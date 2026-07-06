/** Regras de validação do domínio (Camada de Domínio — regras de negócio puras). */

export function validarEmailUfam(email: string): boolean {
  return /@ufam\.edu\.br$/.test(email.trim());
}

export function validarSenha(senha: string): boolean {
  return senha.length >= 6;
}

export function validarPrazo(prazo: Date): boolean {
  return prazo > new Date();
}
