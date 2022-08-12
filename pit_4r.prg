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

PROCEDURE Pit_4R( _G, _M, _STR, _OU )

   PRIVATE P3, P4, P4r, P6, P6k
   PRIVATE P1, P16, P17, P18, P19, p17a
   PRIVATE P20, P21, P22, P23, P24, p46, p47, p48
   PRIVATE P63
   PRIVATE tresc_korekty_pit4r := '', rodzaj_korekty := 0
   PRIVATE aPit48Covid := { .F., .F., .F., .F., .F., .F., .F., .F., .F., .F., .F., .F. }

   RAPORT := RAPTEMP
   zDEKLKOR := 'D'
   store 0 TO P29, P30, P31, p32, p33, p34, p35
   store '' to P3, P4, P4r, P6, P6k, P1, P16, P17, P18, P19, P20, p17a
   store '' to P21, P24
   rRPIC4 := '@E     999   '
   rRPIC1 := '@E  999 999  '
   Czekaj()
   _czy_close := .F.

   *#################################     PIT_4      #############################
   BEGIN SEQUENCE
      SELECT 10
      IF Dostep( 'PRAC_HZ' )
         SetInd( 'PRAC_HZ' )
      ELSE
         BREAK
      ENDIF

      SELECT 9
      IF DostepEx( 'TABPIT4R' )
         ZAP
         INDEX ON del + firma + mc TO TABPIT4R
      ELSE
         BREAK
      ENDIF

      SELECT 8
      IF Dostep( 'SUMA_MC' )
         SET INDEX TO SUMA_MC
         SEEK '+' + ident_fir + miesiac
      ELSE
         BREAK
      ENDIF

      SELECT 7
      IF Dostep( 'UMOWY' )
         SetInd( 'UMOWY' )
         SET ORDER TO 4
         GO TOP
      ELSE
         BREAK
      ENDIF

      SELECT 6
      IF Dostep( 'SPOLKA' )
         SetInd( 'SPOLKA' )
         SEEK '+' + ident_fir
      ELSE
         BREAK
      ENDIF
      IF del # '+' .OR. firma # ident_fir
         kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ' )
         BREAK
      ENDIF

      SELECT 5
      IF Dostep( 'URZEDY' )
         SetInd( 'URZEDY' )
      ELSE
         BREAK
      ENDIF

      SELECT 4
      IF Dostep( 'ETATY' )
         SetInd( 'ETATY' )
      ELSE
         BREAK
      ENDIF

      SELECT 3
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
         spolka_ := spolka
      ELSE
         BREAK
      ENDIF
      P1 := nip

      SELECT 2
      IF Dostep( 'PRAC' )
         SET INDEX TO prac3
      ELSE
         BREAK
      ENDIF

      zDEKLNAZWI := C->DEKLNAZWI
      zDEKLIMIE := C->DEKLIMIE
      zDEKLTEL := C->DEKLTEL

      P3 := rozrzut( miesiac )
      P4 := rozrzut( param_rok )
      P4r := param_rok
      IF spolka_
         SELECT firma
         P8 := AllTrim( nazwa ) + ' , ' + SubStr( NR_REGON, 3, 9 )
         P8a := AllTrim( nazwa ) + ' , ' + SubStr( NR_REGON, 3, 9 )
         P8n  :=  AllTrim( nazwa )
         P8r  :=  AllTrim( SubStr( NR_REGON, 3, 9 ) )
         SELECT urzedy
         IF FIRMA->skarb > 0
            GO FIRMA->skarb
            P6 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
            P6k := AllTrim( kodurzedu )
         ELSE
            P6 := space( 60 )
            Komunikat( "Prosz© uzupeˆni† kod urz©du skarbowego." )
            BREAK
         ENDIF
      ELSE
         SELECT spolka
         SEEK '+' + ident_fir + firma->nazwisko
         IF Found()
            P8 := AllTrim( naz_imie ) + ' , ' + DToC( data_ur )
            P8n := AllTrim( naz_imie )
            P8d := data_ur
            SELECT urzedy
            IF SPOLKA->skarb>0
               GO SPOLKA->skarb
               P6 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
               P6k := AllTrim( kodurzedu )
            ELSE
               P6 := space( 60 )
               Komunikat( "Prosz© uzupeˆni† kod urz©du skarbowego." )
               BREAK
            ENDIF
            IF P6k == ''
               Komunikat( "Prosz© uzupeˆni† kod urz©du skarbowego." )
               BREAK
            ENDIF
         ELSE
            P8 := space( 60 )
            Komunikat( "Prosz© wybra† nazwisko peˆnomocnika lub wˆa˜ciciela w informacji o firmie." )
            BREAK
         ENDIF
      ENDIF
      IF spolka_
         SELECT firma
         P16 := tlx
         P17 := param_woj
         p17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := nr_domu
         P21 := nr_mieszk
         P22 := miejsc
         P23 := kod_p
         P24 := poczta
      ELSE
         SELECT spolka
         P16 := kraj
         P17 := param_woj
         p17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := nr_domu
         P21 := nr_mieszk
         P22 := miejsc_zam
         P23 := kod_poczt
         P24 := poczta
      ENDIF
      p46 := 0
      p47 := 0
      p48 := 0

      for xxm := 1 to 12
         P29 := 0
         P30 := 0
         P31 := 0
         p63 := 0
         pc2 := 0
         pc4 := 0
         pc5 := 0
         pc6 := 0
         pc7 := 0
         pc8 := 0
         pc9 := 0
         pc10 := 0
         xxmiesiac := Str( xxm, 2 )
         SELECT etaty
         idprac := 'BRAK'
         SEEK '+' + ident_fir
         DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir
            SELECT prac
            SEEK Val( etaty->ident )
            SELECT etaty
            STORE .F. TO DOD
            STORE .T. TO DDO

            DOD := Prac_HZ_Aktywny( Val( xxmiesiac ) ) .AND. prac->status <> 'Z'

            /*
            IF .NOT. Empty( PRAC->DATA_PRZY )
               DOD := SubStr( DToS( PRAC->DATA_PRZY ), 1, 6 ) <= param_rok + StrTran( xxmiesiac, ' ', '0' )
            ENDIF
            IF .NOT. Empty( PRAC->DATA_ZWOL )
               DDO := SubStr( DToS( PRAC->DATA_ZWOL ), 1, 6 ) >= param_rok + StrTran( xxmiesiac, ' ', '0' )
            ENDIF
            */

            IF DO_WYPLATY <> 0.0 .OR. ( BRUT_RAZEM - WAR_PSUM ) <> 0.0 .OR. PODATEK <> 0.0 .OR. ( DOD .AND. DDO )
               IF mc = xxmiesiac .AND. IDPRAC <> IDENT
                  P29++
                  IDPRAC := IDENT
               ENDIF
               IF DO_PIT4 == StrTran( param_rok + xxmiesiac, ' ', '0' )
                  P30 := P30 + ( BRUT_RAZEM - WAR_PSUM )
                  P31 := P31 + PODATEK
                  P63 := P63 + ZUS_PODAT
               ENDIF
            ENDIF
            IF mc = xxmiesiac
               pc4 := pc4 + PIT4RC4
               pc5 := pc5 + PIT4RC5
               pc6 := pc6 + PIT4RC6
               pc7 := pc7 + PIT4RC7
               pc8 := pc8 + PIT4RC8
            ENDIF
            SKIP 1
         ENDDO

         SELECT umowy
         SEEK '+' + ident_fir + StrTran( param_rok + xxmiesiac, ' ', '0' )
         DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir .AND. SubStr( DToS( data_wyp ), 1, 6 ) = StrTran( param_rok + xxmiesiac, ' ', '0' )
            DO CASE
            CASE TYTUL = '1'
               pc9 := pc9 + podatek
            CASE TYTUL = '2' .OR. TYTUL = '3' .OR. TYTUL = '4'
               pc2 := pc2 + podatek
            CASE TYTUL='8'
               zmienna := 1
            CASE TYTUL = '10'
               // nic bo to obcokrajowcy i idzie do pit-8ar
            OTHERWISE
               pc10 := pc10 + podatek
            ENDCASE
            SKIP 1
         ENDDO

         SELECT TABPIT4R
         SEEK '+' + ident_fir + xxmiesiac
         IF .NOT. Found()
            dopap()
            repl_( 'del', '+' )
            repl_( 'firma', ident_fir )
            repl_( 'mc', xxmiesiac )
         ENDIF
         repl_( 'ilpod', P29 )
         repl_( 'nalzal', P31 + p63 )
         repl_( 'nalzal33', pc2 )
         repl_( 'ogrzal', pc4 )
         repl_( 'ogrzal32', pc5 )
         repl_( 'dodzal', pc6 )
         repl_( 'nadzwr', pc7 )
         repl_( 'pfron', pc8 )
         repl_( 'aktyw', pc9 )
         repl_( 'zal13', pc10 )
         COMMIT
         UNLOCK
         SELECT etaty
      NEXT

      ColStd()
      @ 24, 0 CLEAR

      IF _STR == 1
         PIT4RTAB( miesiac )
      ENDIF

      FOR xxm := 1 TO 12
         xxmiesiac := Str( xxm, 2 )
         SELECT SUMA_MC
         SEEK '+' + ident_fir + xxmiesiac
         IF Found()
            SELECT TABPIT4R
            SEEK '+' + ident_fir + xxmiesiac
            IF .NOT. Found()
               dopap()
               repl_( 'del', '+' )
               repl_( 'firma', ident_fir )
               repl_( 'mc', xxmiesiac )
            ENDIF
            repl_( 'ilpodu', suma_mc->P4il_pod )
            repl_( 'nalzalu', suma_mc->P4sum_zal )
            repl_( 'nalzal33u', suma_mc->P4nalzal33 )
            repl_( 'ogrzalu', suma_mc->P4ogrzal )
            repl_( 'ogrzal32u', suma_mc->P4ogrzal33 )
            repl_( 'dodzalu', suma_mc->P4dodzal )
            repl_( 'nadzwru', suma_mc->P4nadzwr )
            repl_( 'pfronu', suma_mc->P4pfron )
            repl_( 'aktywu', suma_mc->P4aktyw )
            repl_( 'zal13u', suma_mc->P4zal13 )
            repl_( 'wynagr', suma_mc->P4potrac )
            COMMIT
            UNLOCK
         ENDIF
      NEXT

      FOR xxxmm := 1 TO 12
          xxm := StrTran( Str( xxxmm, 2 ), ' ', '0' )
          z1a&xxm := 0
          z1b&xxm := 0
          z2&xxm := 0
          z3&xxm := 0
          z4&xxm := 0
          z5&xxm := 0
          z6&xxm := 0
          z7&xxm := 0
          z8&xxm := 0
          z9&xxm := 0
          z10&xxm := 0
          z11&xxm := 0
          z12&xxm := 0
          z13&xxm := 0
      NEXT

      SELECT TABPIT4R
      FOR xxxmm := 1 TO 12
          xxm := Str( xxxmm, 2 )
          SEEK '+' + ident_fir + xxm
          IF Found()
             xxm := StrTran( Str( xxxmm, 2 ), ' ', '0' )
             z1a&xxm := Ilpod + Ilpodu
             z1b&xxm := Nalzal + Nalzalu
             z2&xxm := Nalzal33 + Nalzal33u
             z4&xxm := Ogrzal + Ogrzalu
             z5&xxm := Ogrzal32 + Ogrzal32u
             z6&xxm := Dodzal + Dodzalu
             z7&xxm := Nadzwr + Nadzwru
             z8&xxm := PFRON + PFRONu
             z9&xxm := Aktyw + Aktywu
             z10&xxm := Zal13 + Zal13u
             z3&xxm := z1b&xxm + z2&xxm + z10&xxm + z9&xxm
             z11&xxm := Max( 0,( z3&xxm + z5&xxm + z6&xxm ) - ( z4&xxm + z8&xxm ) )
             z12&xxm := _round( z11&xxm * ( Wynagr / 100 ), 0 )
             z13&xxm := _round( Max( 0, z11&xxm - z12&xxm ), 0 )
          ENDIF
      NEXT

      SELECT 100
      USE &RAPORT VIA "ARRAYRDD"
      DO CASE
      CASE _OU == 'E'
         p_wypla()
      CASE _OU == 'X'
         IF Pit48_Covid()
           edeklaracja_plik := 'PIT_4R_12_' + normalizujNazwe(AllTrim(symbol_fir)) + '_' + AllTrim(p4r)
           IF ( zCzyKorekta := edekCzyKorekta() ) > 0
              IF zCzyKorekta == 2
                 rodzaj_korekty := edekRodzajKorekty()
                 tresc_korekty_pit4r  :=  edekOrdZuTrescPobierz('PIT-4R', Val(ident_fir), 0)
                 zDEKLKOR := 'K'
              ENDIF
              IF zDEKLKOR != 'K' .OR. (zDEKLKOR == 'K' .AND. ValType(tresc_korekty_pit4r) == "C")
                 private danedekl
                 danedekl := edek_pit4r_12()
                 edekZapiszXml(danedekl, edeklaracja_plik, wys_edeklaracja, 'PIT4R-12', zDEKLKOR == 'K')
              ENDIF
           ENDIF
         ENDIF
      OTHERWISE //_OU='K'
         IF Pit48_Covid()
           DeklPodp( 'T' )
           DeklarDrukuj( 'PIT4R-12' )
         ENDIF
      ENDCASE
   END
   close_()

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Pit48_Covid()

   LOCAL lRes := .F., cEkran, cKolor := ColStd(), nI
   LOCAL cCovid1, cCovid2, cCovid3, cCovid4, cCovid5, cCovid6, cCovid7, cCovid8, cCovid9, cCovid10, cCovid11, cCovid12
   LOCAL bOdswierzTN := { | nEl |
      LOCAL lWart, cKolor := SetColor()
      DO CASE
      CASE nEl == 1
         lWart := cCovid1 == 'T'
      CASE nEl == 2
         lWart := cCovid2 == 'T'
      CASE nEl == 3
         lWart := cCovid3 == 'T'
      CASE nEl == 4
         lWart := cCovid4 == 'T'
      CASE nEl == 5
         lWart := cCovid5 == 'T'
      CASE nEl == 6
         lWart := cCovid6 == 'T'
      CASE nEl == 7
         lWart := cCovid7 == 'T'
      CASE nEl == 8
         lWart := cCovid8 == 'T'
      CASE nEl == 9
         lWart := cCovid9 == 'T'
      CASE nEl == 10
         lWart := cCovid10 == 'T'
      CASE nEl == 11
         lWart := cCovid11 == 'T'
      CASE nEl == 12
         lWart := cCovid12 == 'T'
      ENDCASE
      SET COLOR TO w+
      @ 8 + nEl, 43 SAY iif( lWart, 'ak', 'ie' )
      SetColor( cKolor )
      RETURN .T.
   }

   SAVE SCREEN TO cEkran

   cCovid1 := iif( aPit48Covid[ 1 ], 'T', 'N' )
   cCovid2 := iif( aPit48Covid[ 2 ], 'T', 'N' )
   cCovid3 := iif( aPit48Covid[ 3 ], 'T', 'N' )
   cCovid4 := iif( aPit48Covid[ 4 ], 'T', 'N' )
   cCovid5 := iif( aPit48Covid[ 5 ], 'T', 'N' )
   cCovid6 := iif( aPit48Covid[ 6 ], 'T', 'N' )
   cCovid7 := iif( aPit48Covid[ 7 ], 'T', 'N' )
   cCovid8 := iif( aPit48Covid[ 8 ], 'T', 'N' )
   cCovid9 := iif( aPit48Covid[ 9 ], 'T', 'N' )
   cCovid10 := iif( aPit48Covid[ 10 ], 'T', 'N' )
   cCovid11 := iif( aPit48Covid[ 11 ], 'T', 'N' )
   cCovid12 := iif( aPit48Covid[ 12 ], 'T', 'N' )

   @  6, 15 CLEAR TO 21, 64
   @  6, 15 TO 21, 64
   @  7, 16 SAY "  COVID-19 - Przesuni©cie terminu przekazania"
   @  8, 16 SAY " zrycz. podatku pobranego za poni¾sze miesi¥ce"
   @  9, 17 SAY "                      I." GET cCovid1 PICTURE '!' VALID cCovid1 $ 'TN' .AND. Eval( bOdswierzTN, 1 )
   @ 10, 17 SAY "                     II." GET cCovid2 PICTURE '!' VALID cCovid2 $ 'TN' .AND. Eval( bOdswierzTN, 2 )
   @ 11, 17 SAY "                    III." GET cCovid3 PICTURE '!' VALID cCovid3 $ 'TN' .AND. Eval( bOdswierzTN, 3 )
   @ 12, 17 SAY "                     IV." GET cCovid4 PICTURE '!' VALID cCovid4 $ 'TN' .AND. Eval( bOdswierzTN, 4 )
   @ 13, 17 SAY "                      V." GET cCovid5 PICTURE '!' VALID cCovid5 $ 'TN' .AND. Eval( bOdswierzTN, 5 )
   @ 14, 17 SAY "                     VI." GET cCovid6 PICTURE '!' VALID cCovid6 $ 'TN' .AND. Eval( bOdswierzTN, 6 )
   @ 15, 17 SAY "                    VII." GET cCovid7 PICTURE '!' VALID cCovid7 $ 'TN' .AND. Eval( bOdswierzTN, 7 )
   @ 16, 17 SAY "                   VIII." GET cCovid8 PICTURE '!' VALID cCovid8 $ 'TN' .AND. Eval( bOdswierzTN, 8 )
   @ 17, 17 SAY "                     IX." GET cCovid9 PICTURE '!' VALID cCovid9 $ 'TN' .AND. Eval( bOdswierzTN, 9 )
   @ 18, 17 SAY "                      X." GET cCovid10 PICTURE '!' VALID cCovid10 $ 'TN' .AND. Eval( bOdswierzTN, 10 )
   @ 19, 17 SAY "                     XI." GET cCovid11 PICTURE '!' VALID cCovid11 $ 'TN' .AND. Eval( bOdswierzTN, 11 )
   @ 20, 17 SAY "                    XII." GET cCovid12 PICTURE '!' VALID cCovid12 $ 'TN' .AND. Eval( bOdswierzTN, 12 )

   FOR nI := 1 TO 12
      Eval( bOdswierzTN, nI )
   NEXT

   read_()

   IF LastKey() <> 27
      aPit48Covid[ 1 ] := cCovid1 == 'T'
      aPit48Covid[ 2 ] := cCovid2 == 'T'
      aPit48Covid[ 3 ] := cCovid3 == 'T'
      aPit48Covid[ 4 ] := cCovid4 == 'T'
      aPit48Covid[ 5 ] := cCovid5 == 'T'
      aPit48Covid[ 6 ] := cCovid6 == 'T'
      aPit48Covid[ 7 ] := cCovid7 == 'T'
      aPit48Covid[ 8 ] := cCovid8 == 'T'
      aPit48Covid[ 9 ] := cCovid9 == 'T'
      aPit48Covid[ 10 ] := cCovid10 == 'T'
      aPit48Covid[ 11 ] := cCovid11 == 'T'
      aPit48Covid[ 12 ] := cCovid12 == 'T'
      lRes := .T.
   ENDIF

   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN lRes

/*----------------------------------------------------------------------*/
