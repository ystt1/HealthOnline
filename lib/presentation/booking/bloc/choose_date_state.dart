class ChooseDateState{}

class ChooseDateLoading extends ChooseDateState{}

class ChooseDateLoaded extends ChooseDateState{
  final String month;



  ChooseDateLoaded({required this.month});

}
