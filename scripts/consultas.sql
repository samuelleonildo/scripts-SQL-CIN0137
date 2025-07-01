
/* 1. Vamos adicionar uma coluna 'data_desativacao' à tabela Aluno. */
ALTER TABLE Aluno ADD data_desativacao DATE;


/*
    2. Criar um índice na coluna 'titulo' da tabela 'Livro' para acelerar
    as consultas de livros pelo título.
*/
CREATE INDEX idx_livro_titulo ON Livro(titulo);


/* 3. povoando mais uma pessoa */
INSERT INTO Pessoa (id, nome, email, cpf, rua, numero, bairro, cep_end)
VALUES (seq_pessoa.NEXTVAL, 'Sofia Oliveira', 'sofia.o@email.com', '15975385245', 'Rua das Flores', '500', 'Graças', '50000000');

INSERT INTO Telefone (id_telefone, id_pessoa, numero)
VALUES (seq_telefone.NEXTVAL, 14, '81912345678');

INSERT INTO Aluno (id_aluno, matricula)
VALUES (14, '2026006');

INSERT INTO Matricula (matricula, curso, semestre)
VALUES ('2026006', 'Design Gráfico', 1);


/* 4. Multando quem está em atraso com uma multa de R$ 1,50 por dia */
UPDATE RealizaEmprestimo
SET
    situacao = 'Em atraso',
    valor_multa = (SYSDATE - data_prevista) * 1.50, 
    motivo_multa = 'Atraso na devolução do exemplar',
    data_aplicacao_multa = SYSDATE,
    status_multa = 'Pendente'
WHERE
    situacao = 'Em aberto' AND data_prevista < SYSDATE;


/* 5. Anonimizando as avaliações do funcionário 7;
    passando as responsabilidades dos empréstimos e supervisão para o funcionario 6;
    demitindo o funcionário 7 em seguida */
UPDATE Avaliacao SET id_funcionario_revisor = NULL WHERE id_funcionario_revisor = 7;
UPDATE RealizaEmprestimo SET id_funcionario = 6 WHERE id_funcionario = 7;
UPDATE Funcionario SET id_supervisor = 6 WHERE id_supervisor = 7;
DELETE FROM Funcionario WHERE id_funcionario = 7;

/*
    6. Localizar o nome e o e-mail de todos os alunos
     que possuem empréstimos com situação 'Em atraso'.
*/
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


/*
    7. consultar lista todos os funcionários que foram admitidos
    durante o ano de 2023
*/
SELECT
    p.nome,
    f.cargo,
    f.data_admissao
FROM Funcionario f
JOIN Pessoa p ON f.id_funcionario = p.id
WHERE f.data_admissao BETWEEN DATE '2023-01-01' AND DATE '2023-12-31'
ORDER BY f.data_admissao;


/* 8. buscar todos os alunos matriculados em cursos específicos da área de tecnologia */
SELECT
    p.nome AS nome_aluno,
    m.curso
FROM Pessoa p
JOIN Aluno a ON p.id = a.id_aluno
JOIN Matricula m ON a.matricula = m.matricula
WHERE m.curso IN ('Engenharia de Software', 'Ciência da Computação', 'Sistemas de Informação')
ORDER BY m.curso, p.nome;


/* 9. Encontrando qualquer autor cujo nome contenha 'Robert' ou 'Carlos' */
SELECT
    al.autor,
    l.titulo AS livro
FROM Autor_Livro al
JOIN Livro l ON al.isbn = l.isbn
WHERE al.autor LIKE '%Robert%' OR al.autor LIKE '%Carlos%'
ORDER BY al.autor;


/*
    10. Busca todos os funcionários que não possuem supervisor
    (ou seja, os líderes)
*/
SELECT
    p.nome,
    f.cargo,
    f.data_admissao
FROM Pessoa p
JOIN Funcionario f ON p.id = f.id_funcionario
WHERE f.id_supervisor IS NULL;

/*
    11. listar todos os exemplares de livros que estão
    atualmente disponíveis para empréstimo
*/
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