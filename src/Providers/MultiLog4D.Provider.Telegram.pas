unit MultiLog4D.Provider.Telegram;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.JSON,
  MultiLog4D.Types,
  MultiLog4D.Provider.Interfaces,
  MultiLog4D.Provider.Base,
  MultiLog4D.Provider.REST;

type
  TMultiLog4DTelegramParseMode = (tpmPlainText, tpmMarkdown, tpmHTML);

{$I MultiLog4D.Provider.Telegram.inc}

type
  TMultiLog4DProviderTelegram = class(TMultiLog4DProviderREST)
  private
    FChatID   : string;
    FParseMode: TMultiLog4DTelegramParseMode;
    function FormatMessage(const AEntry: TMultiLog4DLogEntry): string;
    function LogTypeLabel(const ALogType: TLogType): string;
  public
    { AToken e AChatID sao OBRIGATORIOS. A biblioteca nao possui destino padrao:
      chamar Create sem informar o destino levanta EMultiLog4DConfig. }
    constructor Create(const AToken, AChatID: string);
    procedure WriteLog(const AEntry: TMultiLog4DLogEntry); override;
    property ParseMode: TMultiLog4DTelegramParseMode
      read FParseMode write FParseMode default tpmMarkdown;
  end;

implementation

constructor TMultiLog4DProviderTelegram.Create(const AToken, AChatID: string);
begin
  if AToken.Trim.IsEmpty then
    raise EMultiLog4DConfig.Create(
      'MultiLog4D: informe o token do seu bot do Telegram. ' +
      'A biblioteca nao possui um destino padrao.');

  if AChatID.Trim.IsEmpty then
    raise EMultiLog4DConfig.Create(
      'MultiLog4D: informe o chat_id de destino do Telegram. ' +
      'A biblioteca nao possui um destino padrao.');

  inherited Create(Format('https://api.telegram.org/bot%s/sendMessage', [AToken.Trim]));
  FChatID       := AChatID.Trim;
  FParseMode    := ML4D_TELEGRAM_DEFAULT_PARSE_MODE;
  LogTypeFilter := ML4D_TELEGRAM_DEFAULT_LOG_FILTER;
  AddHeader('Content-Type', 'application/json');
end;

function TMultiLog4DProviderTelegram.LogTypeLabel(const ALogType: TLogType): string;
begin
  case ALogType of
    ltInformation: Result := 'INF';
    ltWarning:     Result := 'WAR';
    ltError:       Result := 'ERR';
    ltFatalError:  Result := 'FAT';
  else
    Result := 'INF';
  end;
end;

function TMultiLog4DProviderTelegram.FormatMessage(const AEntry: TMultiLog4DLogEntry): string;
var
  LLabel    : string;
  LTimestamp: string;
begin
  LLabel     := LogTypeLabel(AEntry.LogType);
  LTimestamp := FormatDateTime('yyyy-mm-dd hh:nn:ss', AEntry.TimeStamp);

  case FParseMode of
    tpmMarkdown:
      Result := Format('*[%s]* %s'#10'%s'#10'_%s_', [LLabel, AEntry.Tag, AEntry.Message, LTimestamp]);
    tpmHTML:
      Result := Format('<b>[%s]</b> %s'#10'%s'#10'<i>%s</i>', [LLabel, AEntry.Tag, AEntry.Message, LTimestamp]);
  else
    Result := Format('[%s] %s'#10'%s'#10'%s', [LLabel, AEntry.Tag, AEntry.Message, LTimestamp]);
  end;
end;

procedure TMultiLog4DProviderTelegram.WriteLog(const AEntry: TMultiLog4DLogEntry);
var
  LHTTPClient: THTTPClient;
  LPayload   : TStringStream;
  LJSON      : TJSONObject;
  LHeaders   : TNetHeaders;
  I          : Integer;
  LHeaderPair: TPair<string, string>;
begin
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair('chat_id', FChatID);
    LJSON.AddPair('text', FormatMessage(AEntry));
    case FParseMode of
      tpmMarkdown: LJSON.AddPair('parse_mode', 'Markdown');
      tpmHTML:     LJSON.AddPair('parse_mode', 'HTML');
    end;

    LPayload := TStringStream.Create(LJSON.ToJSON, TEncoding.UTF8);
    try
      LHTTPClient := THTTPClient.Create;
      try
        SetLength(LHeaders, FHeaders.Count);
        I := 0;
        for LHeaderPair in FHeaders do
        begin
          LHeaders[I] := TNameValuePair.Create(LHeaderPair.Key, LHeaderPair.Value);
          Inc(I);
        end;
        LHTTPClient.Post(FEndpointURL, LPayload, nil, LHeaders);
      finally
        LHTTPClient.Free;
      end;
    finally
      LPayload.Free;
    end;
  finally
    LJSON.Free;
  end;
end;

end.
