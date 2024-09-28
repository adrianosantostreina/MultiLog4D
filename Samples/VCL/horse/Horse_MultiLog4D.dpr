program Horse_MultiLog4D;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  MultiLog4D.Common,
  MultiLog4D.Util,
  MultiLog4D.Types,
  System.IOUtils,
  System.SysUtils;

var
  LOutputLogPath : string;

begin
  LOutputLogPath := TPath.Combine(ExtractFilePath(ParamStr(0)), 'MyLog');
  ForceDirectories(LOutputLogPath);

  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    //.Output(loBoth)
    //.Category(TEventCategory.ecNone)
    .FileName(TPath.Combine(LOutputLogPath, 'Log.txt'))
    .LogWriteInformation('>>>>>>>>>> Starting <<<<<<<<<<');

  THorse
    .Get('/test1',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      TMultiLog4DUtil
        .Logger
        .LogWriteInformation('Before Test1');

      Res.Send('test1');

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation('After Test1');
    end
    )
    .Get('/test2',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('test2');

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation('Test2');
    end
    )
    .Get('/test3',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('test3');

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation('Test3');
    end
    );

  THorse
    .Listen(9000);
end.
