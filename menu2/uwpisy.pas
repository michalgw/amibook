unit uWpisy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, fgl, LazFileUtils, Forms, process, Dialogs;

type
  TWpisMenu = class;

  { TProgThread }

  TProgThread = class(TThread)
  protected
    procedure Execute; override;
  public
    Wpis: TWpisMenu;
    Okno: TForm;
    Zakoncz: Boolean;
    procedure OdblokujBtn;
  end;

  TTryb = (tTekstowy, tGraficzny);
  TEkran = (eDomyslny, eMaksymalizuj, ePelnyEkran);

  TWpisMenu = class
    Button: TButton;
    Katalog: String;
    Uruchomiony: Boolean;
    Tryb: TTryb;
    Ekran: TEkran;
    NowyStart: Boolean;
  end;

  { TWpisyMenu }

  TWpisyMenu = class(specialize TFPGObjectList<TWpisMenu>)
    InstallWpis: String;
    constructor Create(AFreeObjects: Boolean = True);
    procedure WczytajKonfig;
    procedure ZapiszKonfig;
    function CzyUruchomiony: Boolean;
    procedure WczytajWpisy(AKatalog: String = '');
    function Znajdz(AKatalog: String): TWpisMenu;
  end;

implementation

uses
  IniFiles, ShellApi, uFormMain;

{ TWpisyMenu }

constructor TWpisyMenu.Create(AFreeObjects: Boolean);
begin
  Inherited;
  InstallWpis := '(brak)';
end;

procedure TWpisyMenu.WczytajKonfig;
var
  I: Integer;
  Ini: TIniFile;
  S: String;
begin
  Ini := TIniFile.Create(GetAppConfigFileUTF8(False, False, True));
  for I := 0 to Count - 1 do
  begin
    S := Items[I].Katalog;
    if S = '' then
      S := 'Glowny';
    Items[I].Tryb := TTryb(Ini.ReadInteger(S, 'Tryb', 0));
    Items[I].Ekran := TEkran(Ini.ReadInteger(S, 'Ekran', 0));
  end;
  InstallWpis := Ini.ReadString('Install', 'Install', '(brak)');
  Ini.Free;
end;

procedure TWpisyMenu.ZapiszKonfig;
var
  I: Integer;
  Ini: TIniFile;
  S: String;
begin
  Ini := TIniFile.Create(GetAppConfigFileUTF8(False, False, True));
  for I := 0 to Count - 1 do
  begin
    S := Items[I].Katalog;
    if S = '' then
      S := 'Glowny';
    Ini.WriteInteger(S, 'Tryb', Ord(Items[I].Tryb));
    Ini.WriteInteger(S, 'Ekran', Ord(Items[I].Ekran));
  end;
  Ini.WriteString('Install', 'Install', InstallWpis);
  Ini.Free;
end;

function TWpisyMenu.CzyUruchomiony: Boolean;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Items[I].Uruchomiony then
      Exit(True);
  Result := False;
end;

function WpisCompare(const I1, I2: TWpisMenu): Integer;
var
  S1, S2: String;
begin
  S1 := I1.Katalog.ToUpper;
  S2 := I2.Katalog.ToUpper;
  if S1.StartsWith('OLD9') then
    S1.Insert(3, '19');
  if S2.StartsWith('OLD9') then
    S2.Insert(3, '19');
  Result := CompareFilenamesIgnoreCase(S2, S1);
end;

procedure TWpisyMenu.WczytajWpisy(AKatalog: String);

var
  SR: TSearchRec;

procedure DodajSR; inline;
var
  W: TWpisMenu;
begin
  W := TWpisMenu.Create;
  W.Katalog := SR.Name;
  W.NowyStart := FileExistsUTF8(SR.Name + '\menu2.exe');
  Add(W);
end;

begin
  if AKatalog <> '' then
    AKatalog := IncludeTrailingPathDelimiter(AKatalog);
  if FindFirstUTF8(AKatalog + 'OLD*', faDirectory, SR) = 0 then
  begin
    DodajSR;
    while FindNextUTF8(SR) = 0 do
      DodajSR;
  end;
  Sort(@WpisCompare);
end;

function TWpisyMenu.Znajdz(AKatalog: String): TWpisMenu;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Katalog = AKatalog then
      Exit(Items[I]);
end;

{ TProgThread }

procedure TProgThread.Execute;

type
  TStrArray = array of String;

function Uruchom(AKatalog, AProgram: String; AParametry: TStrArray; AKonsola: Boolean): Integer;
var
  P: TProcess;
  S: String;
begin
  P := TProcess.Create(nil);
  P.CurrentDirectory := AKatalog;
  P.Executable := AProgram;
  P.Parameters.AddStrings(AParametry);
  if AKonsola then
    P.Options := [poWaitOnExit, poNewConsole]
  else
    P.Options := [poWaitOnExit, poNoConsole];
  P.Execute;
  while P.Running do ;
  Result := P.ExitCode;
  P.Free;
end;

procedure AddArr(AStr: String; var AArr: TStrArray); inline;
begin
  SetLength(AArr, Length(AArr) + 1);
  AArr[Length(AArr) - 1] := AStr;
end;

var
  SA: TStrArray;
  Koniec: Boolean;
  S: String;
begin
  Zakoncz := False;
  try
    Koniec := False;
    Wpis.Uruchomiony := True;
    repeat
      SetLength(SA, 0);
      if (Wpis.Katalog = '') or Wpis.NowyStart then
      begin
        S := Wpis.Katalog;
        if S <> '' then
          S := S + '\';
        FileClose(FileCreateUTF8(S + 'start'));
        if Wpis.Tryb = tGraficzny then
          AddArr('//gtwvt', SA);
        if Wpis.Ekran = ePelnyEkran then
          AddArr('//pelnyekran', SA);
        case Uruchom(Wpis.Katalog, 'prog.exe', SA, False) of
          0: Koniec := True;
          200: ;// Backup
          201: ;// Restore
          203: ;// Upgrade
        else
          Koniec := True;
        end;

        if FileExistsUTF8(S + 'arch.mem') then
        begin
          SetLength(SA, 0);
          AddArr('a', SA);
          AddArr('kopia.arc', SA);
          AddArr('*.dbf', SA);
          AddArr('*.mem', SA);
          AddArr('*.fpt', SA);
          AddArr('polznak.*', SA);
          AddArr('XML\*.*', SA);
          Uruchom(S, '7z.exe', SA, True);
          Koniec := False;
        end else
        if FileExistsUTF8(S + 'odtw.mem') then
        begin
          SetLength(SA, 0);
          AddArr('x', SA);
          AddArr('-aoa', SA);
          AddArr('kopia.arc', SA);
          Uruchom(S, '7z.exe', SA, True);
          Koniec := False;
        end else
        if FileExistsUTF8(S + 'zadanie1.mem') then
        begin
          SetLength(SA, 0);
          Uruchom(S, 'ZADANIE1.BAT', SA, True);
          Koniec := False;
        end else
        if FileExistsUTF8(S + 'zadanie2.mem') then
        begin
          SetLength(SA, 0);
          Uruchom(S, 'ZADANIE2.BAT', SA, True);
          Koniec := False;
        end else
        if FileExistsUTF8(S + 'instart.bat') then
        begin
          ShellExecute(0, nil, PChar(S + 'instart.bat'), nil, PChar(S), 1);
          Koniec := True;
          Zakoncz := True;
        end;
      end
      else
      begin
        if Wpis.Tryb = tGraficzny then
          AddArr('//gtwvt', SA);
        Uruchom(Wpis.Katalog, 'ksiega.bat', SA, True);
        Koniec := True;
      end;
    until Koniec;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
  Synchronize(@OdblokujBtn);
end;

procedure TProgThread.OdblokujBtn;
begin
  Wpis.Uruchomiony := False;
  Wpis.Button.Enabled := True;
  Okno.Show;
  Wpis.Button.SetFocus;
  Okno.BringToFront;
  if Zakoncz then
  begin
    FormMain.Wpisy.InstallWpis := Wpis.Katalog;
    Application.QueueAsyncCall(@FormMain.AsyncZamknij, 0);
  end;
end;

end.

