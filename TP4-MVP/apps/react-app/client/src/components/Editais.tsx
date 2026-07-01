import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useEditais } from "@/hooks/useEditais";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useState } from "react";
import { useAuth } from "@/_core/hooks/useAuth";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { EditalStatusSchema } from "@/types";
import { z } from "zod";

export default function Editais() {
  const { editais, isLoading, error, createEdital } = useEditais();
  const { isAuthenticated } = useAuth();

  const [newTitle, setNewTitle] = useState("");
  const [newNumber, setNewNumber] = useState("");
  const [newDescription, setNewDescription] = useState("");
  const [newProReitoria, setNewProReitoria] = useState("");
  const [newPublishDate, setNewPublishDate] = useState("");
  const [newDeadline, setNewDeadline] = useState("");
  const [newUrl, setNewUrl] = useState("");
  const [newStatus, setNewStatus] = useState<z.infer<typeof EditalStatusSchema> | "">("");
  const [newRelatedPrograms, setNewRelatedPrograms] = useState("");

  if (isLoading) {
    return (
      <div className="flex justify-center items-center h-full">
        <Loader2 className="h-8 w-8 animate-spin" />
        <p className="ml-2">Carregando editais...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex justify-center items-center h-full text-red-500">
        <p>Erro ao carregar editais: {error.message}</p>
      </div>
    );
  }

  const handleCreateEdital = async () => {
    if (newTitle.trim() && newPublishDate.trim() && newDeadline.trim() && newStatus) {
      await createEdital({
        title: newTitle,
        number: newNumber.trim() || null,
        description: newDescription.trim() || null,
        proReitoria: newProReitoria.trim() || null,
        publishDate: new Date(newPublishDate),
        deadline: new Date(newDeadline),
        url: newUrl.trim() || null,
        status: newStatus as z.infer<typeof EditalStatusSchema>,
        relatedPrograms: newRelatedPrograms.trim() || null,
      });
      setNewTitle("");
      setNewNumber("");
      setNewDescription("");
      setNewProReitoria("");
      setNewPublishDate("");
      setNewDeadline("");
      setNewUrl("");
      setNewStatus("");
      setNewRelatedPrograms("");
    }
  };

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Editais e Oportunidades</CardTitle>
        </CardHeader>
        <CardContent>
          {editais?.length === 0 ? (
            <p>Nenhum edital encontrado.</p>
          ) : (
            <ul className="space-y-4">
              {editais?.map((edital) => (
                <li key={edital.id} className="border-b pb-4">
                  <h3 className="text-lg font-semibold">{edital.title}</h3>
                  {edital.number && <p className="text-sm text-muted-foreground">Número: {edital.number}</p>}
                  {edital.description && <p className="text-sm">{edital.description}</p>}
                  {edital.proReitoria && <p className="text-sm">Pró-Reitoria: {edital.proReitoria}</p>}
                  <p className="text-sm">Publicação: {edital.publishDate.toLocaleDateString()}</p>
                  <p className="text-sm">Prazo Final: {edital.deadline.toLocaleDateString()}</p>
                  {edital.url && <p className="text-sm"><a href={edital.url} target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">Acessar Edital</a></p>}
                  <p className="text-sm">Status: {edital.status}</p>
                  {edital.relatedPrograms && <p className="text-sm">Programas Relacionados: {edital.relatedPrograms}</p>}
                </li>
              ))}
            </ul>
          )}
        </CardContent>
      </Card>

      {isAuthenticated && (
        <Card>
          <CardHeader>
            <CardTitle>Criar Novo Edital</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid gap-4">
              <div className="grid gap-2">
                <Label htmlFor="edital-title">Título</Label>
                <Input id="edital-title" value={newTitle} onChange={(e) => setNewTitle(e.target.value)} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edital-number">Número (opcional)</Label>
                <Input id="edital-number" value={newNumber} onChange={(e) => setNewNumber(e.target.value)} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edital-description">Descrição (opcional)</Label>
                <Textarea id="edital-description" value={newDescription} onChange={(e) => setNewDescription(e.target.value)} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edital-proreitoria">Pró-Reitoria (opcional)</Label>
                <Input id="edital-proreitoria" value={newProReitoria} onChange={(e) => setNewProReitoria(e.target.value)} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edital-publish-date">Data de Publicação</Label>
                <Input id="edital-publish-date" type="date" value={newPublishDate} onChange={(e) => setNewPublishDate(e.target.value)} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edital-deadline">Prazo Final</Label>
                <Input id="edital-deadline" type="date" value={newDeadline} onChange={(e) => setNewDeadline(e.target.value)} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edital-url">URL (opcional)</Label>
                <Input id="edital-url" value={newUrl} onChange={(e) => setNewUrl(e.target.value)} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edital-status">Status</Label>
                <Select value={newStatus} onValueChange={(value: z.infer<typeof EditalStatusSchema>) => setNewStatus(value)}>
                  <SelectTrigger>
                    <SelectValue placeholder="Selecione o status" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Aberto">Aberto</SelectItem>
                    <SelectItem value="Encerrando em breve">Encerrando em breve</SelectItem>
                    <SelectItem value="Encerrado">Encerrado</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edital-related-programs">Programas Relacionados (opcional)</Label>
                <Input id="edital-related-programs" value={newRelatedPrograms} onChange={(e) => setNewRelatedPrograms(e.target.value)} />
              </div>
              <Button onClick={handleCreateEdital} disabled={!newTitle.trim() || !newPublishDate.trim() || !newDeadline.trim() || !newStatus}>
                Criar Edital
              </Button>
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
