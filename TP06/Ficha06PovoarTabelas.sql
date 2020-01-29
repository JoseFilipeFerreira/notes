/* António Abelha - 2019   */
/* Bases de Dados          */
/* MIEI & LCC              */
/* ----------------------- */
/* FUNÇAO IDADE A CRIAR    */
use Clinica;

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION `idade` (dta date) RETURNS INT
BEGIN
RETURN TIMESTAMPDIFF(YEAR, dta, CURDATE());
END //
DELIMITER ;

/* SAMPLE DO POVOAMENTO DAS TABELAS */

INSERT INTO Clinica.CODIGO_POSTAL (codigo_postal, localidade) VALUES ('4750-002', 'BARCELOS');
INSERT INTO Clinica.CODIGO_POSTAL (codigo_postal, localidade) VALUES ('4700-001', 'BRAGA');
INSERT INTO Clinica.CODIGO_POSTAL (codigo_postal, localidade) VALUES ('4700-002', 'BRAGA');
INSERT INTO Clinica.CODIGO_POSTAL (codigo_postal, localidade) VALUES ('4700-003', 'BRAGA');
INSERT INTO Clinica.CODIGO_POSTAL (codigo_postal, localidade) VALUES ('4700-004', 'BRAGA');
INSERT INTO Clinica.CODIGO_POSTAL (codigo_postal, localidade) VALUES ('4700-005', 'BRAGA');

INSERT INTO Clinica.ESPECIALIDADE (id_especialidade, designacao, preco) VALUES(1, 'Oftalmologia', 50);
INSERT INTO Clinica.ESPECIALIDADE (id_especialidade, designacao, preco) VALUES(2, 'Clinica Geral', 30);
INSERT INTO Clinica.ESPECIALIDADE (id_especialidade, designacao, preco) VALUES(3, 'Cardiologia', 90);
INSERT INTO Clinica.ESPECIALIDADE (id_especialidade, designacao, preco) VALUES(4, 'Neurologia', 70);

INSERT INTO Clinica.MEDICO (id_medico, nome, morada, codigo_postal, data_nascimento, especialidade, data_inicio_servico) VALUES (123456, 'Jose Maria','Rua de Cima n.º 223, 5.º DTO', '4700-001', '1970-01-23', 1, '1990-02-23');
INSERT INTO Clinica.MEDICO (id_medico, nome, morada, codigo_postal, data_nascimento, especialidade, data_inicio_servico) VALUES (223456, 'Antonio Pinto','Rua de Baixo n.º 125, 2.º ESQ', '4700-003', '1991-11-21', 2, '1990-01-23');
INSERT INTO Clinica.MEDICO (id_medico, nome, morada, codigo_postal, data_nascimento, especialidade, data_inicio_servico) VALUES (323456, 'Manuel Maria Neves','Rua de Sul n.º 789, 9.º DTO', '4700-002', '1964-03-24', 2, '1979-07-23');
INSERT INTO Clinica.MEDICO (id_medico, nome, morada, codigo_postal, data_nascimento, especialidade, data_inicio_servico) VALUES (423456, 'Pedro Pinto Silva','Rua de Este n.º 456, 1.º DTO', '4750-002', '1978-02-13', 3, '1980-01-23');
INSERT INTO Clinica.MEDICO (id_medico, nome, morada, codigo_postal, data_nascimento, especialidade, data_inicio_servico) VALUES (523456, 'Marta Catarina','Rua de Cima n.º 120, 3.º ESQ', '4700-001', '1960-09-11', 1, '1971-05-23');

INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (123456, 'Manuel Marques', 'Rua de Cima n.º 753, 4.º DTO', '4700-001', '1970-01-23');
INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (223456, 'Pedro Paulo', 'Rua de Sul n.º 89, 5.º DTO', '4700-002', '1991-04-22');
INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (323456, 'Maria Jose Silva', 'Rua de Este n.º 765, 5.º ESQ', '4700-005', '2012-11-01');
INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (423456, 'Jose Manuel Marques', 'Rua de Oeste n.º 324, 5.º DTO', '4700-004', '1970-09-26');
INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (523456, 'Jacinto Homem', 'Rua de Este n.º 456, 5.º ESQ', '4750-002', '1982-12-23');
INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (623456, 'Sara Catarina Costa', 'Rua de Sul n.º 256, 9.º DTO', '4750-002', '1986-11-02');
INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (723456, 'Jose Carlos Moreira', 'Rua de Oeste n.º 96, 4.º DTO', '4700-004', '1970-09-07');
INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (823456, 'Joana Silva', 'Rua de Este n.º 285, 2.º ESQ', '4750-002', '2010-04-03');
INSERT INTO Clinica.PACIENTE (id_paciente, nome, morada, codigo_postal, data_nascimento) VALUES (923456, 'Rosa Maria Carvalho', 'Rua de Sul n.º 48, 7.º DTO', '4750-002', '2001-11-13');

INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (123456, 123456, '2016-01-23 14:30', 203);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 223456, '2016-01-23 14:30', 221);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 223456, '2016-03-21 14:30', 162);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (423456, 123456, '2016-06-01 08:30', 123);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (423456, 323456, '2015-06-13 15:30', 280);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (323456, 323456, '2016-05-21 16:30', 393);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 523456, '2015-04-27 17:30', 440);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (123456, 123456, '2015-04-27 17:30', 230);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (123456, 423456, '2016-02-27 14:30', 260);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 223456, '2016-01-12 15:30', 228);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 223456, '2015-02-11 11:30', 103);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (523456, 623456, '2015-03-01 14:30', 173);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 123456, '2015-09-30 14:30', 230);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (323456, 623456, '2015-08-23 11:30', 228);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (123456, 623456, '2016-01-23 15:30', 216);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 723456, '2016-03-22 10:30', 225);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 623456, '2016-03-21 15:30', 191);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (423456, 623456, '2016-06-01 09:30', 153);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (423456, 923456, '2015-06-13 16:30', 240);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (323456, 923456, '2016-05-21 17:30', 362);
INSERT INTO Clinica.CONSULTA (id_medico, id_paciente, data_hora, preco) VALUES (223456, 823456, '2015-04-27 18:30', 420);
