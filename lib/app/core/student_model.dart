class Student {
  final String id;
  final String name;
  final String parentId;
  final int age;
  final bool questionsAnswered;
  final DateTime createdAt;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.parentId,
    required this.questionsAnswered,
    required this.createdAt,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      parentId: map['parent_id'],
      age: map['age'],
      name: map['name'],
      questionsAnswered: map['questions_answered'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'parent_id': parentId,
      'questions_answered': questionsAnswered,
      'created_at': createdAt.toIso8601String(),
    };
  }

  copyWith({
    String? id,
    String? name,
    int? age,
    String? parentId,
    bool? questionsAnswered,
    DateTime? createdAt,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      parentId: parentId ?? this.parentId,
      questionsAnswered: questionsAnswered ?? this.questionsAnswered,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Student(id: $id, name: $name, age: $age, parentId: $parentId, createdAt: $createdAt)';
  }
}
