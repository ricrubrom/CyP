Procedure Ejercicio3 IS

    TASK Central IS
        ENTRY Señal1(señal: IN Señal)
        ENTRY Señal2(señal: IN Señal)
    END Central;

    TASK Proceso1;
    TASK Proceso2;

    TASK BODY Central IS
        señal:Señal;
    BEGIN
        ACCEPT Señal1(señal: IN Señal) IS
            Procesar(señal);
        END Señal1;
        LOOP
            SELECT 
                WHEN(PasoTiempo()) ACCEPT Señal1(señal: IN Señal) IS
                    Procesar(señal);
                END;
                OR ACCEPT Señal2(señal: IN Señal) IS
                    Procesar(señal);
                    if(PasoTiempo()) then
                        ActivarClock(180);
                END;
        END LOOP;
    END Central;

    TASK BODY Proceso1 IS
        señal: Señal;
    BEGIN
        LOOP
            ProducirSeñal(señal);
            SELECT Central.Señal1(señal);
            OR DELAY 120
                NULL;
            END SELECT;
        END LOOP;
    END Proceso1;

    TASK BODY Proceso2 IS
        señal: Señal;
    BEGIN
        ProducirSeñal(señal);
        LOOP
            SELECT Central.Señal1(señal);
                ProducirSeñal(señal);
            ELSE
                DELAY 60;
            END SELECT;
        END LOOP;
    END Proceso2;

END Ejercicio3;