unit MultiLog4D.Base;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes
  {$IFDEF ANDROID}
   ,Androidapi.Helpers
  {$ENDIF}

  ,MultiLog4D.Types,
   Winapi.Windows,
  MultiLog4D.Interfaces;

type
  TMultiLog4DBase = class(TInterfacedObject, IMultiLog4D)
  private

  protected
    class var FTag: string;
    class var FTagSet: Boolean;
    function GetDefaultTag: string;
  protected
    {$IFDEF ML4D_SERVICE}
    FEventCategory: TEventCategory;
    FEventID: DWORD;
    {$ENDIF}
    function GetCategoryName: string;
    function GetLogPrefix(const ALogType: TLogType): string;
  public
    function Tag(const ATag: string): IMultiLog4D; virtual;
    {$IFDEF ML4D_SERVICE}
    function Category(const AEventCategory: TEventCategory): IMultiLog4D;
    function EventID(const AEventID: DWORD): IMultiLog4D;
    {$ENDIF}
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; virtual; abstract;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; virtual; abstract;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; virtual; abstract;
    function LogWriteError(const AMsg: string): IMultiLog4D; virtual; abstract;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; virtual; abstract;
    class procedure ResetTag;
  end;

implementation

function TMultiLog4DBase.GetDefaultTag: string;
begin
  FTag := 'MultiLog4D';
  Result := FTag;
end;

function TMultiLog4DBase.Tag(const ATag: string): IMultiLog4D;
begin
  if (ATag <> EmptyStr) and not FTagSet then
  begin
    FTag := ATag;
    FTagSet := True;
  end;

  Result := Self as IMultiLog4D;
end;

function TMultiLog4DBase.GetCategoryName: string;
begin
  Result := EventCategoryNames[FEventCategory];
end;

{$IFDEF ML4D_SERVICE}
function TMultiLog4DBase.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FEventCategory := AEventCategory;
  Result := Self;
end;

function TMultiLog4DBase.EventID(const AEventID: DWORD): IMultiLog4D;
begin
  FEventID := AEventID;
  Result := Self;
end;
{$ENDIF}

function TMultiLog4DBase.GetLogPrefix(const ALogType: TLogType): string;
begin
  case ALogType of
    ltWarning:     Result := ' | WAR | ';
    ltError:       Result := ' | ERR | ';
    ltFatalError:  Result := ' | FAT | ';
    else           Result := ' | INF | ';
  end;
end;

class procedure TMultiLog4DBase.ResetTag;
begin
  FTag := EmptyStr;
  FTagSet := False;
end;

end.
