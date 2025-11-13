import 'package:flutter/material.dart';
import './views/plan_screen.dart';
import './models/data_layer.dart';
import './providers/plan_provider.dart';

void main() => runApp(const MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Plan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: PlanProvider(
        notifier: ValueNotifier<Plan>(const Plan(name: 'Rencana Utama')),
        child: const PlanScreen(),
      ),
    );
  }
}