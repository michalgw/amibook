/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaˆ Gawrycki (gmsystems.pl)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

************************************************************************/

#require "hbwin"
#include "error.ch"

PROCEDURE AmiErrorSys()

   ErrorBlock( {| oError | AmiDefError( oError ) } )

   RETURN

STATIC FUNCTION AmiDefError( oError )

   LOCAL cMessage
   LOCAL cOSError

   LOCAL aOptions
   LOCAL nChoice

   LOCAL n

   LOCAL cMailTresc := '', cStos := ''
   LOCAL zm, zm_, i, j, x, cHtmlScr

   // By default, division by zero results in zero
   IF oError:genCode == EG_ZERODIV .AND. ;
      oError:canSubstitute
      RETURN 0
   ENDIF

   // By default, retry on RDD lock error failure */
   IF oError:genCode == EG_LOCK .AND. ;
      oError:canRetry
      // oError:tries++
      RETURN .T.
   ENDIF

   // Set NetErr() of there was a database open error
   IF oError:genCode == EG_OPEN .AND. ;
      oError:osCode == 32 .AND. ;
      oError:canDefault
      NetErr( .T. )
      RETURN .F.
   ENDIF

   // Set NetErr() if there was a lock error on dbAppend()
   IF oError:genCode == EG_APPENDLOCK .AND. ;
      oError:canDefault
      NetErr( .T. )
      RETURN .F.
   ENDIF

   cMessage := AmiErrorMessage( oError )
   IF ! Empty( oError:osCode )
      cOSError := hb_StrFormat( "(DOS Error %1$d)", oError:osCode )
   ENDIF

   zm=savescreen(0,0,MaxRow(),MaxCol())
   cHtmlScr := scr2html(zm, MaxCol() + 1, 'Ekran programu AMi-BOOK')
   zm_=''
   for j=0 TO MaxRow()
       for i=1 TO MaxCol() * 2 + 1 step 2
           zm_=zm_+substr(zm,j*(MaxCol()+1)*2+i,1)
       next
       zm_=zm_+hb_eol()
   next
   zm_=zm_+repl('@',MaxCol()+1)+hb_eol()

   // Zapis ekranu do pliku html
   IF File('ekran.htm')
      FErase('ekran.htm')
   ENDIF
   x := FCreate('ekran.htm')
   FWrite(x, cHtmlScr)
   FClose(x)

   // Build buttons

   aOptions := {}

   AAdd( aOptions, "Zakoäcz" )

   IF oError:canRetry
      AAdd( aOptions, "Pon¢w" )
   ENDIF

   IF oError:canDefault
      AAdd( aOptions, "Domy˜nie" )
   ENDIF

   AAdd( aOptions, "Zgˆo˜ bˆ¥d" )

   cMailTresc := 'Wersja: ' + wersprog + hb_eol()
   cMailTresc := cMailTresc + cMessage + hb_eol()
   n := 1
   DO WHILE ! Empty( ProcName( ++n ) )

       cStos := cStos + hb_StrFormat( "Called from %1$s(%2$d)  ", ;
              ProcName( n ), ;
              ProcLine( n ) ) + hb_eol()

   ENDDO
   cMailTresc := cMailTresc + cStos
   IF cOSError != NIL
      cMailTresc += "OS Error: " + cOSError + hb_eol()
   ENDIF
   cMailTresc := cMailTresc + repl('-', MaxCol()+1) + hb_eol() + zm_

   // Show alert box

   nChoice := Alert( cMessage + ;
      iif( cOSError == NIL, "", ";" + cOSError ), aOptions )
   DO WHILE nChoice == 0 .OR. aOptions[nChoice] == "Zgˆo˜ bˆ¥d"
      IF nChoice > 0 .AND. aOptions[nChoice] == "Zgˆo˜ bˆ¥d"
         win_MAPISendMail('Raport bledu programu AMi-BOOK', cMailTresc, NIL,;
            DToS( Date() ) + " " + Time(), '', .F., .T., '', {'info@gmsystems.pl'})
      ENDIF
      nChoice := Alert( cMessage + ;
         iif( cOSError == NIL, "", ";" + cOSError ), aOptions )
   ENDDO

   IF ! Empty( nChoice )
      SWITCH aOptions[ nChoice ]
      CASE "Break"
         Break( oError )
      CASE "Pon¢w"
         RETURN .T.
      CASE "Domy˜lnie"
         RETURN .F.
      ENDSWITCH
   ENDIF

   // "Quit" selected

   IF File('blad.txt')
      x=fopen('blad.txt',1)
      fseek(x,0,2)
   else
      x=fcreate('blad.txt',0)
   endif

   FWrite(x, cMailTresc)

   fclose(x)

   OutErr( hb_eol() + cMessage + hb_eol() + cStos )

   hbfr_FreeLibrary()
   amiDllZakoncz()
   WinPrintDone()

   // Usuwamy plik tymczasowy wydruku
   IF File( RAPTEMP + '.dbf' )
      DELETE FILE &RAPTEMP..dbf
   ENDIF
   IF File( RAPTEMP + '.cdx' )
      DELETE FILE &RAPTEMP..cdx
   ENDIF

   ErrorLevel( 1 )
   QUIT

   RETURN .F.

FUNCTION AmiErrorMessage( oError )

   // start error message
   LOCAL cMessage := iif( oError:severity > ES_WARNING, "Error", "Warning" ) + " "

   // add subsystem name if available
   IF HB_ISSTRING( oError:subsystem )
      cMessage += oError:subsystem()
   ELSE
      cMessage += "???"
   ENDIF

   // add subsystem's error code if available
   IF HB_ISNUMERIC( oError:subCode )
      cMessage += "/" + hb_ntos( oError:subCode )
   ELSE
      cMessage += "/???"
   ENDIF

   // add error description if available
   IF HB_ISSTRING( oError:description )
      cMessage += "  " + oError:description
   ENDIF

   // add either filename or operation
   DO CASE
   CASE ! Empty( oError:filename )
      cMessage += ": " + oError:filename
   CASE ! Empty( oError:operation )
      cMessage += ": " + oError:operation
   ENDCASE

   RETURN cMessage