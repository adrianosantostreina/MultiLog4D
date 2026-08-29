<p align="center">
  <a href="https://github.com/adrianosantostreina/MultiLog4D/blob/master/logo.png">
    <img alt="MultiLog4D" src="https://github.com/adrianosantostreina/MultiLog4D/blob/master/logo.png">
  </a>  
</p>

<p align="center">
  <img src="https://img.shields.io/github/v/release/adrianosantostreina/MultiLog4D?style=flat-square">
  <img src="https://img.shields.io/github/stars/adrianosantostreina/MultiLog4D?style=flat-square">
  <img src="https://img.shields.io/github/contributors/adrianosantostreina/MultiLog4D?color=orange&style=flat-square">
  <img src="https://img.shields.io/github/forks/adrianosantostreina/MultiLog4D?style=flat-square">
   <img src="https://tokei.rs/b1/github/adrianosantostreina/MultiLog4D?color=red&category=lines">
  <img src="https://tokei.rs/b1/github/adrianosantostreina/MultiLog4D?color=green&category=code">
  <img src="https://tokei.rs/b1/github/adrianosantostreina/MultiLog4D?color=yellow&category=files">
</p>

<b>MultiLog4D</b> is a library designed to facilitate and speed up the sending of logs to Android, iOS, Windows, macOS and Linux. With just one line of code, it is possible to send a message that will be seen and monitored on the corresponding platform, such as <b>adb logcat</b> on Android or <br>syslog</b> on Linux, for example.

> ## ⚠️ Security notice — Telegram provider (v1.2.5)
>
> **v1.2.5** — the only release that shipped the Telegram provider before this one —
> embedded a **third-party bot token and chat_id** inside the library itself (`MultiLog4D.Provider.Telegram.inc`), used as the constructor's
> default values. Anyone calling `TMultiLog4DProviderTelegram.Create` **with no
> arguments** was silently **publishing their logs to a third-party chat**.
>
> **What to do now:**
> 1. **Upgrade to 2.0.0 or later.** Token and chat_id are now required: `Create`
>    with no arguments no longer compiles, and empty values raise `EMultiLog4DConfig`.
> 2. **Review what was exposed.** Treat every log message sent to Telegram by a
>    v1.2.5 without an explicit destination as leaked — error messages,
>    stack traces, user data, identifiers.
> 3. **The token that shipped in the `.inc` has been revoked** and no longer
>    authenticates. If your application relied on it, it **stopped delivering logs
>    silently** — create your own bot via [@BotFather](https://t.me/BotFather) and
>    pass token and chat_id explicitly.
>
> Details in the [CHANGELOG](CHANGELOG.md) and [`docs/providers/telegram.md`](docs/providers/telegram.md).


## 🪄 Installation
Just download the sources from GitHub, unzip them in a folder of your choice and point to this folder in your project's <b><i>Search Path</i></b> or, if you prefer, you can use Boss (Delphi's dependency manager) to perform the installation:
```
boss install github.com/adrianosantostreina/MultiLog4D
```
## 📝 Usage
There are several ways to use MultiLog4D, we will detail them all below, but the one I like the most is to use the <b><i>TMultiLog4DUtil</i></b> class present in the <b>MultiLog4D.Util.pas</b> unit. It is a <u>Singleton</u> class that can be called from any part of your Delphi project.

Declare the unit in the uses clause of your form and call the line below:
```pascal
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
An important note is that the <B>TAG</b> must be provided for <i>Android</i> and <i>iOS</i>, otherwise you will not be able to filter the logs in the Windows Terminal for Android applications and in the macOS Console for iOS applications. MultiLog4D will not validate whether the tag was entered or not, so you need to remember to call the method. If you do not provide a TAG, MultiLog4D will set the default TAG with the name "MultiLog4D".

The TAG will be used to filter all messages from your application in the Terminal when monitoring is requested:

# 💡How to view the Android log?</br>
Using any Terminal window on Windows, you basically need to use <b>adb</b> with the <b>logcat</b> command to view the logs.

Example:
```sh
  adb logcat <MyTAG>:D *:S
```

Replace <TAG> with the tag entered in MultiLog4D, for example:
```sh
  adb logcat MyAppAndroid:D *:S
```
✍️ Note: Your Android device must be in Developer Mode, with USB debugging enabled. And if you have more than one device connected to the USB port, you will need the UUID of the device that will monitor the logs. Use the following command to view the UUIDs.

```sh
  adb devices
```

This command will show all UUIDs of all devices connected to the USB. Then filter the log using the following command:

```sh
  adb -s <UUID> logcat MyAppAndroid:D *:S
```

Replace <UUID> with the UUID of your device.

# 💡How to view the log on iOS?</br>
On iOS, monitoring the logs must be done through the Console application on macOS. Search for the Console application in the macOS search. When you open the application, the iPhone/iPad device you are using to test your app will appear in the sidebar, just click on it and that's it, the logs for that device will appear in the window.

⚠️ Attention: to filter only the logs of your application, type in the search, in the top right, the name of the TAG that you defined in Delphi and then press ENTER. A combobox will appear to the left of the search. Select the "Message" option in the combobox. And if you prefer, you can also filter the process. Type the name of the process in the search box (The project name is usually the name of your DPR in Delphi), press ENTER and then filter by "Process" in the combobox.

<p align="center">
<a href="https://github.com/adrianosantostreina/MultiLog4D/blob/master/console.png">
<img alt="MultiLog4D Console" src="https://github.com/adrianosantostreina/MultiLog4D/blob/master/console.png">
</a>
</p>

# 💻 Windows
On Windows we can send logs to the Console, Event Viewer and to a file. For this there is a method to be configured, the <b>Output</b>. It has the following variations:

<li><b>loFile</b>: For generation in a file
<li><b>loEventViewer</b>: For generation in the Event Viewer
<li><b>loConsole</b>: For generation in the Console

</br>

```pascal
  TMultiLog4DUtil
    .Logger
      .Output([loConsole, loFile, loEventViewer])
      .LogWriteInformation('Inicializando...');
```
As you can see, it is an array of options and you configure it as you wish.

### 🏆 Additional Resources

* **Filename** </br>
You can configure the folder and the name of the log file that will be generated, otherwise MultiLog4D will automatically create a <b>log</b> directory and a file with a default name. To configure this, simply call the method:

```pascal
  TMultiLog4DUtil
    .Logger
      .FileName('C:\MyLogs\ExampleLog')
      .LogWriteInformation('Initializing...');
```
The library will append the date and file extension.

```txt
ExampleLog_20241001_010720.log
```

i.e. YYYYDDMM hhmmss.log

* **SetLogFormat** </br>
You can format the log output:

Default: `${time} ${username} ${eventid} [${log_type}] - ${message}`

Possible values: `category`

```pascal
  TMultiLog4DUtil
    .Logger
      .SetLogFormat('${time} ${username} ${eventid} [${log_type}] - ${message}')
      .LogWriteInformation('Initializing...');
```

We are evaluating other information that may be part of the log. If you have any suggestions, please send them through <b>ISSUES</b>.

* **SetDateTimeFormat** </br>
You can customize the DateTime format.

```pascal
  TMultiLog4DUtil
    .Logger
      .SetDateTimeFormat('YYYY-DD-MM hh:mm:ss')
      .LogWriteInformation('Initializing...');
```

* **Category** </br>
You can customize the log category to better find errors and information in your project. The category options are provided in the <b>TEventCategory</b> class in the <b>MultiLog4D.Types</b> file.

Possible values ​​are:
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
      .LogWriteInformation('Initializing...');
```
* **EventId** </br>
If you have your own error class and mapped it using a number, you can use that number to show in the log. For example:

<li><b>1000</b> = System offline
<li><b>1001</b> = System online
<li><b>1010</b> = Connection error

<br>

If this is your own way of identifying possible errors, use this number in the log.
```pascal
  TMultiLog4DUtil
    .Logger
      .EventId(1000)
      .LogWriteInformation('Initializing...');
```
# 💻 Linux
On Linux, logs are sent to the operating system's standard output, that is, to <b>syslog</b>. It is not possible to send logs to files, so you can simply monitor the log using the command line below in the Linux terminal:

```bash
  tail -f /var/log/syslog
```
On Linux, you can also configure the EventId mentioned in the previous section.

# 💻 macOS
MacOS applications can also be monitored and receive logs directly from Delphi. The monitoring method is exactly the same as on iOS, through the Console. Return to the iOS section to understand how to view the logs. The only difference is that you will see the name of your Mac device in the macOS sidebar.

As with Linux, it is not possible to create logs in a file. If you see the need to also send the log to a file, send your suggestion through <b>ISSUES</b>.

</br>

## EnableLog </br>
You have the option to disable or enable the log at any time, just use the <b>EnableLog</b> property as shown below:

```pascal
  TMultiLog4DUtil
    .Logger
      .EnableLog(False);
```

✍️ Note:</b>
The default for this property is True.

<br>

# LogWrite Variations
The library has a total of 05 (Five) Log methods, which are:</br>
<li><b>LogWrite</b>
</br>

In this method, you need to define in the second parameter which type of log you want to send, that is: Information, Warning, Error or Fatal Error.</br>

```pascal
  TMultiLog4DUtil
    .Logger
      .LogWrite('Message', lgInformation); 
```

Next you will have the methods:
<li><b>LogWriteInformation</b>
<li><b>LogWriteWarning</b>
<li><b>LogWriteError</b>
<li><b>LogWriteFatalError</b>
</br></br>

In these, it is not necessary to inform the log type as it will already be directed internally to the library.</br>

✍️ Note:</b>
You can also chain several messages in a single call.

```pascal
  TMultiLog4DUtil
    .Logger
      .LogWriteInformation('Initializing the system')
      .LogWriteInformation('Connecting to the server')
      .LogWriteWarning('Validating user status'); 
```

✍️ Example of usage in an Exception:
```pascal
procedure TForm1.Button1Click(Sender: TObject)
begin
  try
    //your code
  except on E:Exception do
    begin
      TMultiLog4DUtil
        .Logger
          .LogWriteError(Format('Error: %s | %s', [E.ClassName, E.Message]));
    end;
  end;
end;
```

---

### 🤖 Providers — External Notifications

MultiLog4D supports **Providers**, external output channels that receive log entries
in addition to the native platform output (Logcat, EventViewer, syslog, etc.).

Add any provider to the logger with `AddProvider`. Remember to add `src/Providers/` to your project's **Search Path**.

#### 📨 Telegram Provider

Sends log messages directly to a Telegram chat or group via Bot API.

**Setup:**
1. Talk to [@BotFather](https://t.me/BotFather) on Telegram → `/newbot` → copy the token
2. Get your Chat ID via [@userinfobot](https://t.me/userinfobot) or the `getUpdates` API endpoint

> **Token and Chat ID are required.** The library has **no default destination**:
> `Create` with no arguments does not compile, and an empty token or chat_id raises
> `EMultiLog4DConfig`. Read the credentials from your application's configuration
> (`.ini`, `.json`, environment variable, secret vault) — never hardcode or commit
> them. See the [security notice](#️-security-notice--telegram-provider-v125)
> if you used the provider on v1.2.5.

**Minimal usage:**
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
    .Tag('MyApp')
    .AddProvider(LProvider);

  TMultiLog4DUtil.Logger.LogWriteWarning('Memory usage above 80%');
  TMultiLog4DUtil.Logger.LogWriteError('Failed to connect to database');
  TMultiLog4DUtil.Logger.LogWriteFatalError('Service terminated unexpectedly');
end;
```

**LogTypeFilter** — send only specific log types to Telegram:
```pascal
LProvider.LogTypeFilter := [ltWarning, ltError, ltFatalError]; // ltInformation is skipped
```

**ParseMode** — control Telegram message formatting:
```pascal
LProvider.ParseMode := tpmMarkdown;  // *[ERR]* MyApp / message / _timestamp_
LProvider.ParseMode := tpmHTML;      // <b>[ERR]</b> MyApp / message / <i>timestamp</i>
LProvider.ParseMode := tpmPlainText; // [ERR] MyApp / message / timestamp
```

**Full example with fluent API:**
```pascal
LProvider := TMultiLog4DProviderTelegram.Create('BOT_TOKEN', 'CHAT_ID');
LProvider.ParseMode     := tpmMarkdown;
LProvider.LogTypeFilter := [ltWarning, ltError, ltFatalError];

TMultiLog4DUtil.Logger
  .Tag('Production')
  .AddProvider(LProvider)
  .LogWriteInformation('Not sent — filtered out')
  .LogWriteWarning('Disk usage above 90%')
  .LogWriteError('Connection timeout')
  .LogWriteFatalError('Service stopped');
```

> See full documentation in [`docs/providers/telegram.md`](docs/providers/telegram.md).

---

### ⭕ Horse
If you are looking to include logs in APIs developed in <b>Horse</b>, know that this is also possible, both for Windows and Linux. The process is the same, just add the library by downloading it or installing it through <b>boss</b> and it will work exactly as explained here.

🤔 Just remember that in Windows we can add logs in the Console, EventViewer and in Files. See a code example: 

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
           .LogWriteInformation('Before Test1 - ' + Format('Log test 1 message: %d', [Random(1000)])); 
      
      Res.Send('test1'); 
      
      TMultiLog4DUtil
        .Logger
          .LogWriteInformation('After Test1 - ' + Format('Log test 1 message: %d', [Random(1000)]));
     end;

  THorse.Listen(9000);
end.

``` 
</br> 

---

Presentation
[![Watch the video](https://github.com/adrianosantostreina/MultiLog4D/blob/master/Play.png)](https://youtu.be/wYnMtSVkRtE?si=KBhKDxnJdNFbOWwe)


## Documentation Languages
[English (en)](https://github.com/adrianosantostreina/MultiLog4D/blob/master/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/MultiLog4D/blob/master/README-ptBR.md)<br>

## ⚠️ License
`MultiLog4D` is free and open-source library licensed under the [MIT License](https://github.com/adrianosantostreina/MultiLog4D/blob/main/LICENSE.md). 

