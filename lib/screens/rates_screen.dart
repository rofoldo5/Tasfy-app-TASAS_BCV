import 'package:flutter/material.dart';
import 'package:saxv1/widgets/rate_glass_card.dart';
import '../models/rates.dart';
import '../services/exchange_service.dart';
import '../widgets/rate_card.dart';



class RatesScreen extends StatefulWidget {
const RatesScreen({super.key});


@override
State<RatesScreen> createState() => _RatesScreenState();
}


class _RatesScreenState extends State<RatesScreen> {
late Future<ExchangeRate>  _ratesFuture;
final ExchangeService _service = ExchangeService();


@override
void initState() {
super.initState();
_ratesFuture = _service.getRates();
}


void _refresh() {
setState(() {
_ratesFuture = _service.getRates();
});
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Tasas de Cambio',
style: TextStyle(
fontWeight: FontWeight.w600,
letterSpacing: 1.2,),),

actions: [
IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh))
],
),
body: FutureBuilder <ExchangeRate> (
future: _ratesFuture,
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return const Center(child: CircularProgressIndicator());
}


if (snapshot.hasError) {
return Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
const Text('Error al obtener las tasas'),
const SizedBox(height: 12),
ElevatedButton(
onPressed: _refresh,
child: const Text('Reintentar'),
)
],
),
);
}


final rate = snapshot.data!;


debugPrint('USD: ${rate.usd}');
debugPrint('EUR: ${rate.eur}');
debugPrint('COP: ${rate.cop}');

return Padding(
padding: const EdgeInsets.all(16),
child: Column(
children: [
RateGlassCard(
  currency: 'Dólar BCV',
  value: rate.usd.toStringAsFixed(2),
),
RateGlassCard(
  currency: 'Euro BCV',
  value: rate.eur.toStringAsFixed(2),
),
RateGlassCard(
  currency: 'Bolívar → COP',
  value: rate.cop.toStringAsFixed(4),
),

const SizedBox(height: 20),
Text('Actualizado: ${rate.timestamp}')
],
),
);
},
),
);
}


Widget _rateCard(String title, double value, String suffix) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: value),
    duration: const Duration(milliseconds: 800),
    curve: Curves.easeOutCubic,
    builder: (context, val, _) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Text(
                val.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 4),
              Text(
                suffix,
                style: const TextStyle(
                  color: Color(0xFF8FAF9F),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}
