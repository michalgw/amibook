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

*################################# GRAFIKA ##################################

PROCEDURE InfoV716()

   sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.01' ) )

   ColInf()
   //@  3,0 say '[B,W]-wplata gotowkowa   [L,N]-przelew   [P]-wplata pocztowa   [D]-wydruk ekranu'
   @  3, 0 SAY '[B,W]-wpl.got.   [L,N]-przelew   [P]-wpl.poczt.   [D]-wydr.ekranu   [I]-wydr.inf'
   ColStd()
   @  4, 0 SAY '                I N F O R M A C J E   O   P O D A T K U   V A T                 '
   @  5, 0 SAY 'PODATEK NALEZNY     NETTO        VAT     PODATEK NALICZONY   NETTO        VAT   '
   @  6, 0 SAY ' kraj         ZW  ת תתת תתת              Nadwyzka z poprzedniej dekl. ת תתת תתת '
   @  7, 0 SAY ' poza kraj    NP  ת תתת תתת              Podatek od spisu z natury    ת תתת תתת '
   @  8, 0 SAY '    w tym art.100 ת תתת תתת              ZAKUPY  Sr.Trwale ת תתת תתת  ת תתת תתת '
   @  9, 0 SAY ' kraj          0% ת תתת תתת                      Pozostale ת תתת תתת  ת תתת תתת '
   @ 10, 0 SAY '    w tym art.129 ת תתת תתת              KOREK-  Sr.trwale ת תתת תתת  ת תתת תתת '
   @ 11, 0 SAY '              ' + Str( vat_C, 2 ) + '% ת תתת תתת   ת תתת תתת  TY      Pozostale ת תתת תתת  ת תתת תתת '
   @ 12, 0 SAY '              ' + Str( vat_B, 2 ) + '% ת תתת תתת   ת תתת תתת  RAZEM NALICZONY              ת תתת תתת '
   @ 13, 0 SAY '              ' + Str( vat_A, 2 ) + '% ת תתת תתת   ת תתת תתת  Do odlicz.za kasy            ת תתת תתת '
   @ 14, 0 SAY ' WDT (UE)      0% ת תתת תתת              Zaniechanie poboru           ת תתת תתת '
   @ 15, 0 SAY ' eksport       0% ת תתת תתת              NALEZNE ZOBOWIAZANIE         ת תתת תתת '
   @ 16, 0 SAY ' WNT (UE)         ת תתת תתת   ת תתת תתת          Wplacone zaliczki    ת תתת תתת '
   @ 17, 0 SAY ' Import towarow   ת תתת תתת   ת תתת תתת          Nadplata z pop.kwart.ת תתת תתת '
   @ 18, 0 SAY ' Import uslug     ת תתת תתת   ת תתת תתת          DO ZAPLATY/NADPLATA  ת תתת תתת '
   @ 19, 0 SAY ' Import u.art.28b ת תתת תתת   ת תתת תתת          Przeniesc nadpl.TAK  ת תתת תתת '
   @ 20, 0 SAY ' Podatnikiem naby.ת תתת תתת   ת תתת תתת  Zwrot za kasy                ת תתת תתת '
   @ 21, 0 SAY ' Podat.nab.dostawaת תתת תתת              Nadwyzka(Na rach)  ת תתת תתת(ת תתת תתת)'
   @ 22, 0 SAY ' od spisu z natury            ת תתת תתת  25/60/180ת תתת תתת/ת תתת תתת/ת תתת תתת '
   @ 23, 0 SAY ' zapl.za sr.transp            ת תתת תתת  Do przeniesienia             ת תתת תתת '
   @ 24, 0 SAY ' RAZEM NALEZNY    ת תתת תתת   ת תתת תתת                                         '
   *################################ OBLICZENIA ################################
   *wartprzek=p98b
   ****************************
   IF zVATFORDR == '7D'
      @ 15, 41 SAY 'NALEZNE ZOBOWIAZANIE'
      SET COLOR TO +w
      @ 18, 49 SAY iif( p98dozap > 0.0, 'DO ZAPLATY         ', 'NADPLATA           ' )
   ELSE
      @ 16, 41 CLEAR TO 19, 79
      SET COLOR TO +w
      @ 15, 41 SAY 'DO WPLATY DO US     '
   ENDIF
   @  6, 18 SAY tran( p64, RVPIC )
   @  7, 18 SAY tran( p64exp, RVPIC )
   @  8, 18 SAY tran( p64expue, RVPIC )
   @  9, 18 SAY tran( p67, RVPIC )
   @ 10, 18 SAY tran( p67art129, RVPIC )
   @ 11, 18 SAY tran( p61+P61a, RVPIC )
   @ 11, 30 SAY tran( p62+P62a, RVPIC )
   @ 12, 18 SAY tran( p69, RVPIC )
   @ 12, 30 SAY tran( p70, RVPIC )
   @ 13, 18 SAY tran( p71, RVPIC )
   @ 13, 30 SAY tran( p72, RVPIC )
   @ 14, 18 SAY tran( p65ue, RVPIC )
   @ 15, 18 SAY tran( p65, RVPIC )

   @ 16, 18 SAY tran( p65dekue, RVPIC )
   @ 16, 30 SAY tran( p65vdekue, RVPIC )
   @ 17, 18 SAY tran( p65dekit, RVPIC )
   @ 17, 30 SAY tran( p65vdekit, RVPIC )
   @ 18, 18 SAY tran( p65dekus, RVPIC )
   @ 18, 30 SAY tran( p65vdekus, RVPIC )
   @ 19, 18 SAY tran( p65dekusu, RVPIC )
   @ 19, 30 SAY tran( p65vdekusu, RVPIC )
   @ 20, 18 SAY tran( p65dekwe, RVPIC )
   @ 20, 30 SAY tran( p65vdekwe, RVPIC )

   @ 22, 30 SAY tran( pp12, RVPIC )
   @ 23, 30 SAY tran( znowytran, RVPIC )
   @ 24, 18 SAY tran( p75, RVPIC )
   @ 24, 30 SAY tran( p76, RVPIC )

   @  6, 70 SAY tran( pp8, RVPIC )
   @  7, 70 SAY tran( pp11, RVPIC )

   @  8, 59 SAY tran( p45dek, RVPIC )
   @  8, 70 SAY tran( p46dek, RVPIC )
   @  9, 59 SAY tran( p49dek, RVPIC )
   @  9, 70 SAY tran( p50dek, RVPIC )

   @ 10, 70 SAY tran( zkorekst, RVPIC )
   @ 11, 70 SAY tran( zkorekpoz, RVPIC )

   @ 12, 70 SAY tran( p79, RVPIC )
   @ 13, 70 SAY tran( p98a, DRVPIC )
   @ 14, 70 SAY tran( pp13, DRVPIC )
   @ 15, 70 SAY tran( p98b, DRVPIC )

   IF zVATFORDR == '7D'
      @ 16, 70 SAY tran( zVATZALMIE, DRVPIC )
      @ 17, 70 SAY tran( zVATNADKWA, DRVPIC )
      IF p98dozap > 0.0
         @ 18, 70 SAY tran( p98dozap, DRVPIC )
      ELSE
         @ 18, 70 SAY tran( p98rozn, DRVPIC )
      ENDIF
      @ 19, 70 SAY tran( p98doprze, DRVPIC )
   ENDIF

   @ 20, 70 SAY tran( p99a, DRVPIC )
   @ 21, 60 SAY tran( p99, DRVPIC )
   @ 21, 70 SAY tran( p99c, RVPIC )
   @ 22, 50 SAY tran( p99abc, RVPIC )
   @ 22, 60 SAY tran( p99ab, RVPIC )
   @ 22, 70 SAY tran( p99b, RVPIC )
   @ 23, 70 SAY tran( p99d, RVPIC )
   *@ 24,58 say ' '+alltrim(tran(zpaliwa,RVPIC))
   *@ 24,70 say ' '+alltrim(tran(zpojazdy,RVPIC))

   @ 21, 18 SAY tran( Int( SEK_CV7net ), RVPIC )

   SELECT firma
   *################################## PRZEKAZ #################################
   zNAZWA_PLA := nazwa
   zULICA_PLA := AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + iif( Len( AllTrim( nr_mieszk ) ) > 0, '/' + AllTrim( nr_mieszk ), '' )
   zMIEJSC_PLA := AllTrim( kod_p ) + ' ' + AllTrim( miejsc )
   zBANK_PLA := bank
   zKONTO_PLA := nr_konta
   ztr1 := PadR( StrTran( AllTrim( nip ), '-', '' ), 14 )
   ztr2 := ' N  '
   IF zVATFORDR == '7 ' .OR. zVATFORDR == '8 ' .OR. zVATFORDR == '9M'
   *if zVATOKRES='M'
      ztr3 := ' ' + SubStr( param_rok, 3, 2 ) + 'M' + StrTran( PadL( miesiac, 2 ), ' ', '0' ) + '  '
   ELSE
      ztr3 := ' ' + SubStr( param_rok, 3, 2 ) + 'K' + StrTran( PadL( P5a, 2 ), ' ', '0' ) + '  '
   ENDIF
   ztr4 := 'VAT7   '
   zTRESC := ztr1 + ztr2 + ztr3 + ztr4
   *zTRESC='VAT-7 '+miesiac+'.'+param_rok+' NIP:'+padc(alltrim(nip),13)

   *sele 7
   *do while.not.dostep('URZEDY')
   *enddo
   *set inde to urzedy
   SELECT urzedy
   GO firma->skarb
   zNAZWA_WIE := 'URZ&__A.D SKARBOWY ' + AllTrim( URZAD )
   zULICA_WIE := AllTrim( ULICA ) + ' ' + AllTrim( NR_DOMU )
   zMIEJSC_WIE := AllTrim( KOD_POCZT ) + ' ' + AllTrim( MIEJSC_US )
   zBANK_WIE := BANK
   zKONTO_WIE := KONTOVAT

   IF nr_uzytk == 108
      csvvat716()
   ENDIF

   SELECT urzedy
   CLEAR TYPEAHEAD
   kkk := Inkey( 0 )
   zPodatki := .T.
   DO CASE
   CASE kkk == 68 .OR. kkk == 100
      **** Drukowanie ekranu
      DrukujEkran( { PadC( AllTrim( firma->nazwa ), 80 ), iif( zVATFORDR='7 ' .OR. zVATFORDR == '8 ' .OR. zVATFORDR == '9M', ;
         PadC( 'Miesi&_a.c ' + param_rok + '.' + StrTran( PadL( miesiac, 2 ), ' ', '0' ), 80 ), ;
         PadC( 'Kwarta&_l. ' + param_rok + '.' + StrTran( PadL( p5a, 2 ), ' ', '0' ), 80 ) ), "" }, , 4, 24 )

   CASE kkk == 87 .OR. kkk == 119 .OR. kkk == 66 .OR. kkk == 98
      SAVE SCREEN TO scr_
      zKWOTA := wartprzek
      AFill( nazform, '' )
      AFill( strform, 0 )
      nazform[ 1 ] := 'WPLATN'
      strform[ 1 ] := 1
      form( nazform, strform, 1 )
      RESTORE SCREEN FROM scr_
   CASE kkk == 78 .OR. kkk == 110 .OR. kkk == 76 .OR. kkk == 108
      SAVE SCREEN TO scr_
      zKWOTA := wartprzek
      AFill( nazform, '' )
      AFill( strform, 0 )
      nazform[ 1 ] := 'PRZELN'
      strform[ 1 ] := 1
      form( nazform, strform, 1 )
      RESTORE SCREEN FROM scr_
   CASE kkk == 80 .OR. kkk == 112
      save screen to scr3
      Przek( zNAZWA_WIE,;
         zNAZWA_PLA,;
         zULICA_WIE,;
         zULICA_PLA,;
         zMIEJSC_WIE,;
         zMIEJSC_PLA,;
         zBANK_WIE,;
         zKONTO_WIE,;
         wartprzek,;
         zTRESC )
      *    do przekaz with wartprzek,'V'
        restore screen from scr3
   CASE kkk == Asc( 'i' ) .OR. kkk == Asc( 'I' )
      DeklarDrukuj( 'VATINFO', resdekl )
   ENDCASE
   zPodatki := .f.
   SELECT firma

   RETURN

****************************
PROCEDURE CSVVAT716
****************************
//tworzenie bazy roboczej

   SAVE SCREEN TO _csvscre_

   ColInb()
   @ 24, 0 CLEAR
   center( 24, 'Preparuj&_e. dane do internetu. Prosz&_e. czeka&_c....' )
   SET COLOR TO


   _konc_ := SubStr( param_rok, 3, 2 ) + StrTran( PadL( miesiac, 2 ), ' ', '0' )
   _plik_ := 'VAT7' + _konc_



   IF File( _plik_ + '.dbf' ) == .F.
      *wait 'brak pliku dbf'
      dbCreate( _plik_, { ;
         { "NIPFIRMY",  "C", 10, 0 }, ;
         { "NIPPODAT",  "C", 10, 0 }, ;
         { "NALEZNY",   "N", 15, 2 }, ;
         { "NALICZONY", "N", 15, 2 }, ;
         { "PODATEK",   "N", 15, 2 }, ;
         { "DATAAKT",   "D",  8, 0 } } )
   ENDIF
   SELECT 11
   IF dostepex( _plik_ )
      INDEX ON nipfirmy + nippodat TO &_plik_
      GO TOP
      IF Len( AllTrim( StrTran( firma->nip, '-', '' ) ) + AllTrim( ztr1 ) ) == 20
         SEEK AllTrim( StrTran( firma->nip, '-', '' ) ) + AllTrim( ztr1 )
         IF Found()
            REPLACE NALEZNY WITH p76, NALICZONY WITH p79, ;
               PODATEK WITH p98b, DATAAKT WITH Date()
            commit_()
         ELSE
            APPEND BLANK
            REPLACE NIPFIRMY WITH AllTrim( StrTran( firma->nip, '-', '' ) ), NIPPODAT WITH AllTrim( ztr1 )
            REPLACE NALEZNY WITH p76, NALICZONY WITH p79, ;
               PODATEK WITH p98b, DATAAKT WITH Date()
            commit_()
         ENDIF
         GO TOP
         COPY TO &_plik_ ALL DELIMITED
      ELSE
         komun( 'Niew&_l.a&_s.ciwe d&_l.ugo&_s.ci NIP firmy i/lub podatnika. Sprawd&_x. i popraw.' )
      ENDIF
   ELSE
      komun( 'Nie mog&_e. zaktualizowa&_c. pliku exportu CSV.' )
   ENDIF
   USE

   RESTORE SCREEN FROM _csvscre_

   RETURN
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
