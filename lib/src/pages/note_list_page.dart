import 'package:flutter/material.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: [Text("Hello World")],
      ),
    );
  }
}
