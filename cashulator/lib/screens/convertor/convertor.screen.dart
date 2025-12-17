import 'dart:async';

import 'package:cashulator/cubit/conv_display.cubit.dart';
import 'package:cashulator/cubit/exchange_rate/exchange_rate.cubit.dart';
import 'package:cashulator/cubit/exchange_rate/exchange_rate.state.dart';
import 'package:cashulator/widgets/convertorWidgets/convertor_keypad.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cashulator/widgets/convertorWidgets/convertorDisplay.widget.dart';

class ConvertorScreen extends StatefulWidget {
  const ConvertorScreen({super.key});

  @override
  State<ConvertorScreen> createState() => _ConvertorScreenState();
}

class _ConvertorScreenState extends State<ConvertorScreen> {
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final displayState = context.read<ConvDisplayCubit>().state;
      context.read<ExchangeRateCubit>().fetchExchangeRate(
            displayState.fromCurrency,
            displayState.toCurrency,
          );
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

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
          child: MultiBlocListener(
            listeners: [
              BlocListener<ConvDisplayCubit, ConvDisplayState>(
                listenWhen: (previous, current) =>
                    previous.fromAmount != current.fromAmount ||
                    previous.fromCurrency != current.fromCurrency ||
                    previous.toCurrency != current.toCurrency,
                listener: (context, displayState) {
                  _debounceTimer?.cancel();
                  _debounceTimer = Timer(const Duration(milliseconds: 500), () {
                    context.read<ExchangeRateCubit>().fetchExchangeRate(
                          displayState.fromCurrency,
                          displayState.toCurrency,
                        );
                  });
                },
              ),
              BlocListener<ExchangeRateCubit, ExchangeRateState?>(
                listener: (context, exchangeState) {
                  if (exchangeState is ExchangeRateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(exchangeState.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (exchangeState is ExchangeRateSuccess) {
                    context.read<ConvDisplayCubit>().convert(exchangeState.exchangeRateDto);
                  }
                },
              ),
            ],
            child: BlocBuilder<ConvDisplayCubit, ConvDisplayState>(
              builder: (context, displayState) {
                return BlocBuilder<ExchangeRateCubit, ExchangeRateState?>(
                  builder: (context, exchangeState) {
                    final isLoading = exchangeState is ExchangeRateLoading;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),

                        // Display with dropdowns + amounts
                        ConvertorDisplayWidget(
                          fromCurrency: displayState.fromCurrency,
                          toCurrency: displayState.toCurrency,
                          fromAmount: displayState.fromAmount,
                          toAmount: displayState.toAmount,
                          isLoading: isLoading,
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
                            onPressed: isLoading
                                ? null
                                : () {
                                    context.read<ExchangeRateCubit>().fetchExchangeRate(
                                          displayState.fromCurrency,
                                          displayState.toCurrency,
                                        );
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text('Convert', style: TextStyle(color: convertBtn)),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Container(height: 1, color: dividerColor),
                        const SizedBox(height: 10),

                        ConvertorKeypadWidget(
                          currentText: displayState.fromAmount,
                          convDisplayCubit: context.read<ConvDisplayCubit>(),
                        ),

                        const SizedBox(height: 12),
                      ],
                    );
                  },
                );
              },
            ),
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
