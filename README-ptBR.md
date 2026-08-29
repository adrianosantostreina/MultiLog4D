<p align="center">
  <a href="https://github.com/adrianosantostreina/MultiLog4D/blob/master/logo.png">
    <img alt="MultiLog4D" src="https://github.com/adrianosantostreina/MultiLog4D/blob/master/logo.png">
  </a>  
</p>
</br>
<p align="center">
  <img src="https://img.shields.io/github/v/release/adrianosantostreina/MultiLog4D?style=flat-square">
  <img src="https://img.shields.io/github/stars/adrianosantostreina/MultiLog4D?style=flat-square">
  <img src="https://img.shields.io/github/contributors/adrianosantostreina/MultiLog4D?color=orange&style=flat-square">
  <img src="https://img.shields.io/github/forks/adrianosantostreina/MultiLog4D?style=flat-square">
   <img src="https://tokei.rs/b1/github/adrianosantostreina/MultiLog4D?color=red&category=lines">
  <img src="https://tokei.rs/b1/github/adrianosantostreina/MultiLog4D?color=green&category=code">
  <img src="https://tokei.rs/b1/github/adrianosantostreina/MultiLog4D?color=yellow&category=files">
</p>

# MultiLog4D
<b>MultiLog4D</b> é uma biblioteca projetada para facilitar e agilizar o envio de logs para Android, iOS, Windows, macOS e Linux. Com apenas uma linha de código é possível enviar uma mensagem que será vista e monitorada na plataforma correspondente, como <b>adb logcat</b> no Android ou <br>syslog</b> no Linux, como exemplo.

> ## ⚠️ Aviso de segurança — provider Telegram (v1.2.5)
>
> A **v1.2.5** — única release que trouxe o provider Telegram antes desta — embutia
> um **token e um chat_id de terceiros** no código da
> biblioteca (`MultiLog4D.Provider.Telegram.inc`), usados como valores padrão do
> construtor. Quem chamou `TMultiLog4DProviderTelegram.Create` **sem argumentos**
> estava, sem qualquer erro ou aviso, **publicando seus logs em um chat de terceiros**.
>
> **O que fazer agora:**
> 1. **Atualize para a 2.0.0 ou superior.** Nela token e chat_id são obrigatórios:
>    `Create` sem argumentos não compila e valores vazios levantam `EMultiLog4DConfig`.
> 2. **Revise o que foi exposto.** Considere vazado todo conteúdo de log enviado ao
>    Telegram pela v1.2.5 sem destino explícito — mensagens de erro,
>    stack traces, dados de usuário, identificadores.
> 3. **O token que vinha no `.inc` já foi revogado** e não autentica mais. Se sua
>    aplicação dependia dele, ela **parou de entregar logs em silêncio** — crie um
>    bot próprio no [@BotFather](https://t.me/BotFather) e informe token e chat_id
>    explicitamente.
>
> Detalhes no [CHANGELOG](CHANGELOG.md) e em [`docs/providers/telegram.md`](docs/providers/telegram.md).


## 🪄 Instalação
Basta baixar os fontes do GitHub, descompactar em uma pasta de sua preferência e no seu projeto apontar para essa pasta no <b><i>Search Path</i></b> do projeto ou se preferir pode utilizar o Boss (gerenciador de dependências do Delphi) para realizar a instalação:
```
boss install github.com/adrianosantostreina/MultiLog4D
```
## 📝 Uso
Existem diversas formas de utilizar o MultiLog4D, detalharemos todas a seguir, mas a que mais gosto é utilizar a classe <b><i>TMultiLog4DUtil</i></b> presente na unidade <b>MultiLog4D.Util.pas</b>. É uma classe <u>Singleton</u> que pode ser chamada de qualquer parte do seu projeto Delphi.

Declare a unidade na cláusula uses do seu formulário e chame a linha abaixo:
```delphi
uses
   MultiLog4D.Util;

procedure TForm1.Button1Click(Sender: TObject);
begin
  TMultiLog4DUtil
    .Logger
      .Tag('MultiLog4D')
      .LogWriteInformation('Qualquer log aqui...')
end;
```
Uma observação importante é que o <B>TAG</b> precisa ser informada obrigatoriamente para <i>Android</i> e <i>iOS</i>, do contrário você não conseguirá filtrar os logs no Terminal do Windows em aplicativos Android e no Console do macOS para aplicativos iOS. O MultiLog4D não irá validar se o tag foi inserido ou não, então você precisa lembrar de chamar o método. Se você não indicar uma TAG, o MultiLog4D definirá a TAG padrão com o nome "MultiLog4D".

A TAG será utilizada para filtrar todas as mensagens da sua aplicação no Terminal quando o monitoramento for solicitado:

# 💡Como ver o log do Android?</br>
Usando qualquer janela de Terminal no Windows, você precisa basicamente usar o <b>adb</b> com o comando <b>logcat</b> para visualizar os logs. 

```bash
adb logcat <MyTAG>:D *:S
```

Substitua <TAG> pelo tag inserido no MultiLog4D, por exemplo:
```bash
adb logcat MyAppAndroid:D *:S
```

✍️ Observação:</b>
Seu dispositivo Android deverá estar em Modo Desenvolvedor, com depuração USB ativada. E caso possua mais de um dispostivo conectado na porta USB, precisará do UUID do disposito o qual fará o monitoramento dos logs. Use o comando a seguir para visualizar os UUID.

```bash
adb devices
```

Esse comando mostrará todos os UUID's de todos os dispositivos conectados ao USB. Em seguida filtre o log usando o comando a seguir:

```bash
adb -s <UUID> logcat MyAppAndroid:D *:S
```

Substitua <UUID> pelo UUID do seu dispositivo.

# 💡Como ver o log no iOS?</br>
No iOS, monitorar os logs deve ser feito pelo aplicativo Console no macOS. Busque pelo aplicativo Console na busca do macOS. Ao abrir o aplicativo, o dispositivo iPhone/iPad que estiver usando para testar seu app aparecerá na barra lateral, apenas clique nele e pronto, os logs desse dispositivo aparecerão na janela. 

⚠️ Atenção: para filtrar somente os logs do seu aplicativo, digite na busca, à direita superior, o nome da TAG que você definiu no Delphi e em seguida aperte ENTER. Um combobox aparecerá à esquerda da busca. Selecione a opção "Mensagem" no combobox. E se preferir, filtre também o processo. Digite o nome do processo na busca (O nome do projeto geralmente é o nome do seu DPR no Delphi), tecle ENTER e em seguida filtre por "Processo" no combobox.

<p align="center">
  <a href="https://github.com/adrianosantostreina/MultiLog4D/blob/master/console.png">
    <img alt="MultiLog4D Console" src="https://github.com/adrianosantostreina/MultiLog4D/blob/master/console.png">
  </a>
</p>

# 💻 Windows
No Windows podemos enviar os logs para Console, Visualizador de Eventos e para arquivo. Para isso há um método a ser configurado, o <b>Output</b>. Ele possui as variações:

<li><b>loFile</b>: Para geração em arquivo
<li><b>loEventViewer</b>: Para geração em Visualizador de Eventos
<li><b>loConsole</b>: Para geração no Console

</br>

```pascal
  TMultiLog4DUtil
    .Logger
    .Output([loConsole, loFile, loEventViewer])
    .LogWriteInformation('Inicializando...');
```
Como pode ver, é um array de opções e você configura como desejar.

### 🏆 Recursos Adicionais

* **Filename** </br>
Você pode configurar a pasta e o nome do arquivo de log que será gerado, do contrário o MultiLog4D criará automaticamente um diretório <b>log</b> e um arquivo com nome padrão. Para configurar isso, basta chamar o método:

```pascal
  TMultiLog4DUtil
    .Logger
    .FileName('C:\MeusLogs\ExemploDeLog')
    .LogWriteInformation('Inicializando...');
```
A biblioteca acrescentará a data e a extensão do arquivo.

```txt
  ExemploDeLog_20241001_010720.log  
```

ou seja, YYYYDDMM hhmmss.log


* **SetLogFormat** </br>
Você pode formatar a saída do log:

Default: `${time} ${username} ${eventid} [${log_type}] - ${message}`

Possible values: `category`

```pascal
  TMultiLog4DUtil
    .Logger
    .SetLogFormat('${time} ${username} ${eventid} [${log_type}] - ${message}')
    .LogWriteInformation('Inicializando...');
```

Estamos avaliando outras informações que poderão fazer parte do log. Caso você tenha sugestões, envie-as através das <b>ISSUES</b>.

* **SetDateTimeFormat** </br>
Você pode personalizar o formato de DataHora.

```pascal
  TMultiLog4DUtil
    .Logger
    .SetDateTimeFormat('YYYY-DD-MM hh:mm:ss')
    .LogWriteInformation('Inicializando...');
```

* **Category** </br>
Você pode personalizar a categoria do log para melhor encontrar os erros e informações no seu projeto. As opções de categoria estão previstas na classe <b>TEventCategory</b> no arquivo <b>MultiLog4D.Types</b>.

Os valores possíveis são:
<li><b>ecNone</b>
<li><b>ecApplication</b>
<li><b>ecSecurity</b>
<li><b>ecPerformance</b>
<li><b>ecError</b>
<li><b>ecWarning</b>
<li><b>ecDebug</b>
<li><b>ecTransaction</b>
<li><b>ecNetwork</b>
</br></br>

```pascal
  TMultiLog4DUtil
    .Logger
    .Category(ecApplication)
    .LogWriteInformation('Inicializando...');
```
* **EventId** </br>
Se você possuir uma classe própria de erros e mapeou usando uma numeração, é possível usar essa numeração para mostrar no log. Por exemplo:

<li><b>1000</b> = Sistema offline
<li><b>1001</b> = Sistema online
<li><b>1010</b> = Erro de conexão

<br>

Caso essa seja sua forma própria de indentificar possíveis erros, use esse número no log.
```pascal
  TMultiLog4DUtil
    .Logger
    .EventId(1000)
    .LogWriteInformation('Inicializando...');
```

# 💻 Linux
No Linux os logs são enviados para a saída padrão do sistema operacional, ou seja, para o <b>syslog</b>. Não é possível enviar logs para arquivos, portanto basta fazer o monitoramento do log usando a linha de comando abaixo no terminal do Linux:

```bash
  tail -f /var/log/syslog  
```
No Linux você ainda pode configurar o EventId mencionado na seção anterior. 

# 💻 macOS
Aplicações para macOS também podem ser monitoradas e receber logs diretamente do Delphi. A forma de monitoramento acontece exatamente como no iOS, através do Console. Retorne na seção sobre iOS para entender como visualizar os logs. A única diferença é que você verá o nome do seu dispositivo mac na barra lateral do macOS.

Assim como no Linux, não é possível criar logs em arquivo. Caso você veja a necessidade de enviar o log também para arquivo, envie sua sugestão através das <b>ISSUES</b>. 
</br>

## EnableLog </br>
Você tem a opção de desativar ou ativar o log a qualquer momento, basta usar a propriedade <b>EnableLog</b> conforme mostrado abaixo:

```pascal
  TMultiLog4DUtil
    .EnableLog(False);
```

✍️ Observação:</b>
O default dessa propriedade é True.

<br>

# Variações do LogWrite
A biblioteca possui ao todo 05 (Cinco) métodos de Log, são eles: </br>
<li><b>LogWrite</b>
</br>

Nesse método você precisa definir no segundo parâmetro qual tipo de log deseja enviar, ou seja: Information, Warning, Error ou Fatal Error. </br>

```pascal
  TMultiLog4DUtil
    .LogWrite('Mensagem', lgInformation);
```

Em seguida você terá os métodos: 
<li><b>LogWriteInformation</b>
<li><b>LogWriteWarning</b>
<li><b>LogWriteError</b>
<li><b>LogWriteFatalError</b>
</br></br>

Nesses não é necessário informar o tipo de log pois já será direcionado internamente para a biblioteca.</br>

✍️ Observação:</b>
Você pode também encadear várias mensagens em uma única chamada.

```pascal
  TMultiLog4DUtil
    .LogWriteInformation('Inicializando o sistema')
    .LogWriteInformation('Conectando ao servidor')
    .LogWriteWarning('Validação de status de usuário');
```

✍️ Exemplo de uso em uma Exceção:
```pascal
procedure TForm1.Button1Click(Sender: TObject)
begin
  try
   //seu código 
  except on E:Exception do
    begin
      TMultiLog4DUtil
        .LogWriteError(Format('Erro: %s | %s', [E.ClassName, E.Message]));
    end;
  end;
end;    
```
---

### 🤖 Providers — Notificações Externas

O MultiLog4D suporta **Providers**, canais de saída externos que recebem as entradas de log
além da saída nativa da plataforma (Logcat, EventViewer, syslog, etc.).

Adicione qualquer provider ao logger com `AddProvider`. Lembre-se de adicionar `src/Providers/` ao **Search Path** do seu projeto.

#### 📨 Provider Telegram

Envia mensagens de log diretamente para um chat ou grupo do Telegram via Bot API.

**Configuração:**
1. Converse com [@BotFather](https://t.me/BotFather) no Telegram → `/newbot` → copie o token
2. Obtenha o Chat ID via [@userinfobot](https://t.me/userinfobot) ou pelo endpoint `getUpdates` da API

> **Token e Chat ID são obrigatórios.** A biblioteca **não tem destino padrão**:
> `Create` sem argumentos não compila, e token ou chat_id vazio levanta
> `EMultiLog4DConfig`. Leia as credenciais da configuração da sua aplicação
> (`.ini`, `.json`, variável de ambiente, cofre de segredos) — nunca as escreva no
> código nem as commite. Veja o [aviso de segurança](#️-aviso-de-segurança--provider-telegram-v125)
> se você usou o provider na v1.2.5.

**Uso mínimo:**
```pascal
uses
  MultiLog4D.Util,
  MultiLog4D.Types,
  MultiLog4D.Provider.Telegram;

var
  LProvider: TMultiLog4DProviderTelegram;
begin
  LProvider := TMultiLog4DProviderTelegram.Create('BOT_TOKEN', 'CHAT_ID');

  TMultiLog4DUtil.Logger
    .Tag('MeuApp')
    .AddProvider(LProvider);

  TMultiLog4DUtil.Logger.LogWriteWarning('Uso de memória acima de 80%');
  TMultiLog4DUtil.Logger.LogWriteError('Falha ao conectar ao banco de dados');
  TMultiLog4DUtil.Logger.LogWriteFatalError('Serviço encerrado inesperadamente');
end;
```

**LogTypeFilter** — envie apenas tipos específicos de log ao Telegram:
```pascal
LProvider.LogTypeFilter := [ltWarning, ltError, ltFatalError]; // ltInformation é ignorado
```

**ParseMode** — controle a formatação das mensagens no Telegram:
```pascal
LProvider.ParseMode := tpmMarkdown;  // *[ERR]* MeuApp / mensagem / _timestamp_
LProvider.ParseMode := tpmHTML;      // <b>[ERR]</b> MeuApp / mensagem / <i>timestamp</i>
LProvider.ParseMode := tpmPlainText; // [ERR] MeuApp / mensagem / timestamp
```

**Exemplo completo com fluent API:**
```pascal
LProvider := TMultiLog4DProviderTelegram.Create('BOT_TOKEN', 'CHAT_ID');
LProvider.ParseMode     := tpmMarkdown;
LProvider.LogTypeFilter := [ltWarning, ltError, ltFatalError];

TMultiLog4DUtil.Logger
  .Tag('Producao')
  .AddProvider(LProvider)
  .LogWriteInformation('Nao enviado — filtrado')
  .LogWriteWarning('Disco acima de 90%')
  .LogWriteError('Timeout na conexao')
  .LogWriteFatalError('Servico encerrado');
```

> Documentação completa em [`docs/providers/telegram.md`](docs/providers/telegram.md).

---

### ⭕ Horse
Caso esteja procurando incluir logs em API's desenvolvidas em <b>Horse</b>, saiba que isso também é possível, tanto para Windows quanto para Linux. O processo é o mesmo, basta adicionar a biblioteca baixando-a ou instalando através do <b>boss</b> que vai funcionar exatamente como explicado até aqui. 

🤔 Lembrando apenas que no Windows podemos adicionar logs no Console, EventViewer e em Arquivos. Veja um exemplo de código:

```pascal
uses
  Horse,
  MultiLog4D.Common,
  MultiLog4D.Util,
  MultiLog4D.Types,
  System.IOUtils,
  System.SysUtils;

begin
  TMultiLog4DUtil
    .Logger
    .LogWriteInformation('Start Application');

  THorse
    .Get('/test1',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Randomize;

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation('Before Test1 - ' + Format('Mensagem de teste 1 de log: %d', [Random(1000)]));

      Res.Send('test1');

      TMultiLog4DUtil
        .Logger
        .LogWriteInformation('After Test1 - ' + Format('Mensagem de teste 1 de log: %d', [Random(1000)]));
    end
    );

  THorse
    .Listen(9000);
end.
```
</br>

---

Apresentação
[![Watch the video](https://github.com/adrianosantostreina/MultiLog4D/blob/master/Play.png)](https://youtu.be/wYnMtSVkRtE?si=KBhKDxnJdNFbOWwe)


## Linguagens da Documentação
[English (en)](https://github.com/adrianosantostreina/MultiLog4D/blob/master/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/MultiLog4D/blob/master/README-ptBR.md)<br>

## ⚠️ Licença
`MultiLog4D` é uma biblioteca gratuita e de código aberto licenciada sob a [MIT License](https://github.com/adrianosantostreina/MultiLog4D/blob/main/LICENSE.md). 
