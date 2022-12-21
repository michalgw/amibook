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

PROCEDURE ZusRca( ubezp )

   LOCAL nNumBlok := 1, nRodzaj
   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou

   @ 1, 47 SAY '          '

   *############################### OTWARCIE BAZ ###############################

   SELECT 6
   IF Dostep( 'FIRMA' )
      GO Val( ident_fir )
   ELSE
      RETURN
   ENDIF
   zspolka := iif( spolka, 'T', 'N' )

   SELECT 5
   IF Dostep( 'UMOWY' )
      SetInd( 'UMOWY' )
      SET ORDER TO 4
   ELSE
      Close_()
      RETURN
   ENDIF

   SELECT 4
   IF Dostep( 'DANE_MC' )
      SET INDEX TO dane_mc
   ELSE
      Close_()
      RETURN
   ENDIF

   SELECT 3
   DO WHILE.NOT.Dostep( 'ETATY' )
   ENDDO
   SetInd( 'ETATY' )
   SET ORDER TO 2

   SELECT 2
   IF Dostep( 'PRAC' )
      SetInd( 'PRAC' )
      SET ORDER TO 2
   ELSE
      Close_()
      RETURN
   ENDIF

   SELECT 1
   IF Dostep( 'SPOLKA' )
      SetInd( 'SPOLKA' )
      SEEK '+' + ident_fir
   ELSE
      Close_()
      RETURN
   ENDIF

   IF del # '+' .OR. firma # ident_fir
      Kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ' )
      Close_()
      RETURN
   ENDIF

   IF ubezp == 2
      @ 3, 42 CLEAR TO 22, 79
      SAVE SCREEN TO scr2
      *--------------------------------------
      param_zu()
      jeden := zus_zglo()

      IF jeden # 1
         Close_()
         RETURN
      ENDIF
      SET CONSOLE OFF
      SET DEVICE TO PRINTER
      SET PRINTER ON
      NUFIR := Val( AllTrim( ident_fir ) )
      Nufir1 := HI36( nufir )
      nufir2 := LO36( nufir )
      PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
         iif( Val( miesiac ) > 9, Chr( 55 + Val( miesiac ) ), AllTrim( miesiac ) ) + ;
         iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
         iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
         '8' + ;
         'F' + ;
         '0' + ;
         '0.' + iif( paraz_wer == 2, 'xml', 'kdu' )
      aaaa := AllTrim( paraz_cel ) + PLIK_KDU
      SET PRINTER TO &aaaa

      DO CASE
      CASE miesiac = ' 1' .OR. miesiac = ' 3' .OR. miesiac = ' 5' .OR. miesiac = ' 7' .OR. miesiac = ' 8' .OR. miesiac = '10' .OR. miesiac = '12'
         DAYM := '31'
      CASE miesiac =' 4' .OR. miesiac = ' 6' .OR. miesiac = ' 9' .OR. miesiac = '11'
         DAYM := '30'
      CASE miesiac = ' 2'
         DAYM := '29'
         IF Day( CToD( param_rok + '.' + miesiac + '.' + DAYM ) ) = 0
              DAYM := '28'
         ENDIF
      ENDCASE
      DDAY := CToD( param_rok + '.' + miesiac + '.' + DAYM )

      kedu_pocz()
      dp_pocz( 'RCA' )
      zus_pocz( 'RCA', 1 )
      dorca( miesiac, param_rok, 0 )
      IF zSPOLKA = 'T'
         dipl( F->NIP, SubStr( F->NR_REGON, 3 ), '', '', '', iif( ! Empty( F->przedm ), F->przedm, F->nazwa_skr ), '', '', CToD( '    /  /  ' ) )
      ELSE
         subim := SubStr( A->NAZ_IMIE, At( ' ', A->NAZ_IMIE ) + 1 )
         dipl( A->NIP, SubStr( F->NR_REGON, 3 ), A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, iif( ! Empty( F->przedm ), F->przedm, F->nazwa_skr ), SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
      ENDIF
      *dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')

      SELECT prac
      GO TOP
      SEEK '+' + ident_fir + '+'
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir .AND. status <= 'U'
         IF .NOT. Empty( DATA_PRZY )
            DOD := SubStr( DToS( DATA_PRZY ), 1, 6 ) <= param_rok + StrTran( miesiac, ' ', '0' )
         ELSE
            DOD := .F.
         ENDIF
         IF .NOT. Empty( DATA_ZWOL )
            DDO := SubStr( DToS( DATA_ZWOL ), 1, 6 ) >= param_rok + StrTran( miesiac, ' ', '0' )
            IF SubStr( DToS( DATA_ZWOL ), 1, 6 ) == param_rok + StrTran( miesiac, ' ', '0' )
               PROZWOL := DToC( DATA_ZWOL )
            ENDIF
         ELSE
            PROZWOL := ''
            DDO := .T.
         ENDIF
         IF DOD .AND. DDO = .T.
            SELECT etaty
            SEEK '+' + ident_fir + miesiac + Str( prac->rec_no, 5 )
            IF Found()
               ddorca( PRAC->NAZWISKO,;
                  PRAC->IMIE1,;
                  iif( .NOT. Empty( PRAC->PESEL ), 'P', iif( .NOT. Empty( PRAC->NIP ), 'N', PRAC->RODZ_DOK ) ), ;
                  iif( .NOT. Empty( PRAC->PESEL ), PRAC->PESEL, iif( .NOT. Empty( PRAC->NIP ), PRAC->NIP, PRAC->DOWOD_OSOB ) ), ;
                  ETATY->KOD_TYTU, ;
                  ZUSWYMIAR( ETATY->WYMIARL,ETATY->WYMIARM ), ;
                  ETATY->PENSJA - ETATY->DOPL_BZUS - ETATY->ZASI_BZUS, ;
                  ETATY->PENSJA - ETATY->DOPL_BZUS - ETATY->ZASI_BZUS, ;
                  ETATY->BRUT_RAZEM - ( ETATY->DOPL_BZUS + ETATY->ZASI_BZUS + ETATY->WAR_PF3 + ETATY->WAR_PSUM ), ;
                  ETATY->WAR_PUE, ;
                  ETATY->WAR_PUR, ;
                  ETATY->WAR_PUC, ;
                  ETATY->WAR_PUZ, ;
                  ETATY->WAR_FUE, ;
                  ETATY->WAR_FUR, ;
                  ETATY->WAR_FUW, ;
                  ETATY->WAR_PF3, ;
                  ETATY->WAR_PSUM + iif( paraz_wer == 2, 0, ETATY->WAR_PUZ ) + ETATY->WAR_FSUM - ( ETATY->WAR_FFP + ETATY->WAR_FFG ), ;
                  ETATY->ILOSO_RODZ, ;
                  ETATY->ZASIL_RODZ, ;
                  ETATY->ILOSO_PIEL, ;
                  ETATY->ZASIL_PIEL, ;
                  ETATY->ZASIL_PIEL + ETATY->ZASIL_RODZ, ;
                  nNumBlok )
               nNumBlok++
            ENDIF
         ENDIF
         SELECT prac
         SKIP
      ENDDO

      SELECT prac
      SET ORDER TO 4

      SELECT umowy
      GO TOP
      SEEK '+' + ident_fir + param_rok + StrTran( miesiac, ' ', '0' )
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir ;
         .AND. umowy->data_wyp >= hb_Date( Val( param_rok ), Val( miesiac ), 1 ) ;
         .AND. umowy->data_wyp <= EoM( hb_Date( Val( param_rok ), Val( miesiac ), 1 ) )

         IF umowy->war_psum <> 0 .OR. umowy->war_fsum <> 0 .OR. umowy->war_ffp <> 0 .OR. umowy->war_ffg <> 0

            prac->( dbSeek( Val( umowy->ident ) ) )

            IF prac->( Found() ) .AND. prac->del == '+' .AND. prac->firma == ident_fir

               ddorca( PRAC->NAZWISKO,;
                  PRAC->IMIE1,;
                  iif( .NOT. Empty( PRAC->PESEL ), 'P', iif( .NOT. Empty( PRAC->NIP ), 'N', PRAC->RODZ_DOK ) ), ;
                  iif( .NOT. Empty( PRAC->PESEL ), PRAC->PESEL, iif( .NOT. Empty( PRAC->NIP ), PRAC->NIP, PRAC->DOWOD_OSOB ) ), ;
                  UMOWY->KOD_TYTU, ;
                  '', ;
                  UMOWY->PENSJA, ;
                  iif( UMOWY->WAR_PUC == 0, 0, UMOWY->PENSJA ), ;
                  UMOWY->PENSJA - ( UMOWY->WAR_PF3 + UMOWY->WAR_PSUM ), ;
                  UMOWY->WAR_PUE, ;
                  UMOWY->WAR_PUR, ;
                  UMOWY->WAR_PUC, ;
                  UMOWY->WAR_PUZ, ;
                  UMOWY->WAR_FUE, ;
                  UMOWY->WAR_FUR, ;
                  UMOWY->WAR_FUW, ;
                  UMOWY->WAR_PF3, ;
                  UMOWY->WAR_PSUM + iif( paraz_wer == 2, 0, UMOWY->WAR_PUZ ) + UMOWY->WAR_FSUM - ( UMOWY->WAR_FFP + UMOWY->WAR_FFG ), ;
                  0, ;
                  0, ;
                  0, ;
                  0, ;
                  0, ;
                  nNumBlok )

               nNumBlok++

            ENDIF

         ENDIF

         SKIP

      ENDDO

      SELECT spolka
      GO TOP
      SEEK '+' + ident_fir
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir
         zident := Str( RecNo(), 5 )
         SELECT dane_mc
         SEEK '+' + zident + miesiac
         IF Found()
            IF zRYCZALT <> 'T'
               nRodzaj := iif( spolka->sposob == 'L', 2, 1 )
            ELSE
               nRodzaj := iif( spolka->ryczstzdr $ '123', 4, 3 )
            ENDIF
            subim := SubStr( A->NAZ_IMIE, At( ' ', A->NAZ_IMIE ) + 1 )
            ddorca( SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), ;
               SubStr( subim, 1, At( ' ', subim ) ), ;
               iif( .NOT. Empty( A->PESEL ), 'P', iif( .NOT. Empty( A->NIP ), 'N', A->RODZ_DOK ) ), ;
               iif( .NOT. Empty( A->PESEL ), A->PESEL, iif( .NOT. Empty( A->NIP ), A->NIP, A->DOWOD_OSOB ) ), ;
               A->KOD_TYTU, ;
               '      ', ;
               D->PODSTAWA, ;
               D->PODSTAWA, ;
               D->PODSTZDR, ;
               D->WAR_wUE, ;
               D->WAR_wUR, ;
               D->WAR_wUC, ;
               D->WAR_wUZ, ;
               0, ;
               0, ;
               D->war_wuw, ;
               0, ;
               D->WAR_wue + D->war_wur + D->war_wuc + iif( paraz_wer == 2, 0, D->WAR_wUZ ) + D->WAR_wuw, ;
               0, ;
               0, ;
               0, ;
               0, ;
               0, ;
               nNumBlok, nRodzaj, D->dochodzdr, A->ryczprzpr )

            nNumBlok++
         ENDIF
         SELECT spolka
         SKIP
      ENDDO

      oplr()
      zus_kon( 'RCA' )
      dp_kon('RCA')
      kedu_kon()
      SET PRINTER TO
      SET CONSOLE ON
      SET PRINTER OFF
      SET DEVICE TO SCREEN
      kedu_rapo( plik_kdu )
      Close_()
      RESTORE SCREEN FROM scr2
      _disp := .F.
   ELSE
      @ 3, 42 CLEAR TO 22, 79
      SAVE SCREEN TO scr2
      *--------------------------------------
      param_zu()
      jeden := zus_zglo()
      IF jeden # 1
         Close_()
         RETURN
      ENDIF
      SET CONSOLE OFF
      SET DEVICE TO PRINTER
      SET PRINTER ON
      NUFIR := Val( AllTrim( ident_fir ) )
      Nufir1 := HI36( nufir )
      nufir2 := LO36( nufir )
      PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
         iif( Val( miesiac ) > 9, Chr( 55 + Val( miesiac ) ), AllTrim( miesiac ) ) + ;
         iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
         iif( nufir2 > 9, Chr( 55 + nufir2 ), str( nufir2, 1 ) ) + ;
         '8' + ;
         'P' + ;
         '0' + ;
         '0.' + iif( paraz_wer == 2, 'xml', 'kdu' )
      aaaa := AllTrim( paraz_cel ) + PLIK_KDU
      SET PRINTER TO &aaaa

      DO CASE
      CASE miesiac = ' 1' .OR. miesiac = ' 3' .OR. miesiac = ' 5' .OR. miesiac = ' 7' .OR. miesiac = ' 8' .OR. miesiac = '10' .OR. miesiac = '12'
         DAYM := '31'
      CASE miesiac = ' 4' .OR. miesiac = ' 6' .OR. miesiac = ' 9' .OR. miesiac = '11'
         DAYM := '30'
      CASE miesiac = ' 2'
         DAYM := '29'
         IF Day( CToD( param_rok + '.' + miesiac + '.' + DAYM ) ) = 0
            DAYM := '28'
         ENDIF
      ENDCASE
      DDAY := CToD( param_rok + '.' + miesiac + '.' + DAYM )

      kedu_pocz()
      dp_pocz('RCA')
      zus_pocz( 'RCA', 1 )
      dorca( miesiac, param_rok, 0 )
      IF zSPOLKA = 'T'
         dipl( F->NIP, SubStr( F->NR_REGON, 3 ), '', '', '', iif( ! Empty( F->przedm ), F->przedm, F->nazwa_skr ), '', '', CToD( '    /  /  ' ) )
      ELSE
         subim := SubStr( A->NAZ_IMIE, At( ' ', A->NAZ_IMIE ) + 1 )
         dipl( A->NIP, substr( F->NR_REGON, 3 ), A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, iif( ! Empty( F->przedm ), F->przedm, F->nazwa_skr ), SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
      ENDIF
      *dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')

      SELECT prac
      GO TOP
      SEEK '+'+ident_fir+'+'
      brakpra := .F.
      IF Found()
         DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir .AND. status <= 'U'
            IF .NOT. Empty( DATA_PRZY )
               DOD := SubStr( DToS( DATA_PRZY ), 1, 6 ) <= param_rok + StrTran( miesiac, ' ', '0' )
            ELSE
               DOD := .F.
            ENDIF
            IF .NOT. Empty( DATA_ZWOL )
               DDO := SubStr( DToS( DATA_ZWOL ), 1, 6 ) >= param_rok + StrTran( miesiac, ' ', '0' )
               IF SubStr( DToS( DATA_ZWOL ), 1, 6 ) == param_rok + StrTran( miesiac, ' ', '0' )
                  PROZWOL := DToC( DATA_ZWOL )
               ENDIF
            ELSE
               PROZWOL := ''
               DDO := .T.
            ENDIF
            SELECT etaty
            SEEK '+' + ident_fir + miesiac + Str( prac->rec_no, 5 )
            IF DOD .AND. DDO = .T.
               SELECT etaty
               SEEK '+' + ident_fir + miesiac + Str( prac->rec_no, 5 )
               IF Found()
                  ddorca( PRAC->NAZWISKO, ;
                     PRAC->IMIE1, ;
                     iif( .NOT. Empty( PRAC->PESEL ), 'P', iif( .NOT. Empty( PRAC->NIP ), 'N', PRAC->RODZ_DOK ) ), ;
                     iif( .NOT. Empty( PRAC->PESEL ), PRAC->PESEL, iif( .NOT. Empty( PRAC->NIP ), PRAC->NIP, PRAC->DOWOD_OSOB ) ), ;
                     ETATY->KOD_TYTU, ;
                     ZUSWYMIAR( ETATY->WYMIARL, ETATY->WYMIARM ), ;
                     ETATY->PENSJA - ETATY->DOPL_BZUS - ETATY->ZASI_BZUS, ;
                     ETATY->PENSJA - ETATY->DOPL_BZUS - ETATY->ZASI_BZUS, ;
                     ETATY->BRUT_RAZEM - ( ETATY->DOPL_BZUS + ETATY->ZASI_BZUS + ETATY->WAR_PF3 + ETATY->WAR_PSUM ), ;
                     ETATY->WAR_PUE, ;
                     ETATY->WAR_PUR, ;
                     ETATY->WAR_PUC, ;
                     ETATY->WAR_PUZ, ;
                     ETATY->WAR_FUE, ;
                     ETATY->WAR_FUR, ;
                     ETATY->WAR_FUW, ;
                     ETATY->WAR_PF3, ;
                     ETATY->WAR_PSUM + ETATY->WAR_PUZ + ETATY->WAR_FSUM - ( ETATY->WAR_FFP + ETATY->WAR_FFG ), ;
                     ETATY->ILOSO_RODZ, ;
                     ETATY->ZASIL_RODZ, ;
                     ETATY->ILOSO_PIEL, ;
                     ETATY->ZASIL_PIEL, ;
                     ETATY->ZASIL_PIEL + ETATY->ZASIL_RODZ, ;
                     nNumBlok )
                  nNumBlok++
               ELSE
                  brakpra := .T.
                  EXIT
               ENDIF
            ENDIF
            SELECT prac
            SKIP
         ENDDO
      ELSE
         brakpra := .T.
      ENDIF

      SELECT prac
      SET ORDER TO 4

      SELECT umowy
      GO TOP
      SEEK '+' + ident_fir + param_rok + StrTran( miesiac, ' ', '0' )
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir ;
         .AND. umowy->data_wyp >= hb_Date( Val( param_rok ), Val( miesiac ), 1 ) ;
         .AND. umowy->data_wyp <= EoM( hb_Date( Val( param_rok ), Val( miesiac ), 1 ) )

         IF umowy->war_psum <> 0 .OR. umowy->war_fsum <> 0 .OR. umowy->war_ffp <> 0 .OR. umowy->war_ffg <> 0

            prac->( dbSeek( Val( umowy->ident ) ) )

            IF prac->( Found() ) .AND. prac->del == '+' .AND. prac->firma == ident_fir

               brakpra := .F.
               ddorca( PRAC->NAZWISKO,;
                  PRAC->IMIE1,;
                  iif( .NOT. Empty( PRAC->PESEL ), 'P', iif( .NOT. Empty( PRAC->NIP ), 'N', PRAC->RODZ_DOK ) ), ;
                  iif( .NOT. Empty( PRAC->PESEL ), PRAC->PESEL, iif( .NOT. Empty( PRAC->NIP ), PRAC->NIP, PRAC->DOWOD_OSOB ) ), ;
                  UMOWY->KOD_TYTU, ;
                  '', ;
                  UMOWY->PENSJA, ;
                  iif( UMOWY->WAR_PUC == 0, 0, UMOWY->PENSJA ), ;
                  UMOWY->PENSJA - ( UMOWY->WAR_PF3 + UMOWY->WAR_PSUM ), ;
                  UMOWY->WAR_PUE, ;
                  UMOWY->WAR_PUR, ;
                  UMOWY->WAR_PUC, ;
                  UMOWY->WAR_PUZ, ;
                  UMOWY->WAR_FUE, ;
                  UMOWY->WAR_FUR, ;
                  UMOWY->WAR_FUW, ;
                  UMOWY->WAR_PF3, ;
                  UMOWY->WAR_PSUM + iif( paraz_wer == 2, 0, UMOWY->WAR_PUZ ) + UMOWY->WAR_FSUM - ( UMOWY->WAR_FFP + UMOWY->WAR_FFG ), ;
                  0, ;
                  0, ;
                  0, ;
                  0, ;
                  0, ;
                  nNumBlok )

               nNumBlok++

            ENDIF

         ENDIF

         SKIP

      ENDDO

      oplr()
      zus_kon( 'RCA' )
      dp_kon( 'RCA' )
      kedu_kon()
      SET PRINTER TO
      SET CONSOLE ON
      SET PRINTER OFF
      SET DEVICE TO SCREEN
      IF brakpra = .T.
         Komun( 'Brak p&_l.ac. Niemo&_z.liwe jest utworzenie prawid&_l.owego pliku dla P&_l.atnika' )
      ELSE
         kedu_rapo( plik_kdu )
      ENDIF
      Close_()
      RESTORE SCREEN FROM scr2
      _disp := .F.
   endif
   Close_()

   RETURN
