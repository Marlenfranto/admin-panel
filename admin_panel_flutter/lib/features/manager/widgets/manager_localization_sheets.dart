import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../src/providers.dart';
import '../providers/manager_providers.dart';

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

Future<void> showManagerTheoryChapterLocalizationsSheet({
  required BuildContext context,
  required int orgId,
  required int chapterId,
  required String parentLabel,
  List<QuizQuestion>? questions,
}) {
  return _showLocalizationSheet(
    context: context,
    title: 'Localizations — $parentLabel',
    body: _MgrTheoryChapterBody(
      orgId: orgId,
      chapterId: chapterId,
      parentLabel: parentLabel,
      questions: questions ?? const <QuizQuestion>[],
    ),
  );
}

class _MgrQuizQuestionState {
  _MgrQuizQuestionState(int answerCount)
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

class _MgrTheoryChapterBody extends ConsumerStatefulWidget {
  const _MgrTheoryChapterBody({
    required this.orgId,
    required this.chapterId,
    required this.parentLabel,
    required this.questions,
  });
  final int orgId;
  final int chapterId;
  final String parentLabel;
  final List<QuizQuestion> questions;

  @override
  ConsumerState<_MgrTheoryChapterBody> createState() =>
      _MgrTheoryChapterBodyState();
}

class _MgrTheoryChapterBodyState extends ConsumerState<_MgrTheoryChapterBody> {
  String? _selectedLocaleKey;
  String? _loadedLocaleKey;
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _thumbCtrl = TextEditingController();
  final _videoCtrl = TextEditingController();
  late List<_MgrQuizQuestionState> _quizStates;
  TheoryChapterLocalization? _current;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _quizStates = widget.questions
        .map((q) => _MgrQuizQuestionState(q.answers.length))
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

  void _loadQuizTranslationsForLocale(String localeKey) {
    for (var i = 0; i < widget.questions.length; i++) {
      final q = widget.questions[i];
      LocalizedQuizContent? match;
      for (final t in q.translations ?? const <LocalizedQuizContent>[]) {
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
    _loadedLocaleKey = _selectedLocaleKey;
    _titleCtrl.text = loc?.title ?? '';
    _descCtrl.text = loc?.description ?? '';
    _thumbCtrl.text = loc?.thumbnailUrl ?? '';
    _videoCtrl.text = loc?.videoUrl ?? '';
  }

  Future<void> _save() async {
    if (_selectedLocaleKey == null) return;
    setState(() => _saving = true);
    try {
      final loc = TheoryChapterLocalization(
        id: _current?.id,
        chapterId: widget.chapterId,
        localeKey: _selectedLocaleKey!,
        title: _titleCtrl.text.trim(),
        description:
            _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
        thumbnailUrl:
            _thumbCtrl.text.trim().isEmpty ? null : _thumbCtrl.text.trim(),
        videoUrl:
            _videoCtrl.text.trim().isEmpty ? null : _videoCtrl.text.trim(),
        videoMetadata: _current?.videoMetadata,
      );
      final saved = await ref
          .read(clientProvider)
          .manager
          .upsertManagedTheoryChapterLocalization(
              widget.orgId, widget.chapterId, loc);
      _current = saved;

      if (widget.questions.isNotEmpty) {
        final quizTranslations = <LocalizedQuizContent>[];
        for (var i = 0; i < widget.questions.length; i++) {
          final state = _quizStates[i];
          quizTranslations.add(
            LocalizedQuizContent(
              languageCode: '',
              localeKey: _selectedLocaleKey,
              question: state.questionCtrl.text.trim(),
              answers: state.answerCtrls
                  .map((c) => c.text.trim())
                  .toList(growable: false),
            ),
          );
        }
        await ref
            .read(clientProvider)
            .manager
            .setManagedTheoryChapterQuizTranslations(
              widget.orgId,
              widget.chapterId,
              _selectedLocaleKey!,
              quizTranslations,
            );
      }

      ref.invalidate(managerTheoryChapterLocalizationsProvider(
          (widget.orgId, widget.chapterId)));
      ref.invalidate(managerTheoryProvider);
      if (mounted) _snackOk('Saved $_selectedLocaleKey');
    } catch (e) {
      if (mounted) _snackError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    if (_current?.id == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .manager
          .deleteManagedTheoryChapterLocalization(
              widget.orgId, _current!.id!);
      ref.invalidate(managerTheoryChapterLocalizationsProvider(
          (widget.orgId, widget.chapterId)));
      setState(() => _loadInto(null));
      if (mounted) _snackOk('Deleted $_selectedLocaleKey');
    } catch (e) {
      if (mounted) _snackError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snackOk(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
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
        ref.watch(managerLocaleConfigsProvider(widget.orgId));
    final existingAsync = ref.watch(managerTheoryChapterLocalizationsProvider(
        (widget.orgId, widget.chapterId)));
    final cfgAsync = ref.watch(managerModuleConfigProvider);

    if (localesAsync.isLoading || existingAsync.isLoading) {
      return const AppSkeletonBox(height: 200);
    }
    final locales = localesAsync.value ?? [];
    final existing = existingAsync.value ?? [];
    final defaultKey = cfgAsync.value?.defaultLocaleKey ?? 'US-en';
    final nonDefault =
        locales.where((l) => l.localeKey != defaultKey).toList();
    if (locales.isEmpty || nonDefault.isEmpty) {
      return _Layout(
        title: 'Localizations — ${widget.parentLabel}',
        chipRow: null,
        form: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locales.isEmpty
                  ? 'No locales configured for this organization.'
                  : 'The default locale ($defaultKey) is edited in the main chapter editor.',
              style: AppTextStyles.bodySm,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Add more locales to author region-specific variants here.',
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
    if (firstLoad || _loadedLocaleKey != _selectedLocaleKey) {
      _loadInto(existingByKey[_selectedLocaleKey]);
      _loadQuizTranslationsForLocale(_selectedLocaleKey!);
    }

    return _Layout(
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
          _field('Title', _titleCtrl),
          const SizedBox(height: AppSpacing.md),
          _field('Thumbnail URL', _thumbCtrl),
          const SizedBox(height: AppSpacing.lg),
          const SheetSection(title: 'Video'),
          const SizedBox(height: AppSpacing.sm),
          _field('Video URL', _videoCtrl),
          const SizedBox(height: AppSpacing.md),
          _field('Video Description', _descCtrl, maxLines: 2),
          if (widget.questions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                const SheetSection(title: 'Quiz Questions'),
                const SizedBox(width: AppSpacing.sm),
                Text('· $_selectedLocaleKey',
                    style: AppTextStyles.bodyXs
                        .copyWith(color: AppColors.onSurfaceMuted)),
              ],
            ),
            Text(
              'The correct-answer index is shared across all locales.',
              style: AppTextStyles.bodyXs,
            ),
            const SizedBox(height: AppSpacing.sm),
            for (var i = 0; i < widget.questions.length; i++)
              _MgrQuizQuestionEditor(
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

class _MgrQuizQuestionEditor extends StatelessWidget {
  const _MgrQuizQuestionEditor({
    required this.index,
    required this.question,
    required this.state,
    required this.defaultLocaleKey,
    required this.selectedLocaleKey,
  });

  final int index;
  final QuizQuestion question;
  final _MgrQuizQuestionState state;
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusChip),
                ),
                child: Text(
                  'Q${index + 1}',
                  style: AppTextStyles.labelMd
                      .copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(selectedLocaleKey,
                  style: AppTextStyles.bodyXs
                      .copyWith(color: AppColors.onSurfaceMuted)),
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

Future<void> showManagerTrainingParameterLocalizationsSheet({
  required BuildContext context,
  required int orgId,
  required int parameterId,
  required String parentLabel,
  required int feedbackCount,
}) {
  return _showLocalizationSheet(
    context: context,
    title: 'Localizations — $parentLabel',
    body: _MgrTrainingParamBody(
      orgId: orgId,
      parameterId: parameterId,
      parentLabel: parentLabel,
      feedbackCount: feedbackCount,
    ),
  );
}

class _MgrTrainingParamBody extends ConsumerStatefulWidget {
  const _MgrTrainingParamBody({
    required this.orgId,
    required this.parameterId,
    required this.parentLabel,
    required this.feedbackCount,
  });
  final int orgId;
  final int parameterId;
  final String parentLabel;
  final int feedbackCount;

  @override
  ConsumerState<_MgrTrainingParamBody> createState() =>
      _MgrTrainingParamBodyState();
}

class _MgrTrainingParamBodyState extends ConsumerState<_MgrTrainingParamBody> {
  String? _selectedLocaleKey;
  String? _loadedLocaleKey;
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
    _loadedLocaleKey = _selectedLocaleKey;
    _nameCtrl.text = loc?.name ?? '';
    _descCtrl.text = loc?.description ?? '';
    final fb = loc?.scoringFeedbacks ?? const <String>[];
    for (var i = 0; i < _feedbackCtrls.length; i++) {
      _feedbackCtrls[i].text = i < fb.length ? fb[i] : '';
    }
  }

  Future<void> _save() async {
    if (_selectedLocaleKey == null) return;
    setState(() => _saving = true);
    try {
      final loc = TrainingParameterLocalization(
        id: _current?.id,
        parameterId: widget.parameterId,
        localeKey: _selectedLocaleKey!,
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        scoringFeedbacks:
            _feedbackCtrls.map((c) => c.text.trim()).toList(),
      );
      final saved = await ref
          .read(clientProvider)
          .manager
          .upsertManagedTrainingParameterLocalization(
              widget.orgId, widget.parameterId, loc);
      _current = saved;
      ref.invalidate(managerTrainingParameterLocalizationsProvider(
          (widget.orgId, widget.parameterId)));
      if (mounted) _snackOk('Saved $_selectedLocaleKey');
    } catch (e) {
      if (mounted) _snackError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    if (_current?.id == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .manager
          .deleteManagedTrainingParameterLocalization(
              widget.orgId, _current!.id!);
      ref.invalidate(managerTrainingParameterLocalizationsProvider(
          (widget.orgId, widget.parameterId)));
      setState(() => _loadInto(null));
      if (mounted) _snackOk('Deleted $_selectedLocaleKey');
    } catch (e) {
      if (mounted) _snackError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snackOk(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
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
        ref.watch(managerLocaleConfigsProvider(widget.orgId));
    final existingAsync = ref.watch(
        managerTrainingParameterLocalizationsProvider(
            (widget.orgId, widget.parameterId)));
    final cfgAsync = ref.watch(managerModuleConfigProvider);

    if (localesAsync.isLoading || existingAsync.isLoading) {
      return const AppSkeletonBox(height: 200);
    }
    final locales = localesAsync.value ?? [];
    final existing = existingAsync.value ?? [];
    final defaultKey = cfgAsync.value?.defaultLocaleKey ?? 'US-en';
    final nonDefault =
        locales.where((l) => l.localeKey != defaultKey).toList();
    if (locales.isEmpty || nonDefault.isEmpty) {
      return _Layout(
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
              'Add more locales to author region-specific variants here.',
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
    if (_loadedLocaleKey != _selectedLocaleKey) {
      _loadInto(existingByKey[_selectedLocaleKey]);
    }

    return _Layout(
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
      form: _paramForm(
        nameCtrl: _nameCtrl,
        descCtrl: _descCtrl,
        feedbackCtrls: _feedbackCtrls,
        feedbackCount: widget.feedbackCount,
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

Future<void> showManagerAssessmentParameterLocalizationsSheet({
  required BuildContext context,
  required int orgId,
  required int parameterId,
  required String parentLabel,
  required int feedbackCount,
}) {
  return _showLocalizationSheet(
    context: context,
    title: 'Localizations — $parentLabel',
    body: _MgrAssessmentParamBody(
      orgId: orgId,
      parameterId: parameterId,
      parentLabel: parentLabel,
      feedbackCount: feedbackCount,
    ),
  );
}

class _MgrAssessmentParamBody extends ConsumerStatefulWidget {
  const _MgrAssessmentParamBody({
    required this.orgId,
    required this.parameterId,
    required this.parentLabel,
    required this.feedbackCount,
  });
  final int orgId;
  final int parameterId;
  final String parentLabel;
  final int feedbackCount;

  @override
  ConsumerState<_MgrAssessmentParamBody> createState() =>
      _MgrAssessmentParamBodyState();
}

class _MgrAssessmentParamBodyState
    extends ConsumerState<_MgrAssessmentParamBody> {
  String? _selectedLocaleKey;
  String? _loadedLocaleKey;
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
    _loadedLocaleKey = _selectedLocaleKey;
    _nameCtrl.text = loc?.name ?? '';
    _descCtrl.text = loc?.description ?? '';
    final fb = loc?.scoringFeedbacks ?? const <String>[];
    for (var i = 0; i < _feedbackCtrls.length; i++) {
      _feedbackCtrls[i].text = i < fb.length ? fb[i] : '';
    }
  }

  Future<void> _save() async {
    if (_selectedLocaleKey == null) return;
    setState(() => _saving = true);
    try {
      final loc = AssessmentParameterLocalization(
        id: _current?.id,
        parameterId: widget.parameterId,
        localeKey: _selectedLocaleKey!,
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        scoringFeedbacks:
            _feedbackCtrls.map((c) => c.text.trim()).toList(),
      );
      final saved = await ref
          .read(clientProvider)
          .manager
          .upsertManagedAssessmentParameterLocalization(
              widget.orgId, widget.parameterId, loc);
      _current = saved;
      ref.invalidate(managerAssessmentParameterLocalizationsProvider(
          (widget.orgId, widget.parameterId)));
      if (mounted) _snackOk('Saved $_selectedLocaleKey');
    } catch (e) {
      if (mounted) _snackError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    if (_current?.id == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .manager
          .deleteManagedAssessmentParameterLocalization(
              widget.orgId, _current!.id!);
      ref.invalidate(managerAssessmentParameterLocalizationsProvider(
          (widget.orgId, widget.parameterId)));
      setState(() => _loadInto(null));
      if (mounted) _snackOk('Deleted $_selectedLocaleKey');
    } catch (e) {
      if (mounted) _snackError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snackOk(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
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
        ref.watch(managerLocaleConfigsProvider(widget.orgId));
    final existingAsync = ref.watch(
        managerAssessmentParameterLocalizationsProvider(
            (widget.orgId, widget.parameterId)));
    final cfgAsync = ref.watch(managerModuleConfigProvider);

    if (localesAsync.isLoading || existingAsync.isLoading) {
      return const AppSkeletonBox(height: 200);
    }
    final locales = localesAsync.value ?? [];
    final existing = existingAsync.value ?? [];
    final defaultKey = cfgAsync.value?.defaultLocaleKey ?? 'US-en';
    final nonDefault =
        locales.where((l) => l.localeKey != defaultKey).toList();
    if (locales.isEmpty || nonDefault.isEmpty) {
      return _Layout(
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
              'Add more locales to author region-specific variants here.',
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
    if (_loadedLocaleKey != _selectedLocaleKey) {
      _loadInto(existingByKey[_selectedLocaleKey]);
    }

    return _Layout(
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
      form: _paramForm(
        nameCtrl: _nameCtrl,
        descCtrl: _descCtrl,
        feedbackCtrls: _feedbackCtrls,
        feedbackCount: widget.feedbackCount,
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

Future<void> showManagerAssetLocalizationsSheet({
  required BuildContext context,
  required int orgId,
  required int assetId,
  required String parentLabel,
}) {
  return _showLocalizationSheet(
    context: context,
    title: 'Localizations — $parentLabel',
    body: _MgrAssetBody(
      orgId: orgId,
      assetId: assetId,
      parentLabel: parentLabel,
    ),
  );
}

class _MgrAssetBody extends ConsumerStatefulWidget {
  const _MgrAssetBody({
    required this.orgId,
    required this.assetId,
    required this.parentLabel,
  });
  final int orgId;
  final int assetId;
  final String parentLabel;

  @override
  ConsumerState<_MgrAssetBody> createState() => _MgrAssetBodyState();
}

class _MgrAssetBodyState extends ConsumerState<_MgrAssetBody> {
  String? _selectedLocaleKey;
  String? _loadedLocaleKey;
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
    _loadedLocaleKey = _selectedLocaleKey;
    _nameCtrl.text = loc?.name ?? '';
    _descCtrl.text = loc?.description ?? '';
    _urlCtrl.text = loc?.url ?? '';
  }

  Future<void> _save() async {
    if (_selectedLocaleKey == null) return;
    setState(() => _saving = true);
    try {
      final loc = AssetLocalization(
        id: _current?.id,
        assetId: widget.assetId,
        localeKey: _selectedLocaleKey!,
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty
            ? null
            : _descCtrl.text.trim(),
        url: _urlCtrl.text.trim(),
      );
      final saved = await ref
          .read(clientProvider)
          .manager
          .upsertManagedAssetLocalization(widget.orgId, widget.assetId, loc);
      _current = saved;
      ref.invalidate(
          managerAssetLocalizationsProvider((widget.orgId, widget.assetId)));
      if (mounted) _snackOk('Saved $_selectedLocaleKey');
    } catch (e) {
      if (mounted) _snackError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    if (_current?.id == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .manager
          .deleteManagedAssetLocalization(widget.orgId, _current!.id!);
      ref.invalidate(
          managerAssetLocalizationsProvider((widget.orgId, widget.assetId)));
      setState(() => _loadInto(null));
      if (mounted) _snackOk('Deleted $_selectedLocaleKey');
    } catch (e) {
      if (mounted) _snackError(e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snackOk(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
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
        ref.watch(managerLocaleConfigsProvider(widget.orgId));
    final existingAsync = ref.watch(
        managerAssetLocalizationsProvider((widget.orgId, widget.assetId)));
    final cfgAsync = ref.watch(managerModuleConfigProvider);

    if (localesAsync.isLoading || existingAsync.isLoading) {
      return const AppSkeletonBox(height: 200);
    }
    final locales = localesAsync.value ?? [];
    final existing = existingAsync.value ?? [];
    final defaultKey = cfgAsync.value?.defaultLocaleKey ?? 'US-en';
    final nonDefault =
        locales.where((l) => l.localeKey != defaultKey).toList();
    if (locales.isEmpty || nonDefault.isEmpty) {
      return _Layout(
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
              'Add more locales to author region-specific variants here.',
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
    if (_loadedLocaleKey != _selectedLocaleKey) {
      _loadInto(existingByKey[_selectedLocaleKey]);
    }

    return _Layout(
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
          _field('Name', _nameCtrl),
          const SizedBox(height: AppSpacing.md),
          _field('Description', _descCtrl, maxLines: 3),
          const SizedBox(height: AppSpacing.md),
          _field('URL', _urlCtrl),
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

// ── Shared helpers ─────────────────────────────────────────────────────────

Widget _field(String label, TextEditingController ctrl, {int maxLines = 1}) {
  return TextField(
    controller: ctrl,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget _paramForm({
  required TextEditingController nameCtrl,
  required TextEditingController descCtrl,
  required List<TextEditingController> feedbackCtrls,
  required int feedbackCount,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _field('Name', nameCtrl),
      const SizedBox(height: AppSpacing.md),
      _field('Description', descCtrl, maxLines: 3),
      if (feedbackCount > 0) ...[
        const SizedBox(height: AppSpacing.lg),
        Text('Scoring feedback', style: AppTextStyles.labelMd),
        const SizedBox(height: AppSpacing.sm),
        for (var i = 0; i < feedbackCount; i++) ...[
          TextField(
            controller: feedbackCtrls[i],
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Feedback #${i + 1}',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    ],
  );
}

class _Layout extends StatelessWidget {
  const _Layout({
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
                  child: Text(title, style: AppTextStyles.headingMd)),
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
