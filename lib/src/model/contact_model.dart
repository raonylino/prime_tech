class Contact {
  final String name;
  final String? phone;
  final String? email;
  final bool isMain;

  Contact({required this.name, this.phone, this.email, required this.isMain});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      isMain: json['is_main'],
    );
  }
}
