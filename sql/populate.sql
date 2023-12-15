-- Endereço
INSERT INTO Endereco(cep, rua, bairro, cidade) VALUES ('55000-001', 'Rua1', 'Bairro1', 'Cidade1');

INSERT INTO Endereco(cep, rua, bairro, cidade) VALUES ('55000-002', 'Rua2', 'Bairro1', 'Cidade1');

INSERT INTO Endereco(cep, rua, bairro, cidade) VALUES ('55000-003', 'Rua2', 'Bairro2', 'Cidade1');

INSERT INTO Endereco(cep, rua, bairro, cidade) VALUES ('55000-004', 'Rua3', 'Bairro3', 'Cidade1');

INSERT INTO Endereco(cep, rua, bairro, cidade) VALUES ('55000-005', 'Rua4', 'Bairro4', 'Cidade2');

SELECT * FROM Endereco;

-- Pessoa

INSERT INTO Pessoa (cpf, nome, data_de_nascimento, genero, cep) VALUES ('123456789-01', 'Fulano', TO_DATE('01-01-2000', 'DD-MM-YYYY'), 'Homem', '55000-001');

INSERT INTO Pessoa (cpf, nome, data_de_nascimento, genero, cep) VALUES ('123456789-02', 'Cicrana', TO_DATE('01-01-1995', 'DD-MM-YYYY'), 'Mulher', '55000-002');

INSERT INTO Pessoa (cpf, nome, data_de_nascimento, genero, cep) VALUES ('123456789-03', 'Beltrana', TO_DATE('01-01-1990', 'DD-MM-YYYY'), 'Mulher', '55000-003');

SELECT * FROM Pessoa;

-- Telefone
INSERT INTO Telefone (cpf, numero) VALUES ('123456789-01', '35230001');
INSERT INTO Telefone (cpf, numero) VALUES ('123456789-02', '35230001');

SELECT * FROM Telefone;

-- Funcionário

INSERT INTO Funcionario (cpf, cargo, salario, email, senha, data_contratacao, supervisor) VALUES ('123456789-03', 'Gerente', 15000.01, 'beltrana@gov.br', '123', TO_DATE('01/02/2023', 'DD-MM-YYYY'), NULL);

INSERT INTO Funcionario (cpf, cargo, salario, email, senha, data_contratacao, supervisor) VALUES ('123456789-01', 'Veterinário', 5000.05, 'fulano.@gmail.com', '123', TO_DATE('05/03/2023', 'DD-MM-YYYY'), '123456789-03');



SELECT * FROM Funcionario;

-- Cliente
INSERT INTO Cliente (cpf, data_primeiro_atendimento, creditos) VALUES ('123456789-02', TO_DATE('01/08/2023', 'DD-MM-YYYY'), 50);

SELECT * FROM Cliente;

-- Detalhes Raça
INSERT INTO DetalhesRaca(raca, especie) VALUES ('Golden Retriever', 'Cachorro');
INSERT INTO DetalhesRaca(raca, especie) VALUES ('Pitbull', 'Cachorro');
INSERT INTO DetalhesRaca(raca, especie) VALUES ('Persa', 'Gato');
INSERT INTO DetalhesRaca(raca, especie) VALUES ('De Combate', 'Galo');

SELECT * FROM DetalhesRaca;

-- Pet
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-02', 'Destruidor', 'Pitbull', TO_DATE('20/01/2023', 'DD-MM-YYYY'), 'Macho', 'Muito amigável');
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-02', 'Florzinha', 'Golden Retriever', TO_DATE('01/01/2023', 'DD-MM-YYYY'), 'Fêmea', 'Extremamente perigosa');

SELECT * FROM Pet;

-- Atendimento
INSERT INTO Atendimento (cpf_Cliente, data_atendimento, cpf_Funcionario, custo_total, metodo_pagamento) VALUES ('123456789-02', TO_DATE('15/10/2023','DD-MM-YYYY'), '123456789-01', 500, 'Pix');

SELECT * FROM Atendimento;

-- Atendimento
INSERT INTO Servico (codigo, nome, descricao, custo, cpf_Cliente, data_atendimento) VALUES ('S#001', 'Tosa', 'Tosa fi passar máquina no pelo', 300, '123456789-02', TO_DATE('15/10/2023', 'DD-MM-YYYY'));

SELECT * FROM Servico;

-- Produto
INSERT INTO Produto (id, nome, preco, quantidade, categoria, marca, caracteristicas) VALUES ('P#001', 'Osso de brinquedo', 40, 33, 'Brinquedos', 'HappyPup', 'Tamanho médio');

SELECT * FROM Produto;

-- Produto
INSERT INTO Equipamento (id, nome, marca, observacoes, data_aquisicao, grau_desgaste, quantidade_usos, vida_util) VALUES ('E#001', 'Banheira', 'PetFurniture', 'Grande', TO_DATE('04/03/2023','DD-MM-YYYY'), 'Leve', 15, 1000);

SELECT * FROM Equipamento;

-- Produto
INSERT INTO Presta (cpf_Cliente, nome_Pet, codigo_Servico, cpf_Funcionario) VALUES ('123456789-02', 'Florzinha', 'S#001', '123456789-01');

SELECT * FROM Presta;

-- Vende
INSERT INTO Vende (cpf_Cliente, data_atendimento, id_Produto) VALUES ('123456789-02', TO_DATE('15/10/2023','DD-MM-YYYY'), 'P#001');

SELECT * FROM Vende;

