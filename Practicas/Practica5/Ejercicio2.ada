Procedure Ejercicio2 IS

TASK Empleado IS
    ENTRY Atender(datos:IN text, res:OUT text);
END Empleado;

TASK TYPE Cliente;

clientes = ARRAY(1..N) OF Cliente;

TASK BODY Cliente IS
    datos, res:text;
Begin
    datos:= ...;
    SELECT Empleado.Atender(datos, res);
    OR DELAY 600
        NULL;
    END SELECT;
END Cliente;

TASK BODY Empleado IS
Begin
    LOOP
        ACCEPT Atender(datos: IN text, res: OUT text) IS
            res:=ObtenerRes(datos);
        END Atender;
    END LOOP;
END Empleado;



BEGIN
    NULL;
END Ejercicio2;