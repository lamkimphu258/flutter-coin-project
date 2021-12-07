class TrendingCoin {
  final String id;
  final String name;
  final String thumb;
  final dynamic marketCapRank;

  TrendingCoin(
      {required this.id,
      required this.name,
      required this.thumb,
      required this.marketCapRank});

  factory TrendingCoin.fromJson(Map<String, dynamic> json) {
    return TrendingCoin(
      id: json['id'],
      name: json['name'],
      thumb: json['large'],
      marketCapRank: json['market_cap_rank'],
    );
  }

// Map<String, dynamic> toJson() => {
//   'id': id,
//   'name': name,
// };
}
