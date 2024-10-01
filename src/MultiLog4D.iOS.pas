unit MultiLog4D.iOS;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,

  MultiLog4D.Interfaces,
  MultiLog4D.Types,
  MultiLog4D.Base
{$IFDEF IOS}
  ,iOSapi.Foundation
  ,Macapi.Helpers
{$ENDIF}
  ;

type
  TMultiLog4DiOS = class(TMultiLog4DBase)
  private
  public
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D; override;
    function LogWriteInformation(const AMsg: string): IMultiLog4D; override;
    function LogWriteWarning(const AMsg: string): IMultiLog4D; override;
    function LogWriteError(const AMsg: string): IMultiLog4D; override;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D; override;
  end;

implementation

function TMultiLog4DiOS.LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  case ALogType of
    ltWarning:     LogWriteWarning(AMsg);
    ltError:       LogWriteError(AMsg);
    ltFatalError:  LogWriteFatalError(AMsg);
    else           LogWriteInformation(AMsg);
  end;
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DiOS.LogWriteInformation(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  {$IFDEF IOS}
    NSLog(StringToID(FTag + GetLogPrefix(ltInformation) + AMsg));
  {$ENDIF}
  Result := Self as IMultiLog4D;
end;

function TMultiLog4DiOS.LogWriteWarning(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  {$IFDEF IOS}
    NSLog(StringToID(FTag + GetLogPrefix(ltWarning) + AMsg));
  {$ENDIF}

  Result := Self as IMultiLog4D;
end;

function TMultiLog4DiOS.LogWriteError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  {$IFDEF IOS}
    NSLog(StringToID(FTag + GetLogPrefix(ltError) + AMsg));
  {$ENDIF}

  Result := Self as IMultiLog4D;
end;

function TMultiLog4DiOS.LogWriteFatalError(const AMsg: string): IMultiLog4D;
begin
  if not FEnableLog then
    Exit(Self);

  {$IFDEF IOS}
    NSLog(StringToID(FTag + GetLogPrefix(ltFatalError) + AMsg));
  {$ENDIF}

  Result := Self as IMultiLog4D;
end;


end.
