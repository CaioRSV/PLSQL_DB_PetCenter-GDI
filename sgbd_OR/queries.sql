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



-------------------------- Procedures e Functions
--get_pessoa_endereco/get_pessoa_info
DECLARE
    pessoaEx pessoa_tp;
BEGIN
    SELECT VALUE(p) INTO pessoaEx FROM Pessoa p WHERE p.cpf='123456789-01';
	pessoaEx.get_pessoa_endereco;
	DBMS_OUTPUT.PUT_LINE('-----');
	pessoaEx.get_pessoa_info;
	DBMS_OUTPUT.PUT_LINE('-----');
END;
/
--Constructor Function DetalhesRaca
DECLARE
    detalhesRacaEx detalhesRaca_tp;
	racaEx VARCHAR2(50);
    especieEx VARCHAR2(50);
	
BEGIN
    racaEx := 'Cachorro';
	especieEx := 'Husky';
	detalhesRacaEx := detalhesRaca_tp(racaEx, especieEx);
	DBMS_OUTPUT.PUT_LINE('Raça: '|| detalhesRacaEx.raca || ' / Especie: ' || detalhesRacaEx.especie);
	COMMIT;
END;
/
--


-- compararIdadesPets
DECLARE
    pet1 pet_tp;
    pet2 pet_tp;
    result NUMBER;
BEGIN

    pet1 := pet_tp(null, 'Destruidor', null, TO_DATE('15/10/2023','DD-MM-YYYY'),  'Macho', 'Muito amigável', null);
    pet2 := pet_tp(null, 'Florzinha', null, TO_DATE('01/01/2023', 'DD-MM-YYYY'),  'Fêmea', 'Extremamente perigosa', null);

    result := pet1.compararIdadesPets(pet2);

    -- Use the result as needed
    DBMS_OUTPUT.PUT_LINE('O pet 2 é mais velho? (1 = Sim,  -1 = Não): ' || result);
END;
/

--calc_PrecoEstoque
DECLARE
    produto produto_tp;
    listaCaracteristicas caracteristicas_list := caracteristicas_list('caracteristica1', 'caracteristica2', 'caracteristica3');
    precoTotal NUMBER;

BEGIN
    produto := produto_tp('P#001','Osso de brinquedo', 40, 33, 'HappyPup', listaCaracteristicas, 'Brinquedos');
    precoTotal := produto.calc_PrecoEstoque();
    DBMS_OUTPUT.PUT_LINE('Preço total do estoque: ' || precoTotal);
END;
/

--equipValidadeRestante
DECLARE
	expectativaVidaRestante INTEGER;
	equipEx equipamento_tp;
BEGIN
	equipEx := equipamento_tp('E#001', 'Banheira', 'PetFurniture', 'Grande', TO_DATE('04/03/2023','DD-MM-YYYY'), 'Leve', 15, 100);
	expectativaVidaRestante := equipEx.equipValidadeRestante;
	DBMS_OUTPUT.PUT_LINE('Expectativa de vida restande do equipamento: '|| expectativaVidaRestante ||' dias.');
END;

/
    
--------------------- Resto de Consultas Individuais das Tabelas ---------------------

SELECT * FROM Endereco;
/
SELECT * FROM Telefone;
/
SELECT * FROM Pessoa;
/
SELECT nome, cargo FROM Funcionario;
/
SELECT nome, creditos FROM Cliente;
/
SELECT * FROM DetalhesRaca;
/
SELECT nome, observacoes FROM Pet;
/
SELECT metodo_pagamento FROM Atendimento;
/
SELECT codigo FROM Servico;
/
SELECT nome_Pet FROM Presta;
/
SELECT * FROM Produto;
/
SELECT * FROM Equipamento;
