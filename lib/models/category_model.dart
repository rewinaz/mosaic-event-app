class User {
  String categoryName, imageLink;
  bool isActive, isFeatured;
  DateTime dateCreated;

  User({
    required this.categoryName,
    required this.imageLink,
    required this.isActive,
    required this.isFeatured,
    required this.dateCreated,
  });
}
