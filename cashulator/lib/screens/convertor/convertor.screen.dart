import 'package:cashulator/cubit/conv_display.cubit.dart';
import 'package:cashulator/service/exchange_rate.service.dart';
import 'package:cashulator/widgets/convertorWidgets/convertor_keypad.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cashulator/widgets/convertorWidgets/convertorDisplay.widget.dart';

class ConvertorScreen extends StatelessWidget {
  const ConvertorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor =
        dark ? const Color(0xFF1E1E1E) : const Color(0xFFE6E6E6);
    final convertBtn = const Color(0xFF22C55E);

    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
            bottom: kBottomNavigationBarHeight +
                MediaQuery.of(context).viewPadding.bottom +
                16,
          ),
          child: BlocBuilder<ConvDisplayCubit, ConvDisplayState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),

                  // Display with dropdowns + amounts
                  ConvertorDisplayWidget(
                    fromCurrency: state.fromCurrency,
                    toCurrency: state.toCurrency,
                    fromAmount: state.fromAmount,
                    toAmount: state.toAmount,
                    onFromChanged: (val) {
                      if (val == null) return;
                      context.read<ConvDisplayCubit>().changeFromCurrency(val);
                    },
                    onToChanged: (val) {
                      if (val == null) return;
                      context.read<ConvDisplayCubit>().changeToCurrency(val);
                    },
                    onSwap: () {
                      context.read<ConvDisplayCubit>().swap();
                    },
                  ),

                  const SizedBox(height: 8),

                  
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dividerColor,
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: () async {
                        try {
                          final dto = await ExchangeRateService.getexchangeRate();
                          if (!context.mounted) return;
                          context.read<ConvDisplayCubit>().convert(dto);
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to load exchange rates'),
                            ),
                          );
                        }
                      },
                      child: Text('Convert', style: TextStyle(color: convertBtn)),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(height: 1, color: dividerColor),
                  const SizedBox(height: 10),

                 
                  ConvertorKeypadWidget(
                    currentText: state.fromAmount,
                    convDisplayCubit: context.read<ConvDisplayCubit>(),
                  ),

                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF22C55E),
        onTap: (i) {
          if (i == 1) {
            return;
          } else if (i == 0) {
            context.go('/');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: 'Calculate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Convert',
          ),
        ],
      ),
    );
  }
}
