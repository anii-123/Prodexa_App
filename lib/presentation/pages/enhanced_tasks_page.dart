import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/task.dart';
import '../components/molecules/stats_card.dart';
import '../components/atoms/filter_pill.dart';
import '../components/organisms/enhanced_task_card.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../components/organisms/app_drawer.dart';
import '../components/templates/base_page.dart';

enum TaskFilter { all, active, done }

class EnhancedTasksPage extends StatefulWidget {
  const EnhancedTasksPage({super.key});

  @override
  State<EnhancedTasksPage> createState() => _EnhancedTasksPageState();
}

class _EnhancedTasksPageState extends State<EnhancedTasksPage> {
  TaskFilter _selectedFilter = TaskFilter.all;

  // Mock data - replace with actual data from BLoC
  final List<Task> _tasks = List.generate(
    15,
    (index) => Task(
      id: 'task_$index',
      title: _getTaskTitle(index),
      isCompleted: index % 3 == 0,
    ),
  );

  static String _getTaskTitle(int index) {
    final titles = [
      'Design landing page',
      'Code review PR #234',
      'Update documentation',
      'Team meeting at 3 PM',
      'Fix bug in authentication',
      'Create wireframes',
      'Write unit tests',
      'Deploy to production',
      'Client presentation',
      'Research new features',
    ];
    return titles[index % titles.length];
  }

  List<Task> get _filteredTasks {
    switch (_selectedFilter) {
      case TaskFilter.active:
        return _tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.done:
        return _tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.all:
        return _tasks;
    }
  }

  int get _completedCount =>
      _tasks.where((task) => task.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BasePage(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Tasks',
              style: AppTypography.heading3(context),
            ),
          ),

          // Stats Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: StatsCard(
                completedTasks: _completedCount,
                totalTasks: _tasks.length,
                streakDays: 15,
              ),
            ),
          ),

          // Filter Pills
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  FilterPill(
                    label: 'All',
                    isSelected: _selectedFilter == TaskFilter.all,
                    onTap: () => setState(() => _selectedFilter = TaskFilter.all),
                    icon: Icons.list,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  FilterPill(
                    label: 'Active',
                    isSelected: _selectedFilter == TaskFilter.active,
                    onTap: () => setState(() => _selectedFilter = TaskFilter.active),
                    icon: Icons.radio_button_unchecked,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  FilterPill(
                    label: 'Done',
                    isSelected: _selectedFilter == TaskFilter.done,
                    onTap: () => setState(() => _selectedFilter = TaskFilter.done),
                    icon: Icons.check_circle,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
          ),

          // Task List
          SliverPadding(
            padding: const EdgeInsets.only(
              bottom: 100, // Space for FAB
            ),
            sliver: _filteredTasks.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _selectedFilter == TaskFilter.done
                                ? Icons.celebration
                                : Icons.inbox,
                            size: 80,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            _selectedFilter == TaskFilter.done
                                ? 'No completed tasks yet'
                                : 'Nothing here yet!',
                            style: AppTypography.heading4(context),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            _selectedFilter == TaskFilter.done
                                ? 'Complete some tasks to see them here'
                                : 'Tap + to create your first task',
                            style: AppTypography.bodyMedium(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final task = _filteredTasks[index];
                        return EnhancedTaskCard(
                          task: task,
                          priority: index % 3 == 0
                              ? TaskPriority.high
                              : index % 2 == 0
                                  ? TaskPriority.medium
                                  : TaskPriority.low,
                          tags: index % 2 == 0
                              ? ['Design', 'Urgent']
                              : ['Development'],
                          dueDate: index % 3 == 0 ? 'Today, 3:00 PM' : null,
                          onTap: () {
                            // TODO: Navigate to task details
                          },
                          onCheckboxChanged: (value) {
                            setState(() {
                              // Find the task in the original list and toggle its completion
                              final taskIndex = _tasks.indexWhere((t) => t.id == task.id);
                              if (taskIndex != -1) {
                                _tasks[taskIndex] = Task(
                                  id: task.id,
                                  title: task.title,
                                  isCompleted: value ?? !task.isCompleted,
                                );
                              }
                            });
                          },
                          onDelete: () {
                            setState(() {
                              _tasks.remove(task);
                            });
                          },
                        ).animate(delay: (index * 50).ms).fadeIn(
                              duration: 300.ms,
                            ).slideX(
                              begin: 0.1,
                              end: 0,
                              duration: 300.ms,
                            );
                      },
                      childCount: _filteredTasks.length,
                    ),
                  ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: [
            BoxShadow(
              color: (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
                  .withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await context.push('/create-task');
            if (result != null && result is Map) {
              setState(() {
                _tasks.insert(0, Task(
                  id: 'task_${DateTime.now().millisecondsSinceEpoch}',
                  title: result['title'],
                  isCompleted: false,
                ));
              });
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add, size: 24),
          label: Text(
            'New Task',
            style: AppTypography.button(context, color: Colors.white),
          ),
        ),
      )
          .animate()
          .scale(delay: 500.ms, duration: 300.ms, curve: Curves.elasticOut),
    );
  }
}
