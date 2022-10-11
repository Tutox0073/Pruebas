<?php

$Conection = mysqli_connect("localhost", 'root', '', 'prueba');

if (!isset($_POST['calendar'])){$_POST['calendar']='';}

$sql = "select c.cedula, c.nombre, a.fecha, a.tiempo, a.saldo, car.placa, car.marca from alquileres as a inner join clientes as c inner join carros as car on c.cedula = a.fk_Cliente and car.placa = a.fk_Carro";


?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/styles.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>


    <title>Document</title>
</head>

<body>
    <div class="container">
        <table class="table table-secondary">
            <thead>
                <tr>
                    <td scope="col">Cedula</td>
                    <td scope="col">Nombre</td>
                    <td scope="col">Fecha alquiler</td>
                    <td scope="col">Tiempo Alquilado</td>
                    <td scope="col">Saldo</td>
                    <td scope="col">Placa</td>
                    <td scope="col">Marca</td>
                </tr>
            </thead>
            <tbody class="contenidobusqueda">
                <?php                
                
                    $sqlf= $sql;
             
                
                $result = mysqli_query($Conection, $sqlf);

                while ($mostrar = $result->fetch_array()) {
                ?>

                    <tr>
                        <td scope="row"><?php echo $mostrar['0'] ?></td>
                        <td><?php echo $mostrar['1'] ?></td>
                        <td><?php echo $mostrar['2'] ?></td>
                        <td><?php echo $mostrar['3'] ?></td>
                        <td><?php echo $mostrar['4'] ?></td>
                        <td><?php echo $mostrar['5'] ?></td>
                        <td><?php echo $mostrar['6'] ?></td>
                    </tr>

                <?php
                }
                ?>
            </tbody>
        </table>

    </div>

</body>


</html>