unit MultiLog4D.Android;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,

  MultiLog4D.Interfaces,
  MultiLog4D.Types,
  MultiLog4D.Base,
  MultiLog4D.Java.Interfaces
  {$IFDEF ANDROID}
   ,Androidapi.Helpers
  {$ENDIF}
  ;

type
  TMultiLog4DAndroid = class(TMultiLog4DBase)
  private
    procedure EventLog(const AMsg: string; AIsForceBroadcast: Boolean = False); override;
    procedure EventLogConsole(const AMsg: string); override;
  public
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

procedure TMultiLog4DAndroid.EventLog(const AMsg: string; AIsForceBroadcast: Boolean);
begin
  inherited;
  EventLogConsole(AMsg);
end;

procedure TMultiLog4DAndroid.EventLogConsole(const AMsg: string);
begin
  inherited;
  {$IFDEF ANDROID}
  TJutil_Log.JavaClass.i(StringToJString(FTag), StringToJString(AMsg)); // Log como info por padrão
  {$ENDIF}
end;

function TMultiLog4DAndroid.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
var
  LMsg: string;
begin
  Result := Self as IMultiLog4D;
  LMsg := EmptyStr; //FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now) + ' '; // Add timestamp

  case ALogType of
    ltWarning:     LMsg := LMsg + 'WARNING: ' + AMsg;
    ltError:       LMsg := LMsg + 'ERROR: ' + AMsg;
    ltFatalError:  LMsg := LMsg + 'FATAL ERROR: ' + AMsg;
    else           LMsg := LMsg + 'INFO: ' + AMsg;
  end;

  EventLog(LMsg);
end;

function TMultiLog4DAndroid.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  Result := Self as IMultiLog4D;
  LogWrite(AMsg, ltInformation);
end;

function TMultiLog4DAndroid.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  Result := Self as IMultiLog4D;
  LogWrite(AMsg, ltWarning);
end;

function TMultiLog4DAndroid.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  Result := Self as IMultiLog4D;
  LogWrite(AMsg, ltError);
end;

function TMultiLog4DAndroid.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  Result := Self as IMultiLog4D;
  LogWrite(AMsg, ltFatalError);
end;

end.
