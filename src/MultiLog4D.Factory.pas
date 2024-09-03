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
  {$IFDEF ANDROID}
    MultiLog4D.Android,
  {$ENDIF}
  {$IFDEF IOS}
    MultiLog4D.IOS,
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    {$IFDEF ML4D_CONSOLE}
      MultiLog4D.Windows.Console,
    {$ENDIF}

    {$IFDEF ML4D_DESKTOP}
      MultiLog4D.Windows.Files,
    {$ENDIF}

    {$IFDEF ML4D_SERVICE}
      MultiLog4D.Windows.Services,
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
      //{$IFDEF MSWINDOWS}
        {$IFDEF ML4D_CONSOLE}
          FLogger := TMultiLog4DWindowsConsole.Create;
        {$ENDIF}
        {$IFDEF ML4D_DESKTOP}
          FLogger := TMultiLog4DWindowsFile.Create(EmptyStr);
        {$ENDIF}
        {$IFDEF ML4D_SERVICE}
          FLogger := TMultiLog4DWindowsServices.Create;
        {$ENDIF}
      //{$ENDIF}
    {$ELSE}
      {$IFDEF ANDROID}
        FLogger := TMultiLog4DAndroid.Create;
      {$ENDIF}
      {$IFDEF IOS}
        FLogger := TMultiLog4DiOS.Create;
      {$ENDIF}
    {$ENDIF}
  end;

(*
  if not Assigned(FLogger) then
  begin
    {$IFDEF ANDROID}
      FLogger := TMultiLog4DAndroid.Create;
    {$ENDIF}
    {$IFDEF IOS}
      FLogger := TMultiLog4DiOS.Create;
    {$ENDIF}
    //{$IFDEF MSWINDOWS}
      {$IFDEF ML4D_CONSOLE}
        FLogger := TMultiLog4DWindowsConsole.Create;
      {$ENDIF}
      {$IFDEF ML4D_DESKTOP}
        FLogger := TMultiLog4DWindowsFile.Create(EmptyStr);
      {$ENDIF}
      {$IFDEF ML4D_SERVICE}
        FLogger := TMultiLog4DWindowsServices.Create;
      {$ENDIF}
    //{$ENDIF}
  end;
*)

  Result := FLogger;
end;


end.
