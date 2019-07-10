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
private P3,P4,P4r,P6,P6k
private P1,P16,P17,P18,P19,p17a
private P20,P21,P22,P23,P24,p46,p47,p48
private P63
private tresc_korekty_pit4r := ''
zDEKLKOR='D'
store 0 to P29,P30,P31,p32,p33,p34,p35
store '' to P3,P4,P4r,P6,P6k,P1,P16,P17,P18,P19,P20,p17a
store '' to P21,P24
rRPIC4='@E     999   '
rRPIC1='@E  999 999  '
do czekaj
_czy_close=.f.
*do &formproc with _dr_gr,_dr_lm,formstro,'D'
*#################################     PIT_4      #############################
begin sequence
   select 9
   if dostepex('TABPIT4R')
      zap
      inde on del+firma+mc to TABPIT4R
   else
      break
   endif

   select 8
   if dostep('SUMA_MC')
      set inde to SUMA_MC
      seek [+]+ident_fir+miesiac
   else
      break
   endif

   select 7
   if dostep('UMOWY')
      do setind with 'UMOWY'
      set orde to 4
      go top
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

   select 5
   if dostep('URZEDY')
      do setind with 'URZEDY'
   else
      break
   endif

   select 4
   if dostep('ETATY')
      do setind with 'ETATY'
   else
      break
   endif

   select 3
   if dostep('FIRMA')
      go val(ident_fir)
      spolka_=spolka
   else
      break
   endif
   P1=nip

   select 2
   if dostep('PRAC')
      set inde to prac3
*      do setind with 'PRAC'
*      set orde to 3
   else
      break
   endif

   zDEKLNAZWI=C->DEKLNAZWI
   zDEKLIMIE=C->DEKLIMIE
   zDEKLTEL=C->DEKLTEL

   P3=rozrzut(miesiac)
   P4=rozrzut(param_rok)
   P4r=param_rok
   if spolka_
      sele firma
      P8=alltrim(nazwa)+' , '+substr(NR_REGON,3,9)
      P8a=alltrim(nazwa)+' , '+substr(NR_REGON,3,9)
      P8n = AllTrim(nazwa)
      P8r = AllTrim(SubStr(NR_REGON,3,9))
      sele urzedy
      if FIRMA->skarb>0
         go FIRMA->skarb
         P6=substr(alltrim(urzad)+','+alltrim(ulica)+' '+alltrim(nr_domu)+','+alltrim(kod_poczt)+' '+alltrim(miejsc_us),1,60)
         P6k=AllTrim(kodurzedu)
      else
         P6=space(60)
      endif
   else
      sele spolka
      seek [+]+ident_fir+firma->nazwisko
      if found()
         P8=alltrim(naz_imie)+' , '+dtoc(data_ur)
         P8n = AllTrim(naz_imie)
         P8d = data_ur
*         P8=alltrim(naz_imie)+' , '+dtoc(data_ur)+' , '+alltrim(PESEL)
*         P8=alltrim(naz_imie)
         sele urzedy
         if SPOLKA->skarb>0
            go SPOLKA->skarb
            P6=substr(alltrim(urzad)+','+alltrim(ulica)+' '+alltrim(nr_domu)+','+alltrim(kod_poczt)+' '+alltrim(miejsc_us),1,60)
            P6k=AllTrim(kodurzedu)
         else
            P6=space(60)
         endif
      else
         P8=space(60)
      endif
   endif
*   sele firma
   if spolka_
      sele firma
      P16=tlx
      P17=param_woj
      p17a=param_pow
      P18=gmina
      P19=ulica
      P20=nr_domu
      P21=nr_mieszk
      P22=miejsc
      P23=kod_p
      P24=poczta
   else
      sele spolka
*      go nr_rec
      P16=kraj
      P17=param_woj
      p17a=param_pow
      P18=gmina
      P19=ulica
      P20=nr_domu
      P21=nr_mieszk
      P22=miejsc_zam
      P23=kod_poczt
      P24=poczta
   endif
   p46=0
   p47=0
   p48=0

for xxm=1 to 12
   P29=0
   P30=0
   P31=0
   p63=0
   pc2=0
   pc4=0
   pc5=0
   pc6=0
   pc7=0
   pc8=0
   pc9=0
   pc10=0
   xxmiesiac=str(xxm,2)
   sele etaty
   idprac='BRAK'
   seek '+'+ident_fir
   do while .not.eof().and.del='+'.and.firma=ident_fir
      sele prac
*      robal=val(etaty->ident)
      seek val(etaty->ident)
*      if found()
*         wait 'znaleziono '+nazwisko
*      else
*         wait 'nie znaleziono '+nazwisko
*      endif
*      wait strtran((etaty->ident),' ','0')+' '+nazwisko
      sele etaty
      store .f. to DOD
      store .t. to DDO
      if .not.empty(PRAC->DATA_PRZY)
         DOD=substr(dtos(PRAC->DATA_PRZY),1,6)<=param_rok+strtran(xxmiesiac,' ','0')
      endif
      if .not.empty(PRAC->DATA_ZWOL)
         DDO=substr(dtos(PRAC->DATA_ZWOL),1,6)>=param_rok+strtran(xxmiesiac,' ','0')
      endif
      if DO_WYPLATY<>0.0 .or.(BRUT_RAZEM-WAR_PSUM)<>0.0 .or.PODATEK<>0.0 .or.(DOD.and.DDO)
         if mc=xxmiesiac.and.IDPRAC<>IDENT
            P29++
            IDPRAC=IDENT
         endif
         if DO_PIT4==strtran(param_rok+xxmiesiac,' ','0')
            P30=P30+(BRUT_RAZEM-WAR_PSUM)
            P31=P31+PODATEK
            P63=P63+ZUS_PODAT
         endif
      endif
      if mc=xxmiesiac
         pc4=pc4+PIT4RC4
         pc5=pc5+PIT4RC5
         pc6=pc6+PIT4RC6
         pc7=pc7+PIT4RC7
         pc8=pc8+PIT4RC8
      endif
      skip 1
   enddo

   sele umowy
   seek '+'+ident_fir+strtran(param_rok+xxmiesiac,' ','0')
   do while .not.eof().and.del='+'.and.firma=ident_fir.and.substr(dtos(data_wyp),1,6)=strtran(param_rok+xxmiesiac,' ','0')
      do case
      case TYTUL='1'
         pc9=pc9+podatek
      case TYTUL='2'.or.TYTUL='3'.or.TYTUL='4'
         pc2=pc2+podatek
      case TYTUL='8'
         zmienna=1
      CASE TYTUL = '10'
         // nic bo to obcokrajowcy i idzie do pit-8ar
      other
         pc10=pc10+podatek
      endcase
      skip 1
   enddo

   sele TABPIT4R
   seek '+'+ident_fir+xxmiesiac
   if .not. found()
      do dopap
      repl_([del],'+')
      repl_([firma],ident_fir)
      repl_([mc],xxmiesiac)
   endif
   repl_([ilpod],P29)
   repl_([nalzal],P31+p63)
   repl_([nalzal33],pc2)
   repl_([ogrzal],pc4)
   repl_([ogrzal32],pc5)
   repl_([dodzal],pc6)
   repl_([nadzwr],pc7)
   repl_([pfron],pc8)
   repl_([aktyw],pc9)
   repl_([zal13],pc10)
   unlock
   sele etaty
next

ColStd()
@ 24,0 clear

if _STR=1
   do PIT4RTAB with miesiac
endif

for xxm=1 to 12
   xxmiesiac=str(xxm,2)
   sele SUMA_MC
   seek '+'+ident_fir+xxmiesiac
   if found()
      sele TABPIT4R
      seek '+'+ident_fir+xxmiesiac
      if .not. found()
         do dopap
         repl_([del],'+')
         repl_([firma],ident_fir)
         repl_([mc],xxmiesiac)
      endif
      repl_([ilpodu],suma_mc->P4il_pod)
      repl_([nalzalu],suma_mc->P4sum_zal)
      repl_([nalzal33u],suma_mc->P4nalzal33)
      repl_([ogrzalu],suma_mc->P4ogrzal)
      repl_([ogrzal32u],suma_mc->P4ogrzal33)
      repl_([dodzalu],suma_mc->P4dodzal)
      repl_([nadzwru],suma_mc->P4nadzwr)
      repl_([pfronu],suma_mc->P4pfron)
      repl_([aktywu],suma_mc->P4aktyw)
      repl_([zal13u],suma_mc->P4zal13)
      repl_([wynagr],suma_mc->P4potrac)
*      repl_([wynagru],suma_mc->P4wynagr)
      unlock
   endif
next

*sele etaty

for xxxmm=1 to 12
    xxm=strtran(str(xxxmm,2),' ','0')
    z1a&xxm=0
    z1b&xxm=0
    z2&xxm=0
    z3&xxm=0
    z4&xxm=0
    z5&xxm=0
    z6&xxm=0
    z7&xxm=0
    z8&xxm=0
    z9&xxm=0
    z10&xxm=0
    z11&xxm=0
    z12&xxm=0
    z13&xxm=0
next

sele TABPIT4R
for xxxmm=1 to 12
    xxm=str(xxxmm,2)
    seek '+'+ident_fir+xxm
    if found()
       xxm=strtran(str(xxxmm,2),' ','0')
       z1a&xxm=Ilpod+Ilpodu
       z1b&xxm=Nalzal+Nalzalu
       z2&xxm=Nalzal33+Nalzal33u
       z4&xxm=Ogrzal+Ogrzalu
       z5&xxm=Ogrzal32+Ogrzal32u
       z6&xxm=Dodzal+Dodzalu
       z7&xxm=Nadzwr+Nadzwru
       z8&xxm=PFRON+PFRONu
       z9&xxm=Aktyw+Aktywu
       z10&xxm=Zal13+Zal13u
       z3&xxm=z1b&xxm+z2&xxm+z10&xxm+z9&xxm
       z11&xxm=max(0,(z3&xxm+z5&xxm+z6&xxm)-(z4&xxm+z7&xxm+z8&xxm))
       z12&xxm=_round(z11&xxm*(Wynagr/100),0)
       z13&xxm=_round(max(0,z11&xxm-z12&xxm),0)
    endif
next

*****************************
****** te kwoty beda rozbijane miesiecznie w TABPIT4R
*   p29=p29+zP4IL_POD
*   p30=p30+zP4SUM_WYP
*   p31=p31+zP4SUM_ZAL
*********************************
****** stare wyliczanki na formularz zastapic nowymi
****************************
*   P33=max(0,_round((P31+p32+p46)-(p47+p48),1))
*   P34=_round(p33*(zP4POTRAC/100),0)
*   P35=P33-P34
*   p64=slownie(p35)
*****************************
   sele 100
   do while.not.dostepex(RAPORT)
   enddo
   do case
   case _OU='E'
      do p_wypla
   case _OU='D'
      do case
      case _STR=1
           DeklPodp( 'T' )
           for x=1 to _G
               rl()
           next
           rl(space(_M)+space(2)+rozrzut(P1))
           for x=1 to 7
               rl()
           next
           rl(space(_M)+space(38)+P4)
           for x=1 to 11
               rl()
           next
           rl(space(_M)+space(7)+padc(alltrim(P6),60))
           rl()
           if zDEKLKOR='D'
              rl(space(_M)+space(25)+'XXX')
           else
              rl(space(_M)+space(42)+'XXX')
           endif
           for x=1 to 5
               rl()
           next
           if spolka_
              rl(space(_M)+space(14)+'XXX')
           else
              rl(space(_M)+space(49)+'XXX')
           endif
           rl()
           rl()
           rl(space(_M)+space(7)+padc(alltrim(P8),60))
           for x=1 to 4
               rl()
           next
           rl(space(_M)+space(3)+padc(alltrim(P16),15)+space(1)+padc(alltrim(P17),30)+space(2)+padc(alltrim(P17a),22))
           rl()
           rl(space(_M)+space(3)+padc(alltrim(P18),18)+space(2)+padc(alltrim(P19),34)+space(4)+padc(alltrim(P20),6)+space(2)+padc(alltrim(P21),6))
           rl()
           rl(space(_M)+space(3)+padc(alltrim(P22),30)+space(1)+padc(alltrim(P23),11)+space(1)+padc(alltrim(P24),27))
           for x=1 to 6
               rl()
           next
           rl(space(_M)+space(17)+tran(z1a01,rRPIC4)+tran(z1a02,rRPIC4)+tran(z1a03,rRPIC4)+tran(z1a04,rRPIC4)+tran(z1a05,rRPIC4)+tran(z1a06,rRPIC4))
           rl()
           rl(space(_M)+space(17)+tran(z1b01,rRPIC1)+tran(z1b02,rRPIC1)+tran(z1b03,rRPIC1)+tran(z1b04,rRPIC1)+tran(z1b05,rRPIC1)+tran(z1b06,rRPIC1))
           rl()
           rl()
           rl(space(_M)+space(17)+tran(z1a07,rRPIC4)+tran(z1a08,rRPIC4)+tran(z1a09,rRPIC4)+tran(z1a10,rRPIC4)+tran(z1a11,rRPIC4)+tran(z1a12,rRPIC4))
           rl()
           rl(space(_M)+space(17)+tran(z1b07,rRPIC1)+tran(z1b08,rRPIC1)+tran(z1b09,rRPIC1)+tran(z1b10,rRPIC1)+tran(z1b11,rRPIC1)+tran(z1b12,rRPIC1))
      case _STR=2
           for x=1 to _G
               rl()
           next
           rl(space(_M)+space(16)+tran(z201,rRPIC1)+tran(z202,rRPIC1)+tran(z203,rRPIC1)+tran(z204,rRPIC1)+tran(z205,rRPIC1)+tran(z206,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z207,rRPIC1)+tran(z208,rRPIC1)+tran(z209,rRPIC1)+tran(z210,rRPIC1)+tran(z211,rRPIC1)+tran(z212,rRPIC1))
           for x=1 to 5
               rl()
           next
           rl(space(_M)+space(16)+tran(z301,rRPIC1)+tran(z302,rRPIC1)+tran(z303,rRPIC1)+tran(z304,rRPIC1)+tran(z305,rRPIC1)+tran(z306,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z307,rRPIC1)+tran(z308,rRPIC1)+tran(z309,rRPIC1)+tran(z310,rRPIC1)+tran(z311,rRPIC1)+tran(z312,rRPIC1))
           for x=1 to 5
               rl()
           next
           rl(space(_M)+space(16)+tran(z401,rRPIC1)+tran(z402,rRPIC1)+tran(z403,rRPIC1)+tran(z404,rRPIC1)+tran(z405,rRPIC1)+tran(z406,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z407,rRPIC1)+tran(z408,rRPIC1)+tran(z409,rRPIC1)+tran(z410,rRPIC1)+tran(z411,rRPIC1)+tran(z412,rRPIC1))
           for x=1 to 5
               rl()
           next
           rl(space(_M)+space(16)+tran(z501,rRPIC1)+tran(z502,rRPIC1)+tran(z503,rRPIC1)+tran(z504,rRPIC1)+tran(z505,rRPIC1)+tran(z506,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z507,rRPIC1)+tran(z508,rRPIC1)+tran(z509,rRPIC1)+tran(z510,rRPIC1)+tran(z511,rRPIC1)+tran(z512,rRPIC1))
           for x=1 to 5
               rl()
           next
           rl(space(_M)+space(16)+tran(z601,rRPIC1)+tran(z602,rRPIC1)+tran(z603,rRPIC1)+tran(z604,rRPIC1))
           for x=1 to 9
               rl()
           next
           rl(space(_M)+space(16)+tran(z701,rRPIC1)+tran(z702,rRPIC1)+tran(z703,rRPIC1)+tran(z704,rRPIC1)+tran(z705,rRPIC1)+tran(z706,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z707,rRPIC1)+tran(z708,rRPIC1)+tran(z709,rRPIC1)+tran(z710,rRPIC1)+tran(z711,rRPIC1)+tran(z712,rRPIC1))
      case _STR=3
           for x=1 to _G
               rl()
           next
           rl(space(_M)+space(16)+tran(z801,rRPIC1)+tran(z802,rRPIC1)+tran(z803,rRPIC1)+tran(z804,rRPIC1)+tran(z805,rRPIC1)+tran(z806,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z807,rRPIC1)+tran(z808,rRPIC1)+tran(z809,rRPIC1)+tran(z810,rRPIC1)+tran(z811,rRPIC1)+tran(z812,rRPIC1))
           for x=1 to 5
               rl()
           next
           rl(space(_M)+space(16)+tran(z1001,rRPIC1)+tran(z1002,rRPIC1)+tran(z1003,rRPIC1)+tran(z1004,rRPIC1)+tran(z1005,rRPIC1)+tran(z1006,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z1007,rRPIC1)+tran(z1008,rRPIC1)+tran(z1009,rRPIC1)+tran(z1010,rRPIC1)+tran(z1011,rRPIC1)+tran(z1012,rRPIC1))
           for x=1 to 5
               rl()
           next
           rl(space(_M)+space(16)+tran(z901,rRPIC1)+tran(z902,rRPIC1)+tran(z903,rRPIC1)+tran(z904,rRPIC1)+tran(z905,rRPIC1)+tran(z906,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z907,rRPIC1)+tran(z908,rRPIC1)+tran(z909,rRPIC1)+tran(z910,rRPIC1)+tran(z911,rRPIC1)+tran(z912,rRPIC1))
           for x=1 to 7
               rl()
           next
           rl(space(_M)+space(16)+tran(z1101,rRPIC1)+tran(z1102,rRPIC1)+tran(z1103,rRPIC1)+tran(z1104,rRPIC1)+tran(z1105,rRPIC1)+tran(z1106,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z1107,rRPIC1)+tran(z1108,rRPIC1)+tran(z1109,rRPIC1)+tran(z1110,rRPIC1)+tran(z1111,rRPIC1)+tran(z1112,rRPIC1))
           for x=1 to 5
               rl()
           next
           rl(space(_M)+space(16)+tran(z1201,rRPIC1)+tran(z1202,rRPIC1)+tran(z1203,rRPIC1)+tran(z1204,rRPIC1)+tran(z1205,rRPIC1)+tran(z1206,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z1207,rRPIC1)+tran(z1208,rRPIC1)+tran(z1209,rRPIC1)+tran(z1210,rRPIC1)+tran(z1211,rRPIC1)+tran(z1212,rRPIC1))
      case _STR=4
           DeklPodp()
           for x=1 to _G
               rl()
           next
           rl(space(_M)+space(16)+tran(z1301,rRPIC1)+tran(z1302,rRPIC1)+tran(z1303,rRPIC1)+tran(z1304,rRPIC1)+tran(z1305,rRPIC1)+tran(z1306,rRPIC1))
           for x=1 to 3
               rl()
           next
           rl(space(_M)+space(16)+tran(z1307,rRPIC1)+tran(z1308,rRPIC1)+tran(z1309,rRPIC1)+tran(z1310,rRPIC1)+tran(z1311,rRPIC1)+tran(z1312,rRPIC1))
           for x=1 to 20
               rl()
           next
           rl(space(_M)+space(9)+zDEKLIMIE+space(7)+zDEKLNAZWI)
      endcase
   case _OU='P'
      DeklPodp( 'T' )
      clear type
      rl(padc('PIT-4R  DEKLARACJA ROCZNA O POBRANYCH ZALICZKACH NA PODATEK DOCHODOWY',80))
      rl('(01) Identyfikator podatkowy NIP p&_l.atnika : '+P1)
      rl('(04) Za rok : '+P3+'.'+P4)
      rl()
      rl(padc('A. MIEJSCE I CEL SK&__L.ADANIA DEKLARACJI',80))
      rl(padc('=====================================',80))
      rl('(05) Urz&_a.d Skarbowy: '+P6)
      if zDEKLKOR='D'
         rl('(06) Z&_l.o&_z.enie deklaracji')
      else
         rl('(06) Korekta deklaracji')
      endif
      rl()
      rl(padc('B. DANE P&__L.ATNIKA',80))
      rl(padc('================',80))
      if spolka_
         rl('B.1. P&__L.ATNIK NIEB&__E.D&__A.CY OSOB&__A. FIZYCZN&__A.')
         rl('-------------------------------------')
         rl('(08) '+P8)
      else
         rl('B.1. OSOBA FIZYCZNA')
         rl('-------------------')
         rl('(08) '+P8)
      endif
      rl()
      if spolka_
         rl('B.2. ADRES SIEDZIBY')
         rl('-------------------')
      else
         rl('B.2. ADRES ZAMIESZKANIA')
         rl('-----------------------')
      endif
      rl('( 9) Kraj.: '+P16+'   (10) Wojew&_o.dztwo: '+P17)
      rl('(11) Powiat: '+p17a+'   (12) Gmina: '+P18)
      rl('(13) Ulica: '+P19+' (14) Nr domu: '+P20+' (15) Nr lokalu: '+P21)
      rl('(16) Miejsc: '+P22+' (17) Kod: '+P23+' (18) Poczta: '+P24)
      appe blan
      appe blan
      repl linia_l with padc('C. WYKAZ NALE&__Z.NYCH ZALICZEK NA PODATEK DOCHODOWY ZA POSZCZEG&__O.LNE MIESI&__A.CE',80)
      appe blan
      repl linia_l with padc('=========================================================================',80)
      appe blan
      repl linia_l with '1.Zaliczki na podatek obliczone przez platnikow,o ktorych mowa w art.31'
      appe blan
      repl linia_l with '  i art.42e ust.1,od dochodow wymienionych w tych przepisach'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Il.pod.:'+kwota(z1a01,8,0)+'   '+kwota(z1a02,8,0)+'   '+kwota(z1a03,8,0)+'   '+kwota(z1a04,8,0)+'   '+kwota(z1a05,8,0)+'   '+kwota(z1a06,8,0)
      appe blan
      repl linia_l with 'Nal.zal:'+kwota(z1b01,10,0)+' '+kwota(z1b02,10,0)+' '+kwota(z1b03,10,0)+' '+kwota(z1b04,10,0)+' '+kwota(z1b05,10,0)+' '+kwota(z1b06,10,0)
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with 'Il.pod.:'+kwota(z1a07,8,0)+'   '+kwota(z1a08,8,0)+'   '+kwota(z1a09,8,0)+'   '+kwota(z1a10,8,0)+'   '+kwota(z1a11,8,0)+'   '+kwota(z1a12,8,0)
      appe blan
      repl linia_l with 'Nal.zal:'+kwota(z1b07,10,0)+' '+kwota(z1b08,10,0)+' '+kwota(z1b09,10,0)+' '+kwota(z1b10,10,0)+' '+kwota(z1b11,10,0)+' '+kwota(z1b12,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '2.Zaliczki na podatek obliczone przez platnikow,o ktorych mowa w art.33-35'
      appe blan
      repl linia_l with '  ustawy od dochodow wymienionych w tych przepisach'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Nalezne '+kwota(z201,10,0)+' '+kwota(z202,10,0)+' '+kwota(z203,10,0)+' '+kwota(z204,10,0)+' '+kwota(z205,10,0)+' '+kwota(z206,10,0)
      appe blan
      repl linia_l with 'zaliczki -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z207,10,0)+' '+kwota(z208,10,0)+' '+kwota(z209,10,0)+' '+kwota(z210,10,0)+' '+kwota(z211,10,0)+' '+kwota(z212,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '3.Suma naleznych zaliczek za poszczegolne miesiace roku podatkowego'
      appe blan
      repl linia_l with '  wykazanych w wierszach 1 i 2'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with 'Suma         I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'nalezn. '+kwota(z301,10,0)+' '+kwota(z302,10,0)+' '+kwota(z303,10,0)+' '+kwota(z304,10,0)+' '+kwota(z305,10,0)+' '+kwota(z306,10,0)
      appe blan
      repl linia_l with 'zaliczek -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z307,10,0)+' '+kwota(z308,10,0)+' '+kwota(z309,10,0)+' '+kwota(z310,10,0)+' '+kwota(z311,10,0)+' '+kwota(z312,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '4.Zaliczki na podatek, ktorych pobor zostal ograniczony na podstawie'
      appe blan
      repl linia_l with '  art.32 ust.2 ustawy'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z401,10,0)+' '+kwota(z402,10,0)+' '+kwota(z403,10,0)+' '+kwota(z404,10,0)+' '+kwota(z405,10,0)+' '+kwota(z406,10,0)
      appe blan
      repl linia_l with 'zaliczek -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z407,10,0)+' '+kwota(z408,10,0)+' '+kwota(z409,10,0)+' '+kwota(z410,10,0)+' '+kwota(z411,10,0)+' '+kwota(z412,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '5.Zaliczki, ktore przypadaly do pobrania w zwiazku z ograniczeniem poboru'
      appe blan
      repl linia_l with '  zaliczek w poprzednich miesiacach na podstawie art.32 ust.2 ustawy'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z501,10,0)+' '+kwota(z502,10,0)+' '+kwota(z503,10,0)+' '+kwota(z504,10,0)+' '+kwota(z505,10,0)+' '+kwota(z506,10,0)
      appe blan
      repl linia_l with 'zaliczek -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z507,10,0)+' '+kwota(z508,10,0)+' '+kwota(z509,10,0)+' '+kwota(z510,10,0)+' '+kwota(z511,10,0)+' '+kwota(z512,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '6.Dodatkowo pobrany podatek wynikajacy z rozliczenia za rok ubiegly'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z601,10,0)+' '+kwota(z602,10,0)+' '+kwota(z603,10,0)+' '+kwota(z604,10,0)
      appe blan
      repl linia_l with 'podatku  -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with ''
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '7.Nadplaty wynikajace z rozliczenia za rok ubiegly oraz zwrot nadplat'
      appe blan
      repl linia_l with '  w gotowce zaliczone na poczet naleznej zaliczki'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with 'Kwoty        I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'nadplaty'+kwota(z701,10,0)+' '+kwota(z702,10,0)+' '+kwota(z703,10,0)+' '+kwota(z704,10,0)+' '+kwota(z705,10,0)+' '+kwota(z706,10,0)
      appe blan
      repl linia_l with 'zaliczon.-----------------------------------------------------------------'
      appe blan
      repl linia_l with 'i zwroco.   VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with 'w gotow.'+kwota(z707,10,0)+' '+kwota(z708,10,0)+' '+kwota(z709,10,0)+' '+kwota(z710,10,0)+' '+kwota(z711,10,0)+' '+kwota(z712,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '8.Pobrany podatek, przekazany na PFRON oraz zakladowy fundusz rehabilitacji'
      appe blan
      repl linia_l with '  osob niepelnosprawnych oraz zakladowy fundusz aktywnosci'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z801,10,0)+' '+kwota(z802,10,0)+' '+kwota(z803,10,0)+' '+kwota(z804,10,0)+' '+kwota(z805,10,0)+' '+kwota(z806,10,0)
      appe blan
      repl linia_l with 'podatku  -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z807,10,0)+' '+kwota(z808,10,0)+' '+kwota(z809,10,0)+' '+kwota(z810,10,0)+' '+kwota(z811,10,0)+' '+kwota(z812,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '9.Zaliczki na podatek pobrane od swiadczen z tytulu dzialalnosci okreslonej'
      appe blan
      repl linia_l with '   w art.13 pkt 2 i 4-9 oraz art.18 ustawy'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z1001,10,0)+' '+kwota(z1002,10,0)+' '+kwota(z1003,10,0)+' '+kwota(z1004,10,0)+' '+kwota(z1005,10,0)+' '+kwota(z1006,10,0)
      appe blan
      repl linia_l with 'zaliczek -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z1007,10,0)+' '+kwota(z1008,10,0)+' '+kwota(z1009,10,0)+' '+kwota(z1010,10,0)+' '+kwota(z1011,10,0)+' '+kwota(z1012,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '10.Zaliczki na podatek pobrane od innych naleznosci, w tym wynikajacych z umowy'
      appe blan
      repl linia_l with '   aktywizacyjnej'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z901,10,0)+' '+kwota(z902,10,0)+' '+kwota(z903,10,0)+' '+kwota(z904,10,0)+' '+kwota(z905,10,0)+' '+kwota(z906,10,0)
      appe blan
      repl linia_l with 'zaliczek -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z907,10,0)+' '+kwota(z908,10,0)+' '+kwota(z909,10,0)+' '+kwota(z910,10,0)+' '+kwota(z911,10,0)+' '+kwota(z912,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '11.Pobrany podatek do przekazania do urzedu skarbowego za poszczegolne'
      appe blan
      repl linia_l with '   miesiace roku podatkowego'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z1101,10,0)+' '+kwota(z1102,10,0)+' '+kwota(z1103,10,0)+' '+kwota(z1104,10,0)+' '+kwota(z1105,10,0)+' '+kwota(z1106,10,0)
      appe blan
      repl linia_l with 'podatku  -----------------------------------------------------------------'
      appe blan
      repl linia_l with '            VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z1107,10,0)+' '+kwota(z1108,10,0)+' '+kwota(z1109,10,0)+' '+kwota(z1110,10,0)+' '+kwota(z1111,10,0)+' '+kwota(z1112,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '12.Wynagrodzenie z tytulu terminowego wplacania podatku dochodowego za'
      appe blan
      repl linia_l with '   poszczegolne miesiace, zgodnie z art.28 Ordynacji podatkowej'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z1201,10,0)+' '+kwota(z1202,10,0)+' '+kwota(z1203,10,0)+' '+kwota(z1204,10,0)+' '+kwota(z1205,10,0)+' '+kwota(z1206,10,0)
      appe blan
      repl linia_l with 'wynagro- -----------------------------------------------------------------'
      appe blan
      repl linia_l with 'dzenia      VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z1207,10,0)+' '+kwota(z1208,10,0)+' '+kwota(z1209,10,0)+' '+kwota(z1210,10,0)+' '+kwota(z1211,10,0)+' '+kwota(z1212,10,0)
      appe blan
      repl linia_l with '=========================================================================='
      appe blan
      repl linia_l with '13.Nalezne kwoty do wplaty za poszczegolne miesiace roku podatkowego'
      appe blan
      repl linia_l with '--------------------------------------------------------------------------'
      appe blan
      repl linia_l with '             I          II        III         IV         V          VI    '
      appe blan
      repl linia_l with 'Kwoty   '+kwota(z1301,10,0)+' '+kwota(z1302,10,0)+' '+kwota(z1303,10,0)+' '+kwota(z1304,10,0)+' '+kwota(z1305,10,0)+' '+kwota(z1306,10,0)
      appe blan
      repl linia_l with 'do       -----------------------------------------------------------------'
      appe blan
      repl linia_l with 'wplaty      VII        VIII        IX          X         XI         XII   '
      appe blan
      repl linia_l with '        '+kwota(z1307,10,0)+' '+kwota(z1308,10,0)+' '+kwota(z1309,10,0)+' '+kwota(z1310,10,0)+' '+kwota(z1311,10,0)+' '+kwota(z1312,10,0)
   CASE _OU == 'X'
        edeklaracja_plik = 'PIT_4R_8_' + normalizujNazwe(AllTrim(symbol_fir)) + '_' + AllTrim(p4r)
        IF ( zCzyKorekta := edekCzyKorekta() ) > 0
           IF zCzyKorekta == 2
              tresc_korekty_pit4r = edekOrdZuTrescPobierz('PIT-4R', Val(ident_fir), 0)
              zDEKLKOR = 'K'
           ENDIF
           IF zDEKLKOR != 'K' .OR. (zDEKLKOR == 'K' .AND. ValType(tresc_korekty_pit4r) == "C")
              private danedekl
              danedekl = edek_pit4r_8()
              edekZapiszXml(danedekl, edeklaracja_plik, wys_edeklaracja, 'PIT4R-8', zDEKLKOR == 'K')
           ENDIF
        ENDIF
   other //_OU='K'
        DeklPodp( 'T' )
        SWITCH GraficznyCzyTekst()
        CASE 0
           EXIT
        CASE 1
           DeklarDrukuj( 'PIT4R-8' )
           EXIT
        CASE 2
           do kpit_4r
           IF zDEKLKOR <> 'D'
              IF tnesc(,'Czy wydrukowa† formularz przyczyn korekty ORD-ZU? (T/N)')
                 tresc_korekty_pit4r := edekOrdZuTrescPobierz('PIT-4R', Val(ident_fir), 0)
                 IF ValType(tresc_korekty_pit4r) == "C"
                    kartka_ordzu(P1,;
                       iif(spolka_, P8n, naz_imie_naz(P8n)),;
                       iif(spolka_, '', naz_imie_imie(P8n)),;
                       iif(spolka_, '', DToC(P8d)),;
                       iif(spolka_, P8r, ''),;
                       '', '', '', '', '', tresc_korekty_pit4r)
                 ENDIF
              ENDIF
           ENDIF
        ENDSWITCH
   endcase
end
close_()
