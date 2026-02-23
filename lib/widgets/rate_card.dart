import 'package:flutter/material.dart';

class RateCard extends StatelessWidget {
  final String title;
  final String currencyCode;
  final double value;
  final double? previousValue; // Para mostrar tendencia
  final String flagEmoji;

  const RateCard({
    super.key,
    required this.title,
    required this.currencyCode,
    required this.value,
    this.previousValue,
    required this.flagEmoji,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUp = previousValue != null && value > previousValue!;
    final isDown = previousValue != null && value < previousValue!;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, val, _) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              // Icono de bandera con fondo circular
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(flagEmoji, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 16),

              // Info de la moneda
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                        fontSize: 13,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      currencyCode,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              // Valor con indicador de tendencia
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    val.toStringAsFixed(2),
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  if (previousValue != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isUp ? Icons.trending_up : Icons.trending_down,
                          size: 14,
                          color: isUp
                              ? const Color(0xFF00C853)
                              : const Color(0xFFFF1744),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${isUp ? '+' : ''}${((value - previousValue!) / previousValue! * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isUp
                                ? const Color(0xFF00C853)
                                : const Color(0xFFFF1744),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}