# Comparação de Tech Stack: Flutter vs React

## 📊 Visão Geral

Este documento compara as duas implementações do Academic Project Management App.

| Aspecto | Flutter Web | React + Node.js |
|---------|-------------|-----------------|
| **Linguagem Frontend** | Dart | TypeScript/JavaScript |
| **Linguagem Backend** | N/A | TypeScript/JavaScript |
| **Framework Frontend** | Flutter | React 19 |
| **Framework Backend** | N/A | Express + tRPC |
| **Banco de Dados** | SQLite (Local) | MySQL/TiDB (Cloud) |
| **ORM** | sqflite | Drizzle ORM |
| **Autenticação** | Local | OAuth (Manus) |
| **UI Framework** | Material Design | shadcn/ui + Tailwind CSS |
| **Gerenciamento Estado** | Provider | React Query + tRPC |
| **Testes** | Flutter Test | Vitest |
| **Deploy** | Flutter Web | Vercel/Railway/Manus |

## 🎯 Quando Usar Cada Um

### Flutter Web
✅ **Ideal para:**
- Aplicações mobile-first
- Código compartilhado entre iOS, Android e Web
- Prototipagem rápida
- Equipes familiarizadas com Dart

❌ **Limitações:**
- Menos maduro para web
- Comunidade menor para web
- Banco de dados local apenas

### React + Node.js
✅ **Ideal para:**
- Aplicações web modernas
- Escalabilidade em produção
- Equipes JavaScript/TypeScript
- Banco de dados compartilhado
- APIs robustas

❌ **Limitações:**
- Requer backend separado
- Mais complexo de configurar
- Maior curva de aprendizado

## 🔄 Sincronização de Dados

### Flutter Web
- Dados armazenados localmente em SQLite
- Sincronização manual com backend (se necessário)
- Offline-first por padrão

### React + Node.js
- Dados centralizados em MySQL/TiDB
- Sincronização automática via tRPC
- Online-first com suporte a offline

## 🚀 Performance

### Flutter Web
- Bundle size: ~50-100MB
- Tempo de carregamento: 2-5s
- Performance: Excelente em dispositivos modernos

### React + Node.js
- Bundle size: ~200-300KB (gzipped)
- Tempo de carregamento: 1-2s
- Performance: Excelente com otimizações

## 🔐 Segurança

### Flutter Web
- Dados locais (sem sincronização = mais seguro)
- Sem backend = sem vulnerabilidades de API

### React + Node.js
- OAuth integrado
- Validação server-side
- HTTPS obrigatório
- Proteção contra CSRF/XSS

## 💾 Banco de Dados

### Flutter Web (SQLite)
```
Tabelas Locais:
- users
- projects
- tasks
- projectMembers
- attendanceRecords
- editais
- comments
- notifications
- projectFiles
```

### React + Node.js (MySQL/TiDB)
```
Tabelas Remotas:
- users (com OAuth)
- projects (com timestamps UTC)
- tasks (com status enum)
- projectMembers (com roles)
- attendanceRecords (com justificativas)
- editais (com status de deadline)
- relatedProjects (relacionamento M:M)
- comments (com timestamps)
- notifications (com read status)
- projectFiles (com S3 storage)
```

## 🧪 Testes

### Flutter Web
```bash
flutter test
```

### React + Node.js
```bash
pnpm test
```

## 📦 Deploy

### Flutter Web
```bash
cd flutter-app
flutter build web
# Servir pasta build/web com nginx/apache
```

### React + Node.js
```bash
cd react-app
pnpm build
# Deploy em Vercel, Railway, ou Manus
```

## 🔗 Integração Entre Aplicações

Ambas as aplicações podem coexistir:

- **Flutter Web**: Rota `/flutter` ou domínio separado
- **React Web**: Rota `/` ou domínio principal

Possibilidade de sincronizar dados entre elas via API REST/tRPC.

---

**Última atualização:** Junho 2026
