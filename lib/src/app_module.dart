import 'package:flutter/material.dart';
import 'screens/note_grid_screen.dart';
import 'utils/color_schemes.dart';

class NotepadApp extends StatelessWidget {
  NotepadApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      routes: {
        "/": (context) => const NoteListScreen(),
      },
    );
  }
}
