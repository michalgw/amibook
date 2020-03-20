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

FUNCTION DodajRaportDoListy(xRaport)
   AAdd(aListaRaportow, xRaport)
   RETURN Len(aListaRaportow)

/*----------------------------------------------------------------------*/

FUNCTION UsunRaportZListy(nIndeks)
   IF HB_ISARRAY(aListaRaportow[nIndeks])
      AEval(aListaRaportow[nIndeks], { | oRap | oRap := NIL } )
   ENDIF
   aListaRaportow[nIndeks] := NIL
   RETURN nIndeks

/*----------------------------------------------------------------------*/

FUNCTION RaportUstawDane(oRap, hDane)
   LOCAL nI, aDane
   PRIVATE cAktKlucz
   aDane := hb_HKeys(hDane)
   AEval(aDane, {| cKlucz |
      IF .NOT.HB_ISHASH(hDane[cKlucz])
         IF HB_ISARRAY(hDane[cKlucz])
            oRap:AddDataset(cKlucz)
            cAktKlucz := cKlucz
            AEval(hDane[cKlucz], {| hRekord |
               IF HB_ISHASH(hRekord)
                  oRap:AddRow(cAktKlucz, hRekord)
               ENDIF
            })
         ELSE
            oRap:AddValue(cKlucz, hDane[cKlucz])
         ENDIF
      ENDIF
   })
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION FRUstawMarginesy( oRap, nLewy, nPrawy, nGora, nDol )

   LOCAL nI

   FOR nI := 0 TO oRap:GetPageCount() - 1
      oRap:SetMargins( nI, nLewy, nPrawy, nGora, nDol )
   NEXT

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE FRDrukuj( cPlikFrp, aDane )

   LOCAL oRap, nMonDruk

   IF ! File( cPlikFrp )
      Komun( 'Brak pliku wydruku: ' + cPlikFrp )
      RETURN
   ENDIF

   @ 24, 0
   @ 24, 26 PROMPT '[ Monitor ]'
   @ 24, 44 PROMPT '[ Drukarka ]'
   IF trybSerwisowy
      @ 24, 70 PROMPT '[ Edytor ]'
   ENDIF
   CLEAR TYPE
   menu TO nMonDruk
   IF LastKey() == 27
      RETURN
   ENDIF

   oRap := TFreeReport():New()
   oRap:LoadFromFile( cPlikFrp )

   IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
      oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
   ENDIF

   FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
      hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

   RaportUstawDane( oRap, aDane )

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

   RETURN NIL

/*----------------------------------------------------------------------*/

