-- ============================================
-- BASE DE DONNÉES : dashboard_formation
-- Date de création : 16 février 2026
-- ============================================

-- Créer la base de données
CREATE DATABASE IF NOT EXISTS dashboard_formation
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Sélectionner la base
USE dashboard_formation;

-- ============================================
-- TABLE 1 : users (Administrateurs)
-- ============================================

CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    UNIQUE KEY unique_username (username),
    UNIQUE KEY unique_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insérer l'administrateur par défaut
-- Username: admin
-- Password: admin (hashé avec bcrypt)
INSERT INTO users (username, password, email) 
VALUES (
    'admin',
    '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    'admin@dashboard.com'
);
```

**Enregistrez (Ctrl + S)**

---

## 🎓 CONCEPTS CLÉS À RETENIR

### 1️⃣ AUTO_INCREMENT

**Comment ça marche ?**
```

Premier INSERT → id = 1 (automatique)
Deuxième INSERT → id = 2 (automatique)
Troisième INSERT → id = 3 (automatique)


-- ============================================
-- TABLE 2 : apprenants 
-- ============================================

CREATE TABLE apprenants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telephone VARCHAR(20),
    date_inscription DATE NOT NULL,
    statut VARCHAR(20) DEFAULT 'actif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================
-- TABLE 3 : formations 
-- ============================================

CREATE TABLE formations (
id INT PRIMARY KEY AUTO_INCREMENT,
titre VARCHAR(255) NOT NULL,
description TEXT,
durees INT NOT NULL,
date_debut DATE NOT NULL,
date_fin DATE NOT NULL 
) ENGINE=InnODB DEFAULT CHARSET=UTF8mb4 COLLATE=UTF8mb4_unicode_ci;

-- ============================================
-- TABLE 4 :inscriptions 
-- ============================================

CREATE TABLE inscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    apprenant_id INT NOT NULL,
    formation_id INT NOT NULL,
    
    -- On enlève le DEFAULT et on mettra la date lors de l'INSERT
    date_inscription DATE NOT NULL,
    
    statut ENUM('en_cours', 'termine', 'abandonne') NOT NULL DEFAULT 'en_cours',
    progression INT DEFAULT 0,
    date_completion DATE NULL,
    
    FOREIGN KEY (apprenant_id) REFERENCES apprenants(id) ON DELETE CASCADE,
    FOREIGN KEY (formation_id) REFERENCES formations(id) ON DELETE CASCADE,
    UNIQUE KEY unique_inscription (apprenant_id, formation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- =====================================================
-- TÂCHE 1.3.2 : Insertion de 10 apprenants fictifs
-- =====================================================

INSERT INTO apprenants (nom, prenom, email, telephone, date_naissance, adresse, ville, code_postal, date_inscription, statut) 
VALUES 
    -- Apprenant 1
    ('Diallo', 'Amadou', 'amadou.diallo@email.com', '+237 6 71 23 45 67', '1995-03-15', 'Rue de la Réunification', 'Douala', '1234', '2024-01-10', 'actif'),
    
    -- Apprenant 2
    ('Nguyen', 'Marie', 'marie.nguyen@email.com', '+237 6 72 34 56 78', '1998-07-22', 'Avenue de la Liberté', 'Douala', '5678', '2024-01-15', 'actif'),
    
    -- Apprenant 3
    ('Kamga', 'Jean', 'jean.kamga@email.com', '+237 6 73 45 67 89', '1992-11-08', 'Boulevard du 20 Mai', 'Douala', '9012', '2024-02-01', 'actif'),
    
    -- Apprenant 4
    ('Fotso', 'Caroline', 'caroline.fotso@email.com', '+237 6 74 56 78 90', '1997-05-30', 'Rue Joffre', 'Douala', '3456', '2024-02-05', 'en_pause'),
    
    -- Apprenant 5
    ('Tchoupi', 'David', 'david.tchoupi@email.com', '+237 6 75 67 89 01', '1994-09-12', 'Avenue Ahidjo', 'Douala', '7890', '2024-02-10', 'actif'),
    
    -- Apprenant 6
    ('Mbala', 'Sophie', 'sophie.mbala@email.com', '+237 6 76 78 90 12', '1999-02-18', 'Rue de Nkongsamba', 'Douala', '2345', '2024-02-12', 'actif'),
    
    -- Apprenant 7
    ('Essomba', 'Patrick', 'patrick.essomba@email.com', '+237 6 77 89 01 23', '1996-12-25', 'Boulevard de la République', 'Douala', '6789', '2024-02-15', 'inactif'),
    
    -- Apprenant 8
    ('Owona', 'Grace', 'grace.owona@email.com', '+237 6 78 90 12 34', '1993-04-07', 'Rue Manga Bell', 'Douala', '1357', '2024-02-18', 'actif'),
    
    -- Apprenant 9
    ('Bella', 'Eric', 'eric.bella@email.com', '+237 6 79 01 23 45', '2000-08-14', 'Avenue Douala Manga Bell', 'Douala', '2468', '2024-02-20', 'actif'),
    
    -- Apprenant 10
    ('Ngo', 'Isabelle', 'isabelle.ngo@email.com', '+237 6 80 12 34 56', '1991-06-03', 'Rue Sylvani', 'Douala', '3579', '2024-02-22', 'en_pause');


    
ALTER TABLE formations 
ADD COLUMN statut ENUM('planifié','en_cours','termine') NOT NULL AFTER date_fin,
ADD COLUMN niveau ENUM('Débutant', 'Intermediaire') NOT NULL AFTER statut,
ADD COLUMN prix INT NOT NULL AFTER niveau,
ADD COLUMN capacite_max INT  NULL AFTER prix;



-- =====================================================
-- TÂCHE 1.3.3 : Insertion de 5 formations fictives
-- =====================================================

INSERT INTO formations (titre, description, duree, date_debut, date_fin, statut, niveau, prix, capacite_max) VALUES

('Développement Web Full Stack', 
 'Formation complète en développement web moderne : HTML, CSS, JavaScript, PHP, MySQL, Bootstrap. Création d\'applications web professionnelles de A à Z.', 
 180, 
 '2024-01-15', 
 '2024-07-15', 
 'en_cours', 
 'Intermédiaire', 
 350000, 
 25),

('Marketing Digital et Réseaux Sociaux', 
 'Maîtrisez les stratégies de marketing digital, SEO, publicité Facebook/Instagram, Google Ads, création de contenu et analyse de données.', 
 90, 
 '2024-03-01', 
 '2024-05-30', 
 'en_cours', 
 'Débutant', 
 200000, 
 30),

('Comptabilité et Gestion Financière', 
 'Formation pratique en comptabilité générale, gestion de trésorerie, analyse financière et utilisation de logiciels comptables (Sage, Ciel).', 
 120, 
 '2024-02-10', 
 '2024-06-10', 
 'en_cours', 
 'Intermédiaire', 
 280000, 
 20),

('Infographie et Design Graphique', 
 'Apprenez Photoshop, Illustrator, InDesign. Création de logos, affiches, supports de communication visuelle et identité de marque.', 
 150, 
 '2023-11-01', 
 '2024-04-01', 
 'termine', 
 'Débutant', 
 250000, 
 18),

('Entrepreneuriat et Gestion d\'Entreprise', 
 'De l\'idée au projet : business plan, étude de marché, gestion administrative, fiscalité, stratégies de croissance et financement.', 
 60, 
 '2024-08-01', 
 '2024-09-30', 
 'planifie', 
 'Débutant', 
 150000, 
 35);

 -- =====================================================
-- TÂCHE 1.3.4 : Insertion d'inscriptions test
-- =====================================================

INSERT INTO inscriptions (apprenant_id, formation_id, date_inscription, statut, progression) VALUES
(1, 1, '2024-01-15', 'en_cours', 45),
(1, 2, '2024-03-10', 'en_cours', 60),
(2, 3, '2024-02-12', 'en_cours', 30),
(3, 1, '2024-02-05', 'en_cours', 50),
(3, 4, '2023-11-05', 'termine', 100),
(5, 2, '2024-03-25', 'en_cours', 70),
(6, 1, '2024-04-08', 'en_cours', 25),
(6, 5, '2024-08-01', 'en_cours', 5),
(8, 3, '2024-05-25', 'en_cours', 40),
(9, 2, '2024-06-15', 'en_cours', 35),
(9, 1, '2024-06-20', 'en_cours', 20),
(10, 5, '2024-08-01', 'en_cours', 10);

-- Inscription avec date de complétion (Paul Tchoumi - diplômé)
INSERT INTO inscriptions (apprenant_id, formation_id, date_inscription, statut, progression, date_completion) VALUES
(4, 4, '2023-11-02', 'termine', 100, '2024-04-01');

-- Inscription abandonnée (André Moukoko)
INSERT INTO inscriptions (apprenant_id, formation_id, date_inscription, statut, progression) VALUES
(10, 4, '2023-11-10', 'abandonne', 15);