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

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
private zNAZWISKO, zIMIE1, zIMIE2, zDO_WYPLATY, zPRZEL_NAKO, zADRES, zPOCZTA, zBANK, zNRKONTA, numprac
private druk,linia, suma, tytul, data, nrkontaba

@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '                LISTA PRZELEW&__O.W WYP&__L.AT NA KONTA PRACOWNIK&__O.W                    '
ColInf()
@  4, 0 say padc('[L]-drukowanie przelew&_o.w   [Z]-drukowanie zbior&_o.wki   [F3]-zmiana sortu',80)
ColStd()
@  5, 0 say 'ÚÄÄÄÄÄÄÄÄÄNazwisko i imionaÄÄÄÄÄÄÄÄÂÄÄÄÄNumer kontaÄÄÄÄÄÄÄÄÄÄÂÄwyp&_l.ataÂÄprzelew¿'
for x=6 to 20
    @  x, 0 say '³                                  ³                         ³        ³        ³'
next
@ 21, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÙ'
@ 22, 0 say ' Bank pracownika:                                                               '
**************************************************************************
//tworzenie bazy roboczej
dbcreate("ROBPRZEL",{;
                     {"DEL","C", 1, 0},;
                     {"NAZWISKO", "C", 30, 0},;
                     {"IMIE1",    "C", 15, 0},;
                     {"IMIE2",    "C", 15, 0},;
                     {"ADRES",    "C", 32, 0},;
                     {"POCZTA",   "C", 27, 0},;
                     {"BANK",     "C", 30, 0},;
                     {"NRKONTA",  "C", 35, 0},;
                     {"DO_WYPLATY","N", 8, 2},;
                     {"PRZEL_NAKO","N", 8, 2}})

select 4
do while .not. dostep('FIRMA')
enddo
go val(ident_fir)

select 3
do while.not.dostep('ETATY')
enddo
do setind with 'ETATY'
set orde to 2
seek [+]+ident_fir

select 2
do while.not.dostep('PRAC')
enddo
do setind with 'PRAC'
set orde to 4
seek [+]+ident_fir

select 1
do while .not. dostep('ROBPRZEL')
enddo
index on del+nazwisko+imie1+imie2 to robprzel
index on del+substr(nrkonta,4,8)+nazwisko+imie1+imie2 to robprze2
set inde to robprzel,robprze2

// wczytanie danych o firmie

select 4
zNAZWA = NAZWA
zADRESFIR = ULICA+' '+alltrim(NR_DOMU)
if alltrim(NR_MIESZK) <> ''
   zADRESFIR += '\'+alltrim(NR_MIESZK)
endif
zPOCZTAFIR = KOD_P+' '+POCZTA
zBANKFIR = BANK
zNRKONTAFIR = NR_KONTA

select 3
//wczytanie informacji o przelwach do bazy tymczasowej
seek [+]+ident_fir+miesiac
if .not. found()
   kom(3,[*u],[ Brak danych ])
   close_()
   return
else
   do while !eof()
// dodajemy rekordy do bazy tymczsowej
      if DEL='+'.and.firma==ident_fir.and.mc==miesiac.and.przel_nako>0
         numprac=IDENT
         zDO_WYPLATY=DO_WYPLATY
         zPRZEL_NAKO=PRZEL_NAKO
         select 2
         //seek val(numprac)
         seek ident_fir + numprac
         zNAZWISKO=Nazwisko
         zIMIE1 =IMIE1
         zIMIE2 =IMIE2
         zADRES = alltrim(ULICA)+' '+alltrim(NR_DOMU)
         if alltrim(NR_MIESZK) <> ''
            zADRES += '\'+alltrim(NR_MIESZK)
         endif
         zPOCZTA = KOD_POCZT+' '+POCZTA
         zBANK = BANK
         zNRKONTA = KONTO
         select 1
         app()
         repl_([NAZWISKO], zNAZWISKO)
         repl_([IMIE1], zIMIE1)
         repl_([IMIE2], zIMIE2)
         repl_([ADRES], zADRES)
         repl_([POCZTA], zPOCZTA)
         repl_([BANK], zBANK)
         repl_([NRKONTA], zNRKONTA)
         repl_([DO_WYPLATY], zDO_WYPLATY)
         repl_([PRZEL_NAKO], zPRZEL_NAKO)
         select 3
      endif
      skip
   enddo
endif
select 1
go top
if reccount()<1
   kom(3,[*w],[b r a k   d a n y c h])
   close_()
   erase robprzel.*
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=6
_col_l=1
_row_d=20
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,13,122,90,108,76,-2,28]

_top=[bof()]
_bot=[eof()]
_stop=[+]
_sbot=[+]+[ş]
_proc=[piszprac()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[piszbank]
_disp=.t.
_cls=''
*----------------------
kl=0
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set color to
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
   do case
   *######################### DRUKOWANIE TABELI #################################
   case kl=13
        save screen to scrtp_
        curre=recno()
        go top
        do przellis with 'L'
        go curre
        restore screen from scrtp_
   *######################### ZMIANA SORTU #################################
   case kl=-2
        if indexord()=1
           set orde to 2
        else
           set orde to 1
        endif
   *############################### ZBIOROWKA  #################################
   case kl=122.or.kl=90
        save screen to scrzb_
        curre=recno()
        ColStd()
        nrkontaba=substr(NRKONTA,4,8)
        set filt to substr(NRKONTA,4,8)==nrkontaba
        go top
        do przellis with 'Z'
        set filt to
        go curre
        restore screen from scrzb_
   *################################ PRZELEWY ##################################
   case kl=108.or.kl=76
        save screen to scr_
        curre=recno()
        ColInf()
        @ 24,0 say padc('Wybierz przelewy: P-wybrany prac., W-wszyscy prac., B-zbior.do wybranego banku',80)
        ColStd()
        klw=0
        klw=inkey(0)
        do while klw#27
           @ 24, 0 say space(80)
           begin sequence
                 tytul='Wyp&_l.ata pensji'
                 tytul=tytul+space(35-len(tytul))
                 data_przel=ctod('    .  .  ')
                 @ 24,0 say 'Tytu&_l. przelewu:' get tytul pict '!'+repl('X',34)
                 @ 24,55 say 'Data przelewu:' get data_przel pict '@D'
                 read
                 IF LASTKEY()=27
                    klw=27
                    break
                 ENDIF
                 if tnesc([],'Jeste&_s. pewny ze chcesz drukowa&_c. (brak podgl&_a.du) (Tak/Nie) ?')=.f.
                    klw=27
                    break
                 endif
                 @ 24, 0 say space(80)
                 do case
                 case klw=80.or.klw=112
                      zNAZWISKO=alltrim(NAZWISKO)+' '+alltrim(IMIE1)+' '+alltrim(IMIE2)
                      zADRES=ADRES
                      zPOCZTA=POCZTA
                      zBANK=BANK
                      zNRKONTA=NRKONTA
                      zPRZEL_NAKO=PRZEL_NAKO

                      save screen to scr_
                      zNAZWA_WIE =zNAZWISKO
                      zNAZWA_PLA =zNAZWA
                      zULICA_WIE =zADRES
                      zULICA_PLA =zADRESFIR
                      zMIEJSC_WIE=zPOCZTA
                      zMIEJSC_PLA=zPOCZTAFIR
                      zBANK_WIE  =zBANK
                      zBANK_PLA  =zBANKFIR
                      zKONTO_WIE =zNRKONTA
                      zKONTO_PLA =zNRKONTAFIR
                      zKWOTA     =zPRZEL_NAKO
                      zTRESC     =tytul
                      zDATA      =DATA_PRZEL
                      afill(nazform,'')
                      afill(strform,0)
                      nazform[1]='PRZELN'
                      strform[1]=1
                      form(nazform,strform,1)
                      restore screen from scr_
                      sele 1

                      klw=27

                 case klw=66.or.klw=98
                      nrkontaba=substr(NRKONTA,4,8)
                      set filt to substr(NRKONTA,4,8)==nrkontaba
                      go top
                      zNAZWISKO='Wynagrodzenia wg za&_l.&_a.czonej listy zbiorczej'
                      zADRES=''
                      zPOCZTA=''
                      zBANK=BANK
                      zNRKONTA='   '+NRKONTABA
                      zPRZEL_NAKO=0
                      do while .not.eof()
                         zPRZEL_NAKO=zPRZEL_NAKO+PRZEL_NAKO
                         skip
                      enddo

                      save screen to scr_
                      zNAZWA_WIE =zNAZWISKO
                      zNAZWA_PLA =zNAZWA
                      zULICA_WIE =zADRES
                      zULICA_PLA =zADRESFIR
                      zMIEJSC_WIE=zPOCZTA
                      zMIEJSC_PLA=zPOCZTAFIR
                      zBANK_WIE  =zBANK
                      zBANK_PLA  =zBANKFIR
                      zKONTO_WIE =zNRKONTA
                      zKONTO_PLA =zNRKONTAFIR
                      zKWOTA     =zPRZEL_NAKO
                      zTRESC     =tytul
                      zDATA      =DATA_PRZEL
                      afill(nazform,'')
                      afill(strform,0)
                      nazform[1]='PRZELN'
                      strform[1]=1
                      form(nazform,strform,1)
                      restore screen from scr_
                      sele 1

                      set filt to
                      klw=27
                 case klw=87.or.klw=119
                      go top
                      do while .not.eof()
                         zNAZWISKO=alltrim(NAZWISKO)+' '+alltrim(IMIE1)+' '+alltrim(IMIE2)
                         zADRES=ADRES
                         zPOCZTA=POCZTA
                         zBANK=BANK
                         zNRKONTA=NRKONTA
                         zPRZEL_NAKO=PRZEL_NAKO
                         if tnesc([],'Drukowa&_c. '+alltrim(substr(zNAZWISKO,1,40))+' (brak podgl&_a.du) (Tak/Nie) ?')=.t.

                            save screen to scr_
                            zNAZWA_WIE =zNAZWISKO
                            zNAZWA_PLA =zNAZWA
                            zULICA_WIE =zADRES
                            zULICA_PLA =zADRESFIR
                            zMIEJSC_WIE=zPOCZTA
                            zMIEJSC_PLA=zPOCZTAFIR
                            zBANK_WIE  =zBANK
                            zBANK_PLA  =zBANKFIR
                            zKONTO_WIE =zNRKONTA
                            zKONTO_PLA =zNRKONTAFIR
                            zKWOTA     =zPRZEL_NAKO
                            zTRESC     =tytul
                            zDATA      =DATA_PRZEL
                            afill(nazform,'')
                            afill(strform,0)
                            nazform[1]='PRZELN'
                            strform[1]=1
                            form(nazform,strform,1)
                            restore screen from scr_
                            sele 1

                         endif
                         skip
                      enddo
                      klw=27 //<--= konieczne do wyjscia z petli
                 endcase
                 inkey()
           end
        enddo
        go curre
        restore screen from scr_
   *################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                           '
        p[ 2]='   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja     '
        p[ 3]='   [PgUp/PgDn].............poprzednia/nast&_e.pna strona      '
        p[ 4]='   [Home/End]..............pierwsza/ostatnia pozycja       '
        p[ 5]='   [L].....................drukowanie przelew&_o.w            '
        p[ 6]='   [Z].....................drukowanie zbior&_o.wki            '
        p[ 7]='   [Enter].................drukowanie tabeli               '
        p[ 8]='   [Esc]...................wyj&_s.cie                         '
        p[ 9]='                                                           '
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
        inkey()
        _disp=.f.
        @ 23,0
   endcase
enddo
erase robprzel.*
close_()
*################################## FUNKCJE #################################
function piszprac
S=''
S=padr(alltrim(NAZWISKO)+' '+alltrim(IMIE1)+' '+alltrim(IMIE2),34)+'³'
S=S+padr((NRKONTA),25)+[³]+str(DO_WYPLATY)+[³]+str(PRZEL_NAKO)
return S
******************************************************
procedure piszbank
set color to w+
*@ 22, 0 say ' Bank pracownika:'
@ 22,17 say BANK
set color to w
return
