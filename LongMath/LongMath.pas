unit LongMath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,LMath, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit5: TEdit;
    Button2: TButton;
    RadioButton5: TRadioButton;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure RadioButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  Operate_var:Integer;

implementation

{$R *.dfm}

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Checked then
    Operate_var:=1;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  if RadioButton2.Checked then
    Operate_var:=2;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
  if RadioButton3.Checked then
    Operate_var:=3;
end;

procedure TForm1.RadioButton4Click(Sender: TObject);
begin
  if RadioButton4.Checked then
    Operate_var:=4;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  DecimalSeparator:=',';
  LMath.oper:=Operate_var;
  if Operate_var=1 then
    begin
      Edit3.Text:=ulSum(Edit1.Text,Edit2.Text);
    end;

  if Operate_var=2 then
    begin
      Edit3.Text:=ulSub(Edit1.Text,Edit2.Text);
    end;

  if Operate_var=3 then
    begin
      Edit3.Text:=ulMPL(Edit1.Text,Edit2.Text);
    end;

  if Operate_var=4 then
    begin
      Edit3.Text:=UlDiv(Edit1.Text,Edit2.Text,StrToInt(Edit4.Text));
    end;

  if Operate_var=5 then
    begin
      Edit3.Text:=IntToStr(UlComparisonStr(Edit1.Text,Edit2.Text));
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var s:string;
begin
  Edit3.Text:=UlRound(Edit3.Text,StrToInt(Edit5.Text));
//  Edit3.Text:=s;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  DecimalSeparator:=',';
  Operate_var:=0;

  if RadioButton1.Checked=True then Operate_var:=1;
  if RadioButton2.Checked=True then Operate_var:=2;
  if RadioButton3.Checked=True then Operate_var:=3;
  if RadioButton4.Checked=True then Operate_var:=4;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=13 then Button1.Click;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=13 then Button1.Click;
end;

procedure TForm1.RadioButton5Click(Sender: TObject);
begin
  if RadioButton5.Checked then
    Operate_var:=5;
end;

end.
