<?php

$path = __DIR__ . '/database.sqlite';

if (file_exists($path)){
    unlink($path);
}

$pdo = new PDO("sqlite:$path");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$query = $pdo->prepare(
    'CREATE TABLE posts ( 
                    id INTEGER PRIMARY KEY,
                    title VARCHAR(255) NOT NULL,
                     body TEXT NOT NULL
                )'
);
$query->execute();

?>

<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Sama Cohorte -- Supprimer database</title>
</head>
<body>
    <h1>
        Suppression réussit
    </h1>
    <p>
        <a href="../post.php">Retour vers la page post</a>
    </p>
</body>
</html>
