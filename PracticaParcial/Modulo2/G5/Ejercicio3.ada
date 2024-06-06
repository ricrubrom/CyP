Procedure Ejercicio3 IS

    TASK Medico IS
        ENTRY espera();
    END Medico;

    TASK TYPE Paciente;

    paciente=array(1..P) of Paciente;

    TASK BODY Medico IS
    atendidos:integer;
    BEGIN
        atendidos:=0
        WHILE (atendidos<N) LOOP
            SELECT
                ACCEPT espera() IS
                    atenderPaciente();
                    atendidos++;
                END espera();
                ELSE DELAY 600;
            END SELECT
        END LOOP
    END Medico;

    TASK BODY Paciente IS
    BEGIN
        Medico.espera();
    END Paciente;

BEGIN
    NULL;
END Ejercicio3;