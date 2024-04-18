unit MultiLog4D;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes
  {$IFDEF ANDROID}
   ,Androidapi.Log
   ,Androidapi.JNI.OS
   ,Androidapi.JNI.JavaTypes
   ,Androidapi.JNIBridge
   ,Androidapi.JNI.GraphicsContentViewText
   ,Androidapi.Helpers
  {$ENDIF}
  ;

type
  {$IFDEF ANDROID}
    Jutil_LogClass = interface(JObjectClass)
      ['{62108FE8-1DBB-4C4F-A0C7-35D12BD116DC}']
      {class} function _GetASSERT: Integer; cdecl;
      {class} function _GetDEBUG: Integer; cdecl;
      {class} function _GetERROR: Integer; cdecl;
      {class} function _GetINFO: Integer; cdecl;
      {class} function _GetVERBOSE: Integer; cdecl;
      {class} function _GetWARN: Integer; cdecl;
      {class} function d(tag: JString; msg: JString): Integer; cdecl; overload;
      {class} function d(tag: JString; msg: JString; tr: JThrowable): Integer; cdecl; overload;
      {class} function e(tag: JString; msg: JString): Integer; cdecl; overload;
      {class} function e(tag: JString; msg: JString; tr: JThrowable): Integer; cdecl; overload;
      {class} function getStackTraceString(tr: JThrowable): JString; cdecl;
      {class} function i(tag: JString; msg: JString): Integer; cdecl; overload;
      {class} function i(tag: JString; msg: JString; tr: JThrowable): Integer; cdecl; overload;
      {class} function isLoggable(tag: JString; level: Integer): Boolean; cdecl;
      {class} function println(priority: Integer; tag: JString; msg: JString): Integer; cdecl;
      {class} function v(tag: JString; msg: JString): Integer; cdecl; overload;
      {class} function v(tag: JString; msg: JString; tr: JThrowable): Integer; cdecl; overload;
      {class} function w(tag: JString; msg: JString): Integer; cdecl; overload;
      {class} function w(tag: JString; msg: JString; tr: JThrowable): Integer; cdecl; overload;
      {class} function w(tag: JString; tr: JThrowable): Integer; cdecl; overload;
      {class} function wtf(tag: JString; msg: JString): Integer; cdecl; overload;
      {class} function wtf(tag: JString; tr: JThrowable): Integer; cdecl; overload;
      {class} function wtf(tag: JString; msg: JString; tr: JThrowable): Integer; cdecl; overload;
      {class} property ASSERT: Integer read _GetASSERT;
      {class} property DEBUG: Integer read _GetDEBUG;
      {class} property ERROR: Integer read _GetERROR;
      {class} property INFO: Integer read _GetINFO;
      {class} property VERBOSE: Integer read _GetVERBOSE;
      {class} property WARN: Integer read _GetWARN;
    end;

    [JavaSignature('android/util/Log')]
    Jutil_Log = interface(JObject)
      ['{6A5EC34E-CB76-4AB0-A11D-7CCB3B40C571}']
    end;
    TJutil_Log = class(TJavaGenericImport<Jutil_LogClass, Jutil_Log>) end;
  {$ENDIF}

  //I - Info
  //W - Warning
  //E - Error
  //F - Fatal
  TLogType = (ltInformation, ltWarning, ltError, ltFatalError);

  TMultiLog4D = class
  private
    class var FTag : string;
    class function GetPackageName: string;
    class procedure EventLog(AMsg: string; AIsForceBraodCast: Boolean = False);
    class procedure EventLogConsole(AMsg: string);
  public
    class procedure LogWrite(const AMsg: string; const ALogType: TLogType);
    class procedure LogWriteInformation(const AMsg: string);
    class procedure LogWriteWarning(const AMsg: string);
    class procedure LogWriteError(const AMsg: string);
    class procedure LogWriteFatalError(const AMsg: string);
    class procedure Tag(const ATag: string);
  end;

implementation

class function TMultiLog4D.GetPackageName: string;
begin
//  Result := JStringToString(TAndroidHelper.Context.getPackageName);
end;

class procedure TMultiLog4D.EventLog(AMsg: string; AIsForceBraodCast: Boolean);
begin
  EventLogConsole(AMsg);
end;

class procedure TMultiLog4D.EventLogConsole(AMsg: string);
begin
  {$IFDEF ANDROID}
  TJutil_Log.JavaClass.d(StringToJString(FTag), StringToJString(AMsg));
  {$ENDIF}
end;

class procedure TMultiLog4D.LogWrite(const AMsg: string; const ALogType: TLogType);
var
  LMsg: string;
  LPathFile: string;
  LFileName: string;
begin
  LMsg := EmptyStr;

  case ALogType of
    ltWarning:
      LMsg := 'WARNING: ';
    ltError:
      LMsg := 'ERROR: ';
    ltFatalError:
      LMsg:= 'FATAL ERROR: ';
  end;

  LMsg := LMsg + FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now) + ' ' + AMsg;
//  LFileName := FormatDateTime('yyyymmdd', Now) + '.log';
//  LPathFile := TUtils.GetApplicationPath;
//  LPathFile := TUtils.Combine(LPathFile, ['Log']);

//  if not(DirectoryExists(LPathFile)) then
//    ForceDirectories(LPathFile);

//  LPathFile := TUtils.Combine(LPathFile, [LFileName]);


  EventLog(LMsg);

//  TFile.AppendAllText(LPathFile, LMsg, TEncoding.UTF8);
end;

class procedure TMultiLog4D.LogWriteError(const AMsg: string);
begin
  LogWrite(AMsg, TLogType.ltError);
end;

class procedure TMultiLog4D.LogWriteInformation(const AMsg: string);
begin
  LogWrite(AMsg, TLogType.ltInformation)
end;

class procedure TMultiLog4D.LogWriteWarning(const AMsg: string);
begin
  LogWrite(AMsg, TLogType.ltWarning)
end;

class procedure TMultiLog4D.Tag(const ATag: string);
begin
  if not ATag.IsEmpty
  then FTag := ATag
  else FTag := 'TMultiLog4D';
end;

class procedure TMultiLog4D.LogWriteFatalError(const AMsg: string);
begin
  LogWrite(AMsg, TLogType.ltFatalError);
end;

//teste


end.



