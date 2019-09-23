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
* Program dokonujacy wymiany wersji ksiegi 19.4 na 19.4c
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

   COPY FILE rejs.dbf TO bkp\rejs.194

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

   dbCloseAll()

   RETURN
