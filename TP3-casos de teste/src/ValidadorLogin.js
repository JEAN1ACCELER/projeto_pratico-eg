// src/ValidadorLogin.js
// US-01 — Login no sistema
// Implementa as regras de negócio do login com base nas Classes de
// Equivalência definidas no TP3 - Parte II (Engenharia de Software I).
//
// Classes de Equivalência cobertas:
// 1 - Usuário cadastrado e preenchido      | 2 - Usuário inexistente | 3 - Campo de usuário vazio
// 4 - Senha correta e preenchida           | 5 - Senha incorreta     | 6 - Campo de senha vazio
// 7 - Usuário ativo                        | 8 - Usuário inativo

// Mock de "banco de dados" de usuários cadastrados, apenas para fins de teste.
const usuariosCadastrados = [
  { usuario: 'victor.antunes', senha: 'Senha123', ativo: true },
  { usuario: 'ana.beatriz', senha: 'Aluna2026', ativo: true },
  { usuario: 'carlos.mendonca', senha: 'Acesso456', ativo: false }, // usuário inativo
];

/**
 * Busca um usuário cadastrado pelo identificador.
 * @param {string} usuario
 * @returns {object|null}
 */
function buscarUsuario(usuario) {
  return usuariosCadastrados.find((u) => u.usuario === usuario) || null;
}

/**
 * Valida uma tentativa de login conforme as regras de negócio da US-01.
 * @param {string} usuario
 * @param {string} senha
 * @returns {{ sucesso: boolean, mensagem: string }}
 */
function validarLogin(usuario, senha) {
  // Classe 3 - Campo de usuário vazio
  if (!usuario || usuario.trim() === '') {
    return { sucesso: false, mensagem: 'Campo de usuário obrigatório' };
  }

  // Classe 6 - Campo de senha vazio
  if (!senha || senha.trim() === '') {
    return { sucesso: false, mensagem: 'Campo de senha obrigatório' };
  }

  const usuarioEncontrado = buscarUsuario(usuario);

  // Classe 2 - Usuário inexistente
  if (!usuarioEncontrado) {
    return { sucesso: false, mensagem: 'Usuário não encontrado' };
  }

  // Classe 5 - Senha incorreta
  if (usuarioEncontrado.senha !== senha) {
    return { sucesso: false, mensagem: 'Senha incorreta' };
  }

  // Classe 8 - Usuário inativo
  if (!usuarioEncontrado.ativo) {
    return { sucesso: false, mensagem: 'Usuário inativo' };
  }

  // Classes 1, 4, 7 - Login válido
  return { sucesso: true, mensagem: 'Login realizado com sucesso' };
}

module.exports = { validarLogin, buscarUsuario, usuariosCadastrados };
