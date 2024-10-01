unit MultiLog4D.Factory;

interface

uses
  System.SysUtils,
  MultiLog4D.Interfaces;

type
  TLogFactory = class
  private
    class var FLogger: IMultiLog4D;
    class constructor Create;
  public
    class function GetLogger: IMultiLog4D;
  end;

implementation

uses
  {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
    {$IFDEF MSWINDOWS}
      MultiLog4D.Windows,
    {$ELSEIF DEFINED(LINUX)}
      MultiLog4D.Linux,
    {$ELSEIF DEFINED(MACOS)}
      MultiLog4D.MacOS,
    {$ENDIF}
  {$ELSE}
    {$IFDEF ANDROID}
      MultiLog4D.Android,
    {$ELSE}
      MultiLog4D.IOS,
    {$ENDIF}
  {$ENDIF}
  System.Classes;

class constructor TLogFactory.Create;
begin
  FLogger := nil;
end;

class function TLogFactory.GetLogger: IMultiLog4D;
begin
  if not Assigned(FLogger) then
  begin
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IFDEF MSWINDOWS}
        FLogger := TMultiLog4DWindows.Create(EmptyStr);
      {$ELSEIF DEFINED(LINUX)}
        FLogger := TMultiLog4DLinux.Create;
      {$ELSEIF DEFINED(MACOS)}
        FLogger := TMultiLog4DMacOS.Create;
      {$ENDIF}
    {$ELSE}
      {$IFDEF ANDROID}
        FLogger := TMultiLog4DAndroid.Create;
      {$ELSEIF DEFINED(IOS)}
        FLogger := TMultiLog4DiOS.Create;
      {$ENDIF}
    {$ENDIF}
  end;

  Result := FLogger;
end;

end.
