#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    151152.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 15.1 na 15.2
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )
   dbfInicjujDane()
   dbfIdxEWID()
   dbfIdxOPER()
   RETURN