import 'package:flutter_bloc/flutter_bloc.dart';

class OperationCubit extends Cubit<String?> {
  OperationCubit() : super(null);

  void setOperation({required String operation}) {
    emit(operation);
  }

  void clear() {
    emit(null);
  }
}
