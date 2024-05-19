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
  `artist_id` int(11) NOT NULL,
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

INSERT INTO `songs` (`id`, `title`, `user_id`, `artist_id`, `image`, `file`, `categories_id`, `date`, `views`, `slug`, `featured`) VALUES
(1, 'Âm thầm bên em ', 1, 2, 'uploads/AmThamBenEm.jpg', 'uploads/AmThamBenEm.mp3', 1, '2022-12-01 11:03:04', 13, 'am-tham-ben-em', 0),
(2, 'Anh Là Ngoại Lệ Của Em', 1, 4, 'uploads/AnhLaNgoaiLeCuaEm.jpg', 'uploads/AnhLaNgoaiLeCuaEm.mp3', 1, '2022-09-11 12:32:17', 241, 'anh-la-ngoai-le-cua-em', 0),
(3, 'Attention', 1, 15, 'uploads/Attention.png', 'uploads/Attention.mp3', 1, '2022-09-11 12:30:34', 168, 'attention', 0),
(4, 'Baby', 1, 18, 'uploads/Baby.jpg', 'uploads/Baby.mp3', 1, '2022-09-11 12:30:34', 335, 'baby', 0),
(5, 'Bigcityboi', 1, 3, 'uploads/Bigcityboi.jpg', 'uploads/Bigcityboi.mp3', 2, '2022-09-11 12:30:34', 333, 'bigcityboi', 0),
(6, 'Bước Qua Mùa Cô Đơn', 1, 13, 'uploads/BuocQuaMuaCoDon.jpg', 'uploads/BuocQuaMuaCoDon.mp3', 1, '2022-09-11 12:30:34', 132, 'buoc-qua-mua-co-don', 0),
(7, 'Bước Qua Nhau', 1, 13, 'uploads/BuocQuaNhau.jpg', 'uploads/BuocQuaNhau.mp3', 1, '2022-09-11 12:30:34', 114, 'buoc-qua-nhau', 0),
(8, 'Càng Cua', 1, 14, 'uploads/CangCua.jpg', 'uploads/CangCua.mp3', 2, '2022-09-11 12:30:34', 3233, 'cang-cua', 0),
(9, 'Chạm Đáy Nỗi Đau', 1, 7, 'uploads/ChamDayNoiDau.jpg', 'uploads/ChamDayNoiDau.mp3', 1, '2022-09-11 12:30:34', 114, 'cham-day-noi-dau', 0),
(10, 'Chạy Về Khóc Với Anh', 1, 7, 'uploads/ChayVeKhocVoiAnh.jpg', 'uploads/ChayVeKhocVoiAnh.mp3', 1, '2022-09-11 12:30:34', 23, 'chay-ve-khoc-voi-anh', 0),
(11, 'Chỉ Một Đêm Nữa Thôi', 1, 6, 'uploads/ChiMotDemNuaThoi.jpg', 'uploads/ChiMotDemNuaThoi.mp3', 2, '2022-09-11 12:30:34', 3434, 'chi-mot-dem-nua-thoi', 0),
(13, 'Chìm Sâu', 1, 6, 'uploads/ChimSau.jpg', 'uploads/ChimSau.mp3', 2, '2022-09-11 12:30:34', 456, 'chim-sau', 0),
(14, 'Closer', 1, 16, 'uploads/Closer.jpg', 'uploads/Closer.mp3', 3, '2022-09-11 12:30:34', 1213, 'Closer', 0),
(15, 'Đã Từng Vô Giá', 1, 8, 'uploads/DaTungVoGia.jpg', 'uploads/DaTungVoGia.mp3', 1, '2022-09-11 12:30:34', 114, 'da-tung-vo-gia', 0),
(16, 'Day Dứt Nỗi Đau', 1, 8, 'uploads/DayDutNoiDau.jpg', 'uploads/DayDutNoiDau.mp3', 1, '2022-09-11 12:30:34', 2323, 'day-dut-noi-dau\r\n', 0),
(17, 'Đi Để Trở Về', 1, 5, 'uploads/DiDeTroVe.jpg', 'uploads/DiDeTroVe.mp3', 1, '2022-09-11 12:30:34', 21, 'di-de-tro-ve', 0),
(18, 'Đông Kiếm Em', 1, 13, 'uploads/DongKiemEm.jpg', 'uploads/DongKiemEm.mp3', 1, '2022-09-11 12:30:34', 34, 'dong-kiem-em', 0),
(19, 'Dont Let Me Down', 1, 16, 'uploads/DontLetMeDown.jpg', 'uploads/DontLetMeDown.mp3', 3, '2022-09-11 12:30:34', 212, 'dont-let-me-down', 0),
(20, 'Đưa Em Về Nhàa', 1, 1, 'uploads/DuaEmVeNha.jpg', 'uploads/DuaEmVeNha.mp3', 1, '2022-09-11 12:30:34', 3326, 'dua-em-ve-nha', 0),
(21, 'Dự Báo Thời Tiết Hôm Nay Mưa', 1, 1, 'uploads/DuBaoThoiTietHomNayMua.jpg', 'uploads/DuBaoThoiTietHomNayMua.mp3', 1, '2022-09-11 12:30:34', 456, 'du-bao-thoi-tiet-hom-nay-mua', 0),
(22, 'Em Không Sai, Chúng Ta Sai', 1, 7, 'uploads/EmKhongSaiChungTaSai.jpg', 'uploads/EmKhongSaiChungTaSai.mp3', 1, '2022-09-11 12:30:34', 656, 'em-khong-sai-chung-ta-sai', 0),
(23, 'Exs Hate Me', 1, 11, 'uploads/ExsHateMe.jpg', 'uploads/ExsHateMe.mp3', 2, '2022-09-11 12:30:34', 555, 'exs-hate-me', 0),
(24, 'Exs Hate Me 2', 1, 11, 'uploads/ExsHateMe2.jpg', 'uploads/ExsHateMe2.mp3', 2, '2022-09-11 12:30:34', 232, 'exs-hate-me-2', 0),
(25, 'Gene', 1, 3, 'uploads/Gene.jpg', 'uploads/Gene.mp3', 2, '2022-09-11 12:30:34', 65, 'Gene', 0),
(26, 'Hãy Trao Cho Anh', 1, 2, 'uploads/HayTraoChoAnh.jpg', 'uploads/HayTraoChoAnh.mp3', 1, '2022-09-11 12:30:34', 114, 'hay-trao-cho-anh', 0),
(27, 'Hết Thương Cạn Nhớ', 1, 12, 'uploads/HetThuongCanNho.jpg', 'uploads/HetThuongCanNho.mp3', 1, '2022-09-11 12:30:34', 3434, 'het-thuong-can-nho', 0),
(28, 'Hit Me Up', 1, 3, 'uploads/HitMeUp.jpg', 'uploads/HitMeUp.mp3', 2, '2022-09-11 12:30:34', 65, 'hit-me-up', 0),
(29, 'Hơn Cả Yêu', 1, 12, 'uploads/HonCaYeu.jpg', 'uploads/HonCaYeu.mp3', 1, '2022-09-11 12:30:34', 43, 'hon-ca-yeu', 0),
(30, 'I Like Me Better', 1, 17, 'uploads/ILikeMeBetter.jpg', 'uploads/ILikeMeBetter.mp3', 3, '2022-09-11 12:30:34', 115, 'i-like-me-better', 0),
(32, 'Lạ Lùng', 1, 13, 'uploads/LaLung.jpg', 'uploads/LaLung.mp3', 1, '2022-09-11 12:30:34', 245, 'la-lung', 0),
(33, 'Love YourSelf', 1, 18, 'uploads/LoveYourself.png', 'uploads/LoveYourself.mp3', 3, '2022-09-11 12:30:34', 222, 'love-yourself', 0),
(34, 'Mặt Trời Của Em', 1, 4, 'uploads/MatTroiCuaEm.jpg', 'uploads/MatTroiCuaEm.mp3', 1, '2022-09-11 12:30:34', 168, 'mat-troi-cua-em', 0),
(35, 'Mean It', 1, 17, 'uploads/MeanIt.jpg', 'uploads/MeanIt.mp3', 3, '2022-09-11 12:30:34', 222, 'mean-it', 0),
(36, 'Missing You', 1, 4, 'uploads/MissingYou.jpg', 'uploads/MissingYou.mp3', 1, '2022-09-11 12:30:34', 244, 'missing-you', 0),
(37, 'Một Bước Yêu, Vạn Dặm Đau', 1, 8, 'uploads/MotBuocYeuVanDamDau.jpg', 'uploads/MotBuocYeuVanDamDau.mp3', 1, '2022-09-11 12:30:34', 222, 'mot-buoc-yeu-van-dam-dau', 0),
(38, 'Nếu Lúc Đó', 1, 10, 'uploads/NeuLucDo.jpg', 'uploads/NeuLucDo.mp3', 2, '2022-09-11 12:30:34', 57, 'neu-luc-do', 0),
(39, 'Nếu Ngày Ấy', 1, 5, 'uploads/NeuNgayAy.jpg', 'uploads/NeuNgayAy.mp3', 1, '2022-09-11 12:30:34', 434, 'neu-ngay-ay', 0),
(40, 'Ngày Đầu Tiên', 1, 12, 'uploads/NgayDauTien.jpg', 'uploads/NgayDauTien.mp3', 1, '2022-09-11 12:30:34', 356, 'ngay-dau-tien', 0),
(41, 'OK', 1, 3, 'uploads/OK.jpg', 'uploads/OK.mp3', 2, '2022-09-11 12:30:34', 23, 'OK', 0),
(42, 'okeokeoke', 1, 14, 'uploads/okeokeoke.jpg', 'uploads/okeokeoke.mp3', 2, '2022-09-11 12:30:34', 123, 'okeokeoke', 0),
(43, 'One Call Away', 1, 15, 'uploads/OneCallAway.jpg', 'uploads/OneCallAway.mp3', 3, '2022-09-11 12:30:34', 34, '', 0),
(44, 'Perfect', 1, 19, 'uploads/Perfect.jpg', 'uploads/Perfect.mp3', 3, '2022-09-11 12:30:34', 114, 'perfect', 0),
(45, 'Phía Sau Một Cô Gái', 1, 5, 'uploads/PhiaSauMotCoGai.png', 'uploads/PhiaSauMotCoGai.mp3', 1, '2022-09-11 12:30:34', 1142, 'phia-sau-mot-co-gai', 0),
(46, 'Photograph', 1, 19, 'uploads/Photograph.jpg', 'uploads/Photograph.mp3', 3, '2022-09-11 12:30:34', 222, 'photograph', 0),
(47, 'Sau Tất Cả', 1, 7, 'uploads/SauTatCa.jpg', 'uploads/SauTatCa.mp3', 1, '2022-09-11 12:30:34', 2323, 'sau-tat-ca', 0),
(48, 'See You Again', 1, 15, 'uploads/SeeYouAgain.jpg', 'uploads/SeeYouAgain.mp3', 0, '2022-09-11 12:30:34', 1142, 'see-you-again', 0),
(49, 'Shape Of You', 1, 19, 'uploads/ShapeOfYou.jpg', 'uploads/ShapeOfYou.mp3', 0, '2022-09-11 12:30:34', 1122, 'shape-of-you', 0),
(53, 'Tại Vì Sao', 1, 6, 'uploads/TaiViSao.jpg', 'uploads/TaiViSao.mp3', 2, '2022-09-11 12:30:34', 434, 'tai-vi-sao', 0),
(54, 'The Playah', 1, 5, 'uploads/ThePlayah.jpg', 'uploads/ThePlayah.mp3', 1, '2022-09-11 12:30:34', 2567, 'the-playah', 0),
(55, 'Thích Quá Rùi Nà', 1, 10, 'uploads/ThichQuaRuiNa.jpg', 'uploads/ThichQuaRuiNa.mp3', 2, '2022-09-11 12:30:34', 26, 'thich-qua-rui-na', 0),
(56, 'ThichThich', 1, 4, 'uploads/ThichThich.jpg', 'uploads/ThichThich.mp3', 1, '2022-09-11 14:45:34', 117, 'thich-thich', 0),
(57, 'Thủ Đô Cypher', 1, 14, 'uploads/ThuDoCypher.jpg', 'uploads/ThuDoCypher.mp3', 2, '2022-09-11 12:30:34', 457, 'thu-do-cypher', 0),
(58, 'Tình Yêu Chậm Trễ', 1, 1, 'uploads/TinhYeuChamTre.jpg', 'uploads/TinhYeuChamTre.mp3', 1, '2022-09-11 12:30:34', 2435, 'tinh-yeu-cham-tre', 0),
(59, 'Tự Lau Nước Mắt', 1, 8, 'uploads/TuLauNuocMat.jpg', 'uploads/TuLauNuocMat.mp3', 1, '2022-09-11 12:30:34', 231, 'tu-lau-nuoc-mat', 0),
(60, 'Vaicaunoicokhiennguoithaydoi', 1, 1, 'uploads/vaicaunoicokhiennguoithaydoi.jpg', 'uploads/VaiCauNoiCoKhienNguoiThayDoi.mp3', 1, '2022-09-11 12:30:34', 1485, 'vaicaunoicokhiennguoithaydoi', 0),
(61, 'We Dont Talk Anymore', 1, 15, 'uploads/WeDontTalkAnymore.png', 'uploads/WeDontTalkAnymore.mp3', 3, '2022-09-11 12:30:34', 215, 'we-dont-talk-anymore', 0),
(62, 'Xin Đừng Nhấc Máy', 1, 11, 'uploads/XinDungNhacMay.jpg', 'uploads/XinDungNhacMay.mp3', 2, '2022-09-11 12:30:34', 21, 'xin-dung-nhac-may', 0),
(63, 'Yêu Anh Đi Mẹ Anh Bán Bánh Mì', 1, 9, 'uploads/YeuAnhDiMeAnhBanBanhMi.jpg', 'uploads/YeuAnhDiMeAnhBanBanhMi.mp3', 2, '2022-09-11 12:30:34', 54, 'yeu-anh-di-me-anh-ban-banh-mi', 0);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `artist_id` (`artist_id`),
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
