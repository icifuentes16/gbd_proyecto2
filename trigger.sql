/*==============================================================*/
/* Nombre:   	Cifuentes Castro Irvin Gustavo          	    */
/* Curso: 		5to Nivel B, Gestion de Bases de Datos  	    */
/*==============================================================*/



/*PRIMERO AÑADIMOS LA COLUMNA SUELDO A LOS EMPLEADOS, TODOS TENDRÁN UN SUELDO BÁSICO DE $400*/

ALTER TABLE EMPLEADO ADD EMPLEADO_SUELDO NUMBER(8,2) DEFAULT 400;

//////////////////////////////////////////////////////////////////////////////////

/*CREAMOS EL TRIGGER*/

create or replace trigger tr_bono_empleado
before
insert on mantenimiento
for each row
declare numero_mantenimiento int :=0; bono_sueldo number(8,2) :=0; mes_mantenimiento int :=0; mes_actual int :=0;
begin
    select count(*) into numero_mantenimiento from mantenimiento where empleado_id = :new.empleado_id;
    select avg(mantenimiento_costo) into bono_sueldo from mantenimiento where rownum <= 5 and empleado_id = :new.empleado_id order by mantenimiento_costo desc;
    select max(extract(month from mantenimiento_fecha_fin)) into mes_mantenimiento from mantenimiento where empleado_id = :new.empleado_id;
    select extract(month from sysdate) into mes_actual from dual;
        if mes_mantenimiento = mes_actual then
            if mod(numero_mantenimiento, 4) = 0 then
                update empleado set empleado_sueldo = empleado_sueldo + bono_sueldo where empleado_id = :new.empleado_id;
            end if;      
        else
            update empleado set empleado_sueldo = 400 where empleado_id = :new.empleado_id;
        end if;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////


/* INSERTAMOS DATOS DEL MES DONDE SE REALIZAN LOS 5 MANTENIMIENTOS*/

INSERT INTO MANTENIMIENTO VALUES (16, 1, 2, to_date('2022/07/10:02:08:11PM', 'yyyy/mm/dd:hh:mi:sspm'), to_date('2022/07/30:02:17:31PM', 'yyyy/mm/dd:hh:mi:sspm'), 'MANTENIMIENTO LIMPIEZA', 10);
INSERT INTO MANTENIMIENTO VALUES (17, 1, 2, to_date('2022/07/14:04:08:11PM', 'yyyy/mm/dd:hh:mi:sspm'), to_date('2022/07/30:04:33:31PM', 'yyyy/mm/dd:hh:mi:sspm'), 'MANTENIMIENTO LIMPIEZA', 10);
INSERT INTO MANTENIMIENTO VALUES (18, 1, 2, to_date('2022/07/14:05:30:11PM', 'yyyy/mm/dd:hh:mi:sspm'), to_date('2022/07/30:06:01:31PM', 'yyyy/mm/dd:hh:mi:sspm'), 'MANTENIMIENTO LIMPIEZA', 10);
INSERT INTO MANTENIMIENTO VALUES (19, 1, 2, to_date('2022/07/14:09:08:11PM', 'yyyy/mm/dd:hh:mi:sspm'), to_date('2022/07/30:10:01:31PM', 'yyyy/mm/dd:hh:mi:sspm'), 'MANTENIMIENTO LIMPIEZA', 10);
INSERT INTO MANTENIMIENTO VALUES (20, 1, 2, to_date('2022/07/21:03:08:11PM', 'yyyy/mm/dd:hh:mi:sspm'), to_date('2022/07/30:03:29:31PM', 'yyyy/mm/dd:hh:mi:sspm'), 'MANTENIMIENTO LIMPIEZA', 10);


/* INSERTAMOS DATOS CON FECHAS DIFERENTES PARA COMPROBAR LO DEL SUELDO*/

INSERT INTO MANTENIMIENTO VALUES (21, 1, 2, to_date('2022/08/15:02:00:11PM', 'yyyy/mm/dd:hh:mi:sspm'), to_date('2022/08/30:02:17:31PM', 'yyyy/mm/dd:hh:mi:sspm'), 'MANTENIMIENTO LIMPIEZA', 10);
INSERT INTO MANTENIMIENTO VALUES (22, 1, 2, to_date('2022/08/16:04:08:11PM', 'yyyy/mm/dd:hh:mi:sspm'), to_date('2022/08/30:05:01:31PM', 'yyyy/mm/dd:hh:mi:sspm'), 'MANTENIMIENTO LIMPIEZA', 10);



DELETE FROM MANTENIMIENTO WHERE MANTENIMIENTO_ID = 22;
DELETE FROM MANTENIMIENTO WHERE MANTENIMIENTO_ID = 21;
DELETE FROM MANTENIMIENTO WHERE MANTENIMIENTO_ID = 20;
DELETE FROM MANTENIMIENTO WHERE MANTENIMIENTO_ID = 19;
DELETE FROM MANTENIMIENTO WHERE MANTENIMIENTO_ID = 18;
DELETE FROM MANTENIMIENTO WHERE MANTENIMIENTO_ID = 17;
DELETE FROM MANTENIMIENTO WHERE MANTENIMIENTO_ID = 16;
