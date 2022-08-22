#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    225225b.PRG                                          *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 22.5 na 22.5b
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

   ? 'Aktualizacja struktur...'
   dbfUtworzTabele( 'FAKTURY', 'faktury.tym' )
   dbfImportujDaneTym('', 'TYM')

   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxFAKTURY()

   dbCloseAll()

   RETURN

/*----------------------------------------------------------------------*/
