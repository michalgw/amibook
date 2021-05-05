/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaˆ Gawrycki (gmsystems.pl)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

************************************************************************/

#include "Box.ch"
#include "hbgtinfo.ch"
#include "dbstruct.ch"
#include "memoedit.ch"
#include "hbwin.ch"
#include "inkey.ch"
#include "tbrowse.ch"
#include "button.ch"

STATIC cZablokowanyEkranEkran := ''
STATIC cZablokowanyEkranKolor := ''

/*----------------------------------------------------------------------*/

FUNCTION normalizujNazwe(anazwa)
   LOCAL res, i, srcch, dstch, cDopuszczalne, res2
   srcch = '¤¨ãà—½¥†©ˆä¢˜«¾ .'
   dstch = 'ACELNOSZZacelnoszz__'
   cDopuszczalne = 'QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm01234567890-_'
   res = anazwa
   FOR i = 1 TO Len(srcch)
      res = StrTran(res, SubStr(srcch, i, 1), SubStr(dstch, i, 1))
   NEXT
   res2 := ''
   FOR i := 1 TO Len( res )
      IF At( SubStr( res, i, 1 ), cDopuszczalne ) > 0
         res2 := res2 + SubStr( res, i, 1 )
      ELSE
         res2 := res2 + '_'
      ENDIF
   NEXT
   RETURN res2

/*----------------------------------------------------------------------*/

FUNCTION oknoKomunikat(cTytul, cTresc)
   LOCAL xScr
   SAVE SCREEN TO xScr

   @ 3, 3, 22, 76 BOX HB_B_SINGLE_UNI + Space(1)


   RESTORE SCREEN FROM xScr
   RETURN

/*----------------------------------------------------------------------*/



FUNCTION FilePath( cFile )
   LOCAL nPos, cFilePath
   IF (nPos := RAT("\", cFile)) != 0
      cFilePath = SUBSTR(cFile, 1, nPos)
   ELSE
      cFilePath = ""
   ENDIF
   RETURN cFilePath

/*----------------------------------------------------------------------*/

function IsDir( cDir )
   return ( !file( cDir ) .and. file( cDir + "\nul" ) )

/*----------------------------------------------------------------------*/

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

FUNCTION wersja2str(nWersja)
   LOCAL n1, n2, n3, cWer := PadL(AllTrim(Str(nWersja)), 6)
   n1 := Val(SubStr(cWer, 1, 2))
   n2 := Val(SubStr(cWer, 3, 2))
   n3 := Val(SubStr(cWer, 5, 2))
   RETURN AllTrim(Str(n1)) + "." + AllTrim(Str(n2)) + iif(n3 > 0, Chr(n3 + Asc("a") - 1), "")

/*----------------------------------------------------------------------*/

FUNCTION DostepPro(cTablica, cIndeks, lDzielony, cAlias, cAmiIndeks)
   LOCAL lRes
   hb_default(@lDzielony, .T.)
   DO WHILE .T.
      dbUseArea(.T., , cTablica, cAlias, lDzielony)
      IF .NOT. NetErr()
         IF !Empty(cIndeks)
            dbSetIndex(cIndeks)
         ENDIF
         IF !Empty( cAmiIndeks )
            SetInd( cAmiIndeks )
         ENDIF
         lRes := .T.
         EXIT
      ENDIF
      komun('Prosz© czeka† na dost©p do zbioru ' + cTablica)
      IF LastKey() == 27
         lRes := .F.
         EXIT
      ENDIF
   ENDDO
   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION WczytajRekordDoHash(cAlias)
   LOCAL hRes := hb_hash(), nI, aStruc
   IF !Empty(cAlias)
      dbSelectArea(cAlias)
   ENDIF
   //AEval(dbStruct(), { | aField | aRes[Lower(aField[DBS_NAME])] := &aField[DBS_NAME] })
   aStruc := dbStruct()
   FOR nI := 1 TO Len(aStruc)
      hRes[Lower(aStruc[nI, DBS_NAME])] := FieldGet(nI)
   NEXT
   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION PobierzUrzad(nUrzadRecNo)
   LOCAL hRes := hb_Hash()
   IF DostepPro('URZEDY')
      urzedy->(dbGoto(nUrzadRecNo))
      hRes := WczytajRekordDoHash()
      hRes['OK'] := .T.
      urzedy->(dbCloseArea())
   ELSE
      hRes['OK'] := .F.
   ENDIF
   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION PobierzFirme( nFirmaRecNo )

   LOCAL hRes := hb_hash()
   LOCAL nArea := Select()

   IF DostepPro( 'FIRMA' )
      firma->( dbGoto( nFirmaRecNo ) )
      hRes[ 'firma' ] := WczytajRekordDoHash()
      IF ! firma->spolka
         IF DostepPro( 'SPOLKA', 'SPOLKA' )
            IF ( spolka->( dbSeek( '+' + Str( nFirmaRecNo, 3 ) + firma->nazwisko ) ) )
               hRes[ 'spolka' ] := WczytajRekordDoHash()
               hRes[ 'spolka' ][ 'OK' ] := .T.
            ELSE
               kom( 5, '*u', ' Prosz© wpisa† wˆa˜cicieli firmy w odpowiedniej opcji ' )
               hRes[ 'spolka' ] := hb_Hash()
               hRes[ 'spolka' ][ 'OK' ] := .F.
            ENDIF
            spolka->( dbCloseArea() )
         ELSE
            hRes[ 'spolka' ] := hb_Hash()
            hRes[ 'spolka' ][ 'OK' ] := .F.
         ENDIF
      ENDIF
      hRes[ 'firma' ][ 'OK' ] := .T.
      firma->( dbCloseArea() )
   ELSE
      hRes[ 'firma' ] := hb_Hash()
      hRes[ 'firma' ][ 'OK' ] := .F.
   ENDIF

   Select( nArea )

   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION WczytajParamIni()
   LOCAL aIni := hb_Hash()
   IF File('amibook.ini')
      aIni := hb_iniRead('amibook.ini')
      IF hb_HHasKey(aIni, 'opcje')
         IF hb_HHasKey(aIni['opcje'], 'wersja4')
            IF aIni['opcje']['wersja4'] == 't'
               WERSJA4 := .T.
            ELSE
               WERSJA4 := .F.
            ENDIF
         ENDIF
      ENDIF
   ENDIF
   RETURN

/*----------------------------------------------------------------------*/



FUNCTION ObliczKwartal(nMiesiac)
   LOCAL hRes := hb_Hash("kwapocz", 1, "kwakon", 3, "kwarta", 1)
   DO CASE
      CASE nMiesiac >= 4 .AND. nMiesiac <= 6
         hRes['kwapocz'] := 4
         hRes['kwakon'] := 6
         hRes['kwarta'] := 2
      CASE nMiesiac >= 7 .AND. nMiesiac <= 9
         hRes['kwapocz'] := 7
         hRes['kwakon'] := 9
         hRes['kwarta'] := 3
      CASE nMiesiac >= 10 .AND. nMiesiac <= 12
         hRes['kwapocz'] := 10
         hRes['kwakon'] := 12
         hRes['kwarta'] := 4
   ENDCASE
   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION dbIlosc(cTablica)
   LOCAL nAktRekord, nIlosc := 0
   nAktRekord := (cTablica)->(RecNo())
   (cTablica)->(dbEval({|| nIlosc++  }))
   (cTablica)->(dbGoto(nAktRekord))
   RETURN nIlosc

/*----------------------------------------------------------------------*/

FUNCTION ZablokujEkran(cKomunikat)
   hb_default(@cKomunikat, '')
   SAVE SCREEN TO cZablokowanyEkranEkran
   cZablokowanyEkranKolor := SetColor('W/N, N/W, N, N, N/W')
   CLEAR SCREEN
   @ 12, 0 SAY PadC(cKomunikat, 80)
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION OdblokujEkran()
   DO WHILE Inkey() <> 0
      CLEAR TYPEAHEAD
   ENDDO
   hb_keyClear()
   hb_keyClear()
   RESTORE SCREEN FROM cZablokowanyEkranEkran
   SetColor(cZablokowanyEkranKolor)
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION Komunikat( cTresc, cKolor )

   LOCAL nRes := 2

   DO WHILE nRes == 2
      nRes := Alert( cTresc, { 'Zamknij', 'Kopiuj komunikat do schowka' }, cKolor )
      IF nRes == 2
         hb_gtInfo( HB_GTI_CLIPBOARDDATA, rezultat )
         komun( 'Komunikat zostaˆ skopiowany do schowka.', 5 )
      ENDIF
   ENDDO

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION WyswietlTekst( cTekst, nTop, nBottom, cTytul )

   LOCAL cScr
   PRIVATE cWyswietlTekstTekst := cTekst
   PRIVATE cTytulWydruku := cTytul

   hb_default( @nTop, 3 )
   hb_default( @nBottom, 22 )

   SAVE SCREEN TO cScr

   @ nTop, 0 CLEAR TO nBottom, 79
   @ nTop, 0, nBottom - 1, 79 BOX B_SINGLE
   @ nBottom, 0 SAY 'Esc - zamknij | D - drukuj | C - kopiuj do schowka | Z - zapisz | ' + Chr( 24 ) + '/' + Chr( 25 ) + ' - przewiä'

   MemoEdit( cTekst, nTop + 1, 1, nBottom - 2, 78, .F., 'WyswietlTekstUserFunc' )

   RESTORE SCREEN FROM cScr

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION WyswietlTekstUserFunc( nMode, nRow, nCol )

   LOCAL nKey := LastKey()
   LOCAL nRet := ME_DEFAULT
   LOCAL cNazwaPliku

   DO CASE
   CASE nMode == ME_UNKEY .OR. nMode == ME_UNKEYX
      DO CASE
      CASE nKey == Asc( 'C' ) .OR. nKey == Asc( 'c' )
         hb_gtInfo( HB_GTI_CLIPBOARDDATA, cWyswietlTekstTekst )
         Komun( 'Komunikat zostaˆ skopiowany do schowka.', 5 )

      CASE nKey == Asc( 'D' ) .OR. nKey == Asc( 'd' )
         WydrukProsty( cWyswietlTekstTekst, cTytulWydruku )

      CASE nKey == Asc( 'Z' ) .OR. nKey == Asc( 'z' )
         cNazwaPliku := AllTrim( win_GetSaveFileName() )
         IF Len( cNazwaPliku ) > 0
            MemoWrit( cNazwaPliku, cWyswietlTekstTekst )
         ENDIF
      ENDCASE
   ENDCASE

   RETURN nRet

/*----------------------------------------------------------------------*/

FUNCTION WyswietlPomoc(aPomoc)
   LOCAL cScr, nI, nY, cColor
   SAVE SCREEN TO cScr
   cColor := ColInf()
   FOR nI := Len(aPomoc) TO 1 STEP -1
      center(24 - Len(aPomoc) + nI, aPomoc[nI])
   NEXT
   pause(0)
   if lastkey()#27.and.lastkey()#28
      keyboard chr(lastkey())
   endif
   SetColor(cColor)
   RESTORE SCREEN FROM cScr
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION scr2html(cScr, nWidth, cTitle)
   LOCAL cHtml := ;
      '<html><head><meta charset="UTF-8"><title>' + cTitle + '</title>' + ;
      '<style>.fg0 { color: #000000; } .fg1 { color: #800000; } .fg2 { color: #008000; } .fg3 { color: #808000; } .fg4 { color: #000080; } .fg5 { color: #800080; } ' + ;
      '.fg6 { color: #008080; } .fg7 { color: #c0c0c0; } .fg8 { color: #808080; } .fg9 { color: #ff0000; } .fg10 { color: #00ff00; } .fg11 { color: #ffff00; } ' + ;
      '.fg12 { color: #0000ff; } .fg13 { color: #ff00ff; } .fg14 { color: #00ffff; } .fg15 { color: #ffffff; } .bg0 { background-color: #000000; } ' + ;
      '.bg1 { background-color: #800000; } .bg2 { background-color: #008000; } .bg3 { background-color: #808000; } .bg4 { background-color: #000080; } ' + ;
      '.bg5 { background-color: #800080; } .bg6 { background-color: #008080; } .bg7 { background-color: #c0c0c0; } .bg8 { background-color: #808080; } ' + ;
      '.bg9 { background-color: #ff0000; } .bg10 { background-color: #00ff00; } .bg11 { background-color: #ffff00; } .bg12 { background-color: #0000ff; } ' + ;
      '.bg13 { background-color: #ff00ff; } .bg14 { background-color: #00ffff; } .bg15 { background-color: #ffffff; } body { font-family: Consolas,"courier new"; }</style></head><body>'
   LOCAL nI, nFG, nBG, cChar, nLFG := Chr(0), nLBG := 0
   FOR nI := 1 TO Len(cScr) STEP 2
      cChar := hb_StrToUTF8(SubStr(cScr, nI, 1))
      IF cChar == ' '
         cChar := '&nbsp;'
      ENDIF
      nFG := ft_ByteAnd(SubStr(cScr, nI + 1, 1), hb_BChar(0xf))
      nBG := hb_bitShift(Asc(ft_byteand(SubStr(cScr, nI + 1, 1), hb_BChar(0xf0))), -4)
      IF nFG <> nLFG .OR. nBG <> nLBG
         IF nI > 1
            cHtml := cHtml + '</span>'
         ENDIF
         cHtml := cHtml + '<span class="fg' + AllTrim(Str(Asc(nFG))) + ' bg' + AllTrim(Str(nBG)) + '" >'
      ENDIF
      nLFG := nFG
      nLBG := nBG
      cHtml := cHtml + cChar
      IF Mod(nI + 1, nWidth * 2) == 0
         cHtml := cHtml + '<br>'
      ENDIF
   NEXT
   cHtml := cHtml + '</span></body></html>'
   RETURN cHtml

/*----------------------------------------------------------------------*/

FUNCTION EwidSprawdzNrDokRec( cTablica, cKontrahent, cMiesiac, cNumer, aRec )

   LOCAL lRes := .F.
   LOCAL nPopArea

   nPopArea := Select()

   SWITCH Upper( cTablica )
   CASE 'REJS'
      dbUseArea(.T., , 'REJS', 'TMPESND', .T., .T.)
      dbSetIndex('rejs2')
      EXIT
   CASE 'REJZ'
      dbUseArea(.T., , 'REJZ', 'TMPESND', .T., .T.)
      dbSetIndex('rejz2')
      EXIT
   CASE 'OPER'
      dbUseArea(.T., , 'OPER', 'TMPESND', .T., .T.)
      dbSetIndex('oper2')
      EXIT
   CASE 'EWID'
      dbUseArea(.T., , 'EWID', 'TMPESND', .T., .T.)
      dbSetIndex('ewid2')
      EXIT
   ENDSWITCH

   IF ( lRes := dbSeek( '+' + cKontrahent + cMiesiac + PadR( cNumer, 20 ) ) )
      aRec := WczytajRekordDoHash()
   ENDIF

   dbCloseArea()
   Select( nPopArea )

   RETURN lRes

/*----------------------------------------------------------------------*/

PROCEDURE EwidSprawdzNrDok(cTablica, cKontrahent, cMiesiac, cNumer, nRecNo)

   LOCAL nWS, nPopArea, nM, nMS, aLista := {}, cKom

   IF ! ( param_ksnd $ 'TR' )
      RETURN
   ENDIF

   IF AllTrim(cNumer) == ''
      RETURN
   ENDIF

   nPopArea := Select()

   SWITCH Upper(cTablica)
   CASE 'REJS'
      dbUseArea(.T., , 'REJS', 'TMPESND', .T., .T.)
      dbSetIndex('rejs2')
      EXIT
   CASE 'REJZ'
      dbUseArea(.T., , 'REJZ', 'TMPESND', .T., .T.)
      dbSetIndex('rejz2')
      EXIT
   CASE 'OPER'
      dbUseArea(.T., , 'OPER', 'TMPESND', .T., .T.)
      dbSetIndex('oper2')
      EXIT
   CASE 'EWID'
      dbUseArea(.T., , 'EWID', 'TMPESND', .T., .T.)
      dbSetIndex('ewid2')
      EXIT
   ENDSWITCH

   nWS := Select()
   IF nWS == nPopArea
      RETURN
   ENDIF

   IF param_ksnd == 'R'
      nMS := 1
   ELSE
      nMS := Val( cMiesiac )
   ENDIF

   FOR nM := nMS TO Val( cMiesiac )
      IF dbSeek('+' + cKontrahent + Str( nM, 2 ) + PadR(cNumer, 20))
         DO WHILE AllTrim( cNumer ) == AllTrim( numer ) .AND. cKontrahent == firma .AND. mc == Str( nM, 2 )
            IF Empty( nRecNo ) .OR. nRecNo <> RecNo()
               AAdd( aLista, { ;
                  'recno' => RecNo(), ;
                  'nip' => AllTrim( nr_ident ), ;
                  'nazwa' => AllTrim( nazwa ), ;
                  'data' => hb_Date( Val( param_rok ), Val( mc ), Val( dzien ) ) } )
            ENDIF
            dbSkip()
         ENDDO
      ENDIF
   NEXT

   dbCloseArea()
   Select(nPopArea)

   IF Len( aLista ) > 0
      cKom := "Dokument o podanym numerze ju¾ istnieje w bazie;"
      FOR nM := 1 TO Len( aLista )
         cKom := cKom + ";Data: " + DToC( aLista[ nM ][ 'data' ] ) + ;
            ", NIP: " + aLista[ nM ][ 'nip' ] + ;
            ", Kontrahent: " + SubStr( aLista[ nM ][ 'nazwa' ], 1, 30 )
      NEXT
      Komunikat( cKom, CColInf )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE ADodajNieZero( aTablica, cPole, nElement, cPole2 )
   IF HB_ISHASH( aTablica )
      IF ( ValType( nElement ) == 'N' ) .AND. ( nElement <> 0 )
         aTablica[ cPole ] := nElement
         IF HB_ISCHAR( cPole2 ) .AND. ! hb_HHasKey( aTablica, cPole2 )
            aTablica[ cPole2 ] := 0
         ENDIF
      ENDIF
   ENDIF
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION MenuEx( nTop, nLeft, aItems, nSelected, lSaveScr )
   LOCAL cScr
   LOCAL nMaxWidth := 0
   LOCAL nI
   LOCAL nRes
   LOCAL cKolor

   hb_default( @lSaveScr, .T. )

   AEval( aItems, { | cItem | nMaxWidth := Max( nMaxWidth, Len( cItem ) ) } )

   IF nTop + Len( aItems ) + 2 > MaxRow()
      nTop := MaxRow() - 2 - Len( aItems )
   ENDIF

   IF nLeft + 4 + nMaxWidth > MaxCol()
      nLeft := MaxCol() - 4 - nMaxWidth
   ENDIF

   IF lSaveScr
      SAVE SCREEN TO cScr
   ENDIF

   cKolor := ColPro()
   @ nTop, nLeft TO nTop + 1 + Len( aItems ), nLeft + 3 + nMaxWidth
   FOR nI := 1 TO Len( aItems )
      @ nTop + nI, nLeft + 1 PROMPT ' ' + PadR( aItems[ nI ], nMaxWidth + 1 )
   NEXT
   nRes := menu( nSelected )
   IF LastKey() == K_ESC
      nRes := 0
   ENDIF

   IF lSaveScr
      RESTORE SCREEN FROM cScr
   ENDIF

   SetColor( cKolor )

   RETURN nRes

/*----------------------------------------------------------------------*/

#define KEY_ELEM 1
#define BLK_ELEM 2

// ANYTYPE[]   ar        - Array to browse
// NUMERIC     nElem     - Element In Array
// CHARACTER[] aHeadings - Array of Headings for each column
// BLOCK[]     aBlocks   - Array containing code block for each column.
// CODE BLOCK  bGetFunc  - Code Block For Special Get Processing
//  NOTE: When evaluated a code block is passed the array element to
//          be edited
// aCustomKeys { nKey, bBlock }
FUNCTION GM_ArEdit( nTop, nLeft, nBot, nRight, ;
      ar, nElem, aHeadings, aBlocks, bGetFunc, bInsertFunc, bDeleteFunc, aCustomKeys, ;
      cColorSpec, aColorBlocks, aFooters )

   LOCAL exit_requested, nKey, meth_no
   LOCAL cSaveWin, i, b, column
   LOCAL nDim, cType, cVal
   LOCAL oHSBar, oVSBar
   LOCAL bMButton := { | b |
      IF b:hitTest( MRow(), MCol() ) == HTCELL
         b:colPos := b:mColPos
         b:rowPos := b:mRowPos
         b:invalidate()
      ENDIF
      SWITCH oHSBar:HitTest( MRow(), MCol() )
         CASE HTSCROLLUNITDEC
         CASE HTSCROLLBLOCKDEC
            b:Left()
            EXIT
         CASE HTSCROLLUNITINC
         CASE HTSCROLLBLOCKINC
            b:Right()
            EXIT
      ENDSWITCH
      SWITCH oVSBar:HitTest( MRow(), MCol() )
         CASE HTSCROLLUNITDEC
            b:Up()
            EXIT
         CASE HTSCROLLUNITINC
            b:Down()
            EXIT
         CASE HTSCROLLBLOCKDEC
            b:PageUp()
            EXIT
         CASE HTSCROLLBLOCKINC
            b:PageDown()
            EXIT
      ENDSWITCH
   }
   LOCAL tb_methods := ;
      { ;
      { K_DOWN,        { | b | b:down() } }, ;
      { K_UP,          { | b | b:up() } }, ;
      { K_PGDN,        { | b | b:pagedown() } }, ;
      { K_PGUP,        { | b | b:pageup() } }, ;
      { K_CTRL_PGUP,   { | b | b:gotop() } }, ;
      { K_CTRL_PGDN,   { | b | b:gobottom() } }, ;
      { K_RIGHT,       { | b | b:Right() } }, ;
      { K_LEFT,        { | b | b:Left() } }, ;
      { K_HOME,        { | b | b:home() } }, ;
      { K_END,         { | b | b:end() } }, ;
      { K_CTRL_LEFT,   { | b | b:panleft() } }, ;
      { K_CTRL_RIGHT,  { | b | b:panright() } }, ;
      { K_CTRL_HOME,   { | b | b:panhome() } }, ;
      { K_CTRL_END,    { | b | b:panend() } }, ;
      { K_MWBACKWARD,  { | b | b:down() } }, ;
      { K_MWFORWARD,   { | b | b:up() } }, ;
      { K_LBUTTONDOWN, bMButton }, ;
      { K_RBUTTONDOWN, bMButton } ;
      }

   hb_default( @aCustomKeys, {} )

   cSaveWin := SaveScreen( nTop, nLeft, nBot, nRight )
   hb_DispBox( nTop, nLeft, nBot, nRight, HB_B_SINGLE_UNI )

   b := TBrowseNew( nTop + 1, nLeft + 1, nBot - 1, nRight - 1 )
   b:headsep := hb_UTF8ToStrBox( "â•â•¤â•" )
   b:colsep  := hb_UTF8ToStrBox( " â”‚ " )
   b:footsep := hb_UTF8ToStrBox( "â•â•§â•" )

   b:gotopblock    := {|| nElem := 1 }
   b:gobottomblock := {|| nElem := Len( ar ) }

   // skipblock originally coded by Robert DiFalco
   b:SkipBlock     := {| nSkip, nStart | nStart := nElem, ;
      nElem := Max( 1, Min( Len( ar ), nElem + nSkip ) ), ;
      nElem - nStart }

   IF HB_ISCHAR( cColorSpec )
      b:colorSpec := cColorSpec
   ENDIF

   FOR i := 1 TO Len( aBlocks )
      column := TBColumnNew( aHeadings[ i ], aBlocks[ i ] )
      IF HB_ISARRAY( aColorBlocks ) .AND. Len( aColorBlocks ) >= i .AND. HB_ISBLOCK( aColorBlocks[ i ] )
         column:colorBlock := aColorBlocks[ i ]
      ENDIF
      IF HB_ISARRAY( aFooters ) .AND. Len( aFooters ) == Len( aColorBlocks )
         column:footing := aFooters[ i ]
      ENDIF
      b:addcolumn( column )
   NEXT

   oHSBar := ScrollBar( nLeft + 1, nRight - 1, nBot, , SCROLL_HORIZONTAL )
   oHSBar:total := b:colCount - 1

   oVSBar := ScrollBar( nTop + 2, nBot - 1, nRight )
   oVSBar:total := Len( ar ) - 1

   exit_requested := .F.
   DO WHILE ! exit_requested

      DO WHILE ( nKey := Inkey() ) == 0 .AND. ! b:stabilize()
      ENDDO

      oHSBar:current := b:colPos - 1
      oHSBar:Display()
      oVSBar:current := nElem - 1
      oVSBar:Display()

      IF nKey == 0
         nKey := Inkey( 0 )
      ENDIF

      meth_no := AScan( tb_methods, {| elem | nKey == elem[ KEY_ELEM ] } )
      IF meth_no != 0
         Eval( tb_methods[ meth_no, BLK_ELEM ], b )
      ELSE
         meth_no := AScan( aCustomKeys, { | elem | iif( HB_ISARRAY( elem[ KEY_ELEM ] ), AScan( elem[ KEY_ELEM ], nKey ) > 0, nKey == elem[ KEY_ELEM ] ) } )
         IF meth_no != 0
            Eval( aCustomKeys[ meth_no, BLK_ELEM ], nElem, ar, b )
            IF Len( ar ) == 0
               exit_requested := .T.
               nElem := 0
            ELSE
               b:refreshAll()
            ENDIF
         ELSE
            DO CASE
            CASE nKey == K_DEL
               IF HB_ISBLOCK( bDeleteFunc )
                  Eval( bDeleteFunc, nElem, ar )
               ELSE
                  hb_ADel( ar, nElem, .T.  )
               ENDIF
               IF Len( ar ) == 0
                  exit_requested := .T.
                  nElem := 0
               ELSE
                  b:up()
                  b:refreshAll()
               ENDIF

            CASE nKey == K_INS
               IF HB_ISBLOCK( bInsertFunc )
                  Eval( bInsertFunc, nElem, ar )
                  b:gobottom()
                  b:refreshAll()
               ENDIF

            CASE nKey == K_ESC
               exit_requested := .T.

               // Other exception handling ...
            CASE HB_ISBLOCK( bGetFunc )
               IF nKey != K_ENTER
                  // want last key to be part of GET edit so KEYBOARD it
                  hb_keyPut( LastKey() )
               ENDIF
               Eval( bGetFunc, b, ar, b:colPos, nElem )
               // after get move to next field
               hb_keyPut( iif( b:colPos < b:colCount, K_RIGHT, { K_HOME, K_DOWN } ) )

               // Placing K_ENTER here below Edit Block (i.e. bGetFunc)
               // defaults K_ENTER to Edit when bGetFunc Is Present
               // BUT if no bGetFunc, then K_ENTER selects element to return
            CASE nKey == K_ENTER
               exit_requested := .T.

            ENDCASE
         ENDIF
      ENDIF
   ENDDO
   RestScreen( nTop, nLeft, nBot, nRight, cSaveWin )

   RETURN nElem

/*----------------------------------------------------------------------*/

FUNCTION PrintTextEx( nRow, nCol, cTekst )

   LOCAL i := 1
   LOCAL cTag := ""
   LOCAL lInTag := .F.
   LOCAL cCurChar := ""
   LOCAL cOldColor := SetColor()

   DevPos( nRow, nCol )

   DO WHILE i <= Len( cTekst )
      cCurChar := SubStr( cTekst, i, 1 )
      IF lInTag
         IF cCurChar == "}"
            lInTag := .F.
            // zrob tag
            SetColor( cTag )
            cTag := ""
         ELSE
            cTag += cCurChar
         ENDIF
      ELSEIF cCurChar == "{"
         lInTag := .T.
         cTag := ""
      ELSE
         QQOut( cCurChar )
      ENDIF
      i += 1
   ENDDO

   SetColor( cOldColor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION PodzielNIP( cNip, cKraj )

   LOCAL cRes := Upper( AllTrim( cNip ) )

   IF Len( cRes ) > 1
      IF IsAlpha( SubStr( cRes, 1, 2 ) )
         cKraj := SubStr( cRes, 1, 2 )
         cRes := SubStr( cRes, 3 )
      ENDIF
   ENDIF

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION HGetDefault( aHash, xKey, xDefault )

   RETURN iif( hb_HHasKey( aHash, xKey ), aHash[ xKey ], xDefault )

/*----------------------------------------------------------------------*/

FUNCTION ProgressBar( nValue, nMaxValue, nWidth, cPicture )

   LOCAL cRes

   hb_default( @nWidth, 10 )
   hb_default( @cPicture, "°²" )

   cRes := Replicate( SubStr( cPicture, 2, 1 ), Round( nWidth / nMaxValue * nValue, 0 ) ) + ;
      Replicate( SubStr( cPicture, 1, 1 ), nWidth - Round( nWidth / nMaxValue * nValue, 0 ) )

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION UsunZnakHash( cDane )

   RETURN iif( SubStr( cDane, 1, 1 ) == "#", SubStr( cDane, 2 ) + " ", cDane )

/*----------------------------------------------------------------------*/

FUNCTION PodzielNaWiersze( cDoPodzialu, nSzerokosc )

   LOCAL aRes := {}
   LOCAL i := 1

   cDoPodzialu := AllTrim( cDoPodzialu )
   IF Len( cDoPodzialu ) > nSzerokosc
      DO WHILE Len( cDoPodzialu ) > i
         AAdd( aRes, PadR( SubStr( cDoPodzialu, i, nSzerokosc ), nSzerokosc ) )
         i := i + nSzerokosc
      ENDDO
   ELSE
      AAdd( aRes, PadR( cDoPodzialu, nSzerokosc ) )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION BlokadaPro( cTablica )

   LOCAL lRes

   hb_default( @cTablica, Alias() )

   DO WHILE .T.
      IF ( cTablica )->( FLock() )
         lRes := .T.
         EXIT
      ENDIF
      Komun( 'Prosz© czeka† - zbi¢r chwilowo nie mo¾e by† zablokowany' )
      IF LastKey() == K_ESC
         lRes := .F.
         EXIT
      ENDIF
   ENDDO

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION SprawdzNIPSuma( cNip )

   LOCAL lRes := .F.
   LOCAL nSuma

   IF Len( cNip ) == 10
      nSuma := 6 * Val( SubStr( cNip, 1, 1 ) ) + ;
         5 * Val( SubStr( cNip, 2, 1 ) ) + ;
         7 * Val( SubStr( cNip, 3, 1 ) ) + ;
         2 * Val( SubStr( cNip, 4, 1 ) ) + ;
         3 * Val( SubStr( cNip, 5, 1 ) ) + ;
         4 * Val( SubStr( cNip, 6, 1 ) ) + ;
         5 * Val( SubStr( cNip, 7, 1 ) ) + ;
         6 * Val( SubStr( cNip, 8, 1 ) ) + ;
         7 * Val( SubStr( cNip, 9, 1 ) )
      nSuma := nSuma % 11
      lRes := nSuma == Val( SubStr( cNip, 10, 1 ) )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

PROCEDURE WydrukProsty( cTresc, cTytul )

   LOCAL oRap

   IF Empty( cTresc ) .OR. ValType( cTresc ) <> 'C'
      RETURN
   ENDIF

   hb_default( @cTytul, "" )

   oRap := TFreeReport():New()
   oRap:LoadFromFile( 'frf\drukprosty.frf' )
   IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
      oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
   ENDIF
   oRap:AddValue( 'Tytul', cTytul )
   oRap:AddValue( 'Tresc', cTresc )
   oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
   oRap:ModalPreview := .F.
   cKolor := ColStd()
   @ 24, 0
   @ 24, 26 PROMPT '[ Monitor ]'
   @ 24, 44 PROMPT '[ Drukarka ]'
   IF trybSerwisowy
      @ 24, 70 PROMPT '[ Edytor ]'
   ENDIF
   CLEAR TYPE
   nMenu := Menu(1)
   IF LastKey() != 27
      SWITCH nMenu
      CASE 1
         oRap:ShowReport()
         EXIT
      CASE 2
         IF oRap:PrepareReport()
            oRap:PrintPreparedReport('', 1)
         ENDIF
         EXIT
      CASE 3
         oRap:DesignReport()
         EXIT
      ENDSWITCH
   ENDIF
   @ 24, 0
   SetColor(cKolor)

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION NormalizujNipPL( cNip )

   LOCAL cRes := '', nI, cC

   cNip := AllTrim( cNip )

   FOR nI := 1 TO Len( cNip )
      cC := SubStr( cNip, nI, 1 )
      IF cC $ '0123456789'
         cRes := cRes + cC
      ENDIF
   NEXT

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION AMerge( aArr1, aArr2 )

   LOCAL aRes := {}, nI

   FOR nI := 1 TO Len( aArr1 )
      IF AScan( aArr2, aArr1[ nI ] ) > 0
         AAdd( aRes, aArr1[ nI ] )
      ENDIF
   NEXT

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION KrajUE( cKraj )

   LOCAL aKrajeUE := { "AT", "BE", "BG", "CY", "CZ", "DK", "DE", "EE", "EL", ;
       "ES", "FI", "FR", "GB", "HR", "HU", "IE", "IT", "LV", "LT", "LU", ;
       "MT", "NL", "PT", "RO", "SE", "SI", "SK" }

   RETURN AScan( aKrajeUE, cKraj ) > 0

/*----------------------------------------------------------------------*/

FUNCTION gm_ATokens( cDane, cSeparator )

   LOCAL aRes := hb_ATokens( AllTrim( cDane ), cSeparator )
   LOCAL nI

   FOR nI := Len( aRes ) TO 1 STEP -1
      aRes[ nI ] := AllTrim( aRes[ nI ] )
      IF Len( aRes[ nI ] ) == 0
         hb_ADel( aRes, nI, .T. )
      ENDIF
   NEXT

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION gm_AStrTok( aTab )

   LOCAL cRes := ""

   AEval( aTab, { | cElem |
      IF Len( AllTrim( cElem ) ) > 0
         IF cRes <> ""
            cRes := cRes + ','
         ENDIF
         cRes := cRes + AllTrim( cElem )
      ENDIF
   } )

   RETURN cRes

/*----------------------------------------------------------------------*/
