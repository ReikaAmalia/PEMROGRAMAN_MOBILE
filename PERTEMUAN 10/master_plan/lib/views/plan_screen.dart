import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../providers/plan_provider.dart';

// Warna tema ungu lembut
const Color kPurpleColor = Color(0xFF9C27B0);
const Color kBackgroundColor = Color(0xFFF3E5F5);

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        // Tutup keyboard ketika scroll
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
    final planNotifier = PlanProvider.of(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Master Plan Reika'),
        backgroundColor: kPurpleColor,
        elevation: 0,
      ),
      body: ValueListenableBuilder<Plan>(
        valueListenable: planNotifier,
        builder: (context, plan, child) {
          return Column(
            children: [
              Expanded(child: _buildList(plan)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    plan.completenessMessage,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPurpleColor,
                    ),
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

  // Tombol tambah task
  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<Plan> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      onPressed: () {
        Plan currentPlan = planNotifier.value;
        planNotifier.value = Plan(
          name: currentPlan.name,
          tasks: List<Task>.from(currentPlan.tasks)..add(const Task()),
        );
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  // Daftar task
  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(plan.tasks[index], index, context),
    );
  }

  // Tile untuk tiap task
  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<Plan> planNotifier = PlanProvider.of(context);
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
            Plan currentPlan = planNotifier.value;
            planNotifier.value = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: task.description,
                  complete: selected ?? false,
                ),
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
            Plan currentPlan = planNotifier.value;
            planNotifier.value = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: text,
                  complete: task.complete,
                ),
            );
          },
        ),
      ),
    );
  }
}