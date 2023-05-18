#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    226230.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 22.6b na 23.0
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

   IF wersja_db < 2300

      ? 'Aktualizacja struktury danych...'
      dbfUtworzTabele( 'FIRMA', 'firma.tym' )
      dbfUtworzTabele( 'KONTR', 'kontr.tym' )
      dbfUtworzTabele( 'REJS', 'rejs.tym' )
      dbfUtworzTabele( 'REJZ', 'rejz.tym' )
      dbfUtworzTabele( 'TRESC', 'tresc.tym' )
      dbfUtworzTabele( 'KAT_ZAK', 'kat_zak.tym' )
      dbfUtworzTabele( 'KAT_SPR', 'kat_spr.tym' )
      dbfImportujDaneTym('', 'TYM')
      dbCloseAll()

      ? 'Indeksowanie...'
      dbfIdxFIRMA()
      dbfIdxKONTR()
      dbfIdxREJS()
      dbfIdxREJZ()
      dbfIdxTRESC()
      dbfIdxKAT_ZAK()
      dbfIdxKAT_SPR()
      dbCloseAll()

      wersja_db := 2300
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/
