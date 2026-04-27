import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/admin_providers.dart';
import '../../../src/providers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class AdminContentScreen extends ConsumerStatefulWidget {
  const AdminContentScreen({super.key});

  @override
  ConsumerState<AdminContentScreen> createState() =>
      _AdminContentScreenState();
}

class _AdminContentScreenState extends ConsumerState<AdminContentScreen>
    with SingleTickerProviderStateMixin {
  Organization? _selectedOrg;
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orgsAsync = ref.watch(parentOrgsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header + org picker ─────────────────────────────────────────
        Padding(
          padding: EdgeInsets.fromLTRB(
            context.responsivePagePadding,
            context.responsivePagePadding,
            context.responsivePagePadding,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Content Management', style: AppTextStyles.headingLg),
              const SizedBox(height: 4),
              Text(
                'Manage theory, training, assessments and assets per organization.',
                style: AppTextStyles.bodySm,
              ),
              const SizedBox(height: AppSpacing.lg),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: orgsAsync.when(
                  data: (orgs) => DropdownButtonFormField<Organization>(
                    value:      _selectedOrg,
                    decoration: const InputDecoration(labelText: 'Organization'),
                    hint:       const Text('Select an organization'),
                    items: orgs
                        .map((o) => DropdownMenuItem(
                              value: o,
                              child: Text(o.name),
                            ))
                        .toList(),
                    onChanged: (org) => setState(() => _selectedOrg = org),
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error:   (e, _) => Text('Error: $e',
                      style: AppTextStyles.bodySm
                          .copyWith(color: AppColors.error)),
                ),
              ),
            ],
          ),
        ),

        // ── Tab bar ─────────────────────────────────────────────────────
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.divider)),
          ),
          child: TabBar(
            controller:   _tab,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Theory'),
              Tab(text: 'Training'),
              Tab(text: 'Assessment'),
              Tab(text: 'Assets'),
            ],
          ),
        ),

        // ── Tab views ───────────────────────────────────────────────────
        Expanded(
          child: _selectedOrg == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.corporate_fare_outlined,
                          size: 40, color: AppColors.onSurfaceSubtle),
                      const SizedBox(height: 12),
                      Text('Select an organization to manage content.',
                          style: AppTextStyles.bodySm),
                    ],
                  ),
                )
              : TabBarView(
                  controller: _tab,
                  children: [
                    _TheoryTab(org: _selectedOrg!),
                    _TrainingTab(org: _selectedOrg!),
                    _AssessmentTab(org: _selectedOrg!),
                    _AssetsTab(org: _selectedOrg!),
                  ],
                ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Theory Tab
// ─────────────────────────────────────────────────────────────────────────────

class _TheoryTab extends ConsumerWidget {
  const _TheoryTab({required this.org});
  final Organization org;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chaptersAsync = ref.watch(adminTheoryProvider(org.id!));

    return _ContentTabShell(
      title:     'Theory Chapters',
      onAdd:     () => _showDialog(context, ref, null),
      isLoading: chaptersAsync.isLoading,
      error:     chaptersAsync.error?.toString(),
      child: AppDataTable<TheoryChapter>(
        isLoading:  chaptersAsync.isLoading,
        rows:       chaptersAsync.value ?? [],
        searchable: true,
        mobileCardBuilder: (c) => _TheoryMobileCard(
          chapter: c,
          onEdit:  () => _showDialog(context, ref, c),
          onDelete: () async {
            await ref.read(clientProvider).admin.deleteTheoryChapter(c.id!);
            ref.invalidate(adminTheoryProvider(org.id!));
          },
        ),
        columns: [
          AppTableColumn(
            label:       'Order',
            flex:        1,
            alignment:   Alignment.center,
            sortKey:     'order',
            comparator:  (a, b) => a.chapterOrder.compareTo(b.chapterOrder),
            cellBuilder: (c) => _OrderBadge(order: c.chapterOrder),
          ),
          AppTableColumn(
            label:       'Title',
            flex:        4,
            sortKey:     'title',
            comparator:  (a, b) => a.title.compareTo(b.title),
            searchValue: (c) => c.title,
            cellBuilder: (c) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(c.title, style: AppTextStyles.labelLg,
                    overflow: TextOverflow.ellipsis),
                if (c.questions != null && c.questions!.isNotEmpty)
                  Text('${c.questions!.length} quiz question(s)',
                      style: AppTextStyles.bodyXs),
              ],
            ),
          ),
          AppTableColumn(
            label:       'Video',
            flex:        2,
            cellBuilder: (c) => c.videoUrl != null
                ? const AppStatusChip(label: 'Has video', variant: AppChipVariant.success)
                : const AppStatusChip(label: 'No video',  variant: AppChipVariant.neutral),
          ),
          AppTableColumn(
            label:       'Actions',
            flex:        1,
            alignment:   Alignment.center,
            cellBuilder: (c) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ActionBtn(
                  icon:    Icons.edit_rounded,
                  tooltip: 'Edit',
                  onTap:   () => _showDialog(context, ref, c),
                ),
                _ActionBtn(
                  icon:    Icons.delete_outline_rounded,
                  tooltip: 'Delete',
                  color:   AppColors.error,
                  onTap: () async {
                    await ref
                        .read(clientProvider)
                        .admin
                        .deleteTheoryChapter(c.id!);
                    ref.invalidate(adminTheoryProvider(org.id!));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, WidgetRef ref, TheoryChapter? existing) {
    showDialog(
      context: context,
      builder: (_) => _ChapterDialog(org: org, existing: existing),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Theory Chapter Dialog
// ─────────────────────────────────────────────────────────────────────────────

class _LocalizedContent {
  _LocalizedContent({String question = '', List<String>? answers})
      : questionCtrl = TextEditingController(text: question),
        answerCtrls  = List.generate(
          4,
          (i) => TextEditingController(
              text: answers != null && i < answers.length ? answers[i] : ''),
        );

  final TextEditingController       questionCtrl;
  final List<TextEditingController> answerCtrls;

  void dispose() {
    questionCtrl.dispose();
    for (final c in answerCtrls) { c.dispose(); }
  }
}

class _QuizEntry {
  _QuizEntry({
    String question = '',
    List<String>? answers,
    int correct = 0,
    List<LocalizedQuizContent>? translations,
  })  : questionCtrl = TextEditingController(text: question),
        answerCtrls  = List.generate(
          4,
          (i) => TextEditingController(
              text: answers != null && i < answers.length ? answers[i] : ''),
        ),
        correctIndex = correct,
        translationMap = {
          for (final t in translations ?? [])
            t.languageCode: _LocalizedContent(
              question: t.question,
              answers:  t.answers,
            ),
        };

  final TextEditingController           questionCtrl;
  final List<TextEditingController>     answerCtrls;
  int                                    correctIndex;
  final Map<String, _LocalizedContent>  translationMap;

  _LocalizedContent getTranslation(String langCode) {
    return translationMap.putIfAbsent(langCode, () => _LocalizedContent());
  }

  void dispose() {
    questionCtrl.dispose();
    for (final c in answerCtrls) { c.dispose(); }
    for (final t in translationMap.values) { t.dispose(); }
  }
}

class _ChapterDialog extends ConsumerStatefulWidget {
  const _ChapterDialog({required this.org, this.existing});
  final Organization  org;
  final TheoryChapter? existing;

  @override
  ConsumerState<_ChapterDialog> createState() => _ChapterDialogState();
}

class _ChapterDialogState extends ConsumerState<_ChapterDialog> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _thumbCtrl;
  late final TextEditingController _videoCtrl;
  late final TextEditingController _orderCtrl;
  late final TextEditingController _durationCtrl;
  late final TextEditingController _videoDescCtrl;
  late List<_QuizEntry>            _questions;
  bool                             _saving = false;
  String                           _selectedLang = '';

  @override
  void initState() {
    super.initState();
    final e      = widget.existing;
    _titleCtrl    = TextEditingController(text: e?.title ?? '');
    _thumbCtrl    = TextEditingController(text: e?.thumbnailUrl ?? '');
    _videoCtrl    = TextEditingController(text: e?.videoUrl ?? '');
    _orderCtrl    = TextEditingController(text: '${e?.chapterOrder ?? 1}');
    _durationCtrl = TextEditingController(
        text: e?.videoMetadata != null ? '${e!.videoMetadata!.duration}' : '');
    _videoDescCtrl = TextEditingController(
        text: e?.videoMetadata?.description ?? '');
    _questions = (e?.questions ?? [])
        .map((q) => _QuizEntry(
              question:     q.question,
              answers:      q.answers,
              correct:      q.correctAnswer,
              translations: q.translations,
            ))
        .toList();
  }

  @override
  void dispose() {
    for (final c in [
      _titleCtrl, _thumbCtrl, _videoCtrl, _orderCtrl,
      _durationCtrl, _videoDescCtrl,
    ]) { c.dispose(); }
    for (final q in _questions) { q.dispose(); }
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);
    final dur = int.tryParse(_durationCtrl.text.trim());
    final chapter = TheoryChapter(
      id:             widget.existing?.id,
      organizationId: widget.org.id,
      chapterOrder:   int.tryParse(_orderCtrl.text) ?? 1,
      title:          _titleCtrl.text.trim(),
      thumbnailUrl:   _thumbCtrl.text.trim().isEmpty
          ? null
          : _thumbCtrl.text.trim(),
      videoUrl: _videoCtrl.text.trim().isEmpty ? null : _videoCtrl.text.trim(),
      videoMetadata: _videoCtrl.text.trim().isNotEmpty && dur != null
          ? VideoMetadata(
              duration:    dur,
              description: _videoDescCtrl.text.trim().isEmpty
                  ? null
                  : _videoDescCtrl.text.trim(),
            )
          : null,
      questions: _questions.isEmpty
          ? null
          : _questions
              .map((q) => QuizQuestion(
                    question:      q.questionCtrl.text.trim(),
                    answers:       q.answerCtrls.map((c) => c.text.trim()).toList(),
                    correctAnswer: q.correctIndex,
                    translations:  q.translationMap.entries
                        .where((e) => e.value.questionCtrl.text.trim().isNotEmpty)
                        .map((e) => LocalizedQuizContent(
                              languageCode: e.key,
                              question:     e.value.questionCtrl.text.trim(),
                              answers:      e.value.answerCtrls
                                  .map((c) => c.text.trim())
                                  .toList(),
                            ))
                        .toList(),
                  ))
              .toList(),
    );
    try {
      await ref.read(clientProvider).admin.upsertTheoryChapter(chapter);
      ref.invalidate(adminTheoryProvider(widget.org.id!));
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceVariant,
      insetPadding:    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640, maxHeight: 720),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 12),
              child: Row(
                children: [
                  Text(
                    widget.existing == null ? 'Add Chapter' : 'Edit Chapter',
                    style: AppTextStyles.headingMd,
                  ),
                  const Spacer(),
                  IconButton(
                    icon:    const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SheetSection(title: 'Chapter Details'),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleCtrl,
                            decoration: const InputDecoration(labelText: 'Title *'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: _orderCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Order'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _thumbCtrl,
                      decoration: const InputDecoration(labelText: 'Thumbnail URL'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const SheetSection(title: 'Video'),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: _videoCtrl,
                      decoration: const InputDecoration(labelText: 'Video URL'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        SizedBox(
                          width: 140,
                          child: TextField(
                            controller: _durationCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Duration (s)'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: TextField(
                            controller: _videoDescCtrl,
                            decoration: const InputDecoration(labelText: 'Description'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        const SheetSection(title: 'Quiz Questions'),
                        const Spacer(),
                        TextButton.icon(
                          icon:  const Icon(Icons.add_rounded, size: 16),
                          label: const Text('Add Question'),
                          onPressed: () =>
                              setState(() => _questions.add(_QuizEntry())),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Builder(builder: (_) {
                      final config = ref.watch(moduleConfigProvider(widget.org.id!)).value;
                      final defaultLang = config?.defaultLanguage ?? 'en';
                      final orgLangs = config?.supportedLanguages ?? [];
                      final hasMultipleLangs = orgLangs.where((l) => l.code != defaultLang).isNotEmpty;
                      if (hasMultipleLangs && _questions.isNotEmpty)
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ChoiceChip(
                                  label: Text(defaultLang.toUpperCase()),
                                  selected: _selectedLang == '',
                                  onSelected: (_) => setState(() => _selectedLang = ''),
                                ),
                                const SizedBox(width: 8),
                                for (final lang in orgLangs)
                                  if (lang.code != defaultLang)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ChoiceChip(
                                        label: Text(lang.name.isNotEmpty ? lang.name : lang.code.toUpperCase()),
                                        selected: _selectedLang == lang.code,
                                        onSelected: (_) => setState(() => _selectedLang = lang.code),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        );
                      return const SizedBox.shrink();
                    }),
                    if (_questions.isEmpty)
                      Text('No quiz questions added yet.',
                          style: AppTextStyles.bodyXs)
                    else
                      ...List.generate(_questions.length, (i) {
                        final q = _questions[i];
                        return _QuestionCard(
                          index:          i,
                          entry:          q,
                          activeLangCode: _selectedLang,
                          onDelete: () {
                            q.dispose();
                            setState(() => _questions.removeAt(i));
                          },
                          onChanged: () => setState(() {}),
                        );
                      }),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  AppGradientButton(
                    label:     'Save Chapter',
                    isLoading: _saving,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.index,
    required this.entry,
    this.activeLangCode = '',
    required this.onDelete,
    required this.onChanged,
  });

  final int          index;
  final _QuizEntry   entry;
  final String       activeLangCode;
  final VoidCallback onDelete;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final isDefault = activeLangCode.isEmpty;
    final TextEditingController questionCtrl;
    final List<TextEditingController> answerCtrls;
    if (isDefault) {
      questionCtrl = entry.questionCtrl;
      answerCtrls  = entry.answerCtrls;
    } else {
      final t = entry.getTranslation(activeLangCode);
      questionCtrl = t.questionCtrl;
      answerCtrls  = t.answerCtrls;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color:        AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Q${index + 1}',
                  style: AppTextStyles.labelMd.copyWith(color: AppColors.primary)),
              if (!isDefault) ...[
                const SizedBox(width: 8),
                Text(activeLangCode.toUpperCase(),
                    style: AppTextStyles.bodyXs.copyWith(color: AppColors.onSurfaceMuted)),
              ],
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 18, color: AppColors.error),
                onPressed: onDelete,
                padding:     EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: questionCtrl,
            maxLines:   2,
            decoration: InputDecoration(
              labelText: isDefault ? 'Question *' : 'Question (${activeLangCode.toUpperCase()})',
              isDense: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Answer Options', style: AppTextStyles.labelSm),
          const SizedBox(height: 6),
          ...List.generate(4, (ai) {
            final isCorrect = entry.correctIndex == ai;
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Radio<int>(
                    value:     ai,
                    groupValue: entry.correctIndex,
                    onChanged: (v) {
                      entry.correctIndex = v!;
                      onChanged();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: answerCtrls[ai],
                      decoration: InputDecoration(
                        labelText:  'Option ${ai + 1}${isCorrect ? ' ✓' : ''}',
                        isDense:    true,
                        labelStyle: isCorrect
                            ? const TextStyle(color: AppColors.success)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Training Tab
// ─────────────────────────────────────────────────────────────────────────────

class _TrainingTab extends ConsumerWidget {
  const _TrainingTab({required this.org});
  final Organization org;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paramsAsync = ref.watch(adminTrainingProvider(org.id!));

    return _ContentTabShell(
      title:     'Training Parameters',
      onAdd:     () => _showDialog(context, ref, null),
      isLoading: paramsAsync.isLoading,
      error:     paramsAsync.error?.toString(),
      child: AppDataTable<TrainingParameter>(
        isLoading:  paramsAsync.isLoading,
        rows:       paramsAsync.value ?? [],
        searchable: true,
        mobileCardBuilder: (p) => _ParamMobileCard(
          name:     p.name,
          subtitle: p.paramId,
          maxScore: p.maxScore,
          onEdit:   () => _showDialog(context, ref, p),
          onDelete: () async {
            await ref.read(clientProvider).admin.deleteTrainingParameter(p.id!);
            ref.invalidate(adminTrainingProvider(org.id!));
          },
        ),
        columns: [
          AppTableColumn(
            label:       'Name',
            flex:        3,
            sortKey:     'name',
            comparator:  (a, b) => a.name.compareTo(b.name),
            searchValue: (p) => '${p.name} ${p.paramId} ${p.description}',
            cellBuilder: (p) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(p.name, style: AppTextStyles.labelLg,
                    overflow: TextOverflow.ellipsis),
                Text(p.paramId, style: AppTextStyles.bodyXs),
              ],
            ),
          ),
          AppTableColumn(
            label:       'Max Score',
            flex:        1,
            alignment:   Alignment.center,
            sortKey:     'score',
            comparator:  (a, b) => a.maxScore.compareTo(b.maxScore),
            cellBuilder: (p) => Text('${p.maxScore}', style: AppTextStyles.bodyMd),
          ),
          AppTableColumn(
            label:       'Actions',
            flex:        1,
            alignment:   Alignment.center,
            cellBuilder: (p) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ActionBtn(
                  icon:    Icons.edit_rounded,
                  tooltip: 'Edit',
                  onTap:   () => _showDialog(context, ref, p),
                ),
                _ActionBtn(
                  icon:    Icons.delete_outline_rounded,
                  tooltip: 'Delete',
                  color:   AppColors.error,
                  onTap: () async {
                    await ref
                        .read(clientProvider)
                        .admin
                        .deleteTrainingParameter(p.id!);
                    ref.invalidate(adminTrainingProvider(org.id!));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(
      BuildContext context, WidgetRef ref, TrainingParameter? existing) {
    showDialog(
      context: context,
      builder: (_) => _ParameterDialog<TrainingParameter>(
        org:      org,
        existing: existing,
        isTraining: true,
        onSave: (param) async {
          await ref.read(clientProvider).admin.upsertTrainingParameter(
              param as TrainingParameter);
          ref.invalidate(adminTrainingProvider(org.id!));
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Assessment Tab
// ─────────────────────────────────────────────────────────────────────────────

class _AssessmentTab extends ConsumerWidget {
  const _AssessmentTab({required this.org});
  final Organization org;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paramsAsync = ref.watch(adminAssessmentProvider(org.id!));

    return _ContentTabShell(
      title:     'Assessment Parameters',
      onAdd:     () => _showDialog(context, ref, null),
      isLoading: paramsAsync.isLoading,
      error:     paramsAsync.error?.toString(),
      child: AppDataTable<AssessmentParameter>(
        isLoading:  paramsAsync.isLoading,
        rows:       paramsAsync.value ?? [],
        searchable: true,
        mobileCardBuilder: (p) => _ParamMobileCard(
          name:     p.name,
          subtitle: p.description,
          maxScore: p.maxScore,
          onEdit:   () => _showDialog(context, ref, p),
          onDelete: () async {
            await ref.read(clientProvider).admin.deleteAssessmentParameter(p.id!);
            ref.invalidate(adminAssessmentProvider(org.id!));
          },
        ),
        columns: [
          AppTableColumn(
            label:       'Name',
            flex:        3,
            sortKey:     'name',
            comparator:  (a, b) => a.name.compareTo(b.name),
            searchValue: (p) => '${p.name} ${p.description}',
            cellBuilder: (p) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(p.name, style: AppTextStyles.labelLg,
                    overflow: TextOverflow.ellipsis),
                Text(p.description, style: AppTextStyles.bodyXs,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          AppTableColumn(
            label:       'Max Score',
            flex:        1,
            alignment:   Alignment.center,
            sortKey:     'score',
            comparator:  (a, b) => a.maxScore.compareTo(b.maxScore),
            cellBuilder: (p) => Text('${p.maxScore}', style: AppTextStyles.bodyMd),
          ),
          AppTableColumn(
            label:       'Actions',
            flex:        1,
            alignment:   Alignment.center,
            cellBuilder: (p) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ActionBtn(
                  icon:    Icons.edit_rounded,
                  tooltip: 'Edit',
                  onTap:   () => _showDialog(context, ref, p),
                ),
                _ActionBtn(
                  icon:    Icons.delete_outline_rounded,
                  tooltip: 'Delete',
                  color:   AppColors.error,
                  onTap: () async {
                    await ref
                        .read(clientProvider)
                        .admin
                        .deleteAssessmentParameter(p.id!);
                    ref.invalidate(adminAssessmentProvider(org.id!));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(
      BuildContext context, WidgetRef ref, AssessmentParameter? existing) {
    showDialog(
      context: context,
      builder: (_) => _ParameterDialog(
        org:        org,
        existing:   existing,
        isTraining: false,
        onSave: (param) async {
          await ref.read(clientProvider).admin.upsertAssessmentParameter(
              param as AssessmentParameter);
          ref.invalidate(adminAssessmentProvider(org.id!));
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared Parameter Dialog (Training + Assessment)
// ─────────────────────────────────────────────────────────────────────────────

class _ParameterDialog<T> extends ConsumerStatefulWidget {
  const _ParameterDialog({
    required this.org,
    required this.existing,
    required this.isTraining,
    required this.onSave,
  });

  final Organization org;
  final T?           existing;
  final bool         isTraining;
  final Future<void> Function(dynamic param) onSave;

  @override
  ConsumerState<_ParameterDialog<T>> createState() =>
      _ParameterDialogState<T>();
}

class _ScoringRuleEntry {
  _ScoringRuleEntry({int threshold = 0, int score = 0, String feedback = ''})
      : thresholdCtrl = TextEditingController(text: '$threshold'),
        scoreCtrl     = TextEditingController(text: '$score'),
        feedbackCtrl  = TextEditingController(text: feedback);

  final TextEditingController thresholdCtrl;
  final TextEditingController scoreCtrl;
  final TextEditingController feedbackCtrl;

  void dispose() {
    thresholdCtrl.dispose();
    scoreCtrl.dispose();
    feedbackCtrl.dispose();
  }
}

class _ParameterDialogState<T> extends ConsumerState<_ParameterDialog<T>> {
  late final TextEditingController _idCtrl;
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _maxCtrl;
  late List<_ScoringRuleEntry>     _rules;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final tp = widget.isTraining ? widget.existing as TrainingParameter? : null;
    final ap = !widget.isTraining ? widget.existing as AssessmentParameter? : null;

    _idCtrl   = TextEditingController(text: tp?.paramId     ?? ap?.paramId     ?? '');
    _nameCtrl = TextEditingController(text: tp?.name        ?? ap?.name        ?? '');
    _descCtrl = TextEditingController(text: tp?.description ?? ap?.description ?? '');
    _maxCtrl  = TextEditingController(text: '${tp?.maxScore ?? ap?.maxScore ?? 5}');

    final existingRules = tp?.scoringRules ?? ap?.scoringRules ?? [];
    _rules = existingRules
        .map((r) => _ScoringRuleEntry(
              threshold: r.threshold,
              score:     r.score,
              feedback:  r.feedback,
            ))
        .toList();
  }

  @override
  void dispose() {
    for (final c in [_idCtrl, _nameCtrl, _descCtrl, _maxCtrl]) { c.dispose(); }
    for (final r in _rules) { r.dispose(); }
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final rules = _rules
        .map((r) => ScoringRule(
              threshold: int.tryParse(r.thresholdCtrl.text.trim()) ?? 0,
              score:     int.tryParse(r.scoreCtrl.text.trim()) ?? 0,
              feedback:  r.feedbackCtrl.text.trim(),
            ))
        .toList();

    dynamic param;
    if (widget.isTraining) {
      final tp = widget.existing as TrainingParameter?;
      param = TrainingParameter(
        id:             tp?.id,
        organizationId: widget.org.id,
        paramId:        _idCtrl.text.trim(),
        name:           _nameCtrl.text.trim(),
        description:    _descCtrl.text.trim(),
        maxScore:       int.tryParse(_maxCtrl.text.trim()) ?? 5,
        scoringRules:   rules,
      );
    } else {
      final ap = widget.existing as AssessmentParameter?;
      param = AssessmentParameter(
        id:             ap?.id,
        organizationId: widget.org.id,
        paramId:        _idCtrl.text.trim(),
        name:           _nameCtrl.text.trim(),
        description:    _descCtrl.text.trim(),
        maxScore:       int.tryParse(_maxCtrl.text.trim()) ?? 5,
        scoringRules:   rules,
      );
    }

    try {
      await widget.onSave(param);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTraining = widget.isTraining;
    final title = widget.existing == null
        ? 'Add ${isTraining ? 'Training' : 'Assessment'} Parameter'
        : 'Edit Parameter';

    return Dialog(
      backgroundColor: AppColors.surfaceVariant,
      insetPadding:    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640, maxHeight: 720),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 12),
              child: Row(
                children: [
                  Text(title, style: AppTextStyles.headingMd),
                  const Spacer(),
                  IconButton(
                    icon:    const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SheetSection(title: 'Parameter Details'),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _idCtrl,
                            decoration: const InputDecoration(
                                labelText: 'Parameter ID *'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller:   _maxCtrl,
                            keyboardType: TextInputType.number,
                            decoration:   const InputDecoration(labelText: 'Max Score'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(labelText: 'Name *'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _descCtrl,
                      maxLines:   2,
                      decoration: const InputDecoration(labelText: 'Description'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        const SheetSection(title: 'Scoring Rules'),
                        const Spacer(),
                        TextButton.icon(
                          icon:     const Icon(Icons.add_rounded, size: 16),
                          label:    const Text('Add Rule'),
                          onPressed: () =>
                              setState(() => _rules.add(_ScoringRuleEntry())),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (_rules.isEmpty)
                      Text('No scoring rules added yet.',
                          style: AppTextStyles.bodyXs)
                    else
                      ...List.generate(_rules.length, (i) {
                        final r = _rules[i];
                        return _ScoringRuleCard(
                          index:   i,
                          entry:   r,
                          onDelete: () {
                            r.dispose();
                            setState(() => _rules.removeAt(i));
                          },
                        );
                      }),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  AppGradientButton(
                    label:     'Save',
                    isLoading: _saving,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoringRuleCard extends StatelessWidget {
  const _ScoringRuleCard({
    required this.index,
    required this.entry,
    required this.onDelete,
  });

  final int               index;
  final _ScoringRuleEntry entry;
  final VoidCallback      onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color:        AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Rule ${index + 1}',
                  style: AppTextStyles.labelMd.copyWith(color: AppColors.primary)),
              const Spacer(),
              IconButton(
                icon:        const Icon(Icons.delete_outline_rounded,
                    size: 18, color: AppColors.error),
                onPressed:   onDelete,
                padding:     EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: TextField(
                  controller:   entry.thresholdCtrl,
                  keyboardType: TextInputType.number,
                  decoration:   const InputDecoration(
                      labelText: 'Threshold', isDense: true),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              SizedBox(
                width: 80,
                child: TextField(
                  controller:   entry.scoreCtrl,
                  keyboardType: TextInputType.number,
                  decoration:   const InputDecoration(
                      labelText: 'Score', isDense: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: entry.feedbackCtrl,
            maxLines:   3,
            decoration: const InputDecoration(
                labelText: 'Feedback', isDense: true),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Assets Tab
// ─────────────────────────────────────────────────────────────────────────────

class _AssetsTab extends ConsumerWidget {
  const _AssetsTab({required this.org});
  final Organization org;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(adminAssetsProvider(org.id!));

    return _ContentTabShell(
      title:     'Assets',
      onAdd:     () => _showSheet(context, ref, null),
      isLoading: assetsAsync.isLoading,
      error:     assetsAsync.error?.toString(),
      child: AppDataTable<Asset>(
        isLoading:  assetsAsync.isLoading,
        rows:       assetsAsync.value ?? [],
        searchable: true,
        mobileCardBuilder: (a) => _AssetMobileCard(
          asset:   a,
          onEdit:  () => _showSheet(context, ref, a),
          onDelete: () async {
            await ref.read(clientProvider).admin.deleteAsset(a.id!);
            ref.invalidate(adminAssetsProvider(org.id!));
          },
        ),
        columns: [
          AppTableColumn(
            label:       'Name',
            flex:        3,
            sortKey:     'name',
            comparator:  (a, b) => a.name.compareTo(b.name),
            searchValue: (a) =>
                '${a.name} ${a.description ?? ''} ${a.module}',
            cellBuilder: (a) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(a.name, style: AppTextStyles.labelLg,
                    overflow: TextOverflow.ellipsis),
                if (a.description != null)
                  Text(a.description!, style: AppTextStyles.bodyXs,
                      overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          AppTableColumn(
            label:       'Version',
            flex:        1,
            sortKey:     'version',
            comparator:  (a, b) => a.version.compareTo(b.version),
            cellBuilder: (a) => Text('v${a.version}', style: AppTextStyles.bodyMd),
          ),
          AppTableColumn(
            label:       'Module',
            flex:        1,
            cellBuilder: (a) => _ModuleChip(module: a.module),
          ),
          AppTableColumn(
            label:       'Actions',
            flex:        1,
            alignment:   Alignment.center,
            cellBuilder: (a) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ActionBtn(
                  icon:    Icons.edit_rounded,
                  tooltip: 'Edit',
                  onTap:   () => _showSheet(context, ref, a),
                ),
                _ActionBtn(
                  icon:    Icons.delete_outline_rounded,
                  tooltip: 'Delete',
                  color:   AppColors.error,
                  onTap: () async {
                    await ref.read(clientProvider).admin.deleteAsset(a.id!);
                    ref.invalidate(adminAssetsProvider(org.id!));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSheet(BuildContext context, WidgetRef ref, Asset? existing) {
    final nameCtrl       = TextEditingController(text: existing?.name ?? '');
    final versionCtrl    = TextEditingController(text: existing?.version ?? '');
    final urlCtrl        = TextEditingController(text: existing?.url ?? '');
    final descCtrl       = TextEditingController(text: existing?.description ?? '');
    final moduleNotifier = ValueNotifier<String>(existing?.module ?? 'theory');

    AppSideSheet.show(
      context:   context,
      title:     existing == null ? 'Add Asset' : 'Edit Asset',
      saveLabel: existing == null ? 'Add' : 'Save',
      body: _AssetBody(
        nameCtrl:       nameCtrl,
        versionCtrl:    versionCtrl,
        urlCtrl:        urlCtrl,
        descCtrl:       descCtrl,
        moduleNotifier: moduleNotifier,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty ||
            versionCtrl.text.trim().isEmpty ||
            urlCtrl.text.trim().isEmpty) {
          throw Exception('Name, version and URL are required.');
        }
        final asset = Asset(
          id:             existing?.id,
          organizationId: existing?.organizationId ?? org.id,
          name:           nameCtrl.text.trim(),
          version:        versionCtrl.text.trim(),
          url:            urlCtrl.text.trim(),
          description:    descCtrl.text.trim().isEmpty
              ? null
              : descCtrl.text.trim(),
          module: moduleNotifier.value,
        );
        await ref.read(clientProvider).admin.upsertAsset(asset);
        ref.invalidate(adminAssetsProvider(org.id!));
      },
    );
  }
}

class _AssetBody extends StatefulWidget {
  const _AssetBody({
    required this.nameCtrl,
    required this.versionCtrl,
    required this.urlCtrl,
    required this.descCtrl,
    required this.moduleNotifier,
  });

  final TextEditingController nameCtrl;
  final TextEditingController versionCtrl;
  final TextEditingController urlCtrl;
  final TextEditingController descCtrl;
  final ValueNotifier<String> moduleNotifier;

  @override
  State<_AssetBody> createState() => _AssetBodyState();
}

class _AssetBodyState extends State<_AssetBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Asset Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(label: 'Name *',    controller: widget.nameCtrl,
            hint: 'e.g. Anatomy Model'),
        const SizedBox(height: AppSpacing.md),
        SheetField(label: 'Version *', controller: widget.versionCtrl,
            hint: 'e.g. 1.0.0'),
        const SizedBox(height: AppSpacing.md),
        SheetField(label: 'URL *',     controller: widget.urlCtrl,
            hint: 'https://cdn.example.com/asset.glb'),
        const SizedBox(height: AppSpacing.md),
        SheetField(label: 'Description', controller: widget.descCtrl,
            maxLines: 2),
        const SizedBox(height: AppSpacing.lg),
        const SheetSection(title: 'Module'),
        const SizedBox(height: AppSpacing.sm),
        ValueListenableBuilder<String>(
          valueListenable: widget.moduleNotifier,
          builder: (_, module, __) => DropdownButtonFormField<String>(
            value: module,
            decoration: const InputDecoration(labelText: 'Available in'),
            items: const [
              DropdownMenuItem(value: 'theory',     child: Text('Theory')),
              DropdownMenuItem(value: 'arExpert',   child: Text('AR Expert')),
              DropdownMenuItem(value: 'training',   child: Text('Training')),
              DropdownMenuItem(value: 'assessment', child: Text('Assessment')),
            ],
            onChanged: (v) => widget.moduleNotifier.value = v!,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

class _ContentTabShell extends StatelessWidget {
  const _ContentTabShell({
    required this.title,
    required this.onAdd,
    required this.child,
    this.isLoading = false,
    this.error,
  });

  final String        title;
  final VoidCallback  onAdd;
  final Widget        child;
  final bool          isLoading;
  final String?       error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pagePadding, AppSpacing.md,
            AppSpacing.pagePadding, AppSpacing.sm,
          ),
          child: Row(
            children: [
              Text(title, style: AppTextStyles.headingSm),
              const Spacer(),
              AppGradientButton(
                label:     'Add',
                icon:      Icons.add_rounded,
                onPressed: onAdd,
              ),
            ],
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding),
            child: Text('Error: $error',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
          ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding),
            child: Container(
              decoration: BoxDecoration(
                color:        AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border:       Border.all(color: AppColors.divider),
              ),
              child: child,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _OrderBadge extends StatelessWidget {
  const _OrderBadge({required this.order});
  final int order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  28,
      height: 28,
      decoration: BoxDecoration(
        color:        AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Center(
        child: Text('$order',
            style: const TextStyle(
              fontSize:   12,
              fontWeight: FontWeight.w700,
              color:      AppColors.primary,
            )),
      ),
    );
  }
}

class _ModuleChip extends StatelessWidget {
  const _ModuleChip({required this.module});
  final String module;

  @override
  Widget build(BuildContext context) {
    return AppStatusChip(
      label: switch (module) {
        'theory'     => 'Theory',
        'arExpert'   => 'AR Expert',
        'training'   => 'Training',
        'assessment' => 'Assessment',
        _            => module,
      },
      variant: switch (module) {
        'theory'     => AppChipVariant.primary,
        'arExpert'   => AppChipVariant.info,
        'training'   => AppChipVariant.success,
        'assessment' => AppChipVariant.warning,
        _            => AppChipVariant.neutral,
      },
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.color,
  });

  final IconData     icon;
  final String       tooltip;
  final VoidCallback onTap;
  final Color?       color;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 16,
              color: color ?? AppColors.onSurfaceMuted),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mobile card builders for content tables
// ─────────────────────────────────────────────────────────────────────────────

class _TheoryMobileCard extends StatelessWidget {
  const _TheoryMobileCard({
    required this.chapter,
    required this.onEdit,
    required this.onDelete,
  });

  final TheoryChapter chapter;
  final VoidCallback  onEdit;
  final VoidCallback  onDelete;

  @override
  Widget build(BuildContext context) {
    return MobileDataCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _OrderBadge(order: chapter.chapterOrder),
              const SizedBox(width: 10),
              Expanded(
                child: Text(chapter.title, style: AppTextStyles.labelLg,
                    overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              MobileCardActions(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              if (chapter.questions != null && chapter.questions!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Text('${chapter.questions!.length} quiz question(s)',
                      style: AppTextStyles.bodyXs),
                ),
              chapter.videoUrl != null
                  ? const AppStatusChip(
                      label: 'Has video', variant: AppChipVariant.success, small: true)
                  : const AppStatusChip(
                      label: 'No video', variant: AppChipVariant.neutral, small: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _ParamMobileCard extends StatelessWidget {
  const _ParamMobileCard({
    required this.name,
    required this.subtitle,
    required this.maxScore,
    required this.onEdit,
    required this.onDelete,
  });

  final String      name;
  final String      subtitle;
  final int         maxScore;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return MobileDataCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.labelLg,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodyXs,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text('$maxScore',
                style: AppTextStyles.labelSm.copyWith(color: AppColors.primary)),
          ),
          const SizedBox(width: 4),
          MobileCardActions(onEdit: onEdit, onDelete: onDelete),
        ],
      ),
    );
  }
}

class _AssetMobileCard extends StatelessWidget {
  const _AssetMobileCard({
    required this.asset,
    required this.onEdit,
    required this.onDelete,
  });

  final Asset        asset;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return MobileDataCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(asset.name, style: AppTextStyles.labelLg,
                        overflow: TextOverflow.ellipsis),
                    if (asset.description != null)
                      Text(asset.description!, style: AppTextStyles.bodyXs,
                          overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              MobileCardActions(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Text('v${asset.version}', style: AppTextStyles.bodyXs),
              const SizedBox(width: AppSpacing.sm),
              _ModuleChip(module: asset.module),
            ],
          ),
        ],
      ),
    );
  }
}
