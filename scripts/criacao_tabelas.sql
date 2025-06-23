-- sequencias
CREATE SEQUENCE seq_pessoa START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_telefone START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_funcionario START WITH 1 INCREMENT BY 1;


/* region pessoa */

    CREATE TABLE Endereco (
        cep VARCHAR2(10) PRIMARY KEY,
        cidade VARCHAR2(50) NOT NULL,
        estado VARCHAR2(2) NOT NULL,
        CONSTRAINT chk_estado CHECK (LENGTH(estado) = 2)
    );

    CREATE TABLE Pessoa (
        id NUMBER PRIMARY KEY,
        nome VARCHAR2(100) NOT NULL,
        email VARCHAR2(100) UNIQUE,
        cpf VARCHAR2(11) UNIQUE NOT NULL,
        rua VARCHAR2(100),
        numero VARCHAR2(10),
        complemento VARCHAR2(50),
        bairro VARCHAR2(50),
        cep_end VARCHAR2(10),
        CONSTRAINT fk_cep FOREIGN KEY (cep_end) REFERENCES Endereco(cep)
    );

    CREATE TABLE Telefone (
        id_telefone NUMBER PRIMARY KEY,
        id_pessoa NUMBER NOT NULL,
        numero VARCHAR2(15) NOT NULL,
        CONSTRAINT fk_pessoa_telefone FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
        CONSTRAINT chk_numero CHECK (REGEXP_LIKE(numero, '^[0-9]+$'))
    );

/* endregion pessoa */

---

/* region especificacoes pessoa */

    /* region aluno */

        CREATE TABLE Aluno (
            id_aluno NUMBER PRIMARY KEY,
            matricula VARCHAR2(20) UNIQUE NOT NULL,
            CONSTRAINT fk_aluno_pessoa FOREIGN KEY (id_aluno) REFERENCES Pessoa(id)
        );

        CREATE TABLE Matricula (
            matricula VARCHAR2(20) PRIMARY KEY,
            curso VARCHAR2(50) NOT NULL,
            semestre NUMBER NOT NULL,
            CONSTRAINT chk_semestre CHECK (semestre BETWEEN 1 AND 12)
        );

    /* endregion aluno */

    ---

    /* region funcionario */

        CREATE TABLE Funcionario (
            id_funcionario NUMBER PRIMARY KEY,
            matricula VARCHAR2(20) UNIQUE NOT NULL,
            cargo VARCHAR2(50) NOT NULL,
            data_admissao DATE NOT NULL,
            id_supervisor NUMBER,
            CONSTRAINT fk_func_pessoa FOREIGN KEY (id_funcionario) REFERENCES Pessoa(id),
            CONSTRAINT fk_supervisor FOREIGN KEY (id_supervisor) REFERENCES Funcionario(id_funcionario)
        );  

    /* endregion funcionario */

/* endregion especificacoes pessoa */

---

/* region livro */

    /* region principal */

        CREATE TABLE Livro (
            isbn VARCHAR2(13) PRIMARY KEY,
            titulo VARCHAR2(100) NOT NULL,
            editora VARCHAR2(50),
            ano_publicacao NUMBER,
            categoria VARCHAR2(50)
        );

        CREATE TABLE Autor_Livro (
            isbn VARCHAR2(13) NOT NULL,
            autor VARCHAR2(100) NOT NULL,
            CONSTRAINT pk_autor_livro PRIMARY KEY (isbn, autor),
            CONSTRAINT fk_livro_autor FOREIGN KEY (isbn) REFERENCES Livro(isbn)
        );

    /* endregion principal */

    ---

    /* region entidade fraca */

        CREATE TABLE Exemplar (
            isbn VARCHAR2(13) NOT NULL,
            numero_patrimonio NUMBER NOT NULL,
            estado_conservacao VARCHAR2(50),
            disponivel CHAR(1) CHECK (disponivel IN ('S', 'N')),
            CONSTRAINT pk_exemplar PRIMARY KEY (isbn, numero_patrimonio),
            CONSTRAINT fk_exemplar_livro FOREIGN KEY (isbn) REFERENCES Livro(isbn)
        );

    /* endregion entidade fraca */

/* endregion livro */

---

/* region avaliacao */

    CREATE TABLE Avaliacao (
        id_aluno NUMBER NOT NULL,
        numero_patrimonio NUMBER NOT NULL,
        isbn VARCHAR2(13) NOT NULL,
        data_avaliacao DATE NOT NULL,
        nota NUMBER(3,1) CHECK (nota BETWEEN 0 AND 10),
        comentario VARCHAR2(255),
        id_funcionario_revisor NUMBER,
        CONSTRAINT pk_avaliacao PRIMARY KEY (id_aluno, numero_patrimonio, isbn, data_avaliacao),
        CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
        CONSTRAINT fk_avaliacao_exemplar FOREIGN KEY (isbn, numero_patrimonio) REFERENCES Exemplar(isbn, numero_patrimonio),
        CONSTRAINT fk_avaliacao_funcionario FOREIGN KEY (id_funcionario_revisor) REFERENCES Funcionario(id_funcionario)
    );

/* endregion avaliacao */

--- 

/* region emprestimo */

    CREATE TABLE RealizaEmprestimo (
        id_aluno NUMBER NOT NULL,
        isbn VARCHAR2(13) NOT NULL,
        numero_patrimonio NUMBER NOT NULL,
        id_funcionario NUMBER NOT NULL,
        data_emprestimo DATE NOT NULL,
        data_prevista DATE,
        data_devolucao DATE,
        situacao VARCHAR2(20) CHECK (situacao IN ('Em aberto', 'Devolvido', 'Em atraso')),
        valor_multa NUMBER(6,2),
        motivo_multa VARCHAR2(255),
        data_aplicacao_multa DATE,
        status_multa VARCHAR2(20),
        CONSTRAINT pk_emprestimo PRIMARY KEY (id_aluno, isbn, numero_patrimonio, data_emprestimo),
        CONSTRAINT fk_emprestimo_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
        CONSTRAINT fk_emprestimo_exemplar FOREIGN KEY (isbn, numero_patrimonio) REFERENCES Exemplar(isbn, numero_patrimonio),
        CONSTRAINT fk_emprestimo_funcionario FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario)
    );

/* endregion emprestimo */