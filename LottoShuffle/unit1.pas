unit Unit1;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
   StdCtrls, Spin, Buttons, ExtCtrls;

type

   { TForm1 }

   TForm1 = class(TForm)
      BitBtn1: TBitBtn;
      BitBtn2: TBitBtn;
      BitBtn3: TBitBtn;
      Image1: TImage;
      ImageList1: TImageList;
      Label1: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      ListBox1: TListBox;
      ListBox2: TListBox;
      SpinEdit1: TSpinEdit;
      SpinEdit2: TSpinEdit;
      StatusBar1: TStatusBar;
      ToolBar1: TToolBar;
      ToolButton1: TToolButton;
      ToolButton2: TToolButton;
      procedure BitBtn1Click(Sender: TObject);
      procedure BitBtn2Click(Sender: TObject);
      procedure BitBtn3Click(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure ToolButton1Click(Sender: TObject);
      procedure ToolButton2Click(Sender: TObject);
   private
      { private declarations }
   public
      { public declarations }
   end;

var
   Form1: TForm1;

implementation

{$R *.lfm}

procedure Shuffle(var a:array of string);
var i,i1,i2:integer;
    temp:string;
begin
  for i:=0 to length(a)*10 do
    begin
      repeat
        i1:=random(length(a));
        i2:=random(length(a));
      until (i1<>i2);
        temp:=a[i1];
        a[i1]:=a[i2];
        a[i2]:=temp;
    end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
   randomize;

   label4.caption:='N := '+inttostr(listbox1.items.count);
   spinedit2.MaxValue:=listbox1.Items.Count;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
var
  buttonSelected : Integer;
begin
  // Show a confirmation dialog
  buttonSelected := MessageDlg('Clear everything?',mtWarning, mbOKCancel, 0);

  if (buttonSelected = mrOK) then //ShowMessage('OK pressed');
   begin
      listbox1.clear;
      listbox2.clear;
      label4.caption := 'N := '+inttostr(listbox1.items.count);
      spinedit1.value := 1;
   end;

  if (buttonSelected = mrCancel) then exit; //ShowMessage('Cancel pressed');
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
   showmessage('Populate the box on the left with your favourite lotto numbers' +#13#10+
               ' (1-45), then let the program choose combinations for you!');
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
    i:integer;
begin

  if spinedit1.Value<10 then listbox1.items.add('0'+inttostr(spinedit1.Value))
  else
  listbox1.items.add(inttostr(spinedit1.Value));

  //check for duplicates and remove accordingly (it will seem like NO add:)
  for i:=listbox1.items.count-1 downto 1 do
    if listbox1.Items.strings[i]=listbox1.items.strings[i-1] then
      listbox1.items.Delete(i);

  label4.caption := 'N := '+inttostr(listbox1.items.count);

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
    i:integer;
    A:array of string;
begin

  listbox2.items.clear;

  if (spinedit2.value > listbox1.items.count) then
  begin
     showmessage('You selected more than exist!');
     exit;
  end;

  setlength(A,listbox1.items.count);

  for i:=0 to listbox1.items.count-1 do
    A[i]:=listbox1.items.Strings[i];

  Shuffle(A);

  for i:=0 to (spinedit2.value)-1 do
    listbox2.items.add(A[i]);

end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
   showmessage('Created by tolisd.');
end;

end.

