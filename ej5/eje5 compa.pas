program practica1_ejercicio5y6;
type
electrodomestico = record
codigo:integer;
nombre:String;
descripcion:String;
precio:real;
stock_minimo:integer;
stock_disponible:integer;
end;

elec = file of electrodomestico;

Procedure LeerElectrodomestico(var elemento:electrodomestico);
begin
writeln('Ingrese codigo del electrodomestico');
readln(elemento.codigo);
if(elemento.codigo <> 0)then begin
writeln('Ingrese nombre del electrodomestico');
readln(elemento.nombre);
writeln('Ingrese descripcion del producto');
readln(elemento.descripcion);
writeln('Ingrese precio del producto');
readln(elemento.precio);
writeln('Ingrese stock_minimo');
readln(elemento.stock_minimo);
writeln('Ingrese stock_disponible');
readln(elemento.stock_disponible);
end;
end;

Procedure CargarArchivo(var arch_elec:elec);
var
E:electrodomestico; carga:text; nombre:String;
begin
writeln('--------------------------');
writeln('Ingrese nombre del archivo');
writeln('--------------------------');
readln(nombre);
Assign(arch_elec,nombre);
Assign(carga,'carga.txt');
Rewrite(arch_elec);
Reset(carga);
while(not EOF(carga))do begin
Readln(carga,E.codigo,E.precio,E.nombre);
Readln(carga,E.stock_disponible,E.stock_minimo,E.descripcion);
Write(arch_elec,E);
end;
Close(arch_elec);
Close(carga);
end;

Procedure ImprimirElemento(E:electrodomestico);
begin
writeln('--------------------------------------------');
writeln('Codigo:', E.codigo);
writeln('Nombre:', E.nombre);
writeln('Descripcion:', E.descripcion);
writeln('Precio:', E.precio:0:2);
writeln('Stock minimo:', E.stock_minimo);
writeln('Stock disponible:', E.stock_disponible);
writeln('--------------------------------------------');
end;

Procedure ListarConStockMenorAlMinimo(var arch_elec:elec);
var
E:electrodomestico;
begin
Reset(arch_elec);
while(not EOF(arch_elec))do begin
read(arch_elec,E);
if(E.stock_disponible < E.stock_minimo)then
ImprimirElemento(E);
end;
Close(arch_elec);
end;

Procedure ListarDescripcion(var arch_elec:elec);
var
descripcion:String; E:electrodomestico;
begin
Reset(arch_elec);
writeln('Ingrese la descripcion que desea buscar');
readln(descripcion);
while(not EOF(arch_elec))do begin
read(arch_elec,E);
if(E.descripcion = descripcion)then
ImprimirElemento(E);
end;
Close(arch_elec);
end;

Procedure ExportarArchivoDeTexto(var arch_elec:elec);
var
E:electrodomestico; arch_total:text;
begin
Reset(arch_elec);
Assign(arch_total,'electro.txt');
Rewrite(arch_total);
while(not EOF(arch_elec))do begin
Read(arch_elec,E);
Writeln(arch_total, 'Codigo de electrodomestico:', E.codigo, ' Precio:', E.precio:0:2, ' Nombre:', E.nombre);
Writeln(arch_total, 'Stock disponible:', E.stock_disponible, ' Stock minimo:', E.stock_minimo, ' Descripcion:', E.descripcion);
end;
Close(arch_elec);
Close(arch_total);
end;

Procedure Anadir(var arch_elec:elec);
var
E:electrodomestico;
begin
Reset(arch_elec);
Seek(arch_elec,FileSize(arch_elec));
LeerElectrodomestico(E);
while(E.codigo <> 0)do begin
Write(arch_elec,E);
LeerElectrodomestico(E);
end;
Close(arch_elec);
end;

Procedure ModificarStock(var arch_elec:elec);
var
codigo:integer; flag:boolean; elemento:electrodomestico;
begin
Reset(arch_elec);
flag:=false;
writeln('Ingrese el codigo de producto que desea modificar');
readln(codigo);
while(not flag) and (not EOF(arch_elec))do begin
Read(arch_elec,elemento);
if(elemento.codigo = codigo)then begin
writeln('Ingrese el stock');
readln(elemento.stock_disponible);
Seek(arch_elec,FilePos(arch_elec)-1);
Write(arch_elec,elemento);
flag:=true;
end;
end;
if(flag = true)then
writeln('Se modifico exitosamente el electrodomestico')
else
writeln('No se hayo el elemento ', codigo);
Close(arch_elec);
end;

Procedure ExportarElectrodomesticosSinStock(var arch_elec:elec);
var
E:electrodomestico; arch_sin_stock:text;
begin
Reset(arch_elec);
Assign(arch_sin_stock,'SinStock.txt');
Rewrite(arch_sin_stock);
while(not EOF(arch_elec))do begin
Read(arch_elec,E);
if(E.stock_disponible = 0)then begin
Writeln(arch_sin_stock, 'Codigo de electrodomestico:', E.codigo, ' Precio:', E.precio:0:2, ' Nombre:', E.nombre);
Writeln(arch_sin_stock, 'Stock disponible:', E.stock_disponible, ' Stock minimo:', E.stock_minimo, ' Descripcion:', E.descripcion);
end;
end;
Close(arch_elec);
Close(arch_sin_stock);
end;

var
arch_elec:elec; opcion:integer;
begin
repeat
writeln('------------------------------------------------------------');
writeln('SELECCION LA OPCION QUE DESEA OPERAR');
writeln('------------------------------------------------------------');
writeln('1)Cargar archivo de electrodomesticos');
writeln('------------------------------------------------------------');
writeln('2)Listar electrodomesticos que tenga stock menor al minimo');
writeln('------------------------------------------------------------');
writeln('3)Listar electrodomesticos cuya descripcion sea la propuesta');
writeln('------------------------------------------------------------');
writeln('4)Exportar electrodomesticos a archivo de texto');
writeln('------------------------------------------------------------');
writeln('5)Añadir electrodomesticos');
writeln('------------------------------------------------------------');
writeln('6)Modicar stock de un electrodomestico');
writeln('------------------------------------------------------------');
writeln('7)Exportar electrodomesticos sin stock a archivo de texto');
writeln('------------------------------------------------------------');
readln(opcion);
case opcion of
1:CargarArchivo(arch_elec);
2:ListarConStockMenorAlMinimo(arch_elec);
3:ListarDescripcion(arch_elec);
4:ExportarArchivoDeTexto(arch_elec);
5:Anadir(arch_elec);
6:ModificarStock(arch_elec);
7:ExportarElectrodomesticosSinStock(arch_elec);
end;
until(opcion = 0);
readln(opcion);
end.
