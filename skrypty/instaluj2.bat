@copy %1\p.exe >nul
@copy %1\konwersja.exe >nul
@konwersja .
@attrib -r prog.exe >nul
@%1\p x -y >nul
@attrib +r prog.exe >nul
@del konwersja.exe >nul
@del p.exe >nul
