# E-Project - Plataforma de Gestão de Projetos Acadêmicos

**E-Project** é uma plataforma para gestão de projetos acadêmicos, desenvolvida como MVP (Produto Mínimo Viável) para o Trabalho Prático IV.

## 📋 Descrição

O E-Project centraliza a gestão de projetos, tarefas, prazos e colaborações de forma intuitiva, oferecendo soluções tanto em plataforma Mobile (Flutter) quanto Web (React).

## 🏗️ Estrutura do Repositório

O repositório está organizado da seguinte forma para facilitar a manutenção e escalabilidade:

```text
TP4-MVP/
├── apps/
│   ├── flutter-app/     # Aplicação Mobile desenvolvida em Flutter
│   └── react-app/       # Aplicação Web desenvolvida em React
├── assets/
│   ├── prints/          # Capturas de tela das aplicações
│   └── video/           # Vídeos de demonstração do MVP
├── docs/                # Documentação técnica e requisitos
└── README.md            # Guia principal do projeto
```

## ✨ Funcionalidades Principais

### Autenticação e Cadastro
- Registro de novos usuários com validação de email e CPF.
- Login seguro com suporte a perfis diferenciados.
- Aceitação de Termos de Uso e Política de Privacidade.

### Gerenciamento de Projetos
- Criar, visualizar e gerenciar projetos acadêmicos.
- Controle de status (ativo, concluído, arquivado).
- Listagem centralizada de projetos por usuário.

### Gerenciamento de Tarefas
- Criação de tarefas vinculadas a projetos específicos.
- Definição de prazos e acompanhamento de conclusão.
- Ordenação por prioridade e data de vencimento.

## 🚀 Como Executar

### Aplicação Flutter (Mobile)
Navegue até `apps/flutter-app/` e siga as instruções:
1. Instale as dependências: `flutter pub get`
2. Execute a aplicação: `flutter run`

### Aplicação React (Web)
Navegue até `apps/react-app/` e siga as instruções:
1. Instale as dependências: `pnpm install`
2. Inicie o servidor de desenvolvimento: `pnpm dev`

## 🧪 Testes

Para executar os testes unitários da aplicação Flutter:
```bash
cd apps/flutter-app
flutter test
```

## 📄 Documentação

Documentos detalhados podem ser encontrados na pasta `/docs`:
- [Documentação Técnica](docs/TECHNICAL_DOCUMENTATION.md)
- [Requisitos do Sistema](docs/requirements.md)
- [Rastreabilidade](docs/rastreabilidade.md)

## 📄 Licença

Este projeto está licenciado sob a MIT License.

---

**Versão**: 1.0.0  
**Status**: MVP - Produto Mínimo Viável
