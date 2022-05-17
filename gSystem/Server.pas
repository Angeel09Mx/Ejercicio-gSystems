unit Server;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, MyAccess;

type
  TBD = class(TDataModule)
    conexion: TMyConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BD: TBD;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
