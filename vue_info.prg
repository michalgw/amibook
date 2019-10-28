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

PROCEDURE VUE_Info()

   *para _G,_M,_STR,_OU
   RAPORT := RAPTEMP
   PRIVATE P4, P5, P6, P6a, P7, P8
   PRIVATE P11, P16, P17, P17a, P18, P19
   PRIVATE P20, P21, P22, P23, P24, P26, P29
   PRIVATE P35, P36, P37, P38, P39
   PRIVATE P40, P41, P42, P43, P44, P45, P46, P47, P48, P49
   PRIVATE P50, P51, P52, P53, P54, P55, P56, P57, P58, P59
   PRIVATE P60, P61, P62, P61a, P62a, P64, P66, P68
   STORE 0 TO P22, P23, P26, P35, P36, P37, P38
   STORE 0 TO P39, P40, P41, P42, P43, P44, P45, P46, P47, P48, P49, P50, P51, P52, P53, P54, P55
   STORE 0 TO P56, P57, P58, P59, P60, P61, P62, P61a, P62a, P64, P66, P68
   STORE '' TO P4, P5, P6, P7, P8, P11, P16, P17, P17a, P18, P19, P20, P21, P29
   zWERVAT := '    '
   _czy_close := .F.
   spolka_ := .F.

   *#################################     VAT_7      #############################
   BEGIN SEQUENCE
      zWERVAT := '(2) '
      _koniec := "del#[+].or.firma#ident_fir.or.mc#miesiac"

      ColInb()
      @ 24, 0
      center( 24, 'Prosz&_e. czeka&_c....' )
      ColStd()
      IF LastKey() == K_ESC
         BREAK
      ENDIF
      KONIEC1 := .F.

      SELECT 7
      IF Dostep( 'SPOLKA' )
         SetInd( 'SPOLKA' )
         SEEK '+' + ident_fir
      ELSE
         BREAK
      ENDIF
      IF del # '+' .OR. firma # ident_fir
         kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej opcji ' )
         BREAK
      ENDIF
*--------------------------------------
      SELECT 6
      IF Dostep( 'URZEDY' )
         SET INDEX TO urzedy
      ELSE
         BREAK
      ENDIF

      SELECT 5
      IF Dostep( 'REJZ' )
         SetInd( 'REJZ' )
         SEEK '+' + IDENT_FIR + miesiac
*         KONIEC1=&_koniec
      ELSE
         BREAK
      ENDIF

      SELECT 4
      IF Dostep( 'KONTR' )
         SetInd( 'KONTR' )
      ELSE
         BREAK
      ENDIF

      SELECT 3
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
         spolka_ := spolka
      ELSE
         BREAK
      ENDIF

      SELECT 1
      IF Dostep( 'REJS' )
         SetInd( 'REJS' )
         SEEK '+' + IDENT_FIR + miesiac
      ELSE
         BREAK
      ENDIF

      STORE 0 TO p45, p46, p47, p48, p49, p50, p51, p52, p61, p62, p61a, p62a, p64, p65, ;
         p67, p69, p70, p71, p72, p75, p76, p77, p78, p79, p98, p99
      STORE 0 TO pp8, pp9, pp10, pp11, pp12, pp13, kkasa_odl, kkasa_zwr, p37, p38, p39, p40, p41, p42, p43, p44

      //tworzenie bazy roboczej
      *if file('ROBVATUE.dbf')=.f.
      dbCreate( "ROBVATUE", { ;
         { "REJ",      "C", 1, 0 }, ;
         { "KOREKTA",  "C", 1, 0 }, ;
         { "USLUGA",   "C", 1, 0 }, ;
         { "KRAJ",     "C", 2, 0 }, ;
         { "VATID",    "C", 30, 0 }, ;
         { "TROJCA",   "C", 1, 0 }, ;
         { "WARTOSC",  "N", 12, 2 } } )
 *      endif
      SELECT 2
      IF DostepEx( 'ROBVATUE' )
*         zap
         INDEX ON rej + kraj + vatid + usluga + trojca TO robvatue
      ELSE
         BREAK
      ENDIF

*     do while .not. dostepex('ROBVATUE')
*     enddo
*     zap
*     index on rej+korekta+kraj+vatid+trojca to robvatue

      SELECT rejs
      DO WHILE ! &_koniec
         IF UE == 'T'
            sumuenet := wartzw + wart00 + wart02 + wart07 + wart22 + wart12
            zwart08 := wart08
            ztrojstr := iif( trojstr == ' ', 'N', trojstr )
            IF sumuenet <> 0.0
               vidue := PadR( iif( SubStr( a->Nr_ident, 3, 1 ) == '-', SubStr( a->Nr_ident, 4 ), a->Nr_ident ), 30, ' ' )
               SELECT 2
               SEEK 'S' + a->Kraj + vidue + 'N' + ztrojstr
               IF Found() .AND. rej + kraj + vatid + usluga + trojca == 'S' + A->Kraj + vidue + 'N' + ztrojstr
                  REPLACE Wartosc WITH Wartosc + sumuenet
                  commit_()
               ELSE
                  APPEND BLANK
                  REPLACE rej WITH 'S', korekta WITH A->korekta, kraj WITH A->Kraj, vatid WITH vidue, wartosc WITH sumuenet, usluga WITH 'N', trojca WITH ztrojstr
                  commit_()
               ENDIF
            ENDIF
            IF zwart08 <> 0.0
               vidue := PadR( iif( SubStr( a->Nr_ident, 3, 1 ) == '-', SubStr( a->Nr_ident, 4 ), a->Nr_ident ), 30, ' ' )
               SELECT 2
               SEEK 'S' + a->Kraj + vidue + 'T' + ztrojstr
               IF Found() .AND. rej + kraj + vatid + usluga + trojca == 'S' + A->Kraj + vidue + 'T' + ztrojstr
                  REPLACE Wartosc WITH Wartosc+zwart08
                  commit_()
               ELSE
                  APPEND BLANK
                  REPLACE rej WITH 'S', korekta WITH A->korekta, kraj WITH A->Kraj, vatid WITH vidue, wartosc WITH zwart08, usluga WITH 'T', trojca WITH ztrojstr
                  commit_()
               ENDIF
            ENDIF
         ENDIF
         SELECT rejs
         SKIP 1
      ENDDO

      SELECT rejz
      DO WHILE ! &_koniec
         IF rach == 'F' .AND. UE == 'T' .AND. ( SEK_CV7 == 'WT' .OR. SEK_CV7 == 'WS' )
            STORE 0 TO p45ue, p47ue, p47aue, p49ue, p51ue, p51aue
            p45ue := iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) ;
               + iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) ;
               + iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + iif( SPZW == 'S', WARTZW, 0 )
            p47ue := iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) ;
               + iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) ;
               + iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
            p47aue := iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) ;
               + iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) ;
               + iif( SP00 == 'S' .AND. ZOM00 =='Z', WART00, 0 )

            p49ue := iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) ;
               + iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) ;
               + iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + iif( SPZW == 'P', WARTZW, 0 )
            p51ue := iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) ;
               + iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) ;
               + iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
            p51aue := iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) ;
               + iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) ;
               + iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

            p65dekue := p45ue + p47ue + p47aue + p49ue + p51ue + p51aue

            ztrojstr := iif( trojstr == ' ', 'N', trojstr )

            IF p65dekue <> 0.0
               vidue := PadR( iif( SubStr( e->Nr_ident, 3, 1 ) == '-', SubStr( e->Nr_ident, 4 ), e->Nr_ident ), 30, ' ' )
               SELECT 2
               SEEK 'Z' + e->Kraj + vidue + 'N' + ztrojstr
               IF Found() .AND. rej + kraj + vatid + trojca == 'Z' + e->Kraj + vidue + ztrojstr
                  REPLACE Wartosc WITH Wartosc + p65dekue
               ELSE
                  APPEND BLANK
                  REPLACE rej WITH 'Z', korekta WITH e->korekta, kraj WITH e->Kraj, vatid WITH vidue, wartosc WITH p65dekue, usluga WITH 'N', trojca WITH ztrojstr
                  commit_()
               ENDIF
            ENDIF
         ENDIF
         SELECT rejz
         SKIP 1
      ENDDO

      STORE 0 TO UEALL, UE, UEA, UEB, UEK, UEZAK, UESPR, UEZAKKOR, UESPRKOR, UEUSL
      STORE 0 TO ROBZAKKOR, ROBSPRKOR, ROBSPR, ROBZAK, ROBUSL
      SELECT 2
      GO TOP
      DO WHILE ! Eof()
         DO CASE
            CASE rej == 'S' .AND. usluga == 'N'
              UESPR := UESPR + 1

            CASE rej == 'S' .AND. usluga == 'T'
              UEUSL := UEUSL + 1

            CASE rej == 'Z'
              UEZAK := UEZAK + 1
         ENDCASE
         SKIP
      ENDDO
*      ROBZAKKOR=_int(UEZAKKOR/6)
*      if UEZAKKOR-(ROBZAKKOR*6)>0
*         ROBZAKKOR=ROBZAKKOR+1
*      endif
*      ROBSPRKOR=_int(UESPRKOR/6)
*      if UESPRKOR-(ROBSPRKOR*6)>0
*         ROBSPRKOR=ROBSPRKOR+1
*      endif
*      UEK=max(ROBSPRKOR,ROBZAKKOR)
      UE := 1
      IF UESPR > 0 .OR. UEZAK > 0 .OR. UEUSL > 0
         IF UESPR > 12
            ROBSPR := _int( ( UESPR - 12 ) / 59 )
            IF ( UESPR + 12 ) - ( ROBSPR * 59 ) > 0
               ROBSPR := ROBSPR + 1
            ENDIF
         ENDIF
         IF UEZAK > 12
            ROBZAK := _int( ( UEZAK - 12 ) / 59 )
            IF ( UEZAK + 12 ) - ( ROBZAK * 59 ) > 0
               ROBZAK := ROBZAK + 1
            ENDIF
         ENDIF
         IF UEUSL > 12
            ROBUSL := _int( ( UEUSL - 12 ) / 59 )
            IF ( UEUSL + 12 ) - ( ROBUSL * 59 ) > 0
               ROBUSL := ROBUSL + 1
            ENDIF
         ENDIF
      ENDIF
      UEALL := UE + ROBZAK + ROBSPR + ROBUSL
      IF UEALL == 0
*         kom(5,[*u],[ Nie znaleziono dokument&_o.w do formularzy VAT-UE ])
*         break
          UEALL := 1
      ENDIF
      vmmm := Array( UEALL )
      xUE := 1
*      if UE>0
      vmmm[ 1 ] := ' VAT-UE       (4)                    '
*      endif
      IF ROBSPR > 0
         FOR xUE := 1 + UE TO ROBSPR + UE
            vmmm[ xUE ] := ' VAT-UE/A (' + Str( xUE - UE, 2 ) + ')(4)                    '
         NEXT
      ENDIF
      IF ROBZAK > 0
         FOR xUE := 1 + UE + ROBSPR TO ROBZAK + UE + ROBSPR
            vmmm[ xUE ] := ' VAT-UE/B (' + Str( xUE - ( UE + ROBSPR ), 2 ) + ')(4)                    '
         NEXT
      ENDIF
      IF ROBUSL > 0
         FOR xUE := 1 + UE + ROBSPR + ROBZAK TO ROBSPR + UE + ROBZAK + ROBUSL
            vmmm[ xUE ] := ' VAT-UE/C (' + Str( xUE - ( UE + ROBSPR + ROBZAK ), 2 ) + ')(4)                    '
         NEXT
      ENDIF
      AAdd(vmmm, ' VAT-UE       (4)   druk graficzny   ')
      AAdd(vmmm, ' VAT-UE       (4)   eDeklaracja      ')
*      if UEK>0
*         for xUE=1+UE+ROBSPR+ROBZAK to UEK+ROBZAK+UE+ROBSPR
*             vmmm[xUE]:=[ VAT-UEK  (]+str(xUE-(UE+ROBSPR+ROBZAK),2)+[)(1)  (GZELLA VI/2004)  ]
*         next
*      endif
      STORE 0 TO gora
      IF UEALL < 4
         gora := 17
      ELSE
         gora := 21 - UEALL
      ENDIF

      SELECT firma
      P4 := nip
*     P5a=miesiac
      P5b := param_rok
      SELECT urzedy
      IF firma->skarb > 0
         GO firma->skarb
         P6 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' ;
            + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
         P6a := AllTrim( kodurzedu )
      ELSE
         P6 := Space( 60 )
         P6a := ''
      ENDIF
      IF spolka_
         SELECT firma
         P8 := AllTrim( nazwa ) + ', ' + SubStr( NR_REGON, 3, 9 )
         P8n := AllTrim( nazwa )
//         P11=space(10)
         P11 := SubStr( NR_REGON, 3, 9 )
      ELSE
         SELECT spolka
         SEEK '+' + ident_fir + firma->nazwisko
         IF Found()
            P8 := SubStr( NAZ_IMIE, 1, At( ' ', NAZ_IMIE ) )
            subim := SubStr( NAZ_IMIE, At( ' ', NAZ_IMIE ) + 1 )
            P8 := P8 + iif( At( ' ', subim ) == 0, subim, SubStr( subim, 1, At( ' ', subim ) ) )
            P11 := DToC( data_ur )
            P11d := data_ur
            P8ni := AllTrim( naz_imie )
         ELSE
            P8 := Space( 60 )
            P11 := Space( 10 )
         ENDIF
      ENDIF
      IF spolka_
         SELECT firma
         P16 := tlx
         P17 := param_woj
         P17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := nr_domu
         P21 := nr_mieszk
         P22 := miejsc
         P23 := kod_p
         P24 := poczta
         P26 := tel
      else
         sele spolka
*        go nr_rec
         P16 := kraj
         P17 := param_woj
         P17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := Left( nr_domu, 5 )
         P21 := Left( nr_mieszk, 5 )
         P22 := miejsc_zam
         P23 := kod_poczt
         P24 := poczta
         P26 := telefon
      endif
*     sele firma
*     do case
*     case k281=1
*          p29=space(16)+'XXX'
*     case k281=2
*          p29=space(36)+'XXX'
*     case k281=3
*          p29=space(51)+'XXX'
*     endcase


      @ 24, 0

      xUE := 0
      opcja1v := 1
      SAVE SCREEN TO ROBSO11v
      DO WHILE .T.
         *=============================
         ColPro()
         @ gora, 1 TO gora + 1 + UEALL + 2, 39
         FOR xUE := 1 TO Len( vmmm )
            @ gora + xUE, 2 PROMPT vmmm[ xUE ]
         NEXT
         opcja1v := menu( opcja1v )
         ColStd()
         if lastkey() == K_ESC
            EXIT
         ENDIF
         *=============================
         SAVE SCREEN TO scr22v
         papier := 'K'
         IF opcja1v >= Len( vmmm ) - 1

            PRIVATE aUEs, aUEz, aUEu, elemUE
            // Cza przepisac dane

            aUEs := {}
            SELECT 2
            SEEK 'S'
            DO WHILE ! Eof()
               IF REJ == 'S' .AND. usluga == 'N'
                  elemUE := Array( 4 )
                  elemUE[ 1 ] := kraj
                  elemUE[ 2 ] := VATid
                  elemUE[ 3 ] := wartosc
                  elemUE[ 4 ] := iif( trojca == 'T', .T., .F. )
                  AAdd( aUEs, elemUE )
               ENDIF
               SKIP
            ENDDO

            aUEz := {}
            SELECT 2
            SEEK 'Z'
            DO WHILE ! Eof()
               IF REJ == 'Z'
                  elemUE := Array(4)
                  elemUE[ 1 ] := kraj
                  elemUE[ 2 ] := VATid
                  elemUE[ 3 ] := wartosc
                  elemUE[ 4 ] := iif( trojca == 'T', .T., .F. )
                  AAdd( aUEz, elemUE )
               ENDIF
               SKIP
            ENDDO

            aUEu := {}
            SELECT 2
            SEEK 'S'
            DO WHILE ! Eof()
               IF REJ == 'S' .AND. usluga == 'T'
                  elemUE := Array( 4 )
                  elemUE[1] := kraj
                  elemUE[2] := VATid
                  elemUE[3] := wartosc
                  elemUE[4] := iif( trojca == 'T', .T., .F. )
                  AAdd( aUEu, elemUE )
               ENDIF
               SKIP
            ENDDO

            zDEKLNAZWI := firma->DEKLNAZWI
            zDEKLIMIE := firma->DEKLIMIE
            zDEKLTEL := firma->DEKLTEL

            IF opcja1v == Len( vmmm )

               PRIVATE zawartoscXml
               edeklaracja_plik = 'VATUE_4_' + normalizujNazwe( AllTrim( symbol_fir ) ) + '_' + AllTrim( miesiac )
               zawartoscXml = edek_vatue_4()
               edekZapiszXml( zawartoscXml, edeklaracja_plik, wys_edeklaracja, 'VATUE-4', .F., Val( miesiac ) )

            ELSE

               DeklarDrukuj( 'VATUE-4' )

            ENDIF

         ELSE
            IF At( 'UE  ', vmmm[ opcja1v ] ) > 0
   *           set curs on
   *           ColStd()
   *           @ gora+opcja1v,15 say space(23)
   *           @ gora+opcja1v,22 get papier pict '!' when wKART(gora+opcja1v,22) valid vKART(gora+opcja1v,22)
   *           read
   *           set curs off
   *           @ 24,0
   *           if lastkey()<>27
   *              if papier='K'
               vat_ue( 0, 0, 1, 'K' )
   *              else
   *                 afill(nazform,'')
   *                 afill(strform,0)
   *                 nazform[1]='VAT-UE'
   *                 strform[1]=2
   *                 form(nazform,strform,1)
   *              endif
   *           endif
            ENDIF
            IF At( 'UE/A', vmmm[ opcja1v ] ) > 0
               numzal := Val( AllTrim( SubStr( vmmm[ opcja1v ], 12, 2 ) ) )
   *           set curs on
   *           ColStd()
   *           @ gora+opcja1v,15 say space(23)
   *           @ gora+opcja1v,22 get papier pict '!' when wKART(gora+opcja1v,22) valid vKART(gora+opcja1v,22)
   *           read
   *           set curs off
   *           @ 24,0
   *           if lastkey()<>27
   *              if papier='K'
               vat_uea( 0, 0, 1, 'K' )
   *              else
   *                 afill(nazform,'')
   *                 afill(strform,0)
   *                 nazform[1]='VAT-UEA'
   *                 strform[1]=2
   *                 form(nazform,strform,1)
   *              endif
   *           endif
            ENDIF
            IF At( 'UE/B', vmmm[ opcja1v ] ) > 0
               numzal := Val( AllTrim( SubStr( vmmm[ opcja1v ], 12, 2 ) ) )
   *            set curs on
   *            ColStd()
   *            @ gora+opcja1v,15 say space(23)
   *            @ gora+opcja1v,22 get papier pict '!' when wKART(gora+opcja1v,22) valid vKART(gora+opcja1v,22)
   *            read
   *            set curs off
   *            @ 24,0
   *            if lastkey()<>27
   *               if papier='K'
               vat_ueb( 0, 0, 1, 'K' )
   *               else
   *                  afill(nazform,'')
   *                  afill(strform,0)
   *                  nazform[1]='VAT-UEB'
   *                  strform[1]=2
   *                  form(nazform,strform,1)
   *               endif
   *            endif
            ENDIF
            IF At( 'UE/C', vmmm[ opcja1v ] ) > 0
               numzal := Val( AllTrim( SubStr( vmmm[ opcja1v ], 12, 2 ) ) )
   *            set curs on
   *            ColStd()
   *            @ gora+opcja1v,15 say space(23)
   *            @ gora+opcja1v,22 get papier pict '!' when wKART(gora+opcja1v,22) valid vKART(gora+opcja1v,22)
   *            read
   *            set curs off
   *            @ 24,0
   *            if lastkey()<>27
   *               if papier='K'
               vat_uec( 0, 0, 1, 'K' )
   *               else
   *                  afill(nazform,'')
   *                  afill(strform,0)
   *                  nazform[1]='VAT-UEC'
   *                  strform[1]=2
   *                  form(nazform,strform,1)
   *               endif
   *            endif
            ENDIF

   *         if at('UEK ',vmmm[opcja1v])>0
   *            numzal=val(alltrim(substr(vmmm[opcja1v],12,2)))
   *            set curs on
   *            ColStd()
   *            @ gora+opcja1v,15 say space(23)
   *            @ gora+opcja1v,22 get papier pict '!' when wKART(gora+opcja1v,22) valid vKART(gora+opcja1v,22)
   *            read
   *            set curs off
   *            @ 24,0
   *            if lastkey()<>27
   *               if papier='K'
   *                  do vat_uek with 0,0,1,'K'
   *               else
   *                  afill(nazform,'')
   *                  afill(strform,0)
   *                  nazform[1]='VAT-UEK'
   *                  strform[1]=2
   *                  form(nazform,strform,1)
   *               endif
   *            endif
   *         endif
         ENDIF
         RESTORE SCREEN FROM SCR22v
      ENDDO
      RESTORE SCREEN FROM ROBSO11v
   END

   IF _czy_close
      close_()
   ENDIF

   RETURN
