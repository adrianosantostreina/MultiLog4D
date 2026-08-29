{ ============================================================
  MultiLog4D.Provider.Telegram.inc

  Defaults de COMPORTAMENTO do provider Telegram.

  ATENCAO: este arquivo NAO contem, e nao deve conter, credenciais.
  Token e chat_id sao parametros obrigatorios do construtor e devem vir
  da configuracao da SUA aplicacao (arquivo .ini/.json, variavel de
  ambiente, cofre de segredos) - nunca de uma constante da biblioteca.

    TMultiLog4DProviderTelegram.Create(SEU_TOKEN, SEU_CHAT_ID);

  Obtendo as credenciais:
    TOKEN  : Converse com @BotFather no Telegram -> /newbot
    CHAT_ID: Use @userinfobot no grupo/canal, ou acesse
             https://api.telegram.org/bot[TOKEN]/getUpdates
  ============================================================ }

const
  ML4D_TELEGRAM_DEFAULT_PARSE_MODE = tpmMarkdown;
  ML4D_TELEGRAM_DEFAULT_LOG_FILTER = [ltWarning, ltError, ltFatalError];
