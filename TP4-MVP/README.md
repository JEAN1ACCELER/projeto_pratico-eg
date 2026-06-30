# TP4-MVP — Academic Project Management App

Este é o repositório do projeto TP4-MVP, um aplicativo de gerenciamento de projetos acadêmicos desenvolvido para auxiliar estudantes e professores na organização e acompanhamento de suas atividades.

## 🚀 Tecnologias Utilizadas

O projeto oferece **duas implementações** para máxima flexibilidade:

### Flutter Web (Mobile & Web)
- **Framework:** Flutter
- **Linguagem:** Dart
- **Banco de Dados Local:** SQLite (via `sqflite`)
- **Gerenciamento de Estado:** Provider

### React Web (Full-Stack)
- **Frontend:** React 19 + TypeScript + Tailwind CSS 4
- **Backend:** Node.js + Express + tRPC
- **Banco de Dados:** MySQL/TiDB
- **ORM:** Drizzle ORM
- **Autenticação:** OAuth Manus
- **UI Components:** shadcn/ui

## 📁 Estrutura de Pastas

```
TP4-MVP/
├── flutter-app/              # Aplicação Flutter (Mobile & Web)
│   ├── src/
│   │   ├── components/       # Widgets reutilizáveis
│   │   ├── pages/            # Telas principais
│   │   ├── services/         # Serviços de backend
│   │   ├── models/           # Modelos de dados
│   │   ├── utils/            # Utilitários
│   │   ├── app.dart          # Configuração principal
│   │   └── main.dart         # Ponto de entrada
│   ├── docs/                 # Documentação Flutter
│   ├── prints/               # Capturas de tela
│   └── video/                # Vídeos de demonstração
│
├── react-app/                # Aplicação React + Node.js (Full-Stack)
│   ├── client/               # Frontend React
│   │   ├── src/
│   │   │   ├── pages/        # Páginas principais
│   │   │   ├── components/   # Componentes React
│   │   │   ├── hooks/        # Custom hooks
│   │   │   ├── lib/          # Utilitários
│   │   │   ├── contexts/     # Contextos React
│   │   │   ├── App.tsx       # Componente raiz
│   │   │   └── main.tsx      # Ponto de entrada
│   │   └── index.html        # Template HTML
│   │
│   ├── server/               # Backend Node.js
│   │   ├── routers.ts        # Endpoints tRPC
│   │   ├── db.ts             # Query helpers
│   │   ├── storage.ts        # S3 storage
│   │   └── _core/            # Framework core
│   │
│   ├── drizzle/              # Schema e migrações
│   │   ├── schema.ts         # Definições de tabelas
│   │   └── migrations/       # Migrações SQL
│   │
│   ├── shared/               # Código compartilhado
│   │   ├── const.ts          # Constantes
│   │   └── types.ts          # Tipos TypeScript
│   │
│   ├── package.json          # Dependências
│   ├── tsconfig.json         # Configuração TypeScript
│   ├── vite.config.ts        # Configuração Vite
│   └── vitest.config.ts      # Configuração Vitest
│
├── docs/                     # Documentação unificada
├── CHANGELOG.md              # Histórico de alterações
└── README.md                 # Este arquivo
```

## 🏃 Como Rodar Localmente

### Flutter Web

```bash
cd TP4-MVP/flutter-app

# Instalar dependências
flutter pub get

# Rodar no navegador
flutter run -d chrome

# Ou em um emulador
flutter run
```

### React + Node.js

```bash
cd TP4-MVP/react-app

# Instalar dependências
pnpm install

# Rodar em desenvolvimento
pnpm dev

# Verificar tipos TypeScript
pnpm check

# Executar testes
pnpm test

# Build para produção
pnpm build
```

## 📊 Funcionalidades Principais

### Ambas as Aplicações Incluem:

- ✅ **Dashboard** com estatísticas em tempo real
- ✅ **Gerenciamento de Projetos** (PIBIC, PACE, Pibex, PIBID, Mestrado)
- ✅ **Gerenciamento de Tarefas** por projeto
- ✅ **Controle de Frequência** com justificativas
- ✅ **Editais e Oportunidades** (listagem pública)
- ✅ **Comentários** nos projetos
- ✅ **Notificações** por usuário
- ✅ **Upload de Arquivos** com armazenamento em S3

### Específico React + Node.js:

- 🔐 **Autenticação OAuth** integrada
- 📱 **API tRPC** type-safe
- 🗄️ **Banco de Dados** MySQL/TiDB com Drizzle ORM
- 🎨 **UI Components** com shadcn/ui
- 🧪 **Testes** com Vitest

## 📚 Documentação Adicional

- [Documentação Técnica](docs/TECHNICAL_DOCUMENTATION.md)
- [Rastreabilidade de Requisitos](docs/rastreabilidade.md)
- [Refatorações Realizadas](docs/refatoracoes.md)
- [Termos de Uso](docs/termos-de-uso.md)

## 📸 Capturas de Tela

Visualize as capturas de tela do aplicativo Flutter na pasta [flutter-app/prints/](flutter-app/prints/).

## 🎬 Vídeo de Demonstração

Assista aos vídeos de demonstração na pasta [flutter-app/video/](flutter-app/video/).

## 🔄 Banco de Dados (React App)

### Tabelas Implementadas:

1. **users** - Usuários do sistema
2. **projects** - Projetos acadêmicos
3. **tasks** - Tarefas dos projetos
4. **projectMembers** - Membros dos projetos
5. **attendanceRecords** - Registros de frequência
6. **editais** - Editais e oportunidades
7. **relatedProjects** - Projetos relacionados
8. **comments** - Comentários nos projetos
9. **notifications** - Notificações dos usuários
10. **projectFiles** - Arquivos dos projetos

## 🧪 Testes

### React App:

```bash
cd react-app

# Executar testes
pnpm test

# Com cobertura
pnpm test -- --coverage
```

## 🚢 Deploy

### Flutter Web:
```bash
cd flutter-app
flutter build web
# Servir arquivos da pasta 'build/web'
```

### React App:
```bash
cd react-app
pnpm build
# Fazer deploy da pasta 'dist'
```

## 📝 Changelog

Veja o arquivo [CHANGELOG.md](CHANGELOG.md) para histórico completo de alterações.

## 👥 Contribuidores

- **Equipe TP4-MVP**

## 📄 Licença

Este projeto é licenciado sob a MIT License - veja o arquivo LICENSE para detalhes.

---

**Última atualização:** Junho 2026
