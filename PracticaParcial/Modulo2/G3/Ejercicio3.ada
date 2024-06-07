PROCEDURE Ejercicio3 IS

    TASK Servidor IS
        ENTRY pedido(id: IN integer; documento: IN document; color: IN bool);
        ENTRY impresionColor(id:OUT integer; documento:OUT document);
        ENTRY impresionNegro(id:OUT integer; documento:OUT document);
    END Servidor;

    TASK TYPE Cliente IS
        ENTRY finalizado(impresion);
    END Cliente;

    TASK TYPE Impresora IS
        ENTRY identificar(aux:IN string);
    END Impresora;

    clientes:array(1..C) of Cliente;
    impresoras:array(1..2) of Impresora;

    TASK BODY Servidor IS
    colaC:queue;
    colaN:queue;
    BEGIN
        LOOP
            SELECT 
                ACCEPT pedido(id: IN integer; documento: IN document; color: IN bool) IS
                    IF (color) THEN 
                        push(colaC, id, documento);
                    ELSE
                        push(colaN, id, documento);
                    END IF
                END pedido;
                OR WHEN (!empty(colaC) OR !empty(colaN)) ACCEPT impresionColor(id:OUT integer; documento:OUT document) IS
                    IF(!empty(colaC)) THEN
                        pop(colaC, id, documento)
                    ELSE
                        pop(colaN, id, documento)
                    END IF
                END impresionColor;
                OR WHEN(!empty(colaN)) ACCEPT impresionNegro(id:OUT integer; documento:OUT document) IS
                    pop(colaN, id, documento)
                END impresionNegro;
            END SELECT
        END LOOP;
    END Servidor;

    TASK BODY Cliente IS
    color:bool;
    documento:document;
    impresion:papel;
    id:integer;
    BEGIN
        documento:...;
        color:...;
        ACCEPT identificar(aux:IN integer) IS
            id:=aux;
        END identificar;
        Servidor.pedido(id, documento, color);
        ACCEPT finalizado(impresion);
    END Cliente;

    TASK BODY Impresora IS
    id:string;
    impresion:papel;
    idC:integer;
    documento:document;
    BEGIN
        ACCEPT identificar(aux:IN string) IS
            id:=aux;
        END identificar;
        IF(id='color') THEN
            LOOP
                Servidor.impresionColor(idC, documento)
                imprimir(documento, impresion);
                clientes(idC).finalizado(impresion);
            END LOOP;
        ELSE 
            LOOP
                Servidor.impresionNegro(idC, documento)
                imprimir(documento, impresion);
                clientes(idC).finalizado(impresion);
            END LOOP;
        END IF;
    END Impresora;

i:integer;
BEGIN
    FOR (i:=1 to C) LOOP
        clientes(i).identificar(i);
    END LOOP
    impresoras(1).identificar('color');
    impresoras(2).identificar('negro');
END Ejercicio3;