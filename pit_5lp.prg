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

PROCEDURE Pit_5LP( _G, _M, _STR, _OU )

   RAPORT := RAPTEMP
   dzial_g := Array( 4, 9 )
   FOR x_y := 1 TO 4
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
   PRIVATE P30, P35, P36, P37, P38, P39
   PRIVATE P40, P41, P42, P43, P44, P45, P46, P47, P48
   PRIVATE P51, P52, P54, P541
   PRIVATE P67, P68
   PRIVATE P76, P77, P78, P79
   PRIVATE P80, P81, P82, P83, P85, P86, P87, P88, P89
   PRIVATE P90, P91, P92, P93, P94, P95, P96, P97, P98, P99
   PRIVATE P100, P101, P102, P103, P104, P105, P106, P107, P108
   PRIVATE P21A, P29A, P37A, P44A, P97MMM, P887MMM, P887MMMa
   PRIVATE SPOL, POJ
   STORE 0 TO SPOL, POJ, P21A, P29A, P37A, P44A
   STORE 0 TO P39, P40, P41, P46, P47, P48, P51, P52
   STORE 0 TO P67, P68
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
      IF Dostep( 'TAB_DOCH' )
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
      IF Dostep('SUMA_MC')
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
      next
      P97MMM := 0
      P887MMM := 0
      P887MMMa := 0
      P887 := 0
   *  wait '..'+miesiac+'..'
      FOR xmc := 1 TO Val( miesiac )
         Pop_L( Str( xmc, 2 ) )
   *      wait xmc
   *      wait P97MMM
      NEXT
      STORE 0 TO SPOL,POJ,P21A,P29A,P37A,P44A
      STORE 0 TO P39,P40,P41,P46,P47,P48,P51,P52
      STORE 0 TO P61,p61a,P67,P68
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
      dzial_g[ 1, 1 ] := rozrzut( NIP )
      dzial_g[ 1, 2 ] := rozrzut( SubStr( nr_regon, 3, 9 ) )
      dzial_g[ 1, 3 ] := AllTrim( NAZWA )
      dzial_g[ 1, 4 ] := SubStr( AllTrim( miejsc ) + ' ' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + iif( Empty( nr_mieszk ), ' ', '/' + AllTrim( nr_mieszk ) ), 1, 34 )
      dzial_g[ 1, 6 ] := przychod
      dzial_g[ 1, 7 ] := koszty
      dzial_g[ 1, 8 ] := Max( 0, przychod - koszty )
      dzial_g[ 1, 9 ] := Abs( Min( 0, przychod - koszty ) )
      *****************************************************************************
      SELECT spolka
      zident := Str( RecNo(), 5 )
      SELECT dane_mc
      SEEK '+' + zident + miesiac

      Dane_Mc( '5L' )

      if LastKey() == K_ESC
         SELECT spolka
         BREAK
      ENDIF

      SEEK '+' + zident + iif( Empty( mc_rozp ), '', mc_rozp )
      STORE 0 TO zg_przych1, zg_przych2, zg_przych3, zg_przych4, zg_koszty1, zg_koszty2, zg_koszty3, zg_koszty4, zg_doch1, zg_doch2, zg_doch3, zg_doch4, zg_udzial1, zg_udzial2, zg_udzial3, zg_udzial4
      STORE .F. TO zg_spolka1, zg_spolka2, zg_spolka3, zg_spolka4
      STORE 0 TO zstraty, zpowodz, zskladki
      STORE 0 TO zodseodmaj
      STORE 0 TO zzaliczka, zpoprz, zalp
      STORE 0 TO zpit566, zpit5104, zpit5105
      STORE 0 TO zpit5agosk, zpit5agosp, zpit5agoss
      STORE 0 TO zrod1_doch, zrod1_stra
      STORE 0 TO zg21, zh385, sumzdro, sumzdro1
      DO WHILE del == '+' .AND. ident == zident .AND. mc <= miesiac
         zg_przych1 := zg_przych1 + g_przych1
         zg_przych2 := zg_przych2 + g_przych2
         zg_przych3 := zg_przych3 + g_przych3
         zg_przych4 := zg_przych4 + g_przych4
         zg_koszty1 := zg_koszty1 + g_koszty1
         zg_koszty2 := zg_koszty2 + g_koszty2
         zg_koszty3 := zg_koszty3 + g_koszty3
         zg_koszty4 := zg_koszty4 + g_koszty4
         zg_udzial1 := Int( ( Val( Left( g_udzial1, 2 ) ) / Val( Right( g_udzial1, 3 ) ) ) * 100 )
         zg_udzial2 := Int( ( Val( Left( g_udzial2, 2 ) ) / Val( Right( g_udzial2, 3 ) ) ) * 100 )
         zg_udzial3 := Int( ( Val( Left( g_udzial3, 2 ) ) / Val( Right( g_udzial3, 3 ) ) ) * 100 )
         zg_udzial4 := Int( ( Val( Left( g_udzial4, 2 ) ) / Val( Right( g_udzial4, 3 ) ) ) * 100 )

         zstraty := zstraty + straty
         zpowodz := zpowodz + powodz

         zskladki := zskladki + skladki + skladkiw

         zg21 := zg21 + g21
         zh385 := zh385 + h385
         sumzdro := sumzdro + zdrowie + zdrowiew
         zodseodmaj := odseodmaj

         zzaliczka := zzaliczka + zaliczka
         zpit5105 := pit5105
   *     zpit5105 := zpit5105+(pit5104*(pit5105/100))
         zpit5agosk := zpit5agosk + pit5agosk
         zpit5agosp := zpit5agosp + pit5agosp

         SKIP
      ENDDO
      zg_doch1 := Max( 0, zg_przych1 - zg_koszty1 )
      zg_doch2 := Max( 0, zg_przych2 - zg_koszty2 )
      zg_doch3 := Max( 0, zg_przych3 - zg_koszty3 )
      zg_doch4 := Max( 0, zg_przych4 - zg_koszty4 )
      zpit566 := Max( 0, zpit5agosp - zpit5agosk )

      zg_stra1 := Abs( Min( 0, zg_przych1 - zg_koszty1 ) )
      zg_stra2 := Abs( Min( 0, zg_przych2 - zg_koszty2 ) )
      zg_stra3 := Abs( Min( 0, zg_przych3 - zg_koszty3 ) )
      zg_stra4 := Abs( Min( 0, zg_przych4 - zg_koszty4 ) )
      zpit5agoss := Max( 0, zpit5agosk - zpit5agosp )

      zrod1_doch := zg_doch1 + zg_doch2 + zg_doch3 + zg_doch4 + dzial_g[ 1, 8 ] + zpit566
      zrod1_stra := zg_stra1 + zg_stra2 + zg_stra3 + zg_stra4 + dzial_g[ 1, 9 ] + zpit5agoss
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
      IF SPOL < 5
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
      IF SPOL < 5
         IF ! Empty( g_rodzaj3 )
            dzial_g[ spol, 1 ] := rozrzut( g_nip3 )
            dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon3, 3, 9 ) )
            dzial_g[ spol, 3 ] := g_rodzaj3
            dzial_g[ spol, 4 ] := g_miejsc3
            dzial_g[ spol, 5 ] := zg_udzial3
            dzial_g[ spol, 6 ] := zg_przych3
            dzial_g[ spol, 7 ] := zg_koszty3
            dzial_g[ spol, 8 ] := zg_doch3
            dzial_g[ spol, 9 ] := zg_stra3
            SPOL++
         ENDIF
      ENDIF
      IF SPOL < 5
         IF ! Empty( g_rodzaj4 )
            dzial_g[ spol, 1 ] := rozrzut( g_nip4 )
            dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon4, 3, 9 ) )
            dzial_g[ spol, 3 ] := g_rodzaj4
            dzial_g[ spol, 4 ] := g_miejsc4
            dzial_g[ spol, 5 ] := zg_udzial4
            dzial_g[ spol, 6 ] := zg_przych4
            dzial_g[ spol, 7 ] := zg_koszty4
            dzial_g[ spol, 8 ] := zg_doch4
            dzial_g[ spol, 9 ] := zg_stra4
            SPOL++
         ENDIF
      ENDIF
      SPOL := 0
      STORE Space( 32 ) TO p120, p127
      STORE Space( 35 ) TO p121,p128
      STORE 0 TO p122, p123, p124, p125, p126, p129, p130, p131, p132, p133
      *****************************************************************************
      p27 := zg_przych1 + zg_przych2 + zg_przych3 + zg_przych4 + zpit5agosp + dzial_g[ 1, 6 ]
      p28 := zg_koszty1 + zg_koszty2 + zg_koszty3 + zg_koszty4 + zpit5agosk + dzial_g[ 1, 7 ]

      p29 := Max( 0, p27 - p28 )
      p30 := Max( 0, p28 - p27 )
      *------------------------------------
      P45 := P27
      P46 := P28
      P47 := P29
      p48 := p30

      p51 := zstraty + Zpowodz
      P52 := ZSKLADKI

      IF P51 > p47
         P51 := P47
         P52 := 0
      ELSE
         IF P51 + P52 > p47
            P52 := p47 - P51
         ENDIF
      ENDIF

      P77 := P47 - ( P51 + P52 )

      p75 := zg21

      p777 := 0
      IF p47 > 0
         p777 := p77 + p75
      ELSE
         IF p47 == 0 .AND. ( p48 < p75 .OR. p48 == 0 )
            p777 := p75 - p48
         ENDIF
      ENDIF
      p777 := _round( p777, 0 )

      podst := P777
      *--------------- podatek dochodowy wg tabeli
      SELECT tab_doch
      GO TOP
      podatek := 0
      zm := podst
      podatek := zm * ( procent / 100 )
      select spolka
      podatek := Max( 0, podatek )
      *---------------
      P79 := podatek
      P80 := Min( p79, sumzdro )

      P85 := Max( 0, p79 - P80 )
      P92 := _round( P97MMM, 1 )
      p93 := _round( Max( 0, p85- p 92 ), 1 )
      p94 := p92 + p93

      p884 := h384
      p885 := zh385
      p886 := rozrzut( SubStr( DToS( h386 ), 7, 2 ) ) + ' ' + rozrzut( SubStr( DToS( h386 ), 5, 2 ) ) + ' ' + rozrzut( SubStr( DToS( h386 ), 1, 4 ) )
      P887MMMa := P887MMMa + P887MMM
      P887MMM := _round( Min( p93, p885 - P887MMMa ), 1 )
      P887 := P887MMMa
      P888 := P887MMM

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
      sele 100
      DO WHILE ! DostepEx( RAPORT )
      ENDDO
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
            rl( Space( _M ) + Space( 19 ) + P4 )
            FOR x := 1 TO 11
               rl()
            next
            rl( Space( _M ) + Space( 10 ) + PadC( AllTrim( P5 ), 60 ) )
            FOR x := 1 TO 5
               rl()
            NEXT
            rl( Space( _M ) + Space( 16 ) + PadC( AllTrim( P7 ), 30 ) )
            rl()
            rl( Space( _M ) + Space( 6 ) + PadC( AllTrim( P8 ), 32 ) + Space( 19 ) + p12 )
            FOR x := 1 TO 3
               rl()
            next
            rl( Space( _M ) + Space( 6 ) + PadC( 'POLSKA', 15 ) + Space( 1 ) + PadC( P15, 31 ) + Space( 1 ) + PadC( p15a, 24 ) )
            rl()
            rl( Space( _M ) + Space( 6 ) + PadC( P16, 18 ) + Space( 1 ) + PadC( P17, 36 ) + Space( 1 ) + PadC( p18, 8 ) + Space( 1 ) + PadC( p19, 8 ) )
            rl()
            rl( Space( _M ) + Space( 6 ) + PadC( AllTrim( P20 ), 25 ) + Space( 8 ) + P21 + Space( 4 ) + PadC( AllTrim( P22 ), 25 ) )
            FOR x := 1 TO 7
               rl()
            NEXT
            rl( Space( _M ) + Space( 23 ) + tran( P27, picfe ) + Space( 0 ) + tran( P28, picfe ) + Space( 2 ) + tran( P29, picf ) + Space( 2 ) + tran( P30, picf ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 62 ) + tran( P51, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 62 ) + tran( P52, picf1 ) )
         CASE _STR == 2
            FOR x := 1 TO _G
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
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P80, picf1 ) )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P85, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P92, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P93, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P94, picf1 ) )
            FOR x := 1 TO 5
               rl()
            NEXT
            rl( Space( _M ) + Space( 13 ) + PadC( p884, 20 ) + Space( 10 ) + p886 )
            FOR x := 1 TO 3
               rl()
            NEXT
            rl( Space( _M ) + Space( 61 ) + tran( P885, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P887, picf1 ) )
            rl()
            rl( Space( _M ) + Space( 61 ) + tran( P888, picf1 ) )
            FOR x := 1 to 2
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
         CASE _STR == 3
            FOR x := 1 TO _G
               rl()
            NEXT
            rl( Space( _M ) + Space( 12 ) + dzial_g[ 1, 1 ] + Space( 18 ) + dzial_g[ 1, 2 ] )
            rl()
            rl( Space( _M ) + Space( 4 ) + PadC( dzial_g[ 1, 3 ], 35 ) + Space( 2 ) + PadC( AllTrim( dzial_g[ 1, 4 ] ), 34 ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + tran( dzial_g[ 1, 5 ], '999' ) + Space( 2 ) + tran( dzial_g[ 1, 6 ], picfe ) + Space( 2 ) + tran( dzial_g[ 1, 7 ], picfe ) + Space( 3 ) + tran( dzial_g[ 1, 8 ], picf ) + Space( 4 ) + tran( dzial_g[ 1, 9 ], picf ) )
            rl()
            rl( Space( _M ) + space( 12 ) + dzial_g[ 2, 1 ] + Space( 18 ) + dzial_g[ 2, 2 ] )
            rl()
            rl( Space( _M ) + Space( 4 ) + PadC( dzial_g[ 2, 3 ], 35 ) + Space( 2 ) + PadC( AllTrim( dzial_g[ 2, 4 ] ), 34 ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + tran( dzial_g[ 2, 5 ], '999' ) + Space( 2 ) + tran( dzial_g[ 2, 6 ], picfe ) + Space( 2 ) + tran( dzial_g[ 2, 7 ], picfe ) + Space( 3 ) + tran( dzial_g[ 2, 8 ], picf ) + Space( 4 ) + tran( dzial_g[ 2, 9 ], picf ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + dzial_g[ 3, 1 ] + Space( 18 ) + dzial_g[ 3, 2 ] )
            rl()
            rl( Space( _M ) + Space( 4 ) + PadC( dzial_g[ 3, 3 ], 35 ) + Space( 2 ) + PadC( AllTrim( dzial_g[ 3, 4 ] ), 34 ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + tran( dzial_g[ 3, 5 ], '999' ) + Space( 2 ) + tran( dzial_g[ 3, 6 ], picfe ) + Space( 2 ) + tran( dzial_g[ 3, 7 ], picfe ) + Space( 3 ) + tran( dzial_g[ 3, 8 ], picf ) + Space( 4 ) + tran( dzial_g[ 3, 9 ], picf ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + dzial_g[ 4, 1 ] + Space( 18 ) + dzial_g[ 4, 2 ] )
            rl()
            rl( Space( _M ) + Space( 4 ) + PadC( dzial_g[ 4, 3 ], 35 ) + Space( 2 ) + PadC( AllTrim( dzial_g[ 4, 4 ] ), 34 ) )
            rl()
            rl( Space( _M ) + Space( 12 ) + tran( dzial_g[ 4, 5 ], '999' ) + Space( 2 ) + tran( dzial_g[ 4, 6 ], picfe ) + Space( 2 ) + tran( dzial_g[ 4, 7 ], picfe ) + Space( 3 ) + tran( dzial_g[ 4, 8 ], picf ) + Space( 4 ) + tran( dzial_g[ 4, 9 ], picf ) )
         ENDCASE
      CASE _OU == 'P'
         rl( PadC( 'PIT-5L   DEKLARACJA NA ZALICZK&__E. MIESI&__E.CZN&__A. NA PODATEK DOCHODOWY', 80 ) )
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
         rl( PadC( 'C. USTALENIE DOCHODU/STRATY', 80 ) )
         rl( PadC( '===========================', 80 ) )
         rl( '&__X.r&_o.d&_l.o przychod&_o.w           Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( 'Pozarol.dzialal.gospodar.' + tran( p27, dRPICe ) + ' ' + tran( p28, dRPICe ) + ' ' + tran( p29, dRPIC ) + ' ' + tran( p30, dRPIC ) )
         rl()
         rl( PadC( 'D. ODLICZENIE STRAT I SKLADEK NA UBEZPIECZENIA SPOLECZNE', 80 ) )
         rl( PadC( '========================================================', 80 ) )
         rl( '(23) Straty z lat ubieglych oraz likwidacja skutkow powodzi.........' + tran( P51, dRPIC ) )
         rl( '(24) Skladki na ubezpieczenia spoleczne.............................' + tran( P52, dRPIC ) )
         rl()
         rl( PadC( 'E. DOCHOD PO ODLICZENIACH', 80 ) )
         rl( PadC( '=========================', 80 ) )
         rl( '(25) Dochod po odliczeniach strat i skladek.........................' + tran( P77, dRPIC ) )
         rl()
         rl( PadC( 'F. USTALENIE PODSTAWY OBLICZENIA PODATKU', 80 ) )
         rl( PadC( '========================================', 80 ) )
         rl( '(26) Kwoty zwiekszajace podstawe opodatkowania/zmniejszajace strate.' + tran( P75, dRPIC ) )
         rl( '(27) Podstawa obliczenia podatku (po zaokragleniu do pelnego zlot..)' + tran( P777, dRPIC ) )
         rl()
         rl( PadC( 'G. OBLICZENIE NALE&__Z.NEGO PODATKU', 80 ) )
         rl( PadC( '===============================', 80 ) )
         rl( 'G.1. OBLICZENIE PODATKU' )
         rl( '-----------------------' )
         rl( '(28) Podatek od podstawy z pozycji 46 obliczony wg skali............' + tran( P79, dRPIC ) )
         rl()
         rl( 'G.2. ODLICZENIA OD PODATKU' )
         rl( '--------------------------' )
         rl( '(29) Suma sk&_l.adek na ubezp.zdrow.op&_l.aconych od poczatku roku........' + tran( p80, dRPIC ) )
         rl()
         rl( 'G.3. OBLICZENIE NALE&__Z.NEJ ZALICZKI' )
         rl( '---------------------------------' )
         rl( '(30) Podatek po odliczeniach od pocz&_a.tku roku.......................' + tran( P85, dRPIC ) )
         rl( '(31) Suma nale&_z.nych zaliczek za poprzednie miesi&_a.ce.................' + tran( P92, dRPIC ) )
         rl( '(32) Nalezna zaliczka za miesiac....................................' + tran( P93, dRPIC ) )
         rl( '(33) Suma nale&_z.nych zaliczek od pocz&_a.tku roku.......................' + tran( P94, dRPIC ) )
         rl()
         rl( 'G.4. OGRANICZENIE POBORU ZALICZEK' )
         rl( '---------------------------------' )
         rl( 'Ograniczenie wysokosci zaliczek albo zaniechanie poboru podatku' )
         rl( '(34) Numer i data decyzji......' + PadR( p884, 20, '.' ) + '....(35)...' + P886 )
         rl( '(36) Kwota wynikajaca z decyzji organu podatkowego..................' + tran( P885, dRPIC ) )
         rl( '(37) Kwota zrealizowana w poprzednich miesiacach....................' + tran( P887, dRPIC ) )
         rl( '(38) Kwota do zrealizowania w niniejszej deklaracji.................' + tran( P888, dRPIC ) )
         rl()
         rl( 'G.5. OBLICZENIE ZOBOWIAZANIA PRZYPADAJACEGO DO ZAPLATY' )
         rl( '------------------------------------------------------' )
         rl( '(39) Zaliczka po ograniczeniu.......................................' + tran( P889, dRPIC ) )
         rl( '(40) Nale&_z.ny zrycza&_l.towany podatek dochodowy z remanentu............' + tran( P88, dRPIC ) )
         rl( '(41) Kwota do zap&_l.aty...............................................' + tran( P89, dRPIC ) )
         rl( '(42) Kwota odsetek naliczonych od dnia zaliczenia do kosztow maj.trw' + tran( P90, dRPIC ) )
         rl()
         rl( PadC( 'H. POZAROLNICZA DZIA&__L.ALNO&__S.&__C. GOSPODARCZA', 80 ) )
         rl( PadC( '=======================================', 80 ) )
         rl( '(43)  NIP:' + dzial_g[ 1, 1 ] + '   (44)  REGON:' + dzial_g[ 1, 2 ] )
         rl( '(45)  ' + PadR( dzial_g[ 1, 3 ], 35 ) + '   (46)  ' + AllTrim( dzial_g[ 1, 4 ] ) )
         rl( 'Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( '     ' + Str( dzial_g[ 1, 5 ], 3 ) + Space( 16 ) + tran( dzial_g[ 1, 6 ], dRPICe ) + ' ' + tran( dzial_g[ 1, 7 ], dRPICe ) + ' ' + tran( dzial_g[ 1, 8 ], dRPIC ) + '  ' + tran( dzial_g[ 1, 9 ], dRPIC ) )
         rl()
         rl( '(52)  NIP:' + dzial_g[ 2, 1 ] + '   (53)  REGON:' + dzial_g[ 2, 2 ] )
         rl( '(54)  ' + PadR( dzial_g[ 2, 3 ], 35 ) + '   (55)  ' + AllTrim( dzial_g[ 2, 4 ] ) )
         rl( 'Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( '     ' + Str( dzial_g[ 2, 5 ], 3 ) + Space( 16 ) + tran( dzial_g[ 2, 6 ], dRPICe ) + ' ' + tran( dzial_g[ 2, 7 ], dRPICe ) + ' ' + tran( dzial_g[ 2, 8 ], dRPIC ) + '  ' + tran( dzial_g[ 2, 9 ], dRPIC ) )
         rl()
         rl( '(61)  NIP:' + dzial_g[ 3, 1 ] + '   (62)  REGON:' + dzial_g[ 3, 2 ] )
         rl( '(63)  ' + PadR( dzial_g[ 3, 3 ], 35 ) + '   (64)  ' + AllTrim( dzial_g[ 3, 4 ] ) )
         rl( 'Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( '     ' + Str( dzial_g[ 3, 5 ], 3 ) + Space( 16 ) + tran( dzial_g[ 3 ,6 ], dRPICe ) + ' ' + tran( dzial_g[ 3, 7 ], dRPICe ) + ' ' + tran( dzial_g[ 3, 8 ], dRPIC ) + '  ' + tran( dzial_g[ 3, 9 ], dRPIC ) )
         rl()
         rl( '(70)  NIP:' + dzial_g[ 4, 1 ] + '   (71)  REGON:' + dzial_g[ 4, 2 ] )
         rl( '(72)  ' + PadR( dzial_g[ 4, 3 ], 35 ) + '   (73)  ' + AllTrim( dzial_g[ 4, 4 ] ) )
         rl( 'Udzia&_l. w %                  Przych&_o.d       Koszty        Doch&_o.d        Strata' )
         rl( '     ' + Str( dzial_g[ 4, 5 ], 3 ) + Space( 16 ) + tran( dzial_g[ 4, 6 ], dRPICe ) + ' ' + tran( dzial_g[ 4, 7 ], dRPICe ) + ' ' + tran( dzial_g[ 4, 8 ], dRPIC ) + '  ' + tran( dzial_g[ 4, 9 ], dRPIC ) )
         rl()
      CASE _OU == 'K'
         KPit_5L()
      ENDCASE
   END
   SELECT spolka
   RETURN
