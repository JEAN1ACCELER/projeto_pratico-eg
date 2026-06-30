# Rastreabilidade - TP4-MVP

Este documento detalha a rastreabilidade entre os requisitos do Trabalho Prático IV (TP4-MVP) e sua implementação no código-fonte, testes e documentação.

## Requisitos do PDF vs. Implementação

| Requisito do PDF | História de Usuário (US) | Implementação (Arquivos) | Testes (Arquivos) | Documentação (Arquivos) |
| :--------------- | :----------------------- | :----------------------- | :---------------- | :---------------------- |
| **8 Telas**      |                          |                          |                   |                         |
| Splash Screen    |                          | `lib/screens/splash_screen.dart` |                   |                         |
| Login Screen     | US-01: Login no Sistema  | `lib/screens/login_screen.dart`, `lib/services/auth_service.dart` | `test/auth_service_test.dart` | `README.md`, `TECHNICAL_DOCUMENTATION.md` |
| Signup Screen    | US-02: Cadastro de Novo Usuário | `lib/screens/signup_screen.dart`, `lib/models/user.dart`, `lib/services/database_service.dart` | `test/database_service_test.dart` | `README.md`, `TECHNICAL_DOCUMENTATION.md` |
| Dashboard Screen |                          | `lib/screens/dashboard_screen.dart` |                   |                         |
| Projects Screen  | US-04: Criar Projeto, US-05: Visualizar Projetos | `lib/screens/projects_screen.dart`, `lib/services/database_service.dart` | `test/database_service_test.dart` | `README.md`, `TECHNICAL_DOCUMENTATION.md` |
| Tasks Screen     | US-06: Criar Tarefa, US-07: Visualizar Tarefas | `lib/screens/tasks_screen.dart`, `lib/services/database_service.dart` | `test/database_service_test.dart` | `README.md`, `TECHNICAL_DOCUMENTATION.md` |
| Profile Screen   | US-03: Visualizar Perfil | `lib/screens/profile_screen.dart` |                   | `README.md`, `TECHNICAL_DOCUMENTATION.md` |
| Settings Screen  | US-08: Configurar Preferências | `lib/screens/settings_screen.dart` |                   | `README.md`, `TECHNICAL_DOCUMENTATION.md` |
| **Funcionalidades Técnicas** |                          |                          |                   |                         |
| Banco de Dados (SQLite) |                          | `lib/services/database_service.dart` | `test/database_service_test.dart` | `TECHNICAL_DOCUMENTATION.md` |
| Autenticação e Segurança | US-01, US-02             | `lib/services/auth_service.dart` | `test/auth_service_test.dart` | `TECHNICAL_DOCUMENTATION.md` |
| Gerenciamento de Estado (Provider) |                          | `lib/main.dart`, `lib/services/auth_service.dart`, `lib/services/database_service.dart` |                   | `TECHNICAL_DOCUMENTATION.md` |
| Navegação        |                          | `lib/main.dart`, `lib/screens/dashboard_screen.dart` |                   | `TECHNICAL_DOCUMENTATION.md` |
| **Documentação Técnica** |                          |                          |                   |                         |
| README.md        |                          |                          |                   | `README.md`             |
| TECHNICAL_DOCUMENTATION.md |                          |                          |                   | `TECHNICAL_DOCUMENTATION.md` |
| Testes Unitários |                          |                          | `test/auth_service_test.dart`, `test/database_service_test.dart` | `TECHNICAL_DOCUMENTATION.md` |
| Qualidade de Código |                          | `analysis_options.yaml`  |                   | `TECHNICAL_DOCUMENTATION.md` |

## Histórias de Usuário e Rastreabilidade

Este MVP implementa as seguintes histórias de usuário, conforme mapeado no `todo.md`:

- **US-01: Login no Sistema**
- **US-02: Cadastro de Novo Usuário**
- **US-03: Visualizar Perfil**
- **US-04: Criar Projeto**
- **US-05: Visualizar Projetos**
- **US-06: Criar Tarefa**
- **US-07: Visualizar Tarefas**
- **US-08: Configurar Preferências**

Cada história de usuário está diretamente ligada aos componentes, serviços e testes correspondentes, garantindo que todos os requisitos funcionais do PDF sejam atendidos e verificáveis.
