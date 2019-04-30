unit login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.Colors ;

type
  Tfrm_login = class(TForm)
    logoSisi: TImage;
    Text1: TText;
    btnCadastro: TText;
    loginOptions: TLayout;
    Text4: TText;
    formUsuario: TLayout;
    labelUsuario: TLabel;
    formSenha: TLayout;
    inputSenha: TEdit;
    labelSenha: TLabel;
    btnSubmit: TLayout;
    Rectangle1: TRectangle;
    Text2: TText;
    Image3: TImage;
    Timer1: TTimer;
    imgFooter: TImage;
    inputUsuario: TEdit;
    procedure btnSubmitClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_login: Tfrm_login;

implementation

{$R *.fmx}

uses home, cadastro;
{$R *.iPhone55in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure Tfrm_login.btnCadastroClick(Sender: TObject);
begin
   try
    if not Assigned(frm_cadastro) then
    begin
      application.CreateForm(Tfrm_cadastro, frm_cadastro);
      frm_cadastro.Show;
    end;
    finally
      freeAndNil(frm_cadastro);
  end;
end;

procedure Tfrm_login.btnSubmitClick(Sender: TObject);
begin
   btnSubmit.AnimateFloat('Position.Y',420,2, TAnimationType.&Out, TInterpolationType.Elastic);
   btnSubmit.AnimateFloat('Position.Y',388,2, TAnimationType.&Out, TInterpolationType.Elastic);
   timer1.Enabled := true;
end;

procedure Tfrm_login.Text1Click(Sender: TObject);
begin
  showMessage('Quem mandou esquecer seu login? Se lasque agora..');
end;

procedure Tfrm_login.Text4Click(Sender: TObject);
begin
  showMessage('Deixe da sua preguiça e faça seu cadastro no App! Mái menino...');
end;

procedure Tfrm_login.Timer1Timer(Sender: TObject);
begin
  try
    if not Assigned(frm_home) then
    begin
      application.CreateForm(Tfrm_home, frm_home);
      frm_home.Show;
      timer1.Enabled := false;
    end;
    finally
      freeAndNil(frm_home);
  end;
end;

end.
