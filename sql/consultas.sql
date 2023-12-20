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

-- 
