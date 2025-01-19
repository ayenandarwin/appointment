class User {
  final int? id;
  final String name;
  final String contact;
  final String description;

  User({this.id, required this.name, required this.contact, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'description': description,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
      description: map['description'],
    );
  }
}
