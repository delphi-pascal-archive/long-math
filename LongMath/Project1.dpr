program Project1;

uses
  Forms,
  LongMath in 'LongMath.pas' {Form1},
  LMath in '..\..\ViAl2.0\LMath.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
