import 'package:flutter/material.dart';
import 'package:saxv1/main.dart';
import '../services/exchange_service.dart';
import '../models/rates.dart';
import '../widgets/rate_card.dart';
import '../widgets/calculador_widget.dart';
import '../widgets/app_footer.dart';


class RatesScreen extends StatefulWidget {
  const RatesScreen({super.key});

  @override
  State<RatesScreen> createState() => _RatesScreenState();
}

class _RatesScreenState extends State<RatesScreen> {
  late Future<ExchangeRate> _ratesFuture;
  final _service = ExchangeService();
  DateTime? _lastUpdated;

  @override
  void initState() {
    super.initState();
    _ratesFuture = _fetchRates();
  }

  Future<ExchangeRate> _fetchRates() async {
    final rates = await _service.getRates();
    setState(() => _lastUpdated = DateTime.now());
    return rates;
  }

  Future<void> _refresh() async {
    setState(() {
      _ratesFuture = _fetchRates();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          color: theme.colorScheme.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Header personalizado (sin AppBar generico)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tasas de Cambio',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize: 28,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (_lastUpdated != null)
                            Text(
                              'Actualizado: ${_formatTime(_lastUpdated!)}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 13,
                                color: theme.colorScheme.onSurface.withOpacity(0.5),
                              ),
                            ),
                        ],
                      ),
                      // Toggle tema con estilo
                        GestureDetector(
                        onTap: () {
                          themeNotifier.value =
                              themeNotifier.value == ThemeMode.dark
                                  ? ThemeMode.light
                                  : ThemeMode.dark;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            themeNotifier.value == ThemeMode.dark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              // Contenido
              SliverToBoxAdapter(
                child: FutureBuilder<ExchangeRate>(
                  future: _ratesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildShimmerLoading(theme);
                    }

                    if (snapshot.hasError) {
                      return _buildErrorState(theme);
                    }

                    final rate = snapshot.data!;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              RateCard(
                                title: 'DOLAR BCV',
                                currencyCode: 'USD / VES',
                                value: rate.usd,
                                flagEmoji: '\u{1F1FA}\u{1F1F8}',
                              ),
                              const SizedBox(height: 12),
                              RateCard(
                                title: 'EURO BCV',
                                currencyCode: 'EUR / VES',
                                value: rate.eur,
                                flagEmoji: '\u{1F1EA}\u{1F1FA}',
                              ),
                              const SizedBox(height: 12),
                              RateCard(
                                title: 'BOLIVAR A PESO',
                                currencyCode: 'VES / COP',
                                value: rate.cop,
                                flagEmoji: '\u{1F1E8}\u{1F1F4}',
                              ),
                            ],
                          ),
                        ),
                        CalculatorWidget(
                          usdRate: rate.usd,
                          eurRate: rate.eur,
                          copRate: rate.cop,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              height: 88,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.wifi_off_rounded, size: 48,
              color: theme.colorScheme.error.withOpacity(0.6)),
          const SizedBox(height: 16),
          Text('No se pudieron cargar las tasas',
              style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Text('Verifica tu conexion e intenta de nuevo',
              style: theme.textTheme.titleMedium),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
