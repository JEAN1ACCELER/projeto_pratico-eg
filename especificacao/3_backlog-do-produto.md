# Backlog do Produto - E-Project

Este documento contém a lista priorizada de funcionalidades do sistema E-Project.

## 1. Link para o Quadro no GitHub Projects
*   **Quadro:** [Inserir Link para o GitHub Project "Backlog do Produto"]

## 2. Histórias de Usuário (15)
| ID | História de Usuário | Prioridade | Persona | Status |
| :--- | :--- | :--- | :--- | :--- |
| US01 | Enquanto orientador, desejo visualizar um dashboard centralizado para acompanhar o progresso de todos os meus projetos ativos. | Alta | Prof. Ricardo | Especificada |
| US02 | Enquanto orientando, desejo visualizar minhas tarefas pendentes para organizar meu cronograma de pesquisa. | Alta | Ana | Especificada |
| US03 | Enquanto orientador, desejo atribuir tarefas específicas aos meus orientandos para delegar atividades do projeto. | Alta | Prof. Ricardo | Especificada |
| US04 | Enquanto usuário, desejo acessar um feed unificado de editais da UFAM para não perder prazos de submissão. | Alta | Todos | Especificada |
| US05 | Enquanto orientando, desejo realizar o upload de relatórios parciais para que o orientador possa revisá-los. | Alta | Ana | Especificada |
| US06 | Enquanto orientador, desejo aprovar ou solicitar correções em documentos enviados para garantir a qualidade da produção acadêmica. | Alta | Prof. Ricardo | Especificada |
| US07 | Enquanto usuário, desejo utilizar templates pré-formatados da UFAM para agilizar a criação de novos projetos. | Média | Prof. Ricardo | Especificada |
| US08 | Enquanto orientando, desejo registrar minha presença em reuniões via check-in digital para substituir listas de papel. | Média | Ana | Especificada |
| US09 | Enquanto orientador, desejo gerar automaticamente declarações de bolsista para facilitar processos administrativos. | Média | Prof. Ricardo | Especificada |
| US10 | Enquanto usuário com baixa visão, desejo utilizar o modo de alto contraste para navegar no sistema com autonomia. | Média | Todos | Especificada |
| US11 | Enquanto usuário, desejo receber notificações de prazos próximos para evitar atrasos em entregas oficiais. | Baixa | Todos | Não Especificada |
| US12 | Enquanto orientador, desejo visualizar indicadores gráficos de desempenho da equipe para identificar gargalos. | Baixa | Prof. Ricardo | Não Especificada |
| US13 | Enquanto usuário, desejo filtrar editais por pró-reitoria (PROPESP, PROEXT) para encontrar oportunidades relevantes. | Baixa | Todos | Não Especificada |
| US14 | Enquanto orientando, desejo visualizar o histórico de feedbacks do orientador para melhorar meu desempenho. | Baixa | Ana | Não Especificada |
| US15 | Enquanto usuário, desejo exportar o cronograma do projeto para PDF para apresentações em reuniões. | Baixa | Todos | Não Especificada |

## 3. Especificação Detalhada (Top 10)

### US01 - Dashboard Centralizado
*   **Critérios de Aceitação:** Exibir lista de projetos, barra de progresso percentual e alertas de prazos críticos.
*   **Regras de Negócio:** Apenas projetos onde o usuário é orientador devem aparecer.

### US02 - Visualização de Tarefas (Orientando)
*   **Critérios de Aceitação:** Lista de tarefas com data de entrega, status e prioridade.
*   **Regras de Negócio:** O orientando só vê tarefas atribuídas a ele.

### US03 - Atribuição de Tarefas
*   **Critérios de Aceitação:** Selecionar orientando, definir prazo e anexar descrição.
*   **Regras de Negócio:** Apenas o orientador do projeto pode criar tarefas.

### US04 - Feed de Editais
*   **Critérios de Aceitação:** Lista cronológica de editais com link direto para o PDF oficial.
*   **Regras de Negócio:** Os dados devem ser buscados nos sites da PROPESP/PROEXT.

### US05 - Upload de Relatórios
*   **Critérios de Aceitação:** Suporte a arquivos PDF/Docx e campo de comentários.
*   **Regras de Negócio:** Limite de tamanho de arquivo de 10MB.

### US06 - Revisão de Documentos
*   **Critérios de Aceitação:** Botões de "Aprovar" e "Solicitar Ajuste" com campo de feedback.
*   **Regras de Negócio:** O status da tarefa deve mudar automaticamente após a ação.

### US07 - Templates UFAM
*   **Critérios de Aceitação:** Seleção de modalidade (PIBIC, PIBEX) que preenche campos padrão.
*   **Regras de Negócio:** Os campos devem seguir as normas vigentes da UFAM.

### US08 - Check-in Digital
*   **Critérios de Aceitação:** Botão de check-in que registra data, hora e geolocalização (opcional).
*   **Regras de Negócio:** O check-in só é válido no dia agendado da reunião.

### US09 - Geração de Declarações
*   **Critérios de Aceitação:** Botão "Gerar PDF" que preenche nome, CPF e projeto do aluno.
*   **Regras de Negócio:** Requer que os dados do aluno estejam completos no perfil.

### US10 - Acessibilidade (Alto Contraste)
*   **Critérios de Aceitação:** Alternância de tema via botão global, garantindo contraste WCAG.
*   **Regras de Negócio:** A preferência deve ser salva no perfil do usuário.
