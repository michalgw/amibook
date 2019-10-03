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
* Program dokonujacy wymiany wersji ksiegi 19.4 na 19.5
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

   COPY FILE rejs.dbf TO bkp\rejs.195
   COPY FILE etaty.dbf TO bkp\etaty.195
   COPY FILE tab_doch.dbf TO bkp\tab_doch.195
   COPY FILE umowy.dbf TO bkp\umowy.195
   COPY FILE spolka.dbf TO bkp\spolka.195

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele( 'UMOWY', 'umowy.tym' )
   dbfUtworzTabele( 'TAB_DOCH', 'tab_doch.tym' )
   dbfUtworzTabele( 'ETATY', 'etaty.tym' )
   dbfUtworzTabele( 'SPOLKA', 'spolka.tym' )
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Aktualizacja danych...'
   RESTORE FROM param ADDITIVE

   dbUseArea( .T., , 'rejs', , .F. )
   rejs->( dbGoTop() )
   DO WHILE ! rejs->( Eof() )
      IF Empty( rejs->datatran )
         rejs->datatran := hb_Date( Val( param_rok ), Val( rejs->mc ), Val( rejs->dzien ) )
      ENDIF
      rejs->( dbSkip() )
   ENDDO
   rejs->( dbCommit() )
   rejs->( dbCloseArea() )

   dbUseArea( .T., , 'rejz', , .F. )
   rejz->( dbGoTop() )
   DO WHILE ! rejz->( Eof() )
      IF Empty( rejz->datatran )
         rejz->datatran := hb_Date( Val( param_rok ), Val( rejz->mc ), Val( rejz->dzien ) )
      ENDIF
      rejz->( dbSkip() )
   ENDDO
   rejz->( dbCommit() )
   rejz->( dbCloseArea() )

   dbUseArea( .T., , 'spolka', , .F. )
   spolka->( dbGoTop() )
   DO WHILE ! spolka->( Eof() )
      spolka->param_kwd := d"2019-10-01"
      spolka->param_kw2 := 548.30
      spolka->( dbSkip() )
   ENDDO
   spolka->( dbCommit() )
   spolka->( dbCloseArea() )

   dbUseArea( .T., , 'etaty', , .F. )
   etaty->( dbGoTop() )
   DO WHILE ! etaty->( Eof() )
      etaty->staw_poda2 := etaty->staw_podat
      etaty->( dbSkip() )
   ENDDO
   etaty->( dbCommit() )
   etaty->( dbCloseArea() )

   dbUseArea( .T., , 'umowy', , .F. )
   umowy->( dbGoTop() )
   DO WHILE ! umowy->( Eof() )
      umowy->staw_poda2 := umowy->staw_podat
      umowy->( dbSkip() )
   ENDDO
   umowy->( dbCommit() )
   umowy->( dbCloseArea() )

   dbUseArea( .T., , 'tab_doch', , .F. )
   tab_doch->( dbGoTop() )
   DO WHILE ! tab_doch->( Eof() )
      tab_doch->procent2 := tab_doch->procent
      tab_doch->( dbSkip() )
   ENDDO
   tab_doch->( dbCommit() )
   tab_doch->( dbCloseArea() )

   dbCloseAll()

   ? 'Indeksowanie...'
   dbfIdxUMOWY()
   dbfIdxETATY()
   dbfIdxREJS()
   dbfIdxREJZ()
   dbfIdxTAB_DOCH()
   dbfIdxSPOLKA()
   dbCloseAll()

   RETURN
