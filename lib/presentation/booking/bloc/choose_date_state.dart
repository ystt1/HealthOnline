import 'package:health_online/domain/booking/entity/time_slot.dart';

abstract class ChooseDateState{
}
class ChooseDateInitialState extends ChooseDateState{

}
class ChooseDateLoading extends ChooseDateState{

}

class ChooseDateLoadSuccess extends ChooseDateState{
  final List<int> choseSlot;

  ChooseDateLoadSuccess({required this.choseSlot});
}

class ChooseDateLoadFailure extends ChooseDateState{
  final String errorMessage;

  ChooseDateLoadFailure({required this.errorMessage});
}
