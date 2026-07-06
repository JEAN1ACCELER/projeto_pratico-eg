import 'file_saver_stub.dart';
export 'file_saver_stub.dart';

import 'file_saver_io.dart'
    if (dart.library.html) 'file_saver_web.dart' as platform;

/// Instância única do FileSaver adequada à plataforma atual.
FileSaver fileSaver = platform.createFileSaver();
