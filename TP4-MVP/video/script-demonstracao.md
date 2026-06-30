# Script: Vídeo de Demonstração do MVP - E-Project App

Este script foi elaborado para um vídeo de aproximadamente **3 minutos**, focando na apresentação técnica e funcional do E-Project App.

---

## 1. Introdução (0:00 - 0:30)
**Visual:** Splash Screen com logo do E-Project App.
**Locução:**
> "Olá! Sou o desenvolvedor do E-Project App, o MVP de gerenciamento de projetos acadêmicos para a disciplina de Engenharia de Software I da UFAM. O aplicativo foi construído com Flutter e segue o padrão arquitetural MVC."

---

## 2. Fluxo de Cadastro e Validação H6 (0:30 - 1:15)
**Visual:** Tela de Signup. Preenchimento de Nome, E-mail, CPF e CNS.
**Ação:** Mostrar o diálogo de Termos de Uso e Política de Privacidade.
**Locução:**
> "No cadastro, atendemos ao requisito H6 com validações rigorosas de CPF e CNS de 15 dígitos. O usuário também deve aceitar os Termos de Uso e a Política de Privacidade antes de prosseguir. A segurança é garantida com o hash SHA-256 das senhas antes do armazenamento."

---

## 3. Dashboard e Persistência SQLite (1:15 - 1:45)
**Visual:** Tela de Dashboard e Projects.
**Locução:**
> "Utilizamos o SQLite como banco de dados local para persistência robusta. No Dashboard, o usuário tem uma visão clara dos seus projetos e tarefas. O gerenciamento de estado é feito através do Provider Pattern, garantindo uma interface reativa e fluida."

---

## 4. Gestão de Projetos e Tarefas (1:45 - 2:30)
**Visual:** Criar um novo projeto e adicionar uma tarefa a ele.
**Locução:**
> "A gestão de projetos e tarefas é o coração do E-Project. O usuário pode criar projetos acadêmicos e vincular tarefas específicas com datas de entrega, tudo armazenado em tabelas relacionais no banco de dados local."

---

## 5. Perfil, Configurações e Encerramento (2:30 - 3:00)
**Visual:** Navegação pelas telas de Profile e Settings (Modo Escuro, Idioma).
**Locução:**
> "Nas telas de Perfil e Configurações, o usuário pode personalizar sua experiência, incluindo ajustes de notificações e modo visual. Com uma arquitetura limpa e testes unitários completos, o E-Project App entrega uma solução sólida para o gerenciamento acadêmico."

---

## Dicas para Gravação:
1. **Ambiente:** Use o emulador do Android ou iOS para uma captura limpa.
2. **Destaque Técnico:** Mencione o uso das bibliotecas `sqflite` e `provider`.
3. **Qualidade:** Garanta que as validações de campo fiquem bem visíveis no vídeo.
