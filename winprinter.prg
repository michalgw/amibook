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
#include "hbclass.ch"
#include "hbwin.ch"

#define MM_TO_INCH     25.4

#define WINPRN_10CPI   1
#define WINPRN_12CPI   2
#define WINPRN_17CPI   3

#define WINPRN_6CPL    1
#define WINPRN_8CPL    2

/*----------------------------------------------------------------------*/

FUNCTION WinPrinterDrukuj( aProfil, aZawartosc, nLiczbaKopii, cTytul )
   LOCAL oWP := TWinPrinter():New( aProfil )
   LOCAL lRes := .F.

   IF oWP:Inicjuj()
      lRes := oWP:Drukuj( aZawartosc, nLiczbaKopii, cTytul )
   ENDIF
   oWP := NIL
   RETURN lRes

/*----------------------------------------------------------------------*/

CREATE CLASS TWinPrinter
   VAR aProfil     INIT NIL HIDDEN
   VAR oPrinter    INIT NIL HIDDEN
   VAR cDane       INIT ""  HIDDEN
   VAR cBufor      INIT ""  HIDDEN
   VAR nIndeks     INIT 1   HIDDEN
   VAR lNowaStrona INIT .F. HIDDEN
   VAR lUtworzNowa INIT .F. HIDDEN
   VAR nCPI        INIT 2   HIDDEN
   VAR nCPL        INIT 1   HIDDEN

   METHOD New( aProfil )
   METHOD Inicjuj()
   METHOD NastepnyZnak()
   METHOD UstawCzcionke()
   METHOD DrukujBufor()
   METHOD NowaLinia()
   METHOD Drukuj( cDane, nLiczbaKopii, cTytul )
ENDCLASS

METHOD New( aProfil ) CLASS TWinPrinter
   ::aProfil := aProfil
   RETURN Self

METHOD Inicjuj() CLASS TWinPrinter
   ::oPrinter := win_Prn():New( AllTrim( ::aProfil[ 'drukarka' ] ) )
   IF ::oPrinter == NIL
      RETURN .F.
   ENDIF
   IF !::oPrinter:Create()
      RETURN .F.
   ENDIF
   ::oPrinter:FormType := WIN_DMPAPER_A4
   ::oPrinter:Landscape := .F.
   ::oPrinter:LeftMargin := ::aProfil[ 'marginl' ] * ::oPrinter:PixelsPerInchX  / MM_TO_INCH
   ::oPrinter:RightMargin := ::oPrinter:PageWidth - ( ::aProfil[ 'marginp' ] * ::oPrinter:PixelsPerInchX  / MM_TO_INCH )
   ::oPrinter:TopMargin := ::aProfil[ 'marging' ] * ::oPrinter:PixelsPerInchY  / MM_TO_INCH
   ::oPrinter:BottomMargin := ::oPrinter:PageHeight - ( ::aProfil[ 'margind' ] * ::oPrinter:PixelsPerInchY  / MM_TO_INCH )
   ::oPrinter:SetBkMode( WIN_TRANSPARENT )
   RETURN .T.

METHOD NastepnyZnak() CLASS TWinPrinter
   LOCAL nRes := SubStr( ::cDane, ::nIndeks, 1 )
   ::nIndeks := ::nIndeks + 1
   RETURN nRes

METHOD PROCEDURE UstawCzcionke() CLASS TWinPrinter
   LOCAL aWidth := { 0, 0 }
   LOCAL nHeight := 10

   SWITCH ::nCPI
   CASE WINPRN_10CPI
      aWidth := { ::aProfil[ 'cpi10c' ], ::aProfil[ 'cpi10z' ] }
      EXIT
   CASE WINPRN_12CPI
      aWidth := { ::aProfil[ 'cpi12c' ], ::aProfil[ 'cpi12z' ] }
      EXIT
   CASE WINPRN_17CPI
      aWidth := { ::aProfil[ 'cpi17c' ], ::aProfil[ 'cpi17z' ] }
      EXIT
   ENDSWITCH

   SWITCH ::nCPL
   CASE WINPRN_6CPL
      ::oPrinter:LineHeight := Int( ::oPrinter:PixelsPerInchY / ::aProfil[ 'lpi6l' ] )
      nHeight := ::aProfil[ 'lpi6z' ]
      EXIT
   CASE WINPRN_8CPL
      ::oPrinter:LineHeight := Int( ::oPrinter:PixelsPerInchY / ::aProfil[ 'lpi8l' ] )
      nHeight := ::aProfil[ 'lpi8z' ]
      EXIT
   ENDSWITCH

   ::oPrinter:SetFont( AllTrim( ::aProfil[ 'czcionka' ] ), nHeight, aWidth )

   RETURN

METHOD PROCEDURE DrukujBufor() CLASS TWinPrinter
   IF Len( ::cBufor ) > 0
      IF Len( AllTrim( ::cBufor ) ) > 0
         IF ::lUtworzNowa
            ::oPrinter:EndPage( .F. )
            ::oPrinter:StartPage( .T. )
            ::lUtworzNowa := .F.
         ENDIF
         ::lNowaStrona := .F.
         ::oPrinter:TextOut( ::cBufor, .F., .T. )
         ::cBufor := ''
      ELSE
         ::oPrinter:PosX := ::oPrinter:PosX + ::oPrinter:CharWidth * Len( ::cBufor )
      ENDIF
   ENDIF
   RETURN

METHOD PROCEDURE NowaLinia() CLASS TWinPrinter
   ::DrukujBufor()
   ::oPrinter:NewLine()
   IF ::oPrinter:PosY + ::oPrinter:LineHeight() > ::oPrinter:BottomMargin
      IF ! ::lNowaStrona
         ::lUtworzNowa := .T.
         ::lNowaStrona := .T.
      ELSE
         ::oPrinter:PosX := ::oPrinter:LeftMargin
         ::oPrinter:PosY := ::oPrinter:TopMargin
      ENDIF
   ENDIF
   RETURN

METHOD Drukuj( cDane, nLiczbaKopii, cTytul ) CLASS TWinPrinter
   LOCAL cZnak1 := ''
   LOCAL cZnak2 := ''
   LOCAL cZnak3 := ''

   ::cDane := cDane
   IF Len( AllTrim( cDane ) ) = 0
      RETURN .T.
   ENDIF

   IF ::oPrinter == NIL
      IF !::Inicjuj()
         Alert( 'Nie udaˆo si© zainicjowa† drukarki: ' + AllTrim( ::aProfil[ 'drukarka' ] ) )
         RETURN .F.
      ENDIF
   ENDIF

   hb_default( @nLiczbaKopii, 1 )
   IF nLiczbaKopii > 0
      ::oPrinter:Copies := nLiczbaKopii
   ELSE
      ::oPrinter:Copies := 1
   ENDIF

   ::nIndeks := 1
   ::cBufor := ''

   hb_default( @cTytul, 'AMi-BOOK' )
   IF !::oPrinter:StartDoc( cTytul )
      Alert( 'Nie mo¾na rozpocz¥† drukowania. Drukarka: ' + AllTrim( ::aProfil[ 'drukarka' ] ) )
      RETURN .F.
   ENDIF

   ::lNowaStrona := .F.
   ::lUtworzNowa := .F.

   ::UstawCzcionke()

   DO WHILE ::nIndeks <= Len( ::cDane )
      cZnak1 := ::NastepnyZnak()
      SWITCH cZnak1
      CASE Chr( 10 )
         ::NowaLinia()
         EXIT
      CASE Chr( 13 )
         ::oPrinter:PosX := ::oPrinter:LeftMargin
         EXIT
      CASE Chr( 12 )
         // FormFeed
         IF ! ::lNowaStrona
            ::DrukujBufor()
            ::lNowaStrona := .T.
            ::lUtworzNowa := .T.
         ENDIF
         EXIT
      CASE Chr( 18 )
         // 10cp
         EXIT
      CASE Chr( 27 )
         cZnak2 := ::NastepnyZnak()
         SWITCH cZnak2
         CASE Chr( 48 )
            // 8cw
            ::DrukujBufor()
            ::nCPL := WINPRN_8CPL
            ::UstawCzcionke()
            EXIT
         CASE Chr( 50 )
            // 68cw
            ::DrukujBufor()
            ::nCPL := WINPRN_6CPL
            ::UstawCzcionke()
            EXIT
         CASE 'P'
            cZnak3 := ::NastepnyZnak()
            IF cZnak3 == Chr( 15 )
               // 17cp
               ::DrukujBufor()
               ::nCPI := WINPRN_17CPI
               ::UstawCzcionke()
            ELSE
               ::cBufor := ::cBufor + cZnak1 + cZnak2 + cZnak3
            ENDIF
            EXIT
         CASE Chr( 64 )
            // reset
            ::cBufor := ""
            ::nCPI := WINPRN_12CPI
            ::nCPL := WINPRN_6CPL
            ::UstawCzcionke()
            EXIT
         CASE Chr( 77 )
            ::DrukujBufor()
            // 12cp
            ::nCPI := WINPRN_12CPI
            ::UstawCzcionke()
            EXIT
         OTHERWISE
            ::cBufor := ::cBufor + cZnak1 + cZnak2
            EXIT
         ENDSWITCH
         EXIT
      OTHERWISE
         ::cBufor := ::cBufor + cZnak1
      ENDSWITCH
   ENDDO
   ::oPrinter:EndDoc()
   RETURN .T.
