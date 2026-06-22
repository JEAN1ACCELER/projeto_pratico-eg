// tests/FiltroTarefasPendentes.test.js
// US-10 — Visualizar tarefas pendentes
// Testes automatizados (Jest) baseados na Tabela de Casos de Teste
// produzida a partir das Classes de Equivalência (TP3 - Parte II).

const { podeExibirTarefa, listarTarefasPendentes } = require("../src/FiltroTarefasPendentes");

// Data de referência fixa para tornar os testes de prazo determinísticos.
const DATA_ATUAL = new Date("2026-06-22T00:00:00");

const contextoBase = {
  alunoAutenticadoId: "ana.beatriz",
  projetoDoAlunoId: "projeto-pibic-01",
  autenticado: true,
  dataAtual: DATA_ATUAL,
};

describe("US-10 — Visualizar tarefas pendentes (Classes de Equivalência)", () => {
  // Caso 1 | Classes 1, 4, 6, 8 | Tarefa do próprio aluno, pendente, prazo futuro, autenticado
  test("Caso 1: tarefa válida do próprio aluno deve ser exibida", () => {
    const tarefa = {
      id: "t1",
      alunoId: "ana.beatriz",
      projetoId: "projeto-pibic-01",
      status: "Pendente",
      prazo: new Date("2026-07-01"),
    };
    const resultado = podeExibirTarefa(tarefa, contextoBase);
    expect(resultado.exibir).toBe(true);
    expect(resultado.motivo).toBe("Tarefa exibida na lista, ordenada por prazo");
    expect(resultado.vencida).toBe(false);
  });

  // Caso 2 | Classes 2, 4, 6, 8 | Tarefa pertencente a outro aluno
  test("Caso 2: tarefa de outro aluno não deve ser exibida", () => {
    const tarefa = {
      id: "t2",
      alunoId: "pedro.jhevison",
      projetoId: "projeto-pibic-01",
      status: "Pendente",
      prazo: new Date("2026-07-01"),
    };
    const resultado = podeExibirTarefa(tarefa, contextoBase);
    expect(resultado.exibir).toBe(false);
    expect(resultado.motivo).toBe("Tarefa pertence a outro aluno");
  });

  // Caso 3 | Classes 3, 4, 6, 8 | Tarefa que não pertence ao projeto do aluno
  test("Caso 3: tarefa fora do projeto do aluno não deve ser exibida", () => {
    const tarefa = {
      id: "t3",
      alunoId: "ana.beatriz",
      projetoId: "projeto-pibex-02",
      status: "Pendente",
      prazo: new Date("2026-07-01"),
    };
    const resultado = podeExibirTarefa(tarefa, contextoBase);
    expect(resultado.exibir).toBe(false);
    expect(resultado.motivo).toBe("Tarefa não pertence ao projeto do aluno");
  });

  // Caso 4 | Classes 1, 5, 6, 8 | Tarefa do aluno com status "Concluído"
  test("Caso 4: tarefa concluída não deve aparecer na lista de pendentes", () => {
    const tarefa = {
      id: "t4",
      alunoId: "ana.beatriz",
      projetoId: "projeto-pibic-01",
      status: "Concluído",
      prazo: new Date("2026-07-01"),
    };
    const resultado = podeExibirTarefa(tarefa, contextoBase);
    expect(resultado.exibir).toBe(false);
    expect(resultado.motivo).toBe("Tarefa concluída não deve ser exibida na lista de pendentes");
  });

  // Caso 5 | Classes 1, 4, 7, 8 | Usuário não autenticado tenta acessar a lista de tarefas
  test("Caso 5: usuário não autenticado não deve acessar a lista de tarefas", () => {
    const tarefa = {
      id: "t5",
      alunoId: "ana.beatriz",
      projetoId: "projeto-pibic-01",
      status: "Pendente",
      prazo: new Date("2026-07-01"),
    };
    const resultado = podeExibirTarefa(tarefa, { ...contextoBase, autenticado: false });
    expect(resultado.exibir).toBe(false);
    expect(resultado.motivo).toBe("Acesso negado — autenticação obrigatória");
  });

  // Caso 6 | Classes 1, 4, 6, 9 | Tarefa do aluno com prazo expirado
  test("Caso 6: tarefa vencida deve ser exibida com destaque visual", () => {
    const tarefa = {
      id: "t6",
      alunoId: "ana.beatriz",
      projetoId: "projeto-pibic-01",
      status: "Pendente",
      prazo: new Date("2026-06-10"),
    };
    const resultado = podeExibirTarefa(tarefa, contextoBase);
    expect(resultado.exibir).toBe(true);
    expect(resultado.motivo).toBe("Tarefa exibida com destaque visual de \"vencida\"");
    expect(resultado.vencida).toBe(true);
  });

  // Teste complementar: verifica a ordenação por prazo (mais próximo primeiro)
  test("Teste complementar: lista deve ser ordenada por prazo de entrega", () => {
    const tarefas = [
      { id: "t7", alunoId: "ana.beatriz", projetoId: "projeto-pibic-01", status: "Pendente", prazo: new Date("2026-08-01") },
      { id: "t8", alunoId: "ana.beatriz", projetoId: "projeto-pibic-01", status: "Pendente", prazo: new Date("2026-06-25") },
      { id: "t9", alunoId: "ana.beatriz", projetoId: "projeto-pibic-01", status: "Pendente", prazo: new Date("2026-07-10") },
    ];
    const lista = listarTarefasPendentes(tarefas, contextoBase);
    expect(lista.map((item) => item.tarefa.id)).toEqual(["t8", "t9", "t7"]);
  });
});
