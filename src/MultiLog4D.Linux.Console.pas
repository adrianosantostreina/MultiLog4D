unit MultiLog4D.Linux.Console;

interface

uses
  System.SysUtils,
  MultiLog4D.Common.WriteToFile,
  MultiLog4D.Base,
  MultiLog4D.Common,
  MultiLog4D.Interfaces,
  MultiLog4D.Types;

type
  TMultiLog4DLinuxConsole = class(TMultiLog4DBase)
  private
    procedure WriteToConsole(const AMsg: string; const ALogType: TLogType);
    procedure LogWriteToFile(const AMsg: string; const ALogType: TLogType);
  protected
    procedure LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
  public
    constructor Create;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        function Category(const AEventCategory: TEventCategory): IMultiLog4D; override;
        function EventID(const AEventID: LongWord): IMultiLog4D; override;
        function UserName(const AUserName: string): IMultiLog4D; override;
        function Output(const AOutput: TLogOutput): IMultiLog4D; override;
      {$ENDIF}
    {$ENDIF}
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

constructor TMultiLog4DLinuxConsole.Create;
begin
  inherited Create;
end;

procedure TMultiLog4DLinuxConsole.WriteToConsole(const AMsg: string; const ALogType: TLogType);
begin
  Writeln(Format('%s %s %s - %s',
    [FormatDateTime('yyyy-mm-dd hh:nn:ss', Now),
     FUserName,
     GetLogPrefix(ALogType),
     AMsg]));
end;

procedure TMultiLog4DLinuxConsole.LogWriteToFile(const AMsg: string; const ALogType: TLogType);
begin
  TMultiLogWriteToFile.Instance
    .FileName(FFileName)
    .Execute(AMsg, ALogType);
end;

procedure TMultiLog4DLinuxConsole.LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
begin
  case FLogOutput of
    loConsole: WriteToConsole(AMsg, ALogType);
    loFile: LogWriteToFile(AMsg, ALogType);
    loBoth:
    begin
      WriteToConsole(AMsg, ALogType);
      LogWriteToFile(AMsg, ALogType);
    end;
  end;
end;

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
function TMultiLog4DLinuxConsole.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FEventCategory := AEventCategory;
  Result := Self;
end;

function TMultiLog4DLinuxConsole.EventID(const AEventID: LongWord): IMultiLog4D;
begin
  FEventID := AEventID;
  Result := Self;
end;

function TMultiLog4DLinuxConsole.UserName(const AUserName: string): IMultiLog4D;
begin
  FUserName := AUserName;
  Result := Self;
end;

function TMultiLog4DLinuxConsole.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  FLogOutput := AOutput;
  Result := Self;
end;
{$ENDIF}
{$ENDIF}

function TMultiLog4DLinuxConsole.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ALogType);
  Result := Self;
end;

function TMultiLog4DLinuxConsole.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltInformation);
  Result := Self;
end;

function TMultiLog4DLinuxConsole.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltWarning);
  Result := Self;
end;

function TMultiLog4DLinuxConsole.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltError);
  Result := Self;
end;

function TMultiLog4DLinuxConsole.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltFatalError);
  Result := Self;
end;

end.
