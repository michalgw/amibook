/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Micha Gawrycki (gmsystems.pl)

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

#include "hbclass.ch"
#include "inkey.ch"
#include "tbrowse.ch"
#include "box.ch"
#include "winprint.ch"

/*----------------------------------------------------------------------*/

PROCEDURE drukujNowy(cZawartosc, nLiczbaKopii, aProf)
   IF cZawartosc == NIL
      cZawartosc = buforDruku
   ENDIF
   IF Len(cZawartosc) == 0
      RETURN
   ENDIF
   IF nLiczbaKopii == NIL
      nLiczbaKopii = 1
   ENDIF
   IF aProf == NIL
      IF nWybProfilDrukarkiIdx == 0
         aProf := aDomProfilDrukarki
      ELSE
         aProf := aProfileDrukarek[nWybProfilDrukarkiIdx]
      ENDIF
   ENDIF
   IF trybSerwisowy
      fh = FCreate('bufor.txt')
      FWrite(fh, cZawartosc)
      FClose(fh)
   ENDIF

   DO CASE
   CASE aProf['sterownik'] == 'WIN'
      cZawartosc = StrTran(cZawartosc, Chr(0), '')
      WinPrintPrint(cZawartosc, AllTrim(aProf['drukarka']), 1, 1, AllTrim(aProf['czcionka']),;
         aProf['czcionrozm'], aProf['marginl'], aProf['marginp'], aProf['marging'], aProf['margind'],;
         aProf['lininacal'], aProf['lininastr'], 'Wydruk z programu AMi-BOOK', WP_CP852 )

   CASE aProf['sterownik'] == 'WN2'
      cZawartosc = StrTran(cZawartosc, Chr(0), '')
      WinPrinterDrukuj( aProf, cZawartosc, nLiczbaKopii )

   OTHERWISE
      win_PrintDataRaw(AllTrim(aProf['drukarka']), cZawartosc)

   ENDCASE

   RETURN

/*----------------------------------------------------------------------*/

CREATE CLASS TMenuKonfigDruk
   VAR oTB
   VAR cNazwa, lDomyslny, cDrukarka, cSterownik, cCzcionka, nCzcionRozm, cTmpPodzialStr
   VAR nLiniNaCal, nLiniNaStr, nMarginL, nMarginP, nMarginG, nMarginD, nSzerCal, lPodzialStr
   VAR nCpi10z, nCpi10c, nCpi12z, nCpi12c, nCpi17z, nCpi17c, nLpi6l, nLpi6z, nLpi8l, nLpi8z
   METHOD New()
   METHOD Uruchom()
   METHOD Tlo( cSter, lTylkoDol )
   METHOD Pokaz()
   METHOD EdytujGet()
   METHOD Edytuj( lDodaj )
   METHOD SprawdzDrkRodz()
   METHOD SprawdzSzerCal()
   METHOD SprawdzPodzialStr()
   METHOD Klawisz()
   METHOD PoSkip()
   METHOD Skip(nRecs)
ENDCLASS

FUNCTION menuKonfigDruk2()
   LOCAL oMK
   oMK := TMenuKonfigDruk():New()
   oMK:Uruchom()
   oMK := NIL
   WczytajProfileDrukarek()
   RETURN


METHOD New() CLASS TMenuKonfigDruk
   RETURN Self

METHOD Uruchom() CLASS TMenuKonfigDruk
   LOCAL oCol, lMore := .T., nKey := 0, xScr, nDefRecNo
   SAVE SCREEN TO xScr
   oTB := TBrowseDB(3, 11, 22, 41)
   oTB:colorSpec := CColPro
   oTB:border := B_SINGLE
   oCol := TBColumnNew('', {|| iif(drukarka->domyslny, ' * ', '   ') })
   oCol:width := 3
   oCol:setStyle(TBC_READWRITE, .F.)
   oTB:addColumn(oCol)
   oCol := TBColumnNew('', { || drukarka->nazwa })
   oCol:width := 24
   oTB:addColumn(oCol)
   oTB:SkipBlock := {|nRecs| ::Skip(nRecs) }
   SELECT 1
   DO WHILE !dostep('drukarka')
   ENDDO
   dbSetFilter({|| AllTrim(drukarka->punkt) == AllTrim(cPunktLogowania) }, 'AllTrim(drukarka->punkt) == AllTrim(cPunktLogowania)')
   dbGoTop()
   ColStd()
   ::Tlo( drukarka->sterownik )
   oTB:colPos := 2
   DO WHILE lMore == .T.
      nKey := 0
      DO WHILE nKey == 0 .AND. !oTB:stable
         oTB:stabilize()
         nKey := Inkey()
      ENDDO

      IF oTB:stable
         ::Pokaz()
         ColSta()
         @ 1,47 say '[F1]-pomoc'
         ColPro()
         @ 3, 18 SAY ' PROFILE DRUKAREK '
         nKey := Inkey(0)
      ENDIF

      DO CASE
         CASE nKey == K_DOWN
            oTB:down()
         CASE nKey == K_UP
            oTB:up()
         CASE nKey == K_PGDN
            oTB:pageDown()
         CASE nKey == K_PGUP
            oTB:pageUp()
         CASE nKey == K_CTRL_PGUP
            oTB:goTop()
         CASE nKey == K_CTRL_PGDN
            oTB:goBottom()
         CASE nKey == K_RIGHT
            oTB:Right()
         CASE nKey == K_LEFT
            oTB:Left()
         CASE nKey == K_HOME
            oTB:home()
         CASE nKey == K_END
            oTB:end()
         CASE nKey == K_ESC
            lMore := .F.
         CASE Chr(nKey)$'Mm'
            ::Edytuj()
         CASE nKey == K_INS
            ::Edytuj( .T. )
         CASE nKey == K_DEL
            IF drukarka->domyslny
               komun('Nie moพna usunฅ domylnego profilu drukarki.')
            ELSE
               IF TNEsc( , 'Czy usunฅ wybrany profil ? (T/N)')
                  BlokadaR()
                  drukarka->(dbDelete())
                  drukarka->(dbCommit())
                  oTB:refreshAll()
               ENDIF
            ENDIF
         CASE Chr(nKey)$'Dd'
            nDefRecNo := RecNo()
            dbSetFilter({|| AllTrim(drukarka->punkt) == AllTrim(cPunktLogowania) .AND. drukarka->domyslny == .T. }, 'AllTrim(drukarka->punkt) == AllTrim(cPunktLogowania)  .AND. drukarka->domyslny == .T.')
            dbGoTop()
            DO WHILE !drukarka->(Eof())
               IF drukarka->domyslny
                  BlokadaR()
                  drukarka->domyslny := .F.
                  drukarka->(dbCommit())
               ENDIF
               dbSkip()
            ENDDO
            dbSetFilter({|| AllTrim(drukarka->punkt) == AllTrim(cPunktLogowania) }, 'AllTrim(drukarka->punkt) == AllTrim(cPunktLogowania)')
            dbGoTop()
            DO WHILE !drukarka->(Eof()) .AND. nDefRecNo <> RecNo()
               dbSkip()
            ENDDO
            BlokadaR()
            drukarka->domyslny := .T.
            drukarka->(dbCommit())
            oTB:refreshAll()
         CASE nKey == K_F1
            save screen to scr_
            ColSta()
            @ 1,47 say [          ]
            declare p[20]
            *---------------------------------------
            p[ 1]='                                                 '
            p[ 2]='     [M].................modyfikacja             '
            p[ 3]='     [Ins]...............dodawanie               '
            p[ 4]='     [Del]...............usuwanie                '
            p[ 5]='     [D].................ustaw jako domylny     '
            p[ 6]='     [Esc]...............wyj&_s.cie                 '
            p[ 7]='                                                 '

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
      ENDCASE
      IF oTB:colPos < 2
         oTB:colPos := 2
      ENDIF
   ENDDO

   RESTORE SCREEN FROM xScr
   RETURN

/*----------------------------------------------------------------------*/

METHOD Tlo( cSter, lTylkoDol ) CLASS TMenuKonfigDruk
   hb_default( @lTylkoDol, .F. )
   IF ! lTylkoDol
      ColSta()
      @  2,42 say 'ออออออออออออออออออออออออออออออออออออออ'
      ColStd()
      @  3,42 say ' Drukarka                             '
      @  4,42 say '                                      '
      @  5,42 say 'ออออออออออออออออออออออออออออออออออออออ'
      @  6,42 say ' Drukarka zgodna z  (IBM-IBM PCL-PCL) '
      @  7,42 say '            (EPS-EPS WIN-WIN WN2-WN2) '
   ENDIF
   ColStd()
   DO CASE
   CASE cSter == 'IBM' .OR. cSter == 'PCL' .OR. cSter == 'EPS'
      @  8,42 say 'ออออออออออออออออออออออออออออออออออออออ'
      @  9,42 say ' Szeroko drukarki (10/15)           '
      @ 10,42 say 'ออออออออออออออออออออออออออออออออออออออ'
      @ 11,42 say '                                      '
      @ 12,42 say '                                      '
      @ 13,42 say '                                      '
      @ 14,42 say '                                      '
      @ 15,42 say '                                      '
      @ 16,42 say '                                      '
      @ 17,42 say '                                      '
      @ 18,42 say '                                      '
      @ 19,42 say '                                      '
      @ 20,42 say '                                      '
      @ 21,42 say '                                      '
      @ 22,42 say '                                      '
   CASE cSter == 'WIN' .OR. cSter == 'WN2'
      @  8,42 say 'ออออออออออออออออออออออออออออออออออออออ'
      @  9,42 say ' Margines (mm)                        '
      @ 10,42 say '  Lewy              Prawy             '
      @ 11,42 say ' Gขrny              Dolny             '
      IF cSter == 'WIN'
         @ 12,42 say 'ออออออออออออออออออออออออออออหอออออออออ'
         @ 13,42 say ' Czcionka dla wydruku       บ Rozmiar '
         @ 14,42 say '                            บ         '
         @ 15,42 say 'ออออออออออออออออออหอออออออออสอออออออออ'
         @ 16,42 say ' Lini na cal      บ Lini na strone    '
         @ 17,42 say '                  บ                   '
         @ 18,42 say 'ออออออออออออออออออสอออออออออออออออออออ'
         @ 19,42 say '   Podzia wydruku na osobne strony   '
         @ 20,42 say '                                      '
         @ 21,42 say '                                      '
         @ 22,42 say '                                      '
      ELSE
         @ 12,42 say 'ออออออออออออออออออออออออออออออออออออออ'
         @ 13,42 say ' Czcionka dla wydruku                 '
         @ 14,42 say '                                      '
         @ 15,42 say 'ออออออออออออออออออออออออออออออออออออออ'
         @ 16,42 say 'Ustawienia szerokoci                 '
         @ 17,42 say ' 10 CPI -     znakขw na     cal(i)    '
         @ 18,42 say ' 12 CPI -     znakขw na     cal(i)    '
         @ 19,42 say ' 17 CPI -     znakขw na     cal(i)    '
         @ 20,42 say 'Ustawienia wysokoci                  '
         @ 21,42 say ' 6 LPI -        lini na cal, rozm:    '
         @ 22,42 say ' 8 LPI -        lini na cal, rozm:    '
      ENDIF
   ENDCASE
   RETURN

/*----------------------------------------------------------------------*/

METHOD Pokaz() CLASS TMenuKonfigDruk
   ::Tlo( drukarka->sterownik )
   clear type
   set colo to w+
   @  4, 43 SAY PadR(drukarka->drukarka, 36) PICTURE 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
   @  7, 45 say drukarka->sterownik picture [!!!]
   DO CASE
   CASE drukarka->sterownik == 'IBM' .OR. drukarka->sterownik == 'PCL' .OR. drukarka->sterownik == 'EPS'
      @  9, 72 SAY drukarka->szercal PICTURE '99'
   CASE drukarka->sterownik == 'WIN' .OR. drukarka->sterownik == 'WN2'
      @ 10, 49 SAY drukarka->marginl PICTURE '9999.9'
      @ 10, 68 SAY drukarka->marginp PICTURE '9999.9'
      @ 11, 49 SAY drukarka->marging PICTURE '9999.9'
      @ 11, 68 SAY drukarka->margind PICTURE '9999.9'
      IF drukarka->sterownik == 'WIN'
         @ 14, 43 SAY PadR(drukarka->czcionka, 26) PICTURE 'XXXXXXXXXXXXXXXXXXXXXXXXXX'
         @ 14, 74 SAY drukarka->czcionrozm PICTURE '99'
         @ 17, 48 SAY drukarka->lininacal PICTURE '99'
         @ 17, 67 SAY drukarka->lininastr PICTURE '99'
         @ 20, 59 SAY iif(drukarka->podzialstr, 'Tak', 'Nie')
      ELSE
         @ 14, 43 SAY PadR(drukarka->czcionka, 36) PICTURE 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
         @ 17, 52 SAY drukarka->cpi10z PICTURE '999'
         @ 17, 66 SAY drukarka->cpi10c PICTURE '999'
         @ 18, 52 SAY drukarka->cpi12z PICTURE '999'
         @ 18, 66 SAY drukarka->cpi12c PICTURE '999'
         @ 19, 52 SAY drukarka->cpi17z PICTURE '999'
         @ 19, 66 SAY drukarka->cpi17c PICTURE '999'
         @ 21, 51 SAY drukarka->lpi6l PICTURE '999.99'
         @ 21, 77 SAY drukarka->lpi6z PICTURE '99'
         @ 22, 51 SAY drukarka->lpi8l PICTURE '999.99'
         @ 22, 77 SAY drukarka->lpi8z PICTURE '99'
      ENDIF
   ENDCASE
   RETURN

/*----------------------------------------------------------------------*/

METHOD Edytuj( lDodaj ) CLASS TMenuKonfigDruk
   LOCAL lRes := .F.
   hb_default( @lDodaj, .F. )

   ColSta()
   @ 1,47 say [          ]
   IF lDodaj
      ColStb()
      center(23,[þ                     þ])
      ColSta()
      center(23,   [D O D A W A N I E])
   ELSE
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,[M O D Y F I K A C J A])
   ENDIF

   IF ! lDodaj
      lDodaj := drukarka->( Bof() ) .AND. drukarka->( Eof() )
   ENDIF

   IF lDodaj
      ::cNazwa := Space(24)
      ::cDrukarka := win_PrinterGetDefault()
      ::cSterownik := 'WIN'
      ::cCzcionka := 'Courier New'
      ::nCzcionRozm := 12
      ::nLiniNaStr := 0
      ::nLiniNaCal := 6
      ::nMarginL := 9
      ::nMarginP := 9
      ::nMarginG := 12.7
      ::nMarginD := 12.7
      ::nSzerCal := 10
      ::lPodzialStr := .F.
      ::nCpi10c := 1
      ::nCpi10z := 10
      ::nCpi12c := 1
      ::nCpi12z := 12
      ::nCpi17c := 1
      ::nCpi17z := 17
      ::nLpi6l := 6
      ::nLpi6z := 10
      ::nLpi8l := 8
      ::nLpi8z := 8
   ELSE
      ::cNazwa := drukarka->nazwa
      ::cDrukarka := AllTrim(drukarka->drukarka)
      ::cSterownik := drukarka->sterownik
      ::cCzcionka := AllTrim(drukarka->czcionka)
      ::nCzcionRozm := drukarka->czcionrozm
      ::nLiniNaStr := drukarka->lininastr
      ::nLiniNaCal := drukarka->lininacal
      ::nMarginL := drukarka->marginl
      ::nMarginP := drukarka->marginp
      ::nMarginG := drukarka->marging
      ::nMarginD := drukarka->margind
      ::nSzerCal := drukarka->szercal
      ::lPodzialStr := drukarka->podzialstr
      ::nCpi10c := drukarka->cpi10c
      ::nCpi10z := drukarka->cpi10z
      ::nCpi12c := drukarka->cpi12c
      ::nCpi12z := drukarka->cpi12z
      ::nCpi17c := drukarka->cpi17c
      ::nCpi17z := drukarka->cpi17z
      ::nLpi6l := drukarka->lpi6l
      ::nLpi6z := drukarka->lpi6z
      ::nLpi8l := drukarka->lpi8l
      ::nLpi8z := drukarka->lpi8z
   ENDIF
   ::EdytujGet()
   IF LastKey() != K_ESC
      IF lDodaj
         dbAppend()
      ELSE
         BlokadaR()
      ENDIF
      drukarka->punkt := cPunktLogowania
      drukarka->nazwa := ::cNazwa
      drukarka->drukarka := ::cDrukarka
      drukarka->sterownik := ::cSterownik
      drukarka->czcionka := ::cCzcionka
      drukarka->czcionrozm := ::nCzcionRozm
      drukarka->lininastr := ::nLiniNaStr
      drukarka->lininacal := ::nLiniNaCal
      drukarka->marginl := ::nMarginL
      drukarka->marginp := ::nMarginP
      drukarka->marging := ::nMarginG
      drukarka->margind := ::nMarginD
      drukarka->szercal := ::nSzerCal
      drukarka->podzialstr := ::lPodzialStr
      drukarka->cpi10c := ::nCpi10c
      drukarka->cpi10z := ::nCpi10z
      drukarka->cpi12c := ::nCpi12c
      drukarka->cpi12z := ::nCpi12z
      drukarka->cpi17c := ::nCpi17c
      drukarka->cpi17z := ::nCpi17z
      drukarka->lpi6l := ::nLpi6l
      drukarka->lpi6z := ::nLpi6z
      drukarka->lpi8l := ::nLpi8l
      drukarka->lpi8z := ::nLpi8z
      drukarka->(dbCommit())
      dbRUnlock()
      lRes := .T.
   ENDIF
   ::Pokaz()
   @ 23,0
   oTB:refreshCurrent()
   RETURN lRes

METHOD EdytujGet() CLASS TMenuKonfigDruk
   LOCAL aListaDrukarek := win_printerList()
   IF ::cSterownik == 'WIN'
      ::cTmpPodzialStr := iif(::lPodzialStr, 'T', 'N')
      set color TO w+
      @ 20, 60 SAY iif(::lPodzialStr, 'ak', 'ie')
   ENDIF
   ColStd()
   @  oTB:nRow, oTB:nCol GET ::cNazwa PICTURE '@S24'
   @  4, 43, 14, 78 GET ::cDrukarka LISTBOX aListaDrukarek DROPDOWN SCROLLBAR
   @  7, 45 get ::cSterownik picture "!!!" valid ::SprawdzDrkRodz()
   CLEAR TYPE
   read_()
   ::lPodzialStr := iif(::cTmpPodzialStr == 'T', .T., .F.)
   RETURN

/*----------------------------------------------------------------------*/

METHOD SprawdzDrkRodz() CLASS TMenuKonfigDruk
   LOCAL GetList := {}
   LOCAL aCzcionki, aCzcionkiWin, nIter
   if lastkey()=5
      return .t.
   endif
   IF ::cSterownik#'IBM'.and.::cSterownik#'EPS'.and.::cSterownik#'PCL'.AND.::cSterownik#'WIN'.AND.::cSterownik#'WN2'
      kom(2,[*u],[ Wpisz "IBM", "EPS", "PCL", "WIN" lub "WN2" ])
      return .f.
   endif
   aCzcionkiWin = win_EnumFonts()
   aCzcionki = {}
   FOR nIter := 1 TO Len(aCzcionkiWin)
      IF aCzcionkiWin[nIter, 2] == .T.
         AAdd(aCzcionki, aCzcionkiWin[nIter, 1])
      ENDIF
   NEXT
   ::Tlo( ::cSterownik, .T. )
   DO CASE
   CASE ::cSterownik == 'IBM' .OR. ::cSterownik == 'EPS' .OR. ::cSterownik == 'PCL'
      @  9, 72 GET ::nSzerCal PICTURE '99' WHEN ::cSterownik == 'IBM' .OR. ::cSterownik == 'EPS' VALID ::SprawdzSzerCal()
   CASE ::cSterownik == 'WIN' .OR. ::cSterownik == 'WN2'
      @ 10, 49 GET ::nMarginL PICTURE '9999.9'
      @ 10, 68 GET ::nMarginP PICTURE '9999.9'
      @ 11, 49 GET ::nMarginG PICTURE '9999.9'
      @ 11, 68 GET ::nMarginD PICTURE '9999.9'
      IF ::cSterownik == 'WIN'
         ::cTmpPodzialStr := iif(::lPodzialStr, 'T', 'N')
         @ 14, 43, 17, 68 GET ::cCzcionka LISTBOX aCzcionki DROPDOWN SCROLLBAR
         @ 14, 74 GET ::nCzcionRozm PICTURE '99'
         @ 17, 48 GET ::nLiniNaCal PICTURE '99'
         @ 17, 67 GET ::nLiniNaStr PICTURE '99'
         @ 20, 59 GET ::cTmpPodzialStr PICTURE '!' VALID ::SprawdzPodzialStr()
      ELSE
         @ 14, 43, 17, 78 GET ::cCzcionka LISTBOX aCzcionki DROPDOWN SCROLLBAR
         @ 17, 52 GET ::nCpi10z PICTURE '999'
         @ 17, 66 GET ::nCpi10c PICTURE '999'
         @ 18, 52 GET ::nCpi12z PICTURE '999'
         @ 18, 66 GET ::nCpi12c PICTURE '999'
         @ 19, 52 GET ::nCpi17z PICTURE '999'
         @ 19, 66 GET ::nCpi17c PICTURE '999'
         @ 21, 51 GET ::nLpi6l PICTURE '999.99'
         @ 21, 77 GET ::nLpi6z PICTURE '99'
         @ 22, 51 GET ::nLpi8l PICTURE '999.99'
         @ 22, 77 GET ::nLpi8z PICTURE '99'
      ENDIF
   ENDCASE
   CLEAR TYPE
   READ
   return .t.

METHOD SprawdzSzerCal() CLASS TMenuKonfigDruk
   if lastkey()=5
   return .t.
   endif
      IF ::nSzerCal#10.and.::nSzerCal#15
      kom(2,[*u],[ 10 lub 15 ])
      return .f.
      endif
   return .t.

METHOD SprawdzPodzialStr() CLASS TMenuKonfigDruk
   IF LastKey() == 5
      RETURN .T.
   ENDIF
   IF !::cTmpPodzialStr$'TN'
      ::cTmpPodzialStr := iif(::lPodzialStr, 'T', 'N')
      RETURN .F.
   ENDIF
   set colo to w+
   @ 22, 60 say iif(::cTmpPodzialStr == 'T', 'ak', 'ie')
   ColStd()
   RETURN .T.

METHOD Klawisz() CLASS TMenuKonfigDruk
return

METHOD PoSkip() CLASS TMenuKonfigDruk
return

METHOD Skip(nRecs) CLASS TMenuKonfigDruk
   LOCAL nSkipped := 0

   IF LastRec() != 0
      IF nRecs == 0
         dbSkip( 0 )
      ELSEIF nRecs > 0 .AND. RecNo() != LastRec() + 1
         DO WHILE nSkipped < nRecs
            dbSkip( 1 )
            IF Eof()
               dbSkip( -1 )
               EXIT
            ENDIF
            nSkipped++
         ENDDO
      ELSEIF nRecs < 0
         DO WHILE nSkipped > nRecs
            dbSkip( -1 )
            IF Bof()
               EXIT
            ENDIF
            nSkipped--
         ENDDO
      ENDIF
   ENDIF
   RETURN nSkipped

FUNCTION WczytajProfileDrukarek()
   LOCAL n := 0, aProf, aDrukarkaStr := {}
   aProfileDrukarek := {}
   aDomProfilDrukarki := hb_Hash()
   aDomProfilDrukarkiIdx := 0
   select 1
   IF !dostep('drukarka')
      RETURN
   ENDIF
   dbSetFilter({|| AllTrim(drukarka->punkt) == AllTrim(cPunktLogowania) }, 'AllTrim(drukarka->punkt) == AllTrim(cPunktLogowania)')
   DO WHILE !drukarka->(Eof())
      n++
      aProf := hb_Hash()
      aProf['nazwa'] := drukarka->nazwa
      aProf['drukarka'] := drukarka->drukarka
      aProf['sterownik'] := drukarka->sterownik
      aProf['czcionka'] := drukarka->czcionka
      aProf['czcionrozm'] := drukarka->czcionrozm
      aProf['lininastr'] := drukarka->lininastr
      aProf['lininacal'] := drukarka->lininacal
      aProf['marginl'] := drukarka->marginl
      aProf['marginp'] := drukarka->marginp
      aProf['marging'] := drukarka->marging
      aProf['margind'] := drukarka->margind
      aProf['szercal'] := drukarka->szercal
      aProf['podzialstr'] := drukarka->podzialstr
      aProf['cpi10z'] := drukarka->cpi10z
      aProf['cpi10c'] := drukarka->cpi10c
      aProf['cpi12z'] := drukarka->cpi12z
      aProf['cpi12c'] := drukarka->cpi12c
      aProf['cpi17z'] := drukarka->cpi17z
      aProf['cpi17c'] := drukarka->cpi17c
      aProf['lpi6l'] := drukarka->lpi6l
      aProf['lpi6z'] := drukarka->lpi6z
      aProf['lpi8l'] := drukarka->lpi8l
      aProf['lpi8z'] := drukarka->lpi8z
      IF drukarka->domyslny
         aDomProfilDrukarki := aProf
         nDomProfilDrukarkiIdx := n
      ENDIF
      AAdd(aProfileDrukarek, aProf)
      dbSkip()
   ENDDO
   IF n == 0

      PUBLIC drk_drukar, drk_czcion, drk_czrozm, drk_marg_l, drk_marg_p, drk_marg_g
      PUBLIC drk_marg_d, drk_lincal, drk_linstr, param_dru := 'WIN', param_cal := 10

      aProf := hb_Hash()
      aProf['nazwa'] := 'Domylny'

      IF File('paramdrk.mem')
         RESTORE FROM PARAMDRK ADDITIVE
         aProf['drukarka'] := drk_drukar
         aProf['czcionka'] := drk_czcion
         aProf['czcionrozm'] := drk_czrozm
         aProf['lininastr'] := drk_linstr
         aProf['lininacal'] := drk_lincal
         aProf['marginl'] := drk_marg_l
         aProf['marginp'] := drk_marg_p
         aProf['marging'] := drk_marg_g
         aProf['margind'] := drk_marg_d
      ELSE
         aProf['drukarka'] := win_PrinterGetDefault()
         aProf['czcionka'] := 'Courier New'
         aProf['czcionrozm'] := 12
         aProf['lininastr'] := 0
         aProf['lininacal'] := 6
         aProf['marginl'] := 9
         aProf['marginp'] := 9
         aProf['marging'] := 12.7
         aProf['margind'] := 12.7
      ENDIF

      IF File('param.mem')
         RESTORE FROM PARAM ADDITIVE
      ENDIF
      aProf['sterownik'] := param_dru
      aProf['szercal'] := param_cal
      aProf['podzialstr'] := .T.
      aProf['cpi10z'] := 10
      aProf['cpi10c'] := 1
      aProf['cpi12z'] := 12
      aProf['cpi12c'] := 1
      aProf['cpi17z'] := 17
      aProf['cpi17c'] := 1
      aProf['lpi6l'] := 6
      aProf['lpi6z'] := 10
      aProf['lpi8l'] := 8
      aProf['lpi8z'] := 8

      RELEASE drk_drukar, drk_czcion, drk_czrozm, drk_marg_l, drk_marg_p, drk_marg_g,;
         drk_marg_d, drk_lincal, drk_linstr, param_dru, param_cal

      AAdd(aProfileDrukarek, aProf)
      aDomProfilDrukarki := aProf
      aDomProfilDrukarkiIdx := 1

      dbAppend()
      drukarka->punkt := cPunktLogowania
      drukarka->domyslny := .T.
      drukarka->nazwa := aProf['nazwa']
      drukarka->drukarka := aProf['drukarka']
      drukarka->sterownik := aProf['sterownik']
      drukarka->czcionka := aProf['czcionka']
      drukarka->czcionrozm := aProf['czcionrozm']
      drukarka->lininastr := aProf['lininastr']
      drukarka->lininacal := aProf['lininacal']
      drukarka->marginl := aProf['marginl']
      drukarka->marginp := aProf['marginp']
      drukarka->marging := aProf['marging']
      drukarka->margind := aProf['margind']
      drukarka->szercal := aProf['szercal']
      drukarka->podzialstr := aProf['podzialstr']
      drukarka->cpi10z := aProf['cpi10z']
      drukarka->cpi10c := aProf['cpi10c']
      drukarka->cpi12z := aProf['cpi12z']
      drukarka->cpi12c := aProf['cpi12c']
      drukarka->cpi17z := aProf['cpi17z']
      drukarka->cpi17c := aProf['cpi17c']
      drukarka->lpi6l := aProf['lpi6l']
      drukarka->lpi6z := aProf['lpi6z']
      drukarka->lpi8l := aProf['lpi8l']
      drukarka->lpi8z := aProf['lpi8z']
   ENDIF
   dbCloseArea()
   IF Len(aProfileDrukarek) > 0 .AND. nDomProfilDrukarkiIdx == 0
      nDomProfilDrukarkiIdx := 1
      aDomProfilDrukarki := aProfileDrukarek[1]
   ENDIF
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION WybierzProfilDrukarki(nProfIdx)
   LOCAL aProfile := {}, nRes := 0, n, xScr
   FOR n := 1 TO Len(aProfileDrukarek)
      AAdd(aProfile, iif(n == nDomProfilDrukarkiIdx, '* ' + PadR(aProfileDrukarek[n, 'nazwa'], 25),;
         '  ' + PadR(aProfileDrukarek[n, 'nazwa'], 25)))
   NEXT
   SAVE SCREEN TO xScr
   ColPro()
   @ 3, 24, 22, 56 BOX B_SINGLE + Space(1)
   nRes := AChoice(4, 25, 21, 55, aProfile, , , nProfIdx)
   RESTORE SCREEN FROM xScr
   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION DrukujNowyProfil(cDane)
   LOCAL nProfIdx := nDomProfilDrukarkiIdx
   LOCAL xScr, nKlawisz := 0
   SAVE SCREEN TO xScr
   nWybProfilDrukarkiIdx := nDomProfilDrukarkiIdx
   ColInf()
   @ 23, 0 CLEAR TO 24, 79
   center(24, 'ENTER - drukowanie     P - Wybขr profilu drukarki     W - Ustawienia drukarki')
   DO WHILE nKlawisz != K_ESC .AND. nKlawisz != K_ENTER
      ColInf()
      @ 23, 0 SAY 'Profil: ' + PadR(aProfileDrukarek[nWybProfilDrukarkiIdx, 'nazwa'], 28)
      IF param_dzw == 'T'
         tone(400,1)
         tone(400,1)
         tone(400,1)
      ENDIF
      nKlawisz := Inkey(0)
      DO CASE
      CASE nKlawisz == K_ENTER
         drukujNowy(cDane, 1)
         IF param_dzw == 'T'
            Tone(500, 3)
         ENDIF
      CASE nKlawisz == Asc("P") .OR. nKlawisz == Asc("p")
         nProfIdx := WybierzProfilDrukarki(nWybProfilDrukarkiIdx)
         IF nProfIdx > 0
            nWybProfilDrukarkiIdx := nProfIdx
         ENDIF
      CASE nKlawisz == Asc("W") .OR. nKlawisz == Asc("w")
         WinPrintPrinterSetupDlg(AllTrim(aProfileDrukarek[nWybProfilDrukarkiIdx, 'drukarka']))
      ENDCASE
   ENDDO
   RESTORE SCREEN FROM xScr
   RETURN

/*----------------------------------------------------------------------*/

