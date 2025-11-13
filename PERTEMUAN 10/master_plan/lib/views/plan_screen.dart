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
  Plan get plan => widget.plan;

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

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(plan.name),
        backgroundColor: kPurpleColor,
        elevation: 0,
      ),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          Plan currentPlan = plans.firstWhere((p) => p.name == plan.name);
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
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
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      child: const Icon(Icons.add, color: Colors.white),
      onPressed: () {
        Plan currentPlan = plan;
        int planIndex =
            planNotifier.value.indexWhere((p) => p.name == currentPlan.name);
        List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
          ..add(const Task());
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            tasks: updatedTasks,
          );
      },
    );
  }

  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(plan.tasks[index], index, context),
    );
  }

Widget _buildTaskTile(Task task, int index, BuildContext context) {
  ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 2,
    color: Colors.white,
    child: ListTile(
      leading: Checkbox(
        value: task.complete,
        activeColor: kPurpleColor,
        onChanged: (selected) {
          Plan currentPlan = plan;
          int planIndex = planNotifier.value
              .indexWhere((p) => p.name == currentPlan.name);

          List<Task> updatedTasks = List<Task>.from(currentPlan.tasks);
          if (index < updatedTasks.length) {
            updatedTasks[index] = Task(
              description: task.description,
              complete: selected ?? false,
            );
          } else {
            updatedTasks.add(Task(
              description: task.description,
              complete: selected ?? false,
            ));
          }

          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );
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
          Plan currentPlan = plan;
          int planIndex = planNotifier.value
              .indexWhere((p) => p.name == currentPlan.name);

          List<Task> updatedTasks = List<Task>.from(currentPlan.tasks);
          if (index < updatedTasks.length) {
            updatedTasks[index] = Task(
              description: text,
              complete: task.complete,
            );
          } else {
            updatedTasks.add(Task(
              description: text,
              complete: task.complete,
            ));
          }

          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );
        },
      ),
    ),
  );
}
}