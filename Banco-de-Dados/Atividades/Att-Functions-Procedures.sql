-- 1. FUNCTION DE DOBRO
DELIMITER //

CREATE FUNCTION dobro(numero INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN numero * 2;
END //

DELIMITER ;


-- Teste da Function
SELECT dobro(10);

-- 2. FUNCTION DE SITUAÇÃO DO ALUNO

DELIMITER //

CREATE FUNCTION situacao_aluno(media DECIMAL(5,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF media >= 6 THEN
        RETURN 'Aprovado';

    ELSEIF media >= 4 THEN
        RETURN 'Recuperação';

    ELSE
        RETURN 'Reprovado';
    END IF;
END //

DELIMITER ;


-- Testes da Function
SELECT situacao_aluno(8);
SELECT situacao_aluno(5);
SELECT situacao_aluno(3);


-- 3. PROCEDURE DE CONSULTA

DELIMITER //

CREATE PROCEDURE buscar_alunos_por_idade(IN idade_minima INT)
BEGIN
    SELECT
        id,
        nome,
        idade,
        nota1,
        nota2
    FROM alunos
    WHERE idade >= idade_minima;
END //

DELIMITER ;


-- Teste da Procedure
CALL buscar_alunos_por_idade(18);


-- 4. PROCEDURE DE ATUALIZAÇÃO

DELIMITER //

CREATE PROCEDURE aumentar_nota(
    IN aluno_id INT,
    IN valor_aumento DECIMAL(5,2)
)
BEGIN
    UPDATE alunos
    SET nota1 = nota1 + valor_aumento
    WHERE id = aluno_id;
END //

DELIMITER ;


-- Teste da Procedure
CALL aumentar_nota(5, 1);


-- 5. FUNCTION PARA CALCULAR A MÉDIA

DELIMITER //

CREATE FUNCTION calcular_media(
    nota1 DECIMAL(5,2),
    nota2 DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    RETURN (nota1 + nota2) / 2;
END //

DELIMITER ;


-- Teste da Function
SELECT calcular_media(8, 6);


DELIMITER //

CREATE PROCEDURE mostrar_situacao(IN aluno_id INT)
BEGIN
    SELECT
        nome,
        nota1,
        nota2,
        calcular_media(nota1, nota2) AS media,
        situacao_aluno(calcular_media(nota1, nota2)) AS situacao
    FROM alunos
    WHERE id = aluno_id;
END //

DELIMITER ;


-- Teste da Procedure
CALL mostrar_situacao(5);
