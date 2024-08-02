program DefaultSample;

uses
  System.StartUpCopy,
  MultiLog4D.Types,
  MultiLog4D.Util,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  TMultiLog4DUtil
   .Logger
     .Tag('MultiLog4D')
     .LogWrite('Inicializando o sistema...', ltInformation);

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
