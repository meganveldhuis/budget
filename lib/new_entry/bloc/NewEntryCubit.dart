import 'package:flutter_bloc/flutter_bloc.dart';


class ToggleEntryCubit extends Cubit<bool>{
  final bool isIncome;
  ToggleEntryCubit(this.isIncome) : super(isIncome);
  void toggle() {
    emit(!state);
    print(state);
  }
}

class DateEntryCubit extends Cubit<DateTime>{
  final DateTime chosenDate;
  DateEntryCubit(this.chosenDate) : super(chosenDate);

  void updateDate(chosenDate){
    emit(chosenDate);
  }
}

class ToggleTripCubit extends Cubit<bool>{
  final bool isTrip;
  ToggleTripCubit(this.isTrip) : super(isTrip);

  void toggle(){emit(!state);}
  // void togglet() => emit(!state);
}