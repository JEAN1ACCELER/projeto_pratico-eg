import { trpc } from "../lib/trpc";

export const useDashboardStats = () => {
  const { data: stats, isLoading, error } = trpc.dashboard.stats.useQuery();

  return {
    stats,
    isLoading,
    error,
  };
};
