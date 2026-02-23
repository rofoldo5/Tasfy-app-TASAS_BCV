import 'dart:ui';
import 'package:flutter/material.dart';

class RateGlassCard extends StatelessWidget {
  final String currency;
  final String value;
  final String flagEmoji;

  const RateGlassCard({
    super.key,
    required this.currency,
    required this.value,
    this.flagEmoji = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
           decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
          color: theme.colorScheme.shadow.withOpacity(0.05),
          width: 1,
  ),
  boxShadow: [
    BoxShadow(
      color: theme.colorScheme.shadow.withOpacity(0.05),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ],
),
            child: Row(
              children: [
                if (flagEmoji.isNotEmpty)
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        flagEmoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                if (flagEmoji.isNotEmpty) const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    currency,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.6),
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}