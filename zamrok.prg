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

FUNCTION ZamRok()

old_rok=param_rok
new_rok=str((val(PARAM_ROK)+1),4)
@ 3,42 clear to 22,79
@ 4,42 to 22,79 double
set color to i
@  4,43 say [                                    ]
@  5,43 say [             U W A G A              ]
@  6,43 say [ Funkcja NOWY ROK w &_z.aden spos&_o.b nie]
@  7,43 say [ ogranicza dost&_e.pu do danych ]+old_rok+[r. ]
@  8,43 say [ Przygotowuje ona program do pracy  ]
@  9,43 say [ w nowym ]+new_rok+[ roku.                 ]
@ 10,43 say [ Funkcja wykonuje kolejno operacje: ]
@ 11,43 say [ 1.zak&_l.ada podkatalog OLD]+old_rok+[ i     ]
@ 12,43 say [   wykopiowuje tam bie&_z.&_a.ce dane.    ]
@ 13,43 say [ 2.zmienia rok ewidencyjny na ]+new_rok+[  ]
@ 14,43 say [   (dost&_e.pny w parametrach programu)]
@ 15,43 say [   Od tej chwili uruchomiony program]
@ 16,43 say [   pracuje w ]+new_rok+[ roku              ]
@ 17,43 say [ Po wykonaniu funkcji nale&_z.y urucho-]
@ 18,43 say [ mi&_c. program z roku ]+old_rok+[. Je&_z.eli    ]
@ 19,43 say [ wszystkie dane zosta&_l.y prawid&_l.owo  ]
@ 20,43 say [ przekopiowane, nale&_z.y skasowa&_c.     ]
@ 21,43 say [ dane w roku ]+new_rok+[. Po skasowaniu    ]
@ 22,43 say [ mo&_z.na wprowadza&_c. nowe dane.        ]
set color to
if .not.tnesc([*u],[ Jeste&_s. pewny &_z.e chcesz rozpocz&_a.&_c. rok ]+new_rok+[ ? (T/N) ])
   return
endif
@ 3,42 clear to 22,79
@ 11,49 to 17,74 double
set color to i
@ 11,50 say '                        '
@ 12,50 say '     U W A G A  !!!     '
@ 13,50 say '                        '
@ 14,50 say '  Nale&_z.y wykona&_c. kopie  '
@ 15,50 say '      w co najmniej     '
@ 16,50 say '  dw&_o.ch egzemplarzach ? '
@ 17,50 say '                        '
set color to
IF param_dzw='T'
   tone(500,4)
   tone(500,4)
   tone(500,4)
endif
if tnesc([*i],[   Czy wykona&_l.e&_s. kopie danych z ]+old_rok+[ roku ? (T/N)   ])
   set cursor off
   do czekaj
      !cmd.exe /C "md OLD&old_rok"
      !cmd.exe /C "copy *.dbf old&old_rok"
      !cmd.exe /C "copy *.fpt old&old_rok"
      !cmd.exe /C "copy *.cdx old&old_rok"
      !cmd.exe /C "copy *.mem old&old_rok"
      !cmd.exe /C "copy *.txt old&old_rok"
      !cmd.exe /C "copy *.odt old&old_rok"
      !cmd.exe /C "copy *.docx old&old_rok"
      !cmd.exe /C "copy *.txt old&old_rok"
      !cmd.exe /C "copy *.kdu old&old_rok"
      !cmd.exe /C "copy *.bat old&old_rok"
      !cmd.exe /C "copy *.com old&old_rok"
      !cmd.exe /C "copy rar.* old&old_rok"
      !cmd.exe /C "copy ind*.* old&old_rok"
      !cmd.exe /C "copy pol*.* old&old_rok"
      !cmd.exe /C "copy *.exe old&old_rok"
      !cmd.exe /C "copy 7z.* old&old_rok"
      !cmd.exe /C "copy *.dll old&old_rok"
      !cmd.exe /C "copy *.lic old&old_rok"
      !cmd.exe /C "copy *.ini old&old_rok"
      !cmd.exe /C "md OLD&old_rok\XML"
      !cmd.exe /C "copy XML\*.* OLD&old_rok\XML"
      !cmd.exe /C "md OLD&old_rok\frf"
      !cmd.exe /C "copy frf\*.* OLD&old_rok\frf"
      !cmd.exe /C "del OLD&old_rok\_??????_.dbf"
      !cmd.exe /C "md OLD&old_rok\xsd"
      !cmd.exe /C "copy xsd\*.* OLD&old_rok\xsd"
   param_rok=new_rok
   save to param all like param_*

   IF param_dzw='T'
      tone(300,5)
   endif
endif
