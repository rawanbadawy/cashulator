import 'package:flutter/material.dart';

class ConvertorDisplayWidget extends StatelessWidget {
  const ConvertorDisplayWidget({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromAmount,
    required this.toAmount,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onSwap,
  });

  final String fromCurrency;
  final String toCurrency;
  final String fromAmount;
  final String toAmount;
  final ValueChanged<String?> onFromChanged;
  final ValueChanged<String?> onToChanged;
  final VoidCallback onSwap;

  static const _currencies = <String>[
    'USD',
    'EUR',
    'EGP',
    'GBP',
    'JPY',
    'SAR',
    'AED',
  ];

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    final Color opBg =
        dark ? const Color(0xFF2A2A2A) : const Color(0xFFEFEFEF);
    final Color opFg = const Color(0xFF22C55E);

    const codeToLabel = {
      'USD': ' US Dollar',
      'EUR': ' Euro',
      'EGP': ' Egyptian Pound',
      'GBP': ' British Pound',
      'JPY': ' Yen',
      'SAR': ' Saudi Riyal',
      'AED': ' UAE Dirham',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: fromCurrency,
              decoration: InputDecoration(
                filled: true,
                fillColor: opBg,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: opBg,
              items: _currencies
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(codeToLabel[c] ?? c),
                    ),
                  )
                  .toList(),
              onChanged: onFromChanged,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                fromAmount,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // swap button
        SizedBox(
          width: 56,
          height: 56,
          child: ElevatedButton(
            onPressed: onSwap,
            style: ElevatedButton.styleFrom(
              backgroundColor: opBg,
              foregroundColor: opFg,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
            ),
            child: const Icon(Icons.swap_vert, size: 24),
          ),
        ),

        const SizedBox(height: 16),

      
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: toCurrency,
              decoration: InputDecoration(
                filled: true,
                fillColor: opBg,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: opBg,
              items: _currencies
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(codeToLabel[c] ?? c),
                    ),
                  )
                  .toList(),
              onChanged: onToChanged,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                toAmount,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
