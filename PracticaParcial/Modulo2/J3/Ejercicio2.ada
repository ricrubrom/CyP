Procedure Ejercicio2 IS

    TASK TYPE Sede;

    TASK Central IS
        ENTRY pedirProducto(prodCod:OUT integer)
        ENTRY entregarStock(stock:IN integer)
    END Central;

    sedes=array(1..S) of Sede;

    TASK BODY Sede IS
    prodCod, stock:integer;
    BEGIN
        LOOP
            Central.pedirProducto(prodCod);
            DevolverStock(prodCod, stock);
            Central.entregarStock(stock);
        END LOOP;  
    END Sede;

    TASK BODY Central IS
    cod, totStock:integer;
    BEGIN
        LOOP
            GenerarCodigo(cod);
            totStock[cod]:=0;
            FOR (i:=1 to 2*S) LOOP
                SELECT
                    ACCEPT pedirProducto(prodCod:OUT integer) IS
                        prodCod:=cod;
                    END pedirProducto;
                    OR WHEN(pedirProducto'count=0) ACCEPT entregarStock(stock:IN integer) IS
                        totStock(cod):=totStock(cod) + stock;
                    END pedirProducto;
                END SELECT;
            END LOOP;
            //Imprime modelo y stock
        END LOOP;
    END Central;


BEGIN
    NULL;
END Ejercicio2;