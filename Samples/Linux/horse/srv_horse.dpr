program srv_horse;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  MultiLog4D.Common,
  MultiLog4D.Util,
  MultiLog4D.Types,
  System.SysUtils;

begin
  THorse
    .Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      TMultiLog4DUtil
        .Logger
        {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
          {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
            .EventID(123)
            .Category(ecNone)
            .UserName('adriano')
          {$ENDIF}
        {$ENDIF}
        .LogWriteInformation('Log Information');

      Res.Send('pong');

      TMultiLog4DUtil
        .Logger
        {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
          {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
            .EventID(123)
            .Category(ecNone)
            .UserName('adriano')
          {$ENDIF}
        {$ENDIF}
        .LogWriteInformation('Erro');
    end
    );

  THorse
    .Listen(9000);
end.
