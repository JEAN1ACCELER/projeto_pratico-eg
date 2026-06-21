# 📄 Relatório de Inspeção e Refatoração de Requisitos

**Projeto:** E-Project (Gestão de Projetos Acadêmicos)
**Fase:** Trabalho Prático III - Consolidação de Inspeção e Refatoração de Backlog

## Objetivo
Este documento apresenta os resultados da auditoria cruzada (inspeção) realizada no repositório do projeto. O objetivo é detalhar as *Issues* geradas, avaliando-as isoladamente. Indicamos claramente quais problemas foram corrigidos, não corrigidos ou reavaliados, acompanhados de suas devidas justificativas técnicas, garantindo a integridade e qualidade do Backlog.

> **Nota sobre o Custo da Qualidade:** A equipe adotou a premissa de que identificar e corrigir defeitos na fase de requisitos é até 100x mais barato do que mitigá-los após o código estar em produção. Este relatório é, portanto, uma estratégia preventiva de economia e eficiência operacional.

---

## 1. Relação de Issues Criadas no GitHub

> **📌 Nota ao Avaliador:** A coluna **Severidade** indica o impacto potencial do defeito no negócio ou na experiência do usuário. Clique no número da Issue para acessá-la no GitHub.

| Issue | História de Usuário (US) | Severidade | Status |
| :---: | :--- | :---: | :---: |
| **[#48](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/48)** | US05 - Editais (Feed) | Média | 🟢 Corrigido |
| **[#49](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/49)** | US04 - Tarefas | Alta | 🟢 Corrigido |
| **[#50](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/50)** | US03 - Cadastrar Projeto | Média | 🟢 Corrigido |
| **[#51](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/51)** | US02 - Painel Central | Média | 🟢 Corrigido |
| **[#52](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/52)** | US08 - Leitura/Download | Média | 🟢 Corrigido |
| **[#53](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/53)** | US08 - Reativação | Média | 🔴 Não Corrigido |
| **[#54](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/54)** | US07 - Documentos | Baixa | 🟢 Corrigido |
| **[#55](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/55)** | US12 - Notificações | Baixa | 🟢 Corrigido |
| **[#56](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/56)** | US09 - Check-in (PIN) | Crítica | 🟢 Corrigido |
| **[#57](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/57)** | US11 - Limite caracteres | Baixa | 🟢 Corrigido |
| **[#58](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/58)** | US06 - Aprovar Editais | Alta | 🟢 Corrigido |
| **[#60](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/60)** | US16 - Navegabilidade | Alta | 🟢 Corrigido |
| **[#61](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/61)** | US15 - Acessibilidade | Alta | 🟢 Corrigido |
| **[#62](https://github.com/JEAN1ACCELER/projeto_pratico-eg/issues/62)** | US10 - Tarefas Urgentes | Alta | 🟢 Corrigido |

---

## 2. Problemas Pertinentes (Aceitos e Corrigidos)

### Issue #60 (US16) - Ambiguidade em Zoom e Interatividade
* **Problema:** Falta de definição de elementos interativos e limite de zoom.
* **Diagnóstico:** Dificuldade para testes de QA sem critérios da WCAG.
* **Correção:** Interface deve suportar 200% de zoom sem quebra de layout.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1-TQxWVI4zt95MXH6qNMNpAdQcHLjGWxF" alt="Issue #60" width="85%">
  <br><em>Legenda: Registro da Issue #60 evidenciando a correção de acessibilidade.</em>
</p>

---

### Issue #61 (US15) - Omissão de Métricas de Acessibilidade
* **Problema:** Falta de valores para fontes e contraste.
* **Diagnóstico:** Especificações subjetivas impedem adequação real.
* **Correção:** Fontes em unidades relativas e contraste 7:1.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1aVmqWLVMhjMf3VERysDzqa2yilqC_bYv" alt="Issue #61" width="85%">
  <br><em>Legenda: Registro da Issue #61 comprovando métricas de contraste.</em>
</p>

---

### Issue #62 (US10) - Ambiguidade no Parâmetro de Urgência
* **Problema:** Falta de definição matemática para "urgente".
* **Diagnóstico:** Subjetividade impede ordenação algorítmica.
* **Correção:** Tarefas vencendo em até 48h são marcadas como urgentes.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1BTRMD6ZNfQdW14DiRHCiDyOsQiUbiDtJ" alt="Issue #62" width="85%">
  <br><em>Legenda: Registro da Issue #62, documentando nova regra de urgência.</em>
</p>

---

### Issue #56 (US09) - Falha na Validação de Presença
* **Problema:** Check-in via clique, sem prova de presença.
* **Diagnóstico:** Risco de fraude sistêmica.
* **Correção:** Validação por PIN de 4 dígitos.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1NBT2kNXwUqnh7dINcVc5cMUBE3vfKNrr" alt="Issue #56" width="85%">
  <br><em>Legenda: Registro da Issue #56, demonstrando o novo fluxo PIN.</em>
</p>

---

### Issue #49 (US04) - Restrição de Prazo
* **Problema:** Omissão de limite de data final.
* **Diagnóstico:** Possibilidade de tarefas pós-encerramento do projeto.
* **Correção:** Data máxima da tarefa limitada à data final do projeto.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1Kb9K9eL7IiTJ_X7uSWtae01XkrMRog1R" alt="Issue #49" width="85%">
  <br><em>Legenda: Registro da Issue #49, indicando a adição de travas de data.</em>
</p>

---

### Issue #50 (US03) - Estado de Rascunho
* **Problema:** Falta de estado para projetos incompletos.
* **Diagnóstico:** Impede fluxo de trabalho progressivo.
* **Correção:** Criação do status 'Rascunho'.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1lZuSv1ulKOI84coiHlm43YTwvrjhOpJb" alt="Issue #50" width="85%">
  <br><em>Legenda: Registro da Issue #50, evidenciando o status 'Rascunho'.</em>
</p>

---

### Issue #51 (US02) - SLA de Desempenho
* **Problema:** Termo subjetivo "carregar rápido".
* **Diagnóstico:** Falta de testabilidade técnica.
* **Correção:** SLA de 3 segundos para carregamento.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1qobrC2woz1sE8G8dffYSZ7llv0YLxT5I" alt="Issue #51" width="85%">
  <br><em>Legenda: Registro da Issue #51, comprovando fixação de SLA.</em>
</p>

---

### Issue #48 (US05) - Escopo de Integração
* **Problema:** Termos genéricos ("principais pró-reitorias").
* **Diagnóstico:** *Scope Creep* (inchaço de escopo).
* **Correção:** Delimitação para APIs da PROPESP e PROEXT.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1T5U12irneTax8bb1AB4Xxs1rve6ceckL" alt="Issue #48" width="85%">
  <br><em>Legenda: Registro da Issue #48, delimitando APIs.</em>
</p>

---

### Issue #52 (US08) - Leitura x Download
* **Problema:** Ambiguidade entre "somente leitura" e download.
* **Diagnóstico:** Confusão de privilégios de acesso.
* **Correção:** Download explícito permitido em modo leitura.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1BS_W2BmPZ4g8VGzas3W2IjQE0BReGrhi" alt="Issue #52" width="85%">
  <br><em>Legenda: Registro da Issue #52, esclarecendo permissões.</em>
</p>

---

## 3. Problemas Reavaliados e Não Corrigidos

### Issue #53 (US08) - Impossibilidade de Reativação de Projetos
* **Problema:** Falta de botão para reativação.
* **Justificativa:** Decisão proposital para garantir a imutabilidade e *compliance* de auditoria acadêmica.
* **Veredito:** Mantida irreversibilidade. Defeito não corrigido.

<p align="center">
  <strong>📸 Evidência da Imagem:</strong><br><br>
  <img src="https://drive.google.com/uc?export=view&id=1ThFCu7kSAs2ZZkt51WdYdMoQpKQMzfgK" alt="Issue #53" width="85%">
  <br><em>Legenda: Registro da Issue #53, mantendo a regra de design.</em>
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
