# 1. Descrição do Padrão Arquitetural

## 1.1 Apresentação

O padrão arquitetural selecionado para o **E-Project** é a **Arquitetura em Camadas (Layered Architecture)**, complementado pelo padrão **MVC (Model-View-Controller)** nas camadas de Apresentação e Aplicação.

Conforme definido no material de referência (Seção 7.2), a Arquitetura em Camadas organiza as classes em módulos de maior tamanho chamados *camadas*, dispostas hierarquicamente, onde uma camada somente pode utilizar serviços da camada imediatamente inferior. Essa abordagem permite particionar a complexidade do sistema, disciplinar as dependências e facilitar a manutenção e evolução da aplicação.

O padrão **MVC** (Seção 7.3), por sua vez, separa a aplicação em três grupos:

- **Model (Modelo):** representa os dados e a lógica de negócio.
- **View (Visão):** responsável pela interface com o usuário.
- **Controller (Controlador):** gerencia os eventos e a comunicação entre Modelo e Visão.

Essa separação garante que o modelo não possua dependências da interface gráfica, promovendo maior desacoplamento e reutilização.

## 1.2 Domínio

O domínio de aplicação do **E-Project** é a gestão de projetos acadêmicos da **Universidade Federal do Amazonas (UFAM)**.

O sistema contempla múltiplos perfis de usuários, incluindo:

- Professores orientadores;
- Estudantes bolsistas;
- Administradores do sistema.

Além disso, suporta diferentes modalidades de pesquisa, como:

- PIBIC;
- PIBITI;
- PIBEX;
- PACE;
- Pós-Graduação.

Entre as principais funcionalidades do sistema estão:

- Gestão de projetos;
- Controle de tarefas;
- Gerenciamento de documentos;
- Controle de prazos;
- Administração de editais;
- Emissão de relatórios acadêmicos.

# 2. Justificativa da Escolha

## 2.1 Escalabilidade e Manutenção

A Arquitetura em Camadas garante escalabilidade porque cada camada pode ser dimensionada independentemente.

### Exemplos

- A camada de **Apresentação (React PWA)** pode ser replicada para atender milhares de usuários simultaneamente.
- A camada de **Aplicação (Node.js/Express)** pode ser escalada horizontalmente por meio de balanceadores de carga.
- A camada de **Infraestrutura (PostgreSQL e Firebase Auth)** pode ser otimizada separadamente de acordo com a demanda.

A manutenção também é favorecida pela disciplina de dependências, uma vez que cada camada se comunica apenas com a camada imediatamente inferior.

Dessa forma, torna-se possível substituir implementações específicas sem afetar as demais partes do sistema. Por exemplo, seria possível migrar a autenticação do Firebase para o Supabase com impactos mínimos nas camadas superiores.

## 2.2 Testabilidade

Conforme destacado na Seção 7.3 sobre MVC:

> "MVC favorece testabilidade. É mais fácil testar objetos não-visuais, isto é, não relacionados com a implementação de interfaces gráficas."

No **E-Project**, essa característica é aplicada da seguinte forma:

### Camada de Domínio (Modelo)

Contém as regras de negócio, tais como:

- Validação de notas;
- Controle de prazos;
- Regras de submissão de documentos.

Essas funcionalidades podem ser testadas por meio de testes unitários sem dependência de banco de dados ou interface gráfica.

### Camada de Aplicação (Controladores)

Pode ser validada utilizando testes de integração com uso de *mocks* das camadas inferiores.

### Camada de Apresentação (Visão)

Pode ser testada utilizando ferramentas como:

- React Testing Library;
- Jest.

Esses testes simulam interações reais dos usuários com a interface.

## 2.3 Independência de Frameworks e Interface

O material de referência (Seção 7.3) afirma que:

> "Objetos de domínio não incluem código visual, mas apenas lógica de negócios."

Essa característica garante independência de frameworks e tecnologias de interface.

### Aplicação no E-Project

- A camada de **Domínio** não possui dependência de React, Express ou qualquer outro framework.
- A lógica de negócio é implementada em classes TypeScript independentes.
- A camada de **Infraestrutura** encapsula os mecanismos de persistência por meio de repositórios.
- A camada de **Apresentação** pode ser substituída sem afetar a lógica de negócio.

Por exemplo, seria possível migrar a aplicação de uma **React PWA** para um aplicativo móvel em **React Native** sem alterações significativas no domínio do sistema.

Essa abordagem segue o princípio destacado por Fowler e Beck:

> "O coração e a parte mais preciosa de MVC está na separação entre código de interface com o usuário e a lógica do domínio."

### 2.5 Fundamentação Teórica Adicional

Para reforçar a escolha dos padrões adotados, apresentam-se as seguintes citações e justificativas baseadas em referências consolidadas:

#### Padrão MVC

> "A utilização do padrão MVC traz como benefício isolar as regras de negócios da lógica de apresentação, a interface com o usuário. Isto possibilita a existência de várias interfaces com o usuário que podem ser modificadas sem que haja a necessidade da alteração das regras de negócios, proporcionando assim muito mais flexibilidade e oportunidades de reuso das classes." [1]

**Por que usar:** O isolamento promovido pelo MVC é fundamental para que o **E-Project** possa evoluir sua interface (ex: migrar de React para outra tecnologia) sem impactar o núcleo de regras de negócio, maximizando o reaproveitamento de código.

> "O padrão de arquitetura MVC determina a organização do software em 3 camadas: Model (manipulação dos dados), View (interação do usuário) e Controller (controle entre Model e View). É uma boa forma de organizar as responsabilidades através do uso de camadas." [2]

**Por que usar:** A organização clara de responsabilidades facilita a colaboração entre desenvolvedores de frontend e backend, garantindo que cada componente do sistema tenha um propósito bem definido e limitado.

#### Arquitetura em Camadas

> "Uma arquitetura em camadas particiona a complexidade envolvida no desenvolvimento de um sistema em componentes menores (as camadas). Como uma segunda vantagem, ela disciplina as dependências entre essas camadas. Isso ajuda no entendimento, manutenção e evolução de um sistema." [3]

**Por que usar:** O particionamento da complexidade é essencial para um sistema de gestão acadêmica como o **E-Project**, que lida com múltiplos perfis e modalidades. Disciplinar as dependências evita o "código espaguete" e torna a manutenção previsível e segura.

---
**Referências:**
1. [DevMedia - Padrão MVC](https://www.devmedia.com.br/padrao-mvc-java-magazine/21995)
2. [Guia.dev - Camadas e Padrões de Arquitetura](https://guia.dev/pt/pillars/software-architecture/layers-and-architecture-patterns.html)
3. [Engenharia de Software Moderna - Arquitetura em Camadas](https://engsoftmoderna.info/cap7.html)

## 2.4 Atendimento aos Requisitos Não Funcionais

| Requisito Não Funcional | Como a Arquitetura Atende |
|-------------------------|---------------------------|
| **Multiplataforma (PWA)** | A camada de Apresentação em React permite gerar uma PWA que roda em qualquer dispositivo com navegador. |
| **Desempenho** | A separação de camadas permite caching em cada nível (CDN para frontend, Redis para backend). |
| **Segurança** | A camada de Aplicação centraliza autenticação (Firebase Auth) e autorização, isolando regras de acesso. |
| **Disponibilidade** | Camadas independentes permitem arquitetura de alta disponibilidade (ex.: múltiplas instâncias do backend). |
| **Manutenibilidade** | Dependências disciplinadas e separação de responsabilidades facilitam a correção de bugs e a evolução do sistema. |

# 3. Aplicação no Sistema

## 3.1 Mapeamento do Projeto

| Camada (Arquitetura em Camadas) | Componente MVC | Tecnologia |
|----------------------------------|---------------|------------|
| **Apresentação** | View + Controller (parcial) | React + Redux/Context API |
| **Aplicação** | Controller + Service | Node.js/Express |
| **Domínio** | Model | Classes TypeScript |
| **Infraestrutura** | Repository | PostgreSQL, Firebase Auth, Prisma TypeORM |

## 3.2 Aplicação na Camada de Apresentação

Na camada de **Apresentação** do E-Project, o padrão **MVC** é adaptado para o ecossistema React, separando interface, gerenciamento de estado e tratamento de eventos.

### View (Interface)

As *Views* são implementadas por meio de componentes React funcionais responsáveis pela exibição das informações ao usuário. Entre as principais interfaces do sistema destacam-se:

- Dashboard do orientador, contendo cards com projetos ativos e indicadores de acompanhamento;
- Quadro Kanban de tarefas, organizado nas colunas:
  - A Fazer;
  - Em Andamento;
  - Concluído;
- Feed de editais com filtros e mecanismos de busca;
- Formulários para lançamento de notas, frequência e relatórios acadêmicos.

### Model (Estado da Aplicação)

O papel de *Model* é representado pelo gerenciamento de estado da aplicação utilizando **Redux** ou **Context API**.

Os principais dados mantidos no estado incluem:

- Informações de autenticação:
  - Usuário logado;
  - Perfil de acesso;
  - Permissões;
- Lista de projetos vinculados ao usuário;
- Lista de tarefas e atividades;
- Filtros, ordenações e preferências de visualização.

### Controller (Tratamento de Eventos)

O papel de *Controller* é implementado por funções manipuladoras de eventos (*event handlers*), responsáveis por receber as ações do usuário e coordenar atualizações de estado ou comunicação com o backend.

Exemplos:

| Evento | Ação Executada |
|----------|--------------|
| Clique no botão **Adicionar Tarefa** | Dispara uma action para atualizar o estado global da aplicação |
| Alteração do filtro de editais | Atualiza o estado e provoca a re-renderização da interface |
| Envio do formulário de presença | Realiza uma requisição HTTP para a API backend |
| Atualização do status de uma tarefa no Kanban | Envia a alteração para o backend e sincroniza o estado local |
| Login do usuário | Solicita autenticação à API e atualiza o estado de sessão |

Essa adaptação do MVC ao React mantém a separação de responsabilidades entre interface, lógica de interação e dados da aplicação, favorecendo manutenção, reutilização de componentes e testabilidade do sistema.

## 3.3 Fluxo de Funcionalidade: US01 – Cadastrar Projeto

*Adaptado do escopo: "cadastro de projetos, atribuição de tarefas, controle de prazos".*

| Passo | Componente | Ação | Camada |
|--------|------------|--------|---------|
| **1** | **View (React)** | Professor acessa o formulário `/projects/new` e preenche os dados do projeto, incluindo título, modalidade (PIBIC, PIBITI, PIBEX, PACE ou Pós-Graduação), data de término e bolsista associado. | Apresentação |
| **2** | **Controller (React Handler)** | Ao clicar em **Salvar**, o manipulador de eventos coleta os dados do formulário e realiza uma chamada HTTP para `api.post('/projects', data)`. | Apresentação |
| **3** | **Controller (Express)** | A rota `POST /projects` recebe a requisição e valida o token JWT fornecido pelo serviço de autenticação. | Aplicação |
| **4** | **Service (Express)** | O controlador aciona o método `ProjectService.createProject(data)`, responsável por aplicar as regras de negócio e validar os dados recebidos. | Aplicação |
| **5** | **Model (Domínio)** | A entidade `Project` é instanciada e executa validações de domínio, como título obrigatório, modalidade válida e data de término posterior à data atual. | Domínio |
| **6** | **Repository (Infraestrutura)** | O repositório `ProjectRepository.save(project)` persiste os dados do projeto no banco PostgreSQL. | Infraestrutura |
| **7** | **Response (Controller → View)** | O backend retorna a resposta **201 Created** com o identificador do projeto. A interface exibe uma mensagem de sucesso e redireciona o usuário para o dashboard. | Apresentação |

### Descrição do Fluxo

O caso de uso **US01 – Cadastrar Projeto** inicia quando o professor acessa a tela de cadastro e informa os dados necessários para a criação de um novo projeto acadêmico. Após o envio do formulário, a camada de Apresentação encaminha os dados para a API por meio de uma requisição HTTP.

Na camada de Aplicação, o controlador recebe a solicitação, valida a autenticação do usuário e encaminha os dados ao serviço responsável pelas regras de negócio. Em seguida, a camada de Domínio realiza as validações específicas da entidade Projeto, garantindo a consistência das informações antes da persistência.

Após a validação, a camada de Infraestrutura grava os dados no banco PostgreSQL por meio do repositório. Por fim, a API retorna uma resposta de sucesso para a interface, que atualiza a experiência do usuário exibindo uma notificação de confirmação e redirecionando-o para a área de acompanhamento dos projetos cadastrados.

# 4. Figura da Arquitetura

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CAMADA DE APRESENTAÇÃO (Frontend)                        │
│                                                                             │
│                  MVC (React/Redux)                                          │
│                                                                             │
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────────────────────┐        │
│  │    View     │◄──│ Controller  │──►│            Model            │        │
│  │(Componentes │   │ (Handlers,  │   │   (Redux State / Context)  │         │
│  │   React)    │   │  Actions)   │   │  - Projetos, Tarefas       │         │
│  └─────────────┘   └─────────────┘   │  - Autenticação            │         │
│                                      │  - Filtros                 │         │
│                                      └─────────────────────────────┘        │
│                                                                             │
│                         HTTP/JSON (REST)                                    │
└───────────────────────────────┬─────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                     CAMADA DE APLICAÇÃO (Backend)                           │
│                                                                             │
│               Express.js (Controllers + Services)                           │
│                                                                             │
│  Controllers: AuthController, ProjectController, TaskController             │
│                                                                             │
│  Services:    ProjectService, TaskService, EditalService                    │
│                                                                             │
└───────────────────────────────┬─────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                        CAMADA DE DOMÍNIO (Model)                            │
│                                                                             │
│                    Entidades e Regras de Negócio                            │
│                                                                             │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────────┐ ┌─────────┐            │
│  │ Project │ │  User   │ │  Task   │ │ Orientation │ │ Edital  │            │
│  │ - title │ │ - name  │ │ - status│ │ - type      │ │ - title │            │
│  │ - modal.│ │ - email │ │ - due   │ │ - start     │ │ - date  │            │
│  │ - end   │ │ - role  │ │ - assign│ │ - end       │ │ - source│            │
│  └─────────┘ └─────────┘ └─────────┘ └─────────────┘ └─────────┘            │
│                                                                             │
└───────────────────────────────┬─────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                       CAMADA DE INFRAESTRUTURA                              │
│                                                                             │
│ ┌─────────────────┐ ┌─────────────────┐ ┌────────────────────────────┐      │
│ │   PostgreSQL    │ │ Firebase Auth   │ │    Serviços Externos       │      │
│ │ (Banco Dados)   │ │ (Autenticação)  │ │ (E-mail, Webhooks)         │      │
│ │ - Projetos      │ │ - JWT Tokens    │ │ - Notificações             │      │
│ │ - Usuários      │ │ - Social Login  │ │ - Scraping de Editais      │      │
│ │ - Tarefas       │ │ - Roles         │ │                            │      │
│ └─────────────────┘ └─────────────────┘ └────────────────────────────┘      │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Figura 1 – Arquitetura Geral do E-Project baseada em Arquitetura em Camadas e MVC.**

*Fonte: Elaborado pelo autor (2026).*

---

<img width="516" height="349" alt="Screenshot 2026-06-08 at 11-58-45 Cap  7 Arquitetura – Engenharia de Software Moderna" src="https://github.com/user-attachments/assets/fb78c2c6-3788-491d-a362-c1c859ef0ea9" />

**Figura 2 – Arquitetura MVC.**
*Fonte: Elaborado por Marco Tulio Valente (2020).*


## 4.1 Detalhamento dos Componentes da Arquitetura

| Componente | Tecnologia | Responsabilidade Específica no E-Project |
|------------|------------|------------------------------------------|
| **View (React)** | React + Tailwind CSS | Renderiza dashboards, quadro Kanban, formulários de cadastro de projetos e tarefas, feed de editais e relatórios acadêmicos. |
| **Controller (Frontend)** | Redux Thunk / Context API | Gerencia o estado da aplicação, dispara ações assíncronas para a API e trata eventos de interação do usuário, como cliques, submissões de formulários e filtros. |
| **Controller (Backend)** | Express.js | Recebe requisições REST (`POST`, `GET`, `PUT`, `DELETE`), valida autenticação e permissões dos usuários e encaminha as operações para os serviços correspondentes. |
| **Service** | Node.js | Implementa os casos de uso do sistema e orquestra operações complexas, como cadastro de projetos, gerenciamento de tarefas, geração de relatórios e envio de notificações. |
| **Model (Domínio)** | Classes TypeScript | Contém as entidades e regras de negócio da aplicação, incluindo validações de projetos, tarefas, usuários e editais, além do cálculo automático de indicadores e status. |
| **Repository** | Prisma ORM / TypeORM | Abstrai o acesso ao banco de dados por meio de repositórios, disponibilizando operações de persistência e consulta das entidades do sistema. |
| **Banco de Dados** | PostgreSQL | Armazena informações de usuários, projetos, tarefas, orientações, editais, relatórios, registros de presença e logs do sistema. |
| **Autenticação** | Firebase Authentication | Realiza autenticação de usuários por e-mail e senha ou provedores externos, gera e valida tokens JWT e controla perfis de acesso. |
| **Hospedagem** | Vercel / Netlify | Hospeda o frontend em formato PWA e permite integração contínua com repositórios GitHub para implantação automatizada. |

### Descrição dos Componentes

#### View (React)

A camada de visualização é composta por componentes React responsáveis pela apresentação das informações aos usuários. Essa camada inclui dashboards, quadros Kanban, formulários e telas de acompanhamento de projetos acadêmicos.

#### Controller (Frontend)

Os controladores do frontend coordenam as interações do usuário com a interface, atualizam o estado global da aplicação e realizam chamadas à API backend por meio de requisições HTTP.

#### Controller (Backend)

Os controladores implementados em Express.js recebem as requisições do frontend, realizam validações iniciais e encaminham os dados para os serviços responsáveis pelas regras de negócio.

#### Service

A camada de serviços concentra a lógica de aplicação e os casos de uso do sistema, atuando como intermediária entre os controladores e o domínio.

#### Model (Domínio)

Representa o núcleo do sistema e contém as entidades acadêmicas e suas respectivas regras de negócio, garantindo consistência e integridade dos dados.

#### Repository

Os repositórios encapsulam o acesso ao banco de dados, permitindo que a camada de domínio permaneça desacoplada da tecnologia de persistência utilizada.

#### Banco de Dados

O PostgreSQL é responsável pelo armazenamento persistente de todas as informações gerenciadas pelo sistema.

#### Autenticação

O Firebase Authentication fornece mecanismos de autenticação, autorização e gerenciamento de sessões dos usuários.

#### Hospedagem

A camada de hospedagem disponibiliza a aplicação para acesso externo, utilizando serviços de deploy contínuo integrados ao GitHub.
# Arquitetura de Software: Três Camadas vs MVC

Este documento resume e compara dois importantes padrões arquiteturais: **Arquitetura em Três Camadas** e **Model-View-Controller (MVC)**, com base na evolução histórica e aplicação em projetos modernos (como o E-Project).

## Arquitetura em Três Camadas

A Arquitetura em Três Camadas é um padrão comum na construção de sistemas de informação corporativos. Ela surgiu com a migração de sistemas de mainframes para plataformas distribuídas, a partir do final da década de 80.

### As Três Camadas

<img width="666" height="434" alt="Screenshot 2026-06-08 at 12-36-10 Cap  7 Arquitetura – Engenharia de Software Moderna" src="https://github.com/user-attachments/assets/f0816292-1bc6-4f88-ba02-da705e112e1f" />

**Figura 3 – Arquitetura em Três Camadas.**
*Fonte: Elaborado por Marco Tulio Valente (2020).*


| Camada | Responsabilidade | Exemplo no E-Project |
| :--- | :--- | :--- |
| **1. Interface com o Usuário (Apresentação)** | Toda interação com o usuário: exibição de informação, coleta de eventos (cliques, digitação), etc. Pode ser desktop, web ou mobile. | Interface React PWA: dashboards, formulários de projetos, quadro Kanban. |
| **2. Lógica de Negócio (Aplicação)** | Implementa as regras de negócio do sistema. Validações, cálculos, fluxos de trabalho. | Node.js/Express: regras como "notas entre 0 e valor da avaliação", notificações por e-mail. |
| **3. Banco de Dados** | Armazena os dados manipulados pelo sistema. | PostgreSQL: tabelas de usuários, projetos, tarefas, orientações. |

### Características Importantes

- **Arquitetura Distribuída:** Normalmente, a camada de interface executa na máquina do cliente, a camada de negócio em um servidor de aplicação, e o banco de dados em um servidor dedicado.
- **Modularidade:** A camada de aplicação pode conter módulos como fachadas (para facilitar acesso) e persistência (para isolar o banco de dados).
- **Comparação com 2 camadas:** Em sistemas de duas camadas, a interface e a lógica de negócio são unidas no cliente. A desvantagem é que todo o processamento ocorre no cliente, exigindo maior poder computacional.

---

## Diferença entre MVC e Três Camadas (Pergunta Frequente)

A confusão entre estes termos é comum. A melhor forma de entendê-los é através de sua **evolução histórica**, que revela que atuam em níveis de abstração diferentes e foram criados para propósitos distintos.

<img width="625" height="364" alt="Screenshot 2026-06-08 at 12-40-37 Cap  7 Arquitetura – Engenharia de Software Moderna" src="https://github.com/user-attachments/assets/5df32f81-601a-40e0-80b7-09aa559f48cd" />

**Figura 4 – Arquitetura MVC Web junatamnete com a trẽs camadas.**
*Fonte: Elaborado por Marco Tulio Valente (2020).*

### Resumo Rápido

- **Arquitetura em Três Camadas:** É uma **arquitetura de sistema** (macroarquitetura). Preocupa-se com a distribuição física e lógica de um sistema completo (frontend, backend, banco de dados).
- **Padrão MVC:** É um **padrão de apresentação** (microarquitetura). Preocupa-se com a organização interna da camada de interface com o usuário (como separar o código da tela da lógica de domínio).

### Linha do Tempo e Evolução

```mermaid
timeline
    title Evolução Histórica de MVC e 3 Camadas
    section 1970s
        MVC Clássico : Criado para o Smalltalk-80
                    : Foco: Interfaces Gráficas (janelas, botões, mouse)
                    : Objetivo: Separar Modelo (dados) da Visão (UI) e Controlador (eventos)
    section 1990s
        3 Camadas   : Popularizou-se com sistemas distribuídos
                    : Foco: Separar Apresentação, Lógica e Dados em servidores diferentes
                    : Uso: MVC é usado *dentro* da camada de apresentação
    section 2000s
        MVC Web     : Frameworks (Spring, Rails, Django) adaptam o MVC
                    : Visão = HTML, Controller = processa requisições, Model = banco de dados
                    : Resultado: Fim da distinção clara (MVC Web = 3 Camadas?)

