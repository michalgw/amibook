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

FUNCTION edek_pit4r_5()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2014/12/08/1883/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-4R (5)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-4R</KodFormularza>' + nl
      r = r + '    <WariantFormularza>5</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
         r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_9>' + TNaturalny(z1a01) + '</P_9>' + nl
		r = r + '    <P_10>' + TNaturalny(z1a02) + '</P_10>' + nl
		r = r + '    <P_11>' + TNaturalny(z1a03) + '</P_11>' + nl
		r = r + '    <P_12>' + TNaturalny(z1a04) + '</P_12>' + nl
		r = r + '    <P_13>' + TNaturalny(z1a05) + '</P_13>' + nl
		r = r + '    <P_14>' + TNaturalny(z1a06) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaCNieujemna(z1b01) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaCNieujemna(z1b02) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaCNieujemna(z1b03) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaCNieujemna(z1b04) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaCNieujemna(z1b05) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaCNieujemna(z1b06) + '</P_20>' + nl
		r = r + '    <P_21>' + TNaturalny(z1a07) + '</P_21>' + nl
		r = r + '    <P_22>' + TNaturalny(z1a08) + '</P_22>' + nl
		r = r + '    <P_23>' + TNaturalny(z1a09) + '</P_23>' + nl
		r = r + '    <P_24>' + TNaturalny(z1a10) + '</P_24>' + nl
		r = r + '    <P_25>' + TNaturalny(z1a11) + '</P_25>' + nl
		r = r + '    <P_26>' + TNaturalny(z1a12) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaCNieujemna(z1b07) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaCNieujemna(z1b08) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaCNieujemna(z1b09) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaCNieujemna(z1b10) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaCNieujemna(z1b11) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaCNieujemna(z1b12) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaCNieujemna(z201) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaCNieujemna(z202) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaCNieujemna(z203) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaCNieujemna(z204) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna(z205) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(z206) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwotaCNieujemna(z207) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwotaCNieujemna(z208) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaCNieujemna(z209) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwotaCNieujemna(z210) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaCNieujemna(z211) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaCNieujemna(z212) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaCNieujemna(z301) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaCNieujemna(z302) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwotaCNieujemna(z303) + '</P_47>' + nl
		r = r + '    <P_48>' + TKwotaCNieujemna(z304) + '</P_48>' + nl
		r = r + '    <P_49>' + TKwotaCNieujemna(z305) + '</P_49>' + nl
		r = r + '    <P_50>' + TKwotaCNieujemna(z306) + '</P_50>' + nl
		r = r + '    <P_51>' + TKwotaCNieujemna(z307) + '</P_51>' + nl
		r = r + '    <P_52>' + TKwotaCNieujemna(z308) + '</P_52>' + nl
		r = r + '    <P_53>' + TKwotaCNieujemna(z309) + '</P_53>' + nl
		r = r + '    <P_54>' + TKwotaCNieujemna(z310) + '</P_54>' + nl
		r = r + '    <P_55>' + TKwotaCNieujemna(z311) + '</P_55>' + nl
		r = r + '    <P_56>' + TKwotaCNieujemna(z312) + '</P_56>' + nl
		r = r + '    <P_57>' + TKwotaCNieujemna(z401) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwotaCNieujemna(z402) + '</P_58>' + nl
		r = r + '    <P_59>' + TKwotaCNieujemna(z403) + '</P_59>' + nl
		r = r + '    <P_60>' + TKwotaCNieujemna(z404) + '</P_60>' + nl
		r = r + '    <P_61>' + TKwotaCNieujemna(z405) + '</P_61>' + nl
		r = r + '    <P_62>' + TKwotaCNieujemna(z406) + '</P_62>' + nl
		r = r + '    <P_63>' + TKwotaCNieujemna(z407) + '</P_63>' + nl
		r = r + '    <P_64>' + TKwotaCNieujemna(z408) + '</P_64>' + nl
		r = r + '    <P_65>' + TKwotaCNieujemna(z409) + '</P_65>' + nl
		r = r + '    <P_66>' + TKwotaCNieujemna(z410) + '</P_66>' + nl
		r = r + '    <P_67>' + TKwotaCNieujemna(z411) + '</P_67>' + nl
		r = r + '    <P_68>' + TKwotaCNieujemna(z412) + '</P_68>' + nl
		r = r + '    <P_69>' + TKwotaCNieujemna(z501) + '</P_69>' + nl
		r = r + '    <P_70>' + TKwotaCNieujemna(z502) + '</P_70>' + nl
		r = r + '    <P_71>' + TKwotaCNieujemna(z503) + '</P_71>' + nl
		r = r + '    <P_72>' + TKwotaCNieujemna(z504) + '</P_72>' + nl
		r = r + '    <P_73>' + TKwotaCNieujemna(z505) + '</P_73>' + nl
		r = r + '    <P_74>' + TKwotaCNieujemna(z506) + '</P_74>' + nl
		r = r + '    <P_75>' + TKwotaCNieujemna(z507) + '</P_75>' + nl
		r = r + '    <P_76>' + TKwotaCNieujemna(z508) + '</P_76>' + nl
		r = r + '    <P_77>' + TKwotaCNieujemna(z509) + '</P_77>' + nl
		r = r + '    <P_78>' + TKwotaCNieujemna(z510) + '</P_78>' + nl
		r = r + '    <P_79>' + TKwotaCNieujemna(z511) + '</P_79>' + nl
		r = r + '    <P_80>' + TKwotaCNieujemna(z512) + '</P_80>' + nl
		r = r + '    <P_81>' + TKwotaCNieujemna(z601) + '</P_81>' + nl
		r = r + '    <P_82>' + TKwotaCNieujemna(z602) + '</P_82>' + nl
		r = r + '    <P_83>' + TKwotaCNieujemna(z603) + '</P_83>' + nl
		r = r + '    <P_84>' + TKwotaCNieujemna(z604) + '</P_84>' + nl
		r = r + '    <P_85>' + TKwotaCNieujemna(z701) + '</P_85>' + nl
		r = r + '    <P_86>' + TKwotaCNieujemna(z702) + '</P_86>' + nl
		r = r + '    <P_87>' + TKwotaCNieujemna(z703) + '</P_87>' + nl
		r = r + '    <P_88>' + TKwotaCNieujemna(z704) + '</P_88>' + nl
		r = r + '    <P_89>' + TKwotaCNieujemna(z705) + '</P_89>' + nl
		r = r + '    <P_90>' + TKwotaCNieujemna(z706) + '</P_90>' + nl
		r = r + '    <P_91>' + TKwotaCNieujemna(z707) + '</P_91>' + nl
		r = r + '    <P_92>' + TKwotaCNieujemna(z708) + '</P_92>' + nl
		r = r + '    <P_93>' + TKwotaCNieujemna(z709) + '</P_93>' + nl
		r = r + '    <P_94>' + TKwotaCNieujemna(z710) + '</P_94>' + nl
		r = r + '    <P_95>' + TKwotaCNieujemna(z711) + '</P_95>' + nl
		r = r + '    <P_96>' + TKwotaCNieujemna(z712) + '</P_96>' + nl
		r = r + '    <P_97>' + TKwotaCNieujemna(z801) + '</P_97>' + nl
		r = r + '    <P_98>' + TKwotaCNieujemna(z802) + '</P_98>' + nl
		r = r + '    <P_99>' + TKwotaCNieujemna(z803) + '</P_99>' + nl
		r = r + '    <P_100>' + TKwotaCNieujemna(z804) + '</P_100>' + nl
		r = r + '    <P_101>' + TKwotaCNieujemna(z805) + '</P_101>' + nl
		r = r + '    <P_102>' + TKwotaCNieujemna(z806) + '</P_102>' + nl
		r = r + '    <P_103>' + TKwotaCNieujemna(z807) + '</P_103>' + nl
		r = r + '    <P_104>' + TKwotaCNieujemna(z808) + '</P_104>' + nl
		r = r + '    <P_105>' + TKwotaCNieujemna(z809) + '</P_105>' + nl
		r = r + '    <P_106>' + TKwotaCNieujemna(z810) + '</P_106>' + nl
		r = r + '    <P_107>' + TKwotaCNieujemna(z811) + '</P_107>' + nl
		r = r + '    <P_108>' + TKwotaCNieujemna(z812) + '</P_108>' + nl
		r = r + '    <P_109>' + TKwotaCNieujemna(z1001) + '</P_109>' + nl
		r = r + '    <P_110>' + TKwotaCNieujemna(z1002) + '</P_110>' + nl
		r = r + '    <P_111>' + TKwotaCNieujemna(z1003) + '</P_111>' + nl
		r = r + '    <P_112>' + TKwotaCNieujemna(z1004) + '</P_112>' + nl
		r = r + '    <P_113>' + TKwotaCNieujemna(z1005) + '</P_113>' + nl
		r = r + '    <P_114>' + TKwotaCNieujemna(z1006) + '</P_114>' + nl
		r = r + '    <P_115>' + TKwotaCNieujemna(z1007) + '</P_115>' + nl
		r = r + '    <P_116>' + TKwotaCNieujemna(z1008) + '</P_116>' + nl
		r = r + '    <P_117>' + TKwotaCNieujemna(z1009) + '</P_117>' + nl
		r = r + '    <P_118>' + TKwotaCNieujemna(z1010) + '</P_118>' + nl
		r = r + '    <P_119>' + TKwotaCNieujemna(z1011) + '</P_119>' + nl
		r = r + '    <P_120>' + TKwotaCNieujemna(z1012) + '</P_120>' + nl
		r = r + '    <P_121>' + TKwotaCNieujemna(z901) + '</P_121>' + nl
		r = r + '    <P_122>' + TKwotaCNieujemna(z902) + '</P_122>' + nl
		r = r + '    <P_123>' + TKwotaCNieujemna(z903) + '</P_123>' + nl
		r = r + '    <P_124>' + TKwotaCNieujemna(z904) + '</P_124>' + nl
		r = r + '    <P_125>' + TKwotaCNieujemna(z905) + '</P_125>' + nl
		r = r + '    <P_126>' + TKwotaCNieujemna(z906) + '</P_126>' + nl
		r = r + '    <P_127>' + TKwotaCNieujemna(z907) + '</P_127>' + nl
		r = r + '    <P_128>' + TKwotaCNieujemna(z908) + '</P_128>' + nl
		r = r + '    <P_129>' + TKwotaCNieujemna(z909) + '</P_129>' + nl
		r = r + '    <P_130>' + TKwotaCNieujemna(z910) + '</P_130>' + nl
		r = r + '    <P_131>' + TKwotaCNieujemna(z911) + '</P_131>' + nl
		r = r + '    <P_132>' + TKwotaCNieujemna(z912) + '</P_132>' + nl
		r = r + '    <P_133>' + TKwotaCNieujemna(z1101) + '</P_133>' + nl
		r = r + '    <P_134>' + TKwotaCNieujemna(z1102) + '</P_134>' + nl
		r = r + '    <P_135>' + TKwotaCNieujemna(z1103) + '</P_135>' + nl
		r = r + '    <P_136>' + TKwotaCNieujemna(z1104) + '</P_136>' + nl
		r = r + '    <P_137>' + TKwotaCNieujemna(z1105) + '</P_137>' + nl
		r = r + '    <P_138>' + TKwotaCNieujemna(z1106) + '</P_138>' + nl
		r = r + '    <P_139>' + TKwotaCNieujemna(z1107) + '</P_139>' + nl
		r = r + '    <P_140>' + TKwotaCNieujemna(z1108) + '</P_140>' + nl
		r = r + '    <P_141>' + TKwotaCNieujemna(z1109) + '</P_141>' + nl
		r = r + '    <P_142>' + TKwotaCNieujemna(z1110) + '</P_142>' + nl
		r = r + '    <P_143>' + TKwotaCNieujemna(z1111) + '</P_143>' + nl
		r = r + '    <P_144>' + TKwotaCNieujemna(z1112) + '</P_144>' + nl
		r = r + '    <P_145>' + TKwotaCNieujemna(z1201) + '</P_145>' + nl
		r = r + '    <P_146>' + TKwotaCNieujemna(z1202) + '</P_146>' + nl
		r = r + '    <P_147>' + TKwotaCNieujemna(z1203) + '</P_147>' + nl
		r = r + '    <P_148>' + TKwotaCNieujemna(z1204) + '</P_148>' + nl
		r = r + '    <P_149>' + TKwotaCNieujemna(z1205) + '</P_149>' + nl
		r = r + '    <P_150>' + TKwotaCNieujemna(z1206) + '</P_150>' + nl
		r = r + '    <P_151>' + TKwotaCNieujemna(z1207) + '</P_151>' + nl
		r = r + '    <P_152>' + TKwotaCNieujemna(z1208) + '</P_152>' + nl
		r = r + '    <P_153>' + TKwotaCNieujemna(z1209) + '</P_153>' + nl
		r = r + '    <P_154>' + TKwotaCNieujemna(z1210) + '</P_154>' + nl
		r = r + '    <P_155>' + TKwotaCNieujemna(z1211) + '</P_155>' + nl
		r = r + '    <P_156>' + TKwotaCNieujemna(z1212) + '</P_156>' + nl
		r = r + '    <P_157>' + TKwotaCNieujemna(z1301) + '</P_157>' + nl
		r = r + '    <P_158>' + TKwotaCNieujemna(z1302) + '</P_158>' + nl
		r = r + '    <P_159>' + TKwotaCNieujemna(z1303) + '</P_159>' + nl
		r = r + '    <P_160>' + TKwotaCNieujemna(z1304) + '</P_160>' + nl
		r = r + '    <P_161>' + TKwotaCNieujemna(z1305) + '</P_161>' + nl
		r = r + '    <P_162>' + TKwotaCNieujemna(z1306) + '</P_162>' + nl
		r = r + '    <P_163>' + TKwotaCNieujemna(z1307) + '</P_163>' + nl
		r = r + '    <P_164>' + TKwotaCNieujemna(z1308) + '</P_164>' + nl
		r = r + '    <P_165>' + TKwotaCNieujemna(z1309) + '</P_165>' + nl
		r = r + '    <P_166>' + TKwotaCNieujemna(z1310) + '</P_166>' + nl
		r = r + '    <P_167>' + TKwotaCNieujemna(z1311) + '</P_167>' + nl
		r = r + '    <P_168>' + TKwotaCNieujemna(z1312) + '</P_168>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwot z poz. od 157 do 168 lub wpˆacenia ich w niepeˆnej wysoko˜ci niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2012 r. poz. 1015, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowi¥zkom pˆatnika grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
		r = r + '  <Objasnienie>' + str2sxml('Kwoty podatku i wynagrodzenia przysˆuguj¥cego pˆatnikom z tytuˆu terminowego wpˆacenia podatku dochodowego, zgodnie z art. 63 Ordynacji podatkowej, zaokr¥gla si© do peˆnych zˆotych.') + '</Objasnienie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit4r)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_pit4r) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit4r_6()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2015/12/22/3031/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-4R (6)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-4R</KodFormularza>' + nl
      r = r + '    <WariantFormularza>6</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
         r = r + '      <NIP>' + trimnip(P1) + '</NIP>' + nl
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P8d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(z1a01, '    <P_9>' + TNaturalny(z1a01) + '</P_9>' + nl)
		r = r + xmlNiePusty(z1a02, '    <P_10>' + TNaturalny(z1a02) + '</P_10>' + nl)
		r = r + xmlNiePusty(z1a03, '    <P_11>' + TNaturalny(z1a03) + '</P_11>' + nl)
		r = r + xmlNiePusty(z1a04, '    <P_12>' + TNaturalny(z1a04) + '</P_12>' + nl)
		r = r + xmlNiePusty(z1a05, '    <P_13>' + TNaturalny(z1a05) + '</P_13>' + nl)
		r = r + xmlNiePusty(z1a06, '    <P_14>' + TNaturalny(z1a06) + '</P_14>' + nl)
		r = r + xmlNiePusty(z1b01, '    <P_15>' + TKwotaCNieujemna(z1b01) + '</P_15>' + nl)
		r = r + xmlNiePusty(z1b02, '    <P_16>' + TKwotaCNieujemna(z1b02) + '</P_16>' + nl)
		r = r + xmlNiePusty(z1b03, '    <P_17>' + TKwotaCNieujemna(z1b03) + '</P_17>' + nl)
		r = r + xmlNiePusty(z1b04, '    <P_18>' + TKwotaCNieujemna(z1b04) + '</P_18>' + nl)
		r = r + xmlNiePusty(z1b05, '    <P_19>' + TKwotaCNieujemna(z1b05) + '</P_19>' + nl)
		r = r + xmlNiePusty(z1b06, '    <P_20>' + TKwotaCNieujemna(z1b06) + '</P_20>' + nl)
		r = r + xmlNiePusty(z1a07, '    <P_21>' + TNaturalny(z1a07) + '</P_21>' + nl)
		r = r + xmlNiePusty(z1a08, '    <P_22>' + TNaturalny(z1a08) + '</P_22>' + nl)
		r = r + xmlNiePusty(z1a09, '    <P_23>' + TNaturalny(z1a09) + '</P_23>' + nl)
		r = r + xmlNiePusty(z1a10, '    <P_24>' + TNaturalny(z1a10) + '</P_24>' + nl)
		r = r + xmlNiePusty(z1a11, '    <P_25>' + TNaturalny(z1a11) + '</P_25>' + nl)
		r = r + xmlNiePusty(z1a12, '    <P_26>' + TNaturalny(z1a12) + '</P_26>' + nl)
		r = r + xmlNiePusty(z1b07, '    <P_27>' + TKwotaCNieujemna(z1b07) + '</P_27>' + nl)
		r = r + xmlNiePusty(z1b08, '    <P_28>' + TKwotaCNieujemna(z1b08) + '</P_28>' + nl)
		r = r + xmlNiePusty(z1b09, '    <P_29>' + TKwotaCNieujemna(z1b09) + '</P_29>' + nl)
		r = r + xmlNiePusty(z1b10, '    <P_30>' + TKwotaCNieujemna(z1b10) + '</P_30>' + nl)
		r = r + xmlNiePusty(z1b11, '    <P_31>' + TKwotaCNieujemna(z1b11) + '</P_31>' + nl)
		r = r + xmlNiePusty(z1b12, '    <P_32>' + TKwotaCNieujemna(z1b12) + '</P_32>' + nl)
		r = r + xmlNiePusty(z201, '    <P_33>' + TKwotaCNieujemna(z201) + '</P_33>' + nl)
		r = r + xmlNiePusty(z202, '    <P_34>' + TKwotaCNieujemna(z202) + '</P_34>' + nl)
		r = r + xmlNiePusty(z203, '    <P_35>' + TKwotaCNieujemna(z203) + '</P_35>' + nl)
		r = r + xmlNiePusty(z204, '    <P_36>' + TKwotaCNieujemna(z204) + '</P_36>' + nl)
		r = r + xmlNiePusty(z205, '    <P_37>' + TKwotaCNieujemna(z205) + '</P_37>' + nl)
		r = r + xmlNiePusty(z206, '    <P_38>' + TKwotaCNieujemna(z206) + '</P_38>' + nl)
		r = r + xmlNiePusty(z207, '    <P_39>' + TKwotaCNieujemna(z207) + '</P_39>' + nl)
		r = r + xmlNiePusty(z208, '    <P_40>' + TKwotaCNieujemna(z208) + '</P_40>' + nl)
		r = r + xmlNiePusty(z209, '    <P_41>' + TKwotaCNieujemna(z209) + '</P_41>' + nl)
		r = r + xmlNiePusty(z210, '    <P_42>' + TKwotaCNieujemna(z210) + '</P_42>' + nl)
		r = r + xmlNiePusty(z211, '    <P_43>' + TKwotaCNieujemna(z211) + '</P_43>' + nl)
		r = r + xmlNiePusty(z212, '    <P_44>' + TKwotaCNieujemna(z212) + '</P_44>' + nl)
		r = r + xmlNiePusty(z301, '    <P_45>' + TKwotaCNieujemna(z301) + '</P_45>' + nl)
		r = r + xmlNiePusty(z302, '    <P_46>' + TKwotaCNieujemna(z302) + '</P_46>' + nl)
		r = r + xmlNiePusty(z303, '    <P_47>' + TKwotaCNieujemna(z303) + '</P_47>' + nl)
		r = r + xmlNiePusty(z304, '    <P_48>' + TKwotaCNieujemna(z304) + '</P_48>' + nl)
		r = r + xmlNiePusty(z305, '    <P_49>' + TKwotaCNieujemna(z305) + '</P_49>' + nl)
		r = r + xmlNiePusty(z306, '    <P_50>' + TKwotaCNieujemna(z306) + '</P_50>' + nl)
		r = r + xmlNiePusty(z307, '    <P_51>' + TKwotaCNieujemna(z307) + '</P_51>' + nl)
		r = r + xmlNiePusty(z308, '    <P_52>' + TKwotaCNieujemna(z308) + '</P_52>' + nl)
		r = r + xmlNiePusty(z309, '    <P_53>' + TKwotaCNieujemna(z309) + '</P_53>' + nl)
		r = r + xmlNiePusty(z310, '    <P_54>' + TKwotaCNieujemna(z310) + '</P_54>' + nl)
		r = r + xmlNiePusty(z311, '    <P_55>' + TKwotaCNieujemna(z311) + '</P_55>' + nl)
		r = r + xmlNiePusty(z312, '    <P_56>' + TKwotaCNieujemna(z312) + '</P_56>' + nl)
		r = r + xmlNiePusty(z401, '    <P_57>' + TKwotaCNieujemna(z401) + '</P_57>' + nl)
		r = r + xmlNiePusty(z402, '    <P_58>' + TKwotaCNieujemna(z402) + '</P_58>' + nl)
		r = r + xmlNiePusty(z403, '    <P_59>' + TKwotaCNieujemna(z403) + '</P_59>' + nl)
		r = r + xmlNiePusty(z404, '    <P_60>' + TKwotaCNieujemna(z404) + '</P_60>' + nl)
		r = r + xmlNiePusty(z405, '    <P_61>' + TKwotaCNieujemna(z405) + '</P_61>' + nl)
		r = r + xmlNiePusty(z406, '    <P_62>' + TKwotaCNieujemna(z406) + '</P_62>' + nl)
		r = r + xmlNiePusty(z407, '    <P_63>' + TKwotaCNieujemna(z407) + '</P_63>' + nl)
		r = r + xmlNiePusty(z408, '    <P_64>' + TKwotaCNieujemna(z408) + '</P_64>' + nl)
		r = r + xmlNiePusty(z409, '    <P_65>' + TKwotaCNieujemna(z409) + '</P_65>' + nl)
		r = r + xmlNiePusty(z410, '    <P_66>' + TKwotaCNieujemna(z410) + '</P_66>' + nl)
		r = r + xmlNiePusty(z411, '    <P_67>' + TKwotaCNieujemna(z411) + '</P_67>' + nl)
		r = r + xmlNiePusty(z412, '    <P_68>' + TKwotaCNieujemna(z412) + '</P_68>' + nl)
		r = r + xmlNiePusty(z501, '    <P_69>' + TKwotaCNieujemna(z501) + '</P_69>' + nl)
		r = r + xmlNiePusty(z502, '    <P_70>' + TKwotaCNieujemna(z502) + '</P_70>' + nl)
		r = r + xmlNiePusty(z503, '    <P_71>' + TKwotaCNieujemna(z503) + '</P_71>' + nl)
		r = r + xmlNiePusty(z504, '    <P_72>' + TKwotaCNieujemna(z504) + '</P_72>' + nl)
		r = r + xmlNiePusty(z505, '    <P_73>' + TKwotaCNieujemna(z505) + '</P_73>' + nl)
		r = r + xmlNiePusty(z506, '    <P_74>' + TKwotaCNieujemna(z506) + '</P_74>' + nl)
		r = r + xmlNiePusty(z507, '    <P_75>' + TKwotaCNieujemna(z507) + '</P_75>' + nl)
		r = r + xmlNiePusty(z508, '    <P_76>' + TKwotaCNieujemna(z508) + '</P_76>' + nl)
		r = r + xmlNiePusty(z509, '    <P_77>' + TKwotaCNieujemna(z509) + '</P_77>' + nl)
		r = r + xmlNiePusty(z510, '    <P_78>' + TKwotaCNieujemna(z510) + '</P_78>' + nl)
		r = r + xmlNiePusty(z511, '    <P_79>' + TKwotaCNieujemna(z511) + '</P_79>' + nl)
		r = r + xmlNiePusty(z512, '    <P_80>' + TKwotaCNieujemna(z512) + '</P_80>' + nl)
		r = r + xmlNiePusty(z601, '    <P_81>' + TKwotaCNieujemna(z601) + '</P_81>' + nl)
		r = r + xmlNiePusty(z602, '    <P_82>' + TKwotaCNieujemna(z602) + '</P_82>' + nl)
		r = r + xmlNiePusty(z603, '    <P_83>' + TKwotaCNieujemna(z603) + '</P_83>' + nl)
		r = r + xmlNiePusty(z604, '    <P_84>' + TKwotaCNieujemna(z604) + '</P_84>' + nl)
		r = r + xmlNiePusty(z701, '    <P_85>' + TKwotaCNieujemna(z701) + '</P_85>' + nl)
		r = r + xmlNiePusty(z702, '    <P_86>' + TKwotaCNieujemna(z702) + '</P_86>' + nl)
		r = r + xmlNiePusty(z703, '    <P_87>' + TKwotaCNieujemna(z703) + '</P_87>' + nl)
		r = r + xmlNiePusty(z704, '    <P_88>' + TKwotaCNieujemna(z704) + '</P_88>' + nl)
		r = r + xmlNiePusty(z705, '    <P_89>' + TKwotaCNieujemna(z705) + '</P_89>' + nl)
		r = r + xmlNiePusty(z706, '    <P_90>' + TKwotaCNieujemna(z706) + '</P_90>' + nl)
		r = r + xmlNiePusty(z707, '    <P_91>' + TKwotaCNieujemna(z707) + '</P_91>' + nl)
		r = r + xmlNiePusty(z708, '    <P_92>' + TKwotaCNieujemna(z708) + '</P_92>' + nl)
		r = r + xmlNiePusty(z709, '    <P_93>' + TKwotaCNieujemna(z709) + '</P_93>' + nl)
		r = r + xmlNiePusty(z710, '    <P_94>' + TKwotaCNieujemna(z710) + '</P_94>' + nl)
		r = r + xmlNiePusty(z711, '    <P_95>' + TKwotaCNieujemna(z711) + '</P_95>' + nl)
		r = r + xmlNiePusty(z712, '    <P_96>' + TKwotaCNieujemna(z712) + '</P_96>' + nl)
		r = r + xmlNiePusty(z801, '    <P_97>' + TKwotaCNieujemna(z801) + '</P_97>' + nl)
		r = r + xmlNiePusty(z802, '    <P_98>' + TKwotaCNieujemna(z802) + '</P_98>' + nl)
		r = r + xmlNiePusty(z803, '    <P_99>' + TKwotaCNieujemna(z803) + '</P_99>' + nl)
		r = r + xmlNiePusty(z804, '    <P_100>' + TKwotaCNieujemna(z804) + '</P_100>' + nl)
		r = r + xmlNiePusty(z805, '    <P_101>' + TKwotaCNieujemna(z805) + '</P_101>' + nl)
		r = r + xmlNiePusty(z806, '    <P_102>' + TKwotaCNieujemna(z806) + '</P_102>' + nl)
		r = r + xmlNiePusty(z807, '    <P_103>' + TKwotaCNieujemna(z807) + '</P_103>' + nl)
		r = r + xmlNiePusty(z808, '    <P_104>' + TKwotaCNieujemna(z808) + '</P_104>' + nl)
		r = r + xmlNiePusty(z809, '    <P_105>' + TKwotaCNieujemna(z809) + '</P_105>' + nl)
		r = r + xmlNiePusty(z810, '    <P_106>' + TKwotaCNieujemna(z810) + '</P_106>' + nl)
		r = r + xmlNiePusty(z811, '    <P_107>' + TKwotaCNieujemna(z811) + '</P_107>' + nl)
		r = r + xmlNiePusty(z812, '    <P_108>' + TKwotaCNieujemna(z812) + '</P_108>' + nl)
		r = r + xmlNiePusty(z1001, '    <P_109>' + TKwotaCNieujemna(z1001) + '</P_109>' + nl)
		r = r + xmlNiePusty(z1002, '    <P_110>' + TKwotaCNieujemna(z1002) + '</P_110>' + nl)
		r = r + xmlNiePusty(z1003, '    <P_111>' + TKwotaCNieujemna(z1003) + '</P_111>' + nl)
		r = r + xmlNiePusty(z1004, '    <P_112>' + TKwotaCNieujemna(z1004) + '</P_112>' + nl)
		r = r + xmlNiePusty(z1005, '    <P_113>' + TKwotaCNieujemna(z1005) + '</P_113>' + nl)
		r = r + xmlNiePusty(z1006, '    <P_114>' + TKwotaCNieujemna(z1006) + '</P_114>' + nl)
		r = r + xmlNiePusty(z1007, '    <P_115>' + TKwotaCNieujemna(z1007) + '</P_115>' + nl)
		r = r + xmlNiePusty(z1008, '    <P_116>' + TKwotaCNieujemna(z1008) + '</P_116>' + nl)
		r = r + xmlNiePusty(z1009, '    <P_117>' + TKwotaCNieujemna(z1009) + '</P_117>' + nl)
		r = r + xmlNiePusty(z1010, '    <P_118>' + TKwotaCNieujemna(z1010) + '</P_118>' + nl)
		r = r + xmlNiePusty(z1011, '    <P_119>' + TKwotaCNieujemna(z1011) + '</P_119>' + nl)
		r = r + xmlNiePusty(z1012, '    <P_120>' + TKwotaCNieujemna(z1012) + '</P_120>' + nl)
		r = r + xmlNiePusty(z901, '    <P_121>' + TKwotaCNieujemna(z901) + '</P_121>' + nl)
		r = r + xmlNiePusty(z902, '    <P_122>' + TKwotaCNieujemna(z902) + '</P_122>' + nl)
		r = r + xmlNiePusty(z903, '    <P_123>' + TKwotaCNieujemna(z903) + '</P_123>' + nl)
		r = r + xmlNiePusty(z904, '    <P_124>' + TKwotaCNieujemna(z904) + '</P_124>' + nl)
		r = r + xmlNiePusty(z905, '    <P_125>' + TKwotaCNieujemna(z905) + '</P_125>' + nl)
		r = r + xmlNiePusty(z906, '    <P_126>' + TKwotaCNieujemna(z906) + '</P_126>' + nl)
		r = r + xmlNiePusty(z907, '    <P_127>' + TKwotaCNieujemna(z907) + '</P_127>' + nl)
		r = r + xmlNiePusty(z908, '    <P_128>' + TKwotaCNieujemna(z908) + '</P_128>' + nl)
		r = r + xmlNiePusty(z909, '    <P_129>' + TKwotaCNieujemna(z909) + '</P_129>' + nl)
		r = r + xmlNiePusty(z910, '    <P_130>' + TKwotaCNieujemna(z910) + '</P_130>' + nl)
		r = r + xmlNiePusty(z911, '    <P_131>' + TKwotaCNieujemna(z911) + '</P_131>' + nl)
		r = r + xmlNiePusty(z912, '    <P_132>' + TKwotaCNieujemna(z912) + '</P_132>' + nl)
		r = r + xmlNiePusty(z1101, '    <P_133>' + TKwotaCNieujemna(z1101) + '</P_133>' + nl)
		r = r + xmlNiePusty(z1102, '    <P_134>' + TKwotaCNieujemna(z1102) + '</P_134>' + nl)
		r = r + xmlNiePusty(z1103, '    <P_135>' + TKwotaCNieujemna(z1103) + '</P_135>' + nl)
		r = r + xmlNiePusty(z1104, '    <P_136>' + TKwotaCNieujemna(z1104) + '</P_136>' + nl)
		r = r + xmlNiePusty(z1105, '    <P_137>' + TKwotaCNieujemna(z1105) + '</P_137>' + nl)
		r = r + xmlNiePusty(z1106, '    <P_138>' + TKwotaCNieujemna(z1106) + '</P_138>' + nl)
		r = r + xmlNiePusty(z1107, '    <P_139>' + TKwotaCNieujemna(z1107) + '</P_139>' + nl)
		r = r + xmlNiePusty(z1108, '    <P_140>' + TKwotaCNieujemna(z1108) + '</P_140>' + nl)
		r = r + xmlNiePusty(z1109, '    <P_141>' + TKwotaCNieujemna(z1109) + '</P_141>' + nl)
		r = r + xmlNiePusty(z1110, '    <P_142>' + TKwotaCNieujemna(z1110) + '</P_142>' + nl)
		r = r + xmlNiePusty(z1111, '    <P_143>' + TKwotaCNieujemna(z1111) + '</P_143>' + nl)
		r = r + xmlNiePusty(z1112, '    <P_144>' + TKwotaCNieujemna(z1112) + '</P_144>' + nl)
		r = r + xmlNiePusty(z1201, '    <P_145>' + TKwotaCNieujemna(z1201) + '</P_145>' + nl)
		r = r + xmlNiePusty(z1202, '    <P_146>' + TKwotaCNieujemna(z1202) + '</P_146>' + nl)
		r = r + xmlNiePusty(z1203, '    <P_147>' + TKwotaCNieujemna(z1203) + '</P_147>' + nl)
		r = r + xmlNiePusty(z1204, '    <P_148>' + TKwotaCNieujemna(z1204) + '</P_148>' + nl)
		r = r + xmlNiePusty(z1205, '    <P_149>' + TKwotaCNieujemna(z1205) + '</P_149>' + nl)
		r = r + xmlNiePusty(z1206, '    <P_150>' + TKwotaCNieujemna(z1206) + '</P_150>' + nl)
		r = r + xmlNiePusty(z1207, '    <P_151>' + TKwotaCNieujemna(z1207) + '</P_151>' + nl)
		r = r + xmlNiePusty(z1208, '    <P_152>' + TKwotaCNieujemna(z1208) + '</P_152>' + nl)
		r = r + xmlNiePusty(z1209, '    <P_153>' + TKwotaCNieujemna(z1209) + '</P_153>' + nl)
		r = r + xmlNiePusty(z1210, '    <P_154>' + TKwotaCNieujemna(z1210) + '</P_154>' + nl)
		r = r + xmlNiePusty(z1211, '    <P_155>' + TKwotaCNieujemna(z1211) + '</P_155>' + nl)
		r = r + xmlNiePusty(z1212, '    <P_156>' + TKwotaCNieujemna(z1212) + '</P_156>' + nl)
		r = r + '    <P_157>' + TKwotaCNieujemna(z1301) + '</P_157>' + nl
		r = r + '    <P_158>' + TKwotaCNieujemna(z1302) + '</P_158>' + nl
		r = r + '    <P_159>' + TKwotaCNieujemna(z1303) + '</P_159>' + nl
		r = r + '    <P_160>' + TKwotaCNieujemna(z1304) + '</P_160>' + nl
		r = r + '    <P_161>' + TKwotaCNieujemna(z1305) + '</P_161>' + nl
		r = r + '    <P_162>' + TKwotaCNieujemna(z1306) + '</P_162>' + nl
		r = r + '    <P_163>' + TKwotaCNieujemna(z1307) + '</P_163>' + nl
		r = r + '    <P_164>' + TKwotaCNieujemna(z1308) + '</P_164>' + nl
		r = r + '    <P_165>' + TKwotaCNieujemna(z1309) + '</P_165>' + nl
		r = r + '    <P_166>' + TKwotaCNieujemna(z1310) + '</P_166>' + nl
		r = r + '    <P_167>' + TKwotaCNieujemna(z1311) + '</P_167>' + nl
		r = r + '    <P_168>' + TKwotaCNieujemna(z1312) + '</P_168>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwot z poz. od 157 do 168 lub wpˆacenia ich w niepeˆnej wysoko˜ci niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowi¥zkom pˆatnika grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
		r = r + '  <Objasnienie>' + str2sxml('Kwoty podatku i wynagrodzenia przysˆuguj¥cego pˆatnikom z tytuˆu terminowego wpˆacenia podatku dochodowego, zgodnie z art. 63 Ordynacji podatkowej, zaokr¥gla si© do peˆnych zˆotych.') + '</Objasnienie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit4r)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_pit4r) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit4r_8()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2018/12/06/6329/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-4R (8)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-4R</KodFormularza>' + nl
      r = r + '    <WariantFormularza>8</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
         r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(z1a01, '    <P_9>' + TNaturalny(z1a01) + '</P_9>' + nl)
		r = r + xmlNiePusty(z1a02, '    <P_10>' + TNaturalny(z1a02) + '</P_10>' + nl)
		r = r + xmlNiePusty(z1a03, '    <P_11>' + TNaturalny(z1a03) + '</P_11>' + nl)
		r = r + xmlNiePusty(z1a04, '    <P_12>' + TNaturalny(z1a04) + '</P_12>' + nl)
		r = r + xmlNiePusty(z1a05, '    <P_13>' + TNaturalny(z1a05) + '</P_13>' + nl)
		r = r + xmlNiePusty(z1a06, '    <P_14>' + TNaturalny(z1a06) + '</P_14>' + nl)
		r = r + xmlNiePusty(z1b01, '    <P_15>' + TKwotaCNieujemna(z1b01) + '</P_15>' + nl)
		r = r + xmlNiePusty(z1b02, '    <P_16>' + TKwotaCNieujemna(z1b02) + '</P_16>' + nl)
		r = r + xmlNiePusty(z1b03, '    <P_17>' + TKwotaCNieujemna(z1b03) + '</P_17>' + nl)
		r = r + xmlNiePusty(z1b04, '    <P_18>' + TKwotaCNieujemna(z1b04) + '</P_18>' + nl)
		r = r + xmlNiePusty(z1b05, '    <P_19>' + TKwotaCNieujemna(z1b05) + '</P_19>' + nl)
		r = r + xmlNiePusty(z1b06, '    <P_20>' + TKwotaCNieujemna(z1b06) + '</P_20>' + nl)
		r = r + xmlNiePusty(z1a07, '    <P_21>' + TNaturalny(z1a07) + '</P_21>' + nl)
		r = r + xmlNiePusty(z1a08, '    <P_22>' + TNaturalny(z1a08) + '</P_22>' + nl)
		r = r + xmlNiePusty(z1a09, '    <P_23>' + TNaturalny(z1a09) + '</P_23>' + nl)
		r = r + xmlNiePusty(z1a10, '    <P_24>' + TNaturalny(z1a10) + '</P_24>' + nl)
		r = r + xmlNiePusty(z1a11, '    <P_25>' + TNaturalny(z1a11) + '</P_25>' + nl)
		r = r + xmlNiePusty(z1a12, '    <P_26>' + TNaturalny(z1a12) + '</P_26>' + nl)
		r = r + xmlNiePusty(z1b07, '    <P_27>' + TKwotaCNieujemna(z1b07) + '</P_27>' + nl)
		r = r + xmlNiePusty(z1b08, '    <P_28>' + TKwotaCNieujemna(z1b08) + '</P_28>' + nl)
		r = r + xmlNiePusty(z1b09, '    <P_29>' + TKwotaCNieujemna(z1b09) + '</P_29>' + nl)
		r = r + xmlNiePusty(z1b10, '    <P_30>' + TKwotaCNieujemna(z1b10) + '</P_30>' + nl)
		r = r + xmlNiePusty(z1b11, '    <P_31>' + TKwotaCNieujemna(z1b11) + '</P_31>' + nl)
		r = r + xmlNiePusty(z1b12, '    <P_32>' + TKwotaCNieujemna(z1b12) + '</P_32>' + nl)
		r = r + xmlNiePusty(z201, '    <P_33>' + TKwotaCNieujemna(z201) + '</P_33>' + nl)
		r = r + xmlNiePusty(z202, '    <P_34>' + TKwotaCNieujemna(z202) + '</P_34>' + nl)
		r = r + xmlNiePusty(z203, '    <P_35>' + TKwotaCNieujemna(z203) + '</P_35>' + nl)
		r = r + xmlNiePusty(z204, '    <P_36>' + TKwotaCNieujemna(z204) + '</P_36>' + nl)
		r = r + xmlNiePusty(z205, '    <P_37>' + TKwotaCNieujemna(z205) + '</P_37>' + nl)
		r = r + xmlNiePusty(z206, '    <P_38>' + TKwotaCNieujemna(z206) + '</P_38>' + nl)
		r = r + xmlNiePusty(z207, '    <P_39>' + TKwotaCNieujemna(z207) + '</P_39>' + nl)
		r = r + xmlNiePusty(z208, '    <P_40>' + TKwotaCNieujemna(z208) + '</P_40>' + nl)
		r = r + xmlNiePusty(z209, '    <P_41>' + TKwotaCNieujemna(z209) + '</P_41>' + nl)
		r = r + xmlNiePusty(z210, '    <P_42>' + TKwotaCNieujemna(z210) + '</P_42>' + nl)
		r = r + xmlNiePusty(z211, '    <P_43>' + TKwotaCNieujemna(z211) + '</P_43>' + nl)
		r = r + xmlNiePusty(z212, '    <P_44>' + TKwotaCNieujemna(z212) + '</P_44>' + nl)
		r = r + xmlNiePusty(z1001, '    <P_45>' + TKwotaCNieujemna(z1001) + '</P_45>' + nl)
		r = r + xmlNiePusty(z1002, '    <P_46>' + TKwotaCNieujemna(z1002) + '</P_46>' + nl)
		r = r + xmlNiePusty(z1003, '    <P_47>' + TKwotaCNieujemna(z1003) + '</P_47>' + nl)
		r = r + xmlNiePusty(z1004, '    <P_48>' + TKwotaCNieujemna(z1004) + '</P_48>' + nl)
		r = r + xmlNiePusty(z1005, '    <P_49>' + TKwotaCNieujemna(z1005) + '</P_49>' + nl)
		r = r + xmlNiePusty(z1006, '    <P_50>' + TKwotaCNieujemna(z1006) + '</P_50>' + nl)
		r = r + xmlNiePusty(z1007, '    <P_51>' + TKwotaCNieujemna(z1007) + '</P_51>' + nl)
		r = r + xmlNiePusty(z1008, '    <P_52>' + TKwotaCNieujemna(z1008) + '</P_52>' + nl)
		r = r + xmlNiePusty(z1009, '    <P_53>' + TKwotaCNieujemna(z1009) + '</P_53>' + nl)
		r = r + xmlNiePusty(z1010, '    <P_54>' + TKwotaCNieujemna(z1010) + '</P_54>' + nl)
		r = r + xmlNiePusty(z1011, '    <P_55>' + TKwotaCNieujemna(z1011) + '</P_55>' + nl)
		r = r + xmlNiePusty(z1012, '    <P_56>' + TKwotaCNieujemna(z1012) + '</P_56>' + nl)
		r = r + xmlNiePusty(z901, '    <P_57>' + TKwotaCNieujemna(z901) + '</P_57>' + nl)
		r = r + xmlNiePusty(z902, '    <P_58>' + TKwotaCNieujemna(z902) + '</P_58>' + nl)
		r = r + xmlNiePusty(z903, '    <P_59>' + TKwotaCNieujemna(z903) + '</P_59>' + nl)
		r = r + xmlNiePusty(z904, '    <P_60>' + TKwotaCNieujemna(z904) + '</P_60>' + nl)
		r = r + xmlNiePusty(z905, '    <P_61>' + TKwotaCNieujemna(z905) + '</P_61>' + nl)
		r = r + xmlNiePusty(z906, '    <P_62>' + TKwotaCNieujemna(z906) + '</P_62>' + nl)
		r = r + xmlNiePusty(z907, '    <P_63>' + TKwotaCNieujemna(z907) + '</P_63>' + nl)
		r = r + xmlNiePusty(z908, '    <P_64>' + TKwotaCNieujemna(z908) + '</P_64>' + nl)
		r = r + xmlNiePusty(z909, '    <P_65>' + TKwotaCNieujemna(z909) + '</P_65>' + nl)
		r = r + xmlNiePusty(z910, '    <P_66>' + TKwotaCNieujemna(z910) + '</P_66>' + nl)
		r = r + xmlNiePusty(z911, '    <P_67>' + TKwotaCNieujemna(z911) + '</P_67>' + nl)
		r = r + xmlNiePusty(z912, '    <P_68>' + TKwotaCNieujemna(z912) + '</P_68>' + nl)
		r = r + xmlNiePusty(z301, '    <P_69>' + TKwotaCNieujemna(z301) + '</P_69>' + nl)
		r = r + xmlNiePusty(z302, '    <P_70>' + TKwotaCNieujemna(z302) + '</P_70>' + nl)
		r = r + xmlNiePusty(z303, '    <P_71>' + TKwotaCNieujemna(z303) + '</P_71>' + nl)
		r = r + xmlNiePusty(z304, '    <P_72>' + TKwotaCNieujemna(z304) + '</P_72>' + nl)
		r = r + xmlNiePusty(z305, '    <P_73>' + TKwotaCNieujemna(z305) + '</P_73>' + nl)
		r = r + xmlNiePusty(z306, '    <P_74>' + TKwotaCNieujemna(z306) + '</P_74>' + nl)
		r = r + xmlNiePusty(z307, '    <P_75>' + TKwotaCNieujemna(z307) + '</P_75>' + nl)
		r = r + xmlNiePusty(z308, '    <P_76>' + TKwotaCNieujemna(z308) + '</P_76>' + nl)
		r = r + xmlNiePusty(z309, '    <P_77>' + TKwotaCNieujemna(z309) + '</P_77>' + nl)
		r = r + xmlNiePusty(z310, '    <P_78>' + TKwotaCNieujemna(z310) + '</P_78>' + nl)
		r = r + xmlNiePusty(z311, '    <P_79>' + TKwotaCNieujemna(z311) + '</P_79>' + nl)
		r = r + xmlNiePusty(z312, '    <P_80>' + TKwotaCNieujemna(z312) + '</P_80>' + nl)
		r = r + xmlNiePusty(z401, '    <P_81>' + TKwotaCNieujemna(z401) + '</P_81>' + nl)
		r = r + xmlNiePusty(z402, '    <P_82>' + TKwotaCNieujemna(z402) + '</P_82>' + nl)
		r = r + xmlNiePusty(z403, '    <P_83>' + TKwotaCNieujemna(z403) + '</P_83>' + nl)
		r = r + xmlNiePusty(z404, '    <P_84>' + TKwotaCNieujemna(z404) + '</P_84>' + nl)
		r = r + xmlNiePusty(z405, '    <P_85>' + TKwotaCNieujemna(z405) + '</P_85>' + nl)
		r = r + xmlNiePusty(z406, '    <P_86>' + TKwotaCNieujemna(z406) + '</P_86>' + nl)
		r = r + xmlNiePusty(z407, '    <P_87>' + TKwotaCNieujemna(z407) + '</P_87>' + nl)
		r = r + xmlNiePusty(z408, '    <P_88>' + TKwotaCNieujemna(z408) + '</P_88>' + nl)
		r = r + xmlNiePusty(z409, '    <P_89>' + TKwotaCNieujemna(z409) + '</P_89>' + nl)
		r = r + xmlNiePusty(z410, '    <P_90>' + TKwotaCNieujemna(z410) + '</P_90>' + nl)
		r = r + xmlNiePusty(z411, '    <P_91>' + TKwotaCNieujemna(z411) + '</P_91>' + nl)
		r = r + xmlNiePusty(z412, '    <P_92>' + TKwotaCNieujemna(z412) + '</P_92>' + nl)
		r = r + xmlNiePusty(z501, '    <P_93>' + TKwotaCNieujemna(z501) + '</P_93>' + nl)
		r = r + xmlNiePusty(z502, '    <P_94>' + TKwotaCNieujemna(z502) + '</P_94>' + nl)
		r = r + xmlNiePusty(z503, '    <P_95>' + TKwotaCNieujemna(z503) + '</P_95>' + nl)
		r = r + xmlNiePusty(z504, '    <P_96>' + TKwotaCNieujemna(z504) + '</P_96>' + nl)
		r = r + xmlNiePusty(z505, '    <P_97>' + TKwotaCNieujemna(z505) + '</P_97>' + nl)
		r = r + xmlNiePusty(z506, '    <P_98>' + TKwotaCNieujemna(z506) + '</P_98>' + nl)
		r = r + xmlNiePusty(z507, '    <P_99>' + TKwotaCNieujemna(z507) + '</P_99>' + nl)
		r = r + xmlNiePusty(z508, '    <P_100>' + TKwotaCNieujemna(z508) + '</P_100>' + nl)
		r = r + xmlNiePusty(z509, '    <P_101>' + TKwotaCNieujemna(z509) + '</P_101>' + nl)
		r = r + xmlNiePusty(z510, '    <P_102>' + TKwotaCNieujemna(z510) + '</P_102>' + nl)
		r = r + xmlNiePusty(z511, '    <P_103>' + TKwotaCNieujemna(z511) + '</P_103>' + nl)
		r = r + xmlNiePusty(z512, '    <P_104>' + TKwotaCNieujemna(z512) + '</P_104>' + nl)
		r = r + xmlNiePusty(z601, '    <P_105>' + TKwotaCNieujemna(z601) + '</P_105>' + nl)
		r = r + xmlNiePusty(z602, '    <P_106>' + TKwotaCNieujemna(z602) + '</P_106>' + nl)
		r = r + xmlNiePusty(z603, '    <P_107>' + TKwotaCNieujemna(z603) + '</P_107>' + nl)
		r = r + xmlNiePusty(z604, '    <P_108>' + TKwotaCNieujemna(z604) + '</P_108>' + nl)
		r = r + xmlNiePusty(z701, '    <P_109>' + TKwotaCNieujemna(z701) + '</P_109>' + nl)
		r = r + xmlNiePusty(z702, '    <P_110>' + TKwotaCNieujemna(z702) + '</P_110>' + nl)
		r = r + xmlNiePusty(z703, '    <P_111>' + TKwotaCNieujemna(z703) + '</P_111>' + nl)
		r = r + xmlNiePusty(z704, '    <P_112>' + TKwotaCNieujemna(z704) + '</P_112>' + nl)
		r = r + xmlNiePusty(z705, '    <P_113>' + TKwotaCNieujemna(z705) + '</P_113>' + nl)
		r = r + xmlNiePusty(z706, '    <P_114>' + TKwotaCNieujemna(z706) + '</P_114>' + nl)
		r = r + xmlNiePusty(z707, '    <P_115>' + TKwotaCNieujemna(z707) + '</P_115>' + nl)
		r = r + xmlNiePusty(z708, '    <P_116>' + TKwotaCNieujemna(z708) + '</P_116>' + nl)
		r = r + xmlNiePusty(z709, '    <P_117>' + TKwotaCNieujemna(z709) + '</P_117>' + nl)
		r = r + xmlNiePusty(z710, '    <P_118>' + TKwotaCNieujemna(z710) + '</P_118>' + nl)
		r = r + xmlNiePusty(z711, '    <P_119>' + TKwotaCNieujemna(z711) + '</P_119>' + nl)
		r = r + xmlNiePusty(z712, '    <P_120>' + TKwotaCNieujemna(z712) + '</P_120>' + nl)
		r = r + xmlNiePusty(z801, '    <P_121>' + TKwotaCNieujemna(z801) + '</P_121>' + nl)
		r = r + xmlNiePusty(z802, '    <P_122>' + TKwotaCNieujemna(z802) + '</P_122>' + nl)
		r = r + xmlNiePusty(z803, '    <P_123>' + TKwotaCNieujemna(z803) + '</P_123>' + nl)
		r = r + xmlNiePusty(z804, '    <P_124>' + TKwotaCNieujemna(z804) + '</P_124>' + nl)
		r = r + xmlNiePusty(z805, '    <P_125>' + TKwotaCNieujemna(z805) + '</P_125>' + nl)
		r = r + xmlNiePusty(z806, '    <P_126>' + TKwotaCNieujemna(z806) + '</P_126>' + nl)
		r = r + xmlNiePusty(z807, '    <P_127>' + TKwotaCNieujemna(z807) + '</P_127>' + nl)
		r = r + xmlNiePusty(z808, '    <P_128>' + TKwotaCNieujemna(z808) + '</P_128>' + nl)
		r = r + xmlNiePusty(z809, '    <P_129>' + TKwotaCNieujemna(z809) + '</P_129>' + nl)
		r = r + xmlNiePusty(z810, '    <P_130>' + TKwotaCNieujemna(z810) + '</P_130>' + nl)
		r = r + xmlNiePusty(z811, '    <P_131>' + TKwotaCNieujemna(z811) + '</P_131>' + nl)
		r = r + xmlNiePusty(z812, '    <P_132>' + TKwotaCNieujemna(z812) + '</P_132>' + nl)
		r = r + xmlNiePusty(z1101, '    <P_133>' + TKwotaCNieujemna(z1101) + '</P_133>' + nl)
		r = r + xmlNiePusty(z1102, '    <P_134>' + TKwotaCNieujemna(z1102) + '</P_134>' + nl)
		r = r + xmlNiePusty(z1103, '    <P_135>' + TKwotaCNieujemna(z1103) + '</P_135>' + nl)
		r = r + xmlNiePusty(z1104, '    <P_136>' + TKwotaCNieujemna(z1104) + '</P_136>' + nl)
		r = r + xmlNiePusty(z1105, '    <P_137>' + TKwotaCNieujemna(z1105) + '</P_137>' + nl)
		r = r + xmlNiePusty(z1106, '    <P_138>' + TKwotaCNieujemna(z1106) + '</P_138>' + nl)
		r = r + xmlNiePusty(z1107, '    <P_139>' + TKwotaCNieujemna(z1107) + '</P_139>' + nl)
		r = r + xmlNiePusty(z1108, '    <P_140>' + TKwotaCNieujemna(z1108) + '</P_140>' + nl)
		r = r + xmlNiePusty(z1109, '    <P_141>' + TKwotaCNieujemna(z1109) + '</P_141>' + nl)
		r = r + xmlNiePusty(z1110, '    <P_142>' + TKwotaCNieujemna(z1110) + '</P_142>' + nl)
		r = r + xmlNiePusty(z1111, '    <P_143>' + TKwotaCNieujemna(z1111) + '</P_143>' + nl)
		r = r + xmlNiePusty(z1112, '    <P_144>' + TKwotaCNieujemna(z1112) + '</P_144>' + nl)
		r = r + xmlNiePusty(z1201, '    <P_145>' + TKwotaCNieujemna(z1201) + '</P_145>' + nl)
		r = r + xmlNiePusty(z1202, '    <P_146>' + TKwotaCNieujemna(z1202) + '</P_146>' + nl)
		r = r + xmlNiePusty(z1203, '    <P_147>' + TKwotaCNieujemna(z1203) + '</P_147>' + nl)
		r = r + xmlNiePusty(z1204, '    <P_148>' + TKwotaCNieujemna(z1204) + '</P_148>' + nl)
		r = r + xmlNiePusty(z1205, '    <P_149>' + TKwotaCNieujemna(z1205) + '</P_149>' + nl)
		r = r + xmlNiePusty(z1206, '    <P_150>' + TKwotaCNieujemna(z1206) + '</P_150>' + nl)
		r = r + xmlNiePusty(z1207, '    <P_151>' + TKwotaCNieujemna(z1207) + '</P_151>' + nl)
		r = r + xmlNiePusty(z1208, '    <P_152>' + TKwotaCNieujemna(z1208) + '</P_152>' + nl)
		r = r + xmlNiePusty(z1209, '    <P_153>' + TKwotaCNieujemna(z1209) + '</P_153>' + nl)
		r = r + xmlNiePusty(z1210, '    <P_154>' + TKwotaCNieujemna(z1210) + '</P_154>' + nl)
		r = r + xmlNiePusty(z1211, '    <P_155>' + TKwotaCNieujemna(z1211) + '</P_155>' + nl)
		r = r + xmlNiePusty(z1212, '    <P_156>' + TKwotaCNieujemna(z1212) + '</P_156>' + nl)
		r = r + '    <P_157>' + TKwotaCNieujemna(z1301) + '</P_157>' + nl
		r = r + '    <P_158>' + TKwotaCNieujemna(z1302) + '</P_158>' + nl
		r = r + '    <P_159>' + TKwotaCNieujemna(z1303) + '</P_159>' + nl
		r = r + '    <P_160>' + TKwotaCNieujemna(z1304) + '</P_160>' + nl
		r = r + '    <P_161>' + TKwotaCNieujemna(z1305) + '</P_161>' + nl
		r = r + '    <P_162>' + TKwotaCNieujemna(z1306) + '</P_162>' + nl
		r = r + '    <P_163>' + TKwotaCNieujemna(z1307) + '</P_163>' + nl
		r = r + '    <P_164>' + TKwotaCNieujemna(z1308) + '</P_164>' + nl
		r = r + '    <P_165>' + TKwotaCNieujemna(z1309) + '</P_165>' + nl
		r = r + '    <P_166>' + TKwotaCNieujemna(z1310) + '</P_166>' + nl
		r = r + '    <P_167>' + TKwotaCNieujemna(z1311) + '</P_167>' + nl
		r = r + '    <P_168>' + TKwotaCNieujemna(z1312) + '</P_168>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit4r)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v2(tresc_korekty_pit4r) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit4r_9()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2019/12/19/8975/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-4R (9)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-4R</KodFormularza>' + nl
      r = r + '    <WariantFormularza>9</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(P1) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</PelnaNazwa>' + nl
			//r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
         r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
      IF zDEKLKOR <> 'D'
         r = r + '    <P_7>' + iif(rodzaj_korekty == 2, '2', '1' ) + '</P_7>' + nl
      ENDIF
		r = r + xmlNiePusty(z1a01, '    <P_10>' + TNaturalny(z1a01) + '</P_10>' + nl)
		r = r + xmlNiePusty(z1a02, '    <P_11>' + TNaturalny(z1a02) + '</P_11>' + nl)
		r = r + xmlNiePusty(z1a03, '    <P_12>' + TNaturalny(z1a03) + '</P_12>' + nl)
		r = r + xmlNiePusty(z1a04, '    <P_13>' + TNaturalny(z1a04) + '</P_13>' + nl)
		r = r + xmlNiePusty(z1a05, '    <P_14>' + TNaturalny(z1a05) + '</P_14>' + nl)
		r = r + xmlNiePusty(z1a06, '    <P_15>' + TNaturalny(z1a06) + '</P_15>' + nl)
		r = r + xmlNiePusty(z1b01, '    <P_16>' + TKwotaCNieujemna(z1b01) + '</P_16>' + nl)
		r = r + xmlNiePusty(z1b02, '    <P_17>' + TKwotaCNieujemna(z1b02) + '</P_17>' + nl)
		r = r + xmlNiePusty(z1b03, '    <P_18>' + TKwotaCNieujemna(z1b03) + '</P_18>' + nl)
		r = r + xmlNiePusty(z1b04, '    <P_19>' + TKwotaCNieujemna(z1b04) + '</P_19>' + nl)
		r = r + xmlNiePusty(z1b05, '    <P_20>' + TKwotaCNieujemna(z1b05) + '</P_20>' + nl)
		r = r + xmlNiePusty(z1b06, '    <P_21>' + TKwotaCNieujemna(z1b06) + '</P_21>' + nl)
		r = r + xmlNiePusty(z1a07, '    <P_22>' + TNaturalny(z1a07) + '</P_22>' + nl)
		r = r + xmlNiePusty(z1a08, '    <P_23>' + TNaturalny(z1a08) + '</P_23>' + nl)
		r = r + xmlNiePusty(z1a09, '    <P_24>' + TNaturalny(z1a09) + '</P_24>' + nl)
		r = r + xmlNiePusty(z1a10, '    <P_25>' + TNaturalny(z1a10) + '</P_25>' + nl)
		r = r + xmlNiePusty(z1a11, '    <P_26>' + TNaturalny(z1a11) + '</P_26>' + nl)
		r = r + xmlNiePusty(z1a12, '    <P_27>' + TNaturalny(z1a12) + '</P_27>' + nl)
		r = r + xmlNiePusty(z1b07, '    <P_28>' + TKwotaCNieujemna(z1b07) + '</P_28>' + nl)
		r = r + xmlNiePusty(z1b08, '    <P_29>' + TKwotaCNieujemna(z1b08) + '</P_29>' + nl)
		r = r + xmlNiePusty(z1b09, '    <P_30>' + TKwotaCNieujemna(z1b09) + '</P_30>' + nl)
		r = r + xmlNiePusty(z1b10, '    <P_31>' + TKwotaCNieujemna(z1b10) + '</P_31>' + nl)
		r = r + xmlNiePusty(z1b11, '    <P_32>' + TKwotaCNieujemna(z1b11) + '</P_32>' + nl)
		r = r + xmlNiePusty(z1b12, '    <P_33>' + TKwotaCNieujemna(z1b12) + '</P_33>' + nl)
		r = r + xmlNiePusty(z201, '    <P_34>' + TKwotaCNieujemna(z201) + '</P_34>' + nl)
		r = r + xmlNiePusty(z202, '    <P_35>' + TKwotaCNieujemna(z202) + '</P_35>' + nl)
		r = r + xmlNiePusty(z203, '    <P_36>' + TKwotaCNieujemna(z203) + '</P_36>' + nl)
		r = r + xmlNiePusty(z204, '    <P_37>' + TKwotaCNieujemna(z204) + '</P_37>' + nl)
		r = r + xmlNiePusty(z205, '    <P_38>' + TKwotaCNieujemna(z205) + '</P_38>' + nl)
		r = r + xmlNiePusty(z206, '    <P_39>' + TKwotaCNieujemna(z206) + '</P_39>' + nl)
		r = r + xmlNiePusty(z207, '    <P_40>' + TKwotaCNieujemna(z207) + '</P_40>' + nl)
		r = r + xmlNiePusty(z208, '    <P_41>' + TKwotaCNieujemna(z208) + '</P_41>' + nl)
		r = r + xmlNiePusty(z209, '    <P_42>' + TKwotaCNieujemna(z209) + '</P_42>' + nl)
		r = r + xmlNiePusty(z210, '    <P_43>' + TKwotaCNieujemna(z210) + '</P_43>' + nl)
		r = r + xmlNiePusty(z211, '    <P_44>' + TKwotaCNieujemna(z211) + '</P_44>' + nl)
		r = r + xmlNiePusty(z212, '    <P_45>' + TKwotaCNieujemna(z212) + '</P_45>' + nl)
		r = r + xmlNiePusty(z1001, '    <P_46>' + TKwotaCNieujemna(z1001) + '</P_46>' + nl)
		r = r + xmlNiePusty(z1002, '    <P_47>' + TKwotaCNieujemna(z1002) + '</P_47>' + nl)
		r = r + xmlNiePusty(z1003, '    <P_48>' + TKwotaCNieujemna(z1003) + '</P_48>' + nl)
		r = r + xmlNiePusty(z1004, '    <P_49>' + TKwotaCNieujemna(z1004) + '</P_49>' + nl)
		r = r + xmlNiePusty(z1005, '    <P_50>' + TKwotaCNieujemna(z1005) + '</P_50>' + nl)
		r = r + xmlNiePusty(z1006, '    <P_51>' + TKwotaCNieujemna(z1006) + '</P_51>' + nl)
		r = r + xmlNiePusty(z1007, '    <P_52>' + TKwotaCNieujemna(z1007) + '</P_52>' + nl)
		r = r + xmlNiePusty(z1008, '    <P_53>' + TKwotaCNieujemna(z1008) + '</P_53>' + nl)
		r = r + xmlNiePusty(z1009, '    <P_54>' + TKwotaCNieujemna(z1009) + '</P_54>' + nl)
		r = r + xmlNiePusty(z1010, '    <P_55>' + TKwotaCNieujemna(z1010) + '</P_55>' + nl)
		r = r + xmlNiePusty(z1011, '    <P_56>' + TKwotaCNieujemna(z1011) + '</P_56>' + nl)
		r = r + xmlNiePusty(z1012, '    <P_57>' + TKwotaCNieujemna(z1012) + '</P_57>' + nl)
		r = r + xmlNiePusty(z901, '    <P_58>' + TKwotaCNieujemna(z901) + '</P_58>' + nl)
		r = r + xmlNiePusty(z902, '    <P_59>' + TKwotaCNieujemna(z902) + '</P_59>' + nl)
		r = r + xmlNiePusty(z903, '    <P_60>' + TKwotaCNieujemna(z903) + '</P_60>' + nl)
		r = r + xmlNiePusty(z904, '    <P_61>' + TKwotaCNieujemna(z904) + '</P_61>' + nl)
		r = r + xmlNiePusty(z905, '    <P_62>' + TKwotaCNieujemna(z905) + '</P_62>' + nl)
		r = r + xmlNiePusty(z906, '    <P_63>' + TKwotaCNieujemna(z906) + '</P_63>' + nl)
		r = r + xmlNiePusty(z907, '    <P_64>' + TKwotaCNieujemna(z907) + '</P_64>' + nl)
		r = r + xmlNiePusty(z908, '    <P_65>' + TKwotaCNieujemna(z908) + '</P_65>' + nl)
		r = r + xmlNiePusty(z909, '    <P_66>' + TKwotaCNieujemna(z909) + '</P_66>' + nl)
		r = r + xmlNiePusty(z910, '    <P_67>' + TKwotaCNieujemna(z910) + '</P_67>' + nl)
		r = r + xmlNiePusty(z911, '    <P_68>' + TKwotaCNieujemna(z911) + '</P_68>' + nl)
		r = r + xmlNiePusty(z912, '    <P_69>' + TKwotaCNieujemna(z912) + '</P_69>' + nl)
		r = r + xmlNiePusty(z301, '    <P_70>' + TKwotaCNieujemna(z301) + '</P_70>' + nl)
		r = r + xmlNiePusty(z302, '    <P_71>' + TKwotaCNieujemna(z302) + '</P_71>' + nl)
		r = r + xmlNiePusty(z303, '    <P_72>' + TKwotaCNieujemna(z303) + '</P_72>' + nl)
		r = r + xmlNiePusty(z304, '    <P_73>' + TKwotaCNieujemna(z304) + '</P_73>' + nl)
		r = r + xmlNiePusty(z305, '    <P_74>' + TKwotaCNieujemna(z305) + '</P_74>' + nl)
		r = r + xmlNiePusty(z306, '    <P_75>' + TKwotaCNieujemna(z306) + '</P_75>' + nl)
		r = r + xmlNiePusty(z307, '    <P_76>' + TKwotaCNieujemna(z307) + '</P_76>' + nl)
		r = r + xmlNiePusty(z308, '    <P_77>' + TKwotaCNieujemna(z308) + '</P_77>' + nl)
		r = r + xmlNiePusty(z309, '    <P_78>' + TKwotaCNieujemna(z309) + '</P_78>' + nl)
		r = r + xmlNiePusty(z310, '    <P_79>' + TKwotaCNieujemna(z310) + '</P_79>' + nl)
		r = r + xmlNiePusty(z311, '    <P_80>' + TKwotaCNieujemna(z311) + '</P_80>' + nl)
		r = r + xmlNiePusty(z312, '    <P_81>' + TKwotaCNieujemna(z312) + '</P_81>' + nl)
		r = r + xmlNiePusty(z401, '    <P_82>' + TKwotaCNieujemna(z401) + '</P_82>' + nl)
		r = r + xmlNiePusty(z402, '    <P_83>' + TKwotaCNieujemna(z402) + '</P_83>' + nl)
		r = r + xmlNiePusty(z403, '    <P_84>' + TKwotaCNieujemna(z403) + '</P_84>' + nl)
		r = r + xmlNiePusty(z404, '    <P_85>' + TKwotaCNieujemna(z404) + '</P_85>' + nl)
		r = r + xmlNiePusty(z405, '    <P_86>' + TKwotaCNieujemna(z405) + '</P_86>' + nl)
		r = r + xmlNiePusty(z406, '    <P_87>' + TKwotaCNieujemna(z406) + '</P_87>' + nl)
		r = r + xmlNiePusty(z407, '    <P_88>' + TKwotaCNieujemna(z407) + '</P_88>' + nl)
		r = r + xmlNiePusty(z408, '    <P_89>' + TKwotaCNieujemna(z408) + '</P_89>' + nl)
		r = r + xmlNiePusty(z409, '    <P_90>' + TKwotaCNieujemna(z409) + '</P_90>' + nl)
		r = r + xmlNiePusty(z410, '    <P_91>' + TKwotaCNieujemna(z410) + '</P_91>' + nl)
		r = r + xmlNiePusty(z411, '    <P_92>' + TKwotaCNieujemna(z411) + '</P_92>' + nl)
		r = r + xmlNiePusty(z412, '    <P_93>' + TKwotaCNieujemna(z412) + '</P_93>' + nl)
		r = r + xmlNiePusty(z501, '    <P_94>' + TKwotaCNieujemna(z501) + '</P_94>' + nl)
		r = r + xmlNiePusty(z502, '    <P_95>' + TKwotaCNieujemna(z502) + '</P_95>' + nl)
		r = r + xmlNiePusty(z503, '    <P_96>' + TKwotaCNieujemna(z503) + '</P_96>' + nl)
		r = r + xmlNiePusty(z504, '    <P_97>' + TKwotaCNieujemna(z504) + '</P_97>' + nl)
		r = r + xmlNiePusty(z505, '    <P_98>' + TKwotaCNieujemna(z505) + '</P_98>' + nl)
		r = r + xmlNiePusty(z506, '    <P_99>' + TKwotaCNieujemna(z506) + '</P_99>' + nl)
		r = r + xmlNiePusty(z507, '    <P_100>' + TKwotaCNieujemna(z507) + '</P_100>' + nl)
		r = r + xmlNiePusty(z508, '    <P_101>' + TKwotaCNieujemna(z508) + '</P_101>' + nl)
		r = r + xmlNiePusty(z509, '    <P_102>' + TKwotaCNieujemna(z509) + '</P_102>' + nl)
		r = r + xmlNiePusty(z510, '    <P_103>' + TKwotaCNieujemna(z510) + '</P_103>' + nl)
		r = r + xmlNiePusty(z511, '    <P_104>' + TKwotaCNieujemna(z511) + '</P_104>' + nl)
		r = r + xmlNiePusty(z512, '    <P_105>' + TKwotaCNieujemna(z512) + '</P_105>' + nl)
		r = r + xmlNiePusty(z601, '    <P_106>' + TKwotaCNieujemna(z601) + '</P_106>' + nl)
		r = r + xmlNiePusty(z602, '    <P_107>' + TKwotaCNieujemna(z602) + '</P_107>' + nl)
		r = r + xmlNiePusty(z603, '    <P_108>' + TKwotaCNieujemna(z603) + '</P_108>' + nl)
		r = r + xmlNiePusty(z604, '    <P_109>' + TKwotaCNieujemna(z604) + '</P_109>' + nl)
		r = r + xmlNiePusty(z701, '    <P_110>' + TKwotaCNieujemna(z701) + '</P_110>' + nl)
		r = r + xmlNiePusty(z702, '    <P_111>' + TKwotaCNieujemna(z702) + '</P_111>' + nl)
		r = r + xmlNiePusty(z703, '    <P_112>' + TKwotaCNieujemna(z703) + '</P_112>' + nl)
		r = r + xmlNiePusty(z704, '    <P_113>' + TKwotaCNieujemna(z704) + '</P_113>' + nl)
		r = r + xmlNiePusty(z705, '    <P_114>' + TKwotaCNieujemna(z705) + '</P_114>' + nl)
		r = r + xmlNiePusty(z706, '    <P_115>' + TKwotaCNieujemna(z706) + '</P_115>' + nl)
		r = r + xmlNiePusty(z707, '    <P_116>' + TKwotaCNieujemna(z707) + '</P_116>' + nl)
		r = r + xmlNiePusty(z708, '    <P_117>' + TKwotaCNieujemna(z708) + '</P_117>' + nl)
		r = r + xmlNiePusty(z709, '    <P_118>' + TKwotaCNieujemna(z709) + '</P_118>' + nl)
		r = r + xmlNiePusty(z710, '    <P_119>' + TKwotaCNieujemna(z710) + '</P_119>' + nl)
		r = r + xmlNiePusty(z711, '    <P_120>' + TKwotaCNieujemna(z711) + '</P_120>' + nl)
		r = r + xmlNiePusty(z712, '    <P_121>' + TKwotaCNieujemna(z712) + '</P_121>' + nl)
		r = r + xmlNiePusty(z801, '    <P_122>' + TKwotaCNieujemna(z801) + '</P_122>' + nl)
		r = r + xmlNiePusty(z802, '    <P_123>' + TKwotaCNieujemna(z802) + '</P_123>' + nl)
		r = r + xmlNiePusty(z803, '    <P_124>' + TKwotaCNieujemna(z803) + '</P_124>' + nl)
		r = r + xmlNiePusty(z804, '    <P_125>' + TKwotaCNieujemna(z804) + '</P_125>' + nl)
		r = r + xmlNiePusty(z805, '    <P_126>' + TKwotaCNieujemna(z805) + '</P_126>' + nl)
		r = r + xmlNiePusty(z806, '    <P_127>' + TKwotaCNieujemna(z806) + '</P_127>' + nl)
		r = r + xmlNiePusty(z807, '    <P_128>' + TKwotaCNieujemna(z807) + '</P_128>' + nl)
		r = r + xmlNiePusty(z808, '    <P_129>' + TKwotaCNieujemna(z808) + '</P_129>' + nl)
		r = r + xmlNiePusty(z809, '    <P_130>' + TKwotaCNieujemna(z809) + '</P_130>' + nl)
		r = r + xmlNiePusty(z810, '    <P_131>' + TKwotaCNieujemna(z810) + '</P_131>' + nl)
		r = r + xmlNiePusty(z811, '    <P_132>' + TKwotaCNieujemna(z811) + '</P_132>' + nl)
		r = r + xmlNiePusty(z812, '    <P_133>' + TKwotaCNieujemna(z812) + '</P_133>' + nl)
		r = r + xmlNiePusty(z1101, '    <P_134>' + TKwotaCNieujemna(z1101) + '</P_134>' + nl)
		r = r + xmlNiePusty(z1102, '    <P_135>' + TKwotaCNieujemna(z1102) + '</P_135>' + nl)
		r = r + xmlNiePusty(z1103, '    <P_136>' + TKwotaCNieujemna(z1103) + '</P_136>' + nl)
		r = r + xmlNiePusty(z1104, '    <P_137>' + TKwotaCNieujemna(z1104) + '</P_137>' + nl)
		r = r + xmlNiePusty(z1105, '    <P_138>' + TKwotaCNieujemna(z1105) + '</P_138>' + nl)
		r = r + xmlNiePusty(z1106, '    <P_139>' + TKwotaCNieujemna(z1106) + '</P_139>' + nl)
		r = r + xmlNiePusty(z1107, '    <P_140>' + TKwotaCNieujemna(z1107) + '</P_140>' + nl)
		r = r + xmlNiePusty(z1108, '    <P_141>' + TKwotaCNieujemna(z1108) + '</P_141>' + nl)
		r = r + xmlNiePusty(z1109, '    <P_142>' + TKwotaCNieujemna(z1109) + '</P_142>' + nl)
		r = r + xmlNiePusty(z1110, '    <P_143>' + TKwotaCNieujemna(z1110) + '</P_143>' + nl)
		r = r + xmlNiePusty(z1111, '    <P_144>' + TKwotaCNieujemna(z1111) + '</P_144>' + nl)
		r = r + xmlNiePusty(z1112, '    <P_145>' + TKwotaCNieujemna(z1112) + '</P_145>' + nl)
		r = r + xmlNiePusty(z1201, '    <P_146>' + TKwotaCNieujemna(z1201) + '</P_146>' + nl)
		r = r + xmlNiePusty(z1202, '    <P_147>' + TKwotaCNieujemna(z1202) + '</P_147>' + nl)
		r = r + xmlNiePusty(z1203, '    <P_148>' + TKwotaCNieujemna(z1203) + '</P_148>' + nl)
		r = r + xmlNiePusty(z1204, '    <P_149>' + TKwotaCNieujemna(z1204) + '</P_149>' + nl)
		r = r + xmlNiePusty(z1205, '    <P_150>' + TKwotaCNieujemna(z1205) + '</P_150>' + nl)
		r = r + xmlNiePusty(z1206, '    <P_151>' + TKwotaCNieujemna(z1206) + '</P_151>' + nl)
		r = r + xmlNiePusty(z1207, '    <P_152>' + TKwotaCNieujemna(z1207) + '</P_152>' + nl)
		r = r + xmlNiePusty(z1208, '    <P_153>' + TKwotaCNieujemna(z1208) + '</P_153>' + nl)
		r = r + xmlNiePusty(z1209, '    <P_154>' + TKwotaCNieujemna(z1209) + '</P_154>' + nl)
		r = r + xmlNiePusty(z1210, '    <P_155>' + TKwotaCNieujemna(z1210) + '</P_155>' + nl)
		r = r + xmlNiePusty(z1211, '    <P_156>' + TKwotaCNieujemna(z1211) + '</P_156>' + nl)
		r = r + xmlNiePusty(z1212, '    <P_157>' + TKwotaCNieujemna(z1212) + '</P_157>' + nl)
		r = r + '    <P_158>' + TKwotaCNieujemna(z1301) + '</P_158>' + nl
		r = r + '    <P_159>' + TKwotaCNieujemna(z1302) + '</P_159>' + nl
		r = r + '    <P_160>' + TKwotaCNieujemna(z1303) + '</P_160>' + nl
		r = r + '    <P_161>' + TKwotaCNieujemna(z1304) + '</P_161>' + nl
		r = r + '    <P_162>' + TKwotaCNieujemna(z1305) + '</P_162>' + nl
		r = r + '    <P_163>' + TKwotaCNieujemna(z1306) + '</P_163>' + nl
		r = r + '    <P_164>' + TKwotaCNieujemna(z1307) + '</P_164>' + nl
		r = r + '    <P_165>' + TKwotaCNieujemna(z1308) + '</P_165>' + nl
		r = r + '    <P_166>' + TKwotaCNieujemna(z1309) + '</P_166>' + nl
		r = r + '    <P_167>' + TKwotaCNieujemna(z1310) + '</P_167>' + nl
		r = r + '    <P_168>' + TKwotaCNieujemna(z1311) + '</P_168>' + nl
		r = r + '    <P_169>' + TKwotaCNieujemna(z1312) + '</P_169>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit4r)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v2(tresc_korekty_pit4r) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_4()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2014/12/08/1882/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (4)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>4</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
         r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_153>' + TKwotaCNieujemna(z201) + '</P_153>' + nl
		r = r + '    <P_154>' + TKwotaCNieujemna(z202) + '</P_154>' + nl
		r = r + '    <P_155>' + TKwotaCNieujemna(z203) + '</P_155>' + nl
		r = r + '    <P_156>' + TKwotaCNieujemna(z204) + '</P_156>' + nl
		r = r + '    <P_157>' + TKwotaCNieujemna(z205) + '</P_157>' + nl
		r = r + '    <P_158>' + TKwotaCNieujemna(z206) + '</P_158>' + nl
		r = r + '    <P_159>' + TKwotaCNieujemna(z207) + '</P_159>' + nl
		r = r + '    <P_160>' + TKwotaCNieujemna(z208) + '</P_160>' + nl
		r = r + '    <P_161>' + TKwotaCNieujemna(z209) + '</P_161>' + nl
		r = r + '    <P_162>' + TKwotaCNieujemna(z210) + '</P_162>' + nl
		r = r + '    <P_163>' + TKwotaCNieujemna(z211) + '</P_163>' + nl
		r = r + '    <P_164>' + TKwotaCNieujemna(z212) + '</P_164>' + nl
		r = r + '    <P_165>' + TKwota2Nieujemna(z301) + '</P_165>' + nl
		r = r + '    <P_166>' + TKwota2Nieujemna(z302) + '</P_166>' + nl
		r = r + '    <P_167>' + TKwota2Nieujemna(z303) + '</P_167>' + nl
		r = r + '    <P_168>' + TKwota2Nieujemna(z304) + '</P_168>' + nl
		r = r + '    <P_169>' + TKwota2Nieujemna(z305) + '</P_169>' + nl
		r = r + '    <P_170>' + TKwota2Nieujemna(z306) + '</P_170>' + nl
		r = r + '    <P_171>' + TKwota2Nieujemna(z307) + '</P_171>' + nl
		r = r + '    <P_172>' + TKwota2Nieujemna(z308) + '</P_172>' + nl
		r = r + '    <P_173>' + TKwota2Nieujemna(z309) + '</P_173>' + nl
		r = r + '    <P_174>' + TKwota2Nieujemna(z310) + '</P_174>' + nl
		r = r + '    <P_175>' + TKwota2Nieujemna(z311) + '</P_175>' + nl
		r = r + '    <P_176>' + TKwota2Nieujemna(z312) + '</P_176>' + nl
		r = r + '    <P_177>' + TKwotaCNieujemna(z401) + '</P_177>' + nl
		r = r + '    <P_178>' + TKwotaCNieujemna(z402) + '</P_178>' + nl
		r = r + '    <P_179>' + TKwotaCNieujemna(z403) + '</P_179>' + nl
		r = r + '    <P_180>' + TKwotaCNieujemna(z404) + '</P_180>' + nl
		r = r + '    <P_181>' + TKwotaCNieujemna(z405) + '</P_181>' + nl
		r = r + '    <P_182>' + TKwotaCNieujemna(z406) + '</P_182>' + nl
		r = r + '    <P_183>' + TKwotaCNieujemna(z407) + '</P_183>' + nl
		r = r + '    <P_184>' + TKwotaCNieujemna(z408) + '</P_184>' + nl
		r = r + '    <P_185>' + TKwotaCNieujemna(z409) + '</P_185>' + nl
		r = r + '    <P_186>' + TKwotaCNieujemna(z410) + '</P_186>' + nl
		r = r + '    <P_187>' + TKwotaCNieujemna(z411) + '</P_187>' + nl
		r = r + '    <P_188>' + TKwotaCNieujemna(z412) + '</P_188>' + nl
		r = r + '    <P_189>' + TKwota2Nieujemna(z501) + '</P_189>' + nl
		r = r + '    <P_190>' + TKwota2Nieujemna(z502) + '</P_190>' + nl
		r = r + '    <P_191>' + TKwota2Nieujemna(z503) + '</P_191>' + nl
		r = r + '    <P_192>' + TKwota2Nieujemna(z504) + '</P_192>' + nl
		r = r + '    <P_193>' + TKwota2Nieujemna(z505) + '</P_193>' + nl
		r = r + '    <P_194>' + TKwota2Nieujemna(z506) + '</P_194>' + nl
		r = r + '    <P_195>' + TKwota2Nieujemna(z507) + '</P_195>' + nl
		r = r + '    <P_196>' + TKwota2Nieujemna(z508) + '</P_196>' + nl
		r = r + '    <P_197>' + TKwota2Nieujemna(z509) + '</P_197>' + nl
		r = r + '    <P_198>' + TKwota2Nieujemna(z510) + '</P_198>' + nl
		r = r + '    <P_199>' + TKwota2Nieujemna(z511) + '</P_199>' + nl
		r = r + '    <P_200>' + TKwota2Nieujemna(z512) + '</P_200>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwot z poz. od 189 do 200 lub wpˆacenia ich w niepeˆnej wysoko˜ci niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2012 r. poz. 1015, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowi¥zkom pˆatnika grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_5()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2015/01/20/2009/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (5)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>5</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
         r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_165>' + TKwotaCNieujemna(z201) + '</P_165>' + nl
		r = r + '    <P_166>' + TKwotaCNieujemna(z202) + '</P_166>' + nl
		r = r + '    <P_167>' + TKwotaCNieujemna(z203) + '</P_167>' + nl
		r = r + '    <P_168>' + TKwotaCNieujemna(z204) + '</P_168>' + nl
		r = r + '    <P_169>' + TKwotaCNieujemna(z205) + '</P_169>' + nl
		r = r + '    <P_170>' + TKwotaCNieujemna(z206) + '</P_170>' + nl
		r = r + '    <P_171>' + TKwotaCNieujemna(z207) + '</P_171>' + nl
		r = r + '    <P_172>' + TKwotaCNieujemna(z208) + '</P_172>' + nl
		r = r + '    <P_173>' + TKwotaCNieujemna(z209) + '</P_173>' + nl
		r = r + '    <P_174>' + TKwotaCNieujemna(z210) + '</P_174>' + nl
		r = r + '    <P_175>' + TKwotaCNieujemna(z211) + '</P_175>' + nl
		r = r + '    <P_176>' + TKwotaCNieujemna(z212) + '</P_176>' + nl
		r = r + '    <P_177>' + TKwota2Nieujemna(z301) + '</P_177>' + nl
		r = r + '    <P_178>' + TKwota2Nieujemna(z302) + '</P_178>' + nl
		r = r + '    <P_179>' + TKwota2Nieujemna(z303) + '</P_179>' + nl
		r = r + '    <P_180>' + TKwota2Nieujemna(z304) + '</P_180>' + nl
		r = r + '    <P_181>' + TKwota2Nieujemna(z305) + '</P_181>' + nl
		r = r + '    <P_182>' + TKwota2Nieujemna(z306) + '</P_182>' + nl
		r = r + '    <P_183>' + TKwota2Nieujemna(z307) + '</P_183>' + nl
		r = r + '    <P_184>' + TKwota2Nieujemna(z308) + '</P_184>' + nl
		r = r + '    <P_185>' + TKwota2Nieujemna(z309) + '</P_185>' + nl
		r = r + '    <P_186>' + TKwota2Nieujemna(z310) + '</P_186>' + nl
		r = r + '    <P_187>' + TKwota2Nieujemna(z311) + '</P_187>' + nl
		r = r + '    <P_188>' + TKwota2Nieujemna(z312) + '</P_188>' + nl
		r = r + '    <P_189>' + TKwotaCNieujemna(z401) + '</P_189>' + nl
		r = r + '    <P_190>' + TKwotaCNieujemna(z402) + '</P_190>' + nl
		r = r + '    <P_191>' + TKwotaCNieujemna(z403) + '</P_191>' + nl
		r = r + '    <P_192>' + TKwotaCNieujemna(z404) + '</P_192>' + nl
		r = r + '    <P_193>' + TKwotaCNieujemna(z405) + '</P_193>' + nl
		r = r + '    <P_194>' + TKwotaCNieujemna(z406) + '</P_194>' + nl
		r = r + '    <P_195>' + TKwotaCNieujemna(z407) + '</P_195>' + nl
		r = r + '    <P_196>' + TKwotaCNieujemna(z408) + '</P_196>' + nl
		r = r + '    <P_197>' + TKwotaCNieujemna(z409) + '</P_197>' + nl
		r = r + '    <P_198>' + TKwotaCNieujemna(z410) + '</P_198>' + nl
		r = r + '    <P_199>' + TKwotaCNieujemna(z411) + '</P_199>' + nl
		r = r + '    <P_200>' + TKwotaCNieujemna(z412) + '</P_200>' + nl
		r = r + '    <P_201>' + TKwota2Nieujemna(z501) + '</P_201>' + nl
		r = r + '    <P_202>' + TKwota2Nieujemna(z502) + '</P_202>' + nl
		r = r + '    <P_203>' + TKwota2Nieujemna(z503) + '</P_203>' + nl
		r = r + '    <P_204>' + TKwota2Nieujemna(z504) + '</P_204>' + nl
		r = r + '    <P_205>' + TKwota2Nieujemna(z505) + '</P_205>' + nl
		r = r + '    <P_206>' + TKwota2Nieujemna(z506) + '</P_206>' + nl
		r = r + '    <P_207>' + TKwota2Nieujemna(z507) + '</P_207>' + nl
		r = r + '    <P_208>' + TKwota2Nieujemna(z508) + '</P_208>' + nl
		r = r + '    <P_209>' + TKwota2Nieujemna(z509) + '</P_209>' + nl
		r = r + '    <P_210>' + TKwota2Nieujemna(z510) + '</P_210>' + nl
		r = r + '    <P_211>' + TKwota2Nieujemna(z511) + '</P_211>' + nl
		r = r + '    <P_212>' + TKwota2Nieujemna(z512) + '</P_212>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwot z poz. od 189 do 200 lub wpˆacenia ich w niepeˆnej wysoko˜ci niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2012 r. poz. 1015, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowi¥zkom pˆatnika grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_6()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2015/12/21/3014/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (6)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>6</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
         r = r + '      <NIP>' + trimnip(P1) + '</NIP>' + nl
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P8d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(z601, '    <P_69>' + TKwotaCNieujemna(z601) + '</P_69>' + nl)
		r = r + xmlNiePusty(z602, '    <P_70>' + TKwotaCNieujemna(z602) + '</P_70>' + nl)
		r = r + xmlNiePusty(z603, '    <P_71>' + TKwotaCNieujemna(z603) + '</P_71>' + nl)
		r = r + xmlNiePusty(z604, '    <P_72>' + TKwotaCNieujemna(z604) + '</P_72>' + nl)
		r = r + xmlNiePusty(z605, '    <P_73>' + TKwotaCNieujemna(z605) + '</P_73>' + nl)
		r = r + xmlNiePusty(z606, '    <P_74>' + TKwotaCNieujemna(z606) + '</P_74>' + nl)
		r = r + xmlNiePusty(z607, '    <P_75>' + TKwotaCNieujemna(z607) + '</P_75>' + nl)
		r = r + xmlNiePusty(z608, '    <P_76>' + TKwotaCNieujemna(z608) + '</P_76>' + nl)
		r = r + xmlNiePusty(z609, '    <P_77>' + TKwotaCNieujemna(z609) + '</P_77>' + nl)
		r = r + xmlNiePusty(z610, '    <P_78>' + TKwotaCNieujemna(z610) + '</P_78>' + nl)
		r = r + xmlNiePusty(z611, '    <P_79>' + TKwotaCNieujemna(z611) + '</P_79>' + nl)
		r = r + xmlNiePusty(z612, '    <P_80>' + TKwotaCNieujemna(z612) + '</P_80>' + nl)
		r = r + xmlNiePusty(z201, '    <P_165>' + TKwotaCNieujemna(z201) + '</P_165>' + nl)
		r = r + xmlNiePusty(z202, '    <P_166>' + TKwotaCNieujemna(z202) + '</P_166>' + nl)
		r = r + xmlNiePusty(z203, '    <P_167>' + TKwotaCNieujemna(z203) + '</P_167>' + nl)
		r = r + xmlNiePusty(z204, '    <P_168>' + TKwotaCNieujemna(z204) + '</P_168>' + nl)
		r = r + xmlNiePusty(z205, '    <P_169>' + TKwotaCNieujemna(z205) + '</P_169>' + nl)
		r = r + xmlNiePusty(z206, '    <P_170>' + TKwotaCNieujemna(z206) + '</P_170>' + nl)
		r = r + xmlNiePusty(z207, '    <P_171>' + TKwotaCNieujemna(z207) + '</P_171>' + nl)
		r = r + xmlNiePusty(z208, '    <P_172>' + TKwotaCNieujemna(z208) + '</P_172>' + nl)
		r = r + xmlNiePusty(z209, '    <P_173>' + TKwotaCNieujemna(z209) + '</P_173>' + nl)
		r = r + xmlNiePusty(z210, '    <P_174>' + TKwotaCNieujemna(z210) + '</P_174>' + nl)
		r = r + xmlNiePusty(z211, '    <P_175>' + TKwotaCNieujemna(z211) + '</P_175>' + nl)
		r = r + xmlNiePusty(z212, '    <P_176>' + TKwotaCNieujemna(z212) + '</P_176>' + nl)
		r = r + xmlNiePusty(z301, '    <P_177>' + TKwota2Nieujemna(z301) + '</P_177>' + nl)
		r = r + xmlNiePusty(z302, '    <P_178>' + TKwota2Nieujemna(z302) + '</P_178>' + nl)
		r = r + xmlNiePusty(z303, '    <P_179>' + TKwota2Nieujemna(z303) + '</P_179>' + nl)
		r = r + xmlNiePusty(z304, '    <P_180>' + TKwota2Nieujemna(z304) + '</P_180>' + nl)
		r = r + xmlNiePusty(z305, '    <P_181>' + TKwota2Nieujemna(z305) + '</P_181>' + nl)
		r = r + xmlNiePusty(z306, '    <P_182>' + TKwota2Nieujemna(z306) + '</P_182>' + nl)
		r = r + xmlNiePusty(z307, '    <P_183>' + TKwota2Nieujemna(z307) + '</P_183>' + nl)
		r = r + xmlNiePusty(z308, '    <P_184>' + TKwota2Nieujemna(z308) + '</P_184>' + nl)
		r = r + xmlNiePusty(z309, '    <P_185>' + TKwota2Nieujemna(z309) + '</P_185>' + nl)
		r = r + xmlNiePusty(z310, '    <P_186>' + TKwota2Nieujemna(z310) + '</P_186>' + nl)
		r = r + xmlNiePusty(z311, '    <P_187>' + TKwota2Nieujemna(z311) + '</P_187>' + nl)
		r = r + xmlNiePusty(z312, '    <P_188>' + TKwota2Nieujemna(z312) + '</P_188>' + nl)
		r = r + xmlNiePusty(z401, '    <P_189>' + TKwotaCNieujemna(z401) + '</P_189>' + nl)
		r = r + xmlNiePusty(z402, '    <P_190>' + TKwotaCNieujemna(z402) + '</P_190>' + nl)
		r = r + xmlNiePusty(z403, '    <P_191>' + TKwotaCNieujemna(z403) + '</P_191>' + nl)
		r = r + xmlNiePusty(z404, '    <P_192>' + TKwotaCNieujemna(z404) + '</P_192>' + nl)
		r = r + xmlNiePusty(z405, '    <P_193>' + TKwotaCNieujemna(z405) + '</P_193>' + nl)
		r = r + xmlNiePusty(z406, '    <P_194>' + TKwotaCNieujemna(z406) + '</P_194>' + nl)
		r = r + xmlNiePusty(z407, '    <P_195>' + TKwotaCNieujemna(z407) + '</P_195>' + nl)
		r = r + xmlNiePusty(z408, '    <P_196>' + TKwotaCNieujemna(z408) + '</P_196>' + nl)
		r = r + xmlNiePusty(z409, '    <P_197>' + TKwotaCNieujemna(z409) + '</P_197>' + nl)
		r = r + xmlNiePusty(z410, '    <P_198>' + TKwotaCNieujemna(z410) + '</P_198>' + nl)
		r = r + xmlNiePusty(z411, '    <P_199>' + TKwotaCNieujemna(z411) + '</P_199>' + nl)
		r = r + xmlNiePusty(z412, '    <P_200>' + TKwotaCNieujemna(z412) + '</P_200>' + nl)
		r = r + '    <P_201>' + TKwota2Nieujemna(z501) + '</P_201>' + nl
		r = r + '    <P_202>' + TKwota2Nieujemna(z502) + '</P_202>' + nl
		r = r + '    <P_203>' + TKwota2Nieujemna(z503) + '</P_203>' + nl
		r = r + '    <P_204>' + TKwota2Nieujemna(z504) + '</P_204>' + nl
		r = r + '    <P_205>' + TKwota2Nieujemna(z505) + '</P_205>' + nl
		r = r + '    <P_206>' + TKwota2Nieujemna(z506) + '</P_206>' + nl
		r = r + '    <P_207>' + TKwota2Nieujemna(z507) + '</P_207>' + nl
		r = r + '    <P_208>' + TKwota2Nieujemna(z508) + '</P_208>' + nl
		r = r + '    <P_209>' + TKwota2Nieujemna(z509) + '</P_209>' + nl
		r = r + '    <P_210>' + TKwota2Nieujemna(z510) + '</P_210>' + nl
		r = r + '    <P_211>' + TKwota2Nieujemna(z511) + '</P_211>' + nl
		r = r + '    <P_212>' + TKwota2Nieujemna(z512) + '</P_212>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwot z poz. od 201 do 212 lub wpˆacenia ich w niepeˆnej wysoko˜ci niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowi¥zkom pˆatnika grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_7()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2018/12/06/6327/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (7)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>7</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
         r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(z601, '    <P_9>' + TKwotaCNieujemna(z601) + '</P_9>' + nl)
		r = r + xmlNiePusty(z602, '    <P_10>' + TKwotaCNieujemna(z602) + '</P_10>' + nl)
		r = r + xmlNiePusty(z603, '    <P_11>' + TKwotaCNieujemna(z603) + '</P_11>' + nl)
		r = r + xmlNiePusty(z604, '    <P_12>' + TKwotaCNieujemna(z604) + '</P_12>' + nl)
		r = r + xmlNiePusty(z605, '    <P_13>' + TKwotaCNieujemna(z605) + '</P_13>' + nl)
		r = r + xmlNiePusty(z606, '    <P_14>' + TKwotaCNieujemna(z606) + '</P_14>' + nl)
		r = r + xmlNiePusty(z607, '    <P_15>' + TKwotaCNieujemna(z607) + '</P_15>' + nl)
		r = r + xmlNiePusty(z608, '    <P_16>' + TKwotaCNieujemna(z608) + '</P_16>' + nl)
		r = r + xmlNiePusty(z609, '    <P_17>' + TKwotaCNieujemna(z609) + '</P_17>' + nl)
		r = r + xmlNiePusty(z610, '    <P_18>' + TKwotaCNieujemna(z610) + '</P_18>' + nl)
		r = r + xmlNiePusty(z611, '    <P_19>' + TKwotaCNieujemna(z611) + '</P_19>' + nl)
		r = r + xmlNiePusty(z612, '    <P_20>' + TKwotaCNieujemna(z612) + '</P_20>' + nl)
		r = r + xmlNiePusty(z201, '    <P_309>' + TKwotaCNieujemna(z201) + '</P_309>' + nl)
		r = r + xmlNiePusty(z202, '    <P_310>' + TKwotaCNieujemna(z202) + '</P_310>' + nl)
		r = r + xmlNiePusty(z203, '    <P_311>' + TKwotaCNieujemna(z203) + '</P_311>' + nl)
		r = r + xmlNiePusty(z204, '    <P_312>' + TKwotaCNieujemna(z204) + '</P_312>' + nl)
		r = r + xmlNiePusty(z205, '    <P_313>' + TKwotaCNieujemna(z205) + '</P_313>' + nl)
		r = r + xmlNiePusty(z206, '    <P_314>' + TKwotaCNieujemna(z206) + '</P_314>' + nl)
		r = r + xmlNiePusty(z207, '    <P_315>' + TKwotaCNieujemna(z207) + '</P_315>' + nl)
		r = r + xmlNiePusty(z208, '    <P_316>' + TKwotaCNieujemna(z208) + '</P_316>' + nl)
		r = r + xmlNiePusty(z209, '    <P_317>' + TKwotaCNieujemna(z209) + '</P_317>' + nl)
		r = r + xmlNiePusty(z210, '    <P_318>' + TKwotaCNieujemna(z210) + '</P_318>' + nl)
		r = r + xmlNiePusty(z211, '    <P_319>' + TKwotaCNieujemna(z211) + '</P_319>' + nl)
		r = r + xmlNiePusty(z212, '    <P_320>' + TKwotaCNieujemna(z212) + '</P_320>' + nl)
		r = r + xmlNiePusty(z301, '    <P_321>' + TKwota2Nieujemna(z301) + '</P_321>' + nl)
		r = r + xmlNiePusty(z302, '    <P_322>' + TKwota2Nieujemna(z302) + '</P_322>' + nl)
		r = r + xmlNiePusty(z303, '    <P_323>' + TKwota2Nieujemna(z303) + '</P_323>' + nl)
		r = r + xmlNiePusty(z304, '    <P_324>' + TKwota2Nieujemna(z304) + '</P_324>' + nl)
		r = r + xmlNiePusty(z305, '    <P_325>' + TKwota2Nieujemna(z305) + '</P_325>' + nl)
		r = r + xmlNiePusty(z306, '    <P_326>' + TKwota2Nieujemna(z306) + '</P_326>' + nl)
		r = r + xmlNiePusty(z307, '    <P_327>' + TKwota2Nieujemna(z307) + '</P_327>' + nl)
		r = r + xmlNiePusty(z308, '    <P_328>' + TKwota2Nieujemna(z308) + '</P_328>' + nl)
		r = r + xmlNiePusty(z309, '    <P_329>' + TKwota2Nieujemna(z309) + '</P_329>' + nl)
		r = r + xmlNiePusty(z310, '    <P_330>' + TKwota2Nieujemna(z310) + '</P_330>' + nl)
		r = r + xmlNiePusty(z311, '    <P_331>' + TKwota2Nieujemna(z311) + '</P_331>' + nl)
		r = r + xmlNiePusty(z312, '    <P_332>' + TKwota2Nieujemna(z312) + '</P_332>' + nl)
		r = r + xmlNiePusty(z401, '    <P_333>' + TKwotaCNieujemna(z401) + '</P_333>' + nl)
		r = r + xmlNiePusty(z402, '    <P_334>' + TKwotaCNieujemna(z402) + '</P_334>' + nl)
		r = r + xmlNiePusty(z403, '    <P_335>' + TKwotaCNieujemna(z403) + '</P_335>' + nl)
		r = r + xmlNiePusty(z404, '    <P_336>' + TKwotaCNieujemna(z404) + '</P_336>' + nl)
		r = r + xmlNiePusty(z405, '    <P_337>' + TKwotaCNieujemna(z405) + '</P_337>' + nl)
		r = r + xmlNiePusty(z406, '    <P_338>' + TKwotaCNieujemna(z406) + '</P_338>' + nl)
		r = r + xmlNiePusty(z407, '    <P_339>' + TKwotaCNieujemna(z407) + '</P_339>' + nl)
		r = r + xmlNiePusty(z408, '    <P_340>' + TKwotaCNieujemna(z408) + '</P_340>' + nl)
		r = r + xmlNiePusty(z409, '    <P_341>' + TKwotaCNieujemna(z409) + '</P_341>' + nl)
		r = r + xmlNiePusty(z410, '    <P_342>' + TKwotaCNieujemna(z410) + '</P_342>' + nl)
		r = r + xmlNiePusty(z411, '    <P_343>' + TKwotaCNieujemna(z411) + '</P_343>' + nl)
		r = r + xmlNiePusty(z412, '    <P_344>' + TKwotaCNieujemna(z412) + '</P_344>' + nl)
		r = r + '    <P_345>' + TKwota2Nieujemna(z501) + '</P_345>' + nl
		r = r + '    <P_346>' + TKwota2Nieujemna(z502) + '</P_346>' + nl
		r = r + '    <P_347>' + TKwota2Nieujemna(z503) + '</P_347>' + nl
		r = r + '    <P_348>' + TKwota2Nieujemna(z504) + '</P_348>' + nl
		r = r + '    <P_349>' + TKwota2Nieujemna(z505) + '</P_349>' + nl
		r = r + '    <P_350>' + TKwota2Nieujemna(z506) + '</P_350>' + nl
		r = r + '    <P_351>' + TKwota2Nieujemna(z507) + '</P_351>' + nl
		r = r + '    <P_352>' + TKwota2Nieujemna(z508) + '</P_352>' + nl
		r = r + '    <P_353>' + TKwota2Nieujemna(z509) + '</P_353>' + nl
		r = r + '    <P_354>' + TKwota2Nieujemna(z510) + '</P_354>' + nl
		r = r + '    <P_355>' + TKwota2Nieujemna(z511) + '</P_355>' + nl
		r = r + '    <P_356>' + TKwota2Nieujemna(z512) + '</P_356>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v2(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_8()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2019/12/19/8980/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (8)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>8</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(P1) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</PelnaNazwa>' + nl
			//r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
         r = r + '      <etd:NIP>' + trimnip(P1) + '</etd:NIP>' + nl
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(P8n)) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(P8n)) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
      IF zDEKLKOR <> 'D'
         r = r + '    <P_7>' + iif(rodzaj_korekty == 2, '2', '1' ) + '</P_7>' + nl
      ENDIF
		r = r + xmlNiePusty(z601, '    <P_10>' + TKwotaCNieujemna(z601) + '</P_10>' + nl)
		r = r + xmlNiePusty(z602, '    <P_11>' + TKwotaCNieujemna(z602) + '</P_11>' + nl)
		r = r + xmlNiePusty(z603, '    <P_12>' + TKwotaCNieujemna(z603) + '</P_12>' + nl)
		r = r + xmlNiePusty(z604, '    <P_13>' + TKwotaCNieujemna(z604) + '</P_13>' + nl)
		r = r + xmlNiePusty(z605, '    <P_14>' + TKwotaCNieujemna(z605) + '</P_14>' + nl)
		r = r + xmlNiePusty(z606, '    <P_15>' + TKwotaCNieujemna(z606) + '</P_15>' + nl)
		r = r + xmlNiePusty(z607, '    <P_16>' + TKwotaCNieujemna(z607) + '</P_16>' + nl)
		r = r + xmlNiePusty(z608, '    <P_17>' + TKwotaCNieujemna(z608) + '</P_17>' + nl)
		r = r + xmlNiePusty(z609, '    <P_18>' + TKwotaCNieujemna(z609) + '</P_18>' + nl)
		r = r + xmlNiePusty(z610, '    <P_19>' + TKwotaCNieujemna(z610) + '</P_19>' + nl)
		r = r + xmlNiePusty(z611, '    <P_20>' + TKwotaCNieujemna(z611) + '</P_20>' + nl)
		r = r + xmlNiePusty(z612, '    <P_21>' + TKwotaCNieujemna(z612) + '</P_21>' + nl)
		r = r + xmlNiePusty(z201, '    <P_310>' + TKwotaCNieujemna(z201) + '</P_310>' + nl)
		r = r + xmlNiePusty(z202, '    <P_311>' + TKwotaCNieujemna(z202) + '</P_311>' + nl)
		r = r + xmlNiePusty(z203, '    <P_312>' + TKwotaCNieujemna(z203) + '</P_312>' + nl)
		r = r + xmlNiePusty(z204, '    <P_313>' + TKwotaCNieujemna(z204) + '</P_313>' + nl)
		r = r + xmlNiePusty(z205, '    <P_314>' + TKwotaCNieujemna(z205) + '</P_314>' + nl)
		r = r + xmlNiePusty(z206, '    <P_315>' + TKwotaCNieujemna(z206) + '</P_315>' + nl)
		r = r + xmlNiePusty(z207, '    <P_316>' + TKwotaCNieujemna(z207) + '</P_316>' + nl)
		r = r + xmlNiePusty(z208, '    <P_317>' + TKwotaCNieujemna(z208) + '</P_317>' + nl)
		r = r + xmlNiePusty(z209, '    <P_318>' + TKwotaCNieujemna(z209) + '</P_318>' + nl)
		r = r + xmlNiePusty(z210, '    <P_319>' + TKwotaCNieujemna(z210) + '</P_319>' + nl)
		r = r + xmlNiePusty(z211, '    <P_320>' + TKwotaCNieujemna(z211) + '</P_320>' + nl)
		r = r + xmlNiePusty(z212, '    <P_321>' + TKwotaCNieujemna(z212) + '</P_321>' + nl)
		r = r + xmlNiePusty(z301, '    <P_322>' + TKwota2Nieujemna(z301) + '</P_322>' + nl)
		r = r + xmlNiePusty(z302, '    <P_323>' + TKwota2Nieujemna(z302) + '</P_323>' + nl)
		r = r + xmlNiePusty(z303, '    <P_324>' + TKwota2Nieujemna(z303) + '</P_324>' + nl)
		r = r + xmlNiePusty(z304, '    <P_325>' + TKwota2Nieujemna(z304) + '</P_325>' + nl)
		r = r + xmlNiePusty(z305, '    <P_326>' + TKwota2Nieujemna(z305) + '</P_326>' + nl)
		r = r + xmlNiePusty(z306, '    <P_327>' + TKwota2Nieujemna(z306) + '</P_327>' + nl)
		r = r + xmlNiePusty(z307, '    <P_328>' + TKwota2Nieujemna(z307) + '</P_328>' + nl)
		r = r + xmlNiePusty(z308, '    <P_329>' + TKwota2Nieujemna(z308) + '</P_329>' + nl)
		r = r + xmlNiePusty(z309, '    <P_330>' + TKwota2Nieujemna(z309) + '</P_330>' + nl)
		r = r + xmlNiePusty(z310, '    <P_331>' + TKwota2Nieujemna(z310) + '</P_331>' + nl)
		r = r + xmlNiePusty(z311, '    <P_332>' + TKwota2Nieujemna(z311) + '</P_332>' + nl)
		r = r + xmlNiePusty(z312, '    <P_333>' + TKwota2Nieujemna(z312) + '</P_333>' + nl)
		r = r + xmlNiePusty(z401, '    <P_334>' + TKwotaCNieujemna(z401) + '</P_334>' + nl)
		r = r + xmlNiePusty(z402, '    <P_335>' + TKwotaCNieujemna(z402) + '</P_335>' + nl)
		r = r + xmlNiePusty(z403, '    <P_336>' + TKwotaCNieujemna(z403) + '</P_336>' + nl)
		r = r + xmlNiePusty(z404, '    <P_337>' + TKwotaCNieujemna(z404) + '</P_337>' + nl)
		r = r + xmlNiePusty(z405, '    <P_338>' + TKwotaCNieujemna(z405) + '</P_338>' + nl)
		r = r + xmlNiePusty(z406, '    <P_339>' + TKwotaCNieujemna(z406) + '</P_339>' + nl)
		r = r + xmlNiePusty(z407, '    <P_340>' + TKwotaCNieujemna(z407) + '</P_340>' + nl)
		r = r + xmlNiePusty(z408, '    <P_341>' + TKwotaCNieujemna(z408) + '</P_341>' + nl)
		r = r + xmlNiePusty(z409, '    <P_342>' + TKwotaCNieujemna(z409) + '</P_342>' + nl)
		r = r + xmlNiePusty(z410, '    <P_343>' + TKwotaCNieujemna(z410) + '</P_343>' + nl)
		r = r + xmlNiePusty(z411, '    <P_344>' + TKwotaCNieujemna(z411) + '</P_344>' + nl)
		r = r + xmlNiePusty(z412, '    <P_345>' + TKwotaCNieujemna(z412) + '</P_345>' + nl)
		r = r + '    <P_346>' + TKwota2Nieujemna(z501) + '</P_346>' + nl
		r = r + '    <P_347>' + TKwota2Nieujemna(z502) + '</P_347>' + nl
		r = r + '    <P_348>' + TKwota2Nieujemna(z503) + '</P_348>' + nl
		r = r + '    <P_349>' + TKwota2Nieujemna(z504) + '</P_349>' + nl
		r = r + '    <P_350>' + TKwota2Nieujemna(z505) + '</P_350>' + nl
		r = r + '    <P_351>' + TKwota2Nieujemna(z506) + '</P_351>' + nl
		r = r + '    <P_352>' + TKwota2Nieujemna(z507) + '</P_352>' + nl
		r = r + '    <P_353>' + TKwota2Nieujemna(z508) + '</P_353>' + nl
		r = r + '    <P_354>' + TKwota2Nieujemna(z509) + '</P_354>' + nl
		r = r + '    <P_355>' + TKwota2Nieujemna(z510) + '</P_355>' + nl
		r = r + '    <P_356>' + TKwota2Nieujemna(z511) + '</P_356>' + nl
		r = r + '    <P_357>' + TKwota2Nieujemna(z512) + '</P_357>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v2(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit11_21()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF JAKICEL='K'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2014/12/08/1887/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (21)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>21</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1s) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P1s) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8n))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8n))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <Podmiot2 rola="Podatnik">' + nl
      r = r + '    <etd:OsobaFizyczna>' + nl
      IF Len(AllTrim(P30)) = 0
         r = r + '      <etd:NIP>' + trimnip(P29) + '</etd:NIP>' + nl
      ELSE
         r = r + '      <etd:PESEL>' + trimnip(P30) + '</etd:PESEL>' + nl
      ENDIF
      r = r + '      <etd:ImiePierwsze>' + str2sxml(AllTrim(P32)) + '</etd:ImiePierwsze>' + nl
      r = r + '      <etd:Nazwisko>' + str2sxml(AllTrim(P31)) + '</etd:Nazwisko>' + nl
      r = r + '      <etd:DataUrodzenia>' + date2strxml(P36d) + '</etd:DataUrodzenia>' + nl
      r = r + '    </etd:OsobaFizyczna>' + nl
      r = r + '    <etd:AdresZamieszkania  rodzajAdresu="RAD">' + nl
		r = r + '      <etd:AdresPol>' + nl
		r = r + '        <etd:KodKraju>PL</etd:KodKraju>' + nl
		r = r + '        <etd:Wojewodztwo>' + str2sxml(AllTrim(P38)) + '</etd:Wojewodztwo>' + nl
		r = r + '        <etd:Powiat>' + str2sxml(AllTrim(P38a)) + '</etd:Powiat>' + nl
		r = r + '        <etd:Gmina>' + str2sxml(AllTrim(P39)) + '</etd:Gmina>' + nl
      IF Len(AllTrim(P40)) > 0
   		r = r + '        <etd:Ulica>' + str2sxml(AllTrim(P40)) + '</etd:Ulica>' + nl
      ENDIF
		r = r + '        <etd:NrDomu>' + str2sxml(AllTrim(P41)) + '</etd:NrDomu>' + nl
      IF Len(AllTrim(P42)) > 0
   		r = r + '        <etd:NrLokalu>' + str2sxml(AllTrim(P42)) + '</etd:NrLokalu>' + nl
      ENDIF
		r = r + '        <etd:Miejscowosc>' + str2sxml(AllTrim(P43)) + '</etd:Miejscowosc>' + nl
		r = r + '        <etd:KodPocztowy>' + str2sxml(AllTrim(P44)) + '</etd:KodPocztowy>' + nl
		r = r + '        <etd:Poczta>' + str2sxml(AllTrim(P45)) + '</etd:Poczta>' + nl
		r = r + '      </etd:AdresPol>' + nl
		r = r + '    </etd:AdresZamieszkania>' + nl
      r = r + '  </Podmiot2>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_24>1</P_24>' + nl
		r = r + '    <P_25>' + TKwota2Nieujemna(P50) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwota2Nieujemna(P51) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwota2Nieujemna(P53a) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwota2Nieujemna(zKOR_ZWET) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaCNieujemna(P55) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwota2Nieujemna(0) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwota2Nieujemna(0) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwota2Nieujemna(p61+p50_2) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwota2Nieujemna(p61+p50_2) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaCNieujemna(p63+p53_2) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwota2Nieujemna(p50_3) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwota2Nieujemna(p50_3) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwota2Nieujemna(zKOR_ZWEM) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(p53_3) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwota2Nieujemna(0) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwota2Nieujemna(0) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaCNieujemna(0) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwota2Nieujemna(p50_4) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwota2Nieujemna(p50_4) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaCNieujemna(p53_4) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwota2Nieujemna(p50_5) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwota2Nieujemna(p51_5) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwota2Nieujemna(p52_5a) + '</P_47>' + nl
		r = r + '    <P_48>' + TKwotaCNieujemna(p53_5) + '</P_48>' + nl
		r = r + '    <P_49>' + TKwota2Nieujemna(p50_9) + '</P_49>' + nl
		r = r + '    <P_50>' + TKwota2Nieujemna(p51_9) + '</P_50>' + nl
		r = r + '    <P_51>' + TKwota2Nieujemna(p52_9a) + '</P_51>' + nl
		r = r + '    <P_52>' + TKwotaCNieujemna(p53_9) + '</P_52>' + nl
		r = r + '    <P_53>' + TKwota2Nieujemna(0) + '</P_53>' + nl
		r = r + '    <P_54>' + TKwota2Nieujemna(p52_6a) + '</P_54>' + nl
		r = r + '    <P_55>' + TKwotaCNieujemna(p53_6) + '</P_55>' + nl
		r = r + '    <P_56>' + TKwota2Nieujemna(p50_6) + '</P_56>' + nl
		r = r + '    <P_57>' + TKwota2Nieujemna(p51_6) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwota2Nieujemna(p50_1) + '</P_58>' + nl
		r = r + '    <P_59>' + TKwota2Nieujemna(p51_1) + '</P_59>' + nl
		r = r + '    <P_60>' + TKwota2Nieujemna(p52_1a) + '</P_60>' + nl
		r = r + '    <P_61>' + TKwotaCNieujemna(p53_1) + '</P_61>' + nl
		r = r + '    <P_62>' + TKwota2Nieujemna(p50_7) + '</P_62>' + nl
		r = r + '    <P_63>' + TKwota2Nieujemna(p50_7) + '</P_63>' + nl
		r = r + '    <P_64>' + TKwota2Nieujemna(zKOR_ZWIN) + '</P_64>' + nl
		r = r + '    <P_65>' + TKwotaCNieujemna(p53_7) + '</P_65>' + nl
		r = r + '    <P_66>' + TKwota2Nieujemna(p52+p52z) + '</P_66>' + nl
		r = r + '    <P_67>' + TKwota2Nieujemna(zKOR_SPOLZ) + '</P_67>' + nl
		r = r + '    <P_68>' + TKwota2Nieujemna(p54a+p54za+p64) + '</P_68>' + nl
		r = r + '    <P_69>' + TKwota2Nieujemna(zKOR_ZDROZ) + '</P_69>' + nl
//		r = r + '    <P_70>' + TKwota2Nieujemna(0) + '</P_70>' + nl
//		r = r + '    <P_71>' + TKwota2Nieujemna(0) + '</P_71>' + nl
		r = r + '    <P_72>2</P_72>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>' + str2sxml('Za uchybienie obowi¥zkom pˆatnika grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit11)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_pit11) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit11_22()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF JAKICEL='K'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2015/02/23/2094/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (22)" rodzajZobowiazania="Z" wersjaSchemy="1-1E">PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>22</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1s) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P1s) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8n))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8n))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <Podmiot2 rola="Podatnik">' + nl
      r = r + '    <OsobaFizyczna>' + nl
      IF Len(AllTrim(P30)) = 0
         r = r + '      <etd:NIP>' + trimnip(P29) + '</etd:NIP>' + nl
      ELSE
         r = r + '      <etd:PESEL>' + trimnip(P30) + '</etd:PESEL>' + nl
      ENDIF
      r = r + '      <etd:ImiePierwsze>' + str2sxml(AllTrim(P32)) + '</etd:ImiePierwsze>' + nl
      r = r + '      <etd:Nazwisko>' + str2sxml(AllTrim(P31)) + '</etd:Nazwisko>' + nl
      r = r + '      <etd:DataUrodzenia>' + date2strxml(P36d) + '</etd:DataUrodzenia>' + nl
      r = r + '    </OsobaFizyczna>' + nl
      r = r + '    <AdresZamieszkania>' + nl
		r = r + '        <KodKraju poz="P_18A">PL</KodKraju>' + nl
		r = r + '        <Wojewodztwo>' + str2sxml(AllTrim(P38)) + '</Wojewodztwo>' + nl
		r = r + '        <Powiat>' + str2sxml(AllTrim(P38a)) + '</Powiat>' + nl
		r = r + '        <Gmina>' + str2sxml(AllTrim(P39)) + '</Gmina>' + nl
      IF Len(AllTrim(P40)) > 0
   		r = r + '        <Ulica poz="P_22">' + str2sxml(AllTrim(P40)) + '</Ulica>' + nl
      ENDIF
		r = r + '        <NrDomu poz="P_23">' + str2sxml(AllTrim(P41)) + '</NrDomu>' + nl
      IF Len(AllTrim(P42)) > 0
   		r = r + '        <NrLokalu poz="P_24">' + str2sxml(AllTrim(P42)) + '</NrLokalu>' + nl
      ENDIF
		r = r + '        <Miejscowosc poz="P_25">' + str2sxml(AllTrim(P43)) + '</Miejscowosc>' + nl
		r = r + '        <KodPocztowy poz="P_26">' + str2sxml(AllTrim(P44)) + '</KodPocztowy>' + nl
		r = r + '        <Poczta>' + str2sxml(AllTrim(P45)) + '</Poczta>' + nl
		r = r + '    </AdresZamieszkania>' + nl
      r = r + '  </Podmiot2>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>1</P_10>' + nl
		r = r + '    <P_28>1</P_28>' + nl
		r = r + '    <P_29>' + TKwota2Nieujemna(P50) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwota2Nieujemna(P51) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwota2Nieujemna(P53a) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwota2Nieujemna(zKOR_ZWET) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaCNieujemna(P55) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwota2Nieujemna(0) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwota2Nieujemna(0) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwota2Nieujemna(p61+p50_2) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwota2Nieujemna(p61+p50_2) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(p63+p53_2) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwota2Nieujemna(p50_3) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwota2Nieujemna(p50_3) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwota2Nieujemna(zKOR_ZWEM) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwotaCNieujemna(p53_3) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwota2Nieujemna(0) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwota2Nieujemna(0) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaCNieujemna(0) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwota2Nieujemna(p50_4) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwota2Nieujemna(p50_4) + '</P_47>' + nl
		r = r + '    <P_48>' + TKwotaCNieujemna(p53_4) + '</P_48>' + nl
		r = r + '    <P_49>' + TKwota2Nieujemna(p50_5) + '</P_49>' + nl
		r = r + '    <P_50>' + TKwota2Nieujemna(p51_5) + '</P_50>' + nl
		r = r + '    <P_51>' + TKwota2Nieujemna(p52_5a) + '</P_51>' + nl
		r = r + '    <P_52>' + TKwotaCNieujemna(p53_5) + '</P_52>' + nl
		r = r + '    <P_53>' + TKwota2Nieujemna(p50_9) + '</P_53>' + nl
		r = r + '    <P_54>' + TKwota2Nieujemna(p51_9) + '</P_54>' + nl
		r = r + '    <P_55>' + TKwota2Nieujemna(p52_9a) + '</P_55>' + nl
		r = r + '    <P_56>' + TKwotaCNieujemna(p53_9) + '</P_56>' + nl
		r = r + '    <P_57>' + TKwota2Nieujemna(0) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwota2Nieujemna(p52_6a) + '</P_58>' + nl
		r = r + '    <P_59>' + TKwotaCNieujemna(p53_6) + '</P_59>' + nl
		r = r + '    <P_60>' + TKwota2Nieujemna(p50_6) + '</P_60>' + nl
		r = r + '    <P_61>' + TKwota2Nieujemna(p51_6) + '</P_61>' + nl
		r = r + '    <P_62>' + TKwota2Nieujemna(p50_1) + '</P_62>' + nl
		r = r + '    <P_63>' + TKwota2Nieujemna(p51_1) + '</P_63>' + nl
		r = r + '    <P_64>' + TKwota2Nieujemna(p52_1a) + '</P_64>' + nl
		r = r + '    <P_65>' + TKwotaCNieujemna(p53_1) + '</P_65>' + nl
		r = r + '    <P_66>' + TKwota2Nieujemna(p50_7) + '</P_66>' + nl
		r = r + '    <P_67>' + TKwota2Nieujemna(p50_7) + '</P_67>' + nl
		r = r + '    <P_68>' + TKwota2Nieujemna(zKOR_ZWIN) + '</P_68>' + nl
		r = r + '    <P_69>' + TKwotaCNieujemna(p53_7) + '</P_69>' + nl
		r = r + '    <P_70>' + TKwota2Nieujemna(p52+p52z) + '</P_70>' + nl
		r = r + '    <P_71>' + TKwota2Nieujemna(zKOR_SPOLZ) + '</P_71>' + nl
		r = r + '    <P_72>' + TKwota2Nieujemna(p54a+p54za+p64) + '</P_72>' + nl
		r = r + '    <P_73>' + TKwota2Nieujemna(zKOR_ZDROZ) + '</P_73>' + nl
//		r = r + '    <P_70>' + TKwota2Nieujemna(0) + '</P_70>' + nl
//		r = r + '    <P_71>' + TKwota2Nieujemna(0) + '</P_71>' + nl
		r = r + '    <P_76>2</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>' + str2sxml('Za uchybienie obowi¥zkom pˆatnika grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit11)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_pit11) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit11_23()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF JAKICEL='K'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2016/01/11/3066/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (23)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>23</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik') + '">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1s) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P1s) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8n))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8n))) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P8d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <Podmiot2 rola="Podatnik">' + nl
      r = r + '    <OsobaFizyczna>' + nl
      IF Len(AllTrim(P30)) = 0
         r = r + '      <NIP>' + trimnip(P29) + '</NIP>' + nl
      ELSE
         r = r + '      <PESEL>' + trimnip(P30) + '</PESEL>' + nl
      ENDIF
      r = r + '      <ImiePierwsze>' + str2sxml(AllTrim(P32)) + '</ImiePierwsze>' + nl
      r = r + '      <Nazwisko>' + str2sxml(AllTrim(P31)) + '</Nazwisko>' + nl
      r = r + '      <DataUrodzenia>' + date2strxml(P36d) + '</DataUrodzenia>' + nl
      r = r + '    </OsobaFizyczna>' + nl
      r = r + '    <AdresZamieszkania rodzajAdresu="RAD">' + nl
		r = r + '        <KodKraju poz="P_18A">PL</KodKraju>' + nl
		r = r + '        <Wojewodztwo>' + str2sxml(AllTrim(P38)) + '</Wojewodztwo>' + nl
		r = r + '        <Powiat>' + str2sxml(AllTrim(P38a)) + '</Powiat>' + nl
		r = r + '        <Gmina>' + str2sxml(AllTrim(P39)) + '</Gmina>' + nl
      IF Len(AllTrim(P40)) > 0
   		r = r + '        <Ulica poz="P_22">' + str2sxml(AllTrim(P40)) + '</Ulica>' + nl
      ENDIF
		r = r + '        <NrDomu poz="P_23">' + str2sxml(AllTrim(P41)) + '</NrDomu>' + nl
      IF Len(AllTrim(P42)) > 0
   		r = r + '        <NrLokalu poz="P_24">' + str2sxml(AllTrim(P42)) + '</NrLokalu>' + nl
      ENDIF
		r = r + '        <Miejscowosc poz="P_25">' + str2sxml(AllTrim(P43)) + '</Miejscowosc>' + nl
		r = r + '        <KodPocztowy poz="P_26">' + str2sxml(AllTrim(P44)) + '</KodPocztowy>' + nl
		r = r + '        <Poczta>' + str2sxml(AllTrim(P45)) + '</Poczta>' + nl
		r = r + '    </AdresZamieszkania>' + nl
      r = r + '  </Podmiot2>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>1</P_10>' + nl
      IF DP28$'1234'
   		r = r + '    <P_28>' + DP28 + '</P_28>' + nl
      ENDIF
		r = r + '    <P_29>' + TKwota2Nieujemna(P50) + '</P_29>' + nl
		r = r + xmlNiePusty(P51, '    <P_30>' + TKwota2Nieujemna(P51) + '</P_30>' + nl)
		r = r + '    <P_31>' + TKwota2Nieujemna(P53a) + '</P_31>' + nl
		r = r + xmlNiePusty(zKOR_ZWET, '    <P_32>' + TKwota2Nieujemna(zKOR_ZWET) + '</P_32>' + nl)
		r = r + '    <P_33>' + TKwotaCNieujemna(P55) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwota2Nieujemna(0) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwota2Nieujemna(0) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwota2Nieujemna(p61+p50_2) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwota2Nieujemna(p61+p50_2) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(p63+p53_2) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwota2Nieujemna(p50_3) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwota2Nieujemna(p50_3) + '</P_40>' + nl
		r = r + xmlNiePusty(zKOR_ZWEM, '    <P_41>' + TKwota2Nieujemna(zKOR_ZWEM) + '</P_41>' + nl)
		r = r + '    <P_42>' + TKwotaCNieujemna(p53_3) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwota2Nieujemna(0) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwota2Nieujemna(0) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaCNieujemna(0) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwota2Nieujemna(p50_4) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwota2Nieujemna(p50_4) + '</P_47>' + nl
		r = r + '    <P_48>' + TKwotaCNieujemna(p53_4) + '</P_48>' + nl
		r = r + '    <P_49>' + TKwota2Nieujemna(p50_5) + '</P_49>' + nl
		r = r + xmlNiePusty(p51_5, '    <P_50>' + TKwota2Nieujemna(p51_5) + '</P_50>' + nl)
		r = r + '    <P_51>' + TKwota2Nieujemna(p52_5a) + '</P_51>' + nl
		r = r + '    <P_52>' + TKwotaCNieujemna(p53_5) + '</P_52>' + nl
		r = r + '    <P_53>' + TKwota2Nieujemna(p50_9) + '</P_53>' + nl
		r = r + xmlNiePusty(p51_9, '    <P_54>' + TKwota2Nieujemna(p51_9) + '</P_54>' + nl)
		r = r + '    <P_55>' + TKwota2Nieujemna(p52_9a) + '</P_55>' + nl
		r = r + '    <P_56>' + TKwotaCNieujemna(p53_9) + '</P_56>' + nl
		r = r + '    <P_57>' + TKwota2Nieujemna(0) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwota2Nieujemna(p52_6a) + '</P_58>' + nl
		r = r + '    <P_59>' + TKwotaCNieujemna(p53_6) + '</P_59>' + nl
		r = r + '    <P_60>' + TKwota2Nieujemna(p50_6) + '</P_60>' + nl
		r = r + '    <P_61>' + TKwota2Nieujemna(p51_6) + '</P_61>' + nl
		r = r + '    <P_62>' + TKwota2Nieujemna(p50_1) + '</P_62>' + nl
		r = r + xmlNiePusty(p51_1, '    <P_63>' + TKwota2Nieujemna(p51_1) + '</P_63>' + nl)
		r = r + '    <P_64>' + TKwota2Nieujemna(p52_1a) + '</P_64>' + nl
		r = r + '    <P_65>' + TKwotaCNieujemna(p53_1) + '</P_65>' + nl
		r = r + '    <P_66>' + TKwota2Nieujemna(p50_7) + '</P_66>' + nl
		r = r + '    <P_67>' + TKwota2Nieujemna(p50_7) + '</P_67>' + nl
		r = r + xmlNiePusty(zKOR_ZWIN, '    <P_68>' + TKwota2Nieujemna(zKOR_ZWIN) + '</P_68>' + nl)
		r = r + '    <P_69>' + TKwotaCNieujemna(p53_7) + '</P_69>' + nl
		r = r + '    <P_70>' + TKwota2Nieujemna(p52+p52z) + '</P_70>' + nl
		r = r + '    <P_71>' + TKwota2Nieujemna(zKOR_SPOLZ) + '</P_71>' + nl
		r = r + '    <P_72>' + TKwota2Nieujemna(p54a+p54za+p64) + '</P_72>' + nl
		r = r + '    <P_73>' + TKwota2Nieujemna(zKOR_ZDROZ) + '</P_73>' + nl
//		r = r + '    <P_70>' + TKwota2Nieujemna(0) + '</P_70>' + nl
//		r = r + '    <P_71>' + TKwota2Nieujemna(0) + '</P_71>' + nl
		r = r + '    <P_76>2</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>' + str2sxml('Za uchybienie obowi¥zkom pˆatnika grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit11)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_pit11) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit11_24()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF JAKICEL='K'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2018/12/06/6319/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (24)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>24</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik/Skˆadaj¥cy') + '">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(P1s) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' + P8r + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P1s) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8n))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8n))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <Podmiot2 rola="Podatnik">' + nl
      r = r + '    <OsobaFizyczna>' + nl
      IF Len(AllTrim(P30)) = 0
         r = r + '      <etd:NIP>' + trimnip(P29) + '</etd:NIP>' + nl
      ELSE
         r = r + '      <etd:PESEL>' + trimnip(P30) + '</etd:PESEL>' + nl
      ENDIF
      r = r + '      <etd:ImiePierwsze>' + str2sxml(AllTrim(P32)) + '</etd:ImiePierwsze>' + nl
      r = r + '      <etd:Nazwisko>' + str2sxml(AllTrim(P31)) + '</etd:Nazwisko>' + nl
      r = r + '      <etd:DataUrodzenia>' + date2strxml(P36d) + '</etd:DataUrodzenia>' + nl
      r = r + '    </OsobaFizyczna>' + nl
      r = r + '    <AdresZamieszkania rodzajAdresu="RAD">' + nl
		r = r + '        <KodKraju poz="P_18A">' + str2sxml(P_KrajID) + '</KodKraju>' + nl
      IF Len( AllTrim( P38 ) ) > 0
   		r = r + '        <Wojewodztwo>' + str2sxml(AllTrim(P38)) + '</Wojewodztwo>' + nl
      ENDIF
      IF Len( AllTrim( P38a ) ) > 0
   		r = r + '        <Powiat>' + str2sxml(AllTrim(P38a)) + '</Powiat>' + nl
      ENDIF
      IF Len( AllTrim( P39 ) ) > 0
   		r = r + '        <Gmina>' + str2sxml(AllTrim(P39)) + '</Gmina>' + nl
      ENDIF
      IF Len(AllTrim(P40)) > 0
   		r = r + '        <Ulica poz="P_22">' + str2sxml(AllTrim(P40)) + '</Ulica>' + nl
      ENDIF
      IF Len( AllTrim( P41 ) ) > 0
   		r = r + '        <NrDomu poz="P_23">' + str2sxml(AllTrim(P41)) + '</NrDomu>' + nl
      ENDIF
      IF Len(AllTrim(P42)) > 0
   		r = r + '        <NrLokalu poz="P_24">' + str2sxml(AllTrim(P42)) + '</NrLokalu>' + nl
      ENDIF
		r = r + '        <Miejscowosc poz="P_25">' + str2sxml(AllTrim(P43)) + '</Miejscowosc>' + nl
      IF Len( AllTrim( P44 ) ) > 0
   		r = r + '        <KodPocztowy poz="P_26">' + str2sxml(AllTrim(P44)) + '</KodPocztowy>' + nl
      ENDIF
      IF Len( AllTrim( P45 ) ) > 0
   		r = r + '        <Poczta>' + str2sxml(AllTrim(P45)) + '</Poczta>' + nl
      ENDIF
		r = r + '    </AdresZamieszkania>' + nl
      r = r + '  </Podmiot2>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + iif( DP10 == 'N', '2', '1' ) + '</P_10>' + nl
      IF DP28$'1234'
   		r = r + '    <P_28>' + DP28 + '</P_28>' + nl
      ENDIF
		r = r + '    <P_29>' + TKwota2Nieujemna(P50) + '</P_29>' + nl
		r = r + xmlNiePusty(P51, '    <P_30>' + TKwota2Nieujemna(P51) + '</P_30>' + nl)
		r = r + '    <P_31>' + TKwota2Nieujemna(P53a) + '</P_31>' + nl
		r = r + xmlNiePusty(zKOR_ZWET, '    <P_32>' + TKwota2Nieujemna(zKOR_ZWET) + '</P_32>' + nl)
		r = r + '    <P_33>' + TKwotaCNieujemna(P55) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwota2Nieujemna(0) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwota2Nieujemna(0) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwota2Nieujemna(p61+p50_2) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwota2Nieujemna(p61+p50_2) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(p63+p53_2) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwota2Nieujemna(p50_3) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwota2Nieujemna(p50_3) + '</P_40>' + nl
		r = r + xmlNiePusty(zKOR_ZWEM, '    <P_41>' + TKwota2Nieujemna(zKOR_ZWEM) + '</P_41>' + nl)
		r = r + '    <P_42>' + TKwotaCNieujemna(p53_3) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwota2Nieujemna(0) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwota2Nieujemna(0) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaCNieujemna(0) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwota2Nieujemna(p50_4) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwota2Nieujemna(p50_4) + '</P_47>' + nl
		r = r + '    <P_48>' + TKwotaCNieujemna(p53_4) + '</P_48>' + nl
		r = r + '    <P_49>' + TKwota2Nieujemna(p50_5) + '</P_49>' + nl
		r = r + xmlNiePusty(p51_5, '    <P_50>' + TKwota2Nieujemna(p51_5) + '</P_50>' + nl)
		r = r + '    <P_51>' + TKwota2Nieujemna(p52_5a) + '</P_51>' + nl
		r = r + '    <P_52>' + TKwotaCNieujemna(p53_5) + '</P_52>' + nl
		r = r + '    <P_53>' + TKwota2Nieujemna(p50_9) + '</P_53>' + nl
		r = r + xmlNiePusty(p51_9, '    <P_54>' + TKwota2Nieujemna(p51_9) + '</P_54>' + nl)
		r = r + '    <P_55>' + TKwota2Nieujemna(p52_9a) + '</P_55>' + nl
		r = r + '    <P_56>' + TKwotaCNieujemna(p53_9) + '</P_56>' + nl
		r = r + '    <P_57>' + TKwota2Nieujemna(0) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwota2Nieujemna(p52_6a) + '</P_58>' + nl
		r = r + '    <P_59>' + TKwotaCNieujemna(p53_6) + '</P_59>' + nl
		r = r + '    <P_60>' + TKwota2Nieujemna(p50_6) + '</P_60>' + nl
		r = r + '    <P_61>' + TKwota2Nieujemna(p51_6) + '</P_61>' + nl
		r = r + '    <P_62>' + TKwota2Nieujemna(p50_1) + '</P_62>' + nl
		r = r + xmlNiePusty(p51_1, '    <P_63>' + TKwota2Nieujemna(p51_1) + '</P_63>' + nl)
		r = r + '    <P_64>' + TKwota2Nieujemna(p52_1a) + '</P_64>' + nl
		r = r + '    <P_65>' + TKwotaCNieujemna(p53_1) + '</P_65>' + nl
		r = r + '    <P_66>' + TKwota2Nieujemna(p50_7) + '</P_66>' + nl
		r = r + '    <P_67>' + TKwota2Nieujemna(p50_7) + '</P_67>' + nl
		r = r + xmlNiePusty(zKOR_ZWIN, '    <P_68>' + TKwota2Nieujemna(zKOR_ZWIN) + '</P_68>' + nl)
		r = r + '    <P_69>' + TKwotaCNieujemna(p53_7) + '</P_69>' + nl
		r = r + '    <P_70>' + TKwota2Nieujemna(p52+p52z) + '</P_70>' + nl
		r = r + '    <P_71>' + TKwota2Nieujemna(zKOR_SPOLZ) + '</P_71>' + nl
		r = r + '    <P_72>' + TKwota2Nieujemna(p54a+p54za+p64) + '</P_72>' + nl
		r = r + '    <P_73>' + TKwota2Nieujemna(zKOR_ZDROZ) + '</P_73>' + nl
//		r = r + '    <P_70>' + TKwota2Nieujemna(0) + '</P_70>' + nl
//		r = r + '    <P_71>' + TKwota2Nieujemna(0) + '</P_71>' + nl
		r = r + '    <P_85>2</P_85>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit11)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v2(tresc_korekty_pit11) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit11_25()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF JAKICEL='K'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2019/12/19/8981/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (25)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>25</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Pˆatnik/Skˆadaj¥cy') + '">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(P1s) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</PelnaNazwa>' + nl
			//r = r + '      <REGON>' + P8r + '</REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P1s) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8n))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8n))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P8d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <Podmiot2 rola="Podatnik">' + nl
      r = r + '    <OsobaFizyczna>' + nl
      IF Len(AllTrim(P30)) = 0
         r = r + '      <etd:NIP>' + trimnip(P29) + '</etd:NIP>' + nl
      ELSE
         r = r + '      <etd:PESEL>' + trimnip(P30) + '</etd:PESEL>' + nl
      ENDIF
      r = r + '      <etd:ImiePierwsze>' + str2sxml(AllTrim(P32)) + '</etd:ImiePierwsze>' + nl
      r = r + '      <etd:Nazwisko>' + str2sxml(AllTrim(P31)) + '</etd:Nazwisko>' + nl
      r = r + '      <etd:DataUrodzenia>' + date2strxml(P36d) + '</etd:DataUrodzenia>' + nl
      r = r + '    </OsobaFizyczna>' + nl
      r = r + '    <AdresZamieszkania rodzajAdresu="RAD">' + nl
		r = r + '        <KodKraju poz="P_19A">' + str2sxml(P_KrajID) + '</KodKraju>' + nl
      IF Len( AllTrim( P38 ) ) > 0
   		r = r + '        <Wojewodztwo>' + str2sxml(AllTrim(P38)) + '</Wojewodztwo>' + nl
      ENDIF
      IF Len( AllTrim( P38a ) ) > 0
   		r = r + '        <Powiat>' + str2sxml(AllTrim(P38a)) + '</Powiat>' + nl
      ENDIF
      IF Len( AllTrim( P39 ) ) > 0
   		r = r + '        <Gmina>' + str2sxml(AllTrim(P39)) + '</Gmina>' + nl
      ENDIF
      IF Len(AllTrim(P40)) > 0
   		r = r + '        <Ulica poz="P_23">' + str2sxml(AllTrim(P40)) + '</Ulica>' + nl
      ENDIF
      IF Len( AllTrim( P41 ) ) > 0
   		r = r + '        <NrDomu poz="P_24">' + str2sxml(AllTrim(P41)) + '</NrDomu>' + nl
      ENDIF
      IF Len(AllTrim(P42)) > 0
   		r = r + '        <NrLokalu poz="P_25">' + str2sxml(AllTrim(P42)) + '</NrLokalu>' + nl
      ENDIF
		r = r + '        <Miejscowosc poz="P_26">' + str2sxml(AllTrim(P43)) + '</Miejscowosc>' + nl
      IF Len( AllTrim( P44 ) ) > 0
   		r = r + '        <KodPocztowy poz="P_27">' + str2sxml(AllTrim(P44)) + '</KodPocztowy>' + nl
      ENDIF
//      IF Len( AllTrim( P45 ) ) > 0
//   		r = r + '        <Poczta>' + str2sxml(AllTrim(P45)) + '</Poczta>' + nl
//      ENDIF
		r = r + '    </AdresZamieszkania>' + nl
      r = r + '  </Podmiot2>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_11>' + iif( DP10 == 'N', '2', '1' ) + '</P_11>' + nl
      IF DP28$'1234'
   		r = r + '    <P_28>' + DP28 + '</P_28>' + nl
      ENDIF
		r = r + '    <P_29>' + TKwota2Nieujemna(P50) + '</P_29>' + nl
		r = r + xmlNiePusty(P51, '    <P_30>' + TKwota2Nieujemna(P51) + '</P_30>' + nl)
		r = r + '    <P_31>' + TKwota2Nieujemna(P53a) + '</P_31>' + nl
		r = r + xmlNiePusty(zKOR_ZWET, '    <P_32>' + TKwota2Nieujemna(zKOR_ZWET) + '</P_32>' + nl)
		r = r + '    <P_33>' + TKwotaCNieujemna(P55) + '</P_33>' + nl
		//r = r + '    <P_34>' + TKwota2Nieujemna(0) + '</P_34>' + nl
		//r = r + '    <P_35>' + TKwota2Nieujemna(0) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwota2Nieujemna(P50_R262) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwota2Nieujemna(P51_R262) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwota2Nieujemna(P53a_R262) + '</P_38>' + nl
		r = r + xmlNiePusty(zKOR_ZWET, '    <P_39>' + TKwota2Nieujemna(zKOR_ZWET) + '</P_39>' + nl)
		r = r + '    <P_40>' + TKwotaCNieujemna(P55_R262) + '</P_40>' + nl
		//r = r + '    <P_41>' + TKwota2Nieujemna(0) + '</P_41>' + nl
		//r = r + '    <P_42>' + TKwota2Nieujemna(0) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwota2Nieujemna(p50_3) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwota2Nieujemna(p50_3) + '</P_44>' + nl
		r = r + xmlNiePusty(zKOR_ZWEM, '    <P_45>' + TKwota2Nieujemna(zKOR_ZWEM) + '</P_45>' + nl)
		r = r + '    <P_46>' + TKwotaCNieujemna(p53_3) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwota2Nieujemna(P50_11) + '</P_47>' + nl
		r = r + xmlNiePusty(p51_11, '    <P_48>' + TKwota2Nieujemna(p51_11) + '</P_48>' + nl)
		r = r + '    <P_49>' + TKwota2Nieujemna(p52_11a) + '</P_49>' + nl
		r = r + '    <P_50>' + TKwotaCNieujemna(p53_11) + '</P_50>' + nl
		r = r + '    <P_51>' + TKwota2Nieujemna(p51_5) + '</P_51>' + nl
		r = r + xmlNiePusty(p50_5, '    <P_52>' + TKwota2Nieujemna(p50_5) + '</P_52>' + nl)
		r = r + '    <P_53>' + TKwota2Nieujemna(p52_5a) + '</P_53>' + nl
		r = r + '    <P_54>' + TKwotaCNieujemna(p53_5) + '</P_54>' + nl
		r = r + '    <P_55>' + TKwota2Nieujemna(P50_5_R262) + '</P_55>' + nl
		r = r + xmlNiePusty(P51_5_R262, '    <P_56>' + TKwota2Nieujemna(P51_5_R262) + '</P_56>' + nl)
		r = r + '    <P_57>' + TKwota2Nieujemna(P52_5a_R262) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwotaCNieujemna(P53_5_R262) + '</P_58>' + nl
		r = r + '    <P_59>' + TKwota2Nieujemna(0) + '</P_59>' + nl
		r = r + '    <P_60>' + TKwota2Nieujemna(p52_6a) + '</P_60>' + nl
		r = r + '    <P_61>' + TKwotaCNieujemna(p53_6) + '</P_61>' + nl
		r = r + '    <P_62>' + TKwota2Nieujemna(p50_6) + '</P_62>' + nl
		r = r + '    <P_63>' + TKwota2Nieujemna(p51_6) + '</P_63>' + nl
		r = r + '    <P_64>' + TKwota2Nieujemna(p50_7) + '</P_64>' + nl
		r = r + '    <P_65>' + TKwota2Nieujemna(p51_7) + '</P_65>' + nl
		r = r + '    <P_66>' + TKwota2Nieujemna(P50_7-P51_7) + '</P_66>' + nl
		r = r + xmlNiePusty(zKOR_ZWIN, '    <P_67>' + TKwota2Nieujemna(zKOR_ZWIN) + '</P_67>' + nl)
		r = r + '    <P_68>' + TKwotaCNieujemna(p53_7) + '</P_68>' + nl
		r = r + '    <P_69>' + TKwota2Nieujemna(p52+p52z) + '</P_69>' + nl
		r = r + '    <P_70>' + TKwota2Nieujemna(p52_R262+p52z_R262) + '</P_70>' + nl
		r = r + '    <P_71>' + TKwota2Nieujemna(p52_R26+p52z_R26) + '</P_71>' + nl
		r = r + '    <P_72>' + TKwota2Nieujemna(p54a+p54za+p64) + '</P_72>' + nl
		r = r + '    <P_73>' + TKwota2Nieujemna(p54a_R262+p54za_R262+p64_R262) + '</P_73>' + nl
		r = r + '    <P_74>' + TKwota2Nieujemna(zKOR_ZDROZ+p54a_R26+p54za_R26+p64_R26) + '</P_74>' + nl
//		r = r + '    <P_70>' + TKwota2Nieujemna(0) + '</P_70>' + nl
//		r = r + '    <P_71>' + TKwota2Nieujemna(0) + '</P_71>' + nl
      r = r + '    <P_86>' + TKwota2Nieujemna(P50_R26 + P50_5_R26) + '</P_86>' + nl
      r = r + '    <P_87>' + TKwota2Nieujemna(P50_R26) + '</P_87>' + nl
      r = r + '    <P_88>' + TKwota2Nieujemna(P50_5_R26) + '</P_88>' + nl
		r = r + '    <P_89>2</P_89>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit11)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v2(tresc_korekty_pit11) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7_14()
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2013/04/09/1113/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7 (14)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7</KodFormularza>' + nl
      r = r + '    <WariantFormularza>14</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(p5a) + '</Miesiac>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(P4)) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(P65dekwe) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(P65vdekwe) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaCNieujemna(Pp12) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaCNieujemna(znowytran) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P75) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaC(P76) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna(Pp8) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(Pp11) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwotaC(P45dek) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwotaC(P46dek) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P49dek) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwotaC(P50dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(zkorekst) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(zkorekpoz) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P79) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaCNieujemna(P98a) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwotaCNieujemna(pp13) + '</P_47>' + nl
		r = r + '    <P_48>' + TKwotaCNieujemna(P98b) + '</P_48>' + nl
		r = r + '    <P_49>' + TKwotaCNieujemna(P99a) + '</P_49>' + nl
		r = r + '    <P_50>' + TKwotaCNieujemna(P99) + '</P_50>' + nl
		r = r + '    <P_51>' + TKwotaCNieujemna(P99c) + '</P_51>' + nl
		r = r + '    <P_52>' + TKwotaCNieujemna(P99abc) + '</P_52>' + nl
		r = r + '    <P_53>' + TKwotaCNieujemna(P99ab) + '</P_53>' + nl
		r = r + '    <P_54>' + TKwotaCNieujemna(P99b) + '</P_54>' + nl
		r = r + '    <P_55>' + TKwotaCNieujemna(P99d) + '</P_55>' + nl
      IF zf2='T'
   		r = r + '    <P_56>1</P_56>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_57>1</P_57>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_58>1</P_58>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_59>1</P_59>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_68>' + AllTrim(zDEKLTEL) + '</P_68>' + nl
      ENDIF
		r = r + '    <P_69>' + date2strxml(Date()) + '</P_69>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz.48 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz.U. z 2012 r. poz. 1015, z p¢«n. zm.).') + '</Pouczenie>' + nl
		r = r + '  <Oswiadczenie>' + str2sxml('O˜wiadczam, ¾e s¥ mi znane przepisy Kodeksu karnego skarbowego o odpowiedzialno˜ci za podanie danych niezgodnych z rzeczywisto˜ci¥.') + '</Oswiadczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7k_8()
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2013/04/09/1114/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7K (8)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7K</KodFormularza>' + nl
      r = r + '    <WariantFormularza>8</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(P4)) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(P65dekwe) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(P65vdekwe) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaCNieujemna(Pp12) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaCNieujemna(znowytran) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P75) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaC(P76) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna(Pp8) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(Pp11) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwotaC(P45dek) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwotaC(P46dek) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P49dek) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwotaC(P50dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(zkorekst) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(zkorekpoz) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P79) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaCNieujemna(P98a) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwotaCNieujemna(pp13) + '</P_47>' + nl
		r = r + '    <P_48>' + TKwotaCNieujemna(P98b) + '</P_48>' + nl
		r = r + '    <P_49>' + TKwotaCNieujemna(P99a) + '</P_49>' + nl
		r = r + '    <P_50>' + TKwotaCNieujemna(P99) + '</P_50>' + nl
		r = r + '    <P_51>' + TKwotaCNieujemna(P99c) + '</P_51>' + nl
		r = r + '    <P_52>' + TKwotaCNieujemna(P99abc) + '</P_52>' + nl
		r = r + '    <P_53>' + TKwotaCNieujemna(P99ab) + '</P_53>' + nl
		r = r + '    <P_54>' + TKwotaCNieujemna(P99b) + '</P_54>' + nl
		r = r + '    <P_55>' + TKwotaCNieujemna(P99d) + '</P_55>' + nl
      IF zf2='T'
   		r = r + '    <P_56>1</P_56>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_57>1</P_57>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_58>1</P_58>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_59>1</P_59>' + nl
      ENDIF
		r = r + '    <P_60>2</P_60>' + nl
		r = r + '    <P_61>2</P_61>' + nl
		r = r + '    <P_62>2</P_62>' + nl
		r = r + '    <P_63>2</P_63>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_68>' + AllTrim(zDEKLTEL) + '</P_68>' + nl
      ENDIF
		r = r + '    <P_69>' + date2strxml(Date()) + '</P_69>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz.48 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz.U. z 2012 r. poz. 1015, z p¢«n. zm.).') + '</Pouczenie>' + nl
		r = r + '  <Oswiadczenie>' + str2sxml('O˜wiadczam, ¾e s¥ mi znane przepisy Kodeksu karnego skarbowego o odpowiedzialno˜ci za podanie danych niezgodnych z rzeczywisto˜ci¥.') + '</Oswiadczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7d_5()
   LOCAL r, nl, tmp_cel, tmp_p53
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      tmp_p53 = '1'
   IF p98taknie = 'N'
      tml_p53 = '2'
   ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = '<Deklaracja xmlns="http://crd.gov.pl/wzor/2013/04/09/1112/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7D (5)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7D</KodFormularza>' + nl
      r = r + '    <WariantFormularza>5</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(P4)) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(P65dekwe) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(P65vdekwe) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaCNieujemna(Pp12) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaCNieujemna(znowytran) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P75) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaC(P76) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna(Pp8) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(Pp11) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwotaC(P45dek) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwotaC(P46dek) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P49dek) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwotaC(P50dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(zkorekst) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(zkorekpoz) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P79) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaCNieujemna(P98a) + '</P_46>' + nl
		r = r + '    <P_47>' + TKwotaCNieujemna(pp13) + '</P_47>' + nl
		r = r + '    <P_48>' + TKwotaCNieujemna(P98b) + '</P_48>' + nl
		r = r + '    <P_49>' + TKwotaCNieujemna(zVATZALMIE) + '</P_49>' + nl
		r = r + '    <P_50>' + TKwotaCNieujemna(zVATNADKWA) + '</P_50>' + nl
		r = r + '    <P_51>' + TKwotaCNieujemna(P98dozap) + '</P_51>' + nl
		r = r + '    <P_52>' + TKwotaCNieujemna(P98rozn) + '</P_52>' + nl
		r = r + '    <P_53>' + tmp_p53 + '</P_53>' + nl
		r = r + '    <P_54>' + TKwotaCNieujemna(P98doprze) + '</P_54>' + nl
		r = r + '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl
		r = r + '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl
		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwotaCNieujemna(P99abc) + '</P_58>' + nl
		r = r + '    <P_59>' + TKwotaCNieujemna(P99ab) + '</P_59>' + nl
		r = r + '    <P_60>' + TKwotaCNieujemna(P99b) + '</P_60>' + nl
		r = r + '    <P_61>' + TKwotaCNieujemna(P99d) + '</P_61>' + nl
      IF zf2='T'
   		r = r + '    <P_62>1</P_62>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
		r = r + '    <P_66>2</P_66>' + nl
		r = r + '    <P_67>2</P_67>' + nl
		r = r + '    <P_68>2</P_68>' + nl
		r = r + '    <P_69>2</P_69>' + nl
		r = r + '    <P_70>2</P_70>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_75>' + AllTrim(zDEKLTEL) + '</P_75>' + nl
      ENDIF
		r = r + '    <P_76>' + date2strxml(Date()) + '</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz.51 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz.U. z 2012 r. poz.1015, z p¢«n. zm.).') + '</Pouczenie>' + nl
		r = r + '  <Oswiadczenie>' + str2sxml('O˜wiadczam, ¾e s¥ mi znane przepisy Kodeksu karnego skarbowego o odpowiedzialno˜ci za podanie danych niezgodnych z rzeczywisto˜ci¥.') + '</Oswiadczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7_15()
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2015/09/04/2567/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7 (15)" rodzajZobowiazania="Z" wersjaSchemy="1-1E" >VAT-7</KodFormularza>' + nl
      r = r + '    <WariantFormularza>15</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(p5a) + '</Miesiac>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
			r = r + '      <REGON>' +  AllTrim(P11) + '</REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P4) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P11d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_37>' + TKwotaCNieujemna(znowytran) + '</P_37>' + nl)
		r = r + '    <P_38>' + TKwotaC(P75) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwotaC(P76) + '</P_39>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_40>' + TKwotaCNieujemna(Pp8) + '</P_40>' + nl)
		r = r + '    <P_41>' + TKwotaC(P45dek) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwotaC(P46dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(P49dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P50dek) + '</P_44>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_45>' + TKwotaC(zkorekst) + '</P_45>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_46>' + TKwotaC(zkorekpoz) + '</P_46>' + nl)
//		r = r + '    <P_47>' + TKwotaC(0) + '</P_47>' + nl
		r = r + xmlNiePusty(P79, '    <P_48>' + TKwotaC(P79) + '</P_48>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_49>' + TKwotaCNieujemna(P98a) + '</P_49>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_50>' + TKwotaCNieujemna(pp13) + '</P_50>' + nl)
		r = r + '    <P_51>' + TKwotaCNieujemna(P98b) + '</P_51>' + nl
		r = r + xmlNiePusty(P99a, '    <P_52>' + TKwotaCNieujemna(P99a) + '</P_52>' + nl)
		r = r + xmlNiePusty(P99, '    <P_53>' + TKwotaCNieujemna(P99) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P99c) + '</P_54>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_55>' + TKwotaCNieujemna(P99abc) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_56>' + TKwotaCNieujemna(P99ab) + '</P_56>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_57>' + TKwotaCNieujemna(P99b) + '</P_57>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_58>' + TKwotaCNieujemna(P99d) + '</P_58>' + nl)
      IF zf2='T'
   		r = r + '    <P_59>1</P_59>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_60>1</P_60>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_61>1</P_61>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_62>1</P_62>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_71>' + AllTrim(zDEKLTEL) + '</P_71>' + nl
      ENDIF
		r = r + '    <P_72>' + date2strxml(Date()) + '</P_72>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz. 51 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to nara¾enie podatku na uszczuplenie grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7k_9()
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2015/07/09/2480/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7K (9)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7K</KodFormularza>' + nl
      r = r + '    <WariantFormularza>9</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
			r = r + '      <REGON>' +  AllTrim(P11) + '</REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P4) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P11d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_37>' + TKwotaCNieujemna(znowytran) + '</P_37>' + nl)
		r = r + '    <P_38>' + TKwotaC(P75) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwotaC(P76) + '</P_39>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_40>' + TKwotaCNieujemna(Pp8) + '</P_40>' + nl)
		r = r + '    <P_41>' + TKwotaC(P45dek) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwotaC(P46dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(P49dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P50dek) + '</P_44>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_45>' + TKwotaC(zkorekst) + '</P_45>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_46>' + TKwotaC(zkorekpoz) + '</P_46>' + nl)
//		r = r + '    <P_47>' + TKwotaC(0) + '</P_47>' + nl
		r = r + xmlNiePusty(P79, '    <P_48>' + TKwotaC(P79) + '</P_48>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_49>' + TKwotaCNieujemna(P98a) + '</P_49>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_50>' + TKwotaCNieujemna(pp13) + '</P_50>' + nl)
		r = r + '    <P_51>' + TKwotaCNieujemna(P98b) + '</P_51>' + nl
		r = r + xmlNiePusty(P99a, '    <P_52>' + TKwotaCNieujemna(P99a) + '</P_52>' + nl)
		r = r + xmlNiePusty(P99, '    <P_53>' + TKwotaCNieujemna(P99) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P99c) + '</P_54>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_55>' + TKwotaCNieujemna(P99abc) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_56>' + TKwotaCNieujemna(P99ab) + '</P_56>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_57>' + TKwotaCNieujemna(P99b) + '</P_57>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_58>' + TKwotaCNieujemna(P99d) + '</P_58>' + nl)
      IF zf2='T'
   		r = r + '    <P_59>1</P_59>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_60>1</P_60>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_61>1</P_61>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_62>1</P_62>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_71>' + AllTrim(zDEKLTEL) + '</P_71>' + nl
      ENDIF
		r = r + '    <P_72>' + date2strxml(Date()) + '</P_72>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz. 51 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to nara¾enie podatku na uszczuplenie grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7d_6()
   LOCAL r, nl, tmp_cel, tmp_p53
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      tmp_p53 = '1'
   IF p98taknie = 'N'
      tml_p53 = '2'
   ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = '<Deklaracja xmlns="http://crd.gov.pl/wzor/2015/07/09/2482/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7D (6)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7D</KodFormularza>' + nl
      r = r + '    <WariantFormularza>6</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
			r = r + '      <REGON>' +  AllTrim(P11) + '</REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P4) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P11d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_37>' + TKwotaCNieujemna(znowytran) + '</P_37>' + nl)
		r = r + '    <P_38>' + TKwotaC(P75) + '</P_38>' + nl
		r = r + '    <P_39>' + TKwotaC(P76) + '</P_39>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_40>' + TKwotaCNieujemna(Pp8) + '</P_40>' + nl)
		r = r + '    <P_41>' + TKwotaC(P45dek) + '</P_41>' + nl
		r = r + '    <P_42>' + TKwotaC(P46dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(P49dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P50dek) + '</P_44>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_45>' + TKwotaC(zkorekst) + '</P_45>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_46>' + TKwotaC(zkorekpoz) + '</P_46>' + nl)
//		r = r + '    <P_47>' + TKwotaC(0) + '</P_47>' + nl
		r = r + xmlNiePusty(P79, '    <P_48>' + TKwotaC(P79) + '</P_48>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_49>' + TKwotaCNieujemna(P98a) + '</P_49>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_50>' + TKwotaCNieujemna(pp13) + '</P_50>' + nl)
		r = r + xmlNiePusty(P98b, '    <P_51>' + TKwotaCNieujemna(P98b) + '</P_51>' + nl)
		r = r + xmlNiePusty(zVATZALMIE, '    <P_52>' + TKwotaCNieujemna(zVATZALMIE) + '</P_52>' + nl)
		r = r + xmlNiePusty(zVATNADKWA, '    <P_53>' + TKwotaCNieujemna(zVATNADKWA) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98dozap) + '</P_54>' + nl
		r = r + '    <P_55>' + TKwotaCNieujemna(P98rozn) + '</P_55>' + nl
		r = r + '    <P_56>' + tmp_p53 + '</P_56>' + nl
		r = r + xmlNiePusty(P98doprze, '    <P_57>' + TKwotaCNieujemna(P98doprze) + '</P_57>' + nl)
		r = r + xmlNiePusty(P99a, '    <P_58>' + TKwotaCNieujemna(P99a) + '</P_58>' + nl)
		r = r + xmlNiePusty(P99, '    <P_59>' + TKwotaCNieujemna(P99) + '</P_59>' + nl)
		r = r + '    <P_60>' + TKwotaCNieujemna(P99c) + '</P_60>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_61>' + TKwotaCNieujemna(P99abc) + '</P_61>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_62>' + TKwotaCNieujemna(P99ab) + '</P_62>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_63>' + TKwotaCNieujemna(P99b) + '</P_63>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_64>' + TKwotaCNieujemna(P99d) + '</P_64>' + nl)
      IF zf2='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_66>1</P_66>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_67>1</P_67>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_68>1</P_68>' + nl
      ENDIF
		r = r + '    <P_69>2</P_69>' + nl
		r = r + '    <P_70>2</P_70>' + nl
		r = r + '    <P_71>2</P_71>' + nl
		r = r + '    <P_72>2</P_72>' + nl
		r = r + '    <P_73>2</P_73>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_78>' + AllTrim(zDEKLTEL) + '</P_78>' + nl
      ENDIF
		r = r + '    <P_79>' + date2strxml(Date()) + '</P_79>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz.54 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to nara¾enie podatku na uszczuplenie grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7_16()
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2016/01/18/3120/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7 (16)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7</KodFormularza>' + nl
      r = r + '    <WariantFormularza>16</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(p5a) + '</Miesiac>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
			r = r + '      <REGON>' +  AllTrim(P11) + '</REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P4) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P11d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
		//r = r + xmlNiePusty(0, '    <P_37>' + TKwotaCNieujemna(0) + '</P_37>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl)
		r = r + '    <P_39>' + TKwotaC(P75) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwotaC(P76) + '</P_40>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_41>' + TKwotaCNieujemna(Pp8) + '</P_41>' + nl)
		r = r + '    <P_42>' + TKwotaC(P45dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(P46dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P49dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P50dek) + '</P_45>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_46>' + TKwotaC(zkorekst) + '</P_46>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_47>' + TKwotaC(zkorekpoz) + '</P_47>' + nl)
//		r = r + '    <P_47>' + TKwotaC(0) + '</P_47>' + nl
		r = r + xmlNiePusty(P79, '    <P_49>' + TKwotaC(P79) + '</P_49>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_50>' + TKwotaCNieujemna(P98a) + '</P_50>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_51>' + TKwotaCNieujemna(pp13) + '</P_51>' + nl)
		r = r + '    <P_52>' + TKwotaCNieujemna(P98b) + '</P_52>' + nl
		r = r + xmlNiePusty(P99a, '    <P_53>' + TKwotaCNieujemna(P99a) + '</P_53>' + nl)
		r = r + xmlNiePusty(P99, '    <P_54>' + TKwotaCNieujemna(P99) + '</P_54>' + nl)
		r = r + '    <P_55>' + TKwotaCNieujemna(P99c) + '</P_55>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_56>' + TKwotaCNieujemna(P99abc) + '</P_56>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_57>' + TKwotaCNieujemna(P99ab) + '</P_57>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_58>' + TKwotaCNieujemna(P99b) + '</P_58>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_59>' + TKwotaCNieujemna(P99d) + '</P_59>' + nl)
      IF zf2='T'
   		r = r + '    <P_60>1</P_60>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_61>1</P_61>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_62>1</P_62>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_72>' + AllTrim(zDEKLTEL) + '</P_72>' + nl
      ENDIF
		r = r + '    <P_73>' + date2strxml(Date()) + '</P_73>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz. 52 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to nara¾enie podatku na uszczuplenie grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7k_10()
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2016/01/18/3119/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7K (10)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7K</KodFormularza>' + nl
      r = r + '    <WariantFormularza>10</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
			r = r + '      <REGON>' +  AllTrim(P11) + '</REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P4) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P11d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
		//r = r + xmlNiePusty(0, '    <P_37>' + TKwotaCNieujemna(0) + '</P_37>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl)
		r = r + '    <P_39>' + TKwotaC(P75) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwotaC(P76) + '</P_40>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_41>' + TKwotaCNieujemna(Pp8) + '</P_41>' + nl)
		r = r + '    <P_42>' + TKwotaC(P45dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(P46dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P49dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P50dek) + '</P_45>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_46>' + TKwotaC(zkorekst) + '</P_46>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_47>' + TKwotaC(zkorekpoz) + '</P_47>' + nl)
//		r = r + '    <P_47>' + TKwotaC(0) + '</P_47>' + nl
		r = r + xmlNiePusty(P79, '    <P_49>' + TKwotaC(P79) + '</P_49>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_50>' + TKwotaCNieujemna(P98a) + '</P_50>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_51>' + TKwotaCNieujemna(pp13) + '</P_51>' + nl)
		r = r + '    <P_52>' + TKwotaCNieujemna(P98b) + '</P_52>' + nl
		r = r + xmlNiePusty(P99a, '    <P_53>' + TKwotaCNieujemna(P99a) + '</P_53>' + nl)
		r = r + xmlNiePusty(P99, '    <P_54>' + TKwotaCNieujemna(P99) + '</P_54>' + nl)
		r = r + '    <P_55>' + TKwotaCNieujemna(P99c) + '</P_55>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_56>' + TKwotaCNieujemna(P99abc) + '</P_56>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_57>' + TKwotaCNieujemna(P99ab) + '</P_57>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_58>' + TKwotaCNieujemna(P99b) + '</P_58>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_59>' + TKwotaCNieujemna(P99d) + '</P_59>' + nl)
      IF zf2='T'
   		r = r + '    <P_60>1</P_60>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_61>1</P_61>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_62>1</P_62>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_72>' + AllTrim(zDEKLTEL) + '</P_72>' + nl
      ENDIF
		r = r + '    <P_73>' + date2strxml(Date()) + '</P_73>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz. 52 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to nara¾enie podatku na uszczuplenie grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7d_7()
   LOCAL r, nl, tmp_cel, tmp_p53
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      tmp_p53 = '1'
   IF p98taknie = 'N'
      tml_p53 = '2'
   ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = '<Deklaracja xmlns="http://crd.gov.pl/wzor/2016/01/19/3122/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7D (7)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7D</KodFormularza>' + nl
      r = r + '    <WariantFormularza>7</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
			r = r + '      <REGON>' +  AllTrim(P11) + '</REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P4) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(P11d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
//		r = r + xmlNiePusty(0, '    <P_37>' + TKwotaCNieujemna(0) + '</P_37>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl)
		r = r + '    <P_39>' + TKwotaC(P75) + '</P_39>' + nl
		r = r + '    <P_40>' + TKwotaC(P76) + '</P_40>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_41>' + TKwotaCNieujemna(Pp8) + '</P_41>' + nl)
		r = r + '    <P_42>' + TKwotaC(P45dek) + '</P_42>' + nl
		r = r + '    <P_43>' + TKwotaC(P46dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P49dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P50dek) + '</P_45>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_46>' + TKwotaC(zkorekst) + '</P_46>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_47>' + TKwotaC(zkorekpoz) + '</P_47>' + nl)
//		r = r + '    <P_47>' + TKwotaC(0) + '</P_47>' + nl
		r = r + xmlNiePusty(P79, '    <P_49>' + TKwotaC(P79) + '</P_49>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_50>' + TKwotaCNieujemna(P98a) + '</P_50>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_51>' + TKwotaCNieujemna(pp13) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98b, '    <P_52>' + TKwotaCNieujemna(P98b) + '</P_52>' + nl)
		r = r + xmlNiePusty(zVATZALMIE, '    <P_53>' + TKwotaCNieujemna(zVATZALMIE) + '</P_53>' + nl)
		r = r + xmlNiePusty(zVATNADKWA, '    <P_54>' + TKwotaCNieujemna(zVATNADKWA) + '</P_54>' + nl)
		r = r + '    <P_55>' + TKwotaCNieujemna(P98dozap) + '</P_55>' + nl
		r = r + '    <P_56>' + TKwotaCNieujemna(P98rozn) + '</P_56>' + nl
		r = r + '    <P_57>' + tmp_p53 + '</P_57>' + nl
		r = r + xmlNiePusty(P98doprze, '    <P_58>' + TKwotaCNieujemna(P98doprze) + '</P_58>' + nl)
		r = r + xmlNiePusty(P99a, '    <P_59>' + TKwotaCNieujemna(P99a) + '</P_59>' + nl)
		r = r + xmlNiePusty(P99, '    <P_60>' + TKwotaCNieujemna(P99) + '</P_60>' + nl)
		r = r + '    <P_61>' + TKwotaCNieujemna(P99c) + '</P_61>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_62>' + TKwotaCNieujemna(P99abc) + '</P_62>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_63>' + TKwotaCNieujemna(P99ab) + '</P_63>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_64>' + TKwotaCNieujemna(P99b) + '</P_64>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_65>' + TKwotaCNieujemna(P99d) + '</P_65>' + nl)
      IF zf2='T'
   		r = r + '    <P_66>1</P_66>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_67>1</P_67>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_68>1</P_68>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_69>1</P_69>' + nl
      ENDIF
		r = r + '    <P_70>2</P_70>' + nl
		r = r + '    <P_71>2</P_71>' + nl
		r = r + '    <P_72>2</P_72>' + nl
		r = r + '    <P_73>2</P_73>' + nl
		r = r + '    <P_74>2</P_74>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_79>' + AllTrim(zDEKLTEL) + '</P_79>' + nl
      ENDIF
		r = r + '    <P_80>' + date2strxml(Date()) + '</P_80>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpˆacenia w obowi¥zuj¥cym terminie kwoty z poz. 55 lub wpˆacenia jej w niepeˆnej wysoko˜ci, niniejsza deklaracja stanowi podstaw© do wystawienia tytuˆu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o post©powaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z p¢«n. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to nara¾enie podatku na uszczuplenie grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu2(tresc_korekty_vat7) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7_17( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2016/08/05/3412/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7 (17)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7</KodFormularza>' + nl
      r = r + '    <WariantFormularza>17</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(p5a) + '</Miesiac>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(P4)) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
		r = r + xmlNiePusty( art111u6, '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl)

		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl
		r = r + xmlNiePusty(P99a, '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99, '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl)
		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_58>' + TKwotaCNieujemna(P99abc) + '</P_58>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_59>' + TKwotaCNieujemna(P99ab) + '</P_59>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_60>' + TKwotaCNieujemna(P99b) + '</P_60>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_61>' + TKwotaCNieujemna(P99d) + '</P_61>' + nl)
      IF zf2='T'
   		r = r + '    <P_62>1</P_62>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF aDane[ 'VATZZ' ][ 'rob' ]
         r += '    <P_66>1</P_66>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_73>' + AllTrim(zDEKLTEL) + '</P_73>' + nl
      ENDIF
		r = r + '    <P_74>' + date2strxml(Date()) + '</P_74>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZZ' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZZ' ][ 'rob' ]
            r += edek_vat_zz5( aDane[ 'VATZZ' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7k_11( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2016/08/05/3413/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7K (11)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7K</KodFormularza>' + nl
      r = r + '    <WariantFormularza>11</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(P4)) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
		r = r + xmlNiePusty( art111u6, '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl)

		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl
		r = r + xmlNiePusty(P99a, '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99, '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl)
		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_58>' + TKwotaCNieujemna(P99abc) + '</P_58>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_59>' + TKwotaCNieujemna(P99ab) + '</P_59>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_60>' + TKwotaCNieujemna(P99b) + '</P_60>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_61>' + TKwotaCNieujemna(P99d) + '</P_61>' + nl)
      IF zf2='T'
   		r = r + '    <P_62>1</P_62>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF aDane[ 'VATZZ' ][ 'rob' ]
         r += '    <P_66>1</P_66>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_73>' + AllTrim(zDEKLTEL) + '</P_73>' + nl
      ENDIF
		r = r + '    <P_74>' + date2strxml(Date()) + '</P_74>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZZ' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZZ' ][ 'rob' ]
            r += edek_vat_zz5( aDane[ 'VATZZ' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7d_8( aDane )
   LOCAL r, nl, tmp_cel, tmp_p53
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      tmp_p53 = '1'
   IF p98taknie = 'N'
      tml_p53 = '2'
   ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = '<Deklaracja xmlns="http://crd.gov.pl/wzor/2016/08/05/3414/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7D (8)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7D</KodFormularza>' + nl
      r = r + '    <WariantFormularza>8</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(P4)) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + xmlNiePusty(P64, '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl)
		r = r + xmlNiePusty(P64exp, '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl)
		r = r + xmlNiePusty(P64expue, '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl)
		r = r + xmlNiePusty(P67, '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl)
		r = r + xmlNiePusty(P67art129, '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl)
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + xmlNiePusty(P65ue, '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl)
		r = r + xmlNiePusty(P65, '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl)
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + xmlNiePusty(SEK_CV7net, '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl)
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + xmlNiePusty(Pp12, '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl)
		r = r + xmlNiePusty( art111u6, '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl)
		r = r + xmlNiePusty(znowytran, '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl)

		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + xmlNiePusty(P98b, '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl)
		r = r + xmlNiePusty(zVATZALMIE, '    <P_55>' + TKwotaCNieujemna(zVATZALMIE) + '</P_55>' + nl)
		r = r + xmlNiePusty(zVATNADKWA, '    <P_56>' + TKwotaCNieujemna(zVATNADKWA) + '</P_56>' + nl)
		r = r + '    <P_57>' + TKwotaCNieujemna(P98dozap) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwotaCNieujemna(P98rozn) + '</P_58>' + nl
		r = r + '    <P_59>' + tmp_p53 + '</P_59>' + nl
		r = r + xmlNiePusty(P98doprze, '    <P_60>' + TKwotaCNieujemna(P98doprze) + '</P_60>' + nl)
		r = r + xmlNiePusty(P99a, '    <P_61>' + TKwotaCNieujemna(P99a) + '</P_61>' + nl)
		r = r + xmlNiePusty(P99, '    <P_62>' + TKwotaCNieujemna(P99) + '</P_62>' + nl)
		r = r + '    <P_63>' + TKwotaCNieujemna(P99c) + '</P_63>' + nl
		r = r + xmlNiePusty(P99abc, '    <P_64>' + TKwotaCNieujemna(P99abc) + '</P_64>' + nl)
		r = r + xmlNiePusty(P99ab, '    <P_65>' + TKwotaCNieujemna(P99ab) + '</P_65>' + nl)
		r = r + xmlNiePusty(P99b, '    <P_66>' + TKwotaCNieujemna(P99b) + '</P_66>' + nl)
		r = r + xmlNiePusty(P99d, '    <P_67>' + TKwotaCNieujemna(P99d) + '</P_67>' + nl)
      IF zf2='T'
   		r = r + '    <P_68>1</P_68>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_69>1</P_69>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_70>1</P_70>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_71>1</P_71>' + nl
      ENDIF
      IF aDane[ 'VATZZ' ][ 'rob' ]
         r += '    <P_72>1</P_72>' + nl
      ENDIF
		//r = r + '    <P_72>2</P_72>' + nl
		//r = r + '    <P_73>2</P_73>' + nl
		//r = r + '    <P_74>2</P_74>' + nl
		//r = r + '    <P_75>2</P_75>' + nl
		//r = r + '    <P_76>2</P_76>' + nl
      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_80>' + AllTrim(zDEKLTEL) + '</P_80>' + nl
      ENDIF
		r = r + '    <P_81>' + date2strxml(Date()) + '</P_81>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZZ' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZZ' ][ 'rob' ]
            r += edek_vat_zz5( aDane[ 'VATZZ' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7_18( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2018/08/27/5658/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7 (18)" rodzajZobowiazania="Z" wersjaSchemy="1-1E" >VAT-7</KodFormularza>' + nl
      r = r + '    <WariantFormularza>18</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(p5a) + '</Miesiac>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
//			r = r + '      <REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl
		r = r + xmlNiePusty(zKOL39, '    <P_39>' + TKwotaCNieujemna(zKOL39) + '</P_39>' + nl)
		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl
		r = r + xmlNiePusty(P99a, '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99, '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl)
      IF P99c > 0
   		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
         IF zZwrRaVAT > 0
      		r = r + '    <P_58>' + TKwotaCNieujemna(zZwrRaVAT) + '</P_58>' + nl
            r = r + '    <P_68>1</P_68>' + nl
         ELSEIF P99abc > 0
      		r = r + xmlNiePusty(P99abc, '    <P_59>' + TKwotaCNieujemna(P99abc) + '</P_59>' + nl)
            r = r + '    <P_70>2</P_70>' + nl
         ELSEIF P99ab > 0
      		r = r + xmlNiePusty(P99ab, '    <P_60>' + TKwotaCNieujemna(P99ab) + '</P_60>' + nl)
         ELSEIF P99b > 0
      		r = r + xmlNiePusty(P99b, '    <P_61>' + TKwotaCNieujemna(P99b) + '</P_61>' + nl)
         ENDIF
         r = r + '    <P_69>' + iif( aDane[ 'VATZZ' ][ 'rob' ], '1', '2' ) + '</P_69>' + nl
      ENDIF
		r = r + xmlNiePusty(P99d, '    <P_62>' + TKwotaCNieujemna(P99d) + '</P_62>' + nl)
      IF zf2='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_66>1</P_66>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_74>' + zAdrEMail + '</P_74>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_75>' + AllTrim(zDEKLTEL) + '</P_75>' + nl
      ENDIF
		//r = r + '    <P_76>' + date2strxml(Date()) + '</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZZ' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZZ' ][ 'rob' ]
            r += edek_vat_zz5( aDane[ 'VATZZ' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7k_12( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2018/08/28/5663/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7K (12)" rodzajZobowiazania="Z" wersjaSchemy="1-2E" >VAT-7K</KodFormularza>' + nl
      r = r + '    <WariantFormularza>12</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl
		r = r + xmlNiePusty(zKOL39, '    <P_39>' + TKwotaCNieujemna(zKOL39) + '</P_39>' + nl)
		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl
		r = r + xmlNiePusty(P99a, '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99, '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl)
      IF P99c > 0
   		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
         IF zZwrRaVAT > 0
      		r = r + '    <P_58>' + TKwotaCNieujemna(zZwrRaVAT) + '</P_58>' + nl
            r = r + '    <P_68>1</P_68>' + nl
         ELSEIF P99abc > 0
      		r = r + xmlNiePusty(P99abc, '    <P_59>' + TKwotaCNieujemna(P99abc) + '</P_59>' + nl)
            r = r + '    <P_70>2</P_70>' + nl
         ELSEIF P99ab > 0
      		r = r + xmlNiePusty(P99ab, '    <P_60>' + TKwotaCNieujemna(P99ab) + '</P_60>' + nl)
         ELSEIF P99b > 0
      		r = r + xmlNiePusty(P99b, '    <P_61>' + TKwotaCNieujemna(P99b) + '</P_61>' + nl)
         ENDIF
         r = r + '    <P_69>' + iif( aDane[ 'VATZZ' ][ 'rob' ], '1', '2' ) + '</P_69>' + nl
      ENDIF
		r = r + xmlNiePusty(P99d, '    <P_62>' + TKwotaCNieujemna(P99d) + '</P_62>' + nl)
      IF zf2='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_66>1</P_66>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_74>' + zAdrEMail + '</P_74>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_75>' + AllTrim(zDEKLTEL) + '</P_75>' + nl
      ENDIF
		//r = r + '    <P_76>' + date2strxml(Date()) + '</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZZ' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZZ' ][ 'rob' ]
            r += edek_vat_zz5( aDane[ 'VATZZ' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7_19( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2019/02/11/7013/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7 (19)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7</KodFormularza>' + nl
      r = r + '    <WariantFormularza>19</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(p5a) + '</Miesiac>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
//			r = r + '      <REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl
		r = r + xmlNiePusty(zKOL39, '    <P_39>' + TKwotaCNieujemna(zKOL39) + '</P_39>' + nl)
		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl
		r = r + xmlNiePusty(P99a, '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99, '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl)
      IF P99c > 0
   		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
         IF zZwrRaVAT > 0
      		r = r + '    <P_58>' + TKwotaCNieujemna(zZwrRaVAT) + '</P_58>' + nl
            r = r + '    <P_68>1</P_68>' + nl
         ELSEIF P99abc > 0
      		r = r + xmlNiePusty(P99abc, '    <P_59>' + TKwotaCNieujemna(P99abc) + '</P_59>' + nl)
         ELSEIF P99ab > 0
      		r = r + xmlNiePusty(P99ab, '    <P_60>' + TKwotaCNieujemna(P99ab) + '</P_60>' + nl)
         ELSEIF P99b > 0
      		r = r + xmlNiePusty(P99b, '    <P_61>' + TKwotaCNieujemna(P99b) + '</P_61>' + nl)
         ENDIF
      ENDIF
		r = r + xmlNiePusty(P99d, '    <P_62>' + TKwotaCNieujemna(P99d) + '</P_62>' + nl)
      IF zf2='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_66>1</P_66>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl

      IF aDane[ 'VATZD' ][ 'rob' ]
         r = r + '    <P_69>1</P_69>' + nl
      ENDIF

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_72>' + zAdrEMail + '</P_72>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_73>' + AllTrim(zDEKLTEL) + '</P_73>' + nl
      ENDIF
		//r = r + '    <P_76>' + date2strxml(Date()) + '</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZD' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3v2(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZD' ][ 'rob' ]
            r += edek_vat_zd1( aDane[ 'VATZD' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7k_13( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2019/02/11/7012/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7K (13)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7K</KodFormularza>' + nl
      r = r + '    <WariantFormularza>13</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl
		r = r + xmlNiePusty(zKOL39, '    <P_39>' + TKwotaCNieujemna(zKOL39) + '</P_39>' + nl)
		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl
		r = r + xmlNiePusty(P99a, '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99, '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl)
      IF P99c > 0
   		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
         IF zZwrRaVAT > 0
      		r = r + '    <P_58>' + TKwotaCNieujemna(zZwrRaVAT) + '</P_58>' + nl
            r = r + '    <P_68>1</P_68>' + nl
         ELSEIF P99abc > 0
      		r = r + xmlNiePusty(P99abc, '    <P_59>' + TKwotaCNieujemna(P99abc) + '</P_59>' + nl)
         ELSEIF P99ab > 0
      		r = r + xmlNiePusty(P99ab, '    <P_60>' + TKwotaCNieujemna(P99ab) + '</P_60>' + nl)
         ELSEIF P99b > 0
      		r = r + xmlNiePusty(P99b, '    <P_61>' + TKwotaCNieujemna(P99b) + '</P_61>' + nl)
         ENDIF
      ENDIF
		r = r + xmlNiePusty(P99d, '    <P_62>' + TKwotaCNieujemna(P99d) + '</P_62>' + nl)
      IF zf2='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_66>1</P_66>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl

      IF aDane[ 'VATZD' ][ 'rob' ]
         r = r + '    <P_69>1</P_69>' + nl
      ENDIF

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_72>' + zAdrEMail + '</P_72>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_73>' + AllTrim(zDEKLTEL) + '</P_73>' + nl
      ENDIF
		//r = r + '    <P_76>' + date2strxml(Date()) + '</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZD' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3v2(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZD' ][ 'rob' ]
            r += edek_vat_zd1( aDane[ 'VATZD' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7_20( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2019/11/08/8836/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7 (20)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7</KodFormularza>' + nl
      r = r + '    <WariantFormularza>20</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(p5a) + '</Miesiac>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
//			r = r + '      <REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P4) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</Nazwisko>' + nl
//			r = r + '      <DataUrodzenia>' + date2strxml(P11d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl
		r = r + xmlNiePusty(zKOL39, '    <P_39>' + TKwotaCNieujemna(zKOL39) + '</P_39>' + nl)
		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl
		r = r + xmlNiePusty(P99a, '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99, '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl)
      IF P99c > 0
   		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
         IF zZwrRaVAT > 0
      		r = r + '    <P_58>' + TKwotaCNieujemna(zZwrRaVAT) + '</P_58>' + nl
            r = r + '    <P_68>1</P_68>' + nl
         ELSEIF P99abc > 0
      		r = r + xmlNiePusty(P99abc, '    <P_59>' + TKwotaCNieujemna(P99abc) + '</P_59>' + nl)
         ELSEIF P99ab > 0
      		r = r + xmlNiePusty(P99ab, '    <P_60>' + TKwotaCNieujemna(P99ab) + '</P_60>' + nl)
         ELSEIF P99b > 0
      		r = r + xmlNiePusty(P99b, '    <P_61>' + TKwotaCNieujemna(P99b) + '</P_61>' + nl)
         ENDIF
      ENDIF
		r = r + xmlNiePusty(P99d, '    <P_62>' + TKwotaCNieujemna(P99d) + '</P_62>' + nl)
      IF zf2='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_66>1</P_66>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl

      IF lSplitPayment
         r = r + '    <P_69>1</P_69>' + nl
      ENDIF

      IF aDane[ 'VATZD' ][ 'rob' ]
         r = r + '    <P_70>1</P_70>' + nl
      ENDIF

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_73>' + zAdrEMail + '</P_73>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_74>' + AllTrim(zDEKLTEL) + '</P_74>' + nl
      ENDIF
		//r = r + '    <P_76>' + date2strxml(Date()) + '</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZD' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3v2(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZD' ][ 'rob' ]
            r += edek_vat_zd1( aDane[ 'VATZD' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat7k_14( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2019/11/08/8838/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-7K (14)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-7K</KodFormularza>' + nl
      r = r + '    <WariantFormularza>14</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(P4)) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(P8)) + '</PelnaNazwa>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      else
		   r = r + '    <OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <NIP>' + trimnip(P4) + '</NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</Nazwisko>' + nl
//			r = r + '      <DataUrodzenia>' + date2strxml(P11d) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
		r = r + '    <P_10>' + TKwotaC(P64) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC(P64exp) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC(P64expue) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC(P67) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC(P67art129) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC(P61+P61a) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC(P62+P62a) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC(P69) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC(P70) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC(P71) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC(P72) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC(P65ue) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC(P65) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC(P65dekue) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC(P65vdekue) + '</P_24>' + nl
		r = r + '    <P_25>' + TKwotaC(P65dekit) + '</P_25>' + nl
		r = r + '    <P_26>' + TKwotaC(P65vdekit) + '</P_26>' + nl
		r = r + '    <P_27>' + TKwotaC(P65dekus) + '</P_27>' + nl
		r = r + '    <P_28>' + TKwotaC(P65vdekus) + '</P_28>' + nl
		r = r + '    <P_29>' + TKwotaC(P65dekusu) + '</P_29>' + nl
		r = r + '    <P_30>' + TKwotaC(P65vdekusu) + '</P_30>' + nl
		r = r + '    <P_31>' + TKwotaC(SEK_CV7net) + '</P_31>' + nl
		r = r + '    <P_32>' + TKwotaC(0) + '</P_32>' + nl
		r = r + '    <P_33>' + TKwotaC(0) + '</P_33>' + nl
		r = r + '    <P_34>' + TKwotaC(P65dekwe) + '</P_34>' + nl
		r = r + '    <P_35>' + TKwotaC(P65vdekwe) + '</P_35>' + nl
		r = r + '    <P_36>' + TKwotaCNieujemna(Pp12) + '</P_36>' + nl
		r = r + '    <P_37>' + TKwotaCNieujemna( art111u6 ) + '</P_37>' + nl
		r = r + '    <P_38>' + TKwotaCNieujemna(znowytran) + '</P_38>' + nl
		r = r + xmlNiePusty(zKOL39, '    <P_39>' + TKwotaCNieujemna(zKOL39) + '</P_39>' + nl)
		r = r + '    <P_40>' + TKwotaC(P75) + '</P_40>' + nl
		r = r + '    <P_41>' + TKwotaC(P76) + '</P_41>' + nl
		r = r + xmlNiePusty(Pp8, '    <P_42>' + TKwotaCNieujemna(Pp8) + '</P_42>' + nl)
		r = r + '    <P_43>' + TKwotaC(P45dek) + '</P_43>' + nl
		r = r + '    <P_44>' + TKwotaC(P46dek) + '</P_44>' + nl
		r = r + '    <P_45>' + TKwotaC(P49dek) + '</P_45>' + nl
		r = r + '    <P_46>' + TKwotaC(P50dek) + '</P_46>' + nl
		r = r + xmlNiePusty(zkorekst, '    <P_47>' + TKwotaC(zkorekst) + '</P_47>' + nl)
		r = r + xmlNiePusty(zkorekpoz, '    <P_48>' + TKwotaC(zkorekpoz) + '</P_48>' + nl)
		r = r + xmlNiePusty(art89b1, '    <P_49>' + TKwotaC(art89b1) + '</P_49>' + nl)
		r = r + xmlNiePusty(art89b4, '    <P_50>' + TKwotaC(art89b4) + '</P_50>' + nl)
		r = r + xmlNiePusty(P79, '    <P_51>' + TKwotaC(P79) + '</P_51>' + nl)
		r = r + xmlNiePusty(P98a, '    <P_52>' + TKwotaCNieujemna(P98a) + '</P_52>' + nl)
		r = r + xmlNiePusty(pp13, '    <P_53>' + TKwotaCNieujemna(pp13) + '</P_53>' + nl)
		r = r + '    <P_54>' + TKwotaCNieujemna(P98b) + '</P_54>' + nl
		r = r + xmlNiePusty(P99a, '    <P_55>' + TKwotaCNieujemna(P99a) + '</P_55>' + nl)
		r = r + xmlNiePusty(P99, '    <P_56>' + TKwotaCNieujemna(P99) + '</P_56>' + nl)
      IF P99c > 0
   		r = r + '    <P_57>' + TKwotaCNieujemna(P99c) + '</P_57>' + nl
         IF zZwrRaVAT > 0
      		r = r + '    <P_58>' + TKwotaCNieujemna(zZwrRaVAT) + '</P_58>' + nl
            r = r + '    <P_68>1</P_68>' + nl
         ELSEIF P99abc > 0
      		r = r + xmlNiePusty(P99abc, '    <P_59>' + TKwotaCNieujemna(P99abc) + '</P_59>' + nl)
         ELSEIF P99ab > 0
      		r = r + xmlNiePusty(P99ab, '    <P_60>' + TKwotaCNieujemna(P99ab) + '</P_60>' + nl)
         ELSEIF P99b > 0
      		r = r + xmlNiePusty(P99b, '    <P_61>' + TKwotaCNieujemna(P99b) + '</P_61>' + nl)
         ENDIF
      ENDIF
		r = r + xmlNiePusty(P99d, '    <P_62>' + TKwotaCNieujemna(P99d) + '</P_62>' + nl)
      IF zf2='T'
   		r = r + '    <P_63>1</P_63>' + nl
      ENDIF
      IF zf3='T'
   		r = r + '    <P_64>1</P_64>' + nl
      ENDIF
      IF zf4='T'
   		r = r + '    <P_65>1</P_65>' + nl
      ENDIF
      IF zf5='T'
   		r = r + '    <P_66>1</P_66>' + nl
      ENDIF
//		r = r + '    <P_60>2</P_60>' + nl
//		r = r + '    <P_61>2</P_61>' + nl
//		r = r + '    <P_62>2</P_62>' + nl
//		r = r + '    <P_63>2</P_63>' + nl

      IF lSplitPayment
         r = r + '    <P_69>1</P_69>' + nl
      ENDIF

      IF aDane[ 'VATZD' ][ 'rob' ]
         r = r + '    <P_70>1</P_70>' + nl
      ENDIF

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_73>' + zAdrEMail + '</P_73>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_74>' + AllTrim(zDEKLTEL) + '</P_74>' + nl
      ENDIF
		//r = r + '    <P_76>' + date2strxml(Date()) + '</P_76>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 ) .OR. aDane[ 'VATZD' ][ 'rob' ]
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3v2(tresc_korekty_vat7) + nl
         ENDIF
         IF aDane[ 'VATZD' ][ 'rob' ]
            r += edek_vat_zd1( aDane[ 'VATZD' ] )
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vatue_3()
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2013/06/18/1215/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodSystemowy="VAT-UE (3)" wersjaSchemy="1-0E">VAT-UE</KodFormularza>' + nl
      r = r + '    <WariantFormularza>3</WariantFormularza>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      IF zUEOKRES == 'K'
         r = r + '    <Kwartal>' + AllTrim(p5a) + '</Kwartal>' + nl
      ELSE
         r = r + '    <Miesiac>' + AllTrim(miesiac) + '</Miesiac>' + nl
      ENDIF
		r = r + '    <CelZlozenia>1</CelZlozenia>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(P4)) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
      IF Len(aUEs) > 0
         FOR i := 1 TO Len(aUEs)
            r = r + '    <Grupa1>' + nl
            r = r + '      <P_Da>' + AllTrim(aUEs[i, 1]) + '</P_Da>' + nl
            r = r + '      <P_Db>' + edekNipUE(AllTrim(aUEs[i, 2])) + '</P_Db>' + nl
            r = r + '      <P_Dc>' + TKwotaC(aUEs[i, 3]) + '</P_Dc>' + nl
            r = r + '      <P_Dd>' + iif(aUEs[i, 4], '2', '1') + '</P_Dd>' + nl
            r = r + '    </Grupa1>' + nl
         NEXT
      ENDIF
      IF Len(aUEz) > 0
         FOR i := 1 TO Len(aUEz)
            r = r + '    <Grupa2>' + nl
            r = r + '      <P_Na>' + AllTrim(aUEz[i, 1]) + '</P_Na>' + nl
            r = r + '      <P_Nb>' + edekNipUE(AllTrim(aUEz[i, 2])) + '</P_Nb>' + nl
            r = r + '      <P_Nc>' + TKwotaC(aUEz[i, 3]) + '</P_Nc>' + nl
            r = r + '      <P_Nd>' + iif(aUEz[i, 4], '2', '1') + '</P_Nd>' + nl
            r = r + '    </Grupa2>' + nl
         NEXT
      ENDIF
      IF Len(aUEu) > 0
         FOR i := 1 TO Len(aUEu)
            r = r + '    <Grupa3>' + nl
            r = r + '      <P_Ua>' + AllTrim(aUEu[i, 1]) + '</P_Ua>' + nl
            r = r + '      <P_Ub>' + edekNipUE(AllTrim(aUEu[i, 2])) + '</P_Ub>' + nl
            r = r + '      <P_Uc>' + TKwotaC(aUEu[i, 3]) + '</P_Uc>' + nl
            r = r + '    </Grupa3>' + nl
         NEXT
      ENDIF
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vatue_4()
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2017/01/11/3846/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodSystemowy="VAT-UE (4)" wersjaSchemy="1-0E">VAT-UE</KodFormularza>' + nl
      r = r + '    <WariantFormularza>4</WariantFormularza>' + nl
      r = r + '    <Rok>' + AllTrim(p5b) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(miesiac) + '</Miesiac>' + nl
		r = r + '    <CelZlozenia>1</CelZlozenia>' + nl
		r = r + '    <KodUrzedu>' + P6a + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF spolka_
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(P4)) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(P8n)) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip(P4) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml(naz_imie_imie(AllTrim(P8ni))) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(naz_imie_naz(AllTrim(P8ni))) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(P11d) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
      IF Len(aUEs) > 0
         FOR i := 1 TO Len(aUEs)
            r = r + '    <Grupa1>' + nl
            r = r + '      <P_Da>' + AllTrim(aUEs[i, 1]) + '</P_Da>' + nl
            r = r + '      <P_Db>' + edekNipUE(AllTrim(aUEs[i, 2])) + '</P_Db>' + nl
            r = r + '      <P_Dc>' + TKwotaC(aUEs[i, 3]) + '</P_Dc>' + nl
            r = r + '      <P_Dd>' + iif(aUEs[i, 4], '2', '1') + '</P_Dd>' + nl
            r = r + '    </Grupa1>' + nl
         NEXT
      ENDIF
      IF Len(aUEz) > 0
         FOR i := 1 TO Len(aUEz)
            r = r + '    <Grupa2>' + nl
            r = r + '      <P_Na>' + AllTrim(aUEz[i, 1]) + '</P_Na>' + nl
            r = r + '      <P_Nb>' + edekNipUE(AllTrim(aUEz[i, 2])) + '</P_Nb>' + nl
            r = r + '      <P_Nc>' + TKwotaC(aUEz[i, 3]) + '</P_Nc>' + nl
            r = r + '      <P_Nd>' + iif(aUEz[i, 4], '2', '1') + '</P_Nd>' + nl
            r = r + '    </Grupa2>' + nl
         NEXT
      ENDIF
      IF Len(aUEu) > 0
         FOR i := 1 TO Len(aUEu)
            r = r + '    <Grupa3>' + nl
            r = r + '      <P_Ua>' + AllTrim(aUEu[i, 1]) + '</P_Ua>' + nl
            r = r + '      <P_Ub>' + edekNipUE(AllTrim(aUEu[i, 2])) + '</P_Ub>' + nl
            r = r + '      <P_Uc>' + TKwotaC(aUEu[i, 3]) + '</P_Uc>' + nl
            r = r + '    </Grupa3>' + nl
         NEXT
      ENDIF
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vatuek_4( aDane )
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2017/01/11/3845/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodSystemowy="VATUEK (4)" wersjaSchemy="1-0E">VAT-UEK</KodFormularza>' + nl
      r = r + '    <WariantFormularza>4</WariantFormularza>' + nl
      r = r + '    <Rok>' + aDane[ 'rok' ] + '</Rok>' + nl
      r = r + '    <Miesiac>' + aDane[ 'miesiac' ] + '</Miesiac>' + nl
		r = r + '    <CelZlozenia>1</CelZlozenia>' + nl
		r = r + '    <KodUrzedu>' + aDane[ 'kod_urzedu' ] + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF aDane[ 'spolka' ]
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip( aDane[ 'nip' ] ) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml( aDane[ 'nazwa' ] ) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim( aDane[ 'regon' ] ) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      else
		   r = r + '    <etd:OsobaFizyczna>' + nl
//         IF Len(AllTrim(P30)) = 0
            r = r + '      <etd:NIP>' + trimnip( aDane[ 'nip' ] ) + '</etd:NIP>' + nl
//         ELSE
//    			r = r + '      <etd:PESEL>' + P30 + '</etd:PESEL>' + nl
//         ENDIF
			r = r + '      <etd:ImiePierwsze>' + str2sxml( naz_imie_imie( AllTrim( aDane[ 'imie' ] ) ) ) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml( naz_imie_naz( AllTrim( aDane[ 'nazwisko' ] ) ) ) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml( aDane[ 'data_ur' ] ) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
      IF Len( aDane[ 'poz_c' ] ) > 0
         FOR i := 1 TO Len( aDane[ 'poz_c' ] )
            r = r + '    <Grupa1>' + nl
            IF ! Empty( AllTrim( aDane[ 'poz_c' ][ i ][ 'kraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_c' ][ i ][ 'nip' ] ) )

               r = r + '      <P_DBa>' + AllTrim( aDane[ 'poz_c' ][ i ][ 'kraj' ] ) + '</P_DBa>' + nl
               r = r + '      <P_DBb>' + edekNipUE( AllTrim( aDane[ 'poz_c' ][ i ][ 'nip' ] ) ) + '</P_DBb>' + nl
               r = r + '      <P_DBc>' + TKwotaC( aDane[ 'poz_c' ][ i ][ 'wartosc' ] ) + '</P_DBc>' + nl
               r = r + '      <P_DBd>' + iif( aDane[ 'poz_c' ][ i ][ 'trojstr' ] == 'T', '2', '1' ) + '</P_DBd>' + nl
            ENDIF

            IF ! Empty( AllTrim( aDane[ 'poz_c' ][ i ][ 'jkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_c' ][ i ][ 'jnip' ] ) )

               r = r + '      <P_DJa>' + AllTrim( aDane[ 'poz_c' ][ i ][ 'jkraj' ] ) + '</P_DJa>' + nl
               r = r + '      <P_DJb>' + edekNipUE( AllTrim( aDane[ 'poz_c' ][ i ][ 'jnip' ] ) ) + '</P_DJb>' + nl
               r = r + '      <P_DJc>' + TKwotaC( aDane[ 'poz_c' ][ i ][ 'jwartosc' ] ) + '</P_DJc>' + nl
               r = r + '      <P_DJd>' + iif( aDane[ 'poz_c' ][ i ][ 'jtrojstr' ] == 'T', '2', '1' ) + '</P_DJd>' + nl
            ENDIF
            r = r + '    </Grupa1>' + nl
         NEXT
      ENDIF
      IF Len( aDane[ 'poz_d' ] ) > 0
         FOR i := 1 TO Len( aDane[ 'poz_d' ] )
            r = r + '    <Grupa2>' + nl
            IF ! Empty( AllTrim( aDane[ 'poz_d' ][ i ][ 'kraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_d' ][ i ][ 'nip' ] ) )

               r = r + '      <P_NBa>' + AllTrim( aDane[ 'poz_d' ][ i ][ 'kraj' ] ) + '</P_NBa>' + nl
               r = r + '      <P_NBb>' + edekNipUE( AllTrim( aDane[ 'poz_d' ][ i ][ 'nip' ] ) ) + '</P_NBb>' + nl
               r = r + '      <P_NBc>' + TKwotaC( aDane[ 'poz_d' ][ i ][ 'wartosc' ] ) + '</P_NBc>' + nl
               r = r + '      <P_NBd>' + iif( aDane[ 'poz_d' ][ i ][ 'trojstr' ] == 'T', '2', '1' ) + '</P_NBd>' + nl
            ENDIF

            IF ! Empty( AllTrim( aDane[ 'poz_d' ][ i ][ 'jkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_d' ][ i ][ 'jnip' ] ) )

               r = r + '      <P_NJa>' + AllTrim( aDane[ 'poz_d' ][ i ][ 'jkraj' ] ) + '</P_NJa>' + nl
               r = r + '      <P_NJb>' + edekNipUE( AllTrim( aDane[ 'poz_d' ][ i ][ 'jnip' ] ) ) + '</P_NJb>' + nl
               r = r + '      <P_NJc>' + TKwotaC( aDane[ 'poz_d' ][ i ][ 'jwartosc' ] ) + '</P_NJc>' + nl
               r = r + '      <P_NJd>' + iif( aDane[ 'poz_d' ][ i ][ 'jtrojstr' ] == 'T', '2', '1' ) + '</P_NJd>' + nl
            ENDIF
            r = r + '    </Grupa2>' + nl
         NEXT
      ENDIF
      IF Len( aDane[ 'poz_e' ] ) > 0
         FOR i := 1 TO Len( aDane[ 'poz_e' ] )
            r = r + '    <Grupa3>' + nl
            IF ! Empty( AllTrim( aDane[ 'poz_e' ][ i ][ 'kraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_e' ][ i ][ 'nip' ] ) )

               r = r + '      <P_UBa>' + AllTrim( aDane[ 'poz_e' ][ i ][ 'kraj' ] ) + '</P_UBa>' + nl
               r = r + '      <P_UBb>' + edekNipUE( AllTrim( aDane[ 'poz_e' ][ i ][ 'nip' ] ) ) + '</P_UBb>' + nl
               r = r + '      <P_UBc>' + TKwotaC( aDane[ 'poz_e' ][ i ][ 'wartosc' ] ) + '</P_UBc>' + nl
            ENDIF

            IF ! Empty( AllTrim( aDane[ 'poz_e' ][ i ][ 'jkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_e' ][ i ][ 'jnip' ] ) )

               r = r + '      <P_UJa>' + AllTrim( aDane[ 'poz_e' ][ i ][ 'jkraj' ] ) + '</P_UJa>' + nl
               r = r + '      <P_UJb>' + edekNipUE( AllTrim( aDane[ 'poz_e' ][ i ][ 'jnip' ] ) ) + '</P_UJb>' + nl
               r = r + '      <P_UJc>' + TKwotaC( aDane[ 'poz_e' ][ i ][ 'jwartosc' ] ) + '</P_UJc>' + nl
            ENDIF
            r = r + '    </Grupa3>' + nl
         NEXT
      ENDIF
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat27_1(hDane)
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      IF hDane['kwartalnie']
         r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2015/09/04/2566/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      ELSE
         r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2015/09/04/2565/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
      ENDIF
      r = r + '  <Naglowek>' + nl
      IF hDane['kwartalnie']
         r = r + '    <KodFormularza kodSystemowy="VAT27K (1)" wersjaSchemy="1-1E" kodPodatku="VAT" rodzajZobowiazania="Z">VAT-27</KodFormularza>' + nl
      ELSE
         r = r + '    <KodFormularza kodSystemowy="VAT-27 (1)" wersjaSchemy="1-1E" kodPodatku="VAT" rodzajZobowiazania="Z">VAT-27</KodFormularza>' + nl
      ENDIF
      r = r + '    <WariantFormularza>1</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_8">1</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(hDane['rok']) + '</Rok>' + nl
      IF hDane['kwartalnie']
         r = r + '    <Kwartal>' + AllTrim(Str(hDane['kwartal'], 2)) + '</Kwartal>' + nl
      ELSE
         r = r + '    <Miesiac>' + AllTrim(Str(hDane['miesiac'], 3)) + '</Miesiac>' + nl
      ENDIF
		r = r + '    <KodUrzedu>' + AllTrim(hDane['kodurzedu']) + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF hDane['spolka']
         r = r + '    <OsobaNiefizyczna>' + nl
			r = r + '      <NIP>' + trimnip(AllTrim(hDane['nip'])) + '</NIP>' + nl
			r = r + '      <PelnaNazwa>' + str2sxml(AllTrim(hDane['nazwa'])) + '</PelnaNazwa>' + nl
			r = r + '      <REGON>' +  AllTrim(hDane['regon']) + '</REGON>' + nl
		   r = r + '    </OsobaNiefizyczna>' + nl
      ELSE
		   r = r + '    <OsobaFizyczna>' + nl
         r = r + '      <NIP>' + trimnip(hDane['nip']) + '</NIP>' + nl
			r = r + '      <ImiePierwsze>' + str2sxml(hDane['imie']) + '</ImiePierwsze>' + nl
			r = r + '      <Nazwisko>' + str2sxml(hDane['nazwisko']) +'</Nazwisko>' + nl
			r = r + '      <DataUrodzenia>' + date2strxml(hDane['data_ur']) + '</DataUrodzenia>' + nl
		   r = r + '    </OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
      IF Len(hDane['pozycje']) > 0
         FOR i := 1 TO Len(hDane['pozycje'])
            r = r + '    <Grupa_C typ="G">' + nl
            r = r + '      <P_C2>' + str2sxml(AllTrim(hDane['pozycje'][i]['nazwa'])) + '</P_C2>' + nl
            r = r + '      <P_C3>' + trimnip(AllTrim(hDane['pozycje'][i]['nip'])) + '</P_C3>' + nl
            r = r + '      <P_C4>' + TKwota2(hDane['pozycje'][i]['wartosc']) + '</P_C4>' + nl
            r = r + '    </Grupa_C>' + nl
         NEXT
      ENDIF
      r = r + '    <P_11>' + TKwota2(hDane['suma_d']) + '</P_11>' + nl
      IF Len(hDane['pozycje_u']) > 0
         FOR i := 1 TO Len(hDane['pozycje_u'])
            r = r + '    <Grupa_D typ="G">' + nl
            r = r + '      <P_D2>' + str2sxml(AllTrim(hDane['pozycje_u'][i]['nazwa'])) + '</P_D2>' + nl
            r = r + '      <P_D3>' + trimnip(AllTrim(hDane['pozycje_u'][i]['nip'])) + '</P_D3>' + nl
            r = r + '      <P_D4>' + TKwota2(hDane['pozycje_u'][i]['wartosc']) + '</P_D4>' + nl
            r = r + '    </Grupa_D>' + nl
         NEXT
      ENDIF
      r = r + '    <P_12>' + TKwota2(hDane['suma_u']) + '</P_12>' + nl
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat27_2(hDane)
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2017/01/11/3844/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodSystemowy="VAT-27 (2)" wersjaSchemy="1-0E" kodPodatku="VAT" rodzajZobowiazania="Z">VAT-27</KodFormularza>' + nl
      r = r + '    <WariantFormularza>2</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + hDane[ 'cel' ] + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(hDane['rok']) + '</Rok>' + nl
      r = r + '    <Miesiac>' + AllTrim(Str(hDane['miesiac'], 3)) + '</Miesiac>' + nl
		r = r + '    <KodUrzedu>' + AllTrim(hDane['kodurzedu']) + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="Podatnik">' + nl
      IF hDane['spolka']
         r = r + '    <etd:OsobaNiefizyczna>' + nl
			r = r + '      <etd:NIP>' + trimnip(AllTrim(hDane['nip'])) + '</etd:NIP>' + nl
			r = r + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(hDane['nazwa'])) + '</etd:PelnaNazwa>' + nl
			r = r + '      <etd:REGON>' +  AllTrim(hDane['regon']) + '</etd:REGON>' + nl
		   r = r + '    </etd:OsobaNiefizyczna>' + nl
      ELSE
		   r = r + '    <etd:OsobaFizyczna>' + nl
         r = r + '      <etd:NIP>' + trimnip(hDane['nip']) + '</etd:NIP>' + nl
			r = r + '      <etd:ImiePierwsze>' + str2sxml(hDane['imie']) + '</etd:ImiePierwsze>' + nl
			r = r + '      <etd:Nazwisko>' + str2sxml(hDane['nazwisko']) +'</etd:Nazwisko>' + nl
			r = r + '      <etd:DataUrodzenia>' + date2strxml(hDane['data_ur']) + '</etd:DataUrodzenia>' + nl
		   r = r + '    </etd:OsobaFizyczna>' + nl
      ENDIF
      r = r + '  </Podmiot1>' + nl
      r = r + '  <PozycjeSzczegolowe>' + nl
      IF Len(hDane['pozycje']) > 0
         FOR i := 1 TO Len(hDane['pozycje'])
            r = r + '    <Grupa_C typ="G">' + nl
            IF hDane[ 'pozycje' ][ i ][ 'zmiana' ]
               r = r + '      <P_C1>1</P_C1>' + nl
            ENDIF
            r = r + '      <P_C2>' + str2sxml(AllTrim(hDane['pozycje'][i]['nazwa'])) + '</P_C2>' + nl
            r = r + '      <P_C3>' + trimnip(AllTrim(hDane['pozycje'][i]['nip'])) + '</P_C3>' + nl
            r = r + '      <P_C4>' + TKwota2(hDane['pozycje'][i]['wartosc']) + '</P_C4>' + nl
            r = r + '    </Grupa_C>' + nl
         NEXT
      ENDIF
      r = r + '    <P_10>' + TKwota2(hDane['suma_d']) + '</P_10>' + nl
      IF Len(hDane['pozycje_u']) > 0
         FOR i := 1 TO Len(hDane['pozycje_u'])
            r = r + '    <Grupa_D typ="G">' + nl
            IF hDane[ 'pozycje_u' ][ i ][ 'zmiana' ]
               r = r + '      <P_D1>1</P_D1>' + nl
            ENDIF
            r = r + '      <P_D2>' + str2sxml(AllTrim(hDane['pozycje_u'][i]['nazwa'])) + '</P_D2>' + nl
            r = r + '      <P_D3>' + trimnip(AllTrim(hDane['pozycje_u'][i]['nip'])) + '</P_D3>' + nl
            r = r + '      <P_D4>' + TKwota2(hDane['pozycje_u'][i]['wartosc']) + '</P_D4>' + nl
            r = r + '    </Grupa_D>' + nl
         NEXT
      ENDIF
      r = r + '    <P_11>' + TKwota2(hDane['suma_u']) + '</P_11>' + nl
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ord_zu2(sUzasadnienieP13)
   LOCAL r, nl
   nl := Chr(13) + Chr(10)
   r = '  <zzu:Zalacznik_ORD-ZU xmlns:zzu="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/10/07/eD/ORDZU/">' + nl
   r = r + '    <zzu:Naglowek>' + nl
   r = r + '      <zzu:KodFormularza kodSystemowy="ORD-ZU (2)" wersjaSchemy="2-0E">ORD-ZU</zzu:KodFormularza>' + nl
   r = r + '      <zzu:WariantFormularza>2</zzu:WariantFormularza>' + nl
   r = r + '    </zzu:Naglowek>' + nl
   r = r + '    <zzu:PozycjeSzczegolowe>' + nl
   r = r + '       <zzu:P_13>' + str2sxml(sUzasadnienieP13) + '</zzu:P_13>' + nl
   r = r + '    </zzu:PozycjeSzczegolowe>' + nl
   r = r + '  </zzu:Zalacznik_ORD-ZU>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ord_zu3(sUzasadnienieP13)
   LOCAL r, nl
   nl := Chr(13) + Chr(10)
   r = '  <zzu:Zalacznik_ORD-ZU xmlns:zzu="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/02/05/eD/ORDZU/">' + nl
   r = r + '    <zzu:Naglowek>' + nl
   r = r + '      <zzu:KodFormularza kodSystemowy="ORD-ZU (3)" wersjaSchemy="1-0E">ORD-ZU</zzu:KodFormularza>' + nl
   r = r + '      <zzu:WariantFormularza>3</zzu:WariantFormularza>' + nl
   r = r + '    </zzu:Naglowek>' + nl
   r = r + '    <zzu:PozycjeSzczegolowe>' + nl
   r = r + '       <zzu:P_13>' + str2sxml(sUzasadnienieP13) + '</zzu:P_13>' + nl
   r = r + '    </zzu:PozycjeSzczegolowe>' + nl
   r = r + '  </zzu:Zalacznik_ORD-ZU>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ord_zu3v2(sUzasadnienieP13)
   LOCAL r, nl
   nl := Chr(13) + Chr(10)
   r = '  <zzu:Zalacznik_ORD-ZU xmlns:zzu="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/ORDZU/">' + nl
   r = r + '    <zzu:Naglowek>' + nl
   r = r + '      <zzu:KodFormularza kodSystemowy="ORD-ZU (3)" wersjaSchemy="2-0E">ORD-ZU</zzu:KodFormularza>' + nl
   r = r + '      <zzu:WariantFormularza>3</zzu:WariantFormularza>' + nl
   r = r + '    </zzu:Naglowek>' + nl
   r = r + '    <zzu:PozycjeSzczegolowe>' + nl
   r = r + '       <zzu:P_13>' + str2sxml(sUzasadnienieP13) + '</zzu:P_13>' + nl
   r = r + '    </zzu:PozycjeSzczegolowe>' + nl
   r = r + '  </zzu:Zalacznik_ORD-ZU>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ift1_13( aDane )
   LOCAL r, nl := Chr( 13 ) + Chr( 10 )
   r := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   IF aDane[ 'Parametry' ][ 'Roczny' ]
      r := r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2016/01/20/3128/">' + nl
   ELSE
      r := r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2016/01/20/3129/">' + nl
   ENDIF
   r := r + '  <Naglowek>' + nl
   IF aDane[ 'Parametry' ][ 'Roczny' ]
      r := r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="IFT-1R (13)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">IFT-1/IFT-1R</KodFormularza>'
   ELSE
      r := r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="IFT-1 (13)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">IFT-1/IFT-1R</KodFormularza>'
   ENDIF
   r := r + '    <WariantFormularza>13</WariantFormularza>' + nl
   r := r + '    <CelZlozenia poz="P_7">' + iif( aDane[ 'Parametry' ][ 'Korekta' ], '2', '1' ) + '</CelZlozenia>' + nl
   r := r + '    <OkresOd poz="P_4">' + date2strxml( aDane[ 'Parametry' ][ 'DataOd' ] ) + '</OkresOd>' + nl
   r := r + '    <OkresDo poz="P_5">' + date2strxml( aDane[ 'Parametry' ][ 'DataDo' ] ) + '</OkresDo>' + nl
   r := r + '    <KodUrzedu>' + str2sxml( aDane[ 'Dane' ][ 'KodUrzedu' ] ) + '</KodUrzedu>' + nl
   r := r + '  </Naglowek>' + nl
   r := r + '  <Podmiot1 rola="' + str2sxml( 'Pˆatnik/Podmiot Wypˆacaj¥cy' ) + '">' + nl
   IF aDane[ 'Dane' ][ 'FirmaSpolka' ]
      r := r + '    <OsobaNiefizyczna>' + nl
      r := r + '      <etd:NIP xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + trimnip( str2sxml( aDane[ 'Dane' ][ 'FirmaNIP' ] ) ) + '</etd:NIP>' + nl
      r := r + '      <etd:PelnaNazwa xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'FirmaNazwa' ] ) + '</etd:PelnaNazwa>' + nl
      r := r + '      <etd:REGON xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'FirmaREGON' ] ) + '</etd:REGON>' + nl
      r := r + '    </OsobaNiefizyczna>' + nl
   ELSE
      r := r + '    <OsobaFizyczna>' + nl
      r := r + '      <NIP>' + trimnip( str2sxml( aDane[ 'Dane' ][ 'FirmaNIP' ] ) ) + '</NIP>' + nl
      r := r + '      <ImiePierwsze>' + str2sxml( aDane[ 'Dane' ][ 'FirmaImie' ] ) + '</ImiePierwsze>' + nl
      r := r + '      <Nazwisko>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNazwisko' ] ) + '</Nazwisko>' + nl
      r := r + '      <DataUrodzenia>' + date2strxml( aDane[ 'Dane' ][ 'FirmaData' ] ) + '</DataUrodzenia>' + nl
      r := r + '    </OsobaFizyczna>' + nl
   ENDIF
   r := r + '    <AdresZamieszkaniaSiedziby rodzajAdresu="RAD">' + nl
   r := r + '      <etd:AdresPol xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + nl
   r := r + '        <etd:KodKraju>PL</etd:KodKraju>' + nl
   r := r + '        <etd:Wojewodztwo>' + str2sxml( aDane[ 'Dane' ][ 'FirmaWojewodztwo' ] ) + '</etd:Wojewodztwo>' + nl
   r := r + '        <etd:Powiat>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPowiat' ] ) + '</etd:Powiat>' + nl
   r := r + '        <etd:Gmina>' + str2sxml( aDane[ 'Dane' ][ 'FirmaGmina' ] ) + '</etd:Gmina>' + nl
   r := r + '        <etd:Ulica>' + str2sxml( aDane[ 'Dane' ][ 'FirmaUlica' ] ) + '</etd:Ulica>' + nl
   r := r + '        <etd:NrDomu>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNrDomu' ] ) + '</etd:NrDomu>' + nl
   IF Len( aDane[ 'Dane' ][ 'FirmaNrLokalu' ] ) > 0
      r := r + '        <etd:NrLokalu>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNrDomu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r := r + '        <etd:Miejscowosc>' + str2sxml( aDane[ 'Dane' ][ 'FirmaMiejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r := r + '        <etd:KodPocztowy>' + str2sxml( aDane[ 'Dane' ][ 'FirmaKodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   r := r + '        <etd:Poczta>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPoczta' ] ) + '</etd:Poczta>' + nl
   r := r + '      </etd:AdresPol>' + nl
   r := r + '    </AdresZamieszkaniaSiedziby>' + nl
   r := r + '  </Podmiot1>' + nl
   r := r + '  <Podmiot2 rola="' + str2sxml( 'Odbiorca Nale¾no˜ci' ) + '">' + nl
   r := r + '    <OsobaFizZagr>' + nl
   r := r + '      <ImiePierwsze>' + str2sxml( aDane[ 'Dane' ][ 'OsobaImiePierwsze' ] ) + '</ImiePierwsze>' + nl
   r := r + '      <Nazwisko>' + str2sxml( aDane[ 'Dane' ][ 'OsobaNazwisko' ] ) + '</Nazwisko>' + nl
   r := r + '      <DataUrodzenia>' + date2strxml( aDane[ 'Dane' ][ 'OsobaDataUrodzenia' ] ) + '</DataUrodzenia>' + nl
   r := r + '      <MiejsceUrodzenia>' + str2sxml( aDane[ 'Dane' ][ 'OsobaMiejsceUrodzenia' ] ) + '</MiejsceUrodzenia>' + nl
   r := r + '      <ImieOjca>' + str2sxml( aDane[ 'Dane' ][ 'OsobaImieOjca' ] ) + '</ImieOjca>' + nl
   r := r + '      <ImieMatki>' + str2sxml( aDane[ 'Dane' ][ 'OsobaImieMatki' ] ) + '</ImieMatki>' + nl
   r := r + '      <NrId poz="P_26">' + str2sxml( aDane[ 'Dane' ][ 'OsobaNrId' ] ) + '</NrId>' + nl
   r := r + '      <RodzajNrId poz="P_27">' + aDane[ 'Dane' ][ 'OsobaRodzajNrId' ] + '</RodzajNrId>' + nl
   r := r + '      <KodKrajuWydania poz="P_28A">' + str2sxml( aDane[ 'Dane' ][ 'OsobaKraj' ] ) + '</KodKrajuWydania>' + nl
   r := r + '    </OsobaFizZagr>' + nl
   r := r + '    <AdresZamieszkania rodzajAdresu="RAD">' + nl
   r := r + '      <etd:KodKraju xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaKraj' ] ) + '</etd:KodKraju>' + nl
   r := r + '      <etd:KodPocztowy xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaKodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   r := r + '      <etd:Miejscowosc xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaMiejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r := r + '      <etd:Ulica xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaUlica' ] ) + '</etd:Ulica>' + nl
   r := r + '      <etd:NrDomu xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaNrDomu' ] ) + '</etd:NrDomu>' + nl
   IF Len( aDane[ 'Dane' ][ 'OsobaNrLokalu' ] ) > 0
      r := r + '      <etd:NrLokalu xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaNrLokalu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r := r + '    </AdresZamieszkania>' + nl
   r := r + '  </Podmiot2>' + nl
   r := r + '  <PozycjeSzczegolowe>' + nl
   r := r + '    <P_71>0.00</P_71>' + nl
   r := r + '    <P_72>' + TKwota2Nieujemna( aDane[ 'Dane' ][ 'P_72' ] ) + '</P_72>' + nl
   r := r + '    <P_73>' + TProcentowy( aDane[ 'Dane' ][ 'P_73' ] ) + '</P_73>' + nl
   r := r + '    <P_74>' + TKwota2Nieujemna( aDane[ 'Dane' ][ 'P_74' ] ) + '</P_74>' + nl
   IF ! aDane[ 'Parametry' ][ 'Roczny' ]
      r := r + '    <P_75>' + date2strxml( aDane[ 'Parametry' ][ 'DataZlozenia' ] ) + '</P_75>' + nl
   ENDIF
   r := r + '    <P_76>' + date2strxml( aDane[ 'Parametry' ][ 'DataPrzekazania' ] ) + '</P_76>' + nl
   r := r + '  </PozycjeSzczegolowe>' + nl
   r := r + '  <Pouczenie>' + str2sxml( 'Za uchybienie obowi¥zkom pˆatnika/podmiotu grozi odpowiedzialno˜† przewidziana w Kodeksie karnym skarbowym. [The infringement of tax remitter/entity duties shall be subject to the sanctions provided for the Fiscal Penal Code].' ) + '</Pouczenie>' + nl
   IF aDane[ 'Parametry' ][ 'Korekta' ] .AND. HB_ISCHAR( aDane[ 'ORDZU' ] ) .AND. Len( AllTrim( aDane[ 'ORDZU' ] ) ) > 0
      r := r + '  <Zalaczniki>' + nl
      r := r + edek_ord_zu2( aDane[ 'ORDZU' ] ) + nl
      r := r + '  </Zalaczniki>' + nl
   ENDIF
   r := r + '</Deklaracja>'

   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ift1_15( aDane )
   LOCAL r, nl := Chr( 13 ) + Chr( 10 )
   r := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   IF aDane[ 'Parametry' ][ 'Roczny' ]
      r := r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2019/12/19/8976/">' + nl
   ELSE
      r := r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2019/12/19/8977/">' + nl
   ENDIF
   r := r + '  <Naglowek>' + nl
   IF aDane[ 'Parametry' ][ 'Roczny' ]
      r := r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="IFT-1R (15)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">IFT-1/IFT-1R</KodFormularza>'
   ELSE
      r := r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="IFT-1 (15)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">IFT-1/IFT-1R</KodFormularza>'
   ENDIF
   r := r + '    <WariantFormularza>15</WariantFormularza>' + nl
   r := r + '    <CelZlozenia poz="P_7">' + iif( aDane[ 'Parametry' ][ 'Korekta' ], '2', '1' ) + '</CelZlozenia>' + nl
   r := r + '    <OkresOd poz="P_4">' + date2strxml( aDane[ 'Parametry' ][ 'DataOd' ] ) + '</OkresOd>' + nl
   r := r + '    <OkresDo poz="P_5">' + date2strxml( aDane[ 'Parametry' ][ 'DataDo' ] ) + '</OkresDo>' + nl
   r := r + '    <KodUrzedu>' + str2sxml( aDane[ 'Dane' ][ 'KodUrzedu' ] ) + '</KodUrzedu>' + nl
   r := r + '  </Naglowek>' + nl
   r := r + '  <Podmiot1 rola="' + str2sxml( 'Pˆatnik/Podmiot Wypˆacaj¥cy' ) + '">' + nl
   IF aDane[ 'Dane' ][ 'FirmaSpolka' ]
      r := r + '    <OsobaNiefizyczna>' + nl
      r := r + '      <NIP>' + trimnip( str2sxml( aDane[ 'Dane' ][ 'FirmaNIP' ] ) ) + '</NIP>' + nl
      r := r + '      <PelnaNazwa>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNazwa' ] ) + '</PelnaNazwa>' + nl
      r := r + '    </OsobaNiefizyczna>' + nl
   ELSE
      r := r + '    <OsobaFizyczna>' + nl
      r := r + '      <etd:NIP xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + trimnip( str2sxml( aDane[ 'Dane' ][ 'FirmaNIP' ] ) ) + '</etd:NIP>' + nl
      r := r + '      <etd:ImiePierwsze xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'FirmaImie' ] ) + '</etd:ImiePierwsze>' + nl
      r := r + '      <etd:Nazwisko xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'FirmaNazwisko' ] ) + '</etd:Nazwisko>' + nl
      r := r + '      <etd:DataUrodzenia xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + date2strxml( aDane[ 'Dane' ][ 'FirmaData' ] ) + '</etd:DataUrodzenia>' + nl
      r := r + '    </OsobaFizyczna>' + nl
   ENDIF
   r := r + '    <AdresZamieszkaniaSiedziby rodzajAdresu="RAD">' + nl
   r := r + '      <etd:AdresPol xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
   r := r + '        <etd:KodKraju>PL</etd:KodKraju>' + nl
   r := r + '        <etd:Wojewodztwo>' + str2sxml( aDane[ 'Dane' ][ 'FirmaWojewodztwo' ] ) + '</etd:Wojewodztwo>' + nl
   r := r + '        <etd:Powiat>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPowiat' ] ) + '</etd:Powiat>' + nl
   r := r + '        <etd:Gmina>' + str2sxml( aDane[ 'Dane' ][ 'FirmaGmina' ] ) + '</etd:Gmina>' + nl
   r := r + '        <etd:Ulica>' + str2sxml( aDane[ 'Dane' ][ 'FirmaUlica' ] ) + '</etd:Ulica>' + nl
   r := r + '        <etd:NrDomu>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNrDomu' ] ) + '</etd:NrDomu>' + nl
   IF Len( aDane[ 'Dane' ][ 'FirmaNrLokalu' ] ) > 0
      r := r + '        <etd:NrLokalu>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNrDomu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r := r + '        <etd:Miejscowosc>' + str2sxml( aDane[ 'Dane' ][ 'FirmaMiejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r := r + '        <etd:KodPocztowy>' + str2sxml( aDane[ 'Dane' ][ 'FirmaKodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   //r := r + '        <etd:Poczta>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPoczta' ] ) + '</etd:Poczta>' + nl
   r := r + '      </etd:AdresPol>' + nl
   r := r + '    </AdresZamieszkaniaSiedziby>' + nl
   r := r + '  </Podmiot1>' + nl
   r := r + '  <Podmiot2 rola="' + str2sxml( 'Odbiorca Nale¾no˜ci' ) + '">' + nl
   r := r + '    <OsobaFizZagr>' + nl
   r := r + '      <ImiePierwsze>' + str2sxml( aDane[ 'Dane' ][ 'OsobaImiePierwsze' ] ) + '</ImiePierwsze>' + nl
   r := r + '      <Nazwisko>' + str2sxml( aDane[ 'Dane' ][ 'OsobaNazwisko' ] ) + '</Nazwisko>' + nl
   r := r + '      <DataUrodzenia>' + date2strxml( aDane[ 'Dane' ][ 'OsobaDataUrodzenia' ] ) + '</DataUrodzenia>' + nl
   r := r + '      <MiejsceUrodzenia>' + str2sxml( aDane[ 'Dane' ][ 'OsobaMiejsceUrodzenia' ] ) + '</MiejsceUrodzenia>' + nl
   r := r + '      <ImieOjca>' + str2sxml( aDane[ 'Dane' ][ 'OsobaImieOjca' ] ) + '</ImieOjca>' + nl
   r := r + '      <ImieMatki>' + str2sxml( aDane[ 'Dane' ][ 'OsobaImieMatki' ] ) + '</ImieMatki>' + nl
   r := r + '      <NrId poz="P_25">' + str2sxml( aDane[ 'Dane' ][ 'OsobaNrId' ] ) + '</NrId>' + nl
   r := r + '      <RodzajNrId poz="P_26">' + aDane[ 'Dane' ][ 'OsobaRodzajNrId' ] + '</RodzajNrId>' + nl
   r := r + '      <KodKrajuWydania poz="P_27A">' + str2sxml( aDane[ 'Dane' ][ 'OsobaKraj' ] ) + '</KodKrajuWydania>' + nl
   r := r + '    </OsobaFizZagr>' + nl
   r := r + '    <AdresZamieszkania rodzajAdresu="RAD">' + nl
   r := r + '      <etd:KodKraju xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaKraj' ] ) + '</etd:KodKraju>' + nl
   r := r + '      <etd:KodPocztowy xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaKodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   r := r + '      <etd:Miejscowosc xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaMiejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r := r + '      <etd:Ulica xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaUlica' ] ) + '</etd:Ulica>' + nl
   r := r + '      <etd:NrDomu xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaNrDomu' ] ) + '</etd:NrDomu>' + nl
   IF Len( aDane[ 'Dane' ][ 'OsobaNrLokalu' ] ) > 0
      r := r + '      <etd:NrLokalu xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaNrLokalu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r := r + '    </AdresZamieszkania>' + nl
   r := r + '  </Podmiot2>' + nl
   r := r + '  <PozycjeSzczegolowe>' + nl
   r := r + '    <P_70>0.00</P_70>' + nl
   r := r + '    <P_71>' + TKwota2Nieujemna( aDane[ 'Dane' ][ 'P_71' ] ) + '</P_71>' + nl
   r := r + '    <P_72>' + TProcentowy( aDane[ 'Dane' ][ 'P_72' ] ) + '</P_72>' + nl
   r := r + '    <P_73>' + TKwota2Nieujemna( aDane[ 'Dane' ][ 'P_73' ] ) + '</P_73>' + nl
   IF ! aDane[ 'Parametry' ][ 'Roczny' ]
      r := r + '    <P_74>' + date2strxml( aDane[ 'Parametry' ][ 'DataZlozenia' ] ) + '</P_74>' + nl
   ENDIF
   r := r + '    <P_75>' + date2strxml( aDane[ 'Parametry' ][ 'DataPrzekazania' ] ) + '</P_75>' + nl
   r := r + '  </PozycjeSzczegolowe>' + nl
   r := r + '  <Pouczenie>1</Pouczenie>' + nl
   IF aDane[ 'Parametry' ][ 'Korekta' ] .AND. HB_ISCHAR( aDane[ 'ORDZU' ] ) .AND. Len( AllTrim( aDane[ 'ORDZU' ] ) ) > 0
      r := r + '  <Zalaczniki>' + nl
      r := r + edek_ord_zu2( aDane[ 'ORDZU' ] ) + nl
      r := r + '  </Zalaczniki>' + nl
   ENDIF
   r := r + '</Deklaracja>'

   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat_zz5( aDane )

   LOCAL r, nl := Chr( 13 ) + Chr( 10 )

   r := '    <vzz:Wniosek_VAT-ZZ xmlns:vzz="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/08/03/eD/VATZZ/">' + nl
   r += '      <vzz:Naglowek>' + nl
   r += '        <vzz:KodFormularza kodSystemowy="VAT-ZZ (5)" wersjaSchemy="2-1E">VAT-ZZ</vzz:KodFormularza>' + nl
   r += '        <vzz:WariantFormularza>5</vzz:WariantFormularza>' + nl
   r += '      </vzz:Naglowek>' + nl
   r += '      <vzz:PozycjeSzczegolowe>' + nl
   r += '        <vzz:P_8>' + AllTrim( Str( aDane[ 'P_8' ] ) ) + '</vzz:P_8>' + nl
   r += '        <vzz:P_9>' + TKwota2Nieujemna( aDane[ 'P_9' ] ) + '</vzz:P_9>' + nl
   r += '        <vzz:P_10>' + str2sxml( AllTrim( aDane[ 'P_10' ] ) ) + '</vzz:P_10>' + nl
   r += '      </vzz:PozycjeSzczegolowe>' + nl
   r += '    </vzz:Wniosek_VAT-ZZ>' + nl

   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat_zd1( aDane )

   LOCAL r, nl := Chr( 13 ) + Chr( 10 ), i

   r := '    <vzd:Wniosek_VAT-ZD xmlns:vzd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2019/02/07/eD/VATZD/">' + nl
   r += '      <vzd:Naglowek>' + nl
   r += '        <vzd:KodFormularza kodSystemowy="VAT-ZD (1)" wersjaSchemy="3-0E">VAT-ZD</vzd:KodFormularza>' + nl
   r += '        <vzd:WariantFormularza>1</vzd:WariantFormularza>' + nl
   r += '      </vzd:Naglowek>' + nl
   r += '      <vzd:PozycjeSzczegolowe>' + nl
   FOR i := 1 TO Len( aDane[ 'PB' ] )
      r += '        <vzd:P_B typ="G">' + nl
      r += '          <vzd:P_BB>' + str2sxml( AllTrim( aDane[ 'PB' ][ i ][ 'P_BB' ] ) ) + '</vzd:P_BB>' + nl
      r += '          <vzd:P_BC>' + str2sxml( AllTrim( aDane[ 'PB' ][ i ][ 'P_BC' ] ) ) + '</vzd:P_BC>' + nl
      r += '          <vzd:P_BD1>' + str2sxml( AllTrim( aDane[ 'PB' ][ i ][ 'P_BD1' ] ) ) + '</vzd:P_BD1>' + nl
      r += '          <vzd:P_BD2>' + date2strxml( aDane[ 'PB' ][ i ][ 'P_BD2' ] ) + '</vzd:P_BD2>' + nl
      r += '          <vzd:P_BE>' + date2strxml( aDane[ 'PB' ][ i ][ 'P_BE' ] ) + '</vzd:P_BE>' + nl
      r += '          <vzd:P_BF>' + TKwota2Nieujemna( aDane[ 'PB' ][ i ][ 'P_BF' ] ) + '</vzd:P_BF>' + nl
      r += '          <vzd:P_BG>' + TKwota2Nieujemna( aDane[ 'PB' ][ i ][ 'P_BG' ] ) + '</vzd:P_BG>' + nl
      r += '        </vzd:P_B>' + nl
   NEXT
   r += '        <vzd:P_10>' + TKwotaCNieujemna( aDane[ 'P_10' ] ) + '</vzd:P_10>' + nl
   r += '        <vzd:P_11>' + TKwotaCNieujemna( aDane[ 'P_11' ] ) + '</vzd:P_11>' + nl
   r += '      </vzd:PozycjeSzczegolowe>' + nl
   r += '    </vzd:Wniosek_VAT-ZD>' + nl

   RETURN r

/*----------------------------------------------------------------------*/

