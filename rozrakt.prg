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
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
*@  3, 0 say padc('EWIDENCJA  INNYCH  UM&__O.W  i  INNYCH  &__X.R&__O.DE&__L.  PRZYCHOD&__O.W',80)
@  3, 0 say 'INS/DEL-dod/kas.zapl.   F/DEL-dod/kas.fakt.   W-mod.wyroznik    A-aktual.statusu'
@  4, 0 say 'R-rozl/L-nierozl/1-razem     N-szukaj/M-szukaj nastepny     Z-zak/S-sprz/2-razem'
*  Z-pokaz zapl/nie'
@  5, 0 say 'ÚִִִִִִNIPֲִִִִִWyroznik dokum.ֲTerm.zapl.ֲData wyst.ֲִִSprzedanoֲִִִZakupionoִ¿'
@  6, 0 say '³              ³               ³          ³          ³            ³            ³'
@  7, 0 say '³              ³               ³          ³          ³            ³            ³'
@  8, 0 say '³              ³               ³          ³          ³            ³            ³'
@  9, 0 say '³              ³               ³          ³          ³            ³            ³'
@ 10, 0 say '³              ³               ³          ³          ³            ³            ³'
@ 11, 0 say '³              ³               ³          ³          ³            ³            ³'
@ 12, 0 say '³              ³               ³          ³          ³            ³            ³'
@ 13, 0 say '³              ³               ³          ³          ³            ³            ³'
@ 14, 0 say '³              ³               ³          ³          ³            ³            ³'
@ 15, 0 say 'ֱֱֱֱֱֳִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ´'
@ 16, 0 say '³ Kontrahent:                                                                  ³'
@ 17, 0 say '³ Info......:                                                                  ³'
@ 18, 0 say '³ Wyroznik..:                  Rodzaj wpisu....:                               ³'
@ 19, 0 say '³ Faktura...:                  Numer dokumentu.:             Dni plat:         ³'
@ 20, 0 say '³ Suma wplat:                  Data ksiegowania:             Zrodlo..:Faktury  ³'
@ 21, 0 say '³ Saldo.....:                  Data wyst.dokum.:             Status  :Zaplacone³'
@ 22, 0 say 'ְִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִÙ'
*############################### OTWARCIE BAZ ###############################
select 2
do while.not.dostep('KONTR')
enddo
do setind with 'KONTR'
set orde to 2
seek [+]+ident_fir
select 1
do while.not.dostep('ROZR')
enddo
do setind with 'ROZR'
seek ident_fir
if eof().or.firma#ident_fir
   kom(3,[*u],[ Brak dokumentow rozrachunkowych dla tej firmy ])
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=6
_col_l=1
_row_d=14
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,22,48,70,102,7,46,87,119,28,110,78,65,97,82,114,76,108,49,90,122,83,115,50,77,109]
*_esc=[27,-9,13,247,22,48,77,109,7,46,28,82,114,85,117,87,119]
_top=[firma#ident_fir]
_bot=[firma#ident_fir]
_stop=ident_fir
_sbot=ident_fir+[‏]
_proc=[say41ro()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[say41sro]
_disp=.t.
_cls=''
DOROZL=0
FILTRO1="1=1"
FILTRO2="1=1"
TEXTRO1='Rozliczone i nierozliczone'
TEXTRO2='Zakupy i sprzedaz'
zSZUKNIP=space(13)
zSZUKNAZ=space(70)
zSZUKFAK=space(10)
zSZUKOPT='Z'
zSZUKOPT2='O'

*----------------------
kl=0
do while kl#27
ColSta()
@ 1,47 say '[F1]-pomoc'
set colo to
_row=wybor(_row)
ColStd()
kl=lastkey()
do case
*########################### INSERT DOWODU WPLATY #############################
case kl=22.or.kl=48
     if RODZDOK=='ZZ'.or.RODZDOK='ZS'
        do komun with 'Nacisnij INSERT na pozycji z faktura do ktorej naniesc zaplate,nie na zaplacie'
     else
        @ 1,47 say [          ]
        ColStb()
        center(23,[‏                     ‏])
        ColSta()
        center(23,[W P I S Y W A N I E])
        ColStd()

        begin sequence
*ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
        zSZUKNIP=NIP
        zWYR=WYR
        zDATAKS=date()
        zNRDOK= Pad( 'WBnr', 100 )
        zRODZDOK=iif(RODZDOK='FS','ZS','ZZ')
        zKWOTA=abs(DOROZL)
        zUWAGI=space(60)

*ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
        save screen to SCRINSZAPL
        @  7,19 clear to 13,59
        @  7,19 to 13,59 double
        @  8,20 say padc('WPROWADZANIE ZAPLATY',38)
        @  9,21 say 'Wplacono dnia.:'
        @ 10,21 say 'Dowod wplaty..:'
        @ 11,21 say 'Kwota.........:'
        @ 12,21 say 'Uwagi.........:'
        @  9,37 get zDATAKS picture '@D'
        @ 10,37 get zNRDOK  picture '@S20 ' + Replicate( 'X', 100 )
        @ 11,37 get zKWOTA  picture FPIC
        @ 12,37 get zUWAGI  picture '@S20 '+replicate('X',60)
        read_()
        rest screen from SCRINSZAPL
        if lastkey()=27
           break
        endif
*ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
        do dopap
        do BLOKADAR
        repl_([FIRMA],IDENT_FIR)
        repl_([ROKKS],param_rok)
        repl_([NIP],zSZUKNIP)
        repl_([WYR],zWYR)
        repl_([DATAKS],zDATAKS)
        repl_([DATADOK],zDATAKS)
        repl_([TERMIN],zDATAKS)
        repl_([NRDOK],zNRDOK)
        repl_([ZRODLO],'R')
        repl_([RODZDOK],zRODZDOK)
        repl_([KWOTA],zKWOTA)
        repl_([UWAGI],zUWAGI)
        do case
        case zRODZDOK='ZS'
             repl_([MNOZNIK],1)
             repl_([SPRZEDAZ],zKWOTA)
        case zRODZDOK='ZZ'
             repl_([MNOZNIK],(-1))
             repl_([ZAKUP],zKWOTA*(-1))
        endcase
        commit_()
        unlock
*נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
        end
        @ 23,0
     endif
*########################### INSERT FAKTURY #############################
case kl=70.or.kl=102
        @ 1,47 say [          ]
        ColStb()
        center(23,[‏                     ‏])
        ColSta()
        center(23,[W P I S Y W A N I E])
        ColStd()

        begin sequence
*ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
        zSZUKNIP=space(13)
        zWYR=space(15)
        zDATAKS=date()
        zDATADOK=date()
        zTERMIN=date()
        zDNIPLAT=0
        zNRDOK=Space(100)
        zRODZDOK=' '
        zKWOTA=0.0
        zUWAGI=space(60)
        zKWOTAVAT=0.0
        zSZUKNAZ=space(70)
*ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
        save screen to SCRINSZAPL
        @  5,9 clear to 13,69
        @  5,9 to 13,69 double
        @  6,10 say padc('WPROWADZANIE FAKTURY',58)
        @  7,11 say 'Kontrahent NIP:'
        @  7,41 say 'szukaj nazwy..:'
        @  8,11 say 'Data ksiegow..:'
        @  8,41 say 'Data wyst.dok.:'
        @  9,11 say 'Termin zaplaty:    dni (..........)'
        @ 10,11 say 'Nr fakt.:'
        @ 10,41 say 'Rodzaj faktury:'
        @ 11,11 say 'Wartosc brutto:'
        @ 11,41 say 'Wartosc VAT...:'
        @ 12,11 say 'Uwagi.........:'
        @  7,26 get zSZUKNIP picture repl('!',13) valid vv1_3rozr()
        @  7,56 get zSZUKNAZ picture '@S13 '+repl('!',70) valid w1_3rozr()
        @  8,26 get zDATAKS picture '@D'
        @  8,56 get zDATADOK picture '@D'
        @  9,26 get zDNIPLAT picture '999'
        @  9,35 get zTERMIN picture '@D' when wTER_ROZR() valid vTER_ROZR()
        @ 10,20 get zNRDOK picture '@S10 ' + Replicate( 'X', 100 )
        @ 10,56 get zRODZDOK picture '!' when wRODZDOK(10,57) valid vRODZDOK(10,57)
        @ 11,26 get zKWOTA picture FPIC
        @ 11,56 get zKWOTAVAT picture FPIC
        @ 12,26 get zUWAGI picture '@S40 '+replicate('X',60)
        read_()
        rest screen from SCRINSZAPL
        if lastkey()=27
           break
        endif
*ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
        do dopap
        do BLOKADAR
        repl_([FIRMA],IDENT_FIR)
        repl_([ROKKS],param_rok)
        repl_([NIP],zSZUKNIP)
        repl_([WYR],param_rok+'-'+zNRDOK)
        repl_([DATAKS],zDATAKS)
        repl_([DATADOK],zDATADOK)
        repl_([TERMIN],zTERMIN)
        repl_([DNIPLAT],zDNIPLAT)
        repl_([NRDOK],zNRDOK)
        repl_([ZRODLO],'R')
        repl_([RODZDOK],'F'+zRODZDOK)
        do case
        case zRODZDOK='S'
             repl_([MNOZNIK],(-1))
             repl_([SPRZEDAZ],zKWOTA*(-1))
        case zRODZDOK='Z'
             repl_([MNOZNIK],1)
             repl_([ZAKUP],zKWOTA)
        endcase
        repl_([KWOTA],zKWOTA)
        repl_([KWOTAVAT],zKWOTAVAT)
        repl_([UWAGI],zUWAGI)
        commit_()
        unlock
*נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
*        _row=int((_row_g+_row_d)/2)
*        if .not.ins
*           break
*        endif
*        scroll(_row_g,_col_l,_row_d,_col_p,1)
*        @ _row_d,_col_l say '          ³     ³          ³          ³          ³                            '
        end
*_disp=ins.or.lastkey()#27
*kl=iif(lastkey()=27.and._row=-1,27,kl)
        @ 23,0
*########################### MODYFIKACJA WYROZNIKA #############################
case kl=119.or.kl=87
        @ 1,47 say [          ]
        ColStb()
        center(23,[‏                       ‏])
        ColSta()
        center(23,[M O D Y F I K A C J A])
        ColStd()

        begin sequence
*ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
        zWYR=WYR
*ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
        save screen to SCRINSZAPL
        @ 10,19 clear to 13,59
        @ 10,19 to 13,59 double
        @ 11,20 say padc('MODYFIKACJA WYROZNIKA',38)
        @ 12,21 say 'Wyroznik......:'
        @ 12,37 get zWYR picture replicate('!',15)
        read_()
        rest screen from SCRINSZAPL
        if lastkey()=27
           break
        endif
*ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
        do BLOKADAR
        repl_([WYR],zWYR)
        commit_()
        unlock
*נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
*        _row=int((_row_g+_row_d)/2)
*        if .not.ins
*           break
*        endif
*        scroll(_row_g,_col_l,_row_d,_col_p,1)
*        @ _row_d,_col_l say '          ³     ³          ³          ³          ³                            '
        end
*_disp=ins.or.lastkey()#27
*kl=iif(lastkey()=27.and._row=-1,27,kl)
        @ 23,0
*################################ KASOWANIE #################################
case kl=7.or.kl=46
     if ZRODLO<>'R'
        do komun with 'Tutaj mozesz usuwac tylko pozycje ktore wprowadziles w tej funkcji'
     else
        @ 1,47 say [          ]
        ColStb()
        center(23,[‏                   ‏])
        ColSta()
        center(23,[K A S O W A N I E])
        ColStd()
        _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
        if _disp
           do BLOKADAR
           del()
           unlock
           skip
           commit_()
           if &_bot
              skip -1
           endif
        endif
        @ 23,0
     endif
*########################### SZUKANIE NASTEPNEGO  #############################
case kl=77.or.kl=109
     recdocont=recno()
     cont
     if eof()
        do komun with 'Nie znaleziono nastepnego'
        go recdocont
     endif
*########################### SZUKANIE FAKTURY     #############################
case kl=78.or.kl=110
        @ 1,47 say [          ]
        ColStb()
        center(23,[‏             ‏])
        ColSta()
        center(23,[S Z U K A J])
        ColStd()

        begin sequence
*ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
* zSZUKNIP=space(13)
* zSZUKNAZ=space(70)
* zSZUKFAK=space(10)
* zSZUKOPT=space(1)
* zSZUKOPT2='O'
*ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
        save screen to SCRINSZAPL
        @  5,9 clear to 11,69
        @  5,9 to 11,69 double
        @  6,10 say padc('WPROWADZ KRYTERIA SZUKANIA',58)
        @  7,11 say 'Kontrahent NIP:'
        @  7,41 say 'szukaj nazwy..:'
        @  8,11 say 'Szukaj nr fakt:'
        @  9,11 say 'Dokladnie taki numer/Zawarte w numerze faktury (D/Z ?)'
        @ 10,11 say 'Szukac we wszystkich pozycjach/Od tej pozycji  (S/O ?)'
        @  7,26 get zSZUKNIP picture repl('!',13) valid vv1_3rozr()
        @  7,56 get zSZUKNAZ picture '@S13 '+repl('!',70) valid w1_3rozr()
        @  8,26 get zSZUKFAK picture '@S20 ' + repl( '!', 20 )
        @  9,66 get zSZUKOPT picture '!' valid zSZUKOPT$'DZ'
        @ 10,66 get zSZUKOPT2 picture '!' valid zSZUKOPT2$'SO'
        read_()
        rest screen from SCRINSZAPL
        if lastkey()=27
           break
        endif
        if zSZUKOPT2='S'
        do case
        case AllTrim( zSZUKNIP ) <> "" .and. AllTrim( zSZUKFAK ) == ""
             locate all for FIRMA=ident_fir .and. NIP=zSZUKNIP
        case AllTrim( zSZUKNIP ) == "" .and. AllTrim( zSZUKFAK ) <> ""
             if zSZUKOPT='Z'
                locate all for FIRMA=ident_fir .and. alltrim(zSZUKFAK)$NRDOK
             else
                locate all for FIRMA=ident_fir .and. NRDOK==zSZUKFAK
             endif
        case AllTrim( zSZUKNIP ) <> "" .and. AllTrim( zSZUKFAK ) <> ""
             if zSZUKOPT='Z'
                locate all for FIRMA=ident_fir .and. NIP=zSZUKNIP .and. alltrim(zSZUKFAK)$NRDOK
             else
                locate all for FIRMA=ident_fir .and. NIP=zSZUKNIP .and. NRDOK==zSZUKFAK
             endif
        endcase
        else
        do case
        case AllTrim( zSZUKNIP ) <> "" .and. AllTrim( zSZUKFAK ) == ""
             locate rest for FIRMA=ident_fir .and. NIP=zSZUKNIP
        case AllTrim( zSZUKNIP ) == "" .and. AllTrim( zSZUKFAK ) <> ""
             if zSZUKOPT='Z'
                locate rest for FIRMA=ident_fir .and. alltrim(zSZUKFAK)$NRDOK
             else
                locate rest for FIRMA=ident_fir .and. NRDOK==zSZUKFAK
             endif
        case AllTrim( zSZUKNIP ) <> "" .and. AllTrim( zSZUKFAK ) <> ""
             if zSZUKOPT='Z'
                locate rest for FIRMA=ident_fir .and. NIP=zSZUKNIP .and. alltrim(zSZUKFAK)$NRDOK
             else
                locate rest for FIRMA=ident_fir .and. NIP=zSZUKNIP .and. NRDOK==zSZUKFAK
             endif
        endcase
        endif
*ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
*נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
        end
        @ 23,0
*########################### AKTUALIZUJ STATUSY   #############################
case kl=65.or.kl=97
        seek ident_fir
        if found()
           do czekaj
           do while .not.eof().and.FIRMA==ident_fir
              kluczstat=ident_fir+NIP+WYR
              FS=0
              FZ=0
              ZS=0
              ZZ=0
              do while .not.eof().and.FIRMA+NIP+WYR==kluczstat
                 do case
                 case RODZDOK='FS'
                      FS=FS+(MNOZNIK*KWOTA)
                 case RODZDOK='FZ'
                      FZ=FZ+(MNOZNIK*KWOTA)
                 case RODZDOK='ZS'
                      ZS=ZS+(MNOZNIK*KWOTA)
                 case RODZDOK='ZZ'
                      ZZ=ZZ+(MNOZNIK*KWOTA)
                 endcase
                 skip
              enddo
              if FS+ZS=0.0 .and. FZ+ZZ=0.0
                 seek kluczstat
                 do while .not.eof().and.FIRMA+NIP+WYR==kluczstat
                    do BLOKADAR
                    repl_([STATUS],'R')
                    COMMIT
                    unlock
                    skip
                 enddo
              else
                 seek kluczstat
                 do while .not.eof().and.FIRMA+NIP+WYR==kluczstat
                    do BLOKADAR
                    repl_([STATUS],' ')
                    COMMIT
                    unlock
                    skip
                 enddo
              endif
           enddo
        endif
        seek ident_fir
*נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
        @ 23,0
        @ 24,0
*########################### USTAWIANIE FILTROW   #############################
case kl=82.or.kl=114.or.kl=76.or.kl=108.or.kl=49.or.kl=90.or.kl=122.or.kl=83.or.kl=115.or.kl=50
     do case
     case kl=82.or.kl=114
          FILTRO1="(STATUS=='R')"
          TEXTRO1='Tylko Rozliczone'
     case kl=76.or.kl=108
          FILTRO1="(STATUS<>'R')"
          TEXTRO1='Tylko Nierozliczone'
     case kl=49
          FILTRO1="1=1"
          TEXTRO1='Rozliczone i nierozliczone'
     case kl=90.or.kl=122
          FILTRO2="(RODZDOK='FZ'.or.RODZDOK='ZZ')"
          TEXTRO2='Tylko Zakupy'
     case kl=83.or.kl=115
          FILTRO2="(RODZDOK='FS'.or.RODZDOK='ZS')"
          TEXTRO2='Tylko Sprzedaz'
     case kl=50
          FILTRO2="1=1"
          TEXTRO2='Zakupy i sprzedaz'
     endcase
     set filter to firma=ident_fir .and. &FILTRO1 .and. &FILTRO2
     go top
*     @ 22,1 say padc('( '+TEXTRO1+', '+TEXTRO2+' )',78,'ִ')
*################################### POMOC ##################################
              case kl=28
save screen to scr_
@ 1,47 say [          ]
declare p[20]
*---------------------------------------
p[ 1]='                                                        '
p[ 2]='   ['+chr(24)+'/'+chr(25)+'].......poprzednia/nast&_e.pna pozycja             '
p[ 3]='   [Home/End]...pierwsza/ostatnia pozycja               '
p[ 4]='   [INSERT].....dopisanie zaplaty                       '
p[ 5]='   [F]..........dopisanie faktury                       '
p[ 6]='   [DEL]........usuniecie dopisanej zaplaty lub faktury '
p[ 7]='   [W]..........modyfikacja wyroznika                   '
p[ 8]='   [A]..........aktualizacja statusu (na rozliczone)    '
p[ 9]='   [N]..........szukanie                                '
p[10]='   [M]..........szukaj nastepnego wg zadanych kryteriow '
p[11]='   [Esc]........wyj&_s.cie                                 '
p[12]='                                                        '
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
procedure say41ro
return STATUS+NIP+[³]+WYR+[³]+dtoc(TERMIN)+[³]+dtoc(DATADOK)+[³]+str(SPRZEDAZ,12,2)+[³]+str(ZAKUP,12,2)
*############################################################################
procedure say41sro
clear type
set color to +w
roROKKS=ROKKS
roNIP=NIP
roWYR=WYR
reccc=recno()
sele 2
seek '+'+ident_fir+roNIP
if found()
   @ 16,13 say substr(NAZWA,1,65)
endif
sele 1
@ 17,13 say UWAGI
@ 18,13 say WYR
do case
case RODZDOK='FS'
     @ 18,48 say padr('FS-Faktura sprzedazy',31)
case RODZDOK='FZ'
     @ 18,48 say padr('FZ-Faktura zakupu',31)
case RODZDOK='ZS'
     @ 18,48 say padr('ZS-Wplata od kontrahenta',31)
case RODZDOK='ZZ'
     @ 18,48 say padr('ZZ-Zaplata kontrahentowi',31)
endcase
FS=0
FZ=0
ZS=0
ZZ=0
go top
seek ident_fir+roNIP+roWYR
if found()
   do while .not.eof().and.ident_fir+NIP+WYR==ident_fir+roNIP+roWYR
      do case
      case RODZDOK='FS'
           FS=FS+(MNOZNIK*KWOTA)
      case RODZDOK='FZ'
           FZ=FZ+(MNOZNIK*KWOTA)
      case RODZDOK='ZS'
           ZS=ZS+(MNOZNIK*KWOTA)
      case RODZDOK='ZZ'
           ZZ=ZZ+(MNOZNIK*KWOTA)
      endcase
      skip
   enddo
end
go reccc
@ 19,13 say str(FS+FZ,12,2)
@ 20,13 say str(ZS+ZZ,12,2)
@ 21,13 say str((FS+FZ)+(ZS+ZZ),12,2)
DOROZL=(FS+FZ)+(ZS+ZZ)
@ 19,48 say SubStr( NRDOK, 1, 10 )
@ 20,48 say dtoc(DATAKS)
@ 21,48 say dtoc(DATADOK)
@ 19,70 say str(DNIPLAT,3)
do case
case ZRODLO='R'
     @ 20,70 say 'TUTAJ    '
case ZRODLO='K'
     @ 20,70 say 'KSIEGA   '
case ZRODLO='S'
     @ 20,70 say 'Rej.SPRZ.'
case ZRODLO='Z'
     @ 20,70 say 'Rej.ZAKU.'
case ZRODLO='F'
     @ 20,70 say 'FAKTURY  '
endcase
if STATUS='R'
   @ 21,70 say 'Rozliczo.'
else
   @ 21,70 say '         '
endif
set color to
@ 22,1 say padc('( '+TEXTRO1+', '+TEXTRO2+' )',78,'ִ')
return
*############################################################################
***************************************************
function Vv1_3rozr
***************************************************
if lastkey()=5
   return .t.
endif
if len(alltrim(zSZUKNIP))#0
   sele kontr
   seek [+]+ident_fir+zSZUKNIP
   if found()
      zSZUKNAZ=nazwa
      keyboard chr(13)
   else
      znazwa=space(70)
      set color to i
      @ 7,26 say substr(zSZUKNIP,1,13)
      @ 7,56 say substr(zSZUKNAZ,1,13)
      set color to
   endif
   sele ROZR
endif
return .t.
***************************************************
function w1_3rozr
***************************************************
save screen to scr2
if len(alltrim(zSZUKNIP))#0
   sele kontr
   seek [+]+ident_fir+zSZUKNIP
   if .not.found()
      set orde to 1
      seek [+]+ident_fir+substr(zSZUKNAZ,1,15)
      if del#[+].or.firma#ident_fir
         skip -1
      endif
   endif
   set orde to 1
else
   select kontr
   set orde to 1
   seek [+]+ident_fir+substr(zSZUKNAZ,1,15)
   if del#[+].or.firma#ident_fir
      skip -1
   endif
endif
sele kontr
set orde to 1
if del=[+].and.firma=ident_fir
   Kontr_()
   restore screen from scr2
   if lastkey()=13
      zSZUKNAZ=nazwa
      zSZUKNIP=NR_IDENT
      set color to i
      @ 7,26 say substr(zSZUKNIP,1,13)
      @ 7,56 say substr(zSZUKNAZ,1,13)
      set color to
*      keyboard chr(13)
   endif
endif
sele kontr
set orde to 2
select rozr
return .t.
*############################################################################
func wTER_ROZR
zTERMIN=zDATADOK+zDNIPLAT
return .t.
***************************************************
func vTER_ROZR
zDNIPLAT=zTERMIN-zDATADOK
set color to i
@ 9,26 say zDNIPLAT pict '999'
set color to
return .t.
***************************************************
function wRODZDOK
para x,y
ColInf()
@ 24,0 say padc('Sprzedaz czy zakup (S/Z) ?',80,' ')
ColStd()
@ x,y say iif(zRODZDOK='S','przedaz','akup   ')
return .t.
***************************************************
function vRODZDOK
para x,y
R=.f.
if zRODZDOK$'SZ'
   ColStd()
   @ x,y say iif(zRODZDOK='S','przedaz','akup   ')
   @ 24,0
   R=.t.
endif
return R

