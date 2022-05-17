-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.6.5-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para hospital
CREATE DATABASE IF NOT EXISTS `hospital` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci */;
USE `hospital`;

-- Volcando estructura para tabla hospital.t_agendas
CREATE TABLE IF NOT EXISTS `t_agendas` (
  `id_agenda` int(11) NOT NULL AUTO_INCREMENT,
  `id_sucursal` int(11) NOT NULL DEFAULT 1,
  `id_paciente` int(11) NOT NULL DEFAULT 0,
  `id_horario` int(11) NOT NULL DEFAULT 0,
  `id_medico` int(11) NOT NULL DEFAULT 0,
  `tipo_cita` enum('SIN DEFINIR','REVISION','ESTUDIOS') COLLATE latin1_spanish_ci DEFAULT 'SIN DEFINIR',
  `tiempo_cita` time DEFAULT NULL,
  `estatus` enum('CONFIRMADA','SIN CONFIRMAR','CANCELADA','ATENDIDA') COLLATE latin1_spanish_ci DEFAULT 'SIN CONFIRMAR',
  `estudios` enum('S','N') COLLATE latin1_spanish_ci DEFAULT 'N',
  `observaciones` varchar(500) COLLATE latin1_spanish_ci DEFAULT NULL,
  `notas` varchar(500) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_agenda`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.t_horarios
CREATE TABLE IF NOT EXISTS `t_horarios` (
  `id_horario` int(11) NOT NULL AUTO_INCREMENT,
  `dia` date DEFAULT NULL,
  `horario` char(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `disponible` enum('S','N') COLLATE latin1_spanish_ci DEFAULT 'S',
  `id_medico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_horario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.t_log_api
CREATE TABLE IF NOT EXISTS `t_log_api` (
  `id_log_api` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `json_result` varchar(50000) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `num_registros` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_log_api`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.t_medicos
CREATE TABLE IF NOT EXISTS `t_medicos` (
  `id_medico` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `departamento` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_medico`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.t_pacientes
CREATE TABLE IF NOT EXISTS `t_pacientes` (
  `id_paciente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `ap_paterno` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `ap_materno` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `correo` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `localidad` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `telefono` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_paciente`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla hospital.t_usuarios
CREATE TABLE IF NOT EXISTS `t_usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `correo` char(100) COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `password` char(150) COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `login` int(11) DEFAULT 0,
  PRIMARY KEY (`id_usuario`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- La exportación de datos fue deseleccionada.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
