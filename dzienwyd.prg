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

PROCEDURE DzienWyd( zadzien, zestnr )

   PRIVATE _grupa1, _grupa2, _grupa3, _grupa4, _grupa5, _grupa, _koniec, _szerokosc, _numer, _lewa, _prawa, _strona, _czy_mon, _czy_close
   PRIVATE _t1, _t2, _t3, _t4, _t5, _t6, _t7, _t8, _t9, _t10, _t11, _t12, _t13, _t14, _t15

   BEGIN SEQUENCE
      @ 1, 47 SAY Space( 10 )
      *-----parametry wewnetrzne-----
      _papsz := 1
      _lewa := 1
      _prawa := 132
      _strona := .F.
      _czy_mon := .T.
      _czy_close := .F.
      czesc := 1
      *------------------------------
      _szerokosc := 132
      _koniec := "del#[+].or.firma#ident_fir.or.mc#miesiac.or.dzien#zadzien.or.numer#zestnr"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap := 1
      stronak := 99999
      strona := 0
      liczba := 0
      select 3
      DO WHILE .NOT. Dostep( 'FIRMA' )
      ENDDO
      GO Val( ident_fir )
      SELECT dzienne
      SAVE SCREEN TO dops
      @ 22, 0 CLEAR TO 24, 79
      @ 22, 0 TO 24, 79
      SET CURSOR ON
      dopisek := Space( 60 )
      @ 23, 1 SAY 'OPIS ZESTAWIENIA:' GET dopisek PICTURE repl( '!', 60 )
      READ
      SET CURSOR OFF
      RESTORE SCREEN FROM dops
      IF LastKey() == 27
         KEYBOARD Chr( 13 )
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'ö' + ProcName() )
      IF _mon_drk == 2
         _lewa := 1
         _prawa := 132
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      STORE 0 TO s0_6, s0_7, s0_8, s0_9, s0_10, s0_11, s0_12, s0_13, s0_14, s0_15, s0_16, s0_17, s1_9, s1_11, s1_13, s1_14, s1_15, s2_9, s2_11, s2_13, s2_14, s2_15
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k1 := dos_p( zadzien )
      k2 := dos_p( Upper( miesiac( Val( miesiac ) ) ) )
      _grupa1 := int( strona / Max( 1, _druk_2 - 11 ) )
      _grupa := .T.
      _numer := 1
      SEEK '+' + ident_fir + miesiac + zadzien + zestnr
      numpocz := numer_rach
      numkon := numpocz
      DO WHILE .NOT. &_koniec
         IF ( _grupa .OR. _grupa1 # Int( strona / Max( 1, _druk_2 - 11 ) ) )
            _grupa1 := Int( strona / Max( 1, _druk_2 - 11 ) )
            _grupa := .T.
            *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
            k1 := dos_p( zadzien )
            k2 := AllTrim( Upper( miesiac( Val( miesiac ) ) ) )
            SELECT firma
            ks := scal( AllTrim( nazwa ) + ' ' + miejsc + ' ul.' + ulica + ' ' + nr_domu + iif( Empty( nr_mieszk ), ' ', '/' ) + nr_mieszk )
            SELECT dzienne
            k3 := ks + Space( 100 - Len( ks ) )
            k4 := Int( strona / Max( 1, _druk_2 - 11 ) ) + 1
            mon_drk( '    ' + Space( 30 ) + 'Dzienne zestawienie sprzeda&_z.y nr ' + zestnr + ' z dnia ' + k1 + '.' + k2 + '.' + param_rok )
            mon_drk( '    ' + k3 + '           str. ' + Str( k4, 3 ) )
            mon_drk( '    ' + DOPISEK )
            mon_drk( 'ÚÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿' )
            mon_drk( '³  ³          ³ OGOLNA  ³ OGOLNA  ³SPRZEDAZ wg staw' + Str( vat_A, 2 ) + '%³SPRZEDAZ wg staw' + Str( vat_B, 1 ) + '%³SPRZEDAZ wg staw' + Str( vat_C, 1 ) + '%³SPRZEDAZ wg staw' + Str( vat_D, 1 ) + '%³SPRZEDAZ ³ SPRZEDAZ³' )
            mon_drk( '³Lp³  NUMER   ³ WARTOSC ³ WARTOSC ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ´wg stawki³ZWOLNIONA³' )
            mon_drk( '³  ³  DOWODU  ³  NETTO  ³PODAT.VAT³  NETTO  ³   VAT   ³  NETTO  ³   VAT  ³  NETTO  ³   VAT  ³  NETTO  ³   VAT  ³   0 %   ³OD PODAT.³' )
            mon_drk( 'ÀÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ' )
         ENDIF
*        *@@*@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k3 := numer_rach
         nRAZEM := 0
         vRAZEM := 0
         n22 := 0
         n7 := 0
         n2 := 0
         n12 := 0
         n0 := 0
         nzw := 0
         nin := 0
         v22 := 0
         v7 := 0
         v2 := 0
         v12 := 0
         vin := 0
         DO WHILE .NOT. &_bot .AND. dzien == zadzien .AND. numer == zestnr .AND. numer_rach = k3 .AND. .NOT. Eof()
            DO CASE
            CASE STAWKA = Str( vat_A, 2 )
               n22 := n22 + netto
               v22 := v22 + wartvat
            CASE STAWKA = Str( vat_B, 1 ) + ' '
               n7 := n7 + netto
               v7 := v7 + wartvat
            CASE STAWKA = Str( vat_C, 1 ) + ' '
               n2 := n2 + netto
               v2 := v2 + wartvat
            CASE STAWKA = Str( vat_D, 1 ) + ' '
               n12 := n12 + netto
               v12 := v12 + wartvat
            CASE STAWKA = '0 '
               n0 := n0 + netto
            CASE STAWKA = 'ZW'
               nzw := nzw + netto
            OTHERWISE
               nin := nin + netto
               vin := vin + wartvat
            ENDCASE
            nrazem := nrazem + netto
            vrazem := vrazem + wartvat
            SKIP 1
         ENDDO
         k87 := v22 + v12 + v7 + v2 + vin
         k89 := nZW + n0 + n2 + n7 + n22 + n12 + nin
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         strona := strona + 1
         liczba := liczba + 1
         k1 := Str( liczba, 3 )
         s0_8 := s0_8 + k89
         s0_9 := s0_9 + n22
         s0_10 := s0_10 + v22
         s0_6 := s0_6 + n12
         s0_7 := s0_7 + v12
         s0_11 := s0_11 + n7
         s0_12 := s0_12 + v7
         s0_13 := s0_13 + n0
         s0_14 := s0_14 + nzw
         s0_15 := s0_15 + k87
         s0_16 := s0_16 + n2
         s0_17 := s0_17 + v2
         k7 := Transform( k87, '@Z 999999.99' )
         k8 := Transform( k89, '@Z 999999.99' )
         k9 := Transform( n22, '@Z 999999.99' )
         k10 := Transform( v22, '@Z 999999.99' )
         k9a := Transform( n12, '@Z 999999.99' )
         k10a := Transform( v12, '@Z 99999.99' )
         k11 := Transform( n7, '@Z 999999.99' )
         k12 := Transform( v7, '@Z 99999.99' )
         k13 := Transform( n0, '@Z 999999.99' )
         k14 := Transform( nzw, '@Z 999999.99' )
         k15 := Transform( n2, '@Z 999999.99' )
         k16 := Transform( v2, '@Z 99999.99' )
         mon_drk( k1 + ' ' + k3 + ' ' + k8 + ' ' + k7 + ' ' + k9 + ' ' + k10 + ' ' + k11 + ' ' + k12 + ' ' + k15 + ' ' + k16 + ' ' + k9a + ' ' + k10a + ' ' + k13 + ' ' + k14 )
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer := 1
         DO CASE
         CASE Int( strona / Max( 1, _druk_2 - 11 ) ) # _grupa1
            _numer := 0
         ENDCASE
         _grupa := .F.
         IF _numer < 1 .AND. .NOT. &_koniec
            mon_drk( 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ' )
            mon_drk( '                   U&_z.ytkownik programu komputerowego' )
            mon_drk( '           ' + dos_c( code() ) )
            //IF _mon_drk = 2 .OR. _mon_drk = 3
               *ejec
            //ENDIF
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         ENDIF
         numkon := k3
      ENDDO
      *IF _NUMER>=1
         mon_drk( 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ' )
         mon_drk( Space( 4 ) + 'RAZEM      ' + Str( s0_8, 9, 2 ) + ' ' + Str( s0_15, 9, 2 ) + ' ' + Str( s0_9, 9, 2 ) + ' ' + Str( s0_10, 9, 2 ) + ' ' + Str( s0_11, 9, 2 ) + ' ' + Str( s0_12, 8, 2 ) + ' ' + Str( s0_16, 9, 2 ) + ' ' + Str( s0_17, 8, 2 ) + ' ' + Str( s0_6, 9, 2 ) + ' ' + Str( s0_7, 8, 2 ) + ' ' + Str( s0_13, 9, 2 ) + ' ' + Str( s0_14, 9, 2 ) )
         mon_drk( '    DOWODY SPRZEDA&__Z.Y od nr ' + numpocz + ' do nr ' + numkon )
      *ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'ş' )
   END
   IF _czy_close
      close_()
   ENDIF

   RETURN