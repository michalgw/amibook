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

FUNCTION Kat_Rej( cZBIOR )

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou, _top_bot
   PRIVATE ZBIOR := Upper( cZBIOR )
   PRIVATE cScrRodzDow, cScrSekCV7, lScrRodzDow := .F., lScrSekCV7 := .F.

   @  1, 47 SAY "          "
   *################################# GRAFIKA ##################################
   @  3,  0 CLEAR TO 22, 79
   IF Upper( ZBIOR ) = 'KAT_ZAK'
      @  4, 0 SAY PadC( 'K A T A L O G   R E J E S T R &__O. W   Z A K U P &__O. W', 80 )
   ELSE
      @  4, 0 SAY PadC( 'K A T A L O G   R E J E S T R &__O. W   S P R Z E D A &__Z. Y', 80 )
   ENDIF
   @  6, 2 SAY ' Symb. rejes.                     Opis                 ' + iif( ZBIOR == 'KAT_ZAK', '      Opcje      ', ' Oznaczenia GTU  ' ) + 'Kol.'
   @  7, 2 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄ¿'
   @  8, 2 SAY '³            ³                                        ³                 ³  ³'
   @  9, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 10, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 11, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 12, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 13, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 14, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 15, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 16, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 17, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 18, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 19, 2 SAY '³            ³                                        ³                 ³  ³'
   @ 20, 2 SAY 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄ´'
   @ 21, 2 SAY '³Procedura:                   Rodzaj dowodu:           Sekcja VAT:         ³'
   @ 22, 2 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
   *############################### OTWARCIE BAZ ###############################
   SELECT 1
   IF Dostep( ZBIOR )
      SetInd( ZBIOR )
   ELSE
      Close_()
      RETURN
   ENDIF
   SEEK "+" + ident_fir
   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 8
   _col_l := 3
   _row_d := 19
   _col_p := 76
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,287'
   _top := 'firma#ident_fir'
   _bot := "del#'+'.or.firma#ident_fir"
   _stop := "+" + ident_fir
   _sbot := "+" + ident_fir + "þ"
   _proc := "linia133()"
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''
   _top_bot := _top + ".OR." + _bot
   *----------------------
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := Wybor( _row )
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
               zSYMB_REJ := '  '
               zOPIS := Space( 40 )
               zOPCJE := Space( 32 )
               zKOLUMNA := "  "
               zPROCEDUR := Space( 32 )
               zRODZDOW := Space( 6 )
               ZSEK_CV7 := "  "
            ELSE
               zSYMB_REJ := SYMB_REJ
               zOPIS := OPIS
               zOPCJE := OPCJE
               zKOLUMNA := KOLUMNA
               zPROCEDUR := PROCEDUR
               zRODZDOW := RODZDOW
               zSEK_CV7 := SEK_CV7
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz,  8 GET zSYMB_REJ PICTURE "!!" valid v133_1()
            @ wiersz, 16 GET zOPIS PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            @ wiersz, 57 GET zOPCJE PICTURE "@S17 " + Replicate( "!", 32 ) WHEN w133_opcje( ZBIOR ) VALID v133_opcje()
            @ wiersz, 75 GET zKOLUMNA PICTURE "!!" WHEN w133_Kolumna() VALID v133_Kolumna()
            @ 21, 13 GET zPROCEDUR PICTURE "@S16 " + Replicate( "!", 32 ) WHEN w14_Procedur( iif( ZBIOR == "KAT_ZAK", "Z", "S" ) )
            @ 21, 46 GET zRODZDOW PICTURE "!!!!!!" WHEN w14_RodzDow( iif( ZBIOR == "KAT_ZAK", "Z", "S" ) ) VALID V14_RodzDow( iif( ZBIOR == "KAT_ZAK", "Z", "S" ) )
            @ 21, 68 GET zSEK_CV7 PICTURE "!!" WHEN w14_SekCV7( iif( ZBIOR == "KAT_ZAK", "Z", "S" ) ) VALID v14_SekCV7( iif( ZBIOR == "KAT_ZAK", "Z", "S" ) )
            read_()
            IF LASTKEY() == 27
               IF lScrRodzDow
                  RestScreen( 5, 40, 11, 79, cScrRodzDow )
               ENDIF
               IF lScrSekCV7
                  IF ZRODLO == "KAT_ZAK"
                     RestScreen( 0, 16, 16, 55, cScrSekCV7 )
                  ELSE
                     RestScreen( 1, 40, 8, 79, cScrSekCV7 )
                  ENDIF
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
            repl_( 'SYMB_REJ', zSYMB_REJ )
            repl_( 'OPIS', zOPIS )
            repl_( 'OPCJE', zOPCJE )
            repl_( 'KOLUMNA', zKOLUMNA )
            repl_( 'PROCEDUR', zPROCEDUR )
            repl_( 'RODZDOW', zRODZDOW )
            repl_( 'SEK_CV7', zSEK_CV7 )
            COMMIT
            UNLOCK
            commit_()
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '            ³                                        ³                 ³  '
         ENDDO
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() == 27 .AND. _row == -1, 27, kl )
         @ 23,0
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
            COMMIT
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
         f10 := Space( 20 )
         ColStd()
         @ _row, 18 GET f10 PICTURE "!!"
         read_()
         _disp := .NOT. Empty( f10 ) .AND. LastKey() # 27
         IF _disp
            SEEK '+' + ident_fir + dos_l( f10 )
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
         p[  2 ] := '   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
         p[  3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[  4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  5 ] := '   [Ins]...................wpisywanie                   '
         p[  6 ] := '   [M].....................modyfikacja pozycji          '
         p[  7 ] := '   [ALT-S].................wy˜lij do SaldeoSMART        '
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
            keyboard chr(lastkey())
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.

      CASE kl == K_ALT_S
         IF SalSprawdz()
            IF TNEsc( , "Czy wysˆa† rejestry do SaldeoSMART? (Tak/Nie)" )
               SalRejVatWyslij( ZBIOR )
            ENDIF
         ENDIF

      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()

   RETURN

*################################## FUNKCJE #################################
FUNCTION linia133()

   LOCAL cOpcje

   IF Upper( ZBIOR ) = 'KAT_ZAK'
      cOpcje := PadR( iif( AllTrim( OPCJE ) == "P", "Paliwo 100%", iif( AllTrim( OPCJE ) == "2", "Paliwo 20%", iif( AllTrim( OPCJE ) == "7", "Paliwo 70%", " " ) ) ), 17 )
   ELSE
      cOpcje := Left( OPCJE, 17 )
   ENDIF

   @ 21, 13 SAY Left( PROCEDUR, 16 )
   @ 21, 46 SAY RODZDOW
   @ 21, 68 SAY SEK_CV7

   RETURN '     ' + SYMB_REJ + '     ' + '³' + OPIS + '³' + cOpcje + '³' + KOLUMNA

***************************************************
FUNCTION v133_1()
   nr_rec := RecNo()
   SEEK '+' + ident_fir + zSYMB_REJ
   fou := Found()
   rec := RecNo()
   GO nr_rec
   IF fou .AND. ( ins .OR. rec # nr_rec )
      SET CURSOR OFF
      Kom( 3, '*u', 'Taki rejestr ju&_z. istnieje' )
      SET CURSOR ON
      RETURN .F.
   ENDIF

   RETURN .T.

*############################################################################
FUNCTION w133_opcje( zbior )

   IF ZBIOR == "KAT_ZAK"
      ColInf()
      @ 24, 0 SAY PadC( 'Wpisz:  P - paliwo, cz©˜ci...(50% kwoty VAT) lub puste - brak opcji', 80, ' ' )
      ColStd()
      RETURN .T.
   ELSE
      RETURN KRejSWhOpcje()
   ENDIF

   RETURN .F.

/*----------------------------------------------------------------------*/

FUNCTION v133_opcje()

   LOCAL lRes := ZBIOR == "KAT_SPR" .OR. Empty( zOPCJE ) .OR. AllTrim( zOPCJE ) $ '27P'

   IF lRes
      ColStd()
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION v133_Kolumna()

   LOCAL lRes := Empty( zKOLUMNA ) .OR. AScan( wv14_4_kol( iif( ZBIOR == "KAT_ZAK", "Z", "S" ) ), AllTrim( zKOLUMNA ) ) > 0

   IF lRes
      ColStd()
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w133_Kolumna()

   LOCAL aKol
   LOCAL lRes := .NOT. ( ZBIOR == "KAT_ZAK" .AND. zRYCZALT == 'T' )
   LOCAL cKol := ""

   IF lRes
      aKol := wv14_4_kol( iif( ZBIOR == "KAT_ZAK", "Z", "S" ) )
      AEval( aKol, { | cItem | cKol := cKol + iif( cKol <> "", ', ', '' ) + cItem } )

      ColInf()
      @ 24, 0 say PadC( 'Wpisz: ' + cKol, 80, ' ' )
      ColStd()
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

