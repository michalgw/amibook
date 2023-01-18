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

PROCEDURE Pit_811( _G, _M, _STR, _OU )

   RAPORT := RAPTEMP

   PRIVATE P4,P4d,P5,P6,P6_kod,p7,p8,p8n,p8r,p8d,p9,p10
   PRIVATE P1,P1s,P11,P12,P13,P14,P15,P16,P17,P18,P19
   PRIVATE P20,P21,P22,P23,P24,DP28,DP10 := 'T'
   PRIVATE tresc_korekty_pit11 := '', id_pracownika, DP28Scr
   PRIVATE P_KrajID, P_DokIDTyp, P_DokIDNr, P_18Kraj, cIgnoruj26r := 'N'
   PRIVATE SklZdrow, RodzajUlgi := 'N'

   STORE 0 TO P29,P30,P31, SklZdrow
   STORE '' TO P3,P4,P4d,P6,P1,P11,P12,P13,P15,P16,P17,P18,P19,P20
   STORE '' TO P21

   _czy_close := .F.
   spolka_ := .F.

   *do &formproc with _dr_gr,_dr_lm,formstro,'D'
   *#################################     PIT_11/8B      #############################
   BEGIN SEQUENCE
      SAVE SCREEN TO ROBPISC
      Czekaj()

      SELECT 20
      IF DostepEx( 'DATYUM' )
         *set inde to datyum
         ZAP
         INDEX ON DToS( DATA ) + TYP TO DATYUM
      ELSE
         BREAK
      ENDIF
      *use
      *if dostep('DATYUM')
      *   set inde to datyum
      *else
      *   break
      *endif

      SELECT prac
      *idpr=str(recno(),5)
      idpr := Str( rec_no, 5 )

      //id_pracownika := RecNo()
      id_pracownika := prac->id

      IF DToS( data_przy ) <> Space( 8 )
         zdataprzy := data_przy
         SELECT 20
         DOPAP()
         BLOKADAR()
         repl_( 'DATA', zdataprzy )
         repl_( 'TYP', 'P' )
         *commit_()
         COMMIT
         UNLOCK
         SELECT prac
      ELSE
         zdataprzy := CToD( '3000.12.31' )
      ENDIF

      IF DToS( data_zwol ) <> Space( 8 )
         zdatazwol := data_zwol
         SELECT 20
         DOPAP()
         BLOKADAR()
         repl_( 'DATA', zdatazwol )
         repl_( 'TYP', 'Z' )
         *commit_()
         COMMIT
         UNLOCK
         SELECT prac
      ELSE
         zdatazwol := data_zwol
      ENDIF

      SELECT umowy
      INDEX ON del+firma+ident+DToS(data_wyp) TO &raptemp
      SEEK '+' + ident_fir + idpr + param_rok
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir .AND. ident = idpr .AND. SubStr( DToS( data_wyp ), 1, 4 ) = param_rok
         IF TYTUL <> '8 '
            SELECT 20
            DOPAP()
            BLOKADAR()
            repl_( 'DATA', umowy->data_wyp )
            repl_( 'TYP', 'U' )
            *commit_()
            COMMIT
            UNLOCK
            SELECT umowy
         ENDIF
         SKIP
      ENDDO

      SELECT 20
      commit_()
      COUNT TO ILR ALL

      RESTORE SCREEN FROM ROBPISC
      SAVE SCREEN TO ROBPISC

      LGwie := 3
      LGkol := 1
      @ LGwie, LGkol CLEAR TO LGwie + 12 + ILR, 78
      @ LGwie, LGkol TO LGwie + 12 + ILR, 78
      ColInf()
      @ LGwie+1, LGkol + 1  CLEAR TO LGwie+1, 77
      @ LGwie+1, LGkol + 2  SAY 'Etat-poczatek'
      @ LGwie+1, LGkol + 17 SAY 'Inne umowy'
      @ LGwie+1, LGkol + 29 SAY 'Etat-koniec'
      @ LGwie+1, LGkol + 42 SAY 'Komentaz'
      ColStd()
      LINI := LGwie + 2
      GO TOP
      ODKIEDY := CToD( param_rok + '.01.01' )
      DOKIEDY := CToD( param_rok + '.12.31' )
      SET COLOR TO +w
      DO WHILE .NOT. Eof()
         IF TYP = 'P'
            @ LINI, LGkol + 4  SAY DToC( DATA )
         END
         IF TYP = 'U'
            @ LINI, LGkol + 17 SAY DToC( DATA )
            @ LINI, LGkol + 42 SAY 'Data wyplaty innych wyplat '
         END
         IF TYP = 'Z'
            @ LINI, LGkol + 30 SAY DToC( DATA )
         END
         LINI++
         IF LINI >= 16
            EXIT
         ENDIF
         SKIP
      ENDDO
      ColStd()
      LINI++
      SET CONF ON
      @ LINI, LGkol + 2  SAY 'Podaj okres do PIT-11 Od:99.99.9999  Do:99.99.9999'
      @ LINI, LGkol + 27 GET ODKIEDY PICTURE '@D'
      @ LINI, LGkol + 42 GET DOKIEDY PICTURE '@D'
      *read
      read_()
      SET CONF OFF
      IF LastKey() <> 13
         SELECT 20
         USE
         SELECT 1
         BREAK
      ENDIF
      SEEK DToS( ODKIEDY )
      *vPIT8=.f.
      *vPIT11=.f.
      *if (zdatazwol>=ODKIEDY.or.dtos(zdatazwol)==space(8)).and.zdataprzy<=DOKIEDY
      vPIT11 := .T.
      *     endif
      *     do while .not. eof().and. DATA>=ODKIEDY .and. DATA<=DOKIEDY
      *        if TYP='U'
      *           vPIT8=.t.
      *        endif
      *        skip
      *     enddo
      LINI++
      JAKICEL := 'I'
      @ LINI, LGkol + 2 SAY 'Cel zlozenia formularza (zlozenie Informacji/Korekta) :' GET JAKICEL PICTURE '!' VALID JAKICEL$'IK'
      *     NADRUK='PIT-11/8B'
      *     set color to +w
      *     if vPIT11=.t.
      *        @ LINI,LGkol+18 say 'PIT-11.'
      NADRUK := 'PIT-11'
      *     else
      *        @ LINI,LGkol+18 say 'PIT-8B.'
      *        NADRUK='PIT-8B'
      *     endif
      ColStd()
      *     JAKINAD='D'
      zKOR_PRZY := Prac->KOR_PRZY
      zKOR_KOSZ := Prac->KOR_KOSZ
      zKOR_ZALI := Prac->KOR_ZALI
      zKOR_SPOL := Prac->KOR_SPOL
      zKOR_ZDRO := Prac->KOR_ZDRO
      zKOR_SPOLZ := Prac->KOR_SPOLZ
      zKOR_ZDROZ := Prac->KOR_ZDROZ
      zKOR_ZWET := Prac->KOR_ZWET
      zKOR_ZWEM := Prac->KOR_ZWEM
      zKOR_ZWIN := Prac->KOR_ZWIN
      DP28 := '1'
      SET CONF ON
      *     @ LINI,LGkol+58 say 'Drukowa† taki napis czy Wykreslisz (D/W) ?' get JAKINAD pict '!' valid JAKINAD$'DW'
      @ LINI + 1, LGKol + 2 SAY 'Podaj kwoty modyfikuj&_a.ce pola wynagrodze&_n. i sk&_l.adek:'
      @ LINI + 2, LGKol + 2 SAY  'Przy' GET zKOR_PRZY PICTURE '999999.99'
      @ LINI + 2, LGKol + 17 SAY 'Kosz' GET zKOR_KOSZ PICTURE '999999.99'
      @ LINI + 2, LGKol + 32 SAY 'Zali' GET zKOR_ZALI PICTURE '99999.99'
      *      @ LINI+2,LGKol+46 say 'ZUS-76' get zKOR_SPOL pict '99999.99'
      *      @ LINI+2,LGKol+62 say 'ZUS-78' get zKOR_ZDRO pict '99999.99'
      @ LINI + 3, LGKol + 2  SAY 'Zw.(p.32)' GET zKOR_ZWET PICTURE '99999.99'
      @ LINI + 3, LGKol + 20 SAY 'Zw.(p.45)' GET zKOR_ZWEM PICTURE '99999.99'
      @ LINI + 3, LGKol + 38 SAY 'Zw.(p.67)' GET zKOR_ZWIN PICTURE '99999.99'
      @ LINI + 4, LGKol + 2  SAY 'ZUS(p.69)' GET zKOR_SPOL PICTURE '99999.99'
      @ LINI + 4, LGKol + 20 SAY 'ZUS(p.71)' GET zKOR_SPOLZ PICTURE '99999.99'
      @ LINI + 4, LGKol + 38 SAY 'ZUS(p.72)' GET zKOR_ZDRO PICTURE '99999.99'
      @ LINI + 4, LGKol + 56 SAY 'ZUS(p.74)' GET zKOR_ZDROZ PICTURE '99999.99'
      @ LINI + 5, LGKol + 2  SAY 'Informacje o kosztach uzyskania przychodu (sek. D p. 28):' GET DP28 PICT '!' WHEN PIT11_DP28When() VALID PIT11_DP28Valid()
      @ LINI + 6, LGKol + 2  SAY 'Nieograniczony obowi¥zek podatkowy (sek. C p. 10):' GET DP10 PICT '!' VALID DP10 $ 'TN'
      @ LINI + 7, LGKol + 2  SAY 'Wykazuj jako osob© powy¾ej 26 r. ¾ycia (Tak/Nie):' GET cIgnoruj26r PICT '!' VALID cIgnoruj26r $ 'TN'
      read_()
      SET CONF OFF
      IF LastKey() <> 13
         SELECT 20
         USE
         SELECT 1
         BREAK
      ENDIF
      *     if JAKINAD='W'
      *        NADRUK='PIT-11/8B'
      *     endif
      SELECT prac
      blokadar()
      REPLACE KOR_PRZY WITH zKOR_PRZY, KOR_KOSZ WITH zKOR_KOSZ, KOR_ZALI WITH zKOR_ZALI, ;
         KOR_SPOL WITH zKOR_SPOL, KOR_ZDRO WITH zKOR_ZDRO, KOR_SPOLZ WITH zKOR_SPOLZ, KOR_ZDROZ WITH zKOR_ZDROZ, ;
         KOR_ZWET WITH zKOR_ZWET, KOR_ZWEM WITH zKOR_ZWEM, KOR_ZWIN WITH zKOR_ZWIN
      COMMIT
      UNLOCK
      SELECT 20
      USE
      SELECT 1

      *wait
      *      WCLOSE()
      RESTORE SCREEN FROM ROBPISC

      SET DATE GERM
      P4 := rozrzut( DToC( ODKIEDY ) )
      P4d  :=  ODKIEDY
      P5 := rozrzut( DToC( DOKIEDY ) )
      SET DATE ANSI
      SELECT 19
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
         spolka_ := spolka
      ELSE
         BREAK
      ENDIF
      P1 := rozrzut( nip )
      P1s := nip
      zDEKLNAZWI := DEKLNAZWI
      zDEKLIMIE := DEKLIMIE
      zDEKLTEL := DEKLTEL

      SELECT 18
      IF Dostep( 'ORGANY' )
         SET INDEX TO organy
      ELSE
         BREAK
      ENDIF
      SELECT 17
      IF Dostep( 'REJESTRY' )
         SET INDEX TO rejestry
      ELSE
         BREAK
      ENDIF
      SELECT 16
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
      *--------------------------------------
      SELECT urzedy
      IF PRAC->skarb > 0
         GO PRAC->skarb
         P6 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
         P6_kod := AllTrim( kodurzedu )
      ELSE
         P6 := Space( 60 )
         P6_kod := ''
      ENDIF
      IF P6_kod == ''
         Komunikat( "Prosz© uzupeˆni† kod urz©du skarbowego." )
         BREAK
      ENDIF

      IF spolka_
         SELECT firma
         P8 := AllTrim( nazwa )
         P8n := P8
         P9 := nazwa_skr
         P10 := SubStr( nr_regon, 3, 9 )
         SET DATE GERM
         P11 := DToC( data_zal )
         SET DATE ANSI
         P8 := P8 + ', ' + P10
         p8r := P10
      ELSE
         SELECT spolka
         SEEK '+' + ident_fir + firma->nazwisko
         IF Found()
            P8 := AllTrim( naz_imie )
            P8n := P8
            P9 := imie_o + ' , ' + imie_m
            P10 := PESEL
            SET DATE GERM
            P11 := DToC( data_ur )
            P8d := data_ur
            SET DATE ANSI
            P8 := P8 + ', ' + P11
            *  +', '+P10
         ELSE
            P8 := space( 120 )
            P9 := space( 60 )
            P10 := space( 11 )
            P11 := space( 8 )
            Komunikat( "Prosz© wybra† nazwisko peˆnomocnika lub wˆa˜ciciela w informacji o firmie." )
            BREAK
         ENDIF
      ENDIF
      SELECT organy
      IF firma->organ > 0
         GO firma->organ
         P12 := nazwa_org
      ELSE
         P12 := Space( 60 )
      ENDIF
      SELECT rejestry
      IF firma->rejestr > 0
         GO firma->rejestr
         P13 := nazwa_rej
      ELSE
         P13 := Space( 60 )
      ENDIF
      SELECT firma
      SET DATE GERM
      P14 := DToC( data_rej )
      SET DATE ANSI
      P15 := numer_rej
      P16 := 'POLSKA'
      IF spolka_
         SELECT firma
         P17 := param_woj
         p17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := nr_domu
         P21 := nr_mieszk
         P22 := miejsc
         P23 := kod_p
         P24 := poczta
         P25 := skrytka
         P26 := tel
         P27 := tlx
         P28 := fax
      ELSE
         SELECT spolka
         *     go nr_rec
         P17 := param_woj
         p17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := nr_domu
         P21 := nr_mieszk
         P22 := miejsc_zam
         P23 := kod_poczt
         P24 := poczta
         P25 := Space( 5 )
         P26 := telefon
         P27 := ''
         P28 := Space( 10 )
      ENDIF
      SELECT prac
      p20 := PadC( AllTrim( p20 ), 10 )
      p21 := PadC( AllTrim( p21 ), 9 )
      p27 := PadC( AllTrim( p27 ), 25 )
      p29 := nip
      p30 := pesel
      P31 := nazwisko
      P32 := imie1
      P33 := imie2
      P34 := imie_o
      P35 := imie_m
      SET DATE GERM
      P36 := rozrzut( DToC( data_ur ) )
      P36d  :=  data_ur
      SET DATE ANSI
      P37 := 'POLSKA'
      P38 := param_woj
      P38a := param_pow
      P39 := gmina
      P40 := ulica
      P41 := nr_domu
      P42 := nr_mieszk
      P43 := miejsc_zam
      P44 := kod_poczt
      P45 := poczta
      P47 := telefon
      P_KrajID := iif( Len( AllTrim( prac->dokidkraj ) ) == 0, 'PL', prac->dokidkraj )
      P_DokIDTyp := prac->dokidroz
      P_DokIDNr := prac->zagrnrid
      P_18Kraj := iif( prac->dokidkraj == 'PL' .OR. prac->dokidkraj == '  ', 'POLSKA', prac->dokidkraj )
      store 0 to p50,p51,p52,p53,p53a,p54,p54a,p55,;
                 p50z,p51z,p52z,p53z,p53za,p54z,p54za,p55z,;
                 p61,p63,p64,;
                 p75,p76,p78,;
                 p86,p88,;
                 p89,p90,p92,;
                 p93,p94,p96,;
                 p97,p98,p100,;
                 p93,p94,p96,;
                 p101,p102,p103,p104, SklZdrow
      store 0 to p50_1,p51_1,p51a_1,p52_1,p52_1a,p52a_1,p52b_1,p53_1,;
                 p50_5,p51_5,p51a_5,p52_5,p52_5a,p52a_5,p52b_5,p53_5,;
                 p50_6,p51_6,p51a_6,p52_6,p52_6a,p52a_6,p52b_6,p53_6,;
                 p50_7,p51_7,p51a_7,p52_7,p52_7a,p52a_7,p52b_7,p53_7,;
                 p50_8,p51_8,p51a_8,p52_8,p52_8a,p52a_8,p52b_8,p53_8,;
                 p50_0,p51_0,p51a_0,p52_0,p52_0a,p52a_0,p52b_0,p53_0,;
                 p50_2,p51_2,p51a_2,p52_2,p52_2a,p52a_2,p52b_2,p53_2,;
                 p50_3,p51_3,p51a_3,p52_3,p52_3a,p52a_3,p52b_3,p53_3,;
                 p50_4,p51_4,p51a_4,p52_4,p52_4a,p52a_4,p52b_4,p53_4,;
                 p50_9,p51_9,p51a_9,p52_9,p52_9a,p52a_9,p52b_9,p53_9,;
                 p50_11,p51_11,p53_11,p52_11a

      P50_R26 := 0
      P51_R26 := 0
      P52_R26 := 0
      P55_R26 := 0
      P53a_R26 := 0
      P54a_R26 := 0
      P64_R26 := 0

      P50_R262 := 0
      P51_R262 := 0
      P52_R262 := 0
      P55_R262 := 0
      P53a_R262 := 0
      P54a_R262 := 0
      P64_R262 := 0

      P50_5_R26 := 0
      P51_5_R26 := 0
      P53_5_R26 := 0
      P52_5a_R26 := 0
      P52z_R26 := 0
      P54za_R26 := 0

      P50_5_R262 := 0
      P51_5_R262 := 0
      P53_5_R262 := 0
      P52_5a_R262 := 0
      P52z_R262 := 0
      P54za_R262 := 0

      SELECT etaty

      ******* tutaj + mc od do mc do
      ******* tu sie wstrzelic. przeleciec caly rok i sprawdzic DO_PIT4 wg ktorego zaliczyc place
      *************************
      *   seek '+'+ident_fir+idpr+str(month(ODKIEDY),2)
      SEEK '+' + ident_fir + idpr + ' 1'
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir .AND. ident = idpr
         IF do_pit4 >= SubStr( DToS( ODKIEDY ), 1, 6 ) .AND. do_pit4 <= SubStr( DToS( DOKIEDY ), 1, 6 )
            IF  cIgnoruj26r == 'N' /* .AND. SToD( do_pit4 + '01' ) >= 0d20190801 .AND. CzyPracowPonizej26R( Month( SToD( do_pit4 + '01' ) ), Year( SToD( do_pit4 + '01' ) ) ) */
               IF OSWIAD26R $ 'TE'
                  RodzajUlgi := OSWIAD26R
                  P50_R26 := P50_R26 + BRUT_RAZEM - zasi_bzus
                  P51_R26 := P51_R26 + koszt
                  P52_R26 := P52_R26 + war_psum
                  P54a_R26 := P54a_R26 + war_puz // war_puzo
                  P55_R26 := P55_R26 + podatek
                  P64_R26 := P64_R26 + ZUS_RKCH
               ELSE
                  P50_R262 := P50_R262 + BRUT_RAZEM - zasi_bzus
                  P51_R262 := P51_R262 + koszt
                  P52_R262 := P52_R262 + war_psum
                  P54a_R262 := P54a_R262 + war_puzo
                  P55_R262 := P55_R262 + podatek
                  P64_R262 := P64_R262 + ZUS_RKCH
               ENDIF
            ELSE
               P50 := P50 + BRUT_RAZEM - zasi_bzus + PPKPPM
               P51 := P51 + koszt
               P52 := P52 + war_psum
               p54a := p54a + war_puzo
               P55 := P55 + podatek
               P64 := P64 + ZUS_RKCH
            ENDIF
            P54 := P54 + war_puz
            P53 := P53 + dochod
            p61 := p61 + ZUS_ZASCHO
            p63 := p63 + ZUS_PODAT
            P50_7 := P50_7 + zasi_bzus
            SklZdrow := SklZdrow + war_puz
         ENDIF
         SKIP 1
      ENDDO
      *  P53a=P53a+max(0,BRUT_RAZEM-koszt)
      P50 := P50 + zKOR_PRZY
      P51 := P51 + zKOR_KOSZ
      P55 := P55 + zKOR_ZALI
      P52 := P52 + zKOR_SPOL
      P54a := P54a + zKOR_ZDRO
      P53a := Max( 0, P50 - P51 )

//      P50_R26 := P50_R26 + zKOR_PRZY
//      P51_R26 := P51_R26 + zKOR_KOSZ
//      P55_R26 := P55_R26 + zKOR_ZALI
      P53a_R26 := Max( 0, P50_R26 - P51_R26 )
//      P54a_R26 := P54a_R26 + zKOR_ZDRO

//      P50_R262 := P50_R262 + zKOR_PRZY
//      P51_R262 := P51_R262 + zKOR_KOSZ
//      P55_R262 := P55_R262 + zKOR_ZALI
      P53a_R262 := Max( 0, P50_R262 - P51_R262 )
//      P54a_R262 := P54a_R262 + zKOR_ZDRO

      SELECT umowy
      *   index on del+firma+ident+dtos(data_wyp) to &raptemp
      SEEK '+' + ident_fir + idpr + SubStr( DToS( ODKIEDY ), 1, 6 )
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir .AND. ident = idpr .AND. ( SubStr( DToS( data_wyp ), 1, 6 ) >= SubStr( DToS( ODKIEDY ), 1, 6 ) .AND. SubStr( DToS( data_wyp ), 1, 6 ) <= SubStr( DToS( DOKIEDY ), 1, 6 ) )
         IF TYTUL <> '8 '
            DO CASE
            CASE TYTUL = '0'
               P50_0 := P50_0 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
               P51_0 := P51_0 + koszt
               P51a_0 := P51a_0 + war_psum
               P52_0 := P52_0 + dochod
               P52_0a := P52_0a + Max( 0, BRUT_RAZEM - koszt - ZASI_BZUS + PPKPPM )
               P52a_0 := P52a_0 + war_puz
               P52b_0 := P52b_0 + war_puzo
               P53_0 := P53_0 + podatek
            CASE TYTUL = '1'
               P50_1 := P50_1 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
               P51_1 := P51_1 + koszt
               P51a_1 := P51a_1 + war_psum
               P52_1 := P52_1 + dochod
               P52_1a := P52_1a + Max( 0, BRUT_RAZEM - koszt - ZASI_BZUS + PPKPPM )
               P52a_1 := P52a_1 + war_puz
               P52b_1 := P52b_1 + war_puzo
               P53_1 := P53_1 + podatek
            CASE TYTUL = '2'
               P50_2 := P50_2 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
               P51_2 := P51_2 + koszt
               P51a_2 := P51a_2 + war_psum
               P52_2 := P52_2 + dochod
               *        P52_2a=P52_2a+max(0,BRUT_RAZEM-koszt)
               P52a_2 := P52a_2 + war_puz
               P52b_2 := P52b_2 + war_puzo
               P53_2 := P53_2 + podatek
            CASE TYTUL = '3'
               P50_3 := P50_3 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
               P51_3 := P51_3 + koszt
               P51a_3 := P51a_3 + war_psum
               P52_3 := P52_3 + dochod
               *        P52_3a=P52_3a+max(0,BRUT_RAZEM-koszt)
               P52a_3 := P52a_3 + war_puz
               P52b_3 := P52b_3 + war_puzo
               P53_3 := P53_3 + podatek
            CASE TYTUL = '4'
               P50_4 := P50_4 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
               P51_4 := P51_4 + koszt
               P51a_4 := P51a_4 + war_psum
               P52_4 := P52_4 + dochod
               *        P52_4a=P52_4a+max(0,BRUT_RAZEM-koszt)
               P52a_4 := P52a_4 + war_puz
               P52b_4 := P52b_4 + war_puzo
               P53_4 := P53_4 + podatek
            CASE TYTUL = '9'
               P50_9 := P50_9 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
               P51_9 := P51_9 + koszt
               P51a_9 := P51a_9 + war_psum
               P52_9 := P52_9 + dochod
               P52_9a := P52_9a + Max( 0, BRUT_RAZEM - koszt - ZASI_BZUS + PPKPPM )
               P52a_9 := P52a_9 + war_puz
               P52b_9 := P52b_9 + war_puzo
               P53_9 := P53_9 + podatek
            CASE TYTUL = '6'
               P50_6 := P50_6 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
               P51_6 := P51_6 + koszt
               P51a_6 := P51a_6 + war_psum
               P52_6 := P52_6 + dochod
               *        P52_6a=P52_6a+max(0,BRUT_RAZEM-koszt)
               P52a_6 := P52a_6 + war_puz
               P52b_6 := P52b_6 + war_puzo
               P53_6 := P53_6 + podatek
            CASE TYTUL = '7'
               P50_7 := P50_7 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
               P51_7 := P51_7 + koszt
               P51a_7 := P51a_7 + war_psum
               P52_7 := P52_7 + dochod
               *        P52_7a=P52_7a+max(0,BRUT_RAZEM-koszt)
               P52a_7=P52a_7 + war_puz
               P52b_7 := P52b_7 + war_puzo
               P53_7 := P53_7 + podatek
               *     case TYTUL='8'
               *        P50_8=P50_8+BRUT_RAZEM
               *        P51_8=P51_8+koszt
               *        P51a_8=P51a_8+war_psum
               *        P52_8=P52_8+dochod
               *        P52_8a=P52_8a+max(0,BRUT_RAZEM-koszt)
               *        P52a_8=P52a_8+war_puz
               *        P52b_8=P52b_8+war_puzo
               *        P53_8=P53_8+podatek
            OTHERWISE
               IF cIgnoruj26r == 'N' /* .AND. data_wyp >= 0d20190801 .AND. CzyPracowPonizej26R( Month( data_wyp ), Year( data_wyp ) ) */
                  IF OSWIAD26R $ 'TE'
                     RodzajUlgi := OSWIAD26R
                     P50_5_R26 := P50_5_R26 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
                     P51_5_R26 := P51_5_R26 + koszt
                     P53_5_R26 := P53_5_R26 + podatek
                  ELSE
                     P50_5_R262 := P50_5_R262 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
                     P51_5_R262 := P51_5_R262 + koszt
                     P53_5_R262 := P53_5_R262 + podatek
                  ENDIF
               ELSE
                  IF TYTUL == '11'
                     P50_11 := P50_11 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
                     P51_11 := P51_11 + koszt
                     P53_11 := P53_11 + podatek
                  ELSE
                     P50_5 := P50_5 + BRUT_RAZEM - ZASI_BZUS + PPKPPM
                     P51_5 := P51_5 + koszt
                     P53_5 := P53_5 + podatek
                  ENDIF
               ENDIF
               P51a_5 := P51a_5 + war_psum
               P52_5 := P52_5 + dochod
               *        P52_5a=P52_5a+max(0,BRUT_RAZEM-koszt)
               P52a_5 := P52a_5 + war_puz
               P52b_5 := P52b_5 + war_puzo
            ENDCASE
            *     if alltrim(TYTUL)#'1'
            IF cIgnoruj26r == 'N' /* .AND. data_wyp >= 0d20190801 .AND. CzyPracowPonizej26R( Month( data_wyp ), Year( data_wyp ) ) */
               IF OSWIAD26R $ 'TE'
                  RodzajUlgi := OSWIAD26R
                  P52z_R26 := P52z_R26 + war_psum
                  P54za_R26 := P54za_R26 + war_puzo
               ELSE
                  P52z_R262 := P52z_R262 + war_psum
                  P54za_R262 := P54za_R262 + war_puzo
               ENDIF
            ELSE
               P52z := P52z + war_psum
               P54za := P54za + war_puzo
            ENDIF
            P50z := P50z + BRUT_RAZEM - ZASI_BZUS + PPKPPM
            P51z := P51z + koszt
            P53z := P53z + dochod
            *        P53za=P53za+max(0,BRUT_RAZEM-koszt)
            P54z := P54z + war_puz
            P55z := P55z + podatek

            SklZdrow := SklZdrow + war_puz
            *     endif
         ENDIF
         SKIP 1
      ENDDO
      P52_1a := Max( 0, P50_1 - P51_1 )
      P52_6a := Max( 0, P50_6 - P51_6 )
      P52_7a := Max( 0, P50_7 - P51_7 )
      P52_5a := Max( 0, P50_5 - P51_5 )
      P52_11a := Max( 0, P50_11 - P51_11 )
      P53za := Max( 0, P50z - P51z )

      P52_5a_R26 := Max( 0, P50_5_R26 - P51_5_R26 )
      P52_5a_R262 := Max( 0, P50_5_R262 - P51_5_R262 )

      SELECT 100
      USE &RAPORT VIA "ARRAYRDD"

      DO CASE
         CASE _OU='D'
         CASE _OU='P'
         CASE _OU == 'X'
            IF JAKICEL == 'K'
               tresc_korekty_pit11 := edekOrdZuTrescPobierz('PIT-11', Val(ident_fir), id_pracownika)
            ENDIF
            IF JAKICEL != 'K' .OR. ValType(tresc_korekty_pit11) == "C"
               edeklaracja_plik = 'PIT_11_29_' + normalizujNazwe(AllTrim(symbol_fir)) + '_' + AllTrim(Str(Year(p4d))) + '_' + AllTrim(P31) + '_' + AllTrim(P32)
               private danedeklar
               danedeklar = edek_pit11_29()
               edekZapiszXml(danedeklar, edeklaracja_plik, wys_edeklaracja, 'PIT11-29', JAKICEL == 'K', 0, id_pracownika)
            ENDIF
         CASE _OU='K'
            DeklarDrukuj('PIT11-29')
      ENDCASE
   END
   SELECT prac
   IF _czy_close
      close_()
   ENDIF

   IF File( RAPTEMP + '.cdx' )
      DELETE FILE &RAPTEMP..cdx
   ENDIF

   RETURN

FUNCTION PIT11_DP28When()
   DP28Scr := SaveScreen(LINI+7, 1, LINI+13, 78)
   ColInf()
   @ LINI+7, 1 CLEAR TO LINI+13, 78
   @ LINI+7, 1 TO LINI+13, 78
   @ LINI+8, 3 SAY '1 - z jednego stosunku pracy'
   @ LINI+9, 3 SAY '2 - z wi©cej ni¾ jednego stosunku pracy'
   @ LINI+10, 3 SAY '3 - z jednego stosunku pracy podwy¾szone w zwi¥zku z zamieszk. prac. poza'
   @ LINI+11, 3 SAY '4 - z wi©cej ni¾ jednego stosunku pracy podwy¾szone w zwi¥zku z zamieszk.'
   @ LINI+12, 3 SAY '0 - pozostaw niewypeˆnione'
   ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION PIT11_DP28Valid()
   LOCAL lRes
   IF DP28$'01234'
      lRes := .T.
      RestScreen(LINI+7, 1, LINI+13, 78, DP28Scr)
   ELSE
      lRes := .F.
   ENDIF
   RETURN lRes

/*----------------------------------------------------------------------*/

