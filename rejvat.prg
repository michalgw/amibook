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

#include "inkey.ch"
#include "hbcompat.ch"

FUNCTION RejVAT_Zak_Dane( cFirma, cMiesiac, cRodzaj, ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz, bFiltr, lWgVat, lTylkoUE, lTylkoKsiega )

   LOCAL aRes := {}, aRow
   LOCAL aDane := hb_Hash()
   //LOCAL cKoniec := 'rejz->del#"+" .OR. rejz->firma#cFirma .OR. rejz->mc#cMiesiac'
   LOCAL bKoniec := { || rejz->del#"+" .OR. rejz->firma#cFirma .OR. rejz->mc#cMiesiac }
   LOCAL cOpisRej := ''
   LOCAL zstrusprob
   LOCAL lJest := .F.
   LOCAL nLP := 0
   LOCAL nRekZak, cKluczStat, nFZ, nZZ

   hb_default( @lWgVat, .F. )
   hb_default( @lTylkoUE, .F. )
   hb_default( @lTylkoKsiega, .F. )

   aDane[ 'pozycje' ] := {}
   aDane[ 'rok' ] := param_rok
   aDane[ 'miesiac' ] := Upper( miesiac( Val( cMiesiac ) ) )

   IF lWgVat
      SELECT 8
      DO WHILE ! dostep( 'ROZR' )
      ENDDO
      setind( 'ROZR' )
   ENDIF

   SELECT 7
   IF ewid_rzi <> '**'
      DO WHILE ! dostep( 'KAT_ZAK' )
      ENDDO
      SetInd( 'KAT_ZAK' )
      SEEK '+' + cFirma + ewid_rzi
      IF Found()
         cOpisRej := AllTrim( kat_zak->opis )
      ENDIF
   ELSE
      cOpisRej := 'WSZYSTKIE REJESTRY RAZEM'
   ENDIF
   USE

   aDane[ 'jaki_rej' ] := ewid_rzi
   aDane[ 'opis_rej' ] := cOpisRej
   DO CASE
   CASE 'S' $ cRodzaj
      aDane[ 'rejestr' ] := '�RODKI TRWA�E'
   CASE 'P' $ cRodzaj
      aDane[ 'rejestr' ] := 'POZOSTA�E ZAKUPY'
   CASE 'SP' $ cRodzaj
      aDane[ 'rejestr' ] := 'WSZYSTKIE ZAKUPY'
   ENDCASE

   SELECT 3
   IF dostep( 'FIRMA' )
      GO Val( cFirma )
   ELSE
      SELECT 1
      RETURN aDane
   ENDIF
   // Przyjety  wskazn.odliczenia
   zstrusprob := firma->strusprob

   aDane[ 'strusprob' ] := firma->strusprob
   aDane[ 'firma' ] := AllTrim( firma->nazwa ) + ' ' + firma->miejsc + ' ul.' + firma->ulica + ' '+ firma->nr_domu + iif( Empty( firma->nr_mieszk ),' ','/' ) + firma->nr_mieszk

   SELECT 1
   IF dostep( 'REJZ' )
      SETIND( 'REJZ' )
      SEEK '+' + cFirma + cMiesiac
   ELSE
      SELECT 1
      RETURN aDane
   ENDIF
   IF Eof() .OR. Eval( bKoniec ) // &cKoniec
//      kom( 3, '*w', 'b r a k   d a n y c h' )
      RETURN aDane
   ELSE
      SEEK '+' + cFirma + cMiesiac
      DO WHILE ! Eof() .AND. ! Eval( bKoniec ) // &cKoniec
         DO CASE
         CASE ewid_rzk == 'N'
            IF rejz->korekta == 'N' .AND. iif( ewid_rzi <> '**', rejz->symb_rej == ewid_rzi, .T. )
               lJest := .T.
               EXIT
            ELSE
               SKIP 1
            ENDIF
         CASE ewid_rzk == 'T'
            IF rejz->korekta == 'T' .AND. iif( ewid_rzi <> '**', rejz->symb_rej == ewid_rzi, .T. )
               lJest := .T.
               EXIT
            ELSE
               SKIP 1
            ENDIF
         OTHERWISE
            IF iif( ewid_rzi <> '**', rejz->symb_rej == ewid_rzi, .T. )
               lJest := .T.
               EXIT
            ELSE
               SKIP 1
            ENDIF
         ENDCASE
      ENDDO
      IF ! lJest
//         kom( 3, '*w', 'b r a k   d a n y c h' )
         RETURN aDane
      ENDIF
   ENDIF

   DO WHILE ! Eval( bKoniec ) // &cKoniec

      IF ! lTylkoUE .AND. ( rejz->sek_cv7 == 'WS' .OR. rejz->sek_cv7 == 'PS' ;
         .OR. rejz->sek_cv7 == 'IS' .OR. rejz->sek_cv7 == 'US' )
         rejz->( dbSkip() )
         LOOP
      ENDIF

      aRow := hb_Hash()

      aRow[ 'pojazdy' ] := 0
      aRow[ 'zak_zwol_net' ] := 0
      aRow[ 'zak_zwol_vat' ] := 0
      aRow[ 'zak_op_net' ] := 0
      aRow[ 'zak_op_vat' ] := 0
      aRow[ 'nab_netto_m' ] := 0
      aRow[ 'nab_netto_m' ] := 0
      aRow[ 'zak_mi_net' ] := 0
      aRow[ 'zak_mi_vat' ] := 0
      aRow[ 'zak_mi_odl' ] := 0
      aRow[ 'zak_wt_net' ] := 0
      aRow[ 'zak_wt_vat' ] := 0
      aRow[ 'zak_it_net' ] := 0
      aRow[ 'zak_it_vat' ] := 0
      aRow[ 'zak_iu_net' ] := 0
      aRow[ 'zak_iu_vat' ] := 0
      aRow[ 'zak_pn_net' ] := 0
      aRow[ 'zak_pn_vat' ] := 0
      aRow[ 'ue_wt_net' ] := 0
      aRow[ 'ue_wt_vat' ] := 0
      aRow[ 'ue_it_net' ] := 0
      aRow[ 'ue_it_vat' ] := 0
      aRow[ 'ue_iu_net' ] := 0
      aRow[ 'ue_iu_vat' ] := 0
      aRow[ 'ue_pn_net' ] := 0
      aRow[ 'ue_pn_vat' ] := 0

      aRow[ 'pojazdy' ] := iif( rejz->sp22 $ cRodzaj .AND. rejz->wart22 <> 0.00 .AND. rejz->pojazdy <> 0.00, rejz->pojazdy, 0 )
      aRow[ 'paliwa' ] := iif( rejz->sp22 $ cRodzaj .AND. rejz->wart22 <> 0.00 .AND. rejz->paliwa <> 0.00, rejz->paliwa, 0 )

      aRow[ 'rodzdow' ] := AllTrim( rejz->rodzdow )
      aRow[ 'mpp' ] := rejz->sek_cv7 == 'SP'
      aRow[ 'imp' ] := rejz->sek_cv7 == 'IT' .OR. rejz->sek_cv7 == 'IZ' .OR. rejz->sek_cv7 == 'IS' .OR. rejz->sek_cv7 == 'IU' .OR. rejz->sek_cv7 == 'UZ' .OR. rejz->sek_cv7 == 'US'

      aRow[ 'oznaczenia' ] := aRow[ 'rodzdow' ]
      IF aRow[ 'mpp' ]
         IF aRow[ 'oznaczenia' ] <> ""
            aRow[ 'oznaczenia' ] := aRow[ 'oznaczenia' ] + ";"
         ENDIF
         aRow[ 'oznaczenia' ] := aRow[ 'oznaczenia' ] + "MPP"
      ENDIF
      IF aRow[ 'imp' ]
         IF aRow[ 'oznaczenia' ] <> ""
            aRow[ 'oznaczenia' ] := aRow[ 'oznaczenia' ] + ";"
         ENDIF
         aRow[ 'oznaczenia' ] := aRow[ 'oznaczenia' ] + "IMP"
      ENDIF

      DO CASE
      CASE rejz->rach == 'R'

         // Zakupy netto bez odliczen
         aRow[ 'zak_zwol_net' ] := iif( rejz->spzw $ cRodzaj, rejz->wartzw, 0 ) ;
            + iif( rejz->sp00 $ cRodzaj, rejz->wart00, 0 ) ;
            + iif( rejz->sp02 $ cRodzaj, rejz->wart02, 0 ) ;
            + iif( rejz->SP07 $ cRodzaj, rejz->wart07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj, rejz->wart22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj, rejz->wart12, 0 )

         // Zakupy kwota vat bez odliczen
         aRow[ 'zak_zwol_vat' ] := iif( rejz->sp02 $ cRodzaj, rejz->vat02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj, rejz->vat07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj, rejz->vat22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj, rejz->vat12, 0 )

      CASE rejz->rach == 'F'

         // Zakupy netto bez odliczen
         aRow[ 'zak_zwol_net' ] := iif( rejz->spzw $ cRodzaj, rejz->wartzw, 0 ) ;
            + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
            + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'Z', rejz->wart00, 0 )

         // Zakupy kwota vat bez odliczen
         aRow[ 'zak_zwol_vat' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->vat02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->vat07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->vat22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->vat12, 0 )

         // zakup opodatkowany do sprzeda�y opodatkowanej - warto�� netto
         aRow[ 'zak_op_net' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
            + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'O', rejz->wart00, 0 )

         // zakup opodatkowany do sprzeda�y opodatkowanej - warto�� VAT
         aRow[ 'zak_op_vat' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->vat12, 0 )

         // Nabycie netto opodatkowana - do sumy
         aRow[ 'nab_netto_o' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O' .AND. rejz->vat02 <> 0, rejz->wart02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O' .AND. rejz->vat07 <> 0, rejz->wart07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O' .AND. rejz->vat22 <> 0, rejz->wart22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O' .AND. rejz->vat12 <> 0, rejz->wart12, 0 ) ;
            + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'O', rejz->wart00, 0 )

         // Nabycie netto mieszana - do sumy
         aRow[ 'nab_netto_m' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M' .AND. rejz->vat02 <> 0, rejz->wart02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M' .AND. rejz->vat07 <> 0, rejz->wart07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M' .AND. rejz->vat22 <> 0, rejz->wart22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M' .AND. rejz->vat12 <> 0, rejz->wart12, 0 ) ;
            + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'M', rejz->wart00, 0 )

         // zakup opodatkowany do sprzeda�y mieszanej - warto�� netto
         aRow[ 'zak_mi_net' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
            + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'M', rejz->wart00, 0 )

         // zakup opodatkowany do sprzeda�y mieszanej - warto�� vat
         aRow[ 'zak_mi_vat' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->vat12, 0 )

         // zakup opodatkowany do sprzeda�y mieszanej - odlicz vat
         aRow[ 'zak_mi_odl' ] := aRow[ 'zak_mi_vat' ] * ( zstrusprob / 100 )

         aRow[ 'netto_a' ] := rejz->wart22
         aRow[ 'vat_a' ] := rejz->vat22
         aRow[ 'netto_b' ] := rejz->wart07
         aRow[ 'vat_b' ] := rejz->vat07
         aRow[ 'netto_c' ] := rejz->wart02
         aRow[ 'vat_c' ] := rejz->vat02
         aRow[ 'netto_d' ] := rejz->wart12
         aRow[ 'vat_d' ] := rejz->vat12
         aRow[ 'netto_zr' ] := rejz->wart00
         aRow[ 'netto_zw' ] := rejz->wartzw

         aRow[ 'zak_bez_odl' ] := iif( rejz->rach == 'R', rejz->wart22 + rejz->wart12 + rejz->wart07 ;
            + rejz->wart02 + rejz->wart00 + rejz->wartzw + rejz->vat22 + rejz->vat12 + rejz->vat07 ;
            + rejz->vat02, iif( rejz->zom02 == 'Z', rejz->wart02 + rejz->vat02, 0 ) ;
            + iif( rejz->zom07 == 'Z', rejz->wart07 + rejz->vat07, 0 ) ;
            + iif( rejz->zom22 == 'Z', rejz->wart22 + rejz->vat22, 0 ) ;
            + iif( rejz->zom12 == 'Z', rejz->wart12+vat12, 0 ) ;
            + iif( rejz->zom00 == 'Z', rejz->wart00, 0 ) + rejz->wartzw )

         aRow[ 'zak_odl_vat' ] := iif( rejz->rach == 'R', 0, iif( rejz->zom02 <> 'Z', rejz->vat02, 0 ) ;
            + iif( rejz->zom07 <> 'Z', rejz->vat07, 0 ) ;
            + iif( rejz->zom22 <> 'Z', rejz->vat22, 0 ) ;
            + iif( rejz->zom12 <> 'Z', rejz->vat12,0 ) )

         aRow[ 'zak_odl_netto' ] := iif( rejz->rach == 'R', 0, ;
            iif( rejz->zom02 <> 'Z', rejz->wart02, 0 ) ;
            + iif( rejz->zom07 <> 'Z', rejz->wart07, 0 ) ;
            + iif( rejz->zom22 <> 'Z', rejz->wart22, 0 ) ;
            + iif( rejz->zom12 <> 'Z', rejz->wart12, 0 ) ;
            + iif( rejz->zom00 <> 'Z', rejz->wart00, 0 ) )

         DO CASE
         CASE rejz->sek_cv7 == 'WT' .OR. rejz->sek_cv7 == 'WZ' .OR. ( lTylkoUE .AND. rejz->sek_cv7 == 'WS' )
            aRow[ 'zak_wt_net' ] := iif( rejz->spzw $ cRodzaj, rejz->wartzw, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'M', rejz->wart00, 0 )

            aRow[ 'zak_wt_vat' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) + paliwa + pojazdy

            aRow[ 'ue_wt_net' ] := rejz->wartzw + rejz->wart02 + rejz->wart07 + rejz->wart22 + rejz->wart12 + rejz->wart00
            aRow[ 'ue_wt_vat' ] := rejz->vat02 + rejz->vat07 + rejz->vat22 + rejz->vat12

         CASE rejz->sek_cv7 == 'IT' .OR. rejz->sek_cv7 == 'IZ' .OR. ( lTylkoUE .AND. rejz->sek_cv7 == 'IS' )
            aRow[ 'zak_it_net' ] := iif( rejz->spzw $ cRodzaj, rejz->wartzw, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'M', rejz->wart00, 0 )

            aRow[ 'zak_it_vat' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) + paliwa + pojazdy

            aRow[ 'ue_it_net' ] := rejz->wartzw + rejz->wart02 + rejz->wart07 + rejz->wart22 + rejz->wart12 + rejz->wart00
            aRow[ 'ue_it_vat' ] := rejz->vat02 + rejz->vat07 + rejz->vat22 + rejz->vat12

         CASE rejz->sek_cv7 == 'IU' .OR. rejz->sek_cv7 == 'UZ' .OR. ( lTylkoUE .AND. rejz->sek_cv7 == 'US' )
             aRow[ 'zak_iu_net' ] := iif( rejz->spzw $ cRodzaj, rejz->wartzw, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'M', rejz->wart00, 0 )

            aRow[ 'zak_iu_vat' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) + paliwa + pojazdy

            aRow[ 'ue_iu_net' ] := rejz->wartzw + rejz->wart02 + rejz->wart07 + rejz->wart22 + rejz->wart12 + rejz->wart00
            aRow[ 'ue_iu_vat' ] := rejz->vat02 + rejz->vat07 + rejz->vat22 + rejz->vat12

         CASE rejz->sek_cv7 == 'PN' .OR. rejz->sek_cv7 == 'PZ' .OR. ( lTylkoUE .AND. rejz->sek_cv7 == 'PS' )
            aRow[ 'zak_pn_net' ] := iif( rejz->spzw $ cRodzaj, rejz->wartzw, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
               + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'M', rejz->wart00, 0 )

            aRow[ 'zak_pn_vat' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'Z', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'Z', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'Z', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'Z', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) + paliwa + pojazdy

            aRow[ 'ue_pn_net' ] := rejz->wartzw + rejz->wart02 + rejz->wart07 + rejz->wart22 + rejz->wart12 + rejz->wart00
            aRow[ 'ue_pn_vat' ] := rejz->vat02 + rejz->vat07 + rejz->vat22 + rejz->vat12

         ENDCASE

      ENDCASE

      aRow[ 'netto_ksiega' ] := rejz->netto + rejz->netto2

      aRow[ 'wartosc_netto' ] := aRow[ 'zak_zwol_net' ] + aRow[ 'zak_op_net' ] + aRow[ 'zak_mi_net' ] + aRow[ 'pojazdy' ]

      aRow[ 'wartosc_vat' ] := aRow[ 'zak_zwol_vat' ] + aRow[ 'zak_op_vat' ] + aRow[ 'zak_mi_vat' ] + aRow[ 'pojazdy' ]

      IF ( lTylkoKsiega .OR. ( aRow[ 'wartosc_netto' ] <> 0 .OR. aRow[ 'wartosc_vat' ] <> 0 ) ) ;
         .AND. rejz->korekta == iif( ewid_rzk == 'N', 'N', iif( ewid_rzk == 'T', 'T', rejz->korekta ) ) ;
         .AND. iif( ewid_rzi <> '**', rejz->symb_rej == ewid_rzi, .T. ) ;
         .AND. iif( ! lTylkoUE, ( ewid_rzz$'NW' .OR. ( ewid_rzz == 'D' .AND. rejz->zaplata$'23' ) .OR. ( ewid_rzz == 'Z' .AND. rejz->zaplata == '1') ), .T. ) ;
         .AND. iif( cRodzaj == 'P', Eval( bFiltr ), .T. ) ;
         .AND. iif( lTylkoUE, AScan( { 'WT', 'WS', 'IT', 'IU', 'PN', 'PS', 'IS', 'US' }, rejz->sek_cv7 ) > 0, .T. )

         nFZ := 0
         nZZ := 0

         IF lWgVat .AND. rejz->rozrzapz == 'T'
            nRekZak := RecNo()
            SELECT 8
            SET ORDER TO 2
            SEEK cFirma + param_rok + 'Z' +Str( nRekZak, 10 )
            IF Found()
               cKluczStat := cFirma + rozr->nip + rozr->wyr
               SET ORDER TO 1
   			   SEEK cKluczStat
               DO WHILE Eof() .AND. rozr->firma + rozr->nip + rozr->wyr == cKluczStat
                  DO CASE
                  CASE rozr->rodzdok == 'FZ'
                     nFZ := nFZ + ( rozr->mnoznik * rozr->kwota )
                  CASE rozr->rodzdok == 'ZZ'
                     nZZ := nZZ + ( rozr->mnoznik * rozr->kwota )
                  ENDCASE
                  SKIP
               ENDDO
		      ENDIF
            SELECT 1
		   ENDIF

         aRow[ 'fz' ] := nFZ
         aRow[ 'zz' ] := nZZ

         aRow[ 'fz_zz' ] := nFZ + nZZ

         aRow[ 'korekta' ] := iif( rejz->korekta == 'T', '1', '0' )
         aRow[ 'symbol_rej' ] := AllTrim( rejz->symb_rej )
         aRow[ 'dzien' ] := StrTran( rejz->dzien, ' ', '0' ) + '.' + StrTran( cMiesiac, ' ', '0' )
         aRow[ 'data_wystawienia' ] := rejz->roks + '.' + StrTran( rejz->mcs, ' ', '0' ) + '.' + StrTran( rejz->dziens, ' ', '0' )
         aRow[ 'datatran' ] := DToC( rejz->datatran )
         aRow[ 'rodzaj' ] := iif( rejz->rach == 'F', 'Faktura', 'Rachunek' )
         aRow[ 'numer' ] := AllTrim( iif( Left( rejz->numer, 1 ) == Chr( 1 ) .OR. Left( rejz->numer, 1 ) == Chr( 254 ), SubStr( rejz->numer, 2 ), rejz->numer ) )
         aRow[ 'nazwa' ] := AllTrim( rejz->nazwa )
         aRow[ 'nr_ident' ] := AllTrim( rejz->nr_ident )
         aRow[ 'zakup_ue' ] := iif( rejz->ue == 'T', '1', '0' )
         aRow[ 'przedmiot' ] := AllTrim( rejz->tresc )
         aRow[ 'sekcja' ] := AllTrim( rejz->sek_cv7 )
         aRow[ 'kolumna' ] := AllTrim( rejz->kolumna ) + iif( Val( rejz->kolumna2 ) > 0, ',' + rejz->kolumna2, '' )
         nLP++
         aRow[ 'lp' ] := nLP
         AAdd( aRes, aRow )

      ENDIF

      rejz->( dbSkip() )

   ENDDO

   aDane[ 'pozycje' ] := aRes

   close_()

   RETURN aDane

/*----------------------------------------------------------------------*/

/*
  nRaport: 1 - srodki trwale
           2 - pozostale
           3 - pozostale wg vat
           4 - zakup UE / import
*/
FUNCTION RejVAT_Zak_Drukuj( nRaport, cFirma, cMiesiac, ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz )

   LOCAL nDruk, bFiltr, lTylkoKsiega := .F.
   LOCAL aDane, oRap, nMonDruk, oWorkbook, oWorksheet, cPlikWyj, nWiersz
   LOCAL aRodzaj := { 'S', 'P', 'SP', 'SP' }
   LOCAL aWgVat := { .F., .F., .T., .F. }
   LOCAL aTylkoUE := { .F., .F., .F., .T. }
   LOCAL aPlikiMem := { '', 'rejzpzze', 'rejzsze', 'rejszuep' }

   nDruk := GrafTekst_Wczytaj( ident_fir, "RejVATZak", 1 )

   IF ( nDruk := MenuEx( 14, 2, { "T - Druk tekstowy", "P - Druk graficzny A4 (poziomo)", ;
      "Z - Zapisz do pliku..." }, nDruk ) ) > 0

      GrafTekst_Zapisz( ident_fir, "RejVATZak", nDruk )

      SAVE TO ewid ALL LIKE ewid_*
      ColStd()
      @ 24, 0

      DO CASE
      CASE nDruk == 1
         SWITCH nRaport
         CASE 1
            rejzst( ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz )
            EXIT
         CASE 2
            rejzpz( ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz )
            EXIT
         CASE 3
            rejzs( ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz )
            EXIT
         CASE 4
            rejsZUE( ewid_rzs, ewid_rzk, ewid_rzi )
            EXIT
         ENDSWITCH
      CASE nDruk == 2

         IF aRodzaj[ nRaport ] == 'P'
            bFiltr := RejVAT_Zak_Filtr( aPlikiMem[ nRaport ], @lTylkoKsiega )
            IF HB_ISLOGICAL( bFiltr )
               RETURN NIL
            ENDIF
         ENDIF

         aDane := RejVAT_Zak_Dane( cFirma, cMiesiac, aRodzaj[ nRaport ], ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz, bFiltr, aWgVat[ nRaport ], aTylkoUE[ nRaport ], lTylkoKsiega )
         IF hb_HHasKey( aDane, 'pozycje' ) .AND. HB_ISARRAY( aDane[ 'pozycje' ] ) .AND. Len( aDane[ 'pozycje' ] ) > 0

            @ 24, 0
            @ 24, 26 PROMPT '[ Monitor ]'
            @ 24, 44 PROMPT '[ Drukarka ]'
            IF trybSerwisowy
               @ 24, 70 PROMPT '[ Edytor ]'
            ENDIF
            CLEAR TYPE
            menu TO nMonDruk
            IF LastKey() == K_ESC
               RETURN
            ENDIF

            TRY
               oRap := FRUtworzRaport()

               SWITCH nRaport
               CASE 1
               CASE 2
                  oRap:LoadFromFile( 'frf\rejz.frf' )
                  EXIT
               CASE 3
                  oRap:LoadFromFile( 'frf\rejzv.frf' )
                  EXIT
               CASE 4
                  oRap:LoadFromFile( 'frf\rejzu.frf' )
                  EXIT
               ENDSWITCH

               IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
                  oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
               ENDIF

               FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
                  hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

               oRap:AddValue( 'uzytkownik', code() )
               oRap:AddValue( 'miesiac', aDane[ 'miesiac' ] )
               oRap:AddValue( 'rok', aDane[ 'rok' ] )
               oRap:AddValue( 'firma', aDane[ 'firma' ] )
               oRap:AddValue( 'rejestr', aDane[ 'rejestr' ] )
               oRap:AddValue( 'jaki_rej', aDane[ 'jaki_rej' ] )
               oRap:AddValue( 'opis_rej', aDane[ 'opis_rej' ] )
               oRap:AddValue( 'strusprob', aDane[ 'strusprob' ] )
               oRap:AddValue( 'kol_netto_brutto', ewid_rzs )

               oRap:AddDataset('pozycje')
               AEval(aDane['pozycje'], { |aPoz| oRap:AddRow('pozycje', aPoz) })

               oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
               oRap:ModalPreview := .F.

               SWITCH nMonDruk
               CASE 1
                  oRap:ShowReport()
                  EXIT
               CASE 2
                  oRap:PrepareReport()
                  oRap:PrintPreparedReport('', 1)
                  EXIT
               CASE 3
                  oRap:DesignReport()
                  EXIT
               ENDSWITCH
            CATCH oErr
               Alert( "Wyst�pi� b��d podczas generowania wydruku;" + oErr:description )
            END

            oRap := NIL

         ELSE

            kom( 3, '*w', 'b r a k   d a n y c h' )

         ENDIF

      CASE nDruk == 3

         IF ( cPlikWyj := FPSFileSaveDialog() ) <> ""

            IF aRodzaj[ nRaport ] == 'P'
               bFiltr := RejVAT_Zak_Filtr( aPlikiMem[ nRaport ], @lTylkoKsiega )
               IF HB_ISLOGICAL( bFiltr )
                  RETURN NIL
               ENDIF
            ENDIF

            aDane := RejVAT_Zak_Dane( cFirma, cMiesiac, aRodzaj[ nRaport ], ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz, bFiltr, aWgVat[ nRaport ], aTylkoUE[ nRaport ], lTylkoKsiega )
            IF hb_HHasKey( aDane, 'pozycje' ) .AND. HB_ISARRAY( aDane[ 'pozycje' ] ) .AND. Len( aDane[ 'pozycje' ] ) > 0

               IF ( oWorkbook := TsWorkbook():New() ) <> NIL
                  oWorksheet := oWorkbook:AddWorksheet( "Rejestr zakup�w" )
                  SWITCH nRaport
                  CASE 1
                  CASE 2
                     oWorksheet:WriteColWidth( 0, 10, 0 )
                     oWorksheet:WriteColWidth( 1, 10, 0 )
                     oWorksheet:WriteColWidth( 2, 10, 0 )
                     oWorksheet:WriteColWidth( 3, 3, 0 )
                     oWorksheet:WriteColWidth( 4, 3, 0 )
                     oWorksheet:WriteColWidth( 5, 15, 0 )
                     oWorksheet:WriteColWidth( 6, 25, 0 )
                     oWorksheet:WriteColWidth( 7, 12, 0 )
                     oWorksheet:WriteColWidth( 8, 3, 0 )
                     oWorksheet:WriteColWidth( 9, 25, 0 )
                     oWorksheet:WriteColWidth( 10, 10, 0 )
                     oWorksheet:WriteColWidth( 11, 3, 0 )
                     oWorksheet:WriteColWidth( 12, 3, 0 )
                     oWorksheet:WriteColWidth( 13, 15, 0 )
                     oWorksheet:WriteColWidth( 14, 15, 0 )
                     oWorksheet:WriteColWidth( 15, 15, 0 )
                     oWorksheet:WriteColWidth( 16, 15, 0 )
                     oWorksheet:WriteColWidth( 17, 15, 0 )
                     oWorksheet:WriteColWidth( 18, 15, 0 )
                     oWorksheet:WriteColWidth( 19, 15, 0 )
                     oWorksheet:WriteColWidth( 20, 15, 0 )
                     oWorksheet:WriteColWidth( 21, 15, 0 )
                     oWorksheet:WriteColWidth( 22, 15, 0 )

                     oWorksheet:WriteText( 0, 0, "Rejestr zakup�w - " + ;
                        aDane[ 'rejestr' ] + " (" + aDane[ 'jaki_rej' ] + ;
                        " - " + aDane[ 'opis_rej' ] + ")      za miesi�c   " + ;
                        aDane[ 'miesiac' ] + ", " + aDane[ 'rok' ] )
                     oWorksheet:WriteText( 1, 0, aDane[ 'firma' ] )

                     oWorksheet:WriteText( 3, 0, "Data rejestru" )
                     oWorksheet:WriteText( 3, 1, "Data wystawienia" )
                     oWorksheet:WriteText( 3, 2, "Data wp�ywu" )
                     oWorksheet:WriteText( 3, 3, "Rodzaj dokumentu" )
                     oWorksheet:WriteText( 3, 4, "Kolumny ksi�gi" )
                     oWorksheet:WriteText( 3, 5, "Nr dowodu" )
                     oWorksheet:WriteText( 3, 6, "Nazwa dostawcy" )
                     oWorksheet:WriteText( 3, 7, "NIP dostawcy" )
                     oWorksheet:WriteText( 3, 8, "Zakup UE" )
                     oWorksheet:WriteText( 3, 9, "Przedmiot zakupu" )
                     oWorksheet:WriteText( 3, 10, "Oznaczenia" )
                     oWorksheet:WriteText( 3, 11, "Sekcja Deklaracji" )
                     oWorksheet:WriteText( 3, 12, "Symbol rejestru" )
                     oWorksheet:WriteText( 3, 13, "Og�lna warto�� " + iif( ewid_rzs == 'B', "brutto", "netto" ) )
                     oWorksheet:WriteText( 3, 14, "Zak. niepodl. odlicz. NETTO" )
                     oWorksheet:WriteText( 3, 15, "Zak. niepodl. odlicz. VAT" )
                     oWorksheet:WriteText( 3, 16, "Zak. opodat. od sprz. opodat. NETTO" )
                     oWorksheet:WriteText( 3, 17, "Zak. opodat. od sprz. opodat. VAT" )
                     oWorksheet:WriteText( 3, 18, "Zak. opodat. od sprz. miesz. NETTO" )
                     oWorksheet:WriteText( 3, 19, "Zak. opodat. od sprz. miesz. VAT" )
                     oWorksheet:WriteText( 3, 20, "Zak. opodat. od sprz. miesz. VAT odlicz" )
                     oWorksheet:WriteText( 3, 21, "Do ksi�gi" )
                     oWorksheet:WriteText( 3, 22, "Og�lna warto�� VAT" )
                     nWiersz := 4
                     AEval( aDane[ 'pozycje' ], { | aRow |
                        oWorksheet:WriteText( nWiersz, 0, aRow[ 'dzien' ] )
                        oWorksheet:WriteText( nWiersz, 1, aRow[ 'data_wystawienia' ] )
                        oWorksheet:WriteText( nWiersz, 2, aRow[ 'datatran' ] )
                        oWorksheet:WriteText( nWiersz, 3, aRow[ 'rodzaj' ] )
                        oWorksheet:WriteText( nWiersz, 4, aRow[ 'kolumna' ] )
                        oWorksheet:WriteText( nWiersz, 5, aRow[ 'numer' ] )
                        oWorksheet:WriteText( nWiersz, 6, aRow[ 'nazwa' ] )
                        oWorksheet:WriteText( nWiersz, 7, aRow[ 'nr_ident' ] )
                        IF aRow[ 'zakup_ue' ] == '1'
                           oWorksheet:WriteText( nWiersz, 8, "Tak" )
                        ENDIF
                        oWorksheet:WriteText( nWiersz, 9, aRow[ 'przedmiot' ] )
                        oWorksheet:WriteText( nWiersz, 10, aRow[ 'oznaczenia' ] )
                        oWorksheet:WriteText( nWiersz, 11, aRow[ 'sekcja' ] )
                        oWorksheet:WriteText( nWiersz, 12, aRow[ 'symbol_rej' ] )
                        oWorksheet:WriteCurrency( nWiersz, 13, aRow[ 'wartosc_netto' ] + iif( ewid_rzs == 'B', aRow[ 'wartosc_vat' ], 0 ) )
                        IF aRow[ 'zak_zwol_net' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 14, aRow[ 'zak_zwol_net' ] )
                        ENDIF
                        IF aRow[ 'zak_zwol_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 15, aRow[ 'zak_zwol_vat' ] )
                        ENDIF
                        IF aRow[ 'zak_op_net' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 16, aRow[ 'zak_op_net' ] )
                        ENDIF
                        IF aRow[ 'zak_op_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 17, aRow[ 'zak_op_vat' ] )
                        ENDIF
                        IF aRow[ 'zak_mi_net' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 18, aRow[ 'zak_mi_net' ] )
                        ENDIF
                        IF aRow[ 'zak_mi_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 19, aRow[ 'zak_mi_vat' ] )
                        ENDIF
                        IF aRow[ 'zak_mi_odl' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 20, aRow[ 'zak_mi_odl' ] )
                        ENDIF
                        IF aRow[ 'netto_ksiega' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 21, aRow[ 'netto_ksiega' ] )
                        ENDIF
                        IF aRow[ 'wartosc_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 22, aRow[ 'wartosc_vat' ] )
                        ENDIF
                        nWiersz++
                     } )
                     IF oWorkbook:WriteToFile( cPlikWyj ) == 0
                        Komun( "Plik zosta� utworzony" )
                     ENDIF

                     EXIT
                  CASE 3
                     oWorksheet:WriteColWidth( 0, 10, 0 )
                     oWorksheet:WriteColWidth( 1, 10, 0 )
                     oWorksheet:WriteColWidth( 2, 10, 0 )
                     oWorksheet:WriteColWidth( 3, 3, 0 )
                     oWorksheet:WriteColWidth( 4, 3, 0 )
                     oWorksheet:WriteColWidth( 5, 15, 0 )
                     oWorksheet:WriteColWidth( 6, 25, 0 )
                     oWorksheet:WriteColWidth( 7, 12, 0 )
                     oWorksheet:WriteColWidth( 8, 3, 0 )
                     oWorksheet:WriteColWidth( 9, 25, 0 )
                     oWorksheet:WriteColWidth( 10, 10, 0 )
                     oWorksheet:WriteColWidth( 11, 3, 0 )
                     oWorksheet:WriteColWidth( 12, 3, 0 )
                     oWorksheet:WriteColWidth( 13, 15, 0 )
                     oWorksheet:WriteColWidth( 14, 15, 0 )
                     oWorksheet:WriteColWidth( 15, 15, 0 )
                     oWorksheet:WriteColWidth( 16, 15, 0 )
                     oWorksheet:WriteColWidth( 17, 15, 0 )
                     oWorksheet:WriteColWidth( 18, 15, 0 )
                     oWorksheet:WriteColWidth( 19, 15, 0 )
                     oWorksheet:WriteColWidth( 20, 15, 0 )
                     oWorksheet:WriteColWidth( 21, 15, 0 )
                     oWorksheet:WriteColWidth( 22, 15, 0 )
                     oWorksheet:WriteColWidth( 23, 15, 0 )
                     oWorksheet:WriteColWidth( 24, 15, 0 )
                     oWorksheet:WriteColWidth( 25, 15, 0 )
                     oWorksheet:WriteColWidth( 26, 15, 0 )
                     oWorksheet:WriteColWidth( 27, 15, 0 )

                     oWorksheet:WriteText( 0, 0, "Rejestr zakup�w wg stawek - " + ;
                        aDane[ 'rejestr' ] + " (" + aDane[ 'jaki_rej' ] + ;
                        " - " + aDane[ 'opis_rej' ] + ")      za miesi�c   " + ;
                        aDane[ 'miesiac' ] + ", " + aDane[ 'rok' ] )
                     oWorksheet:WriteText( 1, 0, aDane[ 'firma' ] )

                     oWorksheet:WriteText( 3, 0, "Data rejestru" )
                     oWorksheet:WriteText( 3, 1, "Data wystawienia" )
                     oWorksheet:WriteText( 3, 2, "Data wp�ywu" )
                     oWorksheet:WriteText( 3, 3, "Rodzaj dokumentu" )
                     oWorksheet:WriteText( 3, 4, "Kolumny ksi�gi" )
                     oWorksheet:WriteText( 3, 5, "Nr dowodu" )
                     oWorksheet:WriteText( 3, 6, "Nazwa dostawcy" )
                     oWorksheet:WriteText( 3, 7, "NIP dostawcy" )
                     oWorksheet:WriteText( 3, 8, "Zakup UE" )
                     oWorksheet:WriteText( 3, 9, "Przedmiot zakupu" )
                     oWorksheet:WriteText( 3, 10, "Oznaczenia" )
                     oWorksheet:WriteText( 3, 11, "Sekcja Deklaracji" )
                     oWorksheet:WriteText( 3, 12, "Symbol rejestru" )
                     oWorksheet:WriteText( 3, 13, "Og�lna warto�� " + iif( ewid_rzs == 'B', "brutto", "netto" ) )
                     oWorksheet:WriteText( 3, 14, "Zak. wg. st. 23% NETTO" )
                     oWorksheet:WriteText( 3, 15, "Zak. wg. st. 23% VAT" )
                     oWorksheet:WriteText( 3, 16, "Zak. wg. st. 8% NETTO" )
                     oWorksheet:WriteText( 3, 17, "Zak. wg. st. 8% VAT" )
                     oWorksheet:WriteText( 3, 18, "Zak. wg. st. 5% NETTO" )
                     oWorksheet:WriteText( 3, 19, "Zak. wg. st. 5% VAT" )
                     oWorksheet:WriteText( 3, 20, "Zak. wg. st. 7% NETTO" )
                     oWorksheet:WriteText( 3, 21, "Zak. wg. st. 7% VAT" )
                     oWorksheet:WriteText( 3, 22, "Zak. wg. st. 0%" )
                     oWorksheet:WriteText( 3, 23, "Zak. zwol. od pod." )
                     oWorksheet:WriteText( 3, 24, "Zakupy bez odlicze� (NETTO + VAT)" )
                     oWorksheet:WriteText( 3, 25, "Zakupy z odliczeniami NETTO" )
                     oWorksheet:WriteText( 3, 26, "Zakupy z odliczeniami VAT" )
                     oWorksheet:WriteText( 3, 27, "Stan rozr." )
                     nWiersz := 4
                     AEval( aDane[ 'pozycje' ], { | aRow |
                        oWorksheet:WriteText( nWiersz, 0, aRow[ 'dzien' ] )
                        oWorksheet:WriteText( nWiersz, 1, aRow[ 'data_wystawienia' ] )
                        oWorksheet:WriteText( nWiersz, 2, aRow[ 'datatran' ] )
                        oWorksheet:WriteText( nWiersz, 3, aRow[ 'rodzaj' ] )
                        oWorksheet:WriteText( nWiersz, 4, aRow[ 'kolumna' ] )
                        oWorksheet:WriteText( nWiersz, 5, aRow[ 'numer' ] )
                        oWorksheet:WriteText( nWiersz, 6, aRow[ 'nazwa' ] )
                        oWorksheet:WriteText( nWiersz, 7, aRow[ 'nr_ident' ] )
                        IF aRow[ 'zakup_ue' ] == '1'
                           oWorksheet:WriteText( nWiersz, 8, "Tak" )
                        ENDIF
                        oWorksheet:WriteText( nWiersz, 9, aRow[ 'przedmiot' ] )
                        oWorksheet:WriteText( nWiersz, 10, aRow[ 'oznaczenia' ] )
                        oWorksheet:WriteText( nWiersz, 11, aRow[ 'sekcja' ] )
                        oWorksheet:WriteText( nWiersz, 12, aRow[ 'symbol_rej' ] )
                        oWorksheet:WriteCurrency( nWiersz, 13, aRow[ 'wartosc_netto' ] + iif( ewid_rzs == 'B', aRow[ 'wartosc_vat' ], 0 ) )
                        IF aRow[ 'netto_a' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 14, aRow[ 'netto_a' ] )
                        ENDIF
                        IF aRow[ 'vat_a' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 15, aRow[ 'vat_a' ] )
                        ENDIF
                        IF aRow[ 'netto_b' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 16, aRow[ 'netto_b' ] )
                        ENDIF
                        IF aRow[ 'vat_b' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 17, aRow[ 'vat_b' ] )
                        ENDIF
                        IF aRow[ 'netto_c' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 18, aRow[ 'netto_c' ] )
                        ENDIF
                        IF aRow[ 'vat_c' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 19, aRow[ 'vat_c' ] )
                        ENDIF
                        IF aRow[ 'netto_d' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 20, aRow[ 'netto_d' ] )
                        ENDIF
                        IF aRow[ 'vat_d' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 21, aRow[ 'vat_d' ] )
                        ENDIF
                        IF aRow[ 'netto_zr' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 22, aRow[ 'netto_zr' ] )
                        ENDIF
                        IF aRow[ 'netto_zw' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 23, aRow[ 'netto_zw' ] )
                        ENDIF
                        IF aRow[ 'zak_bez_odl' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 24, aRow[ 'zak_bez_odl' ] )
                        ENDIF
                        IF aRow[ 'zak_odl_netto' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 25, aRow[ 'zak_odl_netto' ] )
                        ENDIF
                        IF aRow[ 'zak_odl_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 26, aRow[ 'zak_odl_vat' ] )
                        ENDIF
                        IF aRow[ 'fz_zz' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 27, aRow[ 'fz_zz' ] )
                        ENDIF
                        nWiersz++
                     } )
                     IF oWorkbook:WriteToFile( cPlikWyj ) == 0
                        Komun( "Plik zosta� utworzony" )
                     ENDIF

                     EXIT
                  CASE 4
                     oWorksheet:WriteColWidth( 0, 10, 0 )
                     oWorksheet:WriteColWidth( 1, 10, 0 )
                     oWorksheet:WriteColWidth( 2, 10, 0 )
                     oWorksheet:WriteColWidth( 3, 3, 0 )
                     oWorksheet:WriteColWidth( 4, 3, 0 )
                     oWorksheet:WriteColWidth( 5, 15, 0 )
                     oWorksheet:WriteColWidth( 6, 25, 0 )
                     oWorksheet:WriteColWidth( 7, 12, 0 )
                     oWorksheet:WriteColWidth( 8, 3, 0 )
                     oWorksheet:WriteColWidth( 9, 25, 0 )
                     oWorksheet:WriteColWidth( 10, 10, 0 )
                     oWorksheet:WriteColWidth( 11, 3, 0 )
                     oWorksheet:WriteColWidth( 12, 3, 0 )
                     oWorksheet:WriteColWidth( 13, 15, 0 )
                     oWorksheet:WriteColWidth( 14, 15, 0 )
                     oWorksheet:WriteColWidth( 15, 15, 0 )
                     oWorksheet:WriteColWidth( 16, 15, 0 )
                     oWorksheet:WriteColWidth( 17, 15, 0 )
                     oWorksheet:WriteColWidth( 18, 15, 0 )
                     oWorksheet:WriteColWidth( 19, 15, 0 )
                     oWorksheet:WriteColWidth( 20, 15, 0 )
                     oWorksheet:WriteColWidth( 21, 15, 0 )
                     oWorksheet:WriteColWidth( 22, 15, 0 )

                     oWorksheet:WriteText( 0, 0, "Rejestr zakup�w UE, import... - " + ;
                        aDane[ 'rejestr' ] + " (" + aDane[ 'jaki_rej' ] + ;
                        " - " + aDane[ 'opis_rej' ] + ")      za miesi�c   " + ;
                        aDane[ 'miesiac' ] + ", " + aDane[ 'rok' ] )
                     oWorksheet:WriteText( 1, 0, aDane[ 'firma' ] )

                     oWorksheet:WriteText( 3, 0, "Data rejestru" )
                     oWorksheet:WriteText( 3, 1, "Data wystawienia" )
                     oWorksheet:WriteText( 3, 2, "Data wp�ywu" )
                     oWorksheet:WriteText( 3, 3, "Rodzaj dokumentu" )
                     oWorksheet:WriteText( 3, 4, "Kolumny ksi�gi" )
                     oWorksheet:WriteText( 3, 5, "Nr dowodu" )
                     oWorksheet:WriteText( 3, 6, "Nazwa dostawcy" )
                     oWorksheet:WriteText( 3, 7, "NIP dostawcy" )
                     oWorksheet:WriteText( 3, 8, "Zakup UE" )
                     oWorksheet:WriteText( 3, 9, "Przedmiot zakupu" )
                     oWorksheet:WriteText( 3, 10, "Oznaczenia" )
                     oWorksheet:WriteText( 3, 11, "Sekcja Deklaracji" )
                     oWorksheet:WriteText( 3, 12, "Symbol rejestru" )
                     oWorksheet:WriteText( 3, 13, "Og�lna warto�� " + iif( ewid_rzs == 'B', "brutto", "netto" ) )
                     oWorksheet:WriteText( 3, 14, "Wewn.nab.tow. NETTO" )
                     oWorksheet:WriteText( 3, 15, "Wewn.nab.tow. VAT" )
                     oWorksheet:WriteText( 3, 16, "Import towar�w NETTO" )
                     oWorksheet:WriteText( 3, 17, "Import towar�w VAT" )
                     oWorksheet:WriteText( 3, 18, "Import us�ug NETTO" )
                     oWorksheet:WriteText( 3, 19, "Import us�ug VAT" )
                     oWorksheet:WriteText( 3, 20, "Podatnikiem nabywca NETTO" )
                     oWorksheet:WriteText( 3, 21, "Podatnikiem nabywca VAT" )
                     oWorksheet:WriteText( 3, 22, "Og�lna warto�� VAT" )
                     nWiersz := 4
                     AEval( aDane[ 'pozycje' ], { | aRow |
                        oWorksheet:WriteText( nWiersz, 0, aRow[ 'dzien' ] )
                        oWorksheet:WriteText( nWiersz, 1, aRow[ 'data_wystawienia' ] )
                        oWorksheet:WriteText( nWiersz, 2, aRow[ 'datatran' ] )
                        oWorksheet:WriteText( nWiersz, 3, aRow[ 'rodzaj' ] )
                        oWorksheet:WriteText( nWiersz, 4, aRow[ 'kolumna' ] )
                        oWorksheet:WriteText( nWiersz, 5, aRow[ 'numer' ] )
                        oWorksheet:WriteText( nWiersz, 6, aRow[ 'nazwa' ] )
                        oWorksheet:WriteText( nWiersz, 7, aRow[ 'nr_ident' ] )
                        IF aRow[ 'zakup_ue' ] == '1'
                           oWorksheet:WriteText( nWiersz, 8, "Tak" )
                        ENDIF
                        oWorksheet:WriteText( nWiersz, 9, aRow[ 'przedmiot' ] )
                        oWorksheet:WriteText( nWiersz, 10, aRow[ 'oznaczenia' ] )
                        oWorksheet:WriteText( nWiersz, 11, aRow[ 'sekcja' ] )
                        oWorksheet:WriteText( nWiersz, 12, aRow[ 'symbol_rej' ] )
                        oWorksheet:WriteCurrency( nWiersz, 13, aRow[ 'wartosc_netto' ] + iif( ewid_rzs == 'B', aRow[ 'wartosc_vat' ], 0 ) )
                        IF aRow[ 'ue_wt_net' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 14, aRow[ 'ue_wt_net' ] )
                        ENDIF
                        IF aRow[ 'ue_wt_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 15, aRow[ 'ue_wt_vat' ] )
                        ENDIF
                        IF aRow[ 'ue_it_net' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 16, aRow[ 'ue_it_net' ] )
                        ENDIF
                        IF aRow[ 'ue_it_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 17, aRow[ 'ue_it_vat' ] )
                        ENDIF
                        IF aRow[ 'ue_iu_net' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 18, aRow[ 'ue_iu_net' ] )
                        ENDIF
                        IF aRow[ 'ue_iu_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 19, aRow[ 'ue_iu_vat' ] )
                        ENDIF
                        IF aRow[ 'ue_pn_net' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 20, aRow[ 'ue_pn_net' ] )
                        ENDIF
                        IF aRow[ 'ue_pn_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 21, aRow[ 'ue_pn_vat' ] )
                        ENDIF
                        IF aRow[ 'wartosc_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 22, aRow[ 'wartosc_vat' ] )
                        ENDIF
                        nWiersz++
                     } )
                     IF oWorkbook:WriteToFile( cPlikWyj ) == 0
                        Komun( "Plik zosta� utworzony" )
                     ENDIF

                     EXIT
                  ENDSWITCH
                  oWorksheet := NIL
                  oWorkbook := NIL
               ENDIF

            ENDIF

         ENDIF

      ENDCASE

   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION RejVAT_Zak_Filtr( cMemFile, lTylkoKsiega )

   LOCAL bRes, cRes := '', cRes2 := ''
   LOCAL x, y
   LOCAL aRej := { '10', '11', '12', '13', '16', '  ' }
   LOCAL aRach := { 'R', 'F' }

   MEMVAR  xx, yy, qqs, qqr, qqss
   PRIVATE  xx, yy, qqs, qqr, qqss

   FOR x := 1 TO 10
      FOR y := 1 TO 9
         xx := StrTran( Str( x, 2 ), ' ', '0' )
         yy := StrTran( Str( y, 2 ), ' ', '0' )
         rspz_&xx&yy := 'T'
      NEXT
   NEXT

   IF File( cMemFile + '.mem' )
      RESTORE FROM ( cMemFile ) ADDITIVE
   ELSE
      IF ! File( cMemFile + '.mem' )
         FOR x := 1 TO 10
            FOR y := 1 TO 9
               xx := StrTran( Str( x, 2 ), ' ', '0' )
               yy := StrTran( Str( y, 2 ), ' ', '0' )
               rspz_&xx&yy := 'T'
            NEXT
         NEXT
         SAVE TO ( cMemFile ) ALL LIKE rspz_*
      ENDIF
   ENDIF

   @  3, 42 SAY Space( 38 )
   @  4, 42 SAY Space( 38 )
   @  5, 42 SAY Space( 38 )
   @  6, 42 SAY '                ����������������������'
   @  7, 42 SAY '                �      WARIANTY       '
   @  8, 42 SAY '��������������������������������������'
   @  9, 42 SAY ' KOLUMNY KSIEGI � 1 2 3 4 5 6 7 8 9 10'
   @ 10, 42 SAY '��������������������������������������'
   @ 11, 42 SAY '10-Zakup towarow�                     '
   @ 12, 42 SAY '11-Koszty ubocz.�                     '
   @ 13, 42 SAY '12-Wynagr.w got.�                     '
   @ 14, 42 SAY '13-Pozostale wyd�                     '
   @ 15, 42 SAY '16-Koszty badaw.�                     '
   @ 16, 42 SAY '   NIEKSIEGOWANE�                     '
   @ 17, 42 SAY 'RACHUNKI (T/N) ?�                     '
   @ 18, 42 SAY 'FAKTURY  (T/N) ?�                     '
   @ 19, 42 SAY 'Tylko ksi�gowane�                     '
   @ 20, 42 SAY '��������������������������������������'
   @ 21, 42 SAY Space( 38 )
   @ 22, 42 SAY Space( 38 )
   SET COLOR TO w+
   FOR x := 1 TO 10
      FOR y := 1 TO 9
         xx := StrTran( Str( x, 2 ), ' ', '0' )
         yy := StrTran( Str( y, 2 ), ' ', '0' )
         @ 10 + y, 58 + ( x * 2 ) SAY rspz_&xx&yy PICTURE '!'
      NEXT
   NEXT
   SET COLOR TO
   QQS := 1
   DO WHILE QQS <> 0
      SET COLOR TO w+
      FOR x := 1 TO 10
         FOR y := 1 TO 9
            xx := StrTran( Str( x, 2 ), ' ', '0' )
            yy := StrTran( str( y, 2 ), ' ', '0' )
            @ 10 + y, 58 + ( x * 2 ) SAY rspz_&xx&yy PICTURE '!'
         NEXT
      NEXT
      SET COLOR TO
      @ 9, 60 PROMPT '1 '
      @ 9, 62 PROMPT '2 '
      @ 9, 64 PROMPT '3 '
      @ 9, 66 PROMPT '4 '
      @ 9, 68 PROMPT '5 '
      @ 9, 70 PROMPT '6 '
      @ 9, 72 PROMPT '7 '
      @ 9, 74 PROMPT '8 '
      @ 9, 76 PROMPT '9 '
      @ 9, 78 PROMPT '10'
      MENU TO QQS
      IF LastKey() == K_ESC
         QQS := 0
         EXIT
      ENDIF
      QQR := 1
      @ 21, 42 PROMPT PadC( 'DRUKOWANIE REJESTRU wg PARAMETROW', 38 )
      @ 22, 42 PROMPT PadC( 'MODYFIKACJA PARAMETROW', 38 )
      MENU TO QQR
      IF LastKey() == K_ESC
         QQR := 0
         EXIT
      ENDIF
      DO CASE
      CASE QQR == 1
         QQSS := StrTran( Str( QQS, 2 ), ' ', '0' )
         EXIT
      CASE QQR == 2
         SET CURS ON
         QQSS := StrTran( Str( QQS, 2 ), ' ', '0' )
         FOR y := 1 TO 9
            yy := StrTran( Str( y, 2 ), ' ', '0' )
            @ 10 + y, 58 + ( QQS * 2 ) GET rspz_&QQSS&yy PICTURE '!' VALID rspz_&QQSS&yy$'TN'
         NEXT
         READ
         SAVE TO ( cMemFile ) ALL LIKE rspz_*
         SET CURS OFF
      ENDCASE
      @ 21, 42 CLEAR TO 21, 79
      @ 22, 42 CLEAR TO 22, 79
   ENDDO

   IF QQS == 0 .OR. QQR == 0
      RETURN .F.
   ENDIF

   FOR y := 1 TO 6
      yy := StrTran( Str( y, 2 ), ' ', '0' )
      IF rspz_&QQSS&yy == 'T'
         IF Len( cRes ) > 0
            cRes := cRes + ' .OR. '
         ENDIF
         cRes := cRes + ' rejz->kolumna == "' + aRej[ y ] + '" .OR. rejz->kolumna2 == "' + aRej[ y ] + '"'
         IF y == 4
            cRes := cRes + ' .OR. rejz->kolumna == "14" .OR. rejz->kolumna2 == "14"'
         ENDIF
      ENDIF
   NEXT

   IF Len( cRes ) == 0
      cRes := ' .T. '
   ENDIF

   FOR y := 7 TO 8
      yy := StrTran( Str( y, 2 ), ' ', '0' )
      IF rspz_&QQSS&yy == 'T'
         IF Len( cRes2 ) > 0
            cRes2 := cRes2 + ' .OR. '
         ENDIF
         cRes2 := cRes2 + ' rejz->rach == "' + aRach[ y - 6 ] + '"'
      ENDIF
   NEXT

   IF Len( cRes2 ) == 0
      cRes2 := ' .T. '
   ENDIF

   cRes := '{ || (' + cRes + ') .AND. (' + cRes2 + ') }'
   bRes := &cRes

   yy := StrTran( Str( 9, 2 ), ' ', '0' )
   IF rspz_&QQSS&yy == 'T'
      lTylkoKsiega := .T.
   ELSE
      lTylkoKsiega := .F.
   ENDIF

   RETURN bRes

/*----------------------------------------------------------------------*/

FUNCTION RejVAT_Zak_Marza_Dane( cFirma, cMiesiac )

   LOCAL aRes := {}, aRow
   LOCAL aDane := hb_Hash()
   //LOCAL cKoniec := 'rejz->del#"+" .OR. rejz->firma#cFirma .OR. rejz->mc#cMiesiac'
   LOCAL bKoniec := { || rejz->del#"+" .OR. rejz->firma#cFirma .OR. rejz->mc#cMiesiac }
   LOCAL nLP := 0

   aDane[ 'pozycje' ] := {}
   aDane[ 'rok' ] := param_rok
   aDane[ 'miesiac' ] := Upper( miesiac( Val( cMiesiac ) ) )

   SELECT 3
   IF dostep( 'FIRMA' )
      GO Val( cFirma )
   ELSE
      SELECT 1
      RETURN aDane
   ENDIF
   // Przyjety  wskazn.odliczenia
   zstrusprob := firma->strusprob

   aDane[ 'strusprob' ] := firma->strusprob
   aDane[ 'firma' ] := AllTrim( firma->nazwa ) + ' ' + firma->miejsc + ' ul.' + firma->ulica + ' '+ firma->nr_domu + iif( Empty( firma->nr_mieszk ),' ','/' ) + firma->nr_mieszk

   SELECT 1
   IF dostep( 'REJZ' )
      SETIND( 'REJZ' )
      SEEK '+' + cFirma + cMiesiac
   ELSE
      SELECT 1
      RETURN aDane
   ENDIF

   IF rejz->( Eof() ) .OR. Eval( bKoniec )
      RETURN aDane
   ELSE
      SEEK '+' + cFirma + cMiesiac
      DO WHILE ! rejz->( Eof() ) .AND. ! Eval( bKoniec )
         IF rejz->vatmarza <> 0
            aRow := hb_Hash()
            aRow[ 'korekta' ] := iif( rejz->korekta == 'T', '1', '0' )
            aRow[ 'symbol_rej' ] := AllTrim( rejz->symb_rej )
            aRow[ 'dzien' ] := StrTran( rejz->dzien, ' ', '0' ) + '.' + StrTran( cMiesiac, ' ', '0' )
            aRow[ 'data_wystawienia' ] := rejz->roks + '.' + StrTran( rejz->mcs, ' ', '0' ) + '.' + StrTran( rejz->dziens, ' ', '0' )
            aRow[ 'datatran' ] := DToC( rejz->datatran )
            aRow[ 'rodzaj' ] := iif( rejz->rach == 'F', 'Faktura', 'Rachunek' )
            aRow[ 'numer' ] := AllTrim( iif( Left( rejz->numer, 1 ) == Chr( 1 ) .OR. Left( rejz->numer, 1 ) == Chr( 254 ), SubStr( rejz->numer, 2 ), rejz->numer ) )
            aRow[ 'nazwa' ] := AllTrim( rejz->nazwa )
            aRow[ 'nr_ident' ] := AllTrim( rejz->nr_ident )
            aRow[ 'zakup_ue' ] := iif( rejz->ue == 'T', '1', '0' )
            aRow[ 'przedmiot' ] := AllTrim( rejz->tresc )
            aRow[ 'sekcja' ] := AllTrim( rejz->sek_cv7 )
            aRow[ 'kolumna' ] := AllTrim( rejz->kolumna ) + iif( Val( rejz->kolumna2 ) > 0, ',' + rejz->kolumna2, '' )
            aRow[ 'vatmarza' ] := rejz->vatmarza
            aRow[ 'netto_ksiega' ] := rejz->netto + rejz->netto2
            aRow[ 'rodzdow' ] := AllTrim( rejz->rodzdow )
            aRow[ 'mpp' ] := rejz->sek_cv7 == 'SP'
            aRow[ 'imp' ] := rejz->sek_cv7 == 'IT' .OR. rejz->sek_cv7 == 'IZ' .OR. rejz->sek_cv7 == 'IS' .OR. ( rejz->kraj <> "" .AND. rejz->kraj <> "PL" .AND. ! KrajUE( rejz->kraj ) .AND. rejz->sek_cv7 <> 'IU' .AND. rejz->sek_cv7 <> 'UZ' .AND. rejz->sek_cv7 <> 'US' )
            aRow[ 'oznaczenia' ] := aRow[ 'rodzdow' ]
            IF aRow[ 'mpp' ]
               IF aRow[ 'oznaczenia' ] <> ""
                  aRow[ 'oznaczenia' ] := aRow[ 'oznaczenia' ] + ";"
               ENDIF
               aRow[ 'oznaczenia' ] := aRow[ 'oznaczenia' ] + "MPP"
            ENDIF
            IF aRow[ 'imp' ]
               IF aRow[ 'oznaczenia' ] <> ""
                  aRow[ 'oznaczenia' ] := aRow[ 'oznaczenia' ] + ";"
               ENDIF
               aRow[ 'oznaczenia' ] := aRow[ 'oznaczenia' ] + "IMP"
            ENDIF
            nLP++
            aRow[ 'lp' ] := nLP
            AAdd( aRes, aRow )
         ENDIF
         rejz->( dbSkip() )
      ENDDO

      aDane[ 'pozycje' ] := aRes

   ENDIF

   close_()

   RETURN aDane

/*----------------------------------------------------------------------*/

PROCEDURE RejVAT_Zak_Marza( cFirma, cMiesiac )

   LOCAL aDane := RejVAT_Zak_Marza_Dane( cFirma, cMiesiac )
   LOCAL nMenu, oWorkbook, oWorksheet, cPlikWyj, nWiersz

   IF hb_HHasKey( aDane, 'pozycje' ) .AND. HB_ISARRAY( aDane[ 'pozycje' ] ) .AND. Len( aDane[ 'pozycje' ] ) > 0

      nMenu := MenuEx( 17, 2, { "D - Wydruk graficzny", "Z - Zapis do pliku..." }, 1, .T. )

      SWITCH nMenu
      CASE 1

         @ 24, 0
         @ 24, 26 PROMPT '[ Monitor ]'
         @ 24, 44 PROMPT '[ Drukarka ]'
         IF trybSerwisowy
            @ 24, 70 PROMPT '[ Edytor ]'
         ENDIF
         CLEAR TYPE
         menu TO nMonDruk
         IF LastKey() == K_ESC
            RETURN
         ENDIF

         TRY
            oRap := FRUtworzRaport()

            oRap:LoadFromFile( 'frf\rejzm.frf' )

            IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
               oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
            ENDIF

            FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
               hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

            oRap:AddValue( 'uzytkownik', code() )
            oRap:AddValue( 'miesiac', aDane[ 'miesiac' ] )
            oRap:AddValue( 'rok', aDane[ 'rok' ] )
            oRap:AddValue( 'firma', aDane[ 'firma' ] )
            oRap:AddValue( 'strusprob', aDane[ 'strusprob' ] )

            oRap:AddDataset('pozycje')
            AEval(aDane['pozycje'], { |aPoz| oRap:AddRow('pozycje', aPoz) })

            oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
            oRap:ModalPreview := .F.

            SWITCH nMonDruk
            CASE 1
               oRap:ShowReport()
               EXIT
            CASE 2
               oRap:PrepareReport()
               oRap:PrintPreparedReport('', 1)
               EXIT
            CASE 3
               oRap:DesignReport()
               EXIT
            ENDSWITCH
         CATCH oErr
            Alert( "Wyst�pi� b��d podczas generowania wydruku;" + oErr:description )
         END

         oRap := NIL

         EXIT
      CASE 2
         IF ( cPlikWyj := FPSFileSaveDialog() ) <> ""
            IF ( oWorkbook := TsWorkbook():New() ) <> NIL
               oWorksheet := oWorkbook:AddWorksheet( "Rejestr zakup�w" )

               oWorksheet:WriteColWidth( 0, 10, 0 )
               oWorksheet:WriteColWidth( 1, 10, 0 )
               oWorksheet:WriteColWidth( 2, 10, 0 )
               oWorksheet:WriteColWidth( 3, 3, 0 )
               oWorksheet:WriteColWidth( 4, 3, 0 )
               oWorksheet:WriteColWidth( 5, 15, 0 )
               oWorksheet:WriteColWidth( 6, 25, 0 )
               oWorksheet:WriteColWidth( 7, 12, 0 )
               oWorksheet:WriteColWidth( 8, 25, 0 )
               oWorksheet:WriteColWidth( 9, 3, 0 )
               oWorksheet:WriteColWidth( 10, 15, 0 )
               oWorksheet:WriteColWidth( 11, 15, 0 )

               oWorksheet:WriteText( 0, 0, "Rejestr zakup�w do sprzeda�y w proc. mar�y za miesi�c " + ;
                  aDane[ 'miesiac' ] + ", " + aDane[ 'rok' ] )
               oWorksheet:WriteText( 1, 0, aDane[ 'firma' ] )

               oWorksheet:WriteText( 3, 0, "Data rejestru" )
               oWorksheet:WriteText( 3, 1, "Data wystawienia" )
               oWorksheet:WriteText( 3, 2, "Data wp�ywu" )
               oWorksheet:WriteText( 3, 3, "Rodzaj dokumentu" )
               oWorksheet:WriteText( 3, 4, "Kolumny ksi�gi" )
               oWorksheet:WriteText( 3, 5, "Nr dowodu" )
               oWorksheet:WriteText( 3, 6, "Nazwa dostawcy" )
               oWorksheet:WriteText( 3, 7, "NIP dostawcy" )
               oWorksheet:WriteText( 3, 8, "Przedmiot zakupu" )
               oWorksheet:WriteText( 3, 9, "Symbol rejestru" )
               oWorksheet:WriteText( 3, 10, "Do ksi�gi" )
               oWorksheet:WriteText( 3, 11, "Og�lna warto�� VAT" )
               nWiersz := 4
               AEval( aDane[ 'pozycje' ], { | aRow |
                  oWorksheet:WriteText( nWiersz, 0, aRow[ 'dzien' ] )
                  oWorksheet:WriteText( nWiersz, 1, aRow[ 'data_wystawienia' ] )
                  oWorksheet:WriteText( nWiersz, 2, aRow[ 'datatran' ] )
                  oWorksheet:WriteText( nWiersz, 3, aRow[ 'rodzaj' ] )
                  oWorksheet:WriteText( nWiersz, 4, aRow[ 'kolumna' ] )
                  oWorksheet:WriteText( nWiersz, 5, aRow[ 'numer' ] )
                  oWorksheet:WriteText( nWiersz, 6, aRow[ 'nazwa' ] )
                  oWorksheet:WriteText( nWiersz, 7, aRow[ 'nr_ident' ] )
                  oWorksheet:WriteText( nWiersz, 8, aRow[ 'przedmiot' ] )
                  oWorksheet:WriteText( nWiersz, 9, aRow[ 'symbol_rej' ] )
                  IF aRow[ 'netto_ksiega' ] <> 0
                     oWorksheet:WriteCurrency( nWiersz, 10, aRow[ 'netto_ksiega' ] )
                  ENDIF
                  IF aRow[ 'vatmarza' ] <> 0
                     oWorksheet:WriteCurrency( nWiersz, 11, aRow[ 'vatmarza' ] )
                  ENDIF
                  nWiersz++
               } )
               IF oWorkbook:WriteToFile( cPlikWyj ) == 0
                  Komun( "Plik zosta� utworzony" )
               ENDIF

            ENDIF
            oWorksheet := NIL
            oWorkbook := NIL
         ENDIF
         EXIT
      ENDSWITCH
   ELSE

      kom( 3, '*w', 'b r a k   d a n y c h' )

   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION RejVAT_Sp_Dane( nRaport, cFirma, cMiesiac, ewid_rss, ewid_rsk, ewid_rsi, ewid_rsz, aFiltr )

   LOCAL bKoniec := { || rejs->del#'+' .OR. rejs->firma#cFirma .OR. rejs->mc#cMiesiac }
   LOCAL cOpisRej := ''
   LOCAL lJest := .F.
   LOCAL aDane := hb_Hash()
   LOCAL aRow
   LOCAL nRekZak, cKluczStat, nFS, nZS, nLp := 1
   LOCAL cOpisDod

   aDane[ 'pozycje' ] := {}
   aDane[ 'rok' ] := param_rok
   aDane[ 'miesiac' ] := Upper( miesiac( Val( cMiesiac ) ) )

   SELECT 8
   DO WHILE ! dostep( 'ROZR' )
   ENDDO
   setind( 'ROZR' )

   SELECT 7
   IF ewid_rsi <> '**'
      DO WHILE ! dostep( 'KAT_SPR' )
      ENDDO
      SetInd( 'KAT_SPR' )
      SEEK '+' + cFirma + ewid_rsi
      IF Found()
         cOpisRej := AllTrim( kat_spr->opis )
      ENDIF
   ELSE
      cOpisRej := 'WSZYSTKIE REJESTRY RAZEM'
   ENDIF
   USE

   aDane[ 'jaki_rej' ] := ewid_rsi
   aDane[ 'opis_rej' ] := cOpisRej

   SELECT 4
   IF dostep( 'KONTR' )
      setind( 'KONTR' )
   ELSE
      SELECT 1
      RETURN aDane
   ENDIF
   SELECT 3
   IF dostep( 'FIRMA' )
      GO Val( cFirma )
   ELSE
      SELECT 1
      RETURN aDane
   ENDIF

   aDane[ 'firma' ] := AllTrim( firma->nazwa ) + ' ' + firma->miejsc + ' ul.' + firma->ulica + ' '+ firma->nr_domu + iif( Empty( firma->nr_mieszk ),' ','/' ) + firma->nr_mieszk

   IF dostep( 'REJS' )
      SETIND( 'REJS' )
      SEEK '+' + cFirma + cMiesiac
   ELSE
      SELECT 1
      RETURN aDane
   ENDIF

   IF rejs->( Eof() ) .OR. Eval( bKoniec )
      //kom( 3, '*w', 'b r a k   d a n y c h' )
      RETURN aDane
   ELSE
      SEEK '+' + cFirma + cMiesiac
      DO WHILE ! rejs->( Eof() ) .AND. ! Eval( bKoniec )
         IF iif( ewid_rsk <> 'R', rejs->korekta == ewid_rsk, .T. ) .AND. iif( ewid_rsi <> '**', rejs->symb_rej == ewid_rsi, .T.)
            lJest := .T.
            EXIT
         ELSE
            SKIP 1
         ENDIF
      ENDDO
      IF ! lJest
         //kom( 3, '*w', 'b r a k   d a n y c h' )
         RETURN aDane
      ENDIF
   ENDIF

   DO WHILE ! Eval( bKoniec )

      aRow := hb_Hash()

      cOpisDod := ""
      cOpisDod := iif( AllTrim( rejs->rodzdow ) == "", '', 'RD:' + AllTrim( rejs->rodzdow ) + ";" ) + ;
         iif( AllTrim( rejs->opcje ) == "", "", "GTU:" + AllTrim( rejs->opcje ) + ";" ) + ;
         iif( AllTrim( rejs->procedur ) == "", "", "Pr:" + AllTrim( rejs->procedur ) + ";" ) + ;
         iif( rejs->sek_cv7 == 'PN' .OR. rejs->sek_cv7 =='PU' .OR. rejs->sek_cv7 == "SP", "MPP", "" )

      aRow[ 'kolumna' ] := iif( rejs->kolumna == ' 0', '  ', rejs->kolumna )
      aRow[ 'rodzaj' ] := iif( rejs->rach == 'R', 'Rachunek', 'Faktura' )
      aRow[ 'numer' ] := AllTrim( iif( Left( rejs->numer, 1 ) == Chr( 1 ) .OR. Left( rejs->numer, 1 ) == Chr( 254 ), SubStr( rejs->numer, 2 ) + ' ', rejs->numer ) )
      aRow[ 'nazwa' ] := AllTrim( rejs->nazwa )
      aRow[ 'nr_ident' ] := AllTrim( rejs->nr_ident )
      aRow[ 'tresc' ] := AllTrim( rejs->tresc ) + iif( cOpisDod <> "", " (" + cOpisDod + ")", "" )
      aRow[ 'symb_rej' ] := AllTrim( rejs->symb_rej )
      aRow[ 'dzien' ] := StrTran( rejs->dzien, ' ', '0' ) + '.' + StrTran( cMiesiac, ' ', '0' )
      aRow[ 'data_sprzedazy' ] := rejs->roks + '.' + StrTran( rejs->mcs, ' ' , '0' ) + '.' + StrTran( rejs->dziens, ' ', '0' )
      aRow[ 'datatran' ] := DToC( rejs->datatran )
      aRow[ 'korekta' ] := iif( rejs->korekta == 'T', 'kor', iif( rejs->korekta == 'Z', 'z.d', '' ) )
      aRow[ 'uwagi' ] := AllTrim( rejs->uwagi )

      aRow[ 'dnetto_a' ] := rejs->wart22
      aRow[ 'dvat_a' ] := rejs->vat22
      aRow[ 'dnetto_b' ] := rejs->wart07
      aRow[ 'dvat_b' ] := rejs->vat07
      aRow[ 'dnetto_c' ] := rejs->wart02
      aRow[ 'dvat_c' ] := rejs->vat02
      aRow[ 'dnetto_d' ] := rejs->wart12
      aRow[ 'dvat_d' ] := rejs->vat12

      IF ( AllTrim( rejs->rodzdow ) == "FP" .AND. ! aFiltr[ 'sumujFP' ] ) ;
         .OR. ( At( "MR_UZ", rejs->procedur ) > 0 .AND. ( rejs->wart22 < 0 .OR. ;
         rejs->wart07 < 0 .OR. rejs->wart02 < 0 .OR. rejs->wart12 < 0 )  .AND. rejs->korekta <> 'T' )

         aRow[ 'netto_a' ] := 0
         aRow[ 'vat_a' ] := 0
         aRow[ 'netto_b' ] := 0
         aRow[ 'vat_b' ] := 0
         aRow[ 'netto_c' ] := 0
         aRow[ 'vat_c' ] := 0
         aRow[ 'netto_d' ] := 0
         aRow[ 'vat_d' ] := 0
      ELSE
         aRow[ 'netto_a' ] := rejs->wart22
         aRow[ 'vat_a' ] := rejs->vat22
         aRow[ 'netto_b' ] := rejs->wart07
         aRow[ 'vat_b' ] := rejs->vat07
         aRow[ 'netto_c' ] := rejs->wart02
         aRow[ 'vat_c' ] := rejs->vat02
         aRow[ 'netto_d' ] := rejs->wart12
         aRow[ 'vat_d' ] := rejs->vat12
      ENDIF

      aRow[ 'dnetto_zr_kraj' ] := 0
      aRow[ 'dnetto_zr_eksp' ] := 0
      aRow[ 'dnetto_zr_wdt' ] := 0
      IF rejs->wart00 <> 0
         IF rejs->ue == 'T'
            aRow[ 'dnetto_zr_wdt' ] := rejs->wart00
         ENDIF
         IF rejs->ue <> 'T' .AND. rejs->export == 'T'
            aRow[ 'dnetto_zr_eksp' ] := rejs->wart00
         ENDIF
         IF rejs->ue <> 'T' .AND. rejs->export <> 'T'
            aRow[ 'dnetto_zr_kraj' ] := rejs->wart00
         ENDIF
      ENDIF

      IF ( AllTrim( rejs->rodzdow ) == "FP" .AND. ! aFiltr[ 'sumujFP' ] ) ;
         .OR. ( At( "MR_UZ", rejs->procedur ) > 0 .AND. ( aRow[ 'dnetto_zr_kraj' ] < 0 .OR. ;
         aRow[ 'dnetto_zr_eksp' ] < 0 .OR. aRow[ 'dnetto_zr_wdt' ] < 0 ) .AND. rejs->korekta <> 'T' )

         aRow[ 'netto_zr_kraj' ] := 0
         aRow[ 'netto_zr_eksp' ] := 0
         aRow[ 'netto_zr_wdt' ] := 0
      ELSE
         aRow[ 'netto_zr_kraj' ] := aRow[ 'dnetto_zr_kraj' ]
         aRow[ 'netto_zr_eksp' ] := aRow[ 'dnetto_zr_eksp' ]
         aRow[ 'netto_zr_wdt' ] := aRow[ 'dnetto_zr_wdt' ]
      ENDIF


      aRow[ 'dnetto_zw' ] := rejs->wartzw
      aRow[ 'dnetto_np' ] := rejs->wart08

      IF ( AllTrim( rejs->rodzdow ) == "FP" .AND. ! aFiltr[ 'sumujFP' ] ) ;
         .OR. ( At( "MR_UZ", rejs->procedur ) > 0 .AND. ( rejs->wartzw < 0 .OR. ;
         rejs->wart08 < 0 ) .AND. rejs->korekta <> 'T' )

         aRow[ 'netto_zw' ] := 0
         aRow[ 'netto_np' ] := 0
      ELSE
         aRow[ 'netto_zw' ] := rejs->wartzw
         aRow[ 'netto_np' ] := rejs->wart08
      ENDIF

      aRow[ 'pn_netto_a' ] := 0
      aRow[ 'pn_vat_a' ] := 0
      aRow[ 'pn_netto_b' ] := 0
      aRow[ 'pn_vat_b' ] := 0
      aRow[ 'pn_netto_c' ] := 0
      aRow[ 'pn_vat_c' ] := 0
      aRow[ 'pn_netto_d' ] := 0
      aRow[ 'pn_vat_d' ] := 0

      aRow[ 'pn_netto_zr_kraj' ] := 0
      aRow[ 'pn_netto_zr_eksp' ] := 0
      aRow[ 'pn_netto_zr_wdt' ] := 0

      aRow[ 'pn_netto_zw' ] := 0
      aRow[ 'pn_netto_np' ] := 0

      IF rejs->sek_cv7 == 'PN' .OR. rejs->sek_cv7 =='PU' .OR. rejs->sek_cv7 =='SP'

         aRow[ 'pn_netto_a' ] := rejs->wart22
         aRow[ 'pn_vat_a' ] := rejs->vat22
         aRow[ 'pn_netto_b' ] := rejs->wart07
         aRow[ 'pn_vat_b' ] := rejs->vat07
         aRow[ 'pn_netto_c' ] := rejs->wart02
         aRow[ 'pn_vat_c' ] := rejs->vat02
         aRow[ 'pn_netto_d' ] := rejs->wart12
         aRow[ 'pn_vat_d' ] := rejs->vat12

         aRow[ 'pn_netto_zr_kraj' ] := 0
         aRow[ 'pn_netto_zr_eksp' ] := 0
         aRow[ 'pn_netto_zr_wdt' ] := 0
         IF rejs->wart00 <> 0
            IF rejs->ue == 'T'
               aRow[ 'pn_netto_zr_wdt' ] := rejs->wart00
            ENDIF
            IF rejs->ue <> 'T' .AND. rejs->export == 'T'
               aRow[ 'pn_netto_zr_eksp' ] := rejs->wart00
            ENDIF
            IF rejs->ue <> 'T' .AND. rejs->export <> 'T'
               aRow[ 'pn_netto_zr_kraj' ] := rejs->wart00
            ENDIF
         ENDIF

         aRow[ 'pn_netto_zw' ] := rejs->wartzw
         aRow[ 'pn_netto_np' ] := rejs->wart08

      ENDIF

      aRow[ 'kwota' ] := rejs->kwota
      aRow[ 'rach' ] := rejs->rach

      aRow[ 'dwartosc_netto' ] := aRow[ 'dnetto_a' ] + aRow[ 'dnetto_b' ] + aRow[ 'dnetto_c' ] ;
         + aRow[ 'dnetto_d' ] + aRow[ 'dnetto_zr_wdt' ] + aRow[ 'dnetto_zr_eksp' ] ;
         + aRow[ 'dnetto_zr_kraj' ] + aRow[ 'dnetto_zw' ] + aRow[ 'dnetto_np' ]

      aRow[ 'dwartosc_vat' ] := aRow[ 'dvat_a' ] + aRow[ 'dvat_b' ] + aRow[ 'dvat_c' ] + aRow[ 'dvat_d' ]

      IF ( AllTrim( rejs->rodzdow ) == "FP" .AND. ! aFiltr[ 'sumujFP' ] ) ;
         .OR. ( At( "MR_UZ", rejs->procedur ) > 0 .AND. aRow[ 'dwartosc_netto' ] < 0 .AND. rejs->korekta <> 'T' )

         aRow[ 'wartosc_netto' ] := 0
         aRow[ 'wartosc_vat' ] := 0
      ELSE
         aRow[ 'wartosc_netto' ] := aRow[ 'dwartosc_netto' ]
         aRow[ 'wartosc_vat' ] := aRow[ 'dwartosc_vat' ]
      ENDIF

      aRow[ 'pn_wartosc_netto' ] := aRow[ 'pn_netto_a' ] + aRow[ 'pn_netto_b' ] + aRow[ 'pn_netto_c' ] ;
         + aRow[ 'pn_netto_d' ] + aRow[ 'pn_netto_zr_wdt' ] + aRow[ 'pn_netto_zr_eksp' ] ;
         + aRow[ 'pn_netto_zr_kraj' ] + aRow[ 'pn_netto_zw' ] + aRow[ 'pn_netto_np' ]

      aRow[ 'pn_wartosc_vat' ] := aRow[ 'pn_vat_a' ] + aRow[ 'pn_vat_b' ] + aRow[ 'pn_vat_c' ] + aRow[ 'pn_vat_d' ]

      aRow[ 'netto_op' ] := aRow[ 'netto_a' ] + aRow[ 'netto_b' ] + aRow[ 'netto_c' ] ;
         + aRow[ 'netto_d' ] + rejs->wart00

      aRow[ 'vatmarza' ] := rejs->vatmarza

      nFS := 0
      nZS := 0

      IF rejs->rozrzaps == 'T'
         nRekZak := RecNo()
	      SELECT 8
         SET ORDER TO 2
         SEEK cFirma + param_rok + 'S' + Str( nRekZak, 10 )
         IF Found()
            cKluczStat := cFirma + rozr->nip + rozr->wyr
            SET ORDER TO 1
			   SEEK cKluczStat
            nFS := 0
            nZS := 0
            DO WHILE ! Eof() .AND. rozr->firma + rozr->nip + rozr->wyr == cKluczStat
               DO CASE
               CASE rozr->rodzdok == 'FS'
                  nFS := nFS + ( rozr->mnoznik * rozr->kwota )
               CASE rozr->rodzdok == 'ZS'
                  nZS := nZS + ( rozr->mnoznik * rozr->kwota )
               ENDCASE
               SKIP
            ENDDO
         ENDIF
      ENDIF

      aRow[ 'fs' ] := nFS
      aRow[ 'zs' ] := nZS
      aRow[ 'fs_zs' ] := nFS + nZS

      IF iif( ewid_rsk <> 'R', rejs->korekta == ewid_rsk, .T. ) ;
         .AND. iif( ewid_rsi <> '**', rejs->symb_rej == ewid_rsi, .T. ) ;
         .AND. ( ewid_rsz$'NW' .OR. ( ewid_rsz == 'D' .AND. ( nFS + nZS ) <> 0.0 ) .OR. ( ewid_rsz == 'Z' .AND. ( nFS + nZS ) == 0 ) ) ;
         .AND. ( aFiltr[ 'rodzaj' ] == "*"  .OR. aFiltr[ 'rodzaj' ] == AllTrim( rejs->rodzdow ) ) ;
         .AND. ( Len( aFiltr[ 'opcje' ] ) == 0 .OR. ( AllTrim( rejs->opcje ) <> "" .AND. Len( AMerge( aFiltr[ 'opcje' ], gm_ATokens( AllTrim( rejs->opcje ), ',' ) ) ) > 0 ) ) ;
         .AND. ( Len( aFiltr[ 'procedura' ] ) == 0 .OR. AScan( aFiltr[ 'procedura' ], "MPP" ) > 0 .OR. ( AllTrim( rejs->procedur ) <> "" .AND. Len( AMerge( aFiltr[ 'procedura' ], gm_ATokens( AllTrim( rejs->procedur ), ',' ) ) ) > 0 ) ) ;
         .AND. ( AScan( aFiltr[ 'procedura' ], "MPP" ) == 0 .OR. rejs->sek_cv7 == "SP" ) ;
         .AND. ( aFiltr[ 'dolaczFP' ] .OR. AllTrim( rejs->rodzdow ) <> "FP" )

         aRow[ 'lp' ] := nLp
         AAdd( aDane[ 'pozycje' ], aRow )
         nLP++

      ENDIF

      rejs->( dbSkip() )

   ENDDO

   close_()

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION RejVAT_Sp_Drukuj( nRaport, cFirma, cMiesiac, ewid_rss, ewid_rsk, ewid_rsi, ewid_rzz )

   LOCAL aDane, aFiltr

   SAVE TO ewid ALL LIKE ewid_*
   ColStd()
   @ 24, 0

   aFiltr := RejVAT_Sp_Filtr()

   IF ! HB_ISHASH( aFiltr )
      RETURN
   ENDIF

   nDruk := GrafTekst_Wczytaj( ident_fir, "RejVATSp", 1 )

   IF ( nDruk := MenuEx( 14, 2, { "T - Druk tekstowy", "P - Druk graficzny A4 (poziomo)", "Z - Zapisz do pliku..." }, nDruk ) ) > 0

      GrafTekst_Zapisz( ident_fir, "RejVATSp", nDruk )

      SWITCH nDruk
      CASE 1

         SWITCH nRaport
         CASE 1
            rejs( ewid_rs1s, ewid_rs1k, ewid_rs1i, ewid_rs1z, aFiltr )
            EXIT
         CASE 2
            rejsKNEW( ewid_rs2s, ewid_rs2k, ewid_rs2i, aFiltr )
            EXIT
         ENDSWITCH

         EXIT
      CASE 2

         aDane := RejVAT_Sp_Dane( nRaport, cFirma, cMiesiac, ewid_rss, ewid_rsk, ewid_rsi, ewid_rzz, aFiltr )

         IF Len( aDane[ 'pozycje' ] ) > 0

            @ 24, 0
            @ 24, 26 PROMPT '[ Monitor ]'
            @ 24, 44 PROMPT '[ Drukarka ]'
            IF trybSerwisowy
               @ 24, 70 PROMPT '[ Edytor ]'
            ENDIF
            CLEAR TYPE
            menu TO nMonDruk
            IF LastKey() == K_ESC
               RETURN
            ENDIF

            TRY
               oRap := FRUtworzRaport()

               SWITCH nRaport
               CASE 1
                  oRap:LoadFromFile( 'frf\rejs.frf' )
                  EXIT
               CASE 2
                  oRap:LoadFromFile( 'frf\rejsk.frf' )
                  EXIT
               ENDSWITCH

               IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
                  oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
               ENDIF

               FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
                  hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

               oRap:AddValue( 'uzytkownik', code() )
               oRap:AddValue( 'miesiac', aDane[ 'miesiac' ] )
               oRap:AddValue( 'rok', aDane[ 'rok' ] )
               oRap:AddValue( 'firma', aDane[ 'firma' ] )
               oRap:AddValue( 'jaki_rej', aDane[ 'jaki_rej' ] )
               oRap:AddValue( 'opis_rej', aDane[ 'opis_rej' ] )
               oRap:AddValue( 'kol_netto_brutto', ewid_rss )
               oRap:AddValue( 'rodzdowodu', iif( aFiltr[ 'rodzaj' ] == "*", 'wszystkie', iif( aFiltr[ 'rodzaj' ] == "", "bez rodzaju", aFiltr[ 'rodzaj' ] ) ) )
               PRIVATE cRes := ""
               AEval( aFiltr[ 'opcje' ], { | cItem |
                  IF cRes <> ""
                     cRes := cRes + ','
                  ENDIF
                  cRes := cRes + cItem
               } )
               oRap:AddValue( 'oznaczenia', iif( Len( aFiltr[ 'opcje' ] ) == 0, "wszystkie", cRes ) )
               oRap:AddValue( 'procedura', iif( Len( aFiltr[ 'procedura' ] ) == 0, "wszystkie", gm_AStrTok( aFiltr[ 'procedura' ] ) ) )
               oRap:AddValue( 'sumuj', iif( aFiltr[ 'sumujFP' ], 'TAK', 'NIE' ) )

               oRap:AddDataset('pozycje')
               AEval(aDane['pozycje'], { |aPoz| oRap:AddRow('pozycje', aPoz) })

               oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
               oRap:ModalPreview := .F.

               SWITCH nMonDruk
               CASE 1
                  oRap:ShowReport()
                  EXIT
               CASE 2
                  oRap:PrepareReport()
                  oRap:PrintPreparedReport('', 1)
                  EXIT
               CASE 3
                  oRap:DesignReport()
                  EXIT
               ENDSWITCH
            CATCH oErr
               Alert( "Wyst�pi� b��d podczas generowania wydruku;" + oErr:description )
            END

            oRap := NIL

         ELSE
            kom( 3, '*w', 'b r a k   d a n y c h' )
         ENDIF

         EXIT
      CASE 3
         aDane := RejVAT_Sp_Dane( nRaport, cFirma, cMiesiac, ewid_rss, ewid_rsk, ewid_rsi, ewid_rzz, aFiltr )

         IF Len( aDane[ 'pozycje' ] ) > 0
            IF ( cPlikWyj := FPSFileSaveDialog() ) <> ""
               IF ( oWorkbook := TsWorkbook():New() ) <> NIL
                  oWorksheet := oWorkbook:AddWorksheet( "Rejestr sprzeda�y" )
                  SWITCH nRaport
                  CASE 1
                     oWorksheet:WriteColWidth( 0, 10, 0 )
                     oWorksheet:WriteColWidth( 1, 10, 0 )
                     oWorksheet:WriteColWidth( 2, 10, 0 )
                     oWorksheet:WriteColWidth( 3, 3, 0 )
                     oWorksheet:WriteColWidth( 4, 3, 0 )
                     oWorksheet:WriteColWidth( 5, 15, 0 )
                     oWorksheet:WriteColWidth( 6, 25, 0 )
                     oWorksheet:WriteColWidth( 7, 12, 0 )
                     oWorksheet:WriteColWidth( 8, 25, 0 )
                     oWorksheet:WriteColWidth( 9, 3, 0 )
                     oWorksheet:WriteColWidth( 10, 3, 0 )
                     oWorksheet:WriteColWidth( 11, 15, 0 )
                     oWorksheet:WriteColWidth( 12, 15, 0 )
                     oWorksheet:WriteColWidth( 13, 15, 0 )
                     oWorksheet:WriteColWidth( 14, 15, 0 )
                     oWorksheet:WriteColWidth( 15, 15, 0 )
                     oWorksheet:WriteColWidth( 16, 15, 0 )
                     oWorksheet:WriteColWidth( 17, 15, 0 )
                     oWorksheet:WriteColWidth( 18, 15, 0 )
                     oWorksheet:WriteColWidth( 19, 15, 0 )
                     oWorksheet:WriteColWidth( 20, 15, 0 )
                     oWorksheet:WriteColWidth( 21, 15, 0 )
                     oWorksheet:WriteColWidth( 22, 15, 0 )
                     oWorksheet:WriteColWidth( 23, 15, 0 )
                     oWorksheet:WriteColWidth( 24, 15, 0 )
                     oWorksheet:WriteColWidth( 25, 15, 0 )

                     oWorksheet:WriteText( 0, 0, "Rejestr sprzeda�y za miesi�c " + ;
                        aDane[ 'miesiac' ] + ", " + aDane[ 'rok' ] )
                     oWorksheet:WriteText( 1, 0, aDane[ 'firma' ] )

                     PRIVATE cRes := ""
                     AEval( aFiltr[ 'opcje' ], { | cItem |
                        IF cRes <> ""
                           cRes := cRes + ','
                        ENDIF
                        cRes := cRes + cItem
                     } )
                     oWorksheet:WriteText( 2, 0, "Filtr: " + aDane[ 'jaki_rej' ] + ;
                        " - " + aDane[ 'opis_rej' ] + ", rodzaj dowodu: " + ;
                        iif( aFiltr[ 'rodzaj' ] == "*", 'wszystkie', ;
                        iif( aFiltr[ 'rodzaj' ] == "", "bez rodzaju", aFiltr[ 'rodzaj' ] ) ) + ;
                        ", oznaczenia: " + iif( Len( aFiltr[ 'opcje' ] ) == 0, "wszystkie", cRes ) + ;
                        ", procedura: " + iif( Len( aFiltr[ 'procedura' ] ) == 0, "wszystkie", gm_AStrTok( aFiltr[ 'procedura' ] ) ) )

                     oWorksheet:WriteText( 3, 0, "Data rejestru" )
                     oWorksheet:WriteText( 3, 1, "Data wystawienia" )
                     oWorksheet:WriteText( 3, 2, "Data sprzeda�y" )
                     oWorksheet:WriteText( 3, 3, "Rodzaj dokumentu" )
                     oWorksheet:WriteText( 3, 4, "Kolumny ksi�gi" )
                     oWorksheet:WriteText( 3, 5, "Nr dowodu" )
                     oWorksheet:WriteText( 3, 6, "Nazwa" )
                     oWorksheet:WriteText( 3, 7, "NIP" )
                     oWorksheet:WriteText( 3, 8, "Opis zdarzenia" )
                     oWorksheet:WriteText( 3, 9, "Symbol rejestru" )
                     oWorksheet:WriteText( 3, 10, "Korekta" )
                     oWorksheet:WriteText( 3, 11, "Og�lna warto�� " + iif( ewid_rss == 'B', "brutto", "netto" ) )
                     oWorksheet:WriteText( 3, 12, "Sprz. wg. st. 23% NETTO" )
                     oWorksheet:WriteText( 3, 13, "Sprz. wg. st. 23% VAT" )
                     oWorksheet:WriteText( 3, 14, "Sprz. wg. st. 8% NETTO" )
                     oWorksheet:WriteText( 3, 15, "Sprz. wg. st. 8% VAT" )
                     oWorksheet:WriteText( 3, 16, "Sprz. wg. st. 5% NETTO" )
                     oWorksheet:WriteText( 3, 17, "Sprz. wg. st. 5% VAT" )
                     oWorksheet:WriteText( 3, 18, "Sprz. wg. st. 7% NETTO" )
                     oWorksheet:WriteText( 3, 19, "Sprz. wg. st. 7% VAT" )
                     oWorksheet:WriteText( 3, 20, "Sprz. wg. st. 0% kraj" )
                     oWorksheet:WriteText( 3, 21, "Sprz. wg. st. 0% WDT" )
                     oWorksheet:WriteText( 3, 22, "Sprz. wg. st. 0% Eksport" )
                     oWorksheet:WriteText( 3, 23, "Sprz. zwol. od pod." )
                     oWorksheet:WriteText( 3, 24, "Sprz. nie podl. VAT" )
                     oWorksheet:WriteText( 3, 25, "Razem warto�� podatku" )
                     nWiersz := 4
                     AEval( aDane[ 'pozycje' ], { | aRow |
                        oWorksheet:WriteText( nWiersz, 0, aRow[ 'dzien' ] )
                        oWorksheet:WriteText( nWiersz, 1, aRow[ 'data_sprzedazy' ] )
                        oWorksheet:WriteText( nWiersz, 2, aRow[ 'datatran' ] )
                        oWorksheet:WriteText( nWiersz, 3, aRow[ 'rodzaj' ] )
                        oWorksheet:WriteText( nWiersz, 4, aRow[ 'kolumna' ] )
                        oWorksheet:WriteText( nWiersz, 5, aRow[ 'numer' ] )
                        oWorksheet:WriteText( nWiersz, 6, aRow[ 'nazwa' ] )
                        oWorksheet:WriteText( nWiersz, 7, aRow[ 'nr_ident' ] )
                        oWorksheet:WriteText( nWiersz, 8, aRow[ 'tresc' ] )
                        oWorksheet:WriteText( nWiersz, 9, aRow[ 'symb_rej' ] )
                        oWorksheet:WriteText( nWiersz, 10, aRow[ 'korekta' ] )
                        oWorksheet:WriteCurrency( nWiersz, 11, aRow[ 'dwartosc_netto' ] + iif( ewid_rss == 'B', aRow[ 'dwartosc_vat' ], 0 ) )
                        IF aRow[ 'dnetto_a' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 12, aRow[ 'dnetto_a' ] )
                        ENDIF
                        IF aRow[ 'dvat_a' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 13, aRow[ 'dvat_a' ] )
                        ENDIF
                        IF aRow[ 'dnetto_b' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 14, aRow[ 'dnetto_b' ] )
                        ENDIF
                        IF aRow[ 'dvat_b' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 15, aRow[ 'dvat_b' ] )
                        ENDIF
                        IF aRow[ 'dnetto_c' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 16, aRow[ 'dnetto_c' ] )
                        ENDIF
                        IF aRow[ 'dvat_c' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 17, aRow[ 'dvat_c' ] )
                        ENDIF
                        IF aRow[ 'dnetto_d' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 18, aRow[ 'dnetto_d' ] )
                        ENDIF
                        IF aRow[ 'dvat_d' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 19, aRow[ 'dvat_d' ] )
                        ENDIF
                        IF aRow[ 'dnetto_zr_kraj' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 20, aRow[ 'dnetto_zr_kraj' ] )
                        ENDIF
                        IF aRow[ 'dnetto_zr_wdt' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 21, aRow[ 'dnetto_zr_wdt' ] )
                        ENDIF
                        IF aRow[ 'dnetto_zr_eksp' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 22, aRow[ 'dnetto_zr_eksp' ] )
                        ENDIF
                        IF aRow[ 'dnetto_zw' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 23, aRow[ 'dnetto_zw' ] )
                        ENDIF
                        IF aRow[ 'dnetto_np' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 24, aRow[ 'dnetto_np' ] )
                        ENDIF
                        IF aRow[ 'dwartosc_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 25, aRow[ 'dwartosc_vat' ] )
                        ENDIF
                        nWiersz++
                     } )
                     IF oWorkbook:WriteToFile( cPlikWyj ) == 0
                        Komun( "Plik zosta� utworzony" )
                     ENDIF
                     EXIT
                  CASE 2
                     oWorksheet:WriteColWidth( 0, 10, 0 )
                     oWorksheet:WriteColWidth( 1, 10, 0 )
                     oWorksheet:WriteColWidth( 2, 10, 0 )
                     oWorksheet:WriteColWidth( 3, 3, 0 )
                     oWorksheet:WriteColWidth( 4, 3, 0 )
                     oWorksheet:WriteColWidth( 5, 15, 0 )
                     oWorksheet:WriteColWidth( 6, 25, 0 )
                     oWorksheet:WriteColWidth( 7, 12, 0 )
                     oWorksheet:WriteColWidth( 8, 25, 0 )
                     oWorksheet:WriteColWidth( 9, 3, 0 )
                     oWorksheet:WriteColWidth( 10, 15, 0 )
                     oWorksheet:WriteColWidth( 11, 15, 0 )
                     oWorksheet:WriteColWidth( 12, 15, 0 )
                     oWorksheet:WriteColWidth( 13, 15, 0 )
                     oWorksheet:WriteColWidth( 14, 15, 0 )
                     oWorksheet:WriteColWidth( 15, 15, 0 )
                     oWorksheet:WriteColWidth( 16, 25, 0 )

                     oWorksheet:WriteText( 0, 0, "Rejestr korekt sprzeda�y za miesi�c " + ;
                        aDane[ 'miesiac' ] + ", " + aDane[ 'rok' ] )
                     oWorksheet:WriteText( 1, 0, aDane[ 'firma' ] )

                     PRIVATE cRes := ""
                     AEval( aFiltr[ 'opcje' ], { | cItem |
                        IF cRes <> ""
                           cRes := cRes + ','
                        ENDIF
                        cRes := cRes + cItem
                     } )
                     oWorksheet:WriteText( 2, 0, "Filtr: " + aDane[ 'jaki_rej' ] + ;
                        " - " + aDane[ 'opis_rej' ] + ", rodzaj dowodu: " + ;
                        iif( aFiltr[ 'rodzaj' ] == "*", 'wszystkie', ;
                        iif( aFiltr[ 'rodzaj' ] == "", "bez rodzaju", aFiltr[ 'rodzaj' ] ) ) + ;
                        ", oznaczenia: " + iif( Len( aFiltr[ 'opcje' ] ) == 0, "wszystkie", cRes ) + ;
                        ", procedura: " + iif( Len( aFiltr[ 'procedura' ] ) == 0, "wszystkie", gm_AStrTok( aFiltr[ 'procedura' ] ) ) )

                     oWorksheet:WriteText( 3, 0, "Data rejestru" )
                     oWorksheet:WriteText( 3, 1, "Data wystawienia" )
                     oWorksheet:WriteText( 3, 2, "Data sprzeda�y" )
                     oWorksheet:WriteText( 3, 3, "Rodzaj dokumentu" )
                     oWorksheet:WriteText( 3, 4, "Kolumny ksi�gi" )
                     oWorksheet:WriteText( 3, 5, "Nr dowodu" )
                     oWorksheet:WriteText( 3, 6, "Nazwa" )
                     oWorksheet:WriteText( 3, 7, "NIP" )
                     oWorksheet:WriteText( 3, 8, "Opis zdarzenia" )
                     oWorksheet:WriteText( 3, 9, "Symbol rejestru" )
                     oWorksheet:WriteText( 3, 10, "Og�lna warto�� " + iif( ewid_rss == 'B', "brutto", "netto" ) )
                     oWorksheet:WriteText( 3, 11, "Sprz. opodat. NETTO" )
                     oWorksheet:WriteText( 3, 12, "Sprz. opodat. VAT" )
                     oWorksheet:WriteText( 3, 13, "Sprz. zwolniona NETTO" )
                     oWorksheet:WriteText( 3, 14, "Razem rokekta NETTO" )
                     oWorksheet:WriteText( 3, 15, "Razem korekta VAT" )
                     oWorksheet:WriteText( 3, 16, "Uwagi" )
                     nWiersz := 4
                     AEval( aDane[ 'pozycje' ], { | aRow |
                        oWorksheet:WriteText( nWiersz, 0, aRow[ 'dzien' ] )
                        oWorksheet:WriteText( nWiersz, 1, aRow[ 'data_sprzedazy' ] )
                        oWorksheet:WriteText( nWiersz, 2, aRow[ 'datatran' ] )
                        oWorksheet:WriteText( nWiersz, 3, aRow[ 'rodzaj' ] )
                        oWorksheet:WriteText( nWiersz, 4, aRow[ 'kolumna' ] )
                        oWorksheet:WriteText( nWiersz, 5, aRow[ 'numer' ] )
                        oWorksheet:WriteText( nWiersz, 6, aRow[ 'nazwa' ] )
                        oWorksheet:WriteText( nWiersz, 7, aRow[ 'nr_ident' ] )
                        oWorksheet:WriteText( nWiersz, 8, aRow[ 'tresc' ] )
                        oWorksheet:WriteText( nWiersz, 9, aRow[ 'symb_rej' ] )
                        oWorksheet:WriteCurrency( nWiersz, 10, aRow[ 'wartosc_netto' ] + iif( ewid_rss == 'B', aRow[ 'wartosc_vat' ], 0 ) )
                        IF aRow[ 'netto_op' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 11, aRow[ 'netto_op' ] )
                        ENDIF
                        IF aRow[ 'wartosc_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 12, aRow[ 'wartosc_vat' ] )
                        ENDIF
                        IF aRow[ 'netto_zw' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 13, aRow[ 'netto_zw' ] )
                        ENDIF
                        IF aRow[ 'wartosc_netto' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 14, aRow[ 'wartosc_netto' ] )
                        ENDIF
                        IF aRow[ 'wartosc_vat' ] <> 0
                           oWorksheet:WriteCurrency( nWiersz, 15, aRow[ 'wartosc_vat' ] )
                        ENDIF
                        oWorksheet:WriteText( nWiersz, 16, aRow[ 'uwagi' ] )
                        nWiersz++
                     } )
                     IF oWorkbook:WriteToFile( cPlikWyj ) == 0
                        Komun( "Plik zosta� utworzony" )
                     ENDIF
                     EXIT
                  ENDSWITCH
               ENDIF
               oWorksheet := NIL
               oWorkbook := NIL
            ENDIF
         ELSE
            kom( 3, '*w', 'b r a k   d a n y c h' )
         ENDIF
         EXIT
      ENDSWITCH
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION RejVAT_Sp_Filtr()

   LOCAL aDane
   LOCAL cEkran
   LOCAL cKolor
   LOCAL cRodzDow := '*' + Space( 5 )
   LOCAL aGTU := {}
   LOCAL cUwzglFP := "T"
   LOCAL cSumujFP := "N"
   LOCAL nI

   LOCAL bRodzDowV := { | cWartosc |
      LOCAL lRes := AScan( { "RO", "WEW", "FP", "*", "" }, AllTrim( cWartosc ) ) > 0
      IF lRes
         @ 24, 0
      ENDIF
      RETURN lRes
   }
   LOCAL bRodzDowW := { ||
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY '* - wszystk, RO - Dok.z kas rej., WEW - Dok.wewn, FP - fa.do parag, puste - inne'
      SetColor( cKolor )
      RETURN .T.
   }

   PRIVATE zOpcje := Space( 32 )
   PRIVATE zProcedur := Space( 32 )

   SAVE SCREEN TO cEkran
   cKolor := ColStd()

   @  3, 42 CLEAR TO 22, 79
   @ 10, 42 TO 16, 79
   @  9, 54 SAY "-- Parametry --"
   @ 11, 43 SAY "      Rodzaj dowodu" GET cRodzDow PICTURE '!!!' WHEN Eval( bRodzDowW ) VALID Eval( bRodzDowV, cRodzDow )
   @ 12, 43 SAY "         Oznaczenie" GET zOpcje PICTURE '!!!!!!!!!!!!!!!!' WHEN KRejSWhOpcje()
   @ 13, 43 SAY "          Procedura" GET zProcedur PICTURE '!!!!!!!!!!!!!!!!' WHEN KRejSWhProcedur( .T. )
   @ 14, 43 SAY "Do��cz dokumenty FP" GET cUwzglFP PICTURE '!' VALID cUwzglFP $ 'NT'
   @ 15, 43 SAY " Sumuj dokumenty FP" GET cSumujFP PICTURE '!' WHEN cUwzglFP == "T" VALID cSumujFP $ 'NT'
   READ

   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   IF LastKey() == K_ESC
      RETURN NIL
   ENDIF

   aDane := hb_Hash()
   aDane[ 'rodzaj' ] := AllTrim( cRodzDow )
   aDane[ 'opcje' ] := iif( AllTrim( zOpcje ) <> "", hb_ATokens( AllTrim( zOpcje ), ',' ), {} )
   aDane[ 'procedura' ] := iif( AllTrim( zProcedur ) <> "", hb_ATokens( AllTrim( zProcedur ), ',' ), {} )
   aDane[ 'dolaczFP' ] := cUwzglFP == 'T'
   aDane[ 'sumujFP' ] := aDane[ 'dolaczFP' ] .AND. ( cSumujFP == 'T' )

   FOR nI := 1 TO Len( aDane[ 'procedura' ] )
      aDane[ 'procedura' ][ nI ] := AllTrim( aDane[ 'procedura' ][ nI ] )
   NEXT

   RETURN aDane

/*----------------------------------------------------------------------*/


