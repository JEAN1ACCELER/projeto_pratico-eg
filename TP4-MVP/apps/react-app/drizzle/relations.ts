import { relations } from "drizzle-orm";
import { users, projects, tasks, projectMembers, attendanceRecords, editais, relatedProjects, comments, notifications, projectFiles } from "./schema";

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
