Procedure Ejercicio4 IS

    TASK Medico IS
        ENTRY atenderEnfermera(res:OUT string);
        ENTRY atencion();
        ENTRY procesarNota(id:in integer; peticion:in string)
    END Medico;

    TASK TYPE Enfermera IS
        ENTRY identificacion(aux: IN integer);
        ENTRY respuestaNota(res:IN string);
    END Enfermera;

    TASK TYPE Persona;

    TASK Consultorio IS
        ENTRY dejarNota(id:IN integer; peticion:IN string);
        ENTRY siguienteNota();
    END Consultorio;

    enfermeras: ARRAY(1..E) OF Enfermera;
    personas: ARRAY(1..P) OF Persona;

    TASK BODY Medico IS
        res:string;
    BEGIN
        LOOP
            SELECT 
                WHEN(atencion'count=0) ACCEPT atenderEnfermera(res:OUT string) IS
                    respuestaEnfermera(res);
                END atenderEnfermera;
                OR ACCEPT atencion();
                ELSE
                    SELECT Consultorio.siguienteNota() IS
                        ACCEPT procesarNota(id:in integer; peticion:in string) IS
                            procesar(peticion, res);
                            enfermeras(id).respuestaNota(res);
                        END procesarNota;
                    ELSE
                        NULL;
                    END SELECT;
            END SELECT;
        END LOOP;
    END Medico;

    TASK BODY Enfermera IS
        id:integer;
        peticion:string;
        res:string;
    BEGIN

        ACCEPT Identificacion(aux:IN integer) IS
            id:=aux;
        END Identificacion;
        LOOP
            //TRABAJAR
            SELECT Medico.atenderEnfermera(res);
            ELSE
                peticion:=...;
                Consultorio.dejarNota(id, peticion);
            END SELECT;

            SELECT ACCEPT respuestaNota(res:IN string);
            ELSE
                NULL;
            END SELECT;
        END LOOP;
    END Enfermera;

    TASK BODY Persona IS
        i:integer;
        atendido:bool;
    BEGIN
        i:=0;
        atendido:=False;
        WHILE (i<3 and (not atendido)) LOOP
            SELECT
                Medico.atencion();
                    atendido:=True;
                OR DELAY 300
                    NULL;
            ELSE
                DELAY 600;
            END SELECT;
            i:=i+1;
        END LOOP;
    END Persona;

    TASK BODY Consultorio IS
    queue cola;
    BEGIN
        LOOP
            SELECT
                ACCEPT dejarNota(id:IN integer; peticion:IN string) IS
                    push(cola, id, peticion);
                END dejarNota;
                OR ACCEPT siguienteNota() IS
                    medico.procesarNota(pop(cola));
                END siguienteNota;
            END SELECT;
        END LOOP;
    END Consultorio;


i:integer;
BEGIN
    for i:=1 to E LOOP
        enfermeras(i).identificacion(i);
    END LOOP;
END Ejercicio4;