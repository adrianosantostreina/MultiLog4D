# Varredura de credenciais — 2026-08-29

Executada como parte da correção de segurança da **v2.0.0** (credenciais de
Telegram embutidas na biblioteca). Documenta o escopo, o método e o resultado.

## Escopo

Todos os arquivos **versionados** do repositório (`git ls-files`), com atenção
especial a `src/`, `src/Providers/`, os `.inc` e os `.dfm`/`.fmx` dos samples
— formulários guardam o conteúdo dos `TEdit` no arquivo, e foi exatamente aí que
um dos vazamentos estava.

## Padrões procurados

| Padrão | Alvo |
|---|---|
| `bot[0-9]{6,}:` / `[0-9]{8,}:AA[\w-]{20,}` | Token de bot do Telegram |
| `xox[baprs]-` | Token do Slack |
| `https://hooks.slack` / `discord.com/api/webhooks` | Webhooks |
| `AIza[\w-]{30,}` | Chave de API do Google |
| `sk-[A-Za-z0-9]{20,}` | Chave da OpenAI e similares |
| `ghp_[A-Za-z0-9]{30,}` | Token do GitHub |
| `-----BEGIN ... PRIVATE KEY` | Chave privada |
| Constantes `*TOKEN*`, `*KEY*`, `*SECRET*`, `*PASSWORD*`, `*CHAT_ID*`, `*WEBHOOK*`, `*CREDENTIAL*` | Segredo em constante nomeada |

## Achados e tratamento

| # | Local | Achado | Tratamento |
|---|---|---|---|
| 1 | `src/Providers/MultiLog4D.Provider.Telegram.inc:14-15` | Token de bot e chat_id reais, usados como valor padrão do construtor | Constantes **removidas**. O `.inc` guarda apenas defaults de comportamento. Token **revogado** no @BotFather. |
| 2 | `Samples/Providers/Telegram/desktop/UMain.dfm:42,51` | Mesmo token e chat_id pré-preenchidos nas propriedades `Text` dos `TEdit` | Propriedades `Text` **removidas**; os campos abrem vazios, com `TextHint`. |

Nenhum outro provider embute credenciais: hoje existem apenas
`TMultiLog4DProviderREST` (endpoint informado pelo chamador),
`TMultiLog4DProviderEvents` (callback, sem rede) e o Telegram. Não há Slack,
Discord, SMTP ou provider de e-mail no código.

## Falsos positivos verificados

- `Samples/Linux/horse/**` — dependência de terceiros (Horse) vendorizada.
  Ocorrências de `Password` são **nomes de parâmetro e de evento**
  (`OnGetPassword`, `VPassword`), não valores.
- `Samples/Providers/Telegram/TelegramConfig.inc` — contém os placeholders
  `SEU_BOT_TOKEN_AQUI` / `SEU_CHAT_ID_AQUI` e emite `{$MESSAGE WARN}` na
  compilação enquanto não forem preenchidos. **Preencha localmente e não commite
  os valores.**
- Samples desktop e Android lêem token e chat_id de campos do formulário — sem
  credencial no código.
- `docs/`, `README*.md` e este arquivo citam o formato dos tokens em exemplos e
  no aviso de segurança; são textos ilustrativos.

## Resultado

`git ls-files` + varredura dos padrões acima: **nenhuma credencial no HEAD** após
os tratamentos 1 e 2.

## Limitação importante

A remoção só limpa o **HEAD**. O token continua no **histórico do Git** (desde o
commit `ac9a88e`) e em todo clone ou fork feito antes desta correção. Reescrever
o histórico com `git filter-repo` reescreveria todos os SHAs e ainda assim não
alcançaria clones de terceiros. **O que efetivamente resolve é a revogação do
token no @BotFather** — feita como o passo 1 desta correção, antes da publicação.
