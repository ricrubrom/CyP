Procedure Ejercicio5 IS

    TASK servidor IS
        ENTRY correcion(tp: IN String; errores: OUT bool);
    END servidor;

    TASK TYPE usuario;

    usuarios: array(1..U) of usuario;

    TASK BODY servidor IS
    BEGIN
        LOOP
            ACCEPT correccion(tp: IN String; errores: OUT bool) IS
                corregir(tp, errores);
            END correcion;
        END LOOP;
    END servidor;

    TASK BODY usuario IS
        errores, terminado:bool;
        tp:string;
    BEGIN
        errores:=true;
        terminado:=false;
        while(not terminado) LOOP
            IF(errores) THEN
                //Trabaja
            SELECT 
                servidor.errores(tp, errores);
                    terminado:=not errores;
                OR DELAY 120;
                    DELAY 60;
                    errores:=false;
            END SELECT;
        END LOOP;
    END usuario;

BEGIN
    NULL;
END Ejercicio5;