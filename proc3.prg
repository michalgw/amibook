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

#include "Inkey.ch"
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± FORM     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla menu drukowania-przegladania formularza. Parametry: 1-nazwa for-±
*±mularza i procedury drukujaco-wyswietlajacej,2-ilosc stron formularza,    ±
*±3-ilosc zalacznikow do danego formularza                                  ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
function form
RAPORT=RAPTEMP
parameters _nazwa,_ilstr,_ilel,_konw
private _p,_i,_m,_ilm,_dr_lm,_dr_lq,_dr_gr,ZZ,nStProfIdx := 0
   IF nWybProfilDrukarkiIdx == 0
      nWybProfilDrukarkiIdx := nDomProfilDrukarkiIdx
   ENDIF
_ilm=0
if pcount()=3
   _konw=1
endif
for _i=1 to _ilel
    _ilm=_ilm+_ilstr[_i]
next
_m=array(_ilm+1)
_m[_ilm+1]=' '+padc(' TEST ',16,'*')+' '
_dr_lq=2
for x=1 to (_ilm+1)
    xx=strtran(str(x,2),' ','0')
    _dr_lm&xx=0
    _dr_gr&xx=0
    _dr_mw&xx=1
    _dr_mwi&xx=0
    _dr_kod&xx='chr(27)+chr(74)+chr(0)                                      '
next

if _konw=1
   if file(_nazwa[1]+[.mem])
      restore from (_nazwa[1]) additive
   else
      save to (_nazwa[1]) all like _dr_*
   endif
   _ilm=0
   for _i=1 to _ilel
       for _p=1 to _ilstr[_i]
           _ilm++
           _m[_ilm]=' '+_nazwa[_i]+space(10-len(_nazwa[_i]))+' '+str(_p,2)+'/'+str(_ilstr[_i],2)
       next
   next
   ColPro()
   @ 20-_ilm,16 to 22,35
   ZZ=1
   do while ZZ<>0
      ColPro()
      ZZ=achoice(21-_ilm,17,21,34,_m,.t.,.t.,ZZ)
      save scre to formen
      if ZZ<>0
         set color to /w
         @ 20-_ilm+ZZ,17 say _m[ZZ]
         set color to /w*
         @ 20-_ilm+ZZ,34 say '°'
         set color to
         *נננננננננננננננננננננננננ GRAFIKA נננננננננננננננננננננננננ
         @ 11,42 clear to 22,42
         set color to i
         @ 11,43 say '           PARAMETRY DRUKOWANIA      '
         @ 12,43 say 'ֲִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ'
         @ 13,43 say '     ³ g&_o.rny margines (ilo&_s.&_c. wierszy)'
         @ 14,43 say 'ִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִֵ'
         @ 15,43 say '     ³ mikrowys&_o.w standardowy......1 '
         @ 16,43 say ' ile ³ definiowany.................2 '
         @ 17,43 say '     ³                               '
         @ 18,43 say 'ִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִֵ'
         @ 19,43 say '     ³ lewy margines (ilo&_s.&_c. znak&_o.w)  '
         @ 20,43 say 'ִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִֵ'
         @ 21,43 say '     ³ drukowanie dokladne.........1 '
         @ 22,43 say '     ³ drukowanie szybkie..........2 '
         xx=strtran(str(ZZ,2),' ','0')
         @ 13,45 say _dr_gr&xx picture [99]
         @ 15,45 say _dr_mw&xx picture [99]
         @ 17,45 say _dr_mwi&xx picture [99]
         @ 17,49 say substr(_dr_kod&xx,1,30)
         @ 19,45 say _dr_lm&xx picture [99]
         @ 22,45 say _dr_lq picture [99]
         set colo to
         save scre to paramdr
         if ZZ=_ilm+1
            _kl=0
            do while _kl<>27
               @ 23, 0
               @ 23, 0 SAY ' Profil: ' + PadR(aProfileDrukarek[nWybProfilDrukarkiIdx, 'nazwa'], 28) + '[P] - Profil drukarki  [W] - Ust.drukarki'
               center(24,'          [D]-drukowanie         [M]-modyfikacja parametr&_o.w drukowania          ')
               set color to
               IF param_dzw='T'
                  tone(400,1)
                  tone(400,1)
                  tone(400,1)
               endif
               _kl=0
               clear type
               do while _kl#27.and._kl#68.and._kl#77.and._kl#100.and._kl#109.AND._kl#80.AND._kl#112.AND._kl#87.AND._kl#119
                  _kl=inkey(0)
               enddo
               @ 23,0
               @ 24,0
               do case
               CASE _kl==80.OR._kl==112
                  nStProfIdx := WybierzProfilDrukarki(nWybProfilDrukarkiIdx)
                  IF nStProfIdx > 0
                     nWybProfilDrukarkiIdx := nStProfIdx
                  ENDIF
                  LOOP
               CASE _kl == 87 .OR. _kl == 119 // W
                  WinPrintPrinterSetupDlg(AllTrim(aProfileDrukarek[nWybProfilDrukarkiIdx, 'drukarka']))
                  LOOP
               case _kl=77.or._kl=109
                    begin sequence
                          *נננננננננננננננננננננננננ ZMIENNE נננננננננננננננננננננננננ
                          _drgr=_dr_gr&xx
                          _drmw=_dr_mw&xx
                          _drmwi=_dr_mwi&xx
                          _drkod=_dr_kod&xx
                          _drlm=_dr_lm&xx
                          _drlq=_dr_lq
                          *נננננננננננננננננננננננננננ GET נננננננננננננננננננננננננננ
                          ColStd()
                          @ 13,45 get _drgr picture [99] range 0,99
                          @ 15,45 get _drmw picture [99] range 1,2
                          @ 17,44 get _drmwi picture [999] when _drmw=1 range 0,180
                          @ 17,49 get _drkod picture '@S30 '+repl('X',60) when _drmw=2
                          @ 19,45 get _drlm picture [99] range 0,99
                          @ 22,45 get _drlq picture [99] range 1,2
                          clear type
                          read_()
                          if lastkey()=27
                             break
                          endif
                          *נננננננננננננננננננננננננננ REPL ננננננננננננננננננננננננננ
                          _dr_gr&xx =_drgr
                          _dr_mw&xx =_drmw
                          _dr_mwi&xx=_drmwi
                          _dr_kod&xx=_drkod
                          _dr_lm&xx =_drlm
                          _dr_lq    =_drlq
                          save to (_nazwa[1]) all like _dr_*
                          *נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
                    end
               case _kl=68.or._kl=100
                    //if isprinter()
                       ColInb()
                       @ 24,0
                       center(24,[Prosz&_e. czeka&_c....])
                       set colo to
                       //set device to print
                       //set print on
                       buforDruku = ''
                       prninit=chr(27)+[@]
                       if _dr_lq=1
                          prninit=prninit+chr(27)+'G'
                       endif
                       if _dr_mw&xx=1
                          prninit=prninit+chr(27)+'J'+chr(_dr_mwi&xx)
                       else
                          KODS=alltrim(_dr_kod&xx)
                          prninit=prninit+&KODS
                       endif
                       if _nazwa[1]='PRZELN' .or. _nazwa[1]='WPLATN'
                          do TEST with _dr_gr&xx,_dr_lm&xx,'PRZEL'
                       else
                          do TEST with _dr_gr&xx,_dr_lm&xx,'OGOLNY'
                       endif
                       //eject
                       //set print off
                       //set devi to scre
                       IF Len(buforDruku) > 0
                          buforDruku = buforDruku + kod_eject
                       ENDIF
                       drukujNowy(buforDruku, 1)
                       buforDruku = ''
                       ColStd()
                       @ 24,0 clear
                    //else
                      // kom(3,[*u],[ Drukarka nie jest gotowa do pracy ])
                    //endif
               endcase
            enddo
         else
            _kl=0
            do while _kl<>27
               rest scre from paramdr
               set color to i
               @ 13,45 say _dr_gr&xx picture [99]
               @ 15,45 say _dr_mw&xx picture [99]
               @ 17,45 say _dr_mwi&xx picture [99]
               @ 17,49 say substr(_dr_kod&xx,1,30)
               @ 19,45 say _dr_lm&xx picture [99]
               @ 22,45 say _dr_lq picture [99]
               set colo to
               save scre to paramdr
               @23, 0
               @23, 0 SAY ' Profil: ' + PadR(aProfileDrukarek[nWybProfilDrukarkiIdx, 'nazwa'], 30) + '[P] - Profil drukarki'
               center(24,' [Enter]-przegl&_a.danie   [D]-drukowanie   [M]-modyfikacja parametr&_o.w drukowania  ')
               set color to
               IF param_dzw='T'
                  tone(400,1)
                  tone(400,1)
                  tone(400,1)
               endif
               _kl=0
               clear type
               do while _kl#27.and._kl#13.and._kl#68.and._kl#77.and._kl#100.and._kl#109.AND._kl#80.AND._kl#112
                  _kl=inkey(0)
               enddo
               @ 23,0
               @ 24,0
               do case
               CASE _kl==80.OR._kl==112
                  nStProfIdx := WybierzProfilDrukarki(nWybProfilDrukarkiIdx)
                  IF nStProfIdx > 0
                     nWybProfilDrukarkiIdx := nStProfIdx
                  ENDIF
                  LOOP
               case _kl=77.or._kl=109
                    begin sequence
                    *נננננננננננננננננננננננננ ZMIENNE נננננננננננננננננננננננננ
                    xx=strtran(str(ZZ,2),' ','0')
                    _drgr=_dr_gr&xx
                    _drmw=_dr_mw&xx
                    _drmwi=_dr_mwi&xx
                    _drkod=_dr_kod&xx
                    _drlm=_dr_lm&xx
                    _drlq=_dr_lq
                    *נננננננננננננננננננננננננננ GET נננננננננננננננננננננננננננ
                    ColStd()
                    @ 13,45 get _drgr picture [99] range 0,99
                    @ 15,45 get _drmw picture [99] range 1,2
                    @ 17,44 get _drmwi picture [999] when _drmw=1 range 0,180
                    @ 17,49 get _drkod picture '@S30 '+repl('X',60) when _drmw=2
                    @ 19,45 get _drlm picture [99] range 0,99
                    @ 22,45 get _drlq picture [99] range 1,2
                    clear type
                    read_()
                    if lastkey()=27
                       break
                    endif
                    *נננננננננננננננננננננננננננ REPL ננננננננננננננננננננננננננ
                    _dr_gr&xx =_drgr
                    _dr_mw&xx =_drmw
                    _dr_mwi&xx=_drmwi
                    _dr_kod&xx=_drkod
                    _dr_lm&xx =_drlm
                    _dr_lq    =_drlq
                    save to (_nazwa[1]) all like _dr_*
                    *נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
                    end
               case _kl=68.or._kl=100
                    //if isprinter()
                       prninit=chr(27)+[@]
                       if _dr_lq=1
                          prninit=prninit+chr(27)+'G'
                       endif
                       if _dr_mw&xx=1
                          prninit=prninit+chr(27)+'J'+chr(_dr_mwi&xx)
                       else
                          KODS=alltrim(_dr_kod&xx)
                          prninit=prninit+&KODS
                       endif
                       formproc=strtran(alltrim(substr(_m[ZZ],2,10)),'-','_')
                       formstro=val(alltrim(substr(_m[ZZ],13,2)))
                       do &formproc with _dr_gr&xx,_dr_lm&xx,formstro,'D'
                       ColInb()
                       @ 24,0
                       center(24,[Prosz&_e. czeka&_c....])
                       //set colo to
                       //set device to print
                       //set print on
                       select 100
                       do while.not.dostepex(RAPORT)
                       enddo
                       go top
                       //@ 0,0 say prninit
                       buforDruku = prninit + Chr(13)
                       LL=0
                       do while .not. eof()
                          //@ LL,0 say substr(linia_l,1,80)
                          LL++
                          buforDruku = buforDruku + substr(linia_l,1,80) + &kod_lf
                          skip
                       enddo
                       //eject
                       //set print off
                       //set devi to scre
                       //set colo to
                       IF Len(buforDruku) > 0
                          buforDruku = buforDruku + kod_eject
                       ENDIF
                       drukujNowy(buforDruku, 1)
                       buforDruku = prninit
                       @ 24,0 clear
                       save scre to PRZE
                       select 100
                       do while.not.dostepex(RAPORT)
                       enddo
                       zap
                       rest scre from PRZE
                    //else
                      // kom(3,[*u],[ Drukarka nie jest gotowa do pracy ])
                    //endif
               case _kl=13
                    save scre to PRZE
                    formproc=strtran(alltrim(substr(_m[ZZ],2,10)),'-','_')
                    formstro=val(alltrim(substr(_m[ZZ],13,2)))
                    do &formproc with _dr_gr&xx,_dr_lm&xx,formstro,'P'
                    ColInb()
                    @ 24,0
                    center(24,[Prosz&_e. czeka&_c....])
                    select 100
                    do while.not.dostepex(RAPORT)
                    enddo
                    priv A_POLE
                    A_POLE=array(1)
                    A_POLE[1]='LINIA_L'
                    ColSti()
                    @ 0,0 say status()
                    @ 0,45 say '[F4] - drukowanie'
                    @ 24,1 clear to 24,78
                    @ 24,1 say 'Wprowad&_x. szukany TEKST ִ'
                    set color to
                    dbedit(1,0,23,79,A_pole,'przegform',.t.,padc('FORMULARZ: '+alltrim(substr(_m[ZZ],2,10)),80),'ֽ',.t.,.t.,.t.)
                    zap
                    rest scre from PRZE
                    rele A_POLE
               endcase
            enddo
         endif
      endif
      rest scre from formen
   enddo
endif
return .t.
*******************
function PRZEGFORM
*******************

para status,fld_ptr

priv key

lwyn=.f.
KEY = lastkey()
do case
case key>=48 .and. key<=122
*  SZUKAJ = ''
  KLL = chr(lastkey())
  save screen to ROBSCREEN1
  keyb KLL
  set cursor on
  ColSti()
  @ 24,1 clear to 24,78
  @ 23,1 say ''
  accept ' Wprowad&_x. szukany TEKST ִ' to SZUKAJ
  set cursor off
  set color to
  rest screen from ROBSCREEN1
  locate rest for upper(SZUKAJ)$upper(LINIA_L)
  keyb chr(32)
  return 2
case key=K_F4
  keyb chr(32)
  RECS=recno()
  go top
  //if isprinter()
     ColInb()
     @ 24,0 clear
     center(24,[Prosz&_e. czeka&_c....])
     prninit=chr(27)+[@]
     //set color to
     //set device to print
     //set print on
     //set cons off
     //? prninit+linia_l
     buforDruku = prninit + linia_l + &kod_lf
     skip
     LL=2
     do while .not. eof()
        //? substr(linia_l,1,80)
        buforDruku = buforDruku + substr(linia_l,1,80) + &kod_lf
        LL++
        skip
        if LL=57
           //eject
           IF Len(buforDruku) > 0
              buforDruku = buforDruku + kod_eject
           ENDIF
           IF aProfileDrukarek[nWybProfilDrukarkiIdx, 'podzialstr'] == .T.
              drukujNowy(buforDruku, 1)
              buforDruku = prninit + Chr(13)
              //set print off
              //set devi to scre
              //set cons on
              clea type
              kom(0,[*u],[ Zmie&_n. kartk&_e. i naci&_s.nij klawisz ENTER ])
              if lastkey()=27
                 exit
              else
                // do while .not.isprinter()
                  //  kom(0,[*u],[ Zmie&_n. kartk&_e. i naci&_s.nij klawisz ENTER ])
                    //if lastkey()=27
                      // exit
                    //endif
                 //enddo
                 clea type
                 LL=1
              endif
              //set device to print
              //set print on
              //set cons off
           ENDIF
        endif
        if lastkey()=27
           exit
        endif
     enddo
     IF Len(buforDruku) > 0
        buforDruku = buforDruku + kod_eject
     ENDIF
     drukujNowy(buforDruku, 1)
     buforDruku = ''
     //if isprinter()
        //eject
     //endif
     //set print off
     //set devi to scre
     //set cons on
     //set color to
     @ 24,0
  //else
    //kom(0,[*u],[ Drukarka nie jest gotowa do pracy ])
  //endif
  ColSti()
  @ 24,1 clear to 24,78
  @ 24,1 say 'Wprowad&_x. szukany TEKST ִ'
  set color to
  go RECS
  keyb chr(32)
  return 2
case key=27
  SOR = 0
  return 0
case key=13
* SOR = 0
* return 0
case key=1
  go top
case key=6
  go bottom
endcase
return 1
*******************
function RL
*******************
***** Replace line - zastapienie linii do przegladania trescia
para TEKST
appe blan
if pcount()<>0
   repl linia_l with TEKST
endif
return
