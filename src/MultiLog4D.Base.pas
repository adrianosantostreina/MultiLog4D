unit MultiLog4D.Base;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes
  {$IFDEF ANDROID}
    ,Androidapi.Helpers
  {$ENDIF}
  {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
    {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
      ,Winapi.Windows
    {$ENDIF}
  {$ENDIF}
  ,MultiLog4D.Types,
  MultiLog4D.Common,
  MultiLog4D.Interfaces;

type
  TMultiLog4DBase = class(TInterfacedObject, IMultiLog4D)
  private

  protected
    class var FLogOutput: TLogOutput;
    class var FTag: string;
    class var FTagSet: Boolean;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        FUserName: string;
        FFileName: string;
        FEventCategory: TEventCategory;
        FEventID: DWORD;
      {$ENDIF}
    {$ENDIF}
    function GetDefaultTag: string;
    function GetLogPrefix(const ALogType: TLogType): string;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        function GetCategoryName: string;
      {$ENDIF}
    {$ENDIF}
  public
    function Tag(const ATag: string): IMultiLog4D; virtual;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        function Category(const AEventCategory: TEventCategory): IMultiLog4D; virtual;
        function EventID(const AEventID: DWORD): IMultiLog4D; virtual;
        function Output(const AOutput: TLogOutput): IMultiLog4D; virtual;
        function UserName(const AUserName: string): IMultiLog4D; virtual;
        function FileName(const AFileName: string): IMultiLog4D; virtual;
      {$ENDIF}
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

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
function TMultiLog4DBase.GetCategoryName: string;
begin
  Result := EventCategoryNames[FEventCategory];
end;

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

function TMultiLog4DBase.Output(const AOutput: TLogOutput): IMultiLog4D;
begin
  FLogOutput := AOutput;
  Result := Self;
end;

function TMultiLog4DBase.UserName(const AUserName: string): IMultiLog4D;
begin
  if not AUserName.IsEmpty then
    FUserName := AUserName
  else
    FUserName := TMultiLog4DCommon.GetCurrentUserName;

  Result := Self;
end;

function TMultiLog4DBase.FileName(const AFileName: string): IMultiLog4D;
begin
  FFileName := AFileName;
  Result := Self;
end;
{$ENDIF}
{$ENDIF}

function TMultiLog4DBase.GetLogPrefix(const ALogType: TLogType): string;
begin
  case ALogType of
    ltWarning:     Result := 'WAR';
    ltError:       Result := 'ERR';
    ltFatalError:  Result := 'FAT';
    else           Result := 'INF';
  end;
end;

class procedure TMultiLog4DBase.ResetTag;
begin
  FTag := EmptyStr;
  FTagSet := False;
end;

end.
