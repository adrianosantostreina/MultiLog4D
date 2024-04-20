unit Unit1;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,

  MultiLog4D.Types,
  MultiLog4D.Util;
type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.Button1Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
     .LogWriteWarning('Warning')
     .LogWriteInformation('Information')
     .LogWriteError('Error')
     .LogWriteFatalError('Fatal Error');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  try
    TMultiLog4DUtil
      .Logger
        .LogWriteInformation('Usuário clicou no botão LOGIN');

    //Ação do login

    TMultiLog4DUtil
      .Logger
        .LogWriteInformation('Login efetuado com sucesso!');
  except on E:Exception do
    begin
      TMultiLog4DUtil
        .Logger
          .LogWriteInformation('Ocorreram erros durante o login')
          .LogWriteInformation(E.ClassName + ' | ' + E.Message);
    end;
  end;
end;

end.
