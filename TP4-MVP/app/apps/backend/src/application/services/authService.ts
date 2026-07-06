import bcrypt from "bcrypt";
import { prisma } from "../../infrastructure/prisma.js";
import { generateToken } from "../../infrastructure/auth/jwt.js";
import { validarEmailUfam, validarSenha } from "../../domain/validators.js";

export const authService = {
  async register(data: {
    nomeCompleto: string;
    emailInstitucional: string;
    senha: string;
    papel: string;
    matricula?: string;
    departamento?: string;
    aceiteTermos?: boolean;
    aceitePrivacidade?: boolean;
  }) {
    if (!validarEmailUfam(data.emailInstitucional)) {
      throw Object.assign(new Error("E-mail deve ser institucional (@ufam.edu.br)"), { status: 400 });
    }
    if (!validarSenha(data.senha)) {
      throw Object.assign(new Error("Senha deve ter pelo menos 6 caracteres"), { status: 400 });
    }

    const existing = await prisma.usuario.findUnique({ where: { emailInstitucional: data.emailInstitucional } });
    if (existing) throw Object.assign(new Error("E-mail já cadastrado"), { status: 409 });

    const hash = await bcrypt.hash(data.senha, 10);
    const usuario = await prisma.usuario.create({
      data: {
        nomeCompleto: data.nomeCompleto,
        emailInstitucional: data.emailInstitucional,
        hashSenha: hash,
        papel: data.papel as any,
        matricula: data.matricula,
        departamento: data.departamento,
        aceiteTermos: data.aceiteTermos ?? false,
        aceitePrivacidade: data.aceitePrivacidade ?? false,
      },
    });

    const token = generateToken(usuario.id, usuario.papel);
    return { usuario: sanitizeUser(usuario), token };
  },

  async login(email: string, senha: string) {
    const usuario = await prisma.usuario.findUnique({ where: { emailInstitucional: email } });
    if (!usuario) throw Object.assign(new Error("E-mail ou senha incorretos"), { status: 401 });
    if (!usuario.ativo) throw Object.assign(new Error("Conta desativada"), { status: 403 });

    const match = await bcrypt.compare(senha, usuario.hashSenha);
    if (!match) throw Object.assign(new Error("E-mail ou senha incorretos"), { status: 401 });

    const token = generateToken(usuario.id, usuario.papel);
    return { usuario: sanitizeUser(usuario), token };
  },

  async getMe(userId: string) {
    const usuario = await prisma.usuario.findUnique({ where: { id: userId } });
    if (!usuario) throw Object.assign(new Error("Usuário não encontrado"), { status: 404 });
    return sanitizeUser(usuario);
  },
};

function sanitizeUser(u: any) {
  const { hashSenha, ...safe } = u;
  return safe;
}
