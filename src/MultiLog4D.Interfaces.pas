unit MultiLog4D.Interfaces;

interface

uses
  System.StrUtils,
  System.SysUtils,
  {$IFDEF MSWINDOWS}
    Winapi.Windows,
  {$ENDIF}
  {$IFDEF MACOS}
    Macapi.CoreFoundation,
  {$ENDIF}
  System.Classes,
  MultiLog4D.Types;

type
  IMultiLog4D = interface
    ['{85313A35-9033-4179-8046-B22AD3E36E60}']
    function Tag(const ATag: string): IMultiLog4D;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(MSWINDOWS)}
        function Category(const AEventCategory: TEventCategory): IMultiLog4D;
        function EventID(const AEventID: DWORD): IMultiLog4D;
        function Output(const AOutput: TLogOutputSet): IMultiLog4D;
        function FileName(const AFileName: string): IMultiLog4D;
        function SetLogFormat(const AFormat: string): IMultiLog4D;
        function SetDateTimeFormat(const AFormat: string): IMultiLog4D;
      {$ENDIF}
      {$IFDEF LINUX}
        function EventID(const AEventID: LONGWORD): IMultiLog4D;
      {$ENDIF}
      {$IFDEF MACOS}
        function EventID(const AEventID: UInt32): IMultiLog4D;
      {$ENDIF}
      function UserName(const AUserName: string): IMultiLog4D;
    {$ENDIF}
    function EnableLog(const AEnable: Boolean = True): IMultiLog4D;
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
    function LogWriteInformation(const AMsg: string): IMultiLog4D;
    function LogWriteWarning(const AMsg: string): IMultiLog4D;
    function LogWriteError(const AMsg: string): IMultiLog4D;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D;
  end;

implementation

end.


