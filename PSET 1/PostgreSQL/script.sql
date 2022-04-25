/* CRIAÇÃO DO USUARIO E DA DATABASE */

/*criação do usuario 'hian' com a senha '123'*/

create role hian with createdb password '123'; 	

/*criação da database uvv*/

create database uvv 
    with owner = hian
    template = template0
    encoding = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    allow_connections = true
    ;

    \c uvv;

/*criação do schema elmasri*/



CREATE SCHEMA elmasri AUTHORIZATION hian;

SET SEARCH_PATH TO elmasri, "$user", public;

SHOW SEARCH_PATH;

ALTER USER hian SET SEARCH_PATH TO elmasri, "$user", public;

/*CRIAÇÃO DAS TABELAS */

/*criação da tabela funcionarios*/

CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT const_funcionario_pk PRIMARY KEY (cpf)
);

/*comentários e descrições da tabela funcionários*/
COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário.';

/*criação da tabela departamentos*/
CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11),
                data_inicio_gerente DATE,
                CONSTRAINT const_departamento PRIMARY KEY (numero_departamento)
);

/*comentários e descrição da tabela departamentos*/
COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

/*criação da tabela projetos*/
CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT const_projeto PRIMARY KEY (numero_projeto)
);

/*comentários e descrição da tabela projetos*/
COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';


CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

/*criação da tabela de localizações dos departamentos*/
CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT const_localizacoes_departamento PRIMARY KEY (numero_departamento, local)
);

/*comentários e descrição da tabela de localização dos departamentos*/
COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';

/*criação da tabela de local do trabalho do funcionário*/
CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1),
                CONSTRAINT const_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto)
);

/*comentários e descrição da tabela de local do trabalho do funcionário*/
COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';

/*criação da tabela de dependentes do funcionário*/
CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT cont_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);

/*comentários e descrição da tabela de dependetes do funcionário*/
COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';

/*criação dos relacionamentos entre as tabelas*/
ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk1
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/* INSERÇÃO DE DADOS */

/*departamentos s/ cpf do gerente*/
insert into elmasri.departamento (nome_departamento,numero_departamento,data_inicio_gerente)
values ('Pesquisa',5,'1988-05-22');

insert into elmasri.departamento (nome_departamento,numero_departamento,data_inicio_gerente)
values ('Administração',4,'1995-01-01');

insert into elmasri.departamento (nome_departamento,numero_departamento,data_inicio_gerente)
values ('Matriz',1,'1981-06-19');

/*funcionários*/
insert into elmasri.funcionario (cpf,primeiro_nome,nome_meio,ultimo_nome,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento)
values (88866555576,'Jorge','E','Brito','1937-11-10','Rua do Horto,35, São Paulo, SP','M',55000.00,NULL,1);

insert into elmasri.funcionario (cpf,primeiro_nome,nome_meio,ultimo_nome,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento)
values (33344555587, 'Fernando','T','Wong','1955-12-08','Rua da Lapa, 34, São Paulo, SP','M',40000.00,88866555576,5);

insert into elmasri.funcionario (cpf,primeiro_nome,nome_meio,ultimo_nome,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento)
values (98765432168,'Jennifer','S','Souza','1941-06-20','Av. Arthur de Lima, 54, Santo André, SP','F',43000.00,88866555576,4);

insert into elmasri.funcionario (cpf,primeiro_nome,nome_meio,ultimo_nome,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento)
values (12345678966,'João','B','Silva','09-01-1965','Rua das Flores 751 São Paulo SP', 'M', 30000.00, 33344555587,5);

insert into elmasri.funcionario (cpf,primeiro_nome,nome_meio,ultimo_nome,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento)
values (45345345376,'Joice','A','Leite','1972-07-31','Av. Lucas Obes, 74, São Paulo, SP','F',25000.00,33344555587,5);

insert into elmasri.funcionario (cpf,primeiro_nome,nome_meio,ultimo_nome,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento)
values (66688444476,'Ronaldo','K','Lima','1962-09-15','Rua Rebouças, 65, Piracicaba, SP','M',38000.00,33344555587,5);

insert into elmasri.funcionario (cpf,primeiro_nome,nome_meio,ultimo_nome,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento)
values (99999777767, 'Alice','J','Zelaya','1968-01-19','Rua Souza Lima, 35, Curitiba, PR','F',25000.00,98765432168,4);

insert into elmasri.funcionario (cpf,primeiro_nome,nome_meio,ultimo_nome,data_nascimento,endereco,sexo,salario,cpf_supervisor,numero_departamento)
values (98798798733,'André','V','Pereira','1969-03-29','Rua Timbira, 35, São Paulo, SP','M',25000.00,98765432168,4);

/*inserção do cpf do gerente na tabela de departamentos*/
update elmasri.departamento set cpf_gerente='33344555587' where numero_departamento=1;

update elmasri.departamento set cpf_gerente='98765432168' where numero_departamento=4;

update elmasri.departamento set cpf_gerente='88866555576' where numero_departamento=5;

/*localização dos departamentos*/
insert into elmasri.localizacoes_departamento (numero_departamento,local)
values (1,'São Paulo');

insert into elmasri.localizacoes_departamento (numero_departamento,local)
values (4,'Mauá');

insert into elmasri.localizacoes_departamento (numero_departamento,local)
values (5,'Itu');

insert into elmasri.localizacoes_departamento (numero_departamento,local)
values (5,'Santo André');

insert into elmasri.localizacoes_departamento (numero_departamento,local)
values (5,'São Paulo');

/*projetos*/
insert into elmasri.projeto (nome_projeto,numero_projeto,local_projeto,numero_departamento)
values ('ProdutoX',1,'Santo André',5);

insert into elmasri.projeto (nome_projeto,numero_projeto,local_projeto,numero_departamento)
values ('ProdutoY',2,'Itu',5);

insert into elmasri.projeto (nome_projeto,numero_projeto,local_projeto,numero_departamento)
values ('ProdutoZ',3,'São Paulo',5);

insert into elmasri.projeto (nome_projeto,numero_projeto,local_projeto,numero_departamento)
values ('Informatização',10,'Mauá',4);

insert into elmasri.projeto (nome_projeto,numero_projeto,local_projeto,numero_departamento)
values ('Reorganização',20,'São Paulo',1);

insert into elmasri.projeto (nome_projeto,numero_projeto,local_projeto,numero_departamento)
values ('Novosbenefícios',30,'Mauá',4);

/*dependentes*/
insert into elmasri.dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco)
values(33344555587,'Alicia','F','1986-04-05','Filha');

insert into elmasri.dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco)
values(33344555587,'Tiago','M','1983-10-25','Filho');

insert into elmasri.dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco)
values(33344555587,'Janaína','F','1958-05-03','Esposa');

insert into elmasri.dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco)
values(98765432168,'Antonio','M','1942-02-28','Marido');

insert into elmasri.dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco)
values(12345678966,'Michel','M','1988-01-04','Filho');

insert into elmasri.dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco)
values(12345678966,'Alicia','F','1988-12-30','Filha');

insert into elmasri.dependente (cpf_funcionario,nome_dependente,sexo,data_nascimento,parentesco)
values(12345678966,'Elizabeth','F','1967-05-05','Esposa');

/*trabalha em*/
insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (12345678966,1,32.5);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (12345678966,2,7.5);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (66688444476,3,40.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (45345345376,1,20.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (45345345376,2,20.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (33344555587,2,10.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (33344555587,3,10.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (33344555587,10,10.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (33344555587,20,10.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (98798798733,10,35.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (98798798733,30,5.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (98765432168,30,20.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (98765432168,20,15.0);

insert into elmasri.trabalha_em (cpf_funcionario,numero_projeto,horas)
values (88866555576,20,NULL);

/*fim*/
