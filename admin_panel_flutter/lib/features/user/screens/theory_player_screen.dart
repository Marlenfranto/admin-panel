import 'dart:async';
import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../../../core/theme/theme.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../widgets/theory_quiz_view.dart';
import '../../../core/services/web_fullscreen.dart';

const _kReadyTimeout = Duration(seconds: 30);

class TheoryPlayerScreen extends StatefulWidget {
  const TheoryPlayerScreen({
    super.key,
    required this.chapter,
    this.progress,
  });

  final TheoryChapter chapter;
  final UserTheoryProgress? progress;

  @override
  State<TheoryPlayerScreen> createState() => _TheoryPlayerScreenState();
}

/// Identifies an error condition for which [_TheoryPlayerScreenState]
/// shows a localized message. We can't store the message string directly
/// because it's set from async callbacks where we don't have a [BuildContext].
enum _PlayerError {
  noVideoUrl,
  loadTimeout,
  loadFailed,
}

class _TheoryPlayerScreenState extends State<TheoryPlayerScreen> {
  late final Player _player;
  late final VideoController _videoController;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration>? _durationSub;
  StreamSubscription<bool>? _completedSub;
  StreamSubscription<Duration>? _bufferSub;
  Timer? _readyTimeout;

  Duration _duration = Duration.zero;
  Duration _buffered = Duration.zero;
  bool _isThresholdReached = false;
  bool _showQuiz = false;
  bool _isVideoCompleted = false;
  bool _isReady = false;
  _PlayerError? _error;
  String? _errorDetail;

  @override
  void initState() {
    super.initState();
    _player = Player(
      configuration: const PlayerConfiguration(
        bufferSize: 64 * 1024 * 1024,
        title: 'Theory Player',
      ),
    );
    _videoController = VideoController(_player);
    _initializePlayer();
  }

  Future<void> _applyNetworkTuning() async {
    if (kIsWeb) return;
    try {
      final dynamic native = _player.platform;
      if (native == null) return;
      await native.setProperty('cache', 'yes');
      await native.setProperty('cache-secs', '120');
      await native.setProperty('demuxer-max-bytes', '64MiB');
      await native.setProperty('demuxer-max-back-bytes', '32MiB');
      await native.setProperty('demuxer-readahead-secs', '20');
      await native.setProperty('network-timeout', '15');
      await native.setProperty('stream-buffer-size', '4MiB');
    } catch (_) {}
  }

  Future<void> _initializePlayer() async {
    final url = widget.chapter.videoUrl;
    if (url == null) {
      if (mounted) setState(() => _error = _PlayerError.noVideoUrl);
      return;
    }

    await _applyNetworkTuning();

    _durationSub = _player.stream.duration.listen((d) {
      if (!mounted) return;
      _duration = d;
      if (d > Duration.zero && !_isReady) {
        setState(() => _isReady = true);
      }
    });

    _positionSub = _player.stream.position.listen((position) {
      if (!mounted || _duration.inMilliseconds <= 0) return;
      final progress = position.inMilliseconds / _duration.inMilliseconds;
      if (progress >= 0.9 && !_isThresholdReached) {
        setState(() => _isThresholdReached = true);
      }
    });

    _completedSub = _player.stream.completed.listen((completed) {
      if (!mounted) return;
      if (completed && !_isVideoCompleted) {
        setState(() {
          _isVideoCompleted = true;
          _isThresholdReached = true;
        });
      }
    });

    _bufferSub = _player.stream.buffer.listen((b) {
      if (!mounted) return;
      setState(() => _buffered = b);
    });

    _readyTimeout = Timer(_kReadyTimeout, () {
      if (!mounted || _isReady) return;
      setState(() {
        _error = _PlayerError.loadTimeout;
        _errorDetail = null;
      });
    });

    try {
      await _player.open(Media(url), play: false);
    } catch (e) {
      debugPrint('Error initializing video player: $e');
      if (mounted) {
        setState(() {
          _error = _PlayerError.loadFailed;
          _errorDetail = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _readyTimeout?.cancel();
    _positionSub?.cancel();
    _durationSub?.cancel();
    _completedSub?.cancel();
    _bufferSub?.cancel();
    _player.dispose();
    toggleWebFullscreen(false);
    super.dispose();
  }

  void _onTakeQuiz() {
    setState(() {
      _showQuiz = true;
    });
    _player.pause();
  }

  @override
  Widget build(BuildContext context) {
    if (_showQuiz) {
      return TheoryQuizView(
        chapter: widget.chapter,
        onClose: () => setState(() => _showQuiz = false),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          // arrow_back_ios is direction-sensitive; explicitly tie it to the
          // ambient Directionality so RTL flips it horizontally.
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            textDirection: Directionality.of(context),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.chapter.title,
          style: AppTextStyles.labelLg.copyWith(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _error != null
                  ? _buildErrorWidget()
                  : !_isReady
                      ? _buildBufferingOverlay()
                      : Video(
                          controller: _videoController,
                          controls: AdaptiveVideoControls,
                          fill: Colors.black,
                          onEnterFullscreen: () async {
                            toggleWebFullscreen(true);
                          },
                          onExitFullscreen: () async {
                            toggleWebFullscreen(false);
                          },
                        ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child:
                  _isThresholdReached ? _buildQuizButton(context) : _buildLockedBar(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBufferingOverlay() {
    final t = AppLocalizations.of(context);
    final label = !_isReady ? t.theoryPlayerLoadingVideo : t.theoryPlayerBuffering;
    final bufferedSecs = _buffered.inSeconds;
    return Container(
      color: Colors.black.withValues(alpha: 0.45),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            label,
            style: AppTextStyles.bodySm.copyWith(color: Colors.white),
          ),
          if (_isReady && bufferedSecs > 0) ...[
            const SizedBox(height: 4),
            Text(
              t.theoryPlayerBufferedSecs(bufferedSecs),
              style: AppTextStyles.bodyXs
                  .copyWith(color: Colors.white.withValues(alpha: 0.6)),
            ),
          ],
        ],
      ),
    );
  }

  String _localizedError(AppLocalizations t) => switch (_error) {
        _PlayerError.noVideoUrl  => t.theoryPlayerNoVideoUrl,
        _PlayerError.loadTimeout => t.theoryPlayerLoadTimeout,
        _PlayerError.loadFailed  => t.theoryPlayerLoadFailed(_errorDetail ?? ''),
        null                     => '',
      };

  Widget _buildErrorWidget() {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded,
              color: Colors.white54, size: 48),
          const SizedBox(height: AppSpacing.md),
          Text(_localizedError(t),
              style: AppTextStyles.bodySm.copyWith(color: Colors.white70),
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: () {
              _readyTimeout?.cancel();
              setState(() {
                _error = null;
                _errorDetail = null;
                _isReady = false;
                _buffered = Duration.zero;
              });
              _initializePlayer();
            },
            child: Text(t.theoryPlayerRetry,
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizButton(BuildContext context) {
    final t = AppLocalizations.of(context);
    return ElevatedButton(
      onPressed: _onTakeQuiz,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        textStyle: AppTextStyles.labelMd.copyWith(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.quiz_rounded, size: 20),
          const SizedBox(width: 10),
          Text(t.theoryPlayerTakeQuiz),
        ],
      ),
    );
  }

  Widget _buildLockedBar(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline_rounded,
              size: 14, color: Colors.white.withValues(alpha: 0.6)),
          const SizedBox(width: 8),
          Text(
            t.theoryPlayerLockedHint,
            style: AppTextStyles.bodyXs
                .copyWith(color: Colors.white.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}
