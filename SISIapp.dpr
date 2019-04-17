program SISIapp;



uses
  System.StartUpCopy,
  FMX.Forms,
  login in 'login.pas' {frm_login},
  listaOcorrencias in 'listaOcorrencias.pas' {Form3},
  cadastro in 'cadastro.pas' {Form2},
  home in 'home.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_login, frm_login);
  Application.Run;
end.
