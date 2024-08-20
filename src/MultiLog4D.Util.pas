unit MultiLog4D.Util;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes,
  {$IFDEF MSWINDOWS}
    {$IFDEF ML4D_SERVICE}
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
    {$IFDEF ML4D_SERVICE}
    class procedure SetCategory(const AEventCategory: TEventCategory); static;
    class procedure SetEventID(const AEventID: DWORD); static;
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    class procedure SetUserName(const AUserName: string); static;
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

{$IFDEF ML4D_SERVICE}

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
{$ENDIF}

{$IFDEF MSWINDOWS}
class procedure TMultiLog4DUtil.SetUserName(const AUserName: string);
begin
  if Supports(FLogger, IMultiLog4D) then
    (FLogger as IMultiLog4D).UserName(AUserName);
end;
{$ENDIF}

initialization

TMultiLog4DUtil.Create;

finalization

TMultiLog4DUtil.FLogger := nil;

end.
