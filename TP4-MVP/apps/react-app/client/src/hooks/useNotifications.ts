import { trpc } from "../lib/trpc";
import { Notification, CreateNotificationInput, MarkNotificationAsReadInput } from "../types";

export const useNotifications = () => {
  const utils = trpc.useUtils();

  const { data: notifications, isLoading, error } = trpc.notifications.listByUser.useQuery();

  const createNotificationMutation = trpc.notifications.create.useMutation({
    onSuccess: () => {
      utils.notifications.listByUser.invalidate();
    },
  });

  const markAsReadMutation = trpc.notifications.markAsRead.useMutation({
    onSuccess: () => {
      utils.notifications.listByUser.invalidate();
    },
  });

  const createNotification = async (notificationData: CreateNotificationInput) => {
    return createNotificationMutation.mutateAsync(notificationData);
  };

  const markAsRead = async (notificationId: MarkNotificationAsReadInput['notificationId']) => {
    return markAsReadMutation.mutateAsync({ notificationId });
  };

  return {
    notifications,
    isLoading,
    error,
    createNotification,
    markAsRead,
  };
};
