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
  FMX.Effects, FMX.ScrollBox, FMX.Memo, FGX.ProgressDialog, System.math;


 Function formacpf(numtexto:String):String;

type
  Tfrm_cadastro = class(TForm)
    header: TLayout;
    ToolBar1: TToolBar;
    Rectangle10: TRectangle;
    VertScrollBox1: TVertScrollBox;
    formNome: TLayout;
    inputNome: TEdit;
    labelNome: TLabel;
    Layout4: TLayout;
    Rectangle12: TRectangle;
    Text1: TText;
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    fgActivityDialog: TfgActivityDialog;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    ShadowEffect1: TShadowEffect;
    fundoCPF: TRectangle;
    Layout1: TLayout;
    Label1: TLabel;
    Rectangle11: TRectangle;
    Edit1: TEdit;
    ShadowEffect4: TShadowEffect;
    FundoFone: TRectangle;
    Layout2: TLayout;
    Label2: TLabel;
    Rectangle14: TRectangle;
    Edit2: TEdit;
    ShadowEffect5: TShadowEffect;
    Image1: TImage;
    Image4: TImage;
    ShadowEffect12: TShadowEffect;
    FundoGenero: TRectangle;
    Layout3: TLayout;
    Rectangle15: TRectangle;
    ShadowEffect13: TShadowEffect;
    Text2: TText;
    Rectangle13: TRectangle;
    ShadowEffect14: TShadowEffect;
    Text3: TText;
    Rectangle16: TRectangle;
    ShadowEffect15: TShadowEffect;
    Text4: TText;
    Rectangle17: TRectangle;
    ShadowEffect16: TShadowEffect;
    Text5: TText;
    Rectangle18: TRectangle;
    ShadowEffect17: TShadowEffect;
    Text6: TText;
    fundoEtnia: TRectangle;
    Layout5: TLayout;
    Rectangle20: TRectangle;
    ShadowEffect18: TShadowEffect;
    Text7: TText;
    Rectangle21: TRectangle;
    ShadowEffect19: TShadowEffect;
    Text8: TText;
    Rectangle22: TRectangle;
    ShadowEffect20: TShadowEffect;
    Text9: TText;
    Rectangle23: TRectangle;
    ShadowEffect21: TShadowEffect;
    Text10: TText;
    Rectangle24: TRectangle;
    ShadowEffect22: TShadowEffect;
    Text11: TText;
    Rectangle19: TRectangle;
    ShadowEffect23: TShadowEffect;
    Text12: TText;
    lt_principal: TLayout;
    formEmail: TLayout;
    labelEmail: TLabel;
    Rectangle4: TRectangle;
    inputEmail: TEdit;
    ShadowEffect7: TShadowEffect;
    formCpf: TLayout;
    labelCpf: TLabel;
    Rectangle2: TRectangle;
    ShadowEffect3: TShadowEffect;
    inputCPF: TEdit;
    formDataNasc: TLayout;
    labelDataNasc: TLabel;
    Rectangle3: TRectangle;
    inputDataNasc: TDateEdit;
    ShadowEffect6: TShadowEffect;
    formSenha: TLayout;
    labelSenha: TLabel;
    Rectangle5: TRectangle;
    inputSenha: TEdit;
    PasswordEditButton3: TPasswordEditButton;
    Image2: TImage;
    ShadowEffect2: TShadowEffect;
    formConfirmarSenha: TLayout;
    labelConfirmarSenha: TLabel;
    Rectangle6: TRectangle;
    inputConfirmarSenha: TEdit;
    PasswordEditButton1: TPasswordEditButton;
    Image3: TImage;
    ShadowEffect8: TShadowEffect;
    formGenero: TLayout;
    labelGenero: TLabel;
    Rectangle7: TRectangle;
    ShadowEffect9: TShadowEffect;
    inputGenero: TText;
    Image5: TImage;
    formEtnia: TLayout;
    labelEtnia: TLabel;
    Rectangle8: TRectangle;
    ShadowEffect10: TShadowEffect;
    inputEtnia: TText;
    Image6: TImage;
    formCel: TLayout;
    labelCel: TLabel;
    Rectangle9: TRectangle;
    inputCel: TEdit;
    ShadowEffect11: TShadowEffect;
    Layout6: TLayout;
    Label3: TLabel;
    Image7: TImage;
    procedure menuClick(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure inputDataNascEnter(Sender: TObject);
    procedure inputEmailEnter(Sender: TObject);
    procedure inputSenhaEnter(Sender: TObject);
    procedure inputGeneroEnter(Sender: TObject);
    procedure inputEtniaEnter(Sender: TObject);
    procedure inputCelEnter(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure inputConfirmarSenhaEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure inputCpfExit(Sender: TObject);
    procedure fundoCPFClick(Sender: TObject);
    procedure FundoFoneClick(Sender: TObject);
    procedure inputNomeKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure Image4Click(Sender: TObject);
    procedure FundoGeneroClick(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure Text3Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure Text6Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure inputGeneroClick(Sender: TObject);
    procedure Text7Click(Sender: TObject);
    procedure Text8Click(Sender: TObject);
    procedure Text9Click(Sender: TObject);
    procedure Text11Click(Sender: TObject);
    procedure Text10Click(Sender: TObject);
    procedure Text12Click(Sender: TObject);
    procedure fundoEtniaClick(Sender: TObject);
    procedure inputCPFClick(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure inputEtniaClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure inputCPFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure inputCPFEnter(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormFocusChanged(Sender: TObject);
    procedure inputNomeKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure inputNomeTyping(Sender: TObject);
  private
    { Private declarations }
    FProgressDialogThread: TThread;
    FActivityDialogThread: TThread;
    vFoco: TControl;
    vBounds: TRectF;
    vOffSef: boolean;
    procedure calcBounds(Sender: TObject; var contentBounds: TRectF);
    procedure restorePosition;
    procedure updatePosition;
    procedure ajustar_scroll();
    procedure limpaCampos();

  public
    { Public declarations }
    var
      vCPF_numeros : string;
    const
      IntegerSet = [#33..#47,#58..#255] ;
      StringSet = [#46..#57];
  end;

var
  frm_cadastro: Tfrm_cadastro;

implementation

{$R *.fmx}

uses uGhiFuncoes;

// Remove numeros ou letrars de uma string
//uso: showmessage(ExtractStringsOnly(IntegerSet,Edit1.Text));
// ou showmessage(ExtractStringsOnly(StringSet,Edit1.Text));
function ExtractStringsOnly(_Separators:TSysCharSet;const Str:String):String;
Var
  lista:TStrings;
begin
  lista:=TStringList.Create;
  try
    ExtractStrings(_Separators,[],pchar(str),lista);
    lista.StrictDelimiter:=True;
    lista.QuoteChar:=#0;
    result:=StringReplace(lista.DelimitedText,lista.Delimiter,EmptyStr,[rfReplaceAll]);
    finally
      lista.Free;
  end;
end;


//Formata número CPF
Function formacpf(numtexto:String):String;
begin
    Delete(numtexto,ansipos('.',numtexto),1);  //Remove ponto .
    Delete(numtexto,ansipos('.',numtexto),1);
    Delete(numtexto,ansipos('-',numtexto),1); //Remove traço -
    Delete(numtexto,ansipos('/',numtexto),1); //Remove barra /
    Result:=FormatmaskText('000\.000\.000\-00;0;',numtexto); // Formata os numeros

end;

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

procedure Tfrm_cadastro.calcBounds(Sender: TObject; var contentBounds: TRectF);
begin
  if (vOffSef) and (vBounds.Top > 0) then
  begin
    contentBounds.Bottom := Max(contentBounds.Bottom, 2 * ClientHeight - vBounds.Top);
  end;

end;

procedure Tfrm_cadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  limpaCampos;
end;

procedure Tfrm_cadastro.FormFocusChanged(Sender: TObject);
begin
  updatePosition;
end;

procedure Tfrm_cadastro.FormShow(Sender: TObject);
begin
  VertScrollBox1.OnCalcContentBounds := calcBounds;
end;

procedure Tfrm_cadastro.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  //VertScrollBox1.Margins.Bottom := 0;
  vBounds.Create(0,0,0,0);
  vOffSef := false;
  restorePosition;
end;

procedure Tfrm_cadastro.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  vBounds := TRectF.Create(Bounds);
  vBounds.TopLeft := ScreenToClient(vBounds.TopLeft);
  vBounds.BottomRight := ScreenToClient(vBounds.BottomRight);
  updatePosition;
end;

procedure Tfrm_cadastro.fundoCPFClick(Sender: TObject);
begin
  //fundoCPF.Visible := false;
end;

procedure Tfrm_cadastro.fundoEtniaClick(Sender: TObject);
begin
 fundoEtnia.Visible := false;
end;

procedure Tfrm_cadastro.FundoFoneClick(Sender: TObject);
begin
  FundoFone.Visible := false;
end;

procedure Tfrm_cadastro.FundoGeneroClick(Sender: TObject);
begin
  FundoGenero.Visible := false;
end;

procedure Tfrm_cadastro.Image4Click(Sender: TObject);
begin
  limpaCampos;
  close;
end;

procedure Tfrm_cadastro.Image5Click(Sender: TObject);
begin
  FundoGenero.Visible := true;
end;

procedure Tfrm_cadastro.Image6Click(Sender: TObject);
begin
  fundoEtnia.Visible := true;
end;

procedure Tfrm_cadastro.Image7Click(Sender: TObject);
begin
  Text1Click(self);
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

procedure Tfrm_cadastro.inputCPFClick(Sender: TObject);
begin
  fundoCPF.Visible := true;
  GhiFunc.Teclado_CPF(Self, edit1);
end;

procedure Tfrm_cadastro.inputCPFEnter(Sender: TObject);
begin
  fundoCpf.Visible := true;
  GhiFunc.Teclado_CPF(self, edit1);
end;

procedure Tfrm_cadastro.inputCpfExit(Sender: TObject);
var tamanho :integer;
var sCpf: string;
begin
  inputCPF.Text := formacpf(inputCPF.Text);
{  sCpf := FormatMaskText('000\.000\.000\-00;0;', inputCpf.text);
  inputCpf.Text := '';
  inputcpf.Text := sCpf;
  sCpf := ''; }
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


procedure Tfrm_cadastro.inputCPFKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
 //if length(inputCPF.text) = 11 then
 //begin
 //   keyChar := #0;
  //inputCPF.Text := formacpf(inputCPF.Text);
 //end;

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

procedure Tfrm_cadastro.inputEtniaClick(Sender: TObject);
begin
  fundoEtnia.Visible := true;
end;

procedure Tfrm_cadastro.inputEtniaEnter(Sender: TObject);
begin
  vFoco := TControl(TComboBox(sender).Parent);
  //ajustar_scroll();
end;

procedure Tfrm_cadastro.inputGeneroClick(Sender: TObject);
begin
  FundoGenero.Visible := true;
end;

procedure Tfrm_cadastro.inputGeneroEnter(Sender: TObject);
begin
  FundoGenero.Visible := true;
end;

procedure Tfrm_cadastro.inputNomeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inputNome.Text := ExtractStringsOnly(StringSet,inputNome.Text);
end;

procedure Tfrm_cadastro.inputNomeKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inputNome.Text := ExtractStringsOnly(StringSet,inputNome.Text);
end;

procedure Tfrm_cadastro.inputNomeTyping(Sender: TObject);
begin
  inputNome.Text := ExtractStringsOnly(StringSet,inputNome.Text);
end;

procedure Tfrm_cadastro.inputSenhaEnter(Sender: TObject);
begin
  vFoco := TControl(TEdit(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_cadastro.limpaCampos;
begin
  inputNome.Text           := '';
  inputCPF.Text            := '';
  inputDataNasc.IsEmpty    := true;
  inputEmail.Text          := '';
  inputSenha.Text          := '';
  inputConfirmarSenha.Text := '';
  inputGenero.Text         := '';
  inputEtnia.Text          := '';
  inputCel.Text            := '';
  edit1.Text               := '';
  vCPF_numeros             := '';
end;

procedure Tfrm_cadastro.menuClick(Sender: TObject);
begin
  limpaCampos;
  close;
end;

procedure Tfrm_cadastro.restorePosition;
begin
  VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, 0);
  lt_principal.Align := TAlignLayout.Client;
  VertScrollBox1.RealignContent;
end;

procedure Tfrm_cadastro.Text10Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle23.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle23.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputEtnia.Text := 'AMARELO';
          FundoEtnia.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text11Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle24.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle24.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputEtnia.Text := 'INÍGENA';
          FundoEtnia.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text12Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle19.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle19.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputEtnia.Text := 'NÃO DECLARADO';
          FundoEtnia.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
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

  if not fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
            text1.Enabled := false;
            text1.AnimateFloat('Position.Y',30,1, TAnimationType.&Out, TInterpolationType.Elastic);
            text1.AnimateFloat('Position.Y',0,1, TAnimationType.&Out, TInterpolationType.Elastic);
          end);

          Sleep(500);
          if TThread.CheckTerminated then
            Exit;

          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Enviando...';
            fgActivityDialog.Show;
            try
             body := '{                           '+
        '    "name": "'+inputNome.text+'",    '+
        '    "cpf": "'+vCPF_numeros+'",           '+
        '    "birthdate": "'+FormatDateTime('yyyy-mm-dd', inputDataNasc.Date)+'",'+
        '    "gender": "'+inputGenero.text+'",    '+
        '    "skin_color": "'+inputEtnia.Text+'", '+
        '    "cellphone": "'+inputCel.Text+'",    '+
        '    "phone": "'+inputCel.Text+'",        '+
        '    "status": "ATIVO",                   '+
        '    "email": "'+inputEmail.Text+'",      '+
        '    "password": "'+inputSenha.Text+'" }';

   {                  body := '{'+
        '    "name": "AMARO",'+
        '    "cpf": "331999",      '+
        '    "birthdate": "1994-12-12",'+
        '    "gender": "FEMININO", '+
        '    "skin_color": "BRANCO", '+
        '    "cellphone": "2299", '+
        '    "phone": "2299",  '+
        '    "status": "ATIVO",   '+
        '    "email": "mama@gmail.com", '+
        '    "password": "1234" }//';
 
              RESTRequest1.Params.Items[0].Value := body;
              // RESTRequest1.Params.ParameterByName('body').Value := body;
              RESTRequest1.Execute;
            except on e:exception do
           begin
            showMessage('Falha no cadastro. Erro 422');
            abort;
           end;

           end;

          end);
          Sleep(2000);

          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Envio concluído';
            text1.Enabled := true;
          end);

          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;
        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              fgActivityDialog.Hide;
              showMessage('Cadastro realizado com sucesso!');
              close;
            end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;










end;

procedure Tfrm_cadastro.Text2Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle15.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle15.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputGenero.Text := 'MASCULINO';
          FundoGenero.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text3Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle13.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle13.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputGenero.Text := 'FEMININO';
          FundoGenero.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text4Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle16.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle16.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputGenero.Text := 'TRANS FEM';
          FundoGenero.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text5Click(Sender: TObject);
begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle17.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle17.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputGenero.Text := 'NÃO DECLARADO';
          FundoGenero.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text6Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle18.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle18.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
        inputGenero.Text := 'TRANS MASC';
          FundoGenero.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text7Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle20.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle20.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputEtnia.Text := 'BRANCO';
          FundoEtnia.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text8Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle21.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle21.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputEtnia.Text := 'PARDO';
          FundoEtnia.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.Text9Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          rectangle22.AnimateFloat('Position.X',-30,1, TAnimationType.&Out, TInterpolationType.Elastic);
          rectangle22.AnimateFloat('Position.X',5,1, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          inputEtnia.Text := 'NEGRO';
          FundoEtnia.Visible := false;
        end);

      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_cadastro.updatePosition;
var
  LFocused: TControl;
  LFocusRect: TRectF;
begin
  vOffSef := false;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VertScrollBox1.ViewportPosition);

    if (LFocusRect.IntersectsWith(TRectF.Create(vBounds))) and (LFocusRect.Bottom > vBounds.Top) then
    begin
      vOffSef := true;
      lt_principal.Align := TAlignLayout.Horizontal;
      VertScrollBox1.RealignContent;
      application.ProcessMessages;
      VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.x, LFocusRect.Bottom - vBounds.Top);
    end;

  end;
  if not vOffSef then
    restorePosition;


end;

end.
