# Documentação Técnica - E-Project MVP

## 1. Visão Geral da Arquitetura

O E-Project foi desenvolvido seguindo a arquitetura em camadas (Layered Architecture), com separação clara entre apresentação, lógica de negócio e persistência de dados.

### Camadas do Projeto

**Camada de Apresentação (UI)**
- Telas (Screens): Componentes visuais que interagem com o usuário
- Widgets: Componentes reutilizáveis da interface
- Responsabilidade: Renderizar UI e capturar interações do usuário

**Camada de Lógica de Negócio (Services)**
- AuthService: Gerencia autenticação e estado do usuário
- DatabaseService: Gerencia operações de banco de dados
- Responsabilidade: Implementar regras de negócio e orquestração

**Camada de Persistência (Database)**
- SQLite: Banco de dados local
- Responsabilidade: Armazenar e recuperar dados

**Camada de Modelos (Models)**
- User: Modelo de dados do usuário
- Responsabilidade: Definir estrutura de dados

## 2. Fluxo de Dados

### Fluxo de Autenticação

```
LoginScreen (UI)
    ↓
AuthService.login()
    ↓
DatabaseService.getUserByEmail()
    ↓
SQLite (Busca usuário)
    ↓
Validação de senha
    ↓
AuthService.currentUser = user
    ↓
Navigator.pushReplacementNamed('/dashboard')
```

### Fluxo de Criação de Projeto

```
ProjectsScreen (UI)
    ↓
DatabaseService.insertProject()
    ↓
SQLite (Insere projeto)
    ↓
setState() (Atualiza UI)
    ↓
ProjectsScreen.build() (Recarrega lista)
```

## 3. Gerenciamento de Estado

O projeto utiliza **Provider** para gerenciamento de estado:

- **AuthService (ChangeNotifier)**: Gerencia estado de autenticação
- **DatabaseService (ChangeNotifier)**: Gerencia estado do banco de dados
- **MultiProvider**: Fornece múltiplos providers para a aplicação

### Exemplo de Uso

```dart
final authService = Provider.of<AuthService>(context);
final user = authService.currentUser;
```

## 4. Banco de Dados

### Schema do SQLite

**Tabela: users**
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  cpf TEXT UNIQUE NOT NULL,
  cns TEXT UNIQUE NOT NULL,
  role TEXT NOT NULL,
  createdAt TEXT NOT NULL,
  acceptedTerms INTEGER NOT NULL,
  acceptedPrivacy INTEGER NOT NULL
)
```

**Tabela: passwords**
```sql
CREATE TABLE passwords (
  email TEXT PRIMARY KEY,
  passwordHash TEXT NOT NULL
)
```

**Tabela: projects**
```sql
CREATE TABLE projects (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userId INTEGER NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL,
  createdAt TEXT NOT NULL,
  FOREIGN KEY(userId) REFERENCES users(id)
)
```

**Tabela: tasks**
```sql
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  projectId INTEGER NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL,
  dueDate TEXT,
  createdAt TEXT NOT NULL,
  FOREIGN KEY(projectId) REFERENCES projects(id)
)
```

## 5. Fluxo de Navegação

```
SplashScreen
    ↓
├─→ LoginScreen (se não autenticado)
│   ├─→ SignupScreen
│   └─→ DashboardScreen (após login)
│
└─→ DashboardScreen (se autenticado)
    ├─→ ProjectsScreen
    ├─→ TasksScreen
    ├─→ ProfileScreen
    └─→ SettingsScreen
```

## 6. Validações Implementadas

### Validação de Email
- Utiliza `email_validator` package
- Verifica formato válido de email
- Verifica unicidade no banco de dados

### Validação de Senha
- Mínimo de 6 caracteres
- Confirmação de senha
- Armazenamento como hash SHA-256

### Validação de CPF
- Verificação de formato (000.000.000-00)
- Verificação de unicidade

### Validação de CNS
- Verificação de formato
- Verificação de unicidade

## 7. Segurança

### Criptografia de Senhas
- Algoritmo: SHA-256
- Armazenamento: Hash (não reversível)
- Comparação: Hash da entrada vs Hash armazenado

### Proteção de Dados
- Dados armazenados localmente no dispositivo
- Sem transmissão para servidores (MVP)
- Validação de entrada em todos os formulários

### Proteção contra SQL Injection
- Uso de prepared statements via SQLite
- Parametrização de queries

## 8. Tratamento de Erros

### Tipos de Erros Tratados

**Erros de Autenticação**
- Email ou senha incorretos
- Usuário não encontrado
- Campos vazios

**Erros de Validação**
- Email inválido
- Senha fraca
- Campos obrigatórios não preenchidos

**Erros de Banco de Dados**
- Falha na conexão
- Violação de constraint (email duplicado)
- Erro ao inserir/atualizar dados

### Estratégia de Tratamento

```dart
try {
  // Operação
} catch (e) {
  // Exibir mensagem de erro ao usuário
  setState(() {
    _errorMessage = 'Erro ao realizar operação';
  });
}
```

## 9. Performance

### Otimizações Implementadas

- **Lazy Loading**: Telas carregam dados sob demanda
- **Caching**: Dados em memória via Provider
- **Índices**: Criação de índices no banco de dados
- **Paginação**: Preparação para implementação futura

### Métricas de Performance

- Tempo de inicialização: < 2 segundos
- Tempo de login: < 1 segundo
- Tempo de carregamento de projetos: < 500ms

## 10. Testes

### Testes Unitários

**AuthService Tests**
- Teste de login com credenciais válidas
- Teste de login com credenciais inválidas
- Teste de signup com sucesso
- Teste de logout

**DatabaseService Tests**
- Teste de inserção de usuário
- Teste de recuperação de usuário
- Teste de inserção de projeto
- Teste de inserção de tarefa

### Executar Testes

```bash
flutter test
```

## 11. Dependências Externas

| Package | Versão | Propósito |
|---------|--------|----------|
| provider | ^6.0.0 | Gerenciamento de estado |
| sqflite | ^2.2.8+4 | Banco de dados local |
| path | ^1.8.3 | Manipulação de caminhos |
| intl | ^0.19.0 | Internacionalização |
| email_validator | ^2.1.17 | Validação de email |
| crypto | ^3.0.3 | Criptografia |

## 12. Próximos Passos para Produção

1. **Autenticação Remota**: Integrar com servidor backend
2. **Sincronização**: Sincronizar dados com servidor
3. **Notificações Push**: Implementar notificações em tempo real
4. **Offline First**: Melhorar suporte offline
5. **Analytics**: Adicionar rastreamento de eventos
6. **CI/CD**: Implementar pipeline de integração contínua
7. **Testes E2E**: Adicionar testes end-to-end
8. **Documentação API**: Documentar endpoints da API

## 13. Padrões de Código

### Padrão MVC (Model-View-Controller)

- **Model**: Classe `User` e estruturas de dados
- **View**: Screens e Widgets
- **Controller**: Services (AuthService, DatabaseService)

### Padrão Provider

- Utilizado para gerenciamento de estado
- Notificação de mudanças via `notifyListeners()`
- Acesso via `Provider.of<T>(context)`

### Padrão Singleton

- `DatabaseService` implementado como singleton
- Garante única instância do banco de dados

## 14. Convenções de Código

- **Nomenclatura**: camelCase para variáveis e métodos
- **Constantes**: UPPER_SNAKE_CASE
- **Classes**: PascalCase
- **Arquivos**: snake_case.dart
- **Comentários**: Explicar o "por quê", não o "o quê"

## 15. Estrutura de Diretórios

```
TP4-MVP/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── services/
│   ├── screens/
│   └── widgets/
├── test/
├── assets/
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

---

**Versão**: 1.0.0  
**Última Atualização**: 2024  
**Autor**: Desenvolvedor de Software
