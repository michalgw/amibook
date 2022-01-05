/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2021  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

FUNCTION DomyslneParametry()

   LOCAL aPar, aSek

   IF ! HB_ISHASH( aDomyslneParametry )
      aDomyslneParametry := hb_Hash()

      // Rok 2022
      aPar := hb_Hash()

      // Tabela podatku doch.
      aPar[ 'tab_doch' ] := { ;
         { 'podstawa' => 0.0,       'procent' => 17, 'dataod' => 0d20220101 }, ;
         { 'podstawa' => 120000.01, 'procent' => 32, 'dataod' => 0d20220101 } }

      aPar[ 'tab_dochuks' ] := { ;
         { 'podstod' => 5701.0,  'podstdo' => 8549.0,  'procent' => 0.17, 'mnoznik' => 6.68,  'kwota'=> -380.5, 'dataod' => 0d20220101 }, ;
         { 'podstod' => 8549.01, 'podstdo' => 11141.0, 'procent' => 0.17, 'mnoznik' => -7.35, 'kwota'=> 819.08, 'dataod' => 0d20220101 } }

      // Stawki rycz.
      // Wolna zawody
      aPar[ 'staw_ry20' ] := 0.17
      // Inne uslugi
      aPar[ 'staw_ry17' ] := 0.15
      // Uslugi
      aPar[ 'staw_uslu' ] := 0.125
      // Produkcja
      aPar[ 'staw_prod' ] := 0.1
      // Handel
      aPar[ 'staw_hand' ] := 0.085
      // Wynajem pow. 100000
      aPar[ 'staw_rk07' ] := 0.055
      // Prawa maj.
      aPar[ 'staw_ry10' ] := 0.03
      // Art. 6 ust. 1d
      aPar[ 'staw_rk08' ] := 0.02

      aPar[ 'staw_ory20' ] := 'Wolne zawody            '
      aPar[ 'staw_ory17' ] := 'Inne usˆugi             '
      aPar[ 'staw_ouslu' ] := 'Wynajem pow.100000zˆ    '
      aPar[ 'staw_oprod' ] := 'Prawa maj¥tkowe         '
      aPar[ 'staw_ohand' ] := 'Usˆugi                  '
      aPar[ 'staw_ork07' ] := 'Produkcja               '
      aPar[ 'staw_ory10' ] := 'Handel                  '
      aPar[ 'staw_ork08' ] := 'Art. 6 ust. 1d          '

      // Kwota wolna
      aPar[ 'param_kw' ] := 5100
      aPar[ 'param_kwd' ] := d"2022-01-01"
      aPar[ 'param_kw2' ] := 5100

      aPar[ 'tab_vatue' ] := { ;
         { 'kraj' => 'AT', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 13, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'BE', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 12, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'BG', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'CY', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'CZ', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 15, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'DE', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 7, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'DK', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 0, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'EE', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'EL', 'oddnia' => d"2021-01-01", 'stawka_a' => 24, 'stawka_b' => 13, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'ES', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 10, 'stawka_c' => 0, 'stawka_d' => 4 }, ;
         { 'kraj' => 'FI', 'oddnia' => d"2021-01-01", 'stawka_a' => 24, 'stawka_b' => 14, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'FR', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 10, 'stawka_c' => 5.5, 'stawka_d' => 2.1 }, ;
         { 'kraj' => 'HR', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 13, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'HU', 'oddnia' => d"2021-01-01", 'stawka_a' => 27, 'stawka_b' => 18, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'IE', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 13.5, 'stawka_c' => 9, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'IE', 'oddnia' => d"2021-03-01", 'stawka_a' => 23, 'stawka_b' => 13.5, 'stawka_c' => 9, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'IT', 'oddnia' => d"2021-01-01", 'stawka_a' => 22, 'stawka_b' => 10, 'stawka_c' => 5, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'LT', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'LU', 'oddnia' => d"2021-01-01", 'stawka_a' => 17, 'stawka_b' => 8, 'stawka_c' => 0, 'stawka_d' => 3 }, ;
         { 'kraj' => 'LV', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 12, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'MT', 'oddnia' => d"2021-01-01", 'stawka_a' => 18, 'stawka_b' => 7, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'NL', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'PT', 'oddnia' => d"2021-01-01", 'stawka_a' => 23, 'stawka_b' => 13, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'RO', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SE', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 12, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SI', 'oddnia' => d"2021-01-01", 'stawka_a' => 22, 'stawka_b' => 9.5, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SK', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 10, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'UK', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 5, 'stawka_c' => 0, 'stawka_d' => 0 } }

      aDomyslneParametry[ '2022' ] := aPar

      // Rok 2021
      aPar := hb_Hash()

      // Tabela podatku doch.
      aPar[ 'tab_doch' ] := { ;
         { 'podstawa' => 0.0,      'procent' => 17, 'kwotazmn' => 1360.0, 'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20210101, 'datado' => 0d20211231 }, ;
         { 'podstawa' => 8001.0,   'procent' => 17, 'kwotazmn' => 1360.0, 'degres' => .T., 'kwotade1' => 834.88, 'kwotade2' => 5000.0,  'dataod' => 0d20210101, 'datado' => 0d20211231 }, ;
         { 'podstawa' => 13001.0,  'procent' => 17, 'kwotazmn' => 525.12, 'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20210101, 'datado' => 0d20211231 }, ;
         { 'podstawa' => 85529.0,  'procent' => 32, 'kwotazmn' => 525.12, 'degres' => .T., 'kwotade1' => 525.12, 'kwotade2' => 41472.0, 'dataod' => 0d20210101, 'datado' => 0d20211231 }, ;
         { 'podstawa' => 127001.0, 'procent' => 32, 'kwotazmn' => 0.0,    'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20210101, 'datado' => 0d20211231 } }

      // Stawki rycz.
      // Wolna zawody
      aPar[ 'staw_ry20' ] := 0.17
      // Inne uslugi
      aPar[ 'staw_ry17' ] := 0.15
      // Uslugi
      aPar[ 'staw_uslu' ] := 0.125
      // Produkcja
      aPar[ 'staw_prod' ] := 0.1
      // Handel
      aPar[ 'staw_hand' ] := 0.085
      // Wynajem pow. 100000
      aPar[ 'staw_rk07' ] := 0.055
      // Prawa maj.
      aPar[ 'staw_ry10' ] := 0.03
      // Art. 6 ust. 1d
      aPar[ 'staw_rk08' ] := 0.02

      aPar[ 'staw_ory20' ] := 'Wolne zawody            '
      aPar[ 'staw_ory17' ] := 'Inne usˆugi             '
      aPar[ 'staw_ouslu' ] := 'Wynajem pow.100000zˆ    '
      aPar[ 'staw_oprod' ] := 'Prawa maj¥tkowe         '
      aPar[ 'staw_ohand' ] := 'Usˆugi                  '
      aPar[ 'staw_ork07' ] := 'Produkcja               '
      aPar[ 'staw_ory10' ] := 'Handel                  '
      aPar[ 'staw_ork08' ] := 'Art. 6 ust. 1d          '

      // Kwota wolna
      aPar[ 'param_kw' ] := 525.12
      aPar[ 'param_kwd' ] := d"2019-10-01"
      aPar[ 'param_kw2' ] := 525.12

      aPar[ 'tab_vatue' ] := { ;
         { 'kraj' => 'AT', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 13, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'BE', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 12, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'BG', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'CY', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'CZ', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 15, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'DE', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 7, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'DK', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 0, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'EE', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'EL', 'oddnia' => d"2021-01-01", 'stawka_a' => 24, 'stawka_b' => 13, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'ES', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 10, 'stawka_c' => 0, 'stawka_d' => 4 }, ;
         { 'kraj' => 'FI', 'oddnia' => d"2021-01-01", 'stawka_a' => 24, 'stawka_b' => 14, 'stawka_c' => 10, 'stawka_d' => 0 }, ;
         { 'kraj' => 'FR', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 10, 'stawka_c' => 5.5, 'stawka_d' => 2.1 }, ;
         { 'kraj' => 'HR', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 13, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'HU', 'oddnia' => d"2021-01-01", 'stawka_a' => 27, 'stawka_b' => 18, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'IE', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 13.5, 'stawka_c' => 9, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'IE', 'oddnia' => d"2021-03-01", 'stawka_a' => 23, 'stawka_b' => 13.5, 'stawka_c' => 9, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'IT', 'oddnia' => d"2021-01-01", 'stawka_a' => 22, 'stawka_b' => 10, 'stawka_c' => 5, 'stawka_d' => 4.8 }, ;
         { 'kraj' => 'LT', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'LU', 'oddnia' => d"2021-01-01", 'stawka_a' => 17, 'stawka_b' => 8, 'stawka_c' => 0, 'stawka_d' => 3 }, ;
         { 'kraj' => 'LV', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 12, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'MT', 'oddnia' => d"2021-01-01", 'stawka_a' => 18, 'stawka_b' => 7, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'NL', 'oddnia' => d"2021-01-01", 'stawka_a' => 21, 'stawka_b' => 9, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'PT', 'oddnia' => d"2021-01-01", 'stawka_a' => 23, 'stawka_b' => 13, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'RO', 'oddnia' => d"2021-01-01", 'stawka_a' => 19, 'stawka_b' => 9, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SE', 'oddnia' => d"2021-01-01", 'stawka_a' => 25, 'stawka_b' => 12, 'stawka_c' => 6, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SI', 'oddnia' => d"2021-01-01", 'stawka_a' => 22, 'stawka_b' => 9.5, 'stawka_c' => 5, 'stawka_d' => 0 }, ;
         { 'kraj' => 'SK', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 10, 'stawka_c' => 0, 'stawka_d' => 0 }, ;
         { 'kraj' => 'UK', 'oddnia' => d"2021-01-01", 'stawka_a' => 20, 'stawka_b' => 5, 'stawka_c' => 0, 'stawka_d' => 0 } }

      aDomyslneParametry[ '2021' ] := aPar





      // Rok 2020
      aPar := hb_Hash()
      // Tabela podatku doch.
      aPar[ 'tab_doch' ] := { ;
         { 'podstawa' => 0.0,      'procent' => 17, 'kwotazmn' => 1360.0, 'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20200101, 'datado' => 0d20201231 }, ;
         { 'podstawa' => 8001.0,   'procent' => 17, 'kwotazmn' => 1360.0, 'degres' => .T., 'kwotade1' => 834.88, 'kwotade2' => 5000.0,  'dataod' => 0d20200101, 'datado' => 0d20201231 }, ;
         { 'podstawa' => 13001.0,  'procent' => 17, 'kwotazmn' => 525.12, 'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20200101, 'datado' => 0d20201231 }, ;
         { 'podstawa' => 85529.0,  'procent' => 32, 'kwotazmn' => 525.12, 'degres' => .T., 'kwotade1' => 525.12, 'kwotade2' => 41472.0, 'dataod' => 0d20200101, 'datado' => 0d20201231 }, ;
         { 'podstawa' => 127001.0, 'procent' => 32, 'kwotazmn' => 0.0,    'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20200101, 'datado' => 0d20201231 } }

      // Stawki rycz.
      // Handel
      aPar[ 'staw_hand' ] := 0.03
      // Produkcja
      aPar[ 'staw_prod' ] := 0.055
      // Uslugi
      aPar[ 'staw_uslu' ] := 0.085
      // Wolna zawody
      aPar[ 'staw_ry20' ] := 0.20
      // Inne uslugi
      aPar[ 'staw_ry17' ] := 0.17
      // Prawa maj.
      aPar[ 'staw_ry10' ] := 0.1
      // Wynajem pow. 100000
      aPar[ 'staw_rk07' ] := 0.125
      // Art. 6 ust. 1d
      aPar[ 'staw_rk08' ] := 0.02

      aPar[ 'staw_ory20' ] := 'Wolne zawody            '
      aPar[ 'staw_ory17' ] := 'Inne usˆugi             '
      aPar[ 'staw_ouslu' ] := 'Usˆugi                  '
      aPar[ 'staw_oprod' ] := 'Produkcja               '
      aPar[ 'staw_ohand' ] := 'Handel                  '
      aPar[ 'staw_ork07' ] := 'Wynajem pow.100000zˆ    '
      aPar[ 'staw_ory10' ] := 'Prawa maj¥tkowe         '
      aPar[ 'staw_ork08' ] := 'Art. 6 ust. 1d          '


      // Kwota wolna
      aPar[ 'param_kw' ] := 525.12
      aPar[ 'param_kwd' ] := d"2019-10-01"
      aPar[ 'param_kw2' ] := 525.12

      aDomyslneParametry[ '2020' ] := aPar

   ENDIF

   RETURN aDomyslneParametry

/*----------------------------------------------------------------------*/

FUNCTION DomParRok()

   LOCAL cRok := param_rok
   LOCAL aLata := {}, nWybor := 1

   IF ! hb_HHasKey( aDomyslneParametry, cRok )
      aLata := hb_HKeys( aDomyslneParametry )
      nWybor := MenuEx( 20 - Len( aLata ), 45, aLata, 1, .T. )
      cRok := iif( nWybor > 0, aLata[ nWybor ], '' )
   ENDIF

   RETURN cRok

/*----------------------------------------------------------------------*/

PROCEDURE DomParPrzywroc_TabDoch( lOtworz, cRok )

   IF Empty( cRok ) .OR. ! hb_HHasKey( aDomyslneParametry, cRok )
      RETURN NIL
   ENDIF

   IF lOtworz
      DO WHILE ! DostepPro( 'TAB_DOCH', , .F., , 'TAB_DOCH' )
      ENDDO
   ENDIF

   Blokada()
   tab_doch->( dbGoTop() )
   DO WHILE ! tab_doch->( Eof() )
      tab_doch->( dbDelete() )
      tab_doch->( dbGoTop() )
   ENDDO
   AEval( aDomyslneParametry[ cRok ][ 'tab_doch' ], { | aPoz |
      tab_doch->( dbAppend() )
      //tab_doch->del := '+'
      tab_doch->podstawa := aPoz[ 'podstawa' ]
      tab_doch->procent := aPoz[ 'procent' ]
      //tab_doch->procent2 := aPoz[ 'procent' ]
      //tab_doch->kwotazmn := aPoz[ 'kwotazmn' ]
      //tab_doch->degres := aPoz[ 'degres' ]
      //tab_doch->kwotade1 := aPoz[ 'kwotade1' ]
      //tab_doch->kwotade2 := aPoz[ 'kwotade2' ]
      tab_doch->dataod := aPoz[ 'dataod' ]
      // zostawiamy date do pusta
      //tab_doch->datado := aPoz[ 'datado' ]
   } )
   COMMIT
   UNLOCK

   IF lOtworz
      tab_doch->( dbCloseArea() )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE DomParPrzywroc_TabDochUKS( lOtworz, cRok )

   IF Empty( cRok ) .OR. ! hb_HHasKey( aDomyslneParametry, cRok )
      RETURN NIL
   ENDIF

   IF lOtworz
      DO WHILE ! DostepPro( 'TAB_DOCHUKS', , .F., , 'TAB_DOCHUKS' )
      ENDDO
   ENDIF

   Blokada()
   tab_dochuks->( dbGoTop() )
   DO WHILE ! tab_dochuks->( Eof() )
      tab_dochuks->( dbDelete() )
      tab_dochuks->( dbGoTop() )
   ENDDO
   AEval( aDomyslneParametry[ cRok ][ 'tab_dochuks' ], { | aPoz |
      tab_dochuks->( dbAppend() )
      //tab_doch->del := '+'
      tab_dochuks->podstod := aPoz[ 'podstod' ]
      tab_dochuks->podstdo := aPoz[ 'podstdo' ]
      tab_dochuks->procent := aPoz[ 'procent' ]
      tab_dochuks->mnoznik := aPoz[ 'mnoznik' ]
      tab_dochuks->kwota := aPoz[ 'kwota' ]
      //tab_doch->degres := aPoz[ 'degres' ]
      //tab_doch->kwotade1 := aPoz[ 'kwotade1' ]
      //tab_doch->kwotade2 := aPoz[ 'kwotade2' ]
      tab_dochuks->dataod := aPoz[ 'dataod' ]
      // zostawiamy date do pusta
      //tab_doch->datado := aPoz[ 'datado' ]
   } )
   COMMIT
   UNLOCK

   IF lOtworz
      tab_dochuks->( dbCloseArea() )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE DomParPrzywroc_TabRycz( lPrzypiszTmp, cRok )

   IF Empty( cRok ) .OR. ! hb_HHasKey( aDomyslneParametry, cRok )
      RETURN NIL
   ENDIF

   staw_hand := aDomyslneParametry[ cRok ][ 'staw_hand' ]
   staw_prod := aDomyslneParametry[ cRok ][ 'staw_prod' ]
   staw_uslu := aDomyslneParametry[ cRok ][ 'staw_uslu' ]
   staw_ry20 := aDomyslneParametry[ cRok ][ 'staw_ry20' ]
   staw_ry17 := aDomyslneParametry[ cRok ][ 'staw_ry17' ]
   staw_ry10 := aDomyslneParametry[ cRok ][ 'staw_ry10' ]
   staw_rk07 := aDomyslneParametry[ cRok ][ 'staw_rk07' ]
   staw_rk08 := aDomyslneParametry[ cRok ][ 'staw_rk08' ]

   staw_ohand := aDomyslneParametry[ cRok ][ 'staw_ohand' ]
   staw_oprod := aDomyslneParametry[ cRok ][ 'staw_oprod' ]
   staw_ouslu := aDomyslneParametry[ cRok ][ 'staw_ouslu' ]
   staw_ory20 := aDomyslneParametry[ cRok ][ 'staw_ory20' ]
   staw_ory17 := aDomyslneParametry[ cRok ][ 'staw_ory17' ]
   staw_ory10 := aDomyslneParametry[ cRok ][ 'staw_ory10' ]
   staw_ork07 := aDomyslneParametry[ cRok ][ 'staw_ork07' ]
   staw_ork08 := aDomyslneParametry[ cRok ][ 'staw_ork08' ]

   SAVE TO tab_rycz ALL LIKE staw_*

   IF lPrzypiszTmp
      zstaw_hand := staw_hand * 100
      zstaw_prod := staw_prod * 100
      zstaw_uslu := staw_uslu * 100
      zstaw_ry20 := staw_ry20 * 100
      zstaw_ry17 := staw_ry17 * 100
      zstaw_ry10 := staw_ry10 * 100
      zstaw_rk07 := staw_rk07 * 100
      zstaw_rk08 := staw_rk08 * 100

      zstaw_ohand := staw_ohand
      zstaw_oprod := staw_oprod
      zstaw_ouslu := staw_ouslu
      zstaw_ory20 := staw_ory20
      zstaw_ory17 := staw_ory17
      zstaw_ory10 := staw_ory10
      zstaw_ork07 := staw_ork07
      zstaw_ork08 := staw_ork08
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE DomParPrzywroc_Param( lPrzypiszTmp, cRok )

   IF Empty( cRok ) .OR. ! hb_HHasKey( aDomyslneParametry, cRok )
      RETURN NIL
   ENDIF

   param_kw := aDomyslneParametry[ cRok ][ 'param_kw' ]
   param_kwd := aDomyslneParametry[ cRok ][ 'param_kwd' ]
   param_kw2 := aDomyslneParametry[ cRok ][ 'param_kw2' ]

   SAVE TO param ALL LIKE param_*

   IF lPrzypiszTmp
      zparam_kw := param_kw
      zparam_kwd := param_kwd
      zparam_kw2 := param_kw2
   END

   IF TNEsc( , "Czy przypsa† kwot© woln¥ do wszysztkich firm? (T/N)" )
      UstawKwoteWolnaWFirmach()
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE DomParPrzywroc_TabVatUE( lOtworz, cRok )

   IF Empty( cRok ) .OR. ! hb_HHasKey( aDomyslneParametry, cRok )
      RETURN NIL
   ENDIF

   IF lOtworz
      DO WHILE ! DostepPro( 'TAB_VATUE', , .F., , 'TAB_VATUE' )
      ENDDO
   ENDIF

   Blokada()
   tab_vatue->( dbGoTop() )
   DO WHILE ! tab_vatue->( Eof() )
      tab_vatue->( dbDelete() )
      tab_vatue->( dbGoTop() )
   ENDDO
   AEval( aDomyslneParametry[ cRok ][ 'tab_vatue' ], { | aPoz |
      tab_vatue->( dbAppend() )
      tab_vatue->del := '+'
      tab_vatue->kraj := aPoz[ 'kraj' ]
      tab_vatue->oddnia := aPoz[ 'oddnia' ]
      tab_vatue->stawka_a := aPoz[ 'stawka_a' ]
      tab_vatue->stawka_b := aPoz[ 'stawka_b' ]
      tab_vatue->stawka_c := aPoz[ 'stawka_c' ]
      tab_vatue->stawka_d := aPoz[ 'stawka_d' ]
   } )
   COMMIT
   UNLOCK

   IF lOtworz
      tab_vatue->( dbCloseArea() )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/
