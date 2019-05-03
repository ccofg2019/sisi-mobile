unit registroIrregularidades;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_registroIrregularidades: Tfrm_registroIrregularidades;

implementation

{$R *.fmx}

end.
