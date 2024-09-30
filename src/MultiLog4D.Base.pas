unit MultiLog4D.Base;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes
  {$IFDEF MSWINDOWS}
    ,Winapi.Windows
  {$ENDIF}
  {$IFDEF ANDROID}
    ,Androidapi.Helpers
  {$ENDIF}
  {$IFDEF MACOS}
    ,Macapi.CoreFoundation
  {$ENDIF}
  ,MultiLog4D.Types,
  MultiLog4D.Common,
  MultiLog4D.Interfaces;

type
  TMultiLog4DBase = class(TInterfacedObject, IMultiLog4D)
  private

  protected
    {$IFDEF MSWINDOWS}
    class var FLogOutput: TLogOutputSet;
    {$ENDIF}
    class var FTag: string;
    class var FTagSet: Boolean;
    class var FEnableLog : Boolean;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(MSWINDOWS)}
          FFileName: string;
          FEventCategory: TEventCategory;
          FLogFormat : string;
          FDateTimeFormat: string;
      {$ENDIF}
      FUserName: string;
      FEventID: {$IFDEF MSWINDOWS}DWORD{$ENDIF}{$IFDEF LINUX}LONGWORD{$ENDIF}{$IFDEF MACOS}UInt32{$ENDIF};
    {$ENDIF}
    function GetDefaultTag: string;
    function GetLogPrefix(const ALogType: TLogType): string;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(MSWINDOWS)}
        function GetCategoryName: string;
      {$ENDIF}
    {$ENDIF}
  public
    function Tag(const ATag: string): IMultiLog4D; virtual;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(MSWINDOWS)}
        function Category(const AEventCategory: TEventCategory): IMultiLog4D; virtual;
        function EventID(const AEventID: DWORD): IMultiLog4D; virtual;
        function Output(const AOutput: TLogOutputSet): IMultiLog4D; virtual;
        function FileName(const AFileName: string): IMultiLog4D; virtual;
        function SetLogFormat(const AFormat: string): IMultiLog4D; virtual;
        function SetDateTimeFormat(const ADateTimeFormat: string): IMultiLog4D; virtual;
      {$ENDIF}
      {$IFDEF LINUX}
        function EventID(const AEventID: LONGWORD): IMultiLog4D; virtual;
      {$ENDIF}
      {$IFDEF MACOS}
        function EventID(const AEventID: UInt32): IMultiLog4D; virtual;
      {$ENDIF}
      function UserName(const AUserName: string): IMultiLog4D; virtual;
      function EnableLog(const AEnable: Boolean = True): IMultiLog4D; virtual;
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
{$IF DEFINED(MSWINDOWS)}
function TMultiLog4DBase.GetCategoryName: string;
begin
  Result := EventCategoryNames[FEventCategory];
end;

function TMultiLog4DBase.Category(const AEventCategory: TEventCategory): IMultiLog4D;
begin
  FEventCategory := AEventCategory;
  Result := Self as IMultiLog4D;
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
function TMultiLog4DBase.EventID(const AEventID: DWORD): IMultiLog4D;
{$ENDIF}
{$IFDEF LINUX}
function TMultiLog4DBase.EventID(const AEventID: LONGWORD): IMultiLog4D;
{$ENDIF}
{$IFDEF MACOS}
function TMultiLog4DBase.EventID(const AEventID: UInt32): IMultiLog4D;
{$ENDIF}
begin
  FEventID := AEventID;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DBase.UserName(const AUserName: string): IMultiLog4D;
begin
  if not AUserName.IsEmpty then
    FUserName := AUserName
  else
    FUserName := TMultiLog4DCommon.GetCurrentUserName;

  Result := Self as IMultiLog4D;
end;

function TMultiLog4DBase.EnableLog(const AEnable: Boolean = True): IMultiLog4D;
begin
  FEnableLog := AEnable;
  Result := Self as IMultiLog4D;
end;

{$IFDEF MSWINDOWS}
function TMultiLog4DBase.Output(const AOutput: TLogOutputSet): IMultiLog4D;
begin
  FLogOutput := AOutput;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DBase.FileName(const AFileName: string): IMultiLog4D;
begin
  FFileName := AFileName;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DBase.SetLogFormat(const AFormat: string): IMultiLog4D;
begin
  FLogFormat := AFormat;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DBase.SetDateTimeFormat(const ADateTimeFormat: string): IMultiLog4D;
begin
  FDateTimeFormat := ADateTimeFormat;
  Result := Self as IMultiLog4D;
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
