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

#include "Inkey.ch"

PROCEDURE P_Dochod( _OUT )

   LOCAL dDataNa

   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
   *PRIVATE ObiczKwWl := 'S'
   PRIVATE udz1, udz2, udz3, udz4, udz5, udz6, udz7, udz8, udz9, udz10, udz11, udz12

   PRIVATE a_pz_m, a_remp, a_remk, a_rem, a_wyr_tow, a_uslugi, a_zakup, a_uboczne
   PRIVATE a_wynagr_g, a_wydatki, a_przywsp, a_koszwsp, a_pk1, a_pk2, a_pk3, a_pk4

   PRIVATE dzial_g

   PRIVATE p120, p127, p121, p128, p122, p123, p124, p125, p126, p129, p130, p131, p132, p133

   PRIVATE a_przygos, a_przynaj, a_koszgos, a_kosznaj, a_rentalim, a_straty, a_straty_n
   PRIVATE a_powodz, a_wydatkim, a_wydatkid, a_sumemer, a_budowa, a_ubieginw, a_dochzwol
   PRIVATE a_SSE, a_g21, a_h385, a_sumzdro, a_zaliczki, a_aaa, a_bbb, a_inneodpo
   PRIVATE a_odseodma, a_pit5105, a_pit5gosk, a_pit5najk, a_pit5gosp, a_pit5najp
   PRIVATE a_zalipod, a_zalipodp, a_dochodzdr

   PRIVATE a_dochgos, a_dochnaj, a_stragos, a_stranaj, a_pit566, a_pit567
   PRIVATE a_preman, a_pit5goss, a_pit5najs, a_gosprzy, a_goskosz, a_najprzy
   PRIVATE a_najkosz, a_gosdoch, a_gosstra, a_najdoch, a_najstra, a_pro1doch
   PRIVATE a_pro2doch, a_pro1stra, a_pro2stra, a_pk5, a_p50, a_p51, a_p51a
   PRIVATE a_p51b, a_pkk7, a_pk6, a_pk75, a_pk7, a_ppodst, a_ppodstn, a_pk8, a_pk9, a_pk12
   PRIVATE a_pk13, a_sumzdro1, a_P97MMM, a_P887MMMa, a_P887MMM, a_P885, a_P887
   PRIVATE a_P888, a_P889, a_wartprze


   @ 1, 47 SAY Space( 10 )
   *############################### OTWARCIE BAZ ###############################
   SELECT 7
   IF Dostep( 'URZEDY' )
      SetInd( 'URZEDY' )
   ELSE
      BREAK
   ENDIF

   SELECT 6
   IF Dostep('FIRMA')
      GO Val( ident_fir )
   ELSE
      RETURN
   ENDIF
   zPITOKRES := iif( PITOKRES == ' ', 'M', PITOKRES )
   IF zPITOKRES == 'K'
      okrpod := 3
      DO CASE
      CASE Val( miesiac ) >= 1 .AND. Val( miesiac ) <= 3
         pitKW := 1
      CASE Val( miesiac ) >= 4 .AND. Val( miesiac ) <= 6
         pitKW := 2
      CASE Val( miesiac ) >= 7 .AND. Val( miesiac ) <= 9
         pitKW := 3
      CASE Val( miesiac ) >= 10 .AND. Val( miesiac ) <= 12
         pitKW := 4
      ENDCASE
      P4 := Str( pitKW ) + '.' + param_rok
   ELSE
      okrpod := 2
      P4 := miesiac + '.' + param_rok
   ENDIF

   SELECT 5
   IF Dostep( 'OPER' )
      SetInd( 'OPER' )
      SET ORDER TO 3
   ELSE
      Close_()
      RETURN
   ENDIF

   SELECT 4
   IF Dostep( 'TAB_DOCH' )
      SET INDEX TO tab_doch
   ELSE
      Close_()
      RETURN
   ENDIF
   IF RecCount() == 0
      Kom( 3, '*u', ' Brak informacji w tabeli podatku dochodowego ' )
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
      Kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ' )
      Close_()
      RETURN
   ENDIF

   *--------------------------------------
   SKIP
   spolka := ( del == '+' .AND. firma == ident_fir )
   SKIP -1

   @ 3, 42 CLEAR TO 22, 79

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
   _proc := 'linia12()'
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
      _row := Wybor( _row )
      kl := LastKey()
      DO CASE
      *################################## ZESTAW_ #################################
      CASE kl == 13 .OR. kl == 1006
         SELECT spolka
         zident := Str( RecNo(), 5 )

         P3 := StrTran( NIP, '-', '' )
         P3 := rozrzut( SubStr( P3, 1, 3 ) ) + ' ' + rozrzut( SubStr( P3, 4, 3 ) ) + ' ' + rozrzut( SubStr( P3, 7, 2 ) ) + ' ' + rozrzut( SubStr( P3, 9, 2 ) )
         P6 := PESEL
         P7 := SubStr( NAZ_IMIE, 1, At( ' ', NAZ_IMIE ) )
         subim := SubStr( NAZ_IMIE, At( ' ', NAZ_IMIE ) + 1 )
         P8 := iif( At( ' ', subim ) == 0, subim, SubStr( subim, 1, At( ' ', subim ) ) )
         P9 := iif( At( ' ', subim ) + 1 == 1, '', SubStr( subim, At( ' ', subim ) + 1 ) )
         P10 := IMIE_O
         P11 := IMIE_M
         SET DATE germ
         P12 := DToC( DATA_UR )
         SET DATE ANSI
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

         *ObiczKwWl := spolka->oblkwwol

         SELECT URZEDY
         IF firma->skarb > 0
            GO spolka->skarb
            P5 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
         ELSE
            P5 := Space( 60 )
         ENDIF

         P_Dochod_Licz( .T. )

         SELECT dane_mc

         *tmp2miesiac=miesiac
         *miesiac=tmpmiesiac

         SEEK '+' + zident + miesiac

         liczdoch5 := .F.

         IF spolka->sposob == 'L'
            liczdoch5 := Dane_Mc( '5L' )
         ELSE
            liczdoch5 := Dane_Mc( '5' )
         *   do dane_mc with '5'
         ENDIF

         IF liczdoch5 == .F.
            Close_()
            RETURN
         ENDIF

         P_Dochod_Licz()

         SAVE SCREEN TO scr2
         nr_rec := RecNo()
         otwarte_ := Select()
         *wait otwarte_
         DO CASE
         CASE _OUT == 'I'
            infodoch()
         CASE _OUT == 'Z'
            zezpit_5()
         otherwise
            rpit_5()
         ENDCASE
         Select( otwarte_ )
         GO nr_rec
         RESTORE SCREEN FROM scr2
         _disp := .F.

      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY Space( 10 )
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
               center( j, p[i] )
               j := j - 1
            ENDIF
            i := i-1
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

   RETURN

*################################## FUNKCJE #################################
FUNCTION linia12()

   RETURN ' ' + dos_c( naz_imie ) + ' '

*############################################################################
PROCEDURE P_Dochod_Licz( lDoZUS )

   hb_default( @lDoZUS, .F. )

         *miesiac=tmp2miesiac
         SELECT spolka

         ************udzialy w miesiacach**********
         zm := '  0/1  '
         FOR i := 1 TO 12
            zm1 := 'udzial' + LTrim( Str( i ) )
            IF '   /   ' # &zm1
               zm := &zm1
            endif
            zm2 := 'udz' + LTrim( Str( i ) )
            &zm2 := zm
         NEXT

         *********************************************************************
         * dane z ksiegi i pobranie udzialow
         *********************************************************************
         a_pz_m     := Array( 3, 12 )    //1-miesiecznie,2-narastajaco,3-kwartalnie
         a_remp     := Array( 2, 12 )    //1-rem-p na firme,2-rem-p na wlasciciela
         a_remk     := Array( 2, 12 )    //1-rem-k na firme,2-rem-k na wlasciciela
         a_rem      := Array( 3, 12 )     //roznica remamanentowa przypadajaca w danym miesiacu
         a_wyr_tow  := Array( 3, 12 )
         a_uslugi   := Array( 3, 12 )
         a_zakup    := Array( 3, 12 )
         a_uboczne  := Array( 3, 12 )
         a_wynagr_g := Array( 3, 12 )
         a_wydatki  := Array( 3, 12 )
         a_przywsp  := Array( 3, 12 )
         a_koszwsp  := Array( 3, 12 )
         a_pk1      := Array( 3, 12 )
         a_pk2      := Array( 3, 12 )
         a_pk3      := Array( 3, 12 )
         a_pk4      := Array( 3, 12 )
         FOR xxx := 1 TO 12
            FOR yyy := 1 TO 3
               a_pz_m[ yyy, xxx ] := 0
               a_wyr_tow[ yyy, xxx ] := 0
               a_uslugi[ yyy, xxx ] := 0
               a_zakup[ yyy, xxx ] := 0
               a_uboczne[ yyy, xxx ] := 0
               a_wynagr_g[ yyy, xxx ] := 0
               a_wydatki[ yyy, xxx ] := 0
               a_przywsp[ yyy, xxx ] := 0
               a_koszwsp[ yyy, xxx ] := 0
               a_pk1[ yyy, xxx ] := 0
               a_pk2[ yyy, xxx ] := 0
               a_pk3[ yyy, xxx ] := 0
               a_pk4[ yyy, xxx ] := 0
               a_rem[ yyy, xxx ] := 0
            NEXT
            FOR yyy := 1 TO 2
               a_remp[ yyy, xxx ] := 0
               a_remk[ yyy, xxx ] := 0
            NEXT
         NEXT
         *---Podliczenie ksiegi (OPER.dbf)------
         dzial_g := Array( 6, 9 )
         FOR x_y := 1 TO 6
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
         *najem do druku
         STORE Space( 32 ) TO p120, p127
         STORE Space( 35 ) TO p121, p128
         STORE 0 TO p122, p123, p124, p125, p126, p129, p130, p131, p132, p133

         SELECT oper
         SEEK '+' + ident_fir
         last_remp := 0
         last_remk := 0
         last_rem := 0
         licz_remk := 0
         IF Found()
            FOR i := 1 TO 12
               SEEK '+' + ident_fir + Str( i, 2 )
               zm := 'udz' + LTrim( Str( i ) )
               IF Found()
                  DO WHILE del == '+' .AND. firma == ident_fir .AND. mc == Str( i, 2 ) .AND. ! Eof()
                     IF substr(numer,1,1)<>chr(1) .and. substr(numer,1,1)<>chr(254)
                        a_wyr_tow[ 1, i ] := a_wyr_tow[ 1, i ] + wyr_tow
                        a_uslugi[ 1, i ]  := a_uslugi[ 1, i ] + iif( lDoZUS .AND. wartzus <> 0, wartzus, uslugi )
                        a_zakup[ 1, i ]   := a_zakup[ 1, i ] + zakup
                        a_uboczne[ 1, i ] := a_uboczne[ 1, i ] + uboczne
                        a_wynagr_g[ 1, i ] := a_wynagr_g[ 1, i ] + wynagr_g
                        a_wydatki[ 1, i ] := a_wydatki[ 1, i ] + wydatki
                     ENDIF
                     SKIP
                  ENDDO
               ENDIF
               SEEK '+' + ident_fir + Str( i, 2 ) + Chr( 1 )
               IF Found()
                  *if substr(numer,1,1)=chr(1)
                  a_remp[ 1, i ] := ZAKUP
                  a_remp[ 2, i ] := ZAKUP * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
                  *endif
                  last_remp := ZAKUP * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
               ELSE
                  a_remp[ 2, i ] := last_remp
               ENDIF
               SEEK '+' + ident_fir + Str( i, 2 ) + Chr( 254 )
               IF Found()
                  IF i == 12 .AND. _DEKLINW_ == 'N'
                     a_remk[ 2, i ] := last_remk
                  ELSE
                     *if substr(numer,1,1)=chr(254)
                     a_remk[ 1, i ] := ZAKUP
                     a_remk[ 2, i ] := ZAKUP * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
                     *endif
                     last_remk := ZAKUP * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) )
                     a_rem[ 1, i ] := last_remk - last_remp
                     licz_remk++
                  ENDIF
               ELSE
                  a_remk[ 2, i ] := last_remk
               ENDIF

               *if licz_remk>0
               *endif
               *wait str(a_remk[2,i],10,2)+' '+str(last_remp,10,2)
               a_przywsp[ 1, i ] := _round( ( a_WYR_TOW[ 1, i ] + a_USLUGI[ 1, i ] ) * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) ), 2 )
               a_koszwsp[1,i] := _round( ( a_zakup[ 1, i ] + a_uboczne[ 1, i ] + a_wynagr_g[ 1, i ] + a_wydatki[ 1, i ] ) * Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) ), 2 )
               *a_pk1[yyy,xxx]=0
               *a_pk2[yyy,xxx]=0
               a_pk3[ 1, i ] := Max( 0, a_przywsp[ 1, i ] - a_koszwsp[ 1, i ] )
               a_pk4[ 1, i ] := Abs( Min( 0, a_przywsp[ 1, i ] - a_koszwsp[ 1, i ] ) )

               dzial_g[ 1, 5 ] := _round( Val( Left( &zm, 3 ) ) / Val( Right( &zm, 3 ) ), 4 ) * 100

               SKIP
            NEXT
         ENDIF
         SELECT firma
         dzial_g[ 1, 1 ] := rozrzut( NIP )
         dzial_g[ 1, 2 ] := rozrzut( SubStr( nr_regon, 3, 9 ) )
         dzial_g[ 1, 3 ] := AllTrim( NAZWA )
         dzial_g[ 1, 4 ] := SubStr( AllTrim( miejsc ) + ' ' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + iif( Empty( nr_mieszk ), ' ', '/' + AllTrim( nr_mieszk ) ), 1, 34 )

         *********************************************************************
         * dane miesieczne podatnika
         *********************************************************************
         *   store 0 to pdochody,pzwolniony
         *   store 0 to prop1_doch,prop1_stra,prop2_doch,prop2_stra
         *   store 0 to prop3_doch,prop3_stra,prop4_doch,prop4_stra
         *   store 0 to prop5_doch,prop5_stra
         *   store 0 to psumzdro1

         a_przygos  := Array( 5, 3, 12 )    //nr dzialalnosci, okres(0-miesiecznie,1-narastajaco,2-kwartalnie), miesiace
         a_przynaj  := Array( 2, 3, 12 )    //nr najmu, okres(0-miesiecznie,1-narastajaco,2-kwartalnie), miesiace
         a_koszgos  := Array( 5, 3, 12 )    //nr dzialalnosci, okres(0-miesiecznie,1-narastajaco,2-kwartalnie), miesiace
         a_kosznaj  := Array( 2, 3, 12 )    //nr najmu, okres(0-miesiecznie,1-narastajaco,2-kwartalnie), miesiace

         a_rentalim := Array( 3, 12 )
         a_straty   := Array( 3, 12 )
         a_straty_n := Array( 3, 12 )
         a_powodz   := Array( 3, 12 )
         a_wydatkim := Array( 3, 12 )
         a_wydatkid := Array( 3, 12 )
         a_sumemer  := Array( 3, 12 )
         a_budowa   := Array( 3, 12 )
         a_ubieginw := Array( 3, 12 )
         a_dochzwol := Array( 3, 12 )
         a_SSE      := Array( 3, 12 )
         a_g21      := Array( 3, 12 )
         a_h385     := Array( 3, 12 )
         a_sumzdro  := Array( 3, 12 )
         a_zaliczki := Array( 3, 12 )
         a_aaa      := Array( 3, 12 )
         a_bbb      := Array( 3, 12 )
         a_inneodpo := Array( 3, 12 )
         a_odseodma := Array( 3, 12 )
         a_pit5105  := Array( 3, 12 )
         a_pit5gosk := Array( 3, 12 )
         a_pit5najk := Array( 3, 12 )
         a_pit5gosp := Array( 3, 12 )
         a_pit5najp := Array( 3, 12 )
         a_zalipod  := Array( 3, 12 )
         a_zalipodp := Array( 3, 12 )
         a_dochodzdr:= Array( 3, 12 )

         FOR xxx := 1 TO 12
            FOR yyy := 1 TO 3
               a_rentalim[ yyy, xxx ] := 0
               a_straty[ yyy, xxx ] := 0
               a_straty_n[ yyy, xxx ] := 0
               a_powodz[ yyy, xxx ] := 0
               a_wydatkim[ yyy, xxx ] := 0
               a_wydatkid[ yyy, xxx ] := 0
               a_sumemer[ yyy, xxx ] := 0
               a_budowa[ yyy, xxx ] := 0
               a_ubieginw[ yyy, xxx ] := 0
               a_dochzwol[ yyy, xxx ] := 0
               a_SSE[ yyy, xxx ] := 0
               a_g21[ yyy, xxx ] := 0
               a_h385[ yyy, xxx ] := 0
               a_sumzdro[ yyy, xxx ] := 0
               a_zaliczki[ yyy, xxx ] := 0
               a_aaa[ yyy, xxx ] := 0
               a_bbb[ yyy, xxx ] := 0
               a_inneodpo[ yyy, xxx ] := 0
               a_odseodma[ yyy, xxx ] := 0
               a_pit5105[ yyy, xxx ] := 0
               a_pit5gosk[ yyy, xxx ] := 0
               a_pit5najk[ yyy, xxx ] := 0
               a_pit5gosp[ yyy, xxx ] := 0
               a_pit5najp[ yyy, xxx ] := 0
               a_zalipod[ yyy, xxx ] := 0
               a_zalipodp[ yyy, xxx ] := 0
               a_dochodzdr[ yyy, xxx ] := 0
               FOR zzz := 1 TO 2
                  a_przynaj[ zzz, yyy, xxx ] := 0
                  a_kosznaj[ zzz, yyy, xxx ] := 0
               NEXT
               FOR zzz := 1 TO 5
                  a_przygos[ zzz, yyy, xxx ] := 0
                  a_koszgos[ zzz, yyy, xxx ] := 0
               NEXT
            NEXT
         NEXT
         *---Podliczenie ksiegi (DANE_MC.dbf)------
         SELECT spolka
         zident := Str( RecNo(), 5 )

         SELECT dane_mc
         SEEK '+' + zident

         IF Found()
            FOR i := 1 TO 12
               SEEK '+' + zident + Str( i, 2 )
               IF Found()
                  DO WHILE del == '+' .AND. ident == zident .AND. mc == str( i, 2 ) .AND. ! Eof()
                     a_przygos[ 1, 1, i ] := a_przygos[ 1, 1, i ] + g_przych1
                     a_przygos[ 2, 1, i ] := a_przygos[ 2, 1, i ] + g_przych2
                     a_przygos[ 3, 1, i ] := a_przygos[ 3, 1, i ] + g_przych3
                     a_przygos[ 4, 1, i ] := a_przygos[ 4, 1, i ] + g_przych4
                     a_przygos[ 5, 1, i ] := a_przygos[ 5, 1, i ] + g_przych5
                     a_koszgos[ 1, 1, i ] := a_koszgos[ 1, 1, i ] + g_koszty1
                     a_koszgos[ 2, 1, i ] := a_koszgos[ 2, 1, i ] + g_koszty2
                     a_koszgos[ 3, 1, i ] := a_koszgos[ 3, 1, i ] + g_koszty3
                     a_koszgos[ 4, 1, i ] := a_koszgos[ 4, 1, i ] + g_koszty4
                     a_koszgos[ 5, 1, i ] := a_koszgos[ 5, 1, i ] + g_koszty5
                     dzial_g[ 2, 5 ] := _round( Val( Left( g_udzial1, 2 ) ) / Val( Right( g_udzial1, 3 ) ), 4 ) * 100
                     dzial_g[ 3, 5 ] := _round( Val( Left( g_udzial2, 2 ) ) / Val( Right( g_udzial2, 3 ) ), 4 ) * 100
                     dzial_g[ 4, 5 ] := _round( Val( Left( g_udzial3, 2 ) ) / Val( Right( g_udzial3, 3 ) ), 4 ) * 100
                     dzial_g[ 5, 5 ] := _round( Val( Left( g_udzial4, 2 ) ) / Val( Right( g_udzial4, 3 ) ), 4 ) * 100
                     dzial_g[ 6, 5 ] := _round( Val( Left( g_udzial5, 2 ) ) / Val( Right( g_udzial5, 3 ) ), 4 ) * 100
                     p122 := _round( Val( Left( n_udzial1, 2 ) ) / Val( Right( n_udzial1, 3 ) ), 4 ) * 100
                     p129 := _round( Val( Left( n_udzial1, 2 ) ) / Val( Right( n_udzial1, 3 ) ), 4 ) * 100
                     a_przynaj[ 1, 1, i ] := a_przynaj[ 1, 1, i ] + n_przych1
                     a_przynaj[ 2, 1, i ] := a_przynaj[ 2, 1, i ] + n_przych2
                     a_kosznaj[ 1, 1, i ] := a_kosznaj[ 1, 1, i ] + n_koszty1
                     a_kosznaj[ 2, 1, i ] := a_kosznaj[ 2, 1, i ] + n_koszty2
                     a_rentalim[ 1, i ]  := a_rentalim[ 1, i ] + rentalim
                     a_straty[ 1, i ]    := a_straty[ 1, i ] + straty
                     a_straty_n[ 1, i ]  := a_straty_n[ 1, i ] + straty_n
                     a_powodz[ 1, i ]    := a_powodz[ 1, i ] + powodz
                     IF spolka->sposob == 'L'
                        a_wydatkim[ 1, i ]  := a_wydatkim[ 1, i ] + skladki + skladkiw
                        a_wydatkid[ 1, i ]  := a_wydatkid[ 1, i ] + skladki + skladkiw
                     ELSE
                        a_wydatkim[ 1, i ]  := a_wydatkim[ 1, i ] + skladki + skladkiw + organy + zwrot_ren + zwrot_swi + rehab + kopaliny + darowiz + wynagro + inne + budowa + ubieginw
                        a_wydatkid[ 1, i ]  := a_wydatkid[ 1, i ] + organy + zwrot_ren + zwrot_swi + rehab + kopaliny + darowiz + wynagro + inne
                     ENDIF
                     a_sumemer[ 1, i ]   := a_sumemer[ 1, i ] + skladki + skladkiw
                     a_budowa[ 1, i ]    := a_budowa[ 1, i ] + budowa
                     a_ubieginw[ 1, i ]  := a_ubieginw[ 1, i ] + ubieginw
                     a_dochzwol[ 1, i ]  := a_dochzwol[ 1, i ] + dochzwol
                     a_SSE[ 1, i ]       := a_SSE[ 1, i ] + dochzwol
                     a_g21[ 1, i ]       := a_g21[ 1, i ] + g21
                     a_h385[ 1, i ]      := a_h385[ 1, i ] + h385
                     a_sumzdro[ 1, i ]   := a_sumzdro[ 1, i ] + zdrowie + zdrowiew
                     a_aaa[ 1, i ]       := a_aaa[ 1, i ] + aaa
                     a_bbb[ 1, i ]       := a_bbb[ 1, i ] + bbb
                     a_inneodpo[ 1, i ]  := a_inneodpo[ 1, i ] + inneodpod
                     a_zaliczki[ 1, i ]  := a_zaliczki[ 1, i ] + zaliczka
                     a_pit5gosk[ 1, i ]  := a_pit5gosk[ 1, i ] + pit5agosk
                     a_pit5najk[ 1, i ]  := a_pit5najk[ 1, i ] + pit5anajk
                     a_pit5gosp[ 1, i ]  := a_pit5gosp[ 1, i ] + pit5agosp
                     a_pit5najp[ 1, i ]  := a_pit5najp[ 1, i ] + pit5anajp
                     a_zalipod[ 1, i ]   := a_zalipod[ 1, i ] + zaliczka
                     a_zalipodp[ 1, i ]  := a_zalipodp[ 1, i ] + zaliczkap
                     a_dochodzdr[ 1, i ] := a_dochodzdr[ 1, i ] + dochodzdr

                     a_pit5105[ 1, i ] := pit5105
                     a_odseodma[ 1, i ] := odseodmaj
                     skip
                  ENDDO
               ENDIF
            NEXT
         ENDIF

         *********************************************************************
         * wyliczenia w petlach
         *********************************************************************
         a_dochgos  := Array( 5, 3, 12 )    //nr dzialalnosci, okres(0-miesiecznie,1-narastajaco,2-kwartalnie), miesiace
         a_dochnaj  := Array( 2, 3, 12 )    //nr najmu, okres(0-miesiecznie,1-narastajaco,2-kwartalnie), miesiace
         a_stragos  := Array( 5, 3, 12 )    //nr dzialalnosci, okres(0-miesiecznie,1-narastajaco,2-kwartalnie), miesiace
         a_stranaj  := Array( 2, 3, 12 )    //nr najmu, okres(0-miesiecznie,1-narastajaco,2-kwartalnie), miesiace

         a_pit566   := Array( 3, 12 )
         a_pit567   := Array( 3, 12 )
         a_preman   := Array( 3, 12 )
         a_pit5goss := Array( 3, 12 )
         a_pit5najs := Array( 3, 12 )
         a_gosprzy  := Array( 3, 12 )
         a_goskosz  := Array( 3, 12 )
         a_najprzy  := Array( 3, 12 )
         a_najkosz  := Array( 3, 12 )
         a_gosdoch  := Array( 3, 12 )
         a_gosstra  := Array( 3, 12 )
         a_najdoch  := Array( 3, 12 )
         a_najstra  := Array( 3, 12 )
         a_pro1doch := Array( 3, 12 )
         a_pro2doch := Array( 3, 12 )
         a_pro1stra := Array( 3, 12 )
         a_pro2stra := Array( 3, 12 )
         a_pk5      := Array( 3, 12 )
         a_p50      := Array( 3, 12 )
         a_p51      := Array( 3, 12 )
         a_p51a     := Array( 3, 12 )
         a_p51b     := Array( 3, 12 )
         a_pkk7     := Array( 3, 12 )
         a_pk6      := Array( 3, 12 )
         a_pk75     := Array( 3, 12 )
         a_pk7      := Array( 3, 12 )
         a_ppodst   := Array( 3, 12 )
         a_ppodstn  := Array( 3, 12 )
         a_pk8      := Array( 3, 12 )
         a_pk9      := Array( 3, 12 )
         a_pk12     := Array( 3, 12 )
         a_pk13     := Array( 3, 12 )
         a_sumzdro1 := Array( 3, 12 )
         a_P97MMM   := Array( 3, 12 )
         a_P887MMMa := Array( 3, 12 )
         a_P887MMM  := Array( 3, 12 )
         a_P885     := Array( 3, 12 )
         a_P887     := Array( 3, 12 )
         a_P888     := Array( 3, 12 )
         a_P889     := Array( 3, 12 )
         a_wartprze := Array( 3, 12 )
         FOR xxx := 1 TO 12
            FOR yyy := 1 TO 3
               a_pit566[ yyy, xxx ] := 0
               a_pit567[ yyy, xxx ] := 0
               a_preman[ yyy, xxx ] := 0
               a_pit5goss[ yyy, xxx ] := 0
               a_pit5najs[ yyy, xxx ] := 0
               a_gosprzy[ yyy, xxx ] := 0
               a_goskosz[ yyy, xxx ] := 0
               a_najprzy[ yyy, xxx ] := 0
               a_najkosz[ yyy, xxx ] := 0
               a_gosdoch[ yyy, xxx ] := 0
               a_gosstra[ yyy, xxx ] := 0
               a_najdoch[ yyy, xxx ] := 0
               a_najstra[ yyy, xxx ] := 0
               a_pro1doch[ yyy, xxx ] := 0
               a_pro2doch[ yyy, xxx ] := 0
               a_pro1stra[ yyy, xxx ] := 0
               a_pro2stra[ yyy, xxx ] := 0
               a_pk5[ yyy, xxx ] := 0
               a_p50[ yyy, xxx ] := 0
               a_p51[ yyy, xxx ] := 0
               a_p51a[ yyy, xxx ] := 0
               a_p51b[ yyy, xxx ] := 0
               a_pkk7[ yyy, xxx ] := 0
               a_pk6[ yyy, xxx ] := 0
               a_pk75[ yyy, xxx ] := 0
               a_pk7[ yyy, xxx ] := 0
               a_ppodst[ yyy, xxx ] := 0
               a_ppodstn[ yyy, xxx ] := 0
               a_pk8[ yyy, xxx ] := 0
               a_pk9[ yyy, xxx ] := 0
               a_pk12[ yyy, xxx ] := 0
               a_pk13[ yyy, xxx ] := 0
               a_sumzdro1[ yyy, xxx ] := 0
               a_P97MMM[ yyy, xxx ] := 0
               a_P887MMMa[ yyy, xxx ] := 0
               a_P887MMM[ yyy, xxx ] := 0
               a_P885[ yyy, xxx ] := 0
               a_P887[ yyy, xxx ] := 0
               a_P888[ yyy, xxx ] := 0
               a_P889[ yyy, xxx ] := 0
               a_wartprze[ yyy, xxx ] := 0
               FOR zzz := 1 TO 2
                  a_dochnaj[ zzz, yyy, xxx ] := 0
                  a_stranaj[ zzz, yyy, xxx ] := 0
               NEXT
               FOR zzz := 1 TO 5
                  a_dochgos[ zzz, yyy, xxx ] := 0
                  a_stragos[ zzz, yyy, xxx ] := 0
               NEXT
            NEXT
         NEXT
         FOR xxx := 1 TO 12
            a_preman[ 1, xxx ] := a_pit5105[ 1, xxx ]
            a_dochgos[ 1, 1, xxx ] := Max( 0, a_przygos[ 1, 1, xxx ] - a_koszgos[ 1, 1, xxx ] )
            a_dochgos[ 2, 1, xxx ] := Max( 0, a_przygos[ 2, 1, xxx ] - a_koszgos[ 2, 1, xxx ] )
            a_dochgos[ 3, 1, xxx ] := Max( 0, a_przygos[ 3, 1, xxx ] - a_koszgos[ 3, 1, xxx ] )
            a_dochgos[ 4, 1, xxx ] := Max( 0, a_przygos[ 4, 1, xxx ] - a_koszgos[ 4, 1, xxx ] )
            a_dochgos[ 5, 1, xxx ] := Max( 0, a_przygos[ 5, 1, xxx ] - a_koszgos[ 5, 1, xxx ] )
            a_dochnaj[ 1, 1, xxx ] := Max( 0, a_przynaj[ 1, 1, xxx ] - a_kosznaj[ 1, 1, xxx ] )
            a_dochnaj[ 2, 1, xxx ] := Max( 0, a_przynaj[ 2, 1, xxx ] - a_kosznaj[ 2, 1, xxx ] )
            a_pit566[ 1, xxx ] := Max( 0, a_pit5gosp[ 1, xxx ] - a_pit5gosk[ 1, xxx ] )
            a_pit567[ 1, xxx ] := Max( 0, a_pit5najp[ 1, xxx ] - a_pit5najk[ 1, xxx ] )
            a_stragos[ 1, 1, xxx ] := Abs( Max( 0, a_przygos[ 1, 1, xxx ] - a_koszgos[ 1, 1, xxx ] ) )
            a_stragos[ 2, 1, xxx ] := Abs( Max( 0, a_przygos[ 2, 1, xxx ] - a_koszgos[ 2, 1, xxx ] ) )
            a_stragos[ 3, 1, xxx ] := Abs( Max( 0, a_przygos[ 3, 1, xxx ] - a_koszgos[ 3, 1, xxx ] ) )
            a_stragos[ 4, 1, xxx ] := Abs( Max( 0, a_przygos[ 4, 1, xxx ] - a_koszgos[ 4, 1, xxx ] ) )
            a_stragos[ 5, 1, xxx ] := Abs( Max( 0, a_przygos[ 5, 1, xxx ] - a_koszgos[ 5, 1, xxx ] ) )
            a_stranaj[ 1, 1, xxx ] := Abs( Max( 0, a_przynaj[ 1, 1, xxx ] - a_kosznaj[ 1, 1, xxx ] ) )
            a_stranaj[ 2, 1, xxx ] := Abs( Max( 0, a_przynaj[ 2, 1, xxx ] - a_kosznaj[ 2, 1, xxx ] ) )
            a_pit5goss[ 1, xxx ] := Max( 0, a_pit5gosk[ 1, xxx ] - a_pit5gosp[ 1, xxx ] )
            a_pit5najs[ 1, xxx ] := Max( 0, a_pit5najk[ 1, xxx ] - a_pit5najp[ 1, xxx ] )
            a_gosprzy[ 1, xxx ] := a_przygos[ 1, 1, xxx ] + a_przygos[ 2, 1, xxx ] + a_przygos[ 3, 1, xxx ] + a_przygos[ 4, 1, xxx ] + a_przygos[ 5, 1, xxx ] + a_pit5gosp[ 1, xxx ] + a_przywsp[ 1, xxx ]
            a_goskosz[ 1, xxx ] := a_koszgos[ 1, 1, xxx ] + a_koszgos[ 2, 1, xxx ] + a_koszgos[ 3, 1, xxx ] + a_koszgos[ 4, 1, xxx ] + a_koszgos[ 5, 1, xxx ] + a_pit5gosk[ 1, xxx ] + a_koszwsp[ 1, xxx ] - a_rem[ 1, xxx ]
            a_najprzy[ 1, xxx ] := a_przynaj[ 1, 1, xxx ] + a_przynaj[ 2, 1, xxx ] + a_pit5najp[ 1, xxx ]
            a_najkosz[ 1, xxx ] := a_kosznaj[ 1, 1, xxx ] + a_kosznaj[ 2, 1, xxx ] + a_pit5najk[ 1, xxx ]
            a_gosdoch[ 1, xxx ] := Max( 0, a_gosprzy[ 1, xxx ] - a_goskosz[ 1, xxx ] )
            a_gosstra[ 1, xxx ] := Max( 0, a_goskosz[ 1, xxx ] - a_gosprzy[ 1, xxx ] )
            a_najdoch[ 1, xxx ] := Max( 0, a_najprzy[ 1, xxx ] - a_najkosz[ 1, xxx ] )
            a_najstra[ 1, xxx ] := Max( 0, a_najkosz[ 1, xxx ] - a_najprzy[ 1, xxx ] )
            a_pro1doch[ 1, xxx ] := a_dochgos[ 1, 1, xxx ] + a_dochgos[ 2, 1, xxx ] + a_dochgos[ 3, 1, xxx ] + a_dochgos[ 4, 1, xxx ] + a_dochgos[ 5, 1, xxx ] + a_pk3[ 1, xxx ] + a_pit566[ 1, xxx ]
            a_pro1stra[ 1, xxx ] := a_stragos[ 1, 1, xxx ] + a_stragos[ 2, 1, xxx ] + a_stragos[ 3, 1, xxx ] + a_stragos[ 4, 1, xxx ] + a_stragos[ 5, 1, xxx ] + a_pk4[ 1, xxx ] + a_pit5goss[ 1, xxx ]
            a_pro2doch[ 1, xxx ] := a_dochnaj[ 1, 1, xxx ] + a_dochnaj[ 2, 1, xxx ] + a_pk3[ 1, xxx ] + a_pit567[ 1, xxx ]
            a_pro2stra[ 1, xxx ] := a_stranaj[ 1, 1, xxx ] + a_stranaj[ 2, 1, xxx ] + a_pk4[ 1, xxx ] + a_pit5najs[ 1, xxx ]
            a_p51a[ 1, xxx ] := a_STRATY[ 1, xxx ]
            a_p51b[ 1, xxx ] := a_powodz[ 1, xxx ]
            IF spolka->sposob == 'L'
               a_pk5[ 1, xxx ] := a_gosdoch[ 1, xxx ]
               a_p51[ 1, xxx ] := Min( a_STRATY[ 1, xxx ], a_gosdoch[ 1, xxx ] ) + a_powodz[ 1, xxx ]
            ELSE
               a_pk5[ 1, xxx ] := a_gosdoch[ 1, xxx ] + a_najdoch[ 1, xxx ]
               a_p51[ 1, xxx ] := Min( a_STRATY[ 1, xxx ], a_gosdoch[ 1, xxx ] ) + Min( a_STRATY_N[ 1, xxx ], a_najdoch[ 1, xxx ] ) + a_powodz[ 1, xxx ]
            ENDIF
            a_p50[ 1, xxx ] := a_rentalim[ 1, xxx ]
            IF a_P50[ 1, xxx ] > a_pk5[ 1, xxx ]
               a_P50[ 1, xxx ] := a_pk5[ 1, xxx ]
               a_P51[ 1, xxx ] := 0
            ELSE
               IF a_P50[ 1, xxx ] + a_P51[ 1, xxx ] > a_pk5[ 1, xxx ]
                  a_P51[ 1, xxx ] := a_pk5[ 1, xxx ] - ( a_P50[ 1, xxx ] )
               ENDIF
            ENDIF
            a_pKK7[ 1, xxx ] := a_pk5[ 1, xxx ] - ( a_P50[ 1, xxx ] + a_P51[ 1, xxx ] )
            ***pk6=dochod po odliczeniach
            IF a_P50[ 1, xxx ] > 0
               a_DOCHZWOL[ 1, xxx ] := 0
            ENDIF
            *a_wydatkim[1,xxx]=min(a_wydatkim[1,xxx]+a_dochzwol[1,xxx],a_pkk7[1,xxx])
            a_pk6[ 1, xxx ] := Max( 0, a_pkk7[ 1, xxx ] - a_wydatkim[ 1, xxx ] )
            ***pk75=p775 odliczenia od podatku
            a_pk75[ 1, xxx ] := a_g21[ 1, xxx ]
            ***pk7=p770 - podstawa
            IF a_gosdoch[ 1, xxx ] > 0
               a_pk7[ 1, xxx ] := a_pk6[ 1, xxx ] + a_pk75[ 1, xxx ]
            ELSE
               IF a_gosdoch[ 1, xxx ] == 0 .AND. a_gosstra[ 1, xxx ] < a_pk75[ 1, xxx ]
                  a_pk7[ 1, xxx ] := a_pk6[ 1, xxx ] + a_pk75[ 1, xxx ] - a_gosstra[ 1, xxx ]
               ELSE
                  a_pk7[ 1, xxx ] := a_pk6[ 1, xxx ]
               ENDIF
            ENDIF
            a_ppodstn[ 1, xxx ] := a_pk7[ 1, xxx ]
            a_pk7[ 1, xxx ] := _round( a_pk7[ 1, xxx ], 0 )
            a_ppodst[ 1, xxx ] := a_pk7[ 1, xxx ]

            *--------------- podatek dochodowy wg tabeli
            dDataNa := hb_Date( Val( param_rok ), xxx, 1 )
            //tab_doch->( dbSetFilter( { || tab_doch->del == '+' .AND. ( tab_doch->dataod <= dDataNa ) .AND. ( ( tab_doch->datado >= dDataNa ) .OR. ( tab_doch->datado == CToD('') ) ) } ) )
            tab_doch->( dbSetFilter( { || ( tab_doch->dataod <= dDataNa ) } ) )
            *IF ObiczKwWl == 'S' .OR. ObiczKwWl == ' '
               SELECT tab_doch
//               SEEK '-'
//               SKIP -1
               tab_doch->( dbGoBottom() )
            *ENDIF
            ppodatek := 0
            pzm := a_ppodst[ 1, xxx ]
            IF spolka->sposob == 'L'
               ppodatek := pzm * ( param_lin / 100 )
               ppodatek := Max( 0, ppodatek )
            ELSE
               *IF ObiczKwWl == 'S' .OR. ObiczKwWl == ' '
                  DO WHILE  ! Bof()
                     ppodatek := ppodatek + Max( 0, Min( a_ppodst[ 1, xxx ], pzm ) - podstawa ) * procent / 100
                     pzm := podstawa
                     SKIP -1
                  ENDDO
                  SELECT spolka
                  IF param_kskw == 'N'
                     IF TabDochProcent( a_ppodst[ 1, xxx ], 'tab_doch', Val( param_rok ), xxx, .F. ) = TabDochProcent( 0, 'tab_doch', Val( param_rok ), xxx, .F. )
                        ppodatek := Max( 0, ppodatek - iif( dDataNa < param_kwd, param_kw, param_kw2 ) )
                     ENDIF
                  ELSE
                     ppodatek := Max( 0, ppodatek - iif( dDataNa < param_kwd, param_kw, param_kw2 ) )
                  ENDIF
               *ELSE
                  *ppodatek := TabDochPodatek( pzm, 'tab_doch', Val( param_rok ), xxx, .F. )
               *ENDIF
            ENDIF
            tab_doch->( dbClearFilter() )
            *---------------
            SELECT spolka
            a_pk8[ 1, xxx ] := ppodatek
            IF spolka->sposob == 'L'
               //a_pk9[ 1, xxx ] := Min( a_pk8[ 1, xxx ], a_sumzdro[ 1, xxx ] )
               a_pk9[ 1, xxx ] :=0 // a_pk8[ 1, xxx ]
            ELSE
               //a_pk9[ 1, xxx ] := Min( a_pk8[ 1, xxx ], a_sumzdro[ 1, xxx ] + a_aaa[ 1, xxx ] + a_bbb[ 1, xxx ] + a_inneodpo[ 1, xxx ] )
               a_pk9[ 1, xxx ] := Min( a_pk8[ 1, xxx ], a_aaa[ 1, xxx ] + a_bbb[ 1, xxx ] + a_inneodpo[ 1, xxx ] )
            ENDIF
            a_sumzdro1[ 1, xxx ] := Max( 0, a_pk8[ 1, xxx ] - a_pk9[ 1, xxx ] )
            a_pk12[ 1, xxx ] := a_P97MMM[ 1, xxx ]
            a_pk13[ 1, xxx ] := _round( Max( 0, a_sumzdro1[ 1, xxx ] - a_pk12[ 1, xxx ] ), 0 )

            a_P97MMM[ 1, xxx ] := a_pk12[ 1, xxx ] + a_pk13[ 1, xxx ]
            a_P887MMMa[ 1, xxx ] := a_P887MMMa[ 1, xxx ] + a_P887MMM[ 1, xxx ]
            a_P887MMM[ 1, xxx ] := Min( a_pk13[ 1, xxx ], a_h385[ 1, xxx ] - a_P887MMMa[ 1, xxx ] )
         NEXT

         ***********************************************************************
         * wyliczenie narastajaco z ksiegi
         ***********************************************************************
         FOR xxx := 1 TO 12
            FOR yyy := 1 TO xxx
               a_pz_m[ 2, xxx ] := a_pz_m[ 2, xxx ] + a_pz_m[ 1, yyy ]
               a_wyr_tow[ 2, xxx ] := a_wyr_tow[ 2, xxx ] + a_wyr_tow[ 1, yyy ]
               a_uslugi[ 2, xxx ] := a_uslugi[ 2, xxx ] + a_uslugi[ 1, yyy ]
               a_zakup[ 2, xxx ] := a_zakup[ 2, xxx ] + a_zakup[ 1, yyy ]
               a_uboczne[ 2, xxx ] := a_uboczne[ 2, xxx ] + a_uboczne[ 1, yyy ]
               a_wynagr_g[ 2, xxx ] := a_wynagr_g[ 2, xxx ] + a_wynagr_g[ 1, yyy ]
               a_wydatki[ 2, xxx ] := a_wydatki[ 2, xxx ] + a_wydatki[ 1, yyy ]
               a_przywsp[ 2, xxx ] := a_przywsp[ 2, xxx ] + a_przywsp[ 1, yyy ]
               a_koszwsp[ 2, xxx ] := a_koszwsp[ 2, xxx ] + a_koszwsp[ 1, yyy ]
               *a_pk1[yyy,xxx]=0
               *a_pk2[yyy,xxx]=0
            NEXT
            a_pk3[ 2, xxx ] := Max( 0, a_przywsp[ 2, xxx ] - a_koszwsp[ 2, xxx ] )
            a_pk4[ 2, xxx ] := Abs( Min( 0, a_przywsp[ 2, xxx ] - a_koszwsp[ 2, xxx ] ) )
         NEXT

         FOR xxx := 1 TO 3
         *yyy=0 to 3
         *for zzz=1 to 3
             a_pz_m[ 3, xxx ] := a_pz_m[ 3, xxx ] + a_pz_m[ 1, 1 ] + a_pz_m[ 1, 2 ] + a_pz_m[ 1, 3 ]
             a_wyr_tow[ 3, xxx ] := a_wyr_tow[ 3, xxx ] + a_wyr_tow[ 1, 1 ] + a_wyr_tow[ 1, 2 ] + a_wyr_tow[ 1, 3 ]
             a_uslugi[ 3, xxx ] := a_uslugi[ 3, xxx ] + a_uslugi[ 1, 1 ] + a_uslugi[ 1, 2 ] + a_uslugi[ 1, 3 ]
             a_zakup[ 3, xxx ] := a_zakup[ 3, xxx ] + a_zakup[ 1, 1 ] + a_zakup[ 1, 2 ] + a_zakup[ 1, 3 ]
             a_uboczne[ 3, xxx ] := a_uboczne[ 3, xxx ] + a_uboczne[ 1, 1 ] + a_uboczne[ 1, 2 ] + a_uboczne[ 1, 3 ]
             a_wynagr_g[ 3, xxx ] := a_wynagr_g[ 3, xxx ] + a_wynagr_g[ 1, 1 ] + a_wynagr_g[ 1, 2 ] + a_wynagr_g[ 1, 3 ]
             a_wydatki[ 3, xxx ] := a_wydatki[ 3, xxx ] + a_wydatki[ 1, 1 ] + a_wydatki[ 1, 2 ] + a_wydatki[ 1, 3 ]
             a_przywsp[ 3, xxx ] := a_przywsp[ 3, xxx ] + a_przywsp[ 1, 1 ] + a_przywsp[ 1, 2 ] + a_przywsp[ 1, 3 ]
             a_koszwsp[ 3, xxx ] := a_koszwsp[ 3, xxx ] + a_koszwsp[ 1, 1 ] + a_koszwsp[ 1, 2 ] + a_koszwsp[ 1, 3 ]
         *next
         *next
             a_pk3[ 3, xxx ] := Max( 0, a_przywsp[ 3, xxx ] - a_koszwsp[ 3, xxx ] )
             a_pk4[ 3, xxx ] := Abs( Min( 0, a_przywsp[ 3, xxx ] - a_koszwsp[ 3, xxx ] ) )
         NEXT
         FOR xxx := 4 TO 6
            FOR yyy := 1 TO 6
         *for zzz=1 to 3
               a_pz_m[ 3, xxx ] := a_pz_m[ 3, xxx ] + a_pz_m[ 1, yyy ]
               a_wyr_tow[ 3, xxx ] := a_wyr_tow[ 3, xxx ] + a_wyr_tow[ 1, yyy ]
               a_uslugi[ 3, xxx ] := a_uslugi[ 3, xxx ] + a_uslugi[ 1, yyy ]
               a_zakup[ 3, xxx ] := a_zakup[ 3, xxx ] + a_zakup[ 1, yyy ]
               a_uboczne[ 3, xxx ] := a_uboczne[ 3, xxx ] + a_uboczne[ 1, yyy ]
               a_wynagr_g[ 3, xxx ] := a_wynagr_g[ 3, xxx ] + a_wynagr_g[ 1, yyy ]
               a_wydatki[ 3, xxx ] := a_wydatki[ 3, xxx ] + a_wydatki[ 1, yyy ]
               a_przywsp[ 3, xxx ] := a_przywsp[ 3, xxx ] + a_przywsp[ 1, yyy ]
               a_koszwsp[ 3, xxx ] := a_koszwsp[ 3, xxx ] + a_koszwsp[ 1, yyy ]
            NEXT
            a_pk3[ 3, xxx ] := Max( 0, a_przywsp[ 3, xxx ] - a_koszwsp[ 3, xxx ] )
            a_pk4[ 3, xxx ] := Abs( Min( 0, a_przywsp[ 3, xxx ] - a_koszwsp[ 3, xxx ] ) )
         NEXT
         FOR xxx := 7 TO 9
            FOR yyy := 1 TO 9
               a_pz_m[ 3, xxx ] := a_pz_m[ 3, xxx ] + a_pz_m[ 1, yyy ]
               a_wyr_tow[ 3, xxx ] := a_wyr_tow[ 3, xxx ] + a_wyr_tow[ 1, yyy ]
               a_uslugi[ 3, xxx ] := a_uslugi[ 3, xxx ] + a_uslugi[ 1, yyy ]
               a_zakup[ 3, xxx ] := a_zakup[ 3, xxx ] + a_zakup[ 1, yyy ]
               a_uboczne[ 3, xxx ] := a_uboczne[ 3, xxx ] + a_uboczne[ 1, yyy ]
               a_wynagr_g[ 3, xxx ] := a_wynagr_g[ 3, xxx ] + a_wynagr_g[ 1, yyy ]
               a_wydatki[ 3, xxx ] := a_wydatki[ 3, xxx ] + a_wydatki[ 1, yyy ]
               a_przywsp[ 3, xxx ] := a_przywsp[ 3, xxx ] + a_przywsp[ 1, yyy ]
               a_koszwsp[ 3, xxx ] := a_koszwsp[ 3, xxx ] + a_koszwsp[ 1, yyy ]
            NEXT
            a_pk3[ 3, xxx ] := Max( 0, a_przywsp[ 3, xxx ] - a_koszwsp[ 3, xxx ] )
            a_pk4[ 3, xxx ] := Abs( Min( 0, a_przywsp[ 3, xxx ] - a_koszwsp[ 3, xxx ] ) )
         NEXT
         FOR xxx := 10 TO 12
            FOR yyy := 1 TO 12
               a_pz_m[ 3, xxx ] := a_pz_m[ 3, xxx ] + a_pz_m[ 1, yyy ]
               a_wyr_tow[ 3, xxx ] := a_wyr_tow[ 3, xxx ] + a_wyr_tow[ 1, yyy ]
               a_uslugi[ 3, xxx ] := a_uslugi[ 3, xxx ] + a_uslugi[ 1, yyy ]
               a_zakup[ 3, xxx ] := a_zakup[ 3, xxx ] + a_zakup[ 1, yyy ]
               a_uboczne[ 3, xxx ] := a_uboczne[ 3, xxx ] + a_uboczne[ 1, yyy ]
               a_wynagr_g[ 3, xxx ] := a_wynagr_g[ 3, xxx ] + a_wynagr_g[ 1, yyy ]
               a_wydatki[ 3, xxx ] := a_wydatki[ 3, xxx ] + a_wydatki[ 1, yyy ]
               a_przywsp[ 3, xxx ] := a_przywsp[ 3, xxx ] + a_przywsp[ 1, yyy ]
               a_koszwsp[ 3, xxx ] := a_koszwsp[ 3, xxx ] + a_koszwsp[ 1, yyy ]
            NEXT
            a_pk3[ 3, xxx ] := Max( 0, a_przywsp[ 3, xxx ] - a_koszwsp[ 3, xxx ] )
            a_pk4[ 3, xxx ] := Abs( Min( 0, a_przywsp[ 3, xxx ] - a_koszwsp[ 3, xxx ] ) )
         NEXT

         *********************************************************************
         * dane miesieczne podatnika narastajaco
         *********************************************************************
         FOR i := 1 TO 12
            FOR yyy := 1 TO i
               a_przygos[ 1, 2, i ] := a_przygos[ 1, 2, i ] + a_przygos[ 1, 1, yyy ]
               a_przygos[ 2, 2, i ] := a_przygos[ 2, 2, i ] + a_przygos[ 2, 1, yyy ]
               a_przygos[ 3, 2, i ] := a_przygos[ 3, 2, i ] + a_przygos[ 3, 1, yyy ]
               a_przygos[ 4, 2, i ] := a_przygos[ 4, 2, i ] + a_przygos[ 4, 1, yyy ]
               a_przygos[ 5, 2, i ] := a_przygos[ 5, 2, i ] + a_przygos[ 5, 1, yyy ]
               a_koszgos[ 1, 2, i ] := a_koszgos[ 1, 2, i ] + a_koszgos[ 1, 1, yyy ]
               a_koszgos[ 2, 2, i ] := a_koszgos[ 2, 2, i ] + a_koszgos[ 2, 1, yyy ]
               a_koszgos[ 3, 2, i ] := a_koszgos[ 3, 2, i ] + a_koszgos[ 3, 1, yyy ]
               a_koszgos[ 4, 2, i ] := a_koszgos[ 4, 2, i ] + a_koszgos[ 4, 1, yyy ]
               a_koszgos[ 5, 2, i ] := a_koszgos[ 5, 2, i ] + a_koszgos[ 5, 1, yyy ]
               a_przynaj[ 1, 2, i ] := a_przynaj[ 1, 2, i ] + a_przynaj[ 1, 1, yyy ]
               a_przynaj[ 2, 2, i ] := a_przynaj[ 2, 2, i ] + a_przynaj[ 2, 1, yyy ]
               a_kosznaj[ 1, 2, i ] := a_kosznaj[ 1, 2, i ] + a_kosznaj[ 1, 1, yyy ]
               a_kosznaj[ 2, 2, i ] := a_kosznaj[ 2, 2, i ] + a_kosznaj[ 2, 1, yyy ]
               a_rentalim[ 2, i ]  := a_rentalim[ 2, i ] + a_rentalim[ 1, yyy ]
               a_straty[ 2, i ]    := a_straty[ 2, i ] + a_straty[ 1, yyy ]
               a_straty_n[ 2, i ]  := a_straty_n[ 2, i ] + a_straty_n[ 1, yyy ]
               a_powodz[ 2, i ]    := a_powodz[ 2, i ] + a_powodz[ 1, yyy ]
               a_wydatkim[ 2, i ]  := a_wydatkim[ 2, i ] + a_wydatkim[ 1, yyy ]
               a_wydatkid[ 2, i ]  := a_wydatkid[ 2, i ] + a_wydatkid[ 1, yyy ]
               a_sumemer[ 2, i ]   := a_sumemer[ 2, i ] + a_sumemer[ 1, yyy ]
               a_budowa[ 2, i ]    := a_budowa[ 2, i ] + a_budowa[ 1, yyy ]
               a_ubieginw[ 2, i ]  := a_ubieginw[ 2, i ] + a_ubieginw[ 1, yyy ]
               a_dochzwol[ 2, i ]  := a_dochzwol[ 2, i ] + a_dochzwol[ 1, yyy ]
               a_SSE[ 2, i ]       := a_SSE[ 2, i ] + a_SSE[ 1, yyy ]
               a_g21[ 2, i ]       := a_g21[ 2, i ] + a_g21[ 1, yyy ]
               a_h385[ 2, i ]      := a_h385[ 2, i ] + a_h385[ 1, yyy ]
               a_sumzdro[ 2, i ]   := a_sumzdro[ 2, i ] + a_sumzdro[ 1, yyy ]
               a_aaa[ 2, i ]       := a_aaa[ 2, i ] + a_aaa[ 1, yyy ]
               a_bbb[ 2, i ]       := a_bbb[ 2, i ] + a_bbb[ 1, yyy ]
               a_inneodpo[ 2, i ]  := a_inneodpo[ 2, i ] + a_inneodpo[ 1, yyy ]
               a_zaliczki[ 2, i ]  := a_zaliczki[ 2, i ] + a_zaliczki[ 1, yyy ]
               a_pit5gosk[ 2, i ]  := a_pit5gosk[ 2, i ] + a_pit5gosk[ 1, yyy ]
               a_pit5najk[ 2, i ]  := a_pit5najk[ 2, i ] + a_pit5najk[ 1, yyy ]
               a_pit5gosp[ 2, i ]  := a_pit5gosp[ 2, i ] + a_pit5gosp[ 1, yyy ]
               a_pit5najp[ 2, i ]  := a_pit5najp[ 2, i ] + a_pit5najp[ 1, yyy ]
               a_zalipod[ 2, i ]   := a_zalipod[ 2,i ] + a_zalipod[ 1, yyy ]
               a_zalipodp[ 2, i ]  := a_zalipodp[ 2, i ] + a_zalipodp[ 1, yyy ]
               a_rem[ 2, i ]       := a_rem[ 2, i ] + a_rem[ 1, yyy ]
               a_dochodzdr[ 2, i ] := a_dochodzdr[ 2, i ] + a_dochodzdr[ 1, yyy ]
            NEXT
            a_preman[ 2, i ] := a_preman[ 1, i ]
            a_odseodma[ 2, i ] := a_odseodma[ 1, i ]
         NEXT

         FOR i := 1 TO 3
            FOR yyy := 1 TO 3
            *for zzz=1 to 3
               a_przygos[ 1, 3, i ] := a_przygos[ 1, 3, i ] + a_przygos[ 1, 1, yyy ]
               a_przygos[ 2, 3, i ] := a_przygos[ 2, 3, i ] + a_przygos[ 2, 1, yyy ]
               a_przygos[ 3, 3, i ] := a_przygos[ 3, 3, i ] + a_przygos[ 3, 1, yyy ]
               a_przygos[ 4, 3, i ] := a_przygos[ 4, 3, i ] + a_przygos[ 4, 1, yyy ]
               a_przygos[ 5, 3, i ] := a_przygos[ 5, 3, i ] + a_przygos[ 5, 1, yyy ]
               a_koszgos[ 1, 3, i ] := a_koszgos[ 1, 3, i ] + a_koszgos[ 1, 1, yyy ]
               a_koszgos[ 2, 3, i ] := a_koszgos[ 2, 3, i ] + a_koszgos[ 2, 1, yyy ]
               a_koszgos[ 3, 3, i ] := a_koszgos[ 3, 3, i ] + a_koszgos[ 3, 1, yyy ]
               a_koszgos[ 4, 3, i ] := a_koszgos[ 4, 3, i ] + a_koszgos[ 4, 1, yyy ]
               a_koszgos[ 5, 3, i ] := a_koszgos[ 5, 3, i ] + a_koszgos[ 5, 1, yyy ]
               a_przynaj[ 1, 3, i ] := a_przynaj[ 1, 3, i ] + a_przynaj[ 1, 1, yyy ]
               a_przynaj[ 2, 3, i ] := a_przynaj[ 2, 3, i ] + a_przynaj[ 2, 1, yyy ]
               a_kosznaj[ 1, 3, i ] := a_kosznaj[ 1, 3, i ] + a_kosznaj[ 1, 1, yyy ]
               a_kosznaj[ 2, 3, i ] := a_kosznaj[ 2, 3, i ] + a_kosznaj[ 2, 1, yyy ]
               a_rentalim[ 3, i ]  := a_rentalim[ 3, i ] + a_rentalim[ 1, yyy ]
               a_straty[ 3, i ]    := a_straty[ 3, i ] + a_straty[ 1, yyy ]
               a_straty_n[ 3, i ]  := a_straty_n[ 3, i ] + a_straty_n[ 1, yyy ]
               a_powodz[ 3, i ]    := a_powodz[ 3, i ] + a_powodz[ 1, yyy ]
               a_wydatkim[ 3, i ]  := a_wydatkim[ 3, i ] + a_wydatkim[ 1, yyy ]
               a_wydatkid[ 3, i ]  := a_wydatkid[ 3, i ] + a_wydatkid[ 1, yyy ]
               a_sumemer[ 3, i ]   := a_sumemer[ 3, i ] + a_sumemer[ 1, yyy ]
               a_budowa[ 3, i ]    := a_budowa[ 3, i ] + a_budowa[ 1, yyy ]
               a_ubieginw[ 3, i ]  := a_ubieginw[ 3, i ] + a_ubieginw[ 1, yyy ]
               a_dochzwol[ 3, i ]  := a_dochzwol[ 3, i ] + a_dochzwol[ 1, yyy ]
               a_SSE[ 3, i ]       := a_SSE[ 3, i ] + a_SSE[ 1, yyy ]
               a_g21[ 3, i ]       := a_g21[ 3, i ] + a_g21[ 1, yyy ]
               a_h385[ 3, i ]      := a_h385[ 3, i ] + a_h385[ 1, yyy ]
               a_sumzdro[ 3, i ]   := a_sumzdro[ 3, i ] + a_sumzdro[ 1, yyy ]
               a_aaa[ 3, i ]       := a_aaa[ 3, i ] + a_aaa[ 1, yyy ]
               a_bbb[ 3, i ]       := a_bbb[ 3, i ] + a_bbb[ 1, yyy ]
               a_inneodpo[ 3, i ]  := a_inneodpo[ 3, i ] + a_inneodpo[ 1, yyy ]
               a_zaliczki[ 3, i ]  := a_zaliczki[ 3, i ] + a_zaliczki[ 1, yyy ]
               a_pit5gosk[ 3, i ]  := a_pit5gosk[ 3, i ] + a_pit5gosk[ 1, yyy ]
               a_pit5najk[ 3, i ]  := a_pit5najk[ 3, i ] + a_pit5najk[ 1, yyy ]
               a_pit5gosp[ 3, i ]  := a_pit5gosp[ 3, i ] + a_pit5gosp[ 1, yyy ]
               a_pit5najp[ 3, i ]  := a_pit5najp[ 3, i ] + a_pit5najp[ 1, yyy ]
               a_zalipod[ 3, i ]   := a_zalipod[ 3, i ] + a_zalipod[ 1, yyy ]
               a_zalipodp[ 3, i ]  := a_zalipodp[ 3, i ] + a_zalipodp[ 1, yyy ]
               a_preman[ 3, i ] := a_preman[ 3, i ] + a_preman[ 1, yyy ]
               a_odseodma[ 3, i ] := a_odseodma[ 3, i ] + a_odseodma[ 1, yyy ]
               a_rem[ 3, i ]      := a_rem[ 3, i ] + a_rem[ 1, yyy ]
               a_dochodzdr[ 3, i ] := a_dochodzdr[ 3, i ] + a_dochodzdr[ 3, yyy ]
             *next
            NEXT
         NEXT
         FOR i := 4 TO 6
            FOR yyy := 1 TO 6
            *for zzz=1 to 3
               a_przygos[ 1, 3, i ] := a_przygos[ 1, 3, i ] + a_przygos[ 1, 1, yyy ]
               a_przygos[ 2, 3, i ] := a_przygos[ 2, 3, i ] + a_przygos[ 2, 1, yyy ]
               a_przygos[ 3, 3, i ] := a_przygos[ 3, 3, i ] + a_przygos[ 3, 1, yyy ]
               a_przygos[ 4, 3, i ] := a_przygos[ 4, 3, i ] + a_przygos[ 4, 1, yyy ]
               a_przygos[ 5, 3, i ] := a_przygos[ 5, 3, i ] + a_przygos[ 5, 1, yyy ]
               a_koszgos[ 1, 3, i ] := a_koszgos[ 1, 3, i ] + a_koszgos[ 1, 1, yyy ]
               a_koszgos[ 2, 3, i ] := a_koszgos[ 2, 3, i ] + a_koszgos[ 2, 1, yyy ]
               a_koszgos[ 3, 3, i ] := a_koszgos[ 3, 3, i ] + a_koszgos[ 3, 1, yyy ]
               a_koszgos[ 4, 3, i ] := a_koszgos[ 4, 3, i ] + a_koszgos[ 4, 1, yyy ]
               a_koszgos[ 5, 3, i ] := a_koszgos[ 5, 3, i ] + a_koszgos[ 5, 1, yyy ]
               a_przynaj[ 1, 3, i ] := a_przynaj[ 1, 3, i ] + a_przynaj[ 1, 1, yyy ]
               a_przynaj[ 2, 3, i ] := a_przynaj[ 2, 3, i ] + a_przynaj[ 2, 1, yyy ]
               a_kosznaj[ 1, 3, i ] := a_kosznaj[ 1, 3, i ] + a_kosznaj[ 1, 1, yyy ]
               a_kosznaj[ 2, 3, i ] := a_kosznaj[ 2, 3, i ] + a_kosznaj[ 2, 1, yyy ]
               a_rentalim[ 3, i ]  := a_rentalim[ 3, i ] + a_rentalim[ 1, yyy ]
               a_straty[ 3, i ]    := a_straty[ 3, i ] + a_straty[ 1, yyy ]
               a_straty_n[ 3, i ]  := a_straty_n[ 3, i ] + a_straty_n[ 1, yyy ]
               a_powodz[ 3, i ]    := a_powodz[ 3, i ] + a_powodz[ 1, yyy ]
               a_wydatkim[ 3, i ]  := a_wydatkim[ 3, i ] + a_wydatkim[ 1, yyy ]
               a_wydatkid[ 3, i ]  := a_wydatkid[ 3, i ] + a_wydatkid[ 1, yyy ]
               a_sumemer[ 3, i ]   := a_sumemer[ 3, i ] + a_sumemer[ 1, yyy ]
               a_budowa[ 3, i ]    := a_budowa[ 3, i ] + a_budowa[ 1, yyy ]
               a_ubieginw[ 3, i ]  := a_ubieginw[ 3, i ] + a_ubieginw[ 1, yyy ]
               a_dochzwol[ 3, i ]  := a_dochzwol[ 3, i ] + a_dochzwol[ 1, yyy ]
               a_SSE[ 3, i ]       := a_SSE[ 3, i ] + a_SSE[ 1, yyy ]
               a_g21[ 3, i ]       := a_g21[ 3, i ] + a_g21[ 1, yyy ]
               a_h385[ 3, i ]      := a_h385[ 3, i ] + a_h385[ 1, yyy ]
               a_sumzdro[ 3, i ]   := a_sumzdro[ 3, i ] + a_sumzdro[ 1, yyy ]
               a_aaa[ 3, i ]       := a_aaa[ 3, i ] + a_aaa[ 1, yyy ]
               a_bbb[ 3, i ]       := a_bbb[ 3, i ] + a_bbb[ 1, yyy ]
               a_inneodpo[ 3, i ]  := a_inneodpo[ 3, i ] + a_inneodpo[ 1, yyy ]
               a_zaliczki[ 3, i ]  := a_zaliczki[ 3, i ] + a_zaliczki[ 1, yyy ]
               a_pit5gosk[ 3, i ]  := a_pit5gosk[ 3, i ] + a_pit5gosk[ 1, yyy ]
               a_pit5najk[ 3, i ]  := a_pit5najk[ 3, i ] + a_pit5najk[ 1, yyy ]
               a_pit5gosp[ 3, i ]  := a_pit5gosp[ 3, i ] + a_pit5gosp[ 1, yyy ]
               a_pit5najp[ 3, i ]  := a_pit5najp[ 3, i ] + a_pit5najp[ 1, yyy ]
               a_zalipod[ 3, i ]   := a_zalipod[ 3, i ] + a_zalipod[ 1, yyy ]
               a_zalipodp[ 3, i ]  := a_zalipodp[ 3, i ] + a_zalipodp[ 1, yyy ]
               a_rem[ 3, i ]      := a_rem[ 3, i ] + a_rem[ 1, yyy ]
               a_dochodzdr[ 3, i ] := a_dochodzdr[3, i ] + a_dochodzdr[ 1, yyy ]
            *next
            NEXT
            FOR yyy := 4 TO 6
                a_preman[ 3, i ] := a_preman[ 3, i ] + a_preman[ 1, yyy ]
                a_odseodma[ 3, i ] := a_odseodma[ 3, i ] + a_odseodma[ 1, yyy ]
            NEXT
         NEXT
         FOR i := 7 TO 9
            FOR yyy := 1 TO 9
               a_przygos[ 1, 3, i ] := a_przygos[ 1, 3, i ] + a_przygos[ 1, 1, yyy ]
               a_przygos[ 2, 3, i ] := a_przygos[ 2, 3, i ] + a_przygos[ 2, 1, yyy ]
               a_przygos[ 3, 3, i ] := a_przygos[ 3, 3, i ] + a_przygos[ 3, 1, yyy ]
               a_przygos[ 4, 3, i ] := a_przygos[ 4, 3, i ] + a_przygos[ 4, 1, yyy ]
               a_przygos[ 5, 3, i ] := a_przygos[ 5, 3, i ] + a_przygos[ 5, 1, yyy ]
               a_koszgos[ 1, 3, i ] := a_koszgos[ 1, 3, i ] + a_koszgos[ 1, 1, yyy ]
               a_koszgos[ 2, 3, i ] := a_koszgos[ 2, 3, i ] + a_koszgos[ 2, 1, yyy ]
               a_koszgos[ 3, 3, i ] := a_koszgos[ 3, 3, i ] + a_koszgos[ 3, 1, yyy ]
               a_koszgos[ 4, 3, i ] := a_koszgos[ 4, 3, i ] + a_koszgos[ 4, 1, yyy ]
               a_koszgos[ 5, 3, i ] := a_koszgos[ 5, 3, i ] + a_koszgos[ 5, 1, yyy ]
               a_przynaj[ 1, 3, i ] := a_przynaj[ 1, 3, i ] + a_przynaj[ 1, 1, yyy ]
               a_przynaj[ 2, 3, i ] := a_przynaj[ 2, 3, i ] + a_przynaj[ 2, 1, yyy ]
               a_kosznaj[ 1, 3, i ] := a_kosznaj[ 1, 3, i ] + a_kosznaj[ 1, 1, yyy ]
               a_kosznaj[ 2, 3, i ] := a_kosznaj[ 2, 3, i ] + a_kosznaj[ 2, 1, yyy ]
               a_rentalim[ 3, i ]  := a_rentalim[ 3, i ] + a_rentalim[ 1, yyy ]
               a_straty[ 3, i ]    := a_straty[ 3, i ] + a_straty[ 1, yyy ]
               a_straty_n[ 3, i ]  := a_straty_n[ 3, i ] + a_straty_n[ 1, yyy ]
               a_powodz[ 3, i ]    := a_powodz[ 3, i ] + a_powodz[ 1, yyy ]
               a_wydatkim[ 3, i ]  := a_wydatkim[ 3, i ] + a_wydatkim[ 1, yyy ]
               a_wydatkid[ 3, i ]  := a_wydatkid[ 3, i ] + a_wydatkid[ 1, yyy ]
               a_sumemer[ 3, i ]   := a_sumemer[ 3, i ] + a_sumemer[ 1, yyy ]
               a_budowa[ 3, i ]    := a_budowa[ 3, i ] + a_budowa[ 1, yyy ]
               a_ubieginw[ 3, i ]  := a_ubieginw[ 3, i ] + a_ubieginw[ 1, yyy ]
               a_dochzwol[ 3, i ]  := a_dochzwol[ 3, i ] + a_dochzwol[ 1, yyy ]
               a_SSE[ 3, i ]       := a_SSE[ 3, i ] + a_SSE[ 1, yyy ]
               a_g21[ 3, i ]       := a_g21[ 3, i ] + a_g21[ 1, yyy ]
               a_h385[ 3, i ]      := a_h385[ 3, i ] + a_h385[ 1, yyy ]
               a_sumzdro[ 3, i ]   := a_sumzdro[ 3, i ] + a_sumzdro[ 1, yyy ]
               a_aaa[ 3, i ]       := a_aaa[ 3, i ] + a_aaa[ 1, yyy ]
               a_bbb[ 3, i ]       := a_bbb[ 3, i ] + a_bbb[ 1, yyy ]
               a_inneodpo[ 3, i ]  := a_inneodpo[ 3, i ] + a_inneodpo[ 1, yyy ]
               a_zaliczki[ 3, i ]  := a_zaliczki[ 3, i ] + a_zaliczki[ 1, yyy ]
               a_pit5gosk[ 3, i ]  := a_pit5gosk[ 3, i ] + a_pit5gosk[ 1, yyy ]
               a_pit5najk[ 3, i ]  := a_pit5najk[ 3, i ] + a_pit5najk[ 1, yyy ]
               a_pit5gosp[ 3, i ]  := a_pit5gosp[ 3, i ] + a_pit5gosp[ 1, yyy ]
               a_pit5najp[ 3, i ]  := a_pit5najp[ 3, i ] + a_pit5najp[ 1, yyy ]
               a_zalipod[ 3, i ]   := a_zalipod[ 3, i ] + a_zalipod[ 1, yyy ]
               a_zalipodp[ 3, i ]  := a_zalipodp[ 3, i ] + a_zalipodp[ 1, yyy ]
               a_rem[ 3, i ]      := a_rem[ 3, i ] + a_rem[ 1, yyy ]
               a_dochodzdr[ 3, i ] := a_dochodzdr[ 3, i ] + a_dochodzdr[ 1, yyy ]
            NEXT
            FOR yyy := 7 TO 9
               a_preman[ 3, i ] := a_preman[ 3, i ] + a_preman[ 1, yyy ]
               a_odseodma[ 3, i ] := a_odseodma[ 3, i ] + a_odseodma[ 1, yyy ]
            NEXT
         NEXT
         FOR i := 10 TO 12
            FOR yyy := 1 TO 12
               a_przygos[ 1, 3, i ] := a_przygos[ 1, 3, i ] + a_przygos[ 1, 1, yyy ]
               a_przygos[ 2, 3, i ] := a_przygos[ 2, 3, i ] + a_przygos[ 2, 1, yyy ]
               a_przygos[ 3, 3, i ] := a_przygos[ 3, 3, i ] + a_przygos[ 3, 1, yyy ]
               a_przygos[ 4, 3, i ] := a_przygos[ 4, 3, i ] + a_przygos[ 4, 1, yyy ]
               a_przygos[ 5, 3, i ] := a_przygos[ 5, 3, i ] + a_przygos[ 5, 1, yyy ]
               a_koszgos[ 1, 3, i ] := a_koszgos[ 1, 3, i ] + a_koszgos[ 1, 1, yyy ]
               a_koszgos[ 2, 3, i ] := a_koszgos[ 2, 3, i ] + a_koszgos[ 2, 1, yyy ]
               a_koszgos[ 3, 3, i ] := a_koszgos[ 3, 3, i ] + a_koszgos[ 3, 1, yyy ]
               a_koszgos[ 4, 3, i ] := a_koszgos[ 4, 3, i ] + a_koszgos[ 4, 1, yyy ]
               a_koszgos[ 5, 3, i ] := a_koszgos[ 5, 3, i ] + a_koszgos[ 5, 1, yyy ]
               a_przynaj[ 1, 3, i ] := a_przynaj[ 1, 3, i ] + a_przynaj[ 1, 1, yyy ]
               a_przynaj[ 2, 3, i ] := a_przynaj[ 2, 3, i ] + a_przynaj[ 2, 1, yyy ]
               a_kosznaj[ 1, 3, i ] := a_kosznaj[ 1, 3, i ] + a_kosznaj[ 1, 1, yyy ]
               a_kosznaj[ 2, 3, i ] := a_kosznaj[ 2, 3, i ] + a_kosznaj[ 2, 1, yyy ]
               a_rentalim[ 3, i ]  := a_rentalim[ 3, i ] + a_rentalim[ 1, yyy ]
               a_straty[ 3, i ]    := a_straty[ 3, i ] + a_straty[ 1, yyy ]
               a_straty_n[ 3, i ]  := a_straty_n[ 3, i ] + a_straty_n[ 1, yyy ]
               a_powodz[ 3, i ]    := a_powodz[ 3, i ] + a_powodz[ 1, yyy ]
               a_wydatkim[ 3, i ]  := a_wydatkim[ 3, i ] + a_wydatkim[ 1, yyy ]
               a_wydatkid[ 3, i ]  := a_wydatkid[ 3, i ] + a_wydatkid[ 1, yyy ]
               a_sumemer[ 3, i ]   := a_sumemer[ 3, i ] + a_sumemer[ 1, yyy ]
               a_budowa[ 3, i ]    := a_budowa[ 3, i ] + a_budowa[ 1, yyy ]
               a_ubieginw[ 3, i ]  := a_ubieginw[ 3, i ] + a_ubieginw[ 1, yyy ]
               a_dochzwol[ 3, i ]  := a_dochzwol[ 3, i ] + a_dochzwol[ 1, yyy ]
               a_SSE[ 3, i ]       := a_SSE[ 3, i ] + a_SSE[ 1, yyy ]
               a_g21[ 3, i ]       := a_g21[ 3, i ] + a_g21[ 1, yyy ]
               a_h385[ 3, i ]      := a_h385[ 3, i ] + a_h385[ 1, yyy ]
               a_sumzdro[ 3, i ]   := a_sumzdro[ 3, i ] + a_sumzdro[ 1, yyy ]
               a_aaa[ 3, i ]       := a_aaa[ 3, i ] + a_aaa[ 1, yyy ]
               a_bbb[ 3, i ]       := a_bbb[ 3, i ] + a_bbb[ 1, yyy ]
               a_inneodpo[ 3, i ]  := a_inneodpo[ 3, i ] + a_inneodpo[ 1, yyy ]
               a_zaliczki[ 3, i ]  := a_zaliczki[ 3, i ] + a_zaliczki[ 1, yyy ]
               a_pit5gosk[ 3, i ]  := a_pit5gosk[ 3, i ] + a_pit5gosk[ 1, yyy ]
               a_pit5najk[ 3, i ]  := a_pit5najk[ 3, i ] + a_pit5najk[ 1, yyy ]
               a_pit5gosp[ 3, i ]  := a_pit5gosp[ 3, i ] + a_pit5gosp[ 1, yyy ]
               a_pit5najp[ 3, i ]  := a_pit5najp[ 3, i ] + a_pit5najp[ 1, yyy ]
               a_zalipod[ 3, i ]   := a_zalipod[ 3, i ] + a_zalipod[ 1, yyy ]
               a_zalipodp[ 3, i ]  := a_zalipodp[ 3, i ] + a_zalipodp[ 1, yyy ]
               a_rem[ 3, i ]       := a_rem[ 3, i ] + a_rem[ 1, yyy ]
               a_dochodzdr[ 3, i ] := a_dochodzdr[ 3, i ] + a_dochodzdr[ 1, yyy ]
            NEXT
            FOR yyy := 10 TO 12
               a_preman[ 3, i ] := a_preman[ 3, i ] + a_preman[ 1, yyy ]
               a_odseodma[ 3, i ] := a_odseodma[ 3, i ] + a_odseodma[ 1, yyy ]
            NEXT
         NEXT

         *********************************************************************
         * wyliczenia w petlach narastajaco
         *********************************************************************
         FOR xxx := 1 TO 12
            a_dochgos[ 1, 2, xxx ] := Max( 0, a_przygos[ 1, 2, xxx ] - a_koszgos[ 1, 2, xxx ] )
            a_dochgos[ 2, 2, xxx ] := Max( 0, a_przygos[ 2, 2, xxx ] - a_koszgos[ 2, 2, xxx ] )
            a_dochgos[ 3, 2, xxx ] := Max( 0, a_przygos[ 3, 2, xxx ] - a_koszgos[ 3, 2, xxx ] )
            a_dochgos[ 4, 2, xxx ] := Max( 0, a_przygos[ 4, 2, xxx ] - a_koszgos[ 4, 2, xxx ] )
            a_dochgos[ 5, 2, xxx ] := Max( 0, a_przygos[ 5, 2, xxx ] - a_koszgos[ 5, 2, xxx ] )
            a_dochnaj[ 1, 2, xxx ] := Max( 0, a_przynaj[ 1, 2, xxx ] - a_kosznaj[ 1, 2, xxx ] )
            a_dochnaj[ 2, 2, xxx ] := Max( 0, a_przynaj[ 2, 2, xxx ] - a_kosznaj[ 2, 2, xxx ] )
            a_pit566[ 2, xxx ] := Max( 0, a_pit5gosp[ 2, xxx ] - a_pit5gosk[ 2, xxx ] )
            a_pit567[ 2, xxx ] := Max( 0, a_pit5najp[ 2, xxx ] - a_pit5najk[ 2, xxx ] )
            a_stragos[ 1, 2, xxx ] := Abs( Max( 0, a_przygos[ 1, 2, xxx ] - a_koszgos[ 1, 2, xxx ] ) )
            a_stragos[ 2, 2, xxx ] := Abs( Max( 0, a_przygos[ 2, 2, xxx ] - a_koszgos[ 2, 2, xxx ] ) )
            a_stragos[ 3, 2, xxx ] := Abs( Max( 0, a_przygos[ 3, 2, xxx ] - a_koszgos[ 3, 2, xxx ] ) )
            a_stragos[ 4, 2, xxx ] := Abs( Max( 0, a_przygos[ 4, 2, xxx ] - a_koszgos[ 4, 2, xxx ] ) )
            a_stragos[ 5, 2, xxx ] := Abs( Max( 0, a_przygos[ 5, 2, xxx ] - a_koszgos[ 5, 2, xxx ] ) )
            a_stranaj[ 1, 2, xxx ] := Abs( Max( 0, a_przynaj[ 1, 2, xxx ] - a_kosznaj[ 1, 2, xxx ] ) )
            a_stranaj[ 2, 2, xxx ] := Abs( Max( 0, a_przynaj[ 2, 2, xxx ] - a_kosznaj[ 2, 2, xxx ] ) )
            a_pit5goss[ 2, xxx ] := Max( 0, a_pit5gosk[ 2, xxx ] - a_pit5gosp[ 2, xxx ] )
            a_pit5najs[ 2, xxx ] := Max( 0, a_pit5najk[ 2, xxx ] - a_pit5najp[ 2, xxx ] )
            a_gosprzy[ 2, xxx ] := a_przygos[ 1, 2, xxx ] + a_przygos[ 2, 2, xxx ] + a_przygos[ 3, 2, xxx ] + a_przygos[ 4, 2, xxx ] + a_przygos[ 5, 2, xxx ] + a_pit5gosp[ 2, xxx ] + a_przywsp[ 2, xxx ]
            a_goskosz[ 2, xxx ] := a_koszgos[ 1, 2, xxx ] + a_koszgos[ 2, 2, xxx ] + a_koszgos[ 3, 2, xxx ] + a_koszgos[ 4, 2, xxx ] + a_koszgos[ 5, 2, xxx ] + a_pit5gosk[ 2, xxx ] + a_koszwsp[ 2, xxx ] - a_rem[ 2, xxx]
            a_najprzy[ 2, xxx ] := a_przynaj[ 1, 2, xxx ] + a_przynaj[ 2, 2, xxx ] + a_pit5najp[ 2, xxx ]
            a_najkosz[ 2, xxx ] := a_kosznaj[ 1, 2, xxx ] + a_kosznaj[ 2, 2, xxx ] + a_pit5najk[ 2, xxx ]
            a_gosdoch[ 2, xxx ] := Max( 0, a_gosprzy[ 2, xxx ] - a_goskosz[ 2, xxx ] )
            a_gosstra[ 2, xxx ] := Max( 0, a_goskosz[ 2, xxx ] - a_gosprzy[ 2, xxx ] )
            a_najdoch[ 2, xxx ] := Max( 0, a_najprzy[ 2, xxx ] - a_najkosz[ 2, xxx ] )
            a_najstra[ 2, xxx ] := Max( 0, a_najkosz[ 2, xxx ] - a_najprzy[ 2, xxx ] )
            a_pro1doch[ 2, xxx ] := a_dochgos[ 1, 2, xxx ] + a_dochgos[ 2, 2, xxx ] + a_dochgos[ 3, 2, xxx ] + a_dochgos[ 4, 2, xxx ] + a_dochgos[ 5, 2, xxx ] + a_pk3[ 2, xxx ] + a_pit566[ 2, xxx ]
            a_pro1stra[ 2, xxx ] := a_stragos[ 1, 2, xxx ] + a_stragos[ 2, 2, xxx ] + a_stragos[ 3, 2, xxx ] + a_stragos[ 4, 2, xxx ] + a_stragos[ 5, 2, xxx ] + a_pk4[ 2, xxx ] + a_pit5goss[ 2, xxx ]
            a_pro2doch[ 2, xxx ] := a_dochnaj[ 1, 2, xxx ] + a_dochnaj[ 2, 2, xxx ] + a_pk3[ 2, xxx ] + a_pit567[ 2, xxx ]
            a_pro2stra[ 2, xxx ] := a_stranaj[ 1, 2, xxx ] + a_stranaj[ 2, 2, xxx ] + a_pk4[ 2, xxx ] + a_pit5najs[ 2, xxx ]
            a_p51a[ 2, xxx ] := a_STRATY[ 2, xxx ]
            a_p51b[ 2, xxx ] := a_powodz[ 2, xxx ]
            IF spolka->sposob == 'L'
               a_pk5[ 2, xxx ] := a_gosdoch[ 2, xxx ]
               a_p51[ 2, xxx ] := Min( a_STRATY[ 2, xxx ], a_gosdoch[ 2, xxx ] ) + a_powodz[ 2, xxx ]
            ELSE
               a_pk5[ 2, xxx ] := a_gosdoch[ 2, xxx ] + a_najdoch[ 2, xxx ]
               a_p51[ 2, xxx ] := Min( a_STRATY[ 2, xxx ], a_gosdoch[ 2, xxx ] ) + Min( a_STRATY_N[ 2, xxx ], a_najdoch[ 2, xxx ] ) + a_powodz[ 2, xxx ]
            ENDIF
            a_p50[ 2, xxx ] := a_rentalim[ 2, xxx ]
            IF a_P50[ 2, xxx ] > a_pk5[ 2, xxx ]
               a_P50[ 2, xxx ] := a_pk5[ 2, xxx ]
               a_P51[ 2, xxx ] := 0
            ELSE
               IF a_P50[ 2, xxx ] + a_P51[ 2, xxx ] > a_pk5[ 2, xxx ]
                  a_P51[ 2, xxx ] := a_pk5[ 2, xxx ] - ( a_P50[ 2, xxx ] )
               ENDIF
            ENDIF
            a_pKK7[ 2, xxx ] := a_pk5[ 2, xxx ] - ( a_P50[ 2, xxx ] + a_P51[ 2, xxx ] )
            ***pk6=dochod po odliczeniach
            IF a_P50[ 2, xxx ] > 0
               a_DOCHZWOL[ 2, xxx ] := 0
            ENDIF
            a_wydatkim[ 2, xxx ] := Min( a_wydatkim[ 2, xxx ] + a_dochzwol[ 2, xxx ], a_pkk7[ 2, xxx ] )
            a_pk6[ 2, xxx ] := Max( 0, a_pkk7[ 2, xxx ] - a_wydatkim[ 2, xxx ] )
            ***pk75=p775 odliczenia od podatku
            a_pk75[ 2, xxx ] := a_g21[ 2, xxx ]
            ***pk7=p770 - podstawa
            IF a_gosdoch[ 2, xxx ] > 0
               a_pk7[ 2, xxx ] := a_pk6[ 2, xxx ] + a_pk75[ 2, xxx ]
            ELSE
               IF a_gosdoch[ 2, xxx ] = 0 .AND. a_gosstra[ 2, xxx ] < a_pk75[ 2, xxx ]
                  a_pk7[ 2, xxx ] := a_pk6[ 2, xxx ] + a_pk75[ 2, xxx ] - a_gosstra[ 2, xxx ]
               ELSE
                  a_pk7[ 2, xxx ] := a_pk6[ 2, xxx ]
               ENDIF
            ENDIF
            a_ppodstn[ 2, xxx ] := a_pk7[ 2, xxx ]
            a_pk7[ 2, xxx ] := _round( a_pk7[ 2, xxx ], 0 )
            a_ppodst[ 2, xxx ] := a_pk7[ 2, xxx ]

            *--------------- podatek dochodowy wg tabeli

            dDataNa := hb_Date( Val( param_rok ), xxx, 1 )
            //tab_doch->( dbSetFilter( { || tab_doch->del == '+' .AND. ( tab_doch->dataod <= dDataNa ) .AND. ( ( tab_doch->datado >= dDataNa ) .OR. ( tab_doch->datado == CToD('') ) ) } ) )
            tab_doch->( dbSetFilter( { || ( tab_doch->dataod <= dDataNa ) } ) )
            *IF ObiczKwWl == 'S' .OR. ObiczKwWl == ' '
               SELECT tab_doch
//               SEEK '-'
//               SKIP -1
               tab_doch->( dbGoBottom() )
            *ENDIF
            ppodatek := 0
            pzm := a_ppodst[ 2, xxx ]
            IF spolka->sposob == 'L'
               ppodatek := pzm * ( param_lin / 100 )
               ppodatek := Max( 0, ppodatek )
            ELSE
               *IF ObiczKwWl == 'S' .OR. ObiczKwWl == ' '
                  DO WHILE ! Bof()
                     ppodatek := ppodatek + Max( 0, Min( a_ppodst[ 2, xxx ], pzm ) - podstawa ) * procent / 100
                     pzm := podstawa
                     SKIP -1
                  ENDDO
                  SELECT spolka
                  IF param_kskw == 'N'
                     IF TabDochProcent( a_ppodst[ 2, xxx ], 'tab_doch', Val( param_rok ), xxx, .F. ) = TabDochProcent( 0, 'tab_doch', Val( param_rok ), xxx, .F. )
                        ppodatek := Max( 0, ppodatek - iif( dDataNa < param_kwd, param_kw, param_kw2 ) )
                     ENDIF
                  ELSE
                     ppodatek := Max( 0, ppodatek - iif( dDataNa < param_kwd, param_kw, param_kw2 ) )
                  ENDIF
               *ELSE
                  *ppodatek := TabDochPodatek( pzm, 'tab_doch', Val( param_rok ), xxx, .F. )
               *ENDIF
            END
            tab_doch->( dbClearFilter() )
            *---------------
            SELECT spolka
            a_pk8[ 2, xxx ] := ppodatek
            IF spolka->sposob == 'L'
               //a_pk9[ 2, xxx ] := Min( a_pk8[ 2, xxx ], a_sumzdro[ 2, xxx ] )
               a_pk9[ 2, xxx ] := 0 // a_pk8[ 2, xxx ]
            ELSE
               //a_pk9[ 2, xxx ] := Min( a_pk8[ 2, xxx ], a_sumzdro[ 2, xxx ] + a_aaa[ 2, xxx ] + a_bbb[ 2, xxx ] + a_inneodpo[ 2, xxx ] )
               a_pk9[ 2, xxx ] := Min( a_pk8[ 2, xxx ], a_aaa[ 2, xxx ] + a_bbb[ 2, xxx ] + a_inneodpo[ 2, xxx ] )
            ENDIF
            a_sumzdro1[ 2, xxx ] := Max( 0, a_pk8[ 2, xxx ] - a_pk9[ 2, xxx ] )
            a_pk12[ 2, xxx ] := iif( xxx == 1, 0, a_P97MMM[ 2, xxx - 1 ] )
            a_pk13[ 2, xxx ] := _round( Max( 0, a_sumzdro1[ 2, xxx ] - a_pk12[ 2, xxx ] ), 0 )
            a_P885[ 2, xxx ] := a_h385[ 2, xxx ]
            a_P888[ 2, xxx ] := Min( a_pk13[ 2, xxx ], a_h385[ 2, xxx ] - iif( xxx == 1, 0, a_P887[ 2, xxx - 1 ] ) )
            a_P887[ 2, xxx ] := iif( xxx == 1, 0, a_P887[ 2, xxx - 1 ] ) + a_P888[ 2, xxx ]
            a_P889[ 2, xxx ] := a_pk13[ 2, xxx ] - a_P888[ 2, xxx ]
            a_wartprze[ 2, xxx ] := a_pk13[ 2, xxx ] + a_preman[ 2, xxx ] + a_odseodma[ 2, xxx ] - a_P888[ 2, xxx ]

            *do case
            *case xxx=11 .and. zPITOKRES='M'
            *     a_wartprze[2,xxx]=(a_pk13[2,xxx]*2)+a_preman[2,xxx]+a_odseodma[2,xxx]-a_P888[2,xxx]
            *case xxx=12 .and. zPITOKRES='M'
            *     a_wartprze[2,xxx]=a_pk13[2,xxx]-a_pk13[2,xxx-1]+a_preman[2,xxx]+a_odseodma[2,xxx]-a_P888[2,xxx]
            *case xxx<11 .and. zPITOKRES='M'
            *     a_wartprze[2,xxx]=a_pk13[2,xxx]+a_preman[2,xxx]+a_odseodma[2,xxx]-a_P888[2,xxx]
            *endcase

            SELECT dane_mc
            SEEK '+' + zident + Str( xxx, 2 )
            IF del == '+' .AND. ident == zident .AND. mc == Str( xxx, 2 )
               BlokadaR()
               IF zPITOKRES == 'M'
                  REPLACE zaliczkap WITH a_wartprze[ 2, xxx ]
                  a_zalipodp[ 1, xxx ] := a_wartprze[ 2, xxx ]
               ELSE
                  REPLACE zaliczkap WITH 0
                  a_zalipodp[ 1, xxx ] := 0
               ENDIF
               COMMIT
               UNLOCK
            ENDIF

            *wait str(a_wartprze[2,xxx],12,2)

            a_P97MMM[ 2, xxx ] := a_pk12[ 2, xxx ] + a_pk13[ 2, xxx ]
         NEXT
         FOR i := 1 TO 12
            a_zalipodp[ 2, i ] := 0
         NEXT
         FOR i := 1 TO 12
            FOR yyy := 1 TO i
               a_zalipodp[ 2, i ] := a_zalipodp[ 2, i ] + a_zalipodp[ 1, yyy ]
            NEXT
         NEXT

         **********************KWARTALNIE*********************
         FOR xxx := 1 TO 12
            a_dochgos[ 1, 3, xxx ] := Max( 0, a_przygos[ 1, 3, xxx ] - a_koszgos[ 1, 3, xxx ] )
            a_dochgos[ 2, 3, xxx ] := Max( 0, a_przygos[ 2, 3, xxx ] - a_koszgos[ 2, 3, xxx ] )
            a_dochgos[ 3, 3, xxx ] := Max( 0, a_przygos[ 3, 3, xxx ] - a_koszgos[ 3, 3, xxx ] )
            a_dochgos[ 4, 3, xxx ] := Max( 0, a_przygos[ 4, 3, xxx ] - a_koszgos[ 4, 3, xxx ] )
            a_dochgos[ 5, 3, xxx ] := Max( 0, a_przygos[ 5, 3, xxx ] - a_koszgos[ 5, 3, xxx ] )
            a_dochnaj[ 1, 3, xxx ] := Max( 0, a_przynaj[ 1, 3, xxx ] - a_kosznaj[ 1, 3, xxx ] )
            a_dochnaj[ 2, 3, xxx ] := Max( 0, a_przynaj[ 2, 3, xxx ] - a_kosznaj[ 2, 3, xxx ] )
            a_pit566[ 3, xxx ] := Max( 0, a_pit5gosp[ 3, xxx ] - a_pit5gosk[ 3, xxx ] )
            a_pit567[ 3, xxx ] := Max( 0, a_pit5najp[ 3, xxx ] - a_pit5najk[ 3, xxx ] )
            a_stragos[ 1, 3, xxx ] := Abs( Max( 0, a_przygos[ 1, 3, xxx ] - a_koszgos[ 1, 3, xxx ] ) )
            a_stragos[ 2, 3, xxx ] := Abs( Max( 0, a_przygos[ 2, 3, xxx ] - a_koszgos[ 2, 3, xxx ] ) )
            a_stragos[ 3, 3, xxx ] := Abs( Max( 0, a_przygos[ 3, 3, xxx ] - a_koszgos[ 3, 3, xxx ] ) )
            a_stragos[ 4, 3, xxx ] := Abs( Max( 0, a_przygos[ 4, 3, xxx ] - a_koszgos[ 4, 3, xxx ] ) )
            a_stragos[ 5, 3, xxx ] := Abs( Max( 0, a_przygos[ 5, 3, xxx ] - a_koszgos[ 5, 3, xxx ] ) )
            a_stranaj[ 1, 3, xxx ] := Abs( Max( 0, a_przynaj[ 1, 3, xxx ] - a_kosznaj[ 1, 3, xxx ] ) )
            a_stranaj[ 2, 3, xxx ] := Abs( Max( 0, a_przynaj[ 2, 3, xxx ] - a_kosznaj[ 2, 3, xxx ] ) )
            a_pit5goss[ 3, xxx ] := Max( 0, a_pit5gosk[ 3, xxx ] - a_pit5gosp[ 3, xxx ] )
            a_pit5najs[ 3, xxx ] := Max( 0, a_pit5najk[ 3, xxx ] - a_pit5najp[ 3, xxx ] )
            a_gosprzy[ 3, xxx ] := a_przygos[ 1, 3, xxx ] + a_przygos[ 2, 3, xxx ] + a_przygos[ 3, 3, xxx ] + a_przygos[ 4, 3, xxx ] + a_przygos[ 5, 3, xxx ] + a_pit5gosp[ 3, xxx ] + a_przywsp[ 3, xxx ]
            a_goskosz[ 3, xxx ] := a_koszgos[ 1, 3, xxx ] + a_koszgos[ 2, 3, xxx ] + a_koszgos[ 3, 3, xxx ] + a_koszgos[ 4, 3, xxx ] + a_koszgos[ 5, 3, xxx ] + a_pit5gosk[ 3, xxx ] + a_koszwsp[ 3, xxx ] - a_rem[ 3, xxx ]
            a_najprzy[ 3, xxx ] := a_przynaj[ 1, 3, xxx ] + a_przynaj[ 2, 3, xxx ] + a_pit5najp[ 3, xxx ]
            a_najkosz[ 3, xxx ] := a_kosznaj[ 1, 3, xxx ] + a_kosznaj[ 2, 3, xxx ] + a_pit5najk[ 3, xxx ]
            a_gosdoch[ 3, xxx ] := Max( 0, a_gosprzy[ 3, xxx ] - a_goskosz[ 3, xxx ] )
            a_gosstra[ 3, xxx ] := Max( 0, a_goskosz[ 3, xxx ] - a_gosprzy[ 3, xxx ] )
            a_najdoch[ 3, xxx ] := Max( 0, a_najprzy[ 3, xxx ] - a_najkosz[ 3, xxx ] )
            a_najstra[ 3, xxx ] := Max( 0, a_najkosz[ 3, xxx ] - a_najprzy[ 3, xxx ] )
            a_pro1doch[ 3, xxx ] := a_dochgos[ 1, 3, xxx ] + a_dochgos[ 2, 3, xxx ] + a_dochgos[ 3, 3, xxx ] + a_dochgos[ 4, 3, xxx ] + a_dochgos[ 5, 3, xxx ] + a_pk3[ 3, xxx ] + a_pit566[ 3, xxx ]
            a_pro1stra[ 3, xxx ] := a_stragos[ 1, 3, xxx ] + a_stragos[ 2, 3, xxx ] + a_stragos[ 3, 3, xxx ] + a_stragos[ 4, 3, xxx ] + a_stragos[ 5, 3, xxx ] + a_pk4[ 3, xxx ] + a_pit5goss[ 3, xxx ]
            a_pro2doch[ 3, xxx ] := a_dochnaj[ 1, 3, xxx ] + a_dochnaj[ 2, 3, xxx ] + a_pk3[ 3, xxx ] + a_pit567[ 3, xxx ]
            a_pro2stra[ 3, xxx ] := a_stranaj[ 1, 3, xxx ] + a_stranaj[ 2, 3, xxx ] + a_pk4[ 3, xxx ] + a_pit5najs[ 3, xxx ]
            a_p51a[ 3, xxx ] := a_STRATY[ 3, xxx ]
            a_p51b[ 3, xxx ] := a_powodz[ 3, xxx ]
            IF spolka->sposob == 'L'
               a_pk5[ 3, xxx ] := a_gosdoch[ 3, xxx ]
               a_p51[ 3, xxx ] := Min( a_STRATY[ 3, xxx ], a_gosdoch[ 3, xxx ] ) + a_powodz[ 3, xxx ]
            ELSE
               a_pk5[ 3, xxx ] := a_gosdoch[ 3, xxx ] + a_najdoch[ 3, xxx ]
               a_p51[ 3, xxx ] := Min( a_STRATY[ 3, xxx ], a_gosdoch[ 3, xxx ] ) + Min( a_STRATY_N[ 3, xxx ], a_najdoch[ 3, xxx ] ) + a_powodz[ 3, xxx ]
            ENDIF
            a_p50[ 3, xxx ] := a_rentalim[ 3, xxx ]
            IF a_P50[ 3, xxx ] > a_pk5[ 3, xxx ]
               a_P50[ 3 ,xxx ] := a_pk5[ 3, xxx ]
               a_P51[ 3 ,xxx ] := 0
            ELSE
               IF a_P50[ 3, xxx ] + a_P51[ 3, xxx ] > a_pk5[ 3, xxx ]
                  a_P51[ 3, xxx ] := a_pk5[ 3, xxx ] - ( a_P50[ 3, xxx ] )
               ENDIF
            ENDIF
            a_pKK7[ 3, xxx ] := a_pk5[ 3, xxx ] - ( a_P50[ 3, xxx ] + a_P51[ 3, xxx ] )
            ***pk6=dochod po odliczeniach
            IF a_P50[ 3, xxx ] > 0
               a_DOCHZWOL[ 3, xxx ] := 0
            ENDIF
            a_wydatkim[ 3, xxx ] := Min( a_wydatkim[ 3, xxx ] + a_dochzwol[ 3, xxx ], a_pkk7[ 3, xxx ] )
            a_pk6[ 3, xxx ] := Max( 0, a_pkk7[ 3, xxx ] - a_wydatkim[ 3, xxx ] )
            ***pk75=p775 odliczenia od podatku
            a_pk75[ 3, xxx ] := a_g21[ 3, xxx ]
            ***pk7=p770 - podstawa
            IF a_gosdoch[ 3, xxx ] > 0
               a_pk7[ 3, xxx ] := a_pk6[ 3, xxx ] + a_pk75[ 3, xxx ]
            ELSE
               IF a_gosdoch[ 3, xxx ] == 0 .AND. a_gosstra[ 3, xxx ] < a_pk75[ 3, xxx ]
                  a_pk7[ 3, xxx ] := a_pk6[ 3, xxx ] + a_pk75[ 3, xxx ] - a_gosstra[ 3, xxx ]
               ELSE
                  a_pk7[ 3, xxx ] := a_pk6[ 3, xxx ]
               ENDIF
            ENDIF
            a_ppodstn[ 3, xxx ] := a_pk7[ 3, xxx ]
            a_pk7[ 3, xxx ] := _round( a_pk7[ 3, xxx ], 0 )
            a_ppodst[ 3, xxx ] := a_pk7[ 3, xxx ]

            *--------------- podatek dochodowy wg tabeli
            dDataNa := hb_Date( Val( param_rok ), xxx, 1 )
            //tab_doch->( dbSetFilter( { || tab_doch->del == '+' .AND. ( tab_doch->dataod <= dDataNa ) .AND. ( ( tab_doch->datado >= dDataNa ) .OR. ( tab_doch->datado == CToD('') ) ) } ) )
            tab_doch->( dbSetFilter( { || ( tab_doch->dataod <= dDataNa ) } ) )
            *IF ObiczKwWl == 'S' .OR. ObiczKwWl == ' '
               SELECT tab_doch
//               SEEK '-'
//               SKIP -1
               tab_doch->( dbGoBottom() )
            *ENDIF
            ppodatek := 0
            pzm := a_ppodst[ 3, xxx ]
            IF spolka->sposob == 'L'
               ppodatek := pzm * ( param_lin / 100 )
               ppodatek := Max( 0, ppodatek )
            ELSE
               *IF ObiczKwWl == 'S' .OR. ObiczKwWl == ' '
                  DO WHILE ! Bof()
                     ppodatek := ppodatek + Max( 0, Min( a_ppodst[ 3, xxx ], pzm ) - podstawa ) * procent / 100
                     pzm := podstawa
                     SKIP -1
                  ENDDO
                  SELECT spolka
                  IF param_kskw == 'N'
                     IF TabDochProcent( a_ppodst[ 3, xxx ], 'tab_doch', Val( param_rok ), xxx, .F. ) = TabDochProcent( 0, 'tab_doch', Val( param_rok ), xxx, .F. )
                        ppodatek := Max( 0, ppodatek - iif( dDataNa < param_kwd, param_kw, param_kw2 ) )
                     ENDIF
                  ELSE
                     ppodatek := Max( 0, ppodatek - iif( dDataNa < param_kwd, param_kw, param_kw2 ) )
                  ENDIF
               *ELSE
                  *ppodatek := TabDochPodatek( pzm, 'tab_doch', Val( param_rok ), xxx, .F. )
               *ENDIF
            ENDIF
            tab_doch->( dbClearFilter() )
            *---------------
            SELECT spolka
            a_pk8[ 3, xxx ] := ppodatek
            IF spolka->sposob == 'L'
               //a_pk9[ 3, xxx ] := Min( a_pk8[ 3, xxx ], a_sumzdro[ 3, xxx ] )
               a_pk9[ 3, xxx ] := 0 // a_pk8[ 3, xxx ]
            ELSE
               //a_pk9[ 3, xxx ] := Min( a_pk8[ 3, xxx ], a_sumzdro[ 3, xxx ] + a_aaa[ 3, xxx ] + a_bbb[ 3, xxx ] + a_inneodpo[ 3, xxx ] )
               a_pk9[ 3, xxx ] := Min( a_pk8[ 3, xxx ], a_aaa[ 3, xxx ] + a_bbb[ 3, xxx ] + a_inneodpo[ 3, xxx ] )
            ENDIF
            a_sumzdro1[ 3, xxx ] := Max( 0, a_pk8[ 3, xxx ] - a_pk9[ 3, xxx ] )
            a_pk12[ 3, xxx ] := iif( xxx <= 3, 0, a_P97MMM[ 3, xxx - 3 ] )
            a_pk13[ 3, xxx ] := _round( Max( 0, a_sumzdro1[ 3, xxx ] - a_pk12[ 3, xxx ] ), 0 )
            a_P885[ 3, xxx ] := a_h385[ 3, xxx ]
            a_P888[ 3, xxx ] := Min( a_pk13[ 3, xxx ], a_h385[ 3, xxx ] - iif( xxx <= 3, 0, a_P887[ 3, xxx - 3 ] ) )
            *for yyy=1 to xxx
            *   a_P887[3,xxx]=a_P887[3,xxx]+iif(yyy<=3,0,a_P888[3,yyy-3])
            *next
            a_P887[ 3, xxx ] := iif( xxx <= 3, 0, a_P887[ 3, xxx - 3 ] ) + a_P888[ 3, xxx ]
            a_P889[ 3, xxx ] := a_pk13[ 3, xxx ] - a_P888[ 3, xxx ]
            a_wartprze[ 3, xxx ] := a_pk13[ 3, xxx ] + a_preman[ 3, xxx ] + a_odseodma[ 3, xxx ] - a_P888[ 3, xxx ]

            *do case
            *case xxx=11 .and. zPITOKRES='K'
            *     a_wartprze[3,xxx]=(a_pk13[3,9])+a_preman[3,xxx]+a_odseodma[3,xxx]-a_P888[3,xxx]
            *case xxx=12 .and. zPITOKRES='K'
            *     a_wartprze[3,xxx]=a_pk13[3,xxx]+a_preman[3,xxx]+a_odseodma[3,xxx]-a_P888[3,xxx]
            *case xxx<11 .and. zPITOKRES='K'
            *     a_wartprze[3,xxx]=a_pk13[3,xxx]+a_preman[3,xxx]+a_odseodma[3,xxx]-a_P888[3,xxx]
            *endcase

            SELECT dane_mc
            SEEK '+' + zident + Str( xxx, 2 )
            IF del == '+' .AND. ident == zident .AND. mc == Str( xxx, 2 )
               BlokadaR()
               IF zPITOKRES == 'K'
                  REPLACE zaliczkap WITH a_wartprze[ 3, xxx ]
                  a_zalipodp[ 1, xxx ] := a_wartprze[ 3, xxx ]
               ELSE
                  REPLACE zaliczkap WITH 0
                  a_zalipodp[ 1, xxx ] := 0
               ENDIF
               COMMIT
               UNLOCK
            ENDIF

            *wait str(a_wartprze[2,xxx],12,2)

            a_P97MMM[ 3, xxx ] := a_pk12[ 3, xxx ] + a_pk13[ 3, xxx ]
         NEXT
         FOR i := 1 TO 12
             a_zalipodp[ 3, i ] := 0
         NEXT
         FOR i := 1 TO 12
            FOR yyy := 1 TO i
               a_zalipodp[ 3, i ] := a_zalipodp[ 3, i ] + a_zalipodp[ 1, yyy ]
            NEXT
         NEXT

         SELECT spolka
         IF zPITOKRES == 'K'
            okrpod := 3
         ELSE
            okrpod := 2
         ENDIF

         dzial_g[ 1, 6 ] := a_przywsp[ okrpod, Val( miesiac ) ]
         dzial_g[ 1, 7 ] := a_koszwsp[ okrpod, Val( miesiac ) ] - a_rem[ okrpod, Val( miesiac ) ]
         dzial_g[ 1, 8 ] := Max( 0, dzial_g[ 1, 6 ] - dzial_g[ 1, 7 ] )
         dzial_g[ 1, 9 ] := Max( 0, dzial_g[ 1, 7 ] - dzial_g[ 1, 6 ] )
         SPOL := 2
         *****************************************************************************
         IF ! Empty( g_rodzaj1 )
            dzial_g[ spol, 1 ] := rozrzut( g_nip1 )
            dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon1, 3, 9 ) )
            dzial_g[ spol, 3 ] := g_rodzaj1
            dzial_g[ spol, 4 ] := g_miejsc1
            *dzial_g[spol,5]=zg_udzial1
            dzial_g[ spol, 6 ] := a_przygos[ 1, okrpod, Val( miesiac ) ]
            dzial_g[ spol, 7 ] := a_koszgos[ 1, okrpod, Val( miesiac ) ]
            dzial_g[ spol, 8 ] := Max( 0, dzial_g[ spol, 6 ] - dzial_g[ spol, 7 ] )
            dzial_g[ spol, 9 ] := Max( 0, dzial_g[ spol, 7 ] - dzial_g[ spol, 6 ] )
            *dzial_g[spol,8]=a_dochgos[1,okrpod,val(miesiac)]
            *dzial_g[spol,9]=a_stragos[1,okrpod,val(miesiac)]
            SPOL++
         ENDIF
         IF SPOL < 7
            IF ! Empty( g_rodzaj2 )
               dzial_g[ spol, 1 ] := rozrzut( g_nip2 )
               dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon2, 3, 9 ) )
               dzial_g[ spol, 3 ] := g_rodzaj2
               dzial_g[ spol, 4 ] := g_miejsc2
               *dzial_g[spol,5]=zg_udzial2
               dzial_g[ spol, 6 ] := a_przygos[ 2, okrpod, Val( miesiac ) ]
               dzial_g[ spol, 7 ] := a_koszgos[ 2, okrpod, Val( miesiac ) ]
               dzial_g[ spol, 8 ] := Max( 0, dzial_g[ spol, 6 ] - dzial_g[ spol, 7 ] )
               dzial_g[ spol, 9 ] := Max( 0, dzial_g[ spol, 7 ] - dzial_g[ spol, 6 ] )
               *dzial_g[spol,8]=a_dochgos[2,okrpod,val(miesiac)]
               *dzial_g[spol,9]=a_stragos[2,okrpod,val(miesiac)]
               SPOL++
            ENDIF
         ENDIF
         IF SPOL < 7
            IF ! Empty( g_rodzaj3 )
               dzial_g[ spol, 1 ] := rozrzut( g_nip3 )
               dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon3, 3, 9 ) )
               dzial_g[ spol, 3 ] := g_rodzaj3
               dzial_g[ spol, 4 ] := g_miejsc3
               *dzial_g[spol,5]=zg_udzial3
               dzial_g[ spol, 6 ] := a_przygos[ 3, okrpod, Val( miesiac ) ]
               dzial_g[ spol, 7 ] := a_koszgos[ 3, okrpod, Val( miesiac ) ]
               dzial_g[ spol, 8 ] := Max( 0, dzial_g[ spol, 6 ] - dzial_g[ spol, 7 ] )
               dzial_g[ spol, 9 ] := Max( 0, dzial_g[ spol, 7 ] - dzial_g[ spol, 6 ] )
               *dzial_g[spol,8]=a_dochgos[3,okrpod,val(miesiac)]
               *dzial_g[spol,9]=a_stragos[3,okrpod,val(miesiac)]
               SPOL++
            ENDIF
         ENDIF
         IF SPOL < 7
            IF ! Empty( g_rodzaj4 )
               dzial_g[ spol, 1 ] := rozrzut( g_nip4 )
               dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon4, 3, 9 ) )
               dzial_g[ spol, 3 ] := g_rodzaj4
               dzial_g[ spol, 4 ] := g_miejsc4
               *dzial_g[spol,5]=zg_udzial3
               dzial_g[ spol, 6 ] := a_przygos[ 4, okrpod, Val( miesiac ) ]
               dzial_g[ spol, 7 ] := a_koszgos[ 4, okrpod, Val( miesiac ) ]
               dzial_g[ spol, 8 ] := Max( 0, dzial_g[ spol, 6 ] - dzial_g[ spol, 7 ] )
               dzial_g[ spol, 9 ] := Max( 0, dzial_g[ spol, 7 ] - dzial_g[ spol, 6 ] )
               *dzial_g[spol,8]=a_dochgos[3,okrpod,val(miesiac)]
               *dzial_g[spol,9]=a_stragos[3,okrpod,val(miesiac)]
               SPOL++
            ENDIF
         ENDIF
         IF SPOL < 7
            IF ! Empty( g_rodzaj5 )
               dzial_g[ spol, 1 ] := rozrzut( g_nip5 )
               dzial_g[ spol, 2 ] := rozrzut( SubStr( g_regon5, 3, 9 ) )
               dzial_g[ spol, 3 ] := g_rodzaj5
               dzial_g[ spol, 4 ] := g_miejsc5
               *dzial_g[spol,5]=zg_udzial3
               dzial_g[ spol, 6 ] := a_przygos[ 5, okrpod, Val( miesiac ) ]
               dzial_g[ spol, 7 ] := a_koszgos[ 5, okrpod, Val( miesiac ) ]
               dzial_g[ spol, 8 ] := Max( 0, dzial_g[ spol, 6 ] - dzial_g[ spol, 7 ] )
               dzial_g[ spol, 9 ] := Max( 0, dzial_g[ spol, 7 ] - dzial_g[ spol, 6 ] )
               *dzial_g[spol,8]=a_dochgos[3,okrpod,val(miesiac)]
               *dzial_g[spol,9]=a_stragos[3,okrpod,val(miesiac)]
               SPOL++
            ENDIF
         ENDIF
         *  if SPOL<4
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
         SPOL := 1
         IF ! Empty( n_przedm1 )
            P120 := n_przedm1
            P121 := n_miejsc1
            p123 := a_przynaj[ 1, okrpod, Val( miesiac ) ]
            p124 := a_kosznaj[ 1, okrpod, Val( miesiac ) ]
            dzial_g[ spol, 8 ] := Max( 0, dzial_g[ spol, 6 ] - dzial_g[ spol, 7 ] )
            dzial_g[ spol, 9 ] := Max( 0, dzial_g[ spol, 7 ] - dzial_g[ spol, 6 ] )
            p125 := Max( 0, p123 - p124 )
            p126 := Max( 0, p124 - p123 )
            SPOL++
         ENDIF
         IF ! Empty( n_przedm2 )
            P127 := n_przedm2
            P128 := n_miejsc2
            p130 := a_przynaj[ 2, okrpod, Val( miesiac ) ]
            p131 := a_kosznaj[ 2, okrpod, Val( miesiac ) ]
            p132 := Max( 0, p130 - p131 )
            p133 := Max( 0, p131 - p130 )
            SPOL++
         ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/



PROCEDURE infodoch()

   *################################# GRAFIKA ##################################
   @  3, 0 CLEAR TO 22, 79
   ColInf()
   @  3, 0 SAY '[B,W]-wplata gotowkowa   [L,N]-przelew   [P]-wplata pocztowa   [D]-wydruk ekranu'
   ColStd()
   IF spolka->sposob == 'L'
      @  4, 0 SAY '                                                                                '
      @  5, 0 SAY '                           Przychody      Koszty        Dochod        Strata    '
      @  6, 0 SAY ' 1 Dzia&_l.alno&_s.&_c. gospodar..                                                       '
      @  7, 0 SAY '                                                                                '
      @  8, 0 SAY '                   RAZEM                                                        '
      @  9, 0 SAY ' 2 Dochod po odliczeniu strat.................................................. '
      @ 10, 0 SAY ' 3 Skladki na ubezpieczenia spoleczne......(ZUS narast:............)........... '
      @ 11, 0 SAY ' 4 Dochod po odliczeniu strat i skladek........................................ '
      @ 12, 0 SAY ' 5 Kwoty zwiekszajace podstawe opodatkowania/zmniejszajace strate.............. '
      @ 13, 0 SAY ' 6 Podstawa obliczenia podatku................................................. '
      @ 14, 0 SAY ' 7 Podatek od podstawy......................................................... '
      @ 15, 0 SAY ' 8 Odliczenia od podatku....................................................... '
      @ 16, 0 SAY ' 9 Podatek po odliczeniach od poczatku roku.................................... '
      IF zPITOKRES == 'K'
         okrpod := 3
         @ 17, 0 SAY '10 Zaliczki za pop.okres(uzytk.:............,......................)........... '
         @ 18, 0 SAY '11 Nalezna zaliczka za kwartal................................................. '
      ELSE
         okrpod := 2
         @ 17, 0 SAY '10 Zaliczki za pop.okres(uzytk.:............,wyliczone:............)........... '
         @ 18, 0 SAY '11 Nalezna zaliczka za miesiac................................................. '
      ENDIF
      *@ 17,0 say [10 Zaliczki za pop.mies.(uzytk.:............,wyliczone:............)........... ]
      *@ 17,0 say [10 Suma naleznych zaliczek za poprzednie miesiace.............................. ]
      @ 19, 0 SAY '12 Ograniczenie wysokosci zaliczek/Zaniechanie poboru podatku.................. '
      @ 20, 0 SAY '13 Nalezny zryczaltowany podatek dochodowy od dochodu z remanentu likwidacyjnego'
      @ 21, 0 SAY '14 Kwota odsetek naliczonych za nabycie lub wytworzenie srodkow trwalych....... '
      @ 22, 0 SAY '15 Podatek do zap&_l.aty.......................................................... '
      ColInf()
      IF zPITOKRES == 'K'
         center( 4, dos_c( ' Podatnik - ' + AllTrim( SubStr( AllTrim( naz_imie ), 1, 46 ) ) + ' (liniowo,kwartalnie) ' ) )
      ELSE
         center( 4, dos_c( ' Podatnik - ' + AllTrim( SubStr( AllTrim( naz_imie ), 1, 45 ) ) + ' (liniowo,miesiecznie) ' ) )
      ENDIF
      ColStd()
   ELSE
      @  4, 0 SAY '                                                                                '
      @  5, 0 SAY '                           Przychody      Koszty        Dochod        Strata    '
      @  6, 0 SAY ' 1 Dzia&_l.alno&_s.&_c. gospodar..                                                       '
      @  7, 0 SAY ' 2 Najem,dzier&_z.awa,itp...                                                       '
      @  8, 0 SAY '                   RAZEM                                                        '
      @  9, 0 SAY ' 3 Dochod po odliczeniu dochodu zwolnionego i strat............................ '
      @ 10, 0 SAY ' 4 Odliczenia od dochodu...................(ZUS narast:............)........... '
      @ 11, 0 SAY ' 5 Dochod po odliczeniu ulg i zwolnien......................................... '
      @ 12, 0 SAY ' 6 Kwoty zwiekszajace podstawe opodatkowania/zmniejszajace strate.............. '
      @ 13, 0 SAY ' 7 Podstawa obliczenia podatku................................................. '
      @ 14, 0 SAY ' 8 Podatek od podstawy......................................................... '
      @ 15, 0 SAY ' 9 Odliczenia od podatku....................................................... '
      @ 16, 0 SAY '10 Podatek po odliczeniach od poczatku roku.................................... '
      IF zPITOKRES == 'K'
         okrpod := 3
         @ 17, 0 SAY '11 Zaliczki za pop.okres....................(uzytkowni:............)........... '
         @ 18, 0 SAY '12 Nalezna zaliczka za kwartal................................................. '
      ELSE
         okrpod := 2
         @ 17, 0 SAY '11 Zaliczki za pop.okres....................(uzytkowni:............)........... '
         @ 18, 0 SAY '12 Nalezna zaliczka za miesiac................................................. '
      ENDIF
      @ 19, 0 SAY '13 Ograniczenie wysokosci zaliczek/Zaniechanie poboru podatku.................. '
      @ 20, 0 SAY '14 Nalezny zryczaltowany podatek dochodowy od dochodu z remanentu likwidacyjnego'
      @ 21, 0 SAY '15 Kwota odsetek naliczonych za nabycie lub wytworzenie srodkow trwalych....... '
      @ 22, 0 SAY '16 Podatek do zap&_l.aty.......................................................... '
      ColInf()
      IF zPITOKRES == 'K'
         center( 4, dos_c( ' Podatnik - ' + AllTrim( SubStr( AllTrim( naz_imie ), 1, 41 ) ) + ' (progresywnie,kwartalnie) ' ) )
      ELSE
         center( 4, dos_c( ' Podatnik - ' + AllTrim( SubStr( AllTrim( naz_imie ), 1, 40 ) ) + ' (progresywnie,miesiecznie) ' ) )
      ENDIF
      ColStd()
   ENDIF
   SET COLOR TO +w
   @  6, 25 SAY a_gosprzy[ okrpod, Val( miesiac ) ] PICTURE RPICE
   @  6, 40 SAY a_goskosz[ okrpod, Val( miesiac ) ] PICTURE RPICE
   @  6, 55 SAY a_gosdoch[ okrpod, Val( miesiac ) ] PICTURE RPIC
   @  6, 68 SAY a_gosstra[ okrpod, Val( miesiac ) ] PICTURE RPIC
   IF spolka->sposob == 'L'
      @  7, 0 SAY '                                                                                '
   ELSE
      @  7, 25 SAY a_najprzy[ okrpod, Val( miesiac ) ] PICTURE RPICE
      @  7, 40 SAY a_najkosz[ okrpod, Val( miesiac ) ] PICTURE RPICE
      @  7, 55 SAY a_najdoch[ okrpod, Val( miesiac ) ] PICTURE RPIC
      @  7, 68 SAY a_najstra[ okrpod, Val( miesiac ) ] PICTURE RPIC
   ENDIF
   @  8, 55 SAY a_pK5[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @  9, 68 SAY a_pKK7[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 10, 55 SAY a_sumemer[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 10, 68 SAY a_wydatkim[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 11, 68 SAY a_pK6[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 12, 68 SAY a_pk75[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 13, 68 SAY a_pK7[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 14, 68 SAY a_pK8[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   //@ 15, 55 SAY a_sumzdro[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 15, 68 SAY a_pK9[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 16, 68 SAY a_sumzdro1[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 17, 55 SAY a_zalipod[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   *if zPITOKRES='M'
   *   @ 17,55 say iif(val(miesiac)=1,0,a_zalipodp[2,val(miesiac)-1]) pict DRPIC
   *endif
   @ 17, 68 SAY a_pk12[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 18, 68 SAY a_pK13[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 19, 68 SAY a_P888[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 20, 68 SAY a_preman[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 21, 68 SAY a_odseodma[ okrpod, Val( miesiac ) ] PICTURE DRPIC
   @ 22, 68 SAY a_wartprze[ okrpod, Val( miesiac ) ] PICTURE DRPIC

   *if zPITOKRES='M'
   *   if miesiac='11'
   *      @ 22,22 say '(UWAGA !!! podw&_o.jna zaliczka)'
   *   endif
   *else
   *   if miesiac='11'
   *      @ 22,22 say '(UWAGA !!! wp&_l.a&_c. jak za poprzedni kwarta&_l. !!!)'
   *   endif
   *endif
   SET COLOR TO
   SELE spolka
   *################################## PRZEKAZ #################################
   zNAZWA_PLA := naz_imie
   zULICA_PLA := AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + iif( Len( AllTrim( nr_mieszk ) ) > 0, '/' + AllTrim( nr_mieszk ), '' )
   zMIEJSC_PLA := AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_zam )
   zBANK_PLA := firma->bank
   zKONTO_PLA := firma->nr_konta
   ztr1 := PadR( StrTran( AllTrim( nip ), '-', '' ), 14 )
   ztr2 := ' N  '
   IF zPITOKRES='M'
      ztr3 := ' ' + SubStr( param_rok, 3, 2 ) + 'M' + StrTran( PadL( miesiac, 2 ), ' ', '0' ) + '  '
   ELSE
      ztr3 := ' ' + SubStr( param_rok, 3, 2 ) + 'K' + StrTran( Str( pitKW, 2 ), ' ', '0' ) + '  '
   ENDIF
   IF spolka->sposob == 'L'
      ztr4 := 'PIT5L   '
   ELSE
      ztr4 := 'PIT5    '
   ENDIF
   zTRESC := ztr1 + ztr2 + ztr3 + ztr4

   SELECT 7
   DO WHILE ! dostep( 'URZEDY' )
   ENDDO
   SET INDEX TO urzedy
   GO spolka->skarb
   zNAZWA_WIE := 'URZ&__A.D SKARBOWY ' + AllTrim( URZAD )
   zULICA_WIE := AllTrim( ULICA ) + ' ' + AllTrim( NR_DOMU )
   zMIEJSC_WIE := AllTrim( KOD_POCZT ) + ' ' + AllTrim( MIEJSC_US )
   zBANK_WIE := BANK
   zKONTO_WIE := KONTODOCH

   IF nr_uzytk == 108
      csvpit5()
   ENDIF

   SELECT 7
   CLEAR TYPE
   kkk := Inkey( 0, INKEY_KEYBOARD )
   zPodatki := .T.
   DO CASE
   CASE kkk == 68 .OR. kkk == 100

      DrukujEkran( { PadC( AllTrim( firma->nazwa ), 80 ), iif( zPITOKRES == 'K', ;
         PadC( 'Kwarta&_l. ' + param_rok + '.' + StrTran( Str( pitKW, 2 ), ' ', '0' ), 80 ), ;
         PadC( 'Miesi&_a.c ' + param_rok + '.' + StrTran( PadL( miesiac, 2 ), ' ', '0' ), 80 ) ) }, , 4, 22 )

   CASE kkk == 87 .OR. kkk == 119 .OR. kkk == 66 .OR. kkk == 98

      zNAZWA_PLA := zNAZWA_PLA + Space( 30 )
      @ 23, 0 CLEAR TO 23, 79
      @ 23, 0 SAY 'Nazwa wp&_l.acaj&_a.cego' GET zNAZWA_PLA PICTURE repl( 'X', 60 )
      read_()

      SAVE SCREEN TO scr_
      zKWOTA := a_wartprze[ okrpod, Val( miesiac ) ]
      AFill( nazform, '' )
      AFill( strform, 0 )
      nazform[ 1 ] := 'WPLATN'
      strform[ 1 ] := 1
      form( nazform, strform, 1 )
      RESTORE SCREEN FROM scr_

   CASE kkk == 78 .OR. kkk == 110 .OR. kkk == 76 .OR. kkk == 108

      zNAZWA_PLA := zNAZWA_PLA + Space( 30 )
      @ 23, 0 CLEAR TO 23, 79
      @ 23, 0 SAY 'Nazwa wp&_l.acaj&_a.cego' GET zNAZWA_PLA PICTURE repl( 'X', 60 )
      read_()

      SAVE SCREEN TO scr_
      zKWOTA := a_wartprze[ okrpod, Val( miesiac ) ]
      AFill( nazform, '' )
      AFill( strform, 0 )
      nazform[ 1 ] := 'PRZELN'
      strform[ 1 ] := 1
      form( nazform, strform, 1 )
      RESTORE SCREEN FROM scr_
   case kkk=80 .or. kkk=112

      zNAZWA_PLA := zNAZWA_PLA + Space( 30 )
      @ 23, 0 CLEAR TO 23, 79
      @ 23, 0 SAY 'Nazwa wp&_l.acaj&_a.cego' GET zNAZWA_PLA PICTURE repl( 'X', 60 )
      read_()

      SAVE SCREEN TO scr3
      przek( zNAZWA_WIE, ;
         zNAZWA_PLA, ;
         zULICA_WIE, ;
         zULICA_PLA, ;
         zMIEJSC_WIE, ;
         zMIEJSC_PLA, ;
         zBANK_WIE, ;
         zKONTO_WIE, ;
         a_wartprze[ okrpod, Val( miesiac ) ], ;
         zTRESC )
      RESTORE SCREEN FROM scr3
   ENDCASE
   zPodatki := .F.
   SELECT spolka

   *miesiac=tmpmiesiac
   RETURN

*############################################################################
****************************
PROCEDURE CSVPIT5()
****************************

   //tworzenie bazy roboczej

   SAVE SCREEN TO _csvscre_

   ColInb()
   @ 24, 0 CLEAR
   center( 24, 'Preparuj&_e. dane do internetu. Prosz&_e. czeka&_c....' )
   SET COLOR TO


   _konc_ := SubStr( param_rok, 3, 2 ) + StrTran( PadL( miesiac, 2 ), ' ', '0' )
   _plik_ := 'PIT5' + _konc_



   IF File( _plik_ + '.dbf' ) == .F.
      *wait 'brak pliku dbf'
      dbCreate( _plik_, {;
         {"NIPFIRMY", "C", 10, 0 } , ;
         {"NIPPODAT", "C", 10, 0 } , ;
         {"PRZYCHODY","N", 15, 2 } , ;
         {"ROZCHODY", "N", 15, 2 } , ;
         {"DOCHOD",   "N", 15, 2 } , ;
         {"PODATEK",  "N", 15, 2 } , ;
         {"DATAAKT",  "D",  8, 0 } } )
   ENDIF
   SELECT 11
   IF dostepex( _plik_ )
      INDEX ON nipfirmy + nippodat TO &_plik_
      GO TOP
      IF Len( AllTrim( StrTran( firma->nip, '-', '' ) ) + AllTrim( ztr1 ) ) == 20
         SEEK AllTrim( StrTran( firma->nip, '-', '' ) ) + AllTrim( ztr1 )
         IF Found()
            REPLACE PRZYCHODY WITH gosprzy + najprzy, ROZCHODY WITH goskosz + najkosz, DOCHOD WITH k5, ;
               PODATEK WITH a_wartprze[ okrpod, Val( miesiac ) ], DATAAKT WITH Date()
            commit_()
         ELSE
            APPEND BLANK
            REPLACE NIPFIRMY WITH AllTrim( StrTran( firma->nip, '-', '' ) ), NIPPODAT WITH AllTrim( ztr1 )
            REPLACE PRZYCHODY WITH gosprzy + najprzy, ROZCHODY WITH goskosz + najkosz, DOCHOD WITH k5, ;
               PODATEK WITH a_wartprze[ okrpod, Val( miesiac ) ], DATAAKT WITH Date()
            commit_()
         ENDIF
         GO TOP
         COPY TO &_plik_ ALL DELIMITED
      ELSE
         komun( 'Niew&_l.a&_s.ciwe d&_l.ugo&_s.ci NIP firmy i/lub podatnika. Sprawd&_x. i popraw.' )
      ENDIF
   ELSE
      komun( 'Nie mog&_e. zaktualizowa&_c. pliku exportu CSV.' )
   ENDIF

   USE

   REST SCREEN FROM _csvscre_

   RETURN
