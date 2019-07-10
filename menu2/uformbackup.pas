unit uFormBackup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, ExtCtrls, Buttons;

type

  { TFormBackup }

  TFormBackup = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBoxHaslo: TCheckBox;
    DirectoryEditFolder: TDirectoryEdit;
    EditHaslo: TEdit;
    GroupBoxFolder: TGroupBox;
    Label1: TLabel;
    Opcje: TGroupBox;
    RadioGroupRodzaj: TRadioGroup;
    procedure CheckBoxHasloChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormBackup: TFormBackup;

implementation

{$R *.lfm}

uses
  IniFiles;

{ TFormBackup }

procedure TFormBackup.CheckBoxHasloChange(Sender: TObject);
begin
  if CheckBoxHaslo.Checked then
    EditHaslo.Enabled := True
  else
  begin
    EditHaslo.Enabled := False;
    EditHaslo.Text := '';
  end;
end;

end.

