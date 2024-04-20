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
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
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
     .LogWriteInformation('Information')
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  try
    TMultiLog4DUtil
      .Logger
        .LogWriteWarning('Usuário clicou no botão LOGIN');

    //Ação do login

    TMultiLog4DUtil
      .Logger
        .LogWriteInformation('Login efetuado com sucesso!');
  except on E:Exception do
    begin
      TMultiLog4DUtil
        .Logger
          .LogWriteError('Ocorreram erros durante o login')
          .LogWriteFatalError(E.ClassName + ' | ' + E.Message);
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
     .LogWriteError('Error')
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
     .LogWriteFatalError('Faltal Error')
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
     .LogWriteWarning('Warning')
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  try
    TMultiLog4DUtil
      .Logger
        .LogWriteWarning('Converte um número');

    StrToInt('MultiLog4D');
  except on E:Exception do
    begin
      TMultiLog4DUtil
        .Logger
          .LogWriteError('Ocorreram erros:')
          .LogWriteFatalError(E.ClassName + ' | ' + E.Message);
    end;
  end;
end;

end.
