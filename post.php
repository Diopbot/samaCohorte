<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST'){

    $path = __DIR__ . '/database/database.sqlite';
    $pdo = new PDO("sqlite:$path");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $query = $pdo->prepare(
        'INSERT INTO posts (title, body) VALUES (?, ?)'
    );

    $query->execute([ $_POST['title'], $_POST['body'] ]);

    header("Refresh:0");
}
if ($_SERVER['REQUEST_METHOD'] === 'GET'){
    $path = __DIR__ . '/database/database.sqlite';
    $pdo = new PDO('sqlite:'. $path);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

    $query = $pdo->prepare('SELECT * FROM posts');
    $result = $query->execute();

    $datas = $query->fetchAll();
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
        <span>Titre</span>
        <input name="title" type="text">
    </p>
    <p>
        <span>body</span>
        <textarea name="body"></textarea>
    </p>
    <p>
        <button> Envoyer</button>
    </p>
</form>

<div>
    <h1>Liste des posts</h1>
    <?php
    if (empty($datas)){
        echo('Nous n\'avons aucun post pour le moment');
    }
    ?>
    <ul>
        <?php foreach ($datas as $data): ?>
            <li>
                <strong>titre : </strong> <?= $data['title'] ?>
                <strong>body : </strong> <?= $data['body'] ?>
            </li>
        <?php endforeach ?>
    </ul>
</div>

<p>
    <h3>
    Aller vers le <a href="admin.php">admin panel</a> pour supprimer les posts
    </h3>

</p>

</body>
</html>