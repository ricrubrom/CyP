PROCEDURE Ejercicio2 IS

    TASK TYPE Persona;

    TASK Caja IS
        ENTRY prioridad(boletas: IN list of string; dinero:IN float; vuelto:OUT float; recibos:OUT list of string);
        ENTRY menor5(boletas: IN list of string; dinero:IN float; vuelto:OUT float; recibos:OUT list of string);
        ENTRY pago(boletas: IN list of string; dinero:IN float; vuelto:OUT float; recibos:OUT list of string);
    END Caja;

    personas=array(1..P) of Persona;

    TASK BODY Persona IS
    cantBoletas:integer;
    dinero, vuelto:float;
    boletas, recibos:list of string;
    BEGIN
        dinero=...;
        coletas=...;
        cantBoletas=length(boletas);
        IF soyAnciano() OR soyEmbarazada() THEN
            Caja.prioridad(boletas, dinero, vuelto, recibos);
        ELSE IF cantBoletas<5 THEN
            Caja.menor5(boletas, dinero, vuelto, recibos);
        ELSE
            Caja.pago(boletas, dinero, vuelto, recibos);
    END Persona;

    TASK BODY Caja IS

    BEGIN
        LOOP
            SELECT
                WHEN((prioridad'count=0) AND (menor5'count=0)) ACCEPT pago(boletas: IN list of string; dinero:IN float; vuelto:OUT float; recibos:OUT list of string) IS
                    efectuarPago(boletas, dinero, vuelto, recibos);
                END pago;
                OR WHEN((prioridad'count=0)) ACCEPT menor5(boletas: IN list of string; dinero:IN float; vuelto:OUT float; recibos:OUT list of string) IS
                    efectuarPago(boletas, dinero, vuelto, recibos);
                END menor5;
                OR ACCEPT prioridad(boletas: IN list of string; dinero:IN float; vuelto:OUT float; recibos:OUT list of string) IS
                    efectuarPago(boletas, dinero, vuelto, recibos);
                END prioridad;
            END SELECT;
        END LOOP;
    END Caja;

BEGIN
    NULL;
END Ejercicio2;