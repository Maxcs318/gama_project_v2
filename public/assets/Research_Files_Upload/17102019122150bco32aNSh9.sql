-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2019 at 05:30 AM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `z_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic_article`
--

CREATE TABLE `academic_article` (
  `aa_id` int(11) NOT NULL,
  `aa_title` text NOT NULL,
  `aa_detail` text NOT NULL,
  `aa_category` varchar(50) NOT NULL,
  `aa_create_date` varchar(50) NOT NULL,
  `aa_image` text NOT NULL,
  `aa_update_date` varchar(50) NOT NULL,
  `aa_file_key` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `academic_article`
--

INSERT INTO `academic_article` (`aa_id`, `aa_title`, `aa_detail`, `aa_category`, `aa_create_date`, `aa_image`, `aa_update_date`, `aa_file_key`) VALUES
(4, 'test 04', 'V2 + S2', '2', '30 กันยายน 2562 time 12:30:32', '30092019130029hjkJfGnClr.png', '30 กันยายน 2562 time 13:00:29', 'AA30092019123032kd76arSXYJ'),
(5, 'test ++', 'test test test test ++', '1', '30 กันยายน 2562 time 14:13:33', '30092019141333o1fhQjWqGk.jpg', '', 'AA30092019141333aIMOkxCE9c'),
(6, 'test aa +', 'aAfdtth + - x skill', '1', '30 กันยายน 2562 time 15:00:00', '300920191500008dbYLgjztU.jpg', '30 กันยายน 2562 time 15:00:20', 'AA30092019150000jZJBNlpS9U'),
(7, 'บทความวิชาการ ++', '+ test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + + test + ', '1', '30 กันยายน 2562 time 15:20:59', '30092019152059miNgPSuLo6.jpg', '', 'AA30092019152059ROkEsZ9NrQ'),
(8, 'check test บทความวิชาการ', '๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ๙๙๙ ', '2', '30 กันยายน 2562 time 15:50:30', '30092019155030nax8ISleTh.png', '04 ตุลาคม 2562 time 15:55:52', 'AA30092019155030Q2lOzQJA2Z'),
(9, 'S2 Academic Article', 'ก็มาดิคร้าบบบบ', '1', '04 ตุลาคม 2562 time 16:03:32', '04102019160332IlhayQm8lT.jpg', '', 'AA04102019160332OpXbbmv9pU');

-- --------------------------------------------------------

--
-- Table structure for table `academic_article_category`
--

CREATE TABLE `academic_article_category` (
  `aac_id` int(11) NOT NULL,
  `aac_title` varchar(100) NOT NULL,
  `aac_description` text NOT NULL,
  `aac_image` text NOT NULL,
  `aac_create_date` varchar(50) NOT NULL,
  `aac_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `academic_article_category`
--

INSERT INTO `academic_article_category` (`aac_id`, `aac_title`, `aac_description`, `aac_image`, `aac_create_date`, `aac_update_date`) VALUES
(1, 'วิชาการ 01', '+1', '', '', ''),
(2, 'วิชาการ 02', '+2', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `a_id` int(11) NOT NULL,
  `a_title` text NOT NULL,
  `a_detail` text NOT NULL,
  `a_category` varchar(50) NOT NULL,
  `a_create_date` varchar(50) NOT NULL,
  `a_image` text NOT NULL,
  `a_update_date` varchar(50) NOT NULL,
  `a_file_key` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`a_id`, `a_title`, `a_detail`, `a_category`, `a_create_date`, `a_image`, `a_update_date`, `a_file_key`) VALUES
(27, 'gr', 'een', '', '28 สิงหาคม 2562 time 14:34:58', '28082019143458YRshJqMn9b.jpg', '', 'A28082019143458VGArYsy4IT'),
(28, 'gt', 'eet', '', '28 สิงหาคม 2562 time 14:36:06', '28082019143606Jc6B8lobDE.png', '', 'A28082019143606uSLrfYRDZH'),
(29, 'gt', 'eet', '', '28 สิงหาคม 2562 time 14:41:27', '28082019144127craeSAHeiv.png', '', 'A28082019144127s5602gASdF'),
(30, 'gt', 'eet', '', '28 สิงหาคม 2562 time 14:42:18', '28082019144218cUe39k7soS.png', '', 'A28082019144218EcXgPjrH1C'),
(32, 'ag', 'f', '', '28 สิงหาคม 2562 time 14:58:47', '28082019145847rvTLxY1ceH.jpg', '', 'A280820191458472XIBtkZdsK'),
(33, 'ag', 'f', '', '28 สิงหาคม 2562 time 14:59:29', '280820191459296NZdiGRIkt.jpg', '', 'A280820191459299sebAFXeeO'),
(34, 'agffafasf now', 'f', '', '28 สิงหาคม 2562 time 14:59:57', '28082019145957nlYnuV7tNE.jpg', '', 'A28082019145957SimOCe0BkZ'),
(35, 'last of us', 'lou', '', '28 สิงหาคม 2562 time 15:23:05', '28082019152305br7Grhgqrs.png', '', 'A28082019152305g7qGel8NEL'),
(36, 'last of us2', 'lou2', '', '28 สิงหาคม 2562 time 15:25:27', '28082019152527KJZC9NoZ6y.png', '', 'A28082019152527Mh9NRwHxaY'),
(37, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:35:54', '28082019153554E68uyjD2xf.jpg', '', 'A28082019153554TkE9eVAzUM'),
(38, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:38:38', '28082019153838hPmAgyOzjN.jpg', '', 'A28082019153838C9yRkzesxv'),
(39, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:39:24', '28082019153924gqe5sCQuNZ.jpg', '', 'A28082019153924YMQ14bTVxt'),
(40, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:40:10', '28082019154010lMJ1qRv35h.jpg', '', 'A28082019154010rltroIQdXu'),
(41, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:41:07', '28082019154107iXztcUsZrT.jpg', '', 'A28082019154107MkTKB9i2g0'),
(42, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:43:26', '28082019154326IMwJtPXjIe.jpg', '', 'A28082019154326o5W8VwF5di'),
(43, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:45:00', '28082019154500xAQc4ULtzf.jpg', '', 'A28082019154500tGbjjVnqct'),
(44, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:46:56', '28082019154656fdkD2ONWRw.jpg', '', 'A28082019154656dUgUR1gdYV'),
(45, 'sf', 'gg', '', '28 สิงหาคม 2562 time 15:47:51', '28082019154751gXB1yuvHr6.jpg', '', 'A28082019154751fVrhIWEfjR'),
(46, 'hhh', 'asd', '', '28 สิงหาคม 2562 time 15:49:37', '280820191549375MrOxWBgnj.jpg', '', 'A280820191549372EL719zBWZ'),
(54, 'test files', 'test', '', '29 สิงหาคม 2562 time 16:40:14', '29082019164014T4vMCwHhR0.png', '', 'A29082019164014lnMb0klhSL'),
(55, 'ad test', 'test file', '', '29 สิงหาคม 2562 time 17:02:09', '29082019170209EMeHIkt11u.jpg', '', 'A29082019170209I8679jUlvg'),
(56, 'a', 'g', '', '29 สิงหาคม 2562 time 17:05:08', '29082019170508bD5iYaLEP4.jpg', '', 'A29082019170508L1RnflDfgi'),
(57, 'test zip files Edit test', 'test download zip', '', '30 สิงหาคม 2562 time 11:25:55', '300820191125557PMdcOiiyL.jpg', '02 กันยายน 2562 time 12:40:57', 'A30082019112555RY1hRjOFn5'),
(58, 'head', 'detail', '', '02 กันยายน 2562 time 15:16:19', '02092019151619xHjkzXeTyx.png', '', 'A020920191516198ITB5UXmpw'),
(59, 'a', 'a ant มด', '', '02 กันยายน 2562 time 15:56:03', '020920191556034P7tFbCxUs.png', '', 'A02092019155603eiDRbg88QC'),
(60, 'อีดิท น่าสนใจ', 'ๆๆๆ', '2', '02 กันยายน 2562 time 15:57:11', '02092019155711EbEiLIKs9z.jpg', '03 กันยายน 2562 time 12:08:59', 'A02092019155711g2BmyvY4hj'),
(61, 'ม', 'ท', '', '02 กันยายน 2562 time 16:00:31', '02092019160031PUYYLapvoK.png', '02 กันยายน 2562 time 16:06:56', 'A02092019160031gI0JGt3rS5'),
(62, 'ฟฟฟฟฟฟฟฟฟฟฟ', 'ห้เหก้ หเหก', '1', '02 กันยายน 2562 time 16:02:21', '02092019160221m7zZF9bPeR.png', '05 กันยายน 2562 time 11:53:00', 'A020920191602217coAqFI6Fr'),
(63, 'ฟหกด่าสว', 'OP', '1', '02 กันยายน 2562 time 16:08:08', '020920191608089PIE1Vxwza.jpg', '05 กันยายน 2562 time 11:38:27', 'A02092019160808MDA7LoC8Tj'),
(64, 'DD 64', 'no more i DD', '2', '02 กันยายน 2562 time 16:08:45', '05092019143744FakhXW9Gs8.png', '05 กันยายน 2562 time 14:37:44', 'A020920191608454KsIrF78nF'),
(65, 'JPG', 'heal', '1', '05 กันยายน 2562 time 14:48:25', '05092019144825B8dLW516j9.png', '', 'A05092019144825Mr8tYRCvJU'),
(66, 'h', 'a', '1', '05 กันยายน 2562 time 15:20:21', '05092019152021lwPf3yBGag.png', '', 'A05092019152021czgkzE7zkG'),
(67, 'Head Ar III', 'DD', '2', '05 กันยายน 2562 time 15:21:49', '16092019120746zCr1JTv4li.png', '16 กันยายน 2562 time 12:07:46', 'A05092019152149bgqDejkcA9'),
(68, 'Article New test ++', '++ test image cat03', '2', '16 กันยายน 2562 time 12:09:24', '16092019120924tOroJ8igeS.jpg', '16 กันยายน 2562 time 12:11:48', 'A160920191209243PkJnsU6FV'),
(70, '70', '++', '1', '16 กันยายน 2562 time 12:19:54', '16092019121954DW0ysfhJNO.jpg', '07 ตุลาคม 2562 time 16:24:30', 'A16092019121954HaQJkqUtTi'),
(71, 'test page ++', 'test page', '1', '08 ตุลาคม 2562 time 14:59:41', '08102019145940FNgLfJInJa.jpg', '', 'A08102019145940VTBX7mnDU2'),
(72, 'test page 2 ++', 'test page again ++', '2', '08 ตุลาคม 2562 time 15:00:07', '08102019150007ZSUbweX2iE.png', '', 'A08102019150007AmgQfkvnAJ');

-- --------------------------------------------------------

--
-- Table structure for table `article_category`
--

CREATE TABLE `article_category` (
  `ac_id` int(11) NOT NULL,
  `ac_title` varchar(100) NOT NULL,
  `ac_description` text NOT NULL,
  `ac_create_date` varchar(50) NOT NULL,
  `ac_update_date` varchar(50) NOT NULL,
  `ac_image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `article_category`
--

INSERT INTO `article_category` (`ac_id`, `ac_title`, `ac_description`, `ac_create_date`, `ac_update_date`, `ac_image`) VALUES
(1, 'บทความน่าสนใจ', '', '', '', ''),
(2, 'บทความเทคนิคดีๆ', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `banking`
--

CREATE TABLE `banking` (
  `b_id` int(11) NOT NULL,
  `b_name` varchar(200) NOT NULL,
  `b_account_name` varchar(250) NOT NULL,
  `b_account_number` varchar(10) NOT NULL,
  `b_description` varchar(250) NOT NULL,
  `b_create_date` varchar(100) NOT NULL,
  `b_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `banking`
--

INSERT INTO `banking` (`b_id`, `b_name`, `b_account_name`, `b_account_number`, `b_description`, `b_create_date`, `b_update_date`) VALUES
(1, 'ธนาคาร กรุงใคร', ' A krungkrai', '1234567890', 'ตกลง กรุงใคร ?', '', ''),
(2, 'ธนาคาร ใครพานิด', 'A Kraipanid', '1357908642', 'แล้วใครพานิด ?', '', ''),
(3, 'ธนาคาร ทหารใคร', 'A tahankrai', '0987654321', 'ทหารใคร ? ( อันนี้ ผมไม่หารนะครับ )', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `files_upload`
--

CREATE TABLE `files_upload` (
  `f_id` int(11) NOT NULL,
  `f_name` text NOT NULL,
  `f_title` text NOT NULL,
  `f_key` varchar(100) NOT NULL,
  `f_create_date` varchar(50) NOT NULL,
  `f_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `files_upload`
--

INSERT INTO `files_upload` (`f_id`, `f_name`, `f_title`, `f_key`, `f_create_date`, `f_update_date`) VALUES
(158, '04102019155431Cb8FS4vDSe.jpg', 'news cat test ', 'N16092019121653a46KDb8723', '04 ตุลาคม 2562 time 15:54:31', ''),
(159, '04102019155500GAE0qbHD8k.jpg', 'article cat test ', 'A16092019121954HaQJkqUtTi', '04 ตุลาคม 2562 time 15:55:00', ''),
(160, '04102019155525EL6meBhbSW.jpg', 'online_journal cat test ', 'OJ01102019163225MX3kTwDqzM', '04 ตุลาคม 2562 time 15:55:25', ''),
(161, '04102019155552AHXpj6xHY5.jpg', 'academic article cat test ', 'AA30092019155030Q2lOzQJA2Z', '04 ตุลาคม 2562 time 15:55:52', ''),
(164, '04102019155951Ir7LcAuQpE.rar', 'max 1', 'N04102019155841qd1WH1053g', '04 ตุลาคม 2562 time 15:59:51', ''),
(165, '04102019155951hjP2mCpGnQ.fa19f1cc.rar', 'max 2', 'N04102019155841qd1WH1053g', '04 ตุลาคม 2562 time 15:59:51', ''),
(166, '04102019155951Q2IbbHSYyu.fa19f1cc.rar', 'max 3', 'N04102019155841qd1WH1053g', '04 ตุลาคม 2562 time 15:59:51', ''),
(169, '041020191603327tSDMEU2qC.3.1-dist.zip', 'บูทสแตรบ สี่ จุด สาม จุด หนึ่ง', 'AA04102019160332OpXbbmv9pU', '04 ตุลาคม 2562 time 16:03:33', ''),
(170, '04102019160442Nf9Q2tiQtK.1.1.zip', 'bootstrap 4.1.1', 'OJ04102019160442abSsv8YpFA', '04 ตุลาคม 2562 time 16:04:42', ''),
(171, '07102019162430nVIjH6Dter.rar', 'max test', 'A16092019121954HaQJkqUtTi', '07 ตุลาคม 2562 time 16:24:31', '');

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `g_id` int(11) NOT NULL,
  `g_name` varchar(250) NOT NULL,
  `g_release_date` varchar(100) NOT NULL,
  `g_image` varchar(250) NOT NULL,
  `g_description` text NOT NULL,
  `g_create_date` varchar(100) NOT NULL,
  `g_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`g_id`, `g_name`, `g_release_date`, `g_image`, `g_description`, `g_create_date`, `g_update_date`) VALUES
(2, 'test B edit', '', '27092019140750JB9nc67fpd.png', 'BB ++', '26 กันยายน 2562 time 17:04:45', '27 กันยายน 2562 time 15:10:52'),
(3, 'test C++', '', '26092019170656k7EocbONbQ.png', 'C', '26 กันยายน 2562 time 17:06:56', '27 กันยายน 2562 time 15:15:34'),
(4, 'test D', '', '26092019170748oZTW7X6CwH.jpg', 'D', '26 กันยายน 2562 time 17:07:48', ''),
(5, 'cat test', '', '27092019132727TkpNiF8cq0.jpg', '++', '27 กันยายน 2562 time 13:27:27', ''),
(6, 'test ppaa test cat ++ test again', '', '27092019164733UEF2WaqXA6.jpg', 'test test', '27 กันยายน 2562 time 13:31:59', '27 กันยายน 2562 time 16:47:33');

-- --------------------------------------------------------

--
-- Table structure for table `gallery_image`
--

CREATE TABLE `gallery_image` (
  `gi_id` int(11) NOT NULL,
  `gi_image` text NOT NULL,
  `gi_gallery_id` varchar(10) NOT NULL,
  `gi_create_date` varchar(100) NOT NULL,
  `gi_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallery_image`
--

INSERT INTO `gallery_image` (`gi_id`, `gi_image`, `gi_gallery_id`, `gi_create_date`, `gi_update_date`) VALUES
(3, '26092019170445bbiZp3Z5lc.jpg', '2', '26 กันยายน 2562 time 17:04:45', ''),
(4, '26092019170445Vqg72FXDhz.jpg', '2', '26 กันยายน 2562 time 17:04:45', ''),
(7, '26092019170656n497VtcgrI.png', '3', '26 กันยายน 2562 time 17:06:56', ''),
(8, '26092019170656VORMCT2BpH.jpg', '3', '26 กันยายน 2562 time 17:06:56', ''),
(10, '26092019170748UlR5nigLlB.png', '4', '26 กันยายน 2562 time 17:07:48', ''),
(11, '26092019170748Alcqq0MoG8.jpg', '4', '26 กันยายน 2562 time 17:07:48', ''),
(12, '27092019132727EbYynV8RQO.jpg', '5', '27 กันยายน 2562 time 13:27:27', ''),
(19, '270920191405369EHnw8Qcmd.jpg', '6', '27 กันยายน 2562 time 14:05:36', ''),
(20, '270920191405367KEPWw7Fdu.jpg', '6', '27 กันยายน 2562 time 14:05:36', ''),
(21, '27092019140536S6KGMnqxNI.jpg', '6', '27 กันยายน 2562 time 14:05:36', ''),
(22, '27092019140750dQc1KUE59O.jpg', '2', '27 กันยายน 2562 time 14:07:50', ''),
(23, '27092019140750kPIP7K8Y8F.png', '2', '27 กันยายน 2562 time 14:07:50', ''),
(24, '27092019151052iGiZ5MYHXO.jpg', '2', '27 กันยายน 2562 time 15:10:52', ''),
(25, '27092019151052zaKxyQboLy.jpg', '2', '27 กันยายน 2562 time 15:10:52', ''),
(26, '27092019151052G9kCao15Wr.png', '2', '27 กันยายน 2562 time 15:10:52', ''),
(27, '27092019151052017LXJh6vY.jpg', '2', '27 กันยายน 2562 time 15:10:52', ''),
(28, '27092019151052DVQHTj7vHN.jpg', '2', '27 กันยายน 2562 time 15:10:52', ''),
(29, '27092019151236jNjF9B5Tex.png', '6', '27 กันยายน 2562 time 15:12:36', ''),
(30, '27092019151236ezstwUAsCY.jpg', '6', '27 กันยายน 2562 time 15:12:36', ''),
(31, '27092019151236mdF3nRieLf.jpg', '6', '27 กันยายน 2562 time 15:12:36', ''),
(32, '270920191514010wZdnpmcBB.png', '3', '27 กันยายน 2562 time 15:14:01', ''),
(33, '27092019151401zx9hNbaQt6.jpg', '3', '27 กันยายน 2562 time 15:14:01', ''),
(35, '27092019151534gG3MWazP31.png', '3', '27 กันยายน 2562 time 15:15:34', '');

-- --------------------------------------------------------

--
-- Table structure for table `logged`
--

CREATE TABLE `logged` (
  `l_id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `l_id_m_id` text NOT NULL,
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logged`
--

INSERT INTO `logged` (`l_id`, `time`, `l_id_m_id`, `token`) VALUES
(78, '2019-09-04 09:02:20', '16', '0409201916022016UCEk0mDqEl'),
(80, '2019-09-10 09:22:07', '14', '1009201916220714jAvdCmR5yq'),
(94, '2019-09-13 07:56:35', '12', '1309201914563512rnE3l5Q8MY'),
(106, '2019-09-19 06:02:47', '12', '19092019130247125WoMG2YNDf'),
(211, '2019-10-09 03:24:22', '1', '091020191024221SUSplqNozN');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `m_id` int(11) NOT NULL,
  `m_id_number` varchar(10) NOT NULL,
  `m_firstname` varchar(50) NOT NULL,
  `m_lastname` varchar(50) NOT NULL,
  `m_firstname_eng` varchar(100) NOT NULL,
  `m_lastname_eng` varchar(100) NOT NULL,
  `m_username` varchar(50) NOT NULL,
  `m_status` varchar(50) NOT NULL,
  `m_password` varchar(100) NOT NULL,
  `m_imageprofile` varchar(50) NOT NULL,
  `m_type` varchar(10) NOT NULL,
  `m_upgrade_date_id` varchar(50) NOT NULL,
  `m_company` varchar(250) NOT NULL,
  `m_phone` varchar(20) NOT NULL,
  `m_email` varchar(100) NOT NULL,
  `m_institute` varchar(250) NOT NULL,
  `m_address` text NOT NULL,
  `m_create_date` varchar(50) NOT NULL,
  `m_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`m_id`, `m_id_number`, `m_firstname`, `m_lastname`, `m_firstname_eng`, `m_lastname_eng`, `m_username`, `m_status`, `m_password`, `m_imageprofile`, `m_type`, `m_upgrade_date_id`, `m_company`, `m_phone`, `m_email`, `m_institute`, `m_address`, `m_create_date`, `m_update_date`) VALUES
(1, '100', 'ดวงดี Admin +123', 'มูลคำ', 'Dusngdee ENG', 'Moolkham ENG', 'max', 'admin', 'f561aaf6ef0bf14d4208bb46a4ccb3ad', '03102019120654RipxfeHYIt.png', '3', '25', '123', '0980980980', 'MAXMAIL@Mail.com', 'ดาวอังคาร', 'The Moon', '', '04 ตุลาคม 2562 time 11:23:20 ( Edit By Admin )'),
(2, '', 'JPEG IS Real ?', 'm', '', '', 'xxx', 'user', 'f561aaf6ef0bf14d4208bb46a4ccb3ad', '12092019171138y16v7uQcds.png', '2', '17', '', '', '', '', '', '', '02 ตุลาคม 2562 time 16:10:16 ( Edit By Admin )'),
(3, '', 'zzz First ++', 'zzz Last', 'FZeng', 'LZeng', 'zzz', 'admin', 'f3abb86bd34cf4d52698f14c0da1dc60', '02092019120759BSL755Z3iP.jpg', '3', '18', 'no', '0987654321', 'Z@g', 'no have', 'no have too', '', '02 ตุลาคม 2562 time 16:10:30 ( Edit By Admin )'),
(4, '10101011', 'ดวงดี ---', 'มูลคำ', 'Duangdee', 'Moolkham', 'corazon', 'user', 'f561aaf6ef0bf14d4208bb46a4ccb3ad', 'jpg.png', '3', '26', 'company', '1234567890', 'max@mail', 'institute', 'address', 'C Date', '03 ตุลาคม 2562 time 14:23:49 ( Edit By Admin )'),
(5, '', 'เอ', 'เอเอ', 'A', 'AA', 'aaa', 'user', '47bce5c74f589f4867dbd57e9ca9f808', '02092019125206JP3ilnGpRZ.png', '1', '', '', '0192837465', 'a@amail.com', 'No', 'ad ee', '02 กันยายน 2562 time 12:09:53', '02 ตุลาคม 2562 time 15:45:18 ( Edit By Admin )'),
(6, '', 'real', 'laer', '', '', 'qqq', 'user', 'b2ca678b4c936f905fb82f2733f5297f', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:06:27', ''),
(7, '', 'eeee', 'eee', '', '', 'eee', 'user', 'd2f2297d6e829cd3493aa7de4416a18f', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:09:37', ''),
(8, '', 'rrrF', 'rrrL', '', '', 'rrr', 'user', '44f437ced647ec3f40fa0841041871cd', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:12:10', ''),
(9, '', 'ooo', 'ooo', '', '', 'ooo', 'user', '7f94dd413148ff9ac9e9e4b6ff2b6ca9', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:14:24', ''),
(10, '', 'sss', 'sss', '', '', 'sss', 'user', '9f6e6800cfae7749eb6c486619254b9c', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:18:01', '03 ตุลาคม 2562 time 11:59:24 ( Edit By Admin )'),
(11, '', 'www', 'www', '', '', 'www', 'user', '4eae35f1b35977a00ebd8086c259d4c9', '', '2', '', '', '', '', '', '', '02 กันยายน 2562 time 14:23:34', '02 ตุลาคม 2562 time 13:09:20 ( Edit By Admin )'),
(12, '', 'iii', 'iii', '', '', 'iii', 'user', '36347412c7d30ae6fde3742bbc4f21b9', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:24:11', ''),
(13, '', '', '', '', '', 'x', 'user', '000', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:18:23', ''),
(14, '', 'mmmm', 'mmm', '', '', 'xo', 'user', 'f13dfee35a80a761918d326acd591d12', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:20:56', ''),
(15, '', 'ma', 'xa', '', '', 'z', 'user', 'fbade9e36a3f36d3d676c1b808451dd7', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:42:08', ''),
(16, '', 'lll', 'lll', '', '', 'loop', 'user', 'e48b981fb62db33b98a27fc6cf8bf40a', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:43:26', ''),
(17, '', '', '', '', '', 'xw', 'user', '000', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:48:03', ''),
(18, '', 'pl', 'll', '', 'a', 'root', 'user', 'c6f057b86584942e415435ffb1fa93d4', '', '1', '', '', '', '', '', '', '11 กันยายน 2562 time 18:21:25', '03 ตุลาคม 2562 time 16:23:01 ( Edit By Admin )'),
(19, '', 'ทดสอบ', '๙๙', 'test', '99', 'mmm', 'user', '000', '03102019120802Fq7Qqap4ei.png', '3', '23', '', '', '', '', '', '11 กันยายน 2562 time 18:21:44', '03 ตุลาคม 2562 time 16:12:22 ( Edit By Admin )');

-- --------------------------------------------------------

--
-- Table structure for table `member_type`
--

CREATE TABLE `member_type` (
  `mt_id` int(11) NOT NULL,
  `mt_name` varchar(50) NOT NULL,
  `mt_create_date` varchar(50) NOT NULL,
  `mt_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `member_type`
--

INSERT INTO `member_type` (`mt_id`, `mt_name`, `mt_create_date`, `mt_update_date`) VALUES
(1, 'Member ', '', ''),
(2, 'Full Member', '', ''),
(3, 'Gold Member', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `member_upgrade_date`
--

CREATE TABLE `member_upgrade_date` (
  `mud_id` int(11) NOT NULL,
  `mud_date_start` varchar(50) NOT NULL,
  `mud_date_end` varchar(50) NOT NULL,
  `mud_create_date` varchar(50) NOT NULL,
  `mud_update_date` varchar(50) NOT NULL,
  `mud_member_own_id` varchar(10) NOT NULL,
  `mud_member_type_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `member_upgrade_date`
--

INSERT INTO `member_upgrade_date` (`mud_id`, `mud_date_start`, `mud_date_end`, `mud_create_date`, `mud_update_date`, `mud_member_own_id`, `mud_member_type_id`) VALUES
(16, '02-10-2019 16:09:59', '02-10-2020 16:09:59', '02 ตุลาคม 2562 time 16:09:59', '', '1', '3'),
(17, '02-10-2019 16:10:16', '02-12-2019 16:10:16', '02 ตุลาคม 2562 time 16:10:16', '', '2', '2'),
(18, '02-10-2019 16:10:30', '02-07-2020 16:10:30', '02 ตุลาคม 2562 time 16:10:30', '', '3', '3'),
(19, '02-10-2019 16:12:06', '02-08-2020 16:12:06', '02 ตุลาคม 2562 time 16:12:06', '', '1', '3'),
(20, '02-10-2019 16:33:26', '02-10-2020 16:33:26', '02 ตุลาคม 2562 time 16:33:26', '', '19', '2'),
(21, '02-10-2019 16:34:08', '02-11-2019 16:34:08', '02 ตุลาคม 2562 time 16:34:08', '', '19', '3'),
(22, '02-10-2019 16:38:31', '02-10-2020 16:38:31', '02 ตุลาคม 2562 time 16:38:31', '', '19', '2'),
(23, '02-10-2019 16:40:37', '02-11-2019 16:40:37', '02 ตุลาคม 2562 time 16:40:37', '', '19', '3'),
(24, '03-10-2019 11:59:43', '03-11-2019 11:59:43', '03 ตุลาคม 2562 time 11:59:43', '', '1', '2'),
(25, '03-10-2019 12:01:06', '03-10-2020 12:01:06', '03 ตุลาคม 2562 time 12:01:06', '', '1', '3'),
(26, '03-10-2019 14:22:37', '03-11-2019 14:22:37', '03 ตุลาคม 2562 time 14:22:37', '', '4', '3');

-- --------------------------------------------------------

--
-- Table structure for table `money_transfer`
--

CREATE TABLE `money_transfer` (
  `mtf_id` int(11) NOT NULL,
  `mtf_payments_id` varchar(50) NOT NULL,
  `mtf_member_id` varchar(50) NOT NULL,
  `mtf_title` varchar(250) NOT NULL,
  `mtf_banking_id` varchar(50) NOT NULL,
  `mtf_slip` text NOT NULL,
  `mtf_date` varchar(100) NOT NULL,
  `mtf_comment` text NOT NULL,
  `mtf_create_date` varchar(100) NOT NULL,
  `mtf_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `money_transfer`
--

INSERT INTO `money_transfer` (`mtf_id`, `mtf_payments_id`, `mtf_member_id`, `mtf_title`, `mtf_banking_id`, `mtf_slip`, `mtf_date`, `mtf_comment`, `mtf_create_date`, `mtf_update_date`) VALUES
(1, '2', '1', 'จ่ายแล้วนะ', '', '23092019161641s7aDWVjf3T.png', '12-09-2019 22:00', 'comment test Go Go Go', '23 กันยายน 2562 time 16:16:41', ''),
(2, '2', '1', 'จ่ายอีก', '', '230920191620553OxJs89yiJ.jpg', '12-09-2019 00:00', 'จ่ายแล้ว ครับ', '23 กันยายน 2562 time 16:20:55', ''),
(3, '2', '1', 'จ่าย ++', '', '23092019165800ejGjeLLBWq.jpg', '23-09-2019 11:30', 'comment', '23 กันยายน 2562 time 16:58:00', ''),
(4, '1', '2', 'x pay', '2', '24092019122014whkkIuxcqY.jpg', '24-09-2019 12:20', 'p x p x p', '24 กันยายน 2562 time 12:20:14', ''),
(5, '1', '1', 'จ่าย ๙๙๙', '1', '25092019171910hupzAlyPm8.jpg', '25-09-2019 17:18', '+++', '25 กันยายน 2562 time 17:19:10', ''),
(6, '2', '1', 'gogogo', '', '260920191409547Hq7Z8wi3u.jpg', '26-09-2019 00:00', 'gg', '26 กันยายน 2562 time 14:09:54', ''),
(7, '1', '1', 'aaa', '1', '260920191426591ORMhtSNe0.jpg', '26-09-2019 00:00', 'aaafff', '26 กันยายน 2562 time 14:26:59', ''),
(8, '1', '1', 'lolol', '1', '26092019143028fZsR2VpwJt.jpg', '26-09-2019 00:00', 'lll', '26 กันยายน 2562 time 14:30:28', ''),
(9, '2', '1', 'fg', '', '26092019143211fMAUwvphtE.jpg', '26-09-2019 00:00', 'adww', '26 กันยายน 2562 time 14:32:11', ''),
(10, '2', '1', 'hhh', '', '26092019143322zQ154Yej4H.png', '26-09-2019 00:00', 'hheett', '26 กันยายน 2562 time 14:33:22', ''),
(11, '1', '1', 'test', '1', '26092019143519FJHBNtZcO1.jpg', '26-09-2019 00:00', '++', '26 กันยายน 2562 time 14:35:19', ''),
(12, '1', '1', '++', '2', '26092019143609kEDy3Rrunt.jpg', '26-09-2019 00:00', 'mmm', '26 กันยายน 2562 time 14:36:09', ''),
(13, '1', '1', 'max pay', '3', '26092019144302DMEz0d0wOZ.jpg', '26-09-2019 00:00', '+d', '26 กันยายน 2562 time 14:43:02', ''),
(14, '2', '1', 'ttt', '', '26092019144838ys8lpVefOb.png', '26-09-2019 00:00', 'test 2', '26 กันยายน 2562 time 14:48:38', ''),
(15, '2', '1', 'max PP', '', '26092019145959qyTm7eBJoJ.jpg', '26-09-2019 00:00', '+', '26 กันยายน 2562 time 14:59:59', ''),
(16, '1', '1', 'PPP', '2', '26092019150312Rz1f8Aa8d5.jpg', '12-09-2019 00:00', '+ p', '26 กันยายน 2562 time 15:03:13', ''),
(17, '2', '1', 'max pay test', '', '26092019150442TSNcYOJGvy.jpg', '26-09-2019 00:00', '++ test //', '26 กันยายน 2562 time 15:04:42', ''),
(18, '1', '1', 'test blank', '1', '26092019150942Tl6Er6nNAg.jpg', '26-09-2019 23:00', '++', '26 กันยายน 2562 time 15:09:42', ''),
(19, '2', '1', 'test pay and blank', '', '26092019151225i6p0PKI3Tb.jpg', '26-09-2019 00:00', '++', '26 กันยายน 2562 time 15:12:25', ''),
(20, '2', '1', '-go', '', '26092019151339JymFE7JIW3.jpg', '26-09-2019 00:00', '-go ++', '26 กันยายน 2562 time 15:13:39', ''),
(21, '2', '1', 'max PAY again ++', '', '26092019151705kchC4IKHma.jpg', '26-09-2019 00:00', '+', '26 กันยายน 2562 time 15:17:05', ''),
(22, '1', '1', 'PPPaaayyy', '2', '26092019151824DcUS6hMWsz.jpg', '26-09-2019 00:00', '+;pdadrsgdh', '26 กันยายน 2562 time 15:18:24', ''),
(23, '2', '1', 'madwrwqrerr', '', '26092019152044pZkzLFnjY8.jpg', '26-09-2019 00:00', '+', '26 กันยายน 2562 time 15:20:44', '');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `n_id` int(11) NOT NULL,
  `n_title` text NOT NULL,
  `n_detail` text NOT NULL,
  `n_create_date` varchar(50) NOT NULL,
  `n_image` text NOT NULL,
  `n_update_date` varchar(50) NOT NULL,
  `n_file_key` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`n_id`, `n_title`, `n_detail`, `n_create_date`, `n_image`, `n_update_date`, `n_file_key`) VALUES
(1, 'first news', 'First NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst NewsFirst News', '09 สิงหาคม 2562', '09082019150024t7cOlWKSAM.png', '2019-08-27 12:11:55', 'N1'),
(2, 'Second News', '2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 ', '09 สิงหาคม 2562', '21082019153515QL56ZnnvcX.jpg', '2019-08-21 15:40:29', 'N2'),
(3, 'Third News', 'Third NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird NewsThird News', '09 สิงหาคม 2562', '09082019150538dqEi1JDxud.png', '2019-08-21 15:40:29', 'N3'),
(4, '4', '4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 ', '09 สิงหาคม 2562', '090820191506457UZem5eaDf.png', '2019-08-21 15:40:29', 'N4'),
(5, '5 ', '5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 \n', '09 สิงหาคม 2562', '09082019150809lZFJ5K9hOQ.png', '2019-08-21 15:40:29', 'N5'),
(6, '6', 'six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six six ', '09 สิงหาคม 2562', '09082019150930c2a0LEweth.png', '2019-08-21 15:40:29', 'N6'),
(7, 'seven', 'seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven seven ', '09 สิงหาคม 2562', '09082019151042et3bMGNViA.png', '2019-08-21 15:40:29', 'N7'),
(8, '8 ', '8 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 88 8 8 8\n', '09 สิงหาคม 2562', '09082019151447qBnbBdOqZQ.png', '2019-08-21 15:40:29', 'N8'),
(9, '9', '9 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 99 9 99 9', '09 สิงหาคม 2562', '09082019151537mANNBpVkt6.png', '2019-08-21 15:40:29', 'N9'),
(10, '10', 'ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten ten \n', '09 สิงหาคม 2562', '090820191516536Kv48Z9xTO.png', '2019-08-21 15:40:29', 'N10'),
(11, 'ข่าวใหม่', 'ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ข่าวใหม่ ', '13 สิงหาคม 2562', '1308201916025846MMVsNVRZ.jpg', '2019-08-21 15:40:29', 'N11'),
(12, 'ข่าวใหม่กว่า', 'ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ne w ', '16 สิงหาคม 2562', '160820191206149RJtSFgbpz.jpg', '2019-08-21 15:40:29', 'N12'),
(13, 'new news 19/8', 'newnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n nnewnnn n n n n', '19 สิงหาคม 2562', '19082019145437d1dAywg3Hs.jpg', '2019-08-21 15:40:29', 'N13'),
(14, 'new 2', 'a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a ', '19 สิงหาคม 2562', '190820191503495ywC49VpKD.jpg', '2019-08-21 15:40:29', 'N14'),
(15, 'JPG is real ?', 'jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh jpg fight oh ', '19 สิงหาคม 2562', '19082019151226KMRl8GHzxN.png', '2019-08-21 15:40:29', 'N15'),
(16, 'newxxxaaarrr', ' mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa  mewa ', '19 สิงหาคม 2562', '19082019151815XMA0Bn1Eh1.jpg', '05 กันยายน 2562 time 12:07:51', 'N16'),
(17, 'az', 'za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za za ', '19 สิงหาคม 2562', '19082019151920lxnC2gscfr.png', '05 กันยายน 2562 time 11:58:44', 'N17'),
(18, 'ข่าวใหม่จัดๆ กว่าเมื่อกี้', 'จัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีกจัดๆ อีก', '20 สิงหาคม 2562', '20082019143841OcxCtsNGk9.png', '05 กันยายน 2562 time 11:54:27', 'N18'),
(19, 'จัดๆ อีกละ', 'จัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆจัดๆ ๆ', '20 สิงหาคม 2562', '200820191441074njfofI007.jpg', '05 กันยายน 2562 time 10:40:52', 'N19'),
(20, 'แมว 15 HD', 'HD แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15แมว 15', '20 สิงหาคม 2562', '05092019143904dhmeMfVJ9b.jpg', '05 กันยายน 2562 time 14:39:04', 'N20'),
(21, '21', '21 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 2121 21 21', '20 สิงหาคม 2562', '05092019125749yss1gZTdvI.png', '05 กันยายน 2562 time 14:00:07', 'N21'),
(22, 'ข่าวใหม่ ๆ ๆ ๆ ๆ ', ' ม ม ม', '05 กันยายน 2562 time 15:14:11', '05092019151411YVxuPqWhNj.png', '', 'N05092019151411VtEegyNed7'),
(23, 'หัวเรื่อง 123 test Edit', 'รายละเอียด', '11 กันยายน 2562 time 18:33:01', '16092019121553iuSRLz2Qyl.jpg', '16 กันยายน 2562 time 12:15:53', 'N11092019183301zZY7cGuhuI'),
(24, 'Green W', 'GG', '16 กันยายน 2562 time 12:16:53', '16092019121653Y2Q8hpwShc.jpg', '04 ตุลาคม 2562 time 15:54:31', 'N16092019121653a46KDb8723'),
(25, 'tete', '++', '04 ตุลาคม 2562 time 15:58:41', '04102019155841HpRm4MYF5D.jpg', '07 ตุลาคม 2562 time 16:12:24', 'N04102019155841qd1WH1053g');

-- --------------------------------------------------------

--
-- Table structure for table `online_journal`
--

CREATE TABLE `online_journal` (
  `oj_id` int(11) NOT NULL,
  `oj_title` varchar(250) NOT NULL,
  `oj_description` text NOT NULL,
  `oj_detail` text NOT NULL,
  `oj_file_key` varchar(100) NOT NULL,
  `oj_permission` varchar(50) NOT NULL,
  `oj_create_date` varchar(50) NOT NULL,
  `oj_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `online_journal`
--

INSERT INTO `online_journal` (`oj_id`, `oj_title`, `oj_description`, `oj_detail`, `oj_file_key`, `oj_permission`, `oj_create_date`, `oj_update_date`) VALUES
(3, 'edit ++', 'desc + e', 'detail + e', 'OJ01102019145154YsqUPAoKEO', '1', '01 ตุลาคม 2562 time 14:51:54', '01 ตุลาคม 2562 time 15:27:22'),
(4, '++ test ++', 'desc', 'detail +', 'OJ0110201915320287M21S9ZMu', '3', '01 ตุลาคม 2562 time 15:32:02', '01 ตุลาคม 2562 time 16:00:21'),
(5, 'test per2', 'd', 'test per 2', 'OJ01102019163116ltqtwyRzbI', '2', '01 ตุลาคม 2562 time 16:31:16', ''),
(6, 'test per 1', '++\n', 'per 1 can see\n', 'OJ01102019163150uYvSWMJdfQ', '1', '01 ตุลาคม 2562 time 16:31:50', '01 ตุลาคม 2562 time 16:39:29'),
(7, 'just per 3 can see', 'test', '++', 'OJ01102019163225MX3kTwDqzM', '3', '01 ตุลาคม 2562 time 16:32:25', '04 ตุลาคม 2562 time 15:55:25'),
(8, 'online on fire', 'des +++', 'detail +++', 'OJ04102019160442abSsv8YpFA', '3', '04 ตุลาคม 2562 time 16:04:42', '');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `o_id` int(11) NOT NULL,
  `o_code_order` varchar(50) NOT NULL,
  `o_own_id` varchar(10) NOT NULL,
  `o_total_price` decimal(10,0) NOT NULL,
  `o_status_id` varchar(20) NOT NULL,
  `o_comment` text NOT NULL,
  `o_money_transfer_id` varchar(10) NOT NULL,
  `o_shipping_address_id` varchar(10) NOT NULL,
  `o_create_date` varchar(100) NOT NULL,
  `o_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`o_id`, `o_code_order`, `o_own_id`, `o_total_price`, `o_status_id`, `o_comment`, `o_money_transfer_id`, `o_shipping_address_id`, `o_create_date`, `o_update_date`) VALUES
(1, '1-2C3NAJYDB8', '1', '3092', '4', '', '1', '3', '20 กันยายน 2562 time 11:01:22', '27 กันยายน 2562 time 15:44:54'),
(2, '1-JLRO9GT2P2', '1', '3016', '4', '', '3', '1', '20 กันยายน 2562 time 11:31:21', '23 กันยายน 2562 time 16:58:00'),
(3, '1-QLC4LGI47G', '1', '2351', '4', '', '2', '3', '20 กันยายน 2562 time 12:05:25', '23 กันยายน 2562 time 16:20:55'),
(4, '2-AJISR91UZB', '2', '600', '4', '', '4', '4', '20 กันยายน 2562 time 17:22:56', '24 กันยายน 2562 time 12:20:14'),
(5, '1-W5X5F32LYD', '1', '3135', '4', '', '16', '1', '23 กันยายน 2562 time 16:58:47', '26 กันยายน 2562 time 15:03:13'),
(6, '2-MDC8X4ZQLX', '2', '220', '1', '', '', '4', '24 กันยายน 2562 time 12:08:01', ''),
(7, '1-R1FJ384TWE', '1', '8135', '4', '', '15', '5', '25 กันยายน 2562 time 14:21:48', '26 กันยายน 2562 time 14:59:59'),
(8, '1-W4M26GSC1Q', '1', '4471', '4', '', '12', '5', '25 กันยายน 2562 time 14:23:17', '26 กันยายน 2562 time 14:36:09'),
(9, '1-O5C6EUK33Q', '1', '4848', '4', '', '5', '1', '25 กันยายน 2562 time 17:18:19', '25 กันยายน 2562 time 17:19:10'),
(10, '1-T9I2SQ088C', '1', '4947', '3', '', '6', '2', '26 กันยายน 2562 time 14:09:10', '26 กันยายน 2562 time 14:09:54'),
(11, '1-X2CDKYFF3L', '1', '6729', '3', '', '11', '5', '26 กันยายน 2562 time 14:21:45', '26 กันยายน 2562 time 14:35:19'),
(12, '1-E892EWBNOG', '1', '5786', '3', '', '10', '3', '26 กันยายน 2562 time 14:24:27', '26 กันยายน 2562 time 14:33:22'),
(13, '1-1ZZFRPX398', '1', '13271', '3', '', '8', '1', '26 กันยายน 2562 time 14:25:01', '26 กันยายน 2562 time 14:30:28'),
(14, '1-1QUQ022RNM', '1', '11093', '3', '', '7', '1', '26 กันยายน 2562 time 14:26:18', '26 กันยายน 2562 time 14:26:59'),
(15, '1-33HIQR3SNF', '1', '42093', '3', '', '9', '3', '26 กันยายน 2562 time 14:31:20', '26 กันยายน 2562 time 14:32:11'),
(16, '1-G20UI6BE7G', '1', '57093', '2', '', '14', '1', '26 กันยายน 2562 time 14:39:33', '26 กันยายน 2562 time 14:48:38'),
(17, '1-CIBBSD7CU0', '1', '70566', '2', '', '13', '1', '26 กันยายน 2562 time 14:42:32', '26 กันยายน 2562 time 14:43:03'),
(18, '1-OFPY7AOK2C', '1', '83553', '2', '', '17', '1', '26 กันยายน 2562 time 15:04:05', '26 กันยายน 2562 time 15:04:42'),
(19, '1-VFIJU5VIWY', '1', '84225', '2', '', '18', '1', '26 กันยายน 2562 time 15:09:00', '26 กันยายน 2562 time 15:09:42'),
(20, '1-7BDR3TJPWS', '1', '84724', '2', '', '19', '1', '26 กันยายน 2562 time 15:11:15', '26 กันยายน 2562 time 15:12:25'),
(21, '1-ODKNPJ4AQJ', '1', '91211', '2', '', '20', '1', '26 กันยายน 2562 time 15:13:13', '26 กันยายน 2562 time 15:13:39'),
(22, '1-6JNBM6WUG5', '1', '98696', '2', '', '21', '1', '26 กันยายน 2562 time 15:16:41', '26 กันยายน 2562 time 15:17:05'),
(23, '1-E270UDS5PT', '1', '101690', '2', '', '22', '3', '26 กันยายน 2562 time 15:17:59', '26 กันยายน 2562 time 15:18:24'),
(24, '1-NKOIBVABXX', '1', '111670', '2', '', '23', '3', '26 กันยายน 2562 time 15:20:20', '26 กันยายน 2562 time 15:20:44'),
(25, '1-2THLWNX025', '1', '154670', '1', '', '', '6', '26 กันยายน 2562 time 15:26:39', ''),
(26, '1-NQRD7FFQMH', '1', '203670', '1', '', '', '6', '26 กันยายน 2562 time 15:27:42', ''),
(27, '1-HXLFVF7C7Y', '1', '222215', '1', '', '', '6', '26 กันยายน 2562 time 15:29:14', '');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `oi_id` int(11) NOT NULL,
  `oi_order_id` varchar(50) NOT NULL,
  `oi_product_id` varchar(10) NOT NULL,
  `oi_product_price` decimal(10,0) NOT NULL,
  `oi_quantity` int(11) NOT NULL,
  `oi_total_price` decimal(10,0) NOT NULL,
  `oi_create_date` varchar(100) NOT NULL,
  `oi_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`oi_id`, `oi_order_id`, `oi_product_id`, `oi_product_price`, `oi_quantity`, `oi_total_price`, `oi_create_date`, `oi_update_date`) VALUES
(1, '1', '22', '99', 3, '297', '20 กันยายน 2562 time 11:01:22', ''),
(2, '1', '19', '19', 4, '76', '20 กันยายน 2562 time 11:01:22', ''),
(3, '1', '4', '665', 1, '665', '20 กันยายน 2562 time 11:01:22', ''),
(4, '1', '6', '999', 2, '1998', '20 กันยายน 2562 time 11:01:22', ''),
(5, '1', '7', '56', 1, '56', '20 กันยายน 2562 time 11:01:22', ''),
(6, '2', '22', '99', 3, '297', '20 กันยายน 2562 time 11:31:21', ''),
(7, '2', '4', '665', 1, '665', '20 กันยายน 2562 time 11:31:21', ''),
(8, '2', '6', '999', 2, '1998', '20 กันยายน 2562 time 11:31:21', ''),
(9, '2', '7', '56', 1, '56', '20 กันยายน 2562 time 11:31:21', ''),
(10, '3', '22', '99', 3, '297', '20 กันยายน 2562 time 12:05:26', ''),
(11, '3', '6', '999', 2, '1998', '20 กันยายน 2562 time 12:05:26', ''),
(12, '3', '7', '56', 1, '56', '20 กันยายน 2562 time 12:05:26', ''),
(13, '4', '20', '500', 1, '500', '20 กันยายน 2562 time 17:22:56', ''),
(14, '4', '13', '100', 1, '100', '20 กันยายน 2562 time 17:22:56', ''),
(15, '5', '22', '99', 3, '297', '23 กันยายน 2562 time 16:58:47', ''),
(16, '5', '6', '999', 2, '1998', '23 กันยายน 2562 time 16:58:47', ''),
(17, '5', '7', '56', 15, '840', '23 กันยายน 2562 time 16:58:47', ''),
(18, '6', '21', '220', 1, '220', '24 กันยายน 2562 time 12:08:02', ''),
(19, '7', '22', '99', 3, '297', '25 กันยายน 2562 time 14:21:48', ''),
(20, '7', '6', '999', 2, '1998', '25 กันยายน 2562 time 14:21:48', ''),
(21, '7', '7', '56', 15, '840', '25 กันยายน 2562 time 14:21:48', ''),
(22, '7', '8', '1000', 5, '5000', '25 กันยายน 2562 time 14:21:48', ''),
(23, '8', '22', '99', 3, '297', '25 กันยายน 2562 time 14:23:17', ''),
(24, '8', '6', '999', 2, '1998', '25 กันยายน 2562 time 14:23:17', ''),
(25, '8', '7', '56', 21, '1176', '25 กันยายน 2562 time 14:23:17', ''),
(26, '8', '8', '1000', 1, '1000', '25 กันยายน 2562 time 14:23:17', ''),
(27, '9', '22', '99', 3, '297', '25 กันยายน 2562 time 17:18:19', ''),
(28, '9', '6', '999', 2, '1998', '25 กันยายน 2562 time 17:18:19', ''),
(29, '9', '7', '56', 1, '56', '25 กันยายน 2562 time 17:18:19', ''),
(30, '9', '8', '1000', 1, '1000', '25 กันยายน 2562 time 17:18:19', ''),
(31, '9', '20', '499', 3, '1497', '25 กันยายน 2562 time 17:18:19', ''),
(32, '10', '22', '99', 4, '396', '26 กันยายน 2562 time 14:09:10', ''),
(33, '10', '6', '999', 2, '1998', '26 กันยายน 2562 time 14:09:10', ''),
(34, '10', '7', '56', 1, '56', '26 กันยายน 2562 time 14:09:10', ''),
(35, '10', '8', '1000', 1, '1000', '26 กันยายน 2562 time 14:09:10', ''),
(36, '10', '20', '499', 3, '1497', '26 กันยายน 2562 time 14:09:10', ''),
(37, '11', '22', '99', 22, '2178', '26 กันยายน 2562 time 14:21:45', ''),
(38, '11', '6', '999', 2, '1998', '26 กันยายน 2562 time 14:21:45', ''),
(39, '11', '7', '56', 1, '56', '26 กันยายน 2562 time 14:21:45', ''),
(40, '11', '8', '1000', 1, '1000', '26 กันยายน 2562 time 14:21:45', ''),
(41, '11', '20', '499', 3, '1497', '26 กันยายน 2562 time 14:21:45', ''),
(42, '12', '22', '99', 22, '2178', '26 กันยายน 2562 time 14:24:27', ''),
(43, '12', '6', '999', 1, '999', '26 กันยายน 2562 time 14:24:27', ''),
(44, '12', '7', '56', 2, '112', '26 กันยายน 2562 time 14:24:27', ''),
(45, '12', '8', '1000', 1, '1000', '26 กันยายน 2562 time 14:24:27', ''),
(46, '12', '20', '499', 3, '1497', '26 กันยายน 2562 time 14:24:27', ''),
(47, '13', '22', '99', 22, '2178', '26 กันยายน 2562 time 14:25:01', ''),
(48, '13', '6', '999', 1, '999', '26 กันยายน 2562 time 14:25:01', ''),
(49, '13', '7', '56', 2, '112', '26 กันยายน 2562 time 14:25:01', ''),
(50, '13', '8', '1000', 1, '1000', '26 กันยายน 2562 time 14:25:01', ''),
(51, '13', '20', '499', 18, '8982', '26 กันยายน 2562 time 14:25:01', ''),
(52, '14', '6', '999', 1, '999', '26 กันยายน 2562 time 14:26:18', ''),
(53, '14', '7', '56', 2, '112', '26 กันยายน 2562 time 14:26:18', ''),
(54, '14', '8', '1000', 1, '1000', '26 กันยายน 2562 time 14:26:18', ''),
(55, '14', '20', '499', 18, '8982', '26 กันยายน 2562 time 14:26:18', ''),
(56, '15', '6', '999', 1, '999', '26 กันยายน 2562 time 14:31:20', ''),
(57, '15', '7', '56', 2, '112', '26 กันยายน 2562 time 14:31:20', ''),
(58, '15', '8', '1000', 32, '32000', '26 กันยายน 2562 time 14:31:20', ''),
(59, '15', '20', '499', 18, '8982', '26 กันยายน 2562 time 14:31:20', ''),
(60, '16', '6', '999', 1, '999', '26 กันยายน 2562 time 14:39:33', ''),
(61, '16', '7', '56', 2, '112', '26 กันยายน 2562 time 14:39:33', ''),
(62, '16', '8', '1000', 47, '47000', '26 กันยายน 2562 time 14:39:33', ''),
(63, '16', '20', '499', 18, '8982', '26 กันยายน 2562 time 14:39:33', ''),
(64, '17', '6', '999', 1, '999', '26 กันยายน 2562 time 14:42:33', ''),
(65, '17', '7', '56', 2, '112', '26 กันยายน 2562 time 14:42:33', ''),
(66, '17', '8', '1000', 47, '47000', '26 กันยายน 2562 time 14:42:33', ''),
(67, '17', '20', '499', 45, '22455', '26 กันยายน 2562 time 14:42:33', ''),
(68, '18', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:04:05', ''),
(69, '18', '7', '56', 2, '112', '26 กันยายน 2562 time 15:04:05', ''),
(70, '18', '8', '1000', 47, '47000', '26 กันยายน 2562 time 15:04:05', ''),
(71, '18', '20', '499', 45, '22455', '26 กันยายน 2562 time 15:04:05', ''),
(72, '19', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:09:00', ''),
(73, '19', '7', '56', 14, '784', '26 กันยายน 2562 time 15:09:00', ''),
(74, '19', '8', '1000', 47, '47000', '26 กันยายน 2562 time 15:09:00', ''),
(75, '19', '20', '499', 45, '22455', '26 กันยายน 2562 time 15:09:00', ''),
(76, '20', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:11:15', ''),
(77, '20', '7', '56', 14, '784', '26 กันยายน 2562 time 15:11:15', ''),
(78, '20', '8', '1000', 47, '47000', '26 กันยายน 2562 time 15:11:15', ''),
(79, '20', '20', '499', 46, '22954', '26 กันยายน 2562 time 15:11:15', ''),
(80, '21', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:13:13', ''),
(81, '21', '7', '56', 14, '784', '26 กันยายน 2562 time 15:13:13', ''),
(82, '21', '8', '1000', 47, '47000', '26 กันยายน 2562 time 15:13:13', ''),
(83, '21', '20', '499', 59, '29441', '26 กันยายน 2562 time 15:13:13', ''),
(84, '22', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:16:41', ''),
(85, '22', '7', '56', 14, '784', '26 กันยายน 2562 time 15:16:41', ''),
(86, '22', '8', '1000', 47, '47000', '26 กันยายน 2562 time 15:16:41', ''),
(87, '22', '20', '499', 74, '36926', '26 กันยายน 2562 time 15:16:41', ''),
(88, '23', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:17:59', ''),
(89, '23', '7', '56', 14, '784', '26 กันยายน 2562 time 15:17:59', ''),
(90, '23', '8', '1000', 47, '47000', '26 กันยายน 2562 time 15:17:59', ''),
(91, '23', '20', '499', 80, '39920', '26 กันยายน 2562 time 15:17:59', ''),
(92, '24', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:20:20', ''),
(93, '24', '7', '56', 14, '784', '26 กันยายน 2562 time 15:20:20', ''),
(94, '24', '8', '1000', 47, '47000', '26 กันยายน 2562 time 15:20:20', ''),
(95, '24', '20', '499', 100, '49900', '26 กันยายน 2562 time 15:20:20', ''),
(96, '25', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:26:39', ''),
(97, '25', '7', '56', 14, '784', '26 กันยายน 2562 time 15:26:39', ''),
(98, '25', '8', '1000', 90, '90000', '26 กันยายน 2562 time 15:26:39', ''),
(99, '25', '20', '499', 100, '49900', '26 กันยายน 2562 time 15:26:39', ''),
(100, '26', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:27:42', ''),
(101, '26', '7', '56', 14, '784', '26 กันยายน 2562 time 15:27:42', ''),
(102, '26', '8', '1000', 139, '139000', '26 กันยายน 2562 time 15:27:42', ''),
(103, '26', '20', '499', 100, '49900', '26 กันยายน 2562 time 15:27:42', ''),
(104, '27', '6', '999', 14, '13986', '26 กันยายน 2562 time 15:29:14', ''),
(105, '27', '7', '56', 15, '840', '26 กันยายน 2562 time 15:29:14', ''),
(106, '27', '8', '1000', 152, '152000', '26 กันยายน 2562 time 15:29:14', ''),
(107, '27', '20', '499', 111, '55389', '26 กันยายน 2562 time 15:29:14', '');

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `os_id` int(11) NOT NULL,
  `os_title` varchar(100) NOT NULL,
  `os_description` text NOT NULL,
  `os_create_date` varchar(100) NOT NULL,
  `os_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_status`
--

INSERT INTO `order_status` (`os_id`, `os_title`, `os_description`, `os_create_date`, `os_update_date`) VALUES
(1, 'waiting for payment.', 'รอชำระเงิน', '', ''),
(2, 'Waiting to check payment.', 'รอตรวจสอบการชำระเงิน', '', ''),
(3, 'Payment has been completed. Waiting for delivery.', 'ชำระเงินเรียบร้อย รอจัดส่ง', '', ''),
(4, 'delivered successfully.', 'จัดส่งเรียบร้อย', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `pm_id` int(11) NOT NULL,
  `pm_title` text NOT NULL,
  `pm_description` text NOT NULL,
  `pm_create_date` varchar(100) NOT NULL,
  `pm_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`pm_id`, `pm_title`, `pm_description`, `pm_create_date`, `pm_update_date`) VALUES
(1, 'Bank', '', '', ''),
(2, 'Paypal', 'https://www.google.co.th/', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `p_id` int(11) NOT NULL,
  `p_name` text NOT NULL,
  `p_description` text NOT NULL,
  `p_price` text NOT NULL,
  `p_price2` text NOT NULL,
  `p_image` text NOT NULL,
  `p_quantity` text NOT NULL,
  `p_category` varchar(50) NOT NULL,
  `p_image_key` varchar(100) NOT NULL,
  `p_create_date` varchar(50) NOT NULL,
  `p_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`p_id`, `p_name`, `p_description`, `p_price`, `p_price2`, `p_image`, `p_quantity`, `p_category`, `p_image_key`, `p_create_date`, `p_update_date`) VALUES
(1, 'green', 'green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green green ', '500', '5000', '09082019165757PR6HC4zZsj.jpg', '6', '1', '1', '09 สิงหาคม 2562', '2019-08-23 15:20:51'),
(2, 'training to Iron-cat', 'คุณก็เป็นซุปเปอร์แมวมหาปะลัยได้', '40000', '1000', '090820191702553xMQci4hWZ.jpg', '999', '2', '2', '09 สิงหาคม 2562', '2019-08-23 15:20:51'),
(3, 'Book 2', 'green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 green 2 ', '5000', '4999', '09082019174606sUcnOWBaq9.jpg', '10', '1', '3', '09 สิงหาคม 2562', '2019-08-23 15:20:51'),
(4, 'green SS3', 'SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 SS3 ', '666', '665', '09082019175238xhZP5a2yN0.jpg', '4', '1', '4', '09 สิงหาคม 2562', '2019-08-23 15:20:51'),
(5, 'training to Iron-cat 2', 'เป็นอีกละ 2', '100001', '100000', '09082019175406BvwohdpUE1.jpg', '60', '2', '5', '09 สิงหาคม 2562', '2019-08-23 15:20:51'),
(6, 'Book', 'book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book book ', '888', '999', '13082019102929JvKmF3XBJt.png', '101010', '1', '6', '13 สิงหาคม 2562', '2019-08-23 15:20:51'),
(7, 'Book 2', 'Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2Book 2', '57', '56', '13082019103011jP31W0Co8P.jpg', '55', '1', '7', '13 สิงหาคม 2562', '2019-08-23 15:20:51'),
(8, 'Training', 'cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man cat man ', '5000000', '1000', '13082019104825MpWq8fV6YC.jpg', '10', '2', '8', '13 สิงหาคม 2562', '2019-08-23 15:20:51'),
(9, 'Book Again', 'Book AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook AgainBook Again', '1000', '999', '13082019150402pKRyoCRMWm.jpg', '59', '1', '9', '13 สิงหาคม 2562', '2019-08-23 15:20:51'),
(10, 'Course ABC', 'ad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad adad ad ad', '99', '9', '13082019150823Fup1QEgWBX.png', '59', '2', '10', '13 สิงหาคม 2562', '2019-08-23 16:39:58'),
(11, 'Train to tree', 'train human to tree', '999', 'free', '13082019150931dkUJeuHBuW.jpg', '999', '2', '11', '13 สิงหาคม 2562', '2019-08-23 15:20:51'),
(12, 'BOOOOOOOOOK', 'ba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba abba ba ab', '1000', '100', '06092019121443ebVNtwbMHK.png', '10000', '1', '12', '06 กันยายน 2562 time 12:14:43', ''),
(13, 'bk', 'n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n ', '100', '95', '06092019121623hpw2jFt6gz.jpg', '19', '2', '13', '06 กันยายน 2562 time 12:16:23', ''),
(14, 'cat 007 ', 'm m m m m m m m n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n n ', '1500', '1000', '06092019130657JfQz4foU8p.jpg', '679', '1', '14', '06 กันยายน 2562 time 13:06:57', '12 กันยายน 2562 time 12:23:20'),
(15, 'max pr', 'oduct', '1', '0.5', '06092019133501DVp0ypic0h.png', '1', '1', '15', '06 กันยายน 2562 time 13:35:01', ''),
(16, 'max train', 'ning', '100', '50', '0609201913354439zl8WZADY.jpg', '10', '1', '16', '06 กันยายน 2562 time 13:35:44', '06 กันยายน 2562 time 13:42:28'),
(17, 'test multi files', 'test 1', '10', '50', '06092019141237fEtwmHvHpX.jpg', '10', '2', 'P06092019141237hmnKOg51zw', '06 กันยายน 2562 time 14:12:37', ''),
(18, 'test multi files 2', 'test 2', '100', '50', '06092019141635VJ7Kz5IA4h.jpg', '10', '2', 'P06092019141635ovQfYE4ai6', '06 กันยายน 2562 time 14:16:35', '11 กันยายน 2562 time 12:46:10'),
(19, 'test multi files 3', 'test 3', '38', '19', '06092019142038Mw9p7sOvVt.jpg', '10', '2', 'P06092019142038boBAwTrtWQ', '06 กันยายน 2562 time 14:20:38', '11 กันยายน 2562 time 12:28:41'),
(20, 'test multi files 4', 'test 4', '500', '499', '06092019142142yXIKRsJ0XZ.jpg', '10', '2', 'P06092019142142opY1m2Todl', '06 กันยายน 2562 time 14:21:42', '11 กันยายน 2562 time 12:45:51'),
(21, 'lll', 'g', '220', '101', '13092019141613CaGVjJbCHM.png', '99', '1', 'P11092019184056Da75d152BE', '11 กันยายน 2562 time 18:40:56', '16 กันยายน 2562 time 12:02:55'),
(22, 'test new product ++', '++', '100', '99', '160920191204130Ejv5omKga.jpg', '150', '1', 'P16092019120413f6JxAHxTa8', '16 กันยายน 2562 time 12:04:13', '16 กันยายน 2562 time 12:04:41'),
(23, 'P test TT', ' ++ --', '100', '90', '2709201911352055bciV2IaV.png', '1000', '1', 'P16092019122057B9fvfGzeuS', '16 กันยายน 2562 time 12:20:57', '27 กันยายน 2562 time 11:35:20');

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `pc_id` int(11) NOT NULL,
  `pc_title` text NOT NULL,
  `pc_image` text NOT NULL,
  `pc_description` text NOT NULL,
  `pc_create_date` varchar(100) NOT NULL,
  `pc_update_date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`pc_id`, `pc_title`, `pc_image`, `pc_description`, `pc_create_date`, `pc_update_date`) VALUES
(1, 'book', '', 'หนังสือ', '', ''),
(2, 'training_course', '', 'เทรนนิ่ง คอร์ส', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `product_image`
--

CREATE TABLE `product_image` (
  `pi_id` int(11) NOT NULL,
  `pi_name` text NOT NULL,
  `pi_create_date` varchar(100) NOT NULL,
  `pi_update_date` varchar(100) NOT NULL,
  `pi_image_key` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_image`
--

INSERT INTO `product_image` (`pi_id`, `pi_name`, `pi_create_date`, `pi_update_date`, `pi_image_key`) VALUES
(2, '060920191421424kBmmfVuZG.jpg', '06 กันยายน 2562 time 14:21:42', '', 'P06092019142142opY1m2Todl'),
(3, '06092019142142pLot0dcgKx.jpg', '06 กันยายน 2562 time 14:21:42', '', 'P06092019142142opY1m2Todl'),
(4, '06092019142142QoDbagYfZZ.jpg', '06 กันยายน 2562 time 14:21:42', '', 'P06092019142142opY1m2Todl'),
(5, '06092019142142PFioggIi6R.png', '06 กันยายน 2562 time 14:21:42', '', 'P06092019142142opY1m2Todl'),
(7, '060920191421421Xp0aVEwt4.jpg', '06 กันยายน 2562 time 14:21:42', '', 'P06092019142142opY1m2Todl'),
(14, '16092019120255KtcB3QSjMx.png', '16 กันยายน 2562 time 12:02:55', '', 'P11092019184056Da75d152BE'),
(15, '16092019120255lAhYpyxBvA.jpg', '16 กันยายน 2562 time 12:02:55', '', 'P11092019184056Da75d152BE'),
(16, '16092019120413SBkAgCrTo3.jpg', '16 กันยายน 2562 time 12:04:14', '', 'P16092019120413f6JxAHxTa8'),
(17, '160920191204143WrOEtsT9f.jpg', '16 กันยายน 2562 time 12:04:14', '', 'P16092019120413f6JxAHxTa8'),
(18, '16092019120414murjyypQb6.png', '16 กันยายน 2562 time 12:04:14', '', 'P16092019120413f6JxAHxTa8'),
(19, '16092019120441XCTqWZko9z.png', '16 กันยายน 2562 time 12:04:41', '', 'P16092019120413f6JxAHxTa8'),
(20, '27092019113300SXYNLOjAUB.jpg', '27 กันยายน 2562 time 11:33:00', '', 'P16092019122057B9fvfGzeuS'),
(21, '27092019113300dqRA0u75vz.jpg', '27 กันยายน 2562 time 11:33:00', '', 'P16092019122057B9fvfGzeuS'),
(22, '27092019113520KeqEO3pJh5.jpg', '27 กันยายน 2562 time 11:35:20', '', 'P16092019122057B9fvfGzeuS'),
(23, '27092019113520PUWXaIoswj.jpg', '27 กันยายน 2562 time 11:35:20', '', 'P16092019122057B9fvfGzeuS'),
(24, '27092019113520OV1e2Epwfq.jpg', '27 กันยายน 2562 time 11:35:20', '', 'P16092019122057B9fvfGzeuS'),
(25, '27092019113520DYQAQCCIIf.jpg', '27 กันยายน 2562 time 11:35:20', '', 'P16092019122057B9fvfGzeuS');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_address`
--

CREATE TABLE `shipping_address` (
  `sa_id` int(11) NOT NULL,
  `sa_title` varchar(50) NOT NULL,
  `sa_first_name` varchar(50) NOT NULL,
  `sa_last_name` varchar(50) NOT NULL,
  `sa_member_id` varchar(10) NOT NULL,
  `sa_address` text NOT NULL,
  `sa_city` varchar(200) NOT NULL,
  `sa_country` varchar(250) NOT NULL,
  `sa_postcode` varchar(10) NOT NULL,
  `sa_company` text NOT NULL,
  `sa_phone` varchar(20) NOT NULL,
  `sa_email` varchar(100) NOT NULL,
  `sa_create_date` varchar(50) NOT NULL,
  `sa_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shipping_address`
--

INSERT INTO `shipping_address` (`sa_id`, `sa_title`, `sa_first_name`, `sa_last_name`, `sa_member_id`, `sa_address`, `sa_city`, `sa_country`, `sa_postcode`, `sa_company`, `sa_phone`, `sa_email`, `sa_create_date`, `sa_update_date`) VALUES
(1, 'Max Home', '', '', '1', '81/1', '', '', '50130', 'no', '000', 'maxkiller1112@gmail.com', '18 กันยายน 2562 time 11:35:04', ''),
(2, 'Home 2', '', '', '1', '81/1', '', '', '50130', '123', '091', 'maxkiller1112@gmail.com', '18 กันยายน 2562 time 14:58:42', ''),
(3, 'Home 009', '', '', '1', 'ดาวอังคาร', '', '', '900', 'ASW', '-1-1-1-', 'M@mail', '18 กันยายน 2562 time 16:30:53', ''),
(4, 'My X', '', '', '2', 'pluto', '', '', '098', 'NO', '890', 'X@Xmail', '19 กันยายน 2562 time 10:59:42', ''),
(5, 'new home', '', '', '1', 'ดาว เสาร์', '', '', '0187', 'out the world', '9078563412', 'Newsadt@mail.com', '25 กันยายน 2562 time 14:21:48', ''),
(6, 'ก็มาดิครับ', '', '', '1', 'จังหวัด เชัยงใหม่\nอำเภอ เชียงราย\nตำบล ลำพูน\nหมู่บ้าน ลำปาง', '', '', '56473', 'no no no', '6574839201', 'maxkiller1112@gmail.com', '26 กันยายน 2562 time 15:26:39', '');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `v_id` int(11) NOT NULL,
  `v_title` text NOT NULL,
  `v_description` text NOT NULL,
  `v_link` text NOT NULL,
  `v_room` text NOT NULL,
  `v_create_date` varchar(50) NOT NULL,
  `v_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`v_id`, `v_title`, `v_description`, `v_link`, `v_room`, `v_create_date`, `v_update_date`) VALUES
(1, 'videos 1', 'no description', 'https://www.youtube.com/embed/pNNMr5glICM', '1', '', ''),
(2, 'videos 2', 'no description 2', 'https://www.youtube.com/embed/Y1QZOprK7PQ', '1', '', ''),
(4, 'videos new 1', 'no description new 1', 'https://www.youtube.com/embed/JZELmUooBlY', '2', '', ''),
(5, 'videos new 2', 'no description new 2', 'coming soon new', '2', '', ''),
(43, 'Louis Tomlinson - Back to You (Official Video) ft. Bebe Rexha, Digital Farm Animals', 'Back to you', 'https://www.youtube.com/embed/-HjpL-Ns6_A', '3', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `video_room`
--

CREATE TABLE `video_room` (
  `vr_id` int(11) NOT NULL,
  `vr_title` text NOT NULL,
  `vr_description` text NOT NULL,
  `vr_owner` text NOT NULL,
  `vr_create_date` varchar(50) NOT NULL,
  `vr_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `video_room`
--

INSERT INTO `video_room` (`vr_id`, `vr_title`, `vr_description`, `vr_owner`, `vr_create_date`, `vr_update_date`) VALUES
(1, 'New Videos One', 'description video 1', '1', '16 สิงหาคม 2562', '09 กันยายน 2562 time 10:30:46'),
(2, 'New Videos2 edit', 'description 2', '1', '16 สิงหาคม 2562', '11 กันยายน 2562 time 11:43:46'),
(3, 'the video training 1', 'training one', '1', '19 สิงหาคม 2562', '2019-08-23 16:09:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_article`
--
ALTER TABLE `academic_article`
  ADD PRIMARY KEY (`aa_id`);

--
-- Indexes for table `academic_article_category`
--
ALTER TABLE `academic_article_category`
  ADD PRIMARY KEY (`aac_id`);

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`a_id`);

--
-- Indexes for table `article_category`
--
ALTER TABLE `article_category`
  ADD PRIMARY KEY (`ac_id`);

--
-- Indexes for table `banking`
--
ALTER TABLE `banking`
  ADD PRIMARY KEY (`b_id`);

--
-- Indexes for table `files_upload`
--
ALTER TABLE `files_upload`
  ADD PRIMARY KEY (`f_id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`g_id`);

--
-- Indexes for table `gallery_image`
--
ALTER TABLE `gallery_image`
  ADD PRIMARY KEY (`gi_id`);

--
-- Indexes for table `logged`
--
ALTER TABLE `logged`
  ADD PRIMARY KEY (`l_id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`m_id`);

--
-- Indexes for table `member_type`
--
ALTER TABLE `member_type`
  ADD PRIMARY KEY (`mt_id`);

--
-- Indexes for table `member_upgrade_date`
--
ALTER TABLE `member_upgrade_date`
  ADD PRIMARY KEY (`mud_id`);

--
-- Indexes for table `money_transfer`
--
ALTER TABLE `money_transfer`
  ADD PRIMARY KEY (`mtf_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`n_id`);

--
-- Indexes for table `online_journal`
--
ALTER TABLE `online_journal`
  ADD PRIMARY KEY (`oj_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`o_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`oi_id`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`os_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`pm_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`pc_id`);

--
-- Indexes for table `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`pi_id`);

--
-- Indexes for table `shipping_address`
--
ALTER TABLE `shipping_address`
  ADD PRIMARY KEY (`sa_id`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`v_id`);

--
-- Indexes for table `video_room`
--
ALTER TABLE `video_room`
  ADD PRIMARY KEY (`vr_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_article`
--
ALTER TABLE `academic_article`
  MODIFY `aa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `academic_article_category`
--
ALTER TABLE `academic_article_category`
  MODIFY `aac_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `article_category`
--
ALTER TABLE `article_category`
  MODIFY `ac_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `banking`
--
ALTER TABLE `banking`
  MODIFY `b_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `files_upload`
--
ALTER TABLE `files_upload`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `g_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `gallery_image`
--
ALTER TABLE `gallery_image`
  MODIFY `gi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `logged`
--
ALTER TABLE `logged`
  MODIFY `l_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `m_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `member_type`
--
ALTER TABLE `member_type`
  MODIFY `mt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_upgrade_date`
--
ALTER TABLE `member_upgrade_date`
  MODIFY `mud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `money_transfer`
--
ALTER TABLE `money_transfer`
  MODIFY `mtf_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `n_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `online_journal`
--
ALTER TABLE `online_journal`
  MODIFY `oj_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `o_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `oi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `os_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `pm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `pc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `pi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `shipping_address`
--
ALTER TABLE `shipping_address`
  MODIFY `sa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `v_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `video_room`
--
ALTER TABLE `video_room`
  MODIFY `vr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
