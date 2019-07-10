/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Micha Gawrycki (gmsystems.pl)

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

param ubezp
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
*############################### OTWARCIE BAZ ###############################
select 6
if dostep('FIRMA')
   go val(ident_fir)
else
   return
endif
zspolka=iif(spolka,'T','N')
select 4
if dostep('DANE_MC')
   set inde to DANE_MC
else
   close_()
   return
endif
select 3
do while.not.dostep('ETATY')
enddo
do setind with 'ETATY'
set orde to 2
select 2
if dostep('PRAC')
   do setind with 'PRAC'
   set orde to 2
else
   close_()
   return
endif
select 1
if dostep('SPOLKA')
   do setind with 'SPOLKA'
   seek [+]+ident_fir
else
   close_()
   return
endif
if del#[+].or.firma#ident_fir
   kom(5,[*u],[ Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ])
   close_()
   return
endif
do case
case ubezp=1
     @ 3,42 clear to 22,79
     save screen to scr2
     *--------------------------------------
     param_zu()
     jeden=zus_zglo()
     if jeden#1
        close_()
        return
     endif
     set console off
     set device to print
     set print on
     NUFIR=val(alltrim(ident_fir))
     Nufir1=HI36(nufir)
     Nufir2=LO36(nufir)
     PLIK_KDU=substr(param_rok,4,1)+;
              iif(val(miesiac)>9,chr(55+val(miesiac)),alltrim(miesiac))+;
              iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
              iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
              '9'+;
              'P'+;
              '0'+;
              '0.kdu'
     aaaa=alltrim(paraz_cel)+PLIK_KDU
     set printer to &aaaa

     do case
     case miesiac=' 1'.or.miesiac=' 3'.or.miesiac=' 5'.or.miesiac=' 7'.or.miesiac=' 8'.or.miesiac='10'.or.miesiac='12'
          DAYM='31'
     case miesiac=' 4'.or.miesiac=' 6'.or.miesiac=' 9'.or.miesiac='11'
          DAYM='30'
     case miesiac=' 2'
          DAYM='29'
          if day(ctod(param_rok+'.'+miesiac+'.'+DAYM))=0
             DAYM='28'
          endif
     endcase
     DDAY=ctod(param_rok+'.'+miesiac+'.'+DAYM)
     ilub=0
     ilet=0
     sum_eme=0
     sum_ren=0
     zwar_pue=0
     zwar_pur=0
     zwar_fue=0
     zwar_fur=0
     sum_cho=0
     sum_wyp=0
     zwar_puc=0
     zwar_puw=0
     zwar_fuw=0
     zwar_puz=0
     zwar_ffp=0
     zwar_ffg=0
     sele prac
     go top
     seek '+'+ident_fir+'+'
     do while .not.eof().and.del='+'.and.firma=ident_fir.and.status<='U'
        if .not.empty(DATA_PRZY)
           DOD=substr(dtos(DATA_PRZY),1,6)<=param_rok+strtran(miesiac,' ','0')
        else
           DOD=.f.
        endif
        if .not.empty(DATA_ZWOL)
           DDO=substr(dtos(DATA_ZWOL),1,6)>=param_rok+strtran(miesiac,' ','0')
           if substr(dtos(DATA_ZWOL),1,6)==param_rok+strtran(miesiac,' ','0')
              PROZWOL=dtoc(DATA_ZWOL)
           endif
        else
           PROZWOL=''
           DDO=.t.
        endif
        if DOD.and.DDO=.t.
           sele etaty
           seek '+'+ident_fir+miesiac+str(prac->rec_no,5)
           if found()
              ilub=ilub+1
              ilet=ilet+(wymiarl/wymiarm)
              sum_eme=sum_eme+war_pue+war_fue
              sum_ren=sum_ren+war_pur+war_fur
              zwar_pue=zwar_pue+war_pue
              zwar_pur=zwar_pur+war_pur
              zwar_fue=zwar_fue+war_fue
              zwar_fur=zwar_fur+war_fur
              sum_cho=sum_cho+war_puc+war_fuc
              sum_wyp=sum_wyp+war_puw+war_fuw
              zwar_puc=zwar_puc+war_puc
              zwar_puw=zwar_puw+war_puw
              zwar_fuw=zwar_fuw+war_fuw
              zwar_puz=zwar_puz+war_puz
              zwar_ffp=zwar_ffp+war_ffp
              zwar_ffg=zwar_ffg+war_ffg
           endif
        endif
        sele prac
        skip
     enddo

     kedu_pocz()
     dp_pocz('DRA')
     ?'<ZUSDRA>'
     dadra('3',miesiac,param_rok)
     if zSPOLKA='T'
        dipl(F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  '))
     else
        subim=substr(A->NAZ_IMIE,at(' ',A->NAZ_IMIE)+1)
        dipl(A->NIP,substr(F->NR_REGON,3),A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,F->nazwa_skr,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
     endif
     inn7(ilub,ilet,parap_fuw)
     zsdrai(sum_eme,sum_ren,sum_eme+sum_ren,zwar_pue,zwar_pur,zwar_pue+zwar_pur,;
                    zwar_fue,zwar_fur,zwar_fue+zwar_fur,sum_cho,sum_wyp,sum_cho+sum_wyp,;
                    zwar_puc,zwar_puw,zwar_puc+zwar_puw,;
                    zwar_fuw,zwar_fuw,sum_eme+sum_ren+sum_cho+sum_wyp)
     zwdra()
     rivdra()
     zsdra(zwar_puz)
     zdrav(zwar_ffp,zwar_ffg,zwar_ffp+zwar_ffg)
     lskd()
     kndk()
     dddu('',0)
     opls()
     ?'</ZUSDRA>'
     dp_kon('DRA')
     kedu_kon()
     set printer to
     set console on
     set print off
     set devi to screen
     kedu_rapo(plik_kdu)
     restore screen from scr2
     _disp=.f.
     close_()
case ubezp=2
     *--------------------------------------
     sele firma
     *--------------------------------------
     @ 3,42 clear to 22,79
     if .not.f->spolka
        sele spolka
        param_zu()
        jeden=zus_zglo()
        if jeden#1
           close_()
           return
        endif
        set device to print
        set console off
        set print on
        NUFIR=val(alltrim(ident_fir))
        Nufir1=HI36(nufir)
        Nufir2=LO36(nufir)
        NUPLA=recno()
        Nupla1=HI36(nupla)
        Nupla2=LO36(nupla)
        PLIK_KDU=substr(param_rok,4,1)+;
                 iif(val(miesiac)>9,chr(55+val(miesiac)),alltrim(miesiac))+;
                 iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
                 iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
                 '9'+;
                 'W'+;
                 iif(nupla1>9,chr(55+nupla1),str(nupla1,1))+;
                 iif(nupla2>9,chr(55+nupla2),str(nupla2,1))+'.kdu'
        aaaa=alltrim(paraz_cel)+PLIK_KDU
        zident=str(recno(),5)
        select dane_mc
        seek [+]+zident+miesiac
        sele spolka
        set printer to &aaaa
        kedu_pocz()
        dp_pocz('DRA')
        ?'<ZUSDRA>'
        dadra('2',miesiac,param_rok)
*       dipl rozne dla spolki i osoby fizycznej
        subim=substr(NAZ_IMIE,at(' ',NAZ_IMIE)+1)
        dipl(A->NIP,'',A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,A->NAZ_IMIE,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
        inn7(1,0,d->staw_wuw)
        zsdrai(d->war_wue,d->war_wur,d->war_wue+d->war_wur,d->war_wue,d->war_wur,d->war_wue+d->war_wur,;
                       0,0,0,d->war_wuc,d->war_wuw,d->war_wuc+d->war_wuw,d->war_wuc,d->war_wuw,d->war_wuc+d->war_wuw,;
                       0,0,d->war_wue+d->war_wur+d->war_wuc+d->war_wuw)
        zwdra()
        rivdra()
        zsdra(d->war_wuz)
        zdrav(d->war_wfp,d->war_wfg,d->war_wfp+d->war_wfg)
        lskd()
        kndk()
        dddu(A->KOD_TYTU,d->podstawa,d->podstzdr)
        opls()
        ?'</ZUSDRA>'
        dp_kon('DRA')
        kedu_kon()
        set printer to
        set console on
        set print off
        set devi to screen
        kedu_rapo(plik_kdu)
        close_()
        return
     endif
     *################################# GRAFIKA ##################################
     ColStd()
     @  3,44 say '            Podatnik:             '
     @  4,44 say 'ษออออออออออออออออออออออออออออออออป'
     @  5,44 say 'บ                                บ'
     @  6,44 say 'บ                                บ'
     @  7,44 say 'บ                                บ'
     @  8,44 say 'บ                                บ'
     @  9,44 say 'บ                                บ'
     @ 10,44 say 'ศออออออออออออออออออออออออออออออออผ'
     *################################# OPERACJE #################################
     *----- parametry ------
     _row_g=5
     _col_l=45
     _row_d=9
     _col_p=76
     _invers=[i]
     _curs_l=0
     _curs_p=0
     _esc=[27,28,13]
     _top=[firma#ident_fir]
     _bot=[del#'+'.or.firma#ident_fir]
     _stop=[+]+ident_fir
     _sbot=[+]+ident_fir+[þ]
     _proc=[linia12z()]
     _row=int((_row_g+_row_d)/2)
     _proc_spe=[]
     _disp=.t.
     _cls=''
     *----------------------
     kl=0
     do while kl#27
        ColSta()
        @ 1,47 say '[F1]-pomoc'
        set colo to
        sele spolka
        _row=wybor(_row)
        kl=lastkey()
        do case
        *################################## ZESTAW_ #################################
        case kl=13
             save screen to scr2
             nr_rec=recno()
             param_zu()
             jeden=zus_zglo()
             if jeden#1
                close_()
                return
             endif
             set device to print
             set console off
             set print on
             NUFIR=val(alltrim(ident_fir))
             Nufir1=HI36(nufir)
             Nufir2=LO36(nufir)
             NUPLA=recno()
             Nupla1=HI36(nupla)
             Nupla2=LO36(nupla)
             PLIK_KDU=substr(param_rok,4,1)+;
                      iif(val(miesiac)>9,chr(55+val(miesiac)),alltrim(miesiac))+;
                      iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
                      iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
                      '9'+;
                      'W'+;
                      iif(nupla1>9,chr(55+nupla1),str(nupla1,1))+;
                      iif(nupla2>9,chr(55+nupla2),str(nupla2,1))+;
                      '.kdu'
             aaaa=alltrim(paraz_cel)+PLIK_KDU
             zident=str(recno(),5)
             select dane_mc
             seek [+]+zident+miesiac
             sele spolka
             set printer to &aaaa
             kedu_pocz()
             dp_pocz('DRA')
             ?'<ZUSDRA>'
             dadra('2',miesiac,param_rok)
*            dipl rozne dla spolki i osoby fizycznej
             subim=substr(NAZ_IMIE,at(' ',NAZ_IMIE)+1)
             dipl(A->NIP,'',A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,A->NAZ_IMIE,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
             inn7(1,0,d->staw_wuw)
             zsdrai(d->war_wue,d->war_wur,d->war_wue+d->war_wur,d->war_wue,d->war_wur,d->war_wue+d->war_wur,;
                            0,0,0,d->war_wuc,d->war_wuw,d->war_wuc+d->war_wuw,d->war_wuc,d->war_wuw,d->war_wuc+d->war_wuw,;
                            0,0,d->war_wue+d->war_wur+d->war_wuc+d->war_wuw)
             zwdra()
             rivdra()
             zsdra(d->war_wuz)
             zdrav(d->war_wfp,d->war_wfg,d->war_wfp+d->war_wfg)
             lskd()
             kndk()
             dddu(A->KOD_TYTU,d->podstawa,d->podstzdr)
             opls()
             ?'</ZUSDRA>'
             dp_kon('DRA')
             kedu_kon()
             set printer to
             set print off
             set console on
             set devi to screen
             kedu_rapo(plik_kdu)
             go nr_rec
             restore screen from scr2
             _disp=.f.
        *################################### POMOC ##################################
        case kl=28
             save screen to scr_
             @ 1,47 say [          ]
             declare p[20]
             *---------------------------------------
             p[ 1]='                                                        '
             p[ 2]='   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
             p[ 3]='   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
             p[ 4]='   [Home/End]..............pierwsza/ostatnia pozycja    '
             p[ 5]='   [Enter].................akceptacja                   '
             p[ 6]='   [Esc]...................wyj&_s.cie                      '
             p[ 7]='                                                        '
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
case ubezp=3
     @ 3,42 clear to 22,79
     save screen to scr2
     *--------------------------------------
     param_zu()
     jeden=zus_zglo()
     if jeden#1
        close_()
        return
     endif
     set console off
     set device to print
     set print on
     NUFIR=val(alltrim(ident_fir))
     Nufir1=HI36(nufir)
     Nufir2=LO36(nufir)
     PLIK_KDU=substr(param_rok,4,1)+;
              iif(val(miesiac)>9,chr(55+val(miesiac)),alltrim(miesiac))+;
              iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
              iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
              '9'+;
              'F'+;
              '0'+;
              '0.kdu'
     aaaa=alltrim(paraz_cel)+PLIK_KDU
     set printer to &aaaa

     do case
     case miesiac=' 1'.or.miesiac=' 3'.or.miesiac=' 5'.or.miesiac=' 7'.or.miesiac=' 8'.or.miesiac='10'.or.miesiac='12'
          DAYM='31'
     case miesiac=' 4'.or.miesiac=' 6'.or.miesiac=' 9'.or.miesiac='11'
          DAYM='30'
     case miesiac=' 2'
          DAYM='29'
          if day(ctod(param_rok+'.'+miesiac+'.'+DAYM))=0
             DAYM='28'
          endif
     endcase
     DDAY=ctod(param_rok+'.'+miesiac+'.'+DAYM)
     ilub=0
     ilet=0
     sum_eme=0
     sum_ren=0
     zwar_pue=0
     zwar_pur=0
     zwar_fue=0
     zwar_fur=0
     sum_cho=0
     sum_wyp=0
     zwar_puc=0
     zwar_puw=0
     zwar_fuw=0
     zwar_puz=0
     zwar_ffp=0
     zwar_ffg=0
     sele prac
     go top
     seek '+'+ident_fir+'+'
     do while .not.eof().and.del='+'.and.firma=ident_fir.and.status<='U'
        if .not.empty(DATA_PRZY)
           DOD=substr(dtos(DATA_PRZY),1,6)<=param_rok+strtran(miesiac,' ','0')
        else
           DOD=.f.
        endif
        if .not.empty(DATA_ZWOL)
           DDO=substr(dtos(DATA_ZWOL),1,6)>=param_rok+strtran(miesiac,' ','0')
           if substr(dtos(DATA_ZWOL),1,6)==param_rok+strtran(miesiac,' ','0')
              PROZWOL=dtoc(DATA_ZWOL)
           endif
        else
           PROZWOL=''
           DDO=.t.
        endif
        if DOD.and.DDO=.t.
           sele etaty
           seek '+'+ident_fir+miesiac+str(prac->rec_no,5)
           if found()
              ilub=ilub+1
              ilet=ilet+(wymiarl/wymiarm)
              sum_eme=sum_eme+war_pue+war_fue
              sum_ren=sum_ren+war_pur+war_fur
              zwar_pue=zwar_pue+war_pue
              zwar_pur=zwar_pur+war_pur
              zwar_fue=zwar_fue+war_fue
              zwar_fur=zwar_fur+war_fur
              sum_cho=sum_cho+war_puc+war_fuc
              sum_wyp=sum_wyp+war_puw+war_fuw
              zwar_puc=zwar_puc+war_puc
              zwar_puw=zwar_puw+war_puw
              zwar_fuw=zwar_fuw+war_fuw
              zwar_puz=zwar_puz+war_puz
              zwar_ffp=zwar_ffp+war_ffp
              zwar_ffg=zwar_ffg+war_ffg
           endif
        endif
        sele prac
        skip
     enddo

     sele spolka
     go top
     seek '+'+ident_fir
     do while .not.eof().and.del='+'.and.firma=ident_fir
        zident=str(recno(),5)
        sele dane_mc
        seek '+'+zident+miesiac
        if found()
           ilub=ilub+1
*           ilet=ilet+1
           sum_eme=sum_eme+war_wue
           sum_ren=sum_ren+war_wur
           zwar_pue=zwar_pue+war_wue
           zwar_pur=zwar_pur+war_wur
           sum_cho=sum_cho+war_wuc
           sum_wyp=sum_wyp+war_wuw
           zwar_puc=zwar_puc+war_wuc
           zwar_puw=zwar_puw+war_wuw
           zwar_puz=zwar_puz+war_wuz
           zwar_ffp=zwar_ffp+war_wfp
           zwar_ffg=zwar_ffg+war_wfg
        endif
        sele spolka
        skip
     enddo
     seek '+'+ident_fir

     sele prac

     kedu_pocz()
     dp_pocz('DRA')
     ?'<ZUSDRA>'
     dadra('3',miesiac,param_rok)
     if zSPOLKA='T'
        dipl(F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  '))
     else
        subim=substr(A->NAZ_IMIE,at(' ',A->NAZ_IMIE)+1)
        dipl(A->NIP,substr(F->NR_REGON,3),A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,F->nazwa_skr,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
     endif
*     dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')
     inn7(ilub,ilet,parap_fuw)
     zsdrai(sum_eme,sum_ren,sum_eme+sum_ren,zwar_pue,zwar_pur,zwar_pue+zwar_pur,;
                    zwar_fue,zwar_fur,zwar_fue+zwar_fur,sum_cho,sum_wyp,sum_cho+sum_wyp,;
                    zwar_puc,zwar_puw,zwar_puc+zwar_puw,;
                    zwar_fuw,zwar_fuw,sum_eme+sum_ren+sum_cho+sum_wyp)
     zwdra()
     rivdra()
     zsdra(zwar_puz)
     zdrav(zwar_ffp,zwar_ffg,zwar_ffp+zwar_ffg)
     lskd()
     kndk()
     dddu('',0)
     opls()
     ?'</ZUSDRA>'
     dp_kon('DRA')
     kedu_kon()
     set printer to
     set console on
     set print off
     set devi to screen
     kedu_rapo(plik_kdu)
     restore screen from scr2
     _disp=.f.
     close_()
endcase
