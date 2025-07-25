/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha� Gawrycki (gmsystems.pl)

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

PROCEDURE FaPozN()

   *����������������������������������������������������������������������������
   *������ ......   ������������������������������������������������������������
   *� Zbiorcze zestawienia sprzedazy                                           �
   *����������������������������������������������������������������������������

   LOCAL cEkran, cKolor

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, _top, _bot, _stop,;
      _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, nr_rec, wiersz, f10, rec, fou, _top_bot
   *################################# GRAFIKA ##################################
   ColStd()
   @  1, 47 SAY '          '
   @  8,  0 CLEAR TO 22, 79
   @  8,  0 SAY '������������������������������������������������������������������������������Ŀ'
   @  9,  0 SAY '�    Nazwa towaru/us&_l.ugi               �  Ilo&_s.&_c.  � JM  �Cena nett�Wart.netto�VA�'
   @ 10,  0 SAY '������������������������������������������������������������������������������Ĵ'
   @ 11,  0 SAY '�                                      �         �     �         �          �  �'
   @ 12,  0 SAY '�                                      �         �     �         �          �  �'
   @ 13,  0 SAY '�                                      �         �     �         �          �  �'
   @ 14,  0 SAY '������������������������������������������������������������������������������Ĵ'
   @ 15,  0 SAY 'Ro.d.:    Ozn.:         Proc.:              �          �' + Str( vat_A, 2 ) + '�         �          �'
   @ 16,  0 SAY 'TYP FAKT.(opis typu/podstawy fakturowania): �          �' + Str( vat_B, 2 ) + '�         �          �'
   @ 17,  0 SAY '                                            �          �' + Str( vat_C, 2 ) + '�         �          �'
   @ 18,  0 SAY 'ODBIORCA:     NIP:                Kraj:     �          �' + Str( vat_D, 2 ) + '�         �          �'
   @ 19,  0 SAY 'Nazwa.                                      �          � 0�         �          �'
   @ 20,  0 SAY 'Adres.                                      �          �ZW�         �          �'
   @ 21,  0 SAY '                                       RAZEM�          �  �         �          �'
   @ 22,  0 SAY '                                            ������������������������������������'
   SET COLO TO w+
   @ 15,  6 SAY SubStr( RODZDOW, 1, 3 )
   @ 15, 15 SAY SubStr( OPCJE, 1, 8 )
   @ 15, 30 SAY SubStr( PROCEDUR, 1, 14 )
   @ 17,  0 SAY SubStr( FAKTTYP, 1, 40 )
   @ 18,  9 SAY iif( ODBJEST == 'T', 'Tak', 'Nie' )
   @ 18, 18 SAY SubStr( ODNR_IDENT, 1, 14 )
   @ 18, 39 SAY ODBKRAJ
   @ 19,  6 SAY SubStr( ODBNAZWA, 1, 30 )
   @ 20,  6 SAY SubStr( ODBADRES, 1, 30 )
   *@ 19,6 say ODBOSOBA
   *############################### OTWARCIE BAZ ###############################
   SELECT pozycje
   SEEK '+' + zident_poz
   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 11
   _col_l := 1
   _row_d := 13
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,22,48,77,109,7,46,28'
   _top := "del#'+'.or.ident#zident_poz"
   _bot := "del#'+'.or.ident#zident_poz"
   _stop := '+' + ident
   _sbot := '+' + ident + '�'
   _proc := 'linia61fn()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'linia61fsn'
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------
   kl := 0
   zNETTO := 0
   zWARTVAT := 0
   zSTAWKA := '  '
   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := Wybor( _row )
      ColStd()
      @ 24, 0 CLEAR
      kl := LastKey()
      DO CASE
      *################################## INSERT ##################################
      CASE kl == K_INS .OR. kl == Asc( '0' ) .OR. _row == -1 .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' )
         @ 1, 47 SAY '          '
         ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
         IF ins .AND. zKOREKTA == 'T'
            Komun( "Nie mo�na dodawa� pozycji do faktury koryguj�cej" )
         ELSE
            IF ins
               ColStb()
               center( 24, '�                     �' )
               ColSta()
               center( 24, 'W P I S Y W A N I E' )
               ColStd()
               RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
               wiersz := _row_d
            ELSE
               ColStb()
               center( 24, '�                       �' )
               ColSta()
               center( 24, 'M O D Y F I K A C J A' )
               ColStd()
               wiersz := _row
            ENDIF
            DO WHILE .T.
               *������������������������������ ZMIENNE ��������������������������������
               IF ins
                  zTOWAR := Space( 512 )
                  *zSWW := space(14)
                  zILO := 0
                  zJM := Space( 5 )
                  zCENA := 0
                  zSTAWKA := '  '
                  zWARTOSC := 0
                  zVATWART := 0
                  zBRUTTO := 0
                  zCENABRUTTO := 0
               else
                  zTOWAR := TOWAR
                  *zSWW=SWW
                  zILO := ILOSC
                  zJM := JM
                  zCENA := CENA
                  zSTAWKA := VAT
                  zWARTOSC := WARTOSC
                  zVATWART := VATWART
                  zBRUTTO := BRUTTO
                  zCENABRUTTO := iif( Val( VAT ) > 0, _round( zCENA * ( 1 + Val( VAT ) / 100 ), 2 ), zCENA )
               endif
               IF zWARTRANSP == 'T'
                  cEkran := SaveScreen()
                  cKolor := ColStd()
                  @  8, 10 CLEAR TO 17, 69
                  @  8, 10 TO 17, 69
                  @  9, 12 SAY "          Nazwa" GET zTOWAR PICTURE '@S40 ' + Replicate( 'X', 512 ) WHEN zKOREKTA <> 'T' .AND. w26_50vn()
                  @ 10, 12 SAY "          Ilo��" GET zILO PICTURE '99999.999' VALID vWARTOSCfn2( 1 )
                  @ 11, 12 SAY "Jednostka miary" GET zJM PICTURE 'XXXXX' WHEN zKOREKTA <> 'T'
                  @ 12, 12 SAY "     Cena netto" GET zCENA PICTURE '999999.99' VALID vWARTOSCfn2( 2 )
                  @ 13, 12 SAY "     Stawka VAT" GET zSTAWKA PICTURE '!!' WHEN zKOREKTA <> 'T' VALID vSTAWKAfn() .AND. vWARTOSCfn2( 3 )
                  @ 14, 12 SAY "    Cena brutto" GET zCENABRUTTO PICTURE '999999.99' VALID vWARTOSCfn2( 4 )
                  @ 15, 12 SAY "    Wartosc VAT" GET zVATWART PICTURE '999999.99' WHEN .F.
                  @ 16, 12 SAY " Wartosc brutto" GET zBRUTTO PICTURE '999999.99' WHEN .F.
               ELSE
                  *�������������������������������� GET ����������������������������������
                  @ wiersz,  1 GET zTOWAR PICTURE '@S38 ' + repl( 'X', 512 ) WHEN zKOREKTA <> 'T' .AND. w26_50vn()
                  *@ wiersz,31 get zSWW   picture '@RS8 !!!!!!!!!!!!!!'
                  IF NR_UZYTK == 204
                     @ wiersz, 40 GET zILO PICTURE '999999.99' VALID vWARTOSCfn()
                  ELSE
                     @ wiersz, 40 GET zILO PICTURE '99999.999' VALID vWARTOSCfn()
                  endif
                  @ wiersz, 50 GET zJM    PICTURE 'XXXXX' WHEN zKOREKTA <> 'T'
                  @ wiersz, 56 GET zCENA  PICTURE '999999.99' VALID vWARTOSCfn()
                  @ wiersz, 77 GET zSTAWKA PICTURE '!!' WHEN zKOREKTA <> 'T' VALID vSTAWKAfn()
               ENDIF
               read_()
               IF zWARTRANSP == 'T'
                  RestScreen( , , , , cEkran )
               ENDIF
               IF LastKey() == K_ESC
                  EXIT
               ENDIF
               *�������������������������������� REPL ���������������������������������
               IF ins
                  app()
                  repl_( 'ident', zident_poz )
               endif
               do BLOKADAR
               repl_( 'towar', ztowar )
               repl_( 'ilosc', zilo )
               repl_( 'jm', zjm )
               repl_( 'cena', zcena )
               repl_( 'wartosc', zwartosc )
               *repl_( 'SWW', zSWW )
               repl_( 'VAT', zSTAWKA )
               repl_( 'VATWART', zVATWART )
               repl_( 'BRUTTO', zBRUTTO )
               commit_()
               UNLOCK
               *�����������������������������������������������������������������������
               _row := Int( ( _row_g + _row_d ) / 2 )
               IF ! ins
                  EXIT
               ENDIF
               @ _row_d, _col_l SAY &_proc
               Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
               @ _row_d, _col_l SAY '                                      �         �     �         �          �  '
            ENDDO
            _disp := ins .OR. LastKey() # K_ESC
            kl := iif( LastKey() == K_ESC .AND. _row == -1, K_ESC, kl )
            *@ 23,0
            @ 24, 0
         ENDIF

      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == Asc( '.' )
         @ 1, 47 SAY '          '
         IF zKOREKTA == 'T'
            Komun( "Nie mo�na kasowa� pozycji faktury koryguj�cej" )
         ELSE
            RECS := RecNo()
            ColStb()
            center( 24, '�                   �' )
            ColSta()
            center( 24, 'K A S O W A N I E' )
            ColStd()
            _disp := TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
            IF _disp
               BlokadaR()
               DELETE
               UNLOCK
               SKIP
               commit_()
               IF &_bot
                  SKIP -1
               ENDIF
            ENDIF
            @ 24, 0
         ENDIF

      *################################### POMOC ##################################
      CASE kl == K_F1
         @ 1,47 say [          ]
         SAVE SCREEN TO scr_
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
         p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[ 5 ] := '   [Ins]...................dopisanie pozycji do faktury '
         p[ 6 ] := '   [M].....................modyfikacja pozycji          '
         p[ 7 ] := '   [Del]...................kasowanie pozycji            '
         p[ 8 ] := '   [Esc]...................koniec edycji pozycji faktury'
         p[ 9 ] := '                                                        '
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
         _disp := .f.
       ******************** ENDCASE
      ENDCASE
   ENDDO
   RETURN

*################################## FUNKCJE #################################
FUNCTION linia61fn()

   IF NR_UZYTK == 204
      Ret := SubStr( towar, 1, 38 ) + '�' + Str( ilosc, 9, 2 ) + '�' + jm + '�' + Str( cena, 9, 2 ) + '�' + Str( wartosc, 10, 2 ) + '�' + VAT
   ELSE
      Ret := SubStr( towar, 1, 38 ) + '�' + Str( ilosc, 9, 3 ) + '�' + jm + '�' + Str( cena, 9, 2 ) + '�' + Str( wartosc, 10, 2 ) + '�' + VAT
   ENDIF
   RETURN RET

*############################################################################
PROCEDURE linia61fsn()

   reccc := RecNo()
   SEEK '+' + ident
   zWARTZW := 0
   zWART08 := 0
   zWART00 := 0
   zWART07 := 0
   zWART02 := 0
   zWART22 := 0
   zWART12 := 0
   zVAT07 := 0
   zVAT02 := 0
   zVAT22 := 0
   zVAT12 := 0
   zBRUT07 := 0
   zBRUT02 := 0
   zBRUT22 := 0
   zBRUT12 := 0
   DO WHILE del == '+' .AND. ident == zident_poz
      DO CASE
      CASE VAT == 'ZW'
         zWARTZW := zWARTZW + WARTOSC
      CASE VAT == 'NP' .OR. VAT == 'PN' .OR. VAT == 'PU'
         zWART08 := zWART08 + WARTOSC
      CASE VAT == '0 '
         zWART00 := zWART00 + WARTOSC
      CASE AllTrim( VAT ) == Str( vat_B, 1 )
         zWART07 := zWART07 + WARTOSC
         zVAT07 := zVAT07 + VATWART
         zBRUT07 := zBRUT07 + BRUTTO
      CASE AllTrim( VAT ) == Str( vat_C, 1 )
         zWART02 := zWART02 + WARTOSC
         zVAT02 := zVAT02 + VATWART
         zBRUT02 := zBRUT02 + BRUTTO
      CASE AllTrim( VAT ) == Str( vat_A, 2 )
         zWART22 := zWART22 + WARTOSC
         zVAT22 := zVAT22 + VATWART
         zBRUT22 := zBRUT22 + BRUTTO
      CASE AllTrim( VAT ) == Str( vat_D, 1 )
         zWART12 := zWART12 + WARTOSC
         zVAT12 := zVAT12 + VATWART
         zBRUT12 := zBRUT12 + BRUTTO
      ENDCASE
      SKIP
   ENDDO
   IF zWARTRANSP == 'T'

   ELSE
      zVAT07 := _round( zwart07 * ( vat_B / 100 ), 2 )
      zBRUT07 := zWART07 + zVAT07
      zVAT02 := _round( zwart02 * ( vat_C / 100 ), 2 )
      zBRUT02 := zWART02 + zVAT02
      zVAT22 := _round( zwart22 * ( vat_A / 100 ), 2 )
      zBRUT22 := zWART22 + zVAT22
      zVAT12 := _round( zwart12 * ( vat_D / 100 ), 2 )
      zBRUT12 := zWART12 + zVAT12
   ENDIF
   SET COLOR TO +w
   @ 15, 45 SAY zWART22 PICTURE "@Z 999 999.99"
   @ 15, 59 SAY zVAT22 PICTURE "@Z 99 999.99"
   @ 15, 69 SAY zBRUT22 PICTURE "@Z 999 999.99"
   @ 16, 45 SAY zWART07 PICTURE "@Z 999 999.99"
   @ 16, 59 SAY zVAT07 PICTURE "@Z 99 999.99"
   @ 16, 69 SAY zBRUT07 PICTURE "@Z 999 999.99"
   @ 17, 45 SAY zWART02 PICTURE "@Z 999 999.99"
   @ 17, 59 SAY zVAT02 PICTURE "@Z 99 999.99"
   @ 17, 69 SAY zBRUT02 PICTURE "@Z 999 999.99"
   @ 18, 45 SAY zWART12 PICTURE "@Z 999 999.99"
   @ 18, 59 SAY zVAT12 PICTURE "@Z 99 999.99"
   @ 18, 69 SAY zBRUT12 PICTURE "@Z 999 999.99"
   @ 19, 45 SAY zWART00 PICTURE "@Z 999 999.99"
   @ 19, 59 SAY 0 PICTURE "@Z 99 999.99"
   @ 19, 69 SAY zWART00 PICTURE "@Z 999 999.99"
   @ 20, 45 SAY zWARTzw + zWART08 PICTURE "@Z 999 999.99"
   @ 20, 59 SAY 0 PICTURE "@Z 99 999.99"
   @ 20, 69 SAY zWARTzw + zWART08 PICTURE "@Z 999 999.99"
   //@ 21, 45 SAY zWART08 PICTURE "@Z 999 999.99"
   //@ 21, 59 SAY 0 PICTURE "@Z 99 999.99"
   //@ 21, 69 SAY zWART08 PICTURE "@Z 999 999.99"
   *@ 21,45 say zWART12 picture "@Z 999 999.99"
   *@ 21,59 say zVAT12 picture "@Z 99 999.99"
   *@ 21,69 say zWART12+zVAT12 picture "@Z 999 999.99"
   SET COLOR TO w
   @ 21, 45 SAY zWARTZW + zWART08 + zWART00 + zWART07 + zWART22 + zWART02 + zWART12 PICTURE "999 999.99"
   @ 21, 59 SAY zVAT07 + zVAT22 + zVAT02 + zVAT12 PICTURE "99 999.99"
   IF faktury->KOREKTA == 'T'
      @ 22, 45 SAY zWARTZW + zWART08 + zWART00 + zWART07 + zWART22 + zWART02 + zWART12 - aBufDok[ 'suma_netto' ] PICTURE "999 999.99"
      @ 22, 59 SAY zVAT07 + zVAT22 + zVAT02 + zVAT12 - ( aBufDok[ 'suma_brutto' ] - aBufDok[ 'suma_netto' ] ) PICTURE "99 999.99"
   ENDIF
   SET COLOR TO w+*
   @ 21, 69 SAY zWARTZW + zWART08 + zWART00 + zBRUT22 + zBRUT02 + zBRUT12 + zBRUT07 PICTURE "999 999.99"
   IF faktury->KOREKTA == 'T'
      @ 22, 69 SAY zWARTZW + zWART08 + zWART00 + zBRUT22 + zBRUT02 + zBRUT12 + zBRUT07 - aBufDok[ 'suma_brutto' ] PICTURE "999 999.99"
   ENDIF
   GO reccc
   ColInf()
   @ 24,  0 SAY PadC( ' M-modyfikacja   ' + iif( zKOREKTA <> 'T', 'Ins-dopisanie   Del-kasowanie', '' ) + '   Esc-zakonczenie ', 80, ' ' )
   ColStd()
   RETURN

****************************************
FUNCTION vSTAWKAfn()
****************************************
   R := .f.
   IF AllTrim( zSTAWKA ) == Str( vat_A, 2 ) .OR. AllTrim( zSTAWKA ) == Str( vat_B, 1 ) ;
      .OR. AllTrim( zSTAWKA ) == Str( vat_C, 1 ) .OR. AllTrim( zSTAWKA ) == Str( vat_D, 1 ) ;
      .OR. zSTAWKA == '0 ' .OR. zSTAWKA == 'ZW' .OR. zSTAWKA == 'NP' .OR. zSTAWKA == 'PN' .OR. zSTAWKA == 'PU'
      R := .T.
   ENDIF
   RETURN R

****************************************
FUNCTION wWARTVATfn()
****************************************
   IF zWARTVAT == 0
      zWARTVAT := _round( zNETTO * ( Val( zSTAWKA ) / 100 ), 2 )
   ENDIF
   RETURN .T.

****************************************
FUNCTION vWARTOSCfn()
****************************************
   zwartosc := _round( zilo * zcena, 2 )
   Collo := SetColor()
   SET COLOR TO w+
   @ Row(), 66 SAY Str( zwartosc, 10, 2 )
   SET COLOR TO Collo
   RETURN .T.

***************************************************
FUNCTION w26_50vn()
***************************************************
   IF Empty( ztowar )
      SELECT tresc
      SEEK '+' + ident_fir
      IF ! Found()
         SELECT pozycje
      ELSE
         SAVE SCREEN TO scr2_a
         Tresc_()
         RESTORE SCREEN FROM scr2_a
         IF LastKey() == K_ENTER .OR. LastKey() == K_LDBLCLK
            zzz := tresc->tresc
            ztowar := PadR( AllTrim( zzz ), 512 )
         ENDIF
         SELECT pozycje
      ENDIF
   ENDIF
   SET CONFIRM OFF
   RETURN .T.

*############################################################################

FUNCTION vWARTOSCfn2( nRodzaj )

   DO CASE
   CASE nRodzaj == 1 .OR. nRodzaj == 2 .OR. nRodzaj == 3
      zCENABRUTTO := iif( Val( zSTAWKA ) > 0, _round( zCENA * ( 1 + Val( zSTAWKA ) / 100 ), 2 ), zCENA )
      zWARTOSC := _round( zCENA * zILO, 2 )
      zBRUTTO := iif( Val( zSTAWKA ) > 0, _round( zWARTOSC * ( 1 + Val( zSTAWKA ) / 100 ), 2 ), zWARTOSC )
      zVATWART := zBRUTTO - zWARTOSC
   CASE nRodzaj == 4 .AND. zCENA == 0
      zCENA := iif( Val( zSTAWKA ) > 0, _round( zCENABRUTTO / ( 1 + Val( zSTAWKA ) / 100 ), 2 ), zCENABRUTTO )
      zWARTOSC := _round( zCENA * zILO, 2 )
      zBRUTTO := iif( Val( zSTAWKA ) > 0, _round( zWARTOSC * ( 1 + Val( zSTAWKA ) / 100 ), 2 ), zWARTOSC )
      zVATWART := zBRUTTO - zWARTOSC
   ENDCASE

   GetList[ 4 ]:display()
   GetList[ 6 ]:display()
   GetList[ 7 ]:display()
   GetList[ 8 ]:display()

   RETURN .T.

/*----------------------------------------------------------------------*/

