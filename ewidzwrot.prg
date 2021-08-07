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

PROCEDURE KasyFiskalne()

   LOCAL lPosiadaWpisy, nPopArea
   LOCAL bAktywnyWhen := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( "T - tak    /    N - nie", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bAktywnyValid := { | |
      IF zAKTYWNY $ 'TN'
         @ 24, 0
         @ wiersz, 77 SAY iif( zAKTYWNY == 'T', 'ak', 'ie' )
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   }

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, _top_bot
   PRIVATE zNAZWA, zNUMER, zAKTYWNY, zOPIS

   @ 1, 47 SAY "          "
   *################################# GRAFIKA ##################################
   @  3, 0 SAY Space( 80 )
   @  4, 0 SAY PadC( 'K A S Y    F I S K A L N E', 80 )
   @  5, 0 SAY Space( 80 )
   @  6, 0 SAY '              Nazwa                             Numer seryjny              Aktyw'
   @  7, 0 SAY 'Úֲֲִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ¿'
   @  8, 0 SAY '³                                ³                                         ³   ³'
   @  9, 0 SAY '³                                ³                                         ³   ³'
   @ 10, 0 SAY '³                                ³                                         ³   ³'
   @ 11, 0 SAY '³                                ³                                         ³   ³'
   @ 12, 0 SAY '³                                ³                                         ³   ³'
   @ 13, 0 SAY '³                                ³                                         ³   ³'
   @ 14, 0 SAY '³                                ³                                         ³   ³'
   @ 15, 0 SAY '³                                ³                                         ³   ³'
   @ 16, 0 SAY '³                                ³                                         ³   ³'
   @ 17, 0 SAY '³                                ³                                         ³   ³'
   @ 18, 0 SAY '³                                ³                                         ³   ³'
   @ 19, 0 SAY '³                                ³                                         ³   ³'
   @ 20, 0 SAY '³                                ³                                         ³   ³'
   @ 21, 0 SAY 'ְֱֱִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִÙ'
   @ 22, 0 SAY 'Opis/uwagi:                                                                     '

   IF ! DostepPro( 'KASAFISK', , .T., , 'KASAFISK' )
      RETURN NIL
   ENDIF

   _row_g := 8
   _col_l := 1
   _row_d := 20
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,-4,-5,-37'
   _top := 'kasafisk->firma#ident_fir'
   _bot := "kasafisk->firma#ident_fir"
   _stop := ident_fir
   _sbot := ident_fir + '‏'
   _proc := 'LiniaKasyFiskalne()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'LiniaKasyFiskalneS'
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot

   kasafisk->( dbSeek( _stop ) )

   *----------------------
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
            center( 23, '‏                     ‏' )
            ColSta()
            center( 23, 'W P I S Y W A N I E' )
            ColStd()
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            ColStb()
            center(23, '‏                       ‏' )
            ColSta()
            center(23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
            *ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
            IF ins
               zNAZWA := Space( 32 )
               zNUMER := Space( 64 )
               zAKTYWNY := 'T'
               zOPIS := Space( 255 )
            ELSE
               zNAZWA := kasafisk->nazwa
               zNUMER := kasafisk->numer
               zAKTYWNY := kasafisk->aktywny
               zOPIS := kasafisk->opis
            ENDIF
            *ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
            @ wiersz,  1 GET zNAZWA PICTURE Repl( '!', 32 ) VALID AllTrim( zNAZWA ) <> ""
            @ wiersz, 34 GET zNUMER PICTURE "@S41 " + Repl( '!', 64 ) VALID AllTrim( zNUMER ) <> ""
            @ wiersz, 76 GET zAKTYWNY PICTURE "!" WHEN Eval( bAktywnyWhen ) VALID Eval( bAktywnyValid )
            @ 22, 11 GET zOPIS PICTURE '@S69 ' + Repl( '!', 255 )
            read_()
            IF LastKey() == K_ESC
               EXIT
            ENDIF
            *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
            IF ins
               kasafisk->( dbAppend() )
               kasafisk->firma := ident_fir
            ENDIF
            BlokadaR( 'kasafisk' )
            kasafisk->nazwa := zNAZWA
            kasafisk->numer := zNUMER
            kasafisk->aktywny := zAKTYWNY
            kasafisk->opis := zOPIS
            kasafisk->( dbCommit() )
            kasafisk->( dbRUnlock() )
            *נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
            _row := Int( (_row_g + _row_d ) / 2 )
            IF ! ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '                                ³                                         ³   '
         ENDDO
         _disp := ins .OR. LastKey() # K_ESC
         kl := iif( LastKey() == K_ESC .AND. _row == -1, K_ESC, kl )
         @ 23,0
      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == hb_keyCode( "." )
         @ 1, 47 SAY '          '
         nPopArea := Select()
         IF DostepPro( 'EWIDZWR', , .T., , 'EWIDZWR' )
            lPosiadaWpisy := ewidzwr->( dbSeek( ident_fir + Str( kasafisk->id, 11, 0 ) ) )
            ewidzwr->( dbCloseArea() )
            IF lPosiadaWpisy
               Komun( "Nie mo¾na usun¥† tej kasy. Kasa posiada wpisy." )
            ELSE
               ColStb()
               center( 23, '‏                   ‏' )
               ColSta()
               center( 23, 'K A S O W A N I E' )
               ColStd()
               _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
               IF _disp
                  BlokadaR( 'kasafisk' )
                  kasafisk->( dbDelete() )
                  kasafisk->( dbCommit() )
                  kasafisk->( dbSkip() )
                  IF &_bot
                     kasafisk->( dbSkip( -1 ) )
                  ENDIF
               ENDIF
               @ 23, 0
            ENDIF
         ENDIF
         Select( nPopArea )
      *################################# SZUKANIE #################################
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                 ‏' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         f10 := Space( 32 )
         ColStd()
         @ _row, 8 GET f10 PICTURE Replicate( "!", 32 )
         read_()
         _disp := ! Empty( f10 ) .AND. LastKey() # K_ESC
         IF _disp
            kasafisk->( dbSeek( ident_fir + f10 ) )
            IF &_bot
               kasafisk->( dbSkip( -1 ) )
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
         p[  7 ] := '   [Del]...................kasowanie pozycji            '
         p[  8 ] := '   [F10]...................szukanie                     '
         p[  9 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 10 ] := '                                                        '
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

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION LiniaKasyFiskalne()

   RETURN kasafisk->nazwa + '³' + SubStr( kasafisk->numer, 1, 41 ) + '³' + iif( kasafisk->aktywny == 'T', 'Tak', 'Nie' )

/*----------------------------------------------------------------------*/

PROCEDURE LiniaKasyFiskalneS()

   SET COLOR TO w+
   @ 22, 11 SAY SubStr( kasafisk->opis, 1, 69 )
   SET COLOR TO

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION KasyFiskalnePobierzListe()

   LOCAL aRes := {}

   IF ! DostepPro( 'KASAFISK', , .T., , 'KASAFISK' )
      RETURN aRes
   ENDIF

   kasafisk->( dbSetFilter( { || FIRMA == ident_fir .AND. AKTYWNY == 'T' }, "FIRMA == ident_fir .AND. AKTYWNY == 'T'" ) )
   kasafisk->( dbGoTop() )
   DO WHILE ! kasafisk->( Eof() )
      AAdd( aRes, { 'id' => kasafisk->id, 'nazwa' => kasafisk->nazwa, 'opis' => kasafisk->opis, 'numer' => kasafisk->numer } )
      kasafisk->( dbSkip() )
   ENDDO
   kasafisk->( dbCloseArea() )

   IF Len( aRes ) == 0
      Komun( "Brak zdefiniowanych kas fiskalnych" )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE EwidencjaZwrotowParagonow()

   LOCAL aKasy := KasyfiskalnePobierzListe()
   LOCAL aKasyACh := {}, nKasaPoz
   LOCAL cEkran, cKolor, nBot

   IF Len( aKasy ) > 0
      AEval( aKasy, { | aKasa | AAdd( aKasyACh, aKasa[ 'nazwa' ] ) } )

      cEkran := SaveScreen()
      cKolor := ColInf()

      nBot := iif( Len( aKasy ) > 7, 7, Len( aKasy ) )

      @ 24, 0 SAY PadC( 'Wybierz kas© fiskaln¥', 80 )
      ColPro()
      @ 14, 6 CLEAR TO 15 + nBot, 40
      @ 14, 6 TO 15 + nBot, 40

      nKasaPoz := 1
      DO WHILE nKasaPoz <> 0
         nKasaPoz := AChoice( 15, 7, 14 + nBot, 39, aKasyACh, , , nKasaPoz )
         IF nKasaPoz > 0
            EwidencjaZwrotowParagonowPokaz( aKasy[ nKasaPoz ] )
         ENDIF
      ENDDO

      RestScreen( , , , , cEkran )
      SetColor( cKolor )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE EwidencjaZwrotowParagonowPokaz( aKasa )

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
   LOCAL bSumuj := { | cPole |
      LOCAL cKolor := SetColor()
      IF HB_ISCHAR( cPole )
         SWITCH cPole
         CASE 'A'
            zVATA := _round( zBRUTA * ( vat_A / ( 100 + vat_A ) ), 4 )
            EXIT
         CASE 'B'
            zVATB := _round( zBRUTB * ( vat_B / ( 100 + vat_B ) ), 4 )
            EXIT
         CASE 'C'
            zVATC := _round( zBRUTC * ( vat_C / ( 100 + vat_C ) ), 4 )
            EXIT
         CASE 'D'
            zVATD := _round( zBRUTD * ( vat_D / ( 100 + vat_D ) ), 4 )
            EXIT
         ENDSWITCH
      ENDIF
      SET COLOR TO w+
      @ wiersz, 54 SAY zBRUTA + zBRUTB + zBRUTC + zBRUTD + zBRUTD PICTURE FPIC
      @ wiersz, 67 SAY zVATA + zVATB + zVATC + zVATD PICTURE FPIC
      SetColor( cKolor )
      RETURN .T.
   }

   PRIVATE zDZIEN, zNRDOK, zDATASP, zTOWAR, zCALOSC, zBRUTA, zVATA, zBRUTB, ;
      zVATB, zBRUTC, zVATC, zBRUTD, zVATD, zBRUTE, zUWAGI, zKASA

   @ 24,  0
   @  1, 47 SAY "          "
   *################################# GRAFIKA ##################################
   @  3, 0 SAY PadC( 'EWIDENCJA ZWROTאW I REKLAMACJI', 80 )
   @  4, 0 SAY PadR( 'Kasa fiskalna: ' + aKasa[ 'nazwa' ], 80 )
   @  5, 0 SAY ' Dz. Data sp.     Nr paragonu       Nazwa towaru      Wart. brutto  Wart. VAT   '
   @  6, 0 SAY 'Úֲֲֲֲֲִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ¿'
   @  7, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @  8, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @  9, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @ 10, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @ 11, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @ 12, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @ 13, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @ 14, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @ 15, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @ 16, 0 SAY '³  ³          ³                  ³                   ³            ³            ³'
   @ 17, 0 SAY 'ְֱֱֱֱֱִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִÙ'
   @ 18, 0 SAY 'Stawka      Brutto        VAT                Stawka      Brutto        VAT      '
   @ 19, 0 SAY '  ' + Str( vat_A, 2, 0 ) + '%........                                 ' + Str( vat_B, 2, 0 ) + '%........                       '
   @ 20, 0 SAY '  ' + Str( vat_C, 2, 0 ) + '%........                                 ' + Str( vat_D, 2, 0 ) + '%........                       '
   @ 21, 0 SAY '   0%........                                                                   '
   @ 22, 0 SAY 'Opis/uwagi:                                                                     '

   IF ! DostepPro( 'EWIDZWR', , .T., , 'EWIDZWR' )
      RestScreen( , , , , cEkran )
      SetColor( cKolor )
      RETURN NIL
   ENDIF

   zKASA := aKasa

   _row_g := 7
   _col_l := 1
   _row_d := 16
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,-4,-5,-37,13,73,105'
   _top := "firma#ident_fir.or.kasafid<>zKasa['id'].or.mc#miesiac"
   _bot := "firma#ident_fir.or.kasafid<>zKasa['id'].or.mc#miesiac"
   _stop := ident_fir + Str( aKasa[ 'id' ], 11, 0 ) + miesiac
   _sbot := ident_fir + Str( aKasa[ 'id' ], 11, 0 ) + miesiac + '‏'
   _proc := 'LiniaEwidencjaZwrotu()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'LiniaEwidencjaZwrotuS'
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------

   ewidzwr->( dbSeek( _stop ) )

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
            center( 23, '‏                     ‏' )
            ColSta()
            center( 23, 'W P I S Y W A N I E' )
            ColStd()
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            ColStb()
            center(23, '‏                       ‏' )
            ColSta()
            center(23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
            *ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
            IF ins
               zDZIEN := Str( Day( Date() ), 2 )
               zNRDOK := Space( 64 )
               zDATASP := SToD( '    .  .  ' )
               zTOWAR := Space( 200 )
               zCALOSC := ' '
               zBRUTA := 0
               zVATA := 0
               zBRUTB := 0
               zVATB := 0
               zBRUTC := 0
               zVATC := 0
               zBRUTD := 0
               zVATD := 0
               zBRUTE := 0
               zUWAGI := Space( 255 )
            ELSE
               zDZIEN := ewidzwr->dzien
               zNRDOK := ewidzwr->nrdok
               zDATASP := ewidzwr->datasp
               zTOWAR := ewidzwr->towar
               zCALOSC := ewidzwr->calosc
               zBRUTA := ewidzwr->bruta
               zVATA := ewidzwr->vata
               zBRUTB := ewidzwr->brutb
               zVATB := ewidzwr->vatb
               zBRUTC := ewidzwr->brutc
               zVATC := ewidzwr->vatc
               zBRUTD := ewidzwr->brutd
               zVATD := ewidzwr->vatd
               zBRUTE := ewidzwr->brute
               zUWAGI := ewidzwr->uwagi
            ENDIF
            *ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
            @ wiersz,  1 GET zDZIEN PICTURE '99' VALID Eval( bDzienValid )
            @ wiersz,  4 GET zDATASP VALID ! Empty( zDATASP )
            @ wiersz, 15 GET zNRDOK PICTURE "@S18 " + Repl( '!', 64 ) VALID AllTrim( zNRDOK ) <> ""
            @ wiersz, 34 GET zTOWAR PICTURE "@S19 " + Repl( '!', 200 )
            @ 19,  9 GET zBRUTA PICTURE FPIC VALID Eval( bSumuj, 'A' )
            @ 19, 22 GET zVATA  PICTURE FPIC VALID Eval( bSumuj )
            @ 19, 54 GET zBRUTB PICTURE FPIC VALID Eval( bSumuj, 'B' )
            @ 19, 67 GET zVATB  PICTURE FPIC VALID Eval( bSumuj )
            @ 20,  9 GET zBRUTC PICTURE FPIC VALID Eval( bSumuj, 'C' )
            @ 20, 22 GET zVATC  PICTURE FPIC VALID Eval( bSumuj )
            @ 20, 54 GET zBRUTD PICTURE FPIC VALID Eval( bSumuj, 'D' )
            @ 20, 67 GET zVATD  PICTURE FPIC VALID Eval( bSumuj )
            @ 21,  9 GET zBRUTE PICTURE FPIC VALID Eval( bSumuj )
            @ 22, 11 GET zUWAGI PICTURE "@S69 " + Repl( '!', 255 )
            read_()
            IF LastKey() == K_ESC
               EXIT
            ENDIF
            *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
            IF ins
               ewidzwr->( dbAppend() )
               ewidzwr->firma := ident_fir
               ewidzwr->kasafid := aKasa[ 'id' ]
               ewidzwr->mc := miesiac
            ENDIF
            BlokadaR( 'ewidzwr' )
            ewidzwr->dzien := Str( Val( zDZIEN ), 2, 0 )
            ewidzwr->nrdok := zNRDOK
            ewidzwr->datasp := zDATASP
            ewidzwr->towar := zTOWAR
            ewidzwr->calosc := zCALOSC
            ewidzwr->bruta := zBRUTA
            ewidzwr->vata := zVATA
            ewidzwr->brutb := zBRUTB
            ewidzwr->vatb := zVATB
            ewidzwr->brutc := zBRUTC
            ewidzwr->vatc := zVATC
            ewidzwr->brutd := zBRUTD
            ewidzwr->vatd := zVATD
            ewidzwr->brute := zBRUTE
            ewidzwr->uwagi := zUWAGI
            ewidzwr->( dbCommit() )
            ewidzwr->( dbRUnlock() )
            *נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
            _row := Int( (_row_g + _row_d ) / 2 )
            IF ! ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '  ³          ³                  ³                   ³            ³            '
         ENDDO
         _disp := ins .OR. LastKey() # K_ESC
         kl := iif( LastKey() == K_ESC .AND. _row == -1, K_ESC, kl )
         @ 23,0
      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == hb_keyCode( "." )
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                   ‏' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR( 'ewidzwr' )
            ewidzwr->( dbDelete() )
            ewidzwr->( dbCommit() )
            ewidzwr->( dbSkip() )
            IF &_bot
               ewidzwr->( dbSkip( -1 ) )
            ENDIF
         ENDIF
         @ 23, 0
      *################################# SZUKANIE #################################
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                 ‏' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         f10 := Space( 32 )
         ColStd()
         @ _row, 4 GET f10 PICTURE Replicate( "!", 32 )
         read_()
         _disp := ! Empty( f10 ) .AND. LastKey() # K_ESC
         IF _disp
            ewidzwr->( dbSeek( ident_fir + f10 ) )
            IF &_bot
               ewidzwr->( dbSkip( -1 ) )
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
         p[  7 ] := '   [Del]...................kasowanie pozycji            '
         p[  8 ] := '   [F10]...................szukanie                     '
         p[  9 ] := '   [Enter].................wydruk zestawienia           '
         p[ 10 ] := '   [I].....................informacja podsumowuj¥ca     '
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
            'pozycje' => EwidencjaZwrotowParagonowDane( aKasa ), ;
            'miesiac' => AllTrim( miesiac( Val( miesiac ) ) ), ;
            'rok' => param_rok, ;
            'firma' => AllTrim( aFirma[ 'NAZWA' ] ), ;
            'kasa_nazwa' => aKasa[ 'nazwa' ], ;
            'kasa_nr' => aKasa[ 'numer' ], ;
            'stawka_a' => vat_A, ;
            'stawka_b' => vat_B, ;
            'stawka_c' => vat_C, ;
            'stawka_d' => vat_D ;
         }

         FRDrukuj( 'frf\ewidzwr.frf', aDane )
      *################################### WYDRUK ###############################
      CASE kl == Asc( 'I' ) .OR. kl == Asc( 'i' )
         EwidencjaZwrotowParagonowInfo( aKasa )
      ******************** ENDCASE
      ENDCASE
   ENDDO

   close_()
   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION LiniaEwidencjaZwrotu()

   RETURN ewidzwr->dzien + '³' + DToC( ewidzwr->datasp ) + '³' + ;
     SubStr( ewidzwr->nrdok, 1, 18 ) + '³' + SubStr( ewidzwr->towar, 1, 19 ) + ;
     '³' + Transform( ewidzwr->bruta + ewidzwr->brutb + ewidzwr->brutc + ;
     ewidzwr->brutd + ewidzwr->brute, FPIC ) + '³' + Transform( ewidzwr->vata + ;
     ewidzwr->vatb + ewidzwr->vatc + ewidzwr->vatd, FPIC )

/*----------------------------------------------------------------------*/

PROCEDURE LiniaEwidencjaZwrotuS()

   SET COLOR TO w+
   @ 19,  9 SAY ewidzwr->bruta PICTURE FPIC
   @ 19, 22 SAY ewidzwr->vata  PICTURE FPIC
   @ 19, 54 SAY ewidzwr->brutb PICTURE FPIC
   @ 19, 67 SAY ewidzwr->vatb  PICTURE FPIC
   @ 20,  9 SAY ewidzwr->brutc PICTURE FPIC
   @ 20, 22 SAY ewidzwr->vatc  PICTURE FPIC
   @ 20, 54 SAY ewidzwr->brutd PICTURE FPIC
   @ 20, 67 SAY ewidzwr->vatd  PICTURE FPIC
   @ 21,  9 SAY ewidzwr->brute PICTURE FPIC
   @ 22, 11 SAY SubStr( ewidzwr->uwagi, 1, 69 )
   SET COLOR TO

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION EwidencjaZwrotowParagonowDane( aKasa )

   LOCAL aDane := {}
   LOCAL nRecNo := ewidzwr->( RecNo() )

   ewidzwr->( dbSeek( ident_fir + Str( aKasa[ 'id' ], 11, 0 ) + miesiac ) )
   DO WHILE ewidzwr->firma == ident_fir .AND. ewidzwr->kasafid == aKasa[ 'id' ] .AND. ewidzwr->mc == miesiac .AND. ! ewidzwr->( Eof() )
      AAdd( aDane, { ;
         'dzien' => Val( ewidzwr->dzien ), ;
         'nrdok' => AllTrim( ewidzwr->nrdok ), ;
         'datasp' => ewidzwr->datasp, ;
         'towar' => AllTrim( ewidzwr->towar ), ;
         'calosc' => ewidzwr->calosc, ;
         'bruta' => ewidzwr->bruta, ;
         'vata' => ewidzwr->vata, ;
         'brutb' => ewidzwr->brutb, ;
         'vatb' => ewidzwr->vatb, ;
         'brutc' => ewidzwr->brutc, ;
         'vatc' => ewidzwr->vatc, ;
         'brutd' => ewidzwr->brutd, ;
         'vatd' => ewidzwr->vatd, ;
         'brute' => ewidzwr->brute, ;
         'uwagi' => AllTrim( ewidzwr->uwagi ), ;
         'datazwr' => hb_Date( Val( param_rok ), Val( ewidzwr->mc ), Val( ewidzwr->dzien ) ) ;
      } )
      ewidzwr->( dbSkip() )
   ENDDO
   ewidzwr->( dbGoto( nRecNo ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

PROCEDURE EwidencjaZwrotowParagonowInfo( aKasa )

   LOCAL cRaport, dKlucz
   LOCAL aDane := { 'bruta' => 0, 'brutb' => 0, 'brutc' => 0, 'brutd' => 0, ;
      'brute' => 0, 'vata' => 0, 'vatb' => 0, 'vatc' => 0, 'vatd' => 0, ;
      'danemies' => { => } }
   LOCAL bKwoty := { | aKwoty |
      RETURN '  Stawka            Brutto            VAT             Netto' + hb_eol() + ;
      '  ' + Str( vat_A, 2, 0 ) + '%...........' + Transform( aKwoty[ 'bruta' ], FPIC ) + '     ' + Transform( aKwoty[ 'vata' ], FPIC ) + '     ' + Transform( aKwoty[ 'bruta' ] - aKwoty[ 'vata' ], FPIC ) + hb_eol() + ;
      '  ' + Str( vat_B, 2, 0 ) + '%...........' + Transform( aKwoty[ 'brutb' ], FPIC ) + '     ' + Transform( aKwoty[ 'vatb' ], FPIC ) + '     ' + Transform( aKwoty[ 'brutb' ] - aKwoty[ 'vatb' ], FPIC ) + hb_eol() + ;
      '  ' + Str( vat_C, 2, 0 ) + '%...........' + Transform( aKwoty[ 'brutc' ], FPIC ) + '     ' + Transform( aKwoty[ 'vatc' ], FPIC ) + '     ' + Transform( aKwoty[ 'brutc' ] - aKwoty[ 'vatc' ], FPIC ) + hb_eol() + ;
      '  ' + Str( vat_D, 2, 0 ) + '%...........' + Transform( aKwoty[ 'brutd' ], FPIC ) + '     ' + Transform( aKwoty[ 'vatd' ], FPIC ) + '     ' + Transform( aKwoty[ 'brutd' ] - aKwoty[ 'vatd' ], FPIC ) + hb_eol() + ;
      '   0%...........' + Transform( aKwoty[ 'brute' ], FPIC ) + hb_eol() + ;
      '                ----------------------------------------' + hb_eol() + ;
      '   razem........' + Transform( aKwoty[ 'bruta' ] + aKwoty[ 'brutb' ] + aKwoty[ 'brutc' ] + aKwoty[ 'brutd' ] + aKwoty[ 'brute' ], FPIC ) + '     ' + Transform( aKwoty[ 'vata' ] + aKwoty[ 'vatb' ] + aKwoty[ 'vatc' ] + aKwoty[ 'vatd' ], FPIC ) + hb_eol()
   }

   AEval( EwidencjaZwrotowParagonowDane( aKasa ), { | aPoz |
      LOCAL dDataKlucz
      aDane[ 'bruta' ] += aPoz[ 'bruta' ]
      aDane[ 'brutb' ] += aPoz[ 'brutb' ]
      aDane[ 'brutc' ] += aPoz[ 'brutc' ]
      aDane[ 'brutd' ] += aPoz[ 'brutd' ]
      aDane[ 'brute' ] += aPoz[ 'brute' ]
      aDane[ 'vata' ] += aPoz[ 'vata' ]
      aDane[ 'vatb' ] += aPoz[ 'vatb' ]
      aDane[ 'vatc' ] += aPoz[ 'vatc' ]
      aDane[ 'vatd' ] += aPoz[ 'vatd' ]
      dDataKlucz := hb_Date( Year( aPoz[ 'datasp' ] ), Month( aPoz[ 'datasp' ] ), 1 )
      IF ! hb_HHasKey( aDane[ 'danemies' ], dDataKlucz )
         aDane[ 'danemies' ][ dDataKlucz ] := { 'bruta' => 0, 'brutb' => 0, ;
         'brutc' => 0, 'brutd' => 0, 'brute' => 0, 'vata' => 0, 'vatb' => 0, ;
         'vatc' => 0, 'vatd' => 0 }
      ENDIF
      aDane[ 'danemies' ][ dDataKlucz ][ 'bruta' ] += aPoz[ 'bruta' ]
      aDane[ 'danemies' ][ dDataKlucz ][ 'brutb' ] += aPoz[ 'brutb' ]
      aDane[ 'danemies' ][ dDataKlucz ][ 'brutc' ] += aPoz[ 'brutc' ]
      aDane[ 'danemies' ][ dDataKlucz ][ 'brutd' ] += aPoz[ 'brutd' ]
      aDane[ 'danemies' ][ dDataKlucz ][ 'brute' ] += aPoz[ 'brute' ]
      aDane[ 'danemies' ][ dDataKlucz ][ 'vata' ] += aPoz[ 'vata' ]
      aDane[ 'danemies' ][ dDataKlucz ][ 'vatb' ] += aPoz[ 'vatb' ]
      aDane[ 'danemies' ][ dDataKlucz ][ 'vatc' ] += aPoz[ 'vatc' ]
      aDane[ 'danemies' ][ dDataKlucz ][ 'vatd' ] += aPoz[ 'vatd' ]
   } )
   cRaport := ;
      'Miesi¥c: ' + AllTrim( miesiac( Val( miesiac ) ) ) + '    ' + param_rok + hb_eol() + ;
      'Kasa fiskalna: ' + AllTrim( aKasa[ 'nazwa' ] ) + hb_eol() + ;
      'Numer seryjny: ' + AllTrim( aKasa[ 'numer' ] ) + hb_eol() + hb_eol() + ;
      Eval( bKwoty, aDane )

   hb_HSort( aDane[ 'danemies' ] )
   AEval( hb_HKeys( aDane[ 'danemies' ] ), { | dKey |
      cRaport += hb_eol() + hb_eol() + ;
         '------------------------------------' + hb_eol() + ;
         'ZAKUPY DOKONANE W MIESI₪CU ' + miesiac( Month( dKey ) ) + Str( Year( dKey ), 4, 0 ) + hb_eol() + hb_eol() + ;
         Eval( bKwoty, aDane[ 'danemies' ][ dKey ] )
   } )

   WyswietlTekst( cRaport )

   RETURN NIL

/*----------------------------------------------------------------------*/

