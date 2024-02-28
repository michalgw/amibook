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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

#include "inkey.ch"

FUNCTION Tresc()

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou, _top_bot
   PRIVATE cScrRodzDow, cScrSekCV7, lScrRodzDow := .F., lScrSekCV7 := .F.

   @ 1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   @  3, 0 SAY '                                                                                '
   @  4, 0 SAY '          K A T A L O G    Z D A R Z E &__N.    G O S P O D A R C Z Y C H           '
   @  5, 0 SAY '                                                                                '
   @  6, 0 SAY '            Nazwa                    Stan         Rodzaj         Opcje      Kol.'
   @  7, 0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄ¿'
   @  8, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @  9, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 10, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 11, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 12, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 13, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 14, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 15, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 16, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 17, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 18, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 19, 0 SAY '³                             ³                ³          ³                 ³  ³'
   @ 20, 0 SAY 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄ´'
   @ 21, 0 SAY '³Procedura:                   Rodzaj dowodu:             Sekcja VAT:           ³'
   @ 22, 0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
   *############################### OTWARCIE BAZ ###############################
   SELECT 1
   DO WHILE .NOT. Dostep( 'TRESC' )
   ENDDO
   SetInd( 'TRESC' )
   SEEK '+' + ident_fir
   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 8
   _col_l := 1
   _row_d := 19
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,287'
   _top := 'firma#ident_fir'
   _bot := "del#'+'.or.firma#ident_fir"
   _stop := "+" + ident_fir
   _sbot := "+" + ident_fir + "þ"
   _proc := "linia14()"
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ""
   _disp := .T.
   _cls := ''
   _top_bot := _top + ".or." + _bot
   *----------------------
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 say '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *############################ INSERT/MODYFIKACJA ############################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         @ 1, 47 SAY '          '
         ins := ( kl # 77 .AND. kl # 109 ) .OR. &_top_bot
         IF ins
            ColStb()
            center( 23, 'þ                     þ' )
            ColSta()
            center( 23, 'W P I S Y W A N I E' )
            ColStd()
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            ColStb()
            center( 23, 'þ                       þ' )
            ColSta()
            center( 23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zTRESC := Space( 30 )
               zSTAN := 0
               zRODZAJ := "O"
               zOPCJE := Space( 32 )
               zKOLUMNA := "  "
               zPROCEDUR := Space( 32 )
               zRODZDOW := Space( 6 )
               zSEK_CV7 := "  "
            ELSE
               zTRESC := TRESC
               zSTAN := STAN
               zRODZAJ := RODZAJ
               zOPCJE := OPCJE
               zKOLUMNA := KOLUMNA
               zPROCEDUR := PROCEDUR
               zRODZDOW := RODZDOW
               zSEK_CV7 := SEK_CV7
            ENDIF
            @ wiersz, 59 SAY "                 "
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz,  2 GET zTRESC PICTURE "@S27 " + Replicate( 'X', 512 ) VALID v14_1()
            @ wiersz, 32 GET zSTAN PICTURE "   99999999.99"
            @ wiersz, 48 GET zRODZAJ PICTURE "!" WHEN w14_2() VALID v14_2()
            @ wiersz, 59 GET zOPCJE PICTURE "@S17 " + Replicate( '!', 32 ) WHEN w14_3() VALID v14_3()
            @ wiersz, 77 GET zKOLUMNA PICTURE "99" WHEN w14_4() VALID v14_4()
            @ 21, 11 GET zPROCEDUR PICTURE "@S16 " + Replicate( "!", 32 ) WHEN w14_Procedur( zRODZAJ )
            @ 21, 44 GET zRODZDOW PICTURE "!!!!!!" WHEN w14_RodzDow( zRODZAJ ) VALID V14_RodzDow( zRODZAJ )
            @ 21, 68 GET zSEK_CV7 PICTURE "!!" WHEN w14_SekCV7( zRODZAJ ) VALID v14_SekCV7( zRODZAJ )
            read_()
            @ 24, 0
            IF LastKey() == 27
               IF lScrRodzDow
                  RestScreen( 5, 40, 11, 79, cScrRodzDow )
               ENDIF
               IF lScrSekCV7
                  DO CASE
                  CASE zRODZAJ == "S"
                     RestScreen( 1, 40, 8, 79, cScrSekCV7 )
                  CASE zRODZAJ == "Z"
                     RestScreen( 0, 16, 16, 55, cScrSekCV7 )
                  ENDCASE
               ENDIF
               @ 24, 0
               EXIT
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
               repl_( 'firma', ident_fir )
            ENDIF
            BlokadaR()
            repl_( 'TRESC', zTRESC )
            repl_( 'STAN', zSTAN )
            repl_( 'RODZAJ', zRODZAJ )
            repl_( 'OPCJE', zOPCJE )
            repl_( 'KOLUMNA', zKOLUMNA )
            repl_( 'PROCEDUR', zPROCEDUR )
            repl_( 'RODZDOW', zRODZDOW )
            repl_( 'SEK_CV7', zSEK_CV7 )
            commit_()
            UNLOCK
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '                             ³                ³          ³                 ³  '
         ENDDO
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() == 27 .AND. _row == -1, 27, kl )
         @ 23, 0
      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR()
            del()
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         @ 23, 0
      *################################# SZUKANIE #################################
      CASE kl == -9 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         f10 := Space( 30 )
         @ _row, 16 GET f10
         read_()
         _disp := .NOT. Empty( f10 ) .AND. LastKey() # 27
         IF _disp
            SEEK '+' + ident_fir + f10
            IF &_bot
               SKIP -1
            ENDIF
            _row := Int( ( _row_g + _row_d ) / 2 )
         ENDIF
         @ 23, 0
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[  3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[  4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  5 ] := '   [Ins]...................wpisywanie                   '
         p[  6 ] := '   [M].....................modyfikacja pozycji          '
         p[  7 ] := '   [ALT-S].................eksport do Saldeo            '
         p[  8 ] := '   [Del]...................kasowanie pozycji            '
         p[  9 ] := '   [F10]...................szukanie                     '
         p[ 10 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 11 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         Pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.

      CASE kl == K_ALT_S
         IF SalSprawdz()
            IF TNEsc( , "Czy wysˆa† kartotek© tre˜ci do SaldeoSMART? (Tak/Nie)" )
               SalTresciWyslij()
            ENDIF
         ENDIF

      ******************** ENDCASE
      ENDCASE
   ENDDO
   Close_()

   RETURN

*################################## FUNKCJE #################################
FUNCTION linia14()

   LOCAL cRodzaj, cOpcje

   cRodzaj := rodzaj2str(RODZAJ)
   cOpcje := "                 "
   DO CASE
   CASE RODZAJ == "Z"
      IF AllTrim( OPCJE ) $ "27P"
         cOpcje := "Paliwo (" + iif( AllTrim( OPCJE ) == "P", "5", AllTrim( OPCJE ) ) + "0%)     "
      ENDIF
   CASE RODZAj == "S"
      cOpcje := Left( OPCJE, 17 )
   ENDCASE

   @ 21, 11 SAY Left( PROCEDUR, 16 )
   @ 21, 44 SAY RODZDOW
   @ 21, 68 SAY SEK_CV7

   RETURN ' ' + Left( TRESC, 27 ) + ' ³ ' + kwota( STAN, 14, 2 ) + ' ³' + cRodzaj + '³' + cOpcje + '³' + KOLUMNA

***************************************************
FUNCTION v14_1()

   IF Empty( zTRESC )
      RETURN .F.
   ENDIF
   nr_rec := RecNo()
   seek '+' + ident_fir + zTRESC
   fou := Found()
   rec := RecNo()
   GO nr_rec
   IF fou .AND. ( ins .OR. rec # nr_rec )
      SET CURSOR OFF
      kom( 3, '*u', ' Takie zdarzenie ju&_z. istnieje ' )
      SET CURSOR ON
      RETURN .F.
   ENDIF

   RETURN .T.

*############################################################################
FUNCTION v14_2()

   LOCAL lRes := zRODZAJ $ "OSZ"

   IF lRes
      IF ! zRODZAJ $ "ZS"
         zOPCJE := Space( 32 )
      ENDIF
      ColStd()
      @ wiersz, 48 SAY rodzaj2str( zRODZAJ )
      @ 24, 0
      IF ! ins .AND. zRODZAJ # RODZAJ
         zOPCJE := Space( 32 )
         zRODZDOW := Space( 6 )
         zPROCEDUR := Space( 32 )
         zKOLUMNA := "  "
         zSEK_CV7 := "  "
      ENDIF
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_2()

   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: S - sprzeda¾ , Z - zakup lub O - oba (zakup / sprzeda¾)', 80, ' ' )
   ColStd()

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION v14_3()

   LOCAL lRes := .T.

   IF zRODZAj == "Z"
      lRes := Empty( zOPCJE ) .OR. AllTrim( zOPCJE ) $ "27P"
      IF lRes
         ColStd()
         @ 24, 0
      ENDIF
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_3()

   LOCAL lRes := .F.

   DO CASE
   CASE zRODZAJ == "Z"
      ColInf()
      @ 24, 0 SAY PadC( 'Wpisz: P - paliwo 50%, 2 - paliwo 20%, 7 - paliwo 70%', 80, ' ' )
      ColStd()
      lRes := .T.
   CASE zRODZAJ == "S"
      lRes := KRejSWhOpcje()
   ENDCASE

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION wv14_4_kol( cRodzaj )

   LOCAL aRes

   DO CASE
   CASE cRodzaj == "S"
      IF zRYCZALT == 'T'
         aRes := { "5", "6", "7", "8", "9", "10", "11", "12", "13" }
      ELSE
         aRes := { "7", "8" }
      ENDIF
   CASE cRodzaj == "Z"
      IF zRYCZALT == 'T'
         aRes := {}
      ELSE
         aRes := { "10", "11", "12", "13", "16" }
      ENDIF
   OTHERWISE
      IF zRYCZALT == 'T'
         aRes := { "5", "6", "7", "8", "9", "10", "11", "12", "13" }
      ELSE
         aRes := { "7", "8", "10", "11", "12", "13", "16" }
      ENDIF
   ENDCASE

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION v14_4()

   LOCAL lRes := Empty( zKOLUMNA ) .OR. AScan( wv14_4_kol( zRODZAJ ), AllTrim( zKOLUMNA ) ) > 0

   IF lRes
      ColStd()
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_4()

   LOCAL aKol
   LOCAL lRes := .NOT. ( zRODZAJ == "Z" .AND. zRYCZALT == 'T' )
   LOCAL cKol := ""

   IF lRes
      aKol := wv14_4_kol( zRODZAJ )
      AEval( aKol, { | cItem | cKol := cKol + iif( cKol <> "", ', ', '' ) + cItem } )

      ColInf()
      @ 24, 0 say PadC( 'Wpisz: ' + cKol, 80, ' ' )
      ColStd()
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_Procedur( cRodzaj )

   LOCAL lRes := cRodzaj == 'S'

   IF lRes
      lRes := KRejSWhProcedur()
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_RodzDow( cRodzaj )

   LOCAL lRes := .F.

   DO CASE
   CASE cRodzaj == "S"
      cScrRodzDow := SaveScreen( 5, 40, 11, 79 )
      lScrRodzDow := .T.
      ColInf()
      @  5, 40 CLEAR TO 11, 79
      @  5, 40 TO 11, 79
      @  6, 41 SAY PadC( 'Podaj rodzaj dowodu sprzeda¾y:', 30 )
      @  7, 41 SAY '    - spacje - ¾adne z poni¾szych     '
      @  8, 41 SAY 'RO  - Dokument zbiorczy z kas rejestr.'
      @  9, 41 SAY 'WEW - Dokument wewn©trzny             '
      @ 10, 41 SAY 'FP  - Faktura,zg.z art.109 ust.3d ust.'
      ColStd()
      lRes := .T.
   CASE cRodzaj == "Z"
      cScrRodzDow := SaveScreen( 5, 40, 11, 79 )
      lScrRodzDow := .T.
      ColInf()
      @  5, 40 CLEAR TO 11, 79
      @  5, 40 TO 11, 79
      @  6, 41 SAY PadC( 'Podaj rodzaj dowodu sprzeda¾y:', 30 )
      @  7, 41 SAY '    - spacje - ¾adne z poni¾szych     '
      @  8, 41 SAY 'MK  - Metoda kasowa rozliczeä art. 21 '
      @  9, 41 SAY 'VAT_RR - Faktura VAT RR, art. 116     '
      @ 10, 41 SAY 'WEW - Dokument wewn©trzny             '
      ColStd()
      lRes := .T.
   ENDCASE

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION v14_RodzDow( cRodzaj )

   LOCAL lRes := .F.

   DO CASE
   CASE cRodzaj == "S"
      lRes := AScan( { "RO", "WEW", "FP", "" }, AllTrim( zRODZDOW ) ) > 0
   CASE cRodzaj == "Z"
      lRes := AScan( { "MK", "VAT_RR", "WEW", "" }, AllTrim( zRODZDOW ) ) > 0
   ENDCASE

   IF lRes
      RestScreen( 5, 40, 11, 79, cScrRodzDow )
      lScrRodzDow := .F.
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_SekCV7( cRodzaj )

   LOCAL lRes := .F.

   DO CASE
   CASE cRodzaj == "S"
      cScrSekCV7 := SaveScreen( 1, 40, 8, 79 )
      lScrSekCV7 := .T.
      ColInf()
      @ 1, 40 CLEAR TO 8, 79
      @ 1, 40 TO 8, 79
      @ 2, 41 SAY PadC( 'Podaj sekcje deklaracji VAT-7:', 30 )
      @ 3, 41 SAY '   - dwie spacje - zadne z ponizszych '
      @ 4, 41 SAY 'PN - podatnikiem nabywca (towar)      '
      @ 5, 41 SAY 'PU - podatnikiem nabywca (usˆuga)     '
      @ 6, 41 SAY 'SP - mechanizm podzielonej pˆatno˜ci  '
      @ 7, 41 SAY 'DP - dodatowe pola (K_36, K_46)       '
      ColStd()
      lRes := .T.
   CASE cRodzaj == "Z"
      cScrSekCV7 := SaveScreen( 0, 16, 16, 55 )
      lScrSekCV7 := .T.
      ColInf()
      @  0, 16 CLEAR TO 16, 55
      @  0, 16 TO 16, 55
      @  1, 17 SAY PadC( 'Podaj sekcje deklaracji VAT-7:', 30 )
      @  2, 17 SAY '   - dwie spacje - zadne z ponizszych '
      @  3, 17 SAY 'WT - wewnatrzwspolnotowe nabycie tow. '
      @  4, 17 SAY 'WZ - WNT tylko podatek naliczony      '
      @  5, 17 SAY 'WS - WNT tylko podatek nale¾ny        '
      @  6, 17 SAY 'IT - import towarow (art.33a ustawy)  '
      @  7, 17 SAY 'IZ - import tow.(tylko pod. naliczony)'
      @  8, 17 SAY 'IS - import tow.(tylko pod. nale¾ny)  '
      @  9, 17 SAY 'IU - import uslug                     '
      @ 10, 17 SAY 'UZ - import usl.(tylko pod. naliczony)'
      @ 11, 17 SAY 'US - import usl.(tylko pod. nale¾ny)  '
      @ 12, 17 SAY 'PN - dostawa tow.(podatnikiem nabywca)'
      @ 13, 17 SAY 'PZ - podat.nab. (tylko pod. naliczony)'
      @ 14, 17 SAY 'PS - podat.nab. (tylko pod. nale¾ny)  '
      @ 15, 17 SAY 'SP - mechanizm podzielonej pˆatno˜ci  '
      ColStd()
      lRes := .T.
   ENDCASE

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION v14_SekCV7( cRodzaj )

   LOCAL lRes := .F.

   DO CASE
   CASE cRodzaj == "S"
      IF ( lRes := AScan( { '  ', 'PN', 'PU', 'DP', 'SP' }, zSEK_CV7 ) > 0 )
         RestScreen( 1, 40, 8, 79, cScrSekCV7 )
         lScrSekCV7 := .F.
      ENDIF
   CASE cRodzaj == "Z"
      IF ( lRes := AScan( { '  ', 'WT', 'IT', 'IU', 'PN', 'WS', 'WZ', 'PZ', 'PS', ;
         'SP', 'IZ', 'IS', 'UZ', 'US' }, zSEK_CV7 ) > 0 )
         RestScreen( 0, 16, 16, 55, cScrSekCV7 )
         lScrSekCV7 := .F.
      ENDIF
   ENDCASE

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION rodzaj2str( cRodzaj )

   LOCAL cRes := "          "

   SWITCH cRodzaj
      CASE "O"
         cRes := "Oba (z/s) "
         EXIT
      CASE "S"
         cRes := "Sprzeda¾  "
         EXIT
      CASE "Z"
         cRes := "Zakup     "
   ENDSWITCH

   RETURN cRes

/*----------------------------------------------------------------------*/

