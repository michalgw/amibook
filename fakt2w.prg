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

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=129
      _strona=.f.
      _czy_mon=.f.
      _czy_close=.f.
      czesc=1
      *------------------------------
      _szerokosc=129
      _koniec="del#[+].or.ident#zident"
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      zident=str(rec_no,8)
      select pozycjew
      seek [+]+zident
      nr_rec=recno()
      licznik=0
      do while del=[+].and.ident=zident
         licznik=licznik+1
         skip
      enddo
      go nr_rec
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      mon_drk([ö]+procname())
*@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      select firma
      zm=scal(alltrim(nazwa)+[, ]+kod_p+' '+alltrim(miejsc)+[, ]+alltrim(ulica)+[ ]+alltrim(nr_domu)+iif(.not.empty(alltrim(nr_mieszk)),[/],[ ])+alltrim(nr_mieszk))
      if fakturyw->UE='T'
         zNIP=NIPue
      else
         zNIP=NIP
      endif
      zTEL=TEL
      zFAX=FAX
      zREGON=substr(NR_REGON,1,11)
      select 1
      Zrach=fakturyw->RACH
      k55=''
sprawdzVAT(10,fakturyw->DATAS)
      if fakturyw->DATAS<>ctod('    .  .  ')
         k55='Data powstania obowi&_a.zku podatkowego '+dtoc(fakturyw->DATAS)
*         k55='Data sprzeda&_z.y-'+substr(dtoc(fakturyw->DATAS),1,7)
      else
         k55='Data powstania obowi&_a.zku podatkowego '+strtran(param_rok+[.]+fakturyw->mc+[.]+fakturyw->dzien,' ','0')
*         k55='Data sprzeda&_z.y-'+strtran(param_rok+[.]+fakturyw->mc,' ','0')
      endif
*      k56=''
*      if fakturyw->DATAZ<>ctod('    .  .  ')
*         k56='Data zaliczki-'+dtoc(fakturyw->DATAZ)
*      endif
*     k7=dos_c(substr(zm,76,25))
      k2=dos_p(iif(len(alltrim(firma->fakt_miej))=0,firma->miejsc,firma->fakt_miej))
      k3=strtran(param_rok+[.]+fakturyw->mc+[.]+fakturyw->dzien,' ','0')
      k6=alltrim(str(fakturyw->numer,5))+[/]+param_rok
      k8=[DOSTAWCA..: ]+alltrim(fakturyw->nazwa)+[ ]+alltrim(fakturyw->adres)
      k08=[            ]+'Nr ident.:'+alltrim(fakturyw->NR_IDENT)
      odebral=fakturyw->odbosoba
      k9=''
      k9a=''
//003 nowy warunek dla obslugi wydruku komentarza
*     if fakturyw->zamowienie<>space(40)
         k9='Dotyczy:'+alltrim(fakturyw->zamowienie)
         k9a='Wyliczono z waluty '+fakturyw->waluta+' wg kursu '+alltrim(transform(fakturyw->kurs,'99999.9999'))+' z dnia '+transform(fakturyw->kursdata,'@D')+' (Tabela kursowa '+alltrim(fakturyw->tabela)+' )'
*     endif
*     if fakturyw->komentarz<>space(80)
*         k9=k9+' '+alltrim(fakturyw->komentarz)
*     endif
      mon_drk(padl(k2+[, dnia ]+k3,129))
      mon_drk(padl(k55,129))
      mon_drk([ ])
*      mon_drk([                                                                                                        ]+k56)
      if zRACH='F'
         if nr_uzytk<>32
            mon_drk([ ]+space(25)+[          F A K T U R A   V A T   W E W N &__E. T R Z N A   Nr  ]+k6)
            mon_drk(padc(alltrim(fakturyw->opisfakt),129))
         else
            mon_drk([ ]+space(25)+[                  F A K T U R A   V A T  ZPChr  Nr  ]+k6)
         endif
      else
         if nr_uzytk<>32
            mon_drk([ ]+space(25)+[                R A C H U N E K   U P R O S Z C Z O N Y   Nr  ]+k6)
         else
            mon_drk([ ]+space(25)+[          R A C H U N E K   U P R O S Z C Z O N Y  ZPChr  Nr  ]+k6)
         endif
      endif
      mon_drk([ ])
      if nr_uzytk=716
         mon_drk([])
         mon_drk([])
         mon_drk([])
      endif
      mon_drk([NABYWCA...: ]+zm)
      mon_drk([            Nr ident.:]+zNIP+[   REGON: ]+zREGON+[   tel.:]+zTEL+[   fax:]+zFAX)
      mon_drk(k8)
      mon_drk(k08)
      if len(k9)>0
         mon_drk(k9)
      endif
      mon_drk(k9a)
*     if alltrim(fakturyw->nazwa)<>alltrim(fakturyw->odbnazwa).or.alltrim(fakturyw->adres)<>alltrim(fakturyw->odbadres)
*        mon_drk(k8o)
*     endif
      mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³              Nazwa towaru              ³    PKWiU     ³        ³Jedn.³     Cena   ³   Warto&_s.&_c.   VAT     Warto&_s.&_c.  ³   Warto&_s.&_c.  ³])
      mon_drk([³                                        ³              ³  Ilo&_s.&_c. ³miary³   netto    ³    netto     %      podatku  ³   brutto   ³])
      mon_drk([ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄ´])
      store 0 to s0_5,s0_7,s0_8
      zWARTZW=0
      zWART08=0
      zWART00=0
      zWART07=0
      zWART02=0
      zWART22=0
      zWART12=0
      zzWARTZW=0
      zzWART08=0
      zzWART00=0
      zzWART07=0
      zzWART02=0
      zzWART22=0
      zzWART12=0
      zVAT07=0
      zVAT02=0
      zVAT22=0
      zVAT12=0
      zPODATKI=fakturyw->PODATKI
      zCLO=fakturyw->CLO
      zTRANSPORT=fakturyw->TRANSPORT
      zPROWIZJA=fakturyw->PROWIZJA
      zOPAKOWAN=fakturyw->OPAKOWAN
      zUBEZPIECZ=fakturyw->UBEZPIECZ
      zINNEKOSZ=fakturyw->INNEKOSZ
      zRAZEMKOSZ=zPODATKI+zCLO+zTRANSPORT+zPROWIZJA+zOPAKOWAN+zUBEZPIECZ+zINNEKOSZ
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k1=towar
         k11=sww
         if wartosc=0
            k2=space(8)
         else
            if nr_uzytk=204
               zm=str(ilosc,8,2)
               if substr(zm,7,2)=='00'
                  zm=substr(zm,1,6)+'   '
               endif
            else
               zm=str(ilosc,8,3)
               if substr(zm,6,3)=='000'
                  zm=substr(zm,1,4)+'    '
               endif
            endif
            k2=zm
         endif
         k3=jm
         zwalcena=_round(fakturyw->kurs*cena,2)
         zwalwart=_round(zwalcena*ilosc,2)
         k4=iif(wartosc=0.0,space(12),kwota(zwalcena,12,2))
         k5=zwalwart
         k6=iif(zwalwart=0.0,space(2),vat)
         k7=_round((val(vat)/100)*zwalwart,2)
         k8=k5+k7
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s0_5=s0_5+k5
         do case
         case k6='ZW'
              zWARTZW=zWARTZW+k5
              zzWARTZW=zzWARTZW+k5
         case k6='NP'
              zWART08=zWART08+k5
              zzWART08=zzWART08+k5
         case k6='0 '
              zWART00=zWART00+k5
              zzWART00=zzWART00+k5
         case alltrim(k6)=str(vat_B,1)
              zWART07=zWART07+k5
              zzWART07=zzWART07+k5
         case alltrim(k6)=str(vat_C,1)
              zWART02=zWART02+k5
              zzWART02=zzWART02+k5
         case alltrim(k6)=str(vat_D,1)
              zWART12=zWART12+k5
              zzWART12=zzWART12+k5
         case alltrim(k6)=str(vat_A,2)
              zWART22=zWART22+k5
              zzWART22=zzWART22+k5
         endcase
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+substr(k1,1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','NP',k6)+[ ]+space(12)+[³]+space(12)+[³])
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=0
         do case
         endcase
         _grupa=.f.
      enddo
      zRESZKOSZ=0
      if zRAZEMKOSZ<>0.0
      if zWART08<>0.0
         k1='Koszty zakupu proporcj&_a. do stawki VAT'
         k11=space(14)
         k2=str(1,4,0)+space(4)
         k3=space(5)
         zwalcena=_round(zRAZEMKOSZ/(zzWARTZW+zzWART08+zzWART00+zzWART07+zzWART02+zzWART22+zzWART12)*zzWARTZW,2)
         if abs(zRAZEMKOSZ-(zRESZKOSZ+zwalcena))=0.01
            zRESZKOSZ=zRAZEMKOSZ
         else
            zRESZKOSZ=zRESZKOSZ+zwalcena
         endif
         k4=kwota(zwalcena,12,2)
         k5=zwalcena
         k6='NP'
         k7=_round((val('NP')/100)*zwalcena,2)
         zWART08=zWART08+k5
         s0_5=s0_5+k5
         k8=k5+k7
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+padr(k1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','  ',k6)+[ ]+space(12)+[³]+space(12)+[³])
      endif
      if zWARTZW<>0.0
         k1='Koszty zakupu proporcj&_a. do stawki VAT'
         k11=space(14)
         k2=str(1,4,0)+space(4)
         k3=space(5)
         zwalcena=_round(zRAZEMKOSZ/(zzWARTZW+zzWART08+zzWART00+zzWART07+zzWART02+zzWART22+zzWART12)*zzWARTZW,2)
         if abs(zRAZEMKOSZ-(zRESZKOSZ+zwalcena))=0.01
            zRESZKOSZ=zRAZEMKOSZ
         else
            zRESZKOSZ=zRESZKOSZ+zwalcena
         endif
         k4=kwota(zwalcena,12,2)
         k5=zwalcena
         k6='ZW'
         k7=_round((val('ZW')/100)*zwalcena,2)
         zWARTZW=zWARTZW+k5
         s0_5=s0_5+k5
         k8=k5+k7
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+padr(k1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','  ',k6)+[ ]+space(12)+[³]+space(12)+[³])
      endif
      if zWART00<>0.0
         k1='Koszty zakupu proporcj&_a. do stawki VAT'
         k11=space(14)
         k2=str(1,4,0)+space(4)
         k3=space(5)
         zwalcena=_round(zRAZEMKOSZ/(zzWARTZW+zzWART08+zzWART00+zzWART07+zzWART02+zzWART22+zzWART12)*zzWART00,2)
         if abs(zRAZEMKOSZ-(zRESZKOSZ+zwalcena))=0.01
            zRESZKOSZ=zRAZEMKOSZ
         else
            zRESZKOSZ=zRESZKOSZ+zwalcena
         endif
         k4=kwota(zwalcena,12,2)
         k5=zwalcena
         k6='0 '
         k7=_round((val('0 ')/100)*zwalcena,2)
         zWART00=zWART00+k5
         s0_5=s0_5+k5
         k8=k5+k7
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+padr(k1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','  ',k6)+[ ]+space(12)+[³]+space(12)+[³])
      endif
      if zWART02<>0.0
         k1='Koszty zakupu proporcj&_a. do stawki VAT'
         k11=space(14)
         k2=str(1,4,0)+space(4)
         k3=space(5)
         zwalcena=_round(zRAZEMKOSZ/(zzWARTZW+zzWART08+zzWART00+zzWART07+zzWART02+zzWART22+zzWART12)*zzWART02,2)
         if abs(zRAZEMKOSZ-(zRESZKOSZ+zwalcena))=0.01
            zRESZKOSZ=zRAZEMKOSZ
         else
            zRESZKOSZ=zRESZKOSZ+zwalcena
         endif
         k4=kwota(zwalcena,12,2)
         k5=zwalcena
         k6=str(vat_C,2)
         k7=_round((vat_C/100)*zwalcena,2)
         zWART02=zWART02+k5
         s0_5=s0_5+k5
         k8=k5+k7
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+padr(k1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','  ',k6)+[ ]+space(12)+[³]+space(12)+[³])
      endif
      if zWART07<>0.0
         k1='Koszty zakupu proporcj&_a. do stawki VAT'
         k11=space(14)
         k2=str(1,4,0)+space(4)
         k3=space(5)
         zwalcena=_round(zRAZEMKOSZ/(zzWARTZW+zzWART08+zzWART00+zzWART07+zzWART02+zzWART22+zzWART12)*zzWART07,2)
         if abs(zRAZEMKOSZ-(zRESZKOSZ+zwalcena))=0.01
            zRESZKOSZ=zRAZEMKOSZ
         else
            zRESZKOSZ=zRESZKOSZ+zwalcena
         endif
         k4=kwota(zwalcena,12,2)
         k5=zwalcena
         k6=str(vat_B,2)
         k7=_round((vat_B/100)*zwalcena,2)
         zWART07=zWART07+k5
         s0_5=s0_5+k5
         k8=k5+k7
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+padr(k1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','  ',k6)+[ ]+space(12)+[³]+space(12)+[³])
      endif
      if zWART12<>0.0
         k1='Koszty zakupu proporcj&_a. do stawki VAT'
         k11=space(14)
         k2=str(1,4,0)+space(4)
         k3=space(5)
         zwalcena=_round(zRAZEMKOSZ/(zzWARTZW+zzWART08+zzWART00+zzWART07+zzWART02+zzWART22+zzWART12)*zzWART12,2)
         if abs(zRAZEMKOSZ-(zRESZKOSZ+zwalcena))=0.01
            zRESZKOSZ=zRAZEMKOSZ
         else
            zRESZKOSZ=zRESZKOSZ+zwalcena
         endif
         k4=kwota(zwalcena,12,2)
         k5=zwalcena
         k6=str(vat_D,2)
         k7=_round((vat_D/100)*zwalcena,2)
         zWART12=zWART12+k5
         s0_5=s0_5+k5
         k8=k5+k7
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+padr(k1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','  ',k6)+[ ]+space(12)+[³]+space(12)+[³])
      endif
      if zWART22<>0.0
         k1='Koszty zakupu proporcj&_a. do stawki VAT'
         k11=space(14)
         k2=str(1,4,0)+space(4)
         k3=space(5)
         zwalcena=_round(zRAZEMKOSZ/(zzWARTZW+zzWART08+zzWART00+zzWART07+zzWART02+zzWART22+zzWART12)*zzWART22,2)
         if abs(zRAZEMKOSZ-(zRESZKOSZ+zwalcena))=0.01
            zRESZKOSZ=zRAZEMKOSZ
         else
            zRESZKOSZ=zRESZKOSZ+zwalcena
         endif
         k4=kwota(zwalcena,12,2)
         k5=zwalcena
         k6=str(vat_A,2)
         k7=_round((vat_A/100)*zwalcena,2)
         zWART22=zWART22+k5
         s0_5=s0_5+k5
         k8=k5+k7
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+padr(k1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','  ',k6)+[ ]+space(12)+[³]+space(12)+[³])
      endif
      if zWART08<>0.0
         k1='Koszty zakupu proporcj&_a. do stawki VAT'
         k11=space(14)
         k2=str(1,4,0)+space(4)
         k3=space(5)
         zwalcena=_round(zRAZEMKOSZ/(zzWARTZW+zzWART08+zzWART00+zzWART07+zzWART02+zzWART22+zzWART12)*zzWART08,2)
         if abs(zRAZEMKOSZ-(zRESZKOSZ+zwalcena))=0.01
            zRESZKOSZ=zRAZEMKOSZ
         else
            zRESZKOSZ=zRESZKOSZ+zwalcena
         endif
         k4=kwota(zwalcena,12,2)
         k5=zwalcena
         k6='NP'
         k7=_round((val('NP')/100)*zwalcena,2)
         zWART08=zWART08+k5
         s0_5=s0_5+k5
         k8=k5+k7
         k5=iif(k5=0.0,space(12),kwota(k5,12,2))
         k7=iif(k7=0.0,space(12),kwota(k7,12,2))
         k8=iif(k8=0.0,space(12),kwota(k8,12,2))
         mon_drk([³]+padr(k1,40)+[³]+k11+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='NP','  ',k6)+[ ]+space(12)+[³]+space(12)+[³])
      endif
      endif
      zVAT07=_round(zWART07*(vat_B/100),2)
      zVAT02=_round(zWART02*(vat_C/100),2)
      zVAT22=_round(zWART22*(vat_A/100),2)
      zVAT12=_round(zWART12*(vat_D/100),2)
*      zVAT07=_round(zwart07*0.07,2)
*      zVAT02=_round(zwart02*0.03,2)
*      zVAT22=_round(zwart22*0.22,2)
*      zVAT12=_round(zwart12*0.12,2)
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      s0_7=zVAT07+zVAT02+zVAT22+zVAT12
      s0_8=zWARTZW+zWART08+zWART00+zWART07+zWART02+zWART22+zWART12+zVAT07+zVAT02+zVAT22+zVAT12
      s1_8=zWARTZW+zWART08+zWART00+zWART07+zWART02+zWART22+zWART12+zVAT07+zVAT02+zVAT22+zVAT12
      zm=wyraz(slownie(s1_8),50)
      zm=zm+space(150-len(zm))
      k1=left(zm,50)
      k2=substr(zm,51,50)
      k4=right(zm,50)
*     do case
*     case fakturyw->sposob_p=1
*          k5=[P&_l.atne przelewem w ci&_a.gu ]+str(fakturyw->termin_z,2)+[ dni na konto ]+iif(substr(firma->nr_konta,1,2)=='  ',substr(firma->nr_konta,4),firma->nr_konta)
*          k6=space(10)+firma->bank
*     case fakturyw->sposob_p=2
*          k6=space(50)
*          if fakturyw->termin_z=0
*             k5=[Zap&_l.acono got&_o.wk&_a.]
*          else
*             if fakturyw->kwota=0
*                k5=[P&_l.atne got&_o.wk&_a. w ci&_a.gu ]+str(fakturyw->termin_z,2)+[ dni]
*             else
*                k5=[Zap&_l.acono got&_o.wk&_a. ]+ltrim(kwota(fakturyw->kwota,13,2))
*                k6=[Do zap&_l.aty ]+ltrim(kwota(s0_8-fakturyw->kwota,13,2))+[ w terminie ]+str(fakturyw->termin_z,2)+[ dni]
*             endif
*          endif
*     case fakturyw->sposob_p=3
*          k5=[Zap&_l.acono czekiem]
*          k6=space(50)
*     endcase
      k7=code()
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([                                                                            w tym:  ³ ]+kwota(zWARTZW,12,2)+[  ZW ]+kwota(0,12,2)+[³]+kwota(zWARTZW,12,2)+'³')
      mon_drk([                                                                                    ³ ]+kwota(zWART00,12,2)+[   0 ]+kwota(0,12,2)+[³]+kwota(zWART00,12,2)+'³')
      mon_drk([ KWOTA NALE&__Z.NO&__S.CI:]+kwota(s1_8,14,2)+[                                                    ³ ]+kwota(zWART02,12,2)+[  ]+str(vat_C,2)+[ ]+kwota(zVAT02,12,2)+[³]+kwota(zWART02+zVAT02,12,2)+'³')
      mon_drk([ S &__L. O W N I E  :                                                                   ³ ]+kwota(zWART07,12,2)+[  ]+str(vat_B,2)+[ ]+kwota(zVAT07,12,2)+[³]+kwota(zWART07+zVAT07,12,2)+'³')
      mon_drk([ ]+k1                                            +[                                 ³ ]+kwota(zWART22,12,2)+[  ]+str(vat_A,2)+[ ]+kwota(zVAT22,12,2)+[³]+kwota(zWART22+zVAT22,12,2)+'³')
      mon_drk([ ]+k2                                            +'                                 ³ '+kwota(zWART08,12,2)+[  NP ]+kwota(0,12,2)+[³]+kwota(zWART08,12,2)+'³')
      mon_drk([ ]+k4                                            +[                                 ³ ]+kwota(zWART12,12,2)+[  ]+str(vat_D,2)+[ ]+kwota(zVAT12,12,2)+[³]+kwota(zWART12+zVAT12,12,2)+'³')
      mon_drk([                                                                             RAZEM  ÚÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÂÍÍÍÍÍÍÍÍÍÍÍÍ¿])
      mon_drk([ ]+padr('',78)+                                                              +[     ³ ]+kwota(s0_5,12,2)+[     ]+kwota(s0_7,12,2)+[³]+kwota(s0_8,12,2)+'³')
      mon_drk([ ]+padr('',78)+                                                              +[     ÀÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÁÍÍÍÍÍÍÍÍÍÍÍÍÙ])
      kosztyz1=''
      kosztyz2=''
      kosztyz3=''
      if zPODATKI<>0.0
         kosztyz1=kosztyz1+'Podatki='+alltrim(transform(zPODATKI,'9999999.99'))+' '
      endif
      if zCLO<>0.0
         kosztyz1=kosztyz1+'Clo,oplaty='+alltrim(transform(zCLO,'9999999.99'))+' '
      endif
      if zTRANSPORT<>0.0
         kosztyz1=kosztyz1+'Transport='+alltrim(transform(zTRANSPORT,'9999999.99'))+' '
      endif
      if zPROWIZJA<>0.0
         kosztyz2=kosztyz2+'Prowizja='+alltrim(transform(zPROWIZJA,'9999999.99'))+' '
      endif
      if zOPAKOWAN<>0.0
         kosztyz2=kosztyz2+'Opakowania='+alltrim(transform(zOPAKOWAN,'9999999.99'))+' '
      endif
      if zUBEZPIECZ<>0.0
         kosztyz2=kosztyz2+'Ubezpieczenia='+alltrim(transform(zUBEZPIECZ,'9999999.99'))+' '
      endif
      if zINNEKOSZ<>0.0
         kosztyz3=kosztyz3+'Inne koszty='+alltrim(transform(zINNEKOSZ,'9999999.99'))+' '
      endif
      if zRAZEMKOSZ<>0.0
         kosztyz3=kosztyz3+'RAZEM KOSZTY ZAKUPU='+alltrim(transform(zRAZEMKOSZ,'9999999.99'))+' '
      endif
      if zRAZEMKOSZ<>0.0
         mon_drk([W kosztach zakupu wykazano:])
      endif
      mon_drk(kosztyz1)
      mon_drk(padr(kosztyz2,85)+ewid_wyst)
      mon_drk(padr(kosztyz3,60)+[                        .....................................     ])
      if zRACH='F'
         mon_drk([                                                                                       faktur&_e. wystawi&_l. (data i podpis)])
      else
         mon_drk([                                                                                      rachunek wystawi&_l. (data i podpis)])
      endif
      mon_drk([])
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if _czy_close
   close_()
endif
