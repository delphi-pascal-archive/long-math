object Form1: TForm1
  Left = 273
  Top = 116
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'LongMath'
  ClientHeight = 214
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 424
    Top = 44
    Width = 92
    Height = 13
    Caption = #1058#1086#1095#1085#1086#1089#1090#1100' '#1076#1077#1083#1077#1085#1080#1103
  end
  object Label2: TLabel
    Left = 312
    Top = 135
    Width = 71
    Height = 13
    Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100' '#1076#1086':'
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 193
    Height = 21
    TabOrder = 0
    Text = '0'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 360
    Top = 8
    Width = 193
    Height = 21
    TabOrder = 1
    Text = '2'
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 43
    Top = 160
    Width = 481
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object Button1: TButton
    Left = 246
    Top = 80
    Width = 75
    Height = 25
    Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object RadioButton1: TRadioButton
    Left = 216
    Top = 8
    Width = 30
    Height = 17
    Caption = '+'
    TabOrder = 4
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 256
    Top = 8
    Width = 30
    Height = 17
    Caption = '-'
    TabOrder = 5
    OnClick = RadioButton2Click
  end
  object RadioButton3: TRadioButton
    Left = 288
    Top = 8
    Width = 30
    Height = 17
    Caption = '*'
    TabOrder = 6
    OnClick = RadioButton3Click
  end
  object RadioButton4: TRadioButton
    Left = 320
    Top = 8
    Width = 30
    Height = 17
    Caption = '/'
    Checked = True
    TabOrder = 7
    TabStop = True
    OnClick = RadioButton4Click
  end
  object Edit4: TEdit
    Left = 520
    Top = 40
    Width = 33
    Height = 21
    TabOrder = 8
    Text = '2'
  end
  object Edit5: TEdit
    Left = 400
    Top = 132
    Width = 57
    Height = 21
    TabOrder = 9
    Text = '2'
  end
  object Button2: TButton
    Left = 474
    Top = 128
    Width = 49
    Height = 25
    Caption = #1054#1050
    TabOrder = 10
    OnClick = Button2Click
  end
  object RadioButton5: TRadioButton
    Left = 216
    Top = 40
    Width = 30
    Height = 17
    Caption = #1089#1088#1072#1074#1085#1080#1090#1100'.'
    TabOrder = 11
    OnClick = RadioButton5Click
  end
end
