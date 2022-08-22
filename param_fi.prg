/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2022  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PARAM_FI ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul innych parametrow firmy                                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Param_FI()

   *############################# PARAMETRY POCZATKOWE #########################
   SELECT 1
   if Dostep( 'FIRMA' )
      SET INDEX TO firma
      GO Val( ident_fir )
   ELSE
      Close_()
      RETURN
   ENDIF

   @  3, 42 CLEAR TO 22, 79
   *################################# GRAFIKA ##################################
   @  3, 42 SAY 'ÍÍ Parametry importu z JPK ÍÍÍÍÍÍÍÍÍÍÍ'
   @  4, 42 SAY ' Zezw¢l na import dokument¢w z dat¥   '
   @  5, 42 SAY ' inn¥ ni¾ aktualny miesi¥c            '
   *################################# OPERACJE #################################
   Param_FI_Say()
   kl := 0
   DO WHILE kl#27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      kl := Inkey( 0 )
      DO CASE
      *############################### MODYFIKACJA ################################
      CASE kl == 109 .OR. kl == 77
         @ 1, 47 SAY "          "
         ColStb()
         center( 23, 'þ                       þ' )
         ColSta()
         center( 23, 'M O D Y F I K A C J A' )
         ColStd()
         BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            zzVATOKRESDR := iif( firma->vatokresdr $ 'TN', firma->vatokresdr, 'N' )
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @  5, 70 GET zzVATOKRESDR PICTURE '!'
            ****************************
            CLEAR TYPE
            Read_()
            IF LastKey() == 27
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            BlokadaR()
            firma->vatokresdr := zzVATOKRESDR
            zVATOKRESDR := zzVATOKRESDR
            Commit_()
            UNLOCK
         END
         Param_FI_Say()
         @ 23, 0
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1]='                                             '
         p[ 2]='     [M].....................modyfikacja     '
         p[ 3]='     [Esc]...................wyj&_s.cie         '
         p[ 4]='                                             '
         *---------------------------------------
         set color to i
            i=20
            j=24
            do while i>0
               if type('p[i]')#[U]
                  center(j,p[i])
                  j=j-1
               endif
            i=i-1
            enddo
         ColStd()
         pause(0)
         if lastkey()#27.and.lastkey()#28
            keyboard chr(lastkey())
         endif
         restore screen from scr_
         _disp=.f.
      ******************** ENDCASE
      endcase
   enddo
   close_()

*################################## FUNKCJE #################################
PROCEDURE Param_FI_Say()

   CLEAR TYPE
   SET COLOR TO w+
   @ 5, 70 say iif( firma->vatokresdr== 'T', 'Tak', 'Nie' )
   ColStd()

   RETURN NIL

*############################################################################
