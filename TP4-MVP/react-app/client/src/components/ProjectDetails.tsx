import { useParams } from "wouter";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Loader2 } from "lucide-react";
import { useProjects } from "@/hooks/useProjects";
import { useTasks } from "@/hooks/useTasks";
import { useProjectMembers } from "@/hooks/useProjectMembers";
import { useComments } from "@/hooks/useComments";
import { useProjectFiles } from "@/hooks/useProjectFiles";
import { Separator } from "@/components/ui/separator";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { useState } from "react";

export default function ProjectDetails() {
  const params = useParams();
  const projectId = params.id ? parseInt(params.id, 10) : undefined;

  const { projects, isLoading: isLoadingProjects, error: errorProjects } = useProjects();
  const project = projects?.find(p => p.id === projectId);

  const { tasks, isLoading: isLoadingTasks, error: errorTasks, createTask, updateTask } = useTasks(projectId || 0);
  const { members, isLoading: isLoadingMembers, error: errorMembers, addMember } = useProjectMembers(projectId || 0);
  const { comments, isLoading: isLoadingComments, error: errorComments, createComment } = useComments(projectId || 0);
  const { files, isLoading: isLoadingFiles, error: errorFiles, uploadFile } = useProjectFiles(projectId || 0);

  const [newComment, setNewComment] = useState("");
  const [newFileName, setNewFileName] = useState("");
  const [newFileUrl, setNewFileUrl] = useState("");

  if (!projectId) {
    return <div className="text-red-500">ID do projeto não fornecido.</div>;
  }

  if (isLoadingProjects || isLoadingTasks || isLoadingMembers || isLoadingComments || isLoadingFiles) {
    return (
      <div className="flex justify-center items-center h-full">
        <Loader2 className="h-8 w-8 animate-spin" />
        <p className="ml-2">Carregando detalhes do projeto...</p>
      </div>
    );
  }

  if (errorProjects || errorTasks || errorMembers || errorComments || errorFiles) {
    return (
      <div className="flex justify-center items-center h-full text-red-500">
        <p>Erro ao carregar o projeto: {errorProjects?.message || errorTasks?.message || errorMembers?.message || errorComments?.message || errorFiles?.message}</p>
      </div>
    );
  }

  if (!project) {
    return <div className="text-red-500">Projeto não encontrado.</div>;
  }

  const handleAddComment = async () => {
    if (newComment.trim() && projectId) {
      // TODO: Replace with actual userId from context
      await createComment({ projectId, userId: 1, content: newComment });
      setNewComment("");
    }
  };

  const handleUploadFile = async () => {
    if (newFileName.trim() && newFileUrl.trim() && projectId) {
      // TODO: Replace with actual userId from context
      await uploadFile({ projectId, fileName: newFileName, fileUrl: newFileUrl, fileSize: 0, uploadedBy: 1 }); // fileSize mockado para 0 por enquanto
      setNewFileName("");
      setNewFileUrl("");
    }
  };

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle className="text-2xl font-bold">{project.title}</CardTitle>
          <p className="text-sm text-muted-foreground">{project.description}</p>
        </CardHeader>
        <CardContent className="grid grid-cols-2 gap-4">
          <div>
            <p><strong>Tipo:</strong> {project.type}</p>
            <p><strong>Status:</strong> {project.status}</p>
            <p><strong>Início:</strong> {project.startDate.toLocaleDateString()}</p>
            <p><strong>Fim:</strong> {project.endDate.toLocaleDateString()}</p>
          </div>
          <div>
            <p><strong>Orientador ID:</strong> {project.orientadorId}</p>
            <p><strong>Progresso:</strong> {project.progress}%</p>
            <p><strong>Criado em:</strong> {project.createdAt.toLocaleDateString()}</p>
            <p><strong>Última Atualização:</strong> {project.updatedAt.toLocaleDateString()}</p>
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Tarefas</CardTitle>
        </CardHeader>
        <CardContent>
          {tasks?.length === 0 ? (
            <p>Nenhuma tarefa para este projeto.</p>
          ) : (
            <ul className="space-y-2">
              {tasks?.map((task) => (
                <li key={task.id} className="flex justify-between items-center">
                  <span>{task.title} - {task.status} (Prioridade: {task.priority})</span>
                  <Button variant="ghost" size="sm" onClick={() => updateTask(task.id, { status: task.status === "Concluída" ? "Pendente" : "Concluída" })}>Alternar Status</Button>
                </li>
              ))}
            </ul>
          )}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Membros do Projeto</CardTitle>
        </CardHeader>
        <CardContent>
          {members?.length === 0 ? (
            <p>Nenhum membro neste projeto.</p>
          ) : (
            <ul className="space-y-2">
              {members?.map((member) => (
                <li key={member.id}>{member.userId} - {member.role}</li>
              ))}
            </ul>
          )}
          {/* TODO: Adicionar formulário para adicionar membros */}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Comentários</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {comments?.length === 0 ? (
              <p>Nenhum comentário para este projeto.</p>
            ) : (
              <ul className="space-y-2">
                {comments?.map((comment) => (
                  <li key={comment.id} className="border-b pb-2">
                    <p className="text-sm"><strong>Usuário {comment.userId}:</strong> {comment.content}</p>
                    <p className="text-xs text-muted-foreground">{comment.createdAt.toLocaleDateString()} {comment.createdAt.toLocaleTimeString()}</p>
                  </li>
                ))}
              </ul>
            )}
            <Separator />
            <div className="flex flex-col gap-2">
              <Textarea
                placeholder="Adicionar um comentário..."
                value={newComment}
                onChange={(e) => setNewComment(e.target.value)}
              />
              <Button onClick={handleAddComment} disabled={!newComment.trim()}>
                Adicionar Comentário
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Arquivos</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {files?.length === 0 ? (
              <p>Nenhum arquivo para este projeto.</p>
            ) : (
              <ul className="space-y-2">
                {files?.map((file) => (
                  <li key={file.id} className="flex justify-between items-center">
                    <a href={file.fileUrl} target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">
                      {file.fileName} ({Math.round(file.fileSize / 1024)} KB)
                    </a>
                    <span className="text-xs text-muted-foreground">Upload por {file.uploadedBy} em {file.createdAt.toLocaleDateString()}</span>
                  </li>
                ))}
              </ul>
            )}
            <Separator />
            <div className="flex flex-col gap-2">
              <Input
                placeholder="Nome do arquivo"
                value={newFileName}
                onChange={(e) => setNewFileName(e.target.value)}
              />
              <Input
                placeholder="URL do arquivo (ex: https://example.com/file.pdf)"
                value={newFileUrl}
                onChange={(e) => setNewFileUrl(e.target.value)}
              />
              <Button onClick={handleUploadFile} disabled={!newFileName.trim() || !newFileUrl.trim()}>
                Upload de Arquivo
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
