DELIMITER //
CREATE OR REPLACE TRIGGER t_programaFidelidad BEFORE INSERT ON reservas
FOR EACH ROW 
BEGIN 
	DECLARE nReserva INT;
	
	SELECT clientes.reservasAcumuladas INTO nReserva FROM clientes
	JOIN reservas ON clientes.id=reservas.clienteId
	WHERE NEW.clienteId = reservas.id;
	
	IF (nReserva>0) AND (nReserva%5 = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT= '!La siguiente corre a nuestro cargo! Gracias por su fidelidad';
	END IF;
END //
DELIMITER ;