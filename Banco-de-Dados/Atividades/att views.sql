-- ============================================
-- 1. CLIENTES + VIEW vw_clientes_pr
-- ============================================

CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2)
);

INSERT INTO clientes (nome, cidade, estado) VALUES
('João Silva', 'Curitiba', 'PR'),
('Maria Souza', 'Londrina', 'PR'),
('Carlos Oliveira', 'São Paulo', 'SP'),
('Ana Santos', 'Maringá', 'PR'),
('Pedro Costa', 'Florianópolis', 'SC');

CREATE VIEW vw_clientes_pr AS
SELECT id, nome, cidade
FROM clientes
WHERE estado = 'PR';


-- ============================================
-- 2. PEDIDOS + VIEW vw_pedidos_clientes
-- ============================================

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    data_pedido DATE,
    valor DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

INSERT INTO pedidos (cliente_id, data_pedido, valor) VALUES
(1, '2026-09-01', 150.00),
(2, '2026-09-02', 250.00),
(3, '2026-09-03', 100.00),
(4, '2026-09-04', 300.00),
(5, '2026-09-05', 200.00);

CREATE VIEW vw_pedidos_clientes AS
SELECT
    clientes.nome,
    pedidos.data_pedido,
    pedidos.valor
FROM clientes
INNER JOIN pedidos
    ON clientes.id = pedidos.cliente_id;


-- ============================================
-- 3. PRODUTOS + VIEW vw_valor_estoque
-- ============================================

CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

INSERT INTO produtos (nome, preco, estoque) VALUES
('Mouse', 50.00, 10),
('Teclado', 100.00, 5),
('Monitor', 800.00, 3),
('Headset', 150.00, 8),
('Webcam', 200.00, 4);

CREATE VIEW vw_valor_estoque AS
SELECT
    nome,
    preco AS preco_unitario,
    estoque AS quantidade_estoque,
    preco * estoque AS valor_total
FROM produtos;


-- ============================================
-- 4. VIEW vw_total_clientes
-- ============================================

CREATE VIEW vw_total_clientes AS
SELECT
    clientes.nome,
    COUNT(pedidos.id) AS quantidade_pedidos,
    SUM(pedidos.valor) AS valor_total_gasto
FROM clientes
INNER JOIN pedidos
    ON clientes.id = pedidos.cliente_id
GROUP BY clientes.id, clientes.nome;


-- ============================================
-- 5. VENDEDORES + VENDAS
-- VIEW vw_desempenho_vendedores
-- ============================================

CREATE TABLE vendedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vendedor_id INT,
    valor DECIMAL(10,2),
    FOREIGN KEY (vendedor_id) REFERENCES vendedores(id)
);

INSERT INTO vendedores (nome) VALUES
('Rafael'),
('Lucas'),
('Fernanda'),
('Juliana'),
('Bruno');

INSERT INTO vendas (vendedor_id, valor) VALUES
(1, 500.00),
(1, 800.00),
(2, 300.00),
(2, 700.00),
(3, 1000.00),
(3, 600.00),
(4, 450.00),
(4, 900.00),
(5, 250.00),
(5, 750.00);

CREATE VIEW vw_desempenho_vendedores AS
SELECT
    vendedores.nome,
    COUNT(vendas.id) AS quantidade_vendas,
    SUM(vendas.valor) AS valor_total_vendido,
    AVG(vendas.valor) AS valor_medio_vendas,
    MAX(vendas.valor) AS maior_venda
FROM vendedores
INNER JOIN vendas
    ON vendedores.id = vendas.vendedor_id
GROUP BY vendedores.id, vendedores.nome;

SELECT * FROM vw_clientes_pr;

SELECT * FROM vw_pedidos_clientes;

SELECT * FROM vw_valor_estoque;

SELECT * FROM vw_total_clientes;

SELECT * FROM vw_desempenho_vendedores;
