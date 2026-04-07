import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme.dart';
import '../../../shared/widgets/responsive_helper.dart';
import '../providers/theory_providers.dart';

class TheoryQuizView extends ConsumerStatefulWidget {
  const TheoryQuizView({
    super.key,
    required this.chapter,
    required this.onClose,
  });

  final TheoryChapter chapter;
  final VoidCallback onClose;

  @override
  ConsumerState<TheoryQuizView> createState() => _TheoryQuizViewState();
}

class _TheoryQuizViewState extends ConsumerState<TheoryQuizView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final questions = widget.chapter.questions ?? [];
      ref.read(quizStateProvider.notifier).init(questions.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(quizStateProvider);
    final questions = widget.chapter.questions ?? [];

    if (questions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.onSurfaceMuted),
              const SizedBox(height: 16),
              const Text('No questions available for this chapter.'),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: widget.onClose, child: const Text('Go Back')),
            ],
          ),
        ),
      );
    }

    if (state.result != null) {
      return _QuizResultView(
        result: state.result!,
        onClose: () {
          Navigator.of(context).pop(); // Go back to listing
        },
        onRetry: () {
          ref.read(quizStateProvider.notifier).init(questions.length);
          widget.onClose(); // Switch back to player
        },
      );
    }

    final currentIndex = state.currentQuestionIndex;
    final currentQuestion = questions[currentIndex];
    final selectedAnswer = state.selectedAnswers[currentIndex];
    final progress = (currentIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Module Quiz', style: AppTextStyles.headingSm),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onClose,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.divider,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.responsivePagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question count
              Text(
                'Question ${currentIndex + 1} of ${questions.length}',
                style: AppTextStyles.labelSm
                    .copyWith(color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.md),

              // Question text
              Text(currentQuestion.question, style: AppTextStyles.headingMd),
              const SizedBox(height: AppSpacing.lg),

              // Answers
              Expanded(
                child: ListView.separated(
                  itemCount: currentQuestion.answers.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, index) {
                    final label = currentQuestion.answers[index];
                    final isSelected = selectedAnswer == index;
                    return _AnswerOption(
                      label: label,
                      isSelected: isSelected,
                      onTap: () => ref
                          .read(quizStateProvider.notifier)
                          .selectAnswer(currentIndex, index),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // Navigation buttons
              Row(
                children: [
                  if (currentIndex > 0)
                    TextButton(
                      onPressed: () => ref
                          .read(quizStateProvider.notifier)
                          .previousQuestion(),
                      child: const Text('Back'),
                    ),
                  const Spacer(),
                  if (currentIndex < questions.length - 1)
                    ElevatedButton(
                      onPressed: selectedAnswer != null
                          ? () => ref
                              .read(quizStateProvider.notifier)
                              .nextQuestion()
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Next'),
                    )
                  else
                    ElevatedButton(
                      onPressed: selectedAnswer != null && !state.isSubmitting
                          ? () => ref
                              .read(quizStateProvider.notifier)
                              .submit(widget.chapter.id!, questions)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: state.isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Text('Finish Quiz'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.onSurfaceSubtle,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodySm.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizResultView extends StatelessWidget {
  const _QuizResultView({
    required this.result,
    required this.onClose,
    required this.onRetry,
  });

  final UserTheoryProgress result;
  final VoidCallback onClose;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final passed = result.status == ModuleProgressStatus.completed;
    final isMobile = context.isMobile;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
                isMobile ? AppSpacing.md : AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  passed
                      ? Icons.emoji_events_rounded
                      : Icons.sentiment_dissatisfied_rounded,
                  size: isMobile ? 72 : 100,
                  color: passed ? Colors.amber : AppColors.error,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  passed ? 'Congratulations!' : 'Almost there!',
                  style: AppTextStyles.headingLg,
                ),
                const SizedBox(height: 8),
                Text(
                  passed
                      ? 'You passed the theory quiz.'
                      : 'Try again to pass this module.',
                  style: AppTextStyles.bodySm
                      .copyWith(color: AppColors.onSurfaceMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? AppSpacing.lg : 32,
                    vertical: isMobile ? AppSpacing.md : 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusLg),
                  ),
                  child: Column(
                    children: [
                      Text('Your Score',
                          style: AppTextStyles.labelSm),
                      const SizedBox(height: 8),
                      Text(
                        '${result.score}%',
                        style: AppTextStyles.headingLg.copyWith(
                          color: passed
                              ? AppColors.success
                              : AppColors.error,
                          fontSize: isMobile ? 36 : 48,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        passed ? 'PASSED' : 'NOT PASSED',
                        style: AppTextStyles.labelMd.copyWith(
                          color: passed
                              ? AppColors.success
                              : AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? AppSpacing.xl : 48),
                // Buttons: stack vertically on mobile
                if (isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: onClose,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30)),
                        ),
                        child: const Text('Back to Course'),
                      ),
                      if (!passed) ...[
                        const SizedBox(height: AppSpacing.sm),
                        OutlinedButton(
                          onPressed: onRetry,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30)),
                          ),
                          child: const Text('Retry Quiz'),
                        ),
                      ],
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!passed) ...[
                        OutlinedButton(
                          onPressed: onRetry,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30)),
                          ),
                          child: const Text('Retry Quiz'),
                        ),
                        const SizedBox(width: 16),
                      ],
                      ElevatedButton(
                        onPressed: onClose,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30)),
                        ),
                        child: const Text('Back to Course'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
