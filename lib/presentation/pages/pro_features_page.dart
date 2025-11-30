import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../components/atoms/primary_button.dart';
import '../components/templates/base_page.dart';

class ProFeaturesPage extends StatelessWidget {
  const ProFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BasePage(
      appBar: AppBar(
        title: Text('Pro Features', style: AppTypography.heading3(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.workspace_premium,
                  size: 64,
                  color: Colors.white,
                ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Unlock Pro Features',
                  style: AppTypography.heading2(context).copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Get unlimited access to all premium features',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Features List
          _FeatureItem(
            icon: Icons.cloud_sync,
            title: 'Cloud Sync',
            description: 'Sync your tasks across all devices',
          ).animate(delay: 100.ms).fadeIn().slideX(begin: -0.2, end: 0),
          
          _FeatureItem(
            icon: Icons.folder_special,
            title: 'Unlimited Projects',
            description: 'Create unlimited projects and categories',
          ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.2, end: 0),
          
          _FeatureItem(
            icon: Icons.analytics,
            title: 'Advanced Analytics',
            description: 'Detailed insights and productivity reports',
          ).animate(delay: 300.ms).fadeIn().slideX(begin: -0.2, end: 0),
          
          _FeatureItem(
            icon: Icons.palette,
            title: 'Custom Themes',
            description: 'Personalize with unlimited color themes',
          ).animate(delay: 400.ms).fadeIn().slideX(begin: -0.2, end: 0),
          
          _FeatureItem(
            icon: Icons.group,
            title: 'Team Collaboration',
            description: 'Share tasks and collaborate with your team',
          ).animate(delay: 500.ms).fadeIn().slideX(begin: -0.2, end: 0),
          
          _FeatureItem(
            icon: Icons.support_agent,
            title: 'Priority Support',
            description: '24/7 dedicated customer support',
          ).animate(delay: 600.ms).fadeIn().slideX(begin: -0.2, end: 0),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Pricing
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Text(
                    '\$9.99',
                    style: AppTypography.heading1(context).copyWith(
                      color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                    ),
                  ),
                  Text(
                    'per month',
                    style: AppTypography.bodyMedium(context),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: 'Upgrade to Pro',
                    onPressed: () {
                      // TODO: Implement payment
                    },
                    icon: Icons.arrow_forward,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    '7-day free trial • Cancel anytime',
                    style: AppTypography.caption(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ).animate(delay: 700.ms).fadeIn().scale(),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(
                  icon,
                  color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                  size: 32,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodyLarge(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      description,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
