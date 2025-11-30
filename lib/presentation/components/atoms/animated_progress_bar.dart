import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;
  final bool useGradient;
  final Color? color;

  const AnimatedProgressBar({
    super.key,
    required this.progress,
    this.height = 6.0,
    this.useGradient = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            // Background
            Container(
              color: isDark
                  ? AppColors.darkDivider
                  : AppColors.lightDivider.withValues(alpha: 0.3),
            ),
            // Progress
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: useGradient && color == null
                      ? LinearGradient(
                          colors: isDark
                              ? [AppColors.darkSuccess, AppColors.darkPrimary]
                              : [AppColors.lightSuccess, AppColors.lightPrimary],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  color: color,
                ),
              ),
            )
                .animate()
                .scaleX(
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.centerLeft,
                )
                .fadeIn(duration: 300.ms),
          ],
        ),
      ),
    );
  }
}
