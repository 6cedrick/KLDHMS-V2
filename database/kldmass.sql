-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2025 at 01:58 PM
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
-- Database: `kldmass`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `doctor_name` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `Day` varchar(255) NOT NULL,
  `time_slot` varchar(50) NOT NULL,
  `status` varchar(20) DEFAULT 'Booked'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`book_id`, `user_id`, `doctor_name`, `date`, `Day`, `time_slot`, `status`) VALUES
(4, 8, 'Dr. Strange Lumaad', '2025-05-18', 'Monday', '7:00am to 10:00am', 'Confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `completedbookings`
--

CREATE TABLE `completedbookings` (
  `booking_id` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `profile_id` varchar(100) NOT NULL,
  `time_slot` varchar(50) DEFAULT NULL,
  `completion_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `DepartmentID` int(11) DEFAULT NULL
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
(2, 'piddidy@kld.edu.ph', '123', 'active', '2025-05-13 09:56:58'),
(3, 'kd@kld.edu.ph', '123', 'active', '2025-05-19 08:35:39'),
(4, '09@kld.edu.ph', '123', 'active', '2025-05-19 10:21:55'),
(6, '08@kld.edu.ph', '123', 'active', '2025-05-19 10:28:04'),
(7, 'lt@kld.edu.ph', '1234', 'active', '2025-05-19 10:31:38'),
(8, 'jp@kld.edu.ph', '1234', 'active', '2025-05-19 10:34:38'),
(11, 'mc@kld.edu.ph', '123', 'active', '2025-05-19 11:18:57');

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
  `DepartmentID` int(11) DEFAULT NULL,
  `specialization` int(11) NOT NULL,
  `License_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_infos`
--

INSERT INTO `doctor_infos` (`profile_id`, `doctor_id`, `F_Name`, `L_Name`, `Dfull_name`, `DepartmentID`, `specialization`, `License_ID`) VALUES
(3, 6, 'Cedrick', 'Garcia', 'Cedrick Garcia', NULL, 1, '123143'),
(4, 7, 'Strange ', 'Lumaad', 'Strange  Lumaad', NULL, 1, '909211'),
(5, 8, 'Joseph ', 'Pujante', 'Joseph  Pujante', NULL, 1, '231512'),
(7, 11, 'terrence', 'maceda', 'terrence maceda', NULL, 2, '9023');

-- --------------------------------------------------------

--
-- Table structure for table `ongoingbookings`
--

CREATE TABLE `ongoingbookings` (
  `booking_id` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `profile_id` varchar(100) NOT NULL,
  `time_slot` varchar(50) DEFAULT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `DepartmentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `specializations`
--

CREATE TABLE `specializations` (
  `SpecializationID` int(11) NOT NULL,
  `SpecializationName` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `specializations`
--

INSERT INTO `specializations` (`SpecializationID`, `SpecializationName`) VALUES
(1, 'Neurologist'),
(2, 'Unassigned');

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
(1, '12345', '12@kld.edu.ph'),
(2, '1234', '14@kld.edu.ph'),
(4, '123', '12@kld.edu.ph'),
(8, '123', 'cc@kld.edu.ph'),
(10, '1234', 'jpujantejr@kld.edu.ph');

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
(1, 1, 'John Louie', 'sahur', 'John Louie Yaneza', 19, '12341'),
(2, 2, 'ced', 'lumaad', 'ced lumaad', 19, '513123'),
(4, 4, 'Joshua ', 'Garcia', 'Joshua  Garcia', 19, '123213'),
(8, 8, 'ced', 'garcia', 'ced garcia', 19, '1231321'),
(10, 10, 'Joseph', 'Pujante', 'Joseph Pujante', 19, '2024-01-0001314');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `completedbookings`
--
ALTER TABLE `completedbookings`
  ADD PRIMARY KEY (`booking_id`);

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
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `FK_doctor_infos_department` (`DepartmentID`),
  ADD KEY `fk_specialization` (`specialization`);

--
-- Indexes for table `ongoingbookings`
--
ALTER TABLE `ongoingbookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `fk_department` (`DepartmentID`);

--
-- Indexes for table `specializations`
--
ALTER TABLE `specializations`
  ADD PRIMARY KEY (`SpecializationID`);

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
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `completedbookings`
--
ALTER TABLE `completedbookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `DepartmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctor_accounts`
--
ALTER TABLE `doctor_accounts`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `doctor_infos`
--
ALTER TABLE `doctor_infos`
  MODIFY `profile_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `ongoingbookings`
--
ALTER TABLE `ongoingbookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `specializations`
--
ALTER TABLE `specializations`
  MODIFY `SpecializationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `useraccount`
--
ALTER TABLE `useraccount`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `userinfo`
--
ALTER TABLE `userinfo`
  MODIFY `InfoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `useraccount` (`UserID`) ON DELETE CASCADE;

--
-- Constraints for table `doctor_infos`
--
ALTER TABLE `doctor_infos`
  ADD CONSTRAINT `FK_doctor_infos_department` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`DepartmentID`),
  ADD CONSTRAINT `doctor_infos_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_accounts` (`doctor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_specialization` FOREIGN KEY (`specialization`) REFERENCES `specializations` (`SpecializationID`);

--
-- Constraints for table `ongoingbookings`
--
ALTER TABLE `ongoingbookings`
  ADD CONSTRAINT `fk_department` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`DepartmentID`);

--
-- Constraints for table `userinfo`
--
ALTER TABLE `userinfo`
  ADD CONSTRAINT `userinfo_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `useraccount` (`UserID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
