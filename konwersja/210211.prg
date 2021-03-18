#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    210211.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 21.0 na 21.1
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

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'EWID', 'ewid.tym' )
   dbfUtworzTabele( 'FAKTURY', 'faktury.tym' )
   dbfUtworzTabele( 'OPER', 'oper.tym' )
   dbfUtworzTabele( 'REJS', 'rejs.tym' )
   dbfUtworzTabele( 'REJZ', 'rejz.tym' )
   dbfUtworzTabele( 'ROZR', 'rozr.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxEWID()
   dbfIdxFAKTURY()
   dbfIdxOPER()
   dbfIdxREJS()
   dbfIdxREJZ()
   dbfIdxROZR()
   dbCloseAll()

   RETURN

FUNCTION DodajBackslash(cSciezka)
   cSciezka = AllTrim(cSciezka)
   IF Len(cSciezka) == 0
      RETURN cSciezka
   ENDIF
   IF SubStr(cSciezka, Len(cSciezka), 1) <> '\'
      cSciezka = cSciezka + '\'
   ENDIF
   RETURN cSciezka


/*----------------------------------------------------------------------*/
