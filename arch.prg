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
*±±±±±± ARCH     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Procedura obslugujaca archiwowanie danych na dyskietki.                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Arch()

archfile=[ksiega]
declare p[1]
if .not.file([arch.mem])
   *---------------------------------------
   @  3,42 say '                                      '
   @  4,42 say '                                      '
   @  5,42 say '                                      '
   @  6,42 say '                                      '
   @  7,42 say '                                      '
   @  8,42 say '    Opcja kopiowania danych tworzy    '
   @  9,42 say '    na wskazanym dysku kopie danych   '
   @ 10,42 say '    programu.                         '
   @ 11,42 say '    W przypadku kopiowania danych     '
   @ 12,42 say '    na dyskietki, nalezy uzyc puste   '
   @ 13,42 say '    sformatowane dyskietki. Kolejne   '
   @ 14,42 say '    kopiowanie na te same dyskietki   '
   @ 15,42 say '    likwiduje poprzedni zapis         '
   @ 16,42 say '    samoczynnie. Nie trzeba pamietac  '
   @ 17,42 say '    kolejnosci dyskietek przy         '
   @ 18,42 say '    odtwarzaniu danych.               '
   @ 19,42 say '                                      '
   @ 20,42 say '                                      '
   @ 21,42 say '                                      '
   @ 22,42 say '                                      '
   *---------------------------------------
   @ 1,47 say space(10)
   @ 24,7 prompt '[ Nap&_e.d A (stacja dyskietek) ]'
*   @ 24,41 prompt '[ Nap&_e.d B (inny dysk+sciezka) ]'
   @ 24,41 prompt '[ Inny nap&_e.d (inny dysk+sciezka) ]'
   clear type
   naped=menu(1)
   if lastkey()=27
      return
   endif
   *+++++++++++++++++++++++++++++++++
   if naped=1
      if .not.entesc([*u],' Wsu&_n. dyskietk&_e. do nap&_e.du A: i naci&_s.nij [Enter] ')
         return
      endif
      do while .t.
         *---
         adir([a:]+archfile+[.*],p)
         if type('p[1]')=[C]
            erase ([a:]+p[1])
         endif
         *---
         if diskspace(naped)<360000
            if entesc([*w],'Brak dyskietki lub nie jest sformatowana - zmie&_n. dyskietk&_e. i naci&_s.nij [Enter]')
               loop
            endif
            return
         endif
         exit
      enddo
   endif
if naped=2
   sciez_ar='c:\'
   if .not.file([archpath.mem])
      save to archpath all like sciez_ar
   else
      restore from archpath additive
   endif
   razempl=0
   do while razempl=0
      sciez_ar=alltrim(sciez_ar)+repl(' ',100-len(alltrim(sciez_ar)))
      @ 24,0 clear to 24,79
      @ 24,5 say 'Podaj folder do zapisu kopii' get sciez_ar pict '@S30 '+repl('!',100)
      read
      if lastkey()=27
         return
      endif

      razempl=0
      zparspr=alltrim(sciez_ar)+'*.*'
      katal=directory(zparspr,'HSDV')
      aeval(katal,{|zbi|RAZEMPL++})
      if razempl=0
         do komun with 'Brak podanego folderu. Podaj inny'
      else
         save to archpath all like sciez_ar
      endif

   enddo
endif
   do CZEKAJ
   *+++++++++++++++++++++++++++++++++
   save to arch all like naped
   save to scr all like scr
   if file(RAPTEMP+'.dbf')
      dele file &RAPTEMP..dbf
   endif
   if file(RAPTEMP+'.cdx')
      dele file &RAPTEMP..cdx
   endif
*wait "cancel"
   hbfr_FreeLibrary()
   amiDllZakoncz()
   WinPrintDone()
   cancel
endif
restore from arch additive
restore from scr additive
erase arch.mem
erase scr.mem
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
do CZEKAJ
x=fopen([kopia.arc],0)
if fblad(ferror())<>0
   return
endif
if naped=1
   size=fseek(x,0,2)
   fseek(x,0,0)
   pozycja=0
   poj_dysk=diskspace(naped)
   nr_dysk=0
   do while .t.
      nr_dysk=nr_dysk+1
      CURR=ColInb()
      @ 24,0
      center(24,[Prosz&_e. czeka&_c.... Sk&_l.aduj&_e. dyskietk&_e. nr ]+str(nr_dysk,2))
      setcolor(CURR)
      zm=iif(size-pozycja<=poj_dysk-1,[z],[x])+strtran(str(nr_dysk,2),[ ],[0])
      y=fcreate([a:]+archfile+[.]+zm,0)
      if fblad(ferror())<>0
         exit
      endif
      poz=pozycja
      rozmem=min(50000,memory(2)*1024)
*     rozmem=10000
*     wait rozmem
*     wait memory(0)*1024
*     wait memory(2)*1024
      do while pozycja<min(poz+poj_dysk-rozmem,size)
         inf=space(rozmem)
         fread(x,@inf,rozmem)
         if fblad(ferror())<>0
            exit
         endif
         fwrite(y,inf,min(rozmem,size-pozycja))
         if fblad(ferror())<>0
            exit
         endif
         pozycja=pozycja+rozmem
         rozmem=min(rozmem,size-pozycja)
      enddo
      rele rozmem
*     wait memory(0)*1024
      fclose(y)
      if fblad(ferror())<>0
         exit
      endif
      if pozycja>=size
         exit
      endif
      *+++++++++++++++++++++++++++++++++
      if .not.entesc([*u],' Wsu&_n. nast&_e.pn&_a. dyskietk&_e. do nap&_e.du A: i naci&_s.nij [Enter] ')
         do arch_
         if fblad(ferror())<>0
            return
         endif
         return
      endif
      do while .t.
         if diskspace(naped)>10000000
*        if diskspace(naped)<100000
            if entesc([*w],'Brak dyskietki lub nie jest sformatowana - zmie&_n. dyskietk&_e. i naci&_s.nij [Enter]')
               loop
            endif
            do arch_
            if fblad(ferror())<>0
               return
            endif
            return
         endif
         *---
         adir([a:]+archfile+[.*],p)
         if type('p[1]')=[C]
            erase ([a:]+p[1])
         endif
         *---
         if diskspace(naped)<360000
            if entesc([*w],' Dyskietka nie jest wyczyszczona - zmie&_n. dyskietk&_e. i naci&_s.nij [Enter] ')
               loop
            endif
            do arch_
            return
         endif
         exit
      enddo
      do CZEKAJ
      *+++++++++++++++++++++++++++++++++
   enddo
endif
if naped=2
   pel_path=''
   sciez_ar='c:\'
   if .not.file([archpath.mem])
      save to archpath all like sciez_ar
   else
      restore from archpath additive
   endif
   wernaz=strtran(wersprog,'.','')+strtran(substr(strtran(time(),':',''),1,4),' ','0')
   if substr(alltrim(sciez_ar),len(alltrim(sciez_ar)),1)='\'
      pel_path=alltrim(sciez_ar)+wernaz+'.z01'
      copy file kopia.arc to &pel_path
   else
      pel_path=alltrim(sciez_ar)+'\'+wernaz+'.z01'
      copy file kopia.arc to &pel_path
   endif
endif

*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
do arch_
@ 24,0
center(24,[- kopiowanie zako&_n.czone -])
if nr_uzytk<>81
tone(500,4)
endif
pause(0)
*********************
procedure arch_
fclose(x)
release all like inf
copy file kopia.arc to kopia.kpr
erase kopia.arc
