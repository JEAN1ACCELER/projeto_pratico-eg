# 7. Rastreabilidade e Inventário LGPD

## 7.1. Rastreabilidade de Histórias de Usuário

A rastreabilidade é fundamental para entender como as funcionalidades do sistema são implementadas através das diferentes camadas da arquitetura. Abaixo, detalhamos o fluxo de três histórias de usuário representativas, mapeando-as aos diagramas C4 e aos componentes internos da API.

### 7.1.1. US-01: Login com matrícula e senha institucional

**Descrição:** Enquanto usuário do E-Project, desejo realizar login com minha matrícula e senha institucional, para acessar meus projetos e funcionalidades de acordo com meu perfil.

**Fluxo Detalhado:**
1.  O **Usuário (Professor/Estudante)** acessa a **Aplicação Web (PWA)** e insere suas credenciais institucionais.
2.  A **Aplicação Web (PWA)** envia uma requisição de login para a **API REST (Backend)**.
3.  No **API REST (Backend)**, o **Controller** de autenticação recebe a requisição.
4.  O **Controller** invoca o **Service** de autenticação.
5.  O **Service** de autenticação utiliza o **Adapter** do Firebase Authentication para interagir com o **Firebase Authentication** (que por sua vez pode se integrar com o Sistema de Autenticação Institucional - SSO).
6.  O **Firebase Authentication** valida as credenciais e retorna um token de autenticação para o **Adapter**.
7.  O **Adapter** retorna o resultado para o **Service**, que o repassa ao **Controller**.
8.  O **Controller** envia a resposta (sucesso/falha e token) de volta para a **Aplicação Web (PWA)**.
9.  A **Aplicação Web (PWA)** armazena o token e redireciona o usuário para o dashboard apropriado.

**Diagramas C4 Envolvidos:**
*   **Contexto:** Professor/Estudante -> E-Project -> Sistema de Autenticação Institucional (SSO)
*   **Containers:** Aplicação Web (PWA) -> API REST (Backend) -> Firebase Authentication
*   **Componentes (API REST):** Controllers -> Services -> Adapters -> Firebase Authentication

### 7.1.2. US-03: Professor cadastra novo projeto

**Descrição:** Enquanto professor orientador, desejo cadastrar um novo projeto escolhendo sua modalidade (PIBIC, PACE, PIBEX etc.), para iniciar o acompanhamento sem precisar configurar campos do zero.

**Fluxo Detalhado:**
1.  O **Professor Orientador** acessa a **Aplicação Web (PWA)** e preenche o formulário de cadastro de novo projeto.
2.  A **Aplicação Web (PWA)** envia uma requisição POST com os dados do projeto para a **API REST (Backend)**.
3.  No **API REST (Backend)**, o **Controller** de projetos recebe a requisição.
4.  O **Controller** valida os dados e invoca o **Service** de projetos.
5.  O **Service** de projetos contém a lógica de negócio para criar um novo projeto e utiliza o **Repository** de projetos.
6.  O **Repository** de projetos persiste os dados do novo projeto no **Banco de Dados (PostgreSQL)**.
7.  O **Banco de Dados** retorna a confirmação da persistência para o **Repository**.
8.  O **Repository** retorna o projeto criado para o **Service**, que o repassa ao **Controller**.
9.  O **Controller** envia a resposta (sucesso e dados do projeto criado) de volta para a **Aplicação Web (PWA)**.
10. A **Aplicação Web (PWA)** exibe uma mensagem de sucesso e atualiza a lista de projetos do professor.

**Diagramas C4 Envolvidos:**
*   **Contexto:** Professor Orientador -> E-Project
*   **Containers:** Aplicação Web (PWA) -> API REST (Backend) -> Banco de Dados (PostgreSQL)
*   **Componentes (API REST):** Controllers -> Services -> Repositories -> Banco de Dados

### 7.1.3. US-10: Aluna orientanda visualiza tarefas pendentes

**Descrição:** Enquanto aluna orientanda, desejo visualizar todas as tarefas pendentes que foram atribuídas a mim, para saber exatamente o que preciso entregar e em qual prazo.

**Fluxo Detalhado:**
1.  A **Estudante Orientanda** acessa a **Aplicação Web (PWA)** e navega para a seção de tarefas.
2.  A **Aplicação Web (PWA)** envia uma requisição GET para a **API REST (Backend)** para buscar as tarefas pendentes da estudante.
3.  No **API REST (Backend)**, o **Controller** de tarefas recebe a requisição.
4.  O **Controller** invoca o **Service** de tarefas.
5.  O **Service** de tarefas contém a lógica de negócio para buscar as tarefas atribuídas à estudante e utiliza o **Repository** de tarefas.
6.  O **Repository** de tarefas consulta o **Banco de Dados (PostgreSQL)** para obter as tarefas pendentes da estudante.
7.  O **Banco de Dados** retorna as tarefas para o **Repository**.
8.  O **Repository** retorna as tarefas para o **Service**, que as repassa ao **Controller**.
9.  O **Controller** formata a lista de tarefas e envia a resposta de volta para a **Aplicação Web (PWA)**.
10. A **Aplicação Web (PWA)** exibe a lista de tarefas pendentes para a estudante.

**Diagramas C4 Envolvidos:**
*   **Contexto:** Estudante Orientanda -> E-Project
*   **Containers:** Aplicação Web (PWA) -> API REST (Backend) -> Banco de Dados (PostgreSQL)
*   **Componentes (API REST):** Controllers -> Services -> Repositories -> Banco de Dados

## 7.2. Inventário de Dados Pessoais (LGPD)

Este inventário detalha os dados pessoais tratados pelo E-Project, em conformidade com a Lei Geral de Proteção de Dados (LGPD).

### 1. Identificação do Projeto
*   **Nome do Projeto:** E-Project - Sistema de Gestão de Projetos de Pesquisa e Extensão
*   **Versão:** 1.0
*   **Data:** 01 de Junho de 2026

### 2. Descrição do Projeto
O E-Project é uma plataforma web desenvolvida para auxiliar professores e estudantes da UFAM na gestão de projetos de pesquisa e extensão. Ele permite o cadastro de projetos, atribuição e acompanhamento de tarefas, submissão de entregas, controle de presença em reuniões, geração de documentos oficiais e comunicação entre orientadores e orientandos.

### 3. Agentes de Tratamento
*   **Controlador:** Universidade Federal do Amazonas (UFAM)
*   **Operador:** Equipe de Desenvolvimento do E-Project (responsável pela manutenção e operação do sistema)
*   **Encarregado de Dados (DPO):** A ser definido pela UFAM.

### 4. Finalidade do Tratamento
O tratamento de dados pessoais no E-Project tem como finalidade principal a gestão eficiente e transparente de projetos de pesquisa e extensão, incluindo:
*   Identificação e autenticação de usuários (professores e estudantes).
*   Gerenciamento de informações de projetos, tarefas e entregas.
*   Facilitação da comunicação e colaboração entre orientadores e orientandos.
*   Geração de documentos oficiais relacionados aos projetos.
*   Monitoramento do desempenho e engajamento dos participantes.

### 5. Fluxo de Tratamento
1.  **Coleta:** Dados são coletados no cadastro inicial (via SSO institucional) e durante o uso do sistema (cadastro de projetos, tarefas, submissão de entregas).
2.  **Armazenamento:** Dados são armazenados no Banco de Dados PostgreSQL e, em alguns casos, em serviços de armazenamento de arquivos (e.g., S3 para documentos e entregas).
3.  **Uso:** Dados são utilizados para as funcionalidades do sistema (exibição de dashboards, atribuição de tarefas, geração de relatórios).
4.  **Compartilhamento:** Dados podem ser compartilhados com sistemas externos da UFAM (para validação ou integração) e serviços de e-mail (para notificações).
5.  **Descarte:** Dados são descartados conforme políticas de retenção de dados da UFAM e requisitos legais.

### 6. Categorias de Dados Coletados
*   **Dados de Identificação:** Nome completo, matrícula institucional, e-mail institucional.
*   **Dados de Contato:** E-mail (institucional).
*   **Dados Acadêmicos:** Curso, período, departamento, titulação.
*   **Dados de Projeto:** Título, descrição, modalidade, status, datas.
*   **Dados de Atividade:** Tarefas atribuídas, entregas submetidas, feedback, presença em reuniões.
*   **Dados de Acessibilidade:** Preferências de interface (tamanho da fonte, alto contraste) para usuários com necessidades especiais.

### 7. Titulares dos Dados
*   Professores Orientadores
*   Estudantes Orientandos
*   Administradores do Sistema

### 8. Base Legal para o Tratamento
*   **Execução de contrato ou de procedimentos preliminares relacionados a contrato:** Para a prestação dos serviços de gestão de projetos (Termos de Uso).
*   **Cumprimento de obrigação legal ou regulatória:** Geração de documentos oficiais, relatórios.
*   **Exercício regular de direitos em processo judicial, administrativo ou arbitral:** Em caso de disputas ou auditorias.
*   **Legítimo interesse:** Para melhoria contínua do serviço, desde que os direitos e liberdades fundamentais dos titulares sejam respeitados.

### 9. Compartilhamento de Dados
*   **Com quem:** Sistemas internos da UFAM, Firebase Authentication, provedores de serviço de e-mail.
*   **Finalidade:** Autenticação, integração de dados acadêmicos, envio de notificações.
*   **Medidas de Segurança:** Contratos com cláusulas de proteção de dados, uso de APIs seguras, criptografia em trânsito.

### 10. Segurança dos Dados
*   **Medidas Técnicas:** Criptografia de dados em repouso e em trânsito, controle de acesso baseado em função (RBAC), firewalls, backups regulares, monitoramento de segurança.
*   **Medidas Organizacionais:** Políticas internas de segurança da informação, treinamento de funcionários, acordos de confidencialidade.

### 11. Direitos dos Titulares
Os titulares dos dados podem exercer os seguintes direitos, conforme a LGPD:
*   Confirmação da existência de tratamento.
*   Acesso aos dados.
*   Correção de dados incompletos, inexatos ou desatualizados.
*   Anonimização, bloqueio ou eliminação de dados desnecessários, excessivos ou tratados em desconformidade.
*   Portabilidade dos dados a outro fornecedor de serviço ou produto.
*   Eliminação dos dados pessoais tratados com o consentimento do titular.
*   Informação das entidades públicas e privadas com as quais o controlador realizou uso compartilhado de dados.
*   Informação sobre a possibilidade de não fornecer consentimento e sobre as consequências da negativa.
*   Revogação do consentimento.

### 12. Riscos e Medidas de Mitigação
*   **Risco:** Acesso não autorizado a dados pessoais.
    *   **Mitigação:** Implementação de autenticação multifator, controle de acesso rigoroso, auditorias de segurança.
*   **Risco:** Vazamento de dados.
    *   **Mitigação:** Criptografia de dados, detecção de intrusão, plano de resposta a incidentes.
*   **Risco:** Uso indevido de dados por operadores.
    *   **Mitigação:** Contratos com cláusulas de proteção de dados, monitoramento de logs de acesso.

### 13. Consentimento
O consentimento será coletado de forma clara e explícita quando necessário, informando ao titular sobre a finalidade específica do tratamento. Para dados essenciais à execução do serviço, a base legal será a execução de contrato ou obrigação legal.

### 14. Disposições Finais
Este inventário será revisado e atualizado periodicamente para garantir a conformidade contínua com a LGPD e as melhores práticas de proteção de dados.
