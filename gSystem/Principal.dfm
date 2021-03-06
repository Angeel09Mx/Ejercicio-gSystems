object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'AGENDA'
  ClientHeight = 562
  ClientWidth = 1162
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object TPanel
    Left = 0
    Top = 0
    Width = 1162
    Height = 562
    Align = alClient
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1160
      Height = 112
      Align = alTop
      Color = clInactiveCaption
      ParentBackground = False
      TabOrder = 0
      object rgMedico: TRadioGroup
        Left = 529
        Top = 1
        Width = 319
        Height = 110
        Align = alLeft
        Caption = 'MEDICOS'
        ItemIndex = 0
        Items.Strings = (
          'TODO'
          'SOLO')
        TabOrder = 9
      end
      object rgPasiente: TRadioGroup
        Left = 217
        Top = 1
        Width = 312
        Height = 110
        Align = alLeft
        Caption = 'PACIENTES'
        ItemIndex = 0
        Items.Strings = (
          'TODO'
          'SOLO')
        TabOrder = 4
      end
      object rgFecha: TRadioGroup
        Left = 1
        Top = 1
        Width = 216
        Height = 110
        Align = alLeft
        Caption = 'MOSTRAR FECHAS'
        ItemIndex = 0
        Items.Strings = (
          'SOLO'
          'ENTRE'
          'TODO')
        TabOrder = 0
      end
      object dtInicio: TDateTimePicker
        Left = 69
        Top = 21
        Width = 129
        Height = 24
        Date = 44697.796148298610000000
        Time = 44697.796148298610000000
        TabOrder = 1
      end
      object dtFin: TDateTimePicker
        Left = 69
        Top = 51
        Width = 129
        Height = 24
        Date = 44697.796148298610000000
        Time = 44697.796148298610000000
        TabOrder = 2
      end
      object rgEstatus: TRadioGroup
        Left = 848
        Top = 1
        Width = 153
        Height = 110
        Align = alLeft
        Caption = 'MEDICOS'
        ItemIndex = 4
        Items.Strings = (
          'CONFIRMADA'
          'SIN CONFIRMAR'
          'CANCELADA'
          'ATENDIDA'
          'TODOS')
        TabOrder = 3
      end
      object cbxPasiente: TComboBox
        Left = 280
        Top = 72
        Width = 243
        Height = 24
        TabOrder = 5
        OnChange = cbxPasienteChange
      end
      object cbxMedico: TComboBox
        Left = 593
        Top = 72
        Width = 243
        Height = 24
        TabOrder = 6
        OnChange = cbxMedicoChange
      end
      object txbIDpasiente: TEdit
        Left = 488
        Top = 42
        Width = 35
        Height = 24
        Alignment = taCenter
        TabOrder = 7
        Text = '000'
      end
      object txbIdMedico: TEdit
        Left = 801
        Top = 42
        Width = 35
        Height = 24
        Alignment = taCenter
        Enabled = False
        TabOrder = 8
        Text = '000'
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 113
      Width = 96
      Height = 448
      Align = alLeft
      Color = clInactiveCaption
      ParentBackground = False
      TabOrder = 1
      ExplicitLeft = -5
      ExplicitTop = 118
      object Label7: TLabel
        Left = 8
        Top = 339
        Width = 59
        Height = 16
        Caption = 'pacientes:'
      end
      object Button4: TButton
        Left = 1
        Top = 137
        Width = 94
        Height = 56
        Align = alTop
        Caption = 'CANCELAR CITA'
        TabOrder = 0
        WordWrap = True
        OnClick = Button4Click
        ExplicitLeft = -4
        ExplicitTop = 143
      end
      object Button5: TButton
        Left = 1
        Top = 1
        Width = 94
        Height = 80
        Align = alTop
        Caption = 'ACTUALIZAR CITAS'
        TabOrder = 1
        WordWrap = True
        OnClick = Button5Click
        ExplicitLeft = -4
        ExplicitTop = -5
      end
      object Button6: TButton
        Left = 1
        Top = 81
        Width = 94
        Height = 56
        Align = alTop
        Caption = 'NUEVA CITA'
        TabOrder = 2
        WordWrap = True
        OnClick = Button6Click
        ExplicitLeft = -4
        ExplicitTop = 75
      end
      object Button2: TButton
        Left = 1
        Top = 391
        Width = 94
        Height = 56
        Align = alBottom
        Caption = 'SINCRONIZAR PACIENTES'
        TabOrder = 3
        WordWrap = True
        OnClick = Button2Click
        ExplicitLeft = -4
      end
      object txbnPacientes: TEdit
        Left = 8
        Top = 361
        Width = 82
        Height = 24
        Alignment = taCenter
        TabOrder = 4
        Text = '10'
      end
    end
    object Panel3: TPanel
      Left = 952
      Top = 113
      Width = 209
      Height = 448
      Align = alRight
      Color = clInactiveCaption
      ParentBackground = False
      TabOrder = 2
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 207
        Height = 446
        Align = alClient
        Caption = 'INFORMACION BASICA DE CITA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 6
        ExplicitTop = 5
      end
      object Label2: TLabel
        Left = 6
        Top = 193
        Width = 104
        Height = 16
        Caption = 'OBSERVACIONES:'
      end
      object Label3: TLabel
        Left = 6
        Top = 106
        Width = 76
        Height = 16
        Caption = 'DIA DE CITA:'
      end
      object Label4: TLabel
        Left = 6
        Top = 147
        Width = 59
        Height = 16
        Caption = 'HORARIO:'
      end
      object Label5: TLabel
        Left = 6
        Top = 67
        Width = 62
        Height = 16
        Caption = 'PACIENTE:'
      end
      object Label6: TLabel
        Left = 6
        Top = 21
        Width = 86
        Height = 16
        Caption = 'FOLIO DE CITA'
      end
      object txbObservaciones: TMemo
        Left = 6
        Top = 215
        Width = 195
        Height = 147
        ReadOnly = True
        TabOrder = 0
      end
      object txbDiaCita: TEdit
        Left = 6
        Top = 122
        Width = 195
        Height = 24
        ReadOnly = True
        TabOrder = 1
      end
      object txbHorarioCita: TEdit
        Left = 6
        Top = 163
        Width = 195
        Height = 24
        ReadOnly = True
        TabOrder = 2
      end
      object txbPasiente: TEdit
        Left = 6
        Top = 83
        Width = 195
        Height = 24
        ReadOnly = True
        TabOrder = 3
      end
      object Button1: TButton
        Left = 40
        Top = 368
        Width = 137
        Height = 73
        Caption = 'VER INFORMACION COMPLETA DE LA CITA'
        TabOrder = 4
        WordWrap = True
        OnClick = Button1Click
      end
      object txbFolio: TEdit
        Left = 6
        Top = 37
        Width = 195
        Height = 24
        ReadOnly = True
        TabOrder = 5
      end
    end
    object dgvDatos: TDBGrid
      Left = 97
      Top = 113
      Width = 855
      Height = 448
      Align = alClient
      DataSource = dsDatos
      DrawingStyle = gdsClassic
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'FOLIO'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PASIENTE'
          Title.Alignment = taCenter
          Width = 200
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'EDAD'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DIA'
          Title.Alignment = taCenter
          Width = 150
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'HORARIO'
          Title.Alignment = taCenter
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OBSERVACIONES'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ESTATUS'
          Title.Alignment = taCenter
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'idHorario'
          Visible = False
        end>
    end
  end
  object sqlLogin: TMyQuery
    Connection = BD.conexion
    Left = 688
    Top = 112
  end
  object dsDatos: TDataSource
    DataSet = sqlDatos
    Left = 576
    Top = 288
  end
  object sqlDatos: TMyQuery
    Connection = BD.conexion
    AfterScroll = sqlDatosAfterScroll
    Left = 440
    Top = 328
  end
  object sqlMedicos: TMyQuery
    Connection = BD.conexion
    Left = 280
    Top = 328
  end
  object sqlPasiente: TMyQuery
    Connection = BD.conexion
    Left = 296
    Top = 368
  end
  object sqlExec: TMyQuery
    Connection = BD.conexion
    Left = 520
    Top = 376
  end
  object http: TIdHTTP
    AllowCookies = False
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 912
    Top = 440
  end
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Params = <>
    HandleRedirects = True
    Left = 792
    Top = 312
  end
  object RESTResponse1: TRESTResponse
    Left = 680
    Top = 232
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 696
    Top = 424
  end
end
