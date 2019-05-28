unit cadastroIrregularidades;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, System.Sensors, System.Sensors.Components

   //Permissão localização
  {$IFDEF ANDROID}
  ,System.Permissions, Androidapi.Helpers, Androidapi.JNI.Os, FGX.ProgressDialog,
  FMX.Effects;
  {$ELSE}
  ;
  {$ENDIF}

type
  Tfrm_cadastroIrregularidades = class(TForm)
    header: TLayout;
    ToolBar1: TToolBar;
    Rectangle10: TRectangle;
    menu: TSpeedButton;
    Text3: TText;
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Edit1: TEdit;
    Layout5: TLayout;
    Rectangle5: TRectangle;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Memo1: TMemo;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    Localizacao: TLocationSensor;
    ed_latitude: TEdit;
    ed_longitude: TEdit;
    Timer1: TTimer;
    Image1: TImage;
    Rectangle8: TRectangle;
    Rectangle3: TRectangle;
    fgActivityDialog: TfgActivityDialog;
    RESTRequest1: TRESTRequest;
    ShadowEffect1: TShadowEffect;
    procedure menuClick(Sender: TObject);
    procedure Text3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure LocalizacaoLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FProgressDialogThread: TThread;
    FActivityDialogThread: TThread;
    latitude, longitude: string;
  public
    { Public declarations }
  end;

var
  frm_cadastroIrregularidades: Tfrm_cadastroIrregularidades;

implementation

{$R *.fmx}

uses home, registroIrregularidades, u_validacao;

procedure Tfrm_cadastroIrregularidades.Button1Click(Sender: TObject);
begin
 localizacao.Active := true;
end;

procedure Tfrm_cadastroIrregularidades.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 edit1.Text := '';
 ComboBox1.ItemIndex := -1;
 memo1.Lines.Clear;
 ed_latitude.Text := '';
 ed_longitude.Text := '';
 text3.Enabled := true;
end;

procedure Tfrm_cadastroIrregularidades.LocalizacaoLocationChanged(
  Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
var long, lati: string;
begin
  lati  := Format('%2.6f', [localizacao.Sensor.Latitude]);
  long  := Format('%2.6f', [localizacao.Sensor.Longitude]);

  latitude := StringReplace(lati, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  longitude := StringReplace(long, ',', '.', [rfReplaceAll, rfIgnoreCase]);
end;

procedure Tfrm_cadastroIrregularidades.menuClick(Sender: TObject);
begin
 close;
end;

procedure Tfrm_cadastroIrregularidades.Text3Click(Sender: TObject);
var
  body, user, pass, lat, long: string;
begin
  if (edit1.Text = '') or (memo1.Lines.Text = '') or (comboBox1.ItemIndex < 0) then
  begin
    ShowMessage('Preencha todos os campos.');
    abort
  end;

  {$IFDEF ANDROID}
  if not fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
            text3.Enabled := false;
            text3.AnimateFloat('Position.Y',30,1, TAnimationType.&Out, TInterpolationType.Elastic);
            text3.AnimateFloat('Position.Y',0,1, TAnimationType.&Out, TInterpolationType.Elastic);
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
            if (latitude <> '') and (longitude <> '' )then
            try
               body := '{'+
          '	   "title":"'+edit1.Text+'", '+
          '	   "story":"'+memo1.Text+'", '+
          '    "coordinates": "'+latitude+','+longitude+'", '+
          '    "irregularity_type_id": '+frm_registroIrregularidades.irregularity_type_id+', '+
          '    "zone_id": 1 }';

                RESTRequest1.Params.Items[1].Value := body;
                //RESTRequest1.Params.ParameterByName('body').Value := body;
                //RESTRequest1.Body.Add(body);
                //RESTRequest1.AddParameter('Authorization', 'Bearer ' + frm_validacao.memo1.Text,
                                         // TRESTRequestParameterKind.pkHTTPHEADER,
                                         // [TRESTRequestParameterOption.poDoNotEncode]);

                RESTRequest1.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;

                RESTRequest1.Execute;

                //Tratamento de possíveis erros...falta implementar
                if RESTResponse1.StatusText = 'OK' then
                begin
                  //timer1.Enabled := false;
                  //text3.Enabled := true;
                  //RESTClient1.ResetToDefaults;
                  //RESTResponse1.ResetToDefaults;
                  //RESTRequest1.ResetToDefaults;
                  //showMessage('Irregularidade cadastrada com sucesso!');
                  //close;
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
            text3.Enabled := true;
          end);

          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;
        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              fgActivityDialog.Hide;
              showMessage('Irregularidade cadastrada com sucesso');
              close;
            end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;












  {  PermissionsService.RequestPermissions([JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION)],
      procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
      begin
        if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
        begin
          { activa o sensor }

 {       end
        else
        begin
          ShowMessage('O SISI precisa do acesso a sua localização.');
        end;
      end);  }
    {$ENDIF}
end;

procedure Tfrm_cadastroIrregularidades.Timer1Timer(Sender: TObject);
var
  body, user, pass, lat, long: string;
  JSONObj: TJSONValue;
begin

end;

end.
