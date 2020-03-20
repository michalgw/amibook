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
*±±±±±± INSTALUJ ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Procedura uruchamiajaca procedure instalacyjna nowej ksiegi               ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Instaluj()

   LOCAL nCh
   LOCAL nRes

   IF .NOT. File( 'instart.bat' )

   nCh := MenuEx( 14, 2, { "S - Sprawd« dost©pno˜† aktualizacji", "P - Pobierz i zainstaluj now¥ wersj©", "I - Instaluj now¥ wersj©" } );

      DO CASE
      CASE nCh == 0
         RETURN NIL

      CASE nCh == 1
         SprawdzAktualizacje( .T. )
         RETURN NIL

      CASE nCh == 2 .OR. nCh == 3

         nRes := amiAktualizuj( nCh == 2 )

         IF nRes == 0 .AND. File( 'instart.bat' )
            hbfr_FreeLibrary()
            amiDllZakoncz()
            WinPrintDone()

            ColStd()
            CLS
            @ 10, 10 SAY 'Aktualizacja programu....'

            CANCEL

         ENDIF

         RETURN NIL

      ENDCASE

   ENDIF

   ERASE instart.bat
   ERASE inst.mem
   ERASE scr.mem
   Tone( 500, 4 )

   RETURN NIL

/*
archfile=[instart.bat]
if .not.file([instart.bat])
   *---------------------------------------
   @  3,42 say '                                      '
   @  4,42 say '                                      '
   @  5,42 say '                                      '
   @  6,42 say '                                      '
   @  7,42 say '                                      '
   @  8,42 say '                                      '
   @  9,42 say '                                      '
   @ 10,42 say '    Funkcja instalacji nowej wersji   '
   @ 11,42 say '    programu AMi-BOOK mo&_z.e w skrajnych'
   @ 12,42 say '    okoliczno&_s.ciach spowodowa&_c. utrat&_e. '
   @ 13,42 say '    danych. Dlatego te&_z. przed insta-  '
   @ 14,42 say '    lacj&_a. prosz&_e. BEZWZGL&__E.DNIE wykona&_c. '
   @ 15,42 say '    kopie zbior&_o.w w co najmniej dw&_o.ch '
   @ 16,42 say '    egzemplarzach.                    '
   @ 17,42 say '                                      '
   @ 18,42 say '                                      '
   @ 19,42 say '                                      '
   @ 20,42 say '                                      '
   @ 21,42 say '                                      '
   @ 22,42 say '                                      '
   *---------------------------------------
   if .not.tnesc([*i],[UWAGA!!! Czy jeste&_s. pewny &_z.e dane s&_a. zabezpieczone i mo&_z.na instalowa&_c. ? (T/N)])
      return
   endif
   sciez_in=''
   @ 1,47 say space(10)
   @ 24,20 prompt '[ Nap&_e.d A ]'
   @ 24,40 prompt '[ Dowolny wskazany folder ]'
   clear type
   naped=menu(1)
   if lastkey()<>13
      return
   endif
   save to scr all like scr
   *------------------
   if naped=1
      sciez_in='a:'
      if .not.entesc([*u],' Wsu&_n. dyskietk&_e. do nap&_e.du '+iif(naped=1,[A],[B])+' i naci&_s.nij [Enter] ')
         return
      endif
   endif
   if naped=2
      sciez_in='a:'
      if .not.file([instpath.mem])
         save to instpath all like sciez_in
      else
         restore from instpath additive
      endif

      razempl=0
      do while razempl=0
         sciez_in=alltrim(sciez_in)+repl(' ',100-len(alltrim(sciez_in)))
         @ 24,0 clear to 24,79
         @ 24,5 say 'Folder z plikami instalacji ' get sciez_in pict '@S30 '+repl('!',100)
         read
         if lastkey()=27
            return
         endif
         sciez_in=alltrim(sciez_in)
         if substr(sciez_in,len(sciez_in),1)='\'
            sciez_in=substr(sciez_in,1,len(sciez_in)-1)
         endif
         razempl=0
         zparspr=sciez_in+'\*.*'
         katal=directory(zparspr,'HSDV')
         aeval(katal,{|zbi|RAZEMPL++})
         if razempl=0
            do komun with 'Brak podanego folderu. Podaj prawid&_l.owy.'
         else
            save to archpath all like sciez_in
         endif

      enddo

   endif
   sciez_in2=sciez_in+'\instaluj.bat'
   do while .t.
      if .not.file(sciez_in2) .AND. .NOT.File(sciez_in + '\setup.exe')
         entesc([*w],'Brak dyskietki lub pliku instalacyjnego - podaj prawid&_l.ow&_a. lokalizacj&_e.')
         return
      endif
      exit
   enddo
   *------------------
   do czekaj
   x=fcreate(archfile,0)
   IF File(sciez_in + '\instaluj.bat')
      sciez_in2 := sciez_in + '\instaluj.bat'
      fwrite(x,sciez_in2+' '+sciez_in + Chr(13) + Chr(10) + "start /b ksiega.exe")
   ELSE
      sciez_in2 := sciez_in + '\setup.exe'
      fwrite(x,'"' + sciez_in2 + '" /DIR="' + hb_DirBase() + '"' + Chr(13) + Chr(10) + "start /b ksiega.exe")
   ENDIF
   fclose(x)
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   save to inst all like naped
   if file(RAPTEMP+'.dbf')
      dele file &RAPTEMP..dbf
   endif
   if file(RAPTEMP+'.cdx')
      dele file &RAPTEMP..cdx
   endif
   hbfr_FreeLibrary()
   amiDllZakoncz()
   WinPrintDone()
   cancel
endif
restore from inst additive
restore from scr additive
do inst_
tone(500,4)
*********************
procedure inst_
erase instart.bat
erase inst.mem
erase scr.mem
*/