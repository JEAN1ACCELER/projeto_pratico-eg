import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useNotifications } from "@/hooks/useNotifications";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";

export default function NotificationsPanel() {
  const { notifications, isLoading, error, markAsRead } = useNotifications();

  if (isLoading) {
    return (
      <div className="flex justify-center items-center h-full">
        <Loader2 className="h-8 w-8 animate-spin" />
        <p className="ml-2">Carregando notificações...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex justify-center items-center h-full text-red-500">
        <p>Erro ao carregar notificações: {error.message}</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Suas Notificações</CardTitle>
        </CardHeader>
        <CardContent>
          {notifications?.length === 0 ? (
            <p>Nenhuma notificação.</p>
          ) : (
            <ul className="space-y-2">
              {notifications?.map((notification) => (
                <li key={notification.id} className={`border-b pb-2 ${notification.read ? "text-muted-foreground" : "font-semibold"}`}>
                  <div className="flex justify-between items-center">
                    <div>
                      <p className="text-sm">{notification.title}</p>
                      {notification.message && <p className="text-xs">{notification.message}</p>}
                      <p className="text-xs text-muted-foreground">{notification.createdAt.toLocaleDateString()} {notification.createdAt.toLocaleTimeString()}</p>
                    </div>
                    {!notification.read && (
                      <Button variant="ghost" size="sm" onClick={() => markAsRead(notification.id)}>
                        Marcar como lida
                      </Button>
                    )}
                  </div>
                </li>
              ))}
            </ul>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
