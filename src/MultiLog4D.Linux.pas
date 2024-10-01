unit MultiLog4D.Linux;

interface

uses
  System.SysUtils,
  MultiLog4D.Base,
  MultiLog4D.Common,
  MultiLog4D.Interfaces,
  MultiLog4D.Types,
  MultiLog4D.Common.WriteToFile,
  MultiLog4D.Posix.Syslog;

type
  TMultiLog4DLinux = class(TMultiLog4DBase)
  private
    procedure WriteToSysLog(const AMsg: string; const ALogType: TLogType);
  protected
    procedure LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
  public
    constructor Create;
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

{ TMultiLog4DLinuxConsole }

constructor TMultiLog4DLinux.Create;
begin
  inherited Create;
end;

procedure TMultiLog4DLinux.WriteToSysLog(const AMsg: string; const ALogType: TLogType);
var
  Priority: Integer;
begin
  case ALogType of
    ltInformation: Priority := LOG_INFO;
    ltWarning:     Priority := LOG_WARNING;
    ltError:       Priority := LOG_ERR;
    ltFatalError:  Priority := LOG_CRIT;
  else
    Priority := LOG_INFO;
  end;

  syslog(Priority, AMsg);
end;

procedure TMultiLog4DLinux.LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
begin
  WriteToSysLog(AMsg, ALogType);
end;

function TMultiLog4DLinux.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ALogType);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DLinux.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltInformation);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DLinux.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltWarning);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DLinux.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltError);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DLinux.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltFatalError);
  Result := Self as IMultiLog4D;
end;

end.


