class Lead {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String need;
  final String createdAt;

  Lead({required this.id, required this.name, required this.phone, required this.email, required this.need, required this.createdAt});

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        need: json['need'],
        createdAt: json['created_at'],
      );
}
