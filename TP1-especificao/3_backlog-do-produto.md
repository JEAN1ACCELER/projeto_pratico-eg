# 3. BACKLOG DO PRODUTO

## 1. INTRODUÇÃO E IMPORTÂNCIA DO BACKLOG

Esta seção apresenta o Backlog do Produto, estruturado em formato de Histórias de Usuário (User Stories). O backlog atua como a única fonte de verdade sobre as funcionalidades e requisitos que o E-Project deve entregar para agregar valor aos seus diferentes perfis de usuários (Alunos, Professores Orientadores e Administradores).

A estruturação correta deste documento é vital para o desenvolvimento do projeto, pois o backlog é o alicerce fundamental para a definição da Arquitetura do Software. A solução arquitetural proposta para o sistema, detalhada por meio do Modelo C4, deve ser justificada com base no backlog[cite: 1]. 

Isso afeta diretamente a validação do sistema através da rastreabilidade: a equipe deve ser capaz de demonstrar de forma clara e verificável como as decisões arquiteturais estão diretamente relacionadas às histórias do usuário[cite: 1]. Cada componente desenhado na arquitetura (como um dashboard administrativo no frontend, regras de permissão na camada de segurança, ou rotas específicas na API) precisa existir para satisfazer uma necessidade explícita descrita nesta tabela.

## 2. HISTÓRIAS DE USUÁRIO (USER STORIES)

O detalhamento completo (Critérios de Aceitação e Regras de Negócio) das histórias principais encontra-se no Quadro do GitHub Projects.

| ID | História de Usuário | Persona(s) | Prioridade | Assignee |
|:---|:---|:---|:---|:---|
| US-01 | Enquanto usuário do E-Project, desejo realizar login com minha matrícula e senha institucional, para acessar meus projetos e funcionalidades de acordo com meu perfil. | Victor Antunes, Ana Beatriz, Carlos Mendonça | Alta | Ricky Brendon |
| US-02 | Enquanto professor orientador, desejo visualizar um dashboard com todos os meus projetos ativos, para ter uma visão consolidada do andamento de cada um sem precisar acessar múltiplos sistemas. | Victor Antunes | Alta | Jean Carlos |
| US-03 | Enquanto professor orientador, desejo cadastrar um novo projeto escolhendo sua modalidade (PIBIC, PACE, PIBEX etc.), para iniciar o acompanhamento sem precisar configurar campos do zero. | Victor Antunes | Alta | Jean Carlos |
| US-04 | Enquanto professor orientador, desejo criar tarefas e atribuí-las aos meus orientandos com prazo definido, para organizar as demandas de cada projeto de forma clara e rastreável. | Victor Antunes | Alta | Ricky Brendon |
| US-05 | Enquanto professor orientador, desejo visualizar um feed centralizado com os editais abertos das pró-reitorias da UFAM, para não precisar acessar múltiplos sites diariamente para encontrar oportunidades. | Victor Antunes | Alta | Gustavo Souza |
| US-06 | Enquanto professor orientador, desejo revisar as entregas dos meus orientandos e fornecer feedback de aprovação ou solicitação de correção, para que o aluno saiba exatamente o que precisa ajustar. | Victor Antunes | Alta | Gustavo Souza |
| US-07 | Enquanto usuário do E-Project, desejo gerar automaticamente documentos oficiais (relatório parcial, declaração de bolsista), para economizar tempo e evitar erros de preenchimento manual. | Victor Antunes, Ana Beatriz | Média | Gustavo Souza |
| US-08 | Enquanto professor orientador, desejo acessar o histórico de projetos já encerrados, para consultar documentos, tarefas e entregas anteriores quando necessário. | Victor Antunes | Média | Ricky Brendon |
| US-09 | Enquanto professor orientador, desejo visualizar o controle de presença dos meus orientandos nas reuniões de projeto, para monitorar o engajamento de cada aluno ao longo do período. | Victor Antunes, Ana Beatriz | Média | Jean Carlos |
| US-10 | Enquanto aluna orientanda, desejo visualizar todas as tarefas pendentes que foram atribuídas a mim, para saber exatamente o que preciso entregar e em qual prazo. | Ana Beatriz | Alta | Jean Carlos |
| US-11 | Enquanto aluna orientanda, desejo submeter o arquivo solicitado em uma tarefa e receber confirmação do envio, para ter certeza de que o orientador recebeu minha entrega. | Ana Beatriz | Alta | Jean Carlos |
| US-12 | Enquanto aluna orientanda, desejo receber uma notificação no meu celular quando o orientador atribuir uma nova tarefa, para não precisar verificar o aplicativo constantemente. | Ana Beatriz | Alta | Gustavo Souza |
| US-13 | Enquanto aluna orientanda, desejo realizar meu check-in de presença em reuniões de projeto pelo aplicativo, para registrar minha participação sem depender de listas de papel. | Ana Beatriz | Média | Ricky Brendon |
| US-14 | Enquanto aluna orientanda, desejo visualizar o feedback deixado pelo orientador nas minhas entregas, para entender o que precisa ser corrigido ou melhorado. | Ana Beatriz | Alta | Gustavo Souza |
| US-15 | Enquanto usuário de acessibilidade, desejo ajustar o tamanho da fonte e ativar o modo de alto contraste, para conseguir usar o sistema sem dificuldades visuais. | Carlos Mendonça | Alta | Ricky Brendon |
| US-16 | Enquanto usuário de acessibilidade, desejo que todos os botões e menus tenham rótulos textuais visíveis (além de ícones), para navegar no sistema sem precisar adivinhar o significado de cada elemento. | Carlos Mendonça | Média | Jean Carlos |
| US-17 | Enquanto usuário de acessibilidade, desejo ativar um modo de interface simplificado que remova elementos decorativos e banners, para me concentrar apenas na tarefa que estou executando. | Carlos Mendonça, Ana Beatriz | Baixa | Ricky Brendon |
| US-18 | Enquanto administrador do sistema, desejo gerenciar o status das contas de usuários (ativar, inativar, alterar níveis de acesso), para garantir que apenas pessoas autorizadas da comunidade acadêmica utilizem a plataforma com as permissões corretas. | Carlos Mendonça | Alta | Jean Carlos |
| US-19 | Enquanto administrador do sistema, desejo cadastrar, editar e encerrar editais das pró-reitorias (PIBIC, PACE, PIBEX, etc.), para que eles fiquem disponíveis no feed de oportunidades dos professores de forma centralizada. | Carlos Mendonça | Alta | Luzinéia Rebelo |
| US-20 | Enquanto administrador do sistema, desejo visualizar um dashboard administrativo com métricas consolidadas (quantidade de projetos ativos e total de usuários), para monitorar o engajamento e o uso global da plataforma. | Carlos Mendonça | Média | Pedro Jhevison |
| US-21 | Enquanto administrador do sistema, desejo consultar um histórico básico (logs) de acessos e ações críticas, para auditar eventuais problemas técnicos e garantir a segurança institucional dos dados. | Carlos Mendonça | Baixa | Jean Carlos |
