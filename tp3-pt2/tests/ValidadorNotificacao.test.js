// tests/ValidadorNotificacao.test.js
// US-12 — Receber notificação de nova tarefa
// Testes automatizados (Jest) baseados na Tabela de Casos de Teste
// produzida a partir das Classes de Equivalência (TP3 - Parte II).

const { gerarNotificacao, visualizarNotificacao } = require("../src/ValidadorNotificacao");

describe("US-12 — Receber notificação de nova tarefa (Classes de Equivalência)", () => {
  // Caso 1 | Classes 1, 4, 6 | Notificação relacionada ao usuário + evento relevante + conta ativa
  test("Caso 1: notificação válida deve ser enviada e exibida corretamente", () => {
    const notificacao = gerarNotificacao({ destinatarioId: "ana.beatriz", evento: "nova_tarefa" });
    expect(notificacao.enviada).toBe(true);
    expect(notificacao.mensagem).toBe("Notificação enviada e exibida corretamente no histórico");

    const visualizacao = visualizarNotificacao(notificacao, "ana.beatriz");
    expect(visualizacao.sucesso).toBe(true);
    expect(visualizacao.mensagem).toBe("Notificação exibida com sucesso");
  });

  // Caso 2 | Classes 2, 4, 6 | Notificação sem relação com o usuário autenticado
  test("Caso 2: notificação sem destinatário não deve ser enviada", () => {
    const notificacao = gerarNotificacao({ destinatarioId: "", evento: "nova_tarefa" });
    expect(notificacao.enviada).toBe(false);
    expect(notificacao.mensagem).toBe("Notificação sem relação com o usuário autenticado");
  });

  // Caso 3 | Classes 3, 4, 6 | Usuário autenticado tenta visualizar notificação de outro usuário
  test("Caso 3: usuário não pode visualizar notificação de outro usuário", () => {
    const notificacao = gerarNotificacao({ destinatarioId: "ana.beatriz", evento: "nova_tarefa" });
    const visualizacao = visualizarNotificacao(notificacao, "victor.antunes");
    expect(visualizacao.sucesso).toBe(false);
    expect(visualizacao.mensagem).toBe("Notificação não pertence ao usuário autenticado");
  });

  // Caso 4 | Classes 1, 5, 6 | Evento considerado irrelevante pelo sistema
  test("Caso 4: notificação não deve ser gerada para evento irrelevante", () => {
    const notificacao = gerarNotificacao({ destinatarioId: "ana.beatriz", evento: "evento_aleatorio" });
    expect(notificacao.enviada).toBe(false);
    expect(notificacao.mensagem).toBe("Evento considerado irrelevante pelo sistema");
  });

  // Caso 5 | Classes 1, 4, 7 | Destinatário com conta inativa/desativada
  test("Caso 5: notificação não deve ser enviada para usuário inativo", () => {
    const notificacao = gerarNotificacao({ destinatarioId: "carlos.mendonca", evento: "nova_tarefa" });
    expect(notificacao.enviada).toBe(false);
    expect(notificacao.mensagem).toBe("Usuário inativo/desativado");
  });
});
