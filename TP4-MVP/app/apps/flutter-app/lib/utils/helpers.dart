import 'package:intl/intl.dart';
import '../config/constants.dart';

class Helpers {
  static String formatDate(DateTime? d) {
    if (d == null) return '—';
    return DateFormat('dd/MM/yyyy').format(d);
  }

  static String formatDateTime(DateTime? d) {
    if (d == null) return '—';
    return DateFormat('dd/MM/yyyy HH:mm').format(d);
  }

  static String timeAgo(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'Agora';
    if (diff.inMinutes < 60) return '${diff.inMinutes}min atrás';
    if (diff.inHours < 24) return '${diff.inHours}h atrás';
    if (diff.inDays < 7) return '${diff.inDays}d atrás';
    return formatDate(d);
  }

  static String modalidadeLabel(String key) => AppConstants.modalidadeLabel[key] ?? key;
  static String statusProjetoLabel(String key) => AppConstants.statusProjetoLabel[key] ?? key;
  static String statusTarefaLabel(String key) => AppConstants.statusTarefaLabel[key] ?? key;
  static String statusAvaliacaoLabel(String key) => AppConstants.statusAvaliacaoLabel[key] ?? key;
}
