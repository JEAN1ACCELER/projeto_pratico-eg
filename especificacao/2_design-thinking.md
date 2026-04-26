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

 <img width="1911" height="916" alt="image" src="https://github.com/user-attachments/assets/3096e69e-bc58-4e2d-b52b-cc87254675f5" />


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

## 3. Conhecendo o usuário – Persona

### 3.1 Persona de Professor (Acessibilidade)
**Nome:** Victor Antunes, 45 anos.
**Perfil:** Professor com baixa visão.
**Necessidade:** Como ele orienta projetos (como PIBIC e PACE) e avalia entregas constantes, precisa que a tela de análise de relatórios seja totalmente responsiva ao zoom de tela.

### 3.2 Persona de Voluntário
**Nome:** Ana Beatriz, 19 anos.
**Perfil:** Aluna voluntária de iniciação científica.
**Necessidade:** Diferente dos bolsistas, Ana Beatriz concilia a pesquisa com um estágio externo. Ela precisa de notificações claras e um cronograma simples para não se perder nas entregas, já que não possui a mesma carga horária dedicada dos bolsistas.

### 3.3 Persona de Suporte 
**Nome:** Eduardo, 28 anos.
**Perfil:** Monitor de laboratório ou suporte técnico.
**Necessidade:** Responsável por auxiliar professores e alunos no uso de novas ferramentas. Precisa de um sistema estável, com documentação clara e que minimize chamados de erro por complexidade de interface.

### 3.4 Professor Orirntador
**Nome:** Dr. Carlos Mendonça, 52 anos.
**Perfil:** Pesquisador Produtividade com 12 orientandos.
**Necessidade:** Visão macro de todos os projetos. Ele não quer saber os detalhes de cada clique, mas sim quem está atrasado, quais editais abriram e se os relatórios parciais já foram revisados para assinatura.

---

## 4. Ideação

### 4.1 Importância do Brainstorming
O brainstorming foi fundamental para divergir ideias antes de convergir na solução final. Ele permitiu que a equipe identificasse que o problema não era apenas "onde guardar arquivos", mas sim "como ser lembrado do que fazer" no contexto específico da UFAM.

### 4.2 O que foi feito
Realizamos uma sessão de ideação utilizando o Notion, onde cada integrante trouxe 3 dores principais e 3 soluções possíveis. Utilizamos a técnica de votação silenciosa para priorizar as funcionalidades que trariam maior impacto imediato (MVP).

### 4.3 Resultados
O resultado foi a definição do **E-Project** como um PWA, priorizando o Dashboard do Orientador e o Feed de Editais como diferenciais competitivos. Decidimos focar na automação de documentos para reduzir a carga burocrática, que foi a dor mais votada durante a sessão.
