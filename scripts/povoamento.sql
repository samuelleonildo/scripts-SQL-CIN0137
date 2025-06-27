-- SEQUÊNCIAS
DROP SEQUENCE seq_pessoa;
CREATE SEQUENCE seq_pessoa START WITH 1 INCREMENT BY 1;

DROP SEQUENCE seq_telefone;
CREATE SEQUENCE seq_telefone START WITH 1 INCREMENT BY 1;

DROP SEQUENCE seq_funcionario;
CREATE SEQUENCE seq_funcionario START WITH 1 INCREMENT BY 1;

-- ENDEREÇOS
INSERT INTO Endereco VALUES ('12345678', 'São Paulo', 'SP');
INSERT INTO Endereco VALUES ('87654321', 'Rio de Janeiro', 'RJ');
INSERT INTO Endereco VALUES ('50000000', 'Recife', 'PE');
INSERT INTO Endereco VALUES ('60000000', 'Fortaleza', 'CE');
INSERT INTO Endereco VALUES ('70000000', 'Brasília', 'DF');

-- PESSOAS
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'João Silva', 'joao@email.com', '12345678901', 'Rua A', '100', 'Apto 10', 'Centro', '12345678');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Maria Souza', 'maria@email.com', '98765432100', 'Rua B', '200', NULL, 'Bairro B', '87654321');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Cleber Rocha', 'clebinho@email.com', '22222222222', 'Rua B', '20', '', 'Boa Vista', '60000000');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Carlos Magno', 'carlos@email.com', '33333333333', 'Rua C', '30', '', 'Aflitos', '70000000');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Janailton', 'jana@email.com', '44444444444', 'Rua D', '40', '', 'Casa Forte', '50000000');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'José Mefistoteles', 'jose@email.com', '55555555555', 'Rua E', '50', '', 'Centro', '60000000');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Manoel Demiurgo', 'devil@gmail.com', '66666666666', 'Rua da Gnose', '777', 'apto 157', 'Ibura', '12345678');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Marcos Antônio', 'marcos@email.com', '11111111111', 'Rua A', '10', '', 'Centro', '50000000');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Ana Paula', 'ana.paula@email.com', '77777777777', 'Rua F', '60', NULL, 'Boa Viagem', '50000000');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Bruno Lima', 'bruno.lima@email.com', '88888888888', 'Rua G', '70', NULL, 'Espinheiro', '12345678');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Camila Rocha', 'camila.rocha@email.com', '99999999999', 'Rua H', '80', NULL, 'Pina', '60000000');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Diego Costa', 'diego.costa@email.com', '10101010101', 'Rua I', '90', NULL, 'Casa Amarela', '70000000');
INSERT INTO Pessoa VALUES (seq_pessoa.NEXTVAL, 'Elisa Mendes', 'elisa.mendes@email.com', '12121212121', 'Rua J', '100', NULL, 'Aflitos', '87654321');

-- TELEFONES
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 1, '11999999999');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 2, '21988888888');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 3, '81911111111');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 4, '85922222222');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 5, '61933333333');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 6, '81944444444');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 7, '85955555555');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 8, '81977777777');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 9, '81988887777');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 10, '81977776666');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 11, '81966665555');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 12, '81955554444');
INSERT INTO Telefone VALUES (seq_telefone.NEXTVAL, 13, '81944443333');

-- ALUNOS
INSERT INTO Aluno VALUES (1, '2023001');
INSERT INTO Aluno VALUES (2, '2025002');
INSERT INTO Aluno VALUES (3, '2024003');
INSERT INTO Aluno VALUES (4, '2023002');
INSERT INTO Aluno VALUES (9, '2026001');
INSERT INTO Aluno VALUES (10, '2026002');
INSERT INTO Aluno VALUES (11, '2026003');
INSERT INTO Aluno VALUES (12, '2026004');
INSERT INTO Aluno VALUES (13, '2026005');

-- MATRÍCULAS
INSERT INTO Matricula VALUES ('2023001', 'Engenharia de Software', 3);
INSERT INTO Matricula VALUES ('2024003', 'Ciência da Computação', 2);
INSERT INTO Matricula VALUES ('2025002', 'Sistemas de Informação', 1);
INSERT INTO Matricula VALUES ('2023002', 'Engenharia de Software', 5);
INSERT INTO Matricula VALUES ('2026001', 'Engenharia Civil', 1);
INSERT INTO Matricula VALUES ('2026002', 'Administração', 3);
INSERT INTO Matricula VALUES ('2026003', 'Direito', 2);
INSERT INTO Matricula VALUES ('2026004', 'Medicina', 4);
INSERT INTO Matricula VALUES ('2026005', 'Arquitetura', 5);

-- FUNCIONÁRIOS
INSERT INTO Funcionario VALUES (5, 'FUNC001', 'Bibliotecário', DATE '2020-01-15', NULL);
INSERT INTO Funcionario VALUES (6, 'FUNC002', 'Bibliotecário', DATE '2020-01-10', NULL);
INSERT INTO Funcionario VALUES (7, 'FUNC003', 'Auxiliar', DATE '2022-03-15', 6);
INSERT INTO Funcionario VALUES (8, 'FUNC004', 'Atendente', DATE '2023-06-01', 5);
INSERT INTO Funcionario VALUES (9, 'FUNC005', 'Secretário', DATE '2023-01-10', 5);
INSERT INTO Funcionario VALUES (10, 'FUNC006', 'Bibliotecário', DATE '2023-02-15', 6);
INSERT INTO Funcionario VALUES (11, 'FUNC007', 'Auxiliar', DATE '2023-03-20', 7);
INSERT INTO Funcionario VALUES (12, 'FUNC008', 'Atendente', DATE '2023-04-25', 8);
INSERT INTO Funcionario VALUES (13, 'FUNC009', 'Recepcionista', DATE '2023-05-30', 5);
-- LIVROS
INSERT INTO Livro VALUES ('9781234567890', 'Banco de Dados', 'Editora Exemplo', 2022, 'Tecnologia');
INSERT INTO Livro VALUES ('9780134310884', 'Clean Code', 'Prentice Hall', 2008, 'Programação');
INSERT INTO Livro VALUES ('9788575225634', 'Dev Ops', 'Alta Books', 2011, 'Engenharia de Software');
INSERT INTO Livro VALUES ('9780132312333', 'Process Mining', 'Prentice Hall', 2008, 'Sistemas de Informação');
INSERT INTO Livro VALUES ('9781111111111', 'Algoritmos', 'Pearson', 2019, 'Tecnologia');
INSERT INTO Livro VALUES ('9782222222222', 'Engenharia de Software', 'Campus', 2017, 'Tecnologia');
INSERT INTO Livro VALUES ('9783333333333', 'Banco de Dados Avançado', 'Novatec', 2018, 'Tecnologia');
INSERT INTO Livro VALUES ('9784444444444', 'Redes de Computadores', 'Elsevier', 2020, 'Tecnologia');
INSERT INTO Livro VALUES ('9785555555555', 'Sistemas Operacionais', 'Pearson', 2021, 'Tecnologia');

-- AUTORES
INSERT INTO Autor_Livro VALUES ('9781234567890', 'Carlos Henrique');
INSERT INTO Autor_Livro VALUES ('9781234567890', 'Fernanda Costa');
INSERT INTO Autor_Livro VALUES ('9780134310884', 'Robert C. Martin');
INSERT INTO Autor_Livro VALUES ('9788575225634', 'Caruzo Hempfild');
INSERT INTO Autor_Livro VALUES ('9780132312333', 'Wil van der Aalst');
INSERT INTO Autor_Livro VALUES ('9781111111111', 'Thomas Cormen');
INSERT INTO Autor_Livro VALUES ('9782222222222', 'Ian Sommerville');
INSERT INTO Autor_Livro VALUES ('9783333333333', 'Carlos Heuser');
INSERT INTO Autor_Livro VALUES ('9784444444444', 'Andrew S. Tanenbaum');
INSERT INTO Autor_Livro VALUES ('9785555555555', 'Abraham Silberschatz');

-- EXEMPLARES
INSERT INTO Exemplar VALUES ('9781234567890', 1, 'Ótimo', 'S');
INSERT INTO Exemplar VALUES ('9780134310884', 101, 'Bom', 'S');
INSERT INTO Exemplar VALUES ('9780134310884', 102, 'Regular', 'S');
INSERT INTO Exemplar VALUES ('9788575225634', 201, 'Ótimo', 'N');
INSERT INTO Exemplar VALUES ('9780132312333', 155, 'Ótimo', 'N');
INSERT INTO Exemplar VALUES ('9781111111111', 301, 'Novo', 'S');
INSERT INTO Exemplar VALUES ('9782222222222', 302, 'Bom', 'S');
INSERT INTO Exemplar VALUES ('9783333333333', 303, 'Regular', 'N');
INSERT INTO Exemplar VALUES ('9784444444444', 304, 'Bom', 'S');
INSERT INTO Exemplar VALUES ('9785555555555', 305, 'Ótimo', 'S');

-- AVALIAÇÕES
INSERT INTO Avaliacao VALUES (1, 1, '9781234567890', SYSDATE, 9.5, 'Livro em excelente estado.', 5);
INSERT INTO Avaliacao VALUES (1, 101, '9780134310884', DATE '2024-05-20', 9.0, 'Muito bom livro.', 6);
INSERT INTO Avaliacao VALUES (3, 102, '9780134310884', DATE '2024-05-22', 8.5, 'Capa rasgada.', 7);
INSERT INTO Avaliacao VALUES (2, 201, '9788575225634', DATE '2024-06-01', 10.0, 'Excelente conteúdo!', 7);
INSERT INTO Avaliacao VALUES (4, 155, '9780132312333', DATE '2024-06-10', 7.5, 'Texto denso.', 8);
INSERT INTO Avaliacao VALUES (9, 301, '9781111111111', SYSDATE - 10, 8.5, 'Muito bom livro.', 9);
INSERT INTO Avaliacao VALUES (10, 302, '9782222222222', SYSDATE - 20, 9.0, 'Ótima leitura.', 10);
INSERT INTO Avaliacao VALUES (11, 303, '9783333333333', SYSDATE - 15, 7.0, 'Pode melhorar.', 11);
INSERT INTO Avaliacao VALUES (12, 304, '9784444444444', SYSDATE - 5, 9.5, 'Excelente conteúdo.', 12);
INSERT INTO Avaliacao VALUES (13, 305, '9785555555555', SYSDATE - 1, 10.0, 'Livro fundamental.', 13);

-- EMPRÉSTIMOS
INSERT INTO RealizaEmprestimo VALUES (1, '9781234567890', 1, 6, SYSDATE, SYSDATE + 7, NULL, 'Em aberto', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (2, '9780134310884', 101, 7, DATE '2024-06-01', DATE '2024-06-10', DATE '2024-06-09', 'Devolvido', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (3, '9780132312333', 155, 7, DATE '2024-06-05', DATE '2024-06-12', NULL, 'Em atraso', 5.00, 'Atraso de devolução', DATE '2024-06-20', 'Pendente');
INSERT INTO RealizaEmprestimo VALUES (4, '9780134310884', 102, 5, DATE '2024-06-11', DATE '2024-06-18', NULL, 'Em aberto', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (9, '9781111111111', 301, 9, SYSDATE - 30, SYSDATE - 15, SYSDATE - 14, 'Devolvido', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (10, '9782222222222', 302, 10, SYSDATE - 20, SYSDATE - 5, NULL, 'Em aberto', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (11, '9783333333333', 303, 11, SYSDATE - 10, SYSDATE + 5, NULL, 'Em aberto', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (12, '9784444444444', 304, 12, SYSDATE - 5, SYSDATE + 10, NULL, 'Em aberto', NULL, NULL, NULL, NULL);
INSERT INTO RealizaEmprestimo VALUES (13, '9785555555555', 305, 13, SYSDATE - 1, SYSDATE + 14, NULL, 'Em aberto', NULL, NULL, NULL, NULL);
