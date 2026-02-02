#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    253260.PRG                                          *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 25.3 na 26.0
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

   IF wersja_db < 2600

      ? 'Aktualizacja struktury danych...'
      dbfUtworzTabele( 'EWID', 'ewid.tym' )
      dbfUtworzTabele( 'OPER', 'oper.tym' )
      dbfUtworzTabele( 'REJS', 'rejs.tym' )
      dbfUtworzTabele( 'REJZ', 'rejz.tym' )
      dbfImportujDaneTym('', 'TYM')
      dbCloseAll()

      ? 'Indeksowanie...'
      dbfIdxEWID()
      dbfIdxOPER()
      dbfIdxREJS()
      dbfIdxREJZ()
      dbCloseAll()

      wersja_db := 2600
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/
