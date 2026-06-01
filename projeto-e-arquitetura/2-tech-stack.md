# 2. Tech Stack

## 2.1. Tecnologias Previstas

O E-Project será desenvolvido utilizando um conjunto de tecnologias modernas e robustas, selecionadas para garantir escalabilidade, manutenibilidade e uma boa experiência de usuário. A stack tecnológica abrange desde o frontend até o backend, banco de dados, autenticação e processos de CI/CD.

### Frontend
*   **React (PWA):** Framework JavaScript para construção de interfaces de usuário reativas e eficientes. A implementação como Progressive Web App (PWA) permitirá que o aplicativo seja instalado em dispositivos móveis e desktops, oferecendo uma experiência similar a um aplicativo nativo, com funcionalidades offline e notificações.

### Backend
*   **Node.js/Express:** Node.js será o ambiente de execução JavaScript no lado do servidor, e Express.js será o framework web para construir a API RESTful. Essa combinação é ideal para aplicações de alta performance e escaláveis, permitindo o uso de JavaScript em toda a stack (full-stack JavaScript).

### Banco de Dados
*   **PostgreSQL:** Um sistema de gerenciamento de banco de dados relacional (SGBDR) de código aberto, conhecido por sua robustez, confiabilidade, desempenho e suporte a recursos avançados. Será utilizado para armazenar dados estruturados do E-Project, como informações de usuários, projetos, tarefas e documentos.

### Autenticação
*   **Firebase Authentication:** Serviço de autenticação fornecido pelo Google Firebase, que oferece uma solução segura e escalável para gerenciar usuários. Suporta diversos métodos de login (e-mail/senha, Google, etc.) e simplifica a implementação de autenticação no aplicativo.

### Deploy e CI/CD
*   **GitHub Actions:** Plataforma de integração contínua e entrega contínua (CI/CD) integrada ao GitHub. Será utilizada para automatizar o processo de build, teste e deploy do E-Project, garantindo que as alterações de código sejam entregues de forma rápida e confiável.

## 2.2. Mapa Visual da Arquitetura

[Será inserido o diagrama D2 aqui]

## 2.3. Explicação das Integrações

A arquitetura do E-Project é projetada para ser modular e com integrações bem definidas entre os componentes. O **Frontend (React PWA)** se comunicará com o **Backend (Node.js/Express)** exclusivamente através de requisições HTTP para a API RESTful. O Backend, por sua vez, será responsável por interagir com o **PostgreSQL** para operações de persistência de dados e com o **Firebase Authentication** para gerenciar a autenticação e autorização dos usuários. O **GitHub Actions** orquestrará o pipeline de CI/CD, automatizando a implantação de novas versões do Frontend e Backend em seus respectivos ambientes de hospedagem.

## 2.4. Tabela Obrigatória: Camada | Tecnologia | Justificativa

| Camada | Tecnologia | Justificativa |
|:---|:---|:---|
| Frontend | React (PWA) | Interface de usuário reativa, experiência de aplicativo nativo, funcionalidades offline. |
| Backend | Node.js/Express | Ambiente de execução JavaScript de alta performance, framework web robusto para API RESTful. |
| Banco de Dados | PostgreSQL | SGBDR confiável, escalável e com recursos avançados para dados estruturados. |
| Autenticação | Firebase Authentication | Solução de autenticação segura, escalável e de fácil integração. |
| CI/CD | GitHub Actions | Automação de build, teste e deploy, garantindo entregas rápidas e confiáveis. |

## 2.2. Mapa Visual da Arquitetura

![Mapa Visual da Tech Stack do E-Project](./e-project-tech-stack.png)

**Legenda:** Diagrama representando as principais tecnologias utilizadas no E-Project e suas interações.
