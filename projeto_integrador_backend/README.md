# Projeto Integrador - Backend

## Descrição

Backend desenvolvido em Java com Spring Boot para o sistema de levantamento e gerenciamento de dados de propriedades rurais.

## Tecnologias Utilizadas

- **Java 17**
- **Spring Boot 3.1.5**
- **Spring Security com JWT**
- **JPA/Hibernate**
- **PostgreSQL**
- **Maven**

## Pré-requisitos

- Java 17 ou superior
- Maven 3.6+
- PostgreSQL 12+
- Git

## Configuração do Banco de Dados

### 1. Criar banco de dados PostgreSQL

```bash
# Conectar ao PostgreSQL
psql -U postgres

# Criar banco de dados
CREATE DATABASE projeto_integrador;

# Criar usuário (opcional)
CREATE USER projeto_user WITH PASSWORD 'projeto_password';
ALTER ROLE projeto_user SET client_encoding TO 'utf8';
ALTER ROLE projeto_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE projeto_user SET default_transaction_deferrable TO on;
ALTER ROLE projeto_user SET default_transaction_read_only TO off;
GRANT ALL PRIVILEGES ON DATABASE projeto_integrador TO projeto_user;
```

### 2. Configurar arquivo `application.properties`

Edite o arquivo `src/main/resources/application.properties` com suas credenciais do PostgreSQL:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/projeto_integrador
spring.datasource.username=postgres
spring.datasource.password=postgres
```

## Instalação e Execução

### 1. Clonar o repositório

```bash
git clone <seu_repositorio>
cd projeto_integrador_backend
```

### 2. Instalar dependências

```bash
mvn clean install
```

### 3. Executar a aplicação

```bash
mvn spring-boot:run
```

A API estará disponível em: `http://localhost:8080/api`

## Endpoints da API

### Autenticação

- **POST** `/api/auth/login` - Realizar login
  ```json
  {
    "email": "admin@example.com",
    "senha": "password123"
  }
  ```

### Usuários (Requer role ADMINISTRADOR)

- **GET** `/api/users` - Listar todos os usuários
- **GET** `/api/users/{id}` - Obter usuário por ID
- **POST** `/api/users` - Criar novo usuário
  ```json
  {
    "nome": "Novo Usuário",
    "email": "novo@example.com",
    "senha": "password123",
    "telefone": "11999999999",
    "tipoUsuario": "COMUM"
  }
  ```
- **PUT** `/api/users/{id}` - Atualizar usuário
- **DELETE** `/api/users/{id}` - Deletar usuário

### Propriedades (Requer autenticação)

- **GET** `/api/properties` - Listar todas as propriedades
- **GET** `/api/properties/{id}` - Obter propriedade por ID
- **GET** `/api/properties/usuario/{idUsuario}` - Listar propriedades por usuário
- **POST** `/api/properties` - Criar nova propriedade
  ```json
  {
    "nome": "Fazenda A",
    "localidade": "Rural",
    "cidade": "Santa Maria",
    "telefone": "5533999999",
    "areaTotal": 100.50,
    "latitude": -29.6834,
    "longitude": -53.8082,
    "idUsuario": 1
  }
  ```
- **PUT** `/api/properties/{id}` - Atualizar propriedade
- **DELETE** `/api/properties/{id}` - Deletar propriedade

## Autenticação com JWT

Todos os endpoints (exceto `/auth/login`) requerem um token JWT no header:

```
Authorization: Bearer <seu_token_jwt>
```

## Estrutura do Projeto

```
projeto_integrador_backend/
├── src/main/java/com/projetointegrador/
│   ├── controller/          # Controladores REST
│   ├── service/             # Lógica de negócio
│   ├── repository/          # Acesso a dados
│   ├── model/               # Entidades JPA
│   ├── dto/                 # Data Transfer Objects
│   ├── config/              # Configurações (Security, JWT)
│   └── ProjetoIntegradorApplication.java
├── src/main/resources/
│   └── application.properties
├── pom.xml
└── README.md
```

## Dados Iniciais

Para criar dados iniciais no banco, você pode usar o seguinte SQL:

```sql
-- Inserir usuário administrador
INSERT INTO usuario (nome, email, senha, telefone, tipo_usuario) 
VALUES ('Administrador', 'admin@example.com', '$2a$10$...', '5533999999', 'ADMINISTRADOR');

-- Inserir usuário comum
INSERT INTO usuario (nome, email, senha, telefone, tipo_usuario) 
VALUES ('Usuário Comum', 'user@example.com', '$2a$10$...', '5533999999', 'COMUM');
```

**Nota:** As senhas devem estar criptografadas com BCrypt.

## Troubleshooting

### Erro de conexão com PostgreSQL
- Verifique se o PostgreSQL está rodando
- Confirme as credenciais no `application.properties`
- Verifique se o banco de dados existe

### Erro de porta já em uso
- Mude a porta em `application.properties`: `server.port=8081`

### Erro de JWT
- Verifique se o token está sendo enviado corretamente no header
- Confirme se o token não expirou

## Próximos Passos

1. Implementar endpoints para Entrevista e Produção
2. Adicionar validações mais robustas
3. Implementar tratamento de erros global
4. Adicionar testes unitários e de integração
5. Documentação com Swagger/OpenAPI

## Contato

Para dúvidas ou sugestões, entre em contato com a equipe de desenvolvimento.
