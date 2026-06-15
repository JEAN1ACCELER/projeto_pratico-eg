<div align="center">

# Rastreabilidade de Requisitos e Fluxos

**E-Project** · C4 Model · Documentação de Arquitetura

---

![UFAM](https://img.shields.io/badge/ICET--UFAM-Engenharia%20de%20Software%20I-00663C?style=for-the-badge)
![Rastreabilidade](https://img.shields.io/badge/Documento-Rastreabilidade-1168BD?style=for-the-badge)
![Sprint](https://img.shields.io/badge/Status-SPRINT%201-blue?style=for-the-badge)

</div>

---

## 7.1 Visão Geral

A **Rastreabilidade** é o mecanismo que permite ligar os requisitos do sistema às decisões arquiteturais e de implementação. Este documento demonstra de forma clara e verificável como as decisões arquiteturais detalhadas nos níveis anteriores estão diretamente relacionadas às histórias de usuário definidas no backlog do TP1.

---

## 7.2 Matriz de Rastreabilidade Simplificada

A tabela abaixo mapeia os fluxos gerais da aplicação com os respectivos componentes arquiteturais mapeados no diagrama de Nível 3.

| ID | Cenário / Requisito | Persona | Componentes / Módulos Acionados | Persistência / Integração |
| :--- | :--- | :--- | :--- | :--- |
| F01 | Cadastrar projeto (US-03) | Professor | Comp. de Projetos, Comp. Autenticação | Banco de Dados |
| F02 | Criar e atribuir tarefas (US-04) | Professor | Comp. de Tarefas, Comp. Projetos | Banco de Dados |
| F03 | Submeter entrega com arquivo (US-11) | Aluno | Comp. de Tarefas, Comp. Documentos | Banco de Dados, Armazenamento (Railway) |
| F04 | Check-in em reunião (US-13) | Aluno | Comp. de Presença | Banco de Dados |
| F05 | Alerta de nova tarefa (US-12) | Sistema | Comp. de Tarefas, Comp. Notificações | Push (Firebase FCM) |
| F06 | Consulta automática de editais (US-05) | Sistema | Comp. de Feed de Editais | Portais UFAM, Banco de Dados |
| F07 | Geração de relatório PDF (US-07) | Professor | Comp. de Documentos | Banco de Dados, Serviço PDF (PDFKit) |
| F08 | Gestão de status de usuários (US-18) | Admin | Comp. de Usuários, Comp. Autenticação | Banco de Dados, Firebase Auth |

---

## 7.3 Rastreabilidade Detalhada com Histórias do Usuário

Abaixo, detalhamos o fluxo arquitetural de três das principais histórias de usuário do sistema, com destaque visual e passo a passo, conforme especificação técnica.

### 7.3.1 Gestão de Tarefas (US-04)

**Extrato da História do Usuário:**
> "US-04: Enquanto professor orientador, desejo criar tarefas e atribuí-las aos meus orientandos com prazo definido, para organizar as demandas de cada projeto de forma clara e rastreável."

**Evidência no Modelo C4:**
A história pode ser identificada nos seguintes diagramas:
* **Diagrama de Containers:** Comunicação entre a Aplicação Web (PWA), a API RESTful e o Banco de Dados.
* **Diagrama de Componentes:** Fluxo interno envolvendo o Componente de Tarefas e a Camada de Repositórios.

**Destaque no Diagrama (Fluxo Visual):**
```mermaid
flowchart LR
    PWA["Aplicação Web (PWA)"] -->|1. Envia Dados| AUTH["Comp. de Autenticação"]
    AUTH -->|2. Encaminha autorizada| TAREFA["Componente de Tarefas"]
    TAREFA -->|3. Processa regra| REPO["Camada de Repositórios"]
    REPO -->|4. Persiste dados| DB[("Banco de Dados (PostgreSQL)")]
    
    style TAREFA fill:#1168BD,stroke:#fff,stroke-width:2px,color:#fff
    style REPO fill:#1168BD,stroke:#fff,stroke-width:2px,color:#fff
