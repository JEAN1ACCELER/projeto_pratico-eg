import { trpc } from "../lib/trpc";
import { UploadProjectFileInput } from "../types";

export const useProjectFiles = (projectId: number) => {
  const utils = trpc.useUtils();

  const { data: files, isLoading, error } = trpc.files.listByProject.useQuery({ projectId });

  const uploadFileMutation = trpc.files.upload.useMutation({
    onSuccess: () => {
      utils.files.listByProject.invalidate({ projectId });
    },
  });

  const uploadFile = async (fileData: UploadProjectFileInput) => {
    return uploadFileMutation.mutateAsync(fileData);
  };

  return {
    files,
    isLoading,
    error,
    uploadFile,
  };
};
