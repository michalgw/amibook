#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    170171.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 17.0 na 17.1
*****************************************************************************
FUNCTION Main()
   LOCAL nX, nY
   
   LOCAL aDaneTabDoch := { ;
      {      0.0, 18, 1188.00, .F.,     0.00,     0.0 }, ;
      {   6601.0, 18, 1188.00, .T.,   631.98,  4400.0 }, ;
      {  11001.0, 18,  556.02, .F.,     0.00,     0.0 }, ;
      {  85529.0, 32,  556.02, .T.,   556.02, 41472.0 }, ;
      { 127001.0, 32,    0.00, .F.,     0.00,     0.0 } }


   PUBLIC cN, cM
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   COPY FILE suma_mc.dbf TO suma_mc.171

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele('PROFIL', 'profil.tym')
   dbfUtworzTabele('SUMA_MC', 'suma_mc.tym')
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   IF File( "TAB_DOCH_OLD.DBF" ) .AND. File( "TAB_DOCH.DBF" )
      FErase( "TAB_DOCH.DBF" )
   ENDIF
   IF File( "TAB_DOCH.DBF" )
      FRename( "TAB_DOCH.DBF", "TAB_DOCH_DBF.OLD"  )
   ENDIF

   dbfUtworzTabele( 'TAB_DOCH', 'tab_doch.dbf' )
   dbfIdxTAB_DOCH()

   ? 'Aktualizacja danych...'
   
   dostep( 'profil' )
   profil->( dbGoTop() )
   do while ! profil->( eof() )
      profil->( dbRLock() )
      if profil->marginl == 0
         profil->marginl := 5
      endif
      if profil->marginp == 0
         profil->marginp := 5
      endif
      if profil->marging == 0
         profil->marging := 5
      endif
      if profil->margind == 0
         profil->margind := 15
      endif
      SKIP
   enddo
   
   profil->( dbCloseArea() )

   dostep( 'tab_doch' )
   set inde to tab_doch
   AEval( aDaneTabDoch, { | aRow |
      tab_doch->( dbAppend() )
      tab_doch->del := '+'
      tab_doch->podstawa := aRow[ 1 ]
      tab_doch->procent := aRow[ 2 ]
      tab_doch->kwotazmn := aRow[ 3 ]
      tab_doch->degres := aRow[ 4 ]
      tab_doch->kwotade1 := aRow[ 5 ]
      tab_doch->kwotade2 := aRow[ 6 ]
      tab_doch->( dbCommit() )
      RETURN NIL
   } )
   RETURN
