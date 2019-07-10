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

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=80
      _strona=.n.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=129
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ö]+procname())
      if spolka->sposob='L'
         mon_drk(padc('ZESTAWIENIE NALEZNEGO PODATKU DOCHODOWEGO OBLICZONEGO LINIOWO',80))
      else
         mon_drk(padc('ZESTAWIENIE NALEZNEGO PODATKU DOCHODOWEGO OBLICZONEGO PROGRESYWNIE',80))
      endif
      if zPITOKRES='K'
         _okresik='KWARTA&__L.'
      else
         _okresik='MIESI&__A.C'
      endif
      mon_drk(padc('za okres: '+_okresik+'  '+P4,80))
      mon_drk('')
      mon_drk(padc('DANE PODATNIKA',80))
      mon_drk(padc('==============',80))
      mon_drk('NIP: '+P3)
      mon_drk('Nazwisko: '+P7+'  Imie: '+P8)
      mon_drk('Data ur.: '+P12)
      mon_drk('Kraj: POLSKA   Wojew&_o.dztwo: '+P15)
      mon_drk('Powiat: '+P15a+'   Gmina: '+P16)
      mon_drk('Ulica: '+P17+'   '+P18+'   '+P19)
      mon_drk('Miejscowo&_s.&_c.: '+P20+' Kod: '+P21+' Poczta: '+P22)
      mon_drk('')
      mon_drk(padc('DOCHODY PODLEGAJ&__A.CE OPODATKOWANIU',80))
      mon_drk(padc('=================================',80))
      mon_drk('&__X.r&_o.d&_l.o przychod&_o.w           Przych&_o.d       Koszty        Doch&_o.d        Strata')
      mon_drk('Pozarol.dzia&_l.al.gospodar.')
      mon_drk('i wolne zawody           '+tran(a_gosprzy[okrpod,val(miesiac)],RPICe)+' '+tran(a_goskosz[okrpod,val(miesiac)],RPICe)+' '+tran(a_gosdoch[okrpod,val(miesiac)],RPIC)+' '+tran(a_gosstra[okrpod,val(miesiac)],RPIC))
      if spolka->sposob=='L'
         mon_drk('')
      else
         mon_drk('Najem,podnajem,dzier&_z.awa '+tran(a_najprzy[okrpod,val(miesiac)],RPICe)+' '+tran(a_najkosz[okrpod,val(miesiac)],RPICe)+' '+tran(a_najdoch[okrpod,val(miesiac)],RPIC)+' '+tran(a_najstra[okrpod,val(miesiac)],RPIC))
         mon_drk('                         -------------------------------------------------------')
         mon_drk('RAZEM                    '+tran(a_gosprzy[okrpod,val(miesiac)]+a_najprzy[okrpod,val(miesiac)],RPICe)+' '+tran(a_goskosz[okrpod,val(miesiac)]+a_najkosz[okrpod,val(miesiac)],RPICe)+' '+;
                                             tran(a_gosdoch[okrpod,val(miesiac)]+a_najdoch[okrpod,val(miesiac)],RPIC)+' '+tran(a_gosstra[okrpod,val(miesiac)]+a_najstra[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      endif
      mon_drk(padc('DOCH&__O.D PO ODLICZENIU DOCHODU ZWOLNIONEGO I STRAT',80))
      mon_drk(padc('================================================',80))
      mon_drk('Dochod zwolniony od podatku (art.21ust.1 pkt63a)....................'+tran(a_P50[okrpod,val(miesiac)],RPIC))
      mon_drk('Straty z lat ubieglych..............................................'+tran(a_P51a[okrpod,val(miesiac)],RPIC))
      mon_drk('Dochod po odliczeniu dochodu zwolnionego i strat....................'+tran(a_Pkk7[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk(padc('ODLICZENIA OD DOCHODU',80))
      mon_drk(padc('=====================',80))
      mon_drk('Inne odliczenia.....................................................'+tran(a_P51b[okrpod,val(miesiac)],RPIC))
      mon_drk('Odliczenia od dochodu w tym ZUS.....................................'+tran(a_wydatkim[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk(padc('DOCHOD ZWOLNIONY OD PODATKU',80))
      mon_drk(padc('===========================',80))
      mon_drk('Na podstawie przepisow wykonawczych o SSE...........................'+tran(a_dochzwol[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk(padc('DOCHOD PO ODLICZENIACH',80))
      mon_drk(padc('======================',80))
      mon_drk('Dochod po odliczeniu ulg i zwolnien.................................'+tran(a_pk6[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk(padc('USTALENIE PODSTAWY OBLICZENIA PODATKU',80))
      mon_drk(padc('=====================================',80))
      mon_drk('Kwoty zwiekszajace podstawe opodatkowania/zmniejszajace strate......'+tran(a_pk75[okrpod,val(miesiac)],RPIC))
      mon_drk('Podstawa obliczenia podatku (po zaokragleniu do pelnego zlot..).....'+tran(a_pk7[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk(padc('OBLICZENIE NALE&__Z.NEGO PODATKU',80))
      mon_drk(padc('============================',80))
      mon_drk('OBLICZENIE PODATKU')
      mon_drk('------------------')
      mon_drk('Podatek od podstawy obliczony wg skali..............................'+tran(a_pk8[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk('ODLICZENIA OD PODATKU')
      mon_drk('---------------------')
      mon_drk('Odliczenia od podatku w tym skladka zdrowotna.......................'+tran(a_pk9[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk('OBLICZENIE NALE&__Z.NEJ ZALICZKI')
      mon_drk('----------------------------')
      mon_drk('Podatek po odliczeniach od pocz&_a.tku roku............................'+tran(a_sumzdro1[okrpod,val(miesiac)],RPIC))
      mon_drk('Suma nale&_z.nych zaliczek za poprzednie okresy........................'+tran(a_pk12[okrpod,val(miesiac)],RPIC))
      mon_drk('Nalezna zaliczka za okres...........................................'+tran(a_pk13[okrpod,val(miesiac)],RPIC))
*      mon_drk('Suma nale&_z.nych zaliczek od pocz&_a.tku roku............................'+tran(P94,dRPIC))
      mon_drk('')
      mon_drk('OGRANICZENIE POBORU ZALICZEK')
      mon_drk('----------------------------')
      mon_drk('Kwota do zrealizowania w niniejszej deklaracji......................'+tran(a_p888[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk('OBLICZENIE ZOBOWIAZANIA PRZYPADAJACEGO DO ZAPLATY')
      mon_drk('-------------------------------------------------')
      mon_drk('Zaliczka po ograniczeniu............................................'+tran(a_p889[okrpod,val(miesiac)],RPIC))
      mon_drk('Nale&_z.ny zrycza&_l.towany podatek dochodowy z remanentu.................'+tran(a_preman[okrpod,val(miesiac)],RPIC))
      mon_drk('Kwota odsetek naliczonych od dnia zaliczenia do kosztow maj.trw.....'+tran(a_odseodma[okrpod,val(miesiac)],RPIC))
      mon_drk('Kwota do zap&_l.aty....................................................'+tran(a_wartprze[okrpod,val(miesiac)],RPIC))
      mon_drk('')
      mon_drk(padc('POZAROLNICZA DZIA&__L.ALNO&__S.&__C. GOSPODARCZA',80))
      mon_drk(padc('=======================================',80))
      mon_drk('1.    NIP:'+dzial_g[1,1]+'         REGON:'+dzial_g[1,2])
      mon_drk('      '+padr(dzial_g[1,3],35)+'         '+alltrim(dzial_g[1,4]))
      mon_drk('Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata')
      mon_drk('  '+tran(dzial_g[1,5],'999.99')+space(16)+tran(dzial_g[1,6],dRPICe)+' '+tran(dzial_g[1,7],dRPICe)+' '+tran(dzial_g[1,8],dRPIC)+'  '+tran(dzial_g[1,9],dRPIC))
      mon_drk('')
      mon_drk('2.    NIP:'+dzial_g[2,1]+'         REGON:'+dzial_g[2,2])
      mon_drk('      '+padr(dzial_g[2,3],35)+'         '+alltrim(dzial_g[2,4]))
      mon_drk('Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata')
      mon_drk('  '+tran(dzial_g[2,5],'999.99')+space(16)+tran(dzial_g[2,6],dRPICe)+' '+tran(dzial_g[2,7],dRPICe)+' '+tran(dzial_g[2,8],dRPIC)+'  '+tran(dzial_g[2,9],dRPIC))
      mon_drk('')
      mon_drk('3.    NIP:'+dzial_g[3,1]+'         REGON:'+dzial_g[3,2])
      mon_drk('      '+padr(dzial_g[3,3],35)+'         '+alltrim(dzial_g[3,4]))
      mon_drk('Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata')
      mon_drk('  '+tran(dzial_g[3,5],'999.99')+space(16)+tran(dzial_g[3,6],dRPICe)+' '+tran(dzial_g[3,7],dRPICe)+' '+tran(dzial_g[3,8],dRPIC)+'  '+tran(dzial_g[3,9],dRPIC))
      mon_drk('')
      mon_drk('4.    NIP:'+dzial_g[4,1]+'         REGON:'+dzial_g[4,2])
      mon_drk('      '+padr(dzial_g[4,3],35)+'         '+alltrim(dzial_g[4,4]))
      mon_drk('Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata')
      mon_drk('  '+tran(dzial_g[4,5],'999.99')+space(16)+tran(dzial_g[4,6],dRPICe)+' '+tran(dzial_g[4,7],dRPICe)+' '+tran(dzial_g[4,8],dRPIC)+'  '+tran(dzial_g[4,9],dRPIC))
      mon_drk('')
      mon_drk(padc('NAJEM,PODNAJEM,DZIER&__Z.AWA itp',80))
      mon_drk(padc('============================',80))
      mon_drk('1.    '+P120+'         '+P121)
      mon_drk('Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata')
      mon_drk('  '+tran(p122,'999.99')+space(16)+tran(p123,dRPICe)+' '+tran(p124,dRPICe)+' '+tran(p125,dRPIC)+'  '+tran(p126,dRPIC))
      mon_drk('')
      mon_drk('2.    '+P127+'         '+P128)
      mon_drk('Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata')
      mon_drk('  '+tran(p129,'999.99')+space(16)+tran(p130,dRPICe)+' '+tran(p131,dRPICe)+' '+tran(p132,dRPIC)+'  '+tran(p133,dRPIC))
      mon_drk([þ])
end
