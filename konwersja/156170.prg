#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    156160.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 15.6 na 17.0
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )
   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele('DRUKARKA', 'drukarka.tym')
   dbfImportujDaneTym('', 'TYM')
   dbUseArea( .T., , 'drukarka')
   dbGoTop()
   DO WHILE .NOT. Eof()
      blokadar('drukarka')
      drukarka->cpi10z := 10
	  drukarka->cpi10c := 1
      drukarka->cpi12z := 10
	  drukarka->cpi12c := 1
      drukarka->cpi17z := 10
	  drukarka->cpi17c := 1
      drukarka->lpi6l := 6
	  drukarka->lpi6z := 11
	  drukarka->lpi8l := 8
	  drukarka->lpi8z := 8
      drukarka->( dbCommit() )
      drukarka->( dbUnlock() )
      drukarka->( dbSkip() )
   ENDDO
   dbCloseAll()
   RETURN