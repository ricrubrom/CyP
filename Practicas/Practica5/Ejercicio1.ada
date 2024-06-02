a)

Procedure Ejercicio1A is

TASK TYPE Auto;
TASK TYPE Camioneta;
TASK TYPE Camion;

TASK Admin is
    ENTRY PasarAuto();
    ENTRY PasarCamioneta();
    ENTRY PasarCamion();
    ENTRY Finalizado();
END admin;

autos: ARRAY(1..A) OF Auto;
camionetas: ARRAY(1..B) OF Camioneta;
camiones: ARRAY(1..C) OF Camion;

TASK BODY Auto IS
    Admin.PasarAuto();
    // Pasa
    Admin.liberar(1);
END Auto;

TASK BODY Camioneta IS
    Admin.PasarCamioneta();
    // Pasa
    Admin.liberar(2);
END Camioneta;

TASK BODY Camion IS
    Admin.PasarCamion();
    // Pasa
    Admin.liberar(3);
END Camion;

TASK BODY Admin IS
    peso_act, aux:integer;
    queue cola;
Begin
    peso_act:=0;
    LOOP
        SELECT 
            WHEN (peso_act<=4) => PasarAuto() IS
                peso_act:=peso_act + 1;
            END PasarAuto;
            OR (peso_act<=3) => PasarCamioneta() IS
                peso_act:=peso_act + 2;
            END PasarCamioneta;
            OR (peso_act<=2) => PasarCamion() IS
                peso_act:=peso_act + 3;
            END PasarCamion;
            OR (peso_act<=4) => Liberar(aux: IN integer) IS
                peso_act:=peso_act - aux;
            END liberar;
    END LOOP;
END Admin;

Begin
    NULL;
End Ejercicio1A;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
b)

Procedure Ejercicio1B is

TASK TYPE Auto;
TASK TYPE Camioneta;
TASK TYPE Camion;

TASK Admin is
    ENTRY PasarAuto();
    ENTRY PasarCamioneta();
    ENTRY PasarCamion();
    ENTRY Finalizado();
END admin;

autos: ARRAY(1..A) OF Auto;
camionetas: ARRAY(1..B) OF Camioneta;
camiones: ARRAY(1..C) OF Camion;

TASK BODY Auto IS
    Admin.PasarAuto();
    // Pasa
    Admin.liberar(1);
END Auto;

TASK BODY Camioneta IS
    Admin.PasarCamioneta();
    // Pasa
    Admin.liberar(2);
END Camioneta;

TASK BODY Camion IS
    Admin.PasarCamion();
    // Pasa
    Admin.liberar(3);
END Camion;

TASK BODY Admin IS
    peso_act, aux:integer;
    queue cola;
Begin
    peso_act:=0;
    LOOP
        SELECT 
            WHEN (peso_act<=4) and (PasarCamion'count = 0 or Peso_act>=3)  => ACCEPT PasarAuto() IS
                peso_act:=peso_act + 1;
            END PasarAuto;
            OR WHEN (peso_act<=3) and (PasarCamion'count = 0 or Peso_act>=3) => ACCEPT PasarCamioneta() IS
                peso_act:=peso_act + 2;
            END PasarCamioneta;
            OR WHEN (peso_act<=2) => PasarCamion() ACCEPT IS
                peso_act:=peso_act + 3;
            END PasarCamion;
            OR WHEN (peso_act<=4) => Liberar(aux: IN integer) ACCEPT IS
                peso_act:=peso_act - aux;
            END liberar;
    END LOOP;
END Admin;

Begin
    NULL;
End Ejercicio1B;