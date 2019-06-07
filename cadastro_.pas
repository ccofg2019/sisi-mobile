unit cadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Objects, FMX.Edit,
  FMX.ListBox, REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, FMX.DateTimeCtrls, System.MaskUtils,
  FMX.Effects, FMX.ScrollBox, FMX.Memo;

type
  Tfrm_cadastro = class(TForm)
    header: TLayout;
    ToolBar1: TToolBar;
    menu: TSpeedButton;
    cadastro: TText;
    Rectangle10: TRectangle;
    VertScrollBox1: TVertScrollBox;
    formCel: TLayout;
    inputCel: TEdit;
    labelCel: TLabel;
    formConfirmarSenha: TLayout;
    inputConfirmarSenha: TEdit;
    labelConfirmarSenha: TLabel;
    formCpf: TLayout;
    inputCpf: TEdit;
    labelCpf: TLabel;
    formDataNasc: TLayout;
    labelDataNasc: TLabel;
    formEmail: TLayout;
    labelEmail: TLabel;
    inputEmail: TEdit;
    formEtnia: TLayout;
    labelEtnia: TLabel;
    inputEtnia: TComboBox;
    formGenero: TLayout;
    labelGenero: TLabel;
    inputGenero: TComboBox;
    formNome: TLayout;
    inputNome: TEdit;
    labelNome: TLabel;
    formSenha: TLayout;
    inputSenha: TEdit;
    labelSenha: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Layout4: TLayout;
    Rectangle12: TRectangle;
    Text1: TText;
    inputDataNasc: TDateEdit;
    PasswordEditButton2: TPasswordEditButton;
    PasswordEditButton3: TPasswordEditButton;
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;
    procedure menuClick(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure inputNomeEnter(Sender: TObject);
    procedure inputDataNascEnter(Sender: TObject);
    procedure inputEmailEnter(Sender: TObject);
    procedure inputSenhaEnter(Sender: TObject);
    procedure inputGeneroEnter(Sender: TObject);
    procedure inputEtniaEnter(Sender: TObject);
    procedure inputCelEnter(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure inputCpfEnter(Sender: TObject);
    procedure inputConfirmarSenhaEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure inputCpfExit(Sender: TObject);
  private
    { Private declarations }
    vFoco: TControl;
    procedure ajustar_scroll();
    procedure limpaCampos();

  public
    { Public declarations }
  end;

var
  frm_cadastro: Tfrm_cadastro;

implementation

{$R *.fmx}

function Cpf(CPF_Text: string): boolean;
var n1,n2,n3,n4,n5,n6,n7,n8,n9: integer;
       d1,d2: integer;
       digitado, calculado: string;
begin
   n1:=StrToInt(CPF_Text[1]);
   n2:=StrToInt(CPF_Text[2]);
   n3:=StrToInt(CPF_Text[3]);
   n4:=StrToInt(CPF_Text[5]);
   n5:=StrToInt(CPF_Text[6]);
   n6:=StrToInt(CPF_Text[7]);
   n7:=StrToInt(CPF_Text[9]);
   n8:=StrToInt(CPF_Text[10]);
   n9:=StrToInt(CPF_Text[11]);
                     d1:=n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1:=11-(d1 mod 11);
   if d1>=10 then d1:=0;
        d2:=d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
    d2:=11-(d2 mod 11);
    if d2>=10 then
       d2:=0;
    calculado:=inttostr(d1)+inttostr(d2);
   digitado:=CPF_Text[13]+CPF_Text[14];
   if calculado=digitado then
       Cpf:=true
   else
       Cpf:=false;
end;

procedure Tfrm_cadastro.ajustar_scroll;
var
  x: integer;
begin
    VertScrollBox1.Margins.Bottom := 250;
    VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, TControl(vFoco).Position.Y - 90);
end;

procedure Tfrm_cadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  limpaCampos;
end;

procedure Tfrm_cadastro.FormShow(Sender: TObject);
begin
  inputNome.SetFocus;
end;

procedure Tfrm_cadastro.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  VertScrollBox1.Margins.Bottom := 0;
end;

procedure Tfrm_cadastro.inputCelEnter(Sender: TObject);
begin
  vFoco := TControl(TEdit(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_cadastro.inputConfirmarSenhaEnter(Sender: TObject);
begin
  vFoco := TControl(TEdit(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_cadastro.inputCpfEnter(Sender: TObject);
begin
  vFoco := TControl(TEdit(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_cadastro.inputCpfExit(Sender: TObject);
var tamanho :integer;
var sCpf: string;
begin
  sCpf := FormatMaskText('000\.000\.000\-00;0;', inputCpf.text);
  inputCpf.Text := '';
  inputcpf.Text := sCpf;
  sCpf := '';
 {If sCpf<>'' Then
  begin
  tamanho := length(sCpf);
  //showmessage(intToStr(length(tamanho)));
   if tamanho < 14 then
   begin
   //MessageDlg('Informe um CPF válido.',mtError, [mbOk],0);
   showMessage('Informe um CPF válido1.');
   //inputCpf.SetFocus;
   //abort;
   end else
    If Cpf(sCpf)=False Then
      Begin
        showMessage('Informe um CPF válido2.');
        //inputCpf.SetFocus;
        //abort;
      End;
   end;
 { if (inputCpf.Text  = '000.000.000-00') or (inputCpf.Text  = '111.111.111-11') or (inputCpf.Text  = '222.222.222-22') or (inputCpf.Text  = '333.333.333-33') or (inputCpf.Text  = '444.444.444-44') or (inputCpf.Text  = '555.555.555-55') or
  (inputCpf.Text  = '777.777.777-77') or (inputCpf.Text  = '888.888.888-88') or (inputCpf.Text  = '999.999.999-99') then
  begin
   //MessageDlg('CPF informado inválido.',mtError, [mbOk],0);
   showMessage('CPF informado inválido.');
   //inputCpf.SetFocus;
   //abort;
  end;  }

  //inputCpf.text :=  FormatMaskText('000\.000\.000\-00;0;', inputCpf.text);
end;


procedure Tfrm_cadastro.inputDataNascEnter(Sender: TObject);
begin
  vFoco := TControl(TEdit(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_cadastro.inputEmailEnter(Sender: TObject);
begin
  vFoco := TControl(TEdit(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_cadastro.inputEtniaEnter(Sender: TObject);
begin
  vFoco := TControl(TComboBox(sender).Parent);
  //ajustar_scroll();
end;

procedure Tfrm_cadastro.inputGeneroEnter(Sender: TObject);
begin
  vFoco := TControl(TComboBox(sender).Parent);
  //ajustar_scroll();
end;

procedure Tfrm_cadastro.inputNomeEnter(Sender: TObject);
begin
  vFoco := TControl(TEdit(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_cadastro.inputSenhaEnter(Sender: TObject);
begin
  vFoco := TControl(TEdit(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_cadastro.limpaCampos;
begin
  inputNome.Text := '';
  inputCPF.Text := '';
  inputDataNasc.IsEmpty := true;
  inputEmail.Text := '';
  inputSenha.Text := '';
  inputConfirmarSenha.Text := '';
  inputGenero.ItemIndex := -1;
  inputEtnia.ItemIndex  := -1;
  inputCel.Text := '';
end;

procedure Tfrm_cadastro.menuClick(Sender: TObject);
begin
  limpaCampos;
  close;
end;

procedure Tfrm_cadastro.Text1Click(Sender: TObject);
var
  body, user, pass: string;
  JSONObj: TJSONValue;
begin

  if (inputSenha.Text <> inputConfirmarSenha.text) then
  begin
   showMessage('Senha não confere. Digite novamente.');
   inputSenha.Text := '';
   inputConfirmarSenha.text := '';
   abort;
  end;

  if inputEmail.Text = '' then
  begin
    showMessage('Informe seu e-mail.');
    abort;
  end;

  layout4.AnimateFloat('Position.Y',30,2, TAnimationType.&Out, TInterpolationType.Elastic);
  layout4.AnimateFloat('Position.Y',0,2, TAnimationType.&Out, TInterpolationType.Elastic);

   try
     body := '{'+
'    "name": "'+inputNome.Text+'",'+
'    "cpf": "'+inputCpf.Text+'",      '+
'    "birthdate": "1994-12-12",'+
'    "gender": "FEMININO", '+
'    "skin_color": "BRANCO", '+
'    "cellphone": "'+inputCel.Text+'", '+
'    "phone": "'+inputCel.Text+'",  '+
'    "status": "ATIVO",   '+
'    "email": "'+inputEmail.Text+'", '+
'    "password": "'+inputSenha.Text+'"  '+
'}';
      //RESTRequest1.Method := TRESTRequestMethod.rmPOST;
      //RESTRequest1.Body.Add(JSONObj.ToString, ContentTypeFromString('application/json'));
      //RESTRequest1.AddParameter('body',memo1.Text,TRESTRequestParameterKind.pkGETorPOST);
      RESTRequest1.Params.Items[1].Value := body;
      //RESTRequest1.Params.ParameterByName('body').AddValue(memo1.Text);
      RESTRequest1.Execute;
      showMessage('Cadastro realizado com sucesso! Faça login no app.');
      limpaCampos;
      close;
   except on e:exception do
   begin
    showMessage('Falha no cadastro. Erro 422');
    abort;
   end;

   end;
end;

end.
