unit MultiLog4D.Common.WriteToFile;

interface

uses
  System.SysUtils,
  System.IOUtils,
  MultiLog4D.Types;

type
  TMultiLogWriteToFile = class
  private
    class var FInstance: TMultiLogWriteToFile;
    FFileName: string;
    procedure EnsureDirectoryExists;
  public
    class function Instance: TMultiLogWriteToFile;
    function FileName(const AFileName: string): TMultiLogWriteToFile; overload;
    function FileName: string; overload;
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
begin
  if FFileName.IsEmpty then
    FFileName := TPath.Combine(ExtractFilePath(ParamStr(0)), 'log\logfile.txt');

  EnsureDirectoryExists;

  AssignFile(LogFile, FFileName);
  if FileExists(FFileName) then
    Append(LogFile)
  else
    Rewrite(LogFile);
  try
    Writeln(LogFile, Format('%s %s %s - %s',
      [FormatDateTime('yyyy-mm-dd hh:nn:ss', Now),
       'UserNamePlaceholder', // A ser substituído pelo nome do usuário
       'LogPrefixPlaceholder', // A ser substituído pelo prefixo do log
       AMsg]));
  finally
    CloseFile(LogFile);
  end;

  Result := Self;
end;

initialization
  TMultiLogWriteToFile.FInstance := nil;

end.

////////////////// Próxima altaração //////////////////

unit MultiLog4D.Common.WriteToFile;

interface

uses
  System.SysUtils,
  System.IOUtils,
  MultiLog4D.Types;

type
  TMultiLogWriteToFile = class
  private
    class var FInstance: TMultiLogWriteToFile;
    FFileName: string;
    FLogFormat: string;
    FUserName: string;  // Pegando o FUserName da classe base
    FDateTimeFormat: string;
    procedure EnsureDirectoryExists;
    function ReplaceLogVariables(const AMsg: string; const ALogType: TLogType): string;
  public
    class function Instance: TMultiLogWriteToFile;
    function FileName(const AFileName: string): TMultiLogWriteToFile; overload;
    function FileName: string; overload;
    function SetDateTimeFormat(const AFormat: string): TMultiLogWriteToFile;
    function SetLogFormat(const AFormat: string): TMultiLogWriteToFile;  // Propriedade para definir o formato do log
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

// Novo método para definir o formato de log
function TMultiLogWriteToFile.SetLogFormat(const AFormat: string): TMultiLogWriteToFile;
begin
  FLogFormat := AFormat;
  Result := Self;
end;

// Implementação do novo método SetDateTimeFormat
function TMultiLogWriteToFile.SetDateTimeFormat(const AFormat: string): TMultiLogWriteToFile;
begin
  FDateTimeFormat := AFormat;
  Result := Self;
end;

// Substitui as variáveis no padrão de log configurado
function TMultiLogWriteToFile.ReplaceLogVariables(const AMsg: string; const ALogType: TLogType): string;
var
  LogPrefix: string;
  LogLine: string;
begin
  // Prefixo do log
  case ALogType of
    ltInformation: LogPrefix := 'INFO';
    ltWarning:     LogPrefix := 'WARN';
    ltError:       LogPrefix := 'ERROR';
    ltFatalError:  LogPrefix := 'FATAL';
  else
    LogPrefix := 'INFO';
  end;

  // Verifica se o formato de log foi definido; caso contrário, usa o padrão
  if FLogFormat.IsEmpty then
    FLogFormat := '${time} ${username} [${log_type}] - ${message}';

  // Se o usuário não configurou um formato, usamos um padrão
  if FDateTimeFormat.IsEmpty then
    DateTimeFormat := 'yyyy-mm-dd hh:nn:ss'
  else
    DateTimeFormat := FDateTimeFormat;

  // Substitui variáveis no formato
  LogLine := FLogFormat;
  LogLine := StringReplace(LogLine, '${time}', FormatDateTime(FDateTimeFormat{'yyyy-mm-dd hh:nn:ss'}, Now), [rfReplaceAll]);
  LogLine := StringReplace(LogLine, '${username}', FUserName, [rfReplaceAll]);  // Pega o nome do usuário configurado
  LogLine := StringReplace(LogLine, '${log_type}', LogPrefix, [rfReplaceAll]);
  LogLine := StringReplace(LogLine, '${message}', AMsg, [rfReplaceAll]);

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

  // Substitui as variáveis no formato do log
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

end.

