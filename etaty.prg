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
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Etaty( mieskart )

   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,kluc,ins,nr_rec,wiersz,f10,rec,fou,mieslok
   PUBLIC z_dowyp

   zData_wwyp := Date()
   zkwota_wwyp := 0
   mieslok := mieskart
   FOR x := 1 TO 12
       xx := StrTran( Str( x, 2 ), ' ', '0' )
       zK_WYP&XX := 0
       zK_ZAL&XX := 0
       zDO_PIT4&XX := '    .  '
       zD_ZAL&XX := CToD( '    .  .  ' )
   NEXT
   @ 1,  47 SAY '          '
   *################################# GRAFIKA ##################################
   @  3,  0 SAY '        K A R T O T E K I   W Y N A G R O D Z E &__N.   P R A C O W N I K &__O. W       '
   @  4,  0 SAY 'ÚÄÄÄÄÄWyp&_l.a&_c. wszystkim...ÄÄÄÄÄ¿ Przyj&_e.to:             Zwolniono.:               '
   @  5,  0 SAY '³                             ³ Odlicza&_c. podatek:     O˜wi. <26r.:     PPK:     '
   @  6,  0 SAY '³                             ³ Wykszta&_l.c:                                      '
   @  7,  0 SAY '³                             ³ Zaw&_o.d....:                       Przedˆ.term:   '
   @  8,  0 SAY '³                             ³ M-c PRZYCH. DO WYP&__L.A. Wyp&_l.aty Wp&_l..podat. Do PIT4'
   @  9,  0 SAY '³                             ³  1                                              '
   @ 10,  0 SAY '³                             ³  2                                              '
   @ 11,  0 SAY '³                             ³  3                                              '
   @ 12,  0 SAY '³                             ³  4                                              '
   @ 13,  0 SAY '³                             ³  5                                              '
   @ 14,  0 SAY '³                             ³  6                                              '
   @ 15,  0 SAY '³                             ³  7                                              '
   @ 16,  0 SAY '³                             ³  8                                              '
   @ 17,  0 SAY '³                             ³  9                                              '
   @ 18,  0 SAY '³                             ³ 10                                              '
   @ 19,  0 SAY '³                             ³ 11                                              '
   @ 20,  0 SAY '³                             ³ 12                                              '
   @ 21,  0 SAY 'ÀÄ(       )ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙSUMA                                             '
   @ 22,  0 SAY ' UWAGI:                                                                         '
   ColInf()
   @  4,  7 SAY 'y'
   @  8, 54 SAY 'W'
   @  8, 66 SAY 'p'
   @  8, 79 SAY '4'
   SET COLOR TO

   *############################### OTWARCIE BAZ ###############################
   SELECT 6
   DO WHILE .NOT. Dostep( 'PRAC_HZ' )
   ENDDO
   SetInd( 'PRAC_HZ' )
   SEEK '+' + ident_fir
   SELECT 5
   DO WHILE .NOT. Dostep( 'ZALICZKI' )
   ENDDO
   SetInd( 'ZALICZKI' )
   SEEK '+' + ident_fir
   SELECT 4
   DO WHILE .NOT. Dostep( 'WYPLATY' )
   ENDDO
   SetInd( 'WYPLATY' )
   SEEK '+' + ident_fir
   SELECT 3
   DO WHILE .NOT. Dostep( 'NIEOBEC' )
   ENDDO
   SetInd( 'NIEOBEC' )
   SEEK '+' + ident_fir
   SELECT 2
   DO WHILE .NOT. Dostep( 'ETATY' )
   ENDDO
   SetInd( 'ETATY' )
   SEEK '+' + ident_fir
   SELECT 1
   DO WHILE .NOT. Dostep( 'PRAC' )
   ENDDO
   SetInd( 'PRAC' )
   SET ORDER TO 2
   SET FILTER TO prac->aktywny == 'T'
   SEEK '+' + ident_fir + '+'
   IF Eof() .OR. del # '+' .OR. firma # ident_fir .OR. status > 'U'
      kom( 3, '*u', ' Brak pracownik&_o.w etatowych ' )
      RETURN
   ENDIF

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 5
   _col_l := 1
   _row_d := 20
   _col_p := 29
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,13,247,75,107,77,109,7,28,80,87,89,112,119,121,52,1006,71,103,72,104'
   _top := "firma#ident_fir.or.status>'U'"
   _bot := "del#'+'.or.firma#ident_fir.or.status>'U'"
   _stop := '+' + ident_fir + '+'
   _sbot := '+' + ident_fir + '+' + 'þ'
   _proc := 'say41e()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'say41es'
   _disp := .T.
   _cls := ''
   *----------------------
   kl := 0
   siacpla := '  '
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      CASE kl == 13 .OR. kl == 1006
         SAVE SCREEN TO robs
         IF Empty( data_przy )
            kom( 3, '*u', ' Brak daty przyj&_e.cia do pracy ' )
         ELSE
            IF ! Empty( data_zwol ) .AND. data_zwol < hb_Date( Val( param_rok ), 1, 1 ) ;
               .AND. ! TNEsc( , 'Pracownik zostaˆ zwolniony. Czy kontynuowa†?  (T/N)' )
            ELSE
               etaty1()
            ENDIF
         ENDIF
         RESTORE SCREEN FROM robs
      CASE kl == 107 .OR. kl == 75
         SAVE SCREEN TO robs
         Kartot_W( mieslok )
         RESTORE SCREEN FROM robs
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[  1 ] := '                                                                       '
         p[  2 ] := '  [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...........poprzedni/nast&_e.pny pracownik                         '
         p[  3 ] := '  [Home/End]......pierwszy/ostatni pracownik                           '
         p[  4 ] := '  [Enter].........ustalenie p&_l.acy miesi&_e.cznej                          '
         p[  5 ] := '  [M].............modyfikacja danych kadrowych                         '
         if mieslok = 'C'
            p[  6 ] := '  [K].............kartoteka wynagrodze&_n. - ca&_l.y rok                     '
         else
            p[  6 ] := '  [K].............kartoteka dodruk za m-c ' + mieslok + '                           '
         endif
         p[  7 ] := '  [Y].............dokonywane wyp&_l.aty - aktualizacja grupowa            '
         p[  8 ] := '  [W].............dokonywane wyp&_l.aty/zaliczki - aktualizacja wybranego '
         p[  9 ] := '  [P].............data wp&_l.aty zaliczki na podatek dochodowy            '
         p[ 10 ] := '  [4].............okres PIT-4 i PIT-11/8B w kt&_o.rym uwzgl&_e.dni&_c. podatek   '
         p[ 11 ] := '  [H].............historia zatrudnienia pracownika                     '
         p[ 12 ] := '  [G].............ponowne zatrudnienie pracownika                      '
         p[ 13 ] := '  [Esc]...........wyj&_s.cie                                              '
         p[ 14 ] := '                                                                       '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
          IF Type( 'p[i]' ) # 'U'
               center( j, p[i] )
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
      case kl=77.or.kl=109
         ColStb()
         center( 23, 'þ                       þ' )
         ColSta()
         center( 23, 'M O D Y F I K A C J A' )
         ColStd()
         zDATA_PRZY := DATA_PRZY
         zDATA_ZWOL := DATA_ZWOL
         zODLICZENIE := ODLICZENIE
         zOSWIAD26R := iif( OSWIAD26R == ' ', 'N', OSWIAD26R )
         zPPK := iif( PPK == ' ', 'N', PPK )
         zWYKSZTALC := WYKSZTALC
         zZAWOD_WYU := ZAWOD_WYU
         zUWAGI := UWAGI
         zPPKZS1 := PPKZS1
         zPPKZS2 := PPKZS2
         zPPKPS2 := PPKPS2
         zPPKIDKADR := iif( Len( AllTrim( PPKIDKADR ) ) == 0, Pad( AllTrim( Str( RecNo(), 10 ) ), 10 ), PPKIDKADR )
         zPPKIDEPPK := PPKIDEPPK
         zPPKIDPZIF := PPKIDPZIF
         zWNIOSTERM := WNIOSTERM
         @  4, 42 GET zdata_przy PICTURE '@D' VALID .NOT. Empty( zdata_przy )
         @  4, 68 GET zdata_zwol PICTURE '@D'
         @  5, 49 GET zodliczenie PICTURE '!' VALID vodlicz()
         @  5, 66 GET zOSWIAD26R PICTURE '!' VALID voswiad26r()
         @  5, 75 GET zPPK PICTURE '!' VALID etatyvppk( 5, 76 )
         @  6, 43 GET zwyksztalc PICTURE '@S37 ' + repl( 'X', 40 )
         @  7, 43 GET zzawod_wyu PICTURE '@S21 ' + repl( 'X', 40 )
         @  7, 77 GET zWNIOSTERM PICTURE '!' VALID ValidTakNie( zWNIOSTERM, 7, 78 )
         @ 22,  8 GET zuwagi
         SET CURSOR ON
         READ
         SET CURSOR OFF
         IF LastKey() == 13
            BlokadaR()
            repl_( 'DATA_PRZY', zDATA_PRZY )
            repl_( 'DATA_ZWOL', zDATA_ZWOL )
            repl_( 'ODLICZENIE', zODLICZENIE )
            repl_( 'OSWIAD26R', zOSWIAD26R )
            repl_( 'PPK', zPPK )
            repl_( 'WYKSZTALC', zWYKSZTALC )
            repl_( 'ZAWOD_WYU', zZAWOD_WYU )
            repl_( 'UWAGI', zUWAGI )
            repl_( 'PPKZS1', zPPKZS1 )
            repl_( 'PPKZS2', zPPKZS2 )
            repl_( 'PPKPS2', zPPKPS2 )
            repl_( 'PPKIDKADR', zPPKIDKADR )
            repl_( 'PPKIDEPPK', zPPKIDEPPK )
            repl_( 'PPKIDPZIF', zPPKIDPZIF )
            repl_( 'WNIOSTERM', zWNIOSTERM )
            COMMIT
            UNLOCK
         ENDIF
         @ 23, 0
      CASE kl == 87 .OR. kl == 119
         IF zRYCZALT = 'T'
            SELECT 100
            DO WHILE .NOT. Dostep( 'EWID' )
            ENDDO
            SetInd( 'EWID' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ELSE
            SELECT 100
            DO WHILE .NOT. Dostep( 'OPER' )
            ENDDO
            SetInd( 'OPER' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ENDIF
         SELECT prac
         siacpla := iif( siacpla = '  ', aktualny, siacpla )
         mieda := Val( siacpla )
         DO WHILE .T.
            SET CURSOR OFF
            ColPro()
            FOR x := 1 TO 12
                xx := StrTran( Str( x, 2 ), ' ', '0' )
                zSUMA_WYP := Transform( zK_WYP&XX + zK_ZAL&XX, '99999.99' )
                @ 8 + x, 53 PROMPT zSUMA_WYP
            NEXT
            mieda := menu( mieda )
            ColStd()
            IF LastKey() == 27
               EXIT
            ENDIF
            IF LastKey() == 13
               _tak := 'P'
               _mieda_ := StrTran( Str( mieda, 2 ), ' ', '0' )
               SAVE SCREEN TO scr_sklad
               @ 11, 40 CLEAR TO 19, 75
               @ 11, 40 TO 19, 75
               @ 12, 41 SAY '  Wprowadzanie wyplat dokonanych  '
               @ 13, 41 SAY '         za okres 9999.99         '
               @ 14, 41 SAY 'Suma wyplaconych zaliczek.' + Transform( zK_ZAL&_mieda_, '99999.99' )
               @ 15, 41 SAY 'Suma wyplaconych plac.....' + Transform( zK_WYP&_mieda_, '99999.99' )
               @ 16, 41 SAY 'RAZEM wyplacono...........' + Transform( zK_WYP&_mieda_ + zK_ZAL&_mieda_, '99999.99' )
               @ 17, 41 SAY '                                  '
               @ 18, 41 SAY 'Wprowadzasz Zaliczke/Place (Z/P) !'
               SET COLOR TO w+
               @ 13, 59 SAY param_rok + '.' + _mieda_
               @ 14, 67 SAY Transform( zK_ZAL&_mieda_, '99999.99' )
               @ 15, 67 SAY Transform( zK_WYP&_mieda_, '99999.99' )
               @ 16, 67 SAY Transform( zK_WYP&_mieda_ + zK_ZAL&_mieda_, '99999.99' )
               @ 18, 74 GET _tak PICTURE '!' valid _tak $ 'ZP'
               SET CONF ON
               READ
               SET CONF OFF
               IF LastKey() == 13
                  IF _tak == 'P'
                     wyplaty()
                  ELSE
                     zaliczki()
                  ENDIF
               ENDIF
               SELECT prac
               RESTORE SCREEN FROM scr_sklad
               say41es()
            ENDIF
         ENDDO
      CASE kl == 122 .OR. kl == 90
         IF zRYCZALT = 'T'
            SELECT 100
            DO WHILE .NOT. Dostep( 'EWID' )
            ENDDO
            SetInd( 'EWID' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ELSE
            SELECT 100
            DO WHILE .NOT. Dostep( 'OPER' )
            ENDDO
            SetInd( 'OPER' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ENDIF
         SELECT prac
         siacpla := iif( siacpla = '  ', aktualny, siacpla )
         mieda := Val( siacpla )
         DO WHILE .T.
            SET CURSOR OFF
            ColPro()
            FOR x := 1 TO 12
                xx := StrTran( Str( x, 2 ), ' ', '0' )
                zSUMA_ZAL := Transform( zK_ZAL&XX, '99999.99' )
                @ 8 + x, 63 PROMPT zSUMA_ZAL
            NEXT
            mieda := menu( mieda )
            ColStd()
            IF LastKey() == 27
               EXIT
            ENDIF
            IF LastKey() == 13
               SAVE SCREEN TO scr_sklad
               zaliczki()
               SELECT prac
               RESTORE SCREEN FROM scr_sklad
               say41es()
            ENDIF
         ENDDO
      CASE kl == 80 .OR. kl == 112
         IF zRYCZALT = 'T'
            SELECT 100
            DO WHILE .NOT. Dostep( 'EWID' )
            ENDDO
            SetInd( 'EWID' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ELSE
            SELECT 100
            DO WHILE .NOT. Dostep( 'OPER' )
            ENDDO
            SetInd( 'OPER' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ENDIF
         SELECT prac
         siacpla := iif( siacpla = '  ', aktualny, siacpla )
         mieda := Val( siacpla )
         DO WHILE .T.
            SET CURSOR OFF
            ColPro()
            FOR x := 1 TO 12
                xx := StrTran( str( x, 2 ), ' ', '0' )
                zDATA_ZAL := DToC( zD_ZAL&XX )
                @ 8 + x, 62 PROMPT zDATA_ZAL
            NEXT
            mieda := menu( mieda )
            ColStd()
            IF LastKey() == 27
               EXIT
            ENDIF
            IF LastKey() == 13
               ColStb()
               center( 23, 'þ                       þ' )
               ColSta()
               center( 23, 'M O D Y F I K A C J A' )
               ColStd()
               xx := StrTran( Str( mieda, 2 ), ' ', '0' )
               @ 8 + mieda, 62 GET zD_ZAL&XX PICTURE '@D'
               SET CONF ON
               SET CURSOR ON
               READ
               SET CURSOR OFF
               SET CONF OFF
               IF LastKey() == 13
                  zidp := Str( rec_no, 5 )
                  SELECT etaty
                  SEEK '+' + ident_fir + zidp + Str( mieda, 2 )
                  IF Found()
                     BlokadaR()
                     repl_( 'DATA_ZAL', zD_ZAL&XX )
                     COMMIT
                     UNLOCK
                  ENDIF
                  _pisac := tnesc( '*i', '   Czy wpisa&_c. tak&_a. sam&_a. dat&_e. innym pracownikom firmy ? (T/N)   ' )
                  IF _pisac
                     SELECT prac
                     SET ORDER TO 4
                     SELECT etaty
                     SET ORDER TO 2
                     GO TOP
                     kluc := '+' + ident_fir + Str( mieda, 2 )
                     SEEK kluc
                     IF Found()
                        DO WHILE .NOT. Eof() .AND. del + firma + mc == kluc
                           SELECT prac
                           SEEK Val( etaty->ident )
                           IF Found() .AND. del == '+' .AND. firma == ident_fir .AND. rec_no = Val( etaty->ident ) .AND. status <= 'U'
                              SELECT etaty
                              BlokadaR()
                              repl_( 'DATA_ZAL', zD_ZAL&XX )
                              COMMIT
                              UNLOCK
                           ENDIF
                           SELECT etaty
                           SKIP
                        ENDDO
                     ENDIF
                     SET ORDER TO 1
                     GO TOP
                     SELECT prac
                     SET ORDER TO 2
                  ENDIF
                  SELECT prac
               ENDIF
               @ 23, 0
            ENDIF
         ENDDO

      CASE kl == 121 .OR. kl == 89
         if zRYCZALT = 'T'
            SELECT 100
            DO WHILE .NOT. Dostep( 'EWID' )
            ENDDO
            SetInd( 'EWID' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ELSE
            SELECT 100
            DO WHILE .NOT. Dostep( 'OPER' )
            ENDDO
            SetInd( 'OPER' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ENDIF
         SELECT prac
         siacpla := iif( siacpla = '  ', aktualny, siacpla )
         mieda := Val( siacpla )
         ColDlg()
         _miewyp := mieda
         _dzienwyp := eom( CToD( param_rok + '.' + Str( _miewyp, 2 ) + '.' + '01' ) )
         _dopit4 := SubStr( DToS( _dzienwyp ), 1, 6 )
         _sposob := 1
         _sposproc := 100
         _sposwart := 0
         _tak := ' '
         SAVE SCREEN TO scr_sklad
         @  8, 40 CLEAR TO 21, 75
         @  8, 40 TO 21, 75
         @  9, 41 SAY '  Nanie&_s.&_c. wyp&_l.aty dla wszystkich  '
         @ 11, 41 SAY 'Wyp&_l.aty za miesi&_a.c..........:99   '
         @ 12, 41 SAY 'Wyp&_l.acono dnia.........:9999.99.99'
         @ 13, 41 SAY 'Uwzgl&_e.dni&_c. w PIT-4 za..:9999.99   '
         @ 15, 41 SAY ' W jaki spos&_o.b nanie&_s.c (1/2/3):9  '
         @ 16, 41 SAY '1.kwoty pozosta&_l.e do wyp&_l.aty      '
         @ 17, 41 SAY '2.% kwoty pozosta&_l.ej do wyp&_l.a.:999'
         @ 18, 41 SAY '3.okre&_s.lona wskazana kwota..:99999'
         @ 20, 41 SAY '     ZATWIERDZAM (Tak/Nie):!      '
         @ 11, 70 GET _miewyp PICTURE '99' RANGE 1, 12
         @ 12, 65 GET _dzienwyp PICTURE '@D' WHEN v_dzienwyp()
         @ 13, 65 GET _dopit4 PICTURE '@R 9999.99' WHEN v_dopit4()
         @ 15, 72 GET _sposob PICTURE '9' RANGE 1, 3
         @ 17, 72 GET _sposproc PICTURE '999' RANGE 0, 100 WHEN _sposob = 2
         @ 18, 70 GET _sposwart PICTURE '99999' RANGE 0, 99999 WHEN _sposob = 3
         @ 20, 68 GET _tak PICTURE '!' VALID _tak $ 'TN'
         SET CONF ON
         READ
         SET CONF OFF
         IF LastKey() == 13 .AND. _tak == 'T'
            mmmie := Str( _miewyp, 2 )
            DO CASE
            CASE _sposob = 1
               ColInf()
               @ 24, 0
               Center( 24, 'Prosz&_e. czeka&_c....' )
               SELECT prac
               nurek_ := recno()
               SEEK '+' + ident_fir + '+'
               DO WHILE .NOT. Eof() .AND. del == '+' .AND. firma == ident_fir .AND. status <= 'U'
                  _zident_ := Str( rec_no, 5 )
                  SELECT etaty
                  SEEK '+' + ident_fir + _zident_ + mmmie
                  z_dowyp := DO_WYPLATY
                  inswyp()
                  zdata_wwyp := _dzienwyp
                  IF zkwota_wwyp > 0.0
                     ins := .T.
                     zapiszwyp()
                     SELECT etaty
                     BlokadaR()
                     repl_( 'DO_PIT4', _dopit4 )
                     commit_()
                     UNLOCK
                  ENDIF
                  SELECT prac
                  SKIP
               ENDDO
               GO nurek_
            CASE _sposob = 2
               IF _sposproc > 0
                  ColInf()
                  @ 24, 0
                  Center( 24, 'Prosz&_e. czeka&_c....' )
                  SELECT prac
                  nurek_ := RecNo()
                  SEEK '+' + ident_fir + '+'
                  DO WHILE .NOT. Eof() .AND. del == '+' .AND. firma == ident_fir .AND. status <= 'U'
                     _zident_ := Str( rec_no, 5 )
                     SELECT etaty
                     SEEK '+' + ident_fir + _zident_ + mmmie
                     z_dowyp := DO_WYPLATY
                     inswyp()
                     zdata_wwyp := _dzienwyp
                     IF zkwota_wwyp > 0.0
                        IF _round( zkwota_wwyp * ( _sposproc / 100 ), 2 ) > 0.0 .AND. Min( zkwota_wwyp, _round( zkwota_wwyp * ( _sposproc / 100 ), 2 ) ) > 0.0
                           zkwota_wwyp := Min( zkwota_wwyp, _round( zkwota_wwyp * ( _sposproc / 100 ), 2  ))
                           ins := .T.
                           zapiszwyp()
                           SELECT etaty
                           BlokadaR()
                           repl_( 'DO_PIT4', _dopit4 )
                           commit_()
                           UNLOCK
                        ENDIF
                     ENDIF
                     SELECT prac
                     SKIP
                  ENDDO
                  GO nurek_
               ELSE
                  kom( 5, '*u', 'Podano 0%. Nie naniesiono wyp&_l.at.' )
               ENDIF
            CASE _sposob = 3
               IF _sposwart > 0
                  ColInf()
                  @ 24, 0
                  Center( 24, 'Prosz&_e. czeka&_c....' )
                  SELECT prac
                  nurek_ := RecNo()
                  SEEK '+' + ident_fir + '+'
                  DO WHILE .NOT. Eof() .AND. del == '+' .AND. firma == ident_fir .AND. status <= 'U'
                     _zident_ := Str( rec_no, 5 )
                     SELECT etaty
                     SEEK '+' + ident_fir + _zident_ + mmmie
                     z_dowyp := DO_WYPLATY
                     inswyp()
                     zdata_wwyp := _dzienwyp
                     IF zkwota_wwyp > 0.0
                        IF Min( zkwota_wwyp, _sposwart ) > 0.0
                           zkwota_wwyp := Min( zkwota_wwyp, _sposwart )
                           ins := .T.
                           zapiszwyp()
                           SELECT etaty
                           BlokadaR()
                           repl_( 'DO_PIT4', _dopit4 )
                           commit_()
                           UNLOCK
                        ENDIF
                     ENDIF
                     SELECT prac
                     SKIP
                  ENDDO
                  GO nurek_
               ELSE
                  kom( 5, '*u', 'Podano kwot&_e. 0z&_l.. Nie naniesiono wyp&_l.at.' )
               ENDIF
             ENDCASE
         ENDIF
         ColStd()
         @ 24, 0
         SELECT prac
         RESTORE SCREEN FROM scr_sklad
         say41es()
      CASE kl == 52
         IF zRYCZALT = 'T'
            SELECT 100
            DO WHILE .NOT. Dostep( 'EWID' )
            ENDDO
            SetInd( 'EWID' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ELSE
            SELECT 100
            DO WHILE .NOT. Dostep( 'OPER' )
            ENDDO
            SetInd( 'OPER' )
            SEEK '+' + ident_fir
            mc_rozp := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            SEEK '+' + ident_fir + 'þ'
            SKIP -1
            aktualny := iif( del = '+' .AND. firma = ident_fir, mc, '  ' )
            USE
         ENDIF
         SELECT prac
         siacpla := iif( siacpla = '  ', aktualny, siacpla )
         mieda := Val( siacpla )
         DO WHILE .T.
            SET CURSOR OFF
            ColPro()
            FOR x := 1 TO 12
               xx := StrTran( str( x, 2 ), ' ', '0' )
               @ 8 + x, 73 PROMPT Transform( zDO_PIT4&XX, '@R 9999.99' )
            NEXT
            mieda := menu( mieda )
            ColStd()
            IF LastKey() == 27
               EXIT
            ENDIF
            IF LastKey() == 13

               ColStb()
               center( 23, 'þ                       þ' )
               ColSta()
               center( 23, 'M O D Y F I K A C J A' )
               ColStd()
               xx := StrTran( Str( mieda, 2 ), ' ', '0' )
               @ 8 + mieda, 73 GET zDO_PIT4&XX PICTURE '@R 9999.99'
               SET CONF ON
               SET CURSOR ON
               READ
               SET CURSOR OFF
               SET CONF OFF
               IF LastKey() == 13
                  zidp := Str( rec_no, 5 )
                  SELECT etaty
                  SEEK '+' + ident_fir + zidp + Str( mieda, 2 )
                  IF Found()
                     BlokadaR()
                     repl_( 'DO_PIT4', zDO_PIT4&XX )
                     COMMIT
                     UNLOCK
                  ENDIF
                  _pisac := tnesc( '*i', '   Czy wpisa&_c. tak&_a. sam&_a. dat&_e. innym pracownikom firmy ? (T/N)   ' )
                  IF _pisac
                     SELECT prac
                     SET ORDER TO 4
                     SELECT etaty
                     SET ORDER TO 2
                     GO TOP
                     kluc := '+' + ident_fir + Str( mieda, 2 )
                     SEEK kluc
                     IF Found()
                        DO WHILE .NOT. Eof() .AND. del + firma + mc == kluc
                           SELECT prac
                           SEEK Val( etaty->ident )
                           IF Found() .AND. del == '+' .AND. firma == ident_fir .AND. rec_no = Val( etaty->ident ) .AND. status <= 'U'
                              SELECT etaty
                              BlokadaR()
                              repl_( 'DO_PIT4', zDO_PIT4&XX )
                              COMMIT
                              UNLOCK
                           ENDIF
                           SELECT etaty
                           SKIP
                        ENDDO
                     ENDIF
                     SET ORDER TO 1
                     GO TOP
                     SELECT prac
                     SET ORDER TO 2
                  ENDIF
                  SELECT prac
               ENDIF
               @ 23, 0
            ENDIF
         ENDDO
      CASE kl == Asc( 'G' ) .OR. kl == Asc( 'g' )
         IF ! Empty( prac->data_przy ) .AND. ! Empty( prac->data_zwol )
            zDATA_PRZY := Date()
            zDATA_ZWOL := SToD()
            @  4, 42 GET zdata_przy PICTURE '@D' VALID .NOT. Empty( zdata_przy )
            @  4, 68 GET zdata_zwol PICTURE '@D'
            SET CURSOR ON
            READ
            SET CURSOR OFF
            IF LastKey() == 13
               prac_hz->( dbAppend() )
               prac_hz->del := '+'
               prac_hz->firma := ident_fir
               prac_hz->pracid := prac->id
               prac_hz->data_przy := prac->data_przy
               prac_hz->data_zwol := prac->data_zwol
               prac_hz->( dbCommit() )

               BlokadaR()
               prac->data_przy := zDATA_PRZY
               prac->data_zwol := zDATA_ZWOL
               COMMIT
               UNLOCK
            ENDIF
         ELSE
            Komun( "Pracownik nadal jest zatrudniony" )
         ENDIF
      CASE kl == Asc( 'H' ) .OR. kl == Asc( 'h' )
         Prac_HZ_Pokaz()
      ENDCASE
   ENDDO
   close_()

   RETURN

*################################## FUNKCJE #################################

FUNCTION say41e()

   znazwisko := PadR( AllTrim( nazwisko ) + ' ' + AllTrim( imie1 ) + ' ' + AllTrim( imie2 ), 29 )
   RETURN znazwisko

*##############################################################################
PROCEDURE say41es()

   CLEAR TYPE
   SET COLOR TO +w
   @  4, 42 SAY data_przy
   @  4, 68 SAY data_zwol
   @  5, 49 SAY iif( odliczenie = 'T', 'Tak', 'Nie' )
   @  5, 66 SAY iif( oswiad26r = 'T', 'Tak', 'Nie' )
   @  5, 75 SAY iif( ppk = 'T', 'Tak', 'Nie' )
   @  6, 43 SAY SubStr( wyksztalc, 1, 37 )
   @  7, 43 SAY SubStr( zawod_wyu, 1, 21 )
   @  7, 77 SAY iif( wniosterm = 'T', 'Tak', 'Nie' )
   zidp := Str( rec_no, 5 )
   SELECT etaty
   SEEK '+' + ident_fir + zidp
   IF Found()
      STORE 0 TO w1, w2, w3, w4
      FOR x := 1 TO 12
         xx := StrTran( Str( x, 2 ), ' ', '0' )
         zK_WYP&XX := 0
         zK_ZAL&XX := 0
         @ 8 + x, 35 SAY brut_razem PICTURE '99999.99'
         jakiewyp()
         jakiezal()
         SELECT etaty
         IF Str( do_wyplaty, 10, 2 ) <> Str( zK_WYP&XX + zK_ZAL&XX, 10, 2 )
            ColErr()
         ELSE
            SET COLOR TO +w
         ENDIF
         @ 8 + x, 44 SAY DO_WYPLATY PICTURE '99999.99'
         @ 8 + x, 53 SAY zK_WYP&XX+zK_ZAL&XX PICTURE '99999.99'
         SET COLOR TO +w
         zD_ZAL&XX := DATA_ZAL
         zDO_PIT4&XX := DO_PIT4
         @ 8 + x, 62 SAY zD_ZAL&XX PICTURE '@D'
         @ 8 + x, 73 SAY zDO_PIT4&XX PICTURE '@R 9999.99'
         w1 := w1 + BRUT_RAZEM
         w2 := w2 + DO_WYPLATY
         w3 := w3 + zK_WYP&XX + zK_ZAL&XX
         SKIP 1
      NEXT
      @ 21,  4 SAY Transform( Str( Int( ( Date() - A->DATA_UR ) / 365 ), 2 ), '99' ) + ' lat'
      @ 21, 35 SAY w1 PICTURE '99999.99'
      @ 21, 44 SAY w2 PICTURE '99999.99'
      @ 21, 53 SAY w3 PICTURE '99999.99'
   ENDIF
   SELECT prac
   @ 22, 8 SAY uwagi
   SET COLOR TO
   RETURN

***************************************************
FUNCTION vodlicz()

   R := .F.
   IF zodliczenie $ 'TN'
      @ 5, 50 SAY iif( zodliczenie = 'T', 'ak', 'ie' )
      R := .T.
   ENDIF
   RETURN R

***************************************************
FUNCTION voswiad26r()

   R := .F.
   IF zOSWIAD26R $ 'TN'
      @ 5, 67 SAY iif( zOSWIAD26R == 'T', 'ak', 'ie' )
      R := .T.
   ENDIF
   RETURN R

FUNCTION etatyvppk( nTNRow, nTNCol )

   LOCAL GetList := {}
   LOCAL R := .F.
   LOCAL cEkran
   LOCAL cKolor

   IF zPPK $ 'TN'
      @ nTNRow, nTNCol SAY iif( zPPK == 'T', 'ak', 'ie' )
      R := .T.
      IF zPPK == 'T'
         IF prac->ppk <> 'T' .AND. zPPKZS1 == 0
            zPPKZS1 := parpk_sz
         ENDIF
         SAVE SCREEN TO cEkran
         cKolor := ColStd()
         @  6, 40 CLEAR TO 15, 79
         @  6, 40 TO 15, 79
         @  6, 42 SAY 'PPK - wpˆata podstawowa'
         @  7, 42 SAY 'Wpˆata podstawowa pracownika       %'
         @  8, 41 TO 8, 78
         @  8, 42 SAY 'PPK - wpˆaty dodatkowe'
         @  9, 42 SAY 'Wpˆata dodatkowa pracownika        %'
         @ 10, 42 SAY 'Wpˆata dodatkowa pracodawcy        %'
         @ 11, 41 TO 11, 78
         @ 11, 42 SAY 'Numery identyfikacyjne'
         @ 12, 42 SAY 'Nr ident. lokalny'
         @ 13, 42 SAY 'Nr ident. ewidencji PPK'
         @ 14, 42 SAY 'Nr ident. inst. finans.'
         @  7, 71 GET zPPKZS1 PICTURE '99.99'
         @  9, 71 GET zPPKZS2 PICTURE '99.99'
         @ 10, 71 GET zPPKPS2 PICTURE '99.99'
         @ 12, 66 GET zPPKIDKADR PICTURE '!!!!!!!!!!'
         @ 13, 66 GET zPPKIDEPPK PICTURE '@S12 ' + Replicate( '!', 20 )
         @ 14, 66 GET zPPKIDPZIF PICTURE '@S12 ' + Replicate( '!', 50 )
         READ
         RESTORE SCREEN FROM cEkran
         SetColor( cKolor )
      ENDIF
   ENDIF

   RETURN R

***************************************************
*       @ 8+x,55 say DATA_WYP   pict '@D'
*       @ 8+x,66 say DATA_ZAL   pict '@D'
***************************************************
PROCEDURE jakiewyp()

   xy := Str( x, 2 )
   SELECT wyplaty
   SEEK '+' + ident_fir + zidp + xy
   IF Found()
      DO WHILE del == '+' .AND. firma == ident_fir .AND. ident == zidp .AND. mc == xy .AND. .NOT. Eof()
         zK_WYP&XX := zK_WYP&XX + kwota
         SKIP
      ENDDO
   ENDIF
   RETURN

***************************************************
PROCEDURE jakiezal()

   xy := Str( x, 2 )
   SELECT zaliczki
   SEEK '+' + ident_fir + zidp + xy
   IF Found()
      DO WHILE del == '+' .AND. firma == ident_fir .AND. ident == zidp .AND. mc == xy .AND. .NOT. Eof()
         zK_ZAL&XX := zK_ZAL&XX + kwota
         SKIP
      ENDDO
   ENDIF
   RETURN

***************************************************
PROCEDURE jakiPIT4()

   xy := Str( x, 2 )
   SELECT etaty
   nrreko := RecNo()
   SEEK '+' + ident_fir + zidp + xy
   IF Found()
      DO WHILE del == '+' .AND. firma == ident_fir .AND. ident == zidp .AND. mc == xy .AND. .NOT. Eof()
         zDO_PIT4&XX := DO_PIT4
         SKIP
      ENDDO
   ENDIF
   GO nrreko
   RETURN

******************************************************
FUNCTION v_dzienwyp()

   _dzienwyp := eom( CToD( param_rok + '.' + Str( _miewyp, 2 ) + '.' + '01' ) )
   RETURN .T.

*******************************************************
FUNCTION v_dopit4()

   _dopit4 := SubStr( DToS( _dzienwyp ), 1, 6 )
   RETURN .T.

*############################################################################

PROCEDURE Prac_HZ_Pokaz()

   LOCAL cEkran := SaveScreen( 5, 41, 9, 64 )

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou, _top_bot


   SELECT prac_hz
   *@ 1,47 say [          ]
   *################################# GRAFIKA ##################################
   @ 5, 41 SAY 'ÚData przyjÂData zwoln¿'
   @ 6, 41 SAY '³          ³          ³'
   @ 7, 41 SAY '³          ³          ³'
   @ 8, 41 SAY '³          ³          ³'
   @ 9, 41 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ'

   *############################### OTWARCIE BAZ ###############################
   SEEK '+' + ident_fir + Str( prac->id, 8 )

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 6
   _col_l := 42
   _row_d := 8
   _col_p := 63
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28'
   _top := "del#'+'.or.firma#ident_fir.or.pracid<>prac->id"
   _bot := "del#'+'.or.firma#ident_fir.or.pracid<>prac->id"
   _stop := '+' + ident_fir + Str( prac->id, 8 )
   _sbot := '+' + ident_fir + Str( prac->id, 8 ) + 'þ'
   *_sbot=[+]+ident_fir+_zident_+mmmie
   _proc := 'Prac_HZ_Linia()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         ins := ( kl # 109 .AND. kl # 77 ) .OR. &_top_bot
         @ 1, 47 SAY '          '
         IF ins
            ColStb()
            center( 23, 'þ                     þ' )
            ColSta()
            center( 23, 'W P I S Y W A N I E' )
            ColStd()
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            ColStb()
            center( 23, 'þ                       þ' )
            ColSta()
            center( 23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         BEGIN SEQUENCE
         *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zDATA_PRZY := Date()
               zDATA_ZWOL := SToD('')
            ELSE
               zDATA_PRZY := data_przy
               zDATA_ZWOL := data_zwol
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            *if ins
            @ wiersz, _col_l      GET zDATA_PRZY PICTURE '@D' VALID ! Empty( zDATA_PRZY )
            *endif
            @ wiersz, _col_l + 11 GET zDATA_ZWOL PICTURE '@D' VALID ! Empty( zDATA_ZWOL )
            read_()
            IF LastKey() == 27
               BREAK
            ENDIF
            ColStd()
            @ 24, 0
            SET COLOR TO
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
               repl_( 'FIRMA', ident_fir )
               repl_( 'PRACID', prac->id )
            ENDIF
            BlokadaR()
            repl_( 'DATA_PRZY', zDATA_PRZY )
            repl_( 'DATA_ZWOL', zDATA_ZWOL )
            commit_()
            UNLOCK
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð

            _row := Int( ( _row_g + _row_d ) / 2 )
            kl := 27
            IF .NOT. ins
               BREAK
            ENDIF
            * @ _row_d,_col_l say &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '          ³          '
         END
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() == 27 .AND. _row == -1, 27, kl )
         @ 23, 0
      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR()
            del()
            COMMIT
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
            kl := 27
         ENDIF
         @ 23, 0
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[ 3 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[ 4 ] := '   [Ins]...................wpisywanie                   '
         p[ 5 ] := '   [M].....................modyfikacja pozycji          '
         p[ 6 ] := '   [Del]...................kasowanie pozycji            '
         p[ 7 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 8 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         Pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO

   SELECT PRAC
   RestScreen( 5, 41, 9, 64, cEkran )

   RETURN

*################################## FUNKCJE #################################
FUNCTION Prac_HZ_Linia()

   RETURN Transform( DATA_PRZY, '@D' ) + '³' + Transform( DATA_ZWOL, '@D' )

/*----------------------------------------------------------------------*/

FUNCTION Prac_HZ_Aktywny( nMiesiac )

   LOCAL lRes := .F., dDataNa := hb_Date( Val( param_rok ), nMiesiac, 1 )

   IF Empty( prac->data_przy )
      RETURN lRes
   ENDIF

   lRes := dDataNa >= hb_Date( Year( prac->data_przy ), Month( prac->data_przy ), 1 ) .AND. ;
     ( Empty( prac->data_zwol ) .OR. dDataNa <= hb_Date( Year( prac->data_zwol ), Month( prac->data_zwol ), 1 ) )

   IF ! lRes .AND. prac_hz->( dbSeek( '+' + ident_fir + Str( prac->id, 8 ) ) )
      DO WHILE ! lRes .AND. ! prac_hz->( Eof() ) .AND. prac_hz->del == '+' .AND. prac_hz->firma == ident_fir .AND. prac_hz->pracid == prac->id
         lRes := dDataNa >= hb_Date( Year( prac_hz->data_przy ), Month( prac_hz->data_przy ), 1 ) .AND. ;
           dDataNa <= hb_Date( Year( prac_hz->data_zwol ), Month( prac_hz->data_zwol ), 1 )
         prac_hz->( dbSkip() )
      ENDDO
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

