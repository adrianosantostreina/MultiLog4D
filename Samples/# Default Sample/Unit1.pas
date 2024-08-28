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
    Button8: TButton;
    radioInformation: TRadioButton;
    radioWarning: TRadioButton;
    radioError: TRadioButton;
    radioFatalError: TRadioButton;
    Button7: TButton;
    Button9: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
    FCont: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$IFDEF IOS}
uses
  iOSapi.Foundation,
  Macapi.Helpers;
{$ENDIF}

{$R *.fmx}


procedure TForm1.Button1Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
   .LogWriteInformation('LogWrite Information');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  try
    TMultiLog4DUtil
      .Logger
        .LogWriteWarning('User clicked on login button');

    TMultiLog4DUtil
      .Logger
        .LogWriteInformation('Login ok');
  except on E:Exception do
    begin
      TMultiLog4DUtil
        .Logger
          .LogWriteError('Errors detected')
          .LogWriteFatalError(E.ClassName + ' | ' + E.Message);
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
   .LogWriteError('LogWrite Error');
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
   .LogWriteWarning('LogWrite Warning');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  try
    TMultiLog4DUtil
      .Logger
        .LogWriteWarning('Convert error');

    StrToInt('MultiLog4D');
  except on E:Exception do
    begin
      TMultiLog4DUtil
        .Logger
          .LogWriteError('Errors detected:')
          .LogWriteFatalError(E.ClassName + ' | ' + E.Message);
    end;
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    {$IFDEF ML4D_SERVICE}
    .Category(TEventCategory.ecNone)
    .EventID(1)
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    //.UserName('Adriano Santos')
    //.UserName(EmptyStr)
    {$ENDIF}
    .LogWriteFatalError('Teste4');
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  LTypeMsg : TLogType;
begin
  Inc(FCont);

  if radioInformation.IsChecked then
    LTypeMsg := TLogType.ltInformation
  else if radioWarning.IsChecked then
    LTypeMsg := TLogType.ltWarning
  else if radioError.IsChecked then
    LTypeMsg := TLogType.ltError
  else
    LTypeMsg := TLogType.ltFatalError;

  TMultiLog4DUtil
   .Logger
   .LogWrite('LogWrite: ' + IntToStr(FCont), LTypeMsg);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  TMultiLog4DUtil
    .Logger
    .Output(loBoth)
    .LogWriteInformation('Adriano');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FCont := 1;
end;

end.
