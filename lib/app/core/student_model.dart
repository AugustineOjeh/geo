class Student {
  final String id;
  final String name;
  final String parentId;
  final int age;
  final DateTime createdAt;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.parentId,
    required this.createdAt,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      parentId: map['parent_id'],
      age: map['age'],
      name: map['first_name'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'parent_id': parentId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
