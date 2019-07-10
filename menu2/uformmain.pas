unit uFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazFileUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Menus, uWpisy;

type

  { TFormMain }

  TFormMain = class(TForm)
    Label1: TLabel;
    MenuItemPomZdal: TMenuItem;
    MenuItemRestore: TMenuItem;
    MenuItemBackup: TMenuItem;
    MenuItemS2: TMenuItem;
    MenuItemEkranOkno: TMenuItem;
    MenuItemEkranMax: TMenuItem;
    MenuItemEkranPelny: TMenuItem;
    MenuItemS1: TMenuItem;
    MenuItemTrybGraficzny: TMenuItem;
    MenuItemTrybTekstowy: TMenuItem;
    PanelTop: TPanel;
    PanelCenter: TPanel;
    PopupMenuTools: TPopupMenu;
    PopupMenuTray: TPopupMenu;
    PopupMenuButton: TPopupMenu;
    TrIcon: TTrayIcon;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure MenuButtonClick(Sender: TObject);
    procedure MenuItemPomZdalClick(Sender: TObject);
    procedure MenuItemRestoreClick(Sender: TObject);
    procedure MenuItemBackupClick(Sender: TObject);
    procedure MenuItemEkranClick(Sender: TObject);
    procedure MenuItemTrybClick(Sender: TObject);
    procedure PopupMenuButtonPopup(Sender: TObject);
    procedure TrIconDblClick(Sender: TObject);
  private

  public
    Wpisy: TWpisyMenu;
    procedure UtworzMenu;
    procedure AsyncZamknij(AData: PtrInt);
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

uses
  uBackup, uFormBackup, IniFiles, ShellApi;

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
var
  W: TWpisMenu;
begin
  Constraints.MinWidth := Screen.Width div 3;
  Wpisy := TWpisyMenu.Create(True);
  Wpisy.WczytajWpisy;
  W := TWpisMenu.Create;
  W.Katalog := '';
  W.NowyStart := True;
  Wpisy.Insert(0, W);
  Wpisy.WczytajKonfig;
  UtworzMenu;
end;

procedure TFormMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Wpisy.CzyUruchomiony then
    CloseAction := caHide
  else
    Wpisy.ZapiszKonfig;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin

end;

procedure TFormMain.FormKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #27 then
    Close;
end;

procedure TFormMain.FormShow(Sender: TObject);
var
  W: TWpisMenu;
begin
  if Wpisy.InstallWpis <> '(brak)' then
  begin
    W := Wpisy.Znajdz(Wpisy.InstallWpis);
    Wpisy.InstallWpis := '(brak)';
    if W <> nil then
      MenuButtonClick(W.Button);
  end;
end;

procedure TFormMain.MenuButtonClick(Sender: TObject);
var
  T: TProgThread;
begin
  TButton(Sender).Enabled := False;
  T := TProgThread.Create(True);
  T.FreeOnTerminate := True;
  T.Wpis := Wpisy[TButton(Sender).Tag];
  T.Okno := Self;
  T.Start;
  Hide;
end;

procedure TFormMain.MenuItemPomZdalClick(Sender: TObject);
var
  S: String;
begin
  S := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName)) + 'pomoczdalna.exe';
  if FileExistsUTF8(S) then
    ShellExecute(0, nil, PChar(S), nil, nil, 1)
  else
    ShellExecute(0, nil, 'https://gmsystems.pl/pliki/inne/pomoczdalna.exe', nil, nil, 1);
end;

procedure TFormMain.MenuItemRestoreClick(Sender: TObject);
begin
  AmiRestore('aaaa.7z', ExtractFileDir(Application.ExeName));
end;

procedure TFormMain.MenuItemBackupClick(Sender: TObject);
begin
  if PopupMenuButton.PopupComponent is TButton then
  begin
    Enabled := False;
    AmiBackup2(IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName)) + Wpisy[PopupMenuButton.PopupComponent.Tag].Katalog);
    Enabled := True;
  end
  else
    Exit;
end;

procedure TFormMain.MenuItemEkranClick(Sender: TObject);
begin
  if PopupMenuButton.PopupComponent is TButton then
  begin
    case TComponent(Sender).Tag of
      0: Wpisy[PopupMenuButton.PopupComponent.Tag].Ekran := eDomyslny;
      1: Wpisy[PopupMenuButton.PopupComponent.Tag].Ekran := eMaksymalizuj;
      2: Wpisy[PopupMenuButton.PopupComponent.Tag].Ekran := ePelnyEkran;
    end;
  end;
end;

procedure TFormMain.MenuItemTrybClick(Sender: TObject);
begin
  if PopupMenuButton.PopupComponent is TButton then
  begin
    if MenuItemTrybGraficzny.Checked then
      Wpisy[PopupMenuButton.PopupComponent.Tag].Tryb := tGraficzny
    else
      Wpisy[PopupMenuButton.PopupComponent.Tag].Tryb := tTekstowy;
  end;
end;

procedure TFormMain.PopupMenuButtonPopup(Sender: TObject);
begin
  if PopupMenuButton.PopupComponent is TButton then
  begin
    if Wpisy[PopupMenuButton.PopupComponent.Tag].Tryb = tGraficzny then
      MenuItemTrybGraficzny.Checked := True
    else
      MenuItemTrybTekstowy.Checked := True;
    case Wpisy[PopupMenuButton.PopupComponent.Tag].Ekran of
      eDomyslny: MenuItemEkranOkno.Checked := True;
      eMaksymalizuj: MenuItemEkranMax.Checked := True;
      ePelnyEkran: MenuItemEkranPelny.Checked := True;
    end;
  end;
end;

procedure TFormMain.TrIconDblClick(Sender: TObject);
begin
  if Visible and (WindowState = wsMinimized) then
    WindowState := wsNormal
  else
  begin
    Visible := not Visible;
    if Visible then
      BringToFront;
  end;
end;

procedure TFormMain.UtworzMenu;
var
  I: Integer;
  B: TButton;
begin
  for I := 0 to Wpisy.Count - 1 do
  begin
    B := TButton.Create(Self);
    B.Parent := PanelCenter;
    B.Height := 48;
    B.Top := I * 48;
    if Wpisy[I].Katalog = '' then
      B.Caption := '&0 - Bieżący rok'
    else
      B.Caption := '&' + IntToStr(I) + ' - Z katalogu ' + Wpisy[I].Katalog;
    B.BorderSpacing.Around := 6;
    B.Align := alTop;
    B.Tag := I;
    B.OnClick := @MenuButtonClick;
    B.OnKeyPress := @FormKeyPress;
    B.PopupMenu := PopupMenuButton;
    if I = 0 then
    begin
      B.Default := True;
      B.Font.Style := [fsBold];
    end;
    Wpisy[I].Button := B;
  end;
end;

procedure TFormMain.AsyncZamknij(AData: PtrInt);
begin
  Close;
end;

end.

