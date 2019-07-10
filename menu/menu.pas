Program menu;

Uses Dos,Crt,Windows, sysutils;
{,Strings;}
Const
     Esc = #27;
     Enter = #13;
Var
     znak : char;
        a : string[8];
    i,j,b : byte;
  c,konie : integer;
        s : array[1..30] of string[8];
       sl : array[1..30] of string[8];
  DirInfo : SearchRec;
     CurD : string[30];
    tekst : text;


Procedure bum(j,ktory:integer);
Begin
  for i:=1 to j do
    Begin
      case ktory of
         1 : sound(200);
         2 : sound(100);
      end;
{      sound(i*i*i);}
      delay(50);
{      delay(j-i)}
    end;
  nosound
end;


PROCEDURE rama_okna(x1,y1,x2,y2,rodzaj,deska:byte);
Var
   r1,r2,r3,r4,r5,r6,tlo : UTF8String;
Begin
  case rodzaj of
    0 : Begin
          r1:=' ';
          r2:=' ';
          r3:=' ';
          r4:=' ';
          r5:=' ';
          r6:=' '
        end;
    1 : Begin
          r1:='';//chr(196);   {Ä}
          r2:='';//chr(179);   {³}
          r3:='';//chr(218);   {Ú}
	  r4:='';//chr(191);   {¿}
          r5:='';//chr(217);   {Ù}
          r6:='';//chr(192)    {À}
        end;
    2 : Begin
          r1:='';//chr(205);   {Í}
          r2:='';//chr(186);   {º}
          r3:='';//chr(201);   {É}
          r4:='';//chr(187);   {»}
          r5:='';//chr(188);   {¼}
          r6:='';//chr(200)    {È}
        end;
    3 : Begin
          r1:='*';        {*}
          r2:='*';
          r3:='*';
          r4:='*';
          r5:='*';
          r6:='*'
        end;
    4 : Begin
          r1:=chr(254);   {þ}
          r2:=chr(254);
          r3:=chr(254);
          r4:=chr(254);
          r5:=chr(254);
          r6:=chr(254)
        end
  end;
  case deska of
    0 : tlo:=' ';      { }
    1 : tlo:='';//chr(176); {°}
    2 : tlo:='';//chr(177); {±}
    3 : tlo:='';//chr(178); {²}
    4 : tlo:='*'       {*}
  end;
  gotoxy(x1,y1);
  for i:=x1 to x2 do
    if i=x1 then write(r3)
            else if i=x2 then write(r4)
                         else write(r1);
  gotoxy(x1,y2);
  for i:=x1 to x2 do
    if i=x1 then write(r6)
            else if i=x2 then write(r5)
                         else write(r1);
  for i:=y1+1 to y2-1 do
    Begin
      gotoxy(x1,i);
      write(r2);
      gotoxy(x2,i);
      write(r2)
    end;
  for i:=y1+1 to y2-1 do
    for j:=x1+1 to x2-1 do
      Begin
        gotoxy(j,i);
        write(tlo)
      end
end;

PROCEDURE explose(x1,y1,x2,y2,rodzaj,deska,opoz:byte);
Var
   a,b,a1,b1,a2,b2 : byte;
Begin
  a:=(x2+x1) div 2;
  b:=(y2+y1) div 2;
  gotoxy(a,b);
  write(chr(254));
  if a<>1 then a1:=a-1 else a1:=a;
  if b<>1 then b1:=b-1 else b1:=b;
  if a<((x2-x1)+1) then a2:=a+1 else a2:=a;
  if b<(y2-y1) then b2:=b+1 else b2:=b;
  rama_okna(a1,b1,a2,b2,rodzaj,deska);
  repeat
    if a1>x1 then a1:=a1-1;
    if b1>y1 then b1:=b1-1;
    if a2<x2 then a2:=a2+1;
    if b2<y2 then b2:=b2+1;
    rama_okna(a1,b1,a2,b2,rodzaj,deska);
    delay(opoz)
  until (a1=x1) and (b1=y1) and (a2=x2) and (b2=y2);
  bum(1,1)
end;

PROCEDURE implose(x1,y1,x2,y2,rodzaj,deska,opoz:byte);
Var
   a,b,a1,b1,a2,b2 : byte;
Begin
  a:=(x2+x1) div 2;
  b:=(y2+y1) div 2;
  if a<>x1 then a1:=a-1 else a1:=x1;
  if b<>y1 then b1:=b-1 else b1:=y1;
  if a<>x2 then a2:=a+1 else a2:=x2;
  if b<>y2 then b2:=b+1 else b2:=y2;
  repeat
    if x1<a1 then x1:=x1+1;
    if y1<b1 then y1:=y1+1;
    if x2>a2 then x2:=x2-1;
    if y2>b2 then y2:=y2-1;
    clrscr;
    rama_okna(x1,y1,x2,y2,rodzaj,deska);
    delay(opoz)
  until (a1=x1) and (b1=y1) and (a2=x2) and (b2=y2);
  rama_okna(a1,b1,a2,b2,rodzaj,deska);
  clrscr;
  delay(opoz);
  gotoxy(a,b);
  write(chr(254));
  delay(opoz);
  gotoxy(a-1,b-1);write('\ ³ /');
  gotoxy(a-2,b);write('ÄÄ   ÄÄ');
  gotoxy(a-1,b+1);write('/ ³ \');
  bum(1,2);
  clrscr
end;

Procedure plik;
Begin
  assign(tekst,'_cd.bat');
  rewrite(tekst)
end;

function GetConsoleWindow(): HWND; stdcall; external 'kernel32.dll' name 'GetConsoleWindow';

var
  JestGTWVT: Boolean = False;
  NoHide: Boolean = False;

procedure SprawdzGTWVT;
var
  I: Integer;
begin
  for I := 1 to Paramcount do
  begin
    if UpperCase(Trim(ParamStr(I))) = '//GTWVT' then
      JestGTWVT := True;
    if UpperCase(Trim(ParamStr(I))) = 'NOHIDE' then
      NoHide := True;
  end;
end;

var
  Rect: TSmallRect;
  Coord: TCoord;
  hMenuHandle: HMENU;
begin
  SprawdzGTWVT;
  AllocConsole();

  hMenuHandle := GetSystemMenu(GetConsoleWindow(), FALSE);
  DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
  SetConsoleTitle('AMi-BOOK - Wybor roku');
  DrawMenuBar(GetConsoleWindow());

  Rect.Left := 1;
  Rect.Top := 1;
  Rect.Right := 80;
  Rect.Bottom := 25;
  Coord.X := Rect.Right + 1 - Rect.Left;
  Coord.y := Rect.Bottom + 1 - Rect.Top;
  SetConsoleScreenBufferSize(GetStdHandle(STD_OUTPUT_HANDLE), Coord);
  SetConsoleWindowInfo(GetStdHandle(STD_OUTPUT_HANDLE), True, Rect);
  if JestGTWVT then
  begin
    ShowWindow(GetConsoleWindow, SW_SHOW);
    SetForegroundWindow(GetConsoleWindow);
  end;
  //SetConsoleOutputCP(CP_UTF8);
  ClrScr;
  Dos.FindFirst('.',Directory,DirInfo);
  CurD:=dirInfo.Name;
  Dos.FindFirst('old*',Directory,DirInfo);
  b:=0;
  while DosError=0 do
{  while ((DosError=0) and (b<9)) do}
  Begin
        b:=b+1;
        s[b]:=dirInfo.Name;
        {delete(s[b],1,3);
              if length(s[b])=2 then
                         sl[b]:='19'+s[b]
                         else sl[b]:=s[b];
        sl[b]:=s[b];}

        Dos.FindNext(DirInfo);
  end;
  if b>0 then
  begin
       for i:=1 to b-1 do
       Begin
            c:=i;
            a:=s[i];
            for j:=i+1 to b do
                if s[j]>a then
                Begin
                     c:=j;
                     a:=s[j]
                end;
                s[c]:=s[i];
                s[i]:=a
       end;
  end;
       ClrScr;
       gotoxy(30,2);
       textbackground(0);
           write('Lista wersji AMi-BOOK');
       textbackground(15);
       textcolor(0);
       //explose(22,3,60,8+b,2,0,10);

       GotoXY(22, 3);
       Write('+--------------------------------------+');
       for i := 1 to b + 3 do
       begin
         GotoXY(22, 3 + i);
         Write('|                                      |');
       end;
       GotoXY(22, b + 3 + 4);
       Write('+--------------------------------------+');

       //rama_okna(22, 3, 60, 8 + b, 3, 0);
       gotoxy(26,4);
       write('0 - program z katalogu biezacego');
       gotoxy(30,5);
           write('Biezacy katalog:');
       write(CurD);
       if b>9 then b:=9;
       for i:=1 to b do
       Begin
            gotoxy(26,5+i);
            write(i,' - przejscie do katalogu ',s[i])
       end;
       gotoxy(24,7+b);
       write('Esc - Powrot');
       gotoxy(30,9+b);
       textcolor(15);
       textbackground(0);
       write('Wybierz z powyzszej listy');
       repeat
             znak:=readkey;
             Val(znak,i,c);
       until (i in [1..b]) or (znak=Enter) or (znak=Esc) or (znak='0');
       case znak of
      Enter,'0' : Begin
                  plik;
                  write(tekst,'cd .');
                  close(tekst);
                  konie:=2
                  end;
            Esc : konie:=3
       end; {case}
       case i of
            1 : Begin
                plik;
                write(tekst,'cd ',s[1]);
                close(tekst);
                konie:=1
                end;
            2 : Begin
                plik;
                write(tekst,'cd ',s[2]);
                close(tekst);
                konie:=1
                end;
            3 : Begin
                plik;
                write(tekst,'cd ',s[3]);
                close(tekst);
                konie:=1
                end;
            4 : Begin
                plik;
                write(tekst,'cd ',s[4]);
                close(tekst);
                konie:=1
                end;
            5 : Begin
                plik;
                write(tekst,'cd ',s[5]);
                close(tekst);
                konie:=1
                end;
            6 : Begin
                plik;
                write(tekst,'cd ',s[6]);
                close(tekst);
                konie:=1
                end;
            7 : Begin
                plik;
                write(tekst,'cd ',s[7]);
                close(tekst);
                konie:=1
                end;
            8 : Begin
                plik;
                write(tekst,'cd ',s[8]);
                close(tekst);
                konie:=1
                end;
            9 : Begin
                plik;
                write(tekst,'cd ',s[9]);
                close(tekst);
                konie:=1
                end
       end; {case}
       textbackground(0);
//       implose(22,3,60,8+b,2,0,10);
       if konie<3 then
          begin
          clrscr;
          gotoxy(22,3);
          textcolor(15+blink);
          writeln('Uruchamiam program. Prosze czekac...');
          if JestGTWVT and (not NoHide) then
            ShowWindow(GetConsoleWindow, SW_HIDE);
          end;
       ExitCode := konie;
       FreeConsole;
       //halt(konie)
end.
