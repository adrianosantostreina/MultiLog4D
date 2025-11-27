unit MultiLog4D.Common.WriteToFile;

interface

uses
  System.SysUtils,
  System.IOUtils,
  {$IFDEF MSWINDOWS}
    Winapi.Windows,
  {$ENDIF}
  MultiLog4D.Types;

type
  TMultiLogWriteToFile = class
  private
    class var FInstance: TMultiLogWriteToFile;
    FFileName: string;
    FLogFormat: string;
    FDateTimeFormat: string;
    FUserName: string;
    {$IFDEF MSWINDOWS}
    FEventID: DWORD;
    {$ENDIF}
    {$IFDEF LINUX}
    FEventID: LONGWORD;
    {$ENDIF}
    {$IFDEF MACOS}
    FEventID: UInt32;
    {$ENDIF}
    procedure EnsureDirectoryExists;
    function ReplaceLogVariables(const AMsg: string; const ALogType: TLogType): string;
  public
    class function Instance: TMultiLogWriteToFile;
    function FileName(const AFileName: string): TMultiLogWriteToFile; overload;
    function FileName: string; overload;
    function SetLogFormat(const AFormat: string): TMultiLogWriteToFile;
    function SetDateTimeFormat(const ADateTimeFormat: string): TMultiLogWriteToFile;
    function SetUserName(const AUserName: string): TMultiLogWriteToFile;
    function SetEventID(const AEventID: {$IFDEF MSWINDOWS}DWORD{$ELSEIF DEFINED(LINUX)}LONGWORD{$ELSEIF DEFINED(MACOS)}UInt32{$ENDIF}): TMultiLogWriteToFile;
    function Execute(const AMsg: string; const ALogType: TLogType): TMultiLogWriteToFile;
  end;

implementation

{ TMultiLogWriteToFile }

class function TMultiLogWriteToFile.Instance: TMultiLogWriteToFile;
begin
  if not Assigned(FInstance) then
    FInstance := TMultiLogWriteToFile.Create;
  Result := FInstance;
end;

function TMultiLogWriteToFile.FileName(const AFileName: string): TMultiLogWriteToFile;
begin
  FFileName := AFileName;
  Result := Self;
end;

function TMultiLogWriteToFile.FileName: string;
begin
  Result := FFileName;
end;

function TMultiLogWriteToFile.SetLogFormat(const AFormat: string): TMultiLogWriteToFile;
begin
  FLogFormat := AFormat;
  Result := Self;
end;

function TMultiLogWriteToFile.SetDateTimeFormat(const ADateTimeFormat: string): TMultiLogWriteToFile;
begin
  FDateTimeFormat := ADateTimeFormat;
  Result := Self;
end;

function TMultiLogWriteToFile.SetUserName(const AUserName: string): TMultiLogWriteToFile;
begin
  FUserName := AUserName;
  Result := Self;
end;

function TMultiLogWriteToFile.SetEventID(const AEventID: {$IFDEF MSWINDOWS}DWORD{$ELSEIF DEFINED(LINUX)}LONGWORD{$ELSEIF DEFINED(MACOS)}UInt32{$ENDIF}): TMultiLogWriteToFile;
begin
  FEventID := AEventID;
  Result := Self;
end;

function TMultiLogWriteToFile.ReplaceLogVariables(const AMsg: string; const ALogType: TLogType): string;
var
  LogPrefix: string;
  LogLine: string;
  DateTimeFormat: string;
begin
  case ALogType of
    ltInformation: LogPrefix := 'INFO ';
    ltWarning:     LogPrefix := 'WARN ';
    ltError:       LogPrefix := 'ERROR';
    ltFatalError:  LogPrefix := 'FATAL';
  else
    LogPrefix := 'INFO';
  end;

  if FLogFormat.IsEmpty then
    FLogFormat := '${time} ${username} ${eventid} [${log_type}] - ${message}';

  if FDateTimeFormat.IsEmpty then
    DateTimeFormat := 'YYYY-MM-DD hh:nn:ss'
  else
    DateTimeFormat := FDateTimeFormat;

  LogLine := FLogFormat;
  LogLine := StringReplace(LogLine, '${time}', FormatDateTime(DateTimeFormat, Now), [rfReplaceAll]);
  LogLine := StringReplace(LogLine, '${username}', FUserName, [rfReplaceAll]);
  LogLine := StringReplace(LogLine, '${log_type}', LogPrefix, [rfReplaceAll]);
  LogLine := StringReplace(LogLine, '${message}', AMsg, [rfReplaceAll]);
  LogLine := StringReplace(LogLine, '${eventid}', Format('%4.4d', [FEventID]), [rfReplaceAll]);

  Result := LogLine;
end;

procedure TMultiLogWriteToFile.EnsureDirectoryExists;
var
  LogDir: string;
begin
  LogDir := ExtractFilePath(FFileName);
  if not DirectoryExists(LogDir) then
    TDirectory.CreateDirectory(LogDir);
end;

function TMultiLogWriteToFile.Execute(const AMsg: string; const ALogType: TLogType): TMultiLogWriteToFile;
var
  LogFile: TextFile;
  LogLine: string;
begin
  if FFileName.IsEmpty then
    FFileName := TPath.Combine(ExtractFilePath(ParamStr(0)), 'log\logfile.txt');

  EnsureDirectoryExists;

  LogLine := ReplaceLogVariables(AMsg, ALogType);

  AssignFile(LogFile, FFileName);
  if FileExists(FFileName) then
    Append(LogFile)
  else
    Rewrite(LogFile);
  try
    Writeln(LogFile, LogLine);
  finally
    CloseFile(LogFile);
  end;

  Result := Self;
end;

initialization
  TMultiLogWriteToFile.FInstance := nil;

{$IFDEF MSWINDOWS}
finalization
if Assigned(TMultiLogWriteToFile.FInstance) then
begin
  TMultiLogWriteToFile.FInstance.Free;
  TMultiLogWriteToFile.FInstance := nil;
end;
{$ENDIF}

end.
