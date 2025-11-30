import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/navigation/navigation_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      child: Column(
        children: [
          // Drawer Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 32, color: AppColors.lightPrimary),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: AppTypography.heading4(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'john@example.com',
                        style: AppTypography.caption(context).copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                _DrawerItem(
                  icon: Icons.check_circle_outline,
                  label: 'Tasks',
                  onTap: () {
                    context.pop(); // Close drawer
                    NavigationController.navigateToTasks();
                  },
                ),
                _DrawerItem(
                  icon: Icons.list_alt,
                  label: 'Checklists',
                  onTap: () {
                    context.pop();
                    NavigationController.navigateToChecklists();
                  },
                ),
                _DrawerItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  onTap: () {
                    context.pop();
                    NavigationController.navigateToProfile();
                  },
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () {
                    context.pop();
                    NavigationController.navigateToSettings();
                  },
                ),
                const Divider(height: 32),
                _DrawerItem(
                  icon: Icons.star_outline,
                  label: 'Pro Features',
                  onTap: () {
                    context.pop();
                    context.push('/pro-features');
                  },
                  isPro: true,
                ),
                _DrawerItem(
                  icon: Icons.help_outline,
                  label: 'Help & Support',
                  onTap: () {
                    context.pop();
                    context.push('/help-support');
                  },
                ),
              ],
            ),
          ),

          // Logout
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: _DrawerItem(
              icon: Icons.logout,
              label: 'Log Out',
              onTap: () => context.go('/login'),
              color: isDark ? AppColors.darkError : AppColors.lightError,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final bool isPro;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.isPro = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final itemColor = color ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);

    return ListTile(
      leading: Icon(icon, color: itemColor),
      title: Text(
        label,
        style: AppTypography.bodyMedium(context).copyWith(
          color: itemColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: isPro
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.priorityHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'PRO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
