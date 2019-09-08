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

   LOCAL aDaneTabDoch := { ;
      {      0.0, 17, 1188.00, .F.,     0.00,     0.0, d"2019-10-01" }, ;
      {   6601.0, 17, 1188.00, .T.,   631.98,  4400.0, d"2019-10-01" }, ;
      {  11001.0, 17,  556.02, .F.,     0.00,     0.0, d"2019-10-01" }, ;
      {  85529.0, 32,  556.02, .T.,   556.02, 41472.0, d"2019-10-01" }, ;
      { 127001.0, 32,    0.00, .F.,     0.00,     0.0, d"2019-10-01" } }

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
   COPY FILE tab_doch.dbf TO bkp\tab_doch.193

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'UMOWY', 'umowy.tym' )
   dbfUtworzTabele( 'REJS', 'rejs.tym' )
   dbfUtworzTabele( 'REJZ', 'rejz.tym' )
   dbfUtworzTabele( 'TAB_DOCH', 'tab_doch.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxUMOWY()
   dbfIdxETATY()
   dbfIdxREJS()
   dbfIdxREJZ()
   dbfIdxTAB_DOCH()
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

   dbUseArea( .T., , 'tab_doch', , .F. )
   tab_doch->( dbGoTop() )
   DO WHILE ! tab_doch->( Eof() )
      tab_doch->dataod := d"2018-01-01"
      tab_doch->datado := d"2019-09-30"
      tab_doch->( dbSkip() )
   ENDDO

   tab_doch->( dbSetIndex( 'tab_doch' ) )
   AEval( aDaneTabDoch, { | aRow |
      tab_doch->( dbAppend() )
      tab_doch->del := '+'
      tab_doch->podstawa := aRow[ 1 ]
      tab_doch->procent := aRow[ 2 ]
      tab_doch->kwotazmn := aRow[ 3 ]
      tab_doch->degres := aRow[ 4 ]
      tab_doch->kwotade1 := aRow[ 5 ]
      tab_doch->kwotade2 := aRow[ 6 ]
      tab_doch->dataod := aRow[ 7 ]
      tab_doch->( dbCommit() )
      RETURN NIL
   } )
   dbCloseAll()

   RETURN
