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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±edycja wzorca UMOWY-ZLECENIA                                              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Umowa( zbior )

local tekst
@ 1,47 say [         ]
tekst:=memoread(zbior)
set curs on
@ 3,0 to 14,79 doub
ColInf()
do center with 3,' Edycja zbioru '+ZBIOR+' '
@ 23,0 say ' Ctrl+W - zapami&_e.tanie wzoru                           ESC - zaniechanie edycji '
set color to
@ 15,0 say 'NAZWISKO   IMIE1 ULICA TERMIN DZISIAJ  $_FFP - fundusz pracy  & ="P"oplaca prac.'
@ 16,0 say 'ADR_FIRMY  IMIE2 LOKAL TEMAT1 DATA_UM  $_FFG - fundusz FGSP      "F"oplaca firma'
@ 17,0 say 'UL_FIRMY   PESEL FIRMA TEMAT2 DATA_RA  $_&UE - ubezp.emeryt.  $ ="STAW"- stawka '
@ 18,0 say 'MIEJSC_UR  NIP   UMOWA %KOSZT DATA_UR  $_&UR - ubezp.rentowe     "WAR"   wartosc'
@ 19,0 say 'MIEJSC_ZAM ZATR  DOWOD KOSZT  PODATEK  $_PUC - ubezp.chorob.      Przedrostki   '
@ 20,0 say 'DATA_WYP   KOD   NETTO BRUTTO IMIE_O   $_FUW - ubezp.wypadk.  # = spacje obciete'
@ 21,0 say '%PODATEK   DOM   NSLOW BSLOW  IMIE_M   $_PUZ - ub.zdr.do ZUS  @ = spacje drukow.'
@ 22,0 say 'POTRACENIA                             $_PZK - ub.zdr.do odl                    '

*@ 19,0 say '@NAZWISKO  @IMIE1  @IMIE2  @IMIE_O  @IMIE_M  @MIEJSC_UR  @DATA_UR  @DOWOD @PESEL'
*@ 20,0 say '@ZATR  @NIP  @MIEJSC_ZAM  @KOD  @GMINA  @ULICA  @DOM  @LOKAL   @DZISIAJ   @UMOWA'
*@ 21,0 say '@DATA_UM  @DATA_RA  @TERMIN  @TEMAT1  @TEMAT2  @BRUTTO  @BSLOW   @NETTO   @NSLOW'
*@ 22,0 say '@%KOSZT @KOSZT @DOCHOD @%PODATEK @PODATEK  @DATA_WYP @FIRMA @UL_FIRMY @ADR_FIRMY'

tekst:=memoedit(tekst,4,1,13,78,.t.)
MEMOWRIT(ZBIOR,TEKST)
set curs off
ColStd()
return
