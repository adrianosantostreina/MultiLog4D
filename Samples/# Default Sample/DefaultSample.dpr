program DefaultSample;

uses
  System.StartUpCopy,
  System.IOUtils,
  System.StrUtils,
  System.SysUtils,
  MultiLog4D.Types,
  MultiLog4D.Util,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  TMultiLog4DUtil
   .Logger
   .Tag('MultiLog4D')
   {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
     .Output(loBoth)
     .FileName(TPath.Combine(ExtractFilePath(ParamStr(0)), 'log\MeuLog.log'))
   {$ENDIF}
   .LogWrite('Inicializando o sistema...', ltInformation);

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
