-- Comandos utilizados: RECORD
-- Objetivo: Buscar nome curso e data do último empréstimo de um aluno (o com id = 1)

DECLARE
    TYPE AlunoRecord IS RECORD (
        nome                   Pessoa.nome%TYPE,
        curso                  Matricula.curso%TYPE,
        data_ultimo_emprestimo RealizaEmprestimo.data_emprestimo%TYPE
    );
    v_info AlunoRecord;
BEGIN
    SELECT p.nome,
           m.curso,
           MAX(e.data_emprestimo)
      INTO v_info.nome,
           v_info.curso,
           v_info.data_ultimo_emprestimo
    FROM Aluno a
    JOIN Pessoa p
      ON p.id = a.id_aluno
    JOIN Matricula m
      ON m.matricula = a.matricula
    LEFT JOIN RealizaEmprestimo e
      ON e.id_aluno = a.id_aluno
    WHERE a.id_aluno = 1
    GROUP BY p.nome, m.curso;

    DBMS_OUTPUT.PUT_LINE(
      'Nome: ' || v_info.nome ||
      ' | Curso: ' || v_info.curso ||
      ' | Último Empréstimo: ' || 
      TO_CHAR(v_info.data_ultimo_emprestimo, 'DD/MM/YYYY HH24:MI:SS')
    );
END;
/

------------------------------------------------------------

-- Comandos utilizados: ESTRUTURA DE DADOS DO TIPO TABLE
-- Objetivo: Criar uma collection com os nomes dos alunos que tem multa pendente

DECLARE
    TYPE AlunoMultado IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    v_multados AlunoMultado;
    idx PLS_INTEGER := 0;
BEGIN
    FOR rec IN (
        SELECT DISTINCT p.nome
          FROM RealizaEmprestimo re
          JOIN Aluno a
            ON a.id_aluno = re.id_aluno
          JOIN Pessoa p
            ON p.id = a.id_aluno
         WHERE re.status_multa = 'Pendente'
    ) LOOP
        idx := idx + 1;
        v_multados(idx) := rec.nome;
    END LOOP;

    IF v_multados.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum aluno com multa pendente.');
    ELSE
        FOR i IN 1..v_multados.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('Aluno com multa pendente: ' || v_multados(i));
        END LOOP;
    END IF;
END;
/

------------------------------------------------------------

-- Comandos utilizados: BLOCO ANÔNIMO
-- Objetivo: Verificar se a nota mais recente de avaliação de um exemplar está abaixo de 7

DECLARE
    v_nota Avaliacao.nota%TYPE;
    v_data Avaliacao.data_avaliacao%TYPE;
BEGIN
    SELECT nota, data_avaliacao
      INTO v_nota, v_data
      FROM (
            SELECT nota, data_avaliacao
              FROM Avaliacao
             WHERE isbn = '9780134310884'
               AND numero_patrimonio = 102
             ORDER BY data_avaliacao DESC
           )
     WHERE ROWNUM = 1;

    IF v_nota < 7 THEN
        DBMS_OUTPUT.PUT_LINE(
          'Atenção! Nota ' || v_nota ||
          ' registrada em ' || TO_CHAR(v_data, 'DD/MM/YYYY')
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nota aceitável: ' || v_nota);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma avaliação encontrada para esse exemplar.');
END;
/

------------------------------------------------------------

-- Comandos utilizados: CREATE PROCEDURE
-- Objetivo: Aplicar multa de 10$ a todos os empréstimos atrasados e não devolvidos

CREATE OR REPLACE PROCEDURE aplicar_multas IS
    v_rows_updated PLS_INTEGER;
BEGIN
    UPDATE RealizaEmprestimo
       SET valor_multa          = 10,
           motivo_multa         = 'Atraso na devolução',
           data_aplicacao_multa = SYSDATE,
           status_multa         = 'Pendente'
     WHERE data_prevista < TRUNC(SYSDATE)
       AND data_devolucao IS NULL
       AND valor_multa IS NULL
    RETURNING COUNT(*) INTO v_rows_updated;

    DBMS_OUTPUT.PUT_LINE(v_rows_updated || ' empréstimos atualizados com multa.');
END aplicar_multas;
/

------------------------------------------------------------

-- Comandos utilizados: CREATE FUNCTION
-- Objetivo: Retornar a média das notas dadas por um funcionário nas avaliações

CREATE OR REPLACE FUNCTION media_notas_funcionario (
    p_func_id IN Funcionario.id_funcionario%TYPE
) RETURN NUMBER IS
    v_media NUMBER;
BEGIN
    SELECT AVG(nota)
      INTO v_media
      FROM Avaliacao
     WHERE id_funcionario_revisor = p_func_id;

    RETURN NVL(v_media, 0);
END media_notas_funcionario;
/

------------------------------------------------------------

-- Comandos utilizados: %TYPE
-- Objetivo: Exibir informaçes detalhadas de um aluno com consistencia de tipos usando %TYPE

DECLARE
    v_id_pessoa   Pessoa.id%TYPE;
    v_nome        Pessoa.nome%TYPE;
    v_email       Pessoa.email%TYPE;
    v_curso       Matricula.curso%TYPE;
    v_semestre    Matricula.semestre%TYPE;
BEGIN
    SELECT p.id, p.nome, p.email, m.curso, m.semestre
      INTO v_id_pessoa, v_nome, v_email, v_curso, v_semestre
      FROM Pessoa p
      JOIN Aluno a
        ON p.id = a.id_aluno
      JOIN Matricula m
        ON a.matricula = m.matricula
     WHERE p.id = 2;

    DBMS_OUTPUT.PUT_LINE(
      'ID: ' || v_id_pessoa ||
      ' | Nome: ' || v_nome ||
      ' | Email: ' || v_email ||
      ' | Curso: ' || v_curso ||
      ' | Semestre: ' || v_semestre
    );
END;
/

------------------------------------------------------------

-- Comando utilizados: %ROWTYPE
-- Objetivo: A consulta deve reportar todas as avaliações com notas maior que 7
DECLARE
    v_ava Avaliacao%ROWTYPE;
    
BEGIN
    SELECT * INTO v_ava FROM Avaliacao WHERE nota >= 7;

    DBMS_OUTPUT.PUT_LINE('ISBN: ' || v_ava.isbn);
    DBMS_OUTPUT.PUT_LINE('Nota: ' || v_ava.nota);

END;
/

------------------------------------------------------------

--Comando utilizado: %ROWTYPE, CASE WHEN, FOR LOOP
--Objetivos: A consulta deve analisar o estado de conservação dos exemplares e exibir apenas aqueles que estejam disponiveis tanto o isbn como o seu estado
DECLARE
    v_exemplares Exemplares%ROWTYPE;
BEGIN
    SELECT  *INTO v_exemplares FROM Exemplares WHERE disponivel = 'S';
    FOR i IN (SELECT v_exemplares.isbn) LOOP
        BEGIN
            CASE 
                WHEN v_exemplares.estado_conservacao = 'Ótimo' THEN
                 DBMS_OUTPUT.PUT_LINE(v_exeomplares.isbn ||'Esta em ótimo estado');
                WHEN v_exemplares.estado_conservacao = 'Bom' THEN
                 DBMS_OUTPUT.PUT_LINE(v_exeomplares.isbn ||'Tem boa qualidade');
                WHEN v_exemplares.estado_conservacao = 'Regular' THEN
                 DBMS_OUTPUT.PUT_LINE(v_exeomplares.isbn ||'É utilizavel');
            END CASE;
    END LOOP;
END;
/

------------------------------------------------------------
    
--Comandos utilizados: IF ELSEIF, LOOP EXIT
--Objetivos: Retorna quantos números cadastrados cada pessoa possui
DECLARE
    
    CURSOR c_pessoas IS
        SELECT id, nome FROM Pessoa;

   
    v_id Pessoa.id%TYPE;
    v_nome Pessoa.nome%TYPE;
    v_qtd_telefones NUMBER;
BEGIN
    OPEN c_pessoas;
    
    LOOP
        FETCH c_pessoas INTO v_id, v_nome;
        EXIT WHEN c_pessoas%NOTFOUND;

        SELECT COUNT(*) INTO v_qtd_telefones
        FROM Telefone
        WHERE id_pessoa = v_id;

        IF v_qtd_telefones = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Pessoa "' || v_nome || '" não possui telefone cadastrado.');
        ELSIF v_qtd_telefones = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Pessoa "' || v_nome || '" possui 1 telefone cadastrado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Pessoa "' || v_nome || '" possui ' || v_qtd_telefones || ' telefones cadastrados.');
        END IF;
    END LOOP;

    CLOSE c_pessoas;
END;
/

------------------------------------------------------------
    
--Comando utilizado: WHILE LOOP 
--Objetivo: Retorna o número de avaliações que cada funcionario revisou
DECLARE
    v_id_func NUMBER := 5;  
    v_qtd_avaliacoes NUMBER;
    v_nome_funcionario Pessoa.nome%TYPE;
BEGIN
    WHILE v_id_func <= 13 LOOP
       
        SELECT nome INTO v_nome_funcionario
        FROM Pessoa
        WHERE id = v_id_func;

        SELECT COUNT(*) INTO v_qtd_avaliacoes
        FROM Avaliacao
        WHERE id_funcionario_revisor = v_id_func;

        DBMS_OUTPUT.PUT_LINE('Funcionário "' || v_nome_funcionario || '" revisou ' || v_qtd_avaliacoes || ' avaliações.');

        v_id_func := v_id_func + 1;
    END LOOP;
END;
/

------------------------------------------------------------

-- 14. CURSOR
-- Comandos utilizados: CURSOR, SELECT, FROM, JOIN, LOOP, DBMS_OUTPUT
-- Objetivo: Listar os livros disponíveis no estoque com seus respectivos patrimônios
DECLARE
    CURSOR c_livros_disponiveis IS
        SELECT l.titulo, e.numero_patrimonio
        FROM Livro l
        JOIN Exemplar e ON l.isbn = e.isbn
        WHERE e.disponivel = 'S';
    
    v_titulo Livro.titulo%TYPE;
    v_patrimonio Exemplar.numero_patrimonio%TYPE;
BEGIN
    OPEN c_livros_disponiveis;
    
    LOOP
        FETCH c_livros_disponiveis INTO v_titulo, v_patrimonio;
        EXIT WHEN c_livros_disponiveis%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Título: ' || v_titulo || ' | Patrimônio: ' || v_patrimonio);
    END LOOP;
    
    CLOSE c_livros_disponiveis;
END;
/

------------------------------------------------------------

-- 15. EXCEPTION WHEN
-- Comandos utilizados: EXCEPTION WHEN, SELECT, FROM
-- Objetivo: Buscar um aluno por ID e tratar o caso em que ele não existe
DECLARE
    v_nome Pessoa.nome%TYPE;
BEGIN
    SELECT nome INTO v_nome
    FROM Pessoa
    WHERE id = 99; -- ID inexistente para testar exceção
    
    DBMS_OUTPUT.PUT_LINE('Nome do aluno: ' || v_nome);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aluno não encontrado.');
END;
/

------------------------------------------------------------

-- 16. USO DE PARÂMETROS (IN, OUT ou IN OUT)
-- Comandos utilizados: CREATE PROCEDURE, SELECT, FROM, EXCEPTION WHEN
-- Objetivo: Criar um procedimento que retorna o nome do aluno dado o ID
CREATE OR REPLACE PROCEDURE obter_nome_aluno (
    p_id_aluno IN Aluno.id_aluno%TYPE,
    p_nome OUT Pessoa.nome%TYPE
) IS
BEGIN
    SELECT nome INTO p_nome
    FROM Pessoa
    WHERE id = p_id_aluno;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_nome := 'Aluno não encontrado';
END;
/

-- Comandos utilizados: CALL PROCEDURE, DBMS_OUTPUT
-- Objetivo: Chamar o procedimento que retorna o nome do aluno
DECLARE
    v_nome Pessoa.nome%TYPE;
BEGIN
    obter_nome_aluno(1, v_nome);
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
END;
/

------------------------------------------------------------

-- 17/18. CREATE OR REPLACE PACKAGE / CREATE OR REPLACE PACKAGE BODY
-- Comandos utilizados: CREATE PACKAGE, CREATE PACKAGE BODY, FOR LOOP, SELECT, FROM, DBMS_OUTPUT
-- Objetivo: Criar um pacote para listar livros por categoria
CREATE OR REPLACE PACKAGE pkg_livros IS
    PROCEDURE listar_livros_por_categoria(p_categoria IN Livro.categoria%TYPE);
END pkg_livros;
/

CREATE OR REPLACE PACKAGE BODY pkg_livros IS
    PROCEDURE listar_livros_por_categoria(p_categoria IN Livro.categoria%TYPE) IS
    BEGIN
        FOR r IN (
            SELECT titulo, ano_publicacao
            FROM Livro
            WHERE categoria = p_categoria
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Título: ' || r.titulo || ' | Ano: ' || r.ano_publicacao);
        END LOOP;
    END listar_livros_por_categoria;
END pkg_livros;
/

-- Comandos utilizados: CALL PROCEDURE, DBMS_OUTPUT
-- Objetivo: Chamar o pacote para listar livros da categoria 'Tecnologia'
BEGIN
    pkg_livros.listar_livros_por_categoria('Tecnologia');
END;
/

------------------------------------------------------------

-- 19. CREATE OR REPLACE TRIGGER (COMANDO)
-- Comandos utilizados: CREATE TRIGGER, SELECT, FROM, RAISE_APPLICATION_ERROR
-- Objetivo: Impedir a exclusão de livros que possuem exemplares cadastrados
CREATE OR REPLACE TRIGGER trg_bloqueia_delete_livro
BEFORE DELETE ON Livro
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Exemplar
    WHERE isbn = :OLD.isbn;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Não é possível excluir livro com exemplares cadastrados.');
    END IF;
END;
/

------------------------------------------------------------

-- 20. CREATE OR REPLACE TRIGGER (LINHA)
-- Comandos utilizados: CREATE TRIGGER
-- Objetivo: Preencher automaticamente o campo status_multa quando valor_multa for informado
CREATE OR REPLACE TRIGGER trg_status_multa
BEFORE INSERT OR UPDATE ON RealizaEmprestimo
FOR EACH ROW
BEGIN
    IF :NEW.valor_multa IS NOT NULL AND :NEW.status_multa IS NULL THEN
        :NEW.status_multa := 'Pendente';
    END IF;
END;
/
