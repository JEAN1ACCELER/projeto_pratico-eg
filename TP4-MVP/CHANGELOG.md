# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

## [1.0.0] - 2025-01-01

### Adicionado
- Estrutura inicial do projeto Flutter
- Tela de Splash Screen com animação de carregamento
- Tela de Login com validação de campos (email e senha)
- Tela de Cadastro com campos: Nome, Email, CEP, CNS e Senha (H6)
- Tela de Dashboard com cards de métricas e gráficos (fl_chart)
- Tela de Perfil do Usuário
- Tela de Listagem de Doações
- Tela de Detalhes da Doação com Hero animation
- Tela de Formulário de Criação/Edição
- Gerenciamento de estado com Provider (ChangeNotifier)
- Repository Pattern para abstração de dados
- Persistência local com Hive
- Navegação declarativa com GoRouter
- Validação de formulários com regex
- Tema customizado Material Design 3
- Testes unitários, de widget e de integração
- Documentação de rastreabilidade com histórias de usuário
- Documentação de 5 refatorações aplicadas

### Refatorações
- Extract Widget: Extração de widgets reutilizáveis
- Extract Method: Separação de lógica de validação
- Introduce Parameter Object: Agrupamento de parâmetros em UserModel
- Replace Nested Conditional with Guard Clauses: Simplificação de condicionais
- Extract Provider: Separação do estado em ChangeNotifier
