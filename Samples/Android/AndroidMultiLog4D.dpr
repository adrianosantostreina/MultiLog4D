program AndroidMultiLog4D;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMain in 'UMain.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
