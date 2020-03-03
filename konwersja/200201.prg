#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    200201.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 20.0 na 20.1
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
   IF ! File( 'kontrspr.dbf' )

      dbfUtworzTabele( 'KONTRSPR', 'kontrspr.dbf' )
      ? 'Indeksowanie...'
      dbCloseAll()
      dbfIdxKONTRSPR()
      dbCloseAll()

   ENDIF

   RETURN
