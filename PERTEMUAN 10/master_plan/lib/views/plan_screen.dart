// lib/views/plan_screen.dart
import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../providers/plan_provider.dart';

const Color kPurpleColor = Color(0xFF9C27B0);
const Color kBackgroundColor = Color(0xFFF3E5F5);

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  // helper: find currentPlan from notifier by name
  Plan _findCurrentPlan(List<Plan> plans) {
    return plans.firstWhere((p) => p.name == widget.plan.name,
        orElse: () => widget.plan);
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _replacePlanInNotifier(ValueNotifier<List<Plan>> notifier, Plan newPlan) {
    final list = List<Plan>.from(notifier.value);
    final idx = list.indexWhere((p) => p.name == newPlan.name);
    if (idx != -1) {
      list[idx] = newPlan;
      notifier.value = list;
    } else {
      // fallback: add if not found
      list.add(newPlan);
      notifier.value = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    final plansNotifier = PlanProvider.of(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(widget.plan.name),
        backgroundColor: kPurpleColor,
        elevation: 0,
      ),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          final currentPlan = _findCurrentPlan(plans);

          return Column(
            children: [
              Expanded(child: _buildList(currentPlan, plansNotifier)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentPlan.completenessMessage,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: kPurpleColor),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Builder(builder: (context) {
        // builder so we can use context
        return _buildAddTaskButton(context);
      }),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    final plansNotifier = PlanProvider.of(context);

    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      onPressed: () {
        // get latest list and find current plan
        final plans = plansNotifier.value;
        final idx = plans.indexWhere((p) => p.name == widget.plan.name);

        // create updated tasks list by taking current tasks (if existed) or empty
        final currentTasks =
            (idx != -1) ? List<Task>.from(plans[idx].tasks) : <Task>[];

        final updatedTasks = List<Task>.from(currentTasks)
          ..add(const Task(description: '', complete: false));

        final updatedPlan = Plan(name: widget.plan.name, tasks: updatedTasks);

        // replace into notifier
        final newPlans = List<Plan>.from(plans);
        if (idx != -1) {
          newPlans[idx] = updatedPlan;
        } else {
          newPlans.add(updatedPlan);
        }
        plansNotifier.value = newPlans;
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _buildList(Plan currentPlan, ValueNotifier<List<Plan>> plansNotifier) {
    final tasks = currentPlan.tasks;
    return ListView.builder(
      controller: scrollController,
      itemCount: tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(tasks[index], index, plansNotifier),
    );
  }

  Widget _buildTaskTile(
      Task task, int index, ValueNotifier<List<Plan>> plansNotifier) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        leading: Checkbox(
          value: task.complete,
          activeColor: kPurpleColor,
          onChanged: (selected) {
            final plans = plansNotifier.value;
            final planIndex =
                plans.indexWhere((p) => p.name == widget.plan.name);
            if (planIndex == -1) return;

            final current = plans[planIndex];
            final updatedTasks = List<Task>.from(current.tasks);

            // if index exists, replace; otherwise add placeholders until index
            if (index < updatedTasks.length) {
              updatedTasks[index] =
                  updatedTasks[index].copyWith(complete: selected ?? false);
            } else {
              // expand list if needed
              while (updatedTasks.length <= index) {
                updatedTasks.add(const Task(description: '', complete: false));
              }
              updatedTasks[index] =
                  updatedTasks[index].copyWith(complete: selected ?? false);
            }

            final updatedPlan = current.copyWith(tasks: updatedTasks);
            _replacePlanInNotifier(plansNotifier, updatedPlan);
          },
        ),
        title: TextFormField(
          initialValue: task.description,
          decoration: InputDecoration(
            hintText: 'Tuliskan tugas...',
            hintStyle: TextStyle(color: kPurpleColor.withOpacity(0.6)),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPurpleColor),
            ),
          ),
          onChanged: (text) {
            final plans = plansNotifier.value;
            final planIndex =
                plans.indexWhere((p) => p.name == widget.plan.name);
            if (planIndex == -1) return;

            final current = plans[planIndex];
            final updatedTasks = List<Task>.from(current.tasks);

            if (index < updatedTasks.length) {
              updatedTasks[index] = updatedTasks[index].copyWith(
                description: text,
              );
            } else {
              while (updatedTasks.length <= index) {
                updatedTasks.add(const Task(description: '', complete: false));
              }
              updatedTasks[index] = updatedTasks[index].copyWith(
                description: text,
              );
            }

            final updatedPlan = current.copyWith(tasks: updatedTasks);
            _replacePlanInNotifier(plansNotifier, updatedPlan);
          },
        ),
      ),
    );
  }
}