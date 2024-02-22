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

PROCEDURE DoWewW()

   PRIVATE _grupa1, _grupa2, _grupa3, _grupa4, _grupa5, _grupa, _koniec, _szerokosc, _numer, _lewa, _prawa, _strona, _czy_mon, _czy_close
   PRIVATE _t1, _t2, _t3, _t4, _t5, _t6, _t7, _t8, _t9, _t10, _t11, _t12, _t13, _t14, _t15

   BEGIN SEQUENCE
      @ 1, 47 SAY Space( 10 )
      *-----parametry wewnetrzne-----
      _papsz := 1
      _lewa := 1
      _prawa := 119
      _strona := .F.
      _czy_mon := .T.
      _czy_close := .F.
      czesc := 1
      *------------------------------
      _szerokosc := 119
      _koniec := "del#[+].or.firma#ident_fir.or.zzestaw#zestaw"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      SAVE SCREEN TO pardow
      zdata := data
      znrdok := nrdok
      zzestaw := zestaw
      SET CURSOR ON
      @ 10, 23 CLEAR TO 14, 57
      @ 10, 23 TO 14, 57
      @ 11, 25 SAY '     Pozycje z zestawu ' + zzestaw
      @ 12, 25 SAY 'drukowa&_c. jako dow&_o.d wewn&_e.trzny'
      @ 13, 25 SAY 'nr            z dnia           '
      @ 13, 28 GET znrdok pict '!!!!!!!!!!'
      @ 13, 46 GET zdata pict '@D'
      READ
      SET CURSOR OFF
      RESTORE SCREEN FROM pardow
      stronap := 1
      stronak := 99999
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      SELECT 5
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
      ELSE
         SELECT dowew
         BREAK
      ENDIF
      liczba := 0
      IF LastKey() == 27
         SELECT dowew
         BREAK
      ENDIF
      SELECT dowew
      SEEK '+' + ident_fir + zzestaw
      strona := 0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      IF &_koniec
         kom( 3, '*w', 'b r a k   d a n y c h' )
         BREAK
      ENDIF
      DO WHILE .NOT. &_koniec
         IF drukowac
            BlokadaR()
            REPLACE DATA WITH zdata, nrdok WITH znrdok
            COMMIT
            UNLOCK
         ENDIF
         SKIP
      ENDDO
      mon_drk( 'ö' + ProcName() )
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      STORE 0 TO sum7
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      SELECT dowew
      SEEK '+' + ident_fir + zzestaw
      k1 := DToC( DATA )
      k2 := nrdok
      k3 := firma->nazwa
      k31 := AllTrim( firma->miejsc )
      k4 := Int( strona / Max( 1, _druk_2 - 9 ) ) + 1
      mon_drk( 'Firma: ' + k3 + Space( 14 ) + PadL( k31 + ', ' + k1, 37 ) )
      mon_drk( '                                            DOW&__O.D WEWN&__E.TRZNY NR ' + k2 )
      mon_drk( 'ÚÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      mon_drk( '³L.p³                                                O P I S                                             ³   WARTO&__S.&__C.  ³' )
      mon_drk( '³(1)³                                                  (2)                                               ³     (3)    ³' )
      mon_drk( 'ÀÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ' )
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      SELECT dowew
      DO WHILE .NOT. &_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         IF drukowac
            liczba := liczba + 1
            k1 := Str( liczba, 3 )
            k2 := opis
            k3 := Transform( wartosc, '9 999 999.99' )
            k3w := wartosc
            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            sum7 := sum7 + k3w
            mon_drk( ' ' + k1 + ' ' + k2 + ' ' + k3 )
         ENDIF
         SELECT dowew
         SKIP
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      ENDDO
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k29 := dos_c( Pad( code(), 50 ) )
      mon_drk( 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      mon_drk( '             U&_z.ytkownik programu komputerowego                                                           ³' + kwota( sum7, 12, 2 ) + '³' )
      mon_drk( '      ' + k29 + Space( 49 ) + 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ' )
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk( 'ş' )
   END
   IF _czy_close
      close_()
   ENDIF
   SELECT firma
   USE
   SELECT dowew

   RETURN
