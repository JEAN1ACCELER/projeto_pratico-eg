// tests/ValidadorLogin.test.js
// US-01 — Login no sistema
// Testes automatizados (Jest) baseados na Tabela de Casos de Teste
// produzida a partir das Classes de Equivalência (TP3 - Parte II).

const { validarLogin } = require("../src/ValidadorLogin");

describe("US-01 — Login no sistema (Classes de Equivalência)", () => {
  // Caso 1 | Classes 1, 4, 7 | Usuário existente + senha correta + conta ativa
  test("Caso 1: login válido deve ser realizado com sucesso", () => {
    const resultado = validarLogin("victor.antunes", "Senha123");
    expect(resultado.sucesso).toBe(true);
    expect(resultado.mensagem).toBe("Login realizado com sucesso");
  });

  // Caso 2 | Classes 2, 4, 7 | Usuário inexistente + senha correta + conta ativa
  test("Caso 2: usuário inexistente deve falhar", () => {
    const resultado = validarLogin("joao404", "Senha123");
    expect(resultado.sucesso).toBe(false);
    expect(resultado.mensagem).toBe("Usuário não encontrado");
  });

  // Caso 3 | Classes 3, 4, 7 | Campo de usuário vazio + senha correta + conta ativa
  test("Caso 3: campo de usuário vazio deve falhar", () => {
    const resultado = validarLogin("", "Senha123");
    expect(resultado.sucesso).toBe(false);
    expect(resultado.mensagem).toBe("Campo de usuário obrigatório");
  });

  // Caso 4 | Classes 1, 5, 7 | Usuário existente + senha incorreta + conta ativa
  test("Caso 4: senha incorreta deve falhar", () => {
    const resultado = validarLogin("victor.antunes", "SenhaErrada");
    expect(resultado.sucesso).toBe(false);
    expect(resultado.mensagem).toBe("Senha incorreta");
  });

  // Caso 5 | Classes 1, 6, 7 | Usuário existente + campo de senha vazio + conta ativa
  test("Caso 5: campo de senha vazio deve falhar", () => {
    const resultado = validarLogin("victor.antunes", "");
    expect(resultado.sucesso).toBe(false);
    expect(resultado.mensagem).toBe("Campo de senha obrigatório");
  });

  // Caso 6 | Classes 1, 4, 8 | Usuário existente + senha correta + conta inativa
  test("Caso 6: usuário inativo deve falhar mesmo com senha correta", () => {
    const resultado = validarLogin("carlos.mendonca", "Acesso456");
    expect(resultado.sucesso).toBe(false);
    expect(resultado.mensagem).toBe("Usuário inativo");
  });
});
