unit MultiLog4D.Util;

interface

uses
  System.SysUtils,
  System.Classes,
  {$IFDEF MSWINDOWS}
  Winapi.Windows,
  {$ENDIF}
  MultiLog4D.Interfaces,
  MultiLog4D.Factory,
  MultiLog4D.Types;

type
  TMultiLog4DUtil = class
  private
    class var FLogger: IMultiLog4D;
    class constructor Create;
  public
    class function Logger: IMultiLog4D; static;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
    {$IF DEFINED(MSWINDOWS)}
    class procedure SetCategory(const AEventCategory: TEventCategory); static;
    class procedure SetFileName(const AFileName: string); static;
    class procedure SetEventID(const AEventID: {$IFDEF MSWINDOWS}DWORD{$ELSE}LONGWORD{$ENDIF}); static;
    class procedure SetLogFormat(const AFormat: string); static;
    class procedure SetDateTimeFormat(const ADateTimeFormat: string); static;
    {$ENDIF}
    class procedure SetUserName(const AUserName: string); static;
    class procedure SetEnableLog(const AEnableLog: Boolean = True); static;
    {$ENDIF}
  end;

implementation

class constructor TMultiLog4DUtil.Create;
begin
  FLogger := TLogFactory.GetLogger;
end;

class function TMultiLog4DUtil.Logger: IMultiLog4D;
begin
  Result := FLogger;
end;

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
{$IF DEFINED(MSWINDOWS)}
class procedure TMultiLog4DUtil.SetCategory(const AEventCategory: TEventCategory);
begin
  if Assigned(FLogger) then
    FLogger.Category(AEventCategory);
end;

class procedure TMultiLog4DUtil.SetEventID(const AEventID: {$IFDEF MSWINDOWS}DWORD{$ELSE}LONGWORD{$ENDIF});
begin
  if Assigned(FLogger) then
    FLogger.EventID(AEventID);
end;

class procedure TMultiLog4DUtil.SetFileName(const AFileName: string);
begin
  if Assigned(FLogger) then
    FLogger.Output([loFile])
      .FileName(AFileName);
end;

class procedure TMultiLog4DUtil.SetLogFormat(const AFormat: string);
begin
  if Assigned(FLogger) then
    FLogger.SetLogFormat(AFormat);
end;

class procedure TMultiLog4DUtil.SetDateTimeFormat(const ADateTimeFormat: string);
begin
  if Assigned(FLogger) then
    FLogger.SetDateTimeFormat(ADateTimeFormat);
end;

{$ENDIF}
class procedure TMultiLog4DUtil.SetUserName(const AUserName: string);
begin
  if Assigned(FLogger) then
    FLogger.UserName(AUserName);
end;

class procedure TMultiLog4DUtil.SetEnableLog(const AEnableLog: Boolean = True);
begin
  if Assigned(FLogger) then
    FLogger.EnableLog(AEnableLog);
end;
{$ENDIF}

initialization
TMultiLog4DUtil.Create;

finalization
TMultiLog4DUtil.FLogger := nil;

end.


