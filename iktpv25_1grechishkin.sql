-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 26, 2026 kell 09:53 EL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `iktpv25_1grechishkin`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `category`
--

CREATE TABLE `category` (
  `idCategory` int(11) NOT NULL,
  `Category_Name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `category`
--

INSERT INTO `category` (`idCategory`, `Category_Name`) VALUES
(1, 'Elektroonika'),
(2, 'Riided'),
(3, 'Toit');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `customer`
--

CREATE TABLE `customer` (
  `idCustomer` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `contact` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `customer`
--

INSERT INTO `customer` (`idCustomer`, `Name`, `contact`) VALUES
(1, 'Timur', 'timur@gmail.com'),
(2, 'Oleg', 'oleg@gmail.com'),
(3, 'Nikita', 'nikita@gmail.com');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `product`
--

CREATE TABLE `product` (
  `idProduct` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `idCategory` int(11) DEFAULT NULL,
  `Price` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `product`
--

INSERT INTO `product` (`idProduct`, `Name`, `idCategory`, `Price`) VALUES
(1, 'Telefon', 1, 599.99),
(2, 'Sülearvuti', 1, 999.99),
(3, 'T-särk', 2, 19.90),
(4, 'Leib', 3, 1.50);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `sale`
--

CREATE TABLE `sale` (
  `idSale` int(11) NOT NULL,
  `idProduct` int(11) DEFAULT NULL,
  `idCustomer` int(11) DEFAULT NULL,
  `Count_pr` int(11) DEFAULT NULL,
  `Date_of_sale` date DEFAULT NULL,
  `Units` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `sale`
--

INSERT INTO `sale` (`idSale`, `idProduct`, `idCustomer`, `Count_pr`, `Date_of_sale`, `Units`) VALUES
(1, 1, 1, 1, '2026-02-01', NULL),
(2, 3, 2, 2, '2026-02-05', NULL),
(3, 4, 3, 5, '2026-02-10', NULL);

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`idCategory`);

--
-- Indeksid tabelile `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`idCustomer`);

--
-- Indeksid tabelile `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `idCategory` (`idCategory`);

--
-- Indeksid tabelile `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`idSale`),
  ADD KEY `idProduct` (`idProduct`),
  ADD KEY `idCustomer` (`idCustomer`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `category`
--
ALTER TABLE `category`
  MODIFY `idCategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `customer`
--
ALTER TABLE `customer`
  MODIFY `idCustomer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `product`
--
ALTER TABLE `product`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `sale`
--
ALTER TABLE `sale`
  MODIFY `idSale` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idCategory`);

--
-- Piirangud tabelile `sale`
--
ALTER TABLE `sale`
  ADD CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`),
  ADD CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`idCustomer`) REFERENCES `customer` (`idCustomer`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
