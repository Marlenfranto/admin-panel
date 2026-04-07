import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../src/providers.dart';

/// Fetches all theory chapters joined with the user's current progress.
final theoryChaptersProvider = FutureProvider.autoDispose<List<TheoryChapterWithProgress>>((ref) async {
  final client = ref.watch(clientProvider);
  return await client.user.getTheoryChaptersWithProgress();
});

/// Manages the state of a single quiz attempt.
final quizStateProvider = StateNotifierProvider.autoDispose<QuizNotifier, QuizState>((ref) {
  return QuizNotifier(ref);
});

class QuizState {
  final int currentQuestionIndex;
  final List<int?> selectedAnswers;
  final bool isSubmitting;
  final UserTheoryProgress? result;

  QuizState({
    this.currentQuestionIndex = 0,
    this.selectedAnswers = const [],
    this.isSubmitting = false,
    this.result,
  });

  QuizState copyWith({
    int? currentQuestionIndex,
    List<int?>? selectedAnswers,
    bool? isSubmitting,
    UserTheoryProgress? result,
  }) {
    return QuizState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      result: result ?? this.result,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  final Ref ref;
  QuizNotifier(this.ref) : super(QuizState());

  void init(int questionCount) {
    state = QuizState(selectedAnswers: List.filled(questionCount, null));
  }

  void selectAnswer(int questionIndex, int answerIndex) {
    final newAnswers = List<int?>.from(state.selectedAnswers);
    newAnswers[questionIndex] = answerIndex;
    state = state.copyWith(selectedAnswers: newAnswers);
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.selectedAnswers.length - 1) {
      state = state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1);
    }
  }

  void previousQuestion() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1);
    }
  }

  Future<void> submit(int chapterId, List<QuizQuestion> questions) async {
    state = state.copyWith(isSubmitting: true);
    
    try {
      int correctCount = 0;
      for (int i = 0; i < questions.length; i++) {
        if (state.selectedAnswers[i] == questions[i].correctAnswer) {
          correctCount++;
        }
      }
      
      final score = ((correctCount / questions.length) * 100).round();
      final client = ref.read(clientProvider);
      
      final result = await client.user.submitTheoryQuiz(chapterId, score);
      state = state.copyWith(isSubmitting: false, result: result);
      
      // Refresh chapters listing to show updated status/score
      ref.invalidate(theoryChaptersProvider);
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }
}
