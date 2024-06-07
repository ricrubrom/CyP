Procedure Ejercicio3 IS

    TASK Empleado IS
        ENTRY atencionCliente(pedido:IN txt);
        ENTRY atencionDirector(pedido:IN txt);
    END Empleado;

    TASK Director;

    TASK TYPE Cliente;

    clientes=array(1..C) of Cliente;

    TASK BODY Empleado IS

    BEGIN
        FOR(i:=0 to C) LOOP
            SELECT
                WHEN (atencionDirector'count=0) ACCEPT atencionCliente(pedido:IN txt) IS
                    atender(pedido);
                END atencionCliente;
                OR ACCEPT atencionDirector(pedido:IN txt) IS
                    atender(pedido);
                END atencionDirector;
                OR ACCEPT noAtendido();
            END SELECT;
        END LOOP;
    END Empleado;

    TASK BODY Director IS
    atendido: bool;
    BEGIN
        atendido:=false;
        WHILE(!atendido) LOOP
            SELECT
                Empleado.atencionDirector(pedido);
                    atendido:=true;
            ELSE
                DELAY 600;
            END SELECT;
        END LOOP
    END Director;

    TASK BODY Cliente IS

    BEGIN
        SELECT
            Empleado.atencionCliente(pedido);
            OR DELAY 1200;
                Empleado.noAtendido();
        END SELECT;
    END Cliente;

BEGIN
    NULL;
END Ejercicio3;