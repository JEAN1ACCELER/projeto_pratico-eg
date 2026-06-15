<div align="center">

# Diagrama de Containers

**E-Project** · C4 Model · Nível 2

---

![UFAM](https://img.shields.io/badge/ICET--UFAM-Engenharia%20de%20Software%20I-00663C?style=for-the-badge)
![C4](https://img.shields.io/badge/C4%20Model-N%C3%ADvel%202%20%E2%80%94%20Containers-1168BD?style=for-the-badge)
![Sprint](https://img.shields.io/badge/Status-SPRINT%201-blue?style=for-the-badge)

</div>

---

## 4.1 Visão Geral do Diagrama

O **Diagrama de Containers** é o segundo nível do modelo C4. Ele aprofunda a visão do sistema, revelando os **principais blocos de execução** que compõem o E-Project — as aplicações, serviços e bancos de dados que, juntos, entregam as funcionalidades ao usuário.

Neste nível, cada "container" representa uma unidade implantável e executável de forma independente. O objetivo é mostrar:

- **Quais containers existem** no sistema;
- **Qual tecnologia** cada container utiliza;
- **Como os containers se comunicam** entre si e com sistemas externos;
- **Onde cada container é hospedado**.

---

## 4.2 Explicação Geral do Diagrama

O E-Project é composto por **quatro containers internos** que colaboram para entregar todas as funcionalidades da plataforma, além de **três sistemas externos** integrados via APIs públicas.

A arquitetura segue um fluxo claro: os **três perfis de usuário** (Professor Orientador, Aluno Orientando e Administrador) acessam o sistema exclusivamente pela **Aplicação Web (PWA)** hospedada na Vercel. Essa camada de apresentação se comunica com a **API RESTful** (backend Node.js/Express, hospedado no Railway) via requisições HTTP/JSON. A API é o **hub central de processamento**: ela lê e persiste dados no **Banco de Dados PostgreSQL**, aciona o **Serviço de Geração de PDF** para criar documentos oficiais, audita ações críticas e acessos (via **Winston**), valida autenticações junto ao **Firebase Authentication** e dispara alertas pelo **Firebase Cloud Messaging**.

O pipeline de CI/CD, gerenciado pelo **GitHub Actions**, automatiza o deploy contínuo tanto do frontend (na Vercel) quanto do backend (no Railway).

---

## 4.3 Descrição dos Containers

### 📦 Containers Internos do E-Project

| Container | Tecnologia | Hospedagem | Responsabilidade |
|:---|:---|:---|:---|
| **Aplicação Web (PWA)** | JavaScript / React / Recharts | Vercel | Interface do usuário. Exibe projetos, tarefas, documentos, notificações e dashboards visuais com métricas. Instalável como PWA. |
| **API RESTful** | TypeScript / Node.js + Express + Winston | Railway | Processa regras de negócio, autentica requisições via JWT, gerencia projetos, tarefas, documentos e audita logs de segurança. |
| **Banco de Dados** | PostgreSQL + Prisma ORM | Railway | Persiste dados de usuários, projetos, tarefas, reuniões, documentos, editais e logs de auditoria. |
| **Serviço de Geração de PDF** | Node.js / PDFKit | Integrado ao Backend | Gera automaticamente relatórios parciais e declarações de bolsista em formato PDF oficial da UFAM. |

### 🔌 Sistemas Externos Integrados

| Sistema | Tipo | Papel no E-Project |
|:---|:---|:---|
| **Firebase Authentication** | Software System (Google) | Autentica usuários via e-mail/senha e retorna token JWT para controle de acesso. |
| **Firebase Cloud Messaging** | Software System (Google) | Envia notificações push de prazos e atualizações aos usuários. |
| **GitHub Actions** | Software System | Pipeline de CI/CD: build, testes e deploy automático para Vercel e Railway. |

---

## 4.4 Diagrama de Containers — Visão Completa

![Diagrama de Containers do E-Project](./imgs/4-c4-containers.png)

**Figura 1 —** Diagrama de Containers do E-Project. Representa os quatro containers internos (PWA, API RESTful, Banco de Dados e Serviço de PDF), os três sistemas externos integrados (Firebase Auth, FCM e GitHub Actions) e os três perfis de usuário que interagem com a plataforma.

---

## 4.5 Detalhamento por Partes

### Parte 1 — Usuários e Aplicação Web (PWA)

Os três perfis de usuário do E-Project interagem com o sistema exclusivamente por meio da **Aplicação Web (PWA)**, acessada via navegador utilizando HTTPS. Por ser implementada como *Progressive Web App*, ela pode ser instalada no dispositivo e oferece funcionalidades offline básicas.

O **Professor Orientador** acessa dashboards de projetos, revisa tarefas e gera documentos institucionais. O **Aluno Orientando** visualiza seu cronograma, envia entregas e registra presença em reuniões. O **Administrador / Coordenador** gerencia contas de usuários, publica editais institucionais e visualiza métricas de uso em dashboards interativos (construídos com a biblioteca Recharts).

![Parte 1 — Usuários e PWA](./imgs/4-c4-containers-parte1.png)

**Figura 2 —** Interação dos três perfis de usuário com o container da Aplicação Web (PWA) via HTTPS.

---

### Parte 2 — Aplicação Web e API RESTful

O frontend se comunica com o backend por meio de requisições **HTTP/JSON**. Toda operação que exige persistência, regra de negócio ou integração com serviços externos passa obrigatoriamente pela API RESTful. A autenticação de cada requisição é validada por meio do token **JWT** emitido pelo Firebase, garantindo que apenas usuários autorizados acessem os recursos do sistema.

![Parte 2 — PWA e API RESTful](./imgs/4-c4-containers-parte2.png)

**Figura 3 —** Comunicação entre o container da Aplicação Web (PWA) e a API RESTful via protocolo HTTP/JSON.

---

### Parte 3 — API RESTful e Banco de Dados

A API RESTful persiste e consulta dados no **PostgreSQL** por meio do **Prisma ORM**, que abstrai as operações de banco de dados e garante tipagem segura em TypeScript. Ambos — API e banco — são hospedados no Railway, no mesmo ambiente, o que simplifica a configuração de rede e reduz a latência entre os serviços.

As principais entidades armazenadas são: usuários, projetos, tarefas, orientações, reuniões, documentos, editais e **logs de auditoria**. O backend utiliza a biblioteca **Winston** para capturar ações críticas (ex: exclusão de projetos, alteração de permissões) e registrá-las no banco, garantindo a segurança e o histórico exigidos pela gestão administrativa.

![Parte 3 — API e Banco de Dados](./imgs/4-c4-containers-parte3.png)

**Figura 4 —** Integração entre a API RESTful e o Banco de Dados PostgreSQL via Prisma ORM.

---

### Parte 4 — API RESTful e Serviço de Geração de PDF

Quando o usuário solicita um documento oficial — como um relatório parcial ou uma declaração de bolsista — a API aciona o **Serviço de Geração de PDF**, que utiliza a biblioteca **PDFKit** para compor o documento no padrão da UFAM. O arquivo gerado é devolvido ao frontend para download direto pelo usuário, eliminando o preenchimento manual e reduzindo erros nos documentos oficiais.

![Parte 4 — API e Serviço de PDF](./imgs/4-c4-containers-parte4.png)

**Figura 5 —** Fluxo de geração automática de documentos PDF envolvendo a API, o Serviço de PDF e o Frontend.

---

### Parte 5 — API RESTful e Firebase Authentication

A autenticação é totalmente delegada ao **Firebase Authentication**. Quando um usuário tenta acessar o sistema, o frontend coleta as credenciais e as envia à API. O backend as encaminha ao Firebase, que valida a identidade e retorna um **token JWT**. Esse token é então utilizado em todas as requisições subsequentes para garantir acesso autorizado conforme o perfil do usuário (professor, aluno ou administrador).

![Parte 5 — API e Firebase Auth](./imgs/4-c4-containers-parte5.png)

**Figura 6 —** Fluxo de autenticação do E-Project com o Firebase Authentication via token JWT.

---

### Parte 6 — API RESTful e Firebase Cloud Messaging

O **Firebase Cloud Messaging (FCM)** é o mecanismo de notificações push do E-Project. Quando a API detecta um evento relevante — prazo se aproximando, nova tarefa atribuída, documento aprovado — ela aciona o FCM via HTTP, que entrega a notificação diretamente ao navegador ou dispositivo do usuário, mesmo com o aplicativo fechado, garantindo comunicação proativa sem necessidade de o usuário verificar o sistema constantemente.

![Parte 6 — API e FCM](./imgs/4-c4-containers-parte6.png)

**Figura 7 —** Fluxo de envio e entrega de notificações push via Firebase Cloud Messaging.

---

### Parte 7 — GitHub Actions e Pipeline CI/CD

O **GitHub Actions** orquestra o processo de integração e entrega contínua. A cada *commit* na branch principal, o pipeline automaticamente executa os testes, realiza o *build* da aplicação e implanta o frontend na **Vercel** e o backend no **Railway**, garantindo entregas rápidas e sem intervenção manual.

![Parte 7 — Pipeline CI/CD](./imgs/4-c4-containers-parte7.png)

**Figura 8 —** Pipeline de CI/CD com GitHub Actions realizando deploy automático para Vercel (frontend) e Railway (backend).

---

## 4.6 Tabela de Comunicações

| Origem | Destino | Protocolo | Descrição |
|:---|:---|:---|:---|
| Professor / Aluno / Admin | Aplicação Web (PWA) | HTTPS | Acesso à interface via navegador |
| Aplicação Web (PWA) | API RESTful | HTTP / JSON / REST | Todas as operações de dados e negócio |
| API RESTful | Banco de Dados | SQL / Prisma ORM | Leitura e persistência de dados |
| API RESTful | Serviço de PDF | Interno (Node.js) | Solicitação de geração de documentos |
| Serviço de PDF | Aplicação Web (PWA) | HTTPS | Entrega do arquivo PDF para download |
| API RESTful | Firebase Authentication | HTTPS | Validação de credenciais e obtenção de JWT |
| API RESTful | Firebase Cloud Messaging | HTTPS / FCM API | Disparo de notificações push |
| Firebase Cloud Messaging | Aplicação Web (PWA) | Push (FCM) | Entrega de notificação ao navegador |
| GitHub Actions | Aplicação Web (PWA) | CI/CD → Vercel | Deploy automático do frontend |
| GitHub Actions | API RESTful | CI/CD → Railway | Deploy automático do backend |


---

## 4.8 Considerações Finais

O Diagrama de Containers evidencia a **separação clara de responsabilidades** que fundamenta a arquitetura do E-Project:

- A **Aplicação Web (PWA)** cuida exclusivamente da apresentação e da experiência do usuário, sem conter lógica de negócio.
- A **API RESTful** centraliza todo o processamento, regras de negócio e orquestração de serviços externos.
- O **Banco de Dados PostgreSQL** é o único ponto de persistência, acessado exclusivamente pela API — nunca diretamente pelo frontend.
- O **Serviço de PDF** é encapsulado como módulo independente, facilitando futuras evoluções nos templates de documentos.
- A inclusão de ferramentas específicas como **Recharts** (no Frontend) e **Winston** (no Backend) atende diretamente aos requisitos de rastreabilidade do painel gerencial, permitindo a geração de métricas visuais e o registro seguro de logs de auditoria.

Os sistemas externos do Firebase foram mantidos mínimos no MVP (apenas Authentication e FCM), assegurando uma arquitetura simples, segura e alinhada ao tech stack definido.

---

<div align="center">

**Universidade Federal do Amazonas — ICET | Engenharia de Software I | 2026**

</div>
