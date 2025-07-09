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

#include "hbfr.ch"
#include "hblr.ch"
#include "hbcompat.ch"


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
   LOCAL aWyklucz := { 'FR_Dataset' }
   PRIVATE cAktKlucz
   aDane := hb_HKeys(hDane)
   AEval(aDane, {| cKlucz |
      IF .NOT. HB_ISHASH(hDane[cKlucz]) .AND. AScan( aWyklucz, cKlucz ) == 0
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
/*
   LOCAL nI

   FOR nI := 0 TO oRap:GetPageCount() - 1
      oRap:SetMargins( nI, nLewy, nPrawy, nGora, nDol )
   NEXT
*/
   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE FRDrukuj( cPlikFrp, aDane )

   LOCAL oRap, nMonDruk, cLPath, cLName, cLExt

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
      @ 24, 0
      RETURN
   ENDIF

   TRY
      oRap := FRUtworzRaport()
      IF hProfilUzytkownika[ 'typrap' ] == 'L'
         hb_FNameSplit( cPlikFrp, @cLPath, @cLName, @cLExt )
         IF File( hb_FNameMerge( cLPath, cLName, '.lrf' ) )
            cPlikFrp := hb_FNameMerge( cLPath, cLName, '.lrf' )
         ENDIF
      ENDIF
      oRap:LoadFromFile( cPlikFrp )

      IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
         oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
      ENDIF

      FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
         hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

      IF hb_HHasKey( aDane, 'FR_Dataset' )
         IF HB_ISARRAY( aDane[ 'FR_Dataset' ] )
            AEval( aDane[ 'FR_Dataset' ], { | cDataSet | oRap:AddDataset( cDataSet ) } )
         ELSEIF HB_ISCHAR( aDane[ 'FR_Dataset' ] )
            oRap:AddDataset( aDane[ 'FR_Dataset' ] )
         ENDIF
      ENDIF

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
   CATCH oErr
      Alert( "Wyst¥piˆ bˆ¥d podczas generowania wydruku;" + oErr:description )
   END

   oRap := NIL

   @ 24, 0

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION GraficznyCzyTekst( cIdentyfikator )

   LOCAL cKolor, nMenu

   cKolor := ColStd()

   IF param_zgt == 'T' .AND. ! Empty( cIdentyfikator )
      nMenu := GrafTekst_Wczytaj( ident_fir, cIdentyfikator, 1 )
   ENDIF

   @ 24, 0
   @ 24, 26 PROMPT '[ Graficzny ]'
   @ 24, 44 PROMPT '[ Tekstowy ]'
   CLEAR TYPE
   nMenu := Menu( nMenu )
   IF LastKey() = 27
      nMenu := 0
   ENDIF
   @ 24, 0
   SetColor(cKolor)

   IF param_zgt == 'T' .AND. nMenu > 0 .AND. ! Empty( cIdentyfikator )
      GrafTekst_Zapisz( ident_fir, cIdentyfikator, nMenu )
   ENDIF

   RETURN nMenu

/*----------------------------------------------------------------------*/

#define GRAFTEKSTDBF "graftekst.dbf"
#define GRAFTEKSTIDX "graftekst"
#define AMIHOMEDIR "AMi-BOOK\"

FUNCTION GrafTekst_Wczytaj( cFirma, cIdentyfikator, nWartoscDomyslna )

   LOCAL cUserDir := DodajBackslash( GetEnv( "LOCALAPPDATA" ) ) + AMIHOMEDIR
   LOCAL nWSpace, nResult

   hb_default( @nWartoscDomyslna, 1 )

   IF param_zgt <> 'T' .OR. ! IsDir( cUserDir ) .OR. ! File( cUserDir + GRAFTEKSTDBF )
      RETURN nWartoscDomyslna
   ENDIF

   nWSpace := Select()

   dbUseArea( .T., , cUserDir + GRAFTEKSTDBF, , .T., .T. )
   graftekst->( ordListAdd( cUserDir + GRAFTEKSTIDX ) )
   graftekst->( ordSetFocus( 1 ) )
   IF graftekst->( dbSeek( cFirma + cIdentyfikator ) )
      nResult := graftekst->wartosc
   ELSE
      nResult := nWartoscDomyslna
   ENDIF
   graftekst->( dbCloseArea() )

   Select( nWSpace )

   RETURN nResult

/*----------------------------------------------------------------------*/

PROCEDURE GrafTekst_Zapisz( cFirma, cIdentyfikator, nWartosc )

   LOCAL cUserDir := DodajBackslash( GetEnv( "LOCALAPPDATA" ) ) + AMIHOMEDIR
   LOCAL nWSpace := Select()

   IF param_zgt <> 'T' .OR. ! IsDir( cUserDir ) .AND. DirMake( cUserDir ) != 0
      RETURN
   ENDIF

   IF ! File( cUserDir + GRAFTEKSTDBF )
      dbCreate( cUserDir + GRAFTEKSTDBF, { { "FIRMA", "C", 3, 0 }, { "IDENT", "C", 64, 0 }, { "WARTOSC", "N", 6, 0 } } )
      dbUseArea( .T., , cUserDir + GRAFTEKSTDBF )
      graftekst->( dbCreateIndex( cUserDir + GRAFTEKSTIDX, "firma+ident", { || firma + ident } ) )
   ELSE
      dbUseArea( .T., , cUserDir + GRAFTEKSTDBF )
      graftekst->( ordListAdd( cUserDir + GRAFTEKSTIDX ) )
      graftekst->( ordSetFocus( 1 ) )
   ENDIF

   IF graftekst->( dbSeek( cFirma + cIdentyfikator ) )
      graftekst->( RLock() )
      graftekst->wartosc := nWartosc
      graftekst->( dbUnlock() )
   ELSE
      graftekst->( dbAppend() )
      graftekst->firma := cFirma
      graftekst->ident := cIdentyfikator
      graftekst->wartosc := nWartosc
   ENDIF
   graftekst->( dbCommit() )
   graftekst->( dbCloseArea() )

   Select( nWSpace )

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION FRInicjuj()

   LOCAL lRes

   IF hProfilUzytkownika[ 'typrap' ] == 'L'
      lRes := hblr_LoadLibrary( HBLR_LIB_NAME, HBLR_CE_CP852 )
   ELSE
      lRes := hbfr_LoadLibrary( HBFR_LIB_NAME, .T. )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION FRUtworzRaport( lComposite )

   LOCAL oRap

   IF hProfilUzytkownika[ 'typrap' ] == 'L'
      oRap := TLazReport():New( lComposite )
   ELSE
      oRap := TFreeReport():New( lComposite )
   ENDIF

   RETURN oRap

/*----------------------------------------------------------------------*/

