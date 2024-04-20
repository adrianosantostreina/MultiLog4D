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
  MultiLog4D.Interfaces;

type
  TMultiLog4DBase = class(TInterfacedObject, IMultiLog4D)
  private

  protected
    class var FTag: string;
    class var FTagSet: Boolean;
    function GetDefaultTag: string;
  public
    function Tag(const ATag: string): IMultiLog4D; virtual;

    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; virtual; abstract;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; virtual; abstract;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; virtual; abstract;
    function LogWriteError(const AMsg: string): IMultiLog4D; virtual; abstract;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; virtual; abstract;

    procedure EventLog(const AMsg: string; AIsForceBroadcast: Boolean = False); virtual; abstract;
    procedure EventLogConsole(const AMsg: string); virtual; abstract;
    class procedure ResetTag;
  end;

implementation

function TMultiLog4DBase.GetDefaultTag: string;
begin
  {$IFDEF MSWINDOWS}
    Result := TPath.GetFileNameWithoutExtension(ParamStr(0)); // Nome do executável
  {$ENDIF}

  {$IFDEF ANDROID}
    Result := JStringToString(TAndroidHelper.Context.getPackageName); // Nome do pacote no Android
  {$ENDIF}

  {$IFDEF IOS}
    Result := 'MultiLog4D'; // Pode precisar de ajuste para obter informações específicas do iOS
  {$ENDIF}

  {$IFDEF MACOS}
    Result := 'MultiLog4D'; // Pode precisar de ajuste para macOS
  {$ENDIF}

  {$IFDEF LINUX}
    Result := 'MultiLog4D'; // Pode precisar de ajuste para Linux
  {$ENDIF}

  if Result.IsEmpty then
    Result := 'MultiLog4D'; // Nome padrão se todas as outras falhas
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

class procedure TMultiLog4DBase.ResetTag;
begin
  FTag := EmptyStr;
  FTagSet := False;
end;



end.
