Procedure Ejercicio7 IS


TASK TYPE Servidor;

servidores = ARRAY(1..8) OF Servidor;

TASK Especialista
    ENTRY EntregarHuella(test: IN imagen);
    ENTRY Resultado(codigo, valor: IN integer);
END Especialista;


TASK BODY Especialista IS
    test_act: imagen;
    i, codigo_max, valor_max: integer;
BEGIN
    LOOP
        codigo_max := -1; valor_max := -1;
        test_act := ...;

        FOR i IN 1..16 LOOP
            SELECT
                ACCEPT EntregarHuella(test: IN imagen) IS
                    test := test_act;
                END EntregarHuella;
            OR
                ACCEPT Resultado(codigo, valor: IN integer) IS
                    IF(valor > valor_max)THEN IS
                        valor_max := valor;
                        codigo_max := codigo;
                    END IF;
                END Resultado;
            END SELECT;
        END LOOP;
    END LOOP;
END Especialista;


TASK BODY Servidor IS
    test: imagen;
    i, codigo_act, valor_act: integer;
BEGIN
    LOOP
        Especialista.EntregarHuella(test);
        Buscar(test, codigo, valor);
        Especialista.Resultado(codigo, valor);
    END LOOP;
END Servidor;


BEGIN
    NULL;
END Ejercicio7;