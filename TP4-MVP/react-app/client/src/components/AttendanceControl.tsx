import { useParams } from "wouter";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Loader2 } from "lucide-react";
import { useAttendance } from "@/hooks/useAttendance";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { Textarea } from "@/components/ui/textarea";
import { useState } from "react";

export default function AttendanceControl() {
  const params = useParams();
  const projectId = params.id ? parseInt(params.id, 10) : undefined;

  const { attendanceRecords, isLoading, error, createAttendanceRecord } = useAttendance(projectId || 0);

  const [newDate, setNewDate] = useState<string>("");
  const [newUserId, setNewUserId] = useState<string>("");
  const [newPresent, setNewPresent] = useState<boolean>(false);
  const [newJustification, setNewJustification] = useState<string>("");

  if (!projectId) {
    return <div className="text-red-500">ID do projeto não fornecido.</div>;
  }

  if (isLoading) {
    return (
      <div className="flex justify-center items-center h-full">
        <Loader2 className="h-8 w-8 animate-spin" />
        <p className="ml-2">Carregando registros de frequência...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex justify-center items-center h-full text-red-500">
        <p>Erro ao carregar registros de frequência: {error.message}</p>
      </div>
    );
  }

  const handleCreateAttendance = async () => {
    if (projectId && newUserId && newDate) {
      await createAttendanceRecord({
        projectId,
        userId: parseInt(newUserId, 10),
        date: new Date(newDate),
        present: newPresent ? 1 : 0,
        justification: newJustification.trim() || null,
      });
      setNewDate("");
      setNewUserId("");
      setNewPresent(false);
      setNewJustification("");
    }
  };

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Registros de Frequência</CardTitle>
        </CardHeader>
        <CardContent>
          {attendanceRecords?.length === 0 ? (
            <p>Nenhum registro de frequência para este projeto.</p>
          ) : (
            <ul className="space-y-2">
              {attendanceRecords?.map((record) => (
                <li key={record.id} className="border-b pb-2">
                  <p className="text-sm"><strong>Usuário {record.userId}</strong> - Data: {record.date.toLocaleDateString()} - Presente: {record.present ? "Sim" : "Não"}</p>
                  {record.justification && <p className="text-xs text-muted-foreground">Justificativa: {record.justification}</p>}
                </li>
              ))}
            </ul>
          )}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Adicionar Novo Registro de Frequência</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid gap-4">
            <div className="grid gap-2">
              <Label htmlFor="attendance-date">Data</Label>
              <Input
                id="attendance-date"
                type="date"
                value={newDate}
                onChange={(e) => setNewDate(e.target.value)}
              />
            </div>
            <div className="grid gap-2">
              <Label htmlFor="attendance-user-id">ID do Usuário</Label>
              <Input
                id="attendance-user-id"
                type="number"
                value={newUserId}
                onChange={(e) => setNewUserId(e.target.value)}
              />
            </div>
            <div className="flex items-center space-x-2">
              <Checkbox
                id="attendance-present"
                checked={newPresent}
                onCheckedChange={(checked) => setNewPresent(checked as boolean)}
              />
              <Label htmlFor="attendance-present">Presente</Label>
            </div>
            <div className="grid gap-2">
              <Label htmlFor="attendance-justification">Justificativa (opcional)</Label>
              <Textarea
                id="attendance-justification"
                placeholder="Justificativa para ausência..."
                value={newJustification}
                onChange={(e) => setNewJustification(e.target.value)}
              />
            </div>
            <Button onClick={handleCreateAttendance} disabled={!newDate || !newUserId}>
              Adicionar Registro
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
