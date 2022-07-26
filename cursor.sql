/*==============================================================*/
/* Nombre:   	Cifuentes Castro Irvin Gustavo          	    */
/* Curso: 		5to Nivel B, Gestion de Bases de Datos  	    */
/*==============================================================*/

declare 
    cursor historial_habitaciones is
        select to_char(to_date(factura_fecha_llegada), 'month') as mes, h.habitacion_descripcion as habitacion, f.factura_total, m.mantenimiento_costo
        from factura f
        inner join habitacion h on h.habitacion_id = f.habitacion_id
        inner join mantenimiento m on m.mantenimiento_id = h.habitacion_id; 
begin   
for historial in historial_habitaciones loop
    dbms_output.put_line('En '||historial.mes||': la '|| historial.habitacion|| 
    '; generó un total de $'|| historial.factura_total|| ', mientras que en gastos de 
    mantemiento ocupó $'||historial.mantenimiento_costo);
end loop;
end;
/

////////////////////////////////////////////////////////////
Cuantas servicios realizaron los empleados que tienen como primeros dígitos 135 en la cedula en el año 2019