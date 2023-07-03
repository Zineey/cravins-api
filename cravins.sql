-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2023 at 03:58 PM
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
-- Database: `cravins`
--
CREATE DATABASE IF NOT EXISTS `cravins` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cravins`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`202011014`@`localhost` PROCEDURE `authLogin` (IN `var_username` VARCHAR(50))   SELECT * FROM tbl_accounts WHERE fld_username=var_username$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `changePass` (IN `var_username` VARCHAR(50), IN `var_password` VARCHAR(100))   UPDATE tbl_accounts SET 
    fld_password = var_password
WHERE fld_username = var_username$$

CREATE DEFINER=`202011014`@`localhost` PROCEDURE `createAccount` (IN `var_userid` VARCHAR(10), IN `var_fname` VARCHAR(50), IN `var_mname` VARCHAR(50), IN `var_lname` VARCHAR(50), IN `var_extname` VARCHAR(4), IN `var_street` TEXT, IN `var_brgy` TEXT, IN `var_city` TEXT, IN `var_province` TEXT, IN `var_bdate` DATE, IN `var_email` VARCHAR(50), IN `var_sex` TINYINT(1), IN `var_username` VARCHAR(50), IN `var_password` VARCHAR(100), IN `var_role` TINYINT(1))   BEGIN
	DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
    	ROLLBACK;
    END;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	ROLLBACK;
    END;
    
	START TRANSACTION;
INSERT INTO tbl_users(fld_userid, fld_fname, fld_mname, fld_lname, fld_extname, fld_street, fld_brgy, fld_city, fld_province, fld_bdate, fld_email, fld_sex) VALUES (var_userid, var_fname, var_mname, var_lname, var_extname, var_street, var_brgy, var_city, var_province, var_bdate, var_email, var_sex);

		INSERT INTO tbl_accounts(fld_userid, fld_username, fld_password, fld_role) VALUES (var_userid, var_username, var_password, var_role);
    COMMIT;
END$$

CREATE DEFINER=`202011014`@`localhost` PROCEDURE `createDish` (IN `var_userid` VARCHAR(10), IN `var_dishid` VARCHAR(10), IN `var_image` LONGBLOB, IN `var_dishname` VARCHAR(100), IN `var_recipes` TEXT, IN `var_coursetype` TINYINT(1))   BEGIN
	DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
    	ROLLBACK;
    END;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	ROLLBACK;
    END;
    
	START TRANSACTION;
INSERT INTO tbl_dishes(fld_userid, fld_dishid, fld_image, fld_dishname, fld_recipes, fld_coursetype) VALUES (var_userid, var_dishid, var_image, var_dishname, var_recipes, var_coursetype);
    COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDish` (IN `var_dishid` VARCHAR(10))   DELETE FROM tbl_dishes WHERE fld_dishid = var_dishid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUserData` (IN `var_userid` INT)   BEGIN
    START TRANSACTION;

    -- Delete from tbl_users
    DELETE FROM tbl_users WHERE fld_userid = var_userid;

    -- Delete from tbl_accounts
    DELETE FROM tbl_accounts WHERE fld_userid = var_userid;
    
        -- Delete from tbl_dishes
    DELETE FROM tbl_dishes WHERE fld_userid = var_userid;

    COMMIT;
END$$

CREATE DEFINER=`202011014`@`localhost` PROCEDURE `getDishByName` (IN `var_dishname` VARCHAR(100))   BEGIN
SELECT * FROM tbl_dishes WHERE LOWER(fld_dishname) LIKE CONCAT('%', LOWER(var_dishname), '%');
END$$

CREATE DEFINER=`202011014`@`localhost` PROCEDURE `getDishByRecipe` (IN `var_recipes` VARCHAR(100))   BEGIN
SELECT * FROM tbl_dishes WHERE LOWER(fld_recipes) LIKE CONCAT('%', LOWER(var_recipes), '%');
END$$

CREATE DEFINER=`202011014`@`localhost` PROCEDURE `getDishes` ()   BEGIN
SELECT * from tbl_dishes;
END$$

CREATE DEFINER=`202011014`@`localhost` PROCEDURE `getUser` (IN `var_userid` VARCHAR(10))   BEGIN
SELECT * FROM tbl_users where fld_userid = var_userid;
END$$

CREATE DEFINER=`202011014`@`localhost` PROCEDURE `getUsers` ()   SELECT * FROM tbl_users$$

CREATE DEFINER=`202011014`@`localhost` PROCEDURE `updateDish` (IN `var_dishid` VARCHAR(10), IN `var_image` LONGBLOB, IN `var_dishname` VARCHAR(100), IN `var_recipes` TEXT, IN `var_coursetype` TINYINT(1))   BEGIN
UPDATE tbl_dishes SET fld_image= var_image, fld_dishname= var_dishname, fld_recipes = var_recipes ,fld_coursetype = var_coursetype WHERE fld_dishid= var_dishid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUser` (IN `var_userid` VARCHAR(10), IN `var_fname` VARCHAR(50), IN `var_mname` VARCHAR(50), IN `var_lname` VARCHAR(50), IN `var_extname` VARCHAR(4), IN `var_street` TEXT, IN `var_brgy` TEXT, IN `var_city` TEXT, IN `var_province` TEXT, IN `var_bdate` DATE, IN `var_email` VARCHAR(100), IN `var_sex` TINYINT(1))   BEGIN
UPDATE tbl_users SET fld_fname=var_fname, fld_mname=var_mname, fld_lname=var_lname, fld_extname= var_extname, fld_street= var_street, fld_brgy = var_brgy, fld_city= var_city, fld_province = var_province, fld_bdate = var_bdate, fld_email=var_email,fld_sex= var_sex WHERE fld_userid= var_userid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_accounts`
--

CREATE TABLE `tbl_accounts` (
  `fld_userid` varchar(10) NOT NULL,
  `fld_username` varchar(50) NOT NULL,
  `fld_password` varchar(100) NOT NULL,
  `fld_role` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_accounts`
--

INSERT INTO `tbl_accounts` (`fld_userid`, `fld_username`, `fld_password`, `fld_role`) VALUES
('69', 'crlramos_', 'newerpassword', 1),
('420', 'username1', 'thisisapass', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_dishes`
--

CREATE TABLE `tbl_dishes` (
  `fld_userid` varchar(10) NOT NULL,
  `fld_dishid` varchar(10) NOT NULL,
  `fld_image` longblob NOT NULL,
  `fld_dishname` varchar(100) NOT NULL,
  `fld_recipes` text NOT NULL COMMENT 'Comma Separated ',
  `fld_coursetype` tinyint(1) NOT NULL COMMENT '0 = Breakfast, 1 = Lunch, 2 = Dinner'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_dishes`
--

INSERT INTO `tbl_dishes` (`fld_userid`, `fld_dishid`, `fld_image`, `fld_dishname`, `fld_recipes`, `fld_coursetype`) VALUES
('69', '1', 0x6c696e6b6469746f6b756e77617269, 'Mas Pinaangas na Shabo', 'Maraming Shabo', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `fld_userid` varchar(10) NOT NULL,
  `fld_fname` varchar(50) NOT NULL,
  `fld_mname` varchar(50) NOT NULL,
  `fld_lname` varchar(50) NOT NULL,
  `fld_extname` varchar(4) NOT NULL,
  `fld_street` text NOT NULL,
  `fld_brgy` text NOT NULL,
  `fld_city` text NOT NULL,
  `fld_province` text NOT NULL,
  `fld_bdate` date NOT NULL,
  `fld_email` varchar(100) NOT NULL,
  `fld_sex` tinyint(1) NOT NULL COMMENT '1 = Male, 0 = Female'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`fld_userid`, `fld_fname`, `fld_mname`, `fld_lname`, `fld_extname`, `fld_street`, `fld_brgy`, `fld_city`, `fld_province`, `fld_bdate`, `fld_email`, `fld_sex`) VALUES
('69', 'John Carlo', 'Dador', 'Ramos', 'Jr', 'Jasmin', 'Sta Rita', 'Olongapo', 'Zambales', '2002-03-08', '202011014@gordoncollege.edu.ph', 1),
('420', 'Carlo John', 'Dorda', 'MosRa', 'Sr', 'Jasmin', 'Santa Rita', 'Olongapo', 'Zambales', '2002-03-12', 'test@gmail.com', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
