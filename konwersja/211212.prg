#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    211212.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 21.1 na 21.2
*****************************************************************************
FUNCTION Main()

   PUBLIC param_rok

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   dbfInicjujDane()

   ? 'Tworzenie nowych tablic...'
   IF ! File( 'kasafisk.dbf' )
      dbfUtworzTabele( 'KASAFISK', 'kasafisk.dbf' )
      dbfIdxKASAFISK()
   ENDIF
   IF ! File( 'ewidzwr.dbf' )
      dbfUtworzTabele( 'EWIDZWR', 'ewidzwr.dbf' )
      dbfIdxEWIDZWR()
   ENDIF

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'UMOWY', 'umowy.tym' )
   dbfUtworzTabele( 'FIRMA', 'firma.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxUMOWY()
   dbfIdxFIRMA()
   dbCloseAll()

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
