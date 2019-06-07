unit registroOcorrencias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, FMX.Ani, FMX.Effects;

type
  Tfrm_registroOcorrencias = class(TForm)
    header: TToolBar;
    Rectangle10: TRectangle;
    menu: TSpeedButton;
    title: TText;
    labelOpcoes: TLayout;
    Rectangle1: TRectangle;
    Text1: TText;
    VertScrollBox1: TVertScrollBox;
    itemArrastao: TLayout;
    Rectangle5: TRectangle;
    imgArrastao: TImage;
    titleArrastao: TText;
    subtitleArrastao: TText;
    itemFurto: TLayout;
    Rectangle2: TRectangle;
    imgFurto: TImage;
    titleFurto: TText;
    subtitleFurto: TText;
    itemRoubo: TLayout;
    Rectangle7: TRectangle;
    imgRoubo: TImage;
    titleRoubo: TText;
    subtitleRoubo: TText;
    itemRouboVeiculo: TLayout;
    Rectangle3: TRectangle;
    imgRouboVeiculo: TImage;
    titleRouboVeiculo: TText;
    subtitleRouboVeiculo: TText;
    itemSequestro: TLayout;
    Rectangle8: TRectangle;
    titleSequestro: TText;
    subtitleSequestro: TText;
    itemTentativaAssalto: TLayout;
    Rectangle6: TRectangle;
    imgTentativaAssalto: TImage;
    titleTentativaAssalto: TText;
    subtitleTentativaAssalto: TText;
    itemViolenciaMulher: TLayout;
    Rectangle4: TRectangle;
    imgViolenciaMulher: TImage;
    titleViolenciaMulher: TText;
    subtitleViolenciaMulher: TText;
    imgSequestro: TImage;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Text8: TText;
    Image1: TImage;
    ShadowEffect1: TShadowEffect;
    procedure menuClick(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure Text3Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure Text6Click(Sender: TObject);
    procedure Text7Click(Sender: TObject);
    procedure Text8Click(Sender: TObject);
  private
    { Private declarations }
    procedure AnimaImg(Img: TImage);
    procedure DoFinish(Sender: TObject);
  public
    { Public declarations }
    var occurrence_type_id: string;
  end;

var
  frm_registroOcorrencias: Tfrm_registroOcorrencias;

implementation

{$R *.fmx}

uses u_registraOcorrencia;

procedure Tfrm_registroOcorrencias.DoFinish(Sender: TObject);
begin
  frm_registraOcorrencia.show;
end;


procedure Tfrm_registroOcorrencias.AnimaImg(Img: TImage);
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
    objImg.StopValue := 17;
    objImg.Interpolation := TInterpolationType.Elastic;
    objImg.OnFinish := DoFinish;
    objImg.Start;
  finally
    objImg.Free;
  end;
end;

procedure Tfrm_registroOcorrencias.menuClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_registroOcorrencias.Text2Click(Sender: TObject);
begin
  occurrence_type_id := '1';
  AnimaImg(ImgFurto);
end;

procedure Tfrm_registroOcorrencias.Text3Click(Sender: TObject);
begin
  occurrence_type_id := '6';
  AnimaImg(imgRouboVeiculo);
end;

procedure Tfrm_registroOcorrencias.Text4Click(Sender: TObject);
begin
  AnimaImg(imgViolenciaMulher);
  occurrence_type_id := '9';
end;

procedure Tfrm_registroOcorrencias.Text5Click(Sender: TObject);
begin
  occurrence_type_id := '7';
  AnimaImg(imgArrastao);
end;

procedure Tfrm_registroOcorrencias.Text6Click(Sender: TObject);
begin
  occurrence_type_id := '8';
  AnimaImg(imgTentativaAssalto);
end;

procedure Tfrm_registroOcorrencias.Text7Click(Sender: TObject);
begin
  occurrence_type_id := '2';
  AnimaImg(imgRoubo);
end;

procedure Tfrm_registroOcorrencias.Text8Click(Sender: TObject);
begin
  occurrence_type_id := '4';
  AnimaImg(imgSequestro);
end;

end.
