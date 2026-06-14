# 4. Representação Arquitetural com o Modelo C4 — Diagrama de Containers

## 4.1 Visão geral do diagrama

O **Diagrama de Containers** apresenta os principais blocos de execução do sistema, seus papéis, tecnologias e a forma como se comunicam. Diferentemente do diagrama de contexto, aqui o sistema deixa de ser visto como uma caixa preta e passa a ser detalhado em suas unidades principais de execução.

## 4.2 Explicação geral do diagrama modelado para o sistema

No E-Project, a arquitetura foi organizada em containers que separam interface, processamento, persistência e integrações externas. Essa divisão favorece manutenção, escalabilidade e clareza arquitetural.

Os principais containers propostos são:

- **Aplicação Web PWA**: interface acessada por professores e alunos;
- **API Backend**: responsável pela lógica de negócio;
- **Banco de Dados Relacional**: armazenamento estruturado;
- **Armazenamento de Arquivos**: persistência de documentos e anexos;
- **Serviço de Notificações/Jobs**: envio de lembretes e processamento assíncrono de eventos;
- **Fontes Externas**: portais institucionais e canais de notificação.

## 4.3 Diagrama de Containers

```mermaid
flowchart TB
    professor["Professor Orientador"]
    aluno["Aluno Orientando"]

    subgraph eproject["E-Project"]
        pwa["Aplicação Web PWA<br/>Container: React + TypeScript<br/>Responsável pela interface acessível e responsiva"]
        api["API Backend<br/>Container: Node.js + NestJS<br/>Responsável por autenticação, projetos, tarefas, editais, documentos e presença"]
        db["Banco de Dados Relacional<br/>Container: PostgreSQL<br/>Armazena usuários, projetos, tarefas, prazos e registros"]
        files["Armazenamento de Arquivos<br/>Container: Storage<br/>Guarda anexos, relatórios e documentos gerados"]
        jobs["Serviço de Notificações e Jobs<br/>Container: Worker/Serviço assíncrono<br/>Processa alertas, prazos e atualização de editais"]
    end

    editais["Portais institucionais UFAM / Pró-Reitorias"]
    notificacao["Serviço externo de E-mail / Push"]

    professor -->|usa via navegador| pwa
    aluno -->|usa via navegador| pwa

    pwa -->|HTTPS / JSON| api
    api -->|SQL| db
    api -->|envia e recupera arquivos| files
    api -->|publica eventos / agenda tarefas| jobs

    jobs -->|consulta informações| editais
    jobs -->|envia mensagens| notificacao
Figura 1 — Diagrama de Containers do E-Project, destacando frontend, backend, persistência, armazenamento e processamento assíncrono.

4.4 Descrição dos containers
Aplicação Web PWA
É o ponto de entrada do usuário no sistema. Permite acesso por navegador em desktop e mobile, com foco em acessibilidade, usabilidade e produtividade.

API Backend
Concentra as regras de negócio do E-Project. Processa autenticação, projetos, tarefas, documentos, presença, notificações e o feed de editais.

Banco de Dados Relacional
Armazena os dados estruturados do domínio acadêmico, como usuários, projetos, cronogramas, tarefas, notificações e históricos.

Armazenamento de Arquivos
Responsável por guardar documentos enviados ou gerados pelo sistema, como relatórios, anexos e declarações.

Serviço de Notificações e Jobs
Executa tarefas assíncronas, como envio de lembretes, varredura periódica de editais e disparo de notificações para os usuários.

4.5 Detalhamento por partes
Fluxo principal de uso
O professor ou aluno acessa a Aplicação Web PWA;
A interface envia requisições à API Backend;
A API processa a lógica de negócio e consulta o Banco de Dados;
Se necessário, a API interage com o Armazenamento de Arquivos;
Eventos e tarefas assíncronas são encaminhados ao Serviço de Notificações e Jobs;
O serviço consulta fontes externas e envia alertas via e-mail ou push.
4.6 Considerações finais
A organização em containers torna o sistema mais claro, facilita a evolução futura e ajuda a demonstrar como o E-Project atende seus requisitos funcionais e não funcionais.


---
