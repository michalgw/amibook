/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

* do 99 999 999 faktur w sumie na wszystkie firmy
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
private _top,_bot,_top_bot,_stop,_sbot,_proc,kl,ins,nr_rec,f10,rec,fou
*################################# GRAFIKA ##################################
@  0, 0 say '                    F A K T U R A     Nr        z dnia                          '
@  1, 0 say 'Dla  :............................................................              '
@  2, 0 say 'Adres:........................................                                  '
@  3, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
@  4, 0 say '³     Nazwa towaru/us&_l.ugi    ³    Ilo&_s.&_c.    ³ Jm  ³  Cena jedn.  ³    Warto&_s.&_c.   ³'
@  5, 0 say 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
@  6, 0 say '³                            ³             ³     ³              ³              ³'
@  7, 0 say '³                            ³             ³     ³              ³              ³'
@  8, 0 say '³                            ³             ³     ³              ³              ³'
@  9, 0 say '³                            ³             ³     ³              ³              ³'
@ 10, 0 say '³                            ³             ³     ³              ³              ³'
@ 11, 0 say '³                            ³             ³     ³              ³              ³'
@ 12, 0 say '³                            ³             ³     ³              ³              ³'
@ 13, 0 say '³                            ³             ³     ³              ³              ³'
@ 14, 0 say '³                            ³             ³     ³              ³              ³'
@ 15, 0 say '³                            ³             ³     ³              ³              ³'
@ 16, 0 say '³                            ³             ³     ³              ³              ³'
@ 17, 0 say '³                            ³             ³     ³              ³              ³'
@ 18, 0 say '³                            ³             ³     ³              ³              ³'
@ 19, 0 say '³                            ³             ³     ³              ³              ³'
@ 20, 0 say '³                            ³             ³     ³              ³              ³'
@ 21, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
@ 22, 0 say '                                                                                '
*############################### OTWARCIE BAZ ###############################
select 6
if dostep('KONTR')
   do setind with 'KONTR'
else
   sele 2
   close_()
   return
endif
select 5
if dostep('FIRMA')
   go val(ident_fir)
else
   sele 2
   close_()
   return
endif
select 4
if dostep('SUMA_MC')
   set inde to suma_mc
   seek [+]+ident_fir+miesiac
else
   sele 2
   close_()
   return
endif
select 3
if dostep('OPER')
   do SETIND with 'OPER'
   set orde to 3
else
   sele 2
   close_()
   return
endif
select 1
if dostep('POZYCJE')
   set inde to pozycje
else
   sele 2
   close_()
   return
endif
select 2
if dostep('FAKTURY')
   do SETIND with 'FAKTURY'
   set orde to 2
*   set inde to faktury1,faktury2,faktury
   seek [+]+ident_fir+miesiac
else
   sele 2
   close_()
   return
endif
if .not.found().and.suma_mc->zamek
   kom(3,[*u],[ Brak danych (miesi&_a.c jest zamkni&_e.ty) ])
   close_()
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_top=[firma#ident_fir.or.mc#miesiac]
_bot=[del#'+'.or.firma#ident_fir.or.mc#miesiac]
_stop=[+]+ident_fir+mc
_sbot=[+]+ident_fir+mc+[þ]
_proc=[say2603]
*----------------------
_top_bot=_top+[.or.]+_bot
if .not.&_top_bot
   do &_proc
endif
kl=0
do while kl#27
   kl=inkey(0)
   do ster
   do case
*########################### INSERT/MODYFIKACJA #############################
   case kl=22.or.kl=48.or.kl=109.or.kl=77.or.&_top_bot
        ins=(kl#109.and.kl#77).OR.&_top_bot
        ktoroper()
        begin sequence
              *-------zamek-------
              if suma_mc->zamek
                 kom(3,[*u],[ Miesi&_a.c jest zamkni&_e.ty ])
                 break
              endif
              *-------------------
              if ins.and.month(date())#val(miesiac).and.del=[+].and.firma=ident_fir.and.mc=miesiac
                 if .not.tnesc([*u],[ Jest ]+upper(rtrim(miesiac(month(date()))))+[ - jeste&_s. pewny? (T/N) ])
                    break
                 endif
              endif
              *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
              declare ztowar[15],zilosc[15],zjm[15],zcena[15],zwartosc[15]
              for i=1 to 15
                  ztowar[i]=space(58)
                  zilosc[i]=0
                  zjm[i]=space(5)
                  zcena[i]=0
                  zwartosc[i]=0
              next
              if ins
                 @ 6,65 clear to 20,75
                 zrach=' '
                 zNUMER=firma->nr_rach
                 zDZIEN=[  ]
                 znazwa=space(70)
                 zADRES=space(40)
                 zsposob_p=2
                 ztermin_z=0
                 zkwota=0
                 znr_ident=space(30)
                 @ 2,47 say repl([.],32)
                 @ 22,0
              else
                 zrach=' '
                 zNUMER=NUMER
                 zDZIEN=DZIEN
                 znazwa=nazwa
                 zADRES=ADRES
                 zsposob_p=sposob_p
                 zkwota=kwota
                 znr_ident=nr_ident
                 ztermin_z=termin_z
                 zident_poz=str(rec_no,8)
                 select pozycje
                 seek [+]+zident_poz
                 i=0
                 do while del=[+].and.ident=zident_poz
                    i=i+1
                    ztowar[i]=towar
                    zilosc[i]=ilosc
                    zjm[i]=jm
                    zcena[i]=cena
                    zwartosc[i]=wartosc
                    skip
                 enddo
                 select faktury
              endif
              *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
              set color to +w
              @ 0,41 say strtran(str(zNUMER,5),[ ],[0])
              set color to
              @ 0,55 get zDZIEN picture "99" valid v26_103()
              @ 1,6 get znazwa picture repl('!',70) valid v26_203()
              @ 2,6 get zADRES picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
              for i=1 to 15
                  @ 5+i, 1 get ztowar[i]   picture [@s28 !]+repl([X],45) valid v26_503()
                  @ 5+i,30 get zilosc[i]   picture "  9999999.999" valid v26_603()
                  @ 5+i,44 get zjm[i]      picture "XXXXX"         valid v26_703()
                  @ 5+i,50 get zcena[i]    picture "   99999999.99" valid v26_803()
                  @ 5+i,65 get zwartosc[i] picture "   99999999.99" valid v26_903()
              next
              wiersz=1
              clear type
              read_()
              set confirm off
              if lastkey()=27
                 break
              endif
              *-----kontrola wartosci faktury-----
              razem=0
              for i=1 to 15
                  razem=razem+zwartosc[i]
              next
              if razem>999999999
                 kom(3,[*u],[ Przekroczony zakres warto&_s.ci faktury ])
                 break
              endif
              *-----------------------------------
              @ 22,0
              @ 22, 9 prompt '[P&_l.atne przelewem]'
              @ 22,33 prompt '[P&_l.atne got&_o.wk&_a.]'
              @ 22,55 prompt '[P&_l.atne czekiem]'
              zsposob_p=menu(zsposob_p)
              @ 22,0
              if lastkey()=27
                 break
              endif
              set color to +w
              do case
              case zsposob_p=1
                   if ins
                      ztermin_z=0
                   endif
                   zkwota=0
                   @ 22,24 say [P&_l.atne przelewem w ci&_a.gu    dni]
                   @ 22,49 get ztermin_z picture [99] range 1,99
                   read_()
                   if lastkey()=27
                      set color to
                      break
                   endif
              case zsposob_p=2
                   @ 22,15 say [P&_l.atne w terminie    dni,]
                   @ 22,33 get ztermin_z picture [99] valid v26_1003()
                   @ 22,41 say [zap&_l.acono] get zkwota picture [   99999999.99] range 0,99999999999
                   read_()
                   if lastkey()=27
                      set color to
                      break
                   endif
              case zsposob_p=3
                   @ 22,25 say [       Zap&_l.acono czekiem       ]
                   zkwota=0
              endcase
              set color to
              zdzien=str(val(zdzien),2)
              znazwa=znazwa
              *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
              select kontr
              if .not.empty(znazwa).and.param_aut=[T]
                 seek [+]+ident_fir+substr(znazwa,1,15)+substr(zadres,1,15)
                 if .not.found()
                    app()
                    repl_([firma],ident_fir)
                    repl_([nazwa],znazwa)
                    repl_([adres],zadres)
                    unlock
                 endif
              endif
              select firma
              if ins
                 do BLOKADAR
                 repl_([nr_rach],nr_rach+1)
                 unlock
              endif
              select faktury
              if ins
                 do BLOKADA
                 set orde to 4
                 go bott
                 z_rec_no=rec_no+1
                 set orde to 2
                 app()
                 repl_([rec_no],z_rec_no)
              endif
              do BLOKADAR
              repl_([firma],ident_fir)
              repl_([mc],miesiac)
              repl_([NUMER],zNUMER)
              repl_([DZIEN],zDZIEN)
              repl_([nazwa],znazwa)
              repl_([ADRES],zADRES)
              repl_([NR_IDENT],zNR_IDENT)
              repl_([sposob_p],zsposob_p)
              repl_([termin_z],ztermin_z)
              repl_([kwota],zkwota)
              unlock
              zident_poz=str(rec_no,8)
              select pozycje
              seek [+]+zident_poz
              razem=0
              for i=1 to 15
                  if empty(ztowar[i])
                     do while del=[+].and.ident=zident_poz
                        skip
                        nr_rec=recno()
                        skip -1
                        do BLOKADAR
                        repl_([del],[-])
                        unlock
                        go nr_rec
                     enddo
                     exit
                  else
                     razem=razem+zwartosc[i]
                     if del#[+].or.ident#zident_poz
                        app()
                        repl_([ident],zident_poz)
                     endif
                     do BLOKADAR
                     repl_([towar],ztowar[i])
                     repl_([ilosc],zilosc[i])
                     repl_([jm],zjm[i])
                     repl_([cena],zcena[i])
                     repl_([wartosc],zwartosc[i])
                     unlock
                     skip
                  endif
              next
              razem=_round(razem,2)
              *========================= Ksiegowanie ========================
              if zRYCZALT<>'T'
                 select oper
                 REC=recno()
                 set inde to
                 go bott
                 ILREK=recno()
                 do SETIND with 'OPER'
                 set orde to 3
                 go REC
                 if ins
                    app()
                    repl_([firma],ident_fir)
                    repl_([mc],miesiac)
                    repl_([zapis],ILREK)
                    repl_([numer],[S-]+strtran(str(znumer,5),[ ],[0]) + '/' + param_rok)
                    repl_([tresc],[Sprzedaz wg rachunku])
                    repl_([ZAKUP],0)
                    repl_([UBOCZNE],0)
                    repl_([WYNAGR_G],0)
                    repl_([WYDATKI],0)
                    repl_([UWAGI],space(14))
                    razem_=0
                    rodzaj=zilosc[1]*1000#0
                 else
                    seek [+]+ident_fir+miesiac+[S-]+strtran(str(znumer,5),[ ],[0])
                    razem_=wyr_tow
                    rodzaj=(wyr_tow#0)
                 endif
                 do BLOKADAR
                 repl_([dzien],zdzien)
                 repl_([nazwa],znazwa)
                 repl_([adres],zadres)
                 repl_([wyr_tow],razem)
                 if zsposob_p=1.or.zsposob_p=3
                    if zsposob_p=3.and.nr_uzytk=6
                       repl_([zaplata],[1])
                    else
                       repl_([zaplata],[3])
                    endif
                 else
                    if ztermin_z=0
                       repl_([zaplata],[1])
                    else
                       if zkwota=0
                          repl_([zaplata],[3])
                       else
                          repl_([zaplata],[2])
                       endif
                    endif
                 endif
                 repl_([kwota],zkwota)
                 unlock
                 set order to 1
                 *********************** lp
                 if nr_uzytk>=0
                    if param_lp=[T]
                       do BLOKADA
                       do czekaj
                       rec=recno()
                       if ins
                          skip -1
                          if bof().or.firma#ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                             zlp=firma->liczba
                          else
                             zlp=lp+1
                          endif
                          go rec
                          do while del=[+].and.firma=ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                             repl_([lp],zlp)
                             zlp=zlp+1
                             skip
                          enddo
                       else
                          zlp=lp
                          skip -1
                          if bof().or.firma#ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                             zlp=firma->liczba
                             go rec
                             do while del=[+].and.firma=ident_fir.and.lp#zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                                repl_([lp],zlp)
                                zlp=zlp+1
                                skip
                             enddo
                          else
                             if lp<zlp
                                zlp=lp+1
                                go rec
                                do while del=[+].and.firma=ident_fir.and.lp#zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                                   repl_([lp],zlp)
                                   zlp=zlp+1
                                   skip
                                enddo
                             else
                                zlp=lp
                                go rec
                                do while .not.bof().and.firma=ident_fir.and.lp#zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                                   repl_([lp],zlp)
                                   zlp=zlp-1
                                   skip -1
                                enddo
                             endif
                          endif
                       endif
                       go rec
                       unlock
                    endif
                 endif
                 set order to 3
                 unlock
                 select suma_mc
                 do BLOKADAR
                 repl_([wyr_tow],wyr_tow-razem_)
                 repl_([wyr_tow],wyr_tow+razem)
                 if ins
                    repl_([pozycje],pozycje+1)
                 endif
                 unlock
                 *==============================================================
              endif
              ***********************
              select faktury
              commit_()
              *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
        end
        @ 22,0
        if &_top_bot
           exit
        else
           do &_proc
        endif
        @ 23,0
        @ 24,0
        *################################ KASOWANIE #################################
   case kl=7.or.kl=46
ColStb()
        center(23,[þ                   þ])
ColSta()
        center(23,[K A S O W A N I E])
ColStd()
        begin sequence
              *-------zamek-------
              if suma_mc->zamek
                 kom(3,[*u],[ Miesi&_a.c jest zamkni&_e.ty ])
                 break
              endif
              *-------------------
              if .not.tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
                 break
              endif
              zident_poz=str(rec_no,8)
              if zRYCZALT<>'T'
                 *========================= Ksiegowanie ========================
                 select oper
                 seek [+]+ident_fir+miesiac+[S-]+strtran(str(faktury->numer,5),[ ],[0])
                 razem_=wyr_tow
                 rodzaj=(wyr_tow#0)
                 set orde to 1
                 do BLOKADAR
                 del()
                 unlock
                 skip
                 *********************** lp
                 if nr_uzytk>=0
                    if param_lp=[T].and.del=[+].and.firma=ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                       do BLOKADA
                       do czekaj
                       rec=recno()
                       do while del=[+].and.firma=ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                          repl_([lp],lp-1)
                          skip
                       enddo
                       go rec
                       unlock
                    endif
                 endif
                 ***********************
                 set orde to 3
                 unlock
                 select suma_mc
                 do BLOKADAR
                 repl_([wyr_tow],wyr_tow-razem_)
                 repl_([pozycje],pozycje-1)
                 unlock
                 *==============================================================
              endif
              if faktury->numer=firma->nr_rach-1
                 select firma
                 do BLOKADAR
                 repl_([nr_rach],nr_rach-1)
                 unlock
              endif
              select pozycje
              seek [+]+zident_poz
              do while del=[+].and.ident=zident_poz
                 do BLOKADAR
                 del()
                 unlock
                 skip
              enddo
              select faktury
              do BLOKADAR
              del()
*              repl_('del','-')
              unlock
              skip
              commit_()
              if &_bot
                 skip -1
              endif
              if .not.&_bot
                 do &_proc
              endif
        end
        @ 23,0
        @ 24,0
        *################################# SZUKANIE #################################
   case kl=-9.or.kl=247
ColStb()
        center(23,[þ                 þ])
ColSta()
        center(23,[S Z U K A N I E])
        f10=[  ]
ColStd()
        @ 0,55 get f10 picture "99"
        read_()
        if .not.empty(f10).and.lastkey()#27
           seek [+]+ident_fir+miesiac+str(val(f10),2)
           if &_bot
              skip -1
           endif
        endif
        do &_proc
        @ 23,0
        *############################### WYDRUK FAKTURY #############################
   case kl=13
        begin sequence
              if numer#firma->nr_rach-1
                 if .not.tnesc([*i],[   Drukujesz wcze&_s.niej wystawion&_a. faktur&_e. - jeste&_s. pewny? (T/N)   ])
                    break
                 endif
              endif
              save screen to scr_
              do fakt3 with zVAT
              select faktury
              restore screen from scr_
        end
        *################################### POMOC ##################################
   case kl=28
        save screen to scr_
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                        '
        p[ 2]='   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
        p[ 3]='   [Home/End]..............pierwsza/ostatnia pozycja    '
        p[ 4]='   [Ins]...................wpisywanie                   '
        p[ 5]='   [M].....................modyfikacja pozycji          '
        p[ 6]='   [Del]...................kasowanie pozycji            '
        p[ 7]='   [F10]...................szukanie                     '
        p[ 8]='   [Enter].................wydruk faktury               '
        p[ 9]='   [Esc]...................wyj&_s.cie                      '
        p[10]='                                                        '
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
        set color to
        pause(0)
        if lastkey()#27.and.lastkey()#28
           keyboard chr(lastkey())
        endif
        restore screen from scr_
        _disp=.f.
        ******************** ENDCASE
   endcase
enddo
close_()
*################################## FUNKCJE #################################
procedure say2603
clear type
select faktury
*@ 1, 6 say repl([.],60)
set color to +w
@ 1,6 say nazwa
@ 2,6 say adres
set color to
*@ 1,47 say repl([.],32)
@ 2,76 say '....'
set color to +w
@ 0,41 say strtran(str(NUMER,5),[ ],[0])
@ 0,55 say DZIEN
@ 22,0 say space(58)
do case
case sposob_p=1
     @ 22,1 say [P&_l.atne przelewem w ci&_a.gu ]+str(termin_z,2)+[ dni]
case sposob_p=2
     if termin_z=0
        @ 22,1 say [Zap&_l.acono got&_o.wk&_a.]
     else
        if kwota=0
           @ 22,1 say [P&_l.atne got&_o.wk&_a. w terminie ]+str(termin_z,2)+[ dni]
        else
           @ 22,1 say [Zap&_l.acono ]+ltrim(kwota(kwota,13,2))+[, reszta p&_l.atna w terminie ]+str(termin_z,2)+[ dni]
        endif
     endif
case sposob_p=3
     @ 22,1 say [Zap&_l.acono czekiem]
endcase
zident_poz=str(rec_no,8)
select pozycje
seek [+]+zident_poz
razem=0
i=0
do while del=[+].and.ident=zident_poz
   i=i+1
   @ 5+i, 1 say left(towar,28)
   if ilosc*1000=0
      @ 5+i,30 say space(13)
      @ 5+i,44 say space(5)
      @ 5+i,50 say space(14)
   else
      zm=kwota(ilosc,13,3)
      if right(zm,1)=[0]
         zm=[ ]+left(zm,12)
         if right(zm,1)=[0]
            zm=[ ]+left(zm,12)
         endif
         if right(zm,1)=[0]
            zm=[  ]+left(zm,11)
         endif
      endif
      @ 5+i,30 say zm
      @ 5+i,44 say JM
      @ 5+i,50 say CENA picture "999 999 999.99"
   endif
   @ 5+i,65 say WARTOSC picture "999 999 999.99"
   razem=razem+wartosc
   skip
enddo
@ 6+i,1 clear to 20,28
@ 6+i,30 clear to 20,42
@ 6+i,44 clear to 20,48
@ 6+i,50 clear to 20,63
@ 6+i,65 clear to 20,78
@ 22,65 say _round(razem,2) picture "999 999 999.99"
select faktury
set color to
@ 22,59 say [Razem ]
***************************************************
function v26_103
if zdzien=[  ]
   zdzien=str(day(date()),2)
   set color to i
   @ 0,55 say zDZIEN
   set color to
endif
return val(zdzien)>=1.and.val(zdzien)<=msc(val(miesiac))
***************************************************
function v26_203
if lastkey()=5
   return .t.
endif
if param_aut=[T]
   save screen to scr2
   select kontr
   seek [+]+ident_fir+substr(znazwa,1,15)
   if del#[+].or.firma#ident_fir
      skip -1
   endif
   if del=[+].and.firma=ident_fir
      Kontr_()
      restore screen from scr2
      if lastkey()=13
         znazwa=kontr->nazwa
         zadres=kontr->adres
         znr_ident=kontr->nr_ident
         set color to i
         @ 1,6 say znazwa
         @ 2,6 say zadres
         set color to
         pause(.5)
         keyboard chr(13)
      endif
   endif
else
   if empty(znazwa)
      save screen to scr2
      select kontr
      seek [+]+ident_fir
      if del=[+].and.firma=ident_fir
         Kontr_()
         restore screen from scr2
         if lastkey()=13
            znazwa=nazwa
            zadres=adres
            znr_ident=nr_ident
            set color to i
            @ 1,6 say znazwa
            @ 2,6 say zadres
            set color to
            keyboard chr(13)
         endif
      endif
   endif
endif
select faktury
return .not.empty(znazwa)
***************************************************
function v26_503
if lastkey()=5
   return .f.
endif
if wiersz=1
   if empty(ztowar[1])
      return .f.
   endif
else
   if empty(ztowar[wiersz])
      set key 23 to
      keyboard chr(23)
      return .t.
   endif
   if zilosc[1]=0
      keyboard chr(13)+chr(13)+chr(13)
      zilosc[wiersz]=0
      zjm[wiersz]=space(5)
      zcena[wiersz]=0
   endif
endif
set confirm off
return .t.
***************************************************
function v26_603
if lastkey()=5
   return .f.
endif
if wiersz=1
   if zilosc[1]=0
      keyboard chr(13)+chr(13)
      zjm[1]=space(5)
      zcena[1]=0
   endif
   return zilosc[1]>=0
else
   return zilosc[wiersz]>0.or.zilosc[1]=0.or.empty(ztowar[wiersz])
endif
***************************************************
function v26_703
if lastkey()=5
   return .f.
endif
return .t.
***************************************************
function v26_803
if lastkey()=5
   return .f.
endif
if zilosc[1]#0
   if zilosc[wiersz]*zcena[wiersz]>999999999
      kom(3,[*u],[ Przekroczony zakres warto&_s.ci ])
      return .f.
   endif
   zwartosc[wiersz]=_round(zilosc[wiersz]*zcena[wiersz],2)
   keyboard chr(13)
endif
return .t.
***************************************************
function v26_903
if lastkey()=5
   return .f.
endif
set confirm on
wiersz=wiersz+1
return .t.
***************************************************
function v26_1003
if ztermin_z<0
   return .f.
endif
if ztermin_z=0
   zkwota=0
   keyboard chr(13)
endif
return .t.
*############################################################################
