unit MultiLog4D.Util;

interface

uses
  System.SysUtils,
  System.Classes,
  {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
    {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
      Winapi.Windows,
    {$ENDIF}
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
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        class procedure SetCategory(const AEventCategory: TEventCategory); static;
        class procedure SetEventID(const AEventID: DWORD); static;
        class procedure SetUserName(const AUserName: string); static;
        class procedure SetFileName(const AFileName: string); static;
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
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
class procedure TMultiLog4DUtil.SetCategory(const AEventCategory: TEventCategory);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).Category(AEventCategory);
end;

class procedure TMultiLog4DUtil.SetEventID(const AEventID: DWORD);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).EventID(AEventID);
end;

class procedure TMultiLog4DUtil.SetUserName(const AUserName: string);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).UserName(AUserName);
end;

class procedure TMultiLog4DUtil.SetFileName(const AFileName: string);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).Output(TLogOutput.loFile)
      .FileName(AFileName);
end;
{$ENDIF}
{$ENDIF}

initialization

TMultiLog4DUtil.Create;

finalization

TMultiLog4DUtil.FLogger := nil;

end.


