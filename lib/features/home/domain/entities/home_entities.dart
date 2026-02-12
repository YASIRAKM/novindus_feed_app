class Category {
  final int id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});
}

class Feed {
  final int id;

  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final User user;
  final String createdAt;

  Feed({
    required this.id,

    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.user,
    required this.createdAt,
  });
}

class User {
  final int id;
  final String name;
  final String image;

  User({required this.id, required this.name, required this.image});
}
