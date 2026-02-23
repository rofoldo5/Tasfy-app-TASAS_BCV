import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorWidget extends StatefulWidget {
  final double usdRate;
  final double eurRate;
  final double copRate;

  const CalculatorWidget({
    super.key,
    required this.usdRate,
    required this.eurRate,
    required this.copRate,
  });

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final _controller = TextEditingController();
  String _selectedFrom = 'USD';
  String _selectedTo = 'VES';
  double _result = 0.0;

  final List<String> _currencies = ['USD', 'EUR', 'VES', 'COP'];

  void _calculate() {
    final input = double.tryParse(_controller.text) ?? 0.0;
    double valueInVes;

    switch (_selectedFrom) {
      case 'USD':
        valueInVes = input * widget.usdRate;
        break;
      case 'EUR':
        valueInVes = input * widget.eurRate;
        break;
      case 'COP':
        valueInVes = input / widget.copRate;
        break;
      default:
        valueInVes = input;
    }

    switch (_selectedTo) {
      case 'USD':
        _result = valueInVes / widget.usdRate;
        break;
      case 'EUR':
        _result = valueInVes / widget.eurRate;
        break;
      case 'COP':
        _result = valueInVes * widget.copRate;
        break;
      default:
        _result = valueInVes;
    }

    setState(() {});
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _selectedFrom;
      _selectedFrom = _selectedTo;
      _selectedTo = temp;
      _calculate();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1D27) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.calculate_rounded,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Convertidor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            onChanged: (_) => _calculate(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: isDark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.15),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildCurrencyDropdown(
                    value: _selectedFrom,
                    label: 'De',
                    isDark: isDark,
                    onChanged: (val) {
                      setState(() {
                        _selectedFrom = val!;
                        _calculate();
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: _swapCurrencies,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.swap_horiz_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: _buildCurrencyDropdown(
                    value: _selectedTo,
                    label: 'A',
                    isDark: isDark,
                    onChanged: (val) {
                      setState(() {
                        _selectedTo = val!;
                        _calculate();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resultado',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _result.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                Text(
                  _selectedTo,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyDropdown({
    required String value,
    required String label,
    required bool isDark,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isDark
                ? Colors.white.withOpacity(0.4)
                : Colors.black.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 4),
        DropdownButton<String>(
          value: value,
          isExpanded: true,
          underline: const SizedBox(),
          dropdownColor: isDark ? const Color(0xFF1A1D27) : Colors.white,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
          ),
          items: _currencies.map((c) {
            return DropdownMenuItem(value: c, child: Text(c));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}