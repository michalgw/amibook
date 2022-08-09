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

#include "achoice.ch"
#include "inkey.ch"
#include "set.ch"

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± CZEKAJ   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// Wyswietla komunikat "Porsze czekac"
PROCEDURE Czekaj()

   LOCAL CURR

   CURR := ColInb()
   @ 24, 0 CLEAR
   center( 24, 'Prosz&_e. czeka&_c....' )
   SetColor( CURR )

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± APPEND_  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Funkcja nie chyba uzywana
FUNCTION append_()

   DOPAP()

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± REPL_    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION repl_( _pole, _wartosc )

   REPLACE &_pole WITH _wartosc

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ZAP_     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION zap_()

   ZAP

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ZERO_    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Funkcja dokonuje zerowania pol ustawionego rekordu bazy danych poczawszy  ±
*±od podanego numeru pola.                                                  ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION zero_( _i )

   LOCAL _zm

   DO WHILE Field( _i )#[]
      _zm := Field( _i )
      DO CASE
      CASE Type( _zm ) == 'C'
         repl_( _zm, '' )
      CASE Type( _zm ) == 'N'
         repl_( _zm, 0 )
      CASE Type( _zm ) == 'D'
         repl_( _zm, ctod( '    .  .  ' ) )
      CASE Type( _zm ) == 'L'
         repl_( _zm, .F. )
      ENDCASE
      _i := _i + 1
   ENDDO

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± COMMIT_  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Bez parametru zapisuje bufory wszystkich otwartych baz danych. Z podanym  ±
*±parametrem zapisuje tylko wymienione np. commit_([dowody,kat_sym,analit]) ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION commit_( _char )

   LOCAL _alias, _i, _j, _zm

   _alias := Alias()

   IF ValType( _char ) == 'U'
      FOR _i := 1 TO 250
         SELECT ( _i )
         IF Used()
            COMMIT
         ENDIF
      NEXT
   ELSE
      STORE 1 TO _i, _j
      DO WHILE _j#0
         _j := At( ',', SubStr( _char, _i ) )
         _zm := iif( _j#0, SubStr( _char, _i, _j - 1 ), SubStr( _char, _i ) )
         _i := _i + _j
         SELECT &_zm
         COMMIT
      ENDDO
   ENDIF

   SELECT &_alias

   // Zmienna 'awaria' prawdopodobnie nieuzywana
   awaria := .F.

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± CLOSE_   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION close_()

   CLOSE DATA
   awaria := .F.
   SELECT 1

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± READ_    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Komenda READ z wylaczonymi przyciskami Ctrl+End,Ctrl+W,Ctrl+C,PgUp,PgDn   ±
*±oraz wlaczonym kursorem.                                                  ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION read_( aGetList )

   IF HB_ISARRAY( aGetList )
      PRIVATE GetList := aGetList
   ENDIF

   SET CURSOR ON

   SET KEY K_PGDN TO non
   SET KEY K_PGUP TO non

   READ

   SET KEY K_PGDN TO
   SET KEY K_PGUP TO

   SET CURSOR OFF

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± NON      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Procedura nic nie robi.                                                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE non()

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± MENU ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Funkcja wylacza dzialanie przyciskow PgUp i PgDn w komendzie MENU TO oraz ±
*±powoduje dzialanie menu przy wcisnietym Num Lock.                         ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION menu( _opcja )

   SET KEY K_PGUP TO men
   SET KEY K_PGDN TO men
   SetKey( K_RBUTTONUP,  {|| ft_PutKey( K_ESC ) }  )
   SetKey( K_MWFORWARD,  {|| ft_PutKey( K_UP ) } )
   SetKey( K_MWBACKWARD, {|| ft_PutKey( K_DOWN ) } )

   MENU TO _opcja

   SET KEY K_PGUP TO
   SET KEY K_PGDN TO
   SET KEY K_RBUTTONUP TO
   SET KEY K_MWFORWARD TO
   SET KEY K_MWBACKWARD TO

   RETURN _opcja

*************
// Klawisze menu
// TODO: Do usuniecia bo puste?
PROCEDURE men()

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PAUSE    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Zatrzymanie wykonywania programu na czas okreslony w sekundach. Czas rowny±
*±zero oznacza czas do nacisniecia dowolnego przycisku. Jesli nie zostanie  ±
*±nacisniety zaden przycisk to funkcja ustawia lastkey() na zero.           ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION pause( _czas )

   LOCAL _aa

   _aa := Seconds() + _czas
   KEYBOARD Chr( 0 )
   Inkey( , INKEY_KEYBOARD )
   DO WHILE ( Seconds() <= _aa .OR. _czas == 0 ) .AND. Inkey( 1, INKEY_KEYBOARD ) == 0
   ENDDO

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± APP      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Tworzenie nowego rekordu w bazie poindeksowanej wg pola del. UWAGA! Pozo- ±
*±stale pola stworzonego rekordu moga byc wypelnione.                       ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION app()

   GO BOTTOM
   IF del == '+' .OR. Eof()
      DOPAP()
   ENDIF
   BLOKADAR()
   zero_( 3 )
   repl_( 'del', '+' )

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DEL      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Kasowanie rekordu w poindeksowanym wg pola del. Jesli mozliwe to zostanie ±
*±ustawiony rekord nastepny, jesli nie to poprzedni. Jesli nie jest istotne ±
*±ustawienie rekordu po sksowaniu to lepiej uzyc komendy  REPL_([DEL],[-])  ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION del()

   DELETE

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± CENTER   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Dla podanej wspolrzednej wiersza wyswietla tekst w jego srodku.           ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION center( _row, _tekst )

   @ _row, ( 80 - Len( _tekst ) ) / 2 SAY _tekst

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± KOM      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla przez podany czas w sekundach z podanym atrybutem komunikat w   ±
*±srodku dolnej linii ekranu. Czas rowny zero oznacza czs do przycisniecia  ±
*±dowolnego przycisku. Jesli nie zostanie nacisniety zaden przycisk to fun- ±
*±kcja ustawia lastkey() na zero.                                           ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION kom( _czas, _atryb, _tekst )

   LOCAL CURR

   CURR := ColInf()
   @ 24, 0
   center( 24, _tekst )
   SetColor( CURR )
   IF param_dzw == 'T'
      Tone( 700, 1 )
      Tone( 500, 4 )
   ENDIF
   pause( _czas )
   @ 24, 0

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± TNESC    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla w srodku dolnej linii ekranu komunikat do momentu nacisniecia   ±
*±klawiszy T,N,Esc.                                                         ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION tnesc( _atryb, _tekst )

   LOCAL CURR

   CURR := ColErr()
   @ 24, 0
   center( 24, _tekst )
   IF param_dzw == 'T'
      Tone( 700, 3 )
      Tone( 700, 3 )
   endif
   CLEAR TYPE
   DO WHILE ! Str( Inkey( 0 ), 3 )$'116, 84,110, 78, 27'
   ENDDO
   ColStd()
   @ 24, 0
   SetColor( CURR )
   IF ValType( _atryb ) == 'L' .AND. _atryb == .T.
      RETURN LastKey()
   ELSE
      RETURN LastKey() == Asc( 't' ) .OR. LastKey() == Asc( 'T' )
   ENDIF

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ENTESC   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla w srodku dolnej linii ekranu komunikat do momentu nacisniecia   ±
*±klawiszy Enter lub Esc.                                                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION entesc( _atryb, _tekst )

   LOCAL CURR

   CURR := ColInb()
   @ 24, 0
   center( 24, _tekst )
   SET COLOR TO
   IF param_dzw == 'T'
      Tone( 700, 3 )
      Tone( 700, 3 )
   ENDIF
   CLEAR TYPE
   DO WHILE ! Str( Inkey( 0 ), 3 )$' 13, 27'
   ENDDO
   ColStd()
   @ 24, 0
   SetColor( CURR )

   RETURN LastKey() == K_ENTER

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± CLS      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±W efektowny sposob od srodka czysci okno o wymiarach y1,x1,x2,x2, efektem ±
*±jest powiekszajaca sie ramka ze znakiem podanym jako ostatni parametr.    ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Funkcja nie uzywana DO wywalenia?
FUNCTION cls( _y1, _x1, _y2, _x2, _char )

   LOCAL _aa, _b, _c, _d, _i

   _char := iif( ValType( _char ) == 'U', ' ', _char )

   IF _y2 - _y1 < _x2 - _x1
      _aa := ( _y1 + _y2 ) / 2
      _b := _aa + 0.5
      _c := _x1 + Int( _aa - _y1 )
      _d := _x2 - Int( _aa - _y1 )
   ELSE
      _c := ( _x1 + _x2 ) / 2
      _d := _c + 0.5
      _aa := _y1 + Int( _c - _x1 )
      _b := _y2 - Int( _c - _x1 )
   ENDIF
   DO WHILE _aa >= _y1
      @ _aa, _c, _b, _d box( repl( _char , 8 ) + ' ' )
      _aa := _aa - 1
      _b := _b + 1
      _c := _c - 1
      _d := _d + 1
      _i := 0
      DO WHILE _i < 35
         _i := _i + 1
      ENDDO
   ENDDO

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DTOC_    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Zamienia wartosc typu data na lancuch oraz kropki na kreski.              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// Funkcja uzyta tylko w jednym miejscu funkcji 'status'
FUNCTION dtoc_( _data )

   RETURN iif( Empty( _data ), '          ', StrTran( DToC( _data ), '.', '-' ) )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± LOS      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Podaje liczbe pseudolosowa z przedzialu [0...1)                           ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Prawdopodobnie nie uzywana
FUNCTION los()

   IF Type( '_los___los' ) == 'U'
      PUBLIC _los___los
      _los___los := 0.6324653256
   ENDIF
   _los___los := 997 * _los___los - Int( 997 * _los___los )

   RETURN _los___los

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DOS_P    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±W lancuchu koncowe spacje wstawia na poczatek.                            ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION dos_p( _char )

   LOCAL _aa

   _aa := Len( _char )
   _char := RTrim( _char )

   RETURN Space( _aa - Len( _char ) ) + _char

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DOS_L    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±W lancuchu poczatkowe spacje wstawia na koniec.                           ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION dos_l( _char )

   LOCAL _aa

   _aa := Len( _char )
   _char := LTrim( _char )

   RETURN _char + Space( _aa - Len( _char ) )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DOS_C    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Centruje tekst w lancuchu.                                                ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION dos_c( _char )

   LOCAL _aa

   _aa := Len( _char )
   _char := AllTrim( _char )

   RETURN Space( ( _aa - Len( _char ) ) / 2 ) + _char + Space( ( _aa - Len( _char ) + 1 ) / 2 )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± KWOTA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Podaje lancuch zawierajacy liczbe calkowita ze spacjami co trzy cyfry     ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION kwota( _liczba, _width, _dec, _pole )

   LOCAL _zm,_i,_j

   _dec := iif( ValType( _dec ) == 'U', 0, _dec )
   _pole := iif( ValType( _pole ) == 'U', 0, _pole )
   IF _pole == 1 .AND. _liczba == 0
      RETURN Space( _width )
   ENDIF
   IF _pole == 2 .AND. _liczba == 0
     _zm := Space( _width / 3 ) + repl( 'Ä', _width / 3 ) + Space( _width / 3 )
      RETURN Space( _width - Len( _zm ) ) + _zm
   ENDIF
   _width := iif( _dec#0, _width - _dec - 1, _width )
   _liczba := LTrim( Str( _liczba, 19, _dec ) )
   _dec := Right( _liczba, _dec )
   _liczba := iif( _dec#'', Left( _liczba, At( '.', _liczba ) - 1 ), _liczba )
   _i := Mod( Len( _liczba ), 3 )
   _zm := Left( _liczba, _i )
   FOR _j := _i + 1 TO Len( _liczba ) - 2 STEP 3
     _zm := _zm + ' ' + SubStr( _liczba, _j, 3 )
   NEXT
   _zm := LTrim( StrTran( _zm, '- ', '-' ) )

   RETURN Space( _width - Len( _zm ) ) + _zm + iif( _dec#'', '.' + _dec, '' )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DZIEN    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Dla zadanej daty podaje nazwe dnia tygodnia po polsku.                    ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION dzien( _data )

   RETURN MemoLine( 'Niedziela   Poniedzia&_l.ekWtorek      &__S.roda       Czwartek    Pi&_a.tek      Sobota      ', 12, DoW( _data ) )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± MIESIAC  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Dla zadanej cyfry podaje nazwe miesiaca po polsku.                        ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION miesiac( _cyfra )

   RETURN MemoLine( 'Stycze&_n.    Luty       Marzec     Kwiecie&_n.   Maj        Czerwiec   Lipiec     Sierpie&_n.   Wrzesie&_n.   Pa&_x.dziernikListopad   Grudzie&_n.   ', 11, _cyfra )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± MSC      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Dla zadanej cyfry podaje ilosc dni w miesiacu (dla cyfry 2 podaje 29)     ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION msc( _cyfra )

   RETURN Val( SubStr( '312931303130313130313031', _cyfra * 2 - 1, 2 ) )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± WYBOR    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Funkcja do obslugi operacji na bazach danych.                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION wybor( _row )

   LOCAL _nr_rec, _i, _kl, _linia

   _i := _top + '.or.' + _bot
   IF Left( _esc, 1 )#','
      _esc := ',' + _esc + ','
      _cls := iif( _cls == '', SaveScreen( _row_g, _col_l, _row_d + 1, _col_p ), _cls )
   ENDIF
   IF &_i
      _kl := Inkey()
      RETURN -1
   ELSE
      _row := disp( _row )
      _disp := .T.
   ENDIF
   IF _invers#''
      @ _row, _col_l SAY _linia
      _linia := &_proc
   ELSE
      @ _row, _curs_l SAY ' '
      @ _row, _curs_p SAY ' '
   ENDIF
   IF _invers == ''
      _linia := &_proc
   ENDIF
   @ _row, _col_l SAY iif( _invers == '', _linia, '' )
   IF _proc_spe#''
      DO &_proc_spe
   ENDIF
   IF _invers#''
      SET COLOR TO ( _invers )
      @ _row, _col_l SAY _linia
   ELSE
      @ _row, _curs_l SAY Chr( 16 )
      @ _row, _curs_p SAY Chr( 17 )
   ENDIF
   SET COLOR TO
   DO WHILE .T.
      _kl := Inkey( 0 )
      DO CASE
      CASE ',' + LTrim( Str( _kl ) ) + ','$_esc
         RETURN _row
      CASE _kl == 5 .OR. _kl == 56 .OR. _kl == K_MWFORWARD
         _nr_rec := RecNo()
         _linia := &_proc
         SKIP -1
         IF Bof() .OR. &_top
            GO _nr_rec
         ELSE
            IF _invers#''
               @ _row, _col_l SAY _linia
               _linia := &_proc
            ELSE
               @ _row, _curs_l SAY ' '
               @ _row, _curs_p SAY ' '
            ENDIF
            IF _row == _row_g
               IF _invers == ''
                  _linia := &_proc
               ENDIF
               Scroll( _row_g, _col_l, _row_d, _col_p, -1 )
               @ _row, _col_l SAY iif( _invers == '', _linia, '' )
            ELSE
               _row := _row - 1
            ENDIF
            IF _proc_spe#''
               DO &_proc_spe
            ENDIF
            IF _invers#''
               SET COLOR TO ( _invers )
               @ _row, _col_l SAY _linia
            ELSE
               @ _row, _curs_l SAY Chr( 16 )
               @ _row, _curs_p SAY Chr( 17 )
            ENDIF
            SET COLOR TO
         ENDIF
         CLEAR TYPE
      CASE _kl == K_DOWN .OR. _kl == Asc( '2' ) .OR. _kl == K_MWBACKWARD
         _nr_rec := RecNo()
         _linia := &_proc
         SKIP
         IF &_bot
            GO _nr_rec
         ELSE
            IF _invers#''
               @ _row, _col_l SAY _linia
               _linia := &_proc
            ELSE
               @ _row, _curs_l SAY ' '
               @ _row, _curs_p SAY ' '
            ENDIF
            IF _row == _row_d
               IF _invers == ''
                  _linia := &_proc
               ENDIF
               scroll( _row_g, _col_l, _row_d, _col_p, 1 )
               @ _row, _col_l SAY iif( _invers == '', _linia, '' )
            ELSE
               _row := _row + 1
            ENDIF
            IF _proc_spe#''
               DO &_proc_spe
            ENDIF
            IF _invers#''
               SET COLOR TO ( _invers )
               @ _row, _col_l SAY _linia
            ELSE
               @ _row, _curs_l SAY Chr( 16 )
               @ _row, _curs_p SAY Chr( 17 )
            ENDIF
            SET COLOR TO
         ENDIF
         CLEAR TYPE
      CASE _kl == K_PGUP .OR. _kl == Asc( '9' )
         _nr_rec := RecNo()
         SKIP _row_g - _row - 1
         IF Bof() .OR. &_top
            GO _nr_rec
         ELSE
            IF _invers#''
               @ _row, _col_l SAY _linia
            ELSE
               @ _row, _curs_l SAY ' '
               @ _row, _curs_p SAY ' '
            ENDIF
            SKIP _row_g - _row_d
            DO WHILE &_top
               SKIP
            ENDDO
            _row := disp( _row_g )
         ENDIF
      CASE _kl == K_PGDN .OR. _kl == Asc( '3' )
         _nr_rec := RecNo()
         SKIP _row_d - _row + 1
         IF &_bot
            GO _nr_rec
         ELSE
            IF _invers#''
               @ _row, _col_l SAY _linia
            ELSE
               @ _row, _curs_l SAY ' '
               @ _row, _curs_p SAY ' '
            ENDIF
            _row := disp( _row_g )
         ENDIF
      CASE _kl == K_HOME .OR. _kl == Asc( '7' )
         _nr_rec := RecNo()
         SEEK _stop
         IF RecNo()#_nr_rec
            IF _invers#''
               @ _row, _col_l SAY _linia
            ELSE
               @ _row, _curs_l SAY ' '
               @ _row, _curs_p SAY ' '
            ENDIF
            _row := disp( _row_g )
         ENDIF
      CASE _kl == K_END .OR. _kl == Asc( '1' )
         _nr_rec := RecNo()
         SEEK _sbot
         SKIP -1
         IF RecNo()#_nr_rec
            IF _invers#''
               @ _row, _col_l SAY _linia
            ELSE
               @ _row,_curs_l SAY ' '
               @ _row,_curs_p SAY ' '
            ENDIF
            _row := disp( _row_d )
         ENDIF
      CASE _kl == K_LBUTTONDOWN
         IF MRow() >= _row_g .AND. MRow() <= _row_d .AND. MCol() >= _col_l .AND. MCol() <= _col_p ;
            .AND. MRow() <> _row
            _nr_rec := RecNo()
            SKIP MRow() - _row
            IF &_bot
               GO _nr_rec
            ELSE
               IF _invers#''
                  @ _row, _col_l SAY _linia
               ELSE
                  @ _row, _curs_l SAY ' '
                  @ _row, _curs_p SAY ' '
               ENDIF
               _row := disp( MRow() )
            ENDIF
         ENDIF
      ENDCASE

      IF _kl == K_END .OR. _kl == Asc( '1' ) .OR. _kl == K_HOME .OR. _kl == Asc( '7' ) ;
         .OR. _kl == K_PGDN .OR. _kl == Asc( '3' ) .OR. _kl == K_PGUP .OR. _kl == Asc( '9' )

         IF _invers#''
            @ _row, _col_l SAY _linia
            _linia := &_proc
         ELSE
            @ _row, _curs_l SAY ' '
            @ _row, _curs_p SAY ' '
         ENDIF
         IF _invers == ''
            _linia := &_proc
         ENDIF
         @ _row, _col_l SAY iif( _invers == '', _linia, '' )
         IF _proc_spe#''
            DO &_proc_spe
         ENDIF
         IF _invers#[]
            SET COLOR TO ( _invers )
            @ _row, _col_l SAY _linia
         ELSE
            @ _row, _curs_l SAY Chr( 16 )
            @ _row, _curs_p SAY Chr( 17 )
         ENDIF
         SET COLOR TO
      ENDIF
   ENDDO

   RETURN NIL

*************
FUNCTION disp( _row )

   LOCAL _nr_rec, _memo, _i, _rec

   STORE &_proc TO _linia, _memo

   IF _disp
      _nr_rec := RecNo()
      *------------
      FOR _i := 1 TO _row_d - _row
         SKIP
         IF &_bot
            EXIT
         ENDIF
         _memo := _memo + &_proc
      NEXT
      _rec := RecNo()
      GO _nr_rec
      FOR _row := _row_g TO _row_d - _i
         SKIP -1
         IF Bof() .OR. &_top
            EXIT
         ENDIF
         _memo := &_proc + _memo
      NEXT
      IF _i + _row <= _row_d
         GO _rec
         FOR _i := _row + _i TO _row_d
            SKIP
            IF &_bot
               EXIT
            ENDIF
            _memo := _memo + &_proc
         NEXT
      ELSE
         _i := _row_d + 1
      ENDIF
      *------------
      RestScreen( _i, _col_l, _row_d + 1, _col_p, SubStr( _cls, ( _i - _row_g ) * ;
         ( _col_p - _col_l + 1 ) * 2 + 1, ( _row_d - _row_g + 2 ) * ( _col_p - _col_l + 1 ) * 2 + 1 ) )
      CLEAR TYPE
      FOR _rec := _row_g TO _i - 1
         @ _rec, _col_l SAY SubStr( _memo, 1 + ( _rec - _row_g ) * ( _col_p - _col_l + 1 ), _col_p - _col_l + 1 )
      NEXT
      GO _nr_rec
   ENDIF
   IF _proc_spe#[]
      DO &_proc_spe
   ENDIF
   SET COLOR TO (_invers)
   @ _row, _col_l SAY _linia
   IF _invers == ''
      @ _row, _curs_l SAY Chr( 16 )
      @ _row, _curs_p SAY Chr( 17 )
   ENDIF
   SET COLOR TO

   RETURN _row

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± STER     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Procedura dokonujaca wyboru rekordu w bazie danych za pomoca przyciskow   ±
*±PgUp,PgDn,Home,End.                                                       ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE ster()

   LOCAL nr_rec

   DO CASE
   CASE kl == K_PGUP .OR. kl == Asc( '9' ) .OR. kl == K_MWFORWARD
      nr_rec := RecNo()
      SKIP -1
      IF Bof() .OR. &_top
         GO nr_rec
      ELSE
         DO &_proc
      ENDIF
   CASE kl == K_PGDN .OR. kl == Asc( '3' ) .OR. kl == K_MWBACKWARD
      nr_rec := RecNo()
      SKIP
      IF &_bot
         GO nr_rec
      ELSE
         DO &_proc
      ENDIF
   CASE kl == K_HOME .OR. kl == Asc( '7' )
      nr_rec := RecNo()
      SEEK _stop
      IF RecNo()#nr_rec
         DO &_proc
      ENDIF
   CASE kl == K_END .OR. kl == Asc( '1' )
      nr_rec := RecNo()
      SEEK _sbot
      SKIP -1
      IF RecNo()#nr_rec
         DO &_proc
      ENDIF
   ENDCASE

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± HASLO    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Podaje wartosc logiczna .t. dla poprawnie wpisanego hasla.                ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION haslo( _haslo )

   LOCAL _h,_i

   _h := ''
   _i := 0
   CLEAR TYPE
   DO WHILE Len( _h ) < Len( _haslo ) .AND. _i#K_ENTER .AND. _i#K_ESC
      _i := Inkey( 0 )
      _h := _h + iif( _i == 0 .OR. _i == K_ESC, '', Chr( _i ) )
   ENDDO

   RETURN Lower( _h ) == Lower( _haslo )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ODMIANA  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Dla trzech mozliwych odmian wyrazu podaje taka odmiane, ktora odpowiada   ±
*±podanej liczbie.                                                          ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Funkcja nie uzywana do usuniecia
FUNCTION odmiana( _liczba, _odmiana1, _odmiana2, _odmiana3 )

   IF _liczba <= 0 .OR. _liczba > 999
      RETURN ''
   ENDIF
   _liczba := StrTran( Str( _liczba, 3 ), ' ', '0' )

   RETURN iif( _liczba == '001', _odmiana1, iif( Right( _liczba, 1 )$'234' .AND. SubStr( _liczba, 2, 1 )#'1', _odmiana2, _odmiana3 ) )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± SLOWNIE  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Funkcja podaje slowne przedstawienie liczby w postaci tekstu. Liczba po-  ±
*±winna zawierac sie w przedziale [1...999 999 999 999 999]. Maksymalna dlu-±
*±gosc tekstu wynosi 225.                                                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION slownie( ILE, JAKWYZEJ )

   LOCAL _cliczba, _liczba, _k1, _k2, _k3, _k4, _k5
   LOCAL GROSZE, slownie, rcyfr
   LOCAL bln, mld, mln, tys, jed, gro, mld1, mln1, tys1
   LOCAL jed1, gro1, mld2, mln2, tys2, jed2, gro2

   IF PCount() == 1
      JAKWYZEJ := .F.
   ENDIF

   GROSZE := ile - _int( ile )

   slownie := ''
   rcyf := Array( 4, 9 )
   _liczba := 0
   _cliczba := '            '
   _k1 := 'na&_s.cie'
   _k2 := 'dzie&_s.ci'
   _k3 := 'dziesi&_a.t'
   _k4 := 'set'
   _k5 := 'sta'
   rcyf[ 1, 1 ] := 'jeden'
   rcyf[ 1, 2 ] := 'dwa'
   rcyf[ 1, 3 ] := 'trzy'
   rcyf[ 1, 4 ] := 'cztery'
   rcyf[ 1, 5 ] := 'pi&_e.&_c.'
   rcyf[ 1, 6 ] := 'sze&_s.&_c.'
   rcyf[ 1, 7 ] := 'siedem'
   rcyf[ 1, 8 ] := 'osiem'
   rcyf[ 1, 9 ] := 'dziewi&_e.&_c.'
   rcyf[ 2, 1 ] := rcyf[ 1, 1 ] + 'a&_s.cie'
   rcyf[ 2, 2 ] := rcyf[ 1, 2 ] + _k1
   rcyf[ 2, 3 ] := rcyf[ 1, 3 ] + _k1
   rcyf[ 2, 4 ] := 'czter' + _k1
   rcyf[ 2, 5 ] := 'pi&_e.t' + _k1
   rcyf[ 2, 6 ] := 'szes' + _k1
   rcyf[ 2, 7 ] := rcyf[ 1, 7 ] + _k1
   rcyf[ 2, 8 ] := rcyf[ 1, 8 ] + _k1
   rcyf[ 2, 9 ] := 'dziewi&_e.t' + _k1
   rcyf[ 3, 1 ] := 'dziesi&_e.&_c.'
   rcyf[ 3, 2 ] := rcyf[ 1, 2 ] + 'dzie&_s.cia'
   rcyf[ 3, 3 ] := rcyf[ 1, 3 ] + _k2
   rcyf[ 3, 4 ] := 'czter' + _k2
   rcyf[ 3, 5 ] := rcyf[ 1, 5 ] + _k3
   rcyf[ 3, 6 ] := rcyf[ 1, 6 ] + _k3
   rcyf[ 3, 7 ] := rcyf[ 1, 7 ] + _k3
   rcyf[ 3, 8 ] := rcyf[ 1, 8 ] + _k3
   rcyf[ 3, 9 ] := rcyf[ 1, 9 ] + _k3
   rcyf[ 4, 1 ] := 'sto'
   rcyf[ 4, 2 ] := 'dwie&_s.cie'
   rcyf[ 4, 3 ] := rcyf[ 1, 3 ] + _k5
   rcyf[ 4, 4 ] := rcyf[ 1, 4 ] + _k5
   rcyf[ 4, 5 ] := rcyf[ 1, 5 ] + _k4
   rcyf[ 4, 6 ] := rcyf[ 1, 6 ] + _k4
   rcyf[ 4, 7 ] := rcyf[ 1, 7 ] + _k4
   rcyf[ 4, 8 ] := rcyf[ 1, 8 ] + _k4
   rcyf[ 4, 9 ] := rcyf[ 1, 9 ] + _k4

   IF ile < 0.0
      _znak := 'minus'
   ELSE
      _znak := ''
   ENDIF

   _liczba := Abs( ile )
   _cliczba := Str( _liczba, 16, 2 )
   IF _liczba == 0
      slownie := slownie + 'zero'
   ELSE
      bln  := SubStr( _cliczba, 1, 1 )
      mld  := SubStr( _cliczba, 2, 3 )
      mln  := SubStr( _cliczba, 5, 3 )
      tys  := SubStr( _cliczba, 8, 3 )
      jed  := SubStr( _cliczba, 11, 3)
      gro  := '0' + SubStr( _cliczba, 15, 2 )
      mld1 := SubStr( _cliczba, 3, 1 )
      mln1 := SubStr( _cliczba, 6, 1 )
      tys1 := SubStr( _cliczba, 9, 1 )
      jed1 := SubStr( _cliczba, 12, 1 )
      gro1 := SubStr( _cliczba, 15, 1 )
      mld2 := SubStr( _cliczba, 4, 1 )
      mln2 := SubStr( _cliczba, 7, 1 )
      tys2 := SubStr( _cliczba, 10, 1 )
      jed2 := SubStr( _cliczba, 13, 1 )
      gro2 := SubStr( _cliczba, 16, 1 )
      pisz1( bln, 'bilion' +iif( Val( BLN ) >=2 .AND. Val( BLN ) <= 4, 'y', ;
         iif( Val( BLN ) >=5 , '&_o.w', '' ) ), @slownie, rcyf )
      pisz1( mld, 'miliard' + iif( Val( MLD2 ) >=2 .AND. Val( MLD2 ) <=4 .AND. ;
         Val( MLD1 ) <> 1, 'y', iif( Val( MLD2 ) >=5 .OR. Val( MLD2 ) == 0 .OR. ;
         Val( MLD1 ) == 1 .OR. ( Val( MLD ) > 5 .AND. Val( MLD2 ) == 1 ), '&_o.w', '' ) ), @slownie, rcyf )
      pisz1( mln, 'milion' + iif( Val( MLN2 ) >= 2 .AND. Val( MLN2 ) <= 4 .AND. ;
         Val( MLN1 ) <> 1, 'y', iif( Val( MLN2 ) >= 5 .OR. Val( MLN2 ) == 0 .OR. ;
         Val( MLN1 ) == 1 .OR. ( Val( MLN ) > 5 .AND. Val( MLN2 ) == 1 ), '&_o.w', '' ) ), @slownie, rcyf )
      pisz1( tys, 'tys' + iif( Val( TYS2 ) >= 2 .AND. Val( TYS2 ) <= 4 .AND. ;
         Val( TYS1 ) <> 1, 'i&_a.ce', iif( Val( TYS2 ) >= 5 .OR. Val( TYS2 ) == 0 .OR. ;
         Val( TYS1 ) == 1 .OR. ( Val( TYS ) > 5 .AND. Val( TYS2 ) == 1 ), 'i&_e.cy', 'i&_a.c' ) ), @slownie, rcyf )
      pisz1( jed, 'z&_l.ot' + iif( Val( JED2 ) >=2 .AND. Val( JED2 ) <= 4 .AND. ;
         Val( JED1 ) <> 1, 'e', iif( Val( JED2 ) >= 5 .OR. Val( JED2 ) == 0 .OR. ;
         Val( JED1 ) == 1 .OR. ( Val( JED ) > 5 .AND. Val( JED2 ) == 0 ), 'ych', 'y' ) ), @slownie, rcyf )
      IF JAKWYZEJ
         slownie := _znak + ' ' + slownie + 'groszy jak wy&_z.ej'
      ELSE
         slownie := _znak + ' ' + slownie + gro1 + gro2 + '/100'
      ENDIF
   ENDIF

   RETURN slownie

*******************
PROCEDURE pisz1( rpoz, rkon, slownie, rcyf )

   LOCAL poz,kon

   poz := rpoz
   kon := rkon

   IF Val( poz ) <> 0
      IF SubStr( poz, 1, 1 ) <> ' ' .AND. SubStr( poz, 1, 1 ) <> '0'
         slownie := slownie + rcyf[ 4, Val( SubStr( poz, 1, 1 ) ) ] + ' '
      ENDIF
      IF SubStr( poz, 2, 1 ) <> ' ' .AND. SubStr( poz, 2, 1 ) <> '0'
         DO CASE
         CASE Val( SubStr( poz, 2, 1 ) ) > 1
            slownie := slownie + rcyf[ 3, Val( SubStr( poz, 2, 1 ) ) ] + ' '
         CASE SubStr( poz, 2, 1 ) == '1' .AND. SubStr( poz, 3, 1 ) <> '0'
            slownie := slownie + rcyf[ 2, Val( SubStr( poz, 3, 1 ) ) ] + ' '
         CASE SubStr( poz, 2, 1 ) == '1' .AND. SubStr( poz, 3, 1 ) == '0'
            slownie := slownie + 'dziesi&_e.&_c. '
         ENDCASE
      ENDIF
      IF SubStr( poz, 3, 1 ) <> ' ' .AND. SubStr( poz, 3, 1 ) <> '0' .AND. SubStr( poz, 2, 1 ) <> '1'
         slownie := slownie + rcyf[ 1, Val( SubStr( poz, 3, 1 ) ) ] + ' '
      ENDIF
      slownie := slownie + kon + ' '
   ENDIF

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± STATUS   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla u gory linie statusowa.                                         ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Zmiana ami-sys na gmsystems?
FUNCTION status()

   LOCAL zm

   zm := Date()
   zm := ' * ' + dtoc_( zm ) + ' ' + RTrim( dzien( zm ) ) + ' *'

   RETURN zm + Space( 68 - Len( zm ) ) + '¯ AMi-SYS ® '

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± WYRAZ    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Dla dowolnego lancucha funkcja podaje lancuch bedacy suma podlancuch¢w o  ±
*±podanej dlugosci.Kazdy z podlancuch¢w zawiera czesc co do wyrazu tekstu   ±
*±lancucha wejsciowego.                                                     ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION wyraz( _wiiersz, _dlugosc )

   LOCAL _aa, _b, _zm, _wynik

   _wiiersz := scal( _wiiersz )
   _wynik := ''
   _aa := 1
   DO WHILE _aa < Len( _wiiersz )
      _b := RAt( ' ', SubStr( _wiiersz, _aa, _dlugosc ) )
      IF _b == 0 .OR. _aa + _dlugosc > Len( _wiiersz )
         _zm := SubStr( _wiiersz, _aa, _dlugosc )
         _aa := _aa + _dlugosc
      ELSE
         _zm := substr( _wiiersz, _aa, _b - 1 )
         _aa := _aa + _b
      ENDIF
   _wynik := _wynik + _zm + Space( _dlugosc - Len( _zm ) )
   ENDDO

   RETURN _wynik

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± SCAL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Dla dowolnego lancucha funkcja usuwa wiodace i konczace spacje oraz skraca±
*±odstepy do jednej spacji.                                                 ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION scal( _wieersz )

   LOCAL _aa, _b, _wynik

   _wieersz := AllTrim( _wieersz ) + ' '
   _wynik := ''
   _aa := 1
   DO WHILE _aa <= Len( _wieersz )
      _b := At( ' ', SubStr( _wieersz, _aa ) )
      _wynik := _wynik + SubStr( _wieersz, _aa, _b - 1 ) + ' '
      _aa := Len( _wieersz ) - Len( LTrim( SubStr( _wieersz, _aa + _b ) ) ) + 1
   ENDDO

   RETURN RTrim( _wynik )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± CODE     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Dla zmiennej globalnej kod_uzytk bedacej lancuchem o dlugosci 150 cyfr    ±
*±podaje nazwe uzytkownika w postaci lancucha o dlugosci 50 zank¢w.         ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//TODO: Przeniesc do niepublicznej czesci
//TODO: Dodac parametr funkcji zamiast zmiennej globalnej 'kod_uzytk', 'nr_uzytk'
FUNCTION code()

   RETURN kod_uzytk

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± LITERY   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Funkcja podaje wartosc logiczna "prawda" jesli lancuch sklada sie tylko   ±
*±z liter.                                                                  ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Do usuniecia - funkcja nie wykorzystywana
FUNCTION litery( _char )

   LOCAL _i

   FOR _i := 1 to Len( _char )
      IF ! IsAlpha( SubStr( _char, _i ) )
         RETURN .F.
      ENDIF
   NEXT

   RETURN .T.

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ZAP_MAX  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Kasuje zawartosc wszystkich baz danych w aktualnym katalogu.              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//TODO: Do usuniecia - funkcja nie wykorzystwana
FUNCTION zap_max()

   LOCAL _i, _zm, p := Array( 99 )

   ADir( '*.dbf', p )
   _i := 1
   DO WHILE ValType( p[ _i ] ) == 'C'
      _zm :=p[ _i ]
      DO WHILE ! dostepex( _zm )
      ENDDO
      zap_()
      _i := _i + 1
   ENDDO
   close_()

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± SIZE     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Podaje w bajtach zajetosc pamieci przez pliki aktualnego katalogu jesli   ±
*±liczba plikow jest mniejsza niz 100. W przeciwnym przypadku podaje -1.    ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION size( _plik )

   LOCAL _i, _zm, p := Array( 100 )

   ADir( '*.*', p, p )
   _zm := 0
   _i := 1
   DO WHILE ValType( p[ _i ] ) == 'N'
      _zm := _zm + p[ _i ]
      _i := _i + 1
   ENDDO

   RETURN iif( _i > 100, -1, _zm )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ROZRZUT  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Rozrzuca zmienna CHAR znak+znak na spacja+znak+spacja+znak i zwraca taka  ±
*±zmienna                                                                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION rozrzut( _ciag )

   LOCAL _i, _wyjciag, x

   _wyjciag := ''
   FOR x := 1 TO Len( _ciag )
      _wyjciag := _wyjciag + ' ' + SubStr( _ciag, x, 1 )
   NEXT

   RETURN _wyjciag

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± INFOfirma ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla podstawowe informacje o wybranej firmie                         ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: ident_fi jako parametr
FUNCTION infofirma()

   LOCAL cUrzad, CURR

   SELECT 1
   DO WHILE ! dostep( 'FIRMA' )
   ENDDO
   SET INDEX TO firma
   GO Val( ident_fir )

   SELECT 2
   DO WHILE ! dostep( 'URZEDY' )
   ENDDO
   SET INDEX TO urzedy
   GO firma->skarb
   cUrzad := AllTrim( urzedy->miejsc_us ) + '-' + AllTrim( urzedy->urzad )
   USE

   SELECT firma
   CURR := ColStd()
   @ 3, 43 SAY 'Tel.:'
   @ 3, 61 SAY 'Fax :'
   @ 4, 43 SAY 'Kontakt:'
   @ 5, 43 SAY 'NIP :'
   @ 6, 43 SAY 'U.S.:'
   @ 7, 43 SAY 'Bie&_z.&_a.cy nr faktury VAT..........'
   @ 8, 43 SAY 'Bie&_z.&_a.cy nr rachunku.............'
   SET COLOR TO w+
   @ 3, 48 SAY firma->tel
   @ 3, 66 SAY firma->fax
   @ 4, 51 SAY firma->nazwisko
   @ 5, 48 SAY firma->nip
   @ 6, 48 SAY cUrzad
   @ 7, 75 SAY firma->nr_fakt PICTURE '99999'
   @ 8, 75 SAY firma->nr_rach PICTURE '99999'
   ColSta()
   @ 9, 43 TO 9, 79
   SetColor( CURR )
   USE

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± INFOmies  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje o obrotach miesiecznie i narastajaco                 ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION infomies( nMode, nCurEl, nRowPos )

   LOCAL nRetVal := AC_CONT
   LOCAL nKey := LastKey()

   DO CASE
   CASE nMode == AC_IDLE
      infoobr(str(nCurEl,2))
      nRetVal:=AC_CONT
   CASE nMode == AC_EXCEPT
      DO CASE
      CASE nKey == K_ENTER
         nRetVal := AC_SELECT
      CASE nKey == K_ESC
         nRetVal := AC_ABORT
      CASE nKey == K_CTRL_F10
         AKTSUMIES( Str( nCurEl, 2 ) )
         KEYBOARD Chr( 32 )
      OTHERWISE
         nRetVal := AC_GOTO
      ENDCASE
   ENDCASE

   RETURN nRetVal

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± infoobr  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Przydziela zbiory indeksowe do podanego zbioru                            ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Globalne parametry: ident_fir, zRYCZALT, mc_rozp
FUNCTION infoobr( nCurEl )

   LOCAL CURR
   LOCAL um, un, pm, pn, hm, hn, zm, zn, ilpoz, ry20m, ry20n, ry17m, ry17n
   LOCAL ry10m, ry10n, sm, sn, km, kn, ryk07m, ryk07n, ryk08m, ryk08n
   LOCAL ryk09m, ryk09n, ryk10m, ryk10n

   SELECT 1
   DO WHILE ! dostep( 'SUMA_MC' )
   ENDDO
   SET INDEX TO suma_mc
   SEEK '+' + ident_fir + mc_rozp
   IF ! found()
      CURR=ColInf()
      @ 10, 43 say '************ BRAK DANYCH ************'
      SetColor( CURR )
   ELSE
      IF zRYCZALT == 'T'
         STORE 0 TO um, un, pm, pn, hm, hn, zm, zn, ilpoz, ry20m, ry20n, ry17m, ry17n, ry10m, ry10n, ;
            ryk07m, ryk07n, ryk08m, ryk08n, ryk09m, ryk09n, ryk10m, ryk10n
         DO WHILE suma_mc->del == '+' .AND. suma_mc->firma == ident_fir .AND. suma_mc->mc <= nCurEl
            um := suma_mc->USLUGI
            pm := suma_mc->WYR_TOW
            hm := suma_mc->HANDEL
            ry20m := suma_mc->RY20
            ry17m := suma_mc->RY17
            ry10m := suma_mc->RY10
            ryk07m := suma_mc->RYK07
            ryk08m := suma_mc->RYK08
            ryk09m := suma_mc->RYK09
            ryk10m := suma_mc->RYK10
            un := un + um
            pn := pn + pm
            hn := hn + hm
            ry20n := ry20n + ry20m
            ry17n := ry17n + ry17m
            ry10n := ry10n + ry10m
            ryk07n := ryk07n + ryk07m
            ryk08n := ryk08n + ryk08m
            ryk09n := ryk09n + ryk09m
            ryk10n := ryk10n + ryk10m
            ilpoz := suma_mc->pozycje
            SKIP
         ENDDO
         CURR := ColStd()
         @ 10, 43 SAY '          ZA MIESI&__A.C     NARASTAJ&__A.CO '
         @ 11, 43 SAY '-------------------------------------'
         @ 12, 43 SAY PadR( AllTrim( SubStr( staw_ory20, 1, 9 ) ), 9, '.' ) + '.                           '
         @ 13, 43 SAY PadR( AllTrim( SubStr( staw_ory17, 1, 9 ) ), 9, '.' ) + '.                           '
         @ 14, 43 SAY PadR( AllTrim( SubStr( staw_ork09, 1, 9 ) ), 9, '.' ) + '.                           '
         @ 15, 43 SAY PadR( AllTrim( SubStr( staw_ouslu, 1, 9 ) ), 9, '.' ) + '.                           '
         @ 16, 43 SAY PadR( AllTrim( SubStr( staw_ork10, 1, 9 ) ), 9, '.' ) + '.                           '
         @ 17, 43 SAY PadR( AllTrim( SubStr( staw_oprod, 1, 9 ) ), 9, '.' ) + '.                           '
         @ 18, 43 SAY PadR( AllTrim( SubStr( staw_ohand, 1, 9 ) ), 9, '.' ) + '.                           '
         @ 19, 43 SAY PadR( AllTrim( SubStr( staw_ork07, 1, 9 ) ), 9, '.' ) + '.                           '
         @ 20, 43 SAY PadR( AllTrim( SubStr( staw_ory10, 1, 9 ) ), 9, '.' ) + '.                           '
         /*
         IF staw_k08w
            @ 19, 43 SAY PadR( AllTrim( SubStr( staw_ork08, 1, 9 ) ), 9, '.' ) + '.                           '
         ELSE
            @ 19, 43 SAY '-------------------------------------'
         ENDIF
         */
         @ 21, 43 SAY 'PRZYCH&__O.D..                           '
         @ 22, 43 SAY 'Ilo&_s.&_c. dokument&_o.w w miesi&_a.cu..........'
         SET COLOR TO w+
         @ 12, 53 SAY ry20m                        PICTURE RPIC
         @ 12, 66 SAY ry20n                        PICTURE RPICE
         @ 13, 53 SAY ry17m                        PICTURE RPIC
         @ 13, 66 SAY ry17n                        PICTURE RPICE
         @ 14, 53 SAY ryk09m                       PICTURE RPIC
         @ 14, 66 SAY ryk09n                       PICTURE RPICE
         @ 15, 53 SAY um                           PICTURE RPIC
         @ 15, 66 SAY un                           PICTURE RPICE
         @ 16, 53 SAY ryk10m                       PICTURE RPIC
         @ 16, 66 SAY ryk10n                       PICTURE RPICE
         @ 17, 53 SAY pm                           PICTURE RPIC
         @ 17, 66 SAY pn                           PICTURE RPICE
         @ 18, 53 SAY hm                           PICTURE RPIC
         @ 18, 66 SAY hn                           PICTURE RPICE
         @ 19, 53 SAY ryk07m                       PICTURE RPIC
         @ 19, 66 SAY ryk07n                       PICTURE RPICE
         @ 20, 53 SAY ry10m                        PICTURE RPIC
         @ 20, 66 SAY ry10n                        PICTURE RPICE
         /*
         IF staw_k08w
            @ 19, 53 SAY ryk08m                        PICTURE RPIC
            @ 19, 66 SAY ryk08n                        PICTURE RPICE
         ENDIF
         */
         @ 21, 53 SAY um + pm + hm + ry20m + ry17m + ry10m + ryk07m + ryk08m + ryk09m + ryk10m PICTURE RPIC
         @ 21, 66 SAY un + pn + hn + ry20n + ry17n + ry10n + ryk07n + ryk08n + ryk09n + ryk10n PICTURE RPICE
         @ 22, 75 SAY ilpoz                        PICTURE '99999'
         SetColor( CURR )
         czyobrvat( un + pn + hn )
      ELSE
         STORE 0 TO sm, sn, pm, pn, zm, zn, km, kn, ilpoz
         DO WHILE suma_mc->del == '+' .AND. suma_mc->firma == ident_fir .AND. suma_mc->mc<=nCurEl
            sm := suma_mc->WYR_TOW
            pm := suma_mc->USLUGI
            zm := suma_mc->ZAKUP + suma_mc->UBOCZNE
            km := suma_mc->WYNAGR_G + suma_mc->WYDATKI
            sn := sn + sm
            pn := pn + pm
            zn := zn + zm
            kn := kn + km
            ilpoz := suma_mc->pozycje
            SKIP
         ENDDO
         CURR=ColStd()
         @ 10, 43 SAY '          ZA MIESI&__A.C     NARASTAJ&__A.CO '
         @ 11, 43 SAY '-------------------------------------'
         @ 12, 43 SAY 'Sprzeda&_z...                           '
         @ 13, 43 SAY 'Pozosta&_l.e.                           '
         @ 14, 43 SAY 'PRZYCHODY                            '
         @ 15, 43 SAY '-------------------------------------'
         @ 16, 43 SAY 'Zakupy....                           '
         @ 17, 43 SAY 'Koszty....                           '
         @ 18, 43 SAY 'ROZCHODY                             '
         @ 19, 43 SAY '-------------------------------------'
         @ 20, 43 SAY 'SALDO...                             '
         @ 21, 43 SAY 'Ilo&_s.&_c. dokument&_o.w w miesi&_a.cu..........'
         SET COLOR TO w+
         @ 12, 53 SAY sm                        PICTURE RPIC
         @ 12, 66 SAY sn                        PICTURE RPICE
         @ 13, 53 SAY pm                        PICTURE RPIC
         @ 13, 66 SAY pn                        PICTURE RPICE
         @ 14, 53 SAY sm + pm                   PICTURE RPIC
         @ 14, 66 SAY sn + pn                   PICTURE RPICE
         @ 16, 53 SAY zm                        PICTURE RPIC
         @ 16, 66 SAY zn                        PICTURE RPICE
         @ 17, 53 SAY km                        PICTURE RPIC
         @ 17, 66 SAY kn                        PICTURE RPICE
         @ 18, 53 SAY zm + km                   PICTURE RPIC
         @ 18, 66 SAY zn + kn                   PICTURE RPICE
         @ 20, 53 SAY ( sm + pm ) - ( zm + km ) PICTURE RPIC
         @ 20, 66 SAY ( sn + pn ) - ( zn + kn ) PICTURE RPICE
         @ 21, 75 SAY ilpoz                     PICTURE '99999'
         SetColor( CURR )
         czyobrvat( sn )
      ENDIF
   ENDIF
   USE

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION ObliczSumMies( cMiesiac )

   LOCAL aRes, cNr
   LOCAL _koniec := "del#[+].or.firma#ident_fir.or.mc#cxMiesiac"
   PRIVATE cxMiesiac := cMiesiac

   SELECT 2
   IF zRYCZALT == 'T'

      aRes := hb_Hash( 'uslugi', 0, 'wyr_tow', 0, 'handel', 0, 'ry20', 0, ;
         'ry17', 0, 'ry10', 0, 'ryk07', 0, 'ryk08', 0, 'ryk09', 0, 'ryk10', 0, 'pozycje', 0 )

      DO WHILE ! Dostep( 'EWID' )
      ENDDO
      SetInd( 'EWID' )
      SEEK '+' + ident_fir + cMiesiac

      DO WHILE ! &_koniec
         cNr := iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2, 20 ) , SubStr( numer, 1, 20 ) )
         IF RTrim( cNr ) # 'REM-P' .AND. RTrim( cNr ) # 'REM-K'
            aRes[ 'uslugi' ] += ewid->uslugi
            aRes[ 'wyr_tow' ] += ewid->produkcja
            aRes[ 'handel' ] += ewid->handel
            aRes[ 'ry20' ] += ewid->ry20
            aRes[ 'ry17' ] += ewid->ry17
            aRes[ 'ry10' ] += ewid->ry10
            aRes[ 'ryk07' ] += ewid->ryk07
            aRes[ 'ryk08' ] += ewid->ryk08
            aRes[ 'ryk09' ] += ewid->ryk09
            aRes[ 'ryk10' ] += ewid->ryk10
            aRes[ 'pozycje' ] := aRes[ 'pozycje' ] + 1
         ENDIF
         SKIP
      ENDDO

   ELSE

      aRes := hb_Hash( 'uslugi', 0, 'wyr_tow', 0, 'zakup', 0, 'uboczne', 0, ;
         'wynagr_g', 0, 'wydatki', 0, 'pozycje', 0 )

      DO WHILE ! Dostep( 'OPER' )
      ENDDO
      SetInd( 'OPER' )
      SEEK '+' + ident_fir + cMiesiac

      DO WHILE ! &_koniec
         cNr := iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2, 20 ) , SubStr( numer, 1, 20 ) )
         IF RTrim( cNr ) # 'REM-P' .AND. RTrim( cNr ) # 'REM-K'
            aRes[ 'uslugi' ] += oper->uslugi
            aRes[ 'wyr_tow' ] += oper->wyr_tow
            aRes[ 'zakup' ] += oper->zakup
            aRes[ 'uboczne' ] += oper->uboczne
            aRes[ 'wynagr_g' ] += oper->wynagr_g
            aRes[ 'wydatki' ] += oper->wydatki
            aRes[ 'pozycje' ] := aRes[ 'pozycje' ] + 1
         ENDIF
         SKIP
      ENDDO

   ENDIF

   USE
   SELECT 1

   RETURN aRes

/*----------------------------------------------------------------------*/

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± aktsumies ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Awaryjna aktualizacja sum miesiecznych w zbiorze SUMA_MC.dbf              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Globalne zmienne: ident_fir, zRYCZALT
FUNCTION aktsumies( nCurEl )

   LOCAL AKTM
   LOCAL zUSLUGI, zWYR_TOW, zHANDEL, zPOZYCJE, zRY20, zRY17, zRY10, zRYK07, zRYK08
   LOCAL zZAKUP, zUBOCZNE, zWYNAGR_G, zWYDATKI, zZAMEK, zRYK09, zRYK10
   LOCAL lPrzelicz := .F., aDane

   lPrzelicz := TNEsc( , "Czy ponownie przeliczy† warto˜ci? (T/N)" )

   SELECT 1
   DO WHILE ! dostep( 'SUMA_MC' )
   ENDDO
   SET INDEX TO suma_mc
   SEEK '+' + ident_fir + nCurEl
   IF Found()
      SAVE SCREEN TO AKTM
      SET CURSOR ON
      IF zRYCZALT == 'T'
         STORE 0 TO zUSLUGI, zWYR_TOW, zHANDEL, zPOZYCJE, zRY20, zRY17, zRY10, zRYK07, zRYK08, zRYK09, zRYK10
         IF lPrzelicz
            aDane := ObliczSumMies( nCurEl )
            zUSLUGI  := aDane[ 'uslugi' ]
            zWYR_TOW := aDane[ 'wyr_tow' ]
            zHANDEL  := aDane[ 'handel' ]
            zRY20    := aDane[ 'ry20' ]
            zRY17    := aDane[ 'ry17' ]
            zRY10    := aDane[ 'ry10' ]
            zRYK07   := aDane[ 'ryk07' ]
            zRYK08   := aDane[ 'ryk08' ]
            zRYK09   := aDane[ 'ryk09' ]
            zRYK10   := aDane[ 'ryk10' ]
            zPOZYCJE := aDane[ 'pozycje' ]
         ELSE
            zUSLUGI  := suma_mc->USLUGI
            zWYR_TOW := suma_mc->WYR_TOW
            zHANDEL  := suma_mc->HANDEL
            zRY20    := suma_mc->RY20
            zRY17    := suma_mc->RY17
            zRY10    := suma_mc->RY10
            zRYK07   := suma_mc->RYK07
            zRYK08   := suma_mc->RYK08
            zRYK09   := suma_mc->RYK09
            zRYK10   := suma_mc->RYK10
            zPOZYCJE := suma_mc->POZYCJE
         ENDIF
         zZAMEK   := iif( suma_mc->ZAMEK, 'T', 'N' )
         @ 12, 53 GET zRY20    PICTURE FPIC
         @ 13, 53 GET zRY17    PICTURE FPIC
         @ 14, 53 GET zRYK09   PICTURE FPIC
         @ 15, 53 GET zUSLUGI  PICTURE FPIC
         @ 16, 53 GET zRYK10   PICTURE FPIC
         @ 17, 53 GET zWYR_TOW PICTURE FPIC
         @ 18, 53 GET zHANDEL  PICTURE FPIC
         @ 19, 53 GET zRYK07   PICTURE FPIC
         @ 20, 53 GET zRY10    PICTURE FPIC
         /*
         IF staw_k08w
            @ 19, 53 GET zRYK08   PICTURE FPIC
         ENDIF
         */
         @ 22, 75 GET zPOZYCJE PICTURE '99999'
         @ 23, 43 SAY "Miesi¥c zamkni©ty" GET zZAMEK PICTURE '!' VALID zZAMEK $ 'NT'
         READ
         IF LastKey() <> K_ESC
            BLOKADAR()
            // TODO: lepiej uzycz suma_mc->pole := ... zamiast REPLACE
            REPLACE USLUGI WITH zUSLUGI, WYR_TOW WITH zWYR_TOW, ;
               HANDEL WITH zHANDEL, POZYCJE WITH zPOZYCJE, ;
               RY20 WITH zRY20, RY17 WITH zRY17, RY10 WITH zRY10, ;
               RYK07 WITH zRYK07, RYK08 WITH zRYK08, RYK09 WITH zRYK09, ;
               RYK10 WITH zRYK10, ZAMEK WITH iif( zZAMEK == 'T', .T., .F. )
            COMMIT
            UNLOCK
         ENDIF
      ELSE
         STORE 0 TO zUSLUGI, zWYR_TOW, zZAKUP, zUBOCZNE,;
            zWYNAGR_G, zWYDATKI, zPOZYCJE
         IF lPrzelicz
            aDane := ObliczSumMies( nCurEl )
            zUSLUGI   := aDane[ 'uslugi' ]
            zWYR_TOW  := aDane[ 'wyr_tow' ]
            zZAKUP    := aDane[ 'zakup' ]
            zUBOCZNE  := aDane[ 'uboczne' ]
            zWYNAGR_G := aDane[ 'wynagr_g' ]
            zWYDATKI  := aDane[ 'wydatki' ]
            zPOZYCJE  := aDane[ 'pozycje' ]
         ELSE
            zUSLUGI   := suma_mc->USLUGI
            zWYR_TOW  := suma_mc->WYR_TOW
            zZAKUP    := suma_mc->ZAKUP
            zUBOCZNE  := suma_mc->UBOCZNE
            zWYNAGR_G := suma_mc->WYNAGR_G
            zWYDATKI  := suma_mc->WYDATKI
            zPOZYCJE  := suma_mc->POZYCJE
         ENDIF
         zZAMEK   := iif( suma_mc->ZAMEK, 'T', 'N' )
         @ 13, 42 to 22,67
         @ 14, 43 SAY 'Wyroby i Tow            '
         @ 15, 43 SAY 'Pozosta&_l.e               '
         @ 16, 43 SAY 'Zakupy                  '
         @ 17, 43 SAY 'Uboczne                 '
         @ 18, 43 SAY 'Wynagr.got.             '
         @ 19, 43 SAY 'Pozosta&_l.e               '
         @ 20, 43 SAY 'Ilo&_s.&_c. pozycji           '
         @ 21, 43 SAY 'Miesi¥c zamkni©ty       '
         @ 14, 55 GET zWYR_TOW  PICTURE FPIC
         @ 15, 55 GET zUSLUGI   PICTURE FPIC
         @ 16, 55 GET zZAKUP    PICTURE FPIC
         @ 17, 55 GET zUBOCZNE  PICTURE FPIC
         @ 18, 55 GET zWYNAGR_G PICTURE FPIC
         @ 19, 55 GET zWYDATKI  PICTURE FPIC
         @ 20, 62 GET zPOZYCJE PICTURE '99999'
         @ 21, 62 GET zZAMEK PICTURE '!' VALID zZAMEK $ 'NT'
         READ
         IF LastKey() <> K_ESC
            BLOKADAR()
            // TODO: lepiej uzycz suma_mc->pole := ... zamiast REPLACE
            REPLACE USLUGI WITH zUSLUGI, WYR_TOW WITH zWYR_TOW, ;
               ZAKUP WITH zZAKUP, UBOCZNE WITH zUBOCZNE, WYNAGR_G WITH zWYNAGR_G, ;
               WYDATKI WITH zWYDATKI, POZYCJE WITH zPOZYCJE, ZAMEK WITH iif( zZAMEK == 'T', .T., .F. )
            COMMIT
            UNLOCK
         ENDIF
      ENDIF
      SET CURSOR OFF
      RESTORE SCREEN FROM AKTM
   ENDIF
   USE

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DOSTEP   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Sprawdza dostep do bazy i otwiera ja                                     ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION DOSTEP( NZB )

   LOCAL R := .F.

   DO WHILE .T.
      USE &NZB SHARED
      IF ! NetErr()
         R := .T.
         EXIT
      ENDIF
      KOMUN( 'Prosz&_e. czeka&_c. na dost&_e.p do zbioru ' + NZB )
      IF LastKey() == K_ESC
         EXIT
      ENDIF
   ENDDO

   RETURN R

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DOSTEPEX ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Sprawdza dostep do bazy i otwiera ja w trybie EXCLUSIVE                  ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION DOSTEPEX( NZB )

   LOCAL R := .F.

   DO WHILE .T.
      USE &NZB EXCLUSIVE
      IF ! NetErr()
         R := .T.
         EXIT
      ENDIF
      KOMUN( 'Prosz&_e. czeka&_c. na wy&_l.&_a.czny dost&_e.p do zbioru ' + NZB )
      IF LastKey() == K_ESC
         EXIT
      ENDIF
   ENDDO

   RETURN R

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DOSTEPRO ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Sprawdza dostep do bazy i otwiera ja                                     ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION DOSTEPRO( NZB )

   LOCAL R := .F.

   DO WHILE .T.
      USE &NZB READONLY
      IF ! NetErr()
         R := .T.
         EXIT
      ENDIF
      KOMUN( 'Prosz&_e. czeka&_c. na dost&_e.p do zbioru ' + NZB )
      IF LastKey() == K_ESC
         EXIT
      ENDIF
   ENDDO

   RETURN R

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± BLOKADA  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Blokuje baze                                                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE BLOKADA()

   DO WHILE .T.
      IF FLock()
         EXIT
      ENDIF
      KOMUN( 'Prosz&_e. czeka&_c. - zbi&_o.r chwilowo nie mo&_z.e by&_c. zablokowany' )
   ENDDO

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± BLOKADAR ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Blokuje rekord                                                           ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE BLOKADAR( cTablica )

   hb_default( @cTablica, '' )

   DO WHILE .T.
      IF Len( cTablica ) > 0
         IF ( cTablica )->( RLock() )
            EXIT
         ENDIF
      ELSE
         IF RLock()
            EXIT
         ENDIF
      ENDIF
      KOMUN( 'Prosz&_e. czeka&_c. - rekord chwilowo nie mo&_z.e by&_c. zablokowany' )
   ENDDO

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± DOPAP    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Dodaje rekord do bazy                                                    ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE DOPAP()

   DO WHILE .T.
      IF FLock()
         APPEND BLANK
         EXIT
      ENDIF
      KOMUN( 'Prosz&_e. czeka&_c. - rekord chwilowo nie mo&_z.e by&_c. dopisany' )
   ENDDO

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± KOMUN    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Wyswietla komunikat przez dlugosc CZAS                                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Globalne parametry: param_dzw
// TODO: Zmienna KKKomun nie uzywana
PROCEDURE KOMUN( TEKST, czas )

   LOCAL DL := Len( TEKST )
   LOCAL OF := int( ( DL / 2 ) + 2 )
   LOCAL _komunes
   LOCAL CURR, KKKomun

   hb_default( @czas, 0 )

   SAVE SCREEN TO _komunes
   CURR := ColInf()
   @ 22, 39 - OF CLEAR TO 24, 39 + OF
   @ 22, 39 - OF TO 24, 39 + OF
   IF param_dzw == 'T'
      Tone( 700, 1 )
      Tone( 500, 4 )
   ENDIF
   @ 23, ( ( 80 - DL ) / 2 ) SAY TEKST
   KKKomun := Inkey( czas, INKEY_KEYBOARD )
   SetColor( CURR )
   RESTORE SCREEN FROM _komunes

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± KALKUL   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Kalkulator                                                                ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE KALKUL()
* Na poczatku programu glownego wstaw
*----------------------------------------------------------------------------
* public MEMKALK1,MEMKALK2,MEMKALK3,MEMKALK4,POPOP,TASMA,LPTASMY,KALKDESK
* store 0 to MEMKALK1,MEMKALK2,MEMKALK3,MEMKALK4
* KALKDESK=''
* POPOP='+'
* TASMA=array(1)
* TASMA[1]='  '+transform(MEMKALK4,'999999999999.9999999')
* LPTASMY=1
* set key -38 to kll
* set key -39 to kll
* set key -46 to kll
* set key -47 to kll
* set key -18 to kll
* set key -19 to kll
* set key -42 to kll
* set key -43 to kll
*----------------------------------------------------------------------------
   LOCAL WART, GETLIST := {}
   LOCAL ColCur, KALKSCR, xzx, razem, SSS

   PRIVATE cc

   SET KEY K_ALT_K TO
   ColCur=SETCOLOR()
   SAVE SCREEN TO KALKSCR
   DO CASE
   CASE Col() < 26
      cc := 52
   CASE Col() < 52
      cc := 0
   CASE Col() >= 52
      cc := 26
   ENDCASE
   SET COLOR TO w
   @  0, cc SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
   FOR xzx := 1 TO 13
      @ xzx, cc SAY '³                       ³'
   NEXT
   @ 14, cc SAY '³                       ³'
   @ 15, cc SAY '³M1                     ³'
   @ 16, cc SAY '³M2                     ³'
   @ 17, cc SAY '³M3                     ³'
   @ 18, cc SAY '³M4                     ³'
   SET COLOR TO /w
   @ 19, cc SAY 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
   @ 20, cc SAY 'º +  -  *  /  .  =ENTER º'
   @ 21, cc SAY 'º D - druk ta&_s.my    ESC º'
   @ 22, cc SAY 'º U - urwanie ta&_s.my   C º'
   @ 23, cc SAY 'º Alt+(F9-F12) - pami&_e.&_c. º'
   @ 24, cc SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
   SET COLOR TO w
   wart := 0
   razem := MEMKALK4
   SET KEY Asc( '+' ) TO kll
   SET KEY Asc( '*' ) TO kll
   SET KEY Asc( '-' ) TO kll
   SET KEY Asc( '/' ) TO kll
   SET KEY Asc( '=' ) TO kll
   SET KEY Asc( 'C' ) TO kll
   SET KEY Asc( 'c' ) TO kll
   SET KEY K_ENTER TO kll
   SET KEY Asc( 'u' ) TO kll
   SET KEY Asc( 'U' ) TO kll
   SET KEY Asc( 'd' ) TO kll
   SET KEY Asc( 'D' ) TO kll
   IF Len( KALKDESK ) == 0
      KALKDESK := SaveScreen( 0, cc, 24, cc + 24 )
   ELSE
      RestScreen( 0, cc, 24, cc + 24 ,KALKDESK )
   ENDIF
   @ 14, cc + 1 GET WART PICTURE '@R      9999999999.9999999'
   SSS := SetCursor()
   SetCursor( 2 )
   READ
   CLEAR TYPE
   KALKDESK := SaveScreen( 0, cc, 24, cc + 24 )
   SetCursor( SSS )
   SetColor( ColCur )
   SET KEY Asc( '+' ) TO
   SET KEY Asc( '*' ) TO
   SET KEY Asc( '-' ) TO
   SET KEY Asc( '/' ) TO
   SET KEY Asc( '=' ) TO
   SET KEY Asc( 'C' ) TO
   SET KEY Asc( 'c' ) TO
   SET KEY K_ENTER TO
   SET KEY Asc( 'u' ) TO
   SET KEY Asc( 'U' ) TO
   SET KEY Asc( 'd' ) TO
   SET KEY Asc( 'D' ) TO
   SET KEY K_ALT_K TO KALKUL
   REST SCREEN FROM KALKSCR

   RETURN

*************************************
FUNCTION kll()
*************************************
   LOCAL oget, wart, kllost, razem, LLLLL

   oget := GetActive()
   IF ValType( oget ) == 'U'
      RETURN
   ENDIF
   wart := oget:varGet()
   kllost := LastKey()
   razem := MEMKALK4
   IF ValType( WART ) == 'N'
      DO CASE
      CASE kllost == K_ALT_F9
         MEMKALK1 := wart
         RETURN
      CASE kllost == K_ALT_F10
         MEMKALK2 := wart
         RETURN
      CASE kllost == K_ALT_F11
         MEMKALK3 := wart
         RETURN
      CASE kllost == K_ALT_F12
         MEMKALK4 := wart
         RETURN
      CASE kllost == K_SH_F9
         oget:varput( MEMKALK1 )
         oget:reset()
         RETURN
      CASE kllost == K_SH_F10
         oget:varput( MEMKALK2 )
         oget:reset()
         RETURN
      CASE kllost == K_SH_F11
         oget:varput( MEMKALK3 )
         oget:reset()
         RETURN
      CASE kllost == K_SH_F12
         oget:varput( MEMKALK4 )
         oget:reset()
         RETURN
      ENDCASE
   ELSE
      RETURN
   ENDIF
   SET COLOR TO w+
   @ 15, cc + 3 SAY MEMKALK1 PICTURE '9 999 999 999.9999999'
   @ 16, cc + 3 SAY MEMKALK2 PICTURE '9 999 999 999.9999999'
   @ 17, cc + 3 SAY MEMKALK3 PICTURE '9 999 999 999.9999999'
   @ 18, cc + 3 SAY MEMKALK4 PICTURE '9 999 999 999.9999999'
   SET COLOR TO w

   // TODO: wydruk z kalkulatora - obecnie nie dziala
   IF kllost == Asc( 'D' ) .OR. kllost == Asc( 'd' )
      IF IsPrinter()
         SET CONS OFF
         SET DEVI TO PRINT
         SET PRINT ON
         FOR LLLLL := 1 TO LPTASMY
            ? TASMA[ LLLLL ]
         NEXT
         ??
         SET DEVI TO SCREE
         SET PRINT OFF
         SET CONS ON
      ELSE
         ?? repl( Chr( 7 ), 3 )
      ENDIF
      RETURN
   ENDIF

   IF kllost == Asc( 'U' ) .OR. kllost == Asc( 'u' )
      TASMA := Array( 1 )
      TASMA[ 1 ] := Transform( MEMKALK4, '9 999 999 999.9999999' )
      LPTASMY := 1
      @ 1, cc + 1 CLEAR TO 13, cc + 23
      SET COLOR TO /w
      @ 0, cc SAY 'ÚÄÄÄD&__L.UGO&__S.&__C. TA&__S.MY=' + Str( LPTASMY, 3 ) + 'ÄÄÄ¿'
      SET COLOR TO W
      RETURN
   ENDIF

   IF wart <> 0 .AND. ( kllost == Asc( '+' ) .OR. kllost == Asc( '*' ) .OR. ;
      kllost == Asc( '-' ) .OR. kllost == Asc( '/' ) .OR. kllost == Asc( '=' ) .OR. ;
      kllost == Asc( 'c' ) .OR. kllost == Asc( 'C' ) .OR. kllost == K_ENTER )

      @ 13, cc + 3 SAY wart PICTURE '9 999 999 999.9999999'
      Scroll( 1, cc + 1, 13, cc + 23, 1 )
      AAdd( TASMA, popop + ' ' + Transform( wart, '9 999 999 999.9999999' ) )
      LPTASMY++
      SET COLOR TO /w
      @  0, cc SAY 'ÚÄÄÄD&__L.UGO&__S.&__C. TA&__S.MY=' + Str( LPTASMY, 3 ) + 'ÄÄÄ¿'
      SET COLOR TO w
      DO CASE
      CASE popop == '+'
         razem := _round( razem + wart, 8 )
      CASE popop == '-'
         razem := _round( razem - wart, 8 )
      CASE popop == '*'
         razem := _round( razem * wart, 8 )
      CASE popop := '/'
         razem := _round( razem / wart, 8 )
      CASE popop == '='
         // TODO: Czy to potrzebne?
         razem := razem
      ENDCASE
   ENDIF

   DO CASE
   CASE kllost == Asc( '+' )
      popop := '+'
   CASE kllost == Asc( '-' )
      popop := '-'
   CASE kllost == Asc( '*' )
      popop := '*'
   CASE kllost == Asc( '/' )
      popop := '/'
   CASE kllost == K_ENTER .OR. kllost == Asc( '=' )
      popop := '='
   CASE kllost == Asc( 'C' ) .OR. kllost == Asc( 'c' )
      popop := 'C'
      razem := 0
   ENDCASE

   @ 13, cc + 1 SAY popop

   IF ( wart <> 0 .OR. popop == 'C' ) .AND. ( kllost == Asc( '+' ) .OR. ;
      kllost == Asc( '*' ) .OR. kllost == Asc( '-' ) .OR. kllost == Asc( '/' ) .OR. ;
      kllost == Asc( '=' ) .OR. kllost == Asc( 'c' ) .OR. kllost == Asc( 'C' ) .OR. kllost == K_ENTER )

      IF popop == '=' .OR. popop == 'C'
         SET COLOR TO w+
         @ 13, cc + 3 SAY razem PICTURE '9 999 999 999.9999999'
         SET COLOR TO w
         Scroll( 1, cc + 1, 13, cc + 23, 2 )
         AAdd( TASMA, popop + ' ' + Transform( razem,'9 999 999 999.9999999' ) )
         AAdd( TASMA, Space( 23 ) )
         LPTASMY++
         LPTASMY++
         SET COLOR TO /w
         @  0, cc SAY 'ÚÄÄÄD&__L.UGO&__S.&__C. TA&__S.MY=' + Str( LPTASMY, 3 ) + 'ÄÄÄ¿'
         SET COLOR TO w
         popop := '+'
      ENDIF
   ENDIF

   MEMKALK4 := razem
   SET COLOR TO w+
   @ 15, cc + 3 SAY MEMKALK1 PICTURE '9 999 999 999.9999999'
   @ 16, cc + 3 SAY MEMKALK2 PICTURE '9 999 999 999.9999999'
   @ 17, cc + 3 SAY MEMKALK3 PICTURE '9 999 999 999.9999999'
   @ 18, cc + 3 SAY MEMKALK4 PICTURE '9 999 999 999.9999999'
   SET COLOR TO w
   oget:varput( 0 )
   oget:reset()

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± NOTES    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Notes                                                                     ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE NOTES( EDI )

   LOCAL _CurSel, _CurCur, ColCur, NOTESCR, cc, znotatka

   hb_default( @EDI, .T. )

   _CurSel := Select()
   _CurCur := SetCursor()
   SELECT 111
   IF dostep( 'NOTES' )
      SET INDEX TO notes
      IF edi
         SEEK '+' + ident_fir
      ELSE
         SEEK '+' + Str( firma->( RecNo() ), 3 )
      ENDIF
      IF ! Found()
         app()
         IF edi
            repl_( 'firma', ident_fir )
         ELSE
            repl_( 'firma', Str( firma->( RecNo() ), 3 ) )
         ENDIF
      ENDIF
      SET KEY K_ALT_N TO
      ColCur := SetColor()
      IF edi
         SAVE SCRE TO NOTESCR
      ENDIF
      DO CASE
      CASE edi == .F.
         cc := 2
      CASE Col() >= 40
         cc := 0
      OTHERWISE
         cc := 40
      ENDCASE
      SET COLOR TO +w
      @  3, cc TO 22, cc + 39 DOUBLE
      @  3, cc + 16 SAY 'NOTATKI'
      IF edi
         @ 22, cc + 1  SAY 'CTRL+W-zapis'
         @ 22, cc + 25 SAY 'ESC-rezygnacja'
         SET CURSOR ON
      ELSE
         KEYBOARD Chr( K_ESC )
      ENDIF
      SET COLOR TO w
      znotatka := MemoEdit( notatka, 4, cc + 1, 21, cc + 38, edi )
      SetCursor( _CurCur )
      IF edi
         RESTORE SCREEN FROM NOTESCR
      ENDIF
      IF edi .AND. lastkey()#K_ESC
         BLOKADAR()
         repl_( 'NOTATKA', zNOTATKA )
         COMMIT
         UNLOCK
      ENDIF
      USE
      SetColor( ColCur )
      SET KEY K_ALT_N TO NOTES
   ENDIF
   SELECT &_CurSel

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± KOLORY   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Zestaw funkcji do ustawiania kolorow                                     ±
*±±±±±±±±±±±±blad±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColErr()

   LOCAL ColCur := SetColor( CColErr )

   RETURN ColCur

*±±±±±±±±±±±±info±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColInf()

   LOCAL ColCur := SetColor( CColInf )

   RETURN ColCur

*±±±±±±±±±±±±info±blink±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColInb()

   LOCAL ColCur := SetColor( CColInb )

   RETURN ColCur

*±±±±±±±±±±±±dialog±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColDlg()

   LOCAL ColCur := SetColor( CColDlg )

   RETURN ColCur
*±±±±±±±±±±±±standard±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColStd()

   LOCAL ColCur := SetColor( CColStd )

   RETURN ColCur

*±±±±±±±±±±±±status±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColSta()

   LOCAL ColCur := SetColor( CColSta )

   RETURN ColCur

*±±±±±±±±±±±±status±blink±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColStb()

   LOCAL ColCur := SetColor( CColStb )

   RETURN ColCur

*±±±±±±±±±±±±status±invers±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColSti()

   LOCAL ColCur := SetColor( CColSti )

   RETURN ColCur

*±±±±±±±±±±±±prompty±i±achoice±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColPro()

   LOCAL ColCur := SetColor( CColPro )

   RETURN ColCur

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION ColInv()

   LOCAL ColCur := SetColor( CColInv )

   RETURN ColCur

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± FBLAD    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Wyswietla blad po ostatniej operacji na zbiorach binarnych               ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION FBLAD( NUMBLAD )

   LOCAL BLAD := ''

   IF NUMBLAD <> 0
      DO CASE
      CASE NUMBLAD == 2
         BLAD := 'B&__L.&__A.D !!!!! Nie znaleziono zbioru'
      CASE NUMBLAD=3
         BLAD := 'B&__L.&__A.D !!!!! Nie znaleziono &_s.cie&_z.ki'
      CASE NUMBLAD=4
         BLAD := 'B&__L.&__A.D !!!!! Za du&_z.o otwartych zbior&_o.w'
      CASE NUMBLAD=5
         BLAD := 'B&__L.&__A.D !!!!! Brak praw dost&_e.pu'
      CASE NUMBLAD=6
         BLAD := 'B&__L.&__A.D !!!!! Niew&_l.a&_s.ciwy deskryptor'
      CASE NUMBLAD=8
         BLAD := 'B&__L.&__A.D !!!!! Brak pami&_e.ci'
      CASE NUMBLAD=15
         BLAD := 'B&__L.&__A.D !!!!! Niew&_l.a&_s.ciwy nap&_e.d dysku'
      CASE NUMBLAD=19
         BLAD := 'B&__L.&__A.D !!!!! Pr&_o.ba zapisu na dysk z ochron&_a. przed zapisem'
      CASE NUMBLAD=21
         BLAD := 'B&__L.&__A.D !!!!! Nap&_e.d nie gotowy'
      CASE NUMBLAD=23
         BLAD := 'B&__L.&__A.D !!!!! B&_l.&_a.d CRC'
      CASE NUMBLAD=29
         BLAD := 'B&__L.&__A.D !!!!! Nieudany zapis'
      CASE NUMBLAD=30
         BLAD := 'B&__L.&__A.D !!!!! Nieudany odczyt'
      CASE NUMBLAD=32
         BLAD := 'B&__L.&__A.D !!!!! Naruszenie trybu dzielonego'
      CASE NUMBLAD=33
         BLAD := 'B&__L.&__A.D !!!!! Naruszenie blokady'
      OTHERWISE
         BLAD := 'B&__L.&__A.D !!!!! Nieopisany b&_l.&_a.d nr ' + Str( NUMBLAD, 6 )
      ENDCASE
      KOMUN( BLAD )
      KOMUN( BLAD )
      KOMUN( BLAD )
      KOMUN( BLAD )
   ENDIF

   RETURN NUMBLAD

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± SETIND   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Przydziela zbiory indeksowe do podanego zbioru                            ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE setind( ZB )

   ZB := Upper( ZB )

   DO CASE
   CASE ZB == 'FAKTURY'
      SET INDEX TO faktury,faktury1,faktury2,faktury3
   CASE ZB == 'FAKTURYW'
      SET INDEX TO fakturw,fakturw1,fakturw2,fakturw3
   CASE ZB == 'POZYCJE'
      SET INDEX TO pozycje
   CASE ZB == 'POZYCJEW'
      SET INDEX TO pozycjew
   CASE ZB == 'SPOLKA'
      SET INDEX TO SPOLKA,SPOLKA1
   CASE ZB == 'URZEDY'
      SET INDEX TO URZEDY
   CASE ZB == 'ORGANY'
      SET INDEX TO ORGANY
   CASE ZB == 'REJESTRY'
      SET INDEX TO REJESTRY
   CASE ZB == 'WYPOSAZ'
      SET INDEX TO WYPOSAZ
   CASE ZB == 'OPER'
      SWITCH param_kslp
      CASE '1'
         SET INDEX TO oper,oper1,oper2,oper3,oper4,oper5
         EXIT
      CASE '2'
         SET INDEX TO oper3,oper1,oper2,oper,oper4,oper5
         EXIT
      CASE '3'
         SET INDEX TO oper5,oper1,oper2,oper,oper4,oper3
         EXIT
      OTHERWISE
         SET INDEX TO oper,oper1,oper2,oper3,oper4,oper5
      ENDSWITCH
   CASE ZB == 'EWID'
      SWITCH param_kslp
      CASE '1'
         SET INDEX TO ewid,ewid1,ewid2,ewid3,ewid4,ewid5
         EXIT
      CASE '2'
         SET INDEX TO ewid3,ewid1,ewid2,ewid,ewid4,ewid5
         EXIT
      CASE '3'
         SET INDEX TO ewid5,ewid1,ewid2,ewid,ewid4,ewid3
         EXIT
      OTHERWISE
         SET INDEX TO ewid,ewid1,ewid2,ewid3,ewid4,ewid5
      ENDSWITCH
   CASE ZB == 'EWIDPOJ'
      SET INDEX TO ewidpoj,ewidpoj1
   CASE ZB == 'DOWEW'
      SET INDEX TO dowew,dowew1
   CASE ZB == 'REJS'
      IF WERSJA4 == .T.
         SET INDEX TO rejs,rejs1,rejs2,rejs3,rejs4
      ELSE
         SET INDEX TO rejs3,rejs1,rejs2,rejs,rejs4
      ENDIF
   CASE ZB == 'REJZ'
      IF WERSJA4=.t.
         SET INDEX TO rejz,rejz1,rejz2,rejz3,rejz4
      ELSE
         SET INDEX TO rejz3,rejz1,rejz2,rejz,rejz4
      ENDIF
   CASE ZB == 'PRAC'
        SET INDEX TO prac,prac1,prac2,prac3,prac4
   CASE ZB == 'PRAC_HZ'
        SET INDEX TO prac_hz
   CASE ZB == 'ETATY'
        SET INDEX TO etaty,etaty1
   CASE ZB == 'NIEOBEC'
        SET INDEX TO nieobec,nieobec1
   CASE ZB == 'WYPLATY'
        SET INDEX TO wyplaty,wyplaty1
   CASE ZB == 'ZALICZKI'
        SET INDEX TO zaliczki,zaliczk1
   CASE ZB == 'UMOWY'
        SET INDEX TO umowy,umowy1,umowy2,umowy3
   CASE ZB == 'DZIENNE'
        SET INDEX TO dzienne
   CASE ZB == 'RACHPOJ'
        SET INDEX TO rachpoj,rachpoj1
   CASE ZB == 'PRZELEWY'
        SET INDEX TO przelewy
   CASE ZB == 'PRZELPOD'
        SET INDEX TO przelpod
   CASE ZB == 'KAT_SPR'
        SET INDEX TO kat_spr
   CASE ZB == 'KAT_ZAK'
        SET INDEX TO kat_zak
   CASE ZB == 'RELACJE'
        SET INDEX TO relacje
   CASE ZB == 'SAMOCHOD'
        SET INDEX TO samochod
   CASE ZB == 'TAB_POJ'
        SET INDEX TO tab_poj
   CASE ZB == 'TAB_VAT'
        SET INDEX TO tab_vat
   CASE ZB == 'KARTST'
        SET INDEX TO kartst,kartst1
   CASE ZB == 'KARTSTMO'
        SET INDEX TO kartstmo
   CASE ZB == 'AMORT'
        SET INDEX TO amort
   CASE ZB == 'KRST'
        SET INDEX TO krst
   CASE ZB == 'NOTES'
        SET INDEX TO notes
   CASE ZB == 'KONTR'
        SET INDEX TO kontr,kontr1
   CASE ZB == 'ROZR'
        SET INDEX TO rozr,rozr1,rozr2
   CASE ZB == 'TRESCKOR'
        SET INDEX TO tresckor
   CASE ZB == 'EDEKLAR'
        SET INDEX TO edeklar,edeklar1
   CASE ZB == 'KASAFISK'
        SET INDEX TO kasafisk
   CASE ZB == 'EWIDZWR'
        SET INDEX TO ewidzwr
   CASE ZB == 'OSSREJ'
        SET INDEX TO ossrej
   CASE ZB == 'TAB_VATUE'
        SET INDEX TO tab_vatue,tab_vatue1
   CASE ZB == 'VIUDOKOR'
        SET INDEX TO viudokor
   CASE ZB == 'TAB_DOCHUKS'
        SET INDEX TO tab_dochuks
   CASE ZB == 'TAB_PLA'
        SET INDEX TO tab_pla
   ENDCASE

   RETURN

********************************
FUNCTION _ROUND( _LICZBA, _DEC )

   LOCAL _lic, znak, _aa
   LOCAL _as, _ac, _a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8

   _lic := Abs( _LICZBA )
   IF _liczba - _lic == 0
      znak := 1
   ELSE
      znak := -1
   ENDIF

   _as := Str( _LICZBA, 21, 8 )
   _ac := SubStr( _as, 1, 12 )
   _a1 := SubStr( _as, 14, 1 )
   _a2 := SubStr( _as, 15, 1 )
   _a3 := SubStr( _as, 16, 1 )
   _a4 := SubStr( _as, 17, 1 )
   _a5 := SubStr( _as, 18, 1 )
   _a6 := SubStr( _as, 19, 1 )
   _a7 := SubStr( _as, 20, 1 )
   _a8 := SubStr( _as, 21, 1 )

   DO CASE
   CASE _DEC == 0
      _aa := Val( _ac )
      IF _a1 == '5' .OR. _a1 == '6' .OR. _a1 == '7' .OR. _a1 == '8' .OR. _a1 == '9'
         _LICZBA := _aa + ( 1 * znak )
      ELSE
         _LICZBA := _aa
      ENDIF
   CASE _DEC == 1
      _aa := Val( _ac + '.' + _a1 )
      IF _a2 == '5' .OR. _a2 == '6' .OR. _a2 == '7' .OR. _a2 == '8' .OR. _a2 == '9'
         _LICZBA := _aa + ( 0.1 * znak )
      ELSE
         _LICZBA := _aa
      ENDIF
   CASE _DEC == 2
      _aa := Val( _ac + '.' + _a1 + _a2 )
      IF _a3 == '5' .OR. _a3 == '6' .OR. _a3 == '7' .OR. _a3 == '8' .OR. _a3 == '9'
         _LICZBA=_aa+(0.01*znak)
      ELSE
         _LICZBA := _aa
      ENDIF
   CASE _DEC == 3
      _aa := Val( _ac + '.' + _a1 + _a2 + _a3 )
      IF _a4 == '5' .OR. _a4 == '6' .OR. _a4 == '7' .OR. _a4 == '8' .OR. _a4 == '9'
         _LICZBA := _aa + ( 0.001 * znak )
      ELSE
         _LICZBA := _aa
      ENDIF
   CASE _DEC == 4
      _aa := Val( _ac + '.' + _a1 + _a2 + _a3 + _a4 )
      IF _a5 == '5' .OR. _a5 == '6' .OR. _a5 == '7' .OR. _a5 == '8' .OR. _a5 == '9'
         _LICZBA := _aa + ( 0.0001 * znak )
      ELSE
         _LICZBA := _aa
      ENDIF
   CASE _DEC == 5
      _aa := Val( _ac + '.' + _a1 + _a2 + _a3 + _a4 + _a5 )
      IF _a6 == '5' .OR. _a6 == '6' .OR. _a6 == '7' .OR. _a6 == '8' .OR. _a6 == '9'
         _LICZBA := _aa + ( 0.00001 * znak )
      ELSE
         _LICZBA := _aa
      ENDIF
   CASE _DEC == 6
      _aa := Val( _ac + '.' + _a1 + _a2 + _a3 + _a4 + _a5 + _a6 )
      IF _a7 == '5' .OR. _a7 == '6' .OR. _a7 == '7' .OR. _a7 == '8' .OR. _a7 == '9'
         _LICZBA := _aa + ( 0.000001 * znak )
      ELSE
         _LICZBA := _aa
      ENDIF
   CASE _DEC == 7
      _aa := Val( _ac + '.' + _a1 + _a2 + _a3 + _a4 + _a5 + _a6 + _a7 )
      IF _a8 == '5' .OR. _a8 == '6' .OR. _a8 == '7' .OR. _a8 == '8' .OR. _a8 == '9'
         _LICZBA := _aa + ( 0.0000001 * znak )
      ELSE
         _LICZBA := _aa
      ENDIF
   ENDCASE

   RETURN _LICZBA

********************************
FUNCTION _INT( _LICZBA )

   LOCAL _as, _ac

   _as := Str( _LICZBA, 17, 5 )
   _ac := SubStr( _as, 1, 11 )
   _LICZBA := Val( _ac )

   RETURN _LICZBA

********************************
// TODO: Zmienne globalne: ident_fir, miesiac, mc_rozp
PROCEDURE ZAMEK()

   IF dostep( 'SUMA_MC' )
      SET INDEX TO suma_mc
      SEEK '+' + ident_fir
   ELSE
      close_()
      RETURN
   ENDIF

   DO WHILE suma_mc->del == '+' .AND. suma_mc->firma == ident_fir
      IF suma_mc->zamek
         IF suma_mc->mc > miesiac
            kom( 3, '*u', ' Firma rozpocz&_e.&_l.a dzia&_l.alno&_s.&_c. w miesi&_a.cu ' + RTrim( miesiac( Val( mc ) ) ) + ' ' )
            close_()
            RETURN
         ENDIF
         EXIT
      ENDIF
      SKIP
   ENDDO

   SEEK '+' + ident_fir + miesiac
   IF suma_mc->zamek
      kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
      close_()
      RETURN
   ENDIF

   IF mc_rozp < miesiac
      SKIP -1
      IF ! suma_mc->zamek
         kom( 3, '*u', ' Poprzedni miesi&_a.c nie jest zamkni&_e.ty ' )
         close_()
         RETURN
      ENDIF
      SKIP
   ENDIF
   **************************************
   @  3, 42 CLEAR TO 22, 79
   SET COLOR TO *w
   @ 12, 45 SAY '         U W A G A ! ! !           '
   @ 13, 45 SAY '       Zamkni&_e.cie miesi&_a.ca         '
   @ 14, 45 SAY '        uniemo&_z.liwi zmiany         '
   @ 15, 45 SAY '    ksi&_e.gowa&_n. z tego miesi&_a.ca.     '
   SET COLOR TO

   IF ! tnesc( '*i', ' Czy wykona&_c. zamkni&_e.cie ? (T/N) ' )
      close_()
      RETURN
   ENDIF
   IF ! tnesc( '*i', ' Jeste&_s. pewny ? (T/N) ' )
      close_()
      RETURN
   ENDIF

   BLOKADAR()
   repl_( 'zamek', .T. )
   COMMIT
   UNLOCK
   Tone( 200, 1 )
   close_()

   RETURN

*****************************************************************************
// TODO: Zmienne globalne: param_vat, zvat
PROCEDURE czyobrvat( kwota_obr )

   IF kwota_obr >= param_vat .AND. zvat#'T'
      KOMUN( 'Firma przekroczy&_l.a obroty ' + AllTrim( Str( param_vat, 9, 2 ) ) + '. Musisz przej&_s.&_c. na VAT (Parametry Firmy).' )
   ENDIF

   RETURN

******************************************************************************
// TODO: Zmienne globalne: param_lp
PROCEDURE numeruj()

   LOCAL CURR, zfirma, zlp

   IF param_lp == 'T'
      CURR := ColInb()
      @ 24, 0
      center( 24, 'Trwa nadawanie liczby porz&_a.dkowej KSI&__E.GI - prosz&_e. czeka&_c....' )
      SELECT 2
      DO WHILE ! dostepex( 'FIRMA' )
      ENDDO
      SELECT 1
      DO WHILE ! dostepex( 'OPER' )
      ENDDO
      SETIND( 'OPER' )
      IF param_kslp == '3'
         SET ORDER TO 4
      ENDIF
      zfirma := '   '

      DO WHILE oper->del == '+'
         IF oper->firma#zfirma
            zfirma := oper->firma
            SELECT firma
            GO Val( zfirma )
            zlp := firma->liczba
            SELECT oper
         ENDIF
         repl_( 'lp', zlp )
         zlp := zlp + 1
         SKIP
      ENDDO
      close_()

      @ 24, 0
      center( 24, 'Trwa nadawanie liczby porz&_a.dkowej EWIDENCJI- prosz&_e. czeka&_c....' )
      SELECT 2
      DO WHILE ! dostepex( 'FIRMA' )
      ENDDO
      SELECT 1
      DO WHILE ! dostepex( 'EWID' )
      ENDDO
      SETIND( 'EWID' )
      IF param_kslp == '3'
         SET ORDER TO 4
      ENDIF
      zfirma := '   '
      DO WHILE ewid->del == '+'
         IF firma#zfirma
            zfirma := firma
            SELECT firma
            GO Val( zfirma )
            zlp := firma->liczba
            SELECT ewid
         ENDIF
         repl_( 'lp', zlp )
         zlp := zlp + 1
         SKIP
      ENDDO
      close_()
      ColStd()
      @ 24, 0
   ENDIF

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± EOM  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Zastepuje funkcje CA-Tools. Oddaje date ostatniego dnia miesiaca podanej  ±
*±daty                                                                      ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION eom( _datka_ )

   LOCAL _miesi_rob, _datka_rob

   _datka_rob := _datka_
   _miesi_rob := SubStr( DToS( _datka_ ), 1, 6 )
   DO WHILE .T.
      _datka_rob := _datka_rob + 1
      IF SubStr( DToS( _datka_rob ),1 ,6 ) > _miesi_rob
         _datka_rob := _datka_rob - 1
         EXIT
      ENDIF
   ENDDO

   RETURN _datka_rob

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± LASTDAYOM ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Zastepuje funkcje CA-Tools. Oddaje numer ostatniego dnia miesiaca podanej ±
*±daty                                                                      ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION lastdayom( _datka_ )

   LOCAL _datka_rob, _miesi_rob

   _datka_rob := _datka_
   _miesi_rob := SubStr( DToS( _datka_ ),1 ,6 )
   DO WHILE .T.
      _datka_rob := _datka_rob + 1
      IF SubStr( DToS( _datka_rob ),1 ,6 ) > _miesi_rob
         _datka_rob := _datka_rob - 1
         EXIT
      ENDIF
   ENDDO

   RETURN Day( _datka_rob )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± NTOC      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Zastepuje funkcje CA-Tools. Oddaje liczbe w postaci binarnej              ±
*±                                                                          ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Do usuniecia - uzywana w proc4.prg z obsluga klucza sprzetowego
FUNCTION amintoc( nlong, nbase, nlength, cpad )

   LOCAL _b1_, _b2_, _b3_, _b4_, _b5_, _b6_, _b7_, _b8_

   _b1_ := _int( nlong / 128 )
   _b2_ := _int( ( nlong - ( _b1_ * 128 ) ) / 64 )
   _b3_ := _int( ( nlong - ( ( _b1_ * 128 ) + ( _b2_ * 64 ) ) ) / 32 )
   _b4_ := _int( ( nlong - ( ( _b1_ * 128 ) + ( _b2_ * 64 ) + ( _b3_ * 32 ) ) ) / 16 )
   _b5_ := _int( ( nlong - ( ( _b1_ * 128 ) + ( _b2_ * 64 ) + ( _b3_ * 32 ) + ( _b4_ *16 ) ) ) / 8 )
   _b6_ := _int( ( nlong - ( ( _b1_ * 128 ) + ( _b2_ * 64 ) + ( _b3_ * 32 ) + ( _b4_ * 16 ) + ( _b5_ * 8 ) ) ) / 4 )
   _b7_ := _int( ( nlong - ( ( _b1_ * 128 ) + ( _b2_ * 64 ) + ( _b3_ * 32 ) + ( _b4_ * 16 ) + ( _b5_ * 8 ) + ( _b6_ * 4 ) ) ) / 2 )
   _b8_ := _int( ( nlong - ( ( _b1_ * 128 ) + ( _b2_ * 64 ) + ( _b3_ * 32 ) + ( _b4_ * 16 ) + ( _b5_ * 8 ) + ( _b6_ * 4 ) + ( _b7_ * 2 ) ) ) / 1 )

   RETURN Str( _b1_, 1 ) + Str( _b2_, 1 ) + Str( _b3_, 1 ) + Str( _b4_, 1 ) + Str( _b5_, 1 ) + Str( _b6_, 1 ) + Str( _b7_, 1 ) + Str( _b8_, 1 )

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ZMIENKOLOR ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Standardowa funkcja podmieniajaca kolory po ich wyborze                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION zmienkolor

   LOCAL c1, c2, c3

   DO CASE
   CASE KINESKOP == 'M'
      CCCN := 'N'
      CCCW := 'W'
      CCCG := 'G'
      CCCGR := 'GR'
      CCCGRJ := 'GR+'
      CCCR := 'R'
      CCCRB := 'RB'
      CCCRBJ := 'RB+'
      CCCBG := 'BG'
      CCCB := 'B'
      c1 := CCCN + '/' + CCCW
      c2 := CCCW + '/' + CCCN
      c3 := CCCW + '+/' + CCCW
      CColErr := '&CCCGRJ/&CCCR,&CCCGRJ/&CCCRBJ,,&CCCN,&CCCR/&CCCN'
      CColInf := '&CCCG/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
      CColInb := '&CCCG*/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
      CColDlg := C2 + ',' + C1 + ',,&CCCN,&CCCN/&CCCW'
      CColStd := '&CCCGR/&CCCN,' + C3 + ',,&CCCGR/&CCCN,&CCCN/&CCCW'
      CColSta := '&CCCG/&CCCN,' + C3 + ',,&CCCN,&CCCG/&CCCN'
      CColSti := '&CCCW/&CCCN,' + C3 + ',,&CCCN,&CCCG/&CCCN'
      CColStb := '&CCCG*/&CCCN,' + C3 + ',,&CCCN,&CCCG/&CCCN'
      CColPro := C2 + ',' + C1 + ',,&CCCN,' + C2
      CColInv := '&CCCGR/&CCCN,&CCCN/&CCCW,,&CCCN,&CCCGR/&CCCN'
   CASE KINESKOP == 'K'
      CCCN='N'
      CCCW='W'
      CCCG='G'
      CCCGR='GR'
      CCCGRJ='GR+'
      CCCR='R'
      CCCRB='RB'
      CCCRBJ='RB+'
      CCCBG='BG'
      CCCB='B'
      CColErr='&CCCGRJ/&CCCR,&CCCGRJ/&CCCRBJ,,&CCCN,&CCCR/&CCCN'
      CColInf='&CCCG/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
      CColInb='&CCCG*/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
      CColDlg='&CCCN/&CCCGR,&CCCN/&CCCG,,&CCCN,&CCCN/&CCCW'
      CColStd='&CCCGR/&CCCN,&CCCN/&CCCG,&CCCGR/&CCCN,&CCCGR/&CCCN,&CCCN/&CCCW'
      CColSta='&CCCG/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
      CColSti='&CCCN/&CCCG,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
      CColStb='&CCCG*/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
      CColPro='&CCCN/&CCCGR,&CCCN/&CCCG,,&CCCN,&CCCN/&CCCGR'
      CColInv='&CCCGR/&CCCN,&CCCN/&CCCW,,&CCCN,&CCCGR/&CCCN'
   CASE KINESKOP == 'U'
      IF File( 'KOLUZYT.mem' )
         RESTORE FROM koluzyt ADDITIVE
         CColErr := '&CCCGRJ/&CCCR,&CCCGRJ/&CCCRBJ,,&CCCN,&CCCR/&CCCN'
         CColInf := '&CCCG/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
         CColInb := '&CCCG*/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
         CColDlg := '&CCCN/&CCCGR,&CCCN/&CCCG,,&CCCGR/&CCCN,&CCCN/&CCCW'
         CColStd := '&CCCGR/&CCCN,&CCCN/&CCCG,&CCCGR/&CCCN,&CCCN,&CCCN/&CCCW'
         CColSta := '&CCCG/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
         CColSti := '&CCCN/&CCCG,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
         CColStb := '&CCCG*/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
         CColPro := '&CCCN/&CCCGR,&CCCN/&CCCG,,&CCCN,&CCCN/&CCCGR'
         CColInv := '&CCCGR/&CCCN,&CCCN/&CCCW,,&CCCN,&CCCGR/&CCCN'
      ENDIF
   ENDCASE

   RETURN .T.

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± SPRAWDZVAT   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Funkcja podstawia stawki VAT z tabeli zgodnie z data kontekstowa          ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
// TODO: Globalne parametry: vat_A, vat_B, vat_C, vat_D
FUNCTION sprawdzVAT( selbazy, dzien )

   LOCAL _CurSel, jakiset

   _CurSel := Select()
   SELECT &selbazy
   DO WHILE ! dostepro( 'TAB_VAT' )
   ENDDO
   SET INDEX TO tab_vat


   jakiset := Set( _SET_SOFTSEEK )
   SET SOFTSEEK ON
   SEEK Descend( '+' + DToS( dzien ) )

   vat_A := tab_vat->stawka_A
   vat_B := tab_vat->stawka_B
   vat_C := tab_vat->stawka_C
   vat_D := tab_vat->stawka_D

   Set( _SET_SOFTSEEK, jakiset )
   USE
   SELECT &_CurSel

   RETURN .T.

*****************************************************************************
// TODO: Parametry globalne: param_rok
FUNCTION ROZRAPP( fZRODLO, fJAKIDOK, fNIP, fNRDOK, fDATAKS, fDATADOK, fTERMIN, fDNIPLAT, fRECNO, fKWOTA, fTRESC, fKWOTAVAT )
* JAKIDOK: FS i FZ (faktury zakupu i sprzedazy), ZS i ZZ (zaplaty za sprzedaz i zakupy)

   LOCAL fMNOZNIK

   IF fJAKIDOK == 'FS' .OR. fJAKIDOK == 'ZZ'
      fMNOZNIK := (-1)
   ELSE
      fMNOZNIK := 1
   ENDIF

   DOPAP()
   BLOKADAR()

   REPLACE FIRMA WITH ident_fir, ;
      NIP WITH fNIP, ;
      WYR WITH param_rok + '-' + fNRDOK, ;
      DATAKS WITH fDATAKS, ;
      DATADOK WITH fDATADOK, ;
      TERMIN WITH fTERMIN, ;
      DNIPLAT WITH fDNIPLAT, ;
      NRDOK WITH fNRDOK, ;
      ZRODLO WITH fZRODLO, ;
      RECNOZROD WITH fRECNO, ;
      RODZDOK WITH fJAKIDOK, ;
      MNOZNIK WITH fMNOZNIK, ;
      KWOTA WITH fKWOTA, ;
      KWOTAVAT WITH fKWOTAVAT, ;
      UWAGI WITH fTRESC, ;
      ROKKS WITH param_rok

   IF fJAKIDOK == 'FS' .OR. fJAKIDOK == 'ZS'
      REPLACE SPRZEDAZ WITH fKWOTA * fMNOZNIK
   ELSE
      REPLACE ZAKUP WITH fKWOTA * fMNOZNIK
   ENDIF

   COMMIT
   UNLOCK

   RETURN .T.

*****************************************************************************
// TODO: Parametry globalne: param_rok
function ROZRDEL( fZRODLO, fRECNO )

   SET ORDER TO 2
   BLOKADA()
   SEEK ident_fir + param_rok + fZRODLO + Str( frecno, 10 )
   IF Found()
      DO WHILE FIRMA + ROKKS + ZRODLO + Str( RECNOZROD, 10 ) == ident_fir + param_rok + fZRODLO + Str( frecno, 10 )
         DELE
         SKIP
      ENDDO
   ENDIF
   SET ORDER TO 1

   COMMIT
   UNLOCK

   RETURN .T.

*****************************************************************************
FUNCTION DodajBackslash( cSciezka )

   cSciezka = AllTrim( cSciezka )

   IF Len( cSciezka ) == 0
      RETURN cSciezka
   ENDIF

   IF SubStr( cSciezka, Len( cSciezka ), 1 ) <> '\'
      cSciezka := cSciezka + '\'
   ENDIF

   RETURN cSciezka


*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± K O N I E C ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
