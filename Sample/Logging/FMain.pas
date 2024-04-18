unit FMain;

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
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  TMultiLog4D.Tag('MeuAplicativo2');
  TMultiLog4D.LogWrite('Primeiro Log', ltInformation);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TADRAndroidLog.LogWriteFatalError('Fatal Error');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  TADRAndroidLog.LogWriteError('Error');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  TADRAndroidLog.LogWriteWarning('Warning');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  TADRAndroidLog.LogWriteInformation('Information');
end;

end.
