unit Main;

interface

uses
  MultiLog4D.Util,
  MultiLog4D.Types,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.SvcMgr,
  Vcl.Dialogs;

type
  TService2 = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  Service2: TService2;

implementation

{$R *.dfm}


procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service2.Controller(CtrlCode);
end;

function TService2.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TService2.ServiceAfterInstall(Sender: TService);
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('After Install');
end;

procedure TService2.ServiceAfterUninstall(Sender: TService);
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('After UnInstall');
end;

procedure TService2.ServiceBeforeInstall(Sender: TService);
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('Before Install');
end;

procedure TService2.ServiceBeforeUninstall(Sender: TService);
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('Before UnInstall');
end;

procedure TService2.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('Continue');
  Continued := True;
end;

procedure TService2.ServiceExecute(Sender: TService);
var
  X: Integer;
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('Service Executing');
  X := 0;
  while not Terminated do
  begin
    Inc(X);
    ServiceThread.ProcessRequests(True);
    Sleep(1000);
  end;
end;

procedure TService2.ServicePause(Sender: TService; var Paused: Boolean);
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('Pause');
  Paused := True;
end;

procedure TService2.ServiceStart(Sender: TService; var Started: Boolean);
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('Start');
  Started := True;
end;

procedure TService2.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('Stop');
  Stopped := True;
end;

end.
