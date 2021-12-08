class RecentCoin {
  final String image;
  final String name;
  final DateTime visitedAt;

  RecentCoin(
      {
      required this.image,
      required this.name,
      required this.visitedAt});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'visitedAt': visitedAt,
    };
  }

  @override
  String toString() {
    return 'Recent Coin{name: $name, image: $image, visitedAt: $visitedAt}';
  }
}
