import 'dart:typed_data';
import 'dart:html' as html;
import 'file_saver_stub.dart';

/// Implementação Web: dispara o download via Blob + anchor clicado.
class FileSaverImpl implements FileSaver {
  @override
  Future<bool> salvar(Uint8List bytes, String filename) async {
    try {
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', filename)
        ..style.display = 'none';
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      html.Url.revokeObjectUrl(url);
      return true;
    } catch (_) {
      return false;
    }
  }
}

FileSaver createFileSaver() => FileSaverImpl();
