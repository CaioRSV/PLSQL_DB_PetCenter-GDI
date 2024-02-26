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

-- Pessoa
CREATE OR REPLACE TYPE pessoa_tp AS OBJECT(
	cpf VARCHAR2(50),
	nome VARCHAR2(50),
    data_de_nascimento DATE,
    genero VARCHAR2(50),
    cep VARCHAR2(50),

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

-- Telefone
CREATE OR REPLACE TYPE telefone_tp AS OBJECT(
        cpf VARCHAR2(50),
    	numero VARCHAR2(50)
);
/

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
    cpf_Responsavel VARCHAR2(50),
    nome VARCHAR2(50),
    raca VARCHAR2(50),
    data_nascimento DATE,
    genero VARCHAR2(50),
    observacoes VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE atendimento_tp AS OBJECT(
    cpf_Cliente VARCHAR2(50),
    data_atendimento DATE,
    cpf_Funcionario VARCHAR2(50),
    custo_total NUMBER,
    metodo_pagamento VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE servico_tp AS OBJECT(
    codigo VARCHAR2(50),
    nome VARCHAR2(50),
    descricao VARCHAR2(50),
    custo NUMBER,

    cpf_Cliente VARCHAR2(50),
    data_atendimento DATE
);
/
CREATE OR REPLACE TYPE produto_tp AS OBJECT(
    id VARCHAR2(50),
    nome VARCHAR2(50),
    preco NUMBER,
    quantidade NUMBER,
    categoria VARCHAR2(50),
    marca VARCHAR2(50),
    caracteristicas VARCHAR2(50)
);
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

 