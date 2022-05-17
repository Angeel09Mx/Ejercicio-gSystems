program Examen;

uses
  Vcl.Forms,
  Login in 'Login.pas' {FormLogin},
  Server in 'Server.pas' {BD: TDataModule},
  Principal in 'Principal.pas' {FormPrincipal},
  UGeneral in 'UGeneral.pas',
  Cita in 'Cita.pas' {FormCita},
  SeleccionarPasiente in 'SeleccionarPasiente.pas' {FormSeleccionarPasiente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TBD, BD);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormCita, FormCita);
  Application.CreateForm(TFormSeleccionarPasiente, FormSeleccionarPasiente);
  Application.Run;
end.
