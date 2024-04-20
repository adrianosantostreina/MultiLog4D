unit UMain;

interface

uses
  MultiLog4D,
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
  FMX.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button5: TButton;
    Button4: TButton;
    Button3: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}


procedure TForm2.Button1Click(Sender: TObject);
begin
  TMultiLog4D.Tag('MeuAplicativo');
  TMultiLog4D.LogWrite('Primeiro Log', ltInformation);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  TMultiLog4D.LogWriteFatalError('Fatal Error');
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  TMultiLog4D.LogWriteError('Error');
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  TMultiLog4D.LogWriteWarning('Warning');
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  TMultiLog4D.LogWriteInformation('Information');
end;

end.
