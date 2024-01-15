// ignore_for_file: public_member_api_docs, sort_constructors_first
class Todo {
  final String? id;
  final String title;
  final String description;
  final bool isDone;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        isDone = json['isDone'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'isDone': isDone,
      };
}
