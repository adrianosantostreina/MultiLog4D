program ProjS;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MultiLog4D in '..\..\src\MultiLog4D.pas',
  MultiLog4D.Interfaces in '..\..\src\MultiLog4D.Interfaces.pas',
  MultiLog4D.Types in '..\..\src\MultiLog4D.Types.pas',
  MultiLog4D.Base in '..\..\src\MultiLog4D.Base.pas',
  MultiLog4D.Android in '..\..\src\MultiLog4D.Android.pas',
  MultiLog4D.Java.Interfaces in '..\..\src\MultiLog4D.Java.Interfaces.pas',
  MultiLog4D.Factory in '..\..\src\MultiLog4D.Factory.pas',
  MultiLog4D.Util in '..\..\src\MultiLog4D.Util.pas';

{$R *.res}

begin
  TMultiLog4DUtil.Logger.Tag('MultiLog4D');
  TMultiLog4DUtil.Logger.LogWrite('Inicializando  o sistema...', ltInformation);

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
