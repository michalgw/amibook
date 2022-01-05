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

PROCEDURE Suma_McR()

   SWITCH GraficznyCzyTekst()
   CASE 1
      Suma_McRGraf()
      EXIT
   CASE 2
      Suma_McRTekst()
      EXIT
   ENDSWITCH

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE Suma_McRTekst()

   PRIVATE _grupa1, _grupa2, _grupa3, _grupa4, _grupa5, _grupa, _koniec, ;
      _szerokosc, _numer, _lewa, _prawa, _strona, _czy_mon, _czy_close
   PRIVATE _t1, _t2, _t3, _t4, _t5, _t6, _t7, _t8, _t9, _t10, _t11, _t12, ;
      _t13,_t14,_t15

   BEGIN SEQUENCE
      @ 1, 47 SAY Space( 10 )
      *-----parametry wewnetrzne-----
      _papsz := 1
      _lewa := 1
      _prawa := 130
      _strona := .F.
      _czy_mon := .T.
      _czy_close := .T.
      czesc := 1
      *------------------------------
      _szerokosc := 130
      _koniec := "del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      SELECT 2
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
      ELSE
         SELECT 1
         BREAK
      ENDIF
      SELECT 1
      IF Dostep( 'SUMA_MC' )
         SET INDEX TO suma_mc
         SEEK '+' + ident_fir
      ELSE
         SELECT 1
         BREAK
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      IF &_koniec
         kom( 3, '*w', 'b r a k   d a n y c h' )
         BREAK
      ENDIF

      mon_drk( 'ö' + ProcName() )
      IF _mon_drk # 1
         _lewa := 1
         _prawa := 130
      ENDIF

      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      SELECT firma
      k1 := AllTrim( nazwa )
      kk1 := scal( miejsc + ' ul.' + ulica + ' ' + nr_domu + iif( Empty( nr_mieszk ), ' ', '/' ) + nr_mieszk )
      SELECT suma_mc
      *k1=k1+space(80-len(k1))
      SUSLUGI := Str( STAW_USLU * 100, 5, 2 )
      SPROD := Str( STAW_PROD * 100, 5, 2 )
      SHANDEL := Str( STAW_HAND * 100, 5, 2 )
      SRY20 := Str( STAW_RY20 * 100, 5, 2 )
      SRY17 := Str( STAW_RY17 * 100, 5, 2 )
      SRY10 := Str( STAW_RY10 * 100, 5, 2 )
      SRYK07 := Str( staw_rk07 * 100, 5, 2 )

      k5opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory20, 1, 12 ) ) ) + ')', 14 )
      k6opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory17, 1, 12 ) ) ) + ')', 14 )
      k7opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ork09, 1, 12 ) ) ) + ')', 14 )
      k8opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ouslu, 1, 12 ) ) ) + ')', 14 )
      k9opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ork10, 1, 12 ) ) ) + ')', 14 )
      k10opis := PadC( '(' + Lower( AllTrim( SubStr( staw_oprod, 1, 12 ) ) ) + ')', 14 )
      k11opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ohand, 1, 12 ) ) ) + ')', 14 )
      k12opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ork07, 1, 12 ) ) ) + ')', 14 )
      k13opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory10, 1, 12 ) ) ) + ')', 14 )

      mon_drk( '          ' + k1 )
      mon_drk( '          ' + kk1 )
      mon_drk( '         ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      mon_drk( ' Rok     ³                               Kwota przychodu opodatkowanego wg stawki                                 ³    Og¢ˆem    ³' )
      mon_drk( ' ewiden- ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´   przychody  ³' )
      mon_drk( ' cyjny   ³    '+sRY20+' %   ³    '+sRY17+' %   ³   '+sUSLUGI+' %    ³   '+sPROD+' %    ³   '+sHANDEL+' %    ³   '+sRYK07+' %    ³   '+sRY10+' %    ³  (5+6+7+8+9  ³' )
      mon_drk( ' '+param_rok+'    ³' + k5opis + '³' + k6opis + '³' + k7opis + '³' + k8opis + '³' + k9opis + '³' + k10opis + '³' + k11opis + '³    +10+11)   ³' )
      mon_drk( '         ³      (5)     ³      (6)     ³      (7)     ³      (8)     ³      (9)     ³     (10)     ³      (11)    ³      (12)    ³' )
      mon_drk( 'ÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´' )
      STORE 0 TO s0_2, s0_3, s0_4, s0_4a, s0_4b, s0_4c, s0_5, s0_4d
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa := .T.
      DO WHILE .NOT. &_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k1 := SubStr( miesiac( Val( mc ) ), 1, 9 )
         k2 := uslugi
         k3 := wyr_tow
         k4 := handel
         k4a := ry20
         k4b := ry17
         k4c := ry10
         k4d := ryk07
         k4e := ryk09
         k4f := ryk10
         k5 := k2 + k3 + k4 + k4a + k4b + k4c + k4d + k4e + k4f
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s0_2 := s0_2 + k2
         s0_3 := s0_3 + k3
         s0_4 := s0_4 + k4
         s0_4a := s0_4a + k4a
         s0_4b := s0_4b + k4b
         s0_4c := s0_4c + k4c
         s0_5 := s0_5 + k5
         s0_4d := s0_4d + k4d
         k2 := Str( k2, 12, 2 )
         k3 := Str( k3, 12, 2 )
         k4 := Str( k4, 12, 2 )
         k4a := Str( k4a, 12, 2 )
         k4b := Str( k4b, 12, 2 )
         k4c := Str( k4c, 12, 2 )
         k4d := Str( k4d, 12, 2 )
         k5 := Str( k5, 12, 2 )
         mon_drk( k1 + '³ ' + k4a + ' ³ ' + k4b + ' ³ ' + k2 + ' ³ ' + k3 + ' ³ ' + k4 + ' ³ ' + k4d + ' ³ ' + k4c + ' ³ ' + k5 + ' ³')
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer := 0
         _grupa := .F.
      ENDDO
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'ÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´' )
      mon_drk( 'R A Z E M³ '+str(s0_4a,12,2)+' ³ '+str(s0_4b,12,2)+' ³ '+str(s0_2,12,2)+' ³ '+str(s0_3,12,2)+' ³ '+str(s0_4,12,2)+' ³ '+str(s0_4d,12,2)+' ³ '+str(s0_4c,12,2)+' ³ '+str(s0_5,12,2)+' ³' )
      mon_drk( 'ÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ' )
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'þ' )
   END
   IF _czy_close
      close_()
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE Suma_McRGraf()

   LOCAL aDane := {=>}, aPoz

   BEGIN SEQUENCE
      _koniec := "del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      SELECT 2
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
      ELSE
         SELECT 1
         BREAK
      ENDIF
      SELECT 1
      IF Dostep( 'SUMA_MC' )
         SET INDEX TO suma_mc
         SEEK '+' + ident_fir
      ELSE
         SELECT 1
         BREAK
      ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      IF &_koniec
         kom( 3, '*w', 'b r a k   d a n y c h' )
         BREAK
      ENDIF

      SELECT firma
      aDane[ 'firma' ] := AllTrim( nazwa )
      aDane[ 'adres' ] := scal( miejsc + ' ul.' + ulica + ' ' + nr_domu + iif( Empty( nr_mieszk ), ' ', '/' ) + nr_mieszk )
      aDane[ 'rok' ] := param_rok
      SELECT suma_mc

      aDane[ 'staw_ry20' ] := staw_ry20 * 100
      aDane[ 'staw_ry17' ] := staw_ry17 * 100
      aDane[ 'staw_ry10' ] := staw_ry10 * 100
      aDane[ 'staw_hand' ] := staw_hand * 100
      aDane[ 'staw_prod' ] := staw_prod * 100
      aDane[ 'staw_uslu' ] := staw_uslu * 100
      aDane[ 'staw_rk07' ] := staw_rk07 * 100
      aDane[ 'staw_rk09' ] := staw_rk09 * 100
      aDane[ 'staw_rk10' ] := staw_rk10 * 100
      aDane[ 'staw_ory20' ] := AllTrim( staw_ory20 )
      aDane[ 'staw_ory17' ] := AllTrim( staw_ory17 )
      aDane[ 'staw_ory10' ] := AllTrim( staw_ory10 )
      aDane[ 'staw_ohand' ] := AllTrim( staw_ohand )
      aDane[ 'staw_oprod' ] := AllTrim( staw_oprod )
      aDane[ 'staw_ouslu' ] := AllTrim( staw_ouslu )
      aDane[ 'staw_ork07' ] := AllTrim( staw_ork07 )
      aDane[ 'staw_ork09' ] := AllTrim( staw_ork09 )
      aDane[ 'staw_ork10' ] := AllTrim( staw_ork10 )

      aDane[ 'poz' ] := {}

      DO WHILE .NOT. &_koniec

         aPoz := {=>}

         aPoz[ 'k1' ] := miesiac( Val( mc ) )
         aPoz[ 'k5' ] := ry20
         aPoz[ 'k6' ] := ry17
         aPoz[ 'k7' ] := ryk09
         aPoz[ 'k8' ] := uslugi
         aPoz[ 'k9' ] := ryk10
         aPoz[ 'k10' ] := wyr_tow
         aPoz[ 'k11' ] := handel
         aPoz[ 'k12' ] := ryk07
         aPoz[ 'k13' ] := ry10
         aPoz[ 'k14' ] := ry20 + ry17 + uslugi + wyr_tow + handel + ryk07 + ry10 + ryk09 + ryk10

         AAdd( aDane[ 'poz' ], aPoz )

         SKIP

      ENDDO

      FRDrukuj( 'frf\sumamcr.frf', aDane )

   END
   close_()

   RETURN NIL

/*----------------------------------------------------------------------*/

