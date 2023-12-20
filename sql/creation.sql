CREATE SEQUENCE servicoNumSequence
  START WITH 0
  INCREMENT BY 1
  MINVALUE 0
  NOCACHE;

---
CREATE TABLE Endereco (
    cep VARCHAR2(50),
    rua VARCHAR2(50),
    bairro VARCHAR2(50),
    cidade VARCHAR2(50),

    CONSTRAINT enderecoPK PRIMARY KEY (cep)
);

CREATE TABLE Pessoa (
	cpf VARCHAR2(50),
	nome VARCHAR2(50),
    data_de_nascimento DATE,
    genero VARCHAR2(50),
    cep VARCHAR2(50),

    CONSTRAINT pessoaPK PRIMARY KEY (cpf),
    CONSTRAINT pessoaEnderecoFK FOREIGN KEY (cep) REFERENCES Endereco(cep)
);

CREATE TABLE Telefone (
    cpf VARCHAR2(50),
    numero VARCHAR2(50),

    CONSTRAINT telefonePK PRIMARY KEY (cpf),
    CONSTRAINT telefoneFK FOREIGN KEY (cpf) REFERENCES Pessoa(cpf)
);

CREATE TABLE Funcionario (
	cpf VARCHAR2(50),
    cargo VARCHAR2(50),
    salario NUMBER,
    email VARCHAR2(50),
    senha VARCHAR2(50),
    data_contratacao DATE,
    supervisor VARCHAR2(50),

    CONSTRAINT funcPessoaFK FOREIGN KEY (cpf) REFERENCES Pessoa(cpf),
	CONSTRAINT funcPK PRIMARY KEY (cpf),
    
    CONSTRAINT supervisaoFK FOREIGN KEY (supervisor) REFERENCES Funcionario(cpf),

    CONSTRAINT checkEmail CHECK ((email LIKE '%.com') OR (email LIKE '%.br'))
    
);

CREATE TABLE Cliente (
	cpf VARCHAR2(50),
    data_primeiro_atendimento DATE,
    creditos NUMBER,

    CONSTRAINT funcClienteFK FOREIGN KEY (cpf) REFERENCES Pessoa(cpf),
    CONSTRAINT clientePK PRIMARY KEY (cpf)
);

CREATE TABLE DetalhesRaca(
    raca VARCHAR2(50),
    especie VARCHAR2(50),

    CONSTRAINT detalhesRacaEspeciePK PRIMARY KEY (raca)
);

CREATE TABLE Pet (
    cpf_Responsavel VARCHAR2(50),
    nome VARCHAR2(50),
    raca VARCHAR2(50),
    data_nascimento DATE,
    genero VARCHAR2(50),
    observacoes VARCHAR2(50),

    CONSTRAINT responsavelPetFK FOREIGN KEY (cpf_Responsavel) REFERENCES Cliente(cpf),
    CONSTRAINT petPK PRIMARY KEY (cpf_Responsavel, nome),

    CONSTRAINT pedigreeFK FOREIGN KEY (raca) REFERENCES DetalhesRaca(raca)
);

CREATE TABLE Atendimento (
    cpf_Cliente VARCHAR2(50),
    data_atendimento DATE,
    cpf_Funcionario VARCHAR2(50),
    custo_total NUMBER,
    metodo_pagamento VARCHAR2(50),

	CONSTRAINT atendimentoClienteFK FOREIGN KEY (cpf_Cliente) REFERENCES Cliente(cpf),
    CONSTRAINT atendimentoFuncionario FOREIGN KEY (cpf_Funcionario) REFERENCES Funcionario(cpf),
    
    CONSTRAINT atendimentoPK PRIMARY KEY (cpf_Cliente, data_atendimento)
);

CREATE TABLE Servico (
    codigo VARCHAR2(50),
    nome VARCHAR2(50),
    descricao VARCHAR2(50),
    custo NUMBER,

    cpf_Cliente VARCHAR2(50),
    data_atendimento DATE,

    CONSTRAINT servicoPK PRIMARY KEY (codigo),

    CONSTRAINT servicoAtendimentoFK FOREIGN KEY (cpf_Cliente, data_atendimento) REFERENCES Atendimento(cpf_Cliente, data_atendimento)
);

CREATE TABLE Produto (
    id VARCHAR2(50),
    nome VARCHAR2(50),
    preco NUMBER,
    quantidade NUMBER,
    categoria VARCHAR2(50),
    marca VARCHAR2(50),
    caracteristicas VARCHAR2(50),

    CONSTRAINT ProdutoPK PRIMARY KEY (id)
);

CREATE TABLE Equipamento (
    id VARCHAR2(50),
    nome VARCHAR2(50),
    marca VARCHAR2(50),
    observacoes VARCHAR2(50),
    data_aquisicao DATE,
    grau_desgaste VARCHAR2(50),
    quantidade_usos INTEGER,
    vida_util INTEGER
);

CREATE TABLE Presta (
    cpf_Cliente VARCHAR2(50),
    nome_Pet VARCHAR2(50),
    codigo_Servico VARCHAR2(50),

    cpf_Funcionario VARCHAR2(50),

    CONSTRAINT prestaPetFK FOREIGN KEY (cpf_Cliente, nome_Pet) REFERENCES Pet(cpf_Responsavel, nome),
    CONSTRAINT prestaServicoFK FOREIGN KEY (codigo_Servico) REFERENCES Servico(codigo),
    CONSTRAINT prestaFuncionarioFK FOREIGN KEY (cpf_Funcionario) REFERENCES Funcionario(cpf),

    CONSTRAINT prestaPK PRIMARY KEY (cpf_Cliente, nome_Pet, codigo_Servico)
    
);

CREATE TABLE Vende (
    cpf_Cliente VARCHAR2(50),
    data_atendimento DATE,
    id_Produto VARCHAR2(50),

    CONSTRAINT vendeAtendimentoFK FOREIGN KEY (cpf_Cliente, data_atendimento) REFERENCES Atendimento(cpf_Cliente, data_atendimento),
    CONSTRAINT vendeProdutoFK FOREIGN KEY (id_Produto) REFERENCES Produto(id),

    CONSTRAINT vendePK PRIMARY KEY (cpf_Cliente, data_atendimento, id_Produto)
);
