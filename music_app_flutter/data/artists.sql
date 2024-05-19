-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 14, 2023 lúc 03:23 AM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `music_website_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `bio` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `image` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `artists`
--

INSERT INTO `artists` (`id`, `name`, `bio`, `user_id`, `image`) VALUES
(1, 'GreyD', '', 1, 'uploads/greyD_avt.jpg'),
(2, 'Sơn Tùng MTP', '', 1, 'uploads/SonTungMTP_avt.jpg'),
(3, 'Binz', '', 1, 'uploads/Binz_avt.jpg'),
(4, 'Phương Ly', '', 1, 'uploads/PhuongLy_avt.jpg'),
(5, 'Soobin Hoàng Sơn', '', 1, 'uploads/SoobinHoangSon_avt.jpg'),
(6, 'RPT MCK', '', 1, 'uploads/MCKeyy_avt.jpg'),
(7, 'Erik', '', 1, 'uploads/Erik_avt.jpg'),
(8, 'Mr Siro', '', 1, 'uploads/MrSiro_avt.jpg'),
(9, 'Phúc Du', '', 1, 'uploads/PhucDu_avt.jpg'),
(10, 'Tlinh', '', 1, 'uploads/Tlinh_avt.jpg'),
(11, 'B Ray', '', 1, 'uploads/Bray_avt.jpg'),
(12, 'Đức Phúc', '', 1, 'uploads/DucPhuc_avt.jpg'),
(13, 'Vũ', '', 1, 'uploads/Vu_avt.jpg'),
(14, 'Low G', '', 1, 'uploads/LowG_avt.jpg'),
(15, 'Charlie Puth', '', 1, 'uploads/CharliePuth_avt.jpg'),
(16, 'The Chainsmokers', '', 1, 'uploads/TheChainsmokers_avt.jpg'),
(17, 'Lauv', '', 1, 'uploads/Lauv_avt.jpg'),
(18, 'Justin Bieber', '', 1, 'uploads/JustinBieber_avt.jpg'),
(19, 'Ed Sherran', '', 1, 'uploads/EdSherran_avt.jpg');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `artists`
--
ALTER TABLE `artists`
  ADD CONSTRAINT `artists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



