import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'file_saver_stub.dart';

/// Implementação mobile/desktop: salva em diretório temporário e
/// dispara o share sheet (permite "Salvar no dispositivo" / preview).
class FileSaverImpl implements FileSaver {
  @override
  Future<bool> salvar(Uint8List bytes, String filename) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles([XFile(file.path)], text: 'Relatório E-Project');
      return true;
    } catch (_) {
      return false;
    }
  }
}

FileSaver createFileSaver() => FileSaverImpl();
