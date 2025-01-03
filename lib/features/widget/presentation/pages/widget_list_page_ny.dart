import 'package:flutter/material.dart';

class WidgetListPageNy extends StatelessWidget {
  final String artBoardId;

  const WidgetListPageNy({super.key, required this.artBoardId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget List'),
      ),
      body: Center(
        child: Text('WidgetListPageNy: ArtBoard ID = $artBoardId'),
      ),
    );
  }
}
