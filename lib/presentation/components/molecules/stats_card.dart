import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../atoms/animated_progress_bar.dart';

class StatsCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final int streakDays;

  const StatsCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.streakDays,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    final percentage = (progress * 100).toInt();

    return GlassmorphicContainer(
      width: double.infinity,
      height: 180,
      borderRadius: AppSpacing.radiusLg,
      blur: 20,
      alignment: Alignment.center,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                AppColors.darkPrimary.withValues(alpha: 0.1),
                AppColors.darkSecondary.withValues(alpha: 0.05),
              ]
            : [
                AppColors.lightPrimary.withValues(alpha: 0.1),
                AppColors.lightSecondary.withValues(alpha: 0.05),
              ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                AppColors.darkPrimary.withValues(alpha: 0.3),
                AppColors.darkSecondary.withValues(alpha: 0.3),
              ]
            : [
                AppColors.lightPrimary.withValues(alpha: 0.3),
                AppColors.lightSecondary.withValues(alpha: 0.3),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                  size: 24,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  "Today's Progress",
                  style: AppTypography.heading4(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            
            // Progress bar
            AnimatedProgressBar(progress: progress),
            const SizedBox(height: AppSpacing.sm),
            
            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$completedTasks/$totalTasks tasks done',
                  style: AppTypography.bodyMedium(context),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.darkSuccess : AppColors.lightSuccess)
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(
                    '$percentage%',
                    style: AppTypography.captionBold(
                      context,
                      color: isDark
                          ? AppColors.darkSuccess
                          : AppColors.lightSuccess,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            
            // Streak indicator
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: AppColors.lightWarning,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '$streakDays day streak',
                  style: AppTypography.bodySmall(context),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 100.ms)
        .slideY(begin: 0.2, end: 0, duration: 400.ms, delay: 100.ms);
  }
}
