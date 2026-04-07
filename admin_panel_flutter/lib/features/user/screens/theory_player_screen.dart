import 'dart:async';
import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/theme/theme.dart';
import '../widgets/theory_quiz_view.dart';
import '../../../core/services/web_fullscreen.dart';

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

class _TheoryPlayerScreenState extends State<TheoryPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isThresholdReached = false;
  bool _showQuiz = false;
  bool _isVideoCompleted = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    final url = widget.chapter.videoUrl;
    if (url == null) return;

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

    try {
      await _videoPlayerController.initialize();
      _videoPlayerController.addListener(_videoListener);

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        placeholder: Container(color: Colors.black),
      );

      _chewieController!.addListener(() {
        if (_chewieController!.isFullScreen) {
          toggleWebFullscreen(true);
        } else {
          toggleWebFullscreen(false);
        }
      });

      setState(() {});
    } catch (e) {
      debugPrint('Error initializing video player: $e');
    }
  }

  void _videoListener() {
    if (!mounted) return;

    final position = _videoPlayerController.value.position;
    final duration = _videoPlayerController.value.duration;

    if (duration.inSeconds > 0) {
      final progress = position.inMilliseconds / duration.inMilliseconds;

      // Threshold reached logic (90%)
      if (progress >= 0.9 && !_isThresholdReached) {
        setState(() {
          _isThresholdReached = true;
        });
      }

      // Completion logic
      if (position >= duration && !_isVideoCompleted) {
        setState(() {
          _isVideoCompleted = true;
          // Prompt quiz if not already shown
        });
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_videoListener);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _onTakeQuiz() {
    setState(() {
      _showQuiz = true;
    });
    _videoPlayerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    if (_showQuiz) {
      return TheoryQuizView(
        chapter: widget.chapter,
        onClose: () => setState(() => _showQuiz = false),
      );
    }

    final safePad = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Player
          Center(
            child: _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : const CircularProgressIndicator(color: Colors.white),
          ),

          // Top Bar — respects safe area (notch / status bar)
          Positioned(
            top: safePad.top + 8,
            left: AppSpacing.sm,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Bottom Action Bar (Enabled after threshold)
          if (_isThresholdReached && !_showQuiz)
            Positioned(
              bottom: safePad.bottom + 24,
              left: AppSpacing.md,
              right: AppSpacing.md,
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _onTakeQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      textStyle: AppTextStyles.labelMd
                          .copyWith(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.quiz_rounded, size: 20),
                        SizedBox(width: 10),
                        Text('Take Quiz'),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Overlay message if not threshold yet
          if (!_isThresholdReached)
            Positioned(
              bottom: safePad.bottom + 12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Watch full video to unlock the quiz',
                    style: AppTextStyles.bodyXs.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
