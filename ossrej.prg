      /************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2021  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

#include "inkey.ch"
#include "xhb.ch"

PROCEDURE RejestrOSS()

   LOCAL cEkran := SaveScreen(), cKolor := ColStd(), aDane, aFirma, cRaport
   LOCAL bDzienValid := { | |
      IF zDZIEN == '  '
         zDZIEN := Str( Day( Date( ) ) , 2 )
         SET COLOR TO i
         @ wiersz, 1 SAY zDZIEN
         SET COLOR TO
      ENDIF
      IF Val( zDZIEN ) < 1 .OR. Val( zDZIEN ) > msc( Val( miesiac ) )
         zDZIEN := '  '
         RETURN .F.
      ENDIF
      RETURN .T.
   }
   LOCAL bRodzajVATW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( 'P - podstawowa,      O - obni¾ona', 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bRodzajVATV := { | |
      LOCAL cKolor := SetColor( "W+" )
      IF zSTAWKARD $ 'OP'
         @ wiersz, 25 SAY iif( zSTAWKARD == 'O', 'bni¾ona  ', 'odstawowa' )
         @ 24, 0
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   }
   LOCAL bNettoEURV := { | |
      zVATEUR := _round( zNETTOEUR * ( zSTAWKA / 100 ), 2 )
      RETURN .T.
   }
   LOCAL bKursV := { | |
      zNETTOPLN := _round( zNETTOEUR * zKURS, 2 )
      RETURN .T.
   }
   LOCAL bStawkaW := { | |
      LOCAL aStawki, nStawka
      LOCAL aListaStawek := {}, aListaWysw := {}
      IF zSTAWKA == 0
         aStawki := Tab_VatUEZnajdz( zKRAJ, hb_Date( Val( param_rok ), Val( miesiac ), Val( zDZIEN ) ) )
         IF zSTAWKARD == 'O'
            IF aStawki[ 'b' ] <> 0
               AAdd( aListaStawek, aStawki[ 'b' ] )
               AAdd( aListaWysw, 'B - ' + Str( aStawki[ 'b' ], 5, 2 ) )
            ENDIF
            IF aStawki[ 'c' ] <> 0
               AAdd( aListaStawek, aStawki[ 'c' ] )
               AAdd( aListaWysw, 'C - ' + Str( aStawki[ 'c' ], 5, 2 ) )
            ENDIF
            IF aStawki[ 'd' ] <> 0
               AAdd( aListaStawek, aStawki[ 'd' ] )
               AAdd( aListaWysw, 'D - ' + Str( aStawki[ 'd' ], 5, 2 ) )
            ENDIF
            IF Len( aListaStawek ) > 0
               IF Len( aListaStawek ) == 1
                  zSTAWKA := aListaStawek[ 1 ]
               ELSE
                  nStawka := MenuEx( 17, 32, aListaWysw, 1, .T. )
                  IF nStawka > 0
                     zSTAWKA := aListaStawek[ nStawka ]
                  ENDIF
               ENDIF
            ENDIF
         ELSE
            zSTAWKA := aStawki[ 'a' ]
         ENDIF
      ENDIF
      RETURN .T.
   }
   LOCAL bRodzDostW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( "Wprowad«:   T - dostawa towar¢w,    U - ˜wiadczenie usˆug", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bRodzDostV := { | |
      LOCAL lRes
      IF ( lRes := zRODZDOST $ 'TU' )
         @ wiersz, 68 SAY iif( zRODZDOST == 'T', 'owar ', 'sˆuga' )
         @ 24, 0
      ENDIF
      RETURN lRes
   }
   LOCAL bSekcjaCW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( "Wprowad«:   2 - sekcja C.2 dekl. VIU-DO,   3 - sekcja C.3 dekl. VIU-DO", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bSekcjaCV := { | |
      LOCAL lRes
      IF ( lRes := zSEKCJAC $ '23' )
         @24, 0
      ENDIF
      RETURN lRes
   }

   PRIVATE zDZIEN, zNRDOK, zKRAJ, zTOWAR, zSTAWKARD, zSTAWKA, zNETTOEUR, zVATEUR, zKURS, ;
      zNETTOPLN, zKOSZTY, zDATAPLAT, zZAPLATA, zZALICZKA, zINFO, zNRZAMOW, zNRZWROT, zNETTOZW, ;
      zVATZW, zWALUTA, zRODZDOST, zKRAJDZ, zNR_IDVAT, zNR_IDPOD, zSEKCJAC

   @ 24,  0
   @  1, 47 SAY "          "
   *################################# GRAFIKA ##################################
   @  3, 0 SAY PadC( 'OSS - REJESTR SPRZEDA½Y', 80 )
   @  4, 0 SAY ' Dz.    Nr dowodu   Kraj Rodz.st.  St.VAT W.netto EUR Wart.VAT EUR R.dost Sekc.C'
   @  5, 0 SAY 'ÚÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄ¿'
   @  6, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @  7, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @  8, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @  9, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @ 10, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @ 11, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @ 12, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @ 13, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @ 14, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @ 15, 0 SAY '³  ³                ³  ³          ³     ³            ³            ³      ³     ³'
   @ 16, 0 SAY 'ÀÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÙ'
   @ 17, 0 SAY 'Towar i ilo˜†:                                                        Waluta:   '
   @ 18, 0 SAY 'Informacje:                                          Nr zam¢wienia:             '
   @ 19, 0 SAY '—r.kurs NBP:             Wart.netto PLN:                  Zaliczka:             '
   @ 20, 0 SAY '     Koszty:               Data zapˆaty:                 Zapˆacono:             '
   @ 21, 0 SAY 'Nr zwrotu:              W.netto zwr.UER:             W.VAT zwr.EUR:             '
   @ 22, 0 SAY 'Nr id. VAT:               Nr id. podat.:               Paästwo prow. dziaˆ.:    '

   SELECT 2
   IF ! DostepPro( 'TAB_VATUE', , .T., , 'TAB_VATUE' )
      RestScreen( , , , , cEkran )
      SetColor( cKolor )
      RETURN NIL
   ENDIF
   tab_vatue->( ordSetFocus( 2 ) )

   SELECT 1
   IF ! DostepPro( 'OSSREJ', , .T., , 'OSSREJ' )
      close_()
      RestScreen( , , , , cEkran )
      SetColor( cKolor )
      RETURN NIL
   ENDIF

   _row_g := 6
   _col_l := 1
   _row_d := 15
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,-4,-5,-37,13,83,115'
   _top := "ossrej->firma#ident_fir.or.ossrej->mc#miesiac"
   _bot := "ossrej->firma#ident_fir.or.ossrej->mc#miesiac"
   _stop := ident_fir + miesiac
   _sbot := ident_fir + miesiac + 'þ'
   _proc := 'RejestrOSSLinia()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'RejestrOSSSzczegoly'
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------

   ossrej->( dbSeek( _stop ) )

   kl := 0
   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *############################ INSERT/MODYFIKACJA ############################
      CASE kl == K_INS .OR. kl == hb_keyCode( "0" ) .OR. _row == -1 .OR. kl == hb_keyCode( "M" ) .OR. kl == hb_keyCode( "m" )
         @ 1, 47 SAY '          '
         ins := ( kl # hb_keyCode( "M" ) .AND. kl # hb_keyCode( "m" ) ) .OR. &_top_bot
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
            center(23, 'þ                       þ' )
            ColSta()
            center(23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zDZIEN := Str( Day( Date() ), 2 )
               zNRDOK := Space( 64 )
               zTOWAR := Space( 200 )
               zKRAJ := Space( 2 )
               zSTAWKARD := ' '
               zSTAWKA := 0
               zNETTOEUR := 0
               zVATEUR := 0
               zKURS := 0
               zNETTOPLN := 0
               zKOSZTY := 0
               zDATAPLAT := SToD( '    .  .  ' )
               zZAPLATA := 0
               zZALICZKA := 0
               zINFO := Space( 200 )
               zNRZAMOW := Space( 64 )
               zNRZWROT := Space( 64 )
               zNETTOZW := 0
               zVATZW := 0
               zWALUTA := Space( 3 )
               zRODZDOST := ' '
               zKRAJDZ := Space( 2 )
               zNR_IDVAT := Space( 30 )
               zNR_IDPOD := Space( 30 )
               zSEKCJAC := '2'
            ELSE
               zDZIEN := ossrej->dzien
               zNRDOK := ossrej->nrdok
               zTOWAR := ossrej->towar
               zKRAJ := ossrej->kraj
               zSTAWKARD := ossrej->stawkard
               zSTAWKA := ossrej->stawka
               zNETTOEUR := ossrej->nettoeur
               zVATEUR := ossrej->vateur
               zKURS := ossrej->kurs
               zNETTOPLN := ossrej->nettopln
               zKOSZTY := ossrej->koszty
               zDATAPLAT := ossrej->dataplat
               zZAPLATA := ossrej->zaplata
               zZALICZKA := ossrej->zaliczka
               zINFO := ossrej->info
               zNRZAMOW := ossrej->nrzamow
               zNRZWROT := ossrej->nrzwrot
               zNETTOZW := ossrej->nettozw
               zVATZW := ossrej->vatzw
               zWALUTA := ossrej->waluta
               zRODZDOST := ossrej->rodzdost
               zKRAJDZ := ossrej->krajdz
               zNR_IDVAT := ossrej->nr_idvat
               zNR_IDPOD := ossrej->nr_idpod
               zSEKCJAC := ossrej->sekcjac
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz,  1 GET zDZIEN    PICTURE '99' VALID Eval( bDzienValid )
            @ wiersz,  4 GET zNRDOK    PICTURE "@S16 " + Repl( '!', 64 ) /*VALID AllTrim( zNRDOK ) <> ""*/
            @ wiersz, 21 GET zKRAJ     PICTURE "!!" VALID KrajUE( zKRAJ )
            @ wiersz, 24 GET zSTAWKARD PICTURE "!" WHEN Eval( bRodzajVATW ) VALID Eval( bRodzajVATV )
            @ wiersz, 35 GET zSTAWKA   PICTURE "99.99" WHEN Eval( bStawkaW )
            @ wiersz, 41 GET zNETTOEUR PICTURE FPIC VALID Eval( bNettoEURV )
            @ wiersz, 54 GET zVATEUR   PICTURE FPIC
            @ wiersz, 67 GET zRODZDOST PICTURE '!' WHEN Eval( bRodzDostW ) VALID Eval( bRodzDostV )
            @ wiersz, 76 GET zSEKCJAC  PICTURE '9' WHEN Eval( bSekcjaCW ) VALID Eval( bSekcjaCV )
            @ 17,     14 GET zTOWAR    PICTURE "@S55 " + Replicate( '!', 200 )
            @ 17,     77 GET zWALUTA   PICTURE '!!!'
            @ 18,     11 GET zINFO     PICTURE '@S40 ' + Replicate( '!', 200 )
            @ 18,     67 GET zNRZAMOW  PICTURE '@S13 ' + Replicate( '!', 64 )
            @ 19,     12 GET zKURS     PICTURE '@ZE  999999.9999' VALID Eval( bKursV )
            @ 19,     40 GET zNETTOPLN PICTURE FPIC
            @ 19,     68 GET zZALICZKA PICTURE FPIC
            @ 20,     12 GET zKOSZTY   PICTURE FPIC
            @ 20,     40 GET zDATAPLAT
            @ 20,     68 GET zZAPLATA  PICTURE FPIC
            @ 21,     10 GET zNRZWROT  PICTURE '@S12 ' + Replicate( '!', 64 )
            @ 21,     40 GET zNETTOZW  PICTURE FPIC
            @ 21,     68 GET zVATZW    PICTURE FPIC
            @ 22,     11 GET zNR_IDVAT PICTURE '@S13 ' + Replicate( '!', 30 )
            @ 22,     40 GET zNR_IDPOD PICTURE '@S13 ' + Replicate( '!', 30 )
            @ 22,     77 GET zKRAJDZ   PICTURE '!!' VALID KrajUE( zKRAJDZ ) .OR. zKRAJDZ == '  '
            read_()
            IF LastKey() == K_ESC
               EXIT
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               ossrej->( dbAppend() )
               ossrej->firma := ident_fir
               ossrej->mc := miesiac
            ENDIF
            BlokadaR( 'ossrej' )
            ossrej->dzien := zDZIEN
            ossrej->nrdok := zNRDOK
            ossrej->towar := zTOWAR
            ossrej->kraj := zKRAJ
            ossrej->stawkard := zSTAWKARD
            ossrej->stawka := zSTAWKA
            ossrej->nettoeur := zNETTOEUR
            ossrej->vateur := zVATEUR
            ossrej->kurs := zKURS
            ossrej->nettopln := zNETTOPLN
            ossrej->koszty := zKOSZTY
            ossrej->dataplat := zDATAPLAT
            ossrej->zaplata := zZAPLATA
            ossrej->zaliczka := zZALICZKA
            ossrej->info := zINFO
            ossrej->nrzamow := zNRZAMOW
            ossrej->nrzwrot := zNRZWROT
            ossrej->nettozw := zNETTOZW
            ossrej->vatzw := zVATZW
            ossrej->waluta := zWALUTA
            ossrej->rodzdost := zRODZDOST
            ossrej->krajdz := zKRAJDZ
            ossrej->nr_idvat := zNR_IDVAT
            ossrej->nr_idpod := zNR_IDPOD
            ossrej->sekcjac := zSEKCJAC

            ossrej->( dbCommit() )
            ossrej->( dbRUnlock() )
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( (_row_g + _row_d ) / 2 )
            IF ! ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '  ³                ³  ³          ³     ³            ³            ³            '
         ENDDO
         _disp := ins .OR. LastKey() # K_ESC
         kl := iif( LastKey() == K_ESC .AND. _row == -1, K_ESC, kl )
         @ 23,0
      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == hb_keyCode( "." )
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR( 'ossrej' )
            ossrej->( dbDelete() )
            ossrej->( dbCommit() )
            ossrej->( dbSkip() )
            IF &_bot
               ossrej->( dbSkip( -1 ) )
            ENDIF
         ENDIF
         @ 23, 0
      *################################# SZUKANIE #################################
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         f10 := Space( 32 )
         ColStd()
         @ _row, 4 GET f10 PICTURE Replicate( "!", 32 )
         read_()
         _disp := ! Empty( f10 ) .AND. LastKey() # K_ESC
         IF _disp
            ossrej->( dbSeek( ident_fir + f10 ) )
            IF &_bot
               ossrej->( dbSkip( -1 ) )
            ENDIF
            _row := int( ( _row_g + _row_d ) / 2 )
         ENDIF
         @ 23,0
      *################################### POMOC ##################################
      CASE kl == K_F1
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[  3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[  4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  5 ] := '   [Ins]...................wpisywanie                   '
         p[  6 ] := '   [M].....................modyfikacja pozycji          '
         p[  7 ] := '   [S].....................wydruk podsumowania          '
         p[  8 ] := '   [Del]...................kasowanie pozycji            '
         p[  9 ] := '   [F10]...................szukanie                     '
         p[ 10 ] := '   [Enter].................wydruk zestawienia           '
         p[ 11 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 12 ] := '                                                        '
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
         pause( 0 )
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      *################################### WYDRUK ###############################
      CASE kl == K_ENTER
         aFirma := Firma_Wczytaj( { 'NAZWA' } )
         aDane := { ;
            'pozycje' => RejestrOSSDane( .T. ), ;
            'miesiac' => AllTrim( miesiac( Val( miesiac ) ) ), ;
            'rok' => param_rok, ;
            'firma' => AllTrim( aFirma[ 'NAZWA' ] ) ;
         }

         FRDrukuj( 'frf\ossrej.frf', aDane )
      *################################### WYDRUK ###############################
      CASE kl == Asc( 'S' ) .OR. kl == Asc( 's' )
         aFirma := Firma_Wczytaj( { 'NAZWA' } )
         aDane := { ;
            'pozycje' => RejestrOSSDaneSumRap( RejestrOSSDaneSum( RejestrOSSDane( .T. ) ) ), ;
            'miesiac' => AllTrim( miesiac( Val( miesiac ) ) ), ;
            'rok' => param_rok, ;
            'firma' => AllTrim( aFirma[ 'NAZWA' ] ) ;
         }

         FRDrukuj( 'frf\osssum.frf', aDane )
      ******************** ENDCASE
      ENDCASE
   ENDDO

   close_()
   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION RejestrOSSLinia()

   RETURN ossrej->dzien + '³' + SubStr( ossrej->nrdok, 1, 16 ) + '³' ;
      + ossrej->kraj + '³' + iif( ossrej->stawkard == 'O', 'Obni¾ona  ', 'Podstawowa' ) ;
      + '³' + Transform( ossrej->stawka, '99.99' )  + '³' + Transform( ossrej->nettoeur, FPIC ) ;
      + '³' + Transform( ossrej->vateur, FPIC ) + '³' + iif( ossrej->rodzdost == 'U', 'Usˆuga', 'Towar ' ) ;
      + '³  ' + ossrej->sekcjac + '  '

/*----------------------------------------------------------------------*/

PROCEDURE RejestrOSSSzczegoly()

   @ 17, 14 SAY SubStr( ossrej->towar, 1, 55 )
   @ 17, 77 SAY ossrej->waluta
   @ 18, 11 SAY SubStr( ossrej->info, 1, 40 )
   @ 18, 67 SAY SubStr( ossrej->nrzamow, 1, 13 )
   @ 19, 12 SAY Transform( ossrej->kurs, '@ZE  999999.9999' )
   @ 19, 40 SAY Transform( ossrej->nettopln, FPIC )
   @ 19, 68 SAY Transform( ossrej->zaliczka, FPIC )
   @ 20, 12 SAY Transform( ossrej->koszty, FPIC )
   @ 20, 40 SAY ossrej->dataplat
   @ 20, 68 SAY Transform( ossrej->zaplata, FPIC )
   @ 21, 10 SAY SubStr( ossrej->nrzwrot, 1, 12 )
   @ 21, 40 SAY Transform( ossrej->nettozw, FPIC )
   @ 21, 68 SAY Transform( ossrej->vatzw, FPIC )
   @ 22, 11 SAY SubStr( ossrej->nr_idvat, 1, 13 )
   @ 22, 40 SAY SubStr( ossrej->nr_idpod, 1, 13 )
   @ 22, 77 SAY ossrej->krajdz

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION RejestrOSSDane( lMiesiecznie )

   LOCAL aDane := {}
   LOCAL nRecNo := ossrej->( RecNo() )
   LOCAL cMiesiacPocz, cMiesiacKon, aKwartal

   IF lMiesiecznie
      cMiesiacPocz := miesiac
      cMiesiacKon := miesiac
   ELSE
      aKwartal := ObliczKwartal( Val( miesiac ) )
      cMiesiacPocz := Str( aKwartal[ 'kwapocz' ], 2, 0 )
      cMiesiacKon := Str( aKwartal[ 'kwakon' ], 2, 0 )
   ENDIF

   ossrej->( dbSeek( ident_fir + cMiesiacPocz ) )
   DO WHILE ossrej->firma == ident_fir .AND. ossrej->mc >= cMiesiacPocz .AND. ossrej->mc <= cMiesiacKon
      AAdd( aDane, { ;
         'data' => hb_Date( Val( param_rok ), Val( ossrej->mc ), Val( ossrej->dzien ) ), ;
         'dzien' => ossrej->dzien, ;
         'nrdok' => AllTrim( ossrej->nrdok ), ;
         'towar' => AllTrim( ossrej->towar ), ;
         'kraj' => ossrej->kraj, ;
         'stawkard' => ossrej->stawkard, ;
         'stawkardp' => iif( ossrej->stawkard == 'O', 'Obni¾ona', 'Podstawowa' ), ;
         'stawka' => ossrej->stawka, ;
         'nettoeur' => ossrej->nettoeur, ;
         'vateur' => ossrej->vateur, ;
         'kurs' => ossrej->kurs, ;
         'nettopln' => ossrej->nettopln, ;
         'koszty' => ossrej->koszty, ;
         'dataplat' => DToC( ossrej->dataplat ), ;
         'zaplata' => ossrej->zaplata, ;
         'datakwotaplat' => iif( ! Empty( ossrej->dataplat ), DToC( ossrej->dataplat ) + hb_eol() + AllTrim( Transform( ossrej->zaplata, RPICE ) ), '' ), ;
         'zaliczka' => ossrej->zaliczka, ;
         'info' => AllTrim( ossrej->info ), ;
         'nrzamow' => AllTrim( ossrej->nrzamow ), ;
         'nrzwrot' => AllTrim( ossrej->nrzwrot ), ;
         'nettozw' => ossrej->nettozw, ;
         'vatzw' => ossrej->vatzw, ;
         'waluta' => ossrej->waluta, ;
         'rodzdost' => ossrej->rodzdost, ;
         'krajdz' => ossrej->krajdz, ;
         'nr_idvat' => AllTrim( ossrej->nr_idvat ), ;
         'nr_idpod' => AllTrim( ossrej->nr_idpod ), ;
         'sekcjac' => ossrej->sekcjac ;
      } )
      ossrej->( dbSkip() )
   ENDDO

   ossrej->( dbGoto( nRecNo ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION RejestrOSSDaneSum( aDane, lTylkoSekcjaC2 )

   LOCAL aSum := {=>}

   hb_default( @lTylkoSekcjaC2, .F. )

   AEval( aDane, { | aPoz |
      IF ! lTylkoSekcjaC2 .OR. aPoz[ 'sekcjac' ] <> '3'
         IF hb_HHasKey( aSum, aPoz[ 'kraj' ] )
            IF hb_HHasKey( aSum[ aPoz[ 'kraj' ] ], aPoz[ 'rodzdost' ] )
               IF hb_HHasKey( aSum[ aPoz[ 'kraj' ] ][ aPoz[ 'rodzdost' ] ], aPoz[ 'stawka' ] )
                  aSum[ aPoz[ 'kraj' ] ][ aPoz[ 'rodzdost' ] ][ aPoz[ 'stawka' ] ][ 'nettoeur' ] += aPoz[ 'nettoeur' ]
                  aSum[ aPoz[ 'kraj' ] ][ aPoz[ 'rodzdost' ] ][ aPoz[ 'stawka' ] ][ 'vateur' ] += aPoz[ 'vateur' ]
                  aSum[ aPoz[ 'kraj' ] ][ aPoz[ 'rodzdost' ] ][ aPoz[ 'stawka' ] ][ 'nettopln' ] += aPoz[ 'nettopln' ]
                  aSum[ aPoz[ 'kraj' ] ][ aPoz[ 'rodzdost' ] ][ aPoz[ 'stawka' ] ][ 'nettozw' ] += aPoz[ 'nettozw' ]
                  aSum[ aPoz[ 'kraj' ] ][ aPoz[ 'rodzdost' ] ][ aPoz[ 'stawka' ] ][ 'vatzw' ] += aPoz[ 'vatzw' ]
               ELSE
                  aSum[ aPoz[ 'kraj' ] ][ aPoz[ 'rodzdost' ] ][ aPoz[ 'stawka' ] ] := { ;
                     'nettoeur' => aPoz[ 'nettoeur' ], ;
                     'vateur' => aPoz[ 'vateur' ], ;
                     'nettopln' => aPoz[ 'nettopln' ], ;
                     'nettozw' => aPoz[ 'nettozw' ], ;
                     'vatzw' => aPoz[ 'vatzw' ], ;
                     'stawkard' => aPoz[ 'stawkard' ], ;
                     'stawkardp' => aPoz[ 'stawkardp' ] }
               ENDIF
            ELSE
               aSum[ aPoz[ 'kraj' ] ][ aPoz[ 'rodzdost' ] ] := { aPoz[ 'stawka' ] => { ;
                  'nettoeur' => aPoz[ 'nettoeur' ], ;
                  'vateur' => aPoz[ 'vateur' ], ;
                  'nettopln' => aPoz[ 'nettopln' ], ;
                  'nettozw' => aPoz[ 'nettozw' ], ;
                  'vatzw' => aPoz[ 'vatzw' ], ;
                  'stawkard' => aPoz[ 'stawkard' ], ;
                  'stawkardp' => aPoz[ 'stawkardp' ] } }
            ENDIF
         ELSE
            aSum[ aPoz[ 'kraj' ] ] := { aPoz[ 'rodzdost' ] => { aPoz[ 'stawka' ] => { ;
               'nettoeur' => aPoz[ 'nettoeur' ], ;
               'vateur' => aPoz[ 'vateur' ], ;
               'nettopln' => aPoz[ 'nettopln' ], ;
               'nettozw' => aPoz[ 'nettozw' ], ;
               'vatzw' => aPoz[ 'vatzw' ], ;
               'stawkard' => aPoz[ 'stawkard' ], ;
               'stawkardp' => aPoz[ 'stawkardp' ] } } }
         ENDIF
      ENDIF
   } )

   RETURN aSum

/*----------------------------------------------------------------------*/

FUNCTION  RejestrOSSDaneSumRap( aDane )

   LOCAL aRes := {}
   PRIVATE cKrajL, aStawkiL, cRodzDostL, aRodzajeL

   hb_HEval( aDane, { | cKraj, aStawki |
      cKrajL := cKraj
      aStawkiL := aStawki
      hb_HEval( aStawki, { | cRodzDost, aRodzaje |
         cRodzDostL := cRodzDost
         aRodzajeL := aRodzaje
         hb_HEval( aRodzaje, { | nStawka, aStawka |
            AAdd( aRes, { ;
               'kraj' => cKrajL, ;
               'krajnazwa' => KrajUENazwa( cKrajL ), ;
               'rodzdost' => cRodzDostL, ;
               'stawka' => nStawka, ;
               'stawkard' => aStawka[ 'stawkard' ], ;
               'stawkardp' => aStawka[ 'stawkardp' ], ;
               'nettoeur' => aStawka[ 'nettoeur' ], ;
               'vateur' => aStawka[ 'vateur' ], ;
               'nettopln' => aStawka[ 'nettopln' ], ;
               'nettozw' => aStawka[ 'nettozw' ], ;
               'vatzw' => aStawka[ 'vatzw' ] ;
            } )
         } )
      } )
   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE OSSKorektyVIU_DO()

   LOCAL cEkran := SaveScreen(), cKolor := ColStd(), aDane, aFirma, cRaport
   LOCAL bKrajV := { | |
      LOCAL lRes := KrajUE( zKRAJ ), cKolor
      IF lRes
         cKolor := SetColor( 'w+' )
         @ wiersz, 15 SAY ' - ' + Pad( SubStr( KrajUENazwa( zKRAJ ), 1, 18 ), 18 )
         SetColor( cKolor )
      ENDIF
      RETURN lRes
   }

   PRIVATE zKWARTAL, zKRAJ, zROKKOR, zKWARTKOR, zKWOTA

   zKWARTAL := Str( ObliczKwartal( Val( miesiac ) )[ 'kwarta' ], 1, 0 )

   @ 24,  0
   @  1, 47 SAY "          "
   *################################# GRAFIKA ##################################
   @  3, 0 SAY '             KOREKTY KWOT PODATKU VAT dla deklaracji za   kwartaˆ               '
   @  4, 0 SAY '              Paästwo czˆonkowskie    Rok   Kwartaˆ    Kwota VAT                '
   @  5, 0 SAY '           ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿           '
   @  6, 0 SAY '           ³                        ³      ³       ³                ³           '
   @  7, 0 SAY '           ³                        ³      ³       ³                ³           '
   @  8, 0 SAY '           ³                        ³      ³       ³                ³           '
   @  9, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 10, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 11, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 12, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 13, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 14, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 15, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 16, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 17, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 18, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 19, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 20, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 21, 0 SAY '           ³                        ³      ³       ³                ³           '
   @ 22, 0 SAY '           ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ           '

   SetColor( 'w+' )
   @ 3, 56 SAY zKWARTAL
   ColStd()

   SELECT 1
   IF ! DostepPro( 'VIUDOKOR', , .T., , 'VIUDOKOR' )
      close_()
      RestScreen( , , , , cEkran )
      SetColor( cKolor )
      RETURN NIL
   ENDIF

   _row_g := 6
   _col_l := 12
   _row_d := 21
   _col_p := 67
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,-4,-5,-37'
   _top := "viudokor->firma#ident_fir.or.viudokor->kwartal#zKWARTAL"
   _bot := "viudokor->firma#ident_fir.or.viudokor->kwartal#zKWARTAL"
   _stop := ident_fir + zKWARTAL
   _sbot := ident_fir + zKWARTAL + 'þ'
   _proc := 'OSSKorektyVIU_DOLinia()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------

   viudokor->( dbSeek( _stop ) )

   kl := 0
   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *############################ INSERT/MODYFIKACJA ############################
      CASE kl == K_INS .OR. kl == hb_keyCode( "0" ) .OR. _row == -1 .OR. kl == hb_keyCode( "M" ) .OR. kl == hb_keyCode( "m" )
         @ 1, 47 SAY '          '
         ins := ( kl # hb_keyCode( "M" ) .AND. kl # hb_keyCode( "m" ) ) .OR. &_top_bot
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
            center(23, 'þ                       þ' )
            ColSta()
            center(23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zKRAJ := Space( 2 )
               zROKKOR := Space( 4 )
               zKWARTKOR := Space( 1 )
               zKWOTA := 0
            ELSE
               zKRAJ := viudokor->kraj
               zROKKOR := viudokor->rokkor
               zKWARTKOR := viudokor->kwartkor
               zKWOTA := viudokor->kwota
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz, 13 GET zKRAJ     PICTURE "!!" VALID Eval( bKrajV )
            @ wiersz, 38 GET zROKKOR   PICTURE "9999" VALID ! Empty( zROKKOR )
            @ wiersz, 47 GET zKWARTKOR PICTURE "9" VALID zKWARTKOR $ '1234'
            @ wiersz, 54 GET zKWOTA    PICTURE FPIC VALID zKWOTA <> 0
            read_()
            IF LastKey() == K_ESC
               EXIT
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               viudokor->( dbAppend() )
               viudokor->firma := ident_fir
               viudokor->kwartal := zKWARTAL
            ENDIF
            BlokadaR( 'viudokor' )
            viudokor->kraj := zKRAJ
            viudokor->rokkor := zROKKOR
            viudokor->kwartkor := zKWARTKOR
            viudokor->kwota := zKWOTA

            viudokor->( dbCommit() )
            viudokor->( dbRUnlock() )
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( (_row_g + _row_d ) / 2 )
            IF ! ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '                        ³      ³       ³                '
         ENDDO
         _disp := ins .OR. LastKey() # K_ESC
         kl := iif( LastKey() == K_ESC .AND. _row == -1, K_ESC, kl )
         @ 23,0
      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == hb_keyCode( "." )
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR( 'viudokor' )
            viudokor->( dbDelete() )
            viudokor->( dbCommit() )
            viudokor->( dbSkip() )
            IF &_bot
               viudokor->( dbSkip( -1 ) )
            ENDIF
         ENDIF
         @ 23, 0
      *################################### POMOC ##################################
      CASE kl == K_F1
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[  3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[  4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  5 ] := '   [Ins]...................wpisywanie                   '
         p[  6 ] := '   [M].....................modyfikacja pozycji          '
         p[  7 ] := '   [Del]...................kasowanie pozycji            '
         p[  8 ] := '   [Esc]...................wyj&_s.cie                      '
         p[  9 ] := '                                                        '
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
         pause( 0 )
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO

   close_()
   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION OSSKorektyVIU_DOLinia()

   RETURN ' ' + viudokor->kraj + ' - ' ;
      + Pad( SubStr( KrajUENazwa( viudokor->kraj ), 1, 18 ), 18 ) + '³ ' ;
      + viudokor->rokkor + ' ³   ' + viudokor->kwartkor + '   ³  ' ;
      + Transform( viudokor->kwota, FPIC )  + '  '

/*----------------------------------------------------------------------*/

FUNCTION OSSKorektyVIU_DODane()

   LOCAL aDane := {=>}, cKwartal := Str( ObliczKwartal( Val( miesiac ) )[ 'kwarta' ], 1, 0 )

   DO WHILE ! DostepPro( 'VIUDOKOR', , .T., , 'VIUDOKOR' )
   ENDDO

   viudokor->( dbSeek( ident_fir + cKwartal ) )
   DO WHILE viudokor->firma == ident_fir .AND. viudokor->kwartal == cKwartal
      IF ! hb_HHasKey( aDane, viudokor->kraj )
         aDane[ viudokor->kraj ] := {}
      ENDIF
      AAdd( aDane[ viudokor->kraj ], { ;
         'rok' => viudokor->rokkor, ;
         'kwartal' => viudokor->kwartkor, ;
         'kwota' => viudokor->kwota ;
      } )
      viudokor->( dbSkip() )
   ENDDO
   viudokor->( dbCloseArea() )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION OSSSekcjaC3Dane( aDaneOSS )

   LOCAL aDane := {=>}

   AEval( aDaneOSS, { | aPoz |
      IF aPoz[ 'sekcjac' ] == '3'
         IF ! hb_HHasKey( aDane, aPoz[ 'kraj' ] )
            aDane[ aPoz[ 'kraj' ] ] := {}
         ENDIF
         AAdd( aDane[ aPoz[ 'kraj' ] ], { ;
            'krajdz' => aPoz[ 'krajdz' ], ;
            'nr_idvat' => aPoz[ 'nr_idvat' ], ;
            'nr_idpod' => aPoz[ 'nr_idpod' ], ;
            'rodzdost' => aPoz[ 'rodzdost' ], ;
            'stawkard' => aPoz[ 'stawkard' ], ;
            'stawka' => aPoz[ 'stawka' ], ;
            'nettoeur' => aPoz[ 'nettoeur' ], ;
            'vateur' => aPoz[ 'vateur' ] ;
         } )
      ENDIF
   } )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION OSSSekcjaC6Dane( aDaneOSS, aDaneKor, nSuma )

   LOCAL aDane := {=>}, cKrajL

   hb_default( @nSuma, 0 )

   AEval( aDaneOSS, { | aPoz |
      IF ! hb_HHasKey( aDane, aPoz[ 'kraj' ] )
         aDane[ aPoz[ 'kraj' ] ] := 0
      ENDIF
      aDane[ aPoz[ 'kraj' ] ] += aPoz[ 'vateur' ]
      nSuma += aPoz[ 'vateur' ]
   } )

   hb_HEval( aDaneKor, { | cKraj, aPozycje |
      IF ! hb_HHasKey( aDane, cKraj )
         aDane[ cKraj ] := 0
      ENDIF
      cKrajL := cKraj
      AEval( aPozycje, { | aPoz |
         aDane[ cKrajL ] += aPoz[ 'kwota' ]
         IF aPoz[ 'kwota' ] > 0
            nSuma += aPoz[ 'kwota' ]
         ENDIF
      } )
   } )

   IF nSuma < 0
      nSuma := 0
   ENDIF

   RETURN aDane

/*----------------------------------------------------------------------*/

PROCEDURE OSSDeklaracjaVIU_DO()

   LOCAL aDane, dOkresPocz := SToD(), dOkresKon := SToD(), cEkran, cKolor
   LOCAL cRobocza := 'D', dDataWyp := Date(), nMenu, aFirma, aDaneOSS
   LOCAL cDeklaracja
   LOCAL bRoboczaW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( 'Wprowad«: D - zˆo¾enie deklaracji,   R - wersja robocza', 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bRoboczaV := { | |
      LOCAL lRes := cRobocza $ 'DR', cKolor
      IF lRes
         cKolor := SetColor( 'w+' )
         @  4, 71 SAY iif( cRobocza == 'R', 'obocza   ', 'eklaracja' )
         SetColor( cKolor )
         @ 24,  0
      ENDIF
      RETURN lRes
   }

   ColStd()
   @  3, 42 CLEAR TO 22, 79
   SetColor( 'w+' )
   @  3, 42 SAY ' -- DEKLARACJA VIU-DO --------------- '
   ColStd()
   @  4, 42 SAY 'Deklalaracja czy wer.rob.?.' GET cRobocza PICTURE '!' WHEN Eval( bRoboczaW ) VALID Eval( bRoboczaV )
   @  5, 42 SAY 'Data wypeˆnienia...........' GET dDataWyp
   SetColor( 'w+' )
   @  7, 42 SAY ' -- Termin rozp. i zak. okresu ˜w. usˆ'
   ColStd()
   @  8, 42 SAY 'Data rozpocz©cia okresu....' GET dOkresPocz
   @  9, 42 SAY 'Data zakoäczenia okresu....' GET dOkresKon
   Eval( bRoboczaV )

   READ

   IF LastKey() == K_ESC
      RETURN NIL
   ENDIF

   nMenu := 0

   DO WHILE .T.
      SetColor( 'w+' )
      @ 19, 42 TO 19, 79
      ColPro()
      @ 20, 42 CLEAR TO 20, 79
      @ 20, 42 PROMPT '         UTWàRZ eDEKLARACJ¨           '
      @ 21, 42 PROMPT '         DRUKUJ DEKLARACJ¨            '
      @ 22, 42 PROMPT ' KOREKTY KWOT PDATKU VAT (SEKCJA C.5) '

      MENU TO nMenu

      IF LastKey() == K_ESC
         RETURN NIL
      ENDIF

      IF nMenu == 3
         OSSKorektyVIU_DO()
      ENDIF

      IF nMenu == 1 .OR. nMenu == 2
         aDane := {=>}

         IF Empty( aDaneOSS )
            DO WHILE ! DostepPro( 'OSSREJ', , .T., , 'OSSREJ' )
            ENDDO
            aDaneOSS := RejestrOSSDane( .F. )
            ossrej->( dbCloseArea() )
         ENDIF

         aDane[ 'sekcja_c2' ] := RejestrOSSDaneSum( aDaneOSS, .T. )
         aDane[ 'sekcja_c3' ] := OSSSekcjaC3Dane( aDaneOSS )
         aDane[ 'sekcja_c5' ] := OSSKorektyVIU_DODane()
         aDane[ 'suma_vat' ] := 0
         aDane[ 'sekcja_c6' ] := OSSSekcjaC6Dane( aDaneOSS, aDane[ 'sekcja_c5' ], @aDane[ 'suma_vat' ] )

         IF ! JPK_Dane_Firmy( Val( ident_fir ), @aFirma )
            Komun( "Nie udaˆo si© odczyta† danych firmy" )
            RETURN NIL
         ENDIF
         aDane[ 'firma' ] := aFirma

         aDane[ 'kwartal' ] := ObliczKwartal( Val( miesiac ) )[ 'kwarta' ]
         aDane[ 'rok' ] := param_rok
         aDane[ 'kod_urzedu' ] := iif( Empty( param_evku ), aFirma[ 'KodUrzedu' ], param_evku )
         aDane[ 'cel' ] := cRobocza
         aDane[ 'data_wypelnienia' ] := dDataWyp
         aDane[ 'okres_od' ] := dOkresPocz
         aDane[ 'okres_do' ] := dOkresKon

         IF nMenu == 1
            SAVE SCREEN TO cEkran
            cDeklaracja := edek_viudo_2( aDane )
            edekZapiszXML( cDeklaracja, normalizujNazwe( 'VIUDO' + '_' + param_rok + '_' + Str( aDane[ 'kwartal' ], 1, 0 ) + 'KW' ), wys_edeklaracja, 'VIUDO-2', .F., aDane[ 'kwartal' ] )
            RESTORE SCREEN FROM cEkran
         ELSE
            DeklarDrukuj( 'VIUDO-2', aDane )
         ENDIF

      ENDIF

   ENDDO

   RETURN NIL

/*----------------------------------------------------------------------*/
