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

#include "Inkey.ch"

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±edycja wzorca UMOWY-ZLECENIA                                              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Umowa( zbior )

   LOCAL tekst

   @ 1, 47 SAY '         '
   tekst := MemoRead( zbior )
   SET CURSOR ON
   @  3, 0 TO 14, 79 DOUBLE
   ColInf()
   Center( 3, ' Edycja zbioru ' + ZBIOR + ' ' )
   @ 23, 0 SAY ' Ctrl+W - zapami&_e.tanie wzoru      F2 - wstaw pole      ESC - zaniechanie edycji '
   SET COLOR TO
   @ 15, 0 SAY 'NAZWISKO   IMIE1 ULICA TERMIN DZISIAJ  $_FFP - fundusz pracy  & ="P"oplaca prac.'
   @ 16, 0 SAY 'ADR_FIRMY  IMIE2 LOKAL TEMAT1 DATA_UM  $_FFG - fundusz FGSP      "F"oplaca firma'
   @ 17, 0 SAY 'UL_FIRMY   PESEL FIRMA TEMAT2 DATA_RA  $_&UE - ubezp.emeryt.  $ ="STAW"- stawka '
   @ 18, 0 SAY 'MIEJSC_UR  NIP   UMOWA %KOSZT DATA_UR  $_&UR - ubezp.rentowe     "WAR"   wartosc'
   @ 19, 0 SAY 'MIEJSC_ZAM ZATR  DOWOD KOSZT  PODATEK  $_PUC - ubezp.chorob.      Przedrostki   '
   @ 20, 0 SAY 'DATA_WYP   KOD   NETTO BRUTTO IMIE_O   $_FUW - ubezp.wypadk.  # = spacje obciete'
   @ 21, 0 SAY '%PODATEK   DOM   NSLOW BSLOW  IMIE_M   $_PUZ - ub.zdr.do ZUS  @ = spacje drukow.'
   @ 22, 0 SAY 'POTRACENIA                             $_PZK - ub.zdr.do odl                    '

   *@ 19,0 say '@NAZWISKO  @IMIE1  @IMIE2  @IMIE_O  @IMIE_M  @MIEJSC_UR  @DATA_UR  @DOWOD @PESEL'
   *@ 20,0 say '@ZATR  @NIP  @MIEJSC_ZAM  @KOD  @GMINA  @ULICA  @DOM  @LOKAL   @DZISIAJ   @UMOWA'
   *@ 21,0 say '@DATA_UM  @DATA_RA  @TERMIN  @TEMAT1  @TEMAT2  @BRUTTO  @BSLOW   @NETTO   @NSLOW'
   *@ 22,0 say '@%KOSZT @KOSZT @DOCHOD @%PODATEK @PODATEK  @DATA_WYP @FIRMA @UL_FIRMY @ADR_FIRMY'

   SET KEY K_F2 TO UmowaWstaw
   tekst := MemoEdit( tekst, 4, 1, 13, 78, .T. )
   SET KEY K_F2 TO
   MemoWrit( ZBIOR, TEKST )
   SET CURSOR OFF
   ColStd()

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE UmowaWstaw()

   LOCAL nRes, cEkran, cKolor, nC := Col(), nR := Row()
   LOCAL aElementy := { ;
      '@DZISIAJ', ;
      '#DZISIAJ', ;
      '@NAZWISKO', ;
      '#NAZWISKO', ;
      '@IMIE1', ;
      '#IMIE1', ;
      '@IMIE2', ;
      '#IMIE2', ;
      '@IMIE_O', ;
      '#IMIE_O', ;
      '@IMIE_M', ;
      '#IMIE_M', ;
      '@MIEJSC_UR', ;
      '#MIEJSC_UR', ;
      '@DATA_UR', ;
      '#DATA_UR', ;
      '@ZATR', ;
      '#ZATR', ;
      '@PESEL', ;
      '#PESEL', ;
      '@NIP', ;
      '#NIP', ;
      '@MIEJSC_ZAM', ;
      '#MIEJSC_ZAM', ;
      '@KOD', ;
      '#KOD', ;
      '@GMINA', ;
      '#GMINA', ;
      '@ULICA', ;
      '#ULICA', ;
      '@DOM', ;
      '#DOM', ;
      '@LOKAL', ;
      '#LOKAL', ;
      '@DOWOD', ;
      '#DOWOD', ;
      '@FIRMA', ;
      '#FIRMA', ;
      '@UL_FIRMY', ;
      '#UL_FIRMY', ;
      '@ADR_FIRMY', ;
      '#ADR_FIRMY', ;
      '@UMOWA', ;
      '#UMOWA', ;
      '@DATA_UM', ;
      '#DATA_UM', ;
      '@DATA_WYP', ;
      '#DATA_WYP', ;
      '@DATA_RA', ;
      '#DATA_RA', ;
      '@BRUTTO', ;
      '#BRUTTO', ;
      '@BSLOW', ;
      '#BSLOW', ;
      '@%KOSZT', ;
      '#%KOSZT', ;
      '@KOSZT', ;
      '#KOSZT', ;
      '@DOCHOD', ;
      '#DOCHOD', ;
      '@%PODATEK', ;
      '#%PODATEK', ;
      '@PODATEK', ;
      '#PODATEK', ;
      '@NETTO', ;
      '#NETTO', ;
      '@NSLOW', ;
      '#NSLOW', ;
      '@TEMAT1', ;
      '#TEMAT1', ;
      '@TEMAT2', ;
      '#TEMAT2', ;
      '@TERMIN', ;
      '#TERMIN', ;
      '@STAW_PUE', ;
      '#STAW_PUE', ;
      '@STAW_PUR', ;
      '#STAW_PUR', ;
      '@STAW_PUC', ;
      '#STAW_PUC', ;
      '@STAW_PSUM', ;
      '#STAW_PSUM', ;
      '@STAW_PUW', ;
      '#STAW_PUW', ;
      '@STAW_PUZ', ;
      '#STAW_PUZ', ;
      '@STAW_PZK', ;
      '#STAW_PZK', ;
      '@STAW_FUE', ;
      '#STAW_FUE', ;
      '@STAW_FUR', ;
      '#STAW_FUR', ;
      '@STAW_FUC', ;
      '#STAW_FUC', ;
      '@STAW_FUW', ;
      '#STAW_FUW', ;
      '@STAW_FUZ', ;
      '#STAW_FUZ', ;
      '@STAW_FSUM', ;
      '#STAW_FSUM', ;
      '@WAR_PUE', ;
      '#WAR_PUE', ;
      '@WAR_PUR', ;
      '#WAR_PUR', ;
      '@WAR_PUC', ;
      '#WAR_PUC', ;
      '@WAR_PSUM', ;
      '#WAR_PSUM', ;
      '@WAR_PUW', ;
      '#WAR_PUW', ;
      '@WAR_PUZ', ;
      '#WAR_PUZ', ;
      '@WAR_PZK', ;
      '#WAR_PZK', ;
      '@WAR_FUE', ;
      '#WAR_FUE', ;
      '@WAR_FUR', ;
      '#WAR_FUR', ;
      '@WAR_FUC', ;
      '#WAR_FUC', ;
      '@WAR_FUW', ;
      '#WAR_FUW', ;
      '@WAR_FUZ', ;
      '#WAR_FUZ', ;
      '@WAR_FSUM', ;
      '#WAR_FSUM', ;
      '@STAW_FFP', ;
      '#STAW_FFP', ;
      '@STAW_FFG', ;
      '#STAW_FFG', ;
      '@WAR_FFP', ;
      '#WAR_FFP', ;
      '@WAR_FFG', ;
      '#WAR_FFG', ;
      '@POTRACENIA', ;
      '#POTRACENIA', ;
      '@PPKZS1', ;
      '#PPKZS1', ;
      '@PPKZK1', ;
      '#PPKZK1', ;
      '@PPKZS2', ;
      '#PPKZS2', ;
      '@PPKZK2', ;
      '#PPKZK2', ;
      '@PPKPK1', ;
      '#PPKPK1', ;
      '@PPKPS2', ;
      '#PPKPS2', ;
      '@PPKPK2', ;
      '#PPKPK2', ;
      '@PPKPPM', ;
      '#PPKPPM' }

   SAVE SCREEN TO cEkran
   cKolor := ColStd()
   @ 4, 34 TO 22, 47
   SET CURSOR OFF
   IF ( nRes := AChoice(5, 35, 21, 46, aElementy ) ) > 0
      KEYBOARD aElementy[ nRes ]
   ENDIF
   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )
   SET CURSOR ON
   DevPos( nR, nC )

   RETURN NIL