// src/FiltroTarefasPendentes.js
// US-10 — Visualizar tarefas pendentes
// Implementa as regras de negócio para filtrar tarefas pendentes
// com base nas Classes de Equivalência definidas no TP3 - Parte II.

/**
 * Determina se uma tarefa deve ser exibida para o aluno autenticado.
 * @param {object} tarefa - Objeto da tarefa
 * @param {object} contexto - Contexto do aluno autenticado
 * @returns {{ exibir: boolean, motivo: string, vencida: boolean }}
 */
function podeExibirTarefa(tarefa, contexto) {
  // Classe: Usuário não autenticado
  if (!contexto.autenticado) {
    return { exibir: false, motivo: 'Acesso negado — autenticação obrigatória', vencida: false };
  }

  // Classe: Tarefa de outro aluno
  if (tarefa.alunoId !== contexto.alunoAutenticadoId) {
    return { exibir: false, motivo: 'Tarefa pertence a outro aluno', vencida: false };
  }

  // Classe: Tarefa de outro projeto
  if (tarefa.projetoId !== contexto.projetoDoAlunoId) {
    return { exibir: false, motivo: 'Tarefa não pertence ao projeto do aluno', vencida: false };
  }

  // Classe: Tarefa concluída
  if (tarefa.status === 'Concluído') {
    return { exibir: false, motivo: 'Tarefa concluída não deve ser exibida na lista de pendentes', vencida: false };
  }

  // Verifica se a tarefa está vencida (apenas para pendentes)
  const estaVencida = tarefa.prazo < contexto.dataAtual;

  // Classe: Tarefa pendente e válida
  if (tarefa.status === 'Pendente') {
    if (estaVencida) {
      return { exibir: true, motivo: 'Tarefa exibida com destaque visual de "vencida"', vencida: true };
    }
    return { exibir: true, motivo: 'Tarefa exibida na lista, ordenada por prazo', vencida: false };
  }

  // Fallback (não deve ocorrer para status válidos)
  return { exibir: false, motivo: 'Status não reconhecido', vencida: false };
}

/**
 * Lista todas as tarefas pendentes de um aluno, ordenadas por prazo.
 * @param {Array} tarefas - Lista de todas as tarefas
 * @param {object} contexto - Contexto do aluno autenticado
 * @returns {Array} Lista ordenada de tarefas pendentes
 */
function listarTarefasPendentes(tarefas, contexto) {
  const pendentes = tarefas
    .filter((tarefa) => {
      const resultado = podeExibirTarefa(tarefa, contexto);
      return resultado.exibir;
    })
    .map((tarefa) => ({
      tarefa,
      vencida: tarefa.prazo < contexto.dataAtual,
    }));

  // Ordena por prazo (mais próximo primeiro)
  pendentes.sort((a, b) => a.tarefa.prazo - b.tarefa.prazo);
  return pendentes;
}

module.exports = { podeExibirTarefa, listarTarefasPendentes };
