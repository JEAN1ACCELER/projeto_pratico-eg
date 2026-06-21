# 📄 Relatório de Inspeção e Refatoração de Requisitos

**Projeto:** E-Project (Gestão de Projetos Acadêmicos)
**Fase:** Trabalho Prático III - Consolidação de Inspeção e Refatoração de Backlog

## Objetivo
Este documento apresenta os resultados da auditoria cruzada (inspeção) realizada por outras equipes no repositório do projeto. O objetivo é detalhar as *Issues* geradas no GitHub, avaliando-as isoladamente. Indicamos claramente quais apontamentos foram considerados pertinentes (corrigidos) e quais foram classificados como falsos positivos (não corrigidos ou reavaliados), acompanhados de suas devidas justificativas técnicas.

---

## 1. Relação de Issues Criadas no GitHub

> **📌 Nota ao Avaliador:** Para facilitar a rastreabilidade, todas as *issues* no repositório foram categorizadas com **labels** de status (ex: `Revisadas`, `Corrigido`, `Não Corrigido (Falso Positivo)`). Acesse os links na tabela abaixo para consultar a resolução diretamente no GitHub.

| Issue GitHub | História de Usuário (US) | Status / Label Aplicada |
| :---: | :--- | :--- |
| **[Issue #51](COLE_O_LINK_AQUI)** | US02 - Visualizar painel central | 🟢 Corrigido |
| **[Issue #50](COLE_O_LINK_AQUI)** | US03 - Cadastrar novo projeto acadêmico | 🟢 Corrigido |
| **[Issue #49](COLE_O_LINK_AQUI)** | US04 - Criar e definir tarefa a orientar | 🟢 Corrigido |
| **[Issue #48](COLE_O_LINK_AQUI)** | US05 - Visualizar e filtrar editais no feed unificado | 🟢 Corrigido |
| **[Issue #46](COLE_O_LINK_AQUI)** | US10 - Visualizar tarefas pendentes | 🟢 Corrigido |
| **[Issue #45](COLE_O_LINK_AQUI)** | US13 - Realizar check-in de presença | 🟢 Corrigido |
| **[Issue #47](COLE_O_LINK_AQUI)** | US06 - Aprovar ou solicitar editais | 🟡 Parcial (Título corrigido / Enunciado mantido) |
| **[Issue #52](COLE_O_LINK_AQUI)** | US08 - Regra de "Somente Leitura" no Histórico | 🔴 Não Corrigido (Reavaliado) |

---

## 2. Problemas Pertinentes (Aceitos e Corrigidos)

Nesta seção, detalhamos as *issues* que reportaram defeitos reais e agregaram valor ao projeto. O Backlog foi refatorado para mitigar estas falhas.

### Issue #51 (US02) - Ambiguidade em Requisito Não-Funcional
* **Problema Apontado:** O critério de aceite possuía falha de clareza ao usar o termo subjetivo "carregar rápido em conexão de boa qualidade".
* **Diagnóstico:** Requisitos Não-Funcionais precisam de *thresholds* exatos para viabilizar testes automatizados.
* **Correção Aplicada:** Trocamos a subjetividade por uma métrica de SLA clara. O sistema agora exige tempo de resposta de "até 3 segundos sob uma banda de rede estável >= 10 Mbps".

### Issue #50 (US03) - Falta de Estado Intermediário
* **Problema Apontado:** O projeto exigia um aluno vinculado para ser ativado, mas a interface não previa um estado para salvamento prévio.
* **Diagnóstico:** A ausência de estado transitório impede o salvamento no banco de dados e prejudica a usabilidade.
* **Correção Aplicada:** Implementação da transição de status. Projetos salvos sem alunos recebem o status **'Rascunho'**. Apenas quando um aluno é vinculado, o status muda automaticamente para **'Em Andamento'**.

### Issue #49 (US04) - Omissão de Ciclo de Vida e Restrição de Prazo
* **Problema Apontado:** Falta de clareza sobre os status de uma tarefa e omissão de limite máximo para a definição de prazo de entrega.
* **Diagnóstico:** A falta de status impede a modelagem do banco, e a ausência de trava temporal geraria inconsistências de datas.
* **Correção Aplicada:** Inserido o ciclo Kanban (A Fazer, Em Andamento, Concluída, Atrasada) e criada a regra de negócio que bloqueia a criação de tarefas com datas de entrega que superem o encerramento do projeto.

### Issue #48 (US05) - Escopo de Integração Vago
* **Problema Apontado:** O requisito mencionava integrar dados das "principais pró-reitorias" de forma aberta e inespecífica.
* **Diagnóstico:** Termos abertos geram *Scope Creep* (inchaço de escopo) e inviabilizam a entrega do MVP.
* **Correção Aplicada:** O escopo foi delimitado estritamente. O *fetch* de dados ocorrerá unicamente via integração com as APIs da **PROPESP** e **PROEXT**.

### Issue #46 (US10) - Ordenação Subjetiva e Inconsistência de Dicionário
* **Problema Apontado:** A funcionalidade ordenava tarefas por prazo "mais urgente", não definindo o que é "urgente". O critério 4 também usava a palavra "instruções", diferindo dos campos criados na US04.
* **Diagnóstico:** A lógica requer um parâmetro algorítmico exato e o sistema não pode ter ambiguidades no Dicionário de Dados.
* **Correção Aplicada:** A ordenação foi parametrizada para usar `data_vencimento ASC` e tarefas "Atrasadas" ganharam prioridade no topo. O termo "instruções" foi padronizado para "descrição" para manter simetria (1:1) com a US04.

### Issue #45 (US13) - Falha Lógica na Validação de Presença
* **Problema Apontado:** O check-in era realizado apenas por um clique no aplicativo, sem validação real de presença física.
* **Diagnóstico:** Esse modelo focado no lado do cliente (*Client-Side*) permite fraudes sistêmicas (presença sem comparecimento).
* **Correção Aplicada:** O fluxo foi alterado para validação síncrona. Agora, o check-in exige a inserção de um Código PIN (OTP) de 4 dígitos gerado pelo orientador no momento do encontro presencial.

---

## 3. Problemas Reavaliados e Não Corrigidos (Falsos Positivos)

Nesta seção, detalhamos os apontamentos que foram **rejeitados** após análise técnica da equipe, acompanhados de suas devidas justificativas metodológicas ou conceituais.

### Issue #52 (US08) - Regra de "Somente Leitura" (Ambiguidade sobre Downloads)
* **Problema Apontado:** A equipe indicou omissão argumentando que o termo "somente leitura" no histórico é ambíguo em relação a ações de download de documentos, não deixando claro se o acesso se restringe apenas à visualização em tela.
* **Justificativa para Não Correção (Reavaliação Técnica):** Trata-se de um falso positivo conceitual. Na arquitetura de software (padrão REST e Sistemas de Arquivos), o privilégio *Read-Only* refere-se exclusivamente ao bloqueio de mutação de dados (métodos de criação, edição ou exclusão). A "leitura" abrange, intrinsecamente, a extração e o download de arquivos já consolidados no servidor. Logo, não há falha estrutural no requisito.
* **Veredito:** O defeito técnico foi recusado. Contudo, para fins de pacificação da documentação e para mitigar futuras dúvidas da equipe de Frontend, o texto do requisito recebeu um pequeno adendo: *"mantendo liberada a visualização dos dados em tela e o download de todos os documentos previamente gerados."*

### Issue #47 (US06) - Exigência de Fluxo Técnico no Enunciado BDD
* **Problema Apontado:** Foi reportado como defeito (omissão) o fato de o enunciado da história não descrever "de que maneira a necessidade será atendida pelo sistema".
* **Justificativa para Não Correção (Reavaliação Metodológica):** Este apontamento fere os princípios da Engenharia de Requisitos Ágil. O formato *Behavior-Driven Development* (BDD - *Eu como... Quero... Para que...*) foca estritamente na percepção de valor de negócio do usuário e **nunca em especificações técnicas, fluxos de tela ou soluções algorítmicas**. Inserir o "como o sistema vai fazer" na narrativa primária é um anti-padrão. Os detalhes de comportamento residem exclusivamente nos Critérios de Aceite.
* **Veredito:** A narrativa da US06 foi mantida intacta em sua forma original. *(Nota: O único ajuste aceito desta issue foi a renomeação do Título da US para alinhar com o escopo).*
