class Game {
  final int id;
  final String name;
  final String category;
  final int year;
  final String developer;
  final String platform;
  final String image;
  final double rating;
  final String? description;

  const Game({
    required this.id,
    required this.name,
    required this.category,
    required this.year,
    required this.developer,
    required this.platform,
    required this.image,
    required this.rating,
    this.description,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      year: json['year'] as int,
      developer: json['developer'] as String,
      platform: json['platform'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String?,
    );
  }
}
