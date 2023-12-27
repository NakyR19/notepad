import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    super.key,
    required this.cardHeight,
    required this.notes,
    required this.onTap,
    required this.onLongPress,
  });

  final double cardHeight;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Note notes;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: cardHeight * 0.65,
                child: Text(
                  notes.content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 9,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(
                height: cardHeight * 0.1,
                child: Text(
                  notes.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(
                height: cardHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.schedule),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      notes.date,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
