#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    192193.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 19.5 na 19.6
*****************************************************************************
FUNCTION Main()

   PUBLIC param_rok

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   IF ! File( 'vat7zd.dbf' )

      ? 'Aktualizacja struktury danych...'
      dbfInicjujDane()
      dbfUtworzTabele( 'VAT7ZD', 'vat7zd.dbf' )   
      dbCloseAll()

      ? 'Indeksowanie...'
      dbfIdxVAT7ZD()
      dbCloseAll()

   ENDIF

   RETURN
