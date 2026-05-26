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

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────────────┐
│                    Flutter App (Frontend)                │
│  ┌──────────────────────────────────────────────────┐   │
│  │  Screens (Login, Home, Forms, Details)           │   │
│  │  Providers (Auth, Propriedade)                   │   │
│  │  Services (API Integration)                      │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                           ↕ HTTP/REST
┌─────────────────────────────────────────────────────────┐
│                Spring Boot API (Backend)                 │
│  ┌──────────────────────────────────────────────────┐   │
│  │  Controllers (Auth, Users, Properties)           │   │
│  │  Services (Business Logic)                       │   │
│  │  Repositories (Data Access)                      │   │
│  │  Security (JWT, Spring Security)                 │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                           ↕ JDBC
┌─────────────────────────────────────────────────────────┐
│                  PostgreSQL Database                     │
│  ┌──────────────────────────────────────────────────┐   │
│  │  usuario | propriedade | (entrevista | producao)│   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

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

## 📦 Estrutura do Projeto

```
projeto_integrador/
├── projeto_integrador_backend/
│   ├── src/main/java/com/projetointegrador/
│   │   ├── controller/          # Controladores REST
│   │   ├── service/             # Lógica de negócio
│   │   ├── repository/          # Acesso a dados
│   │   ├── model/               # Entidades JPA
│   │   ├── dto/                 # Data Transfer Objects
│   │   ├── config/              # Configurações
│   │   └── ProjetoIntegradorApplication.java
│   ├── src/main/resources/
│   │   └── application.properties
│   ├── pom.xml
│   ├── Dockerfile
│   ├── init_database.sql
│   └── README.md
│
├── projeto_integrador_flutter/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/              # Modelos de dados
│   │   ├── services/            # Serviços
│   │   ├── providers/           # Provedores de estado
│   │   ├── screens/             # Telas
│   │   ├── widgets/             # Widgets reutilizáveis
│   │   └── utils/               # Utilitários
│   ├── pubspec.yaml
│   ├── analysis_options.yaml
│   └── README.md
│
├── docker-compose.yml           # Orquestração de containers
├── setup.sh                     # Script de setup automático
├── GUIA_INTEGRACAO.md          # Guia completo de integração
└── README.md                    # Este arquivo
```

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
| Admin | admin@example.com | admin123 |
| Usuário | user@example.com | user123 |

## 📚 Documentação Detalhada

- **[GUIA_INTEGRACAO.md](./GUIA_INTEGRACAO.md)** - Guia completo de integração e setup
- **[projeto_integrador_backend/README.md](./projeto_integrador_backend/README.md)** - Documentação do backend
- **[projeto_integrador_flutter/README.md](./projeto_integrador_flutter/README.md)** - Documentação do frontend

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

## 🎬 Vídeo de Demonstração

Um vídeo de 2-5 minutos demonstrando o funcionamento completo do sistema deve ser enviado junto com a entrega. O vídeo deve incluir:

1. Tela de login
2. Autenticação bem-sucedida
3. Visualização de propriedades
4. Criação de nova propriedade
5. Edição de propriedade
6. Visualização de detalhes
7. Exclusão de propriedade
8. Perfil do usuário e logout

## 🔐 Segurança

- ✅ Senhas criptografadas com BCrypt
- ✅ Autenticação com JWT
- ✅ CORS configurado
- ✅ Validação de entrada
- ✅ Controle de acesso baseado em roles

## 📊 Modelo de Dados

### Tabela: usuario
| Campo | Tipo | Restrições |
|-------|------|-----------|
| id_usuario | SERIAL | PRIMARY KEY |
| nome | VARCHAR(255) | NOT NULL |
| email | VARCHAR(255) | UNIQUE, NOT NULL |
| senha | VARCHAR(255) | NOT NULL |
| telefone | VARCHAR(20) | |
| tipo_usuario | VARCHAR(50) | NOT NULL, CHECK |

### Tabela: propriedade
| Campo | Tipo | Restrições |
|-------|------|-----------|
| id_propriedade | SERIAL | PRIMARY KEY |
| nome | VARCHAR(255) | NOT NULL |
| localidade | VARCHAR(255) | |
| cidade | VARCHAR(255) | |
| telefone | VARCHAR(20) | |
| area_total | DECIMAL(10,2) | |
| latitude | DECIMAL(10,7) | |
| longitude | DECIMAL(10,7) | |
| id_usuario | INTEGER | NOT NULL, FK |
| data_criacao | TIMESTAMP | NOT NULL |
| data_atualizacao | TIMESTAMP | NOT NULL |

## 🐛 Troubleshooting

### Erro: "Connection refused"
```bash
# Verificar se PostgreSQL está rodando
sudo systemctl status postgresql

# Ou usando Docker
docker-compose ps
```

### Erro: "Porta 8080 já em uso"
```bash
# Mudar porta em application.properties
server.port=8081
```

### Erro: "Token inválido"
```bash
# Fazer login novamente
# O token JWT tem validade de 24 horas por padrão
```

## 📈 Próximas Fases (Futuro)

- [ ] Implementar CRUD de Entrevistas
- [ ] Implementar CRUD de Produção
- [ ] Integração com mapa (Google Maps)
- [ ] Câmera para capturar fotos
- [ ] Gráficos de produção
- [ ] Relatórios em PDF
- [ ] Notificações push
- [ ] Sincronização offline
- [ ] Testes automatizados
- [ ] CI/CD pipeline

## 📝 Licença

Este projeto é desenvolvido como trabalho acadêmico para a disciplina de Sistemas para Internet.

## 👥 Equipe

- **Desenvolvedor:** [Seu Nome]
- **Instituição:** Universidade Federal de Santa Maria (UFSM)
- **Curso:** Sistemas para Internet
- **Disciplina:** Projeto Integrador

## 📞 Suporte

Para dúvidas ou sugestões:
1. Consulte a [GUIA_INTEGRACAO.md](./GUIA_INTEGRACAO.md)
2. Verifique os READMEs específicos de cada projeto
3. Consulte a documentação oficial do Flutter e Spring Boot

## ✅ Checklist de Entrega

- [x] Backend implementado em Java Spring Boot
- [x] Frontend implementado em Flutter
- [x] Banco de dados PostgreSQL configurado
- [x] Autenticação com JWT funcionando
- [x] CRUD completo de propriedades
- [x] Interface móvel responsiva
- [x] Documentação completa
- [x] Script de setup automático
- [x] Docker Compose para fácil deployment
- [x] Pronto para apresentação

---

**Última atualização:** 26/05/2026  
**Versão:** 1.0.0  
**Status:** ✅ Pronto para Entrega 3
