-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 14, 2023 lúc 03:25 AM
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
-- Cấu trúc bảng cho bảng `songs`
--

CREATE TABLE `songs` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `artist` varchar(110) NOT NULL,
  `image` varchar(1024) NOT NULL,
  `file` varchar(1024) NOT NULL,
  `categories_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `views` int(11) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `songs`
--

INSERT INTO `songs` (`id`, `title`, `user_id`, `artist`, `image`, `file`, `categories_id`, `date`, `views`, `slug`, `featured`) VALUES
(1, 'Âm thầm bên em ', 1, 'Sơn Tùng MTP', 'assets/AmThamBenEm.jpg', 'AmThamBenEm.mp3', 1, '2022-12-01 11:03:04', 13, 'am-tham-ben-em', 0),
(2, 'Anh Là Ngoại Lệ Của Em', 1, 'Phương Ly', 'assets/AnhLaNgoaiLeCuaEm.jpg', 'AnhLaNgoaiLeCuaEm.mp3', 1, '2022-09-11 12:32:17', 241, 'anh-la-ngoai-le-cua-em', 0),
(3, 'Attention', 1, 'Charlie Puth', 'assets/Attention.png', 'Attention.mp3', 1, '2022-09-11 12:30:34', 168, 'attention', 0),
(4, 'Baby', 1, 'Justin Bieber', 'assets/Baby.mp3', 'Baby.mp3', 1, '2022-09-11 12:30:34', 335, 'baby', 0),
(5, 'Bigcityboi', 1, 'Binz', 'assets/Bigcityboi.jpg', 'Bigcityboi.mp3', 2, '2022-09-11 12:30:34', 333, 'bigcityboi', 0),
(6, 'Bước Qua Mùa Cô Đơn', 1, 'Vũ', 'assets/BuocQuaMuaCoDon.jpg', 'BuocQuaMuaCoDon.mp3', 1, '2022-09-11 12:30:34', 132, 'buoc-qua-mua-co-don', 0),
(7, 'Bước Qua Nhau', 1, 'Vũ', 'assets/BuocQuaNhau.jpg', 'BuocQuaNhau.mp3', 1, '2022-09-11 12:30:34', 114, 'buoc-qua-nhau', 0),
(8, 'Càng Cua', 1, 'LowG', 'assets/CangCua.jpg', 'CangCua.mp3', 2, '2022-09-11 12:30:34', 3233, 'cang-cua', 0),
(9, 'Chạm Đáy Nỗi Đau', 1,'Erik', 'assets/ChamDayNoiDau.jpg', 'ChamDayNoiDau.mp3', 1, '2022-09-11 12:30:34', 114, 'cham-day-noi-dau', 0),
(10, 'Chạy Về Khóc Với Anh', 1, 'Erik', 'assets/ChayVeKhocVoiAnh.jpg', 'ChayVeKhocVoiAnh.mp3', 1, '2022-09-11 12:30:34', 23, 'chay-ve-khoc-voi-anh', 0),
(11, 'Chỉ Một Đêm Nữa Thôi', 1, 'MCK', 'assets/ChiMotDemNuaThoi.jpg', 'ChiMotDemNuaThoi.mp3', 2, '2022-09-11 12:30:34', 3434, 'chi-mot-dem-nua-thoi', 0),
(12, 'Chìm Sâu', 1, 'MCK', 'assets/ChimSau.jpg', 'ChimSau.mp3', 2, '2022-09-11 12:30:34', 456, 'chim-sau', 0),
(13, 'Closer', 1, 'The Chainsmoker', 'assets/Closer.jpg', 'Closer.mp3', 3, '2022-09-11 12:30:34', 1213, 'Closer', 0),
(14, 'Đã Từng Vô Giá', 1, 'Mr Siro', 'assets/DaTungVoGia.jpg', 'DaTungVoGia.mp3', 1, '2022-09-11 12:30:34', 114, 'da-tung-vo-gia', 0),
(15, 'Day Dứt Nỗi Đau', 1, 'Mr Siro', 'assets/DayDutNoiDau.jpg', 'DayDutNoiDau.mp3', 1, '2022-09-11 12:30:34', 2323, 'day-dut-noi-dau\r\n', 0),
(16, 'Đi Để Trở Về', 1, 'Soobin Hoàng Sơn', 'assets/DiDeTroVe.jpg', 'DiDeTroVe.mp3', 1, '2022-09-11 12:30:34', 21, 'di-de-tro-ve', 0),
(17, 'Đông Kiếm Em', 1, 'Vũ', 'assets/DongKiemEm.jpg', 'DongKiemEm.mp3', 1, '2022-09-11 12:30:34', 34, 'dong-kiem-em', 0),
(18, 'Dont Let Me Down', 1, 'The Chainsmoker', 'assets/DontLetMeDown.jpg', 'DontLetMeDown.mp3', 3, '2022-09-11 12:30:34', 212, 'dont-let-me-down', 0),
(19, 'Đưa Em Về Nhàa', 1, 'GreyD', 'assets/DuaEmVeNha.jpg', 'DuaEmVeNha.mp3', 1, '2022-09-11 12:30:34', 3326, 'dua-em-ve-nha', 0),
(20, 'Dự Báo Thời Tiết Hôm Nay Mưa', 1, 'GreyD', 'assets/DuBaoThoiTietHomNayMua.jpg', 'DuBaoThoiTietHomNayMua.mp3', 1, '2022-09-11 12:30:34', 456, 'du-bao-thoi-tiet-hom-nay-mua', 0),
(21, 'Em Không Sai, Chúng Ta Sai', 1, 'Erik', 'assets/EmKhongSaiChungTaSai.jpg', 'EmKhongSaiChungTaSai.mp3', 1, '2022-09-11 12:30:34', 656, 'em-khong-sai-chung-ta-sai', 0),
(22, 'Exs Hate Me', 1, 'Bray', 'assets/ExsHateMe.jpg', 'ExsHateMe.mp3', 2, '2022-09-11 12:30:34', 555, 'exs-hate-me', 0),
(23, 'Exs Hate Me 2', 1, 'Bray', 'assets/ExsHateMe2.jpg', 'ExsHateMe2.mp3', 2, '2022-09-11 12:30:34', 232, 'exs-hate-me-2', 0),
(24, 'Gene', 1, 'Binz', 'assets/Gene.jpg', 'Gene.mp3', 2, '2022-09-11 12:30:34', 65, 'Gene', 0),
(25, 'Hãy Trao Cho Anh', 1, 'Sơn Tùng MTP', 'assets/HayTraoChoAnh.jpg', 'HayTraoChoAnh.mp3', 1, '2022-09-11 12:30:34', 114, 'hay-trao-cho-anh', 0),
(26, 'Hết Thương Cạn Nhớ', 1, 'Đức Phúc', 'assets/HetThuongCanNho.jpg', 'HetThuongCanNho.mp3', 1, '2022-09-11 12:30:34', 3434, 'het-thuong-can-nho', 0),
(27, 'Hit Me Up', 1, 'Binz', 'assets/HitMeUp.jpg', 'HitMeUp.mp3', 2, '2022-09-11 12:30:34', 65, 'hit-me-up', 0),
(28, 'Hơn Cả Yêu', 1, 'Đức Phúc', 'assets/HonCaYeu.jpg', 'HonCaYeu.mp3', 1, '2022-09-11 12:30:34', 43, 'hon-ca-yeu', 0),
(29, 'I Like Me Better', 1, 'Lauv', 'assets/ILikeMeBetter.jpg', 'ILikeMeBetter.mp3', 3, '2022-09-11 12:30:34', 115, 'i-like-me-better', 0),
(30, 'Lạ Lùng', 1, 'Vũ', 'assets/LaLung.jpg', 'LaLung.mp3', 1, '2022-09-11 12:30:34', 245, 'la-lung', 0),
(31, 'Love YourSelf', 1, 'Justin Bieber', 'assets/LoveYourself.png', 'LoveYourself.mp3', 3, '2022-09-11 12:30:34', 222, 'love-yourself', 0),
(32, 'Mặt Trời Của Em', 1, 'Phương Ly', 'assets/MatTroiCuaEm.jpg', 'MatTroiCuaEm.mp3', 1, '2022-09-11 12:30:34', 168, 'mat-troi-cua-em', 0),
(33, 'Mean It', 1, 'Lauv', 'assets/MeanIt.jpg', 'MeanIt.mp3', 3, '2022-09-11 12:30:34', 222, 'mean-it', 0),
(34, 'Missing You', 1, 'Phương Ly', 'assets/MissingYou.jpg', 'MissingYou.mp3', 1, '2022-09-11 12:30:34', 244, 'missing-you', 0),
(35, 'Một Bước Yêu, Vạn Dặm Đau', 1, 'Mr Siro', 'assets/MotBuocYeuVanDamDau.jpg', 'MotBuocYeuVanDamDau.mp3', 1, '2022-09-11 12:30:34', 222, 'mot-buoc-yeu-van-dam-dau', 0),
(36, 'Nếu Lúc Đó', 1, 'TLinh', 'assets/NeuLucDo.jpg', 'NeuLucDo.mp3', 2, '2022-09-11 12:30:34', 57, 'neu-luc-do', 0),
(37, 'Nếu Ngày Ấy', 1, 'Soobin Hoàng Sơn', 'assets/NeuNgayAy.jpg', 'NeuNgayAy.mp3', 1, '2022-09-11 12:30:34', 434, 'neu-ngay-ay', 0),
(38, 'Ngày Đầu Tiên', 1, 'Đức Phúc', 'assets/NgayDauTien.jpg', 'NgayDauTien.mp3', 1, '2022-09-11 12:30:34', 356, 'ngay-dau-tien', 0),
(39, 'OK', 1, 'Binz', 'assets/OK.jpg', 'OK.mp3', 2, '2022-09-11 12:30:34', 23, 'OK', 0),
(40, 'okeokeoke', 1, 'LowG', 'assets/okeokeoke.jpg', 'okeokeoke.mp3', 2, '2022-09-11 12:30:34', 123, 'okeokeoke', 0),
(41, 'One Call Away', 1, 'Charlie Puth', 'assets/OneCallAway.jpg', 'OneCallAway.mp3', 3, '2022-09-11 12:30:34', 34, '', 0),
(42, 'Perfect', 1, 'Ed Sherran', 'assets/Perfect.jpg', 'Perfect.mp3', 3, '2022-09-11 12:30:34', 114, 'perfect', 0),
(43, 'Phía Sau Một Cô Gái', 1, 'Soobin Hoàng Sơn', 'assets/PhiaSauMotCoGai.png', 'PhiaSauMotCoGai.mp3', 1, '2022-09-11 12:30:34', 1142, 'phia-sau-mot-co-gai', 0),
(44, 'Photograph', 1, 'Ed Sherran', 'assets/Photograph.jpg', 'Photograph.mp3', 3, '2022-09-11 12:30:34', 222, 'photograph', 0),
(45, 'Sau Tất Cả', 1, 'Erik', 'assets/SauTatCa.jpg', 'SauTatCa.mp3', 1, '2022-09-11 12:30:34', 2323, 'sau-tat-ca', 0),
(46, 'See You Again', 1, 'Charlie Puth', 'assets/SeeYouAgain.jpg', 'SeeYouAgain.mp3', 0, '2022-09-11 12:30:34', 1142, 'see-you-again', 0),
(47, 'Shape Of You', 1, 'Ed Sherran', 'assets/ShapeOfYou.jpg', 'ShapeOfYou.mp3', 0, '2022-09-11 12:30:34', 1122, 'shape-of-you', 0),
(48, 'Tại Vì Sao', 1, 'MCK', 'assets/TaiViSao.jpg', 'TaiViSao.mp3', 2, '2022-09-11 12:30:34', 434, 'tai-vi-sao', 0),
(49, 'The Playah', 1, 'Soobin Hoàng Sơn', 'assets/ThePlayah.jpg', 'ThePlayah.mp3', 1, '2022-09-11 12:30:34', 2567, 'the-playah', 0),
(50, 'Thích Quá Rùi Nà', 1, 'TLinh', 'assets/ThichQuaRuiNa.jpg', 'ThichQuaRuiNa.mp3', 2, '2022-09-11 12:30:34', 26, 'thich-qua-rui-na', 0),
(51, 'ThichThich', 1, 'Phương Ly', 'assets/ThichThich.jpg', 'ThichThich.mp3', 1, '2022-09-11 14:45:34', 117, 'thich-thich', 0),
(52, 'Thủ Đô Cypher', 1, 'MCK', 'assets/ThuDoCypher.jpg', 'ThuDoCypher.mp3', 2, '2022-09-11 12:30:34', 457, 'thu-do-cypher', 0),
(53, 'Tình Yêu Chậm Trễ', 1, 'GreyD', 'assets/TinhYeuChamTre.jpg', 'TinhYeuChamTre.mp3', 1, '2022-09-11 12:30:34', 2435, 'tinh-yeu-cham-tre', 0),
(54, 'Tự Lau Nước Mắt', 1, 'Mr Siro', 'assets/TuLauNuocMat.jpg', 'TuLauNuocMat.mp3', 1, '2022-09-11 12:30:34', 231, 'tu-lau-nuoc-mat', 0),
(55, 'Vaicaunoicokhiennguoithaydoi', 1, 'GreyD', 'assets/vaicaunoicokhiennguoithaydoi.jpg', 'VaiCauNoiCoKhienNguoiThayDoi.mp3', 1, '2022-09-11 12:30:34', 1485, 'vaicaunoicokhiennguoithaydoi', 0),
(56, 'We Dont Talk Anymore', 1, 'Charlie Puth', 'assets/WeDontTalkAnymore.png', 'WeDontTalkAnymore.mp3', 3, '2022-09-11 12:30:34', 215, 'we-dont-talk-anymore', 0),
(57, 'Xin Đừng Nhấc Máy', 1, 'Bray', 'assetss/XinDungNhacMay.jpg', 'XinDungNhacMay.mp3', 2, '2022-09-11 12:30:34', 21, 'xin-dung-nhac-may', 0),
(58, 'Yêu Anh Đi Mẹ Anh Bán Bánh Mì', 1, 'Phúc Du', 'assets/YeuAnhDiMeAnhBanBanhMi.jpg', 'YeuAnhDiMeAnhBanBanhMi.mp3', 2, '2022-09-11 12:30:34', 54, 'yeu-anh-di-me-anh-ban-banh-mi', 0);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `artist` (`artist`),
  ADD KEY `category_id` (`categories_id`),
  ADD KEY `views` (`views`),
  ADD KEY `date` (`date`),
  ADD KEY `title` (`title`),
  ADD KEY `slug` (`slug`),
  ADD KEY `featured` (`featured`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `songs`
--
ALTER TABLE `songs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `songs`
--
ALTER TABLE `songs`
  ADD CONSTRAINT `songs_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  ADD CONSTRAINT `songs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
