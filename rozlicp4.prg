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

PROCEDURE RozlicP4()

   LOCAL nMenu, aDane, aWiersz, nZakres, aRekordy := {}

   PRIVATE _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
   PRIVATE _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep

   BEGIN SEQUENCE
      @ 1, 47 say Space( 10 )
      *-----parametry wewnetrzne-----
      nr_strony := 0
      _papsz := 1
      _lewa := 1
      _prawa := 87
      _strona := .F.
      _czy_mon := .T.
      _czy_close := .T.
      czesc := 1
      *------------------------------
      _szerokosc := 87
      _koniec := "del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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
      IF ! File( 'ROBWYP.dbf' )
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

      paras_rp4 := 'Rozliczone w PIT-4'
      IF .NOT. File( 'param_sp.mem' )
         SAVE TO param_sp ALL LIKE paras_*
      ELSE
         RESTORE FROM param_sp ADDITIVE
      ENDIF
      zparas_rp4 := paras_rp4 + Space( 40 - Len( paras_rp4 ) )
      zdopit4 := param_rok + StrTran( miesiac, ' ', '0' )
      @ 23,  0 CLEAR TO 23, 79
      @ 23,  0 SAY 'Okres PIT-4' GET zdopit4 PICTURE '@R 9999.99'
      @ 23, 22 SAY 'Nag&_l.&_o.wek' GET zparas_rp4 PICTURE repl( 'X', 40 )
      read_()
      IF LastKey() == 27
         BREAK
      ENDIF
      paras_rp4 := AllTrim( zparas_rp4 )
      SAVE TO param_sp ALL LIKE paras_*

      SELECT etaty
      SET FILTER TO ( do_wyplaty <> 0 .OR. ( brut_razem - war_psum ) <> 0 .OR. podatek <> 0 ) .AND. do_pit4 == zdopit4
      ***********************
      *      (DOD.and.DDO)
      ***********************
      GO TOP

      SELECT prac

      DO WHILE .NOT. &_koniec .AND. .NOT. Eof()
         SELECT etaty
         SEEK '+' + ident_fir + Str( prac->rec_no, 5 )
         IF Found() .AND. ( Len( aRekordy ) == 0 .OR. AScan( aRekordy, prac->( RecNo() ) ) > 0 )
            znazimie := AllTrim( prac->nazwisko ) + ' ' + AllTrim( prac->imie1 ) + ' ' + AllTrim( prac->imie2 )
            zpesel := prac->pesel
            DO WHILE del + firma + ident == '+' + ident_fir + Str( prac->rec_no, 5 ) .AND. .NOT. Eof()
               SELECT robwyp
               APPEND BLANK
               REPLACE nazwisko WITH znazimie, ;
                  pesel WITH zpesel, ;
                  mcwyp WITH etaty->mc, ;
                  dowyplaty WITH etaty->do_wyplaty, ;
                  wyplacono WITH etaty->brut_razem-etaty->war_psum, ;
                  podatek WITH etaty->podatek, ;
                  dopit4 WITH etaty->do_pit4
               SELECT etaty
               SKIP
            ENDDO
         ENDIF
         SELECT prac
         SKIP
      ENDDO

      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      SELECT robwyp
      GO TOP

      nMenu := GraficznyCzyTekst( "RozlicP4" )
      IF nMenu == 0
         BREAK
      ENDIF

      IF nMenu == 1

         aDane := hb_Hash()
         aDane[ 'uzytkownik' ] := AllTrim( dos_c( code() ) )
         aDane[ 'firma' ] := AllTrim( symbol_fir )
         aDane[ 'naglowek' ] := AllTrim( paras_rp4 ) + ' za ' + Transform( zdopit4, '@R 9999.99')

         aDane[ 'wiersze' ] := {}

         DO WHILE .NOT. Eof()


            aWiersz := hb_Hash()
            aWiersz[ 'mcwyp' ] := mcwyp
            aWiersz[ 'nazwisko' ] := AllTrim( nazwisko )
            aWiersz[ 'pesel' ] := AllTrim( pesel )
            aWiersz[ 'dowyplaty' ] := dowyplaty
            aWiersz[ 'datawypla' ] := StrTran( DToC( datawypla ), '    .  .  ', '' )
            aWiersz[ 'wyplacono' ] := wyplacono
            aWiersz[ 'datazali' ] := StrTran( DToC( datazali ), '    .  .  ', '' )
            aWiersz[ 'zaliczka' ] := zaliczka
            aWiersz[ 'podatek' ] := podatek
            aWiersz[ 'dopit4' ] := StrTran( SubStr( dopit4, 1, 4 ) + '.' + SubStr( dopit4, 5, 2 ), '    .  ', '' )

            AAdd( aDane[ 'wiersze' ], aWiersz )
            SKIP

         ENDDO

         FRDrukuj( 'frf\rozlicp4.frf', aDane )

      ELSE

         strona := 0
         glowka := PadC( AllTrim( paras_rp4 ) + ' za ' + Transform( zdopit4, '@R 9999.99'), 61, ' ' )
         mon_drk( 'ö' + ProcName() )
         _grupa1 := Int( strona / Max( 1, _druk_2 - 6 ) )
         _grupa := .T.
         *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
         kk3 := mcwyp
         kk1 := SubStr( nazwisko, 1, 32 )
         kk2 := pesel
         kk2a := kk1 + kk2
         kk4 := Transform( dowyplaty, '@Z 999999.99' )
         kk5 := StrTran( DToC( datawypla ), '    .  .  ', Space( 10 ) )
         kk6 := Transform( wyplacono, '@Z 999999.99' )
         kk7 := StrTran( DToC( datazali ), '    .  .  ', Space( 10 ) )
         kk8 := Transform( zaliczka, '@Z 999999.99' )
         kk9 := Space( 9 )
         kk10 := Transform( podatek, '@Z 999999.99' )
         kk11 := StrTran( SubStr( dopit4, 1, 4 ) + '.' + SubStr( dopit4, 5, 2 ), '    .  ', Space( 7 ) )
         STORE 0 TO sumkk4mc,sumkk4,sumkk6mc,sumkk6,sumkk8mc,sumkk8,sumkk9mc,sumkk9,sumkk10mc,sumkk10,sumkklicz,sumkkliczm
         STORE 0 TO allkk4,allkk6,allkk8,allkk9,allkk10
         *** wstawic gdy bedzie komplet petli***
         DO WHILE .NOT. Eof()
            glrozlicp4()
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k3 := mcwyp
            k1 := SubStr( nazwisko, 1, 32 )
            k2 := pesel
            k4 := Transform( dowyplaty, '@Z 999999.99' )
            k5 := StrTran( DToC( datawypla ), '    .  .  ', Space( 10 ) )
            k6 := Transform( wyplacono, '@Z 999999.99' )
            k7 := StrTran( DToC( datazali ), '    .  .  ', Space( 10 ) )
            k8 := Transform( zaliczka, '@Z 999999.99' )
            k9 := Transform( Val( kk4 ) - ( sumkk6mc + sumkk8mc + Val( k6 ) + Val( k8 ) ), '999999.99' )
            k10 := Transform( podatek, '@Z 999999.99' )
            k11 := StrTran( SubStr( dopit4, 1, 4 ) + '.' + SubStr( dopit4, 5, 2 ), '    .  ', Space( 7 ) )
            IF sumkklicz = 0
               mon_drk2( 'glrozlicp4', 'strozlicp4', ' ' + k1 + ' ' + k2 + ' ' + k3 + ' ' + k6 + ' ' + k4 + ' ' + k10 + ' ' + k11 + ' ' )
            ELSE
               mon_drk2( 'glrozlicp4', 'strozlicp4', ' ' + Space( 32 ) + ' ' + Space( 11 ) + ' ' + k3 + ' ' + k6 + ' ' + k4 + ' ' + k10 + ' ' + k11 + ' ' )
            ENDIF
            SKIP
            sumkk6mc := sumkk6mc + Val( k6 )
            sumkk4mc := sumkk4mc + Val( k4 )
            sumkk10mc := sumkk10mc + Val( k10 )
            sumkklicz := sumkklicz + 1
            IF SubStr( nazwisko, 1, 32 ) + pesel <> kk1 + kk2 .OR. Eof()
               IF sumkklicz > 1
                  mon_drk2( 'glrozlicp4', 'strozlicp4', Space( 46 ) + repl( '-', 41 ) )
                  mon_drk2( 'glrozlicp4', 'strozlicp4', ' ' + Space( 32 ) + ' ' + kk2 + ' ' + Space( 2 ) + ' ' + Transform( sumkk6mc, '999999.99' ) + ' ' + Transform( sumkk4mc, '999999.99' ) + ' ' + Transform( sumkk10mc, '999999.99' ) )
                  mon_drk2( 'glrozlicp4', 'strozlicp4', Space( 34 ) + repl( '=', 53 ) )
                  sumkk6 := sumkk6 + sumkk6mc
                  sumkk4 := sumkk4 + sumkk4mc
                  sumkk10 := sumkk10 + sumkk10mc
                  sumkk6mc := 0
                  sumkk4mc := 0
                  sumkk10mc := 0
                  sumkklicz := 0
               ELSE
                  sumkk6 := sumkk6 + sumkk6mc
                  sumkk4 := sumkk4 + sumkk4mc
                  sumkk10 := sumkk10 + sumkk10mc
                  sumkk6mc := 0
                  sumkk4mc := 0
                  sumkk10mc := 0
                  sumkklicz := 0
               ENDIF
               kk3 := mcwyp
               kk1 := SubStr( nazwisko, 1, 32 )
               kk2 := pesel
               kk2a := kk1 + kk2
               kk4 := Transform( dowyplaty, '@Z 999999.99' )
               kk5 := StrTran( DToC( datawypla ), '    .  .  ', Space( 10 ) )
               kk6 := Transform( wyplacono, '@Z 999999.99' )
               kk7 := StrTran( DToC( datazali ), '    .  .  ', Space( 10 ) )
               kk8 := Transform( zaliczka, '@Z 999999.99' )
               kk9 := Space( 9 )
               kk10 := Transform( podatek, '@Z 999999.99' )
               kk11 := StrTran( SubStr( dopit4, 1, 4 ) + '.' + SubStr( dopit4, 5, 2 ), '    .  ', Space( 7 ) )
            ENDIF
            strozlicp4()
            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         ENDDO
         *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk( repl( '=', 87 ) )
         mon_drk2( 'glrozlicp4', 'strozlicp4', ' ' + Space( 32 ) + ' ' + Space( 11 ) + ' ' + Space( 2 ) + Transform( sumkk6, '9999999.99' ) + Transform( sumkk4, '9999999.99' ) + Transform( sumkk10, '9999999.99' ) )
         mon_drk( repl( '*', 87 ) )
         mon_drk( '' )
         mon_drk( '                U&_z.ytkownik programu komputerowego' )
         mon_drk( '        ' + dos_c( code() ) )
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk( 'þ' )

      ENDIF

   END
   IF _czy_close
      close_()
   ENDIF
   RETURN

***************************************************
PROCEDURE glrozlicp4()
***************************************************
   IF _grupa .OR. _grupa1 # Int( strona / Max( 1, _druk_2 - 6 ) )
      _grupa1 := Int( strona / max( 1, _druk_2 - 6 ) )
      _grupa := .F.
      nr_strony := nr_strony + 1
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( ' FIRMA:' + symbol_fir + ' ' + glowka + ' str.' + Str( nr_strony, 2 ) )
      mon_drk( 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      mon_drk( '³                                ³           ³MC³  Kwota  ³  Kwota  ³     PODATEK     ³' )
      mon_drk( '³ N A Z W I S K O  i  I M I O N A³   PESEL   ³wy³    do   ³    do   ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄ´' )
      mon_drk( '³                                ³           ³pl³  PIT-4  ³ wyplaty ³  Kwota  ³ w PIT4³' )
      mon_drk( 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÙ' )
   ENDIF
   RETURN

***************************************************
PROCEDURE strozlicp4()
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
