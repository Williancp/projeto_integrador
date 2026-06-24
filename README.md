# Projeto Integrador - Sistema de Levantamento de Dados Rurais

## 📋 Visão Geral

Aplicativo móvel completo para levantamento e gerenciamento de dados de propriedades rurais, desenvolvido como projeto integrador para a disciplina de Sistemas para Internet. O sistema implementa 50% das funcionalidades planejadas, focando em autenticação, gerenciamento de usuários (admin) e CRUD completo de propriedades.

**Status:** Entrega 3 - 50% do Sistema Implementado ✅

## 🎯 Funcionalidades Implementadas

### Autenticação
- ✅ Login com email e senha
- ✅ Validação de credenciais
- ✅ Geração de token JWT
- ✅ Persistência de sessão

### Gerenciamento de Usuários (Admin)
- ✅ Listar usuários
- ✅ Criar novo usuário
- ✅ Editar usuário
- ✅ Deletar usuário

### Gerenciamento de Propriedades (CRUD Completo)
- ✅ Listar propriedades
- ✅ Visualizar detalhes
- ✅ Criar propriedade
- ✅ Editar propriedade
- ✅ Deletar propriedade

### Interface Móvel
- ✅ Tela de login responsiva
- ✅ Home com navegação
- ✅ Lista de propriedades
- ✅ Formulário de propriedade
- ✅ Detalhes de propriedade
- ✅ Perfil do usuário

## 🛠️ Tecnologias Utilizadas

### Backend
- **Java 17** - Linguagem de programação
- **Spring Boot 3.1.5** - Framework web
- **Spring Security** - Autenticação e autorização
- **JWT** - Token-based authentication
- **JPA/Hibernate** - ORM
- **PostgreSQL** - Banco de dados relacional
- **Maven** - Gerenciador de dependências

### Frontend
- **Flutter 3.0+** - Framework móvel multiplataforma
- **Dart 3.0+** - Linguagem de programação
- **Provider** - State management
- **HTTP** - Cliente HTTP
- **Shared Preferences** - Armazenamento local

### DevOps
- **Docker** - Containerização
- **Docker Compose** - Orquestração de containers
- **Git** - Controle de versão

## 🚀 Quick Start

### Opção 1: Usando Docker (Recomendado)

```bash
# Clonar o repositório
git clone <seu_repositorio>
cd projeto_integrador

# Iniciar containers
docker-compose up -d

# Aguardar inicialização (30-60 segundos)
docker-compose logs -f backend

# A API estará disponível em: http://localhost:8080/api
```

### Opção 2: Setup Manual

```bash
# Executar script de setup
./setup.sh

# Configurar banco de dados
psql -U postgres -d projeto_integrador -f projeto_integrador_backend/init_database.sql

# Terminal 1: Executar backend
cd projeto_integrador_backend
mvn spring-boot:run

# Terminal 2: Executar frontend
cd projeto_integrador_flutter
flutter run
```

## 📱 Credenciais de Teste

| Tipo | Email | Senha |
|------|-------|-------|
| Admin | adm@123 | adm123 |
| Usuário | usuario@123 | usuario123 |

## 🧪 Testando o Sistema

### Teste de Login
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@example.com","senha":"admin123"}'
```

### Teste de CRUD de Propriedades
```bash
# Criar propriedade
curl -X POST http://localhost:8080/api/properties \
  -H "Authorization: Bearer <seu_token>" \
  -H "Content-Type: application/json" \
  -d '{
    "nome":"Fazenda Teste",
    "cidade":"Santa Maria",
    "areaTotal":100.5,
    "idUsuario":1
  }'

# Listar propriedades
curl -X GET http://localhost:8080/api/properties \
  -H "Authorization: Bearer <seu_token>"
```

## 🔐 Segurança

- ✅ Senhas criptografadas com BCrypt
- ✅ Autenticação com JWT
- ✅ CORS configurado
- ✅ Validação de entrada
- ✅ Controle de acesso baseado em roles


