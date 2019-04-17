unit listaOcorrencias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts;

type
  Tfrm_listaOcorrencias = class(TForm)
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
    procedure menuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_listaOcorrencias: Tfrm_listaOcorrencias;

implementation

{$R *.fmx}

procedure Tfrm_listaOcorrencias.menuClick(Sender: TObject);
begin
  close;
end;

end.
