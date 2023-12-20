-- ALTER TABLE
ALTER TABLE Endereco DROP COLUMN numero_residencia;

-- CREATE INDEX
CREATE INDEX idx_nomeEquipamento ON Equipamento(nome);

-- INSERT INTO
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-06', 'Chicken Little', 'De Combate', TO_DATE('10/01/2023', 'DD-MM-YYYY'), 'Macho', 'Pequeno');

-- UPDATE
UPDATE Pet SET observacoes = 'Altamente treinado' WHERE (cpf_Responsavel='123456789-06') AND (nome='Chicken Little');

-- DELETE
INSERT INTO DetalhesRaca(raca, especie) VALUES ('aaa', 'incognito');
DELETE FROM DetalhesRaca WHERE (raca='aaa');

-- SELECT-FROM-WHERE
SELECT * FROM DetalhesRaca WHERE especie = 'Cachorro';

-- BETWEEN
SELECT * FROM Cliente WHERE creditos BETWEEN 1 AND 20;

-- IN
SELECT * FROM DetalhesRaca WHERE especie IN ('Cachorro', 'Gato');

-- LIKE
SELECT * FROM Servico WHERE nome LIKE '%Terapia%';

-- NULL OU NOT NULL
SELECT * FROM Funcionario WHERE supervisor IS NULL;

SELECT * FROM Funcionario WHERE supervisor IS NOT NULL;

-- INNER JOIN 
SELECT f.email, f.cargo, a.data_atendimento, a.cpf_Cliente FROM (Funcionario f INNER JOIN  Atendimento a ON f.cpf = a.cpf_Funcionario);

-- MAX
SELECT cpf, creditos FROM Cliente WHERE creditos=(SELECT MAX(creditos) FROM Cliente);

-- MIN 
SELECT cpf, creditos FROM Cliente WHERE creditos=(SELECT MIN(creditos) FROM Cliente);

-- AVG
SELECT * FROM Produto WHERE preco>=(SELECT AVG(preco) FROM Produto); 

-- COUNT 
SELECT COUNT(*) FROM Funcionario WHERE supervisor='123456789-01';

-- LEFT ou RIGHT ou FULL OUTER JOIN (LEFT)
SELECT p.nome, t.numero FROM (Pessoa p LEFT JOIN Telefone t ON t.cpf=p.cpf);

-- SUBCONSULTA COM OPERADOR RELACIONAL
SELECT cpf, creditos FROM Cliente WHERE creditos=(SELECT MAX(creditos) FROM Cliente);

-- SUBCONSULTA COM IN
SELECT * FROM Pet WHERE raca IN (SELECT raca FROM DetalhesRaca WHERE especie IN ('Cachorro', 'Gato'));

-- SUBCONSULTA COM ANY
SELECT * FROM Pet WHERE raca = ANY (SELECT raca FROM DetalhesRaca WHERE especie IN ('Peixe', 'Galo'));

-- SUBCONSULTA COM ALL
SELECT * FROM Produto WHERE 0 < ALL (SELECT preco FROM Produto);

-- ORDER BY
SELECT nome FROM Pessoa ORDER BY nome;

-- GROUP BY
SELECT genero, COUNT(nome) FROM Pessoa GROUP BY genero;

-- HAVING
SELECT genero, COUNT(nome) FROM Pessoa GROUP BY genero HAVING COUNT(nome)>1;

-- UNION ou INTERSECT ou MINUS (UNION)
SELECT t.numero FROM (Pessoa p INNER JOIN Telefone t ON t.cpf = p.cpf) UNION (SELECT numero FROM Telefone);

-- CREATE VIEW
CREATE VIEW DadosFuncionarios AS (SELECT cpf, email, cargo FROM Funcionario);
SELECT * FROM DadosFuncionarios;

-------------------------------------------- PL ------------------------------------------------
-- RECORD
DECLARE
    rowDadosAtual Pessoa%ROWTYPE;
BEGIN
    SELECT * INTO rowDadosAtual FROM Pessoa WHERE nome='Fulano';
    DBMS_OUTPUT.PUT_LINE(rowDadosAtual.nome || ' - ' || rowDadosAtual.cpf);
END;

-- USO DE ESTRUTURA DE DADOS DO TIPO TABLE
DECLARE
    TYPE clientesDoMes IS TABLE OF VARCHAR2(50);
    clientesMes_Atual clientesDoMes := clientesDoMes('Cicrana', 'Rachel', 'Beltrene');
BEGIN 
    DBMS_OUTPUT.PUT_LINE(clientesMes_Atual(1));
	DBMS_OUTPUT.PUT_LINE(clientesMes_Atual(2));
	DBMS_OUTPUT.PUT_LINE(clientesMes_Atual(3));
END;

-- BLOCO ANÔNIMO

DECLARE
    varTeste VARCHAR2(50) := 'texto_Teste_abcdefghijklmnopqrstuvwxyz';
BEGIN 
    DBMS_OUTPUT.PUT_LINE(varTeste);
END;

-- CREATE PROCEDURE

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
DECLARE
    nomeCargo funcionario.cargo%TYPE;
BEGIN
    nomeCargo := 'cargoFicticio';
    DBMS_OUTPUT.PUT_LINE('Cargo aleatório: ' || nomeCargo);
END;
/

-- %ROWTYPE

DECLARE
    rowDadosAtual Pessoa%ROWTYPE;
BEGIN
    SELECT * INTO rowDadosAtual FROM Pessoa WHERE nome='Fulano';
    DBMS_OUTPUT.PUT_LINE(rowDadosAtual.nome || ' - ' || rowDadosAtual.cpf);
END;
/

-- IF ELSIF
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
DECLARE
	pessoaZeroCreditos VARCHAR2(50) := '';
BEGIN
	FOR clienteAtual IN (SELECT cpf, creditos FROM Cliente) LOOP
		pessoaZeroCreditos := clienteAtual.cpf;
    	EXIT WHEN clienteAtual.creditos = 0;
    END LOOP;

	DBMS_OUTPUT.PUT_LINE('CPF do cliente com zero créditos: ' || pessoaZeroCreditos);
END;

-- WHILE LOOP
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


-- FOR IN LOOP
BEGIN
	FOR clienteAtual IN (SELECT cpf, creditos FROM Cliente) LOOP
		DBMS_OUTPUT.PUT_LINE('CPF Cliente: ' || clienteAtual.cpf || ' // ' || 'Creditos do cliente: ' || clienteAtual.creditos);
    END LOOP;
END;

-- SELECT...INTO
DECLARE
    contador NUMBER := 0;
BEGIN
	SELECT COUNT(*) INTO contador FROM Pessoa;
	DBMS_OUTPUT.PUT_LINE('Quantidade de pessoas registradas: ' || contador);
END;

-- 



