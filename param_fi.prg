/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2022  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PARAM_FI ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul innych parametrow firmy                                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Param_FI()

   LOCAL bParKsWSW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( "T - Tak, zbiorczy wpis RS-7/8   N - ka¾dy wpis osobno  D - domy˜nie wg. par.", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bParKsWSV := { | |
      LOCAL lRes := zzPAR_KSWS $ 'TND'
      IF lRes
         @ 10, 65 SAY iif( zzPAR_KSWS == 'T', 'ak      ', iif( zzPAR_KSWS == 'N', 'ie      ', 'omy˜lnie' ) )
         @ 24, 0
      ENDIF
      RETURN lRes
   }
   LOCAL cEkrInfo, cRodzajZwol, cOpisZwol
   LOCAL bRW := { | |
      cEkrInfo := SaveScreen( 17, 0, 23, 79 )
      ColInf()
      @ 17, 0 SAY Pad( '1 - Przepis ustawy albo aktu wydanego na podstawie ustawy, na podstawie kt¢rego', 80 )
      @ 18, 0 SAY Pad( '    podatnik stosuje zwolnienie od podatku.', 80 )
      @ 19, 0 SAY Pad( '2 - Przepis dyrektywy 2006/112/WE, kt¢ry zwalnia od podatku tak¥ dostaw©', 80 )
      @ 20, 0 SAY Pad( '    towar¢w lub takie ˜wiadczenie usˆug.', 80 )
      @ 21, 0 SAY Pad( '3 - Inna podstawa prawna wskazuj¥c¥ na to, ¾e dostawa towar¢w lub ˜wiadczenie', 80 )
      @ 22, 0 SAY Pad( '    usˆug korzysta ze zwolnienia od podatku.', 80 )
      ColStd()
      RETURN .T.
   }
   LOCAL bRV := { | |
      LOCAL lRes := ( cRodzajZwol >= '1' .AND. cRodzajZwol <= '3' ) .OR. cRodzajZwol == ' '
      IF lRes
         RestScreen( 17, 0, 23, 79, cEkrInfo )
      ENDIF
      RETURN lRes
   }

   *############################# PARAMETRY POCZATKOWE #########################
   SELECT 1
   if Dostep( 'FIRMA' )
      SET INDEX TO firma
      GO Val( ident_fir )
   ELSE
      Close_()
      RETURN
   ENDIF

   @  3, 42 CLEAR TO 22, 79
   *################################# GRAFIKA ##################################
   @  3, 42 SAY 'ÍÍ Parametry importu z JPK ÍÍÍÍÍÍÍÍÍÍÍ'
   @  4, 42 SAY ' Zezw¢l na import dokument¢w z dat¥   '
   @  5, 42 SAY ' inn¥ ni¾ aktualny miesi¥c            '
   @  6, 42 SAY 'ÍÍ Inne parametry ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
   @  7, 42 SAY ' Sygnaˆ o VAT (Tak/Nie)               '
   @  8, 42 SAY 'ÍÍ Parametry ksi©gowania ÍÍÍÍÍÍÍÍÍÍÍÍÍ'
   @  9, 42 SAY ' Zbiorczy wpis sprzeda¾y w ksi©dze    '
   @ 10, 42 SAY ' (Tak/Nie/Domy˜lnie)                  '
   IF firma->vat <> 'T'
      @ 11, 42 SAY 'ÍÍ Podstawa prawna zwolnienia ÍÍÍÍÍÍÍÍ'
      @ 12, 42 SAY ' Podstawa zwolnienia (1-3)            '
      @ 13, 42 SAY ' Przepis ust.                         '
   ENDIF

   *################################# OPERACJE #################################
   Param_FI_Say()
   kl := 0
   DO WHILE kl#27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      kl := Inkey( 0 )
      DO CASE
      *############################### MODYFIKACJA ################################
      CASE kl == 109 .OR. kl == 77
         @ 1, 47 SAY "          "
         ColStb()
         center( 23, 'þ                       þ' )
         ColSta()
         center( 23, 'M O D Y F I K A C J A' )
         ColStd()
         BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            zzVATOKRESDR := iif( firma->vatokresdr $ 'TN', firma->vatokresdr, 'N' )
            zsygnalvat := iif( firma->sygnalvat $ 'TN', firma->sygnalvat, 'T' )
            zzPAR_KSWS := iif( firma->par_ksws $ 'TN', firma->par_ksws, 'D' )
            cRodzajZwol := firma->rodzzwol
            cOpisZwol := firma->opiszwol
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @  5, 70 GET zzVATOKRESDR PICTURE '!' VALID zzVATOKRESDR $ 'TN'
            @  7, 66 GET zsygnalvat PICTURE '!' VALID zsygnalvat $ 'TN'
            @ 10, 64 GET zzPAR_KSWS PICTURE '!' WHEN Eval( bParKsWSV ) VALID Eval( bParKsWSV )
            IF firma->vat <> 'T'
               @ 12, 70 GET cRodzajZwol PICTURE '9' WHEN Eval( bRW ) VALID Eval( bRV )
               @ 13, 56 GET cOpisZwol PICTURE '@S24 ' + Replicate( 'X', 255 )
            ENDIF
            ****************************
            CLEAR TYPE
            Read_()
            IF LastKey() == 27
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            BlokadaR()
            firma->vatokresdr := zzVATOKRESDR
            zVATOKRESDR := zzVATOKRESDR
            firma->sygnalvat := zsygnalvat
            fsygnalvat := zsygnalvat
            firma->par_ksws := zzPAR_KSWS
            firma->rodzzwol := cRodzajZwol
            firma->opiszwol := cOpisZwol
            pzparam_ksws := iif( firma->par_ksws $ 'TN', firma->par_ksws, param_ksws )
            Commit_()
            UNLOCK
         END
         Param_FI_Say()
         @ 23, 0
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1]='                                             '
         p[ 2]='     [M].....................modyfikacja     '
         p[ 3]='     [Esc]...................wyj&_s.cie         '
         p[ 4]='                                             '
         *---------------------------------------
         set color to i
            i=20
            j=24
            do while i>0
               if type('p[i]')#[U]
                  center(j,p[i])
                  j=j-1
               endif
            i=i-1
            enddo
         ColStd()
         pause(0)
         if lastkey()#27.and.lastkey()#28
            keyboard chr(lastkey())
         endif
         restore screen from scr_
         _disp=.f.
      ******************** ENDCASE
      endcase
   enddo
   close_()

*################################## FUNKCJE #################################
PROCEDURE Param_FI_Say()

   CLEAR TYPE
   SET COLOR TO w+
   @  5, 70 say iif( firma->vatokresdr== 'T', 'Tak', 'Nie' )
   @  7, 66 say iif( firma->sygnalvat== 'N', 'Nie', 'Tak' )
   @ 10, 64 SAY iif( firma->par_ksws == 'T', 'Tak      ', iif( firma->par_ksws == 'N', 'Nie      ', 'Domy˜lnie' ) )
   @ 12, 70 SAY firma->rodzzwol
   @ 13, 56 SAY SubStr( firma->opiszwol, 1, 24 )
   ColStd()

   RETURN NIL

*############################################################################
