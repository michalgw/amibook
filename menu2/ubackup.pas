unit uBackup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils;

type
  TNazwaArchiwum = record
    Wersja: String;
    WersjaNum: LongWord;
    Utworzono: TDateTime;
    PelnaKopia: Boolean;
    Haslo: Boolean;
  end;

function AmiBackup(AKatalogZrodlowy: String; APlikWynikowy: String;
  APelnyBackup: Boolean = false; AHaslo: String = '';
  AMetaFile: TStream = nil): Boolean;
function AmiRestore(APlikZrodlowy: String; AKatalogDocelowy: String;
  AHaslo: String = ''): Boolean;

procedure AmiBackup2(AKatalogZrodlowy: String);
procedure AmiRestore2(AKatalogDocelowy: String);

function RozlozNazweArchiwum(ANazwa: String; var ANazwaArchiwum: TNazwaArchiwum): Boolean;

implementation

uses
  sevenzip, uFormProgres, Forms, Dialogs, uFormBackup, uFormRestore, IniFiles,
  Controls, fileinfo, winpeimagereader, dateutils;


function RozlozNazweArchiwum(ANazwa: String; var ANazwaArchiwum: TNazwaArchiwum): Boolean;
var
  S: String;
  Y,M,D,H,N,Se: Word;
begin
  ANazwa := ExtractFileNameOnly(ANazwa);
  Result := False;
  if (Length(ANazwa) >= 26) and (LowerCase(Copy(ANazwa, 1, 2)) = 'ab') then
  begin
    ANazwaArchiwum.Wersja := Copy(ANazwa, 3, 6);
    if not TryStrToInt(ANazwaArchiwum.Wersja, Integer(ANazwaArchiwum.WersjaNum)) then
      Exit;
    S := Copy(ANazwaArchiwum.Wersja, 5, 2);
    if S = '00' then
      S := ''
    else
      S := Chr(Ord('a') + StrToInt(S) - 1);
    ANazwaArchiwum.Wersja := IntToStr(StrToInt(Copy(ANazwaArchiwum.Wersja, 1, 2))) + '.' + IntToStr(StrToInt(Copy(ANazwaArchiwum.Wersja, 3, 2))) + S;
    Y := StrToInt(Copy(ANazwa, 10, 4));
    M := StrToInt(Copy(ANazwa, 14, 2));
    D := StrToInt(Copy(ANazwa, 16, 2));
    H := StrToInt(Copy(ANazwa, 18, 2));
    N := StrToInt(Copy(ANazwa, 20, 2));
    Se := StrToInt(Copy(ANazwa, 22, 2));
    ANazwaArchiwum.Utworzono := EncodeDateTime(Y, M, D, H, N, Se, 0);
    ANazwaArchiwum.PelnaKopia := LowerCase(Copy(ANazwa, 25, 1)) = 'p';
    ANazwaArchiwum.Haslo := LowerCase(Copy(ANazwa, 26, 1)) = 'h';
    Result := True;
  end;
end;

function ProgressCallback(sender: Pointer; total: boolean; value: int64): HRESULT; stdcall;
begin
  if total then
    FormProgres.PrgBar.Max := value else
    FormProgres.PrgBar.Position := value;
  Application.ProcessMessages;
  Result := S_OK;
end;

function AmiBackup(AKatalogZrodlowy: String; APlikWynikowy: String;
  APelnyBackup: Boolean; AHaslo: String; AMetaFile: TStream): Boolean;
var
  Arch: I7zOutArchive;
begin
  try
    Arch := CreateOutArchive(CLSID_CFormat7z);
    if Assigned(AMetaFile) and (AMetaFile.Size > 0) then
      Arch.AddStream(AMetaFile, soReference, faArchive, CurrentFileTime, CurrentFileTime, 'backup.meta', False, False);
    if APelnyBackup then
    begin
      Arch.AddFiles(AKatalogZrodlowy, '', '*.*', False);
      Arch.AddFiles(IncludeTrailingPathDelimiter(AKatalogZrodlowy) + 'XML', 'XML', '*.*', False);
    end
    else
    begin
      Arch.AddFiles(AKatalogZrodlowy, '', '*.dbf;*.txt;*.mem;*.fpt', False);
      Arch.AddFiles(IncludeTrailingPathDelimiter(AKatalogZrodlowy) + 'XML', 'XML', '*.*', False);
    end;
    if Length(AHaslo) > 0 then
      Arch.SetPassword(AHaslo);
    FormProgres := TFormProgres.Create(nil);
    FormProgres.Show;
    Application.ProcessMessages;
    Arch.SetProgressCallback(FormProgres, @ProgressCallback);
    Arch.SaveToFile(APlikWynikowy);
    FormProgres.Close;
  except
    on E: Exception do
      MessageDlg('Archiwizacja',
        'Wystąpił błąd podczas archiwizacji:' + LineEnding + E.Message,
        mtError, [mbOK], 0);
  end;
  if Assigned(FormProgres) then
    FreeAndNil(FormProgres);
end;

function AmiRestore(APlikZrodlowy: String; AKatalogDocelowy: String;
  AHaslo: String = ''): Boolean;
var
  Arch: I7zInArchive;
begin
  try
    Arch := CreateInArchive(CLSID_CFormat7z);
    FormProgres := TFormProgres.Create(nil);
    FormProgres.Show;
    Arch.SetProgressCallback(FormProgres, @ProgressCallback);
    Arch.OpenFile(APlikZrodlowy);
    Arch.ExtractTo(AKatalogDocelowy);
    FormProgres.Close;
    FreeAndNil(FormProgres);
  except
    on E: Exception do
      MessageDlg('Przywracanie danych',
        'Wystąpił błąd podczas archiwizacji:' + LineEnding + E.Message,
        mtError, [mbOK], 0);
  end;

end;

function WersjaKsiegi(APlik: String): String;
var
  FI: TFileVersionInfo;
  VQ: TVersionQuad;
begin
  Result := '000000';
  if FileExistsUTF8(APlik) then
  begin
    FI := TFileVersionInfo.Create(nil);
    try
      FI.FileName := APlik;
      FI.ReadFileInfo;
      if TryStrToVersionQuad(FI.VersionStrings.Values['ProductVersion'], VQ) then
        Result := Format('%.2d%.2d%.2d',[VQ[1], VQ[2], VQ[3]]);
    finally
      FI.Free;
    end;
  end;
end;

procedure AmiBackup2(AKatalogZrodlowy: String);
var
  Arch: I7zOutArchive;
  Ini: TIniFile;
  FN: String;
  S: String;
  Meta: TStringList;
  MetaStream: TMemoryStream;
begin
  try
    Ini := TIniFile.Create(GetAppConfigFileUTF8(False, False, True));
    FormBackup := TFormBackup.Create(nil);
    FormBackup.DirectoryEditFolder.Directory := Ini.ReadString('Backup', 'Dir', '');
    FormBackup.CheckBoxHasloChange(nil);
    if FormBackup.ShowModal = mrOK then
    begin
      S := WersjaKsiegi(IncludeTrailingPathDelimiter(AKatalogZrodlowy) + 'prog.exe');
      Ini.WriteString('Backup', 'Dir', FormBackup.DirectoryEditFolder.Directory);
      FN := 'ab' + S + '_' + FormatDateTime('yyyymmddhhnnss', Now) + '_';
      if FormBackup.RadioGroupRodzaj.ItemIndex = 0 then
        FN := FN + 'd'
      else
        FN := FN + 'p';
      if FormBackup.CheckBoxHaslo.Checked and (FormBackup.EditHaslo.Text <> '') then
        FN := FN + 'h'
      else
        FN := FN + 'x';
      Meta := TStringList.Create;
      Meta.Values['Dir'] := AKatalogZrodlowy;
      Meta.Values['Wersja'] := S;
      if FormBackup.RadioGroupRodzaj.ItemIndex = 0 then
        Meta.Values['Tryb'] := 'dane'
      else
        Meta.Values['Tryb'] := 'pelny';
      Meta.Values['Data'] := DateTimeToStr(Now);
      MetaStream := TMemoryStream.Create;
      Meta.SaveToStream(MetaStream);
      MetaStream.Position := 0;
      Arch := CreateOutArchive(CLSID_CFormat7z);
      Arch.AddStream(MetaStream, soReference, faArchive, CurrentFileTime, CurrentFileTime, 'backup.meta', False, False);
      if FormBackup.RadioGroupRodzaj.ItemIndex = 1 then
      begin
        Arch.AddFiles(AKatalogZrodlowy, '', '*.*', False);
        Arch.AddFiles(IncludeTrailingPathDelimiter(AKatalogZrodlowy) + 'XML', 'XML', '*.*', False);
      end
      else
      begin
        Arch.AddFiles(AKatalogZrodlowy, '', '*.dbf;*.txt;*.mem;*.fpt', False);
        Arch.AddFiles(IncludeTrailingPathDelimiter(AKatalogZrodlowy) + 'XML', 'XML', '*.*', False);
      end;
      if FormBackup.CheckBoxHaslo.Checked and (Length(FormBackup.EditHaslo.Text) > 0) then
        Arch.SetPassword(FormBackup.EditHaslo.Text);
      FormProgres := TFormProgres.Create(nil);
      FormProgres.Show;
      Application.ProcessMessages;
      Arch.SetProgressCallback(FormProgres, @ProgressCallback);
      Arch.SaveToFile(IncludeTrailingPathDelimiter(FormBackup.DirectoryEditFolder.Directory) + FN);
      FormProgres.Close;

      MetaStream.Free;
      Meta.Free;
    end;
    Ini.Free;
    FreeAndNil(FormBackup);

  except
    on E: Exception do
      MessageDlg('Archiwizacja',
        'Wystąpił błąd podczas archiwizacji:' + LineEnding + E.Message,
        mtError, [mbOK], 0);
  end;
  if Assigned(FormProgres) then
    FreeAndNil(FormProgres);
end;

procedure AmiRestore2(AKatalogDocelowy: String);
var
  Arch: I7zInArchive;
  MS: TMemoryStream;
  I: Integer;
  Jest: Boolean;
  Meta: TStringList;
begin
  FormRestore := TFormRestore.Create(nil);
  if FormRestore.ShowModal = mrOK then
  begin
    Arch := CreateInArchive(CLSID_CFormat7z);
    Arch.OpenFile(FormRestore.NazwaPliku);
    Jest := False;
    for I := 0 to Arch.GetNumberOfItems - 1 do
      if Arch.ItemName[I] = 'backup.meta' then
      begin
        Jest := True;
        Break;
      end;
    if Jest then
    begin
      MS := TMemoryStream.Create;
      Arch.ExtractItem(I, MS, False);
      Meta := TStringList.Create;
      MS.Position := 0;
      Meta.LoadFromStream(MS);
      if LowerCase(IncludeTrailingPathDelimiter(Meta.Values['Dir'])) <>
        LowerCase(IncludeTrailingPathDelimiter(AKatalogDocelowy)) then
        if MessageDlg('Odtwarzanie danych', 'UWAGA!!!' + LineEnding +
          'Dane w archiwum pochodzą z innej lokalizacji programu.' + LineEnding +
          'Katalog archiwum: ' + Meta.Values['Dir'] + LineEnding +
          'Katalog docelowy: ' + AKatalogDocelowy + LineEnding + LineEnding +
          'Czy kontynuować przywracanie danych?', mtWarning, mbYesNo, 0) <> mrYes then
          Jest := False
        else
          Jest := True;
      MS.Free;
      Meta.Free;
    end
    else
      Jest := True;
    if Jest then
    begin
      FormProgres := TFormProgres.Create(nil);
      FormProgres.Show;
      Arch.SetProgressCallback(FormProgres, @ProgressCallback);
      Arch.ExtractTo(AKatalogDocelowy);
      FormProgres.Close;
      FreeAndNil(FormProgres);
    end;
  end;
  FormRestore.Free;
end;

end.

