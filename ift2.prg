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

#include "Inkey.ch"
#include "achoice.ch"

PROCEDURE IFT2_Dane( cTablica, dDataOd, dDataDo )

   LOCAL aRes := {}, aPoz, nPoz

   DO WHILE ! DostepPro( cTablica, , .T., "DANE", cTablica )
   ENDDO
   dane->( dbSetOrder( 1 ) )

   dane->( dbSeek( "+" + ident_fir + Str( Month( dDataOd ), 2 ) + Str( Day( dDataOd ), 2 ) ) )
   DO WHILE dane->del == "+" .AND. dane->firma == ident_fir ;
      .AND. hb_Date( Val( param_rok ), Val( dane->mc ), Val( dane->dzien ) ) >= dDataOd ;
      .AND. hb_Date( Val( param_rok ), Val( dane->mc ), Val( dane->dzien ) ) <= dDataDo

      IF dane->ift2 == 'T'
         IF ( nPoz := AScan( aRes, { | aEl | aEl[ 'nip' ] == dane->nr_ident .AND. aEl[ 'nazwa' ] == dane->nazwa } ) ) > 0
            aPoz := aRes[ nPoz ]
         ELSE

            aPoz := { ;
               'nip' => dane->nr_ident, ;
               'nazwa' => dane->nazwa, ;
               'poz' => {}, ;
               'D1D' => 0, ;
               'D1E' => 0, ;
               'D1F' => 0, ;
               'D1G' => 0, ;
               'D2D' => 0, ;
               'D2E' => 0, ;
               'D2F' => 0, ;
               'D2G' => 0, ;
               'D3D' => 0, ;
               'D3E' => 0, ;
               'D3F' => 0, ;
               'D3G' => 0, ;
               'D4D' => 0, ;
               'D4E' => 0, ;
               'D4F' => 0, ;
               'D4G' => 0, ;
               'D5D' => 0, ;
               'D5E' => 0, ;
               'D5F' => 0, ;
               'D5G' => 0, ;
               'D6D' => 0, ;
               'D6E' => 0, ;
               'D6F' => 0, ;
               'D6G' => 0, ;
               'D7D' => 0, ;
               'D7E' => 0, ;
               'D7F' => 0, ;
               'D7G' => 0, ;
               'D8D' => 0, ;
               'D8E' => 0, ;
               'D8F' => 0, ;
               'D8G' => 0, ;
               'D9D' => 0, ;
               'D9E' => 0, ;
               'D9F' => 0, ;
               'D9G' => 0, ;
               'D10D' => 0, ;
               'D10E' => 0, ;
               'D10F' => 0, ;
               'D10G' => 0, ;
               'D11D' => 0, ;
               'D11E' => 0, ;
               'D11F' => 0, ;
               'D11G' => 0, ;
               'D12D' => 0, ;
               'D12E' => 0, ;
               'D12F' => 0, ;
               'D12G' => 0, ;
               'K01' => 0, ;
               'K02' => 0, ;
               'K03' => 0, ;
               'K04' => 0, ;
               'K05' => 0, ;
               'K06' => 0, ;
               'K07' => 0, ;
               'K08' => 0, ;
               'K09' => 0, ;
               'K10' => 0, ;
               'K11' => 0, ;
               'K12' => 0, ;
               'K13' => 0, ;
               'K14' => 0, ;
               'K15' => 0, ;
               'K16' => 0, ;
               'K17' => 0, ;
               'K18' => 0, ;
               'K19' => 0, ;
               'K20' => 0, ;
               'K21' => 0, ;
               'K22' => 0, ;
               'K23' => 0, ;
               'P01' => 0, ;
               'P02' => 0, ;
               'P03' => 0, ;
               'P04' => 0, ;
               'P05' => 0, ;
               'P06' => 0, ;
               'P07' => 0, ;
               'P08' => 0, ;
               'P09' => 0, ;
               'P10' => 0, ;
               'P11' => 0, ;
               'P12' => 0, ;
               'P13' => 0, ;
               'P14' => 0, ;
               'P15' => 0, ;
               'P16' => 0, ;
               'P17' => 0, ;
               'P18' => 0, ;
               'P19' => 0, ;
               'P20' => 0, ;
               'P21' => 0, ;
               'P22' => 0, ;
               'P23' => 0, ;
               'KR' => 0, ;
               'PR' => 0, ;
               'miesiace' => 12, ;
               'data_zl' => SToD( '' ), ;
               'data_prz' => SToD( '' ) ;
            }

            KontrahZnajdzIFT2( dane->nr_ident, @aPoz )

            AAdd( aRes, aPoz )

         ENDIF

         AAdd( aPoz[ 'poz' ], { ;
            'numer' => dane->numer, ;
            'miesiac' => dane->mc, ;
            'ift2sek' => dane->ift2sek, ;
            'ift2kwot' => dane->ift2kwot ;
         } )

         SWITCH Val( dane->ift2sek )
         CASE 1
            aPoz[ 'D1D' ] := aPoz[ 'D1D' ] + dane->ift2kwot
            EXIT
         CASE 2
            aPoz[ 'D2D' ] := aPoz[ 'D2D' ] + dane->ift2kwot
            EXIT
         CASE 3
            aPoz[ 'D3D' ] := aPoz[ 'D3D' ] + dane->ift2kwot
            EXIT
         CASE 4
            aPoz[ 'D4D' ] := aPoz[ 'D4D' ] + dane->ift2kwot
            EXIT
         CASE 5
            aPoz[ 'D5D' ] := aPoz[ 'D5D' ] + dane->ift2kwot
            EXIT
         CASE 6
            aPoz[ 'D6D' ] := aPoz[ 'D6D' ] + dane->ift2kwot
            EXIT
         CASE 7
            aPoz[ 'D7D' ] := aPoz[ 'D7D' ] + dane->ift2kwot
            EXIT
         CASE 8
            aPoz[ 'D8D' ] := aPoz[ 'D8D' ] + dane->ift2kwot
            EXIT
         CASE 9
            aPoz[ 'D9D' ] := aPoz[ 'D9D' ] + dane->ift2kwot
            EXIT
         CASE 10
            aPoz[ 'D10D' ] := aPoz[ 'D10D' ] + dane->ift2kwot
            EXIT
         CASE 11
            aPoz[ 'D11D' ] := aPoz[ 'D11D' ] + dane->ift2kwot
            EXIT
         CASE 12
            aPoz[ 'D12D' ] := aPoz[ 'D12D' ] + dane->ift2kwot
            EXIT
         ENDSWITCH

      ENDIF

      dane->( dbSkip() )

   ENDDO

   dane->( dbCloseArea() )

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE IFT2_Rob()

   LOCAL aDane, cRoczna, dDataOd, dDataDo, cEkran, cKolor
   LOCAL oDataOd, oDataDo
   LOCAL bDekRocz := { | |
      IF cRoczna $ 'NT'
         IF cRoczna == 'T'
            dDataOd := hb_Date( Val( param_rok ), 1, 1 )
            dDataDo := EoM( hb_Date( Val( param_rok ), 12, 1 ) )
         ELSE
            dDataOd := hb_Date( Val( param_rok ), Val( miesiac ), 1 )
            dDataDo := EoM( hb_Date( Val( param_rok ), Val( miesiac ), 1 ) )
         ENDIF
         SET COLOR TO W+
         @ 5, 70 SAY iif( cRoczna == 'T', 'ak', 'ie' )
         ColStd()
         oDataOd:display()
         oDataDo:display()
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   }

   IF zRYCZALT == 'T' .OR. zVAT <> 'T'
      Komun( 'Opcja nie dost©pna' )
      RETURN NIL
   ENDIF

   cEkran := SaveScreen()
   cKolor := ColStd()
   cRoczna := iif( miesiac == '12', 'T', 'N' )
   dDataOd := Date()
   dDataDo := Date()

   @  3, 42 CLEAR TO 22, 79

   SET COLOR TO W+
   @ 5, 70 SAY iif( cRoczna == 'T', 'ak', 'ie' )
   ColStd()

   @  3, 42 SAY ' -- DEKLARACJA IFT-2/2R --  '
   @  5, 42 SAY ' Deklalar. roczna(Tak/Nie)' GET cRoczna PICTURE '!' VALID Eval( bDekRocz )
   @  6, 42 SAY '    Deklaracja za okres od' GET dDataOd
   oDataOd := ATail( GetList )
   @  7, 42 SAY '                        do' GET dDataDo
   oDataDo := ATail( GetList )

   READ

   IF LastKey() <> K_ESC

      aDane := IFT2_Dane( iif( zRYCZALT <> 'T', 'OPER', 'REJZ' ), dDataOd, dDataDo )

      IF Len( aDane ) > 0
         IFT2_Lista( aDane, dDataOd, dDataDo, cRoczna == 'T' )
      ELSE
         Komun( 'Brak danych w zadanym okresie' )
      ENDIF

   ENDIF

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE IFT2_Lista( aDane, dDataOd, dDataDo, lRocznie )

   LOCAL aLista := {}
   LOCAL nWybor := 1

   AEval( aDane, { | aPoz |
      AAdd( aLista, SubStr( aPoz[ 'nazwa' ], 1, 57 ) + "|" + SubStr( aPoz[ 'nip' ], 1, 16 ) + "|" + Str( Len( aPoz[ 'poz' ] ), 3, 0 ) )
   } )

   ColStd()
   @  3, 0 CLEAR TO 22, 79
   @  3, 0 TO 21, 79
   SET COLOR TO W+
   @  4, 1 SAY PadC( "IFT-2" + iif( lRocznie, "R", " " ) + " za okres od " + DToC( dDataOd ) + " do " + DToC( dDataDo ) + " - LISTA PODATNIKàW", 78 )
   ColStd()
   @  5, 1 TO 5, 78
   @ 22, 0 SAY PadC( "Enter - wybierz            ESC - koniec", 80 )

   DO WHILE nWybor > 0
      nWybor := AChoice( 6, 1, 20, 78, aLista, , , nWybor )
      IF nWybor > 0
         IFT2_Edycja( aDane[ nWybor ], dDataOd, dDataDo, lRocznie )
      ENDIF
   ENDDO

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE IFT2_Edycja( aDane, dDataOd, dDataDo, lRocznie )

   LOCAL cEkran := SaveScreen(), cEkran2
   LOCAL nWybor := 1, nKorekta, cDeklaracja, aFirma
   LOCAL cPodPic := '@ZE  99.99'
   LOCAL bRodzajIdW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( "1 - podatkowej        2 - innej", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bRodzajIdV := { | |
      LOCAL cKolor
      IF aDane[ 'rodzajid' ] $ '12'
         @ 24, 0
         cKolor := SetColor()
         SET COLOR TO W+
         DO CASE
         CASE aDane[ 'rodzajid' ] == '1'
            @ 9, 43 SAY "- podatkowej"
         CASE aDane[ 'rodzajid' ] == '2'
            @ 9, 43 SAY "- innej     "
         OTHERWISE
            @ 9, 43 SAY "            "
         ENDCASE
         SetColor( cKolor )
         RETURN .T.
      ENDIF
      RETURN .F.
   }
   LOCAL bUserFun := { | nMode, nIndex |
      LOCAL nRetVal := AC_CONT
      LOCAL nKey := LastKey()
      IF nMode == AC_IDLE .AND. nKey <> K_MOUSEMOVE
         ColStd()
         DO CASE
         CASE nIndex == 1
            @  6, 20 CLEAR TO 20, 78
            @  6, 20 SAY "Nazwa peˆna"
            @  7, 20 SAY "Nazwa skr¢cona"
            @  8, 20 SAY "Data rozpocz©cia dziaˆalno˜ci"
            @  9, 20 SAY "Rodzaj identyfikacji"
            @ 10, 20 SAY "Numer identyfikacyjny podatnika"
            @ 11, 20 SAY "Kod kraju wydania"
            @ 12, 20 SAY "Miejscowo˜†"
            @ 13, 20 SAY "Kod pocztowy"
            @ 14, 20 SAY "Ulica"
            @ 15, 20 SAY "Nr domu              Nr lokalu"
            @ 16, 20 SAY "Kraj          Podmiot powi¥zany (Tak/Nie)"
            SET COLOR TO W+
            @  6, 32 SAY SubStr( aDane[ 'nazwa' ], 1, 47 )
            @  7, 35 SAY SubStr( aDane[ 'nazwaskr' ], 1, 44 )
            @  8, 50 SAY DToC( aDane[ 'datarozp' ] )
            @  9, 41 SAY aDane[ 'rodzajid' ]
            @ 10, 52 SAY SubStr( aDane[ 'nridpod' ], 1, 27 )
            @ 11, 38 SAY aDane[ 'krajwyd' ]
            @ 12, 32 SAY SubStr( aDane[ 'miasto' ], 1, 47 )
            @ 13, 33 SAY aDane[ 'kodpoczt' ]
            @ 14, 26 SAY SubStr( aDane[ 'ulica' ], 1, 46 )
            @ 15, 28 SAY aDane[ 'nrbud' ]
            @ 15, 51 SAY aDane[ 'nrlok' ]
            @ 16, 25 SAY aDane[ 'kraj' ]
            @ 16, 62 SAY iif( aDane[ 'powiazany' ] == 'T', 'Tak', 'Nie' )
            DO CASE
            CASE aDane[ 'rodzajid' ] == '1'
               @ 9, 43 SAY "- podatkowej"
            CASE aDane[ 'rodzajid' ] == '2'
               @ 9, 43 SAY "- innej     "
            OTHERWISE
               @ 9, 43 SAY "            "
            ENDCASE
         CASE nIndex == 2
            @  6, 20 CLEAR TO 20, 78
            @  6, 20 SAY "Rodzaj przych.  Kwota zwoln. Kwota podl.  Staw.   Podatek"
            @  7, 20 SAY "D.1 Wyw¢z ˆadun."
            @  8, 20 SAY "D.2 Przych.w RP."
            @  9, 20 SAY "D.3 Dywidendy..."
            @ 10, 20 SAY "D.4 Odsetki....."
            @ 11, 20 SAY "D.5 Opˆ.licency."
            @ 12, 20 SAY "D.6 Dz.widowisk."
            @ 13, 20 SAY "D.7 Doradztwo..."
            @ 14, 20 SAY "D.8 Art.21 odse."
            @ 15, 20 SAY "D.9 Art.21 lice."
            @ 16, 20 SAY "D.10 Art.22 dyw."
            @ 17, 20 SAY "D.11 Art.21 inn."
            @ 18, 20 SAY "D.12 Zyski kapi."
            SET COLOR TO W+
            @  7, 37 SAY Transform( aDane[ 'D1D' ], RVPIC ) + "  " + Transform( aDane[ 'D1E' ], RVPIC ) + "    " + Transform( aDane[ 'D1F' ], cPodPic ) + "   " + Transform( aDane[ 'D1G' ], RVPIC )
            @  8, 37 SAY Transform( aDane[ 'D2D' ], RVPIC ) + "  " + Transform( aDane[ 'D2E' ], RVPIC ) + "    " + Transform( aDane[ 'D2F' ], cPodPic ) + "   " + Transform( aDane[ 'D2G' ], RVPIC )
            @  9, 37 SAY Transform( aDane[ 'D3D' ], RVPIC ) + "  " + Transform( aDane[ 'D3E' ], RVPIC ) + "    " + Transform( aDane[ 'D3F' ], cPodPic ) + "   " + Transform( aDane[ 'D3G' ], RVPIC )
            @ 10, 37 SAY Transform( aDane[ 'D4D' ], RVPIC ) + "  " + Transform( aDane[ 'D4E' ], RVPIC ) + "    " + Transform( aDane[ 'D4F' ], cPodPic ) + "   " + Transform( aDane[ 'D4G' ], RVPIC )
            @ 11, 37 SAY Transform( aDane[ 'D5D' ], RVPIC ) + "  " + Transform( aDane[ 'D5E' ], RVPIC ) + "    " + Transform( aDane[ 'D5F' ], cPodPic ) + "   " + Transform( aDane[ 'D5G' ], RVPIC )
            @ 12, 37 SAY Transform( aDane[ 'D6D' ], RVPIC ) + "  " + Transform( aDane[ 'D6E' ], RVPIC ) + "    " + Transform( aDane[ 'D6F' ], cPodPic ) + "   " + Transform( aDane[ 'D6G' ], RVPIC )
            @ 13, 37 SAY Transform( aDane[ 'D7D' ], RVPIC ) + "  " + Transform( aDane[ 'D7E' ], RVPIC ) + "    " + Transform( aDane[ 'D7F' ], cPodPic ) + "   " + Transform( aDane[ 'D7G' ], RVPIC )
            @ 14, 37 SAY Transform( aDane[ 'D8D' ], RVPIC ) + "  " + Transform( aDane[ 'D8E' ], RVPIC ) + "    " + Transform( aDane[ 'D8F' ], cPodPic ) + "   " + Transform( aDane[ 'D8G' ], RVPIC )
            @ 15, 37 SAY Transform( aDane[ 'D9D' ], RVPIC ) + "  " + Transform( aDane[ 'D9E' ], RVPIC ) + "    " + Transform( aDane[ 'D9F' ], cPodPic ) + "   " + Transform( aDane[ 'D9G' ], RVPIC )
            @ 16, 37 SAY Transform( aDane[ 'D10D' ], RVPIC ) + "  " + Transform( aDane[ 'D10E' ], RVPIC ) + "    " + Transform( aDane[ 'D10F' ], cPodPic ) + "   " + Transform( aDane[ 'D10G' ], RVPIC )
            @ 17, 37 SAY Transform( aDane[ 'D11D' ], RVPIC ) + "  " + Transform( aDane[ 'D11E' ], RVPIC ) + "    " + Transform( aDane[ 'D11F' ], cPodPic ) + "   " + Transform( aDane[ 'D11G' ], RVPIC )
            @ 18, 37 SAY Transform( aDane[ 'D12D' ], RVPIC ) + "  " + Transform( aDane[ 'D12E' ], RVPIC ) + "    " + Transform( aDane[ 'D11F' ], cPodPic ) + "   " + Transform( aDane[ 'D12G' ], RVPIC )
         CASE nIndex == 3
            @  6, 20 CLEAR TO 20, 78
            @  6, 20 SAY "Miesi¥c      1            2            3            4"
            @  7, 20 SAY "Doch¢d"
            @  8, 20 SAY "Podatek"
            @  9, 20 SAY "Miesi¥c      5            6            7            8"
            @ 10, 20 SAY "Doch¢d"
            @ 11, 20 SAY "Podatek"
            @ 12, 20 SAY "Miesi¥c      9           10           11           12"
            @ 13, 20 SAY "Doch¢d"
            @ 14, 20 SAY "Podatek"
            @ 15, 20 SAY "Miesi¥c     13           14           15           16"
            @ 16, 20 SAY "Doch¢d"
            @ 17, 20 SAY "Podatek"
            @ 18, 20 SAY "Miesi¥c     17           18           19           20"
            @ 19, 20 SAY "Doch¢d"
            @ 20, 20 SAY "Podatek"
            SET COLOR TO W+
            @  7, 28 SAY Transform( aDane[ 'K01' ], RVPIC ) + '    ' + Transform( aDane[ 'K02' ], RVPIC ) + '    ' + Transform( aDane[ 'K03' ], RVPIC ) + '    ' + Transform( aDane[ 'K04' ], RVPIC )
            @  8, 28 SAY Transform( aDane[ 'P01' ], RVPIC ) + '    ' + Transform( aDane[ 'P02' ], RVPIC ) + '    ' + Transform( aDane[ 'P03' ], RVPIC ) + '    ' + Transform( aDane[ 'P04' ], RVPIC )
            @ 10, 28 SAY Transform( aDane[ 'K05' ], RVPIC ) + '    ' + Transform( aDane[ 'K06' ], RVPIC ) + '    ' + Transform( aDane[ 'K07' ], RVPIC ) + '    ' + Transform( aDane[ 'K08' ], RVPIC )
            @ 11, 28 SAY Transform( aDane[ 'P05' ], RVPIC ) + '    ' + Transform( aDane[ 'P06' ], RVPIC ) + '    ' + Transform( aDane[ 'P07' ], RVPIC ) + '    ' + Transform( aDane[ 'P08' ], RVPIC )
            @ 13, 28 SAY Transform( aDane[ 'K09' ], RVPIC ) + '    ' + Transform( aDane[ 'K10' ], RVPIC ) + '    ' + Transform( aDane[ 'K11' ], RVPIC ) + '    ' + Transform( aDane[ 'K12' ], RVPIC )
            @ 14, 28 SAY Transform( aDane[ 'P09' ], RVPIC ) + '    ' + Transform( aDane[ 'P10' ], RVPIC ) + '    ' + Transform( aDane[ 'P11' ], RVPIC ) + '    ' + Transform( aDane[ 'P12' ], RVPIC )
            @ 16, 28 SAY Transform( aDane[ 'K13' ], RVPIC ) + '    ' + Transform( aDane[ 'K14' ], RVPIC ) + '    ' + Transform( aDane[ 'K15' ], RVPIC ) + '    ' + Transform( aDane[ 'K16' ], RVPIC )
            @ 17, 28 SAY Transform( aDane[ 'P13' ], RVPIC ) + '    ' + Transform( aDane[ 'P14' ], RVPIC ) + '    ' + Transform( aDane[ 'P15' ], RVPIC ) + '    ' + Transform( aDane[ 'P16' ], RVPIC )
            @ 19, 28 SAY Transform( aDane[ 'K17' ], RVPIC ) + '    ' + Transform( aDane[ 'K18' ], RVPIC ) + '    ' + Transform( aDane[ 'K19' ], RVPIC ) + '    ' + Transform( aDane[ 'K20' ], RVPIC )
            @ 20, 28 SAY Transform( aDane[ 'P17' ], RVPIC ) + '    ' + Transform( aDane[ 'P18' ], RVPIC ) + '    ' + Transform( aDane[ 'P19' ], RVPIC ) + '    ' + Transform( aDane[ 'P20' ], RVPIC )
         CASE nIndex == 4
            @  6, 20 CLEAR TO 20, 78
            IF lRocznie
               @  6, 20 SAY "Liczba miesi©cy skˆadaj¥ca si© na rok podatkowy"
               @  7, 20 SAY "Data przekazania informacji podatnikowi"
               SET COLOR TO W+
               @  6, 68 SAY Str( aDane[ 'miesiace' ], 3, 0 )
               @  7, 60 SAY DToC( aDane[ 'data_prz' ] )
            ELSE
               @  6, 20 SAY "Data zˆo¾enia wniosku przez podatnika"
               @  7, 20 SAY "Data przekazania informacji podatnikowi"
               SET COLOR TO W+
               @  6, 58 SAY DToC( aDane[ 'data_zl' ] )
               @  7, 60 SAY DToC( aDane[ 'data_prz' ] )
            ENDIF
         ENDCASE
         SET COLOR TO W+
      ELSEIF nMode == AC_EXCEPT
         DO CASE
         CASE nKey == K_RETURN
            nRetVal := AC_SELECT
         CASE nKey == K_ESC
            nRetVal := AC_ABORT
         OTHERWISE
            nRetVal := AC_GOTO
         ENDCASE
      ENDIF
      RETURN nRetVal
   }

   @ 3, 0 CLEAR TO 22, 79
   @ 3, 0 TO 21, 79
   SET COLOR TO W+
   @ 4, 1 SAY SubStr( aDane[ 'nazwa' ], 1, 60 ) + "|" + SubStr( aDane[ 'nip' ], 1, 16 )
   ColStd()
   @ 5, 1 TO 5, 78
   @ 6, 19 TO 20, 19
   @ 22, 0 SAY PadC( "Enter - wybierz         ESC - koniec" )

   Eval( bUserFun, AC_IDLE, 1 )
   DO WHILE nWybor > 0
      SET COLOR TO W+
      nWybor := AChoice( 6, 1, 20, 18, { "C. DANE PODATNIKA", "D. RODZ. PRZYCH.", ;
         "E. ZOBOWIAZANIA", "F. INFORMACJE UZUP", "DRUKIJ", "UTWàRZ eDEKLARACJ¨" }, , bUserFun, nWybor )
      IF nWybor > 0
         DO CASE
         CASE nWybor == 1
            @  6, 32 GET aDane[ 'nazwa' ] PICTURE "@S47 " + Replicate( "!", 200 )
            @  7, 35 GET aDane[ 'nazwaskr' ] PICTURE "@S44 " + Replicate( "!", 200 )
            @  8, 50 GET aDane[ 'datarozp' ]
            @  9, 41 GET aDane[ 'rodzajid' ] PICTURE "!" WHEN Eval( bRodzajIdW ) VALID Eval( bRodzajIdV )
            @ 10, 52 GET aDane[ 'nridpod' ] PICTURE "@S27 " + Replicate( "!", 50 )
            @ 11, 38 GET aDane[ 'krajwyd' ] PICTURE "!!"
            @ 12, 32 GET aDane[ 'miasto' ] PICTURE "@S47 " + Replicate( "!", 56 )
            @ 13, 33 GET aDane[ 'kodpoczt' ] PICTURE "!!!!!!!!"
            @ 14, 26 GET aDane[ 'ulica' ] PICTURE "@S46 " + Replicate( "!", 65 )
            @ 15, 28 GET aDane[ 'nrbud' ] PICTURE "!!!!!!!!!"
            @ 15, 51 GET aDane[ 'nrlok' ] PICTURE "!!!!!!!!!!"
            @ 16, 25 GET aDane[ 'kraj' ] PICTURE "!!"
            @ 16, 62 GET aDane[ 'powiazany' ] PICTURE "!" VALID ValidTakNie( aDane[ 'powiazany' ], 16, 63 )
            READ
            KontrahentZapiszIFT2( aDane )
         CASE nWybor == 2
            @  7, 37 GET aDane[ 'D1D' ] PICTURE RVPIC
            @  7, 49 GET aDane[ 'D1E' ] PICTURE RVPIC
            @  7, 61 GET aDane[ 'D1F' ] PICTURE cPodPic
            @  7, 70 GET aDane[ 'D1G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D1G' ] := _round( aDane[ 'D1E' ] * ( aDane[ 'D1F' ] / 100 ), 0 ), .T. } )
            @  8, 37 GET aDane[ 'D2D' ] PICTURE RVPIC
            @  8, 49 GET aDane[ 'D2E' ] PICTURE RVPIC
            @  8, 61 GET aDane[ 'D2F' ] PICTURE cPodPic
            @  8, 70 GET aDane[ 'D2G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D2G' ] := _round( aDane[ 'D2E' ] * ( aDane[ 'D2F' ] / 100 ), 0 ), .T. } )
            @  9, 37 GET aDane[ 'D3D' ] PICTURE RVPIC
            @  9, 49 GET aDane[ 'D3E' ] PICTURE RVPIC
            @  9, 61 GET aDane[ 'D3F' ] PICTURE cPodPic
            @  9, 70 GET aDane[ 'D3G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D3G' ] := _round( aDane[ 'D3E' ] * ( aDane[ 'D3F' ] / 100 ), 0 ), .T. } )
            @ 10, 37 GET aDane[ 'D4D' ] PICTURE RVPIC
            @ 10, 49 GET aDane[ 'D4E' ] PICTURE RVPIC
            @ 10, 61 GET aDane[ 'D4F' ] PICTURE cPodPic
            @ 10, 70 GET aDane[ 'D4G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D4G' ] := _round( aDane[ 'D4E' ] * ( aDane[ 'D4F' ] / 100 ), 0 ), .T. } )
            @ 11, 37 GET aDane[ 'D5D' ] PICTURE RVPIC
            @ 11, 49 GET aDane[ 'D5E' ] PICTURE RVPIC
            @ 11, 61 GET aDane[ 'D5F' ] PICTURE cPodPic
            @ 11, 70 GET aDane[ 'D5G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D5G' ] := _round( aDane[ 'D5E' ] * ( aDane[ 'D5F' ] / 100 ), 0 ), .T. } )
            @ 12, 37 GET aDane[ 'D6D' ] PICTURE RVPIC
            @ 12, 49 GET aDane[ 'D6E' ] PICTURE RVPIC
            @ 12, 61 GET aDane[ 'D6F' ] PICTURE cPodPic
            @ 12, 70 GET aDane[ 'D6G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D6G' ] := _round( aDane[ 'D6E' ] * ( aDane[ 'D6F' ] / 100 ), 0 ), .T. } )
            @ 13, 37 GET aDane[ 'D7D' ] PICTURE RVPIC
            @ 13, 49 GET aDane[ 'D7E' ] PICTURE RVPIC
            @ 13, 61 GET aDane[ 'D7F' ] PICTURE cPodPic
            @ 13, 70 GET aDane[ 'D7G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D7G' ] := _round( aDane[ 'D7E' ] * ( aDane[ 'D7F' ] / 100 ), 0 ), .T. } )
            @ 14, 37 GET aDane[ 'D8D' ] PICTURE RVPIC
            @ 14, 49 GET aDane[ 'D8E' ] PICTURE RVPIC
            @ 14, 61 GET aDane[ 'D8F' ] PICTURE cPodPic
            @ 14, 70 GET aDane[ 'D8G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D8G' ] := _round( aDane[ 'D8E' ] * ( aDane[ 'D8F' ] / 100 ), 0 ), .T. } )
            @ 15, 37 GET aDane[ 'D9D' ] PICTURE RVPIC
            @ 15, 49 GET aDane[ 'D9E' ] PICTURE RVPIC
            @ 15, 61 GET aDane[ 'D9F' ] PICTURE cPodPic
            @ 15, 70 GET aDane[ 'D9G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D9G' ] := _round( aDane[ 'D9E' ] * ( aDane[ 'D9F' ] / 100 ), 0 ), .T. } )
            @ 16, 37 GET aDane[ 'D10D' ] PICTURE RVPIC
            @ 16, 49 GET aDane[ 'D10E' ] PICTURE RVPIC
            @ 16, 61 GET aDane[ 'D10F' ] PICTURE cPodPic
            @ 16, 70 GET aDane[ 'D10G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D10G' ] := _round( aDane[ 'D10E' ] * ( aDane[ 'D10F' ] / 100 ), 0 ), .T. } )
            @ 17, 37 GET aDane[ 'D11D' ] PICTURE RVPIC
            @ 17, 49 GET aDane[ 'D11E' ] PICTURE RVPIC
            @ 17, 61 GET aDane[ 'D11F' ] PICTURE cPodPic
            @ 17, 70 GET aDane[ 'D11G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D11G' ] := _round( aDane[ 'D11E' ] * ( aDane[ 'D11F' ] / 100 ), 0 ), .T. } )
            @ 18, 37 GET aDane[ 'D12D' ] PICTURE RVPIC
            @ 18, 49 GET aDane[ 'D12E' ] PICTURE RVPIC
            @ 18, 61 GET aDane[ 'D12F' ] PICTURE cPodPic
            @ 18, 70 GET aDane[ 'D12G' ] PICTURE RVPIC WHEN Eval( { | | aDane[ 'D12G' ] := _round( aDane[ 'D12E' ] * ( aDane[ 'D12F' ] / 100 ), 0 ), .T. } )
            READ
         CASE nWybor == 3 .AND. lRocznie
            @  7, 28 GET aDane[ 'K01' ] PICTURE RVPIC
            @  7, 41 GET aDane[ 'K02' ] PICTURE RVPIC
            @  7, 54 GET aDane[ 'K03' ] PICTURE RVPIC
            @  7, 67 GET aDane[ 'K04' ] PICTURE RVPIC
            @  8, 28 GET aDane[ 'P01' ] PICTURE RVPIC
            @  8, 41 GET aDane[ 'P02' ] PICTURE RVPIC
            @  8, 54 GET aDane[ 'P03' ] PICTURE RVPIC
            @  8, 67 GET aDane[ 'P04' ] PICTURE RVPIC
            @ 10, 28 GET aDane[ 'K05' ] PICTURE RVPIC
            @ 10, 41 GET aDane[ 'K06' ] PICTURE RVPIC
            @ 10, 54 GET aDane[ 'K07' ] PICTURE RVPIC
            @ 10, 67 GET aDane[ 'K08' ] PICTURE RVPIC
            @ 11, 28 GET aDane[ 'P05' ] PICTURE RVPIC
            @ 11, 41 GET aDane[ 'P06' ] PICTURE RVPIC
            @ 11, 54 GET aDane[ 'P07' ] PICTURE RVPIC
            @ 11, 67 GET aDane[ 'P08' ] PICTURE RVPIC
            @ 13, 28 GET aDane[ 'K09' ] PICTURE RVPIC
            @ 13, 41 GET aDane[ 'K10' ] PICTURE RVPIC
            @ 13, 54 GET aDane[ 'K11' ] PICTURE RVPIC
            @ 13, 67 GET aDane[ 'K12' ] PICTURE RVPIC
            @ 14, 28 GET aDane[ 'P09' ] PICTURE RVPIC
            @ 14, 41 GET aDane[ 'P10' ] PICTURE RVPIC
            @ 14, 54 GET aDane[ 'P11' ] PICTURE RVPIC
            @ 14, 67 GET aDane[ 'P12' ] PICTURE RVPIC
            @ 16, 28 GET aDane[ 'K13' ] PICTURE RVPIC
            @ 16, 41 GET aDane[ 'K14' ] PICTURE RVPIC
            @ 16, 54 GET aDane[ 'K15' ] PICTURE RVPIC
            @ 16, 67 GET aDane[ 'K16' ] PICTURE RVPIC
            @ 17, 28 GET aDane[ 'P13' ] PICTURE RVPIC
            @ 17, 41 GET aDane[ 'P14' ] PICTURE RVPIC
            @ 17, 54 GET aDane[ 'P15' ] PICTURE RVPIC
            @ 17, 67 GET aDane[ 'P16' ] PICTURE RVPIC
            @ 19, 28 GET aDane[ 'K17' ] PICTURE RVPIC
            @ 19, 41 GET aDane[ 'K18' ] PICTURE RVPIC
            @ 19, 54 GET aDane[ 'K19' ] PICTURE RVPIC
            @ 19, 67 GET aDane[ 'K20' ] PICTURE RVPIC
            @ 20, 28 GET aDane[ 'P17' ] PICTURE RVPIC
            @ 20, 41 GET aDane[ 'P18' ] PICTURE RVPIC
            @ 20, 54 GET aDane[ 'P19' ] PICTURE RVPIC
            @ 20, 67 GET aDane[ 'P20' ] PICTURE RVPIC
            READ
            aDane[ 'KR' ] := aDane[ 'K01' ] + aDane[ 'K02' ] + aDane[ 'K03' ] + ;
               aDane[ 'K04' ] + aDane[ 'K05' ] + aDane[ 'K06' ] + aDane[ 'K07' ] + ;
               aDane[ 'K08' ] + aDane[ 'K09' ] + aDane[ 'K10' ] + aDane[ 'K11' ] + ;
               aDane[ 'K12' ] + aDane[ 'K13' ] + aDane[ 'K14' ] + aDane[ 'K15' ] + ;
               aDane[ 'K16' ] + aDane[ 'K17' ] + aDane[ 'K18' ] + aDane[ 'K19' ] + ;
               aDane[ 'K20' ] + aDane[ 'K21' ] + aDane[ 'K22' ] + aDane[ 'K23' ]
            aDane[ 'PR' ] := aDane[ 'P01' ] + aDane[ 'P02' ] + aDane[ 'P03' ] + ;
               aDane[ 'P04' ] + aDane[ 'P05' ] + aDane[ 'P06' ] + aDane[ 'P07' ] + ;
               aDane[ 'P08' ] + aDane[ 'P09' ] + aDane[ 'P10' ] + aDane[ 'P11' ] + ;
               aDane[ 'P12' ] + aDane[ 'P13' ] + aDane[ 'P14' ] + aDane[ 'P15' ] + ;
               aDane[ 'P16' ] + aDane[ 'P17' ] + aDane[ 'P18' ] + aDane[ 'P19' ] + ;
               aDane[ 'P20' ] + aDane[ 'P21' ] + aDane[ 'P22' ] + aDane[ 'P23' ]
         CASE nWybor == 4
            IF lRocznie
               @  6, 68 GET aDane[ 'miesiace' ] PICTURE '999' RANGE 1, 23
               @  7, 60 GET aDane[ 'data_prz' ]
            ELSE
               @  6, 58 GET aDane[ 'data_zl' ]
               @  7, 60 GET aDane[ 'data_prz' ]
            ENDIF
            READ
         CASE nWybor == 5 .OR. nWybor == 6
            IF IFT2_Sprawdz( aDane, lRocznie )
               IF ( nKorekta := edekCzyKorekta( 16, 2 ) ) > 0 .AND. JPK_Dane_Firmy( Val( ident_fir ), @aFirma )
                  aDane[ 'data_od' ] := dDataOd
                  aDane[ 'data_do' ] := dDataDo
                  aDane[ 'korekta' ] := iif( nKorekta == 2, '2', '1' )
                  aDane[ 'Firma' ] := aFirma
                  aDane[ 'rocznie' ] := lRocznie
                  IF ! Empty( param_eiku )
                     aDane[ 'Firma' ][ 'KodUrzedu' ] := param_eiku
                  ENDIF
                  cEkran2 := SaveScreen()
                  IF nWybor == 5
                     DeklarDrukuj( iif( lRocznie, 'IFT2R-12', 'IFT2-12' ), aDane )
                  ELSE
                     cDeklaracja := edek_ift2_12( aDane, lRocznie )
                     edekZapiszXML( cDeklaracja, normalizujNazwe( 'IFT2' + iif( lRocznie, 'R', '' ) + '_' + param_rok + '_' + DToS( dDataOd ) + DToS( dDataDo ) ), wys_edeklaracja, 'IFT2' + iif( lRocznie, 'R', '' ) + '-12', aDane[ 'korekta' ] == '2', Month( dDataOd ) )
                  ENDIF
                  RestScreen( , , , , cEkran2 )
               ENDIF
            ENDIF
         ENDCASE
         Eval( bUserFun, AC_IDLE, nWybor )
      ENDIF
   ENDDO

   ColStd()
   RestScreen( , , , , cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION IFT2_Sprawdz( aDane, lRocznie )

   LOCAL nSumD, nSumE, nSumF, nSumG

   nSumD := aDane[ 'D1D' ] + aDane[ 'D2D' ] + aDane[ 'D3D' ] + aDane[ 'D4D' ] + ;
      aDane[ 'D5D' ] + aDane[ 'D6D' ] + aDane[ 'D7D' ] + aDane[ 'D8D' ] + ;
      aDane[ 'D9D' ] + aDane[ 'D10D' ] + aDane[ 'D11D' ] + aDane[ 'D12D' ]

   nSumE := aDane[ 'D1E' ] + aDane[ 'D2E' ] + aDane[ 'D3E' ] + aDane[ 'D4E' ] + ;
      aDane[ 'D5E' ] + aDane[ 'D6E' ] + aDane[ 'D7E' ] + aDane[ 'D8E' ] + ;
      aDane[ 'D9E' ] + aDane[ 'D10E' ] + aDane[ 'D11E' ] + aDane[ 'D12E' ]

//   nSumF := aDane[ 'D1F' ] + aDane[ 'D2F' ] + aDane[ 'D3F' ] + aDane[ 'D4F' ] + ;
//      aDane[ 'D5F' ] + aDane[ 'D6F' ] + aDane[ 'D7F' ] + aDane[ 'D8F' ] + ;
//      aDane[ 'D9F' ]

   nSumG := aDane[ 'D1G' ] + aDane[ 'D2G' ] + aDane[ 'D3G' ] + aDane[ 'D4G' ] + ;
      aDane[ 'D5G' ] + aDane[ 'D6G' ] + aDane[ 'D7G' ] + aDane[ 'D8G' ] + ;
      aDane[ 'D9G' ] + aDane[ 'D10G' ] + aDane[ 'D11G' ] + aDane[ 'D12G' ]

   IF nSumD == 0 .AND. nSumE == 0 .AND. nSumG == 0
      Komun( "Sekcja D. deklaracji nie zawiera ¾adych kwot." )
      RETURN .F.
   ENDIF

   IF lRocznie .AND. ( nSumE <> aDane[ 'KR' ] .OR. nSumG <> aDane[ 'PR' ] )
      Komun( "Kwoty z skcji D nie s¥ zgodne z kwotami z sekcji E" )
      RETURN .F.
   ENDIF

   IF lRocznie .AND. ( aDane[ 'miesiace' ] < 1 .OR. aDane[ 'miesiace' ] > 23 )
      Komun( "Prosz© wprowadzi† poprawn¥ liczb© miesi©cy roku pod." )
      RETURN .F.
   ENDIF

   IF Empty( aDane[ 'data_prz' ] )
      Komun( "Prosz© wprowadzi† dat© przekazania inf. podatnikowi." )
      RETURN .F.
   ENDIF

   IF ! lRocznie .AND. Empty( aDane[ 'data_zl' ] )
      Komun( "Prosz© wprowadzi† dat© zˆo¾enia wniosku." )
      RETURN .F.
   ENDIF

   IF Empty( aDane[ 'nazwa' ] )
      Komun( "Prosz© wprowadzi† nazw© podatnika." )
      RETURN .F.
   ENDIF

   IF ! ( aDane[ 'rodzajid' ] $ '12' )
      Komun( "Prosz© wprowadzi† rodzaj ident. podatkowj." )
      RETURN .F.
   ENDIF

   IF Empty( aDane[ 'nridpod' ] )
      Komun( "Prosz© wprowadzi† numer ident. podatkowj." )
      RETURN .F.
   ENDIF

   IF Empty( aDane[ 'krajwyd' ] )
      Komun( "Prosz© wprowadzi† kraj wydania." )
      RETURN .F.
   ENDIF

   IF Empty( aDane[ 'kraj' ] )
      Komun( "Prosz© wprowadzi† kraj siedziby." )
      RETURN .F.
   ENDIF

   IF Empty( aDane[ 'miasto' ] )
      Komun( "Prosz© wprowadzi† miejscowo˜† siedziby." )
      RETURN .F.
   ENDIF

   RETURN .T.

/*----------------------------------------------------------------------*/

