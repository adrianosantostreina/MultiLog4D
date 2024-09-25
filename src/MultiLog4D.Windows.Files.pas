unit MultiLog4D.Windows.Files;

interface

uses
  System.SysUtils,
  MultiLog4D.Base,
  MultiLog4D.Common,
  MultiLog4D.Interfaces
  {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
    {$IFDEF MSWINDOWS}
      ,Winapi.Windows
    {$ENDIF}
  {$ENDIF}
  ,MultiLog4D.Types
  ,MultiLog4D.Common.WriteToFile;

type
  TMultiLog4DWindowsFile = class(TMultiLog4DBase)
  private
    procedure WriteToFile(const AMsg: string; const ALogType: TLogType);
  protected
    procedure LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
  public
    constructor Create(const AFileName: string);
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

constructor TMultiLog4DWindowsFile.Create(const AFileName: string);
begin
  inherited Create;
  FFileName := AFileName;
end;

procedure TMultiLog4DWindowsFile.WriteToFile(const AMsg: string; const ALogType: TLogType);
begin
  TMultiLogWriteToFile.Instance
    .FileName(FFileName)
    .Execute(AMsg, ALogType);
end;

procedure TMultiLog4DWindowsFile.LogWriteToDestination(const AMsg: string; const ALogType: TLogType);
begin
  case FLogOutput of
    loFile, loBoth: WriteToFile(AMsg, ALogType);
  end;
end;

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
function TMultiLog4DWindowsFile.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FEventCategory := AEventCategory;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsFile.EventID(const AEventID: DWORD): IMultiLog4D;
begin
  FEventID := AEventID;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsFile.UserName(const AUserName: string): IMultiLog4D;
begin
  FUserName := AUserName;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsFile.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  FLogOutput := AOutput;
  Result := Self as IMultiLog4D;
end;
{$ENDIF}
{$ENDIF}

function TMultiLog4DWindowsFile.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ALogType);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsFile.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltInformation);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsFile.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltWarning);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsFile.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltError);
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DWindowsFile.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  LogWriteToDestination(AMsg, ltFatalError);
  Result := Self as IMultiLog4D;
end;

end.
