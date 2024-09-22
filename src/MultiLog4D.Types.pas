unit MultiLog4D.Types;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes;

type
  TLogType = (ltInformation, ltWarning, ltError, ltFatalError);
  TEventCategory = (ecNone, ecApplication, ecSecurity, ecPerformance, ecError,
    ecWarning, ecDebug, ecTransaction, ecNetwork);
  TLogOutPut = (loBoth, {$IFDEF MSWINDOWS}loConsole,{$ENDIF} loFile, {$IFDEF MSWINDOWS}loEventViewer{$ENDIF}{$IFDEF LINUX}loSysLog{$ENDIF});

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
