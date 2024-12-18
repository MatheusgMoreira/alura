USE `insight_places`;
DROP PROCEDURE IF EXISTS `insight_places`.`novoAluguel_21`;
DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_21`()
BEGIN
    DECLARE vAluguel VARCHAR(10) DEFAULT 10001;
    DECLARE vCliente VARCHAR(10) DEFAULT 1002;
    DECLARE vHospedagem VARCHAR(10) DEFAULT 8635;
    DECLARE vDataInicio DATE DEFAULT '2023-03-01';
    DECLARE vDataFinal DATE DEFAULT '2023-03-05';
    DECLARE vPrecoTotal DECIMAL(10,2) DEFAULT 550.23;
    SELECT vAluguel, vCliente, vHospedagem, vDataInicio,
    vDataFinal, vPrecoTotal;
END$$
DELIMITER ;

CALL novoAluguel_21;

USE `insight_places`;
DROP PROCEDURE IF EXISTS `insight_places`.`novoAluguel_22`;
DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_22`()
BEGIN
    DECLARE vAluguel VARCHAR(10) DEFAULT 10001;
    DECLARE vCliente VARCHAR(10) DEFAULT 1002;
    DECLARE vHospedagem VARCHAR(10) DEFAULT 8635;
    DECLARE vDataInicio DATE DEFAULT '2023-03-01';
    DECLARE vDataFinal DATE DEFAULT '2023-03-05';
    DECLARE vPrecoTotal DECIMAL(10,2) DEFAULT 550.23;
    INSERT INTO reservas VALUES (vAluguel, vCliente, vHospedagem, vDataInicio,
    vDataFinal, vPrecoTotal);
END$$
DELIMITER ;

CALL novoAluguel_22;

USE `insight_places`;
DROP PROCEDURE IF EXISTS `insight_places`.`novoAluguel_23`;
DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_23`
(
	vAluguel VARCHAR(10),
    vCliente VARCHAR(10),
    vHospedagem VARCHAR(10),
    vDataInicio DATE,
    vDataFinal DATE,
    vPrecoTotal DECIMAL(10,2)
)
BEGIN
    INSERT INTO reservas VALUES (vAluguel, vCliente, vHospedagem, vDataInicio,
    vDataFinal, vPrecoTotal);
END$$
DELIMITER ;

CALL novoAluguel_23('10002', '1003', '8635', '2023-03-06', '2023-03-10', 600);
SELECT * FROM reservas WHERE reserva_id = '10002';

USE `insight_places`;
DROP PROCEDURE IF EXISTS `insight_places`.`novoAluguel_24`;
DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_24`
(
	vAluguel VARCHAR(10),
    vCliente VARCHAR(10),
    vHospedagem VARCHAR(10),
    vDataInicio DATE,
    vDataFinal DATE,
    vPrecoUnitario DECIMAL(10,2)
)
BEGIN
	DECLARE vDias INTEGER DEFAULT 0;
    DECLARE vPrecoTotal DECIMAL(10,2);
    SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
    SET vPrecoTotal = vDias * vPrecoUnitario;
    INSERT INTO reservas VALUES (vAluguel, vCliente, vHospedagem, vDataInicio,
    vDataFinal, vPrecoTotal);
END$$
DELIMITER ;

CALL novoAluguel_24('10006', '1004', '8635', '2023-03-13', '2023-03-16', 32);
SELECT * FROM reservas WHERE reserva_id = '10006';

USE `insight_places`;
DROP PROCEDURE IF EXISTS `insight_places`.`novoAluguel_25`;
DELIMITER $$
USE `insight_places`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `novoAluguel_25`
(
	vAluguel VARCHAR(10),
    vCliente VARCHAR(10),
    vHospedagem VARCHAR(10),
    vDataInicio DATE,
    vDataFinal DATE,
    vPrecoUnitario DECIMAL(10,2)
)
BEGIN
	DECLARE vDias INTEGER DEFAULT 0;
    DECLARE vPrecoTotal DECIMAL(10,2);
    DECLARE vMensagem VARCHAR(100);
    DECLARE EXIT HANDLER FOR 1452
    BEGIN
		SET vMensagem = 'Problema de chave estrangeira, associado a alguma entidade da base';
        SELECT vMensagem;
    END;
    SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
    SET vPrecoTotal = vDias * vPrecoUnitario;
    INSERT INTO reservas VALUES (vAluguel, vCliente, vHospedagem, vDataInicio,
    vDataFinal, vPrecoTotal);
    SET vMensagem = 'Aluguel incluido na base com sucesso';
	SELECT vMensagem;
END$$
DELIMITER ;

CALL novoAluguel_25('10008', '1004', '8635', '2023-03-13', '2023-03-16', 32);
SELECT * FROM clientes WHERE cliente_id = '10007';