unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  MemDS, DBAccess, MyAccess;

type
  TFormLogin = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    txbEmail: TEdit;
    txbPass: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    sqlLogin: TMyQuery;
    sqlExec: TMyQuery;
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure txbPassKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    var pass_index,correo_index:String;
    procedure validacion_login;
    procedure validacion_registro;
    var existe_usuario:Integer;
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}

uses Principal,UGeneral;

function emailValido(const email : string) : boolean;
  function caracterPermitido(const s : string) : boolean;
    var i : integer;
  begin
    Result := False;
    for i := 1 to Length(s) do
      if not (s[i] in ['a'..'z','A'..'Z','0'..'9','_','-','.']) then
        exit;
    Result := true;
  end;
var
  i, longitudServidor : integer;
  parteUsuario, parteServidor : string;
begin
  Result := False;
  i := Pos('@', email);

  if (i = 0) or (i = 1) or (Pos('..', email) > 0) then
    exit;
  parteUsuario := Copy(email, 1, i - 1);
  parteServidor := Copy(email, i + 1, Length(email));
  longitudServidor := Length(parteServidor);
  if (longitudServidor < 3) or (Pos('.', parteServidor) = 0) or
      (parteServidor[1] = '.') or (parteServidor[longitudServidor] = '.') or
      (parteServidor[longitudServidor - 1] = '.') then
    exit;
  Result := caracterPermitido(parteUsuario) and
      caracterPermitido(parteServidor);
end;

procedure TFormLogin.Button1Click(Sender: TObject);
begin
  validacion_login;
end;

procedure TFormLogin.Button2Click(Sender: TObject);
begin
  FormLogin.Close;
end;

procedure TFormLogin.Button3Click(Sender: TObject);
begin
  validacion_registro;
end;

procedure TFormLogin.FormActivate(Sender: TObject);
begin
  pass_index := '123456';
  correo_index := 'correo@cliente.com';
end;

procedure TFormLogin.txbPassKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(key = vk_return)then
  begin
    validacion_login
  end;
end;

procedure TFormLogin.validacion_login;
var existe_Integer:Integer;
begin
 //Iincia validaciones.
    if( (Trim(txbEmail.Text) = '') or (Length(txbEmail.Text) <= 0) )then
    begin
      showMessage('Debes ingresar tu correo para acceder a la plataforma.');
      txbEmail.SetFocus;
      txbEmail.SelectAll;
    end else
    if( (Trim(txbPass.Text) = '') or (Length(txbPass.Text) <= 0) )then
    begin
      showMessage('Debes ingresar tu contrase?a para acceder a la plataforma.');
      txbPass.SetFocus;
      txbPass.SelectAll;
    end else
    if(emailValido(Trim(txbEmail.Text)) = false)then
    begin
      showMessage('El correo electronico no tiene el formato correcto..');
      txbEmail.SelectAll;
    end else
    begin
      with sqlLogin do
      begin
        //-INICIO DE sqlLogin
        sql.Clear;
        sql.Add('SELECT');
        sql.Add(' us.login AS isLogin,');
        sql.Add(' us.id_usuario as id,');
        sql.Add(' us.correo as mail,');
        sql.Add('	COUNT(*) AS existe');
        sql.Add('FROM t_usuarios us');
        sql.Add('WHERE us.correo = '''+Trim(txbEmail.Text)+''' AND us.password = MD5('''+Trim(txbPass.Text)+''')');
        try
       // Memo1.Text := sqlLogin.SQL.Text;
        Open;
        //verifica si existe usuario en bd
        existe_usuario := sqlLogin.FieldByName('existe').AsInteger;

        if(existe_usuario <= 0)then
        begin
          showMessage('Los datos ingresados no corresponden a ninguna cuenta registrada o algun dato es incorrecto verifica la informaci?n.');
          txbEmail.SelectAll;
          //txbPass.PasswordChar := #0;
          txbEmail.SetFocus;
        end else
        if(existe_usuario >= 1)then
        begin
          if(sqlLogin.FieldByName('isLogin').AsInteger = 1)then
          begin
            showMessage('El usuario ya se encuentra logeado. Cierra sesion en el dispositivo donde iniciaste sesion anteiormente');
            Exit;
          end;
          UGeneral.id_usuario := sqlLogin.fieldbyname('id').AsString;
          UGeneral.correo_usuario := sqlLogin.fieldbyname('mail').AsString;
          with sqlLogin do
          begin
            sql.Clear;
            sql.Add('UPDATE t_usuarios SET');
            sql.Add('login = 1');
            sql.Add('WHERE id_usuario = '''+UGeneral.id_usuario+'''');
            try
              //cambia bandera para detectar que ya ah sido logueado el usuario y no pse pueda logear en otro dispositivo por seguridad
              ExecSQL;
            Except
              showMessage('Error al cerrar sesion.');
            end;
          end;
          FormPrincipal.Show;


        //  FormLogin.Hide;
        end;

        Except
          showMessage('Error al validar usuario.');
        end;
      end;
    end;

end;

procedure TFormLogin.validacion_registro;
var existe_Integer:Integer;
begin
    if( (Trim(txbEmail.Text) = '') or (Length(txbEmail.Text) <= 0) )then
    begin
      showMessage('Debes ingresar un correo para realizar el registro');
      txbEmail.SetFocus;
      txbEmail.SelectAll;
    end else
    if( (Trim(txbPass.Text) = '') or (Length(txbPass.Text) <= 0) )then
    begin
      showMessage('Debes ingresar una contrase?a para realizar el registro.');
      txbPass.SetFocus;
      txbPass.SelectAll;
    end else
    if(emailValido(Trim(txbEmail.Text)) = false)then
    begin
      showMessage('El correo electronico no tiene el formato correcto..');
      txbEmail.SelectAll;
    end else
    begin
      with sqlLogin do
      begin
        //-INICIO DE SQLOOGN
        sql.Clear;
        sql.Add('SELECT');
        sql.Add('	COUNT(*) AS existe');
        sql.Add('FROM t_usuarios us');
        sql.Add('WHERE us.correo = '''+Trim(txbEmail.Text)+'''');
        try
        //Memo1.Text := sqlLogin.SQL.Text;
        Open;
        existe_usuario := sqlLogin.FieldByName('existe').AsInteger;

        if(existe_usuario <= 0)then
        begin
            with sqlExec do
            begin
              sql.Clear;
              sql.Add('insert into t_usuarios (correo,password)');
              sql.Add('values (');
              sql.Add(''''+TRIM(txbEmail.Text)+''',');
              sql.Add('MD5('''+Trim(txbPass.Text)+'''))');
              //Memo1.Text := sqlExec.SQL.Text;
              try
                ExecSQL;
              Except
                showMessage('Error al registrar usuario.');
              end;
            end;
        end else
        if(existe_usuario >= 1)then
        begin
          showMessage('Ya existe un usuario registrado con este correo electronico.');
          txbEmail.SelectAll;
        end;

        Except
          showMessage('Error al validar usuario.');
        end;
      end;
    end;
end;

end.
