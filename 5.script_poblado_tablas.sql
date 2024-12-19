INSERT INTO `usuarios` (`id`, `dni`, `contraseña`) VALUES
(1, '12345678A', 'pass1234'),
(2, '23456789B', 'pass5678'),
(3, '34567890C', 'pass8901'),
(4, '45678901D', 'pass2345');

INSERT INTO `estadocontratos` (`id`, `contrato`) VALUES
(1, 'Vigente'),
(2, 'Finalizado');

INSERT INTO `clientes` (`id`, `usuarioId`, `nombre`, `apellidos`, `telefono`, `reservasAcumuladas`, `preferencias`) VALUES
(1, 1, 'Juan', 'Perez', 123456789, 2, 'Vistas al mar'),
(2, 2, 'Ana', 'Garcia', 234567890, 1, 'Cama king-size');

INSERT INTO `empleados` (`id`, `usuarioId`, `estadoContratoId`) VALUES
(1, 3, 1), -- Usuario 3 tiene contrato vigente
(2, 4, 2); -- Usuario 4 tiene contrato finalizado

INSERT INTO `reservas` (`id`, `clienteId`, `empleadoId`, `fechaCheckIn`, `fechaCheckOut`, `importe`) VALUES
(1, 1, 1, '2024-12-20', '2024-12-25', 500.00),
(2, 2, 1, '2024-12-22', '2024-12-24', 300.00);

INSERT INTO `habitaciones` (`id`, `empleadoId`, `numero`, `capacidad`, `precio`, `disponibilidad`) VALUES
(1, 1, 101, 2, 100, 1),
(2, 1, 102, 3, 150, 1);

INSERT INTO `reservashabitacion` (`id`, `reservaId`, `habitacionId`, `fechaComprobacion`, `toallas`, `gel`, `sabanas`) VALUES
(1, 1, 1, '2024-12-21', 2, 1, 1),
(2, 1, 2, '2024-12-22', 3, 2, 1),
(3, 2, 1, '2024-12-23', 1, 1, 0);
