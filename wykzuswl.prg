/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2022  GM Systems Micha Gawrycki (gmsystems.pl)

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

#include "Inkey.ch"

FUNCTION Wlasciciel_Wybierz( bRobWybor )

   LOCAL nRes := 0

   SELECT 1
   IF Dostep( 'SPOLKA' )
      SetInd( 'SPOLKA' )
      SEEK '+' + ident_fir
   ELSE
      RETURN nRes
   ENDIF
   IF del # '+' .OR. firma # ident_fir
      Kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ' )
      Close_()
      RETURN nRes
   ENDIF

   *--------------------------------------
   SKIP
   spolka := ( del == '+' .AND. firma == ident_fir )
   SKIP -1

   @ 3, 42 CLEAR TO 22, 79

   *################################# GRAFIKA ##################################
   ColStd()
   @  3, 44 SAY '            Podatnik:             '
   @  4, 44 SAY 'ษออออออออออออออออออออออออออออออออป'
   @  5, 44 SAY 'บ                                บ'
   @  6, 44 SAY 'บ                                บ'
   @  7, 44 SAY 'บ                                บ'
   @  8, 44 SAY 'บ                                บ'
   @  9, 44 SAY 'บ                                บ'
   @ 10, 44 SAY 'ศออออออออออออออออออออออออออออออออผ'
   *################################# OPERACJE #################################

   *----- parametry ------
   _row_g := 5
   _col_l := 45
   _row_d := 9
   _col_p := 76
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,28,13,1006'
   _top := 'spolka->firma#ident_fir'
   _bot := "spolka->del#'+'.or.spolka->firma#ident_fir"
   _stop := '+' + ident_fir
   _sbot := '+' + ident_fir + 'þ'
   _proc := 'Wlasciciel_Wybierz_Linia()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''

   *----------------------
   nRes := 0
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := Wybor( _row )
      kl := LastKey()
      DO CASE
      *################################## ZESTAW_ #################################
      CASE kl == 13 .OR. kl == 1006
         IF HB_ISBLOCK( bRobWybor )
            Eval( bRobWybor )
            SELECT spolka
         ELSE
            nRes := spolka->( RecNo() )
            KEYBOARD Chr( K_ESC )
         ENDIF
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY Space( 10 )
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
               center( j, p[i] )
               j := j - 1
            ENDIF
            i := i-1
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
   Close_()

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION Wlasciciel_Wybierz_Linia()

   RETURN ' ' + dos_c( spolka->naz_imie ) + ' '

/*----------------------------------------------------------------------*/



PROCEDURE Wlasciciel_SkladkiZus()

   LOCAL bDrukuj := { || Wlasciciel_SkladkiZus_Druk() }

   Wlasciciel_Wybierz( bDrukuj )

   RETURN

PROCEDURE Wlasciciel_SkladkiZus_Druk()

   LOCAL aDane := { 'pozycje' => {} }
   LOCAL cIdent := Str( spolka->( RecNo() ), 5 )
   LOCAL aRow

   SELECT 3
   IF Dostep('FIRMA')
      GO Val( ident_fir )
   ELSE
      RETURN
   ENDIF

   SELECT 2
   IF Dostep( 'DANE_MC' )
      SET INDEX TO dane_mc
   ELSE
      firma->( dbCloseArea() )
      RETURN
   ENDIF

   dane_mc->( dbSeek( '+' + cIdent ) )

   DO WHILE dane_mc->del == '+' .AND. dane_mc->ident == cIdent
      aRow := { ;
         'mc' => dane_mc->mc, ;
         'podst_zus' => dane_mc->podstawa, ;
         'podst_zdr' => dane_mc->podstzdr, ;
         'emer_st' => dane_mc->staw_wue, ;
         'emer_war' => dane_mc->war_wue, ;
         'emer_pit' => dane_mc->war5_wue, ;
         'emer_mc' => dane_mc->mc_wue, ;
         'rent_st' => dane_mc->staw_wur, ;
         'rent_war' => dane_mc->war_wur, ;
         'rent_pit' => dane_mc->war5_wur, ;
         'rent_mc' => dane_mc->mc_wur, ;
         'chor_st' => dane_mc->staw_wuc, ;
         'chor_war' => dane_mc->war_wuc, ;
         'chor_pit' => dane_mc->war5_wuc, ;
         'chor_mc' => dane_mc->mc_wuc, ;
         'wypa_st' => dane_mc->staw_wuw, ;
         'wypa_war' => dane_mc->war_wuw, ;
         'wypa_pit' => dane_mc->war5_wuw, ;
         'wypa_mc' => dane_mc->mc_wuw, ;
         'zdro_st' => dane_mc->staw_wuz, ;
         'zdro_war' => dane_mc->war_wuz, ;
         'zdro_pit' => dane_mc->war5_wuz, ;
         'zdro_mc' => dane_mc->mc_wuz, ;
         'fnpr_st' => dane_mc->staw_wfp, ;
         'fnpr_war' => dane_mc->war_wfp, ;
         'fngs_st' => dane_mc->staw_wfg, ;
         'fngs_war' => dane_mc->war_wfg, ;
         'dochodzdr' => dane_mc->dochodzdr }
      AAdd( aDane[ 'pozycje' ], aRow )

      dane_mc->( dbSkip() )
   ENDDO

   dane_mc->( dbCloseArea() )

   aDane[ 'firma' ] := AllTrim( firma->nazwa )
   aDane[ 'nazwisko' ] := AllTrim( spolka->naz_imie )
   aDane[ 'rok' ] := param_rok
   aDane[ 'uzytkownik' ] := AllTrim( dos_c( code() ) )

   firma->( dbCloseArea() )

   FRDrukuj( 'frf\wykzuswl.frf', aDane )

   RETURN

/*----------------------------------------------------------------------*/

