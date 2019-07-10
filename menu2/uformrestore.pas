unit uFormRestore;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, ComCtrls, Buttons;

type

  { TFormRestore }

  TFormRestore = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DirectoryEditFolder: TDirectoryEdit;
    GroupBoxFolder: TGroupBox;
    GroupBoxLista: TGroupBox;
    ListViewKopie: TListView;
    procedure DirectoryEditFolderChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListViewKopieSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { private declarations }
  public
    { public declarations }
    procedure WczytajFolder(AFolder: String);
    function NazwaPliku: String;
  end;

var
  FormRestore: TFormRestore;

implementation

{$R *.lfm}

uses
  uBackup, IniFiles;

{ TFormRestore }

procedure TFormRestore.DirectoryEditFolderChange(Sender: TObject);
begin
  WczytajFolder(DirectoryEditFolder.Directory);
end;

procedure TFormRestore.FormShow(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(GetAppConfigFile(False, False));
  DirectoryEditFolder.Directory := Ini.ReadString('Backup', 'Dir', '');
  Ini.Free;
end;

procedure TFormRestore.ListViewKopieSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    BitBtn1.Enabled := (ListViewKopie.Items.Count > 0) and (ListViewKopie.Selected <> nil);
end;

procedure TFormRestore.WczytajFolder(AFolder: String);
const
  TakNie: array[Boolean] of String = ('Nie', 'Tak');
var
  SR: TSearchRec;
  LI: TListItem;
  NA: TNazwaArchiwum;
begin
  if not DirectoryExists(AFolder) then
    Exit;
  ListViewKopie.Clear;
  if FindFirst(IncludeTrailingPathDelimiter(AFolder) + '*.aba', faAnyFile, SR) = 0 then
    repeat
      if RozlozNazweArchiwum(SR.Name, NA) then
      begin
        LI := ListViewKopie.Items.Add;
        LI.Caption := DateTimeToStr(NA.Utworzono);
        LI.SubItems.Add(NA.Wersja);
        LI.SubItems.Add(TakNie[NA.PelnaKopia]);
        LI.SubItems.Add(TakNie[NA.Haslo]);
        LI.SubItems.Add(IncludeTrailingPathDelimiter(AFolder) + SR.Name);
      end;
    until FindNext(SR) <> 0;
  FindClose(SR);
  BitBtn1.Enabled := (ListViewKopie.Items.Count > 0) and (ListViewKopie.Selected <> nil);
end;

function TFormRestore.NazwaPliku: String;
begin
  if ListViewKopie.Selected <> nil then
    Result := ListViewKopie.Selected.SubItems[3]
  else
    Result := '';
end;

end.

