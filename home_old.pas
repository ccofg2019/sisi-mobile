unit home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, FMX.MultiView,
  FMX.Effects, FMX.Ani, System.Sensors, System.Sensors.Components, u_PowerManager,System.JSON

  //Para vibração e permissão de localização --->
  {$IFDEF ANDROID}
  ,Androidapi.JNI.Os,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.Helpers,
  Androidapi.JNIBridge, FMX.Edit, System.Permissions, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope; // SharedActivity ;
  {$ELSE}
  ;
  {$ENDIF}


type
  Tfrm_home = class(TForm)
    header: TToolBar;
    Rectangle10: TRectangle;
    menu: TSpeedButton;
    title: TText;
    btnRegistrarOcorrencia: TLayout;
    itemRegistrarIrregularidade: TLayout;
    btnRegistrarIrregularidade: TLayout;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Image2: TImage;
    Image3: TImage;
    S: TImage;
    Layout2: TLayout;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle2: TRectangle;
    Layout3: TLayout;
    ShadowEffect1: TShadowEffect;
    lt_menu: TLayout;
    AnimaMenu: TFloatAnimation;
    Rectangle6: TRectangle;
    Circle4: TCircle;
    Circle5: TCircle;
    Label5: TLabel;
    Label6: TLabel;
    Layout4: TLayout;
    Rectangle7: TRectangle;
    Circle8: TCircle;
    Label9: TLabel;
    Label10: TLabel;
    swAccelerometerSensorActive: TSwitch;
    MotionSensor1: TMotionSensor;
    Timer1: TTimer;
    lbAccelerationX: TLabel;
    StyleBook1: TStyleBook;
    StyleBook2: TStyleBook;
    Timer2: TTimer;
    Image1: TImage;
    Layout1: TLayout;
    Circle3: TCircle;
    Label4: TLabel;
    ShadowEffect2: TShadowEffect;
    Layout5: TLayout;
    Timer3: TTimer;
    lbl_time: TLabel;
    lbl_tempoAlerta: TLabel;
    Timer4: TTimer;
    Label2: TLabel;
    Label1: TLabel;
    Image4: TImage;
    Image7: TImage;
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    Localizacao: TLocationSensor;
    Timer5: TTimer;
    procedure btnSairClick(Sender: TObject);
    procedure btnRegistrarOcorrenciaClick(Sender: TObject);
    procedure itemRegistrarIrregularidadeClick(Sender: TObject);
    procedure btnRegistrarIrregularidadeClick(Sender: TObject);
    procedure menuClick(Sender: TObject);
    procedure Circle3Click(Sender: TObject);
    procedure Rectangle6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AnimaMenuFinish(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure swAccelerometerSensorActiveSwitch(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Text4Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure LocalizacaoLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
  private
    { Private declarations }
    var cont: integer;
    latitude, longitude: string;
  public
    { Public declarations }
  var_horafinal: TTime;
    {$IFDEF ANDROID}
    BloqueioTela: JWakeLock;
    {$ENDIF}
  end;

var
  frm_home: Tfrm_home;

implementation

{$R *.fmx}

uses registroOcorrencias, login, listaOcorrencias, u_validacao, cadastro,
  registroIrregularidades, listaIrregularidades;

procedure Tfrm_home.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_home.Circle3Click(Sender: TObject);
begin
  label4.AnimateFloat('RotationAngle',360,2, TAnimationType.&Out, TInterpolationType.Elastic);

  lt_menu.Position.Y := frm_home.Height + 60;
  lt_menu.Visible := true;

  AnimaMenu.Inverse := false;
  AnimaMenu.StartValue := frm_home.Height + 20;
  AnimaMenu.StopValue := 0;
  AnimaMenu.Start;
end;

procedure Tfrm_home.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //ReleaseWakeLock(BloqueioTela);
  {$IFDEF ANDROID}
  ReleaseWakeLock;
  {$ENDIF}
end;

procedure Tfrm_home.FormCreate(Sender: TObject);
begin
  lt_menu.Visible := false;
  cont := 0;
  {$IFDEF ANDROID}
  AcquireWakeLock();
  {$ENDIF}
end;

procedure Tfrm_home.Image4Click(Sender: TObject);
begin
  circle5.AnimateFloat('Position.X',circle3.Position.X - 30,1, TAnimationType.&Out, TInterpolationType.Elastic);
  circle5.AnimateFloat('Position.X',circle3.Position.X,1, TAnimationType.&Out, TInterpolationType.Elastic);
  frm_listaIrregularidades.Show;
end;

procedure Tfrm_home.Image7Click(Sender: TObject);
begin
  circle4.AnimateFloat('Position.X',circle3.Position.X -30,1, TAnimationType.&Out, TInterpolationType.Elastic);
  circle4.AnimateFloat('Position.X',circle3.Position.X,1, TAnimationType.&Out, TInterpolationType.Elastic);
  frm_listaOcorrencias.Show;
end;

procedure Tfrm_home.btnRegistrarOcorrenciaClick(Sender: TObject);
begin
  try
    if not Assigned(frm_registroOcorrencias) then
    begin
      application.CreateForm(Tfrm_registroOcorrencias, frm_registroOcorrencias);
      frm_registroOcorrencias.Show;
    end;
    finally
      freeAndNil(frm_registroOcorrencias);
  end;
end;

procedure Tfrm_home.itemRegistrarIrregularidadeClick(Sender: TObject) ;
begin
  showmessage('Em desenvolvimento. Oxi...');
end;

procedure Tfrm_home.LocalizacaoLocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var long, lati: string;
begin
  lati  := Format('%2.6f', [localizacao.Sensor.Latitude]);
  long  := Format('%2.6f', [localizacao.Sensor.Longitude]);

  latitude  := StringReplace(lati, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  longitude := StringReplace(long, ',', '.', [rfReplaceAll, rfIgnoreCase]);
end;

procedure Tfrm_home.menuClick(Sender: TObject);
begin
  frm_validacao.memo1.Lines.Clear;
  frm_validacao.edit2.Text := '';
  close;
end;

procedure Tfrm_home.Rectangle6Click(Sender: TObject);
begin
  AnimaMenu.Inverse := true;
  AnimaMenu.Start;
  label4.AnimateFloat('RotationAngle',0,2, TAnimationType.&Out, TInterpolationType.Elastic);
end;

procedure Tfrm_home.swAccelerometerSensorActiveSwitch(Sender: TObject);
begin
  MotionSensor1.Active := swAccelerometerSensorActive.IsChecked;
  if swAccelerometerSensorActive.IsChecked = true then
  begin
    var_horafinal := Time() + StrToTime('00:30');
    timer4.enabled := true;
    label1.Visible := false;
    showMessage('Modo emergência ativo. Mantenha o app ligado para sua segurança e disparo de emergência.');
  end else
  begin
   timer4.enabled := false;
   //label1.Visible := false;
  end;

  //Variavel cont iniciando contagem regressiva do alerta
  cont := 0;
  //label1.Text := intToStr(cont);
  Timer1.Enabled := swAccelerometerSensorActive.IsChecked;
end;

procedure Tfrm_home.Text2Click(Sender: TObject);
begin
  try
    btnRegistrarOcorrencia.AnimateFloat('Position.X',-30,2, TAnimationType.&Out, TInterpolationType.Elastic);
    btnRegistrarOcorrencia.AnimateFloat('Position.X',5,2, TAnimationType.&Out, TInterpolationType.Elastic);
    finally
      frm_registroOcorrencias.Show;
  end;
end;

procedure Tfrm_home.Text4Click(Sender: TObject);
begin
  try
    itemRegistrarIrregularidade.AnimateFloat('Position.X',-30,2, TAnimationType.&Out, TInterpolationType.Elastic);
    itemRegistrarIrregularidade.AnimateFloat('Position.X',5,2, TAnimationType.&Out, TInterpolationType.Elastic);
    finally
      frm_registroIrregularidades.Show;
  end;
end;

procedure Tfrm_home.Timer1Timer(Sender: TObject);
var
  LProp: TCustomMotionSensor.TProperty;
{$IFDEF ANDROID}
var
  vibrar: JVibrator;
{$ENDIF}
var
 myThread, emergencyThread : TThread;
begin
  for LProp in MotionSensor1.Sensor.AvailableProperties do
  begin
    { get the data from the sensor }
    case LProp of
      TCustomMotionSensor.TProperty.AccelerationX:
      begin
         lbAccelerationX.Text := Format('%6.2f', [MotionSensor1.Sensor.AccelerationX]);
      end;
     end;
  end;

  if strToFloat(lbAccelerationX.Text) < -1.3 then
        begin
          cont := cont + 1;
          sleep(100);
          if cont >= 2 then
            begin
              // Handshake action thread
              myThread := TThread.CreateAnonymousThread( procedure begin
                {$IFDEF ANDROID}
                vibrar := TJVibrator.Wrap((SharedActivityContext.getSystemService(TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject) .GetObjectID);
                vibrar.vibrate (1000);
                timer1.Enabled := false;
                swAccelerometerSensorActive.IsChecked := false;
                lbAccelerationX.Text := '0';
                cont := 0;
                {$ENDIF}
              end);
              myThread.start();


              //Emergency action thread
              emergencyThread := TThread.CreateAnonymousThread( procedure begin
                {$IFDEF ANDROID}
                PermissionsService.RequestPermissions([JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION)],
                procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
                begin
                  if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
                  begin
                    { ativa o sensor }
                    localizacao.Active := True;
                    timer5.Enabled := true;
                  end
                  else
                  begin
                    ShowMessage('O SISI precisa do acesso a sua localização.');
                  end;
                end);
                {$ENDIF}
              end);
              emergencyThread.start();

            end;
        end;

end;

procedure Tfrm_home.Timer3Timer(Sender: TObject);
begin
  lbl_time.Text := timeToStr(time);
end;

procedure Tfrm_home.Timer4Timer(Sender: TObject);
begin
  lbl_tempoAlerta.text := TimeToStr(var_horafinal - Time());
  if (Time() > var_horafinal) then
  begin
    Timer4.Enabled := false;
    swAccelerometerSensorActive.IsChecked := false;
    lbAccelerationX.Text := '0';
    label1.Visible := false;
  end;
end;

procedure Tfrm_home.Timer5Timer(Sender: TObject);
var
  body, user, pass: string;
  JSONObj: TJSONValue;
begin
   if (latitude <> '') and (longitude <> '' ) then
   try
     body := '{'+
'    "latitude": '+latitude+', '+
'    "longitude": '+longitude+' '+
'    }';

      RESTRequest1.Params.Items[1].Value := body;
      RESTRequest1.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;

      RESTRequest1.Execute;
      timer5.Enabled := false;
      label1.Visible := true;//Mostra texto do envio de alerta
      close;// Fecha o app por questão de seguração do usuário
   except on e:exception do
   begin
    showMessage('Falha no cadastro. Erro 422');
    abort;
   end;
  end;

end;

procedure Tfrm_home.AnimaMenuFinish(Sender: TObject);
begin
  if AnimaMenu.Inverse = true then
    lt_menu.Visible := false;
end;

procedure Tfrm_home.btnRegistrarIrregularidadeClick(Sender: TObject) ;
begin
  showmessage('Em desenvolvimento. Oxi...');
end;

end.
