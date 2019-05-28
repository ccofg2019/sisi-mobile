unit cadastroIrregularidades;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
<<<<<<< HEAD
  FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, System.Sensors, System.Sensors.Components

   //Permissão localização
  {$IFDEF ANDROID}
  ,System.Permissions, Androidapi.Helpers, Androidapi.JNI.Os;
  {$ELSE}
  ;
  {$ENDIF}
=======
  FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation;
>>>>>>> master

type
  Tfrm_cadastroIrregularidades = class(TForm)
    header: TLayout;
    ToolBar1: TToolBar;
    Rectangle10: TRectangle;
    menu: TSpeedButton;
<<<<<<< HEAD
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
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    Localizacao: TLocationSensor;
    ed_latitude: TEdit;
    ed_longitude: TEdit;
    Timer1: TTimer;
    Image1: TImage;
    Rectangle8: TRectangle;
    Rectangle3: TRectangle;
    procedure menuClick(Sender: TObject);
    procedure Text3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure LocalizacaoLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure Timer1Timer(Sender: TObject);
=======
    cadastro: TText;
    VertScrollBox1: TVertScrollBox;
    formDescricao: TLayout;
    bgInput: TRectangle;
    inputDescricao: TEdit;
    labelDescricao: TLabel;
    formLocal: TLayout;
    Rectangle8: TRectangle;
    labelLocal: TLabel;
    inputLocal: TComboBox;
    formTipoIrregularidade: TLayout;
    Rectangle9: TRectangle;
    labelTipoIrregularidade: TLabel;
    inputTipoIrregularidade: TComboBox;
    formTitulo: TLayout;
    Rectangle1: TRectangle;
    inputTitulo: TEdit;
    labelTitulo: TLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle11: TRectangle;
    Text2: TText;
    Layout4: TLayout;
    Rectangle12: TRectangle;
    Text1: TText;
>>>>>>> master
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cadastroIrregularidades: Tfrm_cadastroIrregularidades;

implementation

{$R *.fmx}

<<<<<<< HEAD
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

  ed_latitude.Text := StringReplace(lati, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  ed_longitude.Text := StringReplace(long, ',', '.', [rfReplaceAll, rfIgnoreCase]);
end;

procedure Tfrm_cadastroIrregularidades.menuClick(Sender: TObject);
begin
 close;
end;

procedure Tfrm_cadastroIrregularidades.Text3Click(Sender: TObject);
begin
  if (edit1.Text = '') or (memo1.Lines.Text = '') or (comboBox1.ItemIndex < 0) then
  begin
    ShowMessage('Preencha todos os campos.');
    abort
  end;

  {$IFDEF ANDROID}
    PermissionsService.RequestPermissions([JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION)],
      procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
      begin
        if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
        begin
          { activa o sensor }
          localizacao.Active := True;
          timer1.Enabled := true;
          text3.Enabled := false;
        end
        else
        begin
          ShowMessage('O SISI precisa do acesso a sua localização.');
        end;
      end);
    {$ENDIF}
end;

procedure Tfrm_cadastroIrregularidades.Timer1Timer(Sender: TObject);
var
  body, user, pass, lat, long: string;
  JSONObj: TJSONValue;
begin
  if (ed_latitude.Text <> '') and (ed_longitude.Text <> '' )then
  try
    RESTClient1.ResetToDefaults;
    RESTResponse1.ResetToDefaults;
    RESTResponse1.ResetToDefaults;
     body := '{'+
'	   "title":"'+edit1.Text+'", '+
'	   "story":"'+memo1.Text+'", '+
'    "coordinates": "'+ed_latitude.Text+','+ed_longitude.Text+'", '+
'    "irregularity_type_id": '+frm_registroIrregularidades.irregularity_type_id+', '+
'    "zone_id": 1 }';

      RESTRequest1.Params.Items[1].Value := body;
      RESTRequest1.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;

      RESTRequest1.Execute;

      if RESTResponse1.StatusText = 'OK' then
      begin
        timer1.Enabled := false;
        text3.Enabled := true;
        RESTClient1.ResetToDefaults;
        RESTResponse1.ResetToDefaults;
        RESTRequest1.ResetToDefaults;
        showMessage('Irregularidade cadastrada com sucesso!');
        close;
      end;
   except on e:exception do
   begin
    timer1.Enabled := false;
    showMessage('Falha no cadastro. Erro 422');
    abort;
   end;
  end;
end;

=======
>>>>>>> master
end.
