/* region pessoa */
    -- Inserção de Endereços
    INSERT INTO Endereco (cep, cidade, estado) VALUES ('12345678', 'São Paulo', 'SP');
    INSERT INTO Endereco (cep, cidade, estado) VALUES ('87654321', 'Rio de Janeiro', 'RJ');

    -- Inserção de Pessoas
    INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
    VALUES (seq_pessoa.NEXTVAL, 'João Silva', 'joao@email.com', '12345678901', 'Rua A', '100', 'Apto 10', 'Centro', '12345678');

    INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
    VALUES (seq_pessoa.NEXTVAL, 'Maria Souza', 'maria@email.com', '98765432100', 'Rua B', '200', NULL, 'Bairro B', '87654321');

    -- Inserção de Telefones
    INSERT INTO Telefone (id_telefone, id_pessoa, numero) VALUES (seq_telefone.NEXTVAL, 1, '11999999999');
    INSERT INTO Telefone (id_telefone, id_pessoa, numero) VALUES (seq_telefone.NEXTVAL, 2, '21988888888');

/* endregion pessoa */

---

/* region especificacoes pessoa */
    -- Inserção de Alunos
    INSERT INTO Aluno (id_aluno, matricula) VALUES (1, '2023001');
    INSERT INTO Matricula (matricula, curso, semestre) VALUES ('2023001', 'Engenharia de Software', 3);

    -- Inserção de Funcionários
    INSERT INTO Funcionario (id_funcionario, matricula, cargo, data_admissao, id_supervisor)
    VALUES (2, 'FUNC001', 'Bibliotecário', TO_DATE('2020-01-15', 'YYYY-MM-DD'), NULL);

/* endregion especificacoes pessoa */

---

/* region livro */
    -- Inserção de Livros
    INSERT INTO Livro (isbn, titulo, editora, ano_publicacao, categoria)
    VALUES ('9781234567890', 'Banco de Dados', 'Editora Exemplo', 2022, 'Tecnologia');

    -- Inserção de Autores
    INSERT INTO Autor_Livro (isbn, autor) VALUES ('9781234567890', 'Carlos Henrique');
    INSERT INTO Autor_Livro (isbn, autor) VALUES ('9781234567890', 'Fernanda Costa');

    -- Inserção de Exemplar
    INSERT INTO Exemplar (isbn, numero_patrimonio, estado_conservacao, disponivel)
    VALUES ('9781234567890', 1, 'Ótimo', 'S');

/* endregion livro */

---

/* region avaliacao */
    INSERT INTO Avaliacao (id_aluno, numero_patrimonio, isbn, data_avaliacao, nota, comentario, id_funcionario_revisor)
    VALUES (1, 1, '9781234567890', SYSDATE, 9.5, 'Livro em excelente estado.', 2);

/* endregion avaliacao */

---

/* region emprestimo */
    INSERT INTO RealizaEmprestimo (id_aluno, isbn, numero_patrimonio, id_funcionario, data_emprestimo, data_prevista, situacao)
    VALUES (1, '9781234567890', 1, 2, SYSDATE, SYSDATE + 7, 'Em aberto');
    
/* endregion emprestimo */