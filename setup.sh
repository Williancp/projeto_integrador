#!/bin/bash

# Script de configuração do Projeto Integrador - Entrega 3
# Este script automatiza a configuração do ambiente

set -e

echo "=========================================="
echo "Projeto Integrador - Setup Automático"
echo "=========================================="
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para imprimir mensagens coloridas
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar pré-requisitos
print_info "Verificando pré-requisitos..."

# Verificar Java
if ! command -v java &> /dev/null; then
    print_error "Java não está instalado. Por favor, instale Java 17 ou superior."
    exit 1
fi
JAVA_VERSION=$(java -version 2>&1 | grep -oP 'version "\K[^"]*')
print_info "Java encontrado: $JAVA_VERSION"

# Verificar Maven
if ! command -v mvn &> /dev/null; then
    print_error "Maven não está instalado. Por favor, instale Maven 3.6 ou superior."
    exit 1
fi
MAVEN_VERSION=$(mvn -v | grep "Apache Maven" | awk '{print $3}')
print_info "Maven encontrado: $MAVEN_VERSION"

# Verificar PostgreSQL
if ! command -v psql &> /dev/null; then
    print_warning "PostgreSQL não está instalado. Você pode usar Docker para executar o PostgreSQL."
    print_info "Use: docker-compose up -d postgres"
else
    POSTGRES_VERSION=$(psql --version | awk '{print $3}')
    print_info "PostgreSQL encontrado: $POSTGRES_VERSION"
fi

# Verificar Flutter (opcional)
if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version | head -1)
    print_info "Flutter encontrado: $FLUTTER_VERSION"
else
    print_warning "Flutter não está instalado. Você precisará instalá-lo para executar o frontend."
fi

echo ""
print_info "Iniciando setup..."
echo ""

# Setup Backend
print_info "Configurando Backend..."
cd projeto_integrador_backend

print_info "Compilando Backend com Maven..."
mvn clean install -DskipTests

print_info "Backend compilado com sucesso!"
cd ..

echo ""

# Setup Frontend
print_info "Configurando Frontend..."
cd projeto_integrador_flutter

if command -v flutter &> /dev/null; then
    print_info "Instalando dependências Flutter..."
    flutter pub get
    
    print_info "Gerando modelos JSON..."
    flutter pub run build_runner build
    
    print_info "Frontend configurado com sucesso!"
else
    print_warning "Flutter não está disponível. Pulando setup do frontend."
    print_info "Para configurar o frontend manualmente, execute:"
    echo "  cd projeto_integrador_flutter"
    echo "  flutter pub get"
    echo "  flutter pub run build_runner build"
fi

cd ..

echo ""
echo "=========================================="
print_info "Setup concluído com sucesso!"
echo "=========================================="
echo ""
echo "Próximos passos:"
echo ""
echo "1. Configurar o Banco de Dados:"
echo "   - Se usar Docker: docker-compose up -d postgres"
echo "   - Se usar PostgreSQL local: psql -U postgres -d projeto_integrador -f projeto_integrador_backend/init_database.sql"
echo ""
echo "2. Executar o Backend:"
echo "   cd projeto_integrador_backend"
echo "   mvn spring-boot:run"
echo ""
echo "3. Executar o Frontend (em outro terminal):"
echo "   cd projeto_integrador_flutter"
echo "   flutter run"
echo ""
echo "4. Acessar a API:"
echo "   http://localhost:8080/api"
echo ""
echo "5. Credenciais de teste:"
echo "   Admin: admin@example.com / admin123"
echo "   User: user@example.com / user123"
echo ""
