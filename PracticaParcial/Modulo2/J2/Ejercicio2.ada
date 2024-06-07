Procedure Ejercicio2 IS

    TASK TYPE Sucursal;

    TASK Central IS
        ENTRY pedirProducto(prodId:OUT integer);
        ENTRY darVentas(cant:IN integer);
        ENTRY sigProd();
    END Central;

    sucursales=array(1..100) of Sucursal;

    TASK BODY Sucursal IS
    prodId:integer;
    BEGIN
        LOOP
            Central.pedirProducto(prodId);
            Central.darVentas(ObtenerVentas(prodId));
            Central.sigProd();
        END LOOP;
    END Sucursal;

    TASK BODY Central IS
    prodId, i, ventas:integer;
    BEGIN
        LOOP
            cod:=GenerarArticulo();
            ventas:=0;
            FOR i:=1 to 200 LOOP
                SELECT
                    ACCEPT pedirProducto(prodId:OUT integer) IS
                        prodId:=cod;
                    END pedirProducto;
                    or WHEN(PedirProducto'count=0) ACCEPT darVentas(cant:IN integer)IS
                        ventas:=ventas+cant;
                    END datVentas;
                END SELECT;
            END LOOP;
            FOR i:=1 to 100 LOOP
                ACCEPT sigProd();
            END LOOP;
        END LOOP;
    END Central;



BEGIN
    NULL;
END Ejercicio2;