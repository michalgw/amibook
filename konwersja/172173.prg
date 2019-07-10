#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    172172.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 17.2 na 17.3
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   COPY FILE rejs.dbf TO rejs.172
   COPY FILE rejz.dbf TO rejz.172

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele('REJS', 'rejs.tym')
   dbfUtworzTabele('REJZ', 'rejz.tym')
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   RETURN
