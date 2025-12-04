import 'package:cashulator/cubit/calc_Display.cubit.dart';
import 'package:cashulator/cubit/calc_history.cubit.dart';
import 'package:cashulator/cubit/conv_display.cubit.dart';
import 'package:cashulator/service/network.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes.config.dart';
import 'cubit/first_operator.cubit.dart';
import 'cubit/second_operator.cubit.dart';
import 'cubit/operation.cubit.dart';
import 'cubit/calc.cubit.dart';

void main() {
  NetworkClientService.init();
  runApp(const CashulatorApp());
}

class CashulatorApp extends StatelessWidget {
  const CashulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FirstOperatorCubit()),
        BlocProvider(create: (_) => SecondOperatorCubit()),
        BlocProvider(create: (_) => OperationCubit()),
        BlocProvider(create: (_) => CalcCubit()),
        BlocProvider(create: (_) => CalcHistoryCubit()),
        BlocProvider(create: (_) => CalcDisplayCubit()),
        BlocProvider(create: (_) => ConvDisplayCubit()),
      ],
      
      child: MaterialApp.router(
        title: 'Cashulator',
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xFF1F7ACF)),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1F7ACF),
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
