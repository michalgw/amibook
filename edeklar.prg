/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michał Gawrycki (gmsystems.pl)

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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwot z poz. od 157 do 168 lub wpłacenia ich w niepełnej wysokości niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2012 r. poz. 1015, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowiązkom płatnika grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
		r = r + '  <Objasnienie>' + str2sxml('Kwoty podatku i wynagrodzenia przysługującego płatnikom z tytułu terminowego wpłacenia podatku dochodowego, zgodnie z art. 63 Ordynacji podatkowej, zaokrągla się do pełnych złotych.') + '</Objasnienie>' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwot z poz. od 157 do 168 lub wpłacenia ich w niepełnej wysokości niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowiązkom płatnika grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
		r = r + '  <Objasnienie>' + str2sxml('Kwoty podatku i wynagrodzenia przysługującego płatnikom z tytułu terminowego wpłacenia podatku dochodowego, zgodnie z art. 63 Ordynacji podatkowej, zaokrągla się do pełnych złotych.') + '</Objasnienie>' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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

FUNCTION edek_pit4r_10()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2020/11/13/10089/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-4R (10)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-4R</KodFormularza>' + nl
      r = r + '    <WariantFormularza>10</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z801, '    <P_110>' + TKwotaCNieujemna(z801) + '</P_110>' + nl)
		r = r + xmlNiePusty(z802, '    <P_111>' + TKwotaCNieujemna(z802) + '</P_111>' + nl)
		r = r + xmlNiePusty(z803, '    <P_112>' + TKwotaCNieujemna(z803) + '</P_112>' + nl)
		r = r + xmlNiePusty(z804, '    <P_113>' + TKwotaCNieujemna(z804) + '</P_113>' + nl)
		r = r + xmlNiePusty(z805, '    <P_114>' + TKwotaCNieujemna(z805) + '</P_114>' + nl)
		r = r + xmlNiePusty(z806, '    <P_115>' + TKwotaCNieujemna(z806) + '</P_115>' + nl)
		r = r + xmlNiePusty(z807, '    <P_116>' + TKwotaCNieujemna(z807) + '</P_116>' + nl)
		r = r + xmlNiePusty(z808, '    <P_117>' + TKwotaCNieujemna(z808) + '</P_117>' + nl)
		r = r + xmlNiePusty(z809, '    <P_118>' + TKwotaCNieujemna(z809) + '</P_118>' + nl)
		r = r + xmlNiePusty(z810, '    <P_119>' + TKwotaCNieujemna(z810) + '</P_119>' + nl)
		r = r + xmlNiePusty(z811, '    <P_120>' + TKwotaCNieujemna(z811) + '</P_120>' + nl)
		r = r + xmlNiePusty(z812, '    <P_121>' + TKwotaCNieujemna(z812) + '</P_121>' + nl)
		r = r + xmlNiePusty(z1101, '    <P_122>' + TKwotaCNieujemna(z1101) + '</P_122>' + nl)
		r = r + xmlNiePusty(z1102, '    <P_123>' + TKwotaCNieujemna(z1102) + '</P_123>' + nl)
		r = r + xmlNiePusty(z1103, '    <P_124>' + TKwotaCNieujemna(z1103) + '</P_124>' + nl)
		r = r + xmlNiePusty(z1104, '    <P_125>' + TKwotaCNieujemna(z1104) + '</P_125>' + nl)
		r = r + xmlNiePusty(z1105, '    <P_126>' + TKwotaCNieujemna(z1105) + '</P_126>' + nl)
		r = r + xmlNiePusty(z1106, '    <P_127>' + TKwotaCNieujemna(z1106) + '</P_127>' + nl)
		r = r + xmlNiePusty(z1107, '    <P_128>' + TKwotaCNieujemna(z1107) + '</P_128>' + nl)
		r = r + xmlNiePusty(z1108, '    <P_129>' + TKwotaCNieujemna(z1108) + '</P_129>' + nl)
		r = r + xmlNiePusty(z1109, '    <P_130>' + TKwotaCNieujemna(z1109) + '</P_130>' + nl)
		r = r + xmlNiePusty(z1110, '    <P_131>' + TKwotaCNieujemna(z1110) + '</P_131>' + nl)
		r = r + xmlNiePusty(z1111, '    <P_132>' + TKwotaCNieujemna(z1111) + '</P_132>' + nl)
		r = r + xmlNiePusty(z1112, '    <P_133>' + TKwotaCNieujemna(z1112) + '</P_133>' + nl)
		r = r + xmlNiePusty(z1201, '    <P_134>' + TKwotaCNieujemna(z1201) + '</P_134>' + nl)
		r = r + xmlNiePusty(z1202, '    <P_135>' + TKwotaCNieujemna(z1202) + '</P_135>' + nl)
		r = r + xmlNiePusty(z1203, '    <P_136>' + TKwotaCNieujemna(z1203) + '</P_136>' + nl)
		r = r + xmlNiePusty(z1204, '    <P_137>' + TKwotaCNieujemna(z1204) + '</P_137>' + nl)
		r = r + xmlNiePusty(z1205, '    <P_138>' + TKwotaCNieujemna(z1205) + '</P_138>' + nl)
		r = r + xmlNiePusty(z1206, '    <P_139>' + TKwotaCNieujemna(z1206) + '</P_139>' + nl)
		r = r + xmlNiePusty(z1207, '    <P_140>' + TKwotaCNieujemna(z1207) + '</P_140>' + nl)
		r = r + xmlNiePusty(z1208, '    <P_141>' + TKwotaCNieujemna(z1208) + '</P_141>' + nl)
		r = r + xmlNiePusty(z1209, '    <P_142>' + TKwotaCNieujemna(z1209) + '</P_142>' + nl)
		r = r + xmlNiePusty(z1210, '    <P_143>' + TKwotaCNieujemna(z1210) + '</P_143>' + nl)
		r = r + xmlNiePusty(z1211, '    <P_144>' + TKwotaCNieujemna(z1211) + '</P_144>' + nl)
		r = r + xmlNiePusty(z1212, '    <P_145>' + TKwotaCNieujemna(z1212) + '</P_145>' + nl)
		r = r + '    <P_146>' + TKwotaCNieujemna(z1301) + '</P_146>' + nl
		r = r + '    <P_147>' + TKwotaCNieujemna(z1302) + '</P_147>' + nl
		r = r + '    <P_148>' + TKwotaCNieujemna(z1303) + '</P_148>' + nl
		r = r + '    <P_149>' + TKwotaCNieujemna(z1304) + '</P_149>' + nl
		r = r + '    <P_150>' + TKwotaCNieujemna(z1305) + '</P_150>' + nl
		r = r + '    <P_151>' + TKwotaCNieujemna(z1306) + '</P_151>' + nl
		r = r + '    <P_152>' + TKwotaCNieujemna(z1307) + '</P_152>' + nl
		r = r + '    <P_153>' + TKwotaCNieujemna(z1308) + '</P_153>' + nl
		r = r + '    <P_154>' + TKwotaCNieujemna(z1309) + '</P_154>' + nl
		r = r + '    <P_155>' + TKwotaCNieujemna(z1310) + '</P_155>' + nl
		r = r + '    <P_156>' + TKwotaCNieujemna(z1311) + '</P_156>' + nl
		r = r + '    <P_157>' + TKwotaCNieujemna(z1312) + '</P_157>' + nl
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

FUNCTION edek_pit4r_11()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2021/01/05/10281/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-4R (11)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-4R</KodFormularza>' + nl
      r = r + '    <WariantFormularza>11</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z801, '    <P_110>' + TKwotaCNieujemna(z801) + '</P_110>' + nl)
		r = r + xmlNiePusty(z802, '    <P_111>' + TKwotaCNieujemna(z802) + '</P_111>' + nl)
		r = r + xmlNiePusty(z803, '    <P_112>' + TKwotaCNieujemna(z803) + '</P_112>' + nl)
		r = r + xmlNiePusty(z804, '    <P_113>' + TKwotaCNieujemna(z804) + '</P_113>' + nl)
		r = r + xmlNiePusty(z805, '    <P_114>' + TKwotaCNieujemna(z805) + '</P_114>' + nl)
		r = r + xmlNiePusty(z806, '    <P_115>' + TKwotaCNieujemna(z806) + '</P_115>' + nl)
		r = r + xmlNiePusty(z807, '    <P_116>' + TKwotaCNieujemna(z807) + '</P_116>' + nl)
		r = r + xmlNiePusty(z808, '    <P_117>' + TKwotaCNieujemna(z808) + '</P_117>' + nl)
		r = r + xmlNiePusty(z809, '    <P_118>' + TKwotaCNieujemna(z809) + '</P_118>' + nl)
		r = r + xmlNiePusty(z810, '    <P_119>' + TKwotaCNieujemna(z810) + '</P_119>' + nl)
		r = r + xmlNiePusty(z811, '    <P_120>' + TKwotaCNieujemna(z811) + '</P_120>' + nl)
		r = r + xmlNiePusty(z812, '    <P_121>' + TKwotaCNieujemna(z812) + '</P_121>' + nl)
		r = r + xmlNiePusty(z1101, '    <P_122>' + TKwotaCNieujemna(z1101) + '</P_122>' + nl)
		r = r + xmlNiePusty(z1102, '    <P_123>' + TKwotaCNieujemna(z1102) + '</P_123>' + nl)
		r = r + xmlNiePusty(z1103, '    <P_124>' + TKwotaCNieujemna(z1103) + '</P_124>' + nl)
		r = r + xmlNiePusty(z1104, '    <P_125>' + TKwotaCNieujemna(z1104) + '</P_125>' + nl)
		r = r + xmlNiePusty(z1105, '    <P_126>' + TKwotaCNieujemna(z1105) + '</P_126>' + nl)
		r = r + xmlNiePusty(z1106, '    <P_127>' + TKwotaCNieujemna(z1106) + '</P_127>' + nl)
		r = r + xmlNiePusty(z1107, '    <P_128>' + TKwotaCNieujemna(z1107) + '</P_128>' + nl)
		r = r + xmlNiePusty(z1108, '    <P_129>' + TKwotaCNieujemna(z1108) + '</P_129>' + nl)
		r = r + xmlNiePusty(z1109, '    <P_130>' + TKwotaCNieujemna(z1109) + '</P_130>' + nl)
		r = r + xmlNiePusty(z1110, '    <P_131>' + TKwotaCNieujemna(z1110) + '</P_131>' + nl)
		r = r + xmlNiePusty(z1111, '    <P_132>' + TKwotaCNieujemna(z1111) + '</P_132>' + nl)
		r = r + xmlNiePusty(z1112, '    <P_133>' + TKwotaCNieujemna(z1112) + '</P_133>' + nl)
		r = r + xmlNiePusty(z1201, '    <P_134>' + TKwotaCNieujemna(z1201) + '</P_134>' + nl)
		r = r + xmlNiePusty(z1202, '    <P_135>' + TKwotaCNieujemna(z1202) + '</P_135>' + nl)
		r = r + xmlNiePusty(z1203, '    <P_136>' + TKwotaCNieujemna(z1203) + '</P_136>' + nl)
		r = r + xmlNiePusty(z1204, '    <P_137>' + TKwotaCNieujemna(z1204) + '</P_137>' + nl)
		r = r + xmlNiePusty(z1205, '    <P_138>' + TKwotaCNieujemna(z1205) + '</P_138>' + nl)
		r = r + xmlNiePusty(z1206, '    <P_139>' + TKwotaCNieujemna(z1206) + '</P_139>' + nl)
		r = r + xmlNiePusty(z1207, '    <P_140>' + TKwotaCNieujemna(z1207) + '</P_140>' + nl)
		r = r + xmlNiePusty(z1208, '    <P_141>' + TKwotaCNieujemna(z1208) + '</P_141>' + nl)
		r = r + xmlNiePusty(z1209, '    <P_142>' + TKwotaCNieujemna(z1209) + '</P_142>' + nl)
		r = r + xmlNiePusty(z1210, '    <P_143>' + TKwotaCNieujemna(z1210) + '</P_143>' + nl)
		r = r + xmlNiePusty(z1211, '    <P_144>' + TKwotaCNieujemna(z1211) + '</P_144>' + nl)
		r = r + xmlNiePusty(z1212, '    <P_145>' + TKwotaCNieujemna(z1212) + '</P_145>' + nl)
		r = r + '    <P_146>' + TKwotaCNieujemna(z1301) + '</P_146>' + nl
		r = r + '    <P_147>' + TKwotaCNieujemna(z1302) + '</P_147>' + nl
		r = r + '    <P_148>' + TKwotaCNieujemna(z1303) + '</P_148>' + nl
		r = r + '    <P_149>' + TKwotaCNieujemna(z1304) + '</P_149>' + nl
		r = r + '    <P_150>' + TKwotaCNieujemna(z1305) + '</P_150>' + nl
		r = r + '    <P_151>' + TKwotaCNieujemna(z1306) + '</P_151>' + nl
		r = r + '    <P_152>' + TKwotaCNieujemna(z1307) + '</P_152>' + nl
		r = r + '    <P_153>' + TKwotaCNieujemna(z1308) + '</P_153>' + nl
		r = r + '    <P_154>' + TKwotaCNieujemna(z1309) + '</P_154>' + nl
		r = r + '    <P_155>' + TKwotaCNieujemna(z1310) + '</P_155>' + nl
		r = r + '    <P_156>' + TKwotaCNieujemna(z1311) + '</P_156>' + nl
		r = r + '    <P_157>' + TKwotaCNieujemna(z1312) + '</P_157>' + nl
      IF aPit48Covid[ 1 ]
   		r = r + '    <P_159>1</P_159>' + nl
      ENDIF
      IF aPit48Covid[ 2 ]
   		r = r + '    <P_160>1</P_160>' + nl
      ENDIF
      IF aPit48Covid[ 3 ]
   		r = r + '    <P_161>1</P_161>' + nl
      ENDIF
      IF aPit48Covid[ 4 ]
   		r = r + '    <P_162>1</P_162>' + nl
      ENDIF
      IF aPit48Covid[ 5 ]
   		r = r + '    <P_163>1</P_163>' + nl
      ENDIF
      IF aPit48Covid[ 6 ]
   		r = r + '    <P_164>1</P_164>' + nl
      ENDIF
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit4r)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v3(tresc_korekty_pit4r) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit4r_12()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2021/04/02/10568/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-4R (12)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-4R</KodFormularza>' + nl
      r = r + '    <WariantFormularza>12</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z801, '    <P_110>' + TKwotaCNieujemna(z801) + '</P_110>' + nl)
		r = r + xmlNiePusty(z802, '    <P_111>' + TKwotaCNieujemna(z802) + '</P_111>' + nl)
		r = r + xmlNiePusty(z803, '    <P_112>' + TKwotaCNieujemna(z803) + '</P_112>' + nl)
		r = r + xmlNiePusty(z804, '    <P_113>' + TKwotaCNieujemna(z804) + '</P_113>' + nl)
		r = r + xmlNiePusty(z805, '    <P_114>' + TKwotaCNieujemna(z805) + '</P_114>' + nl)
		r = r + xmlNiePusty(z806, '    <P_115>' + TKwotaCNieujemna(z806) + '</P_115>' + nl)
		r = r + xmlNiePusty(z807, '    <P_116>' + TKwotaCNieujemna(z807) + '</P_116>' + nl)
		r = r + xmlNiePusty(z808, '    <P_117>' + TKwotaCNieujemna(z808) + '</P_117>' + nl)
		r = r + xmlNiePusty(z809, '    <P_118>' + TKwotaCNieujemna(z809) + '</P_118>' + nl)
		r = r + xmlNiePusty(z810, '    <P_119>' + TKwotaCNieujemna(z810) + '</P_119>' + nl)
		r = r + xmlNiePusty(z811, '    <P_120>' + TKwotaCNieujemna(z811) + '</P_120>' + nl)
		r = r + xmlNiePusty(z812, '    <P_121>' + TKwotaCNieujemna(z812) + '</P_121>' + nl)
		r = r + xmlNiePusty(z1101, '    <P_122>' + TKwotaCNieujemna(z1101) + '</P_122>' + nl)
		r = r + xmlNiePusty(z1102, '    <P_123>' + TKwotaCNieujemna(z1102) + '</P_123>' + nl)
		r = r + xmlNiePusty(z1103, '    <P_124>' + TKwotaCNieujemna(z1103) + '</P_124>' + nl)
		r = r + xmlNiePusty(z1104, '    <P_125>' + TKwotaCNieujemna(z1104) + '</P_125>' + nl)
		r = r + xmlNiePusty(z1105, '    <P_126>' + TKwotaCNieujemna(z1105) + '</P_126>' + nl)
		r = r + xmlNiePusty(z1106, '    <P_127>' + TKwotaCNieujemna(z1106) + '</P_127>' + nl)
		r = r + xmlNiePusty(z1107, '    <P_128>' + TKwotaCNieujemna(z1107) + '</P_128>' + nl)
		r = r + xmlNiePusty(z1108, '    <P_129>' + TKwotaCNieujemna(z1108) + '</P_129>' + nl)
		r = r + xmlNiePusty(z1109, '    <P_130>' + TKwotaCNieujemna(z1109) + '</P_130>' + nl)
		r = r + xmlNiePusty(z1110, '    <P_131>' + TKwotaCNieujemna(z1110) + '</P_131>' + nl)
		r = r + xmlNiePusty(z1111, '    <P_132>' + TKwotaCNieujemna(z1111) + '</P_132>' + nl)
		r = r + xmlNiePusty(z1112, '    <P_133>' + TKwotaCNieujemna(z1112) + '</P_133>' + nl)
		r = r + xmlNiePusty(z1201, '    <P_134>' + TKwotaCNieujemna(z1201) + '</P_134>' + nl)
		r = r + xmlNiePusty(z1202, '    <P_135>' + TKwotaCNieujemna(z1202) + '</P_135>' + nl)
		r = r + xmlNiePusty(z1203, '    <P_136>' + TKwotaCNieujemna(z1203) + '</P_136>' + nl)
		r = r + xmlNiePusty(z1204, '    <P_137>' + TKwotaCNieujemna(z1204) + '</P_137>' + nl)
		r = r + xmlNiePusty(z1205, '    <P_138>' + TKwotaCNieujemna(z1205) + '</P_138>' + nl)
		r = r + xmlNiePusty(z1206, '    <P_139>' + TKwotaCNieujemna(z1206) + '</P_139>' + nl)
		r = r + xmlNiePusty(z1207, '    <P_140>' + TKwotaCNieujemna(z1207) + '</P_140>' + nl)
		r = r + xmlNiePusty(z1208, '    <P_141>' + TKwotaCNieujemna(z1208) + '</P_141>' + nl)
		r = r + xmlNiePusty(z1209, '    <P_142>' + TKwotaCNieujemna(z1209) + '</P_142>' + nl)
		r = r + xmlNiePusty(z1210, '    <P_143>' + TKwotaCNieujemna(z1210) + '</P_143>' + nl)
		r = r + xmlNiePusty(z1211, '    <P_144>' + TKwotaCNieujemna(z1211) + '</P_144>' + nl)
		r = r + xmlNiePusty(z1212, '    <P_145>' + TKwotaCNieujemna(z1212) + '</P_145>' + nl)
		r = r + '    <P_146>' + TKwotaCNieujemna(z1301) + '</P_146>' + nl
		r = r + '    <P_147>' + TKwotaCNieujemna(z1302) + '</P_147>' + nl
		r = r + '    <P_148>' + TKwotaCNieujemna(z1303) + '</P_148>' + nl
		r = r + '    <P_149>' + TKwotaCNieujemna(z1304) + '</P_149>' + nl
		r = r + '    <P_150>' + TKwotaCNieujemna(z1305) + '</P_150>' + nl
		r = r + '    <P_151>' + TKwotaCNieujemna(z1306) + '</P_151>' + nl
		r = r + '    <P_152>' + TKwotaCNieujemna(z1307) + '</P_152>' + nl
		r = r + '    <P_153>' + TKwotaCNieujemna(z1308) + '</P_153>' + nl
		r = r + '    <P_154>' + TKwotaCNieujemna(z1309) + '</P_154>' + nl
		r = r + '    <P_155>' + TKwotaCNieujemna(z1310) + '</P_155>' + nl
		r = r + '    <P_156>' + TKwotaCNieujemna(z1311) + '</P_156>' + nl
		r = r + '    <P_157>' + TKwotaCNieujemna(z1312) + '</P_157>' + nl
      IF aPit48Covid[ 1 ]
   		r = r + '    <P_159>1</P_159>' + nl
      ENDIF
      IF aPit48Covid[ 2 ]
   		r = r + '    <P_160>1</P_160>' + nl
      ENDIF
      IF aPit48Covid[ 3 ]
   		r = r + '    <P_161>1</P_161>' + nl
      ENDIF
      IF aPit48Covid[ 4 ]
   		r = r + '    <P_162>1</P_162>' + nl
      ENDIF
      IF aPit48Covid[ 5 ]
   		r = r + '    <P_163>1</P_163>' + nl
      ENDIF
      IF aPit48Covid[ 6 ]
   		r = r + '    <P_164>1</P_164>' + nl
      ENDIF
      IF aPit48Covid[ 7 ]
   		r = r + '    <P_165>1</P_165>' + nl
      ENDIF
      IF aPit48Covid[ 8 ]
   		r = r + '    <P_166>1</P_166>' + nl
      ENDIF
      IF aPit48Covid[ 9 ]
   		r = r + '    <P_167>1</P_167>' + nl
      ENDIF
      IF aPit48Covid[ 10 ]
   		r = r + '    <P_168>1</P_168>' + nl
      ENDIF
      IF aPit48Covid[ 11 ]
   		r = r + '    <P_169>1</P_169>' + nl
      ENDIF
      IF aPit48Covid[ 12 ]
   		r = r + '    <P_170>1</P_170>' + nl
      ENDIF
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit4r)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v3(tresc_korekty_pit4r) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit4r_13()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2023/11/07/12978/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/09/13/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-4R (13)" rodzajZobowiazania="P" wersjaSchemy="1-0E" >PIT-4R</KodFormularza>' + nl
      r = r + '    <WariantFormularza>13</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z801, '    <P_110>' + TKwotaCNieujemna(z801) + '</P_110>' + nl)
		r = r + xmlNiePusty(z802, '    <P_111>' + TKwotaCNieujemna(z802) + '</P_111>' + nl)
		r = r + xmlNiePusty(z803, '    <P_112>' + TKwotaCNieujemna(z803) + '</P_112>' + nl)
		r = r + xmlNiePusty(z804, '    <P_113>' + TKwotaCNieujemna(z804) + '</P_113>' + nl)
		r = r + xmlNiePusty(z805, '    <P_114>' + TKwotaCNieujemna(z805) + '</P_114>' + nl)
		r = r + xmlNiePusty(z806, '    <P_115>' + TKwotaCNieujemna(z806) + '</P_115>' + nl)
		r = r + xmlNiePusty(z807, '    <P_116>' + TKwotaCNieujemna(z807) + '</P_116>' + nl)
		r = r + xmlNiePusty(z808, '    <P_117>' + TKwotaCNieujemna(z808) + '</P_117>' + nl)
		r = r + xmlNiePusty(z809, '    <P_118>' + TKwotaCNieujemna(z809) + '</P_118>' + nl)
		r = r + xmlNiePusty(z810, '    <P_119>' + TKwotaCNieujemna(z810) + '</P_119>' + nl)
		r = r + xmlNiePusty(z811, '    <P_120>' + TKwotaCNieujemna(z811) + '</P_120>' + nl)
		r = r + xmlNiePusty(z812, '    <P_121>' + TKwotaCNieujemna(z812) + '</P_121>' + nl)
		r = r + xmlNiePusty(z1101, '    <P_122>' + TKwotaCNieujemna(z1101) + '</P_122>' + nl)
		r = r + xmlNiePusty(z1102, '    <P_123>' + TKwotaCNieujemna(z1102) + '</P_123>' + nl)
		r = r + xmlNiePusty(z1103, '    <P_124>' + TKwotaCNieujemna(z1103) + '</P_124>' + nl)
		r = r + xmlNiePusty(z1104, '    <P_125>' + TKwotaCNieujemna(z1104) + '</P_125>' + nl)
		r = r + xmlNiePusty(z1105, '    <P_126>' + TKwotaCNieujemna(z1105) + '</P_126>' + nl)
		r = r + xmlNiePusty(z1106, '    <P_127>' + TKwotaCNieujemna(z1106) + '</P_127>' + nl)
		r = r + xmlNiePusty(z1107, '    <P_128>' + TKwotaCNieujemna(z1107) + '</P_128>' + nl)
		r = r + xmlNiePusty(z1108, '    <P_129>' + TKwotaCNieujemna(z1108) + '</P_129>' + nl)
		r = r + xmlNiePusty(z1109, '    <P_130>' + TKwotaCNieujemna(z1109) + '</P_130>' + nl)
		r = r + xmlNiePusty(z1110, '    <P_131>' + TKwotaCNieujemna(z1110) + '</P_131>' + nl)
		r = r + xmlNiePusty(z1111, '    <P_132>' + TKwotaCNieujemna(z1111) + '</P_132>' + nl)
		r = r + xmlNiePusty(z1112, '    <P_133>' + TKwotaCNieujemna(z1112) + '</P_133>' + nl)
		r = r + xmlNiePusty(z1201, '    <P_134>' + TKwotaCNieujemna(z1201) + '</P_134>' + nl)
		r = r + xmlNiePusty(z1202, '    <P_135>' + TKwotaCNieujemna(z1202) + '</P_135>' + nl)
		r = r + xmlNiePusty(z1203, '    <P_136>' + TKwotaCNieujemna(z1203) + '</P_136>' + nl)
		r = r + xmlNiePusty(z1204, '    <P_137>' + TKwotaCNieujemna(z1204) + '</P_137>' + nl)
		r = r + xmlNiePusty(z1205, '    <P_138>' + TKwotaCNieujemna(z1205) + '</P_138>' + nl)
		r = r + xmlNiePusty(z1206, '    <P_139>' + TKwotaCNieujemna(z1206) + '</P_139>' + nl)
		r = r + xmlNiePusty(z1207, '    <P_140>' + TKwotaCNieujemna(z1207) + '</P_140>' + nl)
		r = r + xmlNiePusty(z1208, '    <P_141>' + TKwotaCNieujemna(z1208) + '</P_141>' + nl)
		r = r + xmlNiePusty(z1209, '    <P_142>' + TKwotaCNieujemna(z1209) + '</P_142>' + nl)
		r = r + xmlNiePusty(z1210, '    <P_143>' + TKwotaCNieujemna(z1210) + '</P_143>' + nl)
		r = r + xmlNiePusty(z1211, '    <P_144>' + TKwotaCNieujemna(z1211) + '</P_144>' + nl)
		r = r + xmlNiePusty(z1212, '    <P_145>' + TKwotaCNieujemna(z1212) + '</P_145>' + nl)
		r = r + '    <P_146>' + TKwotaCNieujemna(z1301) + '</P_146>' + nl
		r = r + '    <P_147>' + TKwotaCNieujemna(z1302) + '</P_147>' + nl
		r = r + '    <P_148>' + TKwotaCNieujemna(z1303) + '</P_148>' + nl
		r = r + '    <P_149>' + TKwotaCNieujemna(z1304) + '</P_149>' + nl
		r = r + '    <P_150>' + TKwotaCNieujemna(z1305) + '</P_150>' + nl
		r = r + '    <P_151>' + TKwotaCNieujemna(z1306) + '</P_151>' + nl
		r = r + '    <P_152>' + TKwotaCNieujemna(z1307) + '</P_152>' + nl
		r = r + '    <P_153>' + TKwotaCNieujemna(z1308) + '</P_153>' + nl
		r = r + '    <P_154>' + TKwotaCNieujemna(z1309) + '</P_154>' + nl
		r = r + '    <P_155>' + TKwotaCNieujemna(z1310) + '</P_155>' + nl
		r = r + '    <P_156>' + TKwotaCNieujemna(z1311) + '</P_156>' + nl
		r = r + '    <P_157>' + TKwotaCNieujemna(z1312) + '</P_157>' + nl
      r = r + '    <P_158>2</P_158>' + nl
		r = r + '    <P_171>' + TKwotaCNieujemna(z1301) + '</P_171>' + nl
		r = r + '    <P_172>' + TKwotaCNieujemna(z1302) + '</P_172>' + nl
		r = r + '    <P_173>' + TKwotaCNieujemna(z1303) + '</P_173>' + nl
		r = r + '    <P_174>' + TKwotaCNieujemna(z1304) + '</P_174>' + nl
		r = r + '    <P_175>' + TKwotaCNieujemna(z1305) + '</P_175>' + nl
		r = r + '    <P_176>' + TKwotaCNieujemna(z1306) + '</P_176>' + nl
		r = r + '    <P_177>' + TKwotaCNieujemna(z1307) + '</P_177>' + nl
		r = r + '    <P_178>' + TKwotaCNieujemna(z1308) + '</P_178>' + nl
		r = r + '    <P_179>' + TKwotaCNieujemna(z1309) + '</P_179>' + nl
		r = r + '    <P_180>' + TKwotaCNieujemna(z1310) + '</P_180>' + nl
		r = r + '    <P_181>' + TKwotaCNieujemna(z1311) + '</P_181>' + nl
		r = r + '    <P_182>' + TKwotaCNieujemna(z1312) + '</P_182>' + nl
      IF aPit48Covid[ 1 ]
   		r = r + '    <P_184>1</P_184>' + nl
      ENDIF
      IF aPit48Covid[ 2 ]
   		r = r + '    <P_185>1</P_185>' + nl
      ENDIF
      IF aPit48Covid[ 3 ]
   		r = r + '    <P_186>1</P_186>' + nl
      ENDIF
      IF aPit48Covid[ 4 ]
   		r = r + '    <P_187>1</P_187>' + nl
      ENDIF
      IF aPit48Covid[ 5 ]
   		r = r + '    <P_188>1</P_188>' + nl
      ENDIF
      IF aPit48Covid[ 6 ]
   		r = r + '    <P_189>1</P_189>' + nl
      ENDIF
      IF aPit48Covid[ 7 ]
   		r = r + '    <P_190>1</P_190>' + nl
      ENDIF
      IF aPit48Covid[ 8 ]
   		r = r + '    <P_191>1</P_191>' + nl
      ENDIF
      IF aPit48Covid[ 9 ]
   		r = r + '    <P_192>1</P_192>' + nl
      ENDIF
      IF aPit48Covid[ 10 ]
   		r = r + '    <P_193>1</P_193>' + nl
      ENDIF
      IF aPit48Covid[ 11 ]
   		r = r + '    <P_194>1</P_194>' + nl
      ENDIF
      IF aPit48Covid[ 12 ]
   		r = r + '    <P_195>1</P_195>' + nl
      ENDIF
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit4r)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v10(tresc_korekty_pit4r) + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwot z poz. od 189 do 200 lub wpłacenia ich w niepełnej wysokości niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2012 r. poz. 1015, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowiązkom płatnika grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwot z poz. od 189 do 200 lub wpłacenia ich w niepełnej wysokości niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2012 r. poz. 1015, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowiązkom płatnika grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwot z poz. od 201 do 212 lub wpłacenia ich w niepełnej wysokości niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za uchybienie obowiązkom płatnika grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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

FUNCTION edek_pit8ar_9()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2020/11/13/10088/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (9)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>9</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z201, '    <P_382>' + TKwotaCNieujemna(z201) + '</P_382>' + nl)
		r = r + xmlNiePusty(z202, '    <P_383>' + TKwotaCNieujemna(z202) + '</P_383>' + nl)
		r = r + xmlNiePusty(z203, '    <P_384>' + TKwotaCNieujemna(z203) + '</P_384>' + nl)
		r = r + xmlNiePusty(z204, '    <P_385>' + TKwotaCNieujemna(z204) + '</P_385>' + nl)
		r = r + xmlNiePusty(z205, '    <P_386>' + TKwotaCNieujemna(z205) + '</P_386>' + nl)
		r = r + xmlNiePusty(z206, '    <P_387>' + TKwotaCNieujemna(z206) + '</P_387>' + nl)
		r = r + xmlNiePusty(z207, '    <P_388>' + TKwotaCNieujemna(z207) + '</P_388>' + nl)
		r = r + xmlNiePusty(z208, '    <P_389>' + TKwotaCNieujemna(z208) + '</P_389>' + nl)
		r = r + xmlNiePusty(z209, '    <P_390>' + TKwotaCNieujemna(z209) + '</P_390>' + nl)
		r = r + xmlNiePusty(z210, '    <P_391>' + TKwotaCNieujemna(z210) + '</P_391>' + nl)
		r = r + xmlNiePusty(z211, '    <P_392>' + TKwotaCNieujemna(z211) + '</P_392>' + nl)
		r = r + xmlNiePusty(z212, '    <P_393>' + TKwotaCNieujemna(z212) + '</P_393>' + nl)
		r = r + xmlNiePusty(z301, '    <P_394>' + TKwota2Nieujemna(z301) + '</P_394>' + nl)
		r = r + xmlNiePusty(z302, '    <P_395>' + TKwota2Nieujemna(z302) + '</P_395>' + nl)
		r = r + xmlNiePusty(z303, '    <P_396>' + TKwota2Nieujemna(z303) + '</P_396>' + nl)
		r = r + xmlNiePusty(z304, '    <P_397>' + TKwota2Nieujemna(z304) + '</P_397>' + nl)
		r = r + xmlNiePusty(z305, '    <P_398>' + TKwota2Nieujemna(z305) + '</P_398>' + nl)
		r = r + xmlNiePusty(z306, '    <P_399>' + TKwota2Nieujemna(z306) + '</P_399>' + nl)
		r = r + xmlNiePusty(z307, '    <P_400>' + TKwota2Nieujemna(z307) + '</P_400>' + nl)
		r = r + xmlNiePusty(z308, '    <P_401>' + TKwota2Nieujemna(z308) + '</P_401>' + nl)
		r = r + xmlNiePusty(z309, '    <P_402>' + TKwota2Nieujemna(z309) + '</P_402>' + nl)
		r = r + xmlNiePusty(z310, '    <P_403>' + TKwota2Nieujemna(z310) + '</P_403>' + nl)
		r = r + xmlNiePusty(z311, '    <P_404>' + TKwota2Nieujemna(z311) + '</P_404>' + nl)
		r = r + xmlNiePusty(z312, '    <P_405>' + TKwota2Nieujemna(z312) + '</P_405>' + nl)
		r = r + xmlNiePusty(z401, '    <P_406>' + TKwotaCNieujemna(z401) + '</P_406>' + nl)
		r = r + xmlNiePusty(z402, '    <P_407>' + TKwotaCNieujemna(z402) + '</P_407>' + nl)
		r = r + xmlNiePusty(z403, '    <P_408>' + TKwotaCNieujemna(z403) + '</P_408>' + nl)
		r = r + xmlNiePusty(z404, '    <P_409>' + TKwotaCNieujemna(z404) + '</P_409>' + nl)
		r = r + xmlNiePusty(z405, '    <P_410>' + TKwotaCNieujemna(z405) + '</P_410>' + nl)
		r = r + xmlNiePusty(z406, '    <P_411>' + TKwotaCNieujemna(z406) + '</P_411>' + nl)
		r = r + xmlNiePusty(z407, '    <P_412>' + TKwotaCNieujemna(z407) + '</P_412>' + nl)
		r = r + xmlNiePusty(z408, '    <P_413>' + TKwotaCNieujemna(z408) + '</P_413>' + nl)
		r = r + xmlNiePusty(z409, '    <P_414>' + TKwotaCNieujemna(z409) + '</P_414>' + nl)
		r = r + xmlNiePusty(z410, '    <P_415>' + TKwotaCNieujemna(z410) + '</P_415>' + nl)
		r = r + xmlNiePusty(z411, '    <P_416>' + TKwotaCNieujemna(z411) + '</P_416>' + nl)
		r = r + xmlNiePusty(z412, '    <P_417>' + TKwotaCNieujemna(z412) + '</P_417>' + nl)
		r = r + '    <P_418>' + TKwota2Nieujemna(z501) + '</P_418>' + nl
		r = r + '    <P_419>' + TKwota2Nieujemna(z502) + '</P_419>' + nl
		r = r + '    <P_420>' + TKwota2Nieujemna(z503) + '</P_420>' + nl
		r = r + '    <P_421>' + TKwota2Nieujemna(z504) + '</P_421>' + nl
		r = r + '    <P_422>' + TKwota2Nieujemna(z505) + '</P_422>' + nl
		r = r + '    <P_423>' + TKwota2Nieujemna(z506) + '</P_423>' + nl
		r = r + '    <P_424>' + TKwota2Nieujemna(z507) + '</P_424>' + nl
		r = r + '    <P_425>' + TKwota2Nieujemna(z508) + '</P_425>' + nl
		r = r + '    <P_426>' + TKwota2Nieujemna(z509) + '</P_426>' + nl
		r = r + '    <P_427>' + TKwota2Nieujemna(z510) + '</P_427>' + nl
		r = r + '    <P_428>' + TKwota2Nieujemna(z511) + '</P_428>' + nl
		r = r + '    <P_429>' + TKwota2Nieujemna(z512) + '</P_429>' + nl
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

FUNCTION edek_pit8ar_10()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2021/01/07/10282/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (10)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>10</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z201, '    <P_382>' + TKwotaCNieujemna(z201) + '</P_382>' + nl)
		r = r + xmlNiePusty(z202, '    <P_383>' + TKwotaCNieujemna(z202) + '</P_383>' + nl)
		r = r + xmlNiePusty(z203, '    <P_384>' + TKwotaCNieujemna(z203) + '</P_384>' + nl)
		r = r + xmlNiePusty(z204, '    <P_385>' + TKwotaCNieujemna(z204) + '</P_385>' + nl)
		r = r + xmlNiePusty(z205, '    <P_386>' + TKwotaCNieujemna(z205) + '</P_386>' + nl)
		r = r + xmlNiePusty(z206, '    <P_387>' + TKwotaCNieujemna(z206) + '</P_387>' + nl)
		r = r + xmlNiePusty(z207, '    <P_388>' + TKwotaCNieujemna(z207) + '</P_388>' + nl)
		r = r + xmlNiePusty(z208, '    <P_389>' + TKwotaCNieujemna(z208) + '</P_389>' + nl)
		r = r + xmlNiePusty(z209, '    <P_390>' + TKwotaCNieujemna(z209) + '</P_390>' + nl)
		r = r + xmlNiePusty(z210, '    <P_391>' + TKwotaCNieujemna(z210) + '</P_391>' + nl)
		r = r + xmlNiePusty(z211, '    <P_392>' + TKwotaCNieujemna(z211) + '</P_392>' + nl)
		r = r + xmlNiePusty(z212, '    <P_393>' + TKwotaCNieujemna(z212) + '</P_393>' + nl)
		r = r + xmlNiePusty(z301, '    <P_394>' + TKwota2Nieujemna(z301) + '</P_394>' + nl)
		r = r + xmlNiePusty(z302, '    <P_395>' + TKwota2Nieujemna(z302) + '</P_395>' + nl)
		r = r + xmlNiePusty(z303, '    <P_396>' + TKwota2Nieujemna(z303) + '</P_396>' + nl)
		r = r + xmlNiePusty(z304, '    <P_397>' + TKwota2Nieujemna(z304) + '</P_397>' + nl)
		r = r + xmlNiePusty(z305, '    <P_398>' + TKwota2Nieujemna(z305) + '</P_398>' + nl)
		r = r + xmlNiePusty(z306, '    <P_399>' + TKwota2Nieujemna(z306) + '</P_399>' + nl)
		r = r + xmlNiePusty(z307, '    <P_400>' + TKwota2Nieujemna(z307) + '</P_400>' + nl)
		r = r + xmlNiePusty(z308, '    <P_401>' + TKwota2Nieujemna(z308) + '</P_401>' + nl)
		r = r + xmlNiePusty(z309, '    <P_402>' + TKwota2Nieujemna(z309) + '</P_402>' + nl)
		r = r + xmlNiePusty(z310, '    <P_403>' + TKwota2Nieujemna(z310) + '</P_403>' + nl)
		r = r + xmlNiePusty(z311, '    <P_404>' + TKwota2Nieujemna(z311) + '</P_404>' + nl)
		r = r + xmlNiePusty(z312, '    <P_405>' + TKwota2Nieujemna(z312) + '</P_405>' + nl)
		r = r + xmlNiePusty(z401, '    <P_406>' + TKwotaCNieujemna(z401) + '</P_406>' + nl)
		r = r + xmlNiePusty(z402, '    <P_407>' + TKwotaCNieujemna(z402) + '</P_407>' + nl)
		r = r + xmlNiePusty(z403, '    <P_408>' + TKwotaCNieujemna(z403) + '</P_408>' + nl)
		r = r + xmlNiePusty(z404, '    <P_409>' + TKwotaCNieujemna(z404) + '</P_409>' + nl)
		r = r + xmlNiePusty(z405, '    <P_410>' + TKwotaCNieujemna(z405) + '</P_410>' + nl)
		r = r + xmlNiePusty(z406, '    <P_411>' + TKwotaCNieujemna(z406) + '</P_411>' + nl)
		r = r + xmlNiePusty(z407, '    <P_412>' + TKwotaCNieujemna(z407) + '</P_412>' + nl)
		r = r + xmlNiePusty(z408, '    <P_413>' + TKwotaCNieujemna(z408) + '</P_413>' + nl)
		r = r + xmlNiePusty(z409, '    <P_414>' + TKwotaCNieujemna(z409) + '</P_414>' + nl)
		r = r + xmlNiePusty(z410, '    <P_415>' + TKwotaCNieujemna(z410) + '</P_415>' + nl)
		r = r + xmlNiePusty(z411, '    <P_416>' + TKwotaCNieujemna(z411) + '</P_416>' + nl)
		r = r + xmlNiePusty(z412, '    <P_417>' + TKwotaCNieujemna(z412) + '</P_417>' + nl)
		r = r + '    <P_418>' + TKwota2Nieujemna(z501) + '</P_418>' + nl
		r = r + '    <P_419>' + TKwota2Nieujemna(z502) + '</P_419>' + nl
		r = r + '    <P_420>' + TKwota2Nieujemna(z503) + '</P_420>' + nl
		r = r + '    <P_421>' + TKwota2Nieujemna(z504) + '</P_421>' + nl
		r = r + '    <P_422>' + TKwota2Nieujemna(z505) + '</P_422>' + nl
		r = r + '    <P_423>' + TKwota2Nieujemna(z506) + '</P_423>' + nl
		r = r + '    <P_424>' + TKwota2Nieujemna(z507) + '</P_424>' + nl
		r = r + '    <P_425>' + TKwota2Nieujemna(z508) + '</P_425>' + nl
		r = r + '    <P_426>' + TKwota2Nieujemna(z509) + '</P_426>' + nl
		r = r + '    <P_427>' + TKwota2Nieujemna(z510) + '</P_427>' + nl
		r = r + '    <P_428>' + TKwota2Nieujemna(z511) + '</P_428>' + nl
		r = r + '    <P_429>' + TKwota2Nieujemna(z512) + '</P_429>' + nl
      IF aPit48Covid[ 1 ]
   		r = r + '    <P_430>1</P_430>' + nl
      ENDIF
      IF aPit48Covid[ 2 ]
   		r = r + '    <P_431>1</P_431>' + nl
      ENDIF
      IF aPit48Covid[ 3 ]
   		r = r + '    <P_432>1</P_432>' + nl
      ENDIF
      IF aPit48Covid[ 4 ]
   		r = r + '    <P_433>1</P_433>' + nl
      ENDIF
      IF aPit48Covid[ 5 ]
   		r = r + '    <P_434>1</P_434>' + nl
      ENDIF
      IF aPit48Covid[ 6 ]
   		r = r + '    <P_435>1</P_435>' + nl
      ENDIF
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v3(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_11()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2021/04/02/10564/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (11)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>11</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z201, '    <P_382>' + TKwotaCNieujemna(z201) + '</P_382>' + nl)
		r = r + xmlNiePusty(z202, '    <P_383>' + TKwotaCNieujemna(z202) + '</P_383>' + nl)
		r = r + xmlNiePusty(z203, '    <P_384>' + TKwotaCNieujemna(z203) + '</P_384>' + nl)
		r = r + xmlNiePusty(z204, '    <P_385>' + TKwotaCNieujemna(z204) + '</P_385>' + nl)
		r = r + xmlNiePusty(z205, '    <P_386>' + TKwotaCNieujemna(z205) + '</P_386>' + nl)
		r = r + xmlNiePusty(z206, '    <P_387>' + TKwotaCNieujemna(z206) + '</P_387>' + nl)
		r = r + xmlNiePusty(z207, '    <P_388>' + TKwotaCNieujemna(z207) + '</P_388>' + nl)
		r = r + xmlNiePusty(z208, '    <P_389>' + TKwotaCNieujemna(z208) + '</P_389>' + nl)
		r = r + xmlNiePusty(z209, '    <P_390>' + TKwotaCNieujemna(z209) + '</P_390>' + nl)
		r = r + xmlNiePusty(z210, '    <P_391>' + TKwotaCNieujemna(z210) + '</P_391>' + nl)
		r = r + xmlNiePusty(z211, '    <P_392>' + TKwotaCNieujemna(z211) + '</P_392>' + nl)
		r = r + xmlNiePusty(z212, '    <P_393>' + TKwotaCNieujemna(z212) + '</P_393>' + nl)
		r = r + xmlNiePusty(z301, '    <P_394>' + TKwota2Nieujemna(z301) + '</P_394>' + nl)
		r = r + xmlNiePusty(z302, '    <P_395>' + TKwota2Nieujemna(z302) + '</P_395>' + nl)
		r = r + xmlNiePusty(z303, '    <P_396>' + TKwota2Nieujemna(z303) + '</P_396>' + nl)
		r = r + xmlNiePusty(z304, '    <P_397>' + TKwota2Nieujemna(z304) + '</P_397>' + nl)
		r = r + xmlNiePusty(z305, '    <P_398>' + TKwota2Nieujemna(z305) + '</P_398>' + nl)
		r = r + xmlNiePusty(z306, '    <P_399>' + TKwota2Nieujemna(z306) + '</P_399>' + nl)
		r = r + xmlNiePusty(z307, '    <P_400>' + TKwota2Nieujemna(z307) + '</P_400>' + nl)
		r = r + xmlNiePusty(z308, '    <P_401>' + TKwota2Nieujemna(z308) + '</P_401>' + nl)
		r = r + xmlNiePusty(z309, '    <P_402>' + TKwota2Nieujemna(z309) + '</P_402>' + nl)
		r = r + xmlNiePusty(z310, '    <P_403>' + TKwota2Nieujemna(z310) + '</P_403>' + nl)
		r = r + xmlNiePusty(z311, '    <P_404>' + TKwota2Nieujemna(z311) + '</P_404>' + nl)
		r = r + xmlNiePusty(z312, '    <P_405>' + TKwota2Nieujemna(z312) + '</P_405>' + nl)
		r = r + xmlNiePusty(z401, '    <P_406>' + TKwotaCNieujemna(z401) + '</P_406>' + nl)
		r = r + xmlNiePusty(z402, '    <P_407>' + TKwotaCNieujemna(z402) + '</P_407>' + nl)
		r = r + xmlNiePusty(z403, '    <P_408>' + TKwotaCNieujemna(z403) + '</P_408>' + nl)
		r = r + xmlNiePusty(z404, '    <P_409>' + TKwotaCNieujemna(z404) + '</P_409>' + nl)
		r = r + xmlNiePusty(z405, '    <P_410>' + TKwotaCNieujemna(z405) + '</P_410>' + nl)
		r = r + xmlNiePusty(z406, '    <P_411>' + TKwotaCNieujemna(z406) + '</P_411>' + nl)
		r = r + xmlNiePusty(z407, '    <P_412>' + TKwotaCNieujemna(z407) + '</P_412>' + nl)
		r = r + xmlNiePusty(z408, '    <P_413>' + TKwotaCNieujemna(z408) + '</P_413>' + nl)
		r = r + xmlNiePusty(z409, '    <P_414>' + TKwotaCNieujemna(z409) + '</P_414>' + nl)
		r = r + xmlNiePusty(z410, '    <P_415>' + TKwotaCNieujemna(z410) + '</P_415>' + nl)
		r = r + xmlNiePusty(z411, '    <P_416>' + TKwotaCNieujemna(z411) + '</P_416>' + nl)
		r = r + xmlNiePusty(z412, '    <P_417>' + TKwotaCNieujemna(z412) + '</P_417>' + nl)
		r = r + '    <P_418>' + TKwota2Nieujemna(z501) + '</P_418>' + nl
		r = r + '    <P_419>' + TKwota2Nieujemna(z502) + '</P_419>' + nl
		r = r + '    <P_420>' + TKwota2Nieujemna(z503) + '</P_420>' + nl
		r = r + '    <P_421>' + TKwota2Nieujemna(z504) + '</P_421>' + nl
		r = r + '    <P_422>' + TKwota2Nieujemna(z505) + '</P_422>' + nl
		r = r + '    <P_423>' + TKwota2Nieujemna(z506) + '</P_423>' + nl
		r = r + '    <P_424>' + TKwota2Nieujemna(z507) + '</P_424>' + nl
		r = r + '    <P_425>' + TKwota2Nieujemna(z508) + '</P_425>' + nl
		r = r + '    <P_426>' + TKwota2Nieujemna(z509) + '</P_426>' + nl
		r = r + '    <P_427>' + TKwota2Nieujemna(z510) + '</P_427>' + nl
		r = r + '    <P_428>' + TKwota2Nieujemna(z511) + '</P_428>' + nl
		r = r + '    <P_429>' + TKwota2Nieujemna(z512) + '</P_429>' + nl
      IF aPit48Covid[ 1 ]
   		r = r + '    <P_430>1</P_430>' + nl
      ENDIF
      IF aPit48Covid[ 2 ]
   		r = r + '    <P_431>1</P_431>' + nl
      ENDIF
      IF aPit48Covid[ 3 ]
   		r = r + '    <P_432>1</P_432>' + nl
      ENDIF
      IF aPit48Covid[ 4 ]
   		r = r + '    <P_433>1</P_433>' + nl
      ENDIF
      IF aPit48Covid[ 5 ]
   		r = r + '    <P_434>1</P_434>' + nl
      ENDIF
      IF aPit48Covid[ 6 ]
   		r = r + '    <P_435>1</P_435>' + nl
      ENDIF
      IF aPit48Covid[ 7 ]
   		r = r + '    <P_436>1</P_436>' + nl
      ENDIF
      IF aPit48Covid[ 8 ]
   		r = r + '    <P_437>1</P_437>' + nl
      ENDIF
      IF aPit48Covid[ 9 ]
   		r = r + '    <P_438>1</P_438>' + nl
      ENDIF
      IF aPit48Covid[ 10 ]
   		r = r + '    <P_439>1</P_439>' + nl
      ENDIF
      IF aPit48Covid[ 11 ]
   		r = r + '    <P_440>1</P_440>' + nl
      ENDIF
      IF aPit48Covid[ 12 ]
   		r = r + '    <P_441>1</P_441>' + nl
      ENDIF
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v3(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_12()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2022/04/15/11486/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (12)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>12</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z201, '    <P_394>' + TKwotaCNieujemna(z201) + '</P_394>' + nl)
		r = r + xmlNiePusty(z202, '    <P_395>' + TKwotaCNieujemna(z202) + '</P_395>' + nl)
		r = r + xmlNiePusty(z203, '    <P_396>' + TKwotaCNieujemna(z203) + '</P_396>' + nl)
		r = r + xmlNiePusty(z204, '    <P_397>' + TKwotaCNieujemna(z204) + '</P_397>' + nl)
		r = r + xmlNiePusty(z205, '    <P_398>' + TKwotaCNieujemna(z205) + '</P_398>' + nl)
		r = r + xmlNiePusty(z206, '    <P_399>' + TKwotaCNieujemna(z206) + '</P_399>' + nl)
		r = r + xmlNiePusty(z207, '    <P_400>' + TKwotaCNieujemna(z207) + '</P_400>' + nl)
		r = r + xmlNiePusty(z208, '    <P_401>' + TKwotaCNieujemna(z208) + '</P_401>' + nl)
		r = r + xmlNiePusty(z209, '    <P_402>' + TKwotaCNieujemna(z209) + '</P_402>' + nl)
		r = r + xmlNiePusty(z210, '    <P_403>' + TKwotaCNieujemna(z210) + '</P_403>' + nl)
		r = r + xmlNiePusty(z211, '    <P_404>' + TKwotaCNieujemna(z211) + '</P_404>' + nl)
		r = r + xmlNiePusty(z212, '    <P_405>' + TKwotaCNieujemna(z212) + '</P_405>' + nl)
		r = r + xmlNiePusty(z301, '    <P_406>' + TKwota2Nieujemna(z301) + '</P_406>' + nl)
		r = r + xmlNiePusty(z302, '    <P_407>' + TKwota2Nieujemna(z302) + '</P_407>' + nl)
		r = r + xmlNiePusty(z303, '    <P_408>' + TKwota2Nieujemna(z303) + '</P_408>' + nl)
		r = r + xmlNiePusty(z304, '    <P_409>' + TKwota2Nieujemna(z304) + '</P_409>' + nl)
		r = r + xmlNiePusty(z305, '    <P_410>' + TKwota2Nieujemna(z305) + '</P_410>' + nl)
		r = r + xmlNiePusty(z306, '    <P_411>' + TKwota2Nieujemna(z306) + '</P_411>' + nl)
		r = r + xmlNiePusty(z307, '    <P_412>' + TKwota2Nieujemna(z307) + '</P_412>' + nl)
		r = r + xmlNiePusty(z308, '    <P_413>' + TKwota2Nieujemna(z308) + '</P_413>' + nl)
		r = r + xmlNiePusty(z309, '    <P_414>' + TKwota2Nieujemna(z309) + '</P_414>' + nl)
		r = r + xmlNiePusty(z310, '    <P_415>' + TKwota2Nieujemna(z310) + '</P_415>' + nl)
		r = r + xmlNiePusty(z311, '    <P_416>' + TKwota2Nieujemna(z311) + '</P_416>' + nl)
		r = r + xmlNiePusty(z312, '    <P_417>' + TKwota2Nieujemna(z312) + '</P_417>' + nl)
		r = r + xmlNiePusty(z401, '    <P_418>' + TKwotaCNieujemna(z401) + '</P_418>' + nl)
		r = r + xmlNiePusty(z402, '    <P_419>' + TKwotaCNieujemna(z402) + '</P_419>' + nl)
		r = r + xmlNiePusty(z403, '    <P_420>' + TKwotaCNieujemna(z403) + '</P_420>' + nl)
		r = r + xmlNiePusty(z404, '    <P_421>' + TKwotaCNieujemna(z404) + '</P_421>' + nl)
		r = r + xmlNiePusty(z405, '    <P_422>' + TKwotaCNieujemna(z405) + '</P_422>' + nl)
		r = r + xmlNiePusty(z406, '    <P_423>' + TKwotaCNieujemna(z406) + '</P_423>' + nl)
		r = r + xmlNiePusty(z407, '    <P_424>' + TKwotaCNieujemna(z407) + '</P_424>' + nl)
		r = r + xmlNiePusty(z408, '    <P_425>' + TKwotaCNieujemna(z408) + '</P_425>' + nl)
		r = r + xmlNiePusty(z409, '    <P_426>' + TKwotaCNieujemna(z409) + '</P_426>' + nl)
		r = r + xmlNiePusty(z410, '    <P_427>' + TKwotaCNieujemna(z410) + '</P_427>' + nl)
		r = r + xmlNiePusty(z411, '    <P_428>' + TKwotaCNieujemna(z411) + '</P_428>' + nl)
		r = r + xmlNiePusty(z412, '    <P_429>' + TKwotaCNieujemna(z412) + '</P_429>' + nl)
		r = r + '    <P_430>' + TKwota2Nieujemna(z501) + '</P_430>' + nl
		r = r + '    <P_431>' + TKwota2Nieujemna(z502) + '</P_431>' + nl
		r = r + '    <P_432>' + TKwota2Nieujemna(z503) + '</P_432>' + nl
		r = r + '    <P_433>' + TKwota2Nieujemna(z504) + '</P_433>' + nl
		r = r + '    <P_434>' + TKwota2Nieujemna(z505) + '</P_434>' + nl
		r = r + '    <P_435>' + TKwota2Nieujemna(z506) + '</P_435>' + nl
		r = r + '    <P_436>' + TKwota2Nieujemna(z507) + '</P_436>' + nl
		r = r + '    <P_437>' + TKwota2Nieujemna(z508) + '</P_437>' + nl
		r = r + '    <P_438>' + TKwota2Nieujemna(z509) + '</P_438>' + nl
		r = r + '    <P_439>' + TKwota2Nieujemna(z510) + '</P_439>' + nl
		r = r + '    <P_440>' + TKwota2Nieujemna(z511) + '</P_440>' + nl
		r = r + '    <P_441>' + TKwota2Nieujemna(z512) + '</P_441>' + nl
      IF aPit48Covid[ 1 ]
   		r = r + '    <P_442>1</P_442>' + nl
      ENDIF
      IF aPit48Covid[ 2 ]
   		r = r + '    <P_443>1</P_443>' + nl
      ENDIF
      IF aPit48Covid[ 3 ]
   		r = r + '    <P_444>1</P_444>' + nl
      ENDIF
      IF aPit48Covid[ 4 ]
   		r = r + '    <P_445>1</P_445>' + nl
      ENDIF
      IF aPit48Covid[ 5 ]
   		r = r + '    <P_446>1</P_446>' + nl
      ENDIF
      IF aPit48Covid[ 6 ]
   		r = r + '    <P_447>1</P_447>' + nl
      ENDIF
      IF aPit48Covid[ 7 ]
   		r = r + '    <P_448>1</P_448>' + nl
      ENDIF
      IF aPit48Covid[ 8 ]
   		r = r + '    <P_449>1</P_449>' + nl
      ENDIF
      IF aPit48Covid[ 9 ]
   		r = r + '    <P_450>1</P_450>' + nl
      ENDIF
      IF aPit48Covid[ 10 ]
   		r = r + '    <P_451>1</P_451>' + nl
      ENDIF
      IF aPit48Covid[ 11 ]
   		r = r + '    <P_452>1</P_452>' + nl
      ENDIF
      IF aPit48Covid[ 12 ]
   		r = r + '    <P_453>1</P_453>' + nl
      ENDIF
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v3(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_13()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2023/11/08/12979/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/09/13/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (13)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>13</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z201, '    <P_418>' + TKwotaCNieujemna(z201) + '</P_418>' + nl)
		r = r + xmlNiePusty(z202, '    <P_419>' + TKwotaCNieujemna(z202) + '</P_419>' + nl)
		r = r + xmlNiePusty(z203, '    <P_420>' + TKwotaCNieujemna(z203) + '</P_420>' + nl)
		r = r + xmlNiePusty(z204, '    <P_421>' + TKwotaCNieujemna(z204) + '</P_421>' + nl)
		r = r + xmlNiePusty(z205, '    <P_422>' + TKwotaCNieujemna(z205) + '</P_422>' + nl)
		r = r + xmlNiePusty(z206, '    <P_423>' + TKwotaCNieujemna(z206) + '</P_423>' + nl)
		r = r + xmlNiePusty(z207, '    <P_424>' + TKwotaCNieujemna(z207) + '</P_424>' + nl)
		r = r + xmlNiePusty(z208, '    <P_425>' + TKwotaCNieujemna(z208) + '</P_425>' + nl)
		r = r + xmlNiePusty(z209, '    <P_426>' + TKwotaCNieujemna(z209) + '</P_426>' + nl)
		r = r + xmlNiePusty(z210, '    <P_427>' + TKwotaCNieujemna(z210) + '</P_427>' + nl)
		r = r + xmlNiePusty(z211, '    <P_428>' + TKwotaCNieujemna(z211) + '</P_428>' + nl)
		r = r + xmlNiePusty(z212, '    <P_429>' + TKwotaCNieujemna(z212) + '</P_429>' + nl)
		r = r + xmlNiePusty(z301, '    <P_430>' + TKwota2Nieujemna(z301) + '</P_430>' + nl)
		r = r + xmlNiePusty(z302, '    <P_431>' + TKwota2Nieujemna(z302) + '</P_431>' + nl)
		r = r + xmlNiePusty(z303, '    <P_432>' + TKwota2Nieujemna(z303) + '</P_432>' + nl)
		r = r + xmlNiePusty(z304, '    <P_433>' + TKwota2Nieujemna(z304) + '</P_433>' + nl)
		r = r + xmlNiePusty(z305, '    <P_434>' + TKwota2Nieujemna(z305) + '</P_434>' + nl)
		r = r + xmlNiePusty(z306, '    <P_435>' + TKwota2Nieujemna(z306) + '</P_435>' + nl)
		r = r + xmlNiePusty(z307, '    <P_436>' + TKwota2Nieujemna(z307) + '</P_436>' + nl)
		r = r + xmlNiePusty(z308, '    <P_437>' + TKwota2Nieujemna(z308) + '</P_437>' + nl)
		r = r + xmlNiePusty(z309, '    <P_438>' + TKwota2Nieujemna(z309) + '</P_438>' + nl)
		r = r + xmlNiePusty(z310, '    <P_439>' + TKwota2Nieujemna(z310) + '</P_439>' + nl)
		r = r + xmlNiePusty(z311, '    <P_440>' + TKwota2Nieujemna(z311) + '</P_440>' + nl)
		r = r + xmlNiePusty(z312, '    <P_441>' + TKwota2Nieujemna(z312) + '</P_441>' + nl)
		r = r + xmlNiePusty(z401, '    <P_442>' + TKwotaCNieujemna(z401) + '</P_442>' + nl)
		r = r + xmlNiePusty(z402, '    <P_443>' + TKwotaCNieujemna(z402) + '</P_443>' + nl)
		r = r + xmlNiePusty(z403, '    <P_444>' + TKwotaCNieujemna(z403) + '</P_444>' + nl)
		r = r + xmlNiePusty(z404, '    <P_445>' + TKwotaCNieujemna(z404) + '</P_445>' + nl)
		r = r + xmlNiePusty(z405, '    <P_446>' + TKwotaCNieujemna(z405) + '</P_446>' + nl)
		r = r + xmlNiePusty(z406, '    <P_447>' + TKwotaCNieujemna(z406) + '</P_447>' + nl)
		r = r + xmlNiePusty(z407, '    <P_448>' + TKwotaCNieujemna(z407) + '</P_448>' + nl)
		r = r + xmlNiePusty(z408, '    <P_449>' + TKwotaCNieujemna(z408) + '</P_449>' + nl)
		r = r + xmlNiePusty(z409, '    <P_450>' + TKwotaCNieujemna(z409) + '</P_450>' + nl)
		r = r + xmlNiePusty(z410, '    <P_451>' + TKwotaCNieujemna(z410) + '</P_451>' + nl)
		r = r + xmlNiePusty(z411, '    <P_452>' + TKwotaCNieujemna(z411) + '</P_452>' + nl)
		r = r + xmlNiePusty(z412, '    <P_453>' + TKwotaCNieujemna(z412) + '</P_453>' + nl)
		r = r + '    <P_454>' + TKwota2Nieujemna(z501) + '</P_454>' + nl
		r = r + '    <P_455>' + TKwota2Nieujemna(z502) + '</P_455>' + nl
		r = r + '    <P_456>' + TKwota2Nieujemna(z503) + '</P_456>' + nl
		r = r + '    <P_457>' + TKwota2Nieujemna(z504) + '</P_457>' + nl
		r = r + '    <P_458>' + TKwota2Nieujemna(z505) + '</P_458>' + nl
		r = r + '    <P_459>' + TKwota2Nieujemna(z506) + '</P_459>' + nl
		r = r + '    <P_460>' + TKwota2Nieujemna(z507) + '</P_460>' + nl
		r = r + '    <P_461>' + TKwota2Nieujemna(z508) + '</P_461>' + nl
		r = r + '    <P_462>' + TKwota2Nieujemna(z509) + '</P_462>' + nl
		r = r + '    <P_463>' + TKwota2Nieujemna(z510) + '</P_463>' + nl
		r = r + '    <P_464>' + TKwota2Nieujemna(z511) + '</P_464>' + nl
		r = r + '    <P_465>' + TKwota2Nieujemna(z512) + '</P_465>' + nl

      r = r + '    <P_466>2</P_466>' + nl

		r = r + '    <P_479>' + TKwota2Nieujemna(z501) + '</P_479>' + nl
		r = r + '    <P_480>' + TKwota2Nieujemna(z502) + '</P_480>' + nl
		r = r + '    <P_481>' + TKwota2Nieujemna(z503) + '</P_481>' + nl
		r = r + '    <P_482>' + TKwota2Nieujemna(z504) + '</P_482>' + nl
		r = r + '    <P_483>' + TKwota2Nieujemna(z505) + '</P_483>' + nl
		r = r + '    <P_484>' + TKwota2Nieujemna(z506) + '</P_484>' + nl
		r = r + '    <P_485>' + TKwota2Nieujemna(z507) + '</P_485>' + nl
		r = r + '    <P_486>' + TKwota2Nieujemna(z508) + '</P_486>' + nl
		r = r + '    <P_487>' + TKwota2Nieujemna(z509) + '</P_487>' + nl
		r = r + '    <P_488>' + TKwota2Nieujemna(z510) + '</P_488>' + nl
		r = r + '    <P_489>' + TKwota2Nieujemna(z511) + '</P_489>' + nl
		r = r + '    <P_490>' + TKwota2Nieujemna(z512) + '</P_490>' + nl

      IF aPit48Covid[ 1 ]
   		r = r + '    <P_503>1</P_503>' + nl
      ENDIF
      IF aPit48Covid[ 2 ]
   		r = r + '    <P_504>1</P_504>' + nl
      ENDIF
      IF aPit48Covid[ 3 ]
   		r = r + '    <P_505>1</P_505>' + nl
      ENDIF
      IF aPit48Covid[ 4 ]
   		r = r + '    <P_506>1</P_506>' + nl
      ENDIF
      IF aPit48Covid[ 5 ]
   		r = r + '    <P_507>1</P_507>' + nl
      ENDIF
      IF aPit48Covid[ 6 ]
   		r = r + '    <P_508>1</P_508>' + nl
      ENDIF
      IF aPit48Covid[ 7 ]
   		r = r + '    <P_509>1</P_509>' + nl
      ENDIF
      IF aPit48Covid[ 8 ]
   		r = r + '    <P_510>1</P_510>' + nl
      ENDIF
      IF aPit48Covid[ 9 ]
   		r = r + '    <P_511>1</P_511>' + nl
      ENDIF
      IF aPit48Covid[ 10 ]
   		r = r + '    <P_512>1</P_512>' + nl
      ENDIF
      IF aPit48Covid[ 11 ]
   		r = r + '    <P_513>1</P_513>' + nl
      ENDIF
      IF aPit48Covid[ 12 ]
   		r = r + '    <P_514>1</P_514>' + nl
      ENDIF
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v10(tresc_korekty_pit8ar) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit8ar_14()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF zDEKLKOR <> 'D'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2024/10/10/13525/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/09/13/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PPR" kodSystemowy="PT-8AR (14)" rodzajZobowiazania="P" wersjaSchemy="1-0E">PIT-8AR</KodFormularza>' + nl
      r = r + '    <WariantFormularza>14</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_6">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(p4r) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6k + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + xmlNiePusty(z201, '    <P_418>' + TKwotaCNieujemna(z201) + '</P_418>' + nl)
		r = r + xmlNiePusty(z202, '    <P_419>' + TKwotaCNieujemna(z202) + '</P_419>' + nl)
		r = r + xmlNiePusty(z203, '    <P_420>' + TKwotaCNieujemna(z203) + '</P_420>' + nl)
		r = r + xmlNiePusty(z204, '    <P_421>' + TKwotaCNieujemna(z204) + '</P_421>' + nl)
		r = r + xmlNiePusty(z205, '    <P_422>' + TKwotaCNieujemna(z205) + '</P_422>' + nl)
		r = r + xmlNiePusty(z206, '    <P_423>' + TKwotaCNieujemna(z206) + '</P_423>' + nl)
		r = r + xmlNiePusty(z207, '    <P_424>' + TKwotaCNieujemna(z207) + '</P_424>' + nl)
		r = r + xmlNiePusty(z208, '    <P_425>' + TKwotaCNieujemna(z208) + '</P_425>' + nl)
		r = r + xmlNiePusty(z209, '    <P_426>' + TKwotaCNieujemna(z209) + '</P_426>' + nl)
		r = r + xmlNiePusty(z210, '    <P_427>' + TKwotaCNieujemna(z210) + '</P_427>' + nl)
		r = r + xmlNiePusty(z211, '    <P_428>' + TKwotaCNieujemna(z211) + '</P_428>' + nl)
		r = r + xmlNiePusty(z212, '    <P_429>' + TKwotaCNieujemna(z212) + '</P_429>' + nl)
		r = r + xmlNiePusty(z301, '    <P_430>' + TKwota2Nieujemna(z301) + '</P_430>' + nl)
		r = r + xmlNiePusty(z302, '    <P_431>' + TKwota2Nieujemna(z302) + '</P_431>' + nl)
		r = r + xmlNiePusty(z303, '    <P_432>' + TKwota2Nieujemna(z303) + '</P_432>' + nl)
		r = r + xmlNiePusty(z304, '    <P_433>' + TKwota2Nieujemna(z304) + '</P_433>' + nl)
		r = r + xmlNiePusty(z305, '    <P_434>' + TKwota2Nieujemna(z305) + '</P_434>' + nl)
		r = r + xmlNiePusty(z306, '    <P_435>' + TKwota2Nieujemna(z306) + '</P_435>' + nl)
		r = r + xmlNiePusty(z307, '    <P_436>' + TKwota2Nieujemna(z307) + '</P_436>' + nl)
		r = r + xmlNiePusty(z308, '    <P_437>' + TKwota2Nieujemna(z308) + '</P_437>' + nl)
		r = r + xmlNiePusty(z309, '    <P_438>' + TKwota2Nieujemna(z309) + '</P_438>' + nl)
		r = r + xmlNiePusty(z310, '    <P_439>' + TKwota2Nieujemna(z310) + '</P_439>' + nl)
		r = r + xmlNiePusty(z311, '    <P_440>' + TKwota2Nieujemna(z311) + '</P_440>' + nl)
		r = r + xmlNiePusty(z312, '    <P_441>' + TKwota2Nieujemna(z312) + '</P_441>' + nl)
		r = r + xmlNiePusty(z401, '    <P_442>' + TKwotaCNieujemna(z401) + '</P_442>' + nl)
		r = r + xmlNiePusty(z402, '    <P_443>' + TKwotaCNieujemna(z402) + '</P_443>' + nl)
		r = r + xmlNiePusty(z403, '    <P_444>' + TKwotaCNieujemna(z403) + '</P_444>' + nl)
		r = r + xmlNiePusty(z404, '    <P_445>' + TKwotaCNieujemna(z404) + '</P_445>' + nl)
		r = r + xmlNiePusty(z405, '    <P_446>' + TKwotaCNieujemna(z405) + '</P_446>' + nl)
		r = r + xmlNiePusty(z406, '    <P_447>' + TKwotaCNieujemna(z406) + '</P_447>' + nl)
		r = r + xmlNiePusty(z407, '    <P_448>' + TKwotaCNieujemna(z407) + '</P_448>' + nl)
		r = r + xmlNiePusty(z408, '    <P_449>' + TKwotaCNieujemna(z408) + '</P_449>' + nl)
		r = r + xmlNiePusty(z409, '    <P_450>' + TKwotaCNieujemna(z409) + '</P_450>' + nl)
		r = r + xmlNiePusty(z410, '    <P_451>' + TKwotaCNieujemna(z410) + '</P_451>' + nl)
		r = r + xmlNiePusty(z411, '    <P_452>' + TKwotaCNieujemna(z411) + '</P_452>' + nl)
		r = r + xmlNiePusty(z412, '    <P_453>' + TKwotaCNieujemna(z412) + '</P_453>' + nl)
		r = r + '    <P_454>' + TKwota2Nieujemna(z501) + '</P_454>' + nl
		r = r + '    <P_455>' + TKwota2Nieujemna(z502) + '</P_455>' + nl
		r = r + '    <P_456>' + TKwota2Nieujemna(z503) + '</P_456>' + nl
		r = r + '    <P_457>' + TKwota2Nieujemna(z504) + '</P_457>' + nl
		r = r + '    <P_458>' + TKwota2Nieujemna(z505) + '</P_458>' + nl
		r = r + '    <P_459>' + TKwota2Nieujemna(z506) + '</P_459>' + nl
		r = r + '    <P_460>' + TKwota2Nieujemna(z507) + '</P_460>' + nl
		r = r + '    <P_461>' + TKwota2Nieujemna(z508) + '</P_461>' + nl
		r = r + '    <P_462>' + TKwota2Nieujemna(z509) + '</P_462>' + nl
		r = r + '    <P_463>' + TKwota2Nieujemna(z510) + '</P_463>' + nl
		r = r + '    <P_464>' + TKwota2Nieujemna(z511) + '</P_464>' + nl
		r = r + '    <P_465>' + TKwota2Nieujemna(z512) + '</P_465>' + nl

      r = r + '    <P_466>2</P_466>' + nl

		r = r + '    <P_479>' + TKwota2Nieujemna(z501) + '</P_479>' + nl
		r = r + '    <P_480>' + TKwota2Nieujemna(z502) + '</P_480>' + nl
		r = r + '    <P_481>' + TKwota2Nieujemna(z503) + '</P_481>' + nl
		r = r + '    <P_482>' + TKwota2Nieujemna(z504) + '</P_482>' + nl
		r = r + '    <P_483>' + TKwota2Nieujemna(z505) + '</P_483>' + nl
		r = r + '    <P_484>' + TKwota2Nieujemna(z506) + '</P_484>' + nl
		r = r + '    <P_485>' + TKwota2Nieujemna(z507) + '</P_485>' + nl
		r = r + '    <P_486>' + TKwota2Nieujemna(z508) + '</P_486>' + nl
		r = r + '    <P_487>' + TKwota2Nieujemna(z509) + '</P_487>' + nl
		r = r + '    <P_488>' + TKwota2Nieujemna(z510) + '</P_488>' + nl
		r = r + '    <P_489>' + TKwota2Nieujemna(z511) + '</P_489>' + nl
		r = r + '    <P_490>' + TKwota2Nieujemna(z512) + '</P_490>' + nl

      IF aPit48Covid[ 1 ]
   		r = r + '    <P_503>1</P_503>' + nl
      ENDIF
      IF aPit48Covid[ 2 ]
   		r = r + '    <P_504>1</P_504>' + nl
      ENDIF
      IF aPit48Covid[ 3 ]
   		r = r + '    <P_505>1</P_505>' + nl
      ENDIF
      IF aPit48Covid[ 4 ]
   		r = r + '    <P_506>1</P_506>' + nl
      ENDIF
      IF aPit48Covid[ 5 ]
   		r = r + '    <P_507>1</P_507>' + nl
      ENDIF
      IF aPit48Covid[ 6 ]
   		r = r + '    <P_508>1</P_508>' + nl
      ENDIF
      IF aPit48Covid[ 7 ]
   		r = r + '    <P_509>1</P_509>' + nl
      ENDIF
      IF aPit48Covid[ 8 ]
   		r = r + '    <P_510>1</P_510>' + nl
      ENDIF
      IF aPit48Covid[ 9 ]
   		r = r + '    <P_511>1</P_511>' + nl
      ENDIF
      IF aPit48Covid[ 10 ]
   		r = r + '    <P_512>1</P_512>' + nl
      ENDIF
      IF aPit48Covid[ 11 ]
   		r = r + '    <P_513>1</P_513>' + nl
      ENDIF
      IF aPit48Covid[ 12 ]
   		r = r + '    <P_514>1</P_514>' + nl
      ENDIF
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit8ar)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v10(tresc_korekty_pit8ar) + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + '  <Pouczenie>' + str2sxml('Za uchybienie obowiązkom płatnika grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + '  <Pouczenie>' + str2sxml('Za uchybienie obowiązkom płatnika grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik') + '">' + nl
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
		r = r + '  <Pouczenie>' + str2sxml('Za uchybienie obowiązkom płatnika grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
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
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik/Składający') + '">' + nl
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
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2020/07/10/9720/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/07/06/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (25)" rodzajZobowiazania="Z" wersjaSchemy="1-1E">PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>25</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik/Składający') + '">' + nl
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
		r = r + '    <P_51>' + TKwota2Nieujemna(p50_5) + '</P_51>' + nl
		r = r + xmlNiePusty(p51_5, '    <P_52>' + TKwota2Nieujemna(p51_5) + '</P_52>' + nl)
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

FUNCTION edek_pit11_26()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF JAKICEL='K'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2020/11/13/10091/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/07/06/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (26)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>26</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik/Składający') + '">' + nl
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
      IF Len( AllTrim( P29 ) ) > 0
         r = r + '      <etd:NIP>' + trimnip(P29) + '</etd:NIP>' + nl
      ELSEIF Len( AllTrim( P30 ) ) > 0
         r = r + '      <etd:PESEL>' + trimnip(P30) + '</etd:PESEL>' + nl
      ENDIF
      r = r + '      <etd:ImiePierwsze>' + str2sxml(AllTrim(P32)) + '</etd:ImiePierwsze>' + nl
      r = r + '      <etd:Nazwisko>' + str2sxml(AllTrim(P31)) + '</etd:Nazwisko>' + nl
      r = r + '      <etd:DataUrodzenia>' + date2strxml(P36d) + '</etd:DataUrodzenia>' + nl
      IF Len( AllTrim( P_DokIDNr ) ) > 0
         r = r + '      <NrId poz="P_13">' + str2sxml( AllTrim( P_DokIDNr ) ) + '</NrId>' + nl
         r = r + '      <RodzajNrId poz="P_14">' + AllTrim( P_DokIDTyp ) + '</RodzajNrId>' + nl
         r = r + '      <KodKrajuWydania poz="P_15A">' + AllTrim( P_KrajID ) + '</KodKrajuWydania>' + nl
      ENDIF
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
		r = r + '    <P_51>' + TKwota2Nieujemna(p50_5) + '</P_51>' + nl
		r = r + xmlNiePusty(p51_5, '    <P_52>' + TKwota2Nieujemna(p51_5) + '</P_52>' + nl)
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
         r = r + edek_ord_zu3v4(tresc_korekty_pit11) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit11_27()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF JAKICEL='K'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2021/03/04/10477/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/07/06/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (27)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>27</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik/Składający') + '">' + nl
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
      IF Len( AllTrim( P29 ) ) > 0
         r = r + '      <etd:NIP>' + trimnip(P29) + '</etd:NIP>' + nl
      ELSEIF Len( AllTrim( P30 ) ) > 0
         r = r + '      <etd:PESEL>' + trimnip(P30) + '</etd:PESEL>' + nl
      ENDIF
      r = r + '      <etd:ImiePierwsze>' + str2sxml(AllTrim(P32)) + '</etd:ImiePierwsze>' + nl
      r = r + '      <etd:Nazwisko>' + str2sxml(AllTrim(P31)) + '</etd:Nazwisko>' + nl
      r = r + '      <etd:DataUrodzenia>' + date2strxml(P36d) + '</etd:DataUrodzenia>' + nl
      IF Len( AllTrim( P_DokIDNr ) ) > 0
         r = r + '      <NrId poz="P_13">' + str2sxml( AllTrim( P_DokIDNr ) ) + '</NrId>' + nl
         r = r + '      <RodzajNrId poz="P_14">' + AllTrim( P_DokIDTyp ) + '</RodzajNrId>' + nl
         r = r + '      <KodKrajuWydania poz="P_15A">' + AllTrim( P_KrajID ) + '</KodKrajuWydania>' + nl
      ENDIF
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
		r = r + '    <P_51>' + TKwota2Nieujemna(p50_5) + '</P_51>' + nl
		r = r + xmlNiePusty(p51_5, '    <P_52>' + TKwota2Nieujemna(p51_5) + '</P_52>' + nl)
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

		r = r + '    <P_70>' + TKwota2Nieujemna(p50_7) + '</P_70>' + nl
		r = r + '    <P_71>' + TKwota2Nieujemna(p51_7) + '</P_71>' + nl
		r = r + '    <P_72>' + TKwota2Nieujemna(P50_7-P51_7) + '</P_72>' + nl
		r = r + xmlNiePusty(zKOR_ZWIN, '    <P_73>' + TKwota2Nieujemna(zKOR_ZWIN) + '</P_73>' + nl)
		r = r + '    <P_74>' + TKwotaCNieujemna(p53_7) + '</P_74>' + nl
		r = r + '    <P_75>' + TKwota2Nieujemna(p52+p52z) + '</P_75>' + nl
		r = r + '    <P_76>' + TKwota2Nieujemna(p52_R262+p52z_R262) + '</P_76>' + nl
		r = r + '    <P_77>' + TKwota2Nieujemna(p52_R26+p52z_R26) + '</P_77>' + nl
		r = r + '    <P_78>' + TKwota2Nieujemna(p54a+p54za+p64) + '</P_78>' + nl
		r = r + '    <P_79>' + TKwota2Nieujemna(p54a_R262+p54za_R262+p64_R262) + '</P_79>' + nl
		r = r + '    <P_80>' + TKwota2Nieujemna(zKOR_ZDROZ+p54a_R26+p54za_R26+p64_R26) + '</P_80>' + nl
//		r = r + '    <P_70>' + TKwota2Nieujemna(0) + '</P_70>' + nl
//		r = r + '    <P_71>' + TKwota2Nieujemna(0) + '</P_71>' + nl
      r = r + '    <P_92>' + TKwota2Nieujemna(P50_R26 + P50_5_R26) + '</P_92>' + nl
      r = r + '    <P_93>' + TKwota2Nieujemna(P50_R26) + '</P_93>' + nl
      r = r + '    <P_94>' + TKwota2Nieujemna(P50_5_R26) + '</P_94>' + nl
		r = r + '    <P_96>2</P_96>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit11)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v4(tresc_korekty_pit11) + nl
         r = r + '</Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_pit11_29()
   LOCAL r, nl, tmp_cel
      nl = Chr(13) + Chr(10)
      tmp_cel = '1'
      IF JAKICEL='K'
         tmp_cel = '2'
      ENDIF
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2022/11/09/11890/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/03/15/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="PIT-11 (29)" rodzajZobowiazania="Z" wersjaSchemy="1-1E">PIT-11</KodFormularza>' + nl
      r = r + '    <WariantFormularza>29</WariantFormularza>' + nl
		r = r + '    <CelZlozenia poz="P_7">' + tmp_cel + '</CelZlozenia>' + nl
      r = r + '    <Rok>' + AllTrim(Str(Year(p4d))) + '</Rok>' + nl
		r = r + '    <KodUrzedu>' + P6_kod + '</KodUrzedu>' + nl
	   r = r + '  </Naglowek>' + nl
   	r = r + '  <Podmiot1 rola="' + str2sxml('Płatnik/Składający') + '">' + nl
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
      IF Len( AllTrim( P29 ) ) > 0
         r = r + '      <NIP>' + trimnip(P29) + '</NIP>' + nl
      ELSEIF Len( AllTrim( P30 ) ) > 0
         r = r + '      <PESEL>' + trimnip(P30) + '</PESEL>' + nl
      ENDIF
      r = r + '      <ImiePierwsze>' + str2sxml(AllTrim(P32)) + '</ImiePierwsze>' + nl
      r = r + '      <Nazwisko>' + str2sxml(AllTrim(P31)) + '</Nazwisko>' + nl
      r = r + '      <DataUrodzenia>' + date2strxml(P36d) + '</DataUrodzenia>' + nl
      IF Len( AllTrim( P_DokIDNr ) ) > 0
         r = r + '      <NrId poz="P_13">' + str2sxml( AllTrim( P_DokIDNr ) ) + '</NrId>' + nl
         r = r + '      <RodzajNrId poz="P_14">' + AllTrim( P_DokIDTyp ) + '</RodzajNrId>' + nl
         r = r + '      <KodKrajuWydania poz="P_15A">' + AllTrim( P_KrajID ) + '</KodKrajuWydania>' + nl
      ENDIF
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
      IF lPonizej26l
   		r = r + '    <P_36>' + TKwota2Nieujemna(P50_R262) + '</P_36>' + nl
   		r = r + '    <P_37>' + TKwota2Nieujemna(P51_R262) + '</P_37>' + nl
   		r = r + '    <P_38>' + TKwota2Nieujemna(P53a_R262) + '</P_38>' + nl
   		r = r + xmlNiePusty(zKOR_ZWET, '    <P_39>' + TKwota2Nieujemna(zKOR_ZWET) + '</P_39>' + nl)
   		r = r + '    <P_40>' + TKwotaCNieujemna(P55_R262) + '</P_40>' + nl
      ENDIF
      IF lEmeryt
   		r = r + '    <P_43>' + TKwota2Nieujemna(P50_R262) + '</P_43>' + nl
   		r = r + '    <P_44>' + TKwota2Nieujemna(P51_R262) + '</P_44>' + nl
   		r = r + '    <P_45>' + TKwota2Nieujemna(P53a_R262) + '</P_45>' + nl
   		r = r + xmlNiePusty(zKOR_ZWET, '    <P_46>' + TKwota2Nieujemna(zKOR_ZWET) + '</P_46>' + nl)
   		r = r + '    <P_47>' + TKwotaCNieujemna(P55_R262) + '</P_47>' + nl
      ENDIF
		//r = r + '    <P_41>' + TKwota2Nieujemna(0) + '</P_41>' + nl
		//r = r + '    <P_42>' + TKwota2Nieujemna(0) + '</P_42>' + nl
		r = r + '    <P_50>' + TKwota2Nieujemna(p50_3) + '</P_50>' + nl
		r = r + '    <P_51>' + TKwota2Nieujemna(p50_3) + '</P_51>' + nl
		r = r + xmlNiePusty(zKOR_ZWEM, '    <P_52>' + TKwota2Nieujemna(zKOR_ZWEM) + '</P_52>' + nl)
		r = r + '    <P_53>' + TKwotaCNieujemna(p53_3) + '</P_53>' + nl
		r = r + '    <P_54>' + TKwota2Nieujemna(P50_11) + '</P_54>' + nl
		r = r + xmlNiePusty(p51_11, '    <P_55>' + TKwota2Nieujemna(p51_11) + '</P_55>' + nl)
		r = r + '    <P_56>' + TKwota2Nieujemna(p52_11a) + '</P_56>' + nl
		r = r + '    <P_57>' + TKwotaCNieujemna(p53_11) + '</P_57>' + nl
		r = r + '    <P_58>' + TKwota2Nieujemna(p50_5) + '</P_58>' + nl
		r = r + xmlNiePusty(p51_5, '    <P_59>' + TKwota2Nieujemna(p51_5) + '</P_59>' + nl)
		r = r + '    <P_60>' + TKwota2Nieujemna(p52_5a) + '</P_60>' + nl
		r = r + '    <P_61>' + TKwotaCNieujemna(p53_5) + '</P_61>' + nl
      IF lPonizej26l
   		r = r + '    <P_62>' + TKwota2Nieujemna(P50_5_R262) + '</P_62>' + nl
   		r = r + xmlNiePusty(P51_5_R262, '    <P_63>' + TKwota2Nieujemna(P51_5_R262) + '</P_63>' + nl)
   		r = r + '    <P_64>' + TKwota2Nieujemna(P52_5a_R262) + '</P_64>' + nl
   		r = r + '    <P_65>' + TKwotaCNieujemna(P53_5_R262) + '</P_65>' + nl
      ENDIF
      IF lEmeryt
   		r = r + '    <P_66>' + TKwota2Nieujemna(P50_5_R262) + '</P_66>' + nl
   		r = r + xmlNiePusty(P51_5_R262, '    <P_67>' + TKwota2Nieujemna(P51_5_R262) + '</P_67>' + nl)
   		r = r + '    <P_68>' + TKwota2Nieujemna(P52_5a_R262) + '</P_68>' + nl
   		r = r + '    <P_69>' + TKwotaCNieujemna(P53_5_R262) + '</P_69>' + nl
      ENDIF
		r = r + '    <P_70>' + TKwota2Nieujemna(0) + '</P_70>' + nl
		r = r + '    <P_71>' + TKwota2Nieujemna(p52_6a) + '</P_71>' + nl
		r = r + '    <P_72>' + TKwotaCNieujemna(p53_6) + '</P_72>' + nl
		r = r + '    <P_73>' + TKwota2Nieujemna(p50_6) + '</P_73>' + nl
		r = r + '    <P_74>' + TKwota2Nieujemna(p51_6) + '</P_74>' + nl

		r = r + '    <P_90>' + TKwota2Nieujemna(p50_7) + '</P_90>' + nl
		r = r + '    <P_91>' + TKwota2Nieujemna(p51_7) + '</P_91>' + nl
		r = r + '    <P_92>' + TKwota2Nieujemna(P50_7-P51_7) + '</P_92>' + nl
		r = r + xmlNiePusty(zKOR_ZWIN, '    <P_93>' + TKwota2Nieujemna(zKOR_ZWIN) + '</P_93>' + nl)
		r = r + '    <P_94>' + TKwotaCNieujemna(p53_7) + '</P_94>' + nl
		r = r + '    <P_95>' + TKwota2Nieujemna(p52+p52z) + '</P_95>' + nl
		r = r + '    <P_96>' + TKwota2Nieujemna(p52_R262+p52z_R262) + '</P_96>' + nl
		r = r + '    <P_97>' + TKwota2Nieujemna(p52_R26+p52z_R26) + '</P_97>' + nl
		//r = r + '    <P_78>' + TKwota2Nieujemna(p54a+p54za+p64) + '</P_78>' + nl
		//r = r + '    <P_79>' + TKwota2Nieujemna(p54a_R262+p54za_R262+p64_R262) + '</P_79>' + nl
		//r = r + '    <P_80>' + TKwota2Nieujemna(zKOR_ZDROZ+p54a_R26+p54za_R26+p64_R26) + '</P_80>' + nl
//		r = r + '    <P_70>' + TKwota2Nieujemna(0) + '</P_70>' + nl
//		r = r + '    <P_71>' + TKwota2Nieujemna(0) + '</P_71>' + nl
      IF RodzajUlgi == 'T'
         r = r + '    <P_109>' + TKwota2Nieujemna(P50_R26 + P50_5_R26) + '</P_109>' + nl
         r = r + '    <P_110>' + TKwota2Nieujemna(P50_R26) + '</P_110>' + nl
         r = r + '    <P_111>' + TKwota2Nieujemna(P50_5_R26) + '</P_111>' + nl
      ENDIF
      IF RodzajUlgi == 'E'
         r = r + '    <P_114>' + TKwota2Nieujemna(P50_R26 + P50_5_R26) + '</P_114>' + nl
         r = r + '    <P_115>' + TKwota2Nieujemna(P50_R26) + '</P_115>' + nl
         r = r + '    <P_116>' + TKwota2Nieujemna(P50_5_R26) + '</P_116>' + nl
         DO CASE
         CASE cRodzPrzychZwol == '1'
      		r = r + '    <P_118>1</P_118>' + nl
         CASE cRodzPrzychZwol == '2'
      		r = r + '    <P_119>1</P_119>' + nl
         CASE cRodzPrzychZwol == '3'
      		r = r + '    <P_120>1</P_120>' + nl
         ENDCASE
      ENDIF
		r = r + '    <P_121>2</P_121>' + nl
      r = r + '    <P_122>' + TKwota2Nieujemna(SklZdrow) + '</P_122>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      IF tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_pit11)) > 0
         r = r + '<Zalaczniki>' + nl
         r = r + edek_ord_zu3v9(tresc_korekty_pit11) + nl
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
		r = r + '  <Pouczenie>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz.48 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz.U. z 2012 r. poz. 1015, z późn. zm.).') + '</Pouczenie>' + nl
		r = r + '  <Oswiadczenie>' + str2sxml('Oświadczam, że są mi znane przepisy Kodeksu karnego skarbowego o odpowiedzialności za podanie danych niezgodnych z rzeczywistością.') + '</Oswiadczenie>' + nl
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
		r = r + '  <Pouczenie>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz.48 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz.U. z 2012 r. poz. 1015, z późn. zm.).') + '</Pouczenie>' + nl
		r = r + '  <Oswiadczenie>' + str2sxml('Oświadczam, że są mi znane przepisy Kodeksu karnego skarbowego o odpowiedzialności za podanie danych niezgodnych z rzeczywistością.') + '</Oswiadczenie>' + nl
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
		r = r + '  <Pouczenie>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz.51 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz.U. z 2012 r. poz.1015, z późn. zm.).') + '</Pouczenie>' + nl
		r = r + '  <Oswiadczenie>' + str2sxml('Oświadczam, że są mi znane przepisy Kodeksu karnego skarbowego o odpowiedzialności za podanie danych niezgodnych z rzeczywistością.') + '</Oswiadczenie>' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz. 51 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to narażenie podatku na uszczuplenie grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz. 51 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to narażenie podatku na uszczuplenie grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz.54 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to narażenie podatku na uszczuplenie grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz. 52 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to narażenie podatku na uszczuplenie grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz. 52 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to narażenie podatku na uszczuplenie grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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
		r = r + '  <Pouczenie1>' + str2sxml('W przypadku niewpłacenia w obowiązującym terminie kwoty z poz. 55 lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2014 r. poz. 1619, z późn. zm.).') + '</Pouczenie1>' + nl
		r = r + '  <Pouczenie2>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy i przez to narażenie podatku na uszczuplenie grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie2>' + nl
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

FUNCTION edek_vat8_11( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2020/09/22/9926/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-8 (11)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-8</KodFormularza>' + nl
      r = r + '    <WariantFormularza>11</WariantFormularza>' + nl
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
//			r = r + '      <REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
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
		r = r + '    <P_10>' + TKwotaC( aDane[ 'P_10' ] ) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC( aDane[ 'P_11' ] ) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC( aDane[ 'P_12' ] ) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC( aDane[ 'P_13' ] ) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC( aDane[ 'P_14' ] ) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC( aDane[ 'P_15' ] ) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC( aDane[ 'P_16' ] ) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC( aDane[ 'P_17' ] ) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC( aDane[ 'P_18' ] ) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC( aDane[ 'P_19' ] ) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC( aDane[ 'P_20' ] ) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC( aDane[ 'P_21' ] ) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC( aDane[ 'P_22' ] ) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC( aDane[ 'P_23' ] ) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC( aDane[ 'P_24' ] ) + '</P_24>' + nl

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_28>' + zAdrEMail + '</P_28>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_29>' + AllTrim(zDEKLTEL) + '</P_29>' + nl
      ENDIF
		//r = r + '    <P_30>' + date2strxml(Date()) + '</P_30>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3v2(tresc_korekty_vat7) + nl
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat8_12( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2025/02/25/13695/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/09/13/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-8 (12)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-8</KodFormularza>' + nl
      r = r + '    <WariantFormularza>12</WariantFormularza>' + nl
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
//			r = r + '      <REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
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
		r = r + '    <P_10>' + TKwotaC( aDane[ 'P_10' ] ) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC( aDane[ 'P_11' ] ) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC( aDane[ 'P_12' ] ) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC( aDane[ 'P_13' ] ) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC( aDane[ 'P_14' ] ) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC( aDane[ 'P_15' ] ) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC( aDane[ 'P_16' ] ) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC( aDane[ 'P_17' ] ) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC( aDane[ 'P_18' ] ) + '</P_18>' + nl
		r = r + '    <P_19>' + TKwotaC( aDane[ 'P_19' ] ) + '</P_19>' + nl
		r = r + '    <P_20>' + TKwotaC( aDane[ 'P_20' ] ) + '</P_20>' + nl
		r = r + '    <P_21>' + TKwotaC( aDane[ 'P_21' ] ) + '</P_21>' + nl
		r = r + '    <P_22>' + TKwotaC( aDane[ 'P_22' ] ) + '</P_22>' + nl
		r = r + '    <P_23>' + TKwotaC( aDane[ 'P_23' ] ) + '</P_23>' + nl
		r = r + '    <P_24>' + TKwotaC( aDane[ 'P_24' ] ) + '</P_24>' + nl

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_28>' + zAdrEMail + '</P_28>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_29>' + AllTrim(zDEKLTEL) + '</P_29>' + nl
      ENDIF
		//r = r + '    <P_30>' + date2strxml(Date()) + '</P_30>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3v10(tresc_korekty_vat7) + nl
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat9m_10( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2020/09/22/9927/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-9M (10)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-9M</KodFormularza>' + nl
      r = r + '    <WariantFormularza>10</WariantFormularza>' + nl
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
//			r = r + '      <REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
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
		r = r + '    <P_10>' + TKwotaC( aDane[ 'P_10' ] ) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC( aDane[ 'P_11' ] ) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC( aDane[ 'P_12' ] ) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC( aDane[ 'P_13' ] ) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC( aDane[ 'P_14' ] ) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC( aDane[ 'P_15' ] ) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC( aDane[ 'P_16' ] ) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC( aDane[ 'P_17' ] ) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC( aDane[ 'P_18' ] ) + '</P_18>' + nl

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_22>' + zAdrEMail + '</P_22>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_23>' + AllTrim(zDEKLTEL) + '</P_23>' + nl
      ENDIF
		//r = r + '    <P_24>' + date2strxml(Date()) + '</P_24>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3v2(tresc_korekty_vat7) + nl
         ENDIF
         r = r + '  </Zalaczniki>' + nl
      ENDIF
		r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vat9m_11( aDane )
   LOCAL r, nl, tmp_cel
      tmp_cel = '1'
      IF kordek='K'
         tmp_cel = '2'
      ENDIF
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja  xmlns="http://crd.gov.pl/wzor/2025/02/26/13697/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/09/13/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodPodatku="VAT" kodSystemowy="VAT-9M (11)" rodzajZobowiazania="Z" wersjaSchemy="1-0E" >VAT-9M</KodFormularza>' + nl
      r = r + '    <WariantFormularza>11</WariantFormularza>' + nl
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
//			r = r + '      <REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
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
		r = r + '    <P_10>' + TKwotaC( aDane[ 'P_10' ] ) + '</P_10>' + nl
		r = r + '    <P_11>' + TKwotaC( aDane[ 'P_11' ] ) + '</P_11>' + nl
		r = r + '    <P_12>' + TKwotaC( aDane[ 'P_12' ] ) + '</P_12>' + nl
		r = r + '    <P_13>' + TKwotaC( aDane[ 'P_13' ] ) + '</P_13>' + nl
		r = r + '    <P_14>' + TKwotaC( aDane[ 'P_14' ] ) + '</P_14>' + nl
		r = r + '    <P_15>' + TKwotaC( aDane[ 'P_15' ] ) + '</P_15>' + nl
		r = r + '    <P_16>' + TKwotaC( aDane[ 'P_16' ] ) + '</P_16>' + nl
		r = r + '    <P_17>' + TKwotaC( aDane[ 'P_17' ] ) + '</P_17>' + nl
		r = r + '    <P_18>' + TKwotaC( aDane[ 'P_18' ] ) + '</P_18>' + nl

      IF Len( zAdrEMail ) > 0
         r = r + '    <P_22>' + zAdrEMail + '</P_22>' + nl
      ENDIF

      IF Len(AllTrim(zDEKLTEL)) > 0
   		r = r + '    <P_23>' + AllTrim(zDEKLTEL) + '</P_23>' + nl
      ENDIF
		//r = r + '    <P_24>' + date2strxml(Date()) + '</P_24>' + nl
		r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenia>1</Pouczenia>' + nl
      IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
         r = r + '  <Zalaczniki>' + nl
         IF ( tmp_cel = '2' .AND. Len(AllTrim(tresc_korekty_vat7)) > 0 )
            r = r + edek_ord_zu3v10(tresc_korekty_vat7) + nl
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
		r = r + '  <Pouczenie>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
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

FUNCTION edek_vatue_5()
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2020/07/03/9690/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodSystemowy="VAT-UE (5)" wersjaSchemy="1-0E">VAT-UE</KodFormularza>' + nl
      r = r + '    <WariantFormularza>5</WariantFormularza>' + nl
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
			//r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
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
      IF Len( aSekcjaF ) > 0
         FOR i := 1 TO Len( aSekcjaF )
            r = r + '    <Grupa4>' + nl
            r = r + '      <P_Ca>' + AllTrim( aSekcjaF[ i, 'kraj' ] ) + '</P_Ca>' + nl
            r = r + '      <P_Cb>' + edekNipUE( AllTrim( aSekcjaF[ i, 'nip' ] ) ) + '</P_Cb>' + nl
            IF Len( AllTrim( aSekcjaF[ i, 'nipz' ] ) ) > 0
               r = r + '      <P_Cc>' + edekNipUE( AllTrim( aSekcjaF[ i, 'nipz' ] ) ) + '</P_Cc>' + nl
            ELSEIF aSekcjaF[ i, 'powrot' ] $ "TN"
               r = r + '      <P_Cd>' + iif( aSekcjaF[ i, 'powrot' ] == 'T', '2', '1') + '</P_Cd>' + nl
            ENDIF
            r = r + '    </Grupa4>' + nl
         NEXT
      ENDIF
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vatue_5e2()
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2021/01/12/10293/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodSystemowy="VAT-UE (5)" wersjaSchemy="2-0E">VAT-UE</KodFormularza>' + nl
      r = r + '    <WariantFormularza>5</WariantFormularza>' + nl
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
			//r = r + '      <etd:REGON>' +  AllTrim(P11) + '</etd:REGON>' + nl
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
      IF Len( aSekcjaF ) > 0
         FOR i := 1 TO Len( aSekcjaF )
            r = r + '    <Grupa4>' + nl
            r = r + '      <P_Ca>' + AllTrim( aSekcjaF[ i, 'kraj' ] ) + '</P_Ca>' + nl
            r = r + '      <P_Cb>' + edekNipUE( AllTrim( aSekcjaF[ i, 'nip' ] ) ) + '</P_Cb>' + nl
            IF Len( AllTrim( aSekcjaF[ i, 'nipz' ] ) ) > 0
               r = r + '      <P_Cc>' + edekNipUE( AllTrim( aSekcjaF[ i, 'nipz' ] ) ) + '</P_Cc>' + nl
            ELSEIF aSekcjaF[ i, 'powrot' ] $ "TN"
               r = r + '      <P_Cd>' + iif( aSekcjaF[ i, 'powrot' ] == 'T', '2', '1') + '</P_Cd>' + nl
            ENDIF
            r = r + '    </Grupa4>' + nl
         NEXT
      ENDIF
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vatuek_5( aDane )
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2020/07/03/9689/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodSystemowy="VATUEK (5)" wersjaSchemy="1-0E">VAT-UEK</KodFormularza>' + nl
      r = r + '    <WariantFormularza>5</WariantFormularza>' + nl
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
			//r = r + '      <etd:REGON>' +  AllTrim( aDane[ 'regon' ] ) + '</etd:REGON>' + nl
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
      IF Len( aDane[ 'poz_f' ] ) > 0
         FOR i := 1 TO Len( aDane[ 'poz_f' ] )
            r = r + '    <Grupa4>' + nl
            IF ! Empty( AllTrim( aDane[ 'poz_f' ][ i ][ 'bkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_f' ][ i ][ 'bnip' ] ) )

               r = r + '      <P_CBa>' + AllTrim( aDane[ 'poz_f' ][ i ][ 'bkraj' ] ) + '</P_CBa>' + nl
               r = r + '      <P_CBb>' + edekNipUE( AllTrim( aDane[ 'poz_f' ][ i ][ 'bnip' ] ) ) + '</P_CBb>' + nl
               IF Len( AllTrim( aDane[ 'poz_f' ][ i ][ 'bnipz' ] ) ) > 0
                  r = r + '      <P_CBc>' + edekNipUE( AllTrim( aDane[ 'poz_f' ][ i ][ 'bnipz' ] ) ) + '</P_CBc>' + nl
               ELSEIF aDane[ 'poz_f' ][ i ][ 'bpowrot' ] $ "TN"
                  r = r + '      <P_CBd>' + iif( aDane[ 'poz_f' ][ i ][ 'bpowrot' ] == 'T', '2', '1' ) + '</P_CBd>' + nl
               ENDIF
            ENDIF

            IF ! Empty( AllTrim( aDane[ 'poz_f' ][ i ][ 'jkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_f' ][ i ][ 'jnip' ] ) )

               r = r + '      <P_CJa>' + AllTrim( aDane[ 'poz_f' ][ i ][ 'jkraj' ] ) + '</P_CJa>' + nl
               r = r + '      <P_CJb>' + edekNipUE( AllTrim( aDane[ 'poz_f' ][ i ][ 'jnip' ] ) ) + '</P_CJb>' + nl
               IF Len( AllTrim( aDane[ 'poz_f' ][ i ][ 'jnipz' ] ) ) > 0
                  r = r + '      <P_CJc>' + edekNipUE( AllTrim( aDane[ 'poz_f' ][ i ][ 'jnipz' ] ) ) + '</P_CJc>' + nl
               ELSEIF aDane[ 'poz_f' ][ i ][ 'bpowrot' ] $ "TN"
                  r = r + '      <P_CJd>' + iif( aDane[ 'poz_f' ][ i ][ 'bpowrot' ] == 'T', '2', '1' ) + '</P_CJd>' + nl
               ENDIF
            ENDIF
            r = r + '    </Grupa4>' + nl
         NEXT
      ENDIF
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_vatuek_5e2( aDane )
   LOCAL r, nl
      nl = Chr(13) + Chr(10)
      r = '<?xml version="1.0" encoding="UTF-8"?>' + nl
      r = r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2021/01/26/10316/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
      r = r + '  <Naglowek>' + nl
      r = r + '    <KodFormularza kodSystemowy="VATUEK (5)" wersjaSchemy="2-1E">VAT-UEK</KodFormularza>' + nl
      r = r + '    <WariantFormularza>5</WariantFormularza>' + nl
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
			//r = r + '      <etd:REGON>' +  AllTrim( aDane[ 'regon' ] ) + '</etd:REGON>' + nl
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
               r = r + '      <P_DBd>' + iif( aDane[ 'poz_c' ][ i ][ 'trojstr' ] /* == 'T' */, '2', '1' ) + '</P_DBd>' + nl
            ENDIF

            IF ! Empty( AllTrim( aDane[ 'poz_c' ][ i ][ 'jkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_c' ][ i ][ 'jnip' ] ) )

               r = r + '      <P_DJa>' + AllTrim( aDane[ 'poz_c' ][ i ][ 'jkraj' ] ) + '</P_DJa>' + nl
               r = r + '      <P_DJb>' + edekNipUE( AllTrim( aDane[ 'poz_c' ][ i ][ 'jnip' ] ) ) + '</P_DJb>' + nl
               r = r + '      <P_DJc>' + TKwotaC( aDane[ 'poz_c' ][ i ][ 'jwartosc' ] ) + '</P_DJc>' + nl
               r = r + '      <P_DJd>' + iif( aDane[ 'poz_c' ][ i ][ 'jtrojstr' ] /* == 'T' */, '2', '1' ) + '</P_DJd>' + nl
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
               r = r + '      <P_NBd>' + iif( aDane[ 'poz_d' ][ i ][ 'trojstr' ] /* == 'T' */, '2', '1' ) + '</P_NBd>' + nl
            ENDIF

            IF ! Empty( AllTrim( aDane[ 'poz_d' ][ i ][ 'jkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_d' ][ i ][ 'jnip' ] ) )

               r = r + '      <P_NJa>' + AllTrim( aDane[ 'poz_d' ][ i ][ 'jkraj' ] ) + '</P_NJa>' + nl
               r = r + '      <P_NJb>' + edekNipUE( AllTrim( aDane[ 'poz_d' ][ i ][ 'jnip' ] ) ) + '</P_NJb>' + nl
               r = r + '      <P_NJc>' + TKwotaC( aDane[ 'poz_d' ][ i ][ 'jwartosc' ] ) + '</P_NJc>' + nl
               r = r + '      <P_NJd>' + iif( aDane[ 'poz_d' ][ i ][ 'jtrojstr' ] /* == 'T' */, '2', '1' ) + '</P_NJd>' + nl
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
      IF Len( aDane[ 'poz_f' ] ) > 0
         FOR i := 1 TO Len( aDane[ 'poz_f' ] )
            r = r + '    <Grupa4>' + nl
            IF ! Empty( AllTrim( aDane[ 'poz_f' ][ i ][ 'bkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_f' ][ i ][ 'bnip' ] ) )

               r = r + '      <P_CBa>' + AllTrim( aDane[ 'poz_f' ][ i ][ 'bkraj' ] ) + '</P_CBa>' + nl
               r = r + '      <P_CBb>' + edekNipUE( AllTrim( aDane[ 'poz_f' ][ i ][ 'bnip' ] ) ) + '</P_CBb>' + nl
               IF Len( AllTrim( aDane[ 'poz_f' ][ i ][ 'bnipz' ] ) ) > 0
                  r = r + '      <P_CBc>' + edekNipUE( AllTrim( aDane[ 'poz_f' ][ i ][ 'bnipz' ] ) ) + '</P_CBc>' + nl
               ELSEIF aDane[ 'poz_f' ][ i ][ 'bpowrot' ] $ "TN"
                  r = r + '      <P_CBd>' + iif( aDane[ 'poz_f' ][ i ][ 'bpowrot' ] == 'T', '2', '1' ) + '</P_CBd>' + nl
               ENDIF
            ENDIF

            IF ! Empty( AllTrim( aDane[ 'poz_f' ][ i ][ 'jkraj' ] ) ) .AND. ;
               ! Empty( AllTrim( aDane[ 'poz_f' ][ i ][ 'jnip' ] ) )

               r = r + '      <P_CJa>' + AllTrim( aDane[ 'poz_f' ][ i ][ 'jkraj' ] ) + '</P_CJa>' + nl
               r = r + '      <P_CJb>' + edekNipUE( AllTrim( aDane[ 'poz_f' ][ i ][ 'jnip' ] ) ) + '</P_CJb>' + nl
               IF Len( AllTrim( aDane[ 'poz_f' ][ i ][ 'jnipz' ] ) ) > 0
                  r = r + '      <P_CJc>' + edekNipUE( AllTrim( aDane[ 'poz_f' ][ i ][ 'jnipz' ] ) ) + '</P_CJc>' + nl
               ELSEIF aDane[ 'poz_f' ][ i ][ 'bpowrot' ] $ "TN"
                  r = r + '      <P_CJd>' + iif( aDane[ 'poz_f' ][ i ][ 'bpowrot' ] == 'T', '2', '1' ) + '</P_CJd>' + nl
               ENDIF
            ENDIF
            r = r + '    </Grupa4>' + nl
         NEXT
      ENDIF
      r = r + '  </PozycjeSzczegolowe>' + nl
		r = r + '  <Pouczenie>1</Pouczenie>' + nl
      r = r + '</Deklaracja>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_viudo_1( aDane )

   LOCAL r, nl := hb_eol(), nSumT, nSumU, nSumC := 0, cRodzajL

   r := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   r += '<Deklaracja xmlns="http://crd.gov.pl/wzor/2021/08/09/10797/" xmlns:dto="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2021/03/12/eD/DefinicjeTypyOss/">' + nl
   r += '  <Naglowek>' + nl
   r += '    <KodFormularza kodPodatku="VIU" kodSystemowy="VIU-DO (1)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">VIU-DO</KodFormularza>' + nl
   r += '    <WariantFormularza>1</WariantFormularza>' + nl
   r += '    <DataWypelnienia>' + date2strxml( aDane[ 'data_wypelnienia' ] ) + '</DataWypelnienia>' + nl
   r += '    <CelZlozenia>1</CelZlozenia>' + nl
   r += '    <Rok>' + aDane[ 'rok' ] + '</Rok>' + nl
   r += '    <Kwartal>' + TNaturalny( aDane[ 'kwartal' ] ) + '</Kwartal>' + nl
   r += '    <KodUrzedu>' + aDane[ 'kod_urzedu' ] + '</KodUrzedu>' + nl
   r += '  </Naglowek>' + nl

   r += '  <Podmiot1 rola="Podatnik">' + nl
   IF aDane[ 'firma' ][ 'Spolka' ]
      r += '    <dto:OsobaNiefizyczna>' + nl
      r += '      <dto:NIP>' + trimnip( AllTrim( aDane[ 'firma' ][ 'NIP' ] ) )+ '</dto:NIP>' + nl
      r += '      <dto:PelnaNazwa>' + str2sxml( aDane[ 'firma' ][ 'PelnaNazwa' ] ) + '</dto:PelnaNazwa>' + nl
      r += '    </dto:OsobaNiefizyczna>' + nl
   ELSE
      r += '    <dto:OsobaFizyczna>' + nl
      r += '      <dto:NIP>' + trimnip( AllTrim( aDane[ 'firma' ][ 'NIP' ] ) ) + '</dto:NIP>' + nl
      r += '      <dto:ImiePierwsze>' + str2sxml( aDane[ 'firma' ][ 'ImiePierwsze' ] ) + '</dto:ImiePierwsze>' + nl
      r += '      <dto:Nazwisko>' + str2sxml( aDane[ 'firma' ][ 'Nazwisko' ] ) + '</dto:Nazwisko>' + nl
      r += '    </dto:OsobaFizyczna>' + nl
   ENDIF
   r += '  </Podmiot1>' + nl

   r += '  <PozycjeSzczegolowe>' + nl
   IF Empty( aDane[ 'okres_od' ] ) .OR. Empty( aDane[ 'okres_do' ] )
      r += '    <Period/>' + nl
   ELSE
      r += '    <Period>' + nl
      r += '      <dto:StartDate>' + date2strxml( aDane[ 'okres_od' ] ) + '</dto:StartDate>' + nl
      r += '      <dto:EndDate>' + date2strxml( aDane[ 'okres_do' ] ) + '</dto:EndDate>' + nl
      r += '    </Period>' + nl
   ENDIF

   IF ! Empty( aDane[ 'sekcja_c2' ] ) .OR. ! Empty( aDane[ 'sekcja_c3' ] ) .OR. ! Empty( aDane[ 'sekcja_c5' ] )
      r += '    <VATReturnMSCON>' + nl

      IF ! Empty( aDane[ 'sekcja_c2' ] ) .OR. ! Empty( aDane[ 'sekcja_c3' ] )
         r += '      <Supplies>' + nl

         IF ! Empty( aDane[ 'sekcja_c2' ] )
            nSumT := 0
            nSumU := 0

            hb_HEval( aDane[ 'sekcja_c2' ], { | cKraj, aRodzaje |
               r += '        <MSIDSupplies>' + nl

               r += '          <MSCONCountryCode>' + cKraj + '</MSCONCountryCode>' + nl
               r += '          <MSIDSupply>' + nl

               hb_HEval( aRodzaje, { | cRodzaj, aStawki |
                  cRodzajL := cRodzaj
                  hb_HEval( aStawki, { | nStawka, aWartosci |
                     r += '            <dto:OSSVATReturnDetail>' + nl
                     r += '              <dto:SupplyType>' + iif( cRodzajL == 'U', 'SERVICES', 'GOODS' ) + '</dto:SupplyType>' + nl
                     r += '              <dto:VATRate type="' + iif( aWartosci[ 'stawkard' ] == 'O', 'REDUCED', 'STANDARD' ) + '">' + TKwota2( nStawka ) + '</dto:VATRate>' + nl
                     r += '              <dto:TaxableAmount currency="EUR">' + TKwota2( aWartosci[ 'nettoeur' ] ) + '</dto:TaxableAmount>' + nl
                     r += '              <dto:VATAmount currency="EUR">' + TKwota2( aWartosci[ 'vateur' ] ) + '</dto:VATAmount>' + nl
                     r += '            </dto:OSSVATReturnDetail>' + nl

                     IF cRodzajL == 'U'
                        nSumU += aWartosci[ 'vateur' ]
                     ELSE
                        nSumT += aWartosci[ 'vateur' ]
                     ENDIF

                  } )
               } )

               r += '          </MSIDSupply>' + nl
               r += '        </MSIDSupplies>' + nl
            } )

            IF nSumU <> 0
               r += '        <GrandTotalMSIDServices currency="EUR">' + TKwota2( nSumU ) + '</GrandTotalMSIDServices>' + nl
            ENDIF
            IF nSumT <> 0
               r += '        <GrandTotalMSIDGoods currency="EUR">' + TKwota2( nSumT ) + '</GrandTotalMSIDGoods>' + nl
            ENDIF

            nSumC += nSumT + nSumU

         ENDIF

         IF ! Empty( aDane[ 'sekcja_c3' ] )
            nSumT := 0
            nSumU := 0

            hb_HEval( aDane[ 'sekcja_c3' ], { | cKraj, aPozycje |
               r += '        <MSESTSupplies>' + nl
               r += '          <MSCONCountryCode>' + cKraj + '</MSCONCountryCode>' + nl

               AEval( aPozycje, { | aPoz |
                  r += '          <MSESTSupply>' + nl
                  r += '            <VATReturnDetails>' + nl
                  r += '              <EUTraderID>' + nl
                  IF ! Empty( aPoz[ 'nr_idvat' ] )
                     r += '                <dto:VATIdentificationNumber issuedBy="' + aPoz[ 'krajdz' ] + '">' + str2sxml( aPoz[ 'nr_idvat' ] ) + '</dto:VATIdentificationNumber>' + nl
                  ELSE
                     r += '                <dto:TaxReferenceNumber issuedBy="' + aPoz[ 'krajdz' ] + '">' + str2sxml( aPoz[ 'nr_idpod' ] ) + '</dto:TaxReferenceNumber>' + nl
                  ENDIF
                  r += '              </EUTraderID>' + nl
                  r += '              <OSSVATReturnDetail>' + nl
                  r += '                <dto:SupplyType>' + iif( aPoz[ 'rodzdost' ] == 'U', 'SERVICES', 'GOODS' ) + '</dto:SupplyType>' + nl
                  r += '                <dto:VATRate type="' + iif( aPoz[ 'stawkard' ] == 'O', 'REDUCED', 'STANDARD' ) + '">' + TKwota2( aPoz[ 'stawka' ] ) + '</dto:VATRate>' + nl
                  r += '                <dto:TaxableAmount currency="EUR">' + TKwota2( aPoz[ 'nettoeur' ] ) + '</dto:TaxableAmount>' + nl
                  r += '                <dto:VATAmount currency="EUR">' + TKwota2( aPoz[ 'vateur' ] ) + '</dto:VATAmount>' + nl
                  r += '              </OSSVATReturnDetail>' + nl
                  r += '            </VATReturnDetails>' + nl

                  r += '          </MSESTSupply>' + nl

                  IF aPoz[ 'rodzdost' ] == 'U'
                     nSumU += aPoz[ 'vateur' ]
                  ELSE
                     nSumT += aPoz[ 'vateur' ]
                  ENDIF

               } )

               r += '        </MSESTSupplies>' + nl
            } )

            IF nSumU <> 0
               r += '        <GrandTotalMSESTServices currency="EUR">' + TKwota2( nSumU ) + '</GrandTotalMSESTServices>' + nl
            ENDIF
            IF nSumT <> 0
               r += '        <GrandTotalMSESTGoods currency="EUR">' + TKwota2( nSumT ) + '</GrandTotalMSESTGoods>' + nl
            ENDIF

            nSumC += nSumT + nSumU

         ENDIF

         r += '        <GrandTotal currency="EUR">' + TKwota2( nSumC ) + '</GrandTotal>' + nl
         r += '      </Supplies>' + nl
      ENDIF

      IF ! Empty( aDane[ 'sekcja_c5' ] )

         hb_HEval( aDane[ 'sekcja_c5' ], { | cKraj, aPozycje |
            r += '      <Corrections>' + nl
            r += '        <MSCONCountryCode>' + cKraj + '</MSCONCountryCode>' + nl
            r += '        <MSCONCorrections>' + nl

            AEval( aPozycje, { | aPoz |
               r += '          <dto:Correction>' + nl
               r += '            <dto:Period>' + nl
               r += '              <dto:Year>' + aPoz[ 'rok' ] + '</dto:Year>' + nl
               r += '              <dto:Quarter>' + aPoz[ 'kwartal' ] + '</dto:Quarter>' + nl
               r += '            </dto:Period>' + nl
               r += '            <dto:TotalVATAmountCorrection currency="EUR">' + TKwota2( aPoz[ 'kwota' ] ) + '</dto:TotalVATAmountCorrection>' + nl
               r += '          </dto:Correction>' + nl
            } )

            r += '        </MSCONCorrections>' + nl
            r += '      </Corrections>' + nl
         } )

      ENDIF

      r += '    </VATReturnMSCON>' + nl

      IF ! Empty( aDane[ 'sekcja_c6' ] )
         hb_HEval( aDane[ 'sekcja_c6' ], { | cKraj, nKwota |
            r += '    <MSCONBalance>' + nl
            r += '      <MSCONCountryCode>' + cKraj + '</MSCONCountryCode>' + nl
            r += '      <BalanceOfVATDue currency="EUR">' + TKwota2( nKwota ) + '</BalanceOfVATDue>' + nl
            r += '    </MSCONBalance>' + nl
         } )
      ENDIF

      r += '    <TotalAmountOfVATDue currency="EUR">' + TKwota2( aDane[ 'suma_vat' ] ) + '</TotalAmountOfVATDue>' + nl
      r += '  </PozycjeSzczegolowe>' + nl
      r += '  <Pouczenie1>' + str2sxml( 'Za podanie nieprawdy lub zatajenie prawdy i przez to narażenie podatku na uszczuplenie grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.' ) + '</Pouczenie1>' + nl
      r += '  <Pouczenie2>' + str2sxml( 'W przypadku niewpłacenia w obowiązującym terminie kwoty podatku VAT należnej Rzeczpospolitej Polskiej lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego, zgodnie z art. 3a § 1 pkt 1 ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2020 r. poz. 1427, z późn. zm.).' ) + '</Pouczenie2>' + nl
      r += '</Deklaracja>' + nl
   ENDIF

   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_viudo_2( aDane )

   LOCAL r, nl := hb_eol(), nSumT, nSumU, nSumC := 0, cRodzajL

   r := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   r += '<Deklaracja xmlns="http://crd.gov.pl/wzor/2024/05/14/13428/" xmlns:dto="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2021/03/12/eD/DefinicjeTypyOss/">' + nl
   r += '  <Naglowek>' + nl
   r += '    <KodFormularza kodPodatku="VIU" kodSystemowy="VIU-DO (2)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">VIU-DO</KodFormularza>' + nl
   r += '    <WariantFormularza>2</WariantFormularza>' + nl
   r += '    <DataWypelnienia>' + date2strxml( aDane[ 'data_wypelnienia' ] ) + '</DataWypelnienia>' + nl
   r += '    <CelZlozenia>1</CelZlozenia>' + nl
   r += '    <Rok>' + aDane[ 'rok' ] + '</Rok>' + nl
   r += '    <Kwartal>' + TNaturalny( aDane[ 'kwartal' ] ) + '</Kwartal>' + nl
   r += '    <KodUrzedu>' + aDane[ 'kod_urzedu' ] + '</KodUrzedu>' + nl
   r += '  </Naglowek>' + nl

   r += '  <Podmiot1 rola="Podatnik">' + nl
   IF aDane[ 'firma' ][ 'Spolka' ]
      r += '    <dto:OsobaNiefizyczna>' + nl
      r += '      <dto:NIP>' + trimnip( AllTrim( aDane[ 'firma' ][ 'NIP' ] ) )+ '</dto:NIP>' + nl
      r += '      <dto:PelnaNazwa>' + str2sxml( aDane[ 'firma' ][ 'PelnaNazwa' ] ) + '</dto:PelnaNazwa>' + nl
      r += '    </dto:OsobaNiefizyczna>' + nl
   ELSE
      r += '    <dto:OsobaFizyczna>' + nl
      r += '      <dto:NIP>' + trimnip( AllTrim( aDane[ 'firma' ][ 'NIP' ] ) ) + '</dto:NIP>' + nl
      r += '      <dto:ImiePierwsze>' + str2sxml( aDane[ 'firma' ][ 'ImiePierwsze' ] ) + '</dto:ImiePierwsze>' + nl
      r += '      <dto:Nazwisko>' + str2sxml( aDane[ 'firma' ][ 'Nazwisko' ] ) + '</dto:Nazwisko>' + nl
      r += '    </dto:OsobaFizyczna>' + nl
   ENDIF
   r += '  </Podmiot1>' + nl

   r += '  <PozycjeSzczegolowe>' + nl
   IF Empty( aDane[ 'okres_od' ] ) .OR. Empty( aDane[ 'okres_do' ] )
      r += '    <Period></Period>' + nl
   ELSE
      r += '    <Period>' + nl
      r += '      <dto:StartDate>' + date2strxml( aDane[ 'okres_od' ] ) + '</dto:StartDate>' + nl
      r += '      <dto:EndDate>' + date2strxml( aDane[ 'okres_do' ] ) + '</dto:EndDate>' + nl
      r += '    </Period>' + nl
   ENDIF

   IF ! Empty( aDane[ 'sekcja_c2' ] ) .OR. ! Empty( aDane[ 'sekcja_c3' ] ) .OR. ! Empty( aDane[ 'sekcja_c5' ] )
      r += '    <VATReturnMSCON>' + nl

      IF ! Empty( aDane[ 'sekcja_c2' ] ) .OR. ! Empty( aDane[ 'sekcja_c3' ] )
         r += '      <Supplies>' + nl

         IF ! Empty( aDane[ 'sekcja_c2' ] )
            nSumT := 0
            nSumU := 0

            hb_HEval( aDane[ 'sekcja_c2' ], { | cKraj, aRodzaje |
               r += '        <MSIDSupplies>' + nl

               r += '          <MSCONCountryCode>' + cKraj + '</MSCONCountryCode>' + nl
               r += '          <MSIDSupply>' + nl

               hb_HEval( aRodzaje, { | cRodzaj, aStawki |
                  cRodzajL := cRodzaj
                  hb_HEval( aStawki, { | nStawka, aWartosci |
                     r += '            <dto:OSSVATReturnDetail>' + nl
                     r += '              <dto:SupplyType>' + iif( cRodzajL == 'U', 'SERVICES', 'GOODS' ) + '</dto:SupplyType>' + nl
                     r += '              <dto:VATRate type="' + iif( aWartosci[ 'stawkard' ] == 'O', 'REDUCED', 'STANDARD' ) + '">' + TKwota2( nStawka ) + '</dto:VATRate>' + nl
                     r += '              <dto:TaxableAmount currency="EUR">' + TKwota2( aWartosci[ 'nettoeur' ] ) + '</dto:TaxableAmount>' + nl
                     r += '              <dto:VATAmount currency="EUR">' + TKwota2( aWartosci[ 'vateur' ] ) + '</dto:VATAmount>' + nl
                     r += '            </dto:OSSVATReturnDetail>' + nl

                     IF cRodzajL == 'U'
                        nSumU += aWartosci[ 'vateur' ]
                     ELSE
                        nSumT += aWartosci[ 'vateur' ]
                     ENDIF

                  } )
               } )

               r += '          </MSIDSupply>' + nl
               r += '        </MSIDSupplies>' + nl
            } )

            IF nSumU <> 0
               r += '        <GrandTotalMSIDServices currency="EUR">' + TKwota2( nSumU ) + '</GrandTotalMSIDServices>' + nl
            ENDIF
            IF nSumT <> 0
               r += '        <GrandTotalMSIDGoods currency="EUR">' + TKwota2( nSumT ) + '</GrandTotalMSIDGoods>' + nl
            ENDIF

            nSumC += nSumT + nSumU

         ENDIF

         IF ! Empty( aDane[ 'sekcja_c3' ] )
            nSumT := 0
            nSumU := 0

            hb_HEval( aDane[ 'sekcja_c3' ], { | cKraj, aPozycje |
               r += '        <MSESTSupplies>' + nl
               r += '          <MSCONCountryCode>' + cKraj + '</MSCONCountryCode>' + nl

               hb_HEval( aPozycje, { | cKlucz, aPoz |
                  r += '          <MSESTSupply>' + nl
                  r += '            <VATReturnDetails>' + nl
                  r += '              <EUTraderID>' + nl
                  IF ! Empty( aPoz[ 'nr_idvat' ] )
                     r += '                <dto:VATIdentificationNumber issuedBy="' + aPoz[ 'krajdz' ] + '">' + str2sxml( aPoz[ 'nr_idvat' ] ) + '</dto:VATIdentificationNumber>' + nl
                  ELSE
                     r += '                <dto:TaxReferenceNumber issuedBy="' + aPoz[ 'krajdz' ] + '">' + str2sxml( aPoz[ 'nr_idpod' ] ) + '</dto:TaxReferenceNumber>' + nl
                  ENDIF
                  r += '              </EUTraderID>' + nl
                  r += '              <OSSVATReturnDetail>' + nl
                  r += '                <dto:SupplyType>' + iif( aPoz[ 'rodzdost' ] == 'U', 'SERVICES', 'GOODS' ) + '</dto:SupplyType>' + nl
                  r += '                <dto:VATRate type="' + iif( aPoz[ 'stawkard' ] == 'O', 'REDUCED', 'STANDARD' ) + '">' + TKwota2( aPoz[ 'stawka' ] ) + '</dto:VATRate>' + nl
                  r += '                <dto:TaxableAmount currency="EUR">' + TKwota2( aPoz[ 'nettoeur' ] ) + '</dto:TaxableAmount>' + nl
                  r += '                <dto:VATAmount currency="EUR">' + TKwota2( aPoz[ 'vateur' ] ) + '</dto:VATAmount>' + nl
                  r += '              </OSSVATReturnDetail>' + nl
                  r += '            </VATReturnDetails>' + nl

                  r += '          </MSESTSupply>' + nl

                  IF aPoz[ 'rodzdost' ] == 'U'
                     nSumU += aPoz[ 'vateur' ]
                  ELSE
                     nSumT += aPoz[ 'vateur' ]
                  ENDIF

               } )

               r += '        </MSESTSupplies>' + nl
            } )

            IF nSumU <> 0
               r += '        <GrandTotalMSESTServices currency="EUR">' + TKwota2( nSumU ) + '</GrandTotalMSESTServices>' + nl
            ENDIF
            IF nSumT <> 0
               r += '        <GrandTotalMSESTGoods currency="EUR">' + TKwota2( nSumT ) + '</GrandTotalMSESTGoods>' + nl
            ENDIF

            nSumC += nSumT + nSumU

         ENDIF

         r += '        <GrandTotal currency="EUR">' + TKwota2( nSumC ) + '</GrandTotal>' + nl
         r += '      </Supplies>' + nl
      ENDIF

      IF ! Empty( aDane[ 'sekcja_c5' ] )

         hb_HEval( aDane[ 'sekcja_c5' ], { | cKraj, aPozycje |
            r += '      <Corrections>' + nl
            r += '        <MSCONCountryCode>' + cKraj + '</MSCONCountryCode>' + nl
            r += '        <MSCONCorrections>' + nl

            AEval( aPozycje, { | aPoz |
               r += '          <dto:Correction>' + nl
               r += '            <dto:Period>' + nl
               r += '              <dto:Year>' + aPoz[ 'rok' ] + '</dto:Year>' + nl
               r += '              <dto:Quarter>' + aPoz[ 'kwartal' ] + '</dto:Quarter>' + nl
               r += '            </dto:Period>' + nl
               r += '            <dto:TotalVATAmountCorrection currency="EUR">' + TKwota2( aPoz[ 'kwota' ] ) + '</dto:TotalVATAmountCorrection>' + nl
               r += '          </dto:Correction>' + nl
            } )

            r += '        </MSCONCorrections>' + nl
            r += '      </Corrections>' + nl
         } )

      ENDIF

      r += '    </VATReturnMSCON>' + nl

      IF ! Empty( aDane[ 'sekcja_c6' ] )
         hb_HEval( aDane[ 'sekcja_c6' ], { | cKraj, nKwota |
            r += '    <MSCONBalance>' + nl
            r += '      <MSCONCountryCode>' + cKraj + '</MSCONCountryCode>' + nl
            r += '      <BalanceOfVATDue currency="EUR">' + TKwota2( nKwota ) + '</BalanceOfVATDue>' + nl
            r += '    </MSCONBalance>' + nl
         } )
      ENDIF

   ENDIF
   r += '    <TotalAmountOfVATDue currency="EUR">' + TKwota2( aDane[ 'suma_vat' ] ) + '</TotalAmountOfVATDue>' + nl
   r += '  </PozycjeSzczegolowe>' + nl
   r += '  <Pouczenie1>' + str2sxml( 'Za podanie nieprawdy lub zatajenie prawdy i przez to narażenie podatku na uszczuplenie grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.' ) + '</Pouczenie1>' + nl
   r += '  <Pouczenie2>' + str2sxml( 'W przypadku niewpłacenia w obowiązującym terminie kwoty podatku VAT należnej Rzeczpospolitej Polskiej lub wpłacenia jej w niepełnej wysokości, niniejsza deklaracja stanowi podstawę do wystawienia tytułu wykonawczego zgodnie z przepisami ustawy z dnia 17 czerwca 1966 r. o postępowaniu egzekucyjnym w administracji (Dz. U. z 2022 r. poz. 479, z późn. zm.).' ) + '</Pouczenie2>' + nl
   r += '</Deklaracja>' + nl

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
		r = r + '  <Pouczenie>' + str2sxml('Za podanie nieprawdy lub zatajenie prawdy grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym.') + '</Pouczenie>' + nl
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
   r = r + '       <zzu:P_13>' + str2sxml( MemoTran( sUzasadnienieP13, ' ', ' ' ) ) + '</zzu:P_13>' + nl
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
   r = r + '       <zzu:P_13>' + str2sxml( MemoTran( sUzasadnienieP13, ' ', ' ' ) ) + '</zzu:P_13>' + nl
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
   r = r + '       <zzu:P_13>' + str2sxml( MemoTran( sUzasadnienieP13, ' ' , ' ' ) ) + '</zzu:P_13>' + nl
   r = r + '    </zzu:PozycjeSzczegolowe>' + nl
   r = r + '  </zzu:Zalacznik_ORD-ZU>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ord_zu3v3(sUzasadnienieP13)
   LOCAL r, nl
   nl := Chr(13) + Chr(10)
   r = '  <zzu:Zalacznik_ORD-ZU xmlns:zzu="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/25/eD/ORDZU/">' + nl
   r = r + '    <zzu:Naglowek>' + nl
   r = r + '      <zzu:KodFormularza kodSystemowy="ORD-ZU (3)" wersjaSchemy="3-0E">ORD-ZU</zzu:KodFormularza>' + nl
   r = r + '      <zzu:WariantFormularza>3</zzu:WariantFormularza>' + nl
   r = r + '    </zzu:Naglowek>' + nl
   r = r + '    <zzu:PozycjeSzczegolowe>' + nl
   r = r + '       <zzu:P_13>' + str2sxml( MemoTran( sUzasadnienieP13, ' ', ' ' ) ) + '</zzu:P_13>' + nl
   r = r + '    </zzu:PozycjeSzczegolowe>' + nl
   r = r + '  </zzu:Zalacznik_ORD-ZU>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ord_zu3v4(sUzasadnienieP13)
   LOCAL r, nl
   nl := Chr(13) + Chr(10)
   r = '  <zzu:Zalacznik_ORD-ZU xmlns:zzu="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/07/06/eD/ORDZU/">' + nl
   r = r + '    <zzu:Naglowek>' + nl
   r = r + '      <zzu:KodFormularza kodSystemowy="ORD-ZU (3)" wersjaSchemy="4-0E">ORD-ZU</zzu:KodFormularza>' + nl
   r = r + '      <zzu:WariantFormularza>3</zzu:WariantFormularza>' + nl
   r = r + '    </zzu:Naglowek>' + nl
   r = r + '    <zzu:PozycjeSzczegolowe>' + nl
   r = r + '       <zzu:P_13>' + str2sxml( MemoTran( sUzasadnienieP13, ' ', ' ' ) ) + '</zzu:P_13>' + nl
   r = r + '    </zzu:PozycjeSzczegolowe>' + nl
   r = r + '  </zzu:Zalacznik_ORD-ZU>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ord_zu3v9(sUzasadnienieP13)
   LOCAL r, nl
   nl := Chr(13) + Chr(10)
   r = '  <zzu:Zalacznik_ORD-ZU xmlns:zzu="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/03/15/eD/ORDZU/">' + nl
   r = r + '    <zzu:Naglowek>' + nl
   r = r + '      <zzu:KodFormularza kodSystemowy="ORD-ZU (3)" wersjaSchemy="9-0E">ORD-ZU</zzu:KodFormularza>' + nl
   r = r + '      <zzu:WariantFormularza>3</zzu:WariantFormularza>' + nl
   r = r + '    </zzu:Naglowek>' + nl
   r = r + '    <zzu:PozycjeSzczegolowe>' + nl
   r = r + '       <zzu:P_13>' + str2sxml( MemoTran( sUzasadnienieP13, ' ', ' ' ) ) + '</zzu:P_13>' + nl
   r = r + '    </zzu:PozycjeSzczegolowe>' + nl
   r = r + '  </zzu:Zalacznik_ORD-ZU>'
   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ord_zu3v10(sUzasadnienieP13)
   LOCAL r, nl
   nl := Chr(13) + Chr(10)
   r = '  <zzu:Zalacznik_ORD-ZU xmlns:zzu="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/09/13/eD/ORDZU/">' + nl
   r = r + '    <zzu:Naglowek>' + nl
   r = r + '      <zzu:KodFormularza kodSystemowy="ORD-ZU (3)" wersjaSchemy="10-0E">ORD-ZU</zzu:KodFormularza>' + nl
   r = r + '      <zzu:WariantFormularza>3</zzu:WariantFormularza>' + nl
   r = r + '    </zzu:Naglowek>' + nl
   r = r + '    <zzu:PozycjeSzczegolowe>' + nl
   r = r + '       <zzu:P_13>' + str2sxml( MemoTran( sUzasadnienieP13, ' ', ' ' ) ) + '</zzu:P_13>' + nl
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
   r := r + '  <Podmiot1 rola="' + str2sxml( 'Płatnik/Podmiot Wypłacający' ) + '">' + nl
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
   r := r + '  <Podmiot2 rola="' + str2sxml( 'Odbiorca Należności' ) + '">' + nl
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
   r := r + '  <Pouczenie>' + str2sxml( 'Za uchybienie obowiązkom płatnika/podmiotu grozi odpowiedzialność przewidziana w Kodeksie karnym skarbowym. [The infringement of tax remitter/entity duties shall be subject to the sanctions provided for the Fiscal Penal Code].' ) + '</Pouczenie>' + nl
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
   r := r + '  <Podmiot1 rola="' + str2sxml( 'Płatnik/Podmiot Wypłacający' ) + '">' + nl
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
      r := r + '        <etd:NrLokalu>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNrLokalu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r := r + '        <etd:Miejscowosc>' + str2sxml( aDane[ 'Dane' ][ 'FirmaMiejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r := r + '        <etd:KodPocztowy>' + str2sxml( aDane[ 'Dane' ][ 'FirmaKodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   //r := r + '        <etd:Poczta>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPoczta' ] ) + '</etd:Poczta>' + nl
   r := r + '      </etd:AdresPol>' + nl
   r := r + '    </AdresZamieszkaniaSiedziby>' + nl
   r := r + '  </Podmiot1>' + nl
   r := r + '  <Podmiot2 rola="' + str2sxml( 'Odbiorca Należności' ) + '">' + nl
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

FUNCTION edek_ift1_16( aDane )
   LOCAL r, nl := Chr( 13 ) + Chr( 10 )
   r := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   IF aDane[ 'Parametry' ][ 'Roczny' ]
      r := r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2022/03/28/11450/">' + nl
   ELSE
      r := r + '<Deklaracja xmlns="http://crd.gov.pl/wzor/2022/03/28/11451/">' + nl
   ENDIF
   r := r + '  <Naglowek>' + nl
   IF aDane[ 'Parametry' ][ 'Roczny' ]
      r := r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="IFT-1R (16)" rodzajZobowiazania="Z" wersjaSchemy="2-0E">IFT-1/IFT-1R</KodFormularza>'
   ELSE
      r := r + '    <KodFormularza kodPodatku="PIT" kodSystemowy="IFT-1 (16)" rodzajZobowiazania="Z" wersjaSchemy="2-0E">IFT-1/IFT-1R</KodFormularza>'
   ENDIF
   r := r + '    <WariantFormularza>16</WariantFormularza>' + nl
   r := r + '    <CelZlozenia poz="P_7">' + iif( aDane[ 'Parametry' ][ 'Korekta' ], '2', '1' ) + '</CelZlozenia>' + nl
   r := r + '    <OkresOd poz="P_4">' + date2strxml( aDane[ 'Parametry' ][ 'DataOd' ] ) + '</OkresOd>' + nl
   r := r + '    <OkresDo poz="P_5">' + date2strxml( aDane[ 'Parametry' ][ 'DataDo' ] ) + '</OkresDo>' + nl
   r := r + '    <KodUrzedu>' + str2sxml( aDane[ 'Dane' ][ 'KodUrzedu' ] ) + '</KodUrzedu>' + nl
   r := r + '  </Naglowek>' + nl
   r := r + '  <Podmiot1 rola="' + str2sxml( 'Płatnik/Podmiot Wypłacający' ) + '">' + nl
   IF aDane[ 'Dane' ][ 'FirmaSpolka' ]
      r := r + '    <OsobaNiefizyczna>' + nl
      r := r + '      <NIP>' + trimnip( str2sxml( aDane[ 'Dane' ][ 'FirmaNIP' ] ) ) + '</NIP>' + nl
      r := r + '      <PelnaNazwa>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNazwa' ] ) + '</PelnaNazwa>' + nl
      r := r + '    </OsobaNiefizyczna>' + nl
   ELSE
      r := r + '    <OsobaFizyczna>' + nl
      r := r + '      <etd:NIP xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + trimnip( str2sxml( aDane[ 'Dane' ][ 'FirmaNIP' ] ) ) + '</etd:NIP>' + nl
      r := r + '      <etd:ImiePierwsze xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'FirmaImie' ] ) + '</etd:ImiePierwsze>' + nl
      r := r + '      <etd:Nazwisko xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'FirmaNazwisko' ] ) + '</etd:Nazwisko>' + nl
      r := r + '      <etd:DataUrodzenia xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + date2strxml( aDane[ 'Dane' ][ 'FirmaData' ] ) + '</etd:DataUrodzenia>' + nl
      r := r + '    </OsobaFizyczna>' + nl
   ENDIF
   r := r + '    <AdresZamieszkaniaSiedziby rodzajAdresu="RAD">' + nl
   r := r + '      <etd:AdresPol xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + nl
   r := r + '        <etd:KodKraju>PL</etd:KodKraju>' + nl
   r := r + '        <etd:Wojewodztwo>' + str2sxml( aDane[ 'Dane' ][ 'FirmaWojewodztwo' ] ) + '</etd:Wojewodztwo>' + nl
   r := r + '        <etd:Powiat>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPowiat' ] ) + '</etd:Powiat>' + nl
   r := r + '        <etd:Gmina>' + str2sxml( aDane[ 'Dane' ][ 'FirmaGmina' ] ) + '</etd:Gmina>' + nl
   r := r + '        <etd:Ulica>' + str2sxml( aDane[ 'Dane' ][ 'FirmaUlica' ] ) + '</etd:Ulica>' + nl
   r := r + '        <etd:NrDomu>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNrDomu' ] ) + '</etd:NrDomu>' + nl
   IF Len( aDane[ 'Dane' ][ 'FirmaNrLokalu' ] ) > 0
      r := r + '        <etd:NrLokalu>' + str2sxml( aDane[ 'Dane' ][ 'FirmaNrLokalu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r := r + '        <etd:Miejscowosc>' + str2sxml( aDane[ 'Dane' ][ 'FirmaMiejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r := r + '        <etd:KodPocztowy>' + str2sxml( aDane[ 'Dane' ][ 'FirmaKodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   //r := r + '        <etd:Poczta>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPoczta' ] ) + '</etd:Poczta>' + nl
   r := r + '      </etd:AdresPol>' + nl
   r := r + '    </AdresZamieszkaniaSiedziby>' + nl
   r := r + '  </Podmiot1>' + nl
   r := r + '  <Podmiot2 rola="' + str2sxml( 'Odbiorca Należności' ) + '">' + nl
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
   r := r + '      <etd:KodKraju xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaKraj' ] ) + '</etd:KodKraju>' + nl
   r := r + '      <etd:KodPocztowy xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaKodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   r := r + '      <etd:Miejscowosc xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaMiejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r := r + '      <etd:Ulica xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaUlica' ] ) + '</etd:Ulica>' + nl
   r := r + '      <etd:NrDomu xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaNrDomu' ] ) + '</etd:NrDomu>' + nl
   IF Len( aDane[ 'Dane' ][ 'OsobaNrLokalu' ] ) > 0
      r := r + '      <etd:NrLokalu xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Dane' ][ 'OsobaNrLokalu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r := r + '    </AdresZamieszkania>' + nl
   r := r + '  </Podmiot2>' + nl
   r := r + '  <PozycjeSzczegolowe>' + nl
   r := r + '    <P_D>' + nl
   r := r + '      <P_D70>0.00</P_D70>' + nl
   r := r + '      <P_D71>' + TKwota2Nieujemna( aDane[ 'Dane' ][ 'P_71' ] ) + '</P_D71>' + nl
   r := r + '      <P_D72>' + TProcentowy( aDane[ 'Dane' ][ 'P_72' ] ) + '</P_D72>' + nl
   r := r + '      <P_D73>' + TKwota2Nieujemna( aDane[ 'Dane' ][ 'P_73' ] ) + '</P_D73>' + nl
   r := r + '    </P_D>' + nl
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

FUNCTION edek_ift2_9( aDane, lRocznie )

   LOCAL r, nl := Chr( 13 ) + Chr( 10 )

   r := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   IF lRocznie
      r += '<Deklaracja xmlns="http://crd.gov.pl/wzor/2019/12/11/8929/">' + nl
   ELSE
      r += '<Deklaracja xmlns="http://crd.gov.pl/wzor/2019/12/11/8931/">' + nl
   ENDIF
   r += '  <Naglowek>' + nl
   IF lRocznie
      r += '    <KodFormularza kodPodatku="CIT" kodSystemowy="IFT-2R (9)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">IFT-2/IFT-2R</KodFormularza>' + nl
   ELSE
      r += '    <KodFormularza kodPodatku="CIT" kodSystemowy="IFT-2 (9)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">IFT-2/IFT-2R</KodFormularza>' + nl
   ENDIF
   r += '    <WariantFormularza>9</WariantFormularza>' + nl
   r += '    <CelZlozenia poz="P_7">' + aDane[ 'korekta' ] + '</CelZlozenia>' + nl
   r += '    <OkresOd poz="P_4">' + date2strxml( aDane[ 'data_od' ] ) + '</OkresOd>' + nl
   r += '    <OkresDo poz="P_5">' + date2strxml( aDane[ 'data_do' ] ) + '</OkresDo>' + nl
   r += '    <KodUrzedu>' + AllTrim( aDane[ 'Firma' ][ 'KodUrzedu' ] ) + '</KodUrzedu>' + nl
   r += '  </Naglowek>' + nl
   r += '  <Podmiot1 rola="' + str2sxml( 'Płatnik/Podmiot (Wypłacający Należność)' ) + '">' + nl
   IF aDane[ 'Firma' ][ 'Spolka' ]
      r += '    <OsobaNiefizyczna>' + nl
      r += '      <NIP>' + trimnip( str2sxml( aDane[ 'Firma' ][ 'NIP' ] ) ) + '</NIP>' + nl
      r += '      <PelnaNazwa>' + str2sxml( aDane[ 'Firma' ][ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      r += '    </OsobaNiefizyczna>' + nl
   ELSE
      r += '    <OsobaFizyczna>' + nl
      r += '      <etd:NIP xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + trimnip( str2sxml( aDane[ 'Firma' ][ 'NIP' ] ) ) + '</etd:NIP>' + nl
      r += '      <etd:ImiePierwsze xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Firma' ][ 'ImiePierwsze' ] ) + '</etd:ImiePierwsze>' + nl
      r += '      <etd:Nazwisko xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Firma' ][ 'Nazwisko' ] ) + '</etd:Nazwisko>' + nl
      r += '      <etd:DataUrodzenia xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + date2strxml( aDane[ 'Firma' ][ 'DataUrodzenia' ] ) + '</etd:DataUrodzenia>' + nl
      r += '    </OsobaFizyczna>' + nl
   ENDIF
   r += '    <AdresZamieszkaniaSiedziby rodzajAdresu="RAD">' + nl
   r += '      <etd:AdresPol xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
   r += '        <etd:KodKraju>PL</etd:KodKraju>' + nl
   r += '        <etd:Wojewodztwo>' + str2sxml( aDane[ 'Firma' ][ 'Wojewodztwo' ] ) + '</etd:Wojewodztwo>' + nl
   r += '        <etd:Powiat>' + str2sxml( aDane[ 'Firma' ][ 'Powiat' ] ) + '</etd:Powiat>' + nl
   r += '        <etd:Gmina>' + str2sxml( aDane[ 'Firma' ][ 'Gmina' ] ) + '</etd:Gmina>' + nl
   r += '        <etd:Ulica>' + str2sxml( aDane[ 'Firma' ][ 'Ulica' ] ) + '</etd:Ulica>' + nl
   r += '        <etd:NrDomu>' + str2sxml( aDane[ 'Firma' ][ 'NrDomu' ] ) + '</etd:NrDomu>' + nl
   IF ! Empty( aDane[ 'Firma' ][ 'NrLokalu' ] )
      r += '        <etd:NrLokalu>' + str2sxml( aDane[ 'Firma' ][ 'NrLokalu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r += '        <etd:Miejscowosc>' + str2sxml( aDane[ 'Firma' ][ 'Miejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r += '        <etd:KodPocztowy>' + str2sxml( aDane[ 'Firma' ][ 'KodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   //r := r + '        <etd:Poczta>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPoczta' ] ) + '</etd:Poczta>' + nl
   r += '      </etd:AdresPol>' + nl
   r += '    </AdresZamieszkaniaSiedziby>' + nl
   r += '  </Podmiot1>' + nl
   r += '  <Podmiot2 rola="' + str2sxml( 'Podatnik (Odbiorca Należności)' ) + '">' + nl
   r += '    <OsobaNieFizZagr>' + nl
   r += '      <etd:PelnaNazwa xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'nazwa' ] ) + '</etd:PelnaNazwa>' + nl
   IF ! Empty( aDane[ 'nazwaskr' ] )
      r += '      <etd:SkroconaNazwa xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'nazwaskr' ] ) + '</etd:SkroconaNazwa>' + nl
   ENDIF
   IF ! Empty( aDane[ 'datarozp' ] )
      r += '      <DataRozpoczeciaDzialalnosci poz="P_22">' + date2strxml( aDane[ 'datarozp' ] ) + '</DataRozpoczeciaDzialalnosci>' + nl
   ENDIF
   r += '      <RodzajIdentyfikacji poz="P_23">' + aDane[ 'rodzajid' ] + '</RodzajIdentyfikacji>' + nl
   r += '      <NumerIdentyfikacyjnyPodatnika poz="P_24">' + str2sxml( aDane[ 'nridpod' ] ) + '</NumerIdentyfikacyjnyPodatnika>' + nl
   r += '      <KodKrajuWydania poz="P_25">' + aDane[ 'krajwyd' ] + '</KodKrajuWydania>' + nl
   r += '    </OsobaNieFizZagr>' + nl
   r += '    <AdresSiedziby rodzajAdresu="RAD">' + nl
   r += '      <KodKraju>' + aDane[ 'kraj' ] + '</KodKraju>' + nl
   IF ! Empty( aDane[ 'kodpoczt' ] )
      r += '      <KodPocztowy>' + str2sxml( aDane[ 'kodpoczt' ] ) + '</KodPocztowy>' + nl
   ENDIF
   r += '      <Miejscowosc>' + str2sxml( aDane[ 'miasto' ] ) + '</Miejscowosc>' + nl
   IF ! Empty( aDane[ 'ulica' ] )
      r += '      <Ulica>' + str2sxml( aDane[ 'ulica' ] ) + '</Ulica>' + nl
   ENDIF
   IF ! Empty( aDane[ 'nrbud' ] )
      r += '      <NrDomu>' + str2sxml( aDane[ 'nrbud' ] ) + '</NrDomu>' + nl
   ENDIF
   IF ! Empty( aDane[ 'nrlok' ] )
      r += '      <NrLokalu>' + str2sxml( aDane[ 'nrlok' ] ) + '</NrLokalu>' + nl
   ENDIF
   r += '    </AdresSiedziby>' + nl
   r += '  </Podmiot2>' + nl
   r += '  <PozycjeSzczegolowe>' + nl
   IF aDane[ 'D1D' ] <> 0 .OR. aDane[ 'D1E' ] <> 0 .OR. aDane[ 'D1G' ] <> 0
      r += '    <P_32>' + TKwotaC( aDane[ 'D1D' ] ) + '</P_32>' + nl
      r += '    <P_33>' + TKwotaC( aDane[ 'D1E' ] ) + '</P_33>' + nl
      r += '    <P_34>' + TProcentowy( aDane[ 'D1F' ] ) + '</P_34>' + nl
      r += '    <P_35>' + TKwotaC( aDane[ 'D1G' ] ) + '</P_35>' + nl
   ENDIF
   IF aDane[ 'D2D' ] <> 0 .OR. aDane[ 'D2E' ] <> 0 .OR. aDane[ 'D2G' ] <> 0
      r += '    <P_36>' + TKwotaC( aDane[ 'D2D' ] ) + '</P_36>' + nl
      r += '    <P_37>' + TKwotaC( aDane[ 'D2E' ] ) + '</P_37>' + nl
      r += '    <P_38>' + TProcentowy( aDane[ 'D2F' ] ) + '</P_38>' + nl
      r += '    <P_39>' + TKwotaC( aDane[ 'D2G' ] ) + '</P_39>' + nl
   ENDIF
   IF aDane[ 'D3D' ] <> 0 .OR. aDane[ 'D3E' ] <> 0 .OR. aDane[ 'D3G' ] <> 0
      r += '    <P_40>' + TKwotaC( aDane[ 'D3D' ] ) + '</P_40>' + nl
      r += '    <P_41>' + TKwotaC( aDane[ 'D3E' ] ) + '</P_41>' + nl
      r += '    <P_42>' + TProcentowy( aDane[ 'D3F' ] ) + '</P_42>' + nl
      r += '    <P_43>' + TKwotaC( aDane[ 'D3G' ] ) + '</P_43>' + nl
   ENDIF
   IF aDane[ 'D4D' ] <> 0 .OR. aDane[ 'D4E' ] <> 0 .OR. aDane[ 'D4G' ] <> 0
      r += '    <P_44>' + TKwotaC( aDane[ 'D4D' ] ) + '</P_44>' + nl
      r += '    <P_45>' + TKwotaC( aDane[ 'D4E' ] ) + '</P_45>' + nl
      r += '    <P_46>' + TProcentowy( aDane[ 'D4F' ] ) + '</P_46>' + nl
      r += '    <P_47>' + TKwotaC( aDane[ 'D4G' ] ) + '</P_47>' + nl
   ENDIF
   IF aDane[ 'D5D' ] <> 0 .OR. aDane[ 'D5E' ] <> 0 .OR. aDane[ 'D5G' ] <> 0
      r += '    <P_48>' + TKwotaC( aDane[ 'D5D' ] ) + '</P_48>' + nl
      r += '    <P_49>' + TKwotaC( aDane[ 'D5E' ] ) + '</P_49>' + nl
      r += '    <P_50>' + TProcentowy( aDane[ 'D5F' ] ) + '</P_50>' + nl
      r += '    <P_51>' + TKwotaC( aDane[ 'D5G' ] ) + '</P_51>' + nl
   ENDIF
   IF aDane[ 'D6D' ] <> 0 .OR. aDane[ 'D6E' ] <> 0 .OR. aDane[ 'D6G' ] <> 0
      r += '    <P_52>' + TKwotaC( aDane[ 'D6D' ] ) + '</P_52>' + nl
      r += '    <P_53>' + TKwotaC( aDane[ 'D6E' ] ) + '</P_53>' + nl
      r += '    <P_54>' + TProcentowy( aDane[ 'D6F' ] ) + '</P_54>' + nl
      r += '    <P_55>' + TKwotaC( aDane[ 'D6G' ] ) + '</P_55>' + nl
   ENDIF
   IF aDane[ 'D7D' ] <> 0 .OR. aDane[ 'D7E' ] <> 0 .OR. aDane[ 'D7G' ] <> 0
      r += '    <P_56>' + TKwotaC( aDane[ 'D7D' ] ) + '</P_56>' + nl
      r += '    <P_57>' + TKwotaC( aDane[ 'D7E' ] ) + '</P_57>' + nl
      r += '    <P_58>' + TProcentowy( aDane[ 'D7F' ] ) + '</P_58>' + nl
      r += '    <P_59>' + TKwotaC( aDane[ 'D7G' ] ) + '</P_59>' + nl
   ENDIF
   IF aDane[ 'D8D' ] <> 0 .OR. aDane[ 'D8E' ] <> 0 .OR. aDane[ 'D8G' ] <> 0
      r += '    <P_60>' + TKwotaC( aDane[ 'D8D' ] ) + '</P_60>' + nl
      r += '    <P_61>' + TKwotaC( aDane[ 'D8E' ] ) + '</P_61>' + nl
      r += '    <P_62>' + TProcentowy( aDane[ 'D8F' ] ) + '</P_62>' + nl
      r += '    <P_63>' + TKwotaC( aDane[ 'D8G' ] ) + '</P_63>' + nl
   ENDIF
   IF aDane[ 'D9D' ] <> 0 .OR. aDane[ 'D9E' ] <> 0 .OR. aDane[ 'D9G' ] <> 0
      r += '    <P_64>' + TKwotaC( aDane[ 'D9D' ] ) + '</P_64>' + nl
      r += '    <P_65>' + TKwotaC( aDane[ 'D9E' ] ) + '</P_65>' + nl
      r += '    <P_66>' + TProcentowy( aDane[ 'D9F' ] ) + '</P_66>' + nl
      r += '    <P_67>' + TKwotaC( aDane[ 'D9G' ] ) + '</P_67>' + nl
   ENDIF
   IF lRocznie
      r += xmlNiePusty( aDane[ 'K01' ], '    <P_68>' + TKwotaC( aDane[ 'K01' ] ) + '</P_68>' + nl )
      r += xmlNiePusty( aDane[ 'K02' ], '    <P_69>' + TKwotaC( aDane[ 'K02' ] ) + '</P_69>' + nl )
      r += xmlNiePusty( aDane[ 'K03' ], '    <P_70>' + TKwotaC( aDane[ 'K03' ] ) + '</P_70>' + nl )
      r += xmlNiePusty( aDane[ 'K04' ], '    <P_71>' + TKwotaC( aDane[ 'K04' ] ) + '</P_71>' + nl )
      r += xmlNiePusty( aDane[ 'K05' ], '    <P_72>' + TKwotaC( aDane[ 'K05' ] ) + '</P_72>' + nl )
      r += xmlNiePusty( aDane[ 'K06' ], '    <P_73>' + TKwotaC( aDane[ 'K06' ] ) + '</P_73>' + nl )
      r += xmlNiePusty( aDane[ 'P01' ], '    <P_74>' + TKwotaC( aDane[ 'P01' ] ) + '</P_74>' + nl )
      r += xmlNiePusty( aDane[ 'P02' ], '    <P_75>' + TKwotaC( aDane[ 'P02' ] ) + '</P_75>' + nl )
      r += xmlNiePusty( aDane[ 'P03' ], '    <P_76>' + TKwotaC( aDane[ 'P03' ] ) + '</P_76>' + nl )
      r += xmlNiePusty( aDane[ 'P04' ], '    <P_77>' + TKwotaC( aDane[ 'P04' ] ) + '</P_77>' + nl )
      r += xmlNiePusty( aDane[ 'P05' ], '    <P_78>' + TKwotaC( aDane[ 'P05' ] ) + '</P_78>' + nl )
      r += xmlNiePusty( aDane[ 'P06' ], '    <P_79>' + TKwotaC( aDane[ 'P06' ] ) + '</P_79>' + nl )
      r += xmlNiePusty( aDane[ 'K07' ], '    <P_80>' + TKwotaC( aDane[ 'K07' ] ) + '</P_80>' + nl )
      r += xmlNiePusty( aDane[ 'K08' ], '    <P_81>' + TKwotaC( aDane[ 'K08' ] ) + '</P_81>' + nl )
      r += xmlNiePusty( aDane[ 'K09' ], '    <P_82>' + TKwotaC( aDane[ 'K09' ] ) + '</P_82>' + nl )
      r += xmlNiePusty( aDane[ 'K10' ], '    <P_83>' + TKwotaC( aDane[ 'K10' ] ) + '</P_83>' + nl )
      r += xmlNiePusty( aDane[ 'K11' ], '    <P_84>' + TKwotaC( aDane[ 'K11' ] ) + '</P_84>' + nl )
      r += xmlNiePusty( aDane[ 'K12' ], '    <P_85>' + TKwotaC( aDane[ 'K12' ] ) + '</P_85>' + nl )
      r += xmlNiePusty( aDane[ 'P07' ], '    <P_86>' + TKwotaC( aDane[ 'P07' ] ) + '</P_86>' + nl )
      r += xmlNiePusty( aDane[ 'P08' ], '    <P_87>' + TKwotaC( aDane[ 'P08' ] ) + '</P_87>' + nl )
      r += xmlNiePusty( aDane[ 'P09' ], '    <P_88>' + TKwotaC( aDane[ 'P09' ] ) + '</P_88>' + nl )
      r += xmlNiePusty( aDane[ 'P10' ], '    <P_89>' + TKwotaC( aDane[ 'P10' ] ) + '</P_89>' + nl )
      r += xmlNiePusty( aDane[ 'P11' ], '    <P_90>' + TKwotaC( aDane[ 'P11' ] ) + '</P_90>' + nl )
      r += xmlNiePusty( aDane[ 'P12' ], '    <P_91>' + TKwotaC( aDane[ 'P12' ] ) + '</P_91>' + nl )
      r += xmlNiePusty( aDane[ 'K13' ], '    <P_92>' + TKwotaC( aDane[ 'K13' ] ) + '</P_92>' + nl )
      r += xmlNiePusty( aDane[ 'K14' ], '    <P_93>' + TKwotaC( aDane[ 'K14' ] ) + '</P_93>' + nl )
      r += xmlNiePusty( aDane[ 'K15' ], '    <P_94>' + TKwotaC( aDane[ 'K15' ] ) + '</P_94>' + nl )
      r += xmlNiePusty( aDane[ 'K16' ], '    <P_95>' + TKwotaC( aDane[ 'K16' ] ) + '</P_95>' + nl )
      r += xmlNiePusty( aDane[ 'K17' ], '    <P_96>' + TKwotaC( aDane[ 'K17' ] ) + '</P_96>' + nl )
      r += xmlNiePusty( aDane[ 'K18' ], '    <P_97>' + TKwotaC( aDane[ 'K18' ] ) + '</P_97>' + nl )
      r += xmlNiePusty( aDane[ 'P13' ], '    <P_98>' + TKwotaC( aDane[ 'P13' ] ) + '</P_98>' + nl )
      r += xmlNiePusty( aDane[ 'P14' ], '    <P_99>' + TKwotaC( aDane[ 'P14' ] ) + '</P_99>' + nl )
      r += xmlNiePusty( aDane[ 'P15' ], '    <P_100>' + TKwotaC( aDane[ 'P15' ] ) + '</P_100>' + nl )
      r += xmlNiePusty( aDane[ 'P16' ], '    <P_101>' + TKwotaC( aDane[ 'P16' ] ) + '</P_101>' + nl )
      r += xmlNiePusty( aDane[ 'P17' ], '    <P_102>' + TKwotaC( aDane[ 'P17' ] ) + '</P_102>' + nl )
      r += xmlNiePusty( aDane[ 'P18' ], '    <P_103>' + TKwotaC( aDane[ 'P18' ] ) + '</P_103>' + nl )
      r += xmlNiePusty( aDane[ 'K01' ], '    <P_104>' + TKwotaC( aDane[ 'K19' ] ) + '</P_104>' + nl )
      r += xmlNiePusty( aDane[ 'K02' ], '    <P_105>' + TKwotaC( aDane[ 'K20' ] ) + '</P_105>' + nl )
      r += xmlNiePusty( aDane[ 'K03' ], '    <P_106>' + TKwotaC( aDane[ 'K21' ] ) + '</P_106>' + nl )
      r += xmlNiePusty( aDane[ 'K04' ], '    <P_107>' + TKwotaC( aDane[ 'K22' ] ) + '</P_107>' + nl )
      r += xmlNiePusty( aDane[ 'K05' ], '    <P_108>' + TKwotaC( aDane[ 'K23' ] ) + '</P_108>' + nl )
      r += xmlNiePusty( aDane[ 'P19' ], '    <P_110>' + TKwotaC( aDane[ 'P19' ] ) + '</P_110>' + nl )
      r += xmlNiePusty( aDane[ 'P20' ], '    <P_111>' + TKwotaC( aDane[ 'P20' ] ) + '</P_111>' + nl )
      r += xmlNiePusty( aDane[ 'P21' ], '    <P_112>' + TKwotaC( aDane[ 'P21' ] ) + '</P_112>' + nl )
      r += xmlNiePusty( aDane[ 'P22' ], '    <P_113>' + TKwotaC( aDane[ 'P22' ] ) + '</P_113>' + nl )
      r += xmlNiePusty( aDane[ 'P23' ], '    <P_114>' + TKwotaC( aDane[ 'P23' ] ) + '</P_114>' + nl )
      r += '    <P_109>' + TKwotaC( aDane[ 'KR' ] ) + '</P_109>' + nl
      r += '    <P_115>' + TKwotaC( aDane[ 'PR' ] ) + '</P_115>' + nl
      r += '    <P_116>' + TNaturalny( aDane[ 'miesiace' ] ) + '</P_116>' + nl
   ENDIF
   IF ! lRocznie .AND. ! Empty( aDane[ 'data_zl' ] )
      r += '    <P_117>' + date2strxml( aDane[ 'data_zl' ] ) + '</P_117>' + nl
   ENDIF
   r += '    <P_118>' + date2strxml( aDane[ 'data_prz' ] ) + '</P_118>' + nl
   r += '  </PozycjeSzczegolowe>' + nl
   r += '  <Pouczenie>1</Pouczenie>' + nl
   r += '</Deklaracja>' + nl

   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ift2_10( aDane, lRocznie )

   LOCAL r, nl := Chr( 13 ) + Chr( 10 )

   r := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   IF lRocznie
      r += '<Deklaracja xmlns="http://crd.gov.pl/wzor/2024/04/17/13400/">' + nl
   ELSE
      r += '<Deklaracja xmlns="http://crd.gov.pl/wzor/2024/04/16/13399/">' + nl
   ENDIF
   r += '  <Naglowek>' + nl
   IF lRocznie
      r += '    <KodFormularza kodPodatku="CIT" kodSystemowy="IFT-2R (10)" rodzajZobowiazania="Z" wersjaSchemy="3-0E">IFT-2/IFT-2R</KodFormularza>' + nl
   ELSE
      r += '    <KodFormularza kodPodatku="CIT" kodSystemowy="IFT-2 (10)" rodzajZobowiazania="Z" wersjaSchemy="3-0E">IFT-2/IFT-2R</KodFormularza>' + nl
   ENDIF
   r += '    <WariantFormularza>10</WariantFormularza>' + nl
   r += '    <CelZlozenia poz="P_7">' + aDane[ 'korekta' ] + '</CelZlozenia>' + nl
   r += '    <OkresOd poz="P_4">' + date2strxml( aDane[ 'data_od' ] ) + '</OkresOd>' + nl
   r += '    <OkresDo poz="P_5">' + date2strxml( aDane[ 'data_do' ] ) + '</OkresDo>' + nl
   r += '    <KodUrzedu>' + AllTrim( aDane[ 'Firma' ][ 'KodUrzedu' ] ) + '</KodUrzedu>' + nl
   r += '  </Naglowek>' + nl
   r += '  <Podmiot1 rola="' + str2sxml( 'Płatnik/Podmiot (Wypłacający Należność)' ) + '">' + nl
   IF aDane[ 'Firma' ][ 'Spolka' ]
      r += '    <OsobaNiefizyczna>' + nl
      r += '      <NIP>' + trimnip( str2sxml( aDane[ 'Firma' ][ 'NIP' ] ) ) + '</NIP>' + nl
      r += '      <PelnaNazwa>' + str2sxml( aDane[ 'Firma' ][ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      r += '    </OsobaNiefizyczna>' + nl
   ELSE
      r += '    <OsobaFizyczna>' + nl
      r += '      <etd:NIP xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + trimnip( str2sxml( aDane[ 'Firma' ][ 'NIP' ] ) ) + '</etd:NIP>' + nl
      r += '      <etd:ImiePierwsze xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Firma' ][ 'ImiePierwsze' ] ) + '</etd:ImiePierwsze>' + nl
      r += '      <etd:Nazwisko xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'Firma' ][ 'Nazwisko' ] ) + '</etd:Nazwisko>' + nl
      r += '      <etd:DataUrodzenia xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + date2strxml( aDane[ 'Firma' ][ 'DataUrodzenia' ] ) + '</etd:DataUrodzenia>' + nl
      r += '    </OsobaFizyczna>' + nl
   ENDIF
   r += '    <AdresZamieszkaniaSiedziby rodzajAdresu="RAD">' + nl
   r += '      <etd:AdresPol xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + nl
   r += '        <etd:KodKraju>PL</etd:KodKraju>' + nl
   r += '        <etd:Wojewodztwo>' + str2sxml( aDane[ 'Firma' ][ 'Wojewodztwo' ] ) + '</etd:Wojewodztwo>' + nl
   r += '        <etd:Powiat>' + str2sxml( aDane[ 'Firma' ][ 'Powiat' ] ) + '</etd:Powiat>' + nl
   r += '        <etd:Gmina>' + str2sxml( aDane[ 'Firma' ][ 'Gmina' ] ) + '</etd:Gmina>' + nl
   r += '        <etd:Ulica>' + str2sxml( aDane[ 'Firma' ][ 'Ulica' ] ) + '</etd:Ulica>' + nl
   r += '        <etd:NrDomu>' + str2sxml( aDane[ 'Firma' ][ 'NrDomu' ] ) + '</etd:NrDomu>' + nl
   IF ! Empty( aDane[ 'Firma' ][ 'NrLokalu' ] )
      r += '        <etd:NrLokalu>' + str2sxml( aDane[ 'Firma' ][ 'NrLokalu' ] ) + '</etd:NrLokalu>' + nl
   ENDIF
   r += '        <etd:Miejscowosc>' + str2sxml( aDane[ 'Firma' ][ 'Miejscowosc' ] ) + '</etd:Miejscowosc>' + nl
   r += '        <etd:KodPocztowy>' + str2sxml( aDane[ 'Firma' ][ 'KodPocztowy' ] ) + '</etd:KodPocztowy>' + nl
   //r := r + '        <etd:Poczta>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPoczta' ] ) + '</etd:Poczta>' + nl
   r += '      </etd:AdresPol>' + nl
   r += '    </AdresZamieszkaniaSiedziby>' + nl
   r += '  </Podmiot1>' + nl
   r += '  <Podmiot2 rola="' + str2sxml( 'Podatnik (Odbiorca Należności)' ) + '">' + nl
   r += '    <OsobaNieFizZagr>' + nl
   r += '      <etd:PelnaNazwa xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'nazwa' ] ) + '</etd:PelnaNazwa>' + nl
   IF ! Empty( aDane[ 'nazwaskr' ] )
      r += '      <etd:SkroconaNazwa xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/01/05/eD/DefinicjeTypy/">' + str2sxml( aDane[ 'nazwaskr' ] ) + '</etd:SkroconaNazwa>' + nl
   ENDIF
   IF ! Empty( aDane[ 'datarozp' ] )
      r += '      <DataRozpoczeciaDzialalnosci poz="P_22">' + date2strxml( aDane[ 'datarozp' ] ) + '</DataRozpoczeciaDzialalnosci>' + nl
   ENDIF
   r += '      <RodzajIdentyfikacji poz="P_23">' + aDane[ 'rodzajid' ] + '</RodzajIdentyfikacji>' + nl
   r += '      <NumerIdentyfikacyjnyPodatnika poz="P_24">' + str2sxml( aDane[ 'nridpod' ] ) + '</NumerIdentyfikacyjnyPodatnika>' + nl
   r += '      <KodKrajuWydania poz="P_25">' + aDane[ 'krajwyd' ] + '</KodKrajuWydania>' + nl
   r += '    </OsobaNieFizZagr>' + nl
   r += '    <AdresSiedziby rodzajAdresu="RAD">' + nl
   r += '      <KodKraju>' + aDane[ 'kraj' ] + '</KodKraju>' + nl
   IF ! Empty( aDane[ 'kodpoczt' ] )
      r += '      <KodPocztowy>' + str2sxml( aDane[ 'kodpoczt' ] ) + '</KodPocztowy>' + nl
   ENDIF
   r += '      <Miejscowosc>' + str2sxml( aDane[ 'miasto' ] ) + '</Miejscowosc>' + nl
   IF ! Empty( aDane[ 'ulica' ] )
      r += '      <Ulica>' + str2sxml( aDane[ 'ulica' ] ) + '</Ulica>' + nl
   ENDIF
   IF ! Empty( aDane[ 'nrbud' ] )
      r += '      <NrDomu>' + str2sxml( aDane[ 'nrbud' ] ) + '</NrDomu>' + nl
   ENDIF
   IF ! Empty( aDane[ 'nrlok' ] )
      r += '      <NrLokalu>' + str2sxml( aDane[ 'nrlok' ] ) + '</NrLokalu>' + nl
   ENDIF
   r += '    </AdresSiedziby>' + nl
   r += '  </Podmiot2>' + nl
   r += '  <PozycjeSzczegolowe>' + nl
   IF aDane[ 'D1D' ] <> 0 .OR. aDane[ 'D1E' ] <> 0 .OR. aDane[ 'D1G' ] <> 0
      r += '    <P_32>' + TKwotaC( aDane[ 'D1D' ] ) + '</P_32>' + nl
      r += '    <P_33>' + TKwotaC( aDane[ 'D1E' ] ) + '</P_33>' + nl
      r += '    <P_34>' + TProcentowy( aDane[ 'D1F' ] ) + '</P_34>' + nl
      r += '    <P_35>' + TKwotaC( aDane[ 'D1G' ] ) + '</P_35>' + nl
   ENDIF
   IF aDane[ 'D2D' ] <> 0 .OR. aDane[ 'D2E' ] <> 0 .OR. aDane[ 'D2G' ] <> 0
      r += '    <P_36>' + TKwotaC( aDane[ 'D2D' ] ) + '</P_36>' + nl
      r += '    <P_37>' + TKwotaC( aDane[ 'D2E' ] ) + '</P_37>' + nl
      r += '    <P_38>' + TProcentowy( aDane[ 'D2F' ] ) + '</P_38>' + nl
      r += '    <P_39>' + TKwotaC( aDane[ 'D2G' ] ) + '</P_39>' + nl
   ENDIF
   IF aDane[ 'D3D' ] <> 0 .OR. aDane[ 'D3E' ] <> 0 .OR. aDane[ 'D3G' ] <> 0
      r += '    <P_40>' + TKwotaC( aDane[ 'D3D' ] ) + '</P_40>' + nl
      r += '    <P_41>' + TKwotaC( aDane[ 'D3E' ] ) + '</P_41>' + nl
      r += '    <P_42>' + TProcentowy( aDane[ 'D3F' ] ) + '</P_42>' + nl
      r += '    <P_43>' + TKwotaC( aDane[ 'D3G' ] ) + '</P_43>' + nl
   ENDIF
   IF aDane[ 'D4D' ] <> 0 .OR. aDane[ 'D4E' ] <> 0 .OR. aDane[ 'D4G' ] <> 0
      r += '    <P_44>' + TKwotaC( aDane[ 'D4D' ] ) + '</P_44>' + nl
      r += '    <P_45>' + TKwotaC( aDane[ 'D4E' ] ) + '</P_45>' + nl
      r += '    <P_46>' + TProcentowy( aDane[ 'D4F' ] ) + '</P_46>' + nl
      r += '    <P_47>' + TKwotaC( aDane[ 'D4G' ] ) + '</P_47>' + nl
   ENDIF
   IF aDane[ 'D5D' ] <> 0 .OR. aDane[ 'D5E' ] <> 0 .OR. aDane[ 'D5G' ] <> 0
      r += '    <P_48>' + TKwotaC( aDane[ 'D5D' ] ) + '</P_48>' + nl
      r += '    <P_49>' + TKwotaC( aDane[ 'D5E' ] ) + '</P_49>' + nl
      r += '    <P_50>' + TProcentowy( aDane[ 'D5F' ] ) + '</P_50>' + nl
      r += '    <P_51>' + TKwotaC( aDane[ 'D5G' ] ) + '</P_51>' + nl
   ENDIF
   IF aDane[ 'D6D' ] <> 0 .OR. aDane[ 'D6E' ] <> 0 .OR. aDane[ 'D6G' ] <> 0
      r += '    <P_52>' + TKwotaC( aDane[ 'D6D' ] ) + '</P_52>' + nl
      r += '    <P_53>' + TKwotaC( aDane[ 'D6E' ] ) + '</P_53>' + nl
      r += '    <P_54>' + TProcentowy( aDane[ 'D6F' ] ) + '</P_54>' + nl
      r += '    <P_55>' + TKwotaC( aDane[ 'D6G' ] ) + '</P_55>' + nl
   ENDIF
   IF aDane[ 'D7D' ] <> 0 .OR. aDane[ 'D7E' ] <> 0 .OR. aDane[ 'D7G' ] <> 0
      r += '    <P_56>' + TKwotaC( aDane[ 'D7D' ] ) + '</P_56>' + nl
      r += '    <P_57>' + TKwotaC( aDane[ 'D7E' ] ) + '</P_57>' + nl
      r += '    <P_58>' + TProcentowy( aDane[ 'D7F' ] ) + '</P_58>' + nl
      r += '    <P_59>' + TKwotaC( aDane[ 'D7G' ] ) + '</P_59>' + nl
   ENDIF
   IF aDane[ 'D8D' ] <> 0 .OR. aDane[ 'D8E' ] <> 0 .OR. aDane[ 'D8G' ] <> 0
      r += '    <P_60>' + TKwotaC( aDane[ 'D8D' ] ) + '</P_60>' + nl
      r += '    <P_61>' + TKwotaC( aDane[ 'D8E' ] ) + '</P_61>' + nl
      r += '    <P_62>' + TProcentowy( aDane[ 'D8F' ] ) + '</P_62>' + nl
      r += '    <P_63>' + TKwotaC( aDane[ 'D8G' ] ) + '</P_63>' + nl
   ENDIF
   IF aDane[ 'D9D' ] <> 0 .OR. aDane[ 'D9E' ] <> 0 .OR. aDane[ 'D9G' ] <> 0
      r += '    <P_64>' + TKwotaC( aDane[ 'D9D' ] ) + '</P_64>' + nl
      r += '    <P_65>' + TKwotaC( aDane[ 'D9E' ] ) + '</P_65>' + nl
      r += '    <P_66>' + TProcentowy( aDane[ 'D9F' ] ) + '</P_66>' + nl
      r += '    <P_67>' + TKwotaC( aDane[ 'D9G' ] ) + '</P_67>' + nl
   ENDIF
   IF lRocznie
      r += xmlNiePusty( aDane[ 'K01' ], '    <P_68>' + TKwotaC( aDane[ 'K01' ] ) + '</P_68>' + nl )
      r += xmlNiePusty( aDane[ 'K02' ], '    <P_69>' + TKwotaC( aDane[ 'K02' ] ) + '</P_69>' + nl )
      r += xmlNiePusty( aDane[ 'K03' ], '    <P_70>' + TKwotaC( aDane[ 'K03' ] ) + '</P_70>' + nl )
      r += xmlNiePusty( aDane[ 'K04' ], '    <P_71>' + TKwotaC( aDane[ 'K04' ] ) + '</P_71>' + nl )
      r += xmlNiePusty( aDane[ 'K05' ], '    <P_72>' + TKwotaC( aDane[ 'K05' ] ) + '</P_72>' + nl )
      r += xmlNiePusty( aDane[ 'K06' ], '    <P_73>' + TKwotaC( aDane[ 'K06' ] ) + '</P_73>' + nl )
      r += xmlNiePusty( aDane[ 'P01' ], '    <P_74>' + TKwotaC( aDane[ 'P01' ] ) + '</P_74>' + nl )
      r += xmlNiePusty( aDane[ 'P02' ], '    <P_75>' + TKwotaC( aDane[ 'P02' ] ) + '</P_75>' + nl )
      r += xmlNiePusty( aDane[ 'P03' ], '    <P_76>' + TKwotaC( aDane[ 'P03' ] ) + '</P_76>' + nl )
      r += xmlNiePusty( aDane[ 'P04' ], '    <P_77>' + TKwotaC( aDane[ 'P04' ] ) + '</P_77>' + nl )
      r += xmlNiePusty( aDane[ 'P05' ], '    <P_78>' + TKwotaC( aDane[ 'P05' ] ) + '</P_78>' + nl )
      r += xmlNiePusty( aDane[ 'P06' ], '    <P_79>' + TKwotaC( aDane[ 'P06' ] ) + '</P_79>' + nl )
      r += xmlNiePusty( aDane[ 'K07' ], '    <P_80>' + TKwotaC( aDane[ 'K07' ] ) + '</P_80>' + nl )
      r += xmlNiePusty( aDane[ 'K08' ], '    <P_81>' + TKwotaC( aDane[ 'K08' ] ) + '</P_81>' + nl )
      r += xmlNiePusty( aDane[ 'K09' ], '    <P_82>' + TKwotaC( aDane[ 'K09' ] ) + '</P_82>' + nl )
      r += xmlNiePusty( aDane[ 'K10' ], '    <P_83>' + TKwotaC( aDane[ 'K10' ] ) + '</P_83>' + nl )
      r += xmlNiePusty( aDane[ 'K11' ], '    <P_84>' + TKwotaC( aDane[ 'K11' ] ) + '</P_84>' + nl )
      r += xmlNiePusty( aDane[ 'K12' ], '    <P_85>' + TKwotaC( aDane[ 'K12' ] ) + '</P_85>' + nl )
      r += xmlNiePusty( aDane[ 'P07' ], '    <P_86>' + TKwotaC( aDane[ 'P07' ] ) + '</P_86>' + nl )
      r += xmlNiePusty( aDane[ 'P08' ], '    <P_87>' + TKwotaC( aDane[ 'P08' ] ) + '</P_87>' + nl )
      r += xmlNiePusty( aDane[ 'P09' ], '    <P_88>' + TKwotaC( aDane[ 'P09' ] ) + '</P_88>' + nl )
      r += xmlNiePusty( aDane[ 'P10' ], '    <P_89>' + TKwotaC( aDane[ 'P10' ] ) + '</P_89>' + nl )
      r += xmlNiePusty( aDane[ 'P11' ], '    <P_90>' + TKwotaC( aDane[ 'P11' ] ) + '</P_90>' + nl )
      r += xmlNiePusty( aDane[ 'P12' ], '    <P_91>' + TKwotaC( aDane[ 'P12' ] ) + '</P_91>' + nl )
      r += xmlNiePusty( aDane[ 'K13' ], '    <P_92>' + TKwotaC( aDane[ 'K13' ] ) + '</P_92>' + nl )
      r += xmlNiePusty( aDane[ 'K14' ], '    <P_93>' + TKwotaC( aDane[ 'K14' ] ) + '</P_93>' + nl )
      r += xmlNiePusty( aDane[ 'K15' ], '    <P_94>' + TKwotaC( aDane[ 'K15' ] ) + '</P_94>' + nl )
      r += xmlNiePusty( aDane[ 'K16' ], '    <P_95>' + TKwotaC( aDane[ 'K16' ] ) + '</P_95>' + nl )
      r += xmlNiePusty( aDane[ 'K17' ], '    <P_96>' + TKwotaC( aDane[ 'K17' ] ) + '</P_96>' + nl )
      r += xmlNiePusty( aDane[ 'K18' ], '    <P_97>' + TKwotaC( aDane[ 'K18' ] ) + '</P_97>' + nl )
      r += xmlNiePusty( aDane[ 'P13' ], '    <P_98>' + TKwotaC( aDane[ 'P13' ] ) + '</P_98>' + nl )
      r += xmlNiePusty( aDane[ 'P14' ], '    <P_99>' + TKwotaC( aDane[ 'P14' ] ) + '</P_99>' + nl )
      r += xmlNiePusty( aDane[ 'P15' ], '    <P_100>' + TKwotaC( aDane[ 'P15' ] ) + '</P_100>' + nl )
      r += xmlNiePusty( aDane[ 'P16' ], '    <P_101>' + TKwotaC( aDane[ 'P16' ] ) + '</P_101>' + nl )
      r += xmlNiePusty( aDane[ 'P17' ], '    <P_102>' + TKwotaC( aDane[ 'P17' ] ) + '</P_102>' + nl )
      r += xmlNiePusty( aDane[ 'P18' ], '    <P_103>' + TKwotaC( aDane[ 'P18' ] ) + '</P_103>' + nl )
      r += xmlNiePusty( aDane[ 'K01' ], '    <P_104>' + TKwotaC( aDane[ 'K19' ] ) + '</P_104>' + nl )
      r += xmlNiePusty( aDane[ 'K02' ], '    <P_105>' + TKwotaC( aDane[ 'K20' ] ) + '</P_105>' + nl )
      r += xmlNiePusty( aDane[ 'K03' ], '    <P_106>' + TKwotaC( aDane[ 'K21' ] ) + '</P_106>' + nl )
      r += xmlNiePusty( aDane[ 'K04' ], '    <P_107>' + TKwotaC( aDane[ 'K22' ] ) + '</P_107>' + nl )
      r += xmlNiePusty( aDane[ 'K05' ], '    <P_108>' + TKwotaC( aDane[ 'K23' ] ) + '</P_108>' + nl )
      r += xmlNiePusty( aDane[ 'P19' ], '    <P_110>' + TKwotaC( aDane[ 'P19' ] ) + '</P_110>' + nl )
      r += xmlNiePusty( aDane[ 'P20' ], '    <P_111>' + TKwotaC( aDane[ 'P20' ] ) + '</P_111>' + nl )
      r += xmlNiePusty( aDane[ 'P21' ], '    <P_112>' + TKwotaC( aDane[ 'P21' ] ) + '</P_112>' + nl )
      r += xmlNiePusty( aDane[ 'P22' ], '    <P_113>' + TKwotaC( aDane[ 'P22' ] ) + '</P_113>' + nl )
      r += xmlNiePusty( aDane[ 'P23' ], '    <P_114>' + TKwotaC( aDane[ 'P23' ] ) + '</P_114>' + nl )
      r += '    <P_109>' + TKwotaC( aDane[ 'KR' ] ) + '</P_109>' + nl
      r += '    <P_115>' + TKwotaC( aDane[ 'PR' ] ) + '</P_115>' + nl
      r += '    <P_116>' + TNaturalny( aDane[ 'miesiace' ] ) + '</P_116>' + nl
   ENDIF
   IF ! lRocznie .AND. ! Empty( aDane[ 'data_zl' ] )
      r += '    <P_117>' + date2strxml( aDane[ 'data_zl' ] ) + '</P_117>' + nl
   ENDIF
   r += '    <P_118>' + date2strxml( aDane[ 'data_prz' ] ) + '</P_118>' + nl
   r += '  </PozycjeSzczegolowe>' + nl
   r += '  <Pouczenie>1</Pouczenie>' + nl
   r += '</Deklaracja>' + nl

   RETURN r

/*----------------------------------------------------------------------*/

FUNCTION edek_ift2_11( aDane, lRocznie )

   LOCAL r, nl := Chr( 13 ) + Chr( 10 )

   r := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   IF lRocznie
      r += '<Deklaracja xmlns="http://crd.gov.pl/wzor/2024/12/10/13616/">' + nl
   ELSE
      r += '<Deklaracja xmlns="http://crd.gov.pl/wzor/2024/12/10/13615/">' + nl
   ENDIF
   r += '  <Naglowek>' + nl
   IF lRocznie
      r += '    <KodFormularza kodPodatku="CIT" kodSystemowy="IFT-2R (11)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">IFT-2/IFT-2R</KodFormularza>' + nl
   ELSE
      r += '    <KodFormularza kodPodatku="CIT" kodSystemowy="IFT-2 (11)" rodzajZobowiazania="Z" wersjaSchemy="1-0E">IFT-2/IFT-2R</KodFormularza>' + nl
   ENDIF
   r += '    <WariantFormularza>11</WariantFormularza>' + nl
   r += '    <CelZlozenia poz="P_7">' + aDane[ 'korekta' ] + '</CelZlozenia>' + nl
   r += '    <OkresOd poz="P_4">' + date2strxml( aDane[ 'data_od' ] ) + '</OkresOd>' + nl
   r += '    <OkresDo poz="P_5">' + date2strxml( aDane[ 'data_do' ] ) + '</OkresDo>' + nl
   r += '    <KodUrzedu>' + AllTrim( aDane[ 'Firma' ][ 'KodUrzedu' ] ) + '</KodUrzedu>' + nl
   r += '  </Naglowek>' + nl
   r += '  <Podmiot1 rola="' + str2sxml( 'Płatnik/Podmiot (Wypłacający Należność)' ) + '">' + nl
   IF aDane[ 'Firma' ][ 'Spolka' ]
      r += '    <OsobaNiefizyczna>' + nl
      r += '      <NIP>' + trimnip( str2sxml( aDane[ 'Firma' ][ 'NIP' ] ) ) + '</NIP>' + nl
      r += '      <PelnaNazwa>' + str2sxml( aDane[ 'Firma' ][ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      r += '    </OsobaNiefizyczna>' + nl
   ELSE
      r += '    <OsobaFizyczna>' + nl
      r += '      <NIP>' + trimnip( str2sxml( aDane[ 'Firma' ][ 'NIP' ] ) ) + '</NIP>' + nl
      r += '      <ImiePierwsze>' + str2sxml( aDane[ 'Firma' ][ 'ImiePierwsze' ] ) + '</ImiePierwsze>' + nl
      r += '      <Nazwisko>' + str2sxml( aDane[ 'Firma' ][ 'Nazwisko' ] ) + '</Nazwisko>' + nl
      r += '      <DataUrodzenia>' + date2strxml( aDane[ 'Firma' ][ 'DataUrodzenia' ] ) + '</DataUrodzenia>' + nl
      r += '    </OsobaFizyczna>' + nl
   ENDIF
   r += '    <AdresZamieszkaniaSiedziby rodzajAdresu="RAD">' + nl
   r += '      <AdresPol>' + nl
   r += '        <KodKraju>PL</KodKraju>' + nl
   r += '        <Wojewodztwo>' + str2sxml( aDane[ 'Firma' ][ 'Wojewodztwo' ] ) + '</Wojewodztwo>' + nl
   r += '        <Powiat>' + str2sxml( aDane[ 'Firma' ][ 'Powiat' ] ) + '</Powiat>' + nl
   r += '        <Gmina>' + str2sxml( aDane[ 'Firma' ][ 'Gmina' ] ) + '</Gmina>' + nl
   r += '        <Ulica>' + str2sxml( aDane[ 'Firma' ][ 'Ulica' ] ) + '</Ulica>' + nl
   r += '        <NrDomu>' + str2sxml( aDane[ 'Firma' ][ 'NrDomu' ] ) + '</NrDomu>' + nl
   IF ! Empty( aDane[ 'Firma' ][ 'NrLokalu' ] )
      r += '        <NrLokalu>' + str2sxml( aDane[ 'Firma' ][ 'NrLokalu' ] ) + '</NrLokalu>' + nl
   ENDIF
   r += '        <Miejscowosc>' + str2sxml( aDane[ 'Firma' ][ 'Miejscowosc' ] ) + '</Miejscowosc>' + nl
   r += '        <KodPocztowy>' + str2sxml( aDane[ 'Firma' ][ 'KodPocztowy' ] ) + '</KodPocztowy>' + nl
   //r := r + '        <etd:Poczta>' + str2sxml( aDane[ 'Dane' ][ 'FirmaPoczta' ] ) + '</etd:Poczta>' + nl
   r += '      </AdresPol>' + nl
   r += '    </AdresZamieszkaniaSiedziby>' + nl
   r += '  </Podmiot1>' + nl
   r += '  <Podmiot2 rola="' + str2sxml( 'Podatnik (Odbiorca Należności)' ) + '">' + nl
   r += '    <OsobaNieFizZagr>' + nl
   r += '      <PelnaNazwa>' + str2sxml( aDane[ 'nazwa' ] ) + '</PelnaNazwa>' + nl
   IF ! Empty( aDane[ 'nazwaskr' ] )
      r += '      <SkroconaNazwa>' + str2sxml( aDane[ 'nazwaskr' ] ) + '</SkroconaNazwa>' + nl
   ENDIF
   IF ! Empty( aDane[ 'datarozp' ] )
      r += '      <DataRozpoczeciaDzialalnosci poz="P_22">' + date2strxml( aDane[ 'datarozp' ] ) + '</DataRozpoczeciaDzialalnosci>' + nl
   ENDIF
   r += '      <RodzajIdentyfikacji poz="P_23">' + aDane[ 'rodzajid' ] + '</RodzajIdentyfikacji>' + nl
   r += '      <NumerIdentyfikacyjnyPodatnika poz="P_24">' + str2sxml( aDane[ 'nridpod' ] ) + '</NumerIdentyfikacyjnyPodatnika>' + nl
   r += '      <KodKrajuWydania poz="P_25">' + aDane[ 'krajwyd' ] + '</KodKrajuWydania>' + nl
   r += '    </OsobaNieFizZagr>' + nl
   r += '    <AdresSiedziby rodzajAdresu="RAD">' + nl
   r += '      <KodKraju>' + aDane[ 'kraj' ] + '</KodKraju>' + nl
   IF ! Empty( aDane[ 'kodpoczt' ] )
      r += '      <KodPocztowy>' + str2sxml( aDane[ 'kodpoczt' ] ) + '</KodPocztowy>' + nl
   ENDIF
   r += '      <Miejscowosc>' + str2sxml( aDane[ 'miasto' ] ) + '</Miejscowosc>' + nl
   IF ! Empty( aDane[ 'ulica' ] )
      r += '      <Ulica>' + str2sxml( aDane[ 'ulica' ] ) + '</Ulica>' + nl
   ENDIF
   IF ! Empty( aDane[ 'nrbud' ] )
      r += '      <NrDomu>' + str2sxml( aDane[ 'nrbud' ] ) + '</NrDomu>' + nl
   ENDIF
   IF ! Empty( aDane[ 'nrlok' ] )
      r += '      <NrLokalu>' + str2sxml( aDane[ 'nrlok' ] ) + '</NrLokalu>' + nl
   ENDIF
   r += '    </AdresSiedziby>' + nl
   r += '  </Podmiot2>' + nl
   r += '  <PozycjeSzczegolowe>' + nl
   r += '    <P_26>' + iif( aDane[ 'powiazany' ] == 'T', '1', '2' ) + '</P_26>' + nl
   IF aDane[ 'D1D' ] <> 0 .OR. aDane[ 'D1E' ] <> 0 .OR. aDane[ 'D1G' ] <> 0
      r += '    <P_33>' + TKwotaC( aDane[ 'D1D' ] ) + '</P_33>' + nl
      r += '    <P_34>' + TKwotaC( aDane[ 'D1E' ] ) + '</P_34>' + nl
      r += '    <P_35>' + TKwotaC( aDane[ 'D1G' ] ) + '</P_35>' + nl
      r += '    <P_E typ="G">' + nl
      r += '      <P_E1>' + TProcentowy( aDane[ 'D1F' ] ) + '</P_E1>' + nl
      r += '      <P_E2>' + TKwotaC( aDane[ 'D1D' ] ) + '</P_E2>' + nl
      r += '      <P_E3>' + TKwotaC( aDane[ 'D1E' ] ) + '</P_E3>' + nl
      r += '      <P_E4>' + TKwotaC( aDane[ 'D1G' ] ) + '</P_E4>' + nl
      r += '    </P_E>' + nl
   ENDIF
   IF aDane[ 'D2D' ] <> 0 .OR. aDane[ 'D2E' ] <> 0 .OR. aDane[ 'D2G' ] <> 0
      r += '    <P_36>' + TKwotaC( aDane[ 'D2D' ] ) + '</P_36>' + nl
      r += '    <P_37>' + TKwotaC( aDane[ 'D2E' ] ) + '</P_37>' + nl
      r += '    <P_38>' + TKwotaC( aDane[ 'D2G' ] ) + '</P_38>' + nl
      r += '    <P_F typ="G">' + nl
      r += '      <P_F1>' + TProcentowy( aDane[ 'D2F' ] ) + '</P_F1>' + nl
      r += '      <P_F2>' + TKwotaC( aDane[ 'D2D' ] ) + '</P_F2>' + nl
      r += '      <P_F3>' + TKwotaC( aDane[ 'D2E' ] ) + '</P_F3>' + nl
      r += '      <P_F4>' + TKwotaC( aDane[ 'D2G' ] ) + '</P_F4>' + nl
      r += '    </P_F>' + nl
   ENDIF
   IF aDane[ 'D3D' ] <> 0 .OR. aDane[ 'D3E' ] <> 0 .OR. aDane[ 'D3G' ] <> 0
      r += '    <P_39>' + TKwotaC( aDane[ 'D3D' ] ) + '</P_39>' + nl
      r += '    <P_40>' + TKwotaC( aDane[ 'D3E' ] ) + '</P_40>' + nl
      r += '    <P_41>' + TKwotaC( aDane[ 'D3G' ] ) + '</P_41>' + nl
      r += '    <P_G typ="G">' + nl
      r += '      <P_G1>' + TProcentowy( aDane[ 'D3F' ] ) + '</P_G1>' + nl
      r += '      <P_G2>' + TKwotaC( aDane[ 'D3D' ] ) + '</P_G2>' + nl
      r += '      <P_G3>' + TKwotaC( aDane[ 'D3E' ] ) + '</P_G3>' + nl
      r += '      <P_G4>' + TKwotaC( aDane[ 'D3G' ] ) + '</P_G4>' + nl
      r += '    </P_G>' + nl
   ENDIF
   IF aDane[ 'D4D' ] <> 0 .OR. aDane[ 'D4E' ] <> 0 .OR. aDane[ 'D4G' ] <> 0
      r += '    <P_42>' + TKwotaC( aDane[ 'D4D' ] ) + '</P_42>' + nl
      r += '    <P_43>' + TKwotaC( aDane[ 'D4E' ] ) + '</P_43>' + nl
      r += '    <P_44>' + TKwotaC( aDane[ 'D4G' ] ) + '</P_44>' + nl
      r += '    <P_H typ="G">' + nl
      r += '      <P_H1>' + TProcentowy( aDane[ 'D4F' ] ) + '</P_H1>' + nl
      r += '      <P_H2>' + TKwotaC( aDane[ 'D4D' ] ) + '</P_H2>' + nl
      r += '      <P_H3>' + TKwotaC( aDane[ 'D4E' ] ) + '</P_H3>' + nl
      r += '      <P_H4>' + TKwotaC( aDane[ 'D4G' ] ) + '</P_H4>' + nl
      r += '    </P_H>' + nl
   ENDIF
   IF aDane[ 'D5D' ] <> 0 .OR. aDane[ 'D5E' ] <> 0 .OR. aDane[ 'D5G' ] <> 0
      r += '    <P_45>' + TKwotaC( aDane[ 'D5D' ] ) + '</P_45>' + nl
      r += '    <P_46>' + TKwotaC( aDane[ 'D5E' ] ) + '</P_46>' + nl
      r += '    <P_47>' + TKwotaC( aDane[ 'D5G' ] ) + '</P_47>' + nl
      r += '    <P_I typ="G">' + nl
      r += '      <P_I1>' + TProcentowy( aDane[ 'D5F' ] ) + '</P_I1>' + nl
      r += '      <P_I2>' + TKwotaC( aDane[ 'D5D' ] ) + '</P_I2>' + nl
      r += '      <P_I3>' + TKwotaC( aDane[ 'D5E' ] ) + '</P_I3>' + nl
      r += '      <P_I4>' + TKwotaC( aDane[ 'D5G' ] ) + '</P_I4>' + nl
      r += '    </P_I>' + nl
   ENDIF
   IF aDane[ 'D6D' ] <> 0 .OR. aDane[ 'D6E' ] <> 0 .OR. aDane[ 'D6G' ] <> 0
      r += '    <P_48>' + TKwotaC( aDane[ 'D6D' ] ) + '</P_48>' + nl
      r += '    <P_49>' + TKwotaC( aDane[ 'D6E' ] ) + '</P_49>' + nl
      r += '    <P_50>' + TKwotaC( aDane[ 'D6G' ] ) + '</P_50>' + nl
      r += '    <P_J typ="G">' + nl
      r += '      <P_J1>' + TProcentowy( aDane[ 'D6F' ] ) + '</P_J1>' + nl
      r += '      <P_J2>' + TKwotaC( aDane[ 'D6D' ] ) + '</P_J2>' + nl
      r += '      <P_J3>' + TKwotaC( aDane[ 'D6E' ] ) + '</P_J3>' + nl
      r += '      <P_J4>' + TKwotaC( aDane[ 'D6G' ] ) + '</P_J4>' + nl
      r += '    </P_J>' + nl
   ENDIF
   IF aDane[ 'D7D' ] <> 0 .OR. aDane[ 'D7E' ] <> 0 .OR. aDane[ 'D7G' ] <> 0
      r += '    <P_51>' + TKwotaC( aDane[ 'D7D' ] ) + '</P_51>' + nl
      r += '    <P_52>' + TKwotaC( aDane[ 'D7E' ] ) + '</P_52>' + nl
      r += '    <P_53>' + TKwotaC( aDane[ 'D7G' ] ) + '</P_53>' + nl
      r += '    <P_K typ="G">' + nl
      r += '      <P_K1>' + TProcentowy( aDane[ 'D7F' ] ) + '</P_K1>' + nl
      r += '      <P_K2>' + TKwotaC( aDane[ 'D7D' ] ) + '</P_K2>' + nl
      r += '      <P_K3>' + TKwotaC( aDane[ 'D7E' ] ) + '</P_K3>' + nl
      r += '      <P_K4>' + TKwotaC( aDane[ 'D7G' ] ) + '</P_K4>' + nl
      r += '    </P_K>' + nl
   ENDIF
   IF aDane[ 'D8D' ] <> 0 .OR. aDane[ 'D8E' ] <> 0 .OR. aDane[ 'D8G' ] <> 0
      r += '    <P_54>' + TKwotaC( aDane[ 'D8D' ] ) + '</P_54>' + nl
      r += '    <P_55>' + TKwotaC( aDane[ 'D8E' ] ) + '</P_55>' + nl
      r += '    <P_56>' + TKwotaC( aDane[ 'D8G' ] ) + '</P_56>' + nl
      r += '    <P_57>0</P_57>' + nl
      r += '    <P_L typ="G">' + nl
      r += '      <P_L1>' + TProcentowy( aDane[ 'D8F' ] ) + '</P_L1>' + nl
      r += '      <P_L2>' + TKwotaC( aDane[ 'D8D' ] ) + '</P_L2>' + nl
      r += '      <P_L3>' + TKwotaC( aDane[ 'D8E' ] ) + '</P_L3>' + nl
      r += '      <P_L4>' + TKwotaC( aDane[ 'D8G' ] ) + '</P_L4>' + nl
      r += '      <P_L5>0</P_L5>' + nl
      r += '    </P_L>' + nl
   ENDIF
   IF aDane[ 'D9D' ] <> 0 .OR. aDane[ 'D9E' ] <> 0 .OR. aDane[ 'D9G' ] <> 0
      r += '    <P_58>' + TKwotaC( aDane[ 'D9D' ] ) + '</P_58>' + nl
      r += '    <P_59>' + TKwotaC( aDane[ 'D9E' ] ) + '</P_69>' + nl
      r += '    <P_60>' + TKwotaC( aDane[ 'D9G' ] ) + '</P_60>' + nl
      r += '    <P_61>0</P_61>' + nl
      r += '    <P_M typ="G">' + nl
      r += '      <P_M1>' + TProcentowy( aDane[ 'D9F' ] ) + '</P_M1>' + nl
      r += '      <P_M2>' + TKwotaC( aDane[ 'D9D' ] ) + '</P_M2>' + nl
      r += '      <P_M3>' + TKwotaC( aDane[ 'D9E' ] ) + '</P_M3>' + nl
      r += '      <P_M4>' + TKwotaC( aDane[ 'D9G' ] ) + '</P_M4>' + nl
      r += '      <P_M5>0</P_M5>' + nl
      r += '    </P_M>' + nl
   ENDIF
   IF aDane[ 'D10D' ] <> 0 .OR. aDane[ 'D10E' ] <> 0 .OR. aDane[ 'D10G' ] <> 0
      r += '    <P_62>' + TKwotaC( aDane[ 'D10D' ] ) + '</P_62>' + nl
      r += '    <P_63>' + TKwotaC( aDane[ 'D10E' ] ) + '</P_63>' + nl
      r += '    <P_64>' + TKwotaC( aDane[ 'D10G' ] ) + '</P_64>' + nl
      r += '    <P_65>0</P_65>' + nl
      r += '    <P_N typ="G">' + nl
      r += '      <P_N1>' + TProcentowy( aDane[ 'D10F' ] ) + '</P_N1>' + nl
      r += '      <P_N2>' + TKwotaC( aDane[ 'D10D' ] ) + '</P_N2>' + nl
      r += '      <P_N3>' + TKwotaC( aDane[ 'D10E' ] ) + '</P_N3>' + nl
      r += '      <P_N4>' + TKwotaC( aDane[ 'D10G' ] ) + '</P_N4>' + nl
      r += '      <P_N5>0</P_N5>' + nl
      r += '    </P_N>' + nl
   ENDIF
   IF aDane[ 'D11D' ] <> 0 .OR. aDane[ 'D11E' ] <> 0 .OR. aDane[ 'D11G' ] <> 0
      r += '    <P_66>' + TKwotaC( aDane[ 'D11D' ] ) + '</P_66>' + nl
      r += '    <P_67>' + TKwotaC( aDane[ 'D11E' ] ) + '</P_67>' + nl
      r += '    <P_68>' + TKwotaC( aDane[ 'D11G' ] ) + '</P_68>' + nl
      r += '    <P_69>0</P_69>' + nl
      r += '    <P_O typ="G">' + nl
      r += '      <P_O1>' + TProcentowy( aDane[ 'D11F' ] ) + '</P_O1>' + nl
      r += '      <P_O2>' + TKwotaC( aDane[ 'D11D' ] ) + '</P_O2>' + nl
      r += '      <P_O3>' + TKwotaC( aDane[ 'D11E' ] ) + '</P_O3>' + nl
      r += '      <P_O4>' + TKwotaC( aDane[ 'D11G' ] ) + '</P_O4>' + nl
      r += '    </P_O>' + nl
   ENDIF
   IF lRocznie
      r += xmlNiePusty( aDane[ 'K01' ], '    <P_69>' + TKwotaC( aDane[ 'K01' ] ) + '</P_69>' + nl )
      r += xmlNiePusty( aDane[ 'K02' ], '    <P_70>' + TKwotaC( aDane[ 'K02' ] ) + '</P_70>' + nl )
      r += xmlNiePusty( aDane[ 'K03' ], '    <P_71>' + TKwotaC( aDane[ 'K03' ] ) + '</P_71>' + nl )
      r += xmlNiePusty( aDane[ 'K04' ], '    <P_72>' + TKwotaC( aDane[ 'K04' ] ) + '</P_72>' + nl )
      r += xmlNiePusty( aDane[ 'K05' ], '    <P_73>' + TKwotaC( aDane[ 'K05' ] ) + '</P_73>' + nl )
      r += xmlNiePusty( aDane[ 'K06' ], '    <P_74>' + TKwotaC( aDane[ 'K06' ] ) + '</P_74>' + nl )
      r += xmlNiePusty( aDane[ 'P01' ], '    <P_75>' + TKwotaC( aDane[ 'P01' ] ) + '</P_75>' + nl )
      r += xmlNiePusty( aDane[ 'P02' ], '    <P_76>' + TKwotaC( aDane[ 'P02' ] ) + '</P_76>' + nl )
      r += xmlNiePusty( aDane[ 'P03' ], '    <P_77>' + TKwotaC( aDane[ 'P03' ] ) + '</P_77>' + nl )
      r += xmlNiePusty( aDane[ 'P04' ], '    <P_78>' + TKwotaC( aDane[ 'P04' ] ) + '</P_78>' + nl )
      r += xmlNiePusty( aDane[ 'P05' ], '    <P_79>' + TKwotaC( aDane[ 'P05' ] ) + '</P_79>' + nl )
      r += xmlNiePusty( aDane[ 'P06' ], '    <P_80>' + TKwotaC( aDane[ 'P06' ] ) + '</P_80>' + nl )
      r += xmlNiePusty( aDane[ 'K07' ], '    <P_81>' + TKwotaC( aDane[ 'K07' ] ) + '</P_81>' + nl )
      r += xmlNiePusty( aDane[ 'K08' ], '    <P_82>' + TKwotaC( aDane[ 'K08' ] ) + '</P_82>' + nl )
      r += xmlNiePusty( aDane[ 'K09' ], '    <P_83>' + TKwotaC( aDane[ 'K09' ] ) + '</P_83>' + nl )
      r += xmlNiePusty( aDane[ 'K10' ], '    <P_84>' + TKwotaC( aDane[ 'K10' ] ) + '</P_84>' + nl )
      r += xmlNiePusty( aDane[ 'K11' ], '    <P_85>' + TKwotaC( aDane[ 'K11' ] ) + '</P_85>' + nl )
      r += xmlNiePusty( aDane[ 'K12' ], '    <P_86>' + TKwotaC( aDane[ 'K12' ] ) + '</P_86>' + nl )
      r += xmlNiePusty( aDane[ 'P07' ], '    <P_87>' + TKwotaC( aDane[ 'P07' ] ) + '</P_87>' + nl )
      r += xmlNiePusty( aDane[ 'P08' ], '    <P_88>' + TKwotaC( aDane[ 'P08' ] ) + '</P_88>' + nl )
      r += xmlNiePusty( aDane[ 'P09' ], '    <P_89>' + TKwotaC( aDane[ 'P09' ] ) + '</P_89>' + nl )
      r += xmlNiePusty( aDane[ 'P10' ], '    <P_90>' + TKwotaC( aDane[ 'P10' ] ) + '</P_90>' + nl )
      r += xmlNiePusty( aDane[ 'P11' ], '    <P_91>' + TKwotaC( aDane[ 'P11' ] ) + '</P_91>' + nl )
      r += xmlNiePusty( aDane[ 'P12' ], '    <P_92>' + TKwotaC( aDane[ 'P12' ] ) + '</P_92>' + nl )
      r += xmlNiePusty( aDane[ 'K13' ], '    <P_93>' + TKwotaC( aDane[ 'K13' ] ) + '</P_93>' + nl )
      r += xmlNiePusty( aDane[ 'K14' ], '    <P_94>' + TKwotaC( aDane[ 'K14' ] ) + '</P_94>' + nl )
      r += xmlNiePusty( aDane[ 'K15' ], '    <P_95>' + TKwotaC( aDane[ 'K15' ] ) + '</P_95>' + nl )
      r += xmlNiePusty( aDane[ 'K16' ], '    <P_96>' + TKwotaC( aDane[ 'K16' ] ) + '</P_96>' + nl )
      r += xmlNiePusty( aDane[ 'K17' ], '    <P_97>' + TKwotaC( aDane[ 'K17' ] ) + '</P_97>' + nl )
      r += xmlNiePusty( aDane[ 'K18' ], '    <P_98>' + TKwotaC( aDane[ 'K18' ] ) + '</P_98>' + nl )
      r += xmlNiePusty( aDane[ 'P13' ], '    <P_99>' + TKwotaC( aDane[ 'P13' ] ) + '</P_99>' + nl )
      r += xmlNiePusty( aDane[ 'P14' ], '    <P_100>' + TKwotaC( aDane[ 'P14' ] ) + '</P_100>' + nl )
      r += xmlNiePusty( aDane[ 'P15' ], '    <P_101>' + TKwotaC( aDane[ 'P15' ] ) + '</P_101>' + nl )
      r += xmlNiePusty( aDane[ 'P16' ], '    <P_102>' + TKwotaC( aDane[ 'P16' ] ) + '</P_102>' + nl )
      r += xmlNiePusty( aDane[ 'P17' ], '    <P_103>' + TKwotaC( aDane[ 'P17' ] ) + '</P_103>' + nl )
      r += xmlNiePusty( aDane[ 'P18' ], '    <P_104>' + TKwotaC( aDane[ 'P18' ] ) + '</P_104>' + nl )
      r += xmlNiePusty( aDane[ 'K19' ], '    <P_105>' + TKwotaC( aDane[ 'K19' ] ) + '</P_105>' + nl )
      r += xmlNiePusty( aDane[ 'K20' ], '    <P_106>' + TKwotaC( aDane[ 'K20' ] ) + '</P_106>' + nl )
      r += xmlNiePusty( aDane[ 'K21' ], '    <P_107>' + TKwotaC( aDane[ 'K21' ] ) + '</P_107>' + nl )
      r += xmlNiePusty( aDane[ 'K22' ], '    <P_108>' + TKwotaC( aDane[ 'K22' ] ) + '</P_108>' + nl )
      r += xmlNiePusty( aDane[ 'K23' ], '    <P_109>' + TKwotaC( aDane[ 'K23' ] ) + '</P_109>' + nl )
      r += xmlNiePusty( aDane[ 'P19' ], '    <P_111>' + TKwotaC( aDane[ 'P19' ] ) + '</P_111>' + nl )
      r += xmlNiePusty( aDane[ 'P20' ], '    <P_112>' + TKwotaC( aDane[ 'P20' ] ) + '</P_112>' + nl )
      r += xmlNiePusty( aDane[ 'P21' ], '    <P_113>' + TKwotaC( aDane[ 'P21' ] ) + '</P_113>' + nl )
      r += xmlNiePusty( aDane[ 'P22' ], '    <P_114>' + TKwotaC( aDane[ 'P22' ] ) + '</P_114>' + nl )
      r += xmlNiePusty( aDane[ 'P23' ], '    <P_115>' + TKwotaC( aDane[ 'P23' ] ) + '</P_115>' + nl )
      r += '    <P_110>' + TKwotaC( aDane[ 'KR' ] ) + '</P_110>' + nl
      r += '    <P_116>' + TKwotaC( aDane[ 'PR' ] ) + '</P_116>' + nl
      r += '    <P_117>' + TNaturalny( aDane[ 'miesiace' ] ) + '</P_117>' + nl
   ENDIF
   IF ! lRocznie .AND. ! Empty( aDane[ 'data_zl' ] )
      r += '    <P_118>' + date2strxml( aDane[ 'data_zl' ] ) + '</P_118>' + nl
   ENDIF
   r += '    <P_119>' + date2strxml( aDane[ 'data_prz' ] ) + '</P_119>' + nl
   r += '  </PozycjeSzczegolowe>' + nl
   r += '  <Pouczenie>1</Pouczenie>' + nl
   r += '</Deklaracja>' + nl

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

