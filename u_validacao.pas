unit u_validacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  REST.Types, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, REST.Response.Adapter, REST.Client, Data.Bind.ObjectScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, System.JSON, FMX.Effects,
  FMX.ScrollBox, FMX.Memo, FMX.Ani, System.Permissions, FGX.ProgressDialog;

type
  Tfrm_validacao = class(TForm)
    logoSisi: TImage;
    loginOptions: TLayout;
    btnCadastro: TText;
    Text1: TText;
    Text4: TText;
    Image3: TImage;
    imgFooter: TImage;
    formUsuario: TLayout;
    labelUsuario: TLabel;
    ed_usuario: TEdit;
    formSenha: TLayout;
    labelSenha: TLabel;
    ed_senha: TEdit;
    btnSubmit: TLayout;
    Rectangle1: TRectangle;
    Text2: TText;
    FDMemTable1: TFDMemTable;
    FDMemTable1token_type: TWideStringField;
    FDMemTable1expires_in: TWideStringField;
    FDMemTable1access_token: TWideStringField;
    FDMemTable1refresh_token: TWideStringField;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    edit2: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField2: TLinkControlToField;
    Memo1: TMemo;
    LinkControlToField1: TLinkControlToField;
    Image1: TImage;
    Label1: TLabel;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    fgActivityDialog: TfgActivityDialog;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    StyleBook1: TStyleBook;
    ClearEditButton2: TClearEditButton;
    Image2: TImage;
    Image4: TImage;
    PasswordEditButton1: TPasswordEditButton;
    procedure Rectangle1Click(Sender: TObject);
    procedure btnCadastroClick(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fgActivityDialogCancel(Sender: TObject);
    procedure ClearEditButton1Click(Sender: TObject);
    procedure ClearEditButton2Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
    FProgressDialogThread: TThread;
    FActivityDialogThread: TThread;
    Access_Fine_Location, Access_Coarse_Location, Access: String;
    procedure AnimaImg(Img: TText);
    procedure DoFinish(Sender: TObject);
    procedure DisplayRationale(Sender: TObject;
              const APermissions: TArray<string>; const APostRationaleProc: TProc);
    procedure LocationPermissionRequestResult(Sender: TObject;
              const APermission: TArray<string>;
              const AGrantResults: TArray<TPermissionStatus>);

  public
    { Public declarations }
  end;

var
  frm_validacao: Tfrm_validacao;

implementation

{$R *.fmx}

uses home, login, cadastro, FMX.DialogService, androidapi.Helpers, androidapi.JNI.javaTypes, androidapi.JNI.os;


procedure Tfrm_validacao.btnCadastroClick(Sender: TObject);
begin
  AnimaImg(btnCadastro);

  {try
    btnCadastro.AnimateFloat('Position.Y',30,2, TAnimationType.&Out, TInterpolationType.Elastic);
    btnCadastro.AnimateFloat('Position.Y',95,2, TAnimationType.&Out, TInterpolationType.Elastic);
    finally
      frm_cadastro.Show;
  end; }
end;

procedure Tfrm_validacao.ClearEditButton1Click(Sender: TObject);
begin
  ed_senha.Text := '';
end;

procedure Tfrm_validacao.ClearEditButton2Click(Sender: TObject);
begin
  ed_usuario.Text := '';
end;

procedure Tfrm_validacao.DisplayRationale(Sender: TObject;
  const APermissions: TArray<string>; const APostRationaleProc: TProc);
var
  I: Integer;
  RationaleMsg: string;
begin
  for I := 0 to High(APermissions) do
  begin
    if (APermissions[I] = Access_Coarse_Location) or (APermissions[I] = Access_Fine_Location) then
    begin
      Access := 'F';
      RationaleMsg := 'O SISI app precisa do acesso ao GPS para obter sua localização';
    end;
  end;

  TDialogService.ShowMessage(RationaleMsg,
    procedure(Const AResult: TModalResult)
    begin
      APostRationaleProc;
    end);

end;

procedure Tfrm_validacao.DoFinish(Sender: TObject);
var
  token, user, pass: string;
  JSONObj: TJSONValue;
begin
  {if (ed_usuario.Text = '') or (ed_senha.Text = '') then
  begin
    showMessage('Informe usuário e senha.');
    abort;
  end;

   try
     token := '{'+
     '	"grant_type": "password",  '+
     '	"client_id": "2",          '+
     '	"client_secret": "s5iMull7oik5GtCHR58d2pztye7DIUKnOmy5rcp1", '+
     '	"username":"'+ed_usuario.Text+'", '+
     '	"password":"'+ed_senha.Text+'", '+
     '	"scope": "*" '+
     '}// ';
 {     RESTRequest1.Params.Items[1].Value := token;
      RESTRequest1.Execute;
      if  (FDMemTable1.Fields.FieldByName('access_token').IsNull = true) then
      begin
        abort;
      end;

   timer1.Enabled := true;

   except on e:exception do
   begin
    showMessage('Usuário/Senha não conferem');
    abort;
   end;

   end; }

   frm_cadastro.Show;
end;

procedure Tfrm_validacao.fgActivityDialogCancel(Sender: TObject);
begin
  FProgressDialogThread.Terminate;
end;

procedure Tfrm_validacao.FormCreate(Sender: TObject);
begin
 {$IFDEF ANDROID}
  Access_Coarse_Location := JStringToString(TJManifest_permission.JavaClass.ACCESS_COARSE_LOCATION);
  Access_Fine_Location   := JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);
 {$ENDIF}


end;

procedure Tfrm_validacao.Image2Click(Sender: TObject);
begin
  ed_usuario.Text := '';
end;

procedure Tfrm_validacao.Image4Click(Sender: TObject);
begin
  ed_senha.Text := '';
end;

procedure Tfrm_validacao.LocationPermissionRequestResult(Sender: TObject;
  const APermission: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
var
  x: Integer;
begin
  if (Length(AGrantResults) = 2) and
     (AGrantResults[0] = TPermissionStatus.Granted) and
     (AGrantResults[1] = TPermissionStatus.Granted) then
     begin
      Access := 'T';
      text2.Text := 'CLIQUE NOVAMENTE PARA ENTRAR';
      //frm_validacao.btnSubmit.Enabled := true;
     end else
     begin
      //frm_validacao.btnSubmit.Enabled := false;
      Access := 'F';
      text2.Text := 'ENTRAR';
      TDialogService.ShowMessage('Para utilizar o SISI app é necessário permitir o acesso ao GPS do seu smatphone');
     end;
end;

procedure Tfrm_validacao.AnimaImg(Img: TText);
var
  objImg: TFloatAnimation;
begin
  objImg := TFloatAnimation.Create(Img);
  try
    objImg.Parent := Img;
    objImg.AnimationType := TAnimationType.Out;
    objImg.PropertyName := 'Position.X';
    objImg.Duration := 1;
    objImg.StartValue := 30;
    objImg.StopValue := 0;
    objImg.Interpolation := TInterpolationType.Elastic;
    objImg.OnFinish := DoFinish;
    objImg.Start;
  finally
    //objImg.Free;
  end;
end;

procedure Tfrm_validacao.Rectangle1Click(Sender: TObject);
var
  body, user, pass: string;
  JSONObj: TJSONValue;
begin
  btnSubmit.AnimateFloat('Position.X',0,2, TAnimationType.&Out, TInterpolationType.Elastic);
  btnSubmit.AnimateFloat('Position.X',30,2, TAnimationType.&Out, TInterpolationType.Elastic);

  if (ed_usuario.Text = '') or (ed_senha.Text = '') then
  begin
    showMessage('Informe usuário e senha.');
    abort;
  end;

  //Permissão de acesso ao GPS
  if btnSubmit.Enabled = true then
  begin
    {$IFDEF ANDROID}
    PermissionsService.RequestPermissions([Access_Coarse_Location,
                                             Access_Fine_Location],
                                             LocationPermissionRequestResult,
                                             DisplayRationale);
    {$ENDIF}
  end;


  if not fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Efetuando login no SISI';
            fgActivityDialog.Show;
          end);
          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;

          TThread.Synchronize(nil, procedure
          begin
          //Iniciando método de login via REST
          fgActivityDialog.Message := 'Aguarde...';
          if access = 'T' then
                begin
                 try
                   body := '{'+
                   '	"grant_type": "password",  '+
                   '	"client_id": "2",          '+
                   '	"client_secret": "s5iMull7oik5GtCHR58d2pztye7DIUKnOmy5rcp1", '+
                   '	"username":"'+ed_usuario.Text+'", '+
                   '	"password":"'+ed_senha.Text+'", '+
                   '	"scope": "*" '+
                   '}  ';
                    RESTRequest1.Params.Items[1].Value := body;
                    RESTRequest1.Execute;
                    if  (FDMemTable1.Fields.FieldByName('access_token').IsNull = true) then
                    begin
                      abort;
                    end;

                 except on e:exception do
                 begin
                  showMessage('Usuário/Senha não conferem');
                  abort;
                 end;
                end;

               end else
               begin
                 abort;
               end;
          end);
          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;

          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Login efetuado';
            frm_home.label10.Text := ed_usuario.Text;
            frm_home.title.Text := 'Usuário: '+ed_usuario.Text;
            ed_usuario.Text := '';
            ed_senha.Text   := '';
            text2.Text      := 'ENTRAR';
            frm_home.Show;
            //timer1.Enabled := false;

          end);
          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;

        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              fgActivityDialog.Hide;
            end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;
end;

procedure Tfrm_validacao.Text1Click(Sender: TObject);
begin
   text1.AnimateFloat('Position.Y',35,2, TAnimationType.&Out, TInterpolationType.Elastic);
   text1.AnimateFloat('Position.Y',0,2, TAnimationType.&Out, TInterpolationType.Elastic);
end;

procedure Tfrm_validacao.Text4Click(Sender: TObject);
begin
   text4.AnimateFloat('Position.Y',65,2, TAnimationType.&Out, TInterpolationType.Elastic);
   text4.AnimateFloat('Position.Y',35,2, TAnimationType.&Out, TInterpolationType.Elastic);
end;

end.
