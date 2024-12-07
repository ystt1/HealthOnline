import 'package:health_online/domain/history/entity/history_entity.dart';

abstract class GetHistoryState{}

class GetHistoryStateInitial extends GetHistoryState{}

class GetHistoryStateLoading extends GetHistoryState{}

class GetHistoryStateSuccess extends GetHistoryState{
  final List<HistoryEntity> histories;

  GetHistoryStateSuccess({required this.histories});
}

class GetHistoryStateFailure extends GetHistoryState{
  final String errorMsg;

  GetHistoryStateFailure({required this.errorMsg});
}
