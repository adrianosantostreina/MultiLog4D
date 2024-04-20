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
    procedure Tag(const ATag: string); override;
    procedure LogWrite(const AMsg: string; const ALogType: TLogType); override;
    procedure LogWriteInformation(const AMsg: string); override;
    procedure LogWriteWarning(const AMsg: string); override;
    procedure LogWriteError(const AMsg: string); override;
    procedure LogWriteFatalError(const AMsg: string); override;
  end;

implementation

procedure TMultiLog4DAndroid.Tag(const ATag: string);
begin
  FTag := ATag;
end;

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

procedure TMultiLog4DAndroid.LogWrite(const AMsg: string; const ALogType: TLogType);
var
  LMsg: string;
begin
  LMsg := EmptyStr; //FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now) + ' '; // Add timestamp

  case ALogType of
    ltWarning:     LMsg := LMsg + 'WARNING: ' + AMsg;
    ltError:       LMsg := LMsg + 'ERROR: ' + AMsg;
    ltFatalError:  LMsg := LMsg + 'FATAL ERROR: ' + AMsg;
    else           LMsg := LMsg + 'INFO: ' + AMsg;
  end;

  EventLog(LMsg);
end;

procedure TMultiLog4DAndroid.LogWriteInformation(const AMsg: string);
begin
  LogWrite(AMsg, ltInformation);
end;

procedure TMultiLog4DAndroid.LogWriteWarning(const AMsg: string);
begin
  LogWrite(AMsg, ltWarning);
end;

procedure TMultiLog4DAndroid.LogWriteError(const AMsg: string);
begin
  LogWrite(AMsg, ltError);
end;

procedure TMultiLog4DAndroid.LogWriteFatalError(const AMsg: string);
begin
  LogWrite(AMsg, ltFatalError);
end;

end.
