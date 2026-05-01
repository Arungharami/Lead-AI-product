class Lead {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String need;
  final String status;
  final DateTime createdAt;
  final String userId;

  Lead({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.need,
    required this.status,
    required this.createdAt,
    required this.userId,
  });

  factory Lead.fromMap(String id, Map<String, dynamic> map) => Lead(
        id: id,
        name: (map['name'] ?? '').toString(),
        phone: (map['phone'] ?? '').toString(),
        email: (map['email'] ?? '').toString(),
        need: (map['need'] ?? '').toString(),
        status: (map['status'] ?? 'new').toString(),
        createdAt: DateTime.tryParse((map['createdAt'] ?? '').toString()) ?? DateTime.now(),
        userId: (map['userId'] ?? '').toString(),
      );
}
