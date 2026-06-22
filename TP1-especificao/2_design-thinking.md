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

### 3.4 Comparativo de Necessidades e Desafios das Personas

Abaixo, apresentamos um comparativo visual e tabular das principais necessidades e desafios de cada persona, destacando as áreas de maior importância para cada perfil.

#### Gráfico Comparativo de Necessidades

<img src="/home/ubuntu/projeto_pratico-eg/especificacao/comparativo_personas.png" alt="Gráfico Comparativo de Necessidades por Persona" />

#### Tabela Comparativa de Necessidades e Desafios

| Característica | Victor Antunes (Acessibilidade) | Dr. Carlos Mendonça (Professor) | Ana Beatriz (Aluno) |
| :------------- | :----------------------------- | :------------------------------ | :------------------ |
| **Foco Principal** | Acessibilidade e usabilidade | Visão estratégica e eficiência | Organização e clareza |
| **Necessidades Chave** | Interface adaptável, suporte a tecnologias assistivas, feedback claro, relatórios legíveis. | Dashboard intuitivo, alertas personalizáveis, automação de documentos, integração institucional. | Cronograma visual, notificações claras, acesso rápido a templates, interface sem distrações. |
| **Desafios Principais** | Interfaces inacessíveis, navegação complexa, falta de compatibilidade com TA, documentos não acessíveis. | Consolidação de informações, perda de prazos, comunicação fragmentada, revisão manual de documentos. | Conciliação de demandas, sistemas complexos, falta de cronograma e lembretes eficazes, busca de informações em várias plataformas. |
| **Citação Resumo** | "Preciso de uma plataforma que se adapte à minha visão, não o contrário." | "Preciso de um copiloto digital que me dê a visão geral e me avise o que é crítico." | "Preciso de algo que me ajude a organizar a pesquisa sem me dar mais trabalho." |

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

### 3.2 Persona do Administrador / Coordenador: Dr. Carlos Mendonça

**Nome:** Dr. Carlos Mendonça  
**Idade:** 52 anos  
**Ocupação:** Coordenador de Pesquisa e Administrador do Sistema  
**Perfil:** Dr. Carlos atua na coordenação de pesquisa da instituição, sendo o responsável pelo gerenciamento de programas como PIBIC, PIBITI e PIBEX. Como administrador da plataforma E-Project, ele exerce o "comando geral" técnico e gerencial. Ele valoriza a segurança, a organização dos dados institucionais e a eficiência na publicação de editais e no controle de acessos de professores e alunos.

**Objetivos:**
* Gerenciar o status das contas de usuários (ativar, desativar, redefinir senhas e gerenciar permissões).
* Publicar, atualizar e encerrar editais das pró-reitorias de forma centralizada para que apareçam no feed dos professores.
* Ter uma visão macro e acessar relatórios gerenciais sobre a quantidade de projetos ativos e o uso global da plataforma.
* Garantir a segurança, a auditoria básica e a integridade das informações no sistema.

**Desafios:**
* Lidar com um grande volume de contas de usuários e requisições de suporte para acesso.
* Garantir que os prazos e regras dos novos editais institucionais sejam comunicados de forma imediata e sem falhas.
* Dificuldade em auditar e monitorar o status global das atividades de pesquisa sem um painel centralizado.

**Necessidades:**
* Um painel de controle (dashboard administrativo) exclusivo para gestão de usuários, papéis e permissões.
* Interface dedicada e ágil para criação, edição e disparo de editais que alimentarão o sistema.
* Acesso a logs básicos e relatórios consolidados de uso da plataforma para prestação de contas à instituição.
* Integração segura que permita validar se os usuários pertencem à comunidade acadêmica.

**Citação:** 
> "Como coordenador, preciso garantir que a plataforma seja o ambiente seguro e oficial da nossa pesquisa. Meu foco é gerenciar os acessos e manter os editais sempre atualizados para que os professores e alunos não tenham dores de cabeça com a burocracia."
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
