# 👥 17 Personas Detalhadas - E-Project

Este documento apresenta 17 perfis de usuários do sistema E-Project, integrando suas necessidades a Histórias de Usuário, Critérios de Aceitação e Regras de Negócio.

---

## 👨‍🏫 Grupo 1: Professores Orientadores

### 1. Dr. Augusto (Pesquisador Sênior)
*   **História:** Enquanto orientador sênior, desejo visualizar um dashboard com indicadores de progresso de todos os meus 12 orientandos para identificar atrasos rapidamente.
*   **Critérios de Aceitação:** O dashboard deve exibir barras de progresso percentuais e alertas visuais (vermelho/amarelo) para tarefas atrasadas.
*   **Regras de Negócio:** Os indicadores devem ser calculados com base na data de entrega das tarefas no Backlog do Sprint.

### 2. Profa. Helena (Coordenadora de Extensão)
*   **História:** Enquanto coordenadora, desejo filtrar projetos por modalidade (PIBEX/PACE) para gerar relatórios de impacto social.
*   **Critérios de Aceitação:** Filtros funcionais na listagem de projetos que atualizam a visão em tempo real.
*   **Regras de Negócio:** Apenas projetos com status "Ativo" devem ser contabilizados no relatório de impacto.

### 3. Prof. Ricardo (Novo Docente)
*   **História:** Enquanto novo professor, desejo utilizar templates pré-configurados da UFAM para cadastrar meu primeiro projeto PIBIC sem erros de formulário.
*   **Critérios de Aceitação:** Opção de "Novo Projeto via Template" que preenche campos obrigatórios automaticamente.
*   **Regras de Negócio:** Os templates devem ser atualizados anualmente conforme os editais vigentes.

### 4. Dr. Carlos (Orientador de Pós-Graduação)
*   **História:** Enquanto orientador de mestrado, desejo um espaço para revisão de versões de dissertação com histórico de comentários.
*   **Critérios de Aceitação:** Upload de arquivos com versionamento (v1, v2, final) e campo de feedback textual.
*   **Regras de Negócio:** O sistema deve manter o histórico de todas as versões enviadas, sem sobrescrever arquivos antigos.

---

## 👨‍🎓 Grupo 2: Alunos Bolsistas e Voluntários

### 5. Juliana (Aluna Voluntária)
*   **História:** Enquanto voluntária, desejo receber notificações de prazos no celular para conciliar a pesquisa com meu estágio externo.
*   **Critérios de Aceitação:** Notificações push ou via e-mail 48h antes do prazo final de uma tarefa.
*   **Regras de Negócio:** O usuário deve poder desativar notificações específicas nas configurações de perfil.

### 6. Lucas (Bolsista PIBIC)
*   **História:** Enquanto bolsista, desejo realizar o upload do meu relatório parcial diretamente no sistema para validação do orientador.
*   **Critérios de Aceitação:** Botão de upload simples com suporte a PDF e confirmação de envio.
*   **Regras de Negócio:** O envio só é permitido se todos os campos obrigatórios do perfil do aluno estiverem preenchidos.

### 7. Beatriz (Aluna de Iniciação Tecnológica - PIBITI)
*   **História:** Enquanto aluna de tecnologia, desejo registrar o desenvolvimento de protótipos em um log de atividades compartilhado.
*   **Critérios de Aceitação:** Campo de texto para "Diário de Bordo" dentro de cada tarefa.
*   **Regras de Negócio:** O log deve registrar automaticamente a data e hora de cada inserção.

### 8. Gabriel (Aluno de Extensão - PIBEX)
*   **História:** Enquanto aluno de extensão, desejo registrar fotos das atividades de campo para compor o relatório final.
*   **Critérios de Aceitação:** Galeria de anexos que suporte formatos de imagem (JPG/PNG).
*   **Regras de Negócio:** Limite de 5MB por imagem para otimizar o armazenamento.

### 9. Mariana (Aluna de Mestrado)
*   **História:** Enquanto mestranda, desejo visualizar o cronograma completo da minha pesquisa para garantir a entrega da qualificação no prazo.
*   **Critérios de Aceitação:** Visualização de linha do tempo (Gantt simples) dos marcos do projeto.
*   **Regras de Negócio:** Marcos (milestones) só podem ser alterados pelo orientador.

---

## ♿ Grupo 3: Acessibilidade e Inclusão

### 10. Marcos (Técnico com Baixa Visão)
*   **História:** Enquanto usuário com baixa visão, desejo ativar um modo de alto contraste para navegar no sistema sem fadiga ocular.
*   **Critérios de Aceitação:** Botão de alternância de tema que altera cores de fundo e texto para padrões WCAG AAA.
*   **Regras de Negócio:** A preferência de tema deve ser persistida no banco de dados para acessos futuros.

### 11. André (Aluno com Daltonismo)
*   **História:** Enquanto usuário daltônico, desejo que os status das tarefas (Atrasado/No Prazo) sejam indicados por ícones e não apenas por cores.
*   **Critérios de Aceitação:** Uso de símbolos (✅, ⚠️, ❌) acompanhando as cores de status.
*   **Regras de Negócio:** Todos os elementos informativos coloridos devem ter um equivalente textual ou iconográfico.

### 12. Sofia (Usuária de Leitor de Tela)
*   **História:** Enquanto usuária cega, desejo que todos os botões e imagens possuam descrições alternativas (Alt Text) para navegação via TalkBack/NVDA.
*   **Critérios de Aceitação:** Navegação por teclado lógica e presença de atributos ARIA em todos os componentes interativos.
*   **Regras de Negócio:** O sistema deve passar em testes de acessibilidade automatizados (ex: Lighthouse) com score > 90.

---

## 🛠️ Grupo 4: Suporte e Administração

### 13. Felipe (Monitor de TI)
*   **História:** Enquanto suporte, desejo acessar uma base de conhecimento integrada para tirar dúvidas rápidas de professores.
*   **Critérios de Aceitação:** Seção de FAQ pesquisável dentro do sistema.
*   **Regras de Negócio:** O FAQ deve ser editável apenas por usuários com nível de acesso "Administrador".

### 14. Sandra (Secretária de Departamento)
*   **História:** Enquanto secretária, desejo gerar uma lista de todos os bolsistas ativos do departamento para fins de folha de pagamento.
*   **Critérios de Aceitação:** Exportação de tabela para formato CSV/Excel.
*   **Regras de Negócio:** A exportação deve respeitar a LGPD, omitindo dados sensíveis não necessários para a folha.

---

## 🤝 Grupo 5: Perfis Especiais e Voluntários Externos

### 15. Roberto (Colaborador Externo/Voluntário)
*   **História:** Enquanto colaborador de outra instituição, desejo acessar apenas as tarefas que me foram atribuídas para colaborar no projeto sem ver dados sensíveis da UFAM.
*   **Critérios de Aceitação:** Nível de acesso "Convidado" com permissões restritas.
*   **Regras de Negócio:** Convidados não podem visualizar editais internos ou dados financeiros do projeto.

### 16. Aline (Aluna de Graduação - Interessada)
*   **História:** Enquanto aluna interessada em pesquisa, desejo visualizar o feed de editais abertos para encontrar uma oportunidade de voluntariado.
*   **Critérios de Aceitação:** Acesso público (sem login) à lista de editais abertos.
*   **Regras de Negócio:** O acesso público é apenas de leitura, sem permissão para interagir com projetos.

### 17. Sr. João (Comunidade Externa - Beneficiário de Extensão)
*   **História:** Enquanto membro da comunidade atendida por um projeto PACE, desejo realizar o check-in em uma atividade para validar minha participação.
*   **Critérios de Aceitação:** Leitura de QR Code gerado pelo aluno extensionista para registro de presença.
*   **Regras de Negócio:** O check-in via QR Code deve validar a geolocalização para garantir a presença no local da atividade.
