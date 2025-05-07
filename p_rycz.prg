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

PROCEDURE P_Rycz( okres )

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, _top, _bot, ;
      _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, nr_rec, wiersz, f10, rec, fou


   @ 1, 47 SAY '          '
   *############################### OTWARCIE BAZ ###############################
   zPITOKRES := 'M'

   SELECT 6
   IF Dostep( 'FIRMA' )
      GO Val( ident_fir )
   ELSE
      RETURN
   ENDIF

   SELECT 4
   IF Dostep( 'EWID' )
      SetInd( 'EWID' )
      SET ORDER TO 3
   ELSE
      Close_()
      RETURN
   ENDIF

   SELECT 3
   IF Dostep( 'DANE_MC' )
      SET INDEX TO dane_mc
   ELSE
      Close_()
      RETURN
   ENDIF

   SELECT 2
   IF Dostep( 'SUMA_MC' )
      SET INDEX TO suma_mc
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
      Kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej opcji ' )
      Close_()
      RETURN
   ENDIF
   *--------------------------------------
   SKIP
   spolka := ( del == '+' .AND. firma == ident_fir )
   SKIP -1
   *--------------------------------------
   @ 3, 42 CLEAR TO 22, 79
   IF ! spolka
      Zestaw_R( Okres )
      Close_()
      RETURN
   ENDIF
   *################################# GRAFIKA ##################################
   ColStd()
   @  3, 44 SAY '            Podatnik:             '
   @  4, 44 SAY 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
   @  5, 44 SAY 'º                                º'
   @  6, 44 SAY 'º                                º'
   @  7, 44 SAY 'º                                º'
   @  8, 44 SAY 'º                                º'
   @  9, 44 SAY 'º                                º'
   @ 10, 44 SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
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
   _proc := 'linia12R()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''
   *----------------------
   kl := 0
   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := Wybor( _row )
      kl := LastKey()
      DO CASE
      *################################## ZESTAW_R #################################
      CASE kl == K_ENTER .OR. kl == K_LDBLCLK
         SAVE SCREEN TO scr2
         nr_rec := RecNo()
         Zestaw_R( Okres )
         GO nr_rec
         RESTORE SCREEN FROM scr2
         _disp := .F.
      *################################### POMOC ##################################
      CASE kl == K_F1
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
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
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   Close_()
   RETURN

*################################## FUNKCJE #################################
FUNCTION linia12R()

   RETURN ' ' + dos_c( SubStr( naz_imie, 1, 30 ) ) + ' '

*############################################################################
PROCEDURE P_RyczLicz( Okres, lPobierzPrzychody )

   hb_default( @lPobierzPrzychody, .F. )

   SELECT spolka

   *################################ OBLICZENIA ################################
   ********************** udzialy w miesiacach
   zm := '  0/1  '
   FOR i := 1 TO 12
      zm1 := 'udzial' + LTrim( Str( i ) )
      IF '   /   ' # &zm1
         zm := &zm1
      ENDIF
      zm2 := 'udz' + LTrim( Str( i ) )
      &zm2  := zm
   NEXT
   **********************
   SELECT suma_mc
   kwarokr := ' 1'
   kwarkon := ' 3'
   IF OKRES == 'K'
      DO CASE
      CASE Val( AllTrim( miesiac ) ) >= 1 .AND. Val( AllTrim( miesiac ) ) <= 3
         kwarokr := ' 1'
         kwarkon := ' 3'
      CASE Val( AllTrim( miesiac ) ) >= 4 .AND. Val( AllTrim( miesiac ) ) <= 6
         kwarokr := ' 4'
         kwarkon := ' 6'
      CASE Val( AllTrim( miesiac ) ) >= 7 .AND. Val( AllTrim( miesiac ) ) <= 9
         kwarokr := ' 7'
         kwarkon := ' 9'
      CASE Val( alltrim( miesiac ) ) >= 10 .AND. Val( AllTrim( miesiac ) ) <= 12
         kwarokr := '10'
         kwarkon := '12'
      ENDCASE
   ENDIF
   koniecokr := miesiac
   DO CASE
   CASE OKRES == 'M'
      SEEK '+' + ident_fir + miesiac
      koniecokr := miesiac
   CASE OKRES == 'K'
      SEEK '+' + ident_fir + kwarokr
      koniecokr := kwarkon
   CASE OKRES == 'N'
      SEEK '+' + ident_fir + ' 1'
      IF lPobierzPrzychody .AND. Val( miesiac ) > 1
         koniecokr := Str( Val( miesiac ) - iif( firma->zuspodmie == 'B', 0, 1 ), 2, 0 )
      ELSE
         koniecokr := miesiac
      ENDIF
   ENDCASE
   przychodu := 0
   przychodp := 0
   przychodh := 0
   przychr20 := 0
   przychr17 := 0
   przychr10 := 0
   przychrk07 := 0
   przychrk08 := 0
   przychrk09 := 0
   przychrk10 := 0

   DO WHILE del == '+' .AND. firma == ident_fir .AND. mc <= koniecokr
      zm := 'udz' + LTrim( mc )
      przychodu := przychodu + USLUGI * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychodp := przychodp + WYR_TOW * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychodh := przychodh + HANDEL * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychr20 := przychr20 + RY20 * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychr17 := przychr17 + RY17 * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychr10 := przychr10 + RY10 * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychrk07 := przychrk07 + RYK07 * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychrk08 := przychrk08 + RYK08 * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychrk09 := przychrk09 + RYK09 * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      przychrk10 := przychrk10 + RYK10 * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
      SKIP
   ENDDO
   SELECT spolka
   k1 := _round( przychodu, 2 )
   k1a := _round( przychr20, 2 )
   k1b := _round( przychr17, 2 )
   k1c := _round( przychr10, 2 )
   k2 := _round( przychodp, 2 )
   k3 := _round( przychodh, 2 )
   k1k7 := _round( przychrk07, 2 )
   k1k8 := _round( przychrk08, 2 )
   k1k9 := _round( przychrk09, 2 )
   k1k10 := _round( przychrk10, 2 )
   *k4=k1+k2+k3+k1a+k1b+k1c
   k4 := k1 + k2 + k3 + k1a + k1b + k1c + k1k7 + k1k8 + k1k9 + k1k10
   *------------------------------------ dane_mc

   SELECT dane_mc
   DO CASE
   CASE OKRES == 'M'
      SEEK '+' + zident + miesiac
   CASE OKRES == 'K'
      SEEK '+' + zident + kwarokr
   CASE OKRES == 'N'
      SEEK '+' + zident + ' 1'
   ENDCASE

   STORE 0 TO dochody, wydatki, zwolniony, zaliczki, zaaa, zbbb
   STORE 0 TO zpit566, zpit567, zpit569, zpit5104, zpit5105, zzdrowie
   DO WHILE del == '+' .AND. ident == zident .AND. mc <= koniecokr
      dochody := dochody + _round( ( g_przych1 - g_koszty1 ) * Val( Left( g_udzial1, 2 ) ) / Val( Right( g_udzial1, 3 ) ), 2 ) + _round( ( g_przych2 - g_koszty2 ) * Val( Left( g_udzial2, 2 ) ) / Val( Right( g_udzial2, 3 ) ), 2 )
      dochody := dochody + _round( ( n_przych1 - n_koszty1 ) * val( Left( n_udzial1, 2 ) ) / Val( Right( n_udzial1, 3 ) ), 2 ) + _round( ( n_przych2 - n_koszty2 ) * Val( Left( n_udzial2, 2 ) ) / Val( Right( n_udzial2, 3 ) ), 2 )
      k5 := straty + straty_n + powodz + rentalim + skladki + skladkiw + organy + zwrot_ren + zwrot_swi + rehab + kopaliny + darowiz + wynagro + inne + budowa + inwest11 + dochzwol + ubiegbud + ubieginw - g21 + zdrowie + zdrowiew
      wydatki := wydatki + k5
      zzdrowie := zzdrowie + zdrowie + zdrowiew
      zaaa := zaaa + aaa
      zbbb := zbbb + bbb
      zaliczki := zaliczki + zaliczka
      zpit569 := zpit569 + pit569
      zpit5104 := zpit5104 + pit5104
      IF pit5105 > 0
         IF zpit5105 == 0
            zpit5105 := pit5105
         ELSE
            zpit5105 := ( zpit5105 + pit5105 ) / 2
         ENDIF
      ENDIF
      SKIP
   ENDDO

   IF lPobierzPrzychody
      SELECT dane_mc
      RETURN k4 + dochody - wydatki
   ENDIF

   RETURN NIL

PROCEDURE zestaw_R( Okres )

   LOCAL aDaneDruk

   PRIVATE udz1, udz2, udz3, udz4, udz5, udz6, udz7, udz8, udz9, udz10, udz11, udz12
   PRIVATE przychodu, przychodp, przychodh, przychr20, przychr17, przychr10
   PRIVATE przychrk07, przychrk08, przychrk09, przychrk10
   PRIVATE k1, k1a, k1b, k1c, k2, k3, k1k7, k1k8, k1k9, k1k10, k4, k5
   PRIVATE dochody, wydatki, zwolniony, zaliczki, zaaa, zbbb
   PRIVATE zpit566, zpit567, zpit569, zpit5104, zpit5105, zzdrowie
   PRIVATE kwarkon

   @ 1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   *------------------------------------ dane_mc
   zident := Str( RecNo(), 5 )

   P_RyczLicz( Okres )

   SELECT dane_mc
   SEEK '+' + zident + miesiac

*                do case
*                case OKRES='M'
*                   seek [+]+zident+miesiac
*                case OKRES='K'
*                   seek [+]+zident+kwarokr
*                case OKRES='N'
*                   seek [+]+zident+' 1'
*                endcase

   Dane_Mc( '5' )

   IF LastKey() == K_ESC
      SELECT spolka
      RETURN
   ENDIF

   P_RyczLicz( Okres )

   SELECT spolka
   *------------------------------------
   reman := ( zpit5104 * ( zpit5105 / 100 ) ) * 0.1
   zwol := 0
   procent1 := ( iif( k1 > 0, k1, 0 ) + iif( k2 > 0, k2, 0 ) + iif( k3 > 0, k3, 0 ) ;
      + iif( k1a > 0, k1a, 0 ) + iif( k1b > 0, k1b, 0 ) + iif( k1c > 0, k1c, 0 ) ;
      + iif( k1k7 > 0, k1k7, 0 ) + iif( k1k8 > 0, k1k8, 0 ) + iif( k1k9 > 0, k1k9, 0 ) ;
      + iif( k1k10 > 0, k1k10, 0 ) ) / 100
   k6 := iif( przychodu > 0, _round( przychodu / procent1, 2 ), 0 )
   k6a := iif( przychr20 > 0, _round( przychr20 / procent1, 2 ), 0 )
   k6b := iif( przychr17 > 0, _round( przychr17 / procent1, 2 ), 0 )
   k6c := iif( przychr10 > 0, _round( przychr10 / procent1, 2 ), 0 )
   k7 := iif( przychodp > 0, _round( przychodp / procent1, 2 ), 0 )
   k8 := iif( przychodh > 0, _round( przychodh / procent1, 2 ), 0 )
   k6k7 := iif( przychrk07 > 0, _round( przychrk07 / procent1, 2 ), 0 )
   k6k8 := iif( przychrk08 > 0, _round( przychrk08 / procent1, 2 ), 0 )
   k6k9 := iif( przychrk09 > 0, _round( przychrk09 / procent1, 2 ), 0 )
   k6k10 := iif( przychrk10 > 0, _round( przychrk10 / procent1, 2 ), 0 )
   /*IF k6 + k6a + k6b + k6c + k7 + k8 + k6k7 + k6k8 + k6k9 + k6k10 < 100
      k6a := 100 - ( k6 + k6b + k6c + k7 + k8 + k6k7 + k6k8 + k6k9 + k6k10 )
   ELSE
      k8 := 100 - ( k6 + k6a + k6b + k6c + k7 + k6k7 + k6k8 + k6k9 + k6k10 )
   ENDIF*/
   k55 := iif( OKRES == 'M', k5, wydatki )
   k9  := iif( k6 > 0, _round( k55 * ( k6 / 100 ), 2 ), 0 )
   k9a := iif( k6a > 0, _round( k55 * ( k6a / 100 ), 2 ), 0 )
   k9b := iif( k6b > 0, _round( k55 * ( k6b / 100 ), 2 ), 0 )
   k9c := iif( k6c > 0, _round( k55 * ( k6c / 100 ), 2 ), 0 )
   k10 := iif( k7 > 0, _round( k55 * ( k7 / 100 ), 2 ), 0 )
   k11 := iif( k8 > 0, _round( k55 * ( k8 / 100 ), 2 ), 0 )
   k9k7 := iif( k6k7 > 0, _round( k55 * ( k6k7 / 100 ), 2 ), 0 )
   k9k8 := iif( k6k8 > 0, _round( k55 * ( k6k8 / 100 ), 2 ), 0 )
   k9k9 := iif( k6k9 > 0, _round( k55 * ( k6k9 / 100 ), 2 ), 0 )
   k9k10 := iif( k6k10 > 0, _round( k55 * ( k6k10 / 100 ), 2 ), 0 )

   k12 := iif( k1 >= 0, _round( Max( 0, k1 - k9 ), 0 ), k1 )
   k12a := iif( k1a >= 0, _round( Max( 0, k1a - k9a ), 0 ), k1a )
   k12b := iif( k1b >= 0, _round( Max( 0, k1b - k9b ), 0 ), k1b )
   k12c := iif( k1c >= 0, _round( Max( 0, k1c - k9c ), 0 ), k1c )
   k13 := iif( k2 >= 0, _round( Max( 0, k2 - k10 ), 0 ), k2 )
   k14 := iif( k3 >= 0, _round( Max( 0, k3 - k11 ), 0 ), k3 )
   k12k7 := iif( k1k7 >= 0, _round( Max( 0, k1k7 - k9k7 ), 0 ), k1k7 )
   k12k8 := iif( k1k8 >= 0, _round( Max( 0, k1k8 - k9k8 ), 0 ), k1k8 )
   k12k9 := iif( k1k9 >= 0, _round( Max( 0, k1k9 - k9k9 ), 0 ), k1k9 )
   k12k10 := iif( k1k10 >= 0, _round( Max( 0, k1k10 - k9k10 ), 0 ), k1k10 )
   ********* zaremowano w 01.1
   *k15=_round(k12*staw_uslu,1)
   *k16=_round(k13*staw_prod,1)
   *k17=_round(k14*staw_hand,1)
   *k18=_round(k15+k16+k17,1)
   ***************************
   k15 := _round( k12 * staw_uslu, 2 )
   k15a := _round( k12a * staw_ry20, 2 )
   k15b := _round( k12b * staw_ry17, 2 )
   k15c := _round( k12c * staw_ry10, 2 )
   k16 := _round( k13 * staw_prod, 2 )
   k17 := _round( k14 * staw_hand, 2 )
   k15k7 := _round( k12k7 * staw_rk07, 2 )
   k15k8 := _round( k12k8 * staw_rk08, 2 )
   k15k9 := _round( k12k9 * staw_rk09, 2 )
   k15k10 := _round( k12k10 * staw_rk10, 2 )
   k18 := k15 + k15a + k15b + k15c + k16 + k17 + k15k7 + k15k8 + k15k9 + k15k10
   podatek := k18
   SELECT spolka
   *---------------
   k19 := zaaa + zbbb

   *k21 =_round(max(0,k18-(k19+zzdrowie)),1)
   k21 := _round( Max( 0, k18 - ( k19 /*+ zzdrowie*/ ) ), 0 )

   *k21a=_round(max(0,k18-(k19+zzdrowie)),1)
   *k22=_round(zaliczki,1)
   k21a := Max( 0, k18 - ( k19 /*+ zzdrowie*/ ) )
   k22 := zaliczki

   k23 := _round( Max( 0, k21a - k22 ), 0 )

   DO CASE
   CASE OKRES == 'M'
      wartprzek := k21
   CASE OKRES == 'K'
      wartprzek := k23
   CASE OKRES == 'N'
      wartprzek := k23
   ENDCASE

*                if OKRES='N'
*                   wartprzek=k23
*                else
*                   wartprzek=k21
*                endif
*############################### WYSWIETLANIE ###############################
   ColInf()
   @  3, 0 SAY '[B,W]-wplata gotowkowa   [L,N]-przelew   [P]-wplata pocztowa   [D]-wydruk ekranu'
   ColStd()
   @  4, 0 SAY '                                                                                '
   @  5, 0 SAY '                                                                                '
   @  6, 0 SAY '                                                                                '

   @  6, 0 SAY ' ( Odliczenia.......... )³Przychody ³Struktura%³Odliczenia³  Razem   ³ Podatek  '
   @  7, 0 SAY ' 1 (5) ' + PadR( AllTrim( SubStr( staw_ory20, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   @  8, 0 SAY ' 2 (6) ' + PadR( AllTrim( SubStr( staw_ory17, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   @  9, 0 SAY ' 3 (7) ' + PadR( AllTrim( SubStr( staw_ork09, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   @ 10, 0 SAY ' 4 (8) ' + PadR( AllTrim( SubStr( staw_ouslu, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   @ 11, 0 SAY ' 5 (9) ' + PadR( AllTrim( SubStr( staw_ork10, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   @ 12, 0 SAY ' 6 (10)' + PadR( AllTrim( SubStr( staw_oprod, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   @ 13, 0 SAY ' 7 (11)' + PadR( AllTrim( SubStr( staw_ohand, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   @ 14, 0 SAY ' 8 (12)' + PadR( AllTrim( SubStr( staw_ork07, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   @ 15, 0 SAY ' 9 (13)' + PadR( AllTrim( SubStr( staw_ory10, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   /*
   IF staw_k08w
      @ 14, 0 SAY ' 8 (12)' + PadR( AllTrim( SubStr( staw_ork08, 1, 10 ) ), 10 ) + '(      )³          ³          ³          ³          ³          '
   ELSE
      @ 14, 0 SAY '                                                                                '
   ENDIF
   */
   *@ 15, 0 SAY ' -------------------------------------------------------------------------------'
   @ 16, 0 SAY '10 Razem.................³          ³          ³          ³          ³          '
   @ 17, 0 SAY '11 Ulgi podlegaj&_a.ce odliczeniu od podatku.......................                '
   @ 18, 0 SAY '12 Na kas&_e. chorych..............................................                '
   IF OKRES == 'N'
      @ 19, 0 SAY '13 Podatek od pocz&_a.tku roku.....................................                '
      @ 20, 0 SAY '14 Wp&_l.acono zaliczkami za miesi&_a.ce poprzednie...................                '
      @ 21, 0 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
      @ 22, 0 SAY '15 Podatek do zap&_l.aty...........................................                '
   ELSE
      @ 19, 0 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
      @ 20, 0 SAY '13 Podatek do zap&_l.aty...........................................                '
      @ 21, 0 SAY '                                                                                '
      @ 22, 0 SAY '                                                                                '
   ENDIF
   @  7,18 SAY staw_ry20 * 100 PICTURE '99.99%'
   @  8,18 SAY staw_ry17 * 100 PICTURE '99.99%'
   @  9,18 SAY staw_rk09 * 100 PICTURE '99.99%'
   @ 10,18 SAY staw_uslu * 100 PICTURE '99.99%'
   @ 11,18 SAY staw_rk10 * 100 PICTURE '99.99%'
   @ 12,18 SAY staw_prod * 100 PICTURE '99.99%'
   @ 13,18 SAY staw_hand * 100 PICTURE '99.99%'
   @ 14,18 SAY staw_rk07 * 100 PICTURE '99.99%'
   @ 15,18 SAY staw_ry10 * 100 PICTURE '99.99%'
   /*
   IF staw_k08w
      @ 14,18 SAY staw_rk08 * 100 PICTURE '99.99%'
   ENDIF
   */
   ColInf()
   Center( 4, dos_c( ' Podatnik - ' + SubStr( naz_imie, 1, 30 ) + ' ' ) )
   DO CASE
   CASE OKRES == 'M'
      center( 5, dos_c( ' Za miesi&_a.c ' ) )
   CASE OKRES == 'K'
      center( 5, dos_c( ' Za kwarta&_l. ' ) )
   case OKRES == 'N'
      center( 5, dos_c( ' Narastaj&_a.co ' ) )
   ENDCASE

*if OKRES='M'
*   center(5,dos_c([ Za miesi&_a.c ]))
*else
*   center(5,dos_c([ Narastaj&_a.co ]))
*endif

   ColStd()
   set color to +w
   @  7, 26 SAY k1a PICTURE '@Z 9999999.99'
   @  8, 26 SAY k1b PICTURE '@Z 9999999.99'
   @  9, 26 SAY k1k9 PICTURE '@Z 9999999.99'
   @ 10, 26 SAY k1  PICTURE '@Z 9999999.99'
   @ 11, 26 SAY k1k10 PICTURE '@Z 9999999.99'
   @ 12, 26 SAY k2  PICTURE '@Z 9999999.99'
   @ 13, 26 SAY k3  PICTURE '@Z 9999999.99'
   @ 14, 26 SAY k1k7 PICTURE '@Z 9999999.99'
   @ 15, 26 SAY k1c PICTURE '@Z 9999999.99'
   /*
   IF staw_k08w
      @ 14, 26 SAY k1k8 PICTURE '@Z 9999999.99'
   ENDIF
   */

   @  7, 39 SAY k6a PICTURE '@Z 999.99'
   @  8, 39 SAY k6b PICTURE '@Z 999.99'
   @  9, 39 SAY k6k9 PICTURE '@Z 999.99'
   @ 10, 39 SAY k6  PICTURE '@Z 999.99'
   @ 11, 39 SAY k6k10 PICTURE '@Z 999.99'
   @ 12, 39 SAY k7  PICTURE '@Z 999.99'
   @ 13, 39 SAY k8  PICTURE '@Z 999.99'
   @ 14, 39 SAY k6k7 PICTURE '@Z 999.99'
   @ 15, 39 SAY k6c PICTURE '@Z 999.99'
   /*
   IF staw_k08w
      @ 14, 39 SAY k6k8 PICTURE '@Z 999.99'
   ENDIF
   */

   @  6, 15 SAY k55 PICTURE '99999.99'

   @  7, 48 SAY k9a PICTURE '@Z 9999999.99'
   @  8, 48 SAY k9b PICTURE '@Z 9999999.99'
   @  9, 48 SAY k9k9 PICTURE '@Z 9999999.99'
   @ 10, 48 SAY k9  PICTURE '@Z 9999999.99'
   @ 11, 48 SAY k9k10 PICTURE '@Z 9999999.99'
   @ 12, 48 SAY k10 PICTURE '@Z 9999999.99'
   @ 13, 48 SAY k11 PICTURE '@Z 9999999.99'
   @ 14, 48 SAY k9k7 PICTURE '@Z 9999999.99'
   @ 15, 48 SAY k9c PICTURE '@Z 9999999.99'
   /*
   IF staw_k08w
      @ 14, 48 SAY k9k8 PICTURE '@Z 9999999.99'
   ENDIF
   */

   @  7, 59 SAY k12a PICTURE '@Z 9999999.99'
   @  8, 59 SAY k12b PICTURE '@Z 9999999.99'
   @  9, 59 SAY k12k9 PICTURE '@Z 9999999.99'
   @ 10, 59 SAY k12 PICTURE '@Z 9999999.99'
   @ 11, 59 SAY k12k10 PICTURE '@Z 9999999.99'
   @ 12, 59 SAY k13 PICTURE '@Z 9999999.99'
   @ 13, 59 SAY k14 PICTURE '@Z 9999999.99'
   @ 14, 59 SAY k12k7 PICTURE '@Z 9999999.99'
   @ 15, 59 SAY k12c PICTURE '@Z 9999999.99'
   /*
   IF staw_k08w
      @ 14, 59 SAY k12k8 PICTURE '@Z 9999999.99'
   ENDIF
   */

   @  7, 70 SAY k15a PICTURE '@Z 9999999.99'
   @  8, 70 SAY k15b PICTURE '@Z 9999999.99'
   @  9, 70 SAY k15k9 PICTURE '@Z 9999999.99'
   @ 10, 70 SAY k15 PICTURE '@Z 9999999.99'
   @ 11, 70 SAY k15k10 PICTURE '@Z 9999999.99'
   @ 12, 70 SAY k16 PICTURE '@Z 9999999.99'
   @ 13, 70 SAY k17 PICTURE '@Z 9999999.99'
   @ 14, 70 SAY k15k7 PICTURE '@Z 9999999.99'
   @ 15, 70 SAY k15c PICTURE '@Z 9999999.99'
   /*
   IF staw_k08w
      @ 14, 70 SAY k15k8 PICTURE '@Z 9999999.99'
   ENDIF
   */

   @ 16, 26 SAY k1a + k1b + k1k9 + k1 + k1k10 + k2 + k3 + k1k7 + k1c PICTURE '9999999.99'
   @ 16, 48 SAY k9a + k9b + k9k9 + k9 + k9k10 + k10 + k11 + k9k7 + k9c PICTURE '9999999.99'
   @ 16, 59 SAY k12a + k12b + k12k9 + k12 + k12k10 + k13 + k14 + k12k7 + k12c PICTURE '9999999.99'
   @ 16, 70 SAY k18 PICTURE '9999999.99'

   @ 17, 65 SAY k19 PICTURE ' 999 999 999.99'
   @ 18, 65 SAY zzdrowie PICTURE ' 999 999 999.99'

   IF OKRES == 'N'
      @ 19, 65 SAY k21a PICTURE ' 999 999 999.99'
      @ 20, 65 SAY k22 PICTURE ' 999 999 999.99'
      @ 22, 65 SAY k23 PICTURE ' 999 999 999.99'
   ELSE
      @ 20, 65 SAY k21 PICTURE ' 999 999 999.99'
   ENDIF

*do case
*case OKRES='M'
*     @ 20,65 say k21 pict ' 999 999 999.99'
*case OKRES='K'
*     @ 19,65 say k21a pict ' 999 999 999.99'
*     @ 20,65 say k22 pict ' 999 999 999.99'
*     @ 22,65 say k23 pict ' 999 999 999.99'
*case OKRES='N'
*     @ 19,65 say k21a pict ' 999 999 999.99'
*     @ 20,65 say k22 pict ' 999 999 999.99'
*     @ 22,65 say k23 pict ' 999 999 999.99'
*endcase

*if OKRES='N'
*   @ 19,65 say k21a pict ' 999 999 999.99'
*   @ 20,65 say k22 pict ' 999 999 999.99'
*   @ 22,65 say k23 pict ' 999 999 999.99'
*else
*   @ 20,65 say k21 pict ' 999 999 999.99'
*endif
   SET COLOR TO
   SELECT spolka
   *################################## PRZEKAZ #################################
   zNAZWA_PLA := SubStr( naz_imie, 1, 30 )
   zULICA_PLA := AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + iif( Len( AllTrim( nr_mieszk ) ) > 0, '/' + AllTrim( nr_mieszk ), '' )
   zMIEJSC_PLA := AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_zam )
   zBANK_PLA := firma->bank
   zKONTO_PLA := firma->nr_konta
   ztr1 := PadR( StrTran( AllTrim( nip ), '-', '' ), 14 )
   ztr2 := ' N  '
   DO CASE
   CASE OKRES == 'M'
      ztr3 := ' ' + SubStr( param_rok, 3, 2 ) + 'M' + StrTran( PadL( miesiac, 2 ), ' ', '0' ) + '  '
   CASE OKRES == 'K'
      ztr3 := ' ' + SubStr( param_rok, 3, 2 ) + 'K' + StrTran( PadL( Str( Val( kwarkon ) / 3, 2 ), 2 ), ' ', '0' ) + '  '
   CASE OKRES == 'N'
      ztr3 := ' ' + SubStr( param_rok, 3, 2 ) + 'R    '
   ENDCASE
   IF OKRES == 'N' .AND. miesiac == '12'
      ztr4 := 'PIT28   '
   ELSE
      ztr4 := 'PPE     '
   ENDIF
   zTRESC := ztr1 + ztr2 + ztr3 + ztr4
   *zTRESC='PIT27 '+miesiac+'.'+param_rok+' NIP:'+padc(alltrim(nip),13)

   SELECT 7
   DO WHILE! Dostep( 'URZEDY' )
   ENDDO
   SET INDEX TO urzedy
   GO spolka->skarb
   zNAZWA_WIE := 'URZ&__A.D SKARBOWY ' + AllTrim( URZAD )
   zULICA_WIE := AllTrim( ULICA ) + ' ' + AllTrim( NR_DOMU )
   zMIEJSC_WIE := AllTrim( KOD_POCZT ) + ' ' + AllTrim( MIEJSC_US )
   zBANK_WIE := BANK
   zKONTO_WIE := KONTODOCH

   clear type
   kkk := Inkey( 0, INKEY_KEYBOARD )
   zPodatki := .T.
   DO CASE
   CASE kkk == Asc( 'D' ) .OR. kkk == Asc( 'd' )

      SWITCH GraficznyCzyTekst( 'inforycz' )
      CASE 1

         aDaneDruk := { ;
            'firma' => AllTrim( firma->nazwa ), ;
            'nazwisko' => AllTrim( spolka->naz_imie ), ;
            'staw_ory20' => AllTrim( staw_ory20 ), ;
            'staw_ory17' => AllTrim( staw_ory17 ), ;
            'staw_ork09' => AllTrim( staw_ork09 ), ;
            'staw_ouslu' => AllTrim( staw_ouslu ), ;
            'staw_ork10' => AllTrim( staw_ork10 ), ;
            'staw_oprod' => AllTrim( staw_oprod ), ;
            'staw_ohand' => AllTrim( staw_ohand ), ;
            'staw_ork07' => AllTrim( staw_ork07 ), ;
            'staw_ory10' => AllTrim( staw_ory10 ), ;
            'staw_ry20' => staw_ry20 * 100, ;
            'staw_ry17' => staw_ry17 * 100, ;
            'staw_rk09' => staw_rk09 * 100, ;
            'staw_uslu' => staw_uslu * 100, ;
            'staw_rk10' => staw_rk10 * 100, ;
            'staw_prod' => staw_prod * 100, ;
            'staw_hand' => staw_hand * 100, ;
            'staw_rk07' => staw_rk07 * 100, ;
            'staw_ry10' => staw_ry10 * 100, ;
            'okres' => iif( OKRES == 'M', 'Za miesi¥c ' + AllTrim( miesiac( Val( miesiac ) ) ), ;
               iif( OKRES == 'K', 'Za ' + AllTrim( Str( ObliczKwartal( Val( miesiac ) )[ 'kwarta' ] ) ) + ' kwartaˆ', ;
               iif( OKRES == 'N', 'Narastaj¥co ' + AllTrim( miesiac( Val( miesiac ) ) ), '?' ) ) ), ;
            'rok' => param_rok, ;
            'k55' => k55, ;
            'k1a' => k1a, ;
            'k1b' => k1b, ;
            'k1k9' => k1k9, ;
            'k1' => k1, ;
            'k1k10' => k1k10, ;
            'k2' => k2, ;
            'k3' => k3, ;
            'k1k7' => k1k7, ;
            'k1c' => k1c, ;
            'k6a' => k6a, ;
            'k6b' => k6b, ;
            'k6k9' => k6k9, ;
            'k6' => k6, ;
            'k6k10' => k6k10, ;
            'k7' => k7, ;
            'k8' => k8, ;
            'k6k7' => k6k7, ;
            'k6c' => k6c, ;
            'k9a' => k9a, ;
            'k9b' => k9b, ;
            'k9k9' => k9k9, ;
            'k9' => k9, ;
            'k9k10' => k9k10, ;
            'k10' => k10, ;
            'k11' => k11, ;
            'k9k7' => k9k7, ;
            'k9c' => k9c, ;
            'k12a' => k12a, ;
            'k12b' => k12b, ;
            'k12k9' => k12k9, ;
            'k12' => k12, ;
            'k12k10' => k12k10, ;
            'k13' => k13, ;
            'k14' => k14, ;
            'k12k7' => k12k7, ;
            'k12c' => k12c, ;
            'k15a' => k15a, ;
            'k15b' => k15b, ;
            'k15k9' => k15k9, ;
            'k15' => k15, ;
            'k15k10' => k15k10, ;
            'k16' => k16, ;
            'k17' => k17, ;
            'k15k7' => k15k7, ;
            'k15c' => k15c, ;
            'sum1' => k1a + k1b + k1k9 + k1 + k1k10 + k2 + k3 + k1k7 + k1c, ;
            'sum2' => k9a + k9b + k9k9 + k9 + k9k10 + k10 + k11 + k9k7 + k9c, ;
            'sum3' => k12a + k12b + k12k9 + k12 + k12k10 + k13 + k14 + k12k7 + k12c, ;
            'k18' => k18, ;
            'k19' => k19, ;
            'zzdrowie' => zzdrowie, ;
            'k21a' => iif( OKRES == 'N', k21a, 0 ), ;
            'k22' => iif( OKRES == 'N', k22, 0 ), ;
            'k23' => iif( OKRES == 'N', k23, 0 ), ;
            'k21' => iif( OKRES == 'N', 0, k21 ), ;
            'narast' => iif( OKRES == 'N', 1, 0 ) }

         FRDrukuj( 'frf\inforycz.frf', aDaneDruk )
         EXIT

      CASE 2

         DrukujEkran( { PadC( AllTrim( firma->nazwa ), 80 ), ;
            PadC( 'Miesi&_a.c ' + param_rok + '.' + StrTran( PadL( miesiac, 2 ), ' ', '0' ), 80 ) }, , 4, 22 )
         EXIT

      END SWITCH

   CASE kkk == Asc( 'W' ) .OR. kkk == Asc( 'w' ) .OR. kkk == Asc( 'B' ) .OR. kkk == Asc( 'b' )
      zNAZWA_PLA := zNAZWA_PLA + Space( 30 )
      @ 23, 0 CLEAR TO 23, 79
      @ 23, 0 SAY 'Nazwa wp&_l.acaj&_a.cego' GET zNAZWA_PLA PICTURE repl( 'X', 60 )
      Read_()

      SAVE SCREEN TO scr_
      zKWOTA := wartprzek
      AFill( nazform, '' )
      AFill( strform, 0 )
      nazform[ 1 ] := 'WPLATN'
      strform[ 1 ] := 1
      Form( nazform, strform, 1 )
      RESTORE SCREEN FROM scr_

   CASE kkk == Asc( 'N' ) .OR. kkk == Asc( 'n' ) .OR. kkk == Asc( 'L' ) .OR. kkk == Asc( 'l' )
      zNAZWA_PLA=zNAZWA_PLA+space(30)
      @ 23, 0 CLEAR TO 23, 79
      @ 23, 0 SAY 'Nazwa wp&_l.acaj&_a.cego' GET zNAZWA_PLA PICTURE repl( 'X', 60 )
      Read_()

      SAVE SCREEN TO scr_
      zKWOTA := wartprzek
      AFill( nazform, '' )
      AFill( strform, 0 )
      nazform[ 1 ] := 'PRZELN'
      strform[ 1 ] := 1
      Form( nazform, strform, 1 )
      RESTORE SCREEN FROM scr_

   CASE kkk == Asc( 'P' ) .OR. kkk == Asc( 'p' )
      zNAZWA_PLA := zNAZWA_PLA + Space( 30 )
      @ 23, 0 CLEAR TO 23, 79
      @ 23, 0 SAY 'Nazwa wp&_l.acaj&_a.cego' GET zNAZWA_PLA PICTURE repl( 'X', 60 )
      Read_()

      SAVE SCREEN TO scr3
      Przek( zNAZWA_WIE, ;
         zNAZWA_PLA, ;
         zULICA_WIE, ;
         zULICA_PLA, ;
         zMIEJSC_WIE, ;
         zMIEJSC_PLA, ;
         zBANK_WIE, ;
         zKONTO_WIE, ;
         wartprzek, ;
         zTRESC )
*    do przekaz with wartprzek,'D'
      RESTORE SCREEN FROM scr3
   ENDCASE
   zPodatki := .F.
   SELECT spolka
   ****************************
   RETURN
