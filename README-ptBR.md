<p align="center">
  <a href="https://github.com/adrianosantostreina/MultiLog4D/blob/master/logo.png">
    <img alt="MultiLog4D" src="https://github.com/adrianosantostreina/MultiLog4D/blob/master/logo.png">
  </a>  
</p>

# MultiLog4D
MultiLog4D é uma biblioteca projetada para facilitar e agilizar o envio de logs para Android, iOS, Windows, macOS e Linux. Com apenas uma linha de código é possível enviar uma mensagem que será vista e monitorada na plataforma correspondente, como adb logcat no Android por exemplo.

Esta primeira versão cobre apenas Android. Em breve implementaremos implementações para outras plataformas também.

## Instalação
Basta cadastrar no Library Path do seu Delphi o caminho da pasta SOURCE da biblioteca, ou se preferir pode utilizar o Boss (gerenciador de dependências do Delphi) para realizar a instalação:
```
boss install github.com/adrianosantostreina/MultiLog4D
```

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
Uma observação importante é que o TAG precisa ser informado. O MultiLog4D não irá validar se o tag foi inserido ou não, então você precisa lembrar de chamar o método.

A TAG será utilizada para filtrar todas as mensagens da sua aplicação no Terminal Windows quando o monitoramento for solicitado:

Exemplo:
```bash
adb logcat <MyTAG>:D *:S
```

Substitua <TAG> pelo tag inserido no MultiLog4D, por exemplo:
```bash
adb logcat MyAppAndroid:D *:S
```

Apresentação
[![Watch the video](https://github.com/adrianosantostreina/MultiLog4D/blob/master/Play.png)](https://youtu.be/wYnMtSVkRtE?si=KBhKDxnJdNFbOWwe)


## Linguagens da Documentação
[English (en)](https://github.com/adrianosantostreina/MultiLog4D/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/MultiLog4D/blob/master/README-ptBR.md)<br>

## ⚠️ Licença
`MultiLog4D` é uma biblioteca gratuita e de código aberto licenciada sob a [MIT License](https://github.com/adrianosantostreina/MultiLog4D/blob/main/LICENSE.md). 
