import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final year = DateTime.now().year;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1117) : const Color(0xFFF8FAFC),
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo y nombre de la app
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Tasfy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Redes sociales
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: Icons.language_rounded,
                label: 'GitHub',
                isDark: isDark,
                theme: theme,
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: Icons.camera_alt_rounded,
                label: 'Instagram',
                isDark: isDark,
                theme: theme,
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: Icons.share_rounded,
                label: 'Twitter',
                isDark: isDark,
                theme: theme,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Línea divisoria
          Container(
            width: double.infinity,
            height: 1,
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.black.withOpacity(0.06),
          ),
          const SizedBox(height: 20),

          // Copyright
          Column(
            children: [
              Text(
                'Todos los derechos reservados © $year',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'All rights reserved © $year',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tasfy - Conversor de Tasas de Cambio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark
                      ? Colors.white.withOpacity(0.4)
                      : Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required bool isDark,
    required ThemeData theme,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isDark
                ? Colors.white.withOpacity(0.7)
                : Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}