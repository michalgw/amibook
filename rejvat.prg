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

#include "inkey.ch"

FUNCTION RejVAT_Zak_Dane( cFirma, cMiesiac, cRodzaj, ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz, bFiltr, lWgVat, lTylkoUE )

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
      SET INDEX TO KAT_ZAK
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
      aDane[ 'rejestr' ] := '—RODKI TRWAE'
   CASE 'P' $ cRodzaj
      aDane[ 'rejestr' ] := 'POZOSTAE ZAKUPY'
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

      IF ! lTylkoUE .AND. ( rejz->sek_cv7 == 'WS' .OR. rejz->sek_cv7 == 'PS' )
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

         // zakup opodatkowany do sprzeda¾y opodatkowanej - warto˜† netto
         aRow[ 'zak_op_net' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
            + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'O', rejz->wart00, 0 )

         // zakup opodatkowany do sprzeda¾y opodatkowanej - warto˜† VAT
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

         // zakup opodatkowany do sprzeda¾y mieszanej - warto˜† netto
         aRow[ 'zak_mi_net' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
            + iif( rejz->sp00 $ cRodzaj .AND. rejz->zom00 == 'M', rejz->wart00, 0 )

         // zakup opodatkowany do sprzeda¾y mieszanej - warto˜† vat
         aRow[ 'zak_mi_vat' ] := iif( rejz->sp02 $ cRodzaj .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
            + iif( rejz->sp07 $ cRodzaj .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
            + iif( rejz->sp22 $ cRodzaj .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
            + iif( rejz->sp12 $ cRodzaj .AND. rejz->zom12 == 'M', rejz->vat12, 0 )

         // zakup opodatkowany do sprzeda¾y mieszanej - odlicz vat
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

         CASE rejz->sek_cv7 == 'IT'
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

         CASE rejz->sek_cv7 == 'IU'
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

      IF aRow[ 'wartosc_netto' ] <> 0 ;
         .AND. rejz->korekta == iif( ewid_rzk == 'N', 'N', iif( ewid_rzk == 'T', 'T', rejz->korekta ) ) ;
         .AND. iif( ewid_rzi <> '**', rejz->symb_rej == ewid_rzi, .T. ) ;
         .AND. iif( ! lTylkoUE, ( ewid_rzz$'NW' .OR. ( ewid_rzz == 'D' .AND. rejz->zaplata$'23' ) .OR. ( ewid_rzz == 'Z' .AND. rejz->zaplata == '1') ), .T. ) ;
         .AND. iif( cRodzaj == 'P', Eval( bFiltr ), .T. ) ;
         .AND. iif( lTylkoUE, AScan( { 'WT', 'WS', 'IT', 'IU', 'PN', 'PS' }, rejz->sek_cv7 ) > 0, .T. )

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
         aRow[ 'data_wystawienia' ] := StrTran( rejz->dziens, ' ', '0' ) + '.' + StrTran( rejz->mcs, ' ', '0' ) + '.' + rejz->roks
         aRow[ 'rodzaj' ] := iif( rejz->rach == 'F', 'Faktura', 'Rachunek' )
         aRow[ 'numer' ] := AllTrim( iif( Left( rejz->numer, 1 ) == Chr( 1 ) .OR. Left( rejz->numer, 1 ) == Chr( 254 ), SubStr( rejz->numer, 2 ), rejz->numer ) )
         aRow[ 'nazwa' ] := AllTrim( rejz->nazwa )
         aRow[ 'nr_ident' ] := AllTrim( rejz->nr_ident )
         aRow[ 'zakup_ue' ] := iif( rejz->ue == 'T', '1', '0' )
         aRow[ 'przedmiot' ] := AllTrim( rejz->tresc )
         aRow[ 'sekcja' ] := AllTrim( rejz->sek_cv7 )
         aRow[ 'kolumna' ] := AllTrim( rejz->kolumna )
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

   LOCAL nDruk, bFiltr
   LOCAL aDane, oRap, nMonDruk
   LOCAL aRodzaj := { 'S', 'P', 'SP', 'SP' }
   LOCAL aWgVat := { .F., .F., .T., .F. }
   LOCAL aTylkoUE := { .F., .F., .F., .T. }
   LOCAL aPlikiMem := { '', 'rejzpzze', 'rejzsze', 'rejszuep' }

   IF ( nDruk := MenuEx( 14, 2, { "T - Druk tekstowy", "P - Druk graficzny A4 (poziomo)" } ) ) > 0

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
            bFiltr := RejVAT_Zak_Filtr( aPlikiMem[ nRaport ] )
            IF HB_ISLOGICAL( bFiltr )
               RETURN NIL
            ENDIF
         ENDIF

         aDane := RejVAT_Zak_Dane( cFirma, cMiesiac, aRodzaj[ nRaport ], ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz, bFiltr, aWgVat[ nRaport ], aTylkoUE[ nRaport ] )
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

            oRap := TFreeReport():New()

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

            oRap := NIL

         ELSE

            kom( 3, '*w', 'b r a k   d a n y c h' )

         ENDIF
      ENDCASE

   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION RejVAT_Zak_Filtr( cMemFile )

   LOCAL bRes, cRes := '', cRes2 := ''
   LOCAL x, y
   LOCAL aRej := { '10', '11', '12', '13', '16', '  ' }
   LOCAL aRach := { 'R', 'F' }

   MEMVAR  xx, yy, qqs, qqr, qqss
   PRIVATE  xx, yy, qqs, qqr, qqss

   IF File( cMemFile + '.mem' )
      RESTORE FROM ( cMemFile ) ADDITIVE
   ELSE
      IF ! File( cMemFile + '.mem' )
         FOR x := 1 TO 10
            FOR y := 1 TO 8
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
   @  6, 42 SAY '                ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @  7, 42 SAY '                ³      WARIANTY       '
   @  8, 42 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @  9, 42 SAY ' KOLUMNY KSIEGI ³ 1 2 3 4 5 6 7 8 9 10'
   @ 10, 42 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @ 11, 42 SAY '10-Zakup towarow³                     '
   @ 12, 42 SAY '11-Koszty ubocz.³                     '
   @ 13, 42 SAY '12-Wynagr.w got.³                     '
   @ 14, 42 SAY '13-Pozostale wyd³                     '
   @ 15, 42 SAY '16-Koszty badaw.³                     '
   @ 16, 42 SAY '   NIEKSIEGOWANE³                     '
   @ 17, 42 SAY 'RACHUNKI (T/N) ?³                     '
   @ 18, 42 SAY 'FAKTURY  (T/N) ?³                     '
   @ 19, 42 SAY 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @ 20, 42 SAY Space( 38 )
   @ 21, 42 SAY Space( 38 )
   @ 22, 42 SAY Space( 38 )
   SET COLOR TO w+
   FOR x := 1 TO 10
      FOR y := 1 TO 8
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
         FOR y := 1 TO 8
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
         FOR y := 1 TO 8
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

   RETURN bRes

/*----------------------------------------------------------------------*/

FUNCTION RejVAT_Sp_Dane( nRaport, cFirma, cMiesiac, ewid_rss, ewid_rsk, ewid_rsi, ewid_rsz )

   LOCAL bKoniec := { || rejs->del#'+' .OR. rejs->firma#cFirma .OR. rejs->mc#cMiesiac }
   LOCAL cOpisRej := ''
   LOCAL lJest := .F.
   LOCAL aDane := hb_Hash()
   LOCAL aRow
   LOCAL nRekZak, cKluczStat, nFS, nZS, nLp := 1

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
      SET INDEX TO kat_spr
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

      aRow[ 'kolumna' ] := iif( rejs->kolumna == ' 0', '  ', rejs->kolumna )
      aRow[ 'rodzaj' ] := iif( rejs->rach == 'R', 'Rachunek', 'Faktura' )
      aRow[ 'numer' ] := AllTrim( iif( Left( rejs->numer, 1 ) == Chr( 1 ) .OR. Left( rejs->numer, 1 ) == Chr( 254 ), SubStr( rejs->numer, 2 ) + ' ', rejs->numer ) )
      aRow[ 'nazwa' ] := AllTrim( rejs->nazwa )
      aRow[ 'nr_ident' ] := AllTrim( rejs->nr_ident )
      aRow[ 'tresc' ] := AllTrim( rejs->tresc )
      aRow[ 'symb_rej' ] := AllTrim( rejs->symb_rej )
      aRow[ 'dzien' ] := StrTran( rejs->dzien, ' ', '0' ) + '.' + StrTran( cMiesiac, ' ', '0' )
      aRow[ 'data_sprzedazy' ] := StrTran( rejs->dziens, ' ', '0' ) + '.' + StrTran( rejs->mcs, ' ' , '0' ) + '.' + rejs->roks
      aRow[ 'korekta' ] := iif( rejs->korekta == 'T', '1', '0' )
      aRow[ 'uwagi' ] := AllTrim( rejs->uwagi )

      aRow[ 'netto_a' ] := rejs->wart22
      aRow[ 'vat_a' ] := rejs->vat22
      aRow[ 'netto_b' ] := rejs->wart07
      aRow[ 'vat_b' ] := rejs->vat07
      aRow[ 'netto_c' ] := rejs->wart02
      aRow[ 'vat_c' ] := rejs->vat02
      aRow[ 'netto_d' ] := rejs->wart12
      aRow[ 'vat_d' ] := rejs->vat12

      aRow[ 'netto_zr_kraj' ] := 0
      aRow[ 'netto_zr_eksp' ] := 0
      aRow[ 'netto_zr_wdt' ] := 0
      IF rejs->wart00 <> 0
         IF rejs->ue == 'T'
            aRow[ 'netto_zr_wdt' ] := rejs->wart00
         ENDIF
         IF rejs->ue <> 'T' .AND. rejs->export == 'T'
            aRow[ 'netto_zr_eksp' ] := rejs->wart00
         ENDIF
         IF rejs->ue <> 'T' .AND. rejs->export <> 'T'
            aRow[ 'netto_zr_kraj' ] := rejs->wart00
         ENDIF
      ENDIF

      aRow[ 'netto_zw' ] := rejs->wartzw
      aRow[ 'netto_np' ] := rejs->wart08

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

      IF rejs->sek_cv7 == 'PN' .OR. rejs->sek_cv7 =='PU'

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

      aRow[ 'wartosc_netto' ] := aRow[ 'netto_a' ] + aRow[ 'netto_b' ] + aRow[ 'netto_c' ] ;
         + aRow[ 'netto_d' ] + aRow[ 'netto_zr_wdt' ] + aRow[ 'netto_zr_eksp' ] ;
         + aRow[ 'netto_zr_kraj' ] + aRow[ 'netto_zw' ] + aRow[ 'netto_np' ]

      aRow[ 'wartosc_vat' ] := aRow[ 'vat_a' ] + aRow[ 'vat_b' ] + aRow[ 'vat_c' ] + aRow[ 'vat_d' ]

      aRow[ 'pn_wartosc_netto' ] := aRow[ 'pn_netto_a' ] + aRow[ 'pn_netto_b' ] + aRow[ 'pn_netto_c' ] ;
         + aRow[ 'pn_netto_d' ] + aRow[ 'pn_netto_zr_wdt' ] + aRow[ 'pn_netto_zr_eksp' ] ;
         + aRow[ 'pn_netto_zr_kraj' ] + aRow[ 'pn_netto_zw' ] + aRow[ 'pn_netto_np' ]

      aRow[ 'pn_wartosc_vat' ] := aRow[ 'pn_vat_a' ] + aRow[ 'pn_vat_b' ] + aRow[ 'pn_vat_c' ] + aRow[ 'pn_vat_d' ]

      aRow[ 'netto_op' ] := aRow[ 'netto_a' ] + aRow[ 'netto_b' ] + aRow[ 'netto_c' ] ;
         + aRow[ 'netto_d' ] + rejs->wart00

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
         .AND. ( ewid_rsz$'NW' .OR. ( ewid_rsz == 'D' .AND. ( nFS + nZS ) <> 0.0 ) .OR. ( ewid_rsz == 'Z' .AND. ( nFS + nZS ) == 0 ) )

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

   LOCAL aDane

   SAVE TO ewid ALL LIKE ewid_*
   ColStd()
   @ 24, 0

   IF ( nDruk := MenuEx( 14, 2, { "T - Druk tekstowy", "P - Druk graficzny A4 (poziomo)" } ) ) > 0
      SWITCH nDruk
      CASE 1

         SWITCH nRaport
         CASE 1
            rejs( ewid_rs1s, ewid_rs1k, ewid_rs1i, ewid_rs1z )
            EXIT
         CASE 2
            rejsKNEW( ewid_rs2s, ewid_rs2k, ewid_rs2i )
            EXIT
         ENDSWITCH

         EXIT
      CASE 2

         aDane := RejVAT_Sp_Dane( nRaport, cFirma, cMiesiac, ewid_rss, ewid_rsk, ewid_rsi, ewid_rzz )

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

            oRap := TFreeReport():New()

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

            oRap := NIL



         ELSE
            kom( 3, '*w', 'b r a k   d a n y c h' )
         ENDIF

         EXIT
      ENDSWITCH
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/


