import { z } from "zod";

export const UserRoleSchema = z.enum(["orientador", "orientando", "user", "admin"]);
export type UserRole = z.infer<typeof UserRoleSchema>;

export const ProjectTypeSchema = z.enum(["PIBIC", "PACE", "Pibex", "PIBID", "Mestrado"]);
export type ProjectType = z.infer<typeof ProjectTypeSchema>;

export const ProjectStatusSchema = z.enum(["Em andamento", "Concluído", "Atrasado", "Planejamento"]);
export type ProjectStatus = z.infer<typeof ProjectStatusSchema>;

export const TaskStatusSchema = z.enum(["Pendente", "Em progresso", "Concluída"]);
export type TaskStatus = z.infer<typeof TaskStatusSchema>;

export const TaskPrioritySchema = z.enum(["Alta", "Média", "Baixa"]);
export type TaskPriority = z.infer<typeof TaskPrioritySchema>;

export const EditalStatusSchema = z.enum(["Aberto", "Encerrando em breve", "Encerrado"]);
export type EditalStatus = z.infer<typeof EditalStatusSchema>;

export const NotificationTypeSchema = z.enum(["info", "warning", "error", "success"]);
export type NotificationType = z.infer<typeof NotificationTypeSchema>;

export const ViewSchema = z.enum(["dashboard", "project", "editais", "attendance", "techstack"]);
export type View = z.infer<typeof ViewSchema>;

// Inferindo tipos do Drizzle ORM para usar no frontend
import { users, projects, tasks, attendanceRecords, editais, comments, notifications, projectFiles, projectMembers } from "../drizzle/schema";
import { inferRouterInputs } from "@trpc/server";
import { AppRouter } from "../server/routers";

export type RouterInputs = inferRouterInputs<AppRouter>;

export type User = typeof users.$inferSelect;
export type Project = typeof projects.$inferSelect;
export type Task = typeof tasks.$inferSelect;
export type AttendanceRecord = typeof attendanceRecords.$inferSelect;
export type Edital = typeof editais.$inferSelect;
export type Comment = typeof comments.$inferSelect;
export type Notification = typeof notifications.$inferSelect;
export type ProjectFile = typeof projectFiles.$inferSelect;
export type ProjectMember = typeof projectMembers.$inferSelect;

export type CreateProjectInput = RouterInputs["projects"]["create"];
export type UpdateProjectInput = RouterInputs["projects"]["update"];

export type CreateTaskInput = RouterInputs["tasks"]["create"];
export type UpdateTaskInput = RouterInputs["tasks"]["update"];

export type CreateAttendanceRecordInput = RouterInputs["attendance"]["create"];

export type CreateEditalInput = RouterInputs["editais"]["create"];

export type AddProjectMemberInput = RouterInputs["projectMembers"]["add"];

export type CreateCommentInput = RouterInputs["comments"]["create"];

export type CreateNotificationInput = RouterInputs["notifications"]["create"];
export type MarkNotificationAsReadInput = RouterInputs["notifications"]["markAsRead"];

export type UploadProjectFileInput = RouterInputs["files"]["upload"];
