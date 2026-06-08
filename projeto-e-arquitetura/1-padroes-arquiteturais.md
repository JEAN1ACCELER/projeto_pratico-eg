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

## 2.4 Atendimento aos Requisitos Não Funcionais

| Requisito Não Funcional | Como a Arquitetura Atende |
|-------------------------|---------------------------|
| **Multiplataforma (PWA)** | A camada de Apresentação em React permite gerar uma PWA que roda em qualquer dispositivo com navegador. |
| **Desempenho** | A separação de camadas permite caching em cada nível (CDN para frontend, Redis para backend). |
| **Segurança** | A camada de Aplicação centraliza autenticação (Firebase Auth) e autorização, isolando regras de acesso. |
| **Disponibilidade** | Camadas independentes permitem arquitetura de alta disponibilidade (ex.: múltiplas instâncias do backend). |
| **Manutenibilidade** | Dependências disciplinadas e separação de responsabilidades facilitam a correção de bugs e a evolução do sistema. |
