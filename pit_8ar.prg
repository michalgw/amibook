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

PROCEDURE Pit_8AR( _G, _M, _STR, _OU )

   PRIVATE P3, P4, P4r, P6, P6k
   PRIVATE P1, P16, P17, P18, P19, p17a
   PRIVATE P20, P21, P22, P23, P24, p46, p47, p48
   PRIVATE P63
   PRIVATE tresc_korekty_pit8ar := '', rodzaj_korekty := 0
   PRIVATE aPit48Covid := { .F., .F., .F., .F., .F., .F., .F., .F., .F., .F., .F., .F. }

   RAPORT := RAPTEMP
   zDEKLKOR := 'D'
   STORE 0 TO P29, P30, P31, p32, p33, p34, p35
   STORE '' TO P3, P4, P4r, P6, P1, P16, P17, P18, P19, P20, p17a, P6k
   STORE '' TO P21, P24
   rRPIC4 := '@E     999   '
   rRPIC1 := '@E  999 999  '
   czekaj()
   _czy_close := .F.
   *#################################     PIT_8AR    #############################
   BEGIN SEQUENCE
      SELECT 10
      IF Dostep( 'PRAC_HZ' )
         SetInd( 'PRAC_HZ' )
      ELSE
         BREAK
      ENDIF

      SELECT 9
      IF DostepEx( 'TABPIT8R' )
         ZAP
         INDEX ON del + firma + mc TO TABPIT8R
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
         SetInd( 'PRAC' )
         //SET INDEX TO prac3
         SET ORDER TO 4
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
         P8r  :=  SubStr( NR_REGON, 3, 9 )
         SELECT urzedy
         IF FIRMA->skarb > 0
            GO FIRMA->skarb
            P6 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
            P6k  :=  AllTrim( kodurzedu )
         ELSE
            P6 := Space( 60 )
            P6k := ''
         ENDIF
         IF p6k == ''
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
               P6k  :=  AllTrim( kodurzedu )
            ELSE
               P6 := Space( 60 )
            ENDIF
         ELSE
            P8 := Space( 60 )
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

      FOR xxm := 1 TO 12
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
         pc11 := 0
         xxmiesiac := Str( xxm, 2 )
         SELECT etaty
         idprac := 'BRAK'
         seek '+' + ident_fir
         DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir
            SELECT prac
            SEEK Val( etaty->ident )
            SELECT etaty
            STORE .F. TO DOD
            STORE .T. TO DDO

            DOD := Prac_HZ_Aktywny( Val( xxmiesiac ) )

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
            CASE TYTUL = '8'
               pc10 := pc10 + podatek
            CASE TYTUL = '10'
               pc11 := pc11 + podatek
            ENDCASE
            SKIP 1
         ENDDO

         SELECT TABPIT8R
         SEEK '+' + ident_fir + xxmiesiac
         IF .NOT. Found()
            dopap()
            repl_( 'del', '+' )
            repl_( 'firma', ident_fir )
            repl_( 'mc', xxmiesiac )
         ENDIF
         repl_( 'Zlecrycz', pc10 )
         repl_( 'nalzal', pc11 )
         COMMIT
         UNLOCK
         SELECT etaty
      NEXT

      ColStd()
      @ 24, 0 CLEAR

      IF _STR == 1
         PIT8RTAB( miesiac )
      ENDIF

      FOR xxm := 1 TO 12
         xxmiesiac := Str( xxm, 2 )
         SELECT SUMA_MC
         SEEK '+' + ident_fir + xxmiesiac
         IF Found()
            SELECT TABPIT8R
            SEEK '+' + ident_fir + xxmiesiac
            IF .NOT. Found()
               dopap()
               repl_('del', '+' )
               repl_('firma', ident_fir )
               repl_('mc', xxmiesiac )
            ENDIF
            repl_( 'zlecin', suma_mc->P8zlecry )
            repl_( 'zlecinu', suma_mc->P8zlecin )
            repl_( 'potrac', suma_mc->P8potrac )
            COMMIT
            UNLOCK
         ENDIF
      NEXT

      FOR xxxmm := 1 TO 12
         xxm := StrTran( Str( xxxmm, 2 ), ' ', '0' )
         z1&xxm := 0
         z2&xxm := 0
         z3&xxm := 0
         z4&xxm := 0
         z5&xxm := 0
         z6&xxm := 0
      NEXT

      SELECT TABPIT8R
      FOR xxxmm := 1 TO 12
          xxm := Str( xxxmm, 2 )
          SEEK '+' + ident_fir + xxm
          IF Found()
             xxm := StrTran( Str( xxxmm, 2 ), ' ', '0' )
             z1&xxm := zlecin
             z2&xxm := zlecrycz + zlecinu
             z6&xxm := nalzal
             z3&xxm := z1&xxm + z2&xxm + z6&xxm
             z4&xxm := _round( ( potrac / 100 ) * z3&xxm, 0 )
             z5&xxm := z3&xxm - z4&xxm
          ENDIF
      NEXT

      sele 100
      USE &RAPORT VIA "ARRAYRDD"

      DO CASE
      CASE _OU == 'E'
         p_wyplar()
      CASE _OU == 'X'
         IF Pit48_Covid()
           edeklaracja_plik  :=  'PIT_8AR_13_' + normalizujNazwe(AllTrim(symbol_fir)) + '_' + AllTrim(p4r)
           IF ( zCzyKorekta := edekCzyKorekta() ) > 0
              IF zCzyKorekta == 2
                 rodzaj_korekty := edekRodzajKorekty()
                 tresc_korekty_pit8ar  :=  edekOrdZuTrescPobierz('PIT-8AR', Val(ident_fir), 0)
                 zDEKLKOR  :=  'K'
              ENDIF
              IF zDEKLKOR != 'K' .OR. (zDEKLKOR == 'K' .AND. ValType(tresc_korekty_pit8ar) == "C")
                 PRIVATE cWynikXml := ''
                 cWynikXml  :=  edek_pit8ar_13()
                 edekZapiszXml(cWynikXml, edeklaracja_plik, wys_edeklaracja, 'PIT8AR-13', zDEKLKOR == 'K')
              ENDIF
           ENDIF
         ENDIF
      OTHERWISE //_OU='K'
         IF Pit48_Covid()
            DeklPodp( 'T' )
            DeklarDrukuj( 'PIT8AR-13' )
         ENDIF
      ENDCASE
   END
   close_()

   RETURN NIL
