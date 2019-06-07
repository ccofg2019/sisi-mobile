unit registroIrregularidades;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
<<<<<<< HEAD
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, FMX.Ani;
=======
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation;
>>>>>>> master

type
  Tfrm_registroIrregularidades = class(TForm)
    header: TToolBar;
    Rectangle10: TRectangle;
    menu: TSpeedButton;
    title: TText;
    labelOpcoes: TLayout;
    Rectangle1: TRectangle;
    Text1: TText;
    VertScrollBox1: TVertScrollBox;
    itemPoda: TLayout;
    Rectangle5: TRectangle;
    imgPoda: TImage;
    titlePoda: TText;
    subtitlePoda: TText;
    itemAcessibilidade: TLayout;
    Rectangle2: TRectangle;
    imgAcessibilidade: TImage;
    S: TText;
    subtitleAcessibilidade: TText;
    itemOutros: TLayout;
    Rectangle7: TRectangle;
    imgOutros: TImage;
    titleOutros: TText;
    subtitleOutros: TText;
    itemControleAnimais: TLayout;
    Rectangle3: TRectangle;
    imgControleAnimais: TImage;
    titleControleAnimais: TText;
    subtitleControleAnimais: TText;
    itemPoluicao: TLayout;
    Rectangle6: TRectangle;
    imgPoluicao: TImage;
    titlePoluicao: TText;
    subtitlePoluicao: TText;
    itemIluminacaoPublica: TLayout;
    Rectangle4: TRectangle;
    imgIluminacaoPublica: TImage;
    titleIluminacaoPublica: TText;
    subtitleIluminacaoPublica: TText;
<<<<<<< HEAD
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Image1: TImage;
    procedure menuClick(Sender: TObject);
    procedure Text2Click(Sender: TObject);
    procedure Text3Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure Text5Click(Sender: TObject);
    procedure Text7Click(Sender: TObject);
    procedure Text6Click(Sender: TObject);
  private
    { Private declarations }
    procedure AnimaImg(Img: TImage);
    procedure DoFinish(Sender: TObject);
  public
    { Public declarations }
    var irregularity_type_id: string;
=======
  private
    { Private declarations }
  public
    { Public declarations }
>>>>>>> master
  end;

var
  frm_registroIrregularidades: Tfrm_registroIrregularidades;

implementation

{$R *.fmx}

<<<<<<< HEAD
uses cadastroIrregularidades;

procedure Tfrm_registroIrregularidades.AnimaImg(Img: TImage);
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


procedure Tfrm_registroIrregularidades.DoFinish(Sender: TObject);
begin
  frm_cadastroIrregularidades.show;
end;

procedure Tfrm_registroIrregularidades.menuClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_registroIrregularidades.Text2Click(Sender: TObject);
begin
  irregularity_type_id := '3';
  AnimaImg(imgAcessibilidade);
end;

procedure Tfrm_registroIrregularidades.Text3Click(Sender: TObject);
begin
  irregularity_type_id := '1';
  AnimaImg(imgControleAnimais);
end;

procedure Tfrm_registroIrregularidades.Text4Click(Sender: TObject);
begin
  irregularity_type_id := '2';
  AnimaImg(imgIluminacaoPublica);
end;

procedure Tfrm_registroIrregularidades.Text5Click(Sender: TObject);
begin
  irregularity_type_id := '4';
  AnimaImg(imgPoda);
end;

procedure Tfrm_registroIrregularidades.Text6Click(Sender: TObject);
begin
  irregularity_type_id := '5';
  AnimaImg(imgPoluicao);
end;

procedure Tfrm_registroIrregularidades.Text7Click(Sender: TObject);
begin
  irregularity_type_id := '6';
  AnimaImg(imgOutros);
end;

=======
>>>>>>> master
end.
