import { trpc } from "../lib/trpc";
import { Edital, CreateEditalInput } from "../types";

export const useEditais = () => {
  const utils = trpc.useUtils();

  const { data: editais, isLoading, error } = trpc.editais.list.useQuery();

  const createEditalMutation = trpc.editais.create.useMutation({
    onSuccess: () => {
      utils.editais.list.invalidate();
    },
  });

  const createEdital = async (editalData: CreateEditalInput) => {
    return createEditalMutation.mutateAsync(editalData);
  };

  return {
    editais,
    isLoading,
    error,
    createEdital,
  };
};
