import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../components/templates/base_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BasePage(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                        .withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_circle_outline,
                size: 64,
                color: Colors.white,
              ),
            ).animate()
             .scale(duration: 600.ms, curve: Curves.elasticOut)
             .then(delay: 200.ms)
             .shimmer(duration: 1200.ms),
            
            const SizedBox(height: 32),
            
            Text(
              'Prodexa',
              style: AppTypography.heading2(context).copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ).animate()
             .fadeIn(delay: 400.ms, duration: 600.ms)
             .slideY(begin: 0.2, end: 0),
             
            const SizedBox(height: 16),
            
            Text(
              'Organize your life, simply.',
              style: AppTypography.bodyLarge(context).copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ).animate()
             .fadeIn(delay: 800.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
