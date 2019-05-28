program SISIapp;



uses
  System.StartUpCopy,
  FMX.Forms,
  login in 'login.pas' {frm_login},
  registroOcorrencias in 'registroOcorrencias.pas' {frm_registroOcorrencias},
  listaOcorrencias in 'listaOcorrencias.pas' {frm_listaOcorrencias},
  home in 'home.pas' {frm_home},
  u_validacao in 'u_validacao.pas' {frm_validacao},
  cadastro in 'cadastro.pas' {frm_cadastro},
  u_PowerManager in 'u_PowerManager.pas',
  u_registraOcorrencia in 'u_registraOcorrencia.pas' {frm_registraOcorrencia},
  cadastroIrregularidades in 'cadastroIrregularidades.pas' {frm_cadastroIrregularidades},
  listaIrregularidades in 'listaIrregularidades.pas' {frm_listaIrregularidades},
  registroIrregularidades in 'registroIrregularidades.pas' {frm_registroIrregularidades},
  UnitFormatCNPJCPF in 'UnitFormatCNPJCPF.pas',
  uGhiFuncoes in 'uGhiFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(Tfrm_validacao, frm_validacao);
  Application.CreateForm(Tfrm_home, frm_home);
  Application.CreateForm(Tfrm_listaOcorrencias, frm_listaOcorrencias);
  Application.CreateForm(Tfrm_registroOcorrencias, frm_registroOcorrencias);
  Application.CreateForm(Tfrm_cadastro, frm_cadastro);
  Application.CreateForm(Tfrm_registraOcorrencia, frm_registraOcorrencia);
  Application.CreateForm(Tfrm_cadastroIrregularidades, frm_cadastroIrregularidades);
  Application.CreateForm(Tfrm_listaIrregularidades, frm_listaIrregularidades);
  Application.CreateForm(Tfrm_registroIrregularidades, frm_registroIrregularidades);
  Application.Run;
end.
