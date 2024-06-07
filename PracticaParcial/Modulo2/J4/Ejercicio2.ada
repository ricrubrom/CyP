PROCEDURE Ejercicio2 IS

    TASK TYPE Lector IS

    END Lector;

    TASK TYPE Escritor IS

    END Escritor;

    TASK Servidor IS

    END Servidor;

    lectores=array(1..L) of Lector;
    escritores=array(1..E) of Escritor;

    TASK BODY Escritor IS
    BEGIN
        LOOP
            SELECT
                Servidor.escribir(peticion)
            ELSE
                DELAY 60;
            END SELECT;
        END LOOP;
    END Escritor;

    TASK BODY Lector IS
    BEGIN
         LOOP
            SELECT
                Servidor.leer()
                    //Usan
                    Servidor.liberarLeer();
            OR DELAY 120
                DELAY 300;
            END SELECT;
        END LOOP;
    END Lector;

    TASK BODY Servidor IS
    leyendo:integer;
    BEGIN
        leyendo:=0;
        LOOP
            SELECT
                WHEN(!leyendo) ACCEPT escribir(peticion:IN txt) IS
                    escribirBase(peticion);
                END escribir;
                ACCEPT leer(peticion:IN txt) IS
                    leyendo++;
                END leer;
                ACCEPT liberarLeer() IS
                    leyendo--;
                END liberarLeer();
            END SELECT;
        END LOOP;
    END Servidor;




BEGIN
    NULL;
END Ejercicio2;