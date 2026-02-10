import 'dart:ui';
import 'package:flutter/material.dart';

class RateGlassCard extends StatelessWidget {
  final String currency;
  final String value;

  const RateGlassCard({
    super.key,
    required this.currency,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF00F5FF).withOpacity(0.6),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00F5FF).withOpacity(0.25),
                  blurRadius: 18,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              children: [
                Text(
                  currency,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF9CA3AF),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00F5FF),
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
