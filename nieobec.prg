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

PROCEDURE Nieobec()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*set cent off

   LOCAL bWhKod := { ||
      LOCAL cTmpKod := zKODZUS
      IF Param_PZUSKodyNieob( .T., @cTmpKod )
         zKODZUS := cTmpKod
         //GetList[ 4 ]:display()
      ENDIF
      RETURN .T.
   }

   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot
   PRIVATE _stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz
   PRIVATE f10,rec,fou,_top_bot
   PRIVATE cEkran

   @  1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   @  8, 42 SAY 'ÚOdÂDoÂPrzyczyna nieobÂKod¿'
   @  9, 42 SAY '³  ³  ³               ³   ³'
   @ 10, 42 SAY '³  ³  ³               ³   ³'
   @ 11, 42 SAY '³  ³  ³               ³   ³'
   @ 12, 42 SAY '³  ³  ³               ³   ³'
   @ 13, 42 SAY 'ÀÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÙ'

   *############################### OTWARCIE BAZ ###############################
   SELECT prac
   _zident_ := Str( rec_no, 5 )
   SELECT nieobec
   mmmie := etaty->mc
   SEEK '+' + ident_fir + _zident_ + mmmie

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 9
   _col_l := 43
   _row_d := 12
   _col_p := 67
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28'
   _top := "del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc#mmmie"
   _bot := "del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc#mmmie"
   _stop := '+' + ident_fir + _zident_ + mmmie
   *_sbot=[+]+ident_fir+_zident_+mmmie+[þ]
   _sbot := '+' + ident_fir + _zident_ + mmmie
   _proc := 'say41_()'
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
      CASE kl = 22 .OR. kl = 48 .OR. _row = -1 .OR. kl = 77 .OR. kl = 109
         @ 1, 47 SAY '          '
         ins := ( kl # 109 .AND. kl # 77 ) .OR. &_top_bot
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
               zDDOD := Day( Date() )
               zDDDO := Day( Date() )
               zPRZYCZYNA := Space( 15 )
               zKODZUS := '   '
            ELSE
               zDDOD := DDOD
               zDDDO := DDDO
               zPRZYCZYNA := PRZYCZYNA
               zKODZUS := KODZUS
            ENDIF
            zPRZYCZ := SubStr( zPRZYCZYNA, 1, 1 )
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz, _col_l      GET zDDOD   PICTURE '99' RANGE 1,31
            @ wiersz, _col_l + 3  GET zDDDO   PICTURE '99' RANGE 1,31
            @ wiersz, _col_l + 6  GET zPRZYCZ PICTURE '!' WHEN wPOKAPRZY() VALID vPOKAPRZY( zPRZYCZ )
            @ wiersz, _col_l + 22 GET zKODZUS PICTURE '!!!' WHEN Eval( bWhKod )
            read_()
            IF LastKey() = 27
               BREAK
            ENDIF
            ColStd()
            @ 24, 0
            SET COLOR TO
            DO CASE
            CASE zPRZYCZ = 'I'
               zPRZYCZYNA := 'Inne url.(okol)'
            CASE zPRZYCZ='U'
               zPRZYCZYNA := 'Urlop wypoczynk'
            CASE zPRZYCZ='C'
               zPRZYCZYNA := 'Choroba (L-4)'
            CASE zPRZYCZ='Z'
               zPRZYCZYNA := 'Zawod.chor,itp.'
            CASE zPRZYCZ='O'
               zPRZYCZYNA := 'Opieka'
            CASE zPRZYCZ='W'
               zPRZYCZYNA := 'Wychowawczy url'
            CASE zPRZYCZ='B'
               zPRZYCZYNA := 'Bezplatny urlop'
            CASE zPRZYCZ='N'
               zPRZYCZYNA := 'NN'
            CASE zPRZYCZ='M'
               zPRZYCZYNA := 'Macierzynski ur'
            CASE zPRZYCZ='P'
               zPRZYCZYNA := 'Plat.zas.chor.'
            ENDCASE
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
               repl_( 'FIRMA', IDENT_FIR )
               repl_( 'IDENT', _zIDENT_ )
               repl_( 'MC', mmmie )
            ENDIF
            BlokadaR()
            repl_( 'DDOD', zDDOD )
            repl_( 'DDDO', zDDDO )
            repl_( 'PRZYCZYNA', zPRZYCZYNA )
            repl_( 'KODZUS', zKODZUS )
            commit_()
            UNLOCK
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               BREAK
            ENDIF
            * @ _row_d,_col_l say &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '  ³  ³               ³   '
         END
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() = 27 .AND. _row = -1, 27, kl )
         @ 23, 0

      *################################ KASOWANIE #################################
      CASE kl = 7 .OR. kl = 46
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR()
            del()
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         @ 23, 0

      *################################### POMOC ##################################
      CASE kl = 28
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
            if Type( 'p[i]' ) # 'U'
               center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         pause( 0 )
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
PROCEDURE say41_()

   RETURN Str( DDOD, 2 ) + '³' + Str( DDDO, 2 ) + '³' + PRZYCZYNA + '³' + KODZUS

*############################################################################
FUNCTION wPOKAPRZY()
*************************************
   cEkran := SaveScreen( 23, 0, 24, 79 )
   ColInf()
   @ 23, 0 SAY PadC( 'C-80%,Z-100%,O-opieka,N-NN,urlopy:U-wypocz,I-okolicz,W-wychow,B-bezpl,M-macierz', 80, ' ' )
   @ 24, 0 SAY Pad( 'P-Zasiˆek chorobowy pˆatne ZUS', 80, ' ' )
   ColStd()

   RETURN .T.

*******************************************************
FUNCTION vPOKAPRZY( VSP )
*******************************************************
   LOCAL cPole

   IF .NOT. VSP $ 'IUCZOWBMNP'
      //kom(1,[*u],padc([C-80%,Z-100%,O-opieka,N-NN,urlopy:U-wypocz,I-okolicz,W-wychow,B-bezpl,M-macierz],80))
      ColInf()
      @ 23, 0 SAY PadC( 'C-80%,Z-100%,O-opieka,N-NN,urlopy:U-wypocz,I-okolicz,W-wychow,B-bezpl,M-macierz', 80, ' ' )
      @ 24, 0 SAY Pad( 'P-Zasiˆek chorobowy pˆatne ZUS', 80, ' ' )
      ColStd()
      zPRZYCZ := SubStr( zPRZYCZYNA, 1, 1 )
      RETURN .F.
   ELSE
      RestScreen( 23, 0, 24, 79, cEkran )
      @ 24, 0
      cPole := 'parap_kn' + zPRZYCZ
      zKODZUS := &cPole
   ENDIF

   RETURN .T.
