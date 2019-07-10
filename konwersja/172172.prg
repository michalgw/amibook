#include "directry.ch"
#require hbwin.ch
#include "hblang.ch" 
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    172172.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 17.2 na 17.2d
*****************************************************************************
FUNCTION Main()
   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT('PL')
   hb_cdpSelect('PL852')
   SetMode(25, 80)
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   COPY FILE spolka.dbf TO spolka.172
   COPY FILE suma_mc.dbf TO suma_mc.172

   ? 'Aktualizacja struktury danych...'
   dbfInicjujDane()
   dbfUtworzTabele('SPOLKA', 'spolka.tym')
   dbfUtworzTabele('SUMA_MC', 'suma_mc.tym')
   dbfImportujDaneTym('', 'TYM')
   dbCloseAll()

   ? 'Aktualizacja danych...'
   
   dostep( 'spolka' )
   spolka->( dbGoTop() )
   do while ! spolka->( eof() )
      IF spolka->oblkwwol == ' '
         spolka->( dbRLock() )
         spolka->oblkwwol := 'S'
         spolka->( dbUnlock() )
      ENDIF
      SKIP
   enddo
   
   spolka->( dbCloseArea() )

   RETURN
