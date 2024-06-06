Procedure Ejercicio3 IS

    TASK Central IS
        ENTRY nuevaTemperatura(temp: IN float; dormir: OUT boolean);
    END Central;

    TASK TYPE Controlador;

    controladores=array(1..5) of Controlador;

    TASK BODY Central IS

    BEGIN
        LOOP
            ACCEPT nuevaTemperatura(temp: IN float; dormir: OUT boolean) IS
                IF (temp>40) THEN
                    dormir:=true;
                ELSE
                    dormir:=false;
                END IF
            END nuevaTemperatura;
        END LOOP;
    END Central;

    TASK BODY Controlador IS
    temp:integer;
    dormir:boolean;
    BEGIN
        dormir:=false;
        LOOP
            IF (dormir) THEN
                DELAY 3600;
            ELSE
                DELAY 600;
            END IF;
            tomarTemperatura(temp);
            Central.nuevaTemperatura(temp, dormir);
        END LOOP;
    END Controlador;


BEGIN
    NULL;
END Ejercicio3;
