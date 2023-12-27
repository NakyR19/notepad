import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import '../utils/database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({this.note, super.key});

  final Note? note;

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String dateAt = DateFormat("dd/MM/yyyy").format(DateTime.now());

    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }

    save() async {
      final title = titleController.value.text;
      final content = contentController.value.text;

      if (title.isEmpty || content.isEmpty) {
        return;
      }

      final Note model = Note(
          title: title, content: content, id: widget.note?.id, date: dateAt);
      if (widget.note == null) {
        await DatabaseHelper.newNote(model);
      } else {
        await DatabaseHelper.updateNote(model);
      }
      Fluttertoast.showToast(
        msg: "Nota salva com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
        textColor: Theme.of(context).colorScheme.onBackground,
        fontSize: 16.0,
      );
    }

    final PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 5,
      centerTitle: true,
      title: Text(widget.note == null ? 'Nova nota' : 'Editar nota'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          save;
          Navigator.pop(context);
        },
      ),
    );
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar,
      body: noteModify(size, titleController, context, contentController),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          save();
          Navigator.popAndPushNamed(context, "/");
        },
        tooltip: 'Salvar',
        child: const Icon(Icons.save),
      ),
    );
  }

  SafeArea noteModify(Size size, TextEditingController titleController,
      BuildContext context, TextEditingController contentController) {
    return SafeArea(
      child: Container(
        height: size.height,
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {},
                  maxLength: 20,
                  maxLines: null,
                  autofocus: true,
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: "Título da nota",
                    labelText: 'Título',
                  ),
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {},
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Escreva sua nota...",
                  ),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
