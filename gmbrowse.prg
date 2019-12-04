/*
 * Quick Clipper Browse()
 *
 * Copyright 1999 Antonio Linares <alinares@fivetech.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file LICENSE.txt.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA (or visit https://www.gnu.org/licenses/).
 *
 * As a special exception, the Harbour Project gives permission for
 * additional uses of the text contained in its release of Harbour.
 *
 * The exception is that, if you link the Harbour libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the Harbour
 * Project under the name Harbour.  If you copy code from other
 * Harbour Project or Free Software Foundation releases into a copy of
 * Harbour, as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for Harbour, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#include "box.ch"
#include "inkey.ch"
#include "setcurs.ch"

/*

aColSpecs = {
field     C
caption   C
readonly  L
picture   C
valid     B
when      B
width     N
}

aOptions = {

new_record    B
before_delete B
after_delete  B

}

*/

FUNCTION GMBrowse( aColSpecs, nTop, nLeft, nBottom, nRight, aOptions )

   LOCAL oBrw, oCol
   LOCAL lContinue, lAppend, lKeyPressed, lRefresh
   LOCAL n, nOldCursor, nKey
   LOCAL cOldScreen
   LOCAL bAction
   LOCAL aCargoData

   hb_default( @aOptions, hb_Hash() )

   aCargoData := { 'aOptions' => aOptions, 'aColSpecs' => aColSpecs }

   IF ! Used()
      RETURN .F.
   ENDIF

   lAppend := lKeyPressed := lRefresh := .F.

   IF PCount() < 5
      nTop    := 1
      nLeft   := 0
      nBottom := MaxRow()
      nRight  := MaxCol()
   ENDIF

   DispBegin()

   nOldCursor := SetCursor( SC_NONE )
   cOldScreen := SaveScreen( nTop, nLeft, nBottom, nRight )

   hb_DispBox( nTop, nLeft, nBottom, nRight, HB_B_DOUBLE_SINGLE_UNI )
   hb_DispOutAtBox( nTop + 3, nLeft, hb_UTF8ToStrBox( "╞" ) )
   hb_DispOutAtBox( nTop + 3, nRight, hb_UTF8ToStrBox( "╡" ) )
   hb_DispOutAt( nTop + 1, nLeft + 1, Space( nRight - nLeft - 1 ) )

   oBrw := TBrowseDB( nTop + 2, nLeft + 1, nBottom - 1, nRight - 1 )
   oBrw:HeadSep := " " + hb_UTF8ToStrBox( "═" )
   oBrw:SkipBlock := {| nRecs | GMSkipped( nRecs, lAppend ) }
   oBrw:cargo := aCargoData

   FOR n := 1 TO Len( aColSpecs )
      oCol := TBColumnNew( iif( hb_HHasKey( aColSpecs[ n ], 'caption' ), ;
         aColSpecs[ n ][ 'caption' ], aColSpecs[ n ][ 'field' ] ), ;
         FieldBlock( aColSpecs[ n ][ 'field' ] ) )
      IF hb_HHasKey( aColSpecs[ n ], 'width' )
         oCol:width := aColSpecs[ n ][ 'width' ]
      ENDIF
      oCol:cargo := aColSpecs[ n ]
      oBrw:AddColumn( oCol )
   NEXT

   IF Eof()
      dbGoTop()
   ENDIF

   oBrw:ForceStable()

   DispEnd()

   IF LastRec() == 0
      nKey := K_DOWN
      lKeyPressed := .T.
   ENDIF

   lContinue := .T.

   DO WHILE lContinue

      DO WHILE ! lKeyPressed .AND. ! oBrw:Stabilize()
         lKeyPressed := ( nKey := Inkey() ) != 0
      ENDDO

      IF lKeyPressed
         lKeyPressed := .F.
      ELSE
         IF oBrw:HitBottom .AND. ( ! lAppend .OR. RecNo() != LastRec() + 1 )
            IF lAppend
               oBrw:RefreshCurrent()
               oBrw:ForceStable()
               dbGoBottom()
            ELSE
               lAppend := .T.
               SetCursor( iif( ReadInsert(), SC_INSERT, SC_NORMAL ) )
            ENDIF
            oBrw:Down()
            oBrw:ForceStable()
            oBrw:ColorRect( { oBrw:RowPos, 1, oBrw:RowPos, oBrw:ColCount }, ;
               { 2, 2 } )
         ENDIF

         GMStatLine( oBrw, lAppend )

         oBrw:ForceStable()

         nKey := Inkey( 0 )
         IF ( bAction := SetKey( nKey ) ) != NIL
            Eval( bAction, ProcName( 1 ), ProcLine( 1 ), "" )
            LOOP
         ENDIF
      ENDIF

      SWITCH nKey

#ifdef HB_COMPAT_C53
      CASE K_LBUTTONDOWN
      CASE K_LDBLCLK
         TBMouse( oBrw, MRow(), MCol() )
         EXIT
#endif
#ifndef HB_CLP_STRICT
      CASE K_MWFORWARD
#endif
      CASE K_UP
         IF lAppend
            lRefresh := .T.
         ELSE
            oBrw:Up()
         ENDIF
         EXIT

#ifndef HB_CLP_STRICT
      CASE K_MWBACKWARD
#endif
      CASE K_DOWN
         IF lAppend
            oBrw:HitBottom := .T.
         ELSE
            oBrw:Down()
         ENDIF
         EXIT

      CASE K_PGUP
         IF lAppend
            lRefresh := .T.
         ELSE
            oBrw:PageUp()
         ENDIF
         EXIT

      CASE K_PGDN
         IF lAppend
            oBrw:HitBottom := .T.
         ELSE
            oBrw:PageDown()
         ENDIF
         EXIT

      CASE K_CTRL_PGUP
         IF lAppend
            lRefresh := .T.
         ELSE
            oBrw:GoTop()
         ENDIF
         EXIT

      CASE K_CTRL_PGDN
         IF lAppend
            lRefresh := .T.
         ELSE
            oBrw:GoBottom()
         ENDIF
         EXIT

      CASE K_LEFT
         oBrw:Left()
         EXIT

      CASE K_RIGHT
         oBrw:Right()
         EXIT

      CASE K_HOME
         oBrw:Home()
         EXIT

      CASE K_END
         oBrw:End()
         EXIT

      CASE K_CTRL_LEFT
         oBrw:panLeft()
         EXIT

      CASE K_CTRL_RIGHT
         oBrw:panRight()
         EXIT

      CASE K_CTRL_HOME
         oBrw:panHome()
         EXIT

      CASE K_CTRL_END
         oBrw:panEnd()
         EXIT

      CASE K_INS
         IF lAppend
            SetCursor( iif( ReadInsert( ! ReadInsert() ), ;
               SC_NORMAL, SC_INSERT ) )
         ENDIF
         EXIT

      CASE K_DEL
         IF RecNo() != LastRec() + 1
            IF Deleted()
               dbRecall()
            ELSE
               IF hb_HHasKey( aOptions, 'before_delete' ) .AND. HB_ISBLOCK( aOptions[ 'before_delete' ] )
                  Eval( aOptions[ 'before_delete' ] )
               ENDIF
               dbDelete()
               IF hb_HHasKey( aOptions, 'after_delete' ) .AND. HB_ISBLOCK( aOptions[ 'after_delete' ] )
                  Eval( aOptions[ 'after_delete' ] )
               ENDIF
               oBrw:Down()
//               oBrw:RefreshCurrent()
//               oBrw:ForceStable()
               lRefresh := .T.
            ENDIF
         ENDIF
         EXIT

      CASE K_ENTER
         IF lAppend .OR. RecNo() != LastRec() + 1
            lKeyPressed := ( nKey := GMDoGet( oBrw, lAppend ) ) != 0
         ELSE
            nKey := K_DOWN
            lKeyPressed := .T.
         ENDIF
         EXIT

      CASE K_ESC
         lContinue := .F.
         EXIT

      OTHERWISE
         IF ! hb_keyChar( nKey ) == ""
//            hb_keyIns( nKey )
            nKey := K_ENTER
            lKeyPressed := .T.
         ENDIF
      ENDSWITCH

      IF lRefresh
         lRefresh := lAppend := .F.
         GMFreshOrder( oBrw )
         SetCursor( SC_NONE )
      ENDIF

   ENDDO

   RestScreen( nTop, nLeft, nBottom, nRight, cOldScreen )
   SetCursor( nOldCursor )

   RETURN .T.

STATIC PROCEDURE GMStatLine( oBrw, lAppend )

   LOCAL nTop   := oBrw:nTop - 1
   LOCAL nRight := oBrw:nRight

   LOCAL nRecNo := RecNo()
   LOCAL nLastRec := LastRec()

   hb_DispOutAt( nTop, nRight - 27, "Rekord " )

   IF nLastRec == 0 .AND. ! lAppend
      hb_DispOutAt( nTop, nRight - 20, "<brak>               " )
   ELSEIF nRecNo == nLastRec + 1
      hb_DispOutAt( nTop, nRight - 40, "         " )
      hb_DispOutAt( nTop, nRight - 20, "               <nowy>" )
   ELSE
      hb_DispOutAt( nTop, nRight - 40, iif( Deleted(), "<Usuni�ty>", "         " ) )
      hb_DispOutAt( nTop, nRight - 20, PadR( hb_ntos( nRecNo ) + "/" + ;
         hb_ntos( nLastRec ), 16 ) + ;
         iif( oBrw:HitTop, "<bof>", "     " ) )
   ENDIF

   RETURN

STATIC FUNCTION GMDoGet( oBrw, lAppend )

   LOCAL lScore, lExit, bIns, nCursor
   LOCAL oCol, oGet
   LOCAL cIndexKey, cForExp, xKeyValue
   LOCAL bIndexKey
   LOCAL lSuccess, nKey, xValue

   oBrw:HitTop := .F.
   GMStatLine( oBrw, lAppend )
   oBrw:ForceStable()

   lScore := Set( _SET_SCOREBOARD, .F. )
   lExit := Set( _SET_EXIT, .T. )
   bIns := SetKey( K_INS, {|| SetCursor( iif( ReadInsert( ! ReadInsert() ), ;
      SC_NORMAL, SC_INSERT ) ) } )
   nCursor := SetCursor( iif( ReadInsert(), SC_INSERT, SC_NORMAL ) )
   IF ! Empty( cIndexKey := IndexKey( 0 ) )
      xKeyValue := Eval( bIndexKey := hb_macroBlock( cIndexKey ) )
   ENDIF

   oCol := oBrw:GetColumn( oBrw:ColPos )
   xValue := Eval( oCol:Block )
   oGet := GetNew( Row(), Col(), ;
      {| xNewVal | iif( PCount() == 0, xValue, xValue := xNewVal ) }, ;
      "mGetVar", iif( hb_HHasKey( oCol:cargo, 'picture' ) .AND. ;
      HB_ISCHAR( oCol:cargo[ 'picture' ] ), oCol:cargo[ 'picture' ], NIL ), ;
      oBrw:ColorSpec )
   lSuccess := .F.
   IF ReadModal( { oGet } )
      IF hb_HHasKey( oBrw:cargo[ 'aOptions' ], 'before_edit' ) .AND. HB_ISBLOCK( oBrw:cargo[ 'aOptions' ][ 'before_edit' ] )
         Eval( oBrw:cargo[ 'aOptions' ][ 'before_edit' ] )
      ENDIF

      IF lAppend .AND. RecNo() == LastRec() + 1
         dbAppend()
         IF hb_HHasKey( oBrw:cargo[ 'aOptions' ], 'new_record' ) .AND. HB_ISBLOCK( oBrw:cargo[ 'aOptions' ][ 'new_record' ] )
            Eval( oBrw:cargo[ 'aOptions' ][ 'new_record' ] )
         ENDIF
      ENDIF

      Eval( oCol:Block, xValue )

      IF hb_HHasKey( oBrw:cargo[ 'aOptions' ], 'after_edit' ) .AND. HB_ISBLOCK( oBrw:cargo[ 'aOptions' ][ 'after_edit' ] )
         Eval( oBrw:cargo[ 'aOptions' ][ 'after_edit' ] )
      ENDIF

      IF ! lAppend .AND. ! Empty( cForExp := ordFor( IndexOrd() ) ) .AND. ;
         ! Eval( hb_macroBlock( cForExp ) )
         dbGoTop()
      ENDIF
      IF ! lAppend .AND. ! Empty( bIndexKey ) .AND. ! xKeyValue == Eval( bIndexKey )
         lSuccess := .T.
      ENDIF
   ENDIF

   IF lSuccess
      GMFreshOrder( oBrw )
      nKey := 0
   ELSE
      oBrw:RefreshCurrent()
      nKey := GMExitKey( lAppend )
   ENDIF

   IF lAppend
      oBrw:ColorRect( { oBrw:RowPos, 1, oBrw:RowPos, oBrw:ColCount }, ;
         { 2, 2 } )
   ENDIF

   SetCursor( nCursor )
   SetKey( K_INS, bIns )
   Set( _SET_EXIT, lExit )
   Set( _SET_SCOREBOARD, lScore )

   RETURN nKey

STATIC FUNCTION GMExitKey( lAppend )

   LOCAL nKey

   SWITCH nKey := LastKey()
   CASE K_PGDN
      RETURN iif( lAppend, 0, K_DOWN )
   CASE K_PGUP
      RETURN iif( lAppend, 0, K_UP )
   CASE K_DOWN
   CASE K_UP
      RETURN nKey
   ENDSWITCH

   RETURN iif( nKey == K_ENTER .OR. !( hb_keyChar( nKey ) == "" ), K_RIGHT, 0 )

STATIC PROCEDURE GMFreshOrder( oBrw )

   LOCAL nRec := RecNo()

   oBrw:RefreshAll()
   oBrw:ForceStable()

   IF nRec != LastRec() + 1
      DO WHILE RecNo() != nRec .AND. ! Bof()
         oBrw:Up()
         oBrw:ForceStable()
      ENDDO
   ENDIF

   RETURN

STATIC FUNCTION GMSkipped( nRecs, lAppend )

   LOCAL nSkipped := 0

   IF LastRec() != 0
      DO CASE
      CASE nRecs == 0
         dbSkip( 0 )
      CASE nRecs > 0 .AND. RecNo() != LastRec() + 1
         DO WHILE nSkipped < nRecs
            dbSkip()
            IF Eof()
               IF lAppend
                  ++nSkipped
               ELSE
                  dbSkip( -1 )
               ENDIF
               EXIT
            ENDIF
            ++nSkipped
         ENDDO
      CASE nRecs < 0
         DO WHILE nSkipped > nRecs
            dbSkip( -1 )
            IF Bof()
               EXIT
            ENDIF
            --nSkipped
         ENDDO
      ENDCASE
   ENDIF

   RETURN nSkipped
