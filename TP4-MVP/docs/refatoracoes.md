# Refatorações Realizadas no Projeto TP4-MVP

Este documento detalha as refatorações significativas que foram implementadas durante o desenvolvimento do projeto TP4-MVP, descrevendo o que foi alterado, o motivo da alteração e o impacto gerado.

## 1. Refatoração de `ProjectsScreen`

**O que foi alterado:** A tela de listagem e gerenciamento de projetos (`ProjectsScreen`) foi refatorada para melhorar a modularidade e a legibilidade do código. Componentes internos foram extraídos para widgets menores e mais reutilizáveis.

**Por que foi alterado:** A complexidade da `ProjectsScreen` original estava dificultando a manutenção e a adição de novas funcionalidades. A extração de widgets menores permitiu uma melhor separação de responsabilidades.

**Impacto:** Melhoria na organização do código, facilidade de manutenção, aumento da reutilização de componentes e melhor desempenho da interface do usuário.

## 2. Refatoração de `TasksScreen`

**O que foi alterado:** Similar à `ProjectsScreen`, a tela de gerenciamento de tarefas (`TasksScreen`) passou por um processo de refatoração para otimizar sua estrutura e lógica. Foram implementados padrões de design para gerenciar o estado de forma mais eficiente.

**Por que foi alterado:** A `TasksScreen` apresentava um acoplamento alto entre a lógica de negócio e a interface do usuário, tornando os testes e futuras modificações mais desafiadores.

**Impacto:** Código mais limpo, lógica de estado mais clara, facilidade na implementação de testes unitários e melhor experiência do usuário devido a um gerenciamento de estado mais responsivo.

## 3. Refatoração de `DatabaseService`

**O que foi alterado:** O serviço de banco de dados (`DatabaseService`) foi refatorado para utilizar um padrão de repositório, abstraindo a lógica de acesso a dados e tornando-a independente da implementação específica do banco de dados (SQLite, no caso).

**Por que foi alterado:** A implementação inicial do `DatabaseService` estava diretamente acoplada ao `sqflite`, dificultando a troca de banco de dados ou a implementação de testes de unidade sem depender de um banco de dados real.

**Impacto:** Maior flexibilidade para trocar a tecnologia de persistência de dados, facilidade na escrita de testes de unidade e melhor organização da camada de acesso a dados.

## 4. Conversão do Projeto de React para Flutter

**O que foi alterado:** O projeto original, desenvolvido em React, foi completamente reescrito e migrado para a plataforma Flutter.

**Por que foi alterado:** A decisão de migrar para Flutter foi motivada pela necessidade de desenvolver um aplicativo móvel multiplataforma com uma única base de código, aproveitando o desempenho nativo e a rica biblioteca de widgets do Flutter. O React original era focado em web, e a necessidade de uma solução móvel eficiente e com boa experiência de usuário levou à mudança.

**Impacto:** O projeto agora é um aplicativo móvel multiplataforma (Android, iOS, Web, Desktop) com uma interface de usuário consistente e de alta performance, reduzindo o tempo e o custo de desenvolvimento para múltiplas plataformas.
