class TodoModel {
  String? id;
  String? title;
  String? createdAt;
  bool? isChecked;
  String? priority;
  TodoModel({
    this.id,
    this.title,
    this.createdAt,
    this.isChecked,
    this.priority,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'isChecked': isChecked,
      'priority': priority,
    };
  }

  static TodoModel fromJson(Map<String, dynamic> jsonData) => TodoModel(
      id: jsonData['id'],
      title: jsonData['title'],
      createdAt: jsonData['createdAt'],
      isChecked: jsonData['isChecked'],
      priority: jsonData['priority']);

//! without it, will be showing  Instance of 'TodoModel
  @override
  String toString() {
    return '$title $isChecked';
  }
}
