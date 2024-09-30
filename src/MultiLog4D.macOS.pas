unit MultiLog4D.macOS;

interface

uses
  System.SysUtils,
  {$IFDEF MACOS}
    Macapi.Helpers,
    Macapi.ObjCRuntime,
    Macapi.ObjectiveC,
    Macapi.Foundation,
  {$ENDIF}
  FMX.Dialogs,
  MultiLog4D.Base,
  MultiLog4D.Common,
  MultiLog4D.Interfaces,
  MultiLog4D.Types;

type
  TMultiLog4DMacOS = class(TMultiLog4DBase)
  private
    procedure WriteToNSLog(const AMsg: string; const ALogType: TLogType);
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

{ TMultiLog4DMacOS }

constructor TMultiLog4DMacOS.Create;
begin
  inherited Create;
end;

procedure TMultiLog4DMacOS.WriteToNSLog(const AMsg: string; const ALogType: TLogType);
var
  LogMessage: string;
  NSStringMessage: Pointer;
begin
  LogMessage := Format('%s [%s] %s', [FTag, GetLogPrefix(ALogType), AMsg]);
  NSStringMessage := (NSStr(LogMessage) as ILocalObject).GetObjectID;
  NSLog(NSStringMessage);
end;

procedure TMultiLog4DMacOS.LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
begin
  WriteToNSLog(AMsg, ALogType);
end;

function TMultiLog4DMacOS.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ALogType);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DMacOS.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltInformation);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DMacOS.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltWarning);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DMacOS.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltError);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DMacOS.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltFatalError);
  Result := Self as IMultiLog4D;
end;

end.

