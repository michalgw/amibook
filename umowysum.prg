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

PROCEDURE UmowySum()

   LOCAL nDruk, aDane, aPoz

   PRIVATE _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
   PRIVATE _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
   PRIVATE typ //<--= //002a nowa zmienna

   SAVE SCREEN TO scrbor

   BEGIN SEQUENCE
      @ 1, 47 SAY Space( 10 )
      *-----parametry wewnetrzne-----
      _papsz := 1
      _lewa := 1
      _prawa := 130
      _strona := .T.
      _czy_mon := .T.
      _czy_close := .T.
      czesc := 1
      *------------------------------
      _szerokosc := 130
      _koniec := "del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      il_kontr := 0
      od_dnia := CToD( param_rok + '.01.01' )
      do_dnia := CToD( param_rok + '.12.31' )
      od_kontr := Space( 30 )
      od_kontr1 := Space( 15 )
      zTYT := '*'
      klucz := ''
      sort := 1
      @ 20,  1 CLEAR TO 22, 75
      @ 20,  1 SAY 'Od dnia' GET od_dnia
      @ 21,  1 SAY 'Do dnia' GET do_dnia
      @ 20, 20 SAY 'Nazwisko' GET od_kontr PICTURE repl( '!', 30 )
      @ 20, 60 SAY 'Imi©' GET od_kontr1 PICTURE repl( '!', 15 )
      @ 21, 20 SAY '(je¾eli zestawienie dla wszystkich to zostaw puste pola)'
      @ 22,  1 SAY 'W/w daty dotycz¥: zawarcia umowy(1),wypˆaty(2) ?' GET sort PICTURE '9' RANGE 1,2
      @ 22, 54 SAY 'Tylko umowy typu:' GET zTYT PICTURE '!' WHEN jakitytul2() VALID zTYT $ '*AZPICEFSROD'
      read_()
      IF LastKey() == 27
         BREAK
      ENDIF
      IF od_dnia > do_dnia .OR. Year( od_dnia ) # Val( param_rok ) .OR. Year( do_dnia ) # Val( param_rok )
         kom( 3, '*u', ' Nieprawid&_l.owy zakres ')
         BREAK
      ENDIF
      IF .NOT. Empty( od_kontr )
         klucz := od_kontr + AllTrim( od_kontr1 )
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      KONIEC1 := .F.
      zIDENT := 0
      SELECT 2
      IF Dostep( 'PRAC' )
         SetInd( 'PRAC' )
         SEEK '+' + IDENT_FIR + klucz
         KONIEC1 := &_koniec
         IF .NOT. KONIEC1
            *zIDENT=recno()
            zident := rec_no
         ENDIF
      ELSE
         BREAK
      ENDIF
      SELECT 1
      IF DostepEx( 'UMOWY' )
         IF sort == 1
            INDEX ON del+firma+ident+dtos(data_umowy) TO &raptemp
            dat1 := 'Data umowy'
            dat2 := 'Data wyp&_l..'
            fdat1 := 'DATA_UMOWY'
            fdat2 := 'DATA_WYP'
         ELSE
            INDEX ON del+firma+ident+dtos(data_wyp) TO &raptemp
            dat1 := 'Data wyp&_l..'
            dat2 := 'Data umowy'
            fdat1 := 'DATA_WYP'
            fdat2 := 'DATA_UMOWY'
         ENDIF
         IF Dostep( 'UMOWY' )
            SET INDEX TO &raptemp
         ELSE
            BREAK
         ENDIF
         SEEK '+' + ident_fir
         KONIEC1 := &_koniec
      ELSE
         BREAK
      ENDIF
      SELECT prac
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      IF KONIEC1 .AND. &_koniec
         kom( 3, '*w', 'b r a k   d a n y c h' )
         BREAK
      ENDIF

      nDruk := GraficznyCzyTekst()
      IF nDruk == 0
         BREAK
      ENDIF

      TytulOpis := 'wszystkie umowy'
      DO CASE
      CASE zTYT='A'
         TytulOpis := 'umowy aktywizacyjne'
      CASE zTYT='C'
         TytulOpis := 'czlonkowstwo w spoldzielniach'
      CASE zTYT='E'
         TytulOpis := 'emerytury i renty zagraniczne'
      CASE zTYT='F'
         TytulOpis := 'swiadczenia z FP i FGSP'
      CASE zTYT='Z'
         TytulOpis := 'umowy zlecenia'
      CASE zTYT='P'
         TytulOpis := 'prawa autorskie i podobne'
      CASE zTYT='I'
         TytulOpis := 'inne zrodla'
      CASE zTYT='R'
         TytulOpis := 'ryczalty do 200zl'
      CASE zTYT='S'
         TytulOpis := 'obowiazki spoleczne'
      CASE zTYT='O'
         TytulOpis := 'obcokrajowcy'
      CASE zTYT='D'
         TytulOpis := 'umowy o dzieˆo'
      ENDCASE

      IF nDruk == 1
         aDane := {=>}
         aDane[ 'opis' ] := TytulOpis
         aDane[ 'od_kontr' ] := AllTrim( od_kontr )
         aDane[ 'dataod' ] := od_dnia
         aDane[ 'datado' ] := do_dnia
         aDane[ 'firma' ] := symbol_fir
         aDane[ 'umowy' ] := {}
         aDane[ 'data1n' ] := dat1
         aDane[ 'data2n' ] := dat2

         SELECT prac
         SET EXACT OFF
         DO WHILE .NOT. &_koniec .AND. nazwisko + imie1 = klucz
            SET EXACT ON

            kk5 := rec_no

            SELECT umowy
            DO CASE
            CASE zTYT='A'
               SET FILTER TO TYTUL='1'
            CASE zTYT='C'
               SET FILTER TO TYTUL='2'
            CASE zTYT='E'
               SET FILTER TO TYTUL='3'
            CASE zTYT='F'
               SET FILTER TO TYTUL='4'
            CASE zTYT='Z'
               SET FILTER TO TYTUL='5'
            CASE zTYT='P'
               SET FILTER TO TYTUL='6'
            CASE zTYT='I'
               SET FILTER TO TYTUL='7'
            CASE zTYT='R'
               SET FILTER TO TYTUL='8'
            CASE zTYT='S'
               SET FILTER TO TYTUL='9'
            CASE zTYT='O'
               SET FILTER TO TYTUL='10'
            CASE zTYT='D'
               SET FILTER TO TYTUL='11'
            ENDCASE
            GO TOP
            SEEK '+' + IDENT_FIR + Str( kk5, 5 )
            DO WHILE .NOT. Eof() .AND. .NOT. &_koniec .AND. ident = Str( kk5, 5 )
               IF DToS( &fdat1 ) >= DToS( od_dnia ) .AND. DToS( &fdat1 ) <= DToS( do_dnia )
                  aPoz := {=>}
                  aPoz[ 'id' ] := prac->( RecNo() )
                  aPoz[ 'typ' ] := UmowySumKodujTytul( tytul )
                  aPoz[ 'nazwisko' ] := AllTrim( prac->nazwisko )
                  aPoz[ 'imie1' ] := AllTrim( prac->imie1 )
                  aPoz[ 'imie2' ] := AllTrim( prac->imie2 )
                  aPoz[ 'data1' ] := &fdat1
                  aPoz[ 'data2' ] := &fdat2
                  aPoz[ 'numer' ] := AllTrim( numer )
                  aPoz[ 'brut_zasad' ] := brut_zasad
                  aPoz[ 'koszt' ] := koszt
                  aPoz[ 'dochod' ] := dochod
                  aPoz[ 'war_puz' ] := war_puz
                  aPoz[ 'podatek' ] := podatek
                  aPoz[ 'do_wyplaty' ] := do_wyplaty
                  aPoz[ 'war_pue' ] := war_pue
                  aPoz[ 'war_pur' ] := war_pur
                  aPoz[ 'war_puc' ] := war_puc
                  aPoz[ 'war_psum' ] := war_psum
                  aPoz[ 'war_fue' ] := war_fue
                  aPoz[ 'war_fur' ] := war_fur
                  aPoz[ 'war_fuw' ] := war_fuw
                  aPoz[ 'war_fsum' ] := war_fsum
                  aPoz[ 'war_ffp' ] := war_ffp
                  aPoz[ 'war_ffg' ] := war_ffg
                  aPoz[ 'potracenia' ] := potracenia

                  aPoz[ 'ppkzs1' ] := ppkzs1
                  aPoz[ 'ppkzk1' ] := ppkzk1
                  aPoz[ 'ppkzs2' ] := ppkzs2
                  aPoz[ 'ppkzk2' ] := ppkzk2
                  aPoz[ 'ppkps1' ] := ppkps1
                  aPoz[ 'ppkpk1' ] := ppkpk1
                  aPoz[ 'ppkps2' ] := ppkps2
                  aPoz[ 'ppkpk2' ] := ppkpk2
                  aPoz[ 'ppkppm' ] := ppkppm

                  AAdd( aDane[ 'umowy' ], aPoz )
               ENDIF
               SELECT umowy
               SKIP 1
            ENDDO
         ENDDO

         FRDrukuj( 'frf\umowy.frf', aDane )

         BREAK
      ENDIF

      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      *od_dnia_=str(month(od_dnia),2)+[-]+str(day(od_dnia),2)
      *do_dnia_=str(month(do_dnia),2)+[-]+str(day(do_dnia),2)
      STORE 0 TO s0_10,s0_11,s0_12,s0_12b,s0_13,s0_14,s0_31,s0_32
      STORE 0 TO s1_10,s1_11,s1_12,s1_12b,s1_13,s1_14,s1_31,s1_32
      STORE 0 TO s0_20,s0_21,s0_22,s0_23,s0_24,s0_25,s0_26,s0_27,s0_28,s0_29,s0_30
      STORE 0 TO s1_20,s1_21,s1_22,s1_23,s1_24,s1_25,s1_26,s1_27,s1_28,s1_29,s1_30
      STORE 0 TO sPPKZK1, sPPKZK2, sPPKPK1, sPPKPK2, sPPKPPM

      k1 := DToC( od_dnia )
      k2 := DToC( do_dnia )
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'ö' + ProcName() )

      mon_drk( ' ZESTAWIENIE UMOW i INNYCH WYPLAT za okres od  ' + k1 + '  do  ' + k2 + '   (' + TytulOpis + ')        FIRMA: ' + SYMBOL_FIR )
      IF .NOT. Empty( od_kontr )
         mon_drk( ' DLA:  ' + od_kontr )
      ENDIF
      mon_drk('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿')
      mon_drk('³                    ³Mi³                                   I N F O R M A C J E   O   Z L E C E N I U                            ³')
      mon_drk('³ Nazwisko i imiona  ³esÃÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´')
      mon_drk('³                    ³¥c³Numer³'+dat1+  '³'+dat2+  '³Rodz³Przych¢d³  Koszty ³  Doch¢d  ³ZUS zdrow³ Podatek ³Potr¥ceni³Do wypˆaty ³')
      mon_drk('³                    ³  ÃÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÂÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÂÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÂÄÄÄÄÄÄÄÄÄ´')
      mon_drk('³                    ³  ³      Skladki ZUS wykonawcy        ³     Skladki ZUS zleceniodawcy     ³       Fundusze       ³  Razem  ³')
      mon_drk('³                    ³  ³Emeryt. ³Rentowa ³Chorob ³  SUMA   ³Emeryt. ³Rentowa ³Wypadk ³  SUMA   ³ Pracy ³  GSP ³ SUMA  ³Skˆ.i fun³')
      mon_drk('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ')
      SELECT prac
      SET EXACT OFF
      DO WHILE .NOT. &_koniec .AND. nazwisko + imie1 = klucz
         SET EXACT ON
         nazi := 0
         STORE 0 TO pPPKZK1, pPPKZK2, pPPKPK1, pPPKPK2, pPPKPPM
         STORE 0 TO s1_10, s1_11, s1_12, s1_13, s1_14
         k3 := nazwisko
         k4 := imie1
         k5 := imie2
         kk3 := PadR( AllTrim( k3 ) + ' ' + AllTrim( k4 ) + ' ' + AllTrim( k5 ), 40 )
         kk3a := SubStr( kk3, 21, 20 )
         kk3 := SubStr( kk3, 1, 20 )
         *kk5=recno()
         kk5 := rec_no
         SELECT umowy
         DO CASE
         CASE zTYT='A'
            SET FILTER TO TYTUL='1'
         CASE zTYT='C'
            SET FILTER TO TYTUL='2'
         CASE zTYT='E'
            SET FILTER TO TYTUL='3'
         CASE zTYT='F'
            SET FILTER TO TYTUL='4'
         CASE zTYT='Z'
            SET FILTER TO TYTUL='5'
         CASE zTYT='P'
            SET FILTER TO TYTUL='6'
         CASE zTYT='I'
            SET FILTER TO TYTUL='7'
         CASE zTYT='R'
            SET FILTER TO TYTUL='8'
         CASE zTYT='S'
            SET FILTER TO TYTUL='9'
         CASE zTYT='O'
            SET FILTER TO TYTUL='10'
         CASE zTYT='D'
            SET FILTER TO TYTUL='11'
         ENDCASE
         GO TOP
         SEEK '+' + IDENT_FIR + Str( kk5, 5 )
         DO WHILE .NOT. Eof() .AND. .NOT. &_koniec .AND. ident = Str( kk5, 5 )
            IF DToS( &fdat1 ) >= DToS( od_dnia ) .AND. DToS( &fdat1 ) <= DToS( do_dnia )
               typ := UmowySumKodujTytul( tytul )
               //002a do tad
               k6 := Str( Month( &fdat1 ), 2 )
               k7 := numer
               k8 := DToC( &fdat1 )
               k9 := DToC( &fdat2 )
               k10 := brut_zasad
               k11 := koszt
               k12 := dochod
               k12b := war_puz
               k13 := podatek
               k14 := do_wyplaty
               k20 := war_pue
               k21 := war_pur
               k22 := war_puc
               k23 := war_psum
               k24 := war_fue
               k25 := war_fur
               k26 := war_fuw
               k27 := war_fsum
               k28 := war_ffp
               k29 := war_ffg
               k30 := war_ffp + war_ffg
               k31 := potracenia
               k32 := k23 + k27 + k30

               zPPKZS1 := PPKZS1
               zPPKZK1 := PPKZK1
               zPPKZS2 := PPKZS2
               zPPKZK2 := PPKZK2
               zPPKPS1 := PPKPS1
               zPPKPK1 := PPKPK1
               zPPKPS2 := PPKPS2
               zPPKPK2 := PPKPK2
               zPPKPPM := PPKPPM

               //002a dodanie nowej zmiennej do tabeli
               IF nazi = 0
                  mon_drk(' ' + kk3 + ' ' + k6 + ' ' + k7 + ' ' + k8 + ' ' + k9 + ' ' + typ + ' ' + Str( k10, 11, 2 ) + ' ' + Str( k11, 9, 2 ) + ' ' + Str( k12, 10, 2 ) + ' ' + Str( k12b, 9, 2 ) + ' ' + Str( k13, 9, 2 ) + ' ' + Str( k31, 9, 2 ) + ' ' + Str( k14, 11, 2 ) )
                  mon_drk(' ' + kk3a + ' ' + Str( k20, 8, 2 ) + ' ' + Str( k21, 8, 2 ) + ' ' + Str( k22, 7, 2 ) + ' ' + Str( k23, 9, 2 ) + ' ' + Str( k24, 8, 2 ) + ' ' + Str( k25, 8, 2 ) + ' ' + Str( k26, 7, 2 ) + ' ' + Str( k27, 9, 2 ) + ' ' + Str( k28, 7, 2 ) + ' ' + Str( k29, 6, 2 ) + ' ' + Str( k30, 7, 2 ) + ' ' + Str( k32, 9, 2 ) )
               ELSE
                  mon_drk( Space( 22 ) + k6 + ' ' + k7 + ' ' + k8 + ' ' + k9 + ' ' + typ + ' ' + Str( k10, 11, 2 ) + ' ' + Str( k11, 9, 2 ) + ' ' + Str( k12, 10, 2 ) + ' ' + Str( k12b, 9, 2 ) + ' ' + Str( k13, 9, 2 ) + ' ' + Str( k31, 9, 2 ) + ' ' + Str( k14, 11, 2 ) )
                  mon_drk( Space( 25 ) + Str( k20, 8, 2 ) + ' ' + Str( k21, 8, 2 ) + ' ' + Str( k22, 7, 2 ) + ' ' + Str( k23, 9, 2 ) + ' ' + Str( k24, 8, 2 ) + ' ' + Str( k25, 8, 2 ) + ' ' + Str( k26, 7, 2 ) + ' ' + Str( k27, 9, 2 ) + ' ' + Str( k28, 7, 2 ) + ' ' + Str( k29, 6, 2 ) + ' ' + Str( k30, 7, 2 ) + ' ' + Str( k32, 9, 2 ) )
               ENDIF
               IF ppk == 'T'
                  mon_drk( '                  PPK - pracownik: podst.:' + Str( zPPKZK1, 8, 2 ) + ' dodat.:' + Str( zPPKZK2, 8, 2 ) + ' pracodaw.: podst.:' + Str( zPPKPK1, 8, 2 ) + ' dodat.:' + Str( zPPKPK2, 8, 2 ) + ' dol.podst.:' + Str( zPPKPPM, 8, 2 ) )
               ENDIF
               s0_10 := s0_10 + k10
               s0_11 := s0_11 + k11
               s0_12 := s0_12 + k12
               s0_12b := s0_12b + k12b
               s0_13 := s0_13 + k13
               s0_14 := s0_14 + k14

               s1_10 := s1_10 + k10
               s1_11 := s1_11 + k11
               s1_12 := s1_12 + k12
               s1_12b := s1_12b + k12b
               s1_13 := s1_13 + k13
               s1_14 := s1_14 + k14

               s0_20 := s0_20 + k20
               s0_21 := s0_21 + k21
               s0_22 := s0_22 + k22
               s0_23 := s0_23 + k23
               s0_24 := s0_24 + k24
               s0_25 := s0_25 + k25
               s0_26 := s0_26 + k26
               s0_27 := s0_27 + k27
               s0_28 := s0_28 + k28
               s0_29 := s0_29 + k29
               s0_30 := s0_30 + k30
               s0_31 := s0_31 + k31
               s0_32 := s0_32 + k32

               s1_20 := s1_20 + k20
               s1_21 := s1_21 + k21
               s1_22 := s1_22 + k22
               s1_23 := s1_23 + k23
               s1_24 := s1_24 + k24
               s1_25 := s1_25 + k25
               s1_26 := s1_26 + k26
               s1_27 := s1_27 + k27
               s1_28 := s1_28 + k28
               s1_29 := s1_29 + k29
               s1_30 := s1_30 + k30
               s1_31 := s1_31 + k31
               s1_32 := s1_32 + k32

               sPPKZK1 := sPPKZK1 + zPPKZK1
               sPPKZK2 := sPPKZK2 + zPPKZK2
               sPPKPK1 := sPPKPK1 + zPPKPK1
               sPPKPK2 := sPPKPK2 + zPPKPK2
               sPPKPPM := sPPKPPM + zPPKPPM

               pPPKZK1 := pPPKZK1 + zPPKZK1
               pPPKZK2 := pPPKZK2 + zPPKZK2
               pPPKPK1 := pPPKPK1 + zPPKPK1
               pPPKPK2 := pPPKPK2 + zPPKPK2
               pPPKPPM := pPPKPPM + zPPKPPM

               nazi++
            ENDIF
            SELECT umowy
            SKIP 1
         ENDDO
         IF nazi > 1
            mon_drk( '                           R A Z E M                   ' + Str( s1_10, 11, 2 ) + ' ' + Str( s1_11, 9, 2 ) + ' ' + Str( s1_12, 10, 2 ) + ' ' + Str( s1_12b, 9, 2 ) + ' ' + Str( s1_13, 9, 2 ) + ' ' + str( s1_31, 9, 2 ) + ' ' + Str( s1_14, 11, 2 ) )
            mon_drk( Space( 25 ) + Str( s1_20, 8, 2 ) + ' ' + Str( s1_21, 8, 2 ) + ' ' + Str( s1_22, 7, 2 ) + ' ' + Str( s1_23, 9, 2 ) + ' ' + Str( s1_24, 8, 2 ) + ' ' + Str( s1_25, 8, 2 ) + ' ' + Str( s1_26, 7, 2 ) + ' ' + Str( s1_27, 9, 2 ) + ' ' + Str( s1_28, 7, 2 ) + ' ' + Str( s1_29, 6, 2 ) + ' ' + Str( s1_30, 7, 2 ) + ' ' + Str( s1_32, 9, 2 ) )
            mon_drk( '                                ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ' )
         ENDIF
         IF nazi = 1
            mon_drk( '                                ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ' )
         endif
         STORE 0 TO s1_10,s1_11,s1_12,s1_13,s1_14,s1_12b
         STORE 0 TO s1_20,s1_21,s1_22,s1_23,s1_24,s1_25,s1_26,s1_27,s1_28,s1_29,s1_30,s1_31,s1_32
         SELECT prac
         SKIP 1
         SET EXACT OFF
      ENDDO
      SET EXACT ON
      USE
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( repl( '=', 130 ) )
      mon_drk( '                           OG&__O.&__L.EM ZA OKRES             ' + Str( s0_10, 11, 2 ) + ' ' + Str( s0_11, 9, 2 ) + ' ' + Str( s0_12, 10, 2 ) + ' ' + Str( s0_12b, 9, 2 ) + ' ' + Str( s0_13, 9, 2 ) + ' ' + Str( s0_31, 9, 2 ) + ' ' + Str( s0_14, 11, 2 ) )
      mon_drk( Space( 25 ) + Str( s0_20, 8, 2 ) + ' ' + Str( s0_21, 8, 2 ) + ' ' + Str( s0_22, 7, 2 ) + ' ' + Str( s0_23, 9, 2 ) + ' ' + Str( s0_24, 8, 2 ) + ' ' + Str( s0_25, 8, 2 ) + ' ' + Str( s0_26, 7, 2 ) + ' ' + Str( s0_27, 9, 2 ) + ' ' + Str( s0_28, 7, 2 ) + ' ' + Str( s0_29, 6, 2 ) + ' ' + Str( s0_30, 7, 2 ) + ' ' + Str( s0_32, 9, 2 ) )
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'ş' )
   END

   RESTORE SCREEN FROM scrbor

   IF _czy_close
      close_()
   ENDIF

   IF File( RAPTEMP + '.cdx' )
      DELETE FILE &RAPTEMP..cdx
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION jakitytul2()

   ColInf()
   @  7, 50 CLEAR TO 21, 79
   @  7, 50 TO 21, 79
   @  8, 51 SAY PadC( 'Wpisz:', 28 )
   @  9, 51 SAY '* - wszystkie rodzaje       '
   @ 10, 51 SAY 'Z - umowy zlecenia          '
   @ 11, 51 SAY 'D - umowy o dzieˆo          '
   @ 12, 51 SAY 'P - prawa autorskie i inne  '
   @ 13, 51 SAY 'I - inne zrodla             '
   @ 14, 51 SAY 'C - czlonkowstwo w spoldziel'
   @ 15, 51 SAY 'E - emerytury,renty zagrani.'
   @ 16, 51 SAY 'F - swiadczenia z FP i FGSP '
   @ 17, 51 SAY 'S - spoleczne obowiazki     '
   @ 18, 51 SAY 'A - aktywizacyjna umowa     '
   @ 19, 51 SAY 'R - ryczalt do 200zl        '
   @ 20, 51 SAY 'O - obcokrajowcy            '

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION UmowySumKodujTytul( cTytul )

   LOCAL cRes

   DO CASE
   CASE cTytul='0'
      cRes := 'O' //organy stanowiace
   CASE cTytul='1'
      cRes := 'A' //aktywizacja
   CASE cTytul='2'
      cRes := 'C' //czlonkowstwo w spoldzielni
   CASE cTytul='3'
      cRes := 'E' //emerytury i renty zagraniczne
   CASE cTytul='4'
      cRes := 'F' //swiadczenia z funduszu pracy i GSP
   CASE cTytul='9'
      cRes := 'S' //obowiazki spoleczne
   CASE cTytul='6'
      cRes := 'P' //prawa autorskie
   CASE cTytul='7'
      cRes := 'I' //inne zrodla
   CASE cTytul='8'
      cRes := 'R' //kontrakty menadzerskie
   CASE cTytul='10'
      cRes := 'O' //kontrakty menadzerskie
   CASE cTytul='11'
      cRes := 'D' //kontrakty menadzerskie
   OTHERWISE
      cRes := 'Z' //umowy zlecenia i o dzielo 5
   ENDCASE

   RETURN cRes

/*----------------------------------------------------------------------*/

