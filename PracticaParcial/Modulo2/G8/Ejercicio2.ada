Procedure Ejercicio2 IS

    TASK Empleado IS
        ENTRY atencion();
        ENTRY noAtendido();
    END Empleado;

    TASK TYPE Persona;

    personas=array(1..P) of Persona;

    TASK BODY Empleado IS
    i:integer;
    BEGIN
        FOR (i:=1 to P) LOOP
            SELECT
                ACCEPT atencion() IS
                    Atender();
                END atencion;
            OR
                ACCEPT noAtendido();
            END SELECT;
        END LOOP
    END Empleado;

    TASK BODY Persona IS

    BEGIN
        SELECT
            Empleado.atencion();
        OR DELAY 1200;
            Empleado.noAtendido()
        END SELECT;
    END Persona;

BEGIN
    NULL;
END Ejercicio2;