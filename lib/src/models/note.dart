class Note {
  final int? id;
  final String title;
  final String content;
  final String date;

  Note(
      {this.id,
      required this.title,
      required this.content,
      required this.date});

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date,
      };
}
