/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

para _G,_M,_STR,_OU
RAPORT=RAPTEMP
private P4,P4d,P5,P6,P6_kod,p7,p8,p8n,p8r,p8d,p9,p10
private P1,P1s,P11,P12,P13,P14,P15,P16,P17,P18,P19
private P20,P21,P22,P23,P24,DP28,DP10 := 'T'
private tresc_korekty_pit11 := '', id_pracownika, DP28Scr
private P_KrajID, P_DokIDTyp, P_DokIDNr, P_18Kraj
store 0 to P29,P30,P31
store '' to P3,P4,P4d,P6,P1,P11,P12,P13,P15,P16,P17,P18,P19,P20
store '' to P21
_czy_close=.f.
spolka_=.f.
*do &formproc with _dr_gr,_dr_lm,formstro,'D'
*#################################     PIT_11/8B      #############################
begin sequence
      save screen to ROBPISC
      do czekaj

      sele 20
      if dostepex('DATYUM')
*         set inde to datyum
         zap
         inde on dtos(DATA)+TYP to DATYUM
      else
         break
      endif
*      use
*      if dostep('DATYUM')
*         set inde to datyum
*      else
*         break
*      endif

      select prac
*      idpr=str(recno(),5)
      idpr=str(rec_no,5)

      id_pracownika := RecNo()

      if dtos(data_przy)<>space(8)
         zdataprzy=data_przy
         sele 20
         do DOPAP
         do BLOKADAR
         repl_([DATA],zdataprzy)
         repl_([TYP],'P')
*         commit_()
         unlock
         sele prac
      else
         zdataprzy=ctod('3000.12.31')
      endif

      if dtos(data_zwol)<>space(8)
         zdatazwol=data_zwol
         sele 20
         do DOPAP
         do BLOKADAR
         repl_([DATA],zdatazwol)
         repl_([TYP],'Z')
*         commit_()
         unlock
         sele prac
      else
         zdatazwol=data_zwol
      endif

      sele umowy
      index on del+firma+ident+dtos(data_wyp) to &raptemp
      seek '+'+ident_fir+idpr+param_rok
      do while .not.eof().and.del='+'.and.firma=ident_fir.and.ident=idpr.and.substr(dtos(data_wyp),1,4)=param_rok
         if TYTUL<>'8 '
            sele 20
            do DOPAP
            do BLOKADAR
            repl_([DATA],umowy->data_wyp)
            repl_([TYP],'U')
*         commit_()
            unlock
            sele umowy
         endif
         skip
      enddo

      sele 20
      commit_()
      count to ILR all

      rest screen from ROBPISC
      save screen to ROBPISC
      LGwie=3
      LGkol=1
      @ LGwie,LGkol clear to LGwie+11+ILR,78
      @ LGwie,LGkol to LGwie+11+ILR,78
      ColInf()
      @ LGwie+1,LGkol+1 clear to LGwie+1,77
      @ LGwie+1,LGkol+2 say 'Etat-poczatek'
      @ LGwie+1,LGkol+17 say 'Inne umowy'
      @ LGwie+1,LGkol+29 say 'Etat-koniec'
      @ LGwie+1,LGkol+42 say 'Komentaz'
      ColStd()
      LINI=LGwie+2
      go top
      ODKIEDY=ctod(param_rok+'.01.01')
      DOKIEDY=ctod(param_rok+'.12.31')
      set color to +w
      do while .not.eof()
         if TYP='P'
            @ LINI,LGkol+4  say dtoc(DATA)
         end
         if TYP='U'
            @ LINI,LGkol+17 say dtoc(DATA)
            @ LINI,LGkol+42 say 'Data wyplaty innych wyplat '
         end
         if TYP='Z'
            @ LINI,LGkol+30 say dtoc(DATA)
         end
         LINI++
         if LINI>=16
            exit
         endif
         skip
      enddo
      ColStd()
      LINI++
      set conf on
      @ LINI,LGkol+2  say 'Podaj okres do PIT-11 Od:99.99.9999  Do:99.99.9999'
      @ LINI,LGkol+27 get ODKIEDY pict '@D'
      @ LINI,LGkol+42 get DOKIEDY pict '@D'
*      read
      read_()
      set conf off
      if lastkey()<>13
         sele 20
         use
         sele 1
         break
      endif
      seek dtos(ODKIEDY)
*     vPIT8=.f.
*     vPIT11=.f.
*     if (zdatazwol>=ODKIEDY.or.dtos(zdatazwol)==space(8)).and.zdataprzy<=DOKIEDY
         vPIT11=.t.
*     endif
*     do while .not. eof().and. DATA>=ODKIEDY .and. DATA<=DOKIEDY
*        if TYP='U'
*           vPIT8=.t.
*        endif
*        skip
*     enddo
      LINI++
      JAKICEL='I'
      @ LINI,LGkol+2  say 'Cel zlozenia formularza (zlozenie Informacji/Korekta) :' get JAKICEL pict '!' valid JAKICEL$'IK'
*     NADRUK='PIT-11/8B'
*     set color to +w
*     if vPIT11=.t.
*        @ LINI,LGkol+18 say 'PIT-11.'
         NADRUK='PIT-11'
*     else
*        @ LINI,LGkol+18 say 'PIT-8B.'
*        NADRUK='PIT-8B'
*     endif
      ColStd()
*     JAKINAD='D'
      zKOR_PRZY=Prac->KOR_PRZY
      zKOR_KOSZ=Prac->KOR_KOSZ
      zKOR_ZALI=Prac->KOR_ZALI
      zKOR_SPOL=Prac->KOR_SPOL
      zKOR_ZDRO=Prac->KOR_ZDRO
      zKOR_SPOLZ=Prac->KOR_SPOLZ
      zKOR_ZDROZ=Prac->KOR_ZDROZ
      zKOR_ZWET=Prac->KOR_ZWET
      zKOR_ZWEM=Prac->KOR_ZWEM
      zKOR_ZWIN=Prac->KOR_ZWIN
      DP28 := '1'
      set conf on
*     @ LINI,LGkol+58 say 'Drukowa† taki napis czy Wykreslisz (D/W) ?' get JAKINAD pict '!' valid JAKINAD$'DW'
      @ LINI+1,LGKol+2 say 'Podaj kwoty modyfikuj&_a.ce pola wynagrodze&_n. i sk&_l.adek:'
      @ LINI+2,LGKol+2 say  'Przy' get zKOR_PRZY pict '999999.99'
      @ LINI+2,LGKol+17 say 'Kosz' get zKOR_KOSZ pict '999999.99'
      @ LINI+2,LGKol+32 say 'Zali' get zKOR_ZALI pict '99999.99'
*      @ LINI+2,LGKol+46 say 'ZUS-76' get zKOR_SPOL pict '99999.99'
*      @ LINI+2,LGKol+62 say 'ZUS-78' get zKOR_ZDRO pict '99999.99'
      @ LINI+3,LGKol+2  say 'Zw.(p.38)' get zKOR_ZWET pict '99999.99'
      @ LINI+3,LGKol+20 say 'Zw.(p.47)' get zKOR_ZWEM pict '99999.99'
      @ LINI+3,LGKol+38 say 'Zw.(p.73)' get zKOR_ZWIN pict '99999.99'
      @ LINI+4,LGKol+2  say 'ZUS(p.75)' get zKOR_SPOL pict '99999.99'
      @ LINI+4,LGKol+20 say 'ZUS(p.76)' get zKOR_SPOLZ pict '99999.99'
      @ LINI+4,LGKol+38 say 'ZUS(p.77)' get zKOR_ZDRO pict '99999.99'
      @ LINI+4,LGKol+56 say 'ZUS(p.78)' get zKOR_ZDROZ pict '99999.99'
      @ LINI+5,LGKol+2  SAY 'Informacje o kosztach uzyskania przychodu (sek. D p. 28):' GET DP28 PICT '!' WHEN PIT11_DP28When() VALID PIT11_DP28Valid()
      @ LINI+6,LGKol+2  SAY 'Nieograniczony obowi¥zek podatkowy (sek. C p. 10):' GET DP10 PICT '!' VALID DP10 $ 'TN'
      read_()
      set conf off
      if lastkey()<>13
         sele 20
         use
         sele 1
         break
      endif
*     if JAKINAD='W'
*        NADRUK='PIT-11/8B'
*     endif
      sele prac
      do blokadar
      repl KOR_PRZY with zKOR_PRZY,KOR_KOSZ with zKOR_KOSZ,KOR_ZALI with zKOR_ZALI,;
           KOR_SPOL with zKOR_SPOL,KOR_ZDRO with zKOR_ZDRO,KOR_SPOLZ with zKOR_SPOLZ,KOR_ZDROZ with zKOR_ZDROZ,;
           KOR_ZWET with zKOR_ZWET,KOR_ZWEM with zKOR_ZWEM,KOR_ZWIN with zKOR_ZWIN
      unlock
      sele 20
      use
      sele 1

*wait
*      WCLOSE()
      rest screen from ROBPISC

      set date germ
      P4=rozrzut(dtoc(ODKIEDY))
      P4d = ODKIEDY
      P5=rozrzut(dtoc(DOKIEDY))
      set date ansi
      select 9
      if dostep('FIRMA')
         go val(ident_fir)
         spolka_=spolka
      else
         break
      endif
      P1=rozrzut(nip)
      P1s=nip
      zDEKLNAZWI=DEKLNAZWI
      zDEKLIMIE=DEKLIMIE
      zDEKLTEL=DEKLTEL
      IF _OU != 'X'
         DeklPodp()
      ENDIF

      sele 8
      if dostep('ORGANY')
         set inde to organy
      else
         break
      endif
      sele 7
      if dostep('REJESTRY')
         set inde to rejestry
      else
         break
      endif
      select 6
      if dostep('SPOLKA')
         do setind with 'SPOLKA'
         seek [+]+ident_fir
      else
         break
      endif
      if del#[+].or.firma#ident_fir
         kom(5,[*u],[ Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ])
         break
      endif
*--------------------------------------
   sele urzedy
   if PRAC->skarb>0
      go PRAC->skarb
      P6=substr(alltrim(urzad)+','+alltrim(ulica)+' '+alltrim(nr_domu)+','+alltrim(kod_poczt)+' '+alltrim(miejsc_us),1,60)
      P6_kod = AllTrim(kodurzedu)
   else
      P6=space(60)
   endif
   if spolka_
      sele firma
      P8=alltrim(nazwa)
      P8n = P8
      P9=nazwa_skr
      P10=substr(nr_regon,3,9)
      set date germ
      P11=dtoc(data_zal)
      set date ansi
      P8=P8+', '+P10
      p8r = P10
   else
      sele spolka
      seek [+]+ident_fir+firma->nazwisko
      if found()
         P8=alltrim(naz_imie)
         P8n = P8
         P9=imie_o+' , '+imie_m
         P10=PESEL
         set date germ
         P11=dtoc(data_ur)
         P8d = data_ur
         set date ansi
         P8=P8+', '+P11
*  +', '+P10
      else
         P8=space(120)
         P9=space(60)
         P10=space(11)
         P11=space(8)
      endif
   endif
   sele organy
   if firma->organ>0
      go firma->organ
      P12=nazwa_org
   else
      P12=space(60)
   endif
   sele rejestry
   if firma->rejestr>0
      go firma->rejestr
      P13=nazwa_rej
   else
      P13=space(60)
   endif
   sele firma
   set date germ
   P14=dtoc(data_rej)
   set date ansi
   P15=numer_rej
   P16='POLSKA'
   if spolka_
      sele firma
      P17=param_woj
      p17a=param_pow
      P18=gmina
      P19=ulica
      P20=nr_domu
      P21=nr_mieszk
      P22=miejsc
      P23=kod_p
      P24=poczta
      P25=skrytka
      P26=tel
      P27=tlx
      P28=fax
   else
      sele spolka
*     go nr_rec
      P17=param_woj
      p17a=param_pow
      P18=gmina
      P19=ulica
      P20=nr_domu
      P21=nr_mieszk
      P22=miejsc_zam
      P23=kod_poczt
      P24=poczta
      P25=space(5)
      P26=telefon
      P27=''
      P28=space(10)
   endif
   sele prac
   p20=padc(alltrim(p20),10)
   p21=padc(alltrim(p21),9)
   p27=padc(alltrim(p27),25)
   p29=nip
   p30=pesel
   P31=nazwisko
   P32=imie1
   P33=imie2
   P34=imie_o
   P35=imie_m
   set date germ
   P36=rozrzut(dtoc(data_ur))
   P36d = data_ur
   set date ansi
   P37='POLSKA'
   P38=param_woj
   P38a=param_pow
   P39=gmina
   P40=ulica
   P41=nr_domu
   P42=nr_mieszk
   P43=miejsc_zam
   P44=kod_poczt
   P45=poczta
   P47=telefon
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
              p101,p102,p103,p104
   store 0 to p50_1,p51_1,p51a_1,p52_1,p52_1a,p52a_1,p52b_1,p53_1,;
              p50_5,p51_5,p51a_5,p52_5,p52_5a,p52a_5,p52b_5,p53_5,;
              p50_6,p51_6,p51a_6,p52_6,p52_6a,p52a_6,p52b_6,p53_6,;
              p50_7,p51_7,p51a_7,p52_7,p52_7a,p52a_7,p52b_7,p53_7,;
              p50_8,p51_8,p51a_8,p52_8,p52_8a,p52a_8,p52b_8,p53_8,;
              p50_0,p51_0,p51a_0,p52_0,p52_0a,p52a_0,p52b_0,p53_0,;
              p50_2,p51_2,p51a_2,p52_2,p52_2a,p52a_2,p52b_2,p53_2,;
              p50_3,p51_3,p51a_3,p52_3,p52_3a,p52a_3,p52b_3,p53_3,;
              p50_4,p51_4,p51a_4,p52_4,p52_4a,p52a_4,p52b_4,p53_4,;
              p50_9,p51_9,p51a_9,p52_9,p52_9a,p52a_9,p52b_9,p53_9

   sele etaty

******* tutaj + mc od do mc do
******* tu sie wstrzelic. przeleciec caly rok i sprawdzic DO_PIT4 wg ktorego zaliczyc place
*************************
*   seek '+'+ident_fir+idpr+str(month(ODKIEDY),2)
   seek '+'+ident_fir+idpr+' 1'
   do while .not. eof() .and. del='+' .and. firma=ident_fir .and. ident=idpr
      if do_pit4>=substr(dtos(ODKIEDY),1,6) .and. do_pit4<=substr(dtos(DOKIEDY),1,6)
         P50=P50+BRUT_RAZEM
         P51=P51+koszt
         P52=P52+war_psum
         P53=P53+dochod
         P54=P54+war_puz
         p54a=p54a+war_puzo
         P55=P55+podatek
         p61=p61+ZUS_ZASCHO
         p63=p63+ZUS_PODAT
         p64=p64+ZUS_RKCH
      endif
      skip 1
   enddo
*  P53a=P53a+max(0,BRUT_RAZEM-koszt)
   P50=P50+zKOR_PRZY
   P51=P51+zKOR_KOSZ
   P55=P55+zKOR_ZALI
   P52=P52+zKOR_SPOL
   P54a=P54a+zKOR_ZDRO
   P53a=max(0,P50-P51)
   sele umowy
*   index on del+firma+ident+dtos(data_wyp) to &raptemp
   seek '+'+ident_fir+idpr+substr(dtos(ODKIEDY),1,6)
   do while .not.eof().and.del='+'.and.firma=ident_fir.and.ident=idpr.and.(substr(dtos(data_wyp),1,6)>=substr(dtos(ODKIEDY),1,6).and.substr(dtos(data_wyp),1,6)<=substr(dtos(DOKIEDY),1,6))
      if TYTUL<>'8 '
      do case
      case TYTUL='0'
         P50_0=P50_0+BRUT_RAZEM
         P51_0=P51_0+koszt
         P51a_0=P51a_0+war_psum
         P52_0=P52_0+dochod
         P52_0a=P52_0a+max(0,BRUT_RAZEM-koszt)
         P52a_0=P52a_0+war_puz
         P52b_0=P52b_0+war_puzo
         P53_0=P53_0+podatek
      case TYTUL='1'
         P50_1=P50_1+BRUT_RAZEM
         P51_1=P51_1+koszt
         P51a_1=P51a_1+war_psum
         P52_1=P52_1+dochod
         P52_1a=P52_1a+max(0,BRUT_RAZEM-koszt)
         P52a_1=P52a_1+war_puz
         P52b_1=P52b_1+war_puzo
         P53_1=P53_1+podatek
      case TYTUL='2'
         P50_2=P50_2+BRUT_RAZEM
         P51_2=P51_2+koszt
         P51a_2=P51a_2+war_psum
         P52_2=P52_2+dochod
*        P52_2a=P52_2a+max(0,BRUT_RAZEM-koszt)
         P52a_2=P52a_2+war_puz
         P52b_2=P52b_2+war_puzo
         P53_2=P53_2+podatek
      case TYTUL='3'
         P50_3=P50_3+BRUT_RAZEM
         P51_3=P51_3+koszt
         P51a_3=P51a_3+war_psum
         P52_3=P52_3+dochod
*        P52_3a=P52_3a+max(0,BRUT_RAZEM-koszt)
         P52a_3=P52a_3+war_puz
         P52b_3=P52b_3+war_puzo
         P53_3=P53_3+podatek
      case TYTUL='4'
         P50_4=P50_4+BRUT_RAZEM
         P51_4=P51_4+koszt
         P51a_4=P51a_4+war_psum
         P52_4=P52_4+dochod
*        P52_4a=P52_4a+max(0,BRUT_RAZEM-koszt)
         P52a_4=P52a_4+war_puz
         P52b_4=P52b_4+war_puzo
         P53_4=P53_4+podatek
      case TYTUL='9'
         P50_9=P50_9+BRUT_RAZEM
         P51_9=P51_9+koszt
         P51a_9=P51a_9+war_psum
         P52_9=P52_9+dochod
         P52_9a=P52_9a+max(0,BRUT_RAZEM-koszt)
         P52a_9=P52a_9+war_puz
         P52b_9=P52b_9+war_puzo
         P53_9=P53_9+podatek

      case TYTUL='6'
         P50_6=P50_6+BRUT_RAZEM
         P51_6=P51_6+koszt
         P51a_6=P51a_6+war_psum
         P52_6=P52_6+dochod
*        P52_6a=P52_6a+max(0,BRUT_RAZEM-koszt)
         P52a_6=P52a_6+war_puz
         P52b_6=P52b_6+war_puzo
         P53_6=P53_6+podatek
      case TYTUL='7'
         P50_7=P50_7+BRUT_RAZEM
         P51_7=P51_7+koszt
         P51a_7=P51a_7+war_psum
         P52_7=P52_7+dochod
*        P52_7a=P52_7a+max(0,BRUT_RAZEM-koszt)
         P52a_7=P52a_7+war_puz
         P52b_7=P52b_7+war_puzo
         P53_7=P53_7+podatek
*     case TYTUL='8'
*        P50_8=P50_8+BRUT_RAZEM
*        P51_8=P51_8+koszt
*        P51a_8=P51a_8+war_psum
*        P52_8=P52_8+dochod
*        P52_8a=P52_8a+max(0,BRUT_RAZEM-koszt)
*        P52a_8=P52a_8+war_puz
*        P52b_8=P52b_8+war_puzo
*        P53_8=P53_8+podatek
      other
         P50_5=P50_5+BRUT_RAZEM
         P51_5=P51_5+koszt
         P51a_5=P51a_5+war_psum
         P52_5=P52_5+dochod
*        P52_5a=P52_5a+max(0,BRUT_RAZEM-koszt)
         P52a_5=P52a_5+war_puz
         P52b_5=P52b_5+war_puzo
         P53_5=P53_5+podatek
      endcase
*     if alltrim(TYTUL)#'1'
         P50z=P50z+BRUT_RAZEM
         P51z=P51z+koszt
         P52z=P52z+war_psum
         P53z=P53z+dochod
*        P53za=P53za+max(0,BRUT_RAZEM-koszt)
         P54z=P54z+war_puz
         P54za=P54za+war_puzo
         P55z=P55z+podatek
*     endif
      endif
      skip 1
   enddo
   P52_1a=max(0,P50_1-P51_1)
   P52_6a=max(0,P50_6-P51_6)
   P52_7a=max(0,P50_7-P51_7)
   P52_5a=max(0,P50_5-P51_5)
   P53za=max(0,P50z-P51z)
   sele 100
   do while.not.dostepex(RAPORT)
   enddo
   do case
   case _OU='D'
   case _OU='P'
   CASE _OU == 'X'
      IF JAKICEL == 'K'
         tresc_korekty_pit11 := edekOrdZuTrescPobierz('PIT-11', Val(ident_fir), id_pracownika)
      ENDIF
      IF JAKICEL != 'K' .OR. ValType(tresc_korekty_pit11) == "C"
         edeklaracja_plik = 'PIT_11_24_' + normalizujNazwe(AllTrim(symbol_fir)) + '_' + AllTrim(Str(Year(p4d))) + '_' + AllTrim(P31) + '_' + AllTrim(P32)
         private danedeklar
         danedeklar = edek_pit11_24()
         edekZapiszXml(danedeklar, edeklaracja_plik, wys_edeklaracja, 'PIT11-24', JAKICEL == 'K', 0, id_pracownika)
      ENDIF
   case _OU='K'
        SWITCH GraficznyCzyTekst()
        CASE 0
           EXIT
        CASE 1
           DeklarDrukuj('PIT11-24')
           EXIT
        CASE 2
           do kpit_811
           IF JAKICEL == 'K'
              IF tnesc(,'Czy wydrukowa† formularz przyczyn korekty ORD-ZU? (T/N)')
                 tresc_korekty_pit11 := edekOrdZuTrescPobierz('PIT-11', Val(ident_fir), id_pracownika)
                 IF ValType(tresc_korekty_pit11) == "C"
                    kartka_ordzu(P1,;
                       iif(spolka_, P8, naz_imie_naz(P8)),;
                       iif(spolka_, '', naz_imie_imie(P8)),;
                       iif(spolka_, '', DToC(P8d)),;
                       iif(spolka_, P8r, ''),;
                       iif(Len(AllTrim(P30)) == 0, P29, P30),;
                       P31, P32, DToC(P36d), '', tresc_korekty_pit11)
                 ENDIF
              ENDIF
           ENDIF
           EXIT
        ENDSWITCH
   endcase
end
sele prac
if _czy_close
   close_()
endif

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

