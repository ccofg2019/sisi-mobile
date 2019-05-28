unit login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.Colors,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  REST.Types, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.DBScope ;

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
    labelSenha: TLabel;
    btnSubmit: TLayout;
    Rectangle1: TRectangle;
    Text2: TText;
    Image3: TImage;
    Timer1: TTimer;
    imgFooter: TImage;
    ed_usuario: TEdit;
    FDMemTable1: TFDMemTable;
    FDMemTable1token_type: TWideStringField;
    FDMemTable1expires_in: TWideStringField;
    FDMemTable1access_token: TWideStringField;
    FDMemTable1refresh_token: TWideStringField;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    edit1: TEdit;
    edit2: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    ed_senha: TEdit;
    Image1: TImage;
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

uses home, cadastro, System.JSON;
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
var
  token, user, pass: string;
  JSONObj: TJSONValue;
begin
   btnSubmit.AnimateFloat('Position.Y',420,2, TAnimationType.&Out, TInterpolationType.Elastic);
   btnSubmit.AnimateFloat('Position.Y',382,2, TAnimationType.&Out, TInterpolationType.Elastic);

  token := '{'+
 '	"grant_type": "password",  '+
 '	"client_id": "2",          '+
 '	"client_secret": "W46pOX8w61cCteGwnJDw3gvO6DjaVsJCv38eX3x3", '+
 '	"username":"'+ed_usuario.Text+'", '+
 '	"password":"'+ed_senha.Text+'", '+
 '	"scope": "*" '+
 '} ';
  //RESTRequest1.Method := TRESTRequestMethod.rmPOST;
  //RESTRequest1.Body.Add(JSONObj.ToString, ContentTypeFromString('application/json'));
  //RESTRequest1.AddParameter('body',memo1.Text,TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest1.Params.Items[1].Value := token;
  //RESTRequest1.Params.ParameterByName('body').AddValue(memo1.Text);
  RESTRequest1.Execute;
  if edit1.Text = '' then
  begin
    showMessage('Usuário/Senha não conferem');
  end else
  begin
    //showMessage('Acesso permitido!');
    timer1.Enabled := true;
  end;
end;

procedure Tfrm_login.Text1Click(Sender: TObject);
begin
  showMessage('Quem mandou esquecer seu login?');
end;

procedure Tfrm_login.Text4Click(Sender: TObject);
begin
  showMessage('Deixe da sua preguiça e faça seu cadastro no App! Mái menino...');
end;

procedure Tfrm_login.Timer1Timer(Sender: TObject);
begin
  try
    //if not Assigned(frm_home) then
    //begin
      //application.CreateForm(Tfrm_home, frm_home);
      frm_home.label10.Text := frm_login.ed_usuario.Text;
      ed_usuario.Text := '';
      ed_senha.Text   := '';
      frm_home.Show;
      timer1.Enabled := false;
    //end;
    finally
      //freeAndNil(frm_home);
  end;
end;

end.
