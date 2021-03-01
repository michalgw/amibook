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

PROCEDURE Info_kor()

   *################################# GRAFIKA ##################################

   kwoty_k := Array( 12, 4 )
   FOR x_y := 1 TO 12
       kwoty_k[ x_y, 1 ] := 0
       kwoty_k[ x_y, 2 ] := 0
       kwoty_k[ x_y, 3 ] := 0
       kwoty_k[ x_y, 4 ] := 0
   NEXT

   INNE_1 := 0
   INNE_2 := 0

   @  3, 0 CLEAR TO 22, 79
   ColInf()
   @  3, 0 SAY '[ESC]-wyjscie                                                  [D]-wydruk ekranu'
   ColStd()
   @  4, 0 SAY ' Wyliczenie struktury sprzeda&_z.y za rok ' + Str( Val( param_rok ), 4 ) + ' i kwoty korekty zakup&_o.w pozosta&_l.ych '
   @  5, 0 SAY '                    WARTO&__S.&__C. NETTO SPRZEDA&__Z.Y      VAT OD ZAKUP.MIESZ.POZOSTA&__L.E   '
   @  6, 0 SAY '                OPODATKOWANA        OG&__O.&__L.EM      WG DOKUMENTU  NAL.STR.WG ' + Str( Val( param_rok ) - 1, 4 ) + '   '
   @  7, 0 SAY ' Stycze&_n.....:                                                                   '
   @  8, 0 SAY ' Luty.......:                                                                   '
   @  9, 0 SAY ' Marzec.....:                                                                   '
   @ 10, 0 SAY ' Kwiecie&_n....:                                                                   '
   @ 11, 0 SAY ' Maj........:                                                                   '
   @ 12, 0 SAY ' Czerwiec...:                                                                   '
   @ 13, 0 SAY ' Lipiec.....:                                                                   '
   @ 14, 0 SAY ' Sierpie&_n....:                                                                   '
   @ 15, 0 SAY ' Wrzesie&_n....:                                                                   '
   @ 16, 0 SAY ' Pa&_x.dziernik:                                                                   '
   @ 17, 0 SAY ' Listopad...:                                                                   '
   @ 18, 0 SAY ' Grudzie&_n....:                                                                   '
   @ 19, 0 SAY ' INNE.......:                                                                   '
   @ 20, 0 SAY ' RAZEM......:                                                                   '
   @ 21, 0 SAY ' Struktura rzeczywista za ' + Str( Val( param_rok ), 4 ) + ' w %.:     Zaktualizowano na z&_l..:                 '
   @ 22, 0 SAY ' Warto&_s.&_c. korekty od zakup&_o.w pozosta&_l.ych do VAT-7 za okr.I.' + Str( Val( param_rok ) + 1, 4 ) + ':                 '
   *################################ OBLICZENIA ################################
   SET CURSOR OFF
   Czekaj()

   SELECT 3
   IF Dostep( 'FIRMA' )
      GO Val( ident_fir )
      spolka_ := spolka
   ELSE
      BREAK
   ENDIF

   zstrusprob := strusprob
   USE

   _koniec := "del#[+].or.firma#ident_fir.or.eof()"

   SELECT 5
   IF Dostep( 'REJZ' )
      SetInd( 'REJZ' )
      SEEK '+' + IDENT_FIR
      KONIEC1 := &_koniec
   ELSE
      BREAK
   ENDIF

   SELECT 1
   IF Dostep( 'REJS' )
      SetInd( 'REJS' )
      SEEK '+' + IDENT_FIR
   ELSE
      BREAK
   ENDIF

   SELECT REJS
   DO WHILE .NOT. &_koniec
      mies_dok := Val( AllTrim( MC ) )
      IF mies_dok > 0 .AND. mies_dok < 13 .AND. AllTrim( RODZDOW ) <> 'FP'
         kwoty_k[ mies_dok, 1 ] := kwoty_k[ mies_dok, 1 ] + WART02 + WART07 + WART22 + WART00 + WART08
         kwoty_k[ mies_dok, 2 ] := kwoty_k[ mies_dok, 2 ] + WART02 + WART07 + WART22 + WART00 + WART08 + WARTZW
      ENDIF

      SKIP 1
   ENDDO

   poka_korva()

   SELECT REJZ
   DO WHILE .NOT. &_koniec
      mies_dok := Val( AllTrim( MC ) )
      IF mies_dok > 0 .AND. mies_dok < 13 .AND. RACH = 'F'
         kwoty_k[ mies_dok, 3 ] := kwoty_k[ mies_dok, 3 ] + iif( SP02 = 'P' .AND. ZOM02 = 'M', VAT02, 0 ) + ;
            iif( SP07 = 'P' .AND. ZOM07 = 'M', VAT07, 0 ) + iif( SP22 = 'P' .AND. ZOM22 = 'M', VAT22, 0 ) + ;
            iif( SP12 = 'P' .AND. ZOM12 = 'M', VAT12, 0 )
      ENDIF
      SKIP 1
   ENDDO

   FOR x_y := 1 TO 12
       kwoty_k[ x_y, 4 ] := _round( kwoty_k[ x_y, 3 ] * ( zstrusprob / 100 ), 2 )
   NEXT

   SELECT 5
   USE
   SELECT 1
   USE

   poka_korva()

   @ 23, 0 CLEAR
   SET CURSOR ON

   DO WHILE LastKey() <> 27
      @ 19, 15 GET INNE_1 PICTURE '  999999999.99'
      @ 19, 31 GET INNE_2 PICTURE '  999999999.99'
      READ

      poka_korva()

      @ 23, 0 SAY '[D lub PrintScreen]-drukowanie ekranu    [Inny klawisz]-wpisanie nowych wartosci'
      kkk := Inkey( 0 )
      IF kkk == 68 .OR. kkk == 100
         DrukujEkran()
      ENDIF
      @ 23, 0 SAY '                                                                                '
   ENDDO
   SET CURSOR OFF

   RETURN NIL

*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

PROCEDURE poka_korva()

   SET COLOR TO W+

   zrokopod := 0
   zrokogol := 0
   zvatdoku := 0
   zvatstru := 0
   zstrusprwy := 0

   FOR x_y := 1 TO 12
       @ 6 + x_y, 15 SAY kwoty_k[ x_y, 1 ] PICTURE '999 999 999.99'
       @ 6 + x_y, 31 SAY kwoty_k[ x_y, 2 ] PICTURE '999 999 999.99'
       zrokopod := zrokopod + kwoty_k[ x_y, 1 ]
       zrokogol := zrokogol + kwoty_k[ x_y, 2 ]
       @ 6 + x_y, 47 SAY kwoty_k[ x_y, 3 ] PICTURE '999 999 999.99'
       @ 6 + x_y, 63 SAY kwoty_k[ x_y, 4 ] PICTURE '999 999 999.99'
       zvatdoku := zvatdoku + kwoty_k[ x_y, 3 ]
       zvatstru := zvatstru + kwoty_k[ x_y, 4 ]
   NEXT

   @ 19, 15 SAY INNE_1 PICTURE '999 999 999.99'
   @ 19, 31 SAY INNE_2 PICTURE '999 999 999.99'

   zrokopod := zrokopod + INNE_1
   zrokogol := zrokogol + INNE_2

   @ 20, 15 SAY zrokopod picture '999 999 999.99'
   @ 20, 31 SAY zrokogol picture '999 999 999.99'
   @ 20, 47 SAY zvatdoku picture '999 999 999.99'
   @ 20, 63 SAY zvatstru picture '999 999 999.99'

   IF zrokogol <> 0.0
      zstrusprwy := ( zrokopod / zrokogol ) * 100
      IF zstrusprwy <= 2.00
         zstrusprwy := 0.00
      ENDIF
      IF zstrusprwy >= 98.00
         zstrusprwy := 100.00
      ENDIF
      IF zstrusprwy - Int( zstrusprwy ) > 0.000000
         zstrusprwy := Int( zstrusprwy ) + 1
      ELSE
         zstrusprwy := Int( zstrusprwy )
      ENDIF
   ENDIF
   @ 21, 36 SAY zstrusprwy PICTURE '999'

   zvatnew := _round( zvatdoku * ( zstrusprwy / 100 ), 2 )

   @ 21, 63 SAY zvatnew PICTURE '999 999 999.99'

   zvatkorn := _int( zvatnew - zvatstru )

   @ 22, 63 SAY zvatkorn PICTURE '999 999 999.99'

   SET COLOR TO

   RETURN NIL
