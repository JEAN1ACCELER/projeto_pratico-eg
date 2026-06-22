<div align="center">

# 7. Rastreabilidade de Requisitos e Fluxos

**E-Project** · C4 Model · Documentação de Arquitetura

---

![UFAM](https://img.shields.io/badge/ICET--UFAM-Engenharia%20de%20Software%20I-00663C?style=for-the-badge)
![Rastreabilidade](https://img.shields.io/badge/Documento-Rastreabilidade-1168BD?style=for-the-badge)
![Sprint](https://img.shields.io/badge/Status-SPRINT%201-blue?style=for-the-badge)

</div>

---

## 7.1 Visão geral

A **Rastreabilidade** é o mecanismo que permite ligar os requisitos do sistema às decisões arquiteturais e de implementação. Este documento mapeia os principais cenários de uso (personas e histórias) aos fluxos de dados entre os containers e componentes do E-Project, garantindo que cada necessidade do usuário tenha uma contraparte técnica identificável.

---

## 7.2 Explicação geral

Para cada funcionalidade principal do sistema, foi identificado um **fluxo rastreável** que percorre as camadas do E-Project: desde a interface do usuário (PWA), passando pela API Backend, alcançando o banco de dados e, quando aplicável, integrando-se a sistemas externos.

Os fluxos foram numerados e associados às personas definidas no escopo do projeto:
- **Professor Victor Antunes** (orientador com múltiplos projetos);
- **Ana Beatriz** (aluna orientanda e bolsista);
- **Dr. Carlos Mendonça** (administrador institucional).

---

## 7.3 Matriz de Rastreabilidade

| ID | Cenário / Requisito | Persona | Containers Envolvidos | Componentes / Módulos |
| :--- | :--- | :--- | :--- | :--- |
| F01 | Criar novo projeto de pesquisa/extensão | Professor | PWA → API → DB | Componente de Projetos, Componente de Autenticação |
| F02 | Definir cronograma e tarefas | Professor | PWA → API → DB | Componente de Tarefas, Componente de Projetos |
| F03 | Aluno visualiza tarefas e prazos | Aluno | PWA → API → DB | Componente de Tarefas |
| F04 | Aluno anexa relatório/entrega | Aluno | PWA → API → DB + Storage | Componente de Tarefas, Armazenamento de Arquivos |
| F05 | Professor avalia entrega e dá feedback | Professor | PWA → API → DB | Componente de Tarefas |
| F06 | Professor agenda reunião de orientação | Professor | PWA → API → DB | Componente de Presença, Componente de Projetos |
| F07 | Aluno confirma presença em reunião | Aluno | PWA → API → DB | Componente de Presença |
| F08 | Sistema alerta sobre prazo próximo | Sistema | Jobs → API → Notificação | Componente de Notificações, Firebase Cloud Messaging |
| F09 | Consulta automática de editais | Sistema | Jobs → Portais UFAM | Componente de Feed de Editais |
| F10 | Professor gera relatório final | Professor | PWA → API → DB + Storage | Componente de Documentos, Serviço de PDF (PDFKit) |
| F11 | Administrador cadastra modalidade | Admin | PWA → API → DB | Componente de Usuários, Componente de Feed de Editais |

---

## 7.4 Diagramas de Sequência por Fluxo

### Fluxo F01 — Criação de Projeto (Professor)
```mermaid
sequenceDiagram
    actor P as Professor
    participant W as Web App (PWA)
    participant A as API Backend
    participant D as Banco de Dados

    P->>W: Preenche formulário do projeto
    W->>A: POST /projetos (JSON)
    A->>A: Valida regras de negócio
    A->>D: INSERT INTO projetos
    D-->>A: Confirmação
    A-->>W: 201 Created (projeto)
    W-->>P: Exibe confirmação e dashboard
