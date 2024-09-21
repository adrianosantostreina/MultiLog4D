unit MultiLog4D.Setup;

interface

uses
  {$IFDEF MSWINDOWS}
    Winapi.Windows,
  {$ENDIF}
  MultiLog4D.Interfaces,
  MultiLog4D.Types;
(*
type
  TMultiLog4DSetup = class(TInterfacedObject, IMultiLog4DSetup)
  private
    FLogger: IMultiLog4D;
    FTag: string;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        FOutput: TLogOutput;
        FFileName: string;
        FUserName: string;
        FEventID: DWORD;
        FCategory: TEventCategory;
      {$ENDIF}
    {$ENDIF}
  public
    constructor Create(ALogger: IMultiLog4D);
    function Tag(const ATag: string): IMultiLog4DSetup;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        function Output(const AOutput: TLogOutput): IMultiLog4DSetup;
        function FileName(const AFileName: string): IMultiLog4DSetup;
        function UserName(const AUserName: string): IMultiLog4DSetup;
        function EventID(const AEventID: DWORD): IMultiLog4DSetup;
        function Category(const AEventCategory: TEventCategory): IMultiLog4DSetup;
      {$ENDIF}
    {$ENDIF}
    function &End: IMultiLog4D;
  end;
*)
implementation

{ TMultiLog4DSetup }
(*
constructor TMultiLog4DSetup.Create(ALogger: IMultiLog4D);
begin
  FLogger := ALogger;
end;

function TMultiLog4DSetup.Tag(const ATag: string): IMultiLog4DSetup;
begin
  FTag := ATag;
  Result := Self;
end;

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
function TMultiLog4DSetup.Output(const AOutput: TLogOutput): IMultiLog4DSetup;
begin
  FOutput := AOutput;
  Result := Self;
end;

function TMultiLog4DSetup.FileName(const AFileName: string): IMultiLog4DSetup;
begin
  FFileName := AFileName;
  Result := Self;
end;

function TMultiLog4DSetup.UserName(const AUserName: string): IMultiLog4DSetup;
begin
  FUserName := AUserName;
  Result := Self;
end;

function TMultiLog4DSetup.EventID(const AEventID: DWORD): IMultiLog4DSetup;
begin
  FEventID := AEventID;
  Result := Self;
end;

function TMultiLog4DSetup.Category(const AEventCategory: TEventCategory): IMultiLog4DSetup;
begin
  FCategory := AEventCategory;
  Result := Self;
end;
{$ENDIF}
{$ENDIF}

function TMultiLog4DSetup.&End: IMultiLog4D;
begin
  Result := FLogger;
end;
*)

end.

(*
unit MultiLog4D.Setup;

interface

uses
  {$IFDEF MSWINDOWS}
    Winapi.Windows,
  {$ENDIF}
  MultiLog4D.Interfaces,
  MultiLog4D.Types;

type
  TMultiLog4DSetup = class(TInterfacedObject, IMultiLog4DSetup)
  private
    FLogger: IMultiLog4D;
  public
    constructor Create(ALogger: IMultiLog4D);
    function Tag(const ATag: string): IMultiLog4DSetup;
    {$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
      {$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
        function Output(const AOutput: TLogOutput): IMultiLog4DSetup;
        function FileName(const AFileName: string): IMultiLog4DSetup;
        function UserName(const AUserName: string): IMultiLog4DSetup;
        function EventID(const AEventID: DWORD): IMultiLog4DSetup;
        function Category(const AEventCategory: TEventCategory): IMultiLog4DSetup;
      {$ENDIF}
    {$ENDIF}
    function &End: IMultiLog4D;
  end;

implementation

{ TMultiLog4DSetup }

constructor TMultiLog4DSetup.Create(ALogger: IMultiLog4D);
begin
  FLogger := ALogger;
end;

function TMultiLog4DSetup.Tag(const ATag: string): IMultiLog4DSetup;
begin
  // Implementação do método
  Result := Self;
end;

{$IF NOT DEFINED(ANDROID) AND NOT DEFINED(IOS)}
{$IF DEFINED(ML4D_DESKTOP) OR DEFINED(ML4D_CONSOLE) OR DEFINED(ML4D_SERVICE)}
function TMultiLog4DSetup.Output(const AOutput: TLogOutput): IMultiLog4DSetup;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DSetup.FileName(const AFileName: string): IMultiLog4DSetup;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DSetup.UserName(const AUserName: string): IMultiLog4DSetup;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DSetup.EventID(const AEventID: DWORD): IMultiLog4DSetup;
begin
  // Implementação do método
  Result := Self;
end;

function TMultiLog4DSetup.Category(const AEventCategory: TEventCategory): IMultiLog4DSetup;
begin
  // Implementação do método
  Result := Self;
end;
{$ENDIF}
{$ENDIF}

function TMultiLog4DSetup.&End: IMultiLog4D;
begin
  Result := FLogger;
end;

end.
*)

