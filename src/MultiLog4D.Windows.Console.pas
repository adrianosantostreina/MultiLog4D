unit MultiLog4D.Windows.Console;

interface

uses
  System.SysUtils,
  {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
    {$IFDEF MSWINDOWS}
      Winapi.Windows,
    {$ENDIF}
  {$ENDIF}
  MultiLog4D.Common.WriteToFile,
  MultiLog4D.Base,
  MultiLog4D.Common,
  MultiLog4D.Interfaces,
  MultiLog4D.Types;

type
  TMultiLog4DWindowsConsole = class(TMultiLog4DBase)
  private
    procedure WriteToConsole(const AMsg: string; const ALogType: TLogType);
    procedure LogWriteToFile(const AMsg: string; const ALogType: TLogType);
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
        function SetLogFormat(const AFormat: string): IMultiLog4D; override;
        function SetDateTimeFormat(const ADateTimeFormat: string): IMultiLog4D; override;
      {$ENDIF}
    {$ENDIF}
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

constructor TMultiLog4DWindowsConsole.Create;
begin
  inherited Create;
end;

procedure TMultiLog4DWindowsConsole.WriteToConsole(const AMsg: string; const ALogType: TLogType);
begin
  Writeln(Format('%s %s %s - %s',
    [FormatDateTime(FDateTimeFormat, Now),
     FUserName,
     GetLogPrefix(ALogType),
     AMsg]));
end;

procedure TMultiLog4DWindowsConsole.LogWriteToFile(const AMsg: string; const ALogType: TLogType);
begin
  TMultiLogWriteToFile.Instance
    .FileName(FFileName)
    .Execute(AMsg, ALogType);
end;

procedure TMultiLog4DWindowsConsole.LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
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
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
function TMultiLog4DWindowsConsole.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FEventCategory := AEventCategory;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.EventID(const AEventID: DWORD): IMultiLog4D;
begin
  FEventID := AEventID;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.UserName(const AUserName: string): IMultiLog4D;
begin
  FUserName := AUserName;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  FLogOutput := AOutput;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.SetLogFormat(const AFormat: string): IMultiLog4D;
begin
  FLogFormat := AFormat;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.SetDateTimeFormat(const ADateTimeFormat: string): IMultiLog4D;
begin
  FDateTimeFormat := ADateTimeFormat;
  Result := Self as IMultiLog4D;
end;
{$ENDIF}
{$ENDIF}

function TMultiLog4DWindowsConsole.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ALogType);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltInformation);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltWarning);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltError);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsConsole.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltFatalError);
  Result := Self as IMultiLog4D;
end;

end.


