import { eq, and, or, sql } from "drizzle-orm";
import { MySql2Database, drizzle } from "drizzle-orm/mysql2";
import { InsertUser, users, projects, tasks, projectMembers, attendanceRecords, editais, comments, notifications, projectFiles } from "../drizzle/schema";
import { ENV } from './_core/env';
import * as schema from "../drizzle/schema";
import mysql from 'mysql2/promise';

let _db: MySql2Database<typeof schema> | null = null;

// Lazily create the drizzle instance so local tooling can run without a DB.
export async function getDb() {
  if (!_db && process.env.DATABASE_URL) {
    try {
      const pool = mysql.createPool(process.env.DATABASE_URL);
      _db = drizzle(pool, { schema: schema, mode: 'default' });
    } catch (error) {
      console.warn("[Database] Failed to connect:", error);
      _db = null;
    }
  }
  return _db;
}

export async function upsertUser(user: InsertUser): Promise<void> {
  if (!user.openId) {
    throw new Error("User openId is required for upsert");
  }

  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot upsert user: database not available");
    return;
  }

  try {
    const values: InsertUser = {
      openId: user.openId,
    };
    const updateSet: Record<string, unknown> = {};

    const textFields = ["name", "email", "loginMethod"] as const;
    type TextField = (typeof textFields)[number];

    const assignNullable = (field: TextField) => {
      const value = user[field];
      if (value === undefined) return;
      const normalized = value ?? null;
      values[field] = normalized;
      updateSet[field] = normalized;
    };

    textFields.forEach(assignNullable);

    if (user.lastSignedIn !== undefined) {
      values.lastSignedIn = user.lastSignedIn;
      updateSet.lastSignedIn = user.lastSignedIn;
    }
    if (user.role !== undefined) {
      values.role = user.role;
      updateSet.role = user.role;
    } else if (user.openId === ENV.ownerOpenId) {
      values.role = 'admin';
      updateSet.role = 'admin';
    }

    if (!values.lastSignedIn) {
      values.lastSignedIn = new Date();
    }

    if (Object.keys(updateSet).length === 0) {
      updateSet.lastSignedIn = new Date();
    }

    await db.insert(users).values(values).onDuplicateKeyUpdate({
      set: updateSet,
    });
  } catch (error) {
    console.error("[Database] Failed to upsert user:", error);
    throw error;
  }
}

export async function getUserByOpenId(openId: string) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user: database not available");
    return undefined;
  }

  const result = await db.select().from(users).where(eq(users.openId, openId)).limit(1);

  return result.length > 0 ? result[0] : undefined;
}

// Project Queries
export async function getProjectsByUser(userId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(projects).where(eq(projects.orientadorId, userId));
}

export async function getProjectById(projectId: number) {
  const db = await getDb();
  if (!db) return undefined;
  const result = await db.select().from(projects).where(eq(projects.id, projectId)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function createProject(data: Omit<typeof projects.$inferInsert, 'id' | 'createdAt' | 'updatedAt'> & { orientadorId?: number | null }) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(projects).values(data);
  return result;
}

export async function updateProject(projectId: number, data: Partial<typeof projects.$inferInsert>) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.update(projects).set(data).where(eq(projects.id, projectId));
  return result;
}

// Task Queries
export async function getTasksByProject(projectId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(tasks).where(eq(tasks.projectId, projectId));
}

export async function createTask(data: typeof tasks.$inferInsert) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(tasks).values(data);
  return result;
}

export async function updateTask(taskId: number, data: Partial<typeof tasks.$inferInsert>) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.update(tasks).set(data).where(eq(tasks.id, taskId));
  return result;
}

// Attendance Queries
export async function getAttendanceByProject(projectId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(attendanceRecords).where(eq(attendanceRecords.projectId, projectId));
}

export async function createAttendanceRecord(data: typeof attendanceRecords.$inferInsert) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(attendanceRecords).values(data);
  return result;
}

// Edital Queries
export async function getAllEditais() {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(editais);
}

export async function createEdital(data: typeof editais.$inferInsert) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(editais).values(data);
  return result;
}

// Project Member Queries
export async function getProjectMembers(projectId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(projectMembers).where(eq(projectMembers.projectId, projectId));
}

export async function addProjectMember(data: typeof projectMembers.$inferInsert) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(projectMembers).values(data);
  return result;
}

// Comment Queries
export async function getCommentsByProject(projectId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(comments).where(eq(comments.projectId, projectId));
}

export async function createComment(data: typeof comments.$inferInsert) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(comments).values(data);
  return result;
}

// Notification Queries
export async function getNotificationsByUser(userId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(notifications).where(eq(notifications.userId, userId));
}

export async function createNotification(data: typeof notifications.$inferInsert) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(notifications).values(data);
  return result;
}

export async function markNotificationAsRead(notificationId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.update(notifications).set({ read: 1 }).where(eq(notifications.id, notificationId));
  return result;
}

// File Queries
export async function getFilesByProject(projectId: number) {
  const db = await getDb();
  if (!db) return [];
  return db.select().from(projectFiles).where(eq(projectFiles.projectId, projectId));
}

export async function uploadProjectFile(data: typeof projectFiles.$inferInsert) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");
  const result = await db.insert(projectFiles).values(data);
  return result;
}

// Dashboard Statistics
export async function getDashboardStats(userId: number) {
  const db = await getDb();
  if (!db) return { totalProjects: 0, pendingTasks: 0, totalAttendance: 0, openEditais: 0 };

  const totalProjectsResult = await db.select({ count: sql<number>`count(*)` }).from(projects).where(eq(projects.orientadorId, userId));
  const totalProjects = totalProjectsResult[0]?.count || 0;

  const pendingTasksResult = await db.select({ count: sql<number>`count(*)` }).from(tasks).where(and(eq(tasks.assignedToId, userId), eq(tasks.status, 'Pendente')));
  const pendingTasks = pendingTasksResult[0]?.count || 0;

  const totalAttendanceResult = await db.select({ count: sql<number>`count(*)` }).from(attendanceRecords).where(and(eq(attendanceRecords.userId, userId), eq(attendanceRecords.present, 1)));
  const totalAttendance = totalAttendanceResult[0]?.count || 0;

  const openEditaisResult = await db.select({ count: sql<number>`count(*)` }).from(editais).where(eq(editais.status, 'Aberto'));
  const openEditais = openEditaisResult[0]?.count || 0;

  return { totalProjects, pendingTasks, totalAttendance, openEditais };
}
