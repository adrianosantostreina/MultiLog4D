unit MultiLog4D.Types;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes;

type
  TLogType = (ltInformation, ltWarning, ltError, ltFatalError);
  TLogTypeFilter = set of TLogType;
  TEventCategory = (ecNone, ecApplication, ecSecurity, ecPerformance, ecError,
    ecWarning, ecDebug, ecTransaction, ecNetwork);

//  {$IFDEF MSWINDOWS}
//  TLogOutPut = (loBoth, loConsole, loFile, loEventViewer);
//  {$ENDIF}

  {$IFDEF MSWINDOWS}
  TLogOutput = (loConsole, loFile, loEventViewer);
  TLogOutputSet = set of TLogOutput;
  {$ENDIF}

  { Levantada quando um provider e instanciado sem a configuracao obrigatoria
    (token, chave, endpoint, destino). A biblioteca nao possui destinos padrao:
    configuracao ausente falha alto, nunca envia para um lugar arbitrario. }
  EMultiLog4DConfig = class(Exception);

const
  EventCategoryNames: array[TEventCategory] of string = (
    'None',
    'Application',
    'Security',
    'Performance',
    'Error',
    'Warning',
    'Debug',
    'Transaction',
    'Network'
  );

implementation

end.
