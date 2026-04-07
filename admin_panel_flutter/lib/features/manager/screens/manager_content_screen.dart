import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/manager_providers.dart';
import '../../../src/providers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class ManagerContentScreen extends ConsumerStatefulWidget {
  const ManagerContentScreen({super.key});

  @override
  ConsumerState<ManagerContentScreen> createState() =>
      _ManagerContentScreenState();
}

class _ManagerContentScreenState extends ConsumerState<ManagerContentScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orgsAsync   = ref.watch(managedOrganizationsProvider);
    final activeOrgId = ref.watch(activeOrgIdProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ───────────────────────────────────────────────────────
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
              Text('Content', style: AppTextStyles.headingLg),
              const SizedBox(height: 4),
              Text(
                'Manage theory chapters, training and assessment parameters.',
                style: AppTextStyles.bodySm,
              ),
            ],
          ),
        ),

        // ── Org selector strip (multi-org) ───────────────────────────────
        orgsAsync.when(
          data: (orgs) {
            if (orgs.length <= 1) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pagePadding, 0,
                  AppSpacing.pagePadding, AppSpacing.md),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: orgs.map((org) {
                    final isActive = org.id == activeOrgId;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: _OrgChip(
                        org:      org,
                        isActive: isActive,
                        onTap: () => ref
                            .read(selectedOrgIdProvider.notifier)
                            .state = org.id,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error:   (_, __) => const SizedBox.shrink(),
        ),

        // ── Tab bar ──────────────────────────────────────────────────────
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.divider)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding),
            child: TabBar(
              controller:   _tab,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: const [
                Tab(
                  child: _TabLabel(
                    icon:  Icons.menu_book_rounded,
                    label: 'Theory',
                    color: AppColors.theory,
                  ),
                ),
                Tab(
                  child: _TabLabel(
                    icon:  Icons.fitness_center_rounded,
                    label: 'Training',
                    color: AppColors.training,
                  ),
                ),
                Tab(
                  child: _TabLabel(
                    icon:  Icons.quiz_rounded,
                    label: 'Assessment',
                    color: AppColors.assess,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Tab views ─────────────────────────────────────────────────────
        Expanded(
          child: TabBarView(
            controller: _tab,
            children: const [
              _TheoryTab(),
              _TrainingTab(),
              _AssessmentTab(),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Colored tab label ─────────────────────────────────────────────────────────

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String   label;
  final Color    color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Theory Tab
// ─────────────────────────────────────────────────────────────────────────────

class _TheoryTab extends ConsumerWidget {
  const _TheoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chaptersAsync = ref.watch(managerTheoryProvider);
    final chapters      = chaptersAsync.value ?? [];

    return _TabShell(
      title:     'Theory Chapters',
      count:     chaptersAsync.value?.length,
      isLoading: chaptersAsync.isLoading,
      onAdd:     () => _showDialog(context, ref, null),
      child: AppDataTable<TheoryChapter>(
        isLoading:  chaptersAsync.isLoading,
        rows:       chapters,
        searchable: true,
        mobileCardBuilder: (c) => _TheoryMobileCard(
          chapter: c,
          onEdit:  () => _showDialog(context, ref, c),
          onDelete: () => _confirmDelete(context, ref, c),
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
                Text(c.title,
                    style:    AppTextStyles.labelLg,
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
                ? const AppStatusChip(
                    label:   'Has video',
                    variant: AppChipVariant.success,
                  )
                : const AppStatusChip(
                    label:   'No video',
                    variant: AppChipVariant.neutral,
                    dot:     false,
                  ),
          ),
          AppTableColumn(
            label:     'Actions',
            flex:      1,
            alignment: Alignment.center,
            cellBuilder: (c) => _RowActions(
              onEdit:   () => _showDialog(context, ref, c),
              onDelete: () => _confirmDelete(context, ref, c),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(
      BuildContext context, WidgetRef ref, TheoryChapter? existing) {
    showDialog(
      context: context,
      builder: (_) => _ChapterDialog(existing: existing),
    );
  }

  Future<void> _confirmDelete(
      BuildContext ctx, WidgetRef ref, TheoryChapter c) async {
    final ok = await _showDeleteDialog(ctx, c.title);
    if (!ok) return;
    await ref.read(clientProvider).manager.deleteTheoryChapter(c.id!);
    ref.invalidate(managerTheoryProvider);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Training Tab
// ─────────────────────────────────────────────────────────────────────────────

class _TrainingTab extends ConsumerWidget {
  const _TrainingTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paramsAsync = ref.watch(managerTrainingProvider);
    final params      = paramsAsync.value ?? [];

    return _TabShell(
      title:     'Training Parameters',
      count:     paramsAsync.value?.length,
      isLoading: paramsAsync.isLoading,
      onAdd:     () => _showDialog(context, ref, null),
      child: AppDataTable<TrainingParameter>(
        isLoading:  paramsAsync.isLoading,
        rows:       params,
        searchable: true,
        mobileCardBuilder: (p) => _ParamMobileCard(
          name:     p.name,
          subtitle: p.paramId,
          maxScore: p.maxScore,
          onEdit:   () => _showDialog(context, ref, p),
          onDelete: () => _confirmDelete(context, ref, p),
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
                Text(p.name,
                    style:    AppTextStyles.labelLg,
                    overflow: TextOverflow.ellipsis),
                Text(p.paramId, style: AppTextStyles.bodyXs),
              ],
            ),
          ),
          AppTableColumn(
            label:      'Max Score',
            flex:        1,
            alignment:   Alignment.center,
            sortKey:     'score',
            comparator:  (a, b) => a.maxScore.compareTo(b.maxScore),
            cellBuilder: (p) => _ScoreBadge(score: p.maxScore),
          ),
          AppTableColumn(
            label:     'Actions',
            flex:      1,
            alignment: Alignment.center,
            cellBuilder: (p) => _RowActions(
              onEdit:   () => _showDialog(context, ref, p),
              onDelete: () => _confirmDelete(context, ref, p),
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
      builder: (_) => _ParamDialog<TrainingParameter>(
        existing:   existing,
        isTraining: true,
        onSave: (param) async {
          await ref.read(clientProvider).manager.upsertTrainingParameter(
                ref.read(activeOrgIdProvider) ?? 0,
                param as TrainingParameter);
          ref.invalidate(managerTrainingProvider);
        },
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext ctx, WidgetRef ref, TrainingParameter p) async {
    final ok = await _showDeleteDialog(ctx, p.name);
    if (!ok) return;
    await ref.read(clientProvider).manager.deleteTrainingParameter(p.id!);
    ref.invalidate(managerTrainingProvider);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Assessment Tab
// ─────────────────────────────────────────────────────────────────────────────

class _AssessmentTab extends ConsumerWidget {
  const _AssessmentTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paramsAsync = ref.watch(managerAssessmentProvider);
    final params      = paramsAsync.value ?? [];

    return _TabShell(
      title:     'Assessment Parameters',
      count:     paramsAsync.value?.length,
      isLoading: paramsAsync.isLoading,
      onAdd:     () => _showDialog(context, ref, null),
      child: AppDataTable<AssessmentParameter>(
        isLoading:  paramsAsync.isLoading,
        rows:       params,
        searchable: true,
        mobileCardBuilder: (p) => _ParamMobileCard(
          name:     p.name,
          subtitle: p.description,
          maxScore: p.maxScore,
          onEdit:   () => _showDialog(context, ref, p),
          onDelete: () => _confirmDelete(context, ref, p),
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
                Text(p.name,
                    style:    AppTextStyles.labelLg,
                    overflow: TextOverflow.ellipsis),
                Text(p.description,
                    style:    AppTextStyles.bodyXs,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          AppTableColumn(
            label:      'Max Score',
            flex:        1,
            alignment:   Alignment.center,
            sortKey:     'score',
            comparator:  (a, b) => a.maxScore.compareTo(b.maxScore),
            cellBuilder: (p) => _ScoreBadge(score: p.maxScore),
          ),
          AppTableColumn(
            label:     'Actions',
            flex:      1,
            alignment: Alignment.center,
            cellBuilder: (p) => _RowActions(
              onEdit:   () => _showDialog(context, ref, p),
              onDelete: () => _confirmDelete(context, ref, p),
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
      builder: (_) => _ParamDialog(
        existing:   existing,
        isTraining: false,
        onSave: (param) async {
          await ref.read(clientProvider).manager.upsertAssessmentParameter(
                ref.read(activeOrgIdProvider) ?? 0,
                param as AssessmentParameter);
          ref.invalidate(managerAssessmentProvider);
        },
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext ctx, WidgetRef ref, AssessmentParameter p) async {
    final ok = await _showDeleteDialog(ctx, p.name);
    if (!ok) return;
    await ref.read(clientProvider).manager.deleteAssessmentParameter(p.id!);
    ref.invalidate(managerAssessmentProvider);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Chapter Dialog
// ─────────────────────────────────────────────────────────────────────────────

class _QuizEntry {
  _QuizEntry({String question = '', List<String>? answers, int correct = 0})
      : questionCtrl = TextEditingController(text: question),
        answerCtrls  = List.generate(
            4,
            (i) => TextEditingController(
                text: answers != null && i < answers.length
                    ? answers[i]
                    : '')),
        correctIndex = correct;

  final TextEditingController       questionCtrl;
  final List<TextEditingController> answerCtrls;
  int                               correctIndex;

  void dispose() {
    questionCtrl.dispose();
    for (final c in answerCtrls) {
      c.dispose();
    }
  }
}

class _ChapterDialog extends ConsumerStatefulWidget {
  const _ChapterDialog({this.existing});
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

  @override
  void initState() {
    super.initState();
    final e        = widget.existing;
    _titleCtrl     = TextEditingController(text: e?.title ?? '');
    _thumbCtrl     = TextEditingController(text: e?.thumbnailUrl ?? '');
    _videoCtrl     = TextEditingController(text: e?.videoUrl ?? '');
    _orderCtrl     = TextEditingController(text: '${e?.chapterOrder ?? 1}');
    _durationCtrl  = TextEditingController(
        text: e?.videoMetadata != null
            ? '${e!.videoMetadata!.duration}'
            : '');
    _videoDescCtrl = TextEditingController(
        text: e?.videoMetadata?.description ?? '');
    _questions = (e?.questions ?? [])
        .map((q) => _QuizEntry(
              question: q.question,
              answers:  q.answers,
              correct:  q.correctAnswer,
            ))
        .toList();
  }

  @override
  void dispose() {
    for (final c in [
      _titleCtrl, _thumbCtrl, _videoCtrl, _orderCtrl,
      _durationCtrl, _videoDescCtrl,
    ]) {
      c.dispose();
    }
    for (final q in _questions) {
      q.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);
    final dur = int.tryParse(_durationCtrl.text.trim());
    final chapter = TheoryChapter(
      id:           widget.existing?.id,
      chapterOrder: int.tryParse(_orderCtrl.text) ?? 1,
      title:        _titleCtrl.text.trim(),
      thumbnailUrl: _thumbCtrl.text.trim().isEmpty
          ? null
          : _thumbCtrl.text.trim(),
      videoUrl: _videoCtrl.text.trim().isEmpty
          ? null
          : _videoCtrl.text.trim(),
      videoMetadata:
          _videoCtrl.text.trim().isNotEmpty && dur != null
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
                    answers: q.answerCtrls.map((c) => c.text.trim()).toList(),
                    correctAnswer: q.correctIndex,
                  ))
              .toList(),
    );
    try {
      await ref.read(clientProvider).manager.upsertTheoryChapter(
            ref.read(activeOrgIdProvider) ?? 0, chapter);
      ref.invalidate(managerTheoryProvider);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:         Text('Error: $e'),
              backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _StyledDialog(
      title:     widget.existing == null ? 'Add Chapter' : 'Edit Chapter',
      isLoading: _saving,
      onSave:    _save,
      saveLabel: 'Save Chapter',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DialogSection(title: 'Chapter Details'),
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
                  controller:   _orderCtrl,
                  keyboardType: TextInputType.number,
                  decoration:   const InputDecoration(labelText: 'Order'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _thumbCtrl,
            decoration: const InputDecoration(
              labelText:  'Thumbnail URL',
              prefixIcon: Icon(Icons.image_rounded, size: 18),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _DialogSection(title: 'Video'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _videoCtrl,
            decoration: const InputDecoration(
              labelText:  'Video URL',
              prefixIcon: Icon(Icons.play_circle_outline_rounded, size: 18),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              SizedBox(
                width: 140,
                child: TextField(
                  controller:   _durationCtrl,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Duration (s)'),
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
              const _DialogSection(title: 'Quiz Questions'),
              const Spacer(),
              TextButton.icon(
                icon:     const Icon(Icons.add_rounded, size: 16),
                label:    const Text('Add Question'),
                onPressed: () =>
                    setState(() => _questions.add(_QuizEntry())),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (_questions.isEmpty)
            _EmptySlot(
              icon:    Icons.quiz_outlined,
              message: 'No quiz questions added yet.',
            )
          else
            ...List.generate(_questions.length, (i) {
              final q = _questions[i];
              return _QuestionCard(
                index:    i,
                entry:    q,
                onDelete: () {
                  q.dispose();
                  setState(() => _questions.removeAt(i));
                },
                onChanged: () => setState(() {}),
              );
            }),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.index,
    required this.entry,
    required this.onDelete,
    required this.onChanged,
  });

  final int          index;
  final _QuizEntry   entry;
  final VoidCallback onDelete;
  final VoidCallback onChanged;

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
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
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
            controller: entry.questionCtrl,
            maxLines:   2,
            decoration: const InputDecoration(
                labelText: 'Question *', isDense: true),
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
                    value:      ai,
                    groupValue: entry.correctIndex,
                    onChanged: (v) {
                      entry.correctIndex = v!;
                      onChanged();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: entry.answerCtrls[ai],
                      decoration: InputDecoration(
                        labelText: 'Option ${ai + 1}${isCorrect ? ' ✓' : ''}',
                        isDense:   true,
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
// Shared Parameter Dialog (Training + Assessment)
// ─────────────────────────────────────────────────────────────────────────────

class _ParamDialog<T> extends ConsumerStatefulWidget {
  const _ParamDialog({
    required this.existing,
    required this.isTraining,
    required this.onSave,
  });

  final T?                        existing;
  final bool                      isTraining;
  final Future<void> Function(dynamic) onSave;

  @override
  ConsumerState<_ParamDialog<T>> createState() => _ParamDialogState<T>();
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

class _ParamDialogState<T> extends ConsumerState<_ParamDialog<T>> {
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
        id:           tp?.id,
        paramId:      _idCtrl.text.trim(),
        name:         _nameCtrl.text.trim(),
        description:  _descCtrl.text.trim(),
        maxScore:     int.tryParse(_maxCtrl.text.trim()) ?? 5,
        scoringRules: rules,
      );
    } else {
      final ap = widget.existing as AssessmentParameter?;
      param = AssessmentParameter(
        id:           ap?.id,
        paramId:      _idCtrl.text.trim(),
        name:         _nameCtrl.text.trim(),
        description:  _descCtrl.text.trim(),
        maxScore:     int.tryParse(_maxCtrl.text.trim()) ?? 5,
        scoringRules: rules,
      );
    }
    try {
      await widget.onSave(param);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:         Text('Error: $e'),
              backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _StyledDialog(
      title: widget.existing == null
          ? 'Add ${widget.isTraining ? 'Training' : 'Assessment'} Parameter'
          : 'Edit Parameter',
      isLoading: _saving,
      onSave:    _save,
      saveLabel: 'Save',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DialogSection(title: 'Parameter Details'),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _idCtrl,
                  decoration: const InputDecoration(labelText: 'Parameter ID *'),
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
              decoration: const InputDecoration(labelText: 'Name *')),
          const SizedBox(height: AppSpacing.md),
          TextField(
              controller: _descCtrl,
              maxLines:   2,
              decoration: const InputDecoration(labelText: 'Description')),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              const _DialogSection(title: 'Scoring Rules'),
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
            _EmptySlot(
              icon:    Icons.rule_rounded,
              message: 'No scoring rules added yet.',
            )
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color:        AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
                ),
                child: Text(
                  'Rule ${index + 1}',
                  style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
                ),
              ),
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
// Shared layout helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Tab content shell — table card with header row (title + count + Add button).
class _TabShell extends StatelessWidget {
  const _TabShell({
    required this.title,
    required this.onAdd,
    required this.child,
    required this.isLoading,
    this.count,
  });

  final String       title;
  final VoidCallback onAdd;
  final Widget       child;
  final bool         isLoading;
  final int?         count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.pagePadding, AppSpacing.md,
          AppSpacing.pagePadding, AppSpacing.md),
      child: Container(
        decoration: BoxDecoration(
          color:        AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border:       Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.md,
                  AppSpacing.md, AppSpacing.sm),
              child: Row(
                children: [
                  Text(title, style: AppTextStyles.headingSm),
                  const Spacer(),
                  if (!isLoading && count != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(right: AppSpacing.md),
                      child: Text(
                        '$count total',
                        style: AppTextStyles.bodyXs,
                      ),
                    ),
                  AppGradientButton(
                    label:     'Add',
                    icon:      Icons.add_rounded,
                    onPressed: onAdd,
                  ),
                ],
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

/// Styled modal dialog with scrollable body.
class _StyledDialog extends StatelessWidget {
  const _StyledDialog({
    required this.title,
    required this.child,
    required this.isLoading,
    required this.onSave,
    required this.saveLabel,
  });

  final String       title;
  final Widget       child;
  final bool         isLoading;
  final VoidCallback onSave;
  final String       saveLabel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceVariant,
      insetPadding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: 32),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl)),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: 640, maxHeight: 720),
        child: Column(
          children: [
            // Dialog header
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(24, 20, 12, 12),
              child: Row(
                children: [
                  Text(title, style: AppTextStyles.headingMd),
                  const Spacer(),
                  IconButton(
                    icon:      const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: child,
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
                    child:     const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  AppGradientButton(
                    label:     saveLabel,
                    isLoading: isLoading,
                    onPressed: onSave,
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

// ─────────────────────────────────────────────────────────────────────────────
// Row widgets
// ─────────────────────────────────────────────────────────────────────────────

/// Edit + Delete action buttons with hover states.
class _RowActions extends StatelessWidget {
  const _RowActions({required this.onEdit, required this.onDelete});
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HoverIconBtn(
          icon:    Icons.edit_rounded,
          tooltip: 'Edit',
          color:   AppColors.primary,
          onTap:   onEdit,
        ),
        const SizedBox(width: 4),
        _HoverIconBtn(
          icon:    Icons.delete_outline_rounded,
          tooltip: 'Delete',
          color:   AppColors.error,
          onTap:   onDelete,
        ),
      ],
    );
  }
}

class _HoverIconBtn extends StatefulWidget {
  const _HoverIconBtn({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  final IconData     icon;
  final String       tooltip;
  final Color        color;
  final VoidCallback onTap;

  @override
  State<_HoverIconBtn> createState() => _HoverIconBtnState();
}

class _HoverIconBtnState extends State<_HoverIconBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width:  30,
            height: 30,
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.color.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              widget.icon,
              size:  15,
              color: _hovered
                  ? widget.color
                  : AppColors.onSurfaceSubtle,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderBadge extends StatelessWidget {
  const _OrderBadge({required this.order});
  final int order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  30,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.theory.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Center(
        child: Text(
          '$order',
          style: const TextStyle(
            fontSize:   12,
            fontWeight: FontWeight.w700,
            color:      AppColors.theory,
          ),
        ),
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({required this.score});
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Text(
        '$score',
        style: AppTextStyles.labelMd
            .copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _EmptySlot extends StatelessWidget {
  const _EmptySlot({required this.icon, required this.message});
  final IconData icon;
  final String   message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:   double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        color:        AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: AppColors.onSurfaceSubtle),
          const SizedBox(height: 8),
          Text(message, style: AppTextStyles.bodyXs),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dialog section header
// ─────────────────────────────────────────────────────────────────────────────

class _DialogSection extends StatelessWidget {
  const _DialogSection({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.labelMd),
        const SizedBox(height: 4),
        const Divider(height: 1),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Org chip for multi-org selector
// ─────────────────────────────────────────────────────────────────────────────

class _OrgChip extends StatelessWidget {
  const _OrgChip({
    required this.org,
    required this.isActive,
    required this.onTap,
  });

  final Organization org;
  final bool         isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final initial = (org.name.isNotEmpty ? org.name[0] : '?').toUpperCase();

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color:        isActive ? null : AppColors.surfaceVariant,
          gradient:     isActive ? AppColors.brandGradient : null,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.0)
                : AppColors.divider,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width:  28,
              height: 28,
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white.withValues(alpha: 0.25)
                    : AppColors.primary.withValues(alpha: 0.12),
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Center(
                child: Text(
                  initial,
                  style: AppTextStyles.labelMd.copyWith(
                    color:      isActive ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              org.name,
              style: AppTextStyles.labelMd.copyWith(
                color: isActive ? Colors.white : AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Delete confirmation helper
// ─────────────────────────────────────────────────────────────────────────────

Future<bool> _showDeleteDialog(BuildContext context, String name) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
      title:   Text('Delete', style: AppTextStyles.headingSm),
      content: Text(
        'Delete "$name"? This cannot be undone.',
        style: AppTextStyles.bodySm,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child:     const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: TextButton.styleFrom(foregroundColor: AppColors.error),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  return result == true;
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

  final String       name;
  final String       subtitle;
  final int          maxScore;
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
          _ScoreBadge(score: maxScore),
          const SizedBox(width: 4),
          MobileCardActions(onEdit: onEdit, onDelete: onDelete),
        ],
      ),
    );
  }
}
