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

#include "Directry.ch"
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ODTW     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Procedura obslugujaca odtwarzanie danych z dyskietek.                     ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Odtw()

archfile=[ksiega]
if .not.file([odtw.mem])
   *---------------------------------------
   @  3,42 say '                                      '
   @  4,42 say '                                      '
   @  5,42 say '                                      '
   @  6,42 say '                                      '
   @  7,42 say '                                      '
   @  8,42 say '                                      '
   @  9,42 say '                                      '
   @ 10,42 say '    Opcja odtwarzania danych zamienia '
   @ 11,42 say '    dane w komputerze na dane zawarte '
   @ 12,42 say '    w kopii na wskazanym dysku.       '
   @ 13,42 say '    W przypadku odtwarzania danych    '
   @ 14,42 say '    z dyskietek, kolejno&_s.&_c. wsuwanych  '
   @ 15,42 say '    dyskietek nie jest istotna.       '
   @ 16,42 say '                                      '
   @ 17,42 say '                                      '
   @ 18,42 say '                                      '
   @ 19,42 say '                                      '
   @ 20,42 say '                                      '
   @ 21,42 say '                                      '
   @ 22,42 say '                                      '
   *---------------------------------------
   if .not.tnesc([*i],[ UWAGA ! Informacje w bazach danych zostan&_a. zamienione - jeste&_s. pewny? (T/N) ])
      return
   endif
   @ 1,47 say space(10)
   @ 24,7 prompt '[ Nap&_e.d A (stacja dyskietek) ]'
   @ 24,44 prompt '[ Inny nap&_e.d (wskazany plik) ]'
   clear type
   naped=menu(1)
   if lastkey()=27
      return
   endif
   *------------------
   if naped=1
      if .not.entesc([*u],' Wsu&_n. dyskietke do nap&_e.du '+iif(naped=1,[A],[B])+' i naci&_s.nij [Enter] ')
         return
      endif
      do while .t.
         if .not.file(iif(naped=1,[a:]+archfile+[.*],[b:]+archfile+[.*]))
            if entesc([*w],'Brak dyskietki lub kopii na dyskietce - zmie&_n. dyskietke i naci&_s.nij [Enter]')
               loop
            endif
            return
         endif
         exit
      enddo
      *------------------
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      declare p[1]
      store 0 to nr_dysk,il_dysk
      do while .t.
         ColInb()
         @ 24,0 clear
         center(24,[Prosz&_e. czeka&_c....])
         set color to
         nr_dysk=nr_dysk+1
         adir([a:]+archfile+[.*],p)
         if left(right(p[1],3),1)=[Z]
            il_dysk=val(right(p[1],2))
         endif
         copy file ([a:]+p[1]) to (p[1])
         if nr_dysk>=il_dysk.and.il_dysk#0
            exit
         endif
         *------------------
         if .not.entesc([*u],' Wsu&_n. nast&_e.pn&_a. dyskietke do nap&_e.du '+iif(naped=1,[A],[B])+' i naci&_s.nij [Enter] ')
            do odtw_
            return
         endif
         do while .t.
            if .not.file([a:]+archfile+[.*])
               if entesc([*w],'Brak dyskietki lub kopii na dyskietce - zmie&_n. dyskietke i naci&_s.nij [Enter]')
                  loop
               endif
               do odtw_
               return
            endif
            exit
         enddo
      enddo
      *===============scalanie===============
      ColInb()
      @ 24,0 clear
      center(24,[Prosz&_e. czeka&_c....])
      set color to
      x=fcreate([kopia.arc],0)
      if fblad(ferror())<>0
         return
      endif
      for i=1 to il_dysk
         ColInb()
         @ 24,0 clear
         center(24,[Prosz&_e. czeka&_c.... Odtwarzam dyskietke nr ]+str(i,2))
         set color to
         zm=archfile+[.]+iif(i=il_dysk,[z],[x])+strtran(str(i,2),[ ],[0])
         y=fopen(zm,0)
         if fblad(ferror())<>0
            exit
         endif
         size=fseek(y,0,2)
         fseek(y,0,0)
         pozycja=0
         rozmem=min(50000,memory(2)*1024)
*        wait memory(0)*1024
         do while pozycja<size
            inf=space(rozmem)
            fread(y,@inf,rozmem)
            if fblad(ferror())<>0
               exit
            endif
            fwrite(x,inf,min(rozmem,size-pozycja))
            if fblad(ferror())<>0
               exit
            endif
            pozycja=pozycja+rozmem
            rozmem=min(rozmem,size-pozycja)
         enddo
         rele rozmem
*        wait memory(0)*1024
         if fblad(ferror())<>0
            exit
         endif
         fclose(y)
         if fblad(ferror())<>0
            exit
         endif
         erase (zm)
      next
      fclose(x)
      if fblad(ferror())<>0
         return
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      save to odtw all like il_dysk
      save to scr all like scr
      if file(RAPTEMP+'.dbf')
         dele file &RAPTEMP..dbf
      endif
      if file(RAPTEMP+'.cdx')
         dele file &RAPTEMP..cdx
      endif
      rele all
      hbfr_FreeLibrary()
      amiDllZakoncz()
      WinPrintDone()
      cancel
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
         @ 24,5 say 'Podaj dysk i folder z kopi&_a. ' get sciez_ar pict '@S30 '+repl('!',100)
         read
         if lastkey()=27
            return
         endif

         pel_path=''
         if substr(alltrim(sciez_ar),len(alltrim(sciez_ar)),1)='\'
            pel_path=alltrim(sciez_ar)
*            copy file kopia.arc to &pel_path
         else
            pel_path=alltrim(sciez_ar)+'\'
*            copy file kopia.arc to &pel_path
         endif

         razempl=0
         zparspr=alltrim(pel_path)+'*.z01'
         katal=directory(zparspr,'HSD')
         aeval(katal,{|zbi|RAZEMPL++})

*         do komun with 'Sortuje liste plikow'
         ASORT( katal,,, { | x, y | x[ F_DATE ] > y[ F_DATE ] } )
*         do komun with 'Preparuje liste plikow'
         listaplik={}
         FOR nItem := 1 TO razempl
            AADD( listaplik, PADR( katal[ nItem, F_NAME ], 15 ) + ;
                          IF( SUBSTR( katal[ nItem, F_ATTR ], ;
                          1, 1 ) == "D", "   <dir>", ;
                          STR( katal[ nItem, F_SIZE ], 8 ) ) + "  " + ;
                          DTOC( katal[ nItem, F_DATE ] ) + "  " + ;
                          SUBSTR( katal[ nItem, F_TIME ], 1, 5) + "  " + ;
                          SUBSTR( katal[ nItem, F_ATTR ], 1, 4 ) + "  " )
         NEXT

         if razempl=0
            do komun with 'Brak podanego folderu lub plikow z kopiami. Podaj inny folder'
         else
            @ 9,29 clear to 23,79
            @ 9,29 to 23,79
            @ 9,39 say 'Wybierz kopi&_e. kt&_o.ra odtworzy&_c.'
*            achoice(10,0,22,70,katal[1]+' ³ '+str(katal[2],8)+' ³ '+dtoc(katal[3])+' ³ '+katal[4]+' ³ '+katal[5]+' ³ ',.t.)
            wybrplik=achoice(10,30,23,78,listaplik,.t.)
            if lastkey()=13
               pel_path=pel_path+substr(listaplik[wybrplik],1,12)
               if tnesc(0,'Jestes pewny ze chcesz zastapic dane w bazach danymi z tej kopii ? (T/N) ')=.t.
                  copy file &pel_path to kopia.arc
                  il_dysk=1
                  save to odtw all like il_dysk
                  save to scr all like scr
                  if file(RAPTEMP+'.dbf')
                     dele file &RAPTEMP..dbf
                  endif
                  if file(RAPTEMP+'.cdx')
                     dele file &RAPTEMP..cdx
                  endif
                  rele all
                  hbfr_FreeLibrary()
                  amiDllZakoncz()
                  cancel
               else
                  return
               endif
            else
               return
            endif
         endif

      enddo
   endif
endif
restore from odtw additive
restore from scr additive
ColInb()
@ 24,0 clear
center(24,[Prosz&_e. czeka&_c....])
set color to
do odtw_
Indeks()
*!indeks
do numeruj
center(24,[- Odtwarzanie zako&_n.czone -])
IF param_dzw='T'
tone(500,4)
endif
pause(0)
*********************
procedure odtw_
for i=1 to il_dysk
    erase (archfile+[.]+iif(i=il_dysk,[z],[x])+strtran(str(i,2),[ ],[0]))
next
erase arch.mem
erase odtw.mem
erase scr.mem
erase kopia.arc
