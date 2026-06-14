# 6. Diagrama de Código (Classes UML) — Modelo C4

## 6.1 Visão geral do diagrama

O **Diagrama de Código** é o quarto e mais granular nível do modelo C4. Ele desce até o nível da implementação, apresentando a estrutura interna de classes, interfaces, atributos e métodos de um componente específico do sistema.

Este diagrama não visa representar todo o código-fonte do E-Project. Ao invés disso, ele detalha as **classes centrais do domínio de negócio** que sustentam o funcionamento da aplicação, mostrando como os dados são modelados, como as entidades se relacionam e quais operações cada classe executa.

O foco aqui é o **módulo de Gestão de Projetos** da API Backend, pois ele representa o coração do sistema, englobando projetos, tarefas, entregas, reuniões e notificações.

---

```mermaid
classDiagram
    class Usuario {
        +UUID id
        +String nomeCompleto
        +String emailInstitucional
        +String hashSenha
        +Enum papel
        +String departamento
        +Date dataCadastro
        +autenticar(credenciais) Boolean
        +atualizarPerfil(dados) Usuario
        +validarEmail() Boolean
    }

    class Projeto {
        +UUID id
        +String titulo
        +Enum modalidade
        +Enum status
        +Date dataInicio
        +Date dataTermino
        +String resumo
        +UUID orientadorId
        +UUID orientandoId
        +adicionarTarefa(tarefa) Tarefa
        +adicionarReuniao(reuniao) Reuniao
        +gerarRelatorioFinal() Arquivo
        +validarPrazos() Boolean
        +atualizarStatus(novoStatus) void
    }

    class Tarefa {
        +UUID id
        +String titulo
        +String descricao
        +Enum tipo
        +Date prazo
        +Enum status
        +Date dataConclusao
        +UUID projetoId
        +marcarConcluida() void
        +validarPrazo() Boolean
        +criarEntrega(arquivo, comentario) Entrega
        +atualizarDescricao(texto) void
    }

    class Entrega {
        +UUID id
        +UUID tarefaId
        +String arquivoUrl
        +Date dataEnvio
        +String comentarioAluno
        +String feedbackOrientador
        +Enum statusAvaliacao
        +anexarArquivo(url) void
        +avaliar(feedback, status) void
        +verificarDataLimite() Boolean
    }

    class Reuniao {
        +UUID id
        +UUID projetoId
        +Date dataHora
        +String local
        +String resumo
        +String ataUrl
        +List~UUID~ presencas
        +registrarPresenca(usuarioId) void
        +gerarAta() Arquivo
        +atualizarResumo(texto) void
    }

    class Notificacao {
        +UUID id
        +UUID usuarioId
        +Enum tipo
        +String conteudo
        +Date dataEnvio
        +Boolean lida
        +enviar() void
        +marcarComoLida() void
        +agendarEnvio(data) void
    }

    Usuario "1" -- "0..*" Projeto : orienta (como orientador)
    Usuario "1" -- "0..*" Projeto : participa (como orientando)
    Usuario "1" -- "0..*" Notificacao : recebe
    Projeto "1" *-- "0..*" Tarefa : contem
    Projeto "1" *-- "0..*" Reuniao : registra
    Tarefa "1" -- "0..1" Entrega : possui
```

---

## 6.4 Detalhamento por Partes
Parte 1 — Classe Usuario (Autenticação e Perfis)
A classe Usuario é a base de todo o controle de acesso. Ela utiliza um campo papel (enum: PROFESSOR, ALUNO, ADMINISTRADOR) para diferenciar permissões sem criar subclasses desnecessárias, mantendo o modelo flexível para futuros perfis institucionais.

```mermaid
classDiagram
    class Usuario {
        +UUID id
        +String nomeCompleto
        +String emailInstitucional
        +String hashSenha
        +Enum papel
        +String departamento
        +Date dataCadastro
        +autenticar(credenciais) Boolean
        +atualizarPerfil(dados) Usuario
        +validarEmail() Boolean
    }

    class Projeto {
        +UUID orientadorId
        +UUID orientandoId
    }

    class Notificacao {
        +UUID usuarioId
    }

    Usuario "1" -- "0..*" Projeto : orienta
    Usuario "1" -- "0..*" Projeto : e orientando em
    Usuario "1" -- "0..*" Notificacao : recebe
```

**Figura 2 — Classe Usuario e suas associações. Representa a identidade digital dos atores do sistema e sua vinculação com projetos e alertas.**

Explicação dos métodos:
autenticar(): valida credenciais contra o banco de dados, utilizando o hash da senha;
atualizarPerfil(): permite ao usuário modificar dados pessoais e preferências;
validarEmail(): garante que apenas e-mails institucionais da UFAM (@ufam.edu.br) sejam aceitos no cadastro.

---

Parte 2 — Classe Projeto (Núcleo do Domínio)
A classe Projeto é o eixo central do E-Project. Ela agrega todas as informações relativas a uma iniciativa acadêmica e mantém o controle sobre seu ciclo de vida, desde a submissão até a conclusão.

```mermaid
classDiagram
    class Projeto {
        +UUID id
        +String titulo
        +Enum modalidade
        +Enum status
        +Date dataInicio
        +Date dataTermino
        +String resumo
        +UUID orientadorId
        +UUID orientandoId
        +adicionarTarefa(tarefa) Tarefa
        +adicionarReuniao(reuniao) Reuniao
        +gerarRelatorioFinal() Arquivo
        +validarPrazos() Boolean
        +atualizarStatus(novoStatus) void
    }

    class Tarefa {
        +UUID projetoId
    }

    class Reuniao {
        +UUID projetoId
    }

    Projeto "1" *-- "0..*" Tarefa : contem
    Projeto "1" *-- "0..*" Reuniao : registra
```

---

**Figura 3 — Classe Projeto como agregadora de Tarefas e Reuniões. Representa o contrato acadêmico entre orientador e orientando.**

Explicação dos métodos:
adicionarTarefa(): cria uma nova tarefa vinculada ao projeto, atualizando automaticamente o cronograma;
adicionarReuniao(): registra um encontro de orientação e o associa ao histórico do projeto;
gerarRelatorioFinal(): consolida dados do projeto, tarefas concluídas e atas de reunião em um documento padronizado;
validarPrazos(): verifica se o projeto está dentro do período de vigência da modalidade acadêmica;
atualizarStatus(): altera o estado do projeto (ex: EM_ANDAMENTO, PENDENTE, CONCLUIDO, CANCELADO).

---

Parte 3 — Classes Tarefa, Entrega e Reuniao (Fluxo Operacional)
Esse conjunto de classes representa o dia a dia da orientação. O aluno recebe tarefas, entrega documentos e participa de reuniões. O professor acompanha tudo por meio dessas entidades.

```mermaid
classDiagram
    class Tarefa {
        +UUID id
        +String titulo
        +String descricao
        +Enum tipo
        +Date prazo
        +Enum status
        +Date dataConclusao
        +UUID projetoId
        +marcarConcluida() void
        +validarPrazo() Boolean
        +criarEntrega(arquivo, comentario) Entrega
        +atualizarDescricao(texto) void
    }

    class Entrega {
        +UUID id
        +UUID tarefaId
        +String arquivoUrl
        +Date dataEnvio
        +String comentarioAluno
        +String feedbackOrientador
        +Enum statusAvaliacao
        +anexarArquivo(url) void
        +avaliar(feedback, status) void
        +verificarDataLimite() Boolean
    }

    class Reuniao {
        +UUID id
        +UUID projetoId
        +Date dataHora
        +String local
        +String resumo
        +String ataUrl
        +List~UUID~ presencas
        +registrarPresenca(usuarioId) void
        +gerarAta() Arquivo
        +atualizarResumo(texto) void
    }

    Tarefa "1" -- "0..1" Entrega : possui
```

---

**Figura 4 — Fluxo operacional da orientação: Tarefas geram Entregas e Reuniões registram o acompanhamento presencial/online.**

Explicação das classes e métodos:
Tarefa:

marcarConcluida(): altera o status da tarefa e registra a data de conclusão;
validarPrazo(): compara a data atual com o prazo estipulado, retornando false se houver atraso;
criarEntrega(): instancia um objeto Entrega vinculado a esta tarefa.
Entrega:

anexarArquivo(): recebe a URL do arquivo armazenado no Storage (S3) e a persiste;
avaliar(): permite ao professor registrar feedback e marcar a entrega como APROVADA ou NECESSITA_AJUSTE;
verificarDataLimite(): valida se a entrega foi enviada dentro do prazo da tarefa vinculada.
Reuniao:

registrarPresenca(): adiciona o ID do usuário à lista de presenças, evitando duplicatas;
gerarAta(): produz um documento PDF ou texto com os dados da reunião e lista de presentes;
atualizarResumo(): permite ao orientador descrever o que foi discutido na reunião.

---

Parte 4 — Classe Notificacao (Serviço de Alertas)
A classe Notificacao desacopla o envio de alertas do restante do domínio. Ela é consumida pelo serviço de jobs para enviar comunicações via e-mail ou Web Push.

```mermaid
classDiagram
    class Usuario {
        +UUID id
    }

    class Notificacao {
        +UUID id
        +UUID usuarioId
        +Enum tipo
        +String conteudo
        +Date dataEnvio
        +Boolean lida
        +enviar() void
        +marcarComoLida() void
        +agendarEnvio(data) void
    }

    Usuario "1" -- "0..*" Notificacao : recebe
```

---

**Figura 5 — Classe Notificacao representando o sistema de alertas e comunicação assíncrona com os usuários.**

Explicação dos métodos:
enviar(): dispara a notificação pelo canal apropriado (e-mail ou push) e registra a data de envio;
marcarComoLida(): atualiza o flag lida para true, removendo o alerta da caixa de entrada do usuário;
agendarEnvio(): permite programar o envio da notificação para uma data futura, útil para lembretes de prazo.
