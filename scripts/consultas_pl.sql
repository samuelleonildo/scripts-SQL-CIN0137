-- Comando utilizados: %ROWTYPE
-- Objetivo: A consulta deve reportar todas as avaliações com notas maior que 7
DECLARE
    v_ava Avaliacao%ROWTYPE;
    
BEGIN
    SELECT * INTO v_ava FROM Avaliacao WHERE nota >= 7;

    DBMS_OUTPUT.PUT_LINE('ISBN: ' || v_ava.isbn);
    DBMS_OUTPUT.PUT_LINE('Nota: ' || v_ava.nota);

END;

--Comando utikizado: IF ELSE
--
