import 'package:flutter/material.dart';
import 'carousel_flowdelegate.dart';
import 'filter_item.dart';
import 'dart:math' as math;

class FilterSelector extends StatelessWidget {
  final List<Color> filters;
  final ValueChanged<Color> onFilterChanged;

  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SizedBox(
      height: 100,
      child: NotificationListener<ScrollNotification>(
        onNotification: (_) => true,
        child: ListView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final color = filters[index];
            return FilterItem(
              color: color,
              onFilterSelected: () => onFilterChanged(color),
            );
          },
        ),
      ),
    );
  }
}