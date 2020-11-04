@echo off
:ramka
@cls
menu.exe %1 %2 %3
if errorlevel 3 goto powrot
if errorlevel 2 goto ksiega
if errorlevel 1 goto oldy
goto ramka
:oldy
call _cd
call ksiega.bat %1 %2 %3
cd ..
goto ramka
:ksiega
if exist exit.mem del exit.mem
if exist arch.mem del arch.mem
if exist odtw.mem del odtw.mem
if exist zadanie1.mem del zadanie1.mem
if exist zadanie2.mem del zadanie2.mem
if exist inst.mem del inst.mem
if exist kopia.arc del kopia.arc
if exist instart.bat del instart.bat
:e1
copy ksiega.bat start>l.txt
rem call polska
prog %1 %2 %3
if exist start del start
if not exist arch.mem goto e2
7z a kopia.arc *.dbf *.mem *.fpt polznak.* XML\*.* > l.txt
goto e1
:e2
if not exist odtw.mem goto e4
7z x -aoa kopia.arc>l.txt
goto e1
:e4
if not exist zadanie1.mem goto e6
call ZADANIE1.BAT
goto e1
:e6
if not exist zadanie2.mem goto e5
call ZADANIE2.BAT
goto e1
:e5
if not exist instart.bat goto e3
call instart>l.txt
goto e1
:e3
if exist exit.mem goto e1
goto ramka
:powrot
cls
