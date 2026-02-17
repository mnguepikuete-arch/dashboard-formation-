<?php
// =====================================================
// FICHIER : config/database.php
// TÂCHE 2.1.1 : Configuration de la connexion à la base de données
// =====================================================

// Paramètres de connexion à la base de données
// Ces informations correspondent à votre configuration Laragon
define('DB_HOST', 'localhost');        // Serveur MySQL (localhost avec Laragon)
define('DB_NAME', 'dashboard_formation_wesco'); // Nom de votre base de données
define('DB_USER', 'root');             // Utilisateur MySQL (root par défaut avec Laragon)
define('DB_PASS', '');                 // Mot de passe (vide par défaut avec Laragon)
define('DB_CHARSET', 'utf8mb4');       // Encodage pour supporter les caractères spéciaux

// Variable globale pour stocker la connexion PDO
$pdo = null;

/**
 * Fonction pour établir la connexion à la base de données
 * Utilise PDO (PHP Data Objects) pour une connexion sécurisée
 * @return PDO|null Retourne l'objet PDO ou null en cas d'erreur
 */
function getConnection() {
    global $pdo;
    
    // Si la connexion existe déjà, on la retourne (évite les connexions multiples)
    if ($pdo !== null) {
        return $pdo;
    }
    
    try {
        // DSN (Data Source Name) : chaîne de connexion
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        
        // Options PDO pour optimiser la sécurité et les performances
        $options = [
            // Mode d'erreur : lance des exceptions en cas de problème
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            
            // Mode de récupération par défaut : tableau associatif
            // Les résultats seront sous forme ['nom' => 'Dupont', 'prenom' => 'Jean']
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            
            // Désactive l'émulation des requêtes préparées (plus sécurisé)
            PDO::ATTR_EMULATE_PREPARES   => false,
            
            // Définit le jeu de caractères pour la connexion
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES " . DB_CHARSET
        ];
        
        // Création de la connexion PDO
        $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
        
        return $pdo;
        
    } catch (PDOException $e) {
        // En cas d'erreur de connexion
        // EN PRODUCTION : Logger l'erreur dans un fichier
        // EN DÉVELOPPEMENT : Afficher l'erreur (ce qu'on fait ici)
        
        die("Erreur de connexion à la base de données : " . $e->getMessage());
    }
}

/**
 * Fonction pour fermer la connexion à la base de données
 */
function closeConnection() {
    global $pdo;
    $pdo = null;
}

// Établir automatiquement la connexion quand on inclut ce fichier
$pdo = getConnection();

?>