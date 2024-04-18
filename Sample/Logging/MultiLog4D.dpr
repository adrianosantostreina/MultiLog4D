program MultiLog4D;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMain in 'FMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
