# Refatorações Aplicadas

Este documento detalha as 5 refatorações aplicadas no código-fonte do MVP, baseadas no catálogo do livro "Engenharia de Software Moderna".

## 1. Extract Widget (Extrair Widget)

**Problema Identificado:**
As telas de login, cadastro e formulários possuíam trechos de código muito grandes e repetitivos para a construção de botões e campos de texto, misturando lógica de UI com a estrutura da tela.

**Motivação:**
A repetição de código fere o princípio DRY (Don't Repeat Yourself) e dificulta a manutenção, pois uma alteração no design de um botão exigiria modificações em várias telas.

**Descrição da Melhoria:**
Foram criados os widgets `CustomButton` e `CustomTextField` na pasta `lib/widgets/common/`. Toda a lógica de estilização, exibição de ícones e indicadores de carregamento foi encapsulada nestes widgets, que agora são reutilizados em toda a aplicação.

**Impacto no Sistema:**
O código das telas ficou significativamente menor, mais limpo e legível. A padronização visual foi garantida, e futuras alterações no design system precisarão ser feitas em apenas um lugar.

---

## 2. Extract Method (Extrair Método)

**Problema Identificado:**
A lógica de validação dos campos de formulário (e-mail, senha, CPF/CNS) estava espalhada diretamente nas propriedades `validator` dos `TextFormField` nas telas.

**Motivação:**
Misturar regras de negócio (validação) com código de interface gráfica viola o princípio de responsabilidade única e dificulta a escrita de testes unitários para essas validações.

**Descrição da Melhoria:**
A lógica de validação foi extraída para a classe utilitária `Validators` (`lib/utils/validators.dart`). Métodos estáticos como `validateEmail`, `validatePassword` e `validateCns` foram criados para encapsular as expressões regulares (Regex) e as regras de negócio.

**Impacto no Sistema:**
A validação agora é testável de forma isolada (como demonstrado em `test/providers/user_provider_test.dart`). O código de UI ficou mais limpo, apenas referenciando os métodos de validação.

---

## 3. Introduce Parameter Object (Introduzir Objeto de Parâmetro)

**Problema Identificado:**
Os métodos de criação e atualização de usuário recebiam muitos parâmetros soltos (nome, email, cep, cns, senha, tipo sanguíneo), o que tornava a assinatura dos métodos longa e propensa a erros (ordem incorreta de argumentos).

**Motivação:**
Métodos com muitos parâmetros são um "code smell" (mau cheiro no código) que dificulta a leitura e o uso da API interna.

**Descrição da Melhoria:**
Foi criado o objeto `UserModel` (`lib/models/user_model.dart`) que agrupa todos esses dados. O método `UserModel.create()` atua como uma Factory, recebendo os parâmetros nomeados e gerando o objeto completo, incluindo a geração de um ID único e data de criação.

**Impacto no Sistema:**
As assinaturas de métodos nos repositórios e serviços ficaram mais limpas, trafegando um único objeto `UserModel` em vez de múltiplos parâmetros primitivos.

---

## 4. Replace Nested Conditional with Guard Clauses (Substituir Condicional Aninhada por Cláusulas de Guarda)

**Problema Identificado:**
Nos métodos de submissão de formulários (ex: `_handleLogin` e `_handleRegister`), havia condicionais aninhadas (`if (form.validate()) { if (outraCondicao) { ... } }`) que tornavam o fluxo principal do método difícil de seguir.

**Motivação:**
Condicionais aninhadas aumentam a complexidade ciclomática e escondem o "caminho feliz" (happy path) da execução do método.

**Descrição da Melhoria:**
Foram aplicadas cláusulas de guarda (return early). Por exemplo, em `_handleLogin`:
```dart
if (!_formKey.currentState!.validate()) return;
```
O método retorna imediatamente se a validação falhar, permitindo que o restante do código seja escrito sem níveis extras de indentação.

**Impacto no Sistema:**
O código ficou mais linear, fácil de ler e o fluxo de execução principal ficou mais evidente, melhorando a manutenibilidade.

---

## 5. Extract Provider (Extrair Provedor de Estado)

**Problema Identificado:**
Inicialmente, o estado de autenticação (se o usuário está logado, carregando, mensagem de erro) e a lógica de comunicação com o repositório estavam acoplados diretamente nos `StatefulWidgets` das telas.

**Motivação:**
Gerenciar estado complexo e regras de negócio dentro da UI dificulta o compartilhamento desse estado com outras telas e impede a separação clara entre a camada de apresentação e a camada de negócios.

**Descrição da Melhoria:**
Foi criado o `AuthProvider` (`lib/providers/auth_provider.dart`), que estende `ChangeNotifier`. Toda a lógica de login, registro, logout e controle de estado de carregamento/erro foi movida para esta classe. As telas agora apenas observam (`context.watch`) ou chamam métodos (`context.read`) deste provider.

**Impacto no Sistema:**
A aplicação agora segue a arquitetura recomendada pelo Flutter (State Management com Provider). O estado de autenticação tornou-se global e reativo, permitindo que o roteador (`AppRouter`) e outras telas reajam automaticamente a mudanças no login.
