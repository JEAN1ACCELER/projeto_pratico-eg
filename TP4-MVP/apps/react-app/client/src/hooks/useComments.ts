import { trpc } from "../lib/trpc";
import { Comment, CreateCommentInput } from "../types";

export const useComments = (projectId: number) => {
  const utils = trpc.useUtils();

  const { data: comments, isLoading, error } = trpc.comments.listByProject.useQuery({ projectId });

  const createCommentMutation = trpc.comments.create.useMutation({
    onSuccess: () => {
      utils.comments.listByProject.invalidate({ projectId });
    },
  });

  const createComment = async (commentData: CreateCommentInput) => {
    return createCommentMutation.mutateAsync(commentData);
  };

  return {
    comments,
    isLoading,
    error,
    createComment,
  };
};
