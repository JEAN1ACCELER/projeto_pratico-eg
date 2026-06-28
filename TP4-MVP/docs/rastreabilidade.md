# Matriz de Rastreabilidade

Este documento mapeia as funcionalidades implementadas no MVP com as histórias de usuário correspondentes.

## Histórias de Usuário Implementadas

### H6: Cadastro de Doador com Guia de Orientações
**História:** "Enquanto doador em potencial, quero me cadastrar no aplicativo e receber por e-mail um guia com orientações de uso, para iniciar o processo de doação de forma segura e informada."

**Implementação:**
A tela de cadastro (`register_page.dart`) foi implementada contendo todos os campos obrigatórios especificados:
- Nome completo (validação de mínimo 3 caracteres)
- E-mail (validação de formato via regex)
- CEP (validação de formato 00000-000)
- CNS - Cartão Nacional de Saúde (validação de 15 dígitos numéricos)
- Senha e Confirmação de Senha (mínimo 6 caracteres)

A persistência dos dados é realizada localmente utilizando o Hive (`storage_service.dart`). O envio do e-mail com o guia de orientações é simulado no método `register` do `auth_provider.dart`, imprimindo o conteúdo do e-mail no console (conforme permitido pelos requisitos).

### H1: Login de Usuário
**História:** "Enquanto usuário cadastrado, quero fazer login no aplicativo para acessar minha conta e agendar doações."

**Implementação:**
A tela de login (`login_page.dart`) permite autenticação utilizando e-mail e senha. A validação é feita em tempo real e os dados são verificados no armazenamento local (Hive). Em caso de erro, um SnackBar é exibido. Após o login bem-sucedido, o usuário é redirecionado para o Dashboard.

### H2: Visualização de Dashboard
**História:** "Enquanto usuário logado, quero visualizar um dashboard com o resumo das minhas doações e métricas importantes."

**Implementação:**
A tela de Dashboard (`home_page.dart`) exibe um resumo das doações do usuário, incluindo cards com métricas (Total, Concluídas, Agendadas, Pendentes) e um gráfico de pizza utilizando a biblioteca `fl_chart`. A tela possui suporte a Pull-to-Refresh (`RefreshIndicator`) para atualizar os dados.

### H3: Agendamento de Doação
**História:** "Enquanto doador, quero agendar uma nova doação escolhendo a data, o local e o tipo de doação."

**Implementação:**
A tela de formulário (`form_page.dart`) permite a criação de uma nova doação. O usuário pode selecionar o tipo de doação, a data agendada (usando o `showDatePicker`), informar o local e adicionar observações opcionais.

### H4: Listagem e Histórico de Doações
**História:** "Enquanto doador, quero visualizar o histórico de todas as minhas doações e seus respectivos status."

**Implementação:**
A tela de listagem (`list_page.dart`) exibe todas as doações do usuário em uma lista rolável (`ListView.builder`). O usuário pode filtrar as doações por status (Todos, Pendente, Agendada, Concluída, Cancelada) utilizando chips.

### H5: Gerenciamento de Perfil
**História:** "Enquanto usuário, quero acessar e gerenciar as informações do meu perfil."

**Implementação:**
A tela de perfil (`profile_page.dart`) exibe as informações pessoais do usuário cadastradas anteriormente, permite configurar notificações (simulado) e oferece a opção de sair da conta (logout).
