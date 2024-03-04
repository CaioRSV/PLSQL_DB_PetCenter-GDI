--- Consulta com Update com REF
UPDATE Pet p SET p.cpf_Responsavel = (SELECT REF(R) FROM Pessoa R WHERE R.cpf='123456789-06') WHERE p.nome='Destruidor';

--- Consulta a PET e Pessoa, com DEREF
SELECT p.nome, DEREF(p.cpf_Responsavel).nome AS Novo_Responsavel FROM Pet p WHERE p.nome='Destruidor';

-- Consulta de Endereco

SELECT e.rua FROM Endereco e WHERE numero_residencia=1;

-- Telefone
SELECT numero FROM Telefone ORDER BY numero;

-- Selecionando informações sobre pessoas e seus números de telefone / Consulta a VARRAY
SELECT p.cpf, p.nome, p.data_de_nascimento, p.genero, t.numero FROM Pessoa p CROSS JOIN TABLE(p.telefones) t;

--- Consulta a VARRAY
SELECT t.numero FROM Pessoa p CROSS JOIN TABLE(p.telefones) t;

--Funcionário e seu supervisor
SELECT f.nome, DEREF(f.supervisor).nome FROM Funcionario f;

--Clientes com credito maior que 10 e seus endereços
SELECT c.nome, c.endereco.cidade FROM Cliente c; 

-- Pet (Selecionando nome dos animais e seus donos)
SELECT p.nome, DEREF(p.cpf_Responsavel).nome FROM Pet p;

--- Consulta a NESTED TABLE / Consulta a Características
SELECT c.column_value AS caracteristicas FROM Produto p CROSS JOIN TABLE(p.caracteristicas) c;
