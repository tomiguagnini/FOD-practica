const valoralto = 99999;
type
detalle=record
codLocalidad:integer;
codCepa:integer;
CasosActivos:integer;
CasosNuevos:integer;
recuperados:integer;
fallecidos:integer;
end;

archivoDetalle= array [1..10]of file of detalle;
regDetalle= array [1..10] of detalle;

maestro=record
codLocalidad:integer;
nombreLocalidad:string;
codCepa:integer;
nombreCepa:string;
CasosActivos:integer;
CasosNuevos:integer;
Recuperados:integer;
fallecidos:integer;
end;

archivoMaestro= file of maestro;


procedure leer (var archivo:archivoDetalle; var dato:detalle);
    begin
      if (not eof( archivo ))
        then read (archivo, dato)
        else dato.cod := valoralto;
    end;

procedure minimo (var reg_det: regDetalle; var min:detalle; var deta:archivoDetalle);
    var i: integer;
    begin
      { busco el mínimo elemento del 
        vector reg_det en el campo cod,
        supongamos que es el índice i }
      min = reg_det[i];
      leer( deta[i], reg_det[i]);
    end; 


procedure ProcesarMaestro(var mae:maestro;);
begin
    
end;




var
mae:archivoMaestro;
det:archivoDetalle;
regm:maestro;
regd:regDetalle;
min:detalle;

begin
    assign(mae,'maestro.dat');
    for := 1 to 10  do begin
        assign(det[i], 'det'+ i);
        reset(det[i]);
        leer(det[i],regD[i]);
    write('a');
end.

