# 4. Diagrama de Containers — Modelo C4

## 4.1 Visão geral do diagrama
O **Diagrama de Containers** detalha os blocos de execução do sistema, mostrando como o E-Project é dividido em unidades independentes de implantação (Web App, API, Banco de Dados).

## 4.2 Explicação geral do diagrama
O sistema é composto por uma aplicação PWA em React, uma API robusta em NestJS/Node.js, um banco de dados PostgreSQL para dados estruturados e um Storage para arquivos de relatórios.

## 4.3 Diagrama de Containers — Visão Completa

```mermaid
flowchart TB
    subgraph eproject["E-Project - Sistema"]
        pwa["Aplicação Web PWA\n(React + TS)\nInterface responsiva."]
        api["API Backend\n(NestJS)\nLógica de negócio."]
        db["Banco de Dados\n(PostgreSQL)\nPersistência."]
        files["Storage\n(S3)\nArquivos e anexos."]
    end

    professor["Professor"] -- "HTTPS" --> pwa
    pwa -- "JSON/REST" --> api
    api -- "SQL" --> db
    api -- "Upload" --> files
```
**Figura 1 — Diagrama de Containers do E-Project.**

---

### Arquivo: `5-c4-componentes.md`

````markdown
# 5. Diagrama de Componentes — Modelo C4

## 5.1 Visão geral do diagrama
O **Diagrama de Componentes** foca dentro de um container específico. Aqui, detalhamos a **API Backend**, mostrando como seus módulos internos estão organizados.

## 5.2 Explicação geral do diagrama
A API segue a arquitetura modular do NestJS, separando as responsabilidades em controladores de rota, serviços de lógica e repositórios de acesso a dados.

## 5.3 Diagrama de Componentes (API Backend)

```mermaid
flowchart LR
    subgraph api["API Backend (NestJS)"]
        auth["Auth Controller\nValida login."]
        proj["Project Module\nRegras de projetos."]
        task["Task Module\nGestão de tarefas."]
        repo["Data Access Layer\nPrisma ORM."]
    end

    pwa["PWA Frontend"] -- "Requisições" --> auth
    pwa -- "Requisições" --> proj
    proj --> repo
    task --> repo
    repo -- "Queries" --> db[("PostgreSQL")]
```
**Figura 1 — Componentes internos da API Backend.**
