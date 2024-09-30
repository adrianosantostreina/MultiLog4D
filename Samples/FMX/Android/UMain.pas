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
  FMX.StdCtrls, FMX.Layouts;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button5: TButton;
    Button4: TButton;
    Button3: TButton;
    Button2: TButton;
    Label1: TLabel;
    radioInformation: TRadioButton;
    radioWarning: TRadioButton;
    radioError: TRadioButton;
    radioFatalError: TRadioButton;
    Layout1: TLayout;
    Label2: TLabel;
    Layout2: TLayout;
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
var
  LStrTypeMsg : string;
  LTypeMsg : TLogType; //Uses MultiLog4D.Types
begin
  if radioInformation.IsChecked then
  begin
    LTypeMsg := TLogType.ltInformation;
    LStrTypeMsg := 'Information';
  end
  else if radioWarning.IsChecked then
  begin
    LTypeMsg := TLogType.ltWarning;
    LStrTypeMsg := 'Warning';
  end
  else if radioError.IsChecked then
  begin
    LTypeMsg := TLogType.ltError;
    LStrTypeMsg := 'Error';
  end
  else
  begin
    LTypeMsg := TLogType.ltFatalError;
    LStrTypeMsg := 'Faltal Error';
  end;

  TMultiLog4DUtil
   .Logger
   .LogWrite(Format('LogWrite Type: %s', [LStrTypeMsg]), LTypeMsg);
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
