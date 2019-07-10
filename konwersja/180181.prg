#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    180181.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 18.0 na 18.1
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   COPY FILE ewid.dbf TO ewid.180
   COPY FILE faktury.dbf TO faktury.180
   COPY FILE fakturyw.dbf TO fakturyw.180
   COPY FILE kontr.dbf TO kontr.180
   COPY FILE oper.dbf TO oper.180
   COPY FILE rejs.dbf TO rejs.180
   COPY FILE rejz.dbf TO rejz.180
   COPY FILE rozr.dbf TO rozr.180

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'EWID', 'ewid.tym' )
   dbfUtworzTabele( 'FAKTURY', 'faktury.tym' )
   dbfUtworzTabele( 'FAKTURYW', 'fakturyw.tym' )
   dbfUtworzTabele( 'KONTR', 'kontr.tym' )
   dbfUtworzTabele( 'OPER', 'oper.tym' )
   dbfUtworzTabele( 'REJS', 'rejs.tym' )
   dbfUtworzTabele( 'REJZ', 'rejz.tym' )
   dbfUtworzTabele( 'ROZR', 'rozr.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxEWID()
   dbfIdxFAKTURY()
   dbfIdxFAKTURYW()
   dbfIdxKONTR()
   dbfIdxOPER()
   dbfIdxREJS()
   dbfIdxREJZ()
   dbfIdxROZR()

   RETURN
