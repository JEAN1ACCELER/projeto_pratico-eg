import { COOKIE_NAME } from "../shared/const";
import { NOT_ADMIN_ERR_MSG, UNAUTHED_ERR_MSG } from "./_core/const";
import { getSessionCookieOptions } from "./_core/cookies";
import { systemRouter } from "./_core/systemRouter";
import { publicProcedure, router, protectedProcedure } from "./_core/trpc";
import { z } from "zod";
import { 
  getProjectsByUser, getProjectById, createProject, updateProject,
  getTasksByProject, createTask, updateTask,
  getAttendanceByProject, createAttendanceRecord,
  getAllEditais, createEdital,
  getProjectMembers, addProjectMember,
  getCommentsByProject, createComment,
  getNotificationsByUser, createNotification, markNotificationAsRead,
  getFilesByProject, uploadProjectFile,
  getDashboardStats
} from "./db";

export const appRouter = router({
  system: systemRouter,
  auth: router({
    me: publicProcedure.query(opts => opts.ctx.user),
    logout: publicProcedure.mutation(({ ctx }) => {
      const cookieOptions = getSessionCookieOptions(ctx.req);
      ctx.res.clearCookie(COOKIE_NAME, { ...cookieOptions, maxAge: -1 });
      return {
        success: true,
      } as const;
    }),
  }),

  projects: router({
    list: protectedProcedure.query(async ({ ctx }) => {
      if (!ctx.user) throw new Error("Unauthorized");
      return getProjectsByUser(ctx.user.id);
    }),
    getById: protectedProcedure.input(z.object({ projectId: z.number() })).query(async ({ input }) => {
      return getProjectById(input.projectId);
    }),
    create: protectedProcedure.input(z.object({
      title: z.string(),
      type: z.enum(["PIBIC", "PACE", "Pibex", "PIBID", "Mestrado"]),
      status: z.enum(["Em andamento", "Concluído", "Atrasado", "Planejamento"]),
      startDate: z.date(),
      endDate: z.date(),
      orientadorId: z.number().nullable().optional(),
      description: z.string().nullable().optional(),
      progress: z.number().optional(),
    })).mutation(async ({ input }) => {
      return createProject(input);
    }),
    update: protectedProcedure.input(z.object({
      projectId: z.number(),
      data: z.object({
        title: z.string().optional(),
        type: z.enum(["PIBIC", "PACE", "Pibex", "PIBID", "Mestrado"]).optional(),
        status: z.enum(["Em andamento", "Concluído", "Atrasado", "Planejamento"]).optional(),
        startDate: z.date().optional(),
        endDate: z.date().optional(),
        orientadorId: z.number().nullable().optional(),
        description: z.string().nullable().optional(),
        progress: z.number().optional(),
      }).partial(),
    })).mutation(async ({ input }) => {
      return updateProject(input.projectId, input.data);
    }),
  }),

  tasks: router({
    listByProject: protectedProcedure.input(z.object({ projectId: z.number() })).query(async ({ input }) => {
      return getTasksByProject(input.projectId);
    }),
    create: protectedProcedure.input(z.object({
      projectId: z.number(),
      title: z.string(),
      description: z.string().nullable().optional(),
      status: z.enum(["Pendente", "Em progresso", "Concluída"]),
      assignedToId: z.number().nullable().optional(),
      dueDate: z.date().nullable().optional(),
      priority: z.enum(["Alta", "Média", "Baixa"]),
    })).mutation(async ({ input }) => {
      return createTask(input);
    }),
    update: protectedProcedure.input(z.object({
      taskId: z.number(),
      data: z.object({
        title: z.string().optional(),
        description: z.string().nullable().optional(),
        status: z.enum(["Pendente", "Em progresso", "Concluída"]).optional(),
        assignedToId: z.number().nullable().optional(),
        dueDate: z.date().nullable().optional(),
        priority: z.enum(["Alta", "Média", "Baixa"]).optional(),
      }).partial(),
    })).mutation(async ({ input }) => {
      return updateTask(input.taskId, input.data);
    }),
  }),

  attendance: router({
    listByProject: protectedProcedure.input(z.object({ projectId: z.number() })).query(async ({ input }) => {
      return getAttendanceByProject(input.projectId);
    }),
    create: protectedProcedure.input(z.object({
      projectId: z.number(),
      userId: z.number(),
      date: z.date(),
      present: z.number(),
      justification: z.string().nullable().optional(),
    })).mutation(async ({ input }) => {
      return createAttendanceRecord(input);
    }),
  }),

  editais: router({
    list: publicProcedure.query(async () => {
      return getAllEditais();
    }),
    create: protectedProcedure.input(z.object({
      title: z.string(),
      number: z.string().nullable().optional(),
      description: z.string().nullable().optional(),
      proReitoria: z.string().nullable().optional(),
      publishDate: z.date(),
      deadline: z.date(),
      url: z.string().nullable().optional(),
      status: z.enum(["Aberto", "Encerrando em breve", "Encerrado"]),
      relatedPrograms: z.string().nullable().optional(),
    })).mutation(async ({ input }) => {
      return createEdital(input);
    }),
  }),

  projectMembers: router({
    listByProject: protectedProcedure.input(z.object({ projectId: z.number() })).query(async ({ input }) => {
      return getProjectMembers(input.projectId);
    }),
    add: protectedProcedure.input(z.object({
      projectId: z.number(),
      userId: z.number(),
      role: z.enum(["orientando", "orientador"]),
    })).mutation(async ({ input }) => {
      return addProjectMember(input);
    }),
  }),

  comments: router({
    listByProject: protectedProcedure.input(z.object({ projectId: z.number() })).query(async ({ input }) => {
      return getCommentsByProject(input.projectId);
    }),
    create: protectedProcedure.input(z.object({
      projectId: z.number(),
      userId: z.number(),
      content: z.string(),
    })).mutation(async ({ input }) => {
      return createComment(input);
    }),
  }),

  notifications: router({
    listByUser: protectedProcedure.query(async ({ ctx }) => {
      if (!ctx.user) throw new Error("Unauthorized");
      return getNotificationsByUser(ctx.user.id);
    }),
    create: protectedProcedure.input(z.object({
      userId: z.number(),
      title: z.string(),
      message: z.string().nullable().optional(),
      type: z.enum(["info", "warning", "error", "success"]),
    })).mutation(async ({ input }) => {
      return createNotification(input);
    }),
    markAsRead: protectedProcedure.input(z.object({ notificationId: z.number() })).mutation(async ({ input }) => {
      return markNotificationAsRead(input.notificationId);
    }),
  }),

  files: router({
    listByProject: protectedProcedure.input(z.object({ projectId: z.number() })).query(async ({ input }) => {
      return getFilesByProject(input.projectId);
    }),
    upload: protectedProcedure.input(z.object({
      projectId: z.number(),
      fileName: z.string(),
      fileUrl: z.string(),
      fileSize: z.number(),
      uploadedBy: z.number(),
    })).mutation(async ({ input }) => {
      return uploadProjectFile(input);
    }),
  }),

  dashboard: router({
    stats: protectedProcedure.query(async ({ ctx }) => {
      if (!ctx.user) throw new Error("Unauthorized");
      return getDashboardStats(ctx.user.id);
    }),
  }),
});

export type AppRouter = typeof appRouter;
