#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    182183.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 18.2 na 18.3
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   IF ! hb_DirExists( "BKP" )
      MakeDir( ".\BKP" )
   ENDIF
   COPY FILE rejs.dbf TO bkp\rejs.190
   COPY FILE rejz.dbf TO bkp\rejz.190

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'REJS', 'rejs.tym' )
   dbfUtworzTabele( 'REJZ', 'rejz.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxREJS()
   dbfIdxREJZ()

   RETURN
