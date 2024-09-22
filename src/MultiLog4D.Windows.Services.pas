unit MultiLog4D.Windows.Services;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Math,
  MultiLog4D.Base,
  MultiLog4D.Interfaces,
  MultiLog4D.Types,
  MultiLog4D.Common,
  MultiLog4D.Common.WriteToFile,
  Windows;

type
  TMultiLog4DWindowsServices = class(TMultiLog4DBase)
  private
    procedure WriteToEventViewer(const AMessage: string; AType: Integer);
  protected
    procedure LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
  public
    constructor Create;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
        function Category(const AEventCategory: TEventCategory): IMultiLog4D; override;
        function EventID(const AEventID: DWORD): IMultiLog4D; override;
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

constructor TMultiLog4DWindowsServices.Create;
begin
  inherited Create;
end;

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

procedure TMultiLog4DWindowsServices.LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
var
  LType : Integer;
begin
  case FLogOutput of
    loBoth:
      begin
        TMultiLogWriteToFile.Instance
          .FileName(FFileName)
          .Execute(AMsg, ALogType);

        case ALogType of
          ltInformation: LType := EVENTLOG_INFORMATION_TYPE;
          ltWarning: LType := EVENTLOG_WARNING_TYPE;
          ltError, ltFatalError: LType := EVENTLOG_ERROR_TYPE;
        else
          LType := EVENTLOG_INFORMATION_TYPE;
        end;

        WriteToEventViewer(AMsg, LType);
      end;
    loFile:
      TMultiLogWriteToFile.Instance
        .FileName(FFileName)
        .Execute(AMsg, ALogType);
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

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
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

function TMultiLog4DWindowsServices.UserName(const AUserName: string): IMultiLog4D;
begin
  FUserName := AUserName;
  Result := Self;
end;

function TMultiLog4DWindowsServices.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  FLogOutput := AOutput;
  Result := Self;
end;
{$ENDIF}
{$ENDIF}

function TMultiLog4DWindowsServices.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ALogType);
  Result := Self;
end;

function TMultiLog4DWindowsServices.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltInformation);
  Result := Self;
end;

function TMultiLog4DWindowsServices.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltWarning);
  Result := Self;
end;

function TMultiLog4DWindowsServices.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltError);
  Result := Self;
end;

function TMultiLog4DWindowsServices.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltFatalError);
  Result := Self;
end;

end.
