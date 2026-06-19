# 📄 Relatório Técnico: Auditoria e Resolução de Requisitos (QA Review)

**Projeto:** E-Project (Gestão de Projetos Acadêmicos)  
**Fase:** Trabalho Prático III - Consolidação de Inspeção e Refatoração de Backlog  
**Objetivo:** Estabelecer o rastreio rigoroso das não-conformidades apontadas na auditoria cruzada, documentando o *rationale* arquitetural e as ações de mitigação aplicadas ao repositório oficial da plataforma.

---

## 📊 1. Sumário Executivo de Qualidade

A tabela abaixo consolida as métricas de triagem da auditoria de requisitos, categorizando os apontamentos por domínio de impacto tecnológico e de negócios. A análise identificou oportunidades críticas de refatoração para garantir o *Definition of Ready* (DoR) antes da fase de desenvolvimento.

| Categoria do Defeito | Aceitos / Mitigados | Rejeitados (Falso Positivo) | Impacto Principal no Sistema |
| :--- | :---: | :---: | :--- |
| **Integridade e Lógica de Negócios** | 6 | 1 | Regras de transição de estado, consistência temporal e fluxos acadêmicos. |
| **Performance e Escalabilidade (RNF)** | 1 | 0 | SLAs de resposta e viabilização de testes de carga/estresse automatizados. |
| **Segurança e Prevenção de Fraudes** | 1 | 0 | Validação de sessões físicas (Check-in/Presença) com fatores síncronos. |
| **UI/UX e Acessibilidade (WCAG)** | 4 | 0 | Compatibilidade estrutural com tecnologias assistivas e responsividade. |
| **Rastreabilidade e Padrões Ágeis** | 3 | 2 | Dicionário de dados, padronização de nomenclatura e semântica de User Stories. |
| **Total Global** | **15** | **3** | - |

---

## 🟢 2. Matriz de Mitigação: Defeitos Aceitos e Refatorados

As seções a seguir detalham as correções arquiteturais e textuais aplicadas. Cada item justificado altera diretamente os Critérios de Aceite (CA) ou as Regras de Negócio (RN) do sistema.

### 2.1. Refatoração de Lógica de Negócios e Dicionário de Dados

A auditoria revelou inconsistências no ciclo de vida das entidades centrais. A mitigação focou em fechar brechas na *State Machine* (Máquina de Estados) e na integridade referencial temporal do banco de dados.

#### US03 - Cadastrar Projeto Acadêmico (Gerenciamento de Estados)
* **Análise Lógica (Omissão):** A transição para o estado "Ativo" exigia a presença de um aluno, mas a interface permitia o salvamento imediato. Sem um estado intermediário, a persistência geraria uma *Constraint Violation* no banco ou uma UI inconsistente. A implementação do estado transitório ("Rascunho") resolve a fricção de UX.

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Transição de Estado (RN)** | "Cada projeto deve ter pelo menos um aluno contratado para ser ativado." | "O sistema permite salvar projeto sem aluno vinculado, atribuindo status **'Rascunho' (Inativo)**. A transição para **'Em Andamento' (Ativo)** ocorre unicamente via *trigger* de vinculação de orientando." |

> **Evidência de Refatoração:** > ![Evidência US03](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 1: Implementação da regra de transição de status 'Rascunho' na US03.*

#### US04 - Criar Tarefas (Ciclo de Vida Kanban e Restrição Temporal)
* **Análise Lógica (Omissão):** A ausência do mapeamento completo do ciclo de vida das tarefas impediria a modelagem de *Enum Types* no banco de dados. Adicionalmente, mitigou-se uma falha de *Temporal Integrity* onde tarefas poderiam ter prazos fora da vigência do contrato do projeto.

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Estados Kanban (RN)** | Apenas o status "Pendente" era especificado. | Inserção do pipeline completo: **'A Fazer', 'Em Andamento', 'Em Revisão', 'Concluída' e 'Atrasada'**. |
| **Integridade Temporal (RN)** | Sem limite superior de data definido. | "O backend rejeitará o POST/PUT de tarefas cuja **data de entrega seja superior à data de encerramento** do projeto associado." |

> **Evidência de Refatoração:** > ![Evidência US04](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 2: Definição dos Enums de status e restrições de integridade temporal na US04.*

#### US10 - Tarefas Pendentes (Padronização e Algoritmo de Ordenação)
* **Análise Lógica (Ambiguidade/Inconsistência):** A métrica de "urgência" era subjetiva, impossibilitando a construção algorítmica da *query* (ex: `ORDER BY`). A nomenclatura "Instruções" foi refatorada para "Descrição" para garantir simetria com o Dicionário de Dados da US04.

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Algoritmo de Ordenação (RN)** | "ordenadas por prazo (mais urgente primeiro)" | "Ordenação via `data_vencimento ASC`. Tarefas **'Atrasadas'** recebem prioridade absoluta (*Pin to top*) com alerta visual crítico (#FF0000)." |
| **Semântica de Dados (CA)** | Acessar "instruções". | Acessar "descrição completa" (Alinhamento 1:1 com a modelagem da US04). |

> **Evidência de Refatoração:** > ![Evidência US10](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 3: Parametrização matemática do algoritmo de ordenação de tarefas na US10.*

#### US06 - Revisão de Entregas (Correção de Escopo Semântico)
* **Análise Lógica (Fato Incorreto):** O título original ("Aprovar Editais") causava uma severa desagregação de escopo (*Scope Creep*). O desalinhamento entre o título e a intenção da história corromperia a Rastreabilidade (Traceability Matrix).

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Título e Ação** | "US06 - Aprovar ou solicitar editais no feed..." | "US06 - Revisar e avaliar entregas de tarefas." |

> **Evidência de Refatoração:** > ![Evidência US06](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 4: Alinhamento de responsabilidade única (Single Responsibility) no título da US06.*

---

### 2.2. Perfomance, Infraestrutura e Limites de Fronteira

Requisitos sem métricas quantitativas ou sem limites de *payload* foram refatorados para viabilizar testes de integração, carga e proteção de infraestrutura.

#### US02 - Dashboard Central (SLA de Performance)
* **Análise Lógica (Ambiguidade):** Requisitos Não-Funcionais (RNF) com termos relativos ("boa conexão") são anti-padrões. É imperativo estipular *thresholds* quantitativos para viabilizar testes em esteiras de CI/CD (ex: Lighthouse/Jest).

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Threshold de Performance (CA)**| "carregar em menos de 3s em conexão de boa qualidade" | "O dashboard deve resolver todas as requisições em até **3 segundos** sob uma banda de rede estável **>= 10 Mbps**." |

> **Evidência de Refatoração:** > ![Evidência US02](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 5: Refinamento de RNF com métricas testáveis para automação de Quality Assurance.*

#### US11 - Mensagem Opcional (Prevenção de Sobrecarga - String Boundaries)
* **Análise Lógica (Omissão):** A ausência de *Boundary Analysis* em campos de texto permite *Payloads* massivos que podem causar *Buffer Overflow* na base de dados ou corrupção do layout (DOM).

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Limites (RN)** | "incluir uma mensagem opcional junto ao envio" | "O campo de mensagem (Input Text) será mapeado com restrição absoluta (Max-Length) de **500 caracteres**." |

> **Evidência de Refatoração:** > ![Evidência US11](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 6: Implementação de proteção de layout e limitação estrutural de payload.*

#### US05 e US12 - Definição de Escopo de MVP (Context Mapping)
* **Análise Lógica (Ambiguidade):** Integrações abertas ("principais pró-reitorias") e funcionalidades globais vagas ("configurar notificações") introduzem risco ao cronograma. A mitigação isolou o domínio estritamente para o Produto Mínimo Viável (MVP).

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Integração (US05)**| "principais pró-reitorias (PROPESP, PROEXT)..." | "Fetch de dados restrito exclusivamente e unicamente às APIs da **PROPESP e PROEXT**." |
| **Settings (US12)** | "configurar preferências de notificação" | "MVP: Chave booleana (*Toggle Global*) única no perfil para ativar/desativar todas as interrupções de push." |

> **Evidências de Refatoração:** > ![Evidência US05](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 7: Restrição de fronteira de integração a duas pró-reitorias na US05.* > ![Evidência US12](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 8: Simplificação de estado de configuração na US12.*

---

### 2.3. Autenticidade, Segurança e Acessibilidade (Compliance)

O sistema deve assegurar fé pública nos dados institucionais e conformidade absoluta com as normativas internacionais de acessibilidade na web.

#### US09 e US13 - Validação de Check-in (Mecanismo Antifraude)
* **Análise Lógica (Omissão Grave):** O registro de evento focado apenas no lado do cliente (*Client-Side Logging*) abria vetor para falsificação de presenças (*Spoofing*). O mecanismo evoluiu para uma validação síncrona em duas etapas (*Two-Step Verification*).

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Segurança (CA)**| "realizar check-in a partir do aplicativo" | "Presença validada via **Código PIN (OTP de 4 dígitos)** gerado dinamicamente no painel do orientador para validação síncrona pelo aluno em sala." |

> **Evidência de Refatoração:** > ![Evidência US09_13](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 9: Estruturação de token síncrono para garantia de fé pública e auditoria acadêmica.*

#### US07 - Declaração de Bolsista (Modelagem de Relatório)
* **Análise Lógica (Omissão):** Documentos acadêmicos são entidades nominais singulares. Agrupar dados de múltiplas instâncias em um único PDF corrompe a utilidade legal do documento.

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Data Binding (RN)**| "preenchidos com os dados do projeto cadastrado" | "Geração estritamente individual. O payload do PDF consumirá apenas os dados e o ID do usuário selecionado (relação 1:1)." |

> **Evidência de Refatoração:** > ![Evidência US07](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 10: Parametrização da geração de relatórios vinculando documento ao identificador único do usuário.*

#### US15 e US16 - Acessibilidade Visual (Diretrizes WCAG 2.1 AAA)
* **Análise Lógica (Ambiguidade):** Leis modernas de acessibilidade exigem valores exatos. O refinamento garantiu o cumprimento do protocolo internacional *Web Content Accessibility Guidelines* (WCAG).

| Atributo | Estado Anterior (Com Defeito) | Solução Aplicada (Repositório Atualizado) |
| :--- | :--- | :--- |
| **Escalas e Cores (US15)**| "3 níveis... opções de tema Alto Contraste." | "Scales: **100%, 125%, 150%**. Contraste AAA: BG **#000000**, Texto **#FFFF00 ou #FFFFFF**." |
| **Leitores (US16)** | "não depender exclusivamente de ícone..." | "Todo componente clicável exige propriedade **'aria-label'**. Operabilidade preservada em **zoom de 200%** sem sobreposição de blocos (*Reflow*)." |

> **Evidências de Refatoração:** > ![Evidência US15](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 11: Inclusão de metadados absolutos de CSS e HEX codes.* > ![Evidência US16](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 12: Definição de propriedades ARIA e responsividade limite.*

---

## 🛑 3. Resoluções Estratégicas: Falsos Positivos e Decisões de Domínio

A auditoria reportou falhas que, após análise cruzada entre a equipe de Engenharia e Produto, foram **rejeitadas** por colidirem com invariantes do domínio (Regras Institucionais da UFAM) ou com axiomas de Engenharia Ágil.

### 3.1. US08 - Acesso em "Somente Leitura" (Ambiguidade Apontada)
* **Análise do Apontamento:** A inspeção questionou se o termo "somente leitura" bloqueava o download de arquivos em projetos encerrados.
* **Justificativa Técnica (Rejeição com Adendo):** No ecossistema REST e em sistemas operacionais, o privilégio *Read-Only* refere-se à camada de mutação de dados (bloqueio de métodos `POST`, `PUT`, `DELETE`). A leitura (`GET`) compreende integralmente a extração de *Blobs/Files* para o disco local. O apontamento central é um falso positivo conceitual, porém, aplicamos um adendo pacificador (para mitigar dúvidas da equipe de Front-end).
* **Solução:** O defeito foi recusado, mas o texto recebeu a adição: *"mantendo liberada a visualização dos dados em tela e o download de todos os documentos previamente gerados."*

> **Documentação da Justificativa:** > ![Justificativa US08 - Leitura](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 13: Esclarecimento técnico sobre o comportamento de segurança Read-Only na Issue.*

### 3.2. US08 - Reativação de Projetos Históricos (Omissão Apontada)
* **Análise do Apontamento:** A inspeção reportou a falta de um fluxo sistêmico para "reativar projetos encerrados automaticamente".
* **Justificativa de Domínio - DDD (Rejeição Absoluta):** O projeto espelha o regulamento estrito das pró-reitorias. Editais possuem ciclos orçamentários fixos. O encerramento de um projeto é um **Estado Final Absoluto (Terminal State)**. Permitir *rollbacks* ou reativações no banco de dados abriria vulnerabilidades para pagamentos indevidos de bolsas, gerando Risco de Auditoria (*Compliance Risk*).
* **Solução:** Requisito firmemente rejeitado. Adicionada uma diretriz de segurança: *"Projetos no status Histórico são imutáveis e impossibilitados de reativação em qualquer circunstância."*

> **Documentação da Justificativa:** > ![Justificativa US08 - Reativação](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 14: Rejeição estruturada fundamentada nas regras de governança acadêmica.*

### 3.3. US06 - Formato do Enunciado (Omissão Apontada)
* **Análise do Apontamento:** A inspeção considerou defeito o fato de a narrativa "não descrever de que maneira a necessidade seria atendida".
* **Justificativa Metodológica Ágil (Rejeição Absoluta):** O apontamento fere a fundação metodológica do *Behavior-Driven Development* (BDD) e do padrão Connextra (*As a... I want... So that...*). A narrativa primária de uma User Story foca unicamente na percepção de valor do usuário e **nunca em especificações de arquitetura, fluxos de interface ou soluções algorítmicas**. Exigir o "como" na narrativa quebra a independência do *Backlog*. Os fluxos residem nos Critérios de Aceite.
* **Solução:** Defeito rejeitado. O enunciado permaneceu intocado, provando a maturidade metodológica da especificação original.

> **Documentação da Justificativa:** > ![Justificativa US06 - Enunciado](COLE_AQUI_A_URL_DO_DRIVE)  
> *Figura 15: Defesa teórica embasada no Manifesto Ágil e boas práticas de Engenharia de Requisitos registrada na Issue.*
