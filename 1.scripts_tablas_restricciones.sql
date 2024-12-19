-- Tabla de usuarios
CREATE TABLE `usuarios` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `dni` VARCHAR(9) NOT NULL COLLATE 'utf8mb3_general_ci',
    `contraseña` VARCHAR(10) NOT NULL COLLATE 'utf8mb3_general_ci',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `dni` (`dni`) USING BTREE
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB;

-- Tabla de estado de contratos
CREATE TABLE `estadocontratos` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `contrato` ENUM('Vigente', 'Finalizado') NOT NULL COLLATE 'utf8mb3_general_ci',
    PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB;

-- Tabla de clientes
CREATE TABLE `clientes` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `usuarioId` INT(11) NOT NULL,
    `nombre` VARCHAR(10) NOT NULL COLLATE 'utf8mb3_general_ci',
    `apellidos` VARCHAR(10) NOT NULL COLLATE 'utf8mb3_general_ci',
    `telefono` INT(9) NOT NULL,
    `reservasAcumuladas` INT(9) NOT NULL DEFAULT '0',
    `preferencias` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `FK1Clientes_usuarioId` (`usuarioId`) USING BTREE,
    CONSTRAINT `FK1Clientes_usuarioId` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB;

-- Tabla de empleados
CREATE TABLE `empleados` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `usuarioId` INT(11) NOT NULL,
    `estadoContratoId` INT(11) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `FK1Empleado_usuarioId` (`usuarioId`) USING BTREE,
    INDEX `FK2Empleado_estadoContratoId` (`estadoContratoId`) USING BTREE,
    CONSTRAINT `FK1Empleado_usuarioId` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT `FK2Empleado_estadoContratoId` FOREIGN KEY (`estadoContratoId`) REFERENCES `estadocontratos` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB;

-- Tabla de reservas
CREATE TABLE `reservas` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `clienteId` INT(11) NOT NULL,
    `empleadoId` INT(11) NOT NULL,
    `fechaCheckIn` DATE NOT NULL,
    `fechaCheckOut` DATE NOT NULL,
    `importe` FLOAT NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `FK1Reserva_clienteId` (`clienteId`) USING BTREE,
    INDEX `FK2Reserva_empleadoId` (`empleadoId`) USING BTREE,
    CONSTRAINT `FK1Reserva_clienteId` FOREIGN KEY (`clienteId`) REFERENCES `clientes` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT `FK2Reserva_empleadoId` FOREIGN KEY (`empleadoId`) REFERENCES `empleados` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT `CC1CheckOutAnteriorCheckIN` CHECK (`fechaCheckIn` < `fechaCheckOut`),
    CONSTRAINT `CC2EstanciaMinima` CHECK (`fechaCheckOut` > `fechaCheckIn` + INTERVAL 1 DAY)
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB;

-- Tabla de habitaciones
CREATE TABLE `habitaciones` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `empleadoId` INT(11) NOT NULL,
    `numero` INT(11) NOT NULL,
    `capacidad` INT(11) NOT NULL,
    `precio` INT(11) NOT NULL,
    `disponibilidad` INT(11) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `FK1Habitacion_empleadoId` (`empleadoId`) USING BTREE,
    CONSTRAINT `FK1Habitacion_empleadoId` FOREIGN KEY (`empleadoId`) REFERENCES `empleados` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB;

-- Tabla de reservas-habitaciones
CREATE TABLE `reservashabitacion` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `reservaId` INT(11) NOT NULL,
    `habitacionId` INT(11) NOT NULL,
    `fechaComprobacion` DATE NOT NULL,
    `toallas` INT(11) NOT NULL,
    `gel` INT(11) NOT NULL,
    `sabanas` INT(11) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `FK1ReservasHab_reservaId` (`reservaId`) USING BTREE,
    INDEX `FK2ReservasHab_habitacionId` (`habitacionId`) USING BTREE,
    CONSTRAINT `FK1ReservasHab_reservaId` FOREIGN KEY (`reservaId`) REFERENCES `reservas` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT `FK2ReservasHab_habitacionId` FOREIGN KEY (`habitacionId`) REFERENCES `habitaciones` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB;
