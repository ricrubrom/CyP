PROCEDURE Ejercicio3 IS

    TASK Entrenador IS
        ENTRY llegue(idCancha:OUT integer);
        ENTRY termine();
    END Entrenador;

    TASK TYPE Cancha IS
        ENTRY llegueCancha(idJ);
    END Cancha;

    TASK TYPE jugador IS
        ENTRY identificar(aux:integer);
        ENTRY empezarPartido();
        ENTRY terminarPartido();
        ENTRY despedida();
    END Jugador;

    jugadores=array(1..20) of Jugador;
    canchas=array(1..2) of Cancha;

    TASK BODY Entrenador IS
    i:integer;
    canchaAct:integer;
    BEGIN
        canchaAct:=1;
        FOR(i:=1 to 20) LOOP
            ACCEPT llegue(idCancha:OUT integer) IS
                idCancha:=canchaAct;
            END llegue;
            canchaAct:=canchaAct mod 2 +1
        END LOOP;
        FOR(i:=1 to 20) LOOP
            ACCEPT termine();
        END LOOP;
        DELAY 600
        FOR(i:=1 to 20) LOOP
            jugadores(i).despedida();
        END LOOP;
    END Entrenador;

    TASK BODY Cancha IS
    id, idJ, i:integer;
    arr:array[1..10] of integer;
    BEGIN
        FOR(i:=1 to 10) LOOP
            ACCEPT llegueCancha(idJ) IS
                arr[i]:=idJ;
            END llegueCancha;
        END LOOP;
        FOR(i:=1 to 10) LOOP
            jugadores(arr[i]).empezarPartido();
        END LOOP;
        DELAY 2400;
        FOR(i:=1 to 10) LOOP
            jugadores(arr[i]).terminarPartido();
        END LOOP;
    END Cancha;

    TASK BODY Jugador IS
    idCancha, id:integer;
    BEGIN
        ACCEPT identificar(aux:integer) IS
            id:=aux;
        END identificar;
        Entrenador.llegue(idCancha);
        canchas(idCancha).llegueCancha(id);
        ACCEPT empezarPartido();
        //Juegan
        ACCEPT terminarPartido();
        Entrenador.termine();
        ACCEPT despedida();
    END Jugador;

i:integer;
BEGIN
    FOR (i:=1 to 20) LOOP
        jugadores(i).identificar(i);
    END LOOP;
END Ejercicio3;