class TodoModel {
  String? id;
  String? title;
  String? createdAt;
  bool? isChecked;
  TodoModel({
    this.id,
    this.title,
    this.createdAt,
    this.isChecked,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'isChecked': isChecked,
    };
  }

  static TodoModel fromJson(Map<String, dynamic> jsonData) => TodoModel(
      id: jsonData['id'],
      title: jsonData['title'],
      createdAt: jsonData['createdAt'],
      isChecked: jsonData['isChecked']);

//! without it, will be showing  Instance of 'TodoModel
  @override
  String toString() {
    return '$title $isChecked';
  }
}
