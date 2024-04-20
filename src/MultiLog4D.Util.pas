unit MultiLog4D.Util;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes,
  MultiLog4D.Interfaces,
  MultiLog4D.Factory;

type
  TMultiLog4DUtil = class
  private
    class var FLogger: IMultiLog4D;
    class constructor Create;
  public
    class function Logger: IMultiLog4D; static;
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

initialization
  TMultiLog4DUtil.Create;

finalization
  TMultiLog4DUtil.FLogger := nil;

end.
