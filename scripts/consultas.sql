-- Comandos utilizados: ALTER TABLE
-- Objetivo: Adicionar uma coluna 'data_desativacao' à tabela Aluno.
ALTER TABLE Aluno ADD data_desativacao DATE;


-- Comandos utilizados: CREATE INDEX
-- Objetivo: Criar um índice na coluna 'titulo' da tabela 'Livro' para acelerar as consultas de livros pelo título.
CREATE INDEX idx_livro_titulo ON Livro(titulo);

-- Comandos utilizados: INSERT INTO
-- Objetivo: Adicionar mais um aluno, Sofia Oliveira, com seus respectivos dados e matrícula.
INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'Sofia Oliveira', 'sofia.o@email.com', '15975385245', 'Rua das Flores', '500', 'Graças', '50000000');

INSERT INTO Telefone (id_telefone, id_pessoa, numero)
VALUES (seq_telefone.NEXTVAL, 14, '81912345678');

INSERT INTO Aluno (id_aluno, matricula)
VALUES (14, '2026006');

INSERT INTO Matricula (matricula, curso, semestre)
VALUES ('2026006', 'Design Gráfico', 1);

-- Comandos utilizados: UPDATE SET E WHERE
-- Objetivo: Multar quem está em atraso com uma multa de R$ 1,50 por dia.
UPDATE RealizaEmprestimo
SET
    situacao = 'Em atraso',
    valor_multa = (SYSDATE - data_prevista) * 1.50, 
    motivo_multa = 'Atraso na devolução do exemplar',
    data_aplicacao_multa = SYSDATE,
    status_multa = 'Pendente'
WHERE
    situacao = 'Em aberto' AND data_prevista < SYSDATE;


-- Comandos utilizados: UPDATE SET, WHERE E DELETE FROM
-- Objetivo: 
--         - Anonimizar as avaliações do funcionário 7;
--         - Passar as responsabilidades dos empréstimos e supervisão para o funcionario 6;
--         - E por fim, demitir o funcionário 7.
UPDATE Avaliacao SET id_funcionario_revisor = NULL WHERE id_funcionario_revisor = 7;
UPDATE RealizaEmprestimo SET id_funcionario = 6 WHERE id_funcionario = 7;
UPDATE Funcionario SET id_supervisor = 6 WHERE id_supervisor = 7;
DELETE FROM Funcionario WHERE id_funcionario = 7;

-- Comandos utilizados: SELECT-FROM-WHERE
-- Objetivo: Localizar o nome e o e-mail de todos os alunos que possuem empréstimos com situação 'Em atraso'.
SELECT
    p.nome,
    p.email,
    l.titulo,
    re.data_prevista
FROM Pessoa p
JOIN Aluno a ON p.id = a.id_aluno
JOIN RealizaEmprestimo re ON a.id_aluno = re.id_aluno
JOIN Livro l ON re.isbn = l.isbn
WHERE re.situacao = 'Em atraso';

-- Comandos utilizados: SELECT-FROM-WHERE, BEETWEEN E ORDER BY
-- Objetivo: Essa consulta deve listar todos os funcionários que foram admitidos durante o ano de 2023.

SELECT
    p.nome,
    f.cargo,
    f.data_admissao
FROM Funcionario f
JOIN Pessoa p ON f.id_funcionario = p.id
WHERE f.data_admissao BETWEEN DATE '2023-01-01' AND DATE '2023-12-31'
ORDER BY f.data_admissao;
 
-- Comandos utilizados: SELECT-FROM-WHERE, JOIN, ORDER BY E IN
-- Objetivo: Essa consulta deve mostrar todos os alunos matriculados em cursos específicos da área de tecnologia.
SELECT
    p.nome AS nome_aluno,
    m.curso
FROM Pessoa p
JOIN Aluno a ON p.id = a.id_aluno
JOIN Matricula m ON a.matricula = m.matricula
WHERE m.curso IN ('Engenharia de Software', 'Ciência da Computação', 'Sistemas de Informação')
ORDER BY m.curso, p.nome;

-- Comandos utilizados: SELECT-FROM-WHERE, JOIN, ORDER BY E LIKE
-- Objetivo: Essa consulta deve buscar qualquer autor cujo nome contenha 'Robert' ou 'Carlos' 
--          (precisaremos disso futuramente para nosso sistema de busca).
SELECT
    al.autor,
    l.titulo AS livro
FROM Autor_Livro al
JOIN Livro l ON al.isbn = l.isbn
WHERE al.autor LIKE '%Robert%' OR al.autor LIKE '%Carlos%'
ORDER BY al.autor;


-- Comandos utilizados: SELECT-FROM-WHERE, JOIN E IS NULL
-- Objetivo: Essa busca deve retornar todos os funcionários que não possuem supervisor
--          (Justificativa: Quando precisarmos saber quem são os líderes).
SELECT
    p.nome,
    f.cargo,
    f.data_admissao
FROM Pessoa p
JOIN Funcionario f ON p.id = f.id_funcionario
WHERE f.id_supervisor IS NULL;

-- Comandos utilizados: SELECT-FROM-WHERE, INNER JOIN E ORDER BY
-- Objetivo: Essa busca deve retornar a lista de todos os exemplares de livros que estão atualmente disponíveis para empréstimo
SELECT
    l.titulo AS "Título",
    l.editora AS "Editora",
    e.numero_patrimonio AS "Patrimônio",
    e.estado_conservacao AS "Estado"
FROM
    Livro l
INNER JOIN
    Exemplar e ON l.isbn = e.isbn
WHERE
    e.disponivel = 'S'
ORDER BY
    l.titulo;



































/* 20. Subconsulta com All -consulta que lista todos os livros cujo ano de publicação é maior que o ano de publicação de todos os livros da categoria 'Engenharia de Software'*/
SELECT
    titulo,
    ano_publicacao,
    categoria
FROM
    Livro
WHERE
    ano_publicacao > ALL (SELECT ano_publicacao FROM Livro WHERE categoria = 'Engenharia de Software')
ORDER BY
    ano_publicacao DESC;



/* 21. ORDER BY - consulta que lista todos os alunos em ordem alfabética de nome, e para alunos com o mesmo nome, ordena pelo curso em ordem alfabética.*/
SELECT
    p.nome AS nome_aluno,
    m.curso,
    m.semestre
FROM
    Pessoa p
JOIN
    Aluno a ON p.id = a.id_aluno
JOIN
    Matricula m ON a.matricula = m.matricula
ORDER BY
    p.nome ASC, m.curso ASC;



/* 22. GROUP BY- consulta que agrupa os empréstimos por aluno e exibe a quantidade total de empréstimos realizados por eles*/
SELECT
    a.id_aluno,
    p.nome AS nome_aluno,
    COUNT(re.isbn) AS total_emprestimos_realizados
FROM
    Aluno a
JOIN
    Pessoa p ON a.id_aluno = p.id
LEFT JOIN
    RealizaEmprestimo re ON a.id_aluno = re.id_aluno
GROUP BY
    a.id_aluno, p.nome
ORDER BY
    total_emprestimos_realizados DESC;

/* 23. Having - consulta que lista as categorias de livros que possuem uma média de nota de avaliação superior a 8.5.*/
SELECT
    l.categoria,
    AVG(a.nota) AS media_nota_avaliacao
FROM
    Livro l
JOIN
    Exemplar e ON l.isbn = e.isbn
JOIN
    Avaliacao a ON e.isbn = a.isbn AND e.numero_patrimonio = a.numero_patrimonio
GROUP BY
    l.categoria
HAVING
    AVG(a.nota) > 8.5
ORDER BY
    media_nota_avaliacao DESC;

/* 24. MINUS - consulta que lista as pessoas que são apenas alunos e não estão registradas como funcionários.*/
SELECT
    p.nome AS nome_completo,
    p.email
FROM
    Pessoa p
JOIN
    Aluno a ON p.id = a.id_aluno
MINUS
SELECT
    p.nome AS nome_completo,
    p.email
FROM
    Pessoa p
JOIN
    Funcionario f ON p.id = f.id_funcionario;



/* 25.CREATE VIEW - esta view cria uma tabela virtual que exibe informações detalhadas sobre empréstimos em atraso*/
CREATE VIEW Emprestimos_Em_Atraso_View AS
SELECT
    p.nome AS nome_aluno,
    p.email AS email_aluno,
    l.titulo AS titulo_livro,
    re.data_emprestimo,
    re.data_prevista,
    re.valor_multa,
    re.motivo_multa
FROM
    RealizaEmprestimo re
JOIN
    Aluno a ON re.id_aluno = a.id_aluno
JOIN
    Pessoa p ON a.id_aluno = p.id
JOIN
    Livro l ON re.isbn = l.isbn
WHERE
    re.situacao = 'Em atraso';

-



/* 26. GRANT --concede permissões de SELECT, INSERT e UPDATE na tabela Livro ao usuário usuario_leitor */
GRANT SELECT, INSERT, UPDATE ON Livro TO usuario_leitor;

/* 26 REVOKE-- revoga as permissões de INSERT e UPDATE na tabela Livro do usuário usuario_leitor */
REVOKE INSERT, UPDATE ON Livro FROM usuario_leitor;