## PSET 2

### Hian Pertel Boone -  SI1N

### Prof. Abrantes Araujo Silva Filho

---
## INTRODUÇÃO 

Olá, este é o meu segundo _PSet_, é um desafio proposto pelo professor Abrantes Araujo, da Universidade Vila Velha, que leciona a disciplina de Design e Desenvolvimento de Banco de Dados I.

Nele foi proposto que os alunos fizesse diversos comandos ```select``` utilizando o banco de dados criado no [PSet 1](../uvv_bd_1_si1n/PSET%201/), deve ser compartilhado através do **Github** e adequadamente comentado atráves de **Markdown**.

---

## APLICAÇÃO

Utilizei a maquina virtual que o próprio professor disponibilizou através de seu [site](https://www.computacaoraiz.com.br/2022/03/17/maquina-virtual-para-o-estudo-de-sistemas-de-gerenciamento-de-bancos-de-dados-db-server/).

Foi utilizado o **DBeaver 22.0.0** para a implementação no MariaBD.

---

## COMANDOS

<br/>

#### **QUESTÃO 01**: prepare um relatório que mostre a média salarial dos funcionários de cada departamento.

```sql
SELECT a.nome_departamento , avg(b.salario) as salario
FROM departamento as a 
left outer join funcionario as b on a.numero_departamento = b.numero_departamento 
group by a.nome_departamento;
````

<br/>

#### **QUESTÃO 02**: prepare um relatório que mostre a média salarial dos homens e das mulheres.

```sql
SELECT a.sexo, avg(a.salario)
from funcionario as a
group by a.sexo;
````

<br/>

#### **QUESTÃO 03**: prepare um relatório que liste o nome dos departamentos e, para cada departamento, inclua as seguintes informações de seus funcionários: o nome completo, a data de nascimento, a idade em anos completos e o salário.

```sql
SELECT a.nome_departamento, CONCAT(b.primeiro_nome, ' ',b.nome_meio, ' ', b.ultimo_nome)   as nome, b.data_nascimento, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(b.data_nascimento))) AS idade, b.salario 
FROM departamento as a
LEFT OUTER JOIN funcionario as b on a.numero_departamento = b.numero_departamento;
````

<br/>

#### **QUESTÃO 04**: prepare um relatório que mostre o nome completo dos funcionários, a idade em anos completos, o salário atual e o salário com um reajuste que obedece ao seguinte critério: se o salário atual do funcionário é inferior a 35.000 o reajuste deve ser de 20%, e se o salário atual do funcionário for igual ou superior a 35.000 o reajuste deve ser de 15%.

```sql
SELECT concat(a.primeiro_nome, ' ', a.nome_meio, ' ', a.ultimo_nome) as nome, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(a.data_nascimento))) AS idade, salario, IF(a.salario < 35000, a.salario *1.2, a.salario * 1.15) as reajuste 
FROM funcionario as a;
````

<br/>

#### **QUESTÃO 05**: prepare um relatório que liste, para cada departamento, o nome do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento (em ordem crescente) e por salário dos funcionários (em ordem decrescente).

```sql
SELECT a.nome_departamento, concat(c.primeiro_nome, ' ',c.nome_meio, ' ', c.ultimo_nome) as gerente, CONCAT(b.primeiro_nome, ' ', b.nome_meio, ' ', b.ultimo_nome) as nome_funcionario, b.salario
FROM departamento as a 
left outer join funcionario as b on a.numero_departamento  = b.numero_departamento 
left outer join funcionario as c on a.cpf_gerente  = c.cpf 
ORDER BY a.nome_departamento , b.salario  DESC;
````

<br/>

#### **QUESTÃO 06**: prepare um relatório que mostre o nome completo dos funcionários que têm dependentes, o  departamento onde eles trabalham e, para cada funcionário, também liste o nome completo dos dependentes, a idade em anos de cada dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer como “Masculino” ou “Feminino”).

```sql
SELECT CONCAT(a.primeiro_nome, ' ', a.nome_meio, ' ', a.ultimo_nome)  ,b.nome_departamento , c.nome_dependente ,YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(c.data_nascimento))) AS idade_dependente , CASE c.sexo  WHEN 'F' THEN 'Feminino' else 'Masculino' end as sexo_dependente 
FROM funcionario as a 
left outer join departamento as b on a.numero_departamento  = b.numero_departamento  
inner join dependente as c on a.cpf  = c.cpf_funcionario;
````

<br/>

#### **QUESTÃO 07**: prepare um relatório que mostre, para cada funcionário que NÃO TEM dependente, seu nome completo, departamento e salário.

```sql
SELECT CONCAT(a.primeiro_nome, ' ', a.nome_meio, ' ', a.ultimo_nome) as nome, c.nome_departamento , a.salario  
FROM funcionario as a
LEFT JOIN dependente as b on a.cpf = b.cpf_funcionario 
LEFT JOIN departamento as c on a.numero_departamento = c.numero_departamento 
WHERE b.cpf_funcionario  IS NULL;
````

<br/>

#### **QUESTÃO 08**: prepare um relatório que mostre, para cada departamento, os projetos desse departamento e o nome completo dos funcionários que estão alocados em cada projeto. Além disso inclua o número de horas trabalhadas por cada funcionário, em cada projeto.

```sql
SELECT a.nome_departamento , b.nome_projeto , CONCAT(d.primeiro_nome, ' ',d.nome_meio, ' ', d.ultimo_nome)  as nome, c.horas 
FROM departamento as a
LEFT JOIN projeto as b on a.numero_departamento  = b.numero_departamento 
LEFT JOIN trabalha_em as c on b.numero_projeto  = c.numero_projeto 
LEFT JOIN  funcionario as d on c.cpf_funcionario  = d.cpf;
````

<br/>

#### **QUESTÃO 09**: prepare um relatório que mostre a soma total das horas de cada projeto em cada departamento. Obs.: o relatório deve exibir o nome do departamento, o nome do projeto e a soma total das horas.

```sql
SELECT a.nome_departamento, b.nome_projeto, SUM(c.horas) as Total_Horas
FROM departamento as a 
INNER JOIN projeto as b on b.numero_departamento = a.numero_departamento 
INNER JOIN trabalha_em as c on c.numero_projeto = b.numero_projeto 
GROUP BY a.nome_departamento, b.nome_projeto
ORDER BY a.nome_departamento;
````

<br/>

#### **QUESTÃO 10**: prepare um relatório que mostre a média salarial dos funcionários de cada departamento.

```sql
SELECT a.nome_departamento , avg(b.salario) as salario
FROM departamento as a 
LEFT OUTER JOIN funcionario as b on a.numero_departamento = b.numero_departamento 
GROUP BY a.nome_departamento;
````

<br/>

#### **QUESTÃO 11**: considerando que o valor pago por hora trabalhada em um projeto é de 50 reais, prepare um relatório que mostre o nome completo do funcionário, o nome do projeto e o valor total que o funcionário receberá referente às horas trabalhadas naquele projeto.

```sql
SELECT CONCAT(a.primeiro_nome, ' ', a.nome_meio, ' ', a.ultimo_nome) as Funcionario, b.nome_projeto as Projeto, SUM(c.horas * 50) as Total_Horas
FROM funcionario as a
INNER JOIN projeto as b on a.numero_departamento = b.numero_departamento 
INNER JOIN trabalha_em as c on b.numero_projeto = c.numero_projeto 
GROUP BY Funcionario, Projeto
ORDER BY Funcionario;
````

<br/>

#### **QUESTÃO 12**: seu chefe está verificando as horas trabalhadas pelos funcionários nos projetos e percebeu que alguns funcionários, mesmo estando alocadas à algum projeto, não registraram nenhuma hora trabalhada. Sua tarefa é preparar um relatório que liste o nome do departamento, o nome do projeto e o nome dos funcionários que, mesmo estando alocados a algum projeto, não registraram nenhuma hora trabalhada.

```sql
SELECT a.nome_departamento as Departamento, b.nome_projeto as Projeto, CONCAT(c.primeiro_nome, ' ', c.nome_meio, ' ', c.ultimo_nome) as Funcionario
FROM projeto as b
INNER JOIN departamento as a on (b.numero_departamento = a.numero_departamento)
INNER JOIN funcionario as c on (b.numero_departamento = c.numero_departamento)
INNER JOIN trabalha_em as d on (b.numero_projeto = d.numero_projeto)
WHERE d.horas is null or d.horas = 0;
````

<br/>

#### **QUESTÃO 13**: durante o natal deste ano a empresa irá presentear todos os funcionários e todos os dependentes (sim, a empresa vai dar um presente para cada funcionário e um presente para cada dependente de cada funcionário) e pediu para que você preparasse um relatório que listasse o nome completo das pessoas a serem presenteadas (funcionários e dependentes), o sexo e a idade em anos completos (para poder comprar um presente adequado). Esse relatório deve estar ordenado pela idade em anos completos, de forma decrescente.

```sql
SELECT CONCAT(a.primeiro_nome,' ', a.nome_meio,' ', a.ultimo_nome) AS Nome, sexo as Sexo, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(a.data_nascimento))) as Idade
FROM funcionario as a
UNION
SELECT CONCAT(b.nome_dependente, ' ', a.ultimo_nome), b.sexo AS Sexo, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(b.data_nascimento))) AS Idade
FROM dependente b
INNER JOIN funcionario a ON (a.cpf = b.cpf_funcionario)
ORDER BY idade DESC;
````

<br/>

#### **QUESTÃO 14**: prepare um relatório que exiba quantos funcionários cada departamento tem.

```sql
SELECT a.numero_departamento, b.nome_departamento, COUNT(*) AS total_por_departamento 
FROM funcionario as a 
LEFT JOIN departamento as b on (a.numero_departamento = b.numero_departamento)
GROUP BY numero_departamento;
````

<br/>

#### **QUESTÃO 15**: como um funcionário pode estar alocado em mais de um projeto, prepare um relatório que exiba o nome completo do funcionário, o departamento desse funcionário e o nome dos projetos em que cada funcionário está alocado. Atenção: se houver algum funcionário que não está alocado em nenhum projeto, o nome completo e o departamento também devem aparecer no relatório.

```sql
SELECT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) as Funcionario, a.numero_departamento AS departamento, nome_projeto as Projeto_Alocado
FROM funcionario as a
INNER JOIN departamento b ON (a.numero_departamento = b.numero_departamento)
LEFT OUTER JOIN projeto c ON (b.numero_departamento = c.numero_departamento);
````

<br/>

---

## CONCLUSÃO

Achei este segundo PSET mais tranquilo do que o primeiro, tive um pouco de dificuldade no começo mas ao final já estava sabendo fazer tranquilamente, acredito que agora já possuo autonomia o suficiente para fazer os meus próprios comandos ```select```.

###### Tive que refazer 3 vezes esse Pset pois tive problemas com a Máquina Virtal (que fechou com todos os meus scripts enquanto estava fazendo) e com o GitHub (fui fazer o upload e apertei algo errado e ele deletou todos os meus arquivos) 😢😢😢

---

Até breve.

-Hian B :)
