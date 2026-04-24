# Backlog do Produto — E-Project

**Disciplina:** Engenharia de Software I — ICET/UFAM  
**Sistema:** E-Project — Gestão de Projetos Acadêmicos UFAM

> O backlog completo está organizado no GitHub Projects (quadro "Backlog do Produto").  
> Este documento registra as histórias de usuário com seus critérios de aceitação e regras de negócio.

---

## Padrão de Escrita

Todas as histórias seguem o formato:

> **Enquanto** [tipo de usuário], **desejo** [funcionalidade], **para** [benefício/objetivo].

**Prioridades:** Alta 🔴 | Média 🟡 | Baixa 🟢

---

## Histórias de Usuário Especificadas

---

### US01 — Login no sistema
**Prioridade:** 🔴 Alta  
**Persona:** Victor Antunes, Ana Beatriz, Carlos Mendonça

> Enquanto usuário do E-Project, desejo realizar login com minha matrícula e senha institucional, para acessar meus projetos e funcionalidades de acordo com meu perfil.

**Critérios de Aceitação:**
- [ ] O sistema deve exibir campos de matrícula/e-mail e senha na tela de login.
- [ ] Ao inserir credenciais válidas, o usuário deve ser redirecionado para o Dashboard correspondente ao seu perfil (orientador ou orientando).
- [ ] Ao inserir credenciais inválidas, o sistema deve exibir uma mensagem de erro clara ("Credenciais inválidas. Tente novamente.").
- [ ] O sistema deve oferecer a opção "Esqueci minha senha" com fluxo de recuperação via e-mail institucional.
- [ ] A sessão deve ser mantida por, no mínimo, 8 horas se o usuário selecionar "Manter conectado".

**Regras de Negócio:**
- Apenas usuários com matrícula ativa na UFAM podem realizar login.
- O perfil (orientador ou orientando) é determinado automaticamente com base no vínculo institucional.

---

### US02 — Visualizar dashboard central
**Prioridade:** 🔴 Alta  
**Persona:** Victor Antunes

> Enquanto professor orientador, desejo visualizar um dashboard com todos os meus projetos ativos, para ter uma visão consolidada do andamento de cada um sem precisar acessar múltiplos sistemas.

**Critérios de Aceitação:**
- [ ] O dashboard deve exibir todos os projetos ativos do orientador organizados por modalidade (PIBIC, PACE, PIBEX, Mestrado etc.).
- [ ] Cada card de projeto deve mostrar: nome do projeto, modalidade, aluno(s) vinculado(s), percentual de progresso e status atual.
- [ ] O orientador deve conseguir acessar um projeto específico clicando em seu card.
- [ ] Projetos com tarefas vencidas devem ser sinalizados visualmente (borda ou badge vermelho).
- [ ] O dashboard deve carregar em menos de 3 segundos em conexão de boa qualidade.

**Regras de Negócio:**
- Apenas projetos nos quais o usuário logado é o orientador responsável devem ser exibidos.
- Projetos encerrados não aparecem no dashboard padrão, mas podem ser acessados por um filtro "Histórico".

---

### US03 — Cadastrar novo projeto acadêmico
**Prioridade:** 🔴 Alta  
**Persona:** Victor Antunes

> Enquanto professor orientador, desejo cadastrar um novo projeto escolhendo sua modalidade (PIBIC, PACE, PIBEX etc.), para iniciar o acompanhamento sem precisar configurar campos do zero.

**Critérios de Aceitação:**
- [ ] O sistema deve oferecer uma lista de modalidades disponíveis (PIBIC, PIBITI, PIBEX, PASSE, Mestrado, Doutorado).
- [ ] Ao selecionar a modalidade, o formulário deve ser pré-preenchido com os campos padrão daquele tipo de projeto.
- [ ] Campos obrigatórios mínimos: título, modalidade, vigência (início/fim), resumo e orientador responsável.
- [ ] O orientador deve conseguir vincular um ou mais alunos ao projeto via busca por matrícula.
- [ ] Ao salvar, o projeto deve aparecer imediatamente no dashboard do orientador.

**Regras de Negócio:**
- Cada projeto deve ter pelo menos um aluno vinculado para ser ativado.
- A vigência do projeto deve ter data de início anterior ou igual à data de fim.

---

### US04 — Criar e atribuir tarefa a orientando
**Prioridade:** 🔴 Alta  
**Persona:** Victor Antunes

> Enquanto professor orientador, desejo criar tarefas e atribuí-las aos meus orientandos com prazo definido, para organizar as demandas de cada projeto de forma clara e rastreável.

**Critérios de Aceitação:**
- [ ] O orientador deve conseguir criar uma nova tarefa dentro de um projeto específico.
- [ ] Os campos da tarefa devem incluir: título, descrição, prazo, aluno responsável e, opcionalmente, anexo.
- [ ] Ao salvar a tarefa, o aluno vinculado deve receber uma notificação imediata.
- [ ] A tarefa deve aparecer na lista de pendências do aluno com status "Pendente".
- [ ] O orientador deve conseguir visualizar todas as tarefas de um projeto com seus respectivos status.

**Regras de Negócio:**
- Tarefas só podem ser criadas em projetos ativos.
- O prazo não pode ser uma data anterior ao dia da criação da tarefa.

---

### US05 — Visualizar e filtrar editais no feed unificado
**Prioridade:** 🔴 Alta  
**Persona:** Victor Antunes

> Enquanto professor orientador, desejo visualizar um feed centralizado com os editais abertos das pró-reitorias da UFAM, para não precisar acessar múltiplos sites diariamente para encontrar oportunidades.

**Critérios de Aceitação:**
- [ ] O feed deve exibir editais das principais pró-reitorias (PROPESP, PROEXT) com título, pró-reitoria de origem, prazo de inscrição e link direto.
- [ ] O usuário deve conseguir filtrar os editais por pró-reitoria e por status (Abertos / Encerrados).
- [ ] Cada edital deve ter um botão "Baixar PDF" que abre o documento original.
- [ ] O usuário deve conseguir "Favoritar" um edital para acesso rápido posterior.
- [ ] Novos editais publicados nas últimas 24h devem ser marcados com badge "Novo".

**Regras de Negócio:**
- Editais encerrados devem ser mantidos no feed por 30 dias após o vencimento, marcados como "Encerrado".

---

### US06 — Aprovar ou solicitar correção em entrega de aluno
**Prioridade:** 🔴 Alta  
**Persona:** Victor Antunes

> Enquanto professor orientador, desejo revisar as entregas dos meus orientandos e fornecer feedback de aprovação ou solicitação de correção, para que o aluno saiba exatamente o que precisa ajustar.

**Critérios de Aceitação:**
- [ ] O orientador deve receber uma notificação quando um aluno submeter uma tarefa.
- [ ] Na tela da tarefa, o orientador deve conseguir visualizar o arquivo enviado e o histórico de versões.
- [ ] O orientador deve ter dois botões de ação: "Aprovar" e "Solicitar Correção".
- [ ] Ao clicar em "Solicitar Correção", um campo de comentário obrigatório deve ser exibido.
- [ ] O aluno deve ser notificado imediatamente após qualquer ação do orientador, com acesso ao feedback.

**Regras de Negócio:**
- Só o orientador responsável pelo projeto pode aprovar ou solicitar correção das tarefas.
- O comentário de correção é obrigatório e deve ter no mínimo 10 caracteres.

---

### US07 — Gerar documento oficial automaticamente
**Prioridade:** 🟡 Média  
**Persona:** Victor Antunes, Ana Beatriz

> Enquanto usuário do E-Project, desejo gerar automaticamente documentos oficiais (relatório parcial, declaração de bolsista), para economizar tempo e evitar erros de preenchimento manual.

**Critérios de Aceitação:**
- [ ] O sistema deve oferecer ao menos dois modelos de documento: "Relatório Parcial de Atividades" e "Declaração de Bolsista".
- [ ] Os campos do cabeçalho (nome do projeto, orientador, aluno, vigência, modalidade) devem ser preenchidos automaticamente com dados do projeto cadastrado.
- [ ] O usuário deve conseguir pré-visualizar o documento antes do download.
- [ ] O documento final deve ser exportado em formato PDF.

**Regras de Negócio:**
- O documento só pode ser gerado para projetos com status "Ativo".
- O conteúdo específico (atividades realizadas, resultados) deve ser preenchido pelo usuário antes da exportação.

---

### US08 — Consultar histórico de projetos encerrados
**Prioridade:** 🟡 Média  
**Persona:** Victor Antunes

> Enquanto professor orientador, desejo acessar o histórico de projetos já encerrados, para consultar documentos, tarefas e entregas anteriores quando necessário.

**Critérios de Aceitação:**
- [ ] O orientador deve conseguir acessar projetos encerrados por meio de um filtro ou aba "Histórico" no dashboard.
- [ ] Os projetos no histórico devem exibir todas as tarefas, entregas e documentos gerados durante sua vigência.
- [ ] O histórico deve ser somente leitura — nenhuma nova tarefa pode ser criada em projetos encerrados.
- [ ] Deve ser possível buscar projetos no histórico por nome, modalidade e ano.

**Regras de Negócio:**
- Um projeto é movido automaticamente para o histórico após sua data de fim ser atingida.
- O orientador pode encerrar manualmente um projeto antes do prazo se necessário.

---

### US09 — Registrar e acompanhar controle de presença
**Prioridade:** 🟡 Média  
**Persona:** Victor Antunes, Ana Beatriz

> Enquanto professor orientador, desejo visualizar o controle de presença dos meus orientandos nas reuniões de projeto, para monitorar o engajamento de cada aluno ao longo do período.

**Critérios de Aceitação:**
- [ ] O orientador deve conseguir criar eventos de reunião vinculados a um projeto.
- [ ] O aluno deve conseguir realizar check-in no evento a partir do aplicativo.
- [ ] O orientador deve conseguir visualizar a lista de presença de cada evento com status por aluno (Presente / Ausente).
- [ ] Deve haver um resumo percentual de presença por aluno no projeto.

**Regras de Negócio:**
- O check-in do aluno deve ser realizado no mesmo dia do evento para ser computado como presença.

---

### US10 — Visualizar tarefas pendentes
**Prioridade:** 🔴 Alta  
**Persona:** Ana Beatriz

> Enquanto aluna orientanda, desejo visualizar todas as tarefas pendentes que foram atribuídas a mim, para saber exatamente o que preciso entregar e em qual prazo.

**Critérios de Aceitação:**
- [ ] A tela inicial do aluno deve exibir uma lista de tarefas pendentes ordenadas por prazo (mais urgente primeiro).
- [ ] Cada tarefa deve mostrar: título, projeto relacionado, prazo e status ("Pendente", "Em revisão", "Aprovado", "Requer correção").
- [ ] Tarefas com prazo próximo (menos de 3 dias) devem ter destaque visual (borda ou badge vermelho).
- [ ] O aluno deve conseguir acessar os detalhes e instruções de cada tarefa com um toque.

---

### US11 — Submeter arquivo em uma tarefa
**Prioridade:** 🔴 Alta  
**Persona:** Ana Beatriz

> Enquanto aluna orientanda, desejo submeter o arquivo solicitado em uma tarefa e receber confirmação do envio, para ter certeza de que o orientador recebeu minha entrega.

**Critérios de Aceitação:**
- [ ] O aluno deve conseguir anexar um arquivo (PDF ou DOCX, máx. 10MB) à tarefa.
- [ ] Após o upload, o sistema deve exibir uma confirmação visual clara ("Enviado com Sucesso! Seu orientador foi notificado.").
- [ ] Em caso de falha no upload, o sistema deve exibir mensagem de erro e oferecer a opção "Tentar Novamente".
- [ ] O aluno deve conseguir incluir uma mensagem opcional junto ao envio.
- [ ] O status da tarefa deve mudar automaticamente para "Em revisão" após o envio.

**Regras de Negócio:**
- Formatos aceitos: PDF e DOCX. Tamanho máximo: 10MB.
- O aluno pode enviar uma nova versão do arquivo enquanto o status for "Requer Correção".

---

### US12 — Receber notificação de nova tarefa
**Prioridade:** 🔴 Alta  
**Persona:** Ana Beatriz

> Enquanto aluna orientanda, desejo receber uma notificação no meu celular quando o orientador atribuir uma nova tarefa, para não precisar verificar o aplicativo constantemente.

**Critérios de Aceitação:**
- [ ] O sistema deve enviar uma notificação push ao aluno imediatamente após a criação de uma nova tarefa.
- [ ] A notificação deve conter: nome da tarefa, nome do projeto e prazo de entrega.
- [ ] Ao tocar na notificação, o aluno deve ser direcionado diretamente para a tela de detalhes da tarefa.
- [ ] O aluno deve conseguir configurar as preferências de notificação (ativar/desativar).

---

### US13 — Realizar check-in de presença
**Prioridade:** 🟡 Média  
**Persona:** Ana Beatriz

> Enquanto aluna orientanda, desejo realizar meu check-in de presença em reuniões de projeto pelo aplicativo, para registrar minha participação sem depender de listas de papel.

**Critérios de Aceitação:**
- [ ] O aluno deve visualizar os eventos de reunião disponíveis para check-in no dia atual.
- [ ] O sistema deve confirmar o check-in e exibir mensagem de sucesso.
- [ ] O aluno deve conseguir consultar seu histórico de presenças no projeto.

---

### US14 — Consultar feedback do orientador
**Prioridade:** 🔴 Alta  
**Persona:** Ana Beatriz

> Enquanto aluna orientanda, desejo visualizar o feedback deixado pelo orientador nas minhas entregas, para entender o que precisa ser corrigido ou melhorado.

**Critérios de Aceitação:**
- [ ] O aluno deve receber notificação quando o orientador aprovar ou solicitar correção em uma entrega.
- [ ] Na tela da tarefa, o comentário do orientador deve estar visível com destaque.
- [ ] O histórico de feedbacks de todas as versões entregues deve ser acessível na mesma tela.
- [ ] Caso a tarefa esteja com status "Requer Correção", um botão "Reenviar" deve estar disponível.

---

### US15 — Ajustar tamanho de fonte e contraste
**Prioridade:** 🟡 Média  
**Persona:** Carlos Mendonça

> Enquanto professor com baixa visão, desejo ajustar o tamanho da fonte e ativar o modo de alto contraste, para conseguir usar o sistema sem dificuldades visuais.

**Critérios de Aceitação:**
- [ ] O painel de acessibilidade deve estar acessível a partir de todas as telas por meio de ícone fixo.
- [ ] O usuário deve conseguir aumentar o tamanho da fonte em pelo menos 3 níveis (Padrão, Grande, Extra Grande).
- [ ] Deve haver opções de tema: Padrão, Alto Contraste e Modo Escuro.
- [ ] As alterações devem ser aplicadas imediatamente e persistidas entre sessões.

---

### US16 — Navegar com botões rotulados e layout linear
**Prioridade:** 🟡 Média  
**Persona:** Carlos Mendonça

> Enquanto professor com dificuldade visual, desejo que todos os botões e menus tenham rótulos textuais visíveis (além de ícones), para navegar no sistema sem precisar adivinhar o significado de cada elemento.

**Critérios de Aceitação:**
- [ ] Nenhum elemento interativo deve depender exclusivamente de um ícone para comunicar sua função.
- [ ] Todo botão ou item de menu deve ter rótulo textual visível ao lado do ícone.
- [ ] O layout deve funcionar corretamente com zoom de até 200% no navegador sem perda de funcionalidade.

---

### US17 — Utilizar modo de foco sem distrações
**Prioridade:** 🟢 Baixa  
**Persona:** Carlos Mendonça, Ana Beatriz

> Enquanto usuário com necessidade de foco, desejo ativar um modo de interface simplificado que remova elementos decorativos e banners, para me concentrar apenas na tarefa que estou executando.

**Critérios de Aceitação:**
- [ ] O modo de foco deve poder ser ativado/desativado no painel de acessibilidade.
- [ ] Ao ativar, elementos decorativos, banners e notificações visuais secundárias devem ser ocultados.
- [ ] O conteúdo principal (tarefa atual, formulário etc.) deve permanecer centralizado e com maior espaçamento.

---

## Resumo do Backlog

| ID | História | Prioridade | Status | Persona |
|---|---|---|---|---|
| US01 | Login no sistema | 🔴 Alta | Especificada | Todos |
| US02 | Visualizar dashboard central | 🔴 Alta | Especificada | Victor |
| US03 | Cadastrar novo projeto | 🔴 Alta | Especificada | Victor |
| US04 | Criar e atribuir tarefa | 🔴 Alta | Especificada | Victor |
| US05 | Feed unificado de editais | 🔴 Alta | Especificada | Victor |
| US06 | Aprovar / solicitar correção | 🔴 Alta | Especificada | Victor |
| US07 | Gerar documento oficial | 🟡 Média | Especificada | Victor, Ana |
| US08 | Histórico de projetos | 🟡 Média | Especificada | Victor |
| US09 | Controle de presença (orientador) | 🟡 Média | Especificada | Victor, Ana |
| US10 | Visualizar tarefas pendentes | 🔴 Alta | Especificada | Ana |
| US11 | Submeter arquivo em tarefa | 🔴 Alta | Especificada | Ana |
| US12 | Receber notificação de tarefa | 🔴 Alta | Especificada | Ana |
| US13 | Check-in de presença | 🟡 Média | Especificada | Ana |
| US14 | Consultar feedback do orientador | 🔴 Alta | Especificada | Ana |
| US15 | Ajustar fonte e contraste | 🟡 Média | Especificada | Carlos |
| US16 | Botões rotulados e layout linear | 🟡 Média | Especificada | Carlos |
| US17 | Modo de foco sem distrações | 🟢 Baixa | No Backlog | Carlos, Ana |
