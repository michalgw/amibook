#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    173174.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 17.3 na 17.4
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   COPY FILE suma_mc.dbf TO suma_mc.173

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele('SUMA_MC', 'suma_mc.tym')
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   RETURN
