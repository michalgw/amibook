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
private DrukujPN := .F., Dopisek
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
      zm=scal(alltrim(nazwa)+[, ]+kod_p+' '+alltrim(miejsc)+[, ]+alltrim(ulica)+[ ]+alltrim(nr_domu)+iif(.not.empty(alltrim(nr_mieszk)),[/],[ ])+alltrim(nr_mieszk))
      if faktury->UE='T'
         zNIP=NIPue
      else
         zNIP=NIP
      endif
      zTEL=TEL
      zFAX=FAX
      zREGON=substr(NR_REGON,1,11)
      select 1
      Zrach=faktury->RACH
      k55=''
      k3=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')
      k3d=ctod(k3)
sprawdzVAT(10,faktury->DATAS)
      if faktury->DATAS<>ctod('    .  .  ')
*        @ 3,48 say iif(zDATA2TYP='D','dokonanie dost.towar.',iif(zDATA2TYP='T','zakonczenie dost.tow.',iif(zDATA2TYP='U','wykonanie uslugi     ',iif(zDATA2TYP='Z','zaliczka             ','dokonanie dost.towar.'))))
         do case
         case faktury->DATA2TYP='D'
              k55='data dokonania dostawy towaru: '+dtoc(faktury->DATAS)
         case faktury->DATA2TYP='T'
              k55='data zako&_n.czenia dostawy towaru: '+dtoc(faktury->DATAS)
         case faktury->DATA2TYP='U'
              k55='data wykonania us&_l.ugi: '+dtoc(faktury->DATAS)
         case faktury->DATA2TYP='Z'
              k55='data zaliczki: '+dtoc(faktury->DATAS)
         other
              k55='data dokonania dostawy towaru: '+dtoc(faktury->DATAS)
         endcase
*         k55='Data sprzeda&_z.y-'+substr(dtoc(faktury->DATAS),1,7)
      else
          k55='data dokonania dostawy towaru: '+k3
*         k55='Data sprzeda&_z.y-'+strtran(param_rok+[.]+faktury->mc,' ','0')
      endif
      k56=''
*      if faktury->DATAZ<>ctod('    .  .  ')
*         k56='Data zaliczki-'+dtoc(faktury->DATAZ)
*      endif
*     k7=dos_c(substr(zm,76,25))
*      k2=dos_p(iif(len(alltrim(firma->fakt_miej))=0,firma->miejsc,firma->fakt_miej))
      k6 := ZRach + '-' + StrTran( Str( faktury->numer, 5 ), ' ', '0' ) + '/' + param_rok
      k8=[NABYWCA...: ]+alltrim(faktury->nazwa)+[ ]+alltrim(faktury->adres)
      k08=[            ]+'Nr ident.:'+alltrim(faktury->NR_IDENT)
      if alltrim(faktury->nazwa)<>alltrim(faktury->odbnazwa).or.alltrim(faktury->adres)<>alltrim(faktury->odbadres)
         k8o=[ODBIORCA..: ]+alltrim(faktury->odbnazwa)+[ ]+alltrim(faktury->odbadres)
      endif
      odebral=faktury->odbosoba
      k9=''
//003 nowy warunek dla obslugi wydruku komentarza
      if faktury->komentarz<>space(60)
         k9='UWAGI:'+faktury->komentarz
      endif
      if faktury->zamowienie<>space(30)
         k9=k9+'Zam&_o.wienie:'+faktury->zamowienie
      endif

      k3reprint=k3
      k6reprint=k6

      if zRACH='F'
         mon_drk([ ]+padc([F A K T U R A   Nr  ]+k6,129))
      else
         mon_drk([ ]+space(25)+[                R A C H U N E K   U P R O S Z C Z O N Y   Nr  ]+k6)
      endif
      if k3<>dtoc(faktury->DATAS)
         mon_drk([ ]+padc([data wystawienia: ]+k3+[   ]+k55,129))
      else
         mon_drk([ ]+padc([data wystawienia: ]+k3,129))
      endif
      mon_drk([ ]+padc(alltrim(faktury->FAKTTYP),129))
      if zduplikat='T'
         mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ DUPLIKAT-wystawiono dnia ]+dtoc(zduplikatd)+[ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
      else
         mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
      endif
      if nr_uzytk=716
         mon_drk([])
         mon_drk([])
         mon_drk([])
      endif
      mon_drk([SPRZEDAWCA: ]+zm)
      mon_drk([            Nr ident.:]+zNIP+[   REGON: ]+zREGON+[   tel.:]+zTEL+[   fax:]+zFAX)
      mon_drk(k8)
      mon_drk(k08)
      if len(k9)>0
         mon_drk(k9)
      endif
      if alltrim(faktury->nazwa)<>alltrim(faktury->odbnazwa).or.alltrim(faktury->adres)<>alltrim(faktury->odbadres)
         mon_drk(k8o)
      endif
      mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³                     Nazwa towaru                      ³        ³Jedn.³     Cena   ³   Warto&_s.&_c.   VAT     Warto&_s.&_c.  ³   Warto&_s.&_c.  ³])
      mon_drk([³                       (us&_l.ugi)                        ³  Ilo&_s.&_c. ³miary³   netto    ³    netto     %      podatku  ³   brutto   ³])
      mon_drk([ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄ´])
      store 0 to s0_5,s0_7,s0_8
      zWARTZW=0
      zWART08=0
      zWART00=0
      zWART07=0
      zWART02=0
      zWART22=0
      zWART12=0
      zWARTOO=0
      zVAT07=0
      zVAT02=0
      zVAT22=0
      zVAT12=0
      zVATOO=0
      zBRUT07=0
      zBRUT02=0
      zBRUT22=0
      zBRUT12=0
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
                  zm=substr(zm,1,5)+'   '
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
         k4=iif(wartosc=0,space(12),kwota(cena,12,2))
         k5=wartosc
         k6=iif(wartosc=0,space(2),vat)
         IF faktury->wartransp == 'T'
            k7 := VATWART
            k8 := BRUTTO
         ELSE
            k7=_round((val(vat)/100)*wartosc,2)
            k8=k5+k7
         ENDIF
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s0_5=s0_5+k5
         do case
         case k6='ZW'
              zWARTZW=zWARTZW+k5
         case k6='NP'
              zWART08=zWART08+k5
         case k6='0 '
              zWART00=zWART00+k5
         CASE k6 == 'PN' .OR. k6 == 'PU'
              zWARTOO=zWARTOO+k5
              DrukujPN := .T.
         case alltrim(k6)=str(vat_B,1)
              zWART07=zWART07+k5
              zVAT07 := zVAT07 + k7
              zBRUT07 := zBRUT07 + k8
         case alltrim(k6)=str(vat_C,1)
              zWART02=zWART02+k5
              zVAT02 := zVAT02 + k7
              zBRUT07 := zBRUT07 + k8
         case alltrim(k6)=str(vat_D,1)
              zWART12=zWART12+k5
              zVAT12 := zVAT12 + k7
              zBRUT07 := zBRUT07 + k8
         case alltrim(k6)=str(vat_A,2)
              zWART22=zWART22+k5
              zVAT22 := zVAT22 + k7
              zBRUT07 := zBRUT07 + k8
         endcase
         k5=iif(k5=0,space(12),kwota(k5,12,2))
         k7=iif(k7=0,space(12),kwota(k7,12,2))
         k8=iif(k8=0,space(12),kwota(k8,12,2))
         mon_drk([³]+substr(k1,1,55)+[³]+k2+[³]+k3+[³]+k4+[³ ]+k5+[  ]+iif(k6=='PN' .OR. k6=='PU','  ',k6)+[ ]+k7+[³]+k8+[³])
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=0
         do case
         endcase
         _grupa=.f.
      enddo
      IF faktury->wartransp <> 'T'
         zVAT12=_round(zWART12*(vat_D/100),2)
         zVAT07=_round(zWART07*(vat_B/100),2)
         zVAT02=_round(zWART02*(vat_C/100),2)
         zVAT22=_round(zWART22*(vat_A/100),2)
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      s0_7=zVAT07+zVAT02+zVAT22+zVAT12
      IF faktury->wartransp == 'T'
         s0_8=zWARTZW+zWART08+zWART00+zBRUT07+zBRUT02+zBRUT22+zBRUT12+zWARTOO+zVATOO
         s1_8=zWARTZW+zWART08+zWART00+zBRUT07+zBRUT02+zBRUT22+zBRUT12+zWARTOO+zVATOO
      ELSE
         s0_8=zWARTZW+zWART08+zWART00+zWART07+zWART02+zWART22+zWART12+zVAT07+zVAT02+zVAT22+zVAT12+zWARTOO+zVATOO
         s1_8=zWARTZW+zWART08+zWART00+zWART07+zWART02+zWART22+zWART12+zVAT07+zVAT02+zVAT22+zVAT12+zWARTOO+zVATOO
      ENDIF
      zm=wyraz(slownie(s1_8),50)
      zm=zm+space(150-len(zm))
      k1=left(zm,50)
      k2=substr(zm,51,50)
      k4=right(zm,50)
      k6=space(50)
      k6a=space(50)

      k5=[Zap&_l.acono ]+ltrim(kwota(faktury->ZAP_WART,13,2))+[z&_l..]
      if _round(s0_8, 2) <> _round(faktury->ZAP_WART, 2)
         k6=[Do zap&_l.aty ]+ltrim(kwota(s0_8-faktury->ZAP_WART,13,2))+[z&_l.. w terminie ]+str(faktury->ZAP_TER,3)+[ dni (do dnia ]+dtoc(faktury->ZAP_DAT)+[ )]
         k6a=[Na konto: ]+iif(substr(firma->nr_konta,1,2)=='  ',substr(firma->nr_konta,4),firma->nr_konta)+[   (]+alltrim(firma->bank)+[)]
*         k6a=[W banku : ]+alltrim(firma->bank)
      else
         k6=[Do zap&_l.aty ]+ltrim(kwota(0,13,2))+[z&_l..]
      endif


*      do case
*      case faktury->sposob_p=1
*           k5=[P&_l.atne przelewem w ci&_a.gu ]+str(faktury->termin_z,2)+[ dni (do dnia ]+dtoc(k3d+faktury->termin_z)+[ )]
*           k6=[Na konto: ]+iif(substr(firma->nr_konta,1,2)=='  ',substr(firma->nr_konta,4),firma->nr_konta)
*           k6a=[W banku : ]+alltrim(firma->bank)
*      case faktury->sposob_p=2
*           k6=space(50)
*           if faktury->termin_z=0
*              k5=[Zap&_l.acono got&_o.wk&_a.]
*           else
*              if faktury->kwota=0
*                 k5=[P&_l.atne got&_o.wk&_a. w ci&_a.gu ]+str(faktury->termin_z,2)+[ dni (do dnia ]+dtoc(k3d+faktury->termin_z)+[ )]
*              else
*                 k5=[Zap&_l.acono got&_o.wk&_a. ]+ltrim(kwota(faktury->kwota,13,2))
*                 k6=[Do zap&_l.aty ]+ltrim(kwota(s0_8-faktury->kwota,13,2))+[ w terminie ]+str(faktury->termin_z,2)+[ dni (do dnia ]+dtoc(k3d+faktury->termin_z)+[ )]
*              endif
*           endif
*      case faktury->sposob_p=3
*           k5=[Zap&_l.acono czekiem]
*           k6=space(50)
*      endcase
      k7=code()
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄ´])
      IF faktury->splitpay == 'T'
         Dopisek := 'Mechanizm podzielonej pˆatno˜ci'
      ELSEIF DrukujPN
         Dopisek := 'Odwrotne obci¥¾enie            '
      ELSE
         Dopisek := '                               '
      ENDIF
      mon_drk([ ] + Dopisek + [                                            w tym:  ³ ]+kwota(zWARTZW,12,2)+[  ZW ]+kwota(0,12,2)+[³]+kwota(zWARTZW,12,2)+'³')
      mon_drk([                                                                                    ³ ]+kwota(zWART00,12,2)+[   0 ]+kwota(0,12,2)+[³]+kwota(zWART00,12,2)+'³')
      mon_drk([ WARTO&__S.&__C. FAKTURY: ]+kwota(s1_8,14,2)+[                                                    ³ ]+kwota(zWART02,12,2)+[  ]+str(vat_C,2)+[ ]+kwota(zVAT02,12,2)+[³]+kwota(zWART02+zVAT02,12,2)+'³')
      mon_drk([ S &__L. O W N I E  :                                                                   ³ ]+kwota(zWART07,12,2)+[  ]+str(vat_B,2)+[ ]+kwota(zVAT07,12,2)+[³]+kwota(zWART07+zVAT07,12,2)+'³')
      mon_drk([ ]+k1                                            +[                                 ³ ]+kwota(zWART22,12,2)+[  ]+str(vat_A,2)+[ ]+kwota(zVAT22,12,2)+[³]+kwota(zWART22+zVAT22,12,2)+'³')
      mon_drk([ ]+k2                                            +[                                 ³ ]+kwota(zWART08,12,2)+[  NP ]+kwota(0,12,2)+[³]+kwota(zWART08,12,2)+'³')
      mon_drk([ ]+k4                                            +[                                 ³ ]+kwota(zWART12,12,2)+[  ]+str(vat_D,2)+[ ]+kwota(zVAT12,12,2)+[³]+kwota(zWART12+zVAT12,12,2)+'³')
      IF zWARTOO <> 0 .OR. zVATOO <> 0
         mon_drk([                                                                                    ³ ]+kwota(zWARTOO,12,2)+[  OO ]+kwota(zVATOO,12,2)+[³]+kwota(zWARTOO+zVATOO,12,2)+'³')
      ENDIF
      mon_drk([                                                                             RAZEM  ÚÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÂÍÍÍÍÍÍÍÍÍÍÍÍ¿])
      mon_drk([ ]+padr(k5,78)                                                               +[     ³ ]+kwota(s0_5,12,2)+[     ]+kwota(s0_7,12,2)+[³]+kwota(s0_8,12,2)+'³')
      mon_drk([ ]+padr(k6,78)                                                               +[     ÀÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÁÍÍÍÍÍÍÍÍÍÍÍÍÙ])
      mon_drk([ ]+padr(k6a,78))
      mon_drk([ faktur&_e. wystawi&_l.: ]+ewid_wyst)
*      if zRACH='F'
*      mon_drk([                                                                                    ..............................])
*      mon_drk([                                                                                       ])
*      else
*      mon_drk([                                                                                    ...............rachunek wystawi&_l..............])
*      mon_drk([                                                                                      ])
*      endif
      if nr_uzytk=204
      mon_drk([])
      mon_drk([])
      mon_drk([])
      mon_drk([])
      mon_drk([])
      mon_drk([])
      mon_drk([            DO FAKTURY NR  ]+k6reprint+[  WYSTAWIONO WZ NR ............/ ]+param_rok)
      mon_drk([            -----------------------------------------------------------------------])
      mon_drk([            Kwituj&_e. odbi&_o.r towaru zgodnie z faktur&_a. nr  ]+k6reprint+[  z dnia  ]+k3reprint)
      mon_drk([                                                                                    .....................................     ])
      mon_drk([                                                                                    faktur&_e. i towar odebra&_l. (data i podpis)])
      endif
      mon_drk([])
      mon_drk([])
      mon_drk([])
      mon_drk([])
      mon_drk([])
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if _czy_close
   close_()
endif
