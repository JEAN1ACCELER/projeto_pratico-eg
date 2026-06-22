<div align="center">

# 🎓 E-Project
*Sistema de Gestão de Projetos Acadêmicos UFAM*

![STATUS](https://img.shields.io/badge/STATUS-SPRINT%201-blue?style=flat-square)
![DISCIPLINA](https://img.shields.io/badge/ENGENHARIA%20DE%20SOFTWARE%20I-6a0dad?style=flat-square)
![INSTITUIÇÃO](https://img.shields.io/badge/ICET--UFAM-00663C?style=flat-square)
![REPO SIZE](https://img.shields.io/github/repo-size/SEU_USUARIO/projeto-pratico-es?style=flat-square&color=555)

</div>

---

# 🎓 E-Project
**Sistema de Gestão de Projetos Acadêmicos UFAM**

## 📄 Sobre o Projeto
O **E-Project** é uma plataforma web multiplataforma (PWA) desenvolvida para centralizar a gestão de projetos acadêmicos da Universidade Federal do Amazonas. O sistema foi projetado para professores orientadores e alunos orientandos que precisam acompanhar projetos como PIBIC, PIBITI, PIBEX, PASSE e Pós-Graduação em um único ambiente digital, eliminando o retrabalho gerado pelo uso de ferramentas genéricas.

> **Problema Central:** Professores orientadores da UFAM não dispõem de uma ferramenta específica para acompanhar a evolução dos seus projetos acadêmicos após a submissão. Os sistemas oficiais (E-campus e SEI) servem apenas para cadastro e protocolo, obrigando os professores a adaptar ferramentas genéricas (Trello, Notion, Excel) e acessar múltiplos sites de pró-reitorias diariamente para encontrar editais.

## 🚀 Principais Funcionalidades
* **Dashboard Central de Projetos:** Visão unificada de todos os projetos ativos do orientador, organizados por modalidade (PIBIC, PACE, PIBEX, Mestrado etc.), com indicadores de progresso e alertas de prazo.
* **Templates Pré-formatados:** Modelos de projeto prontos com a terminologia e os campos nativos da UFAM, eliminando a necessidade de configuração manual do zero.
* **Feed Unificado de Editais:** Centralização automática dos editais abertos das pró-reitorias (PROPESP, PROEXT) com filtros, favoritos e links diretos para os documentos.
* **Gestão de Tarefas:** Sistema de atribuição de demandas entre orientador e orientandos, com controle de status (Pendente → Em Revisão → Aprovado), upload de arquivos e feedback integrado.
* **Controle de Presença:** Registro de check-in em reuniões de projeto diretamente pelo aplicativo, com validação por PIN, substituindo as listas de papel.
* **Geração Automática de Documentos:** Criação de relatórios parciais, declarações de bolsista e outros documentos oficiais preenchidos automaticamente com os dados do projeto cadastrado.
* **Acessibilidade Nativa:** Interface com suporte a alto contraste, fontes ajustáveis, botões com rótulos textuais e modo de foco sem distrações — atendendo usuários com baixa visão e necessidades cognitivas.

---

## 🏛️ Padrões Arquiteturais

O E-Project adota a **Arquitetura em Camadas (Layered Architecture)** combinada com o padrão **MVC (Model-View-Controller)**, organizando o sistema em quatro camadas com responsabilidades bem definidas:

| Camada | Padrão | Tecnologias |
| :--- | :--- | :--- |
| **Apresentação** | View / Controller | React PWA, Redux / Context API |
| **Aplicação** | Controller / Service | Node.js, Express.js, TypeScript |
| **Domínio** | Model | Classes TypeScript (entidades e regras de negócio) |
| **Infraestrutura** | Repository | PostgreSQL, Firebase Auth, Prisma |

**Por que essa escolha?**
- **Escalabilidade:** cada camada pode ser dimensionada de forma independente.
- **Testabilidade:** regras de negócio na camada de Domínio são testáveis sem dependência de banco de dados ou interface (Jest, React Testing Library).
- **Independência de frameworks:** a lógica de negócio não possui dependência de React ou Express, permitindo, por exemplo, migrar o frontend de React PWA para React Native sem impacto no domínio.

```
┌─────────────────────────────────────────────┐
│       APRESENTAÇÃO — React/Redux (MVC)       │
│  View (Componentes) ↔ Controller (Handlers) │
│            ↕ Model (Estado Redux)            │
└──────────────────────┬──────────────────────┘
                       │ HTTP/JSON (REST)
┌──────────────────────▼──────────────────────┐
│       APLICAÇÃO — Express.js                 │
│  Controllers: Auth, Project, Task, User      │
│  Services:    Project, Task, Edital          │
└──────────────────────┬──────────────────────┘
                       │
┌──────────────────────▼──────────────────────┐
│       DOMÍNIO — Entidades TypeScript         │
│  Project | User | Task | Edital | Orientation│
└──────────────────────┬──────────────────────┘
                       │
┌──────────────────────▼──────────────────────┐
│       INFRAESTRUTURA                         │
│  PostgreSQL | Firebase Auth | FCM | PDFKit   │
└─────────────────────────────────────────────┘
```

---

## 🛠️ Tech Stack

### Frontend & UI
![REACT](https://img.shields.io/badge/React-PWA-61DAFB?style=flat-square&logo=react&logoColor=black)
![TAILWIND](https://img.shields.io/badge/Tailwind%20CSS-Estilização-06B6D4?style=flat-square&logo=tailwindcss&logoColor=white)
![REDUX](https://img.shields.io/badge/Redux-Estado%20Global-764ABC?style=flat-square&logo=redux&logoColor=white)
![RECHARTS](https://img.shields.io/badge/Recharts-Gráficos-22B573?style=flat-square&logo=react&logoColor=white)

### Backend & API
![NODE](https://img.shields.io/badge/Node.js-Servidor-339933?style=flat-square&logo=node.js&logoColor=white)
![EXPRESS](https://img.shields.io/badge/Express.js-API%20RESTful-000000?style=flat-square&logo=express&logoColor=white)
![TYPESCRIPT](https://img.shields.io/badge/TypeScript-Tipagem-3178C6?style=flat-square&logo=typescript&logoColor=white)
![WINSTON](https://img.shields.io/badge/Winston-Logs%20e%20Auditoria-FF9900?style=flat-square&logo=node.js&logoColor=white)

### Banco de Dados & Autenticação
![POSTGRES](https://img.shields.io/badge/PostgreSQL-Banco%20de%20Dados-4169E1?style=flat-square&logo=postgresql&logoColor=white)
![PRISMA](https://img.shields.io/badge/Prisma-ORM-2D3748?style=flat-square&logo=prisma&logoColor=white)
![FIREBASE AUTH](https://img.shields.io/badge/Firebase%20Auth-Autenticação-FFCA28?style=flat-square&logo=firebase&logoColor=black)

### Infraestrutura & Deploy
![VERCEL](https://img.shields.io/badge/Vercel-Frontend-000000?style=flat-square&logo=vercel&logoColor=white)
![RAILWAY](https://img.shields.io/badge/Railway-Backend-0B0D0E?style=flat-square&logo=railway&logoColor=white)
![GITHUB ACTIONS](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF?style=flat-square&logo=githubactions&logoColor=white)

### Notificações & Documentos
![FCM](https://img.shields.io/badge/Firebase%20FCM-Notificações%20Push-FFCA28?style=flat-square&logo=firebase&logoColor=black)
![PDFKIT](https://img.shields.io/badge/PDFKit-Geração%20de%20PDF-CC0000?style=flat-square&logo=adobeacrobatreader&logoColor=white)

| Camada | Tecnologia | Função |
| :--- | :--- | :--- |
| Frontend | React PWA + Recharts | Interface reativa com suporte offline e dashboards visuais |
| Estilização | Tailwind CSS | Estilização utilitária com suporte a acessibilidade |
| Estado | Redux / Context API | Gerenciamento de estado global da aplicação |
| Backend | Node.js / Express + TypeScript | API RESTful com tipagem estática |
| Logs | Winston | Auditoria de ações críticas e histórico de acessos |
| Banco de Dados | PostgreSQL + Prisma ORM | Persistência relacional com conformidade ePING |
| Autenticação | Firebase Auth + Admin SDK | Login seguro, JWT e controle de perfis (Roles) |
| CI/CD | GitHub Actions | Automação de build, testes e deploy |
| Hospedagem Frontend | Vercel | Deploy contínuo integrado ao GitHub |
| Hospedagem Backend | Railway | Servidor e banco no mesmo ambiente |
| Notificações | Firebase FCM | Push notifications em tempo real |
| Geração de PDF | PDFKit | Documentos oficiais gerados automaticamente |

---

## 📁 Estrutura do Repositório

A documentação de especificação está na pasta `especificacao/`:

| Arquivo | Descrição |
| :--- | :--- |
| `1_plano-de-trabalho.md` | Escopo, tecnologias, cronograma e divisão de funções da equipe. |
| `2_design-thinking.md` | Golden Circle, Análise SWOT, Benchmarking, Personas e Ideação. |
| `3_backlog-do-product.md` | Lista priorizada de Histórias de Usuário com critérios de aceitação. |
| `4_backlog-do-sprint.md` | Acompanhamento das tarefas individuais e links das Diárias. |

A documentação de arquitetura está na pasta `projeto-e-arquitetura/`:

| Arquivo | Descrição |
| :--- | :--- |
| [`1-padroes-arquiteturais.md`](./projeto-e-arquitetura/1-padroes-arquiteturais.md) | Definição de padrões como Arquitetura em Camadas e MVC. |
| [`2-tech-stack.md`](./projeto-e-arquitetura/2-tech-stack.md) | Detalhamento das tecnologias (React, Node.js, PostgreSQL, etc). |
| [`3-c4-contexto.md`](./projeto-e-arquitetura/3-c4-contexto.md) | Diagrama de Contexto C4 e interações com sistemas externos. |
| [`4-c4-containers.md`](./projeto-e-arquitetura/4-c4-containers.md) | Diagrama de Containers C4 detalhando as aplicações e BD. |
| [`5-c4-componentes.md`](./projeto-e-arquitetura/5-c4-componentes.md) | Diagrama de Componentes C4 focado nos módulos da API. |
| [`6-c4-codigo.md`](./projeto-e-arquitetura/6-c4-codigo.md) | Diagrama de Classes UML com atributos, métodos e relações. |
| [`7-rastreabilidade.md`](./projeto-e-arquitetura/7-rastreabilidade.md) | Rastreabilidade de Histórias de Usuário e Inventário LGPD. |

---

## 👥 Equipe do Projeto
| Nome | Papel |
| :--- | :--- |
| **Jean Carlos** | Scrum Master / Líder |
| **Luzineia** | Front-end / Integração |
| **Pedro** | Design / UX |
| **Ricky Brendon** | Backlog / Histórias de Usuário |
| **Gustavo Souza** | QA / Documentação |

## 🔗 Links de Gestão
* [Sessão de Brainstorming (Notion)](https://www.notion.so/94f37ff22f25833faf0881dcb7b46d87?v=eff37ff22f2583b1ab368848a4691fbc&source=copy_link)
* [Tabela de Daily Scrum (Notion)](https://www.notion.so/Daily-34d37ff22f25803fa453ee67ec46a3a6)
* [Quadro Backlog do Produto (GitHub Projects)](https://github.com/users/JEAN1ACCELER/projects/2/views/2)
* [Quadro Backlog do Sprint (GitHub Projects)](https://github.com/users/JEAN1ACCELER/projects/3)

---

**Universidade Federal do Amazonas — ICET | Engenharia de Software A | 2026/04**
