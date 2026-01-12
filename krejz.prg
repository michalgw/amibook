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

#include "ami_book.ch"
#include "Inkey.ch"

PROCEDURE KRejZ()

   LOCAL nImpMenu, aDaneVAT

   PRIVATE oGetWAR2, oGetVAT2, oGetWAR7, oGetVAT7, oGetWAR12, oGetVAT12, oGetWAR22, oGetVAT22, lBlokuj := .F.
   PRIVATE oGetSYMB_REJ, oGetTRESC, oGetOPCJE, fDETALISTA, oGetRodzDow, oGetSekCV7, oGetKOLUMNA
   PRIVATE nOrgW2, nOrgW7, nOrgW12, nOrgW22, zRODZDOW, cScrRodzDow
   PRIVATE zK16OPIS, zKOL47, zKOL48, zKOL49, zKOL50, nWartoscNetto, zVATMARZA
   PRIVATE _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou
   PRIVATE cOstSymbRej

   fDETALISTA := DETALISTA

   zexport := 'N'
   scr_kolumL := .F.
   scr_kolumC := .F.
   @ 1, 47 SAY '          '
   m->liczba := 1
   LpStart()

   sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.01' ) )

   *################################# GRAFIKA ##################################
   krejzRysujTlo()
   *############################### OTWARCIE BAZ ###############################
   SELECT 3
   IF Dostep( 'FIRMA' )
      GO Val( ident_fir )
      spolka_ := spolka
   ELSE
      RETURN
   ENDIF
   zstrusprob := strusprob
   paraDATAKS := DATAKS
   SELECT 1
   OpenOper( 'REJZ' )
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
      if Day( CToD( param_rok + '.' + miesiac + '.' + DAYM ) ) == 0
         DAYM := '28'
      ENDIF
   ENDCASE
   *################################# OPERACJE #################################
   *----- parametry ------
   _top := 'firma#ident_fir.or.mc#miesiac'
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + miesiac
   _sbot := '+' + ident_fir + miesiac + 'þ'
   _proc := 'say1z'
   *----------------------
   _top_bot := _top + '.or.' + _bot
   IF ! &_top_bot
      DO &_proc
   ENDIF
   scr_kolum := SaveScreen( 7, 40, 20, 79 )
   scr_sekcv7 := SaveScreen( 0, 16, 12, 55 )
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

         nImpMenu := 1
         IF SalSprawdz( .F. )
            cKolor := ColInf()
            @ 24, 0 SAY PadC( "Wybierz «r¢dˆo importu", 80 )
            SetColor( cKolor )
            nImpMenu := MenuEx( 10, 10, { ;
               "J - Importuj z pliku JPK", ;
               "S - importuj z SaldeoSMART (wysˆane)", ;
               "D - importuj z SaldeoSMART (ostatnie 10 dni)", ;
               "O - importuj z SaldeoSMART (odczytane ost. 10 dni)" }, nImpMenu )
            @ 24, 0
         ENDIF
         DO CASE
         CASE nImpMenu == 1
            JPKImp_VatZ()
         CASE nImpMenu >= 2 .AND. nImpMenu <= 4
            SalImp_VatZ( nImpMenu - 1 )
         ENDCASE
         IF &_bot
            SEEK '+' + ident_fir + miesiac
         ENDIF
         IF ! &_bot
            DO &_proc
         ENDIF

      CASE kl == Asc( 'B' ) .OR. kl == Asc( 'b' )
         IF fDETALISTA == 'T'
            fDETALISTA := 'N'
         ELSE
            fDETALISTA := 'T'
         ENDIF
         @ 2, 70 SAY iif( fDETALISTA <> 'T', ' netto  ', ' brutto ' )
         Komun( "Zmieniono metod© wprowadzania kwot na " + iif( fDETALISTA <> 'T', 'NETTO', 'BRUTTO' ) )

      CASE ( kl == K_INS .OR. kl == Asc( '0' ) .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' ) .OR. kl == Asc( 'K' ) .OR. kl == Asc( 'k' ) .OR. kl == K_F6 .OR. &_top_bot ) .AND. kl # K_ESC
         @ 1,47 SAY '          '
         ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
         BEGIN SEQUENCE
            IF ZamSum1()
               BREAK
            ENDIF
            krejzRysujTlo()
            KtorOper()
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins .AND. kl == K_F6
               aBufDok := Bufor_Dok_Wybierz( 'rejz' )
               IF ! Empty( aBufDok ) .AND. HB_ISHASH( aBufDok )
                  zDZIEN := aBufDok[ 'DZIEN' ]
                  zSYMB_REJ := aBufDok[ 'SYMB_REJ' ]
                  zNAZWA := aBufDok[ 'NAZWA' ]
                  zNR_IDENT := aBufDok[ 'NR_IDENT' ]
                  zNUMER := aBufDok[ 'NUMER' ]
                  zADRES := aBufDok[ 'ADRES' ]
                  zTRESC := aBufDok[ 'TRESC' ]
                  zROKS := aBufDok[ 'ROKS' ]
                  zMCS := aBufDok[ 'MCS' ]
                  zDZIENS := aBufDok[ 'DZIENS' ]
                  zDATAS := aBufDok[ 'DATAS' ]
                  zDATAKS := aBufDok[ 'DATAKS' ]
                  zKOLUMNA := aBufDok[ 'KOLUMNA' ]
                  zUWAGI := aBufDok[ 'UWAGI' ]
                  zWARTZW := aBufDok[ 'WARTZW' ]
                  zWART00 := aBufDok[ 'WART00' ]
                  zWART02 := aBufDok[ 'WART02' ]
                  zVAT02 := aBufDok[ 'VAT02' ]
                  zWART07 := aBufDok[ 'WART07' ]
                  zVAT07 := aBufDok[ 'VAT07' ]
                  zWART22 := aBufDok[ 'WART22' ]
                  zVAT22 := aBufDok[ 'VAT22' ]
                  zWART12 := aBufDok[ 'WART12' ]
                  zVAT12 := aBufDok[ 'VAT12' ]
                  zBRUT02 := aBufDok[ 'VAT02' ] + aBufDok[ 'WART02' ]
                  zBRUT07 := aBufDok[ 'VAT07' ] + aBufDok[ 'WART07' ]
                  zBRUT22 := aBufDok[ 'VAT22' ] + aBufDok[ 'WART22' ]
                  zBRUT12 := aBufDok[ 'VAT12' ] + aBufDok[ 'WART12' ]
                  zNETTO := aBufDok[ 'NETTO' ]
                  zExPORT := iif( aBufDok[ 'EXPORT' ] == ' ', 'N', aBufDok[ 'EXPORT' ] )
                  zUE := iif( aBufDok[ 'UE' ] == ' ', 'N', aBufDok[ 'UE' ] )
                  zKRAJ := iif( aBufDok[ 'KRAJ' ] == '  ', 'PL', aBufDok[ 'KRAJ' ] )
                  zSEK_CV7 := aBufDok[ 'SEK_CV7' ]
                  zRACH := aBufDok[ 'RACH' ]
                  zKOREKTA := aBufDok[ 'KOREKTA' ]
                  zUSLUGAUE := aBufDok[ 'USLUGAUE' ]
                  zWEWDOS := aBufDok[ 'WEWDOS' ]
                  zPALIWA := aBufDok[ 'PALIWA' ]
                  zPOJAZDY := aBufDok[ 'POJAZDY' ]
                  zDETAL := aBufDok[ 'DETAL' ]
                  zSP22 := aBufDok[ 'SP22' ]
                  zSP12 := aBufDok[ 'SP12' ]
                  zSP07 := aBufDok[ 'SP07' ]
                  zSP02 := aBufDok[ 'SP02' ]
                  zSP00 := aBufDok[ 'SP00' ]
                  zSPZW := aBufDok[ 'SPZW' ]
                  zZOM22 := aBufDok[ 'ZOM22' ]
                  zZOM12 := aBufDok[ 'ZOM12' ]
                  zZOM07 := aBufDok[ 'ZOM07' ]
                  zZOM02 := aBufDok[ 'ZOM02' ]
                  zZOM00 := aBufDok[ 'ZOM00' ]
                  zROZRZAPZ := aBufDok[ 'ROZRZAPZ' ]
                  zZAP_TER := aBufDok[ 'ZAP_TER' ]
                  zZAP_DAT := aBufDok[ 'ZAP_DAT' ]
                  zZAP_WART := aBufDok[ 'ZAP_WART' ]
                  zOPCJE := aBufDok[ 'OPCJE' ]

                  zK16OPIS := Space( 30 )
                  zTROJSTR := iif( aBufDok[ 'TROJSTR' ] == ' ', 'N', aBufDok[ 'TROJSTR' ] )

                  zKOL47 := aBufDok[ 'KOL47' ]
                  zKOL48 := aBufDok[ 'KOL48' ]
                  zKOL49 := aBufDok[ 'KOL49' ]
                  zKOL50 := aBufDok[ 'KOL50' ]

                  zNETTO2 := aBufDok[ 'NETTO2' ]
                  zKOLUMNA2 := aBufDok[ 'KOLUMNA2' ]
                  zDATATRAN := aBufDok[ 'DATATRAN' ]

                  zRODZDOW := aBufDok[ 'RODZDOW' ]
                  zVATMARZA := aBufDok[ 'VATMARZA' ]
               ELSE
                  BREAK
               ENDIF
            ELSEIF ins .AND. ( kl == Asc( 'K' ) .OR. kl == Asc( 'k' ) ) .AND. ! &_top_bot
               IF DocSys()
                  BREAK
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
               zDATAKS := DATAKS
               zKOLUMNA := KOLUMNA
               zUWAGI := UWAGI
               zWARTZW := WARTZW
               zWART00 := WART00
               zWART02 := WART02
               zVAT02 := VAT02
               zWART07 := WART07
               zVAT07 := VAT07
               zWART22 := WART22
               zVAT22 := VAT22
               zWART12 := WART12
               zVAT12 := VAT12
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
               zUSLUGAUE := USLUGAUE
               zWEWDOS := WEWDOS
               zPALIWA := PALIWA
               zPOJAZDY := POJAZDY
               zDETAL := DETAL
               zSP22 := SP22
               zSP12 := SP12
               zSP07 := SP07
               zSP02 := SP02
               zSP00 := SP00
               zSPZW := SPZW
               zZOM22 := ZOM22
               zZOM12 := ZOM12
               zZOM07 := ZOM07
               zZOM02 := ZOM02
               zZOM00 := ZOM00
               zROZRZAPZ := ROZRZAPZ
               zZAP_TER := ZAP_TER
               zZAP_DAT := ZAP_DAT
               zZAP_WART := ZAP_WART
               zOPCJE := OPCJE

               zK16OPIS := Space( 30 )
               IF KOLUMNA == '16'
                  // Pobieramy opis kolumny 16 z ksiegi
               ENDIF
               zTROJSTR := iif( TROJSTR == ' ', 'N', TROJSTR )

               zKOL47 := KOL47
               zKOL48 := KOL48
               zKOL49 := KOL49
               zKOL50 := KOL50

               zNETTO2 := NETTO2
               zKOLUMNA2 := KOLUMNA2
               zDATATRAN := DATATRAN

               zRODZDOW := RODZDOW
               zVATMARZA := VATMARZA
            ELSEIF ins
               @  2, 5 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄ'
/*
               @  4, 78 CLEAR TO  5, 79
               @  4, 29 CLEAR TO  4, 50
               @  5, 29 CLEAR TO  7, 69
               @  9, 29 CLEAR TO  9, 38
               @  9, 78 CLEAR TO 10, 79
               @ 10, 29 SAY '   '
               *@ 10,50 say '   '
               *@ 10,77 say '   '
               @ 13,  8 CLEAR TO 13, 79
               @ 14, 40 CLEAR TO 14, 79
               @ 15,  8 CLEAR TO 19, 79
               *@ 13,57 clear to 19,79
*/
               zDZIEN := '  '
               IF param_kssr == 'N'
                  zSYMB_REJ := '  '
               ENDIF
               znazwa := Space( 200 )
               zNR_IDENT := Space( 30 )
               zNUMER := Space( 97 )
               zADRES := Space( 200 )
               zTRESC := Space( 30 )
               zROKS := '    '
               zMCS := '  '
               zDZIENS := '  '
               zDATAS := CToD( zROKS + '.' + zMCS + '.' + zDZIENS )
               zDATAKS := zDATAS
               zKOLUMNA := '  '
               zuwagi := Space( 14 )
               zWARTZW := 0
               zWART00 := 0
               zWART07 := 0
               zWART02 := 0
               zVAT02 := 0
               zVAT07 := 0
               zWART22 := 0
               zVAT22 := 0
               zWART12 := 0
               zVAT12 := 0
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
               zDETAL := fDETALISTA
               zKOREKTA := 'N'
               zUSLUGAUE := 'N'
               zWEWDOS := 'N'
               zPALIWA := 0
               zPOJAZDY := 0
               zSP22 := 'P'
               zSP12 := 'P'
               zSP07 := 'P'
               zSP02 := 'P'
               zSP00 := 'P'
               zSPZW := 'P'
               zZOM22 := 'O'
               zZOM00 := 'O'
               zZOM12 := 'O'
               zZOM07 := 'O'
               zZOM02 := 'O'
               zROZRZAPZ := pzROZRZAPZ
               zZAP_TER := 0
               zZAP_DAT := zDATAS
*                 zZAP_DAT=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')
               zZAP_WART := 0
               zOPCJE := " "
               nOrgW2 := 0
               nOrgW7 := 0
               nOrgW12 := 0
               nOrgW22 := 0

               zK16OPIS := Space( 30 )
               zTROJSTR := 'N'

               zKOL47 := 0
               zKOL48 := 0
               zKOL49 := 0
               zKOL50 := 0

               zNETTO2 := 0
               zKOLUMNA2 := '  '
               zDATATRAN := CToD( zROKS + '.' + zMCS + '.' + zDZIENS )

               zRODZDOW := Space( 6 )
               zVATMARZA := 0
               ***********************
            ELSE
               IF DocSys()
                  BREAK
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
               zDATAKS := DATAKS
               zKOLUMNA := KOLUMNA
               zUWAGI := UWAGI
               zWARTZW := WARTZW
               zWART00 := WART00
               zWART02 := WART02
               zVAT02 := VAT02
               zWART07 := WART07
               zVAT07 := VAT07
               zWART22 := WART22
               zVAT22 := VAT22
               zWART12 := WART12
               zVAT12 := VAT12
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
               zUSLUGAUE := USLUGAUE
               zWEWDOS := WEWDOS
               zPALIWA := PALIWA
               zPOJAZDY := POJAZDY
               zDETAL := DETAL
               zSP22 := SP22
               zSP12 := SP12
               zSP07 := SP07
               zSP02 := SP02
               zSP00 := SP00
               zSPZW := SPZW
               zZOM22 := ZOM22
               zZOM12 := ZOM12
               zZOM07 := ZOM07
               zZOM02 := ZOM02
               zZOM00 := ZOM00
               zROZRZAPZ := ROZRZAPZ
               zZAP_TER := ZAP_TER
               zZAP_DAT := ZAP_DAT
               zZAP_WART := ZAP_WART
               zOPCJE := OPCJE

               zK16OPIS := Space( 30 )
               IF KOLUMNA == '16'
                  // Pobieramy opis kolumny 16 z ksiegi
               ENDIF
               zTROJSTR := iif( TROJSTR == ' ', 'N', TROJSTR )

               zKOL47 := KOL47
               zKOL48 := KOL48
               zKOL49 := KOL49
               zKOL50 := KOL50

               zNETTO2 := NETTO2
               zKOLUMNA2 := KOLUMNA2
               zDATATRAN := DATATRAN

               zRODZDOW := RODZDOW
               zVATMARZA := VATMARZA
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð

            sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.01' ) )
            @ 13, 2 SAY Str( vat_A, 2 )
            @ 14, 2 SAY Str( vat_B, 2 )
            @ 15, 2 SAY Str( vat_C, 2 )
            @ 18, 2 SAY Str( vat_D, 2 )

            stan_ := zNETTO + zNETTO2
            zRACH := 'F'
            scr_kolumL := .F.
            scr_kolumC := .F.
            SET COLOR TO ,W+/W,,,N/W
*             @  3,2 say 'ÍÍ'+chr(16)
            //@  4, 60 SAY 'Nr ident.'
            ColStd()
            @  3, 20 GET zDZIEN PICTURE "99" WHEN WERSJA4 == .T. .OR. ins VALID v1_1z()
            @  3, 38 GET zSYMB_REJ PICTURE "!!" WHEN w11_1z() VALID v11_1z()
            oGetSYMB_REJ := ATail( GetList )
            @  3, 59 GET zNUMER PICTURE "@S20 " + repl( '!', 100 ) VALID v1_2z()
            @  4, 29 SAY Space( 20 )
            @  4, 29 GET zNR_IDENT PICTURE "@S20 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID vv1_3z()
            @  5, 29 GET znazwa PICTURE "@S40 " + repl( '!', 200 ) valid w1_3z() .AND. v1_3z()
            @  6, 29 GET zADRES PICTURE "@S40 " + repl( '!', 200 ) VALID v1_4z()
            @  7, 29 GET zTRESC VALID v1_5z()
            oGetTRESC := ATail( GetList )
            @  8, 29 GET zUWAGI PICTURE '@K' WHEN w1_21z() VALID v1_21z()
            @  9, 29 GET zDATAS PICTURE '@D' WHEN w1_6s() VALID v1_6z()
            @  9, 56 GET zDATATRAN PICTURE '@D' WHEN w1_7s()
            @ 10, 29 GET zKOREKTA PICTURE '!' VALID zKOREKTA $ 'TN' .AND. v1_8z()
            @  4, 73 GET zRODZDOW PICTURE '!!!!!!' WHEN KRejZWRodzDow() VALID KRejZVRodzDow()
            oGetRodzDow := ATail( GetList )
            @  5, 77 GET zUE PICTURE '!' WHEN wfUE( 5, 78 ) VALID vfUE( 5, 78 )
            @  6, 77 GET zKRAJ PICTURE '!!'
            @  8, 77 GET zTROJSTR PICTURE "!" WHEN zUE == 'T' VALID Valid_RejZ_Trojstr()
            @  9, 77 GET zOPCJE PICTURE '!' WHEN w1_opcje() VALID v1_opcje()
            oGetOPCJE := ATail( GetList )
            @ 10, 77 GET zSEK_CV7 PICTURE '!!' WHEN wfSEK_CV7( 10, 78 ) VALID vfSEK_CV7( 10, 78 )
            oGetSekCV7 := ATail( GetList )
            IF fDETALISTA <> 'T'
               @ 13,  8 GET zWART22 PICTURE FPIC WHEN w1_wartosc( nOrgW22, @zWART22 ) VALID SUMPODz( zWART22, @nOrgW22 )
               oGetWAR22 := ATail( GetList )
               @ 13, 25 GET zVAT22  PICTURE FPIC WHEN SUMPOwz( 'zvat22' ) VALID SUMPODz()
               oGetVAT22 := ATail( GetList )
               @ 14,  8 GET zWART07 PICTURE FPIC WHEN w1_wartosc( nOrgW7, @zWART07 ) VALID SUMPODz( zWART07, @nOrgW7 )
               oGetWAR7 := ATail( GetList )
               @ 14, 25 GET zVAT07  PICTURE FPIC WHEN SUMPOwz( 'zvat07' ) VALID SUMPODz()
               oGetVAT7 := ATail( GetList )
               @ 15,  8 GET zWART02 PICTURE FPIC WHEN w1_wartosc( nOrgW2, @zWART02 ) valid SUMPODz( zWART02, @nOrgW7 )
               oGetWAR2 := ATail( GetList )
               @ 15, 25 GET zVAT02  PICTURE FPIC WHEN SUMPOwz( 'zvat02' ) VALID SUMPODz()
               oGetVAT2 := ATail( GetList )
               @ 16,  8 GET zWART00 PICTURE FPIC VALID SUMPODz()
               @ 17,  8 GET zWARTZW PICTURE FPIC VALID SUMPODz()
               @ 18,  8 GET zWART12 PICTURE FPIC WHEN w1_wartosc( nOrgW12, @zWART12 ) VALID SUMPODz( zWART12, @nOrgW12 )
               oGetWAR12 := ATail( GetList )
               @ 18, 25 GET zVAT12  PICTURE FPIC WHEN SUMPOwz( 'zvat12' ) VALID SUMPODz()
               oGetVAT12 := ATail( GetList )
            ELSE
               @ 13, 42 GET zBRUT22 PICTURE FPIC WHEN w1_wartosc( nOrgW22, @zBRUT22 ) VALID SUMPODzB( zBRUT22, @nOrgW22 )
               oGetWAR22 := ATail( GetList )
               @ 13, 25 GET zVAT22  PICTURE FPIC WHEN SUMPOwzB( 'zvat22' ) VALID SUMPODzB()
               oGetVAT22 := ATail( GetList )
               @ 14, 42 GET zBRUT07 PICTURE FPIC WHEN w1_wartosc( nOrgW7, @zWART07 ) VALID SUMPODzB( zWART07, @nOrgW7 )
               oGetWAR7 := ATail( GetList )
               @ 14, 25 GET zVAT07  PICTURE FPIC WHEN SUMPOwzB( 'zvat07' ) VALID SUMPODzB()
               oGetVAT7 := ATail( GetList )
               @ 15, 42 GET zBRUT02 PICTURE FPIC WHEN w1_wartosc( nOrgW2, @zWART02 ) valid SUMPODzB( zWART02, @nOrgW7 )
               oGetWAR2 := ATail( GetList )
               @ 15, 25 GET zVAT02  PICTURE FPIC WHEN SUMPOwzB( 'zvat02' ) VALID SUMPODzB()
               oGetVAT2 := ATail( GetList )
               @ 16, 42 GET zWART00 PICTURE FPIC VALID SUMPODzB()
               @ 17, 42 GET zWARTZW PICTURE FPIC VALID SUMPODzB()
               @ 18, 42 GET zBRUT12 PICTURE FPIC WHEN w1_wartosc( nOrgW12, @zWART12 ) VALID SUMPODzB( zWART12, @nOrgW12 )
               oGetWAR12 := ATail( GetList )
               @ 18, 25 GET zVAT12  PICTURE FPIC WHEN SUMPOwzB( 'zvat12' ) VALID SUMPODzB()
               oGetVAT12 := ATail( GetList )
            ENDIF
            @ 13, 57 GET zSP22  PICTURE '!' WHEN zWART22 + zVAT22<> 0 .AND. wSP() VALID SP(zSP22)
            @ 13, 61 GET zZOM22 PICTURE '!' WHEN zWART22 + zVAT22<> 0 .AND. wZOM() VALID ZOM(zZOM22)
            @ 14, 57 GET zSP07  PICTURE '!' WHEN zWART07 + zVAT07<> 0 .AND. wSP() VALID SP(zSP07)
            @ 14, 61 GET zZOM07 PICTURE '!' WHEN zWART07 + zVAT07<> 0 .AND. wZOM() VALID ZOM(zZOM07)
            @ 15, 57 GET zSP02  PICTURE '!' WHEN zWART02 + zVAT02<> 0 .AND. wSP() VALID SP(zSP02)
            @ 15, 61 GET zZOM02 PICTURE '!' WHEN zWART02 + zVAT02<> 0 .AND. wZOM() VALID ZOM(zZOM02)
            @ 16, 57 GET zSP00  PICTURE '!' WHEN zWART00 <> 0 .AND. wSP() VALID SP( zSP00 )
            @ 16, 61 GET zZOM00 PICTURE '!' WHEN zWART00 <> 0 .AND. wZOM() VALID ZOM( zZOM00 )
            @ 17, 57 GET zSPZW  PICTURE '!' WHEN zWARTZW <> 0 .AND. wSP() VALID SP( zSPZW )
            @ 18, 57 GET zSP12  PICTURE '!' WHEN zWART12 + zVAT12 <> 0 .AND. wSP() VALID SP( zSP12 )
            @ 18, 61 GET zZOM12 PICTURE '!' WHEN zWART12 + zVAT12 <> 0 .AND. wZOM() VALID ZOM( zZOM12 )
            @ 20, 42 GET zVATMARZA PICTURE FPIC WHEN param_ksv7 == 'T'
            IF zRYCZALT <> 'T'
               @ 21, 14 GET zDATAKS PICTURE '@D' WHEN w1_6kz( zKOREKTA == 'T' ) VALID v1_6kz()
               @ 21, 29 GET zNETTO PICTURE  FPIC WHEN SUMNETz() VALID vSUMNETz()
               @ 21, 47 GET zKOLUMNA PICTURE '99' WHEN wKOLz() VALID vKOLz()
               oGetKOLUMNA := ATail( GetList )
               @ 21, 55 GET zNETTO2 PICTURE  FPIC WHEN zNETTO <> 0 .AND. KRejZWNetto2() VALID vSUMNETz2()
               @ 21, 73 GET zKOLUMNA2 PICTURE '99' WHEN wKOLz2() VALID vKOLz2()
            endif
            @ 22, 16 GET zROZRZAPZ PICTURE '!' WHEN wRejZ_Rozr( zKOREKTA == 'T' .AND. zRYCZALT == 'T' ) VALID vROZRget( 'zROZRZAPZ', 22, 16 )
            @ 22, 36 GET zZAP_TER PICTURE '999' WHEN zROZRZAPZ == 'T'
            @ 22, 41 GET zZAP_DAT PICTURE '@D' WHEN zROZRZAPZ == 'T' .AND. wZAP_DATZ() VALID vZAP_DATZ()
            @ 22, 67 GET zZAP_WART PICTURE FPIC WHEN zROZRZAPZ == 'T' VALID zZAP_WART >= 0.0 .AND. zZAP_WART <= Abs( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 )
            ColStd()
            @ 24,0
            SET COLOR TO
            CLEAR TYPEAHEAD
            SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_RejE
            SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_RejE
            Read_()
            SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_DlgK
            SET KEY K_ALT_F9 TO VAT_Sprawdz_Vies_DlgF
            IF scr_kolumL == .T.
               RestScreen( 7, 40, 20, 79, scr_kolum )
            ENDIF
            IF scr_kolumC == .T.
               RestScreen( 0, 16, 12, 55, scr_sekcv7 )
            ENDIF
            IF LastKey() == K_ESC
               BREAK
            ENDIF
            @ 23, 4 SAY ' '
*              if .not.zaplacono()
*                 break
*              endif

            IF param_kswv == 'T' .AND. ! Empty( zNR_IDENT ) .AND. ( Empty( zKRAJ ) .OR. zKRAJ == 'PL' )
               IF WLApiSzukajNip( zNR_IDENT, zDATAS, @aDaneVAT )
                  IF Upper( xmlWartoscH( aDaneVAT, 'statusVat', '' ) ) <> 'CZYNNY'
                     Komun( "Kontrahent nie jest czynnym pˆatnikiem VAT" )
                  ENDIF
               ENDIF
            ENDIF

            KRejZ_Ksieguj()

         END
         IF &_top_bot
            EXIT
         ELSE
            DO &_proc
         ENDIF
         @ 23, 0
         @ 24, 0

      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == Asc( '.' )
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         BEGIN SEQUENCE
            *-------zamek-------
            IF suma_mc->zamek
               Kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
               BREAK
            ENDIF
            *-------------------
            IF Left( numer, 2 ) == 'S-' .OR. Left( numer, 2 ) == 'R-' .OR. Left( numer, 2 ) == 'F-' .OR. Left( numer, 3 ) == 'KF-' .OR. Left( numer, 3 ) == 'KR-'
               Kom( 4, '*u', ' Symbole S-,F-,R-,KF- i KR- mo&_z.na wykasowa&_c. tylko w opcji FAKTUROWANIE ' )
               BREAK
            ENDIF
            IF ! TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
               BREAK
            ENDIF
            REKZAK := RecNo()
            tresc_ := tresc
            stan_ := NETTO + NETTO2
            Numer_Kas := numer
            Dzien_Kas := dzien
            SELECT tresc
            SEEK '+' + ident_fir + tresc_
            IF Found()
               BlokadaR()
               repl_( 'stan', stan - stan_ )
               COMMIT
               UNLOCK
            ENDIF
            SELECT suma_mc
            SEEK '+' + ident_fir + Str( Month( rejz->DATAKS ), 2 )
            BlokadaR()
            IF Left( rejz->numer, 1 ) # Chr( 1 ) .AND. Left( rejz->numer, 1 ) # Chr( 254 )
               DO CASE
               CASE rejz->KOLUMNA == '10'
                  repl_( 'zakup', zakup - rejz->netto )
               CASE rejz->KOLUMNA == '11'
                  repl_( 'uboczne', uboczne - rejz->netto )
               CASE rejz->KOLUMNA == '12'
                  repl_( 'wynagr_g', wynagr_g - rejz->netto )
               CASE rejz->KOLUMNA == '13' .OR. rejz->KOLUMNA == '16'
                  repl_( 'wydatki', wydatki - rejz->netto )
               ENDCASE
               DO CASE
               CASE rejz->KOLUMNA2 == '10'
                  repl_( 'zakup', zakup - rejz->netto2 )
               CASE rejz->KOLUMNA2 == '11'
                  repl_( 'uboczne', uboczne - rejz->netto2 )
               CASE rejz->KOLUMNA2 == '12'
                  repl_( 'wynagr_g', wynagr_g - rejz->netto2 )
               CASE rejz->KOLUMNA2 == '13' .OR. rejz->KOLUMNA2 == '16'
                  repl_( 'wydatki', wydatki - rejz->netto2 )
               ENDCASE
               IF stan_ <> 0
                  repl_( 'pozycje', pozycje - 1 )
               ENDIF
            ENDIF
            COMMIT
            UNLOCK
            SEEK '+' + ident_fir + miesiac

            ************* ZAPIS REJESTRU DO KSIEGI *******************
            IF zRYCZALT <> 'T'
               SELECT 5
               usebaz := 'OPER'
               DO WHILE ! Dostep( usebaz )
               ENDDO
               SetInd( usebaz )
               SET ORDER TO 5
               SEEK '+' + Str( REKZAK, 5 ) + 'RZ-'
               IF Found()
                  BlokadaR()
                  Del()
                  Commit_()
                  UNLOCK
                  SET ORDER TO 1
                  *********************** lp
                  IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                     IF param_kslp == '3'
                        SET ORDER TO 4
                     ENDIF
                     Blokada()
                     Czekaj()
                     rec := RecNo()
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', lp - 1 )
                        SKIP
                     ENDDO
                     GO rec
                     COMMIT
                     UNLOCK
                     IF param_kslp == '3'
                        SET ORDER TO 1
                     ENDIF
                     @ 24, 0
                  ENDIF
                  *******************************
               ENDIF
            ENDIF
            SELECT rejz
            rrrec := RecNo()
            BlokadaR()
            repl_( 'del', '-' )
            Commit_()
            UNLOCK

            SELECT 5
            DO WHILE ! Dostep( 'ROZR' )
            ENDDO
            SetInd( 'ROZR' )

*              select ROZR
            RozrDel( 'Z', rrrec )
            SELECT rejz

            IF &_bot
               SEEK '+' + ident_fir + miesiac + Dzien_Kas + Numer_Kas
            ENDIF
            IF ! &_bot
               DO &_proc
            ELSE
               krejzRysujTlo()
            ENDIF
         END
         ColStd()
         @ 23, 0
         @ 24, 0

      *################################# SZUKANIE DNIA ############################
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         f10 := '  '
         @ 3, 20 GET f10 PICTURE "99"
         read_()
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
         center( 23, 'þ                 þ' )
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
         ColStd()
         SET CURSOR ON
         @ 19, 35 GET zDZIEN PICTURE '99' VALID zDZIEN == '  ' .OR. ( Val( zDZIEN ) >= 1 .AND. Val( zDZIEN ) <= 31 )
         @ 20, 35 GET zNUMER PICTURE '@S20 ' + repl( '!', 40 )
         @ 21, 35 GET zNAZWA PICTURE '@S20 ' + repl( '!', 100 )
         @ 22, 35 GET zZDARZ PICTURE Replicate( '!', 20 )
         READ
         SET COLOR TO
         SET CURSOR OFF
         REC := RecNo()
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            GO top
            SZUK := "del='+'.and.firma=ident_fir.and.mc=miesiac"
            SEEK '+' + ident_fir + miesiac
            IF AllTrim( zDZIEN ) <> ""
               AA := Str( Val( zDZIEN ), 2 )
               SZUK := SZUK + '.and.DZIEN=AA'
            ENDIF
            IF AllTrim( zNUMER ) <> ""
               aNUMER := AllTrim( zNUMER )
               SZUK := SZUK + '.and.aNUMER$upper(NUMER)'
            ENDIF
            IF AllTrim( zNAZWA ) <> ""
               aNAZWA := AllTrim( zNAZWA )
               SZUK := SZUK + '.and.aNAZWA$upper(NAZWA)'
            ENDIF
            IF AllTrim( zZDARZ ) <> ""
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
                     ColStd()
                     @ 23,0
                     WSZUK := 1
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
               Kom( 3, '*u', ' KONIEC SZUKANIA ' )
            ENDIF
         ENDIF
         RESTORE SCREEN FROM scr_
         GO rec
         DO &_proc
         _disp := .F.

      CASE kl == K_F1
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE pppp[ 18 ]
         *---------------------------------------
         pppp[  1 ] := '                                                            '
         pppp[  2 ] := '   [PgUp/PgDn].......poprzednia/nast©pna strona             '
         pppp[  3 ] := '   [Home/End]........pierwsza/ostatnia pozycja              '
         pppp[  4 ] := '   [Ins].............wpisywanie                             '
         pppp[  5 ] := '   [M]...............modyfikacja pozycji                    '
         pppp[  6 ] := '   [I]...............import z pliku JPK / SaldeoSMART       '
         pppp[  7 ] := '   [W]...............grupowa weryf. stat. VAT               '
         pppp[  8 ] := '   [B]...............przeˆ¥cz wprowadzanie nettem/bruttem   '
         pppp[  9 ] := '   [F]...............wykazywanie dokumentu w dek. IFT-2R    '
         pppp[ 10 ] := '   [K]...............kopiowanie dokumentu                   '
         pppp[ 11 ] := '   [Del].............kasowanie pozycji                      '
         pppp[ 12 ] := '   [F5 ].............kopiowanie dokumentu do bufora         '
         pppp[ 13 ] := '   [Shift+F5]........kopiowanie wsystkich dok. do bufora    '
         pppp[ 14 ] := '   [F6 ].............wstawianie dokumentu z bufora          '
         pppp[ 15 ] := '   [F9 ].............szukanie zˆo¾one                       '
         pppp[ 16 ] := '   [F10].............szukanie dnia                          '
         pppp[ 17 ] := '   [Esc].............wyj˜cie                                '
         pppp[ 18 ] := '                                                            '
         *---------------------------------------
         SET COLOR TO i
         i := 18
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

      CASE kl == K_ALT_F8 .OR. kl == K_ALT_F9
         VAT_Sprzwdz_NIP_Rej()

      CASE kl == Asc( 'W' ) .OR. kl == Asc( 'w' )
         VAT_Sprzwdz_GrpNIP_WLApi( 'rejz', { || &_bot }  )
         SELECT rejz

      CASE kl == Asc( 'F' ) .OR. kl == Asc( 'f' )
         KRejZIFT2()
         DO &_proc
         _disp := .F.

      CASE kl == K_F5
         IF ! docsys()
            aBufRec := RejZ_PobierzDok()
            IF ( nBufRecIdx := Bufor_Dok_Znajdz( 'rejz', id ) ) > 0
               bufor_dok[ 'rejz' ][ nBufRecIdx ] := aBufRec
            ELSE
               AAdd( bufor_dok[ 'rejz' ], aBufRec )
            ENDIF
            Komun( "Dokument zostaˆ skopiowany" )
         ENDIF

      CASE kl == K_SH_F5
         IF TNEsc( , "Czy skopiowa† wszytkie dokumenty do bufora? (Tak/Nie)" )
            nAktRec := RecNo()
            nLicznik := 0
            GO TOP
            SEEK "+" + ident_fir + miesiac
            DO WHILE ! &_bot
               IF ! DocSys( .F. )
                  aBufRec := RejZ_PobierzDok()
                  IF ( nBufRecIdx := Bufor_Dok_Znajdz( 'rejz', id ) ) > 0
                     bufor_dok[ 'rejz' ][ nBufRecIdx ] := aBufRec
                  ELSE
                     AAdd( bufor_dok[ 'rejz' ], aBufRec )
                  ENDIF
                  nLicznik++
               ENDIF
               SKIP
            ENDDO
            dbGoto( nAktRec )
            Komun( "Skopiowano " + AllTrim( Str( nLicznik ) ) + " dokument¢w" )
         ENDIF

      ******************** ENDCASE
      ENDCASE
   ENDDO
   Close_()
   SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_DlgK
   SET KEY K_ALT_F9 TO VAT_Sprawdz_Vies_DlgF
   RETURN

*################################## FUNKCJE #################################
PROCEDURE say1z()
***********************
   krejzRysujTlo()
   CLEAR TYPEAHEAD
   @ 2, 70 SAY iif( fDETALISTA <> 'T', ' netto  ', ' brutto ' )
   SELECT rejz
   SET COLOR TO +w
   @  3, 20 SAY DZIEN
   @  3, 38 SAY SYMB_REJ
   @  3, 59 SAY iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2, 20 ), SubStr( numer, 1, 20 ) )
   @  4, 29 SAY Space( 20 )
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
   @  9, 29 SAY ROKS + '.' + MCS + '.' + DZIENS
   @  9, 56 SAY DToC( DATATRAN )
   @ 10, 29 SAY KOREKTA + iif( KOREKTA == 'T', 'ak', 'ie' )
   @  4, 73 SAY RODZDOW
   @  5, 77 SAY UE + iif( UE == 'T', 'ak', 'ie' )
   @  6, 77 SAY KRAJ
   @  8, 77 SAY iif( TROJSTR == 'T', 'Tak', 'Nie' )
   @  9, 77 SAY OPCJE
   @ 10, 77 SAY SEK_CV7

   sprawdzVAT( 10, CToD( ROKS + '.' + MCS + '.' + DZIENS ) )
   @ 13,  2 SAY Str( vat_A, 2 )
   @ 14,  2 SAY Str( vat_B, 2 )
   @ 15,  2 SAY Str( vat_C, 2 )

   @ 13,  8 SAY WART22 PICTURE RPIC
   @ 14,  8 SAY WART07 PICTURE RPIC
   *@ 16,8  say WART12 pict RPIC
   *@ 17,8  say WART02 pict RPIC
   *@ 18,8  say WART00 pict RPIC
   *@ 19,8  say WARTZW pict RPIC
   @ 15,  8 SAY WART02 PICTURE RPIC
   @ 16,  8 SAY WART00 PICTURE RPIC
   @ 17,  8 SAY WARTZW PICTURE RPIC
   @ 18,  8 SAY WART12 PICTURE RPIC
   @ 13, 25 SAY VAT22 PICTURE RPIC
   @ 14, 25 SAY VAT07 PICTURE RPIC
   *@ 16,25 say VAT12 pict RPIC
   *@ 17,25 say VAT02 pict RPIC
   @ 15, 25 SAY VAT02 PICTURE RPIC
   @ 18, 25 SAY VAT12 PICTURE RPIC
   @ 13, 42 SAY WART22 + VAT22 PICTURE RPIC
   @ 14, 42 SAY WART07 + VAT07 PICTURE RPIC
   *@ 16,42 say WART12+VAT12 pict RPIC
   *@ 17,42 say WART02+VAT02 pict RPIC
   *@ 18,42 say WART00 pict RPIC
   *@ 19,42 say WARTZW pict RPIC
   @ 15, 42 SAY WART02 + VAT02 PICTURE RPIC
   @ 16, 42 SAY WART00 PICTURE RPIC
   @ 17, 42 SAY WARTZW PICTURE RPIC
   @ 18, 42 SAY WART12 + VAT12 PICTURE RPIC
   @ 13, 57 SAY SP22 + iif( SP22 == 'S', 'T ', iif( SP22 == 'P', 'oz', Space( 2 ) ) )
   @ 13, 61 SAY ZOM22 + iif( ZOM22 == 'Z', 'wolni', iif( ZOM22 == 'O', 'podat', iif( ZOM22 == 'M', 'iesza', Space( 5 ) ) ) )
   @ 14, 57 SAY SP07 + iif( SP07 == 'S', 'T ', iif( SP07 == 'P', 'oz', Space( 2 ) ) )
   @ 14, 61 SAY ZOM07 + iif( ZOM07 == 'Z', 'wolni', iif( ZOM07 == 'O', 'podat', iif( ZOM07 == 'M', 'iesza', Space( 5 ) ) ) )
   *@ 16,57 say SP12+iif(SP12='S','T.',iif(SP12='P','oz',space(2)))
   *@ 16,61 say ZOM12+iif(ZOM12='Z','wolni',iif(ZOM12='O','podat',iif(ZOM12='M','iesza',space(5))))
   *@ 17,57 say SP02+iif(SP02='S','T ',iif(SP02='P','oz',space(2)))
   *@ 17,61 say ZOM02+iif(ZOM02='Z','wolni',iif(ZOM02='O','podat',iif(ZOM02='M','iesza',space(5))))
   *@ 18,57 say SP00+iif(SP00='S','T ',iif(SP00='P','oz',space(2)))
   *@ 18,61 say ZOM00+iif(ZOM00='Z','wolni',iif(ZOM00='O','podat',iif(ZOM00='M','iesza',space(5))))
   *@ 19,57 say SPZW+iif(SPZW='S','T ',iif(SPZW='P','oz',space(2)))
   @ 15, 57 SAY SP02 + iif( SP02 == 'S', 'T ', iif( SP02 == 'P', 'oz' ,Space( 2 ) ) )
   @ 15, 61 SAY ZOM02 + iif( ZOM02 == 'Z', 'wolni', iif( ZOM02 == 'O', 'podat', iif( ZOM02 == 'M', 'iesza', Space( 5 ) ) ) )
   @ 16, 57 SAY SP00 + iif( SP00 == 'S', 'T ', iif( SP00 == 'P', 'oz', Space( 2 ) ) )
   @ 16, 61 SAY ZOM00 + iif( ZOM00 == 'Z', 'wolni', iif( ZOM00 == 'O', 'podat', iif( ZOM00 == 'M', 'iesza', Space( 5 ) ) ) )
   @ 17, 57 SAY SPZW + iif( SPZW == 'S', 'T ', iif( SPZW == 'P', 'oz', Space( 2 ) ) )
   @ 18, 57 SAY SP12 + iif( SP12 == 'S', 'T.', iif( SP12 == 'P', 'oz', Space( 2) ) )
   @ 18, 61 SAY ZOM12 + iif( ZOM12 == 'Z', 'wolni', iif( ZOM12 == 'O', 'podat', iif( ZOM12 == 'M', 'iesza', Space( 5 ) ) ) )
//   @ 13, 68 SAY iif( SP22 == 'S' .AND. ZOM22 == 'M', Transform( VAT22 * ( zstrusprob / 100 ), RPIC ), iif( SP22 == 'P' .AND. ZOM22 == 'M', '    zbiorczo', Space( 12 ) ) )
   @ 13, 68 SAY iif( ZOM22 == 'M', Transform( VAT22 * ( zstrusprob / 100 ), RPIC ), Space( 12 ) )
//   @ 15, 68 SAY iif( SP07 == 'S' .AND. ZOM07 == 'M', Transform( VAT07 * ( zstrusprob / 100 ), RPIC ), iif( SP07 == 'P' .AND. ZOM07 == 'M', '    zbiorczo', Space( 12 ) ) )
   @ 14, 68 SAY iif( ZOM07 == 'M', Transform( VAT07 * ( zstrusprob / 100 ), RPIC ), Space( 12 ) )
   *@ 16,68 say iif(SP12='S'.and.ZOM12='M',transform(VAT12*(zstrusprob/100),RPIC),iif(SP12='P'.and.ZOM12='M','    zbiorczo',space(12)))
   *@ 17,68 say iif(SP02='S'.and.ZOM02='M',transform(VAT02*(zstrusprob/100),RPIC),iif(SP02='P'.and.ZOM02='M','    zbiorczo',space(12)))
//   @ 16, 68 SAY iif( SP02 == 'S' .AND. ZOM02 == 'M', Transform( VAT02 * ( zstrusprob / 100 ), RPIC ), iif( SP02 == 'P' .AND. ZOM02 == 'M', '    zbiorczo', Space( 12 ) ) )
   @ 15, 68 SAY iif( ZOM02 == 'M', Transform( VAT02 * ( zstrusprob / 100 ), RPIC ), Space( 12 ) )
//   @ 19, 68 SAY iif( SP12 == 'S' .AND. ZOM12 == 'M', Transform( VAT12 * ( zstrusprob / 100 ), RPIC ), iif( SP12 == 'P' .AND. ZOM12 == 'M', '    zbiorczo', Space( 12 ) ) )
   @ 18, 68 SAY iif( ZOM12 == 'M', Transform( VAT12 * ( zstrusprob / 100 ), RPIC ), Space( 12 ) )
   @ 19,  8 SAY WART22 + WART12 + WART07 + WART02 + WART00 + WARTZW PICTURE RPIC
   @ 19, 25 SAY VAT22 + VAT12 + VAT07 + VAT02 PICTURE RPIC
   @ 19, 42 SAY WART22 + WART12 + WART07 + WART02 + WART00 + WARTZW + VAT22 + VAT12 + VAT07 + VAT02 PICTURE RPIC
   @ 20, 42 SAY VATMARZA PICTURE RPIC
   IF zRYCZALT <> 'T'
      @ 21, 14 SAY DATAKS PICTURE '@D'
      @ 21, 29 SAY NETTO PICTURE RPIC
      @ 21, 47 SAY KOLUMNA PICTURE '99'
      @ 21, 55 SAY NETTO2 PICTURE RPIC
      @ 21, 73 SAY KOLUMNA2 PICTURE '99'
   ENDIF
   *@ 22, 0 say 'Kontrola zaplat....  .................. (..........) ..............             '
   @ 22, 16 SAY ROZRZAPZ + iif( ROZRZAPZ == 'T', 'ak', 'ie' )
   IF ROZRZAPZ == 'T'
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

   IF KOREKTA == 'T' .AND. ( KOL47 <> 0 .OR. KOL48 <> 0 .OR. KOL49 <> 0 .OR. KOL50 <> 0 )
      ColStd()
      @ 14, 40 CLEAR TO 20, 79
      @ 14, 40 TO 20, 79
      @ 15, 42 SAY "Korekta podatku naliczonego"
      @ 16, 42 SAY "K.47 - od naby† ˜r.t.  "
      @ 17, 42 SAY "K.48 - pozost. naby†   "
      @ 18, 42 SAY "K.49 - art. 89b ust. 1 "
      @ 19, 42 SAY "K.50 - art. 89b ust. 4 "
      SET COLOR TO +w
      @ 16, 64 SAY KOL47 PICTURE FPIC
      @ 17, 64 SAY KOL48 PICTURE FPIC
      @ 18, 64 SAY KOL49 PICTURE FPIC
      @ 19, 64 SAY KOL50 PICTURE FPIC
   ENDIF

   IF IFT2 == 'T'
      @ 2, 5 SAY 'IFT-2 (' + AllTrim( IFT2SEK ) + ')'
   ELSE
      ColStd()
      @  2, 5 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   ENDIF

   SET COLOR TO
   RETURN

***************************************************
FUNCTION v1_1z()
   IF zdzien == '  '
      zdzien := Str( Day( Date() ), 2 )
      SET COLOR TO i
      @ 3, 20 SAY zDZIEN
      SET COLOR TO
   ENDIF
   IF Val( zdzien ) < 1 .OR. Val( zdzien ) > msc( Val( miesiac ) )
      zdzien := '  '
      RETURN .F.
   ENDIF

   sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.' + zdzien ) )
   @ 13, 2 SAY Str( vat_A, 2 )
   @ 14, 2 SAY Str( vat_B, 2 )
   @ 15, 2 SAY Str( vat_C, 2 )
   @ 18, 2 SAY Str( vat_D, 2 )

   RETURN .T.

***************************************************

FUNCTION w11_1z()

   cOstSymbRej := zSYMB_REJ

   RETURN .T.

***************************************************
FUNCTION V11_1z()
***************************************************

   IF ins .AND. ( cOstSymbRej <> zSYMB_REJ )
      zRODZDOW := Space( 6 )
      oGetRodzDow:display()
      zOPCJE := ' '
      oGetOpcje:display()
      zSEK_CV7 := '  '
      oGetSekCV7:display()
      IF zRYCZALT <> 'T'
         zKOLUMNA := '  '
         oGetKOLUMNA:display()
      ENDIF
   ENDIF

   SAVE SCREEN TO scr2
   SELECT 7
   DO WHILE ! Dostep( 'KAT_ZAK' )
   ENDDO
   SetInd( 'KAT_ZAK' )
   SEEK '+' + ident_fir + zSYMB_REJ
   IF del # '+' .OR. firma # ident_fir
      SKIP -1
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      Kat_Rej_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER .OR. LastKey() == K_LDBLCLK
         zSYMB_REJ := SYMB_REJ

         IF ins .AND. ( cOstSymbRej <> zSYMB_REJ )
            zRODZDOW := Space( 6 )
            oGetRodzDow:display()
            zOPCJE := ' '
            oGetOpcje:display()
            zSEK_CV7 := '  '
            oGetSekCV7:display()
            IF zRYCZALT <> 'T'
               zKOLUMNA := '  '
               oGetKOLUMNA:display()
            ENDIF
         ENDIF

         IF ins .AND. Empty( zRODZDOW ) .AND. ! Empty( kat_zak->rodzdow ) .AND. kat_zak->firma == ident_fir
            zRODZDOW := kat_zak->rodzdow
            oGetRodzDow:display()
         ENDIF
         IF ins .AND. Empty( zOPCJE ) .AND. ! Empty( kat_zak->opcje ) .AND. kat_zak->firma == ident_fir
            zOPCJE := Left( kat_zak->opcje, 1 )
            oGetOpcje:display()
         ENDIF
         IF ins .AND. Empty( zSEK_CV7 ) .AND. ! Empty( kat_zak->sek_cv7 ) .AND. kat_zak->firma == ident_fir
            zSEK_CV7 := kat_zak->sek_cv7
            oGetSekCV7:display()
         ENDIF
         IF zRYCZALT <> 'T' .AND. ins .AND. Empty( zKOLUMNA ) .AND. ! Empty( kat_zak->kolumna ) .AND. kat_zak->firma == ident_fir
            zKOLUMNA := kat_zak->kolumna
            oGetKOLUMNA:display()
         ENDIF

         SET COLOR TO i
         @ 3, 38 SAY zSYMB_REJ
         SET COLOR TO
      ENDIF
   ENDIF
   USE
   SELECT rejz
   RETURN .T.

***************************************************
FUNCTION V1_2z()
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
   CASE Left( LTrim( znumer ), 3 ) == 'RS-'
      Center( 24, ' Symbol zastrze&_z.ony dla sum z rejestru sprzeda&_z.y ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'RZ-'
      Center( 24, ' Symbol zastrze&_z.ony dla dokument&_o.w z rejestru zakupu ' )
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
      Kom( 4, '*u', ' Symbol dowodu (KR-) jest zastrze&_z.ony dla rachunk&_o.w uproszcz.koryg. ')
      RETURN .F.
   ENDCASE
   EwidSprawdzNrDok( 'REJZ', ident_fir, miesiac, znumer, iif( ins, 0, RecNo() ) )
   *@  3,2 say '   '
   *@  4,2 say 'ÍÍ'+chr(16)
   RETURN .T.

***************************************************
FUNCTION Vv1_3z()
***************************************************

   LOCAL aDane := hb_Hash()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   IF ( ins .AND. Len( AllTrim( znr_ident ) ) > 0 ) .OR. ( ! ins .AND. znr_ident # rejz->nr_ident )
      IF  KontrahZnajdz( znr_ident, @aDane )
         znazwa := Pad( aDane[ 'nazwa' ], 200 )
         zadres := Pad( aDane[ 'adres' ], 200 )
         zexport := aDane[ 'export' ]
         zue := aDane[ 'ue' ]
         zkraj := aDane[ 'kraj' ]
         KEYBOARD Chr( K_ENTER )
      ELSE
         znazwa := Space( 200 )
         zadres := Space( 200 )
         zexport := 'N'
         zUE := 'N'
         ZKRAJ := 'PL'
         SET COLOR TO i
         @ 4, 29 SAY SubStr( zNR_IDENT, 1, 20 )
         @ 5, 29 SAY SubStr( znazwa, 1, 40 )
         @ 6, 29 SAY SubStr( zadres, 1, 40 )
         @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
         @ 6, 77 SAY zKRAJ
         SET COLOR TO
      ENDIF
   ENDIF
/*
   IF Len( AllTrim( znr_ident ) ) # 0
      IF ins
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
            znazwa := Space( 200 )
            zadres := Space( 200 )
            zexport := 'N'
            zUE := 'N'
            ZKRAJ := 'PL'
            SET COLOR TO i
            @ 4, 29 SAY SubStr( zNR_IDENT, 1, 20 )
            @ 5, 29 SAY SubStr( znazwa, 1, 40 )
            @ 6, 29 SAY SubStr( zadres, 1, 40 )
            @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
            @ 6, 77 SAY zKRAJ
            SET COLOR TO
         ENDIF
         SET ORDER TO 1
         SELECT rejz
      ELSE
         IF znr_ident # rejz->nr_ident
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
               znazwa := Space( 200 )
               zadres := Space( 200 )
               zexport := 'N'
               zUE := 'N'
               ZKRAJ := 'PL'
               SET COLOR TO i
               @ 4, 29 SAY SubStr( zNR_IDENT, 1, 20 )
               @ 5, 29 SAY SubStr( znazwa, 1, 40 )
               @ 6, 29 SAY SubStr( zadres, 1, 40 )
               @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
               @ 6, 77 SAY zKRAJ
               SET COLOR TO
            ENDIF
            SET ORDER TO 1
            SELECT rejz
         ENDIF
      ENDIF
   ENDIF
   */

   RETURN .T.

***************************************************
FUNCTION w1_3z()
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
      SEEK '+' + ident_fir + SubStr( zNAZWA, 1, 15 ) + SubStr( zadres, 1, 15 )
      IF del # '+' .OR. firma # ident_fir
         SKIP -1
      ENDIF
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      Kontr_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER .OR. LastKey() == K_LDBLCLK
         KontrahAktualizuj()
         znazwa := nazwa
         zadres := adres
         zNR_IDENT := NR_IDENT
         zExPORT := iif( EXPORT == ' ', 'N', EXPORT )
         zUE := iif( UE == ' ', 'N', UE )
         zKRAJ := iif( KRAJ == '  ', 'PL', KRAJ )
         SET COLOR TO i
         @ 4, 29 SAY SubStr( zNR_IDENT, 1, 20 )
         @ 5, 29 SAY SubStr( znazwa, 1, 40 )
         @ 6, 29 SAY SubStr( zadres, 1, 40 )
         @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
         @ 6, 77 SAY zKRAJ
         SET COLOR TO
         KEYBOARD Chr( K_ENTER )
      ENDIF
   ENDIF
   SELECT rejz
   RETURN .T.

***************************************************
FUNCTION V1_3z() // ta funkcja nic nie robi
***************************************************
   if LastKey() == K_UP
      RETURN .T.
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v1_4z() // ta funkcja nic nie robi

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v1_5z()

   LOCAL cKol := "  "

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   IF Empty( ztresc )
      SELECT tresc
      SEEK '+' + ident_fir
      IF ! Found()
         SELECT rejz
      ELSE
         SAVE SCREEN TO scr2
         Tresc_( "Z" )
         RESTORE SCREEN FROM scr2
         SELECT rejz
         if LastKey() == K_ESC
            RETURN .T.
         ENDIF
         ztresc := Left( tresc->tresc, 30 )
         cKol := tresc->kolumna
         IF tresc->rodzaj == "Z"
            IF ins .AND. Empty( zOPCJE ) .AND. ! Empty( tresc->opcje ) .AND. tresc->firma == ident_fir
               zOPCJE := Left( tresc->opcje, 1 )
               oGetOPCJE:display()
            ENDIF
            IF ins .AND. Empty( zRODZDOW ) .AND. ! Empty( tresc->rodzdow ) .AND. tresc->firma == ident_fir
               zRODZDOW := tresc->rodzdow
               oGetRodzDow:display()
            ENDIF
            IF ins .AND. Empty( zSEK_CV7 ) .AND. ! Empty( tresc->sek_cv7 ) .AND. tresc->firma == ident_fir
               zSEK_CV7 := tresc->sek_cv7
               oGetSekCV7:display()
            ENDIF
         ENDIF
         //@  9,77 say zOPCJE
         SET COLOR TO i
         @ 7, 29 SAY ztresc
         SET COLOR TO
      ENDIF
   ENDIF

   IF ( Empty( zKOLUMNA ) .OR. ins ) .AND. ! Empty( cKol )
      IF AScan( { "10", "11", "12", "13", "16" }, cKol ) > 0
         zKOLUMNA := cKol
      ENDIF
   ENDIF

   RETURN .T.

***************************************************
FUNCTION V1_21z() // ta funkcja nic nie robi
***************************************************
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v1_6z()
***************************************************
   IF ins
      IF paraDATAKS == 'W'
         zDATAKS := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
      ELSE
         zDATAKS := zDATAS
      ENDIF
      @ 21, 14 SAY zDATAKS PICTURE '@D'
   ENDIF

   sprawdzVAT( 10, zDATAS )
   @ 13, 2 SAY Str( vat_A, 2 )
   @ 14, 2 SAY Str( vat_B, 2 )
   @ 15, 2 SAY Str( vat_C, 2 )
   @ 18, 2 SAY Str( vat_D, 2 )

   // to jest niepotrzebne
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION w1_6z()
***************************************************
   IF zDATAS == CToD( '    .  .  ' )
      zDATAS := CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.' + StrTran( zDZIEN, ' ', '0' ) )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION w1_7z()
***************************************************
   IF zDATATRAN == CToD( '    .  .  ' )
      zDATATRAN := CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.' + StrTran( zDZIEN, ' ', '0' ) )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION w1_21z()
***************************************************
   IF ins .AND. Len( AllTrim( zUWAGI ) ) == 0
      zUWAGI := 'datRZ:' + SubStr( param_rok, 3, 2 ) + '.' + StrTran( miesiac, ' ', '0' ) + '.' + StrTran( Str( Val( zDZIEN ), 2, 0 ), ' ', '0' )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v1_6kz()
***************************************************
   IF Str( Year( zDATAKS ), 4 ) <> param_rok .OR. zDATAKS == CToD( '    .  .  ' )
      IF zDATAKS == CToD( '    .  .  ' )
         Kom( 4, '*u', PadC( 'Dokument nie b&_e.dzie zaksi&_e.gowany do ksi&_e.gi', 80)  )
      ELSE
         Kom( 4, '*u', PadC( 'Ksi&_e.gowanie do ksi&_e.gi z innych lat musisz wykona&_c. jako niezale&_z.ne ksi&_e.gowania', 80 ) )
      ENDIF
      zDATAKS := CToD( '    .  .  ' )
      zNETTO := 0
      zKOLUMNA := '  '
   ENDIF

   // to jest nieuzywane
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION w1_6kz( lPokazPolaKor )
***************************************************
   IF HB_ISLOGICAL( lPokazPolaKor ) .AND. lPokazPolaKor
      RejZ_PolaKor()
   ENDIF
   IF Str( Year( zDATAKS ), 4 ) <> param_rok .OR. zDATAKS == CToD( '    .  .  ' )
      IF zDATAKS == CToD( '    .  .  ' )
         Kom( 4, '*u', PadC( 'Dokument nie b&_e.dzie zaksi&_e.gowany do ksi&_e.gi', 80 ) )
      ELSE
         Kom( 4, '*u', PadC( 'Ksi&_e.gowanie do ksi&_e.gi z innych lat musisz wykona&_c. jako niezale&_z.ne ksi&_e.gowania', 80 ) )
      ENDIF
      zDATAKS := ctod( '    .  .  ' )
      zNETTO := 0
      zKOLUMNA := '  '
   ENDIF
   RETURN .T.

***************************************************
FUNCTION V1_8z()
***************************************************
   @ 10, 30 SAY iif( zKOREKTA == 'T', 'ak', 'ie' )
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   RETURN .T.

***************************************************
FUNCTION V1_22z()
***************************************************
   RETURN ZKWOTA > 0

***************************************************
FUNCTION SumPodz( nWartosc, nPole )
***************************************************
   @ 13, 42 SAY zWART22 + zVAT22 + iif( zOPCJE $ "257P", zVAT22, 0 ) PICTURE RPIC
   @ 14, 42 SAY zWART07 + zVAT07 + iif( zOPCJE $ "257P", zVAT07, 0 ) PICTURE RPIC
   *@ 16,42 say zWART12+zVAT12 pict RPIC
   *@ 17,42 say zWART02+zVAT02 pict RPIC
   *@ 18,42 say zWART00 pict RPIC
   *@ 19,42 say zWARTZW pict RPIC
   @ 15, 42 SAY zWART02 + zVAT02 + iif( zOPCJE $ "257P", zVAT02, 0 ) PICTURE RPIC
   @ 16, 42 SAY zWART00 PICTURE RPIC
   @ 17, 42 SAY zWARTZW PICTURE RPIC
   @ 18, 42 SAY zWART12 + zVAT12 + iif( zOPCJE $ "257P", zVAT12, 0 ) PICTURE RPIC
   @ 19,  8 SAY zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW PICTURE RPIC
   @ 19, 25 SAY zVAT22 + zVAT12 + zVAT07 + zVAT02 PICTURE RPIC
   @ 19, 42 SAY ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 + iif( zOPCJE $ "257P", zVAT22 + zVAT12 + zVAT07 + zVAT02, 0 ) ) * iif( zOPCJE == "2", 0.2, iif( zOPCJE == "5", 0.5, iif( zOPCJE == "7", 0.75, 1 ) ) ) PICTURE RPIC
   IF ! Empty( nWartosc )
      nPole := nWartosc
   ENDIF
   RETURN .T.

***************************************************
FUNCTION SumPodzB( nWartosc, nPole )
***************************************************
   @ 13,  8 SAY zBRUT22 - zVAT22 + iif( zOPCJE $ "257P", zVAT22, 0 ) PICTURE RPIC
   @ 14,  8 SAY zBRUT07 - zVAT07 + iif( zOPCJE $ "257P", zVAT07, 0 ) PICTURE RPIC
   *@ 16,42 say zWART12+zVAT12 pict RPIC
   *@ 17,42 say zWART02+zVAT02 pict RPIC
   *@ 18,42 say zWART00 pict RPIC
   *@ 19,42 say zWARTZW pict RPIC
   @ 15,  8 SAY zBRUT02 - zVAT02 + iif( zOPCJE $ "257P", zVAT02, 0 ) PICTURE RPIC
   @ 16,  8 SAY zWART00 PICTURE RPIC
   @ 17,  8 SAY zWARTZW PICTURE RPIC
   @ 18,  8 SAY zBRUT12 - zVAT12 + iif( zOPCJE $ "257P", zVAT12, 0 ) PICTURE RPIC
   @ 19,  8 SAY zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW PICTURE RPIC
   @ 19, 25 SAY zVAT22 + zVAT12 + zVAT07 + zVAT02 PICTURE RPIC
   @ 19, 42 SAY ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 + iif( zOPCJE $ "257P", zVAT22 + zVAT12 + zVAT07 + zVAT02, 0 ) ) * iif( zOPCJE == "2", 0.2, iif( zOPCJE == "5", 0.5, iif( zOPCJE == "7", 0.75, 1 ) ) ) PICTURE RPIC
   IF ! Empty( nWartosc )
      nPole := nWartosc
   ENDIF
   RETURN .T.

***************************************************
FUNCTION SUMPOwz( vari )
***************************************************
   LOCAL bTmp

   IF lBlokuj
      RETURN .T.
   ENDIF
   VV1 := 'WART' + SubStr( vari, 5 )
   VV2 := 'VAT' + SubStr( vari, 5 )
   varim := 'zwart' + SubStr( vari, 5 )
   vvariM := SubStr( variM, 2 )
   &VVARIM := &vv1+&VV2
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
      ENDCASE
      NN := _round( &varim * procvat, 2 )
      &vari := NN - &varim
      IF zOPCJE $ "257P"
         &vari := &vari * 0.5
      ENDIF
   CASE &variM == &vvariM
      &vari := &vvari
   ENDCASE
   RETURN .T.

***************************************************
FUNCTION SUMPOwzB( vari )
***************************************************
   LOCAL bTmp

   IF lBlokuj
      RETURN .T.
   ENDIF
   VV1 := 'WART' + SubStr( vari, 5 )
   VV2 := 'VAT' + SubStr( vari, 5 )
   varim := 'zbrut' + SubStr( vari, 5 )
   vvariM := SubStr( variM, 2 )
   VV3 := 'ZWART' + SubStr( vari, 5 )
   &VVARIM := &vv1+&VV2
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
      ENDCASE
      NN := _round( &varim / procvat, 2 )
      &vari := &varim - NN
      &VV3 := &varim - &vari
      IF zOPCJE $ "257P"
         &vari := &vari * 0.5
         &varim := &VV3 + &vari
      ENDIF
   CASE &variM == &vvariM
      &vari := &vvari
   ENDCASE
   RETURN .T.

*******************************************************
FUNCTION SUMNETz()
*******************************************************

   LOCAL nPopNetto

   IF zDATAKS == CToD( '    .  .  ' )
      zNETTO := 0
      nWartoscNetto := zNETTO
      RETURN .F.
   ELSE
      @ 13, 58 SAY iif( zSP22 == 'S', 'T ', iif( zSP22 == 'P', 'oz', Space( 2 ) ) )
      @ 14, 58 SAY iif( zSP07 == 'S', 'T ', iif( zSP07 == 'P', 'oz', Space( 2 ) ) )
   *  @ 16,58 say iif(zSP12='S','T ',iif(zSP12='P','oz',space(2)))
   *  @ 17,58 say iif(zSP02='S','T ',iif(zSP02='P','oz',space(2)))
   *  @ 18,58 say iif(zSP00='S','T ',iif(zSP00='P','oz',space(2)))
   *  @ 19,58 say iif(zSPZW='S','T ',iif(zSPZW='P','oz',space(2)))
      @ 15, 58 SAY iif( zSP02 == 'S', 'T ', iif( zSP02 == 'P', 'oz', Space( 2 ) ) )
      @ 16, 58 SAY iif( zSP00 == 'S', 'T ', iif( zSP00 == 'P', 'oz', Space( 2 ) ) )
      @ 17, 58 SAY iif( zSPZW == 'S', 'T ', iif( zSPZW == 'P', 'oz', Space( 2 ) ) )
      @ 18, 58 SAY iif( zSP12 == 'S', 'T ', iif( zSP12 == 'P', 'oz', Space( 2 ) ) )
      IF ins
         zNETTO := _round( iif( zSPZW == 'S', 0, zWARTZW ) + ;
            iif( zSP00 == 'S', 0, zWART00 ) + iif( ( zZOM00 == 'Z' .OR. zRACH == 'R' ) .AND. zSP00 == 'P', 0, 0 ) + ;
            iif( zSP07 == 'S', 0, zWART07 * iif( ( zOPCJE $ "257P" .AND. param_ks5v == '2' ), 0.5, 1 ) ) + iif( ( ( zZOM07 == 'Z' .OR. zRACH == 'R' ) .AND. zSP07 == 'P' ) .OR. ( zOPCJE $ "257P" ), zVAT07, 0 ) + ;
            iif( zSP02 == 'S', 0, zWART02 * iif( ( zOPCJE $ "257P" .AND. param_ks5v == '2' ), 0.5, 1 ) ) + iif( ( ( zZOM02 == 'Z' .OR. zRACH == 'R' ) .AND. zSP02 == 'P' ) .OR. ( zOPCJE $ "257P" ), zVAT02, 0 ) + ;
            iif( zSP12 == 'S', 0, zWART12 * iif( ( zOPCJE $ "257P" .AND. param_ks5v == '2' ), 0.5, 1 ) ) + iif( ( ( zZOM12 == 'Z' .OR. zRACH == 'R' ) .AND. zSP12 == 'P' ) .OR. ( zOPCJE $ "257P" ), zVAT12, 0 ) + ;
            iif( zSP22 == 'S', 0, ( zWART22 * iif( ( zOPCJE $ "257P" .AND. param_ks5v == '2' ), 0.5, 1 ) ) + zPALIWA + zPOJAZDY ) + iif( ( ( zZOM22 == 'Z' .OR. zRACH == 'R' ) .AND. zSP22 == 'P') .OR. ( zOPCJE $ "257P" ), zVAT22, 0 ), 2 )
         IF zOPCJE == "2"
            zNETTO := zNETTO * 0.2
         ELSEIF zOPCJE == "5"
            zNETTO := zNETTO * 0.5
         ELSEIF zOPCJE == "7"
            zNETTO := zNETTO * 0.75
         ENDIF
         IF zVATMARZA <> 0 .AND. zNETTO == 0 .AND. Month( zDATAS ) == Val( miesiac ) .AND. Year( zDATAS ) == Val( param_rok )
            zNETTO := zVATMARZA
         ENDIF
         nWartoscNetto := zNETTO
      ELSE
         IF zNETTO <> 0
            nPopNetto := zNETTO
            zNETTO := _round( iif( zSPZW == 'S', 0, zWARTZW ) + ;
               iif( zSP00 == 'S', 0, zWART00 ) + iif( ( zZOM00 == 'Z' .OR. zRACH == 'R' ) .AND. zSP00 == 'P', 0, 0 ) + ;
               iif( zSP07 == 'S', 0, zWART07 * iif( ( zOPCJE $ "257P" .AND. param_ks5v == '2' ), 0.5, 1 ) ) + iif( ( ( zZOM07 == 'Z' .OR. zRACH == 'R' ) .AND. zSP07 == 'P' ) .OR. ( zOPCJE $ "257P" ), zVAT07, 0 ) + ;
               iif( zSP02 == 'S', 0, zWART02 * iif( ( zOPCJE $ "257P" .AND. param_ks5v == '2' ), 0.5, 1 ) ) + iif( ( ( zZOM02 == 'Z' .OR. zRACH == 'R' ) .AND. zSP02 == 'P' ) .OR. ( zOPCJE $ "257P" ), zVAT02, 0 ) + ;
               iif( zSP12 == 'S', 0, zWART12 * iif( ( zOPCJE $ "257P" .AND. param_ks5v == '2' ), 0.5, 1 ) ) + iif( ( ( zZOM12 == 'Z' .OR. zRACH == 'R' ) .AND. zSP12 == 'P' ) .OR. ( zOPCJE $ "257P" ), zVAT12, 0 ) + ;
               iif( zSP22 == 'S', 0, ( zWART22 * iif( ( zOPCJE $ "257P" .AND. param_ks5v == '2' ), 0.5, 1 ) ) + zPALIWA + zPOJAZDY ) + iif( ( ( zZOM22 == 'Z' .OR. zRACH == 'R' ) .AND. zSP22 == 'P') .OR. ( zOPCJE $ "257P" ), zVAT22, 0 ), 2 )
            IF zOPCJE == "2"
               zNETTO := zNETTO * 0.2
            ELSEIF zOPCJE == "5"
               zNETTO := zNETTO * 0.5
            ELSEIF zOPCJE == "7"
               zNETTO := zNETTO * 0.75
            ENDIF
            IF zVATMARZA <> 0 .AND. ( zNETTO == 0 .OR. zNETTO == NETTO ) .AND. Month( zDATAS ) == Val( miesiac ) .AND. Year( zDATAS ) == Val( param_rok )
               zNETTO := zVATMARZA
            ENDIF
            IF zNETTO == 0 .AND. nPopNetto <> 0
               zNETTO := nPopNetto
            ENDIF
         ENDIF
         nWartoscNetto := zNETTO
      ENDIF
   ENDIF
   RETURN .T.

*******************************************************
FUNCTION vSUMNETz()
*******************************************************
   IF zNETTO == 0
      zKOLUMNA := '  '
   ENDIF
   RETURN .T.

*******************************************************
FUNCTION vSUMNETz2()
*******************************************************
   IF zNETTO2 == 0
      zKOLUMNA2 := '  '
   ENDIF
   RETURN .T.

*******************************************************
FUNCTION vKOLz()
*******************************************************
   LOCAL oGOpis

   R := .F.
   IF ( zKOLUMNA <> '10' .AND. zKOLUMNA <> '11' .AND. zKOLUMNA <> '12' .AND. zKOLUMNA <> '13' .AND. zKOLUMNA <> '15' .AND. zKOLUMNA <> '16' ) == .T.
      R := .F.
   ELSE
      RestScreen( 7, 40, 20, 79, scr_kolum )
   *   rest screen from scr_kolum
      IF zKOLUMNA == '16'
         scr_kolum := SaveScreen( 13, 23, 15, 54 )
         @ 13, 23 CLEAR TO 15, 54
         @ 13, 23 TO 15, 54
         @ 13, 24 SAY 'Opis kosztu dziaˆal. badawczej'
         //@ 12, 24 GET zK16OPIS PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
         oGOpis := GetNew( 14, 24, , 'zK16OPIS', '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' )
         CLEAR TYPEAHEAD
         //read_()
         ReadModal( { oGOpis } )
         RestScreen( 13, 23, 15, 54, scr_kolum )
      ENDIF
      R := .T.
   ENDIF
   RETURN R

*******************************************************
FUNCTION vKOLz2()
*******************************************************
   LOCAL oGOpis

   R := .F.
   IF ( ( zKOLUMNA2 <> '10' .AND. zKOLUMNA2 <> '11' .AND. zKOLUMNA2 <> '12' .AND. zKOLUMNA2 <> '13' .AND. zKOLUMNA2 <> '15' .AND. zKOLUMNA2 <> '16' ) == .T. ) .OR. zKOLUMNA == zKOLUMNA2
      R := .F.
   ELSE
      RestScreen( 7, 40, 20, 79, scr_kolum )
   *   rest screen from scr_kolum
      IF zKOLUMNA2 == '16'
         scr_kolum := SaveScreen( 13, 23, 15, 54 )
         @ 13, 23 CLEAR TO 15, 54
         @ 13, 23 TO 15, 54
         @ 13, 24 SAY 'Opis kosztu dziaˆal. badawczej'
         //@ 12, 24 GET zK16OPIS PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
         oGOpis := GetNew( 14, 24, , 'zK16OPIS', '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' )
         CLEAR TYPEAHEAD
         //read_()
         ReadModal( { oGOpis } )
         RestScreen( 13, 23, 15, 54, scr_kolum )
      ENDIF
      R := .T.
   ENDIF
   RETURN R

*******************************************************
FUNCTION wKOLz()
*******************************************************
   IF zNETTO == 0
      scr_kolumL := .F.
      RETURN .F.
   ELSE
      scr_kolum := SaveScreen( 7, 40, 20, 79 )
      scr_kolumL := .T.
      ColInf()
      @ 11, 40 CLEAR TO 20, 79
      @ 11, 40 TO 20,79
      @ 12, 41 SAY PadC( 'Wpisz kolumne ksiegi:', 28 )
      @ 13, 41 SAY '10 - zakup towarow i materialow       '
      @ 14, 41 SAY '11 - koszty uboczne zakupu            '
      @ 15, 41 SAY '12 - wynagrodzenia w gotowce i naturze'
      @ 16, 41 SAY '13 - pozostale koszty                 '
      @ 17, 41 SAY '15 - (kolumna wolna)                  '
      @ 18, 41 SAY '16 - koszty dziaˆalno˜ci badawczej    '
      @ 19, 41 SAY '======================================'
      ColStd()
   ENDIF
   RETURN .T.

*******************************************************
FUNCTION wKOLz2()
*******************************************************
   IF zNETTO2 == 0
      scr_kolumL := .F.
      RETURN .F.
   ELSE
      scr_kolum := SaveScreen( 7, 40, 20, 79 )
      scr_kolumL := .T.
      ColInf()
      @ 11, 40 CLEAR TO 20, 79
      @ 11, 40 TO 20,79
      @ 12, 41 SAY PadC( 'Wpisz kolumne ksiegi:', 28 )
      @ 13, 41 SAY '10 - zakup towarow i materialow       '
      @ 14, 41 SAY '11 - koszty uboczne zakupu            '
      @ 15, 41 SAY '12 - wynagrodzenia w gotowce i naturze'
      @ 16, 41 SAY '13 - pozostale koszty                 '
      @ 17, 41 SAY '15 - (kolumna wolna)                  '
      @ 18, 41 SAY '16 - koszty dziaˆalno˜ci badawczej    '
      @ 19, 41 SAY '======================================'
      ColStd()
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION KRejZWNetto2()

   IF zNETTO <> 0 .AND. nWartoscNetto <> 0 .AND. zNETTO <> nWartoscNetto
      zNETTO2 := nWartoscNetto - zNETTO
   ENDIF

   RETURN .T.

/*----------------------------------------------------------------------*/

*******************************************************
FUNCTION vfSEK_CV7()
*******************************************************

   LOCAL R

   IF ( R := AScan( { '  ', 'WT', 'IT', 'IU', 'PN', 'WS', 'WZ', 'PZ', 'PS', ;
      'SP', 'IZ', 'IS', 'UZ', 'US' }, zSEK_CV7 ) > 0 )
      RestScreen( 0, 16, 16, 55, scr_sekcv7 )
   ENDIF

   RETURN R

*******************************************************
FUNCTION wfSEK_CV7()
*******************************************************
   scr_sekcv7 := SaveScreen( 0, 16, 12, 55 )
   scr_kolumC := .T.
   ColInf()
   @  0, 16 CLEAR TO 16, 55
   @  0, 16 TO 16, 55
   @  1, 17 SAY PadC( 'Podaj sekcje deklaracji VAT-7:', 30 )
   @  2, 17 SAY '   - dwie spacje - zadne z ponizszych '
   @  3, 17 SAY 'WT - wewnatrzwspolnotowe nabycie tow. '
   @  4, 17 SAY 'WZ - WNT tylko podatek naliczony      '
   @  5, 17 SAY 'WS - WNT tylko podatek nale¾ny        '
   @  6, 17 SAY 'IT - import towarow (art.33a ustawy)  '
   @  7, 17 SAY 'IZ - import tow.(tylko pod. naliczony)'
   @  8, 17 SAY 'IS - import tow.(tylko pod. nale¾ny)  '
   @  9, 17 SAY 'IU - import uslug                     '
   @ 10, 17 SAY 'UZ - import usl.(tylko pod. naliczony)'
   @ 11, 17 SAY 'US - import usl.(tylko pod. nale¾ny)  '
   @ 12, 17 SAY 'PN - dostawa tow.(podatnikiem nabywca)'
   @ 13, 17 SAY 'PZ - podat.nab. (tylko pod. naliczony)'
   @ 14, 17 SAY 'PS - podat.nab. (tylko pod. nale¾ny)  '
   @ 15, 17 SAY 'SP - mechanizm podzielonej pˆatno˜ci  '
   ColStd()
   RETURN .T.

*******************************************************
FUNCTION SP( VSP )
*******************************************************
   IF VSP <> 'S' .AND. VSP <> 'P'
      Kom( 4, '*u', PadC( 'Wprowad&_x.:   S-zakup &_s.rodka trwa&_l.ego   lub   P-pozosta&_l.e zakupy', 80 ) )
      RETURN .F.
   ELSE
      @ 24, 0
   ENDIF
   @ 13, 58 SAY iif( zSP22 == 'S', 'T ', iif( zSP22 == 'P', 'oz', Space( 2 ) ) )
   @ 14, 58 SAY iif( zSP07 == 'S', 'T ', iif( zSP07 == 'P', 'oz', Space( 2 ) ) )
   *@ 16,58 say iif(zSP12='S','T ',iif(zSP12='P','oz',space(2)))
   *@ 17,58 say iif(zSP02='S','T ',iif(zSP02='P','oz',space(2)))
   *@ 18,58 say iif(zSP00='S','T ',iif(zSP00='P','oz',space(2)))
   *@ 19,58 say iif(zSPZW='S','T ',iif(zSPZW='P','oz',space(2)))
   @ 15, 58 SAY iif( zSP02 == 'S', 'T ', iif( zSP02 == 'P', 'oz', Space( 2 ) ) )
   @ 16, 58 SAY iif( zSP00 == 'S', 'T ', iif( zSP00 == 'P', 'oz', Space( 2 ) ) )
   @ 17, 58 SAY iif( zSPZW == 'S', 'T ', iif( zSPZW == 'P', 'oz', Space( 2 ) ) )
   @ 18, 58 SAY iif( zSP12 == 'S', 'T ', iif( zSP12 == 'P', 'oz', Space( 2 ) ) )
   SET COLOR TO +w
   @ 13, 68 SAY iif( zSP22 == 'S' .AND. zZOM22 == 'M', Transform( zVAT22 * ( zstrusprob / 100 ), RPIC ), iif( zSP22 == 'P' .AND. zZOM22 == 'M', '    zbiorczo', Space( 12 ) ) )
   @ 14, 68 SAY iif( zSP07 == 'S' .AND. zZOM07 == 'M', Transform( zVAT07 * ( zstrusprob / 100 ), RPIC ), iif( zSP07 == 'P' .AND. zZOM07 == 'M', '    zbiorczo', Space( 12 ) ) )
   *@ 16,68 say iif(zSP12='S'.and.zZOM12='M',transform(zVAT12*(zstrusprob/100),RPIC),iif(zSP12='P'.and.zZOM12='M','    zbiorczo',space(12)))
   *@ 17,68 say iif(zSP02='S'.and.zZOM02='M',transform(zVAT02*(zstrusprob/100),RPIC),iif(zSP02='P'.and.zZOM02='M','    zbiorczo',space(12)))
   @ 15, 68 SAY iif( zSP02 == 'S' .AND. zZOM02 == 'M', Transform( zVAT02 * ( zstrusprob / 100 ), RPIC ), iif( zSP02 == 'P' .AND. zZOM02 == 'M', '    zbiorczo', Space( 12 ) ) )
   @ 18, 68 SAY iif( zSP12 == 'S' .AND. zZOM12 == 'M', Transform( zVAT12 * ( zstrusprob / 100 ), RPIC ), iif( zSP12 == 'P' .AND. zZOM12 == 'M', '    zbiorczo', Space( 12 ) ) )
   ColStd()
   RETURN .T.

*******************************************************
FUNCTION ZOM( VZOM )
*******************************************************
   IF VZOM <> 'Z' .AND. VZOM <> 'O' .AND. VZOM <> 'M'
      Kom( 4, '*u', PadC( 'ZAKUPY   Z-bez odlicze&_n.,  O-do sprzeda&_z.y opodatkowanej  lub  M-mieszanej', 80 ) )
      RETURN .F.
   ENDIF
   @ 13, 62 SAY iif( zZOM22 == 'Z', 'wolni', iif( zZOM22 == 'O', 'podat', iif( zZOM22 == 'M', 'iesza', Space( 5 ) ) ) )
   @ 14, 62 SAY iif( zZOM07 == 'Z', 'wolni', iif( zZOM07 == 'O', 'podat', iif( zZOM07 == 'M', 'iesza', Space( 5 ) ) ) )
   *@ 16,62 say iif(zZOM12='Z','wolni',iif(zZOM12='O','podat',iif(zZOM12='M','iesza',space(5))))
   *@ 17,62 say iif(zZOM02='Z','wolni',iif(zZOM02='O','podat',iif(zZOM02='M','iesza',space(5))))
   *@ 18,62 say iif(zZOM00='Z','wolni',iif(zZOM00='O','podat',iif(zZOM00='M','iesza',space(5))))
   @ 15, 62 SAY iif( zZOM02 == 'Z', 'wolni', iif( zZOM02 == 'O', 'podat', iif( zZOM02 == 'M', 'iesza', Space( 5 ) ) ) )
   @ 16, 62 SAY iif( zZOM00 == 'Z', 'wolni', iif( zZOM00 == 'O', 'podat', iif( zZOM00 == 'M', 'iesza', Space( 5 ) ) ) )
   @ 18, 62 SAY iif( zZOM12 == 'Z', 'wolni', iif( zZOM12 == 'O', 'podat', iif( zZOM12 == 'M', 'iesza', Space( 5 ) ) ) )
   SET COLO TO +w
   @ 13, 68 SAY iif( zSP22 == 'S' .AND. zZOM22 == 'M', Transform( zVAT22 * ( zstrusprob / 100 ), RPIC ), iif( zSP22 == 'P' .AND. zZOM22 == 'M', '    zbiorczo', Space( 12 ) ) )
   @ 14, 68 SAY iif( zSP07 == 'S' .AND. zZOM07 == 'M', Transform( zVAT07 * ( zstrusprob / 100 ), RPIC ), iif( zSP07 == 'P' .AND. zZOM07 == 'M', '    zbiorczo', Space( 12 ) ) )
   *@ 16,68 say iif(zSP12='S'.and.zZOM12='M',transform(zVAT12*(zstrusprob/100),RPIC),iif(zSP12='P'.and.zZOM12='M','    zbiorczo',space(12)))
   *@ 17,68 say iif(zSP02='S'.and.zZOM02='M',transform(zVAT02*(zstrusprob/100),RPIC),iif(zSP02='P'.and.zZOM02='M','    zbiorczo',space(12)))
   @ 15, 68 SAY iif( zSP02 == 'S' .AND. zZOM02 == 'M', Transform( zVAT02 * ( zstrusprob / 100 ), RPIC ), iif( zSP02 == 'P' .AND. zZOM02 == 'M', '    zbiorczo', Space( 12 ) ) )
   @ 18, 68 SAY iif( zSP12 == 'S' .AND. zZOM12 == 'M', Transform( zVAT12 * ( zstrusprob / 100 ), RPIC ), iif( zSP12 == 'P' .AND. zZOM12 == 'M', '    zbiorczo', Space( 12 ) ) )
   ColStd()
   @ 24, 0
   RETURN .T.


/*----------------------------------------------------------------------*/

PROCEDURE RejZ_PolaKor()

   LOCAL GetList := {}
   LOCAL cEkran
   LOCAL cKolor := ColStd()

   cEkran := SaveScreen()
   @ 14, 40 CLEAR TO 20, 79
   @ 14, 40 TO 20, 79
   @ 15, 42 SAY "Korekta podatku naliczonego"
   @ 16, 42 SAY "K.44 - od naby† ˜r.t.  " GET zKOL47 PICTURE FPIC
   @ 17, 42 SAY "K.45 - pozost. naby†   " GET zKOL48 PICTURE FPIC
   @ 18, 42 SAY "K.46 - art. 89b ust. 1 " GET zKOL49 PICTURE FPIC
   @ 19, 42 SAY "K.47 - art. 89b ust. 4 " GET zKOL50 PICTURE FPIC
   READ

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION wRejZ_Rozr( lPokazPolaKor )
   IF HB_ISLOGICAL( lPokazPolaKor ) .AND. lPokazPolaKor
      RejZ_PolaKor()
   ENDIF
   RETURN wROZRget()

/*----------------------------------------------------------------------*/

*************************************
FUNCTION wSP()
*************************************
   ColInf()
   @ 24, 0 SAY PadC( 'Wprowad&_x.:   S-zakup &_s.rodka trwa&_l.ego   lub   P-pozosta&_l.e zakupy', 80, ' ' )
   ColStd()
   RETURN .T.

*************************************
FUNCTION wZOM()
*************************************
   ColInf()
   @ 24, 0 SAY PadC( 'ZAKUPY   Z-bez odlicze&_n.,  O-do sprzeda&_z.y opodatkowanej  lub  M-mieszanej', 80, ' ' )
   ColStd()
   RETURN .T.

***************************************************
FUNCTION wfuslugaUE( x, y )

   ColInf()
   @ 24, 0 SAY PadC( 'Czy zakup traktowa&_c. jako import us&_l.ug: T-tak   lub   N-nie', 80, ' ' )
   ColStd()
   @ x, y SAY iif( zuslugaUE == 'T', 'ak', 'ie' )
   RETURN .T.

***************************************************
FUNCTION vfuslugaUE( x, y )

   R := .F.
   IF zuslugaUE $ 'TN'
      ColStd()
      @ x, y SAY iif( zuslugaUE == 'T', 'ak', 'ie' )
      @ 24, 0
      R := .T.
   ENDIF
   RETURN R

***************************************************
FUNCTION wfwewdos( x, y )

   ColInf()
   @ 24, 0 SAY PadC( 'Czy zakup traktowa&_c. jako dostawa wewn&_e.trzna: T-tak   lub   N-nie', 80, ' ' )
   ColStd()
   @ x, y SAY iif( zwewdos == 'T', 'ak', 'ie' )
   RETURN .T.

***************************************************
FUNCTION vfwewdos( x, y )

   R := .F.
   IF zwewdos $ 'TN'
      ColStd()
      @ x, y SAY iif( zwewdos == 'T', 'ak', 'ie' )
      @ 24, 0
      R := .T.
   ENDIF
   RETURN R

*############################################################################
FUNCTION wZAP_DATZ()

   zZAP_DAT := zDATAS + zZAP_TER
   RETURN .T.
*                 zZAP_DAT=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')

***************************************************
FUNCTION vZAP_DATZ()

   zZAP_TER := zZAP_DAT - zDATAS
   RETURN .T.
*                 zZAP_DAT=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')

FUNCTION krejzRysujTlo()
   ColStd()
   @  3, 0 SAY 'Do rej. na dzieä....     Symbol rej...     Nr dowodu ksi©g...                   '
   @  4, 0 SAY 'KONTRAH: Nr identyfik. (NIP).                              Rodzaj dowodu:       '
   @  5, 0 SAY '         Nazwa...............                                             UE:   '
   @  6, 0 SAY '         Adres...............                                           Kraj:   '
   @  7, 0 SAY 'Opis zdarzenia gospodarczego.                                                   '
   @  8, 0 SAY 'Uwagi........................                         Transakcja tr¢jstronna:   '
   @  9, 0 SAY 'Data zakupu....(rrrr.mm.dd)..           Data wpˆywu.....               Opcje:   '
   @ 10, 0 SAY 'Korekta ?....................                            Pola sekcji C VAT-7:   '
   @ 11, 0 SAY ' -------------------------------------------------------------------------------'
   @ 12, 0 SAY '           N E T T O         V A T          B R U T T O  ZAK DO SPR VATwgStrSprz'
   @ 13, 0 SAY '  ' + Str( vat_A, 2 ) + '%                                                                           '
   @ 14, 0 SAY '  ' + Str( vat_B, 2 ) + '%                                                                           '
   @ 15, 0 SAY '  ' + Str( vat_C, 2 ) + '%                                                                           '
   @ 16, 0 SAY '   0%                                                                           '
   @ 17, 0 SAY '  ZW                                                                            '
   @ 18, 0 SAY '  ' + Str( vat_D, 2 ) + '%                                                                           '
   @ 19, 0 SAY 'RAZEM                                                                           '
   @ 20, 0 SAY '                              Zakup mar¾a                                       '
   IF zRYCZALT == 'T'
      @ 21, 0 SAY Space( 80 )
   ELSE
   *  @ 21, 0 say 'Zaksieg.               zl. Dzien ksiegi            Kolumna (10,11,12,13,14) ?.  '
      @ 21, 0 SAY 'Do ks.: dzien             kw.              Kol.   | kw.              Kol.       '
   ENDIF
   @ 22, 0 SAY 'Kontrola zaplat....  Termin zaplaty.... (..........) Juz zaplacono.             '
   @ 23, 0 SAY '                                                                                '
   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION w1_opcje()

   ColInf()
   @ 24, 0 SAY PadC( 'Opcje:  P - pojazdy 100%, 7 - poj.75%, 5 - poj.50%, 2 - poj.20% lub puste - inne', 80, ' ' )
   ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION v1_opcje()

   LOCAL lResult := zOPCJE $ " 257P"

   IF lResult
      ColStd()
      @ 24, 0
   ENDIF
   RETURN lResult

/*----------------------------------------------------------------------*/

FUNCTION w1_wartosc( nWartoscOrg, nZmiennaWart )

   IF lBlokuj
      RETURN .T.
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION Valid_RejZ_Trojstr()

   LOCAL lRes := zTROJSTR $ 'NT'

   IF lRes
      ColStd()
      @ 8, 78 SAY iif( zTROJSTR == 'T', 'ak', 'ie' )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION KRejZWRodzDow()

   IF param_ksv7 <> 'T'
      RETURN .F.
   ENDIF

   cScrRodzDow := SaveScreen( 5, 40, 11, 79 )

   ColInf()
   @  5, 40 CLEAR TO 11, 79
   @  5, 40 TO 11, 79
   @  6, 41 SAY PadC( 'Podaj rodzaj dowodu sprzeda¾y:', 30 )
   @  7, 41 SAY '    - spacje - ¾adne z poni¾szych     '
   @  8, 41 SAY 'MK  - Metoda kasowa rozliczeä art. 21 '
   @  9, 41 SAY 'VAT_RR - Faktura VAT RR, art. 116     '
   @ 10, 41 SAY 'WEW - Dokument wewn©trzny             '
   ColStd()

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION KRejZVRodzDow()

   LOCAL lRes

   IF ( lRes := AScan( { "MK", "VAT_RR", "WEW", "" }, AllTrim( zRODZDOW ) ) > 0 )
      RestScreen(  5, 40, 11, 79, cScrRodzDow )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

PROCEDURE KRejZ_Ksieguj()

   znumer := dos_l( znumer )
   zdzien := Str( Val( zDZIEN ), 2 )
   *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
   tresc_ := tresc
   KontrApp()
   WrocStan()
   SEEK '+' + ident_fir + ztresc
   IF Found()
      BlokadaR()
      AKTPOL+ stan WITH zNETTO + zNETTO2
      COMMIT
      UNLOCK
   ENDIF
   IF zRYCZALT <> 'T'
      SELECT suma_mc
      *******************************
      SEEK '+' + ident_fir + Str( Month( rejz->DATAKS ), 2 )
      IF ! ins .AND. Left( rejz->numer, 1 ) # Chr( 1 ) .AND. Left( rejz->numer, 1 ) # Chr( 254 )
         BlokadaR()
         AktKol( -1, rejz->KOLUMNA, rejz->NETTO )
         AktKol( -1, rejz->KOLUMNA2, rejz->NETTO2 )
      ENDIF
      SEEK '+' + ident_fir + Str( Month( zDATAKS ), 2 )
      IF RTrim( znumer ) # 'REM-P' .AND. RTrim( znumer ) # 'REM-K'
         BlokadaR()
         AktKol( 1, zKOLUMNA, zNETTO )
         AktKol( 1, zKOLUMNA2, zNETTO2 )
      ENDIF
      COMMIT
      UNLOCK
      SEEK '+' + ident_fir + miesiac
   ENDIF
   SELECT rejz
   IfIns( 0 )
   BlokadaR()
   IF ! ins
      zDATAKS_OLD := DATAKS
   ELSE
      zDATAKS_OLD := zDATAKS
   ENDIF
   ADDPOZ
   ADDREJZ
   repl_( 'SPZW', iif( zWARTZW <> 0,zSPZW, ' ') )
   repl_( 'SP00', iif( zWART00 <> 0,zSP00, ' ') )
   repl_( 'SP02', iif( zWART02 + zVAT02 <> 0, zSP02, ' ') )
   repl_( 'SP07', iif( zWART07 + zVAT07 <> 0, zSP07, ' ') )
   repl_( 'SP22', iif( zWART22 + zVAT22 <> 0, zSP22, ' ') )
   repl_( 'SP12', iif( zWART12 + zVAT12 <> 0, zSP12, ' ') )
   repl_( 'ZOM02', iif( zWART02 + zVAT02 <> 0, zZOM02, ' ') )
   repl_( 'ZOM07', iif( zWART07 + zVAT07 <> 0, zZOM07, ' ') )
   repl_( 'ZOM22', iif( zWART22 + zVAT22 <> 0, zZOM22, ' ') )
   repl_( 'ZOM12', iif( zWART12 + zVAT12 <> 0, zZOM12, ' ') )
   repl_( 'ZOM00', iif( zWART00 <> 0, zZOM00, ' ') )
   repl_( 'NETTO', zNETTO )
   repl_( 'KOLUMNA', zKOLUMNA )
   repl_( 'TROJSTR', zTROJSTR )
   repl_( 'KOL47', zKOL47 )
   repl_( 'KOL48', zKOL48 )
   repl_( 'KOL49', zKOL49 )
   repl_( 'KOL50', zKOL50 )
   repl_( 'NETTO2', zNETTO2 )
   repl_( 'KOLUMNA2', zKOLUMNA2 )

   COMMIT
   UNLOCK
   REKZAK := RecNo()

   *para fZRODLO,fJAKIDOK,fNIP,fNRDOK,fDATAKS,fDATADOK,fTERMIN,fDNIPLAT,fRECNO,fKWOTA,fTRESC,fKWOTAVAT
   * JAKIDOK: FS i FZ (faktury zakupu i sprzedazy), ZS i ZZ (zaplaty za sprzedaz i zakupy)

   SELECT 5
   DO WHILE ! Dostep( 'ROZR' )
   ENDDO
   SetInd( 'ROZR' )

   SELECT rozr
   IF ins
      IF zROZRZAPZ == 'T'
         dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
         IF ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
            RozrApp( 'Z', 'FZ', zNR_IDENT, zNUMER, dddat, zDATAS, zZAP_DAT, zZAP_TER, REKZAK, ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
         ENDIF
         IF zZAP_WART > 0.0
            RozrApp( 'Z', 'ZZ', zNR_IDENT, zNUMER, dddat, zDATAS, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
         ENDIF
      ENDIF
   ELSE
      SET ORDER TO 2
      SEEK ident_fir + param_rok + 'Z' + Str( REKZAK, 10 )
      IF Found()
         IF zROZRZAPZ == 'T'
            SELECT rozr
            RozrDel( 'Z', REKZAK )
            dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
            IF ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
               RozrApp( 'Z', 'FZ', zNR_IDENT, zNUMER, dddat, zDATAS, zZAP_DAT, zZAP_TER, REKZAK, ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
            ENDIF
            IF zZAP_WART > 0.0
               RozrApp( 'Z', 'ZZ', zNR_IDENT, zNUMER, dddat, zDATAS, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
            ENDIF
         ELSE
            SELECT rozr
            RozrDel( 'Z', REKZAK )
         ENDIF
      ELSE
         IF zROZRZAPZ == 'T'
            SELECT rozr
            RozrDel( 'Z', REKZAK )
            dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
            IF ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
               RozrApp( 'Z', 'FZ', zNR_IDENT, zNUMER, dddat, zDATAS, zZAP_DAT, zZAP_TER, REKZAK, ( zWART22 + zWART12 + zWART07 + zWART02 + zWART00 + zWARTZW + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
            ENDIF
            IF zZAP_WART > 0.0
               RozrApp( 'Z', 'ZZ', zNR_IDENT, zNUMER, dddat, zDATAS, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
            ENDIF
         ENDIF
      ENDIF
   ENDIF

   ************* ZAPIS REJESTRU DO KSIEGI *******************
   IF zRYCZALT <> 'T'
      SELECT 5
      usebaz := 'OPER'
      DO WHILE ! Dostep( usebaz )
      ENDDO
      SetInd( usebaz )
      IF ! ins
         DO CASE
         CASE stan_ <> 0
            SET ORDER TO 5
            SEEK '+' + Str( REKZAK, 5 ) + 'RZ-'
            IF Found()
               IF zNETTO == 0
                  BlokadaR()
                  Del()
                  Commit_()
                  UNLOCK
                  SELECT suma_mc
                  SEEK '+' + ident_fir + Str( Month( zDATAKS_OLD ), 2 )
                  BlokadaR()
                  repl_( 'pozycje', pozycje - 1 )
                  COMMIT
                  UNLOCK
                  SEEK '+' + ident_fir + miesiac
                  SELECT &usebaz
                  SET ORDER TO 1
                  *********************** lp
                  IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                     IF param_kslp == '3'
                        SET ORDER TO 4
                     ENDIF
                     Blokada()
                     Czekaj()
                     rec := RecNo()
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', lp - 1 )
                        SKIP
                     ENDDO
                     GO rec
                     COMMIT
                     UNLOCK
                     IF param_kslp == '3'
                        SET ORDER TO 1
                     ENDIF
                     @ 24, 0
                  ENDIF
                  *******************************
               ELSE
                  SELECT suma_mc
                  SEEK '+' + ident_fir + Str( Month( zDATAKS_OLD ), 2 )
                  BlokadaR()
                  repl_( 'pozycje', pozycje - 1 )
                  COMMIT
                  UNLOCK
                  SEEK '+' + ident_fir + Str( Month( zDATAKS ), 2 )
                  BlokadaR()
                  repl_( 'pozycje', pozycje + 1 )
                  COMMIT
                  UNLOCK
                  SEEK '+' + ident_fir + miesiac
                  SELECT &usebaz
                  SET ORDER TO 1
                  *********************** lp
                  IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                     IF param_kslp == '3'
                        SET ORDER TO 4
                     ENDIF
                     Blokada()
                     Czekaj()
                     rec := RecNo()
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', lp - 1 )
                        SKIP
                     ENDDO
                     GO rec
                     COMMIT
                     UNLOCK
                     IF param_kslp == '3'
                        SET ORDER TO 1
                     ENDIF
                     @ 24, 0
                  ENDIF
                  *******************************
                  BlokadaR()
                  repl_( 'DZIEN', Str( Day( zDATAKS ), 2 ) )
                  repl_( 'MC', Str( Month( zDATAKS ), 2 ) )
                  repl_( 'TRESC', zTRESC )
                  repl_( 'UWAGI', zUWAGI )
                  *repl_( 'zaplata],[1])
                  *repl_([kwota],0)
                  repl_( 'zakup', iif( zKOLUMNA == '10', znetto, 0 ) )
                  repl_( 'rejzid', REKZAK )
                  repl_( 'NUMER', 'RZ-' + znumer )
                  repl_( 'nazwa', znazwa )
                  repl_( 'ADRES', zADRES )
                  repl_( 'NR_IDENT', zNR_IDENT )
                  repl_( 'uboczne', iif( zKOLUMNA == '11', znetto, 0 ) )
                  repl_( 'wynagr_g', iif( zKOLUMNA == '12', znetto, 0 ) )
                  repl_( 'wydatki', iif( zKOLUMNA == '13' .OR. zKOLUMNA == '16', znetto, 0 ) )
                  repl_( 'PUSTA', iif( zKOLUMNA == '15', znetto, 0) )
                  repl_( 'K16WART', iif( zKOLUMNA == '16', znetto, 0) )
                  repl_( 'K16OPIS', iif( zKOLUMNA == '16', zK16OPIS, Space( 30 ) ) )
                  IF zNETTO2 <> 0 .AND. Val( zKOLUMNA ) > 0
                     DO CASE
                     CASE zKOLUMNA2 == '10'
                        repl_( 'zakup', zNETTO2 )
                     CASE zKOLUMNA2 == '11'
                        repl_( 'uboczne', zNETTO2 )
                     CASE zKOLUMNA2 == '12'
                        repl_( 'wynagr_g', zNETTO2 )
                     CASE zKOLUMNA2 == '13'
                        repl_( 'wydatki', zNETTO2 )
                     CASE zKOLUMNA2 == '15'
                        repl_( 'PUSTA', zNETTO2 )
                     CASE zKOLUMNA2 == '16'
                        repl_( 'K16WART', zNETTO2 )
                        repl_( 'K16OPIS', zK16OPIS )
                        repl_( 'wydatki', zNETTO2 )
                     ENDCASE
                  ENDIF
                  COMMIT
                  UNLOCK
                  SET ORDER TO 1
                  *********************** lp
                  IF param_lp == 'T'
                     IF param_kslp == '3'
                        SET ORDER TO 4
                     ENDIF
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
                     COMMIT
                     UNLOCK
                     IF param_kslp == '3'
                        SET ORDER TO 1
                     ENDIF
                     @ 24,0
                  ENDIF
                  COMMIT
                  UNLOCK
               ENDIF
               Commit_()
            ELSE
               ins := .T.
            ENDIF

         CASE stan_ == 0
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF zNETTO <> 0
               SELECT suma_mc
               SEEK '+' + ident_fir + Str( Month( zDATAKS ), 2 )
               BlokadaR()
               repl_( 'pozycje', pozycje + 1 )
               COMMIT
               UNLOCK
               SEEK '+' + ident_fir + miesiac
               SELECT &usebaz
               SET ORDER TO 1
               App()
               *adddoc
               repl_( 'FIRMA', ident_fir )
               repl_( 'MC', Str( Month( zDATAKS ), 2 ) )
               repl_( 'DZIEN', Str( Day( zDATAKS ), 2 ) )
               repl_( 'TRESC', zTRESC )
               repl_( 'UWAGI', zUWAGI )
               *repl_([zaplata],[1])
               *repl_([kwota],0)
               DO CASE
               CASE zKOLUMNA == '10'
                  repl_( 'zakup', znetto )
               CASE zKOLUMNA == '11'
                  repl_( 'uboczne', znetto )
               CASE zKOLUMNA == '12'
                  repl_( 'wynagr_g', znetto )
               CASE zKOLUMNA == '13'
                  repl_( 'wydatki', znetto)
               CASE zKOLUMNA == '15'
                  repl_( 'PUSTA', znetto)
               CASE zKOLUMNA == '16'
                  repl_(  'wydatki',  znetto )
                  repl_(  'K16WART',  znetto )
                  repl_(  'K16OPIS',  zK16OPIS )
               ENDCASE
               DO CASE
               CASE zKOLUMNA2 == '10'
                  repl_( 'zakup', znetto2 )
               CASE zKOLUMNA2 == '11'
                  repl_( 'uboczne', znetto2 )
               CASE zKOLUMNA2 == '12'
                  repl_( 'wynagr_g', znetto2 )
               CASE zKOLUMNA2 == '13'
                  repl_( 'wydatki', znetto2 )
               CASE zKOLUMNA2 == '15'
                  repl_( 'PUSTA', znetto2 )
               CASE zKOLUMNA2 == '16'
                  repl_(  'wydatki',  znetto2 )
                  repl_(  'K16WART',  znetto2 )
                  repl_(  'K16OPIS',  zK16OPIS )
               ENDCASE
               repl_( 'rejzid', REKZAK )
               repl_( 'NUMER', 'RZ-' + znumer )
               repl_( 'nazwa', znazwa )
               repl_( 'ADRES', zADRES )
               repl_( 'NR_IDENT', zNR_IDENT )
               Commit_()
               UNLOCK
               *********************** lp
               IF param_lp == 'T'
                  IF param_kslp == '3'
                     SET ORDER TO 4
                  ENDIF
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
                  COMMIT
                  UNLOCK
                  IF param_kslp == '3'
                     SET ORDER TO 1
                  ENDIF
                  @ 24, 0
               ENDIF
               COMMIT
               UNLOCK
            ENDIF
         ENDCASE
      ENDIF
      IF ins
         *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
         IF zNETTO <> 0
            SELECT suma_mc
            SEEK '+' + ident_fir + Str( Month( zDATAKS ), 2 )
            BlokadaR()
            repl_( 'pozycje', pozycje + 1 )
            COMMIT
            UNLOCK
            SEEK '+' + ident_fir + miesiac
            SELECT &usebaz
            SET ORDER TO 1
            App()
            *adddoc
            repl_( 'FIRMA', ident_fir )
            repl_( 'MC', Str( Month( zDATAKS ), 2 ) )
            repl_( 'DZIEN', Str( Day( zDATAKS ), 2 ) )
            repl_( 'TRESC', zTRESC )
            repl_( 'UWAGI', zUWAGI )
            *repl_([zaplata],[1])
            *repl_([kwota],0)
            DO CASE
            CASE zKOLUMNA == '10'
               repl_( 'zakup', znetto )
            CASE zKOLUMNA == '11'
               repl_( 'uboczne', znetto )
            CASE zKOLUMNA == '12'
               repl_( 'wynagr_g', znetto )
            CASE zKOLUMNA == '13'
               repl_( 'wydatki', znetto )
            CASE zKOLUMNA == '15'
               repl_( 'PUSTA', znetto )
            CASE zKOLUMNA == '16'
               repl_( 'wydatki' , znetto )
               repl_( 'K16WART' , znetto )
               repl_( 'K16OPIS' , zK16OPIS )
            endcase
            DO CASE
            CASE zKOLUMNA2 == '10'
               repl_( 'zakup', znetto2 )
            CASE zKOLUMNA2 == '11'
               repl_( 'uboczne', znetto2 )
            CASE zKOLUMNA2 == '12'
               repl_( 'wynagr_g', znetto2 )
            CASE zKOLUMNA2 == '13'
               repl_( 'wydatki', znetto2 )
            CASE zKOLUMNA2 == '15'
               repl_( 'PUSTA', znetto2 )
            CASE zKOLUMNA2 == '16'
               repl_( 'wydatki' , znetto2 )
               repl_( 'K16WART' , znetto2 )
               repl_( 'K16OPIS' , zK16OPIS )
            endcase
            repl_( 'rejzid', REKZAK )
            repl_( 'NUMER', 'RZ-' + znumer )
            repl_( 'nazwa', znazwa )
            repl_( 'ADRES', zADRES )
            repl_( 'NR_IDENT', zNR_IDENT )
            Commit_()
            UNLOCK
              *********************** lp
            IF param_lp == 'T'
               IF param_kslp == '3'
                  SET ORDER TO 4
               ENDIF
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
               COMMIT
               UNLOCK
               IF param_kslp == '3'
                  SET ORDER TO 1
               ENDIF
               @ 24,0
            ENDIF
            COMMIT
            UNLOCK
         ENDIF
      ENDIF
   ENDIF
     ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
     *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
   SELECT rejz

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE KRejZIFT2()

   LOCAL cKolor := ColStd()
   LOCAL zIFT2 := iif( IFT2 == 'T', 'T', 'N' )
   LOCAL zIFT2SEK := Val( IFT2SEK )
   LOCAL zIFT2KWOT := iif( IFT2KWOT == 0, _round( NETTO + NETTO2, 0 ), IFT2KWOT )
   LOCAL nRecNo := RecNo()
   LOCAL cEkran
   LOCAL bWykazV := { | |
      LOCAL cKolor := SetColor()
      IF zIFT2 $ 'NT'
         SET COLOR TO W+
         @ 7, 57 SAY iif( zIFT2 == 'T', 'ak', 'ie' )
         SetColor( cKolor )
         RETURN .T.
      ENDIF
      RETURN .F.
   }
   LOCAL bRodzajW := { | |
      cEkran := SaveScreen( 9, 0, 22, 79 )
      ColInf()
      @  9, 0 CLEAR TO 22, 79
      @  9, 0 TO 22, 79
      @ 10, 1 SAY " 1 - Opˆaty za wyw¢z ˆadunk¢w i pasa¾er¢w przyj©tych do przewozu w portach pol"
      @ 11, 1 SAY " 2 - Przychody uzyskane na ter. RP przez zagr. przedsi©biorstwa ¾eglugi powie."
      @ 12, 1 SAY " 3 - Dywidendy i inne przychody (dochody)z tytuˆu udziaˆu w zyskach os¢b prawn"
      @ 13, 1 SAY " 4 - Odsetki"
      @ 14, 1 SAY " 5 - Opˆaty licencyjne"
      @ 15, 1 SAY " 6 - Dziaˆalno˜† widowiskowa, rozrywkowa lub sportowa"
      @ 16, 1 SAY " 7 - Przychody z tytuˆu ˜wiadczeä: doradczych, ksi©gowych, badania rynku,us.pr"
      @ 17, 1 SAY " 8 - Przych¢d okre˜lony zgodnie z art. 21 ustawy (odsetki)"
      @ 18, 1 SAY " 9 - Przych¢d okre˜lony zgodnie z art. 21 ustawy (nale¾no˜ci licencyjne)"
      @ 19, 1 SAY "10 - Przych¢d okre˜lony zgodnie z art. 22 ustawy (dywidendy)"
      @ 20, 1 SAY "11 - Przych¢d okre˜lony zgodnie z art. 21 ustawy (bez dyw. i lic.)"
      @ 21, 1 SAY "12 - Przych¢d z tytuˆu zysk¢w kapitaˆowych, o kt¢rych mowa w art7b ust.1pkt3-6"
      RETURN .T.
   }
   LOCAL bRodzajV := { | |
      IF zIFT2SEK >= 1 .AND. zIFT2SEK <= 12
         RestScreen( 9, 0, 22, 79, cEkran )
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   }

   @  3, 16 CLEAR TO 11, 63
   @  4, 18 TO 10, 61
   @  5, 24 SAY 'WYKAZYWANIE W DEKLARACJI IFT-2R'
   @  6, 19 TO 6, 60
   @  7, 20 SAY 'Wyka¾ w deklaracji IFT-2R (Tak/Nie)' GET zIFT2 PICTURE '!' VALID Eval( bWykazV )
   @  8, 20 SAY 'Rodzaj przychodu (sekcja D, 1-12)' GET zIFT2SEK PICTURE '99' WHEN zIFT2 == 'T' .AND. Eval( bRodzajW ) VALID Eval( bRodzajV )
   @  9, 20 SAY 'Wykazana kwota' GET zIFT2KWOT PICTURE '99999999999' WHEN zIFT2 == 'T' VALID zIFT2KWOT > 0
   Eval( bWykazV )
   READ
   IF LastKey() <> K_ESC
      BlokadaR()
      rejz->IFT2 := zIFT2
      rejz->IFT2SEK := Str( zIFT2SEK, 3 )
      rejz->IFT2KWOT := zIFT2KWOT
      COMMIT
      UNLOCK
      IF zRYCZALT <> 'T'
         SELECT 5
         IF Select( "OPER" ) == 0
            DO WHILE ! Dostep( "OPER" )
            ENDDO
            SetInd( "OPER" )
         ENDIF
         SET ORDER TO 5
         SEEK '+' + Str( nRecNo, 5 ) + 'RZ-'
         IF Found()
            BlokadaR()
            oper->IFT2 := zIFT2
            oper->IFT2SEK := Str( zIFT2SEK, 3 )
            oper->IFT2KWOT := zIFT2KWOT
            COMMIT
            UNLOCK
         ENDIF
         USE
         SELECT 1
      ENDIF
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION RejZ_PobierzDok()

   LOCAL aBufRec := { ;
      'ID' => ID, ;
      'DZIEN' => DZIEN, ;
      'SYMB_REJ' => SYMB_REJ, ;
      'NAZWA' => NAZWA, ;
      'NR_IDENT' => NR_IDENT, ;
      'NUMER' => NUMER, ;
      'ADRES' => ADRES, ;
      'TRESC' => TRESC, ;
      'ROKS' => ROKS, ;
      'MCS' => MCS, ;
      'DZIENS' => DZIENS, ;
      'DATAS' => CToD( ROKS + '.' + MCS + '.' + DZIENS ), ;
      'DATAKS' => DATAKS, ;
      'KOLUMNA' => KOLUMNA, ;
      'UWAGI' => UWAGI, ;
      'WARTZW' => WARTZW, ;
      'WART00' => WART00, ;
      'WART02' => WART02, ;
      'VAT02' => VAT02, ;
      'WART07' => WART07, ;
      'VAT07' => VAT07, ;
      'WART22' => WART22, ;
      'VAT22' => VAT22, ;
      'WART12' => WART12, ;
      'VAT12' => VAT12, ;
      'BRUT02' => VAT02 + WART02, ;
      'BRUT07' => VAT07 + WART07, ;
      'BRUT22' => VAT22 + WART22, ;
      'BRUT12' => VAT12 + WART12, ;
      'NETTO' => NETTO, ;
      'EXPORT' => iif( EXPORT == ' ', 'N', EXPORT ), ;
      'UE' => iif( UE == ' ', 'N', UE ), ;
      'KRAJ' => iif( KRAJ == '  ', 'PL', KRAJ ), ;
      'SEK_CV7' => SEK_CV7, ;
      'RACH' => RACH, ;
      'KOREKTA' => KOREKTA, ;
      'USLUGAUE' => USLUGAUE, ;
      'WEWDOS' => WEWDOS, ;
      'PALIWA' => PALIWA, ;
      'POJAZDY' => POJAZDY, ;
      'DETAL' => DETAL, ;
      'SP22' => SP22, ;
      'SP12' => SP12, ;
      'SP07' => SP07, ;
      'SP02' => SP02, ;
      'SP00' => SP00, ;
      'SPZW' => SPZW, ;
      'ZOM22' => ZOM22, ;
      'ZOM12' => ZOM12, ;
      'ZOM07' => ZOM07, ;
      'ZOM02' => ZOM02, ;
      'ZOM00' => ZOM00, ;
      'ROZRZAPZ' => ROZRZAPZ, ;
      'ZAP_TER' => ZAP_TER, ;
      'ZAP_DAT' => ZAP_DAT, ;
      'ZAP_WART' => ZAP_WART, ;
      'OPCJE' => OPCJE, ;
      'K16OPIS' => Space( 30 ), ;
      'TROJSTR' => iif( TROJSTR == ' ', 'N', TROJSTR ), ;
      'KOL47' => KOL47, ;
      'KOL48' => KOL48, ;
      'KOL49' => KOL49, ;
      'KOL50' => KOL50, ;
      'NETTO2' => NETTO2, ;
      'KOLUMNA2' => KOLUMNA2, ;
      'DATATRAN' => DATATRAN, ;
      'RODZDOW' => RODZDOW, ;
      'VATMARZA' => VATMARZA }

   RETURN aBufRec

/*----------------------------------------------------------------------*/

