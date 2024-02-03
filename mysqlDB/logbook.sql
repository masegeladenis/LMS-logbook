-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 03, 2024 at 04:03 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `logbook`
--

-- --------------------------------------------------------

--
-- Table structure for table `assesments`
--

CREATE TABLE `assesments` (
  `id` int(11) NOT NULL,
  `report_id` int(11) DEFAULT NULL,
  `supervisor_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `marks` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assesments`
--

INSERT INTO `assesments` (`id`, `report_id`, `supervisor_id`, `status`, `marks`, `comment`) VALUES
(2, 14, 1, 'ASSESED', 8, 'WEEL DONE');

-- --------------------------------------------------------

--
-- Table structure for table `reportweeks`
--

CREATE TABLE `reportweeks` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `monday_report` varchar(255) DEFAULT NULL,
  `tuesday_report` varchar(255) DEFAULT NULL,
  `wednesday_report` varchar(255) DEFAULT NULL,
  `thursday_report` varchar(255) DEFAULT NULL,
  `friday_report` varchar(255) DEFAULT NULL,
  `date` date DEFAULT current_timestamp(),
  `cloud_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reportweeks`
--

INSERT INTO `reportweeks` (`id`, `student_id`, `monday_report`, `tuesday_report`, `wednesday_report`, `thursday_report`, `friday_report`, `date`, `cloud_link`) VALUES
(13, 43, 'monday', 'tuesday', 'dsghds', 'dbuibiuifc', 'hdsvyusdgc', '0000-00-00', NULL),
(14, 43, 'guyfyuuvui', 'tuhuyfyuvy', 'dsghds', 'dbuibiuifc', 'hdsvyusdgc', '0000-00-00', NULL),
(15, 236, NULL, NULL, NULL, NULL, NULL, '2024-02-03', NULL),
(16, 236, NULL, NULL, NULL, NULL, NULL, '2024-02-03', NULL),
(17, 236, NULL, NULL, NULL, NULL, NULL, '2024-02-03', NULL),
(18, 236, NULL, NULL, '2222', NULL, NULL, '2024-02-03', NULL),
(19, 236, NULL, NULL, NULL, NULL, NULL, '2024-02-03', NULL),
(20, 236, NULL, NULL, NULL, NULL, NULL, '2024-02-03', NULL),
(21, 236, 'jhgfds', NULL, NULL, NULL, NULL, '2024-02-03', NULL),
(22, 236, 'hello', 'fgnbdvs', NULL, NULL, NULL, '2024-02-03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `s_firstname` varchar(255) DEFAULT NULL,
  `s_lastname` varchar(255) DEFAULT NULL,
  `s_regno` varchar(255) DEFAULT NULL,
  `s_password` varchar(255) DEFAULT NULL,
  `s_email` varchar(255) DEFAULT NULL,
  `s_phonenumber` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `s_firstname`, `s_lastname`, `s_regno`, `s_password`, `s_email`, `s_phonenumber`) VALUES
(43, 'AGUU', 'KANII', '2233466433', 'acf4b89d3d503d8252c9c4ba75ddbf6d', 'JA@FFF.COM', '097654321'),
(233, 'ALLY', 'JUMA', '2233466433', 'acf4b89d3d503d8252c9c4ba75ddbf6d', 'JUMA@FFF.COM', '097654321'),
(234, 'jimmy', 'james', '6733333', 'acf4b89d3d503d8252c9c4ba75ddbf6d', 'gddh@bndhd.cim', '0987654456'),
(235, 'ally', 'ally', '7654323', 'acf4b89d3d503d8252c9c4ba75ddbf6d', 'DDJSSJ@BDHD.CHJ', '098765456'),
(236, 'aly', 'sefu', '123456', '123456', 'qq@fff.com', '0987654323456');

-- --------------------------------------------------------

--
-- Table structure for table `supervisors`
--

CREATE TABLE `supervisors` (
  `id` int(11) NOT NULL,
  `Su_firstname` varchar(255) DEFAULT NULL,
  `Su_lastname` varchar(300) DEFAULT NULL,
  `Su_phonenumber` varchar(244) DEFAULT NULL,
  `Su_email` varchar(244) DEFAULT NULL,
  `Su_password` varchar(244) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supervisors`
--

INSERT INTO `supervisors` (`id`, `Su_firstname`, `Su_lastname`, `Su_phonenumber`, `Su_email`, `Su_password`) VALUES
(1, 'allyyy', 'mayai', '234567890', 'rfe@zsds.com', '876543456'),
(2, 'james', 'wwmayai', '234567890', 'rfe@s3444s.com', '876543456');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assesments`
--
ALTER TABLE `assesments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_asse_superv` (`supervisor_id`),
  ADD KEY `fk_asse_repo` (`report_id`);

--
-- Indexes for table `reportweeks`
--
ALTER TABLE `reportweeks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_rep_stu` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supervisors`
--
ALTER TABLE `supervisors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assesments`
--
ALTER TABLE `assesments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reportweeks`
--
ALTER TABLE `reportweeks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT for table `supervisors`
--
ALTER TABLE `supervisors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assesments`
--
ALTER TABLE `assesments`
  ADD CONSTRAINT `fk_asse_repo` FOREIGN KEY (`report_id`) REFERENCES `reportweeks` (`id`),
  ADD CONSTRAINT `fk_asse_superv` FOREIGN KEY (`supervisor_id`) REFERENCES `supervisors` (`id`);

--
-- Constraints for table `reportweeks`
--
ALTER TABLE `reportweeks`
  ADD CONSTRAINT `fk_rep_stu` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
