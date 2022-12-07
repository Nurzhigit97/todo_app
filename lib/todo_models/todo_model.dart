class TodoModel {
  String id;
  String todo;
  String createdAt;
  bool isChecked;
  TodoModel({
    required this.id,
    required this.todo,
    required this.createdAt,
    required this.isChecked,
  });

//! without it, will be showing  Instance of 'TodoModel
  @override
  String toString() {
    return '${todo} ${isChecked}';
  }
}
