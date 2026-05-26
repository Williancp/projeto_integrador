# Guia de Integração - Projeto Integrador Entrega 3

## 📋 Visão Geral

Este documento fornece instruções completas para configurar, executar e testar o sistema de levantamento e gerenciamento de dados rurais, desenvolvido com Flutter (frontend), Java Spring Boot (backend) e PostgreSQL (banco de dados).

## 🎯 Funcionalidades Implementadas (50% do Sistema)

### 1. Autenticação de Usuário
- **Login com email e senha**
- **Validação de credenciais**
- **Geração de token JWT**
- **Armazenamento seguro de token**

### 2. Gerenciamento de Usuários (CRUD - Restrito a Admin)
- **Listar usuários** (GET `/api/users`)
- **Obter usuário específico** (GET `/api/users/{id}`)
- **Criar novo usuário** (POST `/api/users`)
- **Atualizar usuário** (PUT `/api/users/{id}`)
- **Deletar usuário** (DELETE `/api/users/{id}`)

### 3. Gerenciamento de Propriedades (CRUD Completo - Funcionalidade Principal)
- **Listar todas as propriedades** (GET `/api/properties`)
- **Listar propriedades por usuário** (GET `/api/properties/usuario/{idUsuario}`)
- **Obter propriedade específica** (GET `/api/properties/{id}`)
- **Criar nova propriedade** (POST `/api/properties`)
- **Atualizar propriedade** (PUT `/api/properties/{id}`)
- **Deletar propriedade** (DELETE `/api/properties/{id}`)

### 4. Interface Móvel (Flutter)
- **Tela de Login** com validação
- **Tela Home** com navegação e ações rápidas
- **Lista de Propriedades** com CRUD completo
- **Formulário de Propriedade** para criar e editar
- **Detalhes de Propriedade** com visualização completa
- **Perfil do Usuário** com informações e logout

## 🔧 Pré-requisitos

### Backend
- Java 17 ou superior
- Maven 3.6+
- PostgreSQL 12+
- Git

### Frontend
- Flutter 3.0+
- Dart 3.0+
- Android Studio ou VS Code com Flutter extension
- Emulador Android ou dispositivo físico

## 📦 Estrutura de Pastas

```
projeto_integrador/
├── projeto_integrador_backend/     # Backend Java Spring Boot
│   ├── src/
│   ├── pom.xml
│   ├── README.md
│   └── init_database.sql
├── projeto_integrador_flutter/     # Frontend Flutter
│   ├── lib/
│   ├── pubspec.yaml
│   └── README.md
└── GUIA_INTEGRACAO.md             # Este arquivo
```

## 🚀 Instruções de Execução

### Passo 1: Configurar o Banco de Dados PostgreSQL

#### 1.1 Instalar PostgreSQL (se não estiver instalado)

**Windows:**
```bash
# Baixe do site oficial: https://www.postgresql.org/download/windows/
# Execute o instalador e siga as instruções
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
```

**macOS:**
```bash
brew install postgresql
brew services start postgresql
```

#### 1.2 Criar banco de dados

```bash
# Conectar ao PostgreSQL
psql -U postgres

# Criar banco de dados
CREATE DATABASE projeto_integrador;

# Sair
\q
```

#### 1.3 Inicializar tabelas e dados

```bash
cd projeto_integrador_backend
psql -U postgres -d projeto_integrador -f init_database.sql
```

**Credenciais Padrão para Teste:**
- **Admin:** email: `admin@example.com`, senha: `admin123`
- **Usuário Comum:** email: `user@example.com`, senha: `user123`

### Passo 2: Executar o Backend (Java Spring Boot)

#### 2.1 Navegar até o diretório do backend

```bash
cd projeto_integrador_backend
```

#### 2.2 Compilar o projeto

```bash
mvn clean install
```

#### 2.3 Executar a aplicação

```bash
mvn spring-boot:run
```

A API estará disponível em: **http://localhost:8080/api**

**Verificar se está rodando:**
```bash
curl http://localhost:8080/api/auth/health
```

Resposta esperada: `"API is running"`

### Passo 3: Executar o Frontend (Flutter)

#### 3.1 Navegar até o diretório do frontend

```bash
cd projeto_integrador_flutter
```

#### 3.2 Instalar dependências

```bash
flutter pub get
```

#### 3.3 Gerar modelos JSON

```bash
flutter pub run build_runner build
```

#### 3.4 Configurar a URL da API

Edite `lib/services/api_service.dart`:

```dart
static const String baseUrl = 'http://localhost:8080/api';
```

**Para Emulador Android:**
```dart
static const String baseUrl = 'http://10.0.2.2:8080/api';
```

#### 3.5 Executar o aplicativo

```bash
flutter run
```

## 🧪 Testando o Sistema

### Teste 1: Login

1. Abra o aplicativo Flutter
2. Insira as credenciais:
   - Email: `admin@example.com`
   - Senha: `admin123`
3. Clique em "Entrar"
4. Você deve ser redirecionado para a tela Home

### Teste 2: Visualizar Propriedades

1. Na tela Home, clique na aba "Propriedades"
2. Você verá a lista de propriedades cadastradas
3. Clique em uma propriedade para visualizar seus detalhes

### Teste 3: Criar Propriedade (CREATE)

1. Na lista de propriedades, clique em "Adicionar Propriedade"
2. Preencha o formulário com os dados:
   - Nome: "Minha Fazenda"
   - Localidade: "Rural"
   - Cidade: "Santa Maria"
   - Telefone: "5533999999"
   - Área Total: "100"
   - Latitude: "-29.6834"
   - Longitude: "-53.8082"
3. Clique em "Criar"
4. A propriedade deve aparecer na lista

### Teste 4: Editar Propriedade (UPDATE)

1. Na lista de propriedades, clique no menu (três pontos) de uma propriedade
2. Selecione "Editar"
3. Modifique algum campo (ex: nome)
4. Clique em "Atualizar"
5. A propriedade deve ser atualizada na lista

### Teste 5: Deletar Propriedade (DELETE)

1. Na lista de propriedades, clique no menu (três pontos) de uma propriedade
2. Selecione "Deletar"
3. Confirme a exclusão
4. A propriedade deve desaparecer da lista

### Teste 6: Visualizar Perfil

1. Na tela Home, clique na aba "Perfil"
2. Você verá suas informações de usuário
3. Clique em "Sair" para fazer logout

## 📱 Endpoints da API

### Autenticação

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | `/auth/login` | Fazer login |
| GET | `/auth/health` | Verificar saúde da API |

### Usuários (Requer role ADMINISTRADOR)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/users` | Listar todos os usuários |
| GET | `/users/{id}` | Obter usuário específico |
| POST | `/users` | Criar novo usuário |
| PUT | `/users/{id}` | Atualizar usuário |
| DELETE | `/users/{id}` | Deletar usuário |

### Propriedades (Requer autenticação)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/properties` | Listar todas as propriedades |
| GET | `/properties/{id}` | Obter propriedade específica |
| GET | `/properties/usuario/{idUsuario}` | Listar por usuário |
| POST | `/properties` | Criar nova propriedade |
| PUT | `/properties/{id}` | Atualizar propriedade |
| DELETE | `/properties/{id}` | Deletar propriedade |

## 🎬 Preparando o Vídeo para a Entrega 3

### Roteiro Recomendado (2-5 minutos)

1. **Introdução (15 segundos)**
   - Apresentar o aplicativo
   - Mostrar a tela de login

2. **Autenticação (30 segundos)**
   - Fazer login com credenciais válidas
   - Mostrar redirecionamento para Home

3. **Visualizar Propriedades (30 segundos)**
   - Navegar até a aba "Propriedades"
   - Mostrar lista de propriedades existentes

4. **Criar Propriedade (1 minuto)**
   - Clicar em "Adicionar Propriedade"
   - Preencher formulário com dados
   - Salvar e mostrar na lista

5. **Editar Propriedade (1 minuto)**
   - Selecionar uma propriedade
   - Clicar em "Editar"
   - Modificar dados
   - Salvar alterações

6. **Visualizar Detalhes (30 segundos)**
   - Clicar em uma propriedade
   - Mostrar tela de detalhes

7. **Deletar Propriedade (30 segundos)**
   - Selecionar uma propriedade
   - Clicar em "Deletar"
   - Confirmar exclusão

8. **Perfil e Logout (30 segundos)**
   - Navegar até "Perfil"
   - Mostrar informações do usuário
   - Fazer logout

### Dicas para o Vídeo

- Use um emulador ou dispositivo com boa resolução
- Fale claramente explicando cada ação
- Mostre o CRUD completo de propriedades (funcionalidade principal)
- Demonstre a integração entre frontend e backend
- Mantenha o vídeo entre 2-5 minutos
- Edite para remover pausas longas
- Adicione legendas se necessário

## 🔍 Troubleshooting

### Problema: Erro de conexão com PostgreSQL

**Solução:**
```bash
# Verificar se PostgreSQL está rodando
sudo systemctl status postgresql

# Iniciar PostgreSQL (se não estiver rodando)
sudo systemctl start postgresql

# Verificar credenciais em application.properties
```

### Problema: Porta 8080 já em uso

**Solução:**
Edite `application.properties`:
```properties
server.port=8081
```

### Problema: Flutter não conecta à API

**Solução:**
- Para emulador Android, use `http://10.0.2.2:8080/api`
- Verifique CORS no backend
- Certifique-se de que o backend está rodando

### Problema: Token JWT expirado

**Solução:**
- Faça logout e login novamente
- Aumente o tempo de expiração em `application.properties`:
```properties
jwt.expiration=604800000
```

### Problema: Erro ao gerar modelos JSON

**Solução:**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📚 Documentação Adicional

- **Backend:** Veja `projeto_integrador_backend/README.md`
- **Frontend:** Veja `projeto_integrador_flutter/README.md`
- **Banco de Dados:** Veja `projeto_integrador_backend/init_database.sql`

## ✅ Checklist para Entrega 3

- [ ] Backend compilado e rodando em `http://localhost:8080/api`
- [ ] PostgreSQL configurado com banco de dados e dados iniciais
- [ ] Frontend Flutter compilado e executando
- [ ] Login funcionando com credenciais válidas
- [ ] CRUD completo de propriedades funcionando
- [ ] Vídeo de demonstração (2-5 minutos) gravado
- [ ] Código-fonte organizado no GitHub
- [ ] README.md atualizado em ambos os projetos
- [ ] Instruções de execução claras e testadas

## 🎓 Explicação do Código (Para Apresentação)

### Backend - Estrutura Principal

**Camada de Controle (Controller):**
```java
@RestController
@RequestMapping("/properties")
public class PropriedadeController {
    // Endpoints REST para CRUD
}
```

**Camada de Serviço (Service):**
```java
@Service
public class PropriedadeService {
    // Lógica de negócio
}
```

**Camada de Acesso a Dados (Repository):**
```java
@Repository
public interface PropriedadeRepository extends JpaRepository<Propriedade, Long> {
    // Consultas ao banco de dados
}
```

### Frontend - Arquitetura

**Providers (State Management):**
```dart
class PropriedadeProvider extends ChangeNotifier {
    // Gerencia estado das propriedades
}
```

**Services (Integração com API):**
```dart
class ApiService {
    // Requisições HTTP
}
```

**Screens (Interface do Usuário):**
```dart
class PropriedadeFormScreen extends StatefulWidget {
    // Tela de formulário
}
```

## 📞 Suporte

Em caso de dúvidas ou problemas, consulte:
1. Os READMEs específicos de cada projeto
2. A documentação oficial do Flutter e Spring Boot
3. Os comentários no código-fonte

---

**Última atualização:** 26/05/2026
**Versão:** 1.0.0
**Status:** Pronto para Entrega 3
