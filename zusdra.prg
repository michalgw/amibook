/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha Gawrycki (gmsystems.pl)

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

PROCEDURE ZusDra( ubezp )

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou

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
   DO WHILE .NOT. Dostep( 'ETATY' )
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

   DO CASE
   CASE ubezp == 1
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
      Nufir2 := LO36( nufir )
      PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
         iif( Val( miesiac ) > 9, Chr( 55 + Val( miesiac ) ), AllTrim( miesiac ) ) + ;
         iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
         iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
         '9' + ;
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
      ilub := 0
      ilet := 0
      sum_eme := 0
      sum_ren := 0
      zwar_pue := 0
      zwar_pur := 0
      zwar_fue := 0
      zwar_fur := 0
      sum_cho := 0
      sum_wyp := 0
      zwar_puc := 0
      zwar_puw := 0
      zwar_fuc := 0
      zwar_fuw := 0
      zwar_puz := 0
      zwar_ffp := 0
      zwar_ffg := 0
      SELECT prac
      GO TOP
      SEEK '+' + ident_fir + '+'
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir .AND. status <= 'U'
         IF .NOT. Empty( DATA_PRZY )
            DOD := SubStr( DToS( DATA_PRZY ), 1, 6 ) <= param_rok + StrTran( miesiac, ' ', '0' )
         ELSE
            DOD := .F.
         ENDIF
         IF .NOT.Empty( DATA_ZWOL )
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
               ilub := ilub + 1
               ilet := ilet + ( wymiarl / wymiarm )
               sum_eme := sum_eme + war_pue + war_fue
               sum_ren := sum_ren + war_pur + war_fur
               zwar_pue := zwar_pue + war_pue
               zwar_pur := zwar_pur + war_pur
               zwar_fue := zwar_fue + war_fue
               zwar_fur := zwar_fur + war_fur
               sum_cho := sum_cho + war_puc + war_fuc
               sum_wyp := sum_wyp + war_puw + war_fuw
               zwar_puc := zwar_puc + war_puc
               zwar_puw := zwar_puw + war_puw
               zwar_fuc := zwar_fuc + war_fuc
               zwar_fuw := zwar_fuw + war_fuw
               zwar_puz := zwar_puz + war_puz
               zwar_ffp := zwar_ffp + war_ffp
               zwar_ffg := zwar_ffg + war_ffg
            ENDIF
         ENDIF
         SELECT prac
         SKIP
      ENDDO

      SELECT umowy
      GO TOP
      SEEK '+' + ident_fir + param_rok + StrTran( miesiac, ' ', '0' )
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir ;
         .AND. umowy->data_wyp >= hb_Date( Val( param_rok ), Val( miesiac ), 1 ) ;
         .AND. umowy->data_wyp <= EoM( hb_Date( Val( param_rok ), Val( miesiac ), 1 ) )

         IF umowy->war_psum <> 0 .OR. umowy->war_fsum <> 0 .OR. umowy->war_ffp <> 0 .OR. umowy->war_ffg <> 0
            ilub := ilub + 1
            //ilet := ilet + ( wymiarl / wymiarm )
            sum_eme := sum_eme + war_pue + war_fue
            sum_ren := sum_ren + war_pur + war_fur
            zwar_pue := zwar_pue + war_pue
            zwar_pur := zwar_pur + war_pur
            zwar_fue := zwar_fue + war_fue
            zwar_fur := zwar_fur + war_fur
            sum_cho := sum_cho + war_puc + war_fuc
            sum_wyp := sum_wyp + war_puw + war_fuw
            zwar_puc := zwar_puc + war_puc
            zwar_puw := zwar_puw + war_puw
            zwar_fuc := zwar_fuc + war_fuc
            zwar_fuw := zwar_fuw + war_fuw
            zwar_puz := zwar_puz + war_puz
            zwar_ffp := zwar_ffp + war_ffp
            zwar_ffg := zwar_ffg + war_ffg
         ENDIF

         SKIP

      ENDDO

      kedu_pocz()
      dp_pocz( 'DRA' )
      zus_pocz( 'DRA', 1 )
      dadra( '6', miesiac, param_rok )
      IF zSPOLKA = 'T'
         dipl( F->NIP, SubStr( F->NR_REGON, 3 ), '', '', '', iif( ! Empty( F->przedm ), F->przedm, F->nazwa_skr ), '', '', CToD( '    /  /  ' ) )
      ELSE
         subim := SubStr( A->NAZ_IMIE, At( ' ', A->NAZ_IMIE ) + 1 )
         dipl( A->NIP, SubStr( F->NR_REGON, 3 ), A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, iif( ! Empty( F->przedm ), F->przedm, F->nazwa_skr ), SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
      ENDIF
      inn7( ilub, ilet, parap_fuw )
      zsdrai( sum_eme, sum_ren, sum_eme + sum_ren, zwar_pue, zwar_pur, zwar_pue + zwar_pur, ;
         zwar_fue, zwar_fur, zwar_fue + zwar_fur, sum_cho, sum_wyp, sum_cho + sum_wyp, ;
         zwar_puc, zwar_puw, zwar_puc + zwar_puw, ;
         zwar_fuw, zwar_fuw + iif( paraz_wer == 2, zwar_fuc, 0 ), sum_eme + sum_ren + sum_cho + sum_wyp, zwar_fuc )
      zwdra()
      rivdra()
      zsdra( zwar_puz )
      zdrav( zwar_ffp, zwar_ffg, zwar_ffp + zwar_ffg )
      lskd()
      kndk()
      dddu( '', 0 )
      opls()
      ZUS_DataUtworzenia( 'XIII', 'p1' )
      zus_kon( 'DRA' )
      dp_kon( 'DRA' )
      kedu_kon()
      SET PRINTER TO
      SET CONSOLE ON
      SET PRINTER OFF
      SET DEVICE TO SCREEN
      kedu_rapo( plik_kdu )
      RESTORE SCREEN FROM scr2
      _disp := .F.
      Close_()

   CASE ubezp == 2
      *--------------------------------------
      SELECT firma
      *--------------------------------------
      @ 3, 42 CLEAR TO 22, 79
      IF .NOT. f->spolka
         SELECT spolka
         param_zu()
         jeden := zus_zglo()
         IF jeden # 1
            Close_()
            RETURN
         ENDIF
         SET DEVICE TO PRINTER
         SET CONSOLE OFF
         SET PRINTER ON
         NUFIR := Val( AllTrim( ident_fir ) )
         Nufir1 := HI36( nufir )
         Nufir2 := LO36( nufir )
         NUPLA := RecNo()
         Nupla1 := HI36( nupla )
         Nupla2 := LO36( nupla )
         PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
            iif( Val( miesiac ) > 9, Chr( 55 + Val( miesiac ) ), AllTrim( miesiac ) ) + ;
            iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
            iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
            '9' + ;
            'W' + ;
            iif( nupla1 > 9, Chr( 55 + nupla1 ), Str( nupla1, 1 ) ) + ;
            iif( nupla2 > 9, Chr( 55 + nupla2 ), Str( nupla2, 1 ) ) + '.' + iif( paraz_wer == 2, 'xml', 'kdu' )
         aaaa := AllTrim( paraz_cel ) + PLIK_KDU
         zident := Str( RecNo(), 5 )
         SELECT dane_mc
         SEEK '+' + zident + miesiac
         SELECT spolka
         SET PRINTER TO &aaaa
         kedu_pocz()
         dp_pocz( 'DRA' )
         zus_pocz( 'DRA', 1 )
         dadra( '6', miesiac, param_rok )
         *dipl rozne dla spolki i osoby fizycznej
         subim := SubStr( NAZ_IMIE, At( ' ', NAZ_IMIE ) + 1 )
         dipl( A->NIP, '', A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, A->NAZ_IMIE, SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
         inn7( 1, 0, d->staw_wuw )
         zsdrai( d->war_wue, d->war_wur, d->war_wue + d->war_wur, d->war_wue, d->war_wur, d->war_wue + d->war_wur, ;
            0, 0, 0, d->war_wuc, d->war_wuw, d->war_wuc + d->war_wuw, d->war_wuc, d->war_wuw, d->war_wuc + d->war_wuw, ;
            0, 0, d->war_wue + d->war_wur + d->war_wuc + d->war_wuw, 0 )
         zwdra()
         rivdra()
         zsdra( d->war_wuz )
         zdrav( d->war_wfp, d->war_wfg, d->war_wfp + d->war_wfg )
         lskd()
         kndk()
         dddu( A->KOD_TYTU, d->podstawa, d->podstzdr )
         opls()
         ZUS_DataUtworzenia( 'XIII', 'p1' )
         zus_kon( 'DRA' )
         dp_kon( 'DRA' )
         kedu_kon()
         SET PRINTER TO
         SET CONSOLE ON
         SET PRINTER OFF
         SET DEVICE TO SCREEN
         kedu_rapo( plik_kdu )
         Close_()
         RETURN
      ENDIF
      *################################# GRAFIKA ##################################
      ColStd()
      @  3, 44 SAY '            Podatnik:             '
      @  4, 44 SAY 'ษออออออออออออออออออออออออออออออออป'
      @  5, 44 SAY 'บ                                บ'
      @  6, 44 SAY 'บ                                บ'
      @  7, 44 SAY 'บ                                บ'
      @  8, 44 SAY 'บ                                บ'
      @  9, 44 SAY 'บ                                บ'
      @ 10, 44 SAY 'ศออออออออออออออออออออออออออออออออผ'
      *################################# OPERACJE #################################
      *----- parametry ------
      _row_g := 5
      _col_l := 45
      _row_d := 9
      _col_p := 76
      _invers := 'i'
      _curs_l := 0
      _curs_p := 0
      _esc := '27,28,13,1006'
      _top := 'firma#ident_fir'
      _bot := "del#'+'.or.firma#ident_fir"
      _stop := '+' + ident_fir
      _sbot := '+' + ident_fir + 'þ'
      _proc := 'linia12z()'
      _row := Int( ( _row_g + _row_d ) / 2 )
      _proc_spe := ''
      _disp := .T.
      _cls := ''
      *----------------------
      kl := 0
      DO WHILE kl # 27
         ColSta()
         @ 1, 47 SAY '[F1]-pomoc'
         SET COLOR TO
         SELECT spolka
         _row := wybor( _row )
         kl := LastKey()
         DO CASE
         *################################## ZESTAW_ #################################
         CASE kl == 13 .OR. kl == 1006
            SAVE SCREEN TO scr2
            nr_rec := RecNo()
            param_zu()
            jeden := zus_zglo()
            IF jeden # 1
               Close_()
               RETURN
            ENDIF
            SET DEVICE TO PRINTER
            SET CONSOLE OFF
            SET PRINTER ON
            NUFIR := Val( AllTrim( ident_fir ) )
            Nufir1 := HI36( nufir )
            Nufir2 := LO36( nufir )
            NUPLA := RecNo()
            Nupla1 := HI36( nupla )
            Nupla2 := LO36( nupla )
            PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
               iif( Val( miesiac ) > 9, Chr( 55 + Val( miesiac ) ), AllTrim( miesiac ) ) + ;
               iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
               iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
               '9' + ;
               'W' + ;
               iif( nupla1 > 9, Chr( 55 + nupla1 ), Str( nupla1, 1 ) ) + ;
               iif( nupla2 > 9, Chr( 55 + nupla2 ), Str( nupla2, 1 ) ) + ;
               '.' + iif( paraz_wer == 2, 'xml', 'kdu' )
            aaaa := AllTrim( paraz_cel ) + PLIK_KDU
            zident := Str( RecNo(), 5 )
            SELECT dane_mc
            SEEK '+' + zident + miesiac
            SELECT spolka
            SET PRINTER TO &aaaa
            kedu_pocz()
            dp_pocz('DRA')
            zus_pocz( 'DRA', 1 )
            dadra( '6', miesiac, param_rok )
            *dipl rozne dla spolki i osoby fizycznej
            subim := SubStr( NAZ_IMIE, At( ' ', NAZ_IMIE ) + 1 )
            dipl( A->NIP, '', A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, A->NAZ_IMIE, SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
            inn7( 1, 0, d->staw_wuw )
            zsdrai( d->war_wue, d->war_wur, d->war_wue + d->war_wur, d->war_wue, d->war_wur, d->war_wue + d->war_wur, ;
               0, 0, 0, d->war_wuc, d->war_wuw, d->war_wuc + d->war_wuw, d->war_wuc, d->war_wuw, d->war_wuc + d->war_wuw, ;
               0, 0, d->war_wue + d->war_wur + d->war_wuc + d->war_wuw, 0 )
            zwdra()
            rivdra()
            zsdra( d->war_wuz )
            zdrav( d->war_wfp, d->war_wfg, d->war_wfp + d->war_wfg )
            lskd()
            kndk()
            dddu( A->KOD_TYTU, d->podstawa, d->podstzdr )
            IF zRYCZALT <> 'T'
               nRodzaj := iif( spolka->sposob == 'L', 2, 1 )
            ELSE
               nRodzaj := iif( spolka->ryczstzdr $ '123', 4, 3 )
            ENDIF
            ZUS_FormaOpodat( nRodzaj, D->PODSTZDR, D->WAR_wUZ, D->dochodzdr, A->ryczprzpr, 'XI' )
            opls()
            ZUS_DataUtworzenia( 'XIII', 'p1' )
            zus_kon( 'DRA' )
            dp_kon('DRA')
            kedu_kon()
            SET PRINTER TO
            SET PRINTER OFF
            SET CONSOLE ON
            SET DEVICE TO SCREEN
            kedu_rapo( plik_kdu )
            GO nr_rec
            RESTORE SCREEN FROM scr2
            _disp := .F.
         *################################### POMOC ##################################
         case kl == 28
            SAVE SCREEN TO scr_
            @ 1, 47 SAY '          '
            DECLARE p[ 20 ]
            *---------------------------------------
            p[ 1 ] := '                                                        '
            p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
            p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
            p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
            p[ 5 ] := '   [Enter].................akceptacja                   '
            p[ 6 ] := '   [Esc]...................wyj&_s.cie                      '
            p[ 7 ] := '                                                        '
            *---------------------------------------
            SET COLOR TO i
            i := 20
            j := 24
            DO WHILE i > 0
               IF Type( 'p[i]' ) # 'U'
                  Center( j, p[ i ] )
                  j := j - 1
               ENDIF
               i := i - 1
            ENDDO
            SET COLOR TO
            pause( 0 )
            IF LastKey() # 27 .AND. LastKey() # 28
               KEYBOARD Chr( LastKey() )
            ENDIF
            RESTORE SCREEN FROM scr_
            _disp := .F.
         ******************** ENDCASE
         ENDCASE
      ENDDO
      Close_()

   CASE ubezp == 3
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
      Nufir2 := LO36( nufir )
      PLIK_KDU := SubStr( param_rok, 4, 1 ) + ;
         iif( Val( miesiac ) > 9, Chr( 55 + Val( miesiac ) ), AllTrim( miesiac ) ) + ;
         iif( nufir1 > 9, Chr( 55 + nufir1 ), Str( nufir1, 1 ) ) + ;
         iif( nufir2 > 9, Chr( 55 + nufir2 ), Str( nufir2, 1 ) ) + ;
         '9' + ;
         'F' + ;
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
      ilub := 0
      ilet := 0
      sum_eme := 0
      sum_ren := 0
      zwar_pue := 0
      zwar_pur := 0
      zwar_fue := 0
      zwar_fur := 0
      sum_cho := 0
      sum_wyp := 0
      zwar_puc := 0
      zwar_puw := 0
      zwar_fuc := 0
      zwar_fuw := 0
      zwar_puz := 0
      zwar_ffp := 0
      zwar_ffg := 0
      SELECT prac
      GO TOP
      SEEK '+' + ident_fir + '+'
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir .AND. status <= 'U'
         IF .NOT.Empty( DATA_PRZY )
            DOD := SubStr( DToS( DATA_PRZY ), 1, 6 ) <= param_rok + StrTran( miesiac, ' ', '0' )
         ELSE
            DOD := .F.
         ENDIF
         IF .NOT. Empty( DATA_ZWOL )
            DDO := SubStr( DToS( DATA_ZWOL ), 1, 6 )>= param_rok + StrTran( miesiac, ' ', '0' )
            IF SubStr( DToS( DATA_ZWOL), 1, 6 ) == param_rok + StrTran( miesiac, ' ', '0' )
               PROZWOL := DToC( DATA_ZWOL )
            ENDIF
         ELSE
            PROZWOL := ''
            DDO := .T.
         ENDIF
         IF DOD.AND.DDO=.T.
            SELECT etaty
            SEEK '+' + ident_fir + miesiac + Str( prac->rec_no, 5 )
            IF Found()
               ilub := ilub + 1
               ilet := ilet + ( wymiarl / wymiarm )
               sum_eme := sum_eme + war_pue + war_fue
               sum_ren := sum_ren + war_pur + war_fur
               zwar_pue := zwar_pue + war_pue
               zwar_pur := zwar_pur + war_pur
               zwar_fue := zwar_fue + war_fue
               zwar_fur := zwar_fur + war_fur
               sum_cho := sum_cho + war_puc + war_fuc
               sum_wyp := sum_wyp + war_puw + war_fuw
               zwar_puc := zwar_puc + war_puc
               zwar_puw := zwar_puw + war_puw
               zwar_fuc := zwar_fuc + war_fuc
               zwar_fuw := zwar_fuw + war_fuw
               zwar_puz := zwar_puz + war_puz
               zwar_ffp := zwar_ffp + war_ffp
               zwar_ffg := zwar_ffg + war_ffg
            ENDIF
         ENDIF
         SELECT prac
         SKIP
      ENDDO

      SELECT umowy
      GO TOP
      SEEK '+' + ident_fir + param_rok + StrTran( miesiac, ' ', '0' )
      DO WHILE .NOT. Eof() .AND. del = '+' .AND. firma = ident_fir ;
         .AND. umowy->data_wyp >= hb_Date( Val( param_rok ), Val( miesiac ), 1 ) ;
         .AND. umowy->data_wyp <= EoM( hb_Date( Val( param_rok ), Val( miesiac ), 1 ) )

         IF umowy->war_psum <> 0 .OR. umowy->war_fsum <> 0 .OR. umowy->war_ffp <> 0 .OR. umowy->war_ffg <> 0
            ilub := ilub + 1
            //ilet := ilet + ( wymiarl / wymiarm )
            sum_eme := sum_eme + war_pue + war_fue
            sum_ren := sum_ren + war_pur + war_fur
            zwar_pue := zwar_pue + war_pue
            zwar_pur := zwar_pur + war_pur
            zwar_fue := zwar_fue + war_fue
            zwar_fur := zwar_fur + war_fur
            sum_cho := sum_cho + war_puc + war_fuc
            sum_wyp := sum_wyp + war_puw + war_fuw
            zwar_puc := zwar_puc + war_puc
            zwar_puw := zwar_puw + war_puw
            zwar_fuc := zwar_fuc + war_fuc
            zwar_fuw := zwar_fuw + war_fuw
            zwar_puz := zwar_puz + war_puz
            zwar_ffp := zwar_ffp + war_ffp
            zwar_ffg := zwar_ffg + war_ffg
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
            ilub := ilub + 1
            *ilet=ilet+1
            sum_eme := sum_eme + war_wue
            sum_ren := sum_ren + war_wur
            zwar_pue := zwar_pue + war_wue
            zwar_pur := zwar_pur + war_wur
            sum_cho := sum_cho + war_wuc
            sum_wyp := sum_wyp + war_wuw
            zwar_puc := zwar_puc + war_wuc
            zwar_puw := zwar_puw + war_wuw
            zwar_puz := zwar_puz + war_wuz
            zwar_ffp := zwar_ffp + war_wfp
            zwar_ffg := zwar_ffg + war_wfg
         ENDIF
         SELECT spolka
         SKIP
      ENDDO
      SEEK '+' + ident_fir

      SELECT prac

      kedu_pocz()
      dp_pocz( 'DRA' )
      zus_pocz( 'DRA', 1 )
      dadra( '6', miesiac, param_rok )
      IF zSPOLKA = 'T'
         dipl( F->NIP, SubStr( F->NR_REGON, 3 ), '', '', '', iif( ! Empty( F->przedm ), F->przedm, F->nazwa_skr ), '', '', CToD( '    /  /  ' ) )
      ELSE
         subim := SubStr( A->NAZ_IMIE, At( ' ', A->NAZ_IMIE ) + 1 )
         dipl( A->NIP, SubStr( F->NR_REGON, 3 ), A->PESEL, A->RODZ_DOK, A->DOWOD_OSOB, iif( ! Empty( F->przedm ), F->przedm, F->nazwa_skr ), SubStr( A->NAZ_IMIE, 1, At( ' ', A->NAZ_IMIE ) ), SubStr( subim, 1, At( ' ', subim ) ), A->DATA_UR )
      ENDIF
      *dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')
      inn7( ilub, ilet, parap_fuw )
      zsdrai( sum_eme, sum_ren, sum_eme + sum_ren, zwar_pue, zwar_pur, zwar_pue + zwar_pur, ;
         zwar_fue, zwar_fur, zwar_fue + zwar_fur, sum_cho, sum_wyp, sum_cho + sum_wyp, ;
         zwar_puc, zwar_puw, zwar_puc + zwar_puw, ;
         zwar_fuw, zwar_fuw + iif( paraz_wer == 2, zwar_fuc, 0 ), sum_eme + sum_ren + sum_cho + sum_wyp, zwar_fuc )
      zwdra()
      rivdra()
      zsdra( zwar_puz )
      zdrav( zwar_ffp, zwar_ffg, zwar_ffp + zwar_ffg )
      lskd()
      kndk()
      dddu( '', 0 )
      opls()
      ZUS_DataUtworzenia( 'XIII', 'p1' )
      zus_kon( 'DRA' )
      dp_kon( 'DRA' )
      kedu_kon()
      SET PRINTER TO
      SET CONSOLE ON
      SET PRINTER OFF
      SET DEVICE TO SCREEN
      kedu_rapo( plik_kdu )
      RESTORE SCREEN FROM scr2
      _disp := .F.
      Close_()
   ENDCASE

   RETURN
