program HorseLinux_MultiLog4D;

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
    .LogWriteInformation('Start Application');

  THorse
    .Get('/test1',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Randomize;

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation('Before Test1 - ' + Format('Mensagem de teste 1 de log: %d', [Random(1000)]));

      Res.Send('test1');

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation('After Test1 - ' + Format('Mensagem de teste 1 de log: %d', [Random(1000)]));
    end
    )
    .Get('/test2',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Randomize;
      Res.Send('test2');

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation(Format('Mensagem de teste 2 de log: %d', [Random(1000)]));
    end
    )
    .Get('/test3',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Randomize;
      Res.Send('test3');

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation(Format('Mensagem de teste 3 de log: %d', [Random(1000)]));
    end
    );

  THorse
    .Listen(9000);

end.
