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
  System.Sensors.Components, System.Net.HttpClient

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
    Layout1: TLayout;
    Label1: TLabel;
    Edit1: TEdit;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Layout3: TLayout;
    Rectangle3: TRectangle;
    Label3: TLabel;
    Layout4: TLayout;
    Rectangle4: TRectangle;
    Label4: TLabel;
    Layout5: TLayout;
    Rectangle5: TRectangle;
    Label5: TLabel;
    Layout6: TLayout;
    Rectangle6: TRectangle;
    Label6: TLabel;
    Memo1: TMemo;
    data: TDateEdit;
    hora: TTimeEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Localizacao: TLocationSensor;
    ed_longitude: TEdit;
    ed_latitude: TEdit;
    Timer1: TTimer;
    Image1: TImage;
    Rectangle8: TRectangle;
    Rectangle7: TRectangle;
    Rectangle9: TRectangle;
    Rectangle11: TRectangle;
    Rectangle12: TRectangle;
    fgActivityDialog: TfgActivityDialog;
    ShadowEffect1: TShadowEffect;
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
  private
    { Private declarations }
    FProgressDialogThread: TThread;
    FActivityDialogThread: TThread;
    vFoco: TControl;
    latitude, longitude: string;
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

procedure Tfrm_registraOcorrencia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  edit1.Text := '';
  ComboBox1.ItemIndex := -1;
  ComboBox2.ItemIndex := -1;
  memo1.Lines.Clear;
  ed_longitude.Text := '';
  ed_latitude.Text  := '';
  text1.Enabled := true
end;

procedure Tfrm_registraOcorrencia.FormShow(Sender: TObject);
begin
  edit1.SetFocus;
  data.Date := date;
  hora.Time := time;
end;

procedure Tfrm_registraOcorrencia.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  VertScrollBox1.Margins.Bottom := 0;
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
  vFoco := TControl(TMemo(sender).Parent);
  ajustar_scroll();
end;

procedure Tfrm_registraOcorrencia.menuClick(Sender: TObject);
begin
  close;
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

end.
