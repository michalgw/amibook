program ksiega;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uFormMain, uWpisy, uBackup, uFormProgres, uFormBackup
  { you can add units after this };

{$R *.res}

begin
  Application.Title := 'AMi-BOOK - Wybór roku';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

