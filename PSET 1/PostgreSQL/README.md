## PSET 1
### Hian Pertel Boone - SI1N    

---

## POSTGRESQL

---

Para visualizar a implementação no PostgreSQL você deve copiar todo o script no arquivo `script.sql` e executar.

Há uma pasta chamada Dados, que contém todos os dados implementados em seus respectivos códigos, mas não se preocupe, pois o script já insere os dados automaticamente.

Caso você goste ou queira, é possível ler o arquivo do script! ele está comentado por sessões o que aquela sequencia de código ira executar.

---

### COMO EXECUTAR NO pgAdmin 4

1. Você deve criar um novo servidor.
2. Você selecionará a database 'postgres' e abrirá o PSQL TOOL (grifado em verde), que fica localizado ao lado de properties.
3. Você deve copiar todo o texto do arquivo de script.
4. Assim que você colar ele pedirá uma permissão e você deve permitir.
5. Quando for permitido, ele automaticamente começará a rodar o script, assim que terminar, de um refresh em 'databases' e pronto.

Ao final ele deve aparecer desta forma:
![](../etc/imagens%20md/psql_script.png)

---
#### Processamento

1. O SGBD irá criar um usuário 'hian' com a senha '123'.
2. O SGBD criará e selecionará o Banco de Dados 'uvv'.
3. O SGBD criará o esquema 'elmasri'.
4. O SGBD irá selecionar o esquema 'elmasri' e altera-lo para que as linhas de código sejam executadas nele e não no esquema 'public'.
5. O SGBD Criará as tabelas em sequência, com suas respectivas colunas e respectivos comentários e descrições.
6. O SGBD limitará os relacionamentos e valores as informações da tabala.
7. O SGBD irá preencher os dados.

---

##### RECOMENDADO UTILIZAR APENAS O **pgAdmin 4** PARA EXECUÇÃO!!!!

###### O postgreSQL não possui um comando equivalente a `use` para trocar a database por si só, o unico que possui é o psql, que tem o comando `\c <databasename>`, a principio ele funciona perfeitamente no pgAdmin, por isso solicito que utilize o mesmo na hora de executar o script.

###### FONTES: [1°](https://stackoverflow.com/questions/10335561/use-database-name-command-in-postgresql), [2°](https://stackoverflow.com/questions/3909123/how-to-indicate-in-postgresql-command-in-which-database-to-execute-a-script-si), [3°](https://stackoverflow.com/a/3909992).

###### Eu testei e revisei o script inúmeras vezes, então é bem provável que não ocorra nenhum erro na execução.