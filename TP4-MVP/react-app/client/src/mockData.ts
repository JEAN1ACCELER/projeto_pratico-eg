import { Project, Task, Edital, AttendanceRecord, Comment, Notification, ProjectFile, ProjectMember } from "./types";

export const mockUsers = [
  {
    id: 1,
    openId: "user1_openid",
    name: "João Silva",
    email: "joao.silva@example.com",
    loginMethod: "manus",
    role: "admin",
    createdAt: new Date(),
    updatedAt: new Date(),
    lastSignedIn: new Date(),
  },
  {
    id: 2,
    openId: "user2_openid",
    name: "Maria Souza",
    email: "maria.souza@example.com",
    loginMethod: "manus",
    role: "user",
    createdAt: new Date(),
    updatedAt: new Date(),
    lastSignedIn: new Date(),
  },
];

export const mockProjects: Project[] = [
  {
    id: 1,
    title: "Pesquisa sobre IA na Educação",
    type: "PIBIC",
    status: "Em andamento",
    startDate: new Date("2023-03-01"),
    endDate: new Date("2024-02-28"),
    orientadorId: 1,
    description: "Estudo aprofundado sobre a aplicação de inteligência artificial em métodos de ensino e aprendizagem.",
    progress: 75,
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    id: 2,
    title: "Desenvolvimento de Sistema de Gerenciamento Acadêmico",
    type: "PACE",
    status: "Concluído",
    startDate: new Date("2022-08-15"),
    endDate: new Date("2023-07-31"),
    orientadorId: 1,
    description: "Criação de uma plataforma web para otimizar a gestão de projetos e atividades acadêmicas.",
    progress: 100,
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    id: 3,
    title: "Análise de Dados Climáticos na Amazônia",
    type: "Pibex",
    status: "Atrasado",
    startDate: new Date("2023-01-10"),
    endDate: new Date("2023-12-31"),
    orientadorId: 2,
    description: "Coleta e análise de dados de longo prazo para entender as mudanças climáticas na região amazônica.",
    progress: 40,
    createdAt: new Date(),
    updatedAt: new Date(),
  },
];

export const mockTasks: Task[] = [
  {
    id: 1,
    projectId: 1,
    title: "Revisar literatura sobre IA",
    description: "Pesquisar artigos e livros recentes sobre IA aplicada à educação.",
    status: "Em progresso",
    assignedToId: 2,
    dueDate: new Date("2024-07-15"),
    priority: "Alta",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    id: 2,
    projectId: 1,
    title: "Preparar questionário para alunos",
    description: "Elaborar perguntas para pesquisa de campo com estudantes.",
    status: "Pendente",
    assignedToId: 2,
    dueDate: new Date("2024-08-01"),
    priority: "Média",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    id: 3,
    projectId: 2,
    title: "Codificar módulo de autenticação",
    description: "Implementar sistema de login e registro de usuários.",
    status: "Concluída",
    assignedToId: 1,
    dueDate: new Date("2023-10-20"),
    priority: "Alta",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
];

export const mockAttendanceRecords: AttendanceRecord[] = [
  {
    id: 1,
    projectId: 1,
    userId: 2,
    date: new Date("2024-06-03"),
    present: 1,
    justification: null,
    createdAt: new Date(),
  },
  {
    id: 2,
    projectId: 1,
    userId: 2,
    date: new Date("2024-06-10"),
    present: 0,
    justification: "Problemas de saúde.",
    createdAt: new Date(),
  },
];

export const mockEditais: Edital[] = [
  {
    id: 1,
    title: "Edital PIBIC 2024",
    number: "001/2024",
    description: "Abertura de inscrições para projetos de Iniciação Científica.",
    proReitoria: "PROPESQ",
    publishDate: new Date("2024-05-01"),
    deadline: new Date("2024-07-30"),
    url: "https://example.com/edital-pibic-2024",
    status: "Aberto",
    relatedPrograms: "PIBIC, PIBITI",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    id: 2,
    title: "Chamada Pública para Mestrado",
    number: "005/2023",
    description: "Seleção de candidatos para o programa de Mestrado em Computação.",
    proReitoria: "PPGCOMP",
    publishDate: new Date("2023-11-01"),
    deadline: new Date("2024-01-15"),
    url: "https://example.com/mestrado-comp",
    status: "Encerrado",
    relatedPrograms: "Mestrado",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
];

export const mockComments: Comment[] = [
  {
    id: 1,
    projectId: 1,
    userId: 1,
    content: "Ótima iniciativa! Precisamos focar na metodologia.",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
  {
    id: 2,
    projectId: 1,
    userId: 2,
    content: "Concordo, professor. Já estou levantando os dados.",
    createdAt: new Date(),
    updatedAt: new Date(),
  },
];

export const mockNotifications: Notification[] = [
  {
    id: 1,
    userId: 2,
    title: "Nova tarefa atribuída",
    message: "Você foi atribuído à tarefa 'Revisar literatura sobre IA' no projeto 'Pesquisa sobre IA na Educação'.",
    type: "info",
    read: 0,
    createdAt: new Date(),
  },
  {
    id: 2,
    userId: 1,
    title: "Prazo de edital se aproximando",
    message: "O prazo para o 'Edital PIBIC 2024' encerra em 30/07/2024.",
    type: "warning",
    read: 0,
    createdAt: new Date(),
  },
];

export const mockProjectFiles: ProjectFile[] = [
  {
    id: 1,
    projectId: 1,
    fileName: "Plano de Pesquisa IA.pdf",
    fileUrl: "https://example.com/files/plano_ia.pdf",
    fileSize: 1024 * 500, // 500KB
    uploadedBy: 1,
    createdAt: new Date(),
  },
  {
    id: 2,
    projectId: 2,
    fileName: "Documentação do Sistema.docx",
    fileUrl: "https://example.com/files/docs_sistema.docx",
    fileSize: 1024 * 1200, // 1.2MB
    uploadedBy: 2,
    createdAt: new Date(),
  },
];

export const mockProjectMembers: ProjectMember[] = [
  {
    id: 1,
    projectId: 1,
    userId: 1,
    role: "orientador",
    joinedAt: new Date(),
  },
  {
    id: 2,
    projectId: 1,
    userId: 2,
    role: "orientando",
    joinedAt: new Date(),
  },
];
