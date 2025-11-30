import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../components/templates/base_page.dart';
import '../components/atoms/animated_progress_bar.dart';

class ChecklistsPage extends StatefulWidget {
  const ChecklistsPage({super.key});

  @override
  State<ChecklistsPage> createState() => _ChecklistsPageState();
}

class _ChecklistsPageState extends State<ChecklistsPage> {
  final List<_ChecklistData> _checklists = [
    _ChecklistData(
      id: '1',
      title: '🛒 Grocery Shopping',
      items: [
        _ChecklistItem(title: 'Milk', isCompleted: true),
        _ChecklistItem(title: 'Eggs', isCompleted: true),
        _ChecklistItem(title: 'Bread', isCompleted: false),
        _ChecklistItem(title: 'Butter', isCompleted: false),
        _ChecklistItem(title: 'Cheese', isCompleted: false),
      ],
      isExpanded: false,
    ),
    _ChecklistData(
      id: '2',
      title: '🏠 Home Renovation',
      items: [
        _ChecklistItem(title: 'Paint living room', isCompleted: true),
        _ChecklistItem(title: 'Install new lights', isCompleted: false),
        _ChecklistItem(title: 'Fix bathroom sink', isCompleted: false),
        _ChecklistItem(title: 'Replace door handles', isCompleted: false),
      ],
      isExpanded: false,
    ),
    _ChecklistData(
      id: '3',
      title: '✈️ Vacation Planning',
      items: [
        _ChecklistItem(title: 'Book flights', isCompleted: true),
        _ChecklistItem(title: 'Reserve hotel', isCompleted: true),
        _ChecklistItem(title: 'Plan itinerary', isCompleted: false),
        _ChecklistItem(title: 'Pack luggage', isCompleted: false),
      ],
      isExpanded: false,
    ),
  ];

  void _showAddChecklistDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Checklist'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Checklist Title'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _checklists.add(_ChecklistData(
                    id: DateTime.now().toString(),
                    title: controller.text,
                    items: [],
                    isExpanded: true,
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog(_ChecklistData checklist) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Item'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Item Name'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  checklist.items.add(_ChecklistItem(title: controller.text));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BasePage(
      appBar: AppBar(
        title: Text('Checklists', style: AppTypography.heading3(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _checklists.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.checklist,
                    size: 80,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'No checklists yet',
                    style: AppTypography.heading4(context),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Tap + to create your first checklist',
                    style: AppTypography.bodyMedium(context),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(
                left: AppSpacing.md,
                right: AppSpacing.md,
                top: AppSpacing.md,
                bottom: 100, // Space for FAB
              ),
              itemCount: _checklists.length,
              itemBuilder: (context, index) {
                final checklist = _checklists[index];
                return _ChecklistCard(
                  checklist: checklist,
                  onToggleExpand: () {
                    setState(() {
                      checklist.isExpanded = !checklist.isExpanded;
                    });
                  },
                  onItemToggle: (itemIndex) {
                    setState(() {
                      checklist.items[itemIndex].isCompleted =
                          !checklist.items[itemIndex].isCompleted;
                    });
                  },
                  onAddItem: () => _showAddItemDialog(checklist),
                ).animate(delay: (index * 100).ms).fadeIn(duration: 300.ms).slideY(
                      begin: 0.1,
                      end: 0,
                      duration: 300.ms,
                    );
              },
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
          onPressed: _showAddChecklistDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add, size: 24),
          label: Text(
            'New Checklist',
            style: AppTypography.button(context, color: Colors.white),
          ),
        ),
      )
          .animate()
          .scale(delay: 500.ms, duration: 300.ms, curve: Curves.elasticOut),
    );
  }
}

class _ChecklistData {
  final String id;
  final String title;
  final List<_ChecklistItem> items;
  bool isExpanded;

  _ChecklistData({
    required this.id,
    required this.title,
    required this.items,
    this.isExpanded = false,
  });

  int get completedCount => items.where((item) => item.isCompleted).length;
  double get progress => items.isEmpty ? 0 : completedCount / items.length;
}

class _ChecklistItem {
  final String title;
  bool isCompleted;

  _ChecklistItem({
    required this.title,
    this.isCompleted = false,
  });
}

class _ChecklistCard extends StatelessWidget {
  final _ChecklistData checklist;
  final VoidCallback onToggleExpand;
  final Function(int) onItemToggle;
  final VoidCallback onAddItem;

  const _ChecklistCard({
    required this.checklist,
    required this.onToggleExpand,
    required this.onItemToggle,
    required this.onAddItem,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final percentage = (checklist.progress * 100).toInt();

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        children: [
          InkWell(
            onTap: onToggleExpand,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          checklist.title,
                          style: AppTypography.heading4(context),
                        ),
                      ),
                      Icon(
                        checklist.isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AnimatedProgressBar(progress: checklist.progress),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '$percentage% complete (${checklist.completedCount}/${checklist.items.length})',
                    style: AppTypography.bodySmall(context),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: checklist.isExpanded
                ? Column(
                    children: [
                      const Divider(height: 1),
                      ...List.generate(
                        checklist.items.length,
                        (index) {
                          final item = checklist.items[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Checkbox(
                                  value: item.isCompleted,
                                  onChanged: (_) => onItemToggle(index),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                title: Text(
                                  item.title,
                                  style: AppTypography.bodyMedium(context).copyWith(
                                    decoration: item.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: item.isCompleted
                                        ? (isDark
                                            ? AppColors.darkTextSecondary
                                            : AppColors.lightTextSecondary)
                                        : null,
                                  ),
                                ),
                              ),
                              if (index < checklist.items.length - 1)
                                const Divider(height: 1, indent: 56),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: TextButton.icon(
                          onPressed: onAddItem,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Item'),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
