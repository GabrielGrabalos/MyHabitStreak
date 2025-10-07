import 'package:flutter/material.dart';
import 'package:my_habit_streak/models/habit.dart';
import 'package:my_habit_streak/models/habit_group.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/button.dart';
import 'package:my_habit_streak/widgets/color_selector.dart';
import 'package:my_habit_streak/widgets/habit_card.dart';
import 'package:my_habit_streak/widgets/selectable.dart';

class CreateGroupBottomSheet extends StatefulWidget {
  final List<Habit> availableHabits;
  final ValueChanged<HabitGroup> onCreate;

  const CreateGroupBottomSheet({
    super.key,
    required this.availableHabits,
    required this.onCreate,
  });

  @override
  State<CreateGroupBottomSheet> createState() => _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final List<Habit> _selectedHabits = [];
  Color _selectedColor = blueTheme;
  bool _isCreating = false;

  void _toggleHabitSelection(Habit habit) {
    setState(() {
      if (_selectedHabits.contains(habit)) {
        _selectedHabits.remove(habit);
      } else {
        _selectedHabits.add(habit);
      }
    });
  }

  void _handleCreate() async {
    if (_titleController.text.trim().isEmpty || _selectedHabits.isEmpty) {
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a title and select at least one habit'),
        ),
      );*/
      return;
    }

    setState(() => _isCreating = true);

    final newGroup = HabitGroup(
      name: _titleController.text.trim(),
      color: _selectedColor,
      habitIds: _selectedHabits.map((h) => h.id).toList(),
    );

    await Future.delayed(const Duration(milliseconds: 300));
    widget.onCreate(newGroup);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.35,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: [0.5, 0.75, 0.95],
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(
            color: darkBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Center(
                            child: Text(
                              'Create new group',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Group title input
                          TextField(
                            controller: _titleController,
                            cursorColor: _selectedColor,
                            decoration: InputDecoration(
                              labelText: 'Group title',
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                    BorderSide(color: _selectedColor, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide:
                                    BorderSide(color: _selectedColor, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Color selector
                          Center(
                            child: ColorSelector(
                              selectedColor: _selectedColor,
                              onColorSelected: (color) =>
                                  setState(() => _selectedColor = color),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Selectable habits list
                          Text(
                            'Select habits:',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.availableHabits.length,
                            itemBuilder: (context, index) {
                              final habit = widget.availableHabits[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Selectable<Habit>(
                                  value: habit,
                                  groupValue: _selectedHabits,
                                  onChanged: (_) =>
                                      _toggleHabitSelection(habit),
                                  child: HabitCard(habit: habit),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom row (always at bottom)
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedHabits.length} selected',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Button(
                          isLoading: _isCreating,
                          label: 'Create',
                          color: _selectedColor,
                          onPressed: _handleCreate,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
