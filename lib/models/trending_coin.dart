class TrendingCoin {
  final String id;
  final String name;

  TrendingCoin({required this.id, required this.name});

  factory TrendingCoin.fromJson(Map<String, dynamic> json) {
    return TrendingCoin(
      id: json['id'],
      name: json['name'],
    );
  }

  // Map<String, dynamic> toJson() => {
  //   'id': id,
  //   'name': name,
  // };
}