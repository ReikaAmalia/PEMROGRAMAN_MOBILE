// lib/views/plan_creator_screen.dart
import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../providers/plan_provider.dart';
import 'plan_screen.dart';

const Color kPurpleColor = Color(0xFF9C27B0);
const Color kBackgroundColor = Color(0xFFF3E5F5);

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void addPlan() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final newPlan = Plan(name: text, tasks: []);
    final notifier = PlanProvider.of(context);
    notifier.value = List<Plan>.from(notifier.value)..add(newPlan);

    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {}); // update to show list immediately
  }

  @override
  Widget build(BuildContext context) {
    final plansNotifier = PlanProvider.of(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Master Plans Rere'),
        backgroundColor: kPurpleColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Creator input + button
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'Add a plan',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => addPlan(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: addPlan,
                    icon: const Icon(Icons.add_circle),
                    color: kPurpleColor,
                    iconSize: 28,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // List of plans
            Expanded(
              child: ValueListenableBuilder<List<Plan>>(
                valueListenable: plansNotifier,
                builder: (context, plans, child) {
                  if (plans.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.note, size: 100, color: Colors.grey),
                          SizedBox(height: 12),
                          Text('Anda belum memiliki rencana apapun.',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      final p = plans[index];
                      return Card(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        child: ListTile(
                          title: Text(p.name),
                          subtitle: Text(p.completenessMessage),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => PlanScreen(plan: p),
                            ));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}