type
empleado=record
nombre:string;
apellido:string;
dni:longint;
edad:integer;
end;

archivo= file of empleado;




procedure leer(var e:empleado);
begin

    with e do begin
    writeln ('ingrese dni:');
    readln(dni);
    if (dni <> 00)then begin
        writeln ('ingrese nombre: ');
        readln(nombre);
        writeln ('ingrese apellido: ');
        readln(apellido);
        writeln ('ingrese edad: ');
        readln(edad);
        end;
    end;
end;

procedure generarArchivo(var empleados:archivo);
var
    e:empleado;
    archFisico:string;
begin
    write('ingrese un nombre para el archivo: ');
    readln(archFisico);
    assign(empleados,archFisico);
    rewrite(empleados);
    leer(e);
    while (e.dni <> 00)do begin
        write(empleados,e);
        leer(e);
    end;
    close(empleados);
end;

procedure imprimirEmpleados(var empleados:archivo);
var
    e:empleado;
begin
    reset(empleados);
    while not EOF(empleados)do begin
        read(empleados,e);
        with e do begin
            write(nombre + ' ' + apellido + ' ');
            writeln( edad,' ' ,dni);
        end;
    end;
    close(empleados);
end;

procedure buscar(var empleados:archivo);
var 
    nombre:string;
    e:empleado;
begin
    writeln('ingrese nombre a bucar: ');
    readln(nombre);
    reset(empleados);
    while not eof(empleados)do begin
        read(empleados,e);
        if(e.nombre = nombre)then begin
            with e do begin
                write(nombre + ' ' + apellido + ' ');
                writeln( edad,' ' ,dni);
            end;
        end;
    end;
    close(empleados);

end;

procedure mayores(var empleados:archivo);
var 
    e:empleado;
begin
    reset(empleados);
    while not eof(empleados)do begin
        read(empleados,e);
        if( e.edad > 70 )then begin
            with e do begin
                write(nombre + ' ' + apellido + ' ');
                writeln( edad,' ' ,dni);
            end;
        end;
    end;
    close(empleados);
end;

procedure agregarEmpleado(var empleados:archivo);
var
    e:empleado;
    pos:int64;
begin
    reset(empleados);
    leer(e);
    pos:= fileSize(empleados);
    seek(empleados,pos);
    write(empleados,e);
    close(empleados);
end;

procedure modificarEdad(var empleados:archivo);
var 
    edad:integer;
    e:empleado;
    dni:longint;
begin
    writeln('Ingrese dni de la persona: ');
    readln(dni);
    reset(empleados);
    while not eof(empleados)do begin
        read(empleados,e);
        if(e.dni = dni)then begin
             with e do begin
                write(nombre + ' ' + apellido + ' ');
                writeln( edad,' ' ,dni);
            end;
            writeln('Ingrese edad nueva: ');
            readln(edad);
            e.edad:= edad;
            seek(empleados,filePos(empleados)-1);
            write(empleados,e);
        end;
    end;
    close(empleados);
end;

procedure exportarEmpleados(var empleados:archivo);
var
arch:Text;
e:empleado;
begin
    assign(arch,'exportEmpleados.txt');
    reset(empleados);
    rewrite(arch);
    while not eof(empleados)do begin
        read(empleados,e);
        write(arch,e.dni,' ',e.edad, ' ',e.nombre);
        writeln(arch,' ',e.apellido);
    end;
    close(empleados);
    close(arch);
    
end;

var 
empleados:archivo;
menu:integer;
begin
assign(empleados,'empleados.dat');
writeln('---------MENU---------');
menu := 9;
while (menu <> 0)do begin
    writeln('  ');
    writeln('0. Terminar. ');
    writeln('1. Generar archivo. ');
    writeln('2. Imprimir empleados. ');
    writeln('3. Buscar. ');
    writeln('4. Mayores de 70');
    writeln('5. Agregar un empleado');
    writeln('6. Modificar edad');
    writeln('7. Exportar txt');
    writeln(' ');
    readln(menu);
    if(menu = 1)then
        generarArchivo(empleados);
    if (menu = 2)then
        imprimirEmpleados(empleados);
    if(menu = 3)then
        buscar(empleados);
    if(menu = 4)then
        mayores(empleados);
    if(menu = 5)then
        agregarEmpleado(empleados);
    if(menu = 6)then
        modificarEdad(empleados);
    if(menu = 7)then
        exportarEmpleados(empleados);
end;
end.