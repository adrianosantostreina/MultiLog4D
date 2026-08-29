# Changelog

Todas as mudanças relevantes deste projeto são documentadas aqui.
O formato segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e o
versionamento segue [SemVer](https://semver.org/lang/pt-BR/).

---

## [2.0.0] - 2026-08-29

### ⚠️ Aviso de segurança — provider Telegram

**Versão afetada: 1.2.5** (única release que continha o provider Telegram).

A v1.2.5 embutia, no próprio código da biblioteca
(`src/Providers/MultiLog4D.Provider.Telegram.inc`), um **token de bot e um chat_id
de terceiros**, usados como valores padrão do construtor:

```pascal
constructor Create(
  const AToken  : string = ML4D_TELEGRAM_DEFAULT_TOKEN;
  const AChatID : string = ML4D_TELEGRAM_DEFAULT_CHAT_ID);
```

**Impacto.** Qualquer aplicação que instanciasse
`TMultiLog4DProviderTelegram.Create` **sem argumentos** passava a enviar seus logs
para esse destino embutido — um chat de Telegram de terceiros — **sem qualquer
erro, aviso ou indício**. O caso foi observado em produção, em aparelho de
usuário final, com os logs de erro chegando ao chat "BEST CASINO MINI-APP
@Xstakerobot".

São dois defeitos somados:

1. **Credencial commitada no repositório.** Qualquer pessoa com acesso ao código
   controlava o bot e lia o chat.
2. **Default silencioso perigoso.** Esquecer de configurar o destino não gerava
   erro: gerava envio para o lugar errado. Falta de configuração precisa falhar
   alto.

**O que fazer se você usou a v1.2.5:**

1. **Atualize para a 2.0.0 imediatamente.**
2. **Revise o que foi exposto.** Considere vazado todo conteúdo de log enviado ao
   Telegram sem destino explícito — mensagens de erro, stack traces, dados de
   usuário, identificadores de sessão, nomes de máquina.
3. **Se você reutilizou o token que vinha no `.inc` em qualquer lugar, ele está
   comprometido.** Revogue-o no [@BotFather](https://t.me/BotFather) com `/revoke`
   e crie um bot próprio.

**O token exposto foi revogado no @BotFather e não autentica mais.** Essa é a
medida que efetivamente resolve: o token permanece no histórico do Git — clones e
forks anteriores a esta correção seguem com ele — e removê-lo do HEAD não o
invalidaria.

Consequência prática: uma aplicação ainda rodando a v1.2.5 e apoiada no destino
padrão simplesmente **deixa de entregar** os logs (a Bot API passa a responder
`401 Unauthorized`). O provider não levanta exceção nesse caso — a resposta HTTP
não é checada —, então a falha é silenciosa. Atualize para a 2.0.0 e configure um
bot próprio.

### Changed — BREAKING

- **`TMultiLog4DProviderTelegram.Create` não tem mais valores padrão.** A
  assinatura passou a ser `Create(const AToken, AChatID: string)`. Chamadas
  `TMultiLog4DProviderTelegram.Create` **sem argumentos deixam de compilar** — a
  quebra é **proposital**: quem não informa o destino precisa parar e decidi-lo.
- Token ou chat_id vazio (ou só espaços) levanta `EMultiLog4DConfig` com mensagem
  explicando o que falta. Token e chat_id passam por `Trim`.

**Migração:**

```pascal
// Antes (1.2.5) - enviava para o destino embutido:
LProvider := TMultiLog4DProviderTelegram.Create;

// Agora (2.0.0) - destino obrigatório, vindo da SUA configuração:
LProvider := TMultiLog4DProviderTelegram.Create(SEU_TOKEN, SEU_CHAT_ID);
```

### Removed

- Constantes `ML4D_TELEGRAM_DEFAULT_TOKEN` e `ML4D_TELEGRAM_DEFAULT_CHAT_ID` de
  `src/Providers/MultiLog4D.Provider.Telegram.inc`. O arquivo agora guarda apenas
  defaults de comportamento (`ML4D_TELEGRAM_DEFAULT_PARSE_MODE` e
  `ML4D_TELEGRAM_DEFAULT_LOG_FILTER`) e **nenhuma credencial**.
- Token e chat_id que vinham pré-preenchidos nos campos do sample desktop
  (`Samples/Providers/Telegram/desktop/UMain.dfm`).

### Added

- `EMultiLog4DConfig` (em `MultiLog4D.Types.pas`): exceção levantada quando um
  provider é criado sem a configuração obrigatória.
- Nota de segurança e orientação de uso correto no README (pt-BR e en), em
  `docs/providers/telegram.md` e neste CHANGELOG.
- `docs/security-credential-sweep.md`: varredura de credenciais em todo o
  repositório — escopo, padrões procurados, achados, falsos positivos
  verificados e o resultado (**nenhuma credencial no HEAD**).

---

## [1.2.5] - 2026-03-11

> ⚠️ Contém a vulnerabilidade descrita em [2.0.0](#200---2026-08-29). Não use.

### Added
- Provider Telegram (`TMultiLog4DProviderTelegram`) e infraestrutura de
  `LogTypeFilter`.
- Provider de eventos (`TMultiLog4DProviderEvents`).
- Samples do provider Telegram: console, desktop (VCL) e Android (FMX).

### Fixed
- Memory leak em `MultiLog4D.Common.WriteToFile`.

---

## [1.2.4] - 2025-01-20

Versões anteriores não possuem changelog detalhado. Consulte o
[histórico de releases](https://github.com/adrianosantostreina/MultiLog4D/releases).
