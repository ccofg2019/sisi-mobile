unit listaIrregularidades;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, System.JSON,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  MultiDetailAppearanceU, REST.Types, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Effects, FMX.ListView;

type
  Tfrm_listaIrregularidades = class(TForm)
    header: TToolBar;
    Rectangle10: TRectangle;
    title: TText;
    list: TVertScrollBox;
    menu: TSpeedButton;
    ListView1: TListView;
    ShadowEffect1: TShadowEffect;
    Image1: TImage;
    btn_atualizar: TSpeedButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    ShadowEffect2: TShadowEffect;
    Rectangle1: TRectangle;
    procedure menuClick(Sender: TObject);
    procedure btn_atualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_listaIrregularidades: Tfrm_listaIrregularidades;

implementation

{$R *.fmx}

uses u_validacao;

procedure Tfrm_listaIrregularidades.btn_atualizarClick(Sender: TObject);
var
  retorno: TJSONObject;
  rows: TJSONPair;
  arrayrows: TJSONArray;
  objRows: TJSONObject;
  //arrayElements: TJSONArray;
  //objElements: TJSONObject;

  obj: TJSONObject;
  data, title, story, status: string;
  i: integer;
  ListViewItem: TListViewItem;
begin
   ListView1.BeginUpdate;
   ListView1.Items.Clear;
   ListView1.EndUpdate;
   RESTRequest1.Params.ParameterByName('Authorization').Value := 'Bearer '+frm_validacao.memo1.Text;
   RESTRequest1.Execute;
   retorno        := RESTRequest1.Response.JSONValue as TJSONObject;
   rows           := retorno.Get('data');
   arrayrows      := rows.JsonValue as TJSONArray;
   if RESTResponse1.StatusText <> 'OK' then
   begin
    showMessage('Falha. Erro: '+ RESTResponse1.StatusText);
    abort;
   end else
   try
      for i := 0 to 99 do
      begin
        obj       := arrayrows.Items[i] as TJSONObject;

        title     := obj.GetValue('title').Value;
        story     := obj.GetValue('story').Value;
        //data      := obj.GetValue('irregularity_date').Value;
        status    := obj.GetValue('status').Value;

        ListViewItem   := Listview1.Items.Add;
        ListViewItem.Bitmap := image1.Bitmap;
        ListViewItem.Text := 'Titulo: '+ title;
        ListViewItem.Data[TMultiDetailAppearanceNames.Detail1] := 'Status: '+ status;
        ListViewItem.Data[TMultiDetailAppearanceNames.Detail2] := 'Descrição: '+ story;
      end;
     except on e:exception do
     begin
      //sai do laço
     end;

    end;
end;

procedure Tfrm_listaIrregularidades.FormShow(Sender: TObject);
begin
  btn_atualizarClick(self);
end;

procedure Tfrm_listaIrregularidades.menuClick(Sender: TObject);
begin
  close;
end;

end.
