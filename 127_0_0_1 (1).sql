-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 19, 2025 at 11:42 AM
-- Server version: 8.0.36-28
-- PHP Version: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `safteyeyegaurd`
--
CREATE DATABASE IF NOT EXISTS `safteyeyegaurd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `safteyeyegaurd`;

-- --------------------------------------------------------

--
-- Table structure for table `blue_light_protection`
--

CREATE TABLE `blue_light_protection` (
  `id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `sub_title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blue_light_protection`
--

INSERT INTO `blue_light_protection` (`id`, `title`, `sub_title`, `image_url`, `price`, `description`, `created_at`, `updated_at`) VALUES
(4, 'No Filter', 'No UV Filter', '/projectimages/lensmanegment/blue_light_protection/1745310479_NO_BLUE_LIGHT_FILTER.svg', 0.00, 'Lenses without blue light protection may expose your eyes to the harmful effects of prolonged screen time. Without this protection, you might experience eye strain, discomfort, or disrupted sleep patterns. For screen-heavy lifestyles, consider lenses with blue light defense.', '2025-04-22 08:27:59', '2025-04-22 08:27:59'),
(5, 'Blue Filter', 'Protect againt harmful blue light', '/projectimages/lensmanegment/blue_light_protection/1745310513_BLUE_FILTER.svg', 45.00, 'Blue light protection lenses are designed to filter out harmful blue light emitted from digital devices such as computers, tablets, and mobile screens. These lenses help reduce eye strain, improve comfort, and protect against long-term damage associated with excessive screen exposure.', '2025-04-22 08:28:33', '2025-04-22 08:28:33');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `category_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `color` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`, `color`) VALUES
(4, 'Construction', 'Construction', 'red2');

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

CREATE TABLE `colors` (
  `color_id` int NOT NULL,
  `color_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `frame_sizes` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `colors`
--

INSERT INTO `colors` (`color_id`, `color_name`, `frame_sizes`) VALUES
(4, '#000000', NULL),
(5, '#ffffff', NULL),
(6, '#ff0000', NULL),
(7, '#fb00ff', NULL),
(8, '#00ff2a', NULL),
(9, '#ff7b00', NULL),
(10, '#c02121', NULL),
(11, '#e01515', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int NOT NULL,
  `company_name` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_logo` text COLLATE utf8mb4_general_ci,
  `company_Information` text COLLATE utf8mb4_general_ci,
  `benefits` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `company_name`, `address`, `phone`, `company_logo`, `company_Information`, `benefits`, `created_at`, `updated_at`) VALUES
(1, 'uni dev', 'xyz', '03174572453', '/projectimages/company_logos/1750263438_Apex_Vibe_healing.png', '<p>xyz	</p>', '<p>xyz</p>', '2025-06-18 16:17:18', '2025-06-18 16:17:18');

-- --------------------------------------------------------

--
-- Table structure for table `company_blue_light_protection_mapper`
--

CREATE TABLE `company_blue_light_protection_mapper` (
  `id` int NOT NULL,
  `blue_light_protection_id` int NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_blue_light_protection_mapper`
--

INSERT INTO `company_blue_light_protection_mapper` (`id`, `blue_light_protection_id`, `company_id`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '2025-06-18 16:19:40', '2025-06-18 16:19:40'),
(2, 5, 1, '2025-06-18 16:19:40', '2025-06-18 16:19:40');

-- --------------------------------------------------------

--
-- Table structure for table `company_lens_material_mapper`
--

CREATE TABLE `company_lens_material_mapper` (
  `id` int NOT NULL,
  `lens_material_id` int NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_lens_material_mapper`
--

INSERT INTO `company_lens_material_mapper` (`id`, `lens_material_id`, `company_id`, `created_at`, `updated_at`) VALUES
(1, 6, 1, '2025-06-18 16:19:14', '2025-06-18 16:19:14'),
(2, 7, 1, '2025-06-18 16:19:14', '2025-06-18 16:19:14'),
(3, 8, 1, '2025-06-18 16:19:14', '2025-06-18 16:19:14');

-- --------------------------------------------------------

--
-- Table structure for table `company_lens_protection_mapper`
--

CREATE TABLE `company_lens_protection_mapper` (
  `id` int NOT NULL,
  `lens_protection_id` int NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_lens_protection_mapper`
--

INSERT INTO `company_lens_protection_mapper` (`id`, `lens_protection_id`, `company_id`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '2025-06-18 16:19:34', '2025-06-18 16:19:34'),
(2, 4, 1, '2025-06-18 16:19:34', '2025-06-18 16:19:34'),
(3, 5, 1, '2025-06-18 16:19:34', '2025-06-18 16:19:34');

-- --------------------------------------------------------

--
-- Table structure for table `company_lens_tint_mapper`
--

CREATE TABLE `company_lens_tint_mapper` (
  `id` int NOT NULL,
  `lens_tint_id` int NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_lens_tint_mapper`
--

INSERT INTO `company_lens_tint_mapper` (`id`, `lens_tint_id`, `company_id`, `created_at`, `updated_at`) VALUES
(1, 6, 1, '2025-06-18 16:23:46', '2025-06-18 16:23:46'),
(2, 7, 1, '2025-06-18 16:23:46', '2025-06-18 16:23:46'),
(3, 8, 1, '2025-06-18 16:23:46', '2025-06-18 16:23:46'),
(4, 9, 1, '2025-06-18 16:23:46', '2025-06-18 16:23:46'),
(5, 10, 1, '2025-06-18 16:23:46', '2025-06-18 16:23:46');

-- --------------------------------------------------------

--
-- Table structure for table `company_product_mapper`
--

CREATE TABLE `company_product_mapper` (
  `id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_product_mapper`
--

INSERT INTO `company_product_mapper` (`id`, `product_id`, `company_id`, `created_at`, `updated_at`) VALUES
(2, 10, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(3, 11, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(4, 12, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(5, 13, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(6, 14, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(7, 16, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(8, 17, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(9, 18, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(10, 19, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(11, 20, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(12, 22, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(13, 23, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(14, 24, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(15, 25, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(16, 26, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(17, 27, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(18, 28, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(19, 29, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(20, 30, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(21, 31, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(22, 33, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(23, 34, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(24, 35, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(25, 36, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(26, 37, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(27, 38, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(28, 39, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(29, 40, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(30, 42, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(31, 43, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(32, 44, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(33, 45, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(34, 46, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(35, 48, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(36, 49, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(37, 51, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(38, 52, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(39, 53, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(40, 54, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(41, 55, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(42, 56, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(43, 57, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(44, 58, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(45, 59, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(46, 60, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(47, 61, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(48, 62, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(49, 63, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(50, 64, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(51, 65, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(52, 66, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(53, 67, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(54, 68, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(55, 69, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(56, 70, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(57, 71, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(58, 72, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(59, 73, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(60, 74, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(61, 75, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(62, 76, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(63, 77, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(64, 78, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(65, 79, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(66, 80, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(67, 81, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(68, 82, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(69, 83, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(70, 84, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(71, 85, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(72, 86, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(73, 87, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(74, 88, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(75, 89, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(76, 90, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(77, 91, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(78, 92, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(79, 93, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(80, 94, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(81, 95, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(82, 96, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(83, 97, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(84, 98, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(85, 99, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(86, 100, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(87, 101, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(88, 102, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(89, 103, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(90, 104, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(91, 105, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(92, 106, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(93, 107, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(94, 108, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(95, 109, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(96, 110, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(97, 111, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(98, 112, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(99, 113, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(100, 114, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(101, 115, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(102, 116, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(103, 117, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(104, 118, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(105, 119, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(106, 120, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(107, 121, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(108, 122, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(109, 123, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(110, 124, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(111, 125, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(112, 126, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(113, 127, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(114, 128, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(115, 129, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(116, 130, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(117, 131, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(118, 132, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(119, 133, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(120, 134, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(121, 135, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(122, 136, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(123, 137, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(124, 138, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(125, 139, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(126, 140, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(127, 141, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(128, 142, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(129, 143, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(130, 144, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(131, 145, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(132, 146, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(133, 147, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(134, 148, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(135, 149, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(136, 150, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(137, 151, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(138, 152, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(139, 153, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(140, 154, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(141, 155, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(142, 156, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(143, 157, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(144, 158, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(145, 159, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(146, 160, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(147, 161, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(148, 162, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(149, 164, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(150, 165, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(151, 166, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(152, 167, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(153, 168, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(154, 169, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(155, 170, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(156, 171, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(157, 172, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(158, 173, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(159, 174, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(160, 175, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(161, 176, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(162, 177, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(163, 178, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(164, 179, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(165, 180, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(166, 181, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(167, 182, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(168, 183, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(169, 184, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(170, 185, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(171, 186, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(172, 187, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50'),
(173, 188, 1, '2025-06-18 16:19:50', '2025-06-18 16:19:50');

-- --------------------------------------------------------

--
-- Table structure for table `company_scratch_coating_mapper`
--

CREATE TABLE `company_scratch_coating_mapper` (
  `id` int NOT NULL,
  `scratch_coating_id` int NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_scratch_coating_mapper`
--

INSERT INTO `company_scratch_coating_mapper` (`id`, `scratch_coating_id`, `company_id`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '2025-06-18 16:23:40', '2025-06-18 16:23:40'),
(2, 4, 1, '2025-06-18 16:23:40', '2025-06-18 16:23:40'),
(3, 5, 1, '2025-06-18 16:23:40', '2025-06-18 16:23:40');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int NOT NULL,
  `phone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `designation` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_id` int NOT NULL,
  `benefit_amount` double DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `ending_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `phone`, `designation`, `status`, `company_id`, `benefit_amount`, `starting_date`, `ending_date`, `created_at`, `updated_at`) VALUES
(1, '7888811', 'hr', '', 1, 129.5, '2025-06-17', '2026-06-17', '2025-06-18 16:20:34', '2025-06-19 07:00:14'),
(2, '322111', 'hr', '', 1, 0, NULL, NULL, '2025-06-18 17:18:26', '2025-06-18 17:18:26');

-- --------------------------------------------------------

--
-- Table structure for table `employee_product_mapper`
--

CREATE TABLE `employee_product_mapper` (
  `id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `employee_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_product_mapper`
--

INSERT INTO `employee_product_mapper` (`id`, `product_id`, `company_id`, `employee_id`, `created_at`) VALUES
(2, 10, 1, 1, '2025-06-18 16:21:38'),
(3, 11, 1, 1, '2025-06-18 16:21:38'),
(4, 12, 1, 1, '2025-06-18 16:21:38'),
(5, 13, 1, 1, '2025-06-18 16:21:38'),
(6, 14, 1, 1, '2025-06-18 16:21:38'),
(7, 16, 1, 1, '2025-06-18 16:21:38'),
(8, 17, 1, 1, '2025-06-18 16:21:38'),
(9, 18, 1, 1, '2025-06-18 16:21:38'),
(10, 19, 1, 1, '2025-06-18 16:21:38'),
(11, 20, 1, 1, '2025-06-18 16:21:38'),
(12, 22, 1, 1, '2025-06-18 16:21:38'),
(13, 23, 1, 1, '2025-06-18 16:21:38'),
(14, 24, 1, 1, '2025-06-18 16:21:38'),
(15, 25, 1, 1, '2025-06-18 16:21:38'),
(16, 26, 1, 1, '2025-06-18 16:21:38'),
(17, 27, 1, 1, '2025-06-18 16:21:38'),
(18, 28, 1, 1, '2025-06-18 16:21:38'),
(19, 29, 1, 1, '2025-06-18 16:21:38'),
(20, 30, 1, 1, '2025-06-18 16:21:38'),
(21, 31, 1, 1, '2025-06-18 16:21:38'),
(22, 33, 1, 1, '2025-06-18 16:21:38'),
(23, 34, 1, 1, '2025-06-18 16:21:38'),
(24, 35, 1, 1, '2025-06-18 16:21:38'),
(25, 36, 1, 1, '2025-06-18 16:21:38'),
(26, 37, 1, 1, '2025-06-18 16:21:38'),
(27, 38, 1, 1, '2025-06-18 16:21:38'),
(28, 39, 1, 1, '2025-06-18 16:21:38'),
(29, 40, 1, 1, '2025-06-18 16:21:38'),
(30, 42, 1, 1, '2025-06-18 16:21:38'),
(31, 43, 1, 1, '2025-06-18 16:21:38'),
(32, 44, 1, 1, '2025-06-18 16:21:38'),
(33, 45, 1, 1, '2025-06-18 16:21:38'),
(34, 46, 1, 1, '2025-06-18 16:21:38'),
(35, 48, 1, 1, '2025-06-18 16:21:38'),
(36, 49, 1, 1, '2025-06-18 16:21:38'),
(37, 51, 1, 1, '2025-06-18 16:21:38'),
(38, 52, 1, 1, '2025-06-18 16:21:38'),
(39, 53, 1, 1, '2025-06-18 16:21:38'),
(40, 54, 1, 1, '2025-06-18 16:21:38'),
(41, 55, 1, 1, '2025-06-18 16:21:38'),
(42, 56, 1, 1, '2025-06-18 16:21:38'),
(43, 57, 1, 1, '2025-06-18 16:21:38'),
(44, 58, 1, 1, '2025-06-18 16:21:38'),
(45, 59, 1, 1, '2025-06-18 16:21:38'),
(46, 60, 1, 1, '2025-06-18 16:21:38'),
(47, 61, 1, 1, '2025-06-18 16:21:38'),
(48, 62, 1, 1, '2025-06-18 16:21:38'),
(49, 63, 1, 1, '2025-06-18 16:21:38'),
(50, 64, 1, 1, '2025-06-18 16:21:38'),
(51, 65, 1, 1, '2025-06-18 16:21:38'),
(52, 66, 1, 1, '2025-06-18 16:21:38'),
(53, 67, 1, 1, '2025-06-18 16:21:38'),
(54, 68, 1, 1, '2025-06-18 16:21:38'),
(55, 69, 1, 1, '2025-06-18 16:21:38'),
(56, 70, 1, 1, '2025-06-18 16:21:38'),
(57, 71, 1, 1, '2025-06-18 16:21:38'),
(58, 72, 1, 1, '2025-06-18 16:21:38'),
(59, 73, 1, 1, '2025-06-18 16:21:38'),
(60, 74, 1, 1, '2025-06-18 16:21:38'),
(61, 75, 1, 1, '2025-06-18 16:21:38'),
(62, 76, 1, 1, '2025-06-18 16:21:38'),
(63, 77, 1, 1, '2025-06-18 16:21:38'),
(64, 78, 1, 1, '2025-06-18 16:21:38'),
(65, 79, 1, 1, '2025-06-18 16:21:38'),
(66, 80, 1, 1, '2025-06-18 16:21:38'),
(67, 81, 1, 1, '2025-06-18 16:21:38'),
(68, 82, 1, 1, '2025-06-18 16:21:38'),
(69, 83, 1, 1, '2025-06-18 16:21:38'),
(70, 84, 1, 1, '2025-06-18 16:21:38'),
(71, 85, 1, 1, '2025-06-18 16:21:38'),
(72, 86, 1, 1, '2025-06-18 16:21:38'),
(73, 87, 1, 1, '2025-06-18 16:21:38'),
(74, 88, 1, 1, '2025-06-18 16:21:38'),
(75, 89, 1, 1, '2025-06-18 16:21:38'),
(76, 90, 1, 1, '2025-06-18 16:21:38'),
(77, 91, 1, 1, '2025-06-18 16:21:38'),
(78, 92, 1, 1, '2025-06-18 16:21:38'),
(79, 93, 1, 1, '2025-06-18 16:21:38'),
(80, 94, 1, 1, '2025-06-18 16:21:38'),
(81, 95, 1, 1, '2025-06-18 16:21:38'),
(82, 96, 1, 1, '2025-06-18 16:21:38'),
(83, 97, 1, 1, '2025-06-18 16:21:38'),
(84, 98, 1, 1, '2025-06-18 16:21:38'),
(85, 99, 1, 1, '2025-06-18 16:21:38'),
(86, 100, 1, 1, '2025-06-18 16:21:38'),
(87, 101, 1, 1, '2025-06-18 16:21:38'),
(88, 102, 1, 1, '2025-06-18 16:21:38'),
(89, 103, 1, 1, '2025-06-18 16:21:38'),
(90, 104, 1, 1, '2025-06-18 16:21:38'),
(91, 105, 1, 1, '2025-06-18 16:21:38'),
(92, 106, 1, 1, '2025-06-18 16:21:38'),
(93, 107, 1, 1, '2025-06-18 16:21:38'),
(94, 108, 1, 1, '2025-06-18 16:21:38'),
(95, 109, 1, 1, '2025-06-18 16:21:38'),
(96, 110, 1, 1, '2025-06-18 16:21:38'),
(97, 111, 1, 1, '2025-06-18 16:21:38'),
(98, 112, 1, 1, '2025-06-18 16:21:38'),
(99, 113, 1, 1, '2025-06-18 16:21:38'),
(100, 114, 1, 1, '2025-06-18 16:21:38'),
(101, 115, 1, 1, '2025-06-18 16:21:38'),
(102, 116, 1, 1, '2025-06-18 16:21:38'),
(103, 117, 1, 1, '2025-06-18 16:21:38'),
(104, 118, 1, 1, '2025-06-18 16:21:38'),
(105, 119, 1, 1, '2025-06-18 16:21:38'),
(106, 120, 1, 1, '2025-06-18 16:21:38'),
(107, 121, 1, 1, '2025-06-18 16:21:38'),
(108, 122, 1, 1, '2025-06-18 16:21:38'),
(109, 123, 1, 1, '2025-06-18 16:21:38'),
(110, 124, 1, 1, '2025-06-18 16:21:38'),
(111, 125, 1, 1, '2025-06-18 16:21:38'),
(112, 126, 1, 1, '2025-06-18 16:21:38'),
(113, 127, 1, 1, '2025-06-18 16:21:38'),
(114, 128, 1, 1, '2025-06-18 16:21:38'),
(115, 129, 1, 1, '2025-06-18 16:21:38'),
(116, 130, 1, 1, '2025-06-18 16:21:38'),
(117, 131, 1, 1, '2025-06-18 16:21:38'),
(118, 132, 1, 1, '2025-06-18 16:21:38'),
(119, 133, 1, 1, '2025-06-18 16:21:38'),
(120, 134, 1, 1, '2025-06-18 16:21:38'),
(121, 135, 1, 1, '2025-06-18 16:21:38'),
(122, 136, 1, 1, '2025-06-18 16:21:38'),
(123, 137, 1, 1, '2025-06-18 16:21:38'),
(124, 138, 1, 1, '2025-06-18 16:21:38'),
(125, 139, 1, 1, '2025-06-18 16:21:38'),
(126, 140, 1, 1, '2025-06-18 16:21:38'),
(127, 141, 1, 1, '2025-06-18 16:21:38'),
(128, 142, 1, 1, '2025-06-18 16:21:38'),
(129, 143, 1, 1, '2025-06-18 16:21:38'),
(130, 144, 1, 1, '2025-06-18 16:21:38'),
(131, 145, 1, 1, '2025-06-18 16:21:38'),
(132, 146, 1, 1, '2025-06-18 16:21:38'),
(133, 147, 1, 1, '2025-06-18 16:21:38'),
(134, 148, 1, 1, '2025-06-18 16:21:38'),
(135, 149, 1, 1, '2025-06-18 16:21:38'),
(136, 150, 1, 1, '2025-06-18 16:21:38'),
(137, 151, 1, 1, '2025-06-18 16:21:38'),
(138, 152, 1, 1, '2025-06-18 16:21:38'),
(139, 153, 1, 1, '2025-06-18 16:21:38'),
(140, 154, 1, 1, '2025-06-18 16:21:38'),
(141, 155, 1, 1, '2025-06-18 16:21:38'),
(142, 156, 1, 1, '2025-06-18 16:21:38'),
(143, 157, 1, 1, '2025-06-18 16:21:38'),
(144, 158, 1, 1, '2025-06-18 16:21:38'),
(145, 159, 1, 1, '2025-06-18 16:21:38'),
(146, 160, 1, 1, '2025-06-18 16:21:38'),
(147, 161, 1, 1, '2025-06-18 16:21:38'),
(148, 162, 1, 1, '2025-06-18 16:21:38'),
(149, 164, 1, 1, '2025-06-18 16:21:38'),
(150, 165, 1, 1, '2025-06-18 16:21:38'),
(151, 166, 1, 1, '2025-06-18 16:21:38'),
(152, 167, 1, 1, '2025-06-18 16:21:38'),
(153, 168, 1, 1, '2025-06-18 16:21:38'),
(154, 169, 1, 1, '2025-06-18 16:21:38'),
(155, 170, 1, 1, '2025-06-18 16:21:38'),
(156, 171, 1, 1, '2025-06-18 16:21:38'),
(157, 172, 1, 1, '2025-06-18 16:21:38'),
(158, 173, 1, 1, '2025-06-18 16:21:38'),
(159, 174, 1, 1, '2025-06-18 16:21:38'),
(160, 175, 1, 1, '2025-06-18 16:21:38'),
(161, 176, 1, 1, '2025-06-18 16:21:38'),
(162, 177, 1, 1, '2025-06-18 16:21:38'),
(163, 178, 1, 1, '2025-06-18 16:21:38'),
(164, 179, 1, 1, '2025-06-18 16:21:38'),
(165, 180, 1, 1, '2025-06-18 16:21:38'),
(166, 181, 1, 1, '2025-06-18 16:21:38'),
(167, 182, 1, 1, '2025-06-18 16:21:38'),
(168, 183, 1, 1, '2025-06-18 16:21:38'),
(169, 184, 1, 1, '2025-06-18 16:21:38'),
(170, 185, 1, 1, '2025-06-18 16:21:38'),
(171, 186, 1, 1, '2025-06-18 16:21:38'),
(172, 187, 1, 1, '2025-06-18 16:21:38'),
(173, 188, 1, 1, '2025-06-18 16:21:38');

-- --------------------------------------------------------

--
-- Table structure for table `employe_temp_orderdetails`
--

CREATE TABLE `employe_temp_orderdetails` (
  `id` int NOT NULL,
  `employee_id` int NOT NULL,
  `order_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `frame_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `frame_prescription` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `prescription_image` text COLLATE utf8mb4_general_ci,
  `od_left_sphere` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_left_cylinders` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_left_axis` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_left_nv_add` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_left_2_pds` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_right_sphere` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_right_cylinders` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_right_axis` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_right_nv_add` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_right_2_pds` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pupil_distance` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `frame_picture` text COLLATE utf8mb4_general_ci,
  `pupil_distance_online` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_left_2_pds_online` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_right_2_pds_online` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_right` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_left` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_base_direction_right` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_base_direction_left` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_rigth` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_left` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_base_direction_right` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_base_direction_left` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `special_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employe_temp_orderdetails`
--

INSERT INTO `employe_temp_orderdetails` (`id`, `employee_id`, `order_type`, `frame_type`, `frame_prescription`, `prescription_image`, `od_left_sphere`, `od_left_cylinders`, `od_left_axis`, `od_left_nv_add`, `od_left_2_pds`, `od_right_sphere`, `od_right_cylinders`, `od_right_axis`, `od_right_nv_add`, `od_right_2_pds`, `pupil_distance`, `frame_picture`, `pupil_distance_online`, `od_left_2_pds_online`, `od_right_2_pds_online`, `vertical_right`, `vertical_left`, `vertical_base_direction_right`, `vertical_base_direction_left`, `horizontal_rigth`, `horizontal_left`, `horizontal_base_direction_right`, `horizontal_base_direction_left`, `special_notes`, `created_at`, `updated_at`) VALUES
(2, 1, 'new-order', 'single-vision', 'single-vision-lense', NULL, '0.00', '0.00', '1', '+0.00', '23.0', '0.00', '0.00', '1', '+0.00', '23.5', '46.5', NULL, 'null', 'null', 'null', '0.00', '0.00', 'Up', 'Up', '0.00', '0.00', 'In', 'In', NULL, '2025-06-19 09:41:38', '2025-06-19 09:41:42');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `frame_sizes`
--

CREATE TABLE `frame_sizes` (
  `frame_size_id` int NOT NULL,
  `frame_size_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `rim_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `frame_sizes`
--

INSERT INTO `frame_sizes` (`frame_size_id`, `frame_size_name`, `rim_type`) VALUES
(3, 'Small (S) 44-52', NULL),
(4, 'Medium (M) 53-57', NULL),
(5, 'Large (L) 58-65', NULL),
(6, 'Extra Large (XL)', NULL),
(7, 'UltraFlex Frame', NULL),
(8, 'Precision Fit', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lens_material`
--

CREATE TABLE `lens_material` (
  `id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `sub_title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `single_vision_price` decimal(10,0) DEFAULT NULL,
  `lined_bifocal_lenses_price` decimal(10,0) DEFAULT NULL,
  `no_line_progressive_lenses_price` decimal(10,0) DEFAULT NULL,
  `trifocal_lenses_price` decimal(10,0) DEFAULT NULL,
  `full_readers_price` decimal(10,0) DEFAULT NULL,
  `half_readers_price` decimal(10,0) DEFAULT NULL,
  `non_prescription_plano_lenses_price` decimal(10,0) DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lens_material`
--

INSERT INTO `lens_material` (`id`, `title`, `sub_title`, `image_url`, `single_vision_price`, `lined_bifocal_lenses_price`, `no_line_progressive_lenses_price`, `trifocal_lenses_price`, `full_readers_price`, `half_readers_price`, `non_prescription_plano_lenses_price`, `description`, `created_at`, `updated_at`) VALUES
(6, 'Polycarbonate', 'Everyday Safety Lens', '/projectimages/lensmanegment/material/1745309203_POLYCARBONATE.svg', 45, 74, 89, 84, 45, 74, 29, 'Polycarbonate lenses are lightweight and highly durable, offering excellent impact resistance. Ideal for active individuals, they provide superior protection while maintaining comfort. These lenses are also thinner and lighter compared to traditional materials, making them a great choice for everyday wear.', '2025-04-22 08:06:43', '2025-06-18 17:57:45'),
(7, 'Wrap Style Digital Lens', 'Best for high prescription', '/projectimages/lensmanegment/material/1745309248_WRAP_STYLE_DIGITAL_LENS.svg', 159, 34, 23, 12, 22, 34, 45, 'Wrap-style digital lenses are designed for a wider field of view and maximum comfort. Their curvature helps provide an enhanced visual experience, especially for digital users. They reduce distortion and minimize glare, making them perfect for extended screen time.', '2025-04-22 08:07:28', '2025-06-17 09:24:13'),
(8, 'Trivex', 'Thinner, lighter & more visual acuity', '/projectimages/lensmanegment/material/1745309292_TRIVEX.svg', 94, 34, 12, 34, 23, 12, 45, 'Trivex lenses are known for their lightweight nature and exceptional strength. Offering excellent optical clarity, they provide high-impact resistance and superior UV protection. These lenses are ideal for individuals looking for a balance of performance and comfort, especially in outdoor environments.', '2025-04-22 08:08:12', '2025-06-17 09:40:32');

-- --------------------------------------------------------

--
-- Table structure for table `lens_protection`
--

CREATE TABLE `lens_protection` (
  `id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `sub_title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lens_protection`
--

INSERT INTO `lens_protection` (`id`, `title`, `sub_title`, `image_url`, `price`, `description`, `created_at`, `updated_at`) VALUES
(3, 'No Protection', 'No Extra Protection', '/projectimages/lensmanegment/lens_protection/1745310211_NO_LENS_PROTECTION.svg', 0.00, 'Lenses without reflective protection may allow light to bounce off the surface, causing glare and visual discomfort. Without this feature, reflections can interfere with vision, especially in bright or artificial light. It’s best to consider reflective protection for improved clarity and comfort.', '2025-04-22 08:23:31', '2025-04-22 08:23:31'),
(4, 'Anti Reflective', 'Reduces Glare', '/projectimages/lensmanegment/lens_protection/1745310257_ANTI_REFLECTIVE.svg', 45.00, 'Anti-reflective coatings reduce glare and reflections, enhancing visual clarity. This coating is especially beneficial for driving at night, computer use, and in bright lighting. It ensures that light doesn\'t bounce off the lenses, allowing for more comfortable and focused vision.', '2025-04-22 08:24:17', '2025-04-22 08:24:17'),
(5, 'Premium Anti Reflective', 'Reduces Glare, Durable & Easy Clean', '/projectimages/lensmanegment/lens_protection/1745310426_PREMIUM_ANTI_REFLECTIVE.svg', 95.00, 'Premium anti-reflective coatings offer superior performance, minimizing glare and reflections more effectively than standard coatings. These lenses improve visual comfort, reduce eye strain, and enhance clarity, especially when working with digital screens, driving, or in environments with harsh lighting.', '2025-04-22 08:27:06', '2025-04-22 08:27:06');

-- --------------------------------------------------------

--
-- Table structure for table `lens_tint`
--

CREATE TABLE `lens_tint` (
  `id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `sub_title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lens_tint`
--

INSERT INTO `lens_tint` (`id`, `title`, `sub_title`, `image_url`, `price`, `description`, `created_at`, `updated_at`) VALUES
(6, 'Clear', 'Lens without any Tint and darkening effect', '/projectimages/lensmanegment/lens_tint/1745309717_CLEAR_LENS_TINT.svg', 0.00, 'Clear lens tint offers a neutral look while providing protection from UV rays. These lenses are ideal for indoor use or low-light conditions, offering comfort without altering color perception. They\'re perfect for those who need clear vision without additional tint or color.', '2025-04-22 08:15:17', '2025-04-22 08:15:17'),
(7, 'Photochromic / Transition - Brown', 'Darkens in sunlight', '/projectimages/lensmanegment/lens_tint/1745309760_PHOTOCHROMIC_BROWN.svg', 85.00, 'Photochromic lenses in brown adapt to changing light conditions, darkening when exposed to sunlight and lightening indoors. The brown tint enhances contrast and depth perception, making them ideal for outdoor activities in varying lighting conditions, offering optimal clarity and protection.', '2025-04-22 08:16:00', '2025-04-22 08:16:00'),
(8, 'Photochromic / Transition - Grey', 'Darkens in sunlight', '/projectimages/lensmanegment/lens_tint/1745309810_PHOTOCHROMIC_GRAY.svg', 85.00, 'Gray photochromic lenses adjust to light changes, offering neutral color balance and reducing glare. Ideal for outdoor use, they provide comfort by protecting your eyes from bright sunlight while preserving natural color perception. These lenses are perfect for a wide range of lighting conditions.', '2025-04-22 08:16:50', '2025-04-22 08:16:50'),
(9, 'Transitions XTRActive Gray', 'Darkest Photochromic Available', '/projectimages/lensmanegment/lens_tint/1745309875_TRANSITION_XTRACTIVE_GRAY.svg', 85.00, 'Transitions XTRActive Gray lenses offer advanced light adaptation, darkening in bright sunlight and providing extra protection in extreme light. These lenses offer a more consistent level of darkness, ensuring your eyes remain comfortable and shielded, whether indoors or outdoors.', '2025-04-22 08:17:55', '2025-04-22 08:17:55'),
(10, 'Transitions XTRActive Brown', 'Darkest Photochromic Available', '/projectimages/lensmanegment/lens_tint/1745309912_TRANSITION_XTRACTIVE_BROWN.svg', 85.00, 'Transitions XTRActive Brown lenses offer enhanced contrast and visual clarity, particularly in variable lighting conditions. The brown tint darkens in sunlight and lightens indoors, providing extra comfort. These lenses are ideal for individuals who spend a lot of time outdoors and need all-day protection', '2025-04-22 08:18:32', '2025-04-22 08:18:32');

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--

CREATE TABLE `manufacturers` (
  `manufacturer_id` int NOT NULL,
  `manufacturer_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `contact_info` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `manufacturers`
--

INSERT INTO `manufacturers` (`manufacturer_id`, `manufacturer_name`, `contact_info`) VALUES
(3, 'Uvex (Honeywell)', NULL),
(9, 'ArmouRx', NULL),
(10, 'Wiley X', NULL),
(11, 'Badgley Mischka Men\'s Optical', NULL),
(12, 'Freakshow', NULL),
(13, 'ONeill Small Fit', NULL),
(14, 'Hudson Optical', NULL),
(15, 'American Optical', NULL),
(16, 'AO Eyewear', NULL),
(17, 'SCOJO New York', NULL),
(18, 'Etnia Barcelona', NULL),
(19, 'Tom Ford', NULL),
(20, 'Gumption', NULL),
(21, 'VonZipper', NULL),
(22, 'SafeVision', NULL),
(23, 'On-Guard Safety', NULL),
(24, 'Hilco', NULL),
(25, 'Pentax', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `material_id` int NOT NULL,
  `material_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `shape` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`material_id`, `material_name`, `shape`) VALUES
(5, 'Polycarbonate', NULL),
(6, 'TR-90 Nylon', NULL),
(7, 'Metal Alloy', NULL),
(8, 'Stainless Steel', NULL),
(9, 'Titanium', NULL),
(10, 'Carbon Fiber', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_01_21_082948_create_personal_access_tokens_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` int NOT NULL,
  `company_id` int NOT NULL,
  `prescription_id` int NOT NULL,
  `blue_light_protection` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `lense_material` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `scratch_coating` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lens_tint` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lens_protection` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `order_confirmation_number` int NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `variant_id` int NOT NULL,
  `tray_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `time` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `frame_size` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `product_quantity` int NOT NULL,
  `order_status` enum('Pending','Confirmed','Shipped','Delivered','Cancelled','pending_payment') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Pending',
  `net_total` decimal(10,2) NOT NULL,
  `paid_amount_via_benefit` decimal(10,2) DEFAULT NULL,
  `paid_amount_via_card` decimal(10,2) DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT NULL,
  `stripe_invoice_id` text COLLATE utf8mb4_general_ci,
  `stripe_invoice_url` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `employee_id`, `company_id`, `prescription_id`, `blue_light_protection`, `order_type`, `lense_material`, `scratch_coating`, `lens_tint`, `lens_protection`, `payment_method`, `order_confirmation_number`, `product_id`, `variant_id`, `tray_id`, `time`, `frame_size`, `product_quantity`, `order_status`, `net_total`, `paid_amount_via_benefit`, `paid_amount_via_card`, `paid_amount`, `stripe_invoice_id`, `stripe_invoice_url`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '4', 'new-order', '6', NULL, NULL, '3', 'Benefit Amount + Pay Later', 100021, 10, 20, NULL, NULL, '5', 1, 'pending_payment', 180.50, 150.00, 30.50, NULL, NULL, NULL, '2025-06-18 16:23:14', '2025-06-18 16:23:14'),
(2, 1, 1, 1, '4', 'existing-prescription', '6', '3', '6', '3', 'Benefit Amount', 100022, 10, 19, NULL, NULL, '5', 1, 'Pending', 170.50, 170.50, 0.00, NULL, NULL, NULL, '2025-06-19 07:00:13', '2025-06-19 07:00:13');

-- --------------------------------------------------------

--
-- Table structure for table `order_billing_address`
--

CREATE TABLE `order_billing_address` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `state` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `second_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `zip_postal_code` int NOT NULL,
  `phone_number` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_billing_address`
--

INSERT INTO `order_billing_address` (`id`, `order_id`, `first_name`, `last_name`, `email`, `country`, `state`, `city`, `address`, `second_address`, `zip_postal_code`, `phone_number`, `created_at`, `updated_at`) VALUES
(1, 1, 'Ameer', 'Mavia', 'mavia8701@gmail.com', 'USA', 'Illinois', 'Arlington Heights', 'House no 38 humza street lajna chowk collage road township l', NULL, 54470, '03174572453', '2025-06-18 16:23:14', '2025-06-18 16:23:14'),
(2, 2, 'Abdullah', 'butt', 'abutt042@gmail.com', 'USA', 'Hawaii', 'Carlinville', 'Sodiwal Sodhiwal, Lahore, Pakistan', 'Data street', 54000, '03236326126', '2025-06-19 07:00:14', '2025-06-19 07:00:14');

-- --------------------------------------------------------

--
-- Table structure for table `order_shipping_address`
--

CREATE TABLE `order_shipping_address` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `state` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `second_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `zip_postal_code` int NOT NULL,
  `phone_number` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `additional_information` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_shipping_address`
--

INSERT INTO `order_shipping_address` (`id`, `order_id`, `first_name`, `last_name`, `email`, `country`, `state`, `city`, `address`, `second_address`, `zip_postal_code`, `phone_number`, `additional_information`, `created_at`, `updated_at`) VALUES
(1, 1, 'Ameer', 'Mavia', 'mavia8701@gmail.com', 'USA', 'Illinois', 'Arlington Heights', 'House no 38 humza street lajna chowk collage road township l', NULL, 54470, '03174572453', NULL, '2025-06-18 16:23:14', '2025-06-18 16:23:14'),
(2, 2, 'Abdullah', 'butt', 'abutt042@gmail.com', 'USA', 'Hawaii', 'Carlinville', 'Sodiwal Sodhiwal, Lahore, Pakistan', 'Data street', 54000, '03236326126', NULL, '2025-06-19 07:00:14', '2025-06-19 07:00:14');

-- --------------------------------------------------------

--
-- Table structure for table `order_update_points`
--

CREATE TABLE `order_update_points` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `point` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 89, 'impersonation_token', '6e9878e50b5bfd362f7cbfa22fd44447596b4f8b2f7662f0f22075b0514fe274', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"1|Yx93gxY6ld7r7dTCZohkFJoeqOM6tl6ZAqzUi0nh20b475c8\"}', '2025-06-12 17:12:50', NULL, '2025-06-12 17:08:22', '2025-06-12 17:12:50'),
(3, 'App\\Models\\User', 89, 'auth_token', '79cac35f92947958eb8d50c84f5a9046eb3c76946f0593a4cc8ab9c8347245ae', '[\"*\"]', '2025-06-12 17:21:53', NULL, '2025-06-12 17:21:49', '2025-06-12 17:21:53'),
(5, 'App\\Models\\User', 89, 'impersonation_token', 'a6f59b1e67e5c288fb4df67098167e6bf12bee6d96810c8e8ff8d56f62bcde5d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"4|0j4eSc5viVHy2SJrnQkjdErtDGHivWiwdkYyeNAoa5655f9e\"}', '2025-06-12 17:27:07', NULL, '2025-06-12 17:24:44', '2025-06-12 17:27:07'),
(7, 'App\\Models\\User', 89, 'impersonation_token', 'ba24a0d32be30be1b64cee1c1778243c663164ac7618cb953daa5c99d478b965', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"6|wgC8j6sEqJtXD6TldcNIvBAA1cCKXOiWAIBExiFi342620f1\"}', '2025-06-16 12:36:12', NULL, '2025-06-12 17:38:58', '2025-06-16 12:36:12'),
(8, 'App\\Models\\User', 90, 'impersonation_token', '2c376254c85cfac610b982bdb9c4495cc378e65f0c9e259cd3d28377d615d267', '{\"is_impersonation\":true,\"impersonator_id\":89,\"original_token\":\"7|64RCz4JZ4XH60roUsF5UPcTLLhgfAx2JzR6L33EB40eb4e30\"}', '2025-06-12 17:40:39', NULL, '2025-06-12 17:39:32', '2025-06-12 17:40:39'),
(9, 'App\\Models\\User', 90, 'impersonation_token', '253684b7ba4c521b8098628b1fea385ed270ad04ddab43839b3910e12002e790', '{\"is_impersonation\":true,\"impersonator_id\":89,\"original_token\":\"7|64RCz4JZ4XH60roUsF5UPcTLLhgfAx2JzR6L33EB40eb4e30\"}', '2025-06-12 17:40:58', NULL, '2025-06-12 17:40:58', '2025-06-12 17:40:58'),
(11, 'App\\Models\\User', 90, 'impersonation_token', '38505a61dc9cbc1f1340b9c7ebae3ed4e7226fb10ecd10d2929e4d1a68a28f7f', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"10|INLOknOOmS1RyFyl4mSA1RZMYSHM4cTfmN3hV2zt2b1d2715\"}', '2025-06-12 17:48:00', NULL, '2025-06-12 17:47:59', '2025-06-12 17:48:00'),
(12, 'App\\Models\\User', 90, 'impersonation_token', 'b8e1548cd9022d28d36fd2ed08ff3deac4d898c5343adeebf2cc3c9a92fcd2ad', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"10|INLOknOOmS1RyFyl4mSA1RZMYSHM4cTfmN3hV2zt2b1d2715\"}', '2025-06-12 17:51:21', NULL, '2025-06-12 17:51:20', '2025-06-12 17:51:21'),
(13, 'App\\Models\\User', 90, 'impersonation_token', '433b257c38a4d2fac2d11a91f8b2c145e4309d19682c3b2035e2a519f763bdf1', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"10|INLOknOOmS1RyFyl4mSA1RZMYSHM4cTfmN3hV2zt2b1d2715\"}', '2025-06-12 18:09:59', NULL, '2025-06-12 17:51:20', '2025-06-12 18:09:59'),
(14, 'App\\Models\\User', 90, 'impersonation_token', '376198ab4958764c930682a72f5b44ad26288c007822a423bf28b05c13579cd9', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"4|0j4eSc5viVHy2SJrnQkjdErtDGHivWiwdkYyeNAoa5655f9e\"}', '2025-06-12 18:08:19', NULL, '2025-06-12 18:00:47', '2025-06-12 18:08:19'),
(16, 'App\\Models\\User', 90, 'impersonation_token', '99fc88a9a8f5e8bcca70ba7e867e9692010a89710eba4c6cb3a8d1444a3f1ea3', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"15|4rMm5hHkyOai8k1FJUpWEQuHYtclfPfqbrVnWru7684bbeb2\"}', '2025-06-12 21:32:51', NULL, '2025-06-12 21:32:50', '2025-06-12 21:32:51'),
(17, 'App\\Models\\User', 91, 'auth_token', '251df695a8af2750fe1a71b1d34f40910fb5724a6e56da19aa64e2a2b4766242', '[\"*\"]', '2025-06-12 21:40:10', NULL, '2025-06-12 21:38:34', '2025-06-12 21:40:10'),
(21, 'App\\Models\\User', 91, 'auth_token', 'c20dc318fb4fdc55c74fff150a0f2e3dfc769147c4abc716bc05c7ca835f33e2', '[\"*\"]', '2025-06-12 21:42:04', NULL, '2025-06-12 21:41:42', '2025-06-12 21:42:04'),
(27, 'App\\Models\\User', 89, 'impersonation_token', '64c63cfdae50d8ac81d843899423eaf9235e7f4f6937a6e2c9024e7b1ea5f973', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"24|Flfs6Z2BEFGB52sFFzzC3hMGZrw03cU6PxQ3LWY6a7b44534\"}', '2025-06-12 23:05:15', NULL, '2025-06-12 23:05:15', '2025-06-12 23:05:15'),
(28, 'App\\Models\\User', 89, 'impersonation_token', '6a8165dab3a7625e344a35aaf084705b2e0f2e72382886979d901b0b975ed409', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"24|Flfs6Z2BEFGB52sFFzzC3hMGZrw03cU6PxQ3LWY6a7b44534\"}', '2025-06-12 23:11:01', NULL, '2025-06-12 23:06:38', '2025-06-12 23:11:01'),
(29, 'App\\Models\\User', 93, 'impersonation_token', 'a4e0fc9f0cbc7cb2ebe37373aa87099d7b53c6dcf3a8aa9ffa3a93d03e160ba7', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"24|Flfs6Z2BEFGB52sFFzzC3hMGZrw03cU6PxQ3LWY6a7b44534\"}', '2025-06-12 23:14:27', NULL, '2025-06-12 23:12:02', '2025-06-12 23:14:27'),
(30, 'App\\Models\\User', 89, 'impersonation_token', '8470e120646ec07f95ae9c61705156d070479933960508665d77f7327e161681', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"24|Flfs6Z2BEFGB52sFFzzC3hMGZrw03cU6PxQ3LWY6a7b44534\"}', '2025-06-12 23:15:28', NULL, '2025-06-12 23:15:02', '2025-06-12 23:15:28'),
(31, 'App\\Models\\User', 93, 'impersonation_token', '43961266ce10938091e3a6811cbdf5b707e17eb778f51ed6df2219be6499337e', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"24|Flfs6Z2BEFGB52sFFzzC3hMGZrw03cU6PxQ3LWY6a7b44534\"}', '2025-06-12 23:15:54', NULL, '2025-06-12 23:15:40', '2025-06-12 23:15:54'),
(32, 'App\\Models\\User', 93, 'impersonation_token', 'ef654ec281f0ea55347d7a9d4262c37aac256719e621aed808374abe0950f1f1', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"24|Flfs6Z2BEFGB52sFFzzC3hMGZrw03cU6PxQ3LWY6a7b44534\"}', '2025-06-12 23:26:28', NULL, '2025-06-12 23:21:44', '2025-06-12 23:26:28'),
(33, 'App\\Models\\User', 89, 'impersonation_token', '88951bbd5ccca464d4274b21b03689dca00670a3c59fb53e44945d9022e228c0', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"25|msPYkF8kcY0zR9uPbTIrF6ljEvjDvJdSnN4rvqtP6a6a9824\"}', '2025-06-12 23:25:47', NULL, '2025-06-12 23:25:47', '2025-06-12 23:25:47'),
(34, 'App\\Models\\User', 93, 'impersonation_token', '730ca28799bc47aede6d44390bf5b2fb36ccfe5a2a14f0f675fee778b95f9e26', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"25|msPYkF8kcY0zR9uPbTIrF6ljEvjDvJdSnN4rvqtP6a6a9824\"}', '2025-06-12 23:27:52', NULL, '2025-06-12 23:26:12', '2025-06-12 23:27:52'),
(36, 'App\\Models\\User', 92, 'impersonation_token', 'b85b3fe8ba41a36368c0e9073456abf0b50cb009820e299848939917157a9a0c', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"35|5gxF1ceN6XEgimTrg45mf5PpYy0NshNfscm3ouzq29447d57\"}', '2025-06-13 01:16:10', NULL, '2025-06-13 01:16:10', '2025-06-13 01:16:10'),
(37, 'App\\Models\\User', 94, 'auth_token', '0d2d27fa1819fbf228b07fdd98d4376d7a28e90f96e03dde31e16b5dd846586e', '[\"*\"]', '2025-06-13 01:41:04', NULL, '2025-06-13 01:21:02', '2025-06-13 01:41:04'),
(39, 'App\\Models\\User', 92, 'impersonation_token', '732c964161d46582e6747a0caf3bed8c4a6a4525ede2286b0a94adf13ac56288', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"4|0j4eSc5viVHy2SJrnQkjdErtDGHivWiwdkYyeNAoa5655f9e\"}', '2025-06-13 09:48:10', NULL, '2025-06-13 09:13:20', '2025-06-13 09:48:10'),
(40, 'App\\Models\\User', 94, 'impersonation_token', '92eb33f1a23defcdc131a164870f86d0ef8f3c14a98bc34649524572457d9e99', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"38|M19KeiDAl3bGQT2jGTuq6zzW2p9RqZHRAQr4TtHE51c43fbd\"}', '2025-06-13 09:16:14', NULL, '2025-06-13 09:14:57', '2025-06-13 09:16:14'),
(41, 'App\\Models\\User', 95, 'impersonation_token', 'c081b21baf9ac79a08bc2b65ac9e39bd6266348830607025b18a4e18eb8c518a', '{\"is_impersonation\":true,\"impersonator_id\":94,\"original_token\":\"40|i84tPe2mxNpxybAeATomX4fVejshuqTpEbyqKW2p09e0685b\"}', '2025-06-13 09:16:03', NULL, '2025-06-13 09:15:13', '2025-06-13 09:16:03'),
(43, 'App\\Models\\User', 95, 'impersonation_token', 'c877a9645ddb22c33278aed2804420c00e5bb27e1b539c98afb24cd6d7e26dca', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 09:18:43', NULL, '2025-06-13 09:18:41', '2025-06-13 09:18:43'),
(44, 'App\\Models\\User', 94, 'impersonation_token', '1fb4897442010ceb319b8e37d165cad4eadc859604c26409c56a2742400b0735', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 09:19:14', NULL, '2025-06-13 09:19:07', '2025-06-13 09:19:14'),
(45, 'App\\Models\\User', 89, 'impersonation_token', '4590867286792bd3dd0896e332286cfdcebd7b02fb290e2cb8745fac8937fba5', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 09:20:14', NULL, '2025-06-13 09:19:55', '2025-06-13 09:20:14'),
(46, 'App\\Models\\User', 93, 'impersonation_token', '5458b0ee4566afd8f15e09238c8ebde681a28daf3c51f68585d6fdce75590205', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 09:20:38', NULL, '2025-06-13 09:20:35', '2025-06-13 09:20:38'),
(47, 'App\\Models\\User', 89, 'impersonation_token', 'd98fcefff04d5fb0e0f214da4859fd17a2e50a19da772355512adbc20b24283d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 09:21:22', NULL, '2025-06-13 09:21:08', '2025-06-13 09:21:22'),
(48, 'App\\Models\\User', 93, 'impersonation_token', '3b1c3dfa4319717fec2b54710b44588f0e1773026425fe378a210aefcf105292', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 09:45:49', NULL, '2025-06-13 09:21:48', '2025-06-13 09:45:49'),
(49, 'App\\Models\\User', 93, 'impersonation_token', '27341ed471e4ab2c5a16f8d63969ec67a429e8485b8b19775e9dcbfb91625019', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"4|0j4eSc5viVHy2SJrnQkjdErtDGHivWiwdkYyeNAoa5655f9e\"}', '2025-06-13 09:50:07', NULL, '2025-06-13 09:48:20', '2025-06-13 09:50:07'),
(52, 'App\\Models\\User', 93, 'impersonation_token', 'fb5399c416b5afad9889ca9b78780e43ae79a630cef44e0afd981c582eb57229', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 10:44:42', NULL, '2025-06-13 09:54:22', '2025-06-13 10:44:42'),
(53, 'App\\Models\\User', 91, 'impersonation_token', '0a0baa91c40103d8f243ba6cb9e12856359d83ed0a1c4398c0c031809db6db33', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"25|msPYkF8kcY0zR9uPbTIrF6ljEvjDvJdSnN4rvqtP6a6a9824\"}', '2025-06-13 10:00:46', NULL, '2025-06-13 10:00:46', '2025-06-13 10:00:46'),
(54, 'App\\Models\\User', 95, 'impersonation_token', '7fb2e62f613f2801d193deaa0ada436c15f7ec8f48c199be3be0d513d4cb5d08', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"25|msPYkF8kcY0zR9uPbTIrF6ljEvjDvJdSnN4rvqtP6a6a9824\"}', '2025-06-13 10:01:05', NULL, '2025-06-13 10:00:56', '2025-06-13 10:01:05'),
(55, 'App\\Models\\User', 92, 'impersonation_token', '9ba1fc94700462357813c528eb3b2761cde44058f19ee14537c77590da2defb4', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"25|msPYkF8kcY0zR9uPbTIrF6ljEvjDvJdSnN4rvqtP6a6a9824\"}', '2025-06-13 10:14:00', NULL, '2025-06-13 10:01:20', '2025-06-13 10:14:00'),
(56, 'App\\Models\\User', 93, 'impersonation_token', 'e0765911e3ddc734be4932b44821f59f68b428d682eb6b916315af873e018cbb', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 10:07:57', NULL, '2025-06-13 10:07:04', '2025-06-13 10:07:57'),
(57, 'App\\Models\\User', 93, 'impersonation_token', '335f56857208a519091507179ac1b93b02fd09279e26e97bcd9464fa3ed8b8a8', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 10:08:57', NULL, '2025-06-13 10:08:22', '2025-06-13 10:08:57'),
(58, 'App\\Models\\User', 93, 'impersonation_token', '0749643838061891a73dc03bf93a1eae120c0205150e998b3bdee91d67463931', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 10:11:42', NULL, '2025-06-13 10:10:40', '2025-06-13 10:11:42'),
(59, 'App\\Models\\User', 93, 'impersonation_token', '625143ba8fadd5c000c9d2009665105cd3c35844bbebe1e3a19320cc8d288e70', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 10:12:22', NULL, '2025-06-13 10:12:22', '2025-06-13 10:12:22'),
(60, 'App\\Models\\User', 92, 'impersonation_token', 'd73d5ba9815dda0da485dab23a95b8560a93a62d0eb1bfa53bbb48bf402a9c00', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"25|msPYkF8kcY0zR9uPbTIrF6ljEvjDvJdSnN4rvqtP6a6a9824\"}', '2025-06-13 10:17:52', NULL, '2025-06-13 10:17:52', '2025-06-13 10:17:52'),
(61, 'App\\Models\\User', 89, 'impersonation_token', '30e5e445aaaa8e51d83c4430de1c0f901c14e142a42c0f688efbf45fd4f21aac', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"25|msPYkF8kcY0zR9uPbTIrF6ljEvjDvJdSnN4rvqtP6a6a9824\"}', '2025-06-13 10:31:45', NULL, '2025-06-13 10:30:40', '2025-06-13 10:31:45'),
(64, 'App\\Models\\User', 93, 'impersonation_token', '4a358b503790f2602d3af80458ac8fd8cfafc771916021b6c2c7a86de967c8ac', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"63|UZCf53nGp7QYibjzDd09EKs1Ov02A5H3wmjy4wAbb9c95bc1\"}', '2025-06-13 10:36:52', NULL, '2025-06-13 10:35:04', '2025-06-13 10:36:52'),
(66, 'App\\Models\\User', 93, 'impersonation_token', '8b595f90d776b20dd02840609ed824fa0b5c8ecd1ffa14b096e75898182d7199', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"42|vpDIXYnxnmhWMtPmOJUVNVTLgrs1XpvWKJluyg2d73ea66ae\"}', '2025-06-13 11:38:27', NULL, '2025-06-13 11:37:57', '2025-06-13 11:38:27'),
(69, 'App\\Models\\User', 89, 'impersonation_token', 'ee803f8fff9bf51599122ab68975fb99bcdd7a6d7e3504c42cdb4fe52b678dc5', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"68|hs0K3RjHLi75Sqm34QcV0dSxX8YzRBNJMJa5gFPy26731301\"}', '2025-06-13 12:35:09', NULL, '2025-06-13 12:10:51', '2025-06-13 12:35:09'),
(70, 'App\\Models\\User', 89, 'impersonation_token', 'a16ee8c07a5971df81fee147cc6d812c4bb44afa62ea559260b46eb8b2042718', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"65|fnfnAD1p0QQBlFOsnlILR1ugcGg2TYtqXXOyllYNc1eba4cc\"}', '2025-06-13 13:06:05', NULL, '2025-06-13 12:16:53', '2025-06-13 13:06:05'),
(71, 'App\\Models\\User', 97, 'impersonation_token', '9fb25da475d0339aedae784e8797644e14bfbaf48a87434f326b1c5ef1b46dc4', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"68|hs0K3RjHLi75Sqm34QcV0dSxX8YzRBNJMJa5gFPy26731301\"}', '2025-06-13 12:52:39', NULL, '2025-06-13 12:35:39', '2025-06-13 12:52:39'),
(73, 'App\\Models\\User', 97, 'impersonation_token', 'a08d216e6fe690c1a74da6055876cf7bb6f136848627a39ce73dd8e61178d63c', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"65|fnfnAD1p0QQBlFOsnlILR1ugcGg2TYtqXXOyllYNc1eba4cc\"}', '2025-06-16 07:57:04', NULL, '2025-06-13 13:06:15', '2025-06-16 07:57:04'),
(75, 'App\\Models\\User', 95, 'impersonation_token', 'c34c4ca8bc3eecd26efeea7a9e9de0f010258719b5d3cb7be37ca32d6438a29e', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"74|6lPNnXVZ9102zpSogXIEXEJR5GS2yAvTNcyQ6qhV42ce72c6\"}', '2025-06-13 14:39:43', NULL, '2025-06-13 14:39:07', '2025-06-13 14:39:43'),
(76, 'App\\Models\\User', 96, 'impersonation_token', 'cadb535bb74e726e21144455606629fe1d030e4746e0f4215afc70fa6d39971a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"74|6lPNnXVZ9102zpSogXIEXEJR5GS2yAvTNcyQ6qhV42ce72c6\"}', '2025-06-13 14:40:48', NULL, '2025-06-13 14:40:04', '2025-06-13 14:40:48'),
(77, 'App\\Models\\User', 92, 'impersonation_token', '7ccd8b452fe5703eb0c587440b913307eb51e5eb50363f104ff39150db2d02c5', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"74|6lPNnXVZ9102zpSogXIEXEJR5GS2yAvTNcyQ6qhV42ce72c6\"}', '2025-06-13 14:41:25', NULL, '2025-06-13 14:41:03', '2025-06-13 14:41:25'),
(78, 'App\\Models\\User', 92, 'impersonation_token', 'bac0ed757d7aa091a362308c800ae8fe8b8852832310fd19bbe42cdad263d4fd', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"74|6lPNnXVZ9102zpSogXIEXEJR5GS2yAvTNcyQ6qhV42ce72c6\"}', '2025-06-13 14:44:28', NULL, '2025-06-13 14:44:10', '2025-06-13 14:44:28'),
(79, 'App\\Models\\User', 93, 'impersonation_token', '0566a348f722591eabb9978a798d108b33b556e3041cd991d13e69212aa6af2d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"74|6lPNnXVZ9102zpSogXIEXEJR5GS2yAvTNcyQ6qhV42ce72c6\"}', '2025-06-16 13:13:08', NULL, '2025-06-13 14:44:42', '2025-06-16 13:13:08'),
(81, 'App\\Models\\User', 93, 'impersonation_token', '0121e21221c5b3268d5f49fe9e1fd271310abbf920d8b70057d16357007383eb', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"80|2DonUCDLatWJ6uF6tcZyZtrKjPu7qvJFOTligtC8e33db637\"}', '2025-06-13 20:50:05', NULL, '2025-06-13 20:48:56', '2025-06-13 20:50:05'),
(84, 'App\\Models\\User', 92, 'impersonation_token', '86ae33d2a0ea03e9628f6ad670e66c956303c6e6503bee70f16db597cc807af7', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"80|2DonUCDLatWJ6uF6tcZyZtrKjPu7qvJFOTligtC8e33db637\"}', '2025-06-14 17:34:42', NULL, '2025-06-14 17:32:42', '2025-06-14 17:34:42'),
(86, 'App\\Models\\User', 92, 'impersonation_token', '76a59da6a59c5d687fe55d93d15a793524fcfc10871aea75aa7c8d9a10324f66', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"85|Nak43Hljowkm4gCDBBdv4mD9EnMrhwA5yTNtrfUF5630b2df\"}', '2025-06-14 18:20:34', NULL, '2025-06-14 18:20:28', '2025-06-14 18:20:34'),
(87, 'App\\Models\\User', 92, 'impersonation_token', '8c6ac8b3de858b2955185226c72f87ad2dccba8d37584f81ea9193e9fc2de8e6', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"85|Nak43Hljowkm4gCDBBdv4mD9EnMrhwA5yTNtrfUF5630b2df\"}', '2025-06-14 18:21:11', NULL, '2025-06-14 18:21:11', '2025-06-14 18:21:11'),
(88, 'App\\Models\\User', 93, 'impersonation_token', '800e07f037298fb69f653e0186fd425236a0b4f87aaaa13402b1a506eed47368', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"85|Nak43Hljowkm4gCDBBdv4mD9EnMrhwA5yTNtrfUF5630b2df\"}', '2025-06-14 18:22:20', NULL, '2025-06-14 18:21:27', '2025-06-14 18:22:20'),
(89, 'App\\Models\\User', 89, 'impersonation_token', 'fe1f5f5ee4d0e3096b242bf747a7ee5eb810035fc5ac178f2944c66866660d83', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"85|Nak43Hljowkm4gCDBBdv4mD9EnMrhwA5yTNtrfUF5630b2df\"}', '2025-06-14 18:27:47', NULL, '2025-06-14 18:27:21', '2025-06-14 18:27:47'),
(90, 'App\\Models\\User', 93, 'impersonation_token', '1d51a7c0046520eb9206a5903da69255422031884833599bc0efe4939294f679', '{\"is_impersonation\":true,\"impersonator_id\":89,\"original_token\":\"89|hSZ9gu2LOtyII7AMM7PgkYQCQvcCNTMEis844U1B02ca0d19\"}', '2025-06-14 18:27:32', NULL, '2025-06-14 18:27:31', '2025-06-14 18:27:32'),
(93, 'App\\Models\\User', 89, 'impersonation_token', 'e581ae3f739586f600c4be9256965e3b23d596ad0eb9c91db3286bccb0889519', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"92|6aBASrOxiGe4gl1G9d5yBXvccKkzfyBkKTtlE5DJb5370283\"}', '2025-06-14 18:30:56', NULL, '2025-06-14 18:30:28', '2025-06-14 18:30:56'),
(96, 'App\\Models\\User', 89, 'impersonation_token', '7e63104ea4532eda1f5c9f2ed5ca30b00b702db09867f7e28ca06b7bbe0eb2a9', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"95|2XFiB3pJMz3USjVAfCmfkGiRVP3WSAHagm82hIqO7e3fab0f\"}', '2025-06-14 18:34:39', NULL, '2025-06-14 18:34:36', '2025-06-14 18:34:39'),
(102, 'App\\Models\\User', 89, 'impersonation_token', 'd61cc52a560efb53ab3cf1624cd06e01b05dd570545af0511dcdf9040634de5d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"101|8A60VtnaJ2hZW3wdBqaOUXS3u6etTHCeF5aco7GU00cf3e13\"}', '2025-06-14 18:48:46', NULL, '2025-06-14 18:47:02', '2025-06-14 18:48:46'),
(103, 'App\\Models\\User', 92, 'impersonation_token', 'e5fa7d3bbbdaf5f6c459fda067348534fb25649a4d6cd5d6d91164b7e18914ee', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"101|8A60VtnaJ2hZW3wdBqaOUXS3u6etTHCeF5aco7GU00cf3e13\"}', '2025-06-14 18:54:14', NULL, '2025-06-14 18:49:39', '2025-06-14 18:54:14'),
(104, 'App\\Models\\User', 93, 'impersonation_token', '16300bcea189281b7abdc620bd4313bc6183564db66489e7a535c2e45e367220', '{\"is_impersonation\":true,\"impersonator_id\":89,\"original_token\":\"7|64RCz4JZ4XH60roUsF5UPcTLLhgfAx2JzR6L33EB40eb4e30\"}', '2025-06-16 12:34:54', NULL, '2025-06-15 06:23:39', '2025-06-16 12:34:54'),
(105, 'App\\Models\\User', 100, 'impersonation_token', 'fea6b6a28e810e0be49f97caf45b6e6f73a13e1fa17d6b889721079cad5bb65e', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"35|5gxF1ceN6XEgimTrg45mf5PpYy0NshNfscm3ouzq29447d57\"}', '2025-06-15 22:15:04', NULL, '2025-06-15 22:03:48', '2025-06-15 22:15:04'),
(106, 'App\\Models\\User', 100, 'auth_token', '740b97ab12a97e8bc4b011878b18eb66c1bd817f1a134870eb7afbcd4265aacb', '[\"*\"]', '2025-06-15 22:26:28', NULL, '2025-06-15 22:26:15', '2025-06-15 22:26:28'),
(107, 'App\\Models\\User', 100, 'auth_token', '6e1f9a2c8c65c853ad5ffc6620fbf3c81be241d6ea99b2e22d032d0708d09544', '[\"*\"]', '2025-06-15 23:26:43', NULL, '2025-06-15 22:26:53', '2025-06-15 23:26:43'),
(108, 'App\\Models\\User', 103, 'impersonation_token', '77c0b32f7b69b9e14bb22a3649a606dc53d36074788e6d6c9f752211384fcf33', '{\"is_impersonation\":true,\"impersonator_id\":100,\"original_token\":\"107|YT2KOTBwtwmBvA80ixCYbxKDRc3Zkjjh3h9FOTyKa67b9dd7\"}', '2025-06-15 22:31:02', NULL, '2025-06-15 22:30:46', '2025-06-15 22:31:02'),
(109, 'App\\Models\\User', 101, 'impersonation_token', 'ee228a1c5e32fb206de37d286faa2dc01ac831137f3da4f52e47290b1127f11c', '{\"is_impersonation\":true,\"impersonator_id\":100,\"original_token\":\"107|YT2KOTBwtwmBvA80ixCYbxKDRc3Zkjjh3h9FOTyKa67b9dd7\"}', '2025-06-15 22:47:04', NULL, '2025-06-15 22:47:03', '2025-06-15 22:47:04'),
(110, 'App\\Models\\User', 101, 'impersonation_token', 'a71c1dc240516f74b08c59f3033f000bfee38800c12274efee2ab1c3a3b45c85', '{\"is_impersonation\":true,\"impersonator_id\":100,\"original_token\":\"107|YT2KOTBwtwmBvA80ixCYbxKDRc3Zkjjh3h9FOTyKa67b9dd7\"}', '2025-06-15 23:16:38', NULL, '2025-06-15 22:53:55', '2025-06-15 23:16:38'),
(111, 'App\\Models\\User', 101, 'impersonation_token', '3dbb7c2e35baf2a1cf2437d0554f80d1de7f24da1ccdb4645c509520171911a9', '{\"is_impersonation\":true,\"impersonator_id\":100,\"original_token\":\"107|YT2KOTBwtwmBvA80ixCYbxKDRc3Zkjjh3h9FOTyKa67b9dd7\"}', '2025-06-15 23:21:09', NULL, '2025-06-15 23:20:24', '2025-06-15 23:21:09'),
(112, 'App\\Models\\User', 101, 'impersonation_token', 'eac0e63c345f40cafec20babf793a294ab927636b796beeabdc1d51b5c6e00d9', '{\"is_impersonation\":true,\"impersonator_id\":100,\"original_token\":\"107|YT2KOTBwtwmBvA80ixCYbxKDRc3Zkjjh3h9FOTyKa67b9dd7\"}', '2025-06-15 23:33:29', NULL, '2025-06-15 23:26:43', '2025-06-15 23:33:29'),
(114, 'App\\Models\\User', 92, 'impersonation_token', '95463937b9b45882f91e414ed4e135193d184508f624ebfa8ecbc7568e2ce747', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"113|nxvIDmPRDW6fKncQiizwE3WsMQhQ9IM6B5j4OZWhfbcdca32\"}', '2025-06-16 02:58:04', NULL, '2025-06-16 02:56:30', '2025-06-16 02:58:04'),
(118, 'App\\Models\\User', 93, 'impersonation_token', '49418c254bedfc8fd36549a4b99fe147253f0c2abf71ca1349f78030e5994a5d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"117|n2ltOdIhPgNHhydD5WlHCmYrTEacRpV9zWKxrS83aa761bd0\"}', '2025-06-16 03:17:43', NULL, '2025-06-16 03:01:55', '2025-06-16 03:17:43'),
(119, 'App\\Models\\User', 102, 'impersonation_token', 'ad7769f3c990cf1788ab923fa814e2ac51a09ba16f37954298c8bf742e7110bd', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"116|x6FLv1dPWHBWUVdOuT1lJZ49rxuiwJAHbjmQN55S0b3d3c9b\"}', '2025-06-16 03:04:32', NULL, '2025-06-16 03:02:10', '2025-06-16 03:04:32'),
(123, 'App\\Models\\User', 95, 'impersonation_token', '2400731598da23d5e676ba6993a31e7c2a20fd392f9c49967505eee400257512', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"65|fnfnAD1p0QQBlFOsnlILR1ugcGg2TYtqXXOyllYNc1eba4cc\"}', '2025-06-16 07:58:08', NULL, '2025-06-16 07:57:38', '2025-06-16 07:58:08'),
(125, 'App\\Models\\User', 92, 'impersonation_token', 'cc536be8817dc2d6bfecef35eca8e1b2d075a51ac61754712977fcecd181fc04', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"65|fnfnAD1p0QQBlFOsnlILR1ugcGg2TYtqXXOyllYNc1eba4cc\"}', '2025-06-16 10:22:24', NULL, '2025-06-16 07:58:34', '2025-06-16 10:22:24'),
(126, 'App\\Models\\User', 101, 'impersonation_token', '05e8ab59515c3c2f0e470befb6b70fd8ea42983d045e6820d1cc5115fa27c26d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"124|X2RPdUnAqd9DCcqtVinKhjAV0kxN8wEJMFcjFEuS738bae6a\"}', '2025-06-16 09:22:24', NULL, '2025-06-16 09:17:24', '2025-06-16 09:22:24'),
(127, 'App\\Models\\User', 101, 'impersonation_token', '118be97bb62ee1ea605c0642ccac8d2e2131eeda720eaac3a212f4280a9c3c98', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"35|5gxF1ceN6XEgimTrg45mf5PpYy0NshNfscm3ouzq29447d57\"}', '2025-06-16 10:30:57', NULL, '2025-06-16 10:30:24', '2025-06-16 10:30:57'),
(129, 'App\\Models\\User', 100, 'auth_token', '6d51a8aa8d1194a5b8b1a3529c11233f5473fc0b63a0efac412add899574f176', '[\"*\"]', '2025-06-16 10:49:54', NULL, '2025-06-16 10:36:46', '2025-06-16 10:49:54'),
(130, 'App\\Models\\User', 101, 'impersonation_token', '04ae84b801c0e0831ab410138ca38c3ea67f05b369e6fe7532dd8114b8b7c3cb', '{\"is_impersonation\":true,\"impersonator_id\":100,\"original_token\":\"129|PEVhCYfewDIb27N9AhPpSZOwJnIwwAUmv1XCbk7V17ae5b8b\"}', '2025-06-16 10:43:55', NULL, '2025-06-16 10:37:29', '2025-06-16 10:43:55'),
(132, 'App\\Models\\User', 100, 'impersonation_token', 'd224cb9ab3ede86095efa6e576b4a6f9c2fd38e03a4f857f2031f211e6053b7c', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"131|0mVCamnpDxuXGKHSFT5syduwL16wJKRWAbKtaShOa3516a5e\"}', '2025-06-16 10:39:07', NULL, '2025-06-16 10:39:03', '2025-06-16 10:39:07'),
(133, 'App\\Models\\User', 102, 'impersonation_token', 'a37da714b70603cc3ad4addaae55061b547a070a74525f7b00eff11e01cb4cfa', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"131|0mVCamnpDxuXGKHSFT5syduwL16wJKRWAbKtaShOa3516a5e\"}', '2025-06-16 10:41:01', NULL, '2025-06-16 10:39:48', '2025-06-16 10:41:01'),
(134, 'App\\Models\\User', 101, 'impersonation_token', '50679b5b2d055c72361d8e86752d4d58bd4b2951c128b1ae00c3d84ca6e14a1a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"131|0mVCamnpDxuXGKHSFT5syduwL16wJKRWAbKtaShOa3516a5e\"}', '2025-06-16 10:43:59', NULL, '2025-06-16 10:41:34', '2025-06-16 10:43:59'),
(135, 'App\\Models\\User', 101, 'impersonation_token', '171a6c656558b8c0bd95f28ec356ef34451df4098b2c4e3c51701f5198e383fb', '{\"is_impersonation\":true,\"impersonator_id\":100,\"original_token\":\"129|PEVhCYfewDIb27N9AhPpSZOwJnIwwAUmv1XCbk7V17ae5b8b\"}', '2025-06-16 10:51:15', NULL, '2025-06-16 10:49:54', '2025-06-16 10:51:15'),
(136, 'App\\Models\\User', 101, 'impersonation_token', '368de1f44bd37556b7e78b55580d53dc25fb6d5da4de9b07c7f9ff258838a86d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"124|X2RPdUnAqd9DCcqtVinKhjAV0kxN8wEJMFcjFEuS738bae6a\"}', '2025-06-16 11:02:54', NULL, '2025-06-16 11:02:26', '2025-06-16 11:02:54'),
(137, 'App\\Models\\User', 101, 'impersonation_token', 'f6707f8570eaf1073afec97bf90b9d5783c36d33ce49a782fc832c7c99fcde51', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"124|X2RPdUnAqd9DCcqtVinKhjAV0kxN8wEJMFcjFEuS738bae6a\"}', '2025-06-16 11:13:55', NULL, '2025-06-16 11:07:39', '2025-06-16 11:13:55'),
(138, 'App\\Models\\User', 101, 'impersonation_token', 'b45a8acccaa8489ff916d92be9a0dc9ba960e509ee373b8700f1ae1ffca23ea6', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"131|0mVCamnpDxuXGKHSFT5syduwL16wJKRWAbKtaShOa3516a5e\"}', '2025-06-16 11:45:06', NULL, '2025-06-16 11:37:18', '2025-06-16 11:45:06'),
(153, 'App\\Models\\User', 93, 'impersonation_token', 'd7321ea1041b0151124a9aceb8a5122e0010c5c0a281ebdb17209caa75030fb8', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"152|aQKfx5fXNccvDvw3Kq2mj6nBW04nVBP50eOdavQf44e0a87e\"}', '2025-06-16 12:48:30', NULL, '2025-06-16 12:48:27', '2025-06-16 12:48:30'),
(160, 'App\\Models\\User', 92, 'impersonation_token', 'd526f07e822bda67ab6b90a3f3bbc70f30a1fea1e9630b2e674e5cb72b02ed11', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"159|4vmedAYljIcJzADTAv30fk1YjenEZOebnPzRLHkw51ba680f\"}', '2025-06-16 14:43:17', NULL, '2025-06-16 14:42:09', '2025-06-16 14:43:17'),
(162, 'App\\Models\\User', 92, 'impersonation_token', 'baf6e5513dddde707928d966219ba8d81f7b650b5820a7c7547ecb80fb634dca', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"161|RbfYd8aTQ2uDKulOP3ZhM7jn5C1ddhNeiX5xRgBTc427b317\"}', '2025-06-17 07:24:51', NULL, '2025-06-16 14:43:33', '2025-06-17 07:24:51'),
(163, 'App\\Models\\User', 97, 'impersonation_token', 'fb933ad98ab4c57e0f781642c239f259dee1fae9ea385cd2c9cafa87c4f63135', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"159|4vmedAYljIcJzADTAv30fk1YjenEZOebnPzRLHkw51ba680f\"}', '2025-06-16 14:47:21', NULL, '2025-06-16 14:44:32', '2025-06-16 14:47:21'),
(164, 'App\\Models\\User', 89, 'impersonation_token', '42c9cc6700878a489d89d6f7ab7f50c4d3636a957106e437ddb5c9e0d22f4bd9', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"159|4vmedAYljIcJzADTAv30fk1YjenEZOebnPzRLHkw51ba680f\"}', '2025-06-16 18:57:50', NULL, '2025-06-16 18:57:42', '2025-06-16 18:57:50'),
(166, 'App\\Models\\User', 102, 'impersonation_token', 'a49e76627a502791a59accc84aced949232880411e72e1eec0784a9c5825e5d6', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"165|7M8NdhbNnnPcVta0pBeb1lZv1LvAW0nYTUMqlLVr112fe2fe\"}', '2025-06-16 19:21:19', NULL, '2025-06-16 18:58:22', '2025-06-16 19:21:19'),
(169, 'App\\Models\\User', 92, 'impersonation_token', '95ae49e4003da2f5ca560b6298f5f12e19856acbaff745ef9f06b017037914c3', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"168|K3rjQiM2MXEk4p1AWri3nMDUS4H5DQbZS2DgxhRrbe1162ac\"}', '2025-06-16 19:23:30', NULL, '2025-06-16 19:23:30', '2025-06-16 19:23:30'),
(171, 'App\\Models\\User', 94, 'impersonation_token', 'c4922f873418fe9afd865c032b0dc89d9eef191c0d93a920583ed26ee90d7e5c', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"170|8AkgP9wvOZsgssNEJ9CNtM57zWe2h8PPvs4in1Fp171f2897\"}', '2025-06-16 19:31:48', NULL, '2025-06-16 19:24:08', '2025-06-16 19:31:48'),
(172, 'App\\Models\\User', 95, 'impersonation_token', '1e512da80e2174f1927dbf698ec90f388716153d62760d16d951b088d28f66ae', '{\"is_impersonation\":true,\"impersonator_id\":94,\"original_token\":\"171|Ny0V602U8pgw7AtxDYCdNMXPs9CWNIqkcxtKjet413eb5e35\"}', '2025-06-16 19:31:45', NULL, '2025-06-16 19:24:26', '2025-06-16 19:31:45'),
(176, 'App\\Models\\User', 92, 'impersonation_token', '296fb0351281439fa759c4aa844cdb476fb706bd7fce07f1d8aa71682d194e31', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"175|GuNM1dGWr77yhl5xyQNpRv8nbAMusS48NFjAyqIA527837b9\"}', '2025-06-16 23:15:31', NULL, '2025-06-16 23:15:30', '2025-06-16 23:15:31'),
(177, 'App\\Models\\User', 97, 'impersonation_token', '6d88e48820a5ad799fc651dd5673f5e0e2cb4a29d7aa2f8527b0cc798435504f', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"175|GuNM1dGWr77yhl5xyQNpRv8nbAMusS48NFjAyqIA527837b9\"}', '2025-06-16 23:16:03', NULL, '2025-06-16 23:15:54', '2025-06-16 23:16:03'),
(178, 'App\\Models\\User', 103, 'impersonation_token', '026aff6ee4e3e3a319332e84c7cdccd1f19969a838cf4771b7caf11c6e26174f', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"175|GuNM1dGWr77yhl5xyQNpRv8nbAMusS48NFjAyqIA527837b9\"}', '2025-06-16 23:16:29', NULL, '2025-06-16 23:16:21', '2025-06-16 23:16:29'),
(179, 'App\\Models\\User', 103, 'impersonation_token', '45c05953775460044e37b2ba6697da5be6c5ca7865c680780a53c82829a1f62a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"175|GuNM1dGWr77yhl5xyQNpRv8nbAMusS48NFjAyqIA527837b9\"}', '2025-06-16 23:16:50', NULL, '2025-06-16 23:16:39', '2025-06-16 23:16:50'),
(182, 'App\\Models\\User', 92, 'impersonation_token', 'd722a87ded85ad3b032f9b3f69a7f918e96f5992b337ea99c7bb271db65819a9', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"181|OnmrYe0NZpKeH9FSguyazyOM5pEw61B0lXWTSBT5fdea35d4\"}', '2025-06-16 23:22:49', NULL, '2025-06-16 23:22:48', '2025-06-16 23:22:49'),
(184, 'App\\Models\\User', 100, 'impersonation_token', '78c6ff824815f65f1df0d5fb958f5bf9176b6f101e119ccf93bd6c95d4acdae3', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"183|sBI9yTf6tr9AqSBcG1xOkovfGSeJpRkFTihOXrfRe3f98ff5\"}', '2025-06-17 00:34:49', NULL, '2025-06-17 00:34:39', '2025-06-17 00:34:49'),
(185, 'App\\Models\\User', 105, 'impersonation_token', '1c4bfdf58c5ce1d57d0f6d1ff74637c805612550f8e8ab304c480000de1073d3', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"183|sBI9yTf6tr9AqSBcG1xOkovfGSeJpRkFTihOXrfRe3f98ff5\"}', '2025-06-17 01:28:32', NULL, '2025-06-17 01:28:10', '2025-06-17 01:28:32'),
(186, 'App\\Models\\User', 105, 'impersonation_token', 'cb9be1d0f465076d256204baa6f9b138ad4ec9b089f493752755e0ef3b8c8aa4', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"183|sBI9yTf6tr9AqSBcG1xOkovfGSeJpRkFTihOXrfRe3f98ff5\"}', '2025-06-17 01:41:27', NULL, '2025-06-17 01:28:59', '2025-06-17 01:41:27'),
(187, 'App\\Models\\User', 105, 'auth_token', '2a586de4983268b76eccd2785a8d9a06197baaebc4fe318eb01886e7e1966526', '[\"*\"]', '2025-06-17 02:49:52', NULL, '2025-06-17 01:45:20', '2025-06-17 02:49:52'),
(188, 'App\\Models\\User', 106, 'impersonation_token', 'ced5404a1413554d601f0db82552d1334ae4ad3efc5660d38c9abafd08a50f29', '{\"is_impersonation\":true,\"impersonator_id\":105,\"original_token\":\"187|sdvA5NDqxpznrNcVIe9hday96N4DvkIoN4FejNy00d17e7bd\"}', '2025-06-17 01:45:43', NULL, '2025-06-17 01:45:32', '2025-06-17 01:45:43'),
(189, 'App\\Models\\User', 100, 'impersonation_token', 'f75a91f70a527064180aa02200acda14827d7f1c565ed190ef803c06f5bbdf83', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"159|4vmedAYljIcJzADTAv30fk1YjenEZOebnPzRLHkw51ba680f\"}', '2025-06-17 05:58:33', NULL, '2025-06-17 05:52:23', '2025-06-17 05:58:33'),
(191, 'App\\Models\\User', 105, 'impersonation_token', '0ddc3cf1931efc41a32e14e9eb5d21f95c7a2f39c163b915da374a983c6b24e3', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"190|S2zACdQbXSmcZ9FfxUbSoujBvg9JqPoGQzsWnzAEa142a0a7\"}', '2025-06-17 07:05:32', NULL, '2025-06-17 07:01:02', '2025-06-17 07:05:32'),
(192, 'App\\Models\\User', 103, 'impersonation_token', 'ac5715978dea316596e60db20642687b30b49ee723ca4346048995240468ded9', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"190|S2zACdQbXSmcZ9FfxUbSoujBvg9JqPoGQzsWnzAEa142a0a7\"}', '2025-06-17 07:10:22', NULL, '2025-06-17 07:10:19', '2025-06-17 07:10:22'),
(194, 'App\\Models\\User', 93, 'impersonation_token', '857cea0f086a9d85a989871df69095a0f535fa0bf9e39b99c076907cecabad15', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"190|S2zACdQbXSmcZ9FfxUbSoujBvg9JqPoGQzsWnzAEa142a0a7\"}', '2025-06-17 08:09:03', NULL, '2025-06-17 07:38:33', '2025-06-17 08:09:03'),
(196, 'App\\Models\\User', 93, 'impersonation_token', '8c01959960f7ec3b319a834053b112c5db54f71849b9a063499cb8898dbee9f3', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"195|O8wHlfwR8YUooa8Fvqa7tM4z1Hu2VM9JShuW8R2R2bdef524\"}', '2025-06-17 08:14:09', NULL, '2025-06-17 08:14:06', '2025-06-17 08:14:09'),
(199, 'App\\Models\\User', 95, 'impersonation_token', '0213decadf0854ad199a2562bf590c3ad85734564ac223652d6ef7b9222ddf86', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"198|exGB16r2kRQ5F300vdFYuzqI0vChF1hcY83PDMIVf873ff07\"}', '2025-06-17 08:40:04', NULL, '2025-06-17 08:16:36', '2025-06-17 08:40:04'),
(201, 'App\\Models\\User', 98, 'impersonation_token', 'dc486ba42b243e660c1ee847306ebfbca0a90063321cb6974f54d8165f3684e7', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"200|uqsxkiDLJUH0PN1wpK8WwzaHtPMaNFyGpCai2mOAf1f94c0b\"}', '2025-06-17 08:58:44', NULL, '2025-06-17 08:58:39', '2025-06-17 08:58:44'),
(202, 'App\\Models\\User', 100, 'impersonation_token', '1112ce9789afd3787c8df7a31d7fe820ac03994178d9d6ec03e6357e48de7222', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"195|O8wHlfwR8YUooa8Fvqa7tM4z1Hu2VM9JShuW8R2R2bdef524\"}', '2025-06-17 09:01:05', NULL, '2025-06-17 09:00:33', '2025-06-17 09:01:05'),
(203, 'App\\Models\\User', 93, 'impersonation_token', 'c8c3133b79c8ee2f1150a88a5372d11376199e0576ef187542f4fcc2ae4bf63d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"195|O8wHlfwR8YUooa8Fvqa7tM4z1Hu2VM9JShuW8R2R2bdef524\"}', '2025-06-17 09:09:04', NULL, '2025-06-17 09:09:01', '2025-06-17 09:09:04'),
(206, 'App\\Models\\User', 92, 'impersonation_token', 'd60b4571d9afcaca3f77ffac94fbf8c91fa68a86ad1bfd6ec1ef822e5f7e7790', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"204|DJbNQxL2Eug6R2jjsponZ5PH4UYHoTHd4xiGSNjA9ac58844\"}', '2025-06-17 09:49:55', NULL, '2025-06-17 09:49:54', '2025-06-17 09:49:55'),
(207, 'App\\Models\\User', 103, 'impersonation_token', 'f982c66862b23001a7a4f93122bb30eeac2bb0bbee94934495502b00507f4c66', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"195|O8wHlfwR8YUooa8Fvqa7tM4z1Hu2VM9JShuW8R2R2bdef524\"}', '2025-06-17 09:54:59', NULL, '2025-06-17 09:54:21', '2025-06-17 09:54:59'),
(208, 'App\\Models\\User', 93, 'impersonation_token', '2445e9526e342508514fdfd3c10b01e6246b1739b93a61f139423e5c7a5765a5', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"205|OKWbJuBVIJ1wsO6nLXkMZhh3DJikzFhUn0oBnRJ19264ed6b\"}', '2025-06-17 11:04:15', NULL, '2025-06-17 10:36:29', '2025-06-17 11:04:15'),
(210, 'App\\Models\\User', 89, 'impersonation_token', '805a53731884fcd478aefca41ec63879883d8ac2ce3b4a99cb7886e0b677fee5', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"205|OKWbJuBVIJ1wsO6nLXkMZhh3DJikzFhUn0oBnRJ19264ed6b\"}', '2025-06-17 11:50:22', NULL, '2025-06-17 11:18:31', '2025-06-17 11:50:22'),
(212, 'App\\Models\\User', 101, 'impersonation_token', '658555df6e6fc16c71988ce9f18fb2d9eedc7e7e26ea8696324d72180578c6df', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"211|XaXP0WmWDfoNi70mNRqyUtsRNQr7GBcgge12PFea1677e79d\"}', '2025-06-17 11:56:10', NULL, '2025-06-17 11:55:14', '2025-06-17 11:56:10'),
(213, 'App\\Models\\User', 100, 'impersonation_token', '443e30627c28091ae11161357ae43d87d012c60bb0e050ec8d319a6538d8966f', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"211|XaXP0WmWDfoNi70mNRqyUtsRNQr7GBcgge12PFea1677e79d\"}', '2025-06-17 12:46:06', NULL, '2025-06-17 11:56:53', '2025-06-17 12:46:06'),
(215, 'App\\Models\\User', 98, 'impersonation_token', 'c86c1b0d5a19114736af8da92fa168fde26ea818ce963a28144afe7f41d04957', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"214|Glw4zniqSPLY6RI8u1j2YU6xds4amtnLAYNGbM2g70668d7f\"}', '2025-06-17 12:10:17', NULL, '2025-06-17 12:10:08', '2025-06-17 12:10:17'),
(216, 'App\\Models\\User', 97, 'impersonation_token', '6f474c64500f7133a097f2462d5bb24d63d6649954c92244aaed1e327d98ac1c', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"214|Glw4zniqSPLY6RI8u1j2YU6xds4amtnLAYNGbM2g70668d7f\"}', '2025-06-17 12:10:44', NULL, '2025-06-17 12:10:43', '2025-06-17 12:10:44'),
(220, 'App\\Models\\User', 114, 'impersonation_token', '29773cc37200d1ef0bf6c8b04c8b87187985b904672a2dfde44061b3b56a4546', '{\"is_impersonation\":true,\"impersonator_id\":108,\"original_token\":\"219|3dvZsW0t2eVNzVFwOOD9knsHMB47jj8Buwi4QIjp506fdbb5\"}', '2025-06-17 12:29:06', NULL, '2025-06-17 12:26:47', '2025-06-17 12:29:06'),
(223, 'App\\Models\\User', 116, 'impersonation_token', '2b60ffdc584af8edf0db81b5631731ac7ee99105c5dd5061d4333ba49ea59b28', '{\"is_impersonation\":true,\"impersonator_id\":108,\"original_token\":\"222|rCQlCBzEjijfWRr3KzWuFKeMkgq5JIyDj7HNVE7cc53e4a01\"}', '2025-06-17 12:38:47', NULL, '2025-06-17 12:33:37', '2025-06-17 12:38:47'),
(224, 'App\\Models\\User', 93, 'impersonation_token', '6f7d092a6470f470e40fbfad11b605ffca37520b5fa30b2bc41147258acda989', '{\"is_impersonation\":true,\"impersonator_id\":89,\"original_token\":\"209|s2Ec39VCHti6kegppX8EPuNXCfzTG66DpT0vsyX2eb10d225\"}', '2025-06-17 12:50:23', NULL, '2025-06-17 12:41:01', '2025-06-17 12:50:23'),
(227, 'App\\Models\\User', 97, 'impersonation_token', 'c8fcd3ce09d3e6492944e108f11743f76a379b79902fc2c6af0c85c3da8bc051', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"226|hTztU8FtFebqSWr16znlJ0nfaEBYZNebni5pIz0kde8bc75b\"}', '2025-06-17 13:49:28', NULL, '2025-06-17 13:49:27', '2025-06-17 13:49:28'),
(229, 'App\\Models\\User', 116, 'impersonation_token', '464c0c84169945052d7cc8e21367e80a970cfe4811f66558115057ae420aee3b', '{\"is_impersonation\":true,\"impersonator_id\":108,\"original_token\":\"228|wt3r0TR97o6Hqe09ooGGTYczIcBhxxzIOvpn6x5V1ec5ef04\"}', '2025-06-17 13:50:06', NULL, '2025-06-17 13:50:05', '2025-06-17 13:50:06'),
(230, 'App\\Models\\User', 117, 'impersonation_token', '5d0299f146ad1668d88f20a9e518d870fc8b59eec82bdc1f70aff6ff021da1f1', '{\"is_impersonation\":true,\"impersonator_id\":108,\"original_token\":\"228|wt3r0TR97o6Hqe09ooGGTYczIcBhxxzIOvpn6x5V1ec5ef04\"}', '2025-06-17 13:51:43', NULL, '2025-06-17 13:51:05', '2025-06-17 13:51:43'),
(231, 'App\\Models\\User', 117, 'impersonation_token', 'e12578be8dc516761bc6c0d174d3f74e16919a0fa6a5b3331de3638bc504db79', '{\"is_impersonation\":true,\"impersonator_id\":108,\"original_token\":\"228|wt3r0TR97o6Hqe09ooGGTYczIcBhxxzIOvpn6x5V1ec5ef04\"}', '2025-06-17 14:00:45', NULL, '2025-06-17 13:52:09', '2025-06-17 14:00:45'),
(232, 'App\\Models\\User', 93, 'impersonation_token', 'f8fdef1b6cfafefef666a0711bcacc546375ab7d16665b26deccbc6b3387fb69', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"225|N4qxSeBL7PF9fzKLcV5Z4kEnbbz9D9XBPOoUm49r45ad688a\"}', '2025-06-17 14:08:00', NULL, '2025-06-17 13:53:33', '2025-06-17 14:08:00'),
(233, 'App\\Models\\User', 93, 'impersonation_token', 'f5f553da9aa77bbfac820501a91c684877adc1392f6c8b582b13c58f41595a83', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"225|N4qxSeBL7PF9fzKLcV5Z4kEnbbz9D9XBPOoUm49r45ad688a\"}', '2025-06-17 14:27:25', NULL, '2025-06-17 14:20:44', '2025-06-17 14:27:25'),
(237, 'App\\Models\\User', 122, 'impersonation_token', '0c5872b43c12d28b3ba194acb0c9dfe4fae1a05200f2f873c50209b29bf7dfad', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"236|N1u9OAev8tAZXHbLi417CfOS3M6CeLVaZnTPlmFq328a72df\"}', '2025-06-17 14:43:21', NULL, '2025-06-17 14:43:07', '2025-06-17 14:43:21'),
(238, 'App\\Models\\User', 98, 'impersonation_token', 'f1da6e63a1b09360c6a76c7ec07314bd3202bd22c2a2e617de0794c381e7a2cb', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"236|N1u9OAev8tAZXHbLi417CfOS3M6CeLVaZnTPlmFq328a72df\"}', '2025-06-17 14:46:23', NULL, '2025-06-17 14:46:19', '2025-06-17 14:46:23'),
(240, 'App\\Models\\User', 114, 'impersonation_token', 'ed2993ae98b9dcda33b4d3dd188dbe212c607646a2737ea235482dbdff26e386', '{\"is_impersonation\":true,\"impersonator_id\":108,\"original_token\":\"239|sqlbeTxKE3oV5FMt5m8PRbEkK1LZ2RQKALHO4uDm95b3bd8c\"}', '2025-06-17 14:50:48', NULL, '2025-06-17 14:50:47', '2025-06-17 14:50:48'),
(243, 'App\\Models\\User', 109, 'impersonation_token', '4906e5f7d3959c7e298e74c4cff394b6cfbba57e6c8d149116ce55fd611d45cb', '{\"is_impersonation\":true,\"impersonator_id\":108,\"original_token\":\"242|bpp2QcOC9OR3wVuhNbozuumE3E3SxGLyiSHfgViPff3b5e72\"}', '2025-06-17 14:51:54', NULL, '2025-06-17 14:51:54', '2025-06-17 14:51:54'),
(246, 'App\\Models\\User', 105, 'impersonation_token', '01631a80983eb2ab6c466bf6377d387afc6ca4fe9ca4f5ab4edfb4ca53f92232', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"244|YLci7w68dfQ8qqJ30YEneQ0pV0Ous5rvyr7x0Uu9c7c28091\"}', '2025-06-17 15:05:30', NULL, '2025-06-17 15:05:24', '2025-06-17 15:05:30'),
(250, 'App\\Models\\User', 108, 'impersonation_token', 'd72bf2990f8ff49db5c8e1d113cbcace83c5a6f72ad5c3db99f5b01f3c5ebb79', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"244|YLci7w68dfQ8qqJ30YEneQ0pV0Ous5rvyr7x0Uu9c7c28091\"}', '2025-06-17 15:42:47', NULL, '2025-06-17 15:13:04', '2025-06-17 15:42:47'),
(252, 'App\\Models\\User', 92, 'impersonation_token', '7d93c9990de8c357c8fa269c5bdf381cc459e6d6cd5a62d24395aa8bd43d42df', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"251|IsrLA4AJULou8GXeU0O5Ket2zjg6DetUahtZ0cT610ebf200\"}', '2025-06-17 15:38:24', NULL, '2025-06-17 15:38:24', '2025-06-17 15:38:24'),
(253, 'App\\Models\\User', 108, 'impersonation_token', '1b838fe4c7c7339fc965f81d3e4bce7c986ef189239609e92245a0b6eb2c4f36', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"251|IsrLA4AJULou8GXeU0O5Ket2zjg6DetUahtZ0cT610ebf200\"}', '2025-06-17 15:40:03', NULL, '2025-06-17 15:38:35', '2025-06-17 15:40:03'),
(262, 'App\\Models\\User', 128, 'impersonation_token', 'b1f9c2a8eb0a717780865ae56c729597c3b68c0d827b414aa287f27d9e165607', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"261|Ye0DTYM4uD6ZYXf1fb9IkD0bTJ974m2pF92yEkAR62c8e501\"}', '2025-06-18 07:31:49', NULL, '2025-06-17 19:53:45', '2025-06-18 07:31:49'),
(263, 'App\\Models\\User', 128, 'impersonation_token', '65a7339d41c1bffde7d15a76e0b6dfd7d044c597133234c0859e2263abe36615', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"259|zBxw4rnsfeWHxMAL3sjkrVMvt8Sdgu6xPKy7kqcK58fca4dd\"}', '2025-06-17 20:01:11', NULL, '2025-06-17 20:00:43', '2025-06-17 20:01:11'),
(264, 'App\\Models\\User', 128, 'impersonation_token', '93a786ca3051949dd909d54d3dbad6d728cf1b2979f8f29f9925a7721c8ca330', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"259|zBxw4rnsfeWHxMAL3sjkrVMvt8Sdgu6xPKy7kqcK58fca4dd\"}', '2025-06-17 20:24:07', NULL, '2025-06-17 20:20:02', '2025-06-17 20:24:07'),
(265, 'App\\Models\\User', 131, 'impersonation_token', '5f18102966817a57f67b6bfdeb44e52a95623a4cb45ce9057333022284fc1b29', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"259|zBxw4rnsfeWHxMAL3sjkrVMvt8Sdgu6xPKy7kqcK58fca4dd\"}', '2025-06-17 20:29:06', NULL, '2025-06-17 20:24:51', '2025-06-17 20:29:06'),
(267, 'App\\Models\\User', 130, 'impersonation_token', '9b4747dba2a2bee70cb7ea2aa6d365f417e00500460f5a51841eff6978e93a83', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"266|hGuOUtNFT6LO7mT7makdfNUI5xfQQTwGAhOSYw3Sa5eaaad5\"}', '2025-06-17 20:28:28', NULL, '2025-06-17 20:28:28', '2025-06-17 20:28:28'),
(268, 'App\\Models\\User', 128, 'impersonation_token', '00d1987f126da6b4162fba65b0c4d9b41fbf021f67c1a7fcc5f9e379b42c1f68', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"259|zBxw4rnsfeWHxMAL3sjkrVMvt8Sdgu6xPKy7kqcK58fca4dd\"}', '2025-06-17 20:31:01', NULL, '2025-06-17 20:30:53', '2025-06-17 20:31:01'),
(269, 'App\\Models\\User', 131, 'impersonation_token', '6d64bb8af0325704bc81d8c618934d6f93d099c655d12855f41b3562fd9bc302', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"259|zBxw4rnsfeWHxMAL3sjkrVMvt8Sdgu6xPKy7kqcK58fca4dd\"}', '2025-06-17 20:38:03', NULL, '2025-06-17 20:31:15', '2025-06-17 20:38:03'),
(274, 'App\\Models\\User', 131, 'impersonation_token', '192f537993e7941c1fc5dc5099c95ab50b45671b79dd400feb6bc4ed543bc2c8', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"272|qbWbsjDhRQcJe27qBibJfRMvuJIdhtxKD8NPPLtvc179c337\"}', '2025-06-17 22:58:37', NULL, '2025-06-17 22:58:36', '2025-06-17 22:58:37'),
(275, 'App\\Models\\User', 128, 'impersonation_token', 'a6771dacde75023215d1e641f97707446cb18d7cd8aea72bfb9dbd06c1ca877b', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"272|qbWbsjDhRQcJe27qBibJfRMvuJIdhtxKD8NPPLtvc179c337\"}', '2025-06-17 22:59:33', NULL, '2025-06-17 22:59:07', '2025-06-17 22:59:33'),
(277, 'App\\Models\\User', 133, 'impersonation_token', 'dcccbaa97ae68f83e5f15ff9f8a105d24562ce0d86a218f88931f508943e65fa', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"272|qbWbsjDhRQcJe27qBibJfRMvuJIdhtxKD8NPPLtvc179c337\"}', '2025-06-17 23:41:30', NULL, '2025-06-17 23:17:41', '2025-06-17 23:41:30'),
(279, 'App\\Models\\User', 140, 'impersonation_token', '6ab7c30167845ffe560480297eb72e25b7a55312e3f3d4a6ca71d34cc18b2aae', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"278|crJHIa9WNDWNRvJNhPHuA8jys2kDKtl2pZ0TbUVa62b96eb6\"}', '2025-06-18 02:30:32', NULL, '2025-06-18 02:30:21', '2025-06-18 02:30:32'),
(281, 'App\\Models\\User', 141, 'impersonation_token', '272dc5e313461fb33bf02878d12df2edb64a687814a4ea06b91fd0d41726cd65', '{\"is_impersonation\":true,\"impersonator_id\":140,\"original_token\":\"280|0bOtXLXWBVEm4rEiAhYATXvJnH0VGjM7JZE7Z3Eme6426e75\"}', '2025-06-18 02:36:58', NULL, '2025-06-18 02:33:42', '2025-06-18 02:36:58'),
(283, 'App\\Models\\User', 140, 'impersonation_token', '4af8b1605de966c01542f5b52e1de30d8239b505a13532ed5e02a267525eb946', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"282|ONOdyQ9UsYGcjKUBP6U6WW9oKjy4npe84Sz2iiqP218b1776\"}', '2025-06-18 02:48:25', NULL, '2025-06-18 02:42:43', '2025-06-18 02:48:25');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(284, 'App\\Models\\User', 140, 'impersonation_token', '6fc7a3a777c22f51dec2da92c954684a43110faa58d7349ea069beeadbd0f29e', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"282|ONOdyQ9UsYGcjKUBP6U6WW9oKjy4npe84Sz2iiqP218b1776\"}', '2025-06-18 02:48:41', NULL, '2025-06-18 02:48:39', '2025-06-18 02:48:41'),
(285, 'App\\Models\\User', 140, 'impersonation_token', '42ef988a7727636dcebe379c23694767a7b9927dc98a655212ef97738775a9a0', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"282|ONOdyQ9UsYGcjKUBP6U6WW9oKjy4npe84Sz2iiqP218b1776\"}', '2025-06-18 02:51:16', NULL, '2025-06-18 02:50:27', '2025-06-18 02:51:16'),
(286, 'App\\Models\\User', 141, 'impersonation_token', '078625a24209eacd5e6a6896c86147ea7b8c769fe9cdaf8f7a90a02a72aaf011', '{\"is_impersonation\":true,\"impersonator_id\":140,\"original_token\":\"285|WxFz0a9vysbEqK7f0rlSp1A2n3wxN5UzR830x5u52e74aa42\"}', '2025-06-18 02:50:39', NULL, '2025-06-18 02:50:37', '2025-06-18 02:50:39'),
(288, 'App\\Models\\User', 140, 'impersonation_token', 'c410e5403abc22f8dd64595ecec778236c0b7beae276c29a470686675ecd3167', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"287|IHEYVfvtorIi5BnluoJx6m5F9ETHMWbmiahiDnAd41715713\"}', '2025-06-18 02:53:27', NULL, '2025-06-18 02:52:20', '2025-06-18 02:53:27'),
(291, 'App\\Models\\User', 140, 'impersonation_token', '8630e4a8375130361560b40198343d56e0a6a1ed2fef02ea300fbf6d6a46b389', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"290|oPsTu9fDXZdGbvWmmMGP335Wjm2N38PyKfIq3DTce0dc4a98\"}', '2025-06-18 03:04:04', NULL, '2025-06-18 02:54:30', '2025-06-18 03:04:04'),
(292, 'App\\Models\\User', 141, 'impersonation_token', 'd221c561879fe09bce4d51e1e8b95f55f73205da507c40d4f1efded13c423088', '{\"is_impersonation\":true,\"impersonator_id\":140,\"original_token\":\"291|7fHoxL3rh7gu1g3uPuEYEbdxBsJ1tFjrC1AzgjWA795def09\"}', '2025-06-18 02:55:36', NULL, '2025-06-18 02:55:04', '2025-06-18 02:55:36'),
(293, 'App\\Models\\User', 141, 'impersonation_token', '3d657974895027f9ccdeb65b4f4eb7c1f8375046698b6676e9e973cd6aa766a5', '{\"is_impersonation\":true,\"impersonator_id\":140,\"original_token\":\"291|7fHoxL3rh7gu1g3uPuEYEbdxBsJ1tFjrC1AzgjWA795def09\"}', '2025-06-18 02:56:10', NULL, '2025-06-18 02:55:55', '2025-06-18 02:56:10'),
(295, 'App\\Models\\User', 140, 'impersonation_token', '5faed7fa94d4e8434e8ed6bf0bc28b5274f278f7f4ce1fa0dfca2f896b558e9a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"294|ZPxQcPWBseQrhSJTOg8zrRoVeWoB9K5PY0WDkh22568ce442\"}', '2025-06-18 03:11:24', NULL, '2025-06-18 03:08:37', '2025-06-18 03:11:24'),
(296, 'App\\Models\\User', 141, 'impersonation_token', '4cee40ef3cc64bfd052866c6f6220e4cdde24a7cbc06ab997203cc93201c269a', '{\"is_impersonation\":true,\"impersonator_id\":140,\"original_token\":\"295|0NSO7kKi0GBIo82pRp5eePCIRIOCfOUN3B1SxuI6aecf5c7a\"}', '2025-06-18 03:09:52', NULL, '2025-06-18 03:09:27', '2025-06-18 03:09:52'),
(298, 'App\\Models\\User', 140, 'impersonation_token', '95472fea2c5b16f7df2cc3df32403af790412210f959d93daa8251c5ee008f29', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"297|bmwDfbNskgK3GDItRnK48bkU8FrieMOf77SZOlWy37d40ac1\"}', '2025-06-18 03:12:17', NULL, '2025-06-18 03:12:16', '2025-06-18 03:12:17'),
(299, 'App\\Models\\User', 140, 'impersonation_token', '407b77b34dd28153123dd30eec565948c464536ad3792e1b9ee140d6c20727e6', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"297|bmwDfbNskgK3GDItRnK48bkU8FrieMOf77SZOlWy37d40ac1\"}', '2025-06-18 03:17:46', NULL, '2025-06-18 03:16:59', '2025-06-18 03:17:46'),
(300, 'App\\Models\\User', 141, 'impersonation_token', '51a2c57159d5f94b5ca59185dc195c038ff976ebccf6a394b9ee94110f2a1952', '{\"is_impersonation\":true,\"impersonator_id\":140,\"original_token\":\"299|6PI9ak1jRsPIH1bw8hI8qyMXT0eyOMcs6NS57GjY9a41a003\"}', '2025-06-18 03:17:07', NULL, '2025-06-18 03:17:06', '2025-06-18 03:17:07'),
(302, 'App\\Models\\User', 140, 'impersonation_token', '9dddc4b8cbad9ac7ffd94fc322b412febb849d6503318d74762e16d601eb1c7a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"301|tKcaYvtJxn2cX0xu6dxghiSXeFH3vYfXGN1noSk4ef1608a7\"}', '2025-06-18 03:20:32', NULL, '2025-06-18 03:20:12', '2025-06-18 03:20:32'),
(303, 'App\\Models\\User', 140, 'impersonation_token', '764fe54ae24b5841c21eeea28e8d94e31cd8d376ae88438dce1ca8ee56436c02', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"301|tKcaYvtJxn2cX0xu6dxghiSXeFH3vYfXGN1noSk4ef1608a7\"}', '2025-06-18 03:21:57', NULL, '2025-06-18 03:21:54', '2025-06-18 03:21:57'),
(306, 'App\\Models\\User', 134, 'impersonation_token', '9a68077d6b564a2dfcc5dc522daed426405a23a17746be23f1847beab655a7c2', '{\"is_impersonation\":true,\"impersonator_id\":132,\"original_token\":\"305|HFt3AZgfuxVeV6CLLS6ADW1xjib7CdtccCeGnt6Y4de39692\"}', '2025-06-18 03:24:26', NULL, '2025-06-18 03:23:21', '2025-06-18 03:24:26'),
(307, 'App\\Models\\User', 140, 'impersonation_token', '1ffad2d2c7e1c1289b0af3863aa572346a466b97f0f1c5e084c112618f2bf099', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"304|Twj36xFDxAvjfhtuJIG1UErVGEQbbECQ8rAyFi153e02780a\"}', '2025-06-18 03:24:43', NULL, '2025-06-18 03:23:38', '2025-06-18 03:24:43'),
(309, 'App\\Models\\User', 140, 'impersonation_token', '1f9c9d722acb8d28f2e32bf7793c16a2bf13a9e64e314de526e049fcae7b06e1', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"308|WaGx4No8p3zZJJTlp0Kygw2ygkwYz4He3gTKesne7a013a19\"}', '2025-06-18 03:29:42', NULL, '2025-06-18 03:24:56', '2025-06-18 03:29:42'),
(310, 'App\\Models\\User', 141, 'impersonation_token', '2435bf82e353e6320fda88ce382aa685b55c5295a514ab5f04ab717adc471ac5', '{\"is_impersonation\":true,\"impersonator_id\":140,\"original_token\":\"309|GvrJtIWMPsbmruFWrEApbgYtjUKXZ35YXr4Kq0cL7287855a\"}', '2025-06-18 03:25:32', NULL, '2025-06-18 03:25:17', '2025-06-18 03:25:32'),
(311, 'App\\Models\\User', 141, 'impersonation_token', '55a1ea3542327fafa6060bd54205798fda225665da63b568955f97b07098190a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"304|Twj36xFDxAvjfhtuJIG1UErVGEQbbECQ8rAyFi153e02780a\"}', '2025-06-18 03:29:22', NULL, '2025-06-18 03:28:44', '2025-06-18 03:29:22'),
(312, 'App\\Models\\User', 141, 'impersonation_token', '43ceb3283f48c67e536f63eb8c793937ad57773a825236a637190ed96614c640', '{\"is_impersonation\":true,\"impersonator_id\":140,\"original_token\":\"309|GvrJtIWMPsbmruFWrEApbgYtjUKXZ35YXr4Kq0cL7287855a\"}', '2025-06-18 03:29:31', NULL, '2025-06-18 03:28:54', '2025-06-18 03:29:31'),
(314, 'App\\Models\\User', 140, 'impersonation_token', 'c0bc3f28e271a16413be83ca04cc4e59ac601948226784b7f6299390c12f1b1d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"313|oB4IYr0wSDmNx89mXkasZzh25KLrwJy6sfVSpapMb7af61ba\"}', '2025-06-18 03:31:14', NULL, '2025-06-18 03:31:10', '2025-06-18 03:31:14'),
(315, 'App\\Models\\User', 140, 'auth_token', 'b061f239ba8a4313c9fbd30eb7a09be1d5f0a8fb938592e617602e27c5d8ce91', '[\"*\"]', '2025-06-18 03:32:54', NULL, '2025-06-18 03:32:48', '2025-06-18 03:32:54'),
(317, 'App\\Models\\User', 141, 'impersonation_token', 'e3dc54e085a130f48bad5d0c16fde79c0e97ce2a7bd25deee23d75d9163e2105', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"261|Ye0DTYM4uD6ZYXf1fb9IkD0bTJ974m2pF92yEkAR62c8e501\"}', '2025-06-18 08:34:29', NULL, '2025-06-18 07:40:18', '2025-06-18 08:34:29'),
(318, 'App\\Models\\User', 129, 'impersonation_token', 'bb7f054e16710b99919455883129d2677f2655eaf426942fb2676ad694ee77d1', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"316|2RjqXa9vNq3Nsqau3hZBeoTlpqd6NJv96itVD0WYd41c1630\"}', '2025-06-18 07:57:28', NULL, '2025-06-18 07:57:14', '2025-06-18 07:57:28'),
(319, 'App\\Models\\User', 129, 'impersonation_token', '214cfca45fbcdbe50103c4fd517a7a20be3ccc8d242fff4bed8f7cb0475d5f06', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"316|2RjqXa9vNq3Nsqau3hZBeoTlpqd6NJv96itVD0WYd41c1630\"}', '2025-06-18 07:59:13', NULL, '2025-06-18 07:57:50', '2025-06-18 07:59:13'),
(323, 'App\\Models\\User', 128, 'impersonation_token', 'bbfcde22d13e17dd6c837eebb3aba05af63b54a738c391a4beafd4374d2d6835', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"272|qbWbsjDhRQcJe27qBibJfRMvuJIdhtxKD8NPPLtvc179c337\"}', '2025-06-18 09:49:12', NULL, '2025-06-18 08:57:29', '2025-06-18 09:49:12'),
(325, 'App\\Models\\User', 140, 'impersonation_token', 'a41caa59a5cbb7a14a08bb602932675b7f5c521f73d64d94a5f302869d173d52', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"324|82qo45N187zHfzeziXAoHoOE1Pl9bWHLaUGiXmjp6b0df258\"}', '2025-06-18 09:08:38', NULL, '2025-06-18 09:03:25', '2025-06-18 09:08:38'),
(332, 'App\\Models\\User', 128, 'impersonation_token', 'edf7a70e7cc950c71e3dc53130848c8c97641d0f568247fcaf4abc950aff2e15', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"331|VxrVs484jfTmOBLFVdwgInz08UqJlKSVdARyY2C0a192afea\"}', '2025-06-18 09:21:18', NULL, '2025-06-18 09:21:16', '2025-06-18 09:21:18'),
(334, 'App\\Models\\User', 128, 'impersonation_token', 'abb3a7f12ea82f0ec48591ab21b053bce596a72f9f90ab22961976c8d2bb095e', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"333|ItDznav7i4WOyeaLUVPQrd4UD3HfMPOxCBgVSWhBe1b7564e\"}', '2025-06-18 09:25:55', NULL, '2025-06-18 09:22:33', '2025-06-18 09:25:55'),
(338, 'App\\Models\\User', 129, 'impersonation_token', '6cb816fc07244f36c7493f00374a0c1bb8de7e5e8439c1aee4351df768df64ef', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"337|jdyH8y6MA4cXTKobiRxlXDg4XZnzXqbTA8mbdrAyb1dd67ca\"}', '2025-06-18 09:36:56', NULL, '2025-06-18 09:35:25', '2025-06-18 09:36:56'),
(342, 'App\\Models\\User', 150, 'impersonation_token', 'f3029e15631e43749c8283cabbba0db8261a832738dd37411e801e2c18f73901', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"340|qs6efuzU5oo5TRktohW9QO775KzjtOuRJDrPZtr7757a1d97\"}', '2025-06-18 09:58:26', NULL, '2025-06-18 09:57:10', '2025-06-18 09:58:26'),
(350, 'App\\Models\\User', 153, 'impersonation_token', '8c6ec2fc8d47034acb50adca3441d333750823082d0e32e2b92aeae2d46746f4', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"349|ZjOF2qn7ltCynezQywK7HpXkQq7oeLwdehd6tr6527efa1f0\"}', '2025-06-18 10:09:15', NULL, '2025-06-18 10:08:52', '2025-06-18 10:09:15'),
(352, 'App\\Models\\User', 129, 'impersonation_token', '3cb04fca8b866f9a6d002325afc696303242c243a36691ec7c4696c8548d668a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"351|HNZ8YOJtsOtYt9uPXXUssE2Z858pas5HOaNOEPtQbab36aae\"}', '2025-06-18 10:10:13', NULL, '2025-06-18 10:10:12', '2025-06-18 10:10:13'),
(354, 'App\\Models\\User', 129, 'impersonation_token', 'dabe454562bb80b186121e54b0eb150aaf139feb4c85918456211f5a217dcc10', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"353|u68oTjZYj32s2Mn2YUYtxWbMsNva0rvEuYcTye2m5720e51a\"}', '2025-06-18 10:13:08', NULL, '2025-06-18 10:12:17', '2025-06-18 10:13:08'),
(356, 'App\\Models\\User', 128, 'impersonation_token', '15fb1fdabc17f902770a62cf896715fe6d638a0fea007fd94154de1f1b80a6d0', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"355|1thDZoSNKavo1mTTm9PbCyF2wBygufbwECGpEFynf23c8c9d\"}', '2025-06-18 10:14:19', NULL, '2025-06-18 10:14:15', '2025-06-18 10:14:19'),
(367, 'App\\Models\\User', 151, 'auth_token', '5871de15b73c0cbdec7a278a8f644e5409b2a6f6a1dadcc1ea73b468c0104cc8', '[\"*\"]', '2025-06-18 10:22:34', NULL, '2025-06-18 10:19:42', '2025-06-18 10:22:34'),
(368, 'App\\Models\\User', 143, 'impersonation_token', '5386b7782cf17296768358b5989cd5e59394b00183566514dd3161a6f95f4717', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"366|Gwu5KZOUO9IxYjld8NaavrL4wCpZmmIjTY1WCkxh4e4d4b9d\"}', '2025-06-18 10:20:36', NULL, '2025-06-18 10:19:50', '2025-06-18 10:20:36'),
(369, 'App\\Models\\User', 154, 'auth_token', 'ce918e379426d9979a2256b330973fe10c761bf9f410db96a9a4fdc31ec8ccef', '[\"*\"]', '2025-06-18 10:21:57', NULL, '2025-06-18 10:21:40', '2025-06-18 10:21:57'),
(372, 'App\\Models\\User', 143, 'impersonation_token', '1df08a0bbbb507eb58b2efe8d1168f37a3643406723e9e9ee635931492724638', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"371|ze8THzgWzSRNYOkW4SVILJgcUg0dzFNodH9o59q579323294\"}', '2025-06-18 10:22:44', NULL, '2025-06-18 10:22:42', '2025-06-18 10:22:44'),
(375, 'App\\Models\\User', 143, 'impersonation_token', '2e1407c6407bff0606004ad92d867c98262b149ca4939f2117317d9f944ba26e', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"374|dscn06PmkqFP9FzHbnYw4wodJ1I2UrMsFguzi48jf55a997e\"}', '2025-06-18 10:23:35', NULL, '2025-06-18 10:23:07', '2025-06-18 10:23:35'),
(378, 'App\\Models\\User', 154, 'auth_token', '6ff015467009e5000de6c1062e67913d128dd48f64ac56ea218990ab0e48f27f', '[\"*\"]', '2025-06-18 10:25:41', NULL, '2025-06-18 10:25:37', '2025-06-18 10:25:41'),
(380, 'App\\Models\\User', 154, 'impersonation_token', '23cf3cfdc3d6fc181318ba4edf7a6866f34ab09be82c20a9d71f91d8c70633cb', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"379|xOy8sSZJYM8HuorwBBjzpk7neuJXpBnmHdOVO2aK59441fdd\"}', '2025-06-18 10:26:27', NULL, '2025-06-18 10:26:23', '2025-06-18 10:26:27'),
(382, 'App\\Models\\User', 151, 'impersonation_token', '4193458d49ac9b6a98636d7e16e1f26bc3c7ba423f0e87f7b6e21d0c1f3b7286', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"381|jW4T5BxafxjcVg3cvSGgidbukvup3OWwDeYiAFq09e37bf2c\"}', '2025-06-18 10:27:16', NULL, '2025-06-18 10:27:15', '2025-06-18 10:27:16'),
(390, 'App\\Models\\User', 150, 'impersonation_token', '388a23989bb36e737c0ba2e7ef0ddea5042a487ca3d6d93970fbd4b2e9c8f35f', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"389|hMtd0Xhdzb9H5KCEHqV4RbYU9E31OxMebrgU97e5abf71e75\"}', '2025-06-18 10:37:06', NULL, '2025-06-18 10:37:05', '2025-06-18 10:37:06'),
(394, 'App\\Models\\User', 128, 'impersonation_token', '0d53e0a3b3e971996d38cbb3a0748fef66d8706bf5f6cf1ea571214bed6324cd', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"393|7ZHZh9sN9asRxMiZFSd5ZvkdqWS9MKYlUDGN5jzzb8fade57\"}', '2025-06-18 11:44:41', NULL, '2025-06-18 11:44:33', '2025-06-18 11:44:41'),
(397, 'App\\Models\\User', 140, 'impersonation_token', 'e90fac7e38f8daebdd5855f820a24a529f74cf28048164dec8722156da84b99a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"391|vvvhnzEPzTboboLWasMen5hMldxFgwFrAfctXagIbcf2199b\"}', '2025-06-18 12:05:26', NULL, '2025-06-18 11:59:10', '2025-06-18 12:05:26'),
(400, 'App\\Models\\User', 129, 'impersonation_token', '17e69128f096dbd4e7b88722390d4707767d8753349c04e53d570f0c4417f712', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"399|Ns0bZC7U4CwA3o8A4XsfsqWB8VKeYhk2eiEr8HR0b07eb846\"}', '2025-06-18 14:07:36', NULL, '2025-06-18 12:06:21', '2025-06-18 14:07:36'),
(406, 'App\\Models\\User', 171, 'impersonation_token', 'c8c256745a78b3a960a050adfae2c9374326850680245066c5bf5947870cfd93', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 13:48:24', NULL, '2025-06-18 13:48:23', '2025-06-18 13:48:24'),
(407, 'App\\Models\\User', 171, 'impersonation_token', '9b7d5e2116defff430b7f3397e5b17eb2da1a2279aec35064dbbd3656c24cb77', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:08:39', NULL, '2025-06-18 13:48:59', '2025-06-18 14:08:39'),
(408, 'App\\Models\\User', 128, 'impersonation_token', '097f8c3af47f1259564c5a79689bc3fa80763d6b6a5fe55b1dd863f0c047ff7d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"399|Ns0bZC7U4CwA3o8A4XsfsqWB8VKeYhk2eiEr8HR0b07eb846\"}', '2025-06-18 15:12:45', NULL, '2025-06-18 14:07:46', '2025-06-18 15:12:45'),
(409, 'App\\Models\\User', 143, 'impersonation_token', '4eb32e7f0bbc7eb3cf516876dfeb337a010fa5e0a4d1ecf576083d010b190c6e', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:16:12', NULL, '2025-06-18 14:16:08', '2025-06-18 14:16:12'),
(410, 'App\\Models\\User', 216, 'impersonation_token', 'a0ab85406fea15acff2665084e4a940b7190c92d32d93ceda2eec8c7c67acee1', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:17:22', NULL, '2025-06-18 14:17:16', '2025-06-18 14:17:22'),
(411, 'App\\Models\\User', 128, 'impersonation_token', '1828e60a3555ae8f31e8484b87668a9485c7300abc02a5f1a8a808bfed46c894', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:22:36', NULL, '2025-06-18 14:17:30', '2025-06-18 14:22:36'),
(412, 'App\\Models\\User', 171, 'impersonation_token', '76b6ab37fd2cc37bfeab766ddf8e29aa33add12f45c9f3089dabd4804c74857c', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:25:13', NULL, '2025-06-18 14:23:42', '2025-06-18 14:25:13'),
(413, 'App\\Models\\User', 238, 'impersonation_token', 'e739fdbc2303a9c99e05baf9ac936719eafdcac0584650d325fce2d9152b9b51', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:25:39', NULL, '2025-06-18 14:25:38', '2025-06-18 14:25:39'),
(414, 'App\\Models\\User', 171, 'impersonation_token', '50a2344ef33ee8a210f35a89cb239ef71d0681df0abeba168ff1c8d78702e2d8', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:28:00', NULL, '2025-06-18 14:27:24', '2025-06-18 14:28:00'),
(415, 'App\\Models\\User', 171, 'impersonation_token', 'b8aa175b39466c517718d15407dbad38944fe9ca29f8d57ef16bef802e83b182', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:31:40', NULL, '2025-06-18 14:31:37', '2025-06-18 14:31:40'),
(416, 'App\\Models\\User', 238, 'impersonation_token', 'c887640013b3046b9f8d8ed3afa89cd6cda14fbcd263311cd74a1fc38b3a3725', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:34:11', NULL, '2025-06-18 14:34:10', '2025-06-18 14:34:11'),
(417, 'App\\Models\\User', 238, 'impersonation_token', '0fd8f02a49c6c00d4e7af61a2c629c45c1dd58014b2c60d37449c0cd7587b8c8', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:38:57', NULL, '2025-06-18 14:34:44', '2025-06-18 14:38:57'),
(418, 'App\\Models\\User', 238, 'impersonation_token', '57bffd65d6ddfb1d1c0cece8fd048fc4af14f96914aac509d11e88a992c71f75', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:42:27', NULL, '2025-06-18 14:40:08', '2025-06-18 14:42:27'),
(419, 'App\\Models\\User', 171, 'impersonation_token', '6e6ff2c83e3b14ae901508afac0ab5e7f390341ff3ae6e59fd476ba01e371f34', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:43:19', NULL, '2025-06-18 14:42:50', '2025-06-18 14:43:19'),
(420, 'App\\Models\\User', 238, 'impersonation_token', 'fed24a53017f66a77bf438a6e1c439a55b487e9030b3d113281efa6d2ecb43f1', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:49:09', NULL, '2025-06-18 14:43:32', '2025-06-18 14:49:09'),
(421, 'App\\Models\\User', 171, 'impersonation_token', '2f5d6116aaa83fcb6a0918450495abe62487e1dfd14d30b2724fc7b646b6f5bc', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:50:11', NULL, '2025-06-18 14:49:44', '2025-06-18 14:50:11'),
(422, 'App\\Models\\User', 238, 'impersonation_token', '0b435aa8556b80367482a55c8009d660861c14b6fa44a1fb5f4c80fcf55eacfe', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 14:59:13', NULL, '2025-06-18 14:51:02', '2025-06-18 14:59:13'),
(424, 'App\\Models\\User', 143, 'impersonation_token', '9282eabfa17088ed9dea9d8723e2370b5d03e29e8de4c22b1b1552c850479023', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 14:57:57', NULL, '2025-06-18 14:57:32', '2025-06-18 14:57:57'),
(425, 'App\\Models\\User', 246, 'impersonation_token', '12e7cd3e98cf2f8a45da1284374e793c14d3e81289da0165aecf32526446d515', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 14:58:18', NULL, '2025-06-18 14:58:17', '2025-06-18 14:58:18'),
(426, 'App\\Models\\User', 171, 'impersonation_token', '32340473d372ea85667b80ff8c75c48a0f7603134a174bc565448818178839cd', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 14:59:57', NULL, '2025-06-18 14:59:05', '2025-06-18 14:59:57'),
(427, 'App\\Models\\User', 215, 'impersonation_token', '164629aef76d5bc3be072f969d90f469bd3b29fb7d5f4b1881d7e3233bfe2a62', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:13:20', NULL, '2025-06-18 15:00:35', '2025-06-18 15:13:20'),
(429, 'App\\Models\\User', 171, 'impersonation_token', 'ee0892367df0328571c8d6fa01923478e3c4f955bcd2ceca211a1e8cabd4d10a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"428|0jWXRvs5RsVJbaSka3RV9JrREOeUVaSGUfPf66Dr1dc3ed57\"}', '2025-06-18 15:13:09', NULL, '2025-06-18 15:11:32', '2025-06-18 15:13:09'),
(430, 'App\\Models\\User', 246, 'impersonation_token', 'aae2916b5b1b39a9ab3ffe89f21d1a480fb0d1af98b32a6a82ec73049dee2d40', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:14:30', NULL, '2025-06-18 15:13:52', '2025-06-18 15:14:30'),
(431, 'App\\Models\\User', 171, 'impersonation_token', 'aa131a8b560e1a202e1be20d300a8755a10c6c4bc07e4c9e24ae3830fb9abbcf', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:15:52', NULL, '2025-06-18 15:15:29', '2025-06-18 15:15:52'),
(432, 'App\\Models\\User', 246, 'impersonation_token', '59a0761af1f08425dcce5d54d298b15ed96d79d9668a9e2d0e6faa7018505ffe', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:18:08', NULL, '2025-06-18 15:16:36', '2025-06-18 15:18:08'),
(433, 'App\\Models\\User', 245, 'impersonation_token', '9c057fff7e9569442050a79949ed581ffe99641051b4ab1ee58fd98d3441261b', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:25:09', NULL, '2025-06-18 15:22:12', '2025-06-18 15:25:09'),
(434, 'App\\Models\\User', 244, 'impersonation_token', 'e21a8c6c7a96da90cd33d7f024c3f62ce4618b47415e5c03a2bc3beb5f4e6b0d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:32:44', NULL, '2025-06-18 15:29:31', '2025-06-18 15:32:44'),
(436, 'App\\Models\\User', 173, 'impersonation_token', '15396eb9e0278b39a8a55bbde6e363cf2025a3c5b5d01ea0170249bacec21c91', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:37:05', NULL, '2025-06-18 15:35:43', '2025-06-18 15:37:05'),
(437, 'App\\Models\\User', 171, 'impersonation_token', 'a05239de6bd5fb9797a7217785f74e9b3b9b2c03f10cd31840ce811853df713f', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:38:43', NULL, '2025-06-18 15:38:05', '2025-06-18 15:38:43'),
(438, 'App\\Models\\User', 173, 'impersonation_token', '5372fdc6534d89eb79c36e01564b5af4ba0cce63177ff30b5c9276fe768aa3f8', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:40:12', NULL, '2025-06-18 15:39:27', '2025-06-18 15:40:12'),
(439, 'App\\Models\\User', 171, 'impersonation_token', '1b92b850aad9271c6794906ed87e2f92cd39256d2ce1f046e0af0737dd90b801', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:42:39', NULL, '2025-06-18 15:42:08', '2025-06-18 15:42:39'),
(440, 'App\\Models\\User', 173, 'impersonation_token', '89e748a6e9c2d631c01fd6bea22b4831c664743cab35d9e4a5baf2a505e78316', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:43:41', NULL, '2025-06-18 15:42:53', '2025-06-18 15:43:41'),
(441, 'App\\Models\\User', 171, 'impersonation_token', 'f6d74f02344897c72a65f87989c56ca316bee3633a3eed0738a5ead1b2f2832a', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:48:29', NULL, '2025-06-18 15:48:02', '2025-06-18 15:48:29'),
(442, 'App\\Models\\User', 173, 'impersonation_token', '09efc8cbecca268124999ba5349b62d92c126a3ed2c58323256aa6e2c3ce7817', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-18 15:49:44', NULL, '2025-06-18 15:48:47', '2025-06-18 15:49:44'),
(443, 'App\\Models\\User', 207, 'impersonation_token', '89b984b744549d3f239687cb5ead93719932164a783558578e73f1595421eef3', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"428|0jWXRvs5RsVJbaSka3RV9JrREOeUVaSGUfPf66Dr1dc3ed57\"}', '2025-06-18 15:56:00', NULL, '2025-06-18 15:54:50', '2025-06-18 15:56:00'),
(444, 'App\\Models\\User', 165, 'impersonation_token', '11dbad84180b95b3dbd1f38b3d6961e79018773c17157bb62805bcb3e570830b', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"428|0jWXRvs5RsVJbaSka3RV9JrREOeUVaSGUfPf66Dr1dc3ed57\"}', '2025-06-18 15:57:28', NULL, '2025-06-18 15:57:27', '2025-06-18 15:57:28'),
(445, 'App\\Models\\User', 171, 'impersonation_token', 'd347cb8413f27aeb1703165853b5469f7cc39db0f6678b0245fab85022a6925b', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"428|0jWXRvs5RsVJbaSka3RV9JrREOeUVaSGUfPf66Dr1dc3ed57\"}', '2025-06-18 15:58:30', NULL, '2025-06-18 15:58:00', '2025-06-18 15:58:30'),
(446, 'App\\Models\\User', 172, 'impersonation_token', '4e055993a71ed9c2b586385ae18dd7ae9e4f7dbc86a75d2b18044bfb02600594', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"428|0jWXRvs5RsVJbaSka3RV9JrREOeUVaSGUfPf66Dr1dc3ed57\"}', '2025-06-18 16:02:04', NULL, '2025-06-18 15:59:05', '2025-06-18 16:02:04'),
(448, 'App\\Models\\User', 259, 'impersonation_token', '6ca021c2845cd7dd92bf1dc7bcf5e2ce93e881bae5531f42c7b992b7a547f704', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 16:20:52', NULL, '2025-06-18 16:19:57', '2025-06-18 16:20:52'),
(449, 'App\\Models\\User', 260, 'impersonation_token', 'a4b0b14f51df7e3701f787d82e5548a8f79b5db2684137675e5998ced7d209bb', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 16:21:18', NULL, '2025-06-18 16:21:00', '2025-06-18 16:21:18'),
(450, 'App\\Models\\User', 259, 'impersonation_token', '77a128a001dac4d9d1f70392ca5a9e7da5c580247045c49b9c38c14634513b44', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 16:21:38', NULL, '2025-06-18 16:21:27', '2025-06-18 16:21:38'),
(451, 'App\\Models\\User', 260, 'impersonation_token', '34aab411e08dcc4fd91a99f38d9125d1c68a3ed7fc97d066c676d1c0a0fbd607', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 16:23:14', NULL, '2025-06-18 16:21:46', '2025-06-18 16:23:14'),
(452, 'App\\Models\\User', 260, 'impersonation_token', '6a60cf3ed311a6125d26e175cc65ae684fa461957ead50ed7b086107462c5055', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 16:24:33', NULL, '2025-06-18 16:24:21', '2025-06-18 16:24:33'),
(453, 'App\\Models\\User', 260, 'impersonation_token', 'bf15fdbb78504f6783abf8abc1f22b3418e832cb67dc003b50c9a1ed68e6b06c', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 17:17:47', NULL, '2025-06-18 17:17:47', '2025-06-18 17:17:47'),
(454, 'App\\Models\\User', 259, 'impersonation_token', 'cd84cc59686252182a25f8a8aeba32865f5c42499b383ecc498c085454136586', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 17:18:28', NULL, '2025-06-18 17:18:02', '2025-06-18 17:18:28'),
(456, 'App\\Models\\User', 259, 'impersonation_token', 'eeb119d3cf4f6e437e6ede868794cde11e82c929a9b6f769cfe45e253bb15721', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"455|mdcB0OMtPUe0gI4vXLY5bVkDpW3ibeIDd8XVkl596b950bdb\"}', '2025-06-18 17:54:26', NULL, '2025-06-18 17:52:40', '2025-06-18 17:54:26'),
(457, 'App\\Models\\User', 260, 'impersonation_token', 'bbb575dcb71717695baddc3e3d15a0757cfad658775442d8c74a02f0a5dc857d', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"455|mdcB0OMtPUe0gI4vXLY5bVkDpW3ibeIDd8XVkl596b950bdb\"}', '2025-06-18 17:54:39', NULL, '2025-06-18 17:54:38', '2025-06-18 17:54:39'),
(458, 'App\\Models\\User', 259, 'impersonation_token', '9e9318560ec5aa03d221727e4385fdbd2ca3039ea5fb87e8258fb899e78d3887', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"455|mdcB0OMtPUe0gI4vXLY5bVkDpW3ibeIDd8XVkl596b950bdb\"}', '2025-06-18 17:54:55', NULL, '2025-06-18 17:54:52', '2025-06-18 17:54:55'),
(459, 'App\\Models\\User', 259, 'impersonation_token', '343ce461d06bef8726c87467ee92a3461ec12086f9c5728808838c55c1217ee8', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"405|RQP51yib6U4jhHO8sHoonVsK2cpxulqRUdCIB4Wj221aaceb\"}', '2025-06-18 20:50:29', NULL, '2025-06-18 20:49:53', '2025-06-18 20:50:29'),
(460, 'App\\Models\\User', 259, 'impersonation_token', '95e20788deb0e2460f638998af1a7a7aaab3a3bf6b001449bce162689cc63263', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-19 06:59:06', NULL, '2025-06-19 06:59:01', '2025-06-19 06:59:06'),
(461, 'App\\Models\\User', 260, 'impersonation_token', '854c661b1c2c36b1fca2fa83fb11cb32da62ac13d84090774658c2a95fd34cd5', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-19 07:00:13', NULL, '2025-06-19 06:59:22', '2025-06-19 07:00:13'),
(462, 'App\\Models\\User', 261, 'impersonation_token', '9f11add6d3a4bc990d8fafb04cbf8c614bc46333f3d83aba60703401f6f82db7', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"423|iZBxmu1OCg8rBmPnz52Sa8vFMiNdulK6ThbV7DDLad2881db\"}', '2025-06-19 09:33:18', NULL, '2025-06-19 09:33:18', '2025-06-19 09:33:18'),
(464, 'App\\Models\\User', 260, 'impersonation_token', 'a3a939a26dd76786d7340f58898124bc690c9ed11006dea5e813c0b840521159', '{\"is_impersonation\":true,\"impersonator_id\":1,\"original_token\":\"463|F5AFaN9lOsfT0GUuRI94aeslFQgkneXZ4eNKYP1c82018385\"}', '2025-06-19 09:41:42', NULL, '2025-06-19 09:41:20', '2025-06-19 09:41:42');

-- --------------------------------------------------------

--
-- Table structure for table `prescription_details`
--

CREATE TABLE `prescription_details` (
  `id` int NOT NULL,
  `employee_id` int NOT NULL,
  `frame_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `frame_prescription` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `prescription_image` text COLLATE utf8mb4_general_ci,
  `od_left_sphere` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_left_cylinders` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_left_axis` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_left_nv_add` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_left_2_pds` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_right_sphere` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_right_cylinders` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_right_axis` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_right_nv_add` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `od_right_2_pds` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `pupil_distance` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `frame_picture` text COLLATE utf8mb4_general_ci,
  `pupil_distance_online` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_left_2_pds_online` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `od_right_2_pds_online` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_right` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_left` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_base_direction_right` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_base_direction_left` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_rigth` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_left` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_base_direction_right` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_base_direction_left` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `special_notes` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescription_details`
--

INSERT INTO `prescription_details` (`id`, `employee_id`, `frame_type`, `frame_prescription`, `prescription_image`, `od_left_sphere`, `od_left_cylinders`, `od_left_axis`, `od_left_nv_add`, `od_left_2_pds`, `od_right_sphere`, `od_right_cylinders`, `od_right_axis`, `od_right_nv_add`, `od_right_2_pds`, `pupil_distance`, `frame_picture`, `pupil_distance_online`, `od_left_2_pds_online`, `od_right_2_pds_online`, `vertical_right`, `vertical_left`, `vertical_base_direction_right`, `vertical_base_direction_left`, `horizontal_rigth`, `horizontal_left`, `horizontal_base_direction_right`, `horizontal_base_direction_left`, `special_notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'single-vision', 'single-vision-lense', NULL, '0.00', '0.00', '4', '+0.00', '22.5', '0.00', '0.00', '3', '+0.00', '22.5', '45.0', NULL, 'null', 'null', 'null', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', '2025-06-18 16:23:14', '2025-06-18 16:23:14');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_tags` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `featured_image` text COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `sub_category` int DEFAULT NULL,
  `gender` enum('Male','Female','Unisex') COLLATE utf8mb4_general_ci NOT NULL,
  `rim_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `style` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `material` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shape` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `eye_size` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `manufacturer_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_status` int NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `glasses_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lens_size` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `temple_size` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bridge_size` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `frame_features` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `prescriptions_available` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `upc` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sku` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lens_width` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lens_height` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `frame_width` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_tags`, `featured_image`, `description`, `sub_category`, `gender`, `rim_type`, `style`, `material`, `shape`, `eye_size`, `manufacturer_name`, `product_status`, `created_at`, `updated_at`, `glasses_type`, `lens_size`, `temple_size`, `bridge_size`, `frame_features`, `prescriptions_available`, `upc`, `sku`, `lens_width`, `lens_height`, `frame_width`) VALUES
(10, '3000P', 'ANSI Z87+ HIGH IMPACT,CSA Z94.3', '1749563440RNDo5I2ewK.png', 'The ArmouRx 3000P Safety Glasses is an extra large rectangular full frame made of metal, with prescription available. These prescription safety glasses are available in 2 different colors and sizes, and  features a double bridge, permanent side shield protection, silicone adjustable nose pads and rubberized temples. Plus, these ArmouRx  safety glasses are ANSI Z87.1, and CSA Z94.3 approved.', NULL, 'Unisex', '4', '10', '7', '4', NULL, '9', 1, '2025-05-29 22:36:22', '2025-06-18 15:16:04', 'Eye Glasses', NULL, '132', '15', 'Adjustable Nose Pads,Flexible,Anti-Reflective,UV Protection,Lightweight', NULL, NULL, '555', '0', '0', '0'),
(11, '3001P', 'ANSI Z87+ HIGH IMPACT,CSA Z94.3', '1749563467Q4rjRLTMZ7.png', 'The ArmouRx 3001P Safety Glasses is a lightweight rectangular full-frame made of metal, with prescription available. These prescription safety glasses are available in 2 different colors and sizes, and  features permanent side shield protection, silicone adjustable nose pads and rubber temples. Plus, these ArmouRx  safety glasses are ANSI Z87.1, and CSA Z94.3 approved.', 4, 'Unisex', '4', '10', '7', '4', NULL, '9', 1, '2025-05-30 00:57:27', '2025-06-10 13:51:07', 'null', NULL, '0', '0', 'Spring Hinges,Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective', NULL, NULL, NULL, NULL, NULL, NULL),
(12, '3002P', 'ANSI Z87+ HIGH IMPACT,CSA Z94.3', '1749563487sW2nexl8Gf.png', 'The ArmouRx 3002P Safety Glasses is a lightweight rectangular full-frame made of metal, with prescription available. These prescription safety glasses are available in 2 different colors and sizes, and  features permanent side shield protection, silicone adjustable nose pads and rubberized temples. Plus, these ArmouRx  safety glasses are ANSI Z87.1, and CSA Z94.3 approved.', 4, 'Unisex', '4', '10', '7', '4', NULL, '9', 1, '2025-05-30 01:00:10', '2025-06-10 13:51:27', 'Eye Glasses', NULL, '0', '0', 'Lightweight,Anti-Reflective,UV Protection,Scratch Resistant,Flexible', NULL, NULL, NULL, NULL, NULL, NULL),
(13, '5009', 'ANSI Z87+ HIGH IMPACT,CSA Z94.3', '1749563513ANkEZYgecW.png', 'The ARMOURX 5009 is a frame that brings together both function and style. The protective structure of an integrated side shield and adjustable temple length, make this model ideal for the workplace. This frame is great for indoor and outdoor work environments.', 4, 'Male', '4', '4', '5', '4', NULL, '9', 1, '2025-05-30 01:03:57', '2025-06-10 13:51:53', 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, '5010', 'CSA Z94.3,ANSI Z87+ HIGH IMPACT', '1749563529uK5SXuNmWA.png', 'The ARMOURX 5010 is a frame that brings together both function and style. The protective structure of an integrated side shield and adjustable temple length, make this model ideal for the workplace. This frame is great for indoor and outdoor work environments.', 4, 'Male', '4', '4', '6', '4', NULL, '9', 1, '2025-05-30 01:05:34', '2025-06-10 13:52:09', 'null', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'P-17', 'ANSI Z87+ HIGH IMPACT', '1749563564gLL2z7uI4F.png', 'Year after year, the P-17 continues to be a staple, and one of the top-selling models, in our Active Lifestyle series. Built to fit most face shapes and sizes, it’s a compact fusion of simplicity and performance. A traditional rectangular lens shape exudes classic style while the light-weight, dual-injected nose bridge and temple arms ensure secure and comfortable wearability all day long. The P-17 is sleek, sporty, and ANSI Z87.1+, meeting the highest safety standards for optical clarity and protection.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-05-30 23:58:04', '2025-06-10 13:52:44', 'null', NULL, '120', '18', 'Adjustable Nose Pads,UV Protection,Anti-Reflective', 'yes', NULL, '12', '61', NULL, NULL),
(17, 'Guard Advanced', 'ANSI Z87+ HIGH IMPACT', '1749563601Hb3kkuZdg7.png', 'Protection that you can see! Our Wiley X GUARD ADVANCED is one of the lowest profile frames in our changeable lens series. WX GUARD ADVANCED meets the MIL-PRF-32432(GL) ballistic safety standards for impacts and optical quality. We are constantly improving our products, but with the WX GUARD ADVANCED, we took an already solid pair of glasses and made a few tweaks to make them even better. At a lower price point, these glasses will keep you protected without breaking the bank. Style. Comfort. Value.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-05-31 00:10:39', '2025-06-10 13:53:21', 'null', NULL, '125', '18', 'Flexible,UV Protection,Lightweight', 'yes', NULL, '122', '76', '44', NULL),
(18, 'SG-1', 'ANSI Z87+ HIGH IMPACT,D5 FINE DUST', '1749563618vYXiQuIEZQ.png', 'Our Wiley X SG-1 goggles are lightweight and designed to eliminate tunnel vision, keeping your view unobstructed. The changeable lenses include a Facial Cavity™ that protects your eyes from dust and dirt. Wiley X SG-1 meets the MIL-PRF-32432(GL) ballistic safety standards for optical quality and high mass/high-velocity impacts.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-05-31 00:33:30', '2025-06-10 13:53:38', 'null', NULL, '130', '24', 'UV Protection,Anti-Reflective,Flexible', 'yes', NULL, '122', '60', '36', NULL),
(19, 'WX Peak', 'ANSI Z87+ HIGH IMPACT', '17495636365yuH7qxu02.png', 'When you’ve reached your well-earned vantage of the summit, you’ll be ready to take it all in. The high-wrap frame of our WX Peak lets you enjoy it thoroughly, stopping any peripheral light from obscuring your view. Meanwhile, modest design elements mid-way down the temple arms add some visual interest and a bit of flair to its iconic, rectangular shape. Maybe this is why, year after year, the WX Peak continues to be one of our best-selling models of sunglasses, offering a seamless combination of protection and classic style.\r\n\r\nMeets ANSI Z87.1 safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion free clarity\r\nLightweight frame\r\nPrescription Ready', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-05-31 00:39:26', '2025-06-10 13:53:56', 'null', NULL, '130', '15', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', '0', NULL, '65', '40', NULL),
(20, 'WX Boss', 'ANSI Z87+ HIGH IMPACT', '1749563655xqVbwD8tOD.png', 'While you can’t always control your environment or the conditions you work and play in, you can take charge of how you perform in them with the aptly named WX Boss. Bold style meets high-performance features, with sleek but wide temples, a high-wrap frame, and a removable gasket to keep irritants away from your eyes. With a medium to large overall fit, the WX Boss rests comfortably close to your face and comes with a t-docking strap to keep them in place during intense activity.', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-05-31 00:43:33', '2025-06-10 13:54:15', 'null', NULL, '125', '18', 'Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '68', '42', NULL),
(22, 'WX Omega', 'ANSI Z87+ HIGH IMPACT', '174956367713fedAfidK.png', 'As its name implies, the WX Omega will end your search for a solid pair of perfect fitting sunglasses. A staff favorite and go-to style when fitting a new client, the WX Omega is one of the bolder frames in our Active Lifestyle Series—lightweight with a high-wrap that blocks out any peripheral light. The lenses meet ANSI Z87.1+ safety standards for optical clarity and high-mass/high-velocity impact, guaranteeing maximum protection and precision vision in any outdoor adventure.', 4, 'Unisex', '4', '4', '6', '4', NULL, '10', 1, '2025-05-31 00:50:21', '2025-06-10 13:54:37', 'null', NULL, '125', '17', 'UV Protection,Flexible,Lightweight,Anti-Reflective', 'yes', NULL, NULL, '66', '42', NULL),
(23, 'XL-1 Advanced', 'ANSI Z87+ HIGH IMPACT', '1749563697XVX9JxdiGc.png', 'Sold with two sets of lenses, each for different lighting conditions, and a removable strap that firmly secures the frame and lenses to your head and face, the XL-1 Advanced is described by fans as a hybrid between a goggle and a pair of sunglasses. Ballistic-rated for safety and equipped with a removable Facial Cavity Seal for blocking irritants and peripheral light, the XL-Advanced is a solid workhorse designed and purpose-built for maximum comfort and protection.', 4, 'Male', '4', '4', '6', '9', NULL, '10', 1, '2025-05-31 00:54:43', '2025-06-10 13:54:57', 'null', NULL, '122', '17', 'Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '62', '39', NULL),
(24, 'Saber Advanced', 'ANSI Z87+ HIGH IMPACT', '1749563726VC6q7zkOCl.png', 'What happens when we take our state-of-the-art technology to one of our most trusted styles? The WX SABER ADVANCED is born! Developed with comfort in mind, the SABER ADVANCED features a lightweight design, flexible nose piece, and a foam insert on the changeable lens. The WX Saber Advanced glasses meet MIL-PRF-32432 ballistic safety standards to ensure that you are always protected during any situation.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet the MIL-PRF-32432(GL) ballistic standards: ANSI Z87.1+ optical clarity and high mass/high velocity impact standards: as well as US Federal OSHA 1910.133(b)(1)(1) standards\r\n100% UVA/UVB protection with distortion free clarity\r\nT-Shell™ Lens coating resists scratching\r\nAdjustable take flight nose piece accommodates any face/nose bridge\r\nCompatible with the PTX Prescription Insert', 4, 'Unisex', '4', '4', '6', '9', NULL, '10', 1, '2025-05-31 01:02:49', '2025-06-10 13:55:26', 'null', NULL, '114', '25', 'Flexible,Anti-Reflective,Lightweight,UV Protection', 'yes', NULL, NULL, '138', '50', NULL),
(25, 'WX Contend', 'ANSI Z87+ HIGH IMPACT', '1749563743gbymHmrHIY.png', 'The WX Contend is truly a force to be reckoned with, combining its popular rectangular lens shape with an ANSI Z87.1+ safety rating for optical clarity and protection against high-mass and high-velocity impact. Light as a feather and tough as nails, this model sports a false keyhole nose bridge and subtle design elements baked right into the snap-hinge temple arms. The high-wrap WX Contend is protection, comfort, and style, wrapped into one pair of sunglasses you’ll want to take on all of your adventures.\r\n\r\nMeets ANSI Z87.1 safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion free clarity\r\nLightweight frame\r\nPrescription Ready', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-05-31 01:10:33', '2025-06-10 13:55:43', 'null', NULL, '130', '17', 'Flexible,Anti-Reflective,Lightweight,UV Protection', 'yes', NULL, NULL, '62', '40', NULL),
(26, 'WX Mystique', 'ANSI Z87+ HIGH IMPACT', '1749563760HTXkzr9C2q.png', 'Sophisticated fashionable women’s eyewear that delivers protection during any adventure.\r\n\r\nMeets ANSI Z87.1 safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion free clarity\r\nLightweight frame\r\nPrescription Ready', 4, 'Female', '4', '4', '6', '6', NULL, '10', 1, '2025-05-31 01:14:01', '2025-06-10 13:56:00', 'null', NULL, '125', '15', 'Flexible,Anti-Reflective,Lightweight,UV Protection', 'yes', NULL, NULL, '64', '41', NULL),
(27, 'WX Weekender', 'ANSI Z87+ HIGH IMPACT', '1749563782SPIiNgAvTv.png', 'You’ll always be weekend-ready with the functional yet stylish WX Weekender. All of the features you want with all of the protection you need—all in one pair of sunglasses.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet the MIL-PRF-32432(GL) ballistic standards: ANSI Z87.1+ optical clarity and high mass/high velocity impact standards: as well as US Federal OSHA 1910.133(b)(1)(1) standards', 4, 'Female', '4', '4', '6', '6', NULL, '10', 1, '2025-05-31 01:25:30', '2025-06-10 13:56:22', 'null', NULL, '125', '16', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '57', '46', NULL),
(28, 'WX Twisted', 'ANSI Z87+ HIGH IMPACT', '1749563797ZOraORbw73.png', 'One of our most popular styles in the Active Lifestyle category, the WX Twisted is built with clean-aggressive lines and wide temple arms for a take-charge appearance with exceptional coverage. Strong, rectangular frame fronts and entrenched, geometric design elements around the WX logos add subtle flair to the extreme protection and clarity delivered in every pair of Wiley X glasses. The WX Twisted is also offered in alternate frame options to better fit face shapes with high cheekbones and/or shallow nose bridges.', NULL, 'Male', '4', '10', '10', '4', NULL, '10', 1, '2025-06-01 19:16:33', '2025-06-18 09:02:03', 'null', NULL, '125', '17', 'UV Protection,Anti-Reflective,Flexible,Lightweight', 'yes', '124', '345', '65', '39', '23'),
(29, 'Brick', 'ANSI Z87+ HIGH IMPACT', '1749563815AnoCbH5iuz.png', 'Inspired by its rugged durability and no-nonsense presentation, the Brick solidly lives up to its name. With a traditional rectangular lens shape, the Brick’s streamlined temple arm is partially constructed of rubber, adding flexibility and support during intense activities. Virtually indestructible, this solid but lightweight model is built for a snug and secure, small-to-medium fit with all of the high-performance features that give your eyes and your vision unbeatable protection and clarity.', 4, 'Unisex', '4', '4', '6', '4', NULL, '10', 1, '2025-06-01 19:26:18', '2025-06-10 13:56:55', 'null', NULL, '120', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '63', '39', NULL),
(30, 'WX Kingpin', 'ANSI Z87+ HIGH IMPACT', '1749563831GEjUq1heBH.png', 'The WX Kingpin is built with a clean, traditional style, and a lightweight performance frame that’s ready for any activity you throw at it. Equipped with spring hinges for an optimized fit, you can be sure your sunglasses will stay securely right where you need them. The Kingpin’s nose bridge and streamlined temples are rubberized to prevent slip and ensure all-day comfort whether you’re traversing the winding rugged trails of the backcountry or navigating the swells of offshore waters.\r\n\r\nMeets ANSI Z87.1 safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion free clarity\r\nLightweight frame\r\nPrescription Ready', 4, 'Unisex', '4', '4', '6', '4', NULL, '10', 1, '2025-06-01 19:33:38', '2025-06-10 13:57:11', 'null', NULL, '122', '19', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '60', '40', NULL),
(31, 'WX Aspect', 'ANSI Z87+ HIGH IMPACT', '1749563845mLYItM9j68.png', 'No surprise that the WX Aspect has built-in features to cover every aspect of comfort and protection you look for in a pair of sunglasses. The dual-injected nose bridge and temple arms allow the ultra-sporty and durable frame to rest weightlessly on your ears and nose for even the longest days of wear. Equipped with spring hinges and rubber-tipped stems, the WX Aspect gives the feel of a customized fit on just about any head size while meeting the highest standards for optical clarity and safety.', 4, 'Male', '4', '4', '10', '4', NULL, '10', 1, '2025-06-01 19:39:51', '2025-06-10 13:57:25', 'null', NULL, '130', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '60', '42', NULL),
(33, 'WX Gravity', 'ANSI Z87+ HIGH IMPACT', '17495638601Y5rRRt1ZN.png', 'As its name would suggest, the WX Gravity is a very strong force in the Wiley X lineup, equipped with all of the features you need to maintain control in your pursuits. A slightly angled edge around the shatterproof lenses and textured detail on the rubberized temple arms are subtle and refined design elements that give the WX Gravity a modern flair. With a frame that fits comfortably on most face and head sizes, the included T-docking strap and irritant-blocking removable gasket provide extra security to the fit so your glasses stay right where they need to be.', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-06-01 19:46:07', '2025-06-10 13:57:40', 'null', NULL, '119', '17', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '63', '40', NULL),
(34, 'WX Glory', 'ANSI Z87+ HIGH IMPACT', '17495638766sCiyjQEtB.png', 'Lightweight, low-profile frames with no-slip, rubberized grip on both the nose bridge and temples, The WX Glory is a great choice for the active woman who doesn’t have time to worry about her gear', 4, 'Female', '4', '4', '5', '4', NULL, '10', 1, '2025-06-01 19:50:43', '2025-06-10 13:57:56', 'null', NULL, '125', '16', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '66', '42', NULL),
(35, 'WX Breach', 'ANSI Z87+ HIGH IMPACT', '1749563890Kg6g0WKUa0.png', 'Dependable protective eyewear with foam layer for additional protection\r\n\r\nMeets ANSI Z87.1 safety standards for optical clarity and high mass/high velocity impact protection\r\nIncludes removable Facial Cavity™ Seal that protects eyes from fine dust, pollen, irritants as well as peripheral light\r\n100% UVA/UVB protection with distortion free clarity\r\nPrescription Ready', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-06-01 20:06:26', '2025-06-10 13:58:10', 'null', NULL, '115', '15', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '63', '40', NULL),
(36, 'Airrage', 'ANSI Z87+ HIGH IMPACT', '1749563904kyyOpzF5CJ.png', 'Bigger isn’t always better, and the Airrage is a perfect example, offering big performance features in a slim, low-profile design. Its classic oval lens shape and thin, yet durable temple arms make it a great choice for smaller face shapes or situations where a slighter frame allows better compatibility with other equipment. The included T-docking strap and removable gasket ensure a snug and secure fit while keeping unwanted irritants from reaching your eyes.\r\n\r\nMeets ANSI Z87.1+ safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion free clarity\r\nDual-Injected Rubber Temples\r\nAnti-Fog (Non-Polarized Lenses Only)\r\nLightweight frame\r\nPrescription Ready', 4, 'Male', '4', '4', '6', '5', NULL, '10', 1, '2025-06-01 20:34:13', '2025-06-10 13:58:24', 'null', NULL, '124', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '61', '37', NULL),
(37, 'Vallus', 'ANSI Z87+ HIGH IMPACT', '1749563919bZWDc8Vy68.png', 'The Wiley X WX Vallus Sunglass is part of the Wiley X Active Lifestyle Series and features a bold frame design. Offering ANSI Z87.1 safety rated shatterproof frames and lenses, the Wiley X Vallus Sunglass gives you solid protection for all your outdoor sport activities.', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-06-01 20:44:54', '2025-06-10 13:58:39', 'null', NULL, '128', '16', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '63', NULL, NULL),
(38, 'WX Ovation', 'ANSI Z87+ HIGH IMPACT', '1749563938E0Kj1fUWsT.png', 'Now featuring our bold new icon on the temple and an array of new lens and frame colors, the WX Ovation sets the standard for durability, protection, and style. Featuring an ANSI Z87.1+ safety rating and our innovative swivel side shields that can be easily added for additional protection, the WX Ovation is built for versatility and maximum performance. Crystal-clear vision, unbeatable protection, and everyday wearability make the WX Ovation the ultimate choice for those who demand a single pair of sunglasses that dominates in any situation.', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-06-01 20:52:29', '2025-06-10 13:58:58', 'null', NULL, '140', '18', 'Lightweight,Flexible,UV Protection,Anti-Reflective,Scratch Resistant', 'yes', NULL, NULL, '56', '41', NULL),
(39, 'WX Helix', 'ANSI Z87+ HIGH IMPACT', '1749563953Iy51b1Jb7J.png', 'When it comes to sunglasses and style, the classic design of the WX Helix is always a popular choice but rarely do you see it fused so effortlessly with durability and protection. The WX Helix carries with it an ANSI safety rating, and our new swivel side shields are quick and easy to add or remove, adding another layer of versatility. Crystal-clear vision, maximum protection, and everyday wearability make the WX Helix a go-to selection for people wanting a little bit of everything while sacrificing nothing\r\n\r\nMeets ANSI Z87.1+ safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion free clarity\r\nLightweight frame\r\nPrescription Ready', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-06-02 08:05:34', '2025-06-10 13:59:13', 'Sun Glasses', NULL, '125', '19', 'Lightweight,Flexible,UV Protection,Anti-Reflective,Scratch Resistant', 'yes', NULL, NULL, '54', '39', NULL),
(40, 'WX Alfa', 'ANSI Z87+ HIGH IMPACT', '17495639680JRZDdTuIT.png', 'As part of our Active 6 lineup, the WX ALFA is built with a flatter 6-base lens that can accommodate a higher prescription range while offering the same ANSI+ protection and clarity of all Wiley X sunglasses. The sleek, rectangular build of its lightweight frame offers a comfortable yet flattering fit, and our removable swivel side shields are easy to add or remove for extra peripheral protection when you need it. As its name implies, the WX Alpha earns an A+ in both protection and style.\r\n\r\nMeets ANSI Z87.1 safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion free clarity\r\nLightweight frame\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 09:10:21', '2025-06-10 13:59:28', 'null', NULL, '135', '18', NULL, 'yes', NULL, NULL, '56', '43', NULL),
(42, 'WX Trek', 'ANSI Z87+ HIGH IMPACT', '1749563982kQv2dh0DUW.png', 'With an ANSI Z87.1+ safety rating and removable side shields for extra peripheral protection when you need it, the WX Trek is a virtual fortress of protection for your eyes. Its super-tough Triloid frame can accommodate a higher range of prescriptions than most high-wrap frames without sacrificing the lightweight comfort that makes it a viable choice for treks of any distance. Last but not least, a modern, rectangular lens shape and flattering stem detail give the WX Trek a sporty, go-anywhere flair.\r\n\r\nMeets ANSI Z87.1 safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion-free clarity\r\nLightweight frame\r\nPrescription Ready', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-06-02 09:14:26', '2025-06-10 13:59:42', 'null', NULL, '140', '17', NULL, 'yes', NULL, NULL, '57', '46', NULL),
(43, 'WX Grid', 'ANSI Z87+ HIGH IMPACT', '1749563999nwXRe1cF9D.png', 'No matter the trail, the terrain, or the conditions, the unique and dynamic design of the WX Grid will keep you moving in the right direction. The sleek, soft curve of the dual injected frame features rubberized temples and nose pad for slip-free wear, and the removable Facial Cavity™ seal sits comfortably against your face, blocking unwanted irritants. With an edgy flair and secure fit, the WX Grid provides the high-performance protection you need to ensure your path and peripheral views remain crystal clear.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 09:20:52', '2025-06-10 13:59:59', 'null', NULL, '122', '17', NULL, 'yes', NULL, NULL, '70', '42', NULL),
(44, 'Slay', 'ANSI Z87+ HIGH IMPACT', '1749564012I9RNTwJfkX.png', 'Holding its own in our Active Lifestyle series for over 10 years, the Slay\'s slightly aggressive high-wrap style continues to be a favorite in our Active Lifestyle category. Shatterproof and ballistic-rated, these sunglasses meet both ANSI Z87.1+ and OSHA standards for clarity and protection without sacrificing all-day comfort. Its dual-injected temples and nose bridge keep it lightweight, while strategically designed rubber elements promise flexible durability and a no-slip fit—keeping them securely and comfortably in place during high-intensity activities.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 09:25:07', '2025-06-10 14:00:12', 'null', NULL, '120', '16', NULL, 'yes', NULL, NULL, '65', '37', NULL),
(45, 'WX Ozone', 'ANSI Z87+ HIGH IMPACT', '1749564038Ydy2tlCI76.png', 'As the newest member of our Climate Control series, the WX Ozone offers yet another premium feature that will place it at the forefront of your adventure-gear lineup. Our Click AIR gasket combines exceptional protection from the elements with a quick-click ventilation option to eliminate fogging. Pairing this technology with a sporty, lightweight build and ANSI+ protection and clarity, the WX Ozone is ready to take on the rigors of even the harshest environments', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 09:29:30', '2025-06-10 14:00:38', 'null', NULL, '125', '18', NULL, 'yes', NULL, NULL, '63', '43', NULL),
(46, 'Romer', 'ANSI Z87+ HIGH IMPACT', '174956406072NUlrw8ow.png', 'The Wiley X ROMER  meets MIL-PRF-32432A ballistic safety standards to ensure that you\'ll be protected during the most intense action. Designed with comfort in mind, these glasses are lightweight, yet extremely durable. They also block out any peripheral light that may obstruct your view. Need a change? All you have to do is remove the lenses and pop in the right ones for whatever situation you need. The WX ROMER 3 is offers stylish and versatile protection - is there anything else you could ask for?\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet the MIL-PRF-32432A ballistic standards: ANSI Z87.1+ optical clarity and high mass/high velocity impact standards: as well as US Federal OSHA 1910.133(b)(1)(1) standards\r\n100% UVA/UVB protection with distortion free clarity\r\nT-Shell™ Lens coating resists scratching\r\nSleek design that is Night Vision Goggle (NVG) Compatible\r\nFrame eliminates tunnel vision with 90-degree Wrapback™\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 09:34:01', '2025-06-10 14:01:00', 'null', NULL, '128', '19', NULL, 'yes', NULL, NULL, '63', '38', NULL),
(48, 'WX Saint', 'ANSI Z87+ HIGH IMPACT', '1749565771VzBXNgjMfR.png', 'So good they\'re bad! Our WX SAINT meets the ANSI Z87.1+ safety standards for high velocity/high mass impacts and optical clarity making them the perfect choice for any serious situation. The lenses also include a clear hard coating make them ultra-scratch resistant. The WX SAINT\'s lightweight design and rubber tipped temples provide enough comfort for you to wear all day. Need to adjust for different light or just want to switch up your look? Simply take lenses out and replace them with the ones that fit the situation.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet the MIL-PRF-32432(GL) ballistic standards: ANSI Z87.1+ optical clarity and high mass/high velocity impact standards: as well as US Federal OSHA 1910.133(b)(1)(1) standards\r\n100% UVA/UVB protection with distortion free clarity\r\nT-Shell™ Lens coating resists scratching\r\nDouble-injected rubber temples for non-slip comfort\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 09:42:40', '2025-06-10 14:29:31', 'null', NULL, '114', '16', NULL, 'yes', NULL, NULL, '68', '40', NULL),
(49, 'Tobi', 'ANSI Z87+ HIGH IMPACT', '1749565793SjBtdhdsTu.png', 'Authentic Wiley-X Eyewear\r\nIncludes Wiley-X Hard Case, Cleaning Cloth, & Lanyard\r\n100% UVA/UVB Protection\r\nSECURE NON-SLIP RUBBERIZED FIT\r\nCERTIFIED TO ANSI Z87.1 HIGH IMPACT AND OPTICAL PERFORMANCE STANDARD\r\nRATED AS OSHA GRADE OCCUPATIONAL PROTECTIVE EYEWEAR\r\n5.5\" Frame Width 1.6\" Frame height', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 09:45:48', '2025-06-10 14:29:53', 'null', NULL, '140', '17', NULL, 'yes', NULL, NULL, '60', '41', '140'),
(51, 'WX Valor', 'HIGH RX', '1749565813427zFwJ3tV.png', 'Rise up to the challenge! The WX VALOR features a lightweight, semi-rimless frame, with rubber tipped temples to provide extra grip to keep the glasses from slipping during intense action. The WX VALOR meets MIL-PRF-32432A ballistic safety standards. We pay close attention to the quality of product that we make for the people who defend our country.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet the MIL-PRF-32432(GL) ballistic standards: ANSI Z87.1+ optical clarity and high mass/high velocity impact standards: as well as US Federal OSHA 1910.133(b)(1)(1) standards\r\n100% UVA/UVB protection with distortion free clarity\r\nT-Shell™ Lens coating resists scratching\r\nDouble-injected rubber temples for non-slip comfort\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 10:56:44', '2025-06-10 14:30:13', 'null', NULL, '120', '19', NULL, 'yes', NULL, NULL, '70', '38', NULL),
(52, 'Censor', 'ANSI Z87+ HIGH IMPACT', '1749565828rMzi4wZacl.png', 'The WX CENSOR is the perfect pair of sunglasses to wear during those moments of uncontrollable excitement. The WX CENSOR meets the MIL-PRF-32432(GL) Safety Standard.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 11:02:43', '2025-06-10 14:30:28', 'null', NULL, '130', '16', NULL, 'yes', NULL, NULL, '61', '37', NULL),
(53, 'Vapor', 'ANSI Z87+ HIGH IMPACT', '1749565844xORSNdz8zY.png', 'Lock it in! Our WX VAPOR is one of our most trusted pairs of eyewear. Featuring thin temples and as well as a sleek frame and an adjustable nose piece, the WX VAPOR is designed with style and comfort in mind. The WX VAPOR meets MIL-PRF-32432A ballistic safety standards keeping you safe from unexpected impacts. If you\'re the type of person who needs durable eyewear, these glasses was made for you.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 11:06:38', '2025-06-10 14:30:44', 'null', NULL, '135', '0', NULL, 'yes', NULL, NULL, '143', '51', NULL),
(54, 'Rebel', 'ANSI Z87+ HIGH IMPACT', '1749565859qyYom12hIh.png', 'Our WX Rebel with alternate fit features a durable, low-profile frame that delivers lightweight comfort and a no-nonsense appearance. The sleek, tapered temple arms and dual-injected nose bridge are built to provide a secure fit to those with high cheekbones and/or shallow nose bridges. Paired with its ANSI Z87.1+ safety rating for optical clarity and high-mass/high-velocity impacts, these sunglasses are as tough as their name implies, and open to any adventure. From open roads to open waters, the WX Rebel is ready for action.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 11:11:35', '2025-06-10 14:30:59', 'null', NULL, '124', '18', NULL, 'yes', NULL, NULL, '65', '40', NULL),
(55, 'Tide', 'ANSI Z87+ HIGH IMPACT', '1749565881KyVUwLkYIY.png', 'Experience industry-leading safety and comfort with Uvex Honeywell frames, engineered for those who demand superior eye protection without compromising on style. Designed by Honeywell, a global leader in safety solutions, Uvex frames are built to meet rigorous safety standards, making them ideal for industrial, laboratory, and workplace environments.', 4, 'Male', '4', '4', '5', '4', NULL, '3', 1, '2025-06-02 14:07:41', '2025-06-10 14:31:21', 'Sun Glasses', NULL, '125', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '67', NULL, NULL),
(56, 'Gamer', 'ANSI Z87+ HIGH IMPACT', '17495658973Wu2LBDs4T.png', 'The competition never stood a chance! Our WX GAMER meets ASTM F803 safety standards for high-velocity impact resistance. With a soft plastic nose piece and lightweight frame design, the WX GAMER is the perfect sports accessory. By attaching the included adjustable strap, you can convert these glasses into an awesome pair of goggles. If you\'re looking to gain an edge on your opponents, while also feeling safe, comfortable, and confident, the WX GAMER is the right pair of eyewear for you!', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 14:12:33', '2025-06-10 14:31:37', 'Sun Glasses', NULL, '135', '18', 'Flexible,UV Protection,Anti-Reflective,Scratch Resistant,Lightweight', 'yes', NULL, NULL, '57', NULL, NULL),
(57, 'Flash', 'ANSI Z87+ HIGH IMPACT', '1749565912IsTwRSWwTf.png', 'Woah! Did you see that? Our Wiley X WX FLASH may not make you the fastest person on earth, but they are ASTM F803 rated and will keep you protected from high-velocity projectile impact. The lightweight frame and soft plastic nose piece make the WX FLASH comfortable enough to wear for an entire game or match. Need a little versatility? By attaching the adjustable strap, you can easily convert the WX FLASH from glasses to goggles. The road to victory has never been clearer than through the lenses of the WX FLASH.\r\n\r\nConverts to goggle with an included adjustable strap\r\nShatterproof Selenite™ Polycarbonate lenses that meet rigorous AS™ F803 sports safety standards\r\nOptional Smoke Grey lenses (sold separately)\r\n100% UVA/UVB protection with distortion free clarity\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 14:17:47', '2025-06-10 14:31:52', 'Sun Glasses', NULL, '125', '17', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', NULL, NULL, NULL, '48', NULL, NULL),
(58, 'Victory', 'ANSI Z87+ HIGH IMPACT', '1749565927rCHdDkdV5X.png', 'VICTORY can literally be yours! Our Wiley X WX VICTORY features flexible temples, a soft plastic nose piece, and a lightweight frame that provide you with unparalleled comfort. To ensure your safety, these glasses meet ASTM F803 safety ratings for high-velocity projectile impact. By attaching the included adjustable strap, you can convert the WX VICTORY into goggles. We know the when you take the field that you\'ll have nothing to worry about - unless your competition is wearing WX VICTORY, of course.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet rigorous ASTM F803 sports safety standards 100% UVA/UVB protection with distortion free clarity\r\nConverts to goggle with an included adjustable strap\r\nOptional Smoke Grey lenses (sold separately)\r\nPrescription Ready', 4, 'Unisex', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 14:23:28', '2025-06-10 14:32:07', 'Eye Glasses', NULL, '125', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '52', '34', NULL),
(59, 'Fierce', 'ANSI Z87+ HIGH IMPACT', '1749565942Mah7cKYT3y.png', 'Wake up your inner-beast! Our Wiley X WX FIERCE helps fuel your fire when you are in the heat of battle by providing you with superior protection. By meeting ASTM F803 safety standards for high-velocity impact resistance, you\'ll have the confidence to look fear in the face and laugh. The soft plastic nose piece and lightweight frame deliver extra comfort, and the adjustable strap can convert your glasses into protective goggles. The WX FIERCE might be designed for sports, but this piece of eyewear doesn\'t play games.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet rigorous ASTM F803 sports safety standards 100% UVA/UVB protection with distortion free clarity\r\nConverts to goggle with an included adjustable strap\r\nOptional Smoke Grey lenses (sold separately)\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 14:27:37', '2025-06-10 14:32:22', 'Eye Glasses', NULL, '135', '18', 'Lightweight,Flexible,Anti-Reflective,Scratch Resistant', 'yes', NULL, NULL, '52', NULL, NULL),
(60, 'PT-1', 'ANSI Z87+ HIGH IMPACT', '174956595840j12DpyvJ.png', 'Need a little versatility in your life? Our Wiley X PT-1 meets the MIL-PRF-32432 ballistic safety standards for high mass/high velocity impacts and optical quality. With the visor style lens, the WX PT-1 helps block any unwanted light from your peripheral vision providing an unobstructed view. The lightweight design and flexible nose piece add a level of comfort that would make your raggedy old sweats jealous. If you\'ve had difficulty finding the right pair of glasses, it\'s obvious that you didn\'t shop here first.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 14:34:41', '2025-06-10 14:32:38', 'Sun Glasses', NULL, '0', '0', 'Scratch Resistant,Anti-Reflective,UV Protection,Flexible', 'yes', NULL, NULL, '0', '0', '0'),
(61, 'Epic', 'ANSI Z87+ HIGH IMPACT', '1749565975HhlakVXhHS.png', 'It\'s going to be huge. No. Monumental. No. Legendary! The Wiley X WX EPIC WorkSight eyeglasses deliver a trendy style while still hitting all of the critical protective checkboxes. The frames meet the ANSI Z87.1 safety standard for high velocity/high mass impacts with the optional removable side shields installed. If you’re looking for a single eyewear solution for work and play, look no further than the WX EPIC.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet ANSI Z87.1 high velocity and high mass impact standards as well as US Federal OSHA 1910.133(b)(1)(1) standards when removable side shields are equipped\r\nHand polished, durable Triloid™ nylon frame\r\nRemovable side shields included to provide lateral protection on the job. Side shields can also be converted to permanent with included plug\r\nPrescription Ready', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-06-02 14:39:04', '2025-06-10 14:32:55', 'Eye Glasses', NULL, '145', '17', 'Lightweight,Flexible,Scratch Resistant', 'yes', NULL, NULL, '55', '38', '145'),
(62, 'Marker', 'ANSI Z87+ HIGH IMPACT', '1749565997FxyOMCuHLi.png', 'Wiley X WX MARKER is a perfect choice of Eyeglasses from the exceptional Wiley X collection. These exciting Eyeglasses have a compelling arrangement of remarkable features. This item is made from plastic, for those going for a bold look and stylish flair. The length of the temple pieces are 140 millimeters. It is fully rimmed along the edges to give a sense of completeness, lens security, toleration and absolute style. If you\'re looking for something that\'s compatible with bi-focal or progressive lenses, then you\'ve found it. Black color is subtle, versatile and matches almost any outfit. a greenish blue color, based on the gem of the same name. The width of the bridge of this frame is 15 millimeters. Item ranges in price between $100 and $150. If you\'re looking for something feminine, look no further. These frames are specifically designed for women. If you\'re looking for something masculine, look no further. These frames are specifically designed for men. This is definitely a favorite among many people. It\'s a popular choice primarily recognized for its broad appeal. Get down-to-earth when you use brown colors. The eyesize of this item is 55 millimeters. It’s nature’s color for water and sky. Subtract unnecessary weight and distractions wearing these minimal rimless glasses which make you look (and feel) like you\'re practically wearing nothing at all. This eyewear is eligible for prescription lens installation. If you\'re concerned about sun protection, you are able to add custom polarized or non-polarized clip-on sunglasses to these frames..', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 19:05:39', '2025-06-10 14:33:17', 'Eye Glasses', NULL, '125', '15', 'Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '55', NULL, NULL),
(63, 'Profile', NULL, '1749566013BEs0UA9Zij.png', 'Versatile eyeglasses that transition easily from work to play, the WX Profile meshes style and protection in an understated, durable Triloid™nylon frame. Shatterproof Selenite™ Polycarbonate lenses meet ANSI Z87.1+ high-velocity and high-mass impact standards as well as US Federal OSHA standards when worn with the removable side shields. Quickly remove the side shields, and you’re set with a timely and on-trend look that’s comfortable enough to wear all day, both on the job and off.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet ANSI Z87.1 high velocity and high mass impact standards as well as US Federal OSHA 1910.133(b)(1)(1) standards when removable side shields are equipped\r\nHand polished, durable Triloid™ nylon frame\r\nRemovable side shields included to provide lateral protection on the job. Permanent side shields available\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 19:22:40', '2025-06-10 14:33:33', 'Eye Glasses', NULL, '140', '17', 'Flexible,Lightweight,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '54', '36', '140'),
(64, 'Contour', 'ANSI Z87+ HIGH IMPACT', '1749566027JTT4rey8g5.png', 'You want comfortable and stylish protective eyewear, and we have what you want. The WX CONTOUR features a comfortable, lightweight design that is perfect for wearing all day. The WX CONTOUR meets ANSI Z87.1 safety standards with the removable side shields installed to provide extra protection from unexpected impacts as well as dust and dirt. Whether you’re working in the office or in the shop, the WX CONTOUR is the solution to all of your eyewear problems.\r\n\r\nShatterproof Selenite™ Polycarbonate lenses that meet ANSI Z87.1 high velocity and high mass impact standards as well as US Federal OSHA 1910.133(b)(1)(1) standards when removable side shields are equipped\r\nSuper-tough Triloid™ nylon frame\r\nRemovable side shields included to provide lateral protection on the job. Side shields can also be converted to permanent with included plug\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 19:26:53', '2025-06-10 14:33:47', 'Eye Glasses', NULL, '140', '17', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '54', '36', '138'),
(65, 'Sleek', 'ANSI Z87+ HIGH IMPACT', '1749566046TvKyIgRdDo.png', 'Don’t be fooled by the smaller stature of the WX Sleek. Just as you would expect from its name, this low-profile model packs maximum performance and protection into a sleek, simplistic frame design that fits a smaller head size. The removable Facial Cavity™ Seal rests securely against your face and keeps unwanted irritants from obscuring your vision, no matter the conditions, so you can clearly and comfortably tackle even the biggest jobs.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 19:32:03', '2025-06-10 14:34:06', 'Sun Glasses', NULL, '121', '14', 'Spring Hinges,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '60', '34', '121'),
(66, 'Rogue', 'ANSI Z87+ HIGH IMPACT', '1749566058iRBHsvSeWc.png', 'WX ROGUE COMM sets a new standard for protective eyewear. It features thin COMM temples in a curved temple system that fits perfectly under your earmuffs or other ear mounted communication devices. Together with the 360° adaptable nose piece, the semi-rimless design, and the lightweight frame, you are ensured an extremely comfortable fit. Your focus will be ensured all day long no matter what with the WX ROGUE COMM.', 4, 'Male', '5', '4', '5', '4', NULL, '10', 1, '2025-06-02 19:37:14', '2025-06-10 14:34:18', 'Sun Glasses', NULL, '120', '0', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '0', '0', '149'),
(67, 'Nash', 'ANSI Z87+ HIGH IMPACT', '1749566071K83K828Vrv.png', 'With its bold design, robust temple arms, and high-wrap frame, the WX Nash is packed with attitude and high-performance features. Its lightweight, ultra-durable frame rests comfortably and securely on your face and ears, with rubber grips inside the temples and nose bridge to prevent any slipping during intense activities. With shatterproof lenses and virtually indestructible frame, the WX Nash meets ANSI Z87.1+ Ballistic, and OSHA standards for safety and protection, while delivering crystal-clear, distortion-free vision anytime you need it.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 20:10:47', '2025-06-10 14:34:31', 'Sun Glasses', NULL, '125', '15', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '64', '41', '125'),
(68, 'Enzo', 'ANSI Z87+ HIGH IMPACT', '1749566085gWg67QuPId.png', 'Wind, rain, dirt, dust—the WX Enzo keeps all of it out while keeping up with the well-earned reputation of the WX Climate Control series. From the removable Facial Cavity™ Seal that blocks irritants to its rubberized temples and rectangular low-profile style, every inch of the WX Enzo was thoughtfully designed and purpose-built. Aggressive frame lines suggest a bit of an attitude that plays well with the medium to large overall fit. Whatever the conditions, you’ll be prepared for it all, with unobstructed vision and maximum protection against the elements.\r\n\r\nMeets ANSI Z87.1+ safety standards for optical clarity and high mass/high velocity impact protection\r\n100% UVA/UVB protection with distortion free clarity\r\nDual-Injected Rubber Temples\r\nDual-Injected Rubber Nose Pads\r\nAnti-Fog (Non-Polarized Lenses Only)\r\nLightweight frame\r\nPrescription Ready', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 20:19:58', '2025-06-10 14:34:45', 'Sun Glasses', NULL, '125', '14', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '64', '41', '125'),
(69, 'Ignite', 'ANSI Z87+ HIGH IMPACT', '1749566101A8KbgFfDem.png', 'Wiley X offers its WX Ignite sunglasses for the man who demands a combination of high performance design and cutting-edge aesthetics. The rectangular wrap frames are crafted in a strong but lightweight material that keeps up with your active lifestyle, with temples that curve inward for stability and grip behind the ears.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 20:23:17', '2025-06-10 14:35:01', 'Sun Glasses', NULL, '125', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant,Spring Hinges', 'yes', NULL, NULL, '65', '39', '125'),
(70, 'Crush', NULL, '1749566119rT4VScLWsq.png', 'Watch your opponents crumble! The Wiley X prescription ready WX CRUSH meets ASTM F803 safety ratings for high-velocity impact resistance making sure that your eyes are safe and protected. The soft plastic nose piece and lightweight, yet durable frame design will give you the confidence that you need to rise to any challenge. You can easily convert the WX CRUSH into a pair of goggles by attaching the included adjustable strap. Once you hit the court or field with a pair of the WX CRUSH, you\'ll wonder how you ever played without them.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 20:26:41', '2025-06-10 14:35:19', 'Eye Glasses', NULL, '130', '18', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '52', NULL, '131'),
(71, 'Titan', 'ANSI Z87+ HIGH IMPACT', '1749566137fTKNweI2OO.png', 'Engineered for performance and trusted by military, law enforcement, and outdoor enthusiasts worldwide, Wiley X frames deliver uncompromising protection with cutting-edge style. Built to withstand the toughest conditions, these frames combine ballistic-rated durability with sleek, comfortable designs suitable for both high-intensity environments and everyday wear.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 20:32:39', '2025-06-10 14:35:37', 'Sun Glasses', NULL, '125', '26', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '60', '-2', '125'),
(72, 'Klein', 'ANSI Z87+ HIGH IMPACT', '17495661502TbqXMMXoz.png', 'Wiley X Klein proves style can come with uncompromising protection. Selenite TM polycarbonate lenses meet both ANSI Z87.1 and OSHA 1910.133 standards for security you can depend on. Wiley X Klein lenses are fortified with the scratch-resistant T-Shell TM coating and 100% UVA/UVB blockage to withstand extreme environments. Get your eyes the protection they deserve and tackle the world with the Wiley X Klein.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 20:36:33', '2025-06-10 14:35:50', 'Sun Glasses', NULL, '130', '13', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '67', NULL, '130'),
(73, 'Hayden', 'ANSI Z87+ HIGH IMPACT', '1749566168VtQAWlNOUz.png', 'Lightweight frame\r\nMeets or exceeds ANSI Z87.1 industrial standards for high-mass and high-velocity impact protection.\r\nSmoke grey lenses provide glare reduction without distorting colors. Excellent in bright/glare conditions. Light transmission 14%-20%\r\n100% UVA/UVB protection with distortion free clarity', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 20:42:51', '2025-06-10 14:36:08', 'Sun Glasses', NULL, '130', '13', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '66', NULL, '131'),
(74, 'Wave', 'ANSI Z87+ HIGH IMPACT', '1749566189pK9kZbrqjJ.png', 'This eyewear comes with a shatterproof selenite Polycarbonate lens that conforms to ANSI Z87.1 standards. It has a T-shell coating that provides scratch resistance. The glasses have a removable facial cavity that blocks dirt, dust, and pollen from the air. There are many lens options available to ensure that the glasses provide high visual clarity in all light conditions.', 4, 'Unisex', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 20:58:35', '2025-06-10 14:36:29', 'Sun Glasses', NULL, '125', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '64', NULL, '125');
INSERT INTO `products` (`product_id`, `product_name`, `product_tags`, `featured_image`, `description`, `sub_category`, `gender`, `rim_type`, `style`, `material`, `shape`, `eye_size`, `manufacturer_name`, `product_status`, `created_at`, `updated_at`, `glasses_type`, `lens_size`, `temple_size`, `bridge_size`, `frame_features`, `prescriptions_available`, `upc`, `sku`, `lens_width`, `lens_height`, `frame_width`) VALUES
(75, 'Ace', 'ANSI Z87+ HIGH IMPACT', '1749566211wcwnG3tUFq.png', 'The stealthy frame combined with the rubberized nose pads is among the favorite for many, especially sports enthusiasts. This model is perfect for you, who like to follow fashion and catch the attention in a discrete way wherever you go.', 4, 'Male', '4', '4', '6', '4', NULL, '10', 1, '2025-06-02 21:02:59', '2025-06-10 14:36:51', 'Sun Glasses', NULL, '130', '18', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '64', NULL, '130'),
(76, 'Kobe', 'ANSI Z87+ HIGH IMPACT', '1749566228YloDsEcXLi.png', 'Failure is not an option! The Wiley X WX KOBE meets the ANSI Z87.1 safety standards for high mass/high velocity impacts and optical quality. By adding the rubber nose pad, we ensured that the WX KOBEs would rest comfortably and securely on your face for long periods of time. Along with comfort and style, these sunglasses block any light from entering your peripheral vision giving you a clear and focused view of the world.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 21:04:59', '2025-06-10 14:37:08', 'Sun Glasses', NULL, '125', '21', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective,Scratch Resistant,UV Protection', 'yes', NULL, NULL, '72', NULL, '125'),
(77, 'WX APEX', 'ANSI Z87+ HIGH IMPACT', '1749566253Y3RV0L4wgc.png', 'Enjoy worry-free outdoor adventures with 100% UVA/UVB protection, safeguarding your eyes from harmful rays wherever you go.\r\nAll-Day Comfort\r\nFeel the difference of lightweight frames, crafted to stay comfortable during long hours on the job or at play.\r\nPrescription Ready\r\nPerfectly tailored to you: Our prescription-ready lenses combine style with the clarity you need for every moment.', 4, 'Male', '4', '4', '5', '4', NULL, '10', 1, '2025-06-02 21:15:33', '2025-06-10 14:37:33', 'Eye Glasses', NULL, '0', '0', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, NULL, '0', '0'),
(78, 'Hudson', 'ANSI Z87+ HIGH IMPACT', '1749582750GUUtpYQeHK.png', 'The Badgley Mischka Hudson is a perfect choice of Eyeglasses from the amazing Badgley Mischka collection. These exciting Eyeglasses have a compelling arrangement of amazing features. If you\'re looking for something that\'s compatible with bi-focal or progressive lenses, then you\'ve found it. This eyewear is eligible for prescription lens installation. If you\'re concerned about sun protection, you are able to add custom polarized or non-polarized clip-on sunglasses to these frames. This frame is composed of metal like nickel, monel or stainless steel to help give some durability and relative overall strength. The width of the bridge of this frame is 18 millimeters. Item ranges in price between $150 and $200. If you\'re looking for something masculine, look no further. These frames are specifically designed for men. It’s nature’s color for water and sky. The eyesize of this item is 54 millimeters. The length of the temple pieces are 145 millimeters. Get down-to-earth when you use brown colors.', 4, 'Male', '4', '4', '5', '4', NULL, '11', 1, '2025-06-02 21:21:00', '2025-06-10 19:12:30', 'Eye Glasses', NULL, '145', '18', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '54', NULL, '145'),
(79, 'HUDSON', 'ANSI Z87+ HIGH IMPACT', '1749582782ZDZD8j4EZf.png', 'High quality, impact resistant blue light blocking lenses. Get more comfort while reading from digital screens. Blue light filtering lenses block potentially harmful high-energy light ( HEV ).', 4, 'Female', '4', '4', '7', '4', NULL, '12', 1, '2025-06-02 21:25:42', '2025-06-10 19:13:02', 'Eye Glasses', NULL, '135', '20', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant,Spring Hinges', 'yes', NULL, NULL, '50', NULL, '135'),
(80, 'HUDSON', 'ANSI Z87+ HIGH IMPACT', '1749582813z0mX2WD9v2.png', 'Designed for smaller faces without sacrificing performance or style, the O’Neill Small Fit collection offers the perfect blend of lightweight comfort, modern aesthetics, and everyday durability. Whether you’re hitting the waves or the streets, these frames deliver a snug, secure fit ideal for active lifestyles and all-day wear.\r\n\r\nCrafted with high-quality materials and flexible construction, O’Neill Small Fit frames are built to move with you—offering enhanced comfort, impact resistance, and effortless style in a compact design. With prescription-ready options and a range of colors and shapes, this collection proves that great things really do come in small packages.', 4, 'Male', '4', '4', '7', '4', NULL, '13', 1, '2025-06-02 21:29:11', '2025-06-10 19:13:33', 'Eye Glasses', NULL, '130', '16', 'Flexible,Anti-Reflective,UV Protection,Scratch Resistant,Lightweight', 'yes', NULL, NULL, '48', NULL, '130'),
(81, 'Hudson', 'ANSI Z87+ HIGH IMPACT', '1749582832SWL0sTYMuo.png', 'merican Optical (AO) is one of the oldest and most respected eyewear brands in the world. Known for iconic designs and uncompromising craftsmanship, AO frames blend timeless style with military-grade durability—trusted by pilots, astronauts, and style pioneers alike.\r\n\r\nEach pair of AO glasses is engineered with premium materials, offering exceptional comfort, optical clarity, and long-lasting performance. From the legendary Original Pilot sunglasses worn by NASA crews to modern optical frames built for everyday wear, American Optical stands for quality, heritage, and American-made excellence.', 4, 'Male', '4', '4', '7', '4', NULL, '15', 1, '2025-06-02 21:32:07', '2025-06-10 19:13:52', 'Sun Glasses', NULL, '145', '19', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '57', NULL, '145'),
(82, 'MS1', 'ANSI Z87+ HIGH IMPACT', '1749582849JX38suVzOe.png', 'Hudson SL frames frames have an eye-catching, light brown look that gives you safety on top of style. Their ANSI Z87 rating means you’ll get maximum protection that holds up in even the most strenuous occupational situations.', 4, 'Unisex', '4', '4', '7', '4', NULL, '14', 1, '2025-06-03 16:17:38', '2025-06-10 19:14:09', 'Eye Glasses', NULL, NULL, '23', 'Lightweight,Flexible,Anti-Reflective,UV Protection,Scratch Resistant,Adjustable Nose Pads', 'yes', NULL, NULL, '52', NULL, NULL),
(83, 'VL1', 'ANSI Z87+ HIGH IMPACT', '1749582867EMP0z20NNJ.png', 'The Hudson Optical ValueLine Series VL-1 Safety Glasses is a full rim oval metal frame with prescription available. These safety glasses from Hudson Optical feature spring hinges, and silicone adjustable nose pads for a comfortable fit. The Hudson safety glasses meet rigorous industry standards ANSI Z87.1-2015 providing ultimate protection. The VL-1 Hudson Optical Safety Glasses are available in Brown and Charcoal colors and in 2 sizes. Side Shields are available to purchase separately. For more options, check our Hudson Optical collection.', 4, 'Unisex', '4', '4', '5', '6', NULL, '14', 1, '2025-06-03 16:23:47', '2025-06-10 19:14:27', 'Eye Glasses', NULL, '150', '20', 'Adjustable Nose Pads', 'yes', NULL, NULL, '50', NULL, '150'),
(84, 'VL3', 'ANSI Z87+ HIGH IMPACT', '1749582885CgUATjIiBz.png', 'The Hudson Optical ValueLine Series VL-3 Safety Glasses is a full rim round metal frame with prescription available. These safety glasses from Hudson Optical feature spring hinges, double bridge, and silicone adjustable nose pads for a comfortable fit. The Hudson safety glasses meet rigorous industry standards ANSI Z87.1-2015 providing ultimate protection. The VL-3 Hudson Optical Safety Glasses are available in Brown and Charcoal colors. Side Shields are available to purchase separately. For more options, check our Hudson Optical collection.', 4, 'Male', '4', '4', '7', '6', NULL, '14', 1, '2025-06-03 16:29:37', '2025-06-10 19:14:45', 'Eye Glasses', NULL, '150', '19', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '52', NULL, '150'),
(85, 'EL3', 'ANSI Z87+ HIGH IMPACT', '1749582909Hle5ESi8Wo.png', 'The Hudson Optical EconomyLine Series EL-3 Safety Glasses is a full rim oval metal frame with prescription available. These safety glasses from Hudson Optical feature a double bridge and silicone adjustable nose pads for a comfortable fit. The Hudson safety glasses meet rigorous industry standards ANSI Z87.1-2015 providing ultimate protection. The EL-3  Hudson Optical Safety Glasses are available in Brown and Gunmetal colors. Side Shields are available to purchase separately.', 4, 'Male', '4', '4', '7', '6', NULL, '14', 1, '2025-06-03 19:19:24', '2025-06-10 19:15:09', 'Eye Glasses', NULL, '150', '19', 'Spring Hinges,Flexible,Anti-Reflective,UV Protection,Lightweight,Adjustable Nose Pads', 'yes', NULL, NULL, '52', NULL, '150'),
(86, 'ST3', 'ANSI Z87+ HIGH IMPACT', '1749582925ZZuFySebqH.png', 'The Hudson Optical Stainless Steel Series ST-3 Safety Glasses is a full rim rectangular non-corrosive metal frame with prescription available. These safety glasses from Hudson Optical feature an advanced 8-base design, double bridge, spring hinges, and silicone adjustable nose pads for a comfortable fit. The Hudson safety glasses meet rigorous industry standards ANSI Z87.1-2015 providing ultimate protection. The ST-3  Hudson Optical Safety Glasses are available in Brown and Charcoal colors, and in 2 sizes.', 4, 'Male', '4', '4', '7', '4', NULL, '14', 1, '2025-06-03 19:25:02', '2025-06-10 19:15:25', 'Eye Glasses', NULL, '145', '15', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '60', NULL, '145'),
(87, 'ST4', 'ANSI Z87+ HIGH IMPACT', '1749582942mmigKJIuDl.png', 'The Hudson Optical Stainless Steel Series ST-4 Safety Glasses is a full rim rectangular non-corrosive metal frame with prescription available. These safety glasses from Hudson Optical feature an advanced 8-base design, spring hinges, and silicone adjustable nose pads for a comfortable fit. The Hudson safety glasses meet rigorous industry standards ANSI Z87.1-2015 providing ultimate protection.\r\n\r\nThe ST-4  Hudson Optical Safety Glasses are available in Brown and Charcoal colors, and in 2 sizes.', 4, 'Male', '4', '4', '7', '4', NULL, '14', 1, '2025-06-03 19:28:19', '2025-06-10 19:15:42', 'Eye Glasses', NULL, '150', '15', 'Adjustable Nose Pads,Spring Hinges,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '61', NULL, '150'),
(88, 'SL1', 'ANSI Z87+ HIGH IMPACT', '17495829630okwwhlSg5.png', 'The Hudson Optical Standard Line Series SL-1 Safety Glasses is a full rim oval metal frame with a matte finish and prescription available. These safety glasses from Hudson Optical feature spring hinges, and silicone adjustable nose pads for a comfortable fit. The Hudson safety glasses meet rigorous industry standards ANSI Z87.1-2010 providing ultimate protection.The SL-1  Hudson Optical Safety Glasses are available in Brown and Charcoal colors, and in 2 sizes.', 4, 'Unisex', '4', '4', '7', '6', NULL, '14', 1, '2025-06-03 19:30:56', '2025-06-10 19:16:03', 'Eye Glasses', NULL, '145', '20', 'Spring Hinges,Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,Scratch Resistant', 'yes', NULL, NULL, '47', NULL, '145'),
(89, 'SL2', 'ANSI Z87+ HIGH IMPACT', '1749582980JMtuZs9Ruj.png', 'The Hudson Optical Standard Line Series SL-2 Safety Glasses is a full rim oval metal frame with a matte finish and prescription available. These safety glasses from Hudson Optical feature spring hinges, and silicone adjustable nose pads for a comfortable fit. The Hudson safety glasses meet rigorous industry standards ANSI Z87.1-2010 providing ultimate protection.The SL-2  Hudson Optical Safety Glasses are available in Brown and Charcoal colors, and in 2 sizes.', 4, 'Unisex', '4', '4', '7', '6', NULL, '14', 1, '2025-06-03 19:34:06', '2025-06-10 19:16:20', 'Eye Glasses', NULL, '145', '21', 'Spring Hinges,Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '47', NULL, '145'),
(90, 'SL3', 'ANSI Z87+ HIGH IMPACT', '17495829987yhFX2uQjJ.png', 'The Hudson Optical Standard Line Series SL-3 Safety Glasses is a full rim oval metal frame with a matte finish and prescription available. These safety glasses from Hudson Optical feature spring hinges, and silicone adjustable nose pads for a comfortable fit. The Hudson safety glasses meet rigorous industry standards ANSI Z87.1-2010 providing ultimate protection.\r\n\r\n \r\n\r\nThe SL-3  Hudson Optical Safety Glasses are available in Brown and Charcoal colors, and in 2 sizes.', 4, 'Unisex', '4', '4', '7', '6', NULL, '14', 1, '2025-06-03 19:37:28', '2025-06-10 19:16:38', 'Eye Glasses', NULL, '145', '20', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '47', NULL, '145'),
(91, 'HUDSON 52S', 'ANSI Z87+ HIGH IMPACT', '17495830175Xl8dPCqPJ.png', 'Express your individuality by owning a pair of Etnia Barcelona Sunglasses. They are smooth, functional, and fashionable.\r\nCreated by combining fashion sense and adventurous artistry, these Hudson Sun sunglasses offer astonishing designs that are complemented by superb functionality. They are crafted from high-quality Metal to provide strength and comfort.\r\nThe non-slip temples and nose pads will prevent these Etnia Sunglasses from wobbling while the optical hinges will provide a nice fit.\r\nThe Mineral of these Square sunglasses are also strong. They can provide you superior protection against the cancerous UV rays.\r\nBuy from SmartBuyGlasses and you\'ll be entitled to a 24-month warranty and 100-day returns. We also offer the Etnia Eyewear’s best price.', 4, 'Male', '4', '10', '7', '4', NULL, '18', 1, '2025-06-03 19:47:01', '2025-06-10 19:16:57', 'Sun Glasses', NULL, '145', '17', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '52', NULL, '145'),
(92, 'OG220S WITH DUST DAM', 'ANSI Z87+ HIGH IMPACT', '1749584038Nefpj5o1Lq.png', 'Built for demanding environments and precision work, OnGuard Safety Eyewear delivers reliable protection with modern design and comfort. Whether you\'re on the factory floor, in the lab, or on a construction site, OnGuard frames are engineered to meet strict ANSI Z87.1 and OSHA safety standards—ensuring your vision stays protected in hazardous conditions.', 4, 'Male', '4', '4', '5', '4', NULL, '23', 1, '2025-06-03 19:50:27', '2025-06-10 19:33:58', 'Eye Glasses', NULL, '15', '15', 'Lightweight,Flexible,UV Protection,Anti-Reflective', 'yes', NULL, NULL, '58', NULL, '135'),
(93, 'OG220FS Full Seal', 'ANSI Z87+ HIGH IMPACT', '1749584077Q0TiR1fdVW.png', 'Built for demanding environments and precision work, OnGuard Safety Eyewear delivers reliable protection with modern design and comfort. Whether you\'re on the factory floor, in the lab, or on a construction site, OnGuard frames are engineered to meet strict ANSI Z87.1 and OSHA safety standards—ensuring your vision stays protected in hazardous conditions.', 4, 'Male', '4', '4', '5', '4', NULL, '23', 1, '2025-06-03 19:52:43', '2025-06-10 19:34:37', 'Sun Glasses', NULL, '135', '15', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '58', NULL, '135'),
(94, 'OG613', 'ANSI Z87+ HIGH IMPACT', '1749584105HPfNEwPkQ6.png', 'Built for demanding environments and precision work, OnGuard Safety Eyewear delivers reliable protection with modern design and comfort. Whether you\'re on the factory floor, in the lab, or on a construction site, OnGuard frames are engineered to meet strict ANSI Z87.1 and OSHA safety standards—ensuring your vision stays protected in hazardous conditions.', 4, 'Male', '4', '4', '5', '4', NULL, '23', 1, '2025-06-03 19:54:48', '2025-06-10 19:35:05', 'Eye Glasses', NULL, '135', '16', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '54', NULL, '135'),
(95, 'OG616', 'ANSI Z87+ HIGH IMPACT', '1749584126afdqfZYjrT.png', 'Built for demanding environments and precision work, OnGuard Safety Eyewear delivers reliable protection with modern design and comfort. Whether you\'re on the factory floor, in the lab, or on a construction site, OnGuard frames are engineered to meet strict ANSI Z87.1 and OSHA safety standards—ensuring your vision stays protected in hazardous conditions.', 4, 'Unisex', '4', '4', '5', '4', NULL, '23', 1, '2025-06-03 19:57:28', '2025-06-10 19:35:26', 'Eye Glasses', NULL, '135', '18', 'Adjustable Nose Pads,Lightweight,Anti-Reflective,Flexible,UV Protection', 'yes', NULL, NULL, '54', NULL, '135'),
(96, 'OG255S', 'ANSI Z87+ HIGH IMPACT', '1749584151bhqceh4qvN.png', 'Built for demanding environments and precision work, OnGuard Safety Eyewear delivers reliable protection with modern design and comfort. Whether you\'re on the factory floor, in the lab, or on a construction site, OnGuard frames are engineered to meet strict ANSI Z87.1 and OSHA safety standards—ensuring your vision stays protected in hazardous conditions.', 4, 'Unisex', '4', '4', '5', '4', NULL, '23', 1, '2025-06-03 19:59:06', '2025-06-10 19:35:51', 'Eye Glasses', NULL, '145', '15', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '59', NULL, '145'),
(97, 'US110S', 'ANSI Z87+ HIGH IMPACT', '17495841743OMDQCwJfY.png', 'Built for demanding environments and precision work, OnGuard Safety Eyewear delivers reliable protection with modern design and comfort. Whether you\'re on the factory floor, in the lab, or on a construction site, OnGuard frames are engineered to meet strict ANSI Z87.1 and OSHA safety standards—ensuring your vision stays protected in hazardous conditions.', 4, 'Unisex', '4', '4', '5', '4', NULL, '23', 1, '2025-06-03 20:00:36', '2025-06-10 19:36:14', 'Eye Glasses', NULL, '135', '17', 'Spring Hinges,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '59', NULL, '135'),
(98, 'CAT Track', 'ANSI Z87+ HIGH IMPACT', '1749584198vE1I52pQyL.png', 'Built for demanding environments and precision work, OnGuard Safety Eyewear delivers reliable protection with modern design and comfort. Whether you\'re on the factory floor, in the lab, or on a construction site, OnGuard frames are engineered to meet strict ANSI Z87.1 and OSHA safety standards—ensuring your vision stays protected in hazardous conditions.', 4, 'Unisex', '4', '4', '5', '4', NULL, '23', 1, '2025-06-03 20:02:11', '2025-06-10 19:36:38', 'Eye Glasses', NULL, '0', '0', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '0', '0', '0'),
(99, 'OG 160', 'ANSI Z87+ HIGH IMPACT', '1749584617KnPZ0UvDuF.png', 'Known for quality, versatility, and innovation, Hilco Eyewear offers a comprehensive range of frames designed to meet the needs of professionals and everyday wearers alike. Whether you\'re looking for safety eyewear, sports frames, or optical accessories, Hilco delivers dependable solutions backed by decades of industry expertise.\r\n\r\nCrafted with durable materials and ergonomic designs, Hilco frames provide a secure, comfortable fit and are often prescription-ready, making them ideal for both workplace and lifestyle use. With options that meet ANSI Z87.1 safety standards, Hilco balances protection, performance, and style—offering reliable vision solutions for diverse environments.', 4, 'Male', '4', '4', '5', '4', NULL, '24', 1, '2025-06-03 20:04:14', '2025-06-10 19:43:37', 'Eye Glasses', NULL, '135', '15', 'Spring Hinges,Lightweight,Anti-Reflective,Flexible,UV Protection', 'yes', NULL, NULL, '60', '0', '135'),
(100, 'Guardian', 'ANSI Z87+ HIGH IMPACT', '1749584848tAxfJhjx6W.png', 'When safety and clarity matter most, SafeVision delivers. Specializing in prescription safety eyewear, SafeVision combines high-impact protection with optical precision—trusted by professionals in industrial, healthcare, and laboratory settings worldwide.\r\n\r\nDesigned to meet or exceed ANSI Z87.1 and other workplace safety standards, SafeVision frames are crafted from durable materials and engineered for long-lasting comfort. With a wide selection of styles—from classic wraparounds to contemporary designs—SafeVision ensures a secure fit and a professional look, without compromising on safety or visual performance.', 4, 'Unisex', '4', '4', '5', '4', NULL, '22', 1, '2025-06-03 20:06:45', '2025-06-10 19:47:28', 'Eye Glasses', NULL, '118', '17', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '58', '0', '118'),
(101, 'AVANT GUARDIAN', 'ANSI Z87+ HIGH IMPACT', '1749584869ushGWmUEOV.png', 'Born at the intersection of fashion, function, and rebellion, VonZipper eyewear is made for those who live life loud and unapologetically. With a focus on individuality and expression, VonZipper frames blend bold designs with premium craftsmanship, delivering eyewear that stands out in every crowd.\r\n\r\nWhether you’re chasing waves, hitting the road, or just making a statement, VonZipper offers a wide range of sunglasses and optical frames built with high-quality materials, polarized lens options, and all-day comfort. From classic silhouettes to edgy new looks, VonZipper is your go-to for style that speaks volumes.', 4, 'Male', '4', '4', '5', '4', NULL, '21', 1, '2025-06-03 20:08:24', '2025-06-10 19:47:49', 'Eye Glasses', NULL, '0', '0', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '0', '0', '135'),
(102, 'THE GUARDIAN', 'ANSI Z87+ HIGH IMPACT', '1749584927JTLvIfgK5P.png', 'Gumption eyewear is designed for those who approach life with confidence, courage, and a bold sense of style. Built with durability and everyday performance in mind, Gumption frames offer a sleek, modern look without compromising on comfort or functionality.\r\n\r\nCrafted from quality materials and available in a variety of shapes and finishes, Gumption eyewear is perfect for both casual and professional settings. With prescription-ready options, lightweight construction, and a secure fit, these frames deliver all-day wearability for people who move with intention.', 4, 'Male', '4', '4', '5', '4', NULL, '20', 1, '2025-06-03 20:10:48', '2025-06-10 19:48:47', 'Eye Glasses', NULL, '145', '17', 'Spring Hinges,Adjustable Nose Pads,Lightweight,Flexible', 'yes', NULL, NULL, '54', '0', '145'),
(103, 'HUDSON FT0997-H', 'ANSI Z87+ HIGH IMPACT', '1749584951iESXb3Rz6U.png', 'Bold, luxurious, and unmistakably stylish, Tom Ford Eyewear embodies modern sophistication with a timeless edge. Crafted with meticulous attention to detail, each frame reflects the designer’s signature blend of classic elegance and contemporary flair, making them a favorite among fashion-forward individuals around the globe.\r\n\r\nFrom sleek optical frames to iconic sunglasses, Tom Ford offers a range of premium eyewear made with high-quality materials, superior craftsmanship, and unmistakable design elements—like the signature T-shaped temple detail. Whether you\'re dressing for the boardroom or the red carpet, Tom Ford frames elevate any look with effortless refinement.', 4, 'Male', '4', '4', '5', '4', NULL, '19', 1, '2025-06-03 20:14:10', '2025-06-10 19:49:11', 'Sun Glasses', NULL, '145', '44', 'Spring Hinges,Lightweight,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '55', '0', '145'),
(104, 'HUDSON YARDS', 'ANSI Z87+ HIGH IMPACT', '1749584968coqCKag9EF.png', 'SOCOJO eyewear blends everyday functionality with contemporary style, offering frames that are both comfortable and versatile. Designed for individuals who appreciate clean aesthetics and reliable performance, SOCOJO frames are crafted with lightweight materials, durable construction, and a focus on all-day wearability.\r\n\r\nWhether you\'re in the office, on the go, or enjoying your downtime, SOCOJO delivers prescription-ready eyewear that fits seamlessly into your lifestyle. With a variety of modern shapes and finishes, SOCOJO offers a confident, understated look that doesn’t compromise on quality or comfort.', 4, 'Unisex', '4', '4', '5', '4', NULL, '17', 1, '2025-06-03 20:16:00', '2025-06-10 19:49:28', 'Eye Glasses', NULL, '150', '21', 'Adjustable Nose Pads,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '55', '0', '150'),
(105, 'Hudson', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '17495849825bvvrXyzRm.png', 'AO Eyewear has set premium eyewear standards by combining classic American craftsmanship with cutting-edge technology. Known worldwide for durability and timeless design, AO frames have been trusted by military personnel, aviators, and style icons alike.\r\n\r\nCrafted with precision and built to last, AO Eyewear offers exceptional optical clarity, superior comfort, and rugged reliability. From the iconic Original Pilot sunglasses to versatile optical frames, AO delivers eyewear that performs in the toughest conditions while maintaining a sleek, sophisticated look.', 4, 'Male', '4', '4', '5', '4', NULL, '16', 1, '2025-06-03 20:17:40', '2025-06-10 19:49:42', 'Sun Glasses', NULL, '145', '19', 'Spring Hinges', 'yes', NULL, NULL, '57', '0', '145'),
(106, 'Hudson', 'ANSI Z87+ HIGH IMPACT', '17495849994PWrBmLpk4.png', 'AO Eyewear has set the standard for premium eyewear by combining classic American craftsmanship with cutting-edge technology. Known worldwide for durability and timeless design, AO frames have been trusted by military personnel, aviators, and style icons alike.\r\n\r\nCrafted with precision and built to last, AO Eyewear offers exceptional optical clarity, superior comfort, and rugged reliability. From the iconic Original Pilot sunglasses to versatile optical frames, AO delivers eyewear that performs in the toughest conditions while maintaining a sleek, sophisticated look.', 4, 'Male', '4', '4', '5', '4', NULL, '16', 1, '2025-06-03 21:31:40', '2025-06-10 19:49:59', 'Sun Glasses', NULL, '145', '19', 'Spring Hinges,Lightweight,Anti-Reflective,Flexible', 'yes', NULL, NULL, '57', '0', '145'),
(107, 'VL5', 'ANSI Z87+ HIGH IMPACT', '1749585012RTNkdV2FRQ.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 21:43:29', '2025-06-10 19:50:12', 'Eye Glasses', NULL, '150', '16', 'Spring Hinges,Lightweight,UV Protection', 'yes', NULL, NULL, '54', '0', '150'),
(108, 'HD81', 'ANSI Z87+ HIGH IMPACT', '1749585033LjEyRGERiX.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 21:45:10', '2025-06-10 19:50:33', 'Eye Glasses', NULL, '145', '16', 'Spring Hinges,Adjustable Nose Pads', 'yes', NULL, NULL, '61', '0', '145'),
(109, 'DG92', 'ANSI Z87+ HIGH IMPACT', '1749585047St6kDP6WPF.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 21:47:16', '2025-06-10 19:50:47', 'Eye Glasses', NULL, '145', '18', 'Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '49', '0', '145'),
(110, 'DG94', 'ANSI Z87+ HIGH IMPACT', '1749585062w1wccLZycj.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:00:07', '2025-06-10 19:51:02', 'Eye Glasses', NULL, '150', '18', 'Spring Hinges,Anti-Reflective,Flexible', 'yes', NULL, NULL, '53', '0', '150'),
(111, 'DGXL1', 'ANSI Z87+ HIGH IMPACT', '1749585076Xo9CXauu1m.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:01:42', '2025-06-10 19:51:16', 'Eye Glasses', NULL, '155', '18', 'Spring Hinges', 'yes', NULL, NULL, '57', '0', '155'),
(112, 'DGXL2', 'ANSI Z87+ HIGH IMPACT', '1749585090KH6flHlelB.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:04:07', '2025-06-10 19:51:30', 'Eye Glasses', NULL, '155', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '57', '0', '155'),
(113, 'DGXL3', 'ANSI Z87+ HIGH IMPACT', '1749585105r3TcXmmt8v.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:06:29', '2025-06-10 19:51:45', 'Eye Glasses', NULL, '155', '18', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '58', '0', '155'),
(114, 'VL8', 'ANSI Z87+ HIGH IMPACT', '1749585121E2ks1ycJmu.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:08:42', '2025-06-10 19:52:01', 'Eye Glasses', NULL, '145', '18', 'Spring Hinges,Adjustable Nose Pads,Flexible', 'yes', NULL, NULL, '49', '0', '145'),
(115, 'SL4', 'ANSI Z87+ HIGH IMPACT', '1749590423t77y3ar5O5.png', 'NA', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:11:26', '2025-06-10 21:20:23', 'Eye Glasses', NULL, '145', '18', 'Spring Hinges,Adjustable Nose Pads,Lightweight', 'yes', NULL, NULL, '50', '0', '145'),
(116, 'SL5', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749586362hgIGu54gHM.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Female', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:13:36', '2025-06-10 20:12:42', 'Eye Glasses', NULL, '145', '16', 'Spring Hinges,Lightweight,Anti-Reflective', 'yes', NULL, NULL, '50', '0', '145'),
(117, 'SL6', 'ANSI Z87+ HIGH IMPACT', '1749586390xdxgS9htQT.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '5', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:16:05', '2025-06-10 20:13:10', 'Eye Glasses', NULL, '145', '17', 'Spring Hinges,Adjustable Nose Pads,Lightweight', 'yes', NULL, NULL, '53', '0', '145'),
(118, 'EL4', 'ANSI Z87+ HIGH IMPACT', '1749586419qc20CYpx9G.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:37:47', '2025-06-10 20:13:39', 'Eye Glasses', NULL, '150', '70', 'Spring Hinges,Lightweight', 'yes', NULL, NULL, '56', '0', '150'),
(119, 'EL5', 'ANSI Z87+ HIGH IMPACT', '1749586438r3ECmTGN8W.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Female', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:40:00', '2025-06-10 20:14:09', 'Eye Glasses', NULL, '150', '17', 'Spring Hinges,Adjustable Nose Pads,Lightweight', 'yes', NULL, NULL, '50', '0', '150'),
(120, 'H1', 'ANSI Z87+ HIGH IMPACT', '1749586476tA7WQCOFpg.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Unisex', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:42:34', '2025-06-10 20:14:36', 'Eye Glasses', NULL, '130', '20', 'Spring Hinges,Lightweight', 'yes', NULL, NULL, '56', '0', '130'),
(121, 'DGXL4', 'ANSI Z87+ HIGH IMPACT', '1749586496zhY2rnWS9r.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:45:11', '2025-06-10 20:14:56', 'Eye Glasses', NULL, '150', '17', 'Spring Hinges,Anti-Reflective', 'yes', NULL, NULL, '58', '0', '150'),
(122, 'H3', 'ANSI Z87+ HIGH IMPACT', '1749586522eBaIyxZDBx.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:47:49', '2025-06-10 20:15:22', 'Eye Glasses', NULL, '138', '17', 'Lightweight,UV Protection,Anti-Reflective,Flexible', 'yes', NULL, NULL, '56', '0', '138'),
(123, 'H3P', 'ANSI Z87+ HIGH IMPACT', '1749586543aZg1CFigdj.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Unisex', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:52:57', '2025-06-10 20:15:43', 'Eye Glasses', NULL, '138', '17', 'Lightweight,Flexible,UV Protection', 'yes', NULL, NULL, '56', '0', '138'),
(124, 'DG100', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749586571UUCXLZ76Mk.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Unisex', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:56:36', '2025-06-10 20:16:11', 'Eye Glasses', NULL, '148', '17', 'Spring Hinges,Adjustable Nose Pads,Lightweight', 'yes', NULL, NULL, '54', '0', '148'),
(125, 'THXL8', 'ANSI Z87+ HIGH IMPACT', '1749586592YHk9y6IFRX.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-03 23:58:50', '2025-06-10 20:16:32', 'Eye Glasses', NULL, '148', '17', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '57', '0', '148'),
(126, 'H4', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749586609lZEnQeacZL.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Unisex', '4', '4', '6', '4', NULL, '14', 1, '2025-06-04 00:01:12', '2025-06-10 20:16:49', 'Eye Glasses', NULL, '120', '17', 'Lightweight,Flexible,UV Protection', 'yes', NULL, NULL, '62', '0', '120'),
(127, 'DG101', 'ANSI Z87+ HIGH IMPACT', '1749586634keR2AjmZrp.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Female', '4', '4', '5', '4', NULL, '14', 1, '2025-06-04 00:04:01', '2025-06-10 20:17:14', 'Eye Glasses', NULL, '155', '16', 'Spring Hinges,Adjustable Nose Pads,Lightweight', 'yes', NULL, NULL, '52', '0', '155'),
(128, 'DG102', 'ANSI Z87+ HIGH IMPACT', '1749586653yF8lOsi9eg.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Female', '4', '4', '5', '4', NULL, '14', 1, '2025-06-04 00:07:29', '2025-06-10 20:17:33', 'Eye Glasses', NULL, '145', '16', 'Adjustable Nose Pads,Flexible', 'yes', NULL, NULL, '51', '0', '145'),
(129, 'DG105', 'ANSI Z87+ HIGH IMPACT', '1749586676EmRVdhZnTr.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Unisex', '4', '4', '5', '4', NULL, '14', 1, '2025-06-04 00:10:38', '2025-06-10 20:17:56', 'Eye Glasses', NULL, '145', '15', 'Adjustable Nose Pads,Lightweight,Flexible', 'yes', NULL, NULL, '54', '0', '145'),
(130, 'DG106', 'ANSI Z87+ HIGH IMPACT', '1749586698PmLYeceoZc.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Female', '4', '4', '5', '4', NULL, '14', 1, '2025-06-04 00:13:39', '2025-06-10 20:18:18', 'Eye Glasses', NULL, '152', '15', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '52', '0', '152'),
(131, 'DG107', 'ANSI Z87+ HIGH IMPACT', '1749586720euV3OEXcuH.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-04 00:16:28', '2025-06-10 20:18:40', 'Eye Glasses', NULL, '145', '17', 'Spring Hinges,Adjustable Nose Pads,Lightweight', 'yes', NULL, NULL, '55', '0', '145'),
(132, 'DG108', 'ANSI Z87+ HIGH IMPACT', '1749586742WF0K3OqBrJ.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.NA', 4, 'Unisex', '4', '4', '5', '4', NULL, '14', 1, '2025-06-04 00:19:21', '2025-06-10 20:19:02', 'Eye Glasses', NULL, '145', '18', 'Lightweight,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '53', '0', '145'),
(133, 'Beta', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587080AIRlgpoojf.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '6', '4', NULL, '25', 1, '2025-06-04 00:23:31', '2025-06-10 20:25:34', 'Eye Glasses', NULL, '140', '18', 'Spring Hinges,Adjustable Nose Pads,Lightweight', 'yes', NULL, NULL, '56', '0', '140'),
(134, 'H5', 'ANSI Z87+ HIGH IMPACT', '1749586760voslQZDYwV.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '5', '4', NULL, '14', 1, '2025-06-04 16:02:53', '2025-06-10 20:19:20', 'Eye Glasses', NULL, '0', '0', 'Spring Hinges,Adjustable Nose Pads,Flexible', 'yes', NULL, NULL, '0', '0', NULL);
INSERT INTO `products` (`product_id`, `product_name`, `product_tags`, `featured_image`, `description`, `sub_category`, `gender`, `rim_type`, `style`, `material`, `shape`, `eye_size`, `manufacturer_name`, `product_status`, `created_at`, `updated_at`, `glasses_type`, `lens_size`, `temple_size`, `bridge_size`, `frame_features`, `prescriptions_available`, `upc`, `sku`, `lens_width`, `lens_height`, `frame_width`) VALUES
(135, 'H7', 'ANSI Z87+ HIGH IMPACT', '17495867828yeElDFuQb.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Male', '4', '4', '6', '4', NULL, '14', 1, '2025-06-04 16:06:38', '2025-06-10 20:19:42', 'Eye Glasses', NULL, '120', '17', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '62', '0', '120'),
(136, 'H6P', 'ANSI Z87+ HIGH IMPACT', '1749586798UKWvLtCbHf.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Unisex', '4', '10', '6', '4', NULL, '14', 1, '2025-06-04 16:13:52', '2025-06-10 20:19:58', 'Eye Glasses', NULL, '135', '18', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '32', '0', '135'),
(137, 'VL10', 'ANSI Z87+ HIGH IMPACT', '1749586829RBRLfXraOZ.png', 'Hudson Optical delivers expertly crafted eyewear designed to offer both comfort and sophistication. With a focus on quality materials and meticulous construction, Hudson Optical frames provide a perfect fit and lasting durability, ideal for everyday wear.\r\n\r\nWhether you’re looking for stylish prescription frames or fashionable sunglasses, Hudson Optical combines timeless design with contemporary trends to suit a variety of tastes and lifestyles. Lightweight and comfortable, these frames ensure clear vision and confident style wherever you go.', 4, 'Unisex', '4', '4', '5', '4', NULL, '14', 1, '2025-06-04 16:16:12', '2025-06-10 20:20:29', 'Eye Glasses', NULL, '148', '17', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '52', '0', '148'),
(138, 'ZT100', 'ANSI Z87+ HIGH IMPACT', '1749587126c2ItX3ZQxj.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.NA', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 16:31:15', '2025-06-10 20:25:26', 'Eye Glasses', NULL, '140', '15', 'Spring Hinges,Adjustable Nose Pads,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '53', '0', '140'),
(139, 'ZT400', 'ANSI Z87+ HIGH IMPACT', '1749587154D4emIdoLYR.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 16:44:48', '2025-06-10 20:25:54', 'Eye Glasses', NULL, '133', '15', 'Adjustable Nose Pads,Lightweight,Anti-Reflective', 'yes', NULL, NULL, '57', '0', '133'),
(140, 'DP610', 'ANSI Z87+ HIGH IMPACT', '1749587176ykPWYJ4JZ1.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 16:47:35', '2025-06-10 20:26:16', 'Eye Glasses', NULL, '140', '18', NULL, NULL, NULL, NULL, '54', '0', '140'),
(141, 'DP620', 'ANSI Z87+ HIGH IMPACT', '1749587200NkCE3rnbhu.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Unisex', '4', '4', '6', '4', NULL, '25', 1, '2025-06-04 16:51:01', '2025-06-10 20:26:40', 'Eye Glasses', NULL, '140', '18', 'Adjustable Nose Pads,Lightweight,Flexible', 'yes', NULL, NULL, '51', '0', '140'),
(142, 'DP720', 'ANSI Z87+ HIGH IMPACT', '17495872185v2aRxim9S.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 19:30:39', '2025-06-10 20:26:58', 'Eye Glasses', NULL, '140', '19', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '51', '0', '140'),
(143, 'Steel 400', 'ANSI Z87+ HIGH IMPACT', '1749587237m2gf55wpfu.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 19:33:52', '2025-06-10 20:27:17', 'Eye Glasses', NULL, '140', '17', 'Spring Hinges,Adjustable Nose Pads,Lightweight,Flexible,UV Protection', 'yes', NULL, NULL, '49', '0', '140'),
(144, 'Gamma', 'ANSI Z87+ HIGH IMPACT', '1749587250JGZuiHjteP.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '6', '4', NULL, '25', 1, '2025-06-04 19:37:35', '2025-06-10 20:27:30', 'Eye Glasses', NULL, '140', '18', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '52', '0', '140'),
(145, 'ZT200 Complete', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587264sqoVRpjpVL.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '7', '4', NULL, '25', 1, '2025-06-04 20:04:54', '2025-06-10 20:27:44', 'Eye Glasses', NULL, '126', '20', 'Spring Hinges,Lightweight,Anti-Reflective', 'yes', NULL, NULL, '54', '0', '126'),
(146, 'DP620', 'ANSI Z87+ HIGH IMPACT', '1749587285IJ7BO7DPMI.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '6', '4', NULL, '25', 1, '2025-06-04 20:08:18', '2025-06-10 20:28:05', 'Eye Glasses', NULL, '140', '18', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '51', '0', '140'),
(147, 'RAVN', 'ANSI Z87+ HIGH IMPACT', '1749587302bQPCVheqfY.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '10', '5', '4', NULL, '25', 1, '2025-06-04 20:11:11', '2025-06-10 20:28:22', 'Eye Glasses', NULL, '125', '17', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '55', '0', '126'),
(148, 'ZT45', 'ANSI Z87+ HIGH IMPACT', '1749587317uPczrfNzUn.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 20:14:23', '2025-06-10 20:28:37', 'Eye Glasses', NULL, '130', '13', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '54', '0', '130'),
(149, 'DP820', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587335uNwWr3gZkO.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 20:18:51', '2025-06-10 20:28:55', 'Eye Glasses', NULL, '140', '19', 'Spring Hinges,Adjustable Nose Pads,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '52', '0', '140'),
(150, 'Classic 1', 'ANSI Z87+ HIGH IMPACT', '174958734789KPfJZRLj.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '6', '4', NULL, '25', 1, '2025-06-04 20:24:05', '2025-06-10 20:29:07', 'Eye Glasses', NULL, '130', '15', 'Spring Hinges,Adjustable Nose Pads,Flexible', 'yes', NULL, NULL, '50', '0', '130'),
(151, 'ZT500', 'ANSI Z87+ HIGH IMPACT', '1749587361w6YtvIlvLa.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:17:18', '2025-06-10 20:29:21', 'Eye Glasses', NULL, '131', '18', 'Spring Hinges,Lightweight,Anti-Reflective', 'yes', NULL, NULL, '58', '0', '131'),
(152, 'Attitude 7', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587375mmv88LkLgm.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:22:38', '2025-06-10 20:29:35', 'Eye Glasses', NULL, '140', '17', 'Spring Hinges,Adjustable Nose Pads,Flexible,Anti-Reflective', 'yes', NULL, NULL, '55', '0', '140'),
(153, 'TRX', 'ANSI Z87+ HIGH IMPACT', '1749587389aEXPkefDvs.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:25:04', '2025-06-10 20:29:49', 'Eye Glasses', NULL, '135', '17', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '57', '0', '135'),
(154, 'Classic 10', 'ANSI Z87+ HIGH IMPACT,CSA Z94.3,EN166', '1749587404pqftkUIn7h.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Female', '4', '4', '6', '4', NULL, '25', 1, '2025-06-04 21:27:55', '2025-06-10 20:30:04', 'Eye Glasses', NULL, '140', '60', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '52', '0', '140'),
(155, 'Classic 11', 'ANSI Z87+ HIGH IMPACT', '1749587417uMo1fhoEcY.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Female', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:31:10', '2025-06-10 20:30:17', 'Eye Glasses', NULL, '140', '16', 'Lightweight,Flexible', 'yes', NULL, NULL, '54', '0', '140'),
(156, 'Classic 12', 'ANSI Z87+ HIGH IMPACT', '1749587429orX3hiRAwV.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Female', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:33:19', '2025-06-10 20:30:29', 'Eye Glasses', NULL, '135', '17', 'Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '53', '0', '135'),
(157, 'Attitude 6', 'ANSI Z87+ HIGH IMPACT', '1749587442Ltz5adrJuK.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:35:37', '2025-06-10 20:30:42', 'Eye Glasses', NULL, '130', '14', 'Spring Hinges,Adjustable Nose Pads,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '48', '0', '130'),
(158, 'Attitude 5', 'ANSI Z87+ HIGH IMPACT', '1749587456peq8VmzUxO.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:37:40', '2025-06-10 20:30:56', 'Eye Glasses', NULL, '140', '18', 'Spring Hinges,Lightweight,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '54', '0', '140'),
(159, 'Classic 3', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587469EJ0euy7xZa.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:40:19', '2025-06-10 20:31:09', 'Eye Glasses', NULL, '145', '18', 'Spring Hinges,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '53', '0', '145'),
(160, 'Classic 4', 'ANSI Z87+ HIGH IMPACT', '1749587483KU6Uy9V53M.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:43:38', '2025-06-10 20:31:23', 'Eye Glasses', NULL, '140', '19', 'Spring Hinges,Lightweight,Flexible,UV Protection', 'yes', NULL, NULL, '52', '0', '140'),
(161, 'Attitude 4', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '17495875190dYzZQR9Qq.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:45:37', '2025-06-10 20:31:59', 'Eye Glasses', NULL, '135', '18', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '53', '0', '135'),
(162, 'Attitude 3', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587533e56UcuWUn8.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:47:55', '2025-06-10 20:32:13', 'Eye Glasses', NULL, '140', '18', 'Flexible,Anti-Reflective,Scratch Resistant,UV Protection', 'yes', NULL, NULL, '54', '0', '140'),
(164, 'F9800', 'CSA Z94.3,ANSI Z87+ HIGH IMPACT', '1749587549HnO4zkgolj.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:53:09', '2025-06-10 20:32:29', 'Eye Glasses', NULL, '145', '20', 'Spring Hinges,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '46', '0', '145'),
(165, 'F9900', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587563ZDuu3ZtDsu.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:54:54', '2025-06-10 20:32:43', 'Eye Glasses', NULL, '147', '20', 'Spring Hinges,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '50', '0', '147'),
(166, 'DX670', 'ANSI Z87+ HIGH IMPACT', '17495875779dcDQbfK1u.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 21:58:15', '2025-06-10 20:32:57', 'Eye Glasses', NULL, '135', '19', 'Spring Hinges,Lightweight,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '50', '0', '135'),
(167, 'D490', 'ANSI Z87+ HIGH IMPACT', '1749587601kXhaNdAdnr.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 22:00:30', '2025-06-10 20:33:21', 'Eye Glasses', NULL, '140', '16', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '54', '0', '140'),
(168, 'Alpha', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587616T8YmI059fj.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyleMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Female', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 23:53:49', '2025-06-10 20:33:36', 'Eye Glasses', NULL, '130', '20', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '49', '0', '130'),
(169, 'ZT55', 'ANSI Z87+ HIGH IMPACT', '1749587654tXLYxThnCq.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 23:57:43', '2025-06-10 20:34:14', 'Eye Glasses', NULL, '130', '18', 'Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '56', '0', '130'),
(170, 'A2500', 'ANSI Z87+ HIGH IMPACT', '1749587668pQO1yREIEx.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-04 23:59:30', '2025-06-10 20:34:28', 'Eye Glasses', NULL, '131', '19', 'Spring Hinges,Lightweight,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '55', '0', '131'),
(171, 'V1000 8 Base', 'ANSI Z87+ HIGH IMPACT', '17495876817Eb4IESAtD.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:21:06', '2025-06-10 20:34:41', 'Eye Glasses', NULL, '130', '16', 'Spring Hinges,Lightweight,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '61', '0', '130'),
(172, 'F6000', 'ANSI Z87+ HIGH IMPACT', '1749587695od3vjwTChn.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:26:06', '2025-06-10 20:34:55', 'Eye Glasses', NULL, '140', '13', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective', 'yes', NULL, NULL, '50', '0', '140'),
(173, '650', 'ANSI Z87+ HIGH IMPACT', '1749587713wD6KxSN1yO.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Female', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:29:28', '2025-06-10 20:35:13', 'Eye Glasses', NULL, '140', '16', 'Adjustable Nose Pads,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '48', '0', '140'),
(174, 'Eagle', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587728sVSO7gcn3a.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:31:37', '2025-06-10 20:35:28', 'Eye Glasses', NULL, '138', '13', 'Spring Hinges,Lightweight,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '59', '0', '138'),
(175, 'Urban 6', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587741lQvyEts9TX.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:33:43', '2025-06-10 20:35:41', 'Eye Glasses', NULL, '140', '16', 'Spring Hinges,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '57', '0', '140'),
(176, 'Urban 8', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587755lIRAkxQ77g.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:35:44', '2025-06-10 20:35:55', 'Eye Glasses', NULL, '140', '18', 'Spring Hinges,Lightweight,Flexible,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '55', '0', '140'),
(177, 'A2000', 'ANSI Z87+ HIGH IMPACT', '174958779794SGWdeCiK.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:37:20', '2025-06-10 20:36:37', 'Eye Glasses', NULL, '114', '16', 'Spring Hinges,Flexible,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '58', '0', '114'),
(178, 'ZT35', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587813d84Cxdzfoj.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:40:45', '2025-06-10 20:36:53', 'Eye Glasses', NULL, '125', '20', 'Spring Hinges,Lightweight', 'yes', NULL, NULL, '57', '0', '125'),
(179, 'Rebel', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749587844WVk17Lz8zS.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:43:15', '2025-06-10 20:37:24', 'Eye Glasses', NULL, '135', '18', 'Lightweight,Flexible,UV Protection,Anti-Reflective', 'yes', NULL, NULL, '56', '0', '135'),
(180, 'DP600', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '17495878587bh9yEHTzG.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:45:27', '2025-06-10 20:37:38', 'Eye Glasses', NULL, '140', '18', 'Spring Hinges,Flexible,UV Protection,Scratch Resistant,Anti-Reflective', 'yes', NULL, NULL, '52', '0', '140'),
(181, 'ZT500G', 'HIGH RX,ANSI Z87+ HIGH IMPACT', '1749585899Ww5Tb6oTG8.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:47:28', '2025-06-10 20:04:59', 'Eye Glasses', NULL, '131', '18', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '58', '0', '131'),
(182, 'ZT200', 'ANSI Z87+ HIGH IMPACT', '1749587880926celpb6P.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:49:26', '2025-06-10 20:38:00', 'Eye Glasses', NULL, '126', '20', 'Spring Hinges,Lightweight,Anti-Reflective,UV Protection,Scratch Resistant', 'yes', NULL, NULL, '54', '-2', '126'),
(183, 'ZT25 6 Base', 'ANSI Z87+ HIGH IMPACT', '1749587892uI9ANDvDKf.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:52:45', '2025-06-10 20:38:12', 'Eye Glasses', NULL, '127', '19', 'Spring Hinges', 'yes', NULL, NULL, '56', '0', '127'),
(184, 'ZT25 8 Base', 'ANSI Z87+ HIGH IMPACT', '1749587907OqfxJjdvmR.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:55:40', '2025-06-10 20:38:27', 'Eye Glasses', NULL, '127', '19', 'Spring Hinges,Lightweight,Flexible,Anti-Reflective,UV Protection', 'yes', NULL, NULL, '61', '0', '127'),
(185, 'Maxim Air Seal Rx', 'ANSI Z87+ HIGH IMPACT', '1749587920C1TfF5XsBD.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', 4, 'Male', '4', '4', '5', '4', NULL, '25', 1, '2025-06-05 12:57:45', '2025-06-10 20:38:40', 'Eye Glasses', NULL, '140', '26', 'Spring Hinges,Lightweight,Flexible,UV Protection', 'yes', NULL, NULL, '53', '0', '140'),
(186, 'V1000-6', 'ANSI Z87+ HIGH IMPACT', '1749721599bSntm4IbMm.png', 'Discover the perfect blend of precision engineering and modern design with Pentax eyeglass frames. Known for their superior quality and durability, Pentax frames are crafted to offer exceptional comfort and a timeless aesthetic. Whether you\'re looking for a professional, casual, or contemporary look, Pentax provides a wide range of styles to match every personality and lifestyle.\r\n\r\nMade with high-quality materials and meticulous attention to detail, Pentax frames are lightweight yet sturdy, ensuring long-lasting wear without compromising on comfort. Trusted by vision care professionals worldwide, Pentax combines innovative technology with elegant design—giving you eyewear that not only enhances your vision but also elevates your style.', NULL, 'Unisex', '4', '4', '5', '4', NULL, '25', 1, '2025-06-12 09:46:39', '2025-06-12 09:46:39', 'Eye Glasses', NULL, '130', '18', 'Spring Hinges,Adjustable Nose Pads', 'yes', NULL, NULL, '52', '0', '130'),
(187, 'W1', 'ANSI Z87+ HIGH IMPACT', '1749721779e73OaGO7s0.png', 'Hudson Optica offers a stylish collection of eyewear that perfectly balances modern design with timeless craftsmanship. Designed for individuals who value both aesthetics and comfort, Hudson Optica frames feature clean lines, quality materials, and durable construction for all-day wear.\r\n\r\nWhether you need prescription glasses or trendy sunglasses, Hudson Optica provides a versatile range of frames suited for everyday lifestyle and professional settings. Lightweight yet sturdy, these frames ensure a secure fit while enhancing your personal style with subtle sophistication.', NULL, 'Unisex', '4', '4', '5', '4', NULL, '14', 1, '2025-06-12 09:49:39', '2025-06-12 09:49:39', 'Eye Glasses', NULL, '123', '18', 'Spring Hinges,Adjustable Nose Pads,Lightweight,Flexible', 'yes', NULL, NULL, '61', '0', '123'),
(188, 'asdsds', 'NON CONDUCTIVE,CSA Z94.3', '1750148672FturHE3KuZ.webp', 'skjdhfkjsdhfkjdshfh', NULL, 'Female', '8', '10', '8', '7', NULL, '16', 1, '2025-06-17 08:24:32', '2025-06-17 08:24:32', 'Reading Glasses', NULL, '33', '234', 'Scratch Resistant,Anti-Reflective,Lightweight', 'yes', '234555', 'SKU23435', '33', '33', '33');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `category_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `product_id`, `category_id`) VALUES
(2, 10, 4),
(3, 11, 4),
(4, 12, 4),
(5, 13, 4),
(6, 14, 4),
(7, 15, 4),
(8, 16, 4),
(9, 17, 4),
(10, 18, 4),
(11, 19, 4),
(12, 20, 4),
(13, 21, 4),
(14, 22, 4),
(15, 23, 4),
(16, 24, 4),
(17, 25, 4),
(18, 26, 4),
(19, 27, 4),
(20, 28, 4),
(21, 29, 4),
(22, 30, 4),
(23, 31, 4),
(24, 33, 4),
(25, 34, 4),
(26, 35, 4),
(27, 36, 4),
(28, 37, 4),
(29, 38, 4),
(30, 39, 4),
(31, 40, 4),
(32, 42, 4),
(33, 43, 4),
(34, 44, 4),
(35, 45, 4),
(36, 46, 4),
(37, 47, 4),
(38, 48, 4),
(39, 49, 4),
(40, 51, 4),
(41, 52, 4),
(42, 53, 4),
(43, 54, 4),
(44, 55, 4),
(45, 56, 4),
(46, 57, 4),
(47, 58, 4),
(48, 59, 4),
(49, 60, 4),
(50, 61, 4),
(51, 62, 4),
(52, 63, 4),
(53, 64, 4),
(54, 65, 4),
(55, 66, 4),
(56, 67, 4),
(57, 68, 4),
(58, 69, 4),
(59, 70, 4),
(60, 71, 4),
(61, 72, 4),
(62, 73, 4),
(63, 74, 4),
(64, 75, 4),
(65, 76, 4),
(66, 77, 4),
(67, 78, 4),
(68, 79, 4),
(69, 80, 4),
(70, 81, 4),
(71, 82, 4),
(72, 83, 4),
(73, 84, 4),
(74, 85, 4),
(75, 86, 4),
(76, 87, 4),
(77, 88, 4),
(78, 89, 4),
(79, 90, 4),
(80, 91, 4),
(81, 92, 4),
(82, 93, 4),
(83, 94, 4),
(84, 95, 4),
(85, 96, 4),
(86, 97, 4),
(87, 98, 4),
(88, 99, 4),
(89, 100, 4),
(90, 101, 4),
(91, 102, 4),
(92, 103, 4),
(93, 104, 4),
(94, 105, 4),
(95, 106, 4),
(96, 107, 4),
(97, 108, 4),
(98, 109, 4),
(99, 110, 4),
(100, 111, 4),
(101, 112, 4),
(102, 113, 4),
(103, 114, 4),
(104, 115, 4),
(105, 116, 4),
(106, 117, 4),
(107, 118, 4),
(108, 119, 4),
(109, 120, 4),
(110, 121, 4),
(111, 122, 4),
(112, 123, 4),
(113, 124, 4),
(114, 125, 4),
(115, 126, 4),
(116, 127, 4),
(117, 128, 4),
(118, 129, 4),
(119, 130, 4),
(120, 131, 4),
(121, 132, 4),
(122, 133, 4),
(123, 134, 4),
(124, 135, 4),
(125, 136, 4),
(126, 137, 4),
(127, 138, 4),
(128, 139, 4),
(129, 140, 4),
(130, 141, 4),
(131, 142, 4),
(132, 143, 4),
(133, 144, 4),
(134, 145, 4),
(135, 146, 4),
(136, 147, 4),
(137, 148, 4),
(138, 149, 4),
(139, 150, 4),
(140, 151, 4),
(141, 152, 4),
(142, 153, 4),
(143, 154, 4),
(144, 155, 4),
(145, 156, 4),
(146, 157, 4),
(147, 158, 4),
(148, 159, 4),
(149, 160, 4),
(150, 161, 4),
(151, 162, 4),
(152, 164, 4),
(153, 165, 4),
(154, 166, 4),
(155, 167, 4),
(156, 168, 4),
(157, 169, 4),
(158, 170, 4),
(159, 171, 4),
(160, 172, 4),
(161, 173, 4),
(162, 174, 4),
(163, 175, 4),
(164, 176, 4),
(165, 177, 4),
(166, 178, 4),
(167, 179, 4),
(168, 180, 4),
(169, 181, 4),
(170, 182, 4),
(171, 183, 4),
(172, 184, 4),
(173, 185, 4),
(174, 186, 4),
(175, 187, 4),
(176, 188, 4);

-- --------------------------------------------------------

--
-- Table structure for table `product_frame_size`
--

CREATE TABLE `product_frame_size` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `frame_size_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_frame_size`
--

INSERT INTO `product_frame_size` (`id`, `product_id`, `frame_size_id`) VALUES
(3, 10, 5),
(4, 10, 6),
(5, 11, 3),
(6, 11, 4),
(7, 12, 5),
(8, 12, 6),
(9, 13, 3),
(10, 13, 4),
(11, 14, 5),
(12, 14, 6),
(13, 15, 3),
(14, 15, 4),
(15, 16, 5),
(16, 16, 6),
(17, 17, 3),
(18, 17, 4),
(19, 18, 5),
(20, 18, 6),
(21, 19, 3),
(22, 19, 4),
(23, 20, 5),
(24, 20, 6),
(25, 21, 3),
(26, 21, 4),
(27, 22, 5),
(28, 22, 6),
(29, 23, 3),
(30, 23, 4),
(31, 24, 5),
(32, 24, 6),
(33, 25, 3),
(34, 25, 4),
(35, 26, 5),
(36, 26, 6),
(37, 27, 3),
(38, 27, 4),
(39, 28, 5),
(40, 28, 6),
(41, 29, 3),
(42, 29, 4),
(43, 30, 5),
(44, 30, 6),
(45, 31, 3),
(46, 31, 4),
(47, 33, 5),
(48, 33, 6),
(49, 34, 3),
(50, 34, 4),
(51, 35, 5),
(52, 35, 6),
(53, 36, 3),
(54, 36, 4),
(55, 37, 5),
(56, 37, 6),
(57, 38, 3),
(58, 38, 4),
(59, 39, 5),
(60, 39, 6),
(61, 40, 3),
(62, 40, 4),
(63, 42, 5),
(64, 42, 6),
(65, 43, 3),
(66, 43, 4),
(67, 44, 5),
(68, 44, 6),
(69, 45, 3),
(70, 45, 4),
(71, 46, 5),
(72, 46, 6),
(73, 47, 3),
(74, 47, 4),
(75, 48, 5),
(76, 48, 6),
(77, 49, 3),
(78, 49, 4),
(79, 51, 5),
(80, 51, 6),
(81, 52, 3),
(82, 52, 4),
(83, 53, 5),
(84, 53, 6),
(85, 54, 3),
(86, 54, 4),
(87, 55, 5),
(88, 55, 6),
(89, 56, 3),
(90, 56, 4),
(91, 57, 5),
(92, 57, 6),
(93, 58, 3),
(94, 58, 4),
(95, 59, 5),
(96, 59, 6),
(97, 60, 3),
(98, 60, 4),
(99, 61, 5),
(100, 61, 6),
(101, 62, 3),
(102, 62, 4),
(103, 63, 5),
(104, 63, 6),
(105, 64, 3),
(106, 64, 4),
(107, 65, 5),
(108, 65, 6),
(109, 66, 3),
(110, 66, 4),
(111, 67, 5),
(112, 67, 6),
(113, 68, 3),
(114, 68, 4),
(115, 69, 5),
(116, 69, 6),
(117, 70, 3),
(118, 70, 4),
(119, 71, 5),
(120, 71, 6),
(121, 72, 3),
(122, 72, 4),
(123, 73, 5),
(124, 73, 6),
(125, 74, 3),
(126, 74, 4),
(127, 75, 5),
(128, 75, 6),
(129, 76, 3),
(130, 76, 4),
(131, 77, 5),
(132, 77, 6),
(133, 78, 3),
(134, 78, 4),
(135, 79, 5),
(136, 79, 6),
(137, 80, 3),
(138, 80, 4),
(139, 81, 5),
(140, 81, 6),
(141, 82, 3),
(142, 82, 4),
(143, 83, 5),
(144, 83, 6),
(145, 84, 3),
(146, 84, 4),
(147, 85, 5),
(148, 85, 6),
(149, 86, 3),
(150, 86, 4),
(151, 87, 5),
(152, 87, 6),
(153, 88, 3),
(154, 88, 4),
(155, 89, 5),
(156, 89, 6),
(157, 90, 3),
(158, 90, 4),
(159, 91, 5),
(160, 91, 6),
(161, 92, 3),
(162, 92, 4),
(163, 93, 5),
(164, 93, 6),
(165, 94, 3),
(166, 94, 4),
(167, 95, 5),
(168, 95, 6),
(169, 96, 3),
(170, 96, 4),
(171, 97, 5),
(172, 97, 6),
(173, 98, 3),
(174, 98, 4),
(175, 99, 5),
(176, 99, 6),
(177, 100, 3),
(178, 100, 4),
(179, 101, 5),
(180, 101, 6),
(181, 102, 3),
(182, 102, 4),
(183, 103, 5),
(184, 103, 6),
(185, 104, 3),
(186, 104, 4),
(187, 105, 5),
(188, 105, 6),
(189, 106, 3),
(190, 106, 4),
(191, 107, 5),
(192, 107, 6),
(193, 108, 3),
(194, 108, 4),
(195, 109, 5),
(196, 109, 6),
(197, 110, 3),
(198, 110, 4),
(199, 111, 5),
(200, 111, 6),
(201, 112, 3),
(202, 112, 4),
(203, 113, 5),
(204, 113, 6),
(205, 114, 3),
(206, 114, 4),
(207, 115, 5),
(208, 115, 6),
(209, 116, 3),
(210, 116, 4),
(211, 117, 5),
(212, 117, 6),
(213, 118, 3),
(214, 118, 4),
(215, 119, 5),
(216, 119, 6),
(217, 120, 3),
(218, 120, 4),
(219, 121, 5),
(220, 121, 6),
(221, 122, 3),
(222, 122, 4),
(223, 123, 5),
(224, 123, 6),
(225, 124, 3),
(226, 124, 4),
(227, 125, 5),
(228, 125, 6),
(229, 126, 3),
(230, 126, 4),
(231, 127, 5),
(232, 127, 6),
(233, 128, 3),
(234, 128, 4),
(235, 129, 5),
(236, 129, 6),
(237, 130, 3),
(238, 130, 4),
(239, 131, 5),
(240, 131, 6),
(241, 132, 3),
(242, 132, 4),
(243, 133, 5),
(244, 133, 6),
(245, 134, 3),
(246, 134, 4),
(247, 135, 5),
(248, 135, 6),
(249, 136, 3),
(250, 136, 4),
(251, 137, 5),
(252, 137, 6),
(253, 138, 3),
(254, 138, 4),
(255, 139, 5),
(256, 139, 6),
(257, 140, 3),
(258, 140, 4),
(259, 141, 5),
(260, 141, 6),
(261, 142, 3),
(262, 142, 4),
(263, 143, 5),
(264, 143, 6),
(265, 144, 3),
(266, 144, 4),
(267, 145, 5),
(268, 145, 6),
(269, 146, 3),
(270, 146, 4),
(271, 147, 5),
(272, 147, 6),
(273, 148, 3),
(274, 148, 4),
(275, 149, 5),
(276, 149, 6),
(277, 150, 3),
(278, 150, 4),
(279, 151, 5),
(280, 151, 6),
(281, 152, 3),
(282, 152, 4),
(283, 153, 5),
(284, 153, 6),
(285, 154, 3),
(286, 154, 4),
(287, 155, 5),
(288, 155, 6),
(289, 156, 3),
(290, 156, 4),
(291, 157, 5),
(292, 157, 6),
(293, 158, 3),
(294, 158, 4),
(295, 159, 5),
(296, 159, 6),
(297, 160, 3),
(298, 160, 4),
(299, 161, 5),
(300, 161, 6),
(301, 162, 3),
(302, 162, 4),
(303, 164, 5),
(304, 164, 6),
(305, 165, 3),
(306, 165, 4),
(307, 166, 5),
(308, 166, 6),
(309, 167, 3),
(310, 167, 4),
(311, 168, 5),
(312, 168, 6),
(313, 169, 3),
(314, 169, 4),
(315, 170, 5),
(316, 170, 6),
(317, 171, 3),
(318, 171, 4),
(319, 172, 5),
(320, 172, 6),
(321, 173, 3),
(322, 173, 4),
(323, 174, 5),
(324, 174, 6),
(325, 175, 3),
(326, 175, 4),
(327, 176, 5),
(328, 176, 6),
(329, 177, 3),
(330, 177, 4),
(331, 178, 5),
(332, 178, 6),
(333, 179, 3),
(334, 179, 4),
(335, 180, 5),
(336, 180, 6),
(337, 181, 3),
(338, 181, 4),
(339, 182, 5),
(340, 182, 6),
(341, 183, 3),
(342, 183, 4),
(343, 184, 5),
(344, 184, 6),
(345, 185, 3),
(346, 185, 4),
(347, 186, 5),
(348, 186, 6),
(349, 187, 3),
(350, 187, 4),
(351, 188, 5),
(352, 188, 6);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int NOT NULL,
  `variant_id` int DEFAULT NULL,
  `image_path` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `variant_id`, `image_path`, `created_at`, `updated_at`) VALUES
(1, 1, '1748011353RFZVKpCPuh.jpg', '2025-05-23 14:42:33', '2025-05-23 14:42:33'),
(4, 6, '1748269967zlN7hZlBUC.jpg', '2025-05-26 14:32:47', '2025-05-26 14:32:47'),
(5, 6, '1748269967gV5dD5NCOP.jpg', '2025-05-26 14:32:47', '2025-05-26 14:32:47'),
(6, 7, '0009398216741_50.png', '2025-05-26 14:32:47', '2025-05-26 14:32:47'),
(7, 7, '1748269967OVws5yaaQe.jpg', '2025-05-26 14:32:47', '2025-05-26 14:32:47'),
(22, 13, '1748341153nZTv8seuFs.png', '2025-05-27 10:19:13', '2025-05-27 10:19:13'),
(34, 19, '1748558182SWhJe3LvLP.png', '2025-05-29 22:36:22', '2025-05-29 22:36:22'),
(35, 19, '1748558182mAJFFQaFhZ.png', '2025-05-29 22:36:22', '2025-05-29 22:36:22'),
(36, 20, '1748558182DI3zUQ3yYE.png', '2025-05-29 22:36:22', '2025-05-29 22:36:22'),
(37, 20, '1748558182RGlCiHuxn3.png', '2025-05-29 22:36:22', '2025-05-29 22:36:22'),
(38, 21, '1748566647fuexsy8mXo.png', '2025-05-30 00:57:27', '2025-05-30 00:57:27'),
(39, 21, '1748566647oTx3Pe7hKz.png', '2025-05-30 00:57:27', '2025-05-30 00:57:27'),
(40, 22, '1748566647q6HFp0iUG1.png', '2025-05-30 00:57:27', '2025-05-30 00:57:27'),
(41, 22, '17485666475qtiTcNHMI.png', '2025-05-30 00:57:27', '2025-05-30 00:57:27'),
(42, 23, '1748566810ucK7V3QpLE.png', '2025-05-30 01:00:10', '2025-05-30 01:00:10'),
(43, 23, '1748566810TKoP2iudIE.png', '2025-05-30 01:00:10', '2025-05-30 01:00:10'),
(44, 24, '1748566810IRnDL90ZaV.png', '2025-05-30 01:00:10', '2025-05-30 01:00:10'),
(45, 24, '1748566810OeBIosvNIQ.png', '2025-05-30 01:00:10', '2025-05-30 01:00:10'),
(46, 25, '17485670377ZKezVAP7g.png', '2025-05-30 01:03:57', '2025-05-30 01:03:57'),
(47, 25, '1748567037n9aBrR8cyp.png', '2025-05-30 01:03:57', '2025-05-30 01:03:57'),
(48, 26, '1748567134KSIsM9ZoWg.png', '2025-05-30 01:05:34', '2025-05-30 01:05:34'),
(49, 26, '1748567134qOkRkIzSiB.png', '2025-05-30 01:05:34', '2025-05-30 01:05:34'),
(52, 28, '1748649484zD8bgB999J.png', '2025-05-30 23:58:04', '2025-05-30 23:58:04'),
(53, 28, '1748649484iHgTzlsMmB.png', '2025-05-30 23:58:04', '2025-05-30 23:58:04'),
(54, 29, '17486494841qwrRm9tR1.png', '2025-05-30 23:58:04', '2025-05-30 23:58:04'),
(55, 29, '1748649484HStrcRqTnA.png', '2025-05-30 23:58:04', '2025-05-30 23:58:04'),
(56, 30, '17486494843Lh7SWRvtV.png', '2025-05-30 23:58:04', '2025-05-30 23:58:04'),
(57, 30, '1748649484dusIUluqJZ.png', '2025-05-30 23:58:04', '2025-05-30 23:58:04'),
(58, 31, '1748650239Y9QH90kN9B.png', '2025-05-31 00:10:39', '2025-05-31 00:10:39'),
(59, 31, '17486502390wdWbLLUQH.png', '2025-05-31 00:10:39', '2025-05-31 00:10:39'),
(60, 32, '17486502393HKzvWS0yr.png', '2025-05-31 00:10:39', '2025-05-31 00:10:39'),
(61, 33, '1748651610DfQYdFJgU1.png', '2025-05-31 00:33:30', '2025-05-31 00:33:30'),
(62, 33, '1748651610DJsDh3Rx3e.png', '2025-05-31 00:33:30', '2025-05-31 00:33:30'),
(63, 34, '1748651966cPpuq47nWJ.png', '2025-05-31 00:39:26', '2025-05-31 00:39:26'),
(64, 34, '1748651966fmp5Wids6W.png', '2025-05-31 00:39:26', '2025-05-31 00:39:26'),
(65, 35, '1748652213BZzh1pT7Fv.png', '2025-05-31 00:43:33', '2025-05-31 00:43:33'),
(66, 35, '1748652213tE66eKDTZV.png', '2025-05-31 00:43:33', '2025-05-31 00:43:33'),
(67, 36, '1748652305sB8UaTGuW4.png', '2025-05-31 00:45:05', '2025-05-31 00:45:05'),
(68, 36, '1748652305RGLmrW262n.png', '2025-05-31 00:45:05', '2025-05-31 00:45:05'),
(69, 37, '1748652621rLr64g1163.png', '2025-05-31 00:50:21', '2025-05-31 00:50:21'),
(70, 37, '1748652621ZcPdWcxklv.png', '2025-05-31 00:50:21', '2025-05-31 00:50:21'),
(71, 38, '1748652883gy7qqg3HVr.png', '2025-05-31 00:54:43', '2025-05-31 00:54:43'),
(72, 38, '174865288359yQf2JYBR.png', '2025-05-31 00:54:43', '2025-05-31 00:54:43'),
(73, 39, '1748653369XBooO3x8FG.png', '2025-05-31 01:02:49', '2025-05-31 01:02:49'),
(74, 39, '1748653369LQVKX84A82.png', '2025-05-31 01:02:49', '2025-05-31 01:02:49'),
(75, 40, '1748653369KWAIzZh2CI.png', '2025-05-31 01:02:49', '2025-05-31 01:02:49'),
(76, 40, '1748653369yBdoEVf40n.png', '2025-05-31 01:02:49', '2025-05-31 01:02:49'),
(77, 41, '1748653369uOO2BgVZsF.png', '2025-05-31 01:02:49', '2025-05-31 01:02:49'),
(78, 41, '174865336921NzJKNh9A.png', '2025-05-31 01:02:49', '2025-05-31 01:02:49'),
(79, 42, '1748653369Xn99eZyjVu.png', '2025-05-31 01:02:49', '2025-05-31 01:02:49'),
(80, 42, '1748653369ZZ5rCCF3pN.png', '2025-05-31 01:02:49', '2025-05-31 01:02:49'),
(81, 43, '17486538335sVI3caW3j.png', '2025-05-31 01:10:33', '2025-05-31 01:10:33'),
(82, 43, '1748653833Sg05knXpHB.png', '2025-05-31 01:10:33', '2025-05-31 01:10:33'),
(83, 44, '1748653833cf64DgYvap.png', '2025-05-31 01:10:33', '2025-05-31 01:10:33'),
(84, 44, '174865383334lzb300We.png', '2025-05-31 01:10:33', '2025-05-31 01:10:33'),
(85, 45, '1748654041g6JbMJ262F.png', '2025-05-31 01:14:01', '2025-05-31 01:14:01'),
(86, 45, '1748654041e8Atle5DjN.png', '2025-05-31 01:14:01', '2025-05-31 01:14:01'),
(87, 46, '1748654730bwd6EslBKB.png', '2025-05-31 01:25:30', '2025-05-31 01:25:30'),
(88, 46, '1748654730Kzwfm0UMzP.png', '2025-05-31 01:25:30', '2025-05-31 01:25:30'),
(89, 47, '1748805393VO2MF2Bsgz.png', '2025-06-01 19:16:33', '2025-06-01 19:16:33'),
(90, 47, '1748805393yllCP4x1Be.png', '2025-06-01 19:16:33', '2025-06-01 19:16:33'),
(91, 48, '1748805512iC56zbpokp.png', '2025-06-01 19:18:32', '2025-06-01 19:18:32'),
(92, 48, '1748805512q4UDRj0dir.png', '2025-06-01 19:18:32', '2025-06-01 19:18:32'),
(93, 49, '1748805693u6A34MzcHk.png', '2025-06-01 19:21:33', '2025-06-01 19:21:33'),
(94, 49, '1748805693dgFHKdjk6E.png', '2025-06-01 19:21:33', '2025-06-01 19:21:33'),
(95, 50, '1748805978FR4F5EzIcl.png', '2025-06-01 19:26:18', '2025-06-01 19:26:18'),
(96, 50, '1748805978iGIVgWn9Xb.png', '2025-06-01 19:26:18', '2025-06-01 19:26:18'),
(97, 51, '1748805978BXXDFmM59M.png', '2025-06-01 19:26:18', '2025-06-01 19:26:18'),
(98, 51, '1748805978ATzVSc7FNX.png', '2025-06-01 19:26:18', '2025-06-01 19:26:18'),
(99, 52, '1748806038m2V902Kajt.png', '2025-06-01 19:27:18', '2025-06-01 19:27:18'),
(100, 52, '1748806038bU8cPhAquB.png', '2025-06-01 19:27:18', '2025-06-01 19:27:18'),
(101, 53, '1748806090QSYmooUOs8.png', '2025-06-01 19:28:10', '2025-06-01 19:28:10'),
(102, 53, '1748806090mF4MzTJGHy.png', '2025-06-01 19:28:10', '2025-06-01 19:28:10'),
(103, 54, '1748806153HkZemNPWSe.png', '2025-06-01 19:29:13', '2025-06-01 19:29:13'),
(104, 54, '1748806153NRiNaBSuYW.png', '2025-06-01 19:29:13', '2025-06-01 19:29:13'),
(105, 55, '1748806230afoaxTJzk3.png', '2025-06-01 19:30:30', '2025-06-01 19:30:30'),
(106, 55, '17488062308qHpooTaTm.png', '2025-06-01 19:30:30', '2025-06-01 19:30:30'),
(107, 56, '1748806230BsF2os1fLI.png', '2025-06-01 19:30:30', '2025-06-01 19:30:30'),
(108, 56, '17488062305PlSrnongj.png', '2025-06-01 19:30:30', '2025-06-01 19:30:30'),
(109, 57, '1748806418cV1dnVOKsP.png', '2025-06-01 19:33:38', '2025-06-01 19:33:38'),
(110, 57, '1748806418v7syzE9dTy.png', '2025-06-01 19:33:38', '2025-06-01 19:33:38'),
(111, 58, '1748806791Jhic1Vb6sQ.png', '2025-06-01 19:39:51', '2025-06-01 19:39:51'),
(112, 58, '1748806791eOgetVW6kU.png', '2025-06-01 19:39:51', '2025-06-01 19:39:51'),
(113, 59, '1748806865PXDh0j7Fcr.png', '2025-06-01 19:41:05', '2025-06-01 19:41:05'),
(114, 59, '1748806865jY0PITvpDg.png', '2025-06-01 19:41:05', '2025-06-01 19:41:05'),
(115, 60, '17488069571VZVt3mV2Y.png', '2025-06-01 19:42:37', '2025-06-01 19:42:37'),
(116, 60, '17488069572JAlzHKqPy.png', '2025-06-01 19:42:37', '2025-06-01 19:42:37'),
(117, 61, '1748807167X55AMenFcP.png', '2025-06-01 19:46:07', '2025-06-01 19:46:07'),
(118, 61, '1748807167vvUs8zndwm.png', '2025-06-01 19:46:07', '2025-06-01 19:46:07'),
(119, 62, '1748807443dG1PmjgETz.png', '2025-06-01 19:50:43', '2025-06-01 19:50:43'),
(120, 62, '1748807443dzDdcjAHPg.png', '2025-06-01 19:50:43', '2025-06-01 19:50:43'),
(121, 63, '1748807443jy3zjN9lK7.png', '2025-06-01 19:50:43', '2025-06-01 19:50:43'),
(122, 63, '1748807443Zu8S6acOJI.png', '2025-06-01 19:50:43', '2025-06-01 19:50:43'),
(123, 64, '1748807443i8wUc3I85g.png', '2025-06-01 19:50:43', '2025-06-01 19:50:43'),
(124, 64, '1748807443EyqYtvklYb.png', '2025-06-01 19:50:43', '2025-06-01 19:50:43'),
(125, 65, '1748808386uD6WNBH1TZ.png', '2025-06-01 20:06:26', '2025-06-01 20:06:26'),
(126, 65, '1748808386oolO4CiSok.png', '2025-06-01 20:06:26', '2025-06-01 20:06:26'),
(127, 66, '1748808386Y91lEc0alr.png', '2025-06-01 20:06:26', '2025-06-01 20:06:26'),
(128, 66, '17488083865qrgwL72Tr.png', '2025-06-01 20:06:26', '2025-06-01 20:06:26'),
(129, 67, '1748808386kuscqiDX9X.png', '2025-06-01 20:06:26', '2025-06-01 20:06:26'),
(130, 67, '1748808386la34mYzkdB.png', '2025-06-01 20:06:26', '2025-06-01 20:06:26'),
(131, 68, '1748808386JUdWWfvh8l.png', '2025-06-01 20:06:26', '2025-06-01 20:06:26'),
(132, 68, '1748808386OLF4sjmSa5.png', '2025-06-01 20:06:26', '2025-06-01 20:06:26'),
(133, 69, '1748808454kk8ZPnqyxf.png', '2025-06-01 20:07:34', '2025-06-01 20:07:34'),
(134, 69, '1748808454tByyERFaLF.png', '2025-06-01 20:07:34', '2025-06-01 20:07:34'),
(135, 70, '1748808576ugrUzktmTT.png', '2025-06-01 20:09:36', '2025-06-01 20:09:36'),
(136, 70, '1748808576VIhcMao6Bh.png', '2025-06-01 20:09:36', '2025-06-01 20:09:36'),
(137, 71, '1748808576y8mHD99KJI.png', '2025-06-01 20:09:36', '2025-06-01 20:09:36'),
(138, 71, '174880857619L5CDFf7e.png', '2025-06-01 20:09:36', '2025-06-01 20:09:36'),
(139, 72, '1748810053Yvxv1JjtT3.png', '2025-06-01 20:34:13', '2025-06-01 20:34:13'),
(140, 72, '1748810053q3vZPQIUlQ.png', '2025-06-01 20:34:13', '2025-06-01 20:34:13'),
(141, 73, '1748810179SHIfl7RCxD.png', '2025-06-01 20:36:19', '2025-06-01 20:36:19'),
(142, 73, '174881017901bQfohYOh.png', '2025-06-01 20:36:19', '2025-06-01 20:36:19'),
(143, 74, '17488103068qogKwrCwb.png', '2025-06-01 20:38:26', '2025-06-01 20:38:26'),
(144, 74, '17488103060JYH43fSP5.png', '2025-06-01 20:38:26', '2025-06-01 20:38:26'),
(145, 75, '17488103066BZdNYTbwD.png', '2025-06-01 20:38:26', '2025-06-01 20:38:26'),
(146, 75, '1748810306cvnoj0TDPt.png', '2025-06-01 20:38:26', '2025-06-01 20:38:26'),
(147, 76, '1748810694XZ8QUfYjfD.png', '2025-06-01 20:44:54', '2025-06-01 20:44:54'),
(148, 76, '1748810694Hyo7x608od.png', '2025-06-01 20:44:54', '2025-06-01 20:44:54'),
(149, 77, '1748810694F1CmqNoVC0.png', '2025-06-01 20:44:54', '2025-06-01 20:44:54'),
(150, 77, '17488106949ZwPtqgeV8.png', '2025-06-01 20:44:54', '2025-06-01 20:44:54'),
(151, 78, '1748810779IpmbXCtZ5V.png', '2025-06-01 20:46:19', '2025-06-01 20:46:19'),
(152, 78, '1748810779N2v3SmHwC7.png', '2025-06-01 20:46:19', '2025-06-01 20:46:19'),
(153, 79, '1748811149It50y5s1Tc.png', '2025-06-01 20:52:29', '2025-06-01 20:52:29'),
(154, 79, '174881114919m67rOE7Z.png', '2025-06-01 20:52:29', '2025-06-01 20:52:29'),
(155, 80, '174881114909iewXeoIU.png', '2025-06-01 20:52:29', '2025-06-01 20:52:29'),
(156, 80, '1748811149vhhqIgXZxi.png', '2025-06-01 20:52:29', '2025-06-01 20:52:29'),
(157, 81, '17488111498FNL63ccp1.png', '2025-06-01 20:52:29', '2025-06-01 20:52:29'),
(158, 81, '1748811149InFfk9BBwO.png', '2025-06-01 20:52:29', '2025-06-01 20:52:29'),
(159, 82, '1748811149E9OL2i1am9.png', '2025-06-01 20:52:29', '2025-06-01 20:52:29'),
(160, 82, '1748811149J8jVyApunJ.png', '2025-06-01 20:52:29', '2025-06-01 20:52:29'),
(161, 83, '1748851534TNt6XnIgBQ.png', '2025-06-02 08:05:34', '2025-06-02 08:05:34'),
(162, 83, '1748851534Nllmg1LpTm.png', '2025-06-02 08:05:34', '2025-06-02 08:05:34'),
(163, 84, '1748851534mGo7QBY9ED.png', '2025-06-02 08:05:34', '2025-06-02 08:05:34'),
(164, 84, '1748851534adc1bZZrL3.png', '2025-06-02 08:05:34', '2025-06-02 08:05:34'),
(165, 85, '1748851534MG8cf8y1z2.png', '2025-06-02 08:05:34', '2025-06-02 08:05:34'),
(166, 85, '17488515343O95n4XcDW.png', '2025-06-02 08:05:34', '2025-06-02 08:05:34'),
(167, 86, '1748851534s3eshpuyfl.png', '2025-06-02 08:05:34', '2025-06-02 08:05:34'),
(168, 86, '1748851534iwFR3sjcDU.png', '2025-06-02 08:05:34', '2025-06-02 08:05:34'),
(169, 87, '1748851635V2pED8qj1f.png', '2025-06-02 08:07:15', '2025-06-02 08:07:15'),
(170, 87, '1748851635CIJWQf0kUg.png', '2025-06-02 08:07:15', '2025-06-02 08:07:15'),
(171, 88, '1748852947WVPgFkWHaM.png', '2025-06-02 08:29:07', '2025-06-02 08:29:07'),
(172, 88, '1748852947u4EfuILuqU.png', '2025-06-02 08:29:07', '2025-06-02 08:29:07'),
(173, 89, '1748852947WoAbjFFdgy.png', '2025-06-02 08:29:07', '2025-06-02 08:29:07'),
(174, 89, '1748852947yoqmve5WZu.png', '2025-06-02 08:29:07', '2025-06-02 08:29:07'),
(175, 90, '1748854121ue6cuRKe5Z.png', '2025-06-02 08:48:41', '2025-06-02 08:48:41'),
(176, 90, '1748854121iNYxVDhdXX.png', '2025-06-02 08:48:41', '2025-06-02 08:48:41'),
(177, 91, '174885511149EUAF63pB.png', '2025-06-02 09:05:11', '2025-06-02 09:05:11'),
(178, 91, '1748855111AKkM5OnOLW.png', '2025-06-02 09:05:11', '2025-06-02 09:05:11'),
(179, 92, '1748855168qm1T1X8Sg2.png', '2025-06-02 09:06:08', '2025-06-02 09:06:08'),
(180, 92, '1748855168cp6y9CMGUc.png', '2025-06-02 09:06:08', '2025-06-02 09:06:08'),
(181, 93, '1748855421FrLSY4ysCu.png', '2025-06-02 09:10:21', '2025-06-02 09:10:21'),
(182, 93, '17488554210JvSEAIg6s.png', '2025-06-02 09:10:21', '2025-06-02 09:10:21'),
(183, 94, '1748855421WBBX9ThrdT.png', '2025-06-02 09:10:21', '2025-06-02 09:10:21'),
(184, 94, '1748855421Af5Z5Wki1h.png', '2025-06-02 09:10:21', '2025-06-02 09:10:21'),
(185, 95, '1748855421HOTGvCMcuE.png', '2025-06-02 09:10:21', '2025-06-02 09:10:21'),
(186, 95, '17488554213d7zkW1mfN.png', '2025-06-02 09:10:21', '2025-06-02 09:10:21'),
(189, 97, '1748855666szVXZpnnDj.png', '2025-06-02 09:14:26', '2025-06-02 09:14:26'),
(190, 97, '1748855666h5RQ4a8jVt.png', '2025-06-02 09:14:26', '2025-06-02 09:14:26'),
(191, 98, '1748855666CVOL73ySD7.png', '2025-06-02 09:14:26', '2025-06-02 09:14:26'),
(192, 98, '1748855666P6EpaJ4ATa.png', '2025-06-02 09:14:26', '2025-06-02 09:14:26'),
(193, 99, '1748855666pjPNlogCuS.png', '2025-06-02 09:14:26', '2025-06-02 09:14:26'),
(194, 99, '17488556669LLOGvgUCz.png', '2025-06-02 09:14:26', '2025-06-02 09:14:26'),
(195, 100, '1748855666Uf4oN2HIWA.png', '2025-06-02 09:14:26', '2025-06-02 09:14:26'),
(196, 100, '1748855666XPECQ1yaW9.png', '2025-06-02 09:14:26', '2025-06-02 09:14:26'),
(197, 101, '1748855716HbxNdd7KkC.png', '2025-06-02 09:15:16', '2025-06-02 09:15:16'),
(198, 101, '1748855716A4S8CFqSU8.png', '2025-06-02 09:15:16', '2025-06-02 09:15:16'),
(199, 102, '1748856052dNP7O72DXQ.png', '2025-06-02 09:20:52', '2025-06-02 09:20:52'),
(200, 102, '17488560523qIIoWWreO.png', '2025-06-02 09:20:52', '2025-06-02 09:20:52'),
(201, 103, '1748856052FxubxDobHO.png', '2025-06-02 09:20:52', '2025-06-02 09:20:52'),
(202, 103, '17488560525jgy2zwPSy.png', '2025-06-02 09:20:52', '2025-06-02 09:20:52'),
(203, 104, '1748856052rEht4cSDGM.png', '2025-06-02 09:20:52', '2025-06-02 09:20:52'),
(204, 104, '1748856052lBxAHdxvOJ.png', '2025-06-02 09:20:52', '2025-06-02 09:20:52'),
(205, 105, '1748856052MH4YNL16ij.png', '2025-06-02 09:20:52', '2025-06-02 09:20:52'),
(206, 105, '1748856052dP8p4QVF94.png', '2025-06-02 09:20:52', '2025-06-02 09:20:52'),
(207, 106, '1748856307Ws3Fl3oc7T.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(208, 106, '1748856307ImDBcHm5nF.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(209, 107, '1748856307USoGIhdkNN.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(210, 107, '1748856307yrkN8NcJb8.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(211, 108, '1748856307iLtTciHCtH.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(212, 108, '17488563071nEollR9mf.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(213, 109, '1748856307GmE97yVORz.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(214, 109, '1748856307PCeRoNaaev.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(215, 110, '1748856307rPetkS7Zhb.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(216, 110, '1748856307RV9psxKSgJ.png', '2025-06-02 09:25:07', '2025-06-02 09:25:07'),
(217, 111, '1748856570naUQh3fCXM.png', '2025-06-02 09:29:30', '2025-06-02 09:29:30'),
(218, 111, '1748856570ROyK0D5iRX.png', '2025-06-02 09:29:30', '2025-06-02 09:29:30'),
(219, 112, '174885657088YF4I6quK.png', '2025-06-02 09:29:30', '2025-06-02 09:29:30'),
(220, 112, '1748856570n472Ok86kJ.png', '2025-06-02 09:29:30', '2025-06-02 09:29:30'),
(221, 113, '1748856570uXIqB8tsSE.png', '2025-06-02 09:29:30', '2025-06-02 09:29:30'),
(222, 113, '174885657027HpejK2sD.png', '2025-06-02 09:29:30', '2025-06-02 09:29:30'),
(223, 114, '1748856570nMxwOC7hMi.png', '2025-06-02 09:29:30', '2025-06-02 09:29:30'),
(224, 114, '17488565706jCr7n5kXm.png', '2025-06-02 09:29:30', '2025-06-02 09:29:30'),
(225, 115, '1748856624AX3BoEJam0.png', '2025-06-02 09:30:24', '2025-06-02 09:30:24'),
(226, 115, '1748856624dbSarG132a.png', '2025-06-02 09:30:24', '2025-06-02 09:30:24'),
(227, 116, '1748856841sYpcpJp8Yq.png', '2025-06-02 09:34:01', '2025-06-02 09:34:01'),
(228, 116, '1748856841WX9qmjeoCP.png', '2025-06-02 09:34:01', '2025-06-02 09:34:01'),
(229, 117, '17488568413VC1JvhNrV.png', '2025-06-02 09:34:01', '2025-06-02 09:34:01'),
(230, 117, '1748856841EYHFsUjm8G.png', '2025-06-02 09:34:01', '2025-06-02 09:34:01'),
(231, 118, '1748857024faktVpY0Fl.png', '2025-06-02 09:37:04', '2025-06-02 09:37:04'),
(232, 118, '17488570243RZW3uyUAD.png', '2025-06-02 09:37:04', '2025-06-02 09:37:04'),
(233, 119, '1748857076z5b11jDfEQ.png', '2025-06-02 09:37:56', '2025-06-02 09:37:56'),
(234, 119, '1748857076na3ZVaj6Tu.png', '2025-06-02 09:37:56', '2025-06-02 09:37:56'),
(237, 122, '174885736074NCmiQxdS.png', '2025-06-02 09:42:40', '2025-06-02 09:42:40'),
(238, 122, '1748857360lv8bntgn5l.png', '2025-06-02 09:42:40', '2025-06-02 09:42:40'),
(239, 123, '1748857360E7DOslXvIS.png', '2025-06-02 09:42:40', '2025-06-02 09:42:40'),
(240, 123, '1748857360lAyDkF2AMB.png', '2025-06-02 09:42:40', '2025-06-02 09:42:40'),
(241, 124, '1748857360i9DtbMyACJ.png', '2025-06-02 09:42:40', '2025-06-02 09:42:40'),
(242, 124, '1748857360lvfys94Asr.png', '2025-06-02 09:42:40', '2025-06-02 09:42:40'),
(243, 125, '1748857548jLIjhSMpVs.png', '2025-06-02 09:45:48', '2025-06-02 09:45:48'),
(244, 125, '1748857548r5Fm9ExJS2.png', '2025-06-02 09:45:48', '2025-06-02 09:45:48'),
(245, 126, '1748861804ueZ5Vosgb6.png', '2025-06-02 10:56:44', '2025-06-02 10:56:44'),
(246, 126, '17488618047If3Vp9O0K.png', '2025-06-02 10:56:44', '2025-06-02 10:56:44'),
(247, 127, '1748861804rwulTEZcmM.png', '2025-06-02 10:56:44', '2025-06-02 10:56:44'),
(248, 127, '1748861804U4h5amBQ9N.png', '2025-06-02 10:56:44', '2025-06-02 10:56:44'),
(249, 128, '1748861804ZvHegIGqJW.png', '2025-06-02 10:56:44', '2025-06-02 10:56:44'),
(250, 128, '1748861804eNzjr4zZ7P.png', '2025-06-02 10:56:44', '2025-06-02 10:56:44'),
(251, 120, '1748861977vP1UgwXCR9.png', '2025-06-02 10:59:37', '2025-06-02 10:59:37'),
(252, 120, '1748861977tao6U0RRSy.png', '2025-06-02 10:59:37', '2025-06-02 10:59:37'),
(253, 129, '1748861977FHSJMGoCzO.png', '2025-06-02 10:59:37', '2025-06-02 10:59:37'),
(254, 129, '1748861977lJU3FXu7tw.png', '2025-06-02 10:59:37', '2025-06-02 10:59:37'),
(255, 130, '1748862025uMB0Cms4CX.png', '2025-06-02 11:00:25', '2025-06-02 11:00:25'),
(256, 130, '17488620253T16GAUVfu.png', '2025-06-02 11:00:25', '2025-06-02 11:00:25'),
(257, 131, '1748862163U0FEgtPJy1.png', '2025-06-02 11:02:43', '2025-06-02 11:02:43'),
(258, 131, '1748862163eNon1hMx0j.png', '2025-06-02 11:02:43', '2025-06-02 11:02:43'),
(259, 132, '1748862254WqSKI92dom.png', '2025-06-02 11:04:14', '2025-06-02 11:04:14'),
(260, 132, '17488622540cYPCW2Uj3.png', '2025-06-02 11:04:14', '2025-06-02 11:04:14'),
(261, 133, '17488623986thvCkdAKC.png', '2025-06-02 11:06:38', '2025-06-02 11:06:38'),
(262, 133, '1748862398TCRitv6zZ1.png', '2025-06-02 11:06:38', '2025-06-02 11:06:38'),
(263, 134, '1748862563PHnkOODw6k.png', '2025-06-02 11:09:23', '2025-06-02 11:09:23'),
(264, 134, '1748862563yts0pssEtG.png', '2025-06-02 11:09:23', '2025-06-02 11:09:23'),
(265, 135, '1748862695AkIa88zeSa.png', '2025-06-02 11:11:35', '2025-06-02 11:11:35'),
(266, 135, '1748862695z2NGLcEqtf.png', '2025-06-02 11:11:35', '2025-06-02 11:11:35'),
(267, 136, '1748862816iO4F8rzUrE.png', '2025-06-02 11:13:36', '2025-06-02 11:13:36'),
(268, 136, '1748862816yhbmG0RHEK.png', '2025-06-02 11:13:36', '2025-06-02 11:13:36'),
(269, 137, '1748873261NmJm1bu2FX.png', '2025-06-02 14:07:41', '2025-06-02 14:07:41'),
(270, 137, '17488732615JHuEWjZkK.png', '2025-06-02 14:07:41', '2025-06-02 14:07:41'),
(271, 138, '1748873261Kyh2MLyiPA.png', '2025-06-02 14:07:41', '2025-06-02 14:07:41'),
(272, 138, '17488732615ThwicSIT0.png', '2025-06-02 14:07:41', '2025-06-02 14:07:41'),
(273, 139, '1748873261Ila8NUZmaT.png', '2025-06-02 14:07:41', '2025-06-02 14:07:41'),
(274, 139, '1748873261KtMSs2DJGH.png', '2025-06-02 14:07:41', '2025-06-02 14:07:41'),
(275, 140, '1748873326oHyw9gZufn.png', '2025-06-02 14:08:46', '2025-06-02 14:08:46'),
(276, 140, '1748873326aQ4pE1HH6f.png', '2025-06-02 14:08:46', '2025-06-02 14:08:46'),
(277, 141, '1748873326ZyKpKIL5sY.png', '2025-06-02 14:08:46', '2025-06-02 14:08:46'),
(278, 141, '1748873326s2ftOfVOAN.png', '2025-06-02 14:08:46', '2025-06-02 14:08:46'),
(279, 142, '1748873369hofSGRdOle.png', '2025-06-02 14:09:29', '2025-06-02 14:09:29'),
(280, 142, '1748873369qqJ7qxTA1j.png', '2025-06-02 14:09:29', '2025-06-02 14:09:29'),
(281, 143, '1748873553764fWncLMI.png', '2025-06-02 14:12:33', '2025-06-02 14:12:33'),
(282, 143, '1748873553pwhGLtCGz1.png', '2025-06-02 14:12:33', '2025-06-02 14:12:33'),
(283, 144, '1748873553j4kkiXtIRM.png', '2025-06-02 14:12:33', '2025-06-02 14:12:33'),
(284, 144, '1748873553Wghb2c7duz.png', '2025-06-02 14:12:33', '2025-06-02 14:12:33'),
(285, 145, '1748873867Az6fMUjaMq.png', '2025-06-02 14:17:47', '2025-06-02 14:17:47'),
(286, 145, '1748873867f1LRqgQLpi.png', '2025-06-02 14:17:47', '2025-06-02 14:17:47'),
(287, 146, '17488738671SJeYpHOJD.png', '2025-06-02 14:17:47', '2025-06-02 14:17:47'),
(288, 146, '1748873867r5BxAjJd3U.png', '2025-06-02 14:17:47', '2025-06-02 14:17:47'),
(289, 147, '1748873867xRWuHwg0zU.png', '2025-06-02 14:17:47', '2025-06-02 14:17:47'),
(290, 147, '17488738674gyEBeuUlK.png', '2025-06-02 14:17:47', '2025-06-02 14:17:47'),
(291, 148, '17488738675ZrAj8pDzX.png', '2025-06-02 14:17:47', '2025-06-02 14:17:47'),
(292, 148, '1748873867l2GAUmrjZF.png', '2025-06-02 14:17:47', '2025-06-02 14:17:47'),
(293, 149, '1748874208r3ymnZ6cRL.png', '2025-06-02 14:23:28', '2025-06-02 14:23:28'),
(294, 149, '1748874208BiLXq8uoEt.png', '2025-06-02 14:23:28', '2025-06-02 14:23:28'),
(295, 150, '1748874208ek8kOT6ec8.png', '2025-06-02 14:23:28', '2025-06-02 14:23:28'),
(296, 150, '17488742088jNbyDJmOg.png', '2025-06-02 14:23:28', '2025-06-02 14:23:28'),
(297, 151, '1748874208rZDe9zbRJ3.png', '2025-06-02 14:23:28', '2025-06-02 14:23:28'),
(298, 151, '1748874208bapSM0vhcw.png', '2025-06-02 14:23:28', '2025-06-02 14:23:28'),
(299, 152, '1748874208luv1a4v1Cv.png', '2025-06-02 14:23:28', '2025-06-02 14:23:28'),
(300, 152, '1748874208qXGd1esz5f.png', '2025-06-02 14:23:28', '2025-06-02 14:23:28'),
(301, 153, '17488744572Vxy74Me2j.png', '2025-06-02 14:27:37', '2025-06-02 14:27:37'),
(302, 153, '17488744577w0LXw6EF2.png', '2025-06-02 14:27:37', '2025-06-02 14:27:37'),
(303, 154, '1748874457pFwaEayjg3.png', '2025-06-02 14:27:37', '2025-06-02 14:27:37'),
(304, 154, '1748874457uZEiQqO4pJ.png', '2025-06-02 14:27:37', '2025-06-02 14:27:37'),
(305, 155, '1748874549YARJgfmJpz.png', '2025-06-02 14:29:09', '2025-06-02 14:29:09'),
(306, 155, '1748874549Qgg51EV00x.png', '2025-06-02 14:29:09', '2025-06-02 14:29:09'),
(307, 156, '1748874622QHbWvFEbJu.png', '2025-06-02 14:30:22', '2025-06-02 14:30:22'),
(308, 156, '1748874622T48UGAc1u5.png', '2025-06-02 14:30:22', '2025-06-02 14:30:22'),
(309, 157, '1748874704RXFKAxvd8s.png', '2025-06-02 14:31:44', '2025-06-02 14:31:44'),
(310, 158, '1748874704VPxRqWRqFY.png', '2025-06-02 14:31:44', '2025-06-02 14:31:44'),
(311, 158, '174887470495aEJGr3i5.png', '2025-06-02 14:31:44', '2025-06-02 14:31:44'),
(312, 159, '1748874749YYRdgRJEKW.png', '2025-06-02 14:32:29', '2025-06-02 14:32:29'),
(313, 159, '1748874749lOOI7zRjaq.png', '2025-06-02 14:32:29', '2025-06-02 14:32:29'),
(314, 160, '1748874881mqmvwQSZMz.png', '2025-06-02 14:34:41', '2025-06-02 14:34:41'),
(315, 160, '1748874881l3rY4i4dlc.png', '2025-06-02 14:34:41', '2025-06-02 14:34:41'),
(316, 161, '1748875144t8wx1Pp4Z5.png', '2025-06-02 14:39:04', '2025-06-02 14:39:04'),
(317, 161, '1748875144Z7FhwF90yz.png', '2025-06-02 14:39:04', '2025-06-02 14:39:04'),
(318, 162, '1748875144ut9NXer8t3.png', '2025-06-02 14:39:04', '2025-06-02 14:39:04'),
(319, 162, '1748875144VwZHx3oF4D.png', '2025-06-02 14:39:04', '2025-06-02 14:39:04'),
(320, 163, '1748875144CYvipHAXnN.png', '2025-06-02 14:39:04', '2025-06-02 14:39:04'),
(321, 163, '1748875144E4xWWrouAs.png', '2025-06-02 14:39:04', '2025-06-02 14:39:04'),
(322, 164, '1748890750Gig8ioHmNb.png', '2025-06-02 18:59:10', '2025-06-02 18:59:10'),
(323, 164, '17488907501aLKzl4HMU.png', '2025-06-02 18:59:10', '2025-06-02 18:59:10'),
(324, 165, '1748891139AZd4cESEux.png', '2025-06-02 19:05:39', '2025-06-02 19:05:39'),
(325, 165, '1748891139RgdzyirSZS.png', '2025-06-02 19:05:39', '2025-06-02 19:05:39'),
(326, 166, '1748891139UP02babseA.png', '2025-06-02 19:05:39', '2025-06-02 19:05:39'),
(327, 166, '1748891139UxdQRO8RW2.png', '2025-06-02 19:05:39', '2025-06-02 19:05:39'),
(328, 167, '1748891139FThZqUxY4U.png', '2025-06-02 19:05:39', '2025-06-02 19:05:39'),
(329, 167, '1748891139vKRJ3xCHeO.png', '2025-06-02 19:05:39', '2025-06-02 19:05:39'),
(330, 168, '1748891139SB8y6I87LG.png', '2025-06-02 19:05:39', '2025-06-02 19:05:39'),
(331, 168, '1748891139YpkLQkT6Hs.png', '2025-06-02 19:05:39', '2025-06-02 19:05:39'),
(332, 169, '1748892160cGuedB1HtS.png', '2025-06-02 19:22:40', '2025-06-02 19:22:40'),
(333, 169, '1748892160mAZhhBsCVt.png', '2025-06-02 19:22:40', '2025-06-02 19:22:40'),
(334, 170, '17488921609juqSGXDSQ.png', '2025-06-02 19:22:40', '2025-06-02 19:22:40'),
(335, 170, '1748892160uzHU3x9M48.png', '2025-06-02 19:22:40', '2025-06-02 19:22:40'),
(336, 171, '1748892160sJNoLk4D16.png', '2025-06-02 19:22:40', '2025-06-02 19:22:40'),
(337, 171, '1748892160YaZiwIMN9h.png', '2025-06-02 19:22:40', '2025-06-02 19:22:40'),
(338, 172, '1748892160jTxO4EC01z.png', '2025-06-02 19:22:40', '2025-06-02 19:22:40'),
(339, 172, '1748892160C0X2SjX9j0.png', '2025-06-02 19:22:40', '2025-06-02 19:22:40'),
(340, 173, '1748892413whJ6c7OD8L.png', '2025-06-02 19:26:53', '2025-06-02 19:26:53'),
(341, 173, '1748892413RKDyco5HQz.png', '2025-06-02 19:26:53', '2025-06-02 19:26:53'),
(342, 174, '1748892413jr4zcnOUoE.png', '2025-06-02 19:26:53', '2025-06-02 19:26:53'),
(343, 174, '1748892413TvA1Z04JQn.png', '2025-06-02 19:26:53', '2025-06-02 19:26:53'),
(344, 175, '1748892413PSGMoTXufo.png', '2025-06-02 19:26:53', '2025-06-02 19:26:53'),
(345, 175, '1748892413aD1kRUfF2I.png', '2025-06-02 19:26:53', '2025-06-02 19:26:53'),
(346, 176, '1748892413MGyCCPgJ3x.png', '2025-06-02 19:26:53', '2025-06-02 19:26:53'),
(347, 176, '1748892413KoqmVjCbPN.png', '2025-06-02 19:26:53', '2025-06-02 19:26:53'),
(348, 177, '1748892486zLWjpDJ5Pt.png', '2025-06-02 19:28:06', '2025-06-02 19:28:06'),
(349, 177, '1748892486zxAzctgXLX.png', '2025-06-02 19:28:06', '2025-06-02 19:28:06'),
(350, 178, '1748892486ircRHFlnyd.png', '2025-06-02 19:28:06', '2025-06-02 19:28:06'),
(351, 178, '1748892486mIknVMb4PC.png', '2025-06-02 19:28:06', '2025-06-02 19:28:06'),
(352, 179, '1748892723f7Iyo5abo3.png', '2025-06-02 19:32:03', '2025-06-02 19:32:03'),
(353, 179, '1748892723zwClyVJmyc.png', '2025-06-02 19:32:03', '2025-06-02 19:32:03'),
(354, 180, '1748892723ZPd3Sr7lTn.png', '2025-06-02 19:32:03', '2025-06-02 19:32:03'),
(355, 180, '1748892723qbN0okZdfK.png', '2025-06-02 19:32:03', '2025-06-02 19:32:03'),
(356, 181, '1748892810nD3vbL5F5c.png', '2025-06-02 19:33:30', '2025-06-02 19:33:30'),
(357, 181, '17488928105bY5826pSB.png', '2025-06-02 19:33:30', '2025-06-02 19:33:30'),
(358, 182, '1748892810zWldt1f1F4.png', '2025-06-02 19:33:30', '2025-06-02 19:33:30'),
(359, 182, '1748892810jYPdSSOlKF.png', '2025-06-02 19:33:30', '2025-06-02 19:33:30'),
(360, 183, '1748893034zJQgnGxV7o.png', '2025-06-02 19:37:14', '2025-06-02 19:37:14'),
(361, 183, '1748893034XxAx6jaYEz.png', '2025-06-02 19:37:14', '2025-06-02 19:37:14'),
(362, 184, '1748893702WUJGvvOB0Y.png', '2025-06-02 19:48:22', '2025-06-02 19:48:22'),
(363, 184, '17488937027ffbeAInBR.png', '2025-06-02 19:48:22', '2025-06-02 19:48:22'),
(364, 185, '1748893702nTqa1vwZaz.png', '2025-06-02 19:48:22', '2025-06-02 19:48:22'),
(365, 185, '1748893702wZAtcsPGBt.png', '2025-06-02 19:48:22', '2025-06-02 19:48:22'),
(366, 186, '1748893758iyjHoaLgvH.png', '2025-06-02 19:49:18', '2025-06-02 19:49:18'),
(367, 186, '17488937587jDvuGI4Gg.png', '2025-06-02 19:49:18', '2025-06-02 19:49:18'),
(368, 187, '1748893758OkC6AtPspA.png', '2025-06-02 19:49:18', '2025-06-02 19:49:18'),
(369, 187, '1748893758Dx2cp63sYe.png', '2025-06-02 19:49:18', '2025-06-02 19:49:18'),
(370, 188, '17488938579hAzEl0nxp.png', '2025-06-02 19:50:57', '2025-06-02 19:50:57'),
(371, 188, '1748893857FKRax73HOM.png', '2025-06-02 19:50:57', '2025-06-02 19:50:57'),
(372, 189, '1748893857sWAje368m7.png', '2025-06-02 19:50:57', '2025-06-02 19:50:57'),
(373, 189, '1748893857CvuivlF4US.png', '2025-06-02 19:50:57', '2025-06-02 19:50:57'),
(374, 190, '1748893857VtqrN5nTun.png', '2025-06-02 19:50:57', '2025-06-02 19:50:57'),
(375, 190, '1748893857idNl1vfTZ6.png', '2025-06-02 19:50:57', '2025-06-02 19:50:57'),
(376, 191, '1748893857qk1o637reu.png', '2025-06-02 19:50:57', '2025-06-02 19:50:57'),
(377, 191, '1748893857APZAlh3ho4.png', '2025-06-02 19:50:57', '2025-06-02 19:50:57'),
(378, 192, '1748893907K3ySMYW6c3.png', '2025-06-02 19:51:47', '2025-06-02 19:51:47'),
(379, 192, '1748893907ckSKqSCC0B.png', '2025-06-02 19:51:47', '2025-06-02 19:51:47'),
(380, 193, '1748893907uTxJpP0Mv2.png', '2025-06-02 19:51:47', '2025-06-02 19:51:47'),
(381, 193, '17488939075BUsIXtnth.png', '2025-06-02 19:51:47', '2025-06-02 19:51:47'),
(382, 194, '1748894004oWVjWyU4kg.png', '2025-06-02 19:53:24', '2025-06-02 19:53:24'),
(383, 194, '1748894004m0VyJengBD.png', '2025-06-02 19:53:24', '2025-06-02 19:53:24'),
(384, 195, '1748894004hvN1qMoJ4c.png', '2025-06-02 19:53:24', '2025-06-02 19:53:24'),
(385, 195, '1748894004YtzoGd0NOu.png', '2025-06-02 19:53:24', '2025-06-02 19:53:24'),
(386, 196, '17488940043RX7hBye5P.png', '2025-06-02 19:53:24', '2025-06-02 19:53:24'),
(387, 196, '1748894004FpDRmQUPQd.png', '2025-06-02 19:53:24', '2025-06-02 19:53:24'),
(390, 198, '1748894049qM8TOwbTEX.png', '2025-06-02 19:54:09', '2025-06-02 19:54:09'),
(391, 198, '1748894049QpgBNsUkMn.png', '2025-06-02 19:54:09', '2025-06-02 19:54:09'),
(392, 199, '1748894085ns60hK1PoA.png', '2025-06-02 19:54:45', '2025-06-02 19:54:45'),
(393, 199, '1748894085ci9cK7JYTp.png', '2025-06-02 19:54:45', '2025-06-02 19:54:45'),
(394, 200, '1748894118ELFUGVcILw.png', '2025-06-02 19:55:18', '2025-06-02 19:55:18'),
(395, 200, '1748894118YdLEhatp8C.png', '2025-06-02 19:55:18', '2025-06-02 19:55:18'),
(396, 201, '1748895047nCD03IOOvG.png', '2025-06-02 20:10:47', '2025-06-02 20:10:47'),
(397, 201, '17488950474bfuyQWbDo.png', '2025-06-02 20:10:47', '2025-06-02 20:10:47'),
(398, 202, '1748895047HytnwugmxO.png', '2025-06-02 20:10:47', '2025-06-02 20:10:47'),
(399, 203, '1748895047gm6mOxKgek.png', '2025-06-02 20:10:47', '2025-06-02 20:10:47'),
(400, 204, '1748895598MJCcjeVGAp.png', '2025-06-02 20:19:58', '2025-06-02 20:19:58'),
(401, 204, '1748895598Iih1ZFGOgt.png', '2025-06-02 20:19:58', '2025-06-02 20:19:58'),
(402, 205, '1748895598rJkApGRcTw.png', '2025-06-02 20:19:58', '2025-06-02 20:19:58'),
(403, 205, '1748895598uJ1g55Y0eI.png', '2025-06-02 20:19:58', '2025-06-02 20:19:58'),
(404, 206, '1748895598d5tZ8dEcX3.png', '2025-06-02 20:19:58', '2025-06-02 20:19:58'),
(405, 206, '1748895598GJOAVg7w6c.png', '2025-06-02 20:19:58', '2025-06-02 20:19:58'),
(406, 207, '1748895797E88tEVY2QF.png', '2025-06-02 20:23:17', '2025-06-02 20:23:17'),
(407, 207, '1748895797kVhNdNVQL9.png', '2025-06-02 20:23:17', '2025-06-02 20:23:17'),
(408, 208, '1748896001lQtLD1FcJD.png', '2025-06-02 20:26:41', '2025-06-02 20:26:41'),
(409, 208, '1748896001NXifuSI0GZ.png', '2025-06-02 20:26:41', '2025-06-02 20:26:41'),
(410, 209, '1748896001wEVzM5sosB.png', '2025-06-02 20:26:41', '2025-06-02 20:26:41'),
(411, 209, '1748896001SO7V1n9DK6.png', '2025-06-02 20:26:41', '2025-06-02 20:26:41'),
(412, 210, '1748896001pcPBEhCxgF.png', '2025-06-02 20:26:41', '2025-06-02 20:26:41'),
(413, 210, '1748896001xKgn6m8G0X.png', '2025-06-02 20:26:41', '2025-06-02 20:26:41'),
(414, 211, '1748896068G7DRXxEprp.png', '2025-06-02 20:27:48', '2025-06-02 20:27:48'),
(415, 211, '174889606848ppDTJ7ks.png', '2025-06-02 20:27:48', '2025-06-02 20:27:48'),
(416, 212, '17488960689KKfzuWMzP.png', '2025-06-02 20:27:48', '2025-06-02 20:27:48'),
(417, 212, '1748896068XuB72XT9O5.png', '2025-06-02 20:27:48', '2025-06-02 20:27:48'),
(418, 213, '1748896106lzx01631DH.png', '2025-06-02 20:28:26', '2025-06-02 20:28:26'),
(419, 213, '1748896106FpTIydNIui.png', '2025-06-02 20:28:26', '2025-06-02 20:28:26'),
(420, 214, '1748896359Z0pSmiKFpc.png', '2025-06-02 20:32:39', '2025-06-02 20:32:39'),
(421, 214, '1748896359iVKRN83hPb.png', '2025-06-02 20:32:39', '2025-06-02 20:32:39'),
(422, 215, '1748896359xedj1CUx4f.png', '2025-06-02 20:32:39', '2025-06-02 20:32:39'),
(423, 215, '1748896359VwgReUHFwH.png', '2025-06-02 20:32:39', '2025-06-02 20:32:39'),
(424, 216, '1748896359iffVaZkIwL.png', '2025-06-02 20:32:39', '2025-06-02 20:32:39'),
(425, 216, '1748896359dDebzCBvbG.png', '2025-06-02 20:32:39', '2025-06-02 20:32:39'),
(426, 217, '1748896593JSyNt9JOn3.png', '2025-06-02 20:36:33', '2025-06-02 20:36:33'),
(427, 217, '1748896593zImIflz38b.png', '2025-06-02 20:36:33', '2025-06-02 20:36:33'),
(428, 218, '1748896593roKeryBIcu.png', '2025-06-02 20:36:33', '2025-06-02 20:36:33'),
(429, 218, '1748896593okjaGRSMGw.png', '2025-06-02 20:36:33', '2025-06-02 20:36:33'),
(430, 219, '17488965936nyjFTDe0V.png', '2025-06-02 20:36:33', '2025-06-02 20:36:33'),
(431, 219, '1748896593xpx48HqmDz.png', '2025-06-02 20:36:33', '2025-06-02 20:36:33'),
(432, 220, '1748896971xz0zfL4PKF.png', '2025-06-02 20:42:51', '2025-06-02 20:42:51'),
(433, 220, '1748896971TpA4dzq0H3.png', '2025-06-02 20:42:51', '2025-06-02 20:42:51'),
(434, 221, '1748896971jFNeFuXRHR.png', '2025-06-02 20:42:51', '2025-06-02 20:42:51'),
(435, 221, '1748896971wCLJVtIGMt.png', '2025-06-02 20:42:51', '2025-06-02 20:42:51'),
(436, 222, '1748896971huGru6G81c.png', '2025-06-02 20:42:51', '2025-06-02 20:42:51'),
(437, 222, '1748896971KdH0I2RMfF.png', '2025-06-02 20:42:51', '2025-06-02 20:42:51'),
(438, 223, '1748897915bVK9wJxjt4.png', '2025-06-02 20:58:35', '2025-06-02 20:58:35'),
(439, 223, '1748897915Hz7yfVGLpJ.png', '2025-06-02 20:58:35', '2025-06-02 20:58:35'),
(440, 224, '17488979159Ibg2Xsc9P.png', '2025-06-02 20:58:35', '2025-06-02 20:58:35'),
(441, 224, '17488979151G88asIZlF.png', '2025-06-02 20:58:35', '2025-06-02 20:58:35'),
(442, 225, '17488979156IVouxAdvB.png', '2025-06-02 20:58:35', '2025-06-02 20:58:35'),
(443, 225, '1748897915WLxPmGioMF.png', '2025-06-02 20:58:35', '2025-06-02 20:58:35'),
(444, 226, '1748898179wWs2CNu0ab.png', '2025-06-02 21:02:59', '2025-06-02 21:02:59'),
(445, 226, '1748898179UBZ2Z47XDD.png', '2025-06-02 21:02:59', '2025-06-02 21:02:59'),
(446, 227, '174889817945LpYOMZGg.png', '2025-06-02 21:02:59', '2025-06-02 21:02:59'),
(447, 227, '1748898179koUWkjRTzR.png', '2025-06-02 21:02:59', '2025-06-02 21:02:59'),
(448, 228, '1748898179hM9oYG4roc.png', '2025-06-02 21:02:59', '2025-06-02 21:02:59'),
(449, 228, '1748898179cVBLZPwFG7.png', '2025-06-02 21:02:59', '2025-06-02 21:02:59'),
(450, 229, '1748898299cBoN4598e8.png', '2025-06-02 21:04:59', '2025-06-02 21:04:59'),
(451, 229, '1748898299hy3t1DVcVq.png', '2025-06-02 21:04:59', '2025-06-02 21:04:59'),
(452, 230, '1748898329TIpXTzUSG2.png', '2025-06-02 21:05:29', '2025-06-02 21:05:29'),
(453, 230, '1748898329VbD2o8ZKyG.png', '2025-06-02 21:05:29', '2025-06-02 21:05:29'),
(454, 231, '1748898369uzX6scEEfO.png', '2025-06-02 21:06:09', '2025-06-02 21:06:09'),
(455, 231, '1748898369QCqsq9BOXY.png', '2025-06-02 21:06:09', '2025-06-02 21:06:09'),
(456, 232, '17488984011ynbDMsnB7.png', '2025-06-02 21:06:41', '2025-06-02 21:06:41'),
(457, 232, '1748898401U3T0m7Af4S.png', '2025-06-02 21:06:41', '2025-06-02 21:06:41'),
(458, 197, '1748898500WO7PSvOf8L.png', '2025-06-02 21:08:20', '2025-06-02 21:08:20'),
(459, 197, '17488985007tzn1ZVM2m.png', '2025-06-02 21:08:20', '2025-06-02 21:08:20'),
(460, 233, '1748898500DM0WLLtrzE.png', '2025-06-02 21:08:20', '2025-06-02 21:08:20'),
(461, 233, '1748898500lcDkRD0Ehv.png', '2025-06-02 21:08:20', '2025-06-02 21:08:20'),
(462, 234, '1748898578ixKXaS9ZgW.png', '2025-06-02 21:09:38', '2025-06-02 21:09:38'),
(463, 234, '17488985782AoXazmkHf.png', '2025-06-02 21:09:38', '2025-06-02 21:09:38'),
(464, 235, '1748898578EeRkexpksa.png', '2025-06-02 21:09:38', '2025-06-02 21:09:38'),
(465, 235, '1748898578otjtieT24x.png', '2025-06-02 21:09:38', '2025-06-02 21:09:38'),
(466, 236, '17488987925VSwn6LD4m.png', '2025-06-02 21:13:12', '2025-06-02 21:13:12'),
(467, 236, '1748898792KYAGoEpoNt.png', '2025-06-02 21:13:12', '2025-06-02 21:13:12'),
(468, 237, '1748898933CTDoab7Inm.png', '2025-06-02 21:15:33', '2025-06-02 21:15:33'),
(469, 237, '1748898933K1WVt0MmcZ.png', '2025-06-02 21:15:33', '2025-06-02 21:15:33'),
(470, 238, '1748899260pjIfU7Y1TU.png', '2025-06-02 21:21:00', '2025-06-02 21:21:00'),
(471, 238, '1748899260WMiTDBcrS6.png', '2025-06-02 21:21:00', '2025-06-02 21:21:00'),
(472, 239, '1748899260WfbEat1lff.png', '2025-06-02 21:21:00', '2025-06-02 21:21:00'),
(473, 239, '17488992609FOcbSs7zc.png', '2025-06-02 21:21:00', '2025-06-02 21:21:00'),
(474, 240, '1748899542pJIvkBAYeW.png', '2025-06-02 21:25:42', '2025-06-02 21:25:42'),
(475, 240, '1748899542N61gS5XbJk.png', '2025-06-02 21:25:42', '2025-06-02 21:25:42'),
(476, 241, '17488995428RArxMoMXL.png', '2025-06-02 21:25:42', '2025-06-02 21:25:42'),
(477, 241, '1748899542IZpiVAO1jf.png', '2025-06-02 21:25:42', '2025-06-02 21:25:42'),
(478, 242, '1748899542PuIUWqhspH.png', '2025-06-02 21:25:42', '2025-06-02 21:25:42'),
(479, 242, '1748899542oTK5AMjYJD.png', '2025-06-02 21:25:42', '2025-06-02 21:25:42'),
(480, 243, '1748899751K2ul9TLmPO.png', '2025-06-02 21:29:11', '2025-06-02 21:29:11'),
(481, 243, '1748899751LUL56PC4wv.png', '2025-06-02 21:29:11', '2025-06-02 21:29:11'),
(482, 244, '1748899751kjXFlYuP2O.png', '2025-06-02 21:29:11', '2025-06-02 21:29:11'),
(483, 244, '1748899751E1dkpAVHTZ.png', '2025-06-02 21:29:11', '2025-06-02 21:29:11'),
(484, 245, '17488999274WIpHZABLz.png', '2025-06-02 21:32:07', '2025-06-02 21:32:07'),
(485, 245, '1748899927062cmhTz2I.png', '2025-06-02 21:32:07', '2025-06-02 21:32:07'),
(486, 246, '1748899927dG12vLxDfM.png', '2025-06-02 21:32:07', '2025-06-02 21:32:07'),
(487, 246, '1748899927iw1ysQYv1H.png', '2025-06-02 21:32:07', '2025-06-02 21:32:07'),
(488, 247, '1748967563rqKsOiCasv.png', '2025-06-03 16:19:23', '2025-06-03 16:19:23'),
(489, 247, '1748967563ishOKGgC9R.png', '2025-06-03 16:19:23', '2025-06-03 16:19:23'),
(490, 248, '1748967827rXkN6WStUV.png', '2025-06-03 16:23:47', '2025-06-03 16:23:47'),
(491, 248, '17489678278jENwLlfs0.png', '2025-06-03 16:23:47', '2025-06-03 16:23:47'),
(492, 249, '1748967827t8bcA5UkrR.png', '2025-06-03 16:23:47', '2025-06-03 16:23:47'),
(493, 249, '1748967827e2h8xEx0Bi.png', '2025-06-03 16:23:47', '2025-06-03 16:23:47'),
(494, 250, '1748968177eQx10vgvQF.png', '2025-06-03 16:29:37', '2025-06-03 16:29:37'),
(495, 250, '17489681773OtqImQL6h.png', '2025-06-03 16:29:37', '2025-06-03 16:29:37'),
(496, 251, '1748968177Zj4kQjMtW5.png', '2025-06-03 16:29:37', '2025-06-03 16:29:37'),
(497, 251, '1748968177dI60xMwY00.png', '2025-06-03 16:29:37', '2025-06-03 16:29:37'),
(498, 252, '1748978364GzL4MW5Wgr.png', '2025-06-03 19:19:24', '2025-06-03 19:19:24'),
(499, 252, '1748978364qKNximUHYL.png', '2025-06-03 19:19:24', '2025-06-03 19:19:24'),
(500, 253, '1748978364jThlFJRpct.png', '2025-06-03 19:19:24', '2025-06-03 19:19:24'),
(501, 253, '1748978364ePU45igRYc.png', '2025-06-03 19:19:24', '2025-06-03 19:19:24'),
(502, 254, '1748978702szSCpy9SYu.png', '2025-06-03 19:25:02', '2025-06-03 19:25:02'),
(503, 254, '1748978702b6Sg0PvoaZ.png', '2025-06-03 19:25:02', '2025-06-03 19:25:02'),
(504, 255, '1748978702XYmkbCkXBD.png', '2025-06-03 19:25:02', '2025-06-03 19:25:02'),
(505, 255, '1748978702MgEYKAyKTH.png', '2025-06-03 19:25:02', '2025-06-03 19:25:02'),
(506, 256, '1748978899TMtIy3iMUV.png', '2025-06-03 19:28:19', '2025-06-03 19:28:19'),
(507, 256, '17489788995yC3nxPxyw.png', '2025-06-03 19:28:19', '2025-06-03 19:28:19'),
(508, 257, '17489788998Dh0kkyzdC.png', '2025-06-03 19:28:19', '2025-06-03 19:28:19'),
(509, 257, '1748978899eSitbAWoZD.png', '2025-06-03 19:28:19', '2025-06-03 19:28:19'),
(510, 258, '1748979056K8XLWsd49Q.png', '2025-06-03 19:30:56', '2025-06-03 19:30:56'),
(511, 258, '1748979056l9l2WzgNY4.png', '2025-06-03 19:30:56', '2025-06-03 19:30:56'),
(512, 259, '1748979056uC60ZSagCA.png', '2025-06-03 19:30:56', '2025-06-03 19:30:56'),
(513, 259, '1748979056ww9xdTdUTg.png', '2025-06-03 19:30:56', '2025-06-03 19:30:56'),
(514, 260, '1748979246W174wOtaCq.png', '2025-06-03 19:34:06', '2025-06-03 19:34:06'),
(515, 260, '174897924621StCKhvVm.png', '2025-06-03 19:34:06', '2025-06-03 19:34:06'),
(516, 261, '1748979246vVSHVcFIBF.png', '2025-06-03 19:34:06', '2025-06-03 19:34:06'),
(517, 261, '1748979246Nlllt8o1Zj.png', '2025-06-03 19:34:06', '2025-06-03 19:34:06'),
(518, 262, '1748979448e3J2oSU2fw.png', '2025-06-03 19:37:28', '2025-06-03 19:37:28'),
(519, 262, '1748979448ohLEq8ighL.png', '2025-06-03 19:37:28', '2025-06-03 19:37:28'),
(520, 263, '1748979448llnbSRLvAQ.png', '2025-06-03 19:37:28', '2025-06-03 19:37:28'),
(521, 263, '1748979448uIYVz1vOQ3.png', '2025-06-03 19:37:28', '2025-06-03 19:37:28'),
(522, 264, '1748980021cwhODwi9ie.png', '2025-06-03 19:47:01', '2025-06-03 19:47:01'),
(523, 264, '1748980021dPn3gCsmii.png', '2025-06-03 19:47:01', '2025-06-03 19:47:01'),
(524, 265, '1748980021pXjlXuaEz1.png', '2025-06-03 19:47:01', '2025-06-03 19:47:01'),
(525, 265, '17489800218x4UmMREdK.png', '2025-06-03 19:47:01', '2025-06-03 19:47:01'),
(526, 266, '17489800215I1VUknggH.png', '2025-06-03 19:47:01', '2025-06-03 19:47:01'),
(527, 266, '1748980021qxem8fPZhX.png', '2025-06-03 19:47:01', '2025-06-03 19:47:01'),
(528, 267, '1748980021aVER33G2gt.png', '2025-06-03 19:47:01', '2025-06-03 19:47:01'),
(529, 267, '1748980021vNiuWpmMpH.png', '2025-06-03 19:47:01', '2025-06-03 19:47:01'),
(530, 268, '1748980227xboEpGDTH3.png', '2025-06-03 19:50:27', '2025-06-03 19:50:27'),
(531, 268, '1748980227PV65jDPEJl.png', '2025-06-03 19:50:27', '2025-06-03 19:50:27'),
(532, 269, '1748980363yipmZyalhK.png', '2025-06-03 19:52:43', '2025-06-03 19:52:43'),
(533, 269, '17489803632hnAFuIuwp.png', '2025-06-03 19:52:43', '2025-06-03 19:52:43'),
(534, 270, '1748980488PmjCaR8vyo.png', '2025-06-03 19:54:48', '2025-06-03 19:54:48'),
(535, 270, '1748980488Kg9NTr0JHj.png', '2025-06-03 19:54:48', '2025-06-03 19:54:48'),
(536, 271, '17489806484GOLLHbXpi.png', '2025-06-03 19:57:28', '2025-06-03 19:57:28'),
(537, 271, '1748980648D3XZgtoB86.png', '2025-06-03 19:57:28', '2025-06-03 19:57:28'),
(538, 272, '1748980746oyqwdX6hiD.png', '2025-06-03 19:59:06', '2025-06-03 19:59:06'),
(539, 272, '1748980746mS5LTugUYJ.png', '2025-06-03 19:59:06', '2025-06-03 19:59:06'),
(540, 273, '1748980836in74CvGI13.png', '2025-06-03 20:00:36', '2025-06-03 20:00:36'),
(541, 274, '1748980931Gp6y3J5cwu.png', '2025-06-03 20:02:11', '2025-06-03 20:02:11'),
(542, 274, '1748980931eGRB0o1TsA.png', '2025-06-03 20:02:11', '2025-06-03 20:02:11'),
(543, 275, '1748981054utEg7Lr1er.png', '2025-06-03 20:04:14', '2025-06-03 20:04:14'),
(544, 275, '1748981054llWGhU4DiM.png', '2025-06-03 20:04:14', '2025-06-03 20:04:14'),
(545, 276, '1748981205HHEiWskqDR.png', '2025-06-03 20:06:45', '2025-06-03 20:06:45'),
(546, 276, '1748981205NIT1TuQRu3.png', '2025-06-03 20:06:45', '2025-06-03 20:06:45'),
(547, 277, '17489813041xiEcTXRHC.png', '2025-06-03 20:08:24', '2025-06-03 20:08:24'),
(548, 277, '1748981304GAVmTnzM0a.png', '2025-06-03 20:08:24', '2025-06-03 20:08:24'),
(549, 278, '1748981448egpiazgmk1.png', '2025-06-03 20:10:48', '2025-06-03 20:10:48'),
(550, 278, '17489814481BVlCyygQw.png', '2025-06-03 20:10:48', '2025-06-03 20:10:48'),
(551, 279, '1748981449nAm1K9sAIQ.png', '2025-06-03 20:10:49', '2025-06-03 20:10:49'),
(552, 279, '1748981449Fg9HOfKIaf.png', '2025-06-03 20:10:49', '2025-06-03 20:10:49'),
(553, 280, '1748981650phz2BPMVAg.png', '2025-06-03 20:14:10', '2025-06-03 20:14:10'),
(554, 280, '1748981650yKi5r8q6FY.png', '2025-06-03 20:14:10', '2025-06-03 20:14:10'),
(555, 281, '1748981760nYZoRPp3Ap.png', '2025-06-03 20:16:00', '2025-06-03 20:16:00'),
(556, 281, '1748981760PW41mLGcdF.png', '2025-06-03 20:16:00', '2025-06-03 20:16:00'),
(557, 282, '1748981860AEo6jmH06q.png', '2025-06-03 20:17:40', '2025-06-03 20:17:40'),
(558, 282, '1748981860f0GiaQxewc.png', '2025-06-03 20:17:40', '2025-06-03 20:17:40'),
(559, 283, '1748986300ylRjRAfqzP.png', '2025-06-03 21:31:40', '2025-06-03 21:31:40'),
(560, 283, '1748986300D2BCQ7SPcV.png', '2025-06-03 21:31:40', '2025-06-03 21:31:40'),
(561, 284, '1748987009EsgICC3j3t.png', '2025-06-03 21:43:29', '2025-06-03 21:43:29'),
(562, 284, '1748987009hH9p5N9TO6.png', '2025-06-03 21:43:29', '2025-06-03 21:43:29'),
(563, 285, '1748987110zqwoDbcm9g.png', '2025-06-03 21:45:10', '2025-06-03 21:45:10'),
(564, 285, '1748987110kcIj77yBSX.png', '2025-06-03 21:45:10', '2025-06-03 21:45:10'),
(565, 286, '1748987236cdHcTkiO1n.png', '2025-06-03 21:47:16', '2025-06-03 21:47:16'),
(566, 286, '1748987236U5NCvYuaJr.png', '2025-06-03 21:47:16', '2025-06-03 21:47:16'),
(567, 287, '17489872366Hw0ca6I3b.png', '2025-06-03 21:47:16', '2025-06-03 21:47:16'),
(568, 287, '1748987236ldmr6s22DZ.png', '2025-06-03 21:47:16', '2025-06-03 21:47:16'),
(569, 288, '1748991607q5tS0l76gz.png', '2025-06-03 23:00:07', '2025-06-03 23:00:07'),
(570, 288, '174899160772ESc190iq.png', '2025-06-03 23:00:07', '2025-06-03 23:00:07'),
(571, 289, '1748991607fjOFRLh2vD.png', '2025-06-03 23:00:07', '2025-06-03 23:00:07'),
(572, 289, '1748991607gqnOBimkiN.png', '2025-06-03 23:00:07', '2025-06-03 23:00:07'),
(573, 290, '17489916071qxXXjxGsl.png', '2025-06-03 23:00:07', '2025-06-03 23:00:07'),
(574, 290, '1748991607yaivRJbUPJ.png', '2025-06-03 23:00:07', '2025-06-03 23:00:07'),
(575, 291, '17489917026G0y2W38uA.png', '2025-06-03 23:01:42', '2025-06-03 23:01:42'),
(576, 291, '1748991702rCtgfl0UJi.png', '2025-06-03 23:01:42', '2025-06-03 23:01:42'),
(577, 292, '17489918473w6BzIJ1Ca.png', '2025-06-03 23:04:07', '2025-06-03 23:04:07'),
(578, 292, '1748991847G5gBz4P7XU.png', '2025-06-03 23:04:07', '2025-06-03 23:04:07'),
(579, 293, '17489918478XZfj8pem8.png', '2025-06-03 23:04:07', '2025-06-03 23:04:07'),
(580, 293, '1748991847wsqNtq9a1O.png', '2025-06-03 23:04:07', '2025-06-03 23:04:07'),
(581, 294, '1748991989gWTMfOc8Oc.png', '2025-06-03 23:06:29', '2025-06-03 23:06:29'),
(582, 294, '1748991989BKoiM0Fudr.png', '2025-06-03 23:06:29', '2025-06-03 23:06:29'),
(583, 295, '1748991989TQdMDjvwAT.png', '2025-06-03 23:06:29', '2025-06-03 23:06:29'),
(584, 295, '1748991989t5xAtL2u8p.png', '2025-06-03 23:06:29', '2025-06-03 23:06:29'),
(585, 296, '1748992122O9E8dWixyX.png', '2025-06-03 23:08:42', '2025-06-03 23:08:42'),
(586, 296, '17489921228peU8LihB5.png', '2025-06-03 23:08:42', '2025-06-03 23:08:42'),
(587, 297, '1748992122l8P2rkPJg8.png', '2025-06-03 23:08:42', '2025-06-03 23:08:42'),
(588, 297, '1748992122VkvHQWGc6m.png', '2025-06-03 23:08:42', '2025-06-03 23:08:42'),
(589, 298, '1748992286zfjDw3z2g0.png', '2025-06-03 23:11:26', '2025-06-03 23:11:26'),
(590, 298, '1748992286D5djlTSqXb.png', '2025-06-03 23:11:26', '2025-06-03 23:11:26'),
(591, 299, '1748992286SbPnQJKGqO.png', '2025-06-03 23:11:26', '2025-06-03 23:11:26'),
(592, 299, '17489922863t3CtzEh2m.png', '2025-06-03 23:11:26', '2025-06-03 23:11:26'),
(593, 300, '1748992416XU9OhMFybv.png', '2025-06-03 23:13:36', '2025-06-03 23:13:36'),
(594, 300, '1748992416dxpmqKTP15.png', '2025-06-03 23:13:36', '2025-06-03 23:13:36'),
(595, 301, '1748992416kMYBkyqBsM.png', '2025-06-03 23:13:36', '2025-06-03 23:13:36'),
(596, 301, '1748992416Jxldhb20QX.png', '2025-06-03 23:13:36', '2025-06-03 23:13:36'),
(597, 302, '1748992565uNlcGV4jJw.png', '2025-06-03 23:16:05', '2025-06-03 23:16:05'),
(598, 302, '17489925653wVUQJbFMN.png', '2025-06-03 23:16:05', '2025-06-03 23:16:05'),
(599, 303, '1748992566Q5vdkIUzGB.png', '2025-06-03 23:16:06', '2025-06-03 23:16:06'),
(600, 303, '1748992566iC4rFsgITp.png', '2025-06-03 23:16:06', '2025-06-03 23:16:06'),
(601, 305, '1748993867vOx7Qauht7.png', '2025-06-03 23:37:47', '2025-06-03 23:37:47'),
(602, 305, '1748993867LboufmT4LT.png', '2025-06-03 23:37:47', '2025-06-03 23:37:47'),
(603, 304, '1748993890zaZd6U5Xx4.png', '2025-06-03 23:38:10', '2025-06-03 23:38:10'),
(604, 304, '1748993890LRHNssE41k.png', '2025-06-03 23:38:10', '2025-06-03 23:38:10'),
(605, 306, '17489940000qD5YmgBQ2.png', '2025-06-03 23:40:00', '2025-06-03 23:40:00'),
(606, 306, '17489940002gPuza9EHN.png', '2025-06-03 23:40:00', '2025-06-03 23:40:00'),
(607, 307, '1748994154pz9rnlWFFe.png', '2025-06-03 23:42:34', '2025-06-03 23:42:34'),
(608, 307, '1748994154mfI4AHpzN5.png', '2025-06-03 23:42:34', '2025-06-03 23:42:34'),
(609, 308, '1748994154zENObqO6LO.png', '2025-06-03 23:42:34', '2025-06-03 23:42:34'),
(610, 308, '1748994154Ze8C0HUBp0.png', '2025-06-03 23:42:34', '2025-06-03 23:42:34'),
(611, 309, '1748994311eF5PQCNQmk.png', '2025-06-03 23:45:11', '2025-06-03 23:45:11'),
(612, 309, '1748994311FaFweLlEDs.png', '2025-06-03 23:45:11', '2025-06-03 23:45:11'),
(613, 310, '17489943112dfcyjGlip.png', '2025-06-03 23:45:11', '2025-06-03 23:45:11'),
(614, 310, '1748994311hPTgAwYxwW.png', '2025-06-03 23:45:11', '2025-06-03 23:45:11'),
(615, 311, '1748994311F2U0u0eHS9.png', '2025-06-03 23:45:11', '2025-06-03 23:45:11'),
(616, 311, '1748994311vYb6cXydiu.png', '2025-06-03 23:45:11', '2025-06-03 23:45:11'),
(617, 312, '1748994469bzLgtNfbTL.png', '2025-06-03 23:47:49', '2025-06-03 23:47:49'),
(618, 312, '17489944696PYwh5TSus.png', '2025-06-03 23:47:49', '2025-06-03 23:47:49'),
(619, 314, '1748994469n0xntSMbvo.png', '2025-06-03 23:47:49', '2025-06-03 23:47:49'),
(620, 314, '1748994469aeozqJIWOy.png', '2025-06-03 23:47:49', '2025-06-03 23:47:49'),
(621, 315, '17489945295JawcvGb08.png', '2025-06-03 23:48:49', '2025-06-03 23:48:49'),
(622, 315, '1748994529bg02dX8Q7Q.png', '2025-06-03 23:48:49', '2025-06-03 23:48:49'),
(623, 316, '1748994529NtSC660N9O.png', '2025-06-03 23:48:49', '2025-06-03 23:48:49'),
(624, 316, '1748994529qibwcVs8ll.png', '2025-06-03 23:48:49', '2025-06-03 23:48:49'),
(625, 317, '1748994778KkEeELiAqS.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(626, 317, '1748994778EWt4lWxz7p.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(627, 318, '1748994778EsJVBw4PDG.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(628, 318, '1748994778wa59a5dQuK.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(629, 319, '1748994778Qk7P5LCnU0.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(630, 319, '17489947780KyNIwJ06V.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(631, 320, '174899477807thw9PC29.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(632, 320, '1748994778oBawJhp82D.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58');
INSERT INTO `product_images` (`id`, `variant_id`, `image_path`, `created_at`, `updated_at`) VALUES
(633, 321, '1748994778BepZKznAj5.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(634, 321, '1748994778rln0l1mXxT.png', '2025-06-03 23:52:58', '2025-06-03 23:52:58'),
(635, 322, '1748994996JU8TKpCOkd.png', '2025-06-03 23:56:36', '2025-06-03 23:56:36'),
(636, 322, '1748994996GZLBrEgOzf.png', '2025-06-03 23:56:36', '2025-06-03 23:56:36'),
(637, 323, '1748994996d3tXYpDFgK.png', '2025-06-03 23:56:36', '2025-06-03 23:56:36'),
(638, 323, '17489949966qSURtrJSE.png', '2025-06-03 23:56:36', '2025-06-03 23:56:36'),
(639, 324, '1748994996QyZS5FbhUa.png', '2025-06-03 23:56:36', '2025-06-03 23:56:36'),
(640, 324, '1748994996dnOS17NnT6.png', '2025-06-03 23:56:36', '2025-06-03 23:56:36'),
(641, 325, '1748995130KJhVU1AzLO.png', '2025-06-03 23:58:50', '2025-06-03 23:58:50'),
(642, 325, '174899513057zh9ExE4Z.png', '2025-06-03 23:58:50', '2025-06-03 23:58:50'),
(643, 326, '1748995130ykG8x3B941.png', '2025-06-03 23:58:50', '2025-06-03 23:58:50'),
(644, 326, '1748995130mhnt8mxzfe.png', '2025-06-03 23:58:50', '2025-06-03 23:58:50'),
(645, 327, '1748995272Hcf3udfx4o.png', '2025-06-04 00:01:12', '2025-06-04 00:01:12'),
(646, 327, '174899527234fEOGzBjL.png', '2025-06-04 00:01:12', '2025-06-04 00:01:12'),
(647, 328, '1748995272ICPhyBUfjz.png', '2025-06-04 00:01:12', '2025-06-04 00:01:12'),
(648, 328, '1748995272fxqelChd57.png', '2025-06-04 00:01:12', '2025-06-04 00:01:12'),
(649, 329, '1748995441IkBANHpN4B.png', '2025-06-04 00:04:01', '2025-06-04 00:04:01'),
(650, 329, '1748995441iifSSBjmQ6.png', '2025-06-04 00:04:01', '2025-06-04 00:04:01'),
(651, 330, '1748995441lfLJE1f9xA.png', '2025-06-04 00:04:01', '2025-06-04 00:04:01'),
(652, 330, '1748995441oJSzWx0UIl.png', '2025-06-04 00:04:01', '2025-06-04 00:04:01'),
(653, 331, '1748995441rRtGBYFUO3.png', '2025-06-04 00:04:01', '2025-06-04 00:04:01'),
(654, 331, '1748995441tP0SdEGg6n.png', '2025-06-04 00:04:01', '2025-06-04 00:04:01'),
(655, 332, '1748995649jiQU82fz45.png', '2025-06-04 00:07:29', '2025-06-04 00:07:29'),
(656, 332, '17489956499UhCwqBwh0.png', '2025-06-04 00:07:29', '2025-06-04 00:07:29'),
(657, 333, '1748995649RRtUsClWpt.png', '2025-06-04 00:07:29', '2025-06-04 00:07:29'),
(658, 333, '1748995649ax8VzywBUn.png', '2025-06-04 00:07:29', '2025-06-04 00:07:29'),
(659, 334, '1748995649pFjQsckyRw.png', '2025-06-04 00:07:29', '2025-06-04 00:07:29'),
(660, 334, '17489956490T4a9Na3na.png', '2025-06-04 00:07:29', '2025-06-04 00:07:29'),
(661, 335, '1748995838SQUXGrW8Ya.png', '2025-06-04 00:10:38', '2025-06-04 00:10:38'),
(662, 335, '1748995838xzmNFXLf5q.png', '2025-06-04 00:10:38', '2025-06-04 00:10:38'),
(663, 336, '1748995838xJ5OnkJjT2.png', '2025-06-04 00:10:38', '2025-06-04 00:10:38'),
(664, 336, '1748995838pB5Fao97dJ.png', '2025-06-04 00:10:38', '2025-06-04 00:10:38'),
(665, 337, '1748995838WoAlK2PrBH.png', '2025-06-04 00:10:38', '2025-06-04 00:10:38'),
(666, 337, '1748995838fNomUVuX0a.png', '2025-06-04 00:10:38', '2025-06-04 00:10:38'),
(667, 338, '17489960193mwG5elG2n.png', '2025-06-04 00:13:39', '2025-06-04 00:13:39'),
(668, 338, '17489960198qR3Jyj9Ga.png', '2025-06-04 00:13:39', '2025-06-04 00:13:39'),
(669, 339, '1748996019vWUfuKLm1d.png', '2025-06-04 00:13:39', '2025-06-04 00:13:39'),
(670, 339, '1748996019hGX0b0P89d.png', '2025-06-04 00:13:39', '2025-06-04 00:13:39'),
(671, 340, '1748996019niNcHO3iWS.png', '2025-06-04 00:13:39', '2025-06-04 00:13:39'),
(672, 340, '17489960194KAVl1O8dL.png', '2025-06-04 00:13:39', '2025-06-04 00:13:39'),
(673, 341, '1748996188qmxvGar1b1.png', '2025-06-04 00:16:28', '2025-06-04 00:16:28'),
(674, 341, '1748996188HvzmlEQ8eM.png', '2025-06-04 00:16:28', '2025-06-04 00:16:28'),
(675, 342, '1748996188mGjlrA1Ldk.png', '2025-06-04 00:16:28', '2025-06-04 00:16:28'),
(676, 342, '1748996188UHa805K2Qu.png', '2025-06-04 00:16:28', '2025-06-04 00:16:28'),
(677, 343, '1748996188o157JmAH64.png', '2025-06-04 00:16:28', '2025-06-04 00:16:28'),
(678, 343, '1748996188r37mjs4Dnj.png', '2025-06-04 00:16:28', '2025-06-04 00:16:28'),
(679, 344, '1748996361ax2b3OyMnz.png', '2025-06-04 00:19:21', '2025-06-04 00:19:21'),
(680, 344, '1748996361wsJTnKUDVV.png', '2025-06-04 00:19:21', '2025-06-04 00:19:21'),
(681, 345, '1748996361vxwm3ZlqnV.png', '2025-06-04 00:19:21', '2025-06-04 00:19:21'),
(682, 345, '17489963619s6SCyaIRa.png', '2025-06-04 00:19:21', '2025-06-04 00:19:21'),
(683, 346, '1748996361ZgvtsrXhzN.png', '2025-06-04 00:19:21', '2025-06-04 00:19:21'),
(684, 346, '1748996361Wp2WqWa30O.png', '2025-06-04 00:19:21', '2025-06-04 00:19:21'),
(685, 347, '17489966113lRdbz8jDA.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(686, 347, '17489966118694EWMYCW.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(687, 348, '1748996611p84b2MRiCe.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(688, 348, '1748996611l2NvLApNrt.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(689, 349, '17489966110lEICVtfIg.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(690, 349, '1748996611YdjFPQcNq0.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(691, 350, '1748996611puE5nyOTeB.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(692, 350, '1748996611xAWu3O9uoG.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(693, 351, '1748996611LeO6CBa3jK.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(694, 351, '1748996611IR09kpbT7p.png', '2025-06-04 00:23:31', '2025-06-04 00:23:31'),
(695, 352, '1749052973TEQETx3ZZ2.png', '2025-06-04 16:02:53', '2025-06-04 16:02:53'),
(696, 352, '1749052973AbtqxuP5sq.png', '2025-06-04 16:02:53', '2025-06-04 16:02:53'),
(697, 353, '1749053062paCbEh8yKx.png', '2025-06-04 16:04:22', '2025-06-04 16:04:22'),
(698, 353, '17490530629cthzWkw80.png', '2025-06-04 16:04:22', '2025-06-04 16:04:22'),
(699, 354, '17490531980uxs7H2QmD.png', '2025-06-04 16:06:38', '2025-06-04 16:06:38'),
(700, 354, '1749053198QeIOhid2iI.png', '2025-06-04 16:06:38', '2025-06-04 16:06:38'),
(701, 355, '1749053632daaixbPrcC.png', '2025-06-04 16:13:52', '2025-06-04 16:13:52'),
(702, 355, '1749053632Cg3DOq70jD.png', '2025-06-04 16:13:52', '2025-06-04 16:13:52'),
(703, 356, '1749053632hGyE7CjAFy.png', '2025-06-04 16:13:52', '2025-06-04 16:13:52'),
(704, 356, '1749053632bFeJZCbdE4.png', '2025-06-04 16:13:52', '2025-06-04 16:13:52'),
(705, 357, '1749053772enKxHhgpnj.png', '2025-06-04 16:16:12', '2025-06-04 16:16:12'),
(706, 357, '1749053772hKW0wOz3bq.png', '2025-06-04 16:16:12', '2025-06-04 16:16:12'),
(707, 358, '1749053772eCJu47gHim.png', '2025-06-04 16:16:12', '2025-06-04 16:16:12'),
(708, 358, '1749053772wcM6RhHcdi.png', '2025-06-04 16:16:12', '2025-06-04 16:16:12'),
(709, 359, '1749054675qC0eZtaQQP.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(710, 359, '1749054675vobw2RFQW2.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(711, 360, '1749054675QqRKoFYrzf.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(712, 360, '1749054675np1ioWKI3J.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(713, 361, '174905467569uGB7hLe6.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(714, 361, '1749054675ggUTFyVm0T.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(715, 362, '17490546757sCb8LSDSq.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(716, 362, '1749054675tYk2kfnh7y.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(717, 363, '1749054675UuXwvReRdi.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(718, 363, '1749054675eWKNLoujvY.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(719, 364, '1749054675k53BsPAI3y.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(720, 364, '1749054675hL4KKaggE4.png', '2025-06-04 16:31:15', '2025-06-04 16:31:15'),
(721, 365, '1749055488fKPCJvGuJd.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(722, 365, '1749055488N0FsxHcFzP.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(723, 366, '1749055488SUGMMTsbR4.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(724, 366, '1749055488Po0JV3pjeN.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(725, 367, '1749055488J0TOoMqwNs.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(726, 367, '1749055488tSE0o3D17O.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(727, 368, '1749055488mHfDyYL0uG.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(728, 368, '17490554885w5GNufgBs.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(729, 369, '1749055488hIRLCsyqV3.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(730, 369, '174905548808pLIRIrRv.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(731, 370, '1749055488C2fIVOYire.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(732, 370, '17490554880Jfg9EjNcH.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(733, 371, '1749055488Eb5b8V00VY.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(734, 371, '1749055488IWY9MAiSij.png', '2025-06-04 16:44:48', '2025-06-04 16:44:48'),
(735, 372, '1749055655SXRjEvu02r.png', '2025-06-04 16:47:35', '2025-06-04 16:47:35'),
(736, 372, '1749055655Fc4BEwg8uB.png', '2025-06-04 16:47:35', '2025-06-04 16:47:35'),
(737, 373, '1749055655xQE5uTb1cP.png', '2025-06-04 16:47:35', '2025-06-04 16:47:35'),
(738, 373, '1749055655RXRw28FQre.png', '2025-06-04 16:47:35', '2025-06-04 16:47:35'),
(739, 374, '174905565578ZE6saSdH.png', '2025-06-04 16:47:35', '2025-06-04 16:47:35'),
(740, 374, '1749055655egOVtGbaCr.png', '2025-06-04 16:47:35', '2025-06-04 16:47:35'),
(741, 375, '17490556555txqLFR6FB.png', '2025-06-04 16:47:35', '2025-06-04 16:47:35'),
(742, 375, '1749055655A9c81iHxQy.png', '2025-06-04 16:47:35', '2025-06-04 16:47:35'),
(743, 376, '1749055861OkRQEWemKl.png', '2025-06-04 16:51:01', '2025-06-04 16:51:01'),
(744, 376, '1749055861cemWalLIQn.png', '2025-06-04 16:51:01', '2025-06-04 16:51:01'),
(745, 378, '174905586117nGVEiMAD.png', '2025-06-04 16:51:01', '2025-06-04 16:51:01'),
(746, 378, '1749055861d4ZT61SADX.png', '2025-06-04 16:51:01', '2025-06-04 16:51:01'),
(747, 379, '1749055861bzUrK6lGTc.png', '2025-06-04 16:51:01', '2025-06-04 16:51:01'),
(748, 379, '17490558613CKGMEKLSO.png', '2025-06-04 16:51:01', '2025-06-04 16:51:01'),
(749, 377, '1749055894Sky3KMhzQq.png', '2025-06-04 16:51:34', '2025-06-04 16:51:34'),
(750, 377, '1749055894lRnaukIwTe.png', '2025-06-04 16:51:34', '2025-06-04 16:51:34'),
(751, 380, '1749065439BemGG6Dvr6.png', '2025-06-04 19:30:39', '2025-06-04 19:30:39'),
(752, 380, '1749065439FsQLevNuHJ.png', '2025-06-04 19:30:39', '2025-06-04 19:30:39'),
(753, 381, '1749065439FSviGbqzZ5.png', '2025-06-04 19:30:39', '2025-06-04 19:30:39'),
(754, 381, '1749065439EChsfuRGs8.png', '2025-06-04 19:30:39', '2025-06-04 19:30:39'),
(755, 382, '1749065439hk4uZOBBYW.png', '2025-06-04 19:30:39', '2025-06-04 19:30:39'),
(756, 382, '174906543988OqL3SNj1.png', '2025-06-04 19:30:39', '2025-06-04 19:30:39'),
(757, 383, '17490654396yQ0n0O1Kv.png', '2025-06-04 19:30:39', '2025-06-04 19:30:39'),
(758, 383, '1749065439hBtqQURGnp.png', '2025-06-04 19:30:39', '2025-06-04 19:30:39'),
(759, 384, '17490656320O1fP386Rr.png', '2025-06-04 19:33:52', '2025-06-04 19:33:52'),
(760, 384, '1749065632TKcKBq01Ws.png', '2025-06-04 19:33:52', '2025-06-04 19:33:52'),
(761, 385, '1749065632iKzf49DURU.png', '2025-06-04 19:33:52', '2025-06-04 19:33:52'),
(762, 385, '1749065632EpJmHlNidW.png', '2025-06-04 19:33:52', '2025-06-04 19:33:52'),
(763, 386, '174906563283lDJXM0Hu.png', '2025-06-04 19:33:52', '2025-06-04 19:33:52'),
(764, 386, '17490656322PoR3hKCul.png', '2025-06-04 19:33:52', '2025-06-04 19:33:52'),
(765, 387, '1749065855FCHfcSZ5kg.png', '2025-06-04 19:37:35', '2025-06-04 19:37:35'),
(766, 387, '1749065855rjeS0kcuyU.png', '2025-06-04 19:37:35', '2025-06-04 19:37:35'),
(767, 388, '1749065855mpGLGBYG6n.png', '2025-06-04 19:37:35', '2025-06-04 19:37:35'),
(768, 388, '1749065855qvXDEF7CLm.png', '2025-06-04 19:37:35', '2025-06-04 19:37:35'),
(769, 389, '1749065855tDuqhZZfRh.png', '2025-06-04 19:37:35', '2025-06-04 19:37:35'),
(770, 389, '1749065855cEKgFTz0IY.png', '2025-06-04 19:37:35', '2025-06-04 19:37:35'),
(771, 390, '17490658552NEEgbsDhV.png', '2025-06-04 19:37:35', '2025-06-04 19:37:35'),
(772, 390, '1749065855FB29VSH0YT.png', '2025-06-04 19:37:35', '2025-06-04 19:37:35'),
(773, 391, '1749067494uiNVOSnftU.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(774, 391, '17490674946ST4GfhTra.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(775, 392, '1749067494zUc0IX6xJD.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(776, 392, '17490674940JPRLNUJnh.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(777, 393, '1749067494gWvU5X02SV.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(778, 393, '17490674945wxmma6nny.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(779, 394, '1749067494NX5owKVHWh.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(780, 394, '1749067494r9768vo1SJ.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(781, 395, '1749067494HmeAES7UM0.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(782, 395, '1749067494gR3nI2JQmq.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(783, 396, '1749067494tlUlxeIlCV.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(784, 396, '1749067494NH3k1OE745.png', '2025-06-04 20:04:54', '2025-06-04 20:04:54'),
(785, 397, '1749067698j5RtULGwM1.png', '2025-06-04 20:08:18', '2025-06-04 20:08:18'),
(786, 397, '1749067698LLVyah6Oh5.png', '2025-06-04 20:08:18', '2025-06-04 20:08:18'),
(787, 398, '174906769835iR9NZ0RV.png', '2025-06-04 20:08:18', '2025-06-04 20:08:18'),
(788, 398, '1749067698HFLvm9wwJ5.png', '2025-06-04 20:08:18', '2025-06-04 20:08:18'),
(789, 399, '1749067698RtcQ2cZdBk.png', '2025-06-04 20:08:18', '2025-06-04 20:08:18'),
(790, 399, '1749067698nZpENftx36.png', '2025-06-04 20:08:18', '2025-06-04 20:08:18'),
(791, 400, '1749067698nf8wmVceGZ.png', '2025-06-04 20:08:18', '2025-06-04 20:08:18'),
(792, 400, '1749067698FP6sp3OOtb.png', '2025-06-04 20:08:18', '2025-06-04 20:08:18'),
(793, 401, '1749067871cxYCvp37YA.png', '2025-06-04 20:11:11', '2025-06-04 20:11:11'),
(794, 401, '1749067871sdRUvYnxt9.png', '2025-06-04 20:11:11', '2025-06-04 20:11:11'),
(795, 402, '1749067871Ij3CF2PXf7.png', '2025-06-04 20:11:11', '2025-06-04 20:11:11'),
(796, 402, '1749067871qmjze4NDyj.png', '2025-06-04 20:11:11', '2025-06-04 20:11:11'),
(797, 403, '17490678712cgWyjtOFW.png', '2025-06-04 20:11:11', '2025-06-04 20:11:11'),
(798, 403, '1749067871Sv3V2R94gt.png', '2025-06-04 20:11:11', '2025-06-04 20:11:11'),
(799, 404, '1749068063jidcJ3pvNL.png', '2025-06-04 20:14:23', '2025-06-04 20:14:23'),
(800, 404, '1749068063C00VvPZAHG.png', '2025-06-04 20:14:23', '2025-06-04 20:14:23'),
(801, 405, '1749068063Zhp4ook2ph.png', '2025-06-04 20:14:23', '2025-06-04 20:14:23'),
(802, 405, '1749068063bqBwuQG0OA.png', '2025-06-04 20:14:23', '2025-06-04 20:14:23'),
(803, 406, '1749068063hpRwU85703.png', '2025-06-04 20:14:23', '2025-06-04 20:14:23'),
(804, 406, '1749068063rFr6ECfdQ0.png', '2025-06-04 20:14:23', '2025-06-04 20:14:23'),
(805, 407, '1749068063WeY9ZfKoua.png', '2025-06-04 20:14:23', '2025-06-04 20:14:23'),
(806, 407, '17490680633DYMvxryWv.png', '2025-06-04 20:14:23', '2025-06-04 20:14:23'),
(807, 408, '1749068331VpQ4fnyXFI.png', '2025-06-04 20:18:51', '2025-06-04 20:18:51'),
(808, 408, '1749068331eR2IuGDpmG.png', '2025-06-04 20:18:51', '2025-06-04 20:18:51'),
(809, 409, '1749068331jtzQ93KSgI.png', '2025-06-04 20:18:51', '2025-06-04 20:18:51'),
(810, 409, '1749068331XbmTQ4YKIB.png', '2025-06-04 20:18:51', '2025-06-04 20:18:51'),
(811, 410, '17490683315Gor7GPMgg.png', '2025-06-04 20:18:51', '2025-06-04 20:18:51'),
(812, 410, '1749068331yzcWLSWuC3.png', '2025-06-04 20:18:51', '2025-06-04 20:18:51'),
(813, 411, '1749068331HMmgtuL2tE.png', '2025-06-04 20:18:51', '2025-06-04 20:18:51'),
(814, 411, '1749068331M5fnd2ZY5H.png', '2025-06-04 20:18:51', '2025-06-04 20:18:51'),
(815, 412, '17490686450LrQlfBlzh.png', '2025-06-04 20:24:05', '2025-06-04 20:24:05'),
(816, 412, '1749068645roTIxemA0V.png', '2025-06-04 20:24:05', '2025-06-04 20:24:05'),
(817, 413, '1749068645Raokookpan.png', '2025-06-04 20:24:05', '2025-06-04 20:24:05'),
(818, 413, '1749068645RNCMpG0pAe.png', '2025-06-04 20:24:05', '2025-06-04 20:24:05'),
(819, 414, '1749068645SYlUMVc6yC.png', '2025-06-04 20:24:05', '2025-06-04 20:24:05'),
(820, 414, '1749068645RfUnbjaw7e.png', '2025-06-04 20:24:05', '2025-06-04 20:24:05'),
(821, 415, '1749071838MpxegWRykH.png', '2025-06-04 21:17:18', '2025-06-04 21:17:18'),
(822, 415, '1749071838KFhPiCzH4C.png', '2025-06-04 21:17:18', '2025-06-04 21:17:18'),
(823, 416, '1749071838bwLjOnPvy9.png', '2025-06-04 21:17:18', '2025-06-04 21:17:18'),
(824, 416, '1749071838STyY34fb13.png', '2025-06-04 21:17:18', '2025-06-04 21:17:18'),
(825, 417, '1749072158KEeGMJ1f9x.png', '2025-06-04 21:22:38', '2025-06-04 21:22:38'),
(826, 417, '1749072158wpNl9M44pG.png', '2025-06-04 21:22:38', '2025-06-04 21:22:38'),
(827, 418, '1749072158pf2AjbxkiK.png', '2025-06-04 21:22:38', '2025-06-04 21:22:38'),
(828, 418, '1749072158HtB9czCGqw.png', '2025-06-04 21:22:38', '2025-06-04 21:22:38'),
(829, 419, '17490721589p6XXzJRyL.png', '2025-06-04 21:22:38', '2025-06-04 21:22:38'),
(830, 419, '1749072158HyQyjSUhkW.png', '2025-06-04 21:22:38', '2025-06-04 21:22:38'),
(831, 420, '1749072158v2YQ6agCbJ.png', '2025-06-04 21:22:38', '2025-06-04 21:22:38'),
(832, 420, '1749072158eoYyf88bGn.png', '2025-06-04 21:22:38', '2025-06-04 21:22:38'),
(833, 421, '1749072304HL95CDtyur.png', '2025-06-04 21:25:04', '2025-06-04 21:25:04'),
(834, 421, '1749072304wepyXumxw0.png', '2025-06-04 21:25:04', '2025-06-04 21:25:04'),
(835, 422, '17490723040y56cLMhQa.png', '2025-06-04 21:25:04', '2025-06-04 21:25:04'),
(836, 422, '1749072304zuBtEoeiKp.png', '2025-06-04 21:25:04', '2025-06-04 21:25:04'),
(837, 423, '17490723046NV3ARR9qK.png', '2025-06-04 21:25:04', '2025-06-04 21:25:04'),
(838, 423, '1749072304bWyPlhdeG7.png', '2025-06-04 21:25:04', '2025-06-04 21:25:04'),
(839, 424, '1749072475y1LFXvSLLa.png', '2025-06-04 21:27:55', '2025-06-04 21:27:55'),
(840, 424, '1749072475wJH6r8CvSF.png', '2025-06-04 21:27:55', '2025-06-04 21:27:55'),
(841, 425, '1749072475wzoWKuX3ZU.png', '2025-06-04 21:27:55', '2025-06-04 21:27:55'),
(842, 425, '1749072475yeq964Y5tX.png', '2025-06-04 21:27:55', '2025-06-04 21:27:55'),
(843, 426, '1749072670ggzIwTraGz.png', '2025-06-04 21:31:10', '2025-06-04 21:31:10'),
(844, 426, '1749072670kdjdGLKKOr.png', '2025-06-04 21:31:10', '2025-06-04 21:31:10'),
(845, 427, '1749072670YUaW09eeJk.png', '2025-06-04 21:31:10', '2025-06-04 21:31:10'),
(846, 427, '17490726701MGaAW3jSe.png', '2025-06-04 21:31:10', '2025-06-04 21:31:10'),
(847, 428, '1749072799ya9vQK8stx.png', '2025-06-04 21:33:19', '2025-06-04 21:33:19'),
(848, 428, '1749072799d0wtlzYAxz.png', '2025-06-04 21:33:19', '2025-06-04 21:33:19'),
(849, 429, '1749072799e7AwVm8KvL.png', '2025-06-04 21:33:19', '2025-06-04 21:33:19'),
(850, 429, '1749072799m0crO0jrXO.png', '2025-06-04 21:33:19', '2025-06-04 21:33:19'),
(851, 430, '1749072937x1bfRXbrAf.png', '2025-06-04 21:35:37', '2025-06-04 21:35:37'),
(852, 430, '1749072937lupLnvHtAz.png', '2025-06-04 21:35:37', '2025-06-04 21:35:37'),
(853, 431, '1749072937m2Vn3pKXnb.png', '2025-06-04 21:35:37', '2025-06-04 21:35:37'),
(854, 431, '1749072937uBFAT1COap.png', '2025-06-04 21:35:37', '2025-06-04 21:35:37'),
(855, 432, '1749073060rjxycbEaQw.png', '2025-06-04 21:37:40', '2025-06-04 21:37:40'),
(856, 432, '1749073060O2Vspm1lXI.png', '2025-06-04 21:37:40', '2025-06-04 21:37:40'),
(857, 433, '1749073060Ry3uLoooPN.png', '2025-06-04 21:37:40', '2025-06-04 21:37:40'),
(858, 433, '1749073060pEMot2fQj4.png', '2025-06-04 21:37:40', '2025-06-04 21:37:40'),
(859, 434, '1749073219Js29KULQ4Q.png', '2025-06-04 21:40:19', '2025-06-04 21:40:19'),
(860, 434, '1749073219ELa4RVb4rh.png', '2025-06-04 21:40:19', '2025-06-04 21:40:19'),
(861, 435, '17490732193X2HhI2CHo.png', '2025-06-04 21:40:19', '2025-06-04 21:40:19'),
(862, 435, '1749073219KpYPmGvnkI.png', '2025-06-04 21:40:19', '2025-06-04 21:40:19'),
(863, 436, '17490734181cek6w4YQh.png', '2025-06-04 21:43:38', '2025-06-04 21:43:38'),
(864, 436, '1749073418O5sNMIWtIB.png', '2025-06-04 21:43:38', '2025-06-04 21:43:38'),
(865, 437, '1749073418Z9spAmJohc.png', '2025-06-04 21:43:38', '2025-06-04 21:43:38'),
(866, 437, '1749073418SJlAXGYRCH.png', '2025-06-04 21:43:38', '2025-06-04 21:43:38'),
(867, 438, '1749073418Lj5xx6VaMf.png', '2025-06-04 21:43:38', '2025-06-04 21:43:38'),
(868, 438, '17490734180k4Wk3CAkI.png', '2025-06-04 21:43:38', '2025-06-04 21:43:38'),
(869, 439, '1749073537hvM7m0qKT3.png', '2025-06-04 21:45:37', '2025-06-04 21:45:37'),
(870, 439, '1749073537x7ON9qgDDV.png', '2025-06-04 21:45:37', '2025-06-04 21:45:37'),
(871, 440, '1749073537BvjiwuhQLl.png', '2025-06-04 21:45:37', '2025-06-04 21:45:37'),
(872, 440, '1749073537MgNqxM4QMq.png', '2025-06-04 21:45:37', '2025-06-04 21:45:37'),
(873, 441, '17490736752GM4fSJ9vf.png', '2025-06-04 21:47:55', '2025-06-04 21:47:55'),
(874, 441, '1749073675Gb0aQhcATz.png', '2025-06-04 21:47:55', '2025-06-04 21:47:55'),
(875, 442, '1749073675w5IcNQKETN.png', '2025-06-04 21:47:55', '2025-06-04 21:47:55'),
(876, 442, '1749073675pAcDYWgtKD.png', '2025-06-04 21:47:55', '2025-06-04 21:47:55'),
(879, 445, '1749073863tpJ8CrA1TI.png', '2025-06-04 21:51:03', '2025-06-04 21:51:03'),
(880, 445, '1749073863Q6eQ5JctgL.png', '2025-06-04 21:51:03', '2025-06-04 21:51:03'),
(881, 446, '17490739892mSBN7NwAy.png', '2025-06-04 21:53:09', '2025-06-04 21:53:09'),
(882, 446, '1749073989WwjOfoFgOO.png', '2025-06-04 21:53:09', '2025-06-04 21:53:09'),
(883, 447, '1749073989EEcJEurCIS.png', '2025-06-04 21:53:09', '2025-06-04 21:53:09'),
(884, 447, '1749073989IMIGYpNAyQ.png', '2025-06-04 21:53:09', '2025-06-04 21:53:09'),
(885, 448, '1749074094I3jILPY0GX.png', '2025-06-04 21:54:54', '2025-06-04 21:54:54'),
(886, 448, '1749074094JemkgITu8B.png', '2025-06-04 21:54:54', '2025-06-04 21:54:54'),
(887, 449, '17490740944nYQxwNdxb.png', '2025-06-04 21:54:54', '2025-06-04 21:54:54'),
(888, 449, '17490740945FHT8Xl5nA.png', '2025-06-04 21:54:54', '2025-06-04 21:54:54'),
(889, 450, '1749074295iovrTlHaLN.png', '2025-06-04 21:58:15', '2025-06-04 21:58:15'),
(890, 450, '1749074295TTPhHh69ep.png', '2025-06-04 21:58:15', '2025-06-04 21:58:15'),
(891, 451, '1749074295iHLSRaJgSM.png', '2025-06-04 21:58:15', '2025-06-04 21:58:15'),
(892, 451, '1749074295XhTucHVlTF.png', '2025-06-04 21:58:15', '2025-06-04 21:58:15'),
(893, 452, '1749074295CNsbBpTqyb.png', '2025-06-04 21:58:15', '2025-06-04 21:58:15'),
(894, 452, '1749074295YDeJMRTsJX.png', '2025-06-04 21:58:15', '2025-06-04 21:58:15'),
(895, 453, '1749074430vzAtWo6oPj.png', '2025-06-04 22:00:30', '2025-06-04 22:00:30'),
(896, 453, '17490744306ywyGG4CM6.png', '2025-06-04 22:00:30', '2025-06-04 22:00:30'),
(897, 454, '1749074430cFg2dGwT7T.png', '2025-06-04 22:00:30', '2025-06-04 22:00:30'),
(898, 454, '1749074430ppVrIvFy0b.png', '2025-06-04 22:00:30', '2025-06-04 22:00:30'),
(899, 455, '17490744300ZOcTTorQz.png', '2025-06-04 22:00:30', '2025-06-04 22:00:30'),
(900, 455, '1749074430nBsIgYHjFS.png', '2025-06-04 22:00:30', '2025-06-04 22:00:30'),
(901, 456, '1749081229EPYLif0IRG.png', '2025-06-04 23:53:49', '2025-06-04 23:53:49'),
(902, 456, '1749081229D0f2HF5Mig.png', '2025-06-04 23:53:49', '2025-06-04 23:53:49'),
(903, 457, '1749081229DWQNEkOCRl.png', '2025-06-04 23:53:49', '2025-06-04 23:53:49'),
(904, 457, '1749081229WfHkkv12SC.png', '2025-06-04 23:53:49', '2025-06-04 23:53:49'),
(905, 458, '1749081229Z1MONWIoNs.png', '2025-06-04 23:53:49', '2025-06-04 23:53:49'),
(906, 458, '1749081229UaOxiniXsY.png', '2025-06-04 23:53:49', '2025-06-04 23:53:49'),
(907, 459, '1749081331KRUKGZbcrg.png', '2025-06-04 23:55:31', '2025-06-04 23:55:31'),
(908, 459, '17490813315mmbvOc7NU.png', '2025-06-04 23:55:31', '2025-06-04 23:55:31'),
(909, 460, '1749081331BDyMfiDQc3.png', '2025-06-04 23:55:31', '2025-06-04 23:55:31'),
(910, 460, '1749081331dOvjEjxZ4H.png', '2025-06-04 23:55:31', '2025-06-04 23:55:31'),
(911, 461, '1749081463ZqC8U3G51q.png', '2025-06-04 23:57:43', '2025-06-04 23:57:43'),
(912, 461, '1749081463bbd9YTafes.png', '2025-06-04 23:57:43', '2025-06-04 23:57:43'),
(913, 462, '1749081463I1x1yaqHEm.png', '2025-06-04 23:57:43', '2025-06-04 23:57:43'),
(914, 462, '174908146371cZqlDVFL.png', '2025-06-04 23:57:43', '2025-06-04 23:57:43'),
(915, 463, '17490815703JgHrQULQp.png', '2025-06-04 23:59:30', '2025-06-04 23:59:30'),
(916, 463, '1749081570XaxdYGvsPN.png', '2025-06-04 23:59:30', '2025-06-04 23:59:30'),
(917, 464, '1749081570c4tzxkjGsJ.png', '2025-06-04 23:59:30', '2025-06-04 23:59:30'),
(918, 464, '174908157083sUqCbHUc.png', '2025-06-04 23:59:30', '2025-06-04 23:59:30'),
(919, 465, '1749126066ulwlKyr6nZ.png', '2025-06-05 12:21:06', '2025-06-05 12:21:06'),
(920, 465, '1749126066qGRjm6L5y8.png', '2025-06-05 12:21:06', '2025-06-05 12:21:06'),
(921, 466, '1749126066yJyHy8Yytj.png', '2025-06-05 12:21:06', '2025-06-05 12:21:06'),
(922, 466, '1749126066PvxJnkjkP0.png', '2025-06-05 12:21:06', '2025-06-05 12:21:06'),
(923, 467, '1749126366BNiT0jNXMT.png', '2025-06-05 12:26:06', '2025-06-05 12:26:06'),
(924, 467, '1749126366hhCLluFXuZ.png', '2025-06-05 12:26:06', '2025-06-05 12:26:06'),
(925, 468, '1749126568sRhZmlOCdS.png', '2025-06-05 12:29:28', '2025-06-05 12:29:28'),
(926, 468, '1749126568olz3yS5ZZO.png', '2025-06-05 12:29:28', '2025-06-05 12:29:28'),
(927, 469, '1749126568PsQhOzoXe4.png', '2025-06-05 12:29:28', '2025-06-05 12:29:28'),
(928, 469, '17491265680FoMzicQ45.png', '2025-06-05 12:29:28', '2025-06-05 12:29:28'),
(929, 470, '1749126697iMyynwqko6.png', '2025-06-05 12:31:37', '2025-06-05 12:31:37'),
(930, 470, '1749126697Rbsly75UfX.png', '2025-06-05 12:31:37', '2025-06-05 12:31:37'),
(931, 471, '1749126697QaSDIbpdbm.png', '2025-06-05 12:31:37', '2025-06-05 12:31:37'),
(932, 471, '1749126697xD1TSM4yr9.png', '2025-06-05 12:31:37', '2025-06-05 12:31:37'),
(933, 472, '1749126823pO6wywxtFh.png', '2025-06-05 12:33:43', '2025-06-05 12:33:43'),
(934, 472, '1749126823GfbwsiJxyv.png', '2025-06-05 12:33:43', '2025-06-05 12:33:43'),
(935, 473, '1749126823VBE1hKhJjz.png', '2025-06-05 12:33:43', '2025-06-05 12:33:43'),
(936, 473, '1749126823BFvktHiF5s.png', '2025-06-05 12:33:43', '2025-06-05 12:33:43'),
(937, 474, '1749126944sf1zLmyPHX.png', '2025-06-05 12:35:44', '2025-06-05 12:35:44'),
(938, 474, '1749126944vc1hIC01vl.png', '2025-06-05 12:35:44', '2025-06-05 12:35:44'),
(939, 475, '17491269445sJSVYDvXW.png', '2025-06-05 12:35:44', '2025-06-05 12:35:44'),
(940, 475, '1749126944dlNMwGBU6n.png', '2025-06-05 12:35:44', '2025-06-05 12:35:44'),
(941, 476, '1749127040phbt2UOKOm.png', '2025-06-05 12:37:20', '2025-06-05 12:37:20'),
(942, 476, '1749127040c17qTSz3Qf.png', '2025-06-05 12:37:20', '2025-06-05 12:37:20'),
(943, 477, '174912704042QU5ErsZX.png', '2025-06-05 12:37:20', '2025-06-05 12:37:20'),
(944, 477, '1749127040fdWhpM0DYD.png', '2025-06-05 12:37:20', '2025-06-05 12:37:20'),
(945, 478, '17491272459bAZaAVXWi.png', '2025-06-05 12:40:45', '2025-06-05 12:40:45'),
(946, 478, '1749127245xAmVmpwcMu.png', '2025-06-05 12:40:45', '2025-06-05 12:40:45'),
(947, 479, '1749127245SuU19jAO4g.png', '2025-06-05 12:40:45', '2025-06-05 12:40:45'),
(948, 479, '1749127245gk4pGHLGjB.png', '2025-06-05 12:40:45', '2025-06-05 12:40:45'),
(949, 480, '1749127395wvsMET1462.png', '2025-06-05 12:43:15', '2025-06-05 12:43:15'),
(950, 480, '1749127395owQZMELhwX.png', '2025-06-05 12:43:15', '2025-06-05 12:43:15'),
(951, 481, '17491273957bxa2VCENe.png', '2025-06-05 12:43:15', '2025-06-05 12:43:15'),
(952, 481, '1749127395FaG1MiULGq.png', '2025-06-05 12:43:15', '2025-06-05 12:43:15'),
(953, 482, '174912752772ZBXSSzrI.png', '2025-06-05 12:45:27', '2025-06-05 12:45:27'),
(954, 482, '1749127527GjT4r2H9gm.png', '2025-06-05 12:45:27', '2025-06-05 12:45:27'),
(955, 483, '1749127527s0S91sPsXn.png', '2025-06-05 12:45:27', '2025-06-05 12:45:27'),
(956, 483, '1749127527N6iNXeTeBN.png', '2025-06-05 12:45:27', '2025-06-05 12:45:27'),
(957, 484, '1749127648gBDkGleTUF.png', '2025-06-05 12:47:28', '2025-06-05 12:47:28'),
(958, 484, '17491276486M2gRPEKjX.png', '2025-06-05 12:47:28', '2025-06-05 12:47:28'),
(959, 485, '1749127648iqPqEUtrem.png', '2025-06-05 12:47:28', '2025-06-05 12:47:28'),
(960, 485, '1749127648U5AmXBTad1.png', '2025-06-05 12:47:28', '2025-06-05 12:47:28'),
(961, 486, '1749127766e0WM9zctKo.png', '2025-06-05 12:49:26', '2025-06-05 12:49:26'),
(962, 486, '1749127766fivQcHZgIm.png', '2025-06-05 12:49:26', '2025-06-05 12:49:26'),
(963, 487, '17491277668FpzrOQxsP.png', '2025-06-05 12:49:26', '2025-06-05 12:49:26'),
(964, 487, '1749127766u2IszfkFdR.png', '2025-06-05 12:49:26', '2025-06-05 12:49:26'),
(965, 488, '1749127965ALcy1r4zYv.png', '2025-06-05 12:52:45', '2025-06-05 12:52:45'),
(966, 488, '17491279654B1fyZtHnQ.png', '2025-06-05 12:52:45', '2025-06-05 12:52:45'),
(967, 489, '1749127965jfxTS2z1mV.png', '2025-06-05 12:52:45', '2025-06-05 12:52:45'),
(968, 489, '1749127965GgmZlwqsND.png', '2025-06-05 12:52:45', '2025-06-05 12:52:45'),
(969, 490, '1749127965gIvock4W0n.png', '2025-06-05 12:52:45', '2025-06-05 12:52:45'),
(970, 490, '1749127965LewXwGqz7W.png', '2025-06-05 12:52:45', '2025-06-05 12:52:45'),
(971, 491, '1749128140AFAxLanKzs.png', '2025-06-05 12:55:40', '2025-06-05 12:55:40'),
(972, 491, '1749128140uG96xzArjT.png', '2025-06-05 12:55:40', '2025-06-05 12:55:40'),
(973, 492, '1749128140QG0fhigK2N.png', '2025-06-05 12:55:40', '2025-06-05 12:55:40'),
(974, 492, '1749128140BtK1WGSOzG.png', '2025-06-05 12:55:40', '2025-06-05 12:55:40'),
(975, 493, '1749128140ce0e2RwcVN.png', '2025-06-05 12:55:40', '2025-06-05 12:55:40'),
(976, 493, '1749128140uFWqHiMeIj.png', '2025-06-05 12:55:40', '2025-06-05 12:55:40'),
(977, 494, '1749128178wd3NN8bnt0.png', '2025-06-05 12:56:18', '2025-06-05 12:56:18'),
(978, 494, '1749128178B8O4m5Gyhu.png', '2025-06-05 12:56:18', '2025-06-05 12:56:18'),
(979, 495, '174912826506b5HIuYsl.png', '2025-06-05 12:57:45', '2025-06-05 12:57:45'),
(980, 495, '1749128265ohE90wGSuZ.png', '2025-06-05 12:57:45', '2025-06-05 12:57:45'),
(981, 496, '17497214425h37KvS9yF.png', '2025-06-12 09:44:02', '2025-06-12 09:44:02'),
(982, 496, '1749721442Jxp7v080YX.png', '2025-06-12 09:44:02', '2025-06-12 09:44:02'),
(983, 497, '1749721489RpuSLmoVKB.png', '2025-06-12 09:44:49', '2025-06-12 09:44:49'),
(984, 497, '1749721489spMe98PUHk.png', '2025-06-12 09:44:49', '2025-06-12 09:44:49'),
(985, 498, '1749721599mtUANv4tj6.png', '2025-06-12 09:46:39', '2025-06-12 09:46:39'),
(986, 498, '174972159948bZYVAPOt.png', '2025-06-12 09:46:39', '2025-06-12 09:46:39'),
(987, 499, '17497217794RPyAu4SGE.png', '2025-06-12 09:49:39', '2025-06-12 09:49:39'),
(988, 499, '1749721779YhbUL7Gq2I.png', '2025-06-12 09:49:39', '2025-06-12 09:49:39'),
(989, 500, '1750148672IGED2xe7YN.webp', '2025-06-17 08:24:32', '2025-06-17 08:24:32');

-- --------------------------------------------------------

--
-- Table structure for table `product_subcategories`
--

CREATE TABLE `product_subcategories` (
  `id` int NOT NULL,
  `category_id` int NOT NULL,
  `subcategory_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `color_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `available_quantity` int NOT NULL DEFAULT '0',
  `vto` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `photo_config_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`id`, `product_id`, `color_name`, `price`, `purchase_price`, `available_quantity`, `vto`, `photo_config_name`, `created_at`, `updated_at`) VALUES
(1, 1, 'blue', 250.00, 200.00, 40, '88978686986', 'test', '2025-05-23 14:42:33', '2025-05-23 14:42:33'),
(19, 10, 'Gold', 120.00, 110.00, 11, '882020007128', NULL, '2025-05-29 22:36:22', '2025-06-18 15:16:04'),
(20, 10, 'GUN', 130.00, 120.00, 21, '882020007135', NULL, '2025-05-29 22:36:22', '2025-06-18 15:16:04'),
(21, 11, 'Black', 120.00, 120.00, 12, '882020007166', NULL, '2025-05-30 00:57:27', '2025-06-10 13:51:07'),
(22, 11, 'BROWN', 120.00, 120.00, 12, '882020007173', NULL, '2025-05-30 00:57:27', '2025-06-10 13:51:07'),
(23, 12, 'BLUE', 120.00, 120.00, 12, '882020007197', NULL, '2025-05-30 01:00:10', '2025-06-10 13:51:27'),
(24, 12, 'BROWN', 220.00, 200.00, 22, '882020007227', NULL, '2025-05-30 01:00:10', '2025-06-10 13:51:27'),
(25, 13, 'Black', 200.00, 120.00, 22, '882020007494', NULL, '2025-05-30 01:03:57', '2025-06-10 13:51:53'),
(26, 14, 'Brown', 120.00, 120.00, 20, '882020007500', NULL, '2025-05-30 01:05:34', '2025-06-10 13:52:09'),
(28, 16, 'Matte Black Frame with Smoke Grey Lenses', 210.00, 120.00, 12, '712316000147', NULL, '2025-05-30 23:58:04', '2025-06-10 13:52:44'),
(29, 16, 'Matte Black Frame with Gradient Lenses', 210.00, 120.00, 122, '712316000185', NULL, '2025-05-30 23:58:04', '2025-06-10 13:52:44'),
(30, 16, 'Matte Black Frame with Smoke Green Lenses', 210.00, 120.00, 122, '712316000178', NULL, '2025-05-30 23:58:04', '2025-06-10 13:52:44'),
(31, 17, 'Matte Black Frame with Smoke yellow Lenses', 120.00, 120.00, 12, '712316000253', NULL, '2025-05-31 00:10:39', '2025-06-10 13:53:21'),
(32, 17, 'Matte Black Frame with Smoke black Lenses', 120.00, 120.00, 12, '712316000321', NULL, '2025-05-31 00:10:39', '2025-06-10 13:53:21'),
(33, 18, 'Black', 120.00, 120.00, 12, '712316000710', NULL, '2025-05-31 00:33:30', '2025-06-10 13:53:38'),
(34, 19, 'Matte Black Frame', 130.00, 120.00, 22, '712316002837', NULL, '2025-05-31 00:39:26', '2025-06-10 13:53:56'),
(35, 20, 'Matte Black with Silver Flash Lenses', 130.00, 120.00, 10, '712316002844', NULL, '2025-05-31 00:43:33', '2025-06-10 13:54:15'),
(36, 16, 'Gloss Demi Frame with Blue Mirror Lenses', 120.00, 150.00, 22, '712316002851', NULL, '2025-05-31 00:45:05', '2025-06-10 13:52:44'),
(37, 22, 'Kryptek® Neptune™Polarized Blue Mirror Lenses', 150.00, 120.00, 22, '712316002875', NULL, '2025-05-31 00:50:21', '2025-06-10 13:54:37'),
(38, 23, 'Black', 150.00, 120.00, 22, '712316002912', NULL, '2025-05-31 00:54:43', '2025-06-10 13:54:57'),
(39, 24, 'Matte Black Frame with Pale Yellow Shields', 130.00, 120.00, 22, '712316003001', NULL, '2025-05-31 01:02:49', '2025-06-10 13:55:26'),
(40, 24, 'Matte Black Frame with Smoke Black Lenses', 130.00, 120.00, 22, '712316003025', NULL, '2025-05-31 01:02:49', '2025-06-10 13:55:26'),
(41, 24, 'Matte Black Frame with Clear Lens', 130.00, 120.00, 22, '712316003032', NULL, '2025-05-31 01:02:49', '2025-06-10 13:55:26'),
(42, 24, 'Black', 130.00, 120.00, 22, '712316003148', NULL, '2025-05-31 01:02:49', '2025-06-10 13:55:26'),
(43, 25, 'Matte Graphite Frame with Blue Lenses', 130.00, 120.00, 22, '712316003490', NULL, '2025-05-31 01:10:33', '2025-06-10 13:55:43'),
(44, 25, 'Matte Demi', 130.00, 120.00, 12, '712316003506', NULL, '2025-05-31 01:10:33', '2025-06-10 13:55:43'),
(45, 26, 'Gloss Black Frame', 150.00, 120.00, 22, '712316003520', NULL, '2025-05-31 01:14:01', '2025-06-10 13:56:00'),
(46, 27, 'Gloss Demi Brown', 150.00, 120.00, 22, '712316003537', NULL, '2025-05-31 01:25:30', '2025-06-10 13:56:22'),
(47, 28, 'Matte Grey Frame', 120.00, 120.00, 21, '712316003544', NULL, '2025-06-01 19:16:33', '2025-06-18 09:02:03'),
(48, 19, 'Matte Black Frame with  Copper Lenses', 120.00, 220.00, 22, '712316003551', NULL, '2025-06-01 19:18:32', '2025-06-10 13:53:56'),
(49, 20, 'Matte Black', 120.00, 220.00, 22, '712316003568', NULL, '2025-06-01 19:21:33', '2025-06-10 13:54:15'),
(50, 29, 'Matte Black With Transparent Lenses', 130.00, 120.00, 22, '712316003575', NULL, '2025-06-01 19:26:18', '2025-06-10 13:56:55'),
(51, 29, 'Matte Black With Transparent Lenses', 220.00, 120.00, 11, '712316003582', NULL, '2025-06-01 19:26:18', '2025-06-10 13:56:55'),
(52, 25, 'Matte Black Frame with Smoke Grey Lenses', 120.00, 120.00, 22, '712316003599', NULL, '2025-06-01 19:27:18', '2025-06-10 13:55:43'),
(53, 26, 'Gloss Demi Brown', 120.00, 210.00, 22, '712316003735', NULL, '2025-06-01 19:28:10', '2025-06-10 13:56:00'),
(54, 26, 'Rose Gold Mirror Frame with Gloss Black', 120.00, 120.00, 22, '712316003742', NULL, '2025-06-01 19:29:13', '2025-06-10 13:56:00'),
(55, 27, 'Gloss Black Frame', 120.00, 120.00, 22, '712316003803', NULL, '2025-06-01 19:30:30', '2025-06-10 13:56:22'),
(56, 27, 'Crystal Blush Frame with Rose Gold Mirror', 120.00, 120.00, 220, '712316003810', NULL, '2025-06-01 19:30:30', '2025-06-10 13:56:22'),
(57, 30, 'Matte Graphite Frame', 120.00, 120.00, 22, '712316003919', NULL, '2025-06-01 19:33:38', '2025-06-10 13:57:11'),
(58, 31, 'Matte Black Frame with Smoke yellow Lenses', 120.00, 120.00, 22, '712316003957', NULL, '2025-06-01 19:39:51', '2025-06-10 13:57:25'),
(59, 16, 'Matte Black', 120.00, 120.00, 22, '712316003988', NULL, '2025-06-01 19:41:05', '2025-06-10 13:52:44'),
(60, 22, 'Matte Black Frame with Smoke Yellow Lenses', 120.00, 120.00, 22, '712316004015', NULL, '2025-06-01 19:42:37', '2025-06-10 13:54:37'),
(61, 33, 'Neptune™ Frame Polarized Green Mirror', 120.00, 120.00, 22, '712316004039', NULL, '2025-06-01 19:46:07', '2025-06-10 13:57:40'),
(62, 34, 'Gloss Black Frame Polarized Rose Gold Mirror', 120.00, 120.00, 22, '712316004091', NULL, '2025-06-01 19:50:43', '2025-06-10 13:57:56'),
(63, 34, 'Dark Crystal Purple Frame and Smoke Grey Lens', 120.00, 120.00, 22, '712316004107', NULL, '2025-06-01 19:50:43', '2025-06-10 13:57:56'),
(64, 34, 'Gloss Demi Frame Polarized Blue Mirror Lens', 120.00, 120.00, 22, '712316004114', NULL, '2025-06-01 19:50:43', '2025-06-10 13:57:56'),
(65, 35, 'Matte Black Frame with Smoke Grey Lenses', 124.00, 120.00, 12, '712316004183', NULL, '2025-06-01 20:06:26', '2025-06-10 13:58:10'),
(66, 35, 'Matte Black Frame with Clear Lenses', 122.00, 122.00, 12, '712316004190', NULL, '2025-06-01 20:06:26', '2025-06-10 13:58:10'),
(67, 35, 'Sky Texture Frame with Smoke Blue Lenses', 120.00, 120.00, 24, '712316004206', NULL, '2025-06-01 20:06:26', '2025-06-10 13:58:10'),
(68, 35, 'Brown Texture Frame with Smoke Yellow Lenses', 120.00, 120.00, 21, '712316004213', NULL, '2025-06-01 20:06:26', '2025-06-10 13:58:10'),
(69, 22, 'Matte Black Frame with Smoke Purple Lenses', 120.00, 120.00, 22, '712316004411', NULL, '2025-06-01 20:07:34', '2025-06-10 13:54:37'),
(70, 33, 'Matte Black Frame Polarized Smoked Mirror', 120.00, 120.00, 22, '712316004435', NULL, '2025-06-01 20:09:36', '2025-06-10 13:57:40'),
(71, 33, 'Matte Black Frame Polarized Smoked Blue Mirror', 120.00, 120.00, 22, '712316004947', NULL, '2025-06-01 20:09:36', '2025-06-10 13:57:40'),
(72, 36, 'Gloss Black Frame with Polarized Blue Mirror', 150.00, 120.00, 22, '712316004961', NULL, '2025-06-01 20:34:13', '2025-06-10 13:58:24'),
(73, 30, 'Matte Graphite Frame', 150.00, 120.00, 22, '712316004985', NULL, '2025-06-01 20:36:19', '2025-06-10 13:57:11'),
(74, 31, 'Matte Black Frame with Smoke Black Lenses', 120.00, 120.00, 22, '712316005401', NULL, '2025-06-01 20:38:26', '2025-06-10 13:57:25'),
(75, 31, 'Brown Frame with Smoke Black Lenses', 120.00, 100.00, 22, '712316005418', NULL, '2025-06-01 20:38:26', '2025-06-10 13:57:25'),
(76, 37, 'Silver Flash Lens/Matte Graphite Frame', 100.00, 120.00, 22, '712316005470', NULL, '2025-06-01 20:44:54', '2025-06-10 13:58:39'),
(77, 37, 'Orange Flash Lens/Matte Graphite Frame', 200.00, 120.00, 22, '712316005487', NULL, '2025-06-01 20:44:54', '2025-06-10 13:58:39'),
(78, 30, 'Brown', 120.00, 120.00, 12, '712316005579', NULL, '2025-06-01 20:46:19', '2025-06-10 13:57:11'),
(79, 38, 'Matte Black with Smoke Pink Lenses', 200.00, 120.00, 22, '712316005753', NULL, '2025-06-01 20:52:29', '2025-06-10 13:58:58'),
(80, 38, 'Matte Woodgrain Polarized Blue Mirror Lenses', 120.00, 200.00, 21, '712316005760', NULL, '2025-06-01 20:52:29', '2025-06-10 13:58:58'),
(81, 38, 'Matte Black with Smoke Grey Lenses', 120.00, 220.00, 23, '712316005777', NULL, '2025-06-01 20:52:29', '2025-06-10 13:58:58'),
(82, 38, 'Matte Slate Frame Polarized Blue Mirror', 120.00, 120.00, 22, '712316005784', NULL, '2025-06-01 20:52:29', '2025-06-10 13:58:58'),
(83, 39, 'Matte Black Frame with Smoke Blue Lenses', 150.00, 120.00, 21, '712316005906', NULL, '2025-06-02 08:05:34', '2025-06-10 13:59:13'),
(84, 39, 'Gloss Black Frame with Bronze Mirror Lenses', 150.00, 120.00, 22, '712316005913', NULL, '2025-06-02 08:05:34', '2025-06-10 13:59:13'),
(85, 39, 'loss Demi Frame Green Mirror Lenses', 220.00, 200.00, 22, '712316005920', NULL, '2025-06-02 08:05:34', '2025-06-10 13:59:13'),
(86, 39, 'Matte Black Frame with Smoke Grey Lenses', 220.00, 220.00, 22, '712316005937', NULL, '2025-06-02 08:05:34', '2025-06-10 13:59:13'),
(87, 19, 'Matte Black', 220.00, 250.00, 22, '712316006156', NULL, '2025-06-02 08:07:15', '2025-06-10 13:53:56'),
(88, 16, 'Matte Black', 120.00, 200.00, 22, '712316006323', NULL, '2025-06-02 08:29:06', '2025-06-10 13:52:44'),
(89, 16, 'lack Crystal', 120.00, 200.00, 22, '712316006347', NULL, '2025-06-02 08:29:07', '2025-06-10 13:52:44'),
(90, 28, 'Black Frame with Smoke Lenses', 120.00, 150.00, 22, '712316006408', NULL, '2025-06-02 08:48:41', '2025-06-18 09:02:03'),
(91, 31, 'Matte Black Frame with Polorized Lenses', 120.00, 250.00, 22, '712316006422', NULL, '2025-06-02 09:05:11', '2025-06-10 13:57:25'),
(92, 30, 'Matte Graphite Frame', 120.00, 200.00, 22, '712316006446', NULL, '2025-06-02 09:06:08', '2025-06-10 13:57:11'),
(93, 40, 'Gloss Crystal Light Olive', 200.00, 120.00, 22, '712316006804', NULL, '2025-06-02 09:10:21', '2025-06-10 13:59:28'),
(94, 40, 'Gloss Crystal Light Olive Frame', 120.00, 20.00, 22, '712316006835', NULL, '2025-06-02 09:10:21', '2025-06-10 13:59:28'),
(95, 40, 'Matte Black', 120.00, 120.00, 22, '712316007504', NULL, '2025-06-02 09:10:21', '2025-06-10 13:59:28'),
(97, 42, 'Matte Havana Brown', 200.00, 120.00, 20, '712316007283', NULL, '2025-06-02 09:14:26', '2025-06-10 13:59:42'),
(98, 42, 'Gloss Crystal Light Grey', 200.00, 120.00, 20, '712316007313', NULL, '2025-06-02 09:14:26', '2025-06-10 13:59:42'),
(99, 42, 'Gloss Crystal Light Grey', 200.00, 120.00, 22, '712316007337', NULL, '2025-06-02 09:14:26', '2025-06-10 13:59:42'),
(100, 42, 'Matte Black', 220.00, 200.00, 22, '712316007498', NULL, '2025-06-02 09:14:26', '2025-06-10 13:59:42'),
(101, 19, 'Matte Black', 220.00, 220.00, 22, '712316007573', NULL, '2025-06-02 09:15:16', '2025-06-10 13:53:56'),
(102, 43, 'Matte Black', 220.00, 200.00, 22, '712316007597', NULL, '2025-06-02 09:20:52', '2025-06-10 13:59:59'),
(103, 43, 'Matte Black', 200.00, 120.00, 22, '712316007603', NULL, '2025-06-02 09:20:52', '2025-06-10 13:59:59'),
(104, 43, 'Matte Grey', 220.00, 120.00, 22, '712316007610', NULL, '2025-06-02 09:20:52', '2025-06-10 13:59:59'),
(105, 43, 'Matte Black', 150.00, 120.00, 22, '712316007627', NULL, '2025-06-02 09:20:52', '2025-06-10 13:59:59'),
(106, 44, 'Black', 220.00, 120.00, 22, '712316007917', NULL, '2025-06-02 09:25:07', '2025-06-10 14:00:12'),
(107, 44, 'Black', 250.00, 220.00, 22, '712316009935', NULL, '2025-06-02 09:25:07', '2025-06-10 14:00:12'),
(108, 44, 'Black', 250.00, 120.00, 22, '712316009942', NULL, '2025-06-02 09:25:07', '2025-06-10 14:00:12'),
(109, 44, 'Black', 200.00, 120.00, 22, '712316010115', NULL, '2025-06-02 09:25:07', '2025-06-10 14:00:12'),
(110, 44, 'Black', 150.00, 120.00, 22, '712316010122', NULL, '2025-06-02 09:25:07', '2025-06-10 14:00:12'),
(111, 45, 'Matte Black Frame with Clear Lenses', 120.00, 120.00, 21, '712316008228', NULL, '2025-06-02 09:29:30', '2025-06-10 14:00:38'),
(112, 45, 'Matte Grey', 120.00, 120.00, 22, '712316008235', NULL, '2025-06-02 09:29:30', '2025-06-10 14:00:38'),
(113, 45, 'Matte Black', 220.00, 200.00, 22, '712316008242', NULL, '2025-06-02 09:29:30', '2025-06-10 14:00:38'),
(114, 45, 'Matte Grey Frame Polarized Blue Mirror', 200.00, 120.00, 22, '712316008259', NULL, '2025-06-02 09:29:30', '2025-06-10 14:00:38'),
(115, 22, 'Black', 120.00, 200.00, 22, '712316008372', NULL, '2025-06-02 09:30:24', '2025-06-10 13:54:37'),
(116, 46, 'Black', 120.00, 120.00, 22, '712316010047', NULL, '2025-06-02 09:34:01', '2025-06-10 14:01:00'),
(117, 46, 'Black', 120.00, 120.00, 22, '712316010061', NULL, '2025-06-02 09:34:01', '2025-06-10 14:01:00'),
(118, 33, 'Matte Black', 120.00, 120.00, 22, '712316010627', NULL, '2025-06-02 09:37:04', '2025-06-10 13:57:40'),
(119, 33, 'Matte Black', 120.00, 120.00, 22, '712316010641', NULL, '2025-06-02 09:37:56', '2025-06-10 13:57:40'),
(120, 33, 'Matte Black', 120.00, 120.00, 12, '712316010665', NULL, '2025-06-02 09:37:56', '2025-06-10 13:57:40'),
(122, 48, 'Matte Black Frame w/Clear, Smoke Green Lenses', 120.00, 120.00, 22, '712316010832', NULL, '2025-06-02 09:42:40', '2025-06-10 14:29:31'),
(123, 48, 'Matte Black Frame w/Clear, Smoke Lenses', 120.00, 120.00, 22, '712316011358', NULL, '2025-06-02 09:42:40', '2025-06-10 14:29:31'),
(124, 48, 'Matte Black Frame w/Clear, Smoke black Lenses', 150.00, 120.00, 22, '712316011389', NULL, '2025-06-02 09:42:40', '2025-06-10 14:29:31'),
(125, 49, 'Black', 120.00, 120.00, 22, '712316010894', NULL, '2025-06-02 09:45:48', '2025-06-10 14:29:53'),
(126, 51, 'Matte Black Frame with Smoke Grey Lenses', 120.00, 120.00, 22, '712316010993', NULL, '2025-06-02 10:56:44', '2025-06-10 14:30:13'),
(127, 51, 'Matte Black Frame Yellow Lenses', 200.00, 125.00, 22, '712316011051', NULL, '2025-06-02 10:56:44', '2025-06-10 14:30:13'),
(128, 51, 'Matte Black Frame Smoke Grey Lenses', 120.00, 120.00, 22, '712316011112', NULL, '2025-06-02 10:56:44', '2025-06-10 14:30:13'),
(129, 33, 'Matte Black', 120.00, 120.00, 22, '712316011136', NULL, '2025-06-02 10:59:37', '2025-06-10 13:57:40'),
(130, 28, 'Matte Grey Frame', 120.00, 120.00, 12, '712316011587', NULL, '2025-06-02 11:00:25', '2025-06-18 09:02:03'),
(131, 52, 'Black', 120.00, 120.00, 22, '712316011662', NULL, '2025-06-02 11:02:43', '2025-06-10 14:30:28'),
(132, 51, 'Matte Black Frame Smoke Green Lenses', 120.00, 120.00, 22, '712316011686', NULL, '2025-06-02 11:04:14', '2025-06-10 14:30:13'),
(133, 53, 'Matte Black Frame with Smoke Grey / Clear Lenses', 120.00, 120.00, 18, '712316011747', NULL, '2025-06-02 11:06:38', '2025-06-10 14:30:44'),
(134, 33, 'Black', 1201.00, 120.00, 12, '712316012034', NULL, '2025-06-02 11:09:23', '2025-06-10 13:57:40'),
(135, 54, 'Black', 120.00, 120.00, 12, '712316012164', NULL, '2025-06-02 11:11:35', '2025-06-10 14:30:59'),
(136, 48, 'Matte Black Frame w/Clear, Smoke black Lenses', 49.00, 56.00, 22, '712316012539', NULL, '2025-06-02 11:13:36', '2025-06-10 14:29:31'),
(137, 55, 'Black', 120.00, 120.00, 22, '712316012782', NULL, '2025-06-02 14:07:41', '2025-06-10 14:31:21'),
(138, 55, 'Black and Brown with Yellow Lenses', 130.00, 120.00, 12, '712316012799', NULL, '2025-06-02 14:07:41', '2025-06-10 14:31:21'),
(139, 55, 'Matte Black with Blue Lense', 130.00, 120.00, 22, '712316012805', NULL, '2025-06-02 14:07:41', '2025-06-10 14:31:21'),
(140, 19, 'Black', 120.00, 120.00, 22, '712316013017', NULL, '2025-06-02 14:08:46', '2025-06-10 13:53:56'),
(141, 19, 'Black', 120.00, 130.00, 22, '712316013031', NULL, '2025-06-02 14:08:46', '2025-06-10 13:53:56'),
(142, 16, 'Brown', 210.00, 220.00, 22, '712316013048', NULL, '2025-06-02 14:09:29', '2025-06-10 13:52:44'),
(143, 56, 'Black', 130.00, 120.00, 22, '712316013413', NULL, '2025-06-02 14:12:33', '2025-06-10 14:31:37'),
(144, 56, 'Black & Blue', 130.00, 120.00, 22, '712316013420', NULL, '2025-06-02 14:12:33', '2025-06-10 14:31:37'),
(145, 57, 'Pink', 130.00, 120.00, 22, '712316013475', NULL, '2025-06-02 14:17:47', '2025-06-10 14:31:52'),
(146, 57, 'Blue', 130.00, 120.00, 12, '712316013482', NULL, '2025-06-02 14:17:47', '2025-06-10 14:31:52'),
(147, 57, 'Black', 130.00, 120.00, 22, '712316013499', NULL, '2025-06-02 14:17:47', '2025-06-10 14:31:52'),
(148, 57, 'Black & Blue', 130.00, 120.00, 22, '712316013505', NULL, '2025-06-02 14:17:47', '2025-06-10 14:31:52'),
(149, 58, 'Silver', 130.00, 120.00, 22, '712316013598', NULL, '2025-06-02 14:23:28', '2025-06-10 14:32:07'),
(150, 58, 'Black & Green', 130.00, 120.00, 22, '712316013604', NULL, '2025-06-02 14:23:28', '2025-06-10 14:32:07'),
(151, 58, 'Black & White', 130.00, 120.00, 22, '712316013611', NULL, '2025-06-02 14:23:28', '2025-06-10 14:32:07'),
(152, 58, 'Black & Orange', 130.00, 120.00, 22, '712316013628', NULL, '2025-06-02 14:23:28', '2025-06-10 14:32:07'),
(153, 59, 'Blue', 130.00, 120.00, 22, '712316013710', NULL, '2025-06-02 14:27:37', '2025-06-10 14:32:22'),
(154, 59, 'Silver', 130.00, 120.00, 22, '712316013727', NULL, '2025-06-02 14:27:37', '2025-06-10 14:32:22'),
(155, 57, 'Silver', 120.00, 130.00, 22, '712316013826', NULL, '2025-06-02 14:29:09', '2025-06-10 14:31:52'),
(156, 31, 'Black', 120.00, 120.00, 22, '712316015028', NULL, '2025-06-02 14:30:22', '2025-06-10 13:57:25'),
(157, 30, 'Black', 120.00, 130.00, 22, '712316015035', NULL, '2025-06-02 14:31:44', '2025-06-10 13:57:11'),
(158, 30, 'Black', 120.00, 112.00, 22, '712316015042', NULL, '2025-06-02 14:31:44', '2025-06-10 13:57:11'),
(159, 37, 'Black', 120.00, 120.00, 22, '712316015059', NULL, '2025-06-02 14:32:29', '2025-06-10 13:58:39'),
(160, 60, 'Black', 210.00, 200.00, 22, '712316030113', NULL, '2025-06-02 14:34:41', '2025-06-10 14:32:38'),
(161, 61, 'Black', 120.00, 120.00, 30, '712316060042', NULL, '2025-06-02 14:39:04', '2025-06-10 14:32:55'),
(162, 61, 'Brown', 120.00, 120.00, 30, '712316060059', NULL, '2025-06-02 14:39:04', '2025-06-10 14:32:55'),
(163, 61, 'Black & Greem', 120.00, 120.00, 22, '712316060066', NULL, '2025-06-02 14:39:04', '2025-06-10 14:32:55'),
(164, 51, 'Black', 120.00, 120.00, 12, '712316060851', NULL, '2025-06-02 18:59:10', '2025-06-10 14:30:13'),
(165, 62, 'Black', 122.00, 122.00, 10, '712316061391', NULL, '2025-06-02 19:05:39', '2025-06-10 14:33:17'),
(166, 62, 'Black', 122.00, 122.00, 12, '712316061407', NULL, '2025-06-02 19:05:39', '2025-06-10 14:33:17'),
(167, 62, 'Brown', 122.00, 122.00, 0, '712316061414', NULL, '2025-06-02 19:05:39', '2025-06-10 14:33:17'),
(168, 62, 'Sky Blue', 122.00, 122.00, 12, '712316061421', NULL, '2025-06-02 19:05:39', '2025-06-10 14:33:17'),
(169, 63, 'Black', 120.00, 120.00, 22, '712316061445', NULL, '2025-06-02 19:22:40', '2025-06-10 14:33:33'),
(170, 63, 'Dark Brown', 120.00, 120.00, 12, '712316061452', NULL, '2025-06-02 19:22:40', '2025-06-10 14:33:33'),
(171, 63, 'Brown', 120.00, 120.00, 22, '712316061469', NULL, '2025-06-02 19:22:40', '2025-06-10 14:33:33'),
(172, 63, 'Black', 120.00, 120.00, 11, '712316061476', NULL, '2025-06-02 19:22:40', '2025-06-10 14:33:33'),
(173, 64, 'Dark Brown', 120.00, 120.00, 22, '712316061490', NULL, '2025-06-02 19:26:53', '2025-06-10 14:33:47'),
(174, 64, 'Light Brown', 120.00, 120.00, 22, '712316061506', NULL, '2025-06-02 19:26:53', '2025-06-10 14:33:47'),
(175, 64, 'Black', 120.00, 120.00, 22, '712316061513', NULL, '2025-06-02 19:26:53', '2025-06-10 14:33:47'),
(176, 64, 'Black', 120.00, 120.00, 22, '712316061520', NULL, '2025-06-02 19:26:53', '2025-06-10 14:33:47'),
(177, 20, 'Black', 120.00, 120.00, 21, '712316061544', NULL, '2025-06-02 19:28:06', '2025-06-10 13:54:15'),
(178, 20, 'Black', 120.00, 120.00, 22, '712316061551', NULL, '2025-06-02 19:28:06', '2025-06-10 13:54:15'),
(179, 65, 'Pruple & Black', 120.00, 120.00, 12, '712316061568', NULL, '2025-06-02 19:32:03', '2025-06-10 14:34:06'),
(180, 65, 'Black', 120.00, 120.00, 22, '712316061575', NULL, '2025-06-02 19:32:03', '2025-06-10 14:34:06'),
(181, 22, 'Black', 120.00, 120.00, 22, '712316061605', NULL, '2025-06-02 19:33:30', '2025-06-10 13:54:37'),
(182, 22, 'Black', 120.00, 120.00, 11, '712316061612', NULL, '2025-06-02 19:33:30', '2025-06-10 13:54:37'),
(183, 66, 'Black', 120.00, 120.00, 21, '712316061650', NULL, '2025-06-02 19:37:14', '2025-06-10 14:34:18'),
(184, 20, 'Black', 120.00, 120.00, 12, '712316061797', NULL, '2025-06-02 19:48:22', '2025-06-10 13:54:15'),
(185, 20, 'Black', 120.00, 120.00, 12, '712316061803', NULL, '2025-06-02 19:48:22', '2025-06-10 13:54:15'),
(186, 48, 'Black', 120.00, 120.00, 12, '712316063593', NULL, '2025-06-02 19:49:18', '2025-06-10 14:29:31'),
(187, 48, 'Black', 120.00, 120.00, 12, '712316063609', NULL, '2025-06-02 19:49:18', '2025-06-10 14:29:31'),
(188, 36, 'Black', 120.00, 120.00, 22, '712316066907', NULL, '2025-06-02 19:50:57', '2025-06-10 13:58:24'),
(189, 36, 'Black', 120.00, 120.00, 11, '712316066983', NULL, '2025-06-02 19:50:57', '2025-06-10 13:58:24'),
(190, 36, 'Black', 120.00, 120.00, 12, '712316066990', NULL, '2025-06-02 19:50:57', '2025-06-10 13:58:24'),
(191, 36, 'Black', 120.00, 120.00, 12, '712316067126', NULL, '2025-06-02 19:50:57', '2025-06-10 13:58:24'),
(192, 28, 'Black', 120.00, 120.00, 12, '712316068192', NULL, '2025-06-02 19:51:47', '2025-06-18 09:02:03'),
(193, 28, 'Black', 120.00, 120.00, 12, '712316068208', NULL, '2025-06-02 19:51:47', '2025-06-18 09:02:03'),
(194, 29, 'Black', 120.00, 120.00, 12, '712316068550', NULL, '2025-06-02 19:53:24', '2025-06-10 13:56:55'),
(195, 29, 'Black', 120.00, 120.00, 22, '712316068581', NULL, '2025-06-02 19:53:24', '2025-06-10 13:56:55'),
(196, 29, 'Black', 120.00, 120.00, 12, '712316068598', NULL, '2025-06-02 19:53:24', '2025-06-10 13:56:55'),
(197, 29, 'Black', 120.00, 120.00, 12, '712316068604', NULL, '2025-06-02 19:53:24', '2025-06-10 13:56:55'),
(198, 22, 'Grey', 120.00, 120.00, 12, '712316124003', NULL, '2025-06-02 19:54:09', '2025-06-10 13:54:37'),
(199, 51, 'Grey', 120.00, 120.00, 12, '712316124027', NULL, '2025-06-02 19:54:45', '2025-06-10 14:30:13'),
(200, 20, 'Yellow', 120.00, 120.00, 12, '712316124041', NULL, '2025-06-02 19:55:18', '2025-06-10 13:54:15'),
(201, 67, 'Black', 120.00, 120.00, 12, '712316124065', NULL, '2025-06-02 20:10:47', '2025-06-10 14:34:31'),
(202, 67, 'Black', 120.00, 120.00, 12, '712316124072', NULL, '2025-06-02 20:10:47', '2025-06-10 14:34:31'),
(203, 67, 'Black', 120.00, 120.00, 22, '712316124089', NULL, '2025-06-02 20:10:47', '2025-06-10 14:34:31'),
(204, 68, 'Black', 120.00, 120.00, 12, '712316124164', NULL, '2025-06-02 20:19:58', '2025-06-10 14:34:45'),
(205, 68, 'Black', 120.00, 120.00, 12, '712316124171', NULL, '2025-06-02 20:19:58', '2025-06-10 14:34:45'),
(206, 68, 'Black', 120.00, 120.00, 19, '712316124195', NULL, '2025-06-02 20:19:58', '2025-06-10 14:34:45'),
(207, 69, 'Black', 120.00, 120.00, 20, '712316124270', NULL, '2025-06-02 20:23:17', '2025-06-10 14:35:01'),
(208, 70, 'Black', 120.00, 120.00, 12, '712316124393', NULL, '2025-06-02 20:26:41', '2025-06-10 14:35:19'),
(209, 70, 'Black', 120.00, 120.00, 22, '712316124416', NULL, '2025-06-02 20:26:41', '2025-06-10 14:35:19'),
(210, 70, 'Black', 120.00, 120.00, 12, '712316124430', NULL, '2025-06-02 20:26:41', '2025-06-10 14:35:19'),
(211, 22, 'Black', 120.00, 120.00, 22, '712316124546', NULL, '2025-06-02 20:27:48', '2025-06-10 13:54:37'),
(212, 22, 'Black', 120.00, 120.00, 22, '712316124560', NULL, '2025-06-02 20:27:48', '2025-06-10 13:54:37'),
(213, 48, 'Black', 120.00, 120.00, 20, '712316124584', NULL, '2025-06-02 20:28:26', '2025-06-10 14:29:31'),
(214, 71, 'Black', 120.00, 120.00, 22, '712316124591', NULL, '2025-06-02 20:32:39', '2025-06-10 14:35:37'),
(215, 71, 'Black', 120.00, 120.00, 22, '712316124621', NULL, '2025-06-02 20:32:39', '2025-06-10 14:35:37'),
(216, 71, 'Black', 120.00, 120.00, 22, '712316124638', NULL, '2025-06-02 20:32:39', '2025-06-10 14:35:37'),
(217, 72, 'Silver', 130.00, 120.00, 22, '712316124669', NULL, '2025-06-02 20:36:33', '2025-06-10 14:35:50'),
(218, 72, 'Silver', 130.00, 120.00, 12, '712316124690', NULL, '2025-06-02 20:36:33', '2025-06-10 14:35:50'),
(219, 72, 'Golden', 120.00, 120.00, 12, '712316124720', NULL, '2025-06-02 20:36:33', '2025-06-10 14:35:50'),
(220, 73, 'Black', 120.00, 120.00, 22, '712316124751', NULL, '2025-06-02 20:42:51', '2025-06-10 14:36:08'),
(221, 73, 'Silver', 120.00, 120.00, 22, '712316124782', NULL, '2025-06-02 20:42:51', '2025-06-10 14:36:08'),
(222, 73, 'Golden', 120.00, 120.00, 22, '712316124812', NULL, '2025-06-02 20:42:51', '2025-06-10 14:36:08'),
(223, 74, 'Black', 120.00, 120.00, 22, '712316124843', NULL, '2025-06-02 20:58:35', '2025-06-10 14:36:29'),
(224, 74, 'Brown', 120.00, 120.00, 22, '712316124898', NULL, '2025-06-02 20:58:35', '2025-06-10 14:36:29'),
(225, 74, 'Black', 120.00, 120.00, 22, '712316124928', NULL, '2025-06-02 20:58:35', '2025-06-10 14:36:29'),
(226, 75, 'Black', 120.00, 120.00, 30, '712316124997', NULL, '2025-06-02 21:02:59', '2025-06-10 14:36:51'),
(227, 75, 'Black', 120.00, 120.00, 12, '712316125024', NULL, '2025-06-02 21:02:59', '2025-06-10 14:36:51'),
(228, 75, 'Black', 120.00, 120.00, 118, '712316125055', NULL, '2025-06-02 21:02:59', '2025-06-10 14:36:51'),
(229, 76, 'Black', 120.00, 120.00, 22, '712316125079', NULL, '2025-06-02 21:04:59', '2025-06-10 14:37:08'),
(230, 76, 'Brown', 120.00, 120.00, 12, '712316125109', NULL, '2025-06-02 21:05:29', '2025-06-10 14:37:08'),
(231, 67, 'Green', 120.00, 120.00, 2, '712316125222', NULL, '2025-06-02 21:06:09', '2025-06-10 14:34:31'),
(232, 16, 'Black', 120.00, 120.00, 22, '712316000147', NULL, '2025-06-02 21:06:41', '2025-06-10 13:52:44'),
(233, 29, 'Black', 120.00, 120.00, 12, '712316003575', NULL, '2025-06-02 21:08:20', '2025-06-10 13:56:55'),
(234, 33, 'Black', 120.00, 120.00, 22, '712316011136', NULL, '2025-06-02 21:09:38', '2025-06-10 13:57:40'),
(235, 33, 'Black', 120.00, 120.00, 22, '712316012034', NULL, '2025-06-02 21:09:38', '2025-06-10 13:57:40'),
(236, 40, 'Black', 120.00, 120.00, 12, '712316090599', NULL, '2025-06-02 21:13:12', '2025-06-10 13:59:28'),
(237, 77, 'White', 120.00, 120.00, 22, '712316091404', NULL, '2025-06-02 21:15:33', '2025-06-10 14:37:33'),
(238, 78, 'NAVY', 120.00, 120.00, 22, '781096558162', NULL, '2025-06-02 21:21:00', '2025-06-10 19:12:30'),
(239, 78, 'Brown', 120.00, 120.00, 22, '781096558179', NULL, '2025-06-02 21:21:00', '2025-06-10 19:12:30'),
(240, 79, 'Black', 120.00, 120.00, 20, '3700893826912', NULL, '2025-06-02 21:25:42', '2025-06-10 19:13:02'),
(241, 79, 'Pink', 120.00, 120.00, 22, '3700893826929', NULL, '2025-06-02 21:25:42', '2025-06-10 19:13:02'),
(242, 79, 'Red', 120.00, 120.00, 120, '3700893826936', NULL, '2025-06-02 21:25:42', '2025-06-10 19:13:02'),
(243, 80, 'Black', 120.00, 120.00, 20, '5055022610404', NULL, '2025-06-02 21:29:11', '2025-06-10 19:13:33'),
(244, 80, 'Black', 120.00, 120.00, 20, '5055022610428', NULL, '2025-06-02 21:29:11', '2025-06-10 19:13:33'),
(245, 81, 'Silver', 120.00, 120.00, 22, '738921578956', NULL, '2025-06-02 21:32:07', '2025-06-10 19:13:52'),
(246, 81, 'Brown', 120.00, 120.00, 22, '738921579021', NULL, '2025-06-02 21:32:07', '2025-06-10 19:13:52'),
(247, 82, 'Silver', 120.00, 120.00, 22, '662827040319', NULL, '2025-06-03 16:17:38', '2025-06-10 19:14:09'),
(248, 83, 'Brown', 120.00, 120.00, 12, '662827049718', NULL, '2025-06-03 16:23:47', '2025-06-10 19:14:27'),
(249, 83, 'Black', 120.00, 102.00, 122, '662827049732', NULL, '2025-06-03 16:23:47', '2025-06-10 19:14:27'),
(250, 84, 'Brown', 120.00, 120.00, 22, '662827049794', NULL, '2025-06-03 16:29:37', '2025-06-10 19:14:45'),
(251, 84, 'Black', 120.00, 120.00, 20, '662827049817', NULL, '2025-06-03 16:29:37', '2025-06-10 19:14:45'),
(252, 85, 'Brown', 120.00, 10.00, 22, '662827050806', NULL, '2025-06-03 19:19:24', '2025-06-10 19:15:09'),
(253, 85, 'Gun', 120.00, 120.00, 22, '662827050813', NULL, '2025-06-03 19:19:24', '2025-06-10 19:15:09'),
(254, 86, 'Brown', 120.00, 120.00, 22, '662827050950', NULL, '2025-06-03 19:25:02', '2025-06-10 19:15:25'),
(255, 86, 'Black', 120.00, 120.00, 22, '662827050981', NULL, '2025-06-03 19:25:02', '2025-06-10 19:15:25'),
(256, 87, 'Brown', 120.00, 120.00, 22, '662827051018', NULL, '2025-06-03 19:28:19', '2025-06-10 19:15:42'),
(257, 87, 'Black', 120.00, 120.00, 22, '662827051025', NULL, '2025-06-03 19:28:19', '2025-06-10 19:15:42'),
(258, 88, 'Brown', 120.00, 120.00, 12, '662827051223', NULL, '2025-06-03 19:30:56', '2025-06-10 19:16:03'),
(259, 88, 'Black', 120.00, 120.00, 22, '662827051254', NULL, '2025-06-03 19:30:56', '2025-06-10 19:16:03'),
(260, 89, 'Brown', 120.00, 120.00, 22, '662827051261', NULL, '2025-06-03 19:34:06', '2025-06-10 19:16:20'),
(261, 89, 'Black', 120.00, 120.00, 22, '662827051278', NULL, '2025-06-03 19:34:06', '2025-06-10 19:16:20'),
(262, 90, 'Black', 120.00, 120.00, 22, '662827051315', NULL, '2025-06-03 19:37:28', '2025-06-10 19:16:38'),
(263, 90, 'Brown', 120.00, 120.00, 22, '662827051322', NULL, '2025-06-03 19:37:28', '2025-06-10 19:16:38'),
(264, 91, 'Rose Gold', 100.00, 120.00, 22, '8435304386802', NULL, '2025-06-03 19:47:01', '2025-06-10 19:16:57'),
(265, 91, 'Black Bronze', 120.00, 120.00, 22, '8435304386826', NULL, '2025-06-03 19:47:01', '2025-06-10 19:16:57'),
(266, 91, 'Gold', 120.00, 120.00, 22, '8435304386840', NULL, '2025-06-03 19:47:01', '2025-06-10 19:16:57'),
(267, 91, 'Black', 120.00, 120.00, 22, '8435304386864', NULL, '2025-06-03 19:47:01', '2025-06-10 19:16:57'),
(268, 92, 'Black', 120.00, 120.00, 22, '10164469339', NULL, '2025-06-03 19:50:27', '2025-06-10 19:33:58'),
(269, 93, 'Black', 120.00, 120.00, 22, '10164486954', NULL, '2025-06-03 19:52:43', '2025-06-10 19:34:37'),
(270, 94, 'Black', 120.00, 120.00, 22, '10164525097', NULL, '2025-06-03 19:54:48', '2025-06-10 19:35:05'),
(271, 95, 'Matte Navy', 120.00, 120.00, 22, '10164542841', NULL, '2025-06-03 19:57:28', '2025-06-10 19:35:26'),
(272, 96, 'White', 120.00, 120.00, 22, '10164554264', NULL, '2025-06-03 19:59:06', '2025-06-10 19:35:51'),
(273, 97, 'Black', 120.00, 120.00, 12, '10164598862', NULL, '2025-06-03 20:00:36', '2025-06-10 19:36:14'),
(274, 98, 'White', 120.00, 120.00, 22, '5055022674246', NULL, '2025-06-03 20:02:11', '2025-06-10 19:36:38'),
(275, 99, 'Brown', 120.00, 120.00, 22, '10164519485', NULL, '2025-06-03 20:04:14', '2025-06-10 19:43:37'),
(276, 100, 'White', 120.00, 120.00, 20, '819253024721', NULL, '2025-06-03 20:06:45', '2025-06-10 19:47:28'),
(277, 101, 'Black', 120.00, 120.00, 22, '4222110262420', NULL, '2025-06-03 20:08:24', '2025-06-10 19:47:49'),
(278, 102, 'Blue', 120.00, 120.00, 22, '9398216741', NULL, '2025-06-03 20:10:48', '2025-06-10 19:48:47'),
(279, 102, 'Red&Black', 120.00, 120.00, 22, '9398217441', NULL, '2025-06-03 20:10:49', '2025-06-10 19:48:47'),
(280, 103, 'Light Brown', 120.00, 120.00, 120, '889214384744', NULL, '2025-06-03 20:14:10', '2025-06-10 19:49:11'),
(281, 104, 'GREY', 120.00, 120.00, 12, '796835176835', NULL, '2025-06-03 20:16:00', '2025-06-10 19:49:28'),
(282, 105, 'Black', 120.00, 120.00, 22, '738921578994', NULL, '2025-06-03 20:17:40', '2025-06-10 19:49:42'),
(283, 106, 'Black', 120.00, 120.00, 20, '738921578994', NULL, '2025-06-03 21:31:40', '2025-06-10 19:49:59'),
(284, 107, 'Black', 120.00, 120.00, 22, '662827051933', NULL, '2025-06-03 21:43:29', '2025-06-10 19:50:12'),
(285, 108, 'Black', 120.00, 120.00, 22, '662827052336', NULL, '2025-06-03 21:45:10', '2025-06-10 19:50:33'),
(286, 109, 'Metallic Brown', 120.00, 120.00, 22, '662827053807', NULL, '2025-06-03 21:47:16', '2025-06-10 19:50:47'),
(287, 109, 'Black', 120.00, 120.00, 22, '662827053814', NULL, '2025-06-03 21:47:16', '2025-06-10 19:50:47'),
(288, 110, 'Black', 120.00, 120.00, 52, '662827053913', NULL, '2025-06-03 23:00:07', '2025-06-10 19:51:02'),
(289, 110, 'Auburn', 120.00, 120.00, 22, '662827053937', NULL, '2025-06-03 23:00:07', '2025-06-10 19:51:02'),
(290, 110, 'Cool Black', 120.00, 120.00, 22, '662827053999', NULL, '2025-06-03 23:00:07', '2025-06-10 19:51:02'),
(291, 111, 'Black', 120.00, 120.00, 120, '662827054187', NULL, '2025-06-03 23:01:42', '2025-06-10 19:51:16'),
(292, 112, 'Black', 120.00, 120.00, 22, '662827054200', NULL, '2025-06-03 23:04:07', '2025-06-10 19:51:30'),
(293, 112, 'Brown', 120.00, 120.00, 22, '662827054217', NULL, '2025-06-03 23:04:07', '2025-06-10 19:51:30'),
(294, 113, 'Black', 120.00, 120.00, 22, '662827054231', NULL, '2025-06-03 23:06:29', '2025-06-10 19:51:45'),
(295, 113, 'Metallic Brown', 120.00, 120.00, 12, '662827054248', NULL, '2025-06-03 23:06:29', '2025-06-10 19:51:45'),
(296, 114, 'Black', 120.00, 120.00, 12, '662827054415', NULL, '2025-06-03 23:08:42', '2025-06-10 19:52:01'),
(297, 114, 'Brown', 120.00, 120.00, 22, '662827054446', NULL, '2025-06-03 23:08:42', '2025-06-10 19:52:01'),
(298, 115, 'Slate', 120.00, 120.00, 22, '662827054934', NULL, '2025-06-03 23:11:26', '2025-06-10 21:20:23'),
(299, 115, 'Brown', 120.00, 120.00, 12, '662827054941', NULL, '2025-06-03 23:11:26', '2025-06-10 21:20:23'),
(300, 116, 'Brown', 120.00, 120.00, 120, '662827054965', NULL, '2025-06-03 23:13:36', '2025-06-10 20:12:42'),
(301, 116, 'Burgundy', 120.00, 120.00, 12, '662827054972', NULL, '2025-06-03 23:13:36', '2025-06-10 20:12:42'),
(302, 117, 'Slate', 120.00, 120.00, 22, '662827055016', NULL, '2025-06-03 23:16:05', '2025-06-10 20:13:10'),
(303, 117, 'Brown', 120.00, 120.00, 22, '662827055023', NULL, '2025-06-03 23:16:05', '2025-06-10 20:13:10'),
(304, 118, 'Black', 120.00, 120.00, 22, '662827055467', NULL, '2025-06-03 23:37:47', '2025-06-10 20:13:39'),
(305, 118, 'Brown', 120.00, 120.00, 22, '662827055474', NULL, '2025-06-03 23:37:47', '2025-06-10 20:13:39'),
(306, 119, 'Brown', 120.00, 120.00, 12, '662827055511', NULL, '2025-06-03 23:40:00', '2025-06-10 20:14:09'),
(307, 120, 'White', 120.00, 120.00, 120, '662827055757', NULL, '2025-06-03 23:42:34', '2025-06-10 20:14:36'),
(308, 120, 'Black', 120.00, 120.00, 12, '662827055764', NULL, '2025-06-03 23:42:34', '2025-06-10 20:14:36'),
(309, 121, 'Black', 120.00, 120.00, 12, '662827055825', NULL, '2025-06-03 23:45:11', '2025-06-10 20:14:56'),
(310, 121, 'Brown', 120.00, 120.00, 22, '662827055832', NULL, '2025-06-03 23:45:11', '2025-06-10 20:14:56'),
(311, 121, 'Flint Grey', 120.00, 120.00, 12, '662827055849', NULL, '2025-06-03 23:45:11', '2025-06-10 20:14:56'),
(312, 122, 'Black Fade', 120.00, 120.00, 120, '662827055900', NULL, '2025-06-03 23:47:49', '2025-06-10 20:15:22'),
(313, 122, 'Black with Orange', 120.00, 120.00, 20, '662827055917', NULL, '2025-06-03 23:47:49', '2025-06-10 20:15:22'),
(314, 122, 'Brown with Fade', 120.00, 120.00, 120, '662827055924', NULL, '2025-06-03 23:47:49', '2025-06-10 20:15:22'),
(315, 122, 'Graphite', 120.00, 120.00, 20, '662827055931', NULL, '2025-06-03 23:48:49', '2025-06-10 20:15:22'),
(316, 122, 'Red White', 120.00, 120.00, 120, '662827055948', NULL, '2025-06-03 23:48:49', '2025-06-10 20:15:22'),
(317, 123, 'Black Fade', 120.00, 120.00, 120, '662827055955', NULL, '2025-06-03 23:52:57', '2025-06-10 20:15:43'),
(318, 123, 'Black', 120.00, 120.00, 12, '662827055962', NULL, '2025-06-03 23:52:58', '2025-06-10 20:15:43'),
(319, 123, 'Brown', 120.00, 120.00, 12, '662827055979', NULL, '2025-06-03 23:52:58', '2025-06-10 20:15:43'),
(320, 123, 'Graphite', 120.00, 120.00, 12, '662827055986', NULL, '2025-06-03 23:52:58', '2025-06-10 20:15:43'),
(321, 123, 'Red & Blue', 120.00, 120.00, 22, '662827055993', NULL, '2025-06-03 23:52:58', '2025-06-10 20:15:43'),
(322, 124, 'Black', 120.00, 120.00, 120, '662827056068', NULL, '2025-06-03 23:56:36', '2025-06-10 20:16:11'),
(323, 124, 'Brown', 120.00, 120.00, 12, '662827056075', NULL, '2025-06-03 23:56:36', '2025-06-10 20:16:11'),
(324, 124, 'Slate', 120.00, 120.00, 22, '662827056082', NULL, '2025-06-03 23:56:36', '2025-06-10 20:16:11'),
(325, 125, 'Flint Grey', 120.00, 120.00, 22, '662827056136', NULL, '2025-06-03 23:58:50', '2025-06-10 20:16:32'),
(326, 125, 'Tortoise', 120.00, 120.00, 22, '662827056143', NULL, '2025-06-03 23:58:50', '2025-06-10 20:16:32'),
(327, 126, 'Orange', 120.00, 120.00, 20, '662827056150', NULL, '2025-06-04 00:01:12', '2025-06-10 20:16:49'),
(328, 126, 'Black', 120.00, 120.00, 12, '662827056174', NULL, '2025-06-04 00:01:12', '2025-06-10 20:16:49'),
(329, 127, 'Black', 120.00, 120.00, 22, '662827056525', NULL, '2025-06-04 00:04:01', '2025-06-10 20:17:14'),
(330, 127, 'Purple', 120.00, 120.00, 12, '662827056563', NULL, '2025-06-04 00:04:01', '2025-06-10 20:17:14'),
(331, 127, 'Black', 200.00, 120.00, 22, '662827056570', NULL, '2025-06-04 00:04:01', '2025-06-10 20:17:14'),
(332, 128, 'Red', 120.00, 120.00, 120, '662827056600', NULL, '2025-06-04 00:07:29', '2025-06-10 20:17:33'),
(333, 128, 'Brown', 120.00, 120.00, 120, '662827056617', NULL, '2025-06-04 00:07:29', '2025-06-10 20:17:33'),
(334, 128, 'Black', 120.00, 120.00, 12, '662827056624', NULL, '2025-06-04 00:07:29', '2025-06-10 20:17:33'),
(335, 129, 'Blush Crystal', 120.00, 120.00, 12, '662829000144', NULL, '2025-06-04 00:10:38', '2025-06-10 20:17:56'),
(336, 129, 'Black', 120.00, 120.00, 12, '662829000151', NULL, '2025-06-04 00:10:38', '2025-06-10 20:17:56'),
(337, 129, 'Cobalt Blue', 120.00, 120.00, 12, '662829000168', NULL, '2025-06-04 00:10:38', '2025-06-10 20:17:56'),
(338, 130, 'Black', 120.00, 120.00, 22, '662829000175', NULL, '2025-06-04 00:13:39', '2025-06-10 20:18:18'),
(339, 130, 'Burgundy Marble', 120.00, 120.00, 12, '662829000182', NULL, '2025-06-04 00:13:39', '2025-06-10 20:18:18'),
(340, 130, 'Light Teal Crystal', 120.00, 120.00, 12, '662829000199', NULL, '2025-06-04 00:13:39', '2025-06-10 20:18:18'),
(341, 131, 'Black / Grey Crystal', 120.00, 120.00, 22, '662829000205', NULL, '2025-06-04 00:16:28', '2025-06-10 20:18:40'),
(342, 131, 'Olive Horn', 120.00, 120.00, 12, '662829000212', NULL, '2025-06-04 00:16:28', '2025-06-10 20:18:40'),
(343, 131, 'Matte Granite', 120.00, 120.00, 22, '662829000229', NULL, '2025-06-04 00:16:28', '2025-06-10 20:18:40'),
(344, 132, 'Crystal / Tortoise', 210.00, 210.00, 12, '662829000236', NULL, '2025-06-04 00:19:21', '2025-06-10 20:19:02'),
(345, 132, 'Midnight Blue', 120.00, 120.00, 22, '662829000243', NULL, '2025-06-04 00:19:21', '2025-06-10 20:19:02'),
(346, 132, 'Dark Grey Crystal', 120.00, 120.00, 22, '662829000250', NULL, '2025-06-04 00:19:21', '2025-06-10 20:19:02'),
(347, 133, 'Gold', 120.00, 120.00, 120, '819253020914', NULL, '2025-06-04 00:23:31', '2025-06-10 20:25:34'),
(348, 133, 'Gold', 120.00, 120.00, 12, '819253020921', NULL, '2025-06-04 00:23:31', '2025-06-10 20:25:34'),
(349, 133, 'Gunmetal', 120.00, 120.00, 12, '819253020945', NULL, '2025-06-04 00:23:31', '2025-06-10 20:25:34'),
(350, 133, 'Gunmetal Grey', 120.00, 120.00, 12, '819253020952', NULL, '2025-06-04 00:23:31', '2025-06-10 20:25:34'),
(351, 133, 'Gunmetal Grey', 120.00, 120.00, 12, '819253020969', NULL, '2025-06-04 00:23:31', '2025-06-10 20:25:34'),
(352, 134, 'White', 120.00, 120.00, 11, '662827056181', NULL, '2025-06-04 16:02:53', '2025-06-10 20:19:20'),
(353, 134, 'Graphite', 120.00, 120.00, 12, '662827056198', NULL, '2025-06-04 16:04:22', '2025-06-10 20:19:20'),
(354, 135, 'Black', 120.00, 120.00, 102, '662827056204', NULL, '2025-06-04 16:06:38', '2025-06-10 20:19:42'),
(355, 136, 'Clear', 100.00, 120.00, 12, '662827056273', NULL, '2025-06-04 16:13:52', '2025-06-10 20:19:58'),
(356, 136, 'Black', 120.00, 120.00, 120, '662827056297', NULL, '2025-06-04 16:13:52', '2025-06-10 20:19:58'),
(357, 137, 'Black', 120.00, 100.00, 11, '662827056471', NULL, '2025-06-04 16:16:12', '2025-06-10 20:20:29'),
(358, 137, 'Black', 120.00, 120.00, 22, '662827056495', NULL, '2025-06-04 16:16:12', '2025-06-10 20:20:29'),
(359, 138, 'Black', 120.00, 120.00, 12, '819253021393', NULL, '2025-06-04 16:31:15', '2025-06-10 20:25:26'),
(360, 138, 'Black', 120.00, 120.00, 12, '819253021409', NULL, '2025-06-04 16:31:15', '2025-06-10 20:25:26'),
(361, 138, 'Black', 120.00, 120.00, 22, '819253021416', NULL, '2025-06-04 16:31:15', '2025-06-10 20:25:26'),
(362, 138, 'Blue', 120.00, 120.00, 22, '819253021447', NULL, '2025-06-04 16:31:15', '2025-06-10 20:25:26'),
(363, 138, 'Red', 120.00, 120.00, 12, '819253021454', NULL, '2025-06-04 16:31:15', '2025-06-10 20:25:26'),
(364, 138, 'Gray', 120.00, 120.00, 12, '819253021478', NULL, '2025-06-04 16:31:15', '2025-06-10 20:25:26'),
(365, 139, 'Brown', 120.00, 120.00, 12, '819253023434', NULL, '2025-06-04 16:44:48', '2025-06-10 20:25:54'),
(366, 139, 'Navy w/ Clear carrier', 120.00, 120.00, 12, '819253023458', NULL, '2025-06-04 16:44:48', '2025-06-10 20:25:54'),
(367, 139, 'Blue', 120.00, 120.00, 12, '819253023465', NULL, '2025-06-04 16:44:48', '2025-06-10 20:25:54'),
(368, 139, 'Black', 120.00, 120.00, 22, '819253023472', NULL, '2025-06-04 16:44:48', '2025-06-10 20:25:54'),
(369, 139, 'Black', 120.00, 120.00, 22, '819253023489', NULL, '2025-06-04 16:44:48', '2025-06-10 20:25:54'),
(370, 139, 'Charcoal', 120.00, 120.00, 22, '819253023496', NULL, '2025-06-04 16:44:48', '2025-06-10 20:25:54'),
(371, 139, 'Charcoal w/ Smoke carrier', 120.00, 120.00, 12, '819253023502', NULL, '2025-06-04 16:44:48', '2025-06-10 20:25:54'),
(372, 140, 'GREY', 120.00, 120.00, 22, '819253022796', NULL, '2025-06-04 16:47:35', '2025-06-10 20:26:16'),
(373, 140, 'GREY', 120.00, 120.00, 120, '819253022802', NULL, '2025-06-04 16:47:35', '2025-06-10 20:26:16'),
(374, 140, 'Brown', 120.00, 120.00, 120, '819253022819', NULL, '2025-06-04 16:47:35', '2025-06-10 20:26:16'),
(375, 140, 'Brown', 120.00, 120.00, 12, '819253022826', NULL, '2025-06-04 16:47:35', '2025-06-10 20:26:16'),
(376, 141, 'Black', 120.00, 120.00, 2, '819253022833', NULL, '2025-06-04 16:51:01', '2025-06-10 20:26:40'),
(377, 141, 'Black', 120.00, 120.00, 22, '819253022840', NULL, '2025-06-04 16:51:01', '2025-06-10 20:26:40'),
(378, 141, 'Brown', 120.00, 120.00, 12, '819253022857', NULL, '2025-06-04 16:51:01', '2025-06-10 20:26:40'),
(379, 141, 'Brown', 120.00, 120.00, 22, '819253022864', NULL, '2025-06-04 16:51:01', '2025-06-10 20:26:40'),
(380, 142, 'Matte Brown', 120.00, 120.00, 12, '819253020228', NULL, '2025-06-04 19:30:39', '2025-06-10 20:26:58'),
(381, 142, 'Brown', 120.00, 120.00, 22, '819253020235', NULL, '2025-06-04 19:30:39', '2025-06-10 20:26:58'),
(382, 142, 'GREY', 120.00, 120.00, 12, '819253020242', NULL, '2025-06-04 19:30:39', '2025-06-10 20:26:58'),
(383, 142, 'Matte Grey', 120.00, 120.00, 12, '819253020259', NULL, '2025-06-04 19:30:39', '2025-06-10 20:26:58'),
(384, 143, 'Gray Matte/Brown Matte', 120.00, 120.00, 22, '819253020105', NULL, '2025-06-04 19:33:52', '2025-06-10 20:27:17'),
(385, 143, 'Brown', 120.00, 120.00, 22, '819253020129', NULL, '2025-06-04 19:33:52', '2025-06-10 20:27:17'),
(386, 143, 'Brown Matte', 120.00, 120.00, 22, '819253020136', NULL, '2025-06-04 19:33:52', '2025-06-10 20:27:17'),
(387, 144, 'Gold', 120.00, 120.00, 12, '819253021010', NULL, '2025-06-04 19:37:35', '2025-06-10 20:27:30'),
(388, 144, 'Gold', 120.00, 120.00, 22, '819253021027', NULL, '2025-06-04 19:37:35', '2025-06-10 20:27:30'),
(389, 144, 'Gunmetal', 120.00, 120.00, 22, '819253021034', NULL, '2025-06-04 19:37:35', '2025-06-10 20:27:30'),
(390, 144, 'Gunmetal Gray', 120.00, 120.00, 20, '819253021041', NULL, '2025-06-04 19:37:35', '2025-06-10 20:27:30'),
(391, 145, 'Black With Crystal Carrier', 120.00, 120.00, 22, '819253021683', NULL, '2025-06-04 20:04:54', '2025-06-10 20:27:44'),
(392, 145, 'Black', 120.00, 120.00, 12, '819253021690', NULL, '2025-06-04 20:04:54', '2025-06-10 20:27:44'),
(393, 145, 'Blue', 120.00, 120.00, 22, '819253021706', NULL, '2025-06-04 20:04:54', '2025-06-10 20:27:44'),
(394, 145, 'Blue', 120.00, 120.00, 22, '819253021713', NULL, '2025-06-04 20:04:54', '2025-06-10 20:27:44'),
(395, 145, 'Gray With Crystal Carrier', 120.00, 120.00, 22, '819253021737', NULL, '2025-06-04 20:04:54', '2025-06-10 20:27:44'),
(396, 145, 'Gray With Smoke Carrier', 120.00, 120.00, 12, '819253021744', NULL, '2025-06-04 20:04:54', '2025-06-10 20:27:44'),
(397, 146, 'Black', 120.00, 120.00, 22, '819253022833', NULL, '2025-06-04 20:08:18', '2025-06-10 20:28:05'),
(398, 146, 'Black', 120.00, 120.00, 12, '819253022840', NULL, '2025-06-04 20:08:18', '2025-06-10 20:28:05'),
(399, 146, 'Brown', 120.00, 120.00, 20, '819253022857', NULL, '2025-06-04 20:08:18', '2025-06-10 20:28:05'),
(400, 146, 'Brown', 120.00, 120.00, 22, '819253022864', NULL, '2025-06-04 20:08:18', '2025-06-10 20:28:05'),
(401, 147, 'Black', 120.00, 120.00, 20, '819253026138', NULL, '2025-06-04 20:11:11', '2025-06-10 20:28:22'),
(402, 147, 'Black', 120.00, 120.00, 20, '819253026145', NULL, '2025-06-04 20:11:11', '2025-06-10 20:28:22'),
(403, 147, 'White', 120.00, 120.00, 22, '819253026152', NULL, '2025-06-04 20:11:11', '2025-06-10 20:28:22'),
(404, 148, 'Black', 120.00, 120.00, 22, '819253022352', NULL, '2025-06-04 20:14:23', '2025-06-10 20:28:37'),
(405, 148, 'Black', 120.00, 120.00, 22, '819253022369', NULL, '2025-06-04 20:14:23', '2025-06-10 20:28:37'),
(406, 148, 'White', 120.00, 120.00, 12, '819253022376', NULL, '2025-06-04 20:14:23', '2025-06-10 20:28:37'),
(407, 148, 'Silver', 120.00, 120.00, 22, '819253022383', NULL, '2025-06-04 20:14:23', '2025-06-10 20:28:37'),
(408, 149, 'Gunmetal', 120.00, 120.00, 12, '819253021171', NULL, '2025-06-04 20:18:51', '2025-06-10 20:28:55'),
(409, 149, 'Gunmetal Grey', 120.00, 120.00, 22, '819253021188', NULL, '2025-06-04 20:18:51', '2025-06-10 20:28:55'),
(410, 149, 'Brown', 120.00, 120.00, 22, '819253021195', NULL, '2025-06-04 20:18:51', '2025-06-10 20:28:55'),
(411, 149, 'Brown', 120.00, 120.00, 22, '819253021201', NULL, '2025-06-04 20:18:51', '2025-06-10 20:28:55'),
(412, 150, 'Silver', 120.00, 120.00, 120, '819253021775', NULL, '2025-06-04 20:24:05', '2025-06-10 20:29:07'),
(413, 150, 'Silver', 120.00, 120.00, 12, '819253021799', NULL, '2025-06-04 20:24:05', '2025-06-10 20:29:07'),
(414, 150, 'Brown', 120.00, 120.00, 22, '819253021805', NULL, '2025-06-04 20:24:05', '2025-06-10 20:29:07'),
(415, 151, 'White', 120.00, 120.00, 12, '819253023700', NULL, '2025-06-04 21:17:18', '2025-06-10 20:29:21'),
(416, 151, 'Red', 120.00, 120.00, 12, '819253023717', NULL, '2025-06-04 21:17:18', '2025-06-10 20:29:21'),
(417, 152, 'Gunmetal Gray', 120.00, 120.00, 22, '819253026091', NULL, '2025-06-04 21:22:38', '2025-06-10 20:29:35'),
(418, 152, 'Gunmetal Gray', 120.00, 120.00, 22, '819253026107', NULL, '2025-06-04 21:22:38', '2025-06-10 20:29:35'),
(419, 152, 'Copper', 120.00, 120.00, 12, '819253026114', NULL, '2025-06-04 21:22:38', '2025-06-10 20:29:35'),
(420, 152, 'Copper', 120.00, 120.00, 2, '819253026121', NULL, '2025-06-04 21:22:38', '2025-06-10 20:29:35'),
(421, 153, 'Black', 120.00, 120.00, 22, '819253022581', NULL, '2025-06-04 21:25:04', '2025-06-10 20:29:49'),
(422, 153, 'Silver', 120.00, 120.00, 22, '819253022604', NULL, '2025-06-04 21:25:04', '2025-06-10 20:29:49'),
(423, 153, 'Silver', 120.00, 120.00, 22, '819253022611', NULL, '2025-06-04 21:25:04', '2025-06-10 20:29:49'),
(424, 154, 'Tortoise/Brown', 120.00, 120.00, 12, '819253023854', NULL, '2025-06-04 21:27:55', '2025-06-10 20:30:04'),
(425, 154, 'Black', 120.00, 120.00, 12, '819253023861', NULL, '2025-06-04 21:27:55', '2025-06-10 20:30:04'),
(426, 155, 'Black', 120.00, 120.00, 22, '819253023878', NULL, '2025-06-04 21:31:10', '2025-06-10 20:30:17'),
(427, 155, 'Green Tortoise', 120.00, 120.00, 12, '819253023885', NULL, '2025-06-04 21:31:10', '2025-06-10 20:30:17'),
(428, 156, 'Brown', 120.00, 120.00, 22, '819253023892', NULL, '2025-06-04 21:33:19', '2025-06-10 20:30:29'),
(429, 156, 'Blue Marble', 120.00, 120.00, 22, '819253023908', NULL, '2025-06-04 21:33:19', '2025-06-10 20:30:29'),
(430, 157, 'Matte-Violet Front, Pink Temples', 120.00, 120.00, 22, '819253023229', NULL, '2025-06-04 21:35:37', '2025-06-10 20:30:42'),
(431, 157, 'Matte-Brown Front, Ocean Temples', 102.00, 120.00, 120, '819253023236', NULL, '2025-06-04 21:35:37', '2025-06-10 20:30:42'),
(432, 158, 'Matte-Brown Front, Tortoise Temples', 120.00, 120.00, 22, '819253023199', NULL, '2025-06-04 21:37:40', '2025-06-10 20:30:56'),
(433, 158, 'Matte-Grey Front, Silver Temples', 120.00, 120.00, 22, '819253023205', NULL, '2025-06-04 21:37:40', '2025-06-10 20:30:56'),
(434, 159, 'Tortoise', 120.00, 120.00, 12, '819253022208', NULL, '2025-06-04 21:40:19', '2025-06-10 20:31:09'),
(435, 159, 'Black', 120.00, 120.00, 12, '819253022215', NULL, '2025-06-04 21:40:19', '2025-06-10 20:31:09'),
(436, 160, 'Tortoise', 120.00, 120.00, 12, '819253022222', NULL, '2025-06-04 21:43:38', '2025-06-10 20:31:23'),
(437, 160, 'Black', 120.00, 120.00, 22, '819253022253', NULL, '2025-06-04 21:43:38', '2025-06-10 20:31:23'),
(438, 160, 'Black', 120.00, 120.00, 12, '819253022260', NULL, '2025-06-04 21:43:38', '2025-06-10 20:31:23'),
(439, 161, 'Blue With Silver Inside', 120.00, 120.00, 12, '819253022079', NULL, '2025-06-04 21:45:37', '2025-06-10 20:31:59'),
(440, 161, 'Black With Silver Inside', 120.00, 120.00, 12, '819253022086', NULL, '2025-06-04 21:45:37', '2025-06-10 20:31:59'),
(441, 162, 'Moss With Dark Gunmetal', 120.00, 120.00, 22, '819253022000', NULL, '2025-06-04 21:47:55', '2025-06-10 20:32:13'),
(442, 162, 'Burgundy With Silver Inside', 120.00, 120.00, 12, '819253022024', NULL, '2025-06-04 21:47:55', '2025-06-10 20:32:13'),
(445, 133, 'Black', 120.00, 120.00, 120, '819253023281', NULL, '2025-06-04 21:51:03', '2025-06-10 20:25:34'),
(446, 164, 'Smoke', 120.00, 120.00, 12, '819253020365', NULL, '2025-06-04 21:53:09', '2025-06-10 20:32:29'),
(447, 164, 'Smoke', 120.00, 120.00, 12, '819253020372', NULL, '2025-06-04 21:53:09', '2025-06-10 20:32:29'),
(448, 165, 'Smoke', 120.00, 120.00, 2, '819253020402', NULL, '2025-06-04 21:54:54', '2025-06-10 20:32:43'),
(449, 165, 'Smoke', 120.00, 120.00, 12, '819253020419', NULL, '2025-06-04 21:54:54', '2025-06-10 20:32:43'),
(450, 166, 'Tortoise', 120.00, 120.00, 22, '819253021300', NULL, '2025-06-04 21:58:15', '2025-06-10 20:32:57'),
(451, 166, 'Tortoise', 120.00, 120.00, 12, '819253021317', NULL, '2025-06-04 21:58:15', '2025-06-10 20:32:57'),
(452, 166, 'Olive', 120.00, 120.00, 2, '819253021324', NULL, '2025-06-04 21:58:15', '2025-06-10 20:32:57'),
(453, 167, 'Black Crystal', 120.00, 120.00, 22, '819253021577', NULL, '2025-06-04 22:00:30', '2025-06-10 20:33:21'),
(454, 167, 'Brown', 120.00, 120.00, 22, '819253021591', NULL, '2025-06-04 22:00:30', '2025-06-10 20:33:21'),
(455, 167, 'Brown', 120.00, 120.00, 12, '819253021607', NULL, '2025-06-04 22:00:30', '2025-06-10 20:33:21'),
(456, 168, 'Gunmetal Gray', 120.00, 120.00, 22, '819253023311', NULL, '2025-06-04 23:53:49', '2025-06-10 20:33:36'),
(457, 168, 'Brown', 120.00, 120.00, 22, '819253020990', NULL, '2025-06-04 23:53:49', '2025-06-10 20:33:36'),
(458, 168, 'Brown', 120.00, 120.00, 22, '819253021003', NULL, '2025-06-04 23:53:49', '2025-06-10 20:33:36'),
(459, 145, 'Purple', 120.00, 120.00, 12, '819253023106', NULL, '2025-06-04 23:55:31', '2025-06-10 20:27:44'),
(460, 145, 'Purple with Smoke', 120.00, 120.00, 22, '819253023113', NULL, '2025-06-04 23:55:31', '2025-06-10 20:27:44'),
(461, 169, 'Crystal With Orange Trim', 120.00, 120.00, 22, '819253023175', NULL, '2025-06-04 23:57:43', '2025-06-12 09:44:49');
INSERT INTO `product_variants` (`id`, `product_id`, `color_name`, `price`, `purchase_price`, `available_quantity`, `vto`, `photo_config_name`, `created_at`, `updated_at`) VALUES
(462, 169, 'Crystal With Gray Trim', 120.00, 120.00, 22, '819253023182', NULL, '2025-06-04 23:57:43', '2025-06-12 09:44:49'),
(463, 170, 'Black', 12.00, 120.00, 22, '819253023021', NULL, '2025-06-04 23:59:30', '2025-06-10 20:34:28'),
(464, 170, 'Black', 120.00, 120.00, 22, '819253023038', NULL, '2025-06-04 23:59:30', '2025-06-10 20:34:28'),
(465, 171, 'Jet', 120.00, 120.00, 22, '819253021652', NULL, '2025-06-05 12:21:06', '2025-06-10 20:34:41'),
(466, 171, 'Wine Fade', 120.00, 120.00, 22, '819253021676', NULL, '2025-06-05 12:21:06', '2025-06-10 20:34:41'),
(467, 172, 'GREY', 120.00, 120.00, 120, '819253020143', NULL, '2025-06-05 12:26:06', '2025-06-10 20:34:55'),
(468, 173, 'Brown', 120.00, 120.00, 22, '819253020426', NULL, '2025-06-05 12:29:28', '2025-06-10 20:35:13'),
(469, 173, 'Brown Marble', 120.00, 120.00, 22, '819253020433', NULL, '2025-06-05 12:29:28', '2025-06-10 20:35:13'),
(470, 174, 'Smoke', 120.00, 120.00, 12, '819253020532', NULL, '2025-06-05 12:31:37', '2025-06-10 20:35:28'),
(471, 174, 'Smoke', 120.00, 120.00, 12, '819253021119', NULL, '2025-06-05 12:31:37', '2025-06-10 20:35:28'),
(472, 175, 'Black', 120.00, 120.00, 22, '819253021263', NULL, '2025-06-05 12:33:43', '2025-06-10 20:35:41'),
(473, 175, 'Bronze', 120.00, 120.00, 22, '819253021270', NULL, '2025-06-05 12:33:43', '2025-06-10 20:35:41'),
(474, 176, 'Black', 120.00, 120.00, 22, '819253022109', NULL, '2025-06-05 12:35:44', '2025-06-10 20:35:55'),
(475, 176, 'Brown', 120.00, 120.00, 22, '819253022116', NULL, '2025-06-05 12:35:44', '2025-06-10 20:35:55'),
(476, 177, 'Smoke', 120.00, 120.00, 12, '819253021638', NULL, '2025-06-05 12:37:20', '2025-06-10 20:36:37'),
(477, 177, 'Smoke', 120.00, 120.00, 22, '819253021959', NULL, '2025-06-05 12:37:20', '2025-06-10 20:36:37'),
(478, 178, 'Gray With Black Trim', 120.00, 120.00, 12, '819253022291', NULL, '2025-06-05 12:40:45', '2025-06-12 09:44:01'),
(479, 178, 'Black', 220.00, 200.00, 22, '819253022307', NULL, '2025-06-05 12:40:45', '2025-06-12 09:44:01'),
(480, 179, 'Navy Blue', 200.00, 120.00, 22, '819253022567', NULL, '2025-06-05 12:43:15', '2025-06-10 20:37:24'),
(481, 179, 'Gunmetal', 120.00, 120.00, 22, '819253022574', NULL, '2025-06-05 12:43:15', '2025-06-10 20:37:24'),
(482, 180, 'Brown', 122.00, 120.00, 22, '819253022758', NULL, '2025-06-05 12:45:27', '2025-06-10 20:37:38'),
(483, 180, 'Shiney Silver', 120.00, 120.00, 22, '819253022789', NULL, '2025-06-05 12:45:27', '2025-06-10 20:37:38'),
(484, 181, 'Blue', 120.00, 120.00, 22, '819253023724', NULL, '2025-06-05 12:47:28', '2025-06-10 20:04:59'),
(485, 181, 'Red', 120.00, 120.00, 12, '819253023731', NULL, '2025-06-05 12:47:28', '2025-06-10 20:04:59'),
(486, 182, 'Camo w/ Clear Carrier', 120.00, 120.00, 22, '819253023564', NULL, '2025-06-05 12:49:26', '2025-06-10 20:38:00'),
(487, 182, 'Camouflage', 120.00, 120.00, 22, '819253023571', NULL, '2025-06-05 12:49:26', '2025-06-10 20:38:00'),
(488, 183, 'Black', 120.00, 120.00, 20, '819253021966', NULL, '2025-06-05 12:52:45', '2025-06-10 20:38:12'),
(489, 183, 'CAMO', 120.00, 120.00, 22, '819253023373', NULL, '2025-06-05 12:52:45', '2025-06-10 20:38:12'),
(490, 183, 'Camo', 120.00, 120.00, 23, '819253023410', NULL, '2025-06-05 12:52:45', '2025-06-10 20:38:12'),
(491, 184, 'Black', 120.00, 120.00, 22, '819253021973', NULL, '2025-06-05 12:55:40', '2025-06-10 20:38:27'),
(492, 184, 'Camo', 120.00, 120.00, 12, '819253023380', NULL, '2025-06-05 12:55:40', '2025-06-10 20:38:27'),
(493, 184, 'Camo', 120.00, 120.00, 12, '819253023427', NULL, '2025-06-05 12:55:40', '2025-06-10 20:38:27'),
(494, 182, 'Camo w/ Brown Carrier', 120.00, 120.00, 12, '819253023359', NULL, '2025-06-05 12:56:18', '2025-06-10 20:38:00'),
(495, 185, 'Black', 120.00, 120.00, 22, '819253020563', NULL, '2025-06-05 12:57:45', '2025-06-10 20:38:40'),
(496, 178, 'CAMO W/SEAL & STRAP', 120.00, 120.00, 22, '819253023403', NULL, '2025-06-12 09:44:02', '2025-06-12 09:44:02'),
(497, 169, 'Charcoal', 120.00, 120.00, 22, '819253023694', NULL, '2025-06-12 09:44:49', '2025-06-12 09:44:49'),
(498, 186, 'Black', 120.00, 120.00, 22, '819253023649', NULL, '2025-06-12 09:46:39', '2025-06-12 09:46:39'),
(499, 187, 'Clear', 120.00, 120.00, 22, '662827057737', NULL, '2025-06-12 09:49:39', '2025-06-12 09:49:39'),
(500, 188, 'green', 150.00, 120.00, 23, '2038409238409832', NULL, '2025-06-17 08:24:32', '2025-06-17 08:24:32');

-- --------------------------------------------------------

--
-- Table structure for table `rim_types`
--

CREATE TABLE `rim_types` (
  `rim_type_id` int NOT NULL,
  `rim_type_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `style` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rim_types`
--

INSERT INTO `rim_types` (`rim_type_id`, `rim_type_name`, `style`) VALUES
(4, 'Full-Rim', NULL),
(5, 'Half-Rim', NULL),
(6, 'Rimless', NULL),
(7, 'Wraparound', NULL),
(8, 'Shield Frame', NULL),
(9, 'Wireframe', NULL),
(10, 'Hybrid Rim', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `scracth_coating`
--

CREATE TABLE `scracth_coating` (
  `id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `sub_title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scracth_coating`
--

INSERT INTO `scracth_coating` (`id`, `title`, `sub_title`, `image_url`, `price`, `description`, `created_at`, `updated_at`) VALUES
(3, 'No protection', 'Lens without any Scratch Coat', '/projectimages/lensmanegment/scratch_coating/1745309372_NO_SCRATCH_COATING.svg', 0.00, 'Lenses without scratch protection can be more vulnerable to damage over time. While they maintain clear vision, they require more careful handling to avoid surface scratches. For long-lasting durability, scratch-resistant coatings are recommended to preserve lens quality.', '2025-04-22 08:09:32', '2025-04-22 08:09:32'),
(4, 'Dual side Hard Coat', '1 year, 1 time Warranty', '/projectimages/lensmanegment/scratch_coating/1745309991_DUAL_SIDED_HARD_COAT.svg', 41.00, 'Dual-sided hard coat scratch protection ensures that both the front and back surfaces of the lenses are shielded from everyday wear and tear. This feature helps extend the lifespan of your lenses by preventing scratches and maintaining optical clarity.', '2025-04-22 08:10:46', '2025-04-22 08:19:51'),
(5, 'Dual side Hard Coat with antifog', '1 year, 1 time Warranty', '/projectimages/lensmanegment/scratch_coating/1745310143_DUAL_SIDED_HARD_COAT_WITH_ANTI_FOG.svg', 74.00, 'In addition to scratch protection, this coating also features antifog technology to keep lenses clear in humid or rainy conditions. Whether you\'re transitioning between environments or engaging in physical activities, this coating ensures your vision remains unobstructed.', '2025-04-22 08:11:36', '2025-04-22 08:22:23');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('FBdAkRjGyG5mqGnKNY8nuXZuxtyElISCrrvxDlAf', NULL, '185.177.72.108', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRDJjd3Q1Q0t5bzl2RXE0dFUycTRXelU0dUx5dE82WDBFdWlmQTRJaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHBzOi8vc3J2Njg1NzYyLmhzdGdyLmNsb3VkL2luZGV4LnBocCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750043088),
('ktPWIeDCfzLmrOPFhkrnEt36uy1J8lsF9aC90zTh', NULL, '194.233.72.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNk9FaW5iaEFGTEpUZDNSZ3UxSk9QVnpaejJtUzMzeXo0ZFF1bWFLRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vc3J2Njg1NzYyLmhzdGdyLmNsb3VkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750081668),
('Midq5RmQyOFZ7tFhUDEn5PmdKuQjNyenXDWIimYu', NULL, '52.90.77.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoielFQOFQ5QWdIeEdZS2JCMTZLYjJzanFYRkVZWjk1M0VZT1NyUTZmZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vc3J2Njg1NzYyLmhzdGdyLmNsb3VkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750263007),
('occDnyvJaZW3F444OUgwJkxv7eWb9IaaWUlEOIuz', NULL, '223.123.1.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0g5Z3pRcHRFYWY1dEhtZEdqMFFQYzFmT01ZeFZRV0taeDZNZU1qViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vc3J2Njg1NzYyLmhzdGdyLmNsb3VkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750202423),
('OhAYtDZk27I2bOCNJ3MmYf4m2twBr4sNQHn6LscJ', NULL, '39.60.231.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFljZjYyRDUyOEJ3N3lpcVJvVmVsQVFveTNtT0pMRkNtYjdUVWxvciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vc3J2Njg1NzYyLmhzdGdyLmNsb3VkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750187275),
('pKLWTdjWRrxh9Z8Yeub7N5iSsh6IicCMObp9cJ1k', NULL, '223.123.1.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU3dPOUxqN1IzZ090VkNmdlp5YUh3a2VFRDJyU1NKem1xZ1FjdlRieCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vc3J2Njg1NzYyLmhzdGdyLmNsb3VkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750203763),
('xpgYfdEd3WZaG8ncRKbAzWYqSUazfHnw984vMhYe', NULL, '52.90.77.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2RrSVFaNW95ajhzWGtQTVRTWmhZd1RpS082QUZOQlNDT0xNY1NIVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vc3J2Njg1NzYyLmhzdGdyLmNsb3VkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750263008);

-- --------------------------------------------------------

--
-- Table structure for table `shapes`
--

CREATE TABLE `shapes` (
  `shape_id` int NOT NULL,
  `shape_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `manufacturer_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shapes`
--

INSERT INTO `shapes` (`shape_id`, `shape_name`, `manufacturer_name`) VALUES
(4, 'Rectangular', NULL),
(5, 'Round', NULL),
(6, 'Oval', NULL),
(7, 'Square', NULL),
(8, 'Aviator', NULL),
(9, 'Wraparound', NULL),
(10, 'Shield', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `styles`
--

CREATE TABLE `styles` (
  `style_id` int NOT NULL,
  `style_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `material` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `styles`
--

INSERT INTO `styles` (`style_id`, `style_name`, `material`) VALUES
(4, 'Aviator Shield', NULL),
(10, 'Side Shields', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int NOT NULL,
  `employee_id` int NOT NULL,
  `transaction_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `amount` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `employee_id`, `transaction_type`, `amount`, `balance`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'credit', 150, 150, NULL, '2025-06-18 16:20:50', '2025-06-18 16:20:50'),
(2, 1, 'debit', 150, 0, 'Order payment from benefit', '2025-06-18 16:23:14', '2025-06-18 16:23:14'),
(3, 1, 'credit', 300, 300, NULL, '2025-06-18 17:54:06', '2025-06-18 17:54:06'),
(4, 1, 'debit', 170.5, 129.5, 'Order payment from benefit', '2025-06-19 07:00:14', '2025-06-19 07:00:14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int DEFAULT '1',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `status`, `email_verified_at`, `password`, `remember_token`, `verification_number`, `created_at`, `updated_at`, `role`, `company_id`, `employee_id`) VALUES
(1, 'admin', 'admin@SafetyEyeGuard.com', 1, NULL, '$2y$12$IShD8Uk5FW7croyHsmU6L.cOdShIYHt6e6qE1LS.nhgwfGR9BD2u.', NULL, '', '2025-06-12 17:07:09', '2025-03-12 04:28:50', 'owner', NULL, NULL),
(259, 'mavia21', 'mavia8701@gmail.com', 1, NULL, '$2y$12$DfVq7dNaIKJFUCsvbH5zHuS8YZXbqtTCG1mUwtqf4qGgsKJ5zA.z.', NULL, '59052ff3-4715-445c-ae52-4cf25e39156f', '2025-06-18 16:17:19', '2025-06-18 16:17:19', 'company', 1, NULL),
(260, 'emp', 'hub8701@gmail.com', 1, NULL, '$2y$12$q2U4H8Jx9a2i98FfSeUbROdsdvixqxpvVLI3Olpin2.aKTDGkiOyG', NULL, 'ab4efa89-20d2-4425-a58f-4f74dd6d1135', '2025-06-18 16:20:34', '2025-06-18 16:20:34', 'employee', 1, 1),
(261, 'employyee2', 'minahilmalik8701@gmail.com', 1, NULL, '$2y$12$xFfV4Cx7BI5CY4eHVqX0Y.DHAYTgrEyKbO/3JX0d9BEAPweuSsiAu', NULL, 'a3bf35c4-dc0e-4db6-bc84-b858622849d0', '2025-06-18 17:18:26', '2025-06-18 17:18:26', 'employee', 1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blue_light_protection`
--
ALTER TABLE `blue_light_protection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`color_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_blue_light_protection_mapper`
--
ALTER TABLE `company_blue_light_protection_mapper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_lens_material_mapper`
--
ALTER TABLE `company_lens_material_mapper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_lens_protection_mapper`
--
ALTER TABLE `company_lens_protection_mapper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_lens_tint_mapper`
--
ALTER TABLE `company_lens_tint_mapper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_product_mapper`
--
ALTER TABLE `company_product_mapper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_scratch_coating_mapper`
--
ALTER TABLE `company_scratch_coating_mapper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_product_mapper`
--
ALTER TABLE `employee_product_mapper`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employe_temp_orderdetails`
--
ALTER TABLE `employe_temp_orderdetails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `frame_sizes`
--
ALTER TABLE `frame_sizes`
  ADD PRIMARY KEY (`frame_size_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lens_material`
--
ALTER TABLE `lens_material`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lens_protection`
--
ALTER TABLE `lens_protection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lens_tint`
--
ALTER TABLE `lens_tint`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`manufacturer_id`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`material_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_confirmation_number` (`order_confirmation_number`);

--
-- Indexes for table `order_billing_address`
--
ALTER TABLE `order_billing_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_shipping_address`
--
ALTER TABLE `order_shipping_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_update_points`
--
ALTER TABLE `order_update_points`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `prescription_details`
--
ALTER TABLE `prescription_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_frame_size`
--
ALTER TABLE `product_frame_size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_subcategories`
--
ALTER TABLE `product_subcategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rim_types`
--
ALTER TABLE `rim_types`
  ADD PRIMARY KEY (`rim_type_id`);

--
-- Indexes for table `scracth_coating`
--
ALTER TABLE `scracth_coating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `shapes`
--
ALTER TABLE `shapes`
  ADD PRIMARY KEY (`shape_id`);

--
-- Indexes for table `styles`
--
ALTER TABLE `styles`
  ADD PRIMARY KEY (`style_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blue_light_protection`
--
ALTER TABLE `blue_light_protection`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `colors`
--
ALTER TABLE `colors`
  MODIFY `color_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `company_blue_light_protection_mapper`
--
ALTER TABLE `company_blue_light_protection_mapper`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `company_lens_material_mapper`
--
ALTER TABLE `company_lens_material_mapper`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `company_lens_protection_mapper`
--
ALTER TABLE `company_lens_protection_mapper`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `company_lens_tint_mapper`
--
ALTER TABLE `company_lens_tint_mapper`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `company_product_mapper`
--
ALTER TABLE `company_product_mapper`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=174;

--
-- AUTO_INCREMENT for table `company_scratch_coating_mapper`
--
ALTER TABLE `company_scratch_coating_mapper`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `employee_product_mapper`
--
ALTER TABLE `employee_product_mapper`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=174;

--
-- AUTO_INCREMENT for table `employe_temp_orderdetails`
--
ALTER TABLE `employe_temp_orderdetails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `frame_sizes`
--
ALTER TABLE `frame_sizes`
  MODIFY `frame_size_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lens_material`
--
ALTER TABLE `lens_material`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `lens_protection`
--
ALTER TABLE `lens_protection`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lens_tint`
--
ALTER TABLE `lens_tint`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `manufacturers`
--
ALTER TABLE `manufacturers`
  MODIFY `manufacturer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `material_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_billing_address`
--
ALTER TABLE `order_billing_address`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_shipping_address`
--
ALTER TABLE `order_shipping_address`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_update_points`
--
ALTER TABLE `order_update_points`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=466;

--
-- AUTO_INCREMENT for table `prescription_details`
--
ALTER TABLE `prescription_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- AUTO_INCREMENT for table `product_frame_size`
--
ALTER TABLE `product_frame_size`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=354;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=990;

--
-- AUTO_INCREMENT for table `product_subcategories`
--
ALTER TABLE `product_subcategories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=501;

--
-- AUTO_INCREMENT for table `rim_types`
--
ALTER TABLE `rim_types`
  MODIFY `rim_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `scracth_coating`
--
ALTER TABLE `scracth_coating`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `shapes`
--
ALTER TABLE `shapes`
  MODIFY `shape_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `styles`
--
ALTER TABLE `styles`
  MODIFY `style_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=262;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
