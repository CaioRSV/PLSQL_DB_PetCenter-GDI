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

INSERT INTO Pessoa (cpf, nome, data_de_nascimento, genero, cep) VALUES ('123456789-05', 'Rachel', TO_DATE('17-07-1997', 'DD-MM-YYYY'), 'Mulher', '55000-005');

INSERT INTO Pessoa (cpf, nome, data_de_nascimento, genero, cep) VALUES ('123456789-04', 'Higgins', TO_DATE('11-03-1999', 'DD-MM-YYYY'), 'Homem', '55000-004');

SELECT * FROM Pessoa;

-- Telefone
INSERT INTO Telefone (cpf, numero) VALUES ('123456789-01', '35230001');
INSERT INTO Telefone (cpf, numero) VALUES ('123456789-02', '35230001');
INSERT INTO Telefone (cpf, numero) VALUES ('123456789-03', '33330000');
INSERT INTO Telefone (cpf, numero) VALUES ('123456789-04', '44440000');
INSERT INTO Telefone (cpf, numero) VALUES ('123456789-05', '55550000');

SELECT * FROM Telefone;

-- Funcionário

INSERT INTO Funcionario (cpf, cargo, salario, email, senha, data_contratacao, supervisor) VALUES ('123456789-03', 'Gerente', 15000.01, 'beltrana@gov.br', '123', TO_DATE('01/02/2023', 'DD-MM-YYYY'), NULL);

INSERT INTO Funcionario (cpf, cargo, salario, email, senha, data_contratacao, supervisor) VALUES ('123456789-01', 'Veterinário', 5000.05, 'fulano.@gmail.com', '123', TO_DATE('05/03/2023', 'DD-MM-YYYY'), '123456789-03');

INSERT INTO Funcionario (cpf, cargo, salario, email, senha, data_contratacao, supervisor) VALUES ('123456789-04', 'Vendedor', 1300.00, 'higgins.@gmail.com', '123', TO_DATE('07/03/2023', 'DD-MM-YYYY'), '123456789-04');

SELECT * FROM Funcionario;

-- Cliente

INSERT INTO Cliente (cpf, data_primeiro_atendimento, creditos) VALUES ('123456789-02', TO_DATE('01/08/2023', 'DD-MM-YYYY'), 50);

INSERT INTO Cliente (cpf, data_primeiro_atendimento, creditos) VALUES ('123456789-05', TO_DATE('05/07/2023', 'DD-MM-YYYY'), 15);

SELECT * FROM Cliente;

-- Detalhes Raça
INSERT INTO DetalhesRaca(raca, especie) VALUES ('Golden Retriever', 'Cachorro');
INSERT INTO DetalhesRaca(raca, especie) VALUES ('Pitbull', 'Cachorro');
INSERT INTO DetalhesRaca(raca, especie) VALUES ('Persa', 'Gato');
INSERT INTO DetalhesRaca(raca, especie) VALUES ('De Combate', 'Galo');
INSERT INTO DetalhesRaca(raca, especie) VALUES ('Tucunaré', 'Peixe');

SELECT * FROM DetalhesRaca;

-- Pet
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-02', 'Destruidor', 'Pitbull', TO_DATE('20/01/2023', 'DD-MM-YYYY'), 'Macho', 'Muito amigável');
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-02', 'Florzinha', 'Golden Retriever', TO_DATE('01/01/2023', 'DD-MM-YYYY'), 'Fêmea', 'Extremamente perigosa');
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-05', 'Alpha', 'Tucunaré', TO_DATE('01/05/2023', 'DD-MM-YYYY'), 'Macho', 'Extremamente perigoso');
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-05', 'Beta', 'Tucunaré', TO_DATE('01/05/2023', 'DD-MM-YYYY'), 'Macho', 'Muito Amigavel');
INSERT INTO Pet (cpf_Responsavel, nome, raca, data_nascimento, genero, observacoes) VALUES ('123456789-05', 'Sigma', 'Tucunaré', TO_DATE('01/05/2023', 'DD-MM-YYYY'), 'Macho', 'Extremamente perigoso');

SELECT * FROM Pet;

-- Atendimento
INSERT INTO Atendimento (cpf_Cliente, data_atendimento, cpf_Funcionario, custo_total, metodo_pagamento) VALUES ('123456789-02', TO_DATE('15/10/2023','DD-MM-YYYY'), '123456789-01', 500, 'Pix');

SELECT * FROM Atendimento;

-- Atendimento
INSERT INTO Servico (codigo, nome, descricao, custo, cpf_Cliente, data_atendimento) VALUES ('S#001', 'Tosa', 'Tosa fi passar máquina no pelo', 300, '123456789-02', TO_DATE('15/10/2023', 'DD-MM-YYYY'));

SELECT * FROM Servico;

-- Produto
INSERT INTO Produto (id, nome, preco, quantidade, categoria, marca, caracteristicas) VALUES ('P#001', 'Osso de brinquedo', 40, 33, 'Brinquedos', 'HappyPup', 'Tamanho médio');
INSERT INTO Produto (id, nome, preco, quantidade, categoria, marca, caracteristicas) VALUES ('P#002', 'Arranhador', 189, 7, 'Brinquedos', 'HappyPup', 'Tamanho médio');
INSERT INTO Produto (id, nome, preco, quantidade, categoria, marca, caracteristicas) VALUES ('P#003', 'Bolinha de silicone', 7, 52, 'Brinquedos', 'HappyPup', 'Rosa');
INSERT INTO Produto (id, nome, preco, quantidade, categoria, marca, caracteristicas) VALUES ('P#004', 'chocalho', 15, 38, 'Brinquedos', 'HappyPup', 'Tamanho pequeno');
INSERT INTO Produto (id, nome, preco, quantidade, categoria, marca, caracteristicas) VALUES ('P#005', 'Puleiro', 17, 5, 'Brinquedos', 'HappyPup', 'Tamanho médio');

SELECT * FROM Produto;

-- Equipamento
INSERT INTO Equipamento (id, nome, marca, observacoes, data_aquisicao, grau_desgaste, quantidade_usos, vida_util) VALUES ('E#001', 'Banheira', 'PetFurniture', 'Grande', TO_DATE('04/03/2023','DD-MM-YYYY'), 'Leve', 15, 1000);

SELECT * FROM Equipamento;

-- Produto
INSERT INTO Presta (cpf_Cliente, nome_Pet, codigo_Servico, cpf_Funcionario) VALUES ('123456789-02', 'Florzinha', 'S#001', '123456789-01');

SELECT * FROM Presta;

-- Vende
INSERT INTO Vende (cpf_Cliente, data_atendimento, id_Produto) VALUES ('123456789-02', TO_DATE('15/10/2023','DD-MM-YYYY'), 'P#001');

SELECT * FROM Vende;