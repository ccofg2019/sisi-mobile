program SISIapp;



uses
  System.StartUpCopy,
  FMX.Forms,
  login in 'login.pas' {frm_login},
  registroOcorrencias in 'registroOcorrencias.pas' {frm_registroOcorrencias},
  cadastro in 'cadastro.pas' {Form2},
  home in 'home.pas',
  listaOcorrencias in 'listaOcorrencias.pas' {frm_listaOcorrencias};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_login, frm_login);
  Application.CreateForm(Tfrm_listaOcorrencias, frm_listaOcorrencias);
  Application.Run;
end.
