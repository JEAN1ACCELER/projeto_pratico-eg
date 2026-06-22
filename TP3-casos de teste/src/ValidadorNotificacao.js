// src/ValidadorNotificacao.js
// US-12 — Receber notificação de nova tarefa
// Implementa as regras de negócio para notificações
// com base nas Classes de Equivalência definidas no TP3 - Parte II.

// Mock de banco de dados de usuários
const usuarios = [
  { id: 'ana.beatriz', ativo: true },
  { id: 'victor.antunes', ativo: true },
  { id: 'carlos.mendonca', ativo: false },
];

// Eventos considerados relevantes para gerar notificações
const EVENTOS_RELEVANTES = ['nova_tarefa', 'atualizacao_prazo'];

/**
 * Gera uma notificação para um destinatário específico.
 * @param {object} params - Parâmetros da notificação
 * @param {string} params.destinatarioId - ID do destinatário
 * @param {string} params.evento - Tipo de evento
 * @returns {{ enviada: boolean, mensagem: string, destinatarioId: string, evento: string }}
 */
function gerarNotificacao({ destinatarioId, evento }) {
  // Classe 2 - Notificação sem destinatário
  if (!destinatarioId || destinatarioId.trim() === '') {
    return { enviada: false, mensagem: 'Notificação sem relação com o usuário autenticado' };
  }

  // Verifica se o usuário existe e está ativo
  const usuario = usuarios.find(u => u.id === destinatarioId);
  
  // Classe 7 - Usuário inativo/desativado
  if (!usuario || !usuario.ativo) {
    return { enviada: false, mensagem: 'Usuário inativo/desativado' };
  }

  // Classe 5 - Evento irrelevante
  if (!EVENTOS_RELEVANTES.includes(evento)) {
    return { enviada: false, mensagem: 'Evento considerado irrelevante pelo sistema' };
  }

  // Classes 1, 4, 6 - Notificação válida
  return {
    enviada: true,
    mensagem: 'Notificação enviada e exibida corretamente no histórico',
    destinatarioId,
    evento,
  };
}

/**
 * Visualiza uma notificação para um usuário autenticado.
 * @param {object} notificacao - Objeto da notificação
 * @param {string} usuarioAutenticado - ID do usuário autenticado
 * @returns {{ sucesso: boolean, mensagem: string }}
 */
function visualizarNotificacao(notificacao, usuarioAutenticado) {
  // Classe 3 - Usuário tenta visualizar notificação de outro usuário
  if (notificacao.destinatarioId !== usuarioAutenticado) {
    return { sucesso: false, mensagem: 'Notificação não pertence ao usuário autenticado' };
  }

  // Notificação válida
  return { sucesso: true, mensagem: 'Notificação exibida com sucesso' };
}

module.exports = { gerarNotificacao, visualizarNotificacao, usuarios, EVENTOS_RELEVANTES };
