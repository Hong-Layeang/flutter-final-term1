import 'restaurant_type.dart';

class RestaurantComment {
  final int stars;
  final String feedback;

  RestaurantComment({required this.stars, required this.feedback});
}

class Restaurant {
  final String name;
  final String address;
  final RestaurantType type;
  final List<RestaurantComment> comments;
 
  Restaurant({
    required this.name,
    required this.address,
    required this.type,
    List<RestaurantComment>? comments,
  }) : comments = comments ?? [];

  double get averageRate {
    if (comments.isEmpty) return 0.0;
    double sum = 0;
    for (var comment in comments) {
      sum += comment.stars;
    }
    return sum / comments.length;
  }

  void addComment(RestaurantComment comment) {
    comments.add(comment);
  }
}
