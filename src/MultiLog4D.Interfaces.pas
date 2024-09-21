unit MultiLog4D.Interfaces;

interface

uses
  System.StrUtils,
  System.SysUtils,
  {$IFDEF MSWINDOWS}
    Winapi.Windows,
  {$ENDIF}
  System.Classes,
  {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
  {$ENDIF}
  MultiLog4D.Types;

type
  IMultiLog4D = interface
    ['{85313A35-9033-4179-8046-B22AD3E36E60}']
    function Tag(const ATag: string): IMultiLog4D;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        function Category(const AEventCategory: TEventCategory): IMultiLog4D;
        function EventID(const AEventID: {$IFDEF MSWINDOWS}DWORD{$ENDIF}{$IFDEF LINUX}LONGWORD{$ENDIF}): IMultiLog4D;
        function UserName(const AUserName: string): IMultiLog4D;
        function Output(const AOutput: TLogOutput): IMultiLog4D;
        function FileName(const AFileName: string): IMultiLog4D;
      {$ENDIF}
    {$ENDIF}
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
    function LogWriteInformation(const AMsg: string): IMultiLog4D;
    function LogWriteWarning(const AMsg: string): IMultiLog4D;
    function LogWriteError(const AMsg: string): IMultiLog4D;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D;
  end;

implementation

end.


