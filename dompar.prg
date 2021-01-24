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

      // Rok 2021
      aPar := hb_Hash()

      // Stawki rycz
      aPar[ 'staw_hand' ] := 0.03
      aPar[ 'staw_prod' ] := 0.055
      aPar[ 'staw_uslu' ] := 0.085
      aPar[ 'staw_ry20' ] := 0.17
      aPar[ 'staw_ry17' ] := 0.15
      aPar[ 'staw_ry10' ] := 0.1
      aPar[ 'staw_rk07' ] := 0.125
      aPar[ 'staw_rk08' ] := 0.02

      // Tabela podatku doch.
      aPar[ 'tab_doch' ] := { ;
         { 'podstawa' => 0.0,      'procent' => 17.0, 'kwotazmn' => 1360.0, 'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20210101, 'datado' => 0d20211231 }, ;
         { 'podstawa' => 8001.0,   'procent' => 17.0, 'kwotazmn' => 1360.0, 'degres' => .T., 'kwotade1' => 834.88, 'kwotade2' => 5000.0,  'dataod' => 0d20210101, 'datado' => 0d20211231 }, ;
         { 'podstawa' => 13001.0,  'procent' => 17.0, 'kwotazmn' => 525.12, 'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20210101, 'datado' => 0d20211231 }, ;
         { 'podstawa' => 85529.0,  'procent' => 32.0, 'kwotazmn' => 525.12, 'degres' => .T., 'kwotade1' => 525.12, 'kwotade2' => 41472.0, 'dataod' => 0d20210101, 'datado' => 0d20211231 }, ;
         { 'podstawa' => 127001.0, 'procent' => 32.0, 'kwotazmn' => 0.0,    'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20210101, 'datado' => 0d20211231 } }

      // Stawki rycz.
      // Handel
      aPar[ 'staw_hand' ] := 0.03
      // Produkcja
      aPar[ 'staw_prod' ] := 0.055
      // Uslugi
      aPar[ 'staw_uslu' ] := 0.085
      // Wolna zawody
      aPar[ 'staw_ry20' ] := 0.17
      // Inne uslugi
      aPar[ 'staw_ry17' ] := 0.15
      // Prawa maj.
      aPar[ 'staw_ry10' ] := 0.1
      // Wynajem pow. 100000
      aPar[ 'staw_rk07' ] := 0.125
      // Art. 6 ust. 1d
      aPar[ 'staw_rk08' ] := 0.02

      // Kwota wolna
      aPar[ 'param_kw' ] := 525.12
      aPar[ 'param_kwd' ] := d"2019-10-01"
      aPar[ 'param_kw2' ] := 525.12

      aDomyslneParametry[ '2021' ] := aPar





      // Rok 2020
      aPar := hb_Hash()
      // Stawki rycz
      aPar[ 'staw_hand' ] := 0.03
      aPar[ 'staw_prod' ] := 0.055
      aPar[ 'staw_uslu' ] := 0.085
      aPar[ 'staw_ry20' ] := 0.2
      aPar[ 'staw_ry17' ] := 0.17
      aPar[ 'staw_ry10' ] := 0.1
      aPar[ 'staw_rk07' ] := 0.125
      aPar[ 'staw_rk08' ] := 0.02
      // Tabela podatku doch.
      aPar[ 'tab_doch' ] := { ;
         { 'podstawa' => 0.0,      'procent' => 17.0, 'kwotazmn' => 1360.0, 'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20200101, 'datado' => 0d20201231 }, ;
         { 'podstawa' => 8001.0,   'procent' => 17.0, 'kwotazmn' => 1360.0, 'degres' => .T., 'kwotade1' => 834.88, 'kwotade2' => 5000.0,  'dataod' => 0d20200101, 'datado' => 0d20201231 }, ;
         { 'podstawa' => 13001.0,  'procent' => 17.0, 'kwotazmn' => 525.12, 'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20200101, 'datado' => 0d20201231 }, ;
         { 'podstawa' => 85529.0,  'procent' => 32.0, 'kwotazmn' => 525.12, 'degres' => .T., 'kwotade1' => 525.12, 'kwotade2' => 41472.0, 'dataod' => 0d20200101, 'datado' => 0d20201231 }, ;
         { 'podstawa' => 127001.0, 'procent' => 32.0, 'kwotazmn' => 0.0,    'degres' => .F., 'kwotade1' => 0.0,    'kwotade2' => 0.0,     'dataod' => 0d20200101, 'datado' => 0d20201231 } }

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
      tab_doch->del := '+'
      tab_doch->podstawa := aPoz[ 'podstawa' ]
      tab_doch->procent := aPoz[ 'procent' ]
      tab_doch->kwotazmn := aPoz[ 'kwotazmn' ]
      tab_doch->degres := aPoz[ 'degres' ]
      tab_doch->kwotade1 := aPoz[ 'kwotade1' ]
      tab_doch->kwotade2 := aPoz[ 'kwotade2' ]
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

