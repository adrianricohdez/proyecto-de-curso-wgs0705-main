DELIMITER //
CREATE OR REPLACE PROCEDURE
PCosteTotal(IN pReservaId INT, IN pFechaIn DATE, IN pFechaOut Date)
BEGIN 
DECLARE montoTotal INT;

SELECT SUM(habitaciones.precio) INTO montoTotal
FROM habitaciones
JOIN reservashabitacion ON habitaciones.id=reservashabitacion.habitacionId
WHERE reservas.id=reservashabitacion.reservaId && reservas.fechaCheckIn=pFechaIn && reservas.fechaCheckOut=pfechaOut;

UPDATE reservas SET reservas.importe=montoTotal
WHERE pReservaId=reservas.id;
END //
DELIMITER ;