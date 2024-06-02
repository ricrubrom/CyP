Procedure Ejercicio8 IS

TASK TYPE Persona
    ENTRY Identificarme(ident: IN integer);
    ENTRY Respuesta();
END Persona;

personas = ARRAY(1..P) OF Persona;

TASK TYPE Camion;

camiones = ARRAY(1..3) OF Camion;

TASK Empresa IS
    ENTRY Reclamo(id: IN integer);
    ENTRY Siguiente(id_cliente: out integer);
END Empresa;


TASK BODY Persona IS
    id: integer;
    atendido: bool;
BEGIN
    ACCEPT Identificarme(ident: IN integer) IS
        id := indet;
    END Identificarme;

    atendido := false;
    WHILE(not atendido)LOOP
        Empresa.Reclamo(id);
        SELECT
            ACCEPT Respuesta();
            atendido := true;
        DELAY 900
            NULL;    
        END SELECT;
    END LOOP;
END Persona;


TASK BODY Empresa IS
    reclamos[P]: integer;
BEGIN
    reclamos[:] := 0;
    LOOP
        SELECT
            ACCEPT Reclamo(id: IN integer) IS
                IF(reclamos[id] <> -1)THEN
                    reclamos[id] := reclamos[id] + 1;
            END Reclamo;
                
        OR WHEN (max(reclamos)>0) => 
            ACCEPT Siguiente(id_cliente: out integer) IS
                id_cliente := max_pos(reclamos);
                reclamos[id_cliente] := -1;
            END Siguiente;
        END SELECT;
    END LOOP;
END Empresa;



TASK BODY Camion IS
    id_actual: integer;
BEGIN
    LOOP
        Empresa.Siguiente(id_actual);
        personas(id_actual).Resuesta();
    END LOOP;
END Camion;




    i: integer;
BEGIN
    FOR i IN 1..P LOOP
        personas(i).Identificarme(i);
    END LOOP;
END Ejercicio8;