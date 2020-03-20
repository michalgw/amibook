/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaà Gawrycki (gmsystems.pl)

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

*±±±±±± GLOWKA EDEKL ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    EDEKL_POCZ
??'<?xml version="1.0" encoding="UTF-8"?>'
?'<Deklaracja xmlns="http://crd.gov.pl/wzor/2012/09/03/984/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2011/06/21/eD/DefinicjeTypy/">'
*±±±±±± STOPKA EDEKL ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    EDEKL_KON
?"</Deklaracja>"
*±±±±±± NAGLOWEK VAT ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    VAT_POCZ
para KODSYS,;
     KODFOR,;
     KODPOD,;
     RODZZOB,;
     WERSCHEM,;
     WARFOR,;
     CELPOZ,;
     CEL,;
     ROK,;
     MC,;
     KODURZ
?'<Naglowek>'
?'<KodFormularza kodSystemowy="&kodsys." kodPodatku="&kodpod." rodzajZobowiazania="&rodzzob." wersjaSchemy="&werschem.">&kodfor.</KodFormularza>'
?'<WariantFormularza>&warfor.</WariantFormularza>'
?'<CelZlozenia poz="&celpoz.">&cel.</CelZlozenia>'
?'<Rok>&rok.</Rok>'
?'<Miesiac>&mc.</Miesiac>'
?'<KodUrzedu>&kodurz.</KodUrzedu>'
?'</Naglowek>'
*±±±±±± PODMIOT1 NAGL ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    PODM1_NAGL
para ROLA
?'<Podmiot1 rola="&rola.">'
*±±±±±± PODMIOT1 STOP ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    PODM1_STOP
?'</Podmiot1>'
*±±±±±± OSOB NIEFIZ ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    OSOB_NIEF
para NIP,;
     NAZWA,;
     REGON
NIP=strtran(NIP,'-','')
?'<OsobaNiefizyczna>'
?'<NIP>&NIP.</NIP>'
?C852_UTF8('<PelnaNazwa>&nazwa.</PelnaNazwa>')
?'<REGON>&regon.</REGON>'
?'</OsobaNiefizyczna>'
*±±±±±± OSOB FIZ ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    OSOB_FIZ
para NIP,;
     IMIE,;
     NAZWISKO,;
     DATAUR,;
     PESEL
NIP=strtran(NIP,'-','')
ndataur=substr(dataur,1,4)+'-'+substr(dataur,6,2)+'-'+substr(dataur,9,2)
?'<etd:OsobaFizyczna>'
?'<etd:NIP>&NIP.</etd:NIP>'
?'<etd:ImiePierwsze>'+C852_UTF8(imie)+'</etd:ImiePierwsze>'
?'<etd:Nazwisko>'+C852_UTF8(nazwisko)+'</etd:Nazwisko>'
?'<etd:DataUrodzenia>&ndataur.</etd:DataUrodzenia>'
?'<etd:PESEL>&pesel.</etd:PESEL>'
?'</etd:OsobaFizyczna>'
*±±±±±± ADRES ZAM NAGL ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ADRESZ_NAGL
para RODZADR
?'<etd:AdresZamieszkaniaSiedziby rodzajAdresu="&rodzadr.">'
*±±±±±± ADRES ZAM STOP ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ADRESZ_STOP
?'</etd:AdresZamieszkaniaSiedziby>'
*±±±±±± ADRES POL ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ADRES_POL
para KRAJ,;
     WOJ,;
     POW,;
     GMINA,;
     ULICA,;
     NRDOM,;
     NRLOK,;
     MIEJSCE,;
     KOD,;
     POCZTA
?'<etd:AdresPol>'
?'<etd:KodKraju>&kraj.</etd:KodKraju>'
?C852_UTF8('<etd:Wojewodztwo>&woj.</etd:Wojewodztwo>')
?C852_UTF8('<etd:Powiat>&pow.</etd:Powiat>')
?C852_UTF8('<etd:Gmina>&gmina.</etd:Gmina>')
?C852_UTF8('<etd:Ulica>&ulica.</etd:Ulica>')
?'<etd:NrDomu>&nrdom.</etd:NrDomu>'
if len(alltrim(nrlok))>0
   ?'<etd:NrLokalu>&nrlok.</etd:NrLokalu>'
endif
?C852_UTF8('<etd:Miejscowosc>&miejsce.</etd:Miejscowosc>')
?'<etd:KodPocztowy>&kod.</etd:KodPocztowy>'
?C852_UTF8('<etd:Poczta>&poczta.</etd:Poczta>')
?'</etd:AdresPol>'
*±±±±±± SZCZEG VAT ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    SZCZEG_VAT
para P20,;
     P21,;
     P22,;
     P23,;
     P24,;
     P25,;
     P26,;
     P27,;
     P28,;
     P29,;
     P30,;
     P31,;
     P32,;
     P33,;
     P34,;
     P35,;
     P36,;
     P37,;
     P38,;
     P39,;
     P40,;
     P41,;
     P42,;
     P43,;
     P44,;
     P45,;
     P46,;
     P47,;
     P48,;
     P49,;
     P50,;
     P51,;
     P52,;
     P53,;
     P54,;
     P55,;
     P56,;
     P57,;
     P58,;
     P59,;
     P60,;
     P61,;
     P62,;
     P63,;
     P64,;
     P65,;
     P66,;
     P67,;
     P68,;
     P69,;
     P70,;
     P71
?'<PozycjeSzczegolowe>'
if p20<>'0'
   ?'<P_20>&p20.</P_20>'
endif
if p21<>'0'
   ?'<P_21>&p21.</P_21>'
endif
if p22<>'0'
   ?'<P_22>&p22.</P_22>'
endif
if p23<>'0'
   ?'<P_23>&p23.</P_23>'
endif
if p24<>'0'
   ?'<P_24>&p24.</P_24>'
endif
if p25<>'0'
   ?'<P_25>&p25.</P_25>'
endif
if p26<>'0'
   ?'<P_26>&p26.</P_26>'
endif
if p27<>'0'
   ?'<P_27>&p27.</P_27>'
endif
if p28<>'0'
   ?'<P_28>&p28.</P_28>'
endif
if p29<>'0'
   ?'<P_29>&p29.</P_29>'
endif
if p30<>'0'
   ?'<P_30>&p30.</P_30>'
endif
if p31<>'0'
   ?'<P_31>&p31.</P_31>'
endif
if p32<>'0'
   ?'<P_32>&p32.</P_32>'
endif
if p33<>'0'
   ?'<P_33>&p33.</P_33>'
endif
if p34<>'0'
   ?'<P_34>&p34.</P_34>'
endif
if p35<>'0'
   ?'<P_35>&p35.</P_35>'
endif
if p36<>'0'
   ?'<P_36>&p36.</P_36>'
endif
if p37<>'0'
   ?'<P_37>&p37.</P_37>'
endif
if p38<>'0'
   ?'<P_38>&p38.</P_38>'
endif
if p39<>'0'
   ?'<P_39>&p39.</P_39>'
endif
if p40<>'0'
   ?'<P_40>&p40.</P_40>'
endif
if p41<>'0'
   ?'<P_41>&p41.</P_41>'
endif
if p42<>'0'
   ?'<P_42>&p42.</P_42>'
endif
if p43<>'0'
   ?'<P_43>&p43.</P_43>'
endif
if p44<>'0'
   ?'<P_44>&p44.</P_44>'
endif
if p45<>'0'
   ?'<P_45>&p45.</P_45>'
endif
if p46<>'0'
   ?'<P_46>&p46.</P_46>'
endif
if p47<>'0'
   ?'<P_47>&p47.</P_47>'
endif
if p48<>'0'
   ?'<P_48>&p48.</P_48>'
endif
if p49<>'0'
   ?'<P_49>&p49.</P_49>'
endif
if p50<>'0'
   ?'<P_50>&p50.</P_50>'
endif
if p51<>'0'
   ?'<P_51>&p51.</P_51>'
endif
if p52<>'0'
   ?'<P_52>&p52.</P_52>'
endif
if p53<>'0'
   ?'<P_53>&p53.</P_53>'
endif
if p54<>'0'
   ?'<P_54>&p54.</P_54>'
endif
if p55<>'0'
   ?'<P_55>&p55.</P_55>'
endif
if p56<>'0'
   ?'<P_56>&p56.</P_56>'
endif
if p57<>'0'
   ?'<P_57>&p57.</P_57>'
endif
if p58<>'0'
   ?'<P_58>&p58.</P_58>'
endif
if p59<>'0'
   ?'<P_59>&p59.</P_59>'
endif
if p60<>'0'
   ?'<P_60>&p60.</P_60>'
endif
if p61<>'0'
   ?'<P_61>&p61.</P_61>'
endif
if p62<>'0'
   ?'<P_62>&p62.</P_62>'
endif
if p63<>'0'
   ?'<P_63>&p63.</P_63>'
endif
if p64<>'0'
   ?'<P_64>&p64.</P_64>'
endif
if p65<>'0'
   ?'<P_65>&p65.</P_65>'
endif
if p66<>'0'
   ?'<P_66>&p66.</P_66>'
endif
if p67<>'0'
   ?'<P_67>&p67.</P_67>'
endif
if p68<>'0'
   ?'<P_68>&p68.</P_68>'
endif
if p69<>'0'
   ?'<P_69>&p69.</P_69>'
endif
?'<P_70>&p70.</P_70>'
?'<P_71>&p71.</P_71>'
?'</PozycjeSzczegolowe>'

*±±±±±± POUCZENVAT ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    POUCZENVAT
?C852_UTF8('<Pouczenie>W przypadku niewpàacenia w obowi•zuj•cym terminie kwoty z poz.58 lub '+;
 'wpàacenia jej w niepeànej wysokoòci, niniejsza deklaracja stanowi podstaw© do '+;
 'wystawienia tytuàu wykonawczego, zgodnie z przepisami ustawy z dnia 17 czerwca '+;
 '1966 r. o post©powaniu egzekucyjnym w administracji (Dz.U. z 2005 r. Nr 229, '+;
 'poz.1954, z p¢´n. zm.).')
??'</Pouczenie>'

*±±±±±± OSWIADCZENIE ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    OSWIADCZENIE
?C852_UTF8('<Oswiadczenie>Oòwiadczam, æe s• mi znane przepisy Kodeksu karnego skarbowego o '+;
 'odpowiedzialnoòci za podanie danych niezgodnych z rzeczywistoòci•.')
??'</Oswiadczenie>'
//?'<Zalaczniki/>'

*±±±±±± RAPORT z e-dekl ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    RAPORTEDEKL
para    plik_k
CurCol=ColStd()
set colo to w
@ 12,43 say padc('Utworzono plik '+plik_k,35)
@ 13,43 say padc('Zaimportuj go VAT-7 w Adobe Reader',35)
@ 14,43 say padc('Poszczeg&_o.lne znaki w nazwie',35)
@ 15,43 say padc('pliku '+plik_k+' oznaczaj&_a.:',35)
set colo to w+
@ 16,43 say substr(plik_k,1,1) pict '!!'
@ 17,43 say substr(plik_k,2,1) pict '!!'
@ 18,43 say substr(plik_k,3,2) pict '!!'
@ 19,43 say substr(plik_k,5,1) pict '!!'
@ 20,43 say substr(plik_k,6,1) pict '!!'
@ 21,43 say substr(plik_k,7,2) pict '!!'
ColStd()
@ 16,45 say '-ko&_n.c&_o.wka roku '+param_rok
@ 17,45 say '-nr miesi&_a.ca (HEX)'
@ 18,45 say '-nr firmy (S35)'
do case
case substr(plik_k,5,1)='V'
     symfor='VAT'
other
     symfor=''
endcase
@ 19,45 say '-symbol formularza ('+symfor+')'
if symfor='VAT'
   do case
   case substr(plik_k,6,1)='7'
        sympod='VAT-7'
   case substr(plik_k,6,1)='K'
        sympod='VAT-7K'
   case substr(plik_k,6,1)='R'
        sympod='VAT-7R'
   other
        sympod=''
   endcase
endif
@ 20,45 say '-podtyp formularza ('+sympod+')'
@ 21,45 say '-wersja formularza (DEC)'
set color to &CurCol
inkey(0)
*±±±±±± C852_UTF8 ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func    C852_UTF8
param lancuch

lancuch=strtran(lancuch,'§',chr(196)+chr(132))
lancuch=strtran(lancuch,'è',chr(196)+chr(134))
lancuch=strtran(lancuch,'®',chr(196)+chr(152))
lancuch=strtran(lancuch,'ù',chr(197)+chr(129))
lancuch=strtran(lancuch,'„',chr(197)+chr(131))
lancuch=strtran(lancuch,'‡',chr(195)+chr(147))
lancuch=strtran(lancuch,'ó',chr(197)+chr(154))
lancuch=strtran(lancuch,'Ω',chr(197)+chr(187))
lancuch=strtran(lancuch,'ç',chr(197)+chr(185))

lancuch=strtran(lancuch,'•',chr(196)+chr(133))
lancuch=strtran(lancuch,'Ü',chr(196)+chr(135))
lancuch=strtran(lancuch,'©',chr(196)+chr(153))
lancuch=strtran(lancuch,'à',chr(197)+chr(130))
lancuch=strtran(lancuch,'‰',chr(197)+chr(132))
lancuch=strtran(lancuch,'¢',chr(195)+chr(179))
lancuch=strtran(lancuch,'ò',chr(197)+chr(155))
lancuch=strtran(lancuch,'æ',chr(197)+chr(188))
lancuch=strtran(lancuch,'´',chr(197)+chr(186))

return lancuch
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± K O N I E C ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
