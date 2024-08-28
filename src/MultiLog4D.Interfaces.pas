unit MultiLog4D.Interfaces;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes,
  {$IFDEF MSWINDOWS}
    {$IF DEFINED(ML4D_SERVICE) OR DEFINED(CONSOLE)}
      Winapi.Windows,
    {$ENDIF}
  {$ENDIF}
  MultiLog4D.Types;

type
  IMultiLog4D = interface
    ['{85313A35-9033-4179-8046-B22AD3E36E60}']
    function Tag(const ATag: string): IMultiLog4D;
    {$IF DEFINED(ML4D_SERVICE) OR DEFINED(CONSOLE)}
    function Category(const AEventCategory: TEventCategory): IMultiLog4D;
    function EventID(const AEventID: DWORD): IMultiLog4D;
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    function UserName(const AUserName: string): IMultiLog4D;
    {$ENDIF}
    function Output(const AOutput: TLogOutPut): IMultiLog4D;  // Adicionado
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
    function LogWriteInformation(const AMsg: string): IMultiLog4D;
    function LogWriteWarning(const AMsg: string): IMultiLog4D;
    function LogWriteError(const AMsg: string): IMultiLog4D;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D;
  end;

implementation

end.


(*
unit MultiLog4D.Interfaces;

interface

uses
  System.StrUtils,
  System.SysUtils,
  System.Classes,
  {$IFDEF MSWINDOWS}
    {$IF DEFINED(ML4D_SERVICE) OR DEFINED(CONSOLE)}
      Winapi.Windows,
    {$ENDIF}
  {$ENDIF}
  MultiLog4D.Types;

type
  IMultiLog4D = interface
    ['{85313A35-9033-4179-8046-B22AD3E36E60}']
    function Tag(const ATag: string): IMultiLog4D;
    {$IF DEFINED(ML4D_SERVICE) OR DEFINED(CONSOLE)}
    function Category(const AEventCategory: TEventCategory): IMultiLog4D;
    function EventID(const AEventID: DWORD): IMultiLog4D;
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    function UserName(const AUserName: string): IMultiLog4D;
    {$ENDIF}
    function LogWrite(const AMsg: string; const ALogType: TLogType): IMultiLog4D;
    function LogWriteInformation(const AMsg: string): IMultiLog4D;
    function LogWriteWarning(const AMsg: string): IMultiLog4D;
    function LogWriteError(const AMsg: string): IMultiLog4D;
    function LogWriteFatalError(const AMsg: string): IMultiLog4D;
  end;

implementation

end.
*)
