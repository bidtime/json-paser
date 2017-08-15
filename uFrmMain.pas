unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    Button1: TButton;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Memo2: TMemo;
    Button2: TButton;
    ToolButton1: TToolButton;
    Memo3: TMemo;
    Splitter2: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses System.json, uCarType;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
  procedure doCarParam(const S: string; strs: TStrings; var carType: TCarType);
    procedure doParamTypeItems(JsonResult: TJSONObject; strs: TStrings);
    var
      typeItem: TJSONObject;
      paramTypeItems: TJSONArray;
      I: Integer;
      car_param_type_name: string;
      car_type_id, sort_no,
      create_time, modify_time, creator_id, modifier_id: string;

      procedure doParamItems_CarType(const itemName: string;
        const k, v: string);
      begin
        if itemName.Equals('基本参数') then begin
          if k.Equals('厂商指导价(元)') then begin
            carType.sug_price := v;
          end else if k.Equals('级别') then begin
          end else if k.Equals('上市时间') then begin
            carType.sale_date := v+'.1';
            carType.sale_date := carType.sale_date.Replace('.', '-');
          //end else if k.Equals('发动机') then begin
          //  carType.engine := v;
          //end else if k.Equals('变速箱') then begin
          //  carType.gear := v;
          end else if k.Equals('车身结构') then begin
          end else if k.Equals('整车质保') then begin
          end;
        end else if itemName.Equals('车身') then begin
          if k.Equals('车身结构') then begin
          end;
        end else if itemName.Equals('发动机') then begin
          if k.Equals('发动机型号') then begin
            carType.engine := v;
          end else if k.Equals('排量(L)') then begin
            carType.display := v;
          end else if k.Equals('进气形式') then begin
            if v.Contains('涡轮增压') then begin
              carType.dispunit := 'T';
            end;
          end;
        end else if itemName.Equals('变速箱') then begin
          //if k.Equals('简称') then begin
          //end else
          if k.Equals('变速箱类型') then begin
            carType.gear := v;
          end;
        end;
      end;

      procedure doParamItems(const car_param_type_name: string;
        paramItems: TJSONArray; strs: TStrings);
      var
        I: Integer;
        item: TJSONObject;
        car_param_id, car_param_name, car_param_value: string;
      begin
        for I := 0 to paramItems.Count-1 do begin
          item := paramItems.Items[I] as TJSONObject;
          //
          car_param_id:= IntToStr(strs.Count);
          car_param_name := item.GetValue<String>('name');
          car_param_value := item.GetValue<String>('value');
          //
          strs.Add(//'no' + #9 +
            car_param_id + #9 +
            car_type_id + #9 +
            //'car_param_type_id' + #9 +
            car_param_type_name + #9 +
            car_param_name + #9 +
            car_param_value + #9 +
            sort_no + #9 +
            create_time + #9 +
            modify_time + #9 +
            creator_id + #9 +
            modifier_id);
          //
          doParamItems_CarType(car_param_type_name, car_param_name, car_param_value);
        end;
      end;
    begin
      if strs.Count <= 0 then begin
        strs.Add(//'no' + #9 +
          'car_param_id' + #9 +
          'car_type_id' + #9 +
          //'car_param_type_id' + #9 +
          'car_param_type_name' + #9 +
          'car_param_name' + #9 +
          'car_param_value' + #9 +
          'sort_no' + #9 +
          'create_time' + #9 +
          'modify_time' + #9 +
          'creator_id' + #9 +
          'modifier_id');
      end;
      //
      car_type_id := '1';
      sort_no := '0';
      create_time := FormatDateTime('yyyy-mm-dd hh-nn-ss', now);
      modify_time := create_time;
      creator_id := '0';
      modifier_id := '0';
      //
      paramTypeItems := JsonResult.GetValue('paramtypeitems') as TJSONArray;
      for I := 0 to paramTypeItems.Count-1 do begin
        typeItem := paramTypeItems.Items[I] as TJSONObject;
        car_param_type_name := typeItem.GetValue<String>('name');
        //strs.Add(car_param_type_name);
        doParamItems(car_param_type_name, typeItem.GetValue<TJSONArray>('paramitems'), strs);
      end;
    end;

  var
    JsonRoot, JsonResult: TJSONObject;
  begin
    JsonRoot := TJSONObject.ParseJSONValue(S) as TJSONObject ;
    try
      JsonResult := JsonRoot.GetValue('result') as TJsonObject;
      doParamTypeItems(JsonResult, strs);
    finally
      JsonRoot.Free;
    end;
  end;
var carType: TCarType;
begin
  carType := TCarType.Create;
  try
    Memo2.Lines.Clear;
    doCarParam(memo1.Text, Memo2.Lines, carType);
  finally
    carType.Free;
  end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);

  procedure doCarConfig(const S: string; strs: TStrings);

    procedure doConfigTypeItems(JsonResult: TJSONObject; strs: TStrings);
    var
      typeItem: TJSONObject;
      paramTypeItems: TJSONArray;
      I: Integer;
      car_cfg_type_name: string;
      car_type_id, sort_no,
      create_time, modify_time, creator_id, modifier_id: string;

      procedure doConfigItems(const car_cfg_type_name: string;
        paramItems: TJSONArray; strs: TStrings);
      var
        I: Integer;
        item: TJSONObject;
        car_cfg_id, car_cfg_name, car_cfg_value: string;
      begin
        for I := 0 to paramItems.Count-1 do begin
          item := paramItems.Items[I] as TJSONObject;
          //
          car_cfg_id:= IntToStr(strs.Count);
          car_cfg_name := item.GetValue<String>('name');
          car_cfg_value := item.GetValue<String>('value');
          //
          strs.Add(//'no' + #9 +
            car_cfg_id + #9 +
            car_type_id + #9 +
            //'car_param_type_id' + #9 +
            car_cfg_type_name + #9 +
            car_cfg_name + #9 +
            car_cfg_value + #9 +
            sort_no + #9 +
            create_time + #9 +
            modify_time + #9 +
            creator_id + #9 +
            modifier_id);
        end;
      end;

    begin
      if strs.Count <= 0 then begin
        strs.Add(//'no' + #9 +
          'car_cfg_id' + #9 +
          'car_type_id' + #9 +
          //'car_param_type_id' + #9 +
          'car_cfg_type_name' + #9 +
          'car_cfg_name' + #9 +
          'car_cfg_value' + #9 +
          'sort_no' + #9 +
          'create_time' + #9 +
          'modify_time' + #9 +
          'creator_id' + #9 +
          'modifier_id');
      end;
      //
      car_type_id := '1';
      sort_no := '0';
      create_time := FormatDateTime('yyyy-mm-dd hh-nn-ss', now);
      modify_time := create_time;
      creator_id := '0';
      modifier_id := '0';
      //
      paramTypeItems := JsonResult.GetValue('configtypeitems') as TJSONArray;
      for I := 0 to paramTypeItems.Count-1 do begin
        typeItem := paramTypeItems.Items[I] as TJSONObject;
        car_cfg_type_name := typeItem.GetValue<String>('name');
        //strs.Add(car_cfg_type_name);
        doConfigItems(car_cfg_type_name, typeItem.GetValue<TJSONArray>('configitems'), strs);
      end;
    end;

  var
    JsonRoot, JsonResult: TJSONObject;
  begin
    JsonRoot := TJSONObject.ParseJSONValue(S) as TJSONObject ;
    try
      JsonResult := JsonRoot.GetValue('result') as TJsonObject;
      doConfigTypeItems(JsonResult, strs);
    finally
      JsonRoot.Free;
    end;
  end;
begin
  Memo2.Lines.Clear;
  doCarConfig(memo3.Text, Memo2.Lines);
end;

end.
