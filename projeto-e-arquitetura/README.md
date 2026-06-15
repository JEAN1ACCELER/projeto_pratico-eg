<div align="center">

# Documentação de Arquitetura — E-Project

**Engenharia de Software I** · UFAM · ICET · Itacoatiara

---

![UFAM](https://img.shields.io/badge/ICET--UFAM-Engenharia%20de%20Software%20I-00663C?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-FINALIZADO-brightgreen?style=for-the-badge)
![Arquitetura](https://img.shields.io/badge/Modelo-C4-1168BD?style=for-the-badge)

</div>

---

## 📖 Visão Geral

Esta pasta contém o detalhamento da **Arquitetura de Software do E-Project**, desenvolvida seguindo o modelo **C4** para representar o sistema em diferentes níveis de granularidade. Esta documentação serve como base técnica para a implementação do sistema e atende aos requisitos do Trabalho Prático II da disciplina de Engenharia de Software I.

---

##  Estrutura de Documentos

A documentação está organizada de forma hierárquica, facilitando a compreensão desde os padrões arquiteturais até a rastreabilidade com as histórias de usuário:

| Arquivo | Descrição |
| :--- | :--- |
| `1-padroes-arquiteturais.md` | Definição do padrão **Layered/MVC** e justificativa técnica. |
| `2-tech-stack.md` | Mapa visual e tabela detalhada das tecnologias (**Tech Stack**). |
| `3-c4-contexto.md` | Diagrama de Nível 1: Visão geral do sistema e seus atores. |
| `4-c4-containers.md` | Diagrama de Nível 2: Blocos de execução e tecnologias. |
| `5-c4-componentes.md` | Diagrama de Nível 3: Módulos internos da API Backend. |
| `6-c4-codigo.md` | Diagrama de Nível 4: Estrutura interna de classes (UML). |
| `7-rastreabilidade.md` | Mapeamento entre histórias de usuário e a arquitetura. |

---

##  Tecnologias Principais

O E-Project utiliza uma *stack* moderna baseada em **JavaScript Full-Stack**:

* **Frontend:** React (PWA), Tailwind CSS, Recharts.
* **Backend:** Node.js, Express, TypeScript.
* **Banco de Dados:** PostgreSQL via Prisma ORM.
* **Infraestrutura:** Vercel (Frontend), Railway (Backend/BD).
* **Serviços Firebase:** Authentication (Auth) e Cloud Messaging (Notificações Push).

---

##  Informações Importantes

>  **Integridade da Documentação:**
> Todos os diagramas presentes nestes documentos foram modelados com base no backlog do TP1. As referências cruzadas no documento `7-rastreabilidade.md` garantem a consistência entre o que foi planejado (TP1) e o que foi arquitetado (TP2).

---

<div align="center">

**Equipe de Desenvolvimento — E-Project**
*Jean Carlos, Gustavo Souza, Ricky Brendon, Luzinéia Rebelo, Pedro Jhevison*

**Universidade Federal do Amazonas — ICET | 2026**

</div>
