#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    224225.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 22.4 na 22.5
*****************************************************************************
FUNCTION Main()

   LOCAL aDane, cFirma, cSpolka
   PUBLIC param_rok

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   dbfInicjujDane()

   ? 'Tworzenie tablic...'
   dbfUtworzTabele( 'PRAC_HZ', 'prac_hz.dbf' )

   dbCloseAll()

   ? 'Aktualizacja struktur...'
   dbfUtworzTabele( 'TRESC', 'tresc.tym' )
   dbfImportujDaneTym('', 'TYM')

   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxTRESC()
   dbfIdxPRAC_HZ()

   dbCloseAll()

   RETURN

/*----------------------------------------------------------------------*/
