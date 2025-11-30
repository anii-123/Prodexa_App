import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../components/atoms/primary_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _emailSent = false;
  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark 
                  ? [
                      AppColors.darkPrimary.withValues(alpha: 0.3),
                      AppColors.darkBackground,
                      AppColors.darkPrimary.withValues(alpha: 0.2),
                    ]
                  : [
                      AppColors.lightPrimary.withValues(alpha: 0.1),
                      Colors.white,
                      AppColors.lightPrimary.withValues(alpha: 0.05),
                    ],
              ),
            ),
          ),

          // Floating animated circles
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                return Positioned(
                  top: size.height * (0.15 + index * 0.25) + (_floatingController.value * 40),
                  right: size.width * (0.05 + index * 0.25),
                  child: Container(
                    width: 120 + (index * 40),
                    height: 120 + (index * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                              .withValues(alpha: 0.1),
                          (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                              .withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark 
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ),
                ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),
                          
                          // Icon with gradient
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                                        .withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.lock_reset,
                                size: 40,
                                color: Colors.white,
                              ),
                            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Title
                          Text(
                            _emailSent ? 'Check Your Email' : 'Forgot Password?',
                            style: AppTypography.heading1(context),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
                          
                          const SizedBox(height: 8),
                          
                          Text(
                            _emailSent 
                              ? 'We\'ve sent a password reset link to ${_emailController.text}'
                              : 'No worries! Enter your email and we\'ll send you reset instructions.',
                            style: AppTypography.bodyLarge(context).copyWith(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3, end: 0),
                          
                          const SizedBox(height: 40),
                          
                          if (!_emailSent) ...[
                            // Glassmorphism Card
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              decoration: BoxDecoration(
                                color: isDark 
                                  ? Colors.white.withValues(alpha: 0.05)
                                  : Colors.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                                border: Border.all(
                                  color: isDark 
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.white.withValues(alpha: 0.5),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email Address', style: AppTypography.labelBold(context)),
                                  const SizedBox(height: AppSpacing.sm),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter your email',
                                      filled: true,
                                      fillColor: isDark 
                                        ? AppColors.darkCardBackground.withValues(alpha: 0.5)
                                        : Colors.grey[100],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                        borderSide: BorderSide(
                                          color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                                          width: 2,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                                      ),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 24),
                                  
                                  // Send Reset Link Button
                                  PrimaryButton(
                                    label: 'Send Reset Link',
                                    onPressed: _sendResetLink,
                                    isLoading: _isLoading,
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
                          ] else ...[
                            // Success Card
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.xl),
                              decoration: BoxDecoration(
                                color: (isDark ? AppColors.darkSuccess : AppColors.lightSuccess)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                                border: Border.all(
                                  color: isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.mark_email_read,
                                    size: 60,
                                    color: isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    'Email Sent Successfully!',
                                    style: AppTypography.heading4(context),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    'Please check your inbox and spam folder.',
                                    style: AppTypography.bodyMedium(context),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ).animate().fadeIn().scale(),
                            
                            const SizedBox(height: 24),
                            
                            PrimaryButton(
                              label: 'Back to Login',
                              onPressed: () => context.pop(),
                            ),
                          ],
                          
                          const SizedBox(height: 24),
                          
                          // Back to Login Link
                          if (!_emailSent)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Remember your password? ',
                                  style: AppTypography.bodyMedium(context),
                                ),
                                TextButton(
                                  onPressed: () => context.pop(),
                                  child: Text(
                                    'Log In',
                                    style: AppTypography.button(context).copyWith(
                                      color: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ).animate().fadeIn(delay: 500.ms),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
