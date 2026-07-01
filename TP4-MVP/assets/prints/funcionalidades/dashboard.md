# Rastreabilidade Visual das Telas

## E-Project — Gestão de Projetos UFAM
### TP4-MVP — Engenharia de Software I

Este documento reúne os prints das principais telas do MVP do E-Project, associando cada uma às histórias de usuário (US) do Backlog do Produto que ela implementa, conforme exigido pelo requisito de rastreabilidade do Trabalho Prático IV.

---

## 1. Tela de Login

 <img width="1080" height="2192" alt="WhatsApp Image 2026-07-01 at 02 45 18" src="https://github.com/user-attachments/assets/85e1d1c0-858e-4297-b1e7-d4626da2a90d" /> 

**Descrição:**
Tela de entrada do aplicativo, com campos de E-mail Institucional e Senha, botão "Entrar" e link para quem ainda não possui conta ("Registrar"). Aplica a identidade visual do E-Project (logo e paleta verde institucional).

**Histórias de usuário atendidas:**
* **US-01:** Enquanto usuário do E-Project, desejo realizar login com minha matrícula e senha institucional, para acessar meus projetos e funcionalidades de acordo com meu perfil.

---

## 2. Tela de Cadastro de Usuário

> <img width="788" height="1600" alt="WhatsApp Image 2026-07-01 at 02 45 19" src="https://github.com/user-attachments/assets/5048a304-681c-420a-ad67-2993c8e75178" />


**Descrição:**
Formulário de criação de conta com Nome Completo, E-mail Institucional e Senha, além da seleção de perfil (Estudante ou Orientador), que define os acessos e telas exibidas posteriormente ao usuário.

**Histórias de usuário atendidas:**
* **US-01:** (suporte) Base para o login institucional — cria a conta que será usada para autenticação.

---

## 3. Dashboard do Orientador

> <img width="788" height="1600" alt="WhatsApp Image 2026-07-01 at 02 45 20" src="https://github.com/user-attachments/assets/fc60d1c2-8648-4ebe-94da-5cdef9a7048c" />


**Descrição:**
Tela inicial pós-login do orientador: contadores por modalidade (PIBIC, PACE, Mestrado), alerta de "Próximo Prazo" com ação rápida "Gerar Documento", lista de "Meus Projetos Ativos" com barra de progresso, e seção "Editais em Destaque". Navegação inferior fixa (Dashboard, Projetos, Editais, Perfil).

**Histórias de usuário atendidas:**
* **US-02:** Enquanto professor orientador, desejo visualizar um dashboard com todos os meus projetos ativos, para ter uma visão consolidada do andamento de cada um sem precisar acessar múltiplos sistemas.
* **US-05:** Enquanto professor orientador, desejo visualizar um feed centralizado com os editais abertos das pró-reitorias da UFAM, para não precisar acessar múltiplos sites diariamente.
* **US-07:** Enquanto usuário do E-Project, desejo gerar automaticamente documentos oficiais (relatório parcial, declaração de bolsista), para economizar tempo e evitar erros de preenchimento manual.

---

## 4. Detalhes do Projeto — Sistema de Monitoramento IOT

> <img width="788" height="1600" alt="WhatsApp Image 2026-07-01 at 02 45 20 (1)" src="https://github.com/user-attachments/assets/2d108e8a-4971-4ab6-8b93-fc6a9dab4ecf" />


**Descrição:**
Detalhe de um projeto PIBIC em andamento, com atalhos para gerar documentos (Relatório Parcial e Declaração) e a seção "Gestão de Tarefas", listando tarefas com status (ex.: "Revisão Bibliográfica" — APPROVED) e ações como "Enviar para Revisão".

**Histórias de usuário atendidas:**
* **US-04:** Enquanto professor orientador, desejo criar tarefas e atribuí-las aos meus orientandos com prazo definido, para organizar as demandas de cada projeto de forma clara e rastreável.
* **US-07:** Geração automática de documentos oficiais (Relatório Parcial, Declaração) a partir do projeto.

---

## 5. Detalhes do Projeto — Inclusão Digital Ribeirinha

> <img width="788" height="1600" alt="WhatsApp Image 2026-07-01 at 02 45 21" src="https://github.com/user-attachments/assets/8d368afb-d4eb-4c84-a95a-c0644122a0fe" />


**Descrição:**
Detalhe de um projeto PACE com status "Atrasado", exibindo uma tarefa em revisão ("Elaboração da Cartilha" — IN_REVIEW) com botão "Aprovar", demonstrando o fluxo de revisão e feedback do orientador sobre a entrega do aluno.

**Histórias de usuário atendidas:**
* **US-06:** Enquanto professor orientador, desejo revisar as entregas dos meus orientandos e fornecer feedback de aprovação ou solicitação de correção, para que o aluno saiba exatamente o que precisa ajustar.

---

## 6. Cadastro de Novo Projeto

> <img width="788" height="1600" alt="WhatsApp Image 2026-07-01 at 02 45 21 (1)" src="https://github.com/user-attachments/assets/3b5b2aa8-b8fa-49cc-8597-c2eb75b0d5ed" />


**Descrição:**
Modal "Novo Projeto" acionado pelo botão flutuante (+), com campos de Título, Descrição, Membros da Equipe e seleção do Tipo de Projeto (PIBIC, PACE, TCC), finalizado pelo botão "Adicionar Projeto".

**Histórias de usuário atendidas:**
* **US-03:** Enquanto professor orientador, desejo cadastrar um novo projeto escolhendo sua modalidade (PIBIC, PACE, PIBEX etc.), para iniciar o acompanhamento sem precisar configurar campos do zero.

---

## 7. Lista de Projetos Ativos

> <img width="788" height="1600" alt="WhatsApp Image 2026-07-01 at 02 45 21 (2)" src="https://github.com/user-attachments/assets/41d67c49-ce14-4d60-802f-a38ed06cf0fa" />

**Descrição:**
Listagem completa dos projetos do orientador (PIBIC, PACE, Mestrado), cada card exibindo modalidade, status (Em Andamento, Atrasado, Em Revisão), equipe responsável e barra de progresso — acessível pela aba "Projetos" da navegação inferior.

**Histórias de usuário atendidas:**
* **US-02:** Visão consolidada dos projetos ativos do orientador, complementando o dashboard com uma listagem detalhada.

---

## 8. Menu de Temas e Acessibilidade

> <img width="788" height="1600" alt="WhatsApp Image 2026-07-01 at 02 45 23" src="https://github.com/user-attachments/assets/ba97e7d4-82d4-4b29-9607-8114b949fad7" />

**Descrição:**
Menu acionado pelo ícone de paleta no cabeçalho, permitindo alternar entre os temas Sistema, Claro, Escuro e Alto Contraste, atendendo aos requisitos de acessibilidade do backlog.

**Histórias de usuário atendidas:**
* **US-15:** Enquanto usuário de acessibilidade, desejo ajustar o tamanho da fonte e ativar o modo de alto contraste, para conseguir usar o sistema sem dificuldades visuais.
