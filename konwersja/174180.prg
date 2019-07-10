#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    174180.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 17.4 na 18.0
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   altd()
   
   COPY FILE firma.dbf TO firma.174
   COPY FILE suma_mc.dbf TO suma_mc.174

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'FIRMA', 'firma.tym' )
   dbfUtworzTabele( 'SUMA_MC', 'suma_mc.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxFIRMA()
   dbfIdxOPER()
   dbfIdxEWID()
   dbfIdxREJS()
   dbfIdxREJZ()
   dbfIdxSUMA_MC()

   ? 'Aktualizacja danych...'

   Dostep( 'FIRMA' )

   dbEval( { ||
      firma->( dbRLock() )
      firma->rodznrks := "R"
      firma->( dbUnlock() )
      RETURN NIL
   } )
   dbCloseAll()

   RETURN
