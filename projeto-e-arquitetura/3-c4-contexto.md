# 3. C4: Contexto

## 3.1. Definição Geral do Diagrama de Contexto

O **Diagrama de Contexto**, o nível mais alto do Modelo C4, oferece uma visão de alto nível do sistema de software, ilustrando como ele se integra ao ambiente geral de TI e como interage com usuários e outros sistemas externos [1]. Este diagrama é fundamental para estabelecer o escopo do sistema e para que todas as partes interessadas (técnicas e não-técnicas) compreendam o propósito e as fronteiras do software. Ele foca em **pessoas** (atores) e **sistemas de software** (sistemas externos) que interagem diretamente com o sistema em questão.

## 3.2. Atores e Sistemas Externos do E-Project

Com base no *backlog* do produto, os principais atores e sistemas externos que interagem com o E-Project são:

### Atores
*   **Professor Orientador:** Usuário principal que gerencia projetos, tarefas, orientandos e documentos (US-02, US-03, US-04, US-05, US-06, US-08, US-09).
*   **Estudante Orientando:** Usuário que realiza tarefas, submete entregas, faz *check-in* em reuniões e visualiza *feedback* (US-10, US-11, US-12, US-13, US-14).
*   **Administrador:** Usuário responsável por configurações gerais do sistema, gerenciamento de usuários e manutenção (implícito nas necessidades de gestão do sistema).

### Sistemas Externos
*   **Sistema de E-mail:** Utilizado para envio de notificações, lembretes e comunicações gerais. (Implícito em notificações)
*   **Sistema da UFAM:** Pode ser um sistema acadêmico ou de gestão de editais, do qual o E-Project pode consumir informações ou integrar-se para validação de dados (US-05, US-01 - matrícula institucional).
*   **Sistema de Autenticação Institucional (SSO):** Para *login* com matrícula e senha institucional (US-01).

## 3.4. Explicação Global do Diagrama

O diagrama de contexto do E-Project ilustra o sistema central e suas interações com os diferentes tipos de usuários e sistemas externos. O E-Project atua como o ponto central para a gestão de projetos de pesquisa e extensão, facilitando a comunicação e o fluxo de trabalho entre professores e estudantes. Ele se integra com sistemas externos para autenticação e comunicação, garantindo um ecossistema coeso.

### Detalhamento por Partes

*   **E-Project:** O sistema principal, que oferece funcionalidades de gestão de projetos, tarefas, documentos e comunicação.
*   **Professor Orientador:** Interage com o E-Project para gerenciar projetos, atribuir tarefas, revisar entregas e acompanhar o progresso dos orientandos.
*   **Estudante Orientando:** Utiliza o E-Project para visualizar tarefas, submeter entregas, registrar presença e receber *feedback*.
*   **Administrador:** Gerencia o E-Project em um nível mais alto, configurando parâmetros e usuários.
*   **Usuário com Necessidades Especiais:** Interage com o E-Project, utilizando as funcionalidades de acessibilidade.
*   **Sistema de E-mail:** O E-Project envia notificações e comunicações para os usuários por meio deste sistema.
*   **Sistema da UFAM:** O E-Project pode consultar informações ou integrar-se a este sistema para dados acadêmicos ou de editais.
*   **Sistema de Autenticação Institucional (SSO):** O E-Project utiliza este sistema para autenticar os usuários com suas credenciais institucionais.

## Referências
[1] System context diagram | C4 model. Disponível em: [https://c4model.com/diagrams/system-context](https://c4model.com/diagrams/system-context)

![Diagrama de Contexto do E-Project](./e-project-c4-context.png)

**Legenda:** Diagrama de Contexto do E-Project, mostrando as interações com atores e sistemas externos.
