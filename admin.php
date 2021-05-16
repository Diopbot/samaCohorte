<?php
$connected = false;
$error = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST'){
    if ( $_POST['user'] === 'admin' &&  $_POST['pasword'] === 'admin'){
        $connected= true;
    }else{
        $error = true;
    }
}

?>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Sama Cohorte -- Admin</title>
</head>
<body>
<?php

if (!$connected){
    echo ('
        <h1>
            Veillez vous identifier pour continuer
        </h1>
        <form method="post" action="">
            <p>
                <span> Login</span>
                <input name="user" type="text">
            </p>
            <p>
                <span> Mot de passe</span>
                <input name="pasword" type="password">
            </p>
            <p>
                <button> Envoyer</button>
            </p>
        </form>
   
    ');
    if ($error){
        echo('
            <em> Mot de passe ou login incorect</em>
        ');
    }
}

else{
    echo('
        <h1>
            Supprimer tous les post
        </h1>
        <p>
            <h3>
                <a href="/database/refresh.php">Supprimer</a>
            </h3>
        </p>
    ');
}

?>


</body>
</html>