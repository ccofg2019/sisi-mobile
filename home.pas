unit home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, FMX.MultiView;

type
  Tfrm_home = class(TForm)
    header: TToolBar;
    Rectangle10: TRectangle;
    menu: TSpeedButton;
    title: TText;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Circle1: TCircle;
    Text1: TText;
    Image1: TImage;
    MultiView1: TMultiView;
    ToolBar1: TToolBar;
    Label1: TLabel;
    btnSair: TButton;
    groupRegistrar: TGridLayout;
    btnRegistrarOcorrencia: TLayout;
    btnModoEmergencia: TLayout;
    btnRegistrarIrregularidade: TLayout;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    labelOpcoes: TLayout;
    Rectangle5: TRectangle;
    Text5: TText;
    procedure btnSairClick(Sender: TObject);
    procedure btnRegistrarOcorrenciaClick(Sender: TObject);
    procedure btnModoEmergenciaClick(Sender: TObject);
    procedure btnRegistrarIrregularidadeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_home: Tfrm_home;

implementation

{$R *.fmx}

uses listaOcorrencias;

procedure Tfrm_home.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_home.btnRegistrarOcorrenciaClick(Sender: TObject);
begin
  multiView1.HideMaster;
  try
    if not Assigned(frm_listaOcorrencias) then
    begin
      application.CreateForm(Tfrm_listaOcorrencias, frm_listaOcorrencias);
      frm_listaOcorrencias.Show;
    end;
    finally
      freeAndNil(frm_listaOcorrencias);
  end;
end;

procedure Tfrm_home.btnModoEmergenciaClick(Sender: TObject) ;
begin
  multiView1.HideMaster;
  showmessage('Em desenvolvimento. Oxi...');
end;

procedure Tfrm_home.btnRegistrarIrregularidadeClick(Sender: TObject) ;
begin
  multiView1.HideMaster;
  showmessage('Em desenvolvimento. Oxi...');
end;

end.
