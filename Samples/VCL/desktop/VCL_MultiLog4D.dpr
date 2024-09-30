program VCL_MultiLog4D;

uses
  Vcl.Forms,
  MultiLog4D.Util,
  MultiLog4D.Types,
  System.SysUtils,
  System.StrUtils,
  System.IOUtils,
  Unit1 in 'Unit1.pas' {Form3};

{$R *.res}

var
  LOutputLogPath : string;
begin
  LOutputLogPath := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Log');
  ForceDirectories(LOutputLogPath);

  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    .Output([loConsole, loFile, loEventViewer])
    .FileName(TPath.Combine(LOutputLogPath, 'Log.txt'))
    .UserName('adrianosantos')
    .EventID(1)
    .EnableLog(True)
    .LogWriteInformation('>>>>>>>>>> Starting <<<<<<<<<<');

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
