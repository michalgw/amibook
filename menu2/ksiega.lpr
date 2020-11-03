program ksiega;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Windows,
  Forms, uFormMain, uWpisy, uBackup, uFormProgres, uFormBackup
  { you can add units after this };

{$R *.res}

begin
  CreateMutex(nil, False, 'GMSystemsAmiBookMenuNew');
  Application.Title := 'AMi-BOOK - Wybór roku';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

