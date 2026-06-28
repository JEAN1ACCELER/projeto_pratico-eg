# Script: Vídeo de Demonstração do MVP - DoacaoMVP

Este script foi elaborado para um vídeo de aproximadamente **3 minutos**, focando na apresentação técnica e funcional do MVP desenvolvido para a disciplina de Engenharia de Software I.

---

## 1. Introdução (0:00 - 0:30)
**Visual:** Tela de Splash Screen animada.
**Locução:**
> "Olá! Sou o desenvolvedor do DoacaoMVP, o Produto Mínimo Viável para a disciplina de Engenharia de Software I, sob orientação do Professor Dr. Andrey Rodrigues. O aplicativo foi construído com Flutter e Material Design 3, focando em uma arquitetura robusta e escalável."

---

## 2. Fluxo de Cadastro e História H6 (0:30 - 1:15)
**Visual:** Navegação da Splash para a Tela de Login e depois para a Tela de Cadastro.
**Ação:** Preencher os campos Nome, E-mail, CEP, CNS e Senha. Mostrar as validações em tempo real.
**Locução:**
> "Iniciamos com o fluxo de cadastro, que atende à História de Usuário H6. Aqui, validamos em tempo real o formato do e-mail, o CEP com máscara automática e o CNS com 15 dígitos. Ao finalizar o cadastro, os dados são persistidos localmente com Hive e o sistema simula o envio de um e-mail com um guia de orientações para o novo doador, garantindo que ele inicie o processo de forma informada."

---

## 3. Dashboard e Gerenciamento de Estado (1:15 - 1:45)
**Visual:** Tela de Dashboard (Home) sendo carregada. Mostrar o gráfico de pizza e os cards de métricas. Realizar o Pull-to-Refresh.
**Locução:**
> "No Dashboard, utilizamos o Provider para gerenciamento de estado reativo. As métricas de doações totais, concluídas e pendentes são exibidas em cards dinâmicos, acompanhadas por um gráfico estatístico da biblioteca fl_chart. Implementamos também o Pull-to-Refresh para garantir que os dados estejam sempre atualizados."

---

## 4. Agendamento e Listagem (1:45 - 2:30)
**Visual:** Clicar no botão 'Nova Doação'. Preencher o formulário, selecionar data no DatePicker. Salvar e ver a transição para a Listagem.
**Locução:**
> "O agendamento de doações é simples e intuitivo. Utilizamos o Repository Pattern para abstrair a fonte de dados. Na listagem, o usuário pode visualizar todo o seu histórico e filtrar as doações por status através de chips interativos. Cada item da lista utiliza Hero Animations para uma transição suave até a tela de detalhes."

---

## 5. Detalhes, Perfil e Arquitetura (2:30 - 3:00)
**Visual:** Abrir uma doação específica, mostrar SliverAppBar. Ir para a tela de Perfil. Mostrar o código-fonte rapidamente (pastas lib/).
**Locução:**
> "Na tela de detalhes, aproveitamos componentes avançados como SliverAppBar. No perfil, o usuário gerencia seus dados e configurações. Por trás da interface, aplicamos 5 refatorações do catálogo de Engenharia de Software Moderna, como Extract Widget e Guard Clauses, garantindo um código limpo e de fácil manutenção. Este é o DoacaoMVP: tecnologia a serviço da vida."

---

## Dicas para Gravação:
1. **Resolução:** Grave em 1080p (proporção 9:16 para mobile).
2. **Áudio:** Use um microfone externo para evitar ruídos.
3. **Edição:** Adicione legendas curtas destacando os termos técnicos (ex: "Material 3", "Hive DB", "GoRouter").
4. **Demonstração:** Mostre o console do desenvolvedor quando o e-mail simulado for "enviado" durante o cadastro.
