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

FUNCTION ZusZua( ubezp )

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
select 3
do while.not.dostep('ETATY')
enddo
do setind with 'ETATY'
seek [+]+ident_fir
select 2
if dostep('PRAC')
   do setind with 'PRAC'
   seek [+]+ident_fir
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
if ubezp=2
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
      nufir2=LO36(nufir)
      NUPLA=recno()
      Nupla1=HI36(nupla)
      nupla2=LO36(nupla)
      PLIK_KDU=substr(param_rok,4,1)+;
               '0'+;
               iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
               iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
               '1'+;
               'W'+;
               iif(nupla1>9,chr(55+nupla1),str(nupla1,1))+;
               iif(nupla2>9,chr(55+nupla2),str(nupla2,1))+'.kdu'
      aaaa=alltrim(paraz_cel)+PLIK_KDU
      set printer to &aaaa
      kedu_pocz()
      dp_pocz('ZUA')
      ?'<ZUSZUA>'
      dozua()
*     dipl rozne dla spolki i osoby fizycznej
     if zSPOLKA='T'
        dipl(F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  '))
     else
        subim=substr(A->NAZ_IMIE,at(' ',A->NAZ_IMIE)+1)
        dipl(A->NIP,substr(F->NR_REGON,3),A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,F->nazwa_skr,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
     endif
      subim=substr(NAZ_IMIE,at(' ',NAZ_IMIE)+1)
*      dipl() with A->NIP,'',A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,A->NAZ_IMIE,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR
      dau(A->PESEL,A->NIP,A->RODZ_DOK,A->DOWOD_OSOB,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
      deoz(substr(subim,at(' ',subim)+1),A->NAZW_RODU,A->OBYWATEL,A->PLEC)
      tyub(A->KOD_TYTU)
      dowp(space(6),'X','X','','X')
      doou()
      dobu()
      dodu()
      iodz()
      dokc()
      azmo(A->KOD_POCZT,A->MIEJSC_ZAM,A->GMINA,A->ULICA,A->NR_DOMU,A->NR_MIESZK,A->TELEFON,'')
      adza()
      adkb()
      opl1()
      ?'</ZUSZUA>'
      dp_kon('ZUA')
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
           nufir2=LO36(nufir)
           NUPLA=recno()
           Nupla1=HI36(nupla)
           nupla2=LO36(nupla)
           PLIK_KDU=substr(param_rok,4,1)+;
                    '0'+;
                    iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
                    iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
                    '1'+;
                    'W'+;
                    iif(nupla1>9,chr(55+nupla1),str(nupla1,1))+;
                    iif(nupla2>9,chr(55+nupla2),str(nupla2,1))+;
                    '.kdu'
           aaaa=alltrim(paraz_cel)+PLIK_KDU
           set printer to &aaaa
           kedu_pocz()
           dp_pocz('ZUA')
           ?'<ZUSZUA>'
           dozua()
*          dipl rozne dla spolki i osoby fizycznej
     if zSPOLKA='T'
        dipl(F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  '))
     else
        subim=substr(A->NAZ_IMIE,at(' ',A->NAZ_IMIE)+1)
        dipl(A->NIP,'',A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,A->NAZ_IMIE,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
     endif
           subim=substr(NAZ_IMIE,at(' ',NAZ_IMIE)+1)
*           dipl() with A->NIP,'',A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,A->NAZ_IMIE,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR
           dau(A->PESEL,A->NIP,A->RODZ_DOK,A->DOWOD_OSOB,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
           deoz(substr(subim,at(' ',subim)+1),A->NAZW_RODU,A->OBYWATEL,A->PLEC)
           tyub(A->KOD_TYTU)
           dowp(space(6),'X','X','','X')
           doou()
           dobu()
           dodu()
           iodz()
           dokc()
           azmo(A->KOD_POCZT,A->MIEJSC_ZAM,A->GMINA,A->ULICA,A->NR_DOMU,A->NR_MIESZK,A->TELEFON,'')
           adza()
           adkb()
           opl1()
           ?'</ZUSZUA>'
           dp_kon('ZUA')
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
else
   *--------------------------------------
   sele prac
   *--------------------------------------
   @ 3,42 clear to 22,79
   *################################# GRAFIKA ##################################
   ColStd()
   @  3,42 say '              Podatnik:              '
   @  4,42 say 'ษอออออออออออออออออออออออออออออออออออป'
   @  5,42 say 'บ                                   บ'
   @  6,42 say 'บ                                   บ'
   @  7,42 say 'บ                                   บ'
   @  8,42 say 'บ                                   บ'
   @  9,42 say 'บ                                   บ'
   @ 10,42 say 'ศอออออออออออออออออออออออออออออออออออผ'
   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g=5
   _col_l=43
   _row_d=9
   _col_p=77
   _invers=[i]
   _curs_l=0
   _curs_p=0
   _esc=[27,28,13]
   _top=[firma#ident_fir]
   _bot=[del#'+'.or.firma#ident_fir]
   _stop=[+]+ident_fir
   _sbot=[+]+ident_fir+[þ]
   _proc=[linia12zp()]
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
      sele prac
      _row=wybor(_row)
      kl=lastkey()
      do case
      *################################## ZESTAW_ #################################
      case kl=13
           zidp=str(rec_no,5)
           sele etaty
           seek [+]+ident_fir+zidp
           sele prac
           save screen to scr2
           nr_rec=recno()
           param_zu()
           jeden=zus_zglo()
           if jeden#1
              close_()
              return
           endif
           NUFIR=val(alltrim(ident_fir))
           Nufir1=HI36(nufir)
           nufir2=LO36(nufir)
           NUPRA=recno()
           Nupra1=HI36(nupra)
           nupra2=LO36(nupra)
           set console off
           set device to print
           set print on
           PLIK_KDU=substr(param_rok,4,1)+;
                    '0'+;
                    iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
                    iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
                    '1'+;
                    'P'+;
                    iif(nupra1>9,chr(55+nupra1),str(nupra1,1))+;
                    iif(nupra2>9,chr(55+nupra2),str(nupra2,1))+'.kdu'
           aaaa=alltrim(paraz_cel)+PLIK_KDU
           set printer to &aaaa
           kedu_pocz()
           dp_pocz('ZUA')
           ?'<ZUSZUA>'
           dozua()
*          dipl rozne dla spolki i osoby fizycznej
     if zSPOLKA='T'
        dipl(F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  '))
     else
        subim=substr(A->NAZ_IMIE,at(' ',A->NAZ_IMIE)+1)
        dipl(A->NIP,substr(F->NR_REGON,3),A->PESEL,A->RODZ_DOK,A->DOWOD_OSOB,F->nazwa_skr,substr(A->NAZ_IMIE,1,at(' ',A->NAZ_IMIE)),substr(subim,1,at(' ',subim)),A->DATA_UR)
     endif
*           dipl() with F->NIP,substr(F->NR_REGON,3),'','','',F->nazwa_skr,'','',ctod('    /  /  ')
           dau(B->PESEL,B->NIP,B->RODZ_DOK,B->DOWOD_OSOB,B->NAZWISKO,B->IMIE1,B->DATA_UR)
           deoz(B->IMIE2,B->NAZW_RODU,B->OBYWATEL,B->PLEC)
           tyub(C->KOD_TYTU)
           dowp(ZUSWYMIAR(C->WYMIARL,C->WYMIARM),'X','X','X','X')
           doou()
           dobu()
           dodu()
           iodz()
           dokc(C->KOD_KASY)
           azmo(B->KOD_POCZT,B->MIEJSC_ZAM,B->GMINA,B->ULICA,B->NR_DOMU,B->NR_MIESZK,B->TELEFON,'')
           adza()
           adkb()
           opl1()
           ?'</ZUSZUA>'
           dp_kon('ZUA')
           kedu_kon()
           set printer to
           set console on
           set print off
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
endif
*################################## FUNKCJE #################################
function linia12z
return ' '+dos_c(naz_imie)+' '
*################################## FUNKCJE #################################
function linia12zp
return ' '+padc(alltrim(nazwisko)+' '+alltrim(imie1)+' '+alltrim(imie2),33)+' '
*############################################################################
