object FormLogin: TFormLogin
  Left = 0
  Top = 0
  Caption = 'FormLogin'
  ClientHeight = 450
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 18
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 294
    Height = 450
    Align = alClient
    TabOrder = 0
    object Image1: TImage
      Left = 56
      Top = 24
      Width = 177
      Height = 153
    end
    object Label1: TLabel
      Left = 120
      Top = 203
      Width = 62
      Height = 18
      Caption = 'CORREO:'
    end
    object Label2: TLabel
      Left = 104
      Top = 267
      Width = 98
      Height = 18
      Caption = 'CONTRASE'#209'A:'
    end
    object txbEmail: TEdit
      Left = 40
      Top = 227
      Width = 217
      Height = 26
      Alignment = taCenter
      TabOrder = 0
    end
    object txbPass: TEdit
      Left = 40
      Top = 291
      Width = 209
      Height = 26
      Alignment = taCenter
      TabOrder = 1
      OnKeyDown = txbPassKeyDown
    end
    object Button1: TButton
      Left = 40
      Top = 336
      Width = 100
      Height = 57
      Caption = 'ACCEDER'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 37
      Top = 399
      Width = 209
      Height = 42
      Caption = 'SALIR'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 146
      Top = 336
      Width = 100
      Height = 57
      Caption = 'REGISTRO'
      TabOrder = 4
      OnClick = Button3Click
    end
  end
  object sqlLogin: TMyQuery
    Connection = BD.conexion
    Left = 56
    Top = 176
  end
  object sqlExec: TMyQuery
    Connection = BD.conexion
    Left = 120
    Top = 152
  end
end
