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
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_EVENTVIEWER)}
        function Category(const AEventCategory: TEventCategory): IMultiLog4D;
        {$IFDEF MSWINDOWS}
        function EventID(const AEventID: DWORD): IMultiLog4D;
        {$ENDIF}
        {$IFDEF LINUX}
        function EventID(const AEventID: LONGWORD): IMultiLog4D;
        {$ENDIF}
        {$IFDEF MACOS}
        function EventID(const AEventID: UInt32): IMultiLog4D;
        {$ENDIF}
        function UserName(const AUserName: string): IMultiLog4D;
        {$IFNDEF LINUX}
        function Output(const AOutput: TLogOutput): IMultiLog4D;
        function FileName(const AFileName: string): IMultiLog4D;
        {$ENDIF}
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


