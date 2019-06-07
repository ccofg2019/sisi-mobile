unit u_registraOcorrencia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.DateTimeCtrls, FMX.ScrollBox,
  FMX.Memo, FMX.Edit, FMX.Layouts, FMX.ListBox, System.JSON, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  REST.Response.Adapter, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.Sensors,
  System.Sensors.Components, System.Net.HttpClient, System.math

    //Permissão localização
  {$IFDEF ANDROID}
  ,System.Permissions, Androidapi.Helpers, Androidapi.JNI.Os, FGX.ProgressDialog,
  FMX.Effects;
  {$ELSE}
  ;
  {$ENDIF}

type
  Tfrm_registraOcorrencia = class(TForm)
    header: TToolBar;
    Rectangle10: TRectangle;
    menu: TSpeedButton;
    Text1: TText;
    VertScrollBox1: TVertScrollBox;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Localizacao: TLocationSensor;
    ed_longitude: TEdit;
    ed_latitude: TEdit;
    Timer1: TTimer;
    Image1: TImage;
    fgActivityDialog: TfgActivityDialog;
    ShadowEffect1: TShadowEffect;
    Image7: TImage;
    lt_principal: TLayout;
    formNome: TLayout;
    labelNome: TLabel;
    Rectangle1: TRectangle;
    edit1: TEdit;
    ShadowEffect2: TShadowEffect;
    Layout1: TLayout;
    Label1: TLabel;
    Rectangle8: TRectangle;
    ShadowEffect3: TShadowEffect;
    ComboBox2: TComboBox;
    Layout5: TLayout;
    Label5: TLabel;
    Rectangle5: TRectangle;
    ShadowEffect5: TShadowEffect;
    ComboBox3: TComboBox;
    Layout6: TLayout;
    Label6: TLabel;
    Rectangle6: TRectangle;
    ShadowEffect4: TShadowEffect;
    data: TDateEdit;
    Layout4: TLayout;
    Label4: TLabel;
    Rectangle4: TRectangle;
    ShadowEffect6: TShadowEffect;
    hora: TTimeEdit;
    Layout3: TLayout;
    Label3: TLabel;
    Rectangle3: TRectangle;
    ShadowEffect7: TShadowEffect;
    Memo1: TMemo;
    StyleBook1: TStyleBook;
    procedure menuClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LocalizacaoLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure Timer1Timer(Sender: TObject);
    procedure Memo1Enter(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure Image7Click(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormFocusChanged(Sender: TObject);
  private
    { Private declarations }
    FProgressDialogThread: TThread;
    FActivityDialogThread: TThread;
    latitude, longitude: string;
    vFoco: TControl;
    vBounds: TRectF;
    vOffSef: boolean;
    procedure calcBounds(Sender: TObject; var contentBounds: TRectF);
    procedure restorePosition;
    procedure updatePosition;
    procedure ajustar_scroll();
  public
    { Public declarations }
  end;

var
  frm_registraOcorrencia: Tfrm_registraOcorrencia;

implementation

{$R *.fmx}

uses registroOcorrencias, u_validacao, home;

procedure Tfrm_registraOcorrencia.ajustar_scroll;
var
  x: integer;
begin
    VertScrollBox1.Margins.Bottom := 250;
    VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, TControl(vFoco).Position.Y - 90);
end;

procedure Tfrm_registraOcorrencia.calcBounds(Sender: TObject;
  var contentBounds: TRectF);
begin
if (vOffSef) and (vBounds.Top > 0) then
  begin
    contentBounds.Bottom := Max(contentBounds.Bottom, 2 * ClientHeight - vBounds.Top);
  end;
end;

procedure Tfrm_registraOcorrencia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  edit1.Text := '';
  ComboBox2.ItemIndex := -1;
  ComboBox3.ItemIndex := -1;
  memo1.Lines.Clear;
  ed_longitude.Text := '';
  ed_latitude.Text  := '';
  text1.Enabled := true
end;

procedure Tfrm_registraOcorrencia.FormFocusChanged(Sender: TObject);
begin
  updatePosition;
end;

procedure Tfrm_registraOcorrencia.FormShow(Sender: TObject);
begin
  VertScrollBox1.OnCalcContentBounds := calcBounds;
  edit1.SetFocus;
  data.Date := date;
  hora.Time := time;
end;

procedure Tfrm_registraOcorrencia.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  //VertScrollBox1.Margins.Bottom := 0;
  vBounds.Create(0,0,0,0);
  vOffSef := false;
  restorePosition;
end;

procedure Tfrm_registraOcorrencia.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  vBounds := TRectF.Create(Bounds);
  vBounds.TopLeft := ScreenToClient(vBounds.TopLeft);
  vBounds.BottomRight := ScreenToClient(vBounds.BottomRight);
  updatePosition;
end;

procedure Tfrm_registraOcorrencia.Image7Click(Sender: TObject);
begin
 text1Click(self);
end;

procedure Tfrm_registraOcorrencia.LocalizacaoLocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var long, lati: string;
begin
  lati  := Format('%2.6f', [localizacao.Sensor.Latitude]);
  long  := Format('%2.6f', [localizacao.Sensor.Longitude]);

  latitude  := StringReplace(lati, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  longitude := StringReplace(long, ',', '.', [rfReplaceAll, rfIgnoreCase]);
end;

procedure Tfrm_registraOcorrencia.Memo1Enter(Sender: TObject);
begin
  //vFoco := TControl(TMemo(sender).Parent);
  //ajustar_scroll();
end;

procedure Tfrm_registraOcorrencia.menuClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_registraOcorrencia.restorePosition;
begin
  VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, 0);
  lt_principal.Align := TAlignLayout.Client;
  VertScrollBox1.RealignContent;
end;

procedure Tfrm_registraOcorrencia.Text1Click(Sender: TObject);
var
  body, user, pass: string;
begin
  {$IFDEF ANDROID}

  if (edit1.Text = '') or (Memo1.Lines.Text = '') then
  begin
   showMessage('Informe o título e a descrição da ocorrência');
   abort;
  end;

  if not fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
            VertScrollBox1.Enabled := false;
            text1.Enabled := false;
            text1.AnimateFloat('Position.Y',30,1, TAnimationType.&Out, TInterpolationType.Elastic);
            text1.AnimateFloat('Position.Y',0,1, TAnimationType.&Out, TInterpolationType.Elastic);
          end);

          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;

          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Enviando...';
            fgActivityDialog.Show;
          end);

          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;

          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Obtendo localização GPS...';
            localizacao.Active := True;
          end);

          Sleep(2000);
          if TThread.CheckTerminated then
            Exit;

          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Enviando requisição...';
            if (latitude <> '') and (longitude <> '' ) then
            try
               body := '{'+
          '	   "title":"'+edit1.Text+'", '+
          '	   "story":"'+memo1.Text+'", '+
          '    "occurrence_date": "'+FormatDateTime('yyyy-mm-dd', date)+'",'+
          '    "occurrence_time": "'+frm_home.lbl_time.text+'", '+
          '    "coordinates": "'+latitude+','+longitude+'", '+
          '    "occurrence_type_id": '+frm_registroOcorrencias.occurrence_type_id+', '+
          '    "zone_id": 1 }';

                RESTRequest1.Params.Items[1].Value := body;
                RESTRequest1.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;
                RESTRequest1.Execute;

                //Tratamento de possíveis erros...falta implementar
                if RESTResponse1.StatusText = 'OK' then
                begin
                //
                end;
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
            localizacao.Active := false;
            text1.Enabled := true;
          end);

          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;
        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              VertScrollBox1.Enabled := true;
              fgActivityDialog.Hide;
              showMessage('Ocorrência cadastrada com sucesso');
              close;
            end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;
    {$ENDIF}
end;

procedure Tfrm_registraOcorrencia.Timer1Timer(Sender: TObject);
var
  body, user, pass: string;
  JSONObj: TJSONValue;
begin
   if (ed_latitude.Text <> '') and (ed_longitude.Text <> '' ) then
   try
     body := '{'+
'	   "title":"'+edit1.Text+'", '+
'	   "story":"'+memo1.Text+'", '+
'    "occurrence_date": "'+FormatDateTime('yyyy-mm-dd', date)+'",'+
'    "occurrence_time": "'+frm_home.lbl_time.text+'", '+
'    "coordinates": "'+ed_latitude.Text+','+ed_longitude.Text+'", '+
'    "occurrence_type_id": '+frm_registroOcorrencias.occurrence_type_id+', '+
'    "zone_id": 1 }';

      //RESTRequest1.Params.Items[1].Value := body;

      //RESTRequest1.Params.ParameterByName('body').Value := body;
      //RESTRequest1.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;
      RESTRequest1.Params.Clear;
      RESTRequest1.Body.ClearBody;

      RESTRequest1.Body.Add(body);
      RESTRequest1.AddParameter('Authorization', 'Bearer ' + frm_validacao.memo1.Text,
                                          TRESTRequestParameterKind.pkHTTPHEADER,
                                          [TRESTRequestParameterOption.poDoNotEncode]);

      RESTRequest1.Execute;

      if RESTResponse1.StatusText = 'OK' then
      begin
        timer1.Enabled := false;
        text1.Enabled := true;
        showMessage('Ocorrência cadastrada com sucesso!');
        close;
      end;
   except on e:exception do
   begin
    showMessage('Falha no cadastro. Erro 422');
    abort;
   end;
  end;

end;

procedure Tfrm_registraOcorrencia.updatePosition;
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
