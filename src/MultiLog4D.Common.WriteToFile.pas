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

