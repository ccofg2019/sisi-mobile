unit listaOcorrencias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation;

type
  Tfrm_listaOcorrencias = class(TForm)
    header: TToolBar;
    Rectangle10: TRectangle;
    menu: TSpeedButton;
    title: TText;
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    RoundRect1: TRoundRect;
    Text4: TText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_listaOcorrencias: Tfrm_listaOcorrencias;

implementation

{$R *.fmx}

end.
