unit MultiLog4D.Logger;

interface

uses
  {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
    {$IFDEF MSWINDOWS}
      Winapi.Windows,
    {$ENDIF}
  {$ENDIF}
  System.SysUtils,
  MultiLog4D.Interfaces,
  MultiLog4D.Types,
  MultiLog4D.Setup,
  MultiLog4D.Factory;
(*
type
  TMultiLog4DLogger = class(TInterfacedObject, IMultiLog4D)
  private
    FSetup: TMultiLog4DSetup;
    FLoggerImpl: IMultiLog4D;
  public
    constructor Create;
    function Setup: TMultiLog4DSetup;
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
    function LogWriteInformation(const AMsg: string): IMultiLog4D;
    function LogWriteWarning(const AMsg: string): IMultiLog4D;
    function LogWriteError(const AMsg: string): IMultiLog4D;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      function Category(const AEventCategory: TEventCategory): IMultiLog4D;
      function EventID(const AEventID: DWORD): IMultiLog4D;
      function UserName(const AUserName: string): IMultiLog4D;
      function FileName(const AFileName: string): IMultiLog4D;
      function Output(const AOutput: TLogOutput): IMultiLog4D;
    {$ENDIF}
  end;
*)
implementation

(*
{ TMultiLog4DLogger }

constructor TMultiLog4DLogger.Create;
begin
  // Obter a implementação real do logger usando a fábrica
  FLoggerImpl := TLogFactory.GetLogger;
  FSetup := TMultiLog4DSetup.Create(Self);
end;

function TMultiLog4DLogger.Setup: TMultiLog4DSetup;
begin
  Result := FSetup;
end;

function TMultiLog4DLogger.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  // Delegar para a implementação específica
//  if Supports(FLogger, IMultiLog4D) then
//    (FLogger as IMultiLog4D).Category(AEventCategory);

  Result := Self.LogWrite(AMsg, ALogType); //FLoggerImpl.LogWrite(AMsg, ALogType);
end;

function TMultiLog4DLogger.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  Result := FLoggerImpl.LogWriteInformation(AMsg);
end;

function TMultiLog4DLogger.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  Result := FLoggerImpl.LogWriteWarning(AMsg);
end;

function TMultiLog4DLogger.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  Result := FLoggerImpl.LogWriteError(AMsg);
end;

function TMultiLog4DLogger.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  Result := FLoggerImpl.LogWriteFatalError(AMsg);
end;

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
function TMultiLog4DLogger.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  Result := FLoggerImpl.Category(AEventCategory);
end;

function TMultiLog4DLogger.EventID(const AEventID: DWORD): IMultiLog4D;
begin
  Result := FLoggerImpl.EventID(AEventID);
end;

function TMultiLog4DLogger.UserName(const AUserName: string): IMultiLog4D;
begin
  Result := FLoggerImpl.UserName(AUserName);
end;

function TMultiLog4DLogger.FileName(const AFileName: string): IMultiLog4D;
begin
  Result := FLoggerImpl.FileName(AFileName);
end;

function TMultiLog4DLogger.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  Result := FLoggerImpl.Output(AOutput);
end;
{$ENDIF}
*)
end.


(*
unit MultiLog4D.Logger;

interface

uses
  System.Classes,
  System.StrUtils,
  System.SysUtils,
  System.TypInfo,
  {$IFDEF MSWINDOWS}
    Winapi.Windows,
  {$ENDIF}
  MultiLog4D.Types,
  MultiLog4D.Interfaces,
  MultiLog4D.Setup;

type
  TMultiLog4DLogger = class(TInterfacedObject, IMultiLog4D)
  private
    FSetup: IMultiLog4DSetup;
    FTag: string;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        FOutput: TLogOutput;
        FFileName: string;
        FUserName: string;
        FEventID: DWORD;
        FCategory: TEventCategory;
      {$ENDIF}
    {$ENDIF}
  public
    constructor Create;
    function Setup: IMultiLog4DSetup;
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
    function LogWriteInformation(const AMsg: string): IMultiLog4D;
    function LogWriteWarning(const AMsg: string): IMultiLog4D;
    function LogWriteError(const AMsg: string): IMultiLog4D;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        function Category(const AEventCategory: TEventCategory): IMultiLog4D;
        function EventID(const AEventID: DWORD): IMultiLog4D;
        function UserName(const AUserName: string): IMultiLog4D;
        function FileName(const AFileName: string): IMultiLog4D;
        function Output(const AOutput: TLogOutput): IMultiLog4D;
      {$ENDIF}
    {$ENDIF}
  end;

implementation

{ TMultiLog4DLogger }

constructor TMultiLog4DLogger.Create;
begin
  FSetup := TMultiLog4DSetup.Create(Self);
end;

function TMultiLog4DLogger.Setup: IMultiLog4DSetup;
begin
  Result := FSetup;
end;

function TMultiLog4DLogger.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin

  Result := Self;
end;

function TMultiLog4DLogger.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  Result := LogWriteInformation(AMsg); //LogWrite(AMsg, TLogType.ltInformation);
end;

function TMultiLog4DLogger.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, TLogType.ltWarning);
end;

function TMultiLog4DLogger.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, TLogType.ltError);
end;

function TMultiLog4DLogger.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, TLogType.ltFatalError);
end;


{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
function TMultiLog4DLogger.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FCategory := AEventCategory;
  Result := Self;
end;

function TMultiLog4DLogger.EventID(const AEventID: DWORD): IMultiLog4D;
begin
  FEventID := AEventID;
  Result := Self;
end;

function TMultiLog4DLogger.UserName(const AUserName: string): IMultiLog4D;
begin
  FUserName := AUserName;
  Result := Self;
end;

function TMultiLog4DLogger.FileName(const AFileName: string): IMultiLog4D;
begin
  FFileName := AFileName;
  Result := Self;
end;

function TMultiLog4DLogger.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  FOutput := AOutput;
  Result := Self;
end;
{$ENDIF}
{$ENDIF}

end.
*)

(*
unit MultiLog4D.Logger;

interface

uses
  {$IFDEF MSWINDOWS}
    Winapi.Windows,
  {$ENDIF}
  MultiLog4D.Types,
  MultiLog4D.Interfaces,
  MultiLog4D.Setup;

type
  TMultiLog4DLogger = class(TInterfacedObject, IMultiLog4D)
  private
    FSetup: IMultiLog4DSetup;
    // Campos para armazenar configurações
  public
    constructor Create;
    function Setup: IMultiLog4DSetup;
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
    function LogWriteInformation(const AMsg: string): IMultiLog4D;
    function LogWriteWarning(const AMsg: string): IMultiLog4D;
    function LogWriteError(const AMsg: string): IMultiLog4D;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      function Category(const AEventCategory: TEventCategory): IMultiLog4D;
      function EventID(const AEventID: DWORD): IMultiLog4D;
      function UserName(const AUserName: string): IMultiLog4D;
      function FileName(const AFileName: string): IMultiLog4D;
      function Output(const AOutput: TLogOutput): IMultiLog4D;
    {$ENDIF}
  end;

implementation

{ TMultiLog4DLogger }

constructor TMultiLog4DLogger.Create;
begin
  FSetup := TMultiLog4DSetup.Create(Self);
end;

function TMultiLog4DLogger.Setup: IMultiLog4DSetup;
begin
  Result := FSetup;
end;

function TMultiLog4DLogger.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DLogger.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, TLogType.ltInformation);
end;

function TMultiLog4DLogger.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, TLogType.ltWarning);
end;

function TMultiLog4DLogger.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, TLogType.ltError);
end;

function TMultiLog4DLogger.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, TLogType.ltFatalError);
end;

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
function TMultiLog4DLogger.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DLogger.EventID(const AEventID: DWORD): IMultiLog4D;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DLogger.UserName(const AUserName: string): IMultiLog4D;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DLogger.FileName(const AFileName: string): IMultiLog4D;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DLogger.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  // Implementação do método
  Result := Self;
end;
{$ENDIF}

end.
*)
