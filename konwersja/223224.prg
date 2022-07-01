#include "directry.ch"
#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST DBFCDX
***************************************************************************
*                    223224.PRG                                           *
***************************************************************************
* Program dokonujacy wymiany wersji ksiegi 22.3 na 22.4
*****************************************************************************
FUNCTION Main()

   LOCAL aDane
   PUBLIC param_rok

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )

   dbfInicjujDane()

   ? 'Tworzenie nowych tablic...'
   dbfUtworzTabele( 'TAB_PLA', 'tab_pla.dbf' )
   dbfUtworzTabele( 'TAB_DOCH', 'tab_doch.dbf' )
   dbCloseAll()

   dbfIdxTAB_PLA()
   dbfIdxTAB_DOCH()
   dbCloseAll()

   ? 'Aktualizacja danych...'

   aDane := { { 'dataod' => 0d20220101, 'odlicz' => 425.0, 'podatek' => 17.0, 'obnizzus' => .T., 'aktuks' => .T., 'aktpterm' => .T. }, ;
              { 'dataod' => 0d20220601, 'odlicz' => 300.0, 'podatek' => 12.0, 'obnizzus' => .T., 'aktuks' => .F., 'aktpterm' => .F. } }

   dbUseArea( .T., , 'tab_pla', , .F. )
   tab_pla->( dbSetIndex( 'tab_pla' ) )
   tab_pla->( dbGoTop() )
   AEval( aDane, { | aPoz |
      tab_pla->( dbAppend() )
      tab_pla->odlicz := aPoz[ 'odlicz' ]
      tab_pla->podatek := aPoz[ 'podatek' ]
      tab_pla->dataod := aPoz[ 'dataod' ]
      tab_pla->obnizzus := aPoz[ 'obnizzus' ]
      tab_pla->aktuks := aPoz[ 'aktuks' ]
      tab_pla->aktpterm := aPoz[ 'aktpterm' ]
      tab_pla->( dbCommit() )
   } )
   tab_pla->( dbCloseArea() )

   aDane := { ;
         { 'podstawa' => 0.0,       'procent' => 17, 'dataod' => 0d20220101, 'datado' => 0d20220531 }, ;
         { 'podstawa' => 120000.01, 'procent' => 32, 'dataod' => 0d20220101, 'datado' => 0d20220531 }, ;
         { 'podstawa' => 0.0,       'procent' => 12, 'dataod' => 0d20220601, 'datado' => CToD( '' ) }, ;
         { 'podstawa' => 120000.01, 'procent' => 32, 'dataod' => 0d20220601, 'datado' => CToD( '' ) } }

   dbUseArea( .T., , 'tab_doch', , .F. )
   tab_doch->( dbSetIndex( 'tab_doch' ) )
   tab_doch->( dbGoTop() )
   AEval( aDane, { | aPoz |
      tab_doch->( dbAppend() )
      tab_doch->podstawa := aPoz[ 'podstawa' ]
      tab_doch->procent := aPoz[ 'procent' ]
      tab_doch->dataod := aPoz[ 'dataod' ]
      tab_doch->datado := aPoz[ 'datado' ]
      tab_doch->( dbCommit() )
   } )
   tab_doch->( dbCloseArea() )

   IF File( 'param.mem' )
      RESTORE FROM param.mem ADDITIVE
      param_kw := 5100
      param_kwd := 0d20220601
      param_kw2 := 3600
      SAVE TO param.mem ALL LIKE param_*
   ENDIF

   dbUseArea( .T., , 'spolka', , .F. )
   spolka->( dbGoTop() )
   DO WHILE ! spolka->( Eof() )
      IF spolka->del == "+"
         spolka->( dbRLock() )
         spolka->param_kw := 5100
         spolka->param_kwd := 0d20220601
         spolka->param_kw2 := 3600
         spolka->( dbRUnlock() )
         spolka->( dbCommit() )
      ENDIF
      spolka->( dbSkip() )
   ENDDO
   spolka->( dbCloseArea() )

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
