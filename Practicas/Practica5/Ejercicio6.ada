Procedure Ejercicio6 IS

TASK TYPE Persona IS
    ENTRY Identificacion(ident, num: IN integer);
    ENTRY Barrera();
END Persona;

TASK Admin IS
    ENTRY Llegada(id, num_grupo: IN integer, ultimo: OUT bool);
    ENTRY ReportarMonedas(num_grupo, monedas: IN integer);
    ENTRY GrupoGanador(num: IN integer);
END Admin;


TASK BODY Persona IS
    num_grupo, id, i, monedas, ganador: integer;
    bool ultimo;
BEGIN
    ACCEPT Identificacion(ident, num: IN integer) IS
        id := ident;
        num_grupo := num;
    END Identificacion;
    Admin.Llegada(id, num_grupo, ultimo);
    SELECT WHEN(not ultimo) ACCEPT Barrera(); END SELECT;

    monedas := 0;

    FOR i:= 1 TO 15 LOOP
        monedas := monedas + Moneda();
    END LOOP;

    Admin.ReportarMonedas(num_grupo, monedas);
    Admin.GrupoGanador(ganador: IN integer);
END Persona;


personas = ARRAY(1..U) OF Persona;


TASK BODY Admin IS
    tot_monedas[5], listos[5], terminaron, i, ganador : integer;
    colas[5]: queue(integer);
BEGIN
    tot_monedas[:] := 0; listos[:] := 0; terminaron := 0;

    WHILE(terminaron < 20)LOOP
        SELECT
            ACCEPT Llegada(id, num_grupo: IN integer, ultimo: OUT bool) IS
                listos[num_grupo] := listos[num_grupo] + 1;
                
                IF(listos[num_grupo] = 4)THEN IS
                    FOR i:= 1 to 3 LOOP
                        personas(pop(colas[num_grupo])).Barrera();
                    END LOOP;
                    ultimo := true;
                ELSE
                    push(colas[num_grupo], id); ultimo := false;
                END IF;
            END Llegada;
            OR ACCEPT ReportarMonedas(num_grupo, monedas: IN integer) IS
                tot_monedas[num_grupo] := tot_monedas[num_grupo] + monedas;
                terminaron := terminaron + 1;
            END ReportarMonedas;
        END SELECT;
    END LOOP;

    grupoganador := Max(tot_monedas); # Devuelve la posicion del maximo (numero de grupo ganador).
    FOR i:= 1 to 20 LOOP
        ACCEPT GrupoGanador(ganador: OUT integer) IS
            ganador := grupo_ganador;
        END GrupoGanador;
    END LOOP;
END Admin;




    contador: integer;

BEGIN
    contador := 0;
    FOR i:= 1 to 20 LOOP
        personas(i).Identificacion(i, contador % 4);
        contador := contador + 1;
    END LOOP;
END Ejercicio6;