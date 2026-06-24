# Projeto Integrador - Frontend Flutter

## Descrição

Aplicativo móvel desenvolvido em Flutter para levantamento e gerenciamento de dados de propriedades rurais. O aplicativo oferece funcionalidades de autenticação, gerenciamento de propriedades e perfil do usuário.

## Tecnologias Utilizadas

- **Flutter 3.0+**
- **Dart 3.0+**
- **Provider** para gerenciamento de estado
- **HTTP** para requisições à API
- **Shared Preferences** para armazenamento local
- **JSON Serialization** com `json_serializable`

## Pré-requisitos

- Flutter SDK 3.0 ou superior
- Dart SDK 3.0 ou superior
- Android Studio ou VS Code com Flutter extension
- Emulador Android ou dispositivo físico

## Instalação

### 1. Clonar o repositório

```bash
git clone <seu_repositorio>
cd projeto_integrador_flutter
```

### 2. Instalar dependências

```bash
flutter pub get
```

### 3. Gerar arquivos de serialização JSON

```bash
flutter pub run build_runner build
```

### 4. Configurar a API

Edite o arquivo `lib/services/api_service.dart` e altere a URL da API se necessário:

```dart
static const String baseUrl = 'http://seu_ip:8080/api';
```

**Nota:** Para emulador Android, use `http://10.0.2.2:8080/api` em vez de `localhost`.

### 5. Executar o aplicativo

```bash
flutter run
```

## Estrutura do Projeto

```
projeto_integrador_flutter/
├── lib/
│   ├── main.dart                    # Ponto de entrada da aplicação
│   ├── models/                      # Modelos de dados
│   │   ├── usuario.dart
│   │   ├── propriedade.dart
│   │   └── login_response.dart
│   ├── services/                    # Serviços (API, etc)
│   │   └── api_service.dart
│   ├── providers/                   # Provedores de estado
│   │   ├── auth_provider.dart
│   │   └── propriedade_provider.dart
│   ├── screens/                     # Telas da aplicação
│   │   ├── login_screen.dart
│   │   ├── home_screen.dart
│   │   ├── propriedade_form_screen.dart
│   │   └── propriedade_detail_screen.dart
│   ├── widgets/                     # Widgets reutilizáveis
│   └── utils/                       # Utilitários
│       └── app_router.dart
├── assets/                          # Imagens e ícones
├── pubspec.yaml                     # Dependências do projeto
├── analysis_options.yaml            # Configurações de linting
└── README.md
```

## Fluxo de Funcionalidades

### 1. Autenticação

O usuário faz login com email e senha. O token JWT é armazenado localmente e utilizado em todas as requisições subsequentes.

**Tela:** `LoginScreen`
**Endpoint:** `POST /auth/login`

### 2. Home

Após autenticação, o usuário é redirecionado para a tela inicial que oferece ações rápidas e navegação.

**Tela:** `HomeScreen`

### 3. Gerenciamento de Propriedades (CRUD Completo)

O usuário pode criar, visualizar, editar e deletar propriedades.

**Telas:**
- `PropriedadeFormScreen` - Criar e editar propriedades
- `PropriedadeDetailScreen` - Visualizar detalhes da propriedade

**Endpoints:**
- `GET /properties` - Listar propriedades
- `GET /properties/{id}` - Obter propriedade específica
- `GET /properties/usuario/{idUsuario}` - Listar por usuário
- `POST /properties` - Criar propriedade
- `PUT /properties/{id}` - Atualizar propriedade
- `DELETE /properties/{id}` - Deletar propriedade

### 4. Perfil do Usuário

O usuário pode visualizar suas informações de perfil e fazer logout.

**Tela:** `HomeScreen` (aba Perfil)

## Configuração para Desenvolvimento

### Gerar modelos JSON

Sempre que modificar os modelos, execute:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Executar testes

```bash
flutter test
```

### Build para produção

#### Android

```bash
flutter build apk
```

#### iOS

```bash
flutter build ios
```

## Troubleshooting

### Erro de conexão com API

- Verifique se o backend está rodando em `http://localhost:8080/api`
- Para emulador Android, use `http://10.0.2.2:8080/api`
- Verifique as configurações de CORS no backend

### Erro ao gerar modelos JSON

```bash
flutter pub run build_runner clean
flutter pub run build_runner build
```

### Erro de dependências

```bash
flutter clean
flutter pub get
flutter pub run build_runner build
```

### Hot reload não funciona

```bash
flutter run --no-fast-start
```

## Recursos Futuros

1. Implementar tela de gerenciamento de usuários (admin)
2. Adicionar funcionalidade de entrevistas e cultivos
3. Integrar mapa para visualizar propriedades
4. Implementar câmera para capturar fotos
5. Adicionar gráficos de produção
6. Implementar notificações push

## Contato

Para dúvidas ou sugestões, entre em contato com a equipe de desenvolvimento.
