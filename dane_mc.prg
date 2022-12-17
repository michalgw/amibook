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

#include "Inkey.ch"

FUNCTION Dane_MC( typpit )

   LOCAL nDANE_MCRecNo
   LOCAL bPrzelW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 say PadC( "R - r©cznie, bez przeliczanie    A - automatycznie, przelicz warto˜ci", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bPrzelV := { | cPole |
      LOCAL lRes, cKolor
      IF ( lRes := &( 'przel_' + cPole ) $ 'AR' )
         IF &( 'przel_' + cPole ) == 'A'
            &( 'zwar_' + cPole ) := _round( zzpodstawa * ( &( 'zstaw_' + cPole ) / 100 ), 2 )
            &( 'zwar5_' + cPole ) := _round( zzpodstawa * ( &( 'zstaw_' + cPole ) / 100 ), 2 )
         ENDIF
         DaneMC_Sumuj()
         @ 24, 0
      ENDIF
      RETURN lRes
   }

   SELECT dane_mc
   opc := 0
   STORE 0 TO zwar_wue,zwar_wur,zwar_wuc,zwar_wuw,zwar_wuz,zwar_wfp,zwar_wfg,;
      zwar_wsum,zstaw_wsum
   STORE 0 TO zwar5_wue,zwar5_wur,zwar5_wuc,zwar5_wuw,zwar5_wuz,zwar5_wfp,zwar5_wfg,;
      zwar5_wsum
   STORE 0 TO zmc_wue,zmc_wur,zmc_wuc,zmc_wuw,zmc_wuz
   STORE 0 TO pwar5_wue,pwar5_wur,pwar5_wuc,pwar5_wuw,pwar5_wuz
   STORE 0 TO pmc_wue,pmc_wur,pmc_wuc,pmc_wuw,pmc_wuz,zDOCHODZDR
   STORE 'R' TO przel_wue, przel_wur, przel_wuc, przel_wuw, przel_wuz, przel_wfp, przel_wfg

   nDANE_MCRecNo := dane_mc->( RecNo() )

   ColStd()
   @ 11, 42 CLEAR TO 22, 79
   DO WHILE .T.
      ColStd()
      @ 12, 43 PROMPT '   INFORMACJA O PODATKU DOCHODOWYM   '
      @ 13, 43 SAY    'ÄÄÄDANE MIESI&__E.CZNE (dane do PIT-5)ÄÄÄ'
      @ 14, 43 PROMPT '   Skladki ZUS: ' + Str( skladki + skladkiw, 7, 2 ) + ' FP/G: ' + Str( war_wfp+war_wfg, 6, 2 ) + ' '
      IF SubStr( typpit, 1, 1 ) == '5'
         IF zPITOKRES == 'K'
            @ 15, 43 PROMPT '   Wp&_l.acono za poprzedni kwarta&_l.     '
         ELSE
            @ 15, 43 PROMPT '   Wp&_l.acono za poprzedni miesi&_a.c     '
         ENDIF
         SET COLOR TO w+
         @ 16, 41 SAY    '   ' + Str( zaliczka, 9, 2 )
         ColStd()
*         if zPITOKRES='M'
*            @ 16,53 say    [ (wynika z PIT-5         )]
*            if zaliczka#zaliczkap
*               ColErr()
*               @ 16,70 say    str(zaliczkap,9,2)
*               ColStd()
*            else
*               set colo to w+
*               @ 16,70 say    str(zaliczkap,9,2)
*               ColStd()
*            endif
*         endif
      ELSE
         IF zPITOKRES == 'K'
            @ 15, 43 PROMPT '   Wp&_l.acono za poprzedni kwarta&_l.     '
         ELSE
            @ 15, 43 PROMPT '   Wp&_l.acono za poprzedni miesi&_a.c     '
         ENDIF
         SET COLO TO w+
         @ 16, 41 SAY    '   ' + Str( zaliczka, 9, 2 )
         ColStd()
      ENDIF
      IF typpit == '5L'
         @ 17, 43 PROMPT ' 1.Dodatkowe zr&_o.d&_l.a przychod&_o.w       '
         @ 18, 43 PROMPT ' 2.Dodatkowe informacje              '
         opc := menu( opc )
         IF LastKey() == K_ESC
            @ 11, 42 CLEAR TO 22, 79
            RETURN .F.
         ENDIF
      ELSE
         @ 17, 43 PROMPT ' 1.Dodatkowe zr&_o.d&_l.a przychod&_o.w       '
         @ 18, 43 PROMPT ' 2.Odliczenia od dochodu (D,E1,E2,E3)'
         @ 19, 43 PROMPT ' 3.Odliczenia od dochodu (F,G,I)     '
         @ 20, 43 PROMPT ' 4.Odliczenia od podatku i inne dane '
         opc := menu( opc )
         IF LastKey() == K_ESC
            @ 11, 42 CLEAR TO 22, 79
            RETURN .F.
         ENDIF
      ENDIF
      SAVE SCREEN TO _scr22
      DO CASE
      CASE opc == 1
         IF mc == '12'
            deklinwg( @_DEKLINW_ )
         ENDIF
         RESTORE SCREEN FROM _scr22
         @ 11, 42 CLEAR TO 22, 79
         RETURN .T.
      CASE opc == 2
         zzskladki := skladki
         zzpodstawa := podstawa
         zzzpodstawa := podstawa
         zzpodstzdr := podstzdr
         zzzpodstzdr := podstzdr
*        if podstawa#0
         zstaw_wue := staw_wue
         zstaw_wur := staw_wur
         zstaw_wuc := staw_wuc
         zstaw_wuw := staw_wuw
         zstaw_wfp := staw_wfp
         zstaw_wfg := staw_wfg
         zwar_wue := war_wue
         zwar_wur := war_wur
         zwar_wuc := war_wuc
         zwar_wuw := war_wuw
         zwar_wfp := war_wfp
         zwar_wfg := war_wfg
         pwar5_wue := war5_wue
         pwar5_wur := war5_wur
         pwar5_wuc := war5_wuc
         pwar5_wuw := war5_wuw
         pmc_wue := mc_wue
         pmc_wur := mc_wur
         pmc_wuc := mc_wuc
         pmc_wuw := mc_wuw
         zwar5_wue := war5_wue
         zwar5_wur := war5_wur
         zwar5_wuc := war5_wuc
         zwar5_wuw := war5_wuw
         zmc_wue := mc_wue
         zmc_wur := mc_wur
         zmc_wuc := mc_wuc
         zmc_wuw := mc_wuw
/*         else
              if mc=' 1'
                 zstaw_wue=parap_pue+parap_fue
                 zstaw_wur=parap_pur+parap_fur
                 zstaw_wuc=parap_puc+parap_fuc
                 zstaw_wuw=parap_puw+parap_fww
                 zstaw_wfp=parap_pfp+parap_ffp
                 zstaw_wfg=parap_pfg+parap_ffg
                 zwar_wue=war_wue
                 zwar_wur=war_wur
                 zwar_wuc=war_wuc
                 zwar_wuw=war_wuw
                 zwar_wfp=war_wfp
                 zwar_wfg=war_wfg
                 pwar5_wue=war5_wue
                 pwar5_wur=war5_wur
                 pwar5_wuc=war5_wuc
                 pwar5_wuw=war5_wuw
                 pmc_wue=mc_wue
                 pmc_wur=mc_wur
                 pmc_wuc=mc_wuc
                 pmc_wuw=mc_wuw
                 zwar5_wue=war5_wue
                 zwar5_wur=war5_wur
                 zwar5_wuc=war5_wuc
                 zwar5_wuw=war5_wuw
                 zmc_wue=2
                 zmc_wur=2
                 zmc_wuc=2
                 zmc_wuw=2
              else
                 skip -1
                 zzpodstawa=podstawa
                 zzzpodstawa=podstawa
                 zstaw_wue=staw_wue
                 zstaw_wur=staw_wur
                 zstaw_wuc=staw_wuc
                 zstaw_wuw=staw_wuw
                 zstaw_wfp=staw_wfp
                 zstaw_wfg=staw_wfg
                 zwar_wue=war_wue
                 zwar_wur=war_wur
                 zwar_wuc=war_wuc
                 zwar_wuw=war_wuw
                 zwar_wfp=war_wfp
                 zwar_wfg=war_wfg
                 pwar5_wue=0
                 pwar5_wur=0
                 pwar5_wuc=0
                 pwar5_wuw=0
                 pmc_wue=0
                 pmc_wur=0
                 pmc_wuc=0
                 pmc_wuw=0
                 zwar5_wue=war5_wue
                 zwar5_wur=war5_wur
                 zwar5_wuc=war5_wuc
                 zwar5_wuw=war5_wuw
                 zmc_wue=iif(mc_wue+1<13,mc_wue+1,0)
                 zmc_wur=iif(mc_wur+1<13,mc_wur+1,0)
                 zmc_wuc=iif(mc_wuc+1<13,mc_wuc+1,0)
                 zmc_wuw=iif(mc_wuw+1<13,mc_wuw+1,0)
                 przeskla()
                 skip 1
              endif
           endif
           if podstzdr#0    */
         zstaw_wuz := staw_wuz
         //zstaw5_wuz := staw5_wuz
         zstaw5_wuz := 0
         zwar_wuz := war_wuz
         pwar5_wuz := war5_wuz
         //pwar5_wuz := 0
         pmc_wuz := mc_wuz
         zwar5_wuz := war5_wuz
         IF zRYCZALT <> 'T' .AND. spolka->sposob <> 'L'
            zwar5_wuz := 0
         ENDIF
         zmc_wuz := mc_wuz
         zdochodzdr := dochodzdr
/*         else
              if mc=' 1'
                 zstaw_wuz=parap_puz+parap_fuz
                 zstaw5_wuz=parap_pzk
                 zwar_wuz=war_wuz
                 pwar5_wuz=war5_wuz
                 pmc_wuz=mc_wuz
                 zwar5_wuz=war5_wuz
                 zmc_wuz=2
              else
                 skip -1
                 zzpodstzdr=podstzdr
                 zzzpodstzdr=podstzdr
                 zstaw_wuz=staw_wuz
                 zstaw5_wuz=staw5_wuz
                 zwar_wuz=war_wuz
                 pwar5_wuz=0
                 pmc_wuz=0
                 zwar5_wuz=war5_wuz
                 zmc_wuz=iif(mc_wuz+1<13,mc_wuz+1,0)
                 przeskla()
                 skip 1
              endif
           endif     */
         IF mc == ' 1'
            corobic := 2
         ELSE
            corobic := 0
         ENDIF
         STORE 'R' TO przel_wue, przel_wur, przel_wuc, przel_wuw, przel_wuz, przel_wfp, przel_wfg
         SAVE SCREEN TO scr_sklad
         SET CURSOR ON
         @  4, 38 CLEAR TO 22, 79
         @  4, 38 TO 22, 79
         @  5, 41 SAY 'Wybierz: 2-podstawic z parametrow     '
         @  6, 41 SAY '         1-przepisz z poprzed.miesiaca'
         @  7, 41 SAY '         0-zostawic jak jest          '
         @  8, 41 SAY 'Co wybierasz ?                        '
         @  8, 56 GET CoRobic PICTURE '9' VALID Zrobcos()
*            valid ZrobCos(CoRobic)
         @  9, 41 SAY 'Podstawa do ZUS      (51,53)'
         @  9, 71 GET zzPODSTAWA PICTURE '99999.99' VALID przeskla()
         @ 10, 41 SAY 'Podstawa tylko do zdrow.(52)'
         @ 10, 69 GET zzPODSTZDR PICTURE '9999999.99' VALID przeskla()
         @ 11, 39 SAY 'SK&__L.ADKI    %stawki   do ZUS   do PIT5 za'
         @ 12, 39 SAY 'Emerytalna ' GET zSTAW_WUE PICTURE '99.99'
         @ 12, 57 GET przel_wue PICTURE '!' WHEN Eval( bPrzelW ) VALID Eval( bPrzelV, 'WUE' )
         @ 12, 59 GET zWAR_WUE PICTURE '99999.99' VALID DaneMC_Sumuj()
         @ 12, 68 GET zWAR5_WUE PICTURE '99999.99' VALID DaneMC_Sumuj()
         @ 12, 77 GET zMC_WUE PICTURE '99' RANGE 0, 12
         @ 13, 39 SAY 'Rentowa    ' GET zSTAW_WUR PICTURE '99.99'
         @ 13, 57 GET przel_wur PICTURE '!' WHEN Eval( bPrzelW ) VALID Eval( bPrzelV, 'WUR' )
         @ 13, 59 GET zWAR_WUR PICTURE '99999.99' VALID DaneMC_Sumuj()
         @ 13, 68 GET zWAR5_WUR PICTURE '99999.99' VALID DaneMC_Sumuj()
         @ 13, 77 GET zMC_WUR PICTURE '99' RANGE 0, 12
         @ 14, 39 SAY 'Chorobowa  ' GET zSTAW_WUC PICTURE '99.99'
         @ 14, 57 GET przel_wuc PICTURE '!' WHEN Eval( bPrzelW ) VALID Eval( bPrzelV, 'WUC' )
         @ 14, 59 GET zWAR_WUC PICTURE '99999.99' VALID DaneMC_Sumuj()
         @ 14, 68 GET zWAR5_WUC PICTURE '99999.99' VALID DaneMC_Sumuj()
         @ 14, 77 GET zMC_WUC PICTURE '99' RANGE 0, 12
         @ 15, 39 SAY 'Wypadkowa  ' GET zSTAW_WUW PICTURE '99.99'
         @ 15, 57 GET przel_wuw PICTURE '!' WHEN Eval( bPrzelW ) VALID Eval( bPrzelV, 'WUW' )
         @ 15, 59 GET zWAR_WUW PICTURE '99999.99' VALID DaneMC_Sumuj()
         @ 15, 68 GET zWAR5_WUW PICTURE '99999.99' VALID DaneMC_Sumuj()
         @ 15, 77 GET zMC_WUW PICTURE '99' RANGE 0, 12
         @ 16, 39 SAY 'RAZEM      '
         @ 17, 39 SAY iif( zRYCZALT == 'T', 'Przych¢d narastaj¥co      ','Doch¢d do podst. zdrow.   ' ) GET zDOCHODZDR PICTURE '9999999.99'
         @ 18, 39 SAY 'Zdro.do ZUS' GET zSTAW_WUZ PICTURE '99.99'
         @ 18, 59 GET zWAR_WUZ PICTURE '99999.99'
         //@ 18, 41 SAY '     do PIT' GET zSTAW5_WUZ PICTURE '99.99'
         IF zRYCZALT == 'T' .OR. spolka->sposob == 'L'
            @ 18, 68 GET zWAR5_WUZ PICTURE '99999.99'
            @ 18, 77 GET zMC_WUZ PICTURE '99' RANGE 0, 12
         ENDIF
         @ 19, 39 SAY 'FUNDUSZE   %stawki   do ZUS   do PIT5'
         @ 20, 39 SAY 'Pracy      ' GET zSTAW_WFP PICTURE '99.99'
         @ 20, 57 GET przel_wfp PICTURE '!' WHEN Eval( bPrzelW ) VALID Eval( bPrzelV, 'WFP' )
         @ 20, 59 GET zWAR_WFP PICTURE '99999.99'
         @ 21, 39 SAY 'GSP        ' GET zSTAW_WFG PICTURE '99.99'
         @ 21, 57 GET przel_wfg PICTURE '!' WHEN Eval( bPrzelW ) VALID Eval( bPrzelV, 'WFG' )
         @ 21, 59 GET zWAR_WFG PICTURE '99999.99'
         READ
         SET CURSOR OFF
         RESTORE SCREEN FROM scr_sklad
         dane_mc->( dbGoto( nDANE_MCRecNo ) )
         IF LastKey() # K_ESC
            BlokadaR()
            REPLACE podstawa WITH zzpodstawa, podstzdr WITH zzpodstzdr, ;
               staw_wue WITH zstaw_wue, staw_wur WITH zstaw_wur, ;
               staw_wuc WITH zstaw_wuc, staw_wuw WITH zstaw_wuw, ;
               staw_wuz WITH zstaw_wuz, staw5_wuz WITH zstaw5_wuz, staw_wfp WITH zstaw_wfp, ;
               staw_wfg WITH zstaw_wfg, ;
               war_wue WITH zwar_wue, war_wur WITH zwar_wur, war_wuc WITH zwar_wuc, ;
               war_wuw WITH zwar_wuw, war_wuz WITH zwar_wuz, war_wfp WITH zwar_wfp, ;
               war_wfg WITH zwar_wfg, ;
               war5_wue WITH zwar5_wue, war5_wur WITH zwar5_wur, war5_wuc WITH zwar5_wuc, ;
               war5_wuw WITH zwar5_wuw, war5_wuz WITH zwar5_wuz, ;
               mc_wue WITH zmc_wue, mc_wur WITH zmc_wur, mc_wuc WITH zmc_wuc, ;
               mc_wuw WITH zmc_wuw, mc_wuz WITH zmc_wuz, dochodzdr WITH zdochodzdr
            COMMIT
            UNLOCK

            rrre := RecNo()
            SEEK '+' + zident + Str( pmc_wue, 2 )
            IF Found()
               BlokadaR()
               REPLACE skladki WITH skladki-pwar5_wue
               COMMIT
               UNLOCK
            ENDIF
            SEEK '+' + zident + Str( zmc_wue, 2 )
            IF Found()
               BlokadaR()
               REPLACE skladki WITH skladki + zwar5_wue
               COMMIT
               UNLOCK
            ENDIF

            SEEK '+' + zident + Str( pmc_wur, 2 )
            IF Found()
               BlokadaR()
               REPLACE skladki WITH skladki - pwar5_wur
               COMMIT
               UNLOCK
            ENDIF
            SEEK '+' + zident + Str( zmc_wur, 2 )
            IF Found()
               BlokadaR()
               REPLACE skladki WITH skladki + zwar5_wur
               COMMIT
               UNLOCK
            ENDIF

            SEEK '+' + zident + Str( pmc_wuc, 2 )
            IF Found()
               BlokadaR()
               REPLACE skladki WITH skladki - pwar5_wuc
               COMMIT
               UNLOCK
            ENDIF
            SEEK '+' + zident + Str( zmc_wuc, 2 )
            IF Found()
               BlokadaR()
               REPLACE skladki WITH skladki + zwar5_wuc
               COMMIT
               UNLOCK
            ENDIF

            SEEK '+' + zident + Str( pmc_wuw, 2 )
            IF Found()
               BlokadaR()
               REPLACE skladki WITH skladki - pwar5_wuw
               COMMIT
               UNLOCK
            ENDIF
            SEEK '+' + zident + Str( zmc_wuw, 2 )
            IF Found()
               BlokadaR()
               REPLACE skladki WITH skladki + zwar5_wuw
               COMMIT
               UNLOCK
            ENDIF

            SEEK '+' + zident + Str( pmc_wuz, 2 )
            IF Found()
               BlokadaR()
               REPLACE zdrowie WITH zdrowie - pwar5_wuz
               COMMIT
               UNLOCK
            ENDIF
            SEEK '+' + zident + Str( zmc_wuz, 2 )
            IF Found()
               BlokadaR()
               REPLACE zdrowie WITH zdrowie + zwar5_wuz
               COMMIT
               UNLOCK
            ENDIF
            GO rrre
         ENDIF
      CASE opc == 3
         zzzaliczka := zaliczka
         SET CURSOR ON
         @ 16, 44 GET zzzaliczka PICT '999999.99'
         READ
         SET CURSOR OFF
         IF LastKey() # K_ESC
            blokadar()
            REPLACE zaliczka WITH zzzaliczka
            COMMIT
            UNLOCK
         ENDIF
      CASE opc == 4
         IF zRYCZALT == 'T'
            kom( 5, '+w', ' UWAGA !!! Funkcja nie jest aktywna dla p&_l.atnik&_o.w podatku zrycza&_l.towanego ' )
         ELSE
            zrodla()
         ENDIF
      CASE opc == 5
         IF typpit == '5L'
            dodat5l()
         ELSE
            wydatki()
         ENDIF
      CASE opc == 6
           wydatki2()
      CASE opc == 7
           odlicz()
      ENDCASE
      RESTORE SCREEN FROM _scr22
   ENDDO
   @ 11, 42 CLEAR TO 22, 79
   RETURN .F.

***************************************************************
FUNCTION przeskla()
***************************************************************
   IF zzpodstawa # zzzpodstawa
      zwar_wue := _round( zzpodstawa * ( zstaw_wue / 100 ), 2 )
      zwar_wur := _round( zzpodstawa * ( zstaw_wur / 100 ), 2 )
      zwar_wuc := _round( zzpodstawa * ( zstaw_wuc / 100 ), 2 )
      zwar_wuw := _round( zzpodstawa * ( zstaw_wuw / 100 ), 2 )
      zwar_wfp := _round( zzpodstawa * ( zstaw_wfp / 100 ), 2 )
      zwar_wfg := _round( zzpodstawa * ( zstaw_wfg / 100 ), 2 )
      zwar5_wue := _round( zzpodstawa * ( zstaw_wue / 100 ), 2 )
      zwar5_wur := _round( zzpodstawa * ( zstaw_wur / 100 ), 2 )
      zwar5_wuc := _round( zzpodstawa * ( zstaw_wuc / 100 ), 2 )
      zwar5_wuw := _round( zzpodstawa * ( zstaw_wuw / 100 ), 2 )
   ENDIF
   //IF zzpodstzdr # zzzpodstzdr
      zwar_wuz := Max( _round( zzpodstzdr * ( zstaw_wuz / 100 ), 2 ), _round( parap_p52 * ( parap_fuz / 100 ), 2 ) )
      //zwar5_wuz := _round( zzpodstzdr * ( zstaw5_wuz / 100 ), 2 )
      IF zRYCZALT <> 'T' .AND. spolka->sposob <> 'L'
         zwar5_wuz := 0
      ELSEIF zRYCZALT == 'T'
         zwar5_wuz := _round( zwar_wuz * ( parap_rpz / 100 ), 2 )
      ELSE
         IF Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) > 0 .AND. a_sumzdro5[ 2, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ] < parap_pli
            zwar5_wuz := zwar_wuz
            IF a_sumzdro5[ 2, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ] + zwar5_wuz > parap_pli
               zwar5_wuz := _round( parap_pli - a_sumzdro5[ 2, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ], 2 )
            ENDIF
         ELSE
            zwar5_wuz := Min( zwar_wuz, parap_pli )
         ENDIF
      ENDIF
   //ENDIF
   zwar_wsum := zwar_wue + zwar_wur + zwar_wuc + zwar_wuw
   zwar5_wsum := zwar5_wue + zwar5_wur + zwar5_wuc + zwar5_wuw
   zstaw_wsum := zstaw_wue + zstaw_wur + zstaw_wuc + zstaw_wuw
   zzskladki := zwar_wsum
   SET COLOR TO w+
   @ 16, 39 SAY 'RAZEM       ' + Str( zSTAW_WSUM, 5, 2 )
   @ 16, 59 SAY zWAR_WSUM PICTURE '99999.99'
   @ 16, 68 SAY zWAR5_WSUM PICTURE '99999.99'
   ColStd()
   RETURN .T.

***********************************************************************
FUNCTION zrobcos()
***********************************************************************
*para co
*           zzskladki=skladki
*           zzpodstawa=podstawa
*           zzzpodstawa=podstzdr
*           zzpodstzdr=podstzdr
*           zzzpodstzdr=podstzdr

   LOCAL nPrzychod, nDANE_MCRecNo

   nDANE_MCRecNo := dane_mc->( RecNo() )

   if ( corobic == 1 .AND. mc == ' 1' ) .OR. corobic == 2
      zzpodstawa := parap_p51
*          zzzpodstawa=parap_p51
      //zzpodstzdr := parap_p52
      IF zRYCZALT == 'T'
         IF mc == ' 1'
            zzpodstzdr := parap_p52
         ELSE
            DO CASE
            CASE spolka->ryczstzdr $ ' 0'
               nPrzychod := P_RyczLicz( 'N', .T. )
               zdochodzdr := nPrzychod
               DO CASE
               CASE nPrzychod < parap_rk2
                  zzpodstzdr := _round( parap_frp * ( parap_rs1 / 100 ), 2 )
               CASE nPrzychod >= parap_rk2 .AND. nPrzychod < parap_rk3
                  zzpodstzdr := _round( parap_frp * ( parap_rs2 / 100 ), 2 )
               CASE nPrzychod >= parap_rk3
                  zzpodstzdr := _round( parap_frp * ( parap_rs3 / 100 ), 2 )
               ENDCASE
            CASE spolka->ryczstzdr == '1'
               zzpodstzdr := _round( parap_frp * ( parap_rs1 / 100 ), 2 )
            CASE spolka->ryczstzdr == '2'
               zzpodstzdr := _round( parap_frp * ( parap_rs2 / 100 ), 2 )
            CASE spolka->ryczstzdr == '3'
               zzpodstzdr := _round( parap_frp * ( parap_rs3 / 100 ), 2 )
            ENDCASE
         ENDIF
      ELSE
         IF mc == ' 1'
            zzpodstzdr := parap_p52
            zzpodstzdr := 0
         ELSE
            IF firma->zuspodnar == 'N'
               zzpodstzdr := Max( a_ppodstn[ 2, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ] - a_dochodzdr[ 2, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ], 0 )
            ELSE
               zzpodstzdr := a_ppodstn[ 1, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ]
            ENDIF
            zdochodzdr := Max( zzpodstzdr, 0 )
            IF zzpodstzdr < parap_p52
               zzpodstzdr := parap_p52
            ENDIF
         ENDIF
      ENDIF
      dane_mc->( dbGoto( nDANE_MCRecNo ) )
      zwar_wuz := Max( _round( zzpodstzdr * ( zstaw_wuz / 100 ), 2 ), _round( parap_p52 * ( parap_fuz / 100 ), 2 ) )
*          zzzpodstzdr=parap_p52
      zstaw_wue := parap_pue + parap_fue
      zstaw_wur := parap_pur + parap_fur
      zstaw_wuc := parap_puc + parap_fuc
      zstaw_wuw := parap_puw + parap_fww
      zstaw_wfp := parap_pfp + parap_ffp
      zstaw_wfg := parap_pfg + parap_ffg

      /*
      zwar_wue := war_wue
      zwar_wur := war_wur
      zwar_wuc := war_wuc
      zwar_wuw := war_wuw
      zwar_wfp := war_wfp
      zwar_wfg := war_wfg
      */
* usuwanie bledu naliczania
*
*                 pwar5_wue=war5_wue
*                 pwar5_wur=war5_wur
*                 pwar5_wuc=war5_wuc
*                 pwar5_wuw=war5_wuw
*                 pmc_wue=mc_wue
*                 pmc_wur=mc_wur
*                 pmc_wuc=mc_wuc
*                 pmc_wuw=mc_wuw
*
* usuwanie bledu naliczania
      /*
      zwar5_wue := war5_wue
      zwar5_wur := war5_wur
      zwar5_wuc := war5_wuc
      zwar5_wuw := war5_wuw
      */

      zmc_wue := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )
      zmc_wur := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )
      zmc_wuc := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )
      zmc_wuw := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )

      zstaw_wuz := /*parap_puz +*/ parap_fuz
      IF spolka->sposob == 'L' //.AND. Val( mc ) > 1
         zstaw_wuz := parap_fzl
      ENDIF
      //zstaw5_wuz := parap_pzk
      zstaw5_wuz := 0
      zwar_wuz := war_wuz
* usuwanie bledu naliczania
*
*                 pwar5_wuz=war5_wuz
*                 pmc_wuz=mc_wuz
*
* usuwanie bledu naliczania
      zwar5_wuz := war5_wuz
      IF zRYCZALT <> 'T' .AND. spolka->sposob <> 'L'
         zwar5_wuz := 0
      ENDIF
      zmc_wuz := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )

      zwar_wue := _round( zzpodstawa * ( zstaw_wue / 100 ), 2 )
      zwar_wur := _round( zzpodstawa * ( zstaw_wur / 100 ), 2 )
      zwar_wuc := _round( zzpodstawa * ( zstaw_wuc / 100 ), 2 )
      zwar_wuw := _round( zzpodstawa * ( zstaw_wuw / 100 ), 2 )
      zwar_wfp := _round( zzpodstawa * ( zstaw_wfp / 100 ), 2 )
      zwar_wfg := _round( zzpodstawa * ( zstaw_wfg / 100 ), 2 )
      zwar5_wue := _round( zzpodstawa * ( zstaw_wue / 100 ), 2 )
      zwar5_wur := _round( zzpodstawa * ( zstaw_wur / 100 ), 2 )
      zwar5_wuc := _round( zzpodstawa * ( zstaw_wuc / 100 ), 2 )
      zwar5_wuw := _round( zzpodstawa * ( zstaw_wuw / 100 ), 2 )

   ENDIF
   IF (corobic == 1 .AND. mc # ' 1' )
      SKIP -1
      zzpodstawa := podstawa
*                zzzpodstawa=podstawa
      zzpodstzdr := podstzdr
*                zzzpodstzdr=podstzdr
      zstaw_wue := staw_wue
      zstaw_wur := staw_wur
      zstaw_wuc := staw_wuc
      zstaw_wuw := staw_wuw
      zstaw_wfp := staw_wfp
      zstaw_wfg := staw_wfg
      zwar_wue := war_wue
      zwar_wur := war_wur
      zwar_wuc := war_wuc
      zwar_wuw := war_wuw
      zwar_wfp := war_wfp
      zwar_wfg := war_wfg
* usuwanie bledu naliczania
*
*                 pwar5_wue=0
*                 pwar5_wur=0
*                 pwar5_wuc=0
*                 pwar5_wuw=0
*                 pmc_wue=0
*                 pmc_wur=0
*                 pmc_wuc=0
*                 pmc_wuw=0
*
* usuwanie bledu naliczania
      zwar5_wue := war5_wue
      zwar5_wur := war5_wur
      zwar5_wuc := war5_wuc
      zwar5_wuw := war5_wuw
      zmc_wue := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )
      zmc_wur := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )
      zmc_wuc := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )
      zmc_wuw := iif( Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ) < 13, Val( mc ) + iif( firma->zussklmie == 'B', 0, 1 ), 0 )
*                przeskla()
*                skip 1

*                skip -1
      zzpodstzdr := podstzdr
      zzzpodstzdr := podstzdr
      zstaw_wuz := staw_wuz
      //zstaw5_wuz := staw5_wuz
      zstaw5_wuz := 0
      zwar_wuz := war_wuz
* usuwanie bledu naliczania
*
*                 pwar5_wuz=0
*                 pmc_wuz=0
*
* usuwanie bledu naliczania
      zwar5_wuz := war5_wuz
      IF zRYCZALT <> 'T' .AND. spolka->sposob <> 'L'
         zwar5_wuz := 0
      ENDIF
      zmc_wuz := iif( mc_wuz + iif( firma->zussklmie == 'B', 0, 1 ) < 13, mc_wuz + iif( firma->zussklmie == 'B', 0, 1 ), 0 )
*                przeskla()
      SKIP 1
      IF zRYCZALT == 'T'
         IF mc == ' 1'
            zzpodstzdr := parap_p52
         ELSE
            DO CASE
            CASE spolka->ryczstzdr $ ' 0'
               nPrzychod := P_RyczLicz( 'N', .T. )
               zdochodzdr := nPrzychod
               DO CASE
               CASE nPrzychod < parap_rk2
                  zzpodstzdr := _round( parap_frp * ( parap_rs1 / 100 ), 2 )
               CASE nPrzychod >= parap_rk2 .AND. nPrzychod < parap_rk3
                  zzpodstzdr := _round( parap_frp * ( parap_rs2 / 100 ), 2 )
               CASE nPrzychod >= parap_rk3
                  zzpodstzdr := _round( parap_frp * ( parap_rs3 / 100 ), 2 )
               ENDCASE
            CASE spolka->ryczstzdr == '1'
               zzpodstzdr := _round( parap_frp * ( parap_rs1 / 100 ), 2 )
            CASE spolka->ryczstzdr == '2'
               zzpodstzdr := _round( parap_frp * ( parap_rs2 / 100 ), 2 )
            CASE spolka->ryczstzdr == '3'
               zzpodstzdr := _round( parap_frp * ( parap_rs3 / 100 ), 2 )
            ENDCASE
         ENDIF
      ELSE
         IF mc == ' 1'
            zzpodstzdr := parap_p52
            zzpodstzdr := 0
         ELSE
            IF firma->zuspodnar == 'N'
               zzpodstzdr := Max( a_ppodstn[ 2, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ] - a_dochodzdr[ 2, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ], 0 )
            ELSE
               zzpodstzdr := a_ppodstn[ 1, Val( mc ) - iif( firma->zuspodmie == 'B', 0, 1 ) ]
            ENDIF
            zdochodzdr := Max( zzpodstzdr, 0 )
            IF zzpodstzdr < parap_p52
               zzpodstzdr := parap_p52
            ENDIF
         ENDIF
      ENDIF
      dane_mc->( dbGoto( nDANE_MCRecNo ) )
      zwar_wuz := Max( _round( zzpodstzdr * ( zstaw_wuz / 100 ), 2 ), _round( parap_p52 * ( parap_fuz / 100 ), 2 ) )
   ENDIF
   przeskla()
   SET COLOR TO /w+
   @  9, 71 SAY zzPODSTAWA PICTURE '99999.99'
   @ 10, 69 SAY zzPODSTZDR PICTURE '9999999.99'
   @ 12, 51 SAY zSTAW_WUE PICTURE '99.99'
   @ 12, 59 SAY zWAR_WUE PICTURE '99999.99'
   @ 12, 68 SAY zWAR5_WUE PICTURE '99999.99'
   @ 12, 77 SAY zMC_WUE PICTURE '99'
   @ 13, 51 SAY zSTAW_WUR PICTURE '99.99'
   @ 13, 59 SAY zWAR_WUR PICTURE '99999.99'
   @ 13, 68 SAY zWAR5_WUR PICTURE '99999.99'
   @ 13, 77 SAY zMC_WUR PICTURE '99'
   @ 14, 51 SAY zSTAW_WUC PICTURE '99.99'
   @ 14, 59 SAY zWAR_WUC PICTURE '99999.99'
   @ 14, 68 SAY zWAR5_WUC PICTURE '99999.99'
   @ 14, 77 SAY zMC_WUC PICTURE '99'
   @ 15, 51 SAY zSTAW_WUW PICTURE '99.99'
   @ 15, 59 SAY zWAR_WUW PICTURE '99999.99'
   @ 15, 68 SAY zWAR5_WUW PICTURE '99999.99'
   @ 15, 77 SAY zMC_WUW PICTURE '99'
   @ 17, 66 SAY zDOCHODZDR PICTURE '9999999.99'
   @ 18, 51 SAY zSTAW_WUZ PICTURE '99.99'
   @ 18, 59 SAY zWAR_WUZ PICTURE '99999.99'
   //@ 18, 53 SAY zSTAW5_WUZ PICTURE '99.99'
   IF zRYCZALT == 'T' .OR. spolka->sposob == 'L'
      @ 18, 68 SAY zWAR5_WUZ PICTURE '99999.99'
      @ 18, 77 SAY zMC_WUZ PICTURE '99'
   ENDIF
   @ 20, 51 SAY zSTAW_WFP PICTURE '99.99'
   @ 20, 59 SAY zWAR_WFP PICTURE '99999.99'
   @ 21, 51 SAY zSTAW_WFG PICTURE '99.99'
   @ 21, 59 SAY zWAR_WFG PICTURE '99999.99'
   ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION DaneMC_Sumuj()

   zwar_wsum := zwar_wue + zwar_wur + zwar_wuc + zwar_wuw
   zwar5_wsum := zwar5_wue + zwar5_wur + zwar5_wuc + zwar5_wuw
   zstaw_wsum := zstaw_wue + zstaw_wur + zstaw_wuc + zstaw_wuw
   zzskladki := zwar_wsum
   SET COLOR TO w+
   @ 16, 39 SAY 'RAZEM       ' + Str( zSTAW_WSUM, 5, 2 )
   @ 16, 59 SAY zWAR_WSUM PICTURE '99999.99'
   @ 16, 68 SAY zWAR5_WSUM PICTURE '99999.99'
   ColStd()

   RETURN .T.


