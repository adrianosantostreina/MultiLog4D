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
MultiLog4D é uma biblioteca projetada para facilitar e agilizar o envio de logs para Android, iOS, Windows, macOS e Linux. Com apenas uma linha de código é possível enviar uma mensagem que será vista e monitorada na plataforma correspondente, como adb logcat no Android por exemplo.

Esta primeira versão cobre apenas Android. Em breve implementaremos implementações para outras plataformas também.

## Instalação
Basta cadastrar no Library Path do seu Delphi o caminho da pasta SOURCE da biblioteca, ou se preferir pode utilizar o Boss (gerenciador de dependências do Delphi) para realizar a instalação:
```
boss install github.com/adrianosantostreina/MultiLog4D
```

Caso não queira usar o boss, basta baixar os fontes do GitHub, descompactar em uma pasta de sua preferência e no seu projeto apontar para essa pasta no Search Path do projeto.

## Uso
Existem diversas formas de utilizar o MultiLog4D, detalharemos todas a seguir, mas a que mais gosto é utilizar a classe TMultiLog4DUtil presente na unidade MultiLog4D.Util.pas. É uma classe singleton que pode ser chamada de qualquer parte do seu projeto Delphi.

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
Uma observação importante é que o TAG precisa ser informada obrigatoriamente para Android e iOS, do contrário você não conseguirá filtrar os logs no Terminal do Windows em aplicativos Android e no Console do macOS para aplicativos iOS. O MultiLog4D não irá validar se o tag foi inserido ou não, então você precisa lembrar de chamar o método. Se você não indicar uma TAG, o MultiLog4D definirá a TAG padrão com o nome "MultiLog4D".

A TAG será utilizada para filtrar todas as mensagens da sua aplicação no Terminal quando o monitoramento for solicitado:

# Como ver o log do Android?</br>
Usando qualquer janela de Terminal no Windows, você precisa basicamente usar o adb com o comando logcat para visualizar os logs. 

Exemplo:
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

# Como ver o log no iOS?</br>
No iOS monitorar os logs deve ser feito pelo aplicativo Console no macOS. Busque pelo aplicativo Console na busca do macOS. Ao abrir o aplicativo, o dispositivo iPhone/iPad que estiver usando para testar seu aplicativo aparecerá na barra lateral, apenas clique nele e pronto, os logs desse dispositivo aparecerão na janela. 

⚠️ Atenção: para filtrar somente os logs do seu aplicativo, digite na busca, à direita superior, o nome da TAG que você definiu no Delphi e em seguida aperte ENTER. Um combobox aparecerá à esquerda da busca. Selecione a opção "Mensagem" no combobox. E se preferir, filtre também o processo. Digite o nome do processo na busca (O nome do projeto geralmente é o nome do seu DPR no Delphi), tecle ENTER e em seguida filtre por "Processo" no combobox.

<p align="center">
  <a href="https://github.com/adrianosantostreina/MultiLog4D/blob/master/console.png">
    <img alt="MultiLog4D Console" src="https://github.com/adrianosantostreina/MultiLog4D/blob/master/console.png">
  </a>
</p>

# Windows
No Windows podemos enviar os logs para Console, Visualizador de Eventos do Windows e para arquivo. Para isso há um método a ser configurado, o <b>Output</b>. Ele possui as variações:

<li>loFile: Para geração em arquivo
<li>loEventViewer: Para geração em Visualizador de Eventos
<li>loConsole: Para geração no Console

</br>

```pascal
  TMultiLog4DUtil
    .Logger
    .Output([loConsole, loFile, loEventViewer])
    .LogWriteInformation('Inicializando...');
```
Como pode ver, é um array de opções e você configura como desejar.

### Recursos Adicionais 🏆

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

Estamos avaliando outras informações que poderão fazer parte do log. Caso você tenha sugestões, envie-as através das <b>ISSUES</b>.

```pascal
  TMultiLog4DUtil
    .Logger
    .SetLogFormat('${time} ${username} ${eventid} [${log_type}] - ${message}')
    .LogWriteInformation('Inicializando...');
```

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
<li>ecNone 
<li>ecApplication 
<li>ecSecurity 
<li>ecPerformance 
<li>ecError
<li>ecWarning 
<li>ecDebug 
<li>ecTransaction
<li>ecNetwork

</br>

```pascal
  TMultiLog4DUtil
    .Logger
    .Tag('MultiLog4D')
    .Output([loConsole, loFile, loEventViewer])
    .FileName('C:\MeusLogs\ExemploDeLog')
    .SetLogFormat('${time} ${username} ${eventid} [${log_type}] - ${message}')
    .SetDateTimeFormat('YYYY-DD-MM hh:mm:ss')
    .LogWriteInformation('Inicializando...');
```
</br>


</br></br></br>
# Variações do LogWrite
A biblioteca possui ao todo 05 (Cinco) métodos de Log, são eles: </br>
<li>LogWrite = Nesse método você precisa definir no segundo parâmetro qual tipo de log deseja enviar, ou seja: Information, Warning, Error ou Fatal Error.

Em seguida você terá os métodos: 
<li> LogWriteInformation
<li> LogWriteWarning
<li> LogWriteError
<li> LogWriteFatalError

</br>
Nesses não é necessário informar o tipo de log pois já será direcionado internamente para a biblioteca.


</br></br></br>
Apresentação
[![Watch the video](https://github.com/adrianosantostreina/MultiLog4D/blob/master/Play.png)](https://youtu.be/wYnMtSVkRtE?si=KBhKDxnJdNFbOWwe)


## Linguagens da Documentação
[English (en)](https://github.com/adrianosantostreina/MultiLog4D/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/MultiLog4D/blob/master/README-ptBR.md)<br>

## ⚠️ Licença
`MultiLog4D` é uma biblioteca gratuita e de código aberto licenciada sob a [MIT License](https://github.com/adrianosantostreina/MultiLog4D/blob/main/LICENSE.md). 
