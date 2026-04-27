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
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isThresholdReached = false;
  bool _showQuiz = false;
  bool _isVideoCompleted = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    final url = widget.chapter.videoUrl;
    if (url == null) {
      if (mounted) setState(() => _error = 'No video URL available.');
      return;
    }

    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _videoPlayerController = controller;

    try {
      await controller.initialize();

      // Small delay to ensure the native layer has fully populated
      // the asset tracks before we query the size/aspectRatio.
      await Future.delayed(const Duration(milliseconds: 100));

      if (!mounted) {
        await controller.dispose();
        return;
      }

      controller.addListener(_videoListener);

      // Access aspectRatio safely from the controller value.
      // If it's invalid (0 or negative), default to 16/9.
      double aspectRatio = controller.value.aspectRatio;
      if (aspectRatio <= 0) {
        aspectRatio = 16 / 9;
      }

      _chewieController = ChewieController(
        videoPlayerController: controller,
        aspectRatio: aspectRatio,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        placeholder: Container(color: Colors.black),
        errorBuilder: (context, errorMessage) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              errorMessage,
              style: AppTextStyles.bodySm.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ),
        ),
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
      if (mounted) setState(() => _error = 'Failed to load video: $e');
    }
  }

  void _videoListener() {
    if (!mounted) return;
    final controller = _videoPlayerController;
    if (controller == null) return;

    final position = controller.value.position;
    final duration = controller.value.duration;

    if (duration.inSeconds > 0) {
      final progress = position.inMilliseconds / duration.inMilliseconds;

      // Threshold reached at 90%
      if (progress >= 0.9 && !_isThresholdReached) {
        setState(() => _isThresholdReached = true);
      }

      if (position >= duration && !_isVideoCompleted) {
        setState(() => _isVideoCompleted = true);
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.removeListener(_videoListener);
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void _onTakeQuiz() {
    setState(() {
      _showQuiz = true;
    });
    _videoPlayerController?.pause();
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
          // Video Player Section
          Expanded(
            child: Center(
              child: _error != null
                  ? _buildErrorWidget()
                  : _chewieController != null
                      ? Chewie(controller: _chewieController!)
                      : const CircularProgressIndicator(color: Colors.white),
            ),
          ),

          // Bottom Bar Section
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child:
                  _isThresholdReached ? _buildQuizButton() : _buildLockedBar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded,
              color: Colors.white54, size: 48),
          const SizedBox(height: AppSpacing.md),
          Text(_error!,
              style: AppTextStyles.bodySm.copyWith(color: Colors.white70),
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: () {
              setState(() => _error = null);
              _initializePlayer();
            },
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizButton() {
    return ElevatedButton(
      onPressed: _onTakeQuiz,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        textStyle: AppTextStyles.labelMd.copyWith(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.quiz_rounded, size: 20),
          SizedBox(width: 10),
          Text('Take Quiz'),
        ],
      ),
    );
  }

  Widget _buildLockedBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
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
            'Watch full video to unlock the quiz',
            style: AppTextStyles.bodyXs
                .copyWith(color: Colors.white.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}
