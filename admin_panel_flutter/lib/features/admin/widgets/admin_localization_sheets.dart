import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../src/providers.dart';
import '../providers/admin_providers.dart';

// ── Host shell (centered dialog, matches _ChapterDialog) ──────────────────

Future<void> _showLocalizationSheet({
  required BuildContext context,
  required String title,
  required Widget body,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) => Dialog(
      backgroundColor: AppColors.surfaceVariant,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640, maxHeight: 720),
        child: body,
      ),
    ),
  );
}

// ── Theory chapter ─────────────────────────────────────────────────────────

Future<void> showTheoryChapterLocalizationsSheet({
  required BuildContext context,
  required int chapterId,
  required int orgId,
  required String parentLabel,
  List<QuizQuestion>? questions,
}) {
  return _showLocalizationSheet(
    context: context,
    title: 'Localizations — $parentLabel',
    body: _TheoryChapterLocalizationsBody(
      chapterId: chapterId,
      orgId: orgId,
      parentLabel: parentLabel,
      questions: questions ?? const <QuizQuestion>[],
    ),
  );
}

class _QuizQuestionState {
  _QuizQuestionState(int answerCount)
      : questionCtrl = TextEditingController(),
        answerCtrls =
            List.generate(answerCount, (_) => TextEditingController());

  final TextEditingController questionCtrl;
  final List<TextEditingController> answerCtrls;

  void dispose() {
    questionCtrl.dispose();
    for (final c in answerCtrls) {
      c.dispose();
    }
  }
}

class _TheoryChapterLocalizationsBody extends ConsumerStatefulWidget {
  const _TheoryChapterLocalizationsBody({
    required this.chapterId,
    required this.orgId,
    required this.parentLabel,
    required this.questions,
  });
  final int chapterId;
  final int orgId;
  final String parentLabel;
  final List<QuizQuestion> questions;

  @override
  ConsumerState<_TheoryChapterLocalizationsBody> createState() =>
      _TheoryChapterLocalizationsBodyState();
}

class _TheoryChapterLocalizationsBodyState
    extends ConsumerState<_TheoryChapterLocalizationsBody> {
  String? _selectedLocaleKey;
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _thumbCtrl = TextEditingController();
  final _videoCtrl = TextEditingController();
  late List<_QuizQuestionState> _quizStates;
  TheoryChapterLocalization? _current;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _quizStates = widget.questions
        .map((q) => _QuizQuestionState(q.answers.length))
        .toList();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _thumbCtrl.dispose();
    _videoCtrl.dispose();
    for (final s in _quizStates) {
      s.dispose();
    }
    super.dispose();
  }

  /// Reads the per-locale embedded translation for each quiz question and
  /// fills the per-question editors. Falls back to empty strings when a
  /// question has no entry yet for the selected locale.
  void _loadQuizTranslationsForLocale(String localeKey) {
    for (var i = 0; i < widget.questions.length; i++) {
      final q = widget.questions[i];
      final translations = q.translations ?? const <LocalizedQuizContent>[];
      LocalizedQuizContent? match;
      for (final t in translations) {
        if ((t.localeKey ?? t.languageCode) == localeKey) {
          match = t;
          break;
        }
      }
      final state = _quizStates[i];
      state.questionCtrl.text = match?.question ?? '';
      for (var j = 0; j < state.answerCtrls.length; j++) {
        final src = (match?.answers ?? const <String>[]);
        state.answerCtrls[j].text = j < src.length ? src[j] : '';
      }
    }
  }

  void _loadInto(TheoryChapterLocalization? loc) {
    _current = loc;
    _titleCtrl.text = loc?.title ?? '';
    _descCtrl.text = loc?.description ?? '';
    _thumbCtrl.text = loc?.thumbnailUrl ?? '';
    _videoCtrl.text = loc?.videoUrl ?? '';
  }

  Future<void> _save() async {
    if (_selectedLocaleKey == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final localeKey = _selectedLocaleKey!;
    setState(() => _saving = true);
    try {
      final loc = TheoryChapterLocalization(
        id: _current?.id,
        chapterId: widget.chapterId,
        localeKey: localeKey,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty
            ? null
            : _descCtrl.text.trim(),
        thumbnailUrl: _thumbCtrl.text.trim().isEmpty
            ? null
            : _thumbCtrl.text.trim(),
        videoUrl: _videoCtrl.text.trim().isEmpty
            ? null
            : _videoCtrl.text.trim(),
        videoMetadata: _current?.videoMetadata,
      );
      final saved = await ref
          .read(clientProvider)
          .admin
          .upsertTheoryChapterLocalization(widget.chapterId, loc);
      _current = saved;

      if (widget.questions.isNotEmpty) {
        final quizTranslations = <LocalizedQuizContent>[];
        for (var i = 0; i < widget.questions.length; i++) {
          final state = _quizStates[i];
          quizTranslations.add(
            LocalizedQuizContent(
              languageCode: '',
              localeKey: localeKey,
              question: state.questionCtrl.text.trim(),
              answers: state.answerCtrls
                  .map((c) => c.text.trim())
                  .toList(growable: false),
            ),
          );
        }
        await ref.read(clientProvider).admin.setTheoryChapterQuizTranslations(
              widget.chapterId,
              localeKey,
              quizTranslations,
            );
      }

      ref.invalidate(
          adminTheoryChapterLocalizationsProvider(widget.chapterId));
      if (mounted) {
        navigator.pop();
        messenger.showSnackBar(
          SnackBar(content: Text('Saved $localeKey')),
        );
      }
    } catch (e) {
      if (mounted) {
        _snackError(e);
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _delete() async {
    if (_current?.id == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final localeKey = _selectedLocaleKey;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .admin
          .deleteTheoryChapterLocalization(_current!.id!);
      ref.invalidate(
          adminTheoryChapterLocalizationsProvider(widget.chapterId));
      if (mounted) {
        navigator.pop();
        messenger.showSnackBar(
          SnackBar(content: Text('Deleted $localeKey')),
        );
      }
    } catch (e) {
      if (mounted) {
        _snackError(e);
        setState(() => _saving = false);
      }
    }
  }

  void _snackError(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString().replaceFirst('Exception: ', '')),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localesAsync =
        ref.watch(adminLocaleConfigsProvider(widget.orgId));
    final existingAsync = ref
        .watch(adminTheoryChapterLocalizationsProvider(widget.chapterId));
    final cfgAsync = ref.watch(moduleConfigProvider(widget.orgId));

    if (localesAsync.isLoading || existingAsync.isLoading) {
      return const AppSkeletonBox(height: 200);
    }
    if (localesAsync.hasError) {
      return Text('Error: ${localesAsync.error}');
    }
    final locales = localesAsync.value ?? [];
    final existing = existingAsync.value ?? [];
    final defaultKey = cfgAsync.value?.defaultLocaleKey ?? 'US-en';

    if (locales.isEmpty) {
      return const Text('No locales configured for this organization.');
    }

    // Default locale is edited via the main entry editor; only show
    // non-default locales here.
    final nonDefault = locales.where((l) => l.localeKey != defaultKey).toList();
    if (nonDefault.isEmpty) {
      return _LocalizationLayout(
        title: 'Localizations — ${widget.parentLabel}',
        chipRow: null,
        form: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The default locale ($defaultKey) is edited in the main chapter editor.',
              style: AppTextStyles.bodySm,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Add more locales under Locale Management to author region-specific variants here.',
              style: AppTextStyles.bodyXs,
            ),
          ],
        ),
        saving: false,
        canSave: false,
        canDelete: false,
        onSave: () async {},
        onDelete: () async {},
      );
    }

    final firstLoad =
        _selectedLocaleKey == null || _selectedLocaleKey == defaultKey;
    if (firstLoad) {
      _selectedLocaleKey = nonDefault.first.localeKey;
    }
    final existingByKey = {for (final l in existing) l.localeKey: l};
    if (firstLoad || _current?.localeKey != _selectedLocaleKey) {
      _loadInto(existingByKey[_selectedLocaleKey]);
      _loadQuizTranslationsForLocale(_selectedLocaleKey!);
    }

    return _LocalizationLayout(
      title: 'Localizations — ${widget.parentLabel}',
      chipRow: LocaleChipRow(
        locales: nonDefault,
        selectedLocaleKey: _selectedLocaleKey!,
        existingLocaleKeys: existingByKey.keys.toSet(),
        defaultLocaleKey: defaultKey,
        onSelected: (key) => setState(() {
          _selectedLocaleKey = key;
          _loadInto(existingByKey[key]);
          _loadQuizTranslationsForLocale(key);
        }),
      ),
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetSection(title: 'Chapter Details'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _titleCtrl,
            decoration:
                const InputDecoration(labelText: 'Title', isDense: true),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _thumbCtrl,
            decoration: const InputDecoration(
                labelText: 'Thumbnail URL', isDense: true),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SheetSection(title: 'Video'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _videoCtrl,
            decoration:
                const InputDecoration(labelText: 'Video URL', isDense: true),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _descCtrl,
            maxLines: 2,
            decoration: const InputDecoration(
                labelText: 'Video Description', isDense: true),
          ),
          if (widget.questions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                const SheetSection(title: 'Quiz Questions'),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '· $_selectedLocaleKey',
                  style: AppTextStyles.bodyXs
                      .copyWith(color: AppColors.onSurfaceMuted),
                ),
              ],
            ),
            Text(
              'The correct-answer index is shared across all locales.',
              style: AppTextStyles.bodyXs,
            ),
            const SizedBox(height: AppSpacing.sm),
            for (var i = 0; i < widget.questions.length; i++)
              _QuizQuestionEditor(
                index: i,
                question: widget.questions[i],
                state: _quizStates[i],
                defaultLocaleKey: defaultKey,
                selectedLocaleKey: _selectedLocaleKey!,
              ),
          ],
        ],
      ),
      saving: _saving,
      canSave: true,
      canDelete: _current?.id != null,
      onSave: _save,
      onDelete: _delete,
    );
  }
}

class _QuizQuestionEditor extends StatelessWidget {
  const _QuizQuestionEditor({
    required this.index,
    required this.question,
    required this.state,
    required this.defaultLocaleKey,
    required this.selectedLocaleKey,
  });

  final int index;
  final QuizQuestion question;
  final _QuizQuestionState state;
  final String defaultLocaleKey;
  final String selectedLocaleKey;

  @override
  Widget build(BuildContext context) {
    final defaultText = question.question.trim().isEmpty
        ? '(no default-locale text yet)'
        : question.question;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Q${index + 1}',
                style: AppTextStyles.labelMd
                    .copyWith(color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                selectedLocaleKey,
                style: AppTextStyles.bodyXs
                    .copyWith(color: AppColors.onSurfaceMuted),
              ),
              const Spacer(),
              AppStatusChip(
                label: 'Correct: ${question.correctAnswer + 1}',
                variant: AppChipVariant.success,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$defaultLocaleKey: $defaultText',
            style: AppTextStyles.bodyXs
                .copyWith(color: AppColors.onSurfaceMuted),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: state.questionCtrl,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Question ($selectedLocaleKey)',
              isDense: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Answer Options', style: AppTextStyles.labelSm),
          const SizedBox(height: 6),
          for (var j = 0; j < state.answerCtrls.length; j++) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: TextField(
                controller: state.answerCtrls[j],
                decoration: InputDecoration(
                  labelText: 'Option ${j + 1}'
                      '${j == question.correctAnswer ? ' ✓' : ''}',
                  hintText: j < question.answers.length
                      ? question.answers[j]
                      : null,
                  isDense: true,
                  labelStyle: j == question.correctAnswer
                      ? const TextStyle(color: AppColors.success)
                      : null,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Training parameter ─────────────────────────────────────────────────────

Future<void> showTrainingParameterLocalizationsSheet({
  required BuildContext context,
  required int parameterId,
  required int orgId,
  required String parentLabel,
  required int feedbackCount,
}) {
  return _showLocalizationSheet(
    context: context,
    title: 'Localizations — $parentLabel',
    body: _TrainingParameterLocalizationsBody(
      parameterId: parameterId,
      orgId: orgId,
      parentLabel: parentLabel,
      feedbackCount: feedbackCount,
    ),
  );
}

class _TrainingParameterLocalizationsBody extends ConsumerStatefulWidget {
  const _TrainingParameterLocalizationsBody({
    required this.parameterId,
    required this.orgId,
    required this.parentLabel,
    required this.feedbackCount,
  });
  final int parameterId;
  final int orgId;
  final String parentLabel;
  final int feedbackCount;

  @override
  ConsumerState<_TrainingParameterLocalizationsBody> createState() =>
      _TrainingParameterLocalizationsBodyState();
}

class _TrainingParameterLocalizationsBodyState
    extends ConsumerState<_TrainingParameterLocalizationsBody> {
  String? _selectedLocaleKey;
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  late List<TextEditingController> _feedbackCtrls;
  TrainingParameterLocalization? _current;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _feedbackCtrls = List.generate(
      widget.feedbackCount,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    for (final c in _feedbackCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  void _loadInto(TrainingParameterLocalization? loc) {
    _current = loc;
    _nameCtrl.text = loc?.name ?? '';
    _descCtrl.text = loc?.description ?? '';
    final fb = loc?.scoringFeedbacks ?? const <String>[];
    for (var i = 0; i < _feedbackCtrls.length; i++) {
      _feedbackCtrls[i].text = i < fb.length ? fb[i] : '';
    }
  }

  Future<void> _save() async {
    if (_selectedLocaleKey == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final localeKey = _selectedLocaleKey!;
    setState(() => _saving = true);
    try {
      final loc = TrainingParameterLocalization(
        id: _current?.id,
        parameterId: widget.parameterId,
        localeKey: localeKey,
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        scoringFeedbacks:
            _feedbackCtrls.map((c) => c.text.trim()).toList(),
      );
      final saved = await ref
          .read(clientProvider)
          .admin
          .upsertTrainingParameterLocalization(widget.parameterId, loc);
      _current = saved;
      ref.invalidate(adminTrainingParameterLocalizationsProvider(
          widget.parameterId));
      if (mounted) {
        navigator.pop();
        messenger.showSnackBar(
          SnackBar(content: Text('Saved $localeKey')),
        );
      }
    } catch (e) {
      if (mounted) {
        _snackError(e);
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _delete() async {
    if (_current?.id == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final localeKey = _selectedLocaleKey;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .admin
          .deleteTrainingParameterLocalization(_current!.id!);
      ref.invalidate(adminTrainingParameterLocalizationsProvider(
          widget.parameterId));
      if (mounted) {
        navigator.pop();
        messenger.showSnackBar(
          SnackBar(content: Text('Deleted $localeKey')),
        );
      }
    } catch (e) {
      if (mounted) {
        _snackError(e);
        setState(() => _saving = false);
      }
    }
  }

  void _snackError(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString().replaceFirst('Exception: ', '')),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localesAsync =
        ref.watch(adminLocaleConfigsProvider(widget.orgId));
    final existingAsync = ref.watch(
        adminTrainingParameterLocalizationsProvider(widget.parameterId));
    final cfgAsync = ref.watch(moduleConfigProvider(widget.orgId));

    if (localesAsync.isLoading || existingAsync.isLoading) {
      return const AppSkeletonBox(height: 200);
    }
    final locales = localesAsync.value ?? [];
    final existing = existingAsync.value ?? [];
    final defaultKey = cfgAsync.value?.defaultLocaleKey ?? 'US-en';
    final nonDefault =
        locales.where((l) => l.localeKey != defaultKey).toList();
    if (locales.isEmpty || nonDefault.isEmpty) {
      return _LocalizationLayout(
        title: 'Localizations — ${widget.parentLabel}',
        chipRow: null,
        form: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locales.isEmpty
                  ? 'No locales configured for this organization.'
                  : 'The default locale ($defaultKey) is edited in the main parameter editor.',
              style: AppTextStyles.bodySm,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Add more locales under Locale Management to author region-specific variants here.',
              style: AppTextStyles.bodyXs,
            ),
          ],
        ),
        saving: false,
        canSave: false,
        canDelete: false,
        onSave: () async {},
        onDelete: () async {},
      );
    }

    final firstLoad =
        _selectedLocaleKey == null || _selectedLocaleKey == defaultKey;
    if (firstLoad) {
      _selectedLocaleKey = nonDefault.first.localeKey;
    }
    final existingByKey = {for (final l in existing) l.localeKey: l};
    if (_current?.localeKey != _selectedLocaleKey) {
      _loadInto(existingByKey[_selectedLocaleKey]);
    }

    return _LocalizationLayout(
      chipRow: LocaleChipRow(
        locales: nonDefault,
        selectedLocaleKey: _selectedLocaleKey!,
        existingLocaleKeys: existingByKey.keys.toSet(),
        defaultLocaleKey: defaultKey,
        onSelected: (key) => setState(() {
          _selectedLocaleKey = key;
          _loadInto(existingByKey[key]);
        }),
      ),
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetSection(title: 'Parameter Details'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Name',
              isDense: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _descCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              isDense: true,
            ),
          ),
          if (widget.feedbackCount > 0) ...[
            const SizedBox(height: AppSpacing.lg),
            const SheetSection(title: 'Scoring Feedback'),
            const SizedBox(height: AppSpacing.sm),
            for (var i = 0; i < widget.feedbackCount; i++) ...[
              TextField(
                controller: _feedbackCtrls[i],
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Feedback #${i + 1}',
                  isDense: true,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ],
      ),
      saving: _saving,
      canSave: true,
      canDelete: _current?.id != null,
      title: 'Localizations — ${widget.parentLabel}',
      onSave: _save,
      onDelete: _delete,
    );
  }
}

// ── Assessment parameter ───────────────────────────────────────────────────

Future<void> showAssessmentParameterLocalizationsSheet({
  required BuildContext context,
  required int parameterId,
  required int orgId,
  required String parentLabel,
  required int feedbackCount,
}) {
  return _showLocalizationSheet(
    context: context,
    title: 'Localizations — $parentLabel',
    body: _AssessmentParameterLocalizationsBody(
      parameterId: parameterId,
      orgId: orgId,
      parentLabel: parentLabel,
      feedbackCount: feedbackCount,
    ),
  );
}

class _AssessmentParameterLocalizationsBody extends ConsumerStatefulWidget {
  const _AssessmentParameterLocalizationsBody({
    required this.parameterId,
    required this.orgId,
    required this.parentLabel,
    required this.feedbackCount,
  });
  final int parameterId;
  final int orgId;
  final String parentLabel;
  final int feedbackCount;

  @override
  ConsumerState<_AssessmentParameterLocalizationsBody> createState() =>
      _AssessmentParameterLocalizationsBodyState();
}

class _AssessmentParameterLocalizationsBodyState
    extends ConsumerState<_AssessmentParameterLocalizationsBody> {
  String? _selectedLocaleKey;
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  late List<TextEditingController> _feedbackCtrls;
  AssessmentParameterLocalization? _current;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _feedbackCtrls = List.generate(
      widget.feedbackCount,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    for (final c in _feedbackCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  void _loadInto(AssessmentParameterLocalization? loc) {
    _current = loc;
    _nameCtrl.text = loc?.name ?? '';
    _descCtrl.text = loc?.description ?? '';
    final fb = loc?.scoringFeedbacks ?? const <String>[];
    for (var i = 0; i < _feedbackCtrls.length; i++) {
      _feedbackCtrls[i].text = i < fb.length ? fb[i] : '';
    }
  }

  Future<void> _save() async {
    if (_selectedLocaleKey == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final localeKey = _selectedLocaleKey!;
    setState(() => _saving = true);
    try {
      final loc = AssessmentParameterLocalization(
        id: _current?.id,
        parameterId: widget.parameterId,
        localeKey: localeKey,
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        scoringFeedbacks:
            _feedbackCtrls.map((c) => c.text.trim()).toList(),
      );
      final saved = await ref
          .read(clientProvider)
          .admin
          .upsertAssessmentParameterLocalization(widget.parameterId, loc);
      _current = saved;
      ref.invalidate(adminAssessmentParameterLocalizationsProvider(
          widget.parameterId));
      if (mounted) {
        navigator.pop();
        messenger.showSnackBar(
          SnackBar(content: Text('Saved $localeKey')),
        );
      }
    } catch (e) {
      if (mounted) {
        _snackError(e);
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _delete() async {
    if (_current?.id == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final localeKey = _selectedLocaleKey;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .admin
          .deleteAssessmentParameterLocalization(_current!.id!);
      ref.invalidate(adminAssessmentParameterLocalizationsProvider(
          widget.parameterId));
      if (mounted) {
        navigator.pop();
        messenger.showSnackBar(
          SnackBar(content: Text('Deleted $localeKey')),
        );
      }
    } catch (e) {
      if (mounted) {
        _snackError(e);
        setState(() => _saving = false);
      }
    }
  }

  void _snackError(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString().replaceFirst('Exception: ', '')),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localesAsync =
        ref.watch(adminLocaleConfigsProvider(widget.orgId));
    final existingAsync = ref.watch(
        adminAssessmentParameterLocalizationsProvider(widget.parameterId));
    final cfgAsync = ref.watch(moduleConfigProvider(widget.orgId));

    if (localesAsync.isLoading || existingAsync.isLoading) {
      return const AppSkeletonBox(height: 200);
    }
    final locales = localesAsync.value ?? [];
    final existing = existingAsync.value ?? [];
    final defaultKey = cfgAsync.value?.defaultLocaleKey ?? 'US-en';
    final nonDefault =
        locales.where((l) => l.localeKey != defaultKey).toList();
    if (locales.isEmpty || nonDefault.isEmpty) {
      return _LocalizationLayout(
        title: 'Localizations — ${widget.parentLabel}',
        chipRow: null,
        form: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locales.isEmpty
                  ? 'No locales configured for this organization.'
                  : 'The default locale ($defaultKey) is edited in the main parameter editor.',
              style: AppTextStyles.bodySm,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Add more locales under Locale Management to author region-specific variants here.',
              style: AppTextStyles.bodyXs,
            ),
          ],
        ),
        saving: false,
        canSave: false,
        canDelete: false,
        onSave: () async {},
        onDelete: () async {},
      );
    }

    final firstLoad =
        _selectedLocaleKey == null || _selectedLocaleKey == defaultKey;
    if (firstLoad) {
      _selectedLocaleKey = nonDefault.first.localeKey;
    }
    final existingByKey = {for (final l in existing) l.localeKey: l};
    if (_current?.localeKey != _selectedLocaleKey) {
      _loadInto(existingByKey[_selectedLocaleKey]);
    }

    return _LocalizationLayout(
      chipRow: LocaleChipRow(
        locales: nonDefault,
        selectedLocaleKey: _selectedLocaleKey!,
        existingLocaleKeys: existingByKey.keys.toSet(),
        defaultLocaleKey: defaultKey,
        onSelected: (key) => setState(() {
          _selectedLocaleKey = key;
          _loadInto(existingByKey[key]);
        }),
      ),
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetSection(title: 'Parameter Details'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Name',
              isDense: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _descCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              isDense: true,
            ),
          ),
          if (widget.feedbackCount > 0) ...[
            const SizedBox(height: AppSpacing.lg),
            const SheetSection(title: 'Scoring Feedback'),
            const SizedBox(height: AppSpacing.sm),
            for (var i = 0; i < widget.feedbackCount; i++) ...[
              TextField(
                controller: _feedbackCtrls[i],
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Feedback #${i + 1}',
                  isDense: true,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ],
      ),
      saving: _saving,
      canSave: true,
      canDelete: _current?.id != null,
      title: 'Localizations — ${widget.parentLabel}',
      onSave: _save,
      onDelete: _delete,
    );
  }
}

// ── Asset ──────────────────────────────────────────────────────────────────

Future<void> showAssetLocalizationsSheet({
  required BuildContext context,
  required int assetId,
  required int orgId,
  required String parentLabel,
}) {
  return _showLocalizationSheet(
    context: context,
    title: 'Localizations — $parentLabel',
    body: _AssetLocalizationsBody(
      assetId: assetId,
      orgId: orgId,
      parentLabel: parentLabel,
    ),
  );
}

class _AssetLocalizationsBody extends ConsumerStatefulWidget {
  const _AssetLocalizationsBody({
    required this.assetId,
    required this.orgId,
    required this.parentLabel,
  });
  final int assetId;
  final int orgId;
  final String parentLabel;

  @override
  ConsumerState<_AssetLocalizationsBody> createState() =>
      _AssetLocalizationsBodyState();
}

class _AssetLocalizationsBodyState
    extends ConsumerState<_AssetLocalizationsBody> {
  String? _selectedLocaleKey;
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _urlCtrl = TextEditingController();
  AssetLocalization? _current;
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _urlCtrl.dispose();
    super.dispose();
  }

  void _loadInto(AssetLocalization? loc) {
    _current = loc;
    _nameCtrl.text = loc?.name ?? '';
    _descCtrl.text = loc?.description ?? '';
    _urlCtrl.text = loc?.url ?? '';
  }

  Future<void> _save() async {
    if (_selectedLocaleKey == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final localeKey = _selectedLocaleKey!;
    setState(() => _saving = true);
    try {
      final loc = AssetLocalization(
        id: _current?.id,
        assetId: widget.assetId,
        localeKey: localeKey,
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty
            ? null
            : _descCtrl.text.trim(),
        url: _urlCtrl.text.trim(),
      );
      final saved = await ref
          .read(clientProvider)
          .admin
          .upsertAssetLocalization(widget.assetId, loc);
      _current = saved;
      ref.invalidate(adminAssetLocalizationsProvider(widget.assetId));
      if (mounted) {
        navigator.pop();
        messenger.showSnackBar(
          SnackBar(content: Text('Saved $localeKey')),
        );
      }
    } catch (e) {
      if (mounted) {
        _snackError(e);
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _delete() async {
    if (_current?.id == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final localeKey = _selectedLocaleKey;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .admin
          .deleteAssetLocalization(_current!.id!);
      ref.invalidate(adminAssetLocalizationsProvider(widget.assetId));
      if (mounted) {
        navigator.pop();
        messenger.showSnackBar(
          SnackBar(content: Text('Deleted $localeKey')),
        );
      }
    } catch (e) {
      if (mounted) {
        _snackError(e);
        setState(() => _saving = false);
      }
    }
  }

  void _snackError(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString().replaceFirst('Exception: ', '')),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localesAsync =
        ref.watch(adminLocaleConfigsProvider(widget.orgId));
    final existingAsync =
        ref.watch(adminAssetLocalizationsProvider(widget.assetId));
    final cfgAsync = ref.watch(moduleConfigProvider(widget.orgId));

    if (localesAsync.isLoading || existingAsync.isLoading) {
      return const AppSkeletonBox(height: 200);
    }
    final locales = localesAsync.value ?? [];
    final existing = existingAsync.value ?? [];
    final defaultKey = cfgAsync.value?.defaultLocaleKey ?? 'US-en';
    final nonDefault =
        locales.where((l) => l.localeKey != defaultKey).toList();
    if (locales.isEmpty || nonDefault.isEmpty) {
      return _LocalizationLayout(
        title: 'Localizations — ${widget.parentLabel}',
        chipRow: null,
        form: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locales.isEmpty
                  ? 'No locales configured for this organization.'
                  : 'The default locale ($defaultKey) is edited in the main asset editor.',
              style: AppTextStyles.bodySm,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Add more locales under Locale Management to author region-specific variants here.',
              style: AppTextStyles.bodyXs,
            ),
          ],
        ),
        saving: false,
        canSave: false,
        canDelete: false,
        onSave: () async {},
        onDelete: () async {},
      );
    }

    final firstLoad =
        _selectedLocaleKey == null || _selectedLocaleKey == defaultKey;
    if (firstLoad) {
      _selectedLocaleKey = nonDefault.first.localeKey;
    }
    final existingByKey = {for (final l in existing) l.localeKey: l};
    if (_current?.localeKey != _selectedLocaleKey) {
      _loadInto(existingByKey[_selectedLocaleKey]);
    }

    return _LocalizationLayout(
      chipRow: LocaleChipRow(
        locales: nonDefault,
        selectedLocaleKey: _selectedLocaleKey!,
        existingLocaleKeys: existingByKey.keys.toSet(),
        defaultLocaleKey: defaultKey,
        onSelected: (key) => setState(() {
          _selectedLocaleKey = key;
          _loadInto(existingByKey[key]);
        }),
      ),
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetSection(title: 'Asset Details'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              labelText: 'Name',
              isDense: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _descCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              isDense: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _urlCtrl,
            decoration: const InputDecoration(
              labelText: 'URL',
              isDense: true,
            ),
          ),
        ],
      ),
      saving: _saving,
      canSave: true,
      canDelete: _current?.id != null,
      title: 'Localizations — ${widget.parentLabel}',
      onSave: _save,
      onDelete: _delete,
    );
  }
}

// ── Shared layout chrome ───────────────────────────────────────────────────

/// Full dialog content matching the Add Chapter UX:
///   - Sticky header with title + close
///   - Sticky chip row (when provided)
///   - Scrollable form body
///   - Sticky footer with Delete (when canDelete) + Cancel + Save
class _LocalizationLayout extends StatelessWidget {
  const _LocalizationLayout({
    required this.title,
    required this.chipRow,
    required this.form,
    required this.saving,
    required this.canSave,
    required this.canDelete,
    required this.onSave,
    required this.onDelete,
  });

  final String title;
  final Widget? chipRow;
  final Widget form;
  final bool saving;
  final bool canSave;
  final bool canDelete;
  final Future<void> Function() onSave;
  final Future<void> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: AppTextStyles.headingMd),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed:
                    saving ? null : () => Navigator.of(context).pop(),
                tooltip: 'Close',
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        if (chipRow != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: chipRow!,
          ),
          const Divider(height: 1),
        ],
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: form,
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (canDelete)
                OutlinedButton.icon(
                  onPressed: saving ? null : onDelete,
                  icon: const Icon(Icons.delete_outline_rounded, size: 16),
                  label: const Text('Delete Locale'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                ),
              const Spacer(),
              OutlinedButton(
                onPressed:
                    saving ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
              if (canSave)
                AppGradientButton(
                  label: 'Save Locale',
                  icon: Icons.save_rounded,
                  isLoading: saving,
                  onPressed: saving ? null : onSave,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
