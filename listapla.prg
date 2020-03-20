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

PROCEDURE ListaPla()

   LOCAL nMenu, aDane, aWiersz

   PRIVATE _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
   PRIVATE _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep

   BEGIN SEQUENCE
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz := 1
      _lewa := 1
      _prawa := 130
      _strona := .f.
      _czy_mon := .t.
      _czy_close := .t.
      *------------------------------
      _szerokosc := 130
      _koniec := "del#[+].or.firma#ident_fir"

      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap := 1
      stronak := 99999
      czesc := 1

      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      SELECT 2
      IF Dostep( 'PRAC' )
         SetInd( 'PRAC' )
      ELSE
         BREAK
      ENDIF
      SELECT 1
      IF Dostep( 'ETATY' )
         SetInd( 'ETATY' )
      ELSE
         BREAK
      ENDIF
      SELECT prac
      SEEK '+' + ident_fir
      strona := 0
      IF .NOT. Found()
         Kom(3, '*w', 'b r a k   d a n y c h' )
         BREAK
      ENDIF

      nMenu := GraficznyCzyTekst()
      IF nMenu == 0
         BREAK
      ENDIF

      IF nMenu == 1

         aDane := hb_Hash()
         aDane[ 'uzytkownik' ] := AllTrim( dos_c( code() ) )
         aDane[ 'firma' ] := AllTrim( SYMBOL_FIR )
         aDane[ 'miesiac' ] := miesiac
         aDane[ 'rok' ] := param_rok

         aDane[ 'wiersze' ] := {}

         SELECT prac
         DO WHILE .NOT. &_koniec

            REC := rec_no

            aWiersz := hb_Hash()
            aWiersz[ 'nazwisko' ] := AllTrim( nazwisko )
            aWiersz[ 'imie1' ] := AllTrim( imie1 )
            aWiersz[ 'imie2' ] := AllTrim( imie2 )
            aWiersz[ 'pesel' ] := AllTrim( pesel )

            SELECT etaty
            seek '+' + ident_fir + Str( REC, 5 ) + miesiac
            STORE .F. TO DOD
            STORE .T. TO DDO
            IF .NOT. Empty( PRAC->DATA_PRZY )
               DOD := SubStr( DToS( PRAC->DATA_PRZY ), 1, 6 ) <= param_rok + strtran( miesiac, ' ', '0' )
            ENDIF
            IF .NOT. Empty( PRAC->DATA_ZWOL )
               DDO := SubStr( DToS( PRAC->DATA_ZWOL ), 1, 6 ) >= param_rok + strtran( miesiac, ' ', '0' )
            ENDIF
            IF Found() .AND. ( DO_WYPLATY <> 0 .OR. ( DOD .AND. DDO ) )
               aWiersz[ 'k3' ] := BRUT_RAZEM
               aWiersz[ 'k4' ] := PODATEK
               aWiersz[ 'k5' ] := DOPL_NIEOP
               aWiersz[ 'k6' ] := ODL_NIEOP
               aWiersz[ 'k7' ] := PRZEL_NAKO
               aWiersz[ 'k8' ] := DO_WYPLATY - PRZEL_NAKO
               aWiersz[ 'k9' ] := slownie( iif( aWiersz[ 'k8' ] < 0, 0, aWiersz[ 'k8' ] ) )
               AAdd( aDane[ 'wiersze' ], aWiersz )
            ENDIF

            SELECT prac
            SKIP
         ENDDO

         FRDrukuj( 'frf\listaplac.frf', aDane )

      ELSE
         mon_drk( 'ö' + ProcName() )
         _grupa1 := Int( strona / Max( 1, _druk_2 - 7 ) )
         _grupa := .T.
         //002 nowa suma i k(k8 nie wyzerowane, czy tak ma byc?)
         STORE 0 TO suma1,suma2,suma3,suma4,suma5,suma6,k3,k4,k5,k6,k7,k9
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         SELECT prac
         DO WHILE .NOT. &_koniec
            *   REC=recno()
            REC := rec_no
            k1 := PadR( AllTrim( nazwisko ) + ' ' + AllTrim( imie1 ) + ' ' + AllTrim( imie2 ), 40 )
            k2 := pesel
            SELECT etaty
            seek '+' + ident_fir + Str( REC, 5 ) + miesiac
            STORE .F. TO DOD
            STORE .T. TO DDO
            IF .NOT. Empty( PRAC->DATA_PRZY )
               DOD := SubStr( DToS( PRAC->DATA_PRZY ), 1, 6 ) <= param_rok + strtran( miesiac, ' ', '0' )
            ENDIF
            IF .NOT. Empty( PRAC->DATA_ZWOL )
               DDO := SubStr( DToS( PRAC->DATA_ZWOL ), 1, 6 ) >= param_rok + strtran( miesiac, ' ', '0' )
            ENDIF
            IF Found() .AND. ( DO_WYPLATY <> 0 .OR. ( DOD .AND. DDO ) )
               IF _grupa .OR. _grupa1 # Int( strona / Max( 1, _druk_2 - 7 ) )
                  _grupa1 := Int( strona / Max( 1, _druk_2 - 7 ) )
                  _grupa := .T.
                  *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  mon_drk( ' FIRMA: ' + SYMBOL_FIR + '   Skr&_o.cona lista wyp&_l.at pracownik&_o.w etatowych w miesi&_a.cu ' + miesiac + '.' + param_rok )
                  //002 NOWE ROZMIARY RAMKI
                  mon_drk( 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
                  mon_drk( '³                                        ³           ³          ³         ³         ³         ³          ³          ³ Potwierdzam³' )
                  mon_drk( '³             N A Z W I S K O            ³   PESEL   ³ Przychody- Podatek + Dop&_l.aty -Potr&_a.cen.- Przelew  =   Do     ³   odbi&_o.r   ³' )
                  mon_drk( '³             i  I M I O N A             ³           ³  brutto  ³         ³         ³         ³ na konto ³ wyp&_l.aty  ³   got&_o.wki  ³' )
                  mon_drk( 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ' )
               ENDIF
               k3 := BRUT_RAZEM
               k4 := PODATEK
               k5 := DOPL_NIEOP
               k6 := ODL_NIEOP
               k7 := DO_WYPLATY - PRZEL_NAKO
               //002 nowa linia
               k9 := PRZEL_NAKO
               k8 := slownie( iif( k7 < 0, 0, k7 ) )
               suma1 := suma1 + k3
               suma2 := suma2 + k4
               suma3 := suma3 + k5
               suma4 := suma4 + k6
               suma5 := suma5 + k7
               //002 nowa linia
               suma6 := suma6 + k9
               k3 := kwota( k3, 11, 2 )
               k4 := kwota( k4, 10, 2 )
               k5 := kwota( k5, 10, 2 )
               k6 := kwota( k6, 10, 2 )
               k7 := kwota( k7, 11, 2 )
               //002 nowa linia i zmiana w nastepnej
               k9 := kwota( k9, 11, 2 )
               mon_drk( '  ' + k1 + k2 + k3 + k4 + k5 + k6 + k9 + k7 )
               mon_drk( ' Do wyp&_l.aty: ' + k8 )
               mon_drk( 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ' )
               strona := strona + 3
               _numer := 1

               DO CASE
               CASE Int( strona / Max( 1, _druk_2 - 7 ) ) # _grupa1 .OR. &_koniec
                  _numer := 0
                  _grupa := .T.
               OTHERWISE
                  _grupa := .F.
               ENDCASE
            ENDIF
            SELECT prac
            SKIP
            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         ENDDO
         *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
         k3 := kwota( suma1, 11, 2 )
         k4 := kwota( suma2, 10, 2 )
         k5 := kwota( suma3, 10, 2 )
         k6 := kwota( suma4, 10, 2 )
         k7 := kwota( suma5, 11, 2 )
         //002 nowa linia i zmiana w nastepnej
         k9 := kwota( suma6, 11, 2 )
         mon_drk( '                                         ³ R A Z E M ' + K3 + K4 + K5 + K6 + K9 + k7 )
         mon_drk( '                                         ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ' )
         *mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
         mon_drk( '                U&_z.ytkownik programu komputerowego' )
         mon_drk( '        ' + dos_c( code() ) )
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk( 'ş' )
      ENDIF
   END
   IF _czy_close
      close_()
   ENDIF

   RETURN