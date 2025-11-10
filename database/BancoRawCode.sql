CREATE DATABASE raw_code CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE raw_code;

CREATE TABLE usuarios(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
senha VARCHAR(25) NOT NULL,
tipo ENUM('admin','cliente') DEFAULT 'cliente',
data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produtos(
id_produto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
descricao TEXT,
preco DECIMAL(10,2) NOT NULL,
categoria ENUM('colar','pulseira','anel') NOT NULL,
imagem VARCHAR(255),
estoque INT DEFAULT 0,
data_adicionada DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE carrinho(
id_carrinho INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT NOT NULL,
id_produto INT NOT NULL,
quantidade INT DEFAULT 1,
data_adicao DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
FOREIGN KEY (id_produto) REFERENCES produtos(id_produtos)
);

CREATE TABLE pedidos (
id_pedido INT AUTO_INCREMENT PRIMARY KEY,
id_usuario INT NOT NULL,
data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
stats ENUM('pendente','pago','enviado','entregue') DEFAULT 'pendente',
total DECIMAL(10,2) NOT NULL,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE itens_pedido (
id_item INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
id_produto INT NOT NULL,
quantidade INT NOT NULL,
preco_unitario DECIMAL(10,2) NOT NULL,
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO produtos (nome, descricao, preco, categoria, imagem, estoque)
VALUES
('Colar de Aço Inoxidável', 'Colar masculino em aço, resistente e elegante.', 79.90, 'colar', 'img/colar1.jpg', 10),
('Pulseira de Couro Preta', 'Pulseira de couro legítimo com fecho magnético.', 59.90, 'pulseira', 'img/pulseira1.jpg', 20),
('Anel Viking', 'Anel em aço escovado estilo viking.', 49.90, 'anel', 'img/anel1.jpg', 15);

INSERT INTO usuarios (nome, email, senha, tipo)
VALUES ('Administrador', 'admin@loja.com', '123', 'admin');