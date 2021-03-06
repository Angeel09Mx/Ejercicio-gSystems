unit SeleccionarPasiente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, MemDS, DBAccess, MyAccess;

type
  TFormSeleccionarPasiente = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Label1: TLabel;
    txbDato: TEdit;
    Button3: TButton;
    DataSource1: TDataSource;
    sqlDatos: TMyQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSeleccionarPasiente: TFormSeleccionarPasiente;

implementation

{$R *.dfm}

uses Cita;

procedure TFormSeleccionarPasiente.Button1Click(Sender: TObject);
begin
  FormSeleccionarPasiente.Close;
end;

procedure TFormSeleccionarPasiente.Button2Click(Sender: TObject);
begin
  FOrmCita.txbNombre.Text := sqlDatos.FieldByName('nombre').AsString;
  FOrmCita.txbPaterno.Text := sqlDatos.FieldByName('ap_paterno').AsString;
  FOrmCita.txbMaterno.Text := sqlDatos.FieldByName('ap_materno').AsString;
  FOrmCita.txbIDPasiente.Text := sqlDatos.FieldByName('id_paciente').AsString;
  FOrmCita.txbMail.Text := sqlDatos.FieldByName('correo').AsString;
  FOrmCita.txbEdad.Text := sqlDatos.FieldByName('edad').AsString;
  FOrmCita.txbTelefono.Text := sqlDatos.FieldByName('telefono').AsString;
  FOrmCita.txbLocalidad.Text := sqlDatos.FieldByName('localidad').AsString;
  FormSeleccionarPasiente.Close;
end;

procedure TFormSeleccionarPasiente.Button3Click(Sender: TObject);
begin
  with sqlDatos do
  begin
    sql.Clear;
    sql.Add('SELECT * FROM t_pacientes pas');
    try
      Open;
    Except
      showMessage('error al cargar listaod.');
    end;
  end;
end;

procedure TFormSeleccionarPasiente.FormActivate(Sender: TObject);
begin
  with sqlDatos do
  begin
    sql.Clear;
    sql.Add('SELECT * FROM t_pacientes pas');
    try
      Open;
    Except
      showMessage('error al cargar listaod.');
    end;
  end;
end;

end.
