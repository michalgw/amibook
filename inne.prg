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

PROCEDURE Inne()

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, ;
      _esc,_top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, ;
      _cls, kl, ins, nr_rec, wiersz, f10, rec, fou

   @ 1, 47 SAY "          "
   *############################### OTWARCIE BAZ ###############################
   SELECT 2
   IF Dostep( 'DANE_MC' )
      SET INDEX TO dane_mc
   ELSE
      SELECT 1
      Close_()
      RETURN
   ENDIF
   SELECT 1
   IF Dostep( 'SPOLKA' )
      SetInd( 'SPOLKA' )
      SEEK "+" + ident_fir
   ELSE
      SELECT 1
      Close_()
      RETURN
   ENDIF
   IF del # '+' .OR. firma # ident_fir
      kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ' )
      Close_()
      RETURN
   ENDIF
   SKIP
   spolka := ( del = '+' .AND. firma = ident_fir )
   SKIP -1
   IF .NOT. spolka
      SAVE SCREEN TO scr2
      inne_()
      RESTORE SCREEN FROM scr2
      Close_()
      RETURN
   ELSE
   *################################# GRAFIKA ##################################
      @ 3,42 clear to 22,79
      ColStd()
      @  7, 44 SAY '            Podatnik:             '
      @  8, 44 SAY 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
      @  9, 44 SAY 'º                                º'
      @ 10, 44 SAY 'º                                º'
      @ 11, 44 SAY 'º                                º'
      @ 12, 44 SAY 'º                                º'
      @ 13, 44 SAY 'º                                º'
      @ 14, 44 SAY 'º                                º'
      @ 15, 44 SAY 'º                                º'
      @ 16, 44 SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
   *################################# OPERACJE #################################
   *----- parametry ------
      _row_g := 9
      _col_l := 45
      _row_d := 15
      _col_p := 76
      _invers := 'i'
      _curs_l := 0
      _curs_p := 0
      _esc := '27,28,13'
      _top := 'firma#ident_fir'
      _bot := "del#'+'.or.firma#ident_fir"
      _stop := '+' + ident_fir
      _sbot := '+' + ident_fir + 'þ'
      _proc := 'linia24()'
      _row := Int( ( _row_g + _row_d ) / 2 )
      _proc_spe := ''
      _disp := .T.
      _cls := ''
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
         *################################### INNE ###################################
         CASE kl == 13
            SAVE SCREEN TO scr2
            inne_()
            RESTORE SCREEN FROM scr2
            _disp := .F.
         *################################### POMOC ##################################
         CASE kl == 28
            SAVE SCREEN TO scr_
            @ 1, 47 SAY '          '
            DECLARE p[ 20 ]
            *---------------------------------------
            p[ 1 ] := '                                                        '
            p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
            p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
            p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
            p[ 5 ] := '   [Enter].................akceptacja                   '
            p[ 6 ] := '   [Esc]...................wyj&_s.cie                      '
            p[ 7 ] := '                                                        '
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
   ENDIF

   RETURN

*################################## FUNKCJE #################################

FUNCTION linia24()

   RETURN ' ' + dos_c( naz_imie ) + ' '

*############################################################################
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE inne_()

   PRIVATE _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou

   @ 1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   ColStd()
   @  3, 0 SAY '                                                                                '
   @  4, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
   @  5, 0 SAY '°            º 1.Rodzaj................                                        °'
   @  6, 0 SAY '°Pozarolniczaº   Nr regon..............                      NIP:              °'
   @  7, 0 SAY '° dzia&_l.alno&_s.&_c.º   Miejsce prowadzenia...                                        °'
   @  8, 0 SAY '° gospodarczaº 2.Rodzaj................                                        °'
   @  9, 0 SAY '°            º   Nr regon..............                      NIP:              °'
   @ 10, 0 SAY '°            º   Miejsce prowadzenia...                                        °'
   @ 11, 0 SAY '°            º 3.Rodzaj................                                        °'
   @ 12, 0 SAY '°            º   Nr regon..............                      NIP:              °'
   @ 13, 0 SAY '°            º   Miejsce prowadzenia...                                        °'
   IF sposob = 'L'
      @ 14, 0 SAY '°            º 4.Rodzaj................                                        °'
      @ 15, 0 SAY '°            º   Nr regon..............                      NIP:              °'
      @ 16, 0 SAY '°            º   Miejsce prowadzenia...                                        °'
      @ 17, 0 SAY '°            º 5.Rodzaj................                                        °'
      @ 18, 0 SAY '°            º   Nr regon..............                      NIP:              °'
      @ 19, 0 SAY '°            º   Miejsce prowadzenia...                                        °'
   ELSE
      @ 14, 0 SAY '°            º                                                                 °'
      @ 15, 0 SAY '°            º                                                                 °'
      @ 16, 0 SAY '°            º                                                                 °'
      @ 17, 0 SAY '°            º                                                                 °'
      @ 18, 0 SAY '°            º                                                                 °'
      @ 19, 0 SAY '°            º                                                                 °'
   ENDIF
   IF sposob = 'L'
      @ 20, 0 SAY '°            º                                                                 °'
      @ 21, 0 SAY '°            º                                                                 °'
   ELSE
      @ 17, 0 SAY '°ÄÄÄÄÄÄÄÄÄÄÄÄºÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ°'
      @ 18, 0 SAY '°    Najem   º 1.Przedmiot najmu.......                                        °'
      @ 19, 0 SAY '°     lub    º   Miejsce po&_l.o&_z.enia.....                                        °'
      @ 20, 0 SAY '°  dzier&_z.awa º 2.Przedmiot najmu.......                                        °'
      @ 21, 0 SAY '°            º   Miejsce po&_l.o&_z.enia.....                                        °'
   ENDIF
   @ 22, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
   ColInf()
   center( 3, AllTrim( naz_imie ) + ' - INNE &__X.R&__O.D&__L.A PRZYCHOD&__O.W OD POCZ&__A.TKU ROKU' )
   ColStd()
   *################################# OPERACJE #################################
   *----- parametry ------
   _proc := 'say18'
   *----------------------
   DO &_proc
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      kl := Inkey( 0 )
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl = 109 .OR. kl = 77
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                       þ' )
         ColSta()
         center( 23, 'M O D Y F I K A C J A' )
         ColStd()
         BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            zG_RODZAJ1 := G_RODZAJ1
            zG_REGON1 := G_REGON1
            zG_NIP1 := G_NIP1
            zG_MIEJSC1 := G_MIEJSC1
            zG_RODZAJ2 := G_RODZAJ2
            zG_REGON2 := G_REGON2
            zG_NIP2 := G_NIP2
            zG_MIEJSC2 := G_MIEJSC2
            zG_RODZAJ3 := G_RODZAJ3
            zG_REGON3 := G_REGON3
            zG_NIP3 := G_NIP3
            zG_MIEJSC3 := G_MIEJSC3
            zG_RODZAJ4 := G_RODZAJ4
            zG_REGON4 := G_REGON4
            zG_NIP4 := G_NIP4
            zG_MIEJSC4 := G_MIEJSC4
            zG_RODZAJ5 := G_RODZAJ5
            zG_REGON5 := G_REGON5
            zG_NIP5 := G_NIP5
            zG_MIEJSC5 := G_MIEJSC5
            zN_PRZEDM1 := N_PRZEDM1
            zN_MIEJSC1 := N_MIEJSC1
            zN_PRZEDM2 := N_PRZEDM2
            zN_MIEJSC2 := N_MIEJSC2
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @  5, 39 GET zG_RODZAJ1 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            @  6, 39 GET zG_REGON1  PICTURE "@S20 !-999999999-99999999-99-9-999-99999" VALID v18_1()
            @  6, 65 GET zG_NIP1    PICTURE "!!!!!!!!!!!!!"
            @  7, 39 GET zG_MIEJSC1 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID v18_2()
            @  8, 39 GET zG_RODZAJ2 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            @  9, 39 GET zG_REGON2  PICTURE "@S20 !-999999999-99999999-99-9-999-99999" VALID v18_3()
            @  9, 65 GET zG_NIP2    PICTURE "!!!!!!!!!!!!!"
            @ 10, 39 GET zG_MIEJSC2 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID v18_4()
            @ 11, 39 GET zG_RODZAJ3 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            @ 12, 39 GET zG_REGON3  PICTURE "@S20 !-999999999-99999999-99-9-999-99999" VALID v18_1a()
            @ 12, 65 GET zG_NIP3    PICTURE "!!!!!!!!!!!!!"
            @ 13, 39 GET zG_MIEJSC3 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID v18_2a()
            IF sposob = 'L'
               @ 14, 39 GET zG_RODZAJ4 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
               @ 15, 39 GET zG_REGON4  PICTURE "@S20 !-999999999-99999999-99-9-999-99999" VALID v18_3a()
               @ 15, 65 GET zG_NIP4    PICTURE "!!!!!!!!!!!!!"
               @ 16, 39 GET zG_MIEJSC4 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID v18_4a()
               @ 17, 39 GET zG_RODZAJ5 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
               @ 18, 39 GET zG_REGON5  PICTURE "@S20 !-999999999-99999999-99-9-999-99999" VALID v18_5a()
               @ 18, 65 GET zG_NIP5    PICTURE "!!!!!!!!!!!!!"
               @ 19, 39 GET zG_MIEJSC5 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID v18_6a()
            ENDIF
            IF sposob <> 'L'
               @ 18,39 GET zN_PRZEDM1 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
               @ 19,39 GET zN_MIEJSC1 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID v18_5()
               @ 20,39 GET zN_PRZEDM2 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
               @ 21,39 GET zN_MIEJSC2 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID v18_6()
            ENDIF
            CLEAR TYPE
            read_()
            IF LastKey() = 27
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
           zident := Str( RecNo(), 5 )
           SELECT dane_mc
           SEEK '+' + zident
           DO WHILE del = '+' .AND. ident = zident
              BlokadaR()
              IF Empty( zg_rodzaj1 )
                 repl_( 'g_przych1', 0 )
                 repl_( 'g_koszty1', 0 )
                 repl_( 'g_udzial1', ' 1/1  ' )
              ENDIF
              IF Empty( zg_rodzaj2 )
                 repl_( 'g_przych2', 0 )
                 repl_( 'g_koszty2', 0 )
                 repl_( 'g_udzial2', ' 1/1  ' )
              endif
              IF Empty( zg_rodzaj3 )
                 repl_('g_przych3', 0 )
                 repl_('g_koszty3', 0 )
                 repl_('g_udzial3', ' 1/1  ' )
              ENDIF
              IF Empty( zg_rodzaj4 )
                 repl_('g_przych4', 0 )
                 repl_('g_koszty4', 0 )
                 repl_('g_udzial4', ' 1/1  ' )
              ENDIF
              IF Empty( zg_rodzaj5 )
                 repl_('g_przych5', 0 )
                 repl_('g_koszty5', 0 )
                 repl_('g_udzial5', ' 1/1  ' )
              ENDIF
              IF Empty( zn_przedm1 )
                 repl_('n_przych1', 0 )
                 repl_('n_koszty1', 0 )
                 repl_('n_udzial1', ' 1/1  ' )
              ENDIF
              IF Empty( zn_przedm2 )
                 repl_('n_przych2', 0 )
                 repl_('n_koszty2', 0 )
                 repl_('n_udzial2', ' 1/1  ' )
              ENDIF
              COMMIT
              UNLOCK
              SKIP
           ENDDO
           SELECT spolka
           BlokadaR()
           repl_('G_RODZAJ1', zG_RODZAJ1 )
           repl_('G_REGON1', zG_REGON1 )
           repl_('G_NIP1', zG_NIP1 )
           repl_('G_MIEJSC1', zG_MIEJSC1 )
           repl_('G_RODZAJ2', zG_RODZAJ2 )
           repl_('G_REGON2', zG_REGON2 )
           repl_('G_NIP2', zG_NIP2 )
           repl_('G_MIEJSC2', zG_MIEJSC2 )
           repl_('G_RODZAJ3', zG_RODZAJ3 )
           repl_('G_REGON3', zG_REGON3 )
           repl_('G_NIP3', zG_NIP3 )
           repl_('G_MIEJSC3', zG_MIEJSC3 )
           repl_('G_RODZAJ4', zG_RODZAJ4 )
           repl_('G_REGON4', zG_REGON4 )
           repl_('G_NIP4', zG_NIP4 )
           repl_('G_MIEJSC4', zG_MIEJSC4 )
           repl_('G_RODZAJ5', zG_RODZAJ5 )
           repl_('G_REGON5', zG_REGON5 )
           repl_('G_NIP5', zG_NIP5 )
           repl_('G_MIEJSC5', zG_MIEJSC5 )
           repl_('N_PRZEDM1', zN_PRZEDM1 )
           repl_('N_MIEJSC1', zN_MIEJSC1 )
           repl_('N_PRZEDM2', zN_PRZEDM2 )
           repl_('N_MIEJSC2', zN_MIEJSC2 )
           COMMIT
           UNLOCK
           commit_()
           *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
         END
         DO &_proc
         ColStd()
         @ 23, 0 SAY repl( '°', 80 )
         *################################### POMOC ##################################
      CASE kl = 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   [M].....................modyfikacja                  '
         p[ 3 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 4 ] := '                                                        '
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
      ******************** ENDCASE
      ENDCASE
   ENDDO

   RETURN

*################################## FUNKCJE #################################

PROCEDURE say18()

   CLEAR TYPE
   SET COLOR TO +w
   @  5, 39 SAY G_RODZAJ1
   @  6, 39 SAY SubStr( G_REGON1, 1, 20 )
   @  6, 65 SAY G_NIP1
   @  7, 39 SAY G_MIEJSC1
   @  8, 39 SAY G_RODZAJ2
   @  9, 39 SAY SubStr( G_REGON2, 1, 20 )
   @  9, 65 SAY G_NIP2
   @ 10, 39 SAY G_MIEJSC2
   @ 11, 39 SAY G_RODZAJ3
   @ 12, 39 SAY SubStr( G_REGON3, 1, 20 )
   @ 12, 65 SAY G_NIP3
   @ 13, 39 SAY G_MIEJSC3
   IF sposob = 'L'
      @ 14, 39 SAY G_RODZAJ4
      @ 15, 39 SAY SubStr( G_REGON4, 1, 20 )
      @ 15, 65 SAY G_NIP4
      @ 16, 39 SAY G_MIEJSC4
      @ 17, 39 SAY G_RODZAJ5
      @ 18, 39 SAY SubStr( G_REGON5, 1, 20 )
      @ 18, 65 SAY G_NIP5
      @ 19, 39 SAY G_MIEJSC5
   ENDIF
   IF sposob <> 'L'
      @ 18, 39 SAY N_PRZEDM1
      @ 19, 39 SAY N_MIEJSC1
      @ 20, 39 SAY N_PRZEDM2
      @ 21, 39 SAY N_MIEJSC2
   ENDIF
   ColStd()

   RETURN

****************************************

FUNCTION v18_1()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .T.

****************************************

FUNCTION v18_2()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .NOT. Empty( zg_rodzaj1 ) .AND. .NOT. Empty( zg_miejsc1 ) .OR. Empty( zg_rodzaj1 ) .AND. Empty( zg_miejsc1 )

****************************************

FUNCTION v18_3()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .T.

****************************************

FUNCTION v18_4()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .NOT. Empty( zg_rodzaj2 ) .AND. .NOT. Empty( zg_miejsc2 ) .OR. Empty( zg_rodzaj2 ) .AND. Empty( zg_miejsc2 )

****************************************

FUNCTION v18_1a()

   IF LastKey() = 5
      RETURN .T.
   ENDIF
   RETURN .T.

****************************************

FUNCTION v18_2a()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .NOT. Empty( zg_rodzaj3 ) .AND. .NOT. Empty( zg_miejsc3 ) .OR. Empty( zg_rodzaj3 ) .AND. Empty( zg_miejsc3 )

****************************************

FUNCTION v18_3a()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .T.

****************************************

FUNCTION v18_4a()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .NOT. Empty( zg_rodzaj4 ) .AND. .NOT. Empty( zg_miejsc4 ) .OR. Empty( zg_rodzaj4 ) .AND. Empty( zg_miejsc4 )

****************************************

FUNCTION v18_5a()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .T.

****************************************

FUNCTION v18_6a()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .NOT. Empty( zg_rodzaj5 ) .AND. .NOT. Empty( zg_miejsc5 ) .OR. Empty( zg_rodzaj5 ) .AND. Empty( zg_miejsc5 )

****************************************

FUNCTION v18_5()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .NOT. Empty( zn_przedm1 ) .AND. .NOT. Empty( zn_miejsc1 ) .OR. Empty( zn_przedm1 ) .AND. Empty( zn_miejsc1 )

****************************************

FUNCTION v18_6()

   IF LastKey() = 5
      RETURN .T.
   ENDIF

   RETURN .NOT. Empty( zn_przedm2 ) .AND. .NOT. Empty( zn_miejsc2 ) .OR. Empty( zn_przedm2 ) .AND. Empty( zn_miejsc2 )

*############################################################################
