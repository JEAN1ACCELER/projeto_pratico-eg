# TP4-MVP TODO - Trabalho Prático IV

## 8 Telas Implementadas

### Tela 1: Splash Screen (Tela de Carregamento)
- [x] Exibir logo do aplicativo E-Project
- [x] Animação de carregamento
- [x] Navegação automática para login ou dashboard
- [x] Implementação: `lib/screens/splash_screen.dart`

### Tela 2: Login Screen (Autenticação)
- [x] Implementar Tela de Login (refatorada para usar widgets reutilizáveis e validação centralizada)
  - [x] Processo de autenticação de usuário
  - [x] Validação de email e senha (refatorada para usar validação centralizada)
  - [x] Mensagens de erro e sucesso
  - [x] Acesso aos Termos de Uso e Política de Privacidade
  - [x] Exibir a logo do aplicativo (refatorado para usar `AppLogo` widget)
- [x] Implementação: `lib/screens/login_screen.dart`
- [x] Serviço: `lib/services/auth_service.dart`

### Tela 3: Signup Screen (Cadastro de Usuário)
- [x] Implementar Tela de Cadastro de Usuário (refatorada para usar widgets reutilizáveis e validação centralizada)
  - [x] Armazenamento de dados do usuário (nome, email, CPF, CNS)
  - [x] Validação de campos (formato de e-mail, força da senha, CPF) (refatorada para usar validação centralizada)
  - [x] Mensagens de feedback claras para o usuário
  - [x] Exibição e aceite obrigatório dos Termos de Uso e Política de Privacidade
  - [x] Seleção de tipo de usuário (Doador/Receptor)
- [x] Implementação: `lib/screens/signup_screen.dart`
- [x] Modelo: `lib/models/user.dart`

### Tela 4: Dashboard Screen (Tela Principal)
- [x] Implementar navegação em abas (Bottom Navigation Bar)
- [x] Exibir nome do usuário autenticado
- [x] Navegação entre 4 telas principais
- [x] Implementação: `lib/screens/dashboard_screen.dart`

### Tela 5: Projects Screen (Gerenciamento de Projetos)
- [x] Listar projetos do usuário (implementado com `getProjectsByUserId` retornando `List<Project>`)
- [x] Criar novo projeto com título e descrição
- [x] Exibir status do projeto (ativo, concluído, arquivado) (campo de status adicionado ao modelo Project e lógica de exibição implementada)
- [x] Visualizar detalhes do projeto (tela de detalhes do projeto e passagem de dados implementadas)
- [x] Implementação: `lib/screens/projects_screen.dart`
- [x] Banco de dados: Tabela `projects`

### Tela 6: Tasks Screen (Gerenciamento de Tarefas)
- [x] Listar tarefas do usuário (implementado com `getTasksByUserId` e `insertTask` no `DatabaseService` e exibição na tela)
- [x] Criar nova tarefa com título, descrição e data de vencimento (implementado com `insertTask` no `DatabaseService`)
- [x] Exibir status da tarefa (pendente, em progresso, concluída) (campo de status adicionado ao modelo Task e lógica de exibição implementada)
- [x] Ordenar tarefas por data de vencimento (implementado com ordenação na tela)
- [x] Implementação: `lib/screens/tasks_screen.dart`
- [x] Banco de dados: Tabela `tasks`

### Tela 7: Profile Screen (Perfil do Usuário)
- [x] Exibir informações pessoais do usuário
- [x] Visualizar email, CPF, CNS, tipo de usuário
- [x] Exibir data de cadastro
- [x] Implementar logout
- [x] Implementação: `lib/screens/profile_screen.dart`

### Tela 8: Settings Screen (Configurações)
- [x] Ativar/desativar notificações (persistência implementada com `shared_preferences`)
- [x] Alternar entre modo claro e escuro (persistência e aplicação do tema implementadas)
- [x] Selecionar idioma (Português, Inglês, Espanhol) (persistência implementada com `shared_preferences`)
- [x] Acessar Termos de Uso e Política de Privacidade (dialogo lendo de `docs/termos-de-uso.md`)
- [x] Visualizar versão da aplicação
- [x] Implementação: `lib/screens/settings_screen.dart`

## Funcionalidades Técnicas Implementadas

### Banco de Dados
- [x] Implementar SQLite para armazenamento local
- [x] Criar tabela de usuários com validação de unicidade (unicidade de email, CPF e CNS implementada no banco de dados)
- [x] Criar tabela de senhas com hash SHA-256
- [x] Criar tabela de projetos com relacionamento com usuários
- [x] Criar tabela de tarefas com relacionamento com projetos
- [x] Implementação: `lib/services/database_service.dart`

### Autenticação e Segurança
- [x] Implementar criptografia de senhas (SHA-256)
- [x] Validação de email com package `email_validator`
- [x] Validação de CPF e CNS (com validação de formato e unicidade no banco de dados)
- [x] Proteção contra SQL injection
- [x] Armazenamento seguro de credenciais

### Gerenciamento de Estado
- [x] Implementar Provider para gerenciamento de estado
- [x] AuthService como ChangeNotifier
- [x] DatabaseService como ChangeNotifier
- [x] MultiProvider para múltiplos providers

### Navegação
- [x] Implementar navegação entre todas as 8 telas
- [x] Navegação nomeada com rotas
- [x] Bottom Navigation Bar para acesso rápido
- [x] Navegação automática baseada em autenticação

## Rastreabilidade - Histórias de Usuário

### US-01: Login no Sistema
- **Implementação**: LoginScreen + AuthService
- **Validações**: Email e senha obrigatórios, credenciais corretas
- **Arquivo**: `lib/screens/login_screen.dart`

### US-02: Cadastro de Novo Usuário
- **Implementação**: SignupScreen + DatabaseService
- **Validações**: Email válido, CPF único, CNS único, senha forte
- **Arquivo**: `lib/screens/signup_screen.dart`

### US-03: Visualizar Perfil
- **Implementação**: ProfileScreen
- **Dados Exibidos**: Nome, email, CPF, CNS, tipo de usuário, data de cadastro
- **Arquivo**: `lib/screens/profile_screen.dart`

### US-04: Criar Projeto
- **Implementação**: ProjectsScreen + DatabaseService
- **Dados Capturados**: Título, descrição, status
- **Arquivo**: `lib/screens/projects_screen.dart`

### US-05: Visualizar Projetos
- **Implementação**: ProjectsScreen
- **Dados Exibidos**: Lista de projetos com status
- **Arquivo**: `lib/screens/projects_screen.dart`

### US-06: Criar Tarefa
- **Implementação**: TasksScreen + DatabaseService
- **Dados Capturados**: Título, descrição, data de vencimento, status
- **Arquivo**: `lib/screens/tasks_screen.dart`

### US-07: Visualizar Tarefas
- **Implementação**: TasksScreen
- **Dados Exibidos**: Lista de tarefas ordenadas por data de vencimento
- **Arquivo**: `lib/screens/tasks_screen.dart`

### US-08: Configurar Preferências
- **Implementação**: SettingsScreen
- **Opções**: Notificações, modo escuro, idioma
- **Arquivo**: `lib/screens/settings_screen.dart`

## Documentação Técnica
- [x] README.md com instruções de uso
- [x] TECHNICAL_DOCUMENTATION.md com detalhes técnicos
- [x] Documentação de arquitetura
- [x] Documentação de banco de dados
- [x] Documentação de fluxo de dados

## Testes Implementados
- [x] Testes unitários para AuthService
- [x] Testes unitários para DatabaseService
- [x] Testes de validação de email
- [x] Testes de operações de banco de dados
- [x] Arquivo: `test/auth_service_test.dart`
- [x] Arquivo: `test/database_service_test.dart`

## Qualidade de Código
- [x] Seguir convenções de código Dart/Flutter
- [x] Implementar analysis_options.yaml
- [x] Adicionar comentários explicativos
- [x] Organizar código em camadas (MVC)
- [x] Implementar tratamento de erros
- [x] Validação de entrada em todos os formulários (refatorada para usar validação centralizada e widgets reutilizáveis)

## Estrutura de Diretórios
```
TP4-MVP/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── user.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   └── database_service.dart
│   ├── pages/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── dashboard_screen.dart
│   │   ├── projects_screen.dart
│   │   ├── tasks_screen.dart
│   │   ├── profile_screen.dart
│   │   └── settings_screen.dart
│   └── components/
│       ├── terms_dialog.dart
│       ├── custom_text_field.dart
│       ├── primary_button.dart
│       └── app_logo.dart
├── test/
│   ├── auth_service_test.dart
│   └── database_service_test.dart
├── pubspec.yaml
├── analysis_options.yaml
├── README.md
└── TECHNICAL_DOCUMENTATION.md
```

## Requisitos de Gerência de Configuração e Controle de Versão

### Refatorações
- [x] Aplicar pelo menos 5 refatorações distintas no código (8 refatorações aplicadas e documentadas)
- [x] Documentar cada refatoração (problema, motivação, melhoria, impacto) (documentação em `docs/refatoracoes.md`)
- [ ] Registrar refatorações no histórico do GitHub com commits descritivos (será feito no push final)

### Gerência de Configuração
- [ ] Aplicar práticas básicas de gerência de configuração (necessita definir e aplicar práticas)
- [ ] Seguir fluxo de trabalho colaborativo (clonar, desenvolver, commitar, pushar, atualizar) (necessita aplicar o fluxo)

### Controle de Versão
- [ ] Seguir convenções claras para commits (ex: `feat:`, `refactor:`, `docs:`) (necessita aplicar as convenções)
- [ ] Utilizar branches obrigatórias (`main`, `develop`, `refactor/nome-da-refatoracao`) (necessita criar e usar as branches)
- [ ] Realizar merge visual da branch para `develop` (necessita realizar o merge)
- [ ] Manter histórico organizado no GitHub (necessita organizar o histórico)
- [ ] Criar pelo menos uma release/tag da versão MVP (ex: `v1.0-mvp`) (necessita criar a release/tag)

### Estrutura do Repositório
- [x] Organizar o diretório `TP4-MVP` conforme a estrutura recomendada no PDF
  - [x] `docs/rastreabilidade.md`
  - [x] `docs/refatoracoes.md`
  - [x] `docs/termos-de-uso.md`
  - [x] `prints/` (com subdiretórios para telas) (diretórios criados, prints placeholders)
  - [ ] `video/demonstracao-mvp.mp4` (se aplicável) (gravação pendente - requer execução local)
  - [x] `lib/` (código-fonte - organizado em `pages/` e `components/`)

## Status Geral
- **Telas Implementadas**: 8/8 (100%) (Funcionalidade básica, mas algumas telas precisam de refatoração e complementação)
- **Funcionalidades Técnicas**: 80% Completas (Faltam validações de unicidade no banco, persistência de configurações, etc.)
- **Testes**: 100% Implementados (Testes básicos, mas precisam ser expandidos para cobrir novas funcionalidades e refatorações)
- **Documentação**: 90% Completa (Faltam prints e vídeo de demonstração)
- **Qualidade de Código**: 80% Atendida (Necessita refatorações adicionais e aplicação de widgets reutilizáveis)
- **Rastreabilidade**: 100% Documentada
- **Gerência de Configuração e Controle de Versão**: PENDENTE
- [x] Estrutura do Repositório: ORGANIZADA (Prints placeholders, vídeo pendente - requer execução local)

---

**Versão**: 1.0.0  
**Data de Conclusão**: 2024  
**Status**: MVP Básico Implementado, PENDENTE (Refatorações, Validações Completas, Persistência de Configurações, Gerência de Configuração e Estrutura de Repositório)
