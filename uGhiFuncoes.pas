{
Autor: Victor Henrique B. Ghilardi.
Email: vhghilardi@gmail.com.
WhatsApp: 51 99541-6119
facebook.com/toy.developer

Modificado em: 20/05/2019 por Mike W. Lustosa (81) 9.96302385
}
unit uGhiFuncoes;

interface

uses System.SysUtils, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
     FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani,
     FMX.DialogService, FMX.Types, System.UITypes, System.Threading,
     System.Classes, FMX.Edit, System.Math, IdIOHandler, IdSMTP,
     IdMessage, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
     IniFiles, IdHTTP, System.Json, IPPeerClient, REST.Client,
     Data.Bind.Components, Data.Bind.ObjectScope, Rest.Utils, FMX.WebBrowser, System.StrUtils
  {$IFDEF ANDROID} //if the operative system is Android
     , Androidapi.JNI.Telephony, Androidapi.JNI.Provider ,
     Androidapi.JNIBridge, Androidapi.JNI.GraphicsContentViewText ,
     Androidapi.JNI.JavaTypes,FMX.Helpers.Android, Androidapi.Helpers
  {$ENDIF ANDROID}

     ;

     type
     TResultArray = array[1..2] of string;
     TUtil = Class

     private
          procedure Clique_Btn_Del(Sender : TObject);
          procedure Clique_Btn_Number(Sender : TObject);
          procedure Preenche_Edit(pNumDigitado : Integer; pTipoTeclado : String);  // Valores: 'TEL', 'VLR', 'CPF'...);
          procedure Destroi_MsgToast(Sender: TObject);
          //procedure AppOnExcept(Sender: TObject; E: Exception);
          procedure Monta_Teclado(pTela: TForm; pEdit: TEdit);
          procedure ConfiguraUrl_PagSeguro(pAmbiente: String);
          procedure Nova_Trans_PagSeguro(pNome, pNumCartao, pDataValidade, pCodSeg,
                                         pBandeira: String; pValor: Currency; pParcelas: Integer);
     Public
    function getCamposJsonString(json, value: String): String;
         // procedure Conecta_Unidac(pTela: TForm; pConection : TUniConnection; pStringConIPV4, pStringConIPV6 : String);
         // procedure Desconecta_Unidac(pTela: TForm; pConection : TUniConnection);
          //function  BuscaCampoSTR(pSQL: String): String;
          //procedure ExecutaSQL(pSQL: String);
          //function  Data_Hora_Servidor: TDateTime;
          //function  Data_Servidor: TDateTime;

          function ValidarCPF(cpf: String): Boolean;
          procedure Fecha_Tela(pForm: TForm);
          function  UltimoDiaDoMes(MesAno: string): string;
          function  isCPF(CPF: string): boolean;
          function  Retorna_Num_Tel_Android: String;
          procedure GravarINI(pNomeArq, pUser, pSenha : String);
          function  LerIni(pNomeArq : String) : TResultArray;
          function  Nova_Trans_Simples_Nova(pCliId, pNome, pNumCartao,
                                            pDataValidade, pCodSeg, pBandeira, pValor: String;
                                            pParcelas: Integer): String;

          procedure MensagemToast(pTela : TForm; pMensagem : String;
                                  pPosicao : TAlignLayout = TAlignLayout.Center;
                                  pCor : TAlphaColor = TAlphaColorRec.Lightblue);
          procedure Teclado_VLR(pTela : TForm; pEdit : TEdit);
          procedure Clique_Btn_OK(Sender: TObject);
          procedure Teclado_TEL(pTela : TForm; pEdit : TEdit);
          procedure Teclado_CPF(pTela : TForm; pEdit : TEdit);
          function  InputPass(pTela : TForm; pTitulo, pDescricao : String;
                              pCorTitulo : TAlphaColor = TAlphaColorRec.Gainsboro;
                              pCorGeral : TAlphaColor = TAlphaColorRec.Gainsboro;
                              pCorBorda : TAlphaColor = TAlphaColorRec.Black) : String;
          function  Distancia(pLatPartida, pLongPartida, pLatDestino,
                                           pLongDestino: Double): String;


          procedure Envia_Email(pAssunto, pDestinatario, pTitMsg, pMsg, pNome, pHash,
                                pURL_Logotipo, pAssinatura, pURL_Instagram, pURL_Twitter, pURL_Facebook,
                                pHost, pUserName, pPassWord : String);
          procedure ConfiguraUrl_Cielo;
          procedure Login_Facebook(pTela : TForm; pWebBrowser : TWebBrowser);
          procedure Destroi_Frame(pObjeto : TFrame);

    const vEmail_Padrao : String =
    ' <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//PT> ' +
    ' <html xmlns="https://www.mailee.me/pt"> ' +
    ' <head> ' +
    ' <title>@titulo</title> ' +
    ' <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> ' +
    ' <meta name="viewport" content="width=device-width, initial-scale=1.0" /> ' +
    '         <style> ' +
    '          @import url(https://fonts.googleapis.com/css?family=Roboto:300); /*Calling our web font*/ ' +
    '         /* Some resets and issue fixes */ ' +
    '         #outlook a { padding:0; } ' +
    '         body{ width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0; } ' +
    '         .ReadMsgBody { width: 100%; } ' +
    '         .ExternalClass {width:100%;} ' +
    '         .backgroundTable {margin:0 auto; padding:0; width:100%;!important;} ' +
    '         table td {border-collapse: collapse;} ' +
    '         .ExternalClass * {line-height: 115%;} ' +
    '         /* End reset */ ' +
    '         /* These are our tablet/medium screen media queries */ ' +
    '         @media screen and (max-width: 630px){ ' +
    '             /* Display block allows us to stack elements */ ' +
    '              *[class="mobile-column"] {display: block;} ' +
    '             /* Some more stacking elements */ ' +
    '             *[class="mob-column"] {float: none !important;width: 100% !important;} ' +
    '             /* Hide stuff */ ' +
    '             *[class="hide"] {display:none !important;} ' +
    '              /* This sets elements to 100% width and fixes the height issues too, a god send */ ' +
    '             *[class="100p"] {width:100% !important; height:auto !important;} ' +
    '             /* For the 2x2 stack */ ' +
    '             *[class="condensed"] {padding-bottom:40px !important; display: block;} ' +
    '             /* Centers content on mobile */ ' +
    '             *[class="center"] {text-align:center !important; width:100% !important; height:auto !important;} ' +
    '             /* 100percent width section with 20px padding */ ' +
    '             *[class="100pad"] {width:100% !important; padding:20px;} ' +
    '             /* 100percent width section with 20px padding left & right */ ' +
    '             *[class="100padleftright"] {width:100% !important; padding:0 20px 0 20px;} ' +
    '              /* 100percent width section with 20px padding top & bottom */ ' +
    '             *[class="100padtopbottom"] {width:100% !important; padding:20px 0px 20px 0px;} ' +
    '         } ' +
    '     </style> ' +
    ' <style type="text/css"> ' +
    ' </style> ' +
    ' <style type="text/css"> ' +
    ' </style> ' +
    ' </head> ' +
    ' <div style="background:#ffffff;"> ' +
    ' </div><body style="padding:0; margin:0" bgcolor="#ffffff"> ' +
    ' <table border="0" cellpadding="0" cellspacing="0" style="margin: 0; padding: 0" width="100%"> ' +
    '     <tr> ' +
    '         <td align="center" valign="top"> ' +
    '             <table width="640" border="0" cellspacing="0" cellpadding="0" class="hide"> ' +
    '                 <tr> ' +
    '                     <td height="20"></td> ' +
    '                 </tr> ' +
    '             </table> ' +
    '             <table width="640" cellspacing="0" cellpadding="0" bgcolor="#" class="100p"> ' +
    '                 <tr> ' +
    '                     <td bgcolor="#ffffff" width="640" valign="top" class="100p"> ' +
    '                                 <div> ' +
    '                                     <table width="640" border="0" cellspacing="0" cellpadding="20" class="100p"> ' +
    '                                         <tr> ' +
    '                                             <td valign="top"> ' +
    '                                                 <table border="0" cellspacing="0" cellpadding="0" width="600" class="100p"> ' +
    '                                                     <tr> ' +
    ' <td align="left" width="50%" class="100p"><img src="@URL_Logotipo" width="200" height="96" /> ' +
    '                                                     </td></tr> ' +
    '                                                 </table> ' +
    '                                                 <table border="0" cellspacing="0" cellpadding="0" width="600" class="100p"> ' +
    '                                                     <tr> ' +
    '                                                         <td height="35"></td> ' +
    '                                                     </tr> ' +
    '                                                     <tr> ' +
    '                                                         <td align="center" style="color:#000000; font-size:24px;"> ' +
    '                                                             <font face="''Roboto'', Arial, sans-serif"> ' +
    '                                                                 <span style="font-size:44px;">@tit_msg</span><br /> ' +
    '                                                                 <br /> ' +
    '                                                                 <span style="font-size:24px;">Ola @nome, <br /> ' +
    '                                                                 @corpo_email</span> ' +
    '                                                                 <br /><br /> ' +
    '                                                         </td> ' +
    '                                                     </tr> ' +
    '                                                     <tr> ' +
    '                                                         <td height="35"></td> ' +
    '                                                     </tr> ' +
    '                                                 </table> ' +
    '                                             </td> ' +
    '                                         </tr> ' +
    '                                     </table> ' +
    '                                 </div> ' +
    '                     </td> ' +
    '                 </tr> ' +
    '             </table> ' +
    '             <table width="640" border="0" cellspacing="0" cellpadding="20" bgcolor="#52658d" class="100p"> ' +
    '                 <tr> ' +
    '                     <td align="center" style="font-size:24px; color:#FFFFFF;"><font face="''Roboto'', Arial, sans-serif">@Assinatura</font></td> ' +
    '                 </tr> ' +
    '             </table> ' +
    '             <table width="640" border="0" cellspacing="0" cellpadding="20" bgcolor="#ffffff" class="100p"> ' +
    '                 <tr> ' +
    '                     <td align="right" width="50%" style="font-size:14px; color:#848484;"> ' +
    ' 						<div align="center"> ' +
    ' 							<img src="@URL_Instagram" width="30" height="30" /> ' +
    ' 							<img src="@URL_Twitter" width="30" height="30" /> ' +
    ' 							<img src="@URL_Facebook" width="30" height="30" /> ' +
    ' 						</div> ' +
    ' 					</td> ' +
    ' 				</tr> ' +
    '             </table> ' +
    '             <table width="640" class="100p" border="0" cellspacing="0" cellpadding="0"> ' +
    '                 <tr> ' +
    '                     <td height="50"> ' +
    '                     </td> ' +
    '                 </tr> ' +
    '             </table> ' +
    '         </td> ' +
    '     </tr> ' +
    ' </table> ' +
    ' </body> ' +
    ' </html>';
     End;

var
   GhiFunc : TUtil;
   vMultiplicador : Integer;
   vRetGenerico, vRetMsg, vRetTituloMsg : TRectangle;
   vLabel : TLabel;
   vAnima : TFloatAnimation;

   vQtd_Digitos : Integer;
   vDigitadoGeral : String;
   vEdit, vEdtValor : TEdit;
   vPanel : TPanel;
   vTela : TForm;
   vBtn : TSpeedButton;
   vResultBOL : Boolean;
   vArray_INI : Array of String;

   vTipoTeclado : String;

   vUrlExecTrans, vUrlConsTrans, vMerchantId, vMerchantKey,
   vUrlExecPagSeg, vUrlConsPagSeg, vEmail_PagSeguro, vToken_PagSeguro : String;

//Variável para login no facebook;
  vAccesToken : String;

implementation

//uses uDM;


uses cadastro;{
procedure TUtil.Desconecta_Unidac(pTela: TForm; pConection: TUniConnection);
begin
     try
        pConection.Connected := False;
     except
        MensagemToast(pTela, 'Ocorreu um erro ao desconectar do servidor.');
     end;
end;  }

Function tirapontos(texto : String) : String;
Begin

  While pos('-', Texto) <> 0 Do
    delete(Texto,pos('-', Texto),1);

  While pos('.', Texto) <> 0 Do
    delete(Texto,pos('.', Texto),1);

  Result := Texto;
End;

procedure TUtil.Destroi_Frame(pObjeto: TFrame);
begin
     pObjeto.DisposeOf;
end;

procedure TUtil.Destroi_MsgToast(Sender: TObject);
begin
     vRetMsg.Visible := False;
     vRetMsg.DisposeOf;
     vRetMsg         := nil;
     FreeAndNil(vRetMsg);
end;

procedure TUtil.MensagemToast(pTela : TForm; pMensagem : String;
                              pPosicao : TAlignLayout = TAlignLayout.Center;
                              pCor : TAlphaColor = TAlphaColorRec.Lightblue);
{
Objetivo: Apresentar uma mensagem de forma agradável ao usuário em Android e iOS.
}
      function NumWords(st:string) :byte;
      {
      Objetivo: Retornar a quantidade de ENTER (Quebra de linha) na string recebida.
      }
      var
        w,i : byte;
        aux : string;
      begin
          w   := 0;
          aux := Trim(st);
          for i := 2 to length(aux) do
            if Pos(#13, aux[i]) > 0 then
               inc(w);
          NumWords := w;
      end;

begin
     vRetMsg                := TRectangle.Create(nil);
     vRetMsg.Parent         := pTela;
     vRetMsg.Align          := pPosicao;
     vRetMsg.Margins.Left   := 0;
     vRetMsg.Margins.Top    := 0;
     vRetMsg.Margins.Bottom := 0;
     vRetMsg.Margins.Right  := 0;
     vRetMsg.Fill.Color     := pCor;
     vRetMsg.Stroke.Color   := pCor;
     if Length(pMensagem) < 10 then
     begin
{          vRetMsg.XRadius := 7;
          vRetMsg.YRadius := 30;}
          vRetMsg.Width   := Length(pMensagem) * 10;
          vRetMsg.Height  := 55;
     end
     else
     if (Length(pMensagem) * 10) > 300 then
     begin
          if Length(pMensagem) < 60 then
          begin
//               vRetMsg.XRadius := 10;
               vMultiplicador  := 6;
          end
          else
          if Length(pMensagem) > 60 then
          begin
//               vRetMsg.XRadius := 20;
               vMultiplicador  := 2;
          end;
//          vRetMsg.YRadius := 30;
          vRetMsg.Width   := 300;
          if NumWords(pMensagem) <= 0 then
             vRetMsg.Height  := Trunc(((Length(pMensagem) * 10) / 40)) * vMultiplicador
          else
              vRetMsg.Height  := Trunc(((Length(pMensagem) * 10) / 40)) * vMultiplicador * NumWords(pMensagem);
     end
     else
     begin
          if NumWords(pMensagem) > 0 then
          begin
{              vRetMsg.XRadius := NumWords(pMensagem) *  10;
              vRetMsg.YRadius := 30;}
              vRetMsg.Width   := Length(pMensagem) * 10;
              vRetMsg.Height  := NumWords(pMensagem) * 30;
          end
          else
          begin
{              vRetMsg.XRadius := 10;
              vRetMsg.YRadius := 30;}
              vRetMsg.Width   := Length(pMensagem) * 10;
              vRetMsg.Height  := 45;
          end;
     end;

     vAnima               := TFloatAnimation.Create(nil);
     vAnima.Parent        := vRetMsg;
     vAnima.AnimationType := TAnimationType.&In;
     vAnima.Delay         := 0;
     vAnima.Duration      := 2;
     vAnima.Interpolation := TInterpolationType.Linear;
     vAnima.PropertyName  := 'Opacity';
     vAnima.StartValue    := 0;
     vAnima.StopValue     := 3;
     vAnima.AutoReverse   := True;
     vAnima.OnFinish      := Destroi_MsgToast;

     vLabel                        := TLabel.Create(nil);
     vLabel.Parent                 := vRetMsg;
     vLabel.Align                  := TAlignLayout.Client;
     vLabel.TextSettings.WordWrap  := True;
     vLabel.TextSettings.HorzAlign := TTextAlign.Center;
     vLabel.Text                   := pMensagem;
     vLabel.Margins.Left           := 10;
     vLabel.Margins.Top            := 10;
     vLabel.Margins.Bottom         := 10;
     vLabel.Margins.Right          := 10;

     vAnima.Enabled := True;
end;

procedure TUtil.Teclado_CPF(pTela: TForm; pEdit: TEdit);
begin
     vTipoTeclado := 'CPF';
     Monta_Teclado(pTela, pEdit);
end;


procedure TUtil.Teclado_TEL(pTela: TForm; pEdit: TEdit);
begin
     vTipoTeclado := 'TEL';
     Monta_Teclado(pTela, pEdit);
end;

procedure TUtil.Teclado_VLR(pTela : TForm; pEdit : TEdit);
begin
     vTipoTeclado := 'VLR';
     Monta_Teclado(pTela, pEdit);
end;

procedure TUtil.Monta_Teclado(pTela : TForm; pEdit : TEdit);
var
   vPanel_Btn : Tpanel;
   vScaledLayout : TScaledLayout;
   vButton : TButton;
begin
     vPanel.DisposeOf;
     vPanel := nil;
     FreeAndNil(vPanel);

     vDigitadoGeral := '';
     vQtd_Digitos   := 0;
     try
        FreeAndNil(vPanel);
     except
       //
     end;
     pEdit.TextPrompt := '';
     vEdtValor        := pEdit;
     vTela            := pTela;
     vPanel           := TPanel.Create(pTela);
     vPanel.Parent    := pTela;
     vPanel.Align     := TAlignLayout.Bottom;
     vPanel.Height    := 200;

     vScaledLayout        := TScaledLayout.Create(pTela);
     vScaledLayout.Parent := vPanel;
     vScaledLayout.Align  := TAlignLayout.Client;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 15;
     vButton.Position.Y := 8;
     vButton.Text       := '1';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 1;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 123;
     vButton.Position.Y := 8;
     vButton.Text       := '2';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 2;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 231;
     vButton.Position.Y := 8;
     vButton.Text       := '3';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 3;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 15;
     vButton.Position.Y := 56;
     vButton.Text       := '4';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 4;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 123;
     vButton.Position.Y := 56;
     vButton.Text       := '5';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 5;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 231;
     vButton.Position.Y := 56;
     vButton.Text       := '6';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 6;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 15;
     vButton.Position.Y := 104;
     vButton.Text       := '7';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 7;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 123;
     vButton.Position.Y := 104;
     vButton.Text       := '8';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 8;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vButton            := TButton.Create(pTela);
     vButton.Parent     := vPanel;
     vButton.Position.X := 231;
     vButton.Position.Y := 104;
     vButton.Text       := '9';
     vButton.OnClick    := Clique_Btn_Number;
     vButton.Tag        := 9;
     vButton.Height     := 41;
     vButton.Width      := 100;

     vPanel_Btn            := TPanel.Create(pTela);
     vPanel_Btn.Parent     := vPanel;
     vPanel_Btn.Position.X := 15;
     vPanel_Btn.Position.Y := 152;
     vPanel_Btn.Height     := 41;
     vPanel_Btn.Width      := 100;

     vButton             := TButton.Create(pTela);
     vButton.Parent      := vPanel_Btn;
     vButton.Position.X  := 0;
     vButton.Position.Y  := 0;
     vButton.Text        := 'Apagar';
     vButton.OnClick     := Clique_Btn_Del;
     vButton.Height      := 41;
     vButton.Width       := 100;
     vButton.Align       := TAlignLayout.Center;
     vButton.StyleLookup := 'arrowlefttoolbutton';

     vButton             := TButton.Create(pTela);
     vButton.Parent      := vPanel;
     vButton.Position.X  := 123;
     vButton.Position.Y  := 152;
     vButton.Text        := '0';
     vButton.OnClick     := Clique_Btn_Number;
     vButton.Tag         := 0;
     vButton.Height      := 41;
     vButton.Width       := 100;

     vPanel_Btn            := TPanel.Create(pTela);
     vPanel_Btn.Parent     := vPanel;
     vPanel_Btn.Position.X := 232;
     vPanel_Btn.Position.Y := 152;
     vPanel_Btn.Height     := 41;
     vPanel_Btn.Width      := 100;

     vButton             := TButton.Create(pTela);
     vButton.Parent      := vPanel_Btn;
     vButton.Position.X  := 0;
     vButton.Position.Y  := 0;
     vButton.Text        := 'OK';
     vButton.OnClick     := Clique_Btn_OK;
     vButton.Height      := 41;
     vButton.Width       := 100;
     vButton.Align       := TAlignLayout.Center;
     //vButton.StyleLookup := 'arrowrighttoolbutton';
end;



procedure TUtil.Preenche_Edit(pNumDigitado : Integer; pTipoTeclado : String);  // Valores: 'TEL', 'VLR', 'CPF'...
var
   vNovoConteudo : String;
begin
     if pTipoTeclado = 'VLR' then
     begin
         if pNumDigitado > -1 then
         begin
              if vQtd_Digitos = 0 then
              begin
                   vDigitadoGeral := IntToStr(pNumDigitado);
              end
              else
              begin
                   vDigitadoGeral := vDigitadoGeral + IntToStr(pNumDigitado);
              end;
              vEdtValor.Text := vEdtValor.Text + IntToStr(pNumDigitado);
              vNovoConteudo  := '';
              Inc(vQtd_Digitos);
         end
         else
         begin
              if vQtd_Digitos > 0 then
                 Dec(vQtd_Digitos);
         end;

         if vQtd_Digitos <= 0 then
            vEdtValor.Text := 'R$ 0,00'
         else
         begin
             vNovoConteudo := vDigitadoGeral;

            if vQtd_Digitos = 1 then
               vEdtValor.Text := 'R$ 0,0' + vNovoConteudo
            else
            if vQtd_Digitos = 2 then
               vEdtValor.Text := 'R$ 0,' + vNovoConteudo
            else
            if (vQtd_Digitos > 2) and (vQtd_Digitos <= 5) then
               vEdtValor.Text := 'R$ ' + Copy(vNovoConteudo, 0, (vQtd_Digitos - 2)) + ',' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 1), Length(vNovoConteudo))
            else
            if (vQtd_Digitos = 6) then
               vEdtValor.Text := 'R$ ' + Copy(vNovoConteudo, 0, (vQtd_Digitos - 5)) + '.' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 4), (vQtd_Digitos - 3)) + ',' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 1), Length(vNovoConteudo))
            else
            if (vQtd_Digitos = 7) then
               vEdtValor.Text := 'R$ ' + Copy(vNovoConteudo, 0, (vQtd_Digitos - 5)) + '.' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 4), (vQtd_Digitos - 4)) + ',' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 1), Length(vNovoConteudo))
            else
            if (vQtd_Digitos = 8) then
               vEdtValor.Text := 'R$ ' + Copy(vNovoConteudo, 0, (vQtd_Digitos - 5)) + '.' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 4), (vQtd_Digitos - 5)) + ',' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 1), Length(vNovoConteudo))
            else
            if (vQtd_Digitos = 9) then
               vEdtValor.Text := 'R$ ' + Copy(vNovoConteudo, 0, (vQtd_Digitos - 8)) + '.' +
                                         Copy(vNovoConteudo, 2, (vQtd_Digitos - 6)) + '.' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 4), (vQtd_Digitos - 6)) + ',' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 1), Length(vNovoConteudo))
            else
            if (vQtd_Digitos = 10) then
               vEdtValor.Text := 'R$ ' + Copy(vNovoConteudo, 0, (vQtd_Digitos - 8)) + '.' +
                                         Copy(vNovoConteudo, 3, (vQtd_Digitos - 7)) + '.' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 4), (vQtd_Digitos - 7)) + ',' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 1), Length(vNovoConteudo))
            else
            if (vQtd_Digitos = 11) then
               vEdtValor.Text := 'R$ ' + Copy(vNovoConteudo, 0, (vQtd_Digitos - 8)) + '.' +
                                         Copy(vNovoConteudo, 4, (vQtd_Digitos - 8)) + '.' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 4), (vQtd_Digitos - 8)) + ',' +
                                         Copy(vNovoConteudo, (vQtd_Digitos - 1), Length(vNovoConteudo));
         end;
     end
     else
     if pTipoTeclado = 'TEL' then
     begin
         if pNumDigitado > -1 then
         begin
              if vQtd_Digitos = 0 then
              begin
                   vDigitadoGeral := IntToStr(pNumDigitado);
              end
              else
              begin
                   vDigitadoGeral := vDigitadoGeral + IntToStr(pNumDigitado);
              end;
              vEdtValor.Text := vEdtValor.Text + IntToStr(pNumDigitado);
              vNovoConteudo  := '';
              Inc(vQtd_Digitos);
         end
         else
         begin
              if vQtd_Digitos > 0 then
                 Dec(vQtd_Digitos);
         end;

         if vQtd_Digitos <= 0 then
            vEdtValor.Text := ''
         else
         begin
             vNovoConteudo := vDigitadoGeral;

            if vQtd_Digitos = 1 then
               vEdtValor.Text := '(' + vNovoConteudo
            else
            if vQtd_Digitos = 2 then
               vEdtValor.Text := '(' + vNovoConteudo + ') '
            else
            if (vQtd_Digitos > 2) and (vQtd_Digitos <= 7) then
               vEdtValor.Text := '(' + Copy(vNovoConteudo, 0, 2) + ') ' +
                                       Copy(vNovoConteudo, 3, Length(vNovoConteudo))
            else
            if (vQtd_Digitos >= 8) then
               vEdtValor.Text := '(' + Copy(vNovoConteudo, 0, 2) + ') ' +
                                       Copy(vNovoConteudo, 3, 5) + '-' +
                                       Copy(vNovoConteudo, 8, Length(vNovoConteudo));
         end;
     end
     else
     if pTipoTeclado = 'CPF' then
     begin
         if pNumDigitado > -1 then
         begin
              if vQtd_Digitos = 0 then
              begin
                   vDigitadoGeral := IntToStr(pNumDigitado);
              end
              else
              begin
                   vDigitadoGeral := vDigitadoGeral + IntToStr(pNumDigitado);
              end;
              vEdtValor.Text := vEdtValor.Text + IntToStr(pNumDigitado);
              vNovoConteudo  := '';
              Inc(vQtd_Digitos);
         end
         else
         begin
              if vQtd_Digitos > 0 then
                 Dec(vQtd_Digitos);
         end;

         if vQtd_Digitos <= 0 then
            vEdtValor.Text := ''
         else
         begin
             vNovoConteudo := vDigitadoGeral;

            if (vQtd_Digitos >= 1) and (vQtd_Digitos <= 3) then
               vEdtValor.Text := vNovoConteudo
            else
            if (vQtd_Digitos >= 4) and (vQtd_Digitos <= 6) then
               vEdtValor.Text := Copy(vNovoConteudo, 0, 3) + '.' +
                                 Copy(vNovoConteudo, 4, 3)
            else
            if (vQtd_Digitos >= 7) and (vQtd_Digitos <= 9) then
               vEdtValor.Text := Copy(vNovoConteudo, 0, 3) + '.' +
                                 Copy(vNovoConteudo, 4, 3) + '.' +
                                 Copy(vNovoConteudo, 7, 3)
            else
            if (vQtd_Digitos >= 9) and (vQtd_Digitos <= 11) then
               vEdtValor.Text := Copy(vNovoConteudo, 0, 3) + '.' +
                                 Copy(vNovoConteudo, 4, 3) + '.' +
                                 Copy(vNovoConteudo, 7, 3) + '-' +
                                 Copy(vNovoConteudo, 10, 2);
         end;
     end;
end;

procedure TUtil.Clique_Btn_Number(Sender : TObject);
begin
     Preenche_Edit(StrToInt((Sender as TButton).Tag.ToString), vTipoTeclado);
end;

procedure TUtil.Clique_Btn_OK(Sender : TObject);
var
   vValor : String;
begin
    frm_cadastro.vCPF_numeros := tirapontos(frm_cadastro.edit1.Text);
    if ValidarCPF(frm_cadastro.vCPF_numeros) = true then
    begin
      frm_cadastro.fundoCPF.Visible := false;
      frm_cadastro.inputCPF.text := frm_cadastro.edit1.Text;

      frm_cadastro.VertScrollBox1.Margins.Bottom := 0;
      vPanel.Visible := False;
      vPanel.DisposeOf;
      vPanel := nil;
      FreeAndNil(vPanel);
      if vTipoTeclado = 'VLR' then
      begin
        if vEdtValor.Text = '' then
          vEdtValor.TextPrompt := 'R$ 0,00';
       end;
    end else
    begin
      showmessage('CPF inválido');
    end;
end;

procedure TUtil.Clique_Btn_Del(Sender : TObject);
begin
     if vTipoTeclado = 'VLR' then
     begin
         if vEdtValor.Text <> '0,00' then
         begin
             vEdtValor.Text := Copy(vEdtValor.Text, 1, (Length(vEdtValor.Text)-1));
             vDigitadoGeral := Copy(vDigitadoGeral, 1, (Length(vDigitadoGeral)-1));
             Preenche_Edit(-1, vTipoTeclado);
         end;
     end
     else
     if vTipoTeclado = 'TEL' then
     begin
         vEdtValor.Text := Copy(vEdtValor.Text, 1, (Length(vEdtValor.Text)-1));
         vDigitadoGeral := Copy(vDigitadoGeral, 1, (Length(vDigitadoGeral)-1));
         Preenche_Edit(-1, vTipoTeclado);
     end
     else
     if vTipoTeclado = 'CPF' then
     begin
         vEdtValor.Text := Copy(vEdtValor.Text, 1, (Length(vEdtValor.Text)-1));
         vDigitadoGeral := Copy(vDigitadoGeral, 1, (Length(vDigitadoGeral)-1));
         Preenche_Edit(-1, vTipoTeclado);
     end;
end;

function TUtil.Distancia(pLatPartida, pLongPartida, pLatDestino, pLongDestino : Double) : String;
var
   vResultado : Double;
begin
     {
     Objetivo: Retornar a distância entre dois pontos com base nas suas latitudes e longitudes.
     }
     vResultado := 6371 * ArcCos(Cos(pi*(90-pLatDestino)/180)*Cos((90-pLatPartida)*pi/180)+Sin((90-pLatDestino)*pi/180)*
                   Sin((90-pLatPartida)*pi/180)*Cos((pLongPartida-pLongDestino)*pi/180));

     Result := FloatToStrF(vResultado, ffNumber, 12, 0) + ' Km';
end;

procedure TUtil.Envia_Email(pAssunto, pDestinatario, pTitMsg, pMsg, pNome, pHash,
                            pURL_Logotipo, pAssinatura, pURL_Instagram, pURL_Twitter, pURL_Facebook,
                            pHost, pUserName, pPassWord : String);
var
   vTask : ITask;
begin
     vTask := TTask.Create(procedure
                           begin
                                TThread.Synchronize(nil, procedure
                                                         var
                                                            vIdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;
                                                            vIdSMTP : TIdSMTP;
                                                            vIdMessage : TIdMessage;
                                                            vEmail_Custom : String;
                                                         begin
                                                              vIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();
                                                              vIdSMTP                      := TIdSMTP.Create();
                                                              vIdMessage                   := TIdMessage.Create();
                                                              try
                                                                 // Configura os componentes !!!
                                                                 vIdSSLIOHandlerSocketOpenSSL.Host := pHost;
                                                                 vIdSSLIOHandlerSocketOpenSSL.Port := 587;
                                                                 vIdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := TIdSSLMode.sslmClient;

                                                                 vIdSMTP.IOHandler := vIdSSLIOHandlerSocketOpenSSL;
                                                                 vIdSMTP.Host      := pHost;
                                                                 vIdSMTP.Username  := pUserName;
                                                                 vIdSMTP.Password  := pPassWord;

                                                                 vIdMessage.ContentType := 'text/html';
                                                                 vIdMessage.CharSet     := 'UTF-8';

                                                                  // Monta Email (Assunto, Título, etc...)
                                                                  vEmail_Custom := vEmail_Padrao;
                                                                  vEmail_Custom := StringReplace(vEmail_Custom, '@titulo', pAssunto, [rfReplaceAll]);
                                                                  vEmail_Custom := StringReplace(vEmail_Custom, '@tit_msg', pTitMsg, [rfReplaceAll]);
                                                                  vEmail_Custom := StringReplace(vEmail_Custom, '@nome', pNome, [rfReplaceAll]);
                                                                  vEmail_Custom := StringReplace(vEmail_Custom, '@URL_Logotipo', pURL_Logotipo, [rfReplaceAll]);
                                                                  vEmail_Custom := StringReplace(vEmail_Custom, '@Assinatura', pAssinatura, [rfReplaceAll]);
                                                                  vEmail_Custom := StringReplace(vEmail_Custom, '@URL_Instagram', pURL_Instagram, [rfReplaceAll]);
                                                                  vEmail_Custom := StringReplace(vEmail_Custom, '@URL_Twitter', pURL_Twitter, [rfReplaceAll]);
                                                                  vEmail_Custom := StringReplace(vEmail_Custom, '@URL_Facebook', pURL_Facebook, [rfReplaceAll]);
                                                                  if pHash <> '' then
                                                                     vEmail_Custom := StringReplace(vEmail_Custom, '@corpo_email', pMsg +
                                                                                                                   '<br /><br /> <span style="font-size:44px;">' + pHash + '.</span><br />', [rfReplaceAll])
                                                                  else
                                                                      vEmail_Custom := StringReplace(vEmail_Custom, '@corpo_email', pMsg, [rfReplaceAll]);
                                                                  // Configuração da mensagem (TIdMessage)
                                                                  vIdMessage.From.Address           := pUserName;
                                                                  vIdMessage.From.Name              := pTitMsg;
                                                                  vIdMessage.ReplyTo.EMailAddresses := vIdMessage.From.Address;
                                                                  vIdMessage.Recipients.Add.Text    := pDestinatario;
                                                                  vIdMessage.Subject                := pAssunto;
                                                                  vIdMessage.Encoding               := meMIME;
                                                                  vIdMessage.Body.Clear;
                                                                  vIdMessage.Body.Add(vEmail_Custom);

                                                                  // Conexão e autenticação
                                                                  try
                                                                    vIdSMTP.Connect;
                                                                    vIdSMTP.Authenticate;
                                                                  except
                                                                    on E:Exception do
                                                                    begin
                                                              //           GhiFunc.MensagemToast(Self, 'Erro na conexão ou autenticação: ' + E.Message);
                                                                         Exit;
                                                                    end;
                                                                  end;

                                                                  // Envio da mensagem
                                                                  try
                                                                    vIdSMTP.Send(vIdMessage);
                                                              //      GhiFunc.MensagemToast(Self, 'Mensagem enviada com sucesso!');
                                                                  except
                                                                    On E:Exception do
                                                                    begin
                                                              //           GhiFunc.MensagemToast(Self, 'Erro ao enviar email: ' + E.Message);
                                                                    end;
                                                                  end;
                                                                  // desconecta do servidor
                                                                  vIdSMTP.Disconnect;
                                                              finally
                                                                vIdSSLIOHandlerSocketOpenSSL.Free;
                                                                vIdSMTP.Free;
                                                                vIdMessage.Free;
                                                              end;
                                                         end);
                           end);
     vTask.Start;
end;

function TUtil.InputPass(pTela : TForm; pTitulo, pDescricao : String;
                         pCorTitulo: TAlphaColor = TAlphaColorRec.Gainsboro;
                         pCorGeral : TAlphaColor = TAlphaColorRec.Gainsboro;
                         pCorBorda : TAlphaColor = TAlphaColorRec.Black) : String;
begin
//   Cria o Rectangle principal da mensagem !!!
     vRetMsg              := TRectangle.Create(pTela);
     vRetMsg.Parent       := pTela;
     vRetMsg.Align        := TAlignLayout.Center;
     vRetMsg.Height       := 110;
     vRetMsg.Width        := 300;
     vRetMsg.Fill.Color   := pCorGeral;
     vRetMsg.Stroke.Color := pCorBorda;

//   Cria o Rectangle do título !!!
     vRetTituloMsg              := TRectangle.Create(pTela);
     vRetTituloMsg.Parent       := vRetMsg;
     vRetTituloMsg.Align        := TAlignLayout.Top;
     vRetTituloMsg.Height       := 30;
     vRetTituloMsg.Fill.Color   := pCorTitulo;
     vRetTituloMsg.Stroke.Color := pCorBorda;

//   Cria Label do título !!!
     vLabel               := TLabel.Create(pTela);
     vLabel.Parent        := vRetTituloMsg;
     vLabel.Align         := TAlignLayout.Client;
     vLabel.Text          := pTitulo;
     vLabel.Margins.Left  := 10;
     vLabel.Margins.Right := 10;

//   Cria o Rectangle transparente para colocar o label e o edit;
     vRetGenerico              := TRectangle.Create(pTela);
     vRetGenerico.Parent       := vRetMsg;
     vRetGenerico.Align        := TAlignLayout.Top;
     vRetGenerico.Height       := 50;
     vRetGenerico.Fill.Color   := TAlphaColorRec.Null;
     vRetGenerico.Stroke.Color := TAlphaColorRec.Null;

//   Cria label da descrição !!!
     vLabel               := TLabel.Create(pTela);
     vLabel.Parent        := vRetGenerico;
     vLabel.Align         := TAlignLayout.Left;
     vLabel.Text          := Trim(pDescricao);
     vLabel.AutoSize      := False;
     vLabel.Width         := 80;
     vLabel.Margins.Left  := 10;
     vLabel.Margins.Right := 10;

     vEdit          := TEdit.Create(pTela);
     vEdit.Parent   := vRetGenerico;
     vEdit.Password := True;
     vEdit.Align    := TAlignLayout.Client;
     vEdit.Margins.Left   := 10;
     vEdit.Margins.Right  := 10;
     vEdit.Margins.Top    := 5;
     vEdit.Margins.Bottom := 5;

     vBtn := TSpeedButton.Create(pTela);
     vBtn.Parent         := vRetMsg;
     vBtn.Align          := TAlignLayout.Client;
     vBtn.Margins.Left   := 20;
     vBtn.Margins.Right  := 20;
     vBtn.Margins.Top    := 5;
     vBtn.Margins.Bottom := 5;
     vBtn.Text           := 'Ok';

//     Result
end;


{
procedure TUtil.Conecta_Unidac(pTela: TForm; pConection : TUniConnection; pStringConIPV4, pStringConIPV6 : String);
var
  lConn: TUniConnection;
begin
     DM.Conn.Connect;

{    Application.OnException := AppOnExcept;
    lConn := TUniConnection.Create(Application);

    pConection.Disconnect;
    lConn.ConnectString := pStringConIPV6;
    lConn.Connect;
    pConection := lConn;

{     lConn := TUniConnection.Create(Application);

{     pConection.Disconnect;
      try
          // Tenta conexão IPV4 (Padrão de redes no Brasil)
          lConn.ConnectString := pStringConIPV6;
          lConn.Connect;
          pConection := lConn;
      except
          // Em caso de testes da Apple, da erro em IPV4 e cai para IPV6
          on E: Exception do
          begin
            //ShowMessage(E.QualifiedClassName + sLineBreak + E.Message);
          //pConection.Disconnect;
          //pConection.SpecificOptions.Add('MySQL.Provider=prDirect');// := 'prDirect';
          //pConection.SpecificOptions.Values['MySQL.Provider'] := 'prDirect';


              //pConection.SpecificOptions.Add('MySQL.Provider=prDirect');// := 'prDirect';
              //pConection.SpecificOptions.Values['MySQL.Provider'] := 'prDirect';
              //}
{          end;
      end;
//           GhiFunc.MensagemToast(pTela, 'Você está offline.');

      try
        lConn := TUniConnection.Create(Application);
        //pConection.Disconnect;
        //lConn.ConnectString := pStringConIPV6;
        lConn.ConnectString := pStringConIPV4;
        //pConection.SpecificOptions.Add('MySQL.Provider=prDirect');// := 'prDirect';
        //pConection.SpecificOptions.Values['MySQL.Provider'] := 'prDirect';
       lConn.Connect;

      except
      //
      end;

     pConection := lConn;
     //Abort;     }
//end;

procedure TUtil.ConfiguraUrl_PagSeguro(pAmbiente: String);
begin
     if pAmbiente = 'Producao' then
     begin
          vUrlExecPagSeg   := 'https://ws.pagseguro.uol.com.br/v2/sessions';
          vUrlConsPagSeg   := '';
          vEmail_PagSeguro := 'seuemail@gmail.com';
          vToken_PagSeguro := '';
     end
     else
     if pAmbiente = 'Teste' then
     begin
          vUrlExecPagSeg   := 'https://ws.sandbox.pagseguro.uol.com.br/v2/sessions';
          vUrlConsPagSeg   := '';
          vEmail_PagSeguro := 'seuemail@gmail.com';
          vToken_PagSeguro := '';
     end;
end;

procedure TUtil.Nova_Trans_PagSeguro(pNome, pNumCartao, pDataValidade,
                                            pCodSeg, pBandeira: String;
                                     pValor : Currency; pParcelas : Integer);
var
  URL, Retorno,vJSON : String;
  JsonStreamRetorno, JsonStreamEnvio: TStringStream;
  vIdHttp : TIdHTTP;
  vIdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;

  vRestClient : TRestClient;
  vRestRequest : TRESTRequest;
  vRestResponse : TRestResponse;
begin
    vRestRequest.Resource := vUrlExecPagSeg;
    vRestRequest.Body.JSONWriter;

    vJSON := '';
    JsonStreamEnvio   := TStringStream.Create(vJSON);
    JsonStreamRetorno := TStringStream.Create('');

    vIdHttp           := TIdHTTP.Create();

    vIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();
    try
        try
            vIdHttp.Request.ContentType := 'application/json';
            vIdHttp.Request.Charset     := 'UTF-8';
            vIdHttp.Request.Method      := 'POST';
            vIdHttp.Request.BasicAuthentication := True;
            vIdHttp.IOHandler           := vIdSSLIOHandlerSocketOpenSSL;

            vIdHttp.Post(vUrlExecTrans, JsonStreamEnvio, JsonStreamRetorno);
        except
             on E:EIdHTTPProtocolException do
                ShowMessage(e.ErrorMessage);
        end;
    finally
        vIdHttp.Free;
        vIdSSLIOHandlerSocketOpenSSL.Free;
    end;
end;

procedure TUtil.ConfiguraUrl_Cielo;
begin
     vMerchantId   := '';
     vMerchantKey  := '';
end;

{
function TUtil.BuscaCampoSTR(pSQL : String) : String;
var
   Query : TUniQuery;
begin
    Query := TUniQuery.Create(Application);
    try
       Query.Close;
       Query.SQL.Clear;
       Query.SQL.Add(pSQL);
       Query.Open;
    finally
      Query.Free;
    end;
end;

procedure TUtil.ExecutaSQL(pSQL : String);
var
   Query : TUniQuery;
begin
    Query := TUniQuery.Create(Application);
    try
       Query.Close;
       Query.Connection :=  DM.Conn;
       Query.SQL.Clear;
       Query.SQL.Add(pSQL);
       Query.ExecSQL;
    finally
      Query.Free;
    end;
end;

function TUtil.Data_Hora_Servidor: TDateTime;
var
   Query : TUniQuery;
begin
    Query := TUniQuery.Create(Application);
    try
       Query.Close;
       Query.Connection :=  DM.Conn;
       Query.SQL.Clear;
       Query.SQL.Add('select current_timestamp as data_hora from dual');
       Query.Open;
       Result := Query.FieldByName('data_hora').AsDateTime;
    finally
      Query.Free;
    end;
end;

function TUtil.Data_Servidor: TDateTime;
var
   Query : TUniQuery;
begin
    Query := TUniQuery.Create(Application);
    try
       Query.Close;
       Query.Connection :=  DM.Conn;
       Query.SQL.Clear;
       Query.SQL.Add('select current_date as data from dual');
       Query.Open;
       Result := Query.FieldByName('data').AsDateTime;
    finally
      Query.Free;
    end;
end; }

procedure TUtil.Fecha_Tela(pForm : TForm);
begin
     if not (pForm = nil) then
        pForm.Close;
end;

function TUtil.UltimoDiaDoMes(MesAno: string ): string;
var
   sMes: string;
   sAno: string;
begin
    sMes := Copy( MesAno, 1, 2 );
    sAno := Copy( MesAno, 4, 2 );
    if Pos( sMes, '01 03 05 07 08 10 12' ) > 0 then
       UltimoDiaDoMes := '31'
    else
    if sMes <> '02' then
       UltimoDiaDoMes := '30'
    else
    if ( StrToInt( sAno ) mod 4 ) = 0 then
       UltimoDiaDoMes := '29'
    else
        UltimoDiaDoMes := '28';
end;


function TUtil.ValidarCPF(cpf: String): Boolean;
var
  v: array[0..1] of Word;
begin
  if (Length(cpf) <> 11) then
  begin
     //showmessage('CPF deve ter 11 dígitos. (Apenas números)');
     result := false;
     exit
  end ;

  if pos(cpf,'11111111111.22222222222.33333333333.44444444444.55555555555.'+
         '66666666666.77777777777.88888888888.99999999999.00000000000') > 0 then
  begin
     //showmessage('CPF Informado não é válido');
     result := false;
     exit ;
  end ;

  try
    //Nota: Calcula o primeiro dígito de verificação.
    v[0] := 10*StrToInt(cpf[0]) + 9*StrToInt(cpf[1]) + 8*StrToInt(cpf[2]);
    v[0] := v[0] + 7*StrToInt(cpf[3]) + 6*StrToInt(cpf[4]) + 5*StrToInt(cpf[5]);
    v[0] := v[0] + 4*StrToInt(cpf[6]) + 3*StrToInt(cpf[7]) + 2*StrToInt(cpf[8]);
    v[0] := 11 - v[0] mod 11;
    v[0] := IfThen(v[0] >= 10, 0, v[0]);
    //Nota: Calcula o segundo dígito de verificação.
    v[1] := 11*StrToInt(cpf[0]) + 10*StrToInt(cpf[1]) + 9*StrToInt(cpf[2]);
    v[1] := v[1] + 8*StrToInt(cpf[3]) +  7*StrToInt(cpf[4]) + 6*StrToInt(cpf[5]);
    v[1] := v[1] + 5*StrToInt(cpf[6]) +  4*StrToInt(cpf[7]) + 3*StrToInt(cpf[8]);
    v[1] := v[1] + 2*v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    if ((v[0] <> StrToInt(cpf[9])) or (v[1] <> StrToInt(cpf[10])))then
    begin
      //showmessage('CPF Informado não é válido');
      result := false;
      exit;
    end else
    begin
      result := true;
    end;

  except
    on E:Exception do
    begin
      //showmessage('Erro ao validar CPF '+slinebreak+E.Message);
      result := false;
      exit;
    end;
  end;

end;

function TUtil.isCPF(CPF: string): boolean;
var
   vTask : ITask;
begin
     vTask := TTask.Create(procedure
                           begin
                                TThread.Synchronize(nil, procedure
                                                          var n1,n2,n3,n4,n5,n6,n7,n8,n9: integer;
                                                                 d1,d2: integer;
                                                                 digitado, calculado: string;
                                                          begin
                                                             n1:=StrToInt(CPF[1]);
                                                             n2:=StrToInt(CPF[2]);
                                                             n3:=StrToInt(CPF[3]);
                                                             n4:=StrToInt(CPF[5]);
                                                             n5:=StrToInt(CPF[6]);
                                                             n6:=StrToInt(CPF[7]);
                                                             n7:=StrToInt(CPF[9]);
                                                             n8:=StrToInt(CPF[10]);
                                                             n9:=StrToInt(CPF[11]);
                                                                               d1:=n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
                                                            d1:=11-(d1 mod 11);
                                                             if d1>=10 then d1:=0;
                                                                  d2:=d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
                                                              d2:=11-(d2 mod 11);
                                                              if d2 >= 10 then
                                                                 d2 := 0;
                                                              calculado := inttostr(d1) + inttostr(d2);
                                                             digitado := CPF[13] + CPF[14];
                                                             if calculado = digitado then
                                                                 vResultBOL := true
                                                             else
                                                                 vResultBOL := false;                                                         end);
                           end);
     vTask.Start;
     
     Result := vResultBOL;
end;

function TUtil.Retorna_Num_Tel_Android() : String;
{$IFDEF ANDROID} //if the operative system is Android
var
  TTelMgr: JTelephonyManager;
{$ENDIF ANDROID}
begin
{$IFDEF ANDROID} //if the operative system is Android
  TTelMgr := TJTelephonyManager.Wrap((SharedActivityContext.getSystemService(
             TJContext.JavaClass.TELEPHONY_SERVICE) as ILocalObject).GetObjectID);
  Result  := JStringToString(TTelMgr.getLine1Number);
{$ENDIF ANDROID}
end;

procedure TUtil.GravarINI(pNomeArq, pUser, pSenha : String);
var
   vArquivo_Ini : TIniFile;
begin
    {$IFDEF ANDROID}
    vArquivo_Ini := TIniFile.Create(GetHomePath + PathDelim + pNomeArq + '.ini');
    vArquivo_Ini.WriteString(pNomeArq, 'user', pUser);
    vArquivo_Ini.WriteString(pNomeArq, 'pass', pSenha);
    vArquivo_Ini.Free;
    {$ENDIF ANDROID}

end;

function TUtil.LerIni(pNomeArq : String) : TResultArray;
var
   vArquivo_Ini : TIniFile;
begin
// TERMINAR AINDA...
   {$IFDEF ANDROID}
   try
       vArquivo_Ini := TIniFile.Create(GetHomePath + PathDelim + pNomeArq + '.ini');
       Result[1] := vArquivo_Ini.ReadString(pNomeArq, 'user', '');
       Result[2] := vArquivo_Ini.ReadString(pNomeArq, 'pass', '');
   finally
       vArquivo_Ini.Free;
   end;
   {$ENDIF ANDROID}
end;

procedure TUtil.Login_Facebook(pTela : TForm; pWebBrowser : TWebBrowser);
var
   vURL : String;

          procedure Facebook_AccessTokenRedirect(const AURL: string;
          var DoCloseWebView: boolean);
          var
             LATPos: integer;
             LToken: string;
          begin
              try
                  LATPos := Pos('access_token=', AURL);
                  if (LATPos > 0) then
                  begin
                      LToken := Copy(AURL, LATPos + 13, Length(AURL));
                      if (Pos('&', LToken) > 0) then
                      begin
                          LToken := Copy(LToken, 1, Pos('&', LToken) - 1);
                      end;

                      vAccesToken := LToken;
                      if (LToken <> '') then
                      begin
                          DoCloseWebView := True;
                      end;
                  end
                  else
                  begin
                    LATPos := Pos('api_key=', AURL);
                    if LATPos <= 0 then
                    begin
                      LATPos := Pos('access_denied', AURL);

                      if (LATPos > 0) then
                      begin
                        //Acesso negado/usuário cancelou/usuário não permitiu o acesso
                        vAccesToken := '';
                        DoCloseWebView := True;
                      end;
                    end;
                  end;
              except
                  on E: Exception do
                    ShowMessage(E.Message);
              end;
          end;


begin
     try
         vAccesToken := '';

         vURL := 'https://www.facebook.com/dialogs/oauth';
         vURL := vURL + '?client_id=' + URIEncode('id_seu_app');
         vURL := vURL + '&response_type=token';
         vURL := vURL + '&scope' + URIEncode('user_about_me, user_birthday');
         vURL := vURL + '&redirect_uri=' + URIEncode('https://www.facebook.com/connect/login_sucess.html');

         pWebBrowser.Visible := True;
         pWebBrowser.Navigate(vURL);

         if vAccesToken <> '' then
         begin

         end
         else
             MensagemToast(pTela, 'Login negado.');
     except
           on E: Exception do
              MensagemToast(pTela, E.Message);
     end;

end;

function TUtil.getCamposJsonString(json, value:String): String;
var
   LJSONObject: TJSONObject;
   jSubPar: TJSONPair;
   i,j:integer;
begin

//   LJSONObject := TJSONObject.Create;
   LJSONObject := nil;
   try

      LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(json),0) as TJSONObject;


      for j := 0 to LJSONObject.Size - 1 do  begin
         jSubPar := LJSONObject.Get(j);  //pega o par no índice j
         if (trim(jSubPar.JsonString.Value) = value) then
            Result :=   jSubPar.JsonValue.Value;

      end;
   finally
      LJSONObject.Free;
   end;
end;

function TUtil.Nova_Trans_Simples_Nova(pCliId, pNome, pNumCartao,
                                       pDataValidade, pCodSeg, pBandeira, pValor: String;
                                       pParcelas : Integer) : String;
var
  JsonStreamEnvio, JsonStreamRetorno: TStringStream;
  vIdHttp : TIdHTTP;
  vIdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;
  URL, Retorno, vJSON : String;
  vRetorno : TStringStream;
begin
    vJSON := '{"Customer":{ "CliId":' + pCliId + ', "Name":"' + pNome + '"' +
             '}, "Payment":{"Type":"CreditCard","Amount":' +
             StringReplace(StringReplace(pValor, ',', '', [rfReplaceAll]), '.', '', [rfReplaceAll]) + ',' +
             '"Installments":'+ IntToStr(pParcelas) + ',' +
             '"SoftDescriptor":"Sua Empresa", "CreditCard":{"CardNumber":"'+ pNumCartao + '",' +
             '"Holder":"' + pNome + '",' + '"ExpirationDate":"' + pDataValidade + '",' +
             '"SecurityCode":"' + pCodSeg + '",' + '"Brand":"' + pBandeira + '"}}}';
    JsonStreamEnvio   := TStringStream.Create(vJSON);
    JsonStreamRetorno := TStringStream.Create('');
//    ShowMessage(vJSON);
    vIdHttp           := TIdHTTP.Create();

//    vIdHttp.Request.BasicAuthentication := false;

{    vIdHttp.Request.Clear;
    vIdHttp.Request.CustomHeaders.Clear;}

//    vIdHttp.Request.CustomHeaders.AddValue('MerchantId', vMerchantId);
//    vIdHttp.Request.CustomHeaders.AddValue('MerchantKey', vMerchantKey);

    vIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();
    try
        try
            vIdHttp.Request.UserAgent   := 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36';
            vIdHttp.Request.ContentType := 'application/json';
            vIdHttp.Request.Charset     := 'UTF-8';
            vIdHttp.Request.Method      := 'POST';
            vIdHttp.Request.BasicAuthentication := True;
            vIdHttp.IOHandler                   := vIdSSLIOHandlerSocketOpenSSL;

//            vIdHttp.Post(vUrlExecTrans, JsonStreamEnvio, JsonStreamRetorno);
            Result := getCamposJsonString(vIdHttp.Post(vUrlExecTrans, JsonStreamEnvio), 'status');
//            Result := getCamposJsonString(JsonStreamRetorno.ToString, 'status');
        except
             on E:EIdHTTPProtocolException do
                ShowMessage(e.ErrorMessage);
        end;
    finally
        vIdHttp.Free;
        vIdSSLIOHandlerSocketOpenSSL.Free;
    end;
end;

end.


