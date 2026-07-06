# E-Project - Plataforma de Gestão de Projetos Acadêmicos
<div align="center">

# 🎓 E-Project — TP4-MVP
### Produto Mínimo Viável — Gestão de Projetos Acadêmicos da UFAM

![STATUS](https://img.shields.io/badge/STATUS-MVP-blue?style=flat-square)
![VERSÃO](https://img.shields.io/badge/VERS%C3%83O-2.0.0-informational?style=flat-square)
![DISCIPLINA](https://img.shields.io/badge/ENGENHARIA%20DE%20SOFTWARE%20I-6a0dad?style=flat-square)
![INSTITUIÇÃO](https://img.shields.io/badge/ICET--UFAM-00663C?style=flat-square)
![LICENÇA](https://img.shields.io/badge/LICEN%C3%87A-MIT-yellow?style=flat-square)

</div>

---

## 📄 Sobre o projeto

O **E-Project** centraliza a gestão de projetos acadêmicos (PIBIC, PIBITI, PACE, PIBEX, Mestrado etc.) para professores orientadores e alunos orientandos da UFAM, substituindo o uso de ferramentas genéricas (planilhas, Trello, Notion) e a consulta manual a múltiplos sites de pró-reitorias em busca de editais.

Esta pasta (`TP4-MVP`) corresponde à entrega do **Trabalho Prático IV**: a evolução do protótipo gerado no Figma Make para uma aplicação funcional e navegável, com no mínimo 8 telas implementadas, rastreabilidade das histórias de usuário e evidências de testes.

O MVP possui **duas implementações independentes** da mesma proposta de produto — uma em Flutter e outra em React/Node.js — além de uma API backend própria em Express + Prisma, permitindo comparar abordagens tecnológicas para o mesmo domínio (veja [`docs/TECH_STACK_COMPARISON.md`](docs/TECH_STACK_COMPARISON.md)).

 **🌐 Hospedagem e ambiente de demonstração:** para fins de apresentação do MVP, o aplicativo foi hospedado no **Google AI Studio**, simulando de forma sintética sua institucionalização como se fosse uma dependência direta do **e-Campus** (sistema acadêmico oficial da UFAM). Trata-se de um ambiente de demonstração do Trabalho Prático IV, e não de uma integração oficial ou publicada pela universidade.

## 🏗️ Estrutura do repositório

```text
TP4-MVP/
├── app/
│   └── apps/
│       ├── flutter-app/     # App mobile/web em Flutter (implementação principal do MVP)
│       │   └── lib/
│       │       ├── pages/       # Telas (login, signup, dashboard, projetos, tarefas, editais...)
│       │       ├── providers/   # Gerenciamento de estado
│       │       ├── services/    # Regras de negócio e acesso a dados
│       │       ├── models/      # Entidades de domínio
│       │       └── widgets/     # Componentes reutilizáveis
│       │
│       ├── react-app/       # App web em React 19 + TypeScript (implementação alternativa)
│       │   ├── client/          # Frontend (Vite, shadcn/ui, Tailwind, tRPC client)
│       │   ├── server/          # Backend embutido (Express, tRPC, Drizzle ORM)
│       │   ├── drizzle/         # Migrações do banco (MySQL/TiDB)
│       │   └── shared/          # Tipos e schemas compartilhados
│       │
│       └── backend/         # API REST própria (Express + Prisma + PostgreSQL)
│           ├── prisma/           # Schema, migrações e seed
│           └── src/
│               ├── application/ # Controllers e Services (Auth, Projeto, Tarefa, Entrega,
│               │                 #  Reunião, Edital, Notificação, Documento)
│               ├── domain/       # Validadores de domínio
│               ├── infrastructure/ # Autenticação (JWT) e geração de PDF
│               └── config/       # Variáveis de ambiente e logger (Winston)
│
├── assets/
│   ├── prints/funcionalidades/telas.md  # Rastreabilidade visual das telas (prints + US)
│   └── video/script-demonstracao.md     # Roteiro do vídeo de demonstração do MVP
│
├── docs/
│   ├── requirements.md               # Requisitos do MVP (enunciado do TP4)
│   ├── rastreabilidade.md            # Rastreabilidade requisito ↔ US ↔ código ↔ testes
│   ├── refatoracoes.md               # Refatorações aplicadas (qualidade de código)
│   ├── TECHNICAL_DOCUMENTATION.md    # Arquitetura, fluxos, schema e padrões de projeto
│   ├── TECH_STACK_COMPARISON.md      # Comparativo Flutter vs. React/Node.js
│   ├── termos-de-uso.md              # Termos de Uso e Política de Privacidade
│   └── todo.md                       # Checklist de telas e funcionalidades do MVP
│
├── CHANGELOG.md
└── README.md
```

> ℹ️ A pasta `app/apps/#!` presente no repositório é um artefato residual de um script (`#!/bin/bash`) commitado por engano e pode ser ignorada/removida.

## 🧰 Stack tecnológica

| Camada | Flutter App | React App | Backend (API própria) |
| :--- | :--- | :--- | :--- |
| Linguagem | Dart | TypeScript | TypeScript |
| UI / Framework | Flutter (Material Design) | React 19 + shadcn/ui + Tailwind CSS 4 | — |
| Comunicação | HTTP local | tRPC (type-safe) | REST (Express) |
| Gerenciamento de estado | Provider | React Query + tRPC | — |
| Banco de dados | SQLite (local) | MySQL/TiDB (Drizzle ORM) | PostgreSQL (Prisma ORM) |
| Autenticação | Local (hash de senha) | OAuth (Manus) | JWT (`jsonwebtoken` + `bcrypt`) |
| Testes | `flutter_test` | Vitest | Vitest |
| Documentos/PDF | — | — | `pdfkit` |
| Logs/Auditoria | — | — | Winston |

Mais detalhes em [`docs/TECH_STACK_COMPARISON.md`](docs/TECH_STACK_COMPARISON.md) e [`docs/TECHNICAL_DOCUMENTATION.md`](docs/TECHNICAL_DOCUMENTATION.md).

## ✨ Telas e funcionalidades do MVP

O MVP implementa as 8 telas obrigatórias exigidas pelo enunciado do TP4, com rastreabilidade completa às histórias de usuário do backlog (detalhamento com prints em [`assets/prints/funcionalidades/telas.md`](assets/prints/funcionalidades/telas.md)):

| # | Tela | História(s) de usuário atendida(s) |
| :-- | :--- | :--- |
| 1 | **Login** | US-01 — Login com matrícula/e-mail institucional e senha |
| 2 | **Cadastro de Usuário** | Base para autenticação, com seleção de perfil (Estudante/Orientador) |
| 3 | **Dashboard do Orientador** | US-02 — Projetos ativos consolidados · US-05 — Feed de editais · US-07 — Geração de documentos |
| 4 | **Detalhes do Projeto** (gestão de tarefas) | US-04 — Criar e atribuir tarefas · US-07 — Geração de documentos oficiais |
| 5 | **Detalhes do Projeto** (revisão de entregas) | US-06 — Revisar entregas e dar feedback (aprovar/solicitar correção) |
| 6 | **Cadastro de Novo Projeto** | US-03 — Criar projeto por modalidade (PIBIC, PACE, TCC...) |
| 7 | **Lista de Projetos** | US-02 — Listagem detalhada dos projetos do orientador |
| 8 | **Temas e Acessibilidade** | US-15 — Modo escuro/claro/alto contraste e ajuste de fonte |

Funcionalidades adicionais cobertas pela API/backend: gestão de reuniões e controle de presença, notificações, upload/gestão de documentos e emissão de relatórios em PDF.

## 🚀 Como executar

### Pré-requisitos gerais
- [Node.js](https://nodejs.org/) 18+ e [pnpm](https://pnpm.io/)
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.x
- [Docker](https://www.docker.com/) (para subir o PostgreSQL do backend) ou uma instância PostgreSQL 16+ local

### 1. App Flutter (implementação principal)
```bash
cd app/apps/flutter-app
flutter pub get
flutter run
```

### 2. API Backend (Express + Prisma + PostgreSQL)
```bash
cd app/apps/backend

# Suba o banco PostgreSQL via Docker
docker compose up -d

# Instale as dependências
npm install

# Configure as variáveis de ambiente (crie um .env com base nas chaves abaixo)
# DATABASE_URL, JWT_SECRET, JWT_EXPIRES_IN, PORT, CORS_ORIGIN

# Rode as migrations e o seed de dados de demonstração
npm run prisma:migrate
npm run seed

# Inicie a API em modo desenvolvimento (http://localhost:3000)
npm run dev
```
No Windows, o script `setup-db.ps1` automatiza a criação do banco, das tabelas e do seed:
```powershell
powershell -ExecutionPolicy Bypass -File setup-db.ps1
```
Usuários de demonstração criados pelo seed (senha `senha123`): `admin@ufam.edu.br`, `victor.antunes@ufam.edu.br` (professor) e `ana.beatriz@ufam.edu.br` (aluna).

Rotas expostas pela API: `/auth`, `/projetos`, `/tarefas`, `/entregas`, `/reunioes`, `/editais`, `/notificacoes`, `/documentos`.

### 3. App React (implementação alternativa, full-stack em um único processo)
```bash
cd app/apps/react-app
pnpm install
pnpm dev      # inicia o servidor Express + tRPC servindo o client Vite
```
Outros comandos úteis: `pnpm build` (build de produção), `pnpm start` (executa o build), `pnpm check` (checagem de tipos), `pnpm db:push` (gera e aplica migrações do Drizzle).

## 🧪 Testes

```bash
# Flutter
cd app/apps/flutter-app
flutter test

# Backend
cd app/apps/backend
npm test          # ou: npm run test:watch

# React app
cd app/apps/react-app
pnpm test
```

## 📚 Documentação

| Documento | Conteúdo |
| :--- | :--- |
| [`docs/requirements.md`](docs/requirements.md) | Requisitos oficiais do MVP conforme enunciado do TP4 |
| [`docs/TECHNICAL_DOCUMENTATION.md`](docs/TECHNICAL_DOCUMENTATION.md) | Arquitetura em camadas, fluxo de dados, schema de banco e padrões de projeto |
| [`docs/TECH_STACK_COMPARISON.md`](docs/TECH_STACK_COMPARISON.md) | Comparativo técnico entre as implementações Flutter e React |
| [`docs/rastreabilidade.md`](docs/rastreabilidade.md) | Matriz de rastreabilidade requisito ↔ história de usuário ↔ código ↔ testes |
| [`docs/refatoracoes.md`](docs/refatoracoes.md) | Refatorações aplicadas para reduzir duplicação e melhorar manutenibilidade |
| [`docs/termos-de-uso.md`](docs/termos-de-uso.md) | Termos de Uso e Política de Privacidade exibidos no cadastro/login |
| [`docs/todo.md`](docs/todo.md) | Checklist de telas e funcionalidades previstas para o MVP |
| [`assets/prints/funcionalidades/telas.md`](assets/prints/funcionalidades/telas.md) | Rastreabilidade visual (prints de cada tela) |
| [`assets/video/script-demonstracao.md`](assets/video/script-demonstracao.md) | Roteiro do vídeo de demonstração do MVP |
| [`CHANGELOG.md`](CHANGELOG.md) | Histórico de versões do MVP |

## 📝 Changelog

- **2.0.0** — Adição da implementação full-stack em React 19 + Node.js/tRPC + MySQL/TiDB, mantendo a aplicação Flutter original e reorganizando o repositório.
- **1.0.0** — Versão inicial do MVP em Flutter, com autenticação local, gestão de projetos/tarefas, controle de frequência, editais, comentários e notificações.

Veja o histórico completo em [`CHANGELOG.md`](CHANGELOG.md).

## 📄 Documentação

Documentos detalhados podem ser encontrados na pasta `/docs`:
- [Documentação Técnica](docs/TECHNICAL_DOCUMENTATION.md)
- [Requisitos do Sistema](docs/requirements.md)
- [Rastreabilidade](docs/rastreabilidade.md)

## 📄 Licença

Este projeto está licenciado sob a [MIT License](../LICENSE).

---

<div align="center">

**Disciplina:** Engenharia de Software A — ICET/UFAM · **Etapa:** Trabalho Prático IV (MVP)

</div>


