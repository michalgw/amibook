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

#include "hbclass.ch"
#include "inkey.ch"
#include "tbrowse.ch"
#include "box.ch"
#include "button.ch"
#include "dbinfo.ch"

CREATE CLASS TEDeklaracje
   VAR lOtworzPrac
   VAR oBrowser
   VAR oHSBar
   VAR oVSBar
   VAR aWybrane
   VAR nWybranych
   VAR lBramkaTestowa
   VAR nRekord
   VAR nLiczbaRekordow
   VAR nPracOrd
   VAR nPracRecNo
   METHOD New(lOtwPrac)
   METHOD Inicjuj()
   METHOD Zakoncz()
   METHOD Uruchom(nID)
   METHOD PobierzPrac()
   METHOD PobierzInfo()
   METHOD Skip(nRecs)
   METHOD Podpisz()
   METHOD PodpiszAut()
   METHOD Usun()
   METHOD ZaznaczNiepodpisane()
   METHOD ZaznaczNiewyslane()
   METHOD ZaznaczBezUPO()
   METHOD CzyscAWybrane()
   METHOD Wyslij()
   METHOD RaportWysylki(aDane)
   METHOD PobierzUPO()
   METHOD RaportUPO(aDane)
   METHOD Informacje()
   METHOD Pomoc()
   METHOD WybierzBramke(lRezultat)
   METHOD DrukujDeklaracje()
   METHOD DrukujUPO()
   METHOD Eksport()
   METHOD UruchomGMJPK()
ENDCLASS

METHOD New(lOtwPrac) CLASS TEDeklaracje
   hb_default(@lOtwPrac, .T.)
   ::lOtworzPrac := lOtwPrac
   ::aWybrane := {}
   ::lBramkaTestowa := .T.
   ::nRekord := 0
   RETURN Self

METHOD Inicjuj() CLASS TEDeklaracje
   LOCAL lRes := .F., oCol, nIlosc, bColorBlock, nTmpArea
   IF !DostepPro('EDEKLAR', 'EDEKLAR')
      RETURN .F.
   ENDIF
   edeklar->(dbSetFilter({ || iif(edeklar->firma == ident_fir, .T., .F.) }, 'edeklar->firma == ident_fir'))
   edeklar->(dbGoTop())
   IF (nIlosc := dbIlosc('edeklar')) == 0
      edeklar->(dbCloseArea())
      komun('Brak deklaracji')
      RETURN .F.
   ENDIF
   ::nLiczbaRekordow := nIlosc
   IF ::lOtworzPrac
      nTmpArea := Select()
      IF Select('PRAC') == 0
         IF !DostepPro('PRAC', , , , 'PRAC')
            edeklar->(dbCloseArea())
            RETURN .F.
         ENDIF
      ENDIF
      Select(nTmpArea)
   ELSE
      ::nPracOrd := dbOrderInfo( DBOI_NUMBER )
      ::nPracRecNo := prac->( RecNo() )
   ENDIF
   prac->( dbSetOrder( 5 ) )
   bColorBlock := {|| iif(AScan(::aWybrane, { |n| n == edeklar->(RecNo()) }) > 0, {5,2}, {1,2}) }
   ::oBrowser := TBrowseNew(3, 0, 22, 79)
   ::oBrowser:border := B_SINGLE
   ::oBrowser:ColSep := "³"
   ::oBrowser:HeadSep := "Ä"
   ::oBrowser:GoTopBlock := {|| edeklar->(dbGoTop()) }
   ::oBrowser:GoBottomBlock := {|| edeklar->(dbGoBottom()) }
   ::oBrowser:SkipBlock := { |nSkip| ::Skip(nSkip) }
   oCol := TBColumnNew("Nr", { || Str(edeklar->id, 4) })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Rodzaj", { || SubStr(edeklar->rodzaj, 1, 8) })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Info", { || iif(AScan(::aWybrane, { |n| n == edeklar->(RecNo()) }) > 0, '*', ' ') + ;
      iif(edeklar->korekta, 'K', ' ') + ;
      iif(edeklar->podpisany, 'P', ' ') + iif(edeklar->jest_upo, 'U', ' ') + ;
      iif(!Empty(edeklar->wyslano), 'W', ' ') + iif(edeklar->test, 'T', ' ') })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Status", { || SubStr(edeklar->status, 1, 6) })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Okres", { || PadC(AllTrim(edeklar->miesiac), 5) })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Pracownik", { || ::PobierzPrac() })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Utworzono", { || edeklar->utworzono })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Wysˆano", { || edeklar->wyslano })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Opis statusu", { || edeklar->statopis })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)
   oCol := TBColumnNew("Nr referencyjny", { || edeklar->skrot })
   oCol:colorBlock := bColorBlock
   ::oBrowser:AddColumn(oCol)

   ::oHSBar := ScrollBar(1, 78, 22, , SCROLL_HORIZONTAL)
   ::oHSBar:total := ::oBrowser:colCount - 1

   ::oVSBar := ScrollBar(6, 21, 79)
   ::oVSBar:total := nIlosc

   RETURN .T.

METHOD Zakoncz() CLASS TEDeklaracje
   edeklar->(dbCloseArea())
   IF ::lOtworzPrac
      prac->(dbCloseArea())
   ELSEIF HB_ISNUMERIC( ::nPracOrd )
      prac->( dbSetOrder( ::nPracOrd ) )
      prac->( dbGoto( ::nPracRecNo ) )
   ENDIF
   RETURN

METHOD Uruchom(nID) CLASS TEDeklaracje
   LOCAL lKoniec := .F., nKey, nIdx
   IF !(::Inicjuj())
      RETURN .F.
   ENDIF
   IF HB_ISNUMERIC(nID)
      nIdx := 1
      DO WHILE .NOT. ::oBrowser:hitBottom
         IF edeklar->id == nID
            EXIT
         ENDIF
         nIdx++
         ::oBrowser:down()
         ::oBrowser:stabilize()
      ENDDO
      ::nRekord := nIdx
   ENDIF
   @ 1,47 SAY 'F1 - Pomoc'
   WHILE !lKoniec
      ::oBrowser:ForceStable()
      IF ::oBrowser:hitTop
         ::nRekord := 1
      ENDIF
      IF ::oBrowser:hitBottom
         ::nRekord := ::nLiczbaRekordow
      ENDIF
      ::oHSBar:current := ::oBrowser:colPos - 1
      ::oHSBar:Display()
      ::oVSBar:current := ::nRekord
      ::oVSBar:Display()
      IF aWybranyCertyfikat['wybrany']
         @ 23, 0 SAY PadR('Certyfikat: ' + aWybranyCertyfikat['nazwa'], 80)
      ELSE
         @ 23, 0 SAY PadR('Nie wybrano certyfikatu', 80)
      ENDIF
      nKey := Inkey(0)
      DO CASE
         CASE nKey == K_ESC
            lKoniec := .T.
         CASE nKey == K_UP .OR. nKey == K_MWFORWARD
            ::oBrowser:Up()
         CASE nKey == K_DOWN .OR. nKey == K_MWBACKWARD
            ::oBrowser:Down()
         CASE nKey == K_LEFT
            ::oBrowser:Left()
         CASE nKey == K_RIGHT
            ::oBrowser:Right()
         CASE nKey == K_PGUP
            ::oBrowser:PageUp()
         CASE nKey == K_PGDN
            ::oBrowser:PageDown()
         CASE nKey == K_HOME
            ::oBrowser:goTop()
         CASE nKey == K_END
            ::oBrowser:goBottom()
         CASE nKey == Asc('C') .OR. nKey == Asc('c')
            edekWybierzCertyfikat()
         CASE nKey == Asc('P') .OR. nKey == Asc('p')
            ::Podpisz()
         CASE nKey == Asc('L') .OR. nKey == Asc('l')
            ::PodpiszAut()
         CASE nKey == K_DEL
            ::Usun()
            IF dbIlosc('edeklar') == 0
               komun('Brak deklaracji')
               lKoniec := .T.
            ENDIF
         CASE nKey == K_ENTER .OR. nKey == Asc(' ')
            nIdx := AScan(::aWybrane, {|n| n == edeklar->(RecNo()) })
            IF nIdx == 0
               AAdd(::aWybrane, edeklar->(RecNo()))
            ELSE
               ADel(::aWybrane, nIdx)
            ENDIF
            ::oBrowser:refreshCurrent()
         CASE nKey == Asc('N') .OR. nKey == Asc('n')
            ::ZaznaczNiepodpisane()
         CASE nKey == Asc('M') .OR. nKey == Asc('m')
            ::ZaznaczNiewyslane()
         CASE nKey == Asc('O') .OR. nKey == Asc('o')
            ::aWybrane := {}
            ::oBrowser:refreshAll()
         CASE nKey == Asc('W') .OR. nKey == Asc('w')
            ::Wyslij()
         CASE nKey == Asc('U') .OR. nKey == Asc('u')
            ::PobierzUPO()
         CASE nKey == Asc('B') .OR. nKey == Asc('b')
            ::ZaznaczBezUPO()
         CASE nKey == Asc('I') .OR. nKey == Asc('i')
            ::Informacje()
         CASE nKey == K_F1
            ::Pomoc()
         CASE nKey == Asc('D') .OR. nKey == Asc('d')
            ::DrukujDeklaracje()
         CASE nKey == Asc('F') .OR. nKey == Asc('f')
            ::DrukujUPO()
         CASE nKey == Asc('E') .OR. nKey == Asc('e')
            ::Eksport()
         CASE nKey == Asc('J') .OR. nKey == Asc('j')
            ::UruchomGMJPK()
         CASE nKey == K_LBUTTONDOWN
            IF ::oBrowser:hitTest(MRow(), MCol()) == HTCELL
               ::oBrowser:colPos := ::oBrowser:mColPos
               ::oBrowser:rowPos := ::oBrowser:mRowPos
               ::oBrowser:invalidate()
            ENDIF
            SWITCH ::oHSBar:HitTest(MRow(), MCol())
               CASE HTSCROLLUNITDEC
               CASE HTSCROLLBLOCKDEC
                  ::oBrowser:Left()
                  EXIT
               CASE HTSCROLLUNITINC
               CASE HTSCROLLBLOCKINC
                  ::oBrowser:Right()
                  EXIT
            ENDSWITCH
            SWITCH ::oVSBar:HitTest(MRow(), MCol())
               CASE HTSCROLLUNITDEC
                  ::oBrowser:Up()
                  EXIT
               CASE HTSCROLLUNITINC
                  ::oBrowser:Down()
                  EXIT
               CASE HTSCROLLBLOCKDEC
                  ::oBrowser:PageUp()
                  EXIT
               CASE HTSCROLLBLOCKINC
                  ::oBrowser:PageDown()
                  EXIT
            ENDSWITCH
         CASE nKey == K_RBUTTONDOWN
            IF ::oBrowser:hitTest(MRow(), MCol()) == HTCELL
               ::oBrowser:colPos := ::oBrowser:mColPos
               ::oBrowser:rowPos := ::oBrowser:mRowPos
               ::oBrowser:refreshCurrent()
               nIdx := AScan(::aWybrane, {|n| n == edeklar->(RecNo()) })
               IF nIdx == 0
                  AAdd(::aWybrane, edeklar->(RecNo()))
               ELSE
                  ADel(::aWybrane, nIdx)
               ENDIF
               ::oBrowser:invalidate()
            ENDIF
      ENDCASE
   ENDDO
   ::Zakoncz()
   RETURN

METHOD PobierzPrac() CLASS TEDeklaracje
   IF (Val(edeklar->osoba) > 0) .AND. prac->( dbSeek( Val( edeklar->osoba ) ) )
      //prac->(dbGoto(Val(edeklar->osoba)))
      RETURN PadR(SubStr(AllTrim(prac->nazwisko) + ' ' + AllTrim(prac->imie1), 1, 16), 16)
   ENDIF
   RETURN Space(16)

METHOD PobierzInfo() CLASS TEDeklaracje
   RETURN

METHOD Skip(nRecs) CLASS TEDeklaracje
   LOCAL nSkipped := 0

   IF edeklar->(LastRec()) != 0
      IF nRecs == 0
         edeklar->(dbSkip( 0 ))
      ELSEIF nRecs > 0 .AND. (edeklar->(RecNo()) != edeklar->(LastRec()) + 1)
         DO WHILE nSkipped < nRecs
            edeklar->(dbSkip( 1 ))
            IF edeklar->(Eof())
               edeklar->(dbSkip( -1 ))
               EXIT
            ENDIF
            nSkipped++
         ENDDO
      ELSEIF nRecs < 0
         DO WHILE nSkipped > nRecs
            edeklar->(dbSkip( -1 ))
            IF edeklar->(Bof())
               EXIT
            ENDIF
            nSkipped--
         ENDDO
      ENDIF
   ENDIF
   ::nRekord := ::nRekord + nSkipped
   RETURN nSkipped

METHOD Podpisz() CLASS TEDeklaracje
   LOCAL nI, nDbRec, nDekNo := 0
   ::CzyscAWybrane()
   IF Len(::aWybrane) > 0
      komun('Umie˜† kart© w czytniku.')
      nDbRec := edeklar->(RecNo())
      FOR nI := 1 TO Len(::aWybrane)
         edeklar->(dbGoto(::aWybrane[nI]))
         IF !edeklar->podpisany .AND. edekPodpiszDeklaracje( ;
            edekNazwaPliku(edeklar->id), edekNazwaPliku(edeklar->id, '.xml.sig'), ;
            edeklar->rodzaj )

            blokadar('edeklar')
            edeklar->podpisany := .T.
            edeklar->podpiscer := .T.
            IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK' .AND. param_ejts == 'T'
               edeklar->test := .T.
            ENDIF
            edeklar->(dbCommit())
            edeklar->(dbUnlock())

            nDekNo++
         ENDIF
      NEXT
      edeklar->(dbGoto(nDbRec))
      ::aWybrane := {}
      ::oBrowser:refreshAll()
      komun('Podpisano ' + AllTrim(Str(nDekNo)) + ' deklaracji.')
      RETURN .T.
   ELSE
      IF edeklar->podpisany
         komun('Ten dokument jest ju¾ podpisany')
         RETURN .F.
      ENDIF
      komun('Umie˜† kart© w czytniku.')
      IF edekPodpiszDeklaracje(edekNazwaPliku(edeklar->id), ;
         edekNazwaPliku(edeklar->id, '.xml.sig'), edeklar->rodzaj )

         blokadar('edeklar')
         edeklar->podpisany := .T.
         edeklar->podpiscer := .T.
         IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK' .AND. param_ejts == 'T'
            edeklar->test := .T.
         ENDIF
         edeklar->(dbCommit())
         edeklar->(dbUnlock())

         ::oBrowser:refreshCurrent()
         komun('Deklaracja zostaˆa podpisana.')
         RETURN .T.
      ENDIF
   ENDIF
   RETURN .F.

METHOD PodpiszAut() CLASS TEDeklaracje
   LOCAL nI, nDbRec, nDekNo := 0
   LOCAL cNIP := Space( 13 ), cImie := Space( 30 ), cNazwisko := Space( 30 ), dDataUr := CToD( '' ), nKwota := 0, cScr, cKolor

/*   IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK'
      Komun( 'Pliki JPK nie mog¥ by† podpisywane danymi autoryzacyjnymi')
      RETURN .F.
   ENDIF
*/
   IF DostepPro( 'SPOLKA', 'SPOLKA', , 'spolkaedek' )
      IF spolkaedek->( dbSeek( '+' + ident_fir ) ) .AND. spolkaedek->firma == ident_fir
         cNIP := PadR( spolkaedek->nip, 13 )
         cImie := PadR( naz_imie_imie( spolkaedek->naz_imie ), 30 )
         cNazwisko := PadR( naz_imie_naz( spolkaedek->naz_imie ), 30 )
         dDataUr := spolkaedek->data_ur
      ENDIF
      spolkaedek->( dbCloseArea() )
   ENDIF

   SAVE SCREEN TO cScr
   cKolor := ColStd()
   @ 9,  15  CLEAR TO 15, 63
   @ 9,  15, 15, 63 BOX B_SINGLE
   @ 10, 17  SAY '           NIP'
   @ 11, 17  SAY '          Imi©'
   @ 12, 17  SAY '      Nazwisko'
   @ 13, 17  SAY 'Data urodzenia'
   @ 14, 17  SAY '         Kwota'
   @ 10, 32 GET cNIP      PICTURE "!!!!!!!!!!!!!"                  VALID Len( AllTrim( cNIP ) ) > 0
   @ 11, 32 GET cImie     PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID Len( AllTrim( cImie ) ) > 0
   @ 12, 32 GET cNazwisko PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID Len( AllTrim( cNazwisko ) ) > 0
   @ 13, 32 GET dDataUr                                            VALID dDataUr <> CToD("")
   @ 14, 32 GET nKwota    PICTURE '999 999 999.99'
   CLEAR TYPE
   read_()
   RESTORE SCREEN FROM cScr
   SetColor(cKolor)
   IF LastKey() == 27
      RETURN .F.
   ENDIF

   ::CzyscAWybrane()
   IF Len(::aWybrane) > 0
      nDbRec := edeklar->(RecNo())
      FOR nI := 1 TO Len(::aWybrane)
         edeklar->(dbGoto(::aWybrane[nI]))
         IF !edeklar->podpisany .AND. edekPodpiszDeklaracjeAut( ;
            edekNazwaPliku(edeklar->id), edekNazwaPliku(edeklar->id, '.xml.sig'), ;
            cNIP, cImie, cNazwisko, dDataUr, nKwota, edeklar->rodzaj )

            blokadar('edeklar')
            edeklar->podpisany := .T.
            edeklar->podpiscer := .F.
            IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK' .AND. param_ejts == 'T'
               edeklar->test := .T.
            ENDIF
            edeklar->(dbCommit())
            edeklar->(dbUnlock())

            nDekNo++
         ENDIF
      NEXT
      edeklar->(dbGoto(nDbRec))
      ::aWybrane := {}
      ::oBrowser:refreshAll()
      komun('Podpisano ' + AllTrim(Str(nDekNo)) + ' deklaracji.')
      RETURN .T.
   ELSE
      IF edeklar->podpisany
         komun('Ten dokument jest ju¾ podpisany')
         RETURN .F.
      ENDIF
      IF edekPodpiszDeklaracjeAut(edekNazwaPliku(edeklar->id), ;
         edekNazwaPliku(edeklar->id, '.xml.sig'), ;
         cNIP, cImie, cNazwisko, dDataUr, nKwota, edeklar->rodzaj )

         blokadar('edeklar')
         edeklar->podpisany := .T.
         edeklar->podpiscer := .F.
         IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK' .AND. param_ejts == 'T'
            edeklar->test := .T.
         ENDIF
         edeklar->(dbCommit())
         edeklar->(dbUnlock())

         ::oBrowser:refreshCurrent()
         komun('Deklaracja zostaˆa podpisana.')
         RETURN .T.
      ENDIF
   ENDIF
   RETURN .F.

METHOD Usun() CLASS TEDeklaracje
   IF ! Empty( edeklar->wyslano ) .AND. ! edeklar->test
      komun('Nie mo¾na usun¥† wysˆanej deklaracji.')
      RETURN
   ENDIF
   IF TNEsc(.F., 'Czy usun¥† wybran¥ deklaracj©? (T/N)')
      blokadar('edeklar')
      IF File(edekNazwaPliku(edeklar->id))
         FErase(edekNazwaPliku(edeklar->id))
      ENDIF
      IF File(edekNazwaPliku(edeklar->id, '.xml.sig'))
         FErase(edekNazwaPliku(edeklar->id, '.xml.sig'))
      ENDIF
      edeklar->(dbDelete())
      edeklar->(dbCommit())
      edeklar->(dbUnlock())
      edeklar->(dbGoTop())
      ::oBrowser:refreshAll()
      komun('Deklaracja zostaˆa usuni©ta.')
   ENDIF
   RETURN

METHOD ZaznaczNiepodpisane() CLASS TEDeklaracje
   LOCAL nDbRec
   ::aWybrane := {}
   nDbRec := edeklar->(RecNo())
   edeklar->(dbEval({ ||
         IF !edeklar->podpisany
            AAdd(::aWybrane, edeklar->(RecNo()))
         ENDIF
      }))
   edeklar->(dbGoto(nDbRec))
   ::oBrowser:refreshAll()
   RETURN

METHOD ZaznaczNiewyslane() CLASS TEDeklaracje
   LOCAL nDbRec
   ::aWybrane := {}
   nDbRec := edeklar->(RecNo())
   edeklar->(dbEval({ ||
         IF Empty(edeklar->wyslano) .AND. edeklar->podpisany
            AAdd(::aWybrane, edeklar->(RecNo()))
         ENDIF
      }))
   edeklar->(dbGoto(nDbRec))
   ::oBrowser:refreshAll()
   RETURN

METHOD ZaznaczBezUPO() CLASS TEDeklaracje
   LOCAL nDbRec
   ::aWybrane := {}
   nDbRec := edeklar->(RecNo())
   edeklar->(dbEval({ ||
         IF !edeklar->jest_upo
            AAdd(::aWybrane, edeklar->(RecNo()))
         ENDIF
      }))
   edeklar->(dbGoto(nDbRec))
   ::oBrowser:refreshAll()
   RETURN


METHOD CzyscAWybrane() CLASS TEdeklaracje
   LOCAL aTemp := {}
   AEval(::aWybrane, {|x|
      IF !Empty(x)
         AAdd(aTemp, x)
      ENDIF
      })
   ::aWybrane := aTemp
   RETURN

METHOD Wyslij() CLASS TEdeklaracje
   LOCAL cRefId, nStatus, cStatusOpis, nI, nIlosc, nRecNo, nRes
   LOCAL aRaport := hb_Hash('wyslano', 0, 'niewyslano', 0, 'pozycje', {})
   LOCAL aPoz := hb_Hash(), nRefLen
   ::CzyscAWybrane()
   IF Len(::aWybrane) > 0
      ::lBramkaTestowa := .T.
      IF !::WybierzBramke(@::lBramkaTestowa)
         RETURN .F.
      ENDIF
      IF TNEsc(.F., 'Czy wysˆa† zaznaczone deklaracje (liczba: ' + AllTrim(Str(Len(::aWybrane))) + ')  (T/N)')
         nRecNo := edeklar->(RecNo())
         FOR nI := 1 TO Len(::aWybrane)
            edeklar->(dbGoto(::aWybrane[nI]))
            IF Empty(edeklar->wyslano) .AND. Len(AllTrim(edeklar->skrot)) == 0 .AND. edeklar->podpisany
               IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK'
                  nStatus := amiJpkWyslij( edekNazwaPliku(edeklar->id, '.xml.env.sig'), edeklar->test, @cRefId, @nRefLen )
                  IF nStatus == 200
                     blokadar('edeklar')
                     edeklar->wyslano := hb_DateTime()
                     edeklar->skrot := AllTrim( cRefId )
//                     edeklar->status := Str(nStatus, 6, 0)
                     edeklar->statopis := 'Dokument zostaˆ wysˆany'
                     edeklar->(dbCommit())
                     edeklar->(dbUnlock())
                     aRaport['wyslano'] := aRaport['wyslano'] + 1
                     aPoz := hb_Hash()
                     aPoz['id'] := edeklar->id
                     aPoz['ok'] := .T.
                     aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
                     aPoz['refid'] := AllTrim(cRefId)
                     aPoz['statusopis'] := 'Dokument zostaˆ wysˆany'
                     aPoz['status'] := nStatus
                     AAdd(aRaport['pozycje'], aPoz)
                  ELSE
                     aRaport['niewyslano'] := aRaport['niewyslano'] + 1
                     aPoz := hb_Hash()
                     aPoz['ok'] := .F.
                     aPoz['id'] := edeklar->id
                     aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
                     aPoz['przyczyna'] := AllTrim( amiEdekBladTekst() )
                     AAdd( aRaport['pozycje'], aPoz )
                  ENDIF
               ELSE
                  IF amiEdekWyslij(edekNazwaPliku(edeklar->id, '.xml.sig'), ::lBramkaTestowa, edeklar->podpiscer, @cRefId, @nStatus, @cStatusOpis) = 0
                     blokadar('edeklar')
                     edeklar->wyslano := hb_DateTime()
                     edeklar->skrot := cRefId
                     edeklar->status := Str(nStatus, 6, 0)
                     edeklar->statopis := cStatusOpis
                     edeklar->test := ::lBramkaTestowa
                     edeklar->(dbCommit())
                     edeklar->(dbUnlock())
                     aRaport['wyslano'] := aRaport['wyslano'] + 1
                     aPoz := hb_Hash()
                     aPoz['id'] := edeklar->id
                     aPoz['ok'] := .T.
                     aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
                     aPoz['refid'] := AllTrim(cRefId)
                     aPoz['statusopis'] := AllTrim(cStatusOpis)
                     aPoz['status'] := nStatus
                     AAdd(aRaport['pozycje'], aPoz)
                  ELSE
                     aRaport['niewyslano'] := aRaport['niewyslano'] + 1
                     aPoz := hb_Hash()
                     aPoz['ok'] := .F.
                     aPoz['id'] := edeklar->id
                     aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
                     aPoz['przyczyna'] := AllTrim(amiEdekBladTekst())
                     AAdd(aRaport['pozycje'], aPoz)
                  ENDIF
               ENDIF
            ELSE
               aRaport['niewyslano'] := aRaport['niewyslano'] + 1
               aPoz := hb_Hash()
               aPoz['ok'] := .F.
               aPoz['id'] := edeklar->id
               aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
               aPoz['przyczyna'] := 'Deklaracja nie jest podpisana lub jest ju¾ wysˆana.'
               AAdd(aRaport['pozycje'], aPoz)
            ENDIF
         NEXT
         edeklar->(dbGoto(nRecNo))
         ::aWybrane := {}
         ::oBrowser:refreshAll()
         ::RaportWysylki(aRaport)
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   ELSE
      IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK'

      ELSE
         ::lBramkaTestowa := .T.
         IF !::WybierzBramke(@::lBramkaTestowa)
            RETURN .F.
         ENDIF
      ENDIF
      IF !edeklar->podpisany
         komun('Deklaracja nie jest podpisana')
         RETURN .F.
      ENDIF
      IF !Empty(edeklar->wyslano) .AND. Len(AllTrim(edeklar->skrot)) > 0
         komun('Ta deklaracja zostaˆa ju¾ wysˆana')
         RETURN .F.
      ENDIF
      // TODO: Wybor bramki
      IF TNEsc(.F., 'Czy wysˆa† wybran¥ deklaracj©? (T/N)') == .F.
         RETURN .F.
      ENDIF
      IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK'
         nStatus := amiJpkWyslij( edekNazwaPliku(edeklar->id, '.xml.env.sig'), edeklar->test, @cRefId, @nRefLen )
         IF nStatus == 200
            blokadar('edeklar')
            edeklar->wyslano := hb_DateTime()
            edeklar->skrot := AllTrim( cRefId )
            //edeklar->status := Str(nStatus, 6, 0)
            edeklar->statopis := 'Dokument zostaˆ wysˆany'
            edeklar->(dbCommit())
            edeklar->(dbUnlock())
            aRaport['wyslano'] := aRaport['wyslano'] + 1
            aPoz := hb_Hash()
            aPoz['id'] := edeklar->id
            aPoz['ok'] := .T.
            aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
            aPoz['refid'] := AllTrim(cRefId)
            aPoz['statusopis'] := 'Dokument zostaˆ wysˆany'
            aPoz['status'] := nStatus
            AAdd(aRaport['pozycje'], aPoz)
            ::RaportWysylki(aRaport)
            RETURN .T.
         ELSE
            aRaport['niewyslano'] := aRaport['niewyslano'] + 1
            aPoz := hb_Hash()
            aPoz['ok'] := .F.
            aPoz['id'] := edeklar->id
            aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
            aPoz['przyczyna'] := AllTrim( amiEdekBladTekst() )
            AAdd( aRaport['pozycje'], aPoz )
            ::RaportWysylki(aRaport)
            RETURN .F.
        ENDIF
      ELSE
         IF amiEdekWyslij(edekNazwaPliku(edeklar->id, '.xml.sig'), ::lBramkaTestowa, edeklar->podpiscer, @cRefId, @nStatus, @cStatusOpis) = 0
            blokadar('edeklar')
            edeklar->wyslano := hb_DateTime()
            edeklar->skrot := cRefId
            edeklar->status := Str(nStatus, 6, 0)
            edeklar->statopis := cStatusOpis
            edeklar->test := ::lBramkaTestowa
            edeklar->(dbCommit())
            edeklar->(dbUnlock())
            ::oBrowser:refreshCurrent()
            aRaport['wyslano'] := 1
            aPoz['id'] := edeklar->id
            aPoz['ok'] := .T.
            aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
            aPoz['refid'] := AllTrim(cRefId)
            aPoz['statusopis'] := AllTrim(cStatusOpis)
            aPoz['status'] := nStatus
            AAdd(aRaport['pozycje'], aPoz)
            ::RaportWysylki(aRaport)
            RETURN .T.
         ELSE
            aRaport['niewyslano'] := 1
            aPoz['ok'] := .F.
            aPoz['id'] := edeklar->id
            aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
            aPoz['przyczyna'] := AllTrim(amiEdekBladTekst())
            AAdd(aRaport['pozycje'], aPoz)
            ::RaportWysylki(aRaport)
            RETURN .F.
         ENDIF
      ENDIF
   ENDIF
   RETURN

METHOD RaportWysylki(aDane) CLASS TEDeklaracje
   LOCAL cRes, nI
   cRes := 'Raport z wysyˆki eDeklaracji' + hb_eol()
   cRes := cRes + '----------------------------' + hb_eol() + hb_eol()
   cRes := cRes + 'Liczba wysˆanych dokument¢w:    ' + AllTrim(Str(aDane['wyslano'])) + hb_eol()
   cRes := cRes + 'Liczba niewysˆanych dokument¢w: ' + AllTrim(Str(aDane['niewyslano'])) + hb_eol() + hb_eol()
   FOR nI := 1 TO Len(aDane['pozycje'])
      cRes := cRes + '--------------------------------------' + hb_eol()
      cRes := cRes + 'Nr systemowy: ' + AllTrim(Str(aDane['pozycje'][nI]['id'])) + ;
         '   Rodzaj: ' + AllTrim(aDane['pozycje'][nI]['rodzaj']) + hb_eol()
      IF aDane['pozycje'][nI]['ok']
         cRes := cRes + 'Wysyˆano: TAK    Nr ref.: ' + aDane['pozycje'][nI]['refid'] + hb_eol()
         cRes := cRes + 'Status: ' + AllTrim(Str(aDane['pozycje'][nI]['status'])) + hb_eol()
         cRes := cRes + 'Opis: ' + aDane['pozycje'][nI]['statusopis'] + hb_eol()
      ELSE
         cRes := cRes + 'Wysyˆano: NIE' + hb_eol()
         cRes := cRes + 'Przyczyna niepowodzenia: ' + aDane['pozycje'][nI]['przyczyna'] + hb_eol()
      ENDIF
   NEXT
   WyswietlTekst(cRes)
   RETURN

METHOD PobierzUPO() CLASS TEDeklaracje
   LOCAL nI, nStatus, cStatusOpis, aPoz := hb_Hash(), nRecNo, nRes
   LOCAL aRaport := hb_Hash('pobrano', 0, 'niepobrano', 0, 'pozycje', {})
   ::CzyscAWybrane()
   ::lBramkaTestowa := edeklar->test
   IF Len(::aWybrane) > 0
      IF TNEsc(.F., 'Czy pora† UPO lub sprawdzi† status dla wybranych deklaracji? (liczba: ' + AllTrim(Str(Len(::aWybrane))) + ')  (T/N)')
         nRecNo := edeklar->(RecNo())
         FOR nI := 1 TO Len(::aWybrane)
            edeklar->(dbGoto(::aWybrane[nI]))
            IF !edeklar->jest_upo
               IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK'
                  nStatus := amiJpkPobierzUPO( AllTrim( edeklar->skrot ), edekNazwaPliku(edeklar->id, '.upo.xml'), ::lBramkaTestowa )
                  cStatusOpis := amiEdekBladTekst()
                  nRes := iif( nStatus >= 100 .AND. nStatus < 400, 0, 1 )
                  IF nRes == 0
                     blokadar('edeklar')
                     edeklar->status := Str(nStatus, 6, 0)
                     edeklar->statopis := cStatusOpis
                     IF nStatus == 200 .AND. File(edekNazwaPliku(edeklar->id, '.upo.xml'))
                        edeklar->jest_upo := .T.
                     ELSE
                        edeklar->jest_upo := .F.
                     ENDIF
                     edeklar->(dbCommit())
                     edeklar->(dbUnlock())
                     ::oBrowser:refreshCurrent()
                     aPoz := hb_Hash()
                     aPoz['ok'] := .T.
                     aPoz['id'] := edeklar->id
                     aPoz['jest_upo'] := edeklar->jest_upo
                     aPoz['refid'] := edeklar->skrot
                     aPoz['status'] := nStatus
                     aPoz['statusopis'] := cStatusOpis
                     aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
                     AAdd(aRaport['pozycje'], aPoz)
                     aRaport['pobrano'] := aRaport['pobrano'] + 1
                  ELSE
                     aRaport['niepobrano'] := aRaport['niepobrano'] + 1
                     aPoz['ok'] := .F.
                     aPoz['id'] := edeklar->id
                     aPoz['refid'] := AllTrim(edeklar->skrot)
                     aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
                     aPoz['przyczyna'] := AllTrim( amiEdekBladTekst() )
                     AAdd(aRaport['pozycje'], aPoz)
                  ENDIF
               ELSE
                  IF amiEdekPobierzUPO(AllTrim(edeklar->skrot), ::lBramkaTestowa, edekNazwaPliku(edeklar->id, '.upo.xml'), @nStatus, @cStatusOpis) == 0
                     blokadar('edeklar')
                     edeklar->status := Str(nStatus, 6, 0)
                     edeklar->statopis := cStatusOpis
                     IF nStatus == 200 .AND. File(edekNazwaPliku(edeklar->id, '.upo.xml'))
                        edeklar->jest_upo := .T.
                     ELSE
                        edeklar->jest_upo := .F.
                     ENDIF
                     edeklar->(dbCommit())
                     edeklar->(dbUnlock())
                     ::oBrowser:refreshCurrent()
                     aPoz := hb_Hash()
                     aPoz['ok'] := .T.
                     aPoz['id'] := edeklar->id
                     aPoz['jest_upo'] := edeklar->jest_upo
                     aPoz['refid'] := edeklar->skrot
                     aPoz['status'] := nStatus
                     aPoz['statusopis'] := cStatusOpis
                     aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
                     AAdd(aRaport['pozycje'], aPoz)
                     aRaport['pobrano'] := aRaport['pobrano'] + 1
                  ELSE
                     aRaport['niepobrano'] := aRaport['niepobrano'] + 1
                     aPoz['ok'] := .F.
                     aPoz['id'] := edeklar->id
                     aPoz['refid'] := AllTrim(edeklar->skrot)
                     aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
                     aPoz['przyczyna'] := AllTrim(amiEdekBladTekst())
                     AAdd(aRaport['pozycje'], aPoz)
                  ENDIF
               ENDIF
            ELSE
               aRaport['niepobrano'] := aRaport['niepobrano'] + 1
               aPoz['ok'] := .F.
               aPoz['id'] := edeklar->id
               aPoz['refid'] := AllTrim(edeklar->skrot)
               aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
               aPoz['przyczyna'] := 'UPO jest ju¾ pobrane.'
               AAdd(aRaport['pozycje'], aPoz)
            ENDIF
         NEXT
         edeklar->(dbGoto(nRecNo))
         ::aWybrane := {}
         ::oBrowser:refreshAll()
         ::RaportUPO(aRaport)
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   ELSE
      IF edeklar->jest_upo
         komun('UPO ju¾ zostaˆo pobrane dla tej deklaracji')
         RETURN .F.
      ENDIF
      IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK'
         nStatus := amiJpkPobierzUPO( AllTrim( edeklar->skrot ), edekNazwaPliku(edeklar->id, '.upo.xml'), ::lBramkaTestowa )
         cStatusOpis := amiEdekBladTekst()
         nRes := iif( nStatus >= 100 .AND. nStatus < 400, 0, 1 )
         IF nRes == 0
            blokadar('edeklar')
            edeklar->status := Str(nStatus, 6, 0)
            edeklar->statopis := cStatusOpis
            IF nStatus == 200 .AND. File( edekNazwaPliku( edeklar->id, '.upo.xml' ) )
               edeklar->jest_upo := .T.
            ELSE
               edeklar->jest_upo := .F.
            ENDIF
            edeklar->(dbCommit())
            edeklar->(dbUnlock())
            ::oBrowser:refreshCurrent()
            aPoz := hb_Hash()
            aPoz['ok'] := .T.
            aPoz['id'] := edeklar->id
            aPoz['jest_upo'] := edeklar->jest_upo
            aPoz['refid'] := edeklar->skrot
            aPoz['status'] := nStatus
            aPoz['statusopis'] := cStatusOpis
            aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
            AAdd(aRaport['pozycje'], aPoz)
            aRaport['pobrano'] := aRaport['pobrano'] + 1
            ::RaportUPO(aRaport)
            RETURN .T.
         ELSE
            aRaport['niepobrano'] := aRaport['niepobrano'] + 1
            aPoz['ok'] := .F.
            aPoz['id'] := edeklar->id
            aPoz['refid'] := AllTrim(edeklar->skrot)
            aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
            aPoz['przyczyna'] := AllTrim( amiEdekBladTekst() )
            AAdd(aRaport['pozycje'], aPoz)
            ::RaportUPO(aRaport)
            RETURN .F.
         ENDIF
      ELSE
         IF amiEdekPobierzUPO(AllTrim(edeklar->skrot), ::lBramkaTestowa, edekNazwaPliku(edeklar->id, '.upo.xml'), @nStatus, @cStatusOpis) == 0
            blokadar('edeklar')
            edeklar->status := Str(nStatus, 6, 0)
            edeklar->statopis := cStatusOpis
            IF nStatus == 200 .AND. File(edekNazwaPliku(edeklar->id, '.upo.xml'))
               edeklar->jest_upo := .T.
            ELSE
               edeklar->jest_upo := .F.
            ENDIF
            aRaport['pobrano'] := 1
            edeklar->(dbCommit())
            edeklar->(dbUnlock())
            ::oBrowser:refreshCurrent()
            aPoz := hb_Hash()
            aPoz['ok'] := .T.
            aPoz['id'] := edeklar->id
            aPoz['jest_upo'] := edeklar->jest_upo
            aPoz['refid'] := edeklar->skrot
            aPoz['status'] := nStatus
            aPoz['statusopis'] := cStatusOpis
            aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
            AAdd(aRaport['pozycje'], aPoz)
            ::RaportUPO(aRaport)
            RETURN .T.
         ELSE
            aRaport['niepobrano'] := 1
            aPoz['ok'] := .F.
            aPoz['id'] := edeklar->id
            aPoz['refid'] := AllTrim(edeklar->skrot)
            aPoz['rodzaj'] := AllTrim(edeklar->rodzaj)
            aPoz['przyczyna'] := AllTrim(amiEdekBladTekst())
            AAdd(aRaport['pozycje'], aPoz)
            ::RaportUPO(aRaport)
            RETURN .F.
         ENDIF
      ENDIF
   ENDIF

   RETURN

METHOD RaportUPO(aDane) CLASS TEDeklaracje
   LOCAL cRes, nI
   cRes := 'Raport odbioru UPO' + hb_eol()
   cRes := cRes + '------------------' + hb_eol()
   cRes := cRes + 'Liczba pobranych UPO: ' + AllTrim(Str(aDane['pobrano'])) + hb_eol()
   cRes := cRes + 'Liczba niepobranych UPO: ' + AllTrim(Str(aDane['niepobrano'])) + hb_eol()
   FOR nI := 1 TO Len(aDane['pozycje'])
      cRes := cRes + '--------------------------------------' + hb_eol()
      cRes := cRes + 'Nr systemowy: ' + AllTrim(Str(aDane['pozycje'][nI]['id'])) + ;
         '   Rodzaj: ' + AllTrim(aDane['pozycje'][nI]['rodzaj']) + hb_eol()
      cRes := cRes + 'Nr ref.: ' + aDane['pozycje'][nI]['refid'] + hb_eol()
      IF aDane['pozycje'][nI]['ok']
         cRes := cRes + 'Pobrano UPO: ' + iif(aDane['pozycje'][nI]['jest_upo'], 'TAK', 'NIE') + hb_eol()
         cRes := cRes + 'Status: ' + AllTrim(Str(aDane['pozycje'][nI]['status'])) + hb_eol()
         cRes := cRes + 'Opis: ' + aDane['pozycje'][nI]['statusopis'] + hb_eol()
      ELSE
         cRes := cRes + 'Nie pobrano statusu dokumentu.' + hb_eol()
         cRes := cRes + 'Przyczyna niepowodzenia: ' + aDane['pozycje'][nI]['przyczyna'] + hb_eol()
      ENDIF
   NEXT
   WyswietlTekst(cRes)
   RETURN

METHOD Informacje() CLASS TEDeklaracje
   LOCAL cRes := ''
   cRes := 'Nr systemowy: ' + AllTrim(Str(edeklar->id)) + hb_eol()
   cRes := cRes + 'Rodzaj: ' + AllTrim(edeklar->rodzaj) + hb_eol()
   cRes := cRes + 'Utworzono: ' + DToC(edeklar->wyslano) + hb_eol()
   cRes := cRes + 'Wysˆano: ' + DToC(edeklar->wyslano) + hb_eol()
   cRes := cRes + 'Nr ref.: ' + AllTrim(edeklar->skrot) + hb_eol()
   cRes := cRes + 'Status: ' + AllTrim(edeklar->status) + hb_eol()
   cRes := cRes + 'Opis: ' + AllTrim(edeklar->statopis) + hb_eol()
   WyswietlTekst(cRes)
   RETURN

METHOD Pomoc() CLASS TEDeklaracje
   LOCAL aPomoc := { ;
      '                                                                        ',;
      '    [Spacja] lub [Enter] ................. Zaznacz / odznacz pozycj©    ',;
      '    [O] .................................. Odznacz wszystkie pozycje    ',;
      '    [N] ....................................... Zaznacz niepodpisane    ',;
      '    [M] ......................................... Zaznacz niewysˆane    ',;
      '    [B] ................................. Zaznacz deklaracje bez UPO    ',;
      '    [C] .......................................... Wyb¢r certyfikatu    ',;
      '    [P] ...... Podpisz zaznaczone deklaracje podpisem kwalifikowanym    ',;
      '    [L] ........ Podpisz zaznaczone deklaracje danymi autoryzuj¥cymi    ',;
      '    [W] ............................... Wy˜lij zaznaczone deklaracje    ',;
      '    [U] ....... Pobierz UPO / sprawd« status zaznaczonych deklaracji    ',;
      '    [D] .......................................... Wydruk deklaracji    ',;
      '    [F] .................... Wydruk Urz©dowego Po˜wiadczenia Odbioru    ',;
      '    [E] ......... Eksport - zapis deklaracji do wskazanego pliku XML    ',;
      '    [J] .................... Edytuj plik JPK w zewn©trznym programie    ',;
      '    [Delete] .................................. Usuni©cie deklaracji    ',;
      '                                                                        ',;
      '    Kolumna "Info"                                                      ',;
      '      * ................................................. Zaznaczony    ',;
      '      P .................................................. Podpisany    ',;
      '      K .................................................... Korekta    ',;
      '      W/T.............................. Wysˆany (T - bramka testowa)    ',;
      '      U ................................................ Pobrano UPO    ',;
      '                                                                        '}
   WyswietlPomoc(aPomoc)
   RETURN

METHOD WybierzBramke(lRezultat) CLASS TEDeklaracje
   LOCAL nRes, cColor
   cColor := ColInf()
   nRes := Alert('Wybierz bramk© do kt¢rej wysˆa† deklaracje', {'Bramka testowa', 'Bramka PRODUKCYJNA', 'Anuluj'}, CColInf)
   SetColor(cColor)
   DO CASE
      CASE nRes == 0
         RETURN .F.
      CASE nRes == 1
         lRezultat := .T.
         RETURN .T.
      CASE nRes == 2
         IF TNEsc(.F., 'Czy wysˆa† deklaracje do bramki produkcyjnej? (T/N)')
            lRezultat := .F.
            RETURN .T.
         ELSE
            RETURN .F.
         ENDIF
      CASE nRes == 3
         RETURN .F.
   ENDCASE
   RETURN .F.

METHOD DrukujDeklaracje() CLASS TEDeklaracje
   Drukuj_DeklarXML(edekNazwaPliku(edeklar->id, '.xml'), AllTrim(edeklar->rodzaj), AllTrim(edeklar->skrot))
   RETURN

METHOD DrukujUPO() CLASS TEDeklaracje
   IF !edeklar->jest_upo .OR. !File(edekNazwaPliku(edeklar->id, '.upo.xml'))
      komun('UPO nie jest pobrane.')
   ENDIF
   Drukuj_DeklarXML(edekNazwaPliku(edeklar->id, '.upo.xml'), 'UPO')
   RETURN

METHOD Eksport() CLASS TEDeklaracje

   LOCAL cPlik

   IF ( cPlik := win_GetSaveFileName( , , , 'xml', { {'Pliki XML', '*.xml'}, {'Wszystkie pliki', '*.*'} }, , , ;
      AllTrim( edeklar->rodzaj ) ) ) <> ''

      __CopyFile( edekNazwaPliku(edeklar->id, '.xml'), cPlik )
      Komun( 'Plik zapisano' )
   ENDIF

   RETURN .F.

METHOD UruchomGMJPK() CLASS TEDeklaracje

   IF Upper( SubStr( edeklar->rodzaj, 1, 3 ) ) == 'JPK'
      IF ! edeklar->podpisany
         //hb_run( 'gmjpk.exe "' + edekNazwaPliku( edeklar->id, '.xml' ) + '"' )
         wapi_ShellExecute( NIL, "open", "gmjpk.exe", edekNazwaPliku( edeklar->id, '.xml' ) )
      ELSE
         Komun( 'Ten dokument zostˆ podpisany. Nie mo¾na edytowa† tego dokumentu.' )
      ENDIF
   ELSE
      Komun( 'To nie jest plik JPK' )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION PokazEDeklaracje()
   LOCAL oEdek, cScr
   SAVE SCREEN TO cScr
   oEdek := TEDeklaracje():New()
   oEdek:Uruchom()
   RESTORE SCREEN FROM cScr
   RETURN

/*----------------------------------------------------------------------*/


