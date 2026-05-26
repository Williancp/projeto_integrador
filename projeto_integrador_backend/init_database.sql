-- Script de inicialização do banco de dados PostgreSQL
-- Execute este script para criar as tabelas e inserir dados iniciais

-- Criar tabela de usuários
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    tipo_usuario VARCHAR(50) NOT NULL CHECK (tipo_usuario IN ('ADMINISTRADOR', 'COMUM'))
);

-- Criar tabela de propriedades
CREATE TABLE IF NOT EXISTS propriedade (
    id_propriedade SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    localidade VARCHAR(255),
    cidade VARCHAR(255),
    telefone VARCHAR(20),
    area_total DECIMAL(10, 2),
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    id_usuario INTEGER NOT NULL,
    data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Criar índices para melhor performance
CREATE INDEX IF NOT EXISTS idx_propriedade_id_usuario ON propriedade(id_usuario);
CREATE INDEX IF NOT EXISTS idx_usuario_email ON usuario(email);

-- Inserir usuário administrador (senha: admin123 - BCrypt)
-- Para gerar a senha criptografada, use: https://bcrypt-generator.com/
-- Senha: admin123 -> $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36gZvWFm
INSERT INTO usuario (nome, email, senha, telefone, tipo_usuario) 
VALUES ('Administrador', 'adm@123', 'adm123', '5533999999', 'ADMINISTRADOR')
ON CONFLICT (email) DO NOTHING;

-- Inserir usuário comum (senha: user123 - BCrypt)
-- Senha: user123 -> $2a$10$slYQmyNdGzin7olVN3p5Be7DlH.PKZbv5H8KnzzVgXXbVxzy7QCLM
INSERT INTO usuario (nome, email, senha, telefone, tipo_usuario) 
VALUES ('Usuário Comum', 'user@example.com', '$2a$10$slYQmyNdGzin7olVN3p5Be7DlH.PKZbv5H8KnzzVgXXbVxzy7QCLM', '5533888888', 'COMUM')
ON CONFLICT (email) DO NOTHING;

-- Inserir propriedades de exemplo
INSERT INTO propriedade (nome, localidade, cidade, telefone, area_total, latitude, longitude, id_usuario) 
VALUES 
('Fazenda Santa Maria', 'Rural', 'Santa Maria', '5533999999', 150.50, -29.6834, -53.8082, 1),
('Propriedade do João', 'Zona Rural', 'Novo Hamburgo', '5133888888', 75.25, -29.7625, -51.1375, 2),
('Sítio Verde', 'Interior', 'Carazinho', '5432777777', 45.00, -28.2833, -52.7833, 2)
ON CONFLICT DO NOTHING;

-- Exibir dados inseridos
SELECT 'Usuários cadastrados:' as info;
SELECT id_usuario, nome, email, tipo_usuario FROM usuario;

SELECT 'Propriedades cadastradas:' as info;
SELECT id_propriedade, nome, cidade, area_total FROM propriedade;
