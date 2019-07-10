#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    153154.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 15.3 na 15.4
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
   dbfUtworzTabele('EDEKLAR', 'edeklar.tym')
   dbfImportujDaneTym('', 'TYM')
   dbUseArea( .T., , 'edeklar')
   dbGoTop()
   DO WHILE .NOT. Eof()
      blokadar('edeklar')
      edeklar->podpiscer := .T.
      edeklar->( dbCommit() )
      edeklar->( dbUnlock() )
      edeklar->( dbSkip() )
   ENDDO
   dbCloseAll()
   dbfIdxEDEKLAR()
   RETURN