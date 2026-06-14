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
