import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../components/atoms/primary_button.dart';
import '../components/organisms/enhanced_task_card.dart'; // For TaskPriority enum
import '../components/templates/base_page.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime? _selectedDate;
  final List<String> _selectedTags = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) return;

    // Return the new task data to the previous screen
    context.pop({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'priority': _selectedPriority,
      'date': _selectedDate,
      'tags': _selectedTags,
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BasePage(
      appBar: AppBar(
        title: Text('New Task', style: AppTypography.heading3(context)),
        leading: IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Input
            Text('Title', style: AppTypography.labelBold(context)),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'What needs to be done?',
                filled: true,
                fillColor: isDark ? AppColors.darkCardBackground : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
              style: AppTypography.bodyLarge(context),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Description Input
            Text('Description', style: AppTypography.labelBold(context)),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add details...',
                filled: true,
                fillColor: isDark ? AppColors.darkCardBackground : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
              style: AppTypography.bodyMedium(context),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Priority Selection
            Text('Priority', style: AppTypography.labelBold(context)),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: TaskPriority.values.map((priority) {
                final isSelected = _selectedPriority == priority;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: ChoiceChip(
                    label: Text(
                      priority.name.toUpperCase(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedPriority = priority);
                    },
                    selectedColor: _getPriorityColor(priority),
                    backgroundColor: isDark ? AppColors.darkCardBackground : Colors.grey[200],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Due Date
            Text('Due Date', style: AppTypography.labelBold(context)),
            const SizedBox(height: AppSpacing.sm),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardBackground : Colors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, 
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      _selectedDate == null 
                        ? 'Select Date' 
                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      style: AppTypography.bodyMedium(context),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppSpacing.xxl),
            
            // Save Button
            PrimaryButton(
              label: 'Create Task',
              onPressed: _saveTask,
              icon: Icons.check,
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppColors.priorityHigh;
      case TaskPriority.medium:
        return AppColors.priorityMedium;
      case TaskPriority.low:
        return AppColors.priorityLow;
    }
  }
}
