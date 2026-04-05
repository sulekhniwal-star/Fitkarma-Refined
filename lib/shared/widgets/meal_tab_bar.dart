import 'package:flutter/material.dart';

class MealTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final List<String> tabs;

  const MealTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: tabs.length > 4,
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      labelColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
      indicatorColor: Theme.of(context).colorScheme.primary,
      onTap: onTabSelected,
      controller: null,
    );
  }
}

class MealTabController extends StatelessWidget {
  final List<String> tabs;
  final int initialIndex;
  final IndexedWidgetBuilder tabContent;
  final ValueChanged<int>? onTabChanged;

  const MealTabController({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    required this.tabContent,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: Column(
        children: [
          MealTabBar(
            selectedIndex: initialIndex,
            onTabSelected: onTabChanged ?? (_) {},
            tabs: tabs,
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(
                tabs.length,
                (index) => tabContent(context, index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}