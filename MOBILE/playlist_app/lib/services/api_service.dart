import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

// ── Adresse du backend (Render.com) ───────────────────────────────────────────
const String kBackendWsHost = 'playlist-manager-backend.onrender.com';

String _wsUrl(String path) => 'wss://$kBackendWsHost$path';

// ── Modèle de progression ─────────────────────────────────────────────────────
class ProgressEvent {
  final String type;     // "progress" | "done" | "error"
  final int    done;
  final int    total;
  final String current;
  final String message;

  ProgressEvent({
    required this.type,
    this.done    = 0,
    this.total   = 0,
    this.current = '',
    this.message = '',
  });

  factory ProgressEvent.fromJson(Map<String, dynamic> j) => ProgressEvent(
    type:    j['type']    as String? ?? 'error',
    done:    j['done']    as int?    ?? 0,
    total:   j['total']   as int?    ?? 0,
    current: j['current'] as String? ?? '',
    message: j['message'] as String? ?? '',
  );
}

// ── Service WebSocket générique ───────────────────────────────────────────────
class ApiService {
  WebSocketChannel? _channel;

  Stream<ProgressEvent> connect(String path, Map<String, dynamic> payload) {
    _channel = WebSocketChannel.connect(Uri.parse(_wsUrl(path)));
    _channel!.sink.add(jsonEncode(payload));

    return _channel!.stream.map((raw) {
      final json = jsonDecode(raw as String) as Map<String, dynamic>;
      return ProgressEvent.fromJson(json);
    });
  }

  void close() => _channel?.sink.close();

  // ── Raccourcis par mode ───────────────────────────────────────────────────

  // Import streaming → YouTube (nécessite jwt_token)
  Stream<ProgressEvent> importDeezer(String playlistId, {required String jwtToken}) =>
      connect('/deezer/ws/import', {
        'playlist_id': playlistId,
        'jwt_token':   jwtToken,
      });

  Stream<ProgressEvent> importSpotify(String playlistUrl, {required String jwtToken}) =>
      connect('/spotify/ws/import', {
        'playlist_url': playlistUrl,
        'jwt_token':    jwtToken,
      });

  Stream<ProgressEvent> importSoundCloud(String playlistUrl, {required String jwtToken}) =>
      connect('/soundcloud/ws/import', {
        'playlist_url': playlistUrl,
        'jwt_token':    jwtToken,
      });

  Stream<ProgressEvent> importAppleMusic(String playlistUrl, {required String jwtToken}) =>
      connect('/applemusic/ws/import', {
        'playlist_url': playlistUrl,
        'jwt_token':    jwtToken,
      });

  // Téléchargements MP3 (pas de compte Google requis)
  Stream<ProgressEvent> downloadYoutube(String playlistUrl) =>
      connect('/youtube/ws/download', {'playlist_url': playlistUrl});

  Stream<ProgressEvent> downloadExcel({
    required String playlistName,
    required List<int> fileBytes,
    int sheet    = 0,
    String col   = 'E',
    int firstRow = 7,
  }) {
    _channel = WebSocketChannel.connect(
        Uri.parse(_wsUrl('/excel/ws/download')));
    _channel!.sink.add(jsonEncode({
      'playlist_name': playlistName,
      'sheet':         sheet,
      'col':           col,
      'first_row':     firstRow,
    }));
    _channel!.sink.add(fileBytes);

    return _channel!.stream.map((raw) {
      final json = jsonDecode(raw as String) as Map<String, dynamic>;
      return ProgressEvent.fromJson(json);
    });
  }
}
