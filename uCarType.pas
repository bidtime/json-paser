unit uCarType;

interface

type
  TCarType=class(TObject)

public
  car_type_id: string;
  car_brand_id: string;
  car_brand_name: string;
  car_oem_id: string;
  car_oem_name: string;
  car_serie_id: string;
  car_serie_name: string;
  car_type_code: string;
  car_type_name: string;
  short_code: string;
  sale_date: string;
  //out_date: string;
  //stop_date: string;
  sug_price: string;
  year_model: string;
  engine: string;
  gear: string;
  //description: string;
  //remark: string;
  state: string;
  sort_no: string;
  create_time: string;
  modify_time: string;
  creator_id: string;
  modifier_id: string;
  raw_id: string;
  dispunit: string;
  display: string;
public
  //constructor Create(i:integer); overload;
  constructor Create; overload;
  destructor Destroy;
  class function getColumn(): string;
  function getRow(): string;
end;

implementation

uses SysUtils;

{ TCarTypeBaseInfo }

constructor TCarType.Create;
begin
  state:='1';
  sort_no:='0';
  create_time:=FormatDateTime('yyyy-mm-dd hh-nn-ss', now);
  modify_time:=create_time;
  creator_id:='0';
  modifier_id:='0';
  //
  car_oem_id := '0';
end;

destructor TCarType.Destroy;
begin

end;

class function TCarType.getColumn: string;
begin
  Result :=
  'car_type_id' + #9 +
  'car_brand_id' + #9 +
  'car_brand_name' + #9 +
  'car_oem_id' + #9 +
  'car_oem_name' + #9 +
  'car_serie_id' + #9 +
  'car_serie_name' + #9 +
  'car_type_code' + #9 +
  'car_type_name' + #9 +
  'short_code' + #9 +
  'sale_date' + #9 +
  //'out_date' + #9 +
  //'stop_date' + #9 +
  'sug_price' + #9 +
  'year_model' + #9 +
  'engine' + #9 +
  'gear' + #9 +
  //'description' + #9 +
  //'remark' + #9 +
  'state' + #9 +
  'sort_no' + #9 +
  'create_time' + #9 +
  'modify_time' + #9 +
  'creator_id' + #9 +
  'modifier_id' + #9 +
  'raw_id' + #9 +
  'dispunit' + #9 +
  'display';
end;

function TCarType.getRow: string;
begin
  Result :=
  car_type_id + #9 +
  car_brand_id + #9 +
  car_brand_name + #9 +
  car_oem_id + #9 +
  car_oem_name + #9 +
  car_serie_id + #9 +
  car_serie_name + #9 +
  car_type_code + #9 +
  car_type_name + #9 +
  short_code + #9 +
  sale_date + #9 +
  //out_date + #9 +
  //stop_date + #9 +
  sug_price + #9 +
  year_model + #9 +
  engine + #9 +
  gear + #9 +
  //description + #9 +
  //remark + #9 +
  state + #9 +
  sort_no + #9 +
  create_time + #9 +
  modify_time + #9 +
  creator_id + #9 +
  modifier_id + #9 +
  raw_id + #9 +
  dispunit + #9 +
  display;
end;

end.
