unit MultiLog4D.Android;

interface

uses
  System.SysUtils,

  Multilog4D.Base,
  Multilog4D.Types,
  Multilog4D.Interfaces
  {$IFDEF ANDROID}
  ,Androidapi.Helpers
  ,Androidapi.JNI.JavaTypes
  ,Androidapi.JNI.Util
  ,MultiLog4D.Java.Interfaces
  {$ENDIF}
  ;

type
  TMultiLog4DAndroid = class(TMultiLog4DBase)
  public
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

function TMultiLog4DAndroid.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  case ALogType of
    ltWarning    : LogWriteWarning(AMsg);
    ltError      : LogWriteError(AMsg);
    ltFatalError : LogWriteFatalError(AMsg);
  else
    LogWriteInformation(AMsg);
  end;

  Result := Self as IMultiLog4D;
end;

function TMultiLog4DAndroid.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  {$IFDEF ANDROID}
    if FTag = EmptyStr then
      GetDefaultTag;

    TJutil_Log.JavaClass.i(StringToJString(FTag), StringToJString(AMsg));
  {$ENDIF}
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DAndroid.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  {$IFDEF ANDROID}
    if FTag = EmptyStr then
      GetDefaultTag;

    TJutil_Log.JavaClass.w(StringToJString(FTag), StringToJString(AMsg));
  {$ENDIF}
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DAndroid.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  {$IFDEF ANDROID}
    if FTag = EmptyStr then
      GetDefaultTag;

    TJutil_Log.JavaClass.e(StringToJString(FTag), StringToJString(AMsg));
  {$ENDIF}
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DAndroid.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  {$IFDEF ANDROID}
    if FTag = EmptyStr then
      GetDefaultTag;

    TJutil_Log.JavaClass.e(StringToJString(FTag), StringToJString(AMsg));
  {$ENDIF}
  Result := Self as IMultiLog4D;
end;

end.
