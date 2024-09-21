program Android_MultiLog4D;

uses
  MultiLog4D.Types,
  MultiLog4D.Util,
  System.StartUpCopy,
  FMX.Forms,
  UMain in 'UMain.pas' {Form2};

{$R *.res}

begin
  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    .LogWriteInformation('>>>>>>>>>> Starting app <<<<<<<<<<');

  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
