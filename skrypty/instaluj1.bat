@copy %1\p.exe >nul
@attrib -r prog.exe >nul
@%1\p x -y >nul
@attrib +r prog.exe >nul
@del p.exe >nul
