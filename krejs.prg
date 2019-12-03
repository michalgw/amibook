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

#include "Inkey.ch"
#include "ami_book.ch"

PROCEDURE KRejS()

   LOCAL lRyczModSys := .F.

   PRIVATE _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou
   PRIVATE zDzien, zNazwa, zNr_Ident, zNumer, zAdres, zTresc, zRokS, zMcS, zDzienS
   PRIVATE zDataS, zKolumna, zUwagi, zWartZW, zWart08, zWart00, zWart02, zVat02
   PRIVATE zWart07, zVat07, zWart22, zVat22, zWart12, zVat12, zNetto, zExport, zUe
   PRIVATE zKraj, zSek_CV7, zRach, zDetal, zKorekta, zRozrZapS, zZap_Ter, zZap_Dat
   PRIVATE zZap_Wart, zTrojstr, zKOL36, zKOL37, zKOL38, zKOL39, zNETTO2, zKOLUMNA2, zNETTOOrg

   zexport := 'N'
   scr_kolumC := .F.
   @ 1, 47 SAY '          '
   m->liczba := 1
   LpStart()

   sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.01' ) )

   *################################# GRAFIKA ##################################
   krejsRysujTlo()
   *############################### OTWARCIE BAZ ###############################
   OpenOper( 'REJS' )
   IF ZamSum()
      RETURN
   ENDIF
   DO CASE
   CASE miesiac == ' 1' .OR. miesiac == ' 3' .OR. miesiac == ' 5' .OR. miesiac == ' 7' .OR. miesiac == ' 8' .OR. miesiac == '10' .OR. miesiac == '12'
      DAYM := '31'
   CASE miesiac == ' 4' .OR. miesiac == ' 6' .OR. miesiac == ' 9' .OR. miesiac == '11'
      DAYM := '30'
   CASE miesiac == ' 2'
      DAYM := '29'
      IF Day( CToD( param_rok + '.' + miesiac + '.' + DAYM ) ) == 0
         DAYM := '28'
      ENDIF
   ENDCASE
   *################################# OPERACJE #################################
   *----- parametry ------
   _top := 'firma#ident_fir.or.mc#miesiac'
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + miesiac
   _sbot := '+' + ident_fir + miesiac + '‏'
   _proc := 'say1s'
   *----------------------
   _top_bot := _top + '.or.' + _bot
   IF ! &_top_bot
      DO &_proc
   ENDIF
   scr_sekcv7 := SaveScreen( 3, 40, 8, 79 )
   kl := 0
   zSYMB_REJ := '  '
   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      kl := Inkey( 0 )
      Ster()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl == K_ALT_K
         Kalkul()
      CASE kl == K_ALT_N
         Notes()
      CASE kl == Asc( 'I' ) .OR. kl == Asc( 'i' )
         // Import z JPK
         JPKImp_VatS()
         IF &_bot
            SEEK '+' + ident_fir + miesiac
         ENDIF
         IF ! &_bot
            DO &_proc
         ENDIF
      CASE ( kl == K_INS .OR. kl == Asc( '0' ) .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' ) .OR. &_top_bot ) .AND. kl # K_ESC .AND. kl # K_F1
         @ 1, 47 SAY '          '
         ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
         JESTNIP := .F.
         KtorOper()
         BEGIN SEQUENCE
            IF ZamSum1()
               BREAK
            ENDIF
            KRejSRysujTlo()
            *ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
            IF ins
               @  4, 78 CLEAR TO 5, 79
               @  4, 29 CLEAR TO 7, 69
*                 @  9,41 clear to 10,50
               @ 12, 14 CLEAR TO 19, 62
               zDZIEN := '  '
               znazwa := Space( 100 )
               zNR_IDENT := Space( 30 )
               zNUMER := Space( 40 )
               zADRES := Space( 100 )
               zTRESC := Space( 30 )
               zROKS := '    '
               zMCS := '  '
               zDZIENS := '  '
               zDATAS := CToD( zROKS + '.' + zMCS + '.' + zDZIENS )
               IF zRYCZALT == 'T'
                  zKOLUMNA := '  '
               ELSE
                  zKOLUMNA := '7'
               ENDIF
               zuwagi := Space( 20 )
*                 zzaplata=[1]
*                 zkwota=0
               zWARTZW := 0
               zWART08 := 0
               zWART00 := 0
               zWART02 := 0
               zVAT02 := 0
               zWART07 := 0
               zVAT07 := 0
               zWART22 := 0
               zVAT22 := 0
               zWART12 := 0
               zVAT12 := 0
               zBRUTZW := 0
               zBRUT08 := 0
               zBRUT00 := 0
               zBRUT02 := 0
               zBRUT07 := 0
               zBRUT22 := 0
               zBRUT12 := 0
               zNETTO := 0
               zExPORT := 'N'
               zUE := 'N'
               zKRAJ := 'PL'
               zSEK_CV7 := '  '
               zRACH := 'F'
               zDETAL := DETALISTA
               zKOREKTA := 'N'
               zROZRZAPS := pzROZRZAPS
               zZAP_TER := 0
               zZAP_DAT := date()
*                 zZAP_DAT=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')
               zZAP_WART := 0
               zTROJSTR := 'N'
               zKOL36 := 0
               zKOL37 := 0
               zKOL38 := 0
               zKOL39 := 0
               zNETTO2 := 0
               zKOLUMNA2 := '  '
               zDATATRAN := CToD( zROKS + '.' + zMCS + '.' + zDZIENS )
               ***********************
            ELSE
               lRyczModSys := .F.
               IF zRYCZALT == 'T'
                  IF Left( LTrim( numer ), 2 ) == 'F-'
                     lRyczModSys := .T.
                  ELSE
                     IF DocSys()
                        BREAK
                     ENDIF
                  ENDIF
               ELSE
                  IF DocSys()
                     BREAK
                  ENDIF
               ENDIF
               zDZIEN := DZIEN
               zSYMB_REJ := SYMB_REJ
               zNAZWA := NAZWA
               zNR_IDENT := NR_IDENT
               zNUMER := NUMER
               zADRES := ADRES
               zTRESC := TRESC
               zROKS := ROKS
               zMCS := MCS
               zDZIENS := DZIENS
               zDATAS := CToD( zROKS + '.' + zMCS + '.' + zDZIENS )
               IF zRYCZALT == 'T'
                  zKOLUMNA := KOLUMNA
               ELSE
                  zKOLUMNA := AllTrim( KOLUMNA )
               ENDIF
               zUWAGI := UWAGI
*                 zZAPLATA=ZAPLATA
*                 zKWOTA=KWOTA
               zWARTZW := WARTZW
               zWART08 := WART08
               zWART00 := WART00
               zWART02 := WART02
               zVAT02 := VAT02
               zWART07 := WART07
               zVAT07 := VAT07
               zWART22 := WART22
               zVAT22 := VAT22
               zWART12 := WART12
               zVAT12 := VAT12
               zBRUTZW := WARTZW
               zBRUT08 := WART08
               zBRUT00 := WART00
               zBRUT02 := VAT02 + WART02
               zBRUT07 := VAT07 + WART07
               zBRUT22 := VAT22 + WART22
               zBRUT12 := VAT12 + WART12
               zNETTO := NETTO
               zExPORT := iif( EXPORT == ' ', 'N', EXPORT )
               zUE := iif( UE == ' ', 'N', UE )
               zKRAJ := iif( KRAJ == '  ', 'PL', KRAJ )
               zSEK_CV7 := SEK_CV7
               zRACH := RACH
               zKOREKTA := KOREKTA
               zDETAL := DETAL
               zROZRZAPS := ROZRZAPS
               zZAP_TER := ZAP_TER
               zZAP_DAT := ZAP_DAT
               zZAP_WART := ZAP_WART
               zTROJSTR := iif( TROJSTR == ' ', 'N', TROJSTR )
               zKOL36 := KOL36
               zKOL37 := KOL37
               zKOL38 := KOL38
               zKOL39 := KOL39
               zNETTO2 := NETTO2
               zKOLUMNA2 := KOLUMNA2
               zDATATRAN := DATATRAN
            ENDIF
            stan_ := -zNETTO - zNETTO2
            netprzed := zNETTO
            netprzed2 := zNETTO2
            zRACH := 'F'
            *ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ

            sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.01' ) )
            @ 12, 8 SAY Str( vat_A, 2 )
            @ 13, 8 SAY Str( vat_B, 2 )
            @ 14, 8 SAY Str( vat_C, 2 )
            @ 15, 8 SAY Str( vat_D, 2 )

            scr_kolumC := .f.

            ColStd()
            IF ! lRyczModSys
               @  3, 20 GET zDZIEN    PICTURE "99" WHEN WERSJA4 == .T. .OR. ins VALID v1_1s()
               @  3, 38 GET zSYMB_REJ PICTURE "!!" VALID v11_1s()
               @  3, 59 GET zNUMER    PICTURE "@S20 " + repl( '!', 40 ) VALID v1_2s()
               @  4, 29 SAY Space( 40 )
               @  4, 29 GET zNR_IDENT PICTURE "@S20 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid vv1_3s()
               @  5, 29 GET znazwa    PICTURE "@S40 " + repl( '!', 100 ) VALID w1_3s() .AND. v1_3s()
               @  6, 29 GET zADRES    PICTURE "@S40 " + repl( '!', 100 ) VALID v1_4s()
               @  7, 29 GET zTRESC    VALID v1_5s()
               @  8, 29 GET zUWAGI    VALID v1_21s()
               @  9, 11 GET zDATAS    PICTURE '@D' WHEN w1_6s() VALID v1_6s()
               @  9, 32 GET zDATATRAN PICTURE '@D' WHEN w1_7s()
               @  9, 53 GET zKOREKTA  PICTURE '!' VALID zKOREKTA $ 'TN' .AND. v1_8s()
               @  4, 77 GET zexport   PICTURE '!' WHEN wfEXIM( 4, 78 ) VALID vfEXIM( 4, 78 )
               @  5, 77 GET zUE       PICTURE '!' WHEN wfUE( 5, 78 ) VALID vfUE( 5, 78 )
               @  6, 77 GET zKRAJ     PICTURE '!!'
               @  8, 77 GET zTROJSTR  PICTURE '!' WHEN zUE == 'T' VALID Valid_RejS_Trojstr()
               @  9, 77 GET zSEK_CV7  PICTURE '!!' WHEN wfsSEK_CV7( 9, 78 ) VALID vfsSEK_CV7( 9, 78 )
               IF DETALISTA <> 'T'
                  @ 12, 14 GET zWART22 PICTURE FPIC VALID SUMPODs()
                  @ 12, 31 GET zVAT22  PICTURE FPIC WHEN SUMPOws( 'zvat22' ) VALID SUMPODs()
                  @ 13, 14 GET zWART07 PICTURE FPIC VALID SUMPODs()
                  @ 13, 31 GET zVAT07  PICTURE FPIC WHEN SUMPOws( 'zvat07' ) VALID SUMPODs()
                  @ 14, 14 GET zWART02 PICTURE FPIC VALID SUMPODs()
                  @ 14, 31 GET zVAT02  PICTURE FPIC WHEN SUMPOws( 'zvat02' ) VALID SUMPODs()
                  @ 15, 14 GET zWART12 PICTURE FPIC VALID SUMPODs()
                  @ 15, 31 GET zVAT12  PICTURE FPIC WHEN SUMPOws( 'zvat12' ) VALID SUMPODs()
                  @ 16, 14 GET zWART00 PICTURE FPIC VALID SUMPODs()
                  @ 17, 14 GET zWARTZW PICTURE FPIC VALID SUMPODs()
                  @ 18, 14 GET zWART08 PICTURE FPIC VALID SUMPODs()
               ELSE
                  @ 12, 48 GET zBRUT22 PICTURE FPIC VALID SUMPODd()
                  @ 12, 31 GET zVAT22  PICTURE FPIC WHEN SUMPOwd( 'zvat22' ) VALID SUMPODd()
                  @ 13, 48 GET zBRUT07 PICTURE FPIC VALID SUMPODd()
                  @ 13, 31 GET zVAT07  PICTURE FPIC WHEN SUMPOwd( 'zvat07' ) VALID SUMPODd()
                  @ 14, 48 GET zBRUT02 PICTURE FPIC VALID SUMPODd()
                  @ 14, 31 GET zVAT02  PICTURE FPIC WHEN SUMPOwd( 'zvat02' ) VALID SUMPODd()
                  @ 15, 48 GET zBRUT12 PICTURE FPIC VALID SUMPODd()
                  @ 15, 31 GET zVAT12  PICTURE FPIC WHEN SUMPOwd( 'zvat12' ) VALID SUMPODd()
                  @ 16, 48 GET zBRUT00 PICTURE FPIC VALID SUMPODd()
                  @ 17, 48 GET zBRUTZW PICTURE FPIC VALID SUMPODd()
                  @ 18, 48 GET zBRUT08 PICTURE FPIC VALID SUMPODd()
               ENDIF

            ENDIF
            @ 21, 14 GET zNETTO PICTURE FPIC WHEN SUMNETs( lRyczModSys ) VALID vSUMNETs()
            IF zRYCZALT == 'T'
               @ 21, 41 GET zKOLUMNA PICTURE '@K 99' WHEN KRejSWZKolumna( .T. ) VALID KRejSVZKolumna( .T. )
            ELSE
               @ 21, 41 SAY ' '
               @ 21, 42 GET zKOLUMNA PICTURE '9' WHEN KRejSWZKolumna( .F. ) VALID KRejSVZKolumna( .T. )
            ENDIF
            @ 21, 51 GET zNETTO2 PICTURE FPIC WHEN KRejSWZNetto2()
            IF zRYCZALT == 'T'
               @ 21, 77 GET zKOLUMNA2 PICTURE '@K 99' WHEN KRejSWZKolumna2( .T. ) VALID KRejSVZKolumna2( .T. )
            ELSE
               @ 21, 77 SAY ' '
               @ 21, 78 GET zKOLUMNA2 PICTURE '9' WHEN KRejSWZKolumna2( .F. ) VALID  KRejSVZKolumna2( .F. )
            ENDIF
//            IF ! lRyczModSys
               @ 22, 16 GET zROZRZAPS PICTURE '!' WHEN wROZRget() VALID vROZRget( 'zROZRZAPS', 22, 16 )
               @ 22, 36 GET zZAP_TER PICTURE '999' WHEN zROZRZAPS == 'T'
               @ 22, 41 GET zZAP_DAT PICTURE '@D' WHEN zROZRZAPS == 'T' .AND. wZAP_DAT() VALID vZAP_DAT()
               @ 22, 67 GET zZAP_WART PICTURE FPIC WHEN zROZRZAPS == 'T' VALID zZAP_WART >= 0.0 .AND. zZAP_WART <= Abs( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWART08 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 )
//            ENDIF
            SET COLOR TO
            CLEAR TYPEAHEAD
            SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_RejE
            read_()
            SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_DlgK
            IF scr_kolumC := .T.
               RestScreen( 2, 40, 8, 79, scr_sekcv7 )
            ENDIF
            IF LastKey() == K_ESC
               BREAK
            ENDIF
*              if .not.zaplacono()
*                 break
*              endif

            KRejS_Ksieguj()

         END
         IF &_top_bot
            EXIT
         ELSE
            DO &_proc
         ENDIF
         ColStd()
   *       @  3,4 clear to 10,4
         @ 23, 0
         @ 24, 0

      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == Asc( '.' ) .OR. kl == K_ALT_DEL
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                   ‏' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColSta()
         BEGIN SEQUENCE
            *-------zamek-------
            IF suma_mc->zamek
               kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
               BREAK
            ENDIF
            *-------------------
            IF kl <> K_ALT_DEL .AND. ( Left( numer, 2 ) == 'S-' .OR. Left( numer, 2 ) == 'R-' .OR. Left( numer, 2 ) == 'F-' .OR. Left( numer , 3 ) == 'KF-' .OR. Left( numer, 3 ) == 'KR-' )
               kom( 4, '*u', ' Symbole S-,F-,R-,KF- i KR- mo&_z.na wykasowa&_c. tylko w opcji FAKTUROWANIE ' )
               BREAK
            ENDIF
            IF ! TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
               BREAK
            ENDIF
            REKZAK := RecNo()
            tresc_ := tresc
            stan_ := -NETTO
            Numer_Kas := numer
            Dzien_Kas := dzien
            SELECT tresc
            SEEK '+' + ident_fir + tresc_
            IF Found()
               BlokadaR()
               repl_( 'stan', stan - stan_ )
               UNLOCK
            ENDIF
            SELECT suma_mc
            BlokadaR()
            IF Left( rejs->numer, 1 ) # Chr( 1 ) .AND. Left( rejs->numer, 1 ) # Chr( 254 )
               IF zRYCZALT == 'T'
                  DO CASE
                  CASE AllTrim( rejs->KOLUMNA ) == '5'
                     repl_( 'ry20', ry20 - rejs->netto )
                  CASE AllTrim( rejs->KOLUMNA ) == '6'
                     repl_( 'ry17', ry17 - rejs->netto )
                  CASE AllTrim( rejs->KOLUMNA ) == '7'
                     repl_( 'uslugi', uslugi - rejs->netto )
                  CASE AllTrim( rejs->KOLUMNA ) == '8'
                     repl_( 'wyr_tow', wyr_tow - rejs->netto )
                  CASE AllTrim( rejs->KOLUMNA ) == '9'
                     repl_( 'handel', handel - rejs->netto )
                  CASE AllTrim( rejs->KOLUMNA ) == '11'
                     repl_( 'ry10', ry10 - rejs->netto )
                  ENDCASE
                  DO CASE
                  CASE AllTrim( rejs->KOLUMNA2 ) == '5'
                     repl_( 'ry20', ry20 - rejs->netto2 )
                  CASE AllTrim( rejs->KOLUMNA2 ) == '6'
                     repl_( 'ry17', ry17 - rejs->netto2 )
                  CASE AllTrim( rejs->KOLUMNA2 ) == '7'
                     repl_( 'uslugi', uslugi - rejs->netto2 )
                  CASE AllTrim( rejs->KOLUMNA2 ) == '8'
                     repl_( 'wyr_tow', wyr_tow - rejs->netto2 )
                  CASE AllTrim( rejs->KOLUMNA2 ) == '9'
                     repl_( 'handel', handel - rejs->netto2 )
                  CASE AllTrim( rejs->KOLUMNA2 ) == '11'
                     repl_( 'ry10', ry10 - rejs->netto2 )
                  ENDCASE
                  IF stan_ <> 0 .AND. ( AllTrim( rejs->KOLUMNA ) $ '56789' .OR. AllTrim( rejs->KOLUMNA ) == '11' )
                     repl_( 'pozycje', pozycje - 1 )
                  ENDIF
               ELSE
                  DO CASE
                  CASE Str( Val( rejs->KOLUMNA ), 1 ) $ '7'
                     repl_( 'wyr_tow', wyr_tow - rejs->netto )
                  CASE Str( val( rejs-> KOLUMNA ), 1 ) $ '8'
                     repl_( 'uslugi', uslugi - rejs->netto )
                  ENDCASE
                  DO CASE
                  CASE Str( Val( rejs->KOLUMNA2 ), 1 ) $ '7'
                     repl_( 'wyr_tow', wyr_tow - rejs->netto2 )
                  CASE Str( val( rejs-> KOLUMNA2 ), 1 ) $ '8'
                     repl_( 'uslugi', uslugi - rejs->netto2 )
                  ENDCASE
               ENDIF
            ENDIF
            UNLOCK

            ************* ZAPIS REJESTRU DO KSIEGI *******************
            SELECT 5
            IF zRYCZALT == 'T'
               usebaz := 'EWID'
            ELSE
               usebaz := 'OPER'
            ENDIF
            DO WHILE ! Dostep( usebaz )
            ENDDO
            SetInd( usebaz )
            IF zRYCZALT == 'T'
               SET ORDER TO 5
               SEEK '+' + Str( REKZAK, 5 ) + 'RS-'
               IF Found()
                  BlokadaR()
                  DELETE
                  COMMIT
                  UNLOCK
                  SET ORDER TO 1
                  *********************** lp
                  IF nr_uzytk >= 0
                     IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        Blokada()
                        Czekaj()
                        rec := RecNo()
                        DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                           repl_( 'lp', lp - 1 )
                           SKIP
                        ENDDO
                        GO rec
                        UNLOCK
                        @ 24, 0
                     ENDIF
                  ENDIF
                  *******************************
               ENDIF
            ELSE
               SET ORDER TO 3
               IF ( Str( Val( rejs->KOLUMNA ), 1 ) == '7' ) .OR. ( Str( Val( rejs->KOLUMNA2 ), 1 ) == '7' )
                  GO TOP
                  SEEK '+' + ident_fir + miesiac + 'RS-7'
                  IF Found()
                     SET ORDER TO 1
                     BlokadaR()
                     repl_( 'wyr_tow', wyr_tow - iif( Str( Val( rejs->KOLUMNA ), 1 ) == '7', rejs->netto, rejs->netto2 ) )
                     UNLOCK
                  ELSE
                     SET ORDER TO 1
                     *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
                     SELECT suma_mc
                     BlokadaR()
                     repl_( 'pozycje', pozycje + 1 )
                     UNLOCK
                     SELECT &usebaz
                     app()
                     ADDDOC
                     repl_( 'DZIEN', DAYM )
                     repl_( 'NUMER', 'RS-7' )
                     repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
                     repl_( 'WYR_TOW', -( iif( Str( Val( rejs->KOLUMNA ), 1 ) == '7', rejs->netto, rejs->netto2 ) ) )
                     repl_( 'zaplata', '1' )
*                      repl_([kwota],zkwota)
                     UNLOCK
                     *********************** lp
                     IF nr_uzytk >= 0
                        IF param_lp == 'T'
                           Blokada()
                           Czekaj()
                           rec := RecNo()

                           SKIP -1
                           IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                              zlp := liczba
                           ELSE
                              zlp := lp + 1
                           ENDIF
                           GO rec
                           DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                              repl_( 'lp', zlp )
                              zlp := zlp + 1
                              SKIP
                           ENDDO

                           GO rec
                           UNLOCK
                           @ 24, 0
                        ENDIF
                     ENDIF
                     UNLOCK
                     ***********************
                  ENDIF
               ENDIF
               IF ( Str( Val( rejs->KOLUMNA ), 1 ) == '8' ) .OR. ( Str( Val( rejs->KOLUMNA2 ), 1 ) == '8' )
                  SET ORDER TO 3
                  GO TOP
                  SEEK '+' + ident_fir + miesiac + 'RS-8'
                  IF Found()
                     SET ORDER TO 1
                     BlokadaR()
                     repl_( 'uslugi', uslugi - iif( Str( Val( rejs->KOLUMNA ), 1 ) == '8', rejs->netto, rejs->netto2 ) )
                     UNLOCK
                  ELSE
                     SET ORDER TO 1
                     *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
                     SELECT suma_mc
                     BlokadaR()
                     repl_( 'pozycje', pozycje + 1 )
                     UNLOCK
                     SELECT &usebaz
                     app()
                     ADDDOC
                     repl_( 'DZIEN', DAYM )
                     repl_( 'NUMER', 'RS-8' )
                     repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
                     repl_( 'USLUGI', -( iif( Str( Val( rejs->KOLUMNA ), 1 ) == '8', rejs->netto, rejs->netto2 ) ) )
                     repl_( 'zaplata', '1' )
*                      repl_([kwota],zkwota)
                     UNLOCK
                     *********************** lp
                     IF nr_uzytk >= 0
                        IF param_lp == 'T'
                           Blokada()
                           Czekaj()
                           rec := RecNo()

                           SKIP -1
                           IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                              zlp := liczba
                           ELSE
                              zlp :=lp + 1
                           ENDIF
                           GO rec
                           DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                              repl_( 'lp', zlp )
                              zlp := zlp + 1
                              SKIP
                           ENDDO

                           GO rec
                           UNLOCK
                           @ 24, 0
                        ENDIF
                     ENDIF
                     UNLOCK
                     ***********************
                  ENDIF
               ENDIF
            ENDIF
            ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
            SELECT rejs
            rrrec := RecNo()
            BlokadaR()
            repl_( 'del', '-' )
            commit_()
            UNLOCK

            SELECT 5
            DO WHILE ! Dostep( 'ROZR' )
            ENDDO
            SetInd( 'ROZR' )

            SELECT rozr
            RozrDel( 'S', rrrec )
            SELECT rejs

            IF &_bot
               SEEK '+' + ident_fir + miesiac + Dzien_Kas + Numer_Kas
/*               DO WHILE del == '-' .AND. ! &_top .AND. ! &_bot
                  SKIP -1
               ENDDO */
            ENDIF
            IF ! &_bot
               DO &_proc
            ELSE
               krejsRysujTlo()
            ENDIF
         END
         ColStd()
         @ 23, 0
         @ 24, 0

      *################################ KASOWANIE WSZYSTKICH POZ ##################
      CASE kl == K_CTRL_DEL
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                   ‏' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColSta()
         BEGIN SEQUENCE
            *-------zamek-------
            IF suma_mc->zamek
               kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
               BREAK
            ENDIF
            *-------------------
            IF ! TNEsc( '*i', '   Czy skasowa&_c. wszystkie pozycje w miesi¥cu? (T/N)   ' )
               BREAK
            ENDIF
            IF ! TNEsc( '*i', '   Czy na pewno skasowa&_c. wszystkie pozycje w miesi¥cu? (T/N)   ' )
               BREAK
            ENDIF

            ColInf()
            center( 24, PadC( 'Kasowanie. Prosz© czeka†.' ) )
            ColSta()

            SEEK _stop

            DO WHILE ! &_bot

               IF Left( numer, 2 ) == 'S-' .OR. Left( numer, 2 ) == 'R-' .OR. Left( numer, 2 ) == 'F-' .OR. Left( numer , 3 ) == 'KF-' .OR. Left( numer, 3 ) == 'KR-'
                  //kom( 4, '*u', ' Symbole S-,F-,R-,KF- i KR- mo&_z.na wykasowa&_c. tylko w opcji FAKTUROWANIE ' )
                  //BREAK
                  SKIP
                  LOOP
               ENDIF

               REKZAK := RecNo()
               tresc_ := tresc
               stan_ := -NETTO - NETTO2
               Numer_Kas := numer
               Dzien_Kas := dzien
               SELECT tresc
               SEEK '+' + ident_fir + tresc_
               IF Found()
                  BlokadaR()
                  repl_( 'stan', stan - stan_ )
                  UNLOCK
               ENDIF
               SELECT suma_mc
               BlokadaR()
               IF Left( rejs->numer, 1 ) # Chr( 1 ) .AND. Left( rejs->numer, 1 ) # Chr( 254 )
                  IF zRYCZALT == 'T'
                     DO CASE
                     CASE AllTrim( rejs->KOLUMNA ) == '5'
                        repl_( 'ry20', ry20 - rejs->netto )
                     CASE AllTrim( rejs->KOLUMNA ) == '6'
                        repl_( 'ry17', ry17 - rejs->netto )
                     CASE AllTrim( rejs->KOLUMNA ) == '7'
                        repl_( 'uslugi', uslugi - rejs->netto )
                     CASE AllTrim( rejs->KOLUMNA ) == '8'
                        repl_( 'wyr_tow', wyr_tow - rejs->netto )
                     CASE AllTrim( rejs->KOLUMNA ) == '9'
                        repl_( 'handel', handel - rejs->netto )
                     CASE AllTrim( rejs->KOLUMNA ) == '11'
                        repl_( 'ry10', ry10 - rejs->netto )
                     ENDCASE
                     DO CASE
                     CASE AllTrim( rejs->KOLUMNA2 ) == '5'
                        repl_( 'ry20', ry20 - rejs->netto2 )
                     CASE AllTrim( rejs->KOLUMNA2 ) == '6'
                        repl_( 'ry17', ry17 - rejs->netto2 )
                     CASE AllTrim( rejs->KOLUMNA2 ) == '7'
                        repl_( 'uslugi', uslugi - rejs->netto2 )
                     CASE AllTrim( rejs->KOLUMNA2 ) == '8'
                        repl_( 'wyr_tow', wyr_tow - rejs->netto2 )
                     CASE AllTrim( rejs->KOLUMNA2 ) == '9'
                        repl_( 'handel', handel - rejs->netto2 )
                     CASE AllTrim( rejs->KOLUMNA2 ) == '11'
                        repl_( 'ry10', ry10 - rejs->netto2 )
                     ENDCASE
                     IF stan_ <> 0 .AND. ( AllTrim( rejs->KOLUMNA ) $ '56789' .OR. AllTrim( rejs->KOLUMNA ) == '11' )
                        repl_( 'pozycje', pozycje - 1 )
                     ENDIF
                  ELSE
                     DO CASE
                     CASE Str( Val( rejs->KOLUMNA ), 1 ) $ '7'
                        repl_( 'wyr_tow', wyr_tow - rejs->netto )
                     CASE Str( val( rejs-> KOLUMNA ), 1 ) $ '8'
                        repl_( 'uslugi', uslugi - rejs->netto )
                     ENDCASE
                     DO CASE
                     CASE Str( Val( rejs->KOLUMNA2 ), 1 ) $ '7'
                        repl_( 'wyr_tow', wyr_tow - rejs->netto2 )
                     CASE Str( val( rejs-> KOLUMNA2 ), 1 ) $ '8'
                        repl_( 'uslugi', uslugi - rejs->netto2 )
                     ENDCASE
                  ENDIF
               ENDIF
               UNLOCK

               ************* ZAPIS REJESTRU DO KSIEGI *******************
               SELECT 5
               IF zRYCZALT == 'T'
                  usebaz := 'EWID'
               ELSE
                  usebaz := 'OPER'
               ENDIF
               DO WHILE ! Dostep( usebaz )
               ENDDO
               SetInd( usebaz )
               IF zRYCZALT == 'T'
                  SET ORDER TO 5
                  SEEK '+' + Str( REKZAK, 5 ) + 'RS-'
                  IF Found()
                     BlokadaR()
                     DELETE
                     COMMIT
                     UNLOCK
                     SET ORDER TO 1
                     *********************** lp
                     IF nr_uzytk >= 0
                        IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                           Blokada()
                           Czekaj()
                           rec := RecNo()
                           DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                              repl_( 'lp', lp - 1 )
                              SKIP
                           ENDDO
                           GO rec
                           UNLOCK
                           @ 24, 0
                        ENDIF
                     ENDIF
                     *******************************
                  ENDIF
               ELSE
                  SET ORDER TO 3
                  IF ( Str( Val( rejs->KOLUMNA ), 1 ) == '7' ) .OR. ( Str( Val( rejs->KOLUMNA2 ), 1 ) == '7' )
                     GO TOP
                     SEEK '+' + ident_fir + miesiac + 'RS-7'
                     IF Found()
                        SET ORDER TO 1
                        BlokadaR()
                        repl_( 'wyr_tow', wyr_tow - iif( Str( Val( rejs->KOLUMNA ), 1 ) == '7', rejs->netto, rejs->netto2 ) )
                        UNLOCK
                     ELSE
                        SET ORDER TO 1
                        *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
                        SELECT suma_mc
                        BlokadaR()
                        repl_( 'pozycje', pozycje + 1 )
                        UNLOCK
                        SELECT &usebaz
                        app()
                        ADDDOC
                        repl_( 'DZIEN', DAYM )
                        repl_( 'NUMER', 'RS-7' )
                        repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
                        repl_( 'WYR_TOW', -( iif( Str( Val( rejs->KOLUMNA ), 1 ) == '7', rejs->netto, rejs->netto2 ) ) )
                        repl_( 'zaplata', '1' )
   *                      repl_([kwota],zkwota)
                        UNLOCK
                        *********************** lp
                        IF nr_uzytk >= 0
                           IF param_lp == 'T'
                              Blokada()
                              Czekaj()
                              rec := RecNo()

                              SKIP -1
                              IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                                 zlp := liczba
                              ELSE
                                 zlp := lp + 1
                              ENDIF
                              GO rec
                              DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                                 repl_( 'lp', zlp )
                                 zlp := zlp + 1
                                 SKIP
                              ENDDO

                              GO rec
                              UNLOCK
                              @ 24, 0
                           ENDIF
                        ENDIF
                        UNLOCK
                        ***********************
                     ENDIF
                  ENDIF
                  IF ( Str( Val( rejs->KOLUMNA ), 1 ) == '8' ) .OR. ( Str( Val( rejs->KOLUMNA2 ), 1 ) == '8' )
                     SET ORDER TO 3
                     GO TOP
                     SEEK '+' + ident_fir + miesiac + 'RS-8'
                     IF Found()
                        SET ORDER TO 1
                        BlokadaR()
                        repl_( 'uslugi', uslugi - iif( Str( Val( rejs->KOLUMNA ), 1 ) == '8', rejs->netto, rejs->netto2 ) )
                        UNLOCK
                     ELSE
                        SET ORDER TO 1
                        *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
                        SELECT suma_mc
                        BlokadaR()
                        repl_( 'pozycje', pozycje + 1 )
                        UNLOCK
                        SELECT &usebaz
                        app()
                        ADDDOC
                        repl_( 'DZIEN', DAYM )
                        repl_( 'NUMER', 'RS-8' )
                        repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
                        repl_( 'USLUGI', -( iif( Str( Val( rejs->KOLUMNA ), 1 ) == '8', rejs->netto, rejs->netto2 ) ) )
                        repl_( 'zaplata', '1' )
   *                      repl_([kwota],zkwota)
                        UNLOCK
                        *********************** lp
                        IF nr_uzytk >= 0
                           IF param_lp == 'T'
                              Blokada()
                              Czekaj()
                              rec := RecNo()

                              SKIP -1
                              IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                                 zlp := liczba
                              ELSE
                                 zlp :=lp + 1
                              ENDIF
                              GO rec
                              DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                                 repl_( 'lp', zlp )
                                 zlp := zlp + 1
                                 SKIP
                              ENDDO

                              GO rec
                              UNLOCK
                              @ 24, 0
                           ENDIF
                        ENDIF
                        UNLOCK
                        ***********************
                     ENDIF
                  ENDIF
               ENDIF
               ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
               SELECT rejs
               rrrec := RecNo()
               BlokadaR()
               repl_( 'del', '-' )
               commit_()
               UNLOCK

               SELECT 5
               DO WHILE ! Dostep( 'ROZR' )
               ENDDO
               SetInd( 'ROZR' )

               SELECT rozr
               RozrDel( 'S', rrrec )
               SELECT rejs

               SEEK _stop
            ENDDO

            center( 24, Space( 80 ) )

            IF &_bot
               SEEK '+' + ident_fir + miesiac + Dzien_Kas + Numer_Kas
/*               DO WHILE del == '-' .AND. ! &_top .AND. ! &_bot
                  SKIP -1
               ENDDO */
            ENDIF
            IF ! &_bot
               DO &_proc
            ELSE
               krejsRysujTlo()
            ENDIF
         END
         ColStd()
         @ 23, 0
         @ 24, 0

      *################################# SZUKANIE DNIA ############################
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                 ‏' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         f10 := '  '
         @ 3, 20 GET f10 PICTURE "99"
         Read_()
         IF ! Empty( f10 ) .AND. LastKey() # K_ESC
            SEEK '+' + ident_fir + miesiac + Str( Val( f10 ), 2 )
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         DO &_proc
         @ 23, 0

      *################################# SZUKANIE ZLOZONE #########################
      CASE kl == K_F9
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                 ‏' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         zDZIEN := '  '
         zNUMER := Space( 40 )
         zNAZWA := Space( 100 )
         zZDARZ := Space( 20 )
         DECLARE pp[ 4 ]
         *---------------------------------------
         pp[ 1 ] := '      Dzie&_n.:                     '
         pp[ 2 ] := '  Nr dowodu:                     '
         pp[ 3 ] := ' Kontrahent:                     '
         pp[ 4 ] := '  Zdarzenie:                     '
         *---------------------------------------
         SET COLOR TO N/W,W+/W,,,N/W
         i := 4
         j := 22
         DO WHILE i > 0
            IF Type( 'pp[i]' ) # 'U'
               Center( j, pp[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET CURSOR ON
         ColStd()
         @ 19, 35 GET zDZIEN PICTURE '99' VALID zDZIEN == '  ' .OR. ( Val( zDZIEN ) >= 1 .AND. Val( zDZIEN ) <= 31 )
         @ 20, 35 GET zNUMER PICTURE '@S20 ' + repl( '!', 40 )
         @ 21, 35 GET zNAZWA PICTURE '@S20 ' + repl( '!', 100 )
         @ 22, 35 GET zZDARZ PICTURE Replicate( '!', 20 )
         READ
         SET COLOR TO
         SET CURSOR OFF
         REC := RecNo()
         IF Lastkey() # K_ESC .AND. LastKey() # K_F1
            GO TOP
            SZUK := "del='+'.and.firma=ident_fir.and.mc=miesiac"
            SEEK '+' + ident_fir + miesiac
            IF zDZIEN <> '  '
               AA := Str( Val( zDZIEN ), 2 )
               SZUK := SZUK + '.and.DZIEN=AA'
            ENDIF
            IF zNUMER <> Space( 40 )
               aNUMER := AllTrim( zNUMER )
               SZUK := SZUK + '.and.aNUMER$upper(NUMER)'
            ENDIF
            IF zNAZWA <> Space( 100 )
               aNAZWA := AllTrim( zNAZWA )
               SZUK := SZUK + '.and.aNAZWA$upper(NAZWA)'
            ENDIF
            IF zZDARZ <> Space( 20 )
               aZDARZ := AllTrim( zZDARZ )
               SZUK := SZUK + '.and.aZDARZ$upper(TRESC)'
            ENDIF
            IF SZUK <> "del='+'.and.firma=ident_fir.and.mc=miesiac"
               DO WHILE ! Eof() .AND. del == '+' .AND. firma == ident_fir .AND. mc == miesiac
                  IF &SZUK
                     REC := RecNo()
                     SC1 := SaveScreen( 18, 23, 22, 57 )
                     RESTORE SCREEN FROM scr_
                     DO &_proc
                     SAVE SCREEN TO scr_
                     RestScreen( 18, 23, 22, 57, SC1 )
                     @ 23, 0
                     WSZUK := 1
                     ColStd()
                     @ 24, 18 PROMPT '[ Dalsze szukanie ]'
                     @ 24, 42 PROMPT '[ Koniec szukania ]'
                     MENU TO WSZUK
                     IF WSZUK == 2
                        RESTORE SCREEN FROM scr_
                        EXIT
                     ENDIF
                  ENDIF
                  SKIP 1
               ENDDO
               kom( 3, '*u', ' KONIEC SZUKANIA ' )
            ENDIF
         ENDIF
         RESTORE SCREEN FROM scr_
         GO REC
         DO &_proc
         _disp := .F.

      case kl == K_F1
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE pppp[ 11 ]
         *---------------------------------------
         pppp[  1 ] := '                                                        '
         pppp[  2 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         pppp[  3 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         pppp[  4 ] := '   [Ins]...................wpisywanie                   '
         pppp[  5 ] := '   [M].....................modyfikacja pozycji          '
         pppp[  6 ] := '   [I].....................import z pliku JPK VAT       '
         pppp[  7 ] := '   [Del]...................kasowanie pozycji            '
         pppp[  8 ] := '   [F9 ]...................szukanie z&_l.o&_z.one             '
         pppp[  9 ] := '   [F10]...................szukanie dnia                '
         pppp[ 10 ] := '   [Esc]...................wyj&_s.cie                      '
         pppp[ 11 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO I
         i := 11
         j := 22
         DO WHILE i > 0
            IF Type( 'pppp[i]' ) # 'U'
               Center( j, pppp[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         pause( 0 )
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.

      CASE kl == K_ALT_F8
         VAT_Sprzwdz_NIP_Rej()
      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()
   SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_DlgK
   RETURN

*################################## FUNKCJE #################################
PROCEDURE say1s()
***********************
   KRejSRysujTlo()
   CLEAR TYPE
   SELECT rejs
   SET COLOR TO +w
   @  3, 20 SAY DZIEN
   @  3, 38 SAY SYMB_REJ
   @  3, 59 SAY iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2, 20 ) + ' ', SubStr( numer, 1, 20 ) )
   @  4, 29 SAY Space( 40 )
   @  4, 29 SAY SubStr( nr_ident, 1, 20 )
   *if left(numer,1)=chr(1).or.left(numer,1)=chr(254)
   *   @ 4,50 say space(20)
   *else
   *   do case
   *   case zaplata=[1]
   *        @ 4,50 say 'Zap&_l.. '+tran(Data_Zap,'@D')
   *   case zaplata=[2]
   *        @ 4,50 say 'Zap&_l.. '+str(kwota,10,2)
   *   case zaplata=[3]
   *        @ 4,50 say 'Niezap&_l.acono'
   *   endcase
   *endif
   @  5, 29 SAY SubStr( nazwa, 1, 40 )
   @  6, 29 SAY SubStr( ADRES, 1, 40 )
   @  7, 29 SAY TRESC
   @  8, 29 SAY uwagi
   @  9, 11 SAY ROKS + '.' + MCS + '.' + DZIENS
   @  9, 32 SAY DToC( DATATRAN )
   @  9, 53 SAY KOREKTA + iif( KOREKTA == 'T', 'ak', 'ie' )
   @  4, 77 SAY EXPORT + iif( EXPORT == 'T', 'ak', 'ie' )
   @  5, 77 SAY UE + iif( UE == 'T', 'ak', 'ie' )
   @  6, 77 SAY KRAJ
   @  8, 77 SAY iif( TROJSTR == 'T', 'Tak', 'Nie' )
   @  9, 77 SAY SEK_CV7

   sprawdzVAT( 10, CToD( ROKS + '.' + MCS + '.' + DZIENS ) )
   @ 12,  8 SAY Str( vat_A, 2 )
   @ 13,  8 SAY Str( vat_B, 2 )
   @ 14,  8 SAY Str( vat_C, 2 )

   @ 12, 14 SAY WART22         PICTURE RPIC
   @ 13, 14 SAY WART07         PICTURE RPIC
   @ 14, 14 SAY WART02         PICTURE RPIC
   @ 15, 14 SAY WART12         PICTURE RPIC
   @ 16, 14 SAY WART00         PICTURE RPIC
   @ 17, 14 SAY WARTZW         PICTURE RPIC
   @ 18, 14 SAY WART08         PICTURE RPIC
   @ 12, 31 SAY VAT22          PICTURE RPIC
   @ 13, 31 SAY VAT07          PICTURE RPIC
   @ 14, 31 SAY VAT02          PICTURE RPIC
   @ 15, 31 SAY VAT12          PICTURE RPIC
   @ 12, 48 SAY WART22 + VAT22 PICTURE RPIC
   @ 13, 48 SAY WART07 + VAT07 PICTURE RPIC
   @ 14, 48 SAY WART02 + VAT02 PICTURE RPIC
   @ 15, 48 SAY WART12 + VAT12 PICTURE RPIC
   @ 16, 48 SAY WART00         PICTURE RPIC
   @ 17, 48 SAY WARTZW         PICTURE RPIC
   @ 18, 48 SAY WART08         PICTURE RPIC
   @ 19, 14 SAY WART22 + WART12 + WART07 + WART02 + WART00 + WARTZW + WART08 PICTURE RPIC
   @ 19, 31 SAY VAT22 + VAT12 + VAT07 + VAT02 PICTURE RPIC
   @ 19, 48 SAY WART22 + WART12 + WART07 + WART02 + WART00 + WARTZW + WART08 + VAT22 + VAT12 + VAT07 + VAT02 PICTURE RPIC
   @ 21, 14 SAY NETTO PICTURE RPIC
   @ 21, 41 SAY KOLUMNA PICTURE '99'
   @ 21, 51 SAY NETTO2 PICTURE RPIC
   @ 21, 77 SAY KOLUMNA2 PICTURE '99'

   *@ 22, 0 say 'Kontrola zaplat....  .................. (..........) ..............             '
   @ 22, 16 SAY ROZRZAPS + iif( ROZRZAPS == 'T', 'ak', 'ie' )
   IF ROZRZAPS == 'T'
   *   @ 22, 0 say 'Kontrola zaplat....  Termin zaplaty.... (..........) Juz zaplacono.             '
      @ 22, 36 SAY ZAP_TER PICTURE '999'
      @ 22, 41 SAY ZAP_DAT PICTURE '@D'
      @ 22, 67 SAY ZAP_WART PICTURE FPIC
   ELSE
      SET COLOR TO
      @ 22, 36 SAY '...'
      @ 22, 41 SAY '..........'
      @ 22, 67 SAY Space( 13 )
   ENDIF

   IF SEK_CV7 == 'DP' .AND. ( KOL36 <> 0 .OR. KOL37 <> 0 .OR. KOL38 <> 0 .OR. KOL39 <> 0 )
      ColStd()
      @ 14, 40 CLEAR TO 20, 79
      @ 14, 40 TO 20, 79
      @ 15, 42 SAY "Kwota podatku nale¾nego"
      @ 16, 42 SAY "K.36 - spis z natury   "
      @ 17, 42 SAY "K.37 - zakup kas       "
      @ 18, 42 SAY "K.38 - nab.sr.transp.  "
      @ 19, 42 SAY "K.39 - nab.paliw siln. "
      SET COLOR TO +w
      @ 16, 64 SAY KOL36 PICTURE FPIC
      @ 17, 64 SAY KOL37 PICTURE FPIC
      @ 18, 64 SAY KOL38 PICTURE FPIC
      @ 19, 64 SAY KOL39 PICTURE FPIC
   ENDIF

   SET COLOR TO
   RETURN

***************************************************
FUNCTION v1_1s()

   IF zdzien == '  '
      zdzien := Str( Day( Date( ) ) , 2 )
      SET COLOR TO i
      @ 3, 20 SAY zDZIEN
      SET COLOR TO
   ENDIF
   IF Val( zdzien ) < 1 .OR. Val( zdzien ) > msc( Val( miesiac ) )
      zdzien := '  '
      RETURN .F.
   ENDIF

   sprawdzVAT( 10, CToD( param_rok + '.' + strtran( miesiac, ' ', '0' ) + '.' + zdzien ) )
   @ 12, 8 SAY Str( vat_A, 2 )
   @ 13, 8 SAY Str( vat_B, 2 )
   @ 14, 8 SAY Str( vat_C, 2 )
   @ 15, 8 SAY Str( vat_D, 2 )

   RETURN .T.

***************************************************
FUNCTION V11_1s()
***************************************************
   SAVE SCREEN TO scr2
   SELECT 7
   DO WHILE ! Dostep( 'KAT_SPR' )
   ENDDO
   SET INDEX TO KAT_SPR
   SEEK '+' + ident_fir + zSYMB_REJ
   IF del # '+' .OR. firma # ident_fir
      SKIP -1
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      Kat_Rej_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER
         zSYMB_REJ := SYMB_REJ
         SET COLOR TO i
         @ 3, 38 SAY zSYMB_REJ
         SET COLOR TO
      ENDIF
   ENDIF
   USE
   SELECT rejs
   RETURN .T.

***************************************************
FUNCTION V1_2s()
***************************************************
   /* IF ' ' $ AllTrim( znumer )
      RETURN .F.
   ENDIF */
   @ 24, 0
   DO CASE
   CASE AllTrim( znumer ) == 'REM-P'
      Center( 24, ' Symbol zastrze&_z.ony dla remanentu pocz&_a.tkowego ' )
      RETURN .F.
   CASE AllTrim( znumer ) == 'REM-K'
      Center( 24, ' Symbol zastrze&_z.ony dla remanentu ko&_n.cowego ' )
      RETURN .F.
   CASE AllTrim( znumer ) == 'RS-7'
      Center( 24, ' Symbol zastrze&_z.ony dla sumy z rejestru sprzeda&_z.y z kolumny 7 ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'RZ-' .OR. Left( LTrim( znumer ), 3 ) == 'RS-'
      Center( 24, ' Symbol zastrze&_z.ony dla dokument&_o.w z rejestr&_o.w ' )
      RETURN .F.
   CASE AllTrim( znumer ) == 'RS-8'
      Center( 24, ' Symbol zastrze&_z.ony dla sumy z rejestru sprzeda&_z.y z kolumny 8 ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 2 ) == 'S-'
      Kom( 4, '*u', ' Symbol dowodu (S-) jest zastrze&_z.ony dla faktur ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 2 ) == 'F-'
      Kom( 4, '*u', ' Symbol dowodu (F-) jest zastrze&_z.ony dla faktur VAT' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 2 ) == 'R-'
      Kom( 4, '*u', ' Symbol dowodu (R-) jest zastrze&_z.ony dla rachunk&_o.w uproszczonych ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'KF-'
      Kom( 4, '*u', ' Symbol dowodu (KF-) jest zastrze&_z.ony dla faktur VAT koryguj&_a.cych ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'KR-'
      Kom( 4, '*u', ' Symbol dowodu (KR-) jest zastrze&_z.ony dla rachunk&_o.w uproszcz.koryg. ' )
      RETURN .F.
   ENDCASE
   EwidSprawdzNrDok( 'REJS', ident_fir, miesiac, znumer )
   RETURN .T.

***************************************************
FUNCTION Vv1_3s()
***************************************************
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   IF Len( AllTrim( znr_ident ) ) # 0
      IF ins
         SELECT kontr
         SET ORDER TO 2
         SEEK '+' + ident_fir + znr_ident
         IF Found()
            znazwa := nazwa
            zadres := adres
            zExPORT := iif( EXPORT =='  ', 'N' , EXPORT )
            zUE := iif( UE == ' ', 'N', UE )
            zKRAJ := iif( KRAJ == '  ', 'PL', KRAJ )
            KEYBOARD Chr( K_ENTER )
         ELSE
            znazwa := Space( 100 )
            zadres := Space( 100 )
            zexport := 'N'
            zUE := 'N'
            ZKRAJ := 'PL'
            SET COLOR TO i
            @ 4, 29 SAY zNR_IDENT
            @ 5, 29 SAY SubStr( znazwa, 1, 40 )
            @ 6, 29 SAY SubStr( zadres, 1, 40 )
            @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
            @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
            @ 6, 77 SAY zKRAJ
            SET COLOR TO
         ENDIF
         SET ORDER TO 1
         SELECT rejs
      ELSE
         IF znr_ident # rejs->nr_ident
            SELECT kontr
            SET ORDER TO 2
            SEEK '+' + ident_fir + znr_ident
            IF Found()
               znazwa := nazwa
               zadres := adres
               zExPORT := iif( EXPORT == ' ', 'N', EXPORT )
               zUE := iif( UE == ' ', 'N', UE )
               zKRAJ := iif( KRAJ == '  ', 'PL', KRAJ )
               KEYBOARD Chr( K_ENTER )
            ELSE
               znazwa := Space( 100 )
               zadres := Space( 100 )
               zexport := 'N'
               zUE := 'N'
               ZKRAJ := 'PL'
               SET COLOR TO i
               @ 4, 29 SAY zNR_IDENT
               @ 5, 29 SAY SubStr( znazwa, 1, 40 )
               @ 6, 29 SAY SubStr( zadres, 1, 40 )
               @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
               @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
               @ 6, 77 SAY zKRAJ
               SET COLOR TO
            ENDIF
            SET ORDER TO 1
            SELECT rejs
         ENDIF
      ENDIF
   ENDIF
   RETURN .T.

***************************************************
FUNCTION w1_3s()
***************************************************
   SAVE SCREEN TO scr2
   IF Len( AllTrim( znr_ident ) ) # 0
      SELECT kontr
      SET ORDER TO 2
      SEEK '+' + ident_fir + znr_ident
      IF ! Found()
         SET ORDER TO 1
         SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 ) + SubStr( zadres, 1, 15 )
         IF del # '+' .OR. firma # ident_fir
            SKIP -1
         ENDIF
      ENDIF
      SET ORDER TO 1
   ELSE
      SELECT kontr
      SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 ) + SubStr( zadres, 1, 15 )
      IF del # '+' .OR. firma # ident_fir
         SKIP -1
      ENDIF
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      Kontr_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER
         znazwa := nazwa
         zadres := adres
         zNR_IDENT := NR_IDENT
         zExPORT := iif( EXPORT == ' ', 'N', EXPORT )
         zUE := iif( UE == ' ', 'N', UE )
         zKRAJ := iif( KRAJ == '  ', 'PL', KRAJ )
         SET COLOR TO i
         @ 4, 29 SAY zNR_IDENT
         @ 5, 29 SAY SubStr( znazwa, 1, 40 )
         @ 6, 29 SAY SubStr( zadres, 1, 40 )
         @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
         @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
         @ 6, 77 SAY zKRAJ
         SET COLOR TO
         KEYBOARD Chr( K_ENTER )
      ENDIF
   ENDIF
   SELECT rejs
   RETURN .T.

***************************************************
FUNCTION V1_3s() // ta funkcja nic nie robi
***************************************************
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v1_4s() // ta funkcja nic nie robi

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v1_5s()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   IF Empty( ztresc )
      SELECT tresc
      SEEK '+' + ident_fir
      IF ! Found()
         SELECT rejs
      ELSE
         SAVE SCREEN TO scr2
         Tresc_( "S" )
         RESTORE SCREEN FROM scr2
         SELECT rejs
         IF LastKey() == K_ESC
            RETURN .T.
         ENDIF
         ztresc := tresc->tresc
         SET COLOR TO i
         @ 7, 29 SAY ztresc
         SET COLOR TO
      ENDIF
   ENDIF
   RETURN .T.

***************************************************
FUNCTION V1_21s() // ta funkcja nic nie robi
***************************************************
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v1_6s()
***************************************************
   sprawdzVAT( 10, zDATAS )
   @ 12, 8 SAY Str( vat_A, 2 )
   @ 13, 8 SAY Str( vat_B, 2 )
   @ 14, 8 SAY Str( vat_C, 2 )
   @ 15, 8 SAY Str( vat_D, 2 )

   // to jest niepotrzebne
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION w1_6s()
***************************************************
   IF zDATAS == CToD( '    .  .  ' )
      zDATAS := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION w1_7s()
***************************************************
   IF zDATATRAN == CToD( '    .  .  ' )
      zDATATRAN := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
   ENDIF
   RETURN .T.

***************************************************
*function V1_7s
***************************************************
*@ 10,42 say iif(zRACH='F','aktura ','achunek')
*if lastkey()=5
*   return .t.
*endif
*return .t.
***************************************************
FUNCTION V1_8s()
***************************************************
   @ 9, 53 SAY iif( zKOREKTA == 'T', 'ak', 'ie' )

   // to jest niepotrzebne
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION V1_22s()
***************************************************
   RETURN ZKWOTA > 0

***************************************************
FUNCTION SUMPODs()
***************************************************
   @ 12, 48 SAY zWART22 + zVAT22 PICTURE RPIC
   @ 13, 48 SAY zWART07 + zVAT07 PICTURE RPIC
   @ 14, 48 SAY zWART02 + zVAT02 PICTURE RPIC
   @ 15, 48 SAY zWART12 + zVAT12 PICTURE RPIC
   @ 16, 48 SAY zWART00 PICTURE RPIC
   @ 17, 48 SAY zWARTZW PICTURE RPIC
   @ 18, 48 SAY zWART08 PICTURE RPIC
   @ 19, 14 SAY zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zWART08 PICTURE RPIC
   @ 19, 31 SAY zVAT22 + zVAT12 + zVAT07 + zVAT02 PICTURE RPIC
   @ 19, 48 SAY zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zWART08 + zVAT22 + zVAT12 + zVAT07 + zVAT02 PICTURE RPIC
   RETURN .T.

***************************************************
FUNCTION SUMPOws( vari )
***************************************************
   varim := 'zwart' + SubStr( vari, 5 )
   VV1 := 'WART' + SubStr( vari, 5 )
   VV2 := 'VAT' + SubStr( vari, 5 )
   vvariM := SubStr( variM, 2 )
   &VVARIM := &vv1 + &VV2
   vvari := SubStr( vari, 2 )
   DO CASE
   CASE &vari == 0 .OR. ( &variM <> &vvariM )
      procvat := Val( SubStr( vari, 5, 2 ) )
      DO CASE
      CASE procvat == 2
         procvat := 1 + ( vat_C / 100 )
      CASE procvat == 7
         procvat := 1 + ( vat_B / 100 )
      CASE procvat == 22
         procvat := 1 + ( vat_A / 100 )
      CASE procvat == 12
         procvat := 1 + ( vat_D / 100 )
      case procvat == 8
         procvat := 1.00
      ENDCASE
      NN := _round( &varim * procvat, 2 )
      &vari := NN - &varim
   CASE &variM == &vvariM
        &vari := &vvari
   ENDCASE
   RETURN .T.

***************************************************
FUNCTION SUMPODd()
***************************************************
   zWART22 := zBRUT22 - zVAT22
   zWART07 := zBRUT07 - zVAT07
   zWART02 := zBRUT02 - zVAT02
   zWART12 := zBRUT12 - zVAT12
   zWART00 := zBRUT00
   zWARTZW := zBRUTZW
   zWART08 := zBRUT08
   @ 12, 14 SAY zWART22 PICTURE RPIC
   @ 13, 14 SAY zWART07 PICTURE RPIC
   @ 14, 14 SAY zWART02 PICTURE RPIC
   @ 15, 14 SAY zWART12 PICTURE RPIC
   @ 16, 14 SAY zWART00 PICTURE RPIC
   @ 17, 14 SAY zWARTZW PICTURE RPIC
   @ 18, 14 SAY zWART08 PICTURE RPIC
   @ 19, 14 SAY zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zWART08 PICTURE RPIC
   @ 19, 31 SAY zVAT22 + zVAT12 + zVAT07 + zVAT02 PICTURE RPIC
   @ 19, 48 SAY zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWART08 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 PICTURE RPIC
   RETURN .T.

***************************************************
FUNCTION SUMPOwd( vari )
***************************************************
   varim := 'zbrut' + SubStr( vari, 5 )
   VV1 := 'WART' + SubStr( vari, 5 )
   VV2 := 'VAT' + SubStr( vari, 5 )
   vvariM := SubStr( variM, 2 )
   &VVARIM := &vv1 + &VV2
   vvari := SubStr( vari, 2 )
   DO CASE
   CASE &vari == 0 .OR. ( &variM <> &vvariM )
      procvat := Val( SubStr( vari, 5, 2 ) )
      if zRACH='R'
         DO CASE
         CASE procvat == 2
            procvat := _round( vat_C / ( 100 + vat_C ), 4 )
         CASE procvat == 7
            procvat := _round( vat_B / ( 100 + vat_B ), 4 )
         CASE procvat == 22
            procvat := _round( vat_A / ( 100 + vat_A ), 4 )
         CASE procvat == 12
            procvat := _round( vat_D / ( 100 + vat_D ), 4 )
         CASE procvat=8
            procvat := 0.0000
         ENDCASE
         &vari := _round( &varim * procvat, 2 )
      ELSE
         DO CASE
         CASE procvat == 2
            procvat := 1 + ( vat_C / 100 )
         CASE procvat == 7
            procvat := 1 + ( vat_B / 100 )
         CASE procvat == 22
            procvat := 1 + ( vat_A / 100 )
         CASE procvat == 12
            procvat := 1 + ( vat_D / 100 )
         CASE procvat=8
            procvat := 1.00
         ENDCASE
         NN := _round( &varim / procvat, 2 )
         &vari := &varim - NN
      ENDIF
   CASE &variM == &vvariM
      &vari := &vvari
   ENDCASE
   RETURN .T.

*******************************************************
FUNCTION SUMNETs( lRyczModSys )
*******************************************************

   IF zSEK_CV7 == 'DP'
      RejS_PolaDod()
   ENDIF

   zNETTOOrg := _round( zWARTZW + zWART08 + zWART00 + zWART02 + zWART07 + zWART22 + zWART12, 2 )

   IF ins
      IF zNETTO == 0
         zNETTO := _round( zWARTZW + zWART08 + zWART00 + zWART02 + zWART07 + zWART22 + zWART12, 2 )
      ENDIF
   ELSE
      IF zNETTO <> 0 .OR. lRyczModSys
         zNETTO := _round( zWARTZW + zWART08 + zWART00 + zWART02 + zWART07 + zWART22 + zWART12, 2 )
      ENDIF
   ENDIF
   RETURN .T.

*******************************************************
FUNCTION vSUMNETs()
*******************************************************
   IF zNETTO == 0
      IF zRYCZALT == 'T'
         zKOLUMNA := '00'
         zKOLUMNA2 := '00'
      ELSE
         zKOLUMNA := '0'
         zKOLUMNA2 := '0'
      ENDIF
      zNETTO2 := 0
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION KRejSWZNetto2()

   LOCAL lRes := zNETTO <> 0

   IF lRes .AND. zNETTOOrg <> 0 .AND. zNETTO <> zNETTOOrg
      zNETTO2 := zNETTOOrg - zNETTO
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION KRejSWZKolumna2( lRycz )

   LOCAL lRes := zNETTO2 <> 0

   IF lRes
      ColInf()
      IF lRycz
         @ 24, 0 SAY PadC( 'Kolumna: 5, 6, 7, 8, 9 lub 11', 80, ' ' )
      ELSE
         @ 24, 0 SAY PadC( 'Kolumna: 7 lub 8', 80, ' ' )
         IF Val( zKOLUMNA ) == 7
            zKOLUMNA2 := '8'
         ELSE
            zKOLUMNA2 := '7'
         ENDIF
      ENDIF
      ColStd()
   ELSE
      zKOLUMNA2 := ' '
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION KRejSVZKolumna2( lRycz )

   LOCAL lRes := .F.

   IF lRycz
      lRes := ( AllTrim( zKOLUMNA2 ) $ '56789' .OR. zKOLUMNA2 == '11' ) .AND. ( Val( zKOLUMNA ) <> Val( zKOLUMNA2 ) )
   ELSE
      lRes := zKOLUMNA2 $ '78' .AND. Val( zKOLUMNA2 ) <> Val( zKOLUMNA )
   ENDIF

   IF lRes
      ColStd()
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION KRejSWZKolumna( lRycz )

   LOCAL lRes := zNETTO <> 0

   IF lRes
      ColInf()
      IF lRycz
         @ 24, 0 SAY PadC( 'Kolumna: 5, 6, 7, 8, 9 lub 11', 80, ' ' )
      ELSE
         @ 24, 0 SAY PadC( 'Kolumna: 7 lub 8', 80, ' ' )
      ENDIF
      ColStd()
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION KRejSVZKolumna( lRycz )

   LOCAL lRes := .F.

   IF lRycz
      lRes := AllTrim( zKOLUMNA ) $ '56789' .OR. zKOLUMNA == '11'
   ELSE
      lRes := AllTrim( zKOLUMNA ) $ '78'
   ENDIF

   IF lRes
      ColStd()
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

*******************************************************
FUNCTION vfsSEK_CV7()
*******************************************************
   R := .F.
   IF zSEK_CV7 == 'PN' .OR. zSEK_CV7 == '  ' .OR. zSEK_CV7 == 'PU' .OR. zSEK_CV7 == 'DP' .OR. zSEK_CV7 == 'SP'
      RestScreen( 2, 40, 8, 79, scr_sekcv7 )
      R := .T.
   ELSE
      R := .F.
   ENDIF
   RETURN R

*******************************************************
FUNCTION wfsSEK_CV7()
*******************************************************
   scr_sekcv7 := SaveScreen( 2, 40, 9, 79 )
   scr_kolumC := .T.
   ColInf()
   @ 2, 40 CLEAR TO 9, 79
   @ 2, 40 TO 9, 79
   @ 3, 41 SAY PadC( 'Podaj sekcje deklaracji VAT-7:', 30 )
   @ 4, 41 SAY '   - dwie spacje - zadne z ponizszych '
   @ 5, 41 SAY 'PN - podatnikiem nabywca (towar)      '
   @ 6, 41 SAY 'PU - podatnikiem nabywca (usˆuga)     '
   @ 7, 41 SAY 'SP - mechanizm podzielonej pˆatno˜ci  '
   @ 8, 41 SAY 'DP - dodatowe pola (K_36, K_46)       '
   ColStd()
   RETURN .T.

*############################################################################

FUNCTION krejsRysujTlo()
   ColStd()
   @  3, 0 SAY 'Do rej. na dzien....     Symbol rej...     Nr dowodu ksi©g...                   '
   @  4, 0 SAY 'KONTRAH: Nr identyfik. (NIP).                                            Exp:   '
   @  5, 0 SAY '         Nazwa...............                                             UE:   '
   @  6, 0 SAY '         Adres...............                                           Kraj:   '
   @  7, 0 SAY 'Opis zdarzenia gospodarczego.                                                   '
   @  8, 0 SAY 'Uwagi........................                         Transakcja tr¢jstronna:   '
   @  9, 0 SAY 'Data sprze.           Data wyst.           Korekta ?.    Pola sekcji C VAT-7:   '
   @ 10, 0 SAY ' ------------------------------------------------------------------------------ '
   @ 11, 0 SAY '                 N E T T O         V A T          B R U T T O                   '
   @ 12, 0 SAY '        ' + Str( vat_A, 2 ) + '%                                                                     '
   @ 13, 0 SAY '        ' + Str( vat_B, 2 ) + '%                                                                     '
   @ 14, 0 SAY '        ' + Str( vat_C, 2 ) + '%                                                                     '
   @ 15, 0 SAY '        ' + Str( vat_D, 2 ) + '%                                                                     '
   @ 16, 0 SAY '         0%                                                                     '
   @ 17, 0 SAY '        ZW                                                                      '
   @ 18, 0 SAY '        NP                                                                      '
   @ 19, 0 SAY '      RAZEM                                                                     '
   @ 20, 0 SAY '              **************                                                    '
   @ 21, 0 SAY 'Zaksi©gowa†                  zˆ. do kol.     |                   zˆ. do kol.    '
   @ 22, 0 SAY 'Kontrola zaplat....  Termin zaplaty.... (..........) Juz zaplacono.             '
   @ 23, 0 SAY '                                                                                '
   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Valid_RejS_Trojstr()

   LOCAL lRes := zTROJSTR$'NT'

   IF lRes
      ColStd()
      @ 8, 78 SAY iif( zTROJSTR == 'T', 'ak', 'ie' )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

PROCEDURE RejS_PolaDod()

   LOCAL GetList := {}
   LOCAL cEkran
   LOCAL cKolor := ColStd()

   cEkran := SaveScreen()
   @ 14, 40 CLEAR TO 20, 79
   @ 14, 40 TO 20, 79
   @ 15, 42 SAY "Pola dodatkowe"
   @ 16, 42 SAY "K.36 - spis z natury   " GET zKOL36 PICTURE FPIC
   @ 17, 42 SAY "K.37 - zakup kas       " GET zKOL37 PICTURE FPIC
   @ 18, 42 SAY "K.38 - nab.sr.transp.  " GET zKOL38 PICTURE FPIC
   @ 19, 42 SAY "K.39 - nab.paliw siln. " GET zKOL39 PICTURE FPIC
   READ

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE KRejS_Ksieguj()

   znumer := dos_l( znumer )
   zdzien := Str( Val( zDZIEN ), 2 )
   *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
   tresc_ := tresc
   KontrApp()
   WrocStan()
   SEEK '+' + ident_fir + ztresc
   IF Found()
      BlokadaR()
      AKTPOL+ stan WITH (-zNETTO - zNETTO2)
      UNLOCK
   ENDIF
   SELECT suma_mc
   IF ! ins .AND. Left( rejs->numer, 1 ) # Chr( 1 ) .AND. Left( rejs->numer, 1 ) # Chr( 254 )
      BlokadaR()
      AktKol( -1, rejs->KOLUMNA, netprzed )
      AktKol( -1, rejs->KOLUMNA2, netprzed2 )
   ENDIF
   IF RTrim( znumer ) # 'REM-P' .AND. RTrim( znumer ) # 'REM-K'
      BlokadaR()
      AktKol( 1, zKOLUMNA, zNETTO )
      AktKol( 1, zKOLUMNA2, zNETTO2 )
   ENDIF
   UNLOCK
   SELECT rejs
   IfIns( 0 )
   BlokadaR()
   ADDPOZ
   *WAIT zsek_cv7
   ADDREJS
   UNLOCK
   REKZAK := RecNo()
   COMMIT

   *para fZRODLO,fJAKIDOK,fNIP,fNRDOK,fDATAKS,fDATADOK,fTERMIN,fDNIPLAT,fRECNO,fKWOTA,fTRESC,fKWOTAVAT
   * JAKIDOK: FS i FZ (faktury zakupu i sprzedazy), ZS i ZZ (zaplaty za sprzedaz i zakupy)

   SELECT 5
   DO WHILE ! Dostep( 'ROZR' )
   ENDDO
   SetInd( 'ROZR' )

   SELECT rozr
   IF ins
      IF zROZRZAPS == 'T'
         dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
         IF ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWART08 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
            RozrApp( 'S', 'FS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWART08 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
         ENDIF
         IF zZAP_WART > 0.0
            RozrApp( 'S', 'ZS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
         ENDIF
      ENDIF
   ELSE
      SET ORDER TO 2
      SEEK ident_fir + param_rok + 'S' + Str( REKZAK, 10 )
      IF Found()
         IF zROZRZAPS == 'T'
            SELECT rozr
            RozrDel( 'S', REKZAK )
            dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
            IF ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWART08 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
               RozrApp( 'S', 'FS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWART08 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
            ENDIF
            IF zZAP_WART > 0.0
               RozrApp( 'S', 'ZS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
            ENDIF
         ELSE
            SELECT rozr
            RozrDel( 'S', REKZAK )
         ENDIF
      ELSE
         IF zROZRZAPS == 'T'
            SELECT rozr
            RozrDel( 'S', REKZAK )
            dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
            IF ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWART08 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
               RozrApp( 'S', 'FS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWART08 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
            ENDIF
            IF zZAP_WART > 0.0
               RozrApp( 'S', 'ZS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
            ENDIF
         ENDIF
      ENDIF
   ENDIF

   ************* ZAPIS REJESTRU DO KSIEGI *******************
   SELECT 5
   IF zRYCZALT == 'T'
      usebaz := 'EWID'
   ELSE
      usebaz := 'OPER'
   ENDIF
   DO WHILE ! Dostep( USEBAZ )
   ENDDO
   SetInd( USEBAZ )
   IF ! ins
      IF zRYCZALT == 'T'
         IF ( AllTrim( zKOLUMNA ) $ '56789' .OR. AllTrim( rejs->KOLUMNA ) $ '56789' .OR. AllTrim( zKOLUMNA ) == '11' .OR. AllTrim( rejs->KOLUMNA ) == '11' ) ;
            .OR. ( AllTrim( zKOLUMNA2 ) $ '56789' .OR. AllTrim( rejs->KOLUMNA2 ) $ '56789' .OR. AllTrim( zKOLUMNA2 ) == '11' .OR. AllTrim( rejs->KOLUMNA2 ) == '11' )
            DO CASE
            CASE netprzed <> 0
               SET ORDER TO 5
               SEEK '+' + Str( REKZAK, 5 ) + 'RS-'
               IF Found()
                  IF zNETTO == 0
                     BlokadaR()
                     DELETE
                     UNLOCK
                     COMMIT
                     SELECT suma_mc
                     BlokadaR()
                     repl_( 'pozycje', pozycje - 1 )
                     UNLOCK
                     SELECT &USEBAZ
                     SET ORDER TO 1
                     *********************** lp
                     IF nr_uzytk >= 0
                        IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                           Blokada()
                           Czekaj()
                           rec := RecNo()
                           DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                              repl_( 'lp', lp - 1 )
                              SKIP
                           ENDDO
                           GO rec
                           UNLOCK
                           @ 24, 0
                        ENDIF
                     ENDIF
                     *******************************
                  ELSE
                     BlokadaR()
                     repl_( 'DZIEN', zdzien )
                     repl_( 'DATAPRZY', zdatas )
                     repl_( 'NUMER', 'RS-' + znumer )
                     repl_( 'TRESC', zTRESC )
                     repl_( 'UWAGI', zUWAGI )
                     repl_( 'zaplata', '1' )
                     repl_( 'kwota', 0 )
                     REPLACE  ry20      WITH iif( AllTrim( zKOLUMNA ) == '5', znetto, 0 )
                     REPLACE  ry17      WITH iif( AllTrim( zKOLUMNA ) == '6', znetto, 0 )
                     REPLACE  uslugi    WITH iif( AllTrim( zKOLUMNA ) == '7', znetto, 0 )
                     REPLACE  produkcja WITH iif( AllTrim( zKOLUMNA ) == '8', znetto, 0 )
                     REPLACE  handel    WITH iif( AllTrim( zKOLUMNA ) == '9', znetto, 0 )
                     REPLACE  ry10      WITH iif( AllTrim( zKOLUMNA ) == '11', znetto, 0 )
                     IF zNETTO2 <> 0 .AND. Val( zKOLUMNA2 ) > 0
                        DO CASE
                        CASE AllTrim( zKOLUMNA2 ) == '5'
                           REPLACE  ry20      WITH zNETTO2
                        CASE AllTrim( zKOLUMNA2 ) == '6'
                           REPLACE  ry17      WITH zNETTO2
                        CASE AllTrim( zKOLUMNA2 ) == '7'
                           REPLACE  uslugi    WITH zNETTO2
                        CASE AllTrim( zKOLUMNA2 ) == '8'
                           REPLACE  produkcja WITH zNETTO2
                        CASE AllTrim( zKOLUMNA2 ) == '9'
                           REPLACE  handel    WITH zNETTO2
                        CASE AllTrim( zKOLUMNA2 ) == '11'
                           REPLACE  ry10      WITH zNETTO2
                        ENDCASE
                     ENDIF
                     repl_( 'rejzid', REKZAK )
                     UNLOCK
                  ENDIF
                  commit_()
               ENDIF
            CASE netprzed == 0
               *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
               IF zNETTO <> 0
                  SELECT suma_mc
                  BlokadaR()
                  repl_( 'pozycje', pozycje + 1 )
                  UNLOCK
                  SELECT &USEBAZ
                  SET ORDER TO 1
                  app()
                  ADDDOC
                  repl_( 'DZIEN', zdzien )
                  repl_( 'DATAPRZY', zdatas )
                  REPLACE NUMER WITH 'RS-' + zNUMER
                  repl_( 'TRESC', zTRESC )
                  repl_( 'UWAGI', zUWAGI )
                  repl_( 'zaplata', '1' )
                  repl_( 'kwota', 0 )
                  REPLACE  ry20      WITH iif( AllTrim( zKOLUMNA ) == '5', znetto, 0 )
                  REPLACE  ry17      WITH iif( AllTrim( zKOLUMNA ) == '6', znetto, 0 )
                  REPLACE  uslugi    WITH iif( AllTrim( zKOLUMNA ) == '7', znetto, 0 )
                  REPLACE  produkcja WITH iif( AllTrim( zKOLUMNA ) == '8', znetto, 0 )
                  REPLACE  handel    WITH iif( AllTrim( zKOLUMNA ) == '9', znetto, 0 )
                  REPLACE  ry10      WITH iif( AllTrim( zKOLUMNA ) == '11', znetto, 0 )
                  IF zNETTO2 <> 0 .AND. Val( zKOLUMNA2 ) > 0
                     DO CASE
                     CASE AllTrim( zKOLUMNA2 ) == '5'
                        REPLACE  ry20      WITH zNETTO2
                     CASE AllTrim( zKOLUMNA2 ) == '6'
                        REPLACE  ry17      WITH zNETTO2
                     CASE AllTrim( zKOLUMNA2 ) == '7'
                        REPLACE  uslugi    WITH zNETTO2
                     CASE AllTrim( zKOLUMNA2 ) == '8'
                        REPLACE  produkcja WITH zNETTO2
                     CASE AllTrim( zKOLUMNA2 ) == '9'
                        REPLACE  handel    WITH zNETTO2
                     CASE AllTrim( zKOLUMNA2 ) == '11'
                        REPLACE  ry10      WITH zNETTO2
                     ENDCASE
                  ENDIF
                  repl_( 'rejzid', REKZAK )
                  COMMIT
                  UNLOCK
                  *********************** lp
                  IF nr_uzytk >= 0
                     IF param_lp == 'T'
                        Blokada()
                        Czekaj()
                        rec := RecNo()
                        SKIP -1
                        IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                           zlp := liczba
                        ELSE
                           zlp := lp + 1
                        ENDIF
                        GO rec
                        DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                           repl_( 'lp', zlp )
                           zlp := zlp + 1
                           SKIP
                        ENDDO
                        GO rec
                        UNLOCK
                        @ 24, 0
                     ENDIF
                  ENDIF
                  UNLOCK
               ENDIF
            ENDCASE
         ENDIF
      ELSE
         IF ( Str( Val( rejs->KOLUMNA ), 1 ) == '7' ) .OR. ( Str( Val( rejs->KOLUMNA2 ), 1 ) == '7' )
            SET ORDER TO 3
            GO TOP
            SEEK '+' + ident_fir + miesiac + 'RS-7'
            IF Found()
               SET ORDER TO 1
               BlokadaR()
               AKTPOL- wyr_tow WITH  iif( Str( Val( rejs->KOLUMNA ), 1 ) == '7', netprzed, netprzed2 )
               UNLOCK
            ELSE
               SET ORDER TO 1
               *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
               SELECT suma_mc
               BlokadaR()
               repl_( 'pozycje', pozycje + 1 )
               UNLOCK
               SELECT &USEBAZ
               app()
               ADDDOC
               repl_( 'DZIEN', DAYM )
               repl_( 'NUMER', 'RS-7' )
               repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
               repl_( 'WYR_TOW', -iif( Str( Val( rejs->KOLUMNA ), 1 ) == '7', netprzed, netprzed2 ) )
               repl_( 'zaplata', '1' )
               *repl_([kwota],zkwota)
               UNLOCK
               *********************** lp
               IF nr_uzytk >= 0
                  IF param_lp == 'T'
                     Blokada()
                     Czekaj()
                     rec := RecNo()

                     SKIP -1
                     IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                        zlp := liczba
                     ELSE
                        zlp := lp + 1
                     ENDIF
                     GO rec
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', zlp )
                        zlp := zlp + 1
                        SKIP
                     ENDDO

                     GO rec
                     UNLOCK
                     @ 24, 0
                  ENDIF
               ENDIF
               UNLOCK
               ***********************
            ENDIF
         ENDIF
         IF ( Str( Val( rejs->KOLUMNA ), 1 ) == '8' ) .OR. ( Str( Val( rejs->KOLUMNA2 ), 1 ) == '8' )
            SET ORDER TO 3
            GO TOP
            SEEK '+' + ident_fir + miesiac + 'RS-8'
            IF Found()
               SET ORDER TO 1
               BlokadaR()
               AKTPOL- uslugi WITH iif( Str( Val( rejs->KOLUMNA ), 1 ) == '8', netprzed, netprzed2 )
               UNLOCK
            ELSE
               SET ORDER TO 1
               *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
               SELECT suma_mc
               BlokadaR()
               repl_( 'pozycje', pozycje + 1 )
               UNLOCK
               SELECT &USEBAZ
               app()
               ADDDOC
               repl_( 'DZIEN', DAYM )
               repl_( 'NUMER', 'RS-8' )
               repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
               repl_( 'USLUGI', -iif( Str( Val( rejs->KOLUMNA ), 1 ) == '8', netprzed, netprzed2 ) )
               repl_( 'zaplata', '1' )
               * repl_([kwota],zkwota)
               UNLOCK
               *********************** lp
               IF nr_uzytk >= 0
                  IF param_lp == 'T'
                     Blokada()
                     Czekaj()
                     rec := RecNo()

                     SKIP -1
                     IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                        zlp := liczba
                     ELSE
                        zlp := lp + 1
                     ENDIF
                     GO rec
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', zlp )
                        zlp := zlp + 1
                        SKIP
                     ENDDO

                     GO rec
                     UNLOCK
                     @ 24, 0
                  ENDIF
               ENDIF
               UNLOCK
            ***********************
            ENDIF
         ENDIF
      ENDIF
   ELSE
      IF zRYCZALT == 'T'
         IF ( AllTrim( zKOLUMNA ) $ '56789' .OR. AllTrim( zKOLUMNA ) == '11' ) .OR. ( AllTrim( zKOLUMNA2 ) $ '56789' .OR. AllTrim( zKOLUMNA2 ) == '11' )
            *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
            IF zNETTO <> 0
               SELECT suma_mc
               BlokadaR()
               repl_( 'pozycje', pozycje+1)
               unlock
               select &USEBAZ
               set orde to 1
               app()
               adddoc
               repl_( 'DZIEN', zdzien )
               repl_( 'DATAPRZY', zdatas )
               repl_( 'NUMER', 'RS-' + ZNUMER)
               repl_( 'TRESC', zTRESC )
               repl_( 'UWAGI', zUWAGI )
               repl_( 'zaplata', '1' )
               repl_( 'kwota', 0 )
               REPLACE  ry20      WITH iif( AllTrim( zKOLUMNA ) == '5', znetto, 0 )
               REPLACE  ry17      WITH iif( AllTrim( zKOLUMNA ) == '6', znetto, 0 )
               REPLACE  uslugi    WITH iif( AllTrim( zKOLUMNA ) == '7', znetto, 0 )
               REPLACE  produkcja WITH iif( AllTrim( zKOLUMNA ) == '8', znetto, 0 )
               REPLACE  handel    WITH iif( AllTrim( zKOLUMNA ) == '9', znetto, 0 )
               REPLACE  ry10      WITH iif( AllTrim( zKOLUMNA ) == '11', znetto, 0 )
               IF zNETTO2 <> 0 .AND. Val( zKOLUMNA2 ) > 0
                  DO CASE
                  CASE AllTrim( zKOLUMNA2 ) == '5'
                     REPLACE  ry20      WITH zNETTO2
                  CASE AllTrim( zKOLUMNA2 ) == '6'
                     REPLACE  ry17      WITH zNETTO2
                  CASE AllTrim( zKOLUMNA2 ) == '7'
                     REPLACE  uslugi    WITH zNETTO2
                  CASE AllTrim( zKOLUMNA2 ) == '8'
                     REPLACE  produkcja WITH zNETTO2
                  CASE AllTrim( zKOLUMNA2 ) == '9'
                     REPLACE  handel    WITH zNETTO2
                  CASE AllTrim( zKOLUMNA2 ) == '11'
                     REPLACE  ry10      WITH zNETTO2
                  ENDCASE
               ENDIF
               repl_( 'rejzid', REKZAK )
               commit_()
               UNLOCK
               *********************** lp
               IF nr_uzytk >= 0
                  IF param_lp == 'T'
                     Blokada()
                     Czekaj()
                     rec := RecNo()
                     SKIP -1
                     IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                        zlp := liczba
                     ELSE
                        zlp := lp + 1
                     ENDIF
                     GO rec
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', zlp )
                        zlp := zlp + 1
                        SKIP
                     ENDDO
                     GO rec
                     UNLOCK
                     @ 24, 0
                  ENDIF
               ENDIF
               UNLOCK
            ENDIF
         ENDIF
      ENDIF
   ENDIF
   IF zRYCZALT # 'T'
      IF ( Str( Val( zKOLUMNA ), 1 ) $ '78' ) .OR. ( Str( Val( zKOLUMNA2 ), 1 ) $ '78' )
         SELECT oper
         SET ORDER TO 3
         IF ( Str( Val( zKOLUMNA ), 1 ) == '7' ) .OR. ( Str( Val( zKOLUMNA2 ), 1 ) == '7' )
            GO TOP
            SEEK '+' + ident_fir + miesiac + 'RS-7'
            IF Found()
               SET ORDER TO 1
               BlokadaR()
               repl_( 'wyr_tow', wyr_tow + iif( Str( Val( zKOLUMNA ), 1 ) == '7', znetto, znetto2 ) )
               UNLOCK
            ELSE
               SET ORDER TO 1
               *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
               SELECT suma_mc
               BlokadaR()
               repl_( 'pozycje', pozycje+1)
               unlock
               select &USEBAZ
               app()
               adddoc
               repl_( 'DZIEN', DAYM)
               repl_( 'NUMER', 'RS-7')
               repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY')
               repl_( 'WYR_TOW', iif( Str( Val( zKOLUMNA ), 1 ) == '7', znetto, znetto2 ) )
               repl_( 'zaplata', '1')
               * repl_([kwota],zkwota)
               unlock
               *********************** lp
               IF nr_uzytk >= 0
                  IF param_lp == 'T'
                     Blokada()
                     Czekaj()
                     rec := RecNo()

                     SKIP -1
                     IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                        zlp := liczba
                     ELSE
                        zlp := lp + 1
                     ENDIF
                     GO rec
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', zlp )
                        zlp := zlp + 1
                        SKIP
                     ENDDO

                     GO rec
                     UNLOCK
                     @ 24, 0
                  ENDIF
               ENDIF
               UNLOCK
               ***********************
            ENDIF
         ENDIF
         IF ( Str( Val( zKOLUMNA ), 1 ) == '8' ) .OR. ( Str( Val( zKOLUMNA2 ), 1 ) == '8' )
            SET ORDER TO 3
            GO TOP
            SEEK '+' + ident_fir + miesiac + 'RS-8'
            IF Found()
               SET ORDER TO 1
               BlokadaR()
               repl_( 'uslugi', uslugi + iif( Str( Val( zKOLUMNA ), 1 ) == '8', znetto, znetto2 ) )
               UNLOCK
            ELSE
               SET ORDER TO 1
               *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
               SELECT suma_mc
               BlokadaR()
               repl_( 'pozycje', pozycje + 1 )
               UNLOCK
               SELECT &USEBAZ
               app()
               ADDDOC
               repl_( 'DZIEN', DAYM )
               repl_( 'NUMER', 'RS-8' )
               repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
               repl_( 'USLUGI', iif( Str( Val( zKOLUMNA ), 1 ) == '8', znetto, znetto2 ) )
               repl_( 'zaplata', '1' )
               * repl_([kwota],zkwota)
               UNLOCK
               *********************** lp
               IF nr_uzytk >= 0
                  IF param_lp == 'T'
                     Blokada()
                     Czekaj()
                     rec := RecNo()

                     SKIP -1
                     IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                        zlp := liczba
                     ELSE
                        zlp := lp + 1
                     ENDIF
                     GO rec
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', zlp )
                        zlp := zlp + 1
                        SKIP
                     ENDDO

                     GO rec
                     UNLOCK
                     @ 24, 0
                  ENDIF
               ENDIF
               UNLOCK
               ***********************
            ENDIF
         ENDIF
      ENDIF
   ENDIF
   ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
   SELECT rejs
   BlokadaR()
   repl_( 'NETTO', zNETTO )
   repl_( 'KOLUMNA', AllTrim( zKOLUMNA ) )
   repl_( 'NETTO2', zNETTO2 )
   repl_( 'KOLUMNA2', AllTrim( zKOLUMNA2 ) )
   repl_( 'TROJSTR', zTROJSTR )
   repl_( 'KOL36', zKOL36 )
   repl_( 'KOL37', zKOL37 )
   repl_( 'KOL38', zKOL38 )
   repl_( 'KOL39', zKOL39 )
   UNLOCK
   *נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ


   RETURN NIL

/*----------------------------------------------------------------------*/

