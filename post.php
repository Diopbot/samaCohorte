<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST'){

    $path = __DIR__ . '/database/database.sqlite';
    $pdo = new PDO("sqlite:$path");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $query = $pdo->prepare(
        'INSERT INTO posts (title, body) VALUES (?, ?)'
    );

    $query->execute([ $_POST['title'], $_POST['body'] ]);
}

?>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>SamaCohorte -- Ecrire un post</title>
</head>
<body>
<h1>
    Ecrire un nouveau post
</h1>

<form method="post" action="">
    <p>
        <input name="title" type="text">
    </p>
    <p>
        <textarea name="body"></textarea>
    </p>
    <p>
        <button> Envoyer</button>
    </p>
</form>

<div>
    <h1>Liste des posts</h1>

</div>

</body>
</html>