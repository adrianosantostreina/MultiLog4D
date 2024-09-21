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

begin
  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    .Output(loConsole)
    .LogWriteInformation('>>>>>>>>>> Starting <<<<<<<<<<');

  THorse
    .Get('/test1',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      TMultiLog4DUtil
        .Logger
        .Output(loConsole)
        .LogWriteInformation('Before Test1');

      Res.Send('test1');

      TMultiLog4DUtil
        .Logger
        .Output(loConsole)
        .LogWriteInformation('After Test1');
    end
    )
    .Get('/test2',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('test2');

      TMultiLog4DUtil
        .Logger
        .Output(loFile)
        .Category(TEventCategory.ecSecurity)
        .LogWriteInformation('Test2');
    end
    )
    .Get('/test3',
    procedure(Req: THorseRequest; Res: THorseResponse)
    var
      LOutputLogPath : string;
    begin
      Res.Send('test3');

      LOutputLogPath := TPath.Combine(ExtractFilePath(ParamStr(0)), 'MyLog');
      ForceDirectories(LOutputLogPath);

      TMultiLog4DUtil
        .Logger
        .Category(TEventCategory.ecSecurity)
        .EventID(123)
        .Output(loBoth)
        .FileName(TPath.Combine(LOutputLogPath, 'Log.txt'))
        .LogWriteInformation('Test3');
    end
    );

  THorse
    .Listen(9000);
end.
