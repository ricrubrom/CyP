PROCEDURE Ejercicio3 IS

    TASK Especialista IS
        ENTRY llegue(id:IN integer)
        ENTRY devolverObjetos(id:IN integer; objetos:IN list; puntaje:OUT integer)
    END Especialista;

    TASK TYPE Chico IS
        ENTRY identificar(aux:IN integer)
        ENTRY obtenerLista(aux:IN lista)
        ENTRY ganador(idGanador:IN integer)
    END Chico;

    chicos=array(1..N) of Chico

    TASK BODY Especialista IS
        lista, objetos:list;
        max, maxId: integer;
    BEGIN
        FOR (i:=1 to 2*N) LOOP
            SELECT
                ACCEPT llegue(id:IN integer) IS
                    generarLista(lista);
                    chicos(i).obtenerLista(lista);
                END llegue;
                OR WHEN (llegue'count=0) ACCEPT devolverObjetos(id:IN integer; objetos:IN list; puntaje:OUT integer) IS
                    DarPuntaje(objetos, puntaje);
                    IF(puntaje>max) THEN
                        max:=puntaje;
                        maxId:=id;
                    END IF
                END devolverObjetos
            END SELECT;
        END LOOP;
        FOR (i:=1 to N) LOOP
            chicos(i).ganador(maxId);
        END LOOP;
    END Especialista;

    TASK BODY Chico IS
    puntaje, id, i:integer;
    lista:list;
    objetos:list;

    BEGIN
        ACCEPT identificar(aux:IN integer) IS
            id:=aux;
        END identificar;

        Especialista.llegue(id);
        ACCEPT obtenerLista(aux:IN lista) IS
            lista:=aux;
        END obtenerLista;

        FOR(i:=1 to 10) LOOP
            buscarElemento(lista, objetos); //Busca el elemento y progresa automatica al siguiente;
        END LOOP

        Especialista.devolverObjetos(id, objetos, puntaje);
        ACCEPT ganador(idGanador:IN integer);
    END Chico;



i:integer;
BEGIN
    FOR(i:=1 to N) LOOP
        chicos(i).identificar(i);
    END LOOP
END Ejercicio3;