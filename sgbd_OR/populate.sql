-- Endereço
INSERT INTO Endereco VALUES (endereco_tp('55000-001', 'Rua1', 'Bairro1', 'Cidade1', 1));
INSERT INTO Endereco VALUES (endereco_tp('55000-002', 'Rua2', 'Bairro1', 'Cidade1', 2));
INSERT INTO Endereco VALUES (endereco_tp('55000-003', 'Rua2', 'Bairro2', 'Cidade1', 3));
INSERT INTO Endereco VALUES (endereco_tp('55000-004', 'Rua3', 'Bairro3', 'Cidade1', 4));
INSERT INTO Endereco VALUES (endereco_tp('55000-005', 'Rua4', 'Bairro4', 'Cidade2', 5));

SELECT * FROM Endereco;

-- Telefone
INSERT INTO Telefone VALUES (telefone_tp('35230001'));
INSERT INTO Telefone VALUES (telefone_tp('33330000'));
INSERT INTO Telefone VALUES (telefone_tp('44440000'));
INSERT INTO Telefone VALUES (telefone_tp('55550000'));

SELECT * FROM Telefone;

-- Pessoa

    -- Aba Funcionarios

INSERT INTO Pessoa VALUES (pessoa_tp('123456789-01', 'Fulano', TO_DATE('01-01-2000', 'DD-MM-YYYY'), 'Homem', endereco_tp('55000-001', 'Rua1', 'Bairro1', 'Cidade1', 1), varray_telefone(telefone_tp('35230001')) ));
INSERT INTO Pessoa VALUES (pessoa_tp('123456789-03', 'Beltrana', TO_DATE('01-01-1990', 'DD-MM-YYYY'), 'Mulher', endereco_tp('55000-003', 'Rua2', 'Bairro2', 'Cidade1', 3), varray_telefone(telefone_tp('33330000')) ));
INSERT INTO Pessoa VALUES (pessoa_tp('123456789-04', 'Higgins', TO_DATE('11-03-1999', 'DD-MM-YYYY'), 'Homem', endereco_tp('55000-004', 'Rua3', 'Bairro3', 'Cidade1', 4), varray_telefone(telefone_tp('44440000')) ));

    -- Aba Clientes
INSERT INTO Pessoa VALUES (pessoa_tp('123456789-02', 'Cicrana', TO_DATE('01-01-1995', 'DD-MM-YYYY'), 'Mulher', endereco_tp('55000-002', 'Rua2', 'Bairro1', 'Cidade1', 2), varray_telefone(telefone_tp('35230001')) ));
INSERT INTO Pessoa VALUES (pessoa_tp('123456789-05', 'Rachel', TO_DATE('17-07-1997', 'DD-MM-YYYY'), 'Mulher', endereco_tp('55000-005', 'Rua4', 'Bairro4', 'Cidade2', 5), varray_telefone(telefone_tp('55550000')) ));
INSERT INTO Pessoa VALUES (pessoa_tp('123456789-06', 'Beltrene', TO_DATE('18-07-2001', 'DD-MM-YYYY'), 'Não informado', endereco_tp('55000-005', 'Rua4', 'Bairro4', 'Cidade2', 5), varray_telefone(telefone_tp('35230001')) ));

SELECT * FROM Pessoa;

-- Funcionario
INSERT INTO Funcionario VALUES (funcionario_tp('123456789-01', 'Fulano', TO_DATE('01-01-2000', 'DD-MM-YYYY'), 'Homem', endereco_tp('55000-001', 'Rua1', 'Bairro1', 'Cidade1', 1), varray_telefone(telefone_tp('35230001')), 'Gerente', 15000.01, 'beltrana@gov.br', '123', TO_DATE('01/02/2023', 'DD-MM-YYYY'), NULL));
INSERT INTO Funcionario VALUES (funcionario_tp('123456789-03', 'Beltrana', TO_DATE('01-01-1990', 'DD-MM-YYYY'), 'Mulher', endereco_tp('55000-003', 'Rua2', 'Bairro2', 'Cidade1', 3), varray_telefone(telefone_tp('33330000')), 'Veterinário', 5000.05, 'fulano.@gmail.com', '123', TO_DATE('05/03/2023', 'DD-MM-YYYY'), (SELECT REF(f) FROM Funcionario f WHERE f.cpf = '123456789-01') ));
INSERT INTO Funcionario VALUES (funcionario_tp('123456789-04', 'Higgins', TO_DATE('11-03-1999', 'DD-MM-YYYY'), 'Homem', endereco_tp('55000-004', 'Rua3', 'Bairro3', 'Cidade1', 4), varray_telefone(telefone_tp('44440000')), 'Vendedor', 1300.00, 'higgins.@gmail.com', '123', TO_DATE('07/03/2023', 'DD-MM-YYYY'), (SELECT REF(f) FROM Funcionario f WHERE f.cpf = '123456789-01') ));

SELECT nome, cargo FROM Funcionario;

-- Cliente
INSERT INTO Cliente VALUES (cliente_tp('123456789-02', 'Cicrana', TO_DATE('01-01-1995', 'DD-MM-YYYY'), 'Mulher', endereco_tp('55000-002', 'Rua2', 'Bairro1', 'Cidade1', 2), varray_telefone(telefone_tp('35230001')), TO_DATE('01/08/2023', 'DD-MM-YYYY'), 50 ));
INSERT INTO Cliente VALUES (cliente_tp('123456789-05', 'Rachel', TO_DATE('17-07-1997', 'DD-MM-YYYY'), 'Mulher', endereco_tp('55000-005', 'Rua4', 'Bairro4', 'Cidade2', 5), varray_telefone(telefone_tp('55550000')), TO_DATE('05/07/2023', 'DD-MM-YYYY'), 15 ));
INSERT INTO Cliente VALUES (cliente_tp('123456789-06', 'Beltrent', TO_DATE('18-07-2001', 'DD-MM-YYYY'), 'Não informado', endereco_tp('55000-005', 'Rua4', 'Bairro4', 'Cidade2', 5), varray_telefone(telefone_tp('35230001')), TO_DATE('05/07/2023', 'DD-MM-YYYY'), 0 ));


UPDATE Cliente C SET VALUE(C) = cliente_tp('123456789-06', 'Beltrene', TO_DATE('18-07-2001', 'DD-MM-YYYY'), 'Não informado', endereco_tp('55000-005', 'Rua4', 'Bairro4', 'Cidade2', 5), varray_telefone(telefone_tp('35230001')), TO_DATE('05/07/2023', 'DD-MM-YYYY'), 0 ) WHERE C.cpf = '123456789-06';

SELECT nome, creditos FROM Cliente;

-- DetalhesRaca
INSERT INTO DetalhesRaca VALUES (detalhesRaca_tp('Golden Retriever', 'Cachorro'));
INSERT INTO DetalhesRaca VALUES (detalhesRaca_tp('Pitbull', 'Cachorro'));
INSERT INTO DetalhesRaca VALUES (detalhesRaca_tp('Persa', 'Gato'));
INSERT INTO DetalhesRaca VALUES (detalhesRaca_tp('De Combate', 'Galo'));
INSERT INTO DetalhesRaca VALUES (detalhesRaca_tp('Tucunaré', 'Peixe'));

SELECT * FROM DetalhesRaca;

-- Pet
INSERT INTO Pet VALUES (pet_tp((SELECT REF(P) FROM Pessoa P WHERE P.cpf = '123456789-02'), 'Destruidor', (SELECT REF(R) FROM DetalhesRaca R WHERE R.raca='Pitbull'), TO_DATE('15/10/2023','DD-MM-YYYY'),  'Macho', 'Muito amigável', (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01') ));
INSERT INTO Pet VALUES (pet_tp((SELECT REF(P) FROM Pessoa P WHERE P.cpf = '123456789-02'), 'Florzinha', (SELECT REF(R) FROM DetalhesRaca R WHERE R.raca='Golden Retriever'), TO_DATE('01/01/2023', 'DD-MM-YYYY'),  'Fêmea', 'Extremamente perigosa', (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01') ));
INSERT INTO Pet VALUES (pet_tp((SELECT REF(P) FROM Pessoa P WHERE P.cpf = '123456789-02'), 'Alpha', (SELECT REF(R) FROM DetalhesRaca R WHERE R.raca='Tucunaré'), TO_DATE('01/05/2023', 'DD-MM-YYYY'),  'Macho', 'Extremamente perigoso', (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-03') ));
INSERT INTO Pet VALUES (pet_tp((SELECT REF(P) FROM Pessoa P WHERE P.cpf = '123456789-02'), 'Beta', (SELECT REF(R) FROM DetalhesRaca R WHERE R.raca='Golden Retriever'), TO_DATE('15/10/2023','DD-MM-YYYY'),  'Macho', 'Muito amigável', (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-03') ));
INSERT INTO Pet VALUES (pet_tp((SELECT REF(P) FROM Pessoa P WHERE P.cpf = '123456789-02'), 'Sigma', (SELECT REF(R) FROM DetalhesRaca R WHERE R.raca='Golden Retriever'), TO_DATE('15/10/2023','DD-MM-YYYY'),  'Macho', 'Extremamente perigoso', (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-03') ));

SELECT nome, observacoes FROM Pet;

-- Atendimento

INSERT INTO Atendimento VALUES (atendimento_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02'), TO_DATE('15/10/2023','DD-MM-YYYY'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01'), 500, 'Pix'));
INSERT INTO Atendimento VALUES (atendimento_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02'), TO_DATE('16/10/2023','DD-MM-YYYY'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01'), 500, 'Pix'));
INSERT INTO Atendimento VALUES (atendimento_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02'), TO_DATE('17/10/2023','DD-MM-YYYY'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01'), 500, 'Pix'));
INSERT INTO Atendimento VALUES (atendimento_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-05'), TO_DATE('15/10/2023','DD-MM-YYYY'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01'), 500, 'Pix'));
INSERT INTO Atendimento VALUES (atendimento_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-05'), TO_DATE('16/10/2023','DD-MM-YYYY'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01'), 500, 'Crédito'));

SELECT metodo_pagamento FROM Atendimento;

-- Servico e Presta

INSERT INTO Servico VALUES (servico_tp('S#001', 'Tosa', 'Tosa fi passar máquina no pelo', 300, ( SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02' ), TO_DATE('15/10/2023', 'DD-MM-YYYY')));
INSERT INTO Presta VALUES (presta_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02' ), 'Florzinha', ( SELECT REF(S) FROM Servico S WHERE codigo='S#001'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01')));

INSERT INTO Servico VALUES (servico_tp('S#002', 'Banho', 'Banho normal', 330, ( SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02' ), TO_DATE('16/10/2023', 'DD-MM-YYYY')));
INSERT INTO Presta VALUES (presta_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02' ), 'Destruidor', ( SELECT REF(S) FROM Servico S WHERE codigo='S#002'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01')));

INSERT INTO Servico VALUES (servico_tp('S#003', 'Aparar unhas', 'Cortar e serrar unhas', 500, ( SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02' ), TO_DATE('17/10/2023', 'DD-MM-YYYY')));
INSERT INTO Presta VALUES (presta_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-02' ), 'Destruidor', ( SELECT REF(S) FROM Servico S WHERE codigo='S#003'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01')));

INSERT INTO Servico VALUES (servico_tp('S#004', 'Terapia física', 'Ajuda para recuperar movimentos', 210, ( SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-05' ), TO_DATE('15/10/2023', 'DD-MM-YYYY')));
INSERT INTO Presta VALUES (presta_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-05' ), 'Alpha', ( SELECT REF(S) FROM Servico S WHERE codigo='S#004'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01')));

INSERT INTO Servico VALUES (servico_tp('S#005', 'Terapia física', 'Ajuda para recuperar movimentos', 210, ( SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-05' ), TO_DATE('15/10/2023', 'DD-MM-YYYY')));
INSERT INTO Presta VALUES (presta_tp( (SELECT REF(C) FROM Cliente C WHERE C.cpf='123456789-05' ), 'Sigma', ( SELECT REF(S) FROM Servico S WHERE codigo='S#005'), (SELECT REF(F) FROM Funcionario F WHERE F.cpf='123456789-01')));

SELECT codigo FROM Servico;
SELECT nome_Pet FROM Presta;

-- Produto

INSERT INTO Produto VALUES (produto_tp('P#001','Osso de brinquedo', 40, 33, 'HappyPup', caracteristicas_list('Tamanho médio'), 'Brinquedos'));


SELECT * FROM Produto;

-- Equipamento

INSERT INTO Equipamento VALUES (equipamento_tp('E#001', 'Banheira', 'PetFurniture', 'Grande', TO_DATE('04/03/2023','DD-MM-YYYY'), 'Leve', 15, 100));

SELECT * FROM Equipamento;
