class Item {
  final String id;
  final String title;
  final String subtitle;
  final String imagePath;

  const Item({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imagePath: json['imagePath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imagePath': imagePath,
    };
  }
}
