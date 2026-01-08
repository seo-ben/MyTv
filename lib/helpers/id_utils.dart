import 'package:flutter/foundation.dart';

String normalizeAndLogId(dynamic raw, {String source = ''}) {
  String normalized = '';
  if (raw == null) {
    normalized = '';
  } else if (raw is int) {
    normalized = raw.toString();
  } else if (raw is List) {
    // If API returns an array for sports_id, try to pick a meaningful element.
    if (raw.isEmpty) {
      normalized = '';
    } else {
      String candidate = '';
      for (var item in raw) {
        if (item == null) continue;
        if (item is int) {
          candidate = item.toString();
          break;
        }
        if (item is Map) {
          final v = item['sports_id'] ?? item['id'] ?? item['video_id'];
          if (v != null) {
            final p = int.tryParse(v.toString());
            candidate = p != null ? p.toString() : v.toString();
            break;
          }
        }
        final p = int.tryParse(item.toString());
        if (p != null) {
          candidate = p.toString();
          break;
        }
        // keep first non-empty string as fallback
        if (candidate.isEmpty && item.toString().isNotEmpty) {
          candidate = item.toString();
        }
      }

      normalized = candidate;
    }
  } else if (raw is Map) {
    // If a map is passed, try common id keys
    final candidate =
        raw['sports_id'] ??
        raw['id'] ??
        raw['video_id'] ??
        raw.values.firstWhere((_) => true, orElse: () => null);
    if (candidate == null) {
      normalized = '';
    } else {
      final p = int.tryParse(candidate.toString());
      normalized = p != null ? p.toString() : candidate.toString();
    }
  } else {
    final rawStr = raw.toString();
    final p = int.tryParse(rawStr);
    // If it's numeric, use the numeric string; otherwise preserve the raw string
    normalized = p != null ? p.toString() : rawStr;
  }
  debugPrint(
    '🧭 normalizeAndLogId ${source.isNotEmpty ? '($source)' : ''} -> raw: $raw normalized: $normalized',
  );
  return normalized;
}
