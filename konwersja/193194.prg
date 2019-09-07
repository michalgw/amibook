#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    192193.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 19.3 na 19.4
*****************************************************************************
FUNCTION Main()

   PUBLIC param_rok

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   IF ! hb_DirExists( "BKP" )
      MakeDir( ".\BKP" )
   ENDIF
   COPY FILE umowy.dbf TO bkp\umowy.193
   COPY FILE rejs.dbf TO bkp\rejs.193
   COPY FILE rejz.dbf TO bkp\rejz.193

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'UMOWY', 'umowy.tym' )
   dbfUtworzTabele( 'REJS', 'rejs.tym' )
   dbfUtworzTabele( 'REJZ', 'rejz.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxUMOWY()
   dbfIdxETATY()
   dbfIdxREJS()
   dbfIdxREJZ()
   dbCloseAll()

   ? 'Aktualizacja danych...'
   RESTORE FROM param ADDITIVE

   dbUseArea( .T., , 'rejs', , .F. )
   rejs->( dbGoTop() )
   DO WHILE ! rejs->( Eof() )
      rejs->datatran := hb_Date( Val( param_rok ), Val( rejs->mc ), Val( rejs->dzien ) )
      rejs->( dbSkip() )
   ENDDO
   rejs->( dbCommit() )
   rejs->( dbCloseArea() )

   dbUseArea( .T., , 'rejz', , .F. )
   rejz->( dbGoTop() )
   DO WHILE ! rejz->( Eof() )
      rejz->datatran := hb_Date( Val( param_rok ), Val( rejz->mc ), Val( rejz->dzien ) )
      rejz->( dbSkip() )
   ENDDO
   rejz->( dbCommit() )
   rejz->( dbCloseArea() )

   dbCloseAll()

   RETURN
