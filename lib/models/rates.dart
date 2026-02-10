class ExchangeRate {
  final double usd;
  final double eur;
  final double cop;
  final DateTime timestamp;

  ExchangeRate({
    required this.usd,
    required this.eur,
    required this.cop,
    required this.timestamp,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      usd: (json['usd'] as num).toDouble(),
      eur: (json['eur'] as num).toDouble(),
      cop: (json['cop'] as num).toDouble(),
      timestamp: json['timestamp'],
    );
  }
}
