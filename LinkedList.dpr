library LinkedList;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  System,
  TOperativeUnit in 'TOperativeUnit.pas';

{$R *.res}



  
var
  gHead : PElem;

procedure Append(item : TElemType); stdcall;
var
  newNode : PElem;
  iter : PElem;
begin
  if gHead = nil then
  begin
    //if list is empty, create it
    New(gHead);
    gHead^.Next := nil;
    gHead^.Val := item;
    Exit;
  end;
  //otherwise, find tail and append new element to it
  iter := gHead;
  while(iter^.Next <> nil) do
  begin
    iter := iter^.Next;
  end;
  New(newNode);
  newNode^.Next := nil;
  newNode^.Val := item;

  iter^.Next := newNode;
end;

procedure WriteEach; stdcall;
var
  iter : PElem;
begin
  //check if empty
  if gHead = nil then
  begin
    writeln('Empty');
    Exit;
  end;
   
  iter := gHead;
   
  while iter <> nil do
  begin
    writeln(iter^.Val.FirstName);
    iter := iter^.Next;
  end;

end;

exports 
  Append name 'Append',
  WriteEach name 'WriteEach';

begin
  gHead := nil;
end.
