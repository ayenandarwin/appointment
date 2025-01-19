class Appoint {
  final int? id;

  final String name;
  final String title;
  final String company;
  final String description;
  final String date;
  final String location;

  Appoint(
      {this.id,
      required this.name,
      required this.title,
      required this.description,
      required this.company,
      required this.date,
      required this.location,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'company': company,
      'description': description,
      'date': date,
      'location': location,
    };
  }

  static Appoint fromMap(Map<String, dynamic> map) {
    return Appoint(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      company: map['company'],
      description: map['description'],
      date: map['date'],
      location: map['location'],
    );
  }
}
