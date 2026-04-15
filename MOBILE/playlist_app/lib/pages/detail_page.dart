import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../services/api_service.dart';
import '../services/auth_provider.dart';

// ── Config des modes ──────────────────────────────────────────────────────────
const _modes = {
  'deezer': {
    'color':      kAccentPurple,
    'icon':       '🎵',
    'title_key':  'card_deezer_title',
    'what_key':   'deezer_what',
    'needs_key':  'deezer_needs',
    'label_key':  'deezer_input_label',
    'ph_key':     'deezer_input_placeholder',
    'err_empty':  'err_no_deezer_id',
    'input_type': 'text',
  },
  'spotify': {
    'color':      kAccentSpotify,
    'icon':       '🟢',
    'title_key':  'card_spotify_title',
    'what_key':   'spotify_what',
    'needs_key':  'spotify_needs',
    'label_key':  'spotify_input_label',
    'ph_key':     'spotify_input_placeholder',
    'err_empty':  'err_no_spotify_url',
    'input_type': 'url',
  },
  'soundcloud': {
    'color':      kAccentSoundCloud,
    'icon':       '☁',
    'title_key':  'card_soundcloud_title',
    'what_key':   'soundcloud_what',
    'needs_key':  'soundcloud_needs',
    'label_key':  'soundcloud_input_label',
    'ph_key':     'soundcloud_input_placeholder',
    'err_empty':  'err_no_sc_url',
    'input_type': 'url',
  },
  'applemusic': {
    'color':      kAccentApple,
    'icon':       '🍎',
    'title_key':  'card_apple_title',
    'what_key':   'apple_what',
    'needs_key':  'apple_needs',
    'label_key':  'apple_input_label',
    'ph_key':     'apple_input_placeholder',
    'err_empty':  'err_no_apple_url',
    'input_type': 'url',
  },
  'youtube': {
    'color':      kAccentBlue,
    'icon':       '▶',
    'title_key':  'card_youtube_title',
    'what_key':   'youtube_what',
    'needs_key':  'youtube_needs',
    'label_key':  'youtube_input_label',
    'ph_key':     'youtube_input_placeholder',
    'err_empty':  'err_no_yt_url',
    'input_type': 'url',
  },
  'excel': {
    'color':      kAccentGreen,
    'icon':       '📊',
    'title_key':  'card_excel_title',
    'what_key':   'excel_what',
    'needs_key':  'excel_needs',
    'label_key':  'excel_input_file_label',
    'ph_key':     'excel_input_file_placeholder',
    'err_empty':  'err_no_excel_file',
    'input_type': 'file',
  },
};

class DetailPage extends StatefulWidget {
  final String mode;
  const DetailPage({super.key, required this.mode});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _controller     = TextEditingController();
  final _nameController = TextEditingController();
  final _api            = ApiService();

  String? _errorText;
  bool    _running  = false;
  int     _done     = 0;
  int     _total    = 0;
  String  _current  = '';
  String  _statusMsg = '';

  Map<String, dynamic> get cfg =>
      Map<String, dynamic>.from(_modes[widget.mode] ?? _modes['youtube']!);

  @override
  void dispose() {
    _api.close();
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _stop() {
    _api.close();
    setState(() {
      _running    = false;
      _statusMsg  = '⏹  Arrêté.';
      _current    = '';
    });
  }

  void _launch(AppLocalizations loc, String jwtToken) {
    final val = _controller.text.trim();
    if (val.isEmpty) {
      setState(() => _errorText = loc.t(cfg['err_empty'] as String));
      return;
    }
    if (widget.mode == 'excel' && _nameController.text.trim().isEmpty) {
      setState(() => _errorText = loc.t('err_no_playlist_name'));
      return;
    }

    setState(() {
      _errorText  = null;
      _running    = true;
      _done       = 0;
      _total      = 0;
      _current    = '';
      _statusMsg  = '';
    });

    final stream = _streamForMode(val, jwtToken);
    stream.listen(
      (event) {
        setState(() {
          if (event.type == 'progress') {
            _done    = event.done;
            _total   = event.total;
            _current = event.current;
          } else if (event.type == 'done') {
            _running   = false;
            _statusMsg = event.message.isNotEmpty ? event.message : loc.t('done');
          } else if (event.type == 'error') {
            _running   = false;
            _statusMsg = event.message;
            _errorText = event.message;
          }
        });
      },
      onError: (e) {
        setState(() {
          _running   = false;
          _errorText = e.toString();
        });
      },
    );
  }

  Stream<ProgressEvent> _streamForMode(String val, String jwtToken) {
    switch (widget.mode) {
      case 'deezer':
        return _api.importDeezer(val, jwtToken: jwtToken);
      case 'spotify':
        return _api.importSpotify(val, jwtToken: jwtToken);
      case 'soundcloud':
        return _api.importSoundCloud(val, jwtToken: jwtToken);
      case 'applemusic':
        return _api.importAppleMusic(val, jwtToken: jwtToken);
      case 'youtube':
        return _api.downloadYoutube(val);
      case 'excel':
        return const Stream.empty();
      default:
        return const Stream.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc   = context.watch<AppLocalizations>();
    final color = cfg['color'] as Color;
    final fg2   = Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        foregroundColor: Colors.white,
        title: Text(loc.t(cfg['title_key'] as String),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: loc.toggle,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: color,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.bold),
              ),
              child: Text(loc.t('lang_btn')),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Ce que ça fait ──────────────────────────────────────────────
            Text(loc.t('what_it_does'),
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 6),
            Text(loc.t(cfg['what_key'] as String),
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),

            // ── Ce dont vous avez besoin ────────────────────────────────────
            Text(loc.t('what_you_need'),
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 6),
            ...loc.tList(cfg['needs_key'] as String).map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  •  ', style: TextStyle(color: fg2)),
                  Expanded(child: Text(item,
                      style: TextStyle(fontSize: 13, color: fg2))),
                ],
              ),
            )),

            const Divider(height: 32),

            // ── Champ de saisie ─────────────────────────────────────────────
            Text(loc.t(cfg['label_key'] as String),
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              enabled: !_running,
              keyboardType: cfg['input_type'] == 'url'
                  ? TextInputType.url
                  : TextInputType.text,
              decoration: InputDecoration(
                hintText: loc.t(cfg['ph_key'] as String),
                errorText: _errorText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: color, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
              ),
            ),

            // ── Nom playlist (Excel) ────────────────────────────────────────
            if (widget.mode == 'excel') ...[
              const SizedBox(height: 16),
              Text(loc.t('excel_input_name_label'),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                enabled: !_running,
                decoration: InputDecoration(
                  hintText: loc.t('excel_input_name_placeholder'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: color, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                ),
              ),
            ],

            const SizedBox(height: 28),

            // ── Boutons Lancer / Arrêter ────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _running ? null : () {
                        final jwt = context.read<AuthProvider>().jwtToken ?? '';
                        _launch(loc, jwt);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      child: _running
                          ? const SizedBox(
                              width: 22, height: 22,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2.5))
                          : Text(loc.t('launch')),
                    ),
                  ),
                ),
                if (_running) ...[
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _stop,
                      icon: const Icon(Icons.stop),
                      label: Text(loc.t('stop')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFdc2626),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // ── Progression ─────────────────────────────────────────────────
            if (_running || _statusMsg.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_running) ...[
                      Text(
                        _total > 0
                            ? '$_done / $_total'
                            : loc.t('in_progress'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: color),
                      ),
                      if (_total > 0) ...[
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: _total > 0 ? _done / _total : null,
                          color: color,
                          backgroundColor: color.withValues(alpha: 0.2),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                      if (_current.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(_current,
                            style: TextStyle(fontSize: 13, color: fg2),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ],
                    if (_statusMsg.isNotEmpty)
                      Text(_statusMsg,
                          style: TextStyle(
                              fontSize: 14,
                              color: _errorText != null
                                  ? Colors.red
                                  : Colors.green)),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
