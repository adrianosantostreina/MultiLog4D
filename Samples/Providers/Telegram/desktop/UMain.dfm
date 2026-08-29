object FormTelegramDesktop: TFormTelegramDesktop
  Left = 0
  Top = 0
  Caption = 'MultiLog4D '#226#8364#8221' Telegram Provider (Desktop)'
  ClientHeight = 520
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object grpCredentials: TGroupBox
    Left = 8
    Top = 8
    Width = 504
    Height = 80
    Caption = 'Credenciais'
    TabOrder = 0
    object lblToken: TLabel
      Left = 8
      Top = 20
      Width = 33
      Height = 13
      Caption = 'Token:'
    end
    object lblChatID: TLabel
      Left = 8
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Chat ID:'
    end
    object edtToken: TEdit
      Left = 64
      Top = 16
      Width = 432
      Height = 21
      TabOrder = 0
      TextHint = 'Cole seu bot token aqui'
    end
    object edtChatID: TEdit
      Left = 64
      Top = 44
      Width = 432
      Height = 21
      TabOrder = 1
      TextHint = 'Cole seu chat ID aqui'
    end
  end
  object grpParseMode: TGroupBox
    Left = 8
    Top = 96
    Width = 200
    Height = 50
    Caption = 'Parse Mode'
    TabOrder = 1
    object cmbParseMode: TComboBox
      Left = 8
      Top = 18
      Width = 180
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
  end
  object grpFilter: TGroupBox
    Left = 216
    Top = 96
    Width = 296
    Height = 50
    Caption = 'Log Type Filter'
    TabOrder = 2
    object chkInformation: TCheckBox
      Left = 8
      Top = 20
      Width = 90
      Height = 17
      Caption = 'Information'
      TabOrder = 0
    end
    object chkWarning: TCheckBox
      Left = 100
      Top = 20
      Width = 70
      Height = 17
      Caption = 'Warning'
      TabOrder = 1
    end
    object chkError: TCheckBox
      Left = 172
      Top = 20
      Width = 50
      Height = 17
      Caption = 'Error'
      TabOrder = 2
    end
    object chkFatalError: TCheckBox
      Left = 224
      Top = 20
      Width = 70
      Height = 17
      Caption = 'FatalError'
      TabOrder = 3
    end
  end
  object btnApply: TButton
    Left = 8
    Top = 156
    Width = 504
    Height = 30
    Caption = 'Aplicar Provider'
    TabOrder = 3
    OnClick = btnApplyClick
  end
  object grpLog: TGroupBox
    Left = 8
    Top = 196
    Width = 504
    Height = 50
    Caption = 'Enviar Log'
    TabOrder = 4
    object btnInformation: TButton
      Left = 8
      Top = 16
      Width = 110
      Height = 25
      Caption = 'Information'
      TabOrder = 0
      OnClick = btnInformationClick
    end
    object btnWarning: TButton
      Left = 126
      Top = 16
      Width = 110
      Height = 25
      Caption = 'Warning'
      TabOrder = 1
      OnClick = btnWarningClick
    end
    object btnError: TButton
      Left = 244
      Top = 16
      Width = 110
      Height = 25
      Caption = 'Error'
      TabOrder = 2
      OnClick = btnErrorClick
    end
    object btnFatalError: TButton
      Left = 362
      Top = 16
      Width = 110
      Height = 25
      Caption = 'FatalError'
      TabOrder = 3
      OnClick = btnFatalErrorClick
    end
  end
  object memoFeedback: TMemo
    Left = 8
    Top = 256
    Width = 504
    Height = 256
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
end
