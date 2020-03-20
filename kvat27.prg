/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha� Gawrycki (gmsystems.pl)

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
      mon_drk([�]+procname())
      mon_drk([��������������������������������������������������������������������������������Ŀ])
      mon_drk([�1.Identyfikator podatkowy NIP podatnika   �2.Nr dokumentu             �3.Status �])
      mon_drk([�         PL  ]+rozrzut(hDane['p1'])+[   �                           �         �])
      mon_drk([����������������������������������������������������������������������������������])
      mon_drk([V A T - 2 7              INFORMACJA PODSUMOWUJ�CA / KOREKTA INFORMACJI PODSUMOWUJ�CEJ  ])
      mon_drk([                                             W OBROCIE KRAJOWYM                        ])
      mon_drk([                                    ��������������������������������Ŀ])
      mon_drk([                                    �4.Miesiac        �5.Rok         �])
      mon_drk([                                    �       ] + hDane['p4'] + [        �    ]+rozrzut(hDane['p5'])+[  �])
      mon_drk([                                    ����������������������������������])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������Ŀ])
      mon_drk([�Podstawa prawna: Art.101a ust. 1, 4 albo 5 ustawy z dnia 11 marca 2004 r. o podatku od towar�w i us�ug (Dz. U. z 2011 r.       �])
      mon_drk([�                 Nr 177, poz.1054,z p��n. zm.), zwanej dalej "ustaw�".                                                         �])
      mon_drk([�Termin sk�adania: Do 25. dnia miesi�ca, po okresie, za kt�ry sk�adana jest informacja.                                         �])
      mon_drk([�Sk�adaj�cy: Podatnicy podatku od towar�w i us�ug dokonuj�cy dostawy towar�w lub �wiadcz�cy us�ugi, dla kt�rych podatnikiem     �])
      mon_drk([�            jest nabywca, w przypadkach, o kt�rych jest mowa w art. 17 ust. 1 pkt 7 i 8 ustawy.                                �])
      mon_drk([�Miejsce sk�adania: Urz�d skarbowy w�a�ciwy dla podatnika.                                                                      �])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������ʹ])
      mon_drk([� A. MIEJSCE SK�ADANIA INFORMACJI                                                                                               �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �6.Urz�d skarbowy, do kt�rego adresowana jest informacja               �7.Cel z�o�enia formularza                            �])
      mon_drk([�  � ]+PadC(AllTrim(hDane['p7']),69)+'�['+iif(hDane['p8']<>'K','XX','  ')+'] 1.z�o�enie informacji  ['+iif(hDane['p8']=='K','XX','  ')+'] 2.korekta informacji�')
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������ʹ])
      mon_drk([� B. DANE IDENTYFIKACYJNE PODATNIKA                                                                                             �])
      mon_drk([�    * - dotyczy podmiot&_o.w nieb&_e.d&_a.cych osobami fizycznymi               ** - dotyczy podmiot&_o.w b&_e.d&_a.cych osobami fizycznymi      �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �8.Rodzaj podatnika (zaznaczy&_c. w&_l.a&_s.ciw&_a. form&_e.)                                                                               �])
      mon_drk([�  �                         ]+iif(hDane['p9'],'[XX]','[  ]')+[  1.Podatnik nieb&_e.d&_a.cy osob&_a. fizyczn&_a.            ]+iif(.NOT.hDane['p9'],'[XX]','[  ]')+[  2.Osoba fizyczna                        �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �9.Nazwa pe&_l.na,REGON *   /   Nazwisko, pierwsze imie, data urodzenia **                                                      �])
      mon_drk([�  � ]+padc(rozrzut(AllTrim(hDane['p10'])),120)+[   �])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������ʹ])
      mon_drk([� C. INFORMACJA O O DOSTAWACH TOWAR�W, do kt�rych ma zastosowanie art. 17 ust. 1 pkt 7 ustawy                                   �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �Nast�pi�a�                   Nazwa lub nazwisko i imi� nabywcy                       � Identyfikator �     ��czna warto��   �])
      mon_drk([�  � zmiana  �                                                                           �   podatkowy   �  transakcji w z�, gr �])
      mon_drk([�  � danych  �                                                                           �  NIP nabywcy  �                      �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �    a    �                                     b                                     �       c       �           d          �])
      mon_drk('� 1�['+iif(hDane['poz_t'][nStrona][1]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][1]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][1]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][1]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 2�['+iif(hDane['poz_t'][nStrona][2]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][2]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][2]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][2]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 3�['+iif(hDane['poz_t'][nStrona][3]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][3]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][3]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][3]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 4�['+iif(hDane['poz_t'][nStrona][4]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][4]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][4]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][4]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 5�['+iif(hDane['poz_t'][nStrona][5]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][5]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][5]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][5]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 6�['+iif(hDane['poz_t'][nStrona][6]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][6]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][6]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][6]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 7�['+iif(hDane['poz_t'][nStrona][7]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][7]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][7]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][7]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 8�['+iif(hDane['poz_t'][nStrona][8]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][8]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][8]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][8]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 9�['+iif(hDane['poz_t'][nStrona][9]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][9]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][9]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][9]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�10�['+iif(hDane['poz_t'][nStrona][10]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][10]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][10]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][10]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�11�['+iif(hDane['poz_t'][nStrona][11]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][11]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][11]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][11]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�12�['+iif(hDane['poz_t'][nStrona][12]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][12]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][12]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][12]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�13�['+iif(hDane['poz_t'][nStrona][13]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][13]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][13]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][13]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�14�['+iif(hDane['poz_t'][nStrona][14]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][14]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][14]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][14]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�15�['+iif(hDane['poz_t'][nStrona][15]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][15]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][15]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][15]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�16�['+iif(hDane['poz_t'][nStrona][16]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][16]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][16]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][16]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�17�['+iif(hDane['poz_t'][nStrona][17]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][17]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][17]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][17]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�18�['+iif(hDane['poz_t'][nStrona][18]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][18]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][18]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][18]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�19�['+iif(hDane['poz_t'][nStrona][19]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][19]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][19]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][19]['wartosc'] + [ �])
      mon_drk([���������������������������������������������������������������������������������������������������������������������������������])
      mon_drk([                                                                                                                                 ])
      mon_drk([                                                                                                                 VAT-27(2)   1/2 ])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�20�['+iif(hDane['poz_t'][nStrona][20]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][20]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][20]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][20]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�21�['+iif(hDane['poz_t'][nStrona][21]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][21]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][21]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][21]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�22�['+iif(hDane['poz_t'][nStrona][22]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][22]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][22]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][22]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�23�['+iif(hDane['poz_t'][nStrona][23]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][23]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][23]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][23]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�24�['+iif(hDane['poz_t'][nStrona][24]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][24]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][24]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][24]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�25�['+iif(hDane['poz_t'][nStrona][25]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][25]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][25]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][25]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�26�['+iif(hDane['poz_t'][nStrona][26]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][26]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][26]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][26]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�27�['+iif(hDane['poz_t'][nStrona][27]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][27]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][27]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][27]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�28�['+iif(hDane['poz_t'][nStrona][28]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][28]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][28]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][28]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�29�['+iif(hDane['poz_t'][nStrona][29]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][29]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][29]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][29]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�30�['+iif(hDane['poz_t'][nStrona][30]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_t'][nStrona][30]['nazwa']), 73) + [ � ] + PadC(hDane['poz_t'][nStrona][30]['nip'], 13) + [ �     ] + hDane['poz_t'][nStrona][30]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�  � Razem     (suma kwot z kolumny d.)                                                                  �     ' + hDane['sum_t'][nStrona] + [ �])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������ʹ])
      mon_drk([� D. INFORMACJA O �WIADCZONYCH US�UGACH, do kt�rych ma zastosowanie art. 17 ust. 1 pkt 8 ustawy                                 �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �Nast�pi�a�                   Nazwa lub nazwisko i imi� nabywcy                       � Identyfikator �     ��czna warto��   �])
      mon_drk([�  � zmiana  �                                                                           �   podatkowy   �  transakcji w z�, gr �])
      mon_drk([�  � danych  �                                                                           �  NIP nabywcy  �                      �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �    a    �                                     b                                     �       c       �           d          �])
      mon_drk('� 1�['+iif(hDane['poz_u'][nStrona][1]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][1]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][1]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][1]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 2�['+iif(hDane['poz_u'][nStrona][2]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][2]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][2]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][2]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 3�['+iif(hDane['poz_u'][nStrona][3]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][3]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][3]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][3]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 4�['+iif(hDane['poz_u'][nStrona][4]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][4]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][4]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][4]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 5�['+iif(hDane['poz_u'][nStrona][5]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][5]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][5]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][5]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 6�['+iif(hDane['poz_u'][nStrona][6]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][6]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][6]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][6]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 7�['+iif(hDane['poz_u'][nStrona][7]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][7]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][7]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][7]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 8�['+iif(hDane['poz_u'][nStrona][8]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][8]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][8]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][8]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('� 9�['+iif(hDane['poz_u'][nStrona][9]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][9]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][9]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][9]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�10�['+iif(hDane['poz_u'][nStrona][10]['zmiana'], 'XX', '  ' )+'] Tak � '+PadC(AllTrim(hDane['poz_u'][nStrona][10]['nazwa']), 73) + [ � ] + PadC(hDane['poz_u'][nStrona][10]['nip'], 13) + [ �     ] + hDane['poz_u'][nStrona][10]['wartosc'] + [ �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk('�  � Razem     (suma kwot z kolumny d.)                                                                  �     ' + hDane['sum_u'][nStrona] + [ �])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������ʹ])
      mon_drk([� E. PODPIS PODATNIKA LUB OSOBY REPREZENTUJ�CEJ PODATNIKA                                                                       �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  � 12.Imi&_e.                                                � 13.Nazwisko                                                       �])
      mon_drk([�  �                               ]+zDEKLIMIE+[          �                                   ]+zDEKLNAZWI+[            �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  � 14.Telefon kontaktowy            � 15.Data wype&_l.nienia (dzie&_n.-miesi&_a.c-rok) � 16.Podpis (i piecz&_a.tka) podatnika lub osoby   �])
      mon_drk([�  �                                  �                                         �    reprezentuj&_a.cej podatnika                  �])
      mon_drk([�  �     ]+zDEKLTEL+[    �                                         �                                               �])
      mon_drk([���������������������������������������������������������������������������������������������������������������������������������])
      mon_drk([1) W przypadku, gdy liczba nabywc�w przekracza liczb� wierszy przeznaczonych do ich wpisania w cz��ci C lub D informacji nale�y ])
      mon_drk([    wype�ni� kolejn� informacj� i oznaczy� j� odpowiednim numerem za��cznika w og�lnej liczbie z�o�onych za��cznik�w. ])
      mon_drk([2) Korekt� informacji nale�y z�o�y�, je�eli dane zawarte we wcze�niej z�o�onej informacji podsumowuj�cej wymagaj� zmiany. ])
      mon_drk([3) W przypadku informacji sk�adanej papierowo, poz. 11 lub 12 Razem wype�nia si� tylko na ostatnim za��czniku. ])
      mon_drk([                                                            Obja�nienia: ])
      mon_drk([*  W przypadku informacji sk�adanej za pomoc� �rodk�w komunikacji elektronicznej (interaktywnej) poz. 6 nie wype�nia si� ])
      mon_drk([   (wiersze w cz��ci C lub D stanowi� list� rozwijaln�). ])
      mon_drk([*  W cz��ci C lub D informacji: ])
      mon_drk([   1) kol. a. wype�nia si� tylko, je�li w poz.8 zaznaczono kwadrat nr 2 ?korekta informacji?. ])
      mon_drk([   2) w kol. c. nale�y wpisa� poprawny identyfikator podatkowy NIP nabywcy towar�w lub us�ug. ])
      mon_drk([   3) w kol. d. nale�y wpisa� ��czn� warto�� dostaw towar�w lub �wiadczonych us�ug, dla kt�rych podatnikiem jest nabywca zgodnie])
      mon_drk([   z art. 17 ust. 1 pkt 7 i 8 ustawy, dokonanych w okresie, za kt�ry sk�adana jest informacja, dla poszczeg�lnych nabywc�w. ])
      mon_drk([                                                              Pouczenie ])
      mon_drk([           Za podanie nieprawdy lub zatajenie prawdy grozi odpowiedzialno�� przewidziana w Kodeksie karnym skarbowym.  ])
      mon_drk([                                                                                                                                 ])
      mon_drk([ VAT-27(1)   2/2                                                                                                                 ])
      mon_drk([�])
end
