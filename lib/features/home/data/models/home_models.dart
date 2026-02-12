import '../../domain/entities/home_entities.dart';

class CategoryModel extends Category {
  CategoryModel({required super.id, required super.name, required super.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['title'] ?? 'Unknown',
      image: json['image'] != null
          ? (json['image'].toString().startsWith('http') ? json['image'] : '')
          : '',
    );
  }
}

class FeedModel extends Feed {
  FeedModel({
    required super.id,

    required super.description,
    required super.videoUrl,
    required super.thumbnailUrl,
    required super.user,
    required super.createdAt,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      id: json['id'] ?? 0,

      description: json['description'] ?? '',
      videoUrl: json['video'] != null
          ? (json['video'].toString().startsWith('http') ? json['video'] : '')
          : '',
      thumbnailUrl: json['image'] != null
          ? (json['image'].toString().startsWith('http') ? json['image'] : '')
          : '',
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : UserModel(
              id: 0,
              name: 'User',
              image: '',
            ),
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
    );
  }
}

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'User',
      image: json['image'] != null && json['image'].toString().isNotEmpty
          ? (json['image'].toString().startsWith('http') ? json['image'] : '')
          : '',
    );
  }
}
