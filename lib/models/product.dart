class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final String category;
  final double rating;
  final int reviewCount;
  final bool isInStock;
  final List<Review> reviews;
  
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.isInStock,
    required this.reviews,
  });
}

class Review {
  final String id;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;
  
  Review({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}