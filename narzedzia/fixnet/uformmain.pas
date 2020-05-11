unit uFormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons;

type

  { TFormMain }

  TFormMain = class(TForm)
    BitBtnFix: TBitBtn;
    BitBtnKoniec: TBitBtn;
    ImageNie: TImage;
    ImageOk: TImage;
    LabelTresc: TLabel;
    procedure BitBtnFixClick(Sender: TObject);
    procedure BitBtnKoniecClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    function Sprawdz(Utworz: Boolean): Boolean;
  end;

var
  FormMain: TFormMain;

const
  KLUCZ_SVR = 'System\CurrentControlSet\Services\LanmanServer\Parameters';
  KLUCZ_WKS = 'System\CurrentControlSet\Services\LanmanWorkStation\Parameters';

implementation

{$R *.lfm}

uses
  Registry;

{ TFormMain }

procedure TFormMain.FormShow(Sender: TObject);
begin
  if Sprawdz(False) then
  begin
    ImageOk.Visible := True;
    ImageNie.Visible := False;
    LabelTresc.Caption := 'Konfiguracja jest poprawna.';
    BitBtnFix.Visible := False;
  end
  else
  begin
    ImageOk.Visible := False;
    ImageNie.Visible := True;
    LabelTresc.Caption := 'Konfiguracja sieci nie jest poprawna.' + LineEnding +
      'Kliknij przycisk "Popraw konfiguracje".';
    BitBtnFix.Visible := True;
  end;
end;

procedure TFormMain.BitBtnKoniecClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.BitBtnFixClick(Sender: TObject);
begin
  if Sprawdz(True) then
  begin
    ImageOk.Visible := True;
    ImageNie.Visible := False;
    LabelTresc.Caption := 'Konfiguracja została poprawiona.' + LineEnding +
      'Zmiany zostaną aktywowane po restarcie systemu.';
    BitBtnFix.Visible := False;
  end
  else
  begin
    MessageDlg('Nie udało się poprawić konfiguracji!', mtError, [mbOK], 0);
    ImageOk.Visible := False;
    ImageNie.Visible := True;
    LabelTresc.Caption := 'Konfiguracja sieci nie jest poprawna.' + LineEnding +
      'Kliknij przycisk "Popraw konfiguracje".';
    BitBtnFix.Visible := True;
  end;
end;

function TFormMain.Sprawdz(Utworz: Boolean): Boolean;
var
  R: TRegistry;
  Ac: LongWord;

function SprawdzWartosc(ANazwa: String; AWartosc: Integer): Boolean;
begin
  Result := R.ValueExists(ANazwa) and (R.ReadInteger(ANazwa) = AWartosc);
  if (not Result) and Utworz then
  begin
    R.WriteInteger(ANazwa, AWartosc);
    Result := R.ValueExists(ANazwa) and (R.ReadInteger(ANazwa) = AWartosc);
  end;
end;

begin
  Result := False;
  if Utworz then
    Ac := KEY_ALL_ACCESS
  else
    Ac := KEY_READ;
  R := TRegistry.Create(Ac);
  try
    try
      R.RootKey := HKEY_LOCAL_MACHINE;
      Result := R.OpenKey(KLUCZ_SVR, False);
      if Result then
      begin
        Result := SprawdzWartosc('CachedOpenLimit', 0);
        Result := Result and SprawdzWartosc('EnableOpLocks', 0);
        Result := Result and SprawdzWartosc('EnableOpLockForceClose', 1);
        Result := Result and SprawdzWartosc('SharingViolationDelay', 0);
        Result := Result and SprawdzWartosc('SharingViolationRetries', 0);
        if Win32MajorVersion >= 6 then
          Result := Result or SprawdzWartosc('SMB2', 0);
        R.CloseKey;
      end;
      if Result then
      begin
        Result := R.OpenKey(KLUCZ_WKS, False);
        if Result then
        begin
          Result := Result and SprawdzWartosc('UseOpportunisticLocking', 0);
          Result := Result and SprawdzWartosc('EnableOpLocks', 0);
          Result := Result and SprawdzWartosc('EnableOpLockForceClose', 1);
          Result := Result and SprawdzWartosc('UtilizeNtCaching', 0);
          Result := Result and SprawdzWartosc('UseLockReadUnlock', 0);
          if Win32MajorVersion >= 6 then
          begin
            Result := Result and SprawdzWartosc('FileInfoCacheLifetime', 0);
            Result := Result and SprawdzWartosc('FileNotFoundCacheLifetime', 0);
            Result := Result and SprawdzWartosc('DirectoryCacheLifetime', 0);
          end;
          R.CloseKey;
          if Result and (Win32MajorVersion >= 5) then
          begin
            Result := R.OpenKey('System\CurrentControlSet\Services\MRXSmb\Parameters', Utworz);
            if Result then
              Result := Result and SprawdzWartosc('OpLocksDisabled', 1);
            R.CloseKey;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        MessageDlg('Błąd', 'Wystąpił problem podczas sprawdzania konfiguracji.' + LineEnding +
          'Klasa wyjątku: ' + E.ClassName + LineEnding + 'Komunikat: ' + E.Message,
          mtError, [mbOK], 0);
        Result := False;
      end;
    end;
  finally
    R.Free;
  end;
end;

end.

