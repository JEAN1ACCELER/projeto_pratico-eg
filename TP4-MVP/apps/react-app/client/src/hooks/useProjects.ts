import { trpc } from "../lib/trpc";
import { Project, CreateProjectInput, UpdateProjectInput } from "../types";

export const useProjects = () => {
  const utils = trpc.useUtils();

  const { data: projects, isLoading, error } = trpc.projects.list.useQuery();

  const createProjectMutation = trpc.projects.create.useMutation({
    onSuccess: () => {
      utils.projects.list.invalidate();
    },
  });

  const updateProjectMutation = trpc.projects.update.useMutation({
    onSuccess: () => {
      utils.projects.list.invalidate();
      utils.projects.getById.invalidate();
    },
  });

  const createProject = async (projectData: CreateProjectInput) => {
    return createProjectMutation.mutateAsync(projectData);
  };

  const updateProject = async (projectId: number, projectData: UpdateProjectInput['data']) => {
    return updateProjectMutation.mutateAsync({ projectId, data: projectData });
  };

  return {
    projects,
    isLoading,
    error,
    createProject,
    updateProject,
  };
};
