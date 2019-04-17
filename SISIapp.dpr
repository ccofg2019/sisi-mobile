program SISIapp;

uses
  System.StartUpCopy,
  FMX.Forms,
  u_piloto in 'u_piloto.pas' {frm_piloto},
  login in 'login.pas' {frm_login},
  mapa in 'mapa.pas' {Form4},
  listaOcorrencias in 'listaOcorrencias.pas' {Form3},
  cadastro in 'cadastro.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_login, frm_login);
  Application.Run;
end.
