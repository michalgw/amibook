/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2026  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

#include "ami_book.ch"

PROCEDURE SumaMc_AktPozOgolnie( cMiesiac, lDodaj, nHANDEL, nWYR_TOW, ;
   nUSLUGI, nZAKUP, nUBOCZNE, nWYNAGR_G, nWYDATKI, nPUSTA, nRY20, nRY17, ;
   nRY10, nRYK07, nRYK08, nRYK09, nRYK10 )

   LOCAL nLicz := iif( lDodaj, 1, -1 )

   hb_default( @nHANDEL, 0 )
   hb_default( @nWYR_TOW, 0 )
   hb_default( @nUSLUGI, 0 )
   hb_default( @nZAKUP, 0 )
   hb_default( @nUBOCZNE, 0 )
   hb_default( @nWYNAGR_G, 0 )
   hb_default( @nWYDATKI, 0 )
   hb_default( @nPUSTA, 0 )
   hb_default( @nRY20, 0 )
   hb_default( @nRY17, 0 )
   hb_default( @nRY10, 0 )
   hb_default( @nRYK07, 0 )
   hb_default( @nRYK08, 0 )
   hb_default( @nRYK09, 0 )
   hb_default( @nRYK10, 0 )

   IF suma_mc->( dbSeek( '+' + ident_fir + cMiesiac ) )
      suma_mc->( BlokadaR() )
      suma_mc->handel := suma_mc->handel + nHANDEL * nLicz
      suma_mc->wyr_tow := suma_mc->wyr_tow + nWYR_TOW * nLicz
      suma_mc->uslugi := suma_mc->uslugi + nUSLUGI * nLicz
      suma_mc->zakup := suma_mc->zakup + nZAKUP * nLicz
      suma_mc->uboczne := suma_mc->uboczne + nUBOCZNE * nLicz
      suma_mc->wynagr_g := suma_mc->wynagr_g + nWYNAGR_G * nLicz
      suma_mc->wydatki := suma_mc->wydatki + nWYDATKI * nLicz
      suma_mc->pusta := suma_mc->pusta + nPUSTA * nLicz
      suma_mc->ry20 := suma_mc->ry20 + nRY20 * nLicz
      suma_mc->ry17 := suma_mc->ry17 + nRY17 * nLicz
      suma_mc->ry10 := suma_mc->ry10 + nRY10 * nLicz
      suma_mc->ryk07 := suma_mc->ryk07 + nRYK07 * nLicz
      suma_mc->ryk08 := suma_mc->ryk08 + nRYK08 * nLicz
      suma_mc->ryk09 := suma_mc->ryk09 + nRYK09 * nLicz
      suma_mc->ryk10 := suma_mc->ryk10 + nRYK10 * nLicz
      suma_mc->pozycje := suma_mc->pozycje + nLicz
      suma_mc->( dbUnlock() )
      suma_mc->( dbCommit() )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE SumaMc_AktPozK( cMiesiac, lDodaj, nK7, nK8, nK10, nK11, ;
   nK12, nK13, nK15 )

   SumaMc_AktPozOgolnie( cMiesiac, lDodaj, 0, nK7, nK8, nK10, nK11, nK12, ;
      nK13, nK15 )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE SumaMc_AktPozR( cMiesiac, lDodaj, nK5, nK6, nK7, nK8, ;
   nK9, nK10, nK11, nK12, nK13 )

   SumaMc_AktPozOgolnie( cMiesiac, lDodaj, 0, 0, nK8, 0, 0, 0, 0, 0, nK5, ;
      nK6, nK13, nK12, 0, nK7, nK9 )

   RETURN NIL

/*----------------------------------------------------------------------*/

**************************************************
PROCEDURE KontrApp()
**************************************************
   SELECT kontr
   IF ! Empty( znazwa ) .AND. param_aut == 'T'
      SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 ) + SubStr( zadres, 1, 15 )
      IF ! Found()
         app()
         REPLACE firma WITH ident_fir
         REPLACE nazwa WITH znazwa
         REPLACE adres WITH zadres
         REPLACE NR_IDENT WITH zNR_IDENT
         REPLACE EXPORT WITH zEXPORT
         REPLACE UE WITH zUE
         REPLACE KRAJ WITH zKRAJ
         COMMIT
         UNLOCK
      ENDIF
   ENDIF
   RETURN

*************************************
PROCEDURE WrocStan()
*************************************
   SELECT tresc
   IF ! ins
      SEEK '+' + ident_fir + tresc_
      IF Found()
         BlokadaR()
         STANUJ
         COMMIT
         UNLOCK
      ENDIF
   ENDIF
   RETURN

************************************
PROCEDURE IfIns( rrrec )
************************************
   IF ins
      app()
      ADDDOC
      IF rrrec > 0.0
         repl_( 'REC_NO', rrrec )
      ENDIF
   ENDIF
   RETURN

*************************************
PROCEDURE AktKol( mnoz, kolum, wart )
*************************************
   koko := Val( AllTrim( kolum ) )
   IF zRYCZALT == 'T'
      BlokadaR()
      DO CASE
      CASE KOKO == 5
         AKTPOL+ ry20 WITH wart * mnoz
      CASE KOKO == 6
         AKTPOL+ ry17 WITH wart * mnoz
      CASE KOKO == 7
         AKTPOL+ ryk09 WITH wart * mnoz
      CASE KOKO == 8
         AKTPOL+ uslugi WITH wart * mnoz
      CASE KOKO == 9
         AKTPOL+ ryk10 WITH wart * mnoz
      CASE KOKO == 10
         AKTPOL+ wyr_tow WITH wart * mnoz
      CASE KOKO == 11
         AKTPOL+ handel WITH wart * mnoz
      CASE KOKO == 12
         AKTPOL+ ryk07 WITH wart * mnoz
      CASE KOKO == 13
         AKTPOL+ ry10 WITH wart * mnoz
      ENDCASE
      COMMIT
      UNLOCK
   ELSE
      BlokadaR()
      DO CASE
      CASE KOKO == 7
         AKTPOL+ wyr_tow WITH wart * mnoz
      CASE KOKO == 8
         AKTPOL+ uslugi WITH wart * mnoz
      CASE KOKO == 10
         AKTPOL+ zakup WITH wart * mnoz
      CASE KOKO == 11
         AKTPOL+ uboczne WITH wart * mnoz
      CASE KOKO == 12
         AKTPOL+ wynagr_g WITH wart * mnoz
      CASE KOKO == 13 .OR. KOKO == 16
         AKTPOL+ wydatki WITH wart * mnoz
      ENDCASE
      COMMIT
      UNLOCK
   ENDIF
   RETURN

