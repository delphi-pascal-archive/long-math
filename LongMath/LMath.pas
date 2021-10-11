unit LMath;

interface

type
  TProgress = procedure(Done: real);

function ulFact(First: string): string;
function ulSum(a1, a2: string): string; {+}
function ulSub(a1, a2: string): string; {-}
function ulMPL(First, Second: string): string; {*}
function ulPower(First, Second: string): string;
function UlDiv(First, Second: string; Precision: integer): string; {/}
function UlRound(IshStr: string; DigNum: integer): string;
function UlComparisonStr(a1,a2:string):Integer; {—равнение первого со вторым числом}

var
  OnProgress: TProgress;
  oper:Integer;

implementation

uses SysUtils;

type
  TMathArray = array of integer;

type
  TNumber = record
    int, frac: TMathArray;
    sign: boolean;
  end;

var
  n1, n2: TNumber;
  minus:integer;

//  m1,m2:TNumber;

procedure StrToNum(s:string; var n:TNumber);
var j,i,l:integer;
begin
  SetLength(n.int,0);
  SetLength(n.frac,0);

  l:=Length(s);
  j:=pos(DecimalSeparator,s);

  if j>0 then
    begin
      SetLength(n.int,j-1);

      for i:=1 to (j-1) do
        n.int[i-1]:=StrToInt(s[i]);

      SetLength(n.frac,l-j);
      for i:=1 to (l-j) do
        n.frac[i-1]:=StrToInt(s[j+i]);

       n.sign:=True;
    end
  else
    begin
      SetLength(n.int,l);

      for i:=1 to (l) do
        n.int[i-1]:=StrToInt(s[i]);
    end;
end;

procedure Alligment(var n1,n2:TNumber);
var i,i1,i2:Integer;
begin
  i1:=Length(n1.int);
  i2:=Length(n2.int);

  if i2>i1 then {¬ыполнить расширение разр€дов целой части первого числа, если второе длинее}
    begin
      SetLength(n1.int,i1+(i2-i1));

      if i1>0 then
      for i:=i1-1 downto 0 do
        begin
          n1.int[i2-i1+i]:=n1.int[i]; {ѕеремещение всех чисел на количество позиций равное количиству добавленной розр€дности}
          n1.int[i]:=0;
        end;
    end;

  if i1>i2 then  {¬ыполнить расширение разр€дов целой части второго числа, если певрое длинее}
    begin
      SetLength(n2.int,i2+(i1-i2));

      if i2>0 then
      for i:=i2-1 downto 0 do
        begin
          n2.int[i1-i2+i]:=n2.int[i];
          n2.int[i]:=0;
        end;
    end;

  i1:=Length(n1.frac);
  i2:=Length(n2.frac);

  if i2>i1 then SetLength(n1.frac,i1+(i2-i1)); {¬ыполнить расширение разр€дов целой части первого числа, если второе длинее}
  if i1>i2 then SetLength(n2.frac,i2+(i1-i2)); {¬ыполнить расширение разр€дов целой части второго числа, если певрое длинее}
end;

function normaliz(First,Second:string; Precision: integer):string;
var i,i1,i2,j1,j2:Integer;
    s,s2:string;
begin
  s:=First;
  i1:=Length(s);
  j1:=pos(DecimalSeparator, s);

  i2:=Length(Second);
  j2:=pos(DecimalSeparator, Second);
  s2:=Second;

  if j1=0 then
    begin
      s:=s+DecimalSeparator;
      i1:=Length(s);
      j1:=pos(DecimalSeparator, s);
    end;
    
  if (i1-j1)<(i2-j2) then
    begin
      if j1=0 then s:=s+DecimalSeparator;
      for i:=1 to ((i2-j2)-(i1-j1)) do
           s:=s+'0';
    end;
  Result:=s;
end;

function UlComparison(var n1,n2:TNumber):Integer; {—равнение первого со вторым числом}
var i,i1,i2,x:integer;
begin
  i1:=Length(n1.int);
  i2:=Length(n2.frac);

  Result:=0;
  for i:=0 to i1-1 do
    begin
      if (Result<>2) and (n1.int[i]>n2.int[i]) then
        Result:=1;
      if (Result<>1) and (n1.int[i]<n2.int[i]) then
        Result:=2;
    end;

  If Result=0 then
    for i:=0 to i2-1 do
      begin
        if (Result<>2) and (n1.frac[i]>n2.frac[i]) then
          Result:=1;
        if (Result<>1) and (n1.frac[i]<n2.frac[i]) then
          Result:=2;
      end;
end;

function UlComparisonStr(a1,a2:string):Integer; {—равнение первого со вторым числом}
var i,i1,i2,x,tipe:integer;
begin
  Result:=0; tipe:=0;

  if (a1[1]='-') and (a2[1]<>'-') then Result:=2
  else
    if (a1[1]='') and (a2[1]='-') then Result:=1
    else
      if ((a1[1]='-') and (a2[1]='-')) or ((a1[1]<>'-') and (a2[1]<>'-'))then
        begin
          if ((a1[1]='-') and (a2[1]='-')) then
            begin
              tipe:=1;
              a1[1]:='0';
              a2[1]:='0';
            end;


          StrToNum(a1,n1);
          StrToNum(a2,n2);

          Alligment(n1,n2);

          i1:=Length(n1.int);
          i2:=Length(n2.frac);

          a1:='';
          a2:='';

          for i:=1 to i1 do
            begin
              a1:=a1+IntToStr(n1.int[i-1]);
              a2:=a2+IntToStr(n2.int[i-1]);
            end;

          if i2>0 then
            begin
              a1:=a1+DecimalSeparator;
              a2:=a2+DecimalSeparator;
            end;

          for i:=1 to i2 do
            begin
              a1:=a1+IntToStr(n1.frac[i-1]);
              a2:=a2+IntToStr(n2.frac[i-1]);
            end;

          i1:=Length(a1);

          if Result=0 then
            for i:=0 to i1-1 do
              begin
                if (Result<>2) and (a1[i]>a2[i]) then
                  Result:=1;
                if (Result<>1) and (a1[i]<a2[i]) then
                  Result:=2;
              end;

          if (tipe=1) and (Result=1) then Result:=2;
          if (tipe=1) and (Result=2) then Result:=1;
        end;
end;

function CutZirow(var n:TNumber):string;
var i,j,i1,i2:Integer;
begin
      i1:=Length(n1.int);
      i2:=Length(n1.frac);

      i:=0;
      for j:=1 to i1 do
        if (i1>=1) then
          begin
            if (n.int[j-1]<>0) then
              i:=1;

            if (i=1) or ((i=0) and (i1=j))then
              Result:=Result+IntToStr(n.int[j-1]);
          end;

      if i2>0 then Result:=Result+DecimalSeparator;

      for j:=1 to i2 do
        Result:=Result+IntToStr(n.frac[j-1]);
end;

procedure Str2Number(s: string; var n: TNumber);
var
  i, j, l: integer;
begin
  if s = '' then
  begin
    setlength(n.int, 0);
    setlength(n.frac, 0);
    exit;
  end;
  l := length(s);
  if s[1] = '-' then
  begin
    s := copy(s, 2, l);
    l := l - 1;
    n.sign := false;
  end
  else
    n.sign := true;
  j := pos(DecimalSeparator, s);
  if j > 0 then
  begin
    setlength(n.int, j - 1);
    for i := 1 to j - 1 do
      n.int[i - 1] := strtoint(s[j - i]);
    setlength(n.frac, l - j);
    for i := 1 to l - j do
      n.frac[i - 1] := strtoint(s[l - i + 1]);
  end
  else
  begin
    setlength(n.int, l);
    for i := 1 to l do
      n.int[i - 1] := strtoint(s[l - i + 1]);
    setlength(n.frac, 0);
  end;
end;

function Num2Array(var n: TNumber; var a: TMathArray): integer;
var
  i: integer;
begin
  result := length(n.frac);
  setlength(a, length(n.int) + result);
  for i := 0 to length(a) - 1 do
    if i < result then
      a[i] := n.frac[i]
    else
      a[i] := n.int[i - result];
end;

procedure MultiplyArray(var a1, a2, a: TMathArray);
var
  i, j: integer;
  b: boolean;
begin
  {checking for zero, 1}
  for i := length(a2) - 1 downto 0 do
  begin
    for j := length(a1) - 1 downto 0 do
    begin
      a[j + i] := a[j + i] + (a2[i] * a1[j]);
    end;
  end;
  repeat
    b := true;
    for i := 0 to length(a) - 1 do
      if a[i] > 9 then
      begin
        b := false;
        try
          a[i + 1] := a[i + 1] + 1;
        except
          setlength(a, length(a) + 1);
          a[i + 1] := a[i + 1] + 1;
        end;
        a[i] := a[i] - 10;
      end;
  until b;
end;

procedure Array2Num(var n: TNumber; var a: TMathArray; frac: integer; sign:
  boolean);
var
  i: integer;
begin
  setlength(n.frac, frac);
  setlength(n.int, length(a) - frac);
  for i := 0 to length(a) - 1 do
  begin
    if i < frac then
      n.frac[i] := a[i]
    else
      n.int[i - frac] := a[i];
  end;
  n.sign := sign;
end;

function Number2Str(var n: TNumber): string;
var
  i: integer;
  s: string;
begin
  result := '';
  for i := 0 to high(n.int) do
    result := inttostr(n.int[i]) + result;

  while (Length(Result)>1) and (Result[1]='0') do
    delete(result, 1, 1); 


  if length(n.frac) <> 0 then
  begin
    for i := 0 to high(n.frac) do
      s := inttostr(n.frac[i]) + s;
    result := result + DecimalSeparator + s;
  end;
{  while (length(result) > 1) and (result[1] = '0') do
    delete(result, 1, 1);   }
  if pos(DecimalSeparator, result) > 0 then
    while (length(result) > 1) and (result[length(result)] = '0') do
      delete(result, length(result), 1);
  if (result[length(result)] = DecimalSeparator) then
      delete(result, length(result), 1);
  if not n.sign then
    result := '-' + result;

  if minus=1 then
    result := '-' + result;

  setlength(n.int, 0);
  setlength(n.frac, 0);
end;

procedure DisposeNumber(var n: TNumber);
begin
  setlength(n.int, 0);
  setlength(n.frac, 0);
end;

function ulFact(First: string): string;
var
  n1, n2: TNumber;
  i: integer;
  a, a1, a2: TMathArray;
  max: integer;
begin
  Str2Number('1', n1);
  Str2Number('1', n2);
  Num2Array(n1, a1);
  Num2Array(n2, a2);
  max := strtoint(First);
  for i := 1 to strtoint(First) do
  begin
    if Assigned(OnProgress) then
      OnProgress((i / max) * 100);
    setlength(a, length(a1) + length(a2) + 1);
    MultiplyArray(a1, a2, a);
    setlength(a1, 0);
    setlength(a2, 0);
    a1 := a;
    Str2Number(inttostr(i), n2);
    Num2Array(n2, a2);
  end;
  Array2Num(n1, a1, 0, true);
  result := Number2Str(n1);
  DisposeNumber(n1);
end;

function ulPower(First, Second: string): string;
var
  i, j, c: integer;
  a, a1, a2: TMathArray;
var
  n1: TNumber;
  max: integer;
begin
minus:=0;
  j := strtoint(Second);
  if j = 0 then
  begin
    result := '1';
    exit;
  end
  else if j = 1 then
  begin
    result := First;
    exit;
  end;

  max := j - 1;
  Str2Number(First, n1);
  c := Num2Array(n1, a1);
  setlength(a, 0);
  setlength(a2, 0);
  a2 := a1;
  for i := 1 to j - 1 do
  begin
    if Assigned(OnProgress) then
      OnProgress((i / max) * 100);
    setlength(a, 0);
    setlength(a, length(a1) + length(a2) + 1);
    MultiplyArray(a1, a2, a);
    setlength(a2, 0);
    a2 := a;
  end;
  setlength(a1, 0);
  setlength(a2, 0);
  c := c * j;
  if n1.sign then
    Array2Num(n1, a, c, true)
  else if odd(j) then
    Array2Num(n1, a, c, false)
  else
    Array2Num(n1, a, c, true);
  setlength(a, 0);
  result := Number2Str(n1);
  DisposeNumber(n1);
end;

procedure MultiplyNumbers(var n1, n2: TNumber);
var
  i: integer;
  a, a1, a2: TMathArray;
begin
  i := Num2Array(n1, a1) + Num2Array(n2, a2);
  setlength(a, length(a1) + length(a2) + 1);
  MultiplyArray(a1, a2, a);
  setlength(a1, 0);
  setlength(a2, 0);
  Array2Num(n1, a, i, n1.sign = n2.sign);
  DisposeNumber(n2);
  setlength(a, 0);
end;

function ulMPL(First, Second: string): string;
var
  n1, n2: TNumber;
  ss:string;
begin
minus:=0;
  First:=normaliz(First, Second,-1);
  Second:=normaliz(Second,First,-1);

  Str2Number(First, n1);
  Str2Number(Second, n2);
  MultiplyNumbers(n1, n2);
  result := Number2Str(n1);
  ss:=result;
  DisposeNumber(n1);
end;

procedure AlignNumbers(var n1, n2: TNumber);
var
  i1, i2, i: integer;
begin
  i1 := length(n1.int);
  i2 := length(n2.int);
  if i1 > i2 then
    setlength(n2.int, i1);
  if i2 > i1 then
    setlength(n1.int, i2);

  i1 := length(n1.frac);
  i2 := length(n2.frac);


  if i1 > i2 then
  begin
    setlength(n2.frac, i1);
    for i := i1 - 1 downto 0 do
    begin
      if i - (i1 - i2) > 0 then
        n2.frac[i] := n2.frac[i - (i1 - i2)]
      else
        n2.frac[i] := 0;
    end;
  end;
  if i2 > i1 then
  begin
    setlength(n1.frac, i2);
    for i := i2 - i1 downto 0 do
    begin
      if i - (i2 - i1) >= 0 then
        n1.frac[i] := n1.frac[i - (i2 - i1)]
      else
        n1.frac[i] := 0;
    end;
  end;
end;

function SubInteger(a1, a2: TMathArray): integer;
var
  i: integer;
  b: boolean;
begin
  result := 0;
  if length(a1) = 0 then
    exit;
  for i := 0 to length(a1) - 1 do
    a1[i] := a1[i] - a2[i];
  repeat
    b := true;
    if length(a1)>1 then
    for i := 0 to length(a1) - 1 do
      if a1[i] < 0 then
      begin
        b := false;
        if i = length(a1) - 1 then
        begin
          result := -1;
          a1[i] := a1[i] + 10;
          b := true;
        end
        else
        begin
          if length(a1)>1 then
            a1[i + 1] := a1[i + 1] - 1
          else
            a1[i + 1] := a1[i + 1] - 1;
          a1[i] := a1[i] + 10;
        end;
      end
      else
    else
      if a1[0] < 0 then
        begin
          minus:=1;
          a1[0]:=a1[0]*(-1);
        end;
  until b;
end;


procedure AssignNumber(out n1: TNumber; const n2: TNumber);
var
  i: integer;
begin
  Setlength(n1.int, length(n2.int));
  for i := 0 to length(n2.int) - 1 do
    n1.int[i] := n2.int[i];
  Setlength(n1.frac, length(n2.frac));
  for i := 0 to length(n2.frac) - 1 do
    n1.frac[i] := n2.frac[i];
  n1.sign := n2.sign;
end;

procedure SubNumber(var n1, n2: TNumber);
var
  i: integer;
  n: TNumber;
begin
  AlignNumbers(n1, n2);
  i := subInteger(n1.frac, n2.frac);
  n1.int[0] := n1.int[0] + i;
  DisposeNumber(n);
  AssignNumber(n, n1);
  i := subInteger(n1.int, n2.int);

  if i < 0 then
  begin
    subInteger(n2.int, n.int);
    AssignNumber(n1, n2);
  end
  else
  begin
    DisposeNumber(n2);
  end;
end;

function SumInteger(a1, a2: TMathArray): integer;
var
  i: integer;
  b: boolean;
begin
  result := 0;
  if length(a1) = 0 then
    exit;
  for i := 0 to length(a1) - 1 do
    a1[i] := a1[i] + a2[i];
  repeat
    b := true;
    for i := 0 to length(a1) - 1 do
      if a1[i] > 9 then
      begin
        b := false;
        if i = length(a1) - 1 then
        begin
          result := 1;
          a1[i] := a1[i] - 10;
          b := true;
        end
        else
        begin
          a1[i + 1] := a1[i + 1] + 1;
          a1[i] := a1[i] - 10;
        end;
      end;
  until b;
end;

procedure SumNumber(var n1, n2: TNumber);
var
  i: integer;
begin
  AlignNumbers(n1, n2);
  i := sumInteger(n1.frac, n2.frac);
  n1.int[0] := n1.int[0] + i;
  i := sumInteger(n1.int, n2.int);
  if i > 0 then
  begin
    setlength(n1.int, length(n1.int) + 1);
    n1.int[length(n1.int) - 1] := i;
  end;
  DisposeNumber(n2);
end;

procedure SumNumbers(var n1, n2: TNumber);
begin
  if n1.sign and n2.sign then
  begin
    SumNumber(n1, n2);
    n1.sign := true;
  end
  else if (not n1.sign) and (not n2.sign) then
  begin
    SumNumber(n1, n2);
    n1.sign := False;
  end
  else if (not n1.sign) and n2.sign then
  begin
    SubNumber(n2, n1);
    AssignNumber(n1, n2);
  end
  else
  begin
    SubNumber(n1, n2);
  end;
end;

function ulSum(a1, a2: string): string;
var j,i1,i2,x:integer;
    n:TNumber;
begin
  if a1='' then a1:='0';
  if a2='' then a2:='0';

  Result:='';
  if (a1[1]='-') and (a2[1]<>'-') then
    begin
      a1[1]:='0';
      Result:=UlSub(a2,a1);
    end
  else
    if (a1[1]<>'-') and (a2[1]='-') then
      begin
        a2[1]:='0';
        Result:=UlSub(a1,a2);
      end
    else     
      begin
        if (a1[1]='-') and (a2[1]='-') then
          begin
            a1[1]:='0';
            a2[1]:='0';
            Result:='-';
          end;
          
        StrToNum(a1,n1);
        StrToNum(a2,n2);

        Alligment(n1,n2);
        Alligment(n1,n);

        i1:=Length(n1.int);
        i2:=Length(n2.frac);

        x:=0;
        if i2>0 then
          for j:=(i2-1) downto 0 do
            begin
              n.frac[j]:=n1.frac[j]+n2.frac[j]+x;
              if n.frac[j]>=10 then
                begin
                  x:=1;
                  n.frac[j]:=n.frac[j]-10;
                end
              else
                x:=0;
            end;

        if i1>0 then
          for j:=(i1-1) downto 0 do
            begin
              n.int[j]:=n1.int[j]+n2.int[j]+x;
              if (n.int[j]>=10) and (j>0) then
                begin
                  x:=1;
                  n.int[j]:=n.int[j]-10;
                end
              else x:=0;
            end;

        Result:=CutZirow(n);  {ќбрезка лишних нулей}
      end;
end;

function ulSub(a1, a2: string): string;
var j,i,i1,i2,x,dec,MoreLess1,MoreLess2:integer;
    n:TNumber;
    a_time1,a_time2:string;
begin
  if a1='' then a1:='0';
  if a2='' then a2:='0';

  Result:='';
    if (a1[1]<>'-') and (a2[1]='-')then
      begin
        a2[1]:='0';
        Result:=UlSum(a1,a2);
      end
    else
      if (a1[1]='-') and (a2[1]<>'-') then
        begin
          a1[1]:='0';
          Result:='-'+UlSum(a1,a2);
        end
      else
        begin
          if (a1[1]='-') and (a2[1]='-') then
            begin
              a1[1]:='0';
              a2[1]:='0';
              a_time1:=a1;
              a_time2:=a2;

              a1:=a_time2;
              a2:=a_time1;
            end;

          StrToNum(a1,n1); {ѕеревод строковой переменной в число}
          StrToNum(a2,n2);

          Alligment(n1,n2); {¬ыравнивание по разр€дам двух разных чисел}
          Alligment(n1,n);

          MoreLess1:=0; MoreLess2:=0;
          if UlComparison(n1,n2)=1 then MoreLess1:=1; {—равнение чисел. ≈сли n1 больше n2 тогда функци€ примет значение 1, если наоборот, то 2. ≈сли числа равны то будет 0}
          if UlComparison(n1,n2)=2 then MoreLess2:=1;

          i1:=Length(n1.int);
          i2:=Length(n1.frac);

          if MoreLess1=1 then
            begin
              x:=0;
              if i2>0 then
                for j:=(i2-1) downto 0 do
                  begin
                    if (n1.frac[j]<n2.frac[j]+x) then
                      dec:=10
                    else
                      dec:=0;

                    n.frac[j]:=dec+n1.frac[j]-n2.frac[j]-x;
                    n.frac[j]:=n.frac[j];

                    if dec=10 then x:=1 else x:=0;
                  end;

              if i1>0 then
                for j:=(i1-1) downto 0 do
                  begin
                    if (n1.int[j]<n2.int[j]+x) then
                      dec:=10
                    else
                      dec:=0;

                    n.int[j]:=dec+n1.int[j]-n2.int[j]-x;

                    if dec=10 then x:=1 else x:=0;
                  end;
            end;

          if MoreLess2=1 then
            begin
              x:=0;
              if i2>0 then
                for j:=(i2-1) downto 0 do
                  begin
                    if (n2.frac[j]<n1.frac[j]+x) then
                      dec:=10
                    else
                      dec:=0;

                    n.frac[j]:=dec+n2.frac[j]-n1.frac[j]-x;

                    if dec=10 then x:=1 else x:=0;
                  end;

              if i1>0 then
                for j:=(i1-1) downto 0 do
                  begin
                    if (n2.int[j]<n1.int[j]+x) and (j>0) then
                      dec:=10
                    else
                      dec:=0;

                    n.int[j]:=dec+n2.int[j]-n1.int[j]-x;
                    n.int[j]:=n.int[j];

                    if dec=10 then x:=1 else x:=0;
                  end;
            end;

          if MoreLess2=1 then Result:='-';

          Result:=CutZirow(n);  {ќбрезка лишних нулей впереди}
        end;
end;


Function testSub(SourceStr1, SourceStr2: string ):string;
var i,j,k,m:integer;
    res,str1,str2:string;
    ch1,ch2:char;

begin

     Str1:=SourceStr1; Str2:=SourceStr2;
     res:='';
     m:=0; k:=0;
     j:=pos(DecimalSeparator,str1)+1;
     for i:=length(str1) downto j do //дробна€ часть.
        begin
             ch1:=str1[i];
             ch2:=str2[i];
             try
                if (StrToInt(ch1)-StrToInt(ch2)-m)>=0 //проверка: надо ли брать взаймы 
                   then begin
                            k:=(StrToInt(ch1)-StrToInt(ch2)-m);
                            m:=0
                        end
                   else begin
                            k:=(10+StrToInt(ch1)-StrToInt(ch2)-m);
                            m:=1
                        end;

             except
                  on EConvertError do exit
             end;
             res:=IntToStr(k)+res
        end;
     res:=DecimalSeparator+res;
     for i:=j-2 downto 2 do  //цела€ часть. јналогично.
        begin
             ch1:=str1[i];
             ch2:=str2[i];
             try
                if (StrToInt(ch1)-StrToInt(ch2)-m)>=0
                   then begin
                            k:=(StrToInt(ch1)-StrToInt(ch2)-m);
                            m:=0
                        end
                   else begin
                            k:=(10+StrToInt(ch1)-StrToInt(ch2)-m);
                            m:=1
                        end;
             except
                  on EConvertError do exit
             end;
             res:=IntToStr(k)+res
        end;
     if m<>0 then res:='';
     result:=res
end;

function DupChr(const X: Char; Count: Integer): AnsiString;
begin
  if Count > 0 then
  begin
    SetLength(Result, Count);
    if Length(Result) = Count then
      FillChar(Result[1], Count, X);
  end;
end;

function StrCmp(X, Y: AnsiString): Integer;
var
  I, J: Integer;
begin
  I := Length(X);
  J := Length(Y);
  if I = 0 then
  begin
    Result := J;
    Exit;
  end;
  if J = 0 then
  begin
    Result := I;
    Exit;
  end;
  if X[1] = '-' then
  begin
    if Y[1] = '-' then
    begin
      X := Copy(X, 2, I);
      Y := Copy(Y, 2, J);
    end
    else
    begin
      Result := -1;
      Exit;
    end;
  end
  else if Y[1] = '-' then
  begin
    Result := 1;
    Exit;
  end;
  Result := I - J;
  if Result = 0 then
    Result := CompareStr(X, Y);
end;

function StrDiv(X, Y: AnsiString): AnsiString;
var
  I, J: Integer;
  S, V: Boolean;
  T1, T2: AnsiString;
  R: string;
  max: integer;

  k,l:Integer;
begin
  l:=0;
  for k:=1 to Length(Y) do
    if Y[k]=DecimalSeparator then l:=k;

  if l>0 then
    while (Y[Length(Y)]='0') do
      Delete(Y,Length(Y),1);

  Result := '0';
  R := '0';
  I := Length(X);
  J := Length(Y);
  S := False;
  V := False;
  if I = 0 then
    Exit;
  if (J = 0) or (Y = '0') then
  begin
    Result := '';
    R := '';
    Exit;
  end;
  if X[1] = '-' then
  begin
    Dec(I);
    V := True;
    X := Copy(X, 2, I);
    if Y[1] = '-' then
    begin
      Dec(J);
      Y := Copy(Y, 2, J)
    end
    else
      S := True;
  end
  else if Y[1] = '-' then
  begin
    Dec(J);
    Y := Copy(Y, 2, J);
    S := True;
  end;

 if i>1 then I:=I-1;
 if j>1 then J:=J-1;

  if I < 0 then
  begin
    R := X;
    Exit;
  end;
  T2 := DupChr('0', I)+'0';

/////// test ////
  if l=0 then
    T1 := Y + T2
  else
    begin
      Y:=StringReplace(Y,DecimalSeparator,'',[rfReplaceAll]);

      T1:=Y+Copy(T2,1,Length(T2)-(Length(Y)+1-l));

      while (T1[1]='0') do
        Delete(T1,1,1);
    end;
//////// end test ////
    if StrToFloat(X)>0 then
      T2 := '1' + T2;

//  T1:=FloatToStr(StrToFloat(Y)*StrToFloat(T2));

  max := Length(T1);
  while Length(T1) >= J do
  begin
    while StrCmp(X, T1) >= 0 do
    begin
      X := UlSub(X, T1);
      Result := UlSum(Result, T2);
    end;
    SetLength(T1, Length(T1) - 1);
    SetLength(T2, Length(T2) - 1);
    if Assigned(OnProgress) then
      OnProgress(100 - (Length(T1) / max) * 100);
  end;
  R := X;
  if S then
    if Result[1] <> '0' then
      Result := '-' + Result;
  if V then
    if R[1] <> '0' then
      R := '-' + R;
end;

function Mul10(First: string; Second: integer): string;
var
  s: string;
  i, j: integer;
begin
  if pos(DecimalSeparator, First) = 0 then
  begin
    s := '';
    for i := 0 to Second - 1 do
      s := s + '0';
    Result := First + s;
  end
  else
  begin
    s := '';
    j := length(First) - pos(DecimalSeparator, First);
    if (second - j) > 0 then
      for i := 0 to Second - j - 1 do
        s := s + '0';
    First := First + s;
    j := pos(DecimalSeparator, First);
    First := StringReplace(First, DecimalSeparator, '', []);
    insert(DecimalSeparator, First, j + second);
    while (length(First) > 0) and (First[length(First)] = '0') do
      delete(First, length(First), 1);
    while (length(First) > 0) and (First[length(First)] = DecimalSeparator) do
      delete(First, length(First), 1);
    Result := First;
  end;
end;

function Div10(First: string; Second: integer): string;
var
  s: string;
  i,j: integer;
  SS:Boolean;
begin
  J := Length(First); SS:=False;
  if First[1] = '-' then
  begin
    Dec(J);
    First := Copy(First, 2, J);
    SS := True;
  end;

  s := '';
  for i := 0 to Second do
    s := s + '0';
  s := s + First;

  Insert(DecimalSeparator, s, length(s) - Second + 1);
  while (length(s) > 1) and (s[1] = '0') and (s[2]<>DecimalSeparator) do
    delete(s, 1, 1);
  if pos(DecimalSeparator, s) > 0 then
    while (length(s) > 0) and (s[length(s)] = '0') do
      delete(s, length(s), 1);
  if (length(s) > 0) and (s[length(s)] = DecimalSeparator) then
    delete(s, length(s), 1);
  Result := s;

  if SS then
    Result := '-' + Result;
end;

function UlDiv(First, Second: string; Precision: integer): string;
var k,i:Integer;
begin
minus:=0;

  if Precision<0 then   {≈сли меньше нул€, тогда вычислить автоматом}
    Precision:=Length(First)-Pos(',',First);

//    Precision:=Precision+pos(DecimalSeparator, First)-1;
    if pos(DecimalSeparator, Second)>0 then
    Precision:=Precision+(Length(Second)-pos(DecimalSeparator, Second)-1);

   First:=normaliz(First, Second,Precision);
   Second:=normaliz(Second,First,Precision);

  First := Mul10(First, Precision);
  result := Div10(StrDiv(First, Second), Precision);
end;

function UlRound(IshStr: string; DigNum: integer): string;
Var
 NewDigit,i,j,Index:integer;
 NextStr,NewChar:string;
begin
 if Pos(DecimalSeparator,IshStr)>0 then DigNum:=DigNum+Pos(DecimalSeparator,IshStr);

 if Length(IshStr)>DigNum                                // ≈сли длина строки больше чем разр€д дл€ округлени€
  then                                                   // то работаем, иначе - просто игнорируем.
   begin
     if (Pos(DecimalSeparator,IshStr) <> 0) and                       // ≈сли в строке имеетс€ зап€та€
        (Pos(DecimalSeparator,IshStr)< DigNum)                        // и она попадает в разр€д округлени€
      then                                               // то работаем, иначе выдаем "error"
       begin
         if StrToInt(copy(IshStr,DigNum+1,1))>=5         // ≈сли след.разр€д больше 5ки то
          then
           begin
             j:=DigNum;
             repeat
               if IshStr[j]=DecimalSeparator
                then j:=j-1
                else begin
                       NewDigit:=StrToInt(IshStr[j])+1;  // добавл€ем 1 к разр€ду
                       if NewDigit<10                    // и если не получаетс€, что там стало больше 9ки то
                        then
                         begin                           // сохран€ем новое значение.
                           NewChar:=IntToStr(NewDigit);  //
                           IshStr[j]:=NewChar[1];        //
                           j:=0;                         //
                         end
                        else
                         begin                           // »наче загон€ем туда ноль и переходим на разр€д левее
                           IshStr[j]:='0';               //
                           j:=j-1;                       //
                         end;
                     end;
             until j<1;                                  // и повтор€ем все заново.
           end;
         UlRound:=Copy(IshStr,1,DigNum);                 // ј в конце отбрасываем "хвостик" и пор€док!
       end
      else UlRound:='0';
   end
 else
  UlRound:=IshStr;
end;


end.

