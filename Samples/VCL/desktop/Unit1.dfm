object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'MultiLog4D'
  ClientHeight = 488
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Bevel1: TBevel
    Left = 8
    Top = 169
    Width = 379
    Height = 15
    Shape = bsBottomLine
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 290
    Height = 105
    Caption = 'LogType'
    ItemIndex = 0
    Items.Strings = (
      'Information'
      'Warning'
      'Error'
      'Fatal Error')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 312
    Top = 16
    Width = 75
    Height = 25
    Caption = 'LogWrite'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Information'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 89
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Warning'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 170
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Error'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 251
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Fatal Error'
    TabOrder = 5
    OnClick = Button5Click
  end
  object RadioGroup2: TRadioGroup
    Left = 8
    Top = 200
    Width = 379
    Height = 105
    Caption = 'Destination'
    ItemIndex = 0
    Items.Strings = (
      'File'
      'LogViewer'
      'Both')
    TabOrder = 6
    OnClick = RadioGroup2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 311
    Width = 382
    Height = 122
    Caption = 'Settings'
    TabOrder = 7
    object lbleditDateTimeFormat: TLabeledEdit
      Left = 11
      Top = 40
      Width = 358
      Height = 23
      EditLabel.Width = 91
      EditLabel.Height = 15
      EditLabel.Caption = 'DateTime Format'
      TabOrder = 0
      Text = 'YYYY-MM-DD hh:nn:ss'
    end
    object lbleditLogFormat: TLabeledEdit
      Left = 11
      Top = 88
      Width = 358
      Height = 23
      EditLabel.Width = 61
      EditLabel.Height = 15
      EditLabel.Caption = 'Log Format'
      TabOrder = 1
      Text = '${time} ${username} ${eventid} [${log_type}] - ${message}'
    end
  end
  object chkActiveDeactive: TCheckBox
    Left = 8
    Top = 439
    Width = 97
    Height = 17
    Caption = 'Disable Log'
    TabOrder = 8
    OnClick = chkActiveDeactiveClick
  end
end
