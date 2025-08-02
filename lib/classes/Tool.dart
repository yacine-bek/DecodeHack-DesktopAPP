import 'package:uuid/uuid.dart';

class Tool {
  late String id;
  late String name;
  late String type;
  late String status;
  late String userID;

  Tool({
    required this.name,
    required this.type,
    required this.status,
    this.userID = '',
  }) {
    id = const Uuid().v4();
  }

  Tool.withId({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    this.userID = '',
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'status': status,
      'userID': userID,
    };
  }

  factory Tool.fromMap(Map<String, dynamic> map) {
    return Tool.withId(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      status: map['status'],
      userID: map['userID'] ?? '',
    );
  }
}
