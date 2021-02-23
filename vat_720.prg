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

#include "Inkey.ch"

PROCEDURE Vat_720( _G, _M, _STR, _OU )

   LOCAL nNumerRec, aDane := hb_Hash()
   RAPORT := RAPTEMP
   PRIVATE P4, P5, P6, P7, P8, P8ni
   PRIVATE P11, P11d, P16, P17, P17a, P18, P19
   PRIVATE P20, P21, P22, P23, P24, P26, P29
   PRIVATE P35, P36
   PRIVATE P45, P46, P47, P48, P49
   PRIVATE P50, P51, P52, P53, P54, P55, P56, P57, P58, P59
   PRIVATE P60, P61, P62, P61a, P62a, P64, P64exp, P64expue, P66
   PRIVATE tresc_korekty_vat7 := ''
   PRIVATE P49_50p := 0, P51_50p := 0, P49tmp, P51tmp
   PRIVATE art111u6 := 0, art89b1 := 0, art89b4 := 0
   PRIVATE KorKOL47, KorKOL48, zZwrRaVAT := 0, zAdrEMail, lSplitPayment := .F.
   PRIVATE cJPKRodzZwrot := ' ', cJPKZwrotPod := 'N', nJPKZwrotKwota := 0, cJPKZwrotRodzZob := Space( 60 )
   PRIVATE resdekl, cEkran
   PRIVATE K_68, K_69  // Ulga na zàe dàugi
   STORE 0 TO P22, P23, P26, P35, P36, K_68, K_69
   STORE 0 TO P45, P46, P47, P48, P49, P50, P51, P52, P53, P54, P55, SEK_CV7net, SEK_CV7vat
   STORE 0 TO P56, P57, P58, P59, P60, P61, P62, P61a, P62a, P64, P64exp, P64expue, P66
   STORE '' TO P4, P5, P6, P7, P8, P11, P16, P17, P17a, P18, P19, P20, P21, P29
   kwarta := 0
   zPOLE4 := 'Miesiac'
   zWERVAT := '    '
   _czy_close := .F.
   spolka_ := .F.

   aDane[ 'ORDZU' ] := hb_Hash()
   aDane[ 'ORDZU' ][ 'rob' ] := .F.
   aDane[ 'ORDZU' ][ 'P_13' ] := ''
   aDane[ 'VATZD' ] := hb_Hash()
   aDane[ 'VATZD' ][ 'rob' ] := .F.
   aDane[ 'VATZD' ][ 'PB' ] := {}
   aDane[ 'VATZD' ][ 'P_10' ] := 0
   aDane[ 'VATZD' ][ 'P_11' ] := 0
   aDane[ 'Firma' ] := ident_fir
   aDane[ 'Miesiac' ] := miesiac

   *#################################     VAT_7      #############################
   BEGIN SEQUENCE
      IF zVATFORDR == '7 '
         zPOLE4 := 'Miesiac'
         zPOLESTO := ' '
         zWERVAT := '(18)'
         P5a := miesiac
         kwapocz := Val( AllTrim( miesiac ) )
         kwakon := Val( AllTrim( miesiac ) )
         _koniec := "del#[+].or.firma#ident_fir.or.miesiac#mc"
      ELSE
         zPOLE4 := 'Kwartal'
         IF zVATFORDR == '7K'
            zPOLESTO := 'K'
            zWERVAT := '(12) '
         ELSE
            zPOLESTO := 'D'
            zWERVAT := '(8) '
         ENDIF
         kwapocz := 1
         kwakon := 3
         kwarta := 1
         DO CASE
         CASE Val( AllTrim( miesiac ) ) >= 1 .AND. Val( AllTrim( miesiac ) ) <= 3
            kwapocz := 1
            kwakon := 3
            kwarta := 1
            P5a := ' 1'
         CASE Val( AllTrim( miesiac ) ) >= 4 .AND. Val( AllTrim( miesiac ) ) <= 6
            kwapocz := 4
            kwakon := 6
            kwarta := 2
            P5a := ' 2'
         CASE Val( AllTrim( miesiac ) ) >= 7 .AND. Val( AllTrim( miesiac ) ) <= 9
            kwapocz := 7
            kwakon := 9
            kwarta := 3
            P5a := ' 3'
         CASE Val( AllTrim( miesiac ) ) >= 10 .AND. Val( AllTrim( miesiac ) ) <= 12
            kwapocz := 10
            kwakon := 12
            kwarta := 4
            P5a := ' 4'
         ENDCASE
         _koniec := "del#[+].or.firma#ident_fir.or.mc<str(kwapocz,2,0).or.mc>str(kwakon,2,0)"
      ENDIF

      SELECT 3
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
         spolka_ := spolka
      ELSE
         BREAK
      ENDIF

      zrokopod := rokopod
      zrokogol := rokogol
      zstrusprwy := strusprwy
      zstrusprob := strusprob

      zAdrEMail := AllTrim( email )

      VAT_ZD_Wczytaj( aDane )
      aDane[ 'VATZD' ][ 'rob' ] := Len( aDane[ 'VATZD' ][ 'PB' ] ) > 0

      SELECT 2
      IF Dostep( 'SUMA_MC' )
         SET INDEX TO suma_mc
         SEEK '+' + ident_fir + miesiac
      ELSE
         BREAK
      ENDIF

      ILS := 0
      ILZ := 0

      IF zVATFORDR == '7 '
        pp8 := vat760
      ELSE
         IF Val( AllTrim( miesiac ) ) > kwapocz
            nNumerRec := RecNo()
            SET INDEX TO suma_mc
            SEEK '+' + ident_fir + Str( kwapocz, 2, 0 )
            pp8 := vat760
            dbGoto( nNumerRec )
         ELSE
            pp8 := vat760
         ENDIF
      ENDIF
      //pp8=vat760

      pp10 := vat759
      pp11 := vat740
      //pp12 := vat736
      pp13 := vat762

      art129 := vatart129

      //art111u6 := a111u6
      //art89b1 := a89b1
      //art89b4 := a89b4
      zZwrRaVAT := ZwrRaVAT

      kkasa_odl := kasa_odl
      kkasa_zwr := kasa_zwr
      k281 := licz_mies
      IF mc <> ' 1'
         SKIP -1
         k281 := Max( licz_mies, k281 )
         SKIP 1
      ENDIF

      p77a := mies6opod
      p77b := mies6ogol

      //znowytran := nowytran
      //zkorekst := korekst
      //zkorekpoz := korekpoz
      zkorekst := 0
      zkorekpoz := 0
      zzwr25dni := zwr25dni
      zzwr60dni := zwr60dni
      zzwr180dni := zwr180dni

      cJPKRodzZwrot :=  ZWRKONTO
      cJPKZwrotPod := iif( ZWRPODAT $ 'TN', ZWRPODAT, 'N' )
      nJPKZwrotKwota := ZWRPODKW
      cJPKZwrotRodzZob := ZWRPODRD
      IF cJPKZwrotPod <> 'T'
         nJPKZwrotKwota := 0
         cJPKZwrotRodzZob := Space( 120 )
      ENDIF

      zf1 := f1
      zf2 := f2
      zf3 := f3
      zf4 := f4
      zf5 := f5

      kordek := 'D'

      zVATZALMIE := VATZALMIE
      zVATNADKWA := VATNADKWA

      IF _STR == 1 .OR. _STR == 2
         @ 24,  0 CLEAR
         @  3, 42 CLEAR TO 22, 79
         ColStd()
         @  3, 42 SAY ' Deklaracja czy korekta ?...Deklaracja'
         IF zVATFORDR == '7D'
            @  4, 42 SAY ' Wplacono VAT za ten miesi.           '
         ENDIF
         SET COLOR TO w+
         @  5, 42 SAY ' ' + PadC( 'C.ROZLICZENIE PODATKU NALE&__Z.NEGO', 37, 'ƒ' )
         ColStd()
         @  6, 42 SAY ' Dostawa 0% z art.129                 '
         //@  7, 42 SAY ' Podatek od spisu z natury            '
         //@  8, 42 SAY ' Zapl.VAT za naby.sr.trans            '
         SET COLOR TO w+
         @  7, 42 SAY ' '+padc('D.ROZLICZENIE PODATKU NALICZONEGO', 37, 'ƒ' )
         ColStd()
         @  8, 42 SAY ' Kwota nadw.pop.deklaracji            '
         @  9, 42 SAY ' Podatek od spisu z natury            '
         //@ 12, 42 SAY ' Korekta pod.nal.od sr.trw.           '
         //@ 13, 42 SAY ' Korekta pod.nal.od pozost.           '
         //@ 12, 42 SAY '                                      '
         //@ 13, 42 SAY '                                      '
         SET COLOR TO w+
         @ 10, 42 SAY ' ' + PadC( 'E.OBLICZENIE WYSOKO&__S.CI ZOBOWI&__A.Z.', 37, 'ƒ' )
         ColStd()
         @ 11, 42 SAY ' Do odliczenia za kasy                '
         @ 12, 42 SAY ' Kwota objeta zaniechaniem            '
         IF zVATFORDR == '7D'
            @ 13, 42 SAY ' Nadplata z poprz.kwartalu            '
         ENDIF
         SET COLOR TO w+
         @ 14, 42 say ' ' + PadC( '(gdy nadwy&_z.ka podatku naliczonego)', 37, 'ƒ' )
         ColStd()
         @ 15, 42 SAY ' Do zwrotu za kasy w okresie          '
         @ 16, 42 SAY ' Do zwrotu na rachunek bank.          '
         IF _OU == 'J'
            @ 17, 42 SAY ' Do zwrotu w terminie (wyb¢r 1-4)     '
            @ 18, 42 SAY ' Zwrot pod.na poczet przysz.zob.      '
            @ 19, 42 SAY ' WysokoòÜ do zwrotu przy.zob.         '
            @ 20, 42 SAY ' Rodzaj przyszl.zob.podat.            '
         ELSE
            @ 17, 42 SAY ' r. VAT               25 dni          '
            @ 18, 42 SAY ' 60 dni              180 dni          '
         ENDIF
*        set colo to w+
*        @ 22,42 to 22,79
*        ColStd()

         @  3, 70 GET kordek PICTURE '!' WHEN wfkordek20( 3, 71 ) VALID vfkordek20( 3, 71 )
         IF zVATFORDR == '7D'
            @  4, 71 GET zVATZALMIE PICTURE FVPIC
         ENDIF

         @  6, 71 GET art129 PICTURE FVPIC
         //@  7, 71 GET pp12 PICTURE FVPIC
         //@  8, 71 GET znowytran PICTURE FVPIC

         @  8, 71 GET pp8  PICTURE FVPIC
         @  9, 71 GET pp11 PICTURE FVPIC
         //@ 12, 71 GET zkorekst PICTURE FVPIC
         //@ 13, 71 GET zkorekpoz PICTURE FVPIC

         @ 11, 71 GET kkasa_odl PICTURE FVPIC
         @ 12, 71 GET pp13 PICTURE FVPIC
         IF zVATFORDR == '7D'
            @ 13, 71 GET zVATNADKWA PICTURE FVPIC
         ENDIF

         @ 15, 71 GET kkasa_zwr PICTURE FVPIC
         @ 16, 71 GET pp10 PICTURE FVPIC
         IF _OU == 'J'
            @ 17, 76 GET cJPKRodzZwrot PICTURE '!' WHEN Vat720WRodzZwrot() VALID Vat720VRodzZwrot()
            @ 18, 76 GET cJPKZwrotPod PICTURE '!' WHEN Vat720WZwrotPod() VALID Vat720VZwrotPod()
            @ 19, 71 GET nJPKZwrotKwota PICTURE FVPIC WHEN Vat720WZwrotKwota() VALID Vat720VZwrotKwota()
            @ 20, 71 GET cJPKZwrotRodzZob PICTURE '@S9 ' + Replicate( '!', 120 ) WHEN Vat720WZwrotRodzZob() VALID Vat720VZwrotRodzZob()
         ELSE
            @ 17, 50 GET zZwrRaVAT PICTURE FVPIC
            @ 17, 71 GET zzwr25dni PICTURE FVPIC
            @ 18, 50 GET zzwr60dni PICTURE FVPIC
            @ 18, 71 GET zzwr180dni PICTURE FVPIC
         ENDIF

         Read_()
         IF LastKey() == K_ESC
            BREAK
         ENDIF

         IF cJPKZwrotPod <> 'T'
            nJPKZwrotKwota := 0
            cJPKZwrotRodzZob := Space( 120 )
         ENDIF

         BlokadaR()
         REPLACE vat759 WITH pp10, vat740 WITH pp11, /*vat736 WITH pp12,*/ vat762 WITH pp13
         REPLACE kasa_odl WITH kkasa_odl, kasa_zwr WITH kkasa_zwr
         REPLACE /*nowytran WITH znowytran, korekst WITH zkorekst, korekpoz WITH zkorekpoz,*/ zwr180dni WITH zzwr180dni
         REPLACE vatart129 WITH art129, zwr60dni WITH zzwr60dni, zwr25dni WITH zzwr25dni
         REPLACE VATZALMIE WITH zVATZALMIE, VATNADKWA WITH zVATNADKWA, ZWRRAVAT WITH zZwrRaVAT
         REPLACE ZWRKONTO WITH cJPKRodzZwrot, ZWRPODAT WITH cJPKZwrotPod
         REPLACE ZWRPODKW WITH nJPKZwrotKwota, ZWRPODRD WITH cJPKZwrotRodzZob

         IF Val( AllTrim( mc ) ) > kwapocz
            nNumerRec := RecNo()
            SET INDEX TO suma_mc
            SEEK '+' + ident_fir + Str( kwapocz, 2, 0 )
            BlokadaR()
            REPLACE vat760 WITH pp8
            dbGoto( nNumerRec )
         ELSE
            REPLACE vat760 with pp8
         ENDIF
         COMMIT
         UNLOCK

         dane_vat := 0
         DO WHILE dane_vat <> 1
            SAVE SCREEN TO NNN
            SET COLOR TO w+
            @ 18, 42 TO 18, 79
            ColPro()
            @ 19, 42 CLEAR TO 22, 79
            @ 19, 42 PROMPT '      INFORMACJA O PODATKU VAT        '
            @ 20, 42 PROMPT 'CZYNNOSCI WYKONYWANE W OKRESIE (sek.F)'
            @ 21, 42 PROMPT ' WYLICZENIE STRUKTURY SPRZEDAZY ' + Str( Val( param_rok ) - 1, 4 ) + 'r.'
            //@ 21, 42 PROMPT '      DODATKOWE POLA DEKLARACJI       '
            @ 22, 42 PROMPT '             ZAù§CZNIKI               '
            MENU TO dane_vat
            ColStd()
            IF LastKey() == K_ESC
               BREAK
            ENDIF
            DO CASE
            CASE dane_vat == 2
               @ 17, 42 CLEAR TO 22,79
               @ 17, 42 TO 22, 79 DOUB
*                 @ 17,43 say ' 1.art.86 ust.8 pkt 1 ustawy (T/N)  '
               @ 18, 43 SAY ' 1.art.119 ustawy            (T/N)  '
               @ 19, 43 SAY ' 2.art.120 ust.4 ustawy      (T/N)  '
               @ 20, 43 SAY ' 3.art.122 ustawy            (T/N)  '
               @ 21, 43 SAY ' 4.art.136 ustawy            (T/N)  '
*                 @ 17,78 get zf1 picture '!'
               @ 18, 78 GET zf2 PICTURE '!'
               @ 19, 78 GET zf3 PICTURE '!'
               @ 20, 78 GET zf4 PICTURE '!'
               @ 21, 78 GET zf5 PICTURE '!'
               Read_()
               IF LastKey() <> K_ESC
                  SELECT 2
                  BlokadaR()
                  REPLACE f1 WITH zf1, f2 WITH zf2, f3 WITH zf3, f4 WITH zf4, f5 WITH zf5
                  COMMIT
                  UNLOCK
               ENDIF
            CASE dane_vat == 3
               @ 20, 42 CLEAR TO 22, 79
               @ 20, 42 TO 22, 79 DOUB
*                @ 18,43 say ' Opodatkow.sprzedaz netto           '
*                @ 19,43 say ' Calkowita sprzedaz netto           '
*                @ 20,43 say ' Wyliczony wskazn.odliczenia       %'
               @ 21, 43 SAY ' Przyjety  wskazn.odliczenia       %'

*                @ 18,70 get zrokopod picture FVPIC
*                @ 19,70 get zrokogol picture FVPIC
*                @ 20,72 get zstrusprwy picture '999' when wstruspr15(20,72)
               @ 21, 72 GET zstrusprob PICTURE '999'
               Read_()
               IF LastKey() <> K_ESC
                  SELECT 3
                  BlokadaR()
                  REPLACE rokopod WITH zrokopod, rokogol WITH zrokogol, strusprwy WITH zstrusprwy ,strusprob WITH zstrusprob
                  COMMIT
                  UNLOCK
               ENDIF
           /* CASE dane_vat == 4
                 @ 17, 11 CLEAR TO 22, 79
                 @ 17, 11 TO 22, 79 DOUBLE
*                 @ 17,43 say ' 1.art.86 ust.8 pkt 1 ustawy (T/N)  '
                 @ 18, 12 SAY ' (37) Korekta lub zwrot kwoty za zakup kasy (art.111 u.6)       '
                 //@ 19, 12 SAY ' (49)         Korekta podatku naliczonego art. 89b ust. 1       '
                 //@ 20, 12 SAY ' (50)         Korekta podatku naliczonego art. 89b ust. 4       '
*                 @ 17,78 get zf1 picture '!'
                 @ 18, 70 GET art111u6 PICTURE FVPIC
                 //@ 19, 70 GET art89b1  PICTURE FVPIC
                 //@ 20, 70 GET art89b4  PICTURE FVPIC
                 Read_()
                 IF LastKey() <> K_ESC
                    SELECT 2
                    BlokadaR()
                    REPLACE a111u6 WITH art111u6
                    //REPLACE a89b1  WITH art89b1
                    //REPLACE a89b4  WITH art89b4
                    UNLOCK
                 ENDIF
                 */
            CASE dane_vat == 4
               aDane[ 'Korekta' ] := kordek == 'K'
               VAT_Zalaczniki19( aDane )

            ENDCASE
            RESTORE SCREEN FROM NNN
         ENDDO
         zDEKLNAZWI := C->DEKLNAZWI
         zDEKLIMIE := C->DEKLIMIE
         zDEKLTEL := C->DEKLTEL
      ELSE
         zDEKLNAZWI := C->DEKLNAZWI
         zDEKLIMIE := C->DEKLIMIE
         zDEKLTEL := C->DEKLTEL
      ENDIF
      ColInb()
      @ 24, 0
      center( 24, 'Prosz&_e. czeka&_c....' )
      ColStd()
      IF LastKey() == K_ESC
         BREAK
      ENDIF
      KONIEC1 := .F.

      SELECT 7
      IF Dostep( 'SPOLKA' )
         SetInd( 'SPOLKA' )
         SEEK '+' + ident_fir
      ELSE
         BREAK
      ENDIF
      IF del # '+' .OR. firma # ident_fir
         Kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej opcji ' )
         BREAK
      ENDIF
*--------------------------------------
      SELECT 6
      IF Dostep( 'URZEDY' )
         SET INDEX TO urzedy
      ELSE
         BREAK
      ENDIF

      SELECT 5
      IF Dostep( 'REJZ' )
         SetInd( 'REJZ' )
         SEEK '+' + IDENT_FIR + Str( kwapocz, 2, 0 )
         KONIEC1 := &_koniec
      ELSE
         BREAK
      ENDIF

      SELECT 4
      IF Dostep( 'KONTR' )
         SetInd( 'KONTR' )
      ELSE
         BREAK
      ENDIF

      SELECT 1
      IF Dostep( 'REJS' )
         SetInd( 'REJS' )
         SEEK '+' + IDENT_FIR + Str( kwapocz, 2, 0 )
      ELSE
         BREAK
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
      STORE 0 TO p45, p46, p47, p47a, p48, p49, p50, p51, p51a, p52, p61, p62, p61a, p62a, p64, p65, p65ue, p67, p69, p70, p71, p72, p75, p76, p77, p78, p79, p98, p99
      STORE 0 TO p64exp, p64expue, K_68, K_69
      STORE 0 TO p45ue, p46ue, p47ue, p47aue, p48ue, p49ue, p50ue, p51ue, p51aue, p52ue
      STORE 0 TO p45it, p46it, p47it, p47ait, p48it, p49it, p50it, p51it, p51ait, p52it
      STORE 0 TO p45us, p46us, p47us, p47aus, p48us, p49us, p50us, p51us, p51aus, p52us
      STORE 0 TO p45usue, p46usue, p47usue, p47ausue, p48usue, p49usue, p50usue, p51usue, p51ausue, p52usue
      STORE 0 TO p45we, p46we, p47we, p47awe, p48we, p49we, p50we, p51we, p51awe, p52we
      STORE 0 TO pp8, pp10, pp11, pp12, pp13, kkasa_odl, kkasa_zwr, znowytran, zkorekst, zkorekpoz, zzwr180dni
      STORE 0 TO art129, zzwr60dni, zzwr25dni, zVATZALMIE, zVATNADKWA, p98doprze, zKOL39
      STORE 'N' TO p98taknie
      SELECT suma_mc
      SEEK '+' + IDENT_FIR + Str( kwapocz, 2, 0 )
      DO WHILE ! &_koniec
         IF Val( AllTrim( mc ) ) == kwapocz
            pp8 := pp8 + vat760
         ENDIF
         pp10 := pp10 + vat759
         pp11 := pp11 + vat740
         //pp12 := pp12 + vat736
         art129 := art129 + vatart129
         //znowytran := znowytran + nowytran
         //zkorekst := zkorekst + korekst
         //zkorekpoz := zkorekpoz + korekpoz
         pp13 := pp13 + vat762
         kkasa_odl := kkasa_odl + kasa_odl
         kkasa_zwr := kkasa_zwr + kasa_zwr
         zzwr25dni := zzwr25dni + zwr25dni
         zzwr60dni := zzwr60dni + zwr60dni
         zzwr180dni := zzwr180dni + zwr180dni
         zVATZALMIE := zVATZALMIE + VATZALMIE
         zVATNADKWA := zVATNADKWA + VATNADKWA

         p77a := mies6opod     //sprzedaz opodatkowana z ostatnich 6-mcy
         p77b := mies6ogol     //ogolem sprzedaz z ostatnich 6-mcy
         k281 := licz_mies
         SKIP 1
      ENDDO
      SELECT rejs
      DO WHILE ! &_koniec
         ILS++
         DO CASE
         CASE At( "MR_UZ", procedur ) > 0 .AND. ( WART02 < 0 .OR. WART12 < 0 .OR. WARTZW < 0 .OR. WART08 < 0 .OR. WART07 < 0 .OR. WART22 < 0 .OR. WART00 < 0 ) .AND. KOREKTA <> 'T'
            // Pomijamy maræa ujemna
         CASE ( SEK_CV7 == '  ' .OR. SEK_CV7 == 'SP' ) .AND. AllTrim( RODZDOW ) <> 'FP'
            IF SEK_CV7 == 'SP'
               lSplitPayment := .T.
            ENDIF
            p61 := p61 + WART02
            p62 := p62 + VAT02
            p61a := p61a + WART12
            p62a := p62a + VAT12
            p64 := p64 + WARTZW
            IF EXPORT == 'T'
               p64exp := p64exp + WART08
            ENDIF
            IF EXPORT == 'T' .AND. UE == 'T'
               p64expue := p64expue + WART08
            ENDIF
            p69 := p69 + WART07
            p70 := p70 + VAT07
            p71 := p71 + WART22
            p72 := p72 + VAT22
            IF WART00 <> 0.00
               IF UE == 'T'
                  p65ue := p65ue + rejs->WART00
               ENDIF
               IF UE <> 'T' .AND. EXPORT == 'T'
                  p65 := p65 + rejs->WART00
               ENDIF
               IF UE <> 'T' .AND. EXPORT <> 'T'
                  p67 := p67 + rejs->WART00
               ENDIF
            ENDIF
         CASE ( SEK_CV7=='PN' .OR. SEK_CV7=='PU' ) .AND. AllTrim( RODZDOW ) <> 'FP'
            SEK_CV7net := SEK_CV7net + WART02 + WARTZW + WART08 + WART07 + WART22 + WART00 + WART12
            SEK_CV7vat := SEK_CV7vat + VAT02 + VAT07 + VAT22 + VAT12
         CASE SEK_CV7 == 'DP' .AND. AllTrim( RODZDOW ) <> 'FP'
            art111u6 := art111u6 + KOL37
            pp12 := pp12 + KOL36
            znowytran := znowytran + KOL38
            zKOL39 := zKOL39 + KOL39
         ENDCASE
         IF KOREKTA == 'Z'
            K_68 := K_68 + iif( WART02 < 0, WART02, 0 ) + iif( WART12 < 0, WART12, 0 ) ;
               + iif( WART08 < 0, WART08, 0 ) + iif( WART07 < 0, WART07, 0 ) ;
               + iif( WART22 < 0, WART22, 0 )
            K_69 := K_69 + iif( VAT02 < 0, VAT02, 0 ) + iif( VAT12 < 0, VAT12, 0) ;
               + iif( VAT08 < 0, VAT08, 0 ) + iif( VAT07 < 0, VAT07, 0 ) ;
               + iif( VAT22 < 0, VAT22, 0 )
         ENDIF
         SKIP 1
      ENDDO
      zpojazdy := 0
      zpaliwa := 0
      SELECT REJZ
      DO WHILE ! &_koniec
         ILZ++
         IF RACH == 'F'
            IF SEK_CV7 <> 'WS' .AND. SEK_CV7 <> 'PS' .AND. SEK_CV7 <> 'IS' .AND. SEK_CV7 <> 'US'
               p45 := p45 + iif( SP02 == 'S' .AND. ZOM02 == 'O' .AND. VAT02 <> 0, WART02, 0 ) + ;
                  iif( SP07 == 'S' .AND. ZOM07 == 'O' .AND. VAT07 <> 0, WART07, 0 ) + ;
                  iif( SP22 == 'S' .AND. ZOM22 == 'O' .AND. VAT22 <> 0, WART22, 0 ) + ;
                  iif( SP12 == 'S' .AND. ZOM12 == 'O' .AND. VAT12 <> 0, WART12, 0 ) + ;
                  iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 )
   *            +iif(SPZW='S',WARTZW,0)
               p47 := p47 + iif( SP02 == 'S' .AND. ZOM02 == 'M' .AND. VAT02 <> 0, WART02 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP07 == 'S' .AND. ZOM07 == 'M' .AND. VAT07 <> 0, WART07 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP22 == 'S' .AND. ZOM22 == 'M' .AND. VAT22 <> 0, WART22 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP12 == 'S' .AND. ZOM12 == 'M' .AND. VAT12 <> 0, WART12 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00 * ( zstrusprob / 100 ), 0 )
               p47a := p47a + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                  iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                  iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                  iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                  iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

               p46 := p46 + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                  iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                  iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                  iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 )
               p48 := p48 + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12 * ( zstrusprob / 100 ), 0 )

               P49tmp := iif( SP02 == 'P' .AND. ZOM02 == 'O' .AND. VAT02 <> 0, WART02, 0 ) + ;
                  iif( SP07 == 'P' .AND. ZOM07 == 'O' .AND. VAT07 <> 0, WART07, 0 ) + ;
                  iif( SP22 == 'P' .AND. ZOM22 == 'O' .AND. VAT22 <> 0, WART22, 0 ) + ;
                  iif( SP12 == 'P' .AND. ZOM12 == 'O' .AND. VAT12 <> 0, WART12, 0 ) + ;
                  iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 )
   *            +iif(SPZW='P',WARTZW,0)
               p49 := p49 + P49tmp
               P51tmp := iif( SP02 == 'P' .AND. ZOM02 == 'M' .AND. VAT02 <> 0, WART02 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP07 == 'P' .AND. ZOM07 == 'M' .AND. VAT07 <> 0, WART07 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP22 == 'P' .AND. ZOM22 == 'M' .AND. VAT22 <> 0, WART22 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP12 == 'P' .AND. ZOM12 == 'M' .AND. VAT12 <> 0, WART12 * ( zstrusprob / 100 ), 0 ) + ;
                  iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00 * ( zstrusprob / 100 ), 0 )
               p51 := p51 + P51tmp
               IF OPCJE $ '257P'
                  P49_50p := P49_50p + P49tmp * 0.5
                  P51_50p := P51_50p + P51tmp * 0.5
               ENDIF
               p51a := p51a + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                  iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                  iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                  iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                  iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

               p50 := p50 + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                  iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                  iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                  iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
               p52 := p52 + iif( SP02 == 'P' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                  iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                  iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                  iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
            ENDIF

            IF param_rok >= '2009'
               DO CASE
               CASE SEK_CV7 == 'WT' .OR. SEK_CV7 == 'WS'
                  p45ue := p45ue + iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'S', WARTZW, 0 )
                  p47ue := p47ue + iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
                  p47aue := p47aue + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

                  p46ue := p46ue + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 ) + paliwa + pojazdy
                  p48ue=p48ue + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12, 0 )

                  p49ue := p49ue + iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'P', WARTZW, 0 )
                  p51ue := p51ue + iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
                  p51aue := p51aue + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

                  p50ue := p50ue + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
                  p52ue := p52ue + iif( SP02 == 'P' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
               CASE SEK_CV7 == 'IT' .OR. SEK_CV7 == 'IS'
                  p45it := p45it + iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                  iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                  iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                  iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                  iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                  iif( SPZW == 'S', WARTZW, 0 )
                  p47it := p47it + iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
                  p47ait := p47ait + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

                  p46it := p46it + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 ) + paliwa + pojazdy
                  p48it := p48it + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12, 0 )

                  p49it := p49it + iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'P', WARTZW, 0 )
                  p51it := p51it + iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
                  p51ait := p51ait + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

                  p50it := p50it + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
                  p52it := p52it + iif( SP02 == 'P' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
               CASE SEK_CV7 == 'IU' .OR. SEK_CV7 == 'US'
                  p45us := p45us + iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'S', WARTZW, 0 )
                  p47us := p47us + iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
                  p47aus := p47aus + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

                  p46us := p46us + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 ) + paliwa + pojazdy
                  p48us := p48us + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12, 0 )

                  p49us := p49us + iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'P', WARTZW, 0 )
                  p51us := p51us + iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
                  p51aus := p51aus + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

                  p50us := p50us + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
                  p52us := p52us + iif( SP02 == 'P' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
                  IF UE == 'T'
                     p45usue := p45usue + iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                        iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                        iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                        iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                        iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                        iif( SPZW == 'S', WARTZW, 0 )
                     p47usue := p47usue + iif( SP02 == 'S' .AND. ZOM02 =='M', WART02, 0 ) + ;
                        iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                        iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                        iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                        iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
                     p47ausue := p47ausue + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                        iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                        iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                        iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                        iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

                     p46usue := p46usue + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                        iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                        iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                        iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 ) + paliwa + pojazdy
                     p48usue := p48usue + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                        iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                        iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                        iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12, 0 )

                     p49usue := p49usue + iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                        iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                        iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                        iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                        iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                        iif( SPZW == 'P', WARTZW, 0 )
                     p51usue := p51usue + iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                        iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                        iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                        iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                        iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
                     p51ausue := p51ausue + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                        iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                        iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                        iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                        iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

                     p50usue := p50usue + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                        iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                        iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                        iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
                     p52usue := p52usue + iif( SP02 == 'P' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                        iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                        iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                        iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
                  ENDIF
               CASE SEK_CV7 == 'PN' .OR. SEK_CV7 == 'PU' .OR. SEK_CV7 == 'PS'
                  p45we := p45we + iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'S', WARTZW, 0 )
                  p47we := p47we + iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
                  p47awe := p47awe + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

                  p46we := p46we + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 ) + paliwa + pojazdy
                  p48we := p48we + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12, 0 )

                  p49we := p49we + iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'P', WARTZW, 0 )
                  p51we := p51we + iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
                  p51awe := p51awe + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

                  p50we := p50we + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
                  p52we := p52we + iif( SP02 == 'P' .AND. ZOM02 =='M', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
               ENDCASE
            ELSE
               DO CASE
               CASE UE == 'T' .AND. WEWDOS <> 'T'
                  p45ue := p45ue + iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'S', WARTZW, 0 )
                  p47ue := p47ue + iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
                  p47aue := p47aue + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

                  p46ue := p46ue + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 ) + paliwa + pojazdy
                  p48ue := p48ue + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12, 0 )

                  p49ue := p49ue + iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'P', WARTZW, 0 )
                  p51ue := p51ue + iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
                  p51aue := p51aue + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

                  p50ue := p50ue + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
                  p52ue := p52ue + iif( SP02 == 'P' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
               CASE EXPORT == 'T' .AND. UE <> 'T' .AND. USLUGAUE == 'T' .AND. WEWDOS <> 'T'
                  p45us := p45us + iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'S', WARTZW, 0 )
                  p47us := p47us + iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
                  p47aus := p47aus + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

                  p46us := p46us + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 ) + paliwa + pojazdy
                  p48us := p48us + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02 , 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12, 0 )

                  p49us := p49us + iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'P', WARTZW, 0 )
                  p51us := p51us + iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
                  p51aus := p51aus + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

                  p50us := p50us + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
                  p52us := p52us + iif( SP02 == 'P' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
               CASE EXPORT == 'T' .AND. WEWDOS == 'T'
                  p45we := p45we + iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'S', WARTZW, 0 )
                  p47we := p47we + iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
                  p47awe := p47awe + iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'S' .AND. ZOM00 == 'Z', WART00, 0 )

                  p46we := p46we + iif( SP02 == 'S' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'O', VAT12, 0 ) + paliwa + pojazdy
                  p48we := p48we + iif( SP02 == 'S' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'S' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'S' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'S' .AND. ZOM12 == 'M', VAT12, 0 )

                  p49we := p49we + iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + ;
                     iif( SPZW == 'P', WARTZW, 0 )
                  p51we := p51we + iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
                  p51awe := p51awe + iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) + ;
                     iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

                  p50we := p50we + iif( SP02 == 'P' .AND. ZOM02 == 'O', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'O', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'O', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'O', VAT12, 0 )
                  p52we := p52we + iif( SP02 == 'P' .AND. ZOM02 == 'M', VAT02, 0 ) + ;
                     iif( SP07 == 'P' .AND. ZOM07 == 'M', VAT07, 0 ) + ;
                     iif( SP22 == 'P' .AND. ZOM22 == 'M', VAT22, 0 ) + ;
                     iif( SP12 == 'P' .AND. ZOM12 == 'M', VAT12, 0 )
               ENDCASE
            ENDIF
            zpaliwa := zpaliwa + paliwa
            zpojazdy := zpojazdy + pojazdy
         ENDIF
         IF KOREKTA == 'T'
            zkorekst := zkorekst + KOL47
            zkorekpoz := zkorekpoz + KOL48
            art89b1 := art89b1 + KOL49
            art89b4 := art89b4 + KOL50
         ENDIF
         SKIP 1
      ENDDO

      p45dek := _round( p45 + p47, 0 )
      p49dek := _round( p49 + p51, 0 )
      IF param_ks5d == '2'
         p49dek :=  p49dek - P49_50p - P51_50p
      ENDIF
      p46dek := _round( p46 + p48, 0 )
      p50dek := _round( p50 + ( p52 * ( zstrusprob / 100 ) ), 0 )

      p65dekue := _round( p45ue + p47ue + p47aue + p49ue + p51ue + p51aue, 0 )
      p65vdekue := _round( p46ue + p48ue + p50ue + p52ue, 0 )

      p65dekit := _round( p45it + p47it + p47ait + p49it + p51it + p51ait, 0 )
      p65vdekit := _round( p46it + p48it + p50it + p52it, 0 )

      p65dekus := _round( p45us + p47us + p47aus + p49us + p51us + p51aus, 0 )
      p65vdekus := _round( p46us + p48us + p50us + p52us, 0 )
      p65dekusu := _round( p45usue + p47usue + p47ausue + p49usue + p51usue + p51ausue, 0 )
      p65vdekusu := _round( p46usue + p48usue + p50usue + p52usue, 0 )

      p65dekus := p65dekus - p65dekusu
      p65vdekus := p65vdekus - p65vdekusu

      p65dekwe := _round( p45we + p47we + p47awe + p49we + p51we + p51awe, 0 )
      p65vdekwe := _round( p46we + p48we + p50we + p52we, 0 )

      p61 := _round( p61, 0 )
      p61a := _round( p61a, 0 )
      p64 := _round( p64, 0 )
      p64exp := _round( p64exp, 0 )
      p64expue := _round( p64expue, 0 )
      p65 := _round( p65, 0 )
      p65ue := _round( p65ue, 0 )
      p67 := _round( p67,0 )
      p67art129 := _round( art129, 0 )
      p69 := _round( p69, 0 )
      p71 := _round( p71, 0 )

      p62 := _round( p62, 0 )
      p62a := _round( p62a,0 )
      p70 := _round( p70, 0 )
      p72 := _round( p72, 0 )

      zpaliwa := _round( zpaliwa, 0 )
      zpojazdy := _round( zpojazdy, 0 )


      p75 := p61 + p61a + p64 + p64exp + p69 + p71 + p67 + p65 + p65ue + p65dekue + p65dekit + p65dekus + p65dekwe + SEK_CV7net + p65dekusu
      p76 := ( p62 + p62a + p70 + p72 + p65vdekue + p65vdekit + p65vdekus + p65vdekwe + pp12 + p65vdekusu + art111u6 ) - znowytran - zKOL39

      p79 := pp8 + pp11 + p46dek + p50dek + zkorekst + zkorekpoz + art89b1 + art89b4

      p98a := Min( kkasa_odl, Max( 0, p76 - p79 ) )
      IF p98a <> kkasa_odl .AND. kkasa_zwr == 0
         kkasa_zwr := kkasa_odl - p98a
      ENDIF

      pp13 := iif( ( p76 - p79 - p98a ) < 0.00, 0, Min( pp13, p76 - p79 - p98a ) )
      p98b := iif( p76 - p79 > 0.0, p76 - p79 - p98a - pp13, 0 )
      p98dozap := Max( 0, p98b - ( zVATZALMIE + zVATNADKWA ) )
      p98rozn := Max( 0,( zVATZALMIE + zVATNADKWA ) - p98b )
      wartprzek := p98b

      p99a := kkasa_zwr
      p99 := iif( p79 - p76 + p99a + p98a >= 0.0, p79 - p76 + p99a + p98a, 0 )

      p99c := pp10
      p99abc := zzwr25dni
      p99ab := zzwr60dni
      p99b := zzwr180dni
      p99d := p99 - p99c //- P99abc - p99ab - p99b
      *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
      SELECT firma
      P4 := nip
      P5b := param_rok
      SELECT urzedy
      IF firma->skarb > 0
         GO firma->skarb
         P6 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
         P6a := kodurzedu
      ELSE
         P6 := Space( 60 )
         P6a := ''
      ENDIF
      p8p := ''
      IF spolka_
         SELECT firma
         P8 := AllTrim( nazwa )
         P11 := SubStr( nr_regon, 3, 9 )
      ELSE
         SELECT spolka
         SEEK '+' + ident_fir + firma->nazwisko
         IF Found()
            P8ni := AllTrim( NAZ_IMIE )
            P8 := SubStr( NAZ_IMIE, 1, At( ' ', NAZ_IMIE ) )
            P8n := AllTrim( P8 )
            subim := SubStr( NAZ_IMIE, At( ' ', NAZ_IMIE ) + 1 )
            P8 := P8 + iif( At( ' ', subim ) == 0, subim, SubStr( subim, 1, At( ' ', subim ) ) )
*            P8i=iif(at(' ',subim)=0,subim,substr(subim,1,at(' ',subim)))
            P8i := AllTrim( SubStr( subim, 1, At( ' ', subim ) ) )
            P11 := DToC( data_ur )
            P11d := data_ur
            P8p := pesel
*            wait 'P8...'+p8+'...'
*            wait 'P8N...'+p8n+'...'
*            wait 'subim...'+subim+'...'
*            wait 'P8i...'+p8i+'...'
         ELSE
            P8 := Space( 60 )
            P8n := ''
            P8i := ''
            P8p := ''
            P11 := Space( 10 )
         ENDIF
      ENDIF
      IF spolka_
         SELECT firma
         P16 := TLX
         P17 := param_woj
         P17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := nr_domu
         P21 := nr_mieszk
         P22 := miejsc
         P23 := kod_p
         P24 := poczta
         P26 := tel
      ELSE
         SELECT spolka
         P16 := KRAJ
         P17 := param_woj
         P17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := Left( nr_domu, 5 )
         P21 := Left( nr_mieszk, 5 )
         P22 := miejsc_zam
         P23 := kod_poczt
         P24 := poczta
         P26 := telefon
      ENDIF
      SELECT firma
      DO CASE
      CASE k281 == 1
         p29 := Space( 16 ) + 'XXX'
      CASE k281 == 2
         p29 := Space( 36 ) + 'XXX'
      CASE k281 == 3
         p29 := Space( 51 ) + 'XXX'
      ENDCASE
      @ 24, 0

      IF zVATFORDR == '7D' .AND. p98rozn > 0.0
         SELECT 2
         IF Dostep( 'SUMA_MC' )
            SET INDEX TO suma_mc
            SEEK '+' + ident_fir + miesiac
            p98taknie := 'T'
            p98doprze := p98rozn
            DeklVKwa()
         ELSE
            BREAK
         ENDIF
      ENDIF

      SELECT 2
      IF zVATFORDR == '7 '
         IF Val( miesiac ) < 12 .AND. Dostep( 'SUMA_MC' )
            SET INDEX TO suma_mc
            SEEK '+' + ident_fir + miesiac
            SKIP 1
            BlokadaR( 'SUMA_MC' )
            suma_mc->vat760 := p99d
            COMMIT
            dbUnlock()
            SKIP -1
         ENDIF
      ELSE
         IF kwarta < 4 .AND. Dostep( 'SUMA_MC' )
            nNumerRec := RecNo()
            SET INDEX TO suma_mc
            SEEK '+' + ident_fir + Str( kwakon + 1, 2, 0 )
            BlokadaR( 'SUMA_MC' )
            suma_mc->vat760 := p99d
   /*         skip 1
            blokadar('SUMA_MC')
            suma_mc->vat760 := p99d
            skip 1
            blokadar('SUMA_MC')
            suma_mc->vat760 := p99d */
            COMMIT
            dbUnlock()
            dbGoto( nNumerRec )
         ENDIF
      ENDIF

      SELECT 100
      USE &RAPORT VIA "ARRAYRDD"

      DO CASE
      CASE _OU == 'D'
         DO CASE
         CASE _STR == 1
            FOR x := 1 TO _G
               rl()
            NEXT
            rl( Space( _M ) + Space( 6 ) + rozrzut( strtran( P4, '-', '' ) ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 24 ) + rozrzut( p5a ) + '    ' + rozrzut( p5b ) )
            FOR x := 1 TO 5
               rl()
            NEXT
            IF kordek == 'D'
               rl( Space( _M ) + Space( 4 ) + PadC( AllTrim( P6 ), 40 ) + Space( 2 ) + 'XXX' )
            ELSE
               rl( Space( _M ) + Space( 4 ) + PadC( AllTrim( P6 ), 40 ) + Space( 17 ) + 'XXX' )
            ENDIF
            FOR x := 1 TO 3
               rl()
            NEXT
            IF spolka_
               rl( Space( _M ) + Space( 14 ) + 'XXX' )
            ELSE
               rl( Space( _M ) + Space( 48 ) + 'XXX' )
            ENDIF
            rl()
            rl( Space( _M ) + Space( 7 ) + PadC( AllTrim( P8 ) + ',' + P11 + ',' + p8p, 60 ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 35 ) + kwota( P64, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P64exp, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P64expue, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P67, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P67art129, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P61 + P61a, 18, 0 ) + Space( 2 ) + kwota( P62 + P62a, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P69, 18, 0 ) + Space( 2 ) + kwota( P70, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P71, 18, 0 ) + Space( 2 ) + kwota( P72, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P65ue, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P65, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P65dekue, 18, 0 ) + Space( 2 ) + kwota( P65vdekue, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P65dekit, 18, 0 ) + Space( 2 ) + kwota( P65vdekit, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P65dekus, 18, 0 ) + Space( 2 ) + kwota( P65vdekus, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P65dekusu, 18, 0 ) + Space( 2 ) + kwota( P65vdekusu, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P65dekwe, 18, 0 ) + Space( 2 ) + kwota( P65vdekwe, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( Pp12, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( znowytran, 18, 0 ) )
            rl()
            rl( Space( _M ) + space( 35 ) + kwota( P75, 18, 0 ) + Space( 2 ) + kwota( P76, 18, 0 ) )
            FOR x := 1 TO 4
               rl()
            NEXT
            rl( Space( _M ) + Space( 55 ) + kwota( Pp8, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( Pp11, 18, 0 ) )
         case _STR=2
            IF zVATFORDR <> '7D'
               DeklPodp()
            ENDIF
            FOR x := 1 TO _G
               rl()
            NEXT
   *             if zVATFORDR='7D'
   *             for x=1 to 5
   *                 rl()
   *             next
   *             rl(space(_M)+space(35)+kwota(P45dek,18,0)+space(2)+kwota(P46dek,18,0))
   *             rl()
   *             rl(space(_M)+space(35)+kwota(P49dek,18,0)+space(2)+kwota(P50dek,18,0))
   *             for x=1 to 3
   *                 rl()
   *             next
   *             rl(space(_M)+space(55)+kwota(zkorekst,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(zkorekpoz,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(P79,18,0))
   *             for x=1 to 3
   *                 rl()
   *             next
   *             rl(space(_M)+space(55)+kwota(P98a,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(Pp13,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(P98b,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(zVATZALMIE,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(zVATNADKWA,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(P98dozap,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(P98rozn,18,0))
   *             rl()
   *             rl(space(_M)+space(40)+iif(p98taknie='T','XXX       ','       XXX')+space(5)+kwota(P98doprze,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(P99a,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(P99,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(P99c,18,0))
   *             rl()
   *             rl(space(_M)+space(15)+kwota(P99abc,18,0)+space(2)+kwota(P99ab,18,0)+space(2)+kwota(P99b,18,0))
   *             rl()
   *             rl(space(_M)+space(55)+kwota(P99d,18,0))
   *             for x=1 to 3
   *                 rl()
   *             next
   *             rl(space(_M)+space(7)+iif(zf1='T','XX','  ')+space(12)+iif(zf2='T','XX','  ')+space(12)+iif(zf3='T','XX','  ')+space(12)+iif(zf4='T','XX','  ')+space(11)+iif(zf5='T','XX','  '))
   *             else
            rl( Space( _M ) + Space( 35 ) + kwota( P45dek, 18, 0 ) + Space( 2 ) + kwota( P46dek, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 35 ) + kwota( P49dek, 18, 0 ) + Space( 2 ) + kwota( P50dek, 18, 0 ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 55 ) + kwota( zkorekst, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( zkorekpoz, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( P79, 18, 0 ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 55 ) + kwota( P98a, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( Pp13, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( P98b, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( P99a, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( P99, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 55 ) + kwota( P99c, 18, 0 ) )
            rl()
            rl( Space( _M ) + Space( 15 ) + kwota( P99abc, 18, 0 ) + Space( 2 ) + kwota( P99ab, 18, 0 ) + Space( 2 ) + kwota( P99b, 18, 0 ) )
   *             rl(space(_M)+space(55)+kwota(P99b,18,0))
            FOR x := 1 TO 2
               rl()
            NEXT
            rl( Space( _M ) + Space( 55 ) + kwota( P99d, 18, 0 ) )
            FOR x := 1 TO 3
               rl()
            NEXT
   *             rl(space(_M)+space(6)+iif(zf1='T','XX','  ')+space(14)+iif(zf2='T','XX','  ')+space(10)+iif(zf3='T','XX','  ')+space(14)+iif(zf4='T','XX','  ')+space(12)+iif(zf5='T','XX','  '))
   *             rl(space(_M)+space(6)+iif(zf2='T','XX','  ')+space(15)+iif(zf3='T','XX','  ')+space(17)+iif(zf4='T','XX','  ')+space(16)+iif(zf5='T','XX','  '))
            rl( Space( _M ) + Space( 26 ) + iif( zf2 == 'T', 'XX', '  ' ) + Space( 9 ) + iif( zf3 == 'T', 'XX', '  ' ) + Space( 15 ) + iif( zf4 == 'T', 'XX', '  ' ) + Space( 10 ) + iif( zf5 == 'T', 'XX', '  ' ) )
            FOR x := 1 TO 11
               rl()
            NEXT
            rl( Space( _M ) + Space( 5 ) + zDEKLIMIE + '   ' + zDEKLNAZWI )
            rl()
            rl( Space( _M ) + Space( 5 ) + zDEKLTEL )
   *             endif
         ENDCASE
      CASE _OU == 'P'
         rl( PadC( 'VAT-7' + zPOLESTO + '  DEKLARACJA PODATKOWA DLA PODATKU OD TOWAR&__O.W I US&__L.UG', 80 ) )
         rl( '(01) Numer identyfikacyjny podatnika: ' + P4 )
         rl( '(04) ' + zPOLE4 + ': ' + P5a + '   (05) rok: ' + P5b )
         rl()
         rl( PadC( 'A. MIEJSCE I CEL SK&__L.ADANIA DEKLARACJI', 80 ) )
         rl( PadC( '=====================================', 80 ) )
         rl( '(06) Urz&_a.d Skarbowy: ' + P6 )
         rl( '(07) Cel z&_l.o&_z.enia formularza: ' + iif( kordek == 'D', 'deklaracja', 'korekta' ) )
         rl()
         rl( PadC( 'B. DANE IDENTYFIKACYJNE PODATNIKA', 80 ) )
         rl( PadC( '=================================', 80 ) )
         IF spolka_
            rl( '(08) Podatnik niebedacy osoba fizyczna' )
            rl( '(09) Nazwa pe&_l.na,regon: ' + P8 + ',' + P11 )
         ELSE
            rl( '(08) Osoba fizyczna' )
            rl( '(09) Nazwisko,imie,data urodz.: ' + P8 + ',' + P11 )
         endif
         rl()
         rl( PadC( 'C. ROZLICZENIE PODATKU NALE&__Z.NEGO', 80 ) )
         rl( PadC( '================================', 80 ) )
         rl(                                          PadL( '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø', 80, ' ' ) )
         rl(                                          PadL( '≥Podstawa opoda-≥    Podatek    ≥', 80, ' ' ) )
         rl(                                          PadL( '≥ tkowania w zl ≥ nale&_z.ny w z&_l.  ≥', 80, ' ' ) )
         rl(                                          PadL( '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥', 80 ) )
         rl( ' 1.Dostawa tow.oraz swi.uslug w kraju, zwolnio.≥' + kwota( P64, 14, 0 ) + ' ≥               ≥' )
         rl( ' 2.Dostawa tow.oraz swi.uslug poza teryt.kraju ≥' + kwota( P64exp, 14, 0 ) + ' ≥               ≥' )
         rl( '       w tym art.100 ust.1 pkt 4 ustawy        ≥' + kwota( P64expue, 14, 0) + ' ≥               ≥' )
         rl( ' 3.Dostawa tow.oraz swi.uslug w kraju, 0%      ≥' + kwota( P67, 14, 0 ) + ' ≥               ≥' )
         rl( '       w tym dostawa towarow zgodnie z art.129 ≥' + kwota( P67art129, 14, 0 ) + ' ≥               ≥' )
         rl( ' 4.Dostawa tow.oraz swi.uslug w kraju, 3lub5%  ≥' + kwota( P61 + P61a, 14, 0 ) + ' ≥' + kwota( P62 + P62a, 14, 0 ) + ' ≥' )
         rl( ' 5.Dostawa tow.oraz swi.uslug w kraju, 7lub8%  ≥' + kwota( P69, 14, 0 ) + ' ≥' + kwota( P70, 14, 0 ) + ' ≥' )
         rl( ' 6.Dostawa tow.oraz swi.uslug w kraju,22lub23% ≥' + kwota( P71, 14, 0 ) + ' ≥' + kwota( P72, 14, 0 ) + ' ≥' )
         rl( ' 7.Wewnatrzwspolnotowa dostawa towarow         ≥' + kwota( P65ue, 14, 0 ) + ' ≥               ≥' )
         rl( ' 8.Eksport towarow                             ≥' + kwota( P65, 14, 0 ) + ' ≥               ≥' )
         rl( ' 9.Wewnatrzwspolnotowe nabycie towarow         ≥' + kwota( P65dekue, 14, 0 ) + ' ≥' + kwota( P65vdekue, 14, 0 ) + ' ≥' )
         rl( '10.Import towarow,podl.rozlicz.z art.33a       ≥' + kwota( P65dekit, 14, 0 ) + ' ≥' + kwota( P65vdekit, 14, 0 ) + ' ≥' )
         rl( '11.Import uslug                                ≥' + kwota( P65dekus, 14, 0 ) + ' ≥' + kwota( P65vdekus, 14, 0 ) + ' ≥' )
         rl( '       w tym art.28b                           ≥' + kwota( P65dekusu, 14, 0 ) + ' ≥' + kwota(P65vdekusu, 14, 0 ) + ' ≥' )
         rl( '12.Dostawa tow.dla ktorej podatn.jest nabywca  ≥' + kwota( P65dekwe, 14, 0 ) + ' ≥' + kwota( P65vdekwe, 14, 0 ) + ' ≥' )
         rl(                                          PadL( '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥', 80, ' ' ) )
         rl( '13.Podatek nalezny od spisu z natury                           ≥' + kwota( Pp12, 14, 0 ) + ' ≥' )
         rl( '14.Kwota zapl.pod.od wewnatrzwspolnotowego nabycia sr.transpor.≥' + kwota( znowytran, 14, 0 ) + ' ≥' )
         rl(                                          PadL( '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥', 80, ' ' ) )
         rl( 'RAZEM                                          ≥' + kwota( P75, 14, 0 ) + ' ≥' + kwota( P76, 14, 0 ) + ' ≥' )
         rl(                                          PadL( '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ', 80, ' ' ) )
         rl()
         rl( PadC( 'D. ROZLICZENIE PODATKU NALICZONEGO', 80 ) )
         rl( PadC( '==================================', 80 ) )
         rl( 'D.1. PRZENIESIENIA' + Space( 45 ) +                '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø' )
         rl( '------------------' + Space( 45 ) +                '≥  Podatek do   ≥' )
         rl(                                               PadL( '≥odliczenia w z&_l.≥', 80, ' ' ) )
         rl(                                               PadL( '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥', 80, ' ' ) )
         rl( 'Kwota nadwy&_z.ki z poprzedniej deklaracji' + Space( 24 ) + '≥' + kwota( Pp8, 14, 0 ) + ' ≥' )
         rl( 'Kwota podatku naliczonego ze spisu z natury' + Space( 20 ) + '≥' + kwota( Pp11, 14, 0 ) + ' ≥' )
         rl(                                               PadL( '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ', 80, ' ' ) )
         rl( 'D.2. NABYCIE TOWAROW I USLUG ORAZ PODATEK NALICZONY Z UWZGLEDNIENIEM KOREKT' )
         rl( '---------------------------------------------------------------------------' )
         rl(                                          PadL( '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø', 80, ' ' ) )
         rl(                                          PadL( '≥Warto&_s.&_c. zakupu ≥    Podatek    ≥', 80, ' ' ) )
         rl(                                          PadL( '≥  netto w z&_l..  ≥naliczony w z&_l..≥', 80, ' ' ) )
         rl( '                                               √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥' )
         rl( 'Nabycie towarow i uslug zaliczanych do Sr.Trw. ≥' + kwota( P45dek, 14, 0 ) + ' ≥' + kwota( P46dek, 14, 0 ) + ' ≥' )
         rl( 'Nabycie towarow i uslug pozostalych            ≥' + kwota( P49dek, 14, 0 ) + ' ≥' + kwota( P50dek, 14, 0 ) + ' ≥' )
         rl(                                          PadL( '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ', 80, ' ' ) )
         rl( 'D.3. PODATEK NALICZONY DO ODLICZENIA (w z&_l.)' )
         rl( '----------------------------------------------' )
         rl(                                                          PadL( '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø', 80, ' ' ) )
         rl( 'Korekta podatku naliczonego od nabycia srodkow trwalych        ≥' + kwota( zkorekst, 14, 0 ) + ' ≥' )
         rl( 'Korekta podatku naliczonego od pozostalych nabyc               ≥' + kwota( zkorekpoz, 14, 0 ) + ' ≥' )
         rl(                                                          PadL( '√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥', 80, ' ' ) )
         rl( 'RAZEM kwota podatku naliczonego do odliczenia                  ≥' + kwota( P79, 14, 0 ) + ' ≥' )
         rl(                                                          PadL( '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ', 80, ' ' ) )
         rl()
         rl( padc('E. OBLICZENIE WYSOKO&__S.CI ZOBOWI&__A.ZANIA PODATKOWEGO LUB KWOTY ZWROTU', 80 ) )
         rl( padc('=================================================================', 80 ) )
         rl(                                                          PadL( '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø', 80, ' ' ) )
         rl( 'Kwota wydatkowana na zakup kas, do odliczenia w danym okresie  ≥' + kwota( P98a, 14, 0 ) + ' ≥' )
         rl( 'Kwota podatku obj&_e.ta zaniechaniem poboru                       ≥' + kwota( Pp13, 14, 0 ) + ' ≥' )
         rl( 'Kwota podatku podlegaj&_a.cego wp&_l.acie do urz&_e.du skarbowego       ≥' + kwota( P98b, 14, 0 ) + ' ≥' )
         IF zVATFORDR == '7D'
            rl( 'Suma zaliczek wplaconych w kwartale,ktorego deklaracja dotyczy ≥' + kwota( zVATZALMIE, 14, 0 ) + ' ≥' )
            rl( 'Kwota nadplaty z poprzedniego kwartalu                         ≥' + kwota( zVATNADKWA, 14, 0 ) + ' ≥' )
            rl( 'DO ZAPLATY                                                     ≥' + kwota( P98dozap, 14, 0 ) + ' ≥' )
            rl( 'NADPLATA                                                       ≥' + kwota( P98rozn, 14, 0 ) + ' ≥' )
            rl( 'Zaliczenie nadplaty na poczet przyszlych zobowiazan: ' + iif( p98taknie == 'T', 'TAK', 'NIE' ) + '       ≥' + kwota( P98doprze, 14, 0 ) + ' ≥' )
         ENDIF
         rl('Kwota wydatkowana na zakup kas, do zwrotu w okresie rozlicz.   ≥' + kwota( P99a, 14, 0 ) + ' ≥' )
         rl('Nadwy&_z.ka podatku naliczonego nad nale&_z.nym                      ≥' + kwota( P99, 14, 0 ) + ' ≥' )
         rl('   Kwota do zwrotu na wskazany rachunek bankowy                ≥' + kwota( P99c, 14, 0 ) + ' ≥' )
         rl('   w tym: Kwota do zwrotu w terminie  25 dni                   ≥' + kwota( P99abc, 14, 0 ) + ' ≥' )
         rl('          Kwota do zwrotu w terminie  60 dni                   ≥' + kwota( P99ab, 14, 0 ) + ' ≥' )
         rl('          Kwota do zwrotu w terminie 180 dni                   ≥' + kwota( P99b, 14, 0 ) + ' ≥' )
         rl('   Kwota do przeniesienia na nastepny okres rozliczeniowy      ≥' + kwota( P99d, 14, 0 ) + ' ≥' )
         rl(                                                         PadL( '¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ', 80, ' ' ) )
      CASE _OU == 'K'
         DeklPodp()
         SWITCH GraficznyCzyTekst()
         CASE 0
            EXIT
         CASE 1
            SWITCH zVATFORDR
            CASE '7 '
               DeklarDrukuj( 'VAT7-20' )
               EXIT
            CASE '7K'
               DeklarDrukuj( 'VAT7K-14' )
               EXIT
            CASE '7D'
               DeklarDrukuj( 'VAT7D-8' )
               EXIT
            ENDSWITCH
            EXIT
         CASE 2
            KVat_720()
            IF kordek == 'K'
               IF TNEsc( , 'Czy wydrukowaÜ formularz przyczyn korekty ORD-ZU? (T/N)' )
                  tresc_korekty_vat7 := edekOrdZuTrescPobierz( 'VAT-7', Val( AllTrim( ident_fir ) ), Val( AllTrim( miesiac ) ) )
                  IF ValType( tresc_korekty_vat7 ) == "C"
                     kartka_ordzu( P4,;
                        iif( spolka_, P8, naz_imie_naz( P8ni ) ), ;
                        iif( spolka_, '', naz_imie_imie( P8ni ) ), ;
                        iif( spolka_, '', DToC( P11d ) ), ;
                        iif( spolka_, P11, '' ), ;
                        '', '', '', '', '', tresc_korekty_vat7, '3' )
                  ENDIF
               ENDIF
            ENDIF
            EXIT
         ENDSWITCH
      CASE _OU == 'X'
         //IF kordek == 'K'
            //tresc_korekty_vat7 := edekOrdZuTrescPobierz( 'VAT-7', Val( AllTrim( ident_fir ) ), Val( AllTrim( miesiac ) ) )
         //ENDIF
//         IF ValType( tresc_korekty_vat7 ) == "C"
            tresc_korekty_vat7 := aDane[ 'ORDZU' ][ 'P_13' ]
            resdekl := ''
            edeklaracja_plik := 'VAT_' + AllTrim( zVATFORDR ) + '_' + normalizujNazwe( AllTrim( symbol_fir ) ) + '_' + AllTrim( p5b ) + '_' + AllTrim( P5a )
            DO CASE
            CASE zVATFORDR == '7 '
               resdekl := edek_vat7_20( aDane )
               edekZapiszXml( resdekl, edeklaracja_plik, wys_edeklaracja, 'VAT7-20', kordek == 'K', Val( miesiac ) )
            CASE zVATFORDR == '7K'
               resdekl := edek_vat7k_14( aDane )
               edekZapiszXml( resdekl, edeklaracja_plik, wys_edeklaracja, 'VAT7K-14', kordek == 'K', Val( miesiac ) )
            CASE zVATFORDR == '7D'
               resdekl := edek_vat7d_8( aDane )
               edekZapiszXml( resdekl, edeklaracja_plik, wys_edeklaracja, 'VAT7D-8', kordek == 'K', Val( miesiac ) )
            ENDCASE
//         ENDIF
      CASE _OU == 'I'
         infov716()
//      CASE _OU == 'E'
//         e_vat712()
      CASE _OU == 'J'
         resdekl := JPK_V7_DaneDek()
         IF kordek == 'K'
            resdekl[ 'ORDZU' ] := aDane[ 'ORDZU' ][ 'P_13' ]
         ENDIF
         _czy_close := .T.
      ENDCASE
   END

   IF _czy_close
      close_()
   ENDIF

   RETURN iif( _OU == 'J', resdekl, NIL )

***************************************************
FUNCTION wfkordek20( x, y )

   ColInf()
   @ 24, 0 SAY PadC( 'Cel zlozenia formularza: D-deklaracja   lub   K-korekta', 80, ' ' )
   ColStd()
   @  x, y SAY iif( KORDEK == 'K', 'orekta   ', 'eklaracja' )
   RETURN .T.

***************************************************
FUNCTION vfkordek20( x, y )

   R := .F.
   IF kordek $ 'DK'
      ColStd()
      @  x, y SAY iif( kordek == 'K', 'orekta   ', 'eklaracja' )
      @ 24, 0
      R := .T.
   ENDIF
   RETURN R

***************************************************
*function wfzgrosz
*para x,y
*ColInf()
*@ 24,0 say padc('Co zrobic z groszami: O-odrzucic   lub   Z-zaokraglic',80,' ')
*ColStd()
*@ x,y say iif(zGROSZ='O','dciete   ','aokragl. ')
*return .t.
***************************************************
*function vfzgrosz
*para x,y
*R=.f.
*if zgrosz$'OZ'
*   ColStd()
*   @ x,y say iif(zGROSZ='O','dciete   ','aokragl. ')
*   @ 24,0
*   R=.t.
*endif
*return R
***************************************************
FUNCTION wstruspr20( x, y )

   ColStd()
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
   @ x, y SAY zstrusprwy PICTURE '999'
   RETURN .F.

/*----------------------------------------------------------------------*/

FUNCTION Vat720WRodzZwrot()

   LOCAL cKolor := ColInf()

   cEkran := SaveScreen()

   @ 10, 22 CLEAR TO 16, 79
   @ 10, 22 TO 16, 79
   @ 11, 23 SAY ' 1 - Zwrot na rachunek VAT w terminie 25 dni'
   @ 12, 23 SAY ' 2 - Zwrot na rachunek rozliczeniowy w terminie 25 dni'
   @ 13, 23 SAY ' 3 - Zwrot na rachunek rozliczeniowy w terminie 60 dni'
   @ 14, 23 SAY ' 4 - Zwrot na rachunek rozliczeniowy w terminie 180 dni'
   @ 15, 23 SAY '   - Ωadne z powyæszych'

   SetColor( cKolor )

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION Vat720VRodzZwrot()

   LOCAL lRes := AScan( { '1', '2', '3', '4', ' ' }, cJPKRodzZwrot ) > 0

   IF lRes
      RestScreen( , , , , cEkran )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION Vat720WZwrotPod()

   LOCAL cKolor := ColInf()

   @ 24, 0 SAY PadC( 'Podatnik wnosi o zalicz. zwrotu pod. na poczet przyszàych zobowi•za‰ podat.', 80 )
   SetColor( cKolor )

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION Vat720VZwrotPod()

   LOCAL lRes := cJPKZwrotPod $ 'TN'

   IF lRes
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION Vat720WZwrotKwota()

   LOCAL cKolor
   LOCAL lRes := cJPKZwrotPod == 'T'

   IF lRes
      cKolor := ColInf()
      @ 24, 0 SAY PadC( 'Podatnik wnosi o zalicz. zwrotu pod. na poczet przyszàych zobowi•za‰ podat.', 80 )
      SetColor( cKolor )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION Vat720VZwrotKwota()

   LOCAL lRes := nJPKZwrotKwota > 0

   IF lRes
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION Vat720WZwrotRodzZob()

   LOCAL cKolor
   LOCAL lRes := cJPKZwrotPod == 'T'

   IF lRes
      cKolor := ColInf()
      @ 24, 0 SAY PadC( 'Rodzaj przyszàego zobowi•zania podatkowego', 80 )
      SetColor( cKolor )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION Vat720VZwrotRodzZob()

   LOCAL lRes := Len( AllTrim( cJPKZwrotRodzZob ) ) > 0

   IF lRes
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION JPK_V7_DaneDek( aDane )

   LOCAL hDane := hb_Hash()

   hDane['Rok'] := AllTrim( param_rok )

   hDane['Miesiac'] := AllTrim( p5a )
   hDane['Spolka'] := spolka_
   IF spolka_
      hDane['PelnaNazwa'] := str2sxml( AllTrim( P8 ) )
   ELSE
      hDane['ImiePierwsze'] := str2sxml( naz_imie_imie( AllTrim( P8ni ) ) )
      hDane['Nazwisko'] := str2sxml( naz_imie_naz( AllTrim( P8ni ) ) )
      hDane['DataUrodzenia'] := P11d
   ENDIF

   hDane['Korekta'] := kordek == 'K'
   IF ( hDane['Kwartalnie'] := zVATFORDR == '7K' )
      hDane['Kwartal'] := kwarta
   ENDIF

   hDane['P_10'] := _round( P64, 0 )
   hDane['P_11'] := _round( P64exp, 0 )
   hDane['P_12'] := _round( P64expue, 0 )
   hDane['P_13'] := _round( P67, 0 )
   hDane['P_14'] := _round( P67art129, 0 )
   hDane['P_15'] := _round( P61+P61a, 0 )
   hDane['P_16'] := _round( P62+P62a, 0 )
   hDane['P_17'] := _round( P69, 0 )
   hDane['P_18'] := _round( P70, 0 )
   hDane['P_19'] := _round( P71, 0 )
   hDane['P_20'] := _round( P72, 0 )
   hDane['P_21'] := _round( P65ue, 0 )
   hDane['P_22'] := _round( P65, 0 )
   hDane['P_23'] := _round( P65dekue, 0 )
   hDane['P_24'] := _round( P65vdekue, 0 )
   hDane['P_25'] := _round( P65dekit, 0 )
   hDane['P_26'] := _round( P65vdekit, 0 )
   hDane['P_27'] := _round( P65dekus, 0 )
   hDane['P_28'] := _round( P65vdekus, 0 )
   hDane['P_29'] := _round( P65dekusu, 0 )
   hDane['P_30'] := _round( P65vdekusu, 0 )
   hDane['P_31'] := _round( SEK_CV7net, 0 )
   hDane['P_32'] := _round( SEK_CV7vat, 0 )
   hDane['P_33'] := _round( Pp12, 0 )
   hDane['P_34'] := _round( art111u6, 0 )
   hDane['P_35'] := _round( znowytran, 0 )
   hDane['P_36'] := _round( zKOL39, 0 )
   hDane['P_37'] := _round( P75, 0 )
   hDane['P_38'] := _round( P76, 0 )
   hDane['P_39'] := _round( Pp8, 0 )
   hDane['P_40'] := _round( P45dek, 0 )
   hDane['P_41'] := _round( P46dek, 0 )
   hDane['P_42'] := _round( P49dek, 0 )
   hDane['P_43'] := _round( P50dek, 0 )
   hDane['P_44'] := _round( zkorekst, 0 )
   hDane['P_45'] := _round( zkorekpoz, 0 )
   hDane['P_46'] := _round( art89b1, 0 )
   hDane['P_47'] := _round( art89b4, 0 )
   hDane['P_48'] := _round( P79, 0 )
   hDane['P_49'] := _round( P98a, 0 )
   hDane['P_50'] := _round( pp13, 0 )
   hDane['P_51'] := _round( P98b, 0 )
   hDane['P_52'] := _round( P99a, 0 )
   hDane['P_53'] := _round( P99, 0 )
   hDane['P_54'] := _round( P99c, 0 )
   hDane['P_55'] := cJPKRodzZwrot == '1'
   hDane['P_56'] := cJPKRodzZwrot == '2'
   hDane['P_57'] := cJPKRodzZwrot == '3'
   hDane['P_58'] := cJPKRodzZwrot == '4'
   hDane['P_59'] := cJPKZwrotPod == 'T'
   hDane['P_60'] := nJPKZwrotKwota
   hDane['P_61'] := AllTrim( cJPKZwrotRodzZob )
   hDane['P_62'] := Int( Max( 0, P99d ) )
   hDane['P_63'] := iif( zf2 == 'T', .T., .F. )
   hDane['P_64'] := iif( zf3 == 'T', .T., .F. )
   hDane['P_65'] := iif( zf4 == 'T', .T., .F. )
   hDane['P_66'] := iif( zf5 == 'T', .T., .F. )
   hDane['P_67'] := .F.
   hDane['P_68'] := _round( K_68, 0 )
   hDane['P_69'] := _round( K_69, 0 )

   RETURN hDane

/*----------------------------------------------------------------------*/
