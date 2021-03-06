unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, MyAccess,
  Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,sYSTEM.JSON,idHTTP,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, xmldom, Provider, Xmlxform,
  IdSSLOpenSSL, IdIOHandler, IdIOHandlerSocket, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,WinInet;
type
  TFormPrincipal = class(TForm)
    sqlLogin: TMyQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    rgFecha: TRadioGroup;
    dtInicio: TDateTimePicker;
    dtFin: TDateTimePicker;
    rgEstatus: TRadioGroup;
    rgPasiente: TRadioGroup;
    cbxPasiente: TComboBox;
    cbxMedico: TComboBox;
    txbIDpasiente: TEdit;
    txbIdMedico: TEdit;
    rgMedico: TRadioGroup;
    Panel3: TPanel;
    Label1: TLabel;
    dgvDatos: TDBGrid;
    dsDatos: TDataSource;
    sqlDatos: TMyQuery;
    Label2: TLabel;
    txbObservaciones: TMemo;
    Label3: TLabel;
    txbDiaCita: TEdit;
    Label4: TLabel;
    txbHorarioCita: TEdit;
    Label5: TLabel;
    txbPasiente: TEdit;
    Button1: TButton;
    sqlMedicos: TMyQuery;
    sqlPasiente: TMyQuery;
    Label6: TLabel;
    txbFolio: TEdit;
    sqlExec: TMyQuery;
    Button2: TButton;
    http: TIdHTTP;
    RESTClient1: TRESTClient;
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    Label7: TLabel;
    txbnPacientes: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure cbxMedicoChange(Sender: TObject);
    procedure cbxPasienteChange(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure sqlDatosAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    procedure cargar_datos;
    procedure cierra_login;
    procedure carga_medicos;
    procedure carga_pasientes;
    procedure convierte_datos(json:String);
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses UGeneral,Login,Cita;
{$R *.dfm}


function RemplazaCad(StrSrc, StrDest, Str : string) : string;
// RemplazaCad('hola','prueba','Esto es una prueba') = 'Esto es una hola'
begin
	while Pos(StrDest,Str) > 0 do
	begin
		Insert(StrSrc,Str,Pos(StrDest,Str));
		Delete(Str,Pos(StrDest,Str),Length(StrDest));
	end;
	RemplazaCad := Str;
end;

function GetUrlContent(const Url: string): UTF8String;
var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  Buffer: array[0..1023] of byte;
  BytesRead: dWord;
  StrBuffer: UTF8String;
begin
  Result := '';
  NetHandle := InternetOpen('Delphi 2009', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(NetHandle) then
    try
      UrlHandle := InternetOpenUrl(NetHandle, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD, 0);
      if Assigned(UrlHandle) then
        try
          repeat
            InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer), BytesRead);
            SetString(StrBuffer, PAnsiChar(@Buffer[0]), BytesRead);
            Result := Result + StrBuffer;
          until BytesRead = 0;
        finally
          InternetCloseHandle(UrlHandle);
        end
      else
        raise Exception.CreateFmt('Error de URL %s', [Url]);
    finally
      InternetCloseHandle(NetHandle);
    end
  else
    raise Exception.Create('Error al iniciar proceso Wininet');
end;
{ TFormPrincipal }
function MsgConfirma(mensaje, titulo : String) : boolean;
begin
  if application.MessageBox (pchar(mensaje),
      pchar(titulo), (MB_OKCANCEL + MB_ICONWARNING)) = IDOK then
    result := true
  else
    result := false;
end;

procedure TFormPrincipal.Button1Click(Sender: TObject);
begin
  if(sqlDatos.IsEmpty)then
  begin
    showMessage('NO hay informaci?n para consultar');
  end else
  begin
    FormCita.id_cita := StrToInt(Trim(txbFolio.Text));
    FOrmCita.tipo_pantalla := 'VER';
    FormCita.ShowModal;
  end;
  cargar_datos;
end;

procedure TFormPrincipal.Button2Click(Sender: TObject);
BEGIN
  with sqlExec do
  begin
    sql.Clear;
    sql.Add(' TRUNCATE TABLE t_pacientes');
   // txbObservaciones.Text := sqlExec.sql.Text;
    try
      execSQL;
    Except
      showMessage('Error al guardar log API.');
    end;
  end;
  //TXBoBSERVACIONES.Text := GetUrlContent('http://randomuser.me/api/?results=50');
  convierte_datos(GetUrlContent('http://randomuser.me/api/?results='+txbnPacientes.Text+''));//sepuede ajustar a cuantos cluientes se quiere dar de alta desde AP?
  with sqlExec do
  begin
    sql.Clear;
    sql.Add('INSERT INTO t_log_api');
    sql.Add('(fecha,num_registros)');
    sql.Add('values (');
    sql.Add('NOW(),'''+Trim(txbNPacientes.Text)+''')');
   // txbObservaciones.Text := sqlExec.sql.Text;
    try
      execSQL;
    Except
      showMessage('Error al guardar log API.');
    end;
  end;
end;

procedure TFormPrincipal.Button4Click(Sender: TObject);
begin
  if(sqlDatos.IsEmpty)then
  begin
    showMessage('NO hay informaci?n para cancelar');
  end else
  begin
      if(MsgConfirma('SE CANCELARA AL CITA CON FOLIO: ' + dgvDatos.Columns[0].Field.Text,'ATENCION') = true) then
      begin
        //-
        with sqlExec do
        begin
          sql.Clear;
          sql.Add('UPDATE t_agendas set');
          sql.Add('estatus = ''CANCELADA''');
          sql.Add('Where id_agenda = '+ dgvDatos.Columns[0].Field.Text);
        // txbObservaciones.Text := sqlExec.SQL.Text;
         try
            ExecSQL;
            with sqlExec do
            begin
              sql.Clear;
              sql.Add('UPDATE t_horarios set');
              sql.Add('disponible = ''S''');
              sql.Add('Where id_horario = '+ dgvDatos.Columns[8].Field.Text);
            // txbObservaciones.Text := sqlExec.SQL.Text;
             try
                ExecSQL;
                showMessage('El registro se actualizo correctamente');
              Except
                SHOWmESSAGE('Error al actualizar registro.');
              end;
            end;
          //  showMessage('El registro se actualizo correctamente');
          Except
            SHOWmESSAGE('Error al actualizar registro.');
          end;
        end;
        //-
      end;
  end;
end;

procedure TFormPrincipal.Button5Click(Sender: TObject);
begin
  //Truncar tabla
  cargar_datos;
end;

procedure TFormPrincipal.Button6Click(Sender: TObject);
begin
  fORMCita.tipo_pantalla := 'NEW';
  fORMcITA.ShowModal;
  cargar_datos;
end;

procedure TFormPrincipal.cargar_datos;
begin
  with sqlDatos do
  begin
    sql.Clear;
    sql.Add('select ad.id_agenda as FOLIO,ad.tipo_cita AS TIPO, CONCAT(pa.nombre,'' '',pa.ap_paterno) as PASIENTE,pa.edad AS EDAD,');
    sql.Add('DATE(h.dia) AS DIA,');
    sql.Add('h.id_horario as idHorario,');
    sql.Add('ad.estatus AS ESTATUS,');
    sql.Add('h.horario AS HORARIO,');
    sql.Add('ad.observaciones AS OBSERVACIONES');
    sql.Add('from t_agendas ad');
    sql.Add('LEFT OUTER JOIN t_pacientes pa ON pa.id_paciente = ad.id_paciente');
    sql.Add('LEFT OUTER JOIN t_horarios h on h.id_horario = ad.id_horario');
    sql.Add('WHERE ad.id_sucursal = 1');
    //RANGO DE FECHAS A FILTRAR
    if(rgFecha.ItemIndex = 0)then
    begin
      sql.Add('AND (DATE(h.dia) = DATE('''+FormatDateTime('yyyy/mm/dd',dtInicio.DateTime)+'''))');
    end else
    if(rgFecha.ItemIndex = 1)then
    begin
      sql.Add('AND (DATE(h.dia) BETWEEN DATE('''+FormatDateTime('yyyy/mm/dd',dtInicio.DateTime)+''') AND DATE('''+FormatDateTime('yyyy/mm/dd',DTfIN.DateTime)+'''))');
    end;
    //FILTRAR POR PASIENTE
    if(rgPasiente.ItemIndex = 1) then
    begin
      sql.Add('AND (pa.id_paciente = '''+Trim(txbIDpasiente.Text)+''')');
    end;
    //FILTRAR POR MEDICIO
    if(rgMedico.ItemIndex = 1)then
    begin
      sql.Add('AND (ad.id_medico = '''+Trim(txbIDMedico.Text)+''')');
    end;
    //FILTRAR POR ESTATUS
        if(rgEstatus.ItemIndex = 0)then
    begin
      sql.Add('AND (ad.estatus = ''CONFIRMADA'')');
    end else
        if(rgEstatus.ItemIndex = 1)then
    begin
      sql.Add('AND (ad.estatus = ''SIN CONFIRMAR'')');
    end else
        if(rgEstatus.ItemIndex = 2)then
    begin
      sql.Add('AND (ad.estatus = ''CANCELADA'')');
    end else
        if(rgEstatus.ItemIndex = 3)then
    begin
      sql.Add('AND (ad.estatus = ''ATENDIDA'')');
    end;

    sql.Add('ORDER BY FOLIO DESC');
    txbObservaciones.Text := sqlDatos.SQL.Text;
    try
      Open;
    Except
      showMessage('Error al cargar citas.');
    end;
  end;
end;

procedure TFormPrincipal.carga_medicos;
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

procedure TFormPrincipal.carga_pasientes;
begin
  with sqlPasiente do
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
  end;
end;

procedure TFormPrincipal.cbxMedicoChange(Sender: TObject);
begin
    if cbxMedico.ItemIndex <> -1 then
    sqlMedicos.Locate('FOLIO', Integer(cbxMedico.Items.Objects[cbxMedico.ItemIndex]),[]);
    txbIDMedico.Text := IntToStr(Integer(cbxMedico.Items.Objects[cbxMedico.ItemIndex]));
end;

procedure TFormPrincipal.cbxPasienteChange(Sender: TObject);
begin
    if cbxPasiente.ItemIndex <> -1 then
    sqlPasiente.Locate('FOLIO', Integer(cbxPasiente.Items.Objects[cbxPasiente.ItemIndex]),[]);
    txbIDPasiente.Text := IntToStr(Integer(cbxPasiente.Items.Objects[cbxPasiente.ItemIndex]));
end;

procedure TFormPrincipal.cierra_login;
begin
  with sqlLogin do
  begin
    sql.Clear;
    sql.Add('UPDATE t_usuarios SET');
    sql.Add('login = 0');
    sql.Add('WHERE id_usuario = '''+UGeneral.id_usuario+'''');
    try
      ExecSQL;
      FormLogin.Close;
    Except
      showMessage('Error al cerrar sesion.');
    end;
  end;
end;

procedure TFormPrincipal.convierte_datos(json: String);
var
  I:Integer;
   JSonValue:TJSonValue;
   st:string;
   nombre,paterno,materno,edad,localidad,telefono,correo: string;
begin
  for I := 0 to StrToInt(txbNPacientes.Text) -1do //Se recorre cuantas veces sean los usuarios requeridos para la sincronizaciond el aapi
  begin
   JsonValue := TJSonObject.ParseJSONValue(json);
   nombre := JsonValue.GetValue<string>('results['+I.ToString+'].name.first');
   paterno := JsonValue.GetValue<string>('results['+I.ToString+'].name.last');
   materno := JsonValue.GetValue<string>('results['+I.ToString+'].name.last');
   edad := JsonValue.GetValue<string>('results['+I.ToString+'].dob.age');
   localidad := JsonValue.GetValue<string>('results['+I.ToString+'].location.street.name');
   telefono := JsonValue.GetValue<string>('results['+I.ToString+'].cell');
   correo := JsonValue.GetValue<string>('results['+I.ToString+'].email');
   JsonValue.Free;
  // txbObservaciones.Text := nombre+ ' '+paterno+' '+materno+ ' cel: '+telefono;
   with sqlExec do
   begin
     sql.Clear;
     SQL.Add('INSERT INTO t_pacientes');
     SQL.Add('(nombre,ap_paterno,ap_materno,edad,correo,localidad,telefono)');
     SQL.Add('VALUES(');
     SQL.Add(''''+nombre+''',');
     SQL.Add(''''+paterno+''',');
     SQL.Add(''''+materno+''',');
     SQL.Add(''''+edad+''',');
     SQL.Add(''''+correo+''',');
     SQL.Add(''''+localidad+''',');
     SQL.Add(''''+telefono+''')');
     try
       ExecSQL;//Agrega usuarios a la tabla de pacientes.
     finally

     end;
   end;
  end;

end;

procedure TFormPrincipal.FormActivate(Sender: TObject);
begin
carga_medicos;
carga_pasientes;
  dtInicio.DateTime := now();
  dtFIn.DateTime := now();
  cargar_datos;
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cierra_login;
end;

procedure TFormPrincipal.sqlDatosAfterScroll(DataSet: TDataSet);
begin
  if(dgvDatos.DataSource.DataSet.RecNo > 0)then
  begin
    txbPasiente.Text := dgvDatos.Columns[2].Field.Text;
    txbDiaCita.Text := dgvDatos.Columns[4].Field.Text;
    txbHorarioCita.Text := dgvDatos.Columns[5].Field.Text;
    txbObservaciones.Text := dgvDatos.Columns[6].Field.Text;
    txbFolio.Text := dgvDatos.Columns[0].Field.Text;
  end;
end;

end.
