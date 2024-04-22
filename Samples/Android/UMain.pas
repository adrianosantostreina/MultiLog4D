unit UMain;

interface

uses
  MultiLog4D.Types,
  MultiLog4D.Util,
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
  TMultiLog4DUtil
    .Logger
      .Tag('MyApp')
      .LogWrite('First Log', ltInformation);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  TMultiLog4DUtil
    .Logger
      .LogWriteFatalError('Fatal Error');
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  TMultiLog4DUtil
    .Logger
      .LogWriteError('Error');
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  TMultiLog4DUtil
    .Logger
      .LogWriteWarning('Warning');
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  TMultiLog4DUtil
    .Logger
      .LogWriteInformation('Information');
end;

end.
