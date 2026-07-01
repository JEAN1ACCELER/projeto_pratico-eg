import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useComments } from "@/hooks/useComments";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { useState } from "react";
import { Separator } from "@/components/ui/separator";

export default function CommentsSection({ projectId }: { projectId: number }) {
  const { comments, isLoading, error, createComment } = useComments(projectId);
  const [newComment, setNewComment] = useState("");

  if (isLoading) {
    return (
      <div className="flex justify-center items-center h-full">
        <Loader2 className="h-8 w-8 animate-spin" />
        <p className="ml-2">Carregando comentários...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex justify-center items-center h-full text-red-500">
        <p>Erro ao carregar comentários: {error.message}</p>
      </div>
    );
  }

  const handleAddComment = async () => {
    if (newComment.trim()) {
      // TODO: Replace with actual userId from context
      await createComment({ projectId, userId: 1, content: newComment });
      setNewComment("");
    }
  };

  return (
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
  );
}
