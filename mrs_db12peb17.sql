-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 12, 2017 at 03:42 PM
-- Server version: 5.7.17-0ubuntu0.16.04.1
-- PHP Version: 7.0.13-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mrs_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(1) NOT NULL,
  `name` varchar(30) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `status`) VALUES
(5, 'AXIS', 1),
(3, 'INDOSAT', 1),
(7, 'NOKIA', 1),
(9, 'PLN', 1),
(8, 'SAMSUNG', 1),
(6, 'SMARTFREN', 1),
(2, 'TELKOMSEL', 1),
(4, 'THREE', 1),
(1, 'XL', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `hp` varchar(20) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(11) UNSIGNED NOT NULL,
  `expense_date` date NOT NULL,
  `amount` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `create_by` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`expense_id`, `expense_date`, `amount`, `description`, `create_by`) VALUES
(2, '2017-01-15', 2000, 'ngamen', 2),
(3, '2017-01-15', 1000, 'beli minum', 2);

-- --------------------------------------------------------

--
-- Table structure for table `income_others`
--

CREATE TABLE `income_others` (
  `income_other_id` int(11) UNSIGNED NOT NULL,
  `description` varchar(255) NOT NULL,
  `amount` int(11) UNSIGNED DEFAULT '0',
  `create_at` date DEFAULT NULL,
  `create_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(1) NOT NULL,
  `menu` varchar(50) DEFAULT NULL,
  `parent_id` int(1) DEFAULT NULL,
  `slug` varchar(80) DEFAULT NULL,
  `icon_class` varchar(35) DEFAULT NULL,
  `action` smallint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `menu`, `parent_id`, `slug`, `icon_class`, `action`) VALUES
(1, 'Dashboard', 1, '', 'icon-home', 0),
(11, 'Suplier', 2, 'master/suplier', 'fa fa-building', 1),
(12, 'Pelanggan', 2, 'master/pelanggan', 'fa fa-sitemap', 1),
(13, 'User Management', 2, 'master/user_management', 'fa fa-user', 1),
(14, 'Sales', 2, 'master/sales', 'fa fa-circle', 1),
(15, 'Produk', 2, 'master/produk', 'fa fa-circle', 1),
(41, 'Pembelian', 3, 'transaction/pembelian', 'fa fa-mail-reply-all', 1),
(42, 'Retur Pembelian', 3, 'transaction/retur_pembelian', 'fa fa-circle', 1),
(43, 'Penjualan', 3, 'transaction/penjualan', 'fa fa-circle', 1),
(44, 'Retur Penjualan', 3, 'transaction/retur_penjualan', 'fa fa-circle', 1),
(45, 'Retur Pengeluaran', 3, 'transaction/pengeluaran', 'fa fa-circle', 1),
(61, 'Cash', 4, 'finance/cash', 'fa fa-money', 1),
(62, 'Bank', 4, 'finance/bank', 'fa fa-bank', 1),
(63, 'Receivable', 4, 'finance/receivable', 'fa fa-bank', 1),
(81, 'Setting', 5, 'tools/setting', 'fa fa-gear', 1),
(82, 'Backup DB', 5, 'tools/database', 'fa fa-database', 1),
(101, 'General Ledger', 6, 'report/general_ledger', 'fa fa-sticky-note', 0),
(102, 'Outstanding delivery', 6, 'report/outstanding_delivery', 'fa fa-sticky-note', 0);

-- --------------------------------------------------------

--
-- Table structure for table `menus_parent`
--

CREATE TABLE `menus_parent` (
  `id` int(1) NOT NULL,
  `name_parent` varchar(45) DEFAULT NULL,
  `slug_parent` varchar(45) DEFAULT NULL,
  `icon_class_parent` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menus_parent`
--

INSERT INTO `menus_parent` (`id`, `name_parent`, `slug_parent`, `icon_class_parent`) VALUES
(1, 'Dashboard', 'dashboard', 'icon-home'),
(2, 'Master Data', 'master', 'fa fa-cubes'),
(3, 'Transaction', 'transaction', 'fa fa-cubes'),
(5, 'Tools & Setting', 'tools', 'fa fa-gears'),
(6, 'Report', 'report', 'fa fa-book');

-- --------------------------------------------------------

--
-- Table structure for table `mutasi`
--

CREATE TABLE `mutasi` (
  `id` int(1) NOT NULL,
  `tr_type` enum('D','K') NOT NULL DEFAULT 'D',
  `description` varchar(200) NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `trxid` int(1) NOT NULL,
  `create_at` datetime NOT NULL,
  `create_by` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(1) NOT NULL,
  `order_code` varchar(30) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `netto` double DEFAULT '0',
  `disc` double DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '1',
  `remark` varchar(100) DEFAULT NULL,
  `create_by` int(1) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_code`, `order_date`, `netto`, `disc`, `status`, `remark`, `create_by`, `create_at`, `update_at`) VALUES
(1, 'SL/MRS/II/2017/000001', '2017-02-07', 6000, 0, 0, '', 2, '2017-02-07 14:24:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `id` int(1) NOT NULL,
  `order_id` int(1) NOT NULL,
  `supplier_id` int(1) NOT NULL DEFAULT '0',
  `product_id` int(1) NOT NULL,
  `qty` int(1) NOT NULL,
  `unit` varchar(30) NOT NULL,
  `pprice` double NOT NULL DEFAULT '0',
  `price` double NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `app_id` varchar(30) DEFAULT NULL,
  `respon` text,
  `description` varchar(50) DEFAULT NULL COMMENT 'Deskripsi Produk atau Nomor yang diisi'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`id`, `order_id`, `supplier_id`, `product_id`, `qty`, `unit`, `pprice`, `price`, `amount`, `app_id`, `respon`, `description`) VALUES
(2, 1, 1, 1, 1, '1', 5600, 6000, 6000, NULL, NULL, 'Lala');

-- --------------------------------------------------------

--
-- Table structure for table `order_state`
--

CREATE TABLE `order_state` (
  `id` int(1) NOT NULL,
  `name` varchar(30) NOT NULL DEFAULT 'NEW'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_state`
--

INSERT INTO `order_state` (`id`, `name`) VALUES
(1, 'NEW'),
(2, 'PAID'),
(3, 'ORDERED'),
(4, 'SUCCESS'),
(5, 'FAIL');

-- --------------------------------------------------------

--
-- Table structure for table `parsing`
--

CREATE TABLE `parsing` (
  `id` int(1) NOT NULL,
  `supplier_id` int(1) NOT NULL,
  `product_id` int(1) NOT NULL,
  `pprice` double NOT NULL DEFAULT '0',
  `order_code` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `parsing`
--

INSERT INTO `parsing` (`id`, `supplier_id`, `product_id`, `pprice`, `order_code`) VALUES
(7, 1, 1, 5600, 'S5'),
(5, 1, 3, 2000, 'order'),
(6, 1, 5, 21000, 'PLN'),
(10, 2, 5, 25000, 'PLN');

-- --------------------------------------------------------

--
-- Table structure for table `prefix`
--

CREATE TABLE `prefix` (
  `id` int(10) NOT NULL,
  `prefix` varchar(30) NOT NULL DEFAULT '0',
  `brand_id` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prefix`
--

INSERT INTO `prefix` (`id`, `prefix`, `brand_id`) VALUES
(107, '0818', 1),
(108, '0819', 1),
(109, '0859', 1),
(110, '0878', 1),
(111, '0877', 1),
(116, '0813', 2),
(117, '0838', 5),
(118, '0837', 5),
(119, '0839', 5),
(122, '0856', 3),
(123, '0815', 3),
(124, '0816', 3),
(125, '0858', 3),
(126, '0882', 6),
(127, '0883', 6),
(128, '0881', 6),
(129, '0899', 4),
(130, '0898', 4),
(131, '0897', 4),
(132, '0896', 4),
(133, '0811', 2),
(137, '0857', 3),
(139, '0821', 2),
(140, '0831', 5),
(151, '0855', 3),
(153, '0852', 2),
(157, '0889', 6),
(158, '0887', 6),
(160, '0853', 2),
(161, '0817', 1),
(176, '0822', 2),
(177, '0823', 2),
(186, '0888', 6),
(192, '0812', 2),
(202, '0824', 2),
(212, '0851', 2),
(223, '0895', 4),
(245, '0835', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(1) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `provider_id` int(1) NOT NULL DEFAULT '0',
  `unit_id` int(1) NOT NULL DEFAULT '0',
  `price` int(1) NOT NULL DEFAULT '0',
  `barcode` varchar(40) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0=close, 1=open',
  `create_by` varchar(60) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `code`, `name`, `provider_id`, `unit_id`, `price`, `barcode`, `status`, `create_by`, `create_date`, `update_date`) VALUES
(3, 'ID1G', 'ISAT Data 1GB+2GB 4G', 8, 1, 31000, NULL, 1, 'admin', '2016-12-01 23:33:04', NULL),
(4, 'IF2G', 'ISAT Freedom 2GB+10GB 4G', 8, 1, 31000, NULL, 1, 'admin', '2016-12-01 23:34:02', NULL),
(5, 'PLN20', 'PLN 20,000', 12, 1, 22000, NULL, 1, 'admin', '2016-12-01 23:37:05', NULL),
(6, 'PLN50', 'PLN 50,000', 12, 1, 53000, NULL, 1, 'admin', '2016-12-01 23:37:30', NULL),
(2, 'S10', 'Telkomsel 10,000', 1, 1, 12000, NULL, 1, 'admin', '2016-12-01 23:30:04', NULL),
(1, 'S5', 'Telkomsel 5,000', 1, 1, 6000, '', 1, 'admin', '2016-12-01 23:25:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_type`
--

CREATE TABLE `product_type` (
  `id` int(1) NOT NULL,
  `type_name` varchar(30) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0=not active, 1=active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_type`
--

INSERT INTO `product_type` (`id`, `type_name`, `status`) VALUES
(2, 'Pulsa Data Internet', 1),
(1, 'Pulsa Reguler', 1),
(4, 'Token PLN', 1),
(3, 'Voucher Game', 1);

-- --------------------------------------------------------

--
-- Table structure for table `provider`
--

CREATE TABLE `provider` (
  `id` int(1) NOT NULL,
  `provider_name` varchar(30) NOT NULL,
  `brand_id` int(1) NOT NULL DEFAULT '0',
  `ptype_id` int(1) NOT NULL DEFAULT '0' COMMENT 'Product Type Id',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0=not active, 1=active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `provider`
--

INSERT INTO `provider` (`id`, `provider_name`, `brand_id`, `ptype_id`, `status`) VALUES
(6, 'Axis', 5, 1, 1),
(11, 'Axis Internet', 5, 2, 1),
(2, 'Indosat', 3, 1, 1),
(8, 'Indosat Data', 3, 2, 1),
(12, 'PLN Prabayar', 9, 4, 1),
(4, 'Smartfren', 6, 1, 1),
(1, 'Telkomsel', 2, 1, 1),
(7, 'Telkomsel Data', 2, 2, 1),
(5, 'Three (3)', 4, 1, 1),
(10, 'Three Internet', 4, 2, 1),
(3, 'XL', 1, 1, 1),
(9, 'XL Data', 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `purchase_order_id` int(11) UNSIGNED NOT NULL,
  `no_po` varchar(32) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `payment_duedate` date DEFAULT NULL,
  `payment_status` tinyint(4) UNSIGNED DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `create_at` datetime NOT NULL,
  `create_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` (`purchase_order_id`, `no_po`, `supplier_id`, `payment_duedate`, `payment_status`, `description`, `status`, `create_at`, `create_by`) VALUES
(1, 'PO/MRS/I/2017/000001', 2, '2017-01-15', 1, NULL, 2, '2017-01-15 12:26:59', 2),
(2, 'PO/MRS/I/2017/000002', 1, '2017-01-28', 0, '', 2, '2017-01-15 16:18:12', 2);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_details`
--

CREATE TABLE `purchase_order_details` (
  `purchase_order_detail_id` int(11) UNSIGNED NOT NULL,
  `purchase_order_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  `qty` int(11) NOT NULL DEFAULT '0',
  `item_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `qty_approved` int(11) DEFAULT '0',
  `qty_returned` int(11) UNSIGNED DEFAULT '0',
  `qty_rejected` int(11) DEFAULT '0',
  `total_price_approved` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `purchase_order_details`
--

INSERT INTO `purchase_order_details` (`purchase_order_detail_id`, `purchase_order_id`, `product_id`, `description`, `qty`, `item_price`, `total_price`, `qty_approved`, `qty_returned`, `qty_rejected`, `total_price_approved`) VALUES
(1, 1, 2, '', 10, '10500.00', '105000.00', 10, 0, 0, 105000),
(2, 1, 1, '', 20, '5400.00', '108000.00', 20, 0, 0, 108000),
(3, 2, 3, 'Desc', 20, '20000.00', '400000.00', 20, 0, 0, 400000),
(4, 2, 1, 'I5 Sup Tes', 30, '5300.00', '159000.00', 30, 0, 0, 159000);

-- --------------------------------------------------------

--
-- Table structure for table `returs`
--

CREATE TABLE `returs` (
  `retur_id` int(11) UNSIGNED NOT NULL,
  `retur_no` varchar(32) NOT NULL,
  `supplier_id` int(11) UNSIGNED NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `returs`
--

INSERT INTO `returs` (`retur_id`, `retur_no`, `supplier_id`, `description`, `status`, `create_at`, `create_by`) VALUES
(1, 'RET/MRS/I/2017/000001', 1, NULL, 0, '2017-01-15 17:11:38', 2);

-- --------------------------------------------------------

--
-- Table structure for table `retur_details`
--

CREATE TABLE `retur_details` (
  `retur_detail_id` int(11) UNSIGNED NOT NULL,
  `retur_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  `qty` int(11) NOT NULL DEFAULT '0',
  `item_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `qty_approved` int(11) DEFAULT '0',
  `qty_returned` int(11) UNSIGNED DEFAULT '0',
  `qty_rejected` int(11) DEFAULT '0',
  `total_price_approved` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `retur_details`
--

INSERT INTO `retur_details` (`retur_detail_id`, `retur_id`, `product_id`, `description`, `qty`, `item_price`, `total_price`, `qty_approved`, `qty_returned`, `qty_rejected`, `total_price_approved`) VALUES
(5, 1, 1, 'Rusak', 10, '0.00', '0.00', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `retur_orders`
--

CREATE TABLE `retur_orders` (
  `id` int(11) UNSIGNED NOT NULL,
  `order_id` int(11) UNSIGNED NOT NULL,
  `retur_no` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `retur_orders`
--

INSERT INTO `retur_orders` (`id`, `order_id`, `retur_no`, `status`, `create_at`, `create_by`) VALUES
(1, 1, 'RSL/MRS/II/2017/000001', 0, '2017-02-12 07:12:10', 2);

-- --------------------------------------------------------

--
-- Table structure for table `retur_order_details`
--

CREATE TABLE `retur_order_details` (
  `retur_detail_id` int(11) UNSIGNED NOT NULL,
  `retur_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  `qty` int(11) NOT NULL DEFAULT '0',
  `item_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `qty_approved` int(11) DEFAULT '0',
  `qty_returned` int(11) UNSIGNED DEFAULT '0',
  `qty_rejected` int(11) DEFAULT '0',
  `total_price_approved` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `retur_order_details`
--

INSERT INTO `retur_order_details` (`retur_detail_id`, `retur_id`, `product_id`, `description`, `qty`, `item_price`, `total_price`, `qty_approved`, `qty_returned`, `qty_rejected`, `total_price_approved`) VALUES
(3, 1, 1, '', 1, '0.00', '0.00', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(1) NOT NULL,
  `Var` varchar(30) NOT NULL,
  `Val` varchar(200) NOT NULL,
  `Ket` varchar(200) DEFAULT NULL,
  `Secure` tinyint(1) NOT NULL DEFAULT '0',
  `Status` enum('0','1') NOT NULL DEFAULT '1',
  `urut` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `Var`, `Val`, `Ket`, `Secure`, `Status`, `urut`) VALUES
(2, 'Long Company', 'Mutia Retail System', 'Deskripsi Pendek Nama Perusahaan', 0, '1', 2),
(1, 'Short Company', 'MRS', 'Deskripsi Pendek Nama Perusahaan', 0, '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `last_balance` int(11) DEFAULT '0',
  `added` int(11) NOT NULL DEFAULT '0',
  `reduced` int(11) NOT NULL DEFAULT '0',
  `balance` int(11) NOT NULL DEFAULT '0',
  `closing_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `closed_by` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `products_id`, `last_balance`, `added`, `reduced`, `balance`, `closing_date`, `closed_by`) VALUES
(1, 2, 0, 10, 0, 10, '2017-01-15 16:10:05', 0),
(2, 1, 0, 58, 20, 38, '2017-01-15 16:10:05', 0),
(3, 3, 0, 20, 0, 20, '2017-01-15 17:07:48', 0);

-- --------------------------------------------------------

--
-- Table structure for table `stocks_history`
--

CREATE TABLE `stocks_history` (
  `id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `last_balance` int(11) DEFAULT '0',
  `added` int(11) NOT NULL DEFAULT '0',
  `reduced` int(11) NOT NULL DEFAULT '0',
  `balance` int(11) NOT NULL DEFAULT '0',
  `closing_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `closed_by` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stocks_mutasi`
--

CREATE TABLE `stocks_mutasi` (
  `id` int(11) NOT NULL,
  `stocks_id` int(11) NOT NULL,
  `last_balance` int(11) NOT NULL DEFAULT '0',
  `added` int(11) NOT NULL DEFAULT '0',
  `reduced` int(11) NOT NULL DEFAULT '0',
  `balance` int(11) NOT NULL DEFAULT '0',
  `description` varchar(128) DEFAULT NULL,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stocks_mutasi`
--

INSERT INTO `stocks_mutasi` (`id`, `stocks_id`, `last_balance`, `added`, `reduced`, `balance`, `description`, `create_at`) VALUES
(1, 1, 0, 10, 0, 10, 'PO/MRS/I/2017/000001', '2017-01-15 16:10:05'),
(2, 2, 0, 20, 0, 20, 'PO/MRS/I/2017/000001', '2017-01-15 16:10:06'),
(3, 3, 0, 20, 0, 20, 'PO/MRS/I/2017/000002', '2017-01-15 17:07:48'),
(4, 2, 20, 30, 0, 50, 'PO/MRS/I/2017/000002', '2017-01-15 17:07:48'),
(5, 2, 50, 0, 5, 45, 'RET/MRS/I/2017/000001', '2017-01-15 17:48:54'),
(6, 2, 45, 5, 0, 50, 'RET/MRS/I/2017/000001', '2017-01-15 17:49:07'),
(7, 2, 50, 0, 10, 40, 'RET/MRS/I/2017/000001', '2017-01-15 17:53:35'),
(8, 2, 40, 0, 1, 39, 'SL/MRS/II/2017/000001', '2017-02-12 13:34:56'),
(9, 2, 39, 1, 0, 40, 'SL/MRS/II/2017/000001', '2017-02-12 13:35:56'),
(10, 2, 40, 0, 1, 39, 'SL/MRS/II/2017/000001', '2017-02-12 14:46:18'),
(11, 2, 39, 1, 0, 40, 'RSL/MRS/II/2017/000001', '2017-02-12 14:54:02'),
(12, 2, 40, 0, 1, 39, 'RSL/MRS/II/2017/000001', '2017-02-12 14:54:48'),
(13, 2, 39, 0, 1, 38, 'RSL/MRS/II/2017/000001', '2017-02-12 14:56:03'),
(14, 2, 38, 1, 0, 39, 'RSL/MRS/II/2017/000001', '2017-02-12 14:56:16'),
(15, 2, 39, 0, 1, 38, 'SL/MRS/II/2017/000001', '2017-02-12 15:36:50');

--
-- Triggers `stocks_mutasi`
--
DELIMITER $$
CREATE TRIGGER `stocks_mutasi_set_balance` BEFORE INSERT ON `stocks_mutasi` FOR EACH ROW BEGIN
	DECLARE _last_balance INT DEFAULT 0;
	
	SELECT 
		balance 
	FROM stocks_mutasi 
	WHERE stocks_id = NEW.stocks_id ORDER BY id DESC LIMIT 1 
	INTO _last_balance;

	SET NEW.added = ABS(NEW.added);
	SET NEW.reduced = ABS(NEW.reduced);

	SET NEW.balance = _last_balance + NEW.added - NEW.reduced;
	SET NEW.last_balance = _last_balance; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `stocks_mutasi_update_stocks` AFTER INSERT ON `stocks_mutasi` FOR EACH ROW BEGIN
	UPDATE stocks SET 	 
		added=added + NEW.added, 
		reduced=reduced + NEW.reduced, 
		balance=NEW.balance
WHERE id=NEW.stocks_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id` int(1) NOT NULL,
  `supplier_code` varchar(30) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `supplier_pin` varchar(20) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0=not active, 1=active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id`, `supplier_code`, `supplier_name`, `supplier_pin`, `status`) VALUES
(1, 'TS', 'Tes Supplier', '1234', 1),
(2, 'TS2', 'Supplier 2', '1234', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sys_config`
--

CREATE TABLE `sys_config` (
  `id` int(6) UNSIGNED NOT NULL,
  `tipe` varchar(32) NOT NULL,
  `nama` varchar(32) NOT NULL,
  `nilai` varchar(256) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_config`
--

INSERT INTO `sys_config` (`id`, `tipe`, `nama`, `nilai`, `status`) VALUES
(1, 'UPL_USR', 'upload_path', './uploads/users/', 1),
(2, 'UPL_USR', 'allowed_types', 'png|jpg|gif|jpeg', 1),
(3, 'UPL_USR', 'max_size', '200', 1),
(4, 'UPL_USR', 'overwrite', 'TRUE', 1),
(5, 'UPL_USR', 'max_height', '0', 1),
(6, 'UPL_USR', 'max_width', '0', 1),
(7, 'FORMAT', 'PO', 'PO/MRS/[MONTH]/[YEAR]/[NO]', 1),
(8, 'FORMAT', 'RETUR', 'RET/MRS/[MONTH]/[YEAR]/[NO]', 1),
(9, 'FORMAT', 'ORDER', 'SL/MRS/[MONTH]/[YEAR]/[NO]', 1),
(10, 'FORMAT', 'ORDER RETUR', 'RSL/MRS/[MONTH]/[YEAR]/[NO]', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sys_grup_akses`
--

CREATE TABLE `sys_grup_akses` (
  `id` int(6) UNSIGNED NOT NULL,
  `sys_grup_user_id` int(6) UNSIGNED NOT NULL,
  `sys_menu_id` int(6) UNSIGNED NOT NULL,
  `baca` tinyint(4) DEFAULT '0',
  `tambah` tinyint(4) DEFAULT '0',
  `ubah` tinyint(4) DEFAULT '0',
  `hapus` tinyint(4) DEFAULT '0',
  `cetak` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_grup_akses`
--

INSERT INTO `sys_grup_akses` (`id`, `sys_grup_user_id`, `sys_menu_id`, `baca`, `tambah`, `ubah`, `hapus`, `cetak`) VALUES
(1, 2, 2, 1, 1, 1, 1, 1),
(2, 2, 3, 1, 1, 1, 1, 1),
(4, 2, 14, 1, 1, 1, 1, 1),
(9, 2, 4, 1, 1, 1, 1, 1),
(10, 2, 5, 1, 1, 1, 1, 1),
(11, 2, 6, 1, 1, 1, 1, 1),
(12, 2, 7, 1, 1, 1, 1, 1),
(13, 2, 8, 1, 1, 1, 1, 1),
(14, 2, 25, 1, 1, 1, 1, 1),
(222, 2, 35, 1, 1, 1, 1, 1),
(223, 2, 36, 1, 1, 1, 1, 1),
(224, 2, 37, 1, 1, 1, 1, 1),
(225, 2, 38, 1, 1, 1, 1, 1),
(226, 2, 39, 1, 1, 1, 1, 1),
(227, 2, 40, 1, 1, 1, 1, 1),
(228, 2, 41, 1, 1, 1, 1, 1),
(229, 2, 42, 1, 1, 1, 1, 1),
(230, 2, 43, 1, 1, 1, 1, 1),
(231, 2, 44, 1, 1, 1, 1, 1),
(232, 2, 45, 1, 1, 1, 1, 1),
(233, 2, 46, 1, 1, 1, 1, 1),
(234, 2, 47, 1, 1, 1, 1, 1),
(235, 2, 48, 1, 1, 1, 1, 1),
(236, 2, 49, 1, 1, 1, 1, 1),
(237, 2, 50, 1, 1, 1, 1, 1),
(238, 2, 51, 1, 1, 1, 1, 1),
(239, 2, 52, 1, 1, 1, 1, 1),
(240, 2, 53, 1, 1, 1, 1, 1),
(241, 3, 2, 0, 0, 0, 0, 0),
(242, 3, 3, 0, 0, 0, 0, 0),
(243, 3, 14, 0, 0, 0, 0, 0),
(244, 3, 44, 1, 1, 1, 1, 1),
(245, 3, 49, 0, 0, 0, 0, 0),
(246, 3, 4, 0, 0, 0, 0, 0),
(247, 3, 5, 0, 0, 0, 0, 0),
(248, 3, 6, 0, 0, 0, 0, 0),
(249, 3, 7, 0, 0, 0, 0, 0),
(250, 3, 8, 0, 0, 0, 0, 0),
(251, 3, 25, 0, 0, 0, 0, 0),
(252, 3, 35, 0, 0, 0, 0, 0),
(253, 3, 36, 0, 0, 0, 0, 0),
(254, 3, 37, 0, 0, 0, 0, 0),
(255, 3, 38, 0, 0, 0, 0, 0),
(256, 3, 39, 0, 0, 0, 0, 0),
(257, 3, 40, 0, 0, 0, 0, 0),
(258, 3, 41, 0, 0, 0, 0, 0),
(259, 3, 42, 0, 0, 0, 0, 0),
(260, 3, 43, 0, 0, 0, 0, 0),
(261, 3, 45, 0, 0, 0, 0, 0),
(262, 3, 46, 0, 0, 0, 0, 0),
(263, 3, 47, 0, 0, 0, 0, 0),
(264, 3, 48, 0, 0, 0, 0, 0),
(265, 3, 52, 0, 0, 0, 0, 0),
(266, 3, 53, 0, 0, 0, 0, 0),
(267, 3, 50, 0, 0, 0, 0, 0),
(268, 3, 51, 0, 0, 0, 0, 0),
(269, 2, 54, 1, 1, 1, 1, 1),
(270, 3, 54, 1, 0, 0, 0, 0),
(271, 2, 55, 1, 1, 1, 1, 1),
(272, 3, 55, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sys_grup_user`
--

CREATE TABLE `sys_grup_user` (
  `id` int(6) UNSIGNED NOT NULL,
  `nama` varchar(128) NOT NULL,
  `keterangan` varchar(128) DEFAULT NULL,
  `is_merchant_grup` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_grup_user`
--

INSERT INTO `sys_grup_user` (`id`, `nama`, `keterangan`, `is_merchant_grup`, `status`) VALUES
(2, 'Administrator', 'Administrator', 0, 1),
(3, 'Device', 'Group Untuk Device', 0, 1);

--
-- Triggers `sys_grup_user`
--
DELIMITER $$
CREATE TRIGGER `sys_grup_user_set_sys_grup_akses` AFTER INSERT ON `sys_grup_user` FOR EACH ROW BEGIN
INSERT INTO sys_grup_akses (sys_grup_user_id, sys_menu_id, baca, tambah, ubah, hapus, cetak)
		SELECT NEW.ID, id, 0, 0, 0, 0, 0 FROM sys_menu;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sys_log`
--

CREATE TABLE `sys_log` (
  `id` int(11) UNSIGNED NOT NULL,
  `sys_user_id` int(6) UNSIGNED NOT NULL,
  `log_event` varchar(128) DEFAULT NULL,
  `log_object` varchar(128) DEFAULT NULL,
  `log_ref_key` varchar(128) DEFAULT NULL,
  `log_date` date DEFAULT NULL,
  `log_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_log`
--

INSERT INTO `sys_log` (`id`, `sys_user_id`, `log_event`, `log_object`, `log_ref_key`, `log_date`, `log_time`) VALUES
(1435, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:13:25'),
(1436, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:13:31'),
(1437, 2, 'Remove', 'setting/grup_user', '6', '2016-12-10', '21:13:35'),
(1438, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:13:36'),
(1439, 2, 'Remove', 'setting/grup_user', '5', '2016-12-10', '21:13:39'),
(1440, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:13:39'),
(1441, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:13:45'),
(1442, 2, 'Show', 'setting/user', '', '2016-12-10', '21:14:05'),
(1443, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:14:43'),
(1444, 2, 'Update', 'setting/menu', '2', '2016-12-10', '21:16:57'),
(1445, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:16:58'),
(1446, 2, 'Update', 'setting/menu', '3', '2016-12-10', '21:17:42'),
(1447, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:17:42'),
(1448, 2, 'Update', 'setting/menu', '9', '2016-12-10', '21:18:10'),
(1449, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:18:10'),
(1450, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:18:50'),
(1451, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:19:00'),
(1452, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:19:01'),
(1453, 2, 'Show', 'setting/user', '', '2016-12-10', '21:19:03'),
(1454, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:19:04'),
(1455, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:19:12'),
(1456, 2, 'Show', 'setting/user', '', '2016-12-10', '21:19:23'),
(1457, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:19:24'),
(1458, 2, 'Remove', 'setting/konfigurasi', '12', '2016-12-10', '21:19:33'),
(1459, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:19:33'),
(1460, 2, 'Remove', 'setting/konfigurasi', '10', '2016-12-10', '21:19:36'),
(1461, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:19:36'),
(1462, 2, 'Remove', 'setting/konfigurasi', '11', '2016-12-10', '21:19:40'),
(1463, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:19:40'),
(1464, 2, 'Remove', 'setting/konfigurasi', '7', '2016-12-10', '21:19:43'),
(1465, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:19:43'),
(1466, 2, 'Remove', 'setting/konfigurasi', '9', '2016-12-10', '21:19:47'),
(1467, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:19:47'),
(1468, 2, 'Remove', 'setting/konfigurasi', '8', '2016-12-10', '21:19:50'),
(1469, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:19:50'),
(1470, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:19:54'),
(1471, 2, 'Show', 'setting/user', '', '2016-12-10', '21:20:02'),
(1472, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:20:03'),
(1473, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:20:04'),
(1474, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:20:12'),
(1475, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:20:38'),
(1476, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:20:39'),
(1477, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:20:44'),
(1478, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:20:46'),
(1479, 2, 'Show', 'setting/user', '', '2016-12-10', '21:20:48'),
(1480, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:20:51'),
(1481, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:20:55'),
(1482, 2, 'Remove', 'setting/menu', '26', '2016-12-10', '21:21:23'),
(1483, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:21:24'),
(1484, 2, 'Remove', 'setting/menu', '22', '2016-12-10', '21:21:28'),
(1485, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:21:28'),
(1486, 2, 'Remove', 'setting/menu', '21', '2016-12-10', '21:21:31'),
(1487, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:21:31'),
(1488, 2, 'Remove', 'setting/menu', '20', '2016-12-10', '21:21:36'),
(1489, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:21:36'),
(1490, 2, 'Remove', 'setting/menu', '9', '2016-12-10', '21:21:40'),
(1491, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:21:40'),
(1492, 2, 'Remove', 'setting/menu', '10', '2016-12-10', '21:21:53'),
(1493, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:21:53'),
(1494, 2, 'Remove', 'setting/menu', '11', '2016-12-10', '21:22:00'),
(1495, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:00'),
(1496, 2, 'Remove', 'setting/menu', '28', '2016-12-10', '21:22:05'),
(1497, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:05'),
(1498, 2, 'Remove', 'setting/menu', '29', '2016-12-10', '21:22:09'),
(1499, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:10'),
(1500, 2, 'Remove', 'setting/menu', '12', '2016-12-10', '21:22:14'),
(1501, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:14'),
(1502, 2, 'Remove', 'setting/menu', '15', '2016-12-10', '21:22:17'),
(1503, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:17'),
(1504, 2, 'Remove', 'setting/menu', '24', '2016-12-10', '21:22:21'),
(1505, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:21'),
(1506, 2, 'Remove', 'setting/menu', '23', '2016-12-10', '21:22:25'),
(1507, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:25'),
(1508, 2, 'Remove', 'setting/menu', '19', '2016-12-10', '21:22:30'),
(1509, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:30'),
(1510, 2, 'Remove', 'setting/menu', '18', '2016-12-10', '21:22:34'),
(1511, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:34'),
(1512, 2, 'Remove', 'setting/menu', '17', '2016-12-10', '21:22:38'),
(1513, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:38'),
(1514, 2, 'Remove', 'setting/menu', '16', '2016-12-10', '21:22:43'),
(1515, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:43'),
(1516, 2, 'Remove', 'setting/menu', '34', '2016-12-10', '21:22:47'),
(1517, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:47'),
(1518, 2, 'Remove', 'setting/menu', '27', '2016-12-10', '21:22:51'),
(1519, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:52'),
(1520, 2, 'Remove', 'setting/menu', '30', '2016-12-10', '21:22:55'),
(1521, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:55'),
(1522, 2, 'Remove', 'setting/menu', '31', '2016-12-10', '21:22:59'),
(1523, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:22:59'),
(1524, 2, 'Remove', 'setting/menu', '32', '2016-12-10', '21:23:06'),
(1525, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:23:06'),
(1526, 2, 'Remove', 'setting/menu', '33', '2016-12-10', '21:23:09'),
(1527, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:23:09'),
(1528, 2, 'Show', 'setting/user', '', '2016-12-10', '21:23:17'),
(1529, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:23:19'),
(1530, 2, 'Show', 'setting/user', '', '2016-12-10', '21:23:21'),
(1531, 2, 'Show', 'log/auditrail', '2', '2016-12-10', '21:23:30'),
(1532, 2, 'Show', 'log/auditrail', '2', '2016-12-10', '21:23:37'),
(1533, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:23:44'),
(1534, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:23:47'),
(1535, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:23:52'),
(1536, 2, 'Show', 'setting/grup_akses', '', '2016-12-10', '21:24:06'),
(1537, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:24:16'),
(1538, 2, 'Show', 'setting/grup_akses', '', '2016-12-10', '21:24:19'),
(1539, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:24:38'),
(1540, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:24:39'),
(1541, 2, 'Show', 'setting/user', '', '2016-12-10', '21:24:41'),
(1542, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:24:41'),
(1543, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:25:53'),
(1544, 2, 'Add', 'setting/menu', '35', '2016-12-10', '21:26:28'),
(1545, 2, 'Show', 'log/auditrail', '', '2016-12-10', '21:26:32'),
(1546, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:27:22'),
(1547, 2, 'Add', 'setting/menu', '36', '2016-12-10', '21:27:58'),
(1548, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:28:03'),
(1549, 2, 'Show', 'setting/user', '', '2016-12-10', '21:28:05'),
(1550, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:28:07'),
(1551, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:28:09'),
(1552, 2, 'Add', 'setting/menu', '37', '2016-12-10', '21:31:58'),
(1553, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:32:02'),
(1554, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:33:23'),
(1555, 2, 'Show', 'setting/konfigurasi', '', '2016-12-10', '21:33:40'),
(1556, 2, 'Show', 'setting/user', '', '2016-12-10', '21:33:41'),
(1557, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:33:43'),
(1558, 2, 'Show', 'setting/grup_user', '', '2016-12-10', '21:33:45'),
(1559, 2, 'Show', 'setting/menu', '', '2016-12-10', '21:33:46'),
(1560, 2, 'Show', 'setting/menu', '', '2016-12-11', '07:34:40'),
(1561, 2, 'Show', 'setting/menu', '', '2016-12-11', '17:30:56'),
(1562, 2, 'Show', 'setting/grup_akses', '', '2016-12-11', '17:31:24'),
(1563, 2, 'Update', 'setting/grup_akses', '222', '2016-12-11', '17:31:31'),
(1564, 2, 'Show', 'setting/supplier', '', '2016-12-11', '17:38:19'),
(1565, 2, 'Show', 'setting/produk', '', '2016-12-11', '17:52:34'),
(1566, 2, 'Show', 'setting/produk', '', '2016-12-11', '17:53:46'),
(1567, 2, 'Show', 'setting/produk', '', '2016-12-11', '17:55:04'),
(1568, 2, 'Show', 'setting/produk', '', '2016-12-11', '17:55:52'),
(1569, 2, 'Show', 'setting/produk', '', '2016-12-11', '17:58:06'),
(1570, 2, 'Show', 'setting/produk', '', '2016-12-11', '17:59:10'),
(1571, 2, 'Show', 'log/auditrail', '', '2016-12-11', '17:59:23'),
(1572, 2, 'Show', 'log/auditrail', '', '2016-12-11', '17:59:30'),
(1573, 2, 'Show', 'log/auditrail', '', '2016-12-11', '17:59:33'),
(1574, 2, 'Show', 'log/auditrail', '', '2016-12-11', '17:59:36'),
(1575, 2, 'Show', 'log/auditrail', '', '2016-12-11', '17:59:38'),
(1576, 2, 'Show', 'log/auditrail', '', '2016-12-11', '17:59:42'),
(1577, 2, 'Show', 'log/auditrail', '', '2016-12-11', '17:59:45'),
(1578, 2, 'Show', 'log/auditrail', '', '2016-12-11', '17:59:48'),
(1579, 2, 'Show', 'setting/produk', '', '2016-12-11', '17:59:55'),
(1580, 2, 'Show', 'setting/produk', '', '2016-12-11', '18:40:24'),
(1581, 2, 'Add', 'setting/produk', '8', '2016-12-11', '18:43:45'),
(1582, 2, 'Show', 'setting/produk', '', '2016-12-11', '18:44:08'),
(1583, 2, 'Show', 'setting/produk', '', '2016-12-11', '18:53:05'),
(1584, 2, 'Add', 'setting/produk', '9', '2016-12-11', '18:54:04'),
(1585, 2, 'Show', 'setting/produk', '', '2016-12-11', '18:54:04'),
(1586, 2, 'Remove', 'setting/produk', '9', '2016-12-11', '18:54:10'),
(1587, 2, 'Show', 'setting/produk', '', '2016-12-11', '18:54:11'),
(1588, 2, 'Remove', 'setting/produk', '8', '2016-12-11', '18:54:31'),
(1589, 2, 'Show', 'setting/produk', '', '2016-12-11', '18:54:32'),
(1590, 2, 'Show', 'setting/supplier', '', '2016-12-11', '18:54:44'),
(1591, 2, 'Add', 'setting/supplier', '1', '2016-12-11', '18:55:41'),
(1592, 2, 'Show', 'setting/supplier', '', '2016-12-11', '18:55:41'),
(1593, 2, 'Update', 'setting/supplier', '1', '2016-12-11', '18:55:46'),
(1594, 2, 'Show', 'setting/supplier', '', '2016-12-11', '18:55:47'),
(1595, 2, 'Remove', 'setting/supplier', '1', '2016-12-11', '18:55:50'),
(1596, 2, 'Show', 'setting/supplier', '', '2016-12-11', '18:55:50'),
(1597, 2, 'Show', 'setting/produk', '', '2016-12-11', '18:58:08'),
(1598, 2, 'Show', 'setting/produk', '', '2016-12-11', '18:58:12'),
(1599, 2, 'Show', 'setting/menu', '', '2016-12-11', '18:58:13'),
(1600, 2, 'Show', 'setting/grup_user', '', '2016-12-11', '18:58:14'),
(1601, 2, 'Show', 'setting/supplier', '', '2016-12-11', '18:58:14'),
(1602, 2, 'Show', 'setting/user', '', '2016-12-11', '18:58:15'),
(1603, 2, 'Show', 'setting/konfigurasi', '', '2016-12-11', '18:58:16'),
(1604, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:47:22'),
(1605, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:47:34'),
(1606, 2, 'Update', 'setting/menu', '36', '2016-12-12', '11:47:49'),
(1607, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:47:49'),
(1608, 2, 'Update', 'setting/menu', '37', '2016-12-12', '11:48:45'),
(1609, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:48:45'),
(1610, 2, 'Update', 'setting/menu', '4', '2016-12-12', '11:48:55'),
(1611, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:48:55'),
(1612, 2, 'Update', 'setting/menu', '7', '2016-12-12', '11:49:07'),
(1613, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:49:07'),
(1614, 2, 'Update', 'setting/menu', '6', '2016-12-12', '11:49:16'),
(1615, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:49:16'),
(1616, 2, 'Update', 'setting/menu', '8', '2016-12-12', '11:49:23'),
(1617, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:49:23'),
(1618, 2, 'Update', 'setting/menu', '35', '2016-12-12', '11:49:34'),
(1619, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:49:35'),
(1620, 2, 'Add', 'setting/menu', '38', '2016-12-12', '11:52:29'),
(1621, 2, 'Show', 'setting/supplier', '', '2016-12-12', '11:52:38'),
(1622, 2, 'Show', 'setting/supplier', '', '2016-12-12', '11:52:43'),
(1623, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:54:14'),
(1624, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '11:54:18'),
(1625, 2, 'Update', 'setting/grup_akses', '225', '2016-12-12', '11:54:25'),
(1626, 2, 'Show', 'setting/brand', '', '2016-12-12', '11:55:33'),
(1627, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:55:59'),
(1628, 2, 'Add', 'setting/menu', '39', '2016-12-12', '11:56:23'),
(1629, 2, 'Show', 'setting/menu', '', '2016-12-12', '11:56:28'),
(1630, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '11:56:34'),
(1631, 2, 'Update', 'setting/grup_akses', '226', '2016-12-12', '11:56:40'),
(1632, 2, 'Show', 'setting/supplier', '', '2016-12-12', '11:58:09'),
(1633, 2, 'Show', 'setting/satuan', '', '2016-12-12', '11:59:19'),
(1634, 2, 'Show', 'setting/supplier', '', '2016-12-12', '11:59:56'),
(1635, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:02:50'),
(1636, 2, 'Update', 'setting/menu', '37', '2016-12-12', '12:03:01'),
(1637, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:03:01'),
(1638, 2, 'Show', 'setting/customer', '', '2016-12-12', '12:03:18'),
(1639, 2, 'Show', 'setting/customer', '', '2016-12-12', '12:03:30'),
(1640, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:05:52'),
(1641, 2, 'Add', 'setting/menu', '40', '2016-12-12', '12:06:16'),
(1642, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:06:20'),
(1643, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:06:23'),
(1644, 2, 'Update', 'setting/grup_akses', '227', '2016-12-12', '12:06:31'),
(1645, 2, 'Show', 'setting/tipe_produk', '', '2016-12-12', '12:06:39'),
(1646, 2, 'Show', 'setting/supplier', '', '2016-12-12', '12:11:16'),
(1647, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:11:19'),
(1648, 2, 'Add', 'setting/menu', '41', '2016-12-12', '12:12:28'),
(1649, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:12:36'),
(1650, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:14:47'),
(1651, 2, 'Update', 'setting/grup_akses', '228', '2016-12-12', '12:14:53'),
(1652, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:14:53'),
(1653, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:15:09'),
(1654, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:15:24'),
(1655, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:15:28'),
(1656, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:16:55'),
(1657, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:17:27'),
(1658, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:17:45'),
(1659, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:17:53'),
(1660, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:18:56'),
(1661, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:19:00'),
(1662, 2, 'Show', 'setting/provider', '', '2016-12-12', '12:19:26'),
(1663, 2, 'Add', 'setting/provider', '13', '2016-12-12', '12:22:54'),
(1664, 2, 'Show', 'setting/provider', '', '2016-12-12', '12:22:54'),
(1665, 2, 'Update', 'setting/provider', '1', '2016-12-12', '12:23:01'),
(1666, 2, 'Show', 'setting/provider', '', '2016-12-12', '12:23:01'),
(1667, 2, 'Remove', 'setting/provider', '13', '2016-12-12', '12:23:06'),
(1668, 2, 'Show', 'setting/provider', '', '2016-12-12', '12:23:06'),
(1669, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:24:34'),
(1670, 2, 'Add', 'setting/menu', '42', '2016-12-12', '12:24:51'),
(1671, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:24:51'),
(1672, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:24:59'),
(1673, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:25:05'),
(1674, 2, 'Update', 'setting/grup_akses', '229', '2016-12-12', '12:25:11'),
(1675, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:25:11'),
(1676, 2, 'Show', 'setting/parsing', '', '2016-12-12', '12:30:11'),
(1677, 2, 'Show', 'setting/user', '', '2016-12-12', '12:30:39'),
(1678, 2, 'Show', 'setting/grup_user', '', '2016-12-12', '12:30:40'),
(1679, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:30:41'),
(1680, 2, 'Show', 'setting/provider', '', '2016-12-12', '12:30:42'),
(1681, 2, 'Show', 'setting/satuan', '', '2016-12-12', '12:30:43'),
(1682, 2, 'Show', 'setting/brand', '', '2016-12-12', '12:30:44'),
(1683, 2, 'Show', 'setting/tipe_produk', '', '2016-12-12', '12:30:45'),
(1684, 2, 'Show', 'setting/produk', '', '2016-12-12', '12:30:45'),
(1685, 2, 'Show', 'setting/customer', '', '2016-12-12', '12:30:46'),
(1686, 2, 'Show', 'setting/supplier', '', '2016-12-12', '12:30:47'),
(1687, 2, 'Show', 'setting/parsing', '', '2016-12-12', '12:30:48'),
(1688, 2, 'Show', 'setting/parsing', '', '2016-12-12', '12:33:06'),
(1689, 2, 'Show', 'setting/supplier', '', '2016-12-12', '12:38:48'),
(1690, 2, 'Add', 'setting/supplier', '1', '2016-12-12', '12:39:07'),
(1691, 2, 'Show', 'setting/supplier', '', '2016-12-12', '12:39:07'),
(1692, 2, 'Show', 'setting/parsing', '', '2016-12-12', '12:39:10'),
(1693, 2, 'Add', 'setting/parsing', '1', '2016-12-12', '12:40:08'),
(1694, 2, 'Show', 'setting/parsing', '', '2016-12-12', '12:40:08'),
(1695, 2, 'Show', 'setting/produk', '', '2016-12-12', '12:51:54'),
(1696, 2, 'Show', 'setting/satuan', '', '2016-12-12', '12:52:18'),
(1697, 2, 'Show', 'setting/produk', '', '2016-12-12', '12:52:19'),
(1698, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:52:53'),
(1699, 2, 'Add', 'setting/menu', '43', '2016-12-12', '12:53:14'),
(1700, 2, 'Show', 'setting/menu', '', '2016-12-12', '12:53:14'),
(1701, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:53:42'),
(1702, 2, 'Update', 'setting/grup_akses', '230', '2016-12-12', '12:53:50'),
(1703, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '12:53:50'),
(1704, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '13:05:33'),
(1705, 2, 'Show', 'setting/prefix', '', '2016-12-12', '13:08:52'),
(1706, 2, 'Show', 'setting/prefix', '', '2016-12-12', '13:08:56'),
(1707, 2, 'Show', 'setting/prefix', '', '2016-12-12', '13:09:46'),
(1708, 2, 'Add', 'setting/prefix', '246', '2016-12-12', '13:09:55'),
(1709, 2, 'Show', 'setting/prefix', '', '2016-12-12', '13:09:55'),
(1710, 2, 'Show', 'setting/prefix', '', '2016-12-12', '13:09:58'),
(1711, 2, 'Remove', 'setting/prefix', '246', '2016-12-12', '13:10:01'),
(1712, 2, 'Show', 'setting/prefix', '', '2016-12-12', '13:10:01'),
(1713, 2, 'Show', 'setting/menu', '', '2016-12-12', '13:14:00'),
(1714, 2, 'Add', 'setting/menu', '44', '2016-12-12', '13:24:48'),
(1715, 2, 'Show', 'setting/menu', '', '2016-12-12', '13:24:49'),
(1716, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '13:24:56'),
(1717, 2, 'Update', 'setting/grup_akses', '231', '2016-12-12', '13:25:03'),
(1718, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '13:25:03'),
(1719, 2, 'Add', 'setting/menu', '45', '2016-12-12', '13:25:32'),
(1720, 2, 'Show', 'setting/menu', '', '2016-12-12', '13:25:32'),
(1721, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '13:25:38'),
(1722, 2, 'Update', 'setting/grup_akses', '232', '2016-12-12', '13:25:45'),
(1723, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '13:25:45'),
(1724, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '13:33:43'),
(1725, 2, 'Show', 'setting/menu', '', '2016-12-12', '13:33:58'),
(1726, 2, 'Show', 'setting/grup_akses', '', '2016-12-12', '13:34:02'),
(1727, 2, 'Show', 'setting/menu', '', '2016-12-12', '13:34:12'),
(1728, 2, 'Update', 'setting/menu', '44', '2016-12-12', '13:34:27'),
(1729, 2, 'Show', 'setting/menu', '', '2016-12-12', '13:34:27'),
(1730, 2, 'Show', 'setting/menu', '', '2016-12-12', '13:35:50'),
(1731, 2, 'Update', 'setting/menu', '44', '2016-12-12', '13:35:58'),
(1732, 2, 'Show', 'setting/menu', '', '2016-12-12', '13:35:58'),
(1733, 2, 'Show', 'setting/parsing', '', '2016-12-12', '16:55:46'),
(1734, 2, 'Show', 'setting/prefix', '', '2016-12-12', '16:55:48'),
(1735, 2, 'Show', 'setting/supplier', '', '2016-12-12', '16:55:50'),
(1736, 2, 'Show', 'setting/customer', '', '2016-12-12', '16:55:51'),
(1737, 2, 'Show', 'setting/produk', '', '2016-12-12', '16:55:52'),
(1738, 2, 'Show', 'setting/brand', '', '2016-12-12', '16:55:53'),
(1739, 2, 'Show', 'setting/tipe_produk', '', '2016-12-12', '16:55:55'),
(1740, 2, 'Show', 'setting/satuan', '', '2016-12-12', '16:55:56'),
(1741, 2, 'Show', 'setting/provider', '', '2016-12-12', '16:55:57'),
(1742, 2, 'Show', 'setting/menu', '', '2016-12-12', '16:55:58'),
(1743, 2, 'Show', 'setting/parsing', '', '2016-12-12', '16:56:02'),
(1744, 2, 'Add', 'setting/parsing', '4', '2016-12-12', '16:57:55'),
(1745, 2, 'Show', 'setting/parsing', '', '2016-12-12', '16:57:55'),
(1746, 2, 'Remove', 'setting/parsing', '1', '2016-12-12', '16:58:18'),
(1747, 2, 'Show', 'setting/parsing', '', '2016-12-12', '16:58:18'),
(1748, 2, 'Remove', 'setting/parsing', '4', '2016-12-12', '16:58:23'),
(1749, 2, 'Show', 'setting/parsing', '', '2016-12-12', '16:58:23'),
(1750, 2, 'Show', 'setting/prefix', '', '2016-12-12', '16:58:25'),
(1751, 2, 'Show', 'setting/supplier', '', '2016-12-12', '16:58:27'),
(1752, 2, 'Show', 'setting/parsing', '', '2016-12-12', '16:59:37'),
(1753, 2, 'Add', 'setting/parsing', '5', '2016-12-12', '17:06:04'),
(1754, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:06:04'),
(1755, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:06:11'),
(1756, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:06:47'),
(1757, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:06:54'),
(1758, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:06:58'),
(1759, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:07:47'),
(1760, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:12:06'),
(1761, 2, 'Show', 'setting/menu', '', '2016-12-12', '17:12:40'),
(1762, 2, 'Update', 'setting/menu', '42', '2016-12-12', '17:12:48'),
(1763, 2, 'Show', 'setting/menu', '', '2016-12-12', '17:12:49'),
(1764, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:15:16'),
(1765, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:15:19'),
(1766, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:20:58'),
(1767, 2, 'Add', 'setting/supplier', '2', '2016-12-12', '17:21:20'),
(1768, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:21:20'),
(1769, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:21:28'),
(1770, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:22:28'),
(1771, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:22:31'),
(1772, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:22:35'),
(1773, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:22:59'),
(1774, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:26:25'),
(1775, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:26:56'),
(1776, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:29:20'),
(1777, 2, 'Add', 'setting/parsing', '6', '2016-12-12', '17:29:36'),
(1778, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:30:44'),
(1779, 2, 'Add', 'setting/parsing', '7', '2016-12-12', '17:31:00'),
(1780, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:32:10'),
(1781, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:32:55'),
(1782, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:33:02'),
(1783, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:33:09'),
(1784, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:33:18'),
(1785, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:33:35'),
(1786, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:33:43'),
(1787, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:37:05'),
(1788, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:37:42'),
(1789, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:38:40'),
(1790, 2, 'Add', 'setting/parsing', '8', '2016-12-12', '17:38:50'),
(1791, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:38:50'),
(1792, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:38:56'),
(1793, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:39:02'),
(1794, 2, 'Add', 'setting/parsing', '9', '2016-12-12', '17:39:12'),
(1795, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:39:12'),
(1796, 2, 'Update', 'setting/parsing', '1', '2016-12-12', '17:39:21'),
(1797, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:39:21'),
(1798, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:39:25'),
(1799, 2, 'Remove', 'setting/parsing', '9', '2016-12-12', '17:39:29'),
(1800, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:39:29'),
(1801, 2, 'Add', 'setting/parsing', '10', '2016-12-12', '17:39:42'),
(1802, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:39:42'),
(1803, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:39:48'),
(1804, 2, 'Show', 'setting/produk', '', '2016-12-12', '17:39:54'),
(1805, 2, 'Show', 'setting/tipe_produk', '', '2016-12-12', '17:40:03'),
(1806, 2, 'Show', 'setting/brand', '', '2016-12-12', '17:40:05'),
(1807, 2, 'Show', 'setting/produk', '', '2016-12-12', '17:40:07'),
(1808, 2, 'Show', 'setting/customer', '', '2016-12-12', '17:40:08'),
(1809, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:40:09'),
(1810, 2, 'Show', 'setting/prefix', '', '2016-12-12', '17:40:10'),
(1811, 2, 'Show', 'setting/prefix', '', '2016-12-12', '17:40:35'),
(1812, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:40:36'),
(1813, 2, 'Show', 'setting/customer', '', '2016-12-12', '17:40:38'),
(1814, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:40:39'),
(1815, 2, 'Show', 'setting/parsing', '', '2016-12-12', '17:40:40'),
(1816, 2, 'Show', 'setting/produk', '', '2016-12-12', '17:40:45'),
(1817, 2, 'Show', 'setting/brand', '', '2016-12-12', '17:40:54'),
(1818, 2, 'Show', 'setting/satuan', '', '2016-12-12', '17:40:56'),
(1819, 2, 'Show', 'setting/provider', '', '2016-12-12', '17:40:58'),
(1820, 2, 'Show', 'setting/brand', '', '2016-12-12', '17:41:00'),
(1821, 2, 'Show', 'setting/prefix', '', '2016-12-12', '17:41:03'),
(1822, 2, 'Show', 'setting/supplier', '', '2016-12-12', '17:41:05'),
(1823, 2, 'Show', 'setting/customer', '', '2016-12-12', '17:41:08'),
(1824, 2, 'Show', 'setting/prefix', '', '2016-12-19', '18:56:31'),
(1825, 2, 'Show', 'setting/supplier', '', '2016-12-19', '18:56:33'),
(1826, 2, 'Show', 'setting/customer', '', '2016-12-19', '18:56:35'),
(1827, 2, 'Show', 'setting/produk', '', '2016-12-19', '18:56:37'),
(1828, 2, 'Show', 'setting/brand', '', '2016-12-19', '18:56:39'),
(1829, 2, 'Show', 'setting/tipe_produk', '', '2016-12-19', '18:56:40'),
(1830, 2, 'Show', 'setting/satuan', '', '2016-12-19', '18:56:42'),
(1831, 2, 'Show', 'setting/provider', '', '2016-12-19', '18:56:43'),
(1832, 2, 'Show', 'setting/menu', '', '2016-12-19', '18:56:45'),
(1833, 2, 'Show', 'setting/grup_user', '', '2016-12-19', '18:56:47'),
(1834, 2, 'Show', 'setting/user', '', '2016-12-19', '18:56:49'),
(1835, 2, 'Show', 'setting/konfigurasi', '', '2016-12-19', '18:56:57'),
(1836, 2, 'Show', 'transaksi/pembelian', '', '2016-12-19', '18:57:01'),
(1837, 2, 'Show', 'transaksi/pembelian', '', '2016-12-19', '18:58:54'),
(1838, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '16:11:28'),
(1839, 2, 'Show', 'setting/customer', '', '2016-12-20', '16:13:32'),
(1840, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '16:13:37'),
(1841, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '16:26:42'),
(1842, 2, 'Show', 'setting/konfigurasi', '', '2016-12-20', '16:31:45'),
(1843, 2, 'Add', 'setting/konfigurasi', '7', '2016-12-20', '16:35:10'),
(1844, 2, 'Show', 'setting/konfigurasi', '', '2016-12-20', '16:35:11'),
(1845, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '16:36:21'),
(1846, 2, 'Show', 'setting/konfigurasi', '', '2016-12-20', '16:41:37'),
(1847, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '16:47:24'),
(1848, 2, 'Update', 'setting/konfigurasi', '7', '2016-12-20', '16:55:00'),
(1849, 2, 'Show', 'setting/konfigurasi', '', '2016-12-20', '16:55:00'),
(1850, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:03:15'),
(1851, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:03:37'),
(1852, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:04:31'),
(1853, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:05:11'),
(1854, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:05:55'),
(1855, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:06:07'),
(1856, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:06:55'),
(1857, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:07:28'),
(1858, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:08:00'),
(1859, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:08:57'),
(1860, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:09:13'),
(1861, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:10:09'),
(1862, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:10:36'),
(1863, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:10:57'),
(1864, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:11:16'),
(1865, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:11:26'),
(1866, 2, 'Update', 'setting/konfigurasi', '7', '2016-12-20', '17:21:57'),
(1867, 2, 'Show', 'setting/konfigurasi', '', '2016-12-20', '17:21:57'),
(1868, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:22:12'),
(1869, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:23:42'),
(1870, 2, 'Add', 'transaksi/pembelian', '1', '2016-12-20', '17:25:34'),
(1871, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:25:34'),
(1872, 2, 'Add', 'transaksi/pembelian', '2', '2016-12-20', '17:26:21'),
(1873, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:26:21'),
(1874, 2, 'Add', 'transaksi/pembelian', '3', '2016-12-20', '17:26:45'),
(1875, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:26:45'),
(1876, 2, 'Remove', 'transaksi/pembelian', '1', '2016-12-20', '17:26:50'),
(1877, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:26:51'),
(1878, 2, 'Remove', 'transaksi/pembelian', '2', '2016-12-20', '17:26:53'),
(1879, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:26:53'),
(1880, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '17:28:16'),
(1881, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:19:01'),
(1882, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:19:45'),
(1883, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:20:06'),
(1884, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:20:38'),
(1885, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:21:18'),
(1886, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:23:54'),
(1887, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:24:01'),
(1888, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:24:44'),
(1889, 2, 'Show', 'setting/menu', '', '2016-12-20', '19:24:56'),
(1890, 2, 'Add', 'setting/menu', '46', '2016-12-20', '19:25:43'),
(1891, 2, 'Show', 'setting/menu', '', '2016-12-20', '19:25:43'),
(1892, 2, 'Show', 'setting/grup_akses', '', '2016-12-20', '19:25:55'),
(1893, 2, 'Update', 'setting/grup_akses', '233', '2016-12-20', '19:26:07'),
(1894, 2, 'Show', 'setting/grup_akses', '', '2016-12-20', '19:26:07'),
(1895, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:26:44'),
(1896, 2, 'Show', 'setting/supplier', '', '2016-12-20', '19:28:43'),
(1897, 2, 'Show', 'setting/parsing', '', '2016-12-20', '19:28:48'),
(1898, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-20', '19:37:00'),
(1899, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-20', '19:43:10'),
(1900, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-20', '19:50:19'),
(1901, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '19:54:12'),
(1902, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-20', '19:54:15'),
(1903, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-20', '20:07:34'),
(1904, 2, 'Add', 'transaksi/detil_pembelian', '1', '2016-12-20', '20:07:51'),
(1905, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-20', '20:07:51'),
(1906, 2, 'Add', 'transaksi/detil_pembelian', '2', '2016-12-20', '20:08:11'),
(1907, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-20', '20:08:11'),
(1908, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-20', '20:08:31'),
(1909, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:09:46'),
(1910, 2, 'Add', 'transaksi/pembelian', '4', '2016-12-20', '20:10:09'),
(1911, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:10:09'),
(1912, 2, 'Add', 'transaksi/pembelian', '5', '2016-12-20', '20:10:20'),
(1913, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:10:20'),
(1914, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:11:48'),
(1915, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:12:08'),
(1916, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:12:13'),
(1917, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:13:04'),
(1918, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:13:37'),
(1919, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:13:52'),
(1920, 2, 'Remove', 'transaksi/pembelian', '5', '2016-12-20', '20:14:00'),
(1921, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:14:00'),
(1922, 2, 'Remove', 'transaksi/pembelian', '4', '2016-12-20', '20:14:04'),
(1923, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:14:04'),
(1924, 2, 'Remove', 'transaksi/pembelian', '3', '2016-12-20', '20:14:11'),
(1925, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:14:11'),
(1926, 2, 'Add', 'transaksi/pembelian', '6', '2016-12-20', '20:14:25'),
(1927, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:14:25'),
(1928, 2, 'Add', 'transaksi/pembelian', '7', '2016-12-20', '20:14:35'),
(1929, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:14:35'),
(1930, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:15:27'),
(1931, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:18:06'),
(1932, 2, 'Add', 'transaksi/pembelian', '8', '2016-12-20', '20:18:18'),
(1933, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:18:18'),
(1934, 2, 'Add', 'transaksi/pembelian', '9', '2016-12-20', '20:18:25'),
(1935, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:18:25'),
(1936, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:19:00'),
(1937, 2, 'Remove', 'transaksi/pembelian', '7', '2016-12-20', '20:19:06'),
(1938, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:19:06'),
(1939, 2, 'Remove', 'transaksi/pembelian', '6', '2016-12-20', '20:19:11'),
(1940, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:19:11'),
(1941, 2, 'Remove', 'transaksi/pembelian', '9', '2016-12-20', '20:19:14'),
(1942, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:19:14'),
(1943, 2, 'Remove', 'transaksi/pembelian', '8', '2016-12-20', '20:19:18'),
(1944, 2, 'Show', 'transaksi/pembelian', '', '2016-12-20', '20:19:18'),
(1945, 2, 'Show', 'transaksi/pembelian', '', '2016-12-21', '08:35:47'),
(1946, 2, 'Show', 'setting/menu', '', '2016-12-21', '08:36:11'),
(1947, 2, 'Add', 'setting/menu', '47', '2016-12-21', '08:37:58'),
(1948, 2, 'Show', 'setting/menu', '', '2016-12-21', '08:37:58'),
(1949, 2, 'Show', 'setting/menu', '', '2016-12-21', '08:38:18'),
(1950, 2, 'Show', 'setting/grup_akses', '', '2016-12-21', '08:38:21'),
(1951, 2, 'Update', 'setting/grup_akses', '234', '2016-12-21', '08:38:27'),
(1952, 2, 'Show', 'setting/grup_akses', '', '2016-12-21', '08:38:27'),
(1953, 2, 'Show', 'transaksi/pembelian', '', '2016-12-21', '08:38:35'),
(1954, 2, 'Show', 'transaksi/pembelian', '', '2016-12-21', '09:00:58'),
(1955, 2, 'Add', 'transaksi/pembelian', '1', '2016-12-21', '09:01:43'),
(1956, 2, 'Show', 'transaksi/pembelian', '', '2016-12-21', '09:01:43'),
(1957, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-21', '09:01:52'),
(1958, 2, 'Show', 'transaksi/pembelian', '', '2016-12-21', '09:02:40'),
(1959, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:02:46'),
(1960, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:02:50'),
(1961, 2, 'Update', 'setting/menu', '47', '2016-12-21', '09:02:56'),
(1962, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:02:56'),
(1963, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:04:17'),
(1964, 2, 'Show', 'transaksi/pembelian', '', '2016-12-21', '09:04:21'),
(1965, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-21', '09:04:25'),
(1966, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:04:59'),
(1967, 2, 'Add', 'setting/menu', '48', '2016-12-21', '09:05:18'),
(1968, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:05:18'),
(1969, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:05:20'),
(1970, 2, 'Show', 'setting/grup_akses', '', '2016-12-21', '09:05:23'),
(1971, 2, 'Update', 'setting/grup_akses', '235', '2016-12-21', '09:05:29'),
(1972, 2, 'Show', 'setting/grup_akses', '', '2016-12-21', '09:05:29'),
(1973, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:05:32'),
(1974, 2, 'Show', 'transaksi/pembelian', '', '2016-12-21', '09:09:02'),
(1975, 2, 'Show', 'setting/brand', '', '2016-12-21', '09:54:43'),
(1976, 2, 'Show', 'setting/produk', '', '2016-12-21', '09:54:44'),
(1977, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:56:13'),
(1978, 2, 'Add', 'setting/menu', '49', '2016-12-21', '09:59:08'),
(1979, 2, 'Show', 'setting/menu', '', '2016-12-21', '09:59:08'),
(1980, 2, 'Show', 'setting/grup_akses', '', '2016-12-21', '09:59:13'),
(1981, 2, 'Update', 'setting/grup_akses', '236', '2016-12-21', '09:59:20'),
(1982, 2, 'Show', 'setting/grup_akses', '', '2016-12-21', '09:59:20'),
(1983, 2, 'Add', 'setting/menu', '50', '2016-12-21', '10:00:01'),
(1984, 2, 'Show', 'setting/menu', '', '2016-12-21', '10:00:02'),
(1985, 2, 'Show', 'setting/menu', '', '2016-12-21', '10:00:05'),
(1986, 2, 'Show', 'setting/grup_akses', '', '2016-12-21', '10:00:08'),
(1987, 2, 'Update', 'setting/grup_akses', '237', '2016-12-21', '10:00:16'),
(1988, 2, 'Show', 'setting/grup_akses', '', '2016-12-21', '10:00:16'),
(1989, 2, 'Show', 'laporan/stocks', '', '2016-12-21', '10:51:43'),
(1990, 2, 'Show', 'setting/user', '', '2016-12-21', '16:20:38'),
(1991, 2, 'Show', 'setting/user', '', '2016-12-21', '16:23:52'),
(1992, 2, 'Show', 'setting/user', '', '2016-12-21', '16:26:23'),
(1993, 2, 'Show', 'setting/user', '', '2016-12-21', '16:26:48'),
(1994, 2, 'Show', 'setting/user', '', '2016-12-21', '21:46:36'),
(1995, 2, 'Change Password', 'setting/change_password', '2', '2016-12-21', '21:50:37'),
(1996, 2, 'Show', 'setting/user', '', '2016-12-21', '21:54:47'),
(1997, 2, 'Set Password', 'setting/user', '2', '2016-12-21', '21:55:04'),
(1998, 2, 'Show', 'transaksi/pembelian', '', '2016-12-21', '21:57:07'),
(1999, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-21', '21:57:11'),
(2000, 2, 'Show', 'transaksi/pembelian', '', '2016-12-22', '05:52:26'),
(2001, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-22', '05:52:40'),
(2002, 2, 'Show', 'transaksi/pembelian', '', '2016-12-22', '05:54:16'),
(2003, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-22', '05:54:19'),
(2004, 2, 'Add', 'transaksi/detil_pembelian', '3', '2016-12-22', '05:54:45'),
(2005, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-22', '05:54:45'),
(2006, 2, 'Show', 'setting/produk', '', '2016-12-22', '05:55:01'),
(2007, 2, 'Show', 'transaksi/pembelian', '', '2016-12-22', '05:55:20'),
(2008, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-22', '05:55:37'),
(2009, 2, 'Show', 'transaksi/pembelian', '', '2016-12-22', '05:57:28'),
(2010, 2, 'Show', 'laporan/stocks', '', '2016-12-22', '05:57:43'),
(2011, 2, 'Show', 'laporan/stocks', '', '2016-12-22', '05:58:33'),
(2012, 2, 'Show', 'laporan/stocks', '', '2016-12-22', '06:00:17'),
(2013, 2, 'Show', 'laporan/stocks', '', '2016-12-22', '06:02:12'),
(2014, 2, 'Show', 'setting/menu', '', '2016-12-22', '06:07:16'),
(2015, 2, 'Add', 'setting/menu', '51', '2016-12-22', '06:07:54'),
(2016, 2, 'Show', 'setting/menu', '', '2016-12-22', '06:07:54'),
(2017, 2, 'Show', 'setting/menu', '', '2016-12-22', '06:08:00'),
(2018, 2, 'Update', 'setting/menu', '50', '2016-12-22', '06:08:10'),
(2019, 2, 'Show', 'setting/menu', '', '2016-12-22', '06:08:10'),
(2020, 2, 'Show', 'setting/grup_akses', '', '2016-12-22', '06:08:14'),
(2021, 2, 'Update', 'setting/grup_akses', '238', '2016-12-22', '06:08:23'),
(2022, 2, 'Show', 'setting/grup_akses', '', '2016-12-22', '06:08:23'),
(2023, 2, 'Show', 'setting/grup_user', '', '2016-12-22', '06:08:26'),
(2024, 2, 'Show', 'setting/grup_akses', '', '2016-12-22', '06:08:29'),
(2025, 2, 'Show', 'laporan/stocks_mutasi', '', '2016-12-22', '06:08:42'),
(2026, 2, 'Show', 'laporan/stocks', '', '2016-12-22', '06:09:18'),
(2027, 2, 'Show', 'laporan/stocks_mutasi', '', '2016-12-22', '06:09:19'),
(2028, 2, 'Show', 'laporan/stocks', '', '2016-12-22', '06:09:45'),
(2029, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '14:47:48'),
(2030, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '14:49:14'),
(2031, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '14:49:21'),
(2032, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-25', '14:49:41'),
(2033, 2, 'Add', 'transaksi/pembelian', '2', '2016-12-25', '14:50:10'),
(2034, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '14:50:10'),
(2035, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-25', '14:50:14'),
(2036, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '14:53:26'),
(2037, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '14:56:12'),
(2038, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '15:05:54'),
(2039, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '15:17:37'),
(2040, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '15:18:23'),
(2041, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '15:18:56'),
(2042, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '15:18:58'),
(2043, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '15:21:25'),
(2044, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '15:24:41'),
(2045, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '15:25:39'),
(2046, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '15:28:30'),
(2047, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '15:50:27'),
(2048, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '15:50:55'),
(2049, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '15:51:01'),
(2050, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-25', '15:54:23'),
(2051, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:01:18'),
(2052, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:03:40'),
(2053, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:04:01'),
(2054, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-25', '16:04:03'),
(2055, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:06:39'),
(2056, 2, 'Update', 'transaksi/pembelian', '1', '2016-12-25', '16:06:51'),
(2057, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:06:51'),
(2058, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-25', '16:06:55'),
(2059, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:07:57'),
(2060, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:08:00'),
(2061, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:18:22'),
(2062, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:18:22'),
(2063, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:18:26'),
(2064, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:24:39'),
(2065, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:25:34'),
(2066, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:34:46'),
(2067, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:34:48'),
(2068, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:35:40'),
(2069, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:41:32'),
(2070, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:41:37'),
(2071, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:42:28'),
(2072, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:43:42'),
(2073, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:43:44'),
(2074, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '16:44:33'),
(2075, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:44:48'),
(2076, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:48:01'),
(2077, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:50:45'),
(2078, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:55:50'),
(2079, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '16:56:56'),
(2080, 2, 'Show', 'setting/konfigurasi', '', '2016-12-25', '17:01:06'),
(2081, 2, 'Show', 'setting/prefix', '', '2016-12-25', '17:04:28'),
(2082, 2, 'Show', 'setting/supplier', '', '2016-12-25', '17:04:29'),
(2083, 2, 'Show', 'setting/customer', '', '2016-12-25', '17:04:30'),
(2084, 2, 'Show', 'setting/produk', '', '2016-12-25', '17:04:31'),
(2085, 2, 'Show', 'setting/brand', '', '2016-12-25', '17:04:32'),
(2086, 2, 'Show', 'setting/tipe_produk', '', '2016-12-25', '17:04:33'),
(2087, 2, 'Show', 'setting/provider', '', '2016-12-25', '17:04:35'),
(2088, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '17:18:47'),
(2089, 2, 'Show', 'transaksi/update_pembelian', '', '2016-12-25', '17:19:01'),
(2090, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '17:22:53'),
(2091, 2, 'Show', 'transaksi/pembelian', '', '2016-12-25', '17:32:00'),
(2092, 2, 'Show', 'laporan/stocks', '', '2016-12-26', '08:16:06'),
(2093, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '08:16:11'),
(2094, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '08:17:02'),
(2095, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '08:21:50'),
(2096, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '18:51:34'),
(2097, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '19:03:14'),
(2098, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '19:10:53'),
(2099, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '19:12:54'),
(2100, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '19:23:38'),
(2101, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '19:23:38'),
(2102, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '19:32:17'),
(2103, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-26', '20:06:06'),
(2104, 2, 'Add', 'transaksi/detil_pembelian', '4', '2016-12-26', '20:06:37'),
(2105, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-26', '20:06:37'),
(2106, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-26', '20:09:47'),
(2107, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '20:12:35'),
(2108, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '20:13:50'),
(2109, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-26', '20:13:51'),
(2110, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-26', '20:14:46'),
(2111, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '21:04:51'),
(2112, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '21:05:55'),
(2113, 2, 'Show', 'setting/grup_user', '', '2016-12-26', '21:16:09'),
(2114, 2, 'Show', 'setting/grup_akses', '', '2016-12-26', '21:16:11'),
(2115, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '21:17:36'),
(2116, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-26', '21:18:36'),
(2117, 2, 'Add', 'transaksi/detil_pembelian', '5', '2016-12-26', '21:18:54'),
(2118, 2, 'Show', 'transaksi/detil_pembelian', '', '2016-12-26', '21:18:54'),
(2119, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '21:21:44'),
(2120, 2, 'Export', 'transaksi/pembelian', '', '2016-12-26', '21:21:52'),
(2121, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '21:29:16'),
(2122, 2, 'Show', 'transaksi/pembelian', '', '2016-12-26', '21:33:06'),
(2123, 2, 'Show', 'laporan/stocks', '', '2016-12-26', '21:33:22'),
(2124, 2, 'Show', 'transaksi/pembelian', '', '2017-01-08', '13:01:51'),
(2125, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-08', '13:01:55'),
(2126, 2, 'Show', 'transaksi/pembelian', '', '2017-01-08', '13:02:05'),
(2127, 2, 'Show', 'laporan/stocks', '', '2017-01-08', '13:02:08'),
(2128, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-08', '13:02:40'),
(2129, 2, 'Show', 'laporan/stocks', '', '2017-01-08', '13:02:42'),
(2130, 2, 'Show', 'transaksi/pembelian', '', '2017-01-08', '13:23:17'),
(2131, 2, 'Show', 'setting/prefix', '', '2017-01-09', '11:38:13'),
(2132, 2, 'Show', 'transaksi/pembelian', '', '2017-01-09', '11:38:18'),
(2133, 2, 'Show', 'transaksi/pembelian', '', '2017-01-09', '11:38:20'),
(2134, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:06:51'),
(2135, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:08:21'),
(2136, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:17:38'),
(2137, 2, 'Show', 'setting/customer', '', '2017-01-12', '23:17:39'),
(2138, 2, 'Show', 'setting/tipe_produk', '', '2017-01-12', '23:17:41'),
(2139, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:17:43'),
(2140, 2, 'Show', 'laporan/stocks', '', '2017-01-12', '23:18:20'),
(2141, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:18:23'),
(2142, 2, 'Show', 'setting/customer', '', '2017-01-12', '23:18:26'),
(2143, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:18:39'),
(2144, 2, 'Show', 'laporan/stocks', '', '2017-01-12', '23:24:13'),
(2145, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-12', '23:24:14'),
(2146, 2, 'Show', 'log/auditrail', '', '2017-01-12', '23:24:16'),
(2147, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:24:18'),
(2148, 2, 'Show', 'setting/supplier', '', '2017-01-12', '23:24:19'),
(2149, 2, 'Show', 'setting/customer', '', '2017-01-12', '23:24:21'),
(2150, 2, 'Show', 'setting/produk', '', '2017-01-12', '23:24:22'),
(2151, 2, 'Show', 'setting/tipe_produk', '', '2017-01-12', '23:24:23'),
(2152, 2, 'Show', 'setting/satuan', '', '2017-01-12', '23:24:25'),
(2153, 2, 'Show', 'setting/provider', '', '2017-01-12', '23:24:26'),
(2154, 2, 'Show', 'laporan/stocks', '', '2017-01-12', '23:24:30'),
(2155, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-12', '23:24:31'),
(2156, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:24:35'),
(2157, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:27:34'),
(2158, 2, 'Show', 'setting/tipe_produk', '', '2017-01-12', '23:27:38'),
(2159, 2, 'Show', 'setting/grup_user', '', '2017-01-12', '23:27:41'),
(2160, 2, 'Show', 'setting/produk', '', '2017-01-12', '23:28:01'),
(2161, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:28:17'),
(2162, 2, 'Show', 'setting/menu', '', '2017-01-12', '23:28:19'),
(2163, 2, 'Show', 'setting/grup_user', '', '2017-01-12', '23:28:21'),
(2164, 2, 'Show', 'setting/konfigurasi', '', '2017-01-12', '23:28:24'),
(2165, 2, 'Show', 'laporan/stocks', '', '2017-01-12', '23:28:28'),
(2166, 2, 'Show', 'log/auditrail', '', '2017-01-12', '23:30:35'),
(2167, 2, 'Show', 'setting/supplier', '', '2017-01-12', '23:30:38'),
(2168, 2, 'Show', 'setting/provider', '', '2017-01-12', '23:30:39'),
(2169, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:30:41');
INSERT INTO `sys_log` (`id`, `sys_user_id`, `log_event`, `log_object`, `log_ref_key`, `log_date`, `log_time`) VALUES
(2170, 2, 'Show', 'log/auditrail', '', '2017-01-12', '23:30:42'),
(2171, 2, 'Show', 'laporan/stocks', '', '2017-01-12', '23:30:45'),
(2172, 2, 'Show', 'setting/supplier', '', '2017-01-12', '23:30:46'),
(2173, 2, 'Show', 'setting/tipe_produk', '', '2017-01-12', '23:30:48'),
(2174, 2, 'Show', 'setting/menu', '', '2017-01-12', '23:30:49'),
(2175, 2, 'Show', 'setting/grup_user', '', '2017-01-12', '23:30:50'),
(2176, 2, 'Show', 'setting/konfigurasi', '', '2017-01-12', '23:30:51'),
(2177, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:30:53'),
(2178, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:30:55'),
(2179, 2, 'Show', 'setting/konfigurasi', '', '2017-01-12', '23:30:57'),
(2180, 2, 'Show', 'laporan/stocks', '', '2017-01-12', '23:30:59'),
(2181, 2, 'Show', 'log/auditrail', '', '2017-01-12', '23:31:01'),
(2182, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:31:04'),
(2183, 2, 'Show', 'setting/customer', '', '2017-01-12', '23:31:06'),
(2184, 2, 'Show', 'setting/menu', '', '2017-01-12', '23:31:07'),
(2185, 2, 'Show', 'setting/grup_user', '', '2017-01-12', '23:31:09'),
(2186, 2, 'Show', 'log/auditrail', '', '2017-01-12', '23:36:23'),
(2187, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:36:25'),
(2188, 2, 'Show', 'setting/supplier', '', '2017-01-12', '23:36:29'),
(2189, 2, 'Show', 'log/auditrail', '', '2017-01-12', '23:39:40'),
(2190, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:39:42'),
(2191, 2, 'Show', 'setting/customer', '', '2017-01-12', '23:39:45'),
(2192, 2, 'Show', 'laporan/stocks', '', '2017-01-12', '23:46:37'),
(2193, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:46:41'),
(2194, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-12', '23:57:17'),
(2195, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-12', '23:57:18'),
(2196, 2, 'Show', 'log/auditrail', '', '2017-01-12', '23:57:20'),
(2197, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:57:23'),
(2198, 2, 'Show', 'setting/produk', '', '2017-01-12', '23:57:25'),
(2199, 2, 'Show', 'setting/menu', '', '2017-01-12', '23:57:27'),
(2200, 2, 'Show', 'setting/grup_user', '', '2017-01-12', '23:57:29'),
(2201, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:57:33'),
(2202, 2, 'Show', 'setting/brand', '', '2017-01-12', '23:57:35'),
(2203, 2, 'Show', 'setting/customer', '', '2017-01-12', '23:57:37'),
(2204, 2, 'Show', 'setting/grup_user', '', '2017-01-12', '23:57:39'),
(2205, 2, 'Show', 'setting/konfigurasi', '', '2017-01-12', '23:57:40'),
(2206, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:57:44'),
(2207, 2, 'Show', 'transaksi/pembelian', '', '2017-01-12', '23:57:48'),
(2208, 2, 'Show', 'laporan/stocks', '', '2017-01-12', '23:57:51'),
(2209, 2, 'Show', 'log/auditrail', '', '2017-01-12', '23:57:52'),
(2210, 2, 'Show', 'setting/prefix', '', '2017-01-12', '23:57:55'),
(2211, 2, 'Show', 'setting/supplier', '', '2017-01-12', '23:57:56'),
(2212, 2, 'Show', 'setting/customer', '', '2017-01-12', '23:57:57'),
(2213, 2, 'Show', 'setting/produk', '', '2017-01-12', '23:57:58'),
(2214, 2, 'Show', 'setting/brand', '', '2017-01-12', '23:57:59'),
(2215, 2, 'Show', 'setting/tipe_produk', '', '2017-01-12', '23:57:59'),
(2216, 2, 'Show', 'setting/satuan', '', '2017-01-12', '23:58:00'),
(2217, 2, 'Show', 'setting/provider', '', '2017-01-12', '23:58:00'),
(2218, 2, 'Show', 'setting/menu', '', '2017-01-12', '23:58:01'),
(2219, 2, 'Show', 'setting/grup_user', '', '2017-01-12', '23:58:02'),
(2220, 2, 'Show', 'setting/user', '', '2017-01-12', '23:58:02'),
(2221, 2, 'Show', 'setting/konfigurasi', '', '2017-01-12', '23:58:03'),
(2222, 2, 'Show', 'setting/user', '', '2017-01-13', '00:05:45'),
(2223, 2, 'Show', 'setting/user', '', '2017-01-13', '00:06:12'),
(2224, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:06:15'),
(2225, 2, 'Show', 'setting/customer', '', '2017-01-13', '00:06:16'),
(2226, 2, 'Show', 'setting/produk', '', '2017-01-13', '00:06:17'),
(2227, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:06:18'),
(2228, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:06:18'),
(2229, 2, 'Show', 'setting/customer', '', '2017-01-13', '00:06:19'),
(2230, 2, 'Show', 'setting/produk', '', '2017-01-13', '00:06:19'),
(2231, 2, 'Show', 'setting/brand', '', '2017-01-13', '00:06:19'),
(2232, 2, 'Show', 'setting/tipe_produk', '', '2017-01-13', '00:06:20'),
(2233, 2, 'Show', 'setting/satuan', '', '2017-01-13', '00:06:20'),
(2234, 2, 'Show', 'setting/provider', '', '2017-01-13', '00:06:20'),
(2235, 2, 'Show', 'setting/menu', '', '2017-01-13', '00:06:21'),
(2236, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '00:06:21'),
(2237, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '00:06:22'),
(2238, 2, 'Show', 'setting/tipe_produk', '', '2017-01-13', '00:06:22'),
(2239, 2, 'Show', 'setting/produk', '', '2017-01-13', '00:06:23'),
(2240, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:06:24'),
(2241, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:06:24'),
(2242, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:06:24'),
(2243, 2, 'Show', 'setting/brand', '', '2017-01-13', '00:06:25'),
(2244, 2, 'Show', 'setting/tipe_produk', '', '2017-01-13', '00:06:25'),
(2245, 2, 'Show', 'setting/satuan', '', '2017-01-13', '00:06:25'),
(2246, 2, 'Show', 'setting/provider', '', '2017-01-13', '00:06:26'),
(2247, 2, 'Show', 'setting/menu', '', '2017-01-13', '00:06:26'),
(2248, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '00:06:26'),
(2249, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '00:06:27'),
(2250, 2, 'Show', 'setting/user', '', '2017-01-13', '00:06:27'),
(2251, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '00:06:28'),
(2252, 2, 'Show', 'setting/satuan', '', '2017-01-13', '00:06:28'),
(2253, 2, 'Show', 'setting/tipe_produk', '', '2017-01-13', '00:06:29'),
(2254, 2, 'Show', 'setting/produk', '', '2017-01-13', '00:06:29'),
(2255, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:06:30'),
(2256, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:06:30'),
(2257, 2, 'Show', 'laporan/stocks', '', '2017-01-13', '00:06:32'),
(2258, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-13', '00:06:32'),
(2259, 2, 'Show', 'log/auditrail', '', '2017-01-13', '00:06:33'),
(2260, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:06:36'),
(2261, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:06:36'),
(2262, 2, 'Show', 'setting/customer', '', '2017-01-13', '00:06:37'),
(2263, 2, 'Show', 'setting/produk', '', '2017-01-13', '00:06:37'),
(2264, 2, 'Show', 'setting/produk', '', '2017-01-13', '00:08:19'),
(2265, 2, 'Show', 'setting/provider', '', '2017-01-13', '00:10:01'),
(2266, 2, 'Show', 'setting/brand', '', '2017-01-13', '00:10:03'),
(2267, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '00:10:04'),
(2268, 2, 'Show', 'laporan/stocks', '', '2017-01-13', '00:10:06'),
(2269, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:13:10'),
(2270, 2, 'Add', 'transaksi/pembelian', '3', '2017-01-13', '00:13:17'),
(2271, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:13:17'),
(2272, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-13', '00:13:28'),
(2273, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-13', '00:13:32'),
(2274, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-13', '00:13:37'),
(2275, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:13:55'),
(2276, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-13', '00:13:59'),
(2277, 2, 'Show', 'setting/customer', '', '2017-01-13', '00:32:15'),
(2278, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '00:32:17'),
(2279, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:32:44'),
(2280, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:32:58'),
(2281, 2, 'Show', 'setting/tipe_produk', '', '2017-01-13', '00:35:20'),
(2282, 2, 'Show', 'setting/customer', '', '2017-01-13', '00:36:21'),
(2283, 2, 'Show', 'setting/user', '', '2017-01-13', '00:36:22'),
(2284, 2, 'Show', 'log/auditrail', '', '2017-01-13', '00:36:48'),
(2285, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:36:51'),
(2286, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '00:36:53'),
(2287, 2, 'Show', 'setting/menu', '', '2017-01-13', '00:36:54'),
(2288, 2, 'Show', 'log/auditrail', '', '2017-01-13', '00:37:43'),
(2289, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:45:29'),
(2290, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:45:34'),
(2291, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:45:35'),
(2292, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:45:37'),
(2293, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:45:58'),
(2294, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:46:06'),
(2295, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:46:18'),
(2296, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:48:14'),
(2297, 2, 'Show', 'setting/customer', '', '2017-01-13', '00:50:44'),
(2298, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:50:47'),
(2299, 2, 'Show', 'setting/tipe_produk', '', '2017-01-13', '00:50:50'),
(2300, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '00:50:53'),
(2301, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '00:50:57'),
(2302, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:51:00'),
(2303, 2, 'Show', 'log/auditrail', '', '2017-01-13', '00:51:03'),
(2304, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:52:12'),
(2305, 2, 'Show', 'setting/supplier', '', '2017-01-13', '00:52:17'),
(2306, 2, 'Show', 'setting/customer', '', '2017-01-13', '00:52:18'),
(2307, 2, 'Show', 'setting/produk', '', '2017-01-13', '00:52:19'),
(2308, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '00:52:21'),
(2309, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:52:24'),
(2310, 2, 'Show', 'log/auditrail', '', '2017-01-13', '00:52:26'),
(2311, 2, 'Show', 'setting/prefix', '', '2017-01-13', '00:52:40'),
(2312, 2, 'Show', 'setting/menu', '', '2017-01-13', '00:52:46'),
(2313, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '00:52:49'),
(2314, 2, 'Show', 'log/auditrail', '', '2017-01-13', '00:53:00'),
(2315, 2, 'Show', 'laporan/stocks', '', '2017-01-13', '01:36:13'),
(2316, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-13', '01:36:15'),
(2317, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '01:36:17'),
(2318, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '01:36:22'),
(2319, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '01:36:23'),
(2320, 2, 'Show', 'setting/customer', '', '2017-01-13', '02:24:15'),
(2321, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '02:24:17'),
(2322, 2, 'Show', 'setting/menu', '', '2017-01-13', '02:24:19'),
(2323, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '02:24:21'),
(2324, 2, 'Show', 'log/auditrail', '', '2017-01-13', '02:24:23'),
(2325, 2, 'Show', 'setting/supplier', '', '2017-01-13', '02:24:32'),
(2326, 2, 'Show', 'setting/supplier', '', '2017-01-13', '02:24:36'),
(2327, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '02:24:38'),
(2328, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '02:24:40'),
(2329, 2, 'Show', 'setting/brand', '', '2017-01-13', '02:27:06'),
(2330, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '02:27:09'),
(2331, 2, 'Show', 'setting/grup_user', '', '2017-01-13', '02:27:10'),
(2332, 2, 'Show', 'setting/provider', '', '2017-01-13', '02:27:12'),
(2333, 2, 'Show', 'setting/satuan', '', '2017-01-13', '02:27:14'),
(2334, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '02:27:16'),
(2335, 2, 'Show', 'log/auditrail', '', '2017-01-13', '02:27:19'),
(2336, 2, 'Show', 'laporan/stocks', '', '2017-01-13', '02:27:21'),
(2337, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '02:27:28'),
(2338, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '02:27:37'),
(2339, 2, 'Show', 'transaksi/pembelian', '', '2017-01-13', '02:30:16'),
(2340, 2, 'Show', 'setting/prefix', '', '2017-01-13', '02:30:21'),
(2341, 2, 'Show', 'setting/supplier', '', '2017-01-13', '02:30:34'),
(2342, 2, 'Show', 'setting/tipe_produk', '', '2017-01-13', '02:30:59'),
(2343, 2, 'Show', 'setting/provider', '', '2017-01-13', '02:31:01'),
(2344, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '02:31:04'),
(2345, 2, 'Show', 'setting/supplier', '', '2017-01-13', '02:32:37'),
(2346, 2, 'Show', 'setting/konfigurasi', '', '2017-01-13', '02:34:55'),
(2347, 2, 'Show', 'setting/produk', '', '2017-01-13', '02:35:01'),
(2348, 2, 'Show', 'setting/prefix', '', '2017-01-13', '02:35:05'),
(2349, 2, 'Show', 'setting/supplier', '', '2017-01-14', '10:51:14'),
(2350, 2, 'Show', 'setting/customer', '', '2017-01-14', '10:51:16'),
(2351, 2, 'Show', 'setting/produk', '', '2017-01-14', '10:51:17'),
(2352, 2, 'Show', 'setting/brand', '', '2017-01-14', '10:51:19'),
(2353, 2, 'Show', 'setting/tipe_produk', '', '2017-01-14', '10:51:20'),
(2354, 2, 'Show', 'setting/satuan', '', '2017-01-14', '10:51:21'),
(2355, 2, 'Show', 'setting/konfigurasi', '', '2017-01-14', '10:52:47'),
(2356, 2, 'Show', 'setting/user', '', '2017-01-14', '10:52:49'),
(2357, 2, 'Show', 'setting/grup_user', '', '2017-01-14', '10:52:50'),
(2358, 2, 'Show', 'setting/provider', '', '2017-01-14', '10:52:52'),
(2359, 2, 'Show', 'setting/brand', '', '2017-01-14', '10:52:55'),
(2360, 2, 'Show', 'setting/prefix', '', '2017-01-14', '10:52:56'),
(2361, 2, 'Show', 'setting/supplier', '', '2017-01-14', '10:52:58'),
(2362, 2, 'Show', 'setting/customer', '', '2017-01-14', '10:52:59'),
(2363, 2, 'Show', 'setting/produk', '', '2017-01-14', '10:53:00'),
(2364, 2, 'Show', 'setting/prefix', '', '2017-01-14', '16:41:48'),
(2365, 2, 'Show', 'setting/supplier', '', '2017-01-14', '16:41:50'),
(2366, 2, 'Show', 'setting/customer', '', '2017-01-14', '16:41:51'),
(2367, 2, 'Show', 'setting/produk', '', '2017-01-14', '16:41:52'),
(2368, 2, 'Show', 'setting/brand', '', '2017-01-14', '16:41:54'),
(2369, 2, 'Show', 'setting/tipe_produk', '', '2017-01-14', '16:41:55'),
(2370, 2, 'Show', 'setting/satuan', '', '2017-01-14', '16:41:56'),
(2371, 2, 'Show', 'setting/menu', '', '2017-01-14', '16:41:57'),
(2372, 2, 'Show', 'setting/grup_user', '', '2017-01-14', '16:41:58'),
(2373, 2, 'Show', 'setting/konfigurasi', '', '2017-01-14', '16:41:59'),
(2374, 2, 'Show', 'laporan/stocks', '', '2017-01-14', '17:42:12'),
(2375, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-14', '17:42:14'),
(2376, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '12:23:04'),
(2377, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '12:23:08'),
(2378, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '12:23:21'),
(2379, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '12:23:25'),
(2380, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '12:23:49'),
(2381, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '12:26:53'),
(2382, 2, 'Add', 'transaksi/pembelian', '1', '2017-01-15', '12:26:59'),
(2383, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '12:26:59'),
(2384, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '12:27:09'),
(2385, 2, 'Add', 'transaksi/detil_pembelian', '1', '2017-01-15', '12:28:11'),
(2386, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '12:28:11'),
(2387, 2, 'Add', 'transaksi/detil_pembelian', '2', '2017-01-15', '12:28:33'),
(2388, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '12:28:33'),
(2389, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '12:33:33'),
(2390, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '12:33:45'),
(2391, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '12:34:11'),
(2392, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:07:03'),
(2393, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:09:13'),
(2394, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:09:22'),
(2395, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:10:43'),
(2396, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:10:44'),
(2397, 2, 'Show', 'log/auditrail', '', '2017-01-15', '13:11:00'),
(2398, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '13:11:11'),
(2399, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:11:28'),
(2400, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '13:19:33'),
(2401, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:28:29'),
(2402, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:33:47'),
(2403, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:33:49'),
(2404, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:41:15'),
(2405, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:41:21'),
(2406, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:41:35'),
(2407, 2, 'Show', 'setting/prefix', '', '2017-01-15', '13:41:37'),
(2408, 2, 'Show', 'setting/supplier', '', '2017-01-15', '13:41:38'),
(2409, 2, 'Show', 'setting/produk', '', '2017-01-15', '13:41:41'),
(2410, 2, 'Show', 'setting/produk', '', '2017-01-15', '13:41:52'),
(2411, 2, 'Show', 'setting/produk', '', '2017-01-15', '13:42:00'),
(2412, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:43:39'),
(2413, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '13:43:44'),
(2414, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '13:43:45'),
(2415, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:01:30'),
(2416, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:02:29'),
(2417, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:02:58'),
(2418, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:03:45'),
(2419, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '14:04:37'),
(2420, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:06:40'),
(2421, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:07:17'),
(2422, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '14:08:06'),
(2423, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:22:15'),
(2424, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:23:01'),
(2425, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:23:21'),
(2426, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:23:24'),
(2427, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:23:26'),
(2428, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:23:29'),
(2429, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:25:00'),
(2430, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:25:25'),
(2431, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:25:47'),
(2432, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:31:48'),
(2433, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '14:42:15'),
(2434, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:42:51'),
(2435, 2, 'Show', 'setting/konfigurasi', '', '2017-01-15', '14:48:04'),
(2436, 2, 'Show', 'setting/konfigurasi', '', '2017-01-15', '14:48:10'),
(2437, 2, 'Add', 'setting/konfigurasi', '8', '2017-01-15', '14:49:01'),
(2438, 2, 'Show', 'setting/konfigurasi', '', '2017-01-15', '14:49:01'),
(2439, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '14:59:35'),
(2440, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:09:10'),
(2441, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:11:40'),
(2442, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '15:11:41'),
(2443, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:11:43'),
(2444, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '15:11:44'),
(2445, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:11:49'),
(2446, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '15:11:53'),
(2447, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:11:54'),
(2448, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '15:11:55'),
(2449, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:11:56'),
(2450, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '15:11:57'),
(2451, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:11:58'),
(2452, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '15:11:59'),
(2453, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:12:31'),
(2454, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:18:12'),
(2455, 2, 'Show', 'log/auditrail', '', '2017-01-15', '15:35:52'),
(2456, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '15:41:32'),
(2457, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:41:34'),
(2458, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '15:41:36'),
(2459, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:42:57'),
(2460, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:43:55'),
(2461, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:44:48'),
(2462, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '15:45:28'),
(2463, 2, 'Add', 'transaksi/detil_pembelian', '1', '2017-01-15', '15:46:23'),
(2464, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '15:46:23'),
(2465, 2, 'Add', 'transaksi/detil_pembelian', '2', '2017-01-15', '15:46:39'),
(2466, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '15:46:39'),
(2467, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:46:59'),
(2468, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:46:59'),
(2469, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:47:35'),
(2470, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:48:17'),
(2471, 2, 'Add Stock', 'transaksi/update_pembelian', '1', '2017-01-15', '15:48:17'),
(2472, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '1', '2017-01-15', '15:48:17'),
(2473, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:48:17'),
(2474, 2, 'Add Stock', 'transaksi/update_pembelian', '2', '2017-01-15', '15:48:18'),
(2475, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '2', '2017-01-15', '15:48:18'),
(2476, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '15:48:20'),
(2477, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:48:38'),
(2478, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '15:48:40'),
(2479, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:48:41'),
(2480, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '15:50:17'),
(2481, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:50:29'),
(2482, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '3', '2017-01-15', '15:50:29'),
(2483, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:50:33'),
(2484, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '15:50:38'),
(2485, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:54:17'),
(2486, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '4', '2017-01-15', '15:54:17'),
(2487, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:54:17'),
(2488, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '5', '2017-01-15', '15:54:18'),
(2489, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '15:54:21'),
(2490, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:54:25'),
(2491, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:57:15'),
(2492, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '6', '2017-01-15', '15:57:15'),
(2493, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '15:57:16'),
(2494, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '7', '2017-01-15', '15:57:16'),
(2495, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '15:57:23'),
(2496, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:57:26'),
(2497, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:58:26'),
(2498, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:58:35'),
(2499, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '15:59:38'),
(2500, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:00:02'),
(2501, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:00:36'),
(2502, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:00:50'),
(2503, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:02:02'),
(2504, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:02:31'),
(2505, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:02:36'),
(2506, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:03:16'),
(2507, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:03:48'),
(2508, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:03:49'),
(2509, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:03:50'),
(2510, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:03:51'),
(2511, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:03:53'),
(2512, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:03:55'),
(2513, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:03:57'),
(2514, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:03:58'),
(2515, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:04:00'),
(2516, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:04:00'),
(2517, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:04:02'),
(2518, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:04:27'),
(2519, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:04:57'),
(2520, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:04:58'),
(2521, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:04:59'),
(2522, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:05:03'),
(2523, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:05:04'),
(2524, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:05:41'),
(2525, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:05:44'),
(2526, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:07:58'),
(2527, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:08:43'),
(2528, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:08:50'),
(2529, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:08:53'),
(2530, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:08:56'),
(2531, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:09:03'),
(2532, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '16:10:05'),
(2533, 2, 'Add Stock', 'transaksi/update_pembelian', '1', '2017-01-15', '16:10:05'),
(2534, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '1', '2017-01-15', '16:10:05'),
(2535, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '16:10:05'),
(2536, 2, 'Add Stock', 'transaksi/update_pembelian', '2', '2017-01-15', '16:10:05'),
(2537, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '2', '2017-01-15', '16:10:06'),
(2538, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:10:06'),
(2539, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:10:10'),
(2540, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:10:14'),
(2541, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:13:17'),
(2542, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:14:57'),
(2543, 2, 'Update', 'transaksi/pembelian', '1', '2017-01-15', '16:15:51'),
(2544, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:15:51'),
(2545, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:16:35'),
(2546, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:17:01'),
(2547, 2, 'Update PO', 'transaksi/update_pembelian', '1', '2017-01-15', '16:17:05'),
(2548, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:17:05'),
(2549, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:17:10'),
(2550, 2, 'Update PO', 'transaksi/update_pembelian', '1', '2017-01-15', '16:17:19'),
(2551, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:17:19'),
(2552, 2, 'Add', 'transaksi/pembelian', '2', '2017-01-15', '16:18:12'),
(2553, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:18:13'),
(2554, 2, 'Update PO', 'transaksi/update_pembelian', '1', '2017-01-15', '16:18:21'),
(2555, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:18:22'),
(2556, 2, 'Update PO', 'transaksi/update_pembelian', '1', '2017-01-15', '16:18:28'),
(2557, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:18:28'),
(2558, 2, 'Update PO', 'transaksi/update_pembelian', '1', '2017-01-15', '16:18:41'),
(2559, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:19:22'),
(2560, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '16:19:25'),
(2561, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:19:35'),
(2562, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:23:24'),
(2563, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:23:37'),
(2564, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:23:38'),
(2565, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:23:40'),
(2566, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:23:43'),
(2567, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:23:54'),
(2568, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:24:05'),
(2569, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:24:25'),
(2570, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:24:26'),
(2571, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:24:27'),
(2572, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:24:44'),
(2573, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:24:55'),
(2574, 2, 'Show', 'transaksi/retur', '', '2017-01-15', '16:24:56'),
(2575, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:26:01'),
(2576, 2, 'Show', 'setting/menu', '', '2017-01-15', '16:26:32'),
(2577, 2, 'Show', 'setting/menu', '', '2017-01-15', '16:26:34'),
(2578, 2, 'Update', 'setting/menu', '47', '2017-01-15', '16:26:45'),
(2579, 2, 'Show', 'setting/menu', '', '2017-01-15', '16:26:45'),
(2580, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:27:27'),
(2581, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:29:37'),
(2582, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:30:09'),
(2583, 2, 'Update', 'transaksi/pembelian', '1', '2017-01-15', '16:30:44'),
(2584, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:30:44'),
(2585, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:31:30'),
(2586, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:32:24'),
(2587, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:32:44'),
(2588, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:41:30'),
(2589, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:42:22'),
(2590, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:45:04'),
(2591, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:45:41'),
(2592, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:47:42'),
(2593, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '16:48:45'),
(2594, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '16:48:47'),
(2595, 2, 'Update', 'transaksi/pembelian', '1', '2017-01-15', '16:48:59'),
(2596, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:48:59'),
(2597, 2, 'Update', 'transaksi/pembelian', '1', '2017-01-15', '16:49:21'),
(2598, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:49:21'),
(2599, 2, 'Update', 'transaksi/pembelian', '1', '2017-01-15', '16:49:35'),
(2600, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:49:35'),
(2601, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:50:30'),
(2602, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:51:34'),
(2603, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:51:58'),
(2604, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:52:34'),
(2605, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:52:47'),
(2606, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:53:36'),
(2607, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:54:12'),
(2608, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:54:26'),
(2609, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:54:46'),
(2610, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:55:30'),
(2611, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:55:41'),
(2612, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:55:47'),
(2613, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:56:04'),
(2614, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:56:20'),
(2615, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:56:30'),
(2616, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:56:39'),
(2617, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:56:51'),
(2618, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:57:13'),
(2619, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:57:35'),
(2620, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '16:59:41'),
(2621, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '17:00:24'),
(2622, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:03:55'),
(2623, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:04:35'),
(2624, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '17:04:37'),
(2625, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:04:38'),
(2626, 2, 'Show', 'setting/konfigurasi', '', '2017-01-15', '17:05:40'),
(2627, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:06:22'),
(2628, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '17:06:31'),
(2629, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '17:06:37'),
(2630, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '17:06:41'),
(2631, 2, 'Add', 'transaksi/detil_pembelian', '3', '2017-01-15', '17:07:07'),
(2632, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '17:07:07'),
(2633, 2, 'Add', 'transaksi/detil_pembelian', '4', '2017-01-15', '17:07:28'),
(2634, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-01-15', '17:07:28'),
(2635, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '17:07:48'),
(2636, 2, 'Add Stock', 'transaksi/update_pembelian', '3', '2017-01-15', '17:07:48'),
(2637, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '3', '2017-01-15', '17:07:48'),
(2638, 2, 'Update PO Detail', 'transaksi/update_pembelian', '1', '2017-01-15', '17:07:48'),
(2639, 2, 'Add Stock Mutasi', 'transaksi/update_pembelian', '4', '2017-01-15', '17:07:48'),
(2640, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '17:07:49'),
(2641, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '17:07:57'),
(2642, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:08:06'),
(2643, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:08:31'),
(2644, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:08:45'),
(2645, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:10:14'),
(2646, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '17:10:24'),
(2647, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:10:59'),
(2648, 2, 'Add', 'transaksi/retur_pembelian', '1', '2017-01-15', '17:11:38'),
(2649, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:11:38'),
(2650, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:12:53'),
(2651, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:12:55'),
(2652, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:12:59'),
(2653, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:16:11'),
(2654, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:16:34'),
(2655, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:17:11'),
(2656, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:17:22'),
(2657, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:17:33'),
(2658, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:17:46'),
(2659, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:18:01'),
(2660, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:19:22'),
(2661, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '17:19:52'),
(2662, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:20:04'),
(2663, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:20:33'),
(2664, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:20:41'),
(2665, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:20:43'),
(2666, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:21:56'),
(2667, 2, 'Add', 'transaksi/detil_retur', '1', '2017-01-15', '17:22:17'),
(2668, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:22:17'),
(2669, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:22:27'),
(2670, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:24:35'),
(2671, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:24:46'),
(2672, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:25:08'),
(2673, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:25:24'),
(2674, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:25:27'),
(2675, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:27:25'),
(2676, 2, 'Remove', 'transaksi/detil_retur', '1', '2017-01-15', '17:27:32'),
(2677, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:27:32'),
(2678, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:45:58'),
(2679, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '17:46:27'),
(2680, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:46:32'),
(2681, 2, 'Add', 'transaksi/detil_retur', '2', '2017-01-15', '17:46:49'),
(2682, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:47:54'),
(2683, 2, 'Add', 'transaksi/detil_retur', '3', '2017-01-15', '17:48:05'),
(2684, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:48:44'),
(2685, 2, 'Add', 'transaksi/detil_retur', '4', '2017-01-15', '17:48:54'),
(2686, 2, 'Add Stock Mutasi', 'transaksi/detil_retur', '5', '2017-01-15', '17:48:54'),
(2687, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:48:54'),
(2688, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '17:48:58'),
(2689, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:49:00'),
(2690, 2, 'Add Stock Mutasi', 'transaksi/detil_retur', '6', '2017-01-15', '17:49:07'),
(2691, 2, 'Remove', 'transaksi/detil_retur', '4', '2017-01-15', '17:49:07'),
(2692, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:49:07'),
(2693, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:49:10'),
(2694, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '17:52:51'),
(2695, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:52:52'),
(2696, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:53:21'),
(2697, 2, 'Add', 'transaksi/detil_retur', '5', '2017-01-15', '17:53:35'),
(2698, 2, 'Add Stock Mutasi', 'transaksi/detil_retur', '7', '2017-01-15', '17:53:35'),
(2699, 2, 'Show', 'transaksi/detil_retur', '', '2017-01-15', '17:53:35'),
(2700, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:53:40'),
(2701, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:54:00'),
(2702, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '17:54:08'),
(2703, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:54:22'),
(2704, 2, 'Show', 'laporan/stocks_mutasi', '', '2017-01-15', '17:54:32'),
(2705, 2, 'Show', 'laporan/stocks', '', '2017-01-15', '17:54:41'),
(2706, 2, 'Show', 'setting/menu', '', '2017-01-15', '17:55:24'),
(2707, 2, 'Show', 'setting/menu', '', '2017-01-15', '17:56:05'),
(2708, 2, 'Update', 'setting/menu', '49', '2017-01-15', '17:56:42'),
(2709, 2, 'Show', 'setting/menu', '', '2017-01-15', '17:56:42'),
(2710, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '17:56:51'),
(2711, 2, 'Show', 'setting/menu', '', '2017-01-15', '17:57:44'),
(2712, 2, 'Update', 'setting/menu', '50', '2017-01-15', '17:57:54'),
(2713, 2, 'Show', 'setting/menu', '', '2017-01-15', '17:57:54'),
(2714, 2, 'Update', 'setting/menu', '51', '2017-01-15', '17:58:04'),
(2715, 2, 'Show', 'setting/menu', '', '2017-01-15', '17:58:04'),
(2716, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '17:58:14'),
(2717, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '17:58:24'),
(2718, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '17:58:26'),
(2719, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '17:58:28'),
(2720, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '17:58:30'),
(2721, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '17:58:32'),
(2722, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '17:58:43'),
(2723, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '17:58:44'),
(2724, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '17:58:47'),
(2725, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '17:58:48'),
(2726, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '17:58:59'),
(2727, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '17:59:00'),
(2728, 2, 'Show', 'log/auditrail', '', '2017-01-15', '17:59:24'),
(2729, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '17:59:28'),
(2730, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '17:59:30'),
(2731, 2, 'Show', 'setting/menu', '', '2017-01-15', '18:10:01'),
(2732, 2, 'Add', 'setting/menu', '52', '2017-01-15', '18:10:41'),
(2733, 2, 'Show', 'setting/menu', '', '2017-01-15', '18:10:41'),
(2734, 2, 'Show', 'setting/menu', '', '2017-01-15', '18:10:45'),
(2735, 2, 'Show', 'setting/grup_akses', '', '2017-01-15', '18:10:48'),
(2736, 2, 'Update', 'setting/grup_akses', '239', '2017-01-15', '18:10:55'),
(2737, 2, 'Show', 'setting/grup_akses', '', '2017-01-15', '18:10:55'),
(2738, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:11:02'),
(2739, 2, 'Add', 'transaksi/pengeluaran', '1', '2017-01-15', '18:11:40'),
(2740, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:11:40'),
(2741, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '18:16:23'),
(2742, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:16:25'),
(2743, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '18:16:28'),
(2744, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '18:16:29'),
(2745, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:18:58'),
(2746, 2, 'Add', 'transaksi/pengeluaran', '2', '2017-01-15', '18:20:48'),
(2747, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:20:48'),
(2748, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:21:12'),
(2749, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:21:15'),
(2750, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:21:21'),
(2751, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '18:21:25'),
(2752, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '18:21:28'),
(2753, 2, 'Show', 'setting/prefix', '', '2017-01-15', '18:21:38'),
(2754, 2, 'Show', 'setting/prefix', '', '2017-01-15', '18:21:43'),
(2755, 2, 'Export', 'setting/prefix', '', '2017-01-15', '18:25:20'),
(2756, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '18:27:47'),
(2757, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '18:27:53'),
(2758, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '18:27:57'),
(2759, 2, 'Show', 'setting/prefix', '', '2017-01-15', '18:27:59'),
(2760, 2, 'Export', 'setting/prefix', '', '2017-01-15', '18:29:06'),
(2761, 2, 'Show', 'setting/prefix', '', '2017-01-15', '18:29:08'),
(2762, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:29:25'),
(2763, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:29:30'),
(2764, 2, 'Remove', 'transaksi/pengeluaran', '1', '2017-01-15', '18:29:34'),
(2765, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:29:35'),
(2766, 2, 'Add', 'transaksi/pengeluaran', '3', '2017-01-15', '18:29:46'),
(2767, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '18:29:46'),
(2768, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '20:42:33'),
(2769, 2, 'Show', 'setting/menu', '', '2017-01-15', '20:45:11'),
(2770, 2, 'Show', 'setting/menu', '', '2017-01-15', '20:45:22'),
(2771, 2, 'Add', 'setting/menu', '53', '2017-01-15', '20:45:55'),
(2772, 2, 'Show', 'setting/menu', '', '2017-01-15', '20:45:55'),
(2773, 2, 'Show', 'setting/grup_akses', '', '2017-01-15', '20:46:00'),
(2774, 2, 'Update', 'setting/grup_akses', '240', '2017-01-15', '20:46:06'),
(2775, 2, 'Show', 'setting/grup_akses', '', '2017-01-15', '20:46:06'),
(2776, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-15', '20:51:01'),
(2777, 2, 'Add', 'transaksi/pendapatan_lain', '1', '2017-01-15', '20:52:11'),
(2778, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-15', '20:52:11'),
(2779, 2, 'Update', 'transaksi/pendapatan_lain', '1', '2017-01-15', '20:52:18'),
(2780, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-15', '20:52:18'),
(2781, 2, 'Remove', 'transaksi/pendapatan_lain', '1', '2017-01-15', '20:52:21'),
(2782, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-15', '20:52:21'),
(2783, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '20:53:25'),
(2784, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '20:53:26'),
(2785, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-15', '20:53:27'),
(2786, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '20:53:28'),
(2787, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '20:53:32'),
(2788, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '20:53:33'),
(2789, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '21:04:49'),
(2790, 2, 'Show', 'setting/prefix', '', '2017-01-15', '21:04:51'),
(2791, 2, 'Show', 'setting/supplier', '', '2017-01-15', '21:04:52'),
(2792, 2, 'Show', 'setting/customer', '', '2017-01-15', '21:04:53'),
(2793, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '21:04:55'),
(2794, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '21:05:10'),
(2795, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '21:05:12'),
(2796, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '21:05:19'),
(2797, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '21:05:21'),
(2798, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '21:05:22'),
(2799, 2, 'Show', 'log/auditrail', '', '2017-01-15', '21:05:23'),
(2800, 2, 'Show', 'setting/prefix', '', '2017-01-15', '21:05:43'),
(2801, 2, 'Show', 'transaksi/pembelian', '', '2017-01-15', '21:05:46'),
(2802, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '21:05:47'),
(2803, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-15', '21:05:48'),
(2804, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-15', '21:05:49'),
(2805, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-15', '21:05:50'),
(2806, 2, 'Show', 'persediaan/stocks', '', '2017-01-15', '21:05:52'),
(2807, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-15', '21:05:53'),
(2808, 2, 'Show', 'persediaan/stocks', '', '2017-01-28', '12:47:39'),
(2809, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-28', '12:47:41'),
(2810, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '12:47:44'),
(2811, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-28', '12:47:46'),
(2812, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-28', '12:47:54'),
(2813, 2, 'Show', 'persediaan/stocks', '', '2017-01-28', '12:47:55'),
(2814, 2, 'Show', 'persediaan/stocks', '', '2017-01-28', '12:49:42'),
(2815, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-28', '12:49:43'),
(2816, 2, 'Show', 'setting/customer', '', '2017-01-28', '12:55:37'),
(2817, 2, 'Show', 'setting/user', '', '2017-01-28', '12:55:58'),
(2818, 2, 'Show', 'setting/user', '', '2017-01-28', '12:57:10'),
(2819, 2, 'Show', 'setting/user', '', '2017-01-28', '12:57:45'),
(2820, 2, 'Show', 'setting/grup_user', '', '2017-01-28', '12:58:07'),
(2821, 2, 'Add', 'setting/grup_user', '3', '2017-01-28', '12:58:21'),
(2822, 2, 'Show', 'setting/grup_user', '', '2017-01-28', '12:58:21'),
(2823, 2, 'Show', 'setting/grup_akses', '', '2017-01-28', '12:58:24'),
(2824, 2, 'Show', 'setting/grup_akses', '', '2017-01-28', '12:58:44'),
(2825, 2, 'Show', 'setting/grup_akses', '', '2017-01-28', '12:58:50'),
(2826, 2, 'Update', 'setting/grup_akses', '244', '2017-01-28', '12:58:58'),
(2827, 2, 'Show', 'setting/grup_akses', '', '2017-01-28', '12:58:58'),
(2828, 2, 'Show', 'setting/grup_akses', '', '2017-01-28', '12:59:02'),
(2829, 2, 'Show', 'setting/user', '', '2017-01-28', '12:59:17'),
(2830, 2, 'Add', 'setting/user', '3', '2017-01-28', '12:59:35'),
(2831, 2, 'Show', 'setting/user', '', '2017-01-28', '12:59:35'),
(2832, 2, 'Show', 'setting/customer', '', '2017-01-28', '13:01:01'),
(2833, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-28', '13:01:07'),
(2834, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-28', '13:01:09'),
(2835, 2, 'Show', 'persediaan/stocks', '', '2017-01-28', '13:01:20'),
(2836, 2, 'Show', 'setting/prefix', '', '2017-01-28', '13:04:15'),
(2837, 2, 'Show', 'setting/customer', '', '2017-01-28', '13:04:17'),
(2838, 2, 'Show', 'setting/tipe_produk', '', '2017-01-28', '13:04:21'),
(2839, 2, 'Show', 'setting/provider', '', '2017-01-28', '13:04:27'),
(2840, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-28', '13:05:04'),
(2841, 2, 'Show', 'persediaan/stocks', '', '2017-01-28', '13:05:05'),
(2842, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-28', '13:05:07'),
(2843, 2, 'Show', 'persediaan/stocks', '', '2017-01-28', '13:05:08'),
(2844, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-28', '13:05:09'),
(2845, 2, 'Show', 'log/auditrail', '', '2017-01-28', '13:05:10'),
(2846, 2, 'Show', 'persediaan/stocks', '', '2017-01-28', '13:05:12'),
(2847, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-28', '13:05:13'),
(2848, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '13:37:56'),
(2849, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-28', '13:46:53'),
(2850, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '13:46:54'),
(2851, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '13:51:43'),
(2852, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '13:56:43'),
(2853, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '13:57:08'),
(2854, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '13:57:17'),
(2855, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '13:58:56'),
(2856, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '13:59:11'),
(2857, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:03:44'),
(2858, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:04:14'),
(2859, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:04:28'),
(2860, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:10:36'),
(2861, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:12:21'),
(2862, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:13:27'),
(2863, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:20:51'),
(2864, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:23:37'),
(2865, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:31:12'),
(2866, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:32:58'),
(2867, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:34:09'),
(2868, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:35:03'),
(2869, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:35:15'),
(2870, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:35:37'),
(2871, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:41:17'),
(2872, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:42:33'),
(2873, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:45:40'),
(2874, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:46:12'),
(2875, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:46:46'),
(2876, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:47:10'),
(2877, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:48:31');
INSERT INTO `sys_log` (`id`, `sys_user_id`, `log_event`, `log_object`, `log_ref_key`, `log_date`, `log_time`) VALUES
(2878, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:50:22'),
(2879, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:51:34'),
(2880, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:51:58'),
(2881, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:53:09'),
(2882, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:53:11'),
(2883, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '14:59:58'),
(2884, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:00:58'),
(2885, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:01:12'),
(2886, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-28', '15:09:22'),
(2887, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:09:23'),
(2888, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-28', '15:09:25'),
(2889, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-28', '15:09:26'),
(2890, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-28', '15:09:27'),
(2891, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:09:27'),
(2892, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:18:46'),
(2893, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-28', '15:34:53'),
(2894, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:34:56'),
(2895, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:37:07'),
(2896, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:37:44'),
(2897, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:43:56'),
(2898, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:44:55'),
(2899, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:45:46'),
(2900, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:48:10'),
(2901, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '15:55:48'),
(2902, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:00:35'),
(2903, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:02:22'),
(2904, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:02:52'),
(2905, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:03:13'),
(2906, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:03:34'),
(2907, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:05:38'),
(2908, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:05:53'),
(2909, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:06:16'),
(2910, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:06:25'),
(2911, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:06:43'),
(2912, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:06:53'),
(2913, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:07:22'),
(2914, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:09:03'),
(2915, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:11:26'),
(2916, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:11:42'),
(2917, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:11:48'),
(2918, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:13:31'),
(2919, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:13:39'),
(2920, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:13:49'),
(2921, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:19:58'),
(2922, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:20:39'),
(2923, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:24:30'),
(2924, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:27:26'),
(2925, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:28:25'),
(2926, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:39:08'),
(2927, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:39:21'),
(2928, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:39:44'),
(2929, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:39:53'),
(2930, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:41:30'),
(2931, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:41:58'),
(2932, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:42:00'),
(2933, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:42:15'),
(2934, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:43:08'),
(2935, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:43:18'),
(2936, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:46:18'),
(2937, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:46:34'),
(2938, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:46:50'),
(2939, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:48:17'),
(2940, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:48:36'),
(2941, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:50:01'),
(2942, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:50:36'),
(2943, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:50:53'),
(2944, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:55:55'),
(2945, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:55:56'),
(2946, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:56:56'),
(2947, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '16:58:34'),
(2948, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:00:28'),
(2949, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:00:30'),
(2950, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:01:43'),
(2951, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:01:43'),
(2952, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:06:09'),
(2953, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:06:10'),
(2954, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:06:47'),
(2955, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:06:47'),
(2956, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:07:05'),
(2957, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:14:04'),
(2958, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:14:05'),
(2959, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:14:08'),
(2960, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:17:50'),
(2961, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:20:24'),
(2962, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:37:48'),
(2963, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:39:46'),
(2964, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:40:04'),
(2965, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:45:20'),
(2966, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:45:59'),
(2967, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:46:01'),
(2968, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:46:44'),
(2969, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:49:05'),
(2970, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:49:48'),
(2971, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:49:51'),
(2972, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:50:25'),
(2973, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:53:02'),
(2974, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:53:13'),
(2975, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:53:23'),
(2976, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:53:48'),
(2977, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:53:52'),
(2978, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:54:35'),
(2979, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:55:54'),
(2980, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '17:57:39'),
(2981, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:04:22'),
(2982, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:04:39'),
(2983, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:05:59'),
(2984, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:06:16'),
(2985, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:07:28'),
(2986, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:07:39'),
(2987, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:08:17'),
(2988, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:08:51'),
(2989, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:11:18'),
(2990, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:11:45'),
(2991, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:11:55'),
(2992, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:12:43'),
(2993, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:15:24'),
(2994, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:15:37'),
(2995, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:15:59'),
(2996, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:16:40'),
(2997, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:17:17'),
(2998, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:18:36'),
(2999, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:18:45'),
(3000, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:22:34'),
(3001, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:28:52'),
(3002, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:29:39'),
(3003, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:30:18'),
(3004, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:30:47'),
(3005, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:31:17'),
(3006, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:36:14'),
(3007, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:38:21'),
(3008, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:41:54'),
(3009, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:43:45'),
(3010, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:44:24'),
(3011, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:44:35'),
(3012, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:46:40'),
(3013, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:47:13'),
(3014, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:48:23'),
(3015, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:49:22'),
(3016, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:49:56'),
(3017, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:50:23'),
(3018, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:51:05'),
(3019, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:51:09'),
(3020, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-28', '18:51:19'),
(3021, 2, 'Show', 'transaksi/pembelian', '', '2017-01-28', '18:51:27'),
(3022, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-28', '18:51:35'),
(3023, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-28', '18:53:32'),
(3024, 2, 'Show', 'setting/prefix', '', '2017-01-29', '13:17:47'),
(3025, 2, 'Show', 'setting/customer', '', '2017-01-29', '13:17:49'),
(3026, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:17:51'),
(3027, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-29', '13:17:53'),
(3028, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:17:54'),
(3029, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-29', '13:18:22'),
(3030, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-29', '13:18:24'),
(3031, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-29', '13:18:26'),
(3032, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:18:43'),
(3033, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:18:52'),
(3034, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:19:35'),
(3035, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:20:08'),
(3036, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:20:34'),
(3037, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:22:08'),
(3038, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:24:36'),
(3039, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:24:51'),
(3040, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:25:10'),
(3041, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:36:00'),
(3042, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:36:05'),
(3043, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:36:14'),
(3044, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:36:33'),
(3045, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:37:20'),
(3046, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:37:53'),
(3047, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:37:57'),
(3048, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:38:48'),
(3049, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:39:01'),
(3050, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:42:04'),
(3051, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:43:26'),
(3052, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:44:00'),
(3053, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:47:42'),
(3054, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:47:43'),
(3055, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:47:58'),
(3056, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:47:58'),
(3057, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-29', '13:48:11'),
(3058, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:48:13'),
(3059, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:48:14'),
(3060, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:50:07'),
(3061, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:50:07'),
(3062, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-29', '13:50:27'),
(3063, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:50:29'),
(3064, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:50:30'),
(3065, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-29', '13:50:40'),
(3066, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:50:47'),
(3067, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:50:48'),
(3068, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:52:20'),
(3069, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:52:21'),
(3070, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:53:26'),
(3071, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:53:26'),
(3072, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:54:59'),
(3073, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:55:00'),
(3074, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:55:25'),
(3075, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:55:25'),
(3076, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:55:49'),
(3077, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:55:50'),
(3078, 2, 'Export', 'transaksi/pembelian', '', '2017-01-29', '13:58:47'),
(3079, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:58:54'),
(3080, 2, 'Export', 'transaksi/pembelian', '', '2017-01-29', '13:58:56'),
(3081, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:59:32'),
(3082, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '13:59:32'),
(3083, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-29', '13:59:35'),
(3084, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-29', '13:59:37'),
(3085, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-29', '13:59:38'),
(3086, 2, 'Show', 'persediaan/stocks', '', '2017-01-29', '13:59:40'),
(3087, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-29', '13:59:41'),
(3088, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-01-29', '14:07:26'),
(3089, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '14:07:28'),
(3090, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '14:07:28'),
(3091, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-29', '14:07:30'),
(3092, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-29', '14:07:31'),
(3093, 2, 'Show', 'transaksi/pengeluaran', '', '2017-01-29', '14:07:32'),
(3094, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '14:07:33'),
(3095, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '14:07:34'),
(3096, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-01-29', '14:09:03'),
(3097, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-01-29', '14:09:04'),
(3098, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '14:09:05'),
(3099, 2, 'Show', 'transaksi/pembelian', '', '2017-01-29', '14:09:06'),
(3100, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '11:15:44'),
(3101, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-02-06', '11:17:22'),
(3102, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '11:17:23'),
(3103, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '11:17:32'),
(3104, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '11:17:34'),
(3105, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '11:17:35'),
(3106, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:29:52'),
(3107, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:29:54'),
(3108, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:30:04'),
(3109, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-02-06', '20:30:21'),
(3110, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:30:24'),
(3111, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:32:04'),
(3112, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:37:51'),
(3113, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:37:52'),
(3114, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:38:51'),
(3115, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:38:51'),
(3116, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:38:52'),
(3117, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:40:58'),
(3118, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:41:06'),
(3119, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:41:06'),
(3120, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:41:07'),
(3121, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:41:08'),
(3122, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:41:58'),
(3123, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:42:12'),
(3124, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:42:24'),
(3125, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:42:24'),
(3126, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:42:24'),
(3127, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:42:25'),
(3128, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:45:01'),
(3129, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:45:03'),
(3130, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:45:04'),
(3131, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:45:04'),
(3132, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:45:05'),
(3133, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:47:33'),
(3134, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:48:19'),
(3135, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:50:32'),
(3136, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:50:33'),
(3137, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:50:33'),
(3138, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:52:03'),
(3139, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:55:02'),
(3140, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:55:18'),
(3141, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '20:55:27'),
(3142, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:01:44'),
(3143, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:02:24'),
(3144, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:03:11'),
(3145, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:03:27'),
(3146, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:03:28'),
(3147, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:03:50'),
(3148, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:03:51'),
(3149, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:04:05'),
(3150, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:04:05'),
(3151, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:04:06'),
(3152, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:04:46'),
(3153, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:04:47'),
(3154, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:04:47'),
(3155, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:04:48'),
(3156, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:07:42'),
(3157, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:08:04'),
(3158, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:08:24'),
(3159, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:08:35'),
(3160, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:09:26'),
(3161, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:10:26'),
(3162, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:12:16'),
(3163, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:14:48'),
(3164, 2, 'Show', 'transaksi/pembelian', '', '2017-02-06', '21:14:49'),
(3165, 2, 'Show', 'setting/menu', '', '2017-02-07', '13:35:16'),
(3166, 2, 'Show', 'setting/menu', '', '2017-02-07', '13:35:26'),
(3167, 2, 'Show', 'setting/menu', '', '2017-02-07', '13:35:33'),
(3168, 2, 'Add', 'setting/menu', '54', '2017-02-07', '13:36:06'),
(3169, 2, 'Show', 'setting/menu', '', '2017-02-07', '13:36:06'),
(3170, 2, 'Show', 'setting/grup_akses', '', '2017-02-07', '13:36:11'),
(3171, 2, 'Update', 'setting/grup_akses', '269', '2017-02-07', '13:36:17'),
(3172, 2, 'Show', 'setting/grup_akses', '', '2017-02-07', '13:36:17'),
(3173, 2, 'Update', 'setting/grup_akses', '270', '2017-02-07', '13:36:24'),
(3174, 2, 'Show', 'setting/grup_akses', '', '2017-02-07', '13:36:24'),
(3175, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '13:39:11'),
(3176, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '13:39:12'),
(3177, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '13:44:44'),
(3178, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '13:44:44'),
(3179, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '13:45:06'),
(3180, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '13:45:06'),
(3181, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '13:46:48'),
(3182, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '13:46:49'),
(3183, 2, 'Show', 'setting/konfigurasi', '', '2017-02-07', '14:06:39'),
(3184, 2, 'Show', 'setting/konfigurasi', '', '2017-02-07', '14:07:01'),
(3185, 2, 'Add', 'setting/konfigurasi', '9', '2017-02-07', '14:07:33'),
(3186, 2, 'Show', 'setting/konfigurasi', '', '2017-02-07', '14:07:33'),
(3187, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '14:24:09'),
(3188, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '14:24:10'),
(3189, 2, 'Add', 'transaksi/penjualan', '1', '2017-02-07', '14:24:17'),
(3190, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '14:24:17'),
(3191, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '14:28:32'),
(3192, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-02-07', '14:28:42'),
(3193, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-02-07', '14:30:12'),
(3194, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '14:30:16'),
(3195, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '14:30:56'),
(3196, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-07', '14:31:05'),
(3197, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-07', '14:39:26'),
(3198, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '14:41:57'),
(3199, 2, 'Show', 'transaksi/penjualan', '', '2017-02-07', '14:42:22'),
(3200, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-07', '14:48:02'),
(3201, 2, 'Show', 'setting/prefix', '', '2017-02-11', '09:03:47'),
(3202, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '09:03:54'),
(3203, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '09:03:54'),
(3204, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '09:08:58'),
(3205, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '09:13:15'),
(3206, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-02-11', '09:38:45'),
(3207, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '09:38:49'),
(3208, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '09:38:50'),
(3209, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '09:39:03'),
(3210, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '10:01:49'),
(3211, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '10:01:49'),
(3212, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '10:01:52'),
(3213, 2, 'Show', 'persediaan/stocks', '', '2017-02-11', '10:33:16'),
(3214, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-02-11', '10:33:24'),
(3215, 2, 'Show', 'persediaan/stocks', '', '2017-02-11', '10:33:28'),
(3216, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '10:33:35'),
(3217, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '10:47:16'),
(3218, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '10:48:24'),
(3219, 2, 'Show', 'transaksi/pembelian', '', '2017-02-11', '14:10:08'),
(3220, 2, 'Show', 'transaksi/pembelian', '', '2017-02-11', '14:10:09'),
(3221, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '14:10:10'),
(3222, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '14:10:10'),
(3223, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '14:10:19'),
(3224, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '14:11:43'),
(3225, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '14:11:44'),
(3226, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '14:11:45'),
(3227, 2, 'Show', 'setting/produk', '', '2017-02-11', '14:12:40'),
(3228, 2, 'Show', 'setting/supplier', '', '2017-02-11', '14:12:45'),
(3229, 2, 'Show', 'setting/parsing', '', '2017-02-11', '14:12:48'),
(3230, 2, 'Show', 'setting/parsing', '', '2017-02-11', '14:13:04'),
(3231, 2, 'Show', 'setting/produk', '', '2017-02-11', '14:13:20'),
(3232, 2, 'Show', 'setting/tipe_produk', '', '2017-02-11', '14:14:18'),
(3233, 2, 'Show', 'setting/satuan', '', '2017-02-11', '14:14:24'),
(3234, 2, 'Show', 'setting/provider', '', '2017-02-11', '14:14:25'),
(3235, 2, 'Show', 'setting/prefix', '', '2017-02-11', '14:14:30'),
(3236, 2, 'Show', 'setting/supplier', '', '2017-02-11', '14:14:32'),
(3237, 2, 'Show', 'setting/parsing', '', '2017-02-11', '14:14:38'),
(3238, 2, 'Show', 'setting/parsing', '', '2017-02-11', '14:14:42'),
(3239, 2, 'Remove', 'setting/parsing', '8', '2017-02-11', '14:14:48'),
(3240, 2, 'Show', 'setting/parsing', '', '2017-02-11', '14:14:48'),
(3241, 2, 'Show', 'setting/produk', '', '2017-02-11', '14:15:04'),
(3242, 2, 'Show', 'setting/produk', '', '2017-02-11', '14:24:11'),
(3243, 2, 'Update', 'setting/produk', '1', '2017-02-11', '14:24:22'),
(3244, 2, 'Show', 'setting/produk', '', '2017-02-11', '14:24:22'),
(3245, 2, 'Show', 'transaksi/pendapatan_lain', '', '2017-02-11', '14:27:17'),
(3246, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '14:27:19'),
(3247, 2, 'Show', 'transaksi/penjualan', '', '2017-02-11', '14:27:20'),
(3248, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-11', '14:27:22'),
(3249, 2, 'Show', 'setting/supplier', '', '2017-02-11', '14:27:36'),
(3250, 2, 'Show', 'setting/parsing', '', '2017-02-11', '14:27:43'),
(3251, 2, 'Show', 'setting/produk', '', '2017-02-11', '14:27:52'),
(3252, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '12:01:22'),
(3253, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '12:01:23'),
(3254, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '12:01:25'),
(3255, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '12:20:52'),
(3256, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '12:20:53'),
(3257, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '12:20:54'),
(3258, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '12:32:46'),
(3259, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '12:40:33'),
(3260, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '12:52:24'),
(3261, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '12:55:04'),
(3262, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '13:02:57'),
(3263, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '13:02:59'),
(3264, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '13:33:30'),
(3265, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '13:33:30'),
(3266, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '13:33:31'),
(3267, 2, 'Add', 'transaksi/detil_penjualan', '1', '2017-02-12', '13:34:56'),
(3268, 2, 'Add Stock Mutasi', 'transaksi/detil_penjualan', '8', '2017-02-12', '13:34:56'),
(3269, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '13:34:56'),
(3270, 2, 'Add Stock Mutasi', 'transaksi/detil_penjualan', '9', '2017-02-12', '13:35:56'),
(3271, 2, 'Remove', 'transaksi/detil_penjualan', '1', '2017-02-12', '13:35:56'),
(3272, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '13:35:56'),
(3273, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-02-12', '13:39:59'),
(3274, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-02-12', '13:40:13'),
(3275, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '13:40:15'),
(3276, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '13:40:16'),
(3277, 2, 'Show', 'setting/menu', '', '2017-02-12', '13:49:14'),
(3278, 2, 'Add', 'setting/menu', '55', '2017-02-12', '13:49:56'),
(3279, 2, 'Show', 'setting/menu', '', '2017-02-12', '13:49:56'),
(3280, 2, 'Show', 'setting/menu', '', '2017-02-12', '13:50:01'),
(3281, 2, 'Show', 'setting/grup_akses', '', '2017-02-12', '13:50:05'),
(3282, 2, 'Update', 'setting/grup_akses', '271', '2017-02-12', '13:50:13'),
(3283, 2, 'Show', 'setting/grup_akses', '', '2017-02-12', '13:50:13'),
(3284, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '13:50:23'),
(3285, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:08:54'),
(3286, 2, 'Show', 'setting/konfigurasi', '', '2017-02-12', '14:10:14'),
(3287, 2, 'Show', 'setting/konfigurasi', '', '2017-02-12', '14:10:48'),
(3288, 2, 'Add', 'setting/konfigurasi', '10', '2017-02-12', '14:11:24'),
(3289, 2, 'Show', 'setting/konfigurasi', '', '2017-02-12', '14:11:24'),
(3290, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:12:05'),
(3291, 2, 'Add', 'transaksi/retur_penjualan', '1', '2017-02-12', '14:12:10'),
(3292, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:12:10'),
(3293, 2, 'Show', 'transaksi/detil_retur', '', '2017-02-12', '14:12:17'),
(3294, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:30:02'),
(3295, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:30:05'),
(3296, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:30:28'),
(3297, 2, 'Show', 'transaksi/retur_pembelian', '', '2017-02-12', '14:30:36'),
(3298, 2, 'Show', 'transaksi/detil_retur', '', '2017-02-12', '14:30:39'),
(3299, 2, 'Show', 'transaksi/pembelian', '', '2017-02-12', '14:30:48'),
(3300, 2, 'Show', 'transaksi/pembelian', '', '2017-02-12', '14:30:48'),
(3301, 2, 'Show', 'transaksi/pembelian', '', '2017-02-12', '14:31:02'),
(3302, 2, 'Show', 'transaksi/detil_pembelian', '', '2017-02-12', '14:31:07'),
(3303, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:31:19'),
(3304, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:34:58'),
(3305, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:35:01'),
(3306, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:43:14'),
(3307, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:43:53'),
(3308, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:44:09'),
(3309, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:44:44'),
(3310, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:44:56'),
(3311, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '14:45:51'),
(3312, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '14:45:52'),
(3313, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '14:45:55'),
(3314, 2, 'Add', 'transaksi/detil_penjualan', '2', '2017-02-12', '14:46:18'),
(3315, 2, 'Add Stock Mutasi', 'transaksi/detil_penjualan', '10', '2017-02-12', '14:46:18'),
(3316, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '14:46:19'),
(3317, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:48:14'),
(3318, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:48:16'),
(3319, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:48:53'),
(3320, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '14:49:04'),
(3321, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '14:49:04'),
(3322, 2, 'Show', 'transaksi/detil_penjualan', '', '2017-02-12', '14:49:07'),
(3323, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:49:28'),
(3324, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:49:30'),
(3325, 2, 'Add', 'transaksi/detil_retur_penjualan', '1', '2017-02-12', '14:49:36'),
(3326, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:49:36'),
(3327, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:53:57'),
(3328, 2, 'Add Stock Mutasi', 'transaksi/detil_retur_penjualan', '11', '2017-02-12', '14:54:02'),
(3329, 2, 'Remove', 'transaksi/detil_retur_penjualan', '1', '2017-02-12', '14:54:02'),
(3330, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:54:02'),
(3331, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:54:34'),
(3332, 2, 'Add', 'transaksi/detil_retur_penjualan', '2', '2017-02-12', '14:54:48'),
(3333, 2, 'Add Stock Mutasi', 'transaksi/detil_retur_penjualan', '12', '2017-02-12', '14:54:48'),
(3334, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:54:48'),
(3335, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:55:54'),
(3336, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:55:56'),
(3337, 2, 'Add Stock Mutasi', 'transaksi/detil_retur_penjualan', '13', '2017-02-12', '14:56:03'),
(3338, 2, 'Remove', 'transaksi/detil_retur_penjualan', '2', '2017-02-12', '14:56:03'),
(3339, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:56:03'),
(3340, 2, 'Add', 'transaksi/detil_retur_penjualan', '3', '2017-02-12', '14:56:15'),
(3341, 2, 'Add Stock Mutasi', 'transaksi/detil_retur_penjualan', '14', '2017-02-12', '14:56:16'),
(3342, 2, 'Show', 'transaksi/detil_retur_penjualan', '', '2017-02-12', '14:56:16'),
(3343, 2, 'Show', 'persediaan/stocks', '', '2017-02-12', '14:57:14'),
(3344, 2, 'Show', 'persediaan/stocks_mutasi', '', '2017-02-12', '14:57:16'),
(3345, 2, 'Show', 'persediaan/stocks', '', '2017-02-12', '14:57:26'),
(3346, 2, 'Show', 'transaksi/pembelian', '', '2017-02-12', '14:57:42'),
(3347, 2, 'Show', 'transaksi/pembelian', '', '2017-02-12', '14:57:42'),
(3348, 2, 'Show', 'transaksi/pembelian', '', '2017-02-12', '14:57:45'),
(3349, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '14:57:48'),
(3350, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '14:57:48'),
(3351, 2, 'Show', 'transaksi/retur_penjualan', '', '2017-02-12', '14:57:50'),
(3352, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '14:57:57'),
(3353, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '14:57:57'),
(3354, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:01:38'),
(3355, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:01:39'),
(3356, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:01:48'),
(3357, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:01:48'),
(3358, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:02:09'),
(3359, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:07:36'),
(3360, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:07:37'),
(3361, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:09:58'),
(3362, 2, 'Add Stock Mutasi', 'transaksi/update_penjualan', '15', '2017-02-12', '15:36:50'),
(3363, 2, 'Update Order', 'transaksi/update_penjualan', '1', '2017-02-12', '15:36:50'),
(3364, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:36:51'),
(3365, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:37:40'),
(3366, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:37:41'),
(3367, 2, 'Update Order', 'transaksi/update_penjualan', '1', '2017-02-12', '15:41:21'),
(3368, 2, 'Show', 'transaksi/penjualan', '', '2017-02-12', '15:41:21');

-- --------------------------------------------------------

--
-- Table structure for table `sys_menu`
--

CREATE TABLE `sys_menu` (
  `id` int(6) UNSIGNED NOT NULL,
  `id_induk` int(6) UNSIGNED NOT NULL DEFAULT '0',
  `menu` varchar(128) NOT NULL,
  `uri` varchar(256) DEFAULT NULL,
  `urutan` int(6) DEFAULT '0',
  `status` tinyint(4) DEFAULT '1',
  `icon` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_menu`
--

INSERT INTO `sys_menu` (`id`, `id_induk`, `menu`, `uri`, `urutan`, `status`, `icon`) VALUES
(2, 0, 'Dashboard', 'home', 1, 1, 'desktop'),
(3, 0, 'Master Data', 'setting', 1, 1, 'cogs'),
(4, 3, 'Menu', 'setting/menu', 10, 1, ''),
(5, 3, 'Grup Akses', 'setting/grup_akses', 0, 0, NULL),
(6, 3, 'Grup User', 'setting/grup_user', 11, 1, ''),
(7, 3, 'User', 'setting/user', 12, 1, ''),
(8, 3, 'Konfigurasi', 'setting/konfigurasi', 13, 1, ''),
(14, 0, 'Log User', 'log/auditrail', 10, 1, 'exchange'),
(25, 3, 'Ubah Password', 'setting/change_password', 0, 0, ''),
(35, 3, 'Produk', 'setting/produk', 3, 1, ''),
(36, 3, 'Supplier', 'setting/supplier', 1, 1, ''),
(37, 3, 'Pelanggan', 'setting/customer', 2, 1, ''),
(38, 3, 'Brand', 'setting/brand', 4, 1, ''),
(39, 3, 'Satuan', 'setting/satuan', 5, 1, ''),
(40, 3, 'Tipe Produk', 'setting/tipe_produk', 4, 1, ''),
(41, 3, 'Provider', 'setting/provider', 5, 1, ''),
(42, 3, 'Parsing', 'setting/parsing', 0, 0, ''),
(43, 3, 'Prefix', 'setting/prefix', 0, 1, ''),
(44, 0, 'Transaksi', 'transaksi', 3, 1, 'shopping-cart'),
(45, 44, 'Pembelian', 'transaksi/pembelian', 1, 1, ''),
(46, 44, 'Detil Pembelian', 'transaksi/detil_pembelian', 0, 0, ''),
(47, 44, 'Retur Pembelian', 'transaksi/retur_pembelian', 2, 1, ''),
(48, 44, 'Update Pembelian', 'transaksi/update_pembelian', 0, 0, ''),
(49, 0, 'Persediaan', 'persediaan', 4, 1, 'bar-chart'),
(50, 49, 'Barang Persedian', 'persediaan/stocks', 5, 1, ''),
(51, 49, 'Mutasi Barang Persediaan', 'persediaan/stocks_mutasi', 6, 1, ''),
(52, 44, 'Pengeluaran', 'transaksi/pengeluaran', 6, 1, ''),
(53, 44, 'Pendapatan Lain', 'transaksi/pendapatan_lain', 5, 1, ''),
(54, 44, 'Penjualan', 'transaksi/penjualan', 3, 1, ''),
(55, 44, 'Retur Penjualan', 'transaksi/retur_penjualan', 4, 1, '');

--
-- Triggers `sys_menu`
--
DELIMITER $$
CREATE TRIGGER `sys_menu_set_sys_grup_akses_trg` AFTER INSERT ON `sys_menu` FOR EACH ROW BEGIN
INSERT INTO sys_grup_akses (sys_grup_user_id, sys_menu_id, baca, tambah, ubah, hapus, cetak)
		SELECT id, NEW.id, 0, 0, 0, 0, 0 FROM sys_grup_user WHERE status=1;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sys_user`
--

CREATE TABLE `sys_user` (
  `id` int(6) UNSIGNED NOT NULL,
  `sys_grup_user_id` int(6) UNSIGNED NOT NULL,
  `username` varchar(128) NOT NULL,
  `userpassword` varchar(128) DEFAULT NULL,
  `nama` varchar(256) NOT NULL,
  `status` tinyint(4) DEFAULT '0',
  `poto` varchar(256) DEFAULT NULL,
  `is_device` tinyint(4) NOT NULL DEFAULT '0',
  `force_logout` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_user`
--

INSERT INTO `sys_user` (`id`, `sys_grup_user_id`, `username`, `userpassword`, `nama`, `status`, `poto`, `is_device`, `force_logout`) VALUES
(2, 2, 'yoog', 'bR8PvhN8gWnz0+XphjIb+CiA23rBzVUbiG4/1zmTSeAY2IKTThlEcID2Z4RpoNr2Z+zkVRzR5j5hwc78j5rq7g==', 'Yoga Mahendra', 1, './uploads/users/mario.jpg', 0, 0),
(3, 3, 'dev1', NULL, 'Device 1', 1, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tb_info`
--

CREATE TABLE `tb_info` (
  `id` int(11) NOT NULL,
  `info_name` varchar(30) NOT NULL COMMENT 'digunakan utk identifikasi info dan bs jg digunakan untuk grouping info',
  `info_desc` varchar(256) NOT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT '0=tidak aktif, 1=aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_info`
--

INSERT INTO `tb_info` (`id`, `info_name`, `info_desc`, `status`) VALUES
(1, 'PROMO', 'Dapatkan Diskon 20% - 70% untuk pembelian diatas 200rb', 1),
(2, 'PROMO', 'Beli Samsung S7 Gratis Voucher makan di MCD. Periode 01 Februari 2017 sampai 30 Maret 2017', 1),
(3, 'IKLAN', 'Telah dibuka Grand Mall di Jalan A. Yani No. 15A. Depan Dealer Yamaha', 1);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(1) NOT NULL,
  `unit_name` varchar(30) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0=not active, 1=active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_name`, `status`) VALUES
(4, 'Dos', 1),
(3, 'Pak', 1),
(2, 'Pcs', 1),
(1, 'Unit', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`name`) USING BTREE,
  ADD KEY `id` (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`);

--
-- Indexes for table `income_others`
--
ALTER TABLE `income_others`
  ADD PRIMARY KEY (`income_other_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus_parent`
--
ALTER TABLE `menus_parent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mutasi`
--
ALTER TABLE `mutasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_state`
--
ALTER TABLE `order_state`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `parsing`
--
ALTER TABLE `parsing`
  ADD PRIMARY KEY (`supplier_id`,`product_id`),
  ADD UNIQUE KEY `idx` (`id`);

--
-- Indexes for table `prefix`
--
ALTER TABLE `prefix`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`code`,`unit_id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `product_type`
--
ALTER TABLE `product_type`
  ADD PRIMARY KEY (`type_name`),
  ADD UNIQUE KEY `idx` (`id`);

--
-- Indexes for table `provider`
--
ALTER TABLE `provider`
  ADD PRIMARY KEY (`provider_name`),
  ADD UNIQUE KEY `idx` (`id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`purchase_order_id`),
  ADD KEY `no_po` (`no_po`);

--
-- Indexes for table `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  ADD PRIMARY KEY (`purchase_order_detail_id`),
  ADD KEY `purchase_orders_id` (`purchase_order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `returs`
--
ALTER TABLE `returs`
  ADD PRIMARY KEY (`retur_id`);

--
-- Indexes for table `retur_details`
--
ALTER TABLE `retur_details`
  ADD PRIMARY KEY (`retur_detail_id`),
  ADD KEY `returs_id` (`retur_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `retur_orders`
--
ALTER TABLE `retur_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `retur_order_details`
--
ALTER TABLE `retur_order_details`
  ADD PRIMARY KEY (`retur_detail_id`),
  ADD KEY `returs_id` (`retur_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`Var`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_id` (`products_id`);

--
-- Indexes for table `stocks_history`
--
ALTER TABLE `stocks_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_id` (`products_id`);

--
-- Indexes for table `stocks_mutasi`
--
ALTER TABLE `stocks_mutasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stocks_id` (`stocks_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_code`),
  ADD UNIQUE KEY `idx` (`id`);

--
-- Indexes for table `sys_config`
--
ALTER TABLE `sys_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sys_grup_akses`
--
ALTER TABLE `sys_grup_akses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_grup_user` (`sys_grup_user_id`),
  ADD KEY `id_menu` (`sys_menu_id`);

--
-- Indexes for table `sys_grup_user`
--
ALTER TABLE `sys_grup_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sys_log`
--
ALTER TABLE `sys_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sys_user_id` (`sys_user_id`);

--
-- Indexes for table `sys_menu`
--
ALTER TABLE `sys_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_induk` (`id_induk`);

--
-- Indexes for table `sys_user`
--
ALTER TABLE `sys_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_2` (`username`),
  ADD KEY `sys_grup_user_id` (`sys_grup_user_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `tb_info`
--
ALTER TABLE `tb_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_name`),
  ADD UNIQUE KEY `idx` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `income_others`
--
ALTER TABLE `income_others`
  MODIFY `income_other_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT for table `menus_parent`
--
ALTER TABLE `menus_parent`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `mutasi`
--
ALTER TABLE `mutasi`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `order_state`
--
ALTER TABLE `order_state`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `parsing`
--
ALTER TABLE `parsing`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `prefix`
--
ALTER TABLE `prefix`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `product_type`
--
ALTER TABLE `product_type`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `provider`
--
ALTER TABLE `provider`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `purchase_order_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `purchase_order_details`
--
ALTER TABLE `purchase_order_details`
  MODIFY `purchase_order_detail_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `returs`
--
ALTER TABLE `returs`
  MODIFY `retur_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `retur_details`
--
ALTER TABLE `retur_details`
  MODIFY `retur_detail_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `retur_orders`
--
ALTER TABLE `retur_orders`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `retur_order_details`
--
ALTER TABLE `retur_order_details`
  MODIFY `retur_detail_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `stocks_history`
--
ALTER TABLE `stocks_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `stocks_mutasi`
--
ALTER TABLE `stocks_mutasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sys_config`
--
ALTER TABLE `sys_config`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `sys_grup_akses`
--
ALTER TABLE `sys_grup_akses`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=274;
--
-- AUTO_INCREMENT for table `sys_grup_user`
--
ALTER TABLE `sys_grup_user`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sys_log`
--
ALTER TABLE `sys_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3369;
--
-- AUTO_INCREMENT for table `sys_menu`
--
ALTER TABLE `sys_menu`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
--
-- AUTO_INCREMENT for table `sys_user`
--
ALTER TABLE `sys_user`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tb_info`
--
ALTER TABLE `tb_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `sys_grup_akses`
--
ALTER TABLE `sys_grup_akses`
  ADD CONSTRAINT `sys_grup_akses_sys_grup_user_id_fk` FOREIGN KEY (`sys_grup_user_id`) REFERENCES `sys_grup_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `sys_grup_akses_sys_menu_id_fk` FOREIGN KEY (`sys_menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `sys_log`
--
ALTER TABLE `sys_log`
  ADD CONSTRAINT `sys_log_sys_user_id_fk` FOREIGN KEY (`sys_user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `sys_user`
--
ALTER TABLE `sys_user`
  ADD CONSTRAINT `sys_user_sys_grup_user_id_fk` FOREIGN KEY (`sys_grup_user_id`) REFERENCES `sys_grup_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
