<?php
// =====================================================
// FICHIER : test_connexion.php
// TÂCHE 2.1.2 : Tester la connexion à la base de données
// ⚠️ FICHIER TEMPORAIRE - À SUPPRIMER après test
// =====================================================

// Inclure le fichier de configuration
require_once 'config/database.php';

?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test de Connexion BDD</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f4f4f4;
        }
        .success {
            background: #d4edda;
            color: #155724;
            padding: 20px;
            border-radius: 5px;
            border: 1px solid #c3e6cb;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 20px;
            border-radius: 5px;
            border: 1px solid #f5c6cb;
        }
        h1 { color: #333; }
        .info {
            background: #d1ecf1;
            color: #0c5460;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>🔌 Test de Connexion à la Base de Données</h1>
    
    <?php
    // Vérifier si la connexion existe
    if ($pdo !== null) {
        echo '<div class="success">';
        echo '<h2>✅ CONNEXION RÉUSSIE !</h2>';
        echo '<p><strong>Serveur :</strong> ' . DB_HOST . '</p>';
        echo '<p><strong>Base de données :</strong> ' . DB_NAME . '</p>';
        echo '<p><strong>Utilisateur :</strong> ' . DB_USER . '</p>';
        echo '<p><strong>Encodage :</strong> ' . DB_CHARSET . '</p>';
        echo '</div>';
        
        // Tester une requête simple
        try {
            // Compter le nombre d'apprenants
            $stmt = $pdo->query("SELECT COUNT(*) as total FROM apprenants");
            $result = $stmt->fetch();
            $nbApprenants = $result['total'];
            
            // Compter le nombre de formations
            $stmt = $pdo->query("SELECT COUNT(*) as total FROM formations");
            $result = $stmt->fetch();
            $nbFormations = $result['total'];
            
            // Compter le nombre d'inscriptions
            $stmt = $pdo->query("SELECT COUNT(*) as total FROM inscriptions");
            $result = $stmt->fetch();
            $nbInscriptions = $result['total'];
            
            echo '<div class="info">';
            echo '<h3>📊 Données présentes dans la base :</h3>';
            echo '<ul>';
            echo '<li><strong>Apprenants :</strong> ' . $nbApprenants . '</li>';
            echo '<li><strong>Formations :</strong> ' . $nbFormations . '</li>';
            echo '<li><strong>Inscriptions :</strong> ' . $nbInscriptions . '</li>';
            echo '</ul>';
            echo '</div>';
            
        } catch (PDOException $e) {
            echo '<div class="error">';
            echo '<h3>❌ Erreur lors de la lecture des données</h3>';
            echo '<p>' . $e->getMessage() . '</p>';
            echo '</div>';
        }
        
    } else {
        echo '<div class="error">';
        echo '<h2>❌ ÉCHEC DE LA CONNEXION</h2>';
        echo '<p>Impossible de se connecter à la base de données.</p>';
        echo '<p>Vérifiez vos paramètres dans <code>config/database.php</code></p>';
        echo '</div>';
    }
    ?>
    
    <div class="info" style="margin-top: 30px;">
        <h3>⚠️ IMPORTANT</h3>
        <p><strong>Supprimez ce fichier après le test pour des raisons de sécurité !</strong></p>
        <p>Ce fichier ne doit JAMAIS être déployé en production.</p>
    </div>
    
</body>
</html>