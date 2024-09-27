program macOS_MultiLog4D;

uses
  MultiLog4D.Util,
  MultiLog4D.Types,
  System.StartUpCopy,
  FMX.Forms,
  Unit5 in 'Unit5.pas' {Form5};

{$R *.res}

begin
  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    .LogWriteInformation('Start Sistema');

  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
