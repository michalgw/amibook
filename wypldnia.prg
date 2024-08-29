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

#include "Inkey.ch"

PROCEDURE WyplDnia()

   LOCAL nMenu, aDane, aWiersz, nZakres, aRekordy := {}, lDodaj

   PRIVATE _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
   PRIVATE _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep

   BEGIN SEQUENCE
      @ 1, 47 SAY Space( 10 )
      *-----parametry wewnetrzne-----
      nr_strony := 0
      _papsz := 1
      _lewa := 1
      _prawa := 80
      _strona := .F.
      _czy_mon := .T.
      _czy_close := .T.
      czesc := 1
      *------------------------------
      _szerokosc := 80
      _koniec := "del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      SELECT 5
      IF Dostep( 'ZALICZKI' )
         SetInd( 'ZALICZKI' )
      ELSE
         BREAK
      ENDIF
      SELECT 4
      IF Dostep( 'WYPLATY' )
         SetInd( 'WYPLATY' )
      ELSE
         BREAK
      ENDIF
      SELECT 3
      IF Dostep( 'ETATY' )
         SetInd( 'ETATY' )
      ELSE
         BREAK
      ENDIF
      SELECT 2
      IF Dostep( 'PRAC' )
         SetInd( 'PRAC' )
      ELSE
         BREAK
      ENDIF
      SEEK '+' + ident_fir
      IF .NOT. Found()
         kom( 3, '*w', 'b r a k   p r a c o w n i k &_o. w' )
         BREAK
      ENDIF

      @ 24,  0
      @ 24, 19 PROMPT "[ Wszyscy pracownicy ]"
      @ 24, 44 PROMPT "[ Wybrani pracownicy ]"

      MENU TO nZakres
      IF LastKey() == K_ESC
         BREAK
      ENDIF

      IF nZakres == 2
         aRekordy := PracWybierz()
         IF Len( aRekordy ) == 0
            BREAK
         ENDIF
      ENDIF

      //tworzenie bazy roboczej
      IF ! File('ROBWYP.dbf')
         dbCreate( "ROBWYP", { ;
            { "NAZWISKO",  "C", 50, 0 }, ;
            { "PESEL",     "C", 11, 0 }, ;
            { "MCWYP",     "C",  2, 0 }, ;
            { "DOWYPLATY", "N",  9, 2 }, ;
            { "WYPLACONO", "N",  9, 2 }, ;
            { "DATAWYPLA", "D",  8, 0 }, ;
            { "ZALICZKA",  "N",  9, 2 }, ;
            { "DATAZALI",  "D",  8, 0 }, ;
            { "DATA",      "D",  8, 0 }, ;
            { "PODATEK",   "N",  9, 2 }, ;
            { "DOPIT4",    "C",  6, 0 } } )
      ENDIF
      SELECT 1
      IF DostepEx( 'ROBWYP' )
         ZAP
      ELSE
         BREAK
      ENDIF

      IF ! File( 'ROBWYPZA.dbf' )
         dbCreate( "ROBWYPZA", { ;
            { "DATA",      "D",  8, 0 }, ;
            { "RODZAJ",    "C",  1, 0 }, ;
            { "KWOTA",     "N",  8, 2 }, ;
            { "IDENT",     "C",  5, 0 }, ;
            { "MC",        "C",  2, 0 } } )
      ENDIF
      SELECT 10
      IF DostepEx( 'ROBWYPZA' )
         ZAP
      ELSE
         BREAK
      ENDIF
      INDEX ON DToS( DATA ) + mc TO ROBWYPZA

      paras_wwd := 'Wyp&_l.aty dokonane w okresie'
      IF .NOT. File( 'param_sp.mem' )
         SAVE TO param_sp ALL LIKE paras_*
      ELSE
         RESTORE FROM param_sp ADDITIVE
      ENDIF
      zparas_wwd := paras_wwd + Space( 40 - Len( paras_wwd ) )
      data_od := CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.01' )
      data_do := CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.' + StrTran( Str( lastdayom( data_od ), 2 ), ' ', '0' ) )
      @ 23,  0 CLEAR TO 23, 79
      @ 23,  0 SAY 'Dzie&_n. od' GET data_od
      @ 23, 20 SAY 'do' GET data_do
      @ 23, 36 SAY 'Nag&_l.&_o.wek' GET zparas_wwd PICTURE repl( 'X', 40 )
      read_()
      IF LastKey() == 27
         BREAK
      ENDIF
      paras_wwd := AllTrim( zparas_wwd )
      SAVE TO param_sp ALL LIKE paras_*
      IF data_od > data_do
         kom( 3, '*u', ' Nieprawid&_l.owy zakres ' )
         BREAK
      ENDIF

      SELECT wyplaty
      SEEK '+' + ident_fir
      IF Found()
         DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma == ident_fir
            IF data_wyp >= data_od .AND. data_wyp <= data_do
               SELECT ROBWYPZA
               APPEND BLANK
               REPLACE data WITH wyplaty->data_wyp, rodzaj WITH 'W', kwota WITH wyplaty->kwota, ;
                  ident WITH wyplaty->ident, mc WITH wyplaty->mc
            ENDIF
            SELECT wyplaty
            SKIP
         ENDDO
      ENDIF
      SELECT zaliczki
      SEEK '+' + ident_fir
      IF Found()
         DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma == ident_fir
            IF data_wyp >= data_od .AND. data_wyp <= data_do
               SELECT ROBWYPZA
               APPEND BLANK
               REPLACE data WITH zaliczki->data_wyp, rodzaj WITH 'z', kwota WITH zaliczki->kwota, ;
                  ident WITH zaliczki->ident, mc WITH zaliczki->mc
            ENDIF
            SELECT zaliczki
            SKIP
         ENDDO
      ENDIF

      SELECT prac
      SET ORDER TO 4

      SELECT robwypza
      GO TOP

      DO WHILE .NOT. Eof()
         SELECT prac
         lDodaj := .T.
         //SEEK Val( robwypza->ident )
         SEEK ident_fir + robwypza->ident
         IF Found()
            znazimie := AllTrim( nazwisko ) + ' ' + AllTrim( imie1 ) + ' ' + AllTrim( imie2 )
            zpesel := pesel
            lDodaj := ( Len( aRekordy ) == 0 .OR. AScan( aRekordy, prac->( RecNo() ) ) > 0 )
         ELSE
            znazimie := 'BRAK PRACOWNIKA W BAZIE DANYCH  '
            zpesel := '? ? ? ? ? ?'
         ENDIF

         IF lDodaj
            SELECT robwyp
            APPEND BLANK
            REPLACE nazwisko WITH znazimie, ;
               pesel WITH zpesel, ;
               mcwyp WITH robwypza->mc
            IF robwypza->rodzaj == 'W'
               REPLACE wyplacono WITH robwypza->kwota, datawypla WITH robwypza->data, data WITH robwypza->data
            ENDIF
            IF robwypza->rodzaj == 'Z'
               REPLACE zaliczka WITH robwypza->kwota, datazali WITH robwypza->data, data WITH robwypza->data
            ENDIF
         ENDIF
         SELECT robwypza
         SKIP
      ENDDO

      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      SELECT ROBWYP
      INDEX ON DToS( data ) + mcwyp + nazwisko + pesel TO robwyp
      GO TOP

      nMenu := GraficznyCzyTekst( "WyplDnia" )
      IF nMenu == 0
         BREAK
      ENDIF

      IF nMenu == 1

         aDane := hb_Hash()
         aDane[ 'uzytkownik' ] := AllTrim( dos_c( code() ) )
         aDane[ 'firma' ] := AllTrim( symbol_fir )
         aDane[ 'naglowek' ] := AllTrim( paras_wwd )
         aDane[ 'data_od' ] := data_od
         aDane[ 'data_do' ] := data_do

         aDane[ 'wiersze' ] := {}

         DO WHILE .NOT. Eof()

            aWiersz := hb_Hash()
            aWiersz[ 'data' ] := data
            aWiersz[ 'mcwyp' ] := mcwyp
            aWiersz[ 'nazwisko' ] := AllTrim( nazwisko )
            aWiersz[ 'pesel' ] := AllTrim( pesel )
            aWiersz[ 'wyplacono' ] := wyplacono
            aWiersz[ 'zaliczka' ] := zaliczka

            AAdd( aDane[ 'wiersze' ], aWiersz )
            SKIP

         ENDDO

         FRDrukuj( 'frf\wypldnia.frf', aDane )

      ELSE

         strona := 0
         glowka := PadC( AllTrim( paras_wwd ) + ' ' + DToC( data_od ) + '-' + DToC( data_do ), 62, ' ' )
         mon_drk( 'ö' + ProcName() )
         _grupa1 := Int( strona / max( 1, _druk_2 - 6 ) )
         _grupa := .T.
         *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
         kk3a := DToC( data )
         kk3 := mcwyp
         kk1 := SubStr( nazwisko, 1, 32 )
         kk2 := pesel
         kk2a := kk1 + kk2
         kk6 := Transform( wyplacono, '@Z 999999.99' )
         kk8 := Transform( zaliczka, '@Z 999999.99' )
         STORE 0 TO sumkk6mc, sumkk6, sumkk8mc, sumkk8, sumkklicz, sumkkliczm
         STORE 0 TO allkk6, allkk8
         *** wstawic gdy bedzie komplet petli***
         DO WHILE .NOT. Eof()
            glwypldnia()
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k3a := DToC( DATA )
            k3 := mcwyp
            k1 := SubStr( nazwisko, 1, 32 )
            k2 := pesel
            k6 := Transform( wyplacono, '@Z 999999.99' )
            k8 := Transform( zaliczka, '@Z 999999.99' )
            mon_drk2( 'glwypldnia', 'stwypldnia', ' ' + k3a + ' ' + k3 + ' ' + k1 + ' ' + k2 + ' ' + k6 + ' ' + k8 + ' ' )
            SKIP
            sumkk6mc := sumkk6mc + Val( k6 )
            sumkk8mc := sumkk8mc + Val( k8 )
            stwypldnia()
            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         ENDDO
         *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk( repl( '=', 80 ) )
         mon_drk( Space( 59 ) + Transform( sumkk6mc, '9999999.99' ) + Transform( sumkk8mc, '9999999.99' ) )
         mon_drk( Space( 50 ) + '=====RAZEM=====' + Transform( sumkk6mc + sumkk8mc, '9999999.99' ) )
         mon_drk( repl( '*', 80 ) )
         mon_drk( '' )
         mon_drk( '                U&_z.ytkownik programu komputerowego' )
         mon_drk( '        ' + dos_c( code() ) )
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk( 'ş' )

      ENDIF
   END
   IF _czy_close
      close_()
   ENDIF

   RETURN
***************************************************
PROCEDURE glwypldnia()
***************************************************
   IF _grupa .OR. _grupa1 # Int( strona / Max( 1, _druk_2 - 6 ) )
      _grupa1 := Int( strona / Max( 1, _druk_2 - 6 ) )
      _grupa := .F.
      nr_strony := nr_strony + 1
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( ' ' + SYMBOL_FIR + ' ' + glowka + ' s.' + Str( nr_strony, 1 ) )
      mon_drk( 'ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿' )
      mon_drk( '³   Data   ³MC³                                ³           ³  Jako   ³   Jako  ³' )
      mon_drk( '³ dokonanej³wy³ N A Z W I S K O  i  I M I O N A³   PESEL   ³         ³         ³' )
      mon_drk( '³  wyplaty ³pl³                                ³           ³ wyplata ³ zaliczka³' )
      mon_drk( 'ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ' )
   ENDIF
   RETURN
***************************************************
PROCEDURE stwypldnia()
***************************************************
   _numer := 1
   DO CASE
   CASE Int( strona / Max( 1, _druk_2 - 6 ) ) # _grupa1
      _numer := 0
      _grupa := .T.
   OTHERWISE
      _grupa := .F.
   ENDCASE
   RETURN
