import 'dart:typed_data';

/// Interface comum para salvar/compartilhar arquivos (PDFs).
abstract class FileSaver {
  Future<bool> salvar(Uint8List bytes, String filename);
}

/// Fallback — nunca deve ser chamado, pois o conditional import sobrescreve.
FileSaver createFileSaver() => throw UnsupportedError('Plataforma não suportada');
