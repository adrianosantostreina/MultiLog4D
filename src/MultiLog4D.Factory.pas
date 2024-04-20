unit MultiLog4D.Factory;

interface

uses
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
    MultiLog4D.Android;
  {$ENDIF}

class constructor TLogFactory.Create;
begin
  FLogger := nil;
end;

class function TLogFactory.GetLogger: IMultiLog4D;
begin
  if not Assigned(FLogger) then
  begin
    {$IFDEF ANDROID}
      FLogger := TMultiLog4DAndroid.Create;
    {$ENDIF}
  end;
  Result := FLogger;
end;

end.
