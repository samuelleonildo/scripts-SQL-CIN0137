/* region pessoa */
-- Inserção de Endereços
INSERT INTO Endereco VALUES ('12345678', 'São Paulo', 'SP');
INSERT INTO Endereco VALUES ('87654321', 'Rio de Janeiro', 'RJ');
INSERT INTO Endereco VALUES ('50000000', 'Recife', 'PE');
INSERT INTO Endereco VALUES ('60000000', 'Fortaleza', 'CE');
INSERT INTO Endereco VALUES ('70000000', 'Brasília', 'DF');

-- Inserção de Pessoas
INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'João Silva', 'joao@email.com', '12345678901', 'Rua A', '100', 'Apto 10', 'Centro', '12345678');

INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'Maria Souza', 'maria@email.com', '98765432100', 'Rua B', '200', NULL, 'Bairro B', '87654321');

INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'Cleber Rocha', 'clebinho@email.com', '22222222222', 'Rua B', '20', '', 'Boa Vista', '60000000');

INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'Carlos Magno', 'carlos@email.com', '33333333333', 'Rua C', '30', '', 'Aflitos', '70000000');

INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'Janailton', 'jana@email.com', '44444444444', 'Rua D', '40', '', 'Casa Forte', '50000000');

INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'José Mefistoteles', 'jose@email.com', '55555555555', 'Rua E', '50', '', 'Centro', '60000000');

INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'Manoel Demiurgo', 'devil@gmail.com', '66666666666', 'Rua da Gnose', '777', 'apto 157', 'Ibura', '12345678');

INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, complemento, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'Marcos Antônio', 'marcos@email.com', '11111111111', 'Rua A', '10', '', 'Centro', '50000000');

-- Telefones
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 1, '11999999999');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 2, '21988888888');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 3, '81911111111');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 4, '85922222222');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 5, '61933333333');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 6, '81944444444');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 7, '85955555555');

/* endregion pessoa */

/* region especificacoes pessoa */
-- Alunos
INSERT INTO Aluno VALUES (1, '2023001');
INSERT INTO Aluno VALUES (2, '2025002');
INSERT INTO Aluno VALUES (3, '2024003');
INSERT INTO Aluno VALUES (4, '2023002');

-- Matrícula
INSERT INTO Matricula VALUES ('2023001', 'Engenharia de Software', 3);
INSERT INTO Matricula VALUES ('2024003', 'Ciencia da Computacao', 2);
INSERT INTO Matricula VALUES ('2025002', 'Sistemas de Informação', 1);

-- Funcionários
INSERT INTO Funcionario VALUES (5, 'FUNC001', 'Bibliotecário', DATE '2020-01-15', NULL);
INSERT INTO Funcionario VALUES (6, 'FUNC002', 'Bibliotecário', DATE '2020-01-10', NULL);
INSERT INTO Funcionario VALUES (7, 'FUNC003', 'Auxiliar', DATE '2022-03-15', 6);
/* endregion especificacoes pessoa */

/* region livro */
-- Livros
INSERT INTO Livro VALUES ('9781234567890', 'Banco de Dados', 'Editora Exemplo', 2022, 'Tecnologia');
INSERT INTO Livro VALUES ('9780134310884', 'Clean Code', 'Prentice Hall', 2008, 'Programacao');
INSERT INTO Livro VALUES ('9788575225634', 'Dev Ops', 'Alta Books', 2011, 'Engenharia de Software');
INSERT INTO Livro VALUES ('9780132312333', 'Process Mining', 'Prentice Hall', 2008, 'Integracao e evolucao de sistemas de informacao');

-- Autores
INSERT INTO Autor_Livro VALUES ('9781234567890', 'Carlos Henrique');
INSERT INTO Autor_Livro VALUES ('9781234567890', 'Fernanda Costa');
INSERT INTO Autor_Livro VALUES ('9780134310884', 'Robert C. Melman');
INSERT INTO Autor_Livro VALUES ('9788575225634', 'Caruzo Hempfild');
INSERT INTO Autor_Livro VALUES ('9780132312333', 'Caruzo Hempfild');

-- Exemplares
INSERT INTO Exemplar VALUES ('9781234567890', 1, 'Ótimo', 'S');
INSERT INTO Exemplar VALUES ('9780132350884', 101, 'Bom', 'S');
INSERT INTO Exemplar VALUES ('9780132350884', 102, 'Regular', 'S');
INSERT INTO Exemplar VALUES ('9788575225634', 201, 'Ótimo', 'N');
INSERT INTO Exemplar VALUES ('9780132312333', 155, 'Ótimo', 'N');
/* endregion livro */

/* region avaliacao */
INSERT INTO Avaliacao VALUES (1, 1, '9781234567890', SYSDATE, 9.5, 'Livro em excelente estado.', 2);
INSERT INTO Avaliacao VALUES (1, 101, '9780134310884', DATE '2024-05-20', 9.0, 'Muito bom livro.', 3);
INSERT INTO Avaliacao VALUES (3, 102, '9780134310884', DATE '2024-05-22', 8.5, 'Capa rasgada.', 4);
INSERT INTO Avaliacao VALUES (2, 201, '9788575225634', DATE '2024-06-01', 10.0, 'Excelente conteúdo!', 3);
INSERT INTO Avaliacao VALUES (4, 155, '9780132312333', DATE '2024-06-10', 7.5, 'Texto denso.', 4);
/* endregion avaliacao */

/* region emprestimo */
INSERT INTO RealizaEmprestimo VALUES (1, '9781234567890', 1, 6, SYSDATE, SYSDATE + 7, NULL, 'Em aberto', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (2, '9780134310884', 101, 3, DATE '2024-06-01', DATE '2024-06-10', DATE '2024-06-09', 'Devolvido', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (3, '9780132312333', 155, 7, DATE '2024-06-05', DATE '2024-06-12', NULL, 'Em atraso', 5.00, 'Atraso de devolução', DATE '2024-06-20', 'Pendente');
/* endregion emprestimo */
