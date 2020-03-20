/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha┬ Gawrycki (gmsystems.pl)

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

FUNCTION kvat27(hDane, nStrona, lZalaczniki)
LOCAL p6a := 0, p6b := 0
private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15

begin sequence
      IF lZalaczniki
         p6a := nStrona
         p6b := Len(hDane['poz_t'])
      ENDIF
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=129
      _strona=.n.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=129
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      mon_drk([Ж]+procname())
      mon_drk([зддддддддддддддддддддддддддддддддддддддддддбдддддддддддддддддддддддддддбддддддддд©])
      mon_drk([Ё1.Identyfikator podatkowy NIP podatnika   Ё2.Nr dokumentu             Ё3.Status Ё])
      mon_drk([Ё         PL  ]+rozrzut(hDane['p1'])+[   Ё                           Ё         Ё])
      mon_drk([юддддддддддддддддддддддддддддддддддддддддддадддддддддддддддддддддддддддаддддддддды])
      mon_drk([V A T - 2 7              INFORMACJA PODSUMOWUJ╓CA / KOREKTA INFORMACJI PODSUMOWUJ╓CEJ  ])
      mon_drk([                                             W OBROCIE KRAJOWYM                        ])
      mon_drk([                                    здддддддддддддддддбдддддддддддддд©])
      mon_drk([                                    Ё4.Miesiac        Ё5.Rok         Ё])
      mon_drk([                                    Ё       ] + hDane['p4'] + [        Ё    ]+rozrzut(hDane['p5'])+[  Ё])
      mon_drk([                                    юдддддддддддддддддадддддддддддддды])
      mon_drk([зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©])
      mon_drk([ЁPodstawa prawna: Art.101a ust. 1, 4 albo 5 ustawy z dnia 11 marca 2004 r. o podatku od towar╒w i us┬ug (Dz. U. z 2011 r.       Ё])
      mon_drk([Ё                 Nr 177, poz.1054,z p╒╚n. zm.), zwanej dalej "ustaw╔".                                                         Ё])
      mon_drk([ЁTermin sk┬adania: Do 25. dnia miesi╔ca, po okresie, za kt╒ry sk┬adana jest informacja.                                         Ё])
      mon_drk([ЁSk┬adaj╔cy: Podatnicy podatku od towar╒w i us┬ug dokonuj╔cy dostawy towar╒w lub ≤wiadcz╔cy us┬ugi, dla kt╒rych podatnikiem     Ё])
      mon_drk([Ё            jest nabywca, w przypadkach, o kt╒rych jest mowa w art. 17 ust. 1 pkt 7 i 8 ustawy.                                Ё])
      mon_drk([ЁMiejsce sk┬adania: Urz╔d skarbowy w┬a≤ciwy dla podatnika.                                                                      Ё])
      mon_drk([цммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╢])
      mon_drk([Ё A. MIEJSCE SK²ADANIA INFORMACJI                                                                                               Ё])
      mon_drk([Ё  зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддбддддддддддддддддддддддддддддддддддддддддддддддддддддд╢])
      mon_drk([Ё  Ё6.Urz╔d skarbowy, do kt╒rego adresowana jest informacja               Ё7.Cel z┬o╬enia formularza                            Ё])
      mon_drk([Ё  Ё ]+PadC(AllTrim(hDane['p7']),69)+'Ё['+iif(hDane['p8']<>'K','XX','  ')+'] 1.z┬o╬enie informacji  ['+iif(hDane['p8']=='K','XX','  ')+'] 2.korekta informacjiЁ')
      mon_drk([цммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╢])
      mon_drk([Ё B. DANE IDENTYFIKACYJNE PODATNIKA                                                                                             Ё])
      mon_drk([Ё    * - dotyczy podmiot&_o.w nieb&_e.d&_a.cych osobami fizycznymi               ** - dotyczy podmiot&_o.w b&_e.d&_a.cych osobami fizycznymi      Ё])
      mon_drk([Ё  здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢])
      mon_drk([Ё  Ё8.Rodzaj podatnika (zaznaczy&_c. w&_l.a&_s.ciw&_a. form&_e.)                                                                               Ё])
      mon_drk([Ё  Ё                         ]+iif(hDane['p9'],'[XX]','[  ]')+[  1.Podatnik nieb&_e.d&_a.cy osob&_a. fizyczn&_a.            ]+iif(.NOT.hDane['p9'],'[XX]','[  ]')+[  2.Osoba fizyczna                        Ё])
      mon_drk([Ё  цдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢])
      mon_drk([Ё  Ё9.Nazwa pe&_l.na,REGON *   /   Nazwisko, pierwsze imie, data urodzenia **                                                      Ё])
      mon_drk([Ё  Ё ]+padc(rozrzut(AllTrim(hDane['p10'])),120)+[   Ё])
      mon_drk([цммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╢])
      mon_drk([Ё C. INFORMACJA O O DOSTAWACH TOWARЮW, do kt╒rych ma zastosowanie art. 17 ust. 1 pkt 7 ustawy                                   Ё])
      mon_drk([Ё  здддддддддбдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддбдддддддддддддддбдддддддддддддддддддддд╢])
      mon_drk([Ё  ЁNast╔pi┬aЁ                   Nazwa lub nazwisko i imi╘ nabywcy                       Ё Identyfikator Ё     ²╔czna warto≤├   Ё])
      mon_drk([Ё  Ё zmiana  Ё                                                                           Ё   podatkowy   Ё  transakcji w z┬, gr Ё])
      mon_drk([Ё  Ё danych  Ё                                                                           Ё  NIP nabywcy  Ё                      Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk([Ё  Ё    a    Ё                                     b                                     Ё       c       Ё           d          Ё])
      mon_drk('Ё 1Ё['+iif(hDane['poz_t'][nStrona][1]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][1]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][1]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][1]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 2Ё['+iif(hDane['poz_t'][nStrona][2]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][2]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][2]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][2]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 3Ё['+iif(hDane['poz_t'][nStrona][3]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][3]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][3]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][3]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 4Ё['+iif(hDane['poz_t'][nStrona][4]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][4]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][4]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][4]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 5Ё['+iif(hDane['poz_t'][nStrona][5]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][5]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][5]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][5]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 6Ё['+iif(hDane['poz_t'][nStrona][6]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][6]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][6]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][6]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 7Ё['+iif(hDane['poz_t'][nStrona][7]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][7]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][7]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][7]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 8Ё['+iif(hDane['poz_t'][nStrona][8]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][8]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][8]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][8]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 9Ё['+iif(hDane['poz_t'][nStrona][9]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][9]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][9]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][9]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё10Ё['+iif(hDane['poz_t'][nStrona][10]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][10]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][10]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][10]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё11Ё['+iif(hDane['poz_t'][nStrona][11]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][11]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][11]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][11]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё12Ё['+iif(hDane['poz_t'][nStrona][12]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][12]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][12]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][12]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё13Ё['+iif(hDane['poz_t'][nStrona][13]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][13]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][13]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][13]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё14Ё['+iif(hDane['poz_t'][nStrona][14]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][14]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][14]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][14]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё15Ё['+iif(hDane['poz_t'][nStrona][15]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][15]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][15]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][15]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё16Ё['+iif(hDane['poz_t'][nStrona][16]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][16]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][16]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][16]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё17Ё['+iif(hDane['poz_t'][nStrona][17]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][17]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][17]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][17]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё18Ё['+iif(hDane['poz_t'][nStrona][18]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][18]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][18]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][18]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё19Ё['+iif(hDane['poz_t'][nStrona][19]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][19]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][19]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][19]['wartosc'] + [ Ё])
      mon_drk([юддадддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддадддддддддддддддадддддддддддддддддддддды])
      mon_drk([                                                                                                                                 ])
      mon_drk([                                                                                                                 VAT-27(2)   1/2 ])
      mon_drk([зддбдддддддддбдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддбдддддддддддддддбдддддддддддддддддддддд╢])
      mon_drk('Ё20Ё['+iif(hDane['poz_t'][nStrona][20]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][20]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][20]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][20]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё21Ё['+iif(hDane['poz_t'][nStrona][21]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][21]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][21]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][21]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё22Ё['+iif(hDane['poz_t'][nStrona][22]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][22]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][22]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][22]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё23Ё['+iif(hDane['poz_t'][nStrona][23]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][23]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][23]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][23]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё24Ё['+iif(hDane['poz_t'][nStrona][24]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][24]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][24]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][24]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё25Ё['+iif(hDane['poz_t'][nStrona][25]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][25]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][25]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][25]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё26Ё['+iif(hDane['poz_t'][nStrona][26]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][26]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][26]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][26]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё27Ё['+iif(hDane['poz_t'][nStrona][27]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][27]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][27]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][27]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё28Ё['+iif(hDane['poz_t'][nStrona][28]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][28]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][28]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][28]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё29Ё['+iif(hDane['poz_t'][nStrona][29]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][29]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][29]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][29]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё30Ё['+iif(hDane['poz_t'][nStrona][30]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_t'][nStrona][30]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_t'][nStrona][30]['nip'], 13) + [ Ё     ] + hDane['poz_t'][nStrona][30]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддадддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё  Ё Razem     (suma kwot z kolumny d.)                                                                  Ё     ' + hDane['sum_t'][nStrona] + [ Ё])
      mon_drk([цммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╢])
      mon_drk([Ё D. INFORMACJA O ≈WIADCZONYCH US²UGACH, do kt╒rych ma zastosowanie art. 17 ust. 1 pkt 8 ustawy                                 Ё])
      mon_drk([Ё  здддддддддбдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддбдддддддддддддддбдддддддддддддддддддддд╢])
      mon_drk([Ё  ЁNast╔pi┬aЁ                   Nazwa lub nazwisko i imi╘ nabywcy                       Ё Identyfikator Ё     ²╔czna warto≤├   Ё])
      mon_drk([Ё  Ё zmiana  Ё                                                                           Ё   podatkowy   Ё  transakcji w z┬, gr Ё])
      mon_drk([Ё  Ё danych  Ё                                                                           Ё  NIP nabywcy  Ё                      Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk([Ё  Ё    a    Ё                                     b                                     Ё       c       Ё           d          Ё])
      mon_drk('Ё 1Ё['+iif(hDane['poz_u'][nStrona][1]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][1]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][1]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][1]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 2Ё['+iif(hDane['poz_u'][nStrona][2]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][2]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][2]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][2]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 3Ё['+iif(hDane['poz_u'][nStrona][3]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][3]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][3]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][3]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 4Ё['+iif(hDane['poz_u'][nStrona][4]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][4]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][4]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][4]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 5Ё['+iif(hDane['poz_u'][nStrona][5]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][5]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][5]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][5]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 6Ё['+iif(hDane['poz_u'][nStrona][6]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][6]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][6]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][6]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 7Ё['+iif(hDane['poz_u'][nStrona][7]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][7]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][7]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][7]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 8Ё['+iif(hDane['poz_u'][nStrona][8]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][8]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][8]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][8]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё 9Ё['+iif(hDane['poz_u'][nStrona][9]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][9]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][9]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][9]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддедддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё10Ё['+iif(hDane['poz_u'][nStrona][10]['zmiana'], 'XX', '  ' )+'] Tak Ё '+PadC(AllTrim(hDane['poz_u'][nStrona][10]['nazwa']), 73) + [ Ё ] + PadC(hDane['poz_u'][nStrona][10]['nip'], 13) + [ Ё     ] + hDane['poz_u'][nStrona][10]['wartosc'] + [ Ё])
      mon_drk([Ё  цдддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддадддддддддддддддедддддддддддддддддддддд╢])
      mon_drk('Ё  Ё Razem     (suma kwot z kolumny d.)                                                                  Ё     ' + hDane['sum_u'][nStrona] + [ Ё])
      mon_drk([цммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╢])
      mon_drk([Ё E. PODPIS PODATNIKA LUB OSOBY REPREZENTUJ╓CEJ PODATNIKA                                                                       Ё])
      mon_drk([Ё  зддддддддддддддддддддддддддддддддддддддддддддддддддддддддбддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢])
      mon_drk([Ё  Ё 12.Imi&_e.                                                Ё 13.Nazwisko                                                       Ё])
      mon_drk([Ё  Ё                               ]+zDEKLIMIE+[          Ё                                   ]+zDEKLNAZWI+[            Ё])
      mon_drk([Ё  цддддддддддддддддддддддддддддддддддбдддддддддддддддддддддадддддддддддддддддддбддддддддддддддддддддддддддддддддддддддддддддддд╢])
      mon_drk([Ё  Ё 14.Telefon kontaktowy            Ё 15.Data wype&_l.nienia (dzie&_n.-miesi&_a.c-rok) Ё 16.Podpis (i piecz&_a.tka) podatnika lub osoby   Ё])
      mon_drk([Ё  Ё                                  Ё                                         Ё    reprezentuj&_a.cej podatnika                  Ё])
      mon_drk([Ё  Ё     ]+zDEKLTEL+[    Ё                                         Ё                                               Ё])
      mon_drk([юддаддддддддддддддддддддддддддддддддддадддддддддддддддддддддддддддддддддддддддддаддддддддддддддддддддддддддддддддддддддддддддддды])
      mon_drk([1) W przypadku, gdy liczba nabywc╒w przekracza liczb╘ wierszy przeznaczonych do ich wpisania w cz╘≤ci C lub D informacji nale╬y ])
      mon_drk([    wype┬ni├ kolejn╔ informacj╘ i oznaczy├ j╔ odpowiednim numerem za┬╔cznika w og╒lnej liczbie z┬o╬onych za┬╔cznik╒w. ])
      mon_drk([2) Korekt╘ informacji nale╬y z┬o╬y├, je╬eli dane zawarte we wcze≤niej z┬o╬onej informacji podsumowuj╔cej wymagaj╔ zmiany. ])
      mon_drk([3) W przypadku informacji sk┬adanej papierowo, poz. 11 lub 12 Razem wype┬nia si╘ tylko na ostatnim za┬╔czniku. ])
      mon_drk([                                                            Obja≤nienia: ])
      mon_drk([*  W przypadku informacji sk┬adanej za pomoc╔ ≤rodk╒w komunikacji elektronicznej (interaktywnej) poz. 6 nie wype┬nia si╘ ])
      mon_drk([   (wiersze w cz╘≤ci C lub D stanowi╔ list╘ rozwijaln╔). ])
      mon_drk([*  W cz╘≤ci C lub D informacji: ])
      mon_drk([   1) kol. a. wype┬nia si╘ tylko, je≤li w poz.8 zaznaczono kwadrat nr 2 ?korekta informacji?. ])
      mon_drk([   2) w kol. c. nale╬y wpisa├ poprawny identyfikator podatkowy NIP nabywcy towar╒w lub us┬ug. ])
      mon_drk([   3) w kol. d. nale╬y wpisa├ ┬╔czn╔ warto≤├ dostaw towar╒w lub ≤wiadczonych us┬ug, dla kt╒rych podatnikiem jest nabywca zgodnie])
      mon_drk([   z art. 17 ust. 1 pkt 7 i 8 ustawy, dokonanych w okresie, za kt╒ry sk┬adana jest informacja, dla poszczeg╒lnych nabywc╒w. ])
      mon_drk([                                                              Pouczenie ])
      mon_drk([           Za podanie nieprawdy lub zatajenie prawdy grozi odpowiedzialno≤├ przewidziana w Kodeksie karnym skarbowym.  ])
      mon_drk([                                                                                                                                 ])
      mon_drk([ VAT-27(1)   2/2                                                                                                                 ])
      mon_drk([Ч])
end
