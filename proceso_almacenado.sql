/*==============================================================*/
/* Nombre:   	Cifuentes Castro Irvin Gustavo          	    */
/* Curso: 		5to Nivel B, Gestion de Bases de Datos  	    */
/*==============================================================*/


create or replace procedure gananciasHabitacion_anio(p_habitacion_id habitacion.habitacion_id%type)
as
cursor habitacion_anio is
select h.habitacion_descripcion, f.factura_total, sum(f.factura_total) as total_anio
from factura f
inner join habitacion h on h.habitacion_id = f.habitacion_id
where h.habitacion_id = f.habitacion_id
and f.habitacion_id = p_habitacion_id
group by h.habitacion_descripcion, f.factura_total;
begin
    for total in habitacion_anio loop
    dbms_output.put_line('La '||total.habitacion_descripcion||' ha generado $'||total.total_anio ||' en lo que va del año');
    end loop;
end;
/
declare
p_habitacion_id habitacion.habitacion_id%type := &codigo;
begin
gananciasHabitacion_anio(p_habitacion_id);
end;