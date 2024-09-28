unit Unit1;

interface

uses
  MultiLog4D.Util,
  MultiLog4D.Types,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask;

type
  TForm3 = class(TForm)
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Bevel1: TBevel;
    RadioGroup2: TRadioGroup;
    GroupBox1: TGroupBox;
    lbleditDateTimeFormat: TLabeledEdit;
    lbleditLogFormat: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  private
    { Private declarations }
    FOutputLog : TLogOutPut;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  LStrTypeMsg : string;
  LTypeMsg : TLogType; //Uses MultiLog4D.Types
begin
  case RadioGroup1.ItemIndex of
    0 :
      begin
        LTypeMsg := TLogType.ltInformation;
        LStrTypeMsg := 'Information';
      end;
    1 :
      begin
        LTypeMsg := TLogType.ltWarning;
        LStrTypeMsg := 'Warning';
      end;
    2 :
      begin
        LTypeMsg := TLogType.ltError;
        LStrTypeMsg := 'Error';
      end;
    3 :
      begin
        LTypeMsg := TLogType.ltFatalError;
        LStrTypeMsg := 'Faltal Error';
      end;
  end;

  TMultiLog4DUtil
   .Logger
   .Output(FOutputLog)
   .SetLogFormat(lbleditLogFormat.Text) //Mask Format
   .SetDateTimeFormat(lbleditDateTimeFormat.Text) //Format DateTime
   .UserName('adrianosantos')
   .EventID(Random(1000))
   .LogWrite(Format('LogWrite Type: %s', [LStrTypeMsg]), LTypeMsg);

  ShowMessage(Format('LogWrite Type: %s', [LStrTypeMsg]));
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
   .Output(FOutputLog)
   .SetLogFormat(lbleditLogFormat.Text) //Mask Format
   .SetDateTimeFormat(lbleditDateTimeFormat.Text) //Format DateTime
   .UserName('adrianosantos')
   .EventID(1000)
   .LogWriteInformation('LogWrite Type Information');

  ShowMessage('LogWrite Type Information');
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
   .Output(FOutputLog)
   .SetLogFormat(lbleditLogFormat.Text) //Mask Format
   .SetDateTimeFormat(lbleditDateTimeFormat.Text) //Format DateTime
   .UserName('adrianosantos')
   .EventID(1000)
   .LogWriteInformation('LogWrite Type Warning');

  ShowMessage('LogWrite Type Warning');
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
   .Output(FOutputLog)
   .SetLogFormat(lbleditLogFormat.Text) //Mask Format
   .SetDateTimeFormat(lbleditDateTimeFormat.Text) //Format DateTime
   .UserName('adrianosantos')
   .EventID(1000)
   .LogWriteInformation('LogWrite Type Error');

  ShowMessage('LogWrite Type Error');
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  TMultiLog4DUtil
   .Logger
   .Output(FOutputLog)
   .SetLogFormat(lbleditLogFormat.Text) //Mask Format
   .SetDateTimeFormat(lbleditDateTimeFormat.Text) //Format DateTime
   .UserName('adrianosantos')
   .EventID(Random(1000))
   .LogWriteInformation('LogWrite Type Fatal Error');

  ShowMessage('LogWrite Type Fatal Error');
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FOutputLog := TLogOutPut.loFile;
end;

procedure TForm3.RadioGroup2Click(Sender: TObject);
begin
  case RadioGroup2.ItemIndex of
    0: FOutputLog := TLogOutPut.loFile;
    1: FOutputLog := TLogOutPut.loEventViewer; //Add ML4D_EVENTVIEWER Directivec
    2: FOutputLog := TLogOutPut.loBoth;
  end;
end;

end.
