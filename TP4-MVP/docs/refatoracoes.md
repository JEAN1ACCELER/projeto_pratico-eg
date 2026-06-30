# Refatorações Aplicadas no TP4-MVP

Este documento detalha as refatorações aplicadas ao código do projeto TP4-MVP, com o objetivo de melhorar a qualidade, manutenibilidade e reusabilidade do código, conforme solicitado no enunciado do Trabalho Prático IV.

---

## 1. Extração de `CustomTextField`

- **Problema**: Repetição de código para campos de texto com validação e estilização semelhantes em `LoginScreen` e `SignupScreen`.
- **Motivação**: Reduzir duplicação de código, centralizar lógica de validação e estilização, e facilitar futuras modificações.
- **Melhoria**: Criação do widget `CustomTextField` (`lib/widgets/custom_text_field.dart`) que encapsula um `TextFormField` com `labelText`, `controller`, `obscureText`, `keyboardType` e `validator` customizáveis.
- **Impacto**: Código mais limpo e modular nas telas de autenticação, facilitando a manutenção e a aplicação de padrões de UI.

## 2. Extração de `PrimaryButton`

- **Problema**: Repetição de código para botões principais com estilização e estados de carregamento semelhantes em `LoginScreen` e `SignupScreen`.
- **Motivação**: Padronizar a aparência e o comportamento dos botões de ação, e simplificar a lógica de estado de carregamento.
- **Melhoria**: Criação do widget `PrimaryButton` (`lib/widgets/primary_button.dart`) que encapsula um `ElevatedButton` com `text`, `onPressed` e `isLoading` customizáveis.
- **Impacto**: Consistência visual e funcional em todos os botões principais da aplicação, além de um código mais conciso.

## 3. Extração de `AppLogo`

- **Problema**: Repetição de código para exibir o logo do aplicativo em `LoginScreen` e `SignupScreen`.
- **Motivação**: Centralizar a lógica de exibição do logo, permitindo fácil alteração de design ou ícone em um único local.
- **Melhoria**: Criação do widget `AppLogo` (`lib/widgets/app_logo.dart`) que encapsula a imagem ou ícone do logo com tamanho e cores customizáveis.
- **Impacto**: Redução de duplicação de código e maior flexibilidade para alterações visuais do logo.

## 4. Refatoração de `TermsDialog` para Carregamento Dinâmico

- **Problema**: O `TermsDialog` exibia termos de uso e política de privacidade hardcoded, dificultando atualizações e manutenção.
- **Motivação**: Separar o conteúdo textual da lógica de UI, permitindo que os termos sejam facilmente atualizados sem recompilar o aplicativo e aderindo à estrutura de documentação do projeto.
- **Melhoria**: O `TermsDialog` (`lib/widgets/terms_dialog.dart`) foi refatorado para carregar seu conteúdo de um arquivo Markdown (`docs/termos-de-uso.md`) usando `rootBundle.loadString`.
- **Impacto**: Maior flexibilidade para gerenciar o conteúdo dos termos, alinhamento com as diretrizes de documentação do projeto e melhor manutenibilidade.

## 5. Implementação de `SettingsService` para Persistência de Configurações

- **Problema**: As configurações de usuário (notificações, modo escuro, idioma) não eram persistentes e eram redefinidas a cada inicialização do aplicativo.
- **Motivação**: Proporcionar uma experiência de usuário consistente, mantendo as preferências salvas entre as sessões.
- **Melhoria**: Criação do `SettingsService` (`lib/services/settings_service.dart`) que utiliza `shared_preferences` para armazenar e recuperar as configurações. Integrado via `Provider` e aplicado em `main.dart` e `SettingsScreen`.
- **Impacto**: As preferências do usuário agora são persistentes, melhorando a usabilidade e a personalização do aplicativo. O código de gerenciamento de configurações foi centralizado e desacoplado da UI.

## 6. Validação de CPF e CNS com Unicidade

- **Problema**: A validação de CPF e CNS era apenas de formato, sem verificar a unicidade no banco de dados, o que poderia levar a registros duplicados.
- **Motivação**: Garantir a integridade dos dados e evitar usuários com documentos duplicados.
- **Melhoria**: Implementação de métodos de validação de unicidade para CPF e CNS no `DatabaseService` e integração desses métodos na `SignupScreen`.
- **Impacto**: Maior robustez na validação de dados de usuário e prevenção de registros duplicados.

## 7. Uso de Modelos `Project` e `Task`

- **Problema**: As telas de `ProjectsScreen` e `TasksScreen` manipulavam dados diretamente como `Map<String, dynamic>`, dificultando a leitura e manutenção do código.
- **Motivação**: Melhorar a tipagem, legibilidade e manutenibilidade do código, utilizando objetos bem definidos para representar os dados.
- **Melhoria**: Criação dos modelos `Project` (`lib/models/project.dart`) e `Task` (`lib/models/task.dart`) e refatoração das telas e do `DatabaseService` para utilizá-los.
- **Impacto**: Código mais orientado a objetos, com melhor tipagem e mais fácil de entender e estender.

## 8. Implementação de `ProjectDetailsScreen`

- **Problema**: Não havia uma tela dedicada para exibir os detalhes de um projeto, incluindo suas tarefas associadas.
- **Motivação**: Proporcionar uma visão detalhada de cada projeto, melhorando a usabilidade e a capacidade de gerenciamento.
- **Melhoria**: Criação da `ProjectDetailsScreen` (`lib/screens/project_details_screen.dart`) que exibe o título, descrição, status do projeto e uma lista de suas tarefas. Integrada à `ProjectsScreen` para navegação.
- **Impacto**: Melhor experiência do usuário ao gerenciar projetos, com acesso rápido a informações detalhadas e tarefas.
