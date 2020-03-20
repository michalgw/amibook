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
      _prawa=125
      _strona=.f.
      _czy_mon=.f.
      _czy_close=.f.
      czesc=1
      *------------------------------
      _szerokosc=125
      _koniec="del#[+].or.ident#zident"
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      zident=str(rec_no,8)
      select pozycje
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
      zm1='KANCELARIA NOTARIALNA'
      do case
      case NR_UZYTK=800
           zm2='mgr OLGA MA&__L.ACHWIEJ'
      other
      endcase
      zm3=kod_p+' '+alltrim(miejsc)
      zm4=alltrim(ulica)+[ ]+alltrim(nr_domu)+iif(.not.empty(alltrim(nr_mieszk)),[/],[ ])+alltrim(nr_mieszk)
      zm5='Tel:'+alltrim(TEL)+'   Fax:'+alltrim(FAX)
      zm6=NIP
      select 1
      Zrach=faktury->RACH
sprawdzVAT(10,faktury->DATAS)
      k55=''
      if faktury->DATAS<>ctod('    .  .  ')
         k55='Data czynno&_s.ci   '+dtoc(faktury->DATAS)
      else
         k55='Data czynno&_s.ci   '+strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')
      endif
*     k56=''
*     if faktury->DATAZ<>ctod('    .  .  ')
*        k56='Data zaliczki-'+dtoc(faktury->DATAZ)
*     endif
      k57='ORYGINA&_L. / KOPIA'
*     k7=dos_c(substr(zm,76,25))
      k2=padl(firma->miejsc,30)
      k3='Data wystawienia '+strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')
      k6=alltrim(str(faktury->numer,5))+[/]+param_rok
      k81=faktury->nazwa
      k82=faktury->adres
      k83=faktury->NR_IDENT
      odebral=faktury->odbosoba
      opl1=faktury->oplskarb
      opl2=faktury->poddarow
      opl3=faktury->podcywil
      nrlp=0
      mon_drk([                                                                                                 ]+padl(k57,27))
      mon_drk([                                                                                                 ]+padl(k3,27))
      mon_drk([                                                                                                 ]+padl(k55,27))
      mon_drk([ÚÄUs&_l.ugodawcaÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿       ÚÄUs&_l.ugobiorcaÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³]+padc(zm1,52)+[³       ³                                                              ³])
      mon_drk([³]+padc(zm2,52)+[³       ³ ]+padc(alltrim(k81),60)+[ ³])
      mon_drk([³]+padc(zm3,52)+[³       ³ Adres: ]+k82+[              ³])
      mon_drk([³]+padc(zm4,52)+[³       ³                                                              ³])
      mon_drk([³]+padc(zm5,52)+[³       ³   NIP: ]+k83+[                        ³])
      mon_drk([³]+padc(zm6,52)+[³       ³                                                              ³])
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      mon_drk([])
      mon_drk(padc([F A K T U R A   V A T   Nr  ]+k6,125))
      mon_drk([I.])
      mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³L.p.³               Rodzaj czynnosci             ³    KU    ³  Wynagrodzenie   ³      Podatek VAT       ³  Kwota nalezna   ³])
      mon_drk([³    ³                                            ³          ³    notariusza    ³  stawka %      kwota   ³     (brutto)     ³])
      mon_drk([ÃÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      store 0 to s0_5,s0_7,s0_8
      zWARTZW=0
      zWART00=0
      zWART07=0
      zWART02=0
      zWART22=0
      zVAT07=0
      zVAT02=0
      zVAT22=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         nrlp++
         k1=towar
         k11=sww
         if wartosc=0
            k2=space(9)
         else
            if nr_uzytk=204
               zm=str(ilosc,9,2)
               if substr(zm,8,2)=='00'
                  zm=substr(zm,1,6)+'   '
               endif
            else
               zm=str(ilosc,9,3)
               if substr(zm,7,3)=='000'
                  zm=substr(zm,1,5)+'    '
               endif
            endif
            k2=zm
         endif
         k3=jm
         k4=iif(wartosc=0,space(13),kwota(cena,13,2))
         k5=wartosc
         k6=iif(wartosc=0,space(2),vat)
         k7=_round((val(vat)/100)*wartosc,2)
         k8=k5+k7
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s0_5=s0_5+k5
         do case
         case k6='ZW'
              zWARTZW=zWARTZW+k5
         case k6='0 '
              zWART00=zWART00+k5

         case alltrim(k6)=str(vat_B,1)
              zWART07=zWART07+k5
         case alltrim(k6)=str(vat_C,1)
              zWART02=zWART02+k5
         case alltrim(k6)=str(vat_A,2)
              zWART22=zWART22+k5

         endcase
         k5=iif(k5=0,space(12),kwota(k5,12,2))
         k7=iif(k7=0,space(12),kwota(k7,12,2))
         k8=iif(k8=0,space(12),kwota(k8,12,2))
         mon_drk([³ ]+str(nrlp,2)+[ ³  ]+substr(k1,1,40)+[  ³ ]+k11+[ ³  ]+k5+[    ³      ]+k6+[ ]+k7+[   ³   ]+k8+[   ³])
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=0
         do case
         endcase
         _grupa=.f.
      enddo
      zVAT07=_round(zWART07*(vat_B/100),2)
      zVAT02=_round(zWART02*(vat_C/100),2)
      zVAT22=_round(zWART22*(vat_A/100),2)

      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      s0_7=zVAT07+zVAT02+zVAT22
      s0_8=zWARTZW+zWART00+zWART07+zWART02+zWART22+zVAT07+zVAT02+zVAT22
      s1_8=zWARTZW+zWART00+zWART07+zWART02+zWART22+zVAT07+zVAT02+zVAT22
      zm=wyraz(slownie(s1_8),50)
      zm=zm+space(150-len(zm))
      k1=left(zm,50)
      k2=substr(zm,51,50)
      k4=right(zm,50)
      do case
      case faktury->sposob_p=1
           k5=[P&_l.atne przelewem w ci&_a.gu ]+str(faktury->termin_z,2)+[ dni na konto ]+firma->nr_konta
           k6=space(10)+firma->bank
      case faktury->sposob_p=2
           k6=space(50)
           if faktury->termin_z=0
              k5=[Zap&_l.acono got&_o.wk&_a.]
           else
              if faktury->kwota=0
                 k5=[P&_l.atne got&_o.wk&_a. w ci&_a.gu ]+str(faktury->termin_z,2)+[ dni]
              else
                 k5=[Zap&_l.acono got&_o.wk&_a. ]+ltrim(kwota(faktury->kwota,13,2))
                 k6=[Do zap&_l.aty ]+ltrim(kwota(s0_8-faktury->kwota,13,2))+[ w terminie ]+str(faktury->termin_z,2)+[ dni]
              endif
           endif
      case faktury->sposob_p=3
           k5=[Zap&_l.acono czekiem]
           k6=space(50)
      endcase
      k7=code()
      mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([                                                     w tym:  ³  ]+kwota(zWARTZW,12,2)+[    ³      ZW ]+kwota(0,12,2)+[   ³   ]+kwota(zWARTZW,12,2)+'   ³')
      mon_drk([                                                             ³  ]+kwota(zWART00,12,2)+[    ³       0 ]+kwota(0,12,2)+[   ³   ]+kwota(zWART00,12,2)+'   ³')
      mon_drk([ DO ZAP&__L.ATY     : ]+kwota(s1_8,14,2)+[                             ³  ]+kwota(zWART02,12,2)+[    ³     ]+str(vat_C,2)+[  ]+kwota(zVAT02,12,2)+[   ³   ]+kwota(zWART02+zVAT02,12,2)+'   ³')
      mon_drk([ S &__L. O W N I E  :                                            ³  ]+kwota(zWART07,12,2)+[    ³     ]+str(vat_B,2)+[  ]+kwota(zVAT07,12,2)+[   ³   ]+kwota(zWART07+zVAT07,12,2)+'   ³')
      mon_drk([ ]+k1                                            +[          ³  ]+kwota(zWART22,12,2)+[    ³     ]+str(vat_A,2)+[  ]+kwota(zVAT22,12,2)+[   ³   ]+kwota(zWART22+zVAT22,12,2)+'   ³')
      mon_drk([ ]+k2                                            +[          ÚÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÂÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÂÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¿])
      mon_drk([ ]+k4                                            +[   RAZEM  ³  ]+kwota(s0_5,12,2)+[    ³         ]+kwota(s0_7,12,2)+[   ³   ]+kwota(s0_8,12,2)+'   ³')
      mon_drk([                                                             ÀÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÁÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÁÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÙ])
      mon_drk([ ]+k5)
      mon_drk([ ]+k6)
      mon_drk([])
      mon_drk([                          ]+odebral+[                             ]+ewid_wyst)
      mon_drk([                         ................................                           .....................................     ])
      if zRACH='F'
         mon_drk([                             podpis osoby odbieraj&_a.cej                                 podpis i pieczec notariusza])
      else
         mon_drk([                         rachunek odebra&_l. (data i podpis)                             rachunek wystawi&_l. (data i podpis)])
      endif
      mon_drk([])
      mon_drk([II.])
      mon_drk([PONADTO POBRANO:])
      mon_drk([1) Op&_l.at&_e. skarbow&_a. w kwocie.........................]+kwota(opl1,12,2))
      mon_drk([   slownie: ]+padr(slownie(opl1),113))
      mon_drk([2) Podatek od darowizny w kwocie....................]+kwota(opl2,12,2))
      mon_drk([   slownie: ]+padr(slownie(opl2),113))
      mon_drk([3) Podatek od czynno&_s.ci cywilnoprawnych w kwocie....]+kwota(opl3,12,2))
      mon_drk([   slownie: ]+padr(slownie(opl3),113))
      mon_drk([])
      mon_drk([])
      mon_drk([&__L.&__A.CZNIE (pozycja I i II)...:]+kwota(s1_8+opl1+opl2+opl3,12,2))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
if _czy_close
   close_()
endif
