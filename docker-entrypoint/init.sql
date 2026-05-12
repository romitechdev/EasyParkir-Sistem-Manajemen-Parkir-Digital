-- Create database if not exists
CREATE DATABASE IF NOT EXISTS parkir;
USE parkir;

-- --------------------------------------------------------
-- Struktur dari tabel `jenisKendaraan`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `jenisKendaraan` (
  `id_jenisKendaraan` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_kendaraan` varchar(20) DEFAULT NULL,
  `harga` varchar(10) DEFAULT NULL,
  `kapasitas_slot` int(11) DEFAULT '0',
  PRIMARY KEY (`id_jenisKendaraan`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data untuk tabel `jenisKendaraan`
INSERT INTO `jenisKendaraan` (`id_jenisKendaraan`, `jenis_kendaraan`, `harga`, `kapasitas_slot`) VALUES
(1, 'Motor', '2000', 50),
(2, 'Mobil', '5000', 20),
(3, 'Listrik', '2000', 20);

-- --------------------------------------------------------
-- Struktur dari tabel `kendaraan_masuk`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `kendaraan_masuk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_unik` varchar(20) NOT NULL,
  `nama_kendaraan` varchar(50) DEFAULT NULL,
  `id_jenisKendaraan` int(11) DEFAULT NULL,
  `waktu_masuk` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_jenisKendaraan`) REFERENCES `jenisKendaraan`(`id_jenisKendaraan`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- Struktur dari tabel `riwayat_keluar`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `riwayat_keluar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_unik` varchar(20) DEFAULT NULL,
  `nama_kendaraan` varchar(50) DEFAULT NULL,
  `id_jenisKendaraan` int(11) DEFAULT NULL,
  `waktu_masuk` datetime DEFAULT NULL,
  `waktu_keluar` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `durasi_hari` int(11) DEFAULT NULL,
  `biaya` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_jenisKendaraan`) REFERENCES `jenisKendaraan`(`id_jenisKendaraan`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- Struktur dari tabel `slotParkir`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `slotParkir` (
  `id_slot` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_slot` varchar(20) NOT NULL,
  `id_jenisKendaraan` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'kosong',
  `id_kendaraan_masuk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_slot`),
  FOREIGN KEY (`id_jenisKendaraan`) REFERENCES `jenisKendaraan`(`id_jenisKendaraan`),
  FOREIGN KEY (`id_kendaraan_masuk`) REFERENCES `kendaraan_masuk`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- Struktur dari tabel `users`
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'operator',
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Insert default admin user (password: admin123)
INSERT IGNORE INTO `users` (`id_user`, `username`, `password`, `nama_lengkap`, `email`, `role`) VALUES
(1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'Administrator', 'admin@easyparkir.com', 'admin'),
(2, 'operator', 'fd51014e5d2a29ecaec91eab8c18e4f44a5e4c1cc87b89ba61e3bdcf9c66be5f', 'Operator Parkir', 'operator@easyparkir.com', 'operator'),
(3, 'petugas2', '$2y$10$XcDu/w.9JiY4L7blsO5AxeKJtNt.GQQjg.sRj2/967MAfQVt8qh06', 'Petugas Baru', 'petugas2@easyparkir.com', 'petugas'),
(4, 'admin2', '$2y$10$4T6y9kXBypGyhxqGJIBCWeMXlOq6XL3ld973C1aKAEnoNsR9iXloe', 'Admin Cadangan', 'admin2@easyparkir.com', 'admin');
