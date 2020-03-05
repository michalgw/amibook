#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
FUNCTION main(cKatalog, cKatDanych)
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )
   AltD(1)
   AltD()
   dbfInicjujDane()
   dbfUtworzWszystko(cKatalog, ".dbf", { | aTab, nAkt, nIlosc | QOut("Tworzenie tablicy: " + Str(nAkt) + "/" + Str(nIlosc) + "  " + aTab[2]) })
   importujDane(cKatalog, cKatDanych, "*.txt")
   dbfUtworzIndeksy({ | aTab, nAkt, nIlosc | QOut( "Tworzenie indeksu: " + Str(nAkt) + "/" + Str(nIlosc) + "  " + aTab[1] ) }, cKatalog)
   RETURN

FUNCTION DodajBackslash(cSciezka)
   cSciezka = AllTrim(cSciezka)
   IF Len(cSciezka) == 0
      RETURN cSciezka
   ENDIF
   IF SubStr(cSciezka, Len(cSciezka), 1) <> '\'
      cSciezka = cSciezka + '\'
   ENDIF
   RETURN cSciezka


/*----------------------------------------------------------------------*/

FUNCTION importujDane(cKatalog, cKatalogDanych, cRozszerzenie)
   LOCAL nI, aPliki, cFDir, cFName, cFExt, aStruct := {}, aPola := {}
   aPliki := Directory(DodajBackslash(cKatalogDanych) + "*" + cRozszerzenie)
   FOR nI := 1 TO Len(aPliki)
      hb_FNameSplit(aPliki[nI][1], @cFDir, @cFName, @cFExt)
      IF File(DodajBackslash(cKatalog) + cFName + ".dbf")
         ? "Importowanie danych: " + Str(nI) + "/" + Str(Len(aPliki)) + "   " + cFName
         USE (DodajBackslash(cKatalog) + cFName + ".dbf") EXCL
         aStruct := dbStruct()
         aPola := {}
         AEval(aStruct, {|aElement| IIF(aElement[2] <> "+", AAdd(aPola, aElement[1]), NIL) } )
         //APPEND FROM (DodajBackslash(cKatalogDanych) + aPliki[nI][1]) FIELDS aPola DELIMITED
         __dbDelim(.F., DodajBackslash(cKatalogDanych) + aPliki[nI][1], , aPola)
         USE
      ENDIF
   NEXT
   RETURN

/*----------------------------------------------------------------------*/

