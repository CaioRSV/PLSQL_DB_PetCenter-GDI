-- ALTER TABLE
	-- Retira endereço da tabela Endereo
ALTER TABLE Endereco DROP COLUMN numero_residencia;

-- CREATE INDEX
	-- Cria index para melhor consulta de não-primary key
CREATE INDEX idx_nomeEquipamento ON Equipamento(nome);

-- INSERT INTO
	-- Popula Pet com uma Row
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-06', 'Chicken Little', 'De Combate', TO_DATE('10/01/2023', 'DD-MM-YYYY'), 'Macho', 'Pequeno');

-- UPDATE
	-- Atualiza uma row de Pet
UPDATE Pet SET observacoes = 'Altamente treinado' WHERE (cpf_Responsavel='123456789-06') AND (nome='Chicken Little');

-- DELETE
	-- Inserta e deleta uma row
INSERT INTO DetalhesRaca(raca, especie) VALUES ('aaa', 'incognito');
DELETE FROM DetalhesRaca WHERE (raca='aaa');

-- SELECT-FROM-WHERE
	-- Seleciona todas rows que tem espécie cachorro
SELECT * FROM DetalhesRaca WHERE especie = 'Cachorro';

-- BETWEEN
	-- Pega rows de cliente com 1<creditos<20
SELECT * FROM Cliente WHERE creditos BETWEEN 1 AND 20;

-- IN
	-- Select com verificação se algum atributo está na lista
SELECT * FROM DetalhesRaca WHERE especie IN ('Cachorro', 'Gato');

-- LIKE
	-- Verifica se algum atributo tem algum texto
SELECT * FROM Servico WHERE nome LIKE '%Terapia%';

-- NULL OU NOT NULL
	-- Verifica se algum atributo é nulo ou não
SELECT * FROM Funcionario WHERE supervisor IS NULL;

SELECT * FROM Funcionario WHERE supervisor IS NOT NULL;

-- INNER JOIN 
	-- Seleciona com interseção de tabelas (inner join) dados de funcionários e de atendimento
SELECT f.email, f.cargo, a.data_atendimento, a.cpf_Cliente FROM (Funcionario f INNER JOIN  Atendimento a ON f.cpf = a.cpf_Funcionario);

-- MAX
	-- Pega row onde o valor de creditos é o maior da tabela
SELECT cpf, creditos FROM Cliente WHERE creditos=(SELECT MAX(creditos) FROM Cliente);

-- MIN 
	-- Pega row onde o valor de creditos é o menor da tabela
SELECT cpf, creditos FROM Cliente WHERE creditos=(SELECT MIN(creditos) FROM Cliente);

-- AVG
	-- Pega rows que o preço é maior que a média de preços da tabela
SELECT * FROM Produto WHERE preco>=(SELECT AVG(preco) FROM Produto); 

-- COUNT 
	-- Conta quantidade de funcionários com certo supervisor
SELECT COUNT(*) FROM Funcionario WHERE supervisor='123456789-01';

-- LEFT ou RIGHT ou FULL OUTER JOIN (RIGHT)
	-- Pega dados de pessoas e seus telefones, mas só das que tem telefones
SELECT p.nome, t.numero FROM (Pessoa p RIGHT JOIN Telefone t ON t.cpf=p.cpf);

-- SUBCONSULTA COM OPERADOR RELACIONAL
	-- Com subconsulta SELECT dentro aí q pega row do Cliente com maior n° de créditos
SELECT cpf, creditos FROM Cliente WHERE creditos=(SELECT MAX(creditos) FROM Cliente);

-- SUBCONSULTA COM IN
	-- Com subconsulta com IN e outro SELECT pra pegar Pets que estão inseridos na tupla
SELECT * FROM Pet WHERE raca IN (SELECT raca FROM DetalhesRaca WHERE especie IN ('Cachorro', 'Gato'));

-- SUBCONSULTA COM ANY
	-- Consulta com raça estando em qualquer row da sunconsulta que verifica se o Pet tem espécie dentro da tupla
SELECT * FROM Pet WHERE raca = ANY (SELECT raca FROM DetalhesRaca WHERE especie IN ('Peixe', 'Galo'));

-- SUBCONSULTA COM ALL
	-- Consulta rows de Produto apenas se todos os produtos tiverem preço > 0
SELECT * FROM Produto WHERE 0 < ALL (SELECT preco FROM Produto);

-- ORDER BY
	-- Pega rows ordenadas pelo nome
SELECT nome FROM Pessoa ORDER BY nome;

-- GROUP BY
	-- Utiliza uma função (count) para separar informações agrupadas por alguma semelhança de atributo das rows (genero)
SELECT genero, COUNT(nome) FROM Pessoa GROUP BY genero;

-- HAVING
	-- Selecionando rows que tenham algum atributo (genero) selecionado por alguma função (count(nome))
SELECT genero, COUNT(nome) FROM Pessoa GROUP BY genero HAVING COUNT(nome)>1;

-- UNION ou INTERSECT ou MINUS (UNION)
	-- Une duas tabelas só que exclui duplicatas de info
SELECT t.numero FROM (Pessoa p INNER JOIN Telefone t ON t.cpf = p.cpf) UNION (SELECT numero FROM Telefone);

-- CREATE VIEW
	-- Seleciona uma view (tipo definindo um SELECT como um Objeto, vc podendo consultar essa view como uma tabela praticamente)
CREATE VIEW DadosFuncionarios AS (SELECT cpf, email, cargo FROM Funcionario);
SELECT * FROM DadosFuncionarios;
/
-------------------------------------------- PL ------------------------------------------------
-- RECORD
	-- Armazena algum tipo de dado dinamico ai
DECLARE
    rowDadosAtual Pessoa%ROWTYPE;
BEGIN
    SELECT * INTO rowDadosAtual FROM Pessoa WHERE nome='Fulano';
    DBMS_OUTPUT.PUT_LINE(rowDadosAtual.nome || ' - ' || rowDadosAtual.cpf);
END;
/
-- USO DE ESTRUTURA DE DADOS DO TIPO TABLE
	-- Cria tipo table e printa itens inseridos na definição de uma instância dele
DECLARE
    TYPE clientesDoMes IS TABLE OF VARCHAR2(50);
    clientesMes_Atual clientesDoMes := clientesDoMes('Cicrana', 'Rachel', 'Beltrene');
BEGIN 
    DBMS_OUTPUT.PUT_LINE(clientesMes_Atual(1));
	DBMS_OUTPUT.PUT_LINE(clientesMes_Atual(2));
	DBMS_OUTPUT.PUT_LINE(clientesMes_Atual(3));
END;
/
-- BLOCO ANÔNIMO
	-- Uso de Declare e Begin pra printar um texto qualquer
DECLARE
    varTeste VARCHAR2(50) := 'texto_Teste_abcdefghijklmnopqrstuvwxyz';
BEGIN 
    DBMS_OUTPUT.PUT_LINE(varTeste);
END;
/
-- CREATE PROCEDURE
	-- Cria procedimento que mostra maior preço de um produto
CREATE OR REPLACE PROCEDURE mostrarMaiorPreco
IS
    resultVar NUMBER := 0;

BEGIN
    SELECT MAX(preco) INTO resultVar FROM Produto;

    DBMS_OUTPUT.PUT_LINE('Produto com o maior preço: ' || resultVar);
END;
/
BEGIN
	mostrarMaiorPreco();
END;
/
-- CREATE FUNCTION
	-- Cria função que mostra menor preço de um produto
CREATE OR REPLACE FUNCTION mostrarMenorPreco RETURN NUMBER
IS
    resultVar NUMBER := 0;
BEGIN
    SELECT MIN(preco) INTO resultVar FROM Produto;
    RETURN resultVar;
END;
/
DECLARE
    menorPreco NUMBER;
BEGIN
    menorPreco := mostrarMenorPreco();
    DBMS_OUTPUT.PUT_LINE('Produto com o menor preço: ' || menorPreco);
END;
/
-- %TYPE
	-- VAR se adapta ao tipo estabelecido dps, printa cargo
DECLARE
    nomeCargo funcionario.cargo%TYPE;
BEGIN
    nomeCargo := 'cargoFicticio';
    DBMS_OUTPUT.PUT_LINE('Cargo aleatório: ' || nomeCargo);
END;
/

-- %ROWTYPE
	-- VAR se adapta ao tipo da ROW referenciada, printa dados de Pessoa com nome 'Fulano'
DECLARE
    rowDadosAtual Pessoa%ROWTYPE;
BEGIN
    SELECT * INTO rowDadosAtual FROM Pessoa WHERE nome='Fulano';
    DBMS_OUTPUT.PUT_LINE(rowDadosAtual.nome || ' - ' || rowDadosAtual.cpf);
END;
/

-- IF ELSIF
	-- Condicionais, utiliza para verificar se AVG do preço é >=50, <50 e >0, ou <0
CREATE OR REPLACE PROCEDURE analisarPrecoMedio
IS
    resultVar NUMBER := 0;
BEGIN
    SELECT AVG(preco) INTO resultVar FROM Produto;
    IF resultVar>=50 THEN
        DBMS_OUTPUT.PUT_LINE('Média maior ou igual a 50');
    ELSIF (resultVar>0) AND (resultVar<50) THEN
        DBMS_OUTPUT.PUT_LINE('Média menor que 50');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Algo está errado. A média de preços é igual ou menor a 0.');
    END IF;
END;
/
BEGIN
    analisarPrecoMedio();
END;
/

-- CASE WHEN
	-- Condicionais dnv só que com case when, utiliza para verificar se AVG do preço é >=30, <30 e >0, ou <0.
CREATE OR REPLACE PROCEDURE analisarPrecoMedio_VersaoCase
IS
    resultVar NUMBER := 0;
BEGIN
    SELECT AVG(preco) INTO resultVar FROM Produto;
	CASE
        WHEN resultVar>=30 THEN
        	DBMS_OUTPUT.PUT_LINE('Média maior ou igual a 30');
    	WHEN (resultVar>0) AND (resultVar<30) THEN
        	DBMS_OUTPUT.PUT_LINE('Média menor que 30');
		ELSE
            DBMS_OUTPUT.PUT_LINE('Algo está errado. A média de preços é igual ou menor a 0.');
    END CASE;
END;
/
BEGIN
    analisarPrecoMedio_VersaoCase();
END;
/

--  LOOP EXIT WHEN
	-- Condicional break loop, para quando encontra algué com zero créditos
DECLARE
	pessoaZeroCreditos VARCHAR2(50) := '';
BEGIN
	FOR clienteAtual IN (SELECT cpf, creditos FROM Cliente) LOOP
		pessoaZeroCreditos := clienteAtual.cpf;
    	EXIT WHEN clienteAtual.creditos = 0;
    END LOOP;

	DBMS_OUTPUT.PUT_LINE('CPF do cliente com zero créditos: ' || pessoaZeroCreditos);
END;
/
-- WHILE LOOP
	-- Loop WHILE, verifica se os Pets são ou não cachorros
DECLARE
    contador NUMBER := 1;
    especieDaVez DetalhesRaca.especie%TYPE;
    lenDetalhesRaca NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO lenDetalhesRaca FROM DetalhesRaca;
    WHILE contador <= lenDetalhesRaca LOOP
        SELECT especie INTO especieDaVez FROM (SELECT especie, ROWNUM AS rn FROM DetalhesRaca) WHERE rn = contador;

        IF especieDaVez = 'Cachorro' THEN
            DBMS_OUTPUT.PUT_LINE('O número ' || contador || ' é cachorro!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('O número ' || contador || ' não é cachorro...');
        END IF;

        contador := contador + 1;
    END LOOP;
END;

/
-- FOR IN LOOP
	-- Loop FOR, printa dados de clientes
BEGIN
	FOR clienteAtual IN (SELECT cpf, creditos FROM Cliente) LOOP
		DBMS_OUTPUT.PUT_LINE('CPF Cliente: ' || clienteAtual.cpf || ' // ' || 'Creditos do cliente: ' || clienteAtual.creditos);
    END LOOP;
END;
/
-- SELECT...INTO
	-- SELECT armazenando em VAR definida antes, conta quantidade de rows de Pessoa
DECLARE
    contador NUMBER := 0;
BEGIN
	SELECT COUNT(*) INTO contador FROM Pessoa;
	DBMS_OUTPUT.PUT_LINE('Quantidade de pessoas registradas: ' || contador);
END;
/
-- CURSOR (OPEN, FETCH e CLOSE)
	-- Utilizando cursor, permite abrir ele e dar fetch nos valroes selecionados nas VARs definidas, printa dados de Pet
DECLARE
    CURSOR cursorPets IS 
        SELECT cpf_Responsavel, nome, raca FROM Pet; 

    varCPF Pet.cpf_Responsavel%TYPE; 
    varNome Pet.nome%TYPE; 
    varRaca Pet.raca%TYPE;
 
BEGIN 
    OPEN cursorPets; 
        FETCH cursorPets INTO varCPF, varNome, varRaca; 
 
        DBMS_OUTPUT.PUT_LINE(varCPF || ' - ' || varNome || ' - ' || varRaca); 
    CLOSE cursorPets; 
END;
/
-- EXCEPTION WHEN
	-- Verifica se certo erro/exception aconteceu (ter cpf nulo), e printa algo caso sim
DECLARE
    resultVar VARCHAR2(50) := '';
BEGIN
	SELECT nome INTO resultVar FROM Pessoa WHERE cpf IS NULL;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Não existem Pessoas com CPF nulo');
        WHEN OTHERS THEN
        	DBMS_OUTPUT.PUT_LINE('Qualquer outro erro');
END;
/
-- USO DE PAR METROS (IN, OUT ou IN OUT) / CREATE OR REPLACE PACKAGE / CREATE OR REPLACE PACKAGE BODY
	-- Cria package e package body, com utilização de parametros de procedures por meio de IN
	-- Funções: Uma mostra o maior preço que seja maior que algum parametro x, e a outra analisa o preço médio e printa baseado em condicionais
CREATE OR REPLACE PACKAGE GrupaoProcedures AS
    PROCEDURE mostrarMaiorPreco_MaiorQue (x IN NUMBER);
    PROCEDURE analisarPrecoMedio;
END GrupaoProcedures;
/

CREATE OR REPLACE PACKAGE BODY GrupaoProcedures AS
    PROCEDURE mostrarMaiorPreco_MaiorQue(x IN NUMBER) IS
        resultVar NUMBER := 0;
    BEGIN
        SELECT MAX(preco) INTO resultVar FROM Produto WHERE preco>x;
        DBMS_OUTPUT.PUT_LINE('Produto com o maior preço: ' || resultVar);
    END mostrarMaiorPreco_MaiorQue;

    PROCEDURE analisarPrecoMedio IS
        resultVar NUMBER := 0;
    BEGIN
        SELECT AVG(preco) INTO resultVar FROM Produto;
        IF resultVar >= 50 THEN
            DBMS_OUTPUT.PUT_LINE('Média maior ou igual a 50');
        ELSIF resultVar > 0 AND resultVar < 50 THEN
            DBMS_OUTPUT.PUT_LINE('Média menor que 50');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Algo está errado. A média de preços é igual ou menor a 0.');
        END IF;
    END analisarPrecoMedio;
END GrupaoProcedures;
/
BEGIN
	GrupaoProcedures.mostrarMaiorPreco_MaiorQue(150);
	GrupaoProcedures.analisarPrecoMedio();
END;
/
-- CREATE OR REPLACE TRIGGER (COMANDO) / CREATE OR REPLACE TRIGGER (LINHA)
	-- Cria triggers que sinalizam quando teve um insert em equipamento e que autopreenche alguns dados de algum insert
CREATE OR REPLACE TRIGGER autodefinirStatusEquipamento
BEFORE INSERT ON Equipamento
BEGIN
	DBMS_OUTPUT.PUT_LINE('Novo equipamento adicionado!');
END;
/

CREATE OR REPLACE TRIGGER  autodefinirDataEquipamento
BEFORE INSERT ON Equipamento
FOR EACH ROW
BEGIN
	:NEW.data_aquisicao := SYSDATE;
	:NEW.grau_desgaste := 'Nenhum';
	:NEW.quantidade_usos := 0;
END;
/

	-- Ilustrando triggers com selects
SELECT * FROM Equipamento;

INSERT INTO Equipamento (id, nome, marca, observacoes, vida_util) VALUES ('E#-1', '?', '?', '?', NULL);

SELECT * FROM Equipamento;
