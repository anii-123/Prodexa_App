# Component Usage Guide

## 🎨 How to Use the New UI Components

### Buttons

#### Primary Button (Gradient)
```dart
import 'package:productivity_suite/presentation/components/atoms/primary_button.dart';

PrimaryButton(
  label: 'Save Task',
  onPressed: () {
    // Handle press
  },
  icon: Icons.save, // Optional
  isLoading: false, // Optional
  useGradient: true, // Default
)
```

#### Secondary Button (Outlined)
```dart
import 'package:productivity_suite/presentation/components/atoms/secondary_button.dart';

SecondaryButton(
  label: 'Cancel',
  onPressed: () {
    // Handle press
  },
  icon: Icons.close, // Optional
)
```

### Filter Pills

```dart
import 'package:productivity_suite/presentation/components/atoms/filter_pill.dart';

FilterPill(
  label: 'Active',
  isSelected: _selectedFilter == TaskFilter.active,
  onTap: () => setState(() => _selectedFilter = TaskFilter.active),
  icon: Icons.radio_button_unchecked, // Optional
)
```

### Progress Bar

```dart
import 'package:productivity_suite/presentation/components/atoms/animated_progress_bar.dart';

AnimatedProgressBar(
  progress: 0.75, // 0.0 to 1.0
  height: 6.0, // Optional
  useGradient: true, // Optional
)
```

### Stats Card

```dart
import 'package:productivity_suite/presentation/components/molecules/stats_card.dart';

StatsCard(
  completedTasks: 8,
  totalTasks: 10,
  streakDays: 15,
)
```

### Enhanced Task Card

```dart
import 'package:productivity_suite/presentation/components/organisms/enhanced_task_card.dart';

EnhancedTaskCard(
  task: task,
  priority: TaskPriority.high, // high, medium, low
  tags: ['Design', 'Urgent'],
  dueDate: 'Today, 3:00 PM',
  onTap: () {
    // Navigate to details
  },
  onCheckboxChanged: (value) {
    // Toggle completion
  },
  onDelete: () {
    // Delete task
  },
)
```

## 🎨 Using the Design System

### Colors

```dart
import 'package:productivity_suite/core/theme/app_colors.dart';

// Light mode colors
Container(
  color: AppColors.lightPrimary,
  // or
  color: AppColors.lightBackground,
)

// Dark mode colors
Container(
  color: AppColors.darkPrimary,
)

// Priority colors
Container(
  color: AppColors.priorityHigh, // Red
  // or
  color: AppColors.priorityMedium, // Yellow
  // or
  color: AppColors.priorityLow, // Blue
)

// Gradients
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: AppColors.primaryGradient,
    ),
  ),
)
```

### Spacing

```dart
import 'package:productivity_suite/core/theme/app_spacing.dart';

// Padding/Margin
Padding(
  padding: EdgeInsets.all(AppSpacing.md), // 16px
  child: ...
)

// Border Radius
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppSpacing.radiusLg), // 16px
  ),
)

// Elevation
Card(
  elevation: AppSpacing.elevationSm, // 2.0
)
```

### Typography

```dart
import 'package:productivity_suite/core/theme/app_typography.dart';

Text(
  'Heading',
  style: AppTypography.heading3(context),
)

Text(
  'Body text',
  style: AppTypography.bodyMedium(context),
)

Text(
  'Caption',
  style: AppTypography.caption(context, color: Colors.grey),
)
```

## 🎯 Common Patterns

### Card with Gradient Header

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: isDark 
        ? AppColors.darkGradient 
        : AppColors.primaryGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: ...
)
```

### Animated Entrance

```dart
import 'package:flutter_animate/flutter_animate.dart';

Widget build(BuildContext context) {
  return Container(...)
    .animate()
    .fadeIn(duration: 300.ms)
    .slideY(begin: 0.1, end: 0, duration: 300.ms);
}
```

### Staggered List Animation

```dart
ListView.builder(
  itemBuilder: (context, index) {
    return MyWidget()
      .animate(delay: (index * 50).ms)
      .fadeIn(duration: 300.ms)
      .slideX(begin: 0.1, end: 0, duration: 300.ms);
  },
)
```

### Glassmorphic Card

```dart
import 'package:glassmorphism/glassmorphism.dart';

GlassmorphicContainer(
  width: double.infinity,
  height: null,
  borderRadius: AppSpacing.radiusLg,
  blur: 20,
  border: 2,
  linearGradient: LinearGradient(
    colors: [
      AppColors.lightPrimary.withOpacity(0.1),
      AppColors.lightSecondary.withOpacity(0.05),
    ],
  ),
  borderGradient: LinearGradient(
    colors: [
      AppColors.lightPrimary.withOpacity(0.3),
      AppColors.lightSecondary.withOpacity(0.3),
    ],
  ),
  child: Padding(
    padding: EdgeInsets.all(AppSpacing.lg),
    child: ...
  ),
)
```

### Responsive Dark/Light Mode

```dart
Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  
  return Container(
    color: isDark 
      ? AppColors.darkBackground 
      : AppColors.lightBackground,
    child: Text(
      'Hello',
      style: AppTypography.bodyMedium(context),
    ),
  );
}
```

### Button with Haptic Feedback

```dart
import 'package:flutter/services.dart';

GestureDetector(
  onTap: () {
    HapticFeedback.lightImpact();
    // Handle tap
  },
  child: ...
)
```

### Animated Scale on Press

```dart
class _MyWidgetState extends State<MyWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: Duration(milliseconds: 100),
        child: ...
      ),
    );
  }
}
```

## 📱 Page Templates

### Basic Page Structure

```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark 
        ? AppColors.darkBackground 
        : AppColors.lightBackground,
      appBar: AppBar(
        title: Text('My Page', style: AppTypography.heading3(context)),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        children: [
          // Your content
        ],
      ),
    );
  }
}
```

### Page with CustomScrollView

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      floating: true,
      snap: true,
      title: Text('Title'),
    ),
    SliverToBoxAdapter(
      child: MyWidget(),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => MyListItem(),
        childCount: items.length,
      ),
    ),
  ],
)
```

## 🎨 Best Practices

1. **Always use design system constants**
   - Use `AppColors`, `AppSpacing`, `AppTypography`
   - Don't hardcode values

2. **Check dark mode**
   - Always check `Theme.of(context).brightness`
   - Provide appropriate colors for both modes

3. **Add animations thoughtfully**
   - Use for page transitions and important actions
   - Keep durations between 200-500ms
   - Use appropriate curves

4. **Provide haptic feedback**
   - Use `HapticFeedback.lightImpact()` for taps
   - Use `HapticFeedback.mediumImpact()` for important actions

5. **Handle loading states**
   - Show loading indicators
   - Disable buttons during loading
   - Provide feedback

6. **Empty states**
   - Always show helpful empty states
   - Include icon, message, and action

## 🚀 Quick Start Checklist

- [ ] Import design system files
- [ ] Use `AppColors` for all colors
- [ ] Use `AppSpacing` for all spacing
- [ ] Use `AppTypography` for all text
- [ ] Add entrance animations
- [ ] Handle dark/light mode
- [ ] Add haptic feedback
- [ ] Test on multiple screen sizes
- [ ] Verify animations are smooth
- [ ] Check empty states

---

**Happy Coding! 🎨✨**
