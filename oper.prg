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

PROCEDURE Oper()

   LOCAL nLP1, nLP2, nPozDzien, nPozMiesiac
   PRIVATE _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou, POZOBR

   POZOBR := .F.
   zexport := 'N'
   zUE := 'N'
   zKRAJ := 'PL'
   @ 1, 47 SAY '          '
   m->liczba := 1
   LpStart()
   *################################# GRAFIKA ##################################
   operRysujTlo()
   *                            16                  36   41                        67
   *############################### OTWARCIE BAZ ###############################
   OpenOper( 'OPER' )
   IF ZamSum()
      RETURN
   ENDIF
   *################################# OPERACJE #################################
   *----- parametry ------
   _top := 'firma#ident_fir.or.mc#miesiac'
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + miesiac
   _sbot := '+' + ident_fir + miesiac + '‏'
   _proc := 'say1'
   *----------------------
   _top_bot := _top + '.or.' + _bot
   IF ! &_top_bot
      DO &_proc
   ENDIF
   kl := 0
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
      CASE ( kl == K_INS .OR. kl == Asc( '0' ) .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' ) .OR. &_top_bot ) .AND. kl # K_ESC
         @ 1, 47 SAY '          '
         ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
         KtorOper()
         BEGIN SEQUENCE
            IF ZamSum1()
               BREAK
            ENDIF
            *ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
            IF ins
               zDZIEN := '  '
               znazwa := Space( 100 )
               zNR_IDENT := Space( 30 )
               zNUMER := Space( 40 )
               zADRES := Space( 100 )
               zTRESC := Space( 30 )
               zWYR_TOW := 0
               zUSLUGI := 0
               STORE 0 TO zZAKUP, zUBOCZNE, zWYNAGR_G, zWYDATKI, zPUSTA
               zident := 0
               zuwagi := Space( 14 )
               zROZRZAPK := pzROZRZAPK
               zZAP_TER := 0
               zZAP_DAT := Date()
*                 zZAP_DAT=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')
               zZAP_WART := 0
               zK16WART := 0
               zK16OPIS := Space( 30 )
   *                 zzaplata=[1]
   *                 zkwota=0
               @ 3, 71 SAY Space( 8 )
               *********************** lp
               IF param_lp == 'T'
                  @ 3, 71 SAY Space( 8 )
               ENDIF
               ***********************
            ELSE
               IF docsys()
                  BREAK
               ENDIF
               zDZIEN := DZIEN
               znazwa := nazwa
               zNR_IDENT := NR_IDENT
               zNUMER := iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2, 20 ) , SubStr( numer, 1, 20 ) )
               zADRES := ADRES
               zTRESC := TRESC
               zWYR_TOW := WYR_TOW
               zUSLUGI := USLUGI
               zZAKUP := ZAKUP
               zUBOCZNE := UBOCZNE
               zWYNAGR_G := WYNAGR_G
               zWYDATKI := WYDATKI
               zPUSTA := PUSTA
               zuwagi := uwagi
               zROZRZAPK := ROZRZAPK
               zZAP_TER := ZAP_TER
               zZAP_DAT := ZAP_DAT
               zZAP_WART := ZAP_WART
               zK16WART :=  K16WART
               zK16OPIS := K16OPIS
    *                 zzaplata=zaplata
   *                 zkwota=kwota
            ENDIF
            *ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
            ColStd()
            @  3, 27 GET zDZIEN PICTURE "99" WHEN PolePaliwoStop() .AND. ( WERSJA4 == .T. .OR. ins ) VALID v1_1()
            @  4, 27 GET zNUMER PICTURE "@S40 " + repl( '!', 40 ) WHEN PolePaliwoStop() VALID v1_2()
            @  5, 27 GET zNAZWA PICTURE "@S52 " + repl( '!', 100 ) WHEN PolePaliwoStop() VALID w1_3()
            @  6, 27 GET zADRES PICTURE "@S52 " + repl( '!', 100 ) WHEN PolePaliwoStop()
            @  7, 27 GET zNR_IDENT PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" WHEN PolePaliwoStop()
            @  8, 37 GET zTRESC WHEN PolePaliwoStop() VALID v1_5()
            @ 10, 67 GET zWYR_TOW  PICTURE FPIC WHEN PolePaliwoStop() VALID iif( zWYR_TOW # 0, vKONIEC(), .T. )
            @ 11, 67 GET zUSLUGI   PICTURE FPIC WHEN PolePaliwoStop() VALID iif( zUSLUGI # 0, vKONIEC(), .T. )
            @ 12, 67 GET zZAKUP    PICTURE FPIC WHEN PolePaliwoStart() VALID vSUMOP() .AND. iif( zZAKUP # 0, vKONIEC(), .T.) .AND. PolePaliwoStop()
            @ 13, 67 GET zUBOCZNE  PICTURE FPIC WHEN PolePaliwoStart() VALID vSUMOP() .AND. iif( zUBOCZNE # 0, vKONIEC(), .T. ) .AND. PolePaliwoStop()
            @ 14, 67 SAY "            "
            @ 15, 67 GET zWYNAGR_G PICTURE FPIC WHEN PolePaliwoStart() VALID vSUMOP() .AND. iif( zWYNAGR_G # 0, vKONIEC(), .T. ) .AND. PolePaliwoStop()
            @ 16, 67 GET zWYDATKI  PICTURE FPIC WHEN PolePaliwoStart() VALID vSUMOP() .AND. iif( zWYDATKI # 0, vKONIEC(), .T.) .AND. PolePaliwoStop()
            @ 17, 67 SAY "            "
            @ 18, 67 GET zPUSTA    PICTURE FPIC WHEN PolePaliwoStop() VALID iif( zPUSTA # 0, vKONIEC(), .T.)
            @ 19, 49 GET zK16OPIS  PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" WHEN PolePaliwoStop()
            @ 20, 67 GET zK16WART  PICTURE FPIC WHEN PolePaliwoStop()
            SET COLOR TO i
            @ 21, 65 SAY zUWAGI
            SET COLOR TO
            CLEAR TYPEAHEAD
            read_()
            IF LastKey() == K_ESC
               PolePaliwoStop()
               BREAK
            ENDIF
            ColStd()
            PolePaliwoStop()
*                            16                  36   41                        67
            @ 21, 65 GET ZUWAGI
   *@ 16,67 get pzROZRZAPK picture "!" when wROZRJAK() valid vROZRJAK('pzROZRZAPK')
            IF AllTrim( znumer ) == 'REM-P' .OR. AllTrim( znumer ) == 'REM-K'
               zROZRZAPK := 'N'
            ENDIF
            @ 22, 16 GET zROZRZAPK PICTURE '!' WHEN wROZRget() VALID vROZRget( 'zROZRZAPK', 22, 16 )
            @ 22, 36 GET zZAP_TER PICTURE '999' WHEN zROZRZAPK == 'T'
            @ 22, 41 GET zZAP_DAT PICTURE '@D' WHEN zROZRZAPK == 'T' .AND. wZAP_DAT() VALID vZAP_DAT()
            @ 22, 67 GET zZAP_WART PICTURE FPIC WHEN zROZRZAPK == 'T' VALID zZAP_WART >= 0.0 .AND. zZAP_WART <= Abs( -zWYR_TOW - zUSLUGI + zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA )
            CLEAR TYPEAHEAD
            read_()
            IF LastKey() == K_ESC
               BREAK
            ENDIF
*              if alltrim(znumer)=[REM-P].or.alltrim(znumer)=[REM-K]
*                 zzaplata=[1]
*                 zkwota=0
*              else
*                 if .not.zaplacono()
*                    break
*                 endif
*              endif
            znumer := dos_l( znumer )
            zdzien := Str( Val( zDZIEN ), 2 )
            *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
            tresc_ := tresc
            stan_ := -WYR_TOW - USLUGI + ZAKUP + UBOCZNE + WYNAGR_G + WYDATKI + PUSTA
            obrot_ := wyr_tow
            KontrApp()
            WrocStan()
            SEEK '+' + ident_fir + ztresc
            IF Found()
               BlokadaR()
               AKTPOL+ stan WITH -zWYR_TOW - zUSLUGI + zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA
               COMMIT
               UNLOCK
            ENDIF
            SELECT SUMA_MC
            BlokadaR()
            IF ! ins .AND. Left( oper->numer, 1 ) # Chr( 1 ) .AND. Left( oper->numer, 1 ) # Chr( 254 )
               SUMY-
            ENDIF
            IF RTrim( znumer ) # 'REM-P' .AND. RTrim( znumer ) # 'REM-K'
               SUMY+
            ENDIF
            COMMIT
            UNLOCK
            IF ins
               BlokadaR()
               AKTPOZ+
               COMMIT
               UNLOCK
            ENDIF

            SELECT oper

            IF ins
               SET ORDER TO 2
               Blokada()
               GO BOTTOM
               IDPR := rec_no + 1
               SET ORDER TO 1
            ELSE
               IDPR := rec_no
            ENDIF

            ifins( IDPR )
            DO CASE
            CASE RTrim( znumer ) == 'REM-P'
               znumer := Chr( 1 ) + znumer
            CASE RTrim( znumer ) == 'REM-K'
               zNUMER := Chr( 254 ) + znumer
            ENDCASE
            BlokadaR()
            ADDPOZ
            REPLACE WYR_TOW  WITH zWYR_TOW
            REPLACE USLUGI   WITH zUSLUGI
            REPLACE ZAKUP    WITH zZAKUP
            REPLACE UBOCZNE  WITH zUBOCZNE
            REPLACE WYNAGR_G WITH zWYNAGR_G
            REPLACE WYDATKI  WITH zWYDATKI
            REPLACE PUSTA    WITH zPUSTA
            REPLACE UWAGI    WITH zUWAGI
*              repl zaplata with zzaplata
*              repl kwota   with zkwota
            REPLACE ROZRZAPK WITH zROZRZAPK
            REPLACE ZAP_TER  WITH zZAP_TER
            REPLACE ZAP_DAT  WITH zZAP_DAT
            REPLACE ZAP_WART WITH zZAP_WART

            REPLACE K16WART WITH zK16WART
            REPLACE K16OPIS WITH zK16OPIS

            COMMIT
            UNLOCK
            *********************** lp
            IF param_lp == 'T'
               Blokada()
               ColInb()
               @ 24, 0 CLEAR
               center( 24, 'Prosz&_e. czeka&_c....' )
               SET COLOR TO
               rec := RecNo()
               IF ins
                  SKIP -1
                  IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                     zlp := liczba
                  ELSE
                     zlp := lp+1
                  ENDIF
                  GO rec
                  DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                     REPLACE lp WITH zlp
                     zlp := zlp + 1
                     SKIP
                  ENDDO
               ELSE
                  zlp := lp
                  SKIP -1
                  IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                     zlp := liczba
                     GO rec
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        REPLACE lp WITH zlp
                        zlp := zlp + 1
                        SKIP
                     ENDDO
                  ELSE
                     IF lp < zlp
                        zlp := lp + 1
                        GO rec
                        DO WHILE del == '+' .AND. firma == ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                           REPLACE lp WITH zlp
                           zlp := zlp + 1
                           SKIP
                        ENDDO
                     ELSE
                        zlp := lp
                        GO rec
                        DO WHILE ! Bof() .AND. firma == ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                           REPLACE lp WITH zlp
                           zlp := zlp - 1
                           SKIP -1
                        ENDDO
                     ENDIF
                  ENDIF
               ENDIF
               GO rec
               COMMIT
               UNLOCK
            ENDIF

   *para fZRODLO,fJAKIDOK,fNIP,fNRDOK,fDATAKS,fDATADOK,fTERMIN,fDNIPLAT,fRECNO,fKWOTA,fTRESC,fKWOTAVAT
   * JAKIDOK: FS i FZ (faktury zakupu i sprzedazy), ZS i ZZ (zaplaty za sprzedaz i zakupy)

            SELECT rozr
            IF ins
               IF zROZRZAPK == 'T'
                  dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
                  IF zWYR_TOW + zUSLUGI <> 0.0
                     RozrApp( 'K', 'FS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, ( zWYR_TOW + zUSLUGI ), zTRESC, 0 )
                  ENDIF
                  IF zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA <> 0.0
                     RozrApp( 'K', 'FZ', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, ( zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA ), zTRESC, 0 )
                  ENDIF
                  IF zZAP_WART > 0.0
                     IF ( -zWYR_TOW - zUSLUGI + zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA ) > 0.0
                        dddok := 'ZZ'
                        RozrApp( 'K', dddok, zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, zZAP_WART, zTRESC, 0 )
                     ELSE
                        dddok := 'ZS'
                        RozrApp( 'K', dddok, zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, zZAP_WART, zTRESC, 0 )
                     ENDIF
                  ENDIF
               ENDIF
            ELSE
               SET ORDER TO 2
               SEEK ident_fir + param_rok + 'K' + Str( IDPR, 10 )
               IF Found()
                  IF zROZRZAPK == 'T'
                     SELECT rozr
                     RozrDel( 'K', IDPR )
*                       select OPER
                     IF zWYR_TOW + zUSLUGI <> 0.0
                        dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
                        RozrApp( 'K', 'FS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, ( zWYR_TOW + zUSLUGI ), zTRESC, 0 )
                     ENDIF
                     IF zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA <> 0.0
                        dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
                        RozrApp( 'K', 'FZ', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, ( zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA ), zTRESC, 0 )
                     ENDIF
                     IF zZAP_WART > 0.0
                        IF ( -zWYR_TOW - zUSLUGI + zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA ) > 0.0
                           dddok := 'ZZ'
                           RozrApp( 'K', dddok, zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, zZAP_WART, zTRESC, 0 )
                        ELSE
                           dddok := 'ZS'
                           RozrApp( 'K', dddok, zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, zZAP_WART, zTRESC, 0 )
                        ENDIF
                     ENDIF
*                       select oper
                  ELSE
                     SELECT rozr
                     RozrDel( 'K', IDPR )
*                       SELECT OPER
                  ENDIF
               ELSE
                  IF zROZRZAPK == 'T'
                     IF zWYR_TOW + zUSLUGI <> 0.0
                        dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
                        RozrApp( 'K', 'FS', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, ( zWYR_TOW + zUSLUGI ), zTRESC, 0 )
                     ENDIF
                     IF zZAKUP + zUBOCZNE + zWYNAGR_G  + zWYDATKI + zPUSTA <> 0.0
                        dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
                        RozrApp( 'K', 'FZ', zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, ( zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA ), zTRESC, 0 )
                     ENDIF
                     IF zZAP_WART > 0.0
                        IF ( -zWYR_TOW - zUSLUGI + zZAKUP + zUBOCZNE + zWYNAGR_G + zWYDATKI + zPUSTA ) > 0.0
                           dddok := 'ZZ'
                           RozrApp( 'K', dddok, zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, zZAP_WART, zTRESC, 0 )
                        ELSE
                           dddok := 'ZS'
                           RozrApp( 'K', dddok, zNR_IDENT, zNUMER, dddat, dddat, zZAP_DAT, zZAP_TER, IDPR, zZAP_WART, zTRESC, 0 )
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF

            ***********************
            commit_()
            SELECT 1
            *נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
         END
         IF &_top_bot
            EXIT
         ELSE
            DO &_proc
         ENDIF
         @ 23, 0
         @ 24, 0

      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == Asc( '.' ) .OR. kl == K_CTRL_DEL
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                   ‏' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         BEGIN SEQUENCE
            *-------zamek-------
            IF suma_mc->zamek
               kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
               BREAK
            ENDIF
            *-------------------
            IF kl <> K_CTRL_DEL
               IF Left( numer, 2 ) == 'S-' .OR. Left( numer, 2 ) == 'R-' .OR. Left( numer, 2 ) == 'F-' .OR. Left( numer, 3 ) == 'KF-' .OR. Left( numer, 3 ) == 'KR-'
                  kom( 4, '*u', ' Symbole S-,F-,R-,KF- i KR- mo&_z.na wykasowa&_c. tylko w opcji FAKTUROWANIE ' )
                  BREAK
               ENDIF
               IF Left( numer, 3 ) == 'RS-' .AND. ( WYR_TOW <> 0 .OR. USLUGI <> 0 )
                  kom( 4, '*u', ' Na dokumenty o symbolu RS- <> 0 mo&_z.na wp&_l.ywa&_c. tylko poprzez rejestr sprzeda&_z.y ' )
                  BREAK
               ENDIF
               IF Left( numer, 3 ) == 'RZ-'
                  kom( 4, '*u', ' Na dokumenty o symbolu RZ- mo&_z.na wp&_l.ywa&_c. tylko poprzez rejestr zakupu ' )
                  BREAK
               ENDIF
            ELSE
               IF Left( numer, 3 ) == 'RZ-' .AND. rejzid > 0
                  SELECT 100
                  DO WHILE ! Dostep( 'REJZ' )
                  ENDDO
                  dbGoto( oper->rejzid )
                  IF AllTrim( SubStr( oper->numer, 4 ) ) == AllTrim( numer ) .AND. del == '+'
                     kom( 4, '*u', ' Na dokumenty o symbolu RZ- mo&_z.na wp&_l.ywa&_c. tylko poprzez rejestr zakupu ' )
                     dbCloseArea()
                     SELECT oper
                     BREAK
                  ENDIF
                  dbCloseArea()
                  SELECT oper
               ELSE
                  kom( 4, '*u', ' Nie mo¾na usun¥† tego dokumentu ' )
                  BREAK
               ENDIF
            ENDIF
            IF ! TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
               BREAK
            ENDIF
            tresc_ := tresc
            stan_ := -WYR_TOW - USLUGI + ZAKUP + UBOCZNE + WYNAGR_G + WYDATKI + PUSTA
            obrot_ := wyr_tow
            SELECT tresc
            SEEK '+' + ident_fir+tresc_
            IF Found()
               BlokadaR()
               STANUJ
               COMMIT
               UNLOCK
            ENDIF
            SELECT suma_mc
            BlokadaR()
            IF Left( oper->numer, 1 ) # Chr( 1 ) .AND. Left( oper->numer, 1 ) # Chr( 254 )
               SUMY-
            ENDIF
            AKTPOZ-
            COMMIT
            UNLOCK
            SELECT oper
            rrrec := rec_no
            SELECT rozr
            RozrDel( 'K', rrrec )
            SELECT oper
            BlokadaR()
            del()
            COMMIT
            UNLOCK
            SKIP
            *********************** lp
            IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir
               Blokada()
               ColInb()
               @ 24, 0 CLEAR
               center( 24, 'Prosz&_e. czeka&_c....' )
               rec := RecNo()
               DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                  REPLACE lp WITH lp - 1
                  SKIP
               ENDDO
               GO rec
               COMMIT
               UNLOCK
               ColStd()
            ENDIF
            *******************************
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
            IF ! &_bot
               DO &_proc
            ELSE
               operRysujTlo()
            ENDIF
         END
         @ 23, 0
         @ 24, 0

      *################################# MODYFIKACJA SUMY RS- #####################
      case kl == K_CTRL_F10 .AND. SubStr( NUMER, 1, 3 ) == 'RS-'
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                                 ‏' )
         ColSta()
         center( 23, 'M O D Y F I K A C J A   S U M Y' )
         ColStd()
         SELECT oper
         zWYR_TOW := WYR_TOW
         zUSLUGI := USLUGI
         IF AllTrim( NUMER ) == 'RS-7'
            @ 10, 67 GET zWYR_TOW PICTURE FPIC
         ELSE
            @ 11, 67 GET zUSLUGI  PICTURE FPIC
         ENDIF
         SET CURSOR ON
         READ
         SET CURSOR OFF
         IF LastKey() <> K_ESC
            BlokadaR()
            REPLACE WYR_TOW WITH zWYR_TOW, USLUGI WITH zUSLUGI
            COMMIT
            UNLOCK
         ENDIF
         DO &_proc
         @ 23, 0

      *################################# SZUKANIE DNIA ############################
      CASE kl= K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                 ‏' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         f10 := '  '
         @ 3, 27 GET f10 PICTURE "99"
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
         center( 23, '‏                 ‏' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         zDZIEN := '  '
         zNUMER := Space( 40 )
         zNAZWA := Space( 100 )
         zZDARZ := Space( 20 )
         zLP := '     '
         DECLARE pp[ 5 ]
         *---------------------------------------
         pp[ 1 ] := '      Dzie&_n.:                     '
         pp[ 2 ] := '  Nr dowodu:                     '
         pp[ 3 ] := ' Kontrahent:                     '
         pp[ 4 ] := '  Zdarzenie:                     '
         pp[ 5 ] := '       L.p.:                     '
         *---------------------------------------
         SET COLOR TO N/W,W+/W,,,N/W
         i := 5
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
         @ 18, 35 GET zDZIEN PICTURE '99' VALID zDZIEN == '  ' .OR. ( Val( zDZIEN ) >= 1 .AND. Val( zDZIEN ) <= 31 )
         @ 19, 35 GET zNUMER PICTURE '@S20 ' + repl( '!', 40 )
         @ 20, 35 GET zNAZWA PICTURE '@S20 ' + repl( '!', 100 )
         @ 21, 35 GET zZDARZ PICTURE Replicate( '!', 20 )
         @ 22, 35 GET zLP PICTURE '99999'
         READ
         SET CURSOR OFF
         REC := RecNo()
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            GO top
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
            IF zLP <> '     '
               SZUK := SZUK + '.and.LP=val(zLP)'
            ENDIF
            IF SZUK <> "del='+'.and.firma=ident_fir.and.mc=miesiac"
               DO WHILE ! Eof() .AND. del == '+' .AND. firma == ident_fir .AND. mc == miesiac
                  IF &SZUK
                     REC := recno()
                     SC1 := SaveScreen( 17, 23, 22, 57 )
                     RESTORE SCREEN FROM scr_
                     DO &_proc
                     SAVE SCREEN TO scr_
                     RestScreen( 17, 23, 22, 57, SC1 )
                     @ 23, 0
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
               kom( 3, '*u', ' KONIEC SZUKANIA ' )
            ENDIF
         ENDIF
         RESTORE SCREEN FROM scr_
         GO REC
         DO &_proc
         _disp := .F.
         *#################################### POMOC ##################################
      CASE kl == K_F1
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE pppp[ 20 ]
         *---------------------------------------
         pppp[  1 ] := '                                                        '
         pppp[  2 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         pppp[  3 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         pppp[  4 ] := '   [Ins]...................dopisanie dokumentu          '
         pppp[  5 ] := '   [M].....................modyfikacja dokumentu        '
         pppp[  6 ] := '   [Del]...................kasowanie dokumentu          '
         pppp[  7 ] := '   [F9 ]...................szukanie z&_l.o&_z.one             '
         pppp[  8 ] := '   [F10]...................szukanie dnia                '
         pppp[  9 ] := '   [Esc]...................wyj&_s.cie                      '
         pppp[ 10 ] := '   REM-P   nr dowodu zastrze&_z.ony dla remanentu pocz.    '
         pppp[ 11 ] := '   REM-K   nr dowodu zastrze&_z.ony dla remanentu ko&_n.c.    '
         pppp[ 12 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 12
         j := 22
         DO WHILE i > 0
            IF Type( 'pppp[i]' ) # 'U'
               Center( j, pppp[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         pause(0)
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.

      *########################### PRZESUN W GORE #################################
      CASE kl == K_CTRL_PGUP .AND. param_kslp == '3'
         SELECT oper
         nPozDzien := oper->dzien
         nPozMiesiac := oper->mc
         nLP1 := oper->lp
         rec := RecNo()
         dbSkip( -1 )
         IF Bof() .OR. firma#ident_fir .OR. nPozDzien <> oper->dzien .OR. nPozMiesiac <> oper->mc
            dbGoto( rec )
            komun('Nie mo¾na przesun¥† wy¾ej')
         ELSE
            nLP2 := oper->lp
            Blokada()
            oper->lp := nLP1
   //         unlock
            dbGoto( rec )
   //         blokadar()
            oper->lp := nLP2
            COMMIT
            UNLOCK
   //         setind('OPER')
   //         dbGoto( rec )
            commit_()
         ENDIF
         DO &_proc
      *########################### PRZESUN W DOL ##################################
      CASE kl == K_CTRL_PGDN .AND. param_kslp == '3'
         select oper
         nPozDzien := oper->dzien
         nPozMiesiac := oper->mc
         nLP1 := oper->lp
         rec := RecNo()
         dbSkip( 1 )
         IF Eof() .OR. firma#ident_fir .OR. nPozDzien <> oper->dzien .OR. nPozMiesiac <> oper->mc
            dbGoto( rec )
            komun('Nie mo¾na przesun¥† ni¾ej')
         ELSE
            nLP2 := oper->lp
            Blokada()
            oper->lp := nLP1
   //         unlock
            dbGoto( rec )
   //         blokadar()
            oper->lp := nLP2
            COMMIT
            UNLOCK
   //         setind('OPER')
   //         dbGoto( rec )
            commit_()
         ENDIF
         DO &_proc
      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()
   RETURN

*################################## FUNKCJE #################################
PROCEDURE say1()

   CLEAR TYPEAHEAD
   SELECT oper
   *********************** lp
   IF param_lp == 'T'
      ColStd()
      @ 3, 71 SAY 'Lp.'
      SET COLOR TO +w
      @ 3, 74 SAY lp PICTURE '99999'
      SET COLOR TO
   ENDIF
   ***********************
   SET COLOR TO +w
   @  3, 27 SAY DZIEN
   @  4, 27 SAY iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ) + ' ', numer )
   *if left(numer,1)=chr(1).or.left(numer,1)=chr(254)
   *   @ 4,40 say space(40)
   *else
   *   @ 4,40 say space(40)
   *   @ 4,43 say 'Zap&_l.acono:'
   *   do case
   *   case zaplata=[1]
   *        do case
   *        case left(NUMER,3)='RS-'
   *             @ 4,53 say 'INFO w Rejestrze Sprzeda&_z.y'
   *        case left(NUMER,3)='RZ-'
   *             @ 4,53 say 'INFO w Rejestrze Zakupu'
   *        other
   *             @ 4,53 say 'TAK '+tran(Data_Zap,'@D')
   *        endcase
   *   case zaplata=[2]
   *        do case
   *        case left(NUMER,3)='RS-'
   *             @ 4,53 say 'INFO w Rejestrze Sprzeda&_z.y'
   *        case left(NUMER,3)='RZ-'
   *             @ 4,53 say 'INFO w Rejestrze Zakupu'
   *        other
   *             @ 4,53 say padr('Cz&_e.&_s. '+dos_l(kwota(kwota,12,2))+' '+tran(Data_Zap,'@D'))
   *        endcase
   *   case zaplata=[3]
   *        do case
   *        case left(NUMER,3)='RS-'
   *             @ 4,53 say 'INFO w Rejestrze Sprzeda&_z.y'
   *        case left(NUMER,3)='RZ-'
   *             @ 4,53 say 'INFO w Rejestrze Zakupu'
   *        other
   *             @ 4,53 say 'NIE'
   *        endcase
   *   endcase
   *endif
   @  5, 27 SAY SubStr( nazwa, 1, 52 )
   @  6, 27 SAY SubStr( ADRES, 1, 52 )
   @  7, 27 SAY NR_IDENT
   @  8, 37 SAY TRESC
   @ 10, 67 SAY wyr_tow  PICTURE RPIC
   @ 11, 67 SAY uslugi   PICTURE RPIC
   @ 12, 67 SAY zakup    PICTURE RPIC
   @ 13, 67 SAY uboczne  PICTURE RPIC
   @ 14, 67 SAY zakup + uboczne PICTURE RPIC
   @ 15, 67 SAY wynagr_g PICTURE RPIC
   @ 16, 67 SAY wydatki  PICTURE RPIC
   @ 17, 67 SAY wynagr_g + wydatki PICTURE RPIC
   @ 18, 67 SAY pusta    PICTURE RPIC
   @ 19, 49 SAY K16OPIS
   @ 20, 67 SAY K16WART PICTURE RPIC
   @ 21, 65 SAY uwagi
   *@ 22, 0 say 'Kontrola zaplat....  .................. (..........) ..............             '
   @ 22,16 say ROZRZAPK + iif( ROZRZAPK == 'T', 'ak', 'ie' )
   IF ROZRZAPK == 'T'
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
   SET COLOR TO
   RETURN

***************************************************
FUNCTION vSUMOP()

   SET COLOR TO +w
   @ 14, 67 SAY zzakup + zuboczne  PICTURE RPIC
   @ 17, 67 SAY zwynagr_g + zwydatki PICTURE RPIC
   ColStd()
   RETURN .T.

***************************************************
FUNCTION v1_1()

   IF zdzien == '  '
      zdzien := Str( Day( Date() ), 2 )
      SET COLOR TO i
      @ 3, 27 SAY zDZIEN
      SET COLOR TO
   ENDIF
   IF Val( zdzien ) < 1 .OR. Val( zdzien ) > msc( Val( miesiac ) )
      zdzien := '  '
      RETURN .F.
   ENDIF
   RETURN .T.

***************************************************
FUNCTION V1_2()
***************************************************
   IF ' ' $ AllTrim( znumer )
      RETURN .F.
   ENDIF
   @ 24, 0
   DO CASE
   CASE AllTrim( znumer ) == 'REM-P'
      Center( 24, ' Symbol zastrze&_z.ony dla remanentu pocz&_a.tkowego ' )
   CASE AllTrim( znumer ) == 'REM-K'
      Center( 24, ' Symbol zastrze&_z.ony dla remanentu ko&_n.cowego ' )
   CASE Left( LTrim( znumer ), 2 ) == 'S-'
      kom( 4, '*u', ' Symbol dowodu (S-) jest zastrze&_z.ony dla faktur ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 2 ) == 'F-'
      kom( 4, '*u', ' Symbol dowodu (F-) jest zastrze&_z.ony dla faktur VAT' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 2 ) == 'R-'
      kom( 4, '*u', ' Symbol dowodu (R-) jest zastrze&_z.ony dla rachunk&_o.w uproszczonych ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'KF-'
      kom( 4, '*u', ' Symbol dowodu (KF-) jest zastrze&_z.ony dla faktur VAT koryguj&_a.cych ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'KR-'
      kom( 4, '*u', ' Symbol dowodu (KR-) jest zastrze&_z.ony dla rachunk&_o.w uproszcz.koryg. ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'RS-'
      kom( 4, '*u', ' Symbol dowodu (RS-) jest zastrze&_z.ony dla sum z rejestru sprzeda&_z.y ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'RZ-'
      kom(4,[*u],[ Symbol dowodu (RZ-) jest zastrze&_z.ony dla dokument&_o.w z rejestru zakupu ])
      RETURN .F.
   ENDCASE
   EwidSprawdzNrDok( 'OPER', ident_fir, miesiac, znumer, iif( ins, 0, RecNo() ) )
   RETURN .T.

***************************************************
FUNCTION w1_3()
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
            zexport := 'N'
            zUE := 'N'
            zKRAJ := 'PL'
         ENDIF
      ENDIF
      SET ORDER TO 1
   ELSE
      SELECT kontr
      SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 ) + SubStr( zadres, 1, 15 )
      IF del # '+' .OR. firma # ident_fir
         SKIP -1
         zexport := 'N'
         zUE := 'N'
         zKRAJ := 'PL'
      ENDIF
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      Kontr_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER
         znazwa := nazwa
         zadres := adres
         zNR_IDENT := NR_IDENT
         zexport := export
         zUE := UE
         zKRAJ := KRAJ
         SET COLOR TO i
         @ 5, 27 SAY SubStr( znazwa, 1, 52 )
         @ 6, 27 SAY SubStr( zadres, 1, 40 )
         @ 7, 27 SAY zNR_IDENT
         SET COLOR TO
         KEYBOARD Chr( K_ENTER ) + Chr( K_ENTER )
      ENDIF
   ENDIF
   SELECT oper
   RETURN .T.

***************************************************
FUNCTION v1_5()

   IF Empty( ztresc )
      SELECT tresc
      SEEK '+' + ident_fir
      IF ! Found()
         SELECT oper
      ELSE
         SAVE SCREEN TO scr2
         Tresc_()
         RESTORE SCREEN FROM scr2
         SELECT oper
         IF LastKey() == K_ESC
            RETURN .T.
         ENDIF
         ztresc := tresc->tresc
         SET COLOR TO i
         @ 8, 37 SAY ztresc
         SET COLOR TO
      ENDIF
   ENDIF
   IF AllTrim( znumer ) == 'REM-P' .OR. AllTrim( znumer ) == 'REM-K'
      KEYBOARD Chr( K_ENTER ) + Chr( K_ENTER )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION vKONIEC()

   IF LastKey() == K_ENTER
      SET KEY 23 TO
      KEYBOARD Chr( K_CTRL_W )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION V1_22()
***************************************************
   RETURN ZKWOTA > 0

**************************************************
PROCEDURE KontrApp()
**************************************************
   SELECT kontr
   IF ! Empty( znazwa ) .AND. param_aut == 'T'
      SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 ) + SubStr( zadres, 1, 15 )
      IF ! Found()
         app()
         REPLACE firma WITH ident_fir
         REPLACE nazwa WITH znazwa
         REPLACE adres WITH zadres
         REPLACE NR_IDENT WITH zNR_IDENT
         REPLACE EXPORT WITH zEXPORT
         REPLACE UE WITH zUE
         REPLACE KRAJ WITH zKRAJ
         COMMIT
         UNLOCK
      ENDIF
   ENDIF
   RETURN

**************************************************
PROCEDURE LpStart()
**************************************************
   IF param_lp == 'T'
      DO WHILE ! Dostep( 'FIRMA' )
      ENDDO
      GO Val( ident_fir )
      m->liczba := liczba
      USE
   ENDIF
   RETURN

**************************************************
FUNCTION ZamSum()
**************************************************
   R := .F.
   IF suma_mc->zamek
      kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
      close_()
      R := .T.
   ENDIF
   RETURN R

**************************************************
FUNCTION ZamSum1()
**************************************************
   R := .F.
   IF suma_mc->zamek
      kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
      R := .T.
   ENDIF
   RETURN R

**************************************************
PROCEDURE KtorOper()
**************************************************
   IF ins
      ColStb()
      center(23,[‏                     ‏])
      ColSta()
      center(23,[W P I S Y W A N I E])
      ColStd()
   ELSE
      ColStb()
      center(23,[‏                       ‏])
      ColSta()
      center(23,[M O D Y F I K A C J A])
      ColStd()
   ENDIF

**************************************************
PROCEDURE OpenOper( bazy )
**************************************************
   SELECT 5
   DO WHILE ! Dostep( 'ROZR' )
   ENDDO
   SetInd( 'ROZR' )

   SELECT 4
   DO WHILE ! Dostep( 'TRESC' )
   ENDDO
   SET INDEX TO tresc

   SELECT 3
   DO WHILE ! Dostep( 'KONTR' )
   ENDDO
   SetInd( 'KONTR' )

   SELECT 2
   DO WHILE ! Dostep( 'SUMA_MC' )
   ENDDO
   SET INDEX TO suma_mc
   SEEK '+' + ident_fir + miesiac

   SELECT 1
   DO WHILE ! Dostep( bazy )
   ENDDO
   SetInd( bazy )
   SEEK '+' + ident_fir + miesiac

   RETURN

*************************************
FUNCTION DocSys()
*************************************
   R := .F.
   DO CASE
   CASE Left( LTrim( numer ), 2 ) == 'S-' .OR. Left( LTrim( numer ), 2 ) == 'R-' .OR. Left( LTrim( numer ), 2 ) == 'F-' .OR. Left( LTrim( numer ), 3 ) == 'KF-' .OR. Left( LTrim( numer ), 3 ) == 'KR-'
      kom( 4, '*u', ' Symbole S-,F-,R-,KR- i KF- mo&_z.na modyfikowa&_c. tylko w modyfikacji faktury ' )
      R := .T.
   CASE Left( LTrim( numer ), 3 ) == 'RS-'
      kom( 4, '*u', ' Symbole RS- mo&_z.na modyfikowa&_c. tylko poprzez rejestr sprzeda&_z.y ' )
      R := .T.
   CASE Left( LTrim( numer ), 3 ) == 'RZ-'
      kom( 4, '*u', ' Symbole RZ- mo&_z.na modyfikowa&_c. tylko poprzez rejestr zakupu ' )
      R := .T.
   ENDCASE
   RETURN R

*************************************
FUNCTION Zaplacono()
*************************************
   R := .T.
   BEGIN SEQUENCE
      @ 23,  0
      @ 24,  7 PROMPT '[ Zap&_l.acone ]'
      @ 24, 27 PROMPT '[ Cz&_e.&_s.ciowo zap&_l.acone ]'
      @ 24, 57 PROMPT '[ Niezap&_l.acone ]'
      zzaplata := Str( menu( Val( zzaplata ) ), 1 )
      IF LastKey() == K_ESC
         R := .F.
         BREAK
      ENDIF
      IF zzaplata == '2'
         @ 24, 0
         @ 24, 28 SAY 'Zap&_l.acono' GET zkwota PICTURE '   99999999.99' VALID v1_22()
         CLEAR TYPEAHEAD
         read_()
         IF LastKey() == K_ESC
            R := .F.
            BREAK
         ENDIF
         SET COLOR TO i
         @ 24, 38 SAY Kwota( zkwota, 14, 2 )
         SET COLOR TO
      ELSE
         zkwota := 0
      ENDIF
   END
   RETURN R

*************************************
PROCEDURE WrocStan()
*************************************
   SELECT tresc
   IF ! ins
      SEEK '+' + ident_fir + tresc_
      IF Found()
         BlokadaR()
         STANUJ
         COMMIT
         UNLOCK
      ENDIF
   ENDIF
   RETURN

*************************************
PROCEDURE AktKol( mnoz, kolum, wart )
*************************************
   koko := Val( AllTrim( kolum ) )
   IF zRYCZALT == 'T'
      BlokadaR()
      DO CASE
      CASE KOKO == 5
         AKTPOL+ ry20 WITH wart * mnoz
      CASE KOKO == 6
         AKTPOL+ ry17 WITH wart * mnoz
      CASE KOKO == 7
         AKTPOL+ uslugi WITH wart * mnoz
      CASE KOKO == 8
         AKTPOL+ wyr_tow WITH wart * mnoz
      CASE KOKO == 9
         AKTPOL+ handel WITH wart * mnoz
      CASE KOKO == 11
         AKTPOL+ ry10 WITH wart * mnoz
      ENDCASE
      COMMIT
      UNLOCK
   ELSE
      BlokadaR()
      DO CASE
      CASE KOKO == 7
         AKTPOL+ wyr_tow WITH wart * mnoz
      CASE KOKO == 8
         AKTPOL+ uslugi WITH wart * mnoz
      CASE KOKO == 10
         AKTPOL+ zakup WITH wart * mnoz
      CASE KOKO == 11
         AKTPOL+ uboczne WITH wart * mnoz
      CASE KOKO == 12
         AKTPOL+ wynagr_g WITH wart * mnoz
      CASE KOKO == 13 .OR. KOKO == 16
         AKTPOL+ wydatki WITH wart * mnoz
      ENDCASE
      COMMIT
      UNLOCK
   ENDIF
   RETURN

************************************
PROCEDURE IfIns( rrrec )
************************************
   IF ins
      app()
      ADDDOC
      IF rrrec > 0.0
         repl_( 'REC_NO', rrrec )
      ENDIF
   ENDIF
   RETURN

*############################################################################
FUNCTION wROZRget()

   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: T-kontroluj stan zap&_l.at, N-nie kontroluj stanu zap&_l.at', 80, ' ' )
   ColStd()
   RETURN .T.

***************************************************
FUNCTION vROZRget( vrozrpole, vrozrrow, vrozrcol )

   R := .T.
   IF &vROZRPOLE. <> 'T' .AND. &vROZRPOLE. <> 'N'
      ColInf()
      @ 24, 0 SAY PadC( 'Wpisz: T-kontroluj stan zap&_l.at, N-nie kontroluj stanu zap&_l.at', 80, ' ' )
      ColStd()
      R := .F.
   ELSE
      @ vrozrrow, vrozrcol + 1 SAY iif( &vROZRPOLE. == 'T', 'ak', 'ie' )
      @ 24, 0 CLEAR
   ENDIF
   RETURN R

*############################################################################
FUNCTION wZAP_DAT()

   zZAP_DAT := CToD( StrTran( param_rok + '.' + miesiac + '.' + Str( Val( zdzien ), 2 ), ' ', '0' ) ) + zZAP_TER
   RETURN .T.
*                 zZAP_DAT=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')

***************************************************
FUNCTION vZAP_DAT()

   zZAP_TER := zZAP_DAT - CToD( StrTran( param_rok + '.' + miesiac + '.' + Str( Val( zdzien ), 2 ), ' ', '0' ) )
   RETURN .T.
*                 zZAP_DAT=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')

PROCEDURE operRysujTlo()

   ColStd()
   @  3, 0 say 'Ú (2) Dzie&_n. miesi&_a.ca.......                                                     '
   @  4, 0 say '³ (3) Nr dowodu ksi&_e.gowego.                                                     '
   @  5, 0 say '³ (4) Kontrahent: nazwa....                                                     '
   @  6, 0 say '³ (5)             adres....                                                     '
   @  7, 0 say '³                   NIP....                                                     '
   @  8, 0 say 'ְ (6) Opis zdarzenia gospodarczego....                                          '
   @  9, 0 say 'Ú ----------------------------------PRZYCHODY---------------------------------- '
   @ 10, 0 say 'P (7) Warto&_s.&_c. sprzedanych towar&_o.w i us&_l.ug..........................             '
   @ 11, 0 say 'ְ (8) Pozosta&_l.e przychody..........................................             '
   @ 12, 0 say 'Ú(10) Zakup towar&_o.w handlowych i materia&_l.&_o.w wg cen zakupu..........             '
   @ 13, 0 say 'Z(11) Koszty uboczne zakupu........................................             '
   @ 14, 0 say 'ְ     RAZEM ZAKUPY.................................................             '
   @ 15, 0 say 'Ú(12) Wynagrodzenia w got&_o.wce i w naturze..........................             '
   @ 16, 0 say 'K(13) Pozosta&_l.e wydatki............................................             '
   @ 17, 0 say 'O(14) RAZEM KOSZTY.................................................             '
   @ 18, 0 say 'S(15) .............................................................             '
   @ 19, 0 say 'Z(16) Opis kosztu dziaˆalno˜ci badawczej.........                               '
   @ 20, 0 say 'T(16) Warto˜† kosztu dziaˆalno˜ci badawczej........................             '
   @ 21, 0 say 'ְ(17) Uwagi........................................................             '
   @ 22, 0 say 'Kontrola zaplat....  Termin zaplaty.... (..........) Juz zaplacono.             '
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION PolePaliwoStart()

   SetKey( Asc( 'P' ), { | cProcName, nProcLine, cReadVar | PolePaliwo( cProcName, nProcLine, cReadVar ) } )
   SetKey( Asc( 'p' ), { | cProcName, nProcLine, cReadVar | PolePaliwo( cProcName, nProcLine, cReadVar ) } )

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION PolePaliwoStop()

   SetKey( Asc( 'P' ), NIL )
   SetKey( Asc( 'p' ), NIL )

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION PolePaliwo( cProcName, nProcLine, cReadVar )

   LOCAL cEkran := SaveScreen( 0, 0, MaxRow(), MaxCol() )
   LOCAL cKolor := ColStd()
   LOCAL nNetto := 0, nWartosc := 0
   LOCAL GetList := {}
   LOCAL cVat := '23'
//   LOCAL lButton := .T.
   LOCAL cRodzaj := '7'

   IF Len( cReadVar ) > 0
      nNetto := &cReadVar
   ELSE
      RETURN NIL
   ENDIF

   @ 10, 3 CLEAR TO 17, 67
   @ 11, 6 TO 16, 66
   @ 12, 8 SAY "Warto˜† " + iif( zVAT == 'T' , "netto:", "brutto:" ) GET nNetto PICTURE FPIC
   IF zVAT == 'T'
      @ 13, 8 SAY "Stawka VAT:" GET cVat PICTURE '99'
   ENDIF
   @ 14, 8 SAY "Rodzaj odliczenia (1 - 100%, 2 - 20%, 7 - 75%):" GET cRodzaj PICTURE '9' VALID cRodzaj $ '127'
   @ 15, 8 SAY "Do ksi©gi:" GET nWartosc PICTURE FPIC WHEN PolePaliwoLicz( @nWartosc, nNetto, cVat, cRodzaj )
//   @ 14, 12 GET lButton PUSHBUTTON CAPTION ' Zatwierd« ' STATE { || ReadKill( .T. ) }
   READ

   IF LastKey() <> K_ESC
      &cReadVar := nWartosc
   ENDIF

   RestScreen( 0, 0, MaxRow(), MaxCol(), cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION PolePaliwoLicz( nWartosc, nNetto, cVat, cRodzaj )

   IF zVAT == 'T'
      nWartosc := nNetto + ( ( nNetto * ( Val( cVat ) / 100 ) ) * 0.5 )
   ELSE
      nWartosc := nNetto
   ENDIF

   DO CASE
   CASE cRodzaj == '1'

   CASE cRodzaj == '2'
      nWartosc := nWartosc * 0.2
   CASE cRodzaj == '7'
      nWartosc := nWartosc * 0.75
   ENDCASE

   RETURN .T.

/*----------------------------------------------------------------------*/

