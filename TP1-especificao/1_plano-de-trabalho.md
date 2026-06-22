# Plano de Trabalho - E-Project

## HISTÓRICO DE VERSÕES

| Campo | Descrição |
| :--- | :--- |
|Nome do Projeto:| E-Project | 
|Versão | 1.0 | 
|Status: |Em desenvolvimento| 
|Executor Principal: | Jean Carlos dos Santos Baraúna | 
|Coordenador do Projeto:|Prof. Andrey Antonio de Oliveira Rodrigues| 

---

## 1. INTRODUÇÃO

### 1.1 Objeto
O objeto deste projeto é o desenvolvimento do **E-Project**, uma plataforma web multiplataforma (PWA) voltada para a gestão centralizada de projetos acadêmicos na Universidade Federal do Amazonas (UFAM). O sistema visa integrar o acompanhamento de diversas modalidades de pesquisa e extensão, como PIBIC, PIBITI, PIBEX, PACE e Pós-Graduação.

### 1.2 Motivação, Justificativa e Oportunidade
A motivação surge da dificuldade enfrentada por professores orientadores em gerir múltiplos projetos simultaneamente após a fase de submissão oficial. Atualmente, os sistemas institucionais (E-campus e SEI) focam apenas no protocolo, deixando uma lacuna no acompanhamento diário das atividades. A justificativa reside na necessidade de eliminar o retrabalho e a fragmentação de dados em ferramentas genéricas. A oportunidade identifica-se na ausência de uma solução dedicada que utilize a terminologia e os fluxos específicos da UFAM.

### 1.3 Caracterização do Projeto

#### 1.3.1 Classe
O projeto classifica-se como um **Software de Gestão de Projetos (Project Management Software)** com foco no nicho acadêmico e institucional.

#### 1.3.2 Enquadrabilidade
Enquadra-se como uma ferramenta de **Produtividade e Colaboração Acadêmica**, operando como uma camada de gestão sobre os processos administrativos já existentes na universidade.

---

## 2. INFORMAÇÕES GERAIS

### 2.1 Escopo Geral
O sistema permitirá o cadastro de projetos, atribuição de tarefas, controle de prazos, gestão de documentos e centralização de editais.

#### 2.1.1 Escopo Específico
*   Dashboard unificado para orientadores.
*   Sistema de gestão de tarefas (Kanban/Lista) para orientandos.
*   Feed automatizado de editais das pró-reitorias (PROPESP/PROEXT).
*   Geração automática de relatórios e declarações em PDF.
*   Registro de presença (check-in) em reuniões.

#### 2.1.2 Escopo Negativo
*   O sistema **não** realizará a submissão oficial de projetos nos portais da UFAM (E-campus/SEI).
*   **Não** realizará o pagamento de bolsas ou gestão financeira direta de recursos da união.
*   **Não** substituirá os canais oficiais de protocolo da universidade.

### 2.2 Ambiente de Desenvolvimento
*   **Linguagens:** JavaScript/TypeScript.
*   **Framework Front-end:** React.js.
*   **Back-end/Banco de Dados:** Node.js com Firebase ou Supabase.
*   **Hospedagem:** Vercel ou Netlify.
*   **Versionamento:** GitHub.

### 2.3 Características Inovadoras do Projeto
A principal inovação é a **especialização contextual**. Diferente de ferramentas genéricas, o E-Project nasce com os templates, prazos e fluxos nativos da UFAM, além de oferecer acessibilidade nativa (alto contraste e modo de foco) pensada para o ambiente acadêmico diverso.

### 2.4 Resultados Esperados
Espera-se uma redução no tempo gasto em tarefas administrativas pelos orientadores, maior clareza para os bolsistas quanto às suas obrigações e uma centralização histórica da produção científica de cada laboratório ou grupo de pesquisa.

---

## 3. METODOLOGIA DE PROJETO

### 3.1 Estrutura do Projeto
O projeto será conduzido utilizando a metodologia ágil **Scrum**, organizada em Sprints semanais. A estrutura de documentação seguirá o padrão de Design Thinking (Inspiração e Ideação) seguido pela especificação técnica e implementação incremental.

### 3.2 Equipe de Projeto: Papéis e Responsabilidades
| Integrante | Papel | Responsabilidades |
| :--- | :--- | :--- |
| [Jean Carlos] | Scrum Master | Garantir a aplicação do método ágil e remover impedimentos. |
| [Ricky Brendon] | Product Owner | Definir prioridades do backlog. |
| [Luzineia] | Desenvolvedor Front-end | Implementar a interface PWA e acessibilidade. |
| [Pedro] | Designer UX/UI | Criar protótipos e garantir a usabilidade. |
| [Gustavo Souza] | Analista de QA | Realizar testes e garantir a qualidade da documentação. |

---

## 4. DESPESAS

### 4.1 Dispêndios

#### 4.1.1 Equipamentos e Programa de Computador
*   Uso de equipamentos dedicados (Notebooks).
*   Softwares de código aberto e camadas gratuitas (Free Tier) de serviços cloud.
*   **Custo Estimado:** R$9,000.

#### 4.1.2 Plano do Figema Interprise
* Acesso Full 
* Áreas de trabalho de equipe personalizadas
* Temas de design system e APIs
* Gestão de acessos SCIM
* US$ 90/mês cerca de R$ 447,561


#### 4.1.3 Treinamento
*   Treinamento via documentação oficial das tecnologias e cursos gratuitos.
*   **Custo Estimado:** R$ 500,0.

### 4.2 Resumo Financeiro e Valor Total
* O projeto será desenvolvido com custo financeiro direto mínimo, aproveitando recursos já disponíveis e ferramentas gratuitas para estudantes.
*   **Valor Total Estimado:**  R$ 9947,561 (Custo simbólico de materiais).
