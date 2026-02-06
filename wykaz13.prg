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
   LOCAL nMenu, cScr, nGrafText, aDane := {=>}, aPoz, aSumP, aSumR, aWiersze, i, oRap

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

      nGrafText := GraficznyCzyTekst( 'wykaz13' )

      IF nGrafText == 0
         BREAK
      ENDIF

      aDane[ 'miesiac' ] := AllTrim( Upper( miesiac( Val( miesiac ) ) ) )
      aDane[ 'rok' ] := param_rok
      aDane[ 'firma' ] := AllTrim( symbol_fir )
      aDane[ 's7' ] := 0
      aDane[ 's8' ] := 0
      aDane[ 's10' ] := 0
      aDane[ 's10r' ] := 0
      aDane[ 's11' ] := 0
      aDane[ 's11r' ] := 0
      aDane[ 's12' ] := 0
      aDane[ 's12r' ] := 0
      aDane[ 's13' ] := 0
      aDane[ 's13r' ] := 0
      aDane[ 'sp' ] := 0
      aDane[ 'sr' ] := 0
      aDane[ 'uzytkownik' ] := AllTrim( code() )

      aWiersze := {}

      DO WHILE ! &_koniec
         lRob := .F.
         aPoz := {=>}
         liczba := liczba + 1
         aPoz[ 'lp' ] := liczba
         aPoz[ 'k1' ] := dos_c( Str( liczba, 5 ) )
         aPoz[ 'dzien' ] := dzien
         aPoz[ 'k2' ] := dzien
         aPoz[ 'numer' ] := iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ) + ' ', numer )
         aPoz[ 'k3' ] := SubStr( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ) + ' ', numer ), 1, 10 )
         aPoz[ 'nazwa' ] := AllTrim( nazwa )
         aPoz[ 'k4' ] := nazwa
         aPoz[ 'przychod' ] := iif( lRobS, wyr_tow, 0 ) + iif( lRobI, uslugi, 0 )
         aPoz[ 'k5' ] := iif( lRobS, wyr_tow, 0 ) + iif( lRobI, uslugi, 0 )
         aPoz[ 'rozchod' ] := iif( lRobZ, zakup, 0 ) + iif( lRobU, uboczne, 0 ) + iif( lRobW, wynagr_g, 0 ) + iif( lRobK, wydatki, 0 )
         aPoz[ 'k6' ] := iif( lRobZ, zakup, 0 ) + iif( lRobU, uboczne, 0 ) + iif( lRobW, wynagr_g, 0 ) + iif( lRobK, wydatki, 0 )
         aPoz[ 'P' ] := ' '
         aPoz[ 'R' ] := ' '
         IF wyr_tow <> 0 .AND. lRobS
            aPoz[ 'P' ] := 's'
            aDane[ 's7' ] := aDane[ 's7' ] + wyr_tow
            lRob := .T.
         ENDIF
         IF uslugi <> 0 .AND. lRobI
            aPoz[ 'P' ] := 'i'
            aDane[ 's8' ] := aDane[ 's8' ] + uslugi
            lRob := .T.
         ENDIF
         IF zakup <> 0 .AND. lRobZ
            aPoz[ 'R' ] := 'z'
            IF Left( numer, 3 ) == 'RZ-'
               aDane[ 's10r' ] := aDane[ 's10r' ] + zakup
            ELSE
               aDane[ 's10' ] := aDane[ 's10' ] + zakup
            ENDIF
            lRob := .T.
         ENDIF
         IF uboczne <> 0 .AND. lRobU
            aPoz [ 'R' ] := 'u'
            IF Left( numer, 3 ) == 'RZ-'
               aDane[ 's11r' ] := aDane[ 's11r' ] + uboczne
            ELSE
               aDane[ 's11' ] := aDane[ 's11' ] + uboczne
            ENDIF
            lRob := .T.
         ENDIF
         IF wynagr_g <> 0 .AND. lRobW
            aPoz [ 'R' ] := 'w'
            IF Left( numer, 3 ) == 'RZ-'
               aDane[ 's12r' ] := aDane[ 's12r' ] + wynagr_g
            ELSE
               aDane[ 's12' ] := aDane[ 's12' ] + wynagr_g
            ENDIF
            lRob := .T.
         ENDIF
         IF wydatki <> 0 .AND. lRobK
            aPoz[ 'R' ] := 'k'
            IF Left( numer, 3 ) == 'RZ-'
               aDane[ 's13r' ] := aDane[ 's13r' ] + wydatki
            ELSE
               aDane[ 's13' ] := aDane[ 's13' ] + wydatki
            ENDIF
            lRob := .T.
         ENDIF
         aPoz[ 'nr' ] := AllTrim( numer )
         aPoz[ 'znumer' ] := numer

         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         IF Left( numer, 1 )#Chr( 1 ) .AND. Left( numer, 1 )#Chr( 254 )
            aDane[ 'sp' ] := aDane[ 'sp' ] + aPoz[ 'przychod' ]
            aDane[ 'sr' ] := aDane[ 'sr' ] + aPoz[ 'rozchod' ]
         ENDIF

         IF lRob
            AAdd( aWiersze, aPoz )
         ENDIF

         SKIP

      ENDDO

      DO CASE
      CASE nGrafText == 1

         aSumP := {}
         aSumR := {}
         IF lRobS
            aPoz := {=>}
            aPoz[ 'nazwa' ] := 's - sprzeda¾ towar¢w i usˆug'
            aPoz[ 'kol' ] := 7
            aPoz[ 'wartosc' ] := aDane[ 's7' ]
            AAdd( aSumP, aPoz )
         ENDIF
         IF lRobI
            aPoz := {=>}
            aPoz[ 'nazwa' ] := 'i - inne przychody'
            aPoz[ 'kol' ] := 8
            aPoz[ 'wartosc' ] := aDane[ 's8' ]
            AAdd( aSumP, aPoz )
         ENDIF
         IF lRobZ
            aPoz := {=>}
            aPoz[ 'nazwa' ] := 'z - zakup towar¢w i materiaˆ¢w'
            aPoz[ 'kol' ] := 10
            aPoz[ 'wartosc_k' ] := aDane[ 's10' ]
            aPoz[ 'wartosc_r' ] := aDane[ 's10r' ]
            AAdd( aSumR, aPoz )
         ENDIF
         IF lRobU
            aPoz := {=>}
            aPoz[ 'nazwa' ] := 'u - uboczne koszty zakupu'
            aPoz[ 'kol' ] := 11
            aPoz[ 'wartosc_k' ] := aDane[ 's11' ]
            aPoz[ 'wartosc_r' ] := aDane[ 's11r' ]
            AAdd( aSumR, aPoz )
         ENDIF
         IF lRobW
            aPoz := {=>}
            aPoz[ 'nazwa' ] := 'w - wynagrodzenia'
            aPoz[ 'kol' ] := 12
            aPoz[ 'wartosc_k' ] := aDane[ 's12' ]
            aPoz[ 'wartosc_r' ] := aDane[ 's12r' ]
            AAdd( aSumR, aPoz )
         ENDIF
         IF lRobK
            aPoz := {=>}
            aPoz[ 'nazwa' ] := 'k - koszty pozostaˆe'
            aPoz[ 'kol' ] := 13
            aPoz[ 'wartosc_k' ] := aDane[ 's13' ]
            aPoz[ 'wartosc_r' ] := aDane[ 's13r' ]
            AAdd( aSumR, aPoz )
         ENDIF
         aDane[ 'wiersze' ] := aWiersze
         aDane[ 'sump' ] := aSumP
         aDane[ 'sumr' ] := aSumR
         FRDrukuj( 'frf\wykaz13.frf' , aDane )

      CASE nGrafText == 2

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
         FOR i := 1 TO Len( aWiersze )

            *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@

            k1 := aWiersze[ i ][ 'k1' ]
            k2 := aWiersze[ i ][ 'k2' ]
            k3 := aWiersze[ i ][ 'k3' ]
            k4 := aWiersze[ i ][ 'k4' ]
            K5 := aWiersze[ i ][ 'k5' ]
            K6 := aWiersze[ i ][ 'k6' ]
            P := aWiersze[ i ][ 'P' ]
            R := aWiersze[ i ][ 'R' ]
            znumer := aWiersze[ i ][ 'znumer' ]

            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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

            mon_drk( ' ' + k1 + '  ' + k2 + '  ' + k3 + ' ' + k4 + ' ' + k5 + P + k6 + R )

            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            _numer := 0
            _grupa := .F.
         NEXT

         s0_5 := aDane[ 'sp' ]
         s0_6 := aDane[ 'sr' ]
         SS := aDane[ 's7' ]
         SI := aDane[ 's8' ]
         SZ := aDane[ 's10' ]
         SZr := aDane[ 's10r' ]
         SU := aDane[ 's11' ]
         SUr := aDane[ 's11r' ]
         SW := aDane[ 's12' ]
         SWr := aDane[ 's12r' ]
         SK := aDane[ 's13' ]
         SKr := aDane[ 's13r' ]

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
         mon_drk( 'ş' )
      ENDCASE

   END

   IF _czy_close
      close_()
   ENDIF

   RETURN NIL