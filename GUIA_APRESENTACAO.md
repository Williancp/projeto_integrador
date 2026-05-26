# Guia de Apresentação - Entrega 3

## 📋 Informações Gerais

- **Data de Entrega:** 26/05/2026
- **Data de Apresentação:** 27/05/2026 a 28/05/2026
- **Local:** LAB G209
- **Duração:** 2-5 minutos de vídeo + apresentação presencial
- **Funcionalidades:** 50% do sistema implementado

## 🎯 Objetivos da Apresentação

1. Demonstrar o funcionamento do sistema com interface funcionando
2. Mostrar CRUD completo em pelo menos uma funcionalidade (Propriedades)
3. Apresentar código relevante (interface, banco de dados, lógica)
4. Explicar a organização do projeto
5. Demonstrar integração entre frontend e backend

## 📹 Roteiro do Vídeo (2-5 minutos)

### Segmento 1: Introdução (15 segundos)

**O que fazer:**
- Apresentar o aplicativo
- Mostrar a tela inicial (login)
- Mencionar as tecnologias utilizadas

**Script:**
> "Olá, este é o Sistema de Levantamento de Dados Rurais, desenvolvido em Flutter para o frontend, Java Spring Boot para o backend e PostgreSQL para o banco de dados. Vamos demonstrar as funcionalidades implementadas na Entrega 3."

### Segmento 2: Autenticação (30 segundos)

**O que fazer:**
- Abrir o aplicativo
- Preencher email e senha
- Fazer login com sucesso
- Mostrar redirecionamento para Home

**Script:**
> "Primeiro, vamos fazer login no sistema. Usaremos as credenciais de teste: admin@example.com e senha admin123. O sistema valida as credenciais e gera um token JWT para autenticação."

**Dados de teste:**
- Email: `admin@example.com`
- Senha: `admin123`

### Segmento 3: Visualizar Propriedades (30 segundos)

**O que fazer:**
- Navegar até a aba "Propriedades"
- Mostrar a lista de propriedades existentes
- Destacar que cada propriedade tem opções de editar e deletar

**Script:**
> "Agora estamos na tela de propriedades. Aqui podemos ver todas as propriedades cadastradas. Cada uma tem opções para editar ou deletar. Vamos criar uma nova propriedade para demonstrar o CRUD completo."

### Segmento 4: Criar Propriedade (1 minuto)

**O que fazer:**
- Clicar em "Adicionar Propriedade"
- Preencher o formulário com dados
- Salvar a propriedade
- Mostrar a nova propriedade na lista

**Dados de exemplo:**
```
Nome: Fazenda Nova
Localidade: Zona Rural
Cidade: Santa Maria
Telefone: 55 33 99999-9999
Área Total: 150.50
Latitude: -29.6834
Longitude: -53.8082
```

**Script:**
> "Clicamos em 'Adicionar Propriedade' e preenchemos o formulário com os dados da propriedade. Após preencher todos os campos obrigatórios, clicamos em 'Criar'. A propriedade é salva no banco de dados e aparece imediatamente na lista."

### Segmento 5: Editar Propriedade (1 minuto)

**O que fazer:**
- Selecionar uma propriedade existente
- Clicar em "Editar"
- Modificar um campo (ex: nome ou área)
- Salvar as alterações
- Mostrar a propriedade atualizada na lista

**Script:**
> "Agora vamos editar uma propriedade existente. Clicamos no menu de opções e selecionamos 'Editar'. Modificamos o nome da propriedade e salvamos. As alterações são atualizadas imediatamente no banco de dados."

### Segmento 6: Visualizar Detalhes (30 segundos)

**O que fazer:**
- Clicar em uma propriedade para visualizar detalhes
- Mostrar a tela de detalhes com todas as informações
- Mostrar o botão para editar

**Script:**
> "Aqui podemos visualizar todos os detalhes de uma propriedade específica. Todas as informações cadastradas são exibidas de forma clara e organizada."

### Segmento 7: Deletar Propriedade (30 segundos)

**O que fazer:**
- Selecionar uma propriedade
- Clicar em "Deletar"
- Confirmar a exclusão
- Mostrar a propriedade desaparecendo da lista

**Script:**
> "Para deletar uma propriedade, clicamos no menu e selecionamos 'Deletar'. O sistema pede confirmação e, após confirmar, a propriedade é removida do banco de dados e desaparece da lista."

### Segmento 8: Perfil e Logout (30 segundos)

**O que fazer:**
- Navegar até a aba "Perfil"
- Mostrar as informações do usuário
- Clicar em "Sair"
- Mostrar redirecionamento para login

**Script:**
> "Na aba de perfil, podemos visualizar as informações do usuário autenticado. Ao clicar em 'Sair', o usuário é desconectado e redirecionado para a tela de login."

## 💻 Apresentação Presencial (Estrutura Sugerida)

### Parte 1: Demonstração do Sistema (3-5 minutos)

**Prepare:**
- Máquina com o sistema rodando
- Emulador Android ou dispositivo físico
- Backend rodando em `http://localhost:8080/api`
- PostgreSQL com dados iniciais

**Demonstre:**
1. Fazer login
2. Navegar pelas telas
3. Realizar operações CRUD
4. Mostrar integração com backend

### Parte 2: Explicação do Código (5-10 minutos)

**Apresente:**

#### Interface (Frontend)
```dart
// Exemplo: PropriedadeFormScreen
class PropriedadeFormScreen extends StatefulWidget {
  // Formulário para criar/editar propriedades
  // Validação de campos
  // Integração com API
}
```

**Pontos a destacar:**
- Uso de Provider para state management
- Validação de formulários
- Requisições HTTP com token JWT
- Armazenamento local com SharedPreferences

#### Banco de Dados
```sql
CREATE TABLE propriedade (
    id_propriedade SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    localidade VARCHAR(255),
    cidade VARCHAR(255),
    ...
    id_usuario INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);
```

**Pontos a destacar:**
- Relacionamento entre tabelas
- Integridade referencial
- Índices para performance
- Timestamps de auditoria

#### Lógica de Negócio (Backend)
```java
@Service
@RequiredArgsConstructor
@Transactional
public class PropriedadeService {
    public PropriedadeDTO createPropriedade(PropriedadeDTO dto) {
        // Validação
        // Persistência
        // Retorno
    }
}
```

**Pontos a destacar:**
- Camadas de aplicação (Controller, Service, Repository)
- Tratamento de exceções
- Transações com banco de dados
- DTOs para transferência de dados

### Parte 3: Responder Perguntas (5-10 minutos)

**Possíveis perguntas dos professores:**

1. **"Como funciona a autenticação?"**
   - Explicar fluxo de login
   - JWT token
   - Armazenamento seguro

2. **"Como é feita a integração entre frontend e backend?"**
   - API REST
   - Requisições HTTP
   - Tratamento de erros

3. **"Como os dados são persistidos?"**
   - PostgreSQL
   - JPA/Hibernate
   - Relacionamentos

4. **"Como você organizou o código?"**
   - Padrão MVC/MVVM
   - Separação de responsabilidades
   - Reutilização de componentes

5. **"Qual é a funcionalidade principal?"**
   - CRUD completo de propriedades
   - Demonstração de todas as operações
   - Integração com backend

## 🎬 Dicas para Gravar o Vídeo

### Qualidade
- Use resolução 1080p ou superior
- Áudio claro e bem audível
- Boa iluminação
- Sem distrações de fundo

### Conteúdo
- Fale claramente e com ritmo
- Explique o que está fazendo
- Mostre o resultado de cada ação
- Evite pausas longas
- Mantenha o tempo entre 2-5 minutos

### Edição
- Remova pausas desnecessárias
- Adicione legendas se necessário
- Inclua transições suaves
- Adicione música de fundo (opcional)
- Coloque título e créditos

### Formato
- Salve em MP4 ou MOV
- Bitrate: 5-10 Mbps
- Frame rate: 30 ou 60 fps
- Resolução: 1920x1080 ou superior

## 📋 Checklist Pré-Apresentação

### Antes da Apresentação
- [ ] Testar backend (http://localhost:8080/api/auth/health)
- [ ] Testar frontend (login, CRUD)
- [ ] Verificar conexão com banco de dados
- [ ] Preparar dados de teste
- [ ] Revisar código para possíveis perguntas
- [ ] Preparar slides (opcional)
- [ ] Testar áudio e vídeo do computador
- [ ] Ter backup do código no GitHub
- [ ] Ter cópia do vídeo em pen drive

### Durante a Apresentação
- [ ] Chegar 10 minutos antes
- [ ] Testar conexão e equipamentos
- [ ] Ter credenciais de teste à mão
- [ ] Manter calma e falar claramente
- [ ] Fazer contato visual com os professores
- [ ] Responder perguntas com confiança

### Documentação
- [ ] README.md atualizado
- [ ] GUIA_INTEGRACAO.md completo
- [ ] Código comentado
- [ ] Commits bem descritos no GitHub

## 🎓 Pontos Importantes a Mencionar

1. **Arquitetura em Camadas**
   - Separação clara entre frontend e backend
   - Comunicação via API REST
   - Banco de dados centralizado

2. **Segurança**
   - Autenticação com JWT
   - Senhas criptografadas com BCrypt
   - Validação de entrada
   - Controle de acesso

3. **Qualidade do Código**
   - Padrões de design (MVC, MVVM)
   - Reutilização de componentes
   - Tratamento de erros
   - Logging

4. **Funcionalidades Implementadas**
   - 50% do sistema conforme requisito
   - CRUD completo em propriedades
   - Interface responsiva
   - Integração completa

5. **Próximas Fases**
   - Implementar entrevistas e produção
   - Adicionar mapa
   - Gráficos e relatórios
   - Testes automatizados

## 📞 Contato e Suporte

Se tiver dúvidas durante a apresentação:
- Consulte o código-fonte
- Verifique os READMEs
- Consulte a documentação oficial
- Peça ajuda aos professores

## 🎉 Boa Sorte!

Você está pronto para apresentar a Entrega 3 com sucesso! Demonstre confiança, conhecimento e paixão pelo projeto.

---

**Última atualização:** 26/05/2026  
**Versão:** 1.0.0
