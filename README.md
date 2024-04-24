<p align="center">
  <a href="https://github.com/adrianosantostreina/MultiLog4D/blob/master/logo.png">
    <img alt="MultiLog4D" src="https://github.com/adrianosantostreina/MultiLog4D/blob/master/logo.png">
  </a>  
</p>

# MultiLog4D
MultiLog4D is a library designed to make it easy and quick to send logs to Android, iOS, Windows, macOS and Linux. With just one line of code it is possible to send a message that will be seen and monitored on the corresponding platform, like adb logcat on Android for example.

This first version is only covering Android. We will soon implement for other platforms as well.

## Installation
Just register in the Library Path of your Delphi the path of the SOURCE folder of the library, or if you prefer, you can use Boss (dependency manager for Delphi) to perform the installation:
```
boss install github.com/adrianosantostreina/MultiLog4D
```

## Use
There are several ways to use MultiLog4D, we will detail them all below, but the one I like most is using the TMultiLog4DUtil class present in the MultiLog4D.Util.pas unit. It is a singleton class that can be called from any part of your Delphi project.

Declare the unit in the uses clause of your form and call the line below:
```delphi
uses
   MultiLog4D.Util;

procedure TForm1.Button1Click(Sender: TObject);
begin
  TMultiLog4DUtil
    .Logger
      .Tag('MultiLog4D')
      .LogWriteInformation('Any log here...')
end;
```
An important observation is that the TAG needs to be informed. MultiLog4D will not validate whether the tag was entered or not, so you need to remember to call the method.

The TAG will be used to filter all messages from your application in the Windows Terminal when monitoring has been requested:

Example:
```bash
adb logcat <MyTAG>:D *:S
```

Replace <TAG> with the tag entered in MultiLog4D, for example:
```bash
adb logcat MyAppAndroid:D *:S
```

<iframe width="560" height="315" src="https://www.youtube.com/embed/wYnMtSVkRtE?si=e68NyK1Jq3cuc7Eu" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>


## Documentation Languages
[English (en)](https://github.com/adrianosantostreina/MultiLog4D/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/MultiLogD/blob/main/README-ptBR.md)<br>

## ⚠️ License
`MultiLog4D` is free and open-source library licensed under the [MIT License](https://github.com/adrianosantostreina/MultiLog4D/blob/main/LICENSE.md). 
