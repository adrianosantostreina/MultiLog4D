unit MultiLog4D.Base;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes,

  MultiLog4D.Types,
  MultiLog4D.Interfaces;

type
  TMultiLog4DBase = class(TInterfacedObject, IMultiLog4D)
  private

  protected
    class var FTag: string;
  public
    procedure Tag(const ATag: string); virtual; abstract;
    procedure LogWrite(const AMsg: string; const ALogType: TLogType); virtual; abstract;
    procedure LogWriteInformation(const AMsg: string); virtual; abstract;
    procedure LogWriteWarning(const AMsg: string); virtual; abstract;
    procedure LogWriteError(const AMsg: string); virtual; abstract;
    procedure LogWriteFatalError(const AMsg: string); virtual; abstract;
    procedure EventLog(const AMsg: string; AIsForceBroadcast: Boolean = False); virtual; abstract;
    procedure EventLogConsole(const AMsg: string); virtual; abstract;
  public
    // Optionally include public methods if needed
  end;

implementation

end.
