---

## 1. Enquadramento do Problema – Golden Circle

<img width="1920" height="1080" alt="Azul Turquesa" src="https://github.com/user-attachments/assets/fa609247-f095-46c6-adcb-28c7fa720f06" />

O Golden Circle ajuda a alinhar o propósito da equipe com a entrega final, garantindo que a solução resolva uma dor real.

### 1.1 Por quê? (Why?)
Acreditamos que a gestão da ciência e extensão na universidade não deve ser um fardo burocrático. Professores e alunos perdem tempo precioso com ferramentas genéricas e falta de centralização, o que prejudica a qualidade da pesquisa e o cumprimento de prazos institucionais.

### 1.2 Como? (How?)
Através de uma plataforma especializada que fala a "língua da UFAM", integrando templates nativos, automação de documentos e um feed inteligente de editais, tudo isso em um ambiente acessível e focado na produtividade acadêmica.

### 1.3 O quê? (What?)
O **E-Project**: um sistema PWA de gestão de projetos acadêmicos que centraliza o acompanhamento de PIBIC, PIBITI, PIBEX e Pós-Graduação em um único dashboard.

---

## 2. Exploração do Mercado

### 2.1 Análise SWOT

<img width="1920" height="1080" alt="Azul Turquesa (1)" src="https://github.com/user-attachments/assets/6c04e2c7-e067-4375-becc-1e0198204c43" />

| **Forças (Strengths)** | **Fraquezas (Weaknesses)** |
| :--- | :--- |
| - Especialização no fluxo da UFAM.<br>- Acessibilidade nativa.<br>- Templates pré-configurados. | - Dependência de alimentação manual de dados externos.<br>- Equipe de desenvolvimento reduzida. |
| **Oportunidades (Opportunities)** | **Ameaças (Threats)** |
| - Expansão para outras unidades acadêmicas.<br>- Possível integração futura via API com sistemas oficiais. | - Mudanças bruscas nos editais das pró-reitorias.<br>- Resistência cultural ao abandono de ferramentas genéricas (Excel/Trello). |

### 2.2 Identificações Visuais de Soluções Existentes

2.2.1  **Trello:** Interface de cartões genérica, exige configuração manual pesada para o contexto acadêmico.

 <img width="1905" height="944" alt="image" src="https://github.com/user-attachments/assets/5a8186a7-6111-4d3d-b84d-1e090af86f61" />


2.2.2  **Notion:** Extremamente flexível, mas com curva de aprendizado alta para usuários menos técnicos.

 <img width="1911" height="916" alt="image" src="https://github.com/user-attachments/assets/3096e69e-bc52-4e2d-b52b-cc87254675f5" />


2.2.3  **E-campus (UFAM):** Sistema oficial focado em protocolo, com interface datada e sem ferramentas de gestão de tarefas diárias.

<img width="1907" height="937" alt="image" src="https://github.com/user-attachments/assets/0785e50b-59ee-4458-a0e1-aacb09e58080" />



### 2.3 Quadro Comparativo de Soluções Existentes
| Critério | Trello | Notion | E-campus | E-Project |
| :--- | :--- | :--- | :--- | :--- |
| **Foco Acadêmico** | Baixo | Médio | Alto (Protocolo) | **Total (Gestão)** |
| **Templates UFAM** | Não | Não | Sim (Formulários) | **Sim (Automação)** |
| **Acessibilidade** | Média | Média | Baixa | **Alta** |
| **Gestão de Tarefas** | Alta | Alta | Nula | **Alta** |

---

## 3. Conhecendo o usuário – Personas Aprimoradas

Para garantir que o **E-Project** atenda às diversas necessidades de seus usuários, foram desenvolvidas três personas detalhadas, abrangendo aspectos de acessibilidade, o perfil do professor e o do aluno. Essas personas guiarão o desenvolvimento para criar uma plataforma inclusiva, eficiente e relevante.

### 3.1 Persona de Acessibilidade: Professor Victor Antunes

**Nome:** Victor Antunes
**Idade:** 45 anos
**Ocupação:** Professor Universitário e Orientador de Projetos (PIBIC, PACE)
**Perfil:** Victor é um professor dedicado com baixa visão. Ele utiliza ferramentas de acessibilidade, como zoom de tela e leitores de tela, para interagir com sistemas digitais. Sua principal preocupação é a clareza e a adaptabilidade das interfaces para que sua condição visual não comprometa sua produtividade acadêmica.

**Objetivos:**
*   Gerenciar e acompanhar múltiplos projetos de pesquisa e extensão de forma eficiente.
*   Avaliar relatórios e documentos com precisão, sem esforço visual excessivo.
*   Manter-se atualizado sobre editais, prazos e comunicações institucionais.
*   Colaborar com orientandos e colegas de forma acessível.

**Desafios:**
*   Interfaces de usuário com baixo contraste, fontes pequenas ou ilegíveis.
*   Navegação complexa ou que exige precisão visual (ex: menus suspensos pequenos).
*   Falta de compatibilidade com tecnologias assistivas (leitores de tela, lupas digitais).
*   Documentos e formulários não acessíveis que dificultam o preenchimento e a revisão.

**Necessidades:**
*   Interface com opções de alto contraste e tamanhos de fonte ajustáveis.
*   Suporte robusto para zoom de tela e navegação por teclado.
*   Compatibilidade total com leitores de tela, com elementos bem rotulados.
*   Feedback claro (visual e, se possível, auditivo) para ações e erros.
*   Relatórios e dashboards com informações estruturadas e legíveis, adaptáveis a diferentes níveis de zoom.

**Citação:** _"Minha paixão pela pesquisa é imensa, mas a burocracia e as ferramentas inacessíveis me exaurem. Preciso de uma plataforma que se adapte à minha visão, não o contrário, para que eu possa focar no que realmente importa: a ciência."_

<img width="514" height="720" alt="image" src="https://github.com/user-attachments/assets/5c5aa091-52c4-45ef-b5a7-71811d2ca11f" />

### 3.2 Persona de Professor: Dr. Carlos Mendonça

**Nome:** Dr. Carlos Mendonça
**Idade:** 52 anos
**Ocupação:** Pesquisador Produtividade e Orientador (12 orientandos)
**Perfil:** Dr. Carlos é um professor experiente e altamente produtivo, com uma grande carga de orientações em diversas modalidades (PIBIC, PIBITI, PIBEX, Pós-Graduação). Ele valoriza a eficiência e a capacidade de ter uma visão estratégica de todos os seus projetos, sem se perder em detalhes operacionais.

**Objetivos:**
*   Ter uma visão macro e atualizada do progresso de todos os seus orientandos e projetos.
*   Identificar rapidamente quais alunos estão atrasados ou precisam de atenção.
*   Gerenciar prazos de editais e entregas de forma centralizada.
*   Reduzir o tempo gasto com tarefas administrativas e burocráticas.
*   Garantir a qualidade e a conformidade dos relatórios e documentos.

**Desafios:**
*   Dificuldade em consolidar informações de múltiplos projetos e alunos, que muitas vezes utilizam ferramentas diferentes.
*   Perda de prazos importantes devido à falta de um sistema de alerta eficaz.
*   Excesso de e-mails e comunicações fragmentadas sobre o status dos projetos.
*   A necessidade de revisar manualmente muitos documentos antes da assinatura.

**Necessidades:**
*   Um dashboard intuitivo que apresente o status de todos os projetos e orientandos de forma clara.
*   Alertas e notificações personalizáveis para prazos e entregas pendentes.
*   Ferramentas de automação para a geração e revisão de documentos.
*   Um sistema que permita a visualização rápida de quem está atrasado e o que precisa ser feito.
*   Integração com sistemas institucionais para evitar a redigitação de dados.

**Citação:** _"Com tantos projetos e alunos, preciso de um copiloto digital que me dê a visão geral e me avise o que é crítico. Não quero saber de cada clique, mas sim se meus alunos estão no caminho certo e se os prazos serão cumpridos."_

<img width="752" height="868" alt="image" src="https://github.com/user-attachments/assets/1e979ae5-c7f8-4ff0-8fa9-e600a211119a" />

### 3.3 Persona de Aluno: Ana Beatriz

**Nome:** Ana Beatriz
**Idade:** 19 anos
**Ocupação:** Aluna de Iniciação Científica (Voluntária)
**Perfil:** Ana Beatriz é uma aluna engajada que concilia seus estudos e a iniciação científica voluntária com um estágio externo. Ela é organizada, mas sua rotina multitarefas exige que as ferramentas que utiliza sejam claras, diretas e a ajudem a priorizar suas atividades, evitando sobrecarga e esquecimento de prazos.

**Objetivos:**
*   Gerenciar suas tarefas e prazos da iniciação científica de forma simples e visual.
*   Receber notificações claras sobre entregas e reuniões.
*   Acessar materiais e templates de forma rápida e intuitiva.
*   Colaborar com seu orientador e colegas de pesquisa sem complicações.
*   Evitar a perda de informações importantes ou o esquecimento de tarefas.

**Desafios:**
*   Dificuldade em conciliar as demandas da pesquisa com outras atividades acadêmicas e profissionais.
*   Sistemas complexos ou com muitas funcionalidades desnecessárias que geram confusão.
*   Falta de um cronograma claro e de lembretes eficazes.
*   A necessidade de buscar informações em diferentes plataformas.

**Necessidades:**
*   Um cronograma visual e fácil de entender, com todas as tarefas e prazos da pesquisa.
*   Notificações personalizáveis e claras para lembretes de entregas e eventos.
*   Acesso rápido a templates de documentos e guias para a pesquisa.
*   Uma interface intuitiva e sem distrações, focada na produtividade.
*   Ferramentas de comunicação integradas para facilitar a interação com o orientador e a equipe.

**Citação:** _"Minha vida é uma correria! Preciso de algo que me ajude a organizar a pesquisa sem me dar mais trabalho. Um cronograma claro e lembretes na hora certa são essenciais para eu não me perder."_

<img width="785" height="878" alt="image" src="https://github.com/user-attachments/assets/044a297e-83bc-4afb-934a-450da4546ce6" />

---

## 4. Ideação

### 4.1 Importância do Brainstorming
O brainstorming foi fundamental para divergir ideias antes de convergir na solução final. Ele permitiu que a equipe identificasse que o problema não era apenas "onde guardar arquivos", mas sim "como ser lembrado do que fazer" no contexto específico da UFAM.

### 4.2 O que foi feito
Realizamos uma sessão de ideação utilizando o Notion, onde cada integrante trouxe 3 dores principais e 3 soluções possíveis. Utilizamos a técnica de votação silenciosa para priorizar as funcionalidades que trariam maior impacto imediato (MVP).

### 4.3 Resultados
O resultado foi a definição do **E-Project** como um PWA, priorizando o Dashboard do Orientador e o Feed de Editais como diferenciais competitivos. Decidimos focar na automação de documentos para reduzir a carga burocrática, que foi a dor mais votada durante a sessão.
