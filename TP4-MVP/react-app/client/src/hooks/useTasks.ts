import { trpc } from "../lib/trpc";
import { Task, CreateTaskInput, UpdateTaskInput } from "../types";

export const useTasks = (projectId: number) => {
  const utils = trpc.useUtils();

  const { data: tasks, isLoading, error } = trpc.tasks.listByProject.useQuery({ projectId });

  const createTaskMutation = trpc.tasks.create.useMutation({
    onSuccess: () => {
      utils.tasks.listByProject.invalidate({ projectId });
    },
  });

  const updateTaskMutation = trpc.tasks.update.useMutation({
    onSuccess: () => {
      utils.tasks.listByProject.invalidate({ projectId });
    },
  });

  const createTask = async (taskData: CreateTaskInput) => {
    return createTaskMutation.mutateAsync(taskData);
  };

  const updateTask = async (taskId: number, taskData: UpdateTaskInput['data']) => {
    return updateTaskMutation.mutateAsync({ taskId, data: taskData });
  };

  return {
    tasks,
    isLoading,
    error,
    createTask,
    updateTask,
  };
};
