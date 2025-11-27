import 'package:flutter_bloc/flutter_bloc.dart';


class CalcDisplayCubit extends Cubit<bool> {

  CalcDisplayCubit() : super(true);
  

  void switchDisplay() {
    emit(!state);
  }
void deleteHistory() {
    if (state == false) {
      emit(true);
}
  }
}