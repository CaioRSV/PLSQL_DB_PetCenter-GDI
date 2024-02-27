CREATE SEQUENCE servicoNumSequence
  START WITH 0
  INCREMENT BY 1
  MINVALUE 0
  NOCACHE;
/
-- Criação de tipos de tabela e type bodies
    
-- Endereço
CREATE OR REPLACE TYPE endereco_tp AS OBJECT(
    cep VARCHAR2(50),
    rua VARCHAR2(50),
    bairro VARCHAR2(50),
    cidade VARCHAR2(50),
    numero_residencia NUMBER
);
/
-- Telefone
CREATE OR REPLACE TYPE varray_telefone AS VARRAY(2) OF telefone_tp;
/
CREATE OR REPLACE TYPE telefone_tp AS OBJECT(
    	numero VARCHAR2(50)
);
/

-- Pessoa
CREATE OR REPLACE TYPE pessoa_tp AS OBJECT(
	cpf VARCHAR2(50),
	nome VARCHAR2(50),
    data_de_nascimento DATE,
    genero VARCHAR2(50),
    cep REF endereco_tp,
    telefones varray_telefone,

    MEMBER PROCEDURE get_pessoa_endereco (SELF pessoa_tp),
    FINAL MEMBER PROCEDURE get_pessoa_info (SELF pessoa_tp)
) NOT FINAL;
/
    
CREATE OR REPLACE TYPE BODY pessoa_tp AS
    MEMBER PROCEDURE get_pessoa_endereco (SELF pessoa_tp) IS
    BEGIN
		DBMS_OUTPUT.PUT_LINE('CPF: ' || SELF.cpf);
		DBMS_OUTPUT.PUT_LINE('CEP: ' || SELF.cep);
    END;
    FINAL MEMBER PROCEDURE get_pessoa_info (SELF pessoa_tp) IS
    BEGIN
    	DBMS_OUTPUT.PUT_LINE('Nome: ' || SELF.nome);
		DBMS_OUTPUT.PUT_LINE('Data de Nascimento: ' || SELF.data_de_nascimento);
    END;
END;

/
--

-- Funcionário
CREATE OR REPLACE TYPE funcionario_tp UNDER pessoa_tp(
    cargo VARCHAR2(50),
    salario NUMBER,
    email VARCHAR2(50),
    senha VARCHAR2(50),
    data_contratacao DATE,
    supervisor REF funcionario_tp,

    OVERRIDING MEMBER PROCEDURE get_pessoa_endereco (SELF funcionario_tp)
);
/
CREATE OR REPLACE TYPE BODY funcionario_tp AS
    MEMBER PROCEDURE get_pessoa_endereco
    BEGIN
    	DBMS_OUTPUT.PUT_LINE('CPF: ' || SELF.cpf);
		DBMS_OUTPUT.PUT_LINE('Erro! Não pode se acessar endereço de funcionários.');
    END;
    
/

-- Cliente
    
CREATE OR REPLACE TYPE cliente_tp UNDER pessoa_tp(
    data_primeiro_atendimento DATE,
    creditos NUMBER
);

/
CREATE OR REPLACE TYPE detalhesRaca_tp AS OBJECT(
    raca VARCHAR2(50),
    especie VARCHAR2(50),

    CONSTRUCTOR FUNCTION detalhesRaca_tp(
        raca VARCHAR2,
        especie VARCHAR2
    ) RETURN SELF AS RESULT
    
)NOT INSTANTIABLE;
/
CREATE OR REPLACE TYPE BODY detalhesRaca_tp AS
    CONSTRUCTOR FUNCTION detalhesRaca_tp(
        raca VARCHAR2,
        especie VARCHAR2
    ) RETURN SELF AS RESULT
    IS
    BEGIN
    	SELF.raca := raca;
		SELF.especie := especie;
		RETURN;
	END;
END;

/
CREATE OR REPLACE TYPE pet_tp AS OBJECT(
    cpf_Responsavel REF pessoa_tp,
    nome VARCHAR2(50),
    raca REF detalhesRaca_tp,
    data_nascimento DATE,
    genero VARCHAR2(50),
    observacoes VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE atendimento_tp AS OBJECT(
    cpf_Cliente REF cliente_tp,
    data_atendimento DATE,
    cpf_Funcionario REF funcionario_tp,
    custo_total NUMBER,
    metodo_pagamento VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE servico_tp AS OBJECT(
    codigo VARCHAR2(50),
    nome VARCHAR2(50),
    descricao VARCHAR2(50),
    custo NUMBER,

    cpf_Cliente REF cliente_tp,
    data_atendimento DATE
);
/
CREATE TYPE caracteristicas_list AS TABLE OF VARCHAR2(200);
/
CREATE OR REPLACE TYPE produto_tp AS OBJECT(
    id VARCHAR2(50),
    nome VARCHAR2(50),
    preco NUMBER,
    quantidade NUMBER,
    marca VARCHAR2(50),
    caracteristicas caracteristicas_list
);
/
    
ALTER TYPE produto_tp ADD ATTRIBUTE(categoria VARCHAR2(50)) CASCADE;

/
CREATE OR REPLACE TYPE equipamento_tp AS OBJECT(
    id VARCHAR2(50),
    nome VARCHAR2(50),
    marca VARCHAR2(50),
    observacoes VARCHAR2(50),
    data_aquisicao DATE,
    grau_desgaste VARCHAR2(50),
    quantidade_usos INTEGER,
    vida_util INTEGER,

    MEMBER FUNCTION equipValidadeRestante RETURN INTEGER
);
/
CREATE OR REPLACE TYPE BODY equipamento_tp AS
    MEMBER FUNCTION equipValidadeRestante RETURN INTEGER IS
    expectedLifeTime INTEGER := self.vida_util - self.quantidade_usos;
    BEGIN
        return expectedLifeTime;
    END;
END;

/
CREATE OR REPLACE TYPE presta_tp AS OBJECT(
    cpf_Cliente VARCHAR2(50),
    nome_Pet VARCHAR2(50),
    codigo_Servico VARCHAR2(50),
    cpf_Funcionario VARCHAR2(50)
    
);
/
CREATE OR REPLACE TYPE vende_tp AS OBJECT(
    cpf_Cliente VARCHAR2(50),
    data_atendimento DATE,
    id_Produto VARCHAR2(50)
);
/
-- Criação de instâncias das tabelas

CREATE TABLE Endereco of endereco_tp(
    cep PRIMARY KEY,
    rua NOT NULL,
    bairro NOT NULL,
    cidade NOT NULL,
    numero_residencia NOT NULL
);
/
--
CREATE TABLE Telefone of telefone_tp(
    numero PRIMARY KEY
);
/
--
CREATE TABLE Pessoa of pessoa_tp(
    cpf PRIMARY KEY,
	nome NOT NULL,
    data_de_nascimento NOT NULL,
    genero NOT NULL,
    cep WITH ROWID REFERENCES Endereco
);
/
--
CREATE TABLE Funcionario of funcionario_tp(
    cargo NOT NULL,
    salario NOT NULL,
    email NOT NULL,
    senha NOT NULL,
    data_contratacao NOT NULL,
    supervisor SCOPE IS funcionario_tp,

    CONSTRAINT PRIMARY KEY Funcionario_PK (cpf)
);
/
--
CREATE TABLE Cliente of cliente_tp(
    data_primeiro_atendimento NOT NULL,
    creditos NOT NULL,
    CONSTRAINT PRIMARY KEY Funcionario_PK (cpf)
);
/
--
CREATE TABLE DetalhesRaca of detalhesRaca_tp(
    raca PRIMARY KEY,
    especie NOT NULL
);
/
--
CREATE TABLE Pet of pet_tp(
    cpf_Responsavel WITH ROWID REFERENCES Pessoa,
    nome NOT NULL,
    raca WITH ROWID REFERENCES DetalhesRaca,
    data_nascimento NOT NULL,
    genero NOT NULL,
    observacoes NOT NULL
);
/
--
CREATE TABLE Atendimento of atendimento_tp(
    cpf_Cliente WITH ROWID REFERENCES Cliente,
    data_atendimento NOT NULL,
    cpf_Funcionario WITH ROWID REFERENCES Funcionario,
    custo_total NOT NULL,
    metodo_pagamento NOT NULL
);
/
--
CREATE TABLE Servico OF servico_tp(
    codigo NOT NULL,
    nome NOT NULL,
    descricao NOT NULL,
    custo NOT NULL,

    cpf_Cliente WITH ROWID REFERENCES Cliente,
    data_atendimento NOT NULL
);
/
--

CREATE TABLE Produto of produto_tp(
    id NOT NULL,
    nome NOT NULL,
    preco NOT NULL,
    quantidade NOT NULL,
    marca NOT NULL,
    categoria NOT NULL,
) NESTED TABLE caracteristicas STORE AS NT_CaracteristicasProduto;



 
