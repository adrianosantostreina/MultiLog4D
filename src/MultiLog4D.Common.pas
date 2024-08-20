unit MultiLog4D.Common;

interface

uses
  System.Classes,
  System.StrUtils,
  System.SysUtils
  {$IFDEF MSWINDOWS}
    ,Winapi.Windows
  {$ENDIF}
  ;

type
  TMultiLog4DCommon = class
    private

    public
      {$IFDEF MSWINDOWS}
      class function GetCurrentUserName: string;
      {$ENDIF}
  end;

implementation

{$IFDEF MSWINDOWS}
class function TMultiLog4DCommon.GetCurrentUserName: string;
var
  Buffer: array[0..255] of Char;
  Size: DWORD;
begin
  Size := SizeOf(Buffer);
  if GetUserName(Buffer, Size) then
    Result := Buffer
  else
    Result := 'Unknown';
end;
{$ENDIF}

end.
