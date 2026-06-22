# 📄 Relatório de Inspeção e Refatoração de Requisitos

**Projeto:** E-Project (Gestão de Projetos Acadêmicos)
**Fase:** Trabalho Prático III - Consolidação de Inspeção e Refatoração de Backlog

## Objetivo
Este documento apresenta os resultados da auditoria cruzada (inspeção) realizada no repositório do projeto. O objetivo é detalhar as *Issues* geradas, avaliando-as isoladamente. Indicamos claramente quais problemas foram corrigidos, não corrigidos ou reavaliados, acompanhados de suas devidas justificativas técnicas, garantindo a integridade e qualidade do Backlog.

> **Nota sobre o Custo da Qualidade:** A equipe adotou a premissa de que identificar e corrigir defeitos na fase de requisitos é até 100x mais barato do que mitigá-los após o código estar em produção. Este relatório é, portanto, uma estratégia preventiva de economia e eficiência operacional.

---

## 1. Relação de Issues Criadas no GitHub

> **📌 Nota ao Avaliador:** A coluna **Severidade** indica o impacto potencial do defeito no negócio ou na experiência do usuário. Clique no número da Issue para acessá-la diretamente no GitHub.

| Issue | História de Usuário (US) | Severidade | Status |
| :---: | :--- | :---: | :---: |
| **[#45](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/45)** | US01 - Autenticação e Controle de Acesso | Alta | 🟢 Corrigido |
| **[#46](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/46)** | US01 - Recuperação e Política de Senha | Alta | 🟢 Corrigido |
| **[#47](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/47)** | US14 - Cadastro e Validação Institucional | Alta | 🟢 Corrigido |
| **[#48](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/48)** | US05 - Visualizar e filtrar editais no feed unificado | Média | 🟢 Corrigido |
| **[#49](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/49)** | US04 - Criar e definir tarefa a orientar | Alta | 🟢 Corrigido |
| **[#50](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/50)** | US03 - Cadastrar novo projeto acadêmico | Média | 🟢 Corrigido |
| **[#51](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/51)** | US02 - Visualizar painel central | Média | 🟢 Corrigido |
| **[#52](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/52)** | US08 - Regra de "Somente Leitura" e Downloads | Média | 🟢 Corrigido |
| **[#53](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/53)** | US08 - Impossibilidade de Reativação de Projetos | Média | 🔴 Não Corrigido |
| **[#54](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/54)** | US07 - Geração individual de documentos | Baixa | 🟢 Corrigido |
| **[#55](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/55)** | US12 - Configuração de notificação global | Baixa | 🟢 Corrigido |
| **[#56](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/56)** | US09 - Realizar check-in de presença (Validação PIN) | Crítica | 🟢 Corrigido |
| **[#57](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/57)** | US11 - Limite de caracteres | Baixa | 🟢 Corrigido |
| **[#58](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/58)** | US06 - Aprovar ou solicitar editais | Alta | 🟢 Corrigido |
| **[#59](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/59)** | US13 - Exportação de Relatórios Gerenciais | Média | 🟢 Corrigido |
| **[#60](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/60)** | US16 - Navegar com botões rotulados e layout linear | Alta | 🟢 Corrigido |
| **[#61](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/61)** | US15 - Ajustar tamanho de fonte e contraste | Alta | 🟢 Corrigido |
| **[#62](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/62)** | US10 - Visualizar tarefas pendentes | Alta | 🟢 Corrigido |

---

## 2. Problemas Pertinentes (Aceitos e Corrigidos)

Nesta seção, detalhamos todas as 17 *issues* que reportaram defeitos reais (omissões e ambiguidades) e agregaram valor ao projeto. O Backlog foi refatorado para mitigar estas falhas e parametrizar as regras para as equipes de Front-end e Back-end.

### Issue #45 (US01) - Ambiguidade no Critério de Bloqueio
* **Problema:** Omissão de um critério de bloqueio de conta após sucessivas falhas de login.
* **Diagnóstico:** Ausência dessa regra cria uma brecha de segurança permitindo ataques de força bruta.
* **Correção:** Adicionada regra de bloqueio temporário (15 minutos) após 5 tentativas consecutivas falhas.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1ZRL-PLxrManLjOdyzJ8b1rDjmKo1fJ4T" alt="Issue #45" width="85%">
</p>

---

### Issue #46 (US01) - Ausência de Política de Senhas
* **Problema:** Ausência de política de complexidade de senhas na criação da conta.
* **Diagnóstico:** Permitia a criação de senhas fracas, tornando o sistema vulnerável a vazamentos.
* **Correção:** Exigência mínima de 8 caracteres, contendo pelo menos uma letra maiúscula, um número e um caractere especial.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1udgofadjtQjgHGTM6LEvtRt83pSbdxHb" alt="Issue #46" width="85%">
</p>

---

### Issue #47 (US14) - Validação de E-mail Institucional
* **Problema:** Falta de validação estrita do domínio do e-mail no cadastro acadêmico.
* **Diagnóstico:** Permitia cadastros com e-mails pessoais genéricos, burlando o vínculo institucional.
* **Correção:** Implementada validação que aceita exclusivamente e-mails com domínio institucional da universidade.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1iOXWgrEyTVRnuERoUoOmrB7GjnbZ5sm2" alt="Issue #47" width="85%">
</p>

---

### Issue #48 (US05) - Escopo Vago de Integração de Editais
* **Problema:** O requisito solicitava integrar dados das "principais pró-reitorias" sem especificar quais.
* **Diagnóstico:** Termos abertos geram inchaço de escopo (*Scope Creep*).
* **Correção:** O escopo foi blindado, limitando o *fetch* de dados unicamente aos endpoints da PROPESP e PROEXT.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1T5U12irneTax8bb1AB4Xxs1rve6ceckL" alt="Issue #48" width="85%">
</p>

---

### Issue #49 (US04) - Omissão de Ciclo de Vida e Restrição de Prazo
* **Problema:** Omissão de limite máximo para a definição de prazo de entrega de uma tarefa.
* **Diagnóstico:** A ausência de uma "trava temporal" permitiria cadastrar tarefas para datas após o encerramento do projeto.
* **Correção:** A data máxima de uma tarefa não pode ultrapassar a data final do projeto acadêmico.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1Kb9K9eL7IiTJ_X7uSWtae01XkrMRog1R" alt="Issue #49" width="85%">
</p>

---

### Issue #50 (US03) - Falta de Estado Intermediário para Projetos
* **Problema:** O projeto exigia um aluno vinculado para ser ativado, mas não previa um estado para salvamento prévio.
* **Diagnóstico:** Inviabiliza o trabalho em progresso e prejudica a usabilidade de criação de cadastros longos.
* **Correção:** Criado o status **'Rascunho'** para projetos salvos sem alunos vinculados.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1lZuSv1ulKOI84coiHlm43YTwvrjhOpJb" alt="Issue #50" width="85%">
</p>

---

### Issue #51 (US02) - Inconsistência / Contradição Lógica
* **Problema:** Regras de exibição conflitantes (projetos ativos vs. inativos).
* **Diagnóstico:** Contradição de restrições impossibilita implementação correta de filtros no banco de dados e criação de cenários de teste precisos.
* **Correção:** Unificação dos critérios de aceitação para englobar as condições de exibição de forma lógica e coesa, removendo a restrição conflitante.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1cKgO9ly8xT4Sl0JNUUcIPtRWe0OYlHtt" alt="Issue #51" width="85%">
</p>

---

### Issue #52 (US08) - Esclarecimento: Leitura x Download
* **Problema:** O termo "somente leitura" no histórico abria dúvidas sobre a permissão de download.
* **Diagnóstico:** Faltava delimitar privilégio de "visualização" contra "extração" de arquivos.
* **Correção:** Documento refatorado para manter explicitamente autorizada a visualização e o download, bloqueando apenas edição/deleção.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1BS_W2BmPZ4g8VGzas3W2IjQE0BReGrhi" alt="Issue #52" width="85%">
</p>

---

### Issue #54 (US07) - Geração de Documentos e Formato
* **Problema:** Ambiguidade no formato de saída dos documentos gerados pelo sistema.
* **Diagnóstico:** Falta de padronização geraria arquivos incompatíveis com auditoria futura.
* **Correção:** Definida a exportação obrigatória no formato **PDF/A** para garantir a conformidade e preservação dos dados.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=10hHflKdl-98lSI97_Yxa9gCWS06AljEh" alt="Issue #54" width="85%">
</p>

---

### Issue #55 (US12) - Granularidade de Notificações
* **Problema:** Notificações globais não possuíam opção de escolha de canal (E-mail vs. Plataforma).
* **Diagnóstico:** Risco de inundar o usuário com avisos indesejados, prejudicando a usabilidade.
* **Correção:** Inclusão de configurações granulares permitindo ativar/desativar alertas específicos por canal.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1_-Yh97qoNDjxXUISLHOLL-ZKRS_lxLRc" alt="Issue #55" width="85%">
</p>

---

### Issue #56 (US09) - Falha Lógica na Validação de Presença
* **Problema:** O check-in era realizado apenas por clique, sem validação real de presença física.
* **Diagnóstico:** O modelo puramente *Client-Side* abria margem para fraudes sistêmicas de comparecimento.
* **Correção:** Exigência de um Código PIN (OTP) de 4 dígitos, gerado no sistema do orientador durante o encontro.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1NBT2kNXwUqnh7dINcVc5cMUBE3vfKNrr" alt="Issue #56" width="85%">
</p>

---

### Issue #57 (US11) - Limite de Caracteres Indefinido
* **Problema:** Ausência de limite máximo explícito de caracteres em campos de texto livre.
* **Diagnóstico:** Risco de erro no banco de dados e quebra visual do layout de UI em descrições longas.
* **Correção:** Estabelecido limite estrito de **500 caracteres** para resumos e **2000** para descrições.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1sEHY2eGyhqyZBX8JAu9wzPg7z182zC6P" alt="Issue #57" width="85%">
</p>

---

### Issue #58 (US06) - Ambiguidade em Fluxo de Edital
* **Problema:** Fluxo de aprovação não previa adequadamente o estado "Aguardando Revisão".
* **Diagnóstico:** Pular direto para "Aprovado" ignorava as regras de negócio das pró-reitorias.
* **Correção:** Status intermediário "Aguardando Revisão" adicionado como etapa obrigatória antes da publicação.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1g-a5CMATSLGj2K-yObwS2_WfJWEkQzk_" alt="Issue #58" width="85%">
</p>

---

### Issue #59 (US13) - Periodicidade de Relatórios
* **Problema:** Omissão das regras de agendamento na geração automática de relatórios pesados.
* **Diagnóstico:** Risco de sobrecarga do servidor durante horário comercial por requisições concorrentes.
* **Correção:** Padronizada a extração via processo assíncrono durante a madrugada para não degradar a performance.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1qjJU_9fJ915IupwrznZQlEcy0FEILIn4" alt="Issue #59" width="85%">
</p>

---

### Issue #60 (US16) - Ambiguidade em Zoom e Interatividade
* **Problema:** O requisito não definia o que era um elemento interativo nem o limite de zoom.
* **Diagnóstico:** Impossível realizar testes de QA sem parâmetros numéricos da WCAG.
* **Correção:** Interface deve suportar ampliação de até **200%** sem sobreposição ou perda de funcionalidade.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1-TQxWVI4zt95MXH6qNMNpAdQcHLjGWxF" alt="Issue #60" width="85%">
</p>

---

### Issue #61 (US15) - Omissão de Métricas de Acessibilidade
* **Problema:** Faltavam valores precisos para tamanho de fonte e taxa de contraste.
* **Diagnóstico:** Especificações subjetivas impedem adequação real.
* **Correção:** Fontes fixadas em unidades relativas (rem) e exigida taxa de contraste de **7:1**.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1aVmqWLVMhjMf3VERysDzqa2yilqC_bYv" alt="Issue #61" width="85%">
</p>

---

### Issue #62 (US10) - Ambiguidade no Parâmetro de Urgência
* **Problema:** A ordenação "mais urgente primeiro" não definia matematicamente a urgência.
* **Diagnóstico:** Subjetividade impede o desenvolvimento correto da query de banco de dados.
* **Correção:** Uma tarefa entra no status "Urgente" apenas se o prazo for **igual ou inferior a 48 horas**.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1BTRMD6ZNfQdW14DiRHCiDyOsQiUbiDtJ" alt="Issue #62" width="85%">
</p>

---

## 3. Problemas Reavaliados e Não Corrigidos

Abaixo consta a *issue* classificada como reavaliada. Após deliberação da equipe, a funcionalidade descrita se manterá inalterada para garantir a conformidade do produto.

### Issue #53 (US08) - Impossibilidade de Reativação de Projetos
* **Problema Apontado:** Falta de botão para "reativar" projetos que foram encerrados.
* **Justificativa para Não Correção:** A ausência é proposital para garantir a imutabilidade de registros acadêmicos e *compliance* de auditoria. Uma vez que o projeto vira histórico, os dados se tornam evidências inalteráveis.
* **Veredito:** Mantida a irreversibilidade por design. Defeito não corrigido.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1ThFCu7kSAs2ZZkt51WdYdMoQpKQMzfgK" alt="Issue #53" width="85%">
</p>

---

## 4. Impacto na Usabilidade (Heurísticas de Nielsen)

```mermaid
pie title Distribuição de Falhas de Usabilidade Prevenidas
    "Prevenção de Erros (H5)" : 4
    "Consistência e Padrões (H4)" : 4
    "Controle e Liberdade (H3)" : 2
    "Compatibilidade com o Mundo Real (H2)" : 2
    "Estética e Acessibilidade (H8)" : 1
    "Visibilidade do Status (H1)" : 1
