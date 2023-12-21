import 'package:flutter/material.dart';
import 'package:news_app/views/list_view.dart';
// import 'package:news_app/widgets/cards_pager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, title = 'Insight Daily'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          // Flex factor if needed. 1 here means it takes all the space available.
          flex: 1,
          child:
              NewsScreen(), // No need for const if you expect the widget to change
        ),
      ],
    );
  }
}
