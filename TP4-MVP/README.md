# E-Project - Gerenciador de Projetos Acadêmicos (MVP)

O **E-Project** é um MVP desenvolvido em Flutter para a disciplina de Engenharia de Software I. Ele oferece uma solução completa para estudantes gerenciarem seus projetos e tarefas acadêmicas com segurança e organização.

## 🚀 Como Executar Localmente

Para rodar este projeto em sua máquina, siga os passos abaixo:

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/JEAN1ACCELER/projeto_pratico-eg.git
   ```

2. **Navegue até o diretório do projeto:**
   ```bash
   cd projeto_pratico-eg/TP4-MVP
   ```

3. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

4. **Execute o aplicativo:**
   ```bash
   flutter run
   ```

## ✨ Funcionalidades Principais

| Funcionalidade | Descrição |
| :--- | :--- |
| **Autenticação** | Login e Cadastro seguros com criptografia SHA-256. |
| **Gestão de Projetos** | CRUD completo de projetos acadêmicos. |
| **Gestão de Tarefas** | Controle de tarefas vinculadas a projetos com datas. |
| **Banco Local** | Persistência robusta utilizando SQLite (sqflite). |
| **8 Telas** | Interface completa com Material Design 3. |
| **Validação H6** | Cadastro rigoroso com validação de CPF e CNS. |

## 🏗️ Arquitetura e Padrões

- **Padrão MVC**: Separação clara entre Model, View e Controller.
- **Gerenciamento de Estado**: Provider Pattern com ChangeNotifier.
- **Persistência**: SQLite com 4 tabelas relacionais.
- **Testes**: Testes unitários para serviços de autenticação e banco de dados.

## 📚 Documentação Adicional

- [Documentação Técnica](TECHNICAL_DOCUMENTATION.md)
- [Rastreabilidade e TODO](todo.md)
- [Termos de Uso](docs/termos-de-uso.md)
- [Script de Demonstração](docs/video/script-demonstracao.md)

---
Desenvolvido como Trabalho Prático IV de Engenharia de Software I - UFAM.
