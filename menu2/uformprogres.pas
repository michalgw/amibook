unit uFormProgres;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls;

type

  { TFormProgres }

  TFormProgres = class(TForm)
    Bevel1: TBevel;
    LabelOpis: TLabel;
    PrgBar: TProgressBar;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormProgres: TFormProgres = nil;

implementation

{$R *.lfm}

end.

