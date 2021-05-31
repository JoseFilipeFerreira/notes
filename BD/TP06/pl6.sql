/*a */
select M.nome from Clinica.MEDICO as M
where YEAR(M.data_inicio_servico) < 2009;

/*b */
select M.nome, E.designacao from Clinica.MEDICO as M
JOIN Clinica.ESPECIALIDADE AS E ON M.especialidade = E.id_especialidade;

/*c */
select P.nome, C.codigo_postal from Clinica.PACIENTE as P
JOIN Clinica.CODIGO_POSTAL AS C ON P.codigo_postal = C.codigo_postal
where C.localidade = "Braga";

/*d */
select  M.nome from Clinica.MEDICO as M
join Clinica.ESPECIALIDADE as E on M.especialidade = E.id_especialidade
where E.designacao = "Oftalmologia";

/*e */
select M.nome, 2019-YEAR(M.data_nascimento) from Clinica.MEDICO as M
join Clinica.ESPECIALIDADE as E on M.especialidade = E.id_especialidade
where YEAR(M.data_inicio_servico) < 1979;

/*f */
select distinct M.nome from Clinica.MEDICO as M
join Clinica.ESPECIALIDADE as E on M.especialidade = E.id_especialidade
join Clinica.CONSULTA as C on C.id_medico = M.id_medico
join Clinica.PACIENTE as P on C.id_paciente = P.id_paciente
join Clinica.CODIGO_POSTAL as CP on P.codigo_postal = CP.codigo_postal
where E.designacao = "Oftalmologia" AND CP.localidade = "Braga";

/*g */

/*h */
select distinct P.nome, 2019-YEAR(P.data_nascimento) from Clinica.PACIENTE as P
join Clinica.CONSULTA as C on C.id_paciente = P.id_paciente
join Clinica.MEDICO as M on M.id_medico = C.id_medico
join Clinica.ESPECIALIDADE as E on M.especialidade = E.id_especialidade
where YEAR(P.data_nascimento) < 2009 AND NOT E.designacao = "Oftalmologia";

SELECT P.nome, IDADE(P.nascimente) FROM PACIENTE as P
WHERE IDADE(P.nascimente) > 10 AND P.id NOT I
(SELECT P.id FROM PACIENTE as P
JOIN CONSULTA as C on C.id = P.id
JOIN MEDICO as M on M.id = C.id
JOIN ESPECIALIDADE as E on M.especialidade = E.especialidade
WHERE E.designacao = "Oftalmologia")
/*i */
select distinct E.designacao from Clinica.ESPECIALIDADE as E
join Clinica.MEDICO as M on M.especialidade = E.id_especialidade
join Clinica.CONSULTA as C on C.id_medico = M.id_medico
where YEAR(C.data_hora) = 2016 AND MONTH(C.data_hora) = 1;

/*j */
select M.nome from Clinica.MEDICO as M
where YEAR(M.data_nascimento) < 1989 OR YEAR(M.data_inicio_servico) > 2014;

/*k */
SELECT M.nome FROM Clinica.MEDICO AS M
JOIN Clinica.ESPECIALIDADE AS E ON M.especialidade = E.id_especialidade
WHERE E.designacao = "Clinica Geral"
and id_medico not in (
select me.id_medico from Clinica.MEDICO as me
JOIN Clinica.CONSULTA AS c ON c.id_medico = me.id_medico
where year(c.data_hora) = 2016 and month(c.data_hora) = 1);

/* l*/
