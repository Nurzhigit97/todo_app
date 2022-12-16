class TodoModel {
  String? id;
  String? todo;
  String? createdAt;
  bool? isChecked;
  TodoModel({
    this.id,
    this.todo,
    this.createdAt,
    this.isChecked,
  });
  toJson() {
    return {
      'id': id,
      'todo': todo,
      'createdAt': createdAt,
      'isChecked': isChecked,
    };
  }

  fromJson(jsonData) {
    return TodoModel(
        id: jsonData['id'],
        todo: jsonData['todo'],
        createdAt: jsonData['createdAt'],
        isChecked: jsonData['isChecked']);
  }

//! without it, will be showing  Instance of 'TodoModel
  @override
  String toString() {
    return '$todo $isChecked';
  }
}
