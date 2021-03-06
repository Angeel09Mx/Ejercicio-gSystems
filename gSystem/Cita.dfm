object FormCita: TFormCita
  Left = 0
  Top = 0
  Caption = 'CITA'
  ClientHeight = 738
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 96
    Height = 738
    Align = alLeft
    Color = clInactiveCaption
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 602
    object Button4: TButton
      Left = 1
      Top = 81
      Width = 94
      Height = 56
      Align = alTop
      Caption = 'SALIR'
      TabOrder = 0
      WordWrap = True
      OnClick = Button4Click
    end
    object btnGuardar: TButton
      Left = 1
      Top = 1
      Width = 94
      Height = 80
      Align = alTop
      Caption = 'GUARDA CITA'
      TabOrder = 1
      WordWrap = True
      OnClick = btnGuardarClick
    end
  end
  object Panel1: TPanel
    Left = 96
    Top = 0
    Width = 623
    Height = 738
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 602
    object GroupBox1: TGroupBox
      Left = 1
      Top = 305
      Width = 621
      Height = 163
      Align = alTop
      Caption = 'INFORMACION CITA'
      TabOrder = 0
      ExplicitTop = 321
      object Label1: TLabel
        Left = 98
        Top = 27
        Width = 156
        Height = 16
        Caption = 'EXPEDIENTE DE PACIENTE:'
      end
      object Label3: TLabel
        Left = 170
        Top = 57
        Width = 84
        Height = 16
        Caption = 'TIPO DE CITA:'
      end
      object Label6: TLabel
        Left = 69
        Top = 87
        Width = 185
        Height = 16
        Caption = 'MEDIO POR DONDE SE ENTERO:'
      end
      object Label8: TLabel
        Left = 194
        Top = 127
        Width = 60
        Height = 16
        Caption = 'ESTATUS:'
      end
      object txbExpendiente: TEdit
        Left = 260
        Top = 24
        Width = 106
        Height = 24
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 372
        Top = 24
        Width = 237
        Height = 24
        TabOrder = 1
      end
      object cbxTipo: TComboBox
        Left = 260
        Top = 54
        Width = 341
        Height = 24
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = 'SIN DEFINIR'
        Items.Strings = (
          'SIN DEFINIR'
          'REVISON'
          'ESTUDIOS')
      end
      object cbxMedio: TComboBox
        Left = 260
        Top = 84
        Width = 341
        Height = 24
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = 'NADA'
        Items.Strings = (
          'NADA'
          'PAGINA WEB'
          'AMIGO'
          'REDES SOCIALES'
          'FOLLETO')
      end
      object cbxEstatus: TComboBox
        Left = 260
        Top = 123
        Width = 341
        Height = 24
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'SIN CONFIRMAR'
        Items.Strings = (
          'SIN CONFIRMAR'
          'CONFIRMADA'
          'CANCELADA'
          'ATENDIDA')
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 621
      Height = 64
      Align = alTop
      Caption = 'INFORMACION DEL MEDICO'
      TabOrder = 1
      object Label2: TLabel
        Left = 25
        Top = 28
        Width = 51
        Height = 16
        Caption = 'MEDICO:'
      end
      object cbxMedico: TComboBox
        Left = 82
        Top = 25
        Width = 243
        Height = 24
        TabOrder = 0
        OnChange = cbxMedicoChange
      end
      object txbIDMedico: TEdit
        Left = 331
        Top = 25
        Width = 35
        Height = 24
        Alignment = taCenter
        Enabled = False
        TabOrder = 1
        Text = '0'
        Visible = False
      end
    end
    object GroupBox3: TGroupBox
      Left = 1
      Top = 65
      Width = 621
      Height = 88
      Align = alTop
      Caption = 'HORARIO DE LA CITA'
      TabOrder = 2
      object Label4: TLabel
        Left = 115
        Top = 27
        Width = 25
        Height = 16
        Caption = 'DIA:'
      end
      object Label5: TLabel
        Left = 81
        Top = 56
        Width = 59
        Height = 16
        Caption = 'HORARIO:'
      end
      object dtCita: TDateTimePicker
        Left = 146
        Top = 23
        Width = 129
        Height = 24
        Date = 44697.796148298610000000
        Time = 44697.796148298610000000
        TabOrder = 0
      end
      object txbIdHorario: TEdit
        Left = 311
        Top = 52
        Width = 67
        Height = 24
        Enabled = False
        TabOrder = 1
        Visible = False
      end
      object cbxHorarios: TComboBox
        Left = 146
        Top = 53
        Width = 159
        Height = 24
        Style = csDropDownList
        TabOrder = 2
        OnChange = cbxHorariosChange
      end
    end
    object GroupBox4: TGroupBox
      Left = 1
      Top = 153
      Width = 621
      Height = 152
      Align = alTop
      Caption = 'INFORMACION DEL PACIENTE'
      TabOrder = 3
      ExplicitTop = 169
      object Label12: TLabel
        Left = 98
        Top = 27
        Width = 54
        Height = 16
        Caption = 'NOMBRE:'
      end
      object Label13: TLabel
        Left = 33
        Top = 57
        Width = 119
        Height = 16
        Caption = 'APELLIDO PATERNO:'
      end
      object Label14: TLabel
        Left = 30
        Top = 87
        Width = 122
        Height = 16
        Caption = 'APELLIDO MATERNO:'
      end
      object Label15: TLabel
        Left = 396
        Top = 27
        Width = 36
        Height = 16
        Caption = 'EDAD:'
      end
      object Label16: TLabel
        Left = 575
        Top = 27
        Width = 32
        Height = 16
        Caption = 'A'#241'os.'
      end
      object Label17: TLabel
        Left = 388
        Top = 54
        Width = 66
        Height = 16
        Caption = 'TELEFONO:'
      end
      object Label18: TLabel
        Left = 98
        Top = 117
        Width = 54
        Height = 16
        Caption = 'CORREO:'
      end
      object Label19: TLabel
        Left = 388
        Top = 93
        Width = 70
        Height = 16
        Caption = 'LOCALIDAD:'
      end
      object txbNombre: TEdit
        Left = 158
        Top = 24
        Width = 147
        Height = 24
        Enabled = False
        TabOrder = 0
      end
      object txbPaterno: TEdit
        Left = 158
        Top = 54
        Width = 208
        Height = 24
        Enabled = False
        TabOrder = 1
      end
      object txbMaterno: TEdit
        Left = 158
        Top = 84
        Width = 208
        Height = 24
        Enabled = False
        TabOrder = 2
      end
      object txbEdad: TEdit
        Left = 460
        Top = 24
        Width = 109
        Height = 24
        Alignment = taRightJustify
        NumbersOnly = True
        TabOrder = 3
        Text = '18'
      end
      object txbTelefono: TEdit
        Left = 460
        Top = 54
        Width = 109
        Height = 24
        Alignment = taCenter
        NumbersOnly = True
        TabOrder = 4
      end
      object txbMail: TEdit
        Left = 158
        Top = 114
        Width = 208
        Height = 24
        Enabled = False
        TabOrder = 5
      end
      object txbLocalidad: TEdit
        Left = 388
        Top = 115
        Width = 221
        Height = 24
        TabOrder = 6
      end
      object Button1: TButton
        Left = 311
        Top = 23
        Width = 59
        Height = 25
        Caption = 'Pacientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = Button1Click
      end
      object txbIDPasiente: TEdit
        Left = 25
        Top = 24
        Width = 67
        Height = 24
        Enabled = False
        TabOrder = 8
        Visible = False
      end
    end
    object GroupBox5: TGroupBox
      Left = 1
      Top = 468
      Width = 621
      Height = 253
      Align = alTop
      Caption = 'INFORMACION EXTRA'
      TabOrder = 4
      ExplicitLeft = 6
      ExplicitTop = 474
      object Label7: TLabel
        Left = 25
        Top = 27
        Width = 99
        Height = 16
        Caption = 'OBSERVACIONES'
      end
      object Label9: TLabel
        Left = 17
        Top = 114
        Width = 107
        Height = 16
        Caption = ' NOTAS MEDICAS:'
      end
      object txbObservaciones: TMemo
        Left = 130
        Top = 32
        Width = 471
        Height = 73
        TabOrder = 0
      end
      object txbNOtas: TMemo
        Left = 130
        Top = 111
        Width = 471
        Height = 130
        TabOrder = 1
      end
    end
  end
  object sqlPasiente: TMyQuery
    Connection = BD.conexion
    Left = 320
    Top = 264
  end
  object sqlMedicos: TMyQuery
    Connection = BD.conexion
    Left = 240
    Top = 312
  end
  object sqlExec: TMyQuery
    Connection = BD.conexion
    Left = 240
    Top = 432
  end
  object sqlDatos: TMyQuery
    Connection = BD.conexion
    Left = 400
    Top = 336
  end
  object sqlhorario: TMyQuery
    Connection = BD.conexion
    Left = 208
    Top = 408
  end
end
