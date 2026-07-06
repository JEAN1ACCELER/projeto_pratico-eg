import { trpc } from "../lib/trpc";
import { ProjectMember, AddProjectMemberInput } from "../types";

export const useProjectMembers = (projectId: number) => {
  const utils = trpc.useUtils();

  const { data: members, isLoading, error } = trpc.projectMembers.listByProject.useQuery({ projectId });

  const addMemberMutation = trpc.projectMembers.add.useMutation({
    onSuccess: () => {
      utils.projectMembers.listByProject.invalidate({ projectId });
    },
  });

  const addMember = async (memberData: AddProjectMemberInput) => {
    return addMemberMutation.mutateAsync(memberData);
  };

  return {
    members,
    isLoading,
    error,
    addMember,
  };
};
