-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 27, 2023 at 03:42 PM
-- Server version: 10.6.5-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stampe_saddek`
--

-- --------------------------------------------------------

--
-- Table structure for table `couleur`
--

DROP TABLE IF EXISTS `couleur`;
CREATE TABLE IF NOT EXISTS `couleur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `couleur`
--

INSERT INTO `couleur` (`id`, `nom`) VALUES
(1, 'Rouge'),
(2, 'Vert'),
(3, 'Bleu'),
(4, 'Noir'),
(5, 'Blanc'),
(6, 'Orange');

-- --------------------------------------------------------

--
-- Table structure for table `enchere`
--

DROP TABLE IF EXISTS `enchere`;
CREATE TABLE IF NOT EXISTS `enchere` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_ajout` timestamp NOT NULL DEFAULT current_timestamp(),
  `debut` date DEFAULT NULL,
  `fin` date DEFAULT NULL,
  `prix_plancher` int(11) DEFAULT NULL,
  `offre_actuel` int(11) DEFAULT NULL,
  `offre_actuel_membre` varchar(50) DEFAULT NULL,
  `quantite_mise` int(11) DEFAULT NULL,
  `a_coup_de_coeur_lord` tinyint(4) DEFAULT NULL,
  `est_enligne` tinyint(4) DEFAULT NULL,
  `titre` varchar(200) NOT NULL,
  `commentaire` mediumtext NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `delais_depasse` tinyint(1) GENERATED ALWAYS AS (current_timestamp() > `fin`) VIRTUAL,
  `pas_commence` tinyint(1) GENERATED ALWAYS AS (current_timestamp() < `debut`) VIRTUAL,
  `valide` tinyint(1) GENERATED ALWAYS AS (current_timestamp() between `debut` and `fin` and `est_enligne` <> 0) VIRTUAL,
  PRIMARY KEY (`id`),
  KEY `fk_enchere_utilisateur1_idx` (`id_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `enchere`
--

INSERT INTO `enchere` (`id`, `date_ajout`, `debut`, `fin`, `prix_plancher`, `offre_actuel`, `offre_actuel_membre`, `quantite_mise`, `a_coup_de_coeur_lord`, `est_enligne`, `titre`, `commentaire`, `id_utilisateur`) VALUES
(2, '2023-01-19 23:44:05', '2023-01-15', '2023-02-25', 500, NULL, NULL, NULL, NULL, 1, 'une auction Russel\'s Stamp', 'consectetur adipisicing elit. Voluptatum cupiditate iste quae mollitia, facilis voluptatibus explicabo, similique officiis asperiores incidunt cumque? Mollitia odio odit non iure qui reiciendis deleniti tenetur!Lorem ipsum dolor, sit amet ', 1),
(3, '2023-01-19 23:44:05', '2023-01-10', '2023-02-22', 1000, NULL, NULL, NULL, 1, 1, 'Juste une enchere', 'juste un petit commentaire', 2),
(4, '2023-01-19 23:44:05', '2023-01-25', '2023-03-21', 100, NULL, NULL, NULL, NULL, 1, 'Wikipedia 45 ', 'Une enchere pour vente de timbres', 2),
(5, '2023-01-21 14:35:46', '2023-01-20', '2023-05-03', 150, 83, 'this is me', 1, 1, 1, 'New auction', 'Pour des raisons personnelles j\'ai décidé de vendre ces timbres de collection', 2);

-- --------------------------------------------------------

--
-- Table structure for table `etat`
--

DROP TABLE IF EXISTS `etat`;
CREATE TABLE IF NOT EXISTS `etat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `etat`
--

INSERT INTO `etat` (`id`, `nom`) VALUES
(1, 'Bon'),
(2, 'Nouveau'),
(3, 'Antic'),
(4, 'Autre');

-- --------------------------------------------------------

--
-- Table structure for table `favoris`
--

DROP TABLE IF EXISTS `favoris`;
CREATE TABLE IF NOT EXISTS `favoris` (
  `date_d_ajout` datetime NOT NULL DEFAULT current_timestamp(),
  `id_utilisateur` int(11) NOT NULL,
  `id_enchere` int(11) NOT NULL,
  UNIQUE KEY `uk_favoris` (`id_utilisateur`,`id_enchere`),
  KEY `fk_favoris_utilisateur1_idx` (`id_utilisateur`),
  KEY `fk_favoris_enchere1_idx` (`id_enchere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favoris`
--

INSERT INTO `favoris` (`date_d_ajout`, `id_utilisateur`, `id_enchere`) VALUES
('2023-01-19 19:58:06', 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
CREATE TABLE IF NOT EXISTS `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fichier` varchar(45) NOT NULL,
  `est_principale` tinyint(1) DEFAULT NULL,
  `id_timbre` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fichier_UNIQUE` (`fichier`),
  KEY `fk_image_timbre_idx` (`id_timbre`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`id`, `fichier`, `est_principale`, `id_timbre`) VALUES
(1, '/images/8224654344.jpg', 0, 11),
(27, '/images/9598658496.png', 1, 11),
(28, '/images/8941544512.png', 0, 11),
(32, '/images/9894562584.png', 0, 11),
(41, '/images/8305219874.webp', 0, 11),
(42, '/images/7854271395.webp', 0, 11),
(43, '/images/4121249337.webp', 0, 5),
(45, '/images/4588683054.webp', 0, 4),
(46, '/images/2224497002.webp', 0, 5),
(48, '/images/9944140913.webp', 0, 4),
(50, '/images/7645843555.webp', 1, 5),
(51, '/images/4594551764.webp', 0, 5),
(52, '/images/7531838861.webp', 0, 5),
(53, '/images/9349094055.webp', 0, 5),
(54, '/images/8512633539.webp', 0, 5),
(58, '/images/2898247368.png', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `mise`
--

DROP TABLE IF EXISTS `mise`;
CREATE TABLE IF NOT EXISTS `mise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `valeur` int(11) DEFAULT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_enchere` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique utilisateur enchere` (`id_utilisateur`,`id_enchere`),
  KEY `fk_placer_mise_utilisateur1_idx` (`id_utilisateur`),
  KEY `fk_placer_mise_enchere1_idx` (`id_enchere`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mise`
--

INSERT INTO `mise` (`id`, `date`, `valeur`, `id_utilisateur`, `id_enchere`) VALUES
(1, '2023-01-20 14:14:30', 898, 2, 3),
(10, '2023-01-21 17:01:51', 83, 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pays`
--

INSERT INTO `pays` (`id`, `nom`) VALUES
(1, 'Algerie'),
(2, 'Quebec'),
(3, 'Canada'),
(4, 'USA');

-- --------------------------------------------------------

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
CREATE TABLE IF NOT EXISTS `privilege` (
  `id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `privilege`
--

INSERT INTO `privilege` (`id`, `nom`) VALUES
(2, 'Admin'),
(1, 'Régulier');

-- --------------------------------------------------------

--
-- Table structure for table `timbre`
--

DROP TABLE IF EXISTS `timbre`;
CREATE TABLE IF NOT EXISTS `timbre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) NOT NULL,
  `est_principal` tinyint(1) NOT NULL,
  `date_de_creation` date DEFAULT NULL,
  `tirage` int(11) DEFAULT NULL,
  `largeur` int(11) DEFAULT NULL,
  `longueur` int(11) DEFAULT NULL,
  `certifie` tinyint(1) DEFAULT NULL,
  `id_enchere` int(11) NOT NULL,
  `id_etat` int(11) NOT NULL,
  `id_pays` int(11) NOT NULL,
  `id_couleur` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_timbre_enchere1_idx` (`id_enchere`),
  KEY `fk_timbre_etat1_idx` (`id_etat`),
  KEY `fk_timbre_pays1_idx` (`id_pays`),
  KEY `fk_timbre_couleur1` (`id_couleur`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `timbre`
--

INSERT INTO `timbre` (`id`, `nom`, `est_principal`, `date_de_creation`, `tirage`, `largeur`, `longueur`, `certifie`, `id_enchere`, `id_etat`, `id_pays`, `id_couleur`) VALUES
(4, 'some stamp name', 0, '2023-01-18', 2, 120, 180, 1, 4, 3, 1, 1),
(5, 'saddek amir', 1, '2023-01-19', 13, 14, 25, 1, 3, 2, 1, 3),
(11, 'ceci est un timbre', 1, '2023-01-11', 11, 36, 26, 1, 5, 2, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `mot_de_passe` varchar(80) NOT NULL,
  `courriel` varchar(100) NOT NULL,
  `date_inscrit` datetime DEFAULT current_timestamp(),
  `id_privilege` tinyint(4) UNSIGNED DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`courriel`),
  KEY `id_privilege` (`id_privilege`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nom`, `mot_de_passe`, `courriel`, `date_inscrit`, `id_privilege`) VALUES
(1, 'bila', '$2y$10$gvbRe/UI7izIC.Ce0HQLYeFjh8G7pPaXIaakTwcSC5ba95Y0u5CLK', 'bilal2dddd@hotmail.com', NULL, NULL),
(2, 'Elon Musk Not One', '$2y$10$QkEo65s71KX7jlaEhLJ8hOTbYmFZRp51jxjddMvsiduAZddm5LlSG', 'elon@email.net', NULL, NULL),
(3, 'this is me', '$2y$10$pnA3OGYiJltJRs5LcL6ZZexPQRPtNEQ2evcHQnAyMpOrlB/wStNZa', 'this@email.com', '2023-01-21 12:01:18', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `enchere`
--
ALTER TABLE `enchere`
  ADD CONSTRAINT `fk_enchere_utilisateur1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `favoris`
--
ALTER TABLE `favoris`
  ADD CONSTRAINT `fk_favoris_enchere1` FOREIGN KEY (`id_enchere`) REFERENCES `enchere` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_favoris_utilisateur1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `fk_image_timbre` FOREIGN KEY (`id_timbre`) REFERENCES `timbre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mise`
--
ALTER TABLE `mise`
  ADD CONSTRAINT `fk_placer_mise_enchere1` FOREIGN KEY (`id_enchere`) REFERENCES `enchere` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_placer_mise_utilisateur1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `timbre`
--
ALTER TABLE `timbre`
  ADD CONSTRAINT `fk_timbre_couleur1` FOREIGN KEY (`id_couleur`) REFERENCES `couleur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_timbre_enchere1` FOREIGN KEY (`id_enchere`) REFERENCES `enchere` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_timbre_etat1` FOREIGN KEY (`id_etat`) REFERENCES `etat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_timbre_pays1` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `fk_util_privs` FOREIGN KEY (`id_privilege`) REFERENCES `privilege` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
