# 📄 Relatório de Inspeção e Refatoração de Requisitos

**Projeto:** E-Project (Gestão de Projetos Acadêmicos)
**Fase:** Trabalho Prático III - Consolidação de Inspeção e Refatoração de Backlog

## Objetivo
Este documento apresenta os resultados da auditoria cruzada (inspeção) realizada por outras equipes no nosso repositório. O objetivo é detalhar as *Issues* geradas no GitHub, indicando claramente quais apontamentos foram considerados pertinentes e corrigidos, e quais foram classificados como falsos positivos (não corrigidos) com suas devidas justificativas.

---

## 1. Relação de Issues Criadas no GitHub

> **📌 Nota ao Avaliador:** Para facilitar a rastreabilidade e a correção, todas as *issues* no repositório foram devidamente categorizadas com **labels** de status (ex: `Revisadas`, `Corrigido`, `Não Corrigido (Falso Positivo)`). Acesse os links na tabela abaixo para consultar a resolução, as edições e as justificativas aplicadas diretamente no GitHub.

Abaixo estão listadas as issues apontadas pela equipe inspetora, associadas às respectivas Histórias de Usuário (US) do nosso *Backlog*:

| Issue GitHub | História de Usuário (US) | Status / Label Aplicada |
| :---: | :--- | :--- |
| **[Issue #51](COLE_O_LINK_AQUI)** | US02 - Visualizar painel central | 🟢 Corrigido |
| **[Issue #50](COLE_O_LINK_AQUI)** | US03 - Cadastrar novo projeto acadêmico | 🟢 Corrigido |
| **[Issue #49](COLE_O_LINK_AQUI)** | US04 - Criar e definir tarefa a orientar | 🟢 Corrigido |
| **[Issue #48](COLE_O_LINK_AQUI)** | US05 - Visualizar e filtrar editais no feed unificado | 🟢 Corrigido |
| **[Issue #46](COLE_O_LINK_AQUI)** | US10 - Visualizar tarefas pendentes | 🟢 Corrigido |
| **[Issue #45](COLE_O_LINK_AQUI)** | US13 - Realizar check-in de presença | 🟢 Corrigido |
| **[Issue #47](COLE_O_LINK_AQUI)** | US06 - Aprovar ou solicitar editais | 🟡 Parcial (Título corrigido / Enunciado mantido) |
| **[Issue #52](COLE_O_LINK_AQUI)** | US08 - Regra de "Somente Leitura" no Histórico | 🔴 Não Corrigido (Falso Positivo) |

---

## 2. Problemas Pertinentes (Aceitos e Corrigidos)

Nesta seção, detalhamos os defeitos que **fizeram sentido** e agregaram valor ao projeto. As histórias foram editadas para refletir as correções.

### Issue #51 (US02) - Ambiguidade em Requisito Não-Funcional
* **Problema Apontado:** O critério de aceite usava o termo subjetivo "carregar rápido em conexão de boa qualidade".
* **Correção Aplicada:** Trocamos a subjetividade por uma métrica exata.
* **Resultado:** O critério agora exige tempo de resposta de "até 3 segundos sob uma banda de rede estável >= 10 Mbps", permitindo testes automatizados reais.

> ![Print da Issue #51](COLE_AQUI_A_URL_DO_DRIVE)

### Issue #50 (US03) - Falta de Estado Intermediário
* **Problema Apontado:** O projeto exigia um aluno para ficar ativo, mas a interface permitia o salvamento antes disso, o que poderia gerar erro no banco de dados.
* **Correção Aplicada:** Inclusão de uma nova regra de transição de estado.
* **Resultado:** Projetos salvos sem alunos recebem o status "Rascunho". Apenas quando um aluno é vinculado, o projeto muda para "Em Andamento" (Ativo).

> ![Print da Issue #50](COLE_AQUI_A_URL_DO_DRIVE)

### Issue #49 (US04) - Omissão de Ciclo de Vida e Restrição de Prazo
* **Problema Apontado:** Tarefas não tinham estados claros definidos e os prazos podiam ultrapassar o limite de encerramento do projeto.
* **Correção Aplicada:** Mapeamento de estados e restrição temporal de integridade.
* **Resultado:** Inserido o fluxo (A Fazer, Em Andamento, Concluída, Atrasada) e criada a regra que bloqueia tarefas com datas de entrega superiores à vigência do projeto.

> ![Print da Issue #49](COLE_AQUI_A_URL_DO_DRIVE)

### Issue #48 (US05) - Escopo de Integração Vago
* **Problema Apontado:** A história falava em buscar dados das "principais pró-reitorias", o que deixa o escopo de desenvolvimento aberto e perigoso.
* **Correção Aplicada:** Delimitação de escopo (MVP).
* **Resultado:** A integração foi restrita nominalmente apenas às APIs da **PROPESP** e **PROEXT**.

> ![Print da Issue #48](COLE_AQUI_A_URL_DO_DRIVE)

### Issue #46 (US10) - Ordenação Subjetiva e Inconsistência de Dicionário
* **Problema Apontado:** A ordenação era definida como "mais urgente primeiro" (sem critério lógico) e usava o termo "instruções" em vez de "descrição" (que era usado na US04).
* **Correção Aplicada:** Padronização semântica e definição de algoritmo.
* **Resultado:** A ordenação agora é feita por `data_vencimento ASC` (crescente), priorizando tarefas "Atrasadas". O termo foi padronizado para "descrição".

> ![Print da Issue #46](COLE_AQUI_A_URL_DO_DRIVE)

### Issue #45 (US13) - Falha Lógica na Validação de Presença
* **Problema Apontado:** O check-in era feito apenas clicando em um botão no aplicativo, abrindo brecha para que o aluno marcasse presença mesmo não estando no local.
* **Correção Aplicada:** Implementação de validação síncrona.
* **Resultado:** A presença agora exige um Código PIN (OTP) de 4 dígitos gerado pelo orientador no momento do encontro.

> ![Print da Issue #45](COLE_AQUI_A_URL_DO_DRIVE)

### Issue #47 (US06) - Desalinhamento de Título (Escopo)
* **Problema Apontado:** O título da história era "Aprovar Editais", mas a descrição falava sobre revisar as entregas de tarefas dos alunos.
* **Correção Aplicada:** Renomeação da US para alinhar título e narrativa.
* **Resultado:** O título foi atualizado para "Revisar e avaliar entregas de tarefas". *(Nota: Outro apontamento desta issue foi rejeitado, veja na seção 3).*

> ![Print da Issue #47](COLE_AQUI_A_URL_DO_DRIVE)

---

## 3. Problemas Reavaliados e Não Corrigidos (Falsos Positivos)

Nesta seção, detalhamos os apontamentos feitos pela equipe inspetora que foram **rejeitados** pela nossa equipe. Estes problemas não faziam sentido com as regras de negócio reais ou entravam em conflito com a metodologia Ágil.

### Issue #52 (US08) - Exigência de "Reativação de Projetos"
* **Problema Apontado (Inventado):** A equipe avaliadora alegou que a história estava incompleta porque faltava um fluxo/botão para "reativar projetos encerrados" que estavam no Histórico.
* **Justificativa para Não Correção:** A avaliação não considerou o contexto de negócio (Domínio). Editais institucionais da UFAM (como PIBIC/PACE) possuem ciclos orçamentários rígidos e datas de início/fim estritas governadas por edital. 
* **Veredito:** O término do projeto é um **Estado Final Absoluto**. Permitir a reativação no banco de dados abriria brechas para extensão irregular de prazos e pagamentos de bolsas. Requisito rejeitado por ferir a integridade dos dados acadêmicos.

> ![Print da Issue #52](COLE_AQUI_A_URL_DO_DRIVE)

### Issue #47 (US06) - Exigência de Detalhes Técnicos na Narrativa
* **Problema Apontado (Inventado):** A equipe avaliadora reportou como defeito o fato de a narrativa da User Story "não descrever de que maneira a necessidade será atendida pelo sistema".
* **Justificativa para Não Correção:** O apontamento entra em contradição com as boas práticas de Engenharia de Requisitos (Padrão Ágil). A narrativa padrão (*Eu como... Quero... Para que...*) foca estritamente em **quem** precisa, **o que** deseja e o **valor de negócio**, e **nunca em especificações técnicas ou de como a tela vai funcionar**. O "como" o sistema atende à necessidade é papel exclusivo dos Critérios de Aceitação.
* **Veredito:** A narrativa foi mantida em seu formato original, e o apontamento foi descartado como falso positivo metodológico.

> ![Print da Justificativa Issue #47](COLE_AQUI_A_URL_DO_DRIVE)
