# E-Project - Plataforma de Gestão de Projetos Acadêmicos

**E-Project** é uma aplicação Flutter para gestão de projetos acadêmicos, desenvolvida como MVP (Produto Mínimo Viável) para o Trabalho Prático IV.

## 📋 Descrição

O E-Project é uma plataforma mobile especializada em gestão de projetos acadêmicos, permitindo que professores e alunos gerenciem projetos, tarefas, prazos e colaborações de forma centralizada e intuitiva.

## ✨ Funcionalidades Principais

### Autenticação e Cadastro
- Registro de novos usuários com validação de email e CPF
- Login seguro com armazenamento local de credenciais
- Suporte a dois tipos de usuário: Doador e Receptor
- Aceitação de Termos de Uso e Política de Privacidade

### Gerenciamento de Projetos
- Criar, visualizar e gerenciar projetos acadêmicos
- Definir status de projetos (ativo, concluído, arquivado)
- Adicionar descrições e detalhes aos projetos
- Visualizar lista de todos os projetos do usuário

### Gerenciamento de Tarefas
- Criar tarefas dentro de projetos
- Definir datas de vencimento para tarefas
- Marcar tarefas como concluídas
- Visualizar tarefas pendentes e concluídas
- Ordenar tarefas por data de vencimento

### Perfil do Usuário
- Visualizar informações pessoais
- Editar dados de perfil
- Visualizar histórico de atividades
- Fazer logout da aplicação

### Configurações
- Ativar/desativar notificações
- Alternar entre modo claro e escuro
- Selecionar idioma (Português, Inglês, Espanhol)
- Acessar Termos de Uso e Política de Privacidade
- Visualizar informações sobre a aplicação

## 🏗️ Arquitetura

O projeto segue uma arquitetura em camadas bem definida:

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── models/                   # Modelos de dados
│   └── user.dart            # Modelo de usuário
├── services/                # Serviços de negócio
│   ├── auth_service.dart    # Serviço de autenticação
│   └── database_service.dart # Serviço de banco de dados
├── screens/                 # Telas da aplicação
│   ├── splash_screen.dart   # Tela de carregamento
│   ├── login_screen.dart    # Tela de login
│   ├── signup_screen.dart   # Tela de cadastro
│   ├── dashboard_screen.dart # Tela principal
│   ├── projects_screen.dart # Tela de projetos
│   ├── tasks_screen.dart    # Tela de tarefas
│   ├── profile_screen.dart  # Tela de perfil
│   └── settings_screen.dart # Tela de configurações
└── widgets/                 # Componentes reutilizáveis
    └── terms_dialog.dart    # Diálogo de termos
```

## 🗄️ Banco de Dados

O projeto utiliza SQLite para armazenamento local com as seguintes tabelas:

| Tabela | Descrição |
|--------|-----------|
| `users` | Armazena informações dos usuários |
| `passwords` | Armazena hashes de senhas |
| `projects` | Armazena projetos acadêmicos |
| `tasks` | Armazena tarefas dos projetos |

## 🚀 Como Executar

### Pré-requisitos

- Flutter SDK 3.0.0 ou superior
- Dart 3.0.0 ou superior
- Android Studio ou Xcode (para emulador)
- Um dispositivo Android ou iOS para testes

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/projeto_pratico-eg.git
cd projeto_pratico-eg/TP4-MVP
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute a aplicação:
```bash
flutter run
```

### Executar em Plataforma Específica

Para Android:
```bash
flutter run -d android
```

Para iOS:
```bash
flutter run -d ios
```

## 🧪 Testes

O projeto inclui testes unitários para validar a lógica de autenticação e banco de dados:

```bash
flutter test
```

## 📦 Dependências

As principais dependências do projeto são:

| Dependência | Versão | Propósito |
|-------------|--------|----------|
| `provider` | ^6.0.0 | Gerenciamento de estado |
| `sqflite` | ^2.2.8+4 | Banco de dados local |
| `intl` | ^0.19.0 | Internacionalização |
| `email_validator` | ^2.1.17 | Validação de email |
| `crypto` | ^3.0.3 | Criptografia de senhas |

## 🎨 Design e UI/UX

A aplicação utiliza Material Design 3 com uma paleta de cores moderna:

- **Cor Primária**: Azul (#2196F3)
- **Cor Secundária**: Azul Claro (#64B5F6)
- **Cor de Erro**: Vermelho (#F44336)
- **Cor de Sucesso**: Verde (#4CAF50)

## 📱 Telas da Aplicação

### 1. Splash Screen
Tela de carregamento exibida ao iniciar a aplicação, com logo e animação de carregamento.

### 2. Login Screen
Permite que usuários existentes façam login com email e senha, com validação de credenciais.

### 3. Signup Screen
Formulário de cadastro para novos usuários com campos para nome, email, CPF, CNS, senha e aceitação de termos.

### 4. Dashboard Screen
Tela principal com navegação em abas para Projetos, Tarefas, Perfil e Configurações.

### 5. Projects Screen
Exibe lista de projetos do usuário com opção de criar novos projetos e visualizar detalhes.

### 6. Tasks Screen
Mostra tarefas pendentes com opção de criar novas tarefas e definir datas de vencimento.

### 7. Profile Screen
Exibe informações pessoais do usuário e opção de fazer logout.

### 8. Settings Screen
Permite configurar notificações, aparência, idioma e acessar informações sobre a aplicação.

## 🔒 Segurança

- Senhas são armazenadas como hash SHA-256
- Dados sensíveis são armazenados localmente no dispositivo
- Validação de entrada em todos os formulários
- Proteção contra SQL injection através do ORM SQLite

## 📄 Licença

Este projeto está licenciado sob a MIT License - veja o arquivo LICENSE para detalhes.

## 👥 Autores

Desenvolvido como Trabalho Prático IV para a disciplina de Engenharia de Software.

## 📞 Suporte

Para reportar bugs ou sugerir melhorias, abra uma issue no repositório GitHub.

---

**Versão**: 1.0.0  
**Data de Criação**: 2024  
**Status**: MVP - Produto Mínimo Viável
