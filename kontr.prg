/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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
#include "xhb.ch"

PROCEDURE Kontr()

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou, _top_bot

   @ 1, 47 SAY "          "
   *################################# GRAFIKA ##################################
   @  3, 0 SAY Space( 80 )
   @  4, 0 SAY PadC( 'K A T A L O G    K O N T R A H E N T &__O. W', 80 )
   @  5, 0 SAY Space( 80 )
   @  6, 0 SAY '              Nazwa                             Adres               Nr identyf. '
   @  7, 0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿'
   @  8, 0 SAY '³                                ³                                ³            ³'
   @  9, 0 SAY '³                                ³                                ³            ³'
   @ 10, 0 SAY '³                                ³                                ³            ³'
   @ 11, 0 SAY '³                                ³                                ³            ³'
   @ 12, 0 SAY '³                                ³                                ³            ³'
   @ 13, 0 SAY '³                                ³                                ³            ³'
   @ 14, 0 SAY '³                                ³                                ³            ³'
   @ 15, 0 SAY '³                                ³                                ³            ³'
   @ 16, 0 SAY '³                                ³                                ³            ³'
   @ 17, 0 SAY '³                                ³                                ³            ³'
   @ 18, 0 SAY '³                                ³                                ³            ³'
   @ 19, 0 SAY '³                                ³                                ³            ³'
   @ 20, 0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ'
   @ 21, 0 SAY 'Telefony:                         Exp/Imp:     Kod kraju:          UE:          '
   @ 22, 0 SAY 'Bank:                               Konto:                                      '

   *############################### OTWARCIE BAZ ###############################
   SELECT 1
   IF dostep( 'KONTR' )
      setind( 'KONTR' )
   ELSE
      Close_()
      RETURN
   ENDIF
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
   _esc := '27,-9,247,22,48,77,109,7,46,28,-4,-5,-37'
   _top := 'firma#ident_fir'
   _bot := "del#'+'.or.firma#ident_fir"
   _stop := '+' + ident_fir
   _sbot := '+' + ident_fir + 'þ'
   _proc := 'linia13()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'linia13s'
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------
   kl := 0
   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *############################ INSERT/MODYFIKACJA ############################
      CASE kl == K_INS .OR. kl == hb_keyCode( "0" ) .OR. _row == -1 .OR. kl == hb_keyCode( "M" ) .OR. kl == hb_keyCode( "m" )
         @ 1, 47 SAY '          '
         ins := ( kl # hb_keyCode( "M" ) .AND. kl # hb_keyCode( "m" ) ) .OR. &_top_bot
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
            center(23, 'þ                       þ' )
            ColSta()
            center(23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zNAZWA := Space( 100 )
               zADRES := Space( 100 )
               zNR_IDENT := Space( 30 )
               zEXPORT := 'N'
               zBANK := Space( 28 )
               zKONTO := Space( 32 )
               zTEL := Space( 20 )
               zUE := 'N'
               zKRAJ := 'PL'
            ELSE
               zNAZWA := NAZWA
               zADRES := ADRES
               zNR_IDENT := NR_IDENT
               zEXPORT := EXPORT
               zBANK := BANK
               zKONTO := KONTO
               zTEL := TEL
               zUE := UE
               zKRAJ := KRAJ
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz,  1 GET zNAZWA PICTURE "@S32 " + Repl( '!', 100 ) VALID v13_1()
            @ wiersz, 34 GET zADRES PICTURE "@S32 " + Repl( '!', 100 ) VALID v13_2()
            @ wiersz, 67 GET zNR_IDENT PICTURE "@S12 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            @ 21,  9 GET zTEL    PICTURE Repl( '!', 20 )
            @ 21, 42 GET zEXPORT PICTURE "!" WHEN wfEXIM( 21, 43 ) VALID vfEXIM( 21, 43 )
            @ 21, 57 GET zKRAJ   PICTURE "!!"
            @ 21, 70 GET zUE     PICTURE "!" WHEN wfUE( 21, 71 ) VALID vfUE( 21, 71 )
            @ 22,  5 GET zBANK   PICTURE Repl( '!', 28 )
            @ 22, 42 GET zKONTO  PICTURE Repl( '!', 32 )
            SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_RejE
            read_()
            SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_DlgK
            IF LastKey() == K_ESC
               EXIT
            ENDIF
            znazwa := dos_l( znazwa )
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
               repl_( 'firma', ident_fir )
            ENDIF
            BlokadaR()
            repl_( 'NAZWA', zNAZWA )
            repl_( 'ADRES', zADRES )
            repl_( 'NR_IDENT', zNR_IDENT )
            repl_( 'EXPORT', zEXPORT )
            repl_( 'BANK', zBANK )
            repl_( 'KONTO', zKONTO )
            repl_( 'TEL', zTEL )
            repl_( 'UE', zUE )
            repl_( 'KRAJ', zKRAJ )
            UNLOCK
            commit_()
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( (_row_g + _row_d ) / 2 )
            IF ! ins
               exit
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '                                ³                              ³            ³ '
         ENDDO
         _disp := ins .OR. LastKey() # K_ESC
         kl := iif( LastKey() == K_ESC .AND. _row == -1, K_ESC, kl )
         @ 23,0
      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == hb_keyCode( "." )
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
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
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         f10 := Space( 20 )
         ColStd()
         @ _row, 8 GET f10 PICTURE "!!!!!!!!!!!!!!!!!!!!"
         read_()
         _disp := ! Empty( f10 ) .AND. LastKey() # K_ESC
         IF _disp
            SEEK '+' + ident_fir + dos_l( f10 )
            IF &_bot
               SKIP -1
            ENDIF
            _row := int( ( _row_g + _row_d ) / 2 )
         ENDIF
         @ 23,0
      *################################### POMOC ##################################
      CASE kl == K_F1
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
         p[  7 ] := '   [Del]...................kasowanie pozycji            '
         p[  8 ] := '   [F10]...................szukanie                     '
         p[  9 ] := '   [F5]....................eksport kartoteki do pliku   '
         p[ 10 ] := '   [F6]....................import kartoteki z pliku     '
         p[ 11 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 12 ] := '                                                        '
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
         pause( 0 )
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      *################################### EKSPORT ##################################
      CASE kl == K_F5
         IF ! &_top_bot

            SAVE SCREEN TO scr_
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ               þ' )
            ColSta()
            center( 23,   'E K S P O R T' )

            IF ( cPlik := win_GetSaveFileName() ) <> ''

               IF ! File( cPlik )
                  ExpRecNo := RecNo()
                  SEEK _stop

                  ColInf()
                  center( 24,   '...trwa eksport...' )

                  COPY TO (cPlik) WHILE (! &_bot)

                  Komun( "Eksport zostaˆ wykonany." )

                  GO ExpRecNo
               ELSE
                  Komun( "Plik ju¾ istnieje. Wska¾ inn¥ nazw© pliku" )
               ENDIF
            ENDIF
         ENDIF

         RESTORE SCREEN FROM scr_
         _disp := .F.
      *################################### IMPORT  ##################################
      CASE kl == K_F6
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ             þ' )
         ColSta()
         center( 23,   'I M P O R T' )

         IF ( cPlik := win_GetOpenFileName() ) <> ''

            IF File( cPlik )

               ColInf()
               center( 24,   PadC( '...trwa import...', 80 ) )

               TRY
                  DostepPro( cPlik, , , "import" )
                  ImpStructRaw := import->( dbStruct() )
                  ImpStruct := {}
                  AEval( ImpStructRaw, { | aItem | AAdd( ImpStruct, Upper( aItem[ 1 ] ) ) } )
                  DO WHILE ! import->( Eof() )

                     kontr->( dbAppend() )
                     kontr->del := '+'
                     kontr->firma := ident_fir
                     IF AScan( ImpStruct, 'NAZWA' ) > 0
                        kontr->nazwa := import->nazwa
                     ENDIF
                     IF AScan( ImpStruct, 'ADRES' ) > 0
                        kontr->adres := import->adres
                     ENDIF
                     IF AScan( ImpStruct, 'NR_IDENT' ) > 0
                        kontr->nr_ident := import->nr_ident
                     ENDIF
                     IF AScan( ImpStruct, 'EXPORT' ) > 0
                        kontr->export := import->export
                     ENDIF
                     IF AScan( ImpStruct, 'BANK' ) > 0
                        kontr->bank := import->bank
                     ENDIF
                     IF AScan( ImpStruct, 'KONTO' ) > 0
                        kontr->konto := import->konto
                     ENDIF
                     IF AScan( ImpStruct, 'TEL' ) > 0
                        kontr->tel := import->tel
                     ENDIF
                     IF AScan( ImpStruct, 'UE' ) > 0
                        kontr->ue := import->ue
                     ENDIF
                     IF AScan( ImpStruct, 'KRAJ' ) > 0
                        kontr->kraj := import->kraj
                     ENDIF
                     kontr->( dbCommit() )
                     import->( dbSkip() )

                  ENDDO
                  Komun( "Import zostaˆ wykonany." )
               CATCH
                  Komun( "Import zakoäczony niepowodzeniem !!!" )
               END
               SELECT 1
               SEEK _stop
            ELSE
               Komun( "Plik nie istnieje. Wska¾ poprawn¥ nazw© pliku" )
            ENDIF
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .T.

      CASE kl == K_ALT_F8
         VAT_Sprzwdz_NIP_Rej()
      ******************** ENDCASE
      ENDCASE
   ENDDO

   close_()
   SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_DlgK

   RETURN

*################################## FUNKCJE #################################
FUNCTION linia13()

   return SubStr( NAZWA, 1, 32 ) + '³' + SubStr( ADRES, 1, 32 ) + '³' + SubStr( NR_IDENT, 1, 12 )

*############################################################################

PROCEDURE linia13s()

   SET COLOR TO w+
   @ 21,  9 SAY TEL
   @ 21, 42 SAY EXPORT + iif( EXPORT == 'T', 'ak', 'ie' )
   @ 21, 57 SAY KRAJ
   @ 21, 70 SAY UE + iif( UE == 'T', 'ak', 'ie' )
   @ 22,  5 SAY BANK
   @ 22, 42 SAY KONTO
   SET COLOR TO

   RETURN

***************************************************
FUNCTION v13_1()

   IF Empty( zNAZWA )
      RETURN .F.
   ENDIF
   nr_rec := RecNo()
   seek '+' + ident_fir + dos_l( zNAZWA )
   fou := Found()
   rec := RecNo()
   GO nr_rec
   IF fou .AND. ( ins .OR. rec # nr_rec )
   SET CURSOR OFF
      kom( 3, '*u', 'Taki kontrahent ju&_z. istnieje' )
      SET CURSOR ON
      RETURN .F.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION v13_2()

   RETURN .NOT. Empty( zADRES )

***************************************************
FUNCTION wfEXIM( x, y )

   ColInf()
   @ 24, 0 SAY PadC( 'Czy kontrahent jest odbiorc&_a./dostawc&_a. zagranicznym: T-tak   lub   N-nie', 80, ' ' )
   ColStd()
   @  x, y SAY iif( zEXPORT == 'T', 'ak', 'ie' )
   RETURN .T.

***************************************************
FUNCTION vfEXIM( x, y )

   R := .F.
   IF zEXPORT $ 'TN'
      ColStd()
      @  x, y SAY iif( zEXPORT == 'T', 'ak', 'ie' )
      @ 24, 0
      R := .T.
   ENDIF
   RETURN R

***************************************************
FUNCTION wfUE( x, y )

   ColInf()
   @ 24, 0 SAY PadC( 'Czy obroty traktowa&_c. jako obroty z UE: T-tak   lub   N-nie', 80, ' ' )
   ColStd()
   @  x, y SAY iif( zUE == 'T', 'ak', 'ie' )
   RETURN .T.

***************************************************
FUNCTION vfUE( x, y )

   R := .F.
   IF zUE $ 'TN'
      ColStd()
      @  x, y SAY iif( zUE == 'T', 'ak', 'ie' )
      @ 24, 0
      R := .T.
   ENDIF
   RETURN R

***************************************************
*############################################################################
