program Service_MultiLog4D;

uses
  MultiLog4D.Util,
  MultiLog4D.Types,
  System.IOUtils,
  System.SysUtils,
  System.StrUtils,
  Vcl.SvcMgr,
  Main in 'Main.pas' {MultiLog4D: TService};

{$R *.RES}

var
  LOutputLogPath : string;
begin
  LOutputLogPath := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Log');
  ForceDirectories(LOutputLogPath);

  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    .Output([loEventViewer]) //File and EventViewer
    .FileName(TPath.Combine(LOutputLogPath, 'Log.txt'));

  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TService2, Service2);
  Application.Run;
end.
