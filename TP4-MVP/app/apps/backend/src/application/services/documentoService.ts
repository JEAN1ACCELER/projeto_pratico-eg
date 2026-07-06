import { gerarRelatorioProjeto, gerarRelatorioGeral } from "../../infrastructure/pdf/pdfService.js";

export const documentoService = {
  async gerarRelatorio(projetoId: string) {
    return gerarRelatorioProjeto(projetoId);
  },
  async gerarRelatorioGeral(usuarioId: string, papel: string) {
    return gerarRelatorioGeral(usuarioId, papel);
  },
};
