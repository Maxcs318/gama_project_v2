-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2019 at 06:59 AM
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
(1, 'test', 'test test test +++ ---', '1', '28 ตุลาคม 2562 time 11:17:04', '28102019111704FblxW74T2u.png', '', 'A28102019111704E9DePBMhHq');

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
-- Table structure for table `award_list`
--

CREATE TABLE `award_list` (
  `al_id` int(11) NOT NULL,
  `al_recipient` varchar(250) NOT NULL,
  `al_company_id` varchar(10) NOT NULL,
  `al_year_id` varchar(10) NOT NULL,
  `al_award_type_id` varchar(10) NOT NULL,
  `al_create_date` varchar(50) NOT NULL,
  `al_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `award_list`
--

INSERT INTO `award_list` (`al_id`, `al_recipient`, `al_company_id`, `al_year_id`, `al_award_type_id`, `al_create_date`, `al_update_date`) VALUES
(1, 'A B C D E F G', '3', '1', '3', '', ''),
(2, 'DuangDee  Moolkham', '2', '1', '1', '', ''),
(3, 'Mushashi Rocket', '3', '1', '3', '', ''),
(4, 'Koshiro Rocket', '2', '1', '2', '', ''),
(5, 'Neach Rocket', '1', '1', '3', '', ''),
(6, 'nobi nobita', '1', '1', '3', '', ''),
(7, 'max is me', '1', '2', '1', '24 ตุลาคม 2562 time 15:51:49', ''),
(8, 'Donquixote rosinante corazon', '1', '2', '1', '25 ตุลาคม 2562 time 12:22:29', '');

-- --------------------------------------------------------

--
-- Table structure for table `award_type`
--

CREATE TABLE `award_type` (
  `at_id` int(11) NOT NULL,
  `at_title` varchar(250) NOT NULL,
  `at_detail` text NOT NULL,
  `at_create_date` varchar(50) NOT NULL,
  `at_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `award_type`
--

INSERT INTO `award_type` (`at_id`, `at_title`, `at_detail`, `at_create_date`, `at_update_date`) VALUES
(1, 'Award Type A', 'type a\nA 80\nA+ 100', '', '24 ตุลาคม 2562 time 15:00:36'),
(2, 'Award Type B', '', '', ''),
(3, 'Award Type C', '', '', ''),
(4, 'Award type test', '', '24 ตุลาคม 2562 time 14:38:26', ''),
(7, 'test ++ edit', '', '24 ตุลาคม 2562 time 14:59:59', '24 ตุลาคม 2562 time 15:00:07');

-- --------------------------------------------------------

--
-- Table structure for table `award_year`
--

CREATE TABLE `award_year` (
  `ay_id` int(11) NOT NULL,
  `ay_title` varchar(10) NOT NULL,
  `ay_detail` text NOT NULL,
  `ay_create_date` varchar(50) NOT NULL,
  `ay_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `award_year`
--

INSERT INTO `award_year` (`ay_id`, `ay_title`, `ay_detail`, `ay_create_date`, `ay_update_date`) VALUES
(1, '2018', '', '', ''),
(2, '2019', '', '', ''),
(3, '2020', 'test', '25 ตุลาคม 2562 time 11:59:27', ''),
(4, '2021', 'test edit ++\ntest ++ edit\n++ test edit', '25 ตุลาคม 2562 time 11:59:38', '25 ตุลาคม 2562 time 12:09:23');

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
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `c_id` int(11) NOT NULL,
  `c_title` varchar(250) NOT NULL,
  `c_detail` text NOT NULL,
  `c_create_date` varchar(50) NOT NULL,
  `c_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`c_id`, `c_title`, `c_detail`, `c_create_date`, `c_update_date`) VALUES
(1, 'Company A', '', '', '24 ตุลาคม 2562 time 13:02:45'),
(2, 'Company B', '', '', ''),
(3, 'Company C', '', '', ''),
(4, 'test company ', 'mmm test edit', '', '24 ตุลาคม 2562 time 13:00:10');

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
(1, '25102019133013Zm6gkEwcU0.jpg', 'A', 'R25102019132717TmHExikic4', '25 ตุลาคม 2562 time 13:30:13', ''),
(2, '251020191330134iUMNV8R3e.sql', 'B', 'R25102019132717TmHExikic4', '25 ตุลาคม 2562 time 13:30:13', '');

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
(107, '2019-10-28 04:09:02', '1', '281020191109021VFufzRxwQE'),
(108, '2019-10-28 05:31:12', '1', '281020191231121n9X4xFgdIB');

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
(1, '100', 'ดวงดี Admin +123', 'มูลคำ', 'Dusngdee ENG', 'Moolkham ENG', 'max', 'admin', 'f561aaf6ef0bf14d4208bb46a4ccb3ad', '03102019120654RipxfeHYIt.png', '2', '27', '123', '0980980980', 'MAXMAIL@Mail.com', 'ดาวอังคาร', 'The Moon', '', '24 ตุลาคม 2562 time 11:03:17 ( Edit By Admin )'),
(2, '', 'JPEG IS Real ?', 'm', '', '', 'xxx', 'user', 'f561aaf6ef0bf14d4208bb46a4ccb3ad', '12092019171138y16v7uQcds.png', '2', '17', '', '', '', '', '', '', '17 ตุลาคม 2562 time 11:45:07 ( Edit By Admin )'),
(3, '', 'zzz First ++', 'zzz Last', 'FZeng', 'LZeng', 'zzz', 'admin', 'f3abb86bd34cf4d52698f14c0da1dc60', '02092019120759BSL755Z3iP.jpg', '3', '18', 'no', '0987654321', 'Z@g', 'no have', 'no have too', '', '02 ตุลาคม 2562 time 16:10:30 ( Edit By Admin )'),
(4, '10101011', 'ดวงดี ---', 'มูลคำ', 'Duangdee', 'Moolkham', 'corazon', 'user', 'f561aaf6ef0bf14d4208bb46a4ccb3ad', 'jpg.png', '3', '26', 'company', '1234567890', 'max@mail', 'institute', 'address', 'C Date', '03 ตุลาคม 2562 time 14:23:49 ( Edit By Admin )'),
(5, '', 'เอ', 'เอเอ', 'A', 'AA', 'aaa', 'user', '47bce5c74f589f4867dbd57e9ca9f808', '02092019125206JP3ilnGpRZ.png', '1', '', '', '0192837465', 'a@amail.com', 'No', 'ad ee', '02 กันยายน 2562 time 12:09:53', '02 ตุลาคม 2562 time 15:45:18 ( Edit By Admin )'),
(6, '', 'real', 'laer', '', '', 'qqq', 'user', 'b2ca678b4c936f905fb82f2733f5297f', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:06:27', ''),
(7, '', 'eeee', 'eee', '', '', 'eee', 'user', 'd2f2297d6e829cd3493aa7de4416a18f', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:09:37', ''),
(8, '', 'rrrF', 'rrrL', '', '', 'rrr', 'user', '44f437ced647ec3f40fa0841041871cd', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:12:10', ''),
(9, '', 'ooo', 'ooo', '', '', 'ooo', 'user', '7f94dd413148ff9ac9e9e4b6ff2b6ca9', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:14:24', ''),
(10, '', 'sss', 'sss', '', '', 'sss', 'user', '9f6e6800cfae7749eb6c486619254b9c', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:18:01', '17 ตุลาคม 2562 time 11:45:37 ( Edit By Admin )'),
(11, '', 'www', 'www', '', '', 'www', 'user', '4eae35f1b35977a00ebd8086c259d4c9', '', '2', '', '', '', '', '', '', '02 กันยายน 2562 time 14:23:34', '02 ตุลาคม 2562 time 13:09:20 ( Edit By Admin )'),
(12, '', 'iii', 'iii', '', '', 'iii', 'user', '36347412c7d30ae6fde3742bbc4f21b9', '', '1', '', '', '', '', '', '', '02 กันยายน 2562 time 14:24:11', ''),
(13, '', '', '', '', '', 'x', 'user', '000', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:18:23', ''),
(14, '', 'mmmm', 'mmm', '', '', 'xo', 'user', 'f13dfee35a80a761918d326acd591d12', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:20:56', ''),
(15, '', 'ma', 'xa', '', '', 'z', 'user', 'fbade9e36a3f36d3d676c1b808451dd7', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:42:08', ''),
(16, '', 'lll', 'lll', '', '', 'loop', 'user', 'e48b981fb62db33b98a27fc6cf8bf40a', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:43:26', ''),
(17, '', '', '', '', '', 'xw', 'user', '000', '', '1', '', '', '', '', '', '', '10 กันยายน 2562 time 16:48:03', ''),
(18, '', 'pl', 'll', '', 'a', 'root', 'user', 'c6f057b86584942e415435ffb1fa93d4', '', '1', '', '', '', '', '', '', '11 กันยายน 2562 time 18:21:25', '03 ตุลาคม 2562 time 16:23:01 ( Edit By Admin )'),
(19, '', 'ทดสอบ', '๙๙', 'test', '99', 'mmm', 'user', '000', '03102019120802Fq7Qqap4ei.png', '3', '23', '', '', '', '', '', '11 กันยายน 2562 time 18:21:44', '03 ตุลาคม 2562 time 16:12:22 ( Edit By Admin )'),
(20, '', '', '', '', '', '999', 'user', '000', '', '', '', '', '', '', '', '', '16 ตุลาคม 2562 time 15:36:34', '');

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
(26, '03-10-2019 14:22:37', '03-11-2019 14:22:37', '03 ตุลาคม 2562 time 14:22:37', '', '4', '3'),
(27, '24-10-2019 11:03:17', '24-10-2020 11:03:17', '24 ตุลาคม 2562 time 11:03:17', '', '1', '2');

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
(1, 'etstsdf', 'zsg', '21 ตุลาคม 2562 time 14:49:03', '21102019144903jX13EoURbm.png', '', 'N21102019144903vF6wCyTcsZ');

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
(1, '2-OVHU4EVG35', '2', '990', '1', '', '', '1', '22 ตุลาคม 2562 time 17:38:23', ''),
(2, '1-TCDKDHW4UU', '1', '2970', '1', '', '', '2', '24 ตุลาคม 2562 time 10:27:22', ''),
(3, '1-OUX5IAYWFN', '1', '990', '1', '', '', '2', '24 ตุลาคม 2562 time 11:45:53', '');

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
(1, '1', '1', '990', 1, '990', '22 ตุลาคม 2562 time 17:38:23', ''),
(2, '2', '1', '990', 3, '2970', '24 ตุลาคม 2562 time 10:27:22', ''),
(3, '3', '1', '990', 1, '990', '24 ตุลาคม 2562 time 11:45:53', '');

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
(1, 'test product', '++', '999', '990', '22102019173246HiuBmO9drZ.png', '9999', '1', 'P221020191732461GJOiubHCB', '22 ตุลาคม 2562 time 17:32:47', '');

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

-- --------------------------------------------------------

--
-- Table structure for table `research`
--

CREATE TABLE `research` (
  `r_id` int(11) NOT NULL,
  `r_title` varchar(250) NOT NULL,
  `r_titlealternative` varchar(250) NOT NULL,
  `r_creator` text NOT NULL,
  `r_subject` varchar(250) NOT NULL,
  `r_description` text NOT NULL,
  `r_publisher` text NOT NULL,
  `r_createddate` varchar(50) NOT NULL,
  `r_modifieddate` varchar(50) NOT NULL,
  `r_issueddate` varchar(50) NOT NULL,
  `r_type` varchar(250) NOT NULL,
  `r_format` varchar(250) NOT NULL,
  `r_source` varchar(250) NOT NULL,
  `r_language` varchar(250) NOT NULL,
  `r_rights` varchar(250) NOT NULL,
  `r_permission` varchar(50) NOT NULL,
  `r_file_key` varchar(50) NOT NULL,
  `r_create_date` varchar(50) NOT NULL,
  `r_update_date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `research`
--

INSERT INTO `research` (`r_id`, `r_title`, `r_titlealternative`, `r_creator`, `r_subject`, `r_description`, `r_publisher`, `r_createddate`, `r_modifieddate`, `r_issueddate`, `r_type`, `r_format`, `r_source`, `r_language`, `r_rights`, `r_permission`, `r_file_key`, `r_create_date`, `r_update_date`) VALUES
(1, 'agasgasgsdgsasadf', 'sdfasdfsadfsdafasf', '', 'safasdfasdfsafsda', 'fadsfasdfasfa', 'asdgas\ngadsf', 'ASDGAS', 'GGASGADS', '', 'GSDGASGASG', 'ASGSAGASDG', 'ASGASGSA', 'GASGSAGAS', 'sadgasgas', '1', 'R25102019131606864CRaep1R', '25 ตุลาคม 2562 time 13:16:06', ''),
(2, 'asgasdg', 'asdgsfadgsfd', 'aaa', 'gsfdgsfdgsfd', 'asdgas\ngsagg', 'asdgasdgf\nasfgasf\n', 'sagsf', 'gasgasg', 'sadgsdf', 'sagasgas', 'gasgas', 'gasgasdg', 'asgasgas', 'asdfs', '3', 'R25102019132717TmHExikic4', '25 ตุลาคม 2562 time 13:27:17', '28 ตุลาคม 2562 time 12:31:57'),
(3, 'a', 's', 'd', 'f', 'h\n', 'hg', 'g', 'sd', 'sgsag', 'asg', 'sadfgsf', 'sdfg', 'dfgdfsgsd', 'sdgsd\n\n', '3', 'R28102019123441BozJufRheg', '28 ตุลาคม 2562 time 12:34:41', '');

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
(1, 'aaa', '', '', '2', 'ddd', '', '', 'sds', 'sdg', 'asdgs', 'af@sdg', '22 ตุลาคม 2562 time 17:38:23', ''),
(2, '12', '', '', '1', '34', '', '', '56', '1123', '78', 'maxkiller1112@gmail.com', '24 ตุลาคม 2562 time 10:27:22', '');

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
-- Indexes for table `award_list`
--
ALTER TABLE `award_list`
  ADD PRIMARY KEY (`al_id`);

--
-- Indexes for table `award_type`
--
ALTER TABLE `award_type`
  ADD PRIMARY KEY (`at_id`);

--
-- Indexes for table `award_year`
--
ALTER TABLE `award_year`
  ADD PRIMARY KEY (`ay_id`);

--
-- Indexes for table `banking`
--
ALTER TABLE `banking`
  ADD PRIMARY KEY (`b_id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`c_id`);

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
-- Indexes for table `research`
--
ALTER TABLE `research`
  ADD PRIMARY KEY (`r_id`);

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
  MODIFY `aa_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `academic_article_category`
--
ALTER TABLE `academic_article_category`
  MODIFY `aac_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `article_category`
--
ALTER TABLE `article_category`
  MODIFY `ac_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `award_list`
--
ALTER TABLE `award_list`
  MODIFY `al_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `award_type`
--
ALTER TABLE `award_type`
  MODIFY `at_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `award_year`
--
ALTER TABLE `award_year`
  MODIFY `ay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `banking`
--
ALTER TABLE `banking`
  MODIFY `b_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `files_upload`
--
ALTER TABLE `files_upload`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `g_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gallery_image`
--
ALTER TABLE `gallery_image`
  MODIFY `gi_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logged`
--
ALTER TABLE `logged`
  MODIFY `l_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `m_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `member_type`
--
ALTER TABLE `member_type`
  MODIFY `mt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_upgrade_date`
--
ALTER TABLE `member_upgrade_date`
  MODIFY `mud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `money_transfer`
--
ALTER TABLE `money_transfer`
  MODIFY `mtf_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `n_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `online_journal`
--
ALTER TABLE `online_journal`
  MODIFY `oj_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `o_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `oi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `pc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `pi_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `research`
--
ALTER TABLE `research`
  MODIFY `r_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shipping_address`
--
ALTER TABLE `shipping_address`
  MODIFY `sa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `v_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_room`
--
ALTER TABLE `video_room`
  MODIFY `vr_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
