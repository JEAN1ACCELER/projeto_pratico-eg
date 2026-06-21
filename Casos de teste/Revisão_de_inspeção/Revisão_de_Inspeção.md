# 📄 Relatório de Inspeção e Refatoração de Requisitos

**Projeto:** E-Project (Gestão de Projetos Acadêmicos)
**Fase:** Trabalho Prático III - Consolidação de Inspeção e Refatoração de Backlog

## Objetivo
Este documento apresenta os resultados da auditoria cruzada (inspeção) realizada no repositório do projeto. O objetivo é detalhar as *Issues* geradas, avaliando-as isoladamente. Indicamos claramente quais apontamentos foram considerados pertinentes (corrigidos) e qual foi classificado como falso positivo (reavaliado), acompanhados de suas devidas justificativas técnicas.

---

## 1. Relação de Issues Criadas no GitHub

> **📌 Nota ao Avaliador:** Para facilitar a rastreabilidade, todas as *issues* inspecionadas no repositório receberam a tag geral **`Revisadas`**. Além disso, foram categorizadas com *labels* de status final de resolução, conforme a tabela abaixo. Clique no número da Issue para acessá-la diretamente no GitHub:

| Issue GitHub | História de Usuário (US) | Status / Label Aplicada |
| :---: | :--- | :--- |
| **[Issue #48](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/48)** | US05 - Visualizar e filtrar editais no feed unificado | 🟢 Corrigido |
| **[Issue #49](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/49)** | US04 - Criar e definir tarefa a orientar | 🟢 Corrigido |
| **[Issue #50](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/50)** | US03 - Cadastrar novo projeto acadêmico | 🟢 Corrigido |
| **[Issue #51](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/51)** | US02 - Visualizar painel central | 🟢 Corrigido |
| **[Issue #52](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/52)** | US08 - Regra de "Somente Leitura" e Downloads | 🟢 Corrigido |
| **[Issue #53](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/53)** | US08 - Impossibilidade de Reativação de Projetos | 🔴 Não Corrigido (Reavaliado) |
| **[Issue #54](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/54)** | US07 - Geração individual de documentos | 🟢 Corrigido |
| **[Issue #55](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/55)** | US12 - Configuração de notificação global | 🟢 Corrigido |
| **[Issue #56](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/56)** | US09 - Realizar check-in de presença (Validação PIN) | 🟢 Corrigido |
| **[Issue #57](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/57)** | US11 - Limite de caracteres | 🟢 Corrigido |
| **[Issue #58](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/58)** | US06 - Aprovar ou solicitar editais | 🟢 Corrigido |
| **[Issue #60](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/60)** | US16 - Navegar com botões rotulados e layout linear | 🟢 Corrigido |
| **[Issue #61](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/61)** | US15 - Ajustar tamanho de fonte e contraste | 🟢 Corrigido |
| **[Issue #62](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/62)** | US10 - Visualizar tarefas pendentes | 🟢 Corrigido |

---

## 2. Problemas Pertinentes (Aceitos e Corrigidos)

Nesta seção, detalhamos as *issues* que reportaram defeitos reais (omissões e ambiguidades) e agregaram valor ao projeto. O Backlog foi refatorado para mitigar estas falhas e parametrizar as regras para as equipes de Front-end e Back-end.

### Issue #60 (US16) - Ambiguidade em Zoom e Interatividade
* **Problema Apontado:** O requisito sobre acessibilidade não definia o que era um elemento interativo nem o limite objetivo para perda de funcionalidade em escalas de zoom.
* **Diagnóstico:** Sem limites numéricos e escopo claro baseados na WCAG, a equipe de QA não teria como realizar testes de acessibilidade objetivos.
* **Correção Aplicada:** Definimos que "elementos interativos" incluem botões, links, abas e formulários. Especificamos que a interface deve suportar ampliação de até **200%** sem sobreposição ou necessidade de rolagem horizontal para funções críticas.

### Issue #61 (US15) - Omissão de Métricas de Acessibilidade
* **Problema Apontado:** Faltavam valores precisos para os níveis de fonte e não havia especificação da taxa de contraste para o tema de "Alto Contraste".
* **Diagnóstico:** Especificações subjetivas impedem a adequação real a normativas de acessibilidade.
* **Correção Aplicada:** Fixamos o tamanho da fonte em unidades relativas (1rem/100%, 1.25rem/125%, 1.5rem/150%) e exigimos taxa mínima de contraste de **7:1** (nível AAA da WCAG) no tema escuro.

### Issue #62 (US10) - Ambiguidade no Parâmetro de Urgência
* **Problema Apontado:** A funcionalidade ordenava tarefas da "mais urgente primeiro", mas não definia matematicamente a partir de quando uma tarefa é considerada urgente.
* **Diagnóstico:** A utilização do termo "urgente" sem critério quantitativo impede a correta ordenação no banco de dados e as tratativas visuais no front-end.
* **Correção Aplicada:** Criamos a regra de negócio exata: uma tarefa entra no status/tag "Urgente" quando seu prazo de entrega for **igual ou inferior a 48 horas**. A ordenação principal do feed passa a ser `data_vencimento ASC`.

### Issue #56 (US09) - Falha Lógica na Validação de Presença
* **Problema Apontado:** O check-in era realizado apenas por um clique no aplicativo, sem validação real de presença física.
* **Diagnóstico:** O modelo puramente *Client-Side* abria margem para fraudes sistêmicas (marcação de presença sem comparecimento).
* **Correção Aplicada:** O fluxo foi alterado para exigir a inserção de um Código PIN (OTP) de 4 dígitos, gerado no sistema do orientador durante o encontro.

### Issue #49 (US04) - Omissão de Ciclo de Vida e Restrição de Prazo
* **Problema Apontado:** Falta de clareza sobre os status de uma tarefa e omissão de limite máximo para a definição de prazo de entrega.
* **Diagnóstico:** A ausência de uma "trava temporal" permitiria cadastrar tarefas para datas muito além do encerramento oficial do projeto.
* **Correção Aplicada:** Inserido o ciclo Kanban (A Fazer, Em Andamento, Concluída, Atrasada) e aplicada a regra limitadora: a data máxima de uma tarefa não pode ultrapassar a data final do projeto acadêmico.

### Issue #50 (US03) - Falta de Estado Intermediário para Projetos
* **Problema Apontado:** O projeto exigia um aluno vinculado para ser ativado, mas não previa um estado para salvamento prévio.
* **Diagnóstico:** A ausência de estado transitório inviabiliza o trabalho em progresso e prejudica a usabilidade de criação de cadastros longos.
* **Correção Aplicada:** Criado o status **'Rascunho'** para projetos salvos sem alunos. O status transita para **'Em Andamento'** automaticamente ao vincular os discentes.

### Issue #51 (US02) - Ambiguidade em SLA de Desempenho
* **Problema Apontado:** Uso de termo subjetivo "carregar rápido em conexão de boa qualidade".
* **Diagnóstico:** Requisitos não-funcionais devem ser testáveis e automatizáveis.
* **Correção Aplicada:** Substituído por uma métrica técnica rigorosa: SLA de tempo de resposta máximo de **3 segundos** sob rede de pelo menos 10 Mbps.

### Issue #48 (US05) - Escopo Vago de Integração de Editais
* **Problema Apontado:** O requisito solicitava integrar dados das "principais pró-reitorias" sem especificar quais.
* **Diagnóstico:** Termos abertos geram inchaço de escopo (*Scope Creep*).
* **Correção Aplicada:** O escopo foi blindado, limitando o *fetch* de dados unicamente aos endpoints das **PROPESP** e **PROEXT**.

### Issue #52 (US08) - Esclarecimento: Leitura x Download
* **Problema Apontado:** O termo "somente leitura" no histórico abria dúvidas sobre a permissão de download de arquivos finalizados.
* **Diagnóstico:** Faltava delimitar onde acabava o privilégio de "visualização" e onde entrava a "extração" dos arquivos em tela.
* **Correção Aplicada:** Documento refatorado para esclarecer a separação, mantendo explicitamente autorizada a visualização dos dados e o download de documentos, mas bloqueando a edição/deleção.

---

## 3. Problemas Reavaliados e Não Corrigidos

Nesta seção, encontra-se a única *issue* **rejeitada** após análise técnica da equipe, acompanhada da justificativa pela qual a funcionalidade se manterá conforme originalmente idealizada.

### Issue #53 (US08) - Impossibilidade de Reativação de Projetos
* **Problema Apontado:** Foi apontado como "defeito" o fato de o sistema não possuir um botão para "reativar" projetos que foram encerrados ou cancelados.
* **Justificativa para Não Correção:** Trata-se de um falso positivo, pois essa ausência é **proposital**. O projeto obedece a uma Regra de Negócio de auditoria acadêmica (imutabilidade de registros concluídos). Uma vez que um projeto entra no estado de "Histórico", seu ciclo de vida é encerrado e os dados se tornam evidências oficiais. A criação de um botão de "reativação" comprometeria o *compliance* de versionamento e prazos do sistema acadêmico.
* **Veredito:** Mantida a irreversibilidade por design. A US não sofreu alterações. Defeito rejeitado.
