# TP4-MVP — Academic Project Management App

Este é o repositório do projeto TP4-MVP, um aplicativo de gerenciamento de projetos acadêmicos desenvolvido para auxiliar estudantes e professores na organização e acompanhamento de suas atividades.

## Tecnologias Utilizadas

*   **Framework:** Flutter
*   **Linguagem:** Dart
*   **Banco de Dados Local:** SQLite (via `sqflite`)
*   **Gerenciamento de Estado:** Provider

## Estrutura de Pastas

O projeto segue a seguinte estrutura de pastas para garantir organização e manutenibilidade:

```
TP4-MVP/
├── docs/                 # Documentação do projeto (rastreabilidade, refatorações, termos de uso)
├── prints/               # Capturas de tela do aplicativo
│   ├── tela-login/
│   ├── tela-cadastro/
│   └── funcionalidades/
├── video/                # Vídeos de demonstração do MVP
└── src/                  # Código-fonte da aplicação Flutter
    ├── components/       # Widgets reutilizáveis (botões, cards, etc.)
    ├── pages/            # Telas principais da aplicação (Login, Dashboard, Projects, Tasks)
    ├── services/         # Serviços de backend (autenticação, banco de dados)
    ├── assets/           # Imagens, ícones e outros recursos estáticos
    ├── App.dart          # Configuração principal do aplicativo (rotas, tema)
    └── main.dart         # Ponto de entrada da aplicação
```

## Como Rodar Localmente

Para configurar e executar o projeto em sua máquina local, siga os passos abaixo:

1.  **Instalar Flutter:** Certifique-se de ter o Flutter SDK instalado e configurado em seu ambiente. Você pode seguir as instruções oficiais em [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install).

2.  **Navegar até o Diretório do Projeto:**
    ```bash
    cd /home/ubuntu/projeto_pratico-eg/TP4-MVP
    ```

3.  **Obter Dependências:** Baixe todas as dependências do projeto:
    ```bash
    flutter pub get
    ```

4.  **Executar o Aplicativo:** Inicie o aplicativo em um emulador, dispositivo físico ou navegador (para web):
    ```bash
    flutter run
    ```
    Para rodar no navegador, você pode usar:
    ```bash
    flutter run -d chrome
    ```

## Documentação Adicional

*   [Documentação Detalhada](docs/TECHNICAL_DOCUMENTATION.md)
*   [Rastreabilidade de Requisitos](docs/rastreabilidade.md)
*   [Refatorações Realizadas](docs/refatoracoes.md)
*   [Termos de Uso](docs/termos-de-uso.md)

## Capturas de Tela

Visualize as capturas de tela do aplicativo na pasta [prints/](prints/).

## Vídeo de Demonstração

Assista ao vídeo de demonstração do MVP na pasta [video/](video/demonstracao-mvp.mp4).
