program GUI_Linux_MultiLog4D;

uses
  MultiLog4D.Util,
  MultiLog4D.Types,
  System.StartUpCopy,
  FMX.Forms,
  Unit4 in 'Unit4.pas' {Form4};

{$R *.res}

begin
  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    .LogWriteInformation('Start');

  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
