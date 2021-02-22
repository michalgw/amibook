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

PROCEDURE Pit_5Z( _G, _M, _STR, _OU )

   RAPORT := RAPTEMP
   dzial_g := Array( 2, 9 )
   FOR x_y := 1 TO 2
      dzial_g[ x_y, 1 ] := Space( 26 )
      dzial_g[ x_y, 2 ] := Space( 18 )
      dzial_g[ x_y, 3 ] := Space( 32 )
      dzial_g[ x_y, 4 ] := Space( 32 )
      dzial_g[ x_y, 5 ] := 0
      dzial_g[ x_y, 6 ] := 0
      dzial_g[ x_y, 7 ] := 0
      dzial_g[ x_y, 8 ] := 0
      dzial_g[ x_y, 9 ] := 0
   NEXT
   PRIVATE P3, P4, P5, P6, P7, P8, P9
   PRIVATE P10, P11, P12, P13, P14, P15, p15a, P16, P17, P18, P19
   PRIVATE P20, P21, P22, P23, P24, P25, P26, P27, P28, P29
   PRIVATE P30, P31, P32, P33, P34, P35, P36, P37, P38, P39
   PRIVATE P40, P41, P42, P43, P44, P45, P46, P47, P48
   PRIVATE P50, P51, P52, P54, P541, P55
   PRIVATE P62, P63, P64, P67, P68
   PRIVATE P76, P77, P78, P79
   PRIVATE P80, P81, P82, P83, P85, P86, P87, P88, P89
   PRIVATE P90, P91, P92, P93, P94, P95, P96, P97, P98, P99
   PRIVATE P100, P101, P102, P103, P104, P105, P106, P107, P108
   PRIVATE P21A, P29A, P37A, P44A, P50A, P97MMM, P887MMM, P887MMMa
   PRIVATE SPOL, POJ
   PRIVATE ObiczKwWl := 'S'
   STORE 0 TO SPOL, POJ, P21A, P29A, P37A, P44A, P50A
   STORE 0 TO P32, P33, P34, P39, P40, P41, P46, P47, P48, P50, P51, P52, P55
   STORE 0 TO P62, P63, P64, P67, P68
   _czy_close := .F.
   *do &formproc with _dr_gr,_dr_lm,formstro,'D'
   *#################################     PIT_5      #############################
   BEGIN SEQUENCE
      SELECT 7
      IF Dostep( 'URZEDY' )
         SetInd( 'URZEDY' )
      ELSE
         BREAK
      ENDIF

      SELECT 6
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
      ELSE
         BREAK
      ENDIF

      SELECT 5
      IF Dostep( 'OPER' )
         SetInd( 'OPER' )
         SET ORDER TO 3
      ELSE
         BREAK
      ENDIF

      SELECT 4
      IF Dostep('TAB_DOCH')
         SET INDEX TO tab_doch
      ELSE
         BREAK
      ENDIF
      IF del # '+'
         Kom( 3, '*u', ' Brak informacji w tabeli podatku dochodowego ' )
         BREAK
      ENDIF

      SELECT 3
      IF Dostep( 'DANE_MC' )
         SET INDEX TO dane_mc
      ELSE
         BREAK
      ENDIF

      SELECT 2
      IF Dostep( 'SUMA_MC' )
         SET INDEX TO suma_mc
      ELSE
         BREAK
      ENDIF
      SELECT spolka
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      IF Eof()
         Kom( 3, '*w', 'b r a k   d a n y c h' )
         BREAK
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
      ObiczKwWl := spolka->oblkwwol
      P3 := StrTran( NIP, '-', '' )
      P3 := rozrzut( SubStr( P3, 1, 3 ) ) + ' ' + rozrzut( SubStr( P3, 4, 3 ) ) + ' ' + rozrzut( SubStr( P3, 7, 2 ) ) + ' ' + rozrzut( SubStr( P3, 9, 2 ) )
      P4 := rozrzut( miesiac ) + '  ' + rozrzut( param_rok )
      SELECT urzedy
      IF firma->skarb > 0
         GO spolka->skarb
         P5 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
      ELSE
         P5 := Space( 60 )
      ENDIF
      SELECT spolka
      P6 := PESEL
      P7 := SubStr( NAZ_IMIE, 1, At( ' ', NAZ_IMIE ) )
      subim := SubStr( NAZ_IMIE, At( ' ', NAZ_IMIE ) + 1 )
      P8 := iif( At( ' ', subim ) == 0, subim, SubStr( subim, 1, At( ' ', subim ) ) )
      P9 := iif( At( ' ', subim ) + 1 == 1, '', SubStr( subim, At( ' ', subim ) + 1 ) )
      P10 := IMIE_O
      P11 := IMIE_M
      SET DATE germ
      P12 := DToC( DATA_UR )
      SET DATE ansi
      P12 := rozrzut( SubStr( P12, 1, 2 ) ) + ' ' + rozrzut( SubStr( P12, 4, 2 ) ) + ' ' + rozrzut( SubStr( P12, 7, 4 ) )
      P13 := MIEJSC_UR
      P15 := param_woj
      P15a := param_pow
      P16 := GMINA
      P17 := ULICA
      P18 := NR_DOMU
      P19 := NR_MIESZK
      P20 := MIEJSC_ZAM
      P21 := KOD_POCZT
      P22 := POCZTA
      P24 := TELEFON
      ********************** udzialy w miesiacach
      zm := '  0/1  '
      FOR i := 1 TO 12
         zm1 := 'udzial' + LTrim( Str( i ) )
         IF AllTrim( &zm1 ) <> '/'
            zm := &zm1
         ENDIF
         zm2 := 'udz' + LTrim( Str( i ) )
         &zm2 := zm
      NEXT
      P97MMM := 0
      P887MMM := 0
      P887MMMa := 0
      P887 := 0
   *  wait '..'+miesiac+'..'
      FOR xmc := 1 TO Val( miesiac )
         Pop( Str( xmc, 2 ) )
   *      wait xmc
   *      wait P97MMM
      NEXT
      STORE 0 TO SPOL, POJ, P21A, P29A, P37A, P44A, P50A
      STORE 0 TO P32, P33, P34, P39, P40, P41, P46, P47, P48, P50, P51, P52, P55
      STORE 0 TO P61, p61a, P62, P63, P64, P67, P68
      *-----remanenty-----
      SELECT oper
      SEEK '+' + ident_fir + miesiac + Chr( 254 )
      fou := Found()
      z_m := iif( fou, ZAKUP + UBOCZNE + REKLAMA + WYNAGR_G + WYDATKI, 0 )
      STORE 0 TO rem, rem_
      FOR i := Val( miesiac ) TO Val( mc_rozp ) STEP -1
         SEEK '+' + ident_fir + Str( i, 2 ) + Chr( 1 )
         IF Found()
            IF fou
               zm := 'udz' + LTrim( Str( i ) )
               rem := rem + ZAKUP + UBOCZNE + REKLAMA + WYNAGR_G + WYDATKI - z_m
               rem_ := rem_ + ( ZAKUP + UBOCZNE + REKLAMA + WYNAGR_G + WYDATKI - z_m ) * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
            ENDIF
            z_m := ZAKUP + UBOCZNE + REKLAMA + WYNAGR_G + WYDATKI
            IF i > Val( mc_rozp )
               SEEK '+' + ident_fir + Str( i - 1, 2 ) + Chr( 254 )
               z_m := iif( Found(), ZAKUP + UBOCZNE + REKLAMA + WYNAGR_G + WYDATKI, z_m )
            ENDIF
            fou := .T.
         ENDIF
      NEXT
      *-------------------
      SELECT suma_mc
      SEEK '+' + ident_fir + iif( Empty( mc_rozp ), '', mc_rozp )
      STORE 0 TO przychod, przychod_
      koszty := rem_
      DO WHILE del == '+' .AND. firma == ident_fir .AND. mc <= miesiac
         zm := 'udz' + LTrim( mc )
         przychod := przychod + _round( ( WYR_TOW + USLUGI ) * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) ), 2 )
         dzial_g[ 1, 5 ] := _round( Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) ), 2 ) * 100
         koszty := koszty + _round( ( ZAKUP + UBOCZNE + REKLAMA + WYNAGR_G + WYDATKI ) * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) ), 2 )
         SKIP
      ENDDO
      SELECT firma
      dzial_g[1,1] := rozrzut( NIP )
      dzial_g[1,2] := rozrzut( SubStr( nr_regon, 3, 9 ) )
      dzial_g[1,3] := AllTrim( NAZWA )
      dzial_g[1,4] := SubStr( AllTrim( miejsc ) + ' ' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + iif( Empty( nr_mieszk ), ' ', '/' + AllTrim( nr_mieszk ) ), 1, 34 )
      dzial_g[1,6] := przychod
      dzial_g[1,7] := koszty
      dzial_g[1,8] := Max( 0, przychod - koszty )
      dzial_g[1,9] := Abs( Min( 0, przychod - koszty ) )
      *****************************************************************************
      SELECT spolka
      zident := Str( RecNo(), 5 )
      SELECT dane_mc
      SEEK '+' + zident + miesiac

      Dane_Mc( '5' )

      IF LastKey() == K_ESC
         SELECT spolka
         BREAK
      ENDIF

      SEEK '+' + zident + iif( Empty( mc_rozp ), '', mc_rozp )
      STORE 0 TO zg_przych1, zg_przych2, zg_koszty1, zg_koszty2, zg_doch1, zg_doch2, zg_udzial1, zg_udzial2
      STORE .F. TO zg_spolka1, zg_spolka2
      STORE 0 TO zn_przych1, zn_przych2, zn_koszty1, zn_koszty2, zn_doch1, zn_doch2, zn_udzial1, zn_udzial2
      STORE .F. TO zn_spolka1, zn_spolka2
      STORE 0 TO zstraty, zstraty_n, zpowodz, zrentalim, zskladki, zorgany, zzwrot_ren, zzwrot_swi, zrehab, zkopaliny, zdarowiz, zwynagro, zinne, zbudowa, zubiegbud
      STORE 0 TO zinwest11, zubieginw, zdochzwol, zodseodmaj
      STORE 0 TO zaaa, zbbb, zzaliczka, zpoprz, zalp, zinneodpod
      STORE 0 TO zpit566, zpit567, zpit5104, zpit5105
      STORE 0 TO zpit5agosk, zpit5anajk, zpit5agosp, zpit5anajp, zpit5agoss, zpit5anajs
      STORE 0 TO zrod1_doch, zrod1_stra, zrod2_doch, zrod2_stra
      STORE 0 TO zg21, zh385, sumzdro, sumzdro1
      DO WHILE del == '+' .AND. ident == zident .AND. mc <= miesiac
         zg_przych1 := zg_przych1 + g_przych1
         zg_przych2 := zg_przych2 + g_przych2
         zg_koszty1 := zg_koszty1 + g_koszty1
         zg_koszty2 := zg_koszty2 + g_koszty2
         zg_udzial1 := Int( ( Val( Left( g_udzial1, 2 ) ) / Val( Right( g_udzial1, 3 ) ) ) * 100 )
         zg_udzial2 := Int( ( Val( Left( g_udzial2, 2 ) ) / Val( Right( g_udzial2, 3 ) ) ) * 100 )
         zn_przych1 := zn_przych1 + n_przych1
         zn_przych2 := zn_przych2 + n_przych2
         zn_koszty1 := zn_koszty1 + n_koszty1
         zn_koszty2 := zn_koszty2 + n_koszty2
         zn_udzial1 := Int( ( Val( Left( n_udzial1, 2 ) ) / Val( Right( n_udzial1, 3 ) ) ) * 100 )
         zn_udzial2 := Int( ( Val( Left( n_udzial2, 2 ) ) / Val( Right( n_udzial2, 3 ) ) ) * 100 )

         zstraty := zstraty + straty
         zstraty_n := zstraty_n + straty_n
         zpowodz := zpowodz + powodz

         zrentalim := zrentalim + rentalim

         zskladki := zskladki + skladki + skladkiw

         zorgany := zorgany + organy
         zzwrot_ren := zzwrot_ren + zwrot_ren
         zzwrot_swi := zzwrot_swi + zwrot_swi
         zrehab := zrehab + rehab
         zkopaliny := zkopaliny + kopaliny
         zdarowiz := zdarowiz + darowiz
         zwynagro := zwynagro + wynagro

         zubiegbud := zubiegbud + ubiegbud
         zbudowa := zbudowa + budowa

         zinne := zinne + inne

         zubieginw := zubieginw + ubieginw
         zinwest11 := zinwest11 + inwest11

         zdochzwol := zdochzwol + dochzwol

         zg21 := zg21 + g21
         zh385 := zh385 + h385
         sumzdro := sumzdro + zdrowie + zdrowiew
         zodseodmaj := odseodmaj

         zaaa := zaaa + aaa
         zbbb := zbbb + bbb
         zinneodpod := zinneodpod + inneodpod
         zzaliczka := zzaliczka + zaliczka
   *      zpit569 := zpit569+pit569
         zpit5105 := pit5105
   *     zpit5105 := zpit5105+(pit5104*(pit5105/100))
         zpit5agosk := zpit5agosk + pit5agosk
         zpit5anajk := zpit5anajk + pit5anajk
         zpit5agosp := zpit5agosp + pit5agosp
         zpit5anajp := zpit5anajp + pit5anajp

         SKIP
      ENDDO
      zg_doch1 := Max( 0, zg_przych1 - zg_koszty1 )
      zg_doch2 := Max( 0, zg_przych2 - zg_koszty2 )
      zn_doch1 := Max( 0, zn_przych1 - zn_koszty1 )
      zn_doch2 := Max( 0, zn_przych2 - zn_koszty2 )
      zpit566 := Max( 0, zpit5agosp - zpit5agosk )
      zpit567 := Max( 0, zpit5anajp - zpit5anajk )

      zg_stra1 := Abs( Min( 0, zg_przych1 - zg_koszty1 ) )
      zg_stra2 := Abs( Min( 0, zg_przych2 - zg_koszty2 ) )
      zn_stra1 := Abs( Min( 0, zn_przych1 - zn_koszty1 ) )
      zn_stra2 := Abs( Min( 0, zn_przych2 - zn_koszty2 ) )
      zpit5agoss := Max( 0, zpit5agosk - zpit5agosp )
      zpit5anajs := Max( 0, zpit5anajk - zpit5anajp )

      zrod1_doch := zg_doch1 + zg_doch2 + dzial_g[ 1, 8 ] + zpit566
      zrod1_stra := zg_stra1 + zg_stra2 + dzial_g[ 1, 9 ] + zpit5agoss
      zrod2_doch := zn_doch1 + zn_doch2 + zpit567
      zrod2_stra := zn_stra1 + zn_stra2 + zpit5anajs
      SELECT spolka
      SPOL := 2
      *****************************************************************************
      IF ! Empty( g_rodzaj1 )
         dzial_g[ spol, 1 ] := rozrzut( g_nip1 )
         dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon1, 3, 9 ) )
         dzial_g[ spol, 3 ] := g_rodzaj1
         dzial_g[ spol, 4 ] := g_miejsc1
         dzial_g[ spol, 5 ] := zg_udzial1
         dzial_g[ spol, 6 ] := zg_przych1
         dzial_g[ spol, 7 ] := zg_koszty1
         dzial_g[ spol, 8 ] := zg_doch1
         dzial_g[ spol, 9 ] := zg_stra1
         SPOL++
      ENDIF
      IF SPOL < 3
         IF ! Empty( g_rodzaj2 )
            dzial_g[ spol, 1 ] := rozrzut( g_nip2 )
            dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon2, 3, 9 ) )
            dzial_g[ spol, 3 ] := g_rodzaj2
            dzial_g[ spol, 4 ] := g_miejsc2
            dzial_g[ spol, 5 ] := zg_udzial2
            dzial_g[ spol, 6 ] := zg_przych2
            dzial_g[ spol, 7 ] := zg_koszty2
            dzial_g[ spol, 8 ] := zg_doch2
            dzial_g[ spol, 9 ] := zg_stra2
            SPOL++
         ENDIF
      ENDIF
   *  if SPOL<3
   *     if .not.empty(w_rodzaj1)
   *        dzial_g[spol,3]=w_rodzaj1
   *        dzial_g[spol,4]=w_miejsc1
   *        dzial_g[spol,5]=100
   *        dzial_g[spol,6]=zw_przych1
   *        dzial_g[spol,7]=zw_koszty1
   *        dzial_g[spol,8]=zw_doch1
   *        dzial_g[spol,9]=zw_stra1
   *        SPOL++
   *     endif
   *  endif
   *  if SPOL<3
   *     if .not.empty(w_rodzaj2)
   *        dzial_g[spol,3]=w_rodzaj2
   *        dzial_g[spol,4]=w_miejsc2
   *        dzial_g[spol,5]=100
   *        dzial_g[spol,6]=zw_przych2
   *        dzial_g[spol,7]=zw_koszty2
   *        dzial_g[spol,8]=zw_doch2
   *        dzial_g[spol,9]=zw_stra2
   *        SPOL++
   *     endif
   *  endif
   *  if SPOL<3
   *     if .not.empty(w_rodzaj3).and.SPOL=1
   *        dzial_g[spol,3]=w_rodzaj3
   *        dzial_g[spol,4]=w_miejsc3
   *        dzial_g[spol,5]=100
   *        dzial_g[spol,6]=zw_przych3
   *        dzial_g[spol,7]=zw_koszty3
   *        dzial_g[spol,8]=zw_doch3
   *        dzial_g[spol,9]=zw_stra3
   *     endif
   *  endif
      SPOL := 0
      STORE Space( 32 ) TO p120, p127
      STORE Space( 35 ) TO p121, p128
      STORE 0 TO p122, p123, p124, p125, p126, p129, p130, p131, p132, p133
      *****************************************************************************
      IF ! Empty( n_przedm1 )
         AA := Str( 120 + ( 7 * SPOL ), 3 )
         P&AA := n_przedm1
         AA := Str( 121 + ( 7 * SPOL ), 3 )
         P&AA := n_miejsc1
         AA := Str( 122 + ( 7 * SPOL ), 3 )
         P&AA := zn_udzial1
         AA := Str( 123 + ( 7 * SPOL ), 3 )
         P&AA := zn_przych1
         AA := Str( 124 + ( 7 * SPOL ), 3 )
         P&AA := zn_koszty1
         AA := Str( 125 + ( 7 * SPOL ), 3 )
         P&AA := zn_doch1
         AA := Str( 126 + ( 7 * SPOL ), 3 )
         P&AA := zn_stra1
         SPOL++
      ENDIF
      IF ! Empty( n_przedm2 )
         AA := Str( 120 + ( 7 * SPOL ), 3 )
         P&AA := n_przedm2
         AA := Str( 121 + ( 7 * SPOL ), 3 )
         P&AA := n_miejsc2
         AA := Str( 122 + ( 7 * SPOL ), 3 )
         P&AA := zn_udzial2
         AA := Str( 123 + ( 7 * SPOL ), 3 )
         P&AA := zn_przych2
         AA := Str( 124 + ( 7 * SPOL ), 3 )
         P&AA := zn_koszty2
         AA := Str( 125 + ( 7 * SPOL ), 3 )
         P&AA := zn_doch2
         AA := Str( 126 + ( 7 * SPOL ), 3 )
         P&AA := zn_stra2
         SPOL++
      ENDIF
      *------------------------------------
      p27 := zg_przych1 + zg_przych2 + zpit5agosp + dzial_g[ 1, 6 ]
      p28 := zg_koszty1 + zg_koszty2 + zpit5agosk + dzial_g[ 1, 7 ]

      p31 := zn_przych1 + zn_przych2 + zpit5anajp
      p32 := zn_koszty1 + zn_koszty2 + zpit5anajk

      p29 := Max( 0, p27 - p28 )
      p30 := Max( 0, p28 - p27 )
      p33 := Max( 0, p31 - p32 )
      p34 := Max( 0, p32 - p31 )
      *------------------------------------
      P45 := P27 + P31
      P46 := P28 + P32
      P47 := P29 + P33
      p48 := p30 + p34

   //   P49=min(p29,zpit569)
      P50 := ZRENTALIM
      p51 := Min( p29, zstraty ) + Min( p33, Zstraty_n ) + Zpowodz

      IF P50 > p47
         P50 := P47
         P51 := 0
      ELSE
         IF P50 + P51 > p47
            P51 := p47 - ( P50 )
         ENDIF
      ENDIF

      P52 := p47 - ( p50 + p51 )

      P54 := ZSKLADKI
      P55 := ZORGANY + zzwrot_ren + Zzwrot_swi + ZREHAB + ZKOPALINY + ZDAROWIZ + ZWYNAGRO

      P64 := ZUBIEGBUD
      P63 := ZBUDOWA
      P63o := odlicz2

      P62o := odlicz1
      P62 := ZINNE

      P83o := s_rodzaj

      P68 := ZUBIEGINW
      P67 := ZINWEST11

      P76 := zDOCHZWOL
      IF P50 > 0
         P76 := 0
      ENDIF

      IF P54 > P52
         P54 := P52
         P55 := 0
         P64 := 0
         P63 := 0
         P62 := 0
         P68 := 0
         P67 := 0
         P76 := 0
      ELSE
         IF P54 + P55 > p52
            P55 := P52 - P54
            P64 := 0
            P63 := 0
            P62 := 0
            P68 := 0
            P67 := 0
            P76 := 0
         ELSE
            IF P54 + P55 + P64 > p52
               P64 := p52 - ( P54 + P55 )
               P63 := 0
               P62 := 0
               P68 := 0
               P67 := 0
               P76 := 0
            ELSE
               IF P54 + P55 + P64 + P63 > p52
                  P63 := p52 - ( P54 + P55 + P64 )
                  P62 := 0
                  P68 := 0
                  P67 := 0
                  P76 := 0
               ELSE
                  IF P54 + P55 + P64 + P63 + P62 > p52
                     P62 := p52 - ( P54 + P55 + P64 + P63 )
                     P68 := 0
                     P67 := 0
                     P76 := 0
                  ELSE
                     IF P54 + P55 + P64 + P63 + P62 + P68 > p52
                        P68 := p52 - ( P54 + P55 + P64 + P63 + P62 )
                        P67 := 0
                        P76 := 0
                     ELSE
                        IF P54 + P55 + P64 + P63 + P62 + P68 + P67 > p52
                           P67 := p52 - ( P54 + P55 + P64 + P63 + P62 + P68 )
                           P76 := 0
                        ELSE
                           IF P54 + P55 + P64 + P63 + P62 + P68 + P67 + P76 > p52
                              P76 := p52 - ( P54 + P55 + P64 + P63 + P62 + P68 + P67 )
                           ENDIF
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF
         ENDIF
      ENDIF

      P77 := Max( 0, P52 - ( P54 + P55 + P62 + P63 + P64 + P67 + P68 + P76 ) )

      p75 := zg21

      p777 := 0
      IF p29 > 0
         p777 := p77+p75
      ELSE
         IF p29 == 0 .AND. p30 < p75
            p777 := p77 + p75 - p30
         ELSE
            p777 := p77
         ENDIF
      ENDIF
      p777 := _round( p777, 0 )

      podst := P777
      *--------------- podatek dochodowy wg tabeli
      IF ObiczKwWl == 'S' .OR. ObiczKwWl == ' '
         SELECT tab_doch
         SEEK '-'
         SKIP -1
      ENDIF
      podatek := 0
      zm := podst
      IF ObiczKwWl == 'S' .OR. ObiczKwWl == ' '
         DO WHILE ! Bof()
            podatek := podatek + Max( 0, Min( podst, zm ) - podstawa ) * procent / 100
            zm := podstawa
            SKIP -1
         ENDDO
         SELECT spolka
         IF param_kskw = 'N'
            IF TabDochProcent( podst, 'tab_doch' ) == 18
               podatek := Max( 0, podatek - param_kw )
            ENDIF
         ELSE
            podatek := Max( 0, podatek - param_kw )
         ENDIF
      ELSE
         podatek := TabDochPodatek( podst, 'tab_doch' )
      ENDIF
      *---------------
      P79 := podatek
      P80 := sumzdro
      P81 := ZAAA
      P82 := ZBBB
      P83 := zINNEODPOD
      IF P80 > p79
         P80 := p79
         P81 := 0
         P82 := 0
         P83 := 0
      ELSE
         IF P80 + P81 > p79
            P81 := P79 - P80
            P82 := 0
            P83 := 0
         ELSE
            IF P80 + P81 + P82 > p79
               P82 := P79 - ( P80 + P81 )
               P83 := 0
            ELSE
               IF P80 + P81 + P82 + P83 > p79
                  P83 := P79 - ( P80 + P81 + P82 )
               ENDIF
            ENDIF
         ENDIF
      ENDIF

      P85 := Max( 0, p79 - ( P80 + P81 + P82 + P83 ) )
      P92 := P97MMM
      p93 := _round( Max( 0, p85 - p92 ), 1 )
      p94 := p92 + p93

      p884 := h384
      p885 := zh385
      p886 := rozrzut( SubStr( DToS( h386 ), 7, 2 ) ) + ' ' + rozrzut( SubStr( DToS( h386 ), 5, 2 ) ) + ' ' + rozrzut( SubStr( DToS( h386 ), 1, 4 ) )
      P887MMMa := P887MMMa + P887MMM
      P887MMM := _round( Min( p93, p885 - P887MMMa ), 1 )
      P887 := P887MMMa
   *   P888 := _round(min(p93,P885-P887),1)
      P888 := P887MMM

   *  p87=zpit5104
   *  wspreman=int((zpit5105/zpit5104)*100)

      p889 := P93 - P888
      p88 := zpit5105
      p89 := p889 + p88
      p90 := zodseodmaj

      IF Val( miesiac ) < 12
         SELECT dane_mc
         recdmc := RecNo()
         IF del == '+' .AND. ident == zident .AND. mc == Str( Val( miesiac ) + 1, 2 )
            BlokadaR()
            REPLACE zaliczkap WITH ( p89 + p90 )
            UNLOCK
         ENDIF
         GO recdmc
      ENDIF
      picf := '@E 9999999 .99'
      picfe := '@E 999999999 .99'
      picf1 := '@E 9 999 999 .99'
      SELECT 100
      USE &RAPORT VIA "ARRAYRDD"
      DO CASE
      CASE _OU == 'D'
         DO CASE
         CASE _STR == 1
            FOR x := 1 TO _G
               rl()
            NEXT
            rl( Space( _M ) + Space( 2 ) + P3 )
            FOR x := 1 TO 5
               rl()
            NEXT
            rl( Space( _M ) + Space( 20 ) + P4 )
            FOR x := 1 TO 11
               rl()
            NEXT
            rl( Space( _M ) + Space( 10 ) + PadC( AllTrim( P5 ), 60 ) )
            FOR x := 1 TO 5
               rl()
            NEXT
            rl( Space( _M ) + Space( 16 ) + PadC( AllTrim( P7 ), 30 ) )
            rl()
            rl( Space( _M ) + Space( 6 ) + PadC( AllTrim( P8 ), 32 ) + Space( 18 ) + p12 )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 6 ) + PadC( 'POLSKA', 15 ) + Space( 1 ) + PadC( P15, 31 ) + Space( 1 ) + PadC( p15a, 24 ) )
            rl()
            rl( Space( _M ) + Space( 6 ) + PadC( P16, 18 ) + Space( 1 ) + PadC( P17, 36 ) + Space( 1 ) + PadC( p18, 8 ) + Space( 1 ) + PadC( p19, 8 ) )
            rl()
            rl( Space( _M ) + Space( 6 ) + PadC( AllTrim( P20 ), 25 ) + Space( 8 ) + P21 + Space( 4 ) + PadC( AllTrim( P22 ), 25 ) )
            FOR x := 1 TO 7
               rl()
            NEXT
            rl( Space( _M ) + Space( 22 ) + tran( P27, picfe ) + Space( 0 ) + tran( P28, picfe ) + Space( 2 ) + tran( P29, picf ) + Space( 2 ) + tran( P30, picf ) )
            rl()
            rl( Space( _M ) + Space( 22 ) + tran( P31, picfe ) + Space( 0 ) + tran( P32, picfe ) + Space( 2 ) + tran( P33, picf ) + Space( 2 ) + tran( P34, picf ) )
            rl()
            rl( Space( _M ) + Space( 22 ) + tran( P45, picfe ) + Space( 0 ) + tran( P46, picfe ) + Space( 2 ) + tran( P47, picf ) + Space( 2 ) + tran( P48, picf ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P50, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P51, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P52, picf1 ) )
         CASE _STR == 2
            FOR x := 1 TO _G
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P54, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P55, picf1 ) )
            FOR x := 1 TO 5
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P64, picf1 ) )
            rl()
            rl()
            rl( Space( _M ) + Space( 21 ) + PadC( AllTrim( P63O ), 30 ) + Space( 10 ) + tran( P63, picf1 ) )
            FOR x := 1 TO 5
               rl()
            NEXT
            rl( Space( _M ) + Space( 21 ) + PadC( AllTrim( P62O ), 30 ) + Space( 10 ) + tran( P62, picf1 ) )
            FOR x := 1 TO 4
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P68, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P67, picf1 ) )
            FOR x := 1 TO 5
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P76, picf1 ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P77, picf1 ) )
            FOR x := 1 TO 4
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P75, picf1 ) )
            rl()
            rl()
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P777, picf1 ) )
            FOR x := 1 TO 6
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P79, picf1 ) )
         CASE _STR == 3
            FOR x := 1 TO _G
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P80, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P81, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P82, picf1 ) )
            rl()
            rl()
            rl( Space( _M ) + Space( 21 ) + PadC( AllTrim( P83o ), 30 ) + Space( 10 ) + tran( P83, picf1 ) )
            FOR x := 1 TO 4
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P85, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P92, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P93, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P94, picf1 ) )
            FOR x := 1 TO 4
               rl()
            NEXT
            rl( Space( _M ) + Space( 13 ) + PadC( p884, 20 ) + Space( 10 ) + p886 )
            rl()
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P885, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P887, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P888, picf1 ) )
            FOR x := 1 TO 2
               rl()
            NEXT
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P889, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P88, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P89, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P90, picf1 ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 12 ) + dzial_g[ 1, 1 ] + Space( 18 ) + dzial_g[ 1, 2 ] )
            rl()
            rl( Space( _M ) + Space( 4 ) + PadC( dzial_g[ 1, 3 ], 35 ) + Space( 2 ) + PadC( AllTrim( dzial_g[ 1, 4 ] ), 34 ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + tran( dzial_g[ 1, 5 ], '999' ) + Space( 2 ) + tran( dzial_g[ 1, 6 ], picfe ) + Space( 2 ) + tran( dzial_g[ 1, 7 ], picfe ) + Space( 3 ) + tran( dzial_g[ 1, 8 ], picf ) + Space( 4 ) + tran( dzial_g[ 1, 9 ], picf ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + dzial_g[ 2, 1 ] + Space( 18 ) + dzial_g[ 2, 2 ] )
            rl()
            rl( Space( _M ) + Space( 4 ) + PadC( dzial_g[ 2, 3 ], 35 ) + Space( 2 ) + PadC( AllTrim( dzial_g[ 2, 4 ] ), 34 ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + tran( dzial_g[ 2, 5 ], '999' ) + Space( 2 ) + tran( dzial_g[ 2, 6 ], picfe ) + Space( 2 ) + tran( dzial_g[ 2, 7 ], picfe ) + Space( 3 ) + tran( dzial_g[ 2, 8 ], picf ) + Space( 4 ) + tran( dzial_g[ 2, 9 ], picf ) )
         CASE _STR == 4
            FOR x := 1 TO _G
               rl()
            NEXT
            rl( Space( _M ) + Space( 7 ) + PadC( P120, 32 ) + Space( 1 ) + PadC( P121, 35 ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + tran( p122, '999' ) + Space( 3 ) + tran( P123, picfe ) + Space( 1 ) + tran( P124, picfe ) + Space( 4 ) + tran( P125, picf ) + Space( 3 ) + tran( P126, picf ) )
            rl()
            rl( Space( _M ) + Space( 7 ) + PadC( P127, 32 ) + Space( 1 ) + PadC( P128, 35 ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + tran( p129, '999' ) + Space( 3 ) + tran( P130, picfe ) + Space( 1 ) + tran( P131, picfe ) + Space( 4 ) + tran( P132, picf ) + Space( 3 ) + tran( P133, picf ) )
         ENDCASE
      CASE _OU == 'P'
         rl( PadC( 'PIT-5   DEKLARACJA NA ZALICZK&__E. MIESI&__E.CZN&__A. NA PODATEK DOCHODOWY', 80 ) )
         rl( PadC( '(04) za okres: ' + P4, 80 ) )
         rl( '(01) NIP: ' + P3 )
         rl( PadC( 'A. MIEJSCE SK&__L.ADANIA DEKLARACJI', 80 ) )
         rl( PadC( '===============================', 80 ) )
         rl( '(05) Urz&_a.d Skarbowy: ' + P5 )
         rl()
         rl( PadC( 'B. DANE PODATNIKA', 80 ) )
         rl( PadC( '=================', 80 ) )
         rl( 'B.1. DANE PERSONALNE' )
         rl( '--------------------' )
         rl( '(06) Nazwisko: ' + P7 + '  (07) Imie: ' + P8 )
         rl( '(08) Data ur.: ' + P12 )
         rl()
         rl( 'B.2. ADRES MIEJSCA ZAMIESZKANIA' )
         rl( '-------------------------------' )
         rl( '(09) Kraj: POLSKA   (10) Wojew&_o.dztwo: ' + P15 )
         rl( '(11) Powiat: ' + P15a + '   (12) Gmina: ' + P16 )
         rl( '(13) Ulica: ' + P17 + '   ' + P18 + '   ' + P19 )
         rl( '(16) Miejscowo&_s.&_c.: ' + P20 + ' (17) Kod: ' + P21 + ' (18) Poczta: ' + P22 )
         rl()
         rl( padc('C. DOCHODY PODLEGAJ&__A.CE OPODATKOWANIU', 80 ) )
         rl( padc('====================================', 80 ) )
         rl( '&__X.r&_o.d&_l.o przychod&_o.w           Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( 'Pozarol.dzia&_l.al.gospodar.' )
         rl( 'i wolne zawody           ' + tran( p27, dRPICe ) + ' ' + tran( p28, dRPICe ) + ' ' + tran( p29, dRPIC ) + ' ' + tran( p30, dRPIC ) )
         rl( 'Najem,podnajem,dzier&_z.awa ' + tran( p31, dRPICe ) + ' ' + tran( p32, dRPICe ) + ' ' + tran( p33, dRPIC ) + ' ' + tran( p34, dRPIC ) )
         rl( '                         -------------------------------------------------------' )
         rl( 'RAZEM                    ' + tran( p45, dRPICe ) + ' ' + tran( p46, dRPICe ) + ' ' + tran( p47, dRPIC ) + ' ' + tran( p48, dRPIC ) )
         rl()
         rl( PadC( 'D. DOCH&__O.D PO ODLICZENIU DOCHODU ZWOLNIONEGO I STRAT', 80 ) )
         rl( PadC( '===================================================', 80 ) )
         rl( '(31) Dochod zwolniony od podatku (art.21ust.1 pkt63a)...............' + tran( P50, dRPIC ) )
         rl( '(32) Straty z lat ubieglych oraz likwidacja skutkow powodzi.........' + tran( P51, dRPIC ) )
         rl( '(33) Dochod po odliczeniu dochodu zwolnionego i strat...............' + tran( P52, dRPIC ) )
         rl()
         rl( PadC( 'E. ODLICZENIA OD DOCHODU', 80 ) )
         rl( PadC( '========================', 80 ) )
         rl( 'E.1. ODLICZENIA OD DOCHODU - na podstawie art.26 ust.1 ustawy' )
         rl( '-------------------------------------------------------------' )
         rl( '1.Sk&_l.adki na ubezpieczenia spoleczne................................' + tran( P54, dRPIC ) )
         rl( '2.Odliczenia od dochodu na podstawie art.26 ust.1 pkt3-6 i 9-10 ust.' + tran( P55, dRPIC ) )
         rl()
         rl( 'E.2. ODLICZENIA OD DOCHODU WYDATK&__O.W MIESZKANIOWYCH' )
         rl( '--------------------------------------------------' )
         rl( '1.Wydatki poniesione w latach ubieglych,ktore nie znalazly pokrycia.' + tran( P64, dRPIC ) )
         rl( '2.Wydatki ponies.w roku podat..' + PadR( p63o, 30, '.' ) + '.......' + tran( P63, dRPIC ) )
         rl()
         rl( 'E.3. INNE ODLICZENIA NIE WYMIENIONE W INNYCH SEKCJACH E' )
         rl( '-------------------------------------------------------' )
         rl( '1. Inne odliczenia.............' + padr( p62o, 30, '.' ) + '.......' + tran( P62, dRPIC ) )
         rl()
         rl( PadC( 'F. ODLICZENIE Z TYTULU WYDATKOW INWESTYCYJNYCH', 80 ) )
         rl( PadC( '==============================================', 80 ) )
         rl( '1.Dodatkowa obnizka.................................................' + tran( P68, dRPIC ) )
         rl( '2.Wydatki inwestycyjne i premia inwestycyjna do odliczenia..........' + tran( P67, dRPIC ) )
         rl()
         rl( PadC( 'G. DOCHOD ZWOLNIONY OD PODATKU', 80 ) )
         rl( PadC( '==============================', 80 ) )
         rl( 'Na podstawie przepisow wykonawczych o SSE...........................' + tran( P76, dRPIC ) )
         rl()
         rl( PadC( 'H. DOCHOD PO ODLICZENIACH', 80 ) )
         rl( PadC( '=========================', 80 ) )
         rl( 'Dochod po odliczeniu ulg i zwolnien.................................' + tran( P77, dRPIC ) )
         rl()
         rl( PadC( 'I. USTALENIE PODSTAWY OBLICZENIA PODATKU', 80 ) )
         rl( PadC( '========================================', 80 ) )
         rl( '(45) Kwoty zwiekszajace podstawe opodatkowania/zmniejszajace strate.' + tran( P75, dRPIC ) )
         rl( '(46) Podstawa obliczenia podatku (po zaokragleniu do pelnego zlot..)' + tran( P777, dRPIC ) )
         rl()
         rl( PadC( 'J. OBLICZENIE NALE&__Z.NEGO PODATKU', 80 ) )
         rl( PadC( '===============================', 80 ) )
         rl( 'J.1. OBLICZENIE PODATKU' )
         rl( '-----------------------' )
         rl( '(47) Podatek od podstawy z pozycji 46 obliczony wg skali............' + tran( P79, dRPIC ) )
         rl()
         rl( 'J.2. ODLICZENIA OD PODATKU' )
         rl( '--------------------------' )
         rl( '(48) Suma sk&_l.adek na ubezp.zdrow.op&_l.aconych od poczatku roku........' + tran( p80, dRPIC ) )
         rl( '(49) Ulgi inwestycyjne przyznane przed 1.01.1992r...................' + tran( P81, dRPIC ) )
         rl( '(50) Ulgi za wyszkolenie uczni&_o.w....................................' + tran( P82, dRPIC ) )
         rl( '(52) Inne odlicz.od podatku....' + PadR( p83o, 30, '.' ) + '.......' + tran( P83, dRPIC ) )
         rl()
         rl( 'J.3. OBLICZENIE NALE&__Z.NEJ ZALICZKI' )
         rl( '---------------------------------' )
         rl( '(53) Podatek po odliczeniach od pocz&_a.tku roku.......................' + tran( P85, dRPIC ) )
         rl( '(54) Suma nale&_z.nych zaliczek za poprzednie miesi&_a.ce.................' + tran( P92, dRPIC ) )
         rl( '(55) Nalezna zaliczka za miesiac....................................' + tran( P93, dRPIC ) )
         rl( '(56) Suma nale&_z.nych zaliczek od pocz&_a.tku roku.......................' + tran( P94, dRPIC ) )
         rl()
         rl( 'J.4. OGRANICZENIE POBORU ZALICZEK' )
         rl( '---------------------------------' )
         rl( 'Ograniczenie wysokosci zaliczek albo zaniechanie poboru podatku' )
         rl( '(57) Numer i data decyzji......' + PadR( p884, 20, '.' ) + '....(58)...' + P886 )
         rl( '(59) Kwota wynikajaca z decyzji organu podatkowego..................' + tran( P885, dRPIC ) )
         rl( '(60) Kwota zrealizowana w poprzednich miesiacach....................' + tran( P887, dRPIC ) )
         rl( '(61) Kwota do zrealizowania w niniejszej deklaracji.................' + tran( P888, dRPIC ) )
         rl()
         rl( 'J.5. OBLICZENIE ZOBOWIAZANIA PRZYPADAJACEGO DO ZAPLATY' )
         rl( '------------------------------------------------------' )
         rl( '(62) Zaliczka po ograniczeniu.......................................' + tran( P889, dRPIC ) )
         rl( '(63) Nale&_z.ny zrycza&_l.towany podatek dochodowy z remanentu............' + tran( P88, dRPIC ) )
         rl( '(64) Kwota do zap&_l.aty...............................................' + tran( P89, dRPIC ) )
         rl( '(65) Kwota odsetek naliczonych od dnia zaliczenia do kosztow maj.trw' + tran( P90, dRPIC ) )
         rl()
         rl( PadC( 'K. POZAROLNICZA DZIA&__L.ALNO&__S.&__C. GOSPODARCZA', 80 ) )
         rl( PadC( '=======================================', 80 ) )
         rl( '(66)  NIP:' + dzial_g[ 1, 1 ] + '   (67)  REGON:' + dzial_g[ 1, 2 ] )
         rl( '(68)  ' + PadR( dzial_g[ 1, 3 ], 35 ) + '   (69)  ' + AllTrim( dzial_g[ 1, 4 ] ) )
         rl( 'Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( '     ' + Str( dzial_g[ 1, 5 ], 3 ) + Space( 16 ) + tran( dzial_g[ 1, 6 ], dRPICe ) + ' ' + tran( dzial_g[ 1, 7 ], dRPICe ) + ' ' + tran( dzial_g[ 1, 8 ], dRPIC ) + '  ' + tran( dzial_g[ 1, 9 ], dRPIC ) )
         rl()
         rl( '(75)  NIP:' + dzial_g[ 2, 1 ] + '   (76)  REGON:' + dzial_g[ 2, 2 ] )
         rl( '(77)  ' + PadR( dzial_g[ 2, 3 ], 35 ) + '   (78)  ' + AllTrim( dzial_g[ 2, 4 ] ) )
         rl( 'Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( '     ' + Str( dzial_g[ 2, 5 ], 3 ) + Space( 16 ) + tran( dzial_g[ 2, 6 ], dRPICe ) + ' ' + tran( dzial_g[ 2, 7 ], dRPICe ) + ' ' + tran( dzial_g[ 2, 8 ], dRPIC ) + '  ' + tran( dzial_g[ 2, 9 ], dRPIC ) )
         rl()
         rl( padc('M. NAJEM,PODNAJEM,DZIER&__Z.AWA itp', 80 ) )
         rl( padc('===============================', 80 ) )
         rl( '(116) ' + P120 + '   (117) ' + P121 )
         rl( 'Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( '     ' + Str( p122, 3 ) + Space( 16 ) + tran( p123, dRPICe ) + ' ' + tran( p124, dRPICe ) + ' ' + tran( p125, dRPIC ) + '  ' + tran( p126, dRPIC ) )
         rl()
         rl( '(123) ' + P127 + '   (124) ' + P128 )
         rl( 'Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( '     ' + Str( p129, 3 ) + Space( 16 ) + tran( p130, dRPICe ) + ' ' + tran( p131, dRPICe ) + ' ' + tran( p132, dRPIC ) + '  ' + tran( p133, dRPIC ) )
      CASE _OU == 'K'
         KPit_5Z()
      ENDCASE
   END
   SELECT spolka
   RETURN
