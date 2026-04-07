import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme.dart';
import '../../../shared/widgets/responsive_helper.dart';
import '../providers/theory_providers.dart';
import 'theory_player_screen.dart';

class TheoryChaptersScreen extends ConsumerWidget {
  const TheoryChaptersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chaptersAsync = ref.watch(theoryChaptersProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Theory Modules', style: AppTextStyles.headingSm),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: chaptersAsync.when(
        data: (chapters) => _ChaptersGrid(chapters: chapters),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(
          child: Text('Error loading theory chapters: $e',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
        ),
      ),
    );
  }
}

class _ChaptersGrid extends StatelessWidget {
  const _ChaptersGrid({required this.chapters});

  final List<TheoryChapterWithProgress> chapters;

  @override
  Widget build(BuildContext context) {
    if (chapters.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.menu_book_rounded,
                  size: 48, color: AppColors.onSurfaceSubtle),
              const SizedBox(height: AppSpacing.md),
              Text('No theory chapters available',
                  style: AppTextStyles.headingSm),
              const SizedBox(height: 4),
              Text('Theory content has not been configured for your organization.',
                  style: AppTextStyles.bodySm, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final padding = context.responsivePagePadding;

        // Mobile: single-column list (no fixed aspect ratio → intrinsic height)
        if (w <= 600) {
          return ListView.separated(
            padding: EdgeInsets.all(padding),
            itemCount: chapters.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (_, i) => _ChapterCard(item: chapters[i]),
          );
        }

        // Tablet / Desktop: grid
        final crossAxisCount = w > 1200 ? 4 : (w > 800 ? 3 : 2);
        return GridView.builder(
          padding: EdgeInsets.all(padding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.85,
          ),
          itemCount: chapters.length,
          itemBuilder: (_, i) => _ChapterCard(item: chapters[i]),
        );
      },
    );
  }
}

class _ChapterCard extends StatelessWidget {
  const _ChapterCard({required this.item});

  final TheoryChapterWithProgress item;

  @override
  Widget build(BuildContext context) {
    final chapter = item.chapter;
    final progress = item.progress;
    final status = progress?.status ?? ModuleProgressStatus.notStarted;
    final score = progress?.score;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        side: BorderSide(color: AppColors.divider, width: 1),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TheoryPlayerScreen(chapter: chapter, progress: progress),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with status ribbon
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: chapter.thumbnailUrl != null
                      ? Image.network(chapter.thumbnailUrl!, fit: BoxFit.cover)
                      : Container(
                          color: AppColors.surfaceVariant,
                          child: const Icon(Icons.movie_rounded, size: 48, color: AppColors.onSurfaceSubtle),
                        ),
                ),
                if (status == ModuleProgressStatus.completed)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, size: 12, color: Colors.white),
                          const SizedBox(width: 4),
                          Text('Completed', style: AppTextStyles.labelXs.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            
            // Body
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.title,
                    style: AppTextStyles.headingSm,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.quiz_rounded, size: 14, color: AppColors.onSurfaceMuted),
                      const SizedBox(width: 4),
                      Text('${chapter.questions?.length ?? 0} Questions', style: AppTextStyles.bodyXs),
                      const Spacer(),
                      if (score != null)
                        Text('$score%', style: AppTextStyles.labelSm.copyWith(
                          color: score >= 60 ? AppColors.success : AppColors.error,
                          fontWeight: FontWeight.bold,
                        )),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildStatusBar(status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar(ModuleProgressStatus status) {
    Color color;
    String label;
    
    switch (status) {
      case ModuleProgressStatus.completed:
        color = AppColors.success;
        label = 'Completed';
        break;
      case ModuleProgressStatus.inProgress:
        color = AppColors.warning;
        label = 'In Progress';
        break;
      case ModuleProgressStatus.notStarted:
        color = AppColors.onSurfaceSubtle;
        label = 'Not Started';
    }

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodyXs.copyWith(color: AppColors.onSurfaceMuted)),
      ],
    );
  }
}
