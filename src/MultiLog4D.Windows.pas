unit MultiLog4D.Windows;

interface

uses
  System.SysUtils,
  System.StrUtils,
  MultiLog4D.Base,
  MultiLog4D.Common,
  MultiLog4D.Interfaces,
  {$IFDEF MSWINDOWS}
    Winapi.Windows,
  {$ENDIF}
  MultiLog4D.Types,
  MultiLog4D.Common.WriteToFile;

type
  TMultiLog4DWindows = class(TMultiLog4DBase)
  private
    procedure WriteToConsole(const AMsg: string; const ALogType: TLogType);
    procedure WriteToFile(const AMsg: string; const ALogType: TLogType);
    procedure WriteToEventViewer(const AMessage: string; AType: Integer);
  protected
    procedure LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
  public
    constructor Create(const AFileName: string = ''); overload;
    {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
      function Category(const AEventCategory: TEventCategory): IMultiLog4D; override;
      function EventID(const AEventID: DWORD): IMultiLog4D; override;
      function UserName(const AUserName: string): IMultiLog4D; override;
      function Output(const AOutput: TLogOutputSet): IMultiLog4D; override;
      function SetLogFormat(const AFormat: string): IMultiLog4D; override;
      function SetDateTimeFormat(const ADateTimeFormat: string): IMultiLog4D; override;
    {$ENDIF}
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

constructor TMultiLog4DWindows.Create(const AFileName: string);
begin
  inherited Create;
  if AFileName <> '' then
    FFileName := AFileName;
end;

procedure TMultiLog4DWindows.WriteToConsole(const AMsg: string; const ALogType: TLogType);
begin
  if IsConsole then
    Writeln(Format('%s %s %s - %s',
      [FormatDateTime(FDateTimeFormat, Now),
       FUserName,
       GetLogPrefix(ALogType),
       AMsg]));
end;

procedure TMultiLog4DWindows.WriteToFile(const AMsg: string; const ALogType: TLogType);
begin
  TMultiLogWriteToFile.Instance
    .FileName(FFileName)
    .SetLogFormat(FLogFormat)
    .SetDateTimeFormat(FDateTimeFormat)
    .SetUserName(FUserName)
    .SetEventID(FEventID)
    .Execute(AMsg, ALogType);
end;

procedure TMultiLog4DWindows.WriteToEventViewer(const AMessage: string; AType: Integer);
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

procedure TMultiLog4DWindows.LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
var
  LType: Integer;
begin
  if loConsole in FLogOutput then
    WriteToConsole(AMsg, ALogType);

  if loFile in FLogOutput then
    WriteToFile(AMsg, ALogType);

  if loEventViewer in FLogOutput then
  begin
    case ALogType of
      ltInformation: LType := EVENTLOG_INFORMATION_TYPE;
      ltWarning:     LType := EVENTLOG_WARNING_TYPE;
      ltError,
      ltFatalError:  LType := EVENTLOG_ERROR_TYPE;
    else
      LType := EVENTLOG_INFORMATION_TYPE;
    end;
    WriteToEventViewer(AMsg, LType);
  end;
end;

(*
procedure TMultiLog4DWindows.LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
var
  LType : Integer;
begin
  case FLogOutput of
    loConsole:
      WriteToConsole(AMsg, ALogType);
    loFile:
      WriteToFile(AMsg, ALogType);
    loBoth:
    begin
      WriteToConsole(AMsg, ALogType);
      WriteToFile(AMsg, ALogType);
    end;
    loEventViewer:
    begin
      case ALogType of
        ltInformation: LType := EVENTLOG_INFORMATION_TYPE;
        ltWarning: LType := EVENTLOG_WARNING_TYPE;
        ltError, ltFatalError: LType := EVENTLOG_ERROR_TYPE;
      else
        LType := EVENTLOG_INFORMATION_TYPE;
      end;
      WriteToEventViewer(AMsg, LType);
    end;
  end;
end;
*)

{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
function TMultiLog4DWindows.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FEventCategory := AEventCategory;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.EventID(const AEventID: DWORD): IMultiLog4D;
begin
  FEventID := AEventID;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.UserName(const AUserName: string): IMultiLog4D;
begin
  FUserName := AUserName;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  FLogOutput := AOutput;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.SetLogFormat(const AFormat: string): IMultiLog4D;
begin
  FLogFormat := AFormat;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.SetDateTimeFormat(const ADateTimeFormat: string): IMultiLog4D;
begin
  FDateTimeFormat := ADateTimeFormat;
  Result := Self as IMultiLog4D;
end;
{$ENDIF}

function TMultiLog4DWindows.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ALogType);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltInformation);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltWarning);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltError);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindows.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  LogWriteToDestination(AMsg, ltFatalError);
  Result := Self as IMultiLog4D;
end;

end.

