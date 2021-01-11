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

PROCEDURE KartSTMo()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*set cent off

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou, _top_bot

   *@ 1,47 say [          ]
   *################################# GRAFIKA ##################################
   @ 17, 0 SAY 'ÚData zmianÂKwota(+/-)ÄOpis zmian¿'
   @ 18, 0 SAY '³          ³          ³          ³'
   @ 19, 0 SAY '³          ³          ³          ³'
   @ 20, 0 SAY '³          ³          ³          ³'
   @ 21, 0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ'
   ColInf()
   @ 17, 6 SAY 'Z'
   SET COLOR TO

   *############################### OTWARCIE BAZ ###############################
   SEEK '+' + zidp

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 18
   _col_l := 1
   _row_d := 20
   _col_p := 32
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28'
   _top := "del#'+'.or.ident#zidp"
   _bot := "del#'+'.or.ident#zidp"
   _stop := '+' + zidp
   _sbot := '+' + zidp + 'þ'
   *_sbot=[+]+ident_fir+_zident_+mmmie
   _proc := 'say41__()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         ins := ( kl # 109 .AND. kl # 77 ) .OR. &_top_bot
         rrer := RecNo()
         SKIP 1
         IF ins == .F. .AND. .NOT. Eof() .AND. del = '+' .AND. ident == zidp
            GO rrer
            kom( 3, '*u', ' Modyfikowa&_c. mo&_z.na tylko ostatni wpis ' )
         ELSE
            GO rrer
            @ 1, 47 SAY '          '
            IF ins
               ColStb()
               center( 23, 'þ                     þ' )
               ColSta()
               center( 23, 'W P I S Y W A N I E' )
               ColStd()
               RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
               wiersz := _row_d
            ELSE
               ColStb()
               center( 23, 'þ                       þ' )
               ColSta()
               center( 23, 'M O D Y F I K A C J A' )
               ColStd()
               wiersz := _row
            ENDIF
            BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
               IF ins
                  zDATA_MOD := Date()
                  zWART_MOD := 0
                  zOPIS_MOD := Space( 60 )
               ELSE
                  zDATA_MOD1 := DATA_MOD
                  zWART_MOD1 := WART_MOD
                  zDATA_MOD := DATA_MOD
                  zWART_MOD := WART_MOD
                  zOPIS_MOD := OPIS_MOD
               ENDIF
               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
               *if ins
               @ wiersz, _col_l      GET zDATA_MOD PICTURE '@D'
               *endif
               @ wiersz, _col_l + 11 GET zWART_MOD PICTURE '9999999.99'
               @ wiersz, _col_l + 22 GET zOPIS_MOD PICTURE '@S10 ' + repl( 'X', 60 )
               read_()
               IF LastKey() == 27
                  BREAK
               ENDIF
               ColStd()
               @ 24, 0
               SET COLOR TO
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               rrer := RecNo()
               _zrob := .F.
               *set soft on
               SEEK '+' + zidp + DToS( zDATA_MOD )
               *wait del+ident+dtos(data_mod)
               IF .NOT. Eof() .AND. del = '+' .AND. ident == zidp .AND. iif( ins, DATA_MOD >= zDATA_MOD, RecNo() # rrer )
                  kom( 3, '*u', ' Zmiany warto&_s.ci &_s.rodka trwa&_l.ego musz&_a. by&_c. wprowadzane chronologicznie ' )
               ELSE
                  _zrob := .T.
               ENDIF
               *set soft off
               GO rrer
               IF _zrob == .F.
                  BREAK
               ENDIF
               IF ins
                  app()
                  repl_( 'IDENT', zIDP )
               ENDIF
               BlokadaR()
               repl_( 'DATA_MOD', zDATA_MOD )
               repl_( 'WART_MOD', zWART_MOD )
               repl_( 'OPIS_MOD', zOPIS_MOD )
               commit_()
               UNLOCK
               *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
               IF ins
                  modyst( zdata_mod, zwart_mod )
               ELSE
                  modyst( zdata_mod1, zwart_mod1 * (-1) )
                  modyst( zdata_mod1, 0 )
                  modyst( zdata_mod, zwart_mod )
               ENDIF

               _row := Int( ( _row_g + _row_d ) / 2 )
               kl := 27
               IF .NOT. ins
                  BREAK
               ENDIF
               * @ _row_d,_col_l say &_proc
               Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
               @ _row_d, _col_l SAY '          ³          ³          '
            END
            _disp := ins .OR. LastKey() # 27
            kl := iif( LastKey() == 27 .AND. _row == -1, 27, kl )
            @ 23, 0
         ENDIF
      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         rrer := RecNo()
         SKIP 1
         IF .NOT. Eof() .AND. del = '+' .AND. ident == zidp
            GO rrer
            kom(3,[*u],[ Usuwa&_c. mo&_z.na tylko ostatni wpis ])
         ELSE
            GO rrer
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ                   þ' )
            ColSta()
            center( 23, 'K A S O W A N I E' )
            ColStd()
            _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
            IF _disp
               zDATA_MOD1 := DATA_MOD
               zWART_MOD1 := WART_MOD
               modyst( zdata_mod1, zwart_mod1 * (-1) )
               modyst( zdata_mod1, 0 )
               BlokadaR()
               del()
               COMMIT
               UNLOCK
               SKIP
               commit_()
               IF &_bot
                  SKIP -1
               ENDIF
               kl := 27
            ENDIF
            @ 23, 0
         ENDIF
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[ 3 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[ 4 ] := '   [Ins]...................wpisywanie                   '
         p[ 5 ] := '   [M].....................modyfikacja pozycji          '
         p[ 6 ] := '   [Del]...................kasowanie pozycji            '
         p[ 7 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 8 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         Pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   *close_()
   *set cent on

*################################## FUNKCJE #################################
PROCEDURE say41__()

   RETURN Transform( DATA_MOD, '@D' ) + '³' + Str( WART_MOD, 10, 2 ) + '³' + SubStr( OPIS_MOD, 1, 10 )

*############################################################################
PROCEDURE modyst( da_mo_, wa_mo_ )
***********************
   SELECT amort
   Blokada()
   zodro := Str( Year( DA_MO_ ) + 1, 4 )
   SEEK '+' + zIDP + zODRO
   IF Found()
      DO WHILE del + ident == '+' + zIDP .AND. ROK >= zODRO .AND. .NOT. Eof()
         DELETE
         SKIP
      ENDDO
   ENDIF
   SEEK '+' + zIDP + SubStr( DToS( DA_MO_ ), 1, 4 )
   IF Found()
      REPLACE wart_mod WITH wart_mod + wa_mo_
      kon := .F.
      zwart_pocz := wart_pocz
      zprzel := przel
      zstawka := stawka
      zwspdeg := wspdeg
      zwart_akt := ( zwart_pocz * zprzel ) + wart_mod
      zodpis_sum := umorz_akt
      zodpis_rok := 0
      zumorz_akt := zodpis_sum * zprzel
      zliniowo := _round( zwart_akt * ( zstawka / 100 ), 2 )
      zdegres := _round( ( zwart_akt - zumorz_akt ) * ( ( zstawka * zwspdeg ) / 100 ), 2 )
      zodpis_mie := iif( A->SPOSOB = 'L', _round( zliniowo / 12, 2 ), _round( iif( zliniowo >= zdegres, zliniowo / 12, zdegres / 12 ), 2 ) )
      odm := Month( da_mo_ )
      odr := Year( da_mo_ )
      FOR i := 1 TO odm
          zmcn := StrTran( Str( i, 2 ), ' ', '0' )
          zodpis_rok := zodpis_rok + mc&zmcn
          zodpis_sum := zodpis_sum + mc&zmcn
      NEXT
      FOR i := odm TO 12
         IF Month( da_mo_) = i .AND. Year( da_mo_ ) = odr
         ELSE
            zmcn := StrTran( Str( i, 2 ), ' ', '0' )
            REPLACE mc&zmcn WITH 0
         ENDIF
      NEXT
      DO WHILE .T.
         CURR := ColInf()
         @ 24, 0
         center( 24, 'Dopisuj&_e. rok ' + Str( odr, 4 ) )
         SetColor( CURR )
         SEEK '+' + zIDP + Str( ODR, 4 )
         IF .NOT. Found()
            app()
         ENDIF
         REPLACE firma WITH ident_fir, ;
            ident WITH zidp, ;
            rok WITH Str( odr, 4 ), ;
            wart_pocz WITH zwart_pocz, ;
            przel WITH zprzel, ;
            wart_akt WITH zwart_akt, ;
            umorz_akt WITH zumorz_akt, ;
            stawka WITH zstawka, ;
            wspdeg WITH zwspdeg, ;
            liniowo WITH zliniowo, ;
            degres WITH zdegres
         FOR i := odm TO 12
            zmcn := StrTran( Str( i, 2 ), ' ', '0' )
            IF Month( da_mo_ ) = i .AND. Year( da_mo_ ) = odr
            ELSE
               IF zodpis_mie > zwart_akt - zodpis_sum
                  REPLACE mc&zmcn WITH zwart_akt - zodpis_sum
                  zodpis_rok := zodpis_rok + ( zwart_akt - zodpis_sum )
                  zodpis_sum := zodpis_sum + ( zwart_akt - zodpis_sum )
                  kon := .T.
                  EXIT
               ELSE
                  REPLACE mc&zmcn WITH zodpis_mie
                  zodpis_rok := zodpis_rok + zodpis_mie
                  zodpis_sum := zodpis_sum + zodpis_mie
               ENDIF
            ENDIF
         NEXT
         REPLACE odpis_rok WITH zodpis_rok, ;
            odpis_sum WITH zodpis_sum
         COMMIT
         UNLOCK
         IF kon
            EXIT
         ELSE
            odm := 1
            odr++
            zwart_pocz := zwart_akt
            zprzel := 1
            zwart_akt := zwart_akt * zprzel
            zodpis_rok := 0
            zumorz_akt := zodpis_sum * zprzel
            zliniowo := _round( zwart_akt * ( zstawka / 100 ), 2 )
            zdegres := _round( ( zwart_akt - zumorz_akt ) * ( ( zstawka * zwspdeg ) / 100 ), 2 )
            zodpis_mie := iif( A->SPOSOB = 'L', _round( zliniowo / 12, 2 ), _round( iif( zliniowo >= zdegres, zliniowo / 12, zdegres / 12 ), 2 ) )
         ENDIF
      ENDDO
      COMMIT
      UNLOCK
   ENDIF
   SELECT kartstmo
   @ 24, 0

   RETURN NIL
