object FormSeleccionarPasiente: TFormSeleccionarPasiente
  Left = 0
  Top = 0
  Caption = 'FormSeleccionarPasiente'
  ClientHeight = 299
  ClientWidth = 635
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
    Width = 635
    Height = 299
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 504
    ExplicitTop = 128
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Panel2: TPanel
      Left = 1
      Top = 232
      Width = 633
      Height = 66
      Align = alBottom
      Color = clInactiveCaption
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 233
      object Button1: TButton
        Left = 456
        Top = 1
        Width = 176
        Height = 64
        Align = alRight
        Caption = 'CERRAR'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 1
        Top = 1
        Width = 176
        Height = 64
        Align = alLeft
        Caption = 'SELECCIONAR'
        TabOrder = 1
        OnClick = Button2Click
        ExplicitLeft = 456
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 89
      Width = 633
      Height = 143
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 633
      Height = 88
      Align = alTop
      Color = clInactiveCaption
      ParentBackground = False
      TabOrder = 2
      object Label1: TLabel
        Left = 32
        Top = 24
        Width = 59
        Height = 18
        Caption = 'BUSCAR:'
      end
      object txbDato: TEdit
        Left = 97
        Top = 21
        Width = 368
        Height = 26
        TabOrder = 0
      end
      object Button3: TButton
        Left = 480
        Top = 22
        Width = 129
        Height = 25
        Caption = 'actualizar'
        TabOrder = 1
        OnClick = Button3Click
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = sqlDatos
    Left = 464
    Top = 168
  end
  object sqlDatos: TMyQuery
    Connection = BD.conexion
    Left = 312
    Top = 152
  end
end
