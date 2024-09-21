program Console_MultiLog4D;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  MultiLog4D.Util,
  MultiLog4D.Types,
  System.IOUtils,
  System.SysUtils;

procedure ShowMenu;
begin
  Writeln('Choose number to print log message');
  Writeln('1. LogWrite');
  Writeln('2. LogWrite Information');
  Writeln('3. LogWrite Warning');
  Writeln('4. LogWrite Error');
  Writeln('5. LogWrite Fatal Error');
  Writeln('0. Exit');
end;

procedure ExecuteOption(const AOption: Integer);
begin
  case AOption of
    1: TMultiLog4DUtil
      .Logger
      .LogWrite('LogWrite using ltInformation. Set TLogType on second parameter.', ltInformation);
    2: TMultiLog4DUtil.Logger.LogWriteInformation('LogWrite Information');
    3: TMultiLog4DUtil.Logger.LogWriteWarning('LogWrite Warning');
    4: TMultiLog4DUtil.Logger.LogWriteError('LogWrite Error');
    5: TMultiLog4DUtil.Logger.LogWriteFatalError('LogWrite FataError');
  else
    Writeln('Invalid Option. Try again.');
  end;
end;

procedure PauseForUser;
begin
  Writeln('Press any key to continue...');
  Readln;
end;

var
  UserInput: Integer;
begin
  try
    TMultiLog4DUtil
     .Logger
     .Tag('MultiLog4D')
     .Output(loBoth)
     .LogWrite('>>>>>>>>>> Starting <<<<<<<<<', ltInformation);

    repeat
      ShowMenu;
      Readln(UserInput);
      if UserInput <> 0 then
      begin
        ExecuteOption(UserInput);
        PauseForUser;
      end;
    until UserInput = 0;

  finally

  end;
end.

