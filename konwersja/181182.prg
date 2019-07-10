#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    181182.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 18.1 na 18.2
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
   COPY FILE rejz.dbf TO bkp\rejz.181
   COPY FILE rejs.dbf TO bkp\rejs.181
   COPY FILE suma_mc.dbf TO bkp\suma_mc.181

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'REJZ', 'rejz.tym' )
   dbfUtworzTabele( 'REJS', 'rejs.tym' )
   dbfUtworzTabele( 'SUMA_MC', 'suma_mc.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxREJZ()
   dbfIdxREJS()
   dbfIdxSUMA_MC()

   RETURN
