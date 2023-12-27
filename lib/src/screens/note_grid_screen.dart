import 'package:flutter/material.dart';
import '../models/note.dart';
import '../utils/database_helper.dart';
import '../widgets/note_card_widget.dart';
import 'note_details_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> notes = [];
  int notesLength = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Text("Anotações"),
      centerTitle: true,
      elevation: 5,
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final availableWidth = mediaQuery.size.width -
        mediaQuery.padding.right -
        mediaQuery.padding.top;

    final cardHeight = availableHeight * 0.35;

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder<List<Note>?>(
        future: DatabaseHelper.loadNotes(),
        builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ocorreu um erro!'));
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: availableWidth * 0.48,
                      mainAxisExtent: availableHeight * 0.35,
                      crossAxisSpacing: availableWidth * 0.05,
                      mainAxisSpacing: availableHeight * 0.005,
                    ),
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: NoteCardWidget(
                          cardHeight: cardHeight,
                          notes: snapshot.data![index],
                          onLongPress: () async {
                            myShowDialog(context, snapshot, index);
                          },
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteDetailsScreen(
                                          note: snapshot.data![index],
                                        )));
                            setState(() {});
                          },
                        ),
                      );
                    }),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Não há notas registradas, crie uma agora mesmo!',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteDetailsScreen()));
          setState(() {});
        },
        tooltip: 'Nova Nota',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> myShowDialog(
      BuildContext context, AsyncSnapshot<List<Note>?> snapshot, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Você tem certeza que quer deletar essa nota?',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () async {
                  await DatabaseHelper.deleteNote(snapshot.data![index]);
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text('Sim'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não'),
              ),
            ],
          );
        });
  }
}
