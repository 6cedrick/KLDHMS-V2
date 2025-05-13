-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2025 at 01:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kldmas`
--

-- --------------------------------------------------------

--
-- Table structure for table `apointment`
--

CREATE TABLE `apointment` (
  `Apointment_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `doctor_name` varchar(255) NOT NULL,
  `booked_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DepartmentID` int(11) NOT NULL,
  `DepartmentName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctor_accounts`
--

CREATE TABLE `doctor_accounts` (
  `doctor_id` int(11) NOT NULL,
  `KldEmail` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('active','inactive','pending') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_accounts`
--

INSERT INTO `doctor_accounts` (`doctor_id`, `KldEmail`, `password`, `status`, `created_at`) VALUES
(1, '41@kld.edu.ph', '1234', 'active', '2025-05-08 16:00:41');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_infos`
--

CREATE TABLE `doctor_infos` (
  `profile_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `F_Name` varchar(255) NOT NULL,
  `L_Name` varchar(255) NOT NULL,
  `Dfull_name` varchar(255) NOT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `License_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_infos`
--

INSERT INTO `doctor_infos` (`profile_id`, `doctor_id`, `F_Name`, `L_Name`, `Dfull_name`, `specialization`, `License_ID`) VALUES
(1, 1, 'Tung tung', 'sahur', 'Tung tung sahur', NULL, '12341');

-- --------------------------------------------------------

--
-- Table structure for table `useraccount`
--

CREATE TABLE `useraccount` (
  `UserID` int(11) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `KldEmail` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `useraccount`
--

INSERT INTO `useraccount` (`UserID`, `Password`, `KldEmail`) VALUES
(1, '1234', '12@kld.edu.ph'),
(2, '1234', '14@kld.edu.ph');

-- --------------------------------------------------------

--
-- Table structure for table `userinfo`
--

CREATE TABLE `userinfo` (
  `InfoID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `F_Name` varchar(50) DEFAULT NULL,
  `L_Name` varchar(50) DEFAULT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `KldID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userinfo`
--

INSERT INTO `userinfo` (`InfoID`, `UserID`, `F_Name`, `L_Name`, `FullName`, `Age`, `KldID`) VALUES
(1, 1, 'John Louie', 'Yaneza', 'John Louie Yaneza', 19, '12341'),
(2, 2, 'ced', 'lumaad', 'ced lumaad', 19, '513123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DepartmentID`);

--
-- Indexes for table `doctor_accounts`
--
ALTER TABLE `doctor_accounts`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `email` (`KldEmail`);

--
-- Indexes for table `doctor_infos`
--
ALTER TABLE `doctor_infos`
  ADD PRIMARY KEY (`profile_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `useraccount`
--
ALTER TABLE `useraccount`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `userinfo`
--
ALTER TABLE `userinfo`
  ADD PRIMARY KEY (`InfoID`),
  ADD KEY `UserID` (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `DepartmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctor_accounts`
--
ALTER TABLE `doctor_accounts`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `doctor_infos`
--
ALTER TABLE `doctor_infos`
  MODIFY `profile_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `useraccount`
--
ALTER TABLE `useraccount`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `userinfo`
--
ALTER TABLE `userinfo`
  MODIFY `InfoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctor_infos`
--
ALTER TABLE `doctor_infos`
  ADD CONSTRAINT `doctor_infos_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_accounts` (`doctor_id`) ON DELETE CASCADE;

--
-- Constraints for table `userinfo`
--
ALTER TABLE `userinfo`
  ADD CONSTRAINT `userinfo_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `useraccount` (`UserID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
