import { useAuth } from "@/_core/hooks/useAuth";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { getLoginUrl } from "@/const";

export default function Login() {
  const { loading } = useAuth();

  const handleLogin = () => {
    window.location.href = getLoginUrl();
  };

  return (
    <div className="flex min-h-screen items-center justify-center bg-gray-100 dark:bg-gray-900">
      <Card className="w-full max-w-md">
        <CardHeader className="text-center">
          <CardTitle className="text-2xl">Bem-vindo ao Academic Project Management App</CardTitle>
          <CardDescription>Faça login para acessar sua conta</CardDescription>
        </CardHeader>
        <CardContent>
          <Button onClick={handleLogin} className="w-full" disabled={loading}>
            {loading ? "Carregando..." : "Entrar com Manus OAuth"}
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
