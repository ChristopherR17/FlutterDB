class GameCategory {
  final int id;
  final String name;
  final String description;
  final String icon;

  const GameCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  factory GameCategory.fromJson(Map<String, dynamic> json) {
    return GameCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }
}
