#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    231240.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 23.1 na 24.0
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

   IF wersja_db < 2400

      ? 'Aktualizacja struktury danych...'
      dbfUtworzTabele( 'KARTST', 'kartst.tym' )
      dbfUtworzTabele( 'KAT_SPR', 'kat_spr.tym' )
      dbfUtworzTabele( 'KAT_ZAK', 'kat_zak.tym' )
      dbfUtworzTabele( 'TRESC', 'tresc.tym' )
      dbfImportujDaneTym('', 'TYM')
      dbCloseAll()

      ? 'Indeksowanie...'
      dbfIdxKARTST()
      dbfIdxKAT_SPR()
      dbfIdxKAT_ZAK()
      dbfIdxTRESC()
      dbCloseAll()

      wersja_db := 2400
      SAVE ALL LIKE wersja_db TO wersjadb

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/
