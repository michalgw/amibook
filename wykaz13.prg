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

FUNCTION Wykaz13()

   LOCAL lRobS := .T., lRobI := .T., lRobZ := .T., lRobU := .T., lRobW := .T., lRobK := .T., lRob
   LOCAL cRobS := 'T', cRobI := 'T', cRobZ := 'T', cRobU := 'T', cRobW := 'T', cRobK := 'T'
   LOCAL nMenu, cScr

   PRIVATE _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close := .F.
   PRIVATE _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15

   BEGIN SEQUENCE
      @ 1, 47 SAY Space( 10 )

      nMenu := MenuEx( 19, 8, { "W - Wszystkie kolumny", "K - Wybrane kolumny" } )

      DO CASE
      CASE nMenu == 0
         BREAK
      CASE nMenu == 1
         //
      CASE nMenu == 2
         cScr := SaveScreen()
         @  3, 42 CLEAR TO 22, 79
         @  3, 42 SAY 'ÄÄÄÄÄÄ Przychody ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
         @  4, 43 SAY "Sprzeda¾ towar¢w i usˆug...(7)...."
         @  5, 43 SAY "Inne przychody.............(8)...."
         @  6, 42 SAY 'ÄÄÄÄÄÄ Rozchody ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
         @  7, 43 SAY "Zakup towar¢w i materiaˆ¢w.(10)..."
         @  8, 43 SAY "Uboczne koszyt zakupu......(11)..."
         @  9, 43 SAY "Wynagrodzenia..............(12)..."
         @ 10, 43 SAY "Inne koszty................(13)..."
         @  4, 76 GET cRobS PICTURE "!" VALID cRobS $ 'TN'
         @  5, 76 GET cRobI PICTURE "!" VALID cRobI $ 'TN'
         @  7, 76 GET cRobZ PICTURE "!" VALID cRobZ $ 'TN'
         @  8, 76 GET cRobU PICTURE "!" VALID cRobU $ 'TN'
         @  9, 76 GET cRobW PICTURE "!" VALID cRobW $ 'TN'
         @ 10, 76 GET cRobK PICTURE "!" VALID cRobK $ 'TN'
         read_()
         RestScreen( cScr )
         IF LastKey() == K_ESC
            BREAK
         ENDIF
         lRobS := cRobS == 'T'
         lRobI := cRobI == 'T'
         lRobZ := cRobZ == 'T'
         lRobU := cRobU == 'T'
         lRobW := cRobW == 'T'
         lRobK := cRobK == 'T'
      ENDCASE

      *-----parametry wewnetrzne-----
      _papsz := 1
      _lewa := 1
      _prawa := 80
      _strona := .T.
      _czy_mon := .T.
      _czy_close := .T.
      *------------------------------
      _szerokosc := 80
      _koniec := "del#'+'.or.firma#ident_fir.or.mc#miesiac"

      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      czesc := 1

      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      SELECT 3
      IF dostep( 'FIRMA' )
         GO Val( ident_fir )
      ELSE
         BREAK
      ENDIF

      SELECT 2
      IF dostep( 'SUMA_MC' )
         SET INDEX TO suma_mc
         SEEK '+' + ident_fir + mc_rozp
         liczba := firma->liczba - 1
         DO WHILE del == '+' .AND. firma == ident_fir .AND. mc < miesiac
            liczba := liczba + pozycje
            SKIP
         ENDDO
      ELSE
         BREAK
      ENDIF

      SELECT 1
      IF dostep( 'OPER' )
         setind( 'OPER' )
         SEEK '+' + ident_fir + miesiac
      ELSE
         BREAK
      ENDIF

      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      IF &_koniec
         kom( 3, '*w', 'b r a k   d a n y c h' )
         BREAK
      ENDIF

      mon_drk( 'ö' + ProcName() )

      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k1 := dos_p( Upper( miesiac( Val( miesiac ) ) ) )
      k2 := param_rok
      mon_drk( ' Zestawienie pomocnicze za ' + k1 + '.' + k2 + ' Sporz&_a.dz.dnia-' + DToC( Date() ) + ' godz-' + SubStr( Time(), 1, 5 ) )
      mon_drk( ' FIRMA: ' + symbol_fir )
      mon_drk( 'ÚÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      mon_drk( '³     ³ Nr ³    Nr    ³                          ³              ³              ³' )
      mon_drk( '³ Lp  ³dnia³  dowodu  ³          Kontrahent      ³    Przych&_o.d  ³    Rozch&_o.d   ³' )
      mon_drk( 'ÀÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ' )

      STORE 0 TO s0_5,s0_6,SS,SI,SZ,SU,SR,SW,SK,SZr,SUr,SRr,SWr,SKr
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

      _grupa := .T.
      DO WHILE ! &_koniec

         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@

         lRob := .F.
         liczba := liczba + 1
         k1 := dos_c( Str( liczba, 5 ) )
         k2 := dzien
         k3 := SubStr( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ) + ' ', numer ), 1, 10 )
         k4 := nazwa
         K5 := iif( lRobS, wyr_tow, 0 ) + iif( lRobI, uslugi, 0 )
         K6 := iif( lRobZ, zakup, 0 ) + iif( lRobU, uboczne, 0 ) + iif( lRobW, wynagr_g, 0 ) + iif( lRobK, wydatki, 0 )
         P=' '
         R=' '
         IF wyr_tow <> 0 .AND. lRobS
            P := 's'
            ss := ss + wyr_tow
            lRob := .T.
         ENDIF
         IF uslugi <> 0 .AND. lRobI
            P := 'i'
            si := si + uslugi
            lRob := .T.
         ENDIF
         IF zakup <> 0 .AND. lRobZ
            R := 'z'
            IF Left( numer, 3 ) == 'RZ-'
               szr := szr + zakup
            ELSE
               sz := sz + zakup
            ENDIF
            lRob := .T.
         ENDIF
         IF uboczne <> 0 .AND. lRobU
            R := 'u'
            IF Left( numer, 3 ) == 'RZ-'
               sur := sur + uboczne
            ELSE
               su := su + uboczne
            ENDIF
            lRob := .T.
         ENDIF
         IF wynagr_g <> 0 .AND. lRobW
            R := 'w'
            IF Left( numer, 3 ) == 'RZ-'
               swr := swr + wynagr_g
            ELSE
               sw := sw + wynagr_g
            ENDIF
            lRob := .T.
         ENDIF
         IF wydatki <> 0 .AND. lRobK
            R := 'k'
            IF Left( numer, 3 ) == 'RZ-'
               skr := skr + wydatki
            ELSE
               sk := sk + wydatki
            ENDIF
            lRob := .T.
         ENDIF
         znumer := numer
         SKIP

         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         IF Left( znumer, 1 )#Chr( 1 ) .AND. Left( znumer, 1 )#Chr( 254 )
            s0_5 := s0_5 + k5
            s0_6 := s0_6 + k6
         ENDIF
         k4 := SubStr( k4, 1, 26 )
         IF k5 == 0
            k5 := Space( 14 )
         ELSE
            k5 := kwota( k5, 14, 2 )
         ENDIF
         IF k6 == 0
            k6 := Space( 14 )
         ELSE
            k6 := kwota( k6, 14, 2 )
         ENDIF

         IF lRob
            mon_drk( ' ' + k1 + '  ' + k2 + '  ' + k3 + ' ' + k4 + ' ' + k5 + P + k6 + R )
         ENDIF

         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer := 0
         _grupa := .F.
      ENDDO

      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ' )
      mon_drk( '                     R A Z E M                    ' + kwota( s0_5, 14, 2 ) + ' ' + kwota( s0_6, 14, 2 ) )
      mon_drk( '' )
      IF lRobS
         mon_drk( '        s - sprzeda&_z. towar&_o.w i us&_l.ug (kol. 7)     ' + kwota( SS, 14, 2 ) )
      ENDIF
      IF lRobI
         mon_drk( '        i - inne przychody           (kol. 8)     ' + kwota( SI, 14, 2 ) )
      ENDIF
      IF lRobS .OR. lRobI
         mon_drk( '                                                  --------------' )
         mon_drk( '                                      PRZYCHODY   ' + kwota( SS + SI, 14, 2 ) )
         mon_drk( '' )
      ENDIF
      IF lRobZ .OR. lRobU .OR. lRobW .OR. lRobK
         mon_drk( '                                                 KSI&__E.GA     REJESTR    RAZEM   ' )
      ENDIF
      IF lRobZ
         mon_drk( '        z - zakup towar&_o.w i materia&_l..(kol.10)  ' + kwota( SZ, 10, 2 ) + ' ' + kwota( SZr, 10, 2 ) + ' ' + kwota( sz + SZr, 10, 2 ) )
      ENDIF
      IF lRobU
         mon_drk( '        u - uboczne koszty zakupu    (kol.11)  ' + kwota( SU, 10, 2 ) + ' ' + kwota( SUr, 10, 2 ) + ' ' + kwota( su + SUr, 10, 2 ) )
      ENDIF
      IF lRobW
         mon_drk( '        w - wynagrodzenia            (kol.12)  ' + kwota( SW, 10, 2 ) + ' ' + kwota( SWr, 10, 2 ) + ' ' + kwota( sw + SWr, 10, 2 ) )
      ENDIF
      IF lRobK
         mon_drk( '        k - koszty pozosta&_l.e         (kol.13)  ' + kwota( SK, 10, 2 ) + ' ' + kwota( SKr, 10, 2 ) + ' ' + kwota( sk + SKr, 10, 2 ) )
      ENDIF
      IF lRobZ .OR. lRobU .OR. lRobW .OR. lRobK
         mon_drk( '                                               ---------- ---------- ----------' )
         mon_drk( '                                      ROZCHODY ' + kwota( SZ + SU + SW + SK, 10, 2 ) + ' ' + kwota( SZr + SUr + SWr + SKr, 10, 2 ) + ' ' + kwota( SZ + SU + SW + SK + SZr + SUr + SWr + SKr, 10, 2 ) )
      ENDIF
      mon_drk( '' )
      mon_drk( '                     U&_z.ytkownik programu komputerowego' )
      mon_drk( '             ' + dos_c( code() ) )
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'þ' )
   END

   IF _czy_close
      close_()
   ENDIF

   RETURN NIL