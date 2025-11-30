import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../components/templates/base_page.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: Text('Help & Support', style: AppTypography.heading3(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Contact Options
          Text(
            'Contact Us',
            style: AppTypography.heading4(context),
          ),
          const SizedBox(height: AppSpacing.md),
          
          _ContactCard(
            icon: Icons.email,
            title: 'Email Support',
            subtitle: 'support@productivitysuite.com',
            onTap: () {
              // TODO: Open email client
            },
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          
          _ContactCard(
            icon: Icons.chat_bubble,
            title: 'Live Chat',
            subtitle: 'Chat with our support team',
            onTap: () {
              // TODO: Open live chat
            },
          ).animate(delay: 100.ms).fadeIn().slideX(begin: -0.2, end: 0),
          
          _ContactCard(
            icon: Icons.phone,
            title: 'Phone Support',
            subtitle: '+1 (800) 123-4567',
            onTap: () {
              // TODO: Open phone dialer
            },
          ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.2, end: 0),
          
          const SizedBox(height: AppSpacing.xl),
          
          // FAQ Section
          Text(
            'Frequently Asked Questions',
            style: AppTypography.heading4(context),
          ),
          const SizedBox(height: AppSpacing.md),
          
          _FAQItem(
            question: 'How do I create a new task?',
            answer: 'Tap the + button on the Tasks page to create a new task. You can add a title, description, priority, and due date.',
          ).animate(delay: 300.ms).fadeIn(),
          
          _FAQItem(
            question: 'Can I sync my tasks across devices?',
            answer: 'Yes! Upgrade to Pro to enable cloud sync and access your tasks from any device.',
          ).animate(delay: 400.ms).fadeIn(),
          
          _FAQItem(
            question: 'How do I change the theme?',
            answer: 'Go to Settings > Appearance and choose between Light, Dark, or System theme.',
          ).animate(delay: 500.ms).fadeIn(),
          
          _FAQItem(
            question: 'How do I delete a task?',
            answer: 'Swipe left on any task card to reveal the delete option.',
          ).animate(delay: 600.ms).fadeIn(),
          
          _FAQItem(
            question: 'What are achievements?',
            answer: 'Achievements are milestones you unlock as you complete tasks and maintain productivity streaks.',
          ).animate(delay: 700.ms).fadeIn(),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Resources
          Text(
            'Resources',
            style: AppTypography.heading4(context),
          ),
          const SizedBox(height: AppSpacing.md),
          
          _ResourceCard(
            icon: Icons.book,
            title: 'User Guide',
            onTap: () {
              // TODO: Open user guide
            },
          ).animate(delay: 800.ms).fadeIn(),
          
          _ResourceCard(
            icon: Icons.video_library,
            title: 'Video Tutorials',
            onTap: () {
              // TODO: Open tutorials
            },
          ).animate(delay: 900.ms).fadeIn(),
          
          _ResourceCard(
            icon: Icons.bug_report,
            title: 'Report a Bug',
            onTap: () {
              // TODO: Open bug report form
            },
          ).animate(delay: 1000.ms).fadeIn(),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                    size: 28,
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
                        subtitle,
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
        child: InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.question,
                        style: AppTypography.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ],
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    widget.answer,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ResourceCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
