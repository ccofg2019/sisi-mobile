unit cadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Objects, FMX.Edit,
  FMX.ListBox;

type
  Tfrm_cadastro = class(TForm)
    header: TLayout;
    ToolBar1: TToolBar;
    menu: TSpeedButton;
    cadastro: TText;
    Rectangle10: TRectangle;
    VertScrollBox1: TVertScrollBox;
    formCel: TLayout;
    bgInput: TRectangle;
    inputCel: TEdit;
    labelCel: TLabel;
    formConfirmarSenha: TLayout;
    Rectangle4: TRectangle;
    inputConfirmarSenha: TEdit;
    labelConfirmarSenha: TLabel;
    formCpf: TLayout;
    Rectangle5: TRectangle;
    inputCpf: TEdit;
    labelCpf: TLabel;
    formDataNasc: TLayout;
    Rectangle6: TRectangle;
    inputDataNasc: TEdit;
    labelDataNasc: TLabel;
    formEmail: TLayout;
    Rectangle7: TRectangle;
    labelEmail: TLabel;
    inputEmail: TEdit;
    formEtnia: TLayout;
    Rectangle8: TRectangle;
    labelEtnia: TLabel;
    inputEtnia: TComboBox;
    formGenero: TLayout;
    Rectangle9: TRectangle;
    labelGenero: TLabel;
    inputGenero: TComboBox;
    formNome: TLayout;
    Rectangle1: TRectangle;
    inputNome: TEdit;
    labelNome: TLabel;
    formSenha: TLayout;
    Rectangle2: TRectangle;
    inputSenha: TEdit;
    labelSenha: TLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle11: TRectangle;
    Text2: TText;
    Layout4: TLayout;
    Rectangle12: TRectangle;
    Text1: TText;
    procedure menuClick(Sender: TObject);
    procedure Text1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cadastro: Tfrm_cadastro;

implementation

{$R *.fmx}

procedure Tfrm_cadastro.menuClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_cadastro.Text1Click(Sender: TObject);
begin
  showMessage('Cadastrado com xuxesso! Só que não! rsrs');
end;

end.
