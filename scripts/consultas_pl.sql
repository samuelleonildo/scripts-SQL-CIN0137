-- Comando utilizados: %ROWTYPE
-- Objetivo: A consulta deve reportar todas as avaliações com notas maior que 7
DECLARE
    v_ava Avaliacao%ROWTYPE;
    
BEGIN
    SELECT * INTO v_ava FROM Avaliacao WHERE nota >= 7;

    DBMS_OUTPUT.PUT_LINE('ISBN: ' || v_ava.isbn);
    DBMS_OUTPUT.PUT_LINE('Nota: ' || v_ava.nota);

END;

--Comando utikizado: %ROWTYPE, CASE WHEN, FOR LOOP
--Objetivos: A consulta deve analisar o estado de conservação dos exemplares e exibir apenas aqueles que estjam disponeiveis tanto o isbn como o seu estado
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
