#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    145146.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 12.2 na 13.1
*****************************************************************************
* STACJA - stacja z ktorej odbywa sie instalacja a: lub b:
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )
   IF !File('edeklar.dbf')
      dbfInicjujDane()
      dbfUtworzTabele('EDEKLAR', 'edeklar.dbf')
      dbfIdxEDEKLAR()
   ENDIF
   RETURN