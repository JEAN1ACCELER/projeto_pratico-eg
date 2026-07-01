import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { ProjectTypeSchema, ProjectStatusSchema, CreateProjectInput, UpdateProjectInput } from "@/types";
import { useProjects } from "@/hooks/useProjects";
import { useEffect } from "react";

const formSchema = z.object({
  title: z.string().min(1, { message: "Título é obrigatório." }),
  type: ProjectTypeSchema,
  status: ProjectStatusSchema,
  startDate: z.string().min(1, { message: "Data de início é obrigatória." }),
  endDate: z.string().min(1, { message: "Data de término é obrigatória." }),
  orientadorId: z.number().int().nullable().optional(),
  description: z.string().optional(),
  progress: z.number().min(0).max(100).optional(),
});

type ProjectFormValues = z.infer<typeof formSchema>;

import { Project } from "@/types";


interface ProjectFormProps {
  initialData?: Project;
  projectId?: number;
  onSuccess?: () => void;
}

function mapProjectToFormValues(project: Project): ProjectFormValues {
  return {
    title: project.title,
    type: project.type,
    status: project.status,
    startDate: project.startDate ? project.startDate.toISOString().split("T")[0] : "",
    endDate: project.endDate ? project.endDate.toISOString().split("T")[0] : "",
    orientadorId: project.orientadorId ?? undefined,
    description: project.description ?? undefined,
    progress: project.progress ?? undefined,
  };
}

export default function ProjectForm({ initialData, projectId, onSuccess }: ProjectFormProps) {
  const { createProject, updateProject } = useProjects();

  const resolver = zodResolver(formSchema);
  const form = useForm<ProjectFormValues>({
    resolver,
    defaultValues: initialData ? mapProjectToFormValues(initialData) : {
      title: "",
      type: "PIBIC",
      status: "Em andamento",
      startDate: "",
      endDate: "",
      orientadorId: undefined,
      description: undefined,
      progress: undefined,
    },
  });

  useEffect(() => {
    if (initialData) {
      form.reset(mapProjectToFormValues(initialData));
    }
  }, [initialData, form.reset]);

  async function onSubmit(values: ProjectFormValues) {
    try {
      if (projectId) {
        const updateData: UpdateProjectInput['data'] = {
          title: values.title,
          type: values.type,
          status: values.status,
          startDate: new Date(values.startDate),
          endDate: new Date(values.endDate),
          orientadorId: values.orientadorId === 0 ? null : values.orientadorId,
          description: values.description ?? undefined,
          progress: values.progress === 0 ? undefined : values.progress,
        };
        await updateProject(projectId, updateData);
      } else {
        const createData: CreateProjectInput = {
          title: values.title,
          type: values.type,
          status: values.status,
          startDate: new Date(values.startDate),
          endDate: new Date(values.endDate),
          orientadorId: values.orientadorId === 0 ? null : values.orientadorId,
          description: values.description ?? undefined,
          progress: values.progress === 0 ? undefined : values.progress,
        };
        await createProject(createData);
      }
      onSuccess?.();
    } catch (error) {
      console.error("Erro ao salvar projeto:", error);
      // TODO: Adicionar feedback de erro para o usuário
    }
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <FormField
          control={form.control}
          name="title"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Título</FormLabel>
              <FormControl>
                <Input placeholder="Título do Projeto" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="type"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Tipo</FormLabel>
              <Select onValueChange={field.onChange} defaultValue={field.value}>
                <FormControl>
                  <SelectTrigger>
                    <SelectValue placeholder="Selecione o tipo de projeto" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="PIBIC">PIBIC</SelectItem>
                  <SelectItem value="PACE">PACE</SelectItem>
                  <SelectItem value="Pibex">Pibex</SelectItem>
                  <SelectItem value="PIBID">PIBID</SelectItem>
                  <SelectItem value="Mestrado">Mestrado</SelectItem>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="status"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Status</FormLabel>
              <Select onValueChange={field.onChange} defaultValue={field.value}>
                <FormControl>
                  <SelectTrigger>
                    <SelectValue placeholder="Selecione o status do projeto" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="Em andamento">Em andamento</SelectItem>
                  <SelectItem value="Concluído">Concluído</SelectItem>
                  <SelectItem value="Atrasado">Atrasado</SelectItem>
                  <SelectItem value="Planejamento">Planejamento</SelectItem>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="startDate"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Data de Início</FormLabel>
              <FormControl>
                <Input type="date" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="endDate"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Data de Término</FormLabel>
              <FormControl>
                <Input type="date" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="orientadorId"
          render={({ field }) => (
            <FormItem>
              <FormLabel>ID do Orientador</FormLabel>
              <FormControl>
                <Input type="number" placeholder="ID do Orientador" {...field} value={field.value ?? ''} onChange={e => field.onChange(e.target.value === '' ? undefined : Number(e.target.value))} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="description"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Descrição</FormLabel>
              <FormControl>
                <Textarea placeholder="Descrição do Projeto" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name="progress"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Progresso (%)</FormLabel>
              <FormControl>
                <Input type="number" placeholder="Progresso" {...field} value={field.value ?? ''} onChange={e => field.onChange(e.target.value === '' ? undefined : Number(e.target.value))} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type="submit">{projectId ? "Atualizar Projeto" : "Criar Projeto"}</Button>
      </form>
    </Form>
  );
}
