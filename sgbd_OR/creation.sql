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
CREATE OR REPLACE TYPE telefone_tp AS OBJECT(
    	numero VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE varray_telefone AS VARRAY(2) OF telefone_tp;

/

-- Pessoa
CREATE OR REPLACE TYPE pessoa_tp AS OBJECT(
	cpf VARCHAR2(50),
	nome VARCHAR2(50),
    data_de_nascimento DATE,
    genero VARCHAR2(50),
    endereco endereco_tp,
    telefones varray_telefone,

    MEMBER PROCEDURE get_pessoa_endereco (SELF pessoa_tp),
    FINAL MEMBER PROCEDURE get_pessoa_info (SELF pessoa_tp)
) NOT FINAL;
/
    
CREATE OR REPLACE TYPE BODY pessoa_tp AS
    MEMBER PROCEDURE get_pessoa_endereco ( SELF pessoa_tp) IS
    BEGIN
		DBMS_OUTPUT.PUT_LINE('CPF: ' || SELF.cpf);
		DBMS_OUTPUT.PUT_LINE('CEP: ' || SELF.endereco.cep);
    END;
    FINAL MEMBER PROCEDURE get_pessoa_info (SELF pessoa_tp) IS
    BEGIN
    	DBMS_OUTPUT.PUT_LINE('Nome: ' || SELF.nome);
        DBMS_OUTPUT.PUT_LINE('Data de Nascimento: ' || TO_CHAR(SELF.data_de_nascimento, 'DD-MON-YYYY'));
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
    
);
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
    observacoes VARCHAR2(50),
    funcionarioResp REF funcionario_tp,

    MEMBER FUNCTION compararIdadesPets(pet1 pet_tp) RETURN NUMBER
);
/
CREATE OR REPLACE TYPE BODY pet_tp AS
    MEMBER FUNCTION compararIdadesPets(pet1 pet_tp) RETURN NUMBER IS
    BEGIN
    	IF self.data_nascimento < pet1.data_nascimento THEN
    		RETURN -1;
		ELSIF self.data_nascimento > pet1.data_nascimento THEN
            RETURN 1;
		ELSE
            RETURN 0;
		END IF;
	END;
END;
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
    caracteristicas caracteristicas_list,

    MEMBER FUNCTION calc_PrecoEstoque RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY produto_tp AS
    MEMBER FUNCTION calc_PrecoEstoque RETURN NUMBER IS
        total_price NUMBER := 0;
    BEGIN
        FOR i IN 1..self.caracteristicas.COUNT LOOP
            total_price := total_price + self.preco * self.quantidade;
        END LOOP;
        RETURN total_price;
    END;
END;
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
    endereco NOT NULL
);
/
--
CREATE TABLE Funcionario of funcionario_tp(
    cargo NOT NULL,
    salario NOT NULL,
    email NOT NULL,
    senha NOT NULL,
    data_contratacao NOT NULL,
    supervisor SCOPE IS Funcionario,

    CONSTRAINT Funcionario_PK PRIMARY KEY (cpf)
);
/
--
CREATE TABLE Cliente of cliente_tp(
    data_primeiro_atendimento NOT NULL,
    creditos NOT NULL,
    CONSTRAINT Cliente_PK PRIMARY KEY (cpf)
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
    observacoes NOT NULL,
    funcionarioResp WITH ROWID REFERENCES Funcionario
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
    codigo PRIMARY KEY,
    nome NOT NULL,
    descricao NOT NULL,
    custo NOT NULL,

    cpf_Cliente WITH ROWID REFERENCES Cliente,
    data_atendimento NOT NULL
);
/
--
CREATE TABLE Produto of produto_tp(
    id PRIMARY KEY,
    nome NOT NULL,
    preco NOT NULL,
    quantidade NOT NULL,
    marca NOT NULL,
    categoria NOT NULL
) NESTED TABLE caracteristicas STORE AS NT_CaracteristicasProduto;
/
 
