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
      _prawa=80
      _strona=.n.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=80
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ö]+procname())
      if zPITOKRES='K'
         _okresik='KWARTA&__L.NIE'
      else
         _okresik='MIESI&__E.CZNIE'
      endif
      if spolka->sposob='L'
         mon_drk(padc('DANE DO ZEZNANIA PODATKU DOCHODOWEGO OBLICZONE LINIOWO,'+_okresik,80))
      else
         mon_drk(padc('DANE DO ZEZNANIA PODATKU DOCHODOWEGO OBLICZONE PROGRESYWNIE,'+_okresik,80))
      endif
      mon_drk(padc('ROK: '+param_rok,80))
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
      mon_drk(padc('DOCHODY/STRATY ZE &__X.R&__O.DE&__L. PRZYCHOD&__O.W',80))
      mon_drk(padc('===================================',80))
      mon_drk('&__X.r&_o.d&_l.o przychod&_o.w           Przych&_o.d       Koszty        Doch&_o.d        Strata')
      mon_drk('Pozarol.dzia&_l.al.gospodar.')
      mon_drk('i wolne zawody           '+tran(a_gosprzy[okrpod,12],RPICe)+' '+tran(a_goskosz[okrpod,12],RPICe)+' '+tran(a_gosdoch[okrpod,12],RPIC)+' '+tran(a_gosstra[okrpod,12],RPIC))
      if spolka->sposob=='L'
         mon_drk('')
      else
         mon_drk('Najem,podnajem,dzier&_z.awa '+tran(a_najprzy[okrpod,12],RPICe)+' '+tran(a_najkosz[okrpod,12],RPICe)+' '+tran(a_najdoch[okrpod,12],RPIC)+' '+tran(a_najstra[okrpod,12],RPIC))
         mon_drk('                         -------------------------------------------------------')
         mon_drk('RAZEM                    '+tran(a_gosprzy[okrpod,12]+a_najprzy[okrpod,12],RPICe)+' '+tran(a_goskosz[okrpod,12]+a_najkosz[okrpod,12],RPICe)+' '+;
                                             tran(a_gosdoch[okrpod,12]+a_najdoch[okrpod,12],RPIC)+' '+tran(a_gosstra[okrpod,12]+a_najstra[okrpod,12],RPIC))
      mon_drk('')
      endif
      mon_drk('')
*      mon_drk('Nalezna zaliczka         '+tran(a_sumzdro1[okrpod,12],RPICe))
      if okrpod=2
      mon_drk('Nalezna zaliczka         '+tran(a_pk13[okrpod,1]+a_pk13[okrpod,2]+a_pk13[okrpod,3]+a_pk13[okrpod,4]+a_pk13[okrpod,5]+a_pk13[okrpod,6]+a_pk13[okrpod,7]+a_pk13[okrpod,8]+a_pk13[okrpod,9]+a_pk13[okrpod,10]+a_pk13[okrpod,11]+a_pk13[okrpod,12],RPICe))
      else
      mon_drk('Nalezna zaliczka         '+tran(a_pk13[okrpod,3]+a_pk13[okrpod,6]+a_pk13[okrpod,9]+a_pk13[okrpod,12],RPICe))
      endif
      mon_drk('')
      mon_drk('')
      if spolka->sposob=='L'
      mon_drk(padc('ODLICZENIE STRAT I SK&__L.ADEK NA UBEZPIECZENIE SPO&__L.ECZNE',80))
      mon_drk(padc('=====================================================',80))
      else
      mon_drk(padc('ODLICZENIE DOCHODU ZWOLNIONEGO,STRAT I SKLADEK NA UBEZPIECZENIE SPOLECZNE',80))
      mon_drk(padc('=========================================================================',80))
      mon_drk('Dochod zwolniony od podatku (art.21ust.1 pkt63a)....................'+tran(a_rentalim[okrpod,12],RPIC))
      endif
      mon_drk('Straty z lat ubieglych (dzialalnosc gospodarcza)....................'+tran(a_straty[okrpod,12],RPIC))
      if spolka->sposob<>'L'
      mon_drk('Straty z lat ubieglych (najem)......................................'+tran(a_straty_n[okrpod,12],RPIC))
      endif
      mon_drk('Inne odliczenia.....................................................'+tran(a_p51b[okrpod,12],RPIC))
      mon_drk('Skladki na ubezpieczenie spoleczne..................................'+tran(a_sumemer[okrpod,12],RPIC))
      if spolka->sposob<>'L'
      mon_drk('')
      mon_drk(padc('ODLICZENIA OD DOCHODU/ZWOLNIENIE',80))
      mon_drk(padc('================================',80))
      mon_drk('Odliczenia od dochodu...............................................'+tran(a_wydatkid[okrpod,12],RPIC))
      mon_drk('Odliczenia mieszkaniowe.............................................'+tran(a_budowa[okrpod,12],RPIC))
      mon_drk('Dodatkowa obnizka...................................................'+tran(a_ubieginw[okrpod,12],RPIC))
      mon_drk('Na podstawie przepisow wykonawczych o SSE...........................'+tran(a_SSE[okrpod,12],RPIC))
      endif
      mon_drk('')
      mon_drk(padc('KWOTA ZWIEKSZAJACA PODSTAWE OPODATKOWANIA/ZMNIEJSZAJACA STRATE',80))
      mon_drk(padc('==============================================================',80))
      mon_drk('Kwota zwiekszajaca podstawe opodatkowania/zmniejszajaca strate......'+tran(a_pk75[okrpod,12],RPIC))
      mon_drk('')
      mon_drk(padc('OBLICZENIE PODATKU',80))
      mon_drk(padc('==================',80))
      mon_drk('Podstawa obliczenia podatku (po zaokragleniu do pelnego zlot..).....'+tran(a_pk7[okrpod,12],RPIC))
      mon_drk('Obliczony podatek...................................................'+tran(a_pk8[okrpod,12],RPIC))
      mon_drk('')
      mon_drk(padc('ODLICZENIA OD PODATKU',80))
      mon_drk(padc('=====================',80))
      mon_drk('Skladki na ubezpieczenie zdrowotne..................................'+tran(a_sumzdro[okrpod,12],RPIC))
      if spolka->sposob<>'L'
      mon_drk('Odliczenia od podatku...............................................'+tran(a_bbb[okrpod,12]+a_inneodpo[okrpod,12],RPIC))
      mon_drk('Odliczenia od podatku wydatkow mieszkaniowych.......................'+tran(a_aaa[okrpod,12],RPIC))
      endif
      mon_drk('')
      mon_drk(padc('OBLICZENIE ZOBOWIAZANIA PODATKOWEGO',80))
      mon_drk(padc('===================================',80))
      mon_drk('Podatek po odliczeniach.............................................'+tran(a_sumzdro1[okrpod,12],RPIC))
      mon_drk('Zryczaltowany podatek dochodowy od dochodu z remanentu likwidac.....'+tran(a_preman[okrpod,12],RPIC))
      mon_drk('')
      mon_drk(padc('NALEZNE ZALICZKI',80))
      mon_drk(padc('================',80))
      if okrpod=2
      mon_drk('Nalezna zaliczka za miesiac......................................1: '+tran(a_pk13[okrpod,1],RPIC))
      mon_drk('                                                                 2: '+tran(a_pk13[okrpod,2],RPIC))
      mon_drk('                                                                 3: '+tran(a_pk13[okrpod,3],RPIC))
      mon_drk('                                                                 4: '+tran(a_pk13[okrpod,4],RPIC))
      mon_drk('                                                                 5: '+tran(a_pk13[okrpod,5],RPIC))
      mon_drk('                                                                 6: '+tran(a_pk13[okrpod,6],RPIC))
      mon_drk('                                                                 7: '+tran(a_pk13[okrpod,7],RPIC))
      mon_drk('                                                                 8: '+tran(a_pk13[okrpod,8],RPIC))
      mon_drk('                                                                 9: '+tran(a_pk13[okrpod,9],RPIC))
      mon_drk('                                                                10: '+tran(a_pk13[okrpod,10],RPIC))
      mon_drk('                                                                11: '+tran(a_pk13[okrpod,11],RPIC))
      mon_drk('                                                                12: '+tran(a_pk13[okrpod,12],RPIC))
      else
      mon_drk('Nalezna zaliczka za kwartal......................................1: '+tran(a_pk13[okrpod,3],RPIC))
      mon_drk('                                                                 2: '+tran(a_pk13[okrpod,6],RPIC))
      mon_drk('                                                                 3: '+tran(a_pk13[okrpod,9],RPIC))
      mon_drk('                                                                 4: '+tran(a_pk13[okrpod,12],RPIC))
      endif
      mon_drk('')
      mon_drk(padc('"PODATEK DO ZAPLATY" - ostatni wiersz z informacji o podatku dochodowym',80))
      mon_drk(padc('=======================================================================',80))
      if okrpod=2
      mon_drk('Kwota do zap&_l.aty za miesiac......................................1: '+tran(a_wartprze[okrpod,1],RPIC))
      mon_drk('                                                                 2: '+tran(a_wartprze[okrpod,2],RPIC))
      mon_drk('                                                                 3: '+tran(a_wartprze[okrpod,3],RPIC))
      mon_drk('                                                                 4: '+tran(a_wartprze[okrpod,4],RPIC))
      mon_drk('                                                                 5: '+tran(a_wartprze[okrpod,5],RPIC))
      mon_drk('                                                                 6: '+tran(a_wartprze[okrpod,6],RPIC))
      mon_drk('                                                                 7: '+tran(a_wartprze[okrpod,7],RPIC))
      mon_drk('                                                                 8: '+tran(a_wartprze[okrpod,8],RPIC))
      mon_drk('                                                                 9: '+tran(a_wartprze[okrpod,9],RPIC))
      mon_drk('                                                                10: '+tran(a_wartprze[okrpod,10],RPIC))
      mon_drk('                                                                11: '+tran(a_wartprze[okrpod,11],RPIC))
      mon_drk('                                                                12: '+tran(a_wartprze[okrpod,12],RPIC))
      else
      mon_drk('Kwota do zap&_l.aty za kwartal......................................1: '+tran(a_wartprze[okrpod,3],RPIC))
      mon_drk('                                                                 2: '+tran(a_wartprze[okrpod,6],RPIC))
      mon_drk('                                                                 3: '+tran(a_wartprze[okrpod,9],RPIC))
      mon_drk('                                                                 4: '+tran(a_wartprze[okrpod,12],RPIC))
      endif
      mon_drk([þ])
end
