/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Micha� Gawrycki (gmsystems.pl)

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
      mon_drk([�         PL  ]+rozrzut(P4)+[   �                           �         �])
      mon_drk([����������������������������������������������������������������������������������])
      mon_drk([                                                                                  ])
      mon_drk([V A T - U E / C          INFORMACJA O WEWN&__A.TRZWSP&__O.LNOTOWYM  ])
      mon_drk([                                  SWIADCZENIU USLUG ])
      mon_drk([                     ����������Ŀ     �������������������������Ŀ                    ������������������Ŀ])
      mon_drk([                     �4.Miesiac �     �5.Kwarta&_l. �6.Rok         �                    �7.Numer za&_l.&_a.cznika�])
      mon_drk([                     �   ]+iif(zUEOKRES='K','    ',rozrzut(miesiac))+[   � LUB �   ]+iif(zUEOKRES='K',rozrzut(p5a),'    ')+[   �    ]+rozrzut(p5b)+[  �                    �        ]+str(numzal,2,0)+[        �])
      mon_drk([                     ������������     ���������������������������                    ��������������������])
      mon_drk([                                                                                  ])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������Ŀ])
      mon_drk([�Formularz mo&_z.e by&_c. sk&_l.adany jedynie jako za&_l.&_a.cznik do formularza VAT-UE.                                                       �])
      mon_drk([�Wype&_l.nia si&_e. tylko w przypadku, gdy liczba kontrahent&_o.w (dostawc&_o.w) przekracza liczb&_e. wierszy przeznaczonych do ich wpisywania �])
      mon_drk([�w cz&_e.&_s.ci E formularza VAT-UE.                                                                                                  �])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������ʹ])
      mon_drk([� A. DANE IDENTYFIKACYJNE PODATNIKA                                                                                             �])
      mon_drk([�    * - dotyczy podmiot&_o.w nieb&_e.d&_a.cych osobami fizycznymi                    ** - dotyczy podmiot&_o.w b&_e.d&_a.cych osobami fizycznymi �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �8.Rodzaj podatnika(zaznaczy&_c. w&_l.a&_s.ciwy kwadrat):                                                                             �])
      mon_drk([�  �                         ]+iif(spolka_,'[XX]','[  ]')+[  1.Podatnik nieb&_e.d&_a.cy osob&_a. fizyczn&_a.            ]+iif(.not.spolka_,'[XX]','[  ]')+[  2.Osoba fizyczna                        �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �9.Nazwa pe&_l.na,REGON * / Nazwisko, pierwsze imi&_e., data urodzenia **                                                          �])
      mon_drk([�  � ]+padc(rozrzut(alltrim(P8))+[     ]+P11,120)+[   �])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������ʹ])
      mon_drk([� B. INFORMACJA O WEWN&__A.TRZWSP&__O.LNOTOWYM SWIADCZENIU USLUG                                                                        �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�  �   Kod   �         Numer identyfikacyjny VAT kontrahenta           �          Kwota transakcji w z&_l.                         �])
      mon_drk([�  �  kraju  �                                                         �                                                        �])
      mon_drk([�  �    a    �                            b                            �                     c                                  �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 1�   ]+rozrzut(UEusl[1,1])+[  �              ]+UEusl[1,2]+[             �             ]+kwota(UEusl[1,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 2�   ]+rozrzut(UEusl[2,1])+[  �              ]+UEusl[2,2]+[             �             ]+kwota(UEusl[2,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 3�   ]+rozrzut(UEusl[3,1])+[  �              ]+UEusl[3,2]+[             �             ]+kwota(UEusl[3,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 4�   ]+rozrzut(UEusl[4,1])+[  �              ]+UEusl[4,2]+[             �             ]+kwota(UEusl[4,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 5�   ]+rozrzut(UEusl[5,1])+[  �              ]+UEusl[5,2]+[             �             ]+kwota(UEusl[5,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 6�   ]+rozrzut(UEusl[6,1])+[  �              ]+UEusl[6,2]+[             �             ]+kwota(UEusl[6,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 7�   ]+rozrzut(UEusl[7,1])+[  �              ]+UEusl[7,2]+[             �             ]+kwota(UEusl[7,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 8�   ]+rozrzut(UEusl[8,1])+[  �              ]+UEusl[8,2]+[             �             ]+kwota(UEusl[8,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([� 9�   ]+rozrzut(UEusl[9,1])+[  �              ]+UEusl[9,2]+[             �             ]+kwota(UEusl[9,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�10�   ]+rozrzut(UEusl[10,1])+[  �              ]+UEusl[10,2]+[             �             ]+kwota(UEusl[10,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�11�   ]+rozrzut(UEusl[11,1])+[  �              ]+UEusl[11,2]+[             �             ]+kwota(UEusl[11,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�12�   ]+rozrzut(UEusl[12,1])+[  �              ]+UEusl[12,2]+[             �             ]+kwota(UEusl[12,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�13�   ]+rozrzut(UEusl[13,1])+[  �              ]+UEusl[13,2]+[             �             ]+kwota(UEusl[13,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�14�   ]+rozrzut(UEusl[14,1])+[  �              ]+UEusl[14,2]+[             �             ]+kwota(UEusl[14,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�15�   ]+rozrzut(UEusl[15,1])+[  �              ]+UEusl[15,2]+[             �             ]+kwota(UEusl[15,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�16�   ]+rozrzut(UEusl[16,1])+[  �              ]+UEusl[16,2]+[             �             ]+kwota(UEusl[16,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�17�   ]+rozrzut(UEusl[17,1])+[  �              ]+UEusl[17,2]+[             �             ]+kwota(UEusl[17,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�18�   ]+rozrzut(UEusl[18,1])+[  �              ]+UEusl[18,2]+[             �             ]+kwota(UEusl[18,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�19�   ]+rozrzut(UEusl[19,1])+[  �              ]+UEusl[19,2]+[             �             ]+kwota(UEusl[19,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�20�   ]+rozrzut(UEusl[20,1])+[  �              ]+UEusl[20,2]+[             �             ]+kwota(UEusl[20,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�21�   ]+rozrzut(UEusl[21,1])+[  �              ]+UEusl[21,2]+[             �             ]+kwota(UEusl[21,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�22�   ]+rozrzut(UEusl[22,1])+[  �              ]+UEusl[22,2]+[             �             ]+kwota(UEusl[22,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�23�   ]+rozrzut(UEusl[23,1])+[  �              ]+UEusl[23,2]+[             �             ]+kwota(UEusl[23,3],16,2)+[                           �])
      mon_drk([���������������������������������������������������������������������������������������������������������������������������������])
      mon_drk([                                                                                                               VAT-UE/C(2)   1/2 ])
      mon_drk([�������������������������������������������������������������������������������������������������������������������������������Ŀ])
      mon_drk([�24�   ]+rozrzut(UEusl[24,1])+[  �              ]+UEusl[24,2]+[             �             ]+kwota(UEusl[24,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�25�   ]+rozrzut(UEusl[25,1])+[  �              ]+UEusl[25,2]+[             �             ]+kwota(UEusl[25,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�26�   ]+rozrzut(UEusl[26,1])+[  �              ]+UEusl[26,2]+[             �             ]+kwota(UEusl[26,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�27�   ]+rozrzut(UEusl[27,1])+[  �              ]+UEusl[27,2]+[             �             ]+kwota(UEusl[27,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�28�   ]+rozrzut(UEusl[28,1])+[  �              ]+UEusl[28,2]+[             �             ]+kwota(UEusl[28,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�29�   ]+rozrzut(UEusl[29,1])+[  �              ]+UEusl[29,2]+[             �             ]+kwota(UEusl[29,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�30�   ]+rozrzut(UEusl[30,1])+[  �              ]+UEusl[30,2]+[             �             ]+kwota(UEusl[30,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�31�   ]+rozrzut(UEusl[31,1])+[  �              ]+UEusl[31,2]+[             �             ]+kwota(UEusl[31,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�32�   ]+rozrzut(UEusl[32,1])+[  �              ]+UEusl[32,2]+[             �             ]+kwota(UEusl[32,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�33�   ]+rozrzut(UEusl[33,1])+[  �              ]+UEusl[33,2]+[             �             ]+kwota(UEusl[33,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�34�   ]+rozrzut(UEusl[34,1])+[  �              ]+UEusl[34,2]+[             �             ]+kwota(UEusl[34,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�35�   ]+rozrzut(UEusl[35,1])+[  �              ]+UEusl[35,2]+[             �             ]+kwota(UEusl[35,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�36�   ]+rozrzut(UEusl[36,1])+[  �              ]+UEusl[36,2]+[             �             ]+kwota(UEusl[36,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�37�   ]+rozrzut(UEusl[37,1])+[  �              ]+UEusl[37,2]+[             �             ]+kwota(UEusl[37,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�38�   ]+rozrzut(UEusl[38,1])+[  �              ]+UEusl[38,2]+[             �             ]+kwota(UEusl[38,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�39�   ]+rozrzut(UEusl[39,1])+[  �              ]+UEusl[39,2]+[             �             ]+kwota(UEusl[39,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�40�   ]+rozrzut(UEusl[40,1])+[  �              ]+UEusl[40,2]+[             �             ]+kwota(UEusl[40,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�41�   ]+rozrzut(UEusl[41,1])+[  �              ]+UEusl[41,2]+[             �             ]+kwota(UEusl[41,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�42�   ]+rozrzut(UEusl[42,1])+[  �              ]+UEusl[42,2]+[             �             ]+kwota(UEusl[42,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�43�   ]+rozrzut(UEusl[43,1])+[  �              ]+UEusl[43,2]+[             �             ]+kwota(UEusl[43,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�44�   ]+rozrzut(UEusl[44,1])+[  �              ]+UEusl[44,2]+[             �             ]+kwota(UEusl[44,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�45�   ]+rozrzut(UEusl[45,1])+[  �              ]+UEusl[45,2]+[             �             ]+kwota(UEusl[45,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�46�   ]+rozrzut(UEusl[46,1])+[  �              ]+UEusl[46,2]+[             �             ]+kwota(UEusl[46,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�47�   ]+rozrzut(UEusl[47,1])+[  �              ]+UEusl[47,2]+[             �             ]+kwota(UEusl[47,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�48�   ]+rozrzut(UEusl[48,1])+[  �              ]+UEusl[48,2]+[             �             ]+kwota(UEusl[48,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�49�   ]+rozrzut(UEusl[49,1])+[  �              ]+UEusl[49,2]+[             �             ]+kwota(UEusl[49,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�50�   ]+rozrzut(UEusl[50,1])+[  �              ]+UEusl[50,2]+[             �             ]+kwota(UEusl[50,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�51�   ]+rozrzut(UEusl[51,1])+[  �              ]+UEusl[51,2]+[             �             ]+kwota(UEusl[51,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�52�   ]+rozrzut(UEusl[52,1])+[  �              ]+UEusl[52,2]+[             �             ]+kwota(UEusl[52,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�53�   ]+rozrzut(UEusl[53,1])+[  �              ]+UEusl[53,2]+[             �             ]+kwota(UEusl[53,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�54�   ]+rozrzut(UEusl[54,1])+[  �              ]+UEusl[54,2]+[             �             ]+kwota(UEusl[54,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�55�   ]+rozrzut(UEusl[55,1])+[  �              ]+UEusl[55,2]+[             �             ]+kwota(UEusl[55,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�56�   ]+rozrzut(UEusl[56,1])+[  �              ]+UEusl[56,2]+[             �             ]+kwota(UEusl[56,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�57�   ]+rozrzut(UEusl[57,1])+[  �              ]+UEusl[57,2]+[             �             ]+kwota(UEusl[57,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�58�   ]+rozrzut(UEusl[58,1])+[  �              ]+UEusl[58,2]+[             �             ]+kwota(UEusl[58,3],16,2)+[                           �])
      mon_drk([�  ����������������������������������������������������������������������������������������������������������������������������Ĵ])
      mon_drk([�59�   ]+rozrzut(UEusl[59,1])+[  �              ]+UEusl[59,2]+[             �             ]+kwota(UEusl[59,3],16,2)+[                           �])
      mon_drk([���������������������������������������������������������������������������������������������������������������������������������])
      mon_drk([                                                                                                                                 ])
      mon_drk([                                                                                                                                 ])
      mon_drk([                                                                                                                                 ])
      mon_drk([                                                                                                                                 ])
      mon_drk([                                                                                                                                 ])
      mon_drk([ VAT-UE/C(2)   2/2                                                                                                               ])
      mon_drk([�])
end
