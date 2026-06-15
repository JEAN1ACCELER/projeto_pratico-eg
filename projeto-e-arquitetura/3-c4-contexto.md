<div align="center">

# Diagrama de Containers

**E-Project** · C4 Model · Nível 2

![UFAM](https://img.shields.io/badge/ICET--UFAM-Engenharia%20de%20Software%20I-00663C?style=flat-square)
![C4](https://img.shields.io/badge/C4%20Model-N%C3%ADvel%202%20%E2%80%94%20Containers-4A90D9?style=flat-square)
![Sprint](https://img.shields.io/badge/Status-SPRINT%201-blue?style=flat-square)

</div>

---

## 4.1 Visão Geral do Diagrama

O **Diagrama de Containers** representa o Nível 2 do modelo C4. Ele tem a função de "abrir a caixa preta" do sistema E-Project apresentada no Nível 1 (Contexto), revelando os principais blocos de execução (containers) que compõem a arquitetura da solução.

Neste nível, detalhamos a arquitetura técnica, mostrando as responsabilidades de cada aplicação, banco de dados e as tecnologias envolvidas nas comunicações internas (APIs, conexões de banco) e externas (integrações com Firebase).

---

## 4.2 Explicação Geral do Diagrama Modelado para o Sistema

O sistema E-Project foi desenhado com uma arquitetura baseada na separação de responsabilidades entre cliente, servidor e persistência de dados. Ele é composto por três containers principais:

### 📦 Containers Internos do Sistema

| Container | Tecnologia Base | Responsabilidade |
|-----------|-----------------|------------------|
| **Aplicação Web (PWA)** | React, Tailwind, Recharts | Fornece a interface com o usuário, dashboards visuais (gráficos) para professores e administradores, kanban de tarefas e garante usabilidade offline. |
| **API RESTful (Backend)** | Node.js, Express, PDFKit, Winston | Centraliza as regras de negócio, gerencia autorizações, gera documentos oficiais em PDF dinamicamente e audita logs de segurança. |
| **Banco de Dados** | PostgreSQL | Armazena de forma estruturada e relacional os dados dos usuários, projetos, tarefas, editais e logs de auditoria. |

O fluxo principal de comunicação ocorre via chamadas `HTTP/REST` no formato JSON do Frontend para a API. A API, por sua vez, interage com o banco de dados via `SQL` (utilizando um ORM) e com os serviços externos para validação de tokens (`JWT`) e disparo de eventos de notificação.

---

## 4.3 Diagrama de Containers — Visão Completa

```mermaid
flowchart TB
    professor["👨‍🏫 Professor Orientador\n[Person]"]
    aluno["👨‍🎓 Aluno Orientando\n[Person]"]
    admin["🛠️ Administrador / Coordenador\n[Person]"]

    subgraph eproject ["🎓 E-Project [Software System]"]
        pwa["📱 Aplicação Web PWA\n[Container: React / JavaScript]\nFornece as interfaces de dashboards,\nkanban, editais e painel de gestão."]
        
        api["⚙️ API RESTful\n[Container: Node.js / Express]\nProcessa regras de negócio, gerencia\nPDFs, controla acessos e gera logs."]
        
        db["🗄️ Banco de Dados\n[Container: PostgreSQL]\nArmazena usuários, projetos, tarefas,\neditais, orientações e logs."]
    end

    firebaseauth["🔐 Firebase Authentication\n[Software System]\nAutenticação e gestão de identidade"]
    fcm["🔔 Firebase Cloud Messaging\n[Software System]\nServiço de notificações push"]

    professor --> |Acessa via navegador| pwa
    aluno --> |Acessa via navegador / mobile| pwa
    admin --> |Acessa via navegador| pwa

    pwa -- "Faz requisições\n[HTTPS / JSON]" --> api
    api -- "Lê e escreve dados\n[SQL / TCP]" --> db

    pwa -- "Autentica usuário\n[HTTPS]" --> firebaseauth
    api -- "Valida Token JWT\n[Firebase Admin SDK]" --> firebaseauth
    api -- "Dispara eventos\n[HTTPS]" --> fcm
    fcm -- "Envia alerta\npush" --> pwa
