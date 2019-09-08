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

PROCEDURE Tab_Doch()

   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot

   @  1, 47 say '          '

   *################################# GRAFIKA ##################################
   @  3, 42 CLEAR TO 22, 79
   @  5, 30 CLEAR TO 20, 79
   @  6, 32 SAY 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
   @  7, 32 SAY 'º Podstawa ³Pd³Odl. od ³Deg³  Kwota  ³  Kwota  º'
   @  8, 32 SAY 'ºopodatkow.³% ³podatku ³   ³ degr.#1 ³ degr.#2 º'
   @  9, 32 SAY 'ºÄÄÄÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄº'
   @ 10, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 11, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 12, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 13, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 14, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 15, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 16, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 17, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 18, 32 SAY 'º          ³  ³        ³   ³         ³         º'
   @ 19, 32 SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'

   *############################### OTWARCIE BAZ ###############################
   DO WHILE.NOT.Dostep( 'TAB_DOCH' )
   ENDDO
   SET INDEX TO tab_doch

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 10
   _col_l := 33
   _row_d := 18
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,22,48,77,109,7,46,28'
   _top := '.F.'
   _bot := "del#'+'"
   _stop := ''
   _sbot := '-'
   _proc := 'linia2()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''
   _top_bot := top + '.or.' + _bot

   *----------------------
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
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
               zPODSTAWA := 0
               zPROCENT := 0
               zKWOTAZMN := 0
               zDEGRES := 'N'
               zKWOTADE1 := 0
               zKWOTADE2 := 0
            ELSE
               zPODSTAWA := PODSTAWA
               zPROCENT := PROCENT
               zKWOTAZMN := KWOTAZMN
               zDEGRES := iif( DEGRES, 'T', 'N' )
               zKWOTADE1 := KWOTADE1
               zKWOTADE2 := KWOTADE2
            ENDIF

            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz, 33 GET zPODSTAWA PICTURE "9999999.99" valid v2_1()
            @ wiersz, 44 GET zPROCENT  PICTURE "99" valid v2_2()
            @ wiersz, 47 GET zKWOTAZMN PICTURE "99999.99"
            @ wiersz, 57 GET zDEGRES   PICTURE "!" valid v2_3()
            @ wiersz, 60 GET zKWOTADE1 PICTURE "999999.99"
            @ wiersz, 70 GET zKWOTADE2 PICTURE "999999.99"
            read_()
            SET CURSOR OFF
            IF LastKey() == 27
               EXIT
            ENDIF

            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
            ENDIF
            BlokadaR()
            repl_( 'PODSTAWA', zPODSTAWA )
            repl_( 'PROCENT', zPROCENT )
            repl_( 'KWOTAZMN', zKWOTAZMN )
            repl_( 'DEGRES', iif( zDEGRES == 'T', .T., .F. ) )
            repl_( 'KWOTADE1', zKWOTADE1 )
            repl_( 'KWOTADE2', zKWOTADE2 )
            commit_()
            UNLOCK

            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '          ³  ³        ³   ³         ³         '
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
         _disp := tnesc( '*i', '   Czy skasowa†? (T/N)   ' )
         if _disp
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

      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         declare p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast©pna pozycja  '
         p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast©pna strona   '
         p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[ 5 ] := '   [Ins]...................wpisywanie                   '
         p[ 6 ] := '   [M].....................modyfikacja pozycji          '
         p[ 7 ] := '   [Del]...................kasowanie pozycji            '
         p[ 8 ] := '   [Esc]...................wyj˜cie                      '
         p[ 9 ] := '                                                        '
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
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.

      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()

   RETURN

*################################## FUNKCJE #################################
FUNCTION linia2()

   RETURN kwota( PODSTAWA, 10, 2 ) + "³" + Str( PROCENT, 2 ) + "³" + kwota( kwotazmn, 8, 2 ) + "³ " +iif( degres, "T", "N" ) +  " ³" + kwota( kwotade1, 9, 2 ) + "³" + kwota( kwotade2, 9, 2 )
   //return [   ]+kwota(PODSTAWA,14,2)+[    ³   ]+str(PROCENT,2)+[    ]

***************************************************
FUNCTION v2_1()

   IF zpodstawa < 0
      RETURN .F.
   ENDIF
   nr_rec := RecNo()
   seek '+' + Str( zPODSTAWA, 11, 2 )
   fou := Found()
   rec := RecNo()
   GO nr_rec
   if fou.and.(ins.or.rec#nr_rec)
      SET CURSOR OFF
      kom( 3, '*u', 'Takie dane ju¾ istniej¥' )
      SET CURSOR ON
      RETURN .F.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION v2_2()

   RETURN zPROCENT > 0

***************************************************
FUNCTION v2_3()
   RETURN zDEGRES$'TN'

/*----------------------------------------------------------------------*/

FUNCTION TabDochPobierz( nKwota, ncWorkspace )

   LOCAL aRes := {}
   LOCAL lZamknij := .F.
   LOCAL nPod

   IF Empty( ncWorkspace )
      ncWorkspace := 'tab_doch_pob'
      lZamknij := .T.
      DO WHILE ! DostepEx( 'tab_doch', 'tab_doch', .T., ncWorkspace )
      ENDDO
   ENDIF

   ( ncWorkspace )->( dbSeek( '-' ) )
   ( ncWorkspace )->( dbSkip( -1 ) )

   DO WHILE ( ncWorkspace )->podstawa >= nKwota .AND. ! ( ncWorkspace )->( Bof() )
      ( ncWorkspace )->( dbSkip( -1 ) )
   ENDDO

   AAdd( aRes, ( ncWorkspace )->podstawa )
   AAdd( aRes, ( ncWorkspace )->procent )
   AAdd( aRes, ( ncWorkspace )->kwotazmn )
   AAdd( aRes, ( ncWorkspace )->degres )
   AAdd( aRes, ( ncWorkspace )->kwotade1 )
   AAdd( aRes, ( ncWorkspace )->kwotade2 )

   IF lZamknij
      ( ncWorkspace )->( dbCloseArea() )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION TabDochPodatek( nKwota, ncWorkspace )

   LOCAL nRes := 0
   LOCAL aTab

   aTab := TabDochPobierz( nKwota, ncWorkspace )

   IF Len( aTab ) > 0
      nRes := nKwota * aTab[ 2 ] / 100
      IF aTab[ 4 ]
         nRes := nRes - Max( 0, ( aTab[ 3 ] - aTab[ 5 ] * ( nKwota - aTab[ 1 ] - 1 ) / aTab[ 6 ] ) )
      ELSE
         nRes := nRes - aTab[ 3 ]
      ENDIF
   ENDIF

   RETURN Max( 0, nRes )

/*----------------------------------------------------------------------*/

FUNCTION TabDochProcent( nPodstawa, ncWorkspace )

   LOCAL aTab := {}
   LOCAL nRes := 0

   aTab := TabDochPobierz( nPodstawa, ncWorkspace )
   IF Len( aTab ) > 0
      nRes := aTab[ 2 ]
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/
