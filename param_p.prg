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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PARAM    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul parametrow programu przechowywanych w pliku PARAM_P.MEM             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Param_P()

*############################# PARAMETRY POCZATKOWE #########################
if .not.file([param_p.mem])
   save to param_p all like parap_*
   return
endif
if .not.file([param_ppk.mem])
   save to param_ppk all like parpk_*
   return
endif
*################################# GRAFIKA ##################################
@  3,42 say '-liczba dni wolnych finans.100%       '
@  4,42 say '-koszt uzyskania przychodu            '
//@  5,42 say '-miesi&_e.czne odliczenie podatku        '
@  5,42 say '-staw.zas.chorobowego (do33dni)     % '
//@  7,42 say '-stawka podatku dochodowego         % '
@  6,42 say '-limit odlicz. zdrow. dl lin.         '
@  7,42 say '                                      '
@  8,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍUbezpieczonyÍP&_l.atnik'
set colo to /w+
@  8,60 say 'Ubezpieczony'
@  8,73 say 'P&_l.atnik'
set colo to
@  9,42 say ' Dla    podstawa do ZUS(51,53)        '
@ 10,42 say ' wlasc.          do zdrow.(52)        '
@ 11,42 say '-emerytalne                           '
@ 12,42 say '-rentowe                              '
@ 13,42 say '-zdrowotne do ZUS                     '
@ 14,42 say '-zdrowotne do ZUS liniowo             '
@ 15,42 say '-chorobowe                            '
@ 16,42 say '-wypadkowe - wpisz w parametrach firmy'
@ 17,42 say '-III filar                            '
@ 18,42 say ' Na fundusze:                         '
@ 19,42 say '-Fundusz Pracy                        '
@ 20,42 say '-Fundusz G&__S.P                          '
@ 21,42 say ' Domy&_s.lny symbol Kasy Chorych         '
@ 22,42 say ' PPK st.pracow.     % st.pracod.     %'
*################################# OPERACJE #################################
do say_pr
kl=0
do while kl#27
ColSta()
@ 1,47 say '[F1]-pomoc'
ColStd()
kl=inkey(0)
do case
*############################### MODYFIKACJA ################################
              case kl=109.or.kl=77
@ 1,47 say [          ]
   ColStb()
   center(23,[þ                       þ])
   ColSta()
     center(23,[M O D Y F I K A C J A])
     ColStd()
                             begin sequence
*ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
zparap_p51=parap_p51
zparap_p52=parap_p52
zparap_kos=parap_kos
//zparap_odl=parap_odl
//zparap_pod=parap_pod
zparap_pli=parap_pli
zparap_cho=parap_cho
zparap_puz=parap_puz
zparap_pzk=parap_pzk
zparap_pue=parap_pue
zparap_pur=parap_pur
zparap_puc=parap_puc
zparap_puw=parap_puw
zparap_pfp=parap_pfp
zparap_pfg=parap_pfg
zparap_pf3=parap_pf3
zparap_fuz=parap_fuz
zparap_fue=parap_fue
zparap_fur=parap_fur
zparap_fuc=parap_fuc
zparap_fuw=parap_fuw
zparap_fww=parap_fww
zparap_ffp=parap_ffp
zparap_ffg=parap_ffg
zparap_ff3=parap_ff3
zparap_rkc=parap_rkc
zparpk_sz := parpk_sz
zparpk_sp := parpk_sp
zparap_ldw := parap_ldw
zparap_fzl := parap_fzl
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@  3,77 get zparap_ldw picture "999" range 0,999
@  4,73 get zparap_kos picture "9999.99" range 0,9999
//@  5,73 get zparap_odl picture "9999.99" range 0,9999
@  5,75 get zparap_cho picture '99'
//@  7,72 get zparap_pod picture '99.99'
@  6,72 get zparap_pli picture "99999.99" range 0,99999
@  9,73 get zparap_p51 picture "9999.99" range 0,9999
@ 10,73 get zparap_p52 picture "9999.99" range 0,9999
@ 11,65 get zparap_pue picture "99.99"
@ 12,65 get zparap_pur picture "99.99"
@ 13,65 get zparap_puz picture "99.99"
*@ 14,65 get zparap_pzk picture "99.99"
@ 15,65 get zparap_puc picture "99.99"
*@ 16,65 get zparap_puw picture "99.99"
@ 17,65 get zparap_pf3 picture "99.99"
@ 19,65 get zparap_pfp picture "99.99"
@ 20,65 get zparap_pfg picture "99.99"
@ 11,75 get zparap_fue picture "99.99"
@ 12,75 get zparap_fur picture "99.99"
@ 13,75 get zparap_fuz picture "99.99"
@ 14,75 get zparap_fzl picture "99.99"
@ 15,75 get zparap_fuc picture "99.99"
*@ 15,75 get zparap_fuw picture "99.99"
*@ 16,75 get zparap_fww picture "99.99"
@ 17,75 get zparap_ff3 picture "99.99"
@ 19,75 get zparap_ffp picture "99.99"
@ 20,75 get zparap_ffg picture "99.99"
@ 21,75 get zparap_rkc picture "99!"
@ 22,57 get zparpk_sz picture "99.99"
@ 22,74 get zparpk_sp picture "99.99"
****************************
clear type
read_()
if lastkey()=27
break
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
*do BLOKADAR
*repl_([A->parap_puw],zparap_puw)
*repl_([A->parap_fuw],zparap_fuw)
*repl_([A->parap_fww],zparap_fww)
*commit_()
*unlock

parap_p51=zparap_p51
parap_p52=zparap_p52
parap_kos=zparap_kos
//parap_odl=zparap_odl
//parap_pod=zparap_pod
parap_pli=zparap_pli
parap_cho=zparap_cho
parap_puz=zparap_puz
parap_pzk=zparap_pzk
parap_pue=zparap_pue
parap_pur=zparap_pur
parap_puc=zparap_puc
parap_puw=zparap_puw
parap_pfp=zparap_pfp
parap_pfg=zparap_pfg
parap_pf3=zparap_pf3
parap_fuz=zparap_fuz
parap_fue=zparap_fue
parap_fur=zparap_fur
parap_fuc=zparap_fuc
parap_fuw=zparap_fuw
parap_fww=zparap_fww
parap_ffp=zparap_ffp
parap_ffg=zparap_ffg
parap_ff3=zparap_ff3
parap_rkc=zparap_rkc
parpk_sz := zparpk_sz
parpk_sp := zparpk_sp
parap_ldw := zparap_ldw
parap_fzl := zparap_fzl
****************************
save to param_p all like parap_*
save to param_ppk all like parpk_*
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
                             end
do say_pr
@ 23,0
*################################### POMOC ##################################
              case kl=28
save screen to scr_
@ 1,47 say [          ]
declare p[20]
*---------------------------------------
p[ 1 ] := '                                                      '
p[ 2 ] := '     [M]...............modyfikacja                    '
p[ 3 ] := '     [D]...............przywr¢c domy˜lne warto˜ci     '
p[ 4 ] := '     [Esc].............wyj˜cie                        '
p[ 5 ] := '                                                      '
*---------------------------------------
set color to i
   i=20
   j=24
   do while i>0
      if type('p[i]')#[U]
      center(j,p[i])
      j=j-1
      endif
   i=i-1
   enddo
ColStd()
pause(0)
if lastkey()#27.and.lastkey()#28
keyboard chr(lastkey())
endif
restore screen from scr_
_disp=.f.

      CASE Kl == Asc( 'd' ) .OR. Kl == Asc( 'D' )
         IF TNEsc( , "Czy przywr¢ci† domy˜lne warto˜ci parametr¢w ? (Tak/Nie)" )
            DomParPrzywroc_Param_P( .T., DomParRok() )
            say_pr()
         ENDIF

******************** ENDCASE
endcase
enddo
close_()
*################################## FUNKCJE #################################
procedure say_pr
clear type
set colo to w+
@  3,77 say parap_ldw pict '999'
@  4,73 say parap_kos pict '9999.99'
//@  5,73 say parap_odl pict '9999.99'
@  5,75 say parap_cho pict [99]
//@  7,72 say parap_pod pict '99.99'
@  6,72 say parap_pli picture "99999.99"
@  9,73 say parap_p51 picture "9999.99"
@ 10,73 say parap_p52 picture "9999.99"
@ 11,65 say parap_pue picture "99.99"
@ 12,65 say parap_pur picture "99.99"
@ 13,65 say parap_puz picture "99.99"
*@ 14,65 say parap_pzk picture "99.99"
@ 15,65 say parap_puc picture "99.99"
*@ 15,65 say parap_puw picture "99.99"
@ 17,65 say parap_pf3 picture "99.99"
@ 19,65 say parap_pfp picture "99.99"
@ 20,65 say parap_pfg picture "99.99"
@ 11,75 say parap_fue picture "99.99"
@ 12,75 say parap_fur picture "99.99"
@ 13,75 say parap_fuz picture "99.99"
@ 14,75 say parap_fzl picture "99.99"
@ 15,75 say parap_fuc picture "99.99"
*@ 15,75 say parap_fuw picture "99.99"
*@ 16,75 say parap_fww picture "99.99"
@ 17,75 say parap_ff3 picture "99.99"
@ 19,75 say parap_ffp picture "99.99"
@ 20,75 say parap_ffg picture "99.99"
@ 21,75 say parap_rkc picture "99!"
@ 22,57 say parpk_sz picture "99.99"
@ 22,74 say parpk_sp picture "99.99"
ColStd()
*############################################################################

PROCEDURE Param_PRycz()

   LOCAL bPRyczPisz := { | |
      SET COLOR TO w+
      @  5, 70 SAY parap_frp PICTURE '99999.99'
      @  8, 55 SAY parap_rk1 PICTURE '999999.99'
      @  8, 75 SAY parap_rs1 PICTURE '999'
      @  9, 55 SAY parap_rk2 PICTURE '999999.99'
      @  9, 75 SAY parap_rs2 PICTURE '999'
      @ 10, 55 SAY parap_rk3 PICTURE '999999.99'
      @ 10, 75 SAY parap_rs3 PICTURE '999'
      @ 13, 76 SAY parap_rpz PICTURE '99'
      SET COLOR TO
   }
   LOCAL Kl

   PRIVATE zparap_frp, zparap_rk1, zparap_rs1, zparap_rk2, zparap_rs2, zparap_rk3, zparap_rs3, zparap_rpz

   IF .NOT. File( 'param_p.mem' )
      SAVE TO param_p ALL LIKE parap_*
      RETURN NIL
   ENDIF

   *################################# GRAFIKA ##################################
   @  3,42 CLEAR TO 22, 79
   @  3,42 say 'Przeci©tne miesi©czne wynagrodzenie w '
   @  4,42 say 'sektorze przedsi©biorstw w 4.kwartale '
   @  5,42 say 'roku poprzedniego                     '
   @  6,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
   @  7,42 say 'Miesi©czna podstawa wymiaru skˆadki   '
   @  8,42 say 'Przychody od            podstawa     %'
   @  9,42 say 'Przychody od            podstawa     %'
   @ 10,42 say 'Przychody od            podstawa     %'
   @ 11,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
   @ 12,42 say 'Procent zapˆaconej skˆadki zdrowotnej '
   @ 13,42 say 'o jaki b©d¥ pomniejszane przych.     %'
   *################################# OPERACJE #################################

   Eval( bPRyczPisz )

   Kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      Kl := Inkey( 0 )
      DO CASE
      *############################### MODYFIKACJA ################################
      CASE kl == 109 .OR. kl == 77
         @ 1,47 say '          '
         ColStb()
         center( 23, 'þ                       þ' )
         ColSta()
         center( 23, 'M O D Y F I K A C J A' )
         ColStd()
         BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            zparap_frp := parap_frp
            zparap_rk1 := parap_rk1
            zparap_rs1 := parap_rs1
            zparap_rk2 := parap_rk2
            zparap_rs2 := parap_rs2
            zparap_rk3 := parap_rk3
            zparap_rs3 := parap_rs3
            zparap_rpz := parap_rpz

            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @  5, 70 GET zparap_frp PICTURE '99999.99'
            @  8, 55 GET zparap_rk1 PICTURE '999999.99'
            @  8, 75 GET zparap_rs1 PICTURE '999'
            @  9, 55 GET zparap_rk2 PICTURE '999999.99'
            @  9, 75 GET zparap_rs2 PICTURE '999'
            @ 10, 55 GET zparap_rk3 PICTURE '999999.99'
            @ 10, 75 GET zparap_rs3 PICTURE '999'
            @ 13, 76 GET zparap_rpz PICTURE '99'

            ****************************
            CLEAR TYPEAHEAD
            read_()
            IF LastKey() == 27
               BREAK
            ENDIF

            parap_frp := zparap_frp
            parap_rk1 := zparap_rk1
            parap_rs1 := zparap_rs1
            parap_rk2 := zparap_rk2
            parap_rs2 := zparap_rs2
            parap_rk3 := zparap_rk3
            parap_rs3 := zparap_rs3
            parap_rpz := zparap_rpz

            SAVE TO param_p ALL LIKE parap_*
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
         END
         Eval( bPRyczPisz )
         @ 23,0

      *################################### POMOC ##################################
      CASE Kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                      '
         p[ 2 ] := '     [M]...............modyfikacja                    '
         p[ 3 ] := '     [D]...............przywr¢c domy˜lne warto˜ci     '
         p[ 4 ] := '     [Esc].............wyj˜cie                        '
         p[ 5 ] := '                                                      '
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
         ColStd()
         pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_

      CASE Kl == Asc( 'd' ) .OR. Kl == Asc( 'D' )
         IF TNEsc( , "Czy przywr¢ci† domy˜lne warto˜ci parametr¢w ? (Tak/Nie)" )
            DomParPrzywroc_Param_PRycz( .T., DomParRok() )
            Eval( bPRyczPisz )
         ENDIF

      ******************** ENDCASE
      ENDCASE
   ENDDO

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE Param_PPla()

   LOCAL cEkran, cKolor

   cEkran := SaveScreen()
   cKolor := ColStd()

   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot

   @  1, 47 say '          '

   *################################# GRAFIKA ##################################
   @  3,  12 CLEAR TO 22, 79
   @  3,  13 SAY 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
   @  4,  13 SAY 'º   Data   ³ Podatek ³Odlicz od ³Obni¾ zdro³ Ulga dla ³Odrocz.terº'
   @  5,  13 SAY 'º    od    ³    %    ³ podatku  ³ do 2021  ³ kl. ˜red.³pob.zaliczº'
   @  6,  13 SAY 'ºÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄº'
   @  7,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @  8,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @  9,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @ 10,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @ 11,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @ 12,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @ 13,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @ 14,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @ 15,  13 SAY 'º          ³         ³          ³          ³          ³          º'
   @ 16,  13 SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
   @ 17,  13 SAY 'Data od - data od kiedy b©d¥ obowi¥zywaˆy parametry.              '
   @ 18,  13 SAY 'Podatek - procent stawki podatku.                                 '
   @ 19,  13 SAY 'Odlicz od podatku - miesi©czna kwota odliczenia od podatku.       '
   @ 20,  13 SAY 'Obni¾ zdro. do 2021 - obni¾enie zdrowotnego to poziomu z 2021 r.  '
   @ 21,  13 SAY 'Ulga dla kl. ˜red. - czy ma by† stosowana ulga dla klasy ˜redniej.'
   @ 22,  13 SAY 'Odrocz.ter.pob.zalicz - odroczenie terminu poboru zaliczki pod.   '

   *############################### OTWARCIE BAZ ###############################
   DO WHILE.NOT.Dostep( 'TAB_PLA' )
   ENDDO
   SET INDEX TO tab_pla

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 7
   _col_l := 14
   _row_d := 15
   _col_p := 77
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,22,48,77,109,7,46,28,68,100'
   _top := 'Bof()'
   _bot := 'Eof()'
   _stop := ''
   _sbot := '-'
   _proc := 'liniaTabPla()'
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
      *############################ INSERT/MODYFIKACJA ############################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         @ 1, 47 SAY '          '
         ins := ( kl # 77 .AND. kl # 109 ) .OR. &_top_bot
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
         DO WHILE .T.
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zDATAOD := SToD("")
               zPODATEK := 0
               zODLICZ := 0
               zOBNIZZUS := "N"
               zAKTUKS := "N"
               zAKTPTERM := "N"
            ELSE
               zDATAOD := DATAOD
               zPODATEK := PODATEK
               zODLICZ := ODLICZ
               zOBNIZZUS := iif( OBNIZZUS, "T", "N" )
               zAKTUKS := iif( AKTUKS, "T", "N" )
               zAKTPTERM := iif( AKTPTERM, "T", "N" )
            ENDIF

            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz, 14 GET zDATAOD   PICTURE "@D"
            @ wiersz, 27 GET zPODATEK  PICTURE "99.99" RANGE 0, 99
            @ wiersz, 35 GET zODLICZ   PICTURE "9999999.99"
            @ wiersz, 49 GET zOBNIZZUS PICTURE "!" VALID ValidTakNie( zOBNIZZUS, wiersz, 50 )
            @ wiersz, 60 GET zAKTUKS   PICTURE "!" VALID ValidTakNie( zAKTUKS,   wiersz, 61 )
            @ wiersz, 71 GET zAKTPTERM PICTURE "!" VALID ValidTakNie( zAKTPTERM, wiersz, 72 )
            read_()
            SET CURSOR OFF
            IF LastKey() == 27
               EXIT
            ENDIF

            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
            ENDIF
            BlokadaR()
            repl_( 'DATAOD', zDATAOD )
            repl_( 'PODATEK', zPODATEK )
            repl_( 'ODLICZ', zODLICZ )
            repl_( 'OBNIZZUS', zOBNIZZUS == "T" )
            repl_( 'AKTUKS', zAKTUKS == "T" )
            repl_( 'AKTPTERM', zAKTPTERM == "T" )
            commit_()
            UNLOCK

            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '          ³         ³          ³          ³          ³          '
         ENDDO
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() == 27 .AND. _row == -1, 27, kl )
         @ 23, 0

      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa†? (T/N)   ' )
         if _disp
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
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         declare p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast©pna pozycja  '
         p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast©pna strona   '
         p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[ 5 ] := '   [Ins]...................wpisywanie                   '
         p[ 6 ] := '   [M].....................modyfikacja pozycji          '
         p[ 7 ] := '   [D].....................przywr¢† warto˜ci domy˜lne   '
         p[ 8 ] := '   [Del]...................kasowanie pozycji            '
         p[ 9 ] := '   [Esc]...................wyj˜cie                      '
         p[ 10] := '                                                        '
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
         pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.

      CASE kl == Asc( 'D' ) .OR. kl == Asc( 'd' )

         IF TNEsc( , "Czy przywr¢ci† domy˜ln¥ tabel© stawek i parametr¢w? (Tak/Nie)" )
            DomParPrzywroc_TabPla( .F., DomParRok() )
         ENDIF

      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()

   // Wyczysc tablice parametrow
   Param_PPla_Tab := NIL

   RETURN NIL

*################################## FUNKCJE #################################
FUNCTION liniaTabPla()

   RETURN DToC( DATAOD ) + "³  " + Str( PODATEK, 5, 2 ) + "  ³" + kwota( ODLICZ, 10, 2 ) + "³   " + iif( OBNIZZUS, 'Tak', 'Nie' ) + "    ³   " + iif( AKTUKS, 'Tak', 'Nie' ) + "    ³   " + iif( AKTPTERM, 'Tak', 'Nie' ) + "    "

***************************************************

PROCEDURE Param_PPla_WczytajTab()

   LOCAL nWrk := Select()

   Param_PPla_Tab := {}

   DO WHILE ! DostepPro( 'TAB_PLA', , .T., , 'TAB_PLA', .T. )
   ENDDO
   tab_pla->( dbGoTop() )
   DO WHILE ! tab_pla->( Eof() )
      AAdd( Param_PPla_Tab, PobierzRekord( 'tab_pla' ) )
      tab_pla->( dbSkip() )
   ENDDO
   tab_pla->( dbCloseArea() )

   Select( nWrk )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Param_PPla_param( cParam, dDataNa )

   LOCAL xWartosc := NIL, nI

   IF Empty( Param_PPla_Tab )
      Param_PPla_WczytajTab()
   ENDIF

   FOR nI := 1 TO Len( Param_PPla_Tab )
      IF Param_PPla_Tab[ nI ][ 'dataod' ] <= dDataNa
         xWartosc := Param_PPla_Tab[ nI ][ cParam ]
      ELSE
         EXIT
      ENDIF
   NEXT

   RETURN xWartosc

/*----------------------------------------------------------------------*/
