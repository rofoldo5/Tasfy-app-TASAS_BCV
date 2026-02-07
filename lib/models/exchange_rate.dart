import 'package:hive/hive.dart';

part 'exchange_rate.g.dart';

@HiveType(typeId: 0)
class ExchangeRate {
  @HiveField(0)
  final double usdToVes;

  @HiveField(1)
  final double eurToVes;

  @HiveField(2)
  final double vesToCop;

  @HiveField(3)
  final DateTime timestamp;

  ExchangeRate({
    required this.usdToVes,
    required this.eurToVes,
    required this.vesToCop,
    required this.timestamp,
  });
}
