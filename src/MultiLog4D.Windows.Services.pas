unit MultiLog4D.Windows.Services;

interface

uses
  System.SysUtils,
  System.StrUtils,
  MultiLog4D.Base,
  MultiLog4D.Types,
  MultiLog4D.Interfaces,
  MultiLog4D.Common,
  Windows;

type
  TMultiLog4DWindowsServices = class(TMultiLog4DBase)
  private
    procedure WriteToEventViewer(const AMessage: string; AType: Integer);
  public
    {$IFDEF ML4D_SERVICE}
    function Category(const AEventCategory: TEventCategory): IMultiLog4D;
    function EventID(const AEventID: DWORD): IMultiLog4D;
    {$ENDIF}
    function UserName(const AUserName: string): IMultiLog4D;
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

{ TMultiLog4DWindowsServices }

procedure TMultiLog4DWindowsServices.WriteToEventViewer(const AMessage: string; AType: Integer);
var
  hEventLog: THandle;
  EventStrings: array[0..3] of PChar;
begin
  hEventLog := RegisterEventSource(nil, PChar(FTag));
  if hEventLog <> 0 then
  begin
    try
      EventStrings[0] := PChar(Format('Process: %s', [FTag]));
      EventStrings[1] := PChar(Format('Category Name: %s', [GetCategoryName]));
      EventStrings[2] := PChar(Format('Username: %s', [IfThen(FUserName.IsEmpty, TMultiLog4DCommon.GetCurrentUserName, FUserName)]));
      EventStrings[3] := PChar(Format('Message: %s', [AMessage]));
      ReportEvent(hEventLog, AType, DWORD(FEventCategory), FEventID, nil, 4, 0, @EventStrings, nil);
    finally
      DeregisterEventSource(hEventLog);
    end;
  end
  else
    RaiseLastOSError;
end;
(*
var
  hEventLog: THandle;
  FormattedMessage: string;
begin
  FormattedMessage := Format('%s [%s]: %s', [FTag, GetCategoryName, AMessage]);

  hEventLog := RegisterEventSource(nil, PChar(FTag));
  if hEventLog <> 0 then
  begin
    try
      ReportEvent(hEventLog, AType, DWORD(FEventCategory), FEventID, nil, 1, 0, @FormattedMessage, nil);
    finally
      DeregisterEventSource(hEventLog);
    end;
  end
  else
    RaiseLastOSError;
end;
*)

{$IFDEF ML4D_SERVICE}
function TMultiLog4DWindowsServices.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FEventCategory := AEventCategory;
  Result := Self;
end;

function TMultiLog4DWindowsServices.EventID(const AEventID: DWORD): IMultiLog4D;
begin
  FEventID := AEventID;
  Result := Self;
end;
{$ENDIF}

function TMultiLog4DWindowsServices.UserName(const AUserName: string): IMultiLog4D;
begin
  FUserName := AUserName;
  Result := Self;
end;

function TMultiLog4DWindowsServices.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
var
  LogType: Integer;
begin
  case ALogType of
    ltInformation: LogType := EVENTLOG_INFORMATION_TYPE;
    ltWarning: LogType := EVENTLOG_WARNING_TYPE;
    ltError: LogType := EVENTLOG_ERROR_TYPE;
    ltFatalError: LogType := EVENTLOG_ERROR_TYPE;
  else
    LogType := EVENTLOG_INFORMATION_TYPE;
  end;

  WriteToEventViewer(AMsg, LogType);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsServices.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, ltInformation);
end;

function TMultiLog4DWindowsServices.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, ltWarning);
end;

function TMultiLog4DWindowsServices.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, ltError);
end;

function TMultiLog4DWindowsServices.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, ltFatalError);
end;

end.



(*
interface

uses
  System.SysUtils,

  MultiLog4D.Base,
  MultiLog4D.Types,
  MultiLog4D.Interfaces,

  Windows,
  VCL.SvcMgr;

type
  TMultiLog4DWindowsServices = class(TMultiLog4DBase)
  private
    FEventCategory: TEventCategory;
  public
    function Category(const AEventCategory: TEventCategory): IMultiLog4D;
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

procedure WriteToEventViewer(const AMessage: string; AType: Integer; const AEventSource: string);
var
  hEventLog: THandle;
begin
  hEventLog := RegisterEventSource(nil, PChar(AEventSource));
  if hEventLog <> 0 then
  begin
    try
      ReportEvent(hEventLog, AType, 0, 0, nil, 1, 0, @AMessage, nil);
    finally
      DeregisterEventSource(hEventLog);
    end;
  end
  else
    RaiseLastOSError;
end;

function TMultiLog4DWindowsServices.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FEventCategory := AEventCategory;
  Result := Self;
end;

function TMultiLog4DWindowsServices.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
var
  LogType: Integer;
  LEventCategory: DWORD;
begin
  case ALogType of
    ltInformation: LogType := EVENTLOG_INFORMATION_TYPE;
    ltWarning: LogType := EVENTLOG_WARNING_TYPE;
    ltError: LogType := EVENTLOG_ERROR_TYPE;
    ltFatalError: LogType := EVENTLOG_ERROR_TYPE;
  else
    LogType := EVENTLOG_INFORMATION_TYPE;
  end;

  case FEventCategory of
    ecNone: LEventCategory := 0;
    ecApplication: LEventCategory := 1;
    ecSecurity: LEventCategory := 2;
    ecPerformance: LEventCategory := 3;
    ecError: LEventCategory := 4;
    ecWarning: LEventCategory := 5;
    ecDebug: LEventCategory := 6;
    ecTransaction: LEventCategory := 7;
    ecNetwork: LEventCategory := 8;
  else
    LEventCategory := 0;
  end;

  WriteToEventViewer(AMsg, LogType, FTag);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsServices.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, ltInformation);
end;

function TMultiLog4DWindowsServices.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, ltWarning);
end;

function TMultiLog4DWindowsServices.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, ltError);
end;

function TMultiLog4DWindowsServices.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  Result := LogWrite(AMsg, ltFatalError);
end;
*)

end.
