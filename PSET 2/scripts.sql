-- 1
SELECT a.nome_departamento , avg(b.salario) as salario
FROM departamento as a 
left outer join funcionario as b on a.numero_departamento = b.numero_departamento 
group by a.nome_departamento;

-- 2
SELECT a.sexo, avg(a.salario)
from funcionario as a
group by a.sexo;

-- 3 
SELECT a.nome_departamento, CONCAT(b.primeiro_nome, ' ',b.nome_meio, ' ', b.ultimo_nome)   as nome, b.data_nascimento, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(b.data_nascimento))) AS idade, b.salario 
FROM departamento as a
LEFT OUTER JOIN funcionario as b on a.numero_departamento = b.numero_departamento;
 
-- 4
SELECT concat(a.primeiro_nome, ' ', a.nome_meio, ' ', a.ultimo_nome) as nome, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(a.data_nascimento))) AS idade, salario, IF(a.salario < 35000, a.salario *1.2, a.salario * 1.15) as reajuste 
FROM funcionario as a;

-- 5
SELECT a.nome_departamento, concat(c.primeiro_nome, ' ',c.nome_meio, ' ', c.ultimo_nome) as gerente, CONCAT(b.primeiro_nome, ' ', b.nome_meio, ' ', b.ultimo_nome) as nome_funcionario, b.salario
FROM departamento as a 
left outer join funcionario as b on a.numero_departamento  = b.numero_departamento 
left outer join funcionario as c on a.cpf_gerente  = c.cpf 
ORDER BY a.nome_departamento , b.salario  DESC;

-- 6
SELECT CONCAT(a.primeiro_nome, ' ', a.nome_meio, ' ', a.ultimo_nome)  ,b.nome_departamento , c.nome_dependente ,YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(c.data_nascimento))) AS idade_dependente , CASE c.sexo  WHEN 'F' THEN 'Feminino' else 'Masculino' end as sexo_dependente 
FROM funcionario as a 
left outer join departamento as b on a.numero_departamento  = b.numero_departamento  
inner join dependente as c on a.cpf  = c.cpf_funcionario;

-- 7
SELECT CONCAT(a.primeiro_nome, ' ', a.nome_meio, ' ', a.ultimo_nome) as nome, c.nome_departamento , a.salario  
FROM funcionario as a
LEFT JOIN dependente as b on a.cpf = b.cpf_funcionario 
LEFT JOIN departamento as c on a.numero_departamento = c.numero_departamento 
WHERE b.cpf_funcionario  IS NULL;

-- 8
SELECT a.nome_departamento , b.nome_projeto , CONCAT(d.primeiro_nome, ' ',d.nome_meio, ' ', d.ultimo_nome)  as nome, c.horas 
FROM departamento as a
LEFT JOIN projeto as b on a.numero_departamento  = b.numero_departamento 
LEFT JOIN trabalha_em as c on b.numero_projeto  = c.numero_projeto 
LEFT JOIN  funcionario as d on c.cpf_funcionario  = d.cpf;

-- 9
SELECT a.nome_departamento, b.nome_projeto, SUM(c.horas) as Total_Horas
FROM departamento as a 
INNER JOIN projeto as b on b.numero_departamento = a.numero_departamento 
INNER JOIN trabalha_em as c on c.numero_projeto = b.numero_projeto 
GROUP BY a.nome_departamento, b.nome_projeto
ORDER BY a.nome_departamento;

-- 10
SELECT a.nome_departamento , avg(b.salario) as salario
FROM departamento as a 
LEFT OUTER JOIN funcionario as b on a.numero_departamento = b.numero_departamento 
GROUP BY a.nome_departamento;

-- 11
SELECT CONCAT(a.primeiro_nome, ' ', a.nome_meio, ' ', a.ultimo_nome) as Funcionario, b.nome_projeto as Projeto, SUM(c.horas * 50) as Total_Horas
FROM funcionario as a
INNER JOIN projeto as b on a.numero_departamento = b.numero_departamento 
INNER JOIN trabalha_em as c on b.numero_projeto = c.numero_projeto 
GROUP BY Funcionario, Projeto
ORDER BY Funcionario;

-- 12
SELECT a.nome_departamento as Departamento, b.nome_projeto as Projeto, CONCAT(c.primeiro_nome, ' ', c.nome_meio, ' ', c.ultimo_nome) as Funcionario
FROM projeto as b
INNER JOIN departamento as a on (b.numero_departamento = a.numero_departamento)
INNER JOIN funcionario as c on (b.numero_departamento = c.numero_departamento)
INNER JOIN trabalha_em as d on (b.numero_projeto = d.numero_projeto)
WHERE d.horas is null or d.horas = 0;

-- 13
SELECT CONCAT(a.primeiro_nome,' ', a.nome_meio,' ', a.ultimo_nome) AS Nome, sexo as Sexo, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(a.data_nascimento))) as Idade
FROM funcionario as a
UNION
SELECT CONCAT(b.nome_dependente, ' ', a.ultimo_nome), b.sexo AS Sexo, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(b.data_nascimento))) AS Idade
FROM dependente b
INNER JOIN funcionario a ON (a.cpf = b.cpf_funcionario)
ORDER BY idade DESC;

-- 14
SELECT a.numero_departamento, b.nome_departamento, COUNT(*) AS total_por_departamento 
FROM funcionario as a 
LEFT JOIN departamento as b on (a.numero_departamento = b.numero_departamento)
GROUP BY numero_departamento;

-- 15
SELECT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) as Funcionario, a.numero_departamento AS departamento, nome_projeto as Projeto_Alocado
FROM funcionario as a
INNER JOIN departamento b ON (a.numero_departamento = b.numero_departamento)
LEFT OUTER JOIN projeto c ON (b.numero_departamento = c.numero_departamento);