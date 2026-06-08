1. Descrição do Padrão Arquitetural
1.1.1 Apresentação

O padrão arquitetural selecionado para o E-Project é a Arquitetura em Camadas (Layered Architecture), complementado pelo padrão MVC (Model-View-Controller) nas camadas de Apresentação e Aplicação.

Conforme definido no material de referência (Seção 7.2), a Arquitetura em Camadas organiza as classes em módulos de maior tamanho chamados camadas, dispostas hierarquicamente, onde uma camada somente pode usar serviços da camada imediatamente inferior. Isso particiona a complexidade, disciplina as dependências e facilita a manutenção e evolução do sistema.

O padrão MVC (Seção 7.3), por sua vez, separa a aplicação em três grupos: Visão (interface gráfica), Controladora (tratamento de eventos) e Modelo (dados e lógica de domínio), garantindo que o modelo não tenha dependência da interface.
1.1.2 Domínio

O domínio de aplicação é a gestão de projetos acadêmicos na Universidade Federal do Amazonas (UFAM). O sistema lida com múltiplos perfis de usuário (professores orientadores, estudantes bolsistas, administradores), diferentes modalidades de pesquisa (PIBIC, PIBITI, PIBEX, PACE, Pós-Graduação) e funcionalidades como gestão de tarefas, documentos, prazos, editais e relatórios.

2. Justificativa da Escolha
2.1 Justificar a escalabilidade e manutenção

A Arquitetura em Camadas garante escalabilidade porque cada camada pode ser dimensionada independentemente. Por exemplo:

    A camada de Apresentação (React PWA) pode ser replicada para atender milhares de usuários simultâneos.

    A camada de Aplicação (Node.js/Express) pode ser escalada horizontalmente com balanceadores de carga.

    A camada de Infraestrutura (PostgreSQL, Firebase Auth) pode ser otimizada separadamente.

A manutenção é favorecida pela disciplina de dependências: uma camada só se comunica com a imediatamente inferior. Isso permite trocar implementações (ex: migrar de Firebase para Supabase) sem impactar as camadas superiores, exatamente como o material exemplifica com a troca de TCP para UDP na pilha de protocolos.
2.2 Justificar a testabilidade

Conforme destacado na Seção 7.3 sobre MVC: "MVC favorece testabilidade. É mais fácil testar objetos não-visuais, isto é, não relacionados com a implementação de interfaces gráficas".

No E-Project:

    A camada de Domínio (Modelo) contém as regras de negócio (ex: validação de notas, cálculo de prazos) e pode ser testada com testes unitários isolados, sem dependência de banco ou interface.

    A camada de Aplicação (Controladores) pode ser testada com testes de integração usando mocks das camadas inferiores.

    A camada de Apresentação (Visão) pode ser testada com testes de componente (React Testing Library), simulando interações do usuário.

2.3 Justificar a independência de frameworks e UI

O material (Seção 7.3) afirma que "objetos de domínio não incluem código visual, mas apenas lógica de negócios". Isso garante independência de frameworks e UI porque:

    A camada de Domínio não conhece React, Express ou qualquer framework específico. Ela contém apenas classes puras TypeScript com regras de negócio.

    A camada de Infraestrutura isola a lógica de persistência (repositórios) do restante do sistema.

    É possível trocar toda a interface do usuário (ex: migrar de React PWA para React Native mobile) sem alterar uma linha de código do Modelo ou da Lógica de Negócio.

Isso atende ao princípio fundamental citado: "O coração e a parte mais preciosa de MVC está na separação entre código de interface com o usuário e a lógica do domínio" (Fowler e Beck).
