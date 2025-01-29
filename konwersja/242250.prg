#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    242250.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 24.2b na 25.0
*****************************************************************************
FUNCTION Main()

   LOCAL aDane, cFirma, cSpolka
   PUBLIC wersja_db := 0

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   IF File( 'wersjadb.mem' )
      RESTORE FROM wersjadb ADDITIVE
   ENDIF

   dbfInicjujDane()

   IF wersja_db < 2430

      ? 'Aktualizacja struktury danych...'
      dbfUtworzTabele( 'UMOWY', 'umowy.tym' )
      dbfUtworzTabele( 'PROFIL', 'profil.tym' )
      dbfImportujDaneTym('', 'TYM')
      dbCloseAll()

      ? 'Indeksowanie...'
      dbfIdxUMOWY()
      dbCloseAll()

      wersja_db := 2430
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   IF wersja_db < 2431

      ? 'Indeksowanie...'
      dbfIdxPRAC()
      dbCloseAll()

      wersja_db := 2431
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/
