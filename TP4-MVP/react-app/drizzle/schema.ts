import { int, mysqlEnum, mysqlTable, text, timestamp, varchar, primaryKey } from "drizzle-orm/mysql-core";
import { relations } from "drizzle-orm";

/**
 * Core user table backing auth flow.
 * Extend this file with additional tables as your product grows.
 * Columns use camelCase to match both database fields and generated types.
 */
export const users = mysqlTable("users", {
  /**
   * Surrogate primary key. Auto-incremented numeric value managed by the database.
   * Use this for relations between tables.
   */
  id: int("id").autoincrement().primaryKey(),
  /** Manus OAuth identifier (openId) returned from the OAuth callback. Unique per user. */
  openId: varchar("openId", { length: 64 }).notNull().unique(),
  name: text("name"),
  email: varchar("email", { length: 320 }),
  loginMethod: varchar("loginMethod", { length: 64 }),
  role: mysqlEnum("role", ["user", "admin", "orientador", "orientando"]).default("user").notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
  lastSignedIn: timestamp("lastSignedIn").defaultNow().notNull(),
});

export type User = typeof users.$inferSelect;
export type InsertUser = typeof users.$inferInsert;

export const projects = mysqlTable("projects", {
  id: int("id").autoincrement().primaryKey(),
  title: varchar("title", { length: 255 }).notNull(),
  type: mysqlEnum("type", ["PIBIC", "PACE", "Pibex", "PIBID", "Mestrado"]).notNull(),
  status: mysqlEnum("status", ["Em andamento", "Concluído", "Atrasado", "Planejamento"]).notNull(),
  startDate: timestamp("startDate").notNull(),
  endDate: timestamp("endDate").notNull(),
  orientadorId: int("orientadorId"),
  description: text("description"),
  progress: int("progress").default(0).notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
});

export const tasks = mysqlTable("tasks", {
  id: int("id").autoincrement().primaryKey(),
  projectId: int("projectId").notNull(),
  title: varchar("title", { length: 255 }).notNull(),
  description: text("description"),
  status: mysqlEnum("status", ["Pendente", "Em progresso", "Concluída"]).notNull(),
  assignedToId: int("assignedToId"),
  dueDate: timestamp("dueDate"),
  priority: mysqlEnum("priority", ["Alta", "Média", "Baixa"]).notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
});

export const projectMembers = mysqlTable("projectMembers", {
  id: int("id").autoincrement().primaryKey(),
  projectId: int("projectId").notNull(),
  userId: int("userId").notNull(),
  role: mysqlEnum("role", ["orientando", "orientador"]).notNull(),
  joinedAt: timestamp("joinedAt").defaultNow().notNull(),
});

export const attendanceRecords = mysqlTable("attendanceRecords", {
  id: int("id").autoincrement().primaryKey(),
  projectId: int("projectId").notNull(),
  userId: int("userId").notNull(),
  date: timestamp("date").notNull(),
  present: int("present").notNull(), // 0 for false, 1 for true
  justification: text("justification"),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
});

export const editais = mysqlTable("editais", {
  id: int("id").autoincrement().primaryKey(),
  title: varchar("title", { length: 255 }).notNull(),
  number: varchar("number", { length: 255 }),
  description: text("description"),
  proReitoria: varchar("proReitoria", { length: 255 }),
  publishDate: timestamp("publishDate").notNull(),
  deadline: timestamp("deadline").notNull(),
  url: varchar("url", { length: 2048 }),
  status: mysqlEnum("status", ["Aberto", "Encerrando em breve", "Encerrado"]).notNull(),
  relatedPrograms: text("relatedPrograms"),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
});

export const relatedProjects = mysqlTable("relatedProjects", {
  id: int("id").autoincrement().primaryKey(),
  projectId: int("projectId").notNull(),
  relatedProjectId: int("relatedProjectId").notNull(),
});

export const comments = mysqlTable("comments", {
  id: int("id").autoincrement().primaryKey(),
  projectId: int("projectId").notNull(),
  userId: int("userId").notNull(),
  content: text("content").notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
  updatedAt: timestamp("updatedAt").defaultNow().onUpdateNow().notNull(),
});

export const notifications = mysqlTable("notifications", {
  id: int("id").autoincrement().primaryKey(),
  userId: int("userId").notNull(),
  title: varchar("title", { length: 255 }).notNull(),
  message: text("message"),
  type: mysqlEnum("type", ["info", "warning", "error", "success"]).notNull(),
  read: int("read").default(0).notNull(), // 0 for false, 1 for true
  createdAt: timestamp("createdAt").defaultNow().notNull(),
});

export const projectFiles = mysqlTable("projectFiles", {
  id: int("id").autoincrement().primaryKey(),
  projectId: int("projectId").notNull(),
  fileName: varchar("fileName", { length: 255 }).notNull(),
  fileUrl: varchar("fileUrl", { length: 2048 }).notNull(),
  fileSize: int("fileSize").notNull(),
  uploadedBy: int("uploadedBy").notNull(),
  createdAt: timestamp("createdAt").defaultNow().notNull(),
});

// Relations
export const usersRelations = relations(users, ({ many }) => ({
  projects: many(projects),
  projectMembers: many(projectMembers),
  tasks: many(tasks),
  attendanceRecords: many(attendanceRecords),
  comments: many(comments),
  notifications: many(notifications),
  projectFiles: many(projectFiles),
}));

export const projectsRelations = relations(projects, ({ one, many }) => ({
  orientador: one(users, { fields: [projects.orientadorId], references: [users.id] }),
  tasks: many(tasks),
  projectMembers: many(projectMembers),
  attendanceRecords: many(attendanceRecords),
  comments: many(comments),
  notifications: many(notifications),
  projectFiles: many(projectFiles),
  relatedProjects: many(relatedProjects, { relationName: 'mainProject' }),
  relatedByProjects: many(relatedProjects, { relationName: 'relatedProject' }),
}));

export const tasksRelations = relations(tasks, ({ one }) => ({
  project: one(projects, { fields: [tasks.projectId], references: [projects.id] }),
  assignedTo: one(users, { fields: [tasks.assignedToId], references: [users.id] }),
}));

export const projectMembersRelations = relations(projectMembers, ({ one }) => ({
  project: one(projects, { fields: [projectMembers.projectId], references: [projects.id] }),
  user: one(users, { fields: [projectMembers.userId], references: [users.id] }),
}));

export const attendanceRecordsRelations = relations(attendanceRecords, ({ one }) => ({
  project: one(projects, { fields: [attendanceRecords.projectId], references: [projects.id] }),
  user: one(users, { fields: [attendanceRecords.userId], references: [users.id] }),
}));

export const editaisRelations = relations(editais, ({ many }) => ({
  // No direct relations to other tables specified, but can be added if needed
}));

export const relatedProjectsRelations = relations(relatedProjects, ({ one }) => ({
  mainProject: one(projects, { fields: [relatedProjects.projectId], references: [projects.id], relationName: 'mainProject' }),
  relatedProject: one(projects, { fields: [relatedProjects.relatedProjectId], references: [projects.id], relationName: 'relatedProject' }),
}));

export const commentsRelations = relations(comments, ({ one }) => ({
  project: one(projects, { fields: [comments.projectId], references: [projects.id] }),
  user: one(users, { fields: [comments.userId], references: [users.id] }),
}));

export const notificationsRelations = relations(notifications, ({ one }) => ({
  user: one(users, { fields: [notifications.userId], references: [users.id] }),
}));

export const projectFilesRelations = relations(projectFiles, ({ one }) => ({
  project: one(projects, { fields: [projectFiles.projectId], references: [projects.id] }),
  uploadedByUser: one(users, { fields: [projectFiles.uploadedBy], references: [users.id] }),
}));
