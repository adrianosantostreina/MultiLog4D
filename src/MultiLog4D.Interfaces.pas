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
    function Tag(const ATag: string): IMultiLog4D;
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
    function LogWriteInformation(const AMsg: string): IMultiLog4D;
    function LogWriteWarning(const AMsg: string): IMultiLog4D;
    function LogWriteError(const AMsg: string): IMultiLog4D;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D;
    procedure EventLog(const AMsg: string; AIsForceBroadcast: Boolean = False);
    procedure EventLogConsole(const AMsg: string);
  end;

implementation

end.
