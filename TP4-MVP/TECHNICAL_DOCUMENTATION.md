# Documentação Técnica - E-Project App (Flutter MVP)

Este documento detalha as especificações técnicas, arquitetura e padrões de projeto aplicados no desenvolvimento do MVP do E-Project App.

## 1. Visão Geral
O E-Project App é um sistema de gerenciamento de projetos acadêmicos desenvolvido em Flutter, permitindo que estudantes organizem seus projetos, tarefas e perfis de forma segura e eficiente.

## 2. Arquitetura do Sistema
O projeto segue o padrão **MVC (Model-View-Controller)**, garantindo a separação de responsabilidades e facilitando a manutenção.

- **Model**: Define a estrutura dos dados (User, Project, Task).
- **View**: Telas da interface do usuário construídas com widgets do Flutter.
- **Controller/Provider**: Gerencia o estado da aplicação e a lógica de negócio utilizando o `Provider Pattern`.

## 3. Tecnologias e Dependências
- **Linguagem**: Dart
- **Framework**: Flutter 3.x
- **Gerenciamento de Estado**: `provider`
- **Banco de Dados Local**: `sqflite` (SQLite) para persistência robusta.
- **Roteamento**: `go_router` para navegação declarativa.
- **Segurança**: Criptografia SHA-256 para armazenamento de senhas.

## 4. Estrutura do Banco de Dados (SQLite)
O sistema utiliza 4 tabelas principais:
1. `users`: Armazena dados cadastrais (Nome, E-mail, CPF, CNS).
2. `passwords`: Armazena os hashes das senhas.
3. `projects`: Armazena os projetos acadêmicos.
4. `tasks`: Armazena as tarefas vinculadas aos projetos.

## 5. Telas Implementadas (8 Telas)
1. **Splash Screen**: Tela de abertura com logo e animação.
2. **Login Screen**: Autenticação com validação rigorosa.
3. **Signup Screen**: Cadastro com validação de CPF e CNS (H6).
4. **Dashboard Screen**: Visão geral com navegação por abas.
5. **Projects Screen**: Listagem e gestão de projetos acadêmicos.
6. **Tasks Screen**: Gerenciamento de tarefas com controle de prazos.
7. **Profile Screen**: Exibição e edição de dados do usuário.
8. **Settings Screen**: Configurações de sistema (Tema, Idioma, Notificações).

## 6. Padrões de Projeto Aplicados
- **Singleton Pattern**: Utilizado no serviço de banco de dados para garantir uma única conexão.
- **Repository Pattern**: Abstração da camada de dados para facilitar testes.
- **Observer Pattern**: Implementado via `ChangeNotifier` e `Consumer` do Provider.
