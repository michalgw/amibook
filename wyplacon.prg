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

PROCEDURE Wyplacon()

   LOCAL nMenu, aDane, aWiersz

   PRIVATE _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
   PRIVATE _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep

   BEGIN SEQUENCE
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      nr_strony := 0
      _papsz := 1
      _lewa := 1
      _prawa := 129
      _strona := .F.
      _czy_mon := .T.
      _czy_close := .T.
      czesc := 1
      *------------------------------
      _szerokosc := 129
      _koniec := "del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@

      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
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

      IF ! File( 'ROBWYPZA.dbf' )
         dbCreate( "ROBWYPZA", { ;
            {"DATA",     "D", 8, 0},;
            {"RODZAJ",   "C", 1, 0},;
            {"KWOTA",    "N", 8, 2},;
            {"IDENT",    "C", 5, 0},;
            {"MC",       "C", 2, 0}})
      ENDIF
      SELECT 10
      IF DostepEx( 'ROBWYPZA' )
         ZAP
      ELSE
         BREAK
      ENDIF
      INDEX ON DToS( DATA ) TO ROBWYPZA

      SELECT prac

      paras_wyp := 'Rozliczenie wyp&_l.at'
      IF .NOT. File( 'param_sp.mem' )
         SAVE TO param_sp ALL LIKE paras_*
      ELSE
         RESTORE FROM param_sp ADDITIVE
      ENDIF
      zparas_wyp := paras_wyp + Space( 40 - Len( paras_wyp ) )
      zpesel := Space( 11 )
      komu := 'W'
      mcod := Val( miesiac )
      mcdo := Val( miesiac )
      @ 23,  0 CLEAR TO 23, 79
      @ 23,  0 SAY 'M-c od' GET mcod
      @ 23, 10 SAY 'do' GET mcdo
      @ 23, 16 SAY 'Nag&_l.&_o.wek' GET zparas_wyp PICTURE '@S20 ' + repl( 'X', 40 )
      @ 23, 46 SAY 'Wszyscy/PESEL' GET komu PICTURE '!' VALID komu $ 'WP'
      @ 23, 62 SAY 'PESEL' GET zpesel PICTURE repl( 'X', 11 ) WHEN komu == 'P' VALID v4_141w()
      read_()
      IF LastKey() == 27
         BREAK
      ENDIF
      paras_wyp := AllTrim( zparas_wyp )
      SAVE TO param_sp ALL LIKE paras_*
      IF mcod > mcdo
         kom(3,'*u', ' Nieprawid&_l.owy zakres ' )
         BREAK
      ENDIF

      SELECT prac
      IF komu == 'P' .AND. Len( AllTrim( zpesel ) ) <> 0
         SET ORDER TO 5
         SEEK '+' + ident_fir + zpesel
         IF .NOT. Found()
            BREAK
         ELSE
            SET FILTER TO pesel == zpesel
         ENDIF
      ENDIF
      SET ORDER TO 1
      GO TOP
      SEEK '+' + ident_fir
      DO WHILE &_koniec == .F. .AND. .NOT. Eof()
         SELECT etaty
         SEEK '+' + ident_fir + Str( prac->Rec_no, 5 ) + Str( mcod, 2 )
         IF Found()
            DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma == ident_fir .AND. ident == Str( prac->Rec_no, 5 ) .AND. mc >= Str( mcod, 2 ) .AND. mc<= Str( mcdo, 2 )
               SELECT robwypza
               ZAP
               SELECT wyplaty
               SEEK '+' + ident_fir + Str( prac->Rec_no, 5 ) + etaty->mc
               IF Found()
                  DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma == ident_fir .AND. ident == Str( prac->Rec_no, 5 ) .AND. mc == etaty->mc
                     SELECT robwypza
                     APPEND BLANK
                     REPLACE data WITH wyplaty->data_wyp, rodzaj WITH 'W', kwota WITH wyplaty->kwota
                     SELECT wyplaty
                     SKIP
                  ENDDO
               ENDIF
               SELECT zaliczki
               SEEK '+' + ident_fir + Str( prac->Rec_no, 5 ) + etaty->mc
               IF Found()
                  DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma == ident_fir .AND. ident == Str( prac->Rec_no, 5 ) .AND. mc == etaty->mc
                     SELECT robwypza
                     APPEND BLANK
                     REPLACE data WITH zaliczki->data_wyp, rodzaj WITH 'Z', kwota WITH zaliczki->kwota
                     SELECT zaliczki
                     SKIP
                  ENDDO
               ENDIF

               SELECT robwyp
               APPEND BLANK
               REPLACE nazwisko WITH AllTrim( prac->nazwisko ) + ' ' + AllTrim( prac->imie1 ) + ' ' + AllTrim( prac->imie2 ), ;
                  pesel WITH prac->pesel, ;
                  mcwyp WITH etaty->mc, ;
                  dowyplaty WITH etaty->do_wyplaty, ;
                  podatek WITH etaty->podatek, ;
                  dopit4 WITH etaty->do_pit4
               SELECT robwypza
               GO TOP
               DO WHILE .NOT. Eof()
                  SELECT robwyp
                  IF robwypza->rodzaj == 'W'
                     REPLACE wyplacono WITH robwypza->kwota, datawypla WITH robwypza->data
                  ENDIF
                  IF robwypza->rodzaj == 'Z'
                     REPLACE zaliczka with robwypza->kwota, datazali WITH robwypza->data
                  ENDIF
                  SELECT robwypza
                  SKIP
                  IF .NOT. Eof()
                     SELECT robwyp
                     APPEND BLANK
                  ENDIF
               ENDDO
               SELECT etaty
               SKIP
            ENDDO
         ENDIF
         SELECT prac
         SKIP
      ENDDO

      SELECT robwyp
      GO TOP
      strona := 0
      IF mcdo - mcod = 0
         glowka := PadC( ' ' + paras_wyp + ' ', 71, ' ' ) + PadL( ' okres: ' + Str( mcod, 2 ) + '.' + param_rok, 24, ' ' )
      ELSE
         glowka := PadC( ' ' + paras_wyp + ' ', 71, ' ' ) + PadL( ' okres od ' + Str( mcod, 2 ) + ' do ' + Str( mcdo, 2 ) + '.' + param_rok, 24, ' ' )
      ENDIF

      nMenu := GraficznyCzyTekst()
      IF nMenu == 0
         BREAK
      ENDIF

      IF nMenu == 1

         aDane := hb_Hash()
         aDane[ 'uzytkownik' ] := AllTrim( dos_c( code() ) )
         aDane[ 'firma' ] := AllTrim( symbol_fir )
         aDane[ 'naglowek' ] := AllTrim( paras_wyp )
         aDane[ 'okres' ] := iif( mcdo - mcod == 0, 'okres: ' + Str( mcod, 2 ) + '.' + param_rok, 'okres od ' + Str( mcod, 2 ) + ' do ' + Str( mcdo, 2 ) + '  ' + param_rok )

         aDane[ 'wiersze' ] := {}

         DO WHILE .NOT. Eof()

            aWiersz := hb_Hash()

            aWiersz[ 'nazwisko' ] := AllTrim( nazwisko )
            aWiersz[ 'pesel' ] := AllTrim( pesel )
            aWiersz[ 'mcwyp' ] := mcwyp
            aWiersz[ 'dowyplaty' ] := dowyplaty
            aWiersz[ 'datawypla' ] := StrTran( DToC( datawypla ), '    .  .  ', '' )
            aWiersz[ 'wyplacono' ] := wyplacono
            aWiersz[ 'datazali' ] := StrTran( DToC( datazali ), '    .  .  ', '' )
            aWiersz[ 'zaliczka' ] := zaliczka
            //k9 := Transform( Val( kk4 ) - ( sumkk6mc + sumkk8mc + Val( k6 ) + Val( k8 ) ), '999999.99' )
            aWiersz[ 'podatek' ] := podatek
            aWiersz[ 'dopit4'] := StrTran( SubStr( dopit4, 1, 4 ) + '.' + SubStr( dopit4, 5, 2 ), '    .  ', '' )

            AAdd( aDane[ 'wiersze' ], aWiersz )

            SKIP
         ENDDO

         FRDrukuj( iif( mcdo - mcod = 0, 'frf\wyplaconl.frf', 'frf\wyplacong.frf' ), aDane )

      ELSE

         mon_drk( 'ö' + ProcName() )
         _grupa1 := Int( strona / Max( 1, _druk_2 - 6 ) )
         _grupa := .T.
         *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
         kk1 := SubStr( nazwisko, 1, 32 )
         kk2 := pesel
         kk2a := kk1 + kk2
         kk3 := mcwyp
         kk4 := Transform( dowyplaty, '@Z 999999.99' )
         kk5 := StrTran( DToC( datawypla ), '    .  .  ', Space( 10 ) )
         kk6 := Transform( wyplacono, '@Z 999999.99' )
         kk7 := StrTran( DToC( datazali ), '    .  .  ', Space( 10 ) )
         kk8 := Transform( zaliczka, '@Z 999999.99' )
         kk9 := Space( 9 )
         kk10 := Transform( podatek, '@Z 999999.99' )
         kk11 := StrTran( SubStr( dopit4, 1, 4 ) + '.' + SubStr( dopit4, 5, 2 ), '    .  ', Space( 7 ) )
         STORE 0 TO sumkk4,sumkk6mc,sumkk6,sumkk8mc,sumkk8,sumkk9,sumkk10,sumkklicz,sumkkliczm
         STORE 0 TO allkk4,allkk6,allkk8,allkk9,allkk10
         *** wstawic gdy bedzie komplet petli***
         DO WHILE .NOT. Eof()
            glwyplacon()
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k1 := SubStr( nazwisko, 1, 32 )
            k2 := pesel
            k3 := mcwyp
            k4 := Transform( dowyplaty, '@Z 999999.99' )
            k5 := StrTran( DToC( datawypla ), '    .  .  ', Space( 10 ) )
            k6 := Transform( wyplacono, '@Z 999999.99' )
            k7 := StrTran( DToC( datazali ), '    .  .  ', Space( 10 ) )
            k8 := Transform( zaliczka, '@Z 999999.99' )
            k9 := Transform( Val( kk4 ) - ( sumkk6mc + sumkk8mc + Val( k6 ) + Val( k8 ) ), '999999.99' )
            k10 := Transform( podatek, '@Z 999999.99' )
            k11 := StrTran( SubStr( dopit4, 1, 4 ) + '.' + SubStr( dopit4, 5, 2 ), '    .  ', Space( 7 ) )
            IF sumkklicz == 0 .AND. sumkkliczm == 0
               mon_drk2( 'glwyplacon', 'stwyplacon', ' ' + k1 + ' ' + k2 + ' ' + k3 + ' ' + k4 + ' ' + k5 + ' ' + k6 + ' ' + k7 + ' ' + k8 + ' ' + k9 + ' ' + k10 + ' ' + k11 + ' ' )
            ELSE
               mon_drk2( 'glwyplacon', 'stwyplacon', ' ' + Space( 32 ) + ' ' + Space( 11 ) + ' ' + k3 + ' ' + k4 + ' ' + k5 + ' ' + k6 + ' ' + k7 + ' ' + k8 + ' ' + k9 + ' ' + k10 + ' ' + k11 + ' ' )
            ENDIF
            SKIP
            sumkk6mc := sumkk6mc + Val( k6 )
            sumkk8mc := sumkk8mc + Val( k8 )
            sumkklicz := sumkklicz + 1
            IF mcod <> mcdo
               sumkkliczm := sumkkliczm + 1
            ENDIF
            IF Len( AllTrim( SubStr( nazwisko, 1, 32 ) + pesel ) ) > 0 .OR. Eof()
               IF sumkklicz > 1
                  mon_drk2( 'glwyplacon', 'stwyplacon', Space( 46 ) + repl( '-', 83 ) )
                  mon_drk2( 'glwyplacon', 'stwyplacon', Space( 46 ) + kk3 + ' ' + kk4 + ' ' + Space( 10 ) + ' ' + Transform( sumkk6mc, '999999.99' ) + ' ' + Space( 10 ) + ' ' + Transform( sumkk8mc, '999999.99' ) + ' ' + Transform( Val( kk4 ) - ( sumkk6mc + sumkk8mc ), '999999.99' ) + ' ' + kk10 + ' ' + kk11 + ' ' )
                  mon_drk2( 'glwyplacon', 'stwyplacon', Space( 46 ) + repl( '=', 83 ) )
                  sumkk4 := sumkk4 + Val( kk4 )
                  sumkk6 := sumkk6 + sumkk6mc
                  sumkk8 := sumkk8 + sumkk8mc
                  sumkk10 := sumkk10 + Val( kk10 )
                  sumkk6mc := 0
                  sumkk8mc := 0
                  sumkklicz := 0
               ELSE
                  sumkk4 := sumkk4 + Val( kk4 )
                  sumkk6 := sumkk6 + sumkk6mc
                  sumkk8 := sumkk8 + sumkk8mc
                  sumkk10 := sumkk10 + Val( kk10 )
                  sumkk6mc := 0
                  sumkk8mc := 0
                  sumkklicz := 0
               ENDIF
               IF AllTrim( SubStr( nazwisko, 1, 32 ) + pesel ) <> kk2a .OR. Eof()
                  IF sumkkliczm > 1
                     mon_drk2( 'glwyplacon', 'stwyplacon', Space( 34 ) + repl( '-', 95 ) )
                     mon_drk2( 'glwyplacon', 'stwyplacon', Space( 34 ) + kk2 + '    ' + Transform( sumkk4, '999999.99' ) + ' ' + Space( 10 ) + ' ' + Transform( sumkk6, '999999.99' ) + ' ' + Space( 10 ) + ' ' + Transform( sumkk8, '999999.99' ) + ' ' + Transform( sumkk4 - ( sumkk6 + sumkk8 ), '999999.99' ) + ' ' + Transform( sumkk10, '999999.99' ) )
                     mon_drk2( 'glwyplacon', 'stwyplacon', repl( '=', 129 ) )
                     allkk4 := allkk4 + sumkk4
                     allkk6 := allkk6 + sumkk6
                     allkk8 := allkk8 + sumkk8
                     allkk10 := allkk10 + sumkk10
                     sumkk4 := 0
                     sumkk6 := 0
                     sumkk8 := 0
                     sumkk10 := 0
                     sumkkliczm := 0
                  ELSE
                     allkk4 := allkk4 + sumkk4
                     allkk6 := allkk6 + sumkk6
                     allkk8 := allkk8 + sumkk8
                     allkk10 := allkk10 + sumkk10
                     sumkk4 := 0
                     sumkk6 := 0
                     sumkk8 := 0
                     sumkk10 := 0
                     sumkkliczm := 0
                  ENDIF
               ENDIF
               kk1 := SubStr( nazwisko, 1, 32 )
               kk2 := pesel
               kk2a := kk1 + kk2
               kk3 := mcwyp
               kk4 := Transform( dowyplaty, '@Z 999999.99' )
               kk5 := StrTran( DToC( datawypla ), '    .  .  ', Space( 10 ) )
               kk6 := Transform( wyplacono, '@Z 999999.99' )
               kk7 := StrTran( DToC( datazali ), '    .  .  ', Space( 10 ) )
               kk8 := Transform( zaliczka, '@Z 999999.99' )
               kk9 := Space( 9 )
               kk10 := Transform( podatek, '@Z 999999.99' )
               kk11 := StrTran( SubStr( dopit4, 1, 4 ) + '.' + SubStr( dopit4, 5, 2 ), '    .  ', Space( 7 ) )
            ENDIF
            stwyplacon()
            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         ENDDO
         *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
         IF mcod = mcdo
            mon_drk( repl( '=', 129 ) )
         ENDIF
         mon_drk( Space( 48 ) + Transform( allkk4, '9999999.99' ) + ' ' + Space( 10 ) + Transform( allkk6, '9999999.99' ) + ' ' + Space( 10 ) + Transform( allkk8, '9999999.99' ) + Transform( allkk4 - ( allkk6 + allkk8 ), '9999999.99' ) + Transform( allkk10, '9999999.99' ) )
         mon_drk( repl( '*', 129 ) )
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
FUNCTION v4_141w()

   IF LastKey() == 5
      RETURN .F.
   ENDIF
   SAVE SCREEN TO scr2
   SELECT prac
   SET ORDER TO 5
   SEEK '+' + ident_fir + zpesel
   IF del # '+' .OR. ident_fir # firma .OR. zpesel # pesel
      SET ORDER TO 1
      SEEK '+' + ident_fir
      IF .NOT. Found()
         RESTORE SCREEN FROM scr2
         SELECT prac
         RETURN .F.
      ENDIF
   ENDIF
   SET ORDER TO 1
   pracw_()
   RESTORE SCREEN FROM scr2
   IF LastKey() == 13
      zpesel := pesel
      SET COLOR TO i
      @ 23, 68 SAY zpesel
      SET COLOR TO
      pause( .5 )
   ENDIF
   SELECT prac
   RETURN .NOT. Empty( zpesel )
***************************************************
PROCEDURE glwyplacon()
***************************************************
   IF _grupa .OR. _grupa1 # Int( strona / Max( 1, _druk_2 - 6 ) )
      _grupa1 := Int( strona / max( 1, _druk_2 - 6 ) )
      _grupa := .F.
      nr_strony := nr_strony + 1
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( ' FIRMA: ' + SYMBOL_FIR + '   ' + glowka + '      str.' + Str( nr_strony, 2 ) )
      mon_drk( 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      mon_drk( '³                                ³           ³MC³  Kwota  ³  WYPLATY DOKONANE  ³ WYPLACONE ZALICZKI ³POZOSTALO³     PODATEK     ³' )
      mon_drk( '³ N A Z W I S K O  i  I M I O N A³   PESEL   ³wy³    do   ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ´   do    ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄ´' )
      mon_drk( '³                                ³           ³pl³ wyplaty ³   Dnia   ³  Kwota  ³   Dnia   ³  Kwota  ³ wyplaty ³  Kwota  ³do PIT4³' )
      mon_drk( 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÙ' )
   ENDIF
   RETURN
***************************************************
PROCEDURE stwyplacon()
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
