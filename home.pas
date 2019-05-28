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
  Data.Bind.Components, Data.Bind.ObjectScope, FGX.ProgressDialog,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.DBScope, FMX.ScrollBox, FMX.Memo; // SharedActivity ;
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
    TrackBar1: TTrackBar;
    Label3: TLabel;
    fgActivityDialog: TfgActivityDialog;
    Memo1: TMemo;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    FDMemTable1: TFDMemTable;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1error: TWideStringField;
    FDMemTable1data: TWideStringField;
    FDMemTable1message: TWideStringField;
    BindSourceDB2: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    RESTClient3: TRESTClient;
    RESTRequest3: TRESTRequest;
    RESTResponse3: TRESTResponse;
    ShadowEffect3: TShadowEffect;
    fundoSair: TRectangle;
    dialogExit: TRectangle;
    Line1: TLine;
    Label8: TLabel;
    Rectangle1: TRectangle;
    Text1: TText;
    Rectangle5: TRectangle;
    Text5: TText;
    animaDialog: TFloatAnimation;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    timerAtualizaPosicao: TTimer;
    RESTResponse4: TRESTResponse;
    RESTRequest4: TRESTRequest;
    RESTClient4: TRESTClient;
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
    procedure TrackBar1Tracking(Sender: TObject);
    procedure Text1Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure animaDialogFinish(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure timerAtualizaPosicaoTimer(Sender: TObject);
  private
    { Private declarations }
    function TextoEntre(Texto, Delimitador1, Delimitador2: String; CaseSensitive : boolean = false): string;
    var cont: integer;
    latitude, longitude, emergency_id: string;
    FProgressDialogThread: TThread;
    FActivityDialogThread: TThread;

    FProgressDialogThread2: TThread;
    FActivityDialogThread2: TThread;

    FActivityDialogThread3: TThread;
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
  registroIrregularidades, listaIrregularidades, FMX.DialogService;


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

procedure Tfrm_home.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if key = vkHardwareBack then
  begin
    if fundoSair.Visible = true  then
    begin
      fundoSair.Visible := false;
      key := 0;
      exit;
    end;

    fundoSair.Position.Y := frm_home.Height + 60;
    fundoSair.Visible := true;
    AnimaDialog.Inverse := false;
    AnimaDialog.StartValue := frm_home.Height + 20;
    AnimaDialog.StopValue := 0;
    AnimaDialog.Start;
                     {
   TDialogService.MessageDialog(
   'Deseja realmente sair do app?',
   System.UITypes.TMsgDlgType.mtconfirmation,
   [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
   System.UITypes.TMsgDlgBtn.mbNo,0,
  procedure (const AResult: TModalResult)
  begin
    {fundoSair.Position.Y := frm_home.Height + 60;
    fundoSair.Visible := true;
    AnimaDialog.Inverse := false;
    AnimaDialog.StartValue := frm_home.Height + 20;
    AnimaDialog.StopValue := 0;
    AnimaDialog.Start;}
  {  case AResult of
     mrYes:
     begin
       Application.Terminate;
     end;
    end;
  end);   }

  key := 0;

  end;
end;

procedure Tfrm_home.Image4Click(Sender: TObject);
begin
  circle5.AnimateFloat('Position.X',circle3.Position.X - 30,1, TAnimationType.&Out, TInterpolationType.Elastic);
  circle5.AnimateFloat('Position.X',circle3.Position.X,1, TAnimationType.&Out, TInterpolationType.Elastic);

  if not fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
          fgActivityDialog.Message := 'Processando irregularidades...';
          fgActivityDialog.Show;
          end);
          Sleep(500);
          if TThread.CheckTerminated then
            Exit;

          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Processo concluído';
            frm_listaIrregularidades.Show;

          end);
          Sleep(500);
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

procedure Tfrm_home.Image7Click(Sender: TObject);
begin
  circle4.AnimateFloat('Position.X',circle3.Position.X -30,1, TAnimationType.&Out, TInterpolationType.Elastic);
  circle4.AnimateFloat('Position.X',circle3.Position.X,1, TAnimationType.&Out, TInterpolationType.Elastic);

  if not fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
          //Iniciando método de login via REST
          fgActivityDialog.Message := 'Processando ocorrências...';
          fgActivityDialog.Show;
          end);
          Sleep(500);
          if TThread.CheckTerminated then
            Exit;

          TThread.Synchronize(nil, procedure
          begin
            fgActivityDialog.Message := 'Processo concluído';
            frm_listaOcorrencias.Show;

          end);
          Sleep(500);
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
  fundoSair.Position.Y := frm_home.Height + 60;
  fundoSair.Visible := true;
  AnimaDialog.Inverse := false;
  AnimaDialog.StartValue := frm_home.Height + 20;
  AnimaDialog.StopValue := 0;
  AnimaDialog.Start;
end;

procedure Tfrm_home.Rectangle6Click(Sender: TObject);
begin
  AnimaMenu.Inverse := true;
  AnimaMenu.Start;
  label4.AnimateFloat('RotationAngle',0,2, TAnimationType.&Out, TInterpolationType.Elastic);
end;


function Tfrm_home.TextoEntre(Texto, Delimitador1,
  Delimitador2: String; CaseSensitive : boolean = false): string;
  var Inicio, Fim : Integer;
      Saida : string;
begin
  // Passar o texto para variável temporária
  Saida := Texto;
  // Verificar se é sensível ao caso
  // Pegar o início
  if CaseSensitive then
    Inicio := Pos(Delimitador1, Saida)
  else
    Inicio := Pos(ansiUpperCase(Delimitador1), ansiLowerCase(Saida));
  // Verificar se localizou
  if Inicio > 0 then
    Saida := Copy(Saida, Inicio + Length(Delimitador1), Length(Saida));

  // Pegar o fim
  if CaseSensitive then
    Fim := Pos(Delimitador2, Saida)
  else
    Fim := Pos(ansiUpperCase(Delimitador2), ansiUpperCase(Saida));

  // Verificar se localizou
  if Fim > 0 then
    Saida := Copy(Saida, 1, Fim - 1);

  // retornar o resultado
  Result := Saida;
end;


procedure Tfrm_home.swAccelerometerSensorActiveSwitch(Sender: TObject);
var
  body: string;
var
  retorno: TJSONObject;
  prows: TJSONPair;
  arrayr: TJSONArray;
  objRows: TJSONObject;
  arraye: TJSONArray;
  oElementos: TJSONObject;

  orows: TJSONObject;
  sId, title, story, status, NovaString: string;
  i, iId: integer;
  oId: TJSONObject;

  var
  sPos, sPos2: Integer;
begin
  MotionSensor1.Active := swAccelerometerSensorActive.IsChecked;
  if swAccelerometerSensorActive.IsChecked = true then
  begin
    var_horafinal := Time() + StrToTime('00:'+label3.Text);
    timer4.enabled := true;
    timerAtualizaPosicao.Enabled := true;
    label1.Visible := false;

     if not fgActivityDialog.IsShown then
      begin
      FActivityDialogThread := TThread.CreateAnonymousThread(procedure
        begin
          try
            TThread.Synchronize(nil, procedure
            begin
              fgActivityDialog.Message := 'Verificando GPS...';
              fgActivityDialog.Show;
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
          '    "latitude": '+latitude+', '+
          '    "longitude": '+longitude+' '+
          '    }';

                RESTRequest2.Params.Items[1].Value := body;
                RESTRequest2.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;

                RESTRequest2.Execute;

                sPos  :=  Pos(':', memo1.Text);

                //Função para extrair o emergency_id
                emergency_id := TextoEntre(copy(memo1.Text, sPos + 1, 30), '{"id":', ',"status"');

                //Tratamento de possíveis erros...falta implementar
                if RESTResponse2.StatusText = 'OK' then
                begin
                //tratamento de erros...
                end;
                except on e:exception do
                begin
                  showMessage('Falha de envio. Erro 422');
                  exit;
                end;
              end;

            end);
          //Sleep(1000);

          finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              fgActivityDialog.Hide;
              showMessage('Modo de emergência ativado. Mantenha o app ligado para sua segurança e disparo de emergência.');
            end);
          end;
      end);
      FActivityDialogThread.FreeOnTerminate := False;
      FActivityDialogThread.Start;
    end;

  end else
  begin
    if not fgActivityDialog.IsShown then
      begin
        FActivityDialogThread := TThread.CreateAnonymousThread(procedure
        begin
          try
            TThread.Synchronize(nil, procedure
            begin
              fgActivityDialog.Message := 'Aguarde...';
              localizacao.Active := false;
              fgActivityDialog.Show;
              lbl_tempoAlerta.Text := '00:00:00';
              //var_horafinal := Time() + StrToTime('00:'+label3.Text);
              timer4.enabled := false;
              timerAtualizaPosicao.Enabled := false;
              label1.Visible := false;
            end);

            //Sleep(1000);
            if TThread.CheckTerminated then
              Exit;

            TThread.Synchronize(nil, procedure
            begin
              fgActivityDialog.Message := 'Finalizando modo emergência..';

              //if (latitude <> '') and (longitude <> '' ) then
              try
                body := '{'+
                '    "emergency_id": '+emergency_id+', '+
                '    "status": "FINALIZADO" }';

                RESTRequest4.Params.Items[1].Value := body;
                RESTRequest4.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;

                RESTRequest4.Execute;

                //sPos  :=  Pos(':', memo1.Text);

                //Função para extrair o emergency_id
                //emergency_id := TextoEntre(copy(memo1.Text, sPos + 1, 30), '{"id":', ',"status"');

                //Tratamento de possíveis erros...falta implementar
                if RESTResponse4.StatusText = 'OK' then
                begin
                 // timer1.Enabled := false;
                  //text1.Enabled := true;
                  //showMessage('Ocorrência cadastrada com sucesso!');
                 // close;
                end;
                except on e:exception do
                begin
                  showMessage('Falha de envio. Erro 422');
                  abort;
                end;
              end;

            end);
          Sleep(1000);

          finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              fgActivityDialog.Hide;
              showMessage('Modo de emergência desativado.');
            end);
          end;
      end);
      FActivityDialogThread.FreeOnTerminate := False;
      FActivityDialogThread.Start;
    end;

  end;
  cont := 0;
  Timer1.Enabled := swAccelerometerSensorActive.IsChecked;
end;

procedure Tfrm_home.Text1Click(Sender: TObject);
begin
  fundoSair.Visible := false;
  dialogExit.Visible := false;
  frm_validacao.memo1.Lines.Clear;
  frm_validacao.edit2.Text := '';
  close;
end;

procedure Tfrm_home.Text2Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
      TThread.Synchronize(nil, procedure
        begin
          btnRegistrarOcorrencia.AnimateFloat('Position.X',-30,2, TAnimationType.&Out, TInterpolationType.Elastic);
          btnRegistrarOcorrencia.AnimateFloat('Position.X',5,2, TAnimationType.&Out, TInterpolationType.Elastic);
        end);
      Sleep(1000);
      if TThread.CheckTerminated then
        Exit;

      TThread.Synchronize(nil, procedure
        begin
          Sleep(1000);
          frm_registroOcorrencias.Show;
        end);
      Sleep(500);
      if TThread.CheckTerminated then
        Exit;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_home.Text4Click(Sender: TObject);
begin
  FActivityDialogThread := TThread.CreateAnonymousThread(procedure
    begin
        try
          TThread.Synchronize(nil, procedure
          begin
            itemRegistrarIrregularidade.AnimateFloat('Position.X',-30,2, TAnimationType.&Out, TInterpolationType.Elastic);
            itemRegistrarIrregularidade.AnimateFloat('Position.X',5,2, TAnimationType.&Out, TInterpolationType.Elastic);
          end);
          Sleep(1000);
          if TThread.CheckTerminated then
            Exit;


          TThread.Synchronize(nil, procedure
          begin
            frm_registroIrregularidades.Show;
          end);
          Sleep(500);
          if TThread.CheckTerminated then
            Exit;

        finally

        end;
    end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
end;

procedure Tfrm_home.Text5Click(Sender: TObject);
begin
  dialogExit.Visible  := false;
  AnimaDialog.Inverse := true;
  AnimaDialog.Start;
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
var
  body: string;
begin
  lbl_tempoAlerta.text := TimeToStr(var_horafinal - Time());
  if (Time() > var_horafinal) then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
        begin
          try
            TThread.Synchronize(nil, procedure
            begin
              //if (latitude <> '') and (longitude <> '' ) then
              try
                body := '{'+
                '    "emergency_id": '+emergency_id+', '+
                '    "status": "FINALIZADO" }';

                RESTRequest4.Params.Items[1].Value := body;
                RESTRequest4.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;

                RESTRequest4.Execute;

                //Tratamento de possíveis erros...falta implementar
                if RESTResponse4.StatusText = 'OK' then
                begin
                 // timer1.Enabled := false;
                  //text1.Enabled := true;
                  //showMessage('Ocorrência cadastrada com sucesso!');
                 // close;
                end;
                except on e:exception do
                begin
                  showMessage('Falha. Erro 422');
                  abort;
                end;
              end;

            end);
          Sleep(1000);

          finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              //fgActivityDialog.Hide;
              //showMessage('Modo de emergência desativado.');
            end);
          end;
      end);
      FActivityDialogThread.FreeOnTerminate := False;
      FActivityDialogThread.Start;

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
    '    "emergency_id": '+emergency_id+', '+
    '    "status": "PERIGO" }';

      RESTRequest1.Params.Items[1].Value := body;
      RESTRequest1.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;

      RESTRequest1.Execute;
      timer5.Enabled := false;
      timerAtualizaPosicao.Enabled := false;
      label1.Visible := true;//Mostra texto do envio de alerta
      close;// Fecha o app por questão de seguração do usuário
   except on e:exception do
   begin
    showMessage('Falha no envio. Erro 422');
    exit;
   end;
  end;

end;

procedure Tfrm_home.timerAtualizaPosicaoTimer(Sender: TObject);
var
  body: string;
begin
  FActivityDialogThread3 := TThread.CreateAnonymousThread(procedure
        begin
          try
            TThread.Synchronize(nil, procedure
            begin
              if (lbl_tempoAlerta.Text <> '00:00:00') then
              try
                body := '{'+
                '    "emergency_id": '+emergency_id+', '+
                '    "latitude": '+latitude+', '+
                '    "longitude": '+longitude+' '+
                '    }';

                RESTRequest3.Params.Items[1].Value := body;
                RESTRequest3.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;

                RESTRequest3.Execute;

                //Tratamento de possíveis erros...falta implementar
                if RESTResponse3.StatusText = 'OK' then
                begin
                 // timer1.Enabled := false;
                  //text1.Enabled := true;
                  //showMessage('Ocorrência cadastrada com sucesso!');
                 // close;
                end;
                except on e:exception do
                begin
                  //showMessage('Falha no cadastro. Erro 422');
                  abort;
                end;
              end;

            end);

          finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              //fgActivityDialog.Hide;
              //showMessage('Enviado.');
            end);
          end;
      end);
      FActivityDialogThread3.FreeOnTerminate := False;
      FActivityDialogThread3.Start;
end;

procedure Tfrm_home.TrackBar1Tracking(Sender: TObject);
begin
  label3.Text := formatFloat('0#',TrackBar1.Value);
end;

procedure Tfrm_home.animaDialogFinish(Sender: TObject);
begin
  if AnimaDialog.Inverse = true then
  begin
    fundoSair.Visible := false;
  end else
  begin
    dialogExit.Visible  := true;
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
