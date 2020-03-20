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

FUNCTION kartka_ordzu(cNIP1, cNazwa1, cNazwaS1, cData1, cREGON1, cNIP2, cNazwa2, cNazwaS2, cData2, cREGON2, cTresc, cWersja)
   private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
   private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
   hb_default(@cWersja, '2')
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
      mon_drk([ö]+procname())
      mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³1.Identyfikator podatkowy NIP podmiotu 1                             ³3.Nr dokumentu                       ³4.Status           ³])
      mon_drk([³ ]+ PadC(rozrzut(cNIP1),67)+[ ³                                     ³                   ³])
      mon_drk([ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´                                     ³                   ³])
      mon_drk([³2.Identyfikator podatkowy NIP,PESEL podmiotu 2                       ³                                     ³                   ³])
      mon_drk([³ ]+ PadC(rozrzut(cNIP2),67)+[ ³                                     ³                   ³])
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      mon_drk([O R D - Z U])
      mon_drk([])
      mon_drk([                     U Z A S A D N I E N I E     P R Z Y C Z Y N     K O R E K T Y     D E K L A R A C J I])
      mon_drk([])
      mon_drk([ÚÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¿])
      mon_drk([³ A. DANE IDENTYFIKACYJNE                                                                                                       ³])
      mon_drk([ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³ A.1. DANE IDENTYFIKACYJNE PODMIOTU 1                                                                                          ³])
      mon_drk([³   *-dotyczy podatnik¢w/pˆatnik¢w nieb©d¥cych osobami fizycznymi  **-dotyczy podatnik¢w/pˆatnik¢w b©d¥cych osobami fizycznymi  ³])
      mon_drk([³  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³  ³5.Nazwa peˆna */ Nazwisko **                                     ³6.Nazwa skr¢cona */ Pierwsze imi© **                      ³])
      mon_drk([³  ³   ]+padc(AllTrim(cNazwa1),60)+[  ³  ] + PadC(AllTrim(cNazwaS1), 53) + [   ³])
      mon_drk([³  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³  ³7.Data urodzenia **                                              ³8.REGON *                                                 ³])
      mon_drk([³  ³   ]+padc(AllTrim(cData1),60)+[  ³  ] + PadC(AllTrim(cREGON1), 53) + [   ³])
      mon_drk([ÃÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³ A.2. DANE IDENTYFIKACYJNE PODMIOTU 2                                                                                          ³])
      mon_drk([³  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³  ³9.Nazwa peˆna */ Nazwisko **                                     ³10.Nazwa skr¢cona */ Pierwsze imi© **                     ³])
      mon_drk([³  ³   ]+padc(AllTrim(cNazwa2),60)+[  ³  ] + PadC(AllTrim(cNazwaS2), 53) + [   ³])
      mon_drk([³  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³  ³11.Data urodzenia **                                             ³12.REGON *                                                ³])
      mon_drk([³  ³   ]+padc(AllTrim(cData2),60)+[  ³  ] + PadC(AllTrim(cREGON2), 53) + [   ³])
      mon_drk([ÃÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ´])
      mon_drk([³ B. UZASADNIENIE PRZYCZYN ZO½ENIA KOREKTY                                                                                     ³])
      mon_drk([³  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³  ³13.Tre˜† uzasadnienia                                                                                                       ³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  1, MemoLine(cTresc, 124,  1), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  2, MemoLine(cTresc, 124,  2), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  3, MemoLine(cTresc, 124,  3), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  4, MemoLine(cTresc, 124,  4), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  5, MemoLine(cTresc, 124,  5), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  6, MemoLine(cTresc, 124,  6), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  7, MemoLine(cTresc, 124,  7), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  8, MemoLine(cTresc, 124,  8), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >=  9, MemoLine(cTresc, 124,  9), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 10, MemoLine(cTresc, 124, 10), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 11, MemoLine(cTresc, 124, 11), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 12, MemoLine(cTresc, 124, 12), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 13, MemoLine(cTresc, 124, 13), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 14, MemoLine(cTresc, 124, 14), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 15, MemoLine(cTresc, 124, 15), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 16, MemoLine(cTresc, 124, 16), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 17, MemoLine(cTresc, 124, 17), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 18, MemoLine(cTresc, 124, 18), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 19, MemoLine(cTresc, 124, 19), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 20, MemoLine(cTresc, 124, 20), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 21, MemoLine(cTresc, 124, 21), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 22, MemoLine(cTresc, 124, 22), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 23, MemoLine(cTresc, 124, 23), ''), 124) + [³])
      mon_drk([³  ³] + PadC(iif(MLCount(cTresc, 124) >= 24, MemoLine(cTresc, 124, 24), ''), 124) + [³])
      mon_drk([ÀÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      mon_drk([                                                                                                                      ORD-ZU 1/1])
      mon_drk([ş])
   end
   RETURN

/*----------------------------------------------------------------------*/

