-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2022 at 06:04 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `work-simulation-project`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllRankingSystems` ()   SELECT * FROM ranking_system$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllUniversities` (IN `countryId` INT)  DETERMINISTIC SELECT * FROM university
WHERE country_id = countryId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showNumOfStudents` (IN `universityId` INT, IN `universityYear` INT)   SELECT num_students FROM university_year
WHERE university_id = universityId
AND 
university_year = universityYear$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showTopUniversity` (IN `yearNum` INT, IN `criteriaName` VARCHAR(50))  DETERMINISTIC SELECT * FROM university_ranking_year
INNER JOIN university ON university_ranking_year.university_id 
INNER JOIN ranking_criteria ON university_ranking_year.ranking_criteria_id
WHERE year = yearNum
AND
criteria_name = criteriaName
ORDER BY score DESC
LIMIT 1$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `Id` int(11) NOT NULL,
  `country_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ranking_criteria`
--

CREATE TABLE `ranking_criteria` (
  `Id` int(11) NOT NULL,
  `ranking_system_id` int(11) NOT NULL,
  `criteria_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ranking_system`
--

CREATE TABLE `ranking_system` (
  `Id` int(11) NOT NULL,
  `system_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `university`
--

CREATE TABLE `university` (
  `Id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `university_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `university_ranking_year`
--

CREATE TABLE `university_ranking_year` (
  `university_id` int(11) NOT NULL,
  `ranking_criteria_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `university_year`
--

CREATE TABLE `university_year` (
  `university_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `num_students` int(11) NOT NULL,
  `student_staff_ratio` int(11) NOT NULL,
  `pct_international_students` int(11) NOT NULL,
  `pct_female_students` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `ranking_criteria`
--
ALTER TABLE `ranking_criteria`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `ranking_system_id` (`ranking_system_id`);

--
-- Indexes for table `ranking_system`
--
ALTER TABLE `ranking_system`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `university`
--
ALTER TABLE `university`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `foreign-key` (`country_id`);

--
-- Indexes for table `university_ranking_year`
--
ALTER TABLE `university_ranking_year`
  ADD KEY `university_id` (`university_id`),
  ADD KEY `ranking_criteria_id` (`ranking_criteria_id`);

--
-- Indexes for table `university_year`
--
ALTER TABLE `university_year`
  ADD KEY `university_id` (`university_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ranking_criteria`
--
ALTER TABLE `ranking_criteria`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ranking_system`
--
ALTER TABLE `ranking_system`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `university`
--
ALTER TABLE `university`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ranking_criteria`
--
ALTER TABLE `ranking_criteria`
  ADD CONSTRAINT `ranking_criteria_ibfk_1` FOREIGN KEY (`ranking_system_id`) REFERENCES `ranking_system` (`Id`);

--
-- Constraints for table `university`
--
ALTER TABLE `university`
  ADD CONSTRAINT `foreign-key` FOREIGN KEY (`country_id`) REFERENCES `country` (`Id`);

--
-- Constraints for table `university_ranking_year`
--
ALTER TABLE `university_ranking_year`
  ADD CONSTRAINT `university_ranking_year_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`Id`),
  ADD CONSTRAINT `university_ranking_year_ibfk_2` FOREIGN KEY (`ranking_criteria_id`) REFERENCES `ranking_criteria` (`Id`);

--
-- Constraints for table `university_year`
--
ALTER TABLE `university_year`
  ADD CONSTRAINT `university_year_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
