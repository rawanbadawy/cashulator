import 'package:cashulator/cubit/calc_history.cubit.dart';
import 'package:cashulator/models/calculator_history.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcHistoryWidget extends StatelessWidget {
  final  CalcHistoryCubit calcHistoryCubit;

const CalcHistoryWidget({ super.key,
required this.calcHistoryCubit});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<CalcHistoryCubit, List<CalculatorHistoryModel>>(
          bloc: calcHistoryCubit,
          builder: (context, state) {
            return ListView.separated(

              itemCount: state.length,
              itemBuilder: (context, index) {
            
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state[index].expression,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state[index].result,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            
              separatorBuilder: (context, index) => const Divider(),
            );
          },
        ),
      ),
    );  
  }
}

