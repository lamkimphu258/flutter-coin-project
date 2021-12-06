class Coin {
  final String name;
  final String symbol;
  final String image;
  final dynamic currentPrice;
  final dynamic marketCap;
  final dynamic marketCapRank;
  final dynamic fullyDilutedValuation;
  final dynamic totalVolume;
  final dynamic high24h;
  final dynamic low24h;
  final dynamic priceChange24h;
  final dynamic priceChangePercentage24h;
  final dynamic marketCapChange24h;
  final dynamic marketCapChangePercentage24h;
  final dynamic circulatingSupply;
  final dynamic totalSupply;
  final dynamic maxSupply;
  final dynamic ath;
  final dynamic athChangePercentage;
  final dynamic athDate;
  final dynamic atl;
  final dynamic atlChangePercentage;
  final dynamic atlDate;
  final dynamic roi;
  final dynamic lastUpdated;

  Coin({
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCapChange24h,
    required this.marketCapChangePercentage24h,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.lastUpdated,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.totalVolume,
    this.roi,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      image: json['image'],
      currentPrice: json['current_price'],
      marketCap: json['market_cap'],
      marketCapRank: json['market_cap_rank'],
      fullyDilutedValuation: json["fully_diluted_valuation"],
      totalVolume: json["total_volume"],
      high24h: json["high_24h"],
      low24h: json["low_24h"],
      priceChange24h: json["price_change_24h"],
      priceChangePercentage24h: json["price_change_percentage_24h"],
      marketCapChange24h: json["market_cap_change_24h"],
      marketCapChangePercentage24h: json["market_cap_change_percentage_24h"],
      circulatingSupply: json["circulating_supply"],
      totalSupply: json["total_supply"],
      maxSupply: json["max_supply"],
      ath: json["ath"],
      athChangePercentage: json["ath_change_percentage"],
      athDate: json["ath_date"],
      atl: json["atl"],
      atlChangePercentage: json["atl_change_percentage"],
      atlDate: json["atl_date"],
      roi: json["roi"],
      lastUpdated: json["last_updated"],
    );
  }
}
