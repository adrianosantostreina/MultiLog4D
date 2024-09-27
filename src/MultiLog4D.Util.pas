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
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
        class procedure SetCategory(const AEventCategory: TEventCategory); static;
        {$IFDEF MSWINDOWS}
        class procedure SetEventID(const AEventID: DWORD); static;
        {$ENDIF}
        {$IFDEF LINUX}
        class procedure SetEventID(const AEventID: LONGWORD); static;
        {$ENDIF}
        {$IFDEF MACOS}
        class procedure SetEventID(const AEventID: UInt32); static;
        {$ENDIF}
        class procedure SetUserName(const AUserName: string); static;
        {$IFNDEF LINUX}
        class procedure SetFileName(const AFileName: string); static;
        {$ENDIF}
        class procedure SetLogFormat(const AFormat: string); static;
        class procedure SetDateTimeFormat(const ADateTimeFormat: string); static;
      {$ENDIF}
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
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
class procedure TMultiLog4DUtil.SetCategory(const AEventCategory: TEventCategory);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).Category(AEventCategory);
end;

{$IFDEF MSWINDOWS}
class procedure TMultiLog4DUtil.SetEventID(const AEventID: DWORD);
{$ENDIF}
{$IFDEF LINUX}
class procedure TMultiLog4DUtil.SetEventID(const AEventID:LONGWORD);
{$ENDIF}
{$IFDEF MACOS}
class procedure TMultiLog4DUtil.SetEventID(const AEventID: UInt32);
{$ENDIF}
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).EventID(AEventID);
end;

class procedure TMultiLog4DUtil.SetUserName(const AUserName: string);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).UserName(AUserName);
end;

{$IFNDEF LINUX}
class procedure TMultiLog4DUtil.SetFileName(const AFileName: string);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).Output(TLogOutput.loFile)
      .FileName(AFileName);
end;

class procedure TMultiLog4DUtil.SetLogFormat(const AFormat: string);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).SetLogFormat(AFormat);
end;

class procedure TMultiLog4DUtil.SetDateTimeFormat(const ADateTimeFormat: string);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).SetDateTimeFormat(ADateTimeFormat);
end;
{$ENDIF}
{$ENDIF}
{$ENDIF}

initialization

TMultiLog4DUtil.Create;

finalization

TMultiLog4DUtil.FLogger := nil;

end.


