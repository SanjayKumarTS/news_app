import 'package:flutter/material.dart';
import 'package:news_app/views/list_view.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: categories.map((String category) {
            return Tab(text: category.toUpperCase());
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: categories.map((String category) {
              return NewsScreen(category: category);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
