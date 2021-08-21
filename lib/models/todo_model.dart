class Todo {
  final int id;
  final String title;
  final String description;
  final bool status;
  final String completedDate;
  final String date;
  final int userId;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.completedDate,
    required this.date,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as bool,
      completedDate: json['completedDate'] as String,
      date: json['date'] as String,
      userId: json['userId'] as int,
    );
  }
}
