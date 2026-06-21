<div align="center">

# Casos de Teste — Classes de Equivalência

**E-Project** · TP3 Parte II · Engenharia de Software I

---

![UFAM](https://img.shields.io/badge/ICET--UFAM-Engenharia%20de%20Software%20I-00663C?style=for-the-badge)
![TP3](https://img.shields.io/badge/TP3-Parte%20II%20%E2%80%94%20Casos%20de%20Teste-7B2D8B?style=for-the-badge)
![Sprint](https://img.shields.io/badge/Status-SPRINT%201-blue?style=for-the-badge)

</div>

---

## Introdução

Este documento apresenta o planejamento dos casos de teste para cada história de usuário definida no backlog do produto do **E-Project**, utilizando a técnica de **Particionamento em Classes de Equivalência**.

Para cada US são produzidos três artefatos:
- **História do Usuário** com critérios de aceitação e regras de negócio associadas
- **Tabela de Classes de Equivalência** (Condição de Entrada | Classes Válidas | Classes Inválidas)
- **Tabela de Casos de Teste** (Caso | Classes de Equivalência | Entradas | Resultado Esperado)

> **Regra de ouro aplicada:** cada caso de teste inválido testa uma única classe inválida por vez, mantendo todas as demais condições válidas, evitando que valores errados mascarem mutuamente uns aos outros.

---

## US-01 — Login no sistema

**História do Usuário**: Enquanto Usuário, desejo realizar login no sistema, para acessar as funcionalidades conforme meu perfil.

**Critérios de Aceitação**
- O sistema deve permitir o login quando usuário e senha forem válidos.
- O sistema deve redirecionar o usuário autenticado para seu painel.
- O sistema deve exibir mensagem de erro quando o login não for realizado com sucesso.

**Regras de Negócio** — O sistema não deve permitir login que:
- Utilize usuário inexistente;
- Utilize senha incorreta;
- Seja realizado por usuário inativo;
- Possua campos obrigatórios vazios.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Usuário informado | Usuário cadastrado e preenchido (1) | Usuário inexistente (2) | Campo de usuário vazio (3) |
| Senha informada | Senha correta e preenchida (4) | Senha incorreta (5) | Campo de senha vazio (6) |
| Status da conta | Usuário ativo (7) | Usuário inativo (8) |  |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 7 | Usuário existente + senha correta + conta ativa | Login realizado com sucesso, redirecionado ao painel |
| Caso 2 | 2, 4, 7 | Usuário inexistente + senha correta + conta ativa | Login falha — usuário não encontrado |
| Caso 3 | 3, 4, 7 | Campo de usuário vazio + senha correta + conta ativa | Login falha — campo de usuário obrigatório |
| Caso 4 | 1, 5, 7 | Usuário existente + senha incorreta + conta ativa | Login falha — senha incorreta |
| Caso 5 | 1, 6, 7 | Usuário existente + campo de senha vazio + conta ativa | Login falha — campo de senha obrigatório |
| Caso 6 | 1, 4, 8 | Usuário existente + senha correta + conta inativa | Login falha — usuário inativo |

---

## US-02 — Visualizar painel central

**História do Usuário**:
Enquanto Orientador, desejo visualizar um painel central, para acompanhar os projetos sob minha responsabilidade.

**Critérios de Aceitação**
- O sistema deve exibir no painel apenas projetos específicos ao orientador autenticado.
- O painel deve apresentar informações básicas de status e progresso de cada projeto.
- O orientador deve conseguir acessar os detalhes de um projeto a partir do painel.

**Regras de Negócio** — O sistema não deve permitir que o painel:
- Exiba projetos que não estejam sob responsabilidade do orientador autenticado;
- Exiba projetos com status encerrado no painel principal;
- Permita acesso a projetos sem vínculo com o orientador autenticado.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Vínculo do projeto com o orientador | Projeto vinculado ao orientador autenticado (1) | Projeto vinculado a outro orientador (2) | Projeto inexistente ou removido (3) |
| Status do projeto | Projeto ativo/em andamento (4) | Projeto encerrado (5) | |
| Autenticação do usuário | Usuário autenticado como orientador (6) | Usuário não autenticado (7) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 6 | Orientador autenticado acessa projeto próprio e ativo | Painel exibe o projeto com status e progresso corretamente |
| Caso 2 | 2, 4, 6 | Orientador autenticado tenta acessar projeto de outro orientador | Acesso negado — projeto não pertence ao orientador autenticado |
| Caso 3 | 3, 4, 6 | Orientador autenticado tenta acessar projeto inexistente/removido | Erro — projeto não encontrado |
| Caso 4 | 1, 5, 6 | Orientador autenticado possui projeto com status encerrado | Projeto não aparece no painel principal |
| Caso 5 | 1, 4, 7 | Usuário não autenticado tenta acessar o painel | Acesso negado — autenticação obrigatória |

---

## US-03 — Cadastrar novo projeto acadêmico

**História do Usuário**:
Enquanto Orientador, desejo cadastrar um novo projeto acadêmico, para iniciar o acompanhamento das atividades acadêmicas com meus alunos

**Critérios de Aceitação**
- O sistema deve permitir o cadastro de um projeto com o preenchimento das informações obrigatórias.
- O sistema deve permitir salvar o projeto mesmo sem alunos vinculados.
- O sistema deve permitir a visualização do projeto após o cadastro.
- O projeto deve ser considerado ativo somente após a vinculação de pelo menos um aluno.

**Regras de Negócio** — O sistema não deve permitir que o projeto:
- Seja marcado como ativo quando não houver nenhum aluno vinculado;
- Seja cadastrado sem o preenchimento das informações obrigatórias;
- Tenha o status alterado manualmente para ativo sem que exista pelo menos um aluno vinculado.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Preenchimento das informações obrigatórias | Campos obrigatórios preenchidos corretamente (1) | Campos obrigatórios vazios/faltando (2) | Informações em formato inválido (ex: data de término anterior à data de início) (3) |
| Vinculação de alunos ao projeto | Projeto com pelo menos 1 aluno vinculado (4) | Projeto sem nenhum aluno vinculado (5) | |
| Alteração manual de status | Status definido automaticamente pela regra de negócio (6) | Tentativa de marcar manualmente como "Ativo" sem aluno vinculado (7) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 6 | Campos obrigatórios válidos + 1 aluno vinculado | Projeto cadastrado e status definido automaticamente como "Ativo" |
| Caso 2 | 1, 5, 6 | Campos obrigatórios válidos + nenhum aluno vinculado | Projeto cadastrado e salvo com status "Rascunho" (não ativo) |
| Caso 3 | 2, 4, 6 | Campos obrigatórios vazios (ex: título não informado) | Cadastro rejeitado — informações obrigatórias pendentes |
| Caso 4 | 3, 4, 6 | Data de término anterior à data de início | Cadastro rejeitado — informações em formato/lógica inválida |
| Caso 5 | 1, 5, 7 | Projeto sem aluno vinculado + tentativa manual de definir status como "Ativo" | Sistema rejeita a alteração — status permanece "Rascunho" |

---

## US-04 — Criar e definir tarefa a orientar

**História do Usuário**:
Enquanto Orientador, desejo criar e definir tarefas para um projeto, para organizar e acompanhar as atividades a serem realizadas pelos alunos.

**Critérios de Aceitação**
- O sistema deve permitir a criação de uma tarefa vinculada a um projeto existente.
- O sistema deve permitir definir as informações básicas da tarefa, incluindo título, descrição e prazo final.
- O sistema deve permitir a visualização da tarefa criada no contexto do projeto ao qual está vinculada.
- A tarefa criada deve ficar associada exclusivamente ao projeto selecionado.

**Regras de Negócio (corrigidas)** — O sistema não deve permitir que a tarefa:
- Seja vinculada a um projeto inexistente;
- Seja criada em um projeto encerrado;
- Seja cadastrada sem título, descrição ou prazo final;
- Tenha prazo final anterior à data atual;
- Fique associada a mais de um projeto simultaneamente.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Vínculo com projeto | Projeto existente e ativo (1) | Projeto inexistente (2) | Projeto encerrado (3) |
| Preenchimento das informações da tarefa | Título, descrição e prazo preenchidos corretamente (4) | Campos obrigatórios vazios (5) | Prazo final anterior à data atual (6) |
| Associação da tarefa ao projeto | Tarefa associada a um único projeto (7) | Tentativa de associar a mais de um projeto (8) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 7 | Projeto existente e ativo + título/descrição/prazo válidos | Tarefa criada com sucesso e vinculada ao projeto |
| Caso 2 | 2, 4, 7 | Projeto inexistente + dados da tarefa válidos | Erro — projeto não encontrado |
| Caso 3 | 3, 4, 7 | Projeto encerrado + dados da tarefa válidos | Erro — não é possível criar tarefa em projeto encerrado |
| Caso 4 | 1, 5, 7 | Projeto válido + título ou descrição vazios | Erro — campos obrigatórios pendentes |
| Caso 5 | 1, 6, 7 | Projeto válido + prazo final anterior à data atual | Erro — prazo inválido |
| Caso 6 | 1, 4, 8 | Projeto válido + tentativa de vincular tarefa a 2 projetos | Sistema rejeita — tarefa deve pertencer a um único projeto |

---

## US-05 — Visualizar e filtrar editais no feed unificado

**História do Usuário**:
Enquanto Orientador, desejo visualizar e filtrar os editais disponíveis, para identificar oportunidades relevantes para meus projetos acadêmicos.

**Critérios de Aceitação**
- O sistema deve exibir uma lista de editais disponíveis para consulta.
- O sistema deve permitir aplicar filtros para refinar a visualização dos editais.
- O sistema deve permitir a visualização dos detalhes de um edital selecionado.
- O sistema deve atualizar a lista de editais conforme os filtros aplicados.

**Regras de Negócio** — O sistema não deve permitir que:
- Sejam definidos editais não cadastrados no sistema;
- Filtros retornem editais que não atendem aos critérios selecionados;
- Sejam listados editais com informações obrigatórias ausentes;
- O acesso aos detalhes seja realizado para um edital inexistente.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Existência/integridade do edital | Edital cadastrado e com informações completas (1) | Edital inexistente (2) | Edital com informações obrigatórias ausentes (3) |
| Aplicação de filtros | Filtro retorna editais que atendem aos critérios selecionados (4) | Filtro retorna editais que não atendem aos critérios selecionados (5) | |
| Origem do edital (escopo PROPESP/PROEXT) | Edital proveniente de fonte autorizada (PROPESP/PROEXT) (6) | Edital proveniente de fonte fora do escopo definido (7) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 6 | Edital existente e completo + filtro coerente + fonte PROPESP/PROEXT | Lista exibida corretamente, detalhes acessíveis |
| Caso 2 | 2, 4, 6 | Acesso aos detalhes de um edital inexistente | Erro — edital não encontrado |
| Caso 3 | 3, 4, 6 | Edital cadastrado sem informações obrigatórias (ex: sem data de encerramento) | Edital não deve ser listado / erro de exibição |
| Caso 4 | 1, 5, 6 | Filtro aplicado retorna editais que não atendem aos critérios selecionados | Erro — lista não corresponde ao filtro aplicado |
| Caso 5 | 1, 4, 7 | Edital proveniente de fonte fora do escopo (não PROPESP/PROEXT) | Edital não deve ser exibido no feed |

---

## US-06 — Avaliar tarefa submetida

**História do Usuário**:
Enquanto Orientador, desejo avaliar as tarefas impostas aos alunos, para acompanhar o progresso do projeto e garantir a qualidade das entregas.

**Critérios de Aceitação**
- O sistema deve permitir que o orientador visualize as tarefas submetidas pelos alunos.
- O sistema deve permitir que o orientador avalie uma tarefa designada.
- O sistema deve permitir que o orientador aprove uma tarefa ou solicite correção.
- O sistema deve registrar o status final da avaliação da tarefa.

**Regras de Negócio** — O sistema não deve permitir que a tarefa:
- Seja avaliada por usuários que não sejam orientadores;
- Seja avaliada sem que tenha sido previamente submetida pelo aluno;
- Tenha mais de um status final simultaneamente;
- Seja avaliada novamente sem que o aluno realize uma nova submissão após avaliação anterior.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Perfil do usuário avaliador | Usuário é o orientador responsável pelo projeto (1) | Usuário não é orientador / não autorizado (2) | |
| Estado de submissão da tarefa | Tarefa submetida pelo aluno e pendente de avaliação (3) | Tarefa ainda não submetida pelo aluno (4) | Tarefa já avaliada anteriormente, sem nova submissão (5) |
| Status final da avaliação | Status único definido (Aprovada OU Correção Solicitada) (6) | Tentativa de definir mais de um status simultaneamente (7) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 3, 6 | Orientador avalia tarefa submetida, define status único (ex: Aprovada) | Avaliação registrada com sucesso |
| Caso 2 | 2, 3, 6 | Usuário não orientador tenta avaliar a tarefa | Acesso negado — usuário não autorizado |
| Caso 3 | 1, 4, 6 | Orientador tenta avaliar tarefa que o aluno ainda não submeteu | Erro — tarefa não submetida |
| Caso 4 | 1, 5, 6 | Orientador tenta reavaliar tarefa já avaliada, sem nova submissão do aluno | Erro — necessária nova submissão antes de reavaliar |
| Caso 5 | 1, 3, 7 | Orientador tenta definir simultaneamente "Aprovada" e "Correção Solicitada" | Sistema rejeita — apenas um status final permitido |

---

## US-07 — Reenviar tarefa para correção

**História do Usuário**:
Enquanto Aluno, desejo reenviar uma tarefa após solicitação de correção, para atender às configurações solicitadas pelo orientador e concluir a atividade.

**Critérios de Aceitação**
- O sistema deve permitir que o aluno visualize as tarefas com correção solicitada.
- O sistema deve permitir que o aluno realize um novo envio da tarefa corrigida.
- O sistema deve atualizar o status da tarefa após o reenvio.
- O novo envio deve ficar registrado no histórico da tarefa.

**Regras de Negócio** — O sistema não deve permitir que a tarefa:
- Seja reenviada sem que exista uma solicitação de correção anterior;
- Seja reenviada por um aluno que não está alinhado ao projeto;
- Seja reenviada após a tarefa ter sido aprovada;
- Receba um novo envio sem que o anterior tenha sido avaliado pelo orientador.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Vínculo do aluno ao projeto | Aluno alinhado/vinculado ao projeto (1) | Aluno não alinhado ao projeto (2) | |
| Estado/histórico da tarefa | Tarefa com correção solicitada, aguardando reenvio (3) | Tarefa sem solicitação de correção anterior (4) | Tarefa já aprovada (5) |
| Avaliação do envio anterior | Envio anterior já avaliado pelo orientador (6) | Envio anterior ainda pendente de avaliação (7) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 3, 6 | Aluno alinhado + tarefa com correção solicitada + envio anterior já avaliado | Reenvio aceito, status atualizado e registrado no histórico |
| Caso 2 | 2, 3, 6 | Aluno não alinhado ao projeto tenta reenviar a tarefa | Erro — aluno não autorizado |
| Caso 3 | 1, 4, 6 | Aluno tenta reenviar tarefa que nunca teve correção solicitada | Erro — não há solicitação de correção anterior |
| Caso 4 | 1, 5, 6 | Aluno tenta reenviar tarefa já aprovada | Erro — tarefa já aprovada, reenvio bloqueado |
| Caso 5 | 1, 3, 7 | Aluno tenta reenviar antes do envio anterior ser avaliado pelo orientador | Erro — envio anterior ainda pendente de avaliação |

---

## US-08 — Consultar histórico de projetos encerrados

**História do Usuário**:
Enquanto Orientador, desejo consultar projetos encerrados, para fins de histórico.

**Critérios de Aceitação**
- O sistema deve exibir apenas projetos com status encerrado.
- O sistema deve permitir a visualização dos dados detalhados do projeto selecionado.
- Os dados do projeto devem ser apresentados em modo somente leitura.
- O sistema deve garantir que apenas projetos específicos ao orientador autenticado sejam exibidos.

**Regras de Negócio** — O sistema não deve permitir que:
- Sejam exibidos projetos com status ativo no histórico;
- Sejam exibidos projetos que não pertençam ao orientador autenticado;
- O usuário acesse o histórico sem estar autenticado no sistema;
- Sejam vistos detalhes de projetos inexistentes ou removidos do sistema.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Status do projeto | Projeto com status "Encerrado" (1) | Projeto com status "Ativo" ou "Rascunho" (2) | |
| Vínculo do projeto com o orientador autenticado | Projeto pertence ao orientador autenticado (3) | Projeto pertence a outro orientador (4) | Projeto inexistente ou removido do sistema (5) |
| Autenticação do usuário | Usuário autenticado no sistema (6) | Usuário não autenticado (7) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 3, 6 | Projeto encerrado, pertence ao orientador autenticado | Projeto exibido em modo somente leitura, com opção de download disponível |
| Caso 2 | 2, 3, 6 | Projeto com status ativo tentando ser exibido no histórico | Projeto não aparece na listagem do histórico |
| Caso 3 | 1, 4, 6 | Orientador autenticado tenta acessar projeto encerrado de outro orientador | Acesso negado — projeto não pertence ao orientador autenticado |
| Caso 4 | 1, 5, 6 | Acesso a detalhes de projeto inexistente/removido | Erro — projeto não encontrado |
| Caso 5 | 1, 3, 7 | Usuário não autenticado tenta acessar o histórico de projetos | Acesso negado — autenticação obrigatória |

---

## US-09 — Registrar e acompanhar controle de presença

**História do Usuário**:
Enquanto Orientador, desejo registrar a presença dos alunos em reuniões de projeto, para acompanhar o engajamento de cada um.

**Critérios de Aceitação**
- O sistema deve permitir o registro de presença para cada aluno conforme o projeto.
- O sistema deve permitir que o orientador selecione a reunião/evento ao qual a presença será registrada.
- O sistema deve calcular automaticamente o percentual de presença dos alunos com base nos registros.
- O sistema deve permitir a visualização dos registros de presença pelo orientador.

**Regras de Negócio** — O sistema não deve permitir que:
- Sejam registrados alunos que não estejam vinculados ao projeto;
- Sejam registrados eventos que não existam no sistema;
- O registro de presença seja realizado por usuário não autorizado a atuar como orientador do projeto;
- Sejam incluídas presenças duplicadas para o mesmo aluno no mesmo evento.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Vínculo do aluno ao projeto | Aluno vinculado ao projeto (1) | Aluno não vinculado ao projeto (2) | |
| Existência do evento/reunião | Evento/reunião existente no sistema (3) | Evento/reunião inexistente (4) | |
| Autorização do usuário registrador | Usuário autorizado como orientador do projeto (5) | Usuário não autorizado a atuar como orientador (6) | |
| Duplicidade do registro | Registro único de presença por aluno/evento (7) | Tentativa de registro duplicado para o mesmo aluno no mesmo evento (8) |  |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 3, 5, 7 | Aluno vinculado + evento existente + orientador autorizado + sem duplicidade | Presença registrada com sucesso |
| Caso 2 | 2, 3, 5, 7 | Aluno não vinculado ao projeto | Erro — aluno não pertence ao projeto |
| Caso 3 | 1, 4, 5, 7 | Evento/reunião inexistente no sistema | Erro — evento não encontrado |
| Caso 4 | 1, 3, 6, 7 | Usuário não autorizado tenta registrar presença | Erro — usuário não autorizado como orientador |
| Caso 5 | 1, 3, 5, 8 | Tentativa de registrar presença duplicada para o mesmo aluno no mesmo evento | Erro — presença já registrada para este evento |

---

## US-10 — Visualizar tarefas pendentes

**História do Usuário**:
Enquanto Aluno, desejo visualizar todas as tarefas pendentes que foram atribuídas a mim, para saber exatamente o que preciso entregar e em qual prazo.

**Critérios de Aceitação**
- O sistema deve listar apenas as tarefas pendentes do aluno autenticado.
- As tarefas devem ser exibidas ordenadas por prazo de entrega (mais próximo primeiro).
- O sistema deve destacar visualmente as tarefas vencidas.
- O sistema deve permitir a visualização dos detalhes de cada tarefa.

**Regras de Negócio** — O sistema não deve permitir que:
- Sejam exibidas tarefas de outros alunos;
- Sejam exibidas tarefas com status concluído;
- Sejam exibidas tarefas que não pertençam ao projeto do aluno;
- O usuário acesse tarefas sem estar autenticado no sistema.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Vínculo da tarefa com o aluno autenticado | Tarefa pertence ao aluno e ao projeto do qual ele faz parte (1) | Tarefa pertence a outro aluno (2) | Tarefa não pertence ao projeto do aluno (3) |
| Status da tarefa | Tarefa com status "Pendente" (4) | Tarefa com status "Concluído" (5) | |
| Autenticação do usuário | Usuário autenticado (6) | Usuário não autenticado (7) | |
| Prazo da tarefa | Tarefa com prazo futuro, não vencida (8) | Tarefa com prazo expirado (vencida) (9) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 6, 8 | Tarefa do próprio aluno, pendente, prazo futuro, autenticado | Tarefa exibida na lista, ordenada por prazo |
| Caso 2 | 2, 4, 6, 8 | Tarefa pertencente a outro aluno | Tarefa não aparece na lista do aluno autenticado |
| Caso 3 | 3, 4, 6, 8 | Tarefa que não pertence ao projeto do aluno | Tarefa não aparece na lista do aluno autenticado |
| Caso 4 | 1, 5, 6, 8 | Tarefa do aluno com status "Concluído" | Tarefa não aparece na lista de pendentes |
| Caso 5 | 1, 4, 7, 8 | Usuário não autenticado tenta acessar a lista de tarefas | Acesso negado — autenticação obrigatória |
| Caso 6 | 1, 4, 6, 9 | Tarefa do aluno com prazo expirado | Tarefa exibida com destaque visual de "vencida" |

---

## US-11 — Submeter arquivo em uma tarefa

**História do Usuário**:
Enquanto Aluno, desejo submeter arquivos em tarefas, para cumprir atividades.

**Critérios de Aceitação**
- O sistema deve permitir o envio de arquivos para uma tarefa específica.
- O sistema deve validar o arquivo antes de aceitar a submissão.
- O sistema deve confirmar o envio do arquivo ao aluno.
- O sistema deve atualizar automaticamente o status da tarefa após a submissão.

**Regras de Negócio** — O sistema não deve permitir que:
- Sejam enviados arquivos fora do prazo da tarefa;
- Sejam enviados arquivos em formatos não permitidos pelo sistema;
- Sejam enviados arquivos que excedam o limite de tamanho permitido pelo sistema;
- Sejam submetidos arquivos por alunos não vinculados ao projeto da tarefa.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Vínculo do aluno ao projeto da tarefa | Aluno vinculado ao projeto da tarefa (1) | Aluno não vinculado ao projeto da tarefa (2) | |
| Prazo da tarefa | Envio realizado dentro do prazo da tarefa (3) | Envio realizado após o prazo da tarefa (4) | |
| Formato do arquivo | Arquivo em formato permitido pelo sistema (5) | Arquivo em formato não permitido (6) | |
| Tamanho do arquivo | Arquivo com tamanho dentro do limite permitido (7) | Arquivo excede o limite máximo de tamanho (8) | Arquivo vazio (0 bytes) (9) |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 3, 5, 7 | Aluno vinculado + dentro do prazo + formato permitido + tamanho válido | Arquivo enviado com sucesso, status da tarefa atualizado |
| Caso 2 | 2, 3, 5, 7 | Aluno não vinculado ao projeto da tarefa | Erro — aluno não autorizado a submeter nesta tarefa |
| Caso 3 | 1, 4, 5, 7 | Envio realizado após o prazo da tarefa | Erro — submissão fora do prazo |
| Caso 4 | 1, 3, 6, 7 | Arquivo em formato não permitido (ex: .exe) | Erro — formato de arquivo não suportado |
| Caso 5 | 1, 3, 5, 8 | Arquivo excede o limite máximo de tamanho permitido | Erro — arquivo excede o tamanho máximo |
| Caso 6 | 1, 3, 5, 9 | Arquivo vazio (0 bytes) | Erro — arquivo vazio não pode ser enviado |

---

## US-12 — Receber notificação de nova tarefa

**História do Usuário**:
Enquanto Usuário, desejo receber notificações, para acompanhar atualizações relacionadas às minhas ações e eventos no sistema.

**Critérios de Aceitação**
- O sistema deve enviar notificações relacionadas às ações e eventos do usuário.
- O sistema deve exibir notificações com informações básicas como título, mensagem e data/hora.
- O sistema deve permitir que o usuário acesse o item relacionado à notificação.
- O sistema deve manter um histórico de notificações do usuário.

**Regras de Negócio** — O sistema não deve permitir que:
- Sejam enviadas notificações sem relação com o usuário autenticado;
- Sejam geradas notificações a partir de eventos considerados irrelevantes pelo sistema;
- Sejam enviadas notificações para usuários inativos ou desativados no sistema;
- Sejam exibidas notificações de outros usuários.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Relação da notificação com o destinatário | Notificação relacionada ao usuário autenticado (1) | Notificação sem relação com o usuário autenticado (2) | Notificação pertencente a outro usuário sendo exibida indevidamente (3) |
| Relevância do evento gerador | Evento considerado relevante pelo sistema (4) | Evento considerado irrelevante pelo sistema (5) | |
| Status da conta do destinatário | Usuário com conta ativa (6) | Usuário com conta inativa/desativada (7) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 6 | Notificação relacionada ao usuário + evento relevante + conta ativa | Notificação enviada e exibida corretamente no histórico |
| Caso 2 | 2, 4, 6 | Tentativa de gerar notificação sem relação com o usuário autenticado | Notificação não é enviada |
| Caso 3 | 3, 4, 6 | Usuário autenticado tenta visualizar notificação pertencente a outro usuário | Acesso negado — notificação não pertence ao usuário |
| Caso 4 | 1, 5, 6 | Evento considerado irrelevante pelo sistema | Notificação não é gerada |
| Caso 5 | 1, 4, 7 | Usuário destinatário está inativo/desativado | Notificação não é enviada |

---

## US-13 — Realizar check-in de presença

**História do Usuário**:
Enquanto Aluno, desejo realizar check-in de presença, para garantir o registro da minha participação.

**Critérios de Aceitação**
- O sistema deve permitir que o aluno visualize os eventos de reunião disponíveis para check-in no dia atual.
- O sistema deve permitir que o orientador gere um código PIN de 4 dígitos para validação da presença.
- O sistema deve permitir que o aluno realize o check-in mediante a inserção do PIN fornecido pelo orientador.
- O sistema deve validar o PIN antes de confirmar o registro de presença.
- O sistema deve confirmar o check-in realizado e atualizar o histórico de presença do aluno.

**Regras de Negócio** — O sistema não deve permitir que:
- Seja realizado check-in sem a inserção de um PIN válido gerado pelo orientador;
- Seja realizado check-in com PIN inválido ou expirado;
- Seja realizado check-in fora do horário permitido do evento;
- Seja realizado check-in em eventos inexistentes;
- Seja realizado check-in por alunos não vinculados ao evento ou projeto;
- Sejam realizados check-ins múltiplos para o mesmo aluno no mesmo evento.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Vínculo do aluno ao projeto/evento | Aluno vinculado ao projeto e ao evento (1) | Aluno não vinculado ao projeto (2) | |
| PIN informado | PIN de 4 dígitos válido e gerado pelo orientador (3) | PIN inválido ou incorreto (4) | PIN expirado (5) |
| Existência e horário do evento | Evento existente e dentro do horário permitido (6) | Evento inexistente (7) | Check-in fora do horário permitido do evento (8) |
| Duplicidade do check-in | Primeiro check-in do aluno no evento (9) | Tentativa de check-in duplicado no mesmo evento (10) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 3, 6, 9 | Aluno vinculado + PIN válido + evento existente no horário + primeiro check-in | Check-in realizado com sucesso, histórico atualizado |
| Caso 2 | 2, 3, 6, 9 | Aluno não vinculado ao projeto tenta realizar check-in | Erro — aluno não autorizado para este evento |
| Caso 3 | 1, 4, 6, 9 | Aluno vinculado + PIN incorreto/inválido | Erro — PIN inválido |
| Caso 4 | 1, 5, 6, 9 | Aluno vinculado + PIN expirado | Erro — PIN expirado |
| Caso 5 | 1, 3, 7, 9 | Aluno vinculado + PIN válido + evento inexistente | Erro — evento não encontrado |
| Caso 6 | 1, 3, 8, 9 | Aluno vinculado + PIN válido + evento existente mas fora do horário | Erro — check-in fora do horário permitido |
| Caso 7 | 1, 3, 6, 10 | Aluno vinculado tenta realizar check-in pela segunda vez no mesmo evento | Erro — check-in duplicado não permitido |

---

## US-14 — Consultar feedback do orientador

**História do Usuário**:
Enquanto Aluno, desejo consultar feedbacks, para melhorar meu desempenho.

**Critérios de Aceitação**
- O sistema deve exibir feedbacks vinculados às tarefas do aluno.
- O sistema deve permitir a visualização do histórico completo de feedbacks.
- O sistema deve indicar claramente quando uma tarefa exige solicitação de correção.
- O sistema deve permitir o acesso aos detalhes de cada feedback.

**Regras de Negócio** — O sistema não deve permitir que:
- Sejam selecionados feedbacks de tarefas não avaliadas;
- Sejam listados feedbacks de outros alunos;
- Sejam definidos feedbacks de orientadores que não sejam responsáveis pelo projeto.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Vínculo do feedback com o aluno | Feedback vinculado a tarefa do próprio aluno (1) | Feedback pertencente a outro aluno (2) | |
| Estado de avaliação da tarefa | Tarefa já avaliada pelo orientador (3) | Tarefa ainda não avaliada (4) | — (condição lógica binária) |
| Responsabilidade do orientador | Feedback emitido pelo orientador responsável pelo projeto (5) | Feedback emitido por orientador não responsável pelo projeto (6) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 3, 5 | Feedback da própria tarefa do aluno + tarefa avaliada + orientador responsável | Feedback exibido corretamente com detalhes e histórico |
| Caso 2 | 2, 3, 5 | Aluno tenta acessar feedback pertencente a outro aluno | Acesso negado — feedback não pertence ao aluno autenticado |
| Caso 3 | 1, 4, 5 | Aluno tenta consultar feedback de tarefa ainda não avaliada | Erro — tarefa ainda não possui avaliação |
| Caso 4 | 1, 3, 6 | Feedback emitido por orientador que não é responsável pelo projeto | Feedback não deve ser exibido — orientador não autorizado |

---

## US-15 — Ajustar tamanho de fonte e contraste

**História do Usuário**:
"Enquanto Usuário, desejo ajustar a acessibilidade, para melhorar a usabilidade."

**Critérios de Aceitação**
- O sistema deve permitir que o usuário ajuste o tamanho da fonte e o nível de contraste.
- O sistema deve aplicar as alterações de acessibilidade imediatamente após a modificação.
- O sistema deve manter as preferências de acessibilidade salvas para sessões futuras.
- O sistema deve permitir que o usuário restaure as configurações padrão de acessibilidade.

**Regras de Negócio** — O sistema não deve permitir que:
- As configurações de acessibilidade comprometam a legibilidade do conteúdo do sistema;
- Sejam aplicadas configurações que deixem o texto ilegível ou com contraste insuficiente para leitura;
- As alterações de acessibilidade sejam aplicadas a outros usuários;
- As configurações ultrapassem os limites suportados pela interface do sistema.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Tamanho de fonte selecionado | Tamanho dentro dos limites suportados pela interface (1) | Tamanho abaixo do mínimo suportado (ilegível) (2) | Tamanho acima do máximo suportado pela interface (3) |
| Nível de contraste selecionado | Contraste dentro dos limites que garantem legibilidade (4) | Contraste insuficiente para leitura (5) | Contraste acima do limite máximo suportado (6) |
| Escopo da alteração | Alterações aplicadas apenas ao usuário autenticado (7) | Alterações sendo aplicadas a outros usuários (8) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 7 | Fonte e contraste dentro dos limites + alteração apenas para o usuário autenticado | Configurações aplicadas imediatamente e salvas para sessões futuras |
| Caso 2 | 2, 4, 7 | Tamanho de fonte abaixo do mínimo suportado | Erro — tamanho de fonte não permitido, configuração rejeitada |
| Caso 3 | 3, 4, 7 | Tamanho de fonte acima do máximo suportado | Erro — tamanho de fonte ultrapassa o limite da interface |
| Caso 4 | 1, 5, 7 | Contraste insuficiente para leitura | Erro — nível de contraste comprometeria a legibilidade |
| Caso 5 | 1, 6, 7 | Contraste acima do limite máximo suportado | Erro — contraste ultrapassa o limite suportado pela interface |
| Caso 6 | 1, 4, 8 | Alteração de acessibilidade sendo aplicada a outros usuários | Erro — alterações devem ser restritas ao usuário autenticado |

---

## US-16 — Navegar com botões rotulados e layout linear

**História do Usuário**:
Enquanto Usuário, desejo navegar com botões rotulados, para facilitar o uso.

**Critérios de Aceitação**
- O sistema deve garantir que todos os botões possuam rótulos textuais claros.
- O sistema deve permitir que o usuário se identifique facilmente a ação de cada botão.
- O sistema deve garantir a compatibilidade com a navegação pelo teclado.

**Regras de Negócio** — O sistema não deve permitir que:
- Existam apenas ícones interativos sem identificação textual;
- Existam botões sem texto descritivo diminuindo sua função;
- A navegação dependa exclusivamente de elementos visuais não descritivos;
- A interface impeça o uso do teclado em qualquer funcionalidade essencial.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Identificação textual dos botões | Botão possui rótulo textual claro e descritivo (1) | Botão possui apenas ícone sem texto identificador (2) | Botão possui texto vago que não descreve sua função (3) |
| Dependência de elementos visuais para navegação | Navegação funciona com e sem elementos visuais descritivos (4) | Navegação depende exclusivamente de elementos visuais não descritivos (5) | |
| Compatibilidade com navegação por teclado | Todas as funcionalidades essenciais acessíveis pelo teclado (6) | Interface impede o uso do teclado em funcionalidade essencial (7) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 4, 6 | Botão com rótulo textual claro + navegação não dependente de visual + teclado funcional | Interface acessível, botão identificável e navegação completa pelo teclado |
| Caso 2 | 2, 4, 6 | Botão com apenas ícone e sem texto identificador | Erro — botão não acessível, viola critério de identificação textual |
| Caso 3 | 3, 4, 6 | Botão com texto vago que não descreve sua função (ex: "Clique aqui") | Erro — rótulo insuficiente para identificar a ação do botão |
| Caso 4 | 1, 5, 6 | Navegação possível apenas por elementos visuais não descritivos | Erro — navegação não pode depender exclusivamente de elementos visuais |
| Caso 5 | 1, 4, 7 | Interface bloqueia o uso do teclado em funcionalidade essencial | Erro — funcionalidade essencial inacessível pelo teclado |

---

## US-17 — Utilização modo de foco sem distrações

**História do Usuário**:
Enquanto Usuário, desejo ativar modo foco, para reduzir distrações.

**Critérios de Aceitação**
- O sistema deve permitir ativar e desativar o modo foco.
- O sistema deve ocultar elementos secundários da interface quando o modo foco estiver ativo.
- O conteúdo principal deve permanecer visível e acessível ao usuário.
- O sistema deve manter o modo foco apenas enquanto o usuário desejar, permitindo retorno ao modo padrão a qualquer momento.

**Regras de Negócio** — O sistema não deve permitir que:
- O modo foco oculte funcionalidades essenciais do sistema;
- O modo foco impeça a navegação ou execução das principais ações do usuário;
- O modo foco altere ou modifique dados do usuário.

### Tabela de Classes de Equivalência

| Condição de Entrada | Classes Válidas | Classes Inválidas | Classes Inválidas |
|:---|:---|:---|:---|
| Ativação/desativação do modo foco | Modo foco ativado e desativado corretamente pelo usuário (1) | Modo foco não responde ao comando de ativação/desativação (2) | |
| Visibilidade do conteúdo principal | Conteúdo principal permanece visível e acessível com modo foco ativo (3) | Conteúdo principal ocultado pelo modo foco (4) | Funcionalidade essencial do sistema ocultada pelo modo foco (5) |
| Impacto nas ações do usuário | Modo foco não impede navegação nem execução das ações principais (6) | Modo foco impede a navegação ou execução de ações principais (7) | |
| Integridade dos dados | Modo foco não altera nem modifica dados do usuário (8) | Modo foco altera ou modifica dados do usuário indevidamente (9) | |

### Tabela de Casos de Teste

| Caso | Classes de Equivalência | Entradas | Resultado Esperado |
|:---|:---|:---|:---|
| Caso 1 | 1, 3, 6, 8 | Modo foco ativado corretamente + conteúdo principal visível + ações principais acessíveis + dados intactos | Modo foco ativo, elementos secundários ocultos, conteúdo principal acessível |
| Caso 2 | 2, 3, 6, 8 | Comando de ativação/desativação do modo foco não responde | Erro — modo foco não responde ao comando do usuário |
| Caso 3 | 1, 4, 6, 8 | Modo foco oculta o conteúdo principal da interface | Erro — conteúdo principal não pode ser ocultado pelo modo foco |
| Caso 4 | 1, 5, 6, 8 | Modo foco oculta funcionalidade essencial do sistema | Erro — funcionalidades essenciais não podem ser ocultadas pelo modo foco |
| Caso 5 | 1, 3, 7, 8 | Modo foco impede a navegação ou execução de ações principais | Erro — modo foco não pode bloquear ações principais do usuário |
| Caso 6 | 1, 3, 6, 9 | Modo foco altera ou modifica dados do usuário indevidamente | Erro — modo foco não deve modificar dados do usuário |

---

## Resumo Geral

| US | Título | Nº de Classes | Nº de Casos de Teste | Inconsistências |
|:---|:---|:---:|:---:|:---|
| US-01 | Login no sistema | 8 | 6 | — |
| US-02 | Visualizar painel central | 7 | 5 | — |
| US-03 | Cadastrar novo projeto acadêmico | 7 | 5 | — |
| US-04 | Criar e definir tarefa a orientar | 8 | 6 | ⚠️ Regras de negócio referem-se a editais (Issue #25) |
| US-05 | Visualizar e filtrar editais no feed unificado | 7 | 5 | — |
| US-06 | Aprovar ou solicitar correção de tarefa | 7 | 5 | ⚠️ Título da issue refere-se a editais (Issue #27) |
| US-07 | Reenviar tarefa para correção | 7 | 5 | ⚠️ Título da issue refere-se a geração de documento (Issue #28) |
| US-08 | Consultar histórico de projetos encerrados | 7 | 5 | — |
| US-09 | Registrar e acompanhar controle de presença | 8 | 5 | — |
| US-10 | Visualizar tarefas pendentes | 9 | 6 | — |
| US-11 | Submeter arquivo em uma tarefa | 9 | 6 | — |
| US-12 | Receber notificação de nova tarefa | 7 | 5 | — |
| US-13 | Realizar check-in de presença | 10 | 7 | — |
| US-14 | Consultar feedback do orientador | 6 | 4 | — |
| US-15 | Ajustar tamanho de fonte e contraste | 8 | 6 | — |
| US-16 | Navegar com botões rotulados e layout linear | 7 | 5 | — |
| US-17 | Utilização modo de foco sem distrações | 9 | 6 | — |
| **Total** | | **135** | **97** | **3 inconsistências** |

---

<div align="center">

**Universidade Federal do Amazonas — ICET | Engenharia de Software I | 2026**

</div>
