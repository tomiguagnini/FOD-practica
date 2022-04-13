type

alumno=record
cod:integer;
apellido:string;
nombre:string;
cant_materias_aprobadas:integer;
cant_materias_final:integer;
end;

alum_mat=record
cod:integer;
aprobo:string;
end;

Maestro=file of alumno;
detalle= file of alum_mat;


procedure leer(var a:alumno);
begin
    with a do begin
        readln(cod);
        if(cod <> 00)then begin
            readln(nombre);
            readln(apellido);
            readln(cant_materias_aprobadas);
            readln(cant_materias_final);
        end;
    end;
end;


procedure leer2(var a:alum_mat);
begin
    with a do begin
        readln(cod);
        if(cod <> 00)then begin
            readln(aprobo);
        end;
    end;
end;


procedure generarMaestro(var mae:Maestro);
var
a:alumno;
begin
    rewrite(mae);
    leer(a);
    while (a.cod <> 00)do begin
        write(mae,a);
        leer(a);
    end;
    close(mae);
end;

procedure generarDetalle (var det:detalle);
var
a:alum_mat;
begin
    rewrite(det);
    leer2(a);
    while(a.cod <> 00)do begin
        write(det,a);
        leer2(a);
    end;
    close(det);
end;

procedure imprimirMaestro(var mae:Maestro);
var
    a:alumno;
begin
    reset(mae);
    while not EOF(mae)do begin
        read(mae,a);
        with a do begin
            write(nombre + ' ' + apellido + ' ');
            writeln( cod,' ' );
            writeln(cant_materias_aprobadas,' ',cant_materias_final);
        end;
    end;
    close(mae);
end;


procedure imprimirDetalle(var det:detalle);
var
    a:alum_mat;
begin
    reset(det);
    while not EOF(det)do begin
        read(det,a);
        with a do begin
            writeln( cod,' ',aprobo );
        end;
    end;
    close(det);
end;


procedure leerDetalle(var det:detalle; var regDet:alum_mat);
var
valor_alto:int64;
begin
    valor_alto:=9999;
    if not eof(det)then 
        read(det,regDet)
    else
        regDet.cod:=valor_alto;
    
end;

procedure actualizarMaestro(var mae:Maestro;var det:detalle);
var
regMae:alumno;
regDet:alum_mat;
begin
    reset(mae);
    reset(det);
    while not eof(mae)do begin
        read(mae,regMae);
        leerDetalle(det,regDet);
            while( regMae.cod = regDet.cod) AND (regDet.cod <> 9999) do begin
                if( regDet.aprobo = 'cursada')then
                    regMae.cant_materias_aprobadas := regMae.cant_materias_aprobadas + 1;
                if( regDet.aprobo = 'final')then
                    regMae.cant_materias_final := regMae.cant_materias_final + 1 ;
                leerDetalle(det,regDet);
            end;
        seek(mae,filePos(mae)-1);
        write(mae,regMae);
    end;
    close(mae);
    close(det);
end;




var
mae:Maestro;
det:detalle;
menu:integer;
begin
assign(mae,'maestro.dat');
assign(det,'detalle.dat');
writeln('---------MENU---------');
menu := 9;
while (menu <> 0)do begin
    writeln('  ');
    writeln('0. Terminar. ');
    writeln('1. Generar Maestro. ');
    writeln('2. Generar Detalle. ');
    writeln('3. Imprimir Maestro. ');
    writeln('4. Imprimir Detalle. ');
    writeln('5. Actualizar Maestro. ');
    writeln(' ');
    readln(menu);
    if(menu = 1)then
        generarMaestro(mae);
    if (menu = 2)then 
        generarDetalle(det);
    if(menu = 3)then 
        imprimirMaestro(mae);
    if (menu = 4)then 
        imprimirDetalle(det);
    if (menu = 5)then
        actualizarMaestro(mae,det);
  
    
end;


end.