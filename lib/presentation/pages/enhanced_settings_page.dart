import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/theme_manager.dart';
import '../components/templates/base_page.dart';

enum AppThemeMode { light, dark, system }

class EnhancedSettingsPage extends StatefulWidget {
  const EnhancedSettingsPage({super.key});

  @override
  State<EnhancedSettingsPage> createState() => _EnhancedSettingsPageState();
}

class _EnhancedSettingsPageState extends State<EnhancedSettingsPage> {
  AppThemeMode _selectedTheme = AppThemeMode.system;
  bool _taskReminders = true;
  bool _dailySummary = true;
  bool _achievements = false;
  bool _biometricLock = false;

  @override
  void initState() {
    super.initState();
    _initTheme();
  }

  void _initTheme() {
    final mode = ThemeManager.themeModeNotifier.value;
    switch (mode) {
      case ThemeMode.light:
        _selectedTheme = AppThemeMode.light;
        break;
      case ThemeMode.dark:
        _selectedTheme = AppThemeMode.dark;
        break;
      case ThemeMode.system:
        _selectedTheme = AppThemeMode.system;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: Text('Settings', style: AppTypography.heading3(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Appearance Section
          _SectionHeader(title: 'Appearance', icon: Icons.palette),
          const SizedBox(height: AppSpacing.md),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: AppTypography.labelBold(context),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _ThemeOption(
                          label: 'Light',
                          icon: Icons.light_mode,
                          isSelected: _selectedTheme == AppThemeMode.light,
                          onTap: () {
                            setState(() => _selectedTheme = AppThemeMode.light);
                            ThemeManager.setThemeMode(ThemeMode.light);
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _ThemeOption(
                          label: 'Dark',
                          icon: Icons.dark_mode,
                          isSelected: _selectedTheme == AppThemeMode.dark,
                          onTap: () {
                            setState(() => _selectedTheme = AppThemeMode.dark);
                            ThemeManager.setThemeMode(ThemeMode.dark);
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _ThemeOption(
                          label: 'System',
                          icon: Icons.brightness_auto,
                          isSelected: _selectedTheme == AppThemeMode.system,
                          onTap: () {
                            setState(() => _selectedTheme = AppThemeMode.system);
                            ThemeManager.setThemeMode(ThemeMode.system);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Notifications Section
          _SectionHeader(title: 'Notifications', icon: Icons.notifications),
          const SizedBox(height: AppSpacing.md),
          
          Card(
            child: Column(
              children: [
                _SettingTile(
                  title: 'Task Reminders',
                  subtitle: 'Get notified about upcoming tasks',
                  icon: Icons.alarm,
                  value: _taskReminders,
                  onChanged: (value) => setState(() => _taskReminders = value),
                ),
                const Divider(height: 1),
                _SettingTile(
                  title: 'Daily Summary',
                  subtitle: 'Receive daily productivity summary',
                  icon: Icons.summarize,
                  value: _dailySummary,
                  onChanged: (value) => setState(() => _dailySummary = value),
                ),
                const Divider(height: 1),
                _SettingTile(
                  title: 'Achievements',
                  subtitle: 'Celebrate your milestones',
                  icon: Icons.emoji_events,
                  value: _achievements,
                  onChanged: (value) => setState(() => _achievements = value),
                ),
              ],
            ),
          ).animate(delay: 100.ms).fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Privacy & Security Section
          _SectionHeader(title: 'Privacy & Security', icon: Icons.security),
          const SizedBox(height: AppSpacing.md),
          
          Card(
            child: Column(
              children: [
                _SettingTile(
                  title: 'Biometric Lock',
                  subtitle: 'Use fingerprint or face ID',
                  icon: Icons.fingerprint,
                  value: _biometricLock,
                  onChanged: (value) => setState(() => _biometricLock = value),
                ),
                const Divider(height: 1),
                _NavigationTile(
                  title: 'Auto-lock timeout',
                  subtitle: '5 minutes',
                  icon: Icons.timer,
                  onTap: () {
                    // TODO: Show timeout picker
                  },
                ),
                const Divider(height: 1),
                _NavigationTile(
                  title: 'Export Data',
                  subtitle: 'Download your tasks and data',
                  icon: Icons.download,
                  onTap: () {
                    // TODO: Export data
                  },
                ),
              ],
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
          
          const SizedBox(height: AppSpacing.lg),
          
          // About Section
          _SectionHeader(title: 'About', icon: Icons.info),
          const SizedBox(height: AppSpacing.md),
          
          Card(
            child: Column(
              children: [
                _NavigationTile(
                  title: 'Version',
                  subtitle: '1.0.0',
                  icon: Icons.info_outline,
                  onTap: null,
                ),
                const Divider(height: 1),
                _NavigationTile(
                  title: 'Privacy Policy',
                  icon: Icons.privacy_tip,
                  onTap: () {
                    // TODO: Open privacy policy
                  },
                ),
                const Divider(height: 1),
                _NavigationTile(
                  title: 'Terms of Service',
                  icon: Icons.description,
                  onTap: () {
                    // TODO: Open terms
                  },
                ),
              ],
            ),
          ).animate(delay: 300.ms).fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: AppTypography.heading4(context),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.1)
              : (isDark ? AppColors.darkCardBackground : Colors.grey[100]),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? primaryColor : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              size: 28,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? primaryColor : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return ListTile(
      leading: Icon(
        icon,
        color: primaryColor,
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium(context).copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.caption(context),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
        activeTrackColor: primaryColor.withValues(alpha: 0.5),
        inactiveThumbColor: isDark ? Colors.grey[400] : Colors.grey[300],
        inactiveTrackColor: isDark 
          ? Colors.grey[800] 
          : Colors.grey[300],
      ),
    );
  }
}

class _NavigationTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const _NavigationTile({
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        icon,
        color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium(context).copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.caption(context),
            )
          : null,
      trailing: onTap != null
          ? Icon(
              Icons.chevron_right,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            )
          : null,
      onTap: onTap,
    );
  }
}
