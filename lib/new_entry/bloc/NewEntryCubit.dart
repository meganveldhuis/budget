import 'package:flutter_bloc/flutter_bloc.dart';


class ToggleEntryCubit extends Cubit<bool>{
  final bool isIncome;
  ToggleEntryCubit(this.isIncome) : super(isIncome);
  void toggle() {
    emit(!state);
    print(state);
  }
}