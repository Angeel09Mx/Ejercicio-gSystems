unit Cita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  MemDS, DBAccess, MyAccess, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TFormCita = class(TForm)
    Panel2: TPanel;
    Button4: TButton;
    btnGuardar: TButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    sqlPasiente: TMyQuery;
    sqlMedicos: TMyQuery;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    cbxMedico: TComboBox;
    txbIDMedico: TEdit;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    dtCita: TDateTimePicker;
    Label1: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    txbExpendiente: TEdit;
    GroupBox4: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    txbNombre: TEdit;
    txbPaterno: TEdit;
    txbMaterno: TEdit;
    txbEdad: TEdit;
    txbTelefono: TEdit;
    txbMail: TEdit;
    txbLocalidad: TEdit;
    Edit2: TEdit;
    cbxTipo: TComboBox;
    cbxMedio: TComboBox;
    sqlExec: TMyQuery;
    GroupBox5: TGroupBox;
    Label7: TLabel;
    txbObservaciones: TMemo;
    Button1: TButton;
    Label8: TLabel;
    cbxEstatus: TComboBox;
    txbIDPasiente: TEdit;
    sqlDatos: TMyQuery;
    txbIdHorario: TEdit;
    sqlhorario: TMyQuery;
    cbxHorarios: TComboBox;
    Label5: TLabel;
    Label9: TLabel;
    txbNOtas: TMemo;
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbxMedicoChange(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxHorariosChange(Sender: TObject);
  private
    { Private declarations }
        procedure carga_medicos;
    procedure carga_pasientes;
    procedure carga_horarios(id_medico:Integer);
  public
    { Public declarations }
    var id_cita:Integer;
    var tipo_pantalla:String;
  end;

var
  FormCita: TFormCita;

implementation

{$R *.dfm}

uses SeleccionarPasiente;

procedure TFormCita.Button1Click(Sender: TObject);
begin
  FOrmSeleccionarPasiente.ShowModal;
end;

procedure TFormCita.Button4Click(Sender: TObject);
begin
  FormCita.Close;
end;

procedure TFormCita.btnGuardarClick(Sender: TObject);
var respuesta_horario:Integer;
begin
  if(tipo_pantalla = 'NEW')then
  begin
    if(TrIm(txbidmedico.Text) = '0')then
    begin
      showMessage('Debes seleccionar un medico para generar la cita.');
    end else
    if( (Trim(txbNOmbre.Text) = '') or (Trim(txbPaterno.Text) = '') or (Trim(txbMaterno.Text) = '')   )then
    begin
      showMessage('El nombre completo no debe quedar vacio. verifica informacion.');
    end else
    if(cbxTipo.ItemIndex < 0)then
    begin
      showMessage('El tipo de la cita no puede quedar vacio.');
    end else
    if(cbxHorarios.ItemIndex < 0)then
    begin
      showMessage('Debes seleccionar un horario de la cita.');
    end else
    begin
      with sqlExec do
      begin
        sql.Clear;
        sql.Add('insert into t_agendas');
        sql.Add('(id_sucursal,id_paciente,id_medico,id_horario,tipo_cita,observaciones,notas)');
        sql.Add('VALUES');
        sql.Add('(1,'''+Trim(txbidPasiente.Text)+''','''+Trim(txbIDMedico.Text)+''',');
        sql.Add(''''+Trim(txbidHOrario.Text)+''',');
        sql.Add(''''+Trim(cbxTipo.Text)+''',');
        sql.Add(''''+Trim(txbobservaciones.text)+''',');
        sql.Add(''''+Trim(txbNotas.text)+''')');
      // txbObservaciones.Text := sqlExec.SQL.Text;
        try
          ExecSQL;
          //--cambia estatus de horario.
          with sqlExec do
          begin
            sql.Clear;
            SQL.Add('update t_horarios set disponible = ''N'' WHERE id_horario = '''+txbidHorario.Text+'''');
            try
              ExecSQL;
            finally

            end;
          end;
          showMessage('La cita se a ganerado correctamente!');
          FormCita.Close;
          btnGuardar.Enabled := false;
        Except
          SHOWmESSAGE('ERROR AL GENERAR CITA');
        end;
      end;
    end;
  enD ELSE
  if(tipo_pantalla = 'VER') then
  begin
    if(sqlDatos.FieldByName('estatus').AsString = 'CANCELADA')then
    begin
      showMessage('Esta cita ya se encuentra cancelada. ' + sLineBreak + 'No es posible realizar cambios.');
    end else
    begin
            with sqlExec do
      begin
        sql.Clear;
        sql.Add('UPDATE t_agendas SET');
        sql.Add('id_sucursal = 1,id_paciente = '''+Trim(txbidPasiente.Text)+''',id_medico = '''+Trim(txbIDMedico.Text)+''',');
        sql.Add('id_horario = '''+Trim(txbidHOrario.Text)+''',');
        sql.Add('tipo_cita = '''+Trim(cbxTipo.Text)+''',');
        sql.Add('observaciones = '''+Trim(txbobservaciones.text)+''',');
        sql.Add('notas = '''+Trim(txbNotas.text)+'''');

        sql.Add('where id_agenda = '''+id_cita.ToString+'''');
      //txbObservaciones.Text := sqlExec.SQL.Text;
        try
          ExecSQL;
          //--cambia estatus de horario.
          showMessage('La cita se a ganerado correctamente!');
          FormCita.Close;
          btnGuardar.Enabled := false;
        Except
          SHOWmESSAGE('ERROR AL GENERAR CITA');
        end;
      end;
    end;
  end;


end;

procedure TFormCita.carga_horarios(id_medico:Integer);
begin
  with sqlhorario do
  begin
    sql.Clear;
    sql.Add('SELECT');
    sql.Add('	a.id_horario AS FOLIO,');
    sql.Add('	a.horario AS NOMBRE ');
    sql.Add('FROM t_horarios a where disponible = ''S'' and id_medico = '''+id_medico.ToString+'''');
    try
      Open;
      sqlhorario.First;
      while not sqlhorario.Eof do
      begin
        cbxHOrarios.AddItem(sqlhorario.FieldByName('NOMBRE').AsString,
        TObject(sqlhorario.FieldByName('FOLIO').AsInteger));
        sqlhorario.Next;
      end;
    finally

    end;
  end;
end;

procedure TFormCita.carga_medicos;
begin
  with sqlMedicos do
  begin
    sql.Clear;
    sql.Add('SELECT');
    sql.Add('	a.id_medico AS FOLIO,');
    sql.Add('	a.nombre AS NOMBRE ');
    sql.Add('FROM t_medicos a');
    try
      Open;
      sqlMedicos.First;
      while not sqlMedicos.Eof do
      begin
        cbxMedico.AddItem(sqlMedicos.FieldByName('NOMBRE').AsString,
        TObject(sqlMedicos.FieldByName('FOLIO').AsInteger));
        sqlMedicos.Next;
      end;
    finally

    end;
  end;
end;

procedure TFormCita.carga_pasientes;
begin
 { with sqlPasiente do
  begin
    sql.Clear;
    sql.Add('SELECT');
    sql.Add('	a.id_paciente AS FOLIO,');
    sql.Add('	CONCAT(a.nombre,'' '',a.ap_paterno) AS NOMBRE ');
    sql.Add('FROM t_pacientes a');
    try
      Open;
      sqlPasiente.First;
      while not sqlPasiente.Eof do
      begin
        cbxPasiente.AddItem(sqlPasiente.FieldByName('NOMBRE').AsString,
        TObject(sqlPasiente.FieldByName('FOLIO').AsInteger));
        sqlPasiente.Next;
      end;
    finally

    end;
  end;  }
end;

procedure TFormCita.cbxHorariosChange(Sender: TObject);
begin
   if cbxHorarios.ItemIndex <> -1 then
    sqlHorario.Locate('FOLIO', Integer(cbxHorarios.Items.Objects[cbxHorarios.ItemIndex]),[]);
    txbIDHorario.Text := IntToStr(Integer(cbxHorarios.Items.Objects[cbxHorarios.ItemIndex]));
end;

procedure TFormCita.cbxMedicoChange(Sender: TObject);
begin
  cbxHorarios.Clear;
   if cbxMedico.ItemIndex <> -1 then
    sqlMedicos.Locate('FOLIO', Integer(cbxMedico.Items.Objects[cbxMedico.ItemIndex]),[]);
    txbIDMedico.Text := IntToStr(Integer(cbxMedico.Items.Objects[cbxMedico.ItemIndex]));
    carga_horarios(StrToINt(txbIDMedico.Text));
end;

procedure TFormCita.FormActivate(Sender: TObject);
var
  cc : integer ;
var
  i : Integer;

  begin
    for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
      end;
  end;
btnGuardar.Enabled := true;

  cbxMedico.Clear;
  cbxHorarios.Clear;
carga_medicos;
carga_pasientes;
dtCita.DateTime := NOW();
  if(tipo_pantalla = 'VER') then
  begin
    with sqlDatos do
    begin
      sql.Clear;
      sql.Add('SELECT');
      sql.Add('	m.id_medico AS idm,');
      sql.Add('	m.nombre AS medico,');
      sql.Add('	h.id_horario AS idh,');
      sql.Add('	h.horario AS horarios,');
      sql.Add(' p.id_paciente as id,');
      sql.Add('	p.nombre AS nom,');
      sql.Add('	p.ap_paterno AS pat,');
      sql.Add('	p.ap_materno AS mat,');
      sql.Add('	p.correo AS correo,');
      sql.Add('	p.localidad AS localidad,');
      sql.Add('	p.telefono AS tel,');
      sql.Add('	p.edad AS edad,');
      sql.Add('	a.tipo_cita AS tipo,');
      sql.Add('	a.estatus AS estatus,');
      sql.Add('	a.observaciones AS obs,');
      sql.Add('	a.notas AS notas');
      sql.Add('FROM t_agendas a');
      sql.Add('LEFT OUTER JOIN t_pacientes p ON p.id_paciente = a.id_paciente');
      sql.Add('LEFT OUTER JOIN t_medicos m ON m.id_medico = a.id_medico');
      sql.Add('LEFT OUTER JOIN t_horarios h on h.id_horario = a.id_horario');
      sql.Add('where a.id_agenda = '''+id_cita.ToString+''' ');
     // txbObservaciones.Text := sqlDatos.SQL.Text;
      try
        Open;

        cbxMedico.Text := sqlDatos.FieldByName('medico').AsString;
        txbNombre.Text := sqlDatos.FieldByName('nom').AsString;
        txbPaterno.Text := sqlDatos.FieldByName('pat').AsString;
        txbMaterno.Text := sqlDatos.FieldByName('mat').AsString;
        txbMail.Text := sqlDatos.FieldByName('correo').AsString;
        cbxHorarios.Text := sqlDatos.FieldByName('horarios').AsString;
        txbLocalidad.Text := sqlDatos.FieldByName('localidad').AsString;
        txbTelefono.Text := sqlDatos.FieldByName('tel').AsString;
        txbEdad.Text := sqlDatos.FieldByName('edad').AsString;
        txbObservaciones.Text := sqlDatos.FieldByName('obs').AsString;
        txbIDPasiente.Text := sqlDatos.FieldByName('id').AsString;
        txbIDhorario.Text := sqlDatos.FieldByName('idh').AsString;
        txbidMedico.Text := sqlDatos.FieldByName('idm').AsString;
        txbNotas.Text := sqlDatos.FieldByName('notas').AsString;
        //--
        for cc := 0 to cbxEstatus.Items.Count -1 do
        if cbxEstatus.Items [cc] = sqlDatos.FieldByName('estatus').AsString then
        begin
            cbxEstatus.Itemindex := cc ;
            break ;  // ... y sale del bucle "for"
        end;

        for cc := 0 to cbxTipo.Items.Count -1 do
        if cbxTipo.Items [cc] = sqlDatos.FieldByName('tipo').AsString then
        begin
            cbxTipo.Itemindex := cc ;
            break ;  // ... y sale del bucle "for"
        end;

        //--
      finally

      end;
    end;
end;
end;

end.
