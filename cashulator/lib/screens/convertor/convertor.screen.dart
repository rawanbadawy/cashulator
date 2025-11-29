import 'package:cashulator/cubit/calc_Display.cubit.dart';
import 'package:cashulator/cubit/calc_history.cubit.dart';
import 'package:cashulator/cubit/conv_display.cubit.dart';
import 'package:cashulator/widgets/convertorWidgets/convertor_keypad.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cashulator/widgets/convertorWidgets/convertorDisplay.widget.dart';
import 'package:cashulator/widgets/commonWidgets/options.widget.dart';

class ConvertorScreen extends StatefulWidget {
  const ConvertorScreen({super.key});

  @override
  State<ConvertorScreen> createState() => _ConvertorScreenState();
}

class _ConvertorScreenState extends State<ConvertorScreen> {
  late final ConvDisplayCubit convDisplayCubit;
  late final CalcDisplayCubit calcDisplayCubit;
  late final CalcHistoryCubit calcHistoryCubit;

  @override
  void initState() {
    super.initState();
    convDisplayCubit = ConvDisplayCubit();
    calcDisplayCubit = CalcDisplayCubit();
    calcHistoryCubit = CalcHistoryCubit();
  }

  @override
  void dispose() {
    convDisplayCubit.close();
    calcDisplayCubit.close();
    calcHistoryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor =
        dark ? const Color(0xFF1E1E1E) : const Color(0xFFE6E6E6);

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
            bloc: convDisplayCubit,
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
                      convDisplayCubit.changeFromCurrency(val);
                    },
                    onToChanged: (val) {
                      if (val == null) return;
                      convDisplayCubit.changeToCurrency(val);
                    },
                    onSwap: convDisplayCubit.swap,
                  ),

                  const SizedBox(height: 8),

                  const _ConvertorToolbar(),
                  Container(height: 1, color: dividerColor),
                  const SizedBox(height: 10),

                
                  // Keypad uses the cubit to change the amount
                  ConvertorKeypadWidget(
                    currentText: state.fromAmount,
                    convDisplayCubit: convDisplayCubit,
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

class _ConvertorToolbar extends StatelessWidget {
  const _ConvertorToolbar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: const [
          Icon(Icons.history, size: 20),
          SizedBox(width: 16),
          Icon(Icons.straighten, size: 20),
          SizedBox(width: 16),
          Icon(Icons.check_box_outlined, size: 20),
          Spacer(),
          Icon(Icons.open_in_full, size: 20),
        ],
      ),
    );
  }
}
