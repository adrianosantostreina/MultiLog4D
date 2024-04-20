unit MultiLog4D.Interfaces;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes,

  MultiLog4D.Types;

type
  IMultiLog4D = interface
    ['{85313A35-9033-4179-8046-B22AD3E36E60}']
    procedure Tag(const ATag: string);
    procedure LogWrite(const AMsg: string; const ALogType: TLogType);
    procedure LogWriteInformation(const AMsg: string);
    procedure LogWriteWarning(const AMsg: string);
    procedure LogWriteError(const AMsg: string);
    procedure LogWriteFatalError(const AMsg: string);
    procedure EventLog(const AMsg: string; AIsForceBroadcast: Boolean = False);
    procedure EventLogConsole(const AMsg: string);
  end;

implementation

end.
