-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Märts 30, 2026 kell 08:58 EL
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
-- Andmebaas: `praktikabaas`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `keskminePalk` ()   BEGIN
    SELECT AVG(palk) FROM praktikajuhendaja;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaFirma` (IN `nimi` VARCHAR(50), IN `aadress` VARCHAR(50), IN `telefon` VARCHAR(20))   BEGIN
    INSERT INTO firma(firmanimi, aadress, telefon)
    VALUES (nimi, aadress, telefon);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaVeerg` ()   BEGIN
    ALTER TABLE firma ADD email VARCHAR(50);
END$$

--
-- Funktsioonid
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateAge` (`dob` DATE) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE age INT;

    SET age = TIMESTAMPDIFF(YEAR, dob, CURDATE());

    IF (MONTH(dob) > MONTH(CURDATE())) OR
       (MONTH(dob) = MONTH(CURDATE()) AND DAY(dob) > DAY(CURDATE())) THEN
        SET age = age - 1;
    END IF;

    RETURN age;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fnComputeAge` (`dob` DATE) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC BEGIN
    DECLARE years INT;
    DECLARE months INT;
    DECLARE days INT;

    SET years = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    SET months = TIMESTAMPDIFF(MONTH, dob, CURDATE()) % 12;
    SET days = DATEDIFF(CURDATE(), DATE_ADD(dob, INTERVAL years YEAR) + INTERVAL months MONTH);

    RETURN CONCAT(years, ' Years ', months, ' Months ', days, ' Days');
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `firma`
--

CREATE TABLE `firma` (
  `firmaID` int(11) NOT NULL,
  `firmanimi` varchar(20) DEFAULT NULL,
  `aadress` varchar(20) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `firma`
--

INSERT INTO `firma` (`firmaID`, `firmanimi`, `aadress`, `telefon`) VALUES
(1, 'Elisa', 'Tallinn', '111111'),
(2, 'Telia', 'Tartu', '222222'),
(3, 'Tele2', 'Narva', '333333'),
(4, 'Swedbank', 'Pärnu', '444444'),
(5, 'Euronics', 'Rakvere', '555555');

-- --------------------------------------------------------

--
-- Sise-vaate struktuur `firma_praktika_arv`
-- (Tegelik vaade on allpool)
--
CREATE TABLE `firma_praktika_arv` (
`firmanimi` varchar(20)
,`kogus` bigint(21)
);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `praktikabaas`
--

CREATE TABLE `praktikabaas` (
  `praktikabaasID` int(11) NOT NULL,
  `firmaID` int(11) DEFAULT NULL,
  `praktikatingimused` varchar(20) DEFAULT NULL,
  `arvutiprogramm` varchar(20) DEFAULT NULL,
  `juhendajaID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `praktikabaas`
--

INSERT INTO `praktikabaas` (`praktikabaasID`, `firmaID`, `praktikatingimused`, `arvutiprogramm`, `juhendajaID`) VALUES
(1, 1, 'Hea', 'Excel', 1),
(2, 2, 'Rahuldav', 'Word', 2),
(3, 3, 'Hea', 'Paint', 3),
(4, 1, 'Väga hea', 'Photoshop', 2),
(5, 4, 'Rahuldav', 'Excel', 4),
(6, 5, 'Hea', 'Visual Studio Code', 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `praktikajuhendaja`
--

CREATE TABLE `praktikajuhendaja` (
  `praktikajuhendajaID` int(11) NOT NULL,
  `eesnimi` varchar(30) DEFAULT NULL,
  `perekonnanimi` varchar(30) DEFAULT NULL,
  `synniaeg` date DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `palk` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `praktikajuhendaja`
--

INSERT INTO `praktikajuhendaja` (`praktikajuhendajaID`, `eesnimi`, `perekonnanimi`, `synniaeg`, `telefon`, `palk`) VALUES
(1, 'Ivan', 'Ivanov', '1985-09-10', '123', 1000.00),
(2, 'Petr', 'Petrov', '1990-10-15', '234', 1200.00),
(3, 'Timur', 'Timurov', '1988-11-20', '345', 1100.00),
(4, 'Olga', 'Olgova', '1995-03-12', '456', 1300.00),
(5, 'Sergey', 'Sergeev', '1982-07-07', '567', 1250.00);

-- --------------------------------------------------------

--
-- Sise-vaate struktuur `sygisel_syndinud`
-- (Tegelik vaade on allpool)
--
CREATE TABLE `sygisel_syndinud` (
`praktikajuhendajaID` int(11)
,`eesnimi` varchar(30)
,`perekonnanimi` varchar(30)
,`synniaeg` date
,`telefon` varchar(20)
,`palk` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Vaate struktuur `firma_praktika_arv`
--
DROP TABLE IF EXISTS `firma_praktika_arv`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `firma_praktika_arv`  AS SELECT `firma`.`firmanimi` AS `firmanimi`, count(`praktikabaasID`) AS `kogus` FROM (`praktikabaas` join `firma`) WHERE `firma`.`firmaID` = `firmaID` GROUP BY `firma`.`firmanimi` ;

-- --------------------------------------------------------

--
-- Vaate struktuur `sygisel_syndinud`
--
DROP TABLE IF EXISTS `sygisel_syndinud`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sygisel_syndinud`  AS SELECT `praktikajuhendaja`.`praktikajuhendajaID` AS `praktikajuhendajaID`, `praktikajuhendaja`.`eesnimi` AS `eesnimi`, `praktikajuhendaja`.`perekonnanimi` AS `perekonnanimi`, `praktikajuhendaja`.`synniaeg` AS `synniaeg`, `praktikajuhendaja`.`telefon` AS `telefon`, `praktikajuhendaja`.`palk` AS `palk` FROM `praktikajuhendaja` WHERE month(`praktikajuhendaja`.`synniaeg`) in (9,10,11) ;

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `firma`
--
ALTER TABLE `firma`
  ADD PRIMARY KEY (`firmaID`);

--
-- Indeksid tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  ADD PRIMARY KEY (`praktikabaasID`),
  ADD KEY `firmaID` (`firmaID`),
  ADD KEY `juhendajaID` (`juhendajaID`);

--
-- Indeksid tabelile `praktikajuhendaja`
--
ALTER TABLE `praktikajuhendaja`
  ADD PRIMARY KEY (`praktikajuhendajaID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `firma`
--
ALTER TABLE `firma`
  MODIFY `firmaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  MODIFY `praktikabaasID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `praktikajuhendaja`
--
ALTER TABLE `praktikajuhendaja`
  MODIFY `praktikajuhendajaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `praktikabaas`
--
ALTER TABLE `praktikabaas`
  ADD CONSTRAINT `praktikabaas_ibfk_1` FOREIGN KEY (`firmaID`) REFERENCES `firma` (`firmaID`),
  ADD CONSTRAINT `praktikabaas_ibfk_2` FOREIGN KEY (`juhendajaID`) REFERENCES `praktikajuhendaja` (`praktikajuhendajaID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
