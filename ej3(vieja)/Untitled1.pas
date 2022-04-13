program archivos;
type
empleado= record
  nro:integer;
  nombre:string[20];
  apellido:string[20];
  edad:integer;
  dni:integer;
  end;
archivo = file of empleado;



procedure leer(var e:empleado);
begin
write('ingrese apellido: ');
readln(e.apellido);
if (e.apellido <> 'zzz') then begin
  write('ingrese nro: ');
  readln(e.nro);
  write('ingrese nombre: ');
  readln(e.nombre);
  write('ingrese edad: ');
  readln(e.edad);
  write('ingrese dni: ');
  readln(e.dni);
  end;

end;

procedure Generar_archivo(var arc_logico:archivo;var arc_fisico: string );
var
emp:empleado;
i:integer ;
begin
write( 'Ingrese el nombre del archivo:' );
readln(arc_fisico );
assign( arc_logico, arc_fisico );
rewrite( arc_logico );
leer(emp);
//emp.apellido:= 'a';
while emp.apellido <> 'zzz' do begin
//for i:= 1 to 5 do begin
write( arc_logico, emp );
//emp.apellido:= 'a';
leer(emp);
end;
close( arc_logico );
end;


Procedure Recorrido(var arc_logico: archivo );
var emp: empleado;

begin
reset( arc_logico );
while not eof( arc_logico) do begin
read( arc_logico, emp);
writeln(emp.apellido);
end;
close( arc_logico );
end;


 Procedure agregar (Var Emp: archivo);
var E: empleado;
begin
reset( Emp );
seek( Emp, filesize(Emp));
leer( E );
while E.apellido <> 'zzz' do begin
write( Emp, E );
leer( E );
end;
close( Emp );
end;

procedure exportar (var arc_logico:archivo);
var
carga:text;
str:string;
emp:empleado;
begin
write('ingrese nombre del txt: ');
readln(str);
assign(carga,str);
reset(arc_logico);
rewrite(carga);
while not eof(arc_logico) do begin
read(arc_logico,emp);
with emp do writeln(nro, edad, dni, apellido);
with emp do writeln(carga,' ',nro,' ',edad,' ',dni,' ',apellido);
end;
close(arc_logico);
close(carga);
end;


var
arc_logico: archivo;
nro: integer;
arc_fisico: string[12];
begin

writeln('1. Generar archivo ');
writeln('2. Agregar empleado ');
writeln('3. Imprimir empleado');
writeln('4. Exportar a un txt');
writeln('0. Cerrar ');

readln(nro);
while nro <> 0 do begin
if nro = 1 then
  Generar_archivo(arc_logico, arc_fisico);
if nro = 2 then
  agregar(arc_logico);
if nro= 3 then
  Recorrido(arc_logico);
if nro = 4 then
  exportar (arc_logico);

writeln('1. Generar archivo ');
writeln('2. Agregar empleado al final ');
writeln('3. Imprimir empleado');
writeln('4. Exportar a un txt');
writeln('0. Cerrar ');

readln(nro);
end;
Recorrido(arc_logico);
write('Fin');
read(nro);


end.
