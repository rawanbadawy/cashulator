
import 'package:cashulator/cubit/calc_Display.cubit.dart';
import 'package:cashulator/cubit/calc_history.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsWidget extends StatelessWidget {
const OptionsWidget({ 
  super.key, 
required this.isCalc,
required this.calcDisplayCubit,
 required this.calcHistoryCubit,
 });
 final bool isCalc;
 final CalcDisplayCubit calcDisplayCubit;
 final CalcHistoryCubit calcHistoryCubit;
 
  @override
  Widget build(BuildContext context){
   final dark = Theme.of(context).brightness == Brightness.dark;
   final dividerColor = dark ? const Color(0xFF1E1E1E) : const Color(0xFFE6E6E6);
      
   
    return Column(
      children: [ Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                if (isCalc == true) ... [
                  BlocBuilder<CalcDisplayCubit, bool>(
                bloc: calcDisplayCubit,
                builder: (context, state) 
                  => 
                 GestureDetector(child: IconButton(icon: Icon(state ==true? Icons.history : Icons.calculate), iconSize: 20, onPressed: () { calcDisplayCubit.switchDisplay();}),) ,
                 ),
                SizedBox(width: 4),
                  
                Icon(Icons.superscript, size: 20),
                Spacer(),
                BlocBuilder<CalcDisplayCubit, bool>(
                bloc: calcDisplayCubit,
                builder: (context, state) 
                  => 
                 GestureDetector(child: IconButton(icon: Icon(state ==true? Icons.arrow_back : Icons.delete), iconSize: 20, onPressed: () =>state==true?{}: calcHistoryCubit.clearHistory()) ,) ,
                 ),

                ] else if (isCalc == false) ...[
                  Spacer(),
                  const Icon(Icons.arrow_back, size: 20),
                ]
          
                
              ],
            ),
    
          ),
          Container(height: 1, color: dividerColor),
          const SizedBox(height: 10),
    
      ],
    );
  }
}